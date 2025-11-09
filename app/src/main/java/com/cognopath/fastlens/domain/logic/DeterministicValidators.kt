package com.cognopath.fastlens.domain.logic

import com.cognopath.fastlens.domain.model.ValidatorSpec
import java.math.BigDecimal
import java.math.RoundingMode

fun isFastMethodSafe(validator: ValidatorSpec, correctOption: String): Boolean {
    return when (validator) {
        is ValidatorSpec.PercentageExact -> validatePercentageExact(validator, correctOption)
        is ValidatorSpec.RatioIdentity -> validateRatioIdentity(validator, correctOption)
        is ValidatorSpec.SiExact -> validateSiExact(validator, correctOption)
        is ValidatorSpec.CiExact -> validateCiExact(validator, correctOption)
    }
}

private fun validatePercentageExact(spec: ValidatorSpec.PercentageExact, shownCorrect: String): Boolean {
    val p = BigDecimal(spec.p.toString())
    val base = BigDecimal(spec.base.toString())
    val result = p.divide(BigDecimal(100)).multiply(base)

    val roundedResult = when (spec.rounding) {
        "exact" -> result
        "nearest_1" -> result.setScale(0, RoundingMode.HALF_UP)
        "nearest_0.1" -> result.setScale(1, RoundingMode.HALF_UP)
        else -> result
    }

    return roundedResult.toPlainString() == shownCorrect
}

private fun validateRatioIdentity(spec: ValidatorSpec.RatioIdentity, shownCorrect: String): Boolean {
    // This is a simplified example. A real implementation would need a more robust way
    // to handle different ratio transformations.
    if (spec.transform == "scale") {
        val a = BigDecimal(spec.a.toString())
        val b = BigDecimal(spec.b.toString())
        val gcd = a.toBigInteger().gcd(b.toBigInteger())
        val simplifiedRatio = "${a.divide(BigDecimal(gcd))}:${b.divide(BigDecimal(gcd))}"
        return simplifiedRatio == shownCorrect
    }
    return false
}

private fun validateSiExact(spec: ValidatorSpec.SiExact, shownCorrect: String): Boolean {
    val P = BigDecimal(spec.P.toString())
    val r = BigDecimal(spec.r.toString())
    val t = BigDecimal(spec.t.toString())
    val interest = P.multiply(r).multiply(t)
    return interest.compareTo(BigDecimal(shownCorrect)) == 0
}

private fun validateCiExact(spec: ValidatorSpec.CiExact, shownCorrect: String): Boolean {
    val P = BigDecimal(spec.P.toString())
    val r = BigDecimal(spec.r.toString())
    val t = BigDecimal(spec.t.toString())
    val m = BigDecimal(spec.m.toString())

    val base = BigDecimal.ONE.add(r.divide(m, 10, RoundingMode.HALF_UP))
    val exponent = m.multiply(t)
    val amount = P.multiply(base.pow(exponent.intValueExact()))
    val interest = amount.subtract(P)

    val difference = interest.subtract(BigDecimal(shownCorrect)).abs()
    return difference < BigDecimal(spec.tolerance.toString())
}