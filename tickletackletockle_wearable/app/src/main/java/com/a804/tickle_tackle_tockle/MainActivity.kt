package com.a804.tickle_tackle_tockle

import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.a804.tickle_tackle_tockle.navigation.TTTNavHost
import com.a804.tickle_tackle_tockle.response.TickleListResponse
import com.a804.tickle_tackle_tockle.theme.TTTTheme
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import java.io.IOException
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class MainActivity : ComponentActivity() {
    private lateinit var sharedPreferences: SharedPreferences
    private var tickles: List<TickleListResponse>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        sharedPreferences =
            applicationContext.getSharedPreferences("tttToken", Context.MODE_PRIVATE)

        sharedPreferences.getString("accessToken", null)?.let { accessToken ->
            sharedPreferences.getString("refreshToken", null)?.let { refreshToken ->
                getScheduleList(accessToken, refreshToken)
            }
        }

        super.onCreate(savedInstanceState)
        setContent {
            TTTTheme {
                tickles?.let {
                    TTTNavHost(sharedPreferences, tickles = it)
                }
            }
        }
    }

    private fun getScheduleList(accessToken: String, refreshToken: String) {
        CoroutineScope(Dispatchers.IO).launch {
            val nowDate = LocalDate.now()
            val formatter = DateTimeFormatter.ofPattern("yyyyMMdd")
            val formattedDate = nowDate.format(formatter)
            val url =
                "https://k8a804.p.ssafy.io/staging-api/tickle/schedule?targetDate=${formattedDate}"

            val client = OkHttpClient()
            val request = Request.Builder()
                .url(url)
                .header("authorization", "Bearer $accessToken")
                .get()
                .build()
            val response: Response

            try {
                response = client.newCall(request).execute()
                if (response.isSuccessful) {
                    Log.d("URL 요청 결과", "Success to get TickleList!!!!.")
                    val json = response.body?.string()
                    val TickleList: List<TickleListResponse> =
                        Gson().fromJson(
                            json,
                            object : TypeToken<List<TickleListResponse>>() {}.type
                        )
                    tickles = TickleList
                    setContent {
                        TTTTheme {
                            TTTNavHost(sharedPreferences, tickles = TickleList)
                        }
                    }
                } else {
                    Log.d("URL 요청 결과", "Failed to get TickleList!!!!.")
                }
            } catch (e: IOException) {
                Log.d("URL 요청 결과", "Failed to get TickleList", e)
            }
        }
    }
}
