package com.a804.tickle_tackle_tockle.navigation

import android.util.Log
import androidx.compose.runtime.Composable
import androidx.navigation.NavOptions
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.a804.tickle_tackle_tockle.presentation.AlarmScreen
import com.a804.tickle_tackle_tockle.presentation.TickleListScreen


@Composable
fun TTTNavHost(
    onButtonClick: () -> Unit
) {
    val navController = rememberSwipeDismissableNavController()

    SwipeDismissableNavHost(
        navController = navController,
        startDestination = "alarm_screen"
    ) {
        composable("alarm_screen") {
            AlarmScreen(onButtonClick = {
                Log.d("Bluetooth123", "ClickedButton1212")
                onButtonClick
                Log.d("Bluetooth123", "ClickedButton3434")
//                navController.navigate(
//                    "ticklelist_screen",
//                    NavOptions.Builder()
//                        .setPopUpTo("alarm_screen", true)
//                        .build()
//                )
            })
        }
        composable("ticklelist_screen") {
            TickleListScreen()
        }
        //TickleListScreen(id = it.arguments?.getString("id")!!)
    }
}
