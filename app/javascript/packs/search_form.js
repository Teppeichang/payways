$(function(){
  
  // 検索フォームの✖ボタンをデフォルトで非表示
  $("#header-search-reset").hide();
  // 検索フォームをクリックすると✖ボタンが表示される
  $(".header-search-input").on("click", function(){
    $("#header-search-reset").show();
  });

  // ✖ボタンをクリックすると入力されている文字を全削除する
  $("#header-search-reset").click(function(){
    $(this).parent().find("input").val("");
  });

  // 検索フォームの外をクリックすると✖ボタンが非表示になる
  $(document).on("click touchend", function(){
    if (!$(event.target).closest(".header-search-input").length){
      $("#header-search-reset").hide();
    }
  });
});