package com.example.myapplication.fragments

import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.os.Handler
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import androidx.lifecycle.ViewModelProvider
import com.example.myapplication.Model.DeviceViewModel
import com.example.myapplication.Model.Devices
import com.example.myapplication.R
import com.github.mikephil.charting.charts.LineChart
import com.github.mikephil.charting.components.AxisBase
import com.github.mikephil.charting.components.XAxis
import com.github.mikephil.charting.data.Entry
import com.github.mikephil.charting.data.LineData
import com.github.mikephil.charting.data.LineDataSet
import com.github.mikephil.charting.formatter.ValueFormatter
import com.github.mikephil.charting.utils.ColorTemplate
import com.google.android.material.button.MaterialButton
import kotlinx.android.synthetic.main.dev_button_for_info.view.*
import kotlinx.android.synthetic.main.fragment_device_info.*
import kotlinx.android.synthetic.main.fragment_device_info.view.*
import kotlinx.android.synthetic.main.icon_dialog_box.*
import kotlinx.android.synthetic.main.name_dialog_box.*
import kotlinx.android.synthetic.main.name_dialog_box.save_change
import java.security.KeyStore

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
        val image: ImageView = inc.dev_icon
        val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
        viewModel.searchDevice(position)
        viewModel.ResponseList.observe(viewLifecycleOwner, {
            searched_device = Devices.createList(it)
            val device: Devices = searched_device[0]
            Dev_name.text = device.DEV_NAME
            Dev_desc.text = device.DEV_DESC
            if (device.DEV_STATE == 1){
                Dev_state.text = "On"
                Dev_back.setBackgroundResource(R.drawable.button_on)
            }else{
                Dev_state.text = "Off"
                Dev_back.setBackgroundResource(R.drawable.button_off)
            }
            if (device.IMAGE_PATH == "ligthbulb"){
                image.setImageResource(R.drawable.lightbulb)
            }else if(device.IMAGE_PATH == "pc"){
                image.setImageResource(R.drawable.pc)
            }else if(device.IMAGE_PATH == "console"){
                image.setImageResource(R.drawable.console)
            }
        })

        view.edit_name.setOnClickListener {
            showDialog(view.context, searched_device[0].DEV_ID, searched_device[0].DEV_NAME, "dev_name")
        }

        view.edit_desc.setOnClickListener {
            showDialog(view.context, searched_device[0].DEV_ID, searched_device[0].DEV_DESC, "dev_desc")
        }

        view.edit_icon.setOnClickListener {
            showDialog(view.context, searched_device[0].DEV_ID, searched_device[0].IMAGE_PATH, "dev_icon")
        }

        view.delete_dev.setOnClickListener {
            viewModel.deleteDevice(position)
            val fragmentManager: FragmentManager = requireActivity().supportFragmentManager
            val fragmentTransaction: FragmentTransaction =
                fragmentManager.beginTransaction()
            fragmentTransaction.replace(R.id.fl_wrapper, HomeFragment())
            fragmentTransaction.addToBackStack(null)
            fragmentTransaction.commit()
        }
        val line_chart : LineChart = view.dev_chart
        val linelist : ArrayList<Entry> = ArrayList()
        linelist.add(Entry(0f,40f))
        linelist.add(Entry(1f,67f))
        linelist.add(Entry(1f,0f))
        linelist.add(Entry(2f,0f))
        linelist.add(Entry(2f,41f))
        linelist.add(Entry(3f,45f))
        linelist.add(Entry(3f,0f))
        linelist.add(Entry(4f,0f))

        val lineDataSet = LineDataSet(linelist, "Watts")
        val lineData = LineData(lineDataSet)
        line_chart.data = lineData
        line_chart.legend.isEnabled = false
        line_chart.axisRight.isEnabled = false
        lineDataSet.setColors(Color.GRAY)
        lineDataSet.valueTextColor = Color.BLUE
        lineDataSet.valueTextSize = 10f

        val xAxis = line_chart.xAxis
        xAxis.position = XAxis.XAxisPosition.BOTTOM
        xAxis.labelCount = 5
        xAxis.granularity = 1f
        xAxis.isGranularityEnabled = true

        val xValsDateLabel = ArrayList<String>()
        xValsDateLabel.add("00:00")
        xValsDateLabel.add("01:40")
        xValsDateLabel.add("19:43")
        xValsDateLabel.add("20:50")
        xValsDateLabel.add("24:00")

        xAxis.valueFormatter = (MyValueFormatter(xValsDateLabel))
        return view
    }

    private fun showDialog(context: Context, dev_id: Int, original: String, change_set: String){
        val dialog = Dialog(context)
        if (change_set == "dev_name"){
            dialog.setContentView(R.layout.name_dialog_box)
        }else if (change_set == "dev_desc"){
            dialog.setContentView(R.layout.desc_dialog_box)
        }else if (change_set == "dev_icon"){
            dialog.setContentView(R.layout.icon_dialog_box)
        }
        val save: MaterialButton = dialog.save_change
        dialog.window?.setLayout(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        dialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        if (change_set == "dev_name" || change_set == "dev_desc") {
            dialog.set_change.setText(original)
            save.setOnClickListener {
                val set_change = dialog.set_change.text.toString()
                val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
                viewModel.updateDevice(dev_id, change_set, set_change)
                dialog.dismiss()
                Handler().postDelayed({
                    val fragmentManager: FragmentManager = requireActivity().supportFragmentManager
                    val fragmentTransaction: FragmentTransaction =
                        fragmentManager.beginTransaction()
                    fragmentTransaction.replace(R.id.fl_wrapper, DeviceInfoFragment(position))
                    fragmentTransaction.addToBackStack(null)
                    fragmentTransaction.commit()
                }, 120)

            }
        }else if (change_set == "dev_icon"){
            val spinner: Spinner = dialog.icon_spinner
            ArrayAdapter.createFromResource(
                context,
                R.array.icon_array,
                android.R.layout.simple_spinner_item
            ).also { adapter ->
                adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                spinner.adapter = adapter
            }
            if (original == "lightbulb"){
                spinner.setSelection(0)
            }else if(original == "pc"){
                spinner.setSelection(1)
            }else if(original == "console"){
                spinner.setSelection(2)
            }
            save.setOnClickListener {
                val image_change: String = spinner.selectedItem.toString()
                val viewModel = ViewModelProvider(this).get(DeviceViewModel::class.java)
                viewModel.updateDevice(dev_id, change_set, image_change)
                dialog.dismiss()
                Handler().postDelayed({
                    val fragmentManager: FragmentManager = requireActivity().supportFragmentManager
                    val fragmentTransaction: FragmentTransaction =
                        fragmentManager.beginTransaction()
                    fragmentTransaction.replace(R.id.fl_wrapper, DeviceInfoFragment(position))
                    fragmentTransaction.addToBackStack(null)
                    fragmentTransaction.commit()
                }, 120)
            }
        }
        dialog.show()
    }

    class MyValueFormatter(private val xValsDateLabel: ArrayList<String>) : ValueFormatter(){

        override fun getFormattedValue(value: Float): String {
            return value.toString()
        }

        override fun getAxisLabel(value: Float, axis: AxisBase?): String {
            if(value.toInt() >= 0 && value.toInt() <= xValsDateLabel.size - 1 ){
                return xValsDateLabel[value.toInt()]
            } else {
                return ("").toString()
            }
        }
    }

}