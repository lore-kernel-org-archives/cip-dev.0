Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D62CC5516F
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 05:56:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6216.1785503320178813262
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2026 06:08:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=samarth.atreya.k63@mail.toshiba header.s=key2.smx header.b=Vd97leey;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: samarth.atreya.k63@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	samarth.atreya.k63@mail.toshiba;s=key2.smx;t=1785503304;x=1786712904;bh=D6Two
	FbBRjjoNuYCFFATUt/F6DJb3lGTE87/moLL3X0=;b=Vd97leeySJB6OWH6WV8RsY2NKdSCz0U5bhY
	GaUKg1wHBmhPszD5j2xMOZ/dfvzVcf30x3WimMlo7n+IqpfCWbHBwKYLSu26QFmKkgzmPc1tMZT6b
	2o8UaHc6qC6V0wj/FMW/xeQm0qFdARjjoQaEJcNXffH0j8Bdh8t0k9bzU3ra2ica/TWOmac80XHnu
	swtYvtcKCB1OP6dFn1ZZO2g46Pi82r+4vQGFT2kbiwChEPxjqCp3yaZ2s8MfaBEkLoj5f80W+0JNy
	TzIEBXNBxhC9u29/RW/UPPFpXNPux+zXJEOoYe2itFVxyL8BldgEZ+4lWP8cURKw4TKhPxlUqblA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66VD8OC93933294; Fri, 31 Jul 2026 22:08:24 +0900
X-Iguazu-Qid: 2rWhDvWdSFOwNdqpyz
X-Iguazu-QSIG: v=2; s=1; t=1785503303; q=2rWhDvWdSFOwNdqpyz; m=6Xw9r/fUbaqbZKpZzOICaXE289ONW5CP3exEUn0oHNE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hBRFz39fLz4vym; Fri, 31 Jul 2026 22:08:23 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK1uBQzpnxnv+gG+3WfQ7T6mqiIcAeHCiTpiiSyeBUjp9NauR+hDcCUirruEaD/9MT53xtu51WwzUyps9jyoo0rcwb9sdQPB+ATkA2vc+7KAm0jphaSnTj/QOxCbukkMW98o94xOpjLp8CscTbY4kHk6IyAFGTJFpdmy+BV3BS/lukMiGUTNZJzGJFHb18+uVQsHEmos7g/S04Tx3Mf0IyUA5grk+nerLOuFwBZKAXKKWQrBNi55bFrNSJzNDLXSz0tFvL+2nrF++UO4UA+b+BVULclwzg2FdNaiWBFEgf+bj9Ac/rlEHXlMcV9sHhSYm3d1L14PRebChZGCtNGx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Neyl6fab9TdEjkdpC4buuIl/jhvGC3tDAB2RGSjWFg=;
 b=AiHH61EFdv0UHHgx60qASf3g3e5sL0EuWlBhbfRBDsPNorpUuDdAICwfUaJKjXKjOMlScaAPpozdkajPuMJhu/Dlq5HXc+XMXrxibcLjbVmN0h7KQqC6m5Y+5d0ntjBork0T6CIVJYZUJBQhSXa60B4d2LYafpIrMcw27P/5o9cYfu/1/VJIxxkCT9HMymrbUJjRnUTGYF+sxieaHFohgL+afPeYPlORIKpZPMTpKkirkD5O00gmvCgDNMoySjkp7s4bD89isal78YFj6rSRmT7z0nCqJOCCuIHe5kR8B/fKmaPw/2ifdpseXrSl7e9Tql2EP7AW5GRv0LYhAFJSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <samarth.atreya.k63@mail.toshiba>
To: <submit@bugs.debian.org>, <bernat@debian.org>
CC: <cip-dev@lists.cip-project.org>, <kumar.dinesh.h95@mail.toshiba>
Subject: [cip-dev] PATCH: libsepol: Enable Autopkgtest for libcbor package
Thread-Topic: [cip-dev] PATCH: libsepol: Enable Autopkgtest for libcbor
 package
