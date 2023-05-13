package com.example.tickle_tackle_tockle.presentation

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
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.*
import com.example.tickle_tackle_tockle.R
import com.example.tickle_tackle_tockle.model.Tickle
import com.example.tickle_tackle_tockle.response.TickleListResponse
import com.example.tickle_tackle_tockle.theme.TTTTheme

@Composable
fun TickleListScreen(
    onButtonClick: () -> Unit,
    ticklesCategory: List<TickleListResponse>
) {
    val tickles : MutableList<Tickle> = ArrayList()
    for (element in ticklesCategory) {
        tickles.addAll(element.tickles)
    }

    val sortedTicklesList = tickles.sortedWith(compareBy { it.executionTime })

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
                    horizontalArrangement = Arrangement.Center
                ) {}
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
                    TickleList(sortedTicklesList,onButtonClick)
                }
            }
        }
    }
}
@Composable
private fun TickleList(tickles: List<Tickle>, onButtonClick: () -> Unit) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(1),
        contentPadding = PaddingValues(horizontal = 16.dp, vertical = 15.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        modifier = Modifier.fillMaxHeight()
    ) {
        items(tickles){ tickle ->
            Box(
                Modifier.fillMaxHeight()
            ) {
                if(!tickle.achieved)
                {
                    Row {
                        Column(
                            modifier = Modifier
                                .weight(0.3f)
                                .padding(top = 3.dp),
                            verticalArrangement = Arrangement.Bottom
                        ) {
                            Text(text = tickle.emoji, textAlign = TextAlign.Center)
                        }
                        Column(
                            modifier = Modifier
                                .weight(1.3f)
                                .padding(start = 5.dp),
                            verticalArrangement = Arrangement.Center,
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Row {
                                Text(
                                    text = tickle.habitName,
                                    style = MaterialTheme.typography.body2,
                                    textAlign = TextAlign.Center,
                                    overflow = TextOverflow.Ellipsis,
                                    maxLines = 1
                                )
                            }
                            Row {
                                Text(text = "${tickle.executionTime.substring(0,2)}:${tickle.executionTime.substring(2,4)}",
                                    style = MaterialTheme.typography.caption2,
                                    textAlign = TextAlign.Center,
                                    overflow = TextOverflow.Ellipsis,
                                    maxLines = 1
                                )
                            }
                        }
                        Column(
                            modifier = Modifier
                                .weight(0.7f)
                        ) {
                            Button(
                                onClick = { onButtonClick()}, // TODO: 여기서 API 요청하도록 변경해야함
                                modifier = Modifier
                                    .background(
                                        MaterialTheme.colors.secondary,
                                        shape = RoundedCornerShape(30.dp)
                                    )
                                    .fillMaxSize()
                                    .size(size = 30.dp),
                                colors = ButtonDefaults.secondaryButtonColors()
                            ) {
                                Text(text = "미달성", style = MaterialTheme.typography.caption1)
                            }
                        }
                    }
                }
            }
        }
    }
}

private fun getEmojiByUnicode(unicode: Int): String {
    return String(Character.toChars(unicode))
}
