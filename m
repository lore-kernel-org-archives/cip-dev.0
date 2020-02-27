Return-Path: <SRS0=eDDd=4P=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,
	HTML_OBFUSCATE_05_10,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8018C4BA24
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9188B24695
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="nQaSdSgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9188B24695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C57E87C7D;
	Thu, 27 Feb 2020 12:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFCLcUJnQ0HH; Thu, 27 Feb 2020 12:03:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 58E4387A5E;
	Thu, 27 Feb 2020 12:03:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33526C0177;
	Thu, 27 Feb 2020 12:03:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49076C0177
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 30D418506F
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZqTWcdhXbpT for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2020 12:03:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410111.outbound.protection.outlook.com [40.107.141.111])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 455868785E
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 12:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0jBi56z/QDf4r+SZi2pYHXfFKqHkki55jCMruTEsMkd1CsaX7TgFO8WPqiaJXJo7P1Y0fiTH/3tP7BldPlDabW0FvL7LdsN+rT/IPD1+3AGpPsY3yZvzNMS1XEJisRbJjmCWBNACR9olkwF3ACNrpIW+lLXS9vlbeiN8k4+XV6b9Xoyg0wgUd61Ofw4LXJM+mzfLymi1vuODMEfw7YK8iRJfvHHI3menMiotPRY94ySClhroahB0tuhuggYnYvQXuvsNgaNtwJ8E9cJe/3OAwWDiUAeulFZSUbXsBjo7O+6axX/43NOwE9c2LuG3HOwaOaLLB/lrtCfZx7byzYM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dbu8DA/hS/FpPGPq2UiFZDCE6PHPw1bOgtGTL5cf90=;
 b=bS7w5qi35KV6CDKx4HTDcPe5vs8ptUHCm1RglKDZ6jr+LaD+7XyEtucXBM+dyBSdmXSZ4Vvc4GXaUkDhYlJZ1TZy+NTiU1E2Dim5s6T2b+3fSHKSCYzdeDi4l5oHGD/bpP/uhskuCsEl7qaqB3sp71VCiczGnkxBxuHolkhy41Z41bn05TlsYtpAceCLvo6ydycVc9m+DTUnPDp/gpf3ooFi/LsdXHTxlG61TCLPMdCwp3qAnmqaBqB7E/JSntZQuLUFbund19LJG28xdsQ4j9cdUzjVB+81KR07YHjup321oasPsO5P/z9yTr+tByJc3R5olgHMFLsC8r8aZ3ZcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dbu8DA/hS/FpPGPq2UiFZDCE6PHPw1bOgtGTL5cf90=;
 b=nQaSdSgYuwUWB6i9JH7uTVhGBpfTdAXx66oN7qo9YQ7VGf+Cwbn47YdV7CQXzIYNt/ZOacPqpZNLegftj/WcmavJ3BEqYb5SjYpvyjSaDDoFpJuTCgn75RCTHyWSINSAf7QS5+wyPL8fXyOIEG0V/ly5QWMasN4zcsWQFiApJCk=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1497.jpnprd01.prod.outlook.com (52.133.162.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 12:03:28 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 12:03:27 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Team Call
Thread-Index: AdXoPotTDCgPYozLTDaeyEj6Md9s7gAACH+wAQ76MLAANH9aYAAGRfoQ
Date: Thu, 27 Feb 2020 12:03:27 +0000
Message-ID: <TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB1481EE0DD938E1A1547335B1A0EA0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB148163C4CA1D93220538B86CA0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB148163C4CA1D93220538B86CA0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4c8bb9d-032c-4e51-d291-08d7bb7d0e30
x-ms-traffictypediagnostic: TY1PR01MB1497:
x-microsoft-antispam-prvs: <TY1PR01MB1497DDEF8C06D4E06CBDE7E9A0EB0@TY1PR01MB1497.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(55016002)(9686003)(86362001)(186003)(3480700007)(26005)(8936002)(81156014)(81166006)(7696005)(30864003)(8676002)(316002)(66476007)(6506007)(2906002)(52536014)(5660300002)(64756008)(66556008)(76116006)(66946007)(85182001)(966005)(6916009)(33656002)(2940100002)(71200400001)(478600001)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1497;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0pRdqe4JdDi3yFJrKOpXCTX6DOvO/q77GfELs2OS8KI2WvQ6gSU8pWbFnk0ZlFwyGt/mxSTW3+1jdvxbETeZmnXRjFsHodk4BWvkZGvilJ8N42Cudvthfk0dKLXJVrn+OfyQKt7PfM3k1iARpQKf1+rED2QeEqLbvWWSlO+c9YNZWBGoqbAFW4g2jZjStuC7jq3y25+oTiacSPWKI5/Ub/W1ZM1FYy+Sg9N5vdASYy0XbwKN+h15RyDi1RxyDROwycSo9Pe9gjoKyvMTyFoERZreBt/jacgrnIgFBXitF1HoPHlW+ISwp+1ZWOSSBeMm75OwVDhayJSbqXSkk5XYEZDEtmYGR5tfcUBO+A8iT8p1XRfTYEAqr8y5Ub5HNrxHbb0wPAWX15VlHH7kRaJkDj6YVrroh+tGHHqhqh3JCNKiv2f3ZZZdu/QD39s4Vaku
x-ms-exchange-antispam-messagedata: abV58FbTpeM9ysZXRt5et5wVt04x+2NTpA/jtOt6L/oFcXBCap0QpEgiBQh+sKDBZrCe3flPU5jPiu+dE57k1W0S9aPmtNbh4+lzqih0ASsETJMiXMsEuQ/U68jLJMSLVwkZBfAgm8B2rNTz37AxPw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c8bb9d-032c-4e51-d291-08d7bb7d0e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 12:03:27.8022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVWzKUEYN3pmzjVDWiPH2vtS4MqFsJfNwFszR7XpU2LaZgIJxFx2z44+3b0Y72QIF4eUBVOV9FUTzhxeAX6eZPA2UGK76lmZTwoDCkoW5U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1497
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
Content-Type: multipart/mixed; boundary="===============7663713792129186341=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============7663713792129186341==
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0TY1PR01MB1481jpnp_"

--_000_TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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
To: cip-dev@lists.cip-project.org
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



--_000_TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0TY1PR01MB1481jpnp_
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
<div>Hello, </div>
<div>&nbsp;</div>
<div>Sorry, but I have a difficulty to enter the Zoom meeting.</div>
<div>Instead, could you log in the following bridge?</div>
<div>&nbsp;</div>
<div><a href=3D"https://meet.google.com/zgj-bnot-bfd">https://meet.google.c=
om/zgj-bnot-bfd</a></div>
<div>Smartphone: &#43;1 615-965-4695 and PIN<font face=3D"=1B$B^b%4%7%C%/=
=1B(B">=1B$B!J=1B(B</font>835 782 189#<font face=3D"=1B$B^b%4%7%C%/=1B(B">=
=1B$B!K=1B(B</font></div>
<div>For other tele number, check with <a href=3D"https://tel.meet/zgj-bnot=
-bfd?hs=3D5">https://tel.meet/zgj-bnot-bfd?hs=3D5</a></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div>Sorry for this inconvenience.</div>
<div><font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">--</font></div>
<div>M. Kudo</div>
<div><font face=3D"Calibri">_____________________________________________<b=
r>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Thursday, February 27, 2020 6:04 PM<br>

<b>To:</b> cip-dev@lists.cip-project.org<br>

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

&#43;16465588656,,362722087# US (New York)<br>

&#43;16699006833<font face=3D"MS PGothic Western">,,362722087# US (San Jose=
)<br>

<br>

Dial by your location<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 646 558 8656 US (New York)<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 669 900 6833 US (San Jose)<br>

&nbsp; &nbsp; &nbsp; &nbsp; 877 369 0926 US Toll-free<br>

&nbsp; &nbsp; &nbsp; &nbsp; 855 880 1246 US Toll-free<br>

&nbsp; &nbsp; &nbsp; &nbsp; &#43;1 647 558 0588 Canada<br>

&nbsp; &nbsp; &nbsp; &nbsp; 855 703 8985 Canada Tol</font>l-free<br>

Meeting ID: 362 722 087<br>

Find your local number: <a href=3D"https://zoom.us/u/acNR9omfRY"><font colo=
r=3D"#0563C1"><u>https://zoom.us/u/acNR9omfRY</u></font></a></span></font><=
/div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
</span></font>
</body>
</html>

--_000_TY1PR01MB14810D73A0BF4ABC76CA7224A0EB0TY1PR01MB1481jpnp_--

--===============7663713792129186341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============7663713792129186341==--
