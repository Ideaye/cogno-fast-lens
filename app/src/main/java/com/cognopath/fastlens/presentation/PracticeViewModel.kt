package com.cognopath.fastlens.presentation

import android.app.Application
import android.util.Log
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.cognopath.fastlens.data.local.AppDatabase
import com.cognopath.fastlens.data.local.QuestionAssetDataSource
import com.cognopath.fastlens.data.repository.PracticeRepository
import com.cognopath.fastlens.domain.logic.isFastMethodSafe
import com.cognopath.fastlens.domain.logic.nextQuestion
import com.cognopath.fastlens.domain.model.Attempt
import com.cognopath.fastlens.domain.model.Question
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class PracticeViewModel(application: Application) : AndroidViewModel(application) {

    private val _uiState = MutableStateFlow(PracticeUiState())
    val uiState: StateFlow<PracticeUiState> = _uiState.asStateFlow()

    private val repository: PracticeRepository
    private var questionPool: List<Question> = emptyList()
    private var sessionStartTime: Long = 0L
    private var questionStartTime: Long = 0L

    init {
        val db = AppDatabase.getDatabase(application)
        val dataSource = QuestionAssetDataSource(application)
        repository = PracticeRepository(dataSource, db.attemptDao())
        loadContent()
    }

    private fun loadContent() {
        viewModelScope.launch {
            questionPool = repository.loadQuestions()
            Log.d("PracticeViewModel", "practice_session_started")
            sessionStartTime = System.currentTimeMillis()
            loadNextQuestion()
        }
    }

    fun onOptionSelected(index: Int) {
        if (_uiState.value.timeToFirstActionMs == null) {
            _uiState.update { it.copy(timeToFirstActionMs = (System.currentTimeMillis() - questionStartTime).toInt()) }
        }
        _uiState.update { it.copy(selectedIndex = index) }
    }

    fun submitAnswer() {
        val currentState = _uiState.value
        val question = currentState.currentQuestion ?: return
        val selectedIndex = currentState.selectedIndex ?: return

        _uiState.update { it.copy(isSubmitting = true) }

        val isCorrect = selectedIndex == question.correctIndex
        val timeMs = (System.currentTimeMillis() - questionStartTime).toInt()

        val attempt = Attempt(
            questionId = question.id,
            isCorrect = isCorrect,
            timeMs = timeMs,
            firstActionMs = currentState.timeToFirstActionMs
        )

        viewModelScope.launch {
            repository.saveAttempt(attempt)
            Log.d("PracticeViewModel", "question_attempted: id=${question.id}, correct=$isCorrect, timeMs=$timeMs, firstActionMs=${currentState.timeToFirstActionMs}, subTopic=${question.subTopic}")

            val isSafe = question.fastMethod != null && isFastMethodSafe(question.validator, question.options[question.correctIndex])

            if(isSafe) {
                Log.d("PracticeViewModel", "fastlens_shown: hasShortcut=true")
            } else {
                Log.d("PracticeViewModel", "fastlens_shown: hasShortcut=false")
            }

            val history = repository.getRecentAttempts(50)
            val totalAttempts = uiState.value.questionCount + 1
            val correctAttempts = uiState.value.correctCount + if (isCorrect) 1 else 0
            val totalTime = (uiState.value.avgTimeMs * uiState.value.questionCount) + timeMs

            _uiState.update {
                it.copy(
                    isSubmitting = false,
                    showResult = true,
                    isCorrect = isCorrect,
                    fastLens = if (isSafe) question.fastMethod else null,
                    showNoSafeShortcut = !isSafe,
                    questionCount = totalAttempts,
                    correctCount = correctAttempts,
                    avgTimeMs = totalTime / totalAttempts
                )
            }
        }
    }

    fun loadNextQuestion() {
        viewModelScope.launch {
            val history = repository.getRecentAttempts(50)
            val next = nextQuestion(_uiState.value.currentQuestion?.id, history, questionPool)
            if (next != null) {
                _uiState.update {
                    PracticeUiState(
                        currentQuestion = next,
                        options = next.options,
                        questionCount = it.questionCount,
                        correctCount = it.correctCount,
                        avgTimeMs = it.avgTimeMs
                    )
                }
                questionStartTime = System.currentTimeMillis()
            } else {
                // Handle end of practice session
            }
        }
    }
}
