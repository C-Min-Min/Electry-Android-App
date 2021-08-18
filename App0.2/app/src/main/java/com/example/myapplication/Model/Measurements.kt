package com.example.myapplication.Model

import java.sql.Timestamp

class Measurements(val Id: Int, val consumer_id: Int, val timestamp: Timestamp, val power: Int, val state: Int) {
    companion object{
        fun createList(it:List<Measurements>): ArrayList<Measurements> {
            val List = ArrayList<Measurements>()
            for (measures in it){
                List.add(Measurements(measures.Id, measures.consumer_id, measures.timestamp, measures.power, measures.state))
            }

            return List
        }
    }
}