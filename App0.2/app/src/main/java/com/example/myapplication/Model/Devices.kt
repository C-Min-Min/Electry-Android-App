package com.example.myapplication.Model

import android.util.Log
import kotlinx.coroutines.delay

class Devices(val DEV_ID: Int, val DEV_DESC:String, val DEV_STATE:Int){
    companion object{
        fun createList(it:List<Devices>): ArrayList<Devices> {
            val List = ArrayList<Devices>()
            for (device in it){
                //Log.d("MainActivity", device.DEV_ID.toString())
                //Log.d("MainActivity",device.DEV_DESC.toString())
                //Log.d("MainActivity", device.DEV_STATE.toString())
                List.add(Devices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE))
                Log.d("Devices_before",List.size.toString())

            }

            return List
        }
    }
}

