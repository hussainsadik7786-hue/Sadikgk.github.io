<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<title>Sadik GS Test</title>

<style>

body{
font-family: Arial;
margin:20px;
background:#f5f5f5;
}

.watermark{
position:fixed;
top:50%;
left:50%;
transform:translate(-50%,-50%);
font-size:120px;
color:rgba(0,0,0,0.05);
z-index:-1;
}

#timer{
font-size:20px;
font-weight:bold;
color:red;
margin-bottom:20px;
}

.question{
background:white;
padding:15px;
margin-bottom:10px;
border-radius:8px;
}

.correct{
background:#c8f7c5;
}

.wrong{
background:#f7c5c5;
}

button{
padding:10px 20px;
font-size:16px;
cursor:pointer;
}

</style>
</head>

<body>

<div class="watermark">Sadik</div>

<h2>GS Practice Test</h2>

<div id="timer">Time Left: 15:00</div>

<form id="quizForm">

<div class="question">
<p>1. भारत का संविधान भारत को किस रूप में वर्णित करता है?</p>

<input type="radio" name="q1" value="A"> राज्य संघ<br>
<input type="radio" name="q1" value="B"> संघ राज्य<br>
<input type="radio" name="q1" value="C"> लोकतांत्रिक गणराज्य<br>
<input type="radio" name="q1" value="D"> समाजवादी राज्य

</div>

<div class="question">
<p>2. मछलियों के यकृत तेल में कौन-सा विटामिन अधिक होता है?</p>

<input type="radio" name="q2" value="A"> विटामिन A<br>
<input type="radio" name="q2" value="B"> विटामिन B<br>
<input type="radio" name="q2" value="C"> विटामिन C<br>
<input type="radio" name="q2" value="D"> विटामिन D

</div>

<!-- Isi pattern me Q3 se Q65 paste kar dena -->

<br>

<button type="button" onclick="submitQuiz()">Submit Test</button>

</form>

<h3 id="result"></h3>

<script>

let time = 900;

let timer = setInterval(function(){

let minutes = Math.floor(time/60);
let seconds = time%60;

document.getElementById("timer").innerHTML =
"Time Left: "+minutes+":"+(seconds<10?"0":"")+seconds;

time--;

if(time<0){
clearInterval(timer);
submitQuiz();
}

},1000);


function submitQuiz(){

clearInterval(timer);

let answers = {
q1:"B",
q2:"D"
};

let score = 0;

for(let q in answers){

let selected = document.querySelector('input[name="'+q+'"]:checked');

let questionDiv = document.querySelector('input[name="'+q+'"]').closest(".question");

if(selected){

if(selected.value === answers[q]){

score++;
questionDiv.classList.add("correct");

}else{

questionDiv.classList.add("wrong");

}

}else{

questionDiv.classList.add("wrong");

}

}

document.getElementById("result").innerHTML =
"Your Score: "+score+" / 65";

}

</script>

</body>
</html>
