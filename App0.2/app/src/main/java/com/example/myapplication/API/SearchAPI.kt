package com.example.myapplication.API

import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.Model.OddDevices
import retrofit2.http.GET


public interface SearchAPI {
    @GET("odd_devices")
    suspend fun getOddDevice():List<OddDevices>

    @GET("even_devices")
    suspend fun getEvenDevice():List<EvenDevices>

    //@get:GET("odd_devices")
    //val OddDevicesList:Observable<List<OddDevices>>

    //@get:GET("even_devices")
    //val EvenDevicesList:Observable<List<EvenDevices>>


}