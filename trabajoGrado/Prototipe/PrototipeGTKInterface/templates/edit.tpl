<div class="containerText">
    <div class="name">
        <h2>{NAME}</h2>
    </div>
    <div class="email">
        <h3>{EMAIL}</h3>
    </div>
    <div class=passwords >
        <form name="ValidationForm"   action ="index.php" method="POST">

            <div class=field> 
                <label class="label" for="passwordOld">
                    Contraseña Actual: 
                </label>
                <input class="text-field" type="password" name="passwordOld" id="passwordOld" required/>
            </div>
            <div class=field for="passwordNew"> 
                <label class="label">
                    Contraseña Nueva: 
                </label> 
                <input class="text-field" type="password" name="passwordNew" id="passwordNew" required onkeyup="validatePattern(form, this);"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}"/>
            </div>
            <div class=field for="passwordConfirmation"> 
                <label class="label">
                    Confirmar Contraseña Nueva:
                </label>
                <input class="text-field" type="password" name="passwordConfirmation" id="passwordConfirmation" required onkeyup="validatePattern(form, this);"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}" />
            </div>
            <input class="button" type="submit" value="Actualizar"/>
        </form>
    </div>
</div>