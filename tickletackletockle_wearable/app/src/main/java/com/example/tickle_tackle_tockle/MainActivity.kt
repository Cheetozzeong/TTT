package com.example.tickle_tackle_tockle

import android.content.ContentValues.TAG
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.example.tickle_tackle_tockle.navigation.TTTNavHost
import com.example.tickle_tackle_tockle.theme.TTTTheme
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging

class MainActivity : ComponentActivity() {
    private lateinit var firebaseMessaging: FirebaseMessaging
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        firebaseMessaging = FirebaseMessaging.getInstance()
        val deviceToken = firebaseMessaging.token

        deviceToken.addOnCompleteListener(OnCompleteListener { task ->
            if (!task.isSuccessful) {
                Log.w(TAG, "Fetching FCM registration token failed", task.exception)
                return@OnCompleteListener
            }
            val token = task.result
        })
        setContent {
            TTTTheme {
                TTTNavHost()
            }
        }
    }
}
