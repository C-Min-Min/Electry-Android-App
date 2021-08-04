package com.example.myapplication.Adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Model.OddDevices
import com.example.myapplication.R

class OddDeviceAdapter(private var OddDeviceList:List<OddDevices>):RecyclerView.Adapter<OddDeviceAdapter.MyViewHolder>() {

    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView) {
        val device_name = itemView.findViewById(R.id.device_name) as TextView
        val device_state = itemView.findViewById(R.id.device_state) as TextView

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): OddDeviceAdapter.MyViewHolder {
        val itemView = LayoutInflater.from(parent.context)
        val deviceview = itemView.inflate(R.layout.device_button, parent, false)

        return MyViewHolder(deviceview)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        val odd_device : OddDevices = OddDeviceList[position]
        val device_name = holder.device_name
        val device_state = holder.device_state
        device_name.text = odd_device.DEV_DESC
        //holder.device_name.text = OddDeviceList[position].DEV_DESC
        if(odd_device.DEV_STATE == 1){
            device_state.text = "On"
        }else if(odd_device.DEV_STATE == 0){
            device_state.text = "Off"
        }

    }

    override fun getItemCount(): Int {
        return OddDeviceList.size
    }

}