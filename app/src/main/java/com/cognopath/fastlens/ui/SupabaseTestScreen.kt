package com.cognopath.fastlens.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import com.cognopath.fastlens.data.repository.SupabaseRepository
import com.cognopath.fastlens.domain.model.Attempt
import kotlinx.coroutines.launch

@Composable
fun SupabaseTestScreen() {
    val repository = SupabaseRepository()
    val scope = rememberCoroutineScope()

    Column {
        Button(onClick = {
            scope.launch {
                val testAttempt = Attempt(
                    questionId = "test_question_id",
                    isCorrect = true,
                    timeMs = 1000,
                    firstActionMs = 500
                )
                repository.logAttempt(testAttempt)
            }
        }) {
            Text("Log Test Attempt")
        }

        Button(onClick = {
            scope.launch {
                // This is a placeholder for fetching and displaying attempts.
                // You would typically have a ViewModel and State management for this.
                val attempts = repository.getQuestions("qa_speed")
                println(attempts)
            }
        }) {
            Text("Fetch Attempts")
        }
    }
}