Thread-Index: Ad0g7YYEg1YY2h+DReWv1YVoaeSg9A==
Date: Fri, 31 Jul 2026 13:08:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY4PR01MB156248B073C4C7809B387592BB3C82@TY4PR01MB15624.jpnprd01.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB15624:EE_|OSZPR01MB7889:EE_
x-ms-office365-filtering-correlation-id: 8b0142ab-3354-4444-c8a8-08deef04caa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|6049299003|10070799003|23010399003|1800799024|56012099006|11063799006|10067099003|8096899003|18002099003|13003099007|4053099003|38070700021;
x-microsoft-antispam-message-info: 
 MfNS1YnotyOSr+wZpGXouU+ENl1UX3gLHH5j6ZlmsO9ROj3Fc5oqnazXT5oXIEYgSdUFHpPJJnBT5Pt9w73OUMfZXOwJz5P9fPtzTPfzwBfYI2C/gF7ELc7/QEtnOiHm82gicaw1ztbhaoNrpTVzRXnQV3FM5eL7PqrnJ5CQdQuDwJCZflL5wY4yVnS6A3QB0wvJYSNaiJ08I+/zrCQbx4/CnZVAc5yUam/ZSE+BroYh5SLb1wyfNEBXdlQAKeXle5gOlpm7UGXOay95LIT7DdeJ5YmjZ13qiPI80JfG2ABx65hlj4nsmnxmMSHcuDauggTZqIpuZNmpYfAjyEJbTak74cyc7BCb8ptPrVrvXp1gYSie4lcrZUiC+F32zAQyUZnSUno0FvL+qXW1Tcd5U96gcZLaqsbswth4af57cxRB138e0wHy/iFvIRn4PavBiDedc7Hsa7XTtsW3QCkKkqLt4x8IPsHF7DtNDN2tOPFtsyVfunXOZyzt2OJwr4alH2Kjq8gaCi2SHyILlkd6UIx5mKoP0cOkN30NDgEIZ4U8BABhOq/A6C+WD3svQ+rZivGd9ip7UIa/8s9YeYEeTi9xaOUiJ0U1ovJ7Pyjenv8AI9vYJ7hnI7BNaTa+axOxwDcHjQRrbhJurvxxUIlQmPEUcrIJouIGEuQAEB3yfARW9bL4EV6ZKf2XlQJlE3P8WE/ZvM+fMOCQC1rEiUnhSUw9JCeOB3KPKBYMzpTjKFU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15624.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(6049299003)(10070799003)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(8096899003)(18002099003)(13003099007)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?R09RMEgxR0NEZklzK3dERGxiQURQczRCQVlTSFBENjVJNkRwYW42d1Zp?=
 =?iso-2022-jp?B?ejd3WURmc3VXa216Qk1Vak1kNjVnRTl2eWdZT0NuTXpiM25nVFJQeHhO?=
 =?iso-2022-jp?B?SDJaaysxSk5SZmM2T3hmNllFTWtkSVpXb3pQc2lZOC9pM2QrQUE1ajVQ?=
 =?iso-2022-jp?B?aGlYT3lYd1pFTUZTTFpzdzVGVEhTQkxoUG5ZeTh1TXA5dTZYWnJWY3I3?=
 =?iso-2022-jp?B?cGpDU2cvSXI5a0RYOXZ1Z0xMUUNEOEJvSVRqdExqOWFFT1JoWkNCOU9W?=
 =?iso-2022-jp?B?V1dNRnBVbXdXN0JPQlJML1dPa3FsbUJDeEtGMCt2a1BhMGtnTzcrVkN0?=
 =?iso-2022-jp?B?c2pFek1GU3BQcnZGMlk0dVNMa1JvWHVOSFQzVDU1OVlCYUl2cStteGIw?=
 =?iso-2022-jp?B?WGQxbTIwbytqeXJ0YW42VHVxOEtRSVVpRFdFdXdMVGJOdk1PK1c2elNZ?=
 =?iso-2022-jp?B?b0VLaEVhcFg2a2YxSEZSeDZkUTI1VmV5czdDL1dycW1ubFVUaWsyOXhm?=
 =?iso-2022-jp?B?YkVWUEx3SVdoWDJFb3E4amgwK0lvenIxb0NNTGZ0NFArc1Avb3ZISWtz?=
 =?iso-2022-jp?B?L0Z5cUVuVENucVhkQ0M3NHZ0aFBpbTVPSlVXMVIrTkplckZ3c0VLZ3V6?=
 =?iso-2022-jp?B?TjZjSlJ1TnFjUHhhQnNXTWtLdDg3bTZORzhNek9jREIwNG9ZdkMydzBW?=
 =?iso-2022-jp?B?R1B4enFtd1RROXpuNnU1TzdzcXJwZ2ZjVk03WW1wMXpXQnY2SFNKY0ho?=
 =?iso-2022-jp?B?ZzVjR0g4R2ZCSnd2TE9tRndqQWZWdHo0M0pYSGlPMWxmTFlHTlN5bXpD?=
 =?iso-2022-jp?B?QzB3bEFTa2ZobmV6bTcyd1JnMjI3UDZsekVJM3h6eUhRV3Q0UTJKVnlZ?=
 =?iso-2022-jp?B?NGNzNzlWTXpyT0taNC9nOWw2RGR6ckN4ZU83cXVCcUppdWhRWWppRGpB?=
 =?iso-2022-jp?B?RWczcjRTQTcxWE1PTXZIWUpNQi94bEFydGhKdnp3ckNoQzlYcnd5Mnk2?=
 =?iso-2022-jp?B?R0gxYlBYUDBzV1VtVzh6bGJmNXRWcEt3cHhxRWtQYXhEcFBFNUxRajZ6?=
 =?iso-2022-jp?B?ZXR0SUlxdm5QaDZjWnRBdDdCSjFOaWJFUnFVYTRhR1JQdnBIUjVtTmNy?=
 =?iso-2022-jp?B?ckxMeDN2TTVPL0N5MHk3ejY4NjZVVisyanJoU2xwVlJjbHl0SWRXWUZl?=
 =?iso-2022-jp?B?eThrNXVsQ0dBZHB5cnd2ekhLUDB6OHpMN1k5SGVoSEpMSUFIaFdnRExU?=
 =?iso-2022-jp?B?ODB6elYvU0VPZXl3ZmRRcGhzdk9rK1BHRzVLY3creldDNldCNmVhZm5k?=
 =?iso-2022-jp?B?VFBPR2N2Q1h3dVJpYnhGU1BOcWs4Z3AxRlpZVDhQTWNqSFRmdkpIWldI?=
 =?iso-2022-jp?B?TVNTeVVpN290TzBOeEVRWWZkditSejhOU00wVC9ha1pCdkU1c2p4UVBZ?=
 =?iso-2022-jp?B?dXA4SUhQelkvU2xZSHRkSTNyVXdxNXJHTG56ZzdWaGdyRXRPSGNoeGpM?=
 =?iso-2022-jp?B?YnRMbGJkZnV4cVAxZ2JNNXB2RlEyQUVFYjZqSjI4d3FCZU9pdDVjMzJC?=
 =?iso-2022-jp?B?eitIV2c0c09jUHFUa0kwcTdBWU9ZckE0Y3dkNVdON0I2c0JkanJtTmJF?=
 =?iso-2022-jp?B?WmlaTWxBYng3NnhUUEdaYytjYTM4MFpORHhnUXoxVVBlT2lkWUdWZjNL?=
 =?iso-2022-jp?B?QVFaMzFtSy9vaS91ZVV5ampWVFUxNS9GTVI5bGJ2c0c2cFh2cm5ETnNC?=
 =?iso-2022-jp?B?d0tkOHdyUEczU1diMHNYSzdHV3NqWHFJaTVVeHRrS1o4dktHY2FSWlJj?=
 =?iso-2022-jp?B?bTZQVWVhdVJsWktSVUIvTG9QYS9iU1E0enBRN3ZianQ3dGp0RVM5WjNO?=
 =?iso-2022-jp?B?dGRvRlYxZ3JsUEtwSk81cEtMRUtDVEEvMjYyamN4Smtpc1UraG45bnZp?=
 =?iso-2022-jp?B?QzF1MHJ0Vy94bGowSlNRTWd1eE9JUkpaSW9DQkNEbHRXTWdlZjhYUExl?=
 =?iso-2022-jp?B?K0xaNStPTFNUNjJYL25zcEtCY01KNmoxeGd0UnpFOGI0NnFGaVNEeEUr?=
 =?iso-2022-jp?B?NE5ETEU0NFlMZ3FCNzRvbk41YzlXT3dZNlUvQ3kzc0thWHhTUXFJSDMv?=
 =?iso-2022-jp?B?eXpqc052ZFV0S2hTV3VWcElNaTRTK0lPWWRJS2tUdDkyc2tsbVZoL3ZI?=
 =?iso-2022-jp?B?TEZsd2lkc3NwZWduU0xqV1BQdFlUSWVoM3hsb0JSYnlrMXY5aThMcUtR?=
 =?iso-2022-jp?B?TFlJOWZXRU45V3d3ODFiSFVKYmVWUW0wVkRZbEx2d0UrNkJ6U2dWcEJE?=
 =?iso-2022-jp?B?c2U2YU1VcTBpdE9uQjdGVGsrNDhqYW5NMi92NkgxT3dtRjJ6ZzJMMGdR?=
 =?iso-2022-jp?B?QVNpSnZPbkhmRG5XKzFJZkNvL2RkcWpkTU9uQ0cwaUEwZmcrSUtpcVdx?=
 =?iso-2022-jp?B?WThQc3liaUFKbGw4ZE9obm1hMytvVmE0K0lib1p0a1d5Uzh4MHJoWlh0?=
 =?iso-2022-jp?B?NVF0WjVaMVZ6REpHWmt6S2p0YjhHZ1V0em41dkdGUjNTaDFabkNlNHdv?=
 =?iso-2022-jp?B?alJVQ3kxeTBOcXFCSC9iK1ZyUktBYzJCdFM1NVpkcHVFeE4r?=
