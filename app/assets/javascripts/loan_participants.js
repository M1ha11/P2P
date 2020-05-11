document.getElementById('participant-new').onclick = function show(event) {
  event.preventDefault();
  document.getElementById('part-form').style.display = 'block';
};

document.getElementById('participant-not').onclick=function hide(event) {
  event.preventDefault();
  document.getElementById('part-form').style.display = 'none';
};
