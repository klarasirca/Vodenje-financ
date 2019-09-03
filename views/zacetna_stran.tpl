%rebase("osnova")

<form class="dropdown-menu p-4">
  <div class="form-group">
    <label for="ImePriimek">Ime in Priimek</label>
    <input type="text" class="form-control" id="ImePriimek" placeholder="Ime Priimek">
  </div>
  <div class="form-group">
    <label for="racun">Številka računa</label>
    <input type="text" class="form-control" id="racun" placeholder="e.g.: racun0">
  </div>
  <div class="form-group">
    <div class="form-check">
      <input type="checkbox" class="form-check-input" id="dropdownCheck2">
      <label class="form-check-label" for="dropdownCheck2">
        Remember me
      </label>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">Sign in</button>
</form>