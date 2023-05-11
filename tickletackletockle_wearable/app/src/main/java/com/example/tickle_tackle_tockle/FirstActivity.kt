package com.example.tickle_tackle_tockle

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth

class FirstActivity : AppCompatActivity() {

    private lateinit var firebaseAuth: FirebaseAuth
    private lateinit var sharedPreferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        firebaseAuth = FirebaseAuth.getInstance()
        sharedPreferences = applicationContext.getSharedPreferences("wearAbleToken", Context.MODE_PRIVATE)
        val accessToken = sharedPreferences.getString("accessToken", null)
        val refreshToken = sharedPreferences.getString("refreshToken", null)

        val intent =
            if (firebaseAuth.currentUser != null) {
                Intent(this@FirstActivity, MainActivity::class.java)
                    .putExtra("accessToken","accessToken")
                    .putExtra("refreshToken","refreshToken")
            } else {
                Intent(this@FirstActivity, QRActivity::class.java)
            }
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }
}