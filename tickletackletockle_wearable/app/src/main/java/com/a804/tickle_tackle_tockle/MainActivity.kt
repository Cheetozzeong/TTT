package com.a804.tickle_tackle_tockle

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Context
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.a804.tickle_tackle_tockle.navigation.TTTNavHost
import com.a804.tickle_tackle_tockle.theme.TTTTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val bluetoothAdapter: BluetoothAdapter? by lazy(LazyThreadSafetyMode.PUBLICATION){
            val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
            bluetoothManager.adapter
        }

        setContent {
            TTTTheme {
                TTTNavHost()
            }
        }
    }


}