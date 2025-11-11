package com.cognopath.fastlens.data.repository

import com.cognopath.fastlens.data.remote.SupabaseClientFactory
import com.cognopath.fastlens.domain.model.Attempt
import com.cognopath.fastlens.domain.model.Question
import io.github.jan_tennert.supabase.functions.functions
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

    suspend fun generateOpenAiQuestion(topic: String): Question? {
        return try {
            val result = client.functions.invoke("generate-openai-question", body = mapOf("topic" to topic))
            // The Edge Function returns a raw JSON string, so we parse it manually.
            val questionJson = result.body<String>()
            json.decodeFromString<Question>(questionJson)
        } catch (e: Exception) {
            e.printStackTrace()
            return null
        }
    }
}