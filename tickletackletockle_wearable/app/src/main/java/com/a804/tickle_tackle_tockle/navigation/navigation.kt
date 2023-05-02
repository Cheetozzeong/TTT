package com.a804.tickle_tackle_tockle.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavOptions
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.a804.tickle_tackle_tockle.presentation.AlarmScreen
import com.a804.tickle_tackle_tockle.presentation.TickleListScreen


@Composable
fun TTTNavHost() {
    val navController = rememberSwipeDismissableNavController()

    SwipeDismissableNavHost(
        navController = navController,
        startDestination = "alarm_screen"
    ) {
        composable("alarm_screen") {
            AlarmScreen(onButtonClick = {
                navController.navigate(
                    "ticklelist_screen",
                    NavOptions.Builder()
                        .setPopUpTo("alarm_screen", true)
                        .build()
                )
            })
        }
        composable("ticklelist_screen") {
            TickleListScreen()
        }
        //TickleListScreen(id = it.arguments?.getString("id")!!)
    }
}
