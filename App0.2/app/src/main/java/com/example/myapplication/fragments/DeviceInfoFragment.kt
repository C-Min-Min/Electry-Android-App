package com.example.myapplication.fragments

import android.app.Dialog
import android.bluetooth.BluetoothClass
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.SwitchCompat
import androidx.cardview.widget.CardView
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import androidx.lifecycle.ViewModelProvider
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R
import com.google.android.material.button.MaterialButton
import com.google.android.material.textfield.TextInputEditText
import kotlinx.android.synthetic.main.dev_button_for_info.view.*
import kotlinx.android.synthetic.main.fragment_device_info.view.*
import kotlinx.android.synthetic.main.name_dialog_box.*

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
            showDialog(view.context, searched_device[0].DEV_ID, searched_device[0].DEV_NAME, "dev_name")
        }

        view.edit_desc.setOnClickListener {
            showDialog(view.context, searched_device[0].DEV_ID, searched_device[0].DEV_DESC, "dev_desc")
        }

        return view
    }

    private fun showDialog(context: Context, dev_id: Int, original: String, change_set: String){
        val dialog = Dialog(context)
        if (change_set == "dev_name"){
            dialog.setContentView(R.layout.name_dialog_box)
        }else if (change_set == "dev_desc"){
            dialog.setContentView(R.layout.desc_dialog_box)
        }
        val save: MaterialButton = dialog.save_change
        dialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        dialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        dialog.set_change.setText(original)
        save?.setOnClickListener {
            val name_change = dialog.set_change.text.toString()
            val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
            viewModel.updateDevice(dev_id,change_set,name_change)
            dialog.dismiss()
            Handler().postDelayed({
                val fragmentManager: FragmentManager = requireActivity().supportFragmentManager
                val fragmentTransaction: FragmentTransaction = fragmentManager.beginTransaction()
                fragmentTransaction.replace(R.id.fl_wrapper, DeviceInfoFragment(position))
                fragmentTransaction.addToBackStack(null)
                fragmentTransaction.commit()
            },120)

        }
        dialog.show()
    }
}