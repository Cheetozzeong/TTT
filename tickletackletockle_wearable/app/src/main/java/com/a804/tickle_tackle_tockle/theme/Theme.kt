package com.a804.tickle_tackle_tockle.theme

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.wear.compose.material.Colors
import androidx.wear.compose.material.MaterialTheme


val TTTPrimary = Color(0xFFFF5555)
val TTTOnPrimary = Color(0xFFFFFFFF)
val TTTSecondary = Color(0xFF828282)


internal val wearColor: Colors = Colors(
    primary = TTTPrimary,
    onPrimary = TTTOnPrimary,
    secondary = TTTSecondary
)
@Composable
fun TTTTheme(
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colors = wearColor,
        typography = TTTTypography,
        // For shapes, we generally recommend using the default Material Wear shapes which are
        // optimized for round and non-round devices.
        content = content
    )
}