/* While this template provides a good starting point for using Wear Compose, you can always
 * take a look at https://github.com/android/wear-os-samples/tree/main/ComposeStarter and
 * https://github.com/android/wear-os-samples/tree/main/ComposeAdvanced to find the most up to date
 * changes to the libraries and their usages.
 */

package com.ttt.tickletackletockle.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Devices
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Button
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material.Text
import com.ttt.tickletackletockle.R
import com.ttt.tickletackletockle.presentation.theme.TTTTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val tickles = listOf(
            tickle("emoji1","달성"),
            tickle("emoji2","달성"),
            tickle("emoji3","달성"),
            tickle("emoji4","미달성"),
            tickle("emoji5","미달성"),
            tickle("emoji6","미달성")
        )
        setContent {
            WearApp(tickles)
        }
    }
}

data class tickle(
    val emoji: String,
    val title: String
)

@Composable
fun WearApp(
    tickles: List<tickle>
) {
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
                            .size(110.dp,30.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(text = "오늘의 티끌")
                    }
                }
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(4.0f)
                ) {
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
                                        modifier = Modifier.weight(1f),
                                        verticalArrangement = Arrangement.Center
                                    ) {
                                        Text(text = tickle.emoji, style = MaterialTheme.typography.title3)
                                    }
                                    Column(
                                        modifier = Modifier
                                            .padding(start = 30.dp)
                                            .weight(1f)
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
            }
        }
    }
}