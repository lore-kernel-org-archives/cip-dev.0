Return-Path: <SRS0=eDDd=4P=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_FACE_BAD,HTML_MESSAGE,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83A1C4BA24
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 09:04:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F47F2467F
	for <cip-dev@archiver.kernel.org>; Thu, 27 Feb 2020 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="ifl20QFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47F2467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D06487E90;
	Thu, 27 Feb 2020 09:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSc24R8Arg7w; Thu, 27 Feb 2020 09:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85CAB87E81;
	Thu, 27 Feb 2020 09:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C84C0177;
	Thu, 27 Feb 2020 09:04:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85618C0177
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 09:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7139387E88
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 09:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jro9RZdqNxNm for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2020 09:04:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400091.outbound.protection.outlook.com [40.107.140.91])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2150687E81
 for <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2020 09:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDgrcG7hYgTVD0P6f0b1mDqQ/pb1My1K8fCqKHO7/3wo8HP28jxJYJXyLdwVJRrY9ApROXtRc9TSJS1kkfF9Dfujy58K70N9xssfSwmdXwJzDlFN83YyRWgxxDRvKEgyAQn3NMNr58Y/nG+EcqXARcAoj1yMJtQGAI/FNuaUZwUfov0XMYuKR+QchapzB8uPkdtlP4nQcTnsZRs86JP5y6cjDLiWBIhcn+NmJ7YpcsxSxOdzxMEtCJGty95ehKHQPuxj809TcHP+zm9dmb4ZNdZ39dzgFswvJ2WCHAqxVhGJ3OzqeE0RfksD6RZ6auRYrfJd+BpW6OKvK9SrUeD1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUmtjesszbWxmY2vwV4CKGW9xQ8sf+F0iccGPGorMvk=;
 b=WzDMAm3qXSg0Pi3gI7zTHMCtm711qs73K63uoAcTia1T+DscnWULP1QzD9AX14Ldse9Yw+QwBUPjw37gCZd1bPtuSBbQyDJbcT9n8Tg2C05rJ0oJc6Fbx/vXYXNjieli4VnAVmXIzLC+0oWCrULCo4xqY4RvItACxPKbeThTgJflrdm3zr1RCQZlLKMLRmJlcPpfVXL19yOTBwDvrvmyAgGoJinBWXGpC3yAvKsoKtoPldc/GddHUAhOGFwkodh6DUVwzXaYR9dsFIC1gmHvcbd8JEL0kzzoBp+jaKYEAEty80Z5eKJF3ISwnDwpqTCsf5e/Ns8qEZ+aj6LQYIZU4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUmtjesszbWxmY2vwV4CKGW9xQ8sf+F0iccGPGorMvk=;
 b=ifl20QFxnX995a9YKn0usy3hMsf3IxESVejn4FFp+jQa/L+gpwbos3+tx3bvalRp2KpCU0sh9NitZITmX3JTP2t4wSslI5SZ7kojfhiwoNup9cAxIDNMT5fXTtn2e1tgsXCSQO8L1wXty37FskSrS6LiMycQxcLL24l23rnQa0o=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1546.jpnprd01.prod.outlook.com (52.133.162.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 09:04:26 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::503f:3885:b1d9:a8c7%5]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 09:04:25 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: CIP Kernel Team Call
Thread-Index: AdXoPotTDCgPYozLTDaeyEj6Md9s7gAACH+wAQ76MLAANH9aYA==
Date: Thu, 27 Feb 2020 09:04:25 +0000
Message-ID: <TY1PR01MB148163C4CA1D93220538B86CA0EB0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <TY1PR01MB14816C3E23543732B6F76311A0130@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <TY1PR01MB1481EE0DD938E1A1547335B1A0EA0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1481EE0DD938E1A1547335B1A0EA0@TY1PR01MB1481.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94248679-1ceb-4a4b-0642-08d7bb640b77
x-ms-traffictypediagnostic: TY1PR01MB1546:
x-microsoft-antispam-prvs: <TY1PR01MB1546AD29AABBBC2BAB03FCE0A0EB0@TY1PR01MB1546.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(33656002)(52536014)(71200400001)(3480700007)(30864003)(2906002)(478600001)(85182001)(6916009)(66476007)(76116006)(7696005)(86362001)(66556008)(64756008)(26005)(186003)(66946007)(66446008)(6506007)(316002)(966005)(8676002)(5660300002)(55016002)(9686003)(81156014)(8936002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1546;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acTwI6dWPDGJt3KLwQ/l/GmVJS+C+F2pHfWI21GqH42eNvPcUHAJYVrF/txugcGMNdh16JBkY8XJIXfpDVbG8uuqHBcHMt5jXWkvb2FqDarXu2GkPJkMYYKolXn0c1SUQS0TZe5DTI3YUh1H6kwOPMsbA7rgl6YlIU7iz0eqv8/zbpuHW8JrTv0tO3UvmwZV6GynlQTe7D6w0lkszEToNA0rY8423a2wWFCe4yj9hgKWtdfbtpDQvIUgfH8Q6arcjCqBC+Q3g67hwWW/fri4kVUK7YRI09Rc/IYj/hoEaHDVAAFAXLVi2nOj2WbjLOfUNH/4tb18yi34v6D4F7UMDejjHatk7nzXNsW5gjsi23Y6K3R0eRiY/frDx5X6kA1t829bANFUiAkx5q4Qe+GYkDe/aq8lmQBMiYF8fXWgAC8y6GkTcYqcnW6Impx29avD
x-ms-exchange-antispam-messagedata: 598MAs45lh2S2T/r4DtwM78Z+bRIrh2PkWsUGMEy7aTxv4OA2zb7htHEucyc7Qg4NWiqpoxnsx6ZNFxlbkvsyxk/Zx8BWY62nyNvpGksZYt7GXJMcXGWtIr+rRSMuCiiZhOMxInzCc3tQus092BMwA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 94248679-1ceb-4a4b-0642-08d7bb640b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 09:04:25.8768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQZaW7PU8Nmcgkwt+lBeWzsPDSKqZtx54En5Usrk4zYc+expMSg/HhEZH8p0X4+tEzo4GbR6Edbn4hjRSjPGmNi9d8a0aGqQd6DKRx4r5xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1546
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
Content-Type: multipart/mixed; boundary="===============8715588180430028238=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

--===============8715588180430028238==
Content-Language: ja-JP
Content-Type: multipart/alternative;
	boundary="_000_TY1PR01MB148163C4CA1D93220538B86CA0EB0TY1PR01MB1481jpnp_"

--_000_TY1PR01MB148163C4CA1D93220538B86CA0EB0TY1PR01MB1481jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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
To: cip-dev@lists.cip-project.org
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



--_000_TY1PR01MB148163C4CA1D93220538B86CA0EB0TY1PR01MB1481jpnp_
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
<div>Here is an agenda for the Kernel Team Meeting today.</div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;"><a href=3D"https://docs.google.com/document/d/1IlXKF4N3QnswEbyWFLMuR3Ig=
1FjUK_6w8tnjwI2lsng/edit?usp=3Dsharing"><font face=3D"=1B$B^b%4%7%C%/=1B(B"=
 size=3D"2" color=3D"#0563C1"><span style=3D"font-size:11pt;"><u>https://do=
cs.google.com/document/d/1IlXKF4N3QnswEbyWFLMuR3Ig1FjUK_6w8tnjwI2lsng/edit?=
usp=3Dsharing</u></span></font></a></span></font></div>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div>See you soon!</div>
<div><font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">--</font></div>
<div>M<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">.</font> Kudo</div=
>
<div><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size:12p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri">_____________________________________________<b=
r>

<b>From:</b> <font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B$B9)F#!!=
2m;J!J=1B(B</font>CTJ<font face=3D"=1B$B#M#S=1B(B =1B$B#P%4%7%C%/=1B(B">=1B=
$B!K=1B(B</font>
<br>

<b>Sent:</b> Wednesday, February 26, 2020 5:04 PM<br>

<b>To:</b> cip-dev@lists.cip-project.org<br>

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

--_000_TY1PR01MB148163C4CA1D93220538B86CA0EB0TY1PR01MB1481jpnp_--

--===============8715588180430028238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============8715588180430028238==--
