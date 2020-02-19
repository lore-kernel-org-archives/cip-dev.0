Return-Path: <masashi.kudo@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 091F1C013E
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0514486372
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-CaXk5QF44R for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2020 22:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410133.outbound.protection.outlook.com [40.107.141.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C458D862B7
 for <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2020 22:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MccrbcS9hX05prOF1nVAvwOHBg8Orz4uXJkm8R4svi6maDBIkhNnlZRyY892lnzn/JN/WTLkTV4LoXVdk1NLTf7QVtVJuShxSe7io4CFnCB6UnoYe3fdE6L8ht5rGFEJuP4BTXz+fn1IDHs8l+ezK+p9LMOC1mVLkDYtqdf6QtihGzkHVF41WiZ6jOyQ7RfZjv0mMMOilRtxl2dsUYuWpvq/Zk43uvjz+m/4kQE/VpPC7v6rsouyVhUt5Wow8YNVTqoEEXSxnOYZNzHf9/0n3KhsFP4wZzOgwiFQL3Y3R5EVr2QvHibg2Ymp1LafeYZ26LppqffXYWF8YXYhSSYE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufwCS/ddFDOA4Vwhum6l+gWb3OBhUPMzQ+ol321/US4=;
 b=KbAU+3/YHl9rMtbhpoudiBnF+1qVlTYu9kyYWs21J6G2WXLzuzFi+1Ci3OL9X4wWJRmM42kJmZTfx0zUz8d+Wlr5cSmMfxVrPWRYrBwP6WZbuzRaFOiop8J5NgB/xx9I/um4hU2mDiygzXbBBR92i/rUw8c5SwuO9WIiee9wD7kaqUJr8D+NVLMyvvpdVnv4h/goAmjPofVbdP+zAS/Q+kV6/JgJ2gI1yWM0ZThoH1yyc1GQEveEJyZqLaPj25agadVsOR7sm9BiRrDgYBX9Octt5TV0GK32BSEGEexZzZ9S6QljPBPbEyh9+XEdI9YVNh1qMfmEZAzVli22Ms1FKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufwCS/ddFDOA4Vwhum6l+gWb3OBhUPMzQ+ol321/US4=;
 b=gTXyk7aslmdux9aQqHtCDjoDv40yW3kd3iqZ0p5IL8BI3sETcwGhX+/eXTNXmFPtXkNtqb9NbSQk52iYUARFKZ+9ZPH0X3k8pPEG0QY3fOBv7RAUtsjVGWxOIQLX1PMwTOooXabcn9HRMDF2x1XjMaodWHhsS/0b/x9tx/bJEGE=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1515.jpnprd01.prod.outlook.com (52.133.160.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 22:52:27 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 22:52:27 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Meeting - Embedded World in Nuremberg
Thread-Index: AdXa+W0DNAgJ8A2jQWOjzEEGoZuhCwMfdP8w
Importance: high
X-Priority: 1
Date: Wed, 19 Feb 2020 22:52:27 +0000
Message-ID: <TY1PR01MB1481D8AA9F2C461831BBA359A0100@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-ms-exchange-calendar-series-instance-id: BAAAAIIA4AB0xbcQGoLgCAAAAABwIxaWRNvVAQAAAAAAAAAAEAAAAN/oIbnEnXxKnhK8XvMb4c4=
x-originating-ip: [219.123.27.194]
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 216592b8-43e7-495f-7b63-08d7b58e64e3
x-ms-traffictypediagnostic: TY1PR01MB1515:MeetingMessage
x-microsoft-antispam-prvs: <TY1PR01MB1515B97A33D0FD5DA4F4C755A0100@TY1PR01MB1515.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(8676002)(64756008)(66556008)(6916009)(966005)(66446008)(4326008)(81156014)(81166006)(8936002)(52536014)(5660300002)(66476007)(186003)(2906002)(66946007)(76116006)(316002)(33656002)(6506007)(55016002)(9686003)(7696005)(86362001)(71200400001)(26005)(85182001)(54906003)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1515;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4EEGWlLhRhISFbZoHai9IlQrsHm6KOFRhrZnsjmoLaMmKTQWCQIqv9zeCwX70FgbPuZNix0Z8JHbc03/7ZLREIALXFyBvsoU+l+r3/irs2WJFAdPh7ReDNoB1QNojsB7EgS4owZxZL93hBYMW0wIbniKh/wY6pldD6k1Suapw15d4qnWLZ6pxqzNrzHZ7xbMmLossoTMV5d+txFV86y7Jah9tTjKmSuAvsA34NOOB+2FZNHPbJ4HvJUqchhqB6cSpolt7HKWDwV/OIqINlOCz3e6BE4jw/qI3nN9BEtUZ3bygLx/EhNe0X8h61Co2e3TdncZDhkKXZ1bQlZ/9BX/BQDm2lHYtzJFmYf/D63AAtETzKtxseMlPXOz8HGsSi13jhDTyC6+oajMEiKQlkAIeeSHDji6JaYwEei7skj3CjTHuEm6uXe+WcEpgADOTjKJJ4c/L5U4G85bi4cAyLTSpdvz1KOm/NlvqWGTI4lb6cxkWR+SMuFASQDlsQqDZfLbXySt+jYUF5sYRpZGXNtXZg==
x-ms-exchange-antispam-messagedata: xsZPK5I1XOsW5FQyRQWyOk/+mAXUmupZehaOSDQnnV6dK68xqGRCVigDLQgNugWhlFdYUKKqxqz2CO06WQCT8A7oFMEkFMqrhLjIBTZ4WNCW+arP+g5DXzYNsWR6rNyM5cyP2n8sQXaabXhAy2poFg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 216592b8-43e7-495f-7b63-08d7b58e64e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 22:52:27.7958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGoI5sW6pFqPrOCO3161UPIUoy2JumQVinbs3DvtSwzU6Do++PCMeHxr8dfwpPb/V3ci3NRLblZBO0uEj1fn72LRUuujMluB+NZSQWw7Cpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1515
Cc: wens213@gmail.com, JohnsonCH.Chen@moxa.com
Subject: Canceled: CIP Kernel Meeting - Embedded World in Nuremberg
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Feb 2020 22:52:33 -0000
X-Groupsio-MsgNum: 4421
Content-Language: ja-JP
Content-Type: multipart/alternative;
 boundary="_000_TY1PR01MB1481D8AA9F2C461831BBA359A0100TY1PR01MB1481jpnp_"

--_000_TY1PR01MB1481D8AA9F2C461831BBA359A0100TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, All,



Due to the cancellation of F2F meetings in Nuremberg, this meeting is being=
 rescheduled.

I will send a new invitation later.



Best regards,

--

M. Kudo



--

For remote dial-in :



Working Group is inviting you to a scheduled Zoom meeting.



Topic: CIP Kernel - Embedded World

Time: Feb 27, 2020 02:00 PM Amsterdam, Berlin, Rome, Stockholm, Vienna



Join Zoom Meeting

https://zoom.us/j/940958488



Meeting ID: 940 958 488



One tap mobile

+16699006833,,940958488# US (San Jose)

+16465588656,,940958488# US (New York)



Dial by your location

        +1 669 900 6833 US (San Jose)

        +1 646 558 8656 US (New York)

        855 880 1246 US Toll-free

        877 369 0926 US Toll-free

        +1 647 558 0588 Canada

        855 703 8985 Canada Toll-free

Meeting ID: 940 958 488

Find your local number: https://zoom.us/u/acNR9omfRY


Location
Local Time
Time Zone
UTC Offset
Berlin<https://www.timeanddate.com/worldclock/germany/berlin> (Germany - Be=
rlin)
Thursday, 27 February 2020, 14:00:00
CET<https://www.timeanddate.com/time/zones/cet>
UTC+1 hour
London<https://www.timeanddate.com/worldclock/uk/london> (United Kingdom - =
England)
Thursday, 27 February 2020, 13:00:00
GMT<https://www.timeanddate.com/time/zones/gmt>
UTC
Taipei<https://www.timeanddate.com/worldclock/taiwan/taipei> (Taiwan)
Thursday, 27 February 2020, 21:00:00
CST<https://www.timeanddate.com/time/zones/cst-china>
UTC+8 hours
Tokyo<https://www.timeanddate.com/worldclock/japan/tokyo> (Japan)
Thursday, 27 February 2020, 22:00:00
JST<https://www.timeanddate.com/time/zones/jst>
UTC+9 hours
Corresponding UTC (GMT)
Thursday, 27 February 2020, 13:00:00<https://www.timeanddate.com/worldclock=
/fixedtime.html?iso=3D20200227T1300>









