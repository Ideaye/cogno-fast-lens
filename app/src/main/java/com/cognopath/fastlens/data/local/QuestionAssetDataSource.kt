package com.cognopath.fastlens.data.local

import android.content.Context
import com.cognopath.fastlens.domain.model.Question
import kotlinx.serialization.json.Json
import java.io.IOException

class QuestionAssetDataSource(private val context: Context) {

    private val json = Json { ignoreUnknownKeys = true }

    fun loadQuestions(): List<Question> {
        return try {
            val jsonString = context.assets.open("questions.json").bufferedReader().use { it.readText() }
            json.decodeFromString<List<Question>>(jsonString)
        } catch (ioException: IOException) {
            ioException.printStackTrace()
            emptyList()
        }
    }
}