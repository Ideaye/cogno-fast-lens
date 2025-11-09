import { useState, useEffect, useRef } from "react";
import { supabase } from "@/integrations/supabase/client";
import { getOrCreateDeviceId } from "@/lib/deviceId";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { toast } from "sonner";
import ReactMarkdown from "react-markdown";
import type { Course, Question, FastMethod, Attempt, QuestionOption } from "@/types/database";
import { CheckCircle2, XCircle, SkipForward, RotateCcw, Zap } from "lucide-react";

export default function Practice() {
  const [courses, setCourses] = useState<Course[]>([]);
  const [selectedCourseId, setSelectedCourseId] = useState<string>("");
  const [currentQuestion, setCurrentQuestion] = useState<Question | null>(null);
  const [fastMethod, setFastMethod] = useState<FastMethod | null>(null);
  const [selectedAnswer, setSelectedAnswer] = useState<string>("");
  const [showResult, setShowResult] = useState(false);
  const [isCorrect, setIsCorrect] = useState(false);
  const [sessionAttempts, setSessionAttempts] = useState<Attempt[]>([]);
  
  const startTimeRef = useRef<number>(0);
  const firstActionTimeRef = useRef<number | null>(null);
  const deviceId = getOrCreateDeviceId();

  useEffect(() => {
    loadCourses();
  }, []);

  useEffect(() => {
    if (selectedCourseId) {
      loadNextQuestion();
    }
  }, [selectedCourseId]);

  async function loadCourses() {
    const { data, error } = await supabase
      .from('courses')
      .select('*')
      .eq('is_public', true)
      .order('grade');
    
    if (error) {
      toast.error("Failed to load courses");
      return;
    }
    
    setCourses(data || []);
    if (data && data.length > 0) {
      setSelectedCourseId(data[0].id);
    }
  }

  async function loadNextQuestion() {
    if (!selectedCourseId) return;

    // Simple adaptive selector
    const recentAttempts = sessionAttempts.slice(-10);
    const wrongConcepts = recentAttempts
      .filter(a => !a.correct)
      .map(a => a.question_id);
    
    const lastThreeIds = sessionAttempts.slice(-3).map(a => a.question_id);

    const { data: questions, error } = await supabase
      .from('questions')
      .select('*')
      .eq('course_id', selectedCourseId);

    if (error || !questions || questions.length === 0) {
      toast.error("No questions available");
      return;
    }

    // Filter out last 3
    let availableQuestions = questions.filter(q => !lastThreeIds.includes(q.id));
    
    if (availableQuestions.length === 0) {
      availableQuestions = questions;
    }

    // Pick random from available
    const randomQuestion = availableQuestions[Math.floor(Math.random() * availableQuestions.length)];
    
    setCurrentQuestion({
      ...randomQuestion,
      type: randomQuestion.type as 'MCQ' | 'FR',
      options: randomQuestion.options as unknown as QuestionOption[] | null,
    } as Question);
    setSelectedAnswer("");
    setShowResult(false);
    setFastMethod(null);
    startTimeRef.current = Date.now();
    firstActionTimeRef.current = null;
  }

  function handleFirstAction() {
    if (firstActionTimeRef.current === null) {
      firstActionTimeRef.current = Date.now() - startTimeRef.current;
    }
  }

  async function handleSubmit() {
    if (!currentQuestion || !selectedAnswer) {
      toast.error("Please select an answer");
      return;
    }

    handleFirstAction();
    
    const timeTaken = Date.now() - startTimeRef.current;
    const correct = selectedAnswer === currentQuestion.correct_key;
    
    setIsCorrect(correct);
    setShowResult(true);

    // Save attempt
    const { data, error } = await supabase
      .from('attempts')
      .insert({
        device_id: deviceId,
        course_id: selectedCourseId,
        question_id: currentQuestion.id,
        selected_key: selectedAnswer,
        correct,
        time_taken_ms: timeTaken,
        time_to_first_action_ms: firstActionTimeRef.current,
        skipped: false,
      })
      .select()
      .single();

    if (!error && data) {
      setSessionAttempts(prev => [...prev, data as Attempt]);
    }

    // Load fast method
    const { data: fmData } = await supabase
      .from('fast_methods')
      .select('*')
      .eq('question_id', currentQuestion.id)
      .single();

    setFastMethod(fmData);

    toast[correct ? "success" : "error"](correct ? "Correct!" : "Incorrect");
  }

  async function handleSkip() {
    if (!currentQuestion) return;

    handleFirstAction();
    
    const timeTaken = Date.now() - startTimeRef.current;

    const { data, error } = await supabase
      .from('attempts')
      .insert({
        device_id: deviceId,
        course_id: selectedCourseId,
        question_id: currentQuestion.id,
        correct: null,
        time_taken_ms: timeTaken,
        time_to_first_action_ms: firstActionTimeRef.current,
        skipped: true,
      })
      .select()
      .single();

    if (!error && data) {
      setSessionAttempts(prev => [...prev, data as Attempt]);
    }

    loadNextQuestion();
    toast.info("Question skipped");
  }

  function handleReset() {
    setSessionAttempts([]);
    loadNextQuestion();
    toast.success("Session reset");
  }

  const sessionStats = {
    answered: sessionAttempts.filter(a => !a.skipped).length,
    accuracy: sessionAttempts.filter(a => !a.skipped).length > 0
      ? (sessionAttempts.filter(a => a.correct).length / sessionAttempts.filter(a => !a.skipped).length * 100).toFixed(1)
      : "0.0",
    avgTime: sessionAttempts.length > 0
      ? (sessionAttempts.reduce((sum, a) => sum + a.time_taken_ms, 0) / sessionAttempts.length / 1000).toFixed(1)
      : "0.0",
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <div className="border-b border-border bg-card">
        <div className="container mx-auto px-4 py-4">
          <div className="flex flex-wrap items-center justify-between gap-4">
            <div className="flex items-center gap-4">
              <h1 className="text-2xl font-bold flex items-center gap-2">
                <Zap className="text-primary" />
                FastLens Practice
              </h1>
              <Select value={selectedCourseId} onValueChange={setSelectedCourseId}>
                <SelectTrigger className="w-[240px]">
                  <SelectValue placeholder="Select course" />
                </SelectTrigger>
                <SelectContent>
                  {courses.map(course => (
                    <SelectItem key={course.id} value={course.id}>
                      {course.title}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            
            <div className="flex items-center gap-6 text-sm">
              <div>
                <span className="text-muted-foreground">Answered: </span>
                <span className="font-semibold">{sessionStats.answered}</span>
              </div>
              <div>
                <span className="text-muted-foreground">Accuracy: </span>
                <span className="font-semibold">{sessionStats.accuracy}%</span>
              </div>
              <div>
                <span className="text-muted-foreground">Avg Time: </span>
                <span className="font-semibold">{sessionStats.avgTime}s</span>
              </div>
              <Button variant="outline" size="sm" onClick={handleReset}>
                <RotateCcw className="w-4 h-4 mr-2" />
                Reset
              </Button>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="container mx-auto px-4 py-8 max-w-3xl">
        {currentQuestion ? (
          <div className="space-y-6">
            {/* Question Card */}
            <Card className="p-6">
              <div className="prose prose-sm max-w-none mb-6">
                <ReactMarkdown>{currentQuestion.stem_md}</ReactMarkdown>
              </div>

              {currentQuestion.type === 'MCQ' && currentQuestion.options && !showResult && (
                <RadioGroup
                  value={selectedAnswer}
                  onValueChange={(val) => {
                    handleFirstAction();
                    setSelectedAnswer(val);
                  }}
                >
                  <div className="space-y-3">
                    {currentQuestion.options.map((option) => (
                      <div key={option.key} className="flex items-center space-x-2">
                        <RadioGroupItem value={option.key} id={option.key} />
                        <Label
                          htmlFor={option.key}
                          className="flex-1 cursor-pointer p-3 rounded border border-border hover:bg-muted transition-colors"
                        >
                          <span className="font-semibold mr-2">{option.key}.</span>
                          {option.text}
                        </Label>
                      </div>
                    ))}
                  </div>
                </RadioGroup>
              )}

              {!showResult && (
                <div className="flex gap-3 mt-6">
                  <Button onClick={handleSubmit} className="flex-1">
                    Submit
                  </Button>
                  <Button onClick={handleSkip} variant="outline">
                    <SkipForward className="w-4 h-4 mr-2" />
                    Skip
                  </Button>
                </div>
              )}
            </Card>

            {/* Result & FastLens Card */}
            {showResult && (
              <>
                <Card className={`p-6 border-2 ${isCorrect ? 'border-green-500 bg-green-50' : 'border-red-500 bg-red-50'}`}>
                  <div className="flex items-center gap-3 mb-2">
                    {isCorrect ? (
                      <CheckCircle2 className="w-6 h-6 text-green-600" />
                    ) : (
                      <XCircle className="w-6 h-6 text-red-600" />
                    )}
                    <h3 className="text-xl font-bold">
                      {isCorrect ? "Correct!" : "Incorrect"}
                    </h3>
                  </div>
                  <p className="text-sm">
                    Correct answer: <span className="font-semibold">{currentQuestion.correct_key}</span>
                  </p>
                </Card>

                {fastMethod ? (
                  <Card className="p-6 bg-primary/5 border-primary">
                    <div className="flex items-center gap-2 mb-4">
                      <Zap className="w-6 h-6 text-primary" />
                      <h3 className="text-xl font-bold">FastLens: The Fastest Way</h3>
                    </div>

                    <div className="space-y-4">
                      <div>
                        <h4 className="font-semibold mb-2">Quick Justification</h4>
                        <div className="prose prose-sm max-w-none">
                          <ReactMarkdown>{fastMethod.short_justification_md}</ReactMarkdown>
                        </div>
                      </div>

                      <div>
                        <h4 className="font-semibold mb-2">Fast Steps</h4>
                        <div className="prose prose-sm max-w-none">
                          <ReactMarkdown>{fastMethod.fast_steps_md}</ReactMarkdown>
                        </div>
                      </div>

                      {fastMethod.why_others_wrong_md && (
                        <div>
                          <h4 className="font-semibold mb-2">Why Other Options Are Wrong</h4>
                          <div className="prose prose-sm max-w-none">
                            <ReactMarkdown>{fastMethod.why_others_wrong_md}</ReactMarkdown>
                          </div>
                        </div>
                      )}

                      {fastMethod.checks_notes_md && (
                        <div>
                          <h4 className="font-semibold mb-2">Checks & Units</h4>
                          <div className="prose prose-sm max-w-none">
                            <ReactMarkdown>{fastMethod.checks_notes_md}</ReactMarkdown>
                          </div>
                        </div>
                      )}
                    </div>
                  </Card>
                ) : (
                  <Card className="p-6 bg-muted">
                    <p className="text-center text-muted-foreground">
                      No safe shortcut—use the standard method.
                    </p>
                    <Button variant="outline" size="sm" className="mt-4 mx-auto block">
                      Report missing shortcut
                    </Button>
                  </Card>
                )}

                <Button onClick={loadNextQuestion} className="w-full" size="lg">
                  Next Question
                </Button>
              </>
            )}
          </div>
        ) : (
          <Card className="p-12 text-center">
            <p className="text-muted-foreground">Loading question...</p>
          </Card>
        )}
      </div>
    </div>
  );
}
