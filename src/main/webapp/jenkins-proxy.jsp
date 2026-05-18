<%@ page import="java.net.*,java.io.*" %>
<%
String jenkinsUrl = "http://13.62.172.73:8080/job/devops-dashboard/lastBuild/api/json";
String username = "muhammadarhamrashid12";
String token = "110371a0afa4f0584f13a13e7056e4a51e";

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