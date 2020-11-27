package com.feser.ycapp_foundation.model.notification;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.feser.ycapp_foundation.prefs.Prefs;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.google.gson.stream.JsonReader;

import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

public class YoutubeNotification {

    private final String TAG = "YoutubeNotification";

    private String id;
    private String channelId;
    private String channelName;
    private String videoId;
    private String videoTitle;
    private Date date;
    private Date publishedAt;
    private String creatorNames;

    private String keyString;
    private List<String> creatorKeys;
    private List<String> creatorNamesList;
    private List<YoutubeCreator> creatorList;
    private String creatorListString;

    private String duration;

    public YoutubeNotification(Map<String, String> map) {
        this.id = map.get("id");
        this.channelId = map.get("channelId");
        this.channelName = map.get("channelName");
        this.videoId = map.get("videoId");
        this.videoTitle = map.get("videoTitle");
        this.date = new Date();
        date.setTime(Long.parseLong(map.get("date")));
        this.publishedAt = new Date();
        publishedAt.setTime(Long.parseLong(map.get("publishedMills")));
        if (map.containsKey("creatorNames")) {
            this.creatorNames = map.get("creatorNames");
            Log.d(TAG, "creatorNames: " + creatorNames);
            if (creatorNames != null) {
                String[] a = creatorNames.split(",");
                this.creatorNamesList = new ArrayList<>(Arrays.asList(a));
            }
        } else if (map.containsKey("creatorName")) {
            this.creatorNames = map.get("creatorName");
            Log.d(TAG, "creatorName: " + creatorNames);
            if (creatorNames != null) {
                String[] a = creatorNames.split(",");
                this.creatorNamesList = new ArrayList<>(Arrays.asList(a));
            }
        }
        if (map.containsKey("creatorKeys")) {
            keyString = map.get("creatorKeys");
            Log.d(TAG, "keyString: " + keyString);
            if (keyString != null) {
                String[] keyArray = keyString.split(",");
                this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
            }
        } else if (map.containsKey("creatorKey")) {
            keyString = map.get("creatorKey");
            Log.d(TAG, "keyString: " + keyString);
            if (keyString != null) {
                String[] keyArray = keyString.split(",");
                this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
            }
        }
        creatorList = new ArrayList<>();

        if (creatorNamesList != null && creatorKeys != null) {
            Log.d(TAG, "creatorNamesList != null && creatorKeys != null");
            if (creatorNamesList.size() == creatorKeys.size()) {
                Log.d(TAG, "creatorNamesList.size() == creatorKeys.size()");
                for (int i = 0; i < creatorKeys.size(); i++) {
                    String n = creatorNamesList.get(i);
                    String k = creatorKeys.get(i);
                    YoutubeCreator c = new YoutubeCreator(k, n);
                    Log.d(TAG, c.name + " | " + c.key);
                    creatorList.add(c);
                }
            }
        } else if (map.containsKey("creator")) {
            creatorListString = map.get("creator");
            Log.d(TAG, "creatorListString: " + creatorListString);
            String[] l = creatorListString.replace("[", "").replace("]", "")
                    .replace("},{", "};{")
                    .split(";");
            List<YoutubeCreator> list = new ArrayList<>();
            Log.d(TAG, "l array: " + l);
            for (String s : l) {
                String[] a =
                        s.replace("{", "").replace("}", "")
                                .replace("'", "")
                                .replace("\"", "")
                                .replace("name:", "")
                                .replace("key:", "")
                                .split(",");
                Log.d(TAG, "s array: " + s);
                if (a.length == 2) {
                    YoutubeCreator c = new YoutubeCreator();
                    if (a[0].startsWith("-")) {
                        c.key = a[0];
                        c.name = a[1];
                    } else {
                        c.key = a[1];
                        c.name = a[0];
                    }
                    Log.d(TAG, c.name + " | " + c.key);
                    list.add(c);
                }
            }
            Log.d(TAG, "size: " + list.size());
            for (YoutubeCreator c : list) {
                Log.d(TAG, c.name + " | " + c.key);
            }
            this.creatorList = list;
        } else {
            Log.d(TAG, "No Creator map");
        }

        if (map.containsKey("duration")) {
            duration = map.get("duration");
        }
    }


