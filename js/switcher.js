// Creates a variable called body
var body = document.querySelector("body"), 
  goLight = function() { // Adds 'light' class to the body
    body.className = "";
    body.classList.add("light");
  },
  goDark = function() { // Removes 'light' class from body
    body.className = "";
  }

document.querySelector(".theme1").addEventListener("click", goLight, false); // Tells the first button to run the goLight function when clicked

document.querySelector(".theme2").addEventListener("click", goDark, false); // Tells the second button to run the goDark function when clicked
