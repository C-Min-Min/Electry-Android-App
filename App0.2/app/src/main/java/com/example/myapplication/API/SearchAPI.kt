package com.example.myapplication.API

import com.example.myapplication.Model.Devices
import com.example.myapplication.Model.Measurements
import retrofit2.http.*


interface SearchAPI {
    @FormUrlEncoded
    @POST("devices")
    suspend fun getDevice(@Field("sub_api") Sub_Api : String):List<Devices>
    @FormUrlEncoded
    @POST("devices")
    suspend fun searchDevice(@Field("sub_api") Sub_Api : String, @Field("search") Id: Int):List<Devices>
    @FormUrlEncoded
    @POST("devices")
    suspend fun updateDevice(@Field("sub_api") Sub_Api : String, @Field("id") Id: Int, @Field("change_set") Change: String, @Field("dev_x") Dev: String)
    @FormUrlEncoded
    @POST("devices")
    suspend fun deleteDevice(@Field("sub_api") Sub_Api : String, @Field("id") Id: Int)
    @FormUrlEncoded
    @POST("devices")
    suspend fun getMeasurements(@Field("sub_api") Sub_Api : String, @Field("id") Id: Int):List<Measurements>
}