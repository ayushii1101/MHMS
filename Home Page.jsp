<%@ page import="java.io.*" %>
<html>
<head>
<title>Home Page</title>
<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
}

/* NAVBAR */
.navbar {
    background-color: #6f63ff;   /* purple */
    height: 60px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    box-sizing: border-box;
    position: relative;
    z-index: 2000;
}

/* LOGO */
.logo {
    color: white;
    font-size: 26px;
    font-weight: bold;
}

/* LINKS */
.nav-links a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
}

/* LOGIN DROPDOWN */
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown > a {
    cursor: pointer;
}

/* Hidden menu */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 180px;
    top: 100%;       /* instead of 45px */
    right: 0;
    border-radius: 6px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    z-index: 9999;
}


/* Links inside dropdown */
.dropdown-content a {
    color: #333;
    padding: 12px 16px;
    display: block;
    text-decoration: none;
    font-size: 14px;
}

.dropdown-content a:hover {
    background-color: #f1f1f1;
}

/* Show dropdown on hover */
.dropdown:hover .dropdown-content {
    display: block;
}
.dropdown > a {
    cursor: pointer;
    padding: 20px 15px;   /* hover area bada ho jayega */
    display: inline-block;
}


/* CENTER CONTENT */
.main {
    height: calc(100vh - 60px);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-image: url("images/bg1.png");
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    text-align: center;
}

.main h1 {
    font-size: 48px;
    color: white;
    margin-bottom: 15px;
}

.main p {
    font-size: 18px;
    margin: 15px 0 30px;
    color: white;
}

/* BUTTON */
.btn {
    background-color: yellow;
    color: black;
    padding: 12px 30px;
    text-decoration: none;
    border-radius: 30px;
    font-size: 18px;
    margin-top: 15px;
}

/* NEW SAATHI SECTION
.saathi-section {
    margin-top: 50px;
    text-align: center;
    color: white;
}

.saathi-section h2 {
    font-size: 36px;
    margin-bottom: 15px;
}

.saathi-section p {
    font-size: 20px;
    margin-bottom: 25px;
}

.saathi-section .saathi-btn {
    background-color: #ffcc00;
    color: black;
    padding: 14px 35px;
    font-size: 18px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: bold;
    transition: 0.3s;
}

.saathi-section .saathi-btn:hover {
    background-color: #e6b800;
} */

/* Testimonials Section */

.testimonial-subtitle {
    color: #0d6efd;   /* strong blue */
    font-weight: 600;
    letter-spacing: 1.5px;
    font-size: 14px;
}

.testimonial-title {
    color: #1f2937;   /* dark gray */
    font-size: 36px;
    font-weight: 700;
    margin: 10px 0;
}

.testimonial-desc {
    color: #4b5563;   /* readable gray */
    max-width: 750px;
    margin: 0 auto;
    font-size: 16px;
    line-height: 1.7;
    text-align: center;
   
    transition: opacity 1s ease;

}

.testimonial-line {
    width: 80px;
    height: 3px;
    background: #0d6efd;
    margin: 25px auto 0;
}
.testimonials-section {
    width: 100%;
    padding: 50px 20px;
    text-align: center;

    /* VISIBILITY FIX */
   
    backdrop-filter: blur(4px);
    background: rgba(255, 255, 255, 0.88);
    border-top: 1px solid #e0e0e0;
}
.footer-desc{
    max-width: 100vw;
    margin: 0 auto;
    font-size: 16px;
    line-height: 1.7;
    text-align: center;
    background: #6f63ff;
    color: white;
    display: flex;
    justify-content: center;   /* Horizontal centering of flex items */
}

</style>
</head>

<body>
<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-links">
        <a href="Home Page.jsp">Home</a>
        <a href="AboutUs.jsp">About Us</a>
        <a href="Features.jsp">Features</a>
        <div class="dropdown">
        <a>Login</a>
        <div class="dropdown-content">
            <a href="StudentLogin.jsp">Student</a>
            <a href="CounselorLogin.jsp">Counselor</a>
            <a href="FacultyLogin.jsp">Faculty</a>
        </div>
        </div>
        <a href="ContactUs.jsp">Contact Us</a>
    </div>
