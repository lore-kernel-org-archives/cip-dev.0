Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A0E9A772
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 11:25:06 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17238.1774351503487215623
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 04:25:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=m3gDb1ZR;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.61, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5w8+57IuvEAFJOm/z2z5ix4eVy7Tm5DApumjMyy6XJs7dNUmM7TW+1AHgT782Ah/jPztl6uxYPZFsyK9GAs3HlNXL5s3zyHCTFdbhQXJf4uJ7wkQvcIu8HedwQjYVCJgXw5EJv3KqdjvPM/BzXQOsGOfFoitdK2Kc7D371oe3hRAGjb5x0dJuuUaaxp8mEQjC2FMH0pmNW7rNvQLEzW+WB/YKC6F2NMiTMtELslkzZQMH7dBW9wOJBOgKsbLAW2VYVOKhB2fHOEwZl1T3powc8THb/db/JOh93uW0FIqjBYk4cEENUk7NAsQS2Q7BXcytrJ0CBP7lS9w7R1EPNKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xua5zS8tUHY3ij/to2pfQq9rPjErwRXf1azk6KLtEo=;
 b=QmQVk9JmTg4ZXO4g0ceaHMLTAxi3NZEpN/W1h56JY8h1PPIuabXittsLvvlTrBUTLqfFKA6DVroGuAT0LnTbXahqQWvbj+wh3JnY1X+MbMH5ka5po+POXKT6iyEn98IXEdUT+VYcanxYYiuLFoKNN7jcgLULvTalhYdwY405g9bBMIJjMfmDyw+nXzvCJsBX8gpP1ge0xuc0shxnMOukhiRhugCl3EOrtfCnZHh7v6DTWbDkSaRQXCugvcrUrBK0o16WKfeqJa12kP9qbtPSm+4aj8eCfw/Ubq+oFp9x/GvFP/qYmzaknGs7huJoj4m9YlIySdwOGN8KnjWj0sc8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xua5zS8tUHY3ij/to2pfQq9rPjErwRXf1azk6KLtEo=;
 b=m3gDb1ZRZS3ZJNn9HzBfR8/VdINy7ZXcg54ag40J9Bb5IIXcA6W5y69GaRQ0gsZ4yT9ww8HSOLDhub3C/YS7kkkp+8KdFspYyqX0eJrcw7iTlEeMnY/VILJJK5DFifo5wpylLVlPTaqeI/KFeiTROT4aPo6mqXoZKKOCWqeXAg4=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TY4PR01MB13994.jpnprd01.prod.outlook.com (2603:1096:405:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:24:43 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:25:00 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Thread-Topic: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Thread-Index: AQHcu28jZkgJSp33RUOXx8VrS8KP3bW9irBw
Date: Tue, 24 Mar 2026 11:25:00 +0000
Message-ID: 
 <OSCPR01MB143151900A3759DC135DDA311AA48A@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJW1TpVAGmB1CC6@duo.ucw.cz>
In-Reply-To: <acJW1TpVAGmB1CC6@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TY4PR01MB13994:EE_
x-ms-office365-filtering-correlation-id: 507bdce5-a2fe-452e-4379-08de8997fccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 YJGLfU2cS46xxCSFQ2YIPamlNM/Oy95QQH/UyBpazTM3m1vA8k2PVdXhh78ieJ//Krm+gtwe6UXC3cMvu/528dwgvemt0RlnxjG00KTEseXw03u8G28v208pyehQBMrswBO2HS/TDkD8ixBxX1RqY4xW8SZaG7dJyBG0K7JyTkbD7i+2BwxpZ/XRyxh9xY+W2MVZD7HV/JV+Et9PHJ22hlAf1rNn9F7dBb3LpTT+LheGOAMp9dFBN9br+keMuq2MltUIqspt/otQ0P56MyD57MVWPGqAv5X+B6YqjCsiHiOucQoA95/nqlalJoBbNcQNPtl9LGFpgEMCRljZT53tAjpMj8+O345dnUCZLn/OOuzjW1lwdaeS6ENmzlbvjaxeFjrNS8EqDFWk2pE3AQ4GYJq4tsr2xZxSF5uSXgJjSxU18J6jJziRTpHz5wF+iJv5rQRdjOcFS5obU8ZiHJd5hO8+Xl4JGldTy5rkBP/BOz2EDLrWs45IvsaDAev0So4EIUO1BzPp2WtY5UbEu2WNzNYXi1ROt+9dw8cCSG1RwUAv26pDvFYgRA56ZQklhHOKSlwzUW7gecMFi2Sl+LIIvtBsk2udjCzFgUgWYy0YHnwFI6Opt6HUpfl4rwHNroCyw6kBCNlc0j3bviVxLKRT7axMSsrUArMMbyeUPW1sjv5vKgKkEuSaKSQub3Tz2t/hSzWY0Imc3bKsEEndz4vr5ohJkR7YHDh7kZKoBgV5zaiTvjYIvSXmZESU+owKe9tpW/dWYJGbURshLjbCpBhEgJuBKjvhzeu4n7XIpzVkMt0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jyclRHjQ0FR9OuhuID8k+CjfG1K00F8+Eofb8eWL13h5eoLeFRT4r+tjsOMS?=
 =?us-ascii?Q?ryi0TTpJjh88it6FPbWWv/2lNco6r+651kCgaVBBIUQACSnlFi4PwQbxZleF?=
 =?us-ascii?Q?cIkrkm2QnElEAw/MZbUGWBKHgxoR5jlkuaAOQXwihNT5L1mrM02P72HFB9az?=
 =?us-ascii?Q?3ocG+7dKKz3fR5hlEFgWIWAh1gyV021RQ4qVa+ICM83jklIuw5VpNjZBrRG+?=
 =?us-ascii?Q?TZ9PWm91r2kgHFDy9KVbn2bqaaNUzzNgNrBXBxYu+v3Uw9gBwBaMkmEYi/Fe?=
 =?us-ascii?Q?WN79C/JAvp6ye84kzH6T7j5mXyiXdPDCNPjXNCK6jL7HLCha6r+Os4ueUC7D?=
 =?us-ascii?Q?2bP8f20M3N4Gp7UlPywcRlMcuJVtxvbxgjHeZQA1HaZyvs2xKHVO902h4kFe?=
 =?us-ascii?Q?PeD71r32O2Oomz+EFaUHyj7/R64NLHsTB3buJlPuc/tbCibj9vTTZE2wb8QB?=
 =?us-ascii?Q?XpCodcmsbph0pERYJl0o8gmElyP2mk1mVntDm+VCFFX7Mt4h0YvZHvcYZBxn?=
 =?us-ascii?Q?B0eeWKPFH27DtBaoOWIB9Rw1OvQ/8HqzORQJVPCKd8HhH7gGgrW9fvigqm43?=
 =?us-ascii?Q?Lm4Np2+UGYGVcT8mCKnaAaXH0EsB8yVP7yoYtBs40e2/+FziM2Dwwrs8FfJo?=
 =?us-ascii?Q?P1wApZnzeRbqNVm50fprNqJ3cEaoSgemMJz7MGXTluUNoar73UvPbeN6L566?=
 =?us-ascii?Q?qjSSAbbCBiIg+MNsPAUznfTEv/kTx3lZAcn/5YmwQ6YQ/WlM0eM3LcZhL7St?=
 =?us-ascii?Q?CtXUcRzpILS4YsqFvRBw/hpK6l5Lx+f4U5QxrwJxqP7T38wYQvF9/r5KxCwQ?=
 =?us-ascii?Q?rlOtCl9d97782XP0PK/zTsvS+alJEnDRfcgaBwffL1GLp/RHI0dPyeKD4q5U?=
 =?us-ascii?Q?4MQjPpjWxhuWxipHVA3KhkkVhqkcWI76NZ1WO7VY021QPS9ETYHu+PRGkfEU?=
 =?us-ascii?Q?9HtJRsNecZo0Z08w+72SUOXg6ozopDH6vu4NWlQ2FuSjb99ZPwexSIFSNSgy?=
 =?us-ascii?Q?HyUE0ahQpETHfG+4kIhndoM4n5OkmjsDpPZgkUfxKyrGKO2HLaEwO+1Btt6y?=
 =?us-ascii?Q?KgS84SPaVfaN7OTqVmsBV+ectAGgP4oc4GmDRPLLFQsaQsCDb908IH/6oNr3?=
 =?us-ascii?Q?RqAQoLMYL1y+Lw/HOBcDGKDDB0RT6tVhPaQw4V4sH9ODjkcLyNeFy1l+KC9l?=
 =?us-ascii?Q?7gIAWoqriaRhjmNNT07kbnYzn8OgHdw3gjbb6CxdqKbuTYA2FBmdyA3q8kLZ?=
 =?us-ascii?Q?5eMe1wDY+4MKB6Ale12RzBG63qqd50DpcmhM1Xqsm3NT61kb4D906CzyBuQH?=
 =?us-ascii?Q?8nmuTYWsGmaHh2gCFPvR+YEcq3UY69hJP5v4ayszD7d3LNmn6iCASjPp2i5Y?=
 =?us-ascii?Q?M5DDvPyJvprVqVxG0a/7cNETxDrkQ0UD08JE5WqsrfRmJjF+Tn3aB0cZj0gC?=
 =?us-ascii?Q?lYFV72MdJLhOp7adIiWVHlWl2Fzr60xTMeM+iYcKUn3+LTplvJUBjnF5Jr0X?=
 =?us-ascii?Q?ebci0PUNSzmKfGnedpz2B+J/7W3xOAD0uYW87NpVZmMxXgR9TF2gpUHfTXzF?=
 =?us-ascii?Q?ZL5StasdcH79d3jbPRdFWeruWlJ5m7djboLkL1SHpDWiqFT/JeXRM8+BFTNE?=
 =?us-ascii?Q?fAm6jFkDoEl13MBTWMNTHpg44lXaQmuv4CNOu4IBYxY6wxykZh+kFGq+CiLP?=
 =?us-ascii?Q?5y1Iq+1geEfognQ+DmvJ2lzmkZBjz1cM/UoCunnaKvwDS6bCNJ6QgE6EdNm6?=
 =?us-ascii?Q?DhJhfK4s92k8i1JOQUnCN6kWg9sTUi/h9W1mzHy4GUGXoGtpgdDU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507bdce5-a2fe-452e-4379-08de8997fccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:25:00.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lUPKnctevkeNbiYRQibRM7yLgXgtvVTuz8pxAysQCS5Ait/eLP6IIcMCw5COkiCjVMkFm2HRSwbApdDK6/z6pmUuIn2ICq+fGhGUd7fuGxTmexIRs3mGaJ1NXBx3Hzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13994
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 11:25:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22549

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 24 March 2026 09:18
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth:
> Add support for RZ/T2H SoC
>=20
> Hi!
>=20
>=20
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > @@ -33,6 +34,7 @@
> >   *                handled by the glue driver or core driver.
> >   * @set_clk_tx_rate: Flag to indicate if Tx clock is fixed or
> >   *                   set_clk_tx_rate is needed.
> > + * @has_pcs: Flag to indicate if the MAC has a PCS
>=20
> "." at the end of sentence would be consistent with the rest (but yes,
> that's really nitpicking).
>=20
Agreed.

Cheers,
Prabhakar