    public String getId() {
        return id;
    }

    public String getChannelId() {
        return channelId;
    }

    public String getChannelName() {
        return channelName;
    }

    public String getVideoId() {
        return videoId;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public Date getDate() {
        return date;
    }

    public Date getPublishedAt() {
        return publishedAt;
    }

    public String getCreatorListString() {
        return creatorListString;
    }

    public String getKeyString() {
        return keyString;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getDuration() {
        return duration;
    }

    public String formateDate() {
        @SuppressLint("SimpleDateFormat")
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
        return sdf.format(getPublishedAt());
    }

    public String formateNow() {
        @SuppressLint("SimpleDateFormat")
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
        return sdf.format(new Date());
    }

    public String getCreatorNames() {
        return creatorNames;
    }

    public List<String> getCreatorKeys() {
        return creatorKeys;
    }

    public List<YoutubeCreator> getCreatorList() {
        return creatorList;
    }

    public String getCreatorNameText(Context context) {
        if (getCreatorList().isEmpty()) {
            return "";
        }
        Prefs prefs = new Prefs(context);
        List<String> creator = prefs.getCreator();
        if (creator.isEmpty()) {
            return "";
        }
        String p = prefs.getString("youtube_notification_wiitv", "sub");
        Log.d(TAG, p);
        Log.d(TAG, creator.toString());
        prefs.destroy();
        StringBuilder s = new StringBuilder();
        List<String> names = new ArrayList<>();
        Log.d(TAG, "p.equals(\"sub\"): " + p.equals("sub"));

        for (YoutubeCreator c : getCreatorList()) {
            Log.d(TAG, "creator.contains(" + c.key + "): " + (creator.contains(c.key)));
            if (p.equals("all") || (p.equals("sub") && creator.contains(c.key))) {
                names.add(c.name);
            }
        }
        Log.d(TAG, names.toString());
        s.append("\nWith ");
        int n = names.size();
        if (n == 0) {
            return "";
        }
        boolean useAndMore = n < creatorList.size() && p.equals("all");
        for (int i = 0; i < n; i++) {
            s.append(names.get(i));
            if (i == n - 2 && !useAndMore) {
                s.append(" and ");
            } else if (i < n - 1) {
                s.append(", ");
            }
        }
        if (useAndMore) {
            s.append(" and more!");
        }
        return s.toString();
    }

    public int getNotificationId() {
        if (getPublishedAt() != null) {
            return (int) (((getDate().getTime() / 1000) + (getPublishedAt().getTime() / 1000)) / 2);
        } else {
            return (int) (((getDate().getTime() / 1000)));
        }
    }

    public String getChannelNameLog() {
        return channelName.substring(0, Math.min(30, channelName.length()));
    }

    public String getVideoTitleLog() {
        return videoTitle.substring(0, Math.min(30, videoTitle.length()));
    }

    public boolean isCollab() {
        if (getCreatorNames() == null) {
            return false;
        }
        if (getChannelName().isEmpty()) {
            return false;
        }
        if (getCreatorKeys() == null) {
            return false;
        }
        if (getCreatorKeys().isEmpty()) {
            return false;
        }
        return true;
    }


    public class YoutubeCreator {
        String key;
        String name;

        public YoutubeCreator() {
        }

        public YoutubeCreator(String key, String name) {
            this.key = key;
            this.name = name;
        }
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setPublishedAt(Date publishedAt) {
        this.publishedAt = publishedAt;
    }

    public void setCreatorNames(String creatorNames) {
        this.creatorNames = creatorNames;
    }

    public void setKeyString(String keyString) {
        this.keyString = keyString;
    }

    public void setCreatorKeys(List<String> creatorKeys) {
        this.creatorKeys = creatorKeys;
    }

    public void setCreatorList(List<YoutubeCreator> creatorList) {
        this.creatorList = creatorList;
    }

    public void setCreatorListString(String creatorListString) {
        this.creatorListString = creatorListString;
    }
}
