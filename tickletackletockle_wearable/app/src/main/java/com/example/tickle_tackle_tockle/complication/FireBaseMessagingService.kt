package com.example.tickle_tackle_tockle.complication

import android.content.Context
import android.content.SharedPreferences
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage

class FirebaseMessagingService : FirebaseMessagingService() {
    private lateinit var sharedPreferences: SharedPreferences

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        sharedPreferences = applicationContext.getSharedPreferences("score", Context.MODE_PRIVATE)
        remoteMessage.data["score"]?.let { score ->
            sharedPreferences.edit().putString("score",score).apply()
        }
    }
}