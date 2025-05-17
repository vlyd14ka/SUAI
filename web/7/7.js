let nameBut=document.getElementById("NameButton");
let decBut=document.getElementById("DecButton");
let expBut=document.getElementById("ExpButton");
let arrBut=document.getElementById("ArrButton");


function getName(){
alert('Меня зовут Владислав Тарапанов')
}

function getAlertD(){
alert('Группа 4128')
}

var getAlertE=function(){
alert('ГУАП')
}

var getAlertA=()=>alert('2024')

nameBut.addEventListener("click", getName);
decBut.addEventListener("click", getAlertD);
expBut.addEventListener("click", getAlertE);
arrBut.addEventListener("click", getAlertA);