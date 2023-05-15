package com.example.tickle_tackle_tockle.response

import com.example.tickle_tackle_tockle.model.Tickle

data class TickleListResponse(
    val categoryId: String,
    val categoryName: String,
    val tickles: ArrayList<Tickle> = arrayListOf(),
)
