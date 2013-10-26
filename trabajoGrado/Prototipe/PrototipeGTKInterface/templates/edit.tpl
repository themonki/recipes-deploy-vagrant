    <div class=forms >
        <h1>Editar datos básicos</h1>
        <form if="formEdit" name="formEdit" action ="{SITE_CONTROLADOR}/personal/Edit.php" method="POST"> 
            <div class="field">
                <div class="{MESSAGE_CLASS}">
                    {MESSAGE}
                </div>
            </div>
            <div class="field"> 
                <label class="label" for="email">
                    Correo Electrónico:
                </label>
                <input class="text-field" name="email" id="email" value="{EMAIL}" required disabled/>
            </div>
            <div class="field"> 
                <label class="label" for="name">
                    Nombre: 
                </label>
                <input class="text-field" name="name" id="name" value="{NAME}" required/>
            </div>            
            <div class="field" for="passwordNew"> 
                <label class="label">
                    Contraseña Nueva: 
                </label> 
                <input class="text-field" type="password" name="passwordNew" id="passwordNew" onkeyup="validatePattern(form, this);"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}"/>
            </div>
            <div class="field" for="passwordConfirmation"> 
                <label class="label">
                    Confirmar Contraseña Nueva:
                </label>
                <input class="text-field" type="password" name="passwordConfirmation" id="passwordConfirmation" onkeyup="validatePattern(form, this);"
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}" />
            </div>
            <input class="button" type="submit" value="Actualizar"/>
        </form>
    </div>
