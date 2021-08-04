package com.example.myapplication.Model

import android.util.Log
import kotlinx.coroutines.delay

class OddDevices(val DEV_ID: Int, val DEV_DESC:String, val DEV_STATE:Int){
    companion object{
        fun createOddList(it:List<OddDevices>): ArrayList<OddDevices> {
            val OddList = ArrayList<OddDevices>()
            for (device in it){
                //Log.d("MainActivity", device.DEV_ID.toString())
                //Log.d("MainActivity",device.DEV_DESC.toString())
                //Log.d("MainActivity", device.DEV_STATE.toString())
                OddList.add(OddDevices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE))
                Log.d("Devices_before",OddList.size.toString())

            }

            return OddList
        }
    }
}
class EvenDevices(val DEV_ID: Int, val DEV_DESC:String, val DEV_STATE:Int){
    companion object{
        fun createEvenList(it:List<EvenDevices>): ArrayList<EvenDevices> {
            val EvenList = ArrayList<EvenDevices>()
            for (device in it){
                //Log.d("MainActivity", device.DEV_ID.toString())
                //Log.d("MainActivity",device.DEV_DESC.toString())
                //Log.d("MainActivity", device.DEV_STATE.toString())
                EvenList.add(EvenDevices(device.DEV_ID,device.DEV_DESC,device.DEV_STATE))

            }

            return EvenList
        }
    }
}
