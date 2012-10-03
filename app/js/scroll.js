//scroll functionality. 700ms
(function() {
var scrollLink = $('a.scroll')
scrollLink.on('click', function(event){
event.preventDefault();
$('html,body').animate({scrollTop:$(this.hash).offset().top}, 700);
});
})();