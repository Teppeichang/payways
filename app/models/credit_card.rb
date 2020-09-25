class CreditCard < ActiveHash::Base
  self.data = [
    {id: 1, name: "一覧より選択してください"},
    {id: 2, name: "Visa"},
    {id: 3, name: "MasterCard"},
    {id: 4, name: "JCB"},
    {id: 5, name: "アメリカン・エキスプレス"},
    {id: 6, name: "ダイナースクラブ"},
  ]
end
