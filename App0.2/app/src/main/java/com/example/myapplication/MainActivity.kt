package com.example.myapplication

import android.app.ActionBar
import android.app.Activity
import android.app.Dialog
import android.content.Context
import android.content.SharedPreferences
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.Toast
import androidx.core.content.ContextCompat
import com.example.myapplication.fragments.*
import androidx.fragment.app.Fragment
import com.google.android.material.button.MaterialButton
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.name_dialog_box.*

class MainActivity : AppCompatActivity() {

    public val preferences : SharedPreferences = getSharedPreferences( "sharedPrefs", Context.MODE_PRIVATE )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val actionBar: androidx.appcompat.app.ActionBar? = supportActionBar
        actionBar?.hide()


        val savedIP : String = loadData().toString()
        if (savedIP == "null"){
            showDialog(this, savedIP)
        }


        val homeFragment = HomeFragment()
        val devicesFragment = DevicesFragment()
        val historyFragment = HistoryFragment()
        val notifsFragment = NotifsFragment()
        val settingsFragment = SettingsFragment()

        makeCurrentFragment(homeFragment)

        bottom_navigation.setOnNavigationItemSelectedListener {
            when (it.itemId){
                R.id.ic_home -> makeCurrentFragment(homeFragment)
                R.id.ic_devices -> makeCurrentFragment(devicesFragment)
                R.id.ic_history -> makeCurrentFragment(historyFragment)
                R.id.ic_notifs -> makeCurrentFragment(notifsFragment)
                R.id.ic_settings -> makeCurrentFragment(settingsFragment)
            }
            true
        }


    }

    private fun makeCurrentFragment(fragment: Fragment) =
        supportFragmentManager.beginTransaction().apply {
            replace(R.id.fl_wrapper, fragment)
            commit()
        }

    private fun saveData(inserted_text: String) {

        val sharedPreferences = getSharedPreferences("sharedPrefs", Context.MODE_PRIVATE)
        val editor = sharedPreferences.edit()
        editor.apply{
            putString("STRING_KEY", inserted_text)
        }.apply()

        Toast.makeText(this, "DATA SAVED", Toast.LENGTH_SHORT).show()

    }

    private fun loadData() : String?{
        val sharedPreferences = getSharedPreferences("sharedPrefs", Context.MODE_PRIVATE)
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