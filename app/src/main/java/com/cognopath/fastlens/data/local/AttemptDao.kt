package com.cognopath.fastlens.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface AttemptDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAttempt(attempt: AttemptEntity)

    @Query("SELECT * FROM attempts ORDER BY createdAt DESC LIMIT :limit")
    suspend fun getRecentAttempts(limit: Int): List<AttemptEntity>
}