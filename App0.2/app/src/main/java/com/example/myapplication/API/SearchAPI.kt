package com.example.myapplication.API

import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.Model.OddDevices
import retrofit2.http.GET
import java.util.*


interface SearchAPI {
    @get:GET("odd_devices")
    val OddDevicesList:List<OddDevices>

    @get:GET("even_devices")
    val EvenDevicesList:List<EvenDevices>
}