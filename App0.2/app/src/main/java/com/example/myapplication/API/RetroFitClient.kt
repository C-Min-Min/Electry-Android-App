package com.example.myapplication.API

import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
object RetroFitClient {
    private var instance:Retrofit?=null

    fun getInstance():Retrofit{
        if(instance == null)
                instance = Retrofit.Builder().baseUrl("http://127.0.0.1:3000/Devices")
                    .addConverterFactory(GsonConverterFactory.create())
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    .build()
        return instance!!
    }
}