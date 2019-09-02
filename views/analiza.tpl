% rebase('osnova')


%for kategorija in slovar_zapravljeno.keys():
<div class="container">
  <p>Pod kategorijo {{kategorija}} si v mesecu {{meseci[mesec - 1]}} leta {{leto}} zapravil/a {{slovar_zapravljeno[kategorija]}} EUR.</p>
</div>

%end
   


%for kategorija in slovar_zasluzeno.keys():
<div class="container">
<p>Pod kategorijo {{kategorija}} si  v mesecu {{meseci[mesec - 1]}} leta {{leto}} zaslužil/a {{slovar_zasluzeno[kategorija]}} EUR.</p>
</div>

%end


<div class="container">
<p>Skupaj si v mesecu {{meseci[mesec - 1]}} leta {{leto}} zapravil/a {{skupaj_odhodki}}.</p>
</div>

<div class="container">
<p>Skupaj si v mesecu {{meseci[mesec - 1]}} leta {{leto}} zaslužil/a {{skupaj_prihodki}}.</p>
</div>


%for kategorija in slovar_procentov_odhodek.keys():
<div class="container">
  <p>Procentualno si za {{kategorija}} zapravil/a {{slovar_procentov_odhodek[kategorija]}} od vseh svojih odhodkov.</p>
</div>

%end


%for kategorija in slovar_procentov_prihodek.keys():
<div class="container">
  <p>Procentualno si od {{kategorija}} zaslužil/a {{slovar_procentov_prihodek[kategorija]}} od vseh svojih prihodkov.</p>
</div>

%end



   