package com.example.myapplication.fragments

import android.content.Context
import android.os.Bundle
import android.os.Handler
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.myapplication.API.SearchAPI
import com.example.myapplication.Adapter.EvenDeviceAdapter
import com.example.myapplication.Adapter.OddDeviceAdapter
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.EvenDevices
import com.example.myapplication.Model.OddDevices
import com.example.myapplication.R
import io.reactivex.disposables.CompositeDisposable
import kotlinx.coroutines.delay


class DevicesFragment : Fragment() {


    //override fun onStop(){
    //    compositeDisposable.clear()
    //    super.onStop()
    //}
    //lateinit var thiscontext: Context
    //internal lateinit var myAPI: SearchAPI
    //internal var compositeDisposable = CompositeDisposable()

    internal lateinit var OddAdapter: OddDeviceAdapter
    internal lateinit var EvenAdapter: EvenDeviceAdapter
    lateinit var odd_list:RecyclerView
    lateinit var even_list:RecyclerView



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {


        }
    }



    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        /*thiscontext = requireContext()
        //Init API

        myAPI = api;
        odd_list = view.findViewById(R.id.odd_list)
        even_list = view.findViewById(R.id.even_list)
        getAllDevices()

        even_list.setHasFixedSize(true)
        odd_list.setHasFixedSize(true)
        even_list.layoutManager = LinearLayoutManager(view.context)
        odd_list.layoutManager = LinearLayoutManager(view.context)*/
        var OddList:ArrayList<OddDevices> = ArrayList()
        var EvenList:ArrayList<EvenDevices> = ArrayList()
        val view:View = inflater.inflate(R.layout.fragment_devices,container,false)
        odd_list = view.findViewById(R.id.odd_list)
        even_list = view.findViewById(R.id.even_list)
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.getOddDevice()
        viewModel.OddResponseList.observe(viewLifecycleOwner, Observer {
            OddList = OddDevices.createOddList(it)
        })
        Log.d("Devices_after",OddList.size.toString())
        viewModel.getEvenDevice()
        viewModel.EvenResponseList.observe(viewLifecycleOwner, Observer {
            EvenList = EvenDevices.createEvenList(it)
        })
        Handler().postDelayed({
            OddAdapter = OddDeviceAdapter(OddList)
            EvenAdapter = EvenDeviceAdapter(EvenList)

            even_list.layoutManager = LinearLayoutManager(view.context)
            odd_list.layoutManager = LinearLayoutManager(view.context)
            even_list.adapter = EvenAdapter
            odd_list.adapter = OddAdapter


        },90)
        return view
    }

}