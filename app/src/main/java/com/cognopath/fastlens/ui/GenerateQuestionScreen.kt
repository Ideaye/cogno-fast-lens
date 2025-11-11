package com.cognopath.fastlens.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import com.cognopath.fastlens.data.repository.SupabaseRepository
import com.cognopath.fastlens.domain.model.Question
import kotlinx.coroutines.launch

@Composable
fun GenerateQuestionScreen() {
    val repository = SupabaseRepository()
    val scope = rememberCoroutineScope()
    var generatedQuestion by remember { mutableStateOf<Question?>(null) }

    Column {
        Button(onClick = {
            scope.launch {
                generatedQuestion = repository.generateQuestion("percentages")
            }
        }) {
            Text("Generate New Percentage Question")
        }

        generatedQuestion?.let {
            Text("Generated Question: ${it.text}")
        }
    }
}