package com.example.myapplication.API

import com.example.myapplication.Model.Devices
import retrofit2.http.*


interface SearchAPI {
    @GET("devices")
    suspend fun getDevice():List<Devices>

    @FormUrlEncoded
    @POST("search")
    suspend fun searchDevice(@Field("search") Id: Int):List<Devices>

    @FormUrlEncoded
    @POST("update")
    suspend fun updateDevice(@Field("id") Id: Int, @Field("fav") Fav: Int, @Field("desc") Desc: String)
}