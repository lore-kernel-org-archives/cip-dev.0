Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A38CCA5FCB
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:41 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8577.1790852735712503396
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 04:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PTdshAd6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF+0mUdQ/E70jDb2VQrhtnY0wvb/WFdQKu7ZVFN0iCLuXpzYu9eERJ8g4XpEwPGbCMfRFKxrucv/wSAENgbs2LfiwqXIIIMbVVSccwcVU2N8dLKxM53iHWIe09oahIJJDB4olDzqgRHjvvs+Y3CNj1YwfsO71ax9lRdQ6jqNI+V+3OZ3dLXv6WFFi6Vd4V84zRXpW9Emzn32P1CpjMjGOOREt6cEi5Vqmosudmkhp0Q/sqaDXoqnA2kbodCbKtcuIg8EvZXICdrbZBKOTZgYKuokLBj0wvP1RYpy90cY8WeKSx56OuP9zwW2wO4Wq38L+hgZAOBZfzswsivGVVtyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITe258s1H1rt6l+juiXS4ZvW8DqL8q1PZ07nRLyG7EY=;
 b=b9wgHlm+zISaDrGDpHx4/pI4OjBQHT47Ex3zYdynBXmb/Ob5u+9sTCnmSeav0h0TftXcvTD8egy2yjUOAMc+ms+yw6xonhmcFD20pVme6mtbYp9QhnEerzDJhAjc6d7yd65IpChWuWZxSyqHidOl6ZWucG9vEL82rXmH2Jxuy13/1KQGPuxdFnXAV9OLU0/yewQ2I8xeCIe+c9s8DOtRvk7OmiwFm7qskxo5dyFjuFM9y7in6Fq9o1+Zk7d2MUs2UWg7mVwsUNJkNb2rEnoMXlxRQ0+/qr8XAKNFNGBpfQKCL/7I8X9ClOvfF2zablb2hl8Wqzhv5J/peudil6+0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITe258s1H1rt6l+juiXS4ZvW8DqL8q1PZ07nRLyG7EY=;
 b=PTdshAd61qFY2J4nNrqTaMsOQjEGi8Gb7SjJAaX03PEuWH+i65OeEJO8iXIZaaFXesyW1Vfe5lmYRh6h4Dv6EQ0nww8gv3+VxoPZKp+5+V8l0F/lfDFylu478r0OEhrk7VWs5+6ueksuf1ZcrMup91LDHgr/oqMVpSY9E8fZgLo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB18421.jpnprd01.prod.outlook.com (2603:1096:604:4a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 11:05:30 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 11:05:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro.iwamatsu.x90@mail.toshiba>, Pavel Machek <pavel@nabladev.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Index: AQHdTAehex3U4PayT0iyxysdE3WCZbbokUww
Date: Thu, 1 Oct 2026 11:05:30 +0000
Message-ID: 
 <TY3PR01MB113465D5BE3E3F4DA59396432868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <18D837EDDA8014EF.2416057@lists.cip-project.org>
In-Reply-To: <18D837EDDA8014EF.2416057@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB18421:EE_
x-ms-office365-filtering-correlation-id: 1485bfd2-d209-4f8d-f27e-08df1fabe826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|56012099006|10067099003|11063799006;
x-microsoft-antispam-message-info: 
 Zk6m+PPOWjy34h+c2JD+pObnYEPTmReSLFq5g7IrASxl1QAuI4u2zoe8XpoRpXR5jZquVHJ6MyNRL6lPA4w3S7Z20isb9iqAABqx8jcdhpzhi/VZ1dZDBVLt9scRyzQeCXkocPNSpzUWD59YWTE8oTbUS9Z2pD0+SYxeQuL7oaARQHaw9AWP74bwDr5YTMr0AfNBhSsNYJnWMGR6UA9A+9PN4vO4kGMVRn/4+ihSA1mk6PcHC05wc17ROuUbtjX8Ut27tkYNLB71//gTPbyOynsBxGS8R79C1P6bLcE2INQo0tNUV6SxbPgrmysSV8UfPQSlfIugipEpAA5ybL7tXKDd5WtPGgcEBL9GWVHMZTeHbSBWcTyHuIyRHPagltMyg11Bnrw3fO09NBX6Jo4rDhmqjl0+iNdy9YOe7A4+e6pFVc3ZwY2l9Bi6o67b4Cj3V5LuSXGlgQjlQ5zpkmtmWSi+IBTLp4kuY5e/Ejji9PPdC3NWGWRkw9P/ymAytxalXeWi4YyEqHeSXcxJrfCF0XgUlNW7B1b6OYlSj8tMwdCbp3TLn/8nlsbEpARqBQq3OTU/f9qx1K9iGZnBZCT8yy3TpJgsTr9iDUurVc1jLCyAgoFUUL4pzHSkijl+MWG6nv+IObGPcvz0eMdu1qS7QQ+LxHY2MkMclg2ikhwaVhfDcEuCNey16ElxJV/gmsq5Obdrb0/v1ROIxMWAHWoGs2maSXWgazXj5vNIWykhnqg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6lkeaPg4gE3WSDM0vCQ0hc4kkG2aQtl0GDhmMTW9Kp2mvIMlIo5JHsQSrodD?=
 =?us-ascii?Q?S6+zsBhbwWm7Yc/80kg34147XhRmYOXitgLA1OPZowREsErmNQuROj2GduPK?=
 =?us-ascii?Q?SQuoC2frAOwtPzcPYVyWWXElmnz1VOm/MMromZaKEIsevaY0FTAof/qLOyBc?=
 =?us-ascii?Q?w7J87hhm+zMB7IfdGELD72nByal0eTJSLCfuTuCnaVHJPrY6Yrcf3ccQ18WC?=
 =?us-ascii?Q?jc4tkfqb9vhDq3mdpkHAZCfKAAYgGV9Z/ZqeRwyZvYqn5QswzvaM2eCt8Hxy?=
 =?us-ascii?Q?k8nLmSF03mMrPN9+I3dy0cWOA3P+2FN6NY9aKA/urxIXgn47JHn/tb/A52kI?=
 =?us-ascii?Q?wrNr354XV7aSLoPly9MuNqYm2wK1rpYODAStqYTFL1dkbyE/yhjaV0kN3C2S?=
 =?us-ascii?Q?igKaWVxJ/9NyEubZd7XEHh5GdDIeijg9dLBsJO90UY0cIBX5CBJojBeqe4cw?=
 =?us-ascii?Q?CfRBq7bEwkGb1n7/ZCasFIwR3xnuPL4HESuBO8CjDTQByWhr/7JxBa0ZrxF6?=
 =?us-ascii?Q?tXIoE46YSVRPj0q4aeqKzSXn91/MLXf1gS0FdqbMn4gSMFblxPU4l568up6H?=
 =?us-ascii?Q?zZQ/IeJM14ckrovLPz7GlsL2CwzfaUAehg3fpt+l6LWwJpNIcOmaqRq7Lhc4?=
 =?us-ascii?Q?Is5LV+BphT3waCxnDuRfNzsKpa502SaqV9dGJsC0Z9lPeG4MrBejbub1nB57?=
 =?us-ascii?Q?TEsAHU0J5i4Kg3jBDyvKHkZH+nTTbnBS4IdS0JxGaKVZYmTkmN9svmTeFmO7?=
 =?us-ascii?Q?faJ60HczhD+PCPmjHCXL+14bPyv4W2Hym2Vsdy0h851ED953yFs92DqYKZO1?=
 =?us-ascii?Q?1uNsMXVRinObNZM/WUZzryzdSc1zqos06UdoFyQhBHFd9BrhLhTdtehyN4MU?=
 =?us-ascii?Q?rp/PGwUrLqLP9ZVfLFlVEAPrMZqX/M5//qGiwPtmEM6cz3kDHgPI/5JKcMpL?=
 =?us-ascii?Q?12n0FINZYMt4TrqzPfhPlR2KsXClhX1t99w4VbjSxv+5zE/wLFXd1xe/1zQ7?=
 =?us-ascii?Q?DWYFe8GrQnB7iRSnCFFWvS7LJoQtKiV7YOQCS6aFy6VPozdjP7sY1Tq9KtdL?=
 =?us-ascii?Q?0A2SoHOntHOHItXECb7CvkVzBW5kvOwC3MyDhSOUTvwWdT3tks9kN2jlF1kF?=
 =?us-ascii?Q?y7090YBeBjoc4PVk+AbN6kSCORo+oKjzvDMmPYH9oFcki+m8q3w3oQVj2E8p?=
 =?us-ascii?Q?SBUL2eR4VAs/eBKPvdw9mFp6jJY7/VkEtty15btwvXXcwex6/4NpiKE5Zvhl?=
 =?us-ascii?Q?V/BLKn93DoaWML/dw2zqx9dfp/x3BmXdKLfOhoxMtkV02Ps45CSHz1XSc0hZ?=
 =?us-ascii?Q?N3lpGeoj1nG+6mHK20tiTHZKKtILErkyykb+xXW7ZLM7ilCjLQC9JWn9t6aU?=
 =?us-ascii?Q?O1zPswFUF35z4xoC1HO3IgCbspWPhlmWuH2qgE6D4AH8heuAYY8cnDGTWI0u?=
 =?us-ascii?Q?kmvn60Ot0tVtmIZJx9quSmuzxbaKZJ8VuxRAhN7SwEaNawnWNAjxYDJvO2uf?=
 =?us-ascii?Q?y1dd3f/sUUB+V+D4eDI1sc0C+E8kXJIEV4xb9C86M5sZMpRP8+sedR8WpH5n?=
 =?us-ascii?Q?Hh0WBr5w6RWhMY/3qr66Btcgh+wB/yxj2nR6x+/0Cnr6hfzTrHalok7gT1FV?=
 =?us-ascii?Q?PxJ+mDRWUMKKwUgUnINhoRsW1ZJ4keDg09+P4WpLY4YZzxL9JeOSTt40c+9Y?=
 =?us-ascii?Q?P/nlkYsSV7mPPt10r78oZjpZmKBxIO4017tQPI6Wzw0tJanL1JcNVMxb6dmu?=
 =?us-ascii?Q?vzbCPfj2jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485bfd2-d209-4f8d-f27e-08df1fabe826
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 11:05:30.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2tm8985znes3NNcYV678AqTDVWSnxKRVTavjkCKR3VmqRIVtasd9cfREbCfqBa/D43bppBZacJTJPEYq5bbUpbXxLRHeV6wbPw34Bp4Ctc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18421
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 11:05:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24396

Hi All,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Biju Das via lists.cip-
> project.org
> Sent: 24 September 2026 10:32
> Subject: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
>=20
> Add Renesas RZ/G3L RSPI support. All the patches in this series are cherr=
y-picked from mainline.
>=20
> Biju Das (3):
>   spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
>   arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
>   arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2
>=20
>  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 ++++++++
>  arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 69 +++++++++++++++++++
>  .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 19 +++++
>  3 files changed, 117 insertions(+)
>=20
> --
> 2.43.0

Gentle ping.

Cheers,
Biju


