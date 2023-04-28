package com.ttt.tickletackletockle

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.ttt.tickletackletockle.presentation.AlarmScreen
import com.ttt.tickletackletockle.presentation.tickleListScreen

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AlarmScreen()
        }
    }
}
