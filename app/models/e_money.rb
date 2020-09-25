class EMoney < ActiveHash::Base
  self.data = [
    {id: 1, name: "一覧より選択してください"},
    {id: 2, name: "WAON"},
    {id: 3, name: "楽天Edy"},
    {id: 4, name: "nanaco"},
    {id: 5, name: "QUICPay"},
    {id: 6, name: "iD"},
    {id: 7, name: "Suica"},
    {id: 8, name: "PASMO"},
    {id: 9, name: "ICOCA"},
  ]
end
