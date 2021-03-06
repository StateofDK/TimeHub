﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="TimeHub2.UserProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="UserProfile" runat="server">
        <div class="header">
            <h1>TimeHub</h1>
            <ul>
                <li><a href="CardMgr.aspx">card manager</a></li>
                <li><a href="approvalmgr.aspx">approval manager</a></li>
                <li><a href="UserHome.aspx">home</a></li>
                <li><a href="UserProfile.aspx">profile</a></li>
                <li><a href="">help</a></li>
                <li>
                    <asp:Label runat="server" ID="userloggedin"></asp:Label></li>
                <li>
                    <asp:Button runat="server" ID="buttonLogout" Text="Log Out" OnClick="LogOutClick" /></li>
            </ul>
        </div>
        <div>
            <label for="username">username</label>
            <asp:TextBox runat="server" ID="username" ReadOnly="true"></asp:TextBox>
            <label for="first_name">first name</label>
            <asp:TextBox runat="server" ID="first_name"></asp:TextBox>
            <label for="middle_initial">middle initial</label>
            <asp:TextBox runat="server" ID="middle_initial"></asp:TextBox>
            <label for="last_name">last name</label>
            <asp:TextBox runat="server" ID="last_name"></asp:TextBox>
        </div>
        <div>
            <label for="star">star</label>
            <asp:TextBox runat="server" ID="star"></asp:TextBox>
            <label for="rank">rank</label>
            <asp:TextBox runat="server" ID="rank"></asp:TextBox>
        </div>
        <div>
            <label for="ddl_assignment">assignment</label>
            <asp:DropDownList runat="server" ID="ddl_assignment">
                <asp:ListItem Value='NULL' Text='Select' />
                <asp:ListItem Value=1 Text='Central Station' />
                <asp:ListItem Value=2 Text='Central Station - SIT' />
                <asp:ListItem Value=3 Text='Southern Station' />
                <asp:ListItem Value=4 Text='Southern Station - SIT' />
                <asp:ListItem Value=5 Text='Bayview Station' />
                <asp:ListItem Value=6 Text='Bayview Station - SIT' />
                <asp:ListItem Value=7 Text='Mission Station' />
                <asp:ListItem Value=8 Text='Mission Station - SIT' />
                <asp:ListItem Value=9 Text='Northern Station' />
                <asp:ListItem Value=10 Text='Northern Station - SIT' />
                <asp:ListItem Value=11 Text='Park Station' />
                <asp:ListItem Value=12 Text='Park Station - SIT' />
                <asp:ListItem Value=13 Text='Richmond Station' />
                <asp:ListItem Value=14 Text='Richmond Station - SIT' />
                <asp:ListItem Value=15 Text='Ingleside Station' />
                <asp:ListItem Value=16 Text='Ingleside Station - SIT' />
                <asp:ListItem Value=17 Text='Taraval Station' />
                <asp:ListItem Value=18 Text='Taraval Station - SIT' />
                <asp:ListItem Value=19 Text='Tenderloin Station' />
                <asp:ListItem Value=20 Text='Tenderloin Station - SIT' />
                <asp:ListItem Value=21 Text='Traffic Company' />
                <asp:ListItem Value=22 Text='Crime Scene Investigations' />
                <asp:ListItem Value=23 Text='Department Operations Center' />
                <asp:ListItem Value=24 Text='Equal Employment Opportunity' />
                <asp:ListItem Value=25 Text='Facilities Management' />
                <asp:ListItem Value=26 Text='Field Operations Bureau' />
                <asp:ListItem Value=27 Text='Fleet Management' />
                <asp:ListItem Value=28 Text='Fugitive Recovery Enforcement Team' />
                <asp:ListItem Value=29 Text='Gang Task Force' />
                <asp:ListItem Value=30 Text='Graffiti Abatement' />
                <asp:ListItem Value=31 Text='Hit & Run' />
                <asp:ListItem Value=32 Text='Homeland Security Unit' />
                <asp:ListItem Value=33 Text='Homicide' />
                <asp:ListItem Value=34 Text='Housing Unit' />
                <asp:ListItem Value=35 Text='Municipal Transport Agency' />
                <asp:ListItem Value=36 Text='Narcotics' />
                <asp:ListItem Value=37 Text='Outside Agency' />
                <asp:ListItem Value=38 Text='Permits Bureau' />
                <asp:ListItem Value=39 Text='Property Section' />
                <asp:ListItem Value=40 Text='Risk Management Office' />
                <asp:ListItem Value=41 Text='Special Victims Unit' />
                <asp:ListItem Value=42 Text='Special Investigations' />
                <asp:ListItem Value=43 Text='Violence Reduction Team' />
                <asp:ListItem Value=44 Text='Administration Bureau' />
                <asp:ListItem Value=45 Text='Airport Bureau' />
                <asp:ListItem Value=46 Text='Alcoholic Beverage Control Liaison' />
                <asp:ListItem Value=47 Text='Arson Unit' />
                <asp:ListItem Value=0 Text='Other - Not In List' />
            </asp:DropDownList>
            <label for="ddl_shift">regular shift</label>
            <asp:DropDownList runat="server" ID="ddl_shift">
                <asp:ListItem Value='NULL' Text='Select' />
                <asp:ListItem Value='1' Text='0000/0800' />
                <asp:ListItem Value='25' Text='0000/0900' />
                <asp:ListItem Value='49' Text='0000/1000' />
                <asp:ListItem Value='2' Text='0100/0900' />
                <asp:ListItem Value='26' Text='0100/1000' />
                <asp:ListItem Value='50' Text='0100/1100' />
                <asp:ListItem Value='3' Text='0200/1000' />
                <asp:ListItem Value='27' Text='0200/1100' />
                <asp:ListItem Value='51' Text='0200/1200' />
                <asp:ListItem Value='4' Text='0300/1100' />
                <asp:ListItem Value='28' Text='0300/1200' />
                <asp:ListItem Value='52' Text='0300/1300' />
                <asp:ListItem Value='5' Text='0400/1200' />
                <asp:ListItem Value='29' Text='0400/1300' />
                <asp:ListItem Value='53' Text='0400/1400' />
                <asp:ListItem Value='6' Text='0500/1300' />
                <asp:ListItem Value='30' Text='0500/1400' />
                <asp:ListItem Value='54' Text='0500/1500' />
                <asp:ListItem Value='7' Text='0600/1400' />
                <asp:ListItem Value='31' Text='0600/1500' />
                <asp:ListItem Value='55' Text='0600/1600' />
                <asp:ListItem Value='8' Text='0700/1500' />
                <asp:ListItem Value='32' Text='0700/1600' />
                <asp:ListItem Value='56' Text='0700/1700' />
                <asp:ListItem Value='9' Text='0800/1600' />
                <asp:ListItem Value='33' Text='0800/1700' />
                <asp:ListItem Value='57' Text='0800/1800' />
                <asp:ListItem Value='10' Text='0900/1700' />
                <asp:ListItem Value='34' Text='0900/1800' />
                <asp:ListItem Value='58' Text='0900/1900' />
                <asp:ListItem Value='11' Text='1000/1800' />
                <asp:ListItem Value='35' Text='1000/1900' />
                <asp:ListItem Value='59' Text='1000/2000' />
                <asp:ListItem Value='12' Text='1100/1900' />
                <asp:ListItem Value='36' Text='1100/2000' />
                <asp:ListItem Value='60' Text='1100/2100' />
                <asp:ListItem Value='13' Text='1200/2000' />
                <asp:ListItem Value='37' Text='1200/2100' />
                <asp:ListItem Value='61' Text='1200/2200' />
                <asp:ListItem Value='14' Text='1300/2100' />
                <asp:ListItem Value='38' Text='1300/2200' />
                <asp:ListItem Value='62' Text='1300/2300' />
                <asp:ListItem Value='15' Text='1400/2200' />
                <asp:ListItem Value='39' Text='1400/2300' />
                <asp:ListItem Value='63' Text='1400/0000' />
                <asp:ListItem Value='16' Text='1500/2300' />
                <asp:ListItem Value='40' Text='1500/0000' />
                <asp:ListItem Value='64' Text='1500/0100' />
                <asp:ListItem Value='17' Text='1600/0000' />
                <asp:ListItem Value='41' Text='1600/0100' />
                <asp:ListItem Value='65' Text='1600/0200' />
                <asp:ListItem Value='18' Text='1700/0100' />
                <asp:ListItem Value='42' Text='1700/0200' />
                <asp:ListItem Value='66' Text='1700/0300' />
                <asp:ListItem Value='19' Text='1800/0200' />
                <asp:ListItem Value='43' Text='1800/0300' />
                <asp:ListItem Value='67' Text='1800/0400' />
                <asp:ListItem Value='20' Text='1900/0300' />
                <asp:ListItem Value='44' Text='1900/0400' />
                <asp:ListItem Value='68' Text='1900/0500' />
                <asp:ListItem Value='21' Text='2000/0400' />
                <asp:ListItem Value='45' Text='2000/0500' />
                <asp:ListItem Value='69' Text='2000/0600' />
                <asp:ListItem Value='22' Text='2100/0500' />
                <asp:ListItem Value='46' Text='2100/0600' />
                <asp:ListItem Value='70' Text='2100/0700' />
                <asp:ListItem Value='23' Text='2200/0600' />
                <asp:ListItem Value='47' Text='2200/0700' />
                <asp:ListItem Value='71' Text='2200/0800' />
                <asp:ListItem Value='24' Text='2300/0700' />
                <asp:ListItem Value='48' Text='2300/0800' />
                <asp:ListItem Value='72' Text='2300/0900' /> 
            </asp:DropDownList>
        </div>
        <div>
            <label for="contact_phone">contact phone</label>
            <asp:TextBox runat="server" ID="contact_phone"></asp:TextBox>
            <label for="phone_type">phone type</label>
            <asp:DropDownList ID="phone_type" runat="server">
                <asp:ListItem>home</asp:ListItem>
                <asp:ListItem>cell</asp:ListItem>
            </asp:DropDownList>
            <label for="email">sfpd email</label>
            <asp:TextBox runat="server" ID="email" TextMode="Email"></asp:TextBox>
        </div>
        <div>
            <asp:Button runat="server" ID="save" Text="update profile" OnClick="UpdateProfile" />
            <asp:Button runat="server" ID="reset" Text="Undo Edits" OnClick="ResetFields" />
        </div>
    </form>
</body>
</html>
