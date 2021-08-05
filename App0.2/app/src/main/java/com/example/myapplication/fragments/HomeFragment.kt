package com.example.myapplication.fragments

import android.os.Bundle
import android.os.Handler
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Adapter
import android.widget.GridLayout
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.Adapter.DeviceAdapter
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R

class HomeFragment : Fragment() {

    private lateinit var OnAdapter: DeviceAdapter
    private lateinit var FavsAdapter: DeviceAdapter
    lateinit var on_list:RecyclerView
    lateinit var favs_list:RecyclerView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        var OnList:ArrayList<Devices> = ArrayList()
        var FavsList:ArrayList<Devices> = ArrayList()
        val view:View = inflater.inflate(R.layout.fragment_home, container, false)
        on_list = view.findViewById(R.id.on_list)
        favs_list = view.findViewById(R.id.favs_list)
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.getDevice()
        viewModel.ResponseList.observe(viewLifecycleOwner, {
            OnList = Devices.createOnList(it)
            FavsList = Devices.createFavsList(it)
        })
        Handler().postDelayed({
            OnAdapter = DeviceAdapter(OnList)
            FavsAdapter = DeviceAdapter(FavsList)
            on_list.layoutManager = GridLayoutManager(view.context,2)
            favs_list.layoutManager = GridLayoutManager(view.context,2)
            on_list.adapter = OnAdapter
            favs_list.adapter = FavsAdapter
        }, 120)
        return view
    }

}