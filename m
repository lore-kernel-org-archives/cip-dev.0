Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5A3C3DA42
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 06:22:46 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.76])
 by mx.groups.io with SMTP id smtpd.web10.73921.1720419758772412289
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jul 2024 23:22:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Mfu9djti;
 spf=pass (domain: siemens.com, ip: 40.107.249.76, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNThKO/Y4Pi/SMlg5cFjGFJVQdunZYh9u/++SfXnJcn+OHxalktxJEMec7pA721RC2+zZoUDt9xc6K79RkAfJyJmmdys4LXS8i+lTAvAllWVBYwJDqCoeQur4NJhrzFByAWNiyyA8dwKZDN/7WgSS4oTPzKV+MdCXnWD3mGB4Edt9GkfwDm0m5BwMkrGjaSxCKOi5RAwlkU6hu/r4M2/8TAQr6s2c9Da5FC5S5++kbW8pVeVMH/OHg6c8QcrXXVJabrbCNEbpqlxYhB2YvBdo1xU/zjJaZRZBsyPtK5vMlB3Kf7aRR/zgG6d1VpEXUJisZox8Jm2V9BnFzH6jY6l6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxcfWC4MR7Tf1LPLpeiz4FISBYq3Zp9fxm5LhWQf7dQ=;
 b=CeE+FO57MZyHT5LdIktQQzGkNfNDB8SpV6WnJ+QhaUuKfWScTy0JnD38y4l3A/4QVpAuZ8zuJKHIejHOLpLxlYqEQdXxs+lcVgpbmyjyDNqtefF1LKmXWIL/Rg/v6nYNqT3iMvfkG/ARwLmCSDUad53AODaVKMC/XxGnZhNU13xNryDu0DvtIbUBvnUVzZAm7TZ46Hue2uLD3RM2LxylpoNbwxJRQ88pqyRDmLd4jAQdmTsTOSGoxaSw1pLnn8DfYkaA0O1GLLZyldDSJaAB2wc/VnQAP4c/r05lKEGLAcWZmKdXxpVfWQAcct5Sz0y0x5DseOULrOFM45KICqwO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxcfWC4MR7Tf1LPLpeiz4FISBYq3Zp9fxm5LhWQf7dQ=;
 b=Mfu9djtidhFp393PDXEAfSjRdcTZXkPiWvblB3AiBcZJh7v+TdSRnqwm4HEcDRcvEpB1/V8Q291Zjf6LNk5L3Kic+9+S0X0LVDOJl6YD9KQ280SzgTpE4jjHZCgU9YKjjmBo6maXwqgwEu0gIJCx5Iy+7al5EDYi2ZuvzrpThNXVjCtNETgLvIAIHpZbK1gwntdH0NXI9PTSH9+YrXMjUZGRO93RTKRN4p58bq7+VMJztisjKw/E8bZHYO/Hq7w8OPQo0CKwwFmEh6e7KIlxgK9gxJeeqKSezTVKt+IKR2o8A6jgnPef8yUV0apYXzkrcwVEdGfchaNsKHn26/OGhQ==
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17)
 by PA4PR10MB5729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 06:22:32 +0000
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e659:e46:3b99:a440]) by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e659:e46:3b99:a440%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 06:22:32 +0000
From: "Storm, Christian" <christian.storm@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH] swupdate.bbclass: make swu_files entries unique
Thread-Topic: [PATCH] swupdate.bbclass: make swu_files entries unique
Thread-Index: AQHazrKCL7WXL1IgbkeDcF9cOFvTebHsYQkA
Date: Mon, 8 Jul 2024 06:22:32 +0000
Message-ID: <F901FB53-B396-4FEA-8BE9-4C4DFD907B0F@siemens.com>
References: <20240703114242.1896508-1-ch@denx.de>
 <7a7ed1e59a5682144aaaad819fbbd1264f3ece34.camel@siemens.com>
 <204be939-3a9e-4210-9194-a70ac83640da@denx.de>
 <349d4345-dfa5-4925-b9da-8217b6caca64@siemens.com>
 <f8734192-f1f7-4cb1-bff8-edc950eb390e@denx.de>
 <8fc0b73c-5185-4bd0-952d-7f01aa2a1a2b@siemens.com>
