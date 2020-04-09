package com.feser.ycapp_foundation.model.schedule;


import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Color;
import android.util.Log;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Map;
import java.util.TimeZone;
import com.feser.ycapp_foundation.prefs.Prefs;
import static java.text.DateFormat.SHORT;

public class Slot {

    private String color;
    private String border;
    private int day;
    private int hour;
    private int length;
    private int min;
    private int slot;
    private String subTitle;
    private String title;
    private Date lastUpdate;
    private int height;
    private boolean isFeaturedStream;
    private final String[] greys = new String[]{
            "FAFAFA",
            "F5F5F5",
            "EEEEEE",
            "E0E0E0",
            "D6D6D6",
            "BDBDBD",
            "9E9E9E",
            "757575",
            "616161",
            "424242",
            "303030",
            "212121",
    };
    private final String[] blues = new String[]{
            "62bdff",
            "4eb5ff",
            "3badff",
            "27a4ff",
            "149cff",
            "0094ff",
            "0089eb",
            "007dd8",
            "0072c4",
            "0066b1",
    };
    private final String[] orange = new String[]{
            "ffba92",
            "ffad7e",
            "ffa16b",
            "ff9457",
            "ff8844",
            "ff7b30",
            "ff6e1c",
            "ff6209",
            "f45800",
            "e15100",
    };

    public Slot(String title) {
        this.title = title;
        this.length = 3;
    }


    public Slot(Map<String, Object> map) {
        Object c = map.get("color");
        if (c instanceof String) {
            color = (String) c;
        } else {
            color = "2752ae";
        }
        if (map.containsKey("border")) {
            Object b = map.get("border");

            Log.d("Slot", "has border");
            if (b instanceof String) {
                Log.d("Slot", "border: " + b);
                border = (String) b;
            } else {
                border = "2752ae";
            }
        }

        if (map.get("day") instanceof Double) {
            day = Double.valueOf((double) map.get("day")).intValue();
        } else {
            day = Long.valueOf((long) map.get("day")).intValue();
        }
        if (map.get("hour") instanceof Double) {
            hour = Double.valueOf((double) map.get("hour")).intValue();
        } else {
            hour = Long.valueOf((long) map.get("hour")).intValue();
        }
        if (map.get("length") instanceof Double) {
            length = Double.valueOf((double) map.get("length")).intValue();
        } else {
            length = Long.valueOf((long) map.get("length")).intValue();
        }
        if (map.containsKey("height")) {
            if (map.get("height") instanceof Double) {
                height = Double.valueOf((double) map.get("height")).intValue();
            } else {
                height = Long.valueOf((long) map.get("height")).intValue();
            }
        } else {
            height = length * 60;
        }
        if (map.get("min") instanceof Double) {
            min = Double.valueOf((double) map.get("min")).intValue();
        } else {
            min = Long.valueOf((long) map.get("min")).intValue();
        }
        if (map.get("slot") instanceof Double) {
            slot = Double.valueOf((double) map.get("slot")).intValue();
        } else {
            slot = Long.valueOf((long) map.get("slot")).intValue();
        }
        subTitle = (String) map.get("subTitle");
        title = (String) map.get("title");
        Map<String, Object> time = (Map<String, Object>) map.get("lastUpdate");
        long s;
        if (time.get("_seconds") instanceof Double) {
            s = Double.valueOf((double) time.get("_seconds")).longValue();
        } else {
            s = (long) time.get("_seconds");
        }
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(s * 1000);
        lastUpdate = calendar.getTime();

        if (map.containsKey("featuredStream")) {
            isFeaturedStream = map.get("featuredStream") != null;
        } else {
            isFeaturedStream = false;
        }
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    private int colorInt() {
        return isFeaturedStream ? 0 :

                day % 2 == 0
                        ? 4
                        : 6;
        //((day + (2 * day)) % 7) + 2;
    }

    public int getColorValue(Context context) {
        Prefs prefs = new Prefs(context);
        String theme = prefs.getString("scheduleWidgetTheme", "yogs");
        prefs.destroy();
        int c = colorInt(); //Math.max(100, Math.min((((slot + (day * slot)) % 6) * 200), 900)) / 100;
        switch (theme) {
            case "blue":
                return Color.parseColor("#" + blues[c]);
            case "orange":
                return Color.parseColor("#" + orange[c]);
            case "dark":
                return darkenColor(Color.parseColor("#" + greys[c]), 0.3f);
            case "grey":
                return darkenColor(Color.parseColor("#" + greys[c]), 0.6f);
            default:
                String s = getColor().trim();
                if (s.length() > 8 || s.length() < 6 || s.length() == 7) {
                    s = "0094ff";
                } else if (s.length() == 8) {
                    s = s.substring(2);
                }
                return Color.parseColor("#" + s);
        }

    }

    public int getSlotBorderColor(Context context) {
        Prefs prefs = new Prefs(context);
        String theme = prefs.getString("scheduleWidgetTheme", "yogs");
        prefs.destroy();
        int c = colorInt();
        switch (theme) {
            case "blue":
                return Color.parseColor("#" + blues[c]);
            case "orange":
                return Color.parseColor("#" + orange[c]);
            case "dark":
                return darkenColor(Color.parseColor("#" + greys[c]), 0.3f);
            case "grey":
                return darkenColor(Color.parseColor("#" + greys[c]), 0.6f);
            default:
                if (border == null) {
                    return getColorValue(context);
                } else {
                    return Color.parseColor("#" + border);
                }
        }
    }

    public void setBorder(String border) {
        this.border = border;
    }

    private static int darkenColor(int color, float f) {
        float[] hsv = new float[3];
        Color.colorToHSV(color, hsv);
        hsv[2] *= f;
        return Color.HSVToColor(hsv);
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getLength() {
        return length / 3;
    }

    public int getALength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getHeight() {
        return height;
    }

    public int getMin() {
        return min;
    }

    public void setMin(int min) {
        this.min = min;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public boolean isFeaturedStream() {
        return isFeaturedStream;
    }

    public void setFeaturedStream(boolean featuredStream) {
        isFeaturedStream = featuredStream;
    }

    @SuppressLint("SimpleDateFormat")
    public String getTime() {
        Calendar cal = Calendar.getInstance();
        cal.setTimeZone(TimeZone.getTimeZone("Europe/London"));
        cal.set(Calendar.HOUR_OF_DAY, hour);
        cal.set(Calendar.MINUTE, min);

        Calendar localTime = new GregorianCalendar(TimeZone.getDefault());
        localTime.setTimeInMillis(cal.getTimeInMillis());
        
        return SimpleDateFormat.getTimeInstance(SHORT).format(localTime.getTime());
    }

}
