package com.cognopath.fastlens.data.repository

import com.cognopath.fastlens.data.remote.SupabaseClientFactory
import com.cognopath.fastlens.domain.model.Attempt
import com.cognopath.fastlens.domain.model.Question
import io.github.jan_tennert.supabase.postgrest.postgrest
import kotlinx.serialization.json.Json

class SupabaseRepository {

    private val client = SupabaseClientFactory.create()
    private val json = Json { ignoreUnknownKeys = true }

    suspend fun getQuestions(courseId: String): List<Question> {
        return try {
            val result = client.postgrest["questions"].select {
                eq("course_id", courseId)
            }
            result.decodeList<Question>()
        } catch (e: Exception) {
            e.printStackTrace()
            emptyList()
        }
    }

    suspend fun logAttempt(attempt: Attempt) {
        try {
            client.postgrest["attempts"].insert(attempt)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}