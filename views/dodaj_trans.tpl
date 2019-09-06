% rebase('osnova')

<div class="container">

        <div align="center">
                <h1> Dodaj transakcijo:</h1>
        </div>

        <div align="center">
                <form action="/dodaj_transakcijo" method="post">
                        <input type="hidden" name="tip" value="{{ tip }}"/>
                        <h5>Znesek:
                                <input type="number"  class="form-control-sm" name="znesek" value="0"><br></h5>
                        
                        <div class="form-group col-md-4">
                                <h5>Kategorija:
                                        <select name = "kategorija" class="form-control-sm">
                                        % for kategorija in seznam_kategorij:
                                                <option value="{{ kategorija }}">{{ kategorija }}</option>
                                        % end
                                        </select><br></h5>
                                
                        </div>
                        <h5>Komentar: <input type="text" class="form-control-sm" name="komentar"/><br></h5>
                        <input class="btn btn-outline-secondary" type="submit" value="Dodaj">
                </form>
        </div>

</div>

    