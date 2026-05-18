<%@ page import="java.net.*,java.io.*,java.util.Base64" %>
<%
String jenkinsUrl = "http://13.62.172.73:8080/job/devops-dashboard/lastBuild/api/json";

String username = "muhammadarhamrashid12";
String token = "110371a0afa4f0584f13a13e7056e4a51e";

// Build Basic Auth
String auth = username + ":" + token;
String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes("UTF-8"));

HttpURLConnection conn = null;
BufferedReader reader = null;

StringBuilder sb = new StringBuilder();

try {
    URL url = new URL(jenkinsUrl);
    conn = (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");
    conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
    conn.setRequestProperty("Accept", "application/json");

    int responseCode = conn.getResponseCode();

    InputStream stream;

    // IMPORTANT: handle success vs error
    if (responseCode >= 200 && responseCode < 300) {
        stream = conn.getInputStream();
    } else {
        stream = conn.getErrorStream(); // prevents crash
    }

    reader = new BufferedReader(new InputStreamReader(stream));

    String line;
    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.setHeader("Access-Control-Allow-Origin", "*");

    // Optional: include status for debugging
    out.print(sb.toString());

} catch (Exception e) {
    response.setContentType("application/json");
    response.setStatus(500);

    out.print("{\"error\":\"" + e.getMessage().replace("\"", "'") + "\"}");

} finally {
    try {
        if (reader != null) reader.close();
        if (conn != null) conn.disconnect();
    } catch (Exception ignored) {}
}
%>