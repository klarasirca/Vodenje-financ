%rebase("osnova")

<div class ="container">

<div align="center">
<h1> Dobrodošli na strani za vodenje osebnih financ! </h1>
</div>

<h5>Če želite, da so vaši računi čisti, vaša denarnica organizirana ter polna, se vpišite ter začnite z vodenjem svojih osebnih financ že danes!</h5>

<div align="right">
  <h4><a href="/registracija/" class="btn btn-outline-secondary" role="button" aria-pressed="true">Registriraj se</a></h4>
</div>


<img src="../../img/denarcek.jpeg" class="rounded float-right"" alt="Denarcek">

%if login == False:
<div id = "overlay" class="alert alert-warning alert-dismissible fade show" role="alert">
  Registriraj se, da ti stran dodeli številko računa!
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
%end



<h3>Log in:</h3>
<form action="/prijava/" method ="post">

  <h5>Številka računa: <input type="number"class="form-control-sm"  name="racunid"></h5>
  <input type="submit" class="btn btn-outline-secondary" value="Vpiši se">
</form>

</div>








<div align="right">
    <footer>© 2019, Klara Širca</footer>
</div>
</div>