--_000_TY1PR01MB1481D8AA9F2C461831BBA359A0100TY1PR01MB1481jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=1B$B^b%4%7%C%/=1B(B;
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B";}
@font-face
	{font-family:"\@=1B$B^b%4%7%C%/=1B(B";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"=1B$B=3Dq<0$J$7=1B(B \(=1B$BJ8;z=1B(B\)";
	margin:0mm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0mm;
	mso-margin-bottom-alt:auto;
	margin-left:0mm;
	font-size:12.0pt;
	font-family:"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B";}
span.a
	{mso-style-name:"=1B$B=3Dq<0$J$7=1B(B \(=1B$BJ8;z=1B(B\)";
	mso-style-priority:99;
	mso-style-link:=1B$B=3Dq<0$J$7=1B(B;
	font-family:=1B$B^b%4%7%C%/=1B(B;}
span.small
	{mso-style-name:small;
	font-family:"Times New Roman",serif;}
span.21
	{mso-style-type:personal-compose;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
<v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
</o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"JA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justify-=
trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Hi, All,<o:p></o:p></span></=
p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Due to the cancellation of F=
2F meetings in Nuremberg, this meeting is being rescheduled.<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">I will send a new invitation=
 later.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Best regards,<o:p></o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">--<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">M. Kudo<o:p></o:p></span></p=
>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">--<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">For remote dial-in :<o:p></o=
:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Working Group is inviting yo=
u to a scheduled Zoom meeting.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Topic: CIP Kernel - Embedded=
 World<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Time: Feb 27, 2020 02:00 PM =
Amsterdam, Berlin, Rome, Stockholm, Vienna<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Join Zoom Meeting<o:p></o:p>=
</span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><a href=3D"https://zoom.us/j=
/940958488">https://zoom.us/j/940958488</a><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Meeting ID: 940 958 488<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">One tap mobile<o:p></o:p></s=
pan></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&#43;16699006833,,940958488#=
 US (San Jose)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&#43;16465588656,,940958488#=
 US (New York)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Dial by your location<o:p></=
o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43;1 669 900 6833 US (San Jose)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43;1 646 558 8656 US (New York)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 855 880 1246 US Toll-free<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 877 369 0926 US Toll-free<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &#43;1 647 558 0588 Canada<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 855 703 8985 Canada Toll-free<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Meeting ID: 940 958 488<o:p>=
</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Find your local number: <a h=
ref=3D"https://zoom.us/u/acNR9omfRY">
https://zoom.us/u/acNR9omfRY</a><o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" style=3D"border-collapse:collapse">
<thead>
<tr>
<td style=3D"border-top:solid #DDDDDD 1.0pt;border-left:solid #DDDDDD 1.0pt=
;border-bottom:none;border-right:none;background:white;padding:3.75pt 6.75p=
t 3.75pt 6.75pt">
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left"><b><span la=
ng=3D"EN-US" style=3D"font-family:&quot;Helvetica&quot;,sans-serif;color:#4=
54545">Location<o:p></o:p></span></b></p>
</td>
<td style=3D"border:none;border-top:solid #DDDDDD 1.0pt;background:white;pa=
dding:3.75pt 6.75pt 3.75pt 6.75pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;H=
elvetica&quot;,sans-serif;color:#454545">Local Time<o:p></o:p></span></b></=
p>
</td>
<td style=3D"border:none;border-top:solid #DDDDDD 1.0pt;background:white;pa=
dding:3.75pt 6.75pt 3.75pt 6.75pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;H=
elvetica&quot;,sans-serif;color:#454545">Time Zone<o:p></o:p></span></b></p=
>
</td>
<td style=3D"border-top:solid #DDDDDD 1.0pt;border-left:none;border-bottom:=
none;border-right:solid #DDDDDD 1.0pt;background:white;padding:3.75pt 6.75p=
t 3.75pt 6.75pt">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;H=
elvetica&quot;,sans-serif;color:#454545">UTC Offset<o:p></o:p></span></b></=
p>
</td>
</tr>
</thead>
<tbody>
<tr>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/worldclock/germany/berlin" title=3D"Current local time in Berlin"><span s=
tyle=3D"color:#556BB5;text-decoration:none">Berlin</span></a>&nbsp;</span><=
span class=3D"small"><span lang=3D"EN-US" style=3D"font-size:9.5pt;font-fam=
ily:&quot;Helvetica&quot;,sans-serif;color:#454545">(Germany
 - Berlin)</span></span><span lang=3D"EN-US" style=3D"font-family:&quot;Hel=
vetica&quot;,sans-serif;color:#454545"><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">Thursday, 27 February 2020, 14:00:00<=
o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/time/zones/cet" title=3D"Central European Time"><span style=3D"color:#556=
BB5;text-decoration:none">CET</span></a><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">UTC&#43;1 hour<o:p></o:p></span></p>
</td>
</tr>
<tr>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/worldclock/uk/london" title=3D"Current local time in London"><span style=
=3D"color:#556BB5;text-decoration:none">London</span></a>&nbsp;</span><span=
 class=3D"small"><span lang=3D"EN-US" style=3D"font-size:9.5pt;font-family:=
&quot;Helvetica&quot;,sans-serif;color:#454545">(United
 Kingdom - England)</span></span><span lang=3D"EN-US" style=3D"font-family:=
&quot;Helvetica&quot;,sans-serif;color:#454545"><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">Thursday, 27 February 2020, 13:00:00<=
o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/time/zones/gmt" title=3D"Greenwich Mean Time"><span style=3D"color:#556BB=
5;text-decoration:none">GMT</span></a><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">UTC<o:p></o:p></span></p>
</td>
</tr>
<tr>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/worldclock/taiwan/taipei" title=3D"Current local time in Taipei"><span st=
yle=3D"color:#556BB5;text-decoration:none">Taipei</span></a>&nbsp;</span><s=
pan class=3D"small"><span lang=3D"EN-US" style=3D"font-size:9.5pt;font-fami=
ly:&quot;Helvetica&quot;,sans-serif;color:#454545">(Taiwan)</span></span><s=
pan lang=3D"EN-US" style=3D"font-family:&quot;Helvetica&quot;,sans-serif;co=
lor:#454545"><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">Thursday, 27 February 2020, 21:00:00<=
o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/time/zones/cst-china" title=3D"China Standard Time"><span style=3D"color:=
#556BB5;text-decoration:none">CST</span></a><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">UTC&#43;8 hours<o:p></o:p></span></p>
</td>
</tr>
<tr>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/worldclock/japan/tokyo" title=3D"Current local time in Tokyo"><span style=
=3D"color:#556BB5;text-decoration:none">Tokyo</span></a>&nbsp;</span><span =
class=3D"small"><span lang=3D"EN-US" style=3D"font-size:9.5pt;font-family:&=
quot;Helvetica&quot;,sans-serif;color:#454545">(Japan)</span></span><span l=
ang=3D"EN-US" style=3D"font-family:&quot;Helvetica&quot;,sans-serif;color:#=
454545"><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">Thursday, 27 February 2020, 22:00:00<=
o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/time/zones/jst" title=3D"Japan Standard Time"><span style=3D"color:#556BB=
5;text-decoration:none">JST</span></a><o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:#F3F3F3;padding:4.8pt 4.8pt 4.8pt 4.=
8pt">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">UTC&#43;9 hours<o:p></o:p></span></p>
</td>
</tr>
<tr>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">Corresponding UTC (GMT)<o:p></o:p></s=
pan></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545"><a href=3D"https://www.timeanddate.co=
m/worldclock/fixedtime.html?iso=3D20200227T1300"><span style=3D"color:#556B=
B5;text-decoration:none">Thursday, 27 February 2020, 13:00:00</span></a><o:=
p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">&nbsp;<o:p></o:p></span></p>
</td>
<td valign=3D"top" style=3D"background:white;padding:4.8pt 4.8pt 4.8pt 4.8p=
t">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Helv=
etica&quot;,sans-serif;color:#454545">&nbsp;<o:p></o:p></span></p>
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_TY1PR01MB1481D8AA9F2C461831BBA359A0100TY1PR01MB1481jpnp_
Content-Type: text/calendar; charset="utf-8"; method=CANCEL
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpNRVRIT0Q6Q0FOQ0VMDQpQUk9ESUQ6TWljcm9zb2Z0IEV4Y2hhbmdl
IFNlcnZlciAyMDEwDQpWRVJTSU9OOjIuMA0KQkVHSU46VlRJTUVaT05FDQpUWklEOlRva3lvIFN0
YW5kYXJkIFRpbWUNCkJFR0lOOlNUQU5EQVJEDQpEVFNUQVJUOjE2MDEwMTAxVDAwMDAwMA0KVFpP
RkZTRVRGUk9NOiswOTAwDQpUWk9GRlNFVFRPOiswOTAwDQpFTkQ6U1RBTkRBUkQNCkJFR0lOOkRB
WUxJR0hUDQpEVFNUQVJUOjE2MDEwMTAxVDAwMDAwMA0KVFpPRkZTRVRGUk9NOiswOTAwDQpUWk9G
RlNFVFRPOiswOTAwDQpFTkQ6REFZTElHSFQNCkVORDpWVElNRVpPTkUNCkJFR0lOOlZFVkVOVA0K
T1JHQU5JWkVSOm1haWx0bzptYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KQVRURU5ERUU7
Uk9MRT1SRVEtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9VFJVRTptYWls
dG86Y2lwLWRlDQogdkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkFUVEVOREVFO1JPTEU9T1BULVBB
UlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPVRSVUU6bWFpbHRvOnZpY3Rvcg0K
IC55dUBtb3hhLmNvbQ0KQVRURU5ERUU7Uk9MRT1PUFQtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVF
RFMtQUNUSU9OO1JTVlA9VFJVRTptYWlsdG86Sm9obnNvDQogbkNILkNoZW5AbW94YS5jb20NCkFU
VEVOREVFO1JPTEU9T1BULVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPVRS
VUU6bWFpbHRvOm1pbm1pbg0KIEBwbGF0aG9tZS5jby5qcA0KQVRURU5ERUU7Uk9MRT1PUFQtUEFS
VElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9VFJVRTptYWlsdG86dXJzLmdsDQog
ZWltQHNpZW1lbnMuY29tDQpBVFRFTkRFRTtST0xFPU9QVC1QQVJUSUNJUEFOVDtQQVJUU1RBVD1O
RUVEUy1BQ1RJT047UlNWUD1UUlVFOm1haWx0bzprZXBhQGcNCiBlLmNvbQ0KQVRURU5ERUU7Uk9M
RT1PUFQtUEFSVElDSVBBTlQ7UEFSVFNUQVQ9TkVFRFMtQUNUSU9OO1JTVlA9VFJVRTptYWlsdG86
d2VuczIxDQogM0BnbWFpbC5jb20NCkFUVEVOREVFO1JPTEU9T1BULVBBUlRJQ0lQQU5UO1BBUlRT
VEFUPU5FRURTLUFDVElPTjtSU1ZQPVRSVUU6bWFpbHRvOmJlbi5odQ0KIHRjaGluZ3NAY29kZXRo
aW5rLmNvLnVrDQpBVFRFTkRFRTtST0xFPU9QVC1QQVJUSUNJUEFOVDtQQVJUU1RBVD1ORUVEUy1B
Q1RJT047UlNWUD1UUlVFOm1haWx0bzpjaHJpc3QNCiBpYW4uc3Rvcm1Ac2llbWVucy5jb20NCkRF
U0NSSVBUSU9OO0xBTkdVQUdFPWphLUpQOkhpXCwgQWxsXCxcblxuXG5cbkR1ZSB0byB0aGUgY2Fu
Y2VsbGF0aW9uIG9mIEYyRg0KICBtZWV0aW5ncyBpbiBOdXJlbWJlcmdcLCB0aGlzIG1lZXRpbmcg
aXMgYmVpbmcgcmVzY2hlZHVsZWQuXG5cbkkgd2lsbCBzZW5kDQogIGEgbmV3IGludml0YXRpb24g
bGF0ZXIuXG5cblxuXG5CZXN0IHJlZ2FyZHNcLFxuXG4tLVxuXG5NLiBLdWRvXG5cblxuXG4tLVwN
CiBuXG5Gb3IgcmVtb3RlIGRpYWwtaW4gOlxuXG5cblxuV29ya2luZyBHcm91cCBpcyBpbnZpdGlu
ZyB5b3UgdG8gYSBzY2hlZHVsZQ0KIGQgWm9vbSBtZWV0aW5nLlxuXG5cblxuVG9waWM6IENJUCBL
ZXJuZWwgLSBFbWJlZGRlZCBXb3JsZFxuXG5UaW1lOiBGZWIgMjdcDQogLCAyMDIwIDAyOjAwIFBN
IEFtc3RlcmRhbVwsIEJlcmxpblwsIFJvbWVcLCBTdG9ja2hvbG1cLCBWaWVubmFcblxuXG5cbkpv
aW4NCiAgWm9vbSBNZWV0aW5nXG5cbmh0dHBzOi8vem9vbS51cy9qLzk0MDk1ODQ4OFxuXG5cblxu
TWVldGluZyBJRDogOTQwIDk1OCA0OA0KIDhcblxuXG5cbk9uZSB0YXAgbW9iaWxlXG5cbisxNjY5
OTAwNjgzM1wsXCw5NDA5NTg0ODgjIFVTIChTYW4gSm9zZSlcblxuKzE2DQogNDY1NTg4NjU2XCxc
LDk0MDk1ODQ4OCMgVVMgKE5ldyBZb3JrKVxuXG5cblxuRGlhbCBieSB5b3VyIGxvY2F0aW9uXG5c
biAgICANCiAgICAgKzEgNjY5IDkwMCA2ODMzIFVTIChTYW4gSm9zZSlcblxuICAgICAgICArMSA2
NDYgNTU4IDg2NTYgVVMgKE5ldyBZb3JrKQ0KIFxuXG4gICAgICAgIDg1NSA4ODAgMTI0NiBVUyBU
b2xsLWZyZWVcblxuICAgICAgICA4NzcgMzY5IDA5MjYgVVMgVG9sbC1mcmVlDQogXG5cbiAgICAg
ICAgKzEgNjQ3IDU1OCAwNTg4IENhbmFkYVxuXG4gICAgICAgIDg1NSA3MDMgODk4NSBDYW5hZGEg
VG9sbC1mcmUNCiBlXG5cbk1lZXRpbmcgSUQ6IDk0MCA5NTggNDg4XG5cbkZpbmQgeW91ciBsb2Nh
bCBudW1iZXI6IGh0dHBzOi8vem9vbS51cy91Lw0KIGFjTlI5b21mUllcblxuXG5Mb2NhdGlvblxu
TG9jYWwgVGltZVxuVGltZSBab25lXG5VVEMgT2Zmc2V0XG5CZXJsaW48aHR0cHM6DQogLy93d3cu
dGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svZ2VybWFueS9iZXJsaW4+IChHZXJtYW55IC0gQmVy
bGluKVxuVGh1cnMNCiBkYXlcLCAyNyBGZWJydWFyeSAyMDIwXCwgMTQ6MDA6MDBcbkNFVDxodHRw
czovL3d3dy50aW1lYW5kZGF0ZS5jb20vdGltZS96bw0KIG5lcy9jZXQ+XG5VVEMrMSBob3VyXG5M
b25kb248aHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svdWsvbG9uDQogZG9u
PiAoVW5pdGVkIEtpbmdkb20gLSBFbmdsYW5kKVxuVGh1cnNkYXlcLCAyNyBGZWJydWFyeSAyMDIw
XCwgMTM6MDA6MDBcbkcNCiBNVDxodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vdGltZS96b25l
cy9nbXQ+XG5VVENcblRhaXBlaTxodHRwczovL3d3dy50aQ0KIG1lYW5kZGF0ZS5jb20vd29ybGRj
bG9jay90YWl3YW4vdGFpcGVpPiAoVGFpd2FuKVxuVGh1cnNkYXlcLCAyNyBGZWJydWFyeSAyDQog
MDIwXCwgMjE6MDA6MDBcbkNTVDxodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vdGltZS96b25l
cy9jc3QtY2hpbmE+XG5VVEMNCiArOCBob3Vyc1xuVG9reW88aHR0cHM6Ly93d3cudGltZWFuZGRh
dGUuY29tL3dvcmxkY2xvY2svamFwYW4vdG9reW8+IChKYXBhbg0KIClcblRodXJzZGF5XCwgMjcg
RmVicnVhcnkgMjAyMFwsIDIyOjAwOjAwXG5KU1Q8aHR0cHM6Ly93d3cudGltZWFuZGRhdGUuY29t
DQogL3RpbWUvem9uZXMvanN0PlxuVVRDKzkgaG91cnNcbkNvcnJlc3BvbmRpbmcgVVRDIChHTVQp
XG5UaHVyc2RheVwsIDI3IEZlYnINCiB1YXJ5IDIwMjBcLCAxMzowMDowMDxodHRwczovL3d3dy50
aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9maXhlZHRpbWUuaHRtbA0KID9pc289MjAyMDAyMjdU
MTMwMD5cblxuXG5cblxuXG5cblxuXG4NClVJRDowNDAwMDAwMDgyMDBFMDAwNzRDNUI3MTAxQTgy
RTAwODAwMDAwMDAwNzAyMzE2OTY0NERCRDUwMTAwMDAwMDAwMDAwMDAwMA0KIDAxMDAwMDAwMERG
RTgyMUI5QzQ5RDdDNEE5RTEyQkM1RUYzMUJFMUNFDQpTVU1NQVJZO0xBTkdVQUdFPWphLUpQOkNh
bmNlbGVkOiBDSVAgS2VybmVsIE1lZXRpbmcgLSBFbWJlZGRlZCBXb3JsZCBpbiBOdXINCiBlbWJl
cmcNCkRUU1RBUlQ7VFpJRD1Ub2t5byBTdGFuZGFyZCBUaW1lOjIwMjAwMjI3VDIyMDAwMA0KRFRF
TkQ7VFpJRD1Ub2t5byBTdGFuZGFyZCBUaW1lOjIwMjAwMjI4VDAwMDAwMA0KQ0xBU1M6UFVCTElD
DQpQUklPUklUWToxDQpEVFNUQU1QOjIwMjAwMjE5VDIyNTIyNVoNClRSQU5TUDpUUkFOU1BBUkVO
VA0KU1RBVFVTOkNBTkNFTExFRA0KU0VRVUVOQ0U6MQ0KTE9DQVRJT047TEFOR1VBR0U9amEtSlA6
TnVyZW1iZXJnICYgUmVtb3RlDQpYLU1JQ1JPU09GVC1DRE8tQVBQVC1TRVFVRU5DRToxDQpYLU1J
Q1JPU09GVC1DRE8tT1dORVJBUFBUSUQ6LTE1MTU5Njg1NDANClgtTUlDUk9TT0ZULUNETy1CVVNZ
U1RBVFVTOkZSRUUNClgtTUlDUk9TT0ZULUNETy1JTlRFTkRFRFNUQVRVUzpGUkVFDQpYLU1JQ1JP
U09GVC1DRE8tQUxMREFZRVZFTlQ6RkFMU0UNClgtTUlDUk9TT0ZULUNETy1JTVBPUlRBTkNFOjIN
ClgtTUlDUk9TT0ZULUNETy1JTlNUVFlQRTowDQpYLU1JQ1JPU09GVC1ET05PVEZPUldBUkRNRUVU
SU5HOkZBTFNFDQpYLU1JQ1JPU09GVC1ESVNBTExPVy1DT1VOVEVSOkZBTFNFDQpFTkQ6VkVWRU5U
DQpFTkQ6VkNBTEVOREFSDQo=

--_000_TY1PR01MB1481D8AA9F2C461831BBA359A0100TY1PR01MB1481jpnp_--

