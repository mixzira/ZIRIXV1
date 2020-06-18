/*--------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido pela equipe da Ziraflix Dev Group, por favor mantenha os créditos   ]--
--[                     Contato: contato@ziraflix.com   Discord: discord.gg/6p3M3Cz                    ]--
--------------------------------------------------------------------------------------------------------*/
$(document).ready(function(){
  var $debug = $("#debug");
  var $heal = $("#heal");
  var $box = $("#box");
  var $boxArmor = $("#armor");

  window.addEventListener('message', function(event){
    if ( event.data.display == true ) {
      $('#hud').fadeIn();
      $('body').show();
    }   
    else {
      $('#hud').fadeOut();
    }
    if ( event.data.incar == true ) {
      $('.hud-player').css('background','url(imagens/barra_Esquerda.png) no-repeat');
      $('.hud-player').css('width','220px');
      $('.hud-player').css('right','2%');
      $("#velocimetro").fadeIn(1500);
    }   
    else {
      
      $('.hud-player').css('background','url(imagens/barra_Esquerda.png) no-repeat');
      $('.hud-player').css('width','220px');
      $('.hud-player').css('right','43.8%');
      $("#velocimetro").fadeOut(10);
    }
    if ( event.data.cinto == true ) {
      $('.cinto-icongreen').css('display', 'block');    
      $('.cinto-iconred').css('display', 'none'); 
    }   
    else {
      $('.cinto-iconred').css('display', 'block');
      $('.cinto-icongreen').css('display', 'none'); 
    }
    $("#kmph").html('<span class="velocidade">'+event.data.speed+'</span></br>');
    
    $boxArmor.css("width", (event.data.armor)+"%");
    $heal.css("width", (event.data.heal)+"%");
    
    var data = event.data;

    $("#hunger").css("width", 100 - data.hunger + "%");
    $("#thirst").css("width", 100 - data.thirst + "%");

    if ( event.data.gas > 20 ) {
      $('.gasDiv').css('background-image','url(imagens/gasolina0.png)');
      $('.gasDiv').removeClass('gasReserva');
      $('#gas').removeClass('gasReserva');
    }   
    else {
      $('.gasDiv').css('background-image','url(imagens/gasolina.png)');
      $('.gasDiv').addClass('gasReserva');
      $('#gas').addClass('gasReserva');
    }    
  }); 
});