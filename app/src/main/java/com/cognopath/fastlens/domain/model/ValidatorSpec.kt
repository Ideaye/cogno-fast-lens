package com.cognopath.fastlens.domain.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
sealed class ValidatorSpec {
  @Serializable
  @SerialName("percentage_exact")
  data class PercentageExact(val p: Double, val base: Double, val rounding: String = "exact") : ValidatorSpec()

  @Serializable
  @SerialName("ratio_identity")
  data class RatioIdentity(val a: Double, val b: Double, val transform: String = "scale") : ValidatorSpec()

  @Serializable
  @SerialName("si_exact")
  data class SiExact(val P: Double, val r: Double, val t: Double) : ValidatorSpec()

  @Serializable
  @SerialName("ci_exact")
  data class CiExact(val P: Double, val r: Double, val t: Double, val m: Int = 1, val tolerance: Double = 1e-6) : ValidatorSpec()
}