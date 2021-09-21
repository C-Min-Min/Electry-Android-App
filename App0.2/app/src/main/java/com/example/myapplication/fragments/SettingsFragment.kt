package com.example.myapplication.fragments

import android.app.Dialog
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.content.SharedPreferences
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.example.myapplication.R
import com.google.android.material.button.MaterialButton
import kotlinx.android.synthetic.main.fragment_settings.view.*
import kotlinx.android.synthetic.main.name_dialog_box.*

class SettingsFragment : Fragment() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val view = inflater.inflate(R.layout.fragment_settings, container, false)

        view.edit_db_ip.setOnClickListener {
            val savedIP = loadData().toString()
            showDialog(view.context, savedIP)

        }
        // Inflate the layout for this fragment
        return view
    }

    private fun saveData(inserted_text: String) {

        val sharedPreferences = requireActivity().getSharedPreferences("sharedPrefs", Context.MODE_PRIVATE)
        val editor = sharedPreferences.edit()
        editor.apply{
            putString("STRING_KEY", inserted_text)
        }.apply()

        Toast.makeText(context, "DATA SAVED", Toast.LENGTH_SHORT).show()

    }

    private fun loadData() : String?{
        val sharedPreferences = requireActivity().getSharedPreferences("sharedPrefs", Context.MODE_PRIVATE)
        val savedIP = sharedPreferences.getString("STRING_KEY", null)

        return savedIP
    }

    private fun showDialog(context: Context, original: String) {
        val dialog = Dialog(context)
        dialog.setContentView(R.layout.db_ip_dialog_box)
        val save: MaterialButton = dialog.save_change
        dialog.window?.setLayout(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT
        )
        dialog.window?.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
        dialog.set_change.setText(original)
        save.setOnClickListener {
            val set_change = dialog.set_change.text.toString()
            saveData(set_change)
            dialog.dismiss()
        }
        dialog.show()
    }

}