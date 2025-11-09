package com.cognopath.fastlens.data.local

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "attempts")
data class AttemptEntity(
  @PrimaryKey val id: String,
  val questionId: String,
  val isCorrect: Boolean,
  val timeMs: Int,
  val firstActionMs: Int?,
  val createdAt: Long
)