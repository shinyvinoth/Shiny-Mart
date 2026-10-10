package com.shiny.shinymart.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public final class JsonUtil {

    private static final Gson GSON = new GsonBuilder().create();

    private JsonUtil() {
    }

    public static String toJson(Object obj) {
        return GSON.toJson(obj);
    }

    public static <T> T fromJson(String json, Class<T> clazz) {
        return GSON.fromJson(json, clazz);
    }
}