x-ms-exchange-antispam-messagedata-1: AgTX3OUTiFHtzDbgmdS4iR+Dq82nqyEDF1w=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	osjF1Y0jvoLk095ZrY5FeJW6kTmlsPQIX3EyIxju8vdTb3QtIDHzfGonDWM8DgczS+HoQOCN+72qRPsSF3Wg6KrJZ6ECoDa5vxp/5/NWfw1cJdhEbkLiC8Ma75aYgjIDsU3TC9ykF4gDCZYF14jODGcXcqXA4z0WbvzSUZSvw32nWUrwLg8Afk/aUB2goZ1kA3QvfvdWHIGmNycxbBQ7pzBS17vmlWoFpa+PNH8ZekSWVzZ7GAZpXW1e6WHAsS4aoIQ73+ic+6FA83du5iDPeq7XyxlY3O3KruMvZwfqWURk3XwJe0iw+HVi2e71OhaMgvslmaqIAjbqAubtFgK3ag==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB15624.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0142ab-3354-4444-c8a8-08deef04caa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 13:08:19.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ7zp4/BDh50Fi7oWZ94QZ92QbC0Z1bJWQ47NvoYz2wbtOxIWFJ/knnY8ojmo9IoeahB82F+ly/gP1M/DahSUJseIFDiwqqpbI+YBjhs1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7889
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 05:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23849

