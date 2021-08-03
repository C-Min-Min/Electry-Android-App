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
import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.R

class EvenDeviceAdapter(internal var context: Context, internal var EvenDeviceList:List<EvenDevices>): RecyclerView.Adapter<EvenDeviceAdapter.MyViewHolder>() {
    inner class MyViewHolder(itemView: View):RecyclerView.ViewHolder(itemView), View.OnClickListener {


        internal var root_view: CardView
        internal var device_name: TextView
        internal var device_state: TextView

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

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): EvenDeviceAdapter.MyViewHolder {
        val itemView = LayoutInflater.from(context).inflate(R.layout.device_button, parent, false)
        return MyViewHolder(itemView)
    }

    override fun getItemCount(): Int {
        return EvenDeviceList.size
    }

    override fun onBindViewHolder(holder: EvenDeviceAdapter.MyViewHolder, position: Int) {
        holder.device_name.text = EvenDeviceList[position].DEV_DESC
        if(EvenDeviceList[position].DEV_STATE == 1){
            holder.device_state.text = "On"
        }else if(EvenDeviceList[position].DEV_STATE == 0){
            holder.device_state.text = "Off"
        }

        holder.setClick(object : IDeviceClickListener{
            override fun onDeviceClick(view: View, position: Int) {
                Toast.makeText(context, ""+EvenDeviceList[position].DEV_DESC, Toast.LENGTH_SHORT)
            }
        })
    }
}