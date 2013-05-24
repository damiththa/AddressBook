/*------TESTING------*/
$p(document).ready(function($) {
  //Fire up the Add Contact Window
  $('.aAddresses').live('click', function() {
  ColdFusion.Window.create('Add_Contacts','CC THIS WORK ORDER REQUEST TO...', 'AddContacts.cfm', {x:225,y:175,height:360,width:950,modal:true,closable:true, draggable:true,resizable:true,center:false,initshow:true, minheight:200,minwidth:200});
  });
  
  //Get Email from Click
  $('.LookUBtn').live('click', function() {
	var ClickedEmail = $(this).next('input').val(); //Get the New Email
	var emailCheck = CheckValidEmail(ClickedEmail); //check valid email
	if(emailCheck){
	  IntoCCBoxEmails(ClickedEmail); //Into CC box function
	}
  });
  
  //Email from Enter
  $('#TypeNameEmail_ID').live('keyup', function(e){
	$('#leftBox2 .msg').hide();
	if(e.keyCode == 13){ //ENTER key
	  var myVar_eList = $(this).val();
	  EmailList(myVar_eList);
	}
  });
  
  $('#showCC_ID').live('mouseup', function() {
	  $('#leftBox2 .msg').hide();
	  var sE = $.trim(String(getSelected()));
	  if(sE!=''){
		if(sE.toLowerCase().charAt(sE.length-1) != ','){
		  sE += ',';
		}
		var ccBox_Now = $('#showCC_ID').text();
		var ccBox_After = ccBox_Now.replace(sE,'');
		$('#showCC_ID').html('');
		EmailList(ccBox_After);
	  }
  });
});
/**-------TESTING---------*/

EmailList = function(eList){
  eList = String(eList);
  jQuery.each(eList.split(', '), function(){
	var eListValue = jQuery.trim(this);
	var emailCheck = CheckValidEmail(eListValue); //check valid email
	if(eListValue != ''){
	  if(emailCheck){
	   IntoCCBoxEmails(eListValue); //Calling the function
	  }
	  else{
	   jQuery('#leftBox2 .msg').effect('shake',{times:1},200);
	  }
	}
  });  
}

getSelected = function(){
  var sEmail = '';
  if(window.getSelection){sEmail = window.getSelection();}
  else if(window.getSelection){sEmail = window.getSelection();}
  else if(window.selection){sEmail = window.selection.createRange().text;}
  return sEmail;
};

IntoCCBoxEmails = function(newEmail){
  newEmail += ', '; //add a comma to the end	
  var ccNow = jQuery('#showCC_ID').text(); //Existing CC email addresses
  if(ccNow.toLowerCase().indexOf(newEmail) < 0){ //Avoiding duplicate emails
	ccNow += newEmail; //appending the new/passed email to the existing record
  }
  CCBox(ccNow);
}

CCBox = function(tEmails){
  var tEmails = String(tEmails);
  jQuery('#TypeNameEmail_ID').val(""); //Make Type Name/Email blank
  jQuery('#showCC_ID').html(tEmails);//New CC Box Value
}

CheckValidEmail = function(tryThis){
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(tryThis);
}
