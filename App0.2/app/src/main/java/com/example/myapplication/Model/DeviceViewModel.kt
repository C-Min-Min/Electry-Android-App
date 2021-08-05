package com.example.myapplication.Model

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
}