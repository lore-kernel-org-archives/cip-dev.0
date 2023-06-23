Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10079EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 12:01:55 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web11.40296.1687521709126517153
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 05:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=M9szGKRd;
 spf=pass (domain: renesas.com, ip: 40.107.113.96, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFcdTIQXZW5c02kuxdJyo4WvnNqRcU79XUN/nsdXK+LqHpSCA3fylqG81A3zl6BcMOega4LFtjRIR8VoSLR/QqRuQZaENChdAjYK2mA/iyFf3oN4BG5T5/dodMIv9gadgNVNS/orBE/fiqoe2gH8XHQsKjji6/3lrG4ub0I1zajBYh9p0zW0xb9dk/1tpruyg3lQ3Fo03BimdoQHaBWtQksY6p4sg5tEl3Lxvn1IMFcZrusiydscZ+oR9wBUDIYQGJ8O1ENd3OZAHcEYUlfmHXWKeDFfQ00Mfb2s397ee8eN0SQiHn3t+0U/3JXjWUtd1zLpxN6xrPV9h33cecSavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1kUyV1KN87/xSHbHv9X7RlwpCOoopThXRzSBzmbR8o=;
 b=JUHH+IYgHuiPhzVvH51Q9nou4mjpqPvXhT7VQa1oYvgkWeNGrlgCFr82m95l0clFLSRiHmHC++s8PKCGcpK9iLmxm39Y+u22Dd3tKrF+Vk216NFlO5vS3B7uhLBKufAbB+tAwfGF7xWA7wevyeRPGhlVo2DtiSTH0sxefJJjPe4U+hgiQfidPOS/TrLxlbSDfO3R/ga4qQntApbxXPWTl/Pg7qQgHYkw5LzOtBZ31WW9MCouajjpygHd0JuAj6zRPbYgl9iGhxq57ncqSHDyQQU+Kude4aUm3946QM0W6eleGs7LLCxxRVXFlHfawRvrOBAjhPPDm4rkVOyEkMZD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1kUyV1KN87/xSHbHv9X7RlwpCOoopThXRzSBzmbR8o=;
 b=M9szGKRddU9Hm+qi0kLjm2fKWg8NdY9Zg5D9TiST6Ym+fIVkPHF7VqCIyGNYqUjbpYC7H02YcA2c6H2rnf8sysFs0+pfgyExkdIKniRQv6IT3itfV/AoOsL0knch5kxJjKfW/onH4FMvAnnwwoLvDiFT8IaOgLnTJhdp8tGxHbQ=
Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com (2603:1096:604:d8::13)
 by TYCPR01MB8836.jpnprd01.prod.outlook.com (2603:1096:400:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 12:01:45 +0000
Received: from OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::e1aa:48ff:8244:cde4]) by OS3PR01MB5976.jpnprd01.prod.outlook.com
 ([fe80::e1aa:48ff:8244:cde4%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 12:01:44 +0000
From: Hung Tran <hung.tran.jy@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Yukiho Fujisawa <yukiho.fujisawa.te@renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Kento Yoshida <kento.yoshida.wz@renesas.com>
Subject: [cip-core] Package Proposal #3 (basic security openssl)
Thread-Topic: [cip-core] Package Proposal #3 (basic security openssl)
Thread-Index: AdmlyLrzDGKsYpQSQLuVveqmE7OEdg==
Date: Fri, 23 Jun 2023 12:01:44 +0000
Message-ID: 
 <OS3PR01MB5976DD21C889975CE5FA8BA3C623A@OS3PR01MB5976.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5976:EE_|TYCPR01MB8836:EE_
x-ms-office365-filtering-correlation-id: 9dd36bbc-d94f-4e15-66ad-08db73e19d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TYxMawXbjxQrfIDfVlUEn9VRYs1IrihPQ+mtl5uyX6R6+3cxWkv+X+Zp8FkSq/ctRgcgaDWQQHoP2hBiwara0GTqESJ+nCkQ6HX0uwkYkAWssOCR9AH/eKHA35zbDwX4LYYsuyAuz+or9LiGFZmZlEMP315djnM852S8giyLIv9psuTXVQG17FRiI1p1a21AtyuktsKjf1WsPJpn4q41P0O86G0B3oHiChQAi5YxspP8LGVO0p8EwN5tY3Dl9NOUMHL2OU/gu9SMEv5scXK2s3VvJMTIrHBDc+zNdJUL6dfWbVSNUZqY7TWLCLBwVBOALGyJoXF94fU6novRBH9oUHY5TKW0uvTPpaXmnDGZIDcpG40uROB9Gde7l0a33EBO11PsqswyaIS1e92l8mAc3VVNUPpzRaDYQb3SudV4Im+RD82Mx812ADVO7FvSvdkC92K4gpc933GM63rgWFWbSWMuXCmWo5ASwvJGFMlYt1xAHSJDqF1gABU4PJtfBWH51a1ieQLPzgl/C4/9W6ltk8lLPsrliddJf/8k+YV3oRcXpSh5ifOHv1hZFfCxOxcB/hswgaGZqN4Vdb5cAp9CVc5iD0hu+w7Iq4wFvt1xlBwXDupieFiubi8jU5ua2t1J
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5976.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(54906003)(478600001)(55016003)(107886003)(26005)(9686003)(6506007)(7696005)(71200400001)(5660300002)(2906002)(33656002)(4744005)(66476007)(6916009)(66946007)(66556008)(4326008)(64756008)(76116006)(86362001)(8936002)(52536014)(41300700001)(8676002)(66446008)(83380400001)(316002)(38070700005)(38100700002)(122000001)(99936003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?N8bWt57X4cs7aXpkisCH6aQp0IuXIbc6LJQqux6gCL7sxRmo1puT6mW9x2cs?=
 =?us-ascii?Q?AXsn6Bjp+f97hbNZeUlE78STsUMZG8nlquExER4gEED2bmM2uVP9eShqt2F3?=
 =?us-ascii?Q?s6Zy63zTS6VVDSPqoZAjfj44XumVNTv1mseuh293aiqe0ODdYG3SWmpHlvFA?=
 =?us-ascii?Q?ZA3HxP1ywf2TX34OjrIZj09NtIqMFL6nUZR0Y9It4oaHhS9hYI6wfiprEpVq?=
 =?us-ascii?Q?2dXHPAK6sJ0I2U3Bo4NJned3WH43Wf+3KEiB0uSqsAFWD4GLYtXmB8ohMqsO?=
 =?us-ascii?Q?0tze2n7Z7yZog5iGyGuerwa+sdhgpsmFpXxMvC30I2+/IdNtjVzNc3NzL4U8?=
 =?us-ascii?Q?Hs+k4n+CTdUsaCO8VGgilDFltetXFXGJ4jMX4y9cfT4dN+oqC8ycNZ9TjPuC?=
 =?us-ascii?Q?rAyiZI+QLfxRAmyrg0cuFn1orwpXL6+KXv4rAZcMUNpkY++m/6xHp8N01EED?=
 =?us-ascii?Q?DlgfvrFLFbRV/XgmUi0DH6ucwVyaddYclKpENcQHy0jF63CLGMY1HWct91vp?=
 =?us-ascii?Q?oMXPtGHas4750kfnPDmz5oArH/jx6Q1f+JpLgF9y8XahmgHEHCkHxQznR/0N?=
 =?us-ascii?Q?8RKF5lFOZ2hwwaCPDCSljeyV2VykEadO2VjE08IWFS9a0obramnOb1orKBpX?=
 =?us-ascii?Q?3b2UypktkFNX0Wb3X+ahDxf+Ww00r/U2gIkIHMJrEEoO/ykpgzFc4Y/gQd10?=
 =?us-ascii?Q?8DRxhZlRAMEJN/g2jkdny6JZSsLZgTjSzl+ptyQVhr18vVXxPDy/GhZ9hw27?=
 =?us-ascii?Q?lSnjiu1V/uleP+ubQxfvJ8hc8UJJ5oAbSao9r4yyr4Q3a7no3hnsTreHG2Yo?=
 =?us-ascii?Q?UQE1X8t/4gYvoXewUDhcU48j644Yjk6810TtblZJudbdzDSv1zPNKynCHWvT?=
 =?us-ascii?Q?dS4w5jo3NUNEZjlXRuSKr23J5KEA2Fl9h2aCxEQ+C25hrt67hwwOUn4lehrF?=
 =?us-ascii?Q?DJoKw4aJHRVf/qdY1s07MXx2uvhVAPY7Z6Fl0AxvOCIBkTN7rxmsynWvrOJu?=
 =?us-ascii?Q?l10+8wxDoi1vYd2wFvWROaBNB+nNIkwxQzrvuEVNNJWlfxIV8hXmT6DEMHq/?=
 =?us-ascii?Q?35VM+/8lGybyS0N1tZD4ojK7Rrdy31PsOWnh8ArU//jAjTZHvyi3O2mI9S/2?=
 =?us-ascii?Q?EjXjGTBX6zxOdMRCXVU4oDI03j+UX7TuMhVkuHLkU7SmuaFMFPv892Hm2xy+?=
 =?us-ascii?Q?j5cJcFnh3qJmXj9dz62SCHoAwZFxBkqlwEQ48MN6IfFlZrfdKoTJJ5cndlBz?=
 =?us-ascii?Q?CzrFPZGRfBiMo9fdbHI19Hde4JBgqJ0hvpc12ce0v5VzuPmoVU6o4hRMa4Zy?=
 =?us-ascii?Q?ooARnpvldPXYBEPupPjTAv80tgDvL8gUQm5YPxIh2/92g/jCCGiaoRb11HvO?=
 =?us-ascii?Q?wXWRn435mMX8wfY6QYp0wYhyvEkZEVTkEcTER9gTKUpBTKNSATYAh0HMAqGI?=
 =?us-ascii?Q?x075fwSY+E9XTCGgdcIu0zqB0dnTM/PMxkZ7jyU2cWSAJlRLQJIIWEARbAP+?=
 =?us-ascii?Q?cH+l7bC70ZQPnNDRYm7WO3UdEZQ5fyhnfrCWrgrYsZZQgl9gXi4EfZaaR8GH?=
 =?us-ascii?Q?7PXmHrUOF1Nm5e8Eh5rAgzI+Lejn7DUsHt+O5Ku1?=
Content-Type: multipart/mixed;
	boundary="_004_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5976.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd36bbc-d94f-4e15-66ad-08db73e19d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 12:01:44.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLuPQJ3tuMNvSCeH2ohwwnKhWGjhetkkcV9mdTZyPmxjvr1/MHCydIs/h1CbeaQW2YY3OFg9pBOk2YGKuwocB640g1Ns9MUKyiLFVgbJqJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 12:01:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12135

--_004_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_"

--_000_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Kazu-san and CIP Core members,

This is the proposal from Renesas, as mentioned in our meeting recently.
Sorry for taking so long with this.

Basically the proposal only include 1 software, openssl.
In our opinion, it is an essential software, and should be maintained long =
time (with CVE appears frequently).

The proposal is generated by script. It include 1 source package, 3 binary =
packages, with 2 basic dependency (already included in current list).

Regards,
Hung.

--_000_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Kazu-san and CIP Core members,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is the proposal from Renesas, as mentioned in o=
ur meeting recently.<br>
Sorry for taking so long with this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Basically the proposal only include 1 software, open=
ssl.<br>
In our opinion, it is an essential software, and should be maintained long =
time (with CVE appears frequently).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The proposal is generated by script. It include 1 so=
urce package, 3 binary packages, with 2 basic dependency (already included =
in current list).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hung.<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_--

--_004_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_
Content-Type: application/octet-stream; name="proposal.yml"
Content-Description: proposal.yml
Content-Disposition: attachment; filename="proposal.yml"; size=500;
	creation-date="Fri, 23 Jun 2023 11:53:27 GMT";
	modification-date="Fri, 23 Jun 2023 12:01:44 GMT"
Content-Transfer-Encoding: base64

ZGF0ZTogMjAyMy8wNi8yMwpkZWJpYW5fdmVyc2lvbjogYnVzdGVyCnBkcF9yZXZpc2lvbjogJzQu
MCcKcHJvcG9zZXI6IEh1bmcgVHJhbgpzcmNfcGtnczoKICBvcGVuc3NsOgogICAgYmluX3BrZ3M6
CiAgICAgIGxpYnNzbC1kZXY6CiAgICAgICAgZGVwZW5kczoKICAgICAgICAtIGxpYnNzbDEuMQog
ICAgICBsaWJzc2wxLjE6CiAgICAgICAgZGVwZW5kczoKICAgICAgICAtIGRlYmNvbmYKICAgICAg
ICAtIGxpYmM2CiAgICAgIG9wZW5zc2w6CiAgICAgICAgZGVwZW5kczoKICAgICAgICAtIGxpYmM2
CiAgICAgICAgLSBsaWJzc2wxLjEKICAgIGluX3RhcmdldDogJ1RydWUnCiAgICBuX2N2ZTogJzIz
NicKICAgIHJlYXNvbjogT3BlbnNzbCBpcyBhbiBlc3NlbnRpYWwgcGFja2FnZSBmb3Igc2VjdXJp
dHkKICAgIHNlY3VyaXR5X2NyaXRlcmlhOgogICAgLSBkZXZlbDo6bGFuZzpjCiAgICAtIHNlY3Vy
aXR5OjpjcnlwdG9ncmFwaHkKICAgIC0gc2VjdXJpdHk6OmludGVncml0eQo=

--_004_OS3PR01MB5976DD21C889975CE5FA8BA3C623AOS3PR01MB5976jpnp_--

