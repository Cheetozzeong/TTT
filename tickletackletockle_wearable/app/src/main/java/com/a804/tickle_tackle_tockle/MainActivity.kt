package com.a804.tickle_tackle_tockle

import android.Manifest
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothSocket
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.ParcelUuid
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.app.ActivityCompat
import com.a804.tickle_tackle_tockle.navigation.TTTNavHost
import com.a804.tickle_tackle_tockle.theme.TTTTheme
import java.util.*


class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        val bluetoothAdapter = bluetoothManager.getAdapter()

        val device : BluetoothDevice? = if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED
        ) { bluetoothAdapter?.bondedDevices?.first()} else { return }

        val parcelUuidArray: Array<out ParcelUuid>? = device?.uuids // 변환하려는 ParcelUuid 배열

        val uuidList = parcelUuidArray?.map { it.uuid } // UUID 리스트 생성

        // UUID 리스트를 Array<UUID>로 변환
        val uuidArray = uuidList?.toTypedArray()

        val uuid: UUID? = uuidArray?.getOrNull(0)

        val socket = device?.createRfcommSocketToServiceRecord(uuid)

        
//        Log.d("나와라요오오오오", "uuids: "+device?.uuids.toString())
//        Log.d("나와라요오오오오", "name: "+device?.name.toString())
//        Log.d("나와라요오오오오", "alias: "+device?.alias.toString())
//        Log.d("나와라요오오오오", "bluetoothClass: "+device?.bluetoothClass.toString())
//        Log.d("나와라요오오오오", "type: "+device?.type.toString())
//        Log.d("나와라요오오오오", "bondState: "+device?.bondState.toString())

        setContent {
            TTTTheme {
                TTTNavHost()
            }
        }
    }
}