package com.a804.tickle_tackle_tockle

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.*
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.ParcelUuid
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.ui.Modifier
import androidx.core.app.ActivityCompat
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.Text
import com.a804.tickle_tackle_tockle.navigation.TTTNavHost
import com.a804.tickle_tackle_tockle.theme.TTTTheme
import java.util.*

class MainActivity : ComponentActivity() {

    private var _socket: BluetoothSocket? = null

    // 추가: Bluetooth 권한 및 요청에 대한 변수 정의
    private val PERMISSION_REQUEST_CODE = 1
    private val REQUIRED_PERMISSIONS = arrayOf(
        Manifest.permission.BLUETOOTH,
        Manifest.permission.BLUETOOTH_ADMIN,
        Manifest.permission.ACCESS_FINE_LOCATION
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 추가: Bluetooth 권한 확인 및 요청
        if (!hasPermissions(this, REQUIRED_PERMISSIONS)) {
            Log.d("Bluetooth123", "HasPerMission")
            ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, PERMISSION_REQUEST_CODE)
        } else {
            Log.d("Bluetooth123", "HasNoPerMission")
            // 권한이 이미 허용된 경우, Bluetooth 관련 작업을 진행합니다.
            initializeBluetooth()
        }

        fun send(message: String){
            Log.d("BlueTooth123" , "send message")
            val outputStream = _socket?.outputStream
            outputStream?.write(message.toByteArray())
        }

        setContent {
            Log.d("Bluetooth123","setConetnt")
//            TTTTheme {
//                TTTNavHost(
//                    onButtonClick = {
//                        Log.d("Bluetooth123","isclicked")
//                        send("Button Clicked")
//                    }
//                )
//            }
            Button(onClick = {send("motherFucker")}, Modifier.fillMaxWidth()){}
            Log.d("Bluetooth123","setConetntend")
        }
    }

    // 추가: Bluetooth 권한 확인을 위한 유틸리티 함수
    private fun hasPermissions(context: Context, permissions: Array<String>): Boolean {
        for (permission in permissions) {
            if (ActivityCompat.checkSelfPermission(context, permission) != PackageManager.PERMISSION_GRANTED) {
                return false
            }
        }
        return true
    }

    // 추가: Bluetooth 초기화 작업을 수행하는 함수
    @SuppressLint("MissingPermission")
    private fun initializeBluetooth() {
        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        val bluetoothAdapter = bluetoothManager.adapter
        val devices : Set<BluetoothDevice>? = bluetoothAdapter?.bondedDevices
        val device: BluetoothDevice? = bluetoothAdapter?.bondedDevices?.first()

        val parcelUuidArray: Array<out ParcelUuid>? = device?.uuids
        val uuidList = parcelUuidArray?.map { it.uuid }
        val uuidArray = uuidList?.toTypedArray()
        val uuid: UUID? = uuidArray?.getOrNull(1)
        val socket = device?.createRfcommSocketToServiceRecord(uuid)

        _socket = socket
        if (device != null) {
            Log.d("BlueTooth123" , device.name)
        } else {
            Log.d("BlueTooth123" , "ssibal")
        }
        // Bluetooth 연결 및 데이터 전송 작업을 진행합니다.
        connectBluetoothSocket()
    }

    // 추가: Bluetooth 소켓 연결 작업을 수행하는 함수
    private fun connectBluetoothSocket() {
        Thread {
            Log.d("BlueTooth123" , "thread")
            try {
                Log.d("BlueTooth123" , "try")
                if (ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    _socket?.connect()
                    Log.d("Bluetooth123", "socketConnected")
                } else {
                    Log.d("Bluetooth123", "socketConnectedFailed")
                }

                // 연결된 경우에 대한 작업 수행
                if (_socket?.isConnected == true) {
                    Log.d("Bluetooth123", "Connected")
                } else {
                    Log.d("Bluetooth123", "Connection failed")
                }


                val inputStream = _socket?.inputStream
                val buffer = ByteArray(1024)
                var bytes: Int

                fun close() {
                    _socket?.close()
                }


                // 추가: 데이터 수신 작업 수행
                while (true) {
                    bytes = inputStream?.read(buffer) ?: break
                    val receivedMessage = String(buffer, 0, bytes)
                    Log.d("Bluetooth123", "Received: $receivedMessage")
                }
            } catch (e: Exception) {
                Log.e("BluetoothError", "Error: ${e.message}")
            }
        }.start()
    }
}