In-Reply-To: <8fc0b73c-5185-4bd0-952d-7f01aa2a1a2b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5404:EE_|PA4PR10MB5729:EE_
x-ms-office365-filtering-correlation-id: 2b9659b7-47bd-4169-9466-08dc9f1659dd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?SQ9Xz36IyqMOTms1MkWJCk7X3kApJ9ZFAtuuq52fQSb7Hos+/XPOhJr2QPhU?=
 =?us-ascii?Q?9FmM2ATT3G4kdWSoOhZON/o+/bBUc2MfjYPPVSxMz47qa9W4u7adjyQr6jHv?=
 =?us-ascii?Q?FUzpWXukOaj9xZA05gzUSZWVqK9OstOLeFzfUbPHpWEasnN9IJJmA55yTKgw?=
 =?us-ascii?Q?gLIu8nyP5OWazrotFe1ypbEIS6pFzYZ+RuQ7I0uQ77oUTNZQuJhGbSUAQB/y?=
 =?us-ascii?Q?2p4t9BgC1XebUJyEnAFCbxPquknDLtMfSvTboppzrUhSQZwDMeIDBS0rMUHN?=
 =?us-ascii?Q?WLaIAOOSYt+1abL72qlJ9Y63Gw1TW4+TDEey4k7RUxZaujpRyG791hvhfdgi?=
 =?us-ascii?Q?ZlSGGkIxjA9Ntee5q49AuY/MjN+VvppyWfow6wqthOSqH4EonDku0LS1LjdH?=
 =?us-ascii?Q?ZrwqAUdEcQvPWNojj4RxJ+ohgkM5h5EJabWAQfCE8JYQNdY9J3qAdqzbAav3?=
 =?us-ascii?Q?/cRvW7AQo4WOGPmhbCInfxRctoo6AY2j4n9/wCJRo2wV8XDAocY7xUN44ZiO?=
 =?us-ascii?Q?SBsHQgFFq0y+2CKwppIvxvIzh0kCh1/bXUbXWJR2mm8kIcRpXTxzyjGrPPfH?=
 =?us-ascii?Q?nVZ+nDVuTZqfbi1PkqDc6iTeJK6P13VUYkpzdWUxiIKM7jpYglmCbNKGwPQN?=
 =?us-ascii?Q?kDPQgDOJgOBoEzs9hwzrJ1uG+w1pICTrpOWhFgGH09hyzMVnIdPJMlsWalte?=
 =?us-ascii?Q?vZ0dpXLPiyoaLLBeD7lEuRMjJuCc+dGKw2Nc31TtqdjcNFrOGu/6F6bX60jC?=
 =?us-ascii?Q?jkSOniA6hioykVBmcs2Oj/Q33R4Mlwhc9JfXYKgH7dDJp+M9Opel9jmFkvL/?=
 =?us-ascii?Q?XCeQpXM9poOqOiHhIEcQiAYJKKKcrcI4X+b/EHQUTxT7UPBgJyEgwHgyMUsK?=
 =?us-ascii?Q?wF5tbxIXLsjE6SXrGoU7GGSWp+vbhICavYxzCKvcgAM2Vactzo9GqRsjn0l2?=
 =?us-ascii?Q?iAEBvdp0vXtrz6RFgF9hHtu/qdmUJAGgFKqzsHAI22LEADoPOl/rv1p1BL+4?=
 =?us-ascii?Q?A3Rmb1EWYLIdojkQ7TCoiqCqKp9CSkme41SnntTRlX2wFCQ7sBFHWy+Fl/14?=
 =?us-ascii?Q?2Qm5NnF6RhKYXDOezoWYuPFK8Ta1It8zkOTSBfoKPZs6obMi5hsFpAJl4ZDu?=
 =?us-ascii?Q?X4sooJtP5mSxB/8QL9IThn2zthi2vX/gNHMVCpb9TazJgwAVwayC4VMVnz/N?=
 =?us-ascii?Q?xWTR2JZnCJuw/MGwxJ7iwnIInZsSC1+T5qwNDFGcVqx90NHO3rDMB+JnxdmI?=
 =?us-ascii?Q?7Y7O0Hbt330DFee78gHxww5oEQOrrgc1RjKam+jKg3boRgNm0QdOFGZHgrQD?=
 =?us-ascii?Q?v1iVbbE3ZkZeK3fqS2JFsN9hcg9djuQZR6ERdsLxHy8L0bywWlA4n6xiQemP?=
 =?us-ascii?Q?zMmauNs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U2b5JHALEzj8xwOMIMXk3bG2sA2+yQASUgKA6te+kd85XXB5wZU4u1z9I+MF?=
 =?us-ascii?Q?iGLb0UFHZRsviYJHQz08ap96D7YY9/xuSwNx8Uexu0JqNo+U6xo2Phae/nZ8?=
 =?us-ascii?Q?0lfdGAbaXEd9cMk5wrqVcVsvg49KgcxJ2/JAnwzxuF8rHH6pmR/KmA8Zj91M?=
 =?us-ascii?Q?ktasiAel/YNnOKg0VPhm+mGfVbXmvNPsMTkJAnk/3oiVb9XaGguHzbJWU8QA?=
 =?us-ascii?Q?LhPbroNBg3AmMfGIGhBuMVFXh0g6TEcp8Cn+lSq3Oxx8fHBpq6NsSeKSENny?=
 =?us-ascii?Q?uwU9XK8OMRmaCiRFk3zp0Av1H59EUsJ2X+/rvQZ00xXHhEl7oKB7PAt29ZAw?=
 =?us-ascii?Q?/hCqcKgH+O3u9quvs3qsaGJvN+6rCCS2J/1N5A1TnK0l/XefCf9fcmsMGlwR?=
 =?us-ascii?Q?+ntXIuipWzusssxASXYLBQ2GQlKgyLuUSW5Ynub9JKIqt5Ai2g93AYsOnerc?=
 =?us-ascii?Q?m/PeORARuqAm7BYr2S4cu9euTg8e+SjZlbq1q3nc32WaOmxtVdbS3gCEoO2q?=
 =?us-ascii?Q?Bu73ey0mx0oRefOhcl8IBgOxRVj+qeTN4L5O8epNV484+Z43oJwUfwLDNHe6?=
 =?us-ascii?Q?17L0+HFd/xh78JzQ4s0y9tbJJY4PDQkhAJCGV9ESsvHEANn6IGgMHQAXYgxR?=
 =?us-ascii?Q?je8uQmrYXKSx86nilV+GYp2spILx6wzNCWVwjO/ii/u5/ctAQB4zaMiJjr4Z?=
 =?us-ascii?Q?47iP8Jvl4Ii4wknmMF3ubhcPgCGro5quB1powcfusyNaWQWNuoc73Lwhc3vw?=
 =?us-ascii?Q?5Ua0OpCM4sKTz70F5M+gL8A77PeCtpU/nOfOYxitVVvhHpt56LxKTXcOITrS?=
 =?us-ascii?Q?f4BFVu75+oa9pzu2W6PBrApaWHj+3AlwM+mMvO0uS01QbSlJWEEJecDBakiI?=
 =?us-ascii?Q?WxXfGryCLeYC+mnki9xY+CgUd10cTmhlZ1l+CJ0LS4XGqw+XhlPSpNsrrg9A?=
 =?us-ascii?Q?u4zOGg3mkyAVe9w762EX+sz47M48bWvKtCuSQMen2h6ETU7dHafzEW/2krb3?=
 =?us-ascii?Q?PFuEiaYG/gJqXCo6j7spbwgHWlbIQztm0QtkkyhtMMbkBzqMnhuaQVyldXuM?=
 =?us-ascii?Q?5Di0IwcjPK1T/FbYzc8+S9P7tDOyHyOLy/AeTephp2LLmuUJJz77iQd6V3kq?=
 =?us-ascii?Q?U+ArR6zTOVEORzqff1nUkZYrvQrRxANnPkqwhJUd+Q8xrXHai4lZnI8n59An?=
 =?us-ascii?Q?lHK1EJeyoGd4DYT/hjwvuUUKXu9VAFuxJ3EsKfgDUTx2pZiufTPp9Y7YXHjp?=
 =?us-ascii?Q?cmOH5DDnpSAf+YmxMCE+qNjebrm2Yj4JrlX2FVPnxxc2roBuZ3JbPDISATLI?=
 =?us-ascii?Q?5pyF4nyF63c/Fp2AiRwlpHoUnPvqh2FR0S6ZwdsLfadCV/lhSOVF20TCsiak?=
 =?us-ascii?Q?fNjYIAT/lBjD98Evm/wVkUIsM2E8PpYYEB1st5hpI6h7pVc7xLBO9pNmyHrp?=
 =?us-ascii?Q?mLi2X6Pfb+3LXv/2M8jFHZ9bsMiTAa1yBYDvoMmh1a916BDuLB2tfydv5gmo?=
 =?us-ascii?Q?cURdtoy8kUVklGBZnoqEI1liuaUrq7L0PX8bSCbgUGR3foghEBqoVglTQ4ax?=
 =?us-ascii?Q?7kzFjaIqtUlrZ4Fhx8REg8sTlY/sEXKDi7tBsy9W/Pap6MikTjB412DTV2Ij?=
 =?us-ascii?Q?wiwSOKEW0J1/XSkwko1J0To=3D?=
