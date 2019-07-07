// Creates a variable called body
var body = document.querySelector("body"), 
  goLight = function() { // Adds 'light' class to the body
    body.className = "";
    body.classList.add("light");
  },
  goDark = function() { // Removes 'light' class from body
    body.className = "";
  }

// Execute goLight function if button 1 is clicked
document.querySelector(".theme1").addEventListener("click", goLight, false);

// Execute goDark function if button 2 is clicked
document.querySelector(".theme2").addEventListener("click", goDark, false);

function myToggle() {
  // Get the checkbox
  var checkBox = document.getElementById("cssSwitch");
  checkBox.addEventListener("checked", goLight, false);

  // If the checkbox is checked, display the output text
  if (checkBox.checked == true){
    goLight();
  } else {
    goDark();
  }
} 
