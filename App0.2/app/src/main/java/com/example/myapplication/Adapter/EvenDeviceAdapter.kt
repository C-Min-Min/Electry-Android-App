package com.example.myapplication.Adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.Model.OddDevices
import com.example.myapplication.R

class EvenDeviceAdapter(private var EvenDeviceList:List<EvenDevices>): RecyclerView.Adapter<EvenDeviceAdapter.MyViewHolder>() {
    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView) {

        val device_name = itemView.findViewById(R.id.device_name) as TextView
        val device_state = itemView.findViewById(R.id.device_state) as TextView

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): EvenDeviceAdapter.MyViewHolder {
        val itemView = LayoutInflater.from(parent.context)
        val deviceview = itemView.inflate(R.layout.device_button, parent, false)

        return MyViewHolder(deviceview)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        val even_device : EvenDevices = EvenDeviceList[position]
        val device_name = holder.device_name
        val device_state = holder.device_state
        device_name.text = even_device.DEV_DESC
        //holder.device_name.text = OddDeviceList[position].DEV_DESC
        if(even_device.DEV_STATE == 1){
            device_state.text = "On"
        }else if(even_device.DEV_STATE == 0){
            device_state.text = "Off"
        }

    }

    override fun getItemCount(): Int {
        return EvenDeviceList.size
    }


}