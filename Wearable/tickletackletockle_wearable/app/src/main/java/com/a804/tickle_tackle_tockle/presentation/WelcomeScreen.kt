package com.a804.tickle_tackle_tockle.presentation

import android.content.SharedPreferences
import android.os.Build
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextOverflow
import androidx.wear.compose.material.*
import coil.ImageLoader
import coil.compose.rememberAsyncImagePainter
import coil.decode.GifDecoder
import coil.decode.ImageDecoderDecoder
import coil.request.ImageRequest
import coil.size.Size
import com.a804.tickle_tackle_tockle.R
import com.a804.tickle_tackle_tockle.theme.TTTTheme

@Composable
fun WelcomeScreen(
    onButtonClick: () -> Unit,
    sharedPreferences: SharedPreferences
){
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
                        .weight(2f),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.Center,
                ) {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .clickable(onClick = {
                                sharedPreferences
                                    .edit()
                                    .clear()
                                    .apply()
                            }),
                        contentAlignment = Alignment.Center,
                    ) {
                        Text(text = "티끌 소환중..", style = MaterialTheme.typography.caption1)
                        welecomeGif()
                    }
                }
                Row(
                    Modifier
                        .fillMaxWidth()
                        .weight(0.7f),
                    horizontalArrangement = Arrangement.Center
                ) {
                    Box(
                        Modifier,
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = stringResource(R.string.Today) ,
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis,
                            style = MaterialTheme.typography.body1
                        )
                    }
                }
                Row(
                    Modifier.weight(1f),
                    horizontalArrangement = Arrangement.Center
                ) {
                    Button(
                        onClick = {
                            onButtonClick()
                        },
                        Modifier
                            .background(
                                Color.Gray,
                            )
                            .fillMaxSize(),
                    ) {
                        Text(text = stringResource(R.string.StartMessage), style = MaterialTheme.typography.body2)
                    }
                }
            }
        }
    }
}

@Composable
fun welecomeGif(
    modifier: Modifier = Modifier,
) {
    val context = LocalContext.current
    val imageLoader = ImageLoader.Builder(context)
        .components {
            if (Build.VERSION.SDK_INT >= 28) {
                add(ImageDecoderDecoder.Factory())
            } else {
                add(GifDecoder.Factory())
            }
        }
        .build()
    Image(
        painter = rememberAsyncImagePainter(
            ImageRequest.Builder(context).data(data = R.drawable.ssulmae).apply(block = {
                size(Size.ORIGINAL)
            }).build(), imageLoader = imageLoader
        ),
        contentDescription = null,
        modifier = modifier.fillMaxWidth(),
    )
}

