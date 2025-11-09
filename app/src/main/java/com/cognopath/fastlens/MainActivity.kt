package com.cognopath.fastlens

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.cognopath.fastlens.ui.PracticeScreen
import com.cognopath.fastlens.ui.theme.CognoFastLensTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            CognoFastLensTheme {
                PracticeScreen()
            }
        }
    }
}