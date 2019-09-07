%rebase('osnova')

<div align="right">
    <h4><a href="/domaca_stran/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Domov</a></h4>
  </div>


<div align="center">
        <h1>Odstranite opozorilo</h1>

        <h5>Kategorij, ki še niso nastavljene za opozorila ni mogoče odstraniti. Opozorilo lahko kasneje spet dodate.</h5>


        <form action="/odstranjeno/" method="POST">
                <h5>Kategorija: 
                        <select name = "kategorija_limit" class="form-control-sm" required>
                                <option value="">Izberi</option>
                                %for kategorija in seznam_kategorij_opozorila:
                                        <option value="{{ kategorija }}">{{ kategorija }}</option>
                                %end
                                %for kategorija in seznam_kategorij_neopozorila:
                                        <option value="{{ kategorija }}" disabled>{{ kategorija }}</option>
                                %end
                        </select> <br></h5>

                <input class="btn btn-outline-secondary" type="submit" value="Odstrani">
        </form>
</div>