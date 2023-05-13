package com.example.tickle_tackle_tockle.theme

import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.Typography
import com.example.tickle_tackle_tockle.R


internal val TTTTypography = Typography(
    display1 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 57.sp,
        lineHeight = 64.sp,
        letterSpacing = (-0.25).sp,
    ),
    display2 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 45.sp,
        lineHeight = 52.sp,
        letterSpacing = 0.sp,
    ),
    display3 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 36.sp,
        lineHeight = 44.sp,
        letterSpacing = 0.sp,
    ),
    title1 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 32.sp,
        lineHeight = 40.sp,
        letterSpacing = 0.sp,
    ),
    title2 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 28.sp,
        lineHeight = 36.sp,
        letterSpacing = 0.sp,
    ),
    title3 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Normal,
        fontSize = 24.sp,
        lineHeight = 32.sp,
        letterSpacing = 0.sp,
    ),
    body1 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Bold,
        fontSize = 22.sp,
        lineHeight = 28.sp,
        letterSpacing = 0.sp,
    ),
    body2 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Bold,
        fontSize = 18.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.1.sp,
    ),
    caption1 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Bold,
        fontSize = 12.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.1.sp,
    ),
    caption2 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Bold,
        fontSize = 14.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.1.sp,
    ),
    caption3 = TextStyle(
        fontFamily = IgFont.maple,
        fontWeight = FontWeight.Bold,
        fontSize = 16.sp,
        lineHeight = 24.sp,
        letterSpacing = 0.1.sp,
    ),

)
object IgFont{
    val maple = FontFamily(
        Font(R.font.maplestory_bold, FontWeight.Bold, FontStyle.Normal),
        Font(R.font.maplestory_light, FontWeight.Normal, FontStyle.Normal)
    )
}