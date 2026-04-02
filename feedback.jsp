<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>feedback</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 40px;
        }

        /* FEEDBACK FORM */
        .feedback-container {
            background: white;
            width: 100%;
            max-width: 600px;
            padding: 48px;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .feedback-title {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 12px;
        }

        .feedback-subtitle {
            text-align: center;
            color: #64748b;
            font-size: 16px;
            margin-bottom: 40px;
        }

        /* TEXTAREA */
        .feedback-textarea {
            width: 100%;
            min-height: 200px;
            padding: 24px;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            font-size: 16px;
            font-family: inherit;
            line-height: 1.6;
            resize: vertical;
            transition: all 0.3s;
            background: #f8fafc;
        }

        .feedback-textarea:focus {
            outline: none;
            border-color: #6f63ff;
            box-shadow: 0 0 0 4px rgba(111, 99, 255, 0.1);
            background: white;
        }

        .feedback-textarea::placeholder {
            color: #94a3b8;
        }

        /* SEND BUTTON */
        .send-button {
            width: 100%;
            height: 56px;
            margin-top: 24px;
            border: none;
            border-radius: 24px;
            background: linear-gradient(135deg, #6f63ff, #8b7eff);
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 8px 25px rgba(111, 99, 255, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .send-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(111, 99, 255, 0.4);
        }

        .send-button:active {
            transform: translateY(0);
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .main-content { padding: 40px 20px; }
            .feedback-container {
                padding: 32px 24px;
                margin: 0 8px;
            }
            .feedback-title { font-size: 28px; }
        }
        .star{
            font-size:32px;
            cursor:pointer;
            color:#cbd5f5;
        }
        .star.active{
            color:#facc15;
        }
    </style>
</head>
<body>
    <% Boolean submitted = (Boolean) request.getAttribute("feedbackSubmitted"); %>
<div id="thankYouBox" style="display: none;">
    <div style="
        position: fixed;
        top: 50%; left: 50%;
        transform: translate(-50%, -50%);
        background: rgba(111,99,255,0.9);
        color: white;
        padding: 30px 40px;
        border-radius: 16px;
        text-align: center;
        font-family: Arial, sans-serif;
        z-index: 9999;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    ">
        <div style="font-size:50px; margin-bottom:10px;">✔</div>
        <h2 style="margin-bottom:10px;">Thank You!</h2>
        <p style="opacity:0.9;">Your feedback has been submitted.</p>
    </div>
</div>

<script>
<% if(submitted != null && submitted) { %>
    var box = document.getElementById("thankYouBox");
    box.style.display = "block";

    setTimeout(function(){
        box.style.display = "none";
    }, 3000); // hide after 3 seconds
<% } %>
</script>
    <main class="main-content">
        <form class="feedback-container" method="post" action="submitFeedback.jsp">
            <h1 class="feedback-title"> Send Feedback</h1>
            <p class="feedback-subtitle">
                Help us improve ManSparsh. Your suggestions matter!
            </p>
            <!-- STAR RATING -->
            <div style="text-align:center; margin-bottom:20px;">
                <input type="hidden" name="rating" id="rating">

                <span class="star" onclick="setRating(1)">★</span>
                <span class="star" onclick="setRating(2)">★</span>
                <span class="star" onclick="setRating(3)">★</span>
                <span class="star" onclick="setRating(4)">★</span>
                <span class="star" onclick="setRating(5)">★</span>

                <div id="ratingText" style="margin-top:8px; color:#64748b;">Select Rating</div>
            </div>
            <textarea
                class="feedback-textarea"
                name="feedback"
                placeholder="Share your thoughts, suggestions, or report any issues you've encountered..."
                required
            ></textarea>
           
            <button type="submit" class="send-button">
                 Send Feedback
            </button>
        </form>
    </main>
    <script>
        function setRating(val){
            document.getElementById("rating").value = val;
            let stars = document.querySelectorAll(".star");

            stars.forEach((s,i)=>{
                s.classList.toggle("active", i < val);
            });

            document.getElementById("ratingText").innerText = val + " Star";
        }
    </script>

</body>
</html>