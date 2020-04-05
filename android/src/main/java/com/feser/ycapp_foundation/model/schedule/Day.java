package com.feser.ycapp_foundation.model.schedule;

import android.annotation.SuppressLint;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressLint("UseSparseArrays")
public class Day {
	private Map<Integer, Slot> slotMap;
	private int day;

	public Day() {
		slotMap = new HashMap<>();
		for (int i = 1; i <= 4; i++) {
			slotMap.put(i, new Slot("TBA"));
		}
	}

	Day(int day) {
		this(new ArrayList<>(), day);
	}

	private Day(List<Slot> slots, int day) {
		slotMap = new HashMap<>();
		/*for (int i = 1; i <= 4; i++) {
			slotMap.put(i, new Slot("TBA"));
		}
		this.day = day;
		for (Slot slot : slots) {
			add(slot);
		}*/
	}

	public void add(Slot slot) {
		this.slotMap.put(slot.getSlot(), slot);
		/*if (slot.getLength() > 1) {
			for (int i = slot.getSlot() + 1; i < slot.getSlot() + slot.getLength(); i++) {
				slotMap.put(i, new Slot(""));
			}
		}*/
	}


	public List<Slot> getSlots() {
		List<Slot> list = new ArrayList<>();
		for (Map.Entry<Integer, Slot> entry : slotMap.entrySet()) {
			list.add(entry.getValue());
		}
		return list;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getLength() {
		return slotMap.size();
	}

	public Slot getSlot(int slot) {
		return slotMap.get(slot);
	}

}
