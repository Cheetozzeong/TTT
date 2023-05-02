package com.a804.tickle_tackle_tockle

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.a804.tickle_tackle_tockle.navigation.TTTNavHost
import com.a804.tickle_tackle_tockle.presentation.AlarmScreen
import com.a804.tickle_tackle_tockle.presentation.TickleListScreen
import com.a804.tickle_tackle_tockle.theme.TTTTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TTTTheme {
                TTTNavHost()
            }
        }
    }
}
