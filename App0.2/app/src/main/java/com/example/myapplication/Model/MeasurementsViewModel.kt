package com.example.myapplication.Model

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.myapplication.API.RetrofitClient
import kotlinx.coroutines.launch

class MeasurementsViewModel: ViewModel() {

    val ResponseList: MutableLiveData<List<Measurements>> = MutableLiveData()

    fun getMeasurements(Id: Int) {
        viewModelScope.launch {
            ResponseList.value = RetrofitClient.retrofit.getMeasurements("measurements",Id)
        }
    }
}