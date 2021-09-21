package com.example.myapplication.API

import com.example.myapplication.Model.Devices
import com.example.myapplication.Model.Measurements
import retrofit2.http.*


interface SearchAPI {
    @GET("devices")
    suspend fun getDevice():List<Devices>

    @FormUrlEncoded
    @POST("search")
    suspend fun searchDevice(@Field("search") Id: Int):List<Devices>

    @FormUrlEncoded
    @POST("edit")
    suspend fun updateDevice(@Field("id") Id: Int, @Field("change_set") Change: String, @Field("dev_x") Dev: String)

    @FormUrlEncoded
    @POST("delete")
    suspend fun deleteDevice(@Field("id") Id: Int)

    @FormUrlEncoded
    @POST("measurements")
    suspend fun getMeasurements(@Field("id") Id: Int):List<Measurements>
}