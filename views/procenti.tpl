% rebase('osnova')


%for kategorija in slovar_procentov_odhodek.keys():
<div class="container">
  <p>Procentualno si za {{kategorija} zapravil/a {{slovar_procentov_odhodek[kategorija]}} od vseh svojih odhodkov.</p>
</div>

%end


%for kategorija in slovar_procentov_prihodek.keys():
<div class="container">
  <p>Procentualno si od {{kategorija} zaslužil/a {{slovar_procentov_prihodek[kategorija]}} od vseh svojih prihodkov.</p>
</div>

%end