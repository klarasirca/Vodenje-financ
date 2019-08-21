% rebase('osnova')
  <form action="/dodaj_transakcijo" method="post">
            <input type="hidden" name="tip" value="{{ tip }}"/>
            Znesek: <input type="number" name="znesek" value="0"><br>
            Kategorija: <select name="kategorija">
                        % for kategorija in enumerate(seznamK):
                                <option value="{{ kategorija[0] }}">{{ kategorija[1] }}</option>
                        % end
                </select> <br>
            Komentar: <input type="text" name="komentar"/><br>
            <input type="submit"/>
        </form>