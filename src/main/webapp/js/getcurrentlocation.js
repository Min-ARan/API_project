function askForCoords(){
	navigator.geolocation.getCurrentPosition(onGeoOk,onGeoError);
}


function onGeoOk(position){
    const lat = position.coords.latitude;
    const lnt = position.coords.longitude;
    
    document.getElementById("input-lat").value = lat;
    document.getElementById("input-lnt").value = lnt;
}


function onGeoError(){
    alert("현재 위치를 찾을 수 없습니다.(허용 버튼을 눌러주세요.)");
}