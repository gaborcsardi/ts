<script>
function openCity(evt, language) {
  var currentTab = evt.srcElement.parentElement.parentElement;
  var i, x, tablinks;
  x = currentTab.getElementsByClassName("ts-package");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = currentTab.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-active", "");
  }
  currentTab.getElementsByClassName("ts-package-" + language)[0].style.display = "block";
  evt.srcElement.className += " w3-active";
}
</script>
