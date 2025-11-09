package com.cognopath.fastlens.data.repository

import com.cognopath.fastlens.data.local.AttemptDao
import com.cognopath.fastlens.data.local.AttemptEntity
import com.cognopath.fastlens.data.local.QuestionAssetDataSource
import com.cognopath.fastlens.domain.model.Attempt
import com.cognopath.fastlens.domain.model.Question
import java.util.UUID

class PracticeRepository(
    private val questionAssetDataSource: QuestionAssetDataSource,
    private val attemptDao: AttemptDao
) {

    fun loadQuestions(): List<Question> {
        return questionAssetDataSource.loadQuestions()
    }

    suspend fun saveAttempt(attempt: Attempt) {
        val entity = AttemptEntity(
            id = UUID.randomUUID().toString(),
            questionId = attempt.questionId,
            isCorrect = attempt.isCorrect,
            timeMs = attempt.timeMs,
            firstActionMs = attempt.firstActionMs,
            createdAt = System.currentTimeMillis()
        )
        attemptDao.insertAttempt(entity)
    }

    suspend fun getRecentAttempts(limit: Int): List<AttemptEntity> {
        return attemptDao.getRecentAttempts(limit)
    }
}