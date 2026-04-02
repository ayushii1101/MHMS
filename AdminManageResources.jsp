<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Resources | ManSparsh</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)),
    url('https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80');
    background-size:cover;
    background-attachment:fixed;
    color:#333;
}

/* Header */
.header{
    text-align:center;
    padding:30px;
    color:white;
}
.header h1{
    margin:0;
    font-size:38px;
    letter-spacing:2px;
    text-transform:uppercase;
}
.header p{
    margin-top:8px;
    font-size:16px;
    opacity:0.9;
}

/* Container */
.container{
    max-width:1200px;
    margin:20px auto 50px;
    background:rgba(255,255,255,0.95);
    border-radius:18px;
    padding:30px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

/* ALL SECTION HEADINGS – DARK GREYISH */
.section-title{
    text-align:center;
    font-size:32px;
    font-weight:800;
    color:#4a4a4a;
    margin:50px 0 30px;
    position:relative;
    letter-spacing:1px;
    cursor:pointer;
    transition:all 0.3s ease;
}

.section-title::after{
    content:"";
    width:90px;
    height:4px;
    background:#6a6a6a;
    position:absolute;
    bottom:-10px;
    left:50%;
    transform:translateX(-50%);
    border-radius:10px;
    transition:width 0.3s ease;
}

.section-title:hover{
    color:#2f2f2f;
    text-shadow:0 0 10px rgba(0,0,0,0.25);
}

.section-title:hover::after{
    width:150px;
}

/* Videos */
.video-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:25px;
}
.video-card{
    background:#f7fbff;
    border-radius:15px;
    padding:15px;
    transition:transform 0.3s, box-shadow 0.3s;
}
.video-card:hover{
    transform:translateY(-6px);
    box-shadow:0 10px 20px rgba(0,0,0,0.2);
}
.video-card video{
    width:100%;
    border-radius:12px;
}
.video-card p{
    margin-top:10px;
    font-weight:600;
    color:#444;
    text-align:center;
}

/* Activities */
.activities{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:22px;
}
.activity{
    background:linear-gradient(135deg,#e6f3ff,#ffffff);
    padding:22px;
    border-radius:16px;
    text-align:center;
    transition:transform 0.3s;
}
.activity:hover{
    transform:scale(1.05);
}
.activity a{
    text-decoration:none;
    color:#1E90FF;
    font-size:18px;
    font-weight:800;
}
.activity span{
    display:block;
    margin-top:8px;
    font-size:14px;
    color:#555;
}

/* Quote */
.quote{
    background:#eef6ff;
    padding:30px;
    border-radius:16px;
    text-align:center;
    font-size:18px;
    font-style:italic;
    margin-top:40px;
}

/* Story */
.story{
    margin-top:30px;
    background:#fafcff;
    padding:35px;
    border-radius:16px;
    line-height:1.9;
    font-size:18.5px;
    color:#444;
}
.story strong{
    color:#1E90FF;
}

@media(max-width:768px){
    .header h1{font-size:28px;}
    .section-title{font-size:26px;}
    .story{font-size:17px;}
}
</style>
</head>

<body>

<div class="header">
    <h1>ManSparsh Resources</h1>
    <p>A space to heal, reflect, discover and grow</p>
</div>

<div class="container">

    <!-- Videos -->
    <div class="section-title">Healing Videos</div>
    <div class="video-grid">
        <div class="video-card">
            <video controls>
                <source src="images/Mindfulness.mp4" type="video/mp4">
            </video>
            <p>Mindfulness & Inner Peace</p>
        </div>

        <div class="video-card">
            <video controls>
                <source src="images/psychology.mp4" type="video/mp4">
            </video>
            <p>Understanding Emotions</p>
        </div>

        <div class="video-card">
            <video controls>
                <source src="images/Happiness.mp4" type="video/mp4">
            </video>
            <p>Finding Happiness</p>
        </div>
    </div>

    <!-- Activities -->
    <div class="section-title">Interactive Activities</div>
    <div class="activities">

        <div class="activity">
            <a href="https://www.pursuit-of-happiness.org/science-of-happiness/happiness-quiz/" target="_blank">HAPPINESS QUIZ</a>
            <span>Explore what happiness truly means to you</span>
        </div>

        <div class="activity">
            <a href="https://www.bemindfulonline.com/test-your-stress" target="_blank">STRESS CHECK</a>
            <span>Understand your current stress level</span>
        </div>

        <div class="activity">
            <a href="https://www.16personalities.com/free-personality-test" target="_blank">PERSONALITY TEST</a>
            <span>Discover your personality type</span>
        </div>

        <div class="activity">
            <a href="https://www.psychologytoday.com/us/tests/personality/empathy-test" target="_blank">EMPATHY TEST</a>
            <span>Measure emotional understanding</span>
        </div>

        <div class="activity">
            <a href="https://www.123test.com/iq-test/" target="_blank">IQ TEST</a>
            <span>Assess reasoning & thinking skills</span>
        </div>

    </div>

    <!-- Quote -->
    <div class="quote">
        “Education should nurture not only the intellect, but also emotional balance and inner strength.”
        <br><strong>— Pt. Hiralal Shastri (Founder, Banasthali Vidyapith)</strong>
    </div>

    <!-- Story -->
    <div class="section-title">A Story of Healing</div>
    <div class="story">
        <p><strong>Meet Riya.</strong> A bright college student who always smiled in front of others, yet silently battled anxiety every night.</p>
        <p>Deadlines, expectations, and fear of failure slowly started affecting her sleep, confidence, and peace of mind.</p>
        <p>When she discovered <strong>ManSparsh</strong>, she hesitated—but took a brave step.</p>
        <p>Through compassionate counseling, she learned to pause, reflect, and rebuild herself emotionally.</p>
        <p>Healing began the moment she chose herself—and today, she walks forward with clarity, strength, and hope.</p>
    </div>

</div>

</body>
</html>