</div>
<div class="dashboard-bg">
<!-- MAIN CONTENT -->
<div class="main">
    <h1>Welcome to ManSparsh</h1>
    <p>A safe space to talk, heal, and feel understood.<br> Because your mental health matters- every single day.</p>

    <!-- NEW SAATHI SECTION
    <div class="saathi-section">
        <h2>Meet Saathi: Your AI Therapist</h2>
        <p>Available 24/7 to support you</p>
        <a href="index.jsp" class="saathi-btn">START CHAT WITH SAATHI</a>
    </div> -->
</div>
</div>
               <!-- TESTIMONIALS SECTION -->
<div class="testimonials-section">
    <p id="quote-subtitle" class="testimonial-subtitle"></p>
<p id="quote-text" class="testimonial-desc"></p>
         <div class="testimonial-line"></div>
</div>
<footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>
<script>
const quotes = [
"Healing is not linear.", // Quote 0 (day 1)
"You are enough, exactly as you are.", // Quote 1 (day 2)
"Rest is productive.", // Quote 2 (day 3)
"Progress, not perfection.", // Quote 3 (day 4)
"Your feelings are valid.", // Quote 4 (day 5)
"One breath at a time.", // Quote 5 (day 6)
"You have survived every hard day so far.", // Quote 6 (day 7)
"Small steps still move you forward.", // Quote 7 (day 8)
"Be gentle with yourself today.", // Quote 8 (day 9)
"You are not your thoughts.", // Quote 9 (day 10)
"It's okay to ask for help.", // Quote 10 (day 11)
"Growth takes time.", // Quote 11 (day 12)
"You deserve peace.", // Quote 12 (day 13)
"Today is enough.", // Quote 13 (day 14)
"Your story isn't over.", // Quote 14 (day 15)
"Courage is showing up.", // Quote 15 (day 16)
"You matter.", // Quote 16 (day 17)
"Kindness starts within.", // Quote 17 (day 18)
"Let yourself feel.", // Quote 18 (day 19)
"You are worthy of care.", // Quote 19 (day 20)
"Boundaries are acts of love.", // Quote 20 (day 21)
"Every day is a new start.", // Quote 21 (day 22)
"You don't have to be okay all the time.", // Quote 22 (day 23)
"Hope is always available.", // Quote 23 (day 24)
"Breathe. You've got this.", // Quote 24 (day 25)
"Slow down. You're doing fine.", // Quote 25 (day 26)
"Your worth is not your output.", // Quote 26 (day 27)
"Trust the process.", // Quote 27 (day 28)
"Vulnerability is strength.", // Quote 28 (day 29)
"You are not alone.", // Quote 29 (day 30)
"Difficult roads lead to beautiful places.", // Quote 30 (day 31)
"Feelings are messengers, not monsters.", // Quote 31 (day 32)
"You can start over any time.", // Quote 32 (day 33)
"Peace begins with a pause.", // Quote 33 (day 34)
"You are more resilient than you know.", // Quote 34 (day 35)
"Today, just breathe.", // Quote 35 (day 36)
"Grace over guilt.", // Quote 36 (day 37)
"Your needs matter.", // Quote 37 (day 38)
"Imperfection is human.", // Quote 38 (day 39)
"You are allowed to change.", // Quote 39 (day 40)
"Even flowers need rain.", // Quote 40 (day 41)
"Let go of what you can't control.", // Quote 41 (day 42)
"Choosing yourself is not selfish.", // Quote 42 (day 43)
"Tomorrow is another chance.", // Quote 43 (day 44)
"You are seen.", // Quote 44 (day 45)
"Calm is a superpower.", // Quote 45 (day 46)
"Your past does not define you.", // Quote 46 (day 47)
"There is strength in softness.", // Quote 47 (day 48)
"You are learning as you go.", // Quote 48 (day 49)
"This too shall pass.", // Quote 49 (day 50)
"Connection heals.", // Quote 50 (day 51)
"You are deserving of joy.", // Quote 51 (day 52)
"Rest without guilt.", // Quote 52 (day 53)
"You are a work in progress  and that's beautiful.", // Quote 53 (day 54)
"Every effort counts.", // Quote 54 (day 55)
"Saying no is self care.", // Quote 55 (day 56)
"You are braver than you feel.", // Quote 56 (day 57)
"Peace is possible.", // Quote 57 (day 58)
"You are not a burden.", // Quote 58 (day 59)
"Some days simply surviving is enough.", // Quote 59 (day 60)
"Tend to yourself like a garden.", // Quote 60 (day 61)
"You are allowed to take up space.", // Quote 61 (day 62)
"Being kind to yourself changes everything.", // Quote 62 (day 63)
"Healing happens in waves.", // Quote 63 (day 64)
"There is no rush.", // Quote 64 (day 65)
"You are safe right now.", // Quote 65 (day 66)
"It's okay to slow down.", // Quote 66 (day 67)
"You are more than your diagnosis.", // Quote 67 (day 68)
"Every sunrise is an invitation.", // Quote 68 (day 69)
"Your sensitivity is a gift.", // Quote 69 (day 70)
"Recovery is possible.", // Quote 70 (day 71)
"You are not broken.", // Quote 71 (day 72)
"Let yourself start again.", // Quote 72 (day 73)
"Asking for help is wisdom.", // Quote 73 (day 74)
"You can hold both grief and hope.", // Quote 74 (day 75)
"Your journey is your own.", // Quote 75 (day 76)
"Softness is not weakness.", // Quote 76 (day 77)
"You are capable of healing.", // Quote 77 (day 78)
"One good moment can change a day.", // Quote 78 (day 79)
"It's okay not to have all the answers.", // Quote 79 (day 80)
"You are allowed to rest.", // Quote 80 (day 81)
"Struggle doesn't mean failure.", // Quote 81 (day 82)
"There is power in your pause.", // Quote 82 (day 83)
"You are loved.", // Quote 83 (day 84)
"Your wellbeing comes first.", // Quote 84 (day 85)
"Breathe in peace, breathe out tension.", // Quote 85 (day 86)
"You are growing, even now.", // Quote 86 (day 87)
"Be patient with your healing.", // Quote 87 (day 88)
"You are worthy of kindness.", // Quote 88 (day 89)
"Step by step is still movement.", // Quote 89 (day 90)
"Rain makes things grow.", // Quote 90 (day 91)
"You have more strength than you know.", // Quote 91 (day 92)
"Today doesn't have to be perfect.", // Quote 92 (day 93)
"Honoring your emotions is brave.", // Quote 93 (day 94)
"You are held.", // Quote 94 (day 95)
"Rest is not laziness.", // Quote 95 (day 96)
"Keep going, gently.", // Quote 96 (day 97)
"You matter more than your productivity.", // Quote 97 (day 98)
"Uncertainty is part of life.", // Quote 98 (day 99)
"You are building something beautiful.", // Quote 99 (day 100)
"Compassion is the antidote.", // Quote 100 (day 101)
"Your mind deserves care too.", // Quote 101 (day 102)
"Be here, just for now.", // Quote 102 (day 103)
"You are the hero of your own story.", // Quote 103 (day 104)
"There's no timeline for healing.", // Quote 104 (day 105)
"You are allowed to feel joy.", // Quote 105 (day 106)
"Every day you try is a victory.", // Quote 106 (day 107)
"You are whole.", // Quote 107 (day 108)
"Give yourself the grace you'd give a friend.", // Quote 108 (day 109)
"Stillness is not emptiness.", // Quote 109 (day 110)
"You are worthy of love.", // Quote 110 (day 111)
"Struggle is not permanent.", // Quote 111 (day 112)
"You have survived before.", // Quote 112 (day 113)
"Take what you need and leave the rest.", // Quote 113 (day 114)
"Your pain has made you powerful.", // Quote 114 (day 115)
"Healing is an act of courage.", // Quote 115 (day 116)
"You can do hard things.", // Quote 116 (day 117)
"Hope doesn't require certainty.", // Quote 117 (day 118)
"Let yourself be human.", // Quote 118 (day 119)
"You are enough today.", // Quote 119 (day 120)
"Mental health is health.", // Quote 120 (day 121)
"You are not what happened to you.", // Quote 121 (day 122)
"Choose rest before collapse.", // Quote 122 (day 123)
"You are worthy of support.", // Quote 123 (day 124)
"Grief and growth coexist.", // Quote 124 (day 125)
"Your feelings make sense.", // Quote 125 (day 126)
"You belong here.", // Quote 126 (day 127)
"Reach out. Someone cares.", // Quote 127 (day 128)
"Start small. Start now.", // Quote 128 (day 129)
"You are not falling apart  you are falling open.", // Quote 129 (day 130)
"Your worth is unconditional.", // Quote 130 (day 131)
"One moment of calm is progress.", // Quote 131 (day 132)
"You deserve consistency and care.", // Quote 132 (day 133)
"Hard times reveal your strength.", // Quote 133 (day 134)
"You are allowed to say no.", // Quote 134 (day 135)
"Healing isn't happening to you  you're making it happen.", // Quote 135 (day 136)
"Be the friend to yourself you wish you had.", // Quote 136 (day 137)
"You are stronger than your darkest thought.", // Quote 137 (day 138)
"Let today be gentle.", // Quote 138 (day 139)
"Self compassion is the foundation.", // Quote 139 (day 140)
"You are never too far gone.", // Quote 140 (day 141)
"Small wins are still wins.", // Quote 141 (day 142)
"Let yourself be loved.", // Quote 142 (day 143)
"You are on your own path.", // Quote 143 (day 144)
"What you feel matters.", // Quote 144 (day 145)
"Keep showing up for yourself.", // Quote 145 (day 146)
"You deserve peace of mind.", // Quote 146 (day 147)
"The storm will pass.", // Quote 147 (day 148)
"You are seen, heard, and valued.", // Quote 148 (day 149)
"Be here. That's enough.", // Quote 149 (day 150)
"Take one step. Then one more.", // Quote 150 (day 151)
"Light finds its way through cracks.", // Quote 151 (day 152)
"You are not alone in this.", // Quote 152 (day 153)
"Give yourself permission to grow.", // Quote 153 (day 154)
"Your healing matters to the world.", // Quote 154 (day 155)
"One deep breath can shift everything.", // Quote 155 (day 156)
"You are learning and that is enough.", // Quote 156 (day 157)
"Not all progress is visible.", // Quote 157 (day 158)
"You are allowed to change your mind.", // Quote 158 (day 159)
"Kindness to self ripples outward.", // Quote 159 (day 160)
"You can begin again, always.", // Quote 160 (day 161)
"Hope is a practice.", // Quote 161 (day 162)
"Your voice matters.", // Quote 162 (day 163)
"The present moment is manageable.", // Quote 163 (day 164)
"You are not your worst day.", // Quote 164 (day 165)
"Strength grows in soft places too.", // Quote 165 (day 166)
"You have permission to feel better.", // Quote 166 (day 167)
"Let your emotions move through you.", // Quote 167 (day 168)
"You are always becoming.", // Quote 168 (day 169)
"It is brave to seek help.", // Quote 169 (day 170)
"You deserve gentleness.", // Quote 170 (day 171)
"Take up all the space you need.", // Quote 171 (day 172)
"Calm is always just a breath away.", // Quote 172 (day 173)
"You are worthy of a full life.", // Quote 173 (day 174)
"Embrace the uncertain.", // Quote 174 (day 175)
"You are not your anxiety.", // Quote 175 (day 176)
"Each day holds something small and good.", // Quote 176 (day 177)
"You are doing your best.", // Quote 177 (day 178)
"Give yourself time.", // Quote 178 (day 179)
"Your story is still unfolding.", // Quote 179 (day 180)
"There is hope in the trying.", // Quote 180 (day 181)
"You are allowed to rest today.", // Quote 181 (day 182)
"Take care of the body that carries you.", // Quote 182 (day 183)
"Joy is allowed, even now.", // Quote 183 (day 184)
"You are learning what you need.", // Quote 184 (day 185)
"Peace is a practice, not a destination.", // Quote 185 (day 186)
"You are holding so much  set some down.", // Quote 186 (day 187)
"There's courage in every comeback.", // Quote 187 (day 188)
"You don't have to figure it all out today.", // Quote 188 (day 189)
"Breathe. You are still here.", // Quote 189 (day 190)
"Your health is your wealth.", // Quote 190 (day 191)
"You can feel scared and still move forward.", // Quote 191 (day 192)
"The hard parts don't last forever.", // Quote 192 (day 193)
"You are worthy of all good things.", // Quote 193 (day 194)
"It's okay to need others.", // Quote 194 (day 195)
"You are not defined by your struggles.", // Quote 195 (day 196)
"Find one thing to be grateful for.", // Quote 196 (day 197)
"You are more than enough.", // Quote 197 (day 198)
"Be easy on yourself today.", // Quote 198 (day 199)
"Your emotions are data, not destiny.", // Quote 199 (day 200)
"You are healing in ways you can't yet see.", // Quote 200 (day 201)
"Ask for help. It's strength.", // Quote 201 (day 202)
"You deserve a peaceful mind.", // Quote 202 (day 203)
"Choose one gentle thing for yourself today.", // Quote 203 (day 204)
"You are not behind.", // Quote 204 (day 205)
"Let the good moments land.", // Quote 205 (day 206)
"You are always allowed to start fresh.", // Quote 206 (day 207)
"Your wellbeing is worth protecting.", // Quote 207 (day 208)
"Be as kind to yourself as you are to others.", // Quote 208 (day 209)
"You are still standing. That matters.", // Quote 209 (day 210)
"Healing is your birthright.", // Quote 210 (day 211)
"Take your time. There's no rush.", // Quote 211 (day 212)
"You've made it through every hard day.", // Quote 212 (day 213)
"Let yourself be imperfect.", // Quote 213 (day 214)
"You are resilient by nature.", // Quote 214 (day 215)
"Peace is possible for you.", // Quote 215 (day 216)
"Your inner world deserves attention.", // Quote 216 (day 217)
"Emotions are not weaknesses.", // Quote 217 (day 218)
"You are worthy of calm.", // Quote 218 (day 219)
"Look how far you've come.", // Quote 219 (day 220)
"You don't have to earn rest.", // Quote 220 (day 221)
"Connection is medicine.", // Quote 221 (day 222)
"Your wounds can become wisdom.", // Quote 222 (day 223)
"Be proud of invisible battles won.", // Quote 223 (day 224)
"You are allowed to thrive.", // Quote 224 (day 225)
"It's okay to feel uncertain.", // Quote 225 (day 226)
"You are not your fears.", // Quote 226 (day 227)
"There is no shame in needing support.", // Quote 227 (day 228)
"You are bigger than your bad days.", // Quote 228 (day 229)
"One kind thought toward yourself matters.", // Quote 229 (day 230)
"You are worth the effort.", // Quote 230 (day 231)
"Mindfulness is coming home to yourself.", // Quote 231 (day 232)
"Your recovery is real, even when slow.", // Quote 232 (day 233)
"You are allowed to outgrow what hurts.", // Quote 233 (day 234)
"Be proud of who you are becoming.", // Quote 234 (day 235)
"You have always found a way.", // Quote 235 (day 236)
"Gentleness is a form of courage.", // Quote 236 (day 237)
"Your existence is enough.", // Quote 237 (day 238)
"You don't owe anyone your breakdown.", // Quote 238 (day 239)
"Something good is still possible.", // Quote 239 (day 240)
"You are worth showing up for.", // Quote 240 (day 241)
"Even in stillness, you are growing.", // Quote 241 (day 242)
"Be compassionate with your pace.", // Quote 242 (day 243)
"New seasons bring new possibilities.", // Quote 243 (day 244)
"You are not stuck forever.", // Quote 244 (day 245)
"Keep tending to your roots.", // Quote 245 (day 246)
"Your feelings deserve acknowledgment.", // Quote 246 (day 247)
"You can and you will.", // Quote 247 (day 248)
"The bravest thing is being honest with yourself.", // Quote 248 (day 249)
"You are not powerless.", // Quote 249 (day 250)
"Let go a little more each day.", // Quote 250 (day 251)
"You are worthy of consistent care.", // Quote 251 (day 252)
"Slow days are still days forward.", // Quote 252 (day 253)
"Your thoughts are not facts.", // Quote 253 (day 254)
"You are allowed to want more for yourself.", // Quote 254 (day 255)
"Choose compassion over criticism today.", // Quote 255 (day 256)
"You are always in the right place to begin.", // Quote 256 (day 257)
"It gets lighter.", // Quote 257 (day 258)
"You are more than your hardest moments.", // Quote 258 (day 259)
"Every act of self care counts.", // Quote 259 (day 260)
"You are not what you fear.", // Quote 260 (day 261)
"Hold on. Help is there.", // Quote 261 (day 262)
"Your pain is temporary.", // Quote 262 (day 263)
"You deserve people who show up.", // Quote 263 (day 264)
"What you're going through is real.", // Quote 264 (day 265)
"You are enough in this season too.", // Quote 265 (day 266)
"Let hope outlast the hard.", // Quote 266 (day 267)
"You have inner resources you haven't tapped yet.", // Quote 267 (day 268)
"Rest is a form of resistance.", // Quote 268 (day 269)
"You are healing, not failing.", // Quote 269 (day 270)
"There is room for your struggle and your strength.", // Quote 270 (day 271)
"Be tender with yourself today.", // Quote 271 (day 272)
"You are not done yet.", // Quote 272 (day 273)
"Even on hard days, you are growing.", // Quote 273 (day 274)
"You are allowed to ask for more support.", // Quote 274 (day 275)
"Your mental health deserves investment.", // Quote 275 (day 276)
"You don't have to perform wellness.", // Quote 276 (day 277)
"Every breath is a fresh start.", // Quote 277 (day 278)
"You are never truly alone.", // Quote 278 (day 279)
"This feeling will move.", // Quote 279 (day 280)
"You are worthy of understanding.", // Quote 280 (day 281)
"Kindness is always available  offer it to yourself.", // Quote 281 (day 282)
"You are doing better than you think.", // Quote 282 (day 283)
"It's okay to not feel okay.", // Quote 283 (day 284)
"You can face this.", // Quote 284 (day 285)
"Small acts of care add up.", // Quote 285 (day 286)
"You are brighter than you believe.", // Quote 286 (day 287)
"Choose one kind thing for yourself.", // Quote 287 (day 288)
"Your healing is allowed to be messy.", // Quote 288 (day 289)
"You are not your darkest hour.", // Quote 289 (day 290)
"Let today be a soft landing.", // Quote 290 (day 291)
"You matter, fully and completely.", // Quote 291 (day 292)
"Healing doesn't always look like healing.", // Quote 292 (day 293)
"You are loved exactly as you are.", // Quote 293 (day 294)
"The good is still there, even when hidden.", // Quote 294 (day 295)
"You are an act of courage simply by continuing.", // Quote 295 (day 296)
"Find your people. They exist.", // Quote 296 (day 297)
"You are stronger at the broken places.", // Quote 297 (day 298)
"It's okay to not have it together.", // Quote 298 (day 299)
"Your sensitivity makes you powerful.", // Quote 299 (day 300)
"You have come so far already.", // Quote 300 (day 301)
"Today, just try.", // Quote 301 (day 302)
"You are not your setbacks.", // Quote 302 (day 303)
"Every step toward yourself counts.", // Quote 303 (day 304)
"Gratitude and grief can live together.", // Quote 304 (day 305)
"You are worth the investment of time.", // Quote 305 (day 306)
"Be here. Be soft. Be kind.", // Quote 306 (day 307)
"You are allowed to feel hopeful.", // Quote 307 (day 308)
"Somewhere someone understands.", // Quote 308 (day 309)
"You are not too much.", // Quote 309 (day 310)
"Let yourself receive kindness.", // Quote 310 (day 311)
"You are healing at exactly the right pace.", // Quote 311 (day 312)
"Choose warmth over judgment today.", // Quote 312 (day 313)
"You are a survivor, not a victim.", // Quote 313 (day 314)
"Your feelings are information.", // Quote 314 (day 315)
"You deserve a second chance  from yourself.", // Quote 315 (day 316)
"Joy is not something you have to earn.", // Quote 316 (day 317)
"You are allowed to grieve what's hard.", // Quote 317 (day 318)
"There is wisdom in your wounds.", // Quote 318 (day 319)
"You can cope. You have before.", // Quote 319 (day 320)
"You are held by more than you know.", // Quote 320 (day 321)
"Be curious about your inner life.", // Quote 321 (day 322)
"You are exactly where you need to be.", // Quote 322 (day 323)
"Growth doesn't always feel like growth.", // Quote 323 (day 324)
"You are allowed to hope again.", // Quote 324 (day 325)
"Your experiences have shaped but not broken you.", // Quote 325 (day 326)
"You matter in this world.", // Quote 326 (day 327)
"Let yourself be cared for.", // Quote 327 (day 328)
"You are never too old to begin healing.", // Quote 328 (day 329)
"One person who believes in you can change everything.", // Quote 329 (day 330)
"You have permission to exhale.", // Quote 330 (day 331)
"Your life has meaning.", // Quote 331 (day 332)
"It's okay to need what you need.", // Quote 332 (day 333)
"You are allowed to be well.", // Quote 333 (day 334)
"End the year gently.", // Quote 334 (day 335)
"You made it through.", // Quote 335 (day 336)
"Be proud of every step, no matter how small.", // Quote 336 (day 337)
"You've grown in ways you don't yet see.", // Quote 337 (day 338)
"Celebrate your survival.", // Quote 338 (day 339)
"You deserve rest at year's end.", // Quote 339 (day 340)
"Let the season slow you down.", // Quote 340 (day 341)
"You are not obligated to perform happiness.", // Quote 341 (day 342)
"This year, you kept going. That matters.", // Quote 342 (day 343)
"Give yourself credit for hard days survived.", // Quote 343 (day 344)
"You are more than the year's hardest moments.", // Quote 344 (day 345)
"Warmth lives within you.", // Quote 345 (day 346)
"You are allowed to need extra care this season.", // Quote 346 (day 347)
"Even in the dark, you carried light.", // Quote 347 (day 348)
"You are not behind  you are becoming.", // Quote 348 (day 349)
"Let this season be one of restoration.", // Quote 349 (day 350)
"You deserve joy without conditions.", // Quote 350 (day 351)
"Reach out. Someone is reaching for you too.", // Quote 351 (day 352)
"You don't have to have it all figured out.", // Quote 352 (day 353)
"Hope is a choice you can make every morning.", // Quote 353 (day 354)
"You are worthy of a new beginning.", // Quote 354 (day 355)
"Let yourself be held by something greater.", // Quote 355 (day 356)
"The new year doesn't fix things  you do, slowly, with help.", // Quote 356 (day 357)
"You are enough to walk into tomorrow.", // Quote 357 (day 358)
"Your story continues.", // Quote 358 (day 359)
"You are resilient in ways you're still discovering.", // Quote 359 (day 360)
"Keep going. The world needs you.", // Quote 360 (day 361)
"You are worthy of peace, now and always.", // Quote 361 (day 362)
"Rest here. You've earned it.", // Quote 362 (day 363)
"You have what it takes.", // Quote 363 (day 364)
"You are still here. And that is everything.", // Quote 364 (day 365)

];
document.addEventListener("DOMContentLoaded", function() {

    function getDayOfYear() {
        const now = new Date();
        const start = new Date(now.getFullYear(), 0, 1);
        return Math.floor((now - start) / (1000 * 60 * 60 * 24));
    }

    const subtitle = document.getElementById("quote-subtitle");
    const quoteText = document.getElementById("quote-text");

    const index = getDayOfYear() % quotes.length;

    console.log("Today index:", index);
    console.log("Quote at index:", quotes[index]);
    console.log("Type:", typeof quotes[index]);

    subtitle.textContent = "EMPOWERING COMMUNITY";
    quoteText.textContent = quotes[index];

});</script>
</body>
</html>