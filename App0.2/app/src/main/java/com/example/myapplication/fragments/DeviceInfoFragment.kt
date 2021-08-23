package com.example.myapplication.fragments

import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.os.Handler
import android.util.Log
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
import com.example.myapplication.Model.Measurements
import com.example.myapplication.Model.MeasurementsViewModel
import com.example.myapplication.R
import com.github.mikephil.charting.charts.LineChart
import com.github.mikephil.charting.components.AxisBase
import com.github.mikephil.charting.components.XAxis
import com.github.mikephil.charting.data.Entry
import com.github.mikephil.charting.data.LineData
import com.github.mikephil.charting.data.LineDataSet
import com.github.mikephil.charting.formatter.ValueFormatter
import com.google.android.material.button.MaterialButton
import kotlinx.android.synthetic.main.dev_button_for_info.view.*
import kotlinx.android.synthetic.main.fragment_device_info.*
import kotlinx.android.synthetic.main.fragment_device_info.view.*
import kotlinx.android.synthetic.main.icon_dialog_box.*
import kotlinx.android.synthetic.main.name_dialog_box.*
import kotlinx.android.synthetic.main.name_dialog_box.save_change
import kotlinx.coroutines.tasks.await
import com.shrikanthravi.collapsiblecalendarview.data.Day
import com.shrikanthravi.collapsiblecalendarview.widget.CollapsibleCalendar


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
        val linelist: ArrayList<Entry> = ArrayList()
        val xValsDateLabel: ArrayList<String> = ArrayList()
        var searched_measurements: ArrayList<Measurements>
        val MeasureView = ViewModelProvider(this).get(MeasurementsViewModel::class.java)
        var date: String
        var entries: Float = 0F
        var selectedDay: Day = Day(0,0,0)
        var dayString : String

        MeasureView.getMeasurements(position)
        MeasureView.ResponseList.observe(viewLifecycleOwner, {
            searched_measurements = Measurements.createList(it)
            if(searched_measurements.isNotEmpty()){
                val last_date = searched_measurements[searched_measurements.size - 1].timestamp.toString().split(" ")[0]
                selectedDay = Day(last_date.split("-")[0].toInt() ,last_date.split("-")[1].toInt() - 1, last_date.split("-")[2].toInt() )
                Log.i(
                    javaClass.name, "Selected Day: "
                            + selectedDay.year + "/" + (selectedDay.month + 1) + "/" + selectedDay.day
                )
                if (searched_measurements[0].timestamp.toString()
                        .split(" ")[1].split(".")[0] != "00:00:00"
                ) {
                    xValsDateLabel.add("00:00:00")

                    linelist.add(Entry(entries, 0f))
                    entries++
                    linelist.add(Entry(entries, 0f))

                }
                for (measure in 0 until searched_measurements.size) {
                    date = searched_measurements[measure].timestamp.toString().split(" ")[0]
                    if (date == searched_measurements[searched_measurements.size - 1].timestamp.toString().split(" ")[0]) {
                        xValsDateLabel.add(
                            searched_measurements[measure].timestamp.toString()
                                .split(" ")[1].split(".")[0]
                        )

                        linelist.add(Entry(entries, searched_measurements[measure].power.toFloat()))

                        if (searched_measurements[measure].state == 0) {
                            linelist.add(Entry(entries, 0f))
                        }
                        entries++
                        if (measure + 1 != searched_measurements.size) {
                            if (searched_measurements[measure + 1].state == 1) {
                                linelist.add(Entry(entries, 0f))
                            }
                        }
                    }
                }
                linelist.add(Entry(entries, 0f))
                xValsDateLabel.add("24:00:00")
                showChart(linelist, xValsDateLabel, line_chart)
            }

        })

        val collapsibleCalendar: CollapsibleCalendar = view.calendar
        collapsibleCalendar.selectedDay = selectedDay

        collapsibleCalendar.setCalendarListener(object : CollapsibleCalendar.CalendarListener {
            override fun onDaySelect() {
                val day: Day? = collapsibleCalendar.selectedDay
                if (selectedDay != day) {
                    if (day != null) {
                        selectedDay = day
                        Log.i(
                            javaClass.name, "Selected Day: "
                                    + day.year + "/" + (day.month + 1) + "/" + day.day
                        )
                        if(day.month + 1 >= 10){
                            dayString = day.year.toString() + "-" + (day.month + 1).toString() + "-" + day.day.toString()
                        }else {
                            dayString = day.year.toString() + "-0" + (day.month + 1).toString() + "-" + day.day.toString()
                        }
                        xValsDateLabel.clear()
                        linelist.clear()
                        MeasureView.ResponseList.observe(viewLifecycleOwner, {
                            searched_measurements = Measurements.createList(it)
                            if(searched_measurements.isNotEmpty()){
                                val last_date = searched_measurements[searched_measurements.size - 1].timestamp.toString().split(" ")[0]
                                selectedDay = Day(last_date.split("-")[0].toInt() ,last_date.split("-")[1].toInt() - 1, last_date.split("-")[2].toInt() )
                                Log.i(
                                    javaClass.name, "Selected Day: "
                                            + selectedDay.year + "/" + (selectedDay.month + 1) + "/" + selectedDay.day
                                )
                                if (searched_measurements[0].timestamp.toString()
                                        .split(" ")[1].split(".")[0] != "00:00:00"
                                ) {
                                    xValsDateLabel.add("00:00:00")

                                    linelist.add(Entry(entries, 0f))
                                    entries++
                                    linelist.add(Entry(entries, 0f))

                                }
                                for (measure in 0 until searched_measurements.size) {
                                    date = searched_measurements[measure].timestamp.toString().split(" ")[0]
                                    if (date == dayString) {
                                        Log.d("Passed", "Passed")
                                        xValsDateLabel.add(
                                            searched_measurements[measure].timestamp.toString()
                                                .split(" ")[1].split(".")[0]
                                        )

                                        linelist.add(Entry(entries, searched_measurements[measure].power.toFloat()))

                                        if (searched_measurements[measure].state == 0) {
                                            linelist.add(Entry(entries, 0f))
                                        }
                                        entries++
                                        if (measure + 1 != searched_measurements.size) {
                                            if (searched_measurements[measure + 1].state == 1) {
                                                linelist.add(Entry(entries, 0f))
                                            }
                                        }
                                    }
                                }
                                linelist.add(Entry(entries, 0f))
                                xValsDateLabel.add("24:00:00")
                                showChart(linelist, xValsDateLabel, line_chart)
                            }

                        })
                    }
                }
            }

            override fun onItemClick(v: View) {}
            override fun onClickListener() {}

            override fun onDataUpdate() {}
            override fun onDayChanged() {}

            override fun onMonthChange() {}
            override fun onWeekChange(position: Int) {}
        })

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

    fun showChart(linelist: ArrayList<Entry>, xValsDateLabel: ArrayList<String>, line_chart: LineChart){
        val lineDataSet = LineDataSet(linelist, "Watts")
        val lineData = LineData(lineDataSet)
        line_chart.data = lineData
        line_chart.legend.isEnabled = false
        line_chart.axisRight.isEnabled = false
        lineDataSet.setColors(Color.GRAY)
        lineDataSet.valueTextColor = Color.BLUE
        lineDataSet.valueTextSize = 15f
        lineDataSet.lineWidth = 2f
        lineDataSet.color
        val xAxis = line_chart.xAxis
        xAxis.position = XAxis.XAxisPosition.BOTTOM
        xAxis.labelCount = 5
        xAxis.granularity = 1f
        xAxis.isGranularityEnabled = true

        xAxis.valueFormatter = (MyValueFormatter(xValsDateLabel))
    }

}