package com.feser.ycapp_foundation.model.schedule;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Schedule {

    private List<Day> days;
    private Date lastUpdate;


    public Schedule(List<Slot> slots) {
        List<Day> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            days.add(new Day(i));
        }
        this.days = days;
        for (Slot slot : slots) {
            add(slot, slot.getDay());
        }
    }

    public void add(Slot slot, int day) {
        if (this.lastUpdate == null) {
            this.lastUpdate = slot.getLastUpdate();
        } else if (this.lastUpdate.before(slot.getLastUpdate())) {
            this.lastUpdate = slot.getLastUpdate();
        }
        this.days.get(day - 1).add(slot);
    }

    public void add(Day day) {
        if (this.days == null) {
            this.days = new ArrayList<>();
        }
        this.days.add(day);
    }


    public List<Day> getDays() {
        return days;
    }

    public void setDays(List<Day> days) {
        this.days = days;
    }

    public int longestDay() {
        int i = 0;
        for (Day day : days) {
            if (i < day.getLength()) {
                i = day.getLength();
            }
        }
        return i;
    }
}
