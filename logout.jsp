<%@ page language="java" %>
<%
/* =========================
   1. Prevent Caching
   ========================= */
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies

/* =========================
   2. Get Existing Session
   ========================= */
javax.servlet.http.HttpSession sessionObj = request.getSession(false);

/* =========================
   3. Invalidate Session
   ========================= */
if (sessionObj != null) {
    sessionObj.invalidate();
}

/* =========================
   4. Clear JSESSIONID Cookie
   ========================= */
javax.servlet.http.Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (javax.servlet.http.Cookie cookie : cookies) {
        if ("JSESSIONID".equals(cookie.getName())) {
            cookie.setValue("");
            cookie.setPath(request.getContextPath());
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }
}

/* =========================
   5. Redirect to Homepage
   ========================= */
response.sendRedirect("Home Page.jsp");
%>