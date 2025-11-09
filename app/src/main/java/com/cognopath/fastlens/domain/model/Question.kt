package com.cognopath.fastlens.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Question(
  val id: String,
  val courseId: String,
  val subTopic: String,
  val text: String,
  val options: List<String>,
  val correctIndex: Int,
  val conceptTags: List<String> = emptyList(),
  val fastMethod: FastMethod?,
  val validator: ValidatorSpec
)