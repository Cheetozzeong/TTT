package com.example.tickle_tackle_tockle

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.messaging.FirebaseMessaging
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import java.io.IOException

class FirstActivity : AppCompatActivity() {

    private lateinit var sharedPreferences: SharedPreferences
    private lateinit var firebaseMessaging: FirebaseMessaging
    private lateinit var deviceToken: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        firebaseMessaging = FirebaseMessaging.getInstance()
        val token = firebaseMessaging.token

        sharedPreferences = applicationContext.getSharedPreferences("tttToken", Context.MODE_PRIVATE)
        val accessToken = sharedPreferences.getString("accessToken", null)
        val refreshToken = sharedPreferences.getString("refreshToken", null)

        token.addOnCompleteListener { task ->
            if (!task.isSuccessful) {
                Log.w(ContentValues.TAG, "Fetching FCM registration token failed", task.exception)
                return@addOnCompleteListener
            }

            val deviceToken = task.result
            postNewDeviceToken(deviceToken, accessToken)
        }

        val intent =
            if (accessToken != null && refreshToken != null) {
                Intent(this@FirstActivity, MainActivity::class.java)
            } else {
                Intent(this@FirstActivity, QRActivity::class.java)
            }
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }

    fun postNewDeviceToken(deviceToken: String, accessToken: String?) {
        val url = "http://k8a804.p.ssafy.io:8428/watchfcmtoken"
        val jsonMediaType = "application/json; charset=utf-8".toMediaType()
        val requestBody = "{\"watchFcmToken\":\"$deviceToken\"}".toRequestBody(jsonMediaType)

        val client = OkHttpClient()
        val request = Request.Builder()
            .url(url)
            .header("authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJRdmp1TzJpdGthZlpPY3lvbE9TNE5abDFwU0YyIiwidWlkIjoiUXZqdU8yaXRrYWZaT2N5b2xPUzROWmwxcFNGMiIsImV4cCI6MTY4Mzg3NTUzM30.MirxDXrcSWvZkINuE_tV0WyQTifrKGYzYXjeujtpPSEpWoRkYgDBw1RWiKVLLvlLkTkNZuO9esknlNzUqXdBmA ")
            //TODO: authorization -> accessToken 뒤에 있는거 각자 accessToken으로 url은 https로 Manifest에 있는 android:usesCleartextTraffic="true"코드 지우기
            .post(requestBody)
            .build()

        client.newCall(request).enqueue(object : okhttp3.Callback {
            override fun onFailure(call: okhttp3.Call, e: IOException) {
                Log.e(ContentValues.TAG, "Failed to send FCM token", e)
            }

            override fun onResponse(call: okhttp3.Call, response: Response) {
                if (response.isSuccessful) {
                    Log.d(ContentValues.TAG, "FCM token sent successfully")
                } else {
                    Log.w(ContentValues.TAG, "Failed to send FCM token. Response: ${response.body?.string()}")
                }
            }
        })
    }
}