Content-Type: multipart/alternative;
	boundary="_000_F901FB53B3964FEA8BE94C4DFD907B0Fsiemenscom_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9659b7-47bd-4169-9466-08dc9f1659dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 06:22:32.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZ6OEA8T0Rl2i0uMU5SO2CtcnXjU/7pt5dqtgvqSNXbDhOfaI9AHLlgtzTJmFdMJ8pIpWdr59TaDkZWZs2nKchtnrtYqDXIYwOg4b559kXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 06:22:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16424

--_000_F901FB53B3964FEA8BE94C4DFD907B0Fsiemenscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


From what I experienced, outside of isar-cip-core, the software
collection approach is much more common. There we have swupdate wrapper
scripts, that figure out which software collection should be used, and
call swupdate accordingly.

Right, and that additional, possibly ugly wrapping is what the pattern
in isar-cip-core avoids: You just call "swupdate -i my.swu" (or
equivalent triggers), and everything works as it should.

Christian, seems there is a gap in awareness for this option outside of
the isar-cip-core universe.

Hm, it's well known to the readers of the SWUpdate mailing list and has bee=
n announced officially (https://swupdate.org/2021/06/14) but yes, we may ma=
rket that more prominently.
Nowadays, having all the infrastructure in SWUpdate itself, we may even pur=
sue upstreaming that to SWUpdate instead of maintaining it ourselves... On =
the other hand, we may as well advertise it in CIP more prominently?

Christian

--
Dr. Christian Storm
Siemens AG, Technology, T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3, 85748 Garching, Germany


--_000_F901FB53B3964FEA8BE94C4DFD907B0Fsiemenscom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <76BDDCC9E24F5F48A539B6B0ABF310D6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; line-br=
eak: after-white-space;">
<div><br>
<blockquote type=3D"cite">
<div>
<div>
<blockquote type=3D"cite">From what I experienced, outside of isar-cip-core=
, the software<br>
collection approach is much more common. There we have swupdate wrapper<br>
scripts, that figure out which software collection should be used, and<br>
call swupdate accordingly.<br>
</blockquote>
<br>
Right, and that additional, possibly ugly wrapping is what the pattern<br>
in isar-cip-core avoids: You just call &quot;swupdate -i my.swu&quot; (or<b=
r>
equivalent triggers), and everything works as it should.<br>
<br>
Christian, seems there is a gap in awareness for this option outside of<br>
the isar-cip-core universe.<br>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>Hm, it's well known to the readers of the SWUpdate mailing list and ha=
s been announced officially (<a href=3D"https://swupdate.org/2021/06/14">ht=
tps://swupdate.org/2021/06/14</a>) but yes, we may market that more promine=
ntly.</div>
<div>Nowadays, having all the infrastructure in SWUpdate itself, we may eve=
n pursue upstreaming that to SWUpdate instead of maintaining it ourselves..=
. On the other hand, we may as well advertise it in CIP more prominently?</=
div>
<div><br>
</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre"></span>Christ=
ian</div>
<div><br>
</div>
</div>
<div>
<div dir=3D"auto" style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none; overflow-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;">
<div dir=3D"auto" style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none; overflow-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;">
<div dir=3D"auto" style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none; overflow-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;">
<div>--&nbsp;<br>
Dr. Christian Storm<br>
Siemens AG, Technology, T CED OES-DE</div>
<div><span class=3D"ui-provider a b c d e f g h i j k l m n o p q r s t u v=
 w x y z ab ac ae af ag ah ai aj ak" dir=3D"ltr">Friedrich-Ludwig-Bauer-Str=
. 3,&nbsp;85748 Garching,<span class=3D"Apple-converted-space">&nbsp;</span=
>Germany</span><br>
</div>
</div>
</div>
</div>
</div>
<br>
</body>
</html>

--_000_F901FB53B3964FEA8BE94C4DFD907B0Fsiemenscom_--

