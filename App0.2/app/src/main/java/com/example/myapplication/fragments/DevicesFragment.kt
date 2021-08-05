package com.example.myapplication.fragments

import android.os.Bundle
import android.os.Handler
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Adapter.DeviceAdapter
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R


class DevicesFragment : Fragment() {

    internal lateinit var Adapter: DeviceAdapter
    lateinit var device_list:RecyclerView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {


        }
    }



    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        var List:ArrayList<Devices> = ArrayList()
        val view:View = inflater.inflate(R.layout.fragment_devices,container,false)
        device_list = view.findViewById(R.id.device_list)
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.getDevice()
        viewModel.ResponseList.observe(viewLifecycleOwner, Observer {
            List = Devices.createList(it)
        })
        Log.d("Devices_after",List.size.toString())
        Handler().postDelayed({
            Adapter = DeviceAdapter(List)
            device_list.layoutManager = GridLayoutManager(view.context,2)
            device_list.adapter = Adapter
        },90)
        return view
    }

}