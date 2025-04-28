Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04526C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 08:43:28 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.web11.43308.1745829797319345313
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 01:43:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bOFd2h+Z;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUsqfOb1QHNVXOqWDFdii+C0HLjwYSiKpRcBSJrokRILE6CzI8rWHndGowDk4RPHF2MJASRAnjYzQAlJn8PN+7pIqZ4oMeAt2Mi5aYAYAu7pLHGxR6WBXh5OuSCc7hVzvSaamNS6zt/ov9Tb47q5dKYHzfnyueQytqlcjVTmxnbb2ww2uA63+zji7fQIksvFuPuctG7H8xuk1r4Xg11+XuF+nkLYD0Xxn6C/cM1xySTppD84dz8AfOcaq0diJr3GKpZm12fTQCdKNHdRwkF0U3l/Xz5N4g/ZDKzGOybPalgXBMKOMHwjMWQ0s4pQK122xJIg+J4V+/VQerlFVaUr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVC1xpNlCfrhtH2nwZlI6i/l4MvY9QJ42H5t3tA4u/A=;
 b=ASyTfgnfLXfuekJVcFCAhU0XaqjP7g44Qjd4aA46BwRmfBbthn6CtsjuKnIJnDdNxPiq906zd6GZFL4K8dYyIdMfRSNYtFpQvZRgczsc/5NlH3GwiAOz6Tyh0+EU5dcpRQy/5msXPmKMuZeRprjKbhI96mjotB5qaV5cmSohl2Z7FWJJpmRkKJ6Lx2DYDWz+Lw/pCScj/edf24ljqi6HrUUkWa7r+yzmw8xwxk/rWhVgp1LkOKrjqlqggBLjZaLeNiczH7toMhAUa2kNX9YJOTJRpeQoavkAd68YpwKCEXl4vJkdp+yBXF0vHX1jexBZQHuDy6n1AO5fzRp1isth1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVC1xpNlCfrhtH2nwZlI6i/l4MvY9QJ42H5t3tA4u/A=;
 b=bOFd2h+Z0rzouZ/Jnko+m44D2pf3isnAE3DG9B13hnc06gvNPNVtY6gMW8VNbD09jVRV2vpscRmkAT2i5/HQ4D9GHKoAJhQ0smcojQLCI1XE3OnDwev+Jh6AWMJg2xVazqCsH/ywwYCtHdT4QsCLqUtCbjUXcbAHO46N4GAG7+o=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSCPR01MB14983.jpnprd01.prod.outlook.com (2603:1096:604:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 08:43:07 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:43:07 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 08/16] arm64: dts: renesas: Add
 initial DTS for RZ/V2H EVK board
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 08/16] arm64: dts: renesas: Add
 initial DTS for RZ/V2H EVK board
Thread-Index: AQHbuAT9xR8B2bsPS0+uP5kZWUbSjbO4wnZw
Date: Mon, 28 Apr 2025 08:43:06 +0000
Message-ID: 
 <OSZPR01MB70195825F892D6A43E9A86B4AA812@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250427191548.130118-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aA8dFw5ZUz5KMd/I@duo.ucw.cz>
