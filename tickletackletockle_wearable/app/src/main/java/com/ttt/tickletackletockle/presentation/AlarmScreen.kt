package com.ttt.tickletackletockle.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.focusable
import androidx.compose.foundation.gestures.animateScrollBy
import androidx.compose.foundation.gestures.scrollBy
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.input.rotary.onPreRotaryScrollEvent
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.*
import com.ttt.tickletackletockle.R
import com.ttt.tickletackletockle.complication.Tickle
import com.ttt.tickletackletockle.theme.TTTTheme
import kotlinx.coroutines.launch

@Composable
fun AlarmScreen(){
    val tickle = Tickle(getEmojiByUnicode(0x1F95B),"10분마다 물 마시기")

    TTTTheme {
        Scaffold(
            modifier = Modifier,
        ) {
            Column(
                Modifier
                    .fillMaxWidth()
            ) {
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(1.0f),
                    verticalAlignment = Alignment.Bottom,
                    horizontalArrangement = Arrangement.Center) {}
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(1.0f),
                    verticalAlignment = Alignment.Bottom,
                    horizontalArrangement = Arrangement.Center,
                ) {
                    Box(
                        modifier = Modifier
                            .border(
                                width = 2.dp,
                                color = MaterialTheme.colors.primary,
                                shape = RoundedCornerShape(10.dp)
                            )
                            .size(110.dp, 30.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(text = stringResource(R.string.TickleListTitle))
                    }
                }
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(4.0f)
                ) {

                }
            }
        }
    }
}

