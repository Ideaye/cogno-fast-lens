package com.cognopath.fastlens.domain.model

data class Attempt(
  val questionId: String,
  val isCorrect: Boolean,
  val timeMs: Int,
  val firstActionMs: Int?
)