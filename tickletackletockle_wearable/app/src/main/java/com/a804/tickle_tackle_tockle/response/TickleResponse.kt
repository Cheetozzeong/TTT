package com.a804.tickle_tackle_tockle.response

import com.a804.tickle_tackle_tockle.model.Tickle

data class TickleListResponse(
    val categoryId: String,
    val categoryName: String,
    val tickles: ArrayList<Tickle> = arrayListOf(),
)
