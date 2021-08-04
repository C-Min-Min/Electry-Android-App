package com.example.myapplication.Model

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.myapplication.API.RetrofitClient
import kotlinx.coroutines.launch

class DeviceViewModel : ViewModel() {

    val OddResponseList: MutableLiveData<List<OddDevices>> = MutableLiveData()
    val EvenResponseList: MutableLiveData<List<EvenDevices>> = MutableLiveData()

    fun getOddDevice() {
        viewModelScope.launch {
            OddResponseList.value = RetrofitClient.retrofit.getOddDevice()
        }
    }

    fun getEvenDevice() {
        viewModelScope.launch {
            EvenResponseList.value = RetrofitClient.retrofit.getEvenDevice()
        }
    }
}