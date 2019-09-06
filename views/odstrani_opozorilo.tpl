%rebase('osnova')

<div align="center">
<h1>Odstranite opozorilo</h1>

<h5>Kategorij, ki še niso nastavljene za opozorila ni mogoče odstraniti. Opozorilo lahko kasneje spet dodate.</h5>


<form action="/odstranjeno/" method="POST">
                <h5>Kategorija: </h5>
                                        <select name = "kategorija_limit" class="form-control-sm">
                                        %for kategorija in seznam_kategorij_opozorila:
                                                <option value="{{ kategorija }}">{{ kategorija }}</option>
                                                %end
                                        %for kategorija in seznam_kategorij_neopozorila:
                                        <option value="{{ kategorija }}" disabled>{{ kategorija }}</option>
                                                %end

                                        </select> <br>
                                        
                                
  <input class="btn btn-outline-secondary" type="submit" value="Odstrani">
</form>
</div>