<div class="containerText">
    <div class="name">
        <h2>{NAME}</h2>
    </div>
    <div class="email">
        <h3>{EMAIL}</h3>
    </div>
    <div class=passwords >
        <form name="ValidationForm" onsubmit="validatePassword();"  action ="index.php" method="POST">
            Contraseña Actual: <input type="password" id="passwordOld" required/>
            Contraseña Nueva: <input type="password" id="passwordNew" required/>
            Confirmar Contraseña Nueva:<input type="password" id="passwordConfirmation" required/>
            <input type="submit" value="submit"/>
        </form>
    </div>
</div>