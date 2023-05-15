package com.a804.tickle_tackle_tockle.model

data class Tickle(
    var achieved: Boolean,
    val habitId: Long,
    val habitName: String,
    val executionTime: String,
    val emoji: String
)