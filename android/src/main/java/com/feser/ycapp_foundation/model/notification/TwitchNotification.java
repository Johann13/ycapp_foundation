package com.feser.ycapp_foundation.model.notification;

import android.annotation.SuppressLint;
import android.content.Intent;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

public class TwitchNotification {
	private String id;
	private String channelId;
	private String channelName;
	private String gameId;
	private String gameName;
	private String gameBoxArtUrl;
	private String streamTitle;
	private String summary;
	private Date date;
	private Date startedAt;
	private String creatorNames;
	private List<String> creatorKeys;

	public TwitchNotification(Map<String, String> map) {
		this.id = map.get("id");
		this.channelId = map.get("channelId");
		this.channelName = map.get("channelName");
		this.gameId = map.get("gameId");
		this.gameName = map.get("gameName");
		this.gameBoxArtUrl = map.get("gameBoxArtUrl");
		this.streamTitle = map.get("streamTitle");
		this.date = new Date();
		date.setTime(Long.parseLong(map.get("date")));
		this.startedAt = new Date();
		if (map.containsKey("publishedMills")) {
			startedAt.setTime(Long.parseLong(map.get("publishedMills")));
		}
		if (map.containsKey("summary")) {
			this.summary = map.get("summary");
		}

		if (map.containsKey("creatorName")) {
			this.creatorNames = map.get("creatorNames");
		}
		if (map.containsKey("creatorKeys")) {
			String keyString = map.get("creatorKeys");
			if (keyString != null) {
				String[] keyArray = keyString.split(",");
				this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
			}
		}
	}


	public TwitchNotification(Intent intent) {
		this.id = intent.getStringExtra("id");
		this.channelId = intent.getStringExtra("channelId");
		this.channelName = intent.getStringExtra("channelName");
		this.gameId = intent.getStringExtra("gameId");
		this.gameName = intent.getStringExtra("gameName");
		this.gameBoxArtUrl = intent.getStringExtra("gameBoxArtUrl");
		this.streamTitle = intent.getStringExtra("streamTitle");
		this.date = new Date();
		date.setTime(Long.parseLong(intent.getStringExtra("date")));
		this.startedAt = new Date();
		if (intent.hasExtra("publishedMills")) {
			startedAt.setTime(Long.parseLong(intent.getStringExtra("publishedMills")));
		}
		if (intent.hasExtra("summary")) {
			this.summary = intent.getStringExtra("summary");
		}

		if (intent.hasExtra("creatorName")) {
			this.creatorNames = intent.getStringExtra("creatorNames");
		}
		if (intent.hasExtra("creatorKeys")) {
			String keyString = intent.getStringExtra("creatorKeys");
			if (keyString != null) {
				String[] keyArray = keyString.split(",");
				this.creatorKeys = new ArrayList<>(Arrays.asList(keyArray));
			}
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

	public String getGameId() {
		return gameId;
	}

	public String getGameName() {
		return gameName;
	}

	public String getGameBoxArtUrl() {
		return gameBoxArtUrl;
	}

	public String getStreamTitle() {
		return streamTitle;
	}

	public String getSummary() {
		if (summary == null) {
			return getChannelName() + " went live!";
		}
		return summary;
	}

	public Date getDate() {
		return date;
	}

	public Date getStartedAt() {
		return startedAt;
	}

	public String formateDate() {
		@SuppressLint("SimpleDateFormat")
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
		return sdf.format(getStartedAt());
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

	public int getNotificationId() {
		if (getStartedAt() != null) {
			return (int) (((getDate().getTime() / 1000) + (getStartedAt().getTime() / 1000)) / 2);
		} else {
			return (int) (((getDate().getTime() / 1000)));
		}
	}

	public String getChannelNameLog() {
		return channelName.substring(0, Math.min(30, channelName.length()));
	}

	public String getStreamTitleLog() {
		return streamTitle.substring(0, Math.min(30, streamTitle.length()));
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
}
