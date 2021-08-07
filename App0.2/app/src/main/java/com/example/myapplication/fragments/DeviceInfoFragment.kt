package com.example.myapplication.fragments

import android.bluetooth.BluetoothClass
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.widget.SwitchCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R
import com.google.android.material.textfield.TextInputEditText
import kotlinx.android.synthetic.main.fragment_device_info.view.*

class DeviceInfoFragment(Id: Int) : Fragment() {
    val position = Id
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        var searched_device : ArrayList<Devices> = ArrayList()
        val view:View = inflater.inflate(R.layout.fragment_device_info,container,false)
        val Dev_desc: TextInputEditText = view.findViewById(R.id.DEV_DESC)
        val Dev_fav: SwitchCompat = view.findViewById(R.id.DEV_FAV)
        val Dev_id: TextView = view.findViewById(R.id.DEV_ID)
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.searchDevice(position)
        viewModel.ResponseList.observe(viewLifecycleOwner, {
            searched_device = Devices.createList(it)
        })
        Handler().postDelayed({

            val device: Devices = searched_device[0]
            Log.d("DeviceInfo","Device ID:"+device.DEV_ID.toString())
            Log.d("DeviceInfo", device.DEV_DESC)
            Dev_id.text = "Device ID:"+device.DEV_ID.toString()
            Dev_fav.isChecked = device.DEV_FAV == 1
            Dev_desc.setText(device.DEV_DESC)
        },120)

        view.change_dev.setOnClickListener {
            val dev_desc: TextInputEditText = view.findViewById(R.id.DEV_DESC)
            val dev_fav: SwitchCompat = view.findViewById(R.id.DEV_FAV)
            val dev_id: Int = searched_device[0].DEV_ID
            var New_fav: Int = 0
            val New_desc = dev_desc.text.toString()
            New_fav = if (dev_fav.isChecked){ 1 }else{ 0 }
            viewModel.updateDevice(dev_id, New_fav, New_desc)
        }

        return view
    }
}