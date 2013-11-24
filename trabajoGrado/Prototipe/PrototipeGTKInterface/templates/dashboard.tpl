<div class=forms >
    <h1>tittle</h1>
    <form if="formEdit" name="formEdit" action ="" method="POST">
        <div class="field">
            <div class="{MESSAGE_CLASS}">
                {MESSAGE}
            </div>
        </div>
        <div class="field"> 
            <label class="label" for="input">
                Input
            </label>
            <input class="text-field" name="input" id="input" value="{VALUE}" required disabled
                   maxlength="200"
                   title=""
                   alt=""
                   />
        </div>
        <span class="noField" >
            <label class="label" >
                label
            </label>
        </span>

        <input class="button" type="submit" value="Button"/>
    </form>
</div>