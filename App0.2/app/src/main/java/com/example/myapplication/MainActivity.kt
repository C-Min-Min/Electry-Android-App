package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.ViewGroup
import android.widget.TableLayout
import android.widget.TableRow
import androidx.core.content.res.ResourcesCompat
import com.example.myapplication.fragments.*
import androidx.fragment.app.Fragment
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.device_button.*
import kotlinx.android.synthetic.main.fragment_devices.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

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