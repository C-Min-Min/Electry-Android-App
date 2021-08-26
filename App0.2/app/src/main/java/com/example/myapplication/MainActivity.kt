package com.example.myapplication

import android.app.ActionBar
import android.app.Activity
import android.content.Context
import android.content.res.Configuration
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.view.WindowManager
import androidx.core.content.ContextCompat
import com.example.myapplication.fragments.*
import androidx.fragment.app.Fragment
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val actionBar: androidx.appcompat.app.ActionBar? = supportActionBar
        actionBar?.hide()

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

}