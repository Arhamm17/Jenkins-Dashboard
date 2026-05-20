<%@ page import="java.net.*,java.io.*" %>
<%
try {

    String jenkinsUrl = "http://13.62.172.73:8080/job/devops-dashboard/lastBuild/api/json";

    String username = "arhamrashid";
    String token = "11029dfa3917cb31138a1e30a36fc316ee";

    String auth = username + ":" + token;

    String encodedAuth = java.util.Base64.getEncoder()
        .encodeToString(auth.getBytes());

    URL url = new URL(jenkinsUrl);

    HttpURLConnection conn =
        (HttpURLConnection) url.openConnection();

    conn.setRequestMethod("GET");

    conn.setRequestProperty(
        "Authorization",
        "Basic " + encodedAuth
    );

    int responseCode = conn.getResponseCode();

    InputStream stream;

    if (responseCode >= 200 && responseCode < 300) {
        stream = conn.getInputStream();
    } else {
        stream = conn.getErrorStream();
    }

    BufferedReader reader =
        new BufferedReader(new InputStreamReader(stream));

    StringBuilder sb = new StringBuilder();

    String line;

    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }

    reader.close();

    response.setContentType("application/json");

    response.setHeader(
        "Access-Control-Allow-Origin",
        "*"
    );

    out.print(sb.toString());

} catch (Exception e) {

    response.setContentType("application/json");

    out.print("{\"error\":\"" + e.getMessage() + "\"}");
}
%>