package com.a804.tickle_tackle_tockle.presentation

import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.*
import coil.ImageLoader
import coil.compose.rememberAsyncImagePainter
import coil.decode.ImageDecoderDecoder
import coil.request.ImageRequest
import coil.size.Size
import com.a804.tickle_tackle_tockle.R
import com.a804.tickle_tackle_tockle.model.Tickle
import com.a804.tickle_tackle_tockle.response.TickleListResponse
import com.a804.tickle_tackle_tockle.theme.TTTTheme
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import java.io.IOException
import java.time.LocalDate
import java.time.LocalTime
import java.time.format.DateTimeFormatter

@Composable
fun TickleListScreen(
    ticklesCategory: List<TickleListResponse>,
    accessToken: String,
    refreshToken: String
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
                    TickleList(sortedTicklesList,accessToken,refreshToken)
                }
            }
        }
    }
}

@Composable
private fun TickleList(tickles: List<Tickle>, accessToken: String, refreshToken: String) {
    val scope = rememberCoroutineScope()
    val showGif = remember { mutableStateOf(false) }
    if (showGif.value) {
        AchieveGif(Modifier.fillMaxSize())
    }
    LazyVerticalGrid(
        columns = GridCells.Fixed(1),
        contentPadding = PaddingValues(horizontal = 16.dp, vertical = 10.dp),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        modifier = Modifier.fillMaxHeight()
    ) {
        items(tickles) { tickle ->
            val currentTime = getCurrentTime()
            val executionTime =
                LocalTime.parse(tickle.executionTime, DateTimeFormatter.ofPattern("HHmm"))

            if (!tickle.achieved) {
                Box(
                    Modifier.fillMaxHeight()
                ) {
                    Row(
                        Modifier.padding(bottom = 10.dp)
                    ) {
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
                                Text(
                                    text = "${
                                        tickle.executionTime.substring(
                                            0,
                                            2
                                        )
                                    }:${tickle.executionTime.substring(2, 4)}",
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
                            if (!tickle.achieved && currentTime.isAfter(executionTime)) {
                                Button(
                                    onClick = {
                                        showGif.value = true
                                        tickle.achieved = true
                                        postCreateTickle(
                                            accessToken = accessToken,
                                            refreshToken = refreshToken,
                                            habitId = tickle.habitId,
                                            executionTime = tickle.executionTime
                                        )
                                        scope.launch {
                                            delay(3000)
                                            // Hide the gif
                                            showGif.value = false
                                        }
                                    },
                                    modifier = Modifier
                                        .background(
                                            MaterialTheme.colors.primary,
                                            shape = RoundedCornerShape(30.dp)
                                        )
                                        .fillMaxSize()
                                        .size(size = 30.dp),
                                    colors = ButtonDefaults.primaryButtonColors()
                                ) {
                                    Text(text = "완료하기", style = MaterialTheme.typography.caption1)
                                }
                            } else {
                                Button(
                                    onClick = {},
                                    enabled = false,
                                    modifier = Modifier
                                        .background(
                                            MaterialTheme.colors.secondary,
                                            shape = RoundedCornerShape(30.dp)
                                        )
                                        .fillMaxSize()
                                        .size(size = 30.dp),
                                    colors = ButtonDefaults.secondaryButtonColors()
                                ) {
                                    Text(text = "커밍순!", style = MaterialTheme.typography.caption1)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private fun postCreateTickle(accessToken: String, refreshToken: String, habitId: Long, executionTime: String) {
    val nowDate = LocalDate.now()
    val formatter = DateTimeFormatter.ofPattern("yyyyMMdd")
    val formattedDate = nowDate.format(formatter)

    val url = "https://k8a804.p.ssafy.io/api/tickle"
    val jsonMediaType = "application/json; charset=utf-8".toMediaType()
    val requestBody = """
    {
      "habitId": $habitId,
      "executionDay": "$formattedDate",
      "executionTime": "$executionTime"
    }
""".trimIndent().toRequestBody(jsonMediaType)

    val client = OkHttpClient()
    val request = Request.Builder()
        .url(url)
//        .header("authorization", "Bearer $accessToken")
        .header("accessToken", "Bearer $accessToken")
//          .header("refreshToken",refreshToken)
        //TODO: authorization -> accessToken 뒤에 있는거 각자 accessToken으로 url은 https로 Manifest에 있는 android:usesCleartextTraffic="true"코드 지우기
        .post(requestBody)
        .build()

    client.newCall(request).enqueue(object : okhttp3.Callback {
        override fun onFailure(call: okhttp3.Call, e: IOException) {
            Log.d("URL 요청 결과", "Failed to createTickle", e)

        }

        override fun onResponse(call: okhttp3.Call, response: Response) {
            if (response.isSuccessful) {
                Log.d("URL 요청 결과", "createTickle sent successfully")
            } else {
                Log.d("URL 요청 결과", "Failed createTickle. Response: ${response.body?.string()}")
            }
        }
    })
}

@Composable
fun AchieveGif(
    modifier: Modifier = Modifier,
) {
    val context = LocalContext.current
    val imageLoader = ImageLoader.Builder(context)
        .components {
            add(ImageDecoderDecoder.Factory())
        }
        .build()

    val gifResources = listOf(
        R.drawable.star,
        R.drawable.turningtrophy,
        R.drawable.uptrophy,
        R.drawable.medal
    )

    val randomGifResource = gifResources.random()

    Image(
        painter = rememberAsyncImagePainter(
            ImageRequest.Builder(context)
                .data(randomGifResource)
                .apply {
                    size(Size.ORIGINAL)
                }
                .build(),
            imageLoader = imageLoader
        ),
        contentDescription = "Congratulation!! You get tickle",
        modifier = modifier.fillMaxWidth(),
    )
}

private fun getCurrentTime(): LocalTime {
    return LocalTime.now()
}
