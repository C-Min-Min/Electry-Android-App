package com.example.myapplication.fragments

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.myapplication.API.RetrofitClient
import com.example.myapplication.API.SearchAPI
import com.example.myapplication.Adapter.OddDeviceAdapter
import com.example.myapplication.R
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.schedulers.Schedulers
import kotlinx.android.synthetic.main.fragment_devices.*

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [DevicesFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class DevicesFragment : Fragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    override fun onStop(){
        compositeDisposable.clear()
        super.onStop()
    }
    lateinit var thiscontext: Context
    internal lateinit var myAPI: SearchAPI
    internal var compositeDisposable = CompositeDisposable()
    internal lateinit var layoutManager: LinearLayoutManager
    internal lateinit var adapter: OddDeviceAdapter

    private val api:SearchAPI
    get() = RetrofitClient.getInstance().create(SearchAPI::class.java)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
            thiscontext = requireContext()
            //Init API
            myAPI = api;
            layoutManager = LinearLayoutManager(thiscontext)
            odd_list.layoutManager = layoutManager
            odd_list.addItemDecoration(DividerItemDecoration(thiscontext, layoutManager.orientation))

            getAllDevices()
        }
    }

    private fun getAllDevices() {
        compositeDisposable.addAll(myAPI.OddDevicesList
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({ devices ->
                adapter = OddDeviceAdapter(thiscontext, devices)
                odd_list.adapter = adapter
            },{
                Toast.makeText(thiscontext, "Not found", Toast.LENGTH_SHORT).show()
            }))
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_devices, container, false)
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment DevicesFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            DevicesFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}