Return-Path: <SRS0=/m59=4O=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,
	HTML_OBFUSCATE_05_10,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA939C4BA0A
	for <cip-dev@archiver.kernel.org>; Wed, 26 Feb 2020 08:04:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D63021556
	for <cip-dev@archiver.kernel.org>; Wed, 26 Feb 2020 08:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="Sml2U2Bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63021556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00B4A875C7;
	Wed, 26 Feb 2020 08:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsfOqQ+nJeil; Wed, 26 Feb 2020 08:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC19D8759A;
	Wed, 26 Feb 2020 08:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B1EAC0177;
	Wed, 26 Feb 2020 08:04:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2282EC0177
 for <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2020 08:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE6482041B
 for <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2020 08:04:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yxkunmn3CjqE for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2020 08:04:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410102.outbound.protection.outlook.com [40.107.141.102])
 by silver.osuosl.org (Postfix) with ESMTPS id 3D0012014A
 for <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2020 08:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNelIMC3rSgPwUMqmbKydVWa2Nf6R6oSE7z9BbSll0BB3xp6xEODZdOn3ydoRJjALnALtMqxx7Ks3+kiKC/gHNFY1ojnS85DiYX5rgMwnlBwpfTvaQmfxn1Yv5ZSl63n0ZlimpPrfIllWFC5y6O3foarL8znnz/wI6N89dqn7VnXE6H3pRrdYmriI9NNJzyi71aLW4HTeq3LSvAHuvoVL8sZP9MNZhxN32npHwg9IXq07Lau7LhGn3LMdxteK7QVsCKPKOYEm9kd5nbnyallDZjSQDaWF/t6xKkCazGIkFWoAerQRydjHCWmEhnlhjZRkNEUeXswp3viyL107A56/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JykRXqw40RdOvllAl8Ho/Br9DDKZrRoETCsZDIxEs=;
 b=EWz8jPLwWFt/vsKp2B1nVDcoqlW8Jp/vfT4rix6MOsRJA4+Dc4VyuDOak4MkiKg+P0GOYpW7fnERcRiy8vSDD06Nmg/seUCOweJHnzZG1LQm+YvYdzTBhsAb7Wk6cAvsUtBWt1coXJwEZttGFTYvXvpvJ/0vm4uT3wygoe8c89y6RzGroO3H2wbqOarfPp0QPWUilNM9DPDvT+dkmWOY/erkrCcJf9w+u/NdPrZFKuPHu7RZLz3RfgeLu5WRFCy6HkQKZ1NveQsKy6DXpyv8bDdG6MKHdHDLJvGLlC8BgAaHDErO5LGG6TSusFYwWPMP3HG6tkUUxzPQPDidaWO7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JykRXqw40RdOvllAl8Ho/Br9DDKZrRoETCsZDIxEs=;
 b=Sml2U2Bitzzc2PujkJfBjTu0jXes+1f8dWhNxi6hEg4CKYqtP/t7BFczcUD1w2z0bp+2icT40zvH8s9rZLUqcsHqrMI0HOZTIe87aLWZcMCPJmBFn4K0lBtyPDdRNMR/TiNilhUrfvbuniKx6HNwugPT9poMbTyGuvdzzF/UD64=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1SPR01MB1.jpnprd01.prod.outlook.com (52.133.164.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 26 Feb 2020 08:04:02 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 08:04:02 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Team Call
Thread-Index: AdXoPotTDCgPYozLTDaeyEj6Md9s7gAACH+wAQ76MLA=
Date: Wed, 26 Feb 2020 08:04:02 +0000
Message-ID: <TY1PR01MB1481EE0DD938E1A1547335B1A0EA0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1232a84-19f3-4177-e361-08d7ba92711b
x-ms-traffictypediagnostic: TY1SPR01MB1:
x-microsoft-antispam-prvs: <TY1SPR01MB17CBC90E9CD71214D3CD9A0EA0@TY1SPR01MB1.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(81156014)(71200400001)(8936002)(85182001)(7696005)(81166006)(316002)(3480700007)(9686003)(30864003)(33656002)(5660300002)(6916009)(52536014)(6506007)(66446008)(8676002)(64756008)(966005)(55016002)(2906002)(26005)(186003)(66476007)(66556008)(86362001)(478600001)(76116006)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1SPR01MB1;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9wnrANNTwvNLUxq6wZEdZaq45VHLaniLUz/7IiiQnVdJAINsZ83OAMc1FsUE21nTOxjoPbLrKPBfgyqXNIhP5u8xmKiSwvwf3MepzG2CW14PQeoI1u/DWBBuRMxclftZEIWnxBfgeJtS76xNv9+tF+PvRr6p8+mW1QakEooU8RcZtOKdPBEDj0bnxc0x8sE8ezSKP4WXZQUiOtvoPnPoYYq1RJx0TOjk7K9R5eefc+MBtqxKGy/TY3ZP9ktWgvKy5BuX6uWUWvk/V9STl6HVcHaOg4SjuQ+u9Xm4jodOa5ItJx0ogiPpC48Zmao5jQHTd21EZGu0taMzOU6vaGtdZ1m7LbIJxf8DCdO1kF2IrwQUe+TMnZLlW++Jc7cgO4KHua2jGDXzCHk42jpTaHY8dzsK3YWphBaxcQ+oRe6S3zC2nKb9H45wJyCITSGhCjc
x-ms-exchange-antispam-messagedata: 7Nh3TJ9tfNEPvBzSxUXoKn2xmkFgT+2CZuTsvHxrh4vs4nLaT383tmwLiUOQj8L5FL/W0KoAjPnMiKhva5h3/VUmURqFTTjUHsNj1AR87oF2TTuwC2iMB2y8n3UfCqBZoSTx/nKCYzZwXqFf6GgCUw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1232a84-19f3-4177-e361-08d7ba92711b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 08:04:02.1399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvSY8LLWctQeax6GNqjFzQRYbmOCmQcsIIPYSznLNUYvy/LgxvRBRioT+Pzg8I8leaEc3XuTVABpo1rfmmaGOWoZSVRe65cYtoeo9LvhJsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR01MB1
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
Content-Type: multipart/mixed; boundary="===============8448645483812209094=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============8448645483812209094==
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY1PR01MB1481EE0DD938E1A1547335B1A0EA0TY1PR01MB1481jpnp_"

--_000_TY1PR01MB1481EE0DD938E1A1547335B1A0EA0TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!K=1B(B; cip-dev@lists.cip-project.org
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



--_000_TY1PR01MB1481EE0DD938E1A1547335B1A0EA0TY1PR01MB1481jpnp_
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
<div>Hello,</div>
<div>&nbsp;</div>
<div>The agenda at the call is the following.</div>
<ol style=3D"margin:0;padding-left:29pt;list-style-type:decimal;">
<li>Discuss CIP Kernel Team Roadmap for CY2020</li><li>Review CIP Kernel Te=
am status</li></ol>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div>Please note that we skip a regular IRC weekly meeting on 27<font size=
=3D"1"><span style=3D"font-size:7.3pt;"><sup>th</sup></span></font> tomorro=
w, because we have this call instead.</div>
<div>&nbsp;</div>
<div>See you then!</div>
<div><font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">--</font></div>
<div>M. Kudo</div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri">-----Original Appointment-----<br>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Friday, February 21, 2020 7:40 AM<br>

<b>To:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!2m=
;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B=
!K=1B(B</font>; cip-dev@lists.cip-project.org<br>

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
nt color=3D"#0563C1"><u>https://zoom.us/u/acNR9omfRY</u></font></a></span><=
/font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
</span></font>
</body>
</html>

--_000_TY1PR01MB1481EE0DD938E1A1547335B1A0EA0TY1PR01MB1481jpnp_--

--===============8448645483812209094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============8448645483812209094==--
