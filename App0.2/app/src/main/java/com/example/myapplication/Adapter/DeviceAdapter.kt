package com.example.myapplication.Adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Model.Devices
import com.example.myapplication.R

class DeviceAdapter(private var DeviceList:List<Devices>):RecyclerView.Adapter<DeviceAdapter.MyViewHolder>() {

    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView) {
        val device_name = itemView.findViewById(R.id.device_name) as TextView
        val device_state = itemView.findViewById(R.id.device_state) as TextView

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DeviceAdapter.MyViewHolder {
        val itemView = LayoutInflater.from(parent.context)
        val deviceview = itemView.inflate(R.layout.device_button, parent, false)

        return MyViewHolder(deviceview)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        val device : Devices = DeviceList[position]
        val device_name = holder.device_name
        val device_state = holder.device_state
        device_name.text = device.DEV_DESC
        if(device.DEV_STATE == 1){
            device_state.text = "On"
        }else if(device.DEV_STATE == 0){
            device_state.text = "Off"
        }

    }

    override fun getItemCount(): Int {
        return DeviceList.size
    }

}