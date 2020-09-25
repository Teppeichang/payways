class CodePay < ActiveHash::Base
  self.data = [
    {id: 1, name: "一覧より選択してください"},
    {id: 2, name: "PayPay"},
    {id: 3, name: "LINE Pay"},
    {id: 4, name: "楽天ペイ"},
    {id: 5, name: "au PAY"},
    {id: 6, name: "メルペイ"},
    {id: 7, name: "d払い"},
  ]
end
