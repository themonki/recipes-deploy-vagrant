/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*https://developer.mozilla.org/en-US/docs/JavaScript_crypto*/
//alert ("scripts");


window.onload = function () {
    
//    document.getElementById("passwordNew").onchange = validatePassword();
//    alert ("load");
//    document.getElementById("passwordConfirmation").onchange = validatePassword();
}
function validatePassword(){
    alert ("validate");
    var pass2=document.getElementById("passwordConfirmation").value;
    var pass1=document.getElementById("passwordNew").value;
    if(pass1!=pass2){alert ("load1");
        document.getElementById("passwordConfirmation").setCustomValidity("Passwords Don't Match");
        return false;
    }
    else {alert ("load2");
        document.getElementById("passwordConfirmation").setCustomValidity('');
        return true;
    }
//empty string means no validation error
}