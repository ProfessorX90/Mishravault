const questions=[
{
q:"2+2=?",
options:["1","2","4","5"],
answer:2
},
{
q:"Capital of India?",
options:["Delhi","Patna","Mumbai","Kolkata"],
answer:0
},
{
q:"H2O is?",
options:["Salt","Water","Gas","Metal"],
answer:1
}
];

let current=0;
let score=0;
function loadQuestion(){
let q=questions[current];

let html=`
<h2>${current+1}. ${q.q}</h2>
`;

q.options.forEach((op,i)=>{
html+=`
<label>
<input type='radio' name='option' value='${i}'> ${op}
</label><br><br>
`;
});

document.getElementById('quizBox').innerHTML=html;
}

loadQuestion();

function nextQuestion(){
let selected=document.querySelector(
'input[name="option"]:checked'
);

if(selected){
if(parseInt(selected.value)===questions[current].answer){
score++;
}
}

current++;

if(current<questions.length){
loadQuestion();
}else{
submitTest();
}
}
function submitTest(){
alert(`Score: ${score}/${questions.length}`);

sendScore();
}

let time=1800;

setInterval(()=>{
if(time<=0){
submitTest();
return;
}

let mins=Math.floor(time/60);
let secs=time%60;
document.getElementById('timer').innerText=
`Time Left: ${mins}:${secs<10?'0':''}${secs}`;
time--;
},1000);

function sendScore(){

// REPLACE WITH YOUR GOOGLE APPS SCRIPT WEB APP URL
const scriptURL='PASTE_SCRIPT_URL_HERE';

fetch(scriptURL,{
method:'POST',
body:new URLSearchParams({
name:document.getElementById('name').value,
email:document.getElementById('email').value,
score:score
})
})
.then(()=>console.log('Saved'))
.catch(err=>console.log(err));
}