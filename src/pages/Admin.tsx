import { useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";
import { supabase } from "@/integrations/supabase/client";
import { Button } from "@/components/ui/button";
import { Card } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { toast } from "sonner";

const ADMIN_SECRET = import.meta.env.VITE_ADMIN_SECRET;

export default function Admin() {
  const [searchParams] = useSearchParams();
  const [isAuthorized, setIsAuthorized] = useState(false);
  const [configError, setConfigError] = useState<string | null>(null);

  useEffect(() => {
    if (!ADMIN_SECRET) {
      setConfigError("Admin secret is not configured. Set VITE_ADMIN_SECRET to enable access.");
      return;
    }

    const secret = searchParams.get("secret");
    if (secret === ADMIN_SECRET) {
      setIsAuthorized(true);
    }
  }, [searchParams]);

  async function seedDemoData() {
    toast.info("Seeding demo data...");
    
    // Generate 50 synthetic attempts
    const { data: questions } = await supabase
      .from('questions')
      .select('id, course_id')
      .limit(10);

    if (!questions || questions.length === 0) {
      toast.error("No questions to seed attempts for");
      return;
    }

    const deviceIds = ['device-1', 'device-2', 'device-3'];
    const attempts = [];

    for (let i = 0; i < 50; i++) {
      const q = questions[Math.floor(Math.random() * questions.length)];
      const correct = Math.random() > 0.3;
      
      attempts.push({
        device_id: deviceIds[Math.floor(Math.random() * deviceIds.length)],
        course_id: q.course_id,
        question_id: q.id,
        selected_key: correct ? 'A' : 'B',
        correct,
        time_taken_ms: Math.floor(30000 + Math.random() * 90000),
        time_to_first_action_ms: Math.floor(2000 + Math.random() * 8000),
        skipped: false,
      });
    }

    const { error } = await supabase.from('attempts').insert(attempts);

    if (error) {
      toast.error("Failed to seed data");
    } else {
      toast.success("Demo data seeded successfully!");
    }
  }

  if (configError) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Card className="p-8 max-w-md w-full text-center">
          <h1 className="text-2xl font-bold mb-4">Admin Disabled</h1>
          <p className="text-muted-foreground text-sm">{configError}</p>
        </Card>
      </div>
    );
  }

  if (!isAuthorized) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <Card className="p-8 max-w-md w-full text-center">
          <h1 className="text-2xl font-bold mb-4">Unauthorized</h1>
          <p className="text-muted-foreground">
            Access to admin panel requires authentication.
          </p>
          <p className="text-sm text-muted-foreground mt-4">
            Add <code className="bg-muted px-2 py-1 rounded">?secret=ADMIN_SECRET</code> to URL
          </p>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <h1 className="text-3xl font-bold mb-8">Admin Panel</h1>

        <Tabs defaultValue="seed" className="space-y-6">
          <TabsList>
            <TabsTrigger value="seed">Seed Data</TabsTrigger>
            <TabsTrigger value="courses">Courses</TabsTrigger>
            <TabsTrigger value="questions">Questions</TabsTrigger>
            <TabsTrigger value="methods">Fast Methods</TabsTrigger>
          </TabsList>

          <TabsContent value="seed">
            <Card className="p-6">
              <h2 className="text-xl font-bold mb-4">Seed Demo Data</h2>
              <p className="text-muted-foreground mb-6">
                Generate 50 synthetic attempts to visualize stats and test the system.
              </p>
              <Button onClick={seedDemoData}>
                Seed Demo Data
              </Button>
            </Card>
          </TabsContent>

          <TabsContent value="courses">
            <Card className="p-6">
              <h2 className="text-xl font-bold mb-4">Manage Courses</h2>
              <p className="text-muted-foreground">
                Course management interface coming soon.
              </p>
            </Card>
          </TabsContent>

          <TabsContent value="questions">
            <Card className="p-6">
              <h2 className="text-xl font-bold mb-4">Manage Questions</h2>
              <p className="text-muted-foreground">
                Question management interface coming soon.
              </p>
            </Card>
          </TabsContent>

          <TabsContent value="methods">
            <Card className="p-6">
              <h2 className="text-xl font-bold mb-4">Manage Fast Methods</h2>
              <p className="text-muted-foreground">
                Fast method management interface coming soon.
              </p>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
