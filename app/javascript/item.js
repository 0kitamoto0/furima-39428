function calculateProfit() {
  const amountInput = document.getElementById('item-price');
  const result90 = document.getElementById('profit');
  const result10 = document.getElementById('add-tax-price');

  amountInput.addEventListener("keyup", () => {
    const amount = parseFloat(amountInput.value);
    const profit10 = Math.floor(amount * 0.1); // 金額の10%を切り捨てて計算
    const profit90 = amount - profit10; // 金額の90%を切り捨てて計算
    result90.innerHTML = `${profit90}`; // price-contentに金額の90%を表示
    result10.innerHTML = `${profit10}`; // add-tax-priceに金額の10%を表示
  });
}

window.addEventListener('turbo:load', calculateProfit);