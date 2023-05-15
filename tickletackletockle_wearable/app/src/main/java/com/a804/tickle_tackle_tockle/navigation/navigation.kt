package com.a804.tickle_tackle_tockle.navigation

import android.content.SharedPreferences
import androidx.compose.runtime.Composable
import androidx.navigation.NavOptions
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.a804.tickle_tackle_tockle.presentation.TickleListScreen
import com.a804.tickle_tackle_tockle.presentation.WelcomeScreen
import com.a804.tickle_tackle_tockle.response.TickleListResponse


@Composable
fun TTTNavHost(sharedPreferences: SharedPreferences, tickles: List<TickleListResponse>) {

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
            sharedPreferences.getString("accessToken",null)?.let { accessToken ->
                sharedPreferences.getString("refreshToken", null)?.let { refreshToken ->
                    TickleListScreen(
                        onButtonClick = {
                            navController.navigate(
                                "welcome_screen",
                                NavOptions.Builder()
                                    .setPopUpTo("ticklelist_screen", true)
                                    .build()
                            )
                        },
                        ticklesCategory = tickles
                    )
                }
            }
        }
        //TickleListScreen(id = it.arguments?.getString("id")!!)
    }
}
