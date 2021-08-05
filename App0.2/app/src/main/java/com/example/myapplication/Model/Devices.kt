package com.example.myapplication.Model

import android.util.Log
import kotlinx.coroutines.delay

class Devices(val DEV_ID: Int, val DEV_DESC:String, val DEV_STATE:Int, val DEV_FAV:Int){
    companion object{
        fun createList(it:List<Devices>): ArrayList<Devices> {
            val List = ArrayList<Devices>()
            for (device in it){
                List.add(Devices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE,device.DEV_FAV))
            }

            return List
        }
        fun createOnList(it:List<Devices>): ArrayList<Devices> {
            val List = ArrayList<Devices>()
            for (device in it){
                if (device.DEV_STATE == 1){
                    List.add(Devices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE,device.DEV_FAV))
                }
            }

            return List
        }
        fun createFavsList(it:List<Devices>): ArrayList<Devices> {
            val List = ArrayList<Devices>()
            for (device in it){
                if (device.DEV_FAV == 1){
                    List.add(Devices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE,device.DEV_FAV))
                }
            }

            return List
        }
    }
}