In-Reply-To: <aA8dFw5ZUz5KMd/I@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSCPR01MB14983:EE_
x-ms-office365-filtering-correlation-id: a63e704f-b87b-4ffd-efc7-08dd8630b29c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?14aM+8ypoensVN2c7O05MBB4PHr6YZ2cG8/1pEOKSqqkxpVA2Ao38gRsfRYC?=
 =?us-ascii?Q?jSF3EmPHGogpNYvnLujBfenuEun+Q/i1OBU8c3Os8ReOiP9kr2F5ttbwwwpr?=
 =?us-ascii?Q?I0lcEW0TwWIZzGKTkbfUZTIsDWvlWaL9oHzVisw5r5ju3olMgFmGQwO2nP6C?=
 =?us-ascii?Q?QWRVi3jaR6Gq1hyuHB+qPJDkbnVZ17KRBevfPMJlqVf1XEUpi1EPpvDXbWNu?=
 =?us-ascii?Q?YjSiBC7Nz+713R2YkNOrpqoc6ypc4DoN3UegHK7jQMYlh5hO6XpKKHr+o1kc?=
 =?us-ascii?Q?F+sI694EDkf89TiyrLsKDlWxb+80G87Y8sJ7g698U5Vr0CATWJqg9v1LDQop?=
 =?us-ascii?Q?OikyQOD5a13qdrTpbAdv72ARrlWSnAVzsO6BqbU2a7kjU/4JMEdap7smqO2O?=
 =?us-ascii?Q?mg2YNxpG4NzmjdDTn2NFjlNpFEi4ZcHjMULdWpSwH4DOpaCSbDs38FyeKOeT?=
 =?us-ascii?Q?Eh3v8IQSTwEZIlFcMkCIMUf8LX6eWdOWkDihYR7y9SYUV5uWs+f30R38aGbI?=
 =?us-ascii?Q?mVvjMBYIMQLnKVvPNZVnRHH9MbaReChV9aCBAacpMS+A1Ez9QKB/4+9jTitL?=
 =?us-ascii?Q?zO9TzbaPu4PhVLluCjtPxWW/1mhCZmKR4RqShg44gRBFdslE0o8zqmn6CmgZ?=
 =?us-ascii?Q?V8U9Hz+qLWfWVCOqG8bxQUsZUr7gk+JBBSMMAFoPI2mL9FtsaHedyjgvGGp9?=
 =?us-ascii?Q?ZXnFL+eAmja+PCzwHrs480bPyeat4tiv7iWO7Cv7wge1XnMXaDUb8kmnejfd?=
 =?us-ascii?Q?Bo9qAJfoo7dMs//bMYdyJKzngkfTUTQeUyxqqh/fIVRuq3J3KU1WCy3CDb+2?=
 =?us-ascii?Q?Pf33TUrXGygyhy+8hDq7vbdGGFSgC35h8CXIifxTdOZkP1ytCOqfi1cdyRHW?=
 =?us-ascii?Q?ENnr8HiM91U6AUVb1Ty2uHa1PoFdqSkVWc5U00iGds88TWf+VD6lqZ7uMkex?=
 =?us-ascii?Q?Ag4lqHS8AOch/zy9+BtcYuVzYhpU7TU7bVZwr3ntO/kB+EuitH+j9yU05DEi?=
 =?us-ascii?Q?EBEXvXzoQbrK9GS6TekYnW1p3ZDy8Cy0l+9+iuWxp8nGImrz2UXXT66xyJCS?=
 =?us-ascii?Q?5AeT+eNlrcUIFh7b6JW0cwo+QdN6Chc+sT4inwl3425qfwyqjRvCVGVuQbJk?=
 =?us-ascii?Q?BMkrolxJZT+S9z1MEOY2ziAvOjriNWHLVxweNMMzddLPskW2QUGtJoendT6W?=
 =?us-ascii?Q?rMZXBlap+/2ueTldcg62nvW1q8roMSNAU1RKgntvN0d4is41Rj1x2gJLpnIQ?=
 =?us-ascii?Q?HiSgMrsbzmtIq/pq7usCbJ6GJ8PZk0Xn+rTGtARHTqkhDWZ3DUcHCQuIik52?=
 =?us-ascii?Q?5IzHqLD7M3fubFvlCcQXSUrwJo6/DiWy09Cd4A2kz8TOhufRLYVNFnRqwG7V?=
 =?us-ascii?Q?Mpw1hLJUz+ZPlzLVS0iwVJ5uiE9JU760nXQzs87aSnf9IpbRk7tOwPvg/th9?=
 =?us-ascii?Q?GOZLFVVmYYsvNHBlabVWiPUuwpb8af+KG+7kLPL5MoBqo+h1/yBxSMu0GQUR?=
 =?us-ascii?Q?pNyGnPe2nKU8sBM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?xiBWIaGqTzNGAokAxci2/OKahZVrOku9C6ztIlFgY9rzF4iXAJNcGfGNYCUg?=
 =?us-ascii?Q?xORHCl12edfvIOTHS37DRgYCCFgQoyx0URJqjaBq5Xx16xMv/rf1zClv1BYG?=
 =?us-ascii?Q?tRZdj0X/BpgAKZ37/orPXDNc32XZ43luULKg6pT+f1rxxR34yD9/RcdizbnH?=
 =?us-ascii?Q?JT0utB1AERnrbYWBHG9DXHTz9Ev00LJKjwgkIxs7+Wu12TP7safnJe7IcKTg?=
 =?us-ascii?Q?6pblyM1caUuut9b7hLpZcM+1sjUJ7dEZ26cPySTallbd6woovRa4jJUMIbD+?=
 =?us-ascii?Q?NWRpe6uh8Vk6mwONQ9x1PEkoRWZgB6psK+YyjZBVDoBpxyfsM9nkvSrmiuEH?=
 =?us-ascii?Q?V3StJ4lbZEt9QnGTUU5o8iNNWadm1UDiYav0hyg96BiALySq+zA/Pg2DWtuG?=
 =?us-ascii?Q?3jBuH3vZAUCKznS/TEHTYBfxYAN9Fc+vEf66dZqVD5ZQMPtWtMf3n2k8rp1u?=
 =?us-ascii?Q?siT+Q4UU8ZtQdap1vWEhXmSEAIXUytpjm6puMvKEbP+TVBAg4/dundMZVC7+?=
 =?us-ascii?Q?OmMcNfJ//KUStNRQazmd7L/hgmrwuHmvWCqm4/Lic08Lcy4+S0JxwHZorcIs?=
 =?us-ascii?Q?jGH+lWLwxjmlctyoP6lCbLkm4mNSHgSFfLzSPSQmCzGTxnzbfohEqTdK/LhN?=
 =?us-ascii?Q?9fg6tsoFj+dD55E6K1forXacfbH3bae/6E0ttrBRJTQB4p5OCOhrEgTRxyUv?=
 =?us-ascii?Q?+buZlbgTZSgGRD7/PPW6Oxg6pEo9NkuMu8SkL53axLWxd2k5N/Oc2QIGbrxg?=
 =?us-ascii?Q?+4lSfbUGW6DHwwfD6lUbMHCRmlq0FdyKwBygPH3DtoA0ZS9mJeyAU1+KS4AY?=
 =?us-ascii?Q?SseFhlu4SBwdPd7cTX5Y/R9goTvdvDJWYSgErqlt77ZR/b+4C85qZ0lt+6ol?=
 =?us-ascii?Q?6Pc6XjxSBb1Htf3zB/AaryvjOooD7q6DScmn7v2L5WirmHp9W90pNZpj31Jm?=
 =?us-ascii?Q?SPSpzuS0MxpoH1H/uo348+yvk8duLQodGYD2Tc8JWiRFzYaEpeIZVsX+LaHa?=
 =?us-ascii?Q?WlKdVOgzTeh6F9UpWN4/Deutb3fLgPiPt7QflqyJ87sUqG5f0s6hpbXcxQpJ?=
 =?us-ascii?Q?crYYyIX2DwegqPTmJiKQrlt3fjxeIalZIKMSfUpteVfvEcvr9SR2H+V2cD+r?=
 =?us-ascii?Q?tLN4Q2gtLfN2/YJijdHKKC2k3vyUawyQ+7ts7xDNVxj8WvX5lGL2u/F70kjX?=
 =?us-ascii?Q?vwLD0RgvaI0eqwWyYsllwcb61CRW7l6wLqcOqEAsAdfVOkDlnIyTDxAGlrR0?=
 =?us-ascii?Q?zY8o/iAYvuJO0F15k7QNodGNlo2UvUhLtBgFpexYaKTvtQD013CoKtCeAFl2?=
 =?us-ascii?Q?UaG6yqbVqwlmWuqnWhE3K5Ep558UQ5yYHM+9fI1eOA/hKduntM9HrD6kRs83?=
 =?us-ascii?Q?Lg5x0cMuA2vAOfX8PED30jhEfjrT7tN30eg5EvtEPQmv9MbfKxzQbWcTJmGm?=
 =?us-ascii?Q?tfGe86UqMdFzQnntHeSNFluo0Mgvmhyjmn/LXtGETgSVKSaDme5IEBUvUkkw?=
 =?us-ascii?Q?enwOCTguwUnacMcrhKncSSb+CPHzbL9/ef8pbE9TpEB2QR6OA26PzJNrJzlQ?=
 =?us-ascii?Q?yvBYdHdpMcSg/F+4ZMNHT0aQYvYEu8guLYjXPHn75kIkMCra/ZzrZKufaBEc?=
 =?us-ascii?Q?J0pm/7tbbcPsyln1z3IlPnQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63e704f-b87b-4ffd-efc7-08dd8630b29c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:43:06.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2GJ7Ck5O0nb7cxcCmF9j1vJMXsuUbypviy/Lfw/vqrynxyQYmd74M19zeQ+2C5YVutqyGyIg++Y2dllv6bbvhb3IVm8r2L+YyY78nbeqjKqJo0JJdmZ/w0Yq6dBVUU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14983
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 08:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18691

Hi Pavel,

Thank you for the review.

> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 08/16] arm64: dts: renesas: Add
> initial DTS for RZ/V2H EVK board
>=20
> Hi!
>=20
>=20
> > +	chosen {
> > +		bootargs =3D "ignore_loglevel";
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
>=20
> Having bootarg that affects policy such as "ignore_loglevel" is quite
> strange. Why is it specifically needed on this board?
>=20
Nothing specific for this board. I followed the same approach as done for t=
he
Other platforms which are added recently.

Cheers,
Prabhakar

