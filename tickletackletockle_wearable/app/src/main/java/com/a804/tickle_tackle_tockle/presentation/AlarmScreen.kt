package com.a804.tickle_tackle_tockle.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.*
import com.a804.tickle_tackle_tockle.R
import com.a804.tickle_tackle_tockle.complication.Tickle
import com.a804.tickle_tackle_tockle.theme.TTTTheme

@Composable
fun AlarmScreen(){
    //dummyData
    val tickle = Tickle(getEmojiByUnicode(0x1F95B),"물 한잔 마시기!")

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
                        .weight(0.3f),
                    verticalAlignment = Alignment.Bottom,
                    horizontalArrangement = Arrangement.Center
                ) {}
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(0.8f),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.Center,
                ) {
                    Box(
                        modifier = Modifier,
                        contentAlignment = Alignment.Center
                    ) {
                        Text(text = tickle.emoji, fontSize = 50.sp)
                    }
                }
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(0.5f),
                    horizontalArrangement = Arrangement.Center
                ) {
                    Box(
                        Modifier,
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = tickle.title ,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis,
                        )
                    }
                }
                Row(
                    Modifier.weight(0.5f),
                    horizontalArrangement = Arrangement.Center
                ) {
                    Button(
                        onClick = { /*TODO*/ },
                        Modifier
                            .background(
                                MaterialTheme.colors.primary,
                            )
                            .fillMaxSize(),
                    ) {
                        Text(text = stringResource(R.string.CheckOnAlarm), style = MaterialTheme.typography.body2)
                    }
                }
            }
        }
    }
}

