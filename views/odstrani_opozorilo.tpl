%rebase('osnova')

<div align="center">
<h1>Odstranite opozorilo</h1>

<h5>Opozorilo kasneje spet dodate.</h5>


<form action="/odstranjeno/" method="POST">
                <h5>Kategorija: 
                                        <select name = "kategorija_limit" class="form-control-sm">
                                        % for kategorija in seznamK:
                                                <option value="{{ kategorija }}">{{ kategorija }}</option>
                                        % end
                                        </select> <br>
                                </h5>
  <input class="btn btn-outline-secondary" type="submit" value="Dodaj">
</form>
</div>