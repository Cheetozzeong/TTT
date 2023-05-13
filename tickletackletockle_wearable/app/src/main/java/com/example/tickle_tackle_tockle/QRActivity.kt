package com.example.tickle_tackle_tockle

import android.content.ContentValues
import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material.Text
import com.example.tickle_tackle_tockle.theme.TTTTheme
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging
import com.simonsickle.compose.barcodes.Barcode
import com.simonsickle.compose.barcodes.BarcodeType

class QRActivity : ComponentActivity() {

    private lateinit var sharedPreferences: SharedPreferences
    private lateinit var firebaseMessaging: FirebaseMessaging
    private lateinit var deviceToken: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedPreferences = applicationContext.getSharedPreferences("tttToken", Context.MODE_PRIVATE)
        firebaseMessaging = FirebaseMessaging.getInstance()
        val token = firebaseMessaging.token

        token.addOnCompleteListener(OnCompleteListener { task ->
            if (!task.isSuccessful) {
                Log.w(ContentValues.TAG, "Fetching FCM registration token failed", task.exception)
                return@OnCompleteListener
            }
            deviceToken = task.result
            setContent {
                TTTTheme {
                    QRCodeScreen(content = deviceToken, sharedPreferences = sharedPreferences)
                }
            }
        })

    }
}

@Composable
fun QRCodeScreen(content: String, sharedPreferences: SharedPreferences) {
    Scaffold(
        modifier = Modifier,
    ) {
        Column(
            Modifier
                .fillMaxWidth()
        ) {
            Row(
                Modifier
                    .fillMaxWidth()
                    .weight(0.8f),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.Center,
            ) {
                Box(
                    modifier = Modifier,
                    contentAlignment = Alignment.Center
                ) {
                    if (BarcodeType.QR_CODE.isValueValid(content)) {
                        Barcode(
                            modifier = Modifier
                                .width(130.dp)
                                .height(130.dp),
                            resolutionFactor = 10,
                            type = BarcodeType.QR_CODE,
                            value = content
                        )
                    }
                    if (!BarcodeType.CODE_128.isValueValid(content)) {
                        Text("")
                    }
                }
            }
        }
    }
}

