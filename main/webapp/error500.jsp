<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 - Internal Server Error</title>
</head>

<body>

<h1>500 - Internal Server Error</h1>

<p>Something went wrong while processing the request.</p>

<hr>

<h3>Debug information:</h3>

<p>
    <b>Error:</b>
    <%= exception != null ? exception.getClass().getName() : "Unknown" %>
</p>

<p>
    <b>Message:</b>
    <%= exception != null ? exception.getMessage() : "No message available" %>
</p>

<hr>

<p>ShinyMart</p>

</body>
</html>
