package com.example.myapplication.Model

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.myapplication.API.RetrofitClient
import kotlinx.coroutines.launch

class DeviceViewModel : ViewModel() {

    val ResponseList: MutableLiveData<List<Devices>> = MutableLiveData()

    fun getDevice() {
        viewModelScope.launch {
            ResponseList.value = RetrofitClient.retrofit.getDevice()
        }
    }

    fun searchDevice(Id: Int) {
        viewModelScope.launch {
            ResponseList.value = RetrofitClient.retrofit.searchDevice(Id)
        }
    }

    fun updateDevice(Id: Int, Change: String, Dev: String) {
        viewModelScope.launch {
            RetrofitClient.retrofit.updateDevice(Id, Change, Dev)
        }
    }

    fun deleteDevice(Id: Int){
        viewModelScope.launch {
            RetrofitClient.retrofit.deleteDevice(Id)
        }
    }
}