Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C44D5B170
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 09:46:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44806.1765791980821343670
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 01:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Xy5rRzjs;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyDtyCJsslsL6hoxq703/w7abdf1E9CQzy40DpuNoAxqVwwqkTRvNPSGwh7O4jGC+e49eAMh5NnYzEZ1IeiUHvQMsXqNiFb4kyGFj3evrYd+yEgogtvm6LFG6viVriEoX2Rm99gYuFycPDNmx1PNuoWHUjRBdityqHichtxPqAQs2FAgthGDzpDJ564wrMOzoCP+XMx9B5pcIQpzWH5EIPRX9yHi4kioy//W1iT+L6kCFsADAdQblTpAfSXxbN+/yAHKfVUjOpdUfSadYaTH7HsD24ycSQfsT/2RAzTbFPvFHZJV9qd7fzw1u98t6qveUfStmv7nLbwHWm0dNq57gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0TvX63JvMEkiaQYa+m12R6o9KAXoHRdDL2qVR/eVu0=;
 b=df+EdGCJU6NbOIv83neHL9YC8gNl7mYBZJGcX/sXmXXp7GjmVt5sGVej6hjEAM/Xjo6tqmmqiMRY3bGRChyl2eecqW4GvlwVSdlPmytca/9nOQTS0hBxtJuhU5b8q0oIas6r8lXdQtp1ieboUD7I6xdIGjBMBIWaIOAhz6MZhxGsPRAZ+ZciyWW469zP6r4fuRyEulE4wqI/XGdr11JANnqBzoGASQzZYeoC4pT/hV8NsYUmbM2Su/re//2JGjEYW8r2uo0wUb0BwMRPFMBsmHmL70Sf16c9dhBWKo4Ok0h4W8pn+QmtWtLHyfrJ46bV7LcG0gjJK4ldjDOqb5SDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0TvX63JvMEkiaQYa+m12R6o9KAXoHRdDL2qVR/eVu0=;
 b=Xy5rRzjsqmuwbPbKp9C47VacZMFCsUiVyvHiK55lOfAyThwX3LXCbSpGbV5kpMh3yP1cZlUvXNE3B4VbTizhBmbCRGG8PFL7OSbS2UimvEqK2zsILYkIdaSvGxRmTWcmraHJnvALn4GAeycnFtg6NrtWK1Ij8Wth+XBmV26aqVE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11729.jpnprd01.prod.outlook.com (2603:1096:604:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Mon, 15 Dec
 2025 09:46:18 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9434.001; Mon, 15 Dec 2025
 09:46:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Topic: [PATCH 6.1.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling
 mode
Thread-Index: AQHcbPKqd6YWWpsYAEmr3jyEfmHhrbUidWHw
Date: Mon, 15 Dec 2025 09:46:18 +0000
Message-ID: 
 <TY3PR01MB113460C1CEA306ADD597E18D486ADA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
 <20251214121034.4352-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251214121034.4352-3-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11729:EE_
x-ms-office365-filtering-correlation-id: f5a99dd3-a526-432b-bafd-08de3bbecbd7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?l+yZbiQMaxlCsVKAizo7RHiI5CW2xgD2+REEvTjfKMNzGt7ZbaLlgMJiAchd?=
 =?us-ascii?Q?NZhAGnO5YatrmkL+LKvIe0YCQA0PrsdrFGnu7FAKylTBP1Qe7yOU58BgT/D1?=
 =?us-ascii?Q?e7R4wOpd+9RWAoNK84ka2S+3GbWFEngdL6kmOPOmFwepClrx4tlNlgwGAYK9?=
 =?us-ascii?Q?5WvmF4O4KkUxh4AHmjF9kgM0A4Ang2vWDB5Jtv8ucDrA+Hj45Kk4ZAovce89?=
 =?us-ascii?Q?wQRVYRQVczlwK4RgoLG/ongYLp+ZAYH96X1EMpMw6NANs7jpqTkXiiyJIchB?=
 =?us-ascii?Q?MRwu8w1tCknxRMtRSsZZtmZRGrt6meQ5N+yajvXSx2EmwkgMle/MYsP1gKof?=
 =?us-ascii?Q?uWREKcNC+k+5qW5YZyIoCySKXr33Kf/1N5oVg0wnDXpxX2+8e6TvSJ0o4rSq?=
 =?us-ascii?Q?xYo85qBNVmr6DPT/MQE5JRr7GTmNUl64lAFn1YHoohuY+Hk0QuY2ymABbbCw?=
 =?us-ascii?Q?+Cyy9NU3ogy4VHPiFy39Y2pZi0Hb5tpw00JP7c07NG0OWxNXKp726Yj5s8U4?=
 =?us-ascii?Q?6GGZnO1TGGAsXnuifM84g6zxDK93S1M5HonQpqNPyNdo3MFzaVJKPoPYw6ph?=
 =?us-ascii?Q?du6KJkLfaXDqGFTlSJPc1dj82FbAQ3Uu+du0qmanuPvBhDp/fSH0JjHV6ZIc?=
 =?us-ascii?Q?oImAA4Y9sqW1Hb3u29KTf4MAcgohkDHewMNTruY+4loN6r+xhqdm9O1t+ANN?=
 =?us-ascii?Q?TB+hA6Y8QxbgWkAGuDUnNdEg7UXEmXCbjKqpQ/fTfOoZTkz6Cn4FvuK9q1cJ?=
 =?us-ascii?Q?3xkHOgwt+VJD39u8ZZ8DndBVEATO5PqqHShFhNLsyKWpYwvAJDnN8i1gxXlD?=
 =?us-ascii?Q?t9d6UPGKfIvyssXJugqDjoC46OHyb2a/rpfmpSYKtAd5Iiuy6C183DtyyjUT?=
 =?us-ascii?Q?KFO/epZovULgF6P8nb4xL6pewDcmqWEmyl9B9Cy7G1wozQWEbJkM7kNXczkt?=
 =?us-ascii?Q?vd/CecRzlYQf9nSRC8/GpvFRuNPK8CcvCd2yBTtnVPPs5VGbff5n6RFCJfDI?=
 =?us-ascii?Q?4hs3pkFfhu6LeQnwfwoFDqrY7qA8iNuKMyiSM3w/ZtTEI5qYtEQVBxijMpzJ?=
 =?us-ascii?Q?dYLvaHHrBFQJljvWpOR2q+/eqTiVenKl+D9NNoo2ILPRXKgPSyzjhgM5YHVW?=
 =?us-ascii?Q?jU8bMXmp2DED7VysnBv775Ky9xb1Q5WRS7V6ARuO44wuaK3g6xCvDpkuE1WG?=
 =?us-ascii?Q?pJk6sSLwHHN3m4EUSCfeLrmo88//eFn3rZHKMK9+aeL3AmJiNHt1D3N2qbsu?=
 =?us-ascii?Q?VNxheZOja1RoUz4MsorWlAKcyfjNjoOTkALhop7tfPzrrdIu3UfwYtJ8i84B?=
 =?us-ascii?Q?xoD8vmCJikQA7UDnL1/dHgNznWzAW48IcswUQLOw0ntRbGi71itsL7TZANEh?=
 =?us-ascii?Q?nWxuNKqYOBZMHd/ult1xTrWKYosfFzxkUPRy9D4NKIMnXKBh2dqBy2khr6mi?=
 =?us-ascii?Q?s4bMxkIziz2mLqItaf1XvWONe8L2ps3tgdvnmteV7+uvxiOMDBMqkqEeE5G5?=
 =?us-ascii?Q?fRndo5KdJFgdAG3yAj1176rVtY1El3TEyltv?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KdIK4/boHcq7HswAIstHh8W0xPo+KsP1zyv6w4cxlsM25TIOPbX77tqI4hDP?=
 =?us-ascii?Q?3tSieduyUM4YqiTTHRR8Mh0tVL78zcorPUI9gfjC3GKy3d4ytJoUhxj0OVJL?=
 =?us-ascii?Q?+3f4k7njWTig6/NfZ4UQRdUHbPcEVX7Bg5BH/NjWO68grsCq/ZTr/jqpzpnH?=
 =?us-ascii?Q?DHYD0CWqtIUgO8bi3Fazg5dcY9U/D/4DgLR+HZQTG3ZkgIkG4c+/iM30pOWv?=
 =?us-ascii?Q?oW9BVv+Drs4ze91kswXdkgFEgdvATUtWUtDaioSNifykLUOAN6YoknlfZ/qY?=
 =?us-ascii?Q?DE21urAAhvaUDM3D/jLUxL1BUnN/oCvjT3jVD/3B56SxrxWMpe110XnrQXfT?=
 =?us-ascii?Q?3Xm1wGDq89JPsSpb+SWy6f8liCqRF7mlPaO5ivdGD17LasRyxu04tpBwgw1Z?=
 =?us-ascii?Q?A1VUBJDOpOWf7nickyxPqhsFUFat1JbT2gtx7dT/3zn4UUggR/YNYpVG7121?=
 =?us-ascii?Q?R3L9fX6gaifISjh8b6ySE0ZAcMYmxX0UOl/VGUYYIqatxiPwRbahNiN5e5cI?=
 =?us-ascii?Q?hmh1JVRpQmIM8zbc0BHYLqVedAOogG42ioEL5WcPzgRlWXXv+EzyT+E6pS/r?=
 =?us-ascii?Q?poaTlQUyXxzRUIHrydp+JTgo6E0VyOzdotjarobhvZJntj5fVXtl4gi64E7x?=
 =?us-ascii?Q?5fUtGaQMd1EjzvvAkxCNQ5w/kgdtubqwQBBOlCYlT1bO9R5s1zmTiiT60V8a?=
 =?us-ascii?Q?p0Tr2tY/BibYLeFw94BPpWxufxz0mL3My87vVKviH6NMZ6VsQMq+IHGyL4RS?=
 =?us-ascii?Q?+ns1uRVl67392GS9F32QQD2tN8NdVPur1cQibuAnLyRuItbVG9s+oYEwF5A0?=
 =?us-ascii?Q?+G+ikM7xqw3TBRoVd8HEkEnP8A4D3i89Ub0heA1pwYt9XBzu+cLFIcJu+h5y?=
 =?us-ascii?Q?RW93n4yfnpq75pB50Ws/VSRKBBJFAZlPkIxNjIpyNGn0S2O7Z+ogYFnzJQBk?=
 =?us-ascii?Q?SOAi1pBeg7NjzG1oBHLmIftixguk2TG8l7HiVOPoCFfIpSFeudar5Qo0AGSO?=
 =?us-ascii?Q?8LGKFwxDETmg4UB79WujiRfH6gV0N9HqhLst6nAT/04XrMIImOv+EfXdxre9?=
 =?us-ascii?Q?0za+JjhjuEhNHJTfCXiS+xOnWeQFyApd6WPPH8fbQ5ndOSWxvR3psZK43QAw?=
 =?us-ascii?Q?Vou78X+D8qjfcDmi17KPd+LbDxnhVm3VqIXsBo+W0N95wnVPZVRGKfQ993BN?=
 =?us-ascii?Q?5hM5ztwsWW/ovjh+J5Ufo+uJuG3OzD9LVVl+FTwVwS5JvU/WAajI8qrcGtit?=
 =?us-ascii?Q?oaW6sX//HR0fxBaETQ13J+DpY2vwBQ7BbL+4JwgNju3TKE07JF/oAjrj07bf?=
 =?us-ascii?Q?F7Qzu9sV7KXPhDbCQztnDwG6R76tAeG/LFXCDI3TlTwNwPtW1LVFYZ5EmNzW?=
 =?us-ascii?Q?Votp3Aj0etdSdYQC5ClBiDsODCYNremkYiJ8c3x7gyPdPR5As9ew+BOY59sC?=
 =?us-ascii?Q?/5EpC1lPK4NsbkWQ92deiXhaycJDCRf14hSUHZVeYw9HfEbL1ESXp/oSw9pn?=
 =?us-ascii?Q?FPzpvnXeOKztqCURaqq5VcPZjY4ojRpXn2egyN4D3Bejye3JxwfOnLn+E21/?=
 =?us-ascii?Q?mgLjKsEeQmMHS57nAvt8MeBDqpKFBAZKaR2luEBd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a99dd3-a526-432b-bafd-08de3bbecbd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:46:18.2588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjhrW7w9YhtaFb0Wbi7kl5dNq3LsH46UxUzZOjkzwyWsI19L+qFylxyEDp6LufMTfyNWQibkPE6G/y4hhIw8ttkrCkDMdlzPTimgMJGEf3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 09:46:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21043

+cc=20
nobuhiro.iwamatsu.x90@mail.toshiba as Nobuhiro Iwamatsu <nobuhiro1.iwamatsu=
@toshiba.co.jp>
bouncing.

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 14 December 2025 12:11
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhak=
ar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 2/3] mmc: renesas_sdhi: Enable 64-bit polling m=
ode
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 709fe7aa5aaf8047b528561a0082db8a3a29010c ]
>=20
> Enable 64-bit polling mode for R-Car gen3 and RZ/G2L SoCs.
>=20
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://lore.kernel.org/r/20250730164618.233117-3-biju.das.jz@bp.re=
nesas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 56fa2bc7146d..6044e20ea36a 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -106,7 +106,8 @@ static const struct renesas_sdhi_of_data of_data_rza2=
 =3D {
>=20
>  static const struct renesas_sdhi_of_data of_data_rcar_gen3 =3D {
>  	.tmio_flags	=3D TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
> -			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
> +			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
> +			  TMIO_MMC_64BIT_DATA_PORT,
>  	.capabilities	=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>  	.capabilities2	=3D MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
> --
> 2.43.0


