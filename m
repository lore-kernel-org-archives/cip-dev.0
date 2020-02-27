Return-Path: <SRS0=eDDd=4P=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CADC4BA24
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:13:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225C124695
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="XDWsCTgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225C124695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAE1386A16;
	Thu, 27 Feb 2020 12:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDC3ayW-WNZh; Thu, 27 Feb 2020 12:13:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FEB2864F3;
	Thu, 27 Feb 2020 12:13:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34644C0177;
	Thu, 27 Feb 2020 12:13:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5886BC0177
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 40E722221C
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u+e9HvCBv+yg for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2020 12:13:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410097.outbound.protection.outlook.com [40.107.141.97])
 by silver.osuosl.org (Postfix) with ESMTPS id 33C0822128
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:13:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ3OvNY1qQyVVU4gt3PlnLf0uRNzV4J0OnhskL3Iz1fPyJ95Zj2eu3jXnFdFGIB5PsLdyMYtMPSqLR7raheVf5oDvthhTGAX3RoPNPA3R9B4WX0ytr9lg/MACkIygytwQ3dnCwDWWNKG/Ks0TaQ+aXOvuloF2N5HHpajZlGjNU1/0F6bOzjLAuu7rB9HyLAZfrjr2V0qp+yVEj2Rzh6NUmFPTLGZ0ZfNYhEiqWM8A+V2fvQoFoYsAOJqzO1iZBa7X3dFSE2dxzlI33m/A+DqpNwklGSqxFBATTPgijkQB6Inn04dWpzsimXhVapceWgJgbg70eZMlPnqjpcnM1y4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVReTVSs00sSeZdU7p2exA8+rx14i10hxsBuk3Jmy6c=;
 b=YmOu9hvk//gl3i77pME8Dvl5sy89n6nriDQ0iqJCRmO8RxgWtJxM4d/vPp/SqhHF6wJFzVHiutiD5KlfgG1Y2uiHxuLYJkb8Z/n16XSuoFQFRBZn+fD1MddWL1i29bogB5DjV+kPOUNqVIcNOzfgL9E/Bn6dDFGf29+0xat2XUy9Y595zZGwyfcHeGIkxfCElKCxo1cX7jF/CFR0u24sUOTgtBGfvXANbc2BTICCLuWeP5Bw5sWCnRyLcAFllPhKXPwti36ou1tOow/vdlcExTlxqcSF9IWi6F1RAWwPQzawb3qVAujpOddIMq/wMk14qEkykWxkHTskvqWqzllxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVReTVSs00sSeZdU7p2exA8+rx14i10hxsBuk3Jmy6c=;
 b=XDWsCTgrMPTzecD57z9flKYmPI3AK7jHeShNr/WnmBM7wiDf4PB/6EmEbJ8xZK+X4yj8AEAoR+rwkba1P6sXiNvViZpg/sgQUZ8owztzvRsjhCzHpmA8JEH7vvuBBGvIBctil0DIjWqq5fqiyqc4W08wUfLidV8aVTR7MZ9Vdbk=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1561.jpnprd01.prod.outlook.com (52.133.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 12:13:00 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 12:13:00 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Team Call
Thread-Index: AdXoPotTDCgPYozLTDaeyEj6Md9s7gAACH+wAQ76MLAANH9aYAAGRfoQAABiBKA=
Date: Thu, 27 Feb 2020 12:13:00 +0000
Message-ID: <TY1PR01MB148194CCF1DC2CBA984AEB3AA0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB1481EE0DD938E1A1547335B1A0EA0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB148163C4CA1D93220538B86CA0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50342e93-e733-43b2-a9b7-08d7bb7e6360
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: <TY1PR01MB1561C04DC1A8734E1C08B3CEA0EB0@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(76116006)(66476007)(64756008)(66946007)(66446008)(66556008)(966005)(8676002)(81166006)(71200400001)(81156014)(9686003)(7696005)(2940100002)(33656002)(8936002)(55016002)(85182001)(186003)(6916009)(316002)(86362001)(30864003)(478600001)(52536014)(3480700007)(2906002)(26005)(5660300002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1561;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9H8CZxuBU1QEa9BbdxzjWZ59dLdLxXv3L8XFUW7WVDhnQcg6AP0zhbJp2LE3cg4IaPRVHTAgUPD6BptAcq+y8b7K9Le0DWhzZyxWGudosQZ9GLLLhHJB/V5nDbSHCvzm4jNMuNObE4LxDxd9VWHkaxZ5rZukt8n96GQJLRa0jxHuCyccNlqaNg7QZwm0QsmKQ7fqJ6iLqCK2ylrtKuiX5D3bsBAD/Vmj058hO/t+3kuOu1sAKhwfrETetC9V5BvQR4uJyw6WaC2SJwqdq+cmoN8s0p+86DhJZK9bie7M5X1SyQs28L4Pa4Dm44tdIrC1smFFozSVJ/+xo/0MzR8Dhf+gc361Z7VXosn3oBZWGYR3os3O8H5mQGjptRfEe2rya3p9R+KZjAz6Yivv8W4TyxrfmUbGEqXwtQ7J0oC9iqdItEaKsmvmGesz4ZUKDett
x-ms-exchange-antispam-messagedata: 1+qC3VsDOcX/ifDHhdl4feWnhPPW5ykZ7AaJMgPJZ6QeVnMD6MYhA7tCQVYVZSIsWFGRjmhBlluocVqDpvQfZnGUskMSoa3DpjocSKKGznZvWCB4b2Qmrz3misstkSn33TKZD+uBxZgk6Ko9NLTxQg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 50342e93-e733-43b2-a9b7-08d7bb7e6360
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 12:13:00.2577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyTCCnIcTtXMn1JRTigsdTHnmMah7cvz9idtCiTLEcLtvJt3WVnNXT8zZZZhGGctwH2ii/xti9k+KcmfV4oc5cc+6LKb12IKQ8HAruwrdTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
Subject: Re: [cip-dev] CIP Kernel Team Call
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
Content-Type: multipart/mixed; boundary="===============1555251803187685743=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============1555251803187685743==
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY1PR01MB148194CCF1DC2CBA984AEB3AA0EB0TY1PR01MB1481jpnp_"

--_000_TY1PR01MB148194CCF1DC2CBA984AEB3AA0EB0TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Sorry, again. Please login zoom.
--
M. Kudo

_____________________________________________
From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B
Sent: Thursday, February 27, 2020 9:03 PM
To: cip-dev@lists.cip-project.org
Subject: RE: CIP Kernel Team Call


Hello,

Sorry, but I have a difficulty to enter the Zoom meeting.
Instead, could you log in the following bridge?

https://meet.google.com/zgj-bnot-bfd
Smartphone: +1 615-965-4695 and PIN=1B$B!J=1B(B835 782 189#=1B$B!K=1B(B
For other tele number, check with https://tel.meet/zgj-bnot-bfd?hs=3D5

Sorry for this inconvenience.
--
M. Kudo
_____________________________________________
From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B
Sent: Thursday, February 27, 2020 6:04 PM
To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: RE: CIP Kernel Team Call


Hello,

Here is an agenda for the Kernel Team Meeting today.
https://docs.google.com/document/d/1IlXKF4N3QnswEbyWFLMuR3Ig1FjUK_6w8tnjwI2=
lsng/edit?usp=3Dsharing

See you soon!
--
M. Kudo

_____________________________________________
From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B
Sent: Wednesday, February 26, 2020 5:04 PM
To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: RE: CIP Kernel Team Call


Hello,

The agenda at the call is the following.
1.      Discuss CIP Kernel Team Roadmap for CY2020
2.      Review CIP Kernel Team status

Please note that we skip a regular IRC weekly meeting on 27th tomorrow, bec=
ause we have this call instead.

See you then!
--
M. Kudo

-----Original Appointment-----
From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B
Sent: Friday, February 21, 2020 7:40 AM
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B; cip-dev@lists.cip-project.org<ma=
ilto:cip-dev@lists.cip-project.org>
Subject: CIP Kernel Team Call
When: 2020=1B$BG/=1B(B2=1B$B7n=1B(B27=1B$BF|LZMKF|=1B(B 21:00-22:00 (UTC+09=
:00) =1B$BBg:e!";%KZ!"El5~=1B(B
Where: Zoom


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



--_000_TY1PR01MB148194CCF1DC2CBA984AEB3AA0EB0TY1PR01MB1481jpnp_
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
<font face=3D"=1B$B^b%4%7%C%/=1B(B" size=3D"2"><span style=3D"font-size:11p=
t;">
<div>Sorry, again. Please login zoom.</div>
<div><font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">--</font></div>
<div>M. Kudo</div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri">_____________________________________________<b=
r>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Thursday, February 27, 2020 9:03 PM<br>

<b>To:</b> cip-dev@lists.cip-project.org<br>

<b>Subject:</b> RE: CIP Kernel Team Call</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Hello, </font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Sorry, but I have a difficulty to =
enter the Zoom meeting.</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Instead, could you log in the foll=
owing bridge?</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><a href=3D"https://meet.google.com/zgj-bnot-bfd"><font face=3D"=1B$B^b%=
4%7%C%/=1B(B" size=3D"2" color=3D"#0563C1"><span style=3D"font-size:11pt;">=
<u>https://meet.google.com/zgj-bnot-bfd</u></span></font></a></span></font>=
</div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Smartphone: &#43;1 615-965-4695 an=
d PIN=1B$B!J=1B(B835 782 189#=1B$B!K=1B(B</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">For other tele number, check with =
<a href=3D"https://tel.meet/zgj-bnot-bfd?hs=3D5"><font color=3D"#0563C1"><u=
>https://tel.meet/zgj-bnot-bfd?hs=3D5</u></font></a></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Sorry for this inconvenience.</fon=
t></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">--</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">M. Kudo</font></div>
<div><font face=3D"Calibri">_____________________________________________<b=
r>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Thursday, February 27, 2020 6:04 PM<br>

<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org"><font color=3D"=
#0563C1"><u>cip-dev@lists.cip-project.org</u></font></a><br>

<b>Subject:</b> RE: CIP Kernel Team Call</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Hello,</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Here is an agenda for the Kernel T=
eam Meeting today.</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><a href=3D"https://docs.google.com/document/d/1IlXKF4N3QnswEbyWFLMuR3Ig=
1FjUK_6w8tnjwI2lsng/edit?usp=3Dsharing"><font face=3D"=1B$B^b%4%7%C%/=1B(B"=
 size=3D"2" color=3D"#0563C1"><span style=3D"font-size:11pt;"><u>https://do=
cs.google.com/document/d/1IlXKF4N3QnswEbyWFLMuR3Ig1FjUK_6w8tnjwI2lsng/edit?=
usp=3Dsharing</u></span></font></a></span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">See you soon!</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">--</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">M. Kudo</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"Calibri">_____________________________________________<b=
r>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Wednesday, February 26, 2020 5:04 PM<br>

<b>To:</b> <a href=3D"mailto:cip-dev@lists.cip-project.org"><font color=3D"=
#0563C1"><u>cip-dev@lists.cip-project.org</u></font></a><br>

<b>Subject:</b> RE: CIP Kernel Team Call</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Hello,</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">The agenda at the call is the foll=
owing.</font></div>
<ol style=3D"margin:0;padding-left:29pt;list-style-type:decimal;">
<font face=3D"=1B$B^b%4%7%C%/=1B(B">
<li>Discuss CIP Kernel Team Roadmap for CY2020</li><li>Review CIP Kernel Te=
am status</li></font>
</ol>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">Please note that we skip a regular=
 IRC weekly meeting on 27<font size=3D"1"><span style=3D"font-size:7.3pt;">=
<sup>th</sup></span></font> tomorrow, because we have this call instead.</f=
ont></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">See you then!</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">--</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">M. Kudo</font></div>
<div><font face=3D"=1B$B^b%4%7%C%/=1B(B">&nbsp;</font></div>
<div><font face=3D"Calibri">-----Original Appointment-----<br>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Friday, February 21, 2020 7:40 AM<br>

<b>To:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!2m=
;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B=
!K=1B(B</font>; <a href=3D"mailto:cip-dev@lists.cip-project.org"><font colo=
r=3D"#0563C1"><u>cip-dev@lists.cip-project.org</u></font></a><br>

<b>Subject:</b> CIP Kernel Team Call<br>

<b>When:</b> 2020<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$BG/=
=1B(B</font>2<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B7n=1B(=
B</font>27<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$BF|LZMKF|=
=1B(B</font> 21:00-22:00 (UTC&#43;09:00) <font face=3D"=1B$B#M#S=1B(B =1B$B=
#P%4%7%C%/=1B(B">=1B$BBg:e!";%KZ!"El5~=1B(B<br>

</font><b>Where:</b> Zoom</font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B" size=3D"3"><span st=
yle=3D"font-size:12pt;">Topic: CIP Kernel Team<br>

Time: Feb 27, 2020 09:00 PM Osaka, Sapporo, Tokyo<br>

<br>

Join Zoom Meeting<br>

<a href=3D"https://zoom.us/j/362722087"><font color=3D"#0563C1"><u>https://=
zoom.us/j/362722087</u></font></a><br>

<br>

Meeting ID: 362 722 087<br>

<br>

One tap mobile<br>

<font face=3D"MS PGothic Western">&#43;16465588656,,362722087# US (New York=
)<br>

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
nt color=3D"#0563C1"><u>https://zoom.us/u/acNR9omfRY</u></font></a></span><=
/font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
</span></font>
</body>
</html>

--_000_TY1PR01MB148194CCF1DC2CBA984AEB3AA0EB0TY1PR01MB1481jpnp_--

--===============1555251803187685743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1555251803187685743==--