--_004_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_
Content-Type: multipart/alternative;
	boundary="_000_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_"

--_000_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Source: libcbor
Version: 0.10.2-2.1
Severity: wishlist

Dear Maintainer,

This patch enables autopkgtest for libcbor by adding a control, makefile an=
d a run_tests file (uses makefile to validate the upstream tests against th=
e installed package)

Also created MR:
https://salsa.debian.org/debian/libcbor/-/merge_requests/4

Please review the patch and provide feedback.

Kind regards,
Samarth Atreya


--_000_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Source: libcbor<o:p></o:p></p>
<p class=3D"MsoNormal">Version: 0.10.2-2.1<o:p></o:p></p>
<p class=3D"MsoNormal">Severity: wishlist<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dear Maintainer,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This patch enables autopkgtest for libcbor by adding=
 a control, makefile and a run_tests file (uses makefile to validate the up=
stream tests against the installed package) &nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Also created MR:<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://salsa.debian.org/debian/libcbor/-=
/merge_requests/4">https://salsa.debian.org/debian/libcbor/-/merge_requests=
/4</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please review the patch and provide feedback.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kind regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Samarth Atreya<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
</div>
</body>
</html>

--_000_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_--

--_004_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_
Content-Type: application/octet-stream;
	name="0001-d-tests-enable-tests-via-autopkgtest.patch"
Content-Description: 0001-d-tests-enable-tests-via-autopkgtest.patch
Content-Disposition: attachment;
	filename="0001-d-tests-enable-tests-via-autopkgtest.patch"; size=1744;
	creation-date="Fri, 31 Jul 2026 13:06:06 GMT";
	modification-date="Fri, 31 Jul 2026 13:08:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2MGUzZTllYjExYzg3OTdjNmI1YTBiYWM4YjdhNWMzMjFhNTNhYzg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZXJuYWxvZmNvcm4yIDxzYW1hcnRoLmk2MDBAdG9zaGliYS10
