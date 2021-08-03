package com.example.myapplication.API

import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.Model.OddDevices
import io.reactivex.Observable
import retrofit2.http.GET


interface SearchAPI {
    @get:GET("odd_devices")
    val OddDevicesList:Observable<List<OddDevices>>

    @get:GET("even_devices")
    val EvenDevicesList:Observable<List<EvenDevices>>
}