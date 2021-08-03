package com.example.myapplication.Adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Interface.IDeviceClickListener
import com.example.myapplication.Model.OddDevices
import com.example.myapplication.R


class OddDeviceAdapter(internal var context: Context, internal var OddDeviceList:List<OddDevices>):RecyclerView.Adapter<OddDeviceAdapter.MyViewHolder>() {

    override fun getItemCount(): Int {
        return OddDeviceList.size
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.device_name.text = OddDeviceList[position].DEV_DESC
        if(OddDeviceList[position].DEV_STATE == 1){
            holder.device_state.text = "On"
        }else if(OddDeviceList[position].DEV_STATE == 0){
            holder.device_state.text = "Off"
        }

        holder.setClick(object : IDeviceClickListener{
            override fun onDeviceClick(view: View, position: Int) {
                Toast.makeText(context, ""+OddDeviceList[position].DEV_DESC,Toast.LENGTH_SHORT)
            }
        })
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        val itemView = LayoutInflater.from(context).inflate(R.layout.device_button, parent, false)
        return MyViewHolder(itemView)
    }

    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView),View.OnClickListener {


        internal var root_view:CardView
        internal var device_name:TextView
        internal var device_state:TextView

        internal lateinit var deviceClickListener: IDeviceClickListener

        fun setClick(deviceClickListener: IDeviceClickListener){
            this.deviceClickListener = deviceClickListener
        }

        init{
            root_view = itemView.findViewById(R.id.root_view) as CardView

            device_name = itemView.findViewById(R.id.device_name) as TextView
            device_state = itemView.findViewById(R.id.device_state) as TextView
        }

        override fun onClick(v: View?) {
            deviceClickListener.onDeviceClick(v!!,adapterPosition)
        }

    }



}