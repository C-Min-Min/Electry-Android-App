package com.example.myapplication.API

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


object RetrofitClient {
    val clientSetup = OkHttpClient.Builder()
        .connectTimeout(3, TimeUnit.MINUTES)
        .writeTimeout(3, TimeUnit.MINUTES) // write timeout
        .readTimeout(3, TimeUnit.MINUTES) // read timeout
        .build()
    val retrofit by lazy {
        Retrofit.Builder()
            .baseUrl("http://10.0.11.78:3000/")
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .client(clientSetup)
            .build()
            .create(SearchAPI::class.java)
    }
}