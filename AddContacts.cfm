<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Work Order Request System - Add Contacts</title>
</head>
<body>
<style>
#BigBox #LeftSide, #BigBox #RightSide{float:left; margin:3px;}
#LeftSide{width:440px;}
#LeftSide div{margin-top:5px; margin-bottom:5px;}
#leftBox1 .Qs{font-weight:bold; padding:2px} 
#leftBox1 .As{background-color: transparent; padding:2px; border-style: solid; border-width: 0px 0px 1px 0px;}
#leftBox1 .As_TextBox{border-color: darkred;}
#leftBox1 .As_TextArea{ border-color:transparent;}
#leftBox2 .msg{background-color:#FFC1C1; padding:3px; text-transform:uppercase; text-align:center; font-weight:200; display:none;}
#leftBox3 ol{padding:3px; margin-left:15px; background-color:#E1FFE1;}
#RightSide{width:460px;}
</style>

<DIV id="BigBox">
  <Div id="LeftSide">
    <div id="leftBox1">
      <label class="Qs" for="Type">Type Name/Email:</label><br />    
      <input class="As As_TextBox" name="TypeNameEmail" type="text" size="65" id="TypeNameEmail_ID">
      <br /><br /><br />
      <label class="Qs" for="CC">CC:</label><br />    
      <!--CC Box-->
      <div id="showCC_ID"></div>
    </div>
    <div id="leftBox2">
      <div class="msg">
       Error occured, refer note below. 
      </div>
    </div>
    <div id="leftBox3">
      <ol>  
        <li>Type the complete email address or click from right hand list.</li><br />
        <li>Multiple email addresses must be seperated by <br />a comma(,) <b>and</b> a space( ). <i>(abc@123.com, xyz@123.com)</i></li><br />
        <li>To remove an email address from the list, select/highlight the unwanted email address, <u>in its entirety</u>.</li><br />
        <li>Your <b>this</b> request will be copied to everyone in the <b>CC:</b> field.</li>
      </ol>
    </div>
  </Div>
  <Div id="RightSide">
    <div id="rightBox1">
      <!---Bind--->
      <cfdiv id="aContacts_Bind_DivID" bind="url:AddContacts_bind.cfm?LookThisUp={TypeNameEmail@keyup}" bindOnLoad="true">
    </div>
  </Div>
</DIV>
</body>
</html>
