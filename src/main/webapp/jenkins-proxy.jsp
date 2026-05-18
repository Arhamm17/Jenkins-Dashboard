<%@ page import="java.net.*,java.io.*" %>
<%
String jenkinsUrl = "http://localhost:8080/job/devops-dashboard/lastBuild/api/json";
String username = "muhammadarhamrashid12";
String token = "YOUR-NEW-API-TOKEN";

String auth = username + ":" + token;
String encodedAuth = java.util.Base64.getEncoder().encodeToString(auth.getBytes());

URL url = new URL(jenkinsUrl);
HttpURLConnection conn = (HttpURLConnection) url.openConnection();
conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
conn.setRequestMethod("GET");

BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
StringBuilder sb = new StringBuilder();
String line;
while ((line = reader.readLine()) != null) sb.append(line);
reader.close();

response.setContentType("application/json");
response.setHeader("Access-Control-Allow-Origin", "*");
out.print(sb.toString());
%>