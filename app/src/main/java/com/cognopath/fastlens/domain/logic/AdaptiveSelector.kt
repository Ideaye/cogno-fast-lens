package com.cognopath.fastlens.domain.logic

import com.cognopath.fastlens.data.local.AttemptEntity
import com.cognopath.fastlens.domain.model.Question
import kotlin.math.roundToInt

fun nextQuestion(
    currentId: String?,
    history: List<AttemptEntity>,
    pool: List<Question>
): Question? {
    if (pool.isEmpty()) {
        return null
    }

    val recentQuestionIds = history.take(5).map { it.questionId }.toSet()
    val availableQuestions = pool.filter { it.id != currentId && it.id !in recentQuestionIds }

    if (availableQuestions.isEmpty()) {
        return pool.filter { it.id != currentId }.randomOrNull() ?: pool.firstOrNull()
    }

    val lastAttempt = history.firstOrNull()
    val recentCorrectAttempts = history.filter { it.isCorrect }.take(10)
    val timePercentile75 = if (recentCorrectAttempts.isNotEmpty()) {
        recentCorrectAttempts.map { it.timeMs }.sorted().let {
            it[(it.size * 0.75).roundToInt().coerceAtMost(it.size - 1)]
        }
    } else {
        Int.MAX_VALUE
    }

    val questionWeights = availableQuestions.associateWith { question ->
        var weight = 0.0

        if (lastAttempt != null && !lastAttempt.isCorrect) {
            val lastAttemptQuestion = pool.find { it.id == lastAttempt.questionId }
            if (lastAttemptQuestion?.subTopic == question.subTopic) {
                weight += 2.0
            }
        }

        val lastTimeForThisQuestion = history.firstOrNull { it.questionId == question.id }
        if (lastTimeForThisQuestion != null && lastTimeForThisQuestion.isCorrect && lastTimeForThisQuestion.timeMs > timePercentile75) {
            weight += 1.0
        }

        // Add some randomness to break ties
        weight += Math.random() * 0.1

        weight
    }

    return questionWeights.maxByOrNull { it.value }?.key ?: availableQuestions.random()
}