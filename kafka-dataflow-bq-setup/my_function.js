function transform(inJson) {
 var obj = JSON.parse(inJson);
 obj.city = "Rio de Janeiro";
 obj.credit_card_number = "####-####-####-####";
 return JSON.stringify(obj);
}
