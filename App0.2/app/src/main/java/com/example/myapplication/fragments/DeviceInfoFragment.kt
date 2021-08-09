package com.example.myapplication.fragments

import android.bluetooth.BluetoothClass
import android.content.Context
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.SwitchCompat
import androidx.cardview.widget.CardView
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R
import com.google.android.material.textfield.TextInputEditText
import kotlinx.android.synthetic.main.dev_button_for_info.view.*
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
        val inc:View = view.inc_dev
        val Dev_desc: TextView = inc.dev_desc
        val Dev_name: TextView = view.dev_name
        val Dev_state: TextView = inc.dev_state
        val Dev_back: LinearLayout = inc.view_root
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.searchDevice(position)
        viewModel.ResponseList.observe(viewLifecycleOwner, {
            searched_device = Devices.createList(it)
        })
        Handler().postDelayed({

            val device: Devices = searched_device[0]
            Log.d("DeviceInfo",device.DEV_NAME)
            Log.d("DeviceInfo", device.DEV_DESC)
            Dev_name.text = device.DEV_NAME
            Dev_desc.text = device.DEV_DESC
            if (device.DEV_STATE == 1){
                Dev_state.text = "On"
                Dev_back.setBackgroundResource(R.drawable.button_on)
            }else{
                Dev_state.text = "Off"
                Dev_back.setBackgroundResource(R.drawable.button_off)
            }
        },120)

        view.edit_name.setOnClickListener {
            /*val dev_desc: TextInputEditText = view.findViewById(R.id.DEV_DESC)
            val dev_fav: SwitchCompat = view.findViewById(R.id.DEV_FAV)
            val dev_id: Int = searched_device[0].DEV_ID
            var New_fav: Int = 0
            val New_desc = dev_desc.text.toString()
            New_fav = if (dev_fav.isChecked){ 1 }else{ 0 }
            viewModel.updateDevice(dev_id, New_fav, New_desc)*/
            showDialog(view.context)
        }

        return view
    }

    private fun showDialog(context: Context){
        val alertDialog = AlertDialog.Builder(context)
        alertDialog.apply {
            setTitle("Hello")
        }.create().show()
    }
}