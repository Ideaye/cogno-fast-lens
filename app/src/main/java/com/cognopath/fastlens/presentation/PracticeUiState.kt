package com.cognopath.fastlens.presentation

import com.cognopath.fastlens.domain.model.FastMethod
import com.cognopath.fastlens.domain.model.Question

data class PracticeUiState(
    val currentQuestion: Question? = null,
    val options: List<String> = emptyList(),
    val selectedIndex: Int? = null,
    val showResult: Boolean = false,
    val isCorrect: Boolean? = null,
    val fastLens: FastMethod? = null,
    val showNoSafeShortcut: Boolean = false,
    val questionCount: Int = 0,
    val correctCount: Int = 0,
    val avgTimeMs: Int = 0,
    val isSubmitting: Boolean = false,
    val timeToFirstActionMs: Int? = null
)