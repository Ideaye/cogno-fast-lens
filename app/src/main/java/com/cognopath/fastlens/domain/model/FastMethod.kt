package com.cognopath.fastlens.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class FastMethod(
  val title: String,
  val justificationMd: String,
  val pitfallMd: String
)