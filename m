Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA4C11D00
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 22:40:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F75207FD
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="HOFH48GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F75207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 03B6920401;
	Thu, 20 Feb 2020 22:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0bnZ6vizpHJy; Thu, 20 Feb 2020 22:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4916E203E8;
	Thu, 20 Feb 2020 22:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DD73C013E;
	Thu, 20 Feb 2020 22:40:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0907FC013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 22:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F369B20401
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 22:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDHK4ieYF5bK for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 22:40:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400098.outbound.protection.outlook.com [40.107.140.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 19E48203E8
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 22:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1XNLZ93h8a6YPBO+VoODAT7SKTyRic7wzLznOqc9Ef31s6yM0gauqQsBiQsALoenI8w0VFfYpJNd8srmJxkurpOP6QUKVUSV4QPhExO2FefY253/iGYG3p7jFHaYgQWhQdERiiESraMOXCbX6PnJ4yHMkFk0FCA/UtRpuH/BMucmXXP/LMOlHR5g3E9ulaVzAp5pYvGrLX9+dIpS0K38iz9EJEpReOkLN0QIh6bIjxd9yGIydmeGSn0+6MZvDZOwOBywTI+OVSK0dqWL2CMSGWXlp51BRJDtyTYNu9vJrEVrrMxQBm9H0TFD7x+0zW5sQfXCO4bBGF1uz0LHsh1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTHvPdXctGsRROWgzED+TCFONBgOQ88TRnsnZ+WYYHk=;
 b=V3HAp890NAuOUK0cJnIwZwTiwxq0RoXFyrMIP2Pa4mvPnhYuSYvb/cfWKJVZfap2DIW8zdQSmj5dNFdpTtUjVB/cjFxTBYV5RtvK1SyaRITDXy34OREKVsgsjMMtMT2U3oCW57gML/DfviEIpWwwM/0cGAqWdWtDyvgimTttnFOdQbMnslIGs6rMf2D/AAmf+/u5hS0CaawYcx6Bdhivs4aVmjRqJGysPfaCbM8g60XtbGkJ00uTdAjnHHnCmI+n1JLjrpFEaxNW2MqhvhoH48KqnO/miHHk3jQ+n7apdDjqyk+rnaTu6XetS+gJ2N7UWiC5n1pH59oipz5aXf5how==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTHvPdXctGsRROWgzED+TCFONBgOQ88TRnsnZ+WYYHk=;
 b=HOFH48GJ4ZEBeQJr+v62KhLL7t0SudhaBdJWRwON8n1/zobtPV1TSDAMqDEJr63xEPkGb/I9ufSabj/k1VrhKnNIOxs/D+nluBu9T+UCMouuW72Onz1HpALz52oofbMxUGjta5VvZ2CYejJDF8DPbk2w3AR7r8ww03FT9bqFdoA=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1820.jpnprd01.prod.outlook.com (52.133.164.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Thu, 20 Feb 2020 22:39:59 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 22:39:59 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Team Call
Thread-Index: AdXoPotTDCgPYozLTDaeyEj6Md9s7gAACH+w
Date: Thu, 20 Feb 2020 22:39:59 +0000
Message-ID: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-ms-exchange-calendar-series-instance-id: BAAAAIIA4AB0xbcQGoLgCAAAAABwBXboiejVAQAAAAAAAAAAEAAAALIHwq3iUF1DlWt7EVcHSeI=
x-originating-ip: [219.123.27.194]
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5082b9a3-46c0-4625-5aa9-08d7b655d134
x-ms-traffictypediagnostic: TY1PR01MB1820:MeetingMessage
x-microsoft-antispam-prvs: <TY1PR01MB18200B4CA413741F65450F13A0130@TY1PR01MB1820.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:220;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(39850400004)(376002)(366004)(346002)(199004)(189003)(966005)(64756008)(316002)(5660300002)(85182001)(66946007)(86362001)(76116006)(66556008)(6506007)(66476007)(2906002)(30864003)(3480700007)(33656002)(478600001)(66446008)(186003)(71200400001)(8676002)(81166006)(81156014)(52536014)(7696005)(8936002)(26005)(55016002)(9686003)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1820;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb/TfyhZcXnmyjQwFyR0cnywIg4MAVoIC93/Mqnmpl0vePwJW+po6lGbbhSdT6qCKZIdWrXCbnl0EfPZWRCwdYuQkZGp90eilJ9LKVn5IZkmEwQTiavnqtusUC3oV8D4yXtNS3785TsYqwJqmQWwKJ6q14rIa3OFm8Y69ap353vSySFm83KLhA/fnOsVRCy4tlzm5YwEZDN1bzc13yoUo9zzb3cp7pqSs88Yo3C/REYhbfXZZ+dt6iGSmjoSWJCkT8evBYwwDDtcenzVBh+lp/UCjERWEHqgd7Bnzf2TkD172EMrmlypBPEIA8F5P/RbI/2OxSFtKxgD527ZRXkn9oFVxhs+7V1/ztCtlkv1FczJnX5DPk/2wm/KjdBTd0VAAdXN0A2Y+u28uwnBBjPJTKLK3GPEdg2CDng/U79j5WKgieIOsaLCMWuFZaY/YYDN
x-ms-exchange-antispam-messagedata: B48cFszlVkga/4PGQ95IIVxmRCrn24Cj2385VSgQ853wX3Y4RzZCoE1BITQd3Dh9SLSo+gLAJpHfy33H+PeZVRxUUb8P6eZzzNzl3Zn+PeJMXvW2jafo/orv6lgpRAqJKNYD0/grgCwYLLJV+zEupA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5082b9a3-46c0-4625-5aa9-08d7b655d134
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 22:39:59.3499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JboqEr8HlGi6mCiWliJBtVyTZmMzz+rSbQDSTYjxYMBq8ng2YG4JEGq+sJGm+vzHvfo3RCkRmpFM5/+MM/glAydE3RZHcPbRkRrbL/8/Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1820
Subject: [cip-dev] CIP Kernel Team Call
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
Content-Type: multipart/mixed; boundary="===============9088630992173584663=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============9088630992173584663==
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY1PR01MB14816C3E23543732B6F76311A0130TY1PR01MB1481jpnp_"

--_000_TY1PR01MB14816C3E23543732B6F76311A0130TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Topic: CIP Kernel Team
Time: Feb 27, 2020 09:00 PM Osaka, Sapporo, Tokyo

Join Zoom Meeting
https://zoom.us/j/362722087

Meeting ID: 362 722 087

One tap mobile
+16465588656,,362722087# US (New York)
+16699006833,,362722087# US (San Jose)

Dial by your location
        +1 646 558 8656 US (New York)
        +1 669 900 6833 US (San Jose)
        877 369 0926 US Toll-free
        855 880 1246 US Toll-free
        +1 647 558 0588 Canada
        855 703 8985 Canada Toll-free
Meeting ID: 362 722 087
Find your local number: https://zoom.us/u/acNR9omfRY



--_000_TY1PR01MB14816C3E23543732B6F76311A0130TY1PR01MB1481jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B" size=3D"3"><span style=
=3D"font-size:12pt;">
<div>Topic: CIP Kernel Team<br>

Time: Feb 27, 2020 09:00 PM Osaka, Sapporo, Tokyo<br>

<br>

Join Zoom Meeting<br>

<a href=3D"https://zoom.us/j/362722087"><font color=3D"#0563C1"><u>https://=
zoom.us/j/362722087</u></font></a><br>

<br>

<font face=3D"MS PGothic Western">Meeting ID: 362 722 087<br>

<br>

One tap mobile<br>

&#43;16465588656,,362722087# US (New York)<br>

&#43;16699006833,,362722087# US (San Jose)<br>

<br>

Dial by your location<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 646 558 8656 US (New York)<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 669 900 6833 US (San Jose)<br>

&nbsp; &nbsp; &nbsp; &nbsp; 877 369 0926 US Toll-free<br>

&nbsp; &nbsp; &nbsp; &nbsp; 855 880 1246 US Toll-free<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 647 558 0588 Canada<br>

&nbsp; &nbsp; &nbsp; &nbsp; 855 703 8985 Canada Toll-free<br>

Meeting ID: 362 722 087<br>

Find your local number: </font><a href=3D"https://zoom.us/u/acNR9omfRY"><fo=
nt color=3D"#0563C1"><u>https://zoom.us/u/acNR9omfRY</u></font></a></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_TY1PR01MB14816C3E23543732B6F76311A0130TY1PR01MB1481jpnp_
Content-Type: text/calendar; charset="utf-8"; method=REQUEST
Content-Transfer-Encoding: base64

QkVHSU46VkNBTEVOREFSDQpNRVRIT0Q6UkVRVUVTVA0KUFJPRElEOk1pY3Jvc29mdCBFeGNoYW5n
ZSBTZXJ2ZXIgMjAxMA0KVkVSU0lPTjoyLjANCkJFR0lOOlZUSU1FWk9ORQ0KVFpJRDpUb2t5byBT
dGFuZGFyZCBUaW1lDQpCRUdJTjpTVEFOREFSRA0KRFRTVEFSVDoxNjAxMDEwMVQwMDAwMDANClRa
T0ZGU0VURlJPTTorMDkwMA0KVFpPRkZTRVRUTzorMDkwMA0KRU5EOlNUQU5EQVJEDQpCRUdJTjpE
QVlMSUdIVA0KRFRTVEFSVDoxNjAxMDEwMVQwMDAwMDANClRaT0ZGU0VURlJPTTorMDkwMA0KVFpP
RkZTRVRUTzorMDkwMA0KRU5EOkRBWUxJR0hUDQpFTkQ6VlRJTUVaT05FDQpCRUdJTjpWRVZFTlQN
Ck9SR0FOSVpFUjptYWlsdG86bWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCkFUVEVOREVF
O1JPTEU9UkVRLVBBUlRJQ0lQQU5UO1BBUlRTVEFUPU5FRURTLUFDVElPTjtSU1ZQPVRSVUU6bWFp
bHRvOmNpcC1kZQ0KIHZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQpERVNDUklQVElPTjtMQU5HVUFH
RT1qYS1KUDpUb3BpYzogQ0lQIEtlcm5lbCBUZWFtXG5UaW1lOiBGZWIgMjdcLCAyMDIwIDA5OjAN
CiAwIFBNIE9zYWthXCwgU2FwcG9yb1wsIFRva3lvXG5cbkpvaW4gWm9vbSBNZWV0aW5nXG5odHRw
czovL3pvb20udXMvai8zNjI3Mg0KIDIwODdcblxuTWVldGluZyBJRDogMzYyIDcyMiAwODdcblxu
T25lIHRhcCBtb2JpbGVcbisxNjQ2NTU4ODY1NlwsXCwzNjI3MjIwDQogODcjIFVTIChOZXcgWW9y
aylcbisxNjY5OTAwNjgzM1wsXCwzNjI3MjIwODcjIFVTIChTYW4gSm9zZSlcblxuRGlhbCBieSB5
b3UNCiByIGxvY2F0aW9uXG4gICAgICAgICsxIDY0NiA1NTggODY1NiBVUyAoTmV3IFlvcmspXG4g
ICAgICAgICsxIDY2OSA5MDAgNjgzMw0KICBVUyAoU2FuIEpvc2UpXG4gICAgICAgIDg3NyAzNjkg
MDkyNiBVUyBUb2xsLWZyZWVcbiAgICAgICAgODU1IDg4MCAxMjQ2IFVTDQogIFRvbGwtZnJlZVxu
ICAgICAgICArMSA2NDcgNTU4IDA1ODggQ2FuYWRhXG4gICAgICAgIDg1NSA3MDMgODk4NSBDYW5h
ZGEgVG8NCiBsbC1mcmVlXG5NZWV0aW5nIElEOiAzNjIgNzIyIDA4N1xuRmluZCB5b3VyIGxvY2Fs
IG51bWJlcjogaHR0cHM6Ly96b29tLnVzLw0KIHUvYWNOUjlvbWZSWVxuXG5cbg0KVUlEOjA0MDAw
MDAwODIwMEUwMDA3NEM1QjcxMDFBODJFMDA4MDAwMDAwMDA3MDA1NzZFODg5RThENTAxMDAwMDAw
MDAwMDAwMDAwDQogMDEwMDAwMDAwQjIwN0MyQURFMjUwNUQ0Mzk1NkI3QjExNTcwNzQ5RTINClNV
TU1BUlk7TEFOR1VBR0U9amEtSlA6Q0lQIEtlcm5lbCBUZWFtIENhbGwNCkRUU1RBUlQ7VFpJRD1U
b2t5byBTdGFuZGFyZCBUaW1lOjIwMjAwMjI3VDIxMDAwMA0KRFRFTkQ7VFpJRD1Ub2t5byBTdGFu
ZGFyZCBUaW1lOjIwMjAwMjI3VDIyMDAwMA0KQ0xBU1M6UFVCTElDDQpQUklPUklUWTo1DQpEVFNU
QU1QOjIwMjAwMjIwVDIyMzk1N1oNClRSQU5TUDpPUEFRVUUNClNUQVRVUzpDT05GSVJNRUQNClNF
UVVFTkNFOjANCkxPQ0FUSU9OO0xBTkdVQUdFPWphLUpQOlpvb20NClgtTUlDUk9TT0ZULUNETy1B
UFBULVNFUVVFTkNFOjANClgtTUlDUk9TT0ZULUNETy1PV05FUkFQUFRJRDotMjA1NTkxOTY0NA0K
WC1NSUNST1NPRlQtQ0RPLUJVU1lTVEFUVVM6VEVOVEFUSVZFDQpYLU1JQ1JPU09GVC1DRE8tSU5U
RU5ERURTVEFUVVM6QlVTWQ0KWC1NSUNST1NPRlQtQ0RPLUFMTERBWUVWRU5UOkZBTFNFDQpYLU1J
Q1JPU09GVC1DRE8tSU1QT1JUQU5DRToxDQpYLU1JQ1JPU09GVC1DRE8tSU5TVFRZUEU6MA0KWC1N
SUNST1NPRlQtRE9OT1RGT1JXQVJETUVFVElORzpGQUxTRQ0KWC1NSUNST1NPRlQtRElTQUxMT1ct
Q09VTlRFUjpGQUxTRQ0KWC1NSUNST1NPRlQtTE9DQVRJT05TOlt7IkRpc3BsYXlOYW1lIjoiWm9v
bSJcLCJMb2NhdGlvbkFubm90YXRpb24iOiIiXCwiTG9jDQogYXRpb25VcmkiOiIiXCwiTG9jYXRp
b25TdHJlZXQiOiIiXCwiTG9jYXRpb25DaXR5IjoiIlwsIkxvY2F0aW9uU3RhdGUiOiIiXCwNCiAi
TG9jYXRpb25Db3VudHJ5IjoiIlwsIkxvY2F0aW9uUG9zdGFsQ29kZSI6IiJcLCJMb2NhdGlvbkZ1
bGxBZGRyZXNzIjoiIn1dDQpCRUdJTjpWQUxBUk0NCkRFU0NSSVBUSU9OOlJFTUlOREVSDQpUUklH
R0VSO1JFTEFURUQ9U1RBUlQ6LVBUMTVNDQpBQ1RJT046RElTUExBWQ0KRU5EOlZBTEFSTQ0KRU5E
OlZFVkVOVA0KRU5EOlZDQUxFTkRBUg0K

--_000_TY1PR01MB14816C3E23543732B6F76311A0130TY1PR01MB1481jpnp_--

--===============9088630992173584663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============9088630992173584663==--
