package com.ttt.tickletackletockle.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material.Text
import com.ttt.tickletackletockle.R
import com.ttt.tickletackletockle.complication.Tickle
import com.ttt.tickletackletockle.theme.TTTTheme

@Composable
fun tickleListScreen() {

    //DummyData
    val tickles = listOf(
        Tickle(getEmojiByUnicode(0x1F60A),"달성"),
        Tickle(getEmojiByUnicode(0x1F3C3),"달성"),
        Tickle(getEmojiByUnicode(0x1F3CA),"달성"),
        Tickle(getEmojiByUnicode(0x1F9D7),"미달성"),
        Tickle(getEmojiByUnicode(0x1F9D7),"미달성"),
        Tickle(getEmojiByUnicode(0x1F9D7),"미달성")
    )

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
                    tickleList(tickles)
                }
            }
        }
    }
}

@Composable
fun tickleList(tickles: List<Tickle>) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(1),
        contentPadding = PaddingValues(horizontal = 16.dp, vertical = 10.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        modifier = Modifier.fillMaxHeight()
    ) {
        items(tickles){ tickle ->
            Box(
                Modifier.fillMaxHeight()
            ) {
                Row {
                    Column(
                        modifier = Modifier.weight(0.3f),
                        verticalArrangement = Arrangement.Center
                    ) {
                    }
                    Column(
                        modifier = Modifier.weight(1.2f),
                        verticalArrangement = Arrangement.Center
                    ) {
                        Text(text = tickle.emoji, textAlign = TextAlign.Center)
                    }
                    Column(
                        modifier = Modifier
                            .padding(start = 30.dp)
                            .weight(1.5f)
                    ) {
                        Button(
                            onClick = { /*TODO*/ },
                            modifier = Modifier
                                .background(
                                    MaterialTheme.colors.primary,
                                    shape = RoundedCornerShape(30.dp)
                                )
                                .fillMaxSize()
                                .size(size = 30.dp),
                        ) {
                            Text(text = tickle.title, style = MaterialTheme.typography.body2)
                        }
                    }
                }
            }
        }
    }
}

fun getEmojiByUnicode(unicode: Int): String {
    return String(Character.toChars(unicode))
}
