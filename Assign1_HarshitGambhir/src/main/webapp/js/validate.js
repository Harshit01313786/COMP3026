let zipRule = "NUMERIC"; 

function $(id) {
  return document.getElementById(id);
}

function show(id) {
  $(id).style.visibility = "visible";
}

function hide(id) {
  $(id).style.visibility = "hidden";
}

function initForm() {
  
  hide("userIdMsg");
  hide("passwordMsg");
  hide("nameMsg");
  hide("countryMsg");
  hide("zipMsg");
  hide("emailMsg");
  hide("sexMsg");
  hide("languageMsg");

  updateZipRule(); 
}


function updateZipRule() {
  const c = $("country").value;

  
  if (c === "Canada") {
    zipRule = "ALPHANUMERIC";
    $("zipMsg").innerText = "Required. Must be alphanumeric only.";
  } else {
    zipRule = "NUMERIC";
    $("zipMsg").innerText = "Required. Must be numeric only.";
  }

 
  validateZip(false);
}



function validateUserId(showError) {
  const v = $("userId").value.trim();
  const ok = v.length >= 5 && v.length <= 12;

  if (ok) hide("userIdMsg");
  else if (showError) show("userIdMsg");

  return ok;
}

function validatePassword(showError) {
  const v = $("password").value.trim();
  const ok = v.length >= 7 && v.length <= 12;

  if (ok) hide("passwordMsg");
  else if (showError) show("passwordMsg");

  return ok;
}

function validateName(showError) {
  const v = $("name").value.trim();
  
  const ok = v.length > 0 && /^[A-Za-z ]+$/.test(v);

  if (ok) hide("nameMsg");
  else if (showError) show("nameMsg");

  return ok;
}

function validateCountry(showError) {
  const ok = $("country").value !== "";

  if (ok) hide("countryMsg");
  else if (showError) show("countryMsg");

  return ok;
}

function validateZip(showError) {
  const v = $("zip").value.trim();
  let ok = false;

  if (v.length === 0) {
    ok = false;
  } else if (zipRule === "ALPHANUMERIC") {
    
    ok = /^[A-Za-z0-9 ]+$/.test(v);
  } else {
    
    ok = /^[0-9]+$/.test(v);
  }

  if (ok) hide("zipMsg");
  else if (showError) show("zipMsg");

  return ok;
}

function validateEmail(showError) {
  const v = $("email").value.trim();
  const ok = v.length > 0 && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);

  if (ok) hide("emailMsg");
  else if (showError) show("emailMsg");

  return ok;
}

function validateSex(showError) {
  const ok = $("male").checked || $("female").checked;

  if (ok) hide("sexMsg");
  else if (showError) show("sexMsg");

  return ok;
}

function validateLanguage(showError) {
  const ok = $("english").checked || $("nonEnglish").checked;

  if (ok) hide("languageMsg");
  else if (showError) show("languageMsg");

  return ok;
}



function validateForm() {
  const a = validateUserId(true);
  const b = validatePassword(true);
  const c = validateName(true);
  const d = validateCountry(true);
  const e = validateZip(true);
  const f = validateEmail(true);
  const g = validateSex(true);
  const h = validateLanguage(true);

  return a && b && c && d && e && f && g && h;
}