package com.shiny.shinymart.dto;

/** Fixed envelope format for all /api/v1/... JSON endpoints — Section 13, rule 2. */
public class ApiResponse<T> {
    private boolean success;
    private T data;
    private ApiError error;

    public static <T> ApiResponse<T> ok(T data) {
        ApiResponse<T> r = new ApiResponse<>();
        r.success = true;
        r.data = data;
        r.error = null;
        return r;
    }

    public static <T> ApiResponse<T> fail(String code, String message) {
        ApiResponse<T> r = new ApiResponse<>();
        r.success = false;
        r.data = null;
        r.error = new ApiError(code, message);
        return r;
    }

    public boolean isSuccess() { return success; }
    public T getData() { return data; }
    public ApiError getError() { return error; }
}
