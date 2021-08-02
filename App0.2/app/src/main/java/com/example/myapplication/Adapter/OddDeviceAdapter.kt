package com.example.myapplication.Adapter

import android.content.Context
import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Model.OddDevices


class OddDeviceAdapter(internal var context: Context, internal var OddDeviceList:List<OddDevices>): RecyclerView.Adapter<OddDeviceAdapter.MyViewHolder> {

    inner class MyViewHolder(itemView:View):RecyclerView.ViewHolder(itemView),View.OnClickListener {


        internal var name: TextView

        override fun onClick(v: View?) {
            TODO("Not yet implemented")
        }

    }

}