package com.example.tickle_tackle_tockle.navigation

import android.content.SharedPreferences
import androidx.compose.runtime.Composable
import androidx.navigation.NavOptions
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.example.tickle_tackle_tockle.presentation.TickleListScreen
import com.example.tickle_tackle_tockle.presentation.WelcomeScreen


@Composable
fun TTTNavHost(sharedPreferences: SharedPreferences) {

    val navController = rememberSwipeDismissableNavController()
    SwipeDismissableNavHost(
        navController = navController,
        startDestination = "welcome_screen"
    ) {
        composable("welcome_screen") {
            WelcomeScreen(
                onButtonClick = {
                    navController.navigate(
                        "ticklelist_screen",
                        NavOptions.Builder()
                            .setPopUpTo("welcome_screen", true)
                            .build()
                    )
                },
                sharedPreferences = sharedPreferences
            )
        }
        composable("ticklelist_screen") {
            TickleListScreen(
                onButtonClick = {
                    navController.navigate(
                        "welcome_screen",
                        NavOptions.Builder()
                            .setPopUpTo("ticklelist_screen", true)
                            .build()
                    )
                }
            )
        }
        //TickleListScreen(id = it.arguments?.getString("id")!!)
    }
}
