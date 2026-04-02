<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Mental Health Support Chatbot</title>
    <style>
        body {
            margin: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #fdfbfb, #ebedff);
        }

        .wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .chat-card {
            width: 100%;
            max-width: 720px;
            background: #ffffffcc;
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 18px 45px rgba(126, 143, 189, 0.25);
            padding: 24px 28px 20px;
            border: 1px solid rgba(210, 220, 255, 0.9);
        }

        .chat-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #a5b4fc, #f9a8d4);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 600;
            font-size: 18px;
        }

        .header-text h2 {
            margin: 0;
            font-size: 20px;
            color: #334155;
        }

        .header-text p {
            margin: 2px 0 0;
            font-size: 13px;
            color: #6b7280;
        }

        .chat-window {
            background: #f9fafb;
            border-radius: 18px;
            padding: 16px;
            max-height: 360px;
            overflow-y: auto;
            border: 1px solid #e5e7eb;
            margin-bottom: 16px;
        }

        .message {
            margin-bottom: 10px;
            display: flex;
        }

        .message.user {
            justify-content: flex-end;
        }

        .bubble {
            max-width: 75%;
            padding: 10px 14px;
            border-radius: 16px;
            font-size: 14px;
            line-height: 1.4;
        }

        .user .bubble {
            background: #bfdbfe;
            color: #1e293b;
            border-bottom-right-radius: 4px;
        }

        .bot .bubble {
            background: #e0f2fe;
            color: #0f172a;
            border-bottom-left-radius: 4px;
        }

        .bot .label {
            font-size: 11px;
            color: #6b7280;
            margin-bottom: 3px;
        }

        .input-row {
            display: flex;
            gap: 10px;
            margin-top: 6px;
        }

        textarea {
            flex: 1;
            resize: none;
            border-radius: 14px;
            border: 1px solid #d1d5db;
            padding: 10px 12px;
            font-size: 14px;
            font-family: inherit;
            box-sizing: border-box;
            min-height: 54px;
            background-color: #f9fafb;
        }

        textarea:focus {
            outline: none;
            border-color: #a5b4fc;
            box-shadow: 0 0 0 2px rgba(129, 140, 248, 0.35);
        }

        .send-btn {
            border: none;
            border-radius: 999px;
            padding: 0 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            background: linear-gradient(135deg, #a5b4fc, #f9a8d4);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.1s ease, box-shadow 0.15s ease;
            box-shadow: 0 10px 25px rgba(148, 163, 246, 0.4);
        }

        .send-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 32px rgba(148, 163, 246, 0.5);
        }

        .send-btn:active {
            transform: translateY(0);
            box-shadow: 0 6px 18px rgba(148, 163, 246, 0.35);
        }

        .footer-note {
            margin-top: 8px;
            font-size: 11px;
            color: #9ca3af;
            text-align: center;
        }

        @media (max-width: 600px) {
            .chat-card {
                padding: 18px 16px 14px;
                border-radius: 20px;
            }
            .bubble {
                max-width: 82%;
            }
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="chat-card">
        <div class="chat-header">
            <div class="avatar">MH</div>
            <div class="header-text">
                <h2></h2>
                <p>Share how you feel. This space is gentle and private.</p>
            </div>
        </div>

        <div class="chat-window">
            <%
                java.util.List<com.mentalhealth.chatbot.ChatbotServlet.ChatMessage> history =
                    (java.util.List<com.mentalhealth.chatbot.ChatbotServlet.ChatMessage>)
                        session.getAttribute("history");

                if (history == null || history.isEmpty()) {
            %>
                <div class="message bot">
                    <div>
                        <div class="label">Support bot</div>
                        <div class="bubble">
                            Hi, this is a gentle space to talk about your feelings.
                            What would you like to share today?
                        </div>
                    </div>
                </div>
            <%
                } else {
                    for (com.mentalhealth.chatbot.ChatbotServlet.ChatMessage msg : history) {
                        boolean isUser = "user".equals(msg.getSender());
            %>
                <div class="message <%= isUser ? "user" : "bot" %>">
                    <div>
                        <% if (!isUser) { %>
                            <div class="label">Support bot</div>
                        <% } %>
                        <div class="bubble">
                            <%= msg.getText() %>
                        </div>
                    </div>
                </div>
            <%
                    } // end for
                }     // end if
            %>
        </div>

        <form method="post" action="chat">
            <div class="input-row">
                <textarea name="message"
                          placeholder="Type a few lines about how you’re feeling right now..."></textarea>
                <button type="submit" class="send-btn">
                    Send
                </button>
            </div>
        </form>

        <div class="footer-note">
            This AI offers emotional support and is not a substitute for professional care.
        </div>
    </div>
</div>
</body>
</html>