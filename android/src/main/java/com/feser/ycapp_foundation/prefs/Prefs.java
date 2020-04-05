package com.feser.ycapp_foundation.prefs;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Base64;


import com.feser.ycapp_foundation.model.notification.TwitchNotification;
import com.feser.ycapp_foundation.model.notification.YoutubeNotification;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
public class Prefs {

	private static final String LIST_IDENTIFIER = "VGhpcyBpcyB0aGUgcHJlZml4IGZvciBhIGxpc3Qu";
	private SharedPreferences sharedPreferences;

	public Prefs(Context context) {
		this.sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
	}

	public void attach(Context context) {
		this.sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
	}

	public void destroy() {
		this.sharedPreferences = null;
	}

	private Map<String, ?> getAll() {
		return sharedPreferences.getAll();
	}

	public String all() {
		return getAll().toString();
	}

	public boolean getBool(String prefName, boolean defaultValue) {
		Object o = getAll().get("flutter." + prefName);
		if (o == null) {
			return defaultValue;
		}
		return (boolean) o;
	}

	public void setBool(String prefName, boolean value) {
		sharedPreferences.edit().putBoolean("flutter." + prefName, value).apply();
	}


	public void setList(String prefName, List<String> list) throws IOException {
		sharedPreferences.edit().putString("flutter." + prefName, LIST_IDENTIFIER + encodeList(list)).apply();
	}

	public void addToList(String prefName, String value) {
		try {
			List<String> list = getList(prefName);
			if (!list.contains(value)) {
				list.add(value);
			}
			setList(prefName, list);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int getInt(String prefName, int defaultValue) {
		Object o = getAll().get("flutter." + prefName);
		if (o != null) {
			if (o instanceof Integer) {
				return (int) o;
			}
			long l = (long) o;
			return (int) l;
		} else {
			return defaultValue;
		}
	}

	public long getLong(String prefName, long defaultValue) {
		Object o = getAll().get("flutter." + prefName);
		if (o != null) {
			if (o instanceof Integer) {
				return (int) o;
			}
			return (long) o;
		} else {
			return defaultValue;
		}
	}

	public void setInt(String prefName, int value) {
		sharedPreferences.edit().putInt("flutter." + prefName, value).commit();
	}

	public void setLong(String prefName, long value) {
		sharedPreferences.edit().putLong("flutter." + prefName, value).commit();
	}

	public String getString(String prefName, String defaultValue) {
		Object o = getAll().get("flutter." + prefName);
		if (o != null) {
			return (String) o;
		} else {
			return defaultValue;
		}
	}

	public void setString(String prefName, String value) {
		sharedPreferences.edit().putString("flutter." + prefName, value).commit();
	}

	public List<String> getList(String prefName) {
		Object o = getAll().get("flutter." + prefName);
		if (o == null) {
			return new ArrayList<>();
		}
		String s = o.toString().substring(LIST_IDENTIFIER.length());
		//Log.d("getList", s);
		try {
			return decodeList(s);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ArrayList<>();
	}

	public void removeFromList(String prefName, String value) {
		try {
			List<String> list = getList(prefName);
			list.remove(value);
			setList(prefName, list);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<String> getCreator() {
		return getList("creatorSubscriptions");
	}

	public List<String> getTwitch() {
		return getList("twitchSubscriptions");
	}

	public List<String> getYoutube() {
		return getList("youtubeSubscriptions");
	}


	public List<String> getTwitchNotifications() {
		return getList("twitchNotifications");
	}

	public List<String> getYoutubeNotifications() {
		return getList("youtubeNotifications");
	}


	public List<String> getTwitchInbox() {
		return getList("twitchInbox");
	}

	public List<String> getYoutubeInbox() {
		return getList("youtubeInbox");
	}

	public List<String> getCollab() {
		return getList("collaboration");
	}

	public List<String> getCollabInbox() {
		return getList("collaborationInbox");
	}

	public boolean isSubscribedToYoutubeChannel(String channelId) {
		return getYoutube().contains(channelId);
	}

	public boolean isSubscribedToTwitchChannel(String channelId) {
		return getTwitch().contains(channelId);
	}

	public boolean getsTwitchNotifications(String channelId) {
		return getTwitchNotifications().contains(channelId);
	}

	public boolean getsYoutubeNotifications(String channelId) {
		return getYoutubeNotifications().contains(channelId);
	}

	public boolean getsTwitchInbox(String channelId) {
		return getTwitchInbox().contains(channelId);
	}

	public boolean getsYoutubeInbox(String channelId) {
		return getYoutubeInbox().contains(channelId);
	}

	public boolean getsCollab(String channelId) {
		return getCollab().contains(channelId);
	}

	public boolean getsCollab(List<String> channelIds) {
		for (String channelId : channelIds) {
			if (getsCollab(channelId)) {
				return true;
			}
		}
		return false;
	}

	public boolean getsCollabInbox(String channelId) {
		return getCollabInbox().contains(channelId);
	}

	public boolean getsCollabInbox(List<String> channelIds) {
		for (String channelId : channelIds) {
			if (getCollabInbox().contains(channelId)) {
				return true;
			}
		}
		return false;
	}

	public List<String> getYoutubeBlocker() {
		return getList("notificationBlockerYoutube");
	}

	public List<String> getTwitchBlocker() {
		return getList("notificationBlockerTwitch");
	}

	public List<String> getBlocker(YoutubeNotification notification) {
		return getList("notificationBlockerYoutube_" + notification.getChannelId());
	}

	public List<String> getBlocker(TwitchNotification notification) {
		return getList("notificationBlockerTwitch_" + notification.getChannelId());
	}

	public List<String> getFilter(YoutubeNotification notification) {
		return getList("notificationFilerYoutube_" + notification.getChannelId());
	}

	public List<String> getFilter(TwitchNotification notification) {
		return getList("notificationFilterTwitch_" + notification.getChannelId());
	}

	public boolean stopBecauseOfBlocker(YoutubeNotification notification) {
		return stopBecauseOfBlocker(getTwitchBlocker(), notification.getVideoTitle());
	}

	public boolean stopBecauseOfBlocker(TwitchNotification notification) {
		return stopBecauseOfBlocker(getTwitchBlocker(), notification.getStreamTitle());
	}

	public boolean stopBecauseOfChannelBlocker(YoutubeNotification notification) {
		return stopBecauseOfBlocker(getBlocker(notification), notification.getVideoTitle());
	}

	public boolean stopBecauseOfChannelBlocker(TwitchNotification notification) {
		return stopBecauseOfBlocker(getBlocker(notification), notification.getStreamTitle());
	}

	public boolean stopBecauseOfChannelFilter(YoutubeNotification notification) {
		return stopBecauseOfChannelFilter(getFilter(notification), notification.getVideoTitle());
	}

	public boolean stopBecauseOfChannelFilter(TwitchNotification notification) {
		return stopBecauseOfChannelFilter(getFilter(notification), notification.getStreamTitle());
	}

	private boolean stopBecauseOfBlocker(List<String> blocker, String title) {
		if (blocker != null) {
			for (String f : blocker) {
				if (title.contains(f)) {
					return true;
				}
			}
		}
		return false;
	}

	private boolean stopBecauseOfChannelFilter(List<String> filter, String title) {
		// there are no filters
		if (filter == null) {
			return false;
		}

		// there are no filters
		if (filter.isEmpty()) {
			return false;
		}

		// there are filters
		for (String f : filter) {
			if (title.contains(f)) {
				// there is a filter that matches
				return false;
			}
		}

		// there are filters but the title does not matches any
		return true;
	}

	public boolean showYoutubeNotification(YoutubeNotification notification) {
		return getsYoutubeNotifications(notification.getChannelId());
	}

	public boolean showTwitchNotification(TwitchNotification notification) {
		return getsTwitchNotifications(notification.getChannelId());
	}

	public boolean showCollabNotification(TwitchNotification notification) {
		return getsCollab(notification.getCreatorKeys());
	}

	public boolean showCollabNotification(YoutubeNotification notification) {
		return getsCollab(notification.getCreatorKeys());
	}

	public boolean showYoutubeInbox(YoutubeNotification notification) {
		return getsYoutubeInbox(notification.getChannelId());
	}

	public boolean showTwitchInbox(TwitchNotification notification) {
		return getsTwitchInbox(notification.getChannelId());
	}

	public boolean showCollabInbox(TwitchNotification notification) {
		return getsCollabInbox(notification.getCreatorKeys());
	}

	public boolean showCollabInbox(YoutubeNotification notification) {
		return getsCollabInbox(notification.getCreatorKeys());
	}

	private String encodeList(List<String> list) throws IOException {
		ObjectOutputStream stream = null;
		try {
			ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
			stream = new ObjectOutputStream(byteStream);
			stream.writeObject(list);
			stream.flush();
			return Base64.encodeToString(byteStream.toByteArray(), 0);
		} finally {
			if (stream != null) {
				stream.close();
			}
		}
	}

	private List<String> decodeList(String encodedList) throws IOException {
		if (encodedList == null) {
			return new ArrayList<>();
		} else if (encodedList.isEmpty()) {
			return new ArrayList<>();
		}
		try (ObjectInputStream stream = new ObjectInputStream(new ByteArrayInputStream(Base64.decode(encodedList, 0)))) {
			return (List<String>) stream.readObject();
		} catch (ClassNotFoundException e) {
			throw new IOException(e);
		}
        /*try {
            stream = new ObjectInputStream(new ByteArrayInputStream(Base64.decode(encodedList, 0)));
            if (stream == null) {
                return new ArrayList<>();
            }
            return (List<String>) stream.readObject();
        } catch (ClassNotFoundException e) {
            throw new IOException(e);
        } finally {
            if (stream != null) {
                stream.close();
            }
        }*/
	}

	private Map<String, Object> getAllPrefs() throws IOException {
		Map<String, ?> allPrefs = sharedPreferences.getAll();
		Map<String, Object> filteredPrefs = new HashMap<>();
		for (String key : allPrefs.keySet()) {
			if (key.startsWith("flutter.")) {
				Object value = allPrefs.get(key);
				if (value instanceof String) {
					String stringValue = (String) value;
					if (stringValue.startsWith(LIST_IDENTIFIER)) {
						value = decodeList(stringValue.substring(LIST_IDENTIFIER.length()));
					}
				}
				filteredPrefs.put(key, value);
			}
		}
		return filteredPrefs;
	}

	public void remove(String key) {
		sharedPreferences.edit()
				.remove(key)
				.apply();
	}
}
