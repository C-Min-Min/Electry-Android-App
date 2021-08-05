package com.example.myapplication.API

import com.example.myapplication.Model.Devices
import retrofit2.http.GET


public interface SearchAPI {
    @GET("devices")
    suspend fun getDevice():List<Devices>

}