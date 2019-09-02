% rebase('osnova')
  <form action="/dodaj_transakcijo" method="post">
            <input type="hidden" name="tip" value="{{ tip }}"/>
            Znesek: <input type="number" name="znesek" value="0"><br>
            Kategorija: <select name = "kategorija">
                        % for kategorija in seznamK:
                                <option value="{{ kategorija }}">{{ kategorija }}</option>
                        % end
                </select> <br>
            Komentar: <input type="text" name="komentar"/><br>
            <input class="btn btn-outline-secondary" type="submit" value="Submit">
        </form>

    