c2lwLmNvbT4KRGF0ZTogVHVlLCAyOCBKdWwgMjAyNiAxNzozNjoxOCArMDUzMApTdWJqZWN0OiBb
UEFUQ0hdIGQvdGVzdHM6IGVuYWJsZSB0ZXN0cyB2aWEgYXV0b3BrZ3Rlc3QKCi0tLQogZGViaWFu
L3Rlc3RzL2NvbnRyb2wgICB8ICAzICsrKwogZGViaWFuL3Rlc3RzL21ha2VmaWxlICB8ICA4ICsr
KysrKysrCiBkZWJpYW4vdGVzdHMvcnVuLXRlc3RzIHwgMTEgKysrKysrKysrKysKIDMgZmlsZXMg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRlYmlhbi90ZXN0
cy9jb250cm9sCiBjcmVhdGUgbW9kZSAxMDA2NDQgZGViaWFuL3Rlc3RzL21ha2VmaWxlCiBjcmVh
dGUgbW9kZSAxMDA3NTUgZGViaWFuL3Rlc3RzL3J1bi10ZXN0cwoKZGlmZiAtLWdpdCBhL2RlYmlh
bi90ZXN0cy9jb250cm9sIGIvZGViaWFuL3Rlc3RzL2NvbnRyb2wKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMC4uZTQ4MzVhNgotLS0gL2Rldi9udWxsCisrKyBiL2RlYmlhbi90ZXN0
cy9jb250cm9sCkBAIC0wLDAgKzEsMyBAQAorVGVzdHM6IHJ1bi10ZXN0cworUmVzdHJpY3Rpb25z
OiBhbGxvdy1zdGRlcnIKK0RlcGVuZHM6IEAsIGdjYywgbGliYzYtZGV2LCBwa2ctY29uZmlnLCBs
aWJjbW9ja2EtZGV2CmRpZmYgLS1naXQgYS9kZWJpYW4vdGVzdHMvbWFrZWZpbGUgYi9kZWJpYW4v
dGVzdHMvbWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZmE2OTRk
ZAotLS0gL2Rldi9udWxsCisrKyBiL2RlYmlhbi90ZXN0cy9tYWtlZmlsZQpAQCAtMCwwICsxLDgg
QEAKK0NGTEFHUyA9IC1XYWxsICQoc2hlbGwgcGtnLWNvbmZpZyAtLWNmbGFncyBsaWJjYm9yIGNt
b2NrYSkKK0xETElCUyA9ICQoc2hlbGwgcGtnLWNvbmZpZyAtLWxpYnMgbGliY2JvciBjbW9ja2Ep
IC1sbQorU1VQUE9SVCA9IGFzc2VydGlvbnMuYyB0ZXN0X2FsbG9jYXRvci5jIHN0cmVhbV9leHBl
Y3RhdGlvbnMuYworRVhDTFVERSA9IHVuaWNvZGVfdGVzdCAKK1RFU1RTID0gJChmaWx0ZXItb3V0
ICQoRVhDTFVERSksJChwYXRzdWJzdCAlLmMsJSwkKHdpbGRjYXJkICpfdGVzdC5jKSkpCithbGw6
ICQoVEVTVFMpCiskKFRFU1RTKTogJTogJS5jICQoU1VQUE9SVCkKKwljYyAtdiAkKENGTEFHUykg
LW8gJEAgJDwgJChTVVBQT1JUKSAkKExETElCUykKZGlmZiAtLWdpdCBhL2RlYmlhbi90ZXN0cy9y
dW4tdGVzdHMgYi9kZWJpYW4vdGVzdHMvcnVuLXRlc3RzCm5ldyBmaWxlIG1vZGUgMTAwNzU1Cmlu
ZGV4IDAwMDAwMDAuLmRlMjI0MzAKLS0tIC9kZXYvbnVsbAorKysgYi9kZWJpYW4vdGVzdHMvcnVu
LXRlc3RzCkBAIC0wLDAgKzEsMTEgQEAKKyMhL2Jpbi9zaAorc2V0IC1lCitjZCAiJEFVVE9QS0dU
RVNUX1RNUCIKK3NyYz0iJE9MRFBXRCIKKworY3AgIiRzcmMiL3Rlc3QvKl90ZXN0LmMgLgorY3Ag
IiRzcmMiL3Rlc3QvYXNzZXJ0aW9ucy4qICIkc3JjIi90ZXN0L3Rlc3RfYWxsb2NhdG9yLiogXAor
ICAgIiRzcmMiL3Rlc3Qvc3RyZWFtX2V4cGVjdGF0aW9ucy4qIC4KK2NwIC1yICIkc3JjIi90ZXN0
L2RhdGEgLiAyPi9kZXYvbnVsbCB8fCB0cnVlCitjcCAiJHNyYyIvZGViaWFuL3Rlc3RzL21ha2Vm
aWxlIC4vTWFrZWZpbGUKK21ha2UgCi0tIAoyLjQ3LjMKCg==

--_004_TY4PR01MB156248B073C4C7809B387592BB3C82TY4PR01MB15624jp_--

