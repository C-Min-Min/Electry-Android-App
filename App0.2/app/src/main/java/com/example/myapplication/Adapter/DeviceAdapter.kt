package com.example.myapplication.Adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Model.Devices
import com.example.myapplication.R
import kotlinx.android.synthetic.main.device_button.view.*

class DeviceAdapter(private var DeviceList:List<Devices>, private val listener: OnDeviceClickListener):RecyclerView.Adapter<DeviceAdapter.MyViewHolder>() {

    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView), View.OnClickListener {
        val device_name = itemView.device_name
        val device_state = itemView.device_state
        val root_view = itemView.root_view
        val image = itemView.device_icon

        init {
            itemView.setOnClickListener(this)
        }

        override fun onClick(v: View?) {
            val device : Devices = DeviceList[position]
            listener.OnDeviceClick(device.DEV_ID)
        }
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
        device_name.text = device.DEV_NAME
        if(device.DEV_STATE == 1){
            device_state.text = "On"
            holder.root_view.setBackgroundResource(R.drawable.button_on)
        }else if(device.DEV_STATE == 0){
            device_state.text = "Off"
            holder.root_view.setBackgroundResource(R.drawable.button_off)
        }
        if (device.IMAGE_PATH == "ligthbulb"){
            holder.image.setImageResource(R.drawable.lightbulb)
        }else if(device.IMAGE_PATH == "pc"){
            holder.image.setImageResource(R.drawable.pc)
        }else if(device.IMAGE_PATH == "console"){
            holder.image.setImageResource(R.drawable.console)
        }
    }

    override fun getItemCount(): Int {
        return DeviceList.size
    }

    interface OnDeviceClickListener {
        fun OnDeviceClick(position: Int)
    }

}