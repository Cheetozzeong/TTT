package com.example.tickle_tackle_tockle

import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.example.tickle_tackle_tockle.navigation.TTTNavHost
import com.example.tickle_tackle_tockle.theme.TTTTheme
class MainActivity : ComponentActivity() {
    private lateinit var sharedPreferences: SharedPreferences
    override fun onCreate(savedInstanceState: Bundle?) {
        sharedPreferences = applicationContext.getSharedPreferences("tttToken", Context.MODE_PRIVATE)
        super.onCreate(savedInstanceState)
        setContent {
            TTTTheme {
                TTTNavHost(sharedPreferences)
            }
        }
    }
}



