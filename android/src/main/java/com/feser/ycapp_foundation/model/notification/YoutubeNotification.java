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
        if (map.containsKey("creatorName")) {
            this.creatorNames = map.get("creatorNames");
            Log.d(TAG, "creatorNames: " + creatorNames);
        }
        if (map.containsKey("creatorKeys")) {
            keyString = map.get("creatorKeys");
            Log.d(TAG, "keyString: " + keyString);
            if (keyString != null) {
                String[] keyArray = keyString.split(",");
                this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
            }
        }
        creatorList = new ArrayList<>();
        if (map.containsKey("creator")) {
            creatorListString = map.get("creator");
            Log.d(TAG,"creatorListString: "+ creatorListString);
            String[] l = creatorListString.replace("[", "").replace("]", "")
                    .replace("},{", "};{")
                    .split(";");
            List<YoutubeCreator> list = new ArrayList<>();
            for (String s : l) {
                String[] a =
                        s.replace("{", "").replace("}", "")
                                .replace("name:", "")
                                .replace("key:", "")
                                .replace("'", "")
                                .split(",");
                Log.d(TAG, s);

                Log.d(TAG, "" + a.toString());
                YoutubeCreator c = new YoutubeCreator();
                c.name = a[0].replace("name:", "");
                c.key = a[1].replace("key:", "");
                Log.d(TAG, c.name + " | " + c.key);
                list.add(c);
            }
            Log.d(TAG, "size: " + list.size());
            for (YoutubeCreator c : list) {
                Log.d(TAG, c.name + " | " + c.key);
            }
            this.creatorList = list;
        }

        if (map.containsKey("duration")) {
            duration = map.get("duration");
        }
    }

    public YoutubeNotification(Intent intent) {
        this.id = intent.getStringExtra("id");
        this.channelId = intent.getStringExtra("channelId");
        this.channelName = intent.getStringExtra("channelName");
        this.videoId = intent.getStringExtra("videoId");
        this.videoTitle = intent.getStringExtra("videoTitle");
        this.date = new Date();
        date.setTime(Long.parseLong(intent.getStringExtra("date")));
        this.publishedAt = new Date();
        publishedAt.setTime(Long.parseLong(intent.getStringExtra("publishedMills")));
        if (intent.hasExtra("creatorName")) {
            this.creatorNames = intent.getStringExtra("creatorNames");
        }
        if (intent.hasExtra("creatorKeys")) {
            keyString = intent.getStringExtra("creatorKeys");
            if (keyString != null) {
                String[] keyArray = keyString.split(",");
                this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
            }
        }
        creatorList = new ArrayList<>();
        if (intent.hasExtra("creator")) {
            creatorListString = intent.getStringExtra("creator");
            Log.d(TAG, creatorListString);
            Gson gson = new Gson();
            JsonReader reader = new JsonReader(new StringReader(creatorListString));
            reader.setLenient(true);
            creatorList = gson.fromJson(reader, new TypeToken<List<YoutubeCreator>>() {
            }.getType());
        }
    }

    public Intent toIntent() {
        Intent intent = new Intent();
        intent.putExtra("id", id);
        intent.putExtra("channelId", channelId);
        intent.putExtra("channelName", channelName);
        intent.putExtra("videoId", videoId);
        intent.putExtra("videoTitle", videoTitle);
        intent.putExtra("date", date.getTime());
        intent.putExtra("publishedAt", publishedAt.getTime());
        intent.putExtra("creatorName", channelName);
        intent.putExtra("creatorKeys", keyString);
        intent.putExtra("creator", creatorListString);
        return intent;
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
        Prefs prefs = new Prefs(context);
        List<String> creator = prefs.getCreator();
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


        /*
        switch (p) {
            case "all":
                s.append("\nWith ");
                temp = getCreatorList();
                n = temp.size();
                for (int i = 0; i < n; i++) {
                    YoutubeCreator yc = temp.get(i);
                    s.append(yc.getName());
                    if (i == n - 2) {
                        s.append(" and ");
                    } else if (i < n - 1) {
                        s.append(", ");
                    }
                }
                return s.toString();
            case "sub":
                s.append("\nWith ");
                for (YoutubeCreator yc : creatorList) {
                    if (creator.contains(yc.getKey())) {
                        temp.add(yc);
                    }
                }
                n = temp.size();
                boolean useAndMore = temp.size() < creatorList.size();
                for (int i = 0; i < n; i++) {
                    YoutubeCreator yc = temp.get(i);
                    s.append(yc.getName());
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
            default:
                return "";
        }*/
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
