(function($) {
  $.fn.inputFilter = function(inputFilter) {
    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function() {
      if (inputFilter(this.value)) {
        this.oldValue = this.value;
        this.oldSelectionStart = this.selectionStart;
        this.oldSelectionEnd = this.selectionEnd;
      } else if (this.hasOwnProperty("oldValue")) {
        this.value = this.oldValue;
        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
      }
    });
  };
}(jQuery));

$(document).on('contextmenu', function(event) {
    event.preventDefault();
});

function str_reverse(str) {
  var splitString = str.split("");
  var reverseArray = splitString.reverse();
  var joinArray = reverseArray.join("");
  return joinArray;
}

$(document).ready(function() {
  var actionContainer = $(".inventory-mask, .inventory-content");

  window.addEventListener("message", function(event) {
    var item = event.data;
    switch (item.action) {
      case "showMenu":
        updateMochila();
        actionContainer.fadeIn(500);
        break;

      case "hideMenu":
        actionContainer.fadeOut(500);
        break;

      case "updateMochila":
        updateMochila();
        break;
    }
  });

  document.onkeyup = function(data) {
    if (data.which == 27) {
      $.post("http://vrp_inventory/invClose", JSON.stringify({}), function(datab) {});
    }
  };
});

const formatarNumero = n => {
  var n = n.toString();
  var r = "";
  var x = 0;

  for (var i = n.length; i > 0; i--) {
    r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
    x = x == 2 ? 0 : x + 1;
  }

  return r
    .split("")
    .reverse()
    .join("");
};

var updateMochila = () => {

  $.post("http://vrp_inventory/requestMochila", JSON.stringify({}), data => {
    var nameList = data.inventario.sort((a, b) => (a.name > b.name ? 1 : -1));
    $('.inventory-title').html(`
      Inventário <small>[ <b>${data.peso.toFixed(2)}kg</b>  em uso ][ <b>${(data.maxpeso - data.peso).toFixed(2)}kg</b>  livre de  <b>${data.maxpeso.toFixed(2)}kg</b> ]</small>
    `);
    $(".row.objects").html(`
    ${nameList
      .map(
        item => `
        <div class="cell" data-item-key="${item.key}" data-item-type="${item.type}">
        <div class="options">
          <div class="option" data-event="use">Usar</div>
          <div class="option" data-event="send">Enviar</div>
          <div class="option" data-event="drop">Dropar</div>
        </div>
        <div class="amount-option">
          <div class="row">
            <div class="left">
              <div class="plus"><i class="fas fa-minus"></i></div>
            </div>
            <div class="center"><input type="text" class="amount-value" placeholder="0" style="border: 0px; outline: 0px; width: 100%; height: 100%; text-align: center; padding-left: 5px; padding-right: 5px;" /></div>
            <div class="right">
              <div class="minus"><i class="fas fa-plus"></i></div>
            </div>
          </div>
          <div class="row">
            <button class="button" data-event="send">Enviar</button>
          </div>
          <div class="row">
            <button class="button cancel" data-event="cancel">Cancelar</button>
          </div>
        </div>
        <div class="row">
          <span class="amount">${formatarNumero(item.amount)}</span>
        </div>
        <div class="row">
          <div class="image" style="background-image: url('imagens/${item.index}.png')"></div>
        </div>
        <div class="row">
          <div class="name">${item.name} <i>(${(item.peso * item.amount).toFixed(2)}kg)</i></div>
        </div>
      </div>
    `
      )
      .join("")}
		`);
  });
};


window.Option = false;

$(document).ready(function() {
  $(document).on('mousedown', '.objects .cell', function(ev){
    if(ev.which == 3) {
      $(".cell .options").hide();
      $('.amount-option').hide();
      $(this).find('.options').show();
    }
  });

  $(document).on('click', function(e) {
    if (!$(e.target).is(".objects .cell").length) {
      $(".cell .options").hide();
    }
  });

  $(document).on('click', '.options .option', function() {
    var event = $(this).data('event');
    var parentEl = $(this).closest('.cell');
    if(event == 'send' || event == 'drop') {
      Option = event;
      parentEl.find('.amount-option').show();
      parentEl.find('.amount-option').find('input').val('');
    } else if(event == 'use') {
      var $el = $(this).closest('.cell');
      var amount = 1;
      $.post(
        "http://vrp_inventory/useItem",
        JSON.stringify({
          item: $el.data("item-key"),
          type: $el.data("item-type"),
          amount
        })
      );
    }
  });

  $(document).on('click', '.amount-option button', function() {
    var event = $(this).data('event');
    if(event == 'send') {
      var paramUrl = (Option == 'send' ? 'sendItem' : 'dropItem');
      var $el = $(this).closest('.cell');
      var amount = Number($el.find(".amount-value").val());
      $.post(
        "http://vrp_inventory/" + paramUrl,
        JSON.stringify({
          item: $el.data("item-key"),
          amount
        })
      );
    }

    Option = false;

    $('.amount-option').hide();
  });

  $(".row.objects").on('focusout blur', '.amount-option .center input', function() {
    /*if($(this).val() < 0 || $(this).val() == '') {
      $(this).attr('placeholder', '0');
    }*/
  }).inputFilter(function(value) {
    return /^\d*$/.test(value); 
  });
  
  $(".row.objects").on('click', '.amount-option .left', function() {
    var amountVal = $(this).closest('.cell').find(".amount-option .center input");
    if(amountVal.val() == '') {
      amountVal.val('0');
    }
    if((parseInt(amountVal.val()) - 1) >= 0) {
      amountVal.val(parseInt(amountVal.val()) - 1);
    }
  });
  
  $(".row.objects").on('click', '.amount-option .right', function() {
    var amountVal = $(this).closest('.cell').find(".amount-option .center input");
    if(amountVal.val() == '') {
      amountVal.val('0');
    }
    amountVal.val(parseInt(amountVal.val()) + 1);
  });
});