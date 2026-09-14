Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B37C88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:05:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13991.1789365940237416607
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=GES4IDAs;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789365938;x=1790575538;bh=AscoE2zcsTV4FkrnMzYAtYcUHta2r0aqx2PSu
	6bHFdk=;b=GES4IDAsRLMbDTbH5j5j5YB6krLtRTSJCJRdtuahWislTEEMaBdAKkkFOv3cBIggLFB
	q1m/5IUu9fDxPm7w+4vfvIF5z7gEvgcPVjtn7nr+4vj1soHk75vTah+tNdcSvqxDDOEVLCODDxG21
	hpCXYMasR/0AyXaOqgYcs7Wv2GOb9S+c3QZKY919nHPij2LQydoVkAzup4P2R2M7Cs/jMKEyt39ne
	6BjZhKdWkqWO/1Cx0QRhVtqlam/TShsbjm7hOX3bCcW7mw8E7bVvKX3b41gmTYLNs/tS5wPFGTJww
	2OBgBx156I9PlDZ+MGL1FShF6BTF5tcUcGNe5Po1HBNw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 68E65cpH2781877; Mon, 14 Sep 2026 15:05:38 +0900
X-Iguazu-Qid: 2rWgdPSRDwnQl3Ck5c
X-Iguazu-QSIG: v=2; s=1; t=1789365938; q=2rWgdPSRDwnQl3Ck5c; m=Yp/JIayvnYCgUNSR3H1KsD8pIfg7DXlu6Mah1QqG788=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjvlP6KbJz4vyy; Mon, 14 Sep 2026 15:05:37 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x03NZso/yjVLcj8STmDXyzleZqs5Mdzqic+NibTurmigjxWEm0NwgltJv50LJ+F1C/LU35BT7qFx/FkuAKWJ7i7iRnt8AcKgCas8xTirb9oWOxID3xquSJR01aWA4CoAprWtIaMGx70kLD6DCyc4xwtW8tGDWhNDwI3DI4Qzg0lAT9OAWOmlM56K6HtDeM3Zn0JmeN1L+QCZNuntxQNtSaq1XS71viFLG1McrkHRmBmoOIUNbr8bz7cMFdcQMd9lwUnJAvxrVY45OPdmjntPUUgEksDUhj/L+2JpfRzJd/B7pREuAPR7uT7jN5BR6ghp+1ZGz3TgoVjxW+M3c3T1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnWLvqRmzFhdkWHgBJmJEF/51pPm7Mko12D7fatEVfw=;
 b=cU3cWX3rKFh7+i75sy1tJSWbWSxZxp5nVzzq1SHynI/WmJHzcFSM+72NU6WOZedBOYE8fCA+yGNK7h4tuoJKr8kol8A5PL2H6OqndXuIeLamYbE/x6ewuRlXnRneMXtaEUDE26QDQTbMIrVIcwQ13cCJylRWMgkbXOuSLwpr+UP0MAzQnN80/yNfVEBIUcnVOctS/16PD/Zas4wKs2UugfLs8OXGMiLOlaUC4gwUHw3z+s7ZhJveo+bh047O0j7UV7c2YEA9bznM80CibxaJGxWeUdfqaNuJe0cNA7v85pmcEcw+k39cg0atUk1uOn/AID7YiPP0UpUmi3/na4X7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H and RZ/V2N
Thread-Topic: [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H and RZ/V2N
Thread-Index: AQHdQ548sjgCQWGqqk+/5yDTRUHwzbbNltJA
Date: Mon, 14 Sep 2026 06:05:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818789173C2C8D8F9C75388CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260913163727.77875-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB18284:EE_
x-ms-office365-filtering-correlation-id: bb4aa2f2-821c-4e70-249d-08df122630d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 Eig49x4ez2Nc2WSjtDK7uTezlwtevKztI/taha6mOX4CJutLWB0mamNpG/+t2MOwSbqrjIYtIW0GR4v/184rm0JSflBjuNDksJdxgCLoDLorHA2wSqj9aKx60sZKdwSUnVs7R5X7BwpJ3wV3k68wXFZCA2JUNSQ64SHihjz4T6RIpkQYX6irq2K/4oVrbSr5XKC6vXsufyRxAP3/bhCUPSTVWwDq37Pa/IlEqWoqCbSYOLIACuptawVwByWBFel3Il6QP+R7TU5b52UilmFmpdz3qewZhGXAbe9dFqu1XFw6M+VF3r2c6HFCNDG3eZ4Eza7cEkh0Pl8kr8YhKYRxftdcF6Zeqwd8w5FytqS1jSMKk+Mk74mH0V7IAVA7Lt3UrBzKnT7JykG1zasFs92ra+uuVsUCLUlOPETpxkchy+Tbu1twOCz7pVfwMViEaSvf/SZjDjAkZNKyZXAjbUfC0uO6l3TGzdME5yIp0W/2IWtCConljmWmhwGUsLH3Q/WbHLJ8GnV6Wspd8y1y3tdXa20O7A/lqzTRJeqm+LVQ+X2vCCeldq31KGJuGNs22+7sEmJWIgwLTO+tMyK++dKxAnfGRINl3apOBvbquxaYlCHmL+81GI6KKbCgBo7spOOql5odiCpwfGiBzbrhO7/GLNAIHgq5pihC31mDzyLS4K7RgvYR2mZz5A1L3mRs1M8Iny7uY1kt5ofm05G9PJv6LO8yoWIUt4hbuJlr2bGBUiY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZTdVMlBRU3BsRGI5MzhZaTNKUnFJU2RwWlJJL3Q3UDh3L0Y4RVlwMk5V?=
 =?iso-2022-jp?B?aEVWNE1Ka2EvNWF4blIzazFkMkpTb05JSkhaZHBpZngzVFV2VUNyL2ND?=
 =?iso-2022-jp?B?dURJOEdoUlRrOTdCTXI3V2VUR2dXa3NyeWFXTEN2dWZPZ29Ec0JtcVZz?=
 =?iso-2022-jp?B?ak53cEhqV2NhdWNJUlJEbFdRbjMxT25FVzR1THBYMGpzSENUaS9jY24y?=
 =?iso-2022-jp?B?R1hZSTlpZ2hNQXhmVE9xeG9taEVEVnRLQ3J2RnRuWUR0UWU0NkJsa1BT?=
 =?iso-2022-jp?B?dmtEdWxXYjRYNEliQi9KQ3F6ZmJGRWYzZGhLVlI0dEptNGtpeU1xb1N0?=
 =?iso-2022-jp?B?eDNCcDBVaUxXbTIwbFc2OTZ3MVpOcWlkbUJRM3dVeXJqOFZoN0FqV2Zx?=
 =?iso-2022-jp?B?VDZicTRQYmRheGwzak9CQVZhQkVQYW1yd0wvWklET0F3UDNRRUZpQktl?=
 =?iso-2022-jp?B?K2R4OWZHUGNTOEFpRmpoT0ZCTkdSekttR2ZvNVV6Q0xzcUhDNzVUYlI1?=
 =?iso-2022-jp?B?NGgzVVorZGhlYjRjSkhuMm91RGVrbUpXa0hJT0RGbC9lNCtuRS9ibzdq?=
 =?iso-2022-jp?B?bVgxZnMvcE5BU3FNU2xrb1E0UnRXa2hkR1IybjVrYlN2NDVtWi8zMFVW?=
 =?iso-2022-jp?B?Rjl5T2dOdmRDZUpmd1AvNS9KMnRRcDdZVGdoV0ZyM2I3OUd6RjhTaDFR?=
 =?iso-2022-jp?B?UGZrZXhVUjNlSURRdXZSanJPRWVEQVdUdXRFMjR3TnNjb0JqS3M2SHVi?=
 =?iso-2022-jp?B?RmVrTVlNUXMvZmtIZ0g0WmxqRXhBeTNJZWlWbURnMFVvSThUcUI5MEt0?=
 =?iso-2022-jp?B?a3hNd1hycm43UWpFc0FPaVNxemhTNFhGSERabjY4SU9QaTVJbWNlY2Jy?=
 =?iso-2022-jp?B?RVhwamRKNTg0bFhzcHlVSUx5bFBwVGgwMTlOVytPZGhWVHFaYnZKcGlZ?=
 =?iso-2022-jp?B?aWQrdk5pODVRUkJtMlV3L0w1NS9aUmdjSjhjU3lzekdIcXJGOGFKQ09W?=
 =?iso-2022-jp?B?TFkrSUhUbGRmcUU5Wm9LYk4yY1F6TVlPVEtrU0F2TCtMSkVoUTc3eTRZ?=
 =?iso-2022-jp?B?RDFXY2hzQytDbzl1dTdvVS80VGVMWHlxRWV5ZlhqUGgvUFVUTHVMQ0Uw?=
 =?iso-2022-jp?B?cmQwYTNCcy9JcVpXZG5odURIUHpkdUVXT091dElZMzFlK3BqRUU5Vm5B?=
 =?iso-2022-jp?B?T1VLOHFwQndjVVJ2V3F6cUVqeHBFUmVuK0hjY0h3bFFSUnRuSjRPS2Vm?=
 =?iso-2022-jp?B?dTd2ZURmRVRGbmN5bGFNbzkxYXYzYVc1eWZzeU5hZFZUTWgyTmdRNUdv?=
 =?iso-2022-jp?B?ZlpoVHc5c01KbEZHOWZKUW8zbld6WVZPZ01HMm50M3RPMnZFUWFhdGRa?=
 =?iso-2022-jp?B?MGl6WkZFUTNzY2hEY2FPN0dZN1F3WStHQ3Z3cXpwUDl4YytLOElubjRD?=
 =?iso-2022-jp?B?M3RSRWhMSnlmT2NnRytOTXBtL1BJMkh2bFJERTB5ZHlkZ0lUak1HVHNt?=
 =?iso-2022-jp?B?NHdUYVoxYzlLWXZZck1lb3k4UzFranFUTklmYSt0Uk5xMnhINXVhTGx4?=
 =?iso-2022-jp?B?VTFoV1JWNmJDazJlZXRPNlJNbmRtQ0Urck5UaEVreG9OUDFBRDNHUzRk?=
 =?iso-2022-jp?B?S1RZbkxoWDBySzM1M2NJQU94WUE1V3NSTXJ1RHdMWVI3UFB6dURwVXcz?=
 =?iso-2022-jp?B?M0lraWZlVTN1bWRBVjlOWUVuRkZFNTdnWjFVNnJUMU1aWkN0eVZ4S1pW?=
 =?iso-2022-jp?B?dlVqZzZ5S3M4UlhBa1hwVWlaS1p5cVhvYW1nOVUxdlNrK3RVa0grYWkv?=
 =?iso-2022-jp?B?RWZFS2pTVTFVMGExMVA4YUlmRjZ3NW5JM1FWOWlqMGdXNlZtZDZwZzhN?=
 =?iso-2022-jp?B?ZEw1WGpLb1B1dmlHSCtkd3d6NzBGRTJKVHUvZXl1QVhaZjZ6QnpBWTEv?=
 =?iso-2022-jp?B?cVNqWldQZ05IMHhFd3hQcEVOOXNzSXB5VE9hQWo0VW1QZENXWFlBbHV3?=
 =?iso-2022-jp?B?YWhtQXAwdUp6OW1LSTZVZ0JOWTRRcEVBa3plcDM1T2xOTC8yNzMvSDZl?=
 =?iso-2022-jp?B?aTVBSlJ1Z0swMlNndllpU3hISm15OHZ1SFlqanJRM3BVaVFnWXVMUmNO?=
 =?iso-2022-jp?B?bE1BSVVXREQ4TWxKVjlZUUJlNkFzVjgvMTNLTmYvTzN2Znl3L0lMZ3NS?=
 =?iso-2022-jp?B?SkxxM0JyQkFja2hvbWR4L0FFb3BXUlVtTm5iWWhJY1JKWFYxb3dkTDcw?=
 =?iso-2022-jp?B?WmwrRnExWnA2ZHpzTWRxemE5cCtDNDJDSEJPZ2x4TktOZWZtbUhQWFVV?=
 =?iso-2022-jp?B?RUJEcFl5dFZzRlZJK3orUEFPcTI3N2FuQVJSN042OGxNOVZ0ZUhzQnpD?=
 =?iso-2022-jp?B?cVNJTE1udllxZnVvSkJpVnYxUUdmbEZUUXI2TWM2N0JEY3RkQWhWTjhJ?=
 =?iso-2022-jp?B?OVZXcWUrZWlMYUtINHR4QU5rQUJWRUd3WG1Ra0RvT0JQZ1RBdTh2TWk5?=
 =?iso-2022-jp?B?THdBWVFxSGVtS2VTZkF5aE1UalZNcEpnTkV4c245aEV2bGw1UVpMOGtL?=
 =?iso-2022-jp?B?K2JGTDZ4QT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	gaZ4gN2GQveKvp6qlOvPXbhH2v5po8shOGvqvC0VNVdB9LGicQxN+GHMG4DC2YHNfEMg39PbmgCukasrkMzBkv2Tq6NU//LmbXfai3W4L1ndeiRQWu4panuCAz9HDektePfxezEN3FfophUfssjx0ItibPZmn/Mx3blQZ469kg0G2dWyOMRZuTL7twmnBidcYkwBghmhy4pwOP0hiX8dc/ZnQp5bUOTTGOXhPUChvUM1k6f26XF1GZU1Xzz9X/+XwRm8sf6F3c5aXNatmZ1VHKweoJ3SNuLeZugAxfWvgbTgk37XReb527UDiSP1LOi1DfRQRFqklURX9aOtsGWV+w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4aa2f2-821c-4e70-249d-08df122630d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 06:05:34.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqHOeTcEKWWZejRGq1OahphM7kXRJFVPYSoB/jCBknZW5Gt1jU6v2gSKqzTnZNXLfkjLZSbHbYF+XqSJWWNPe9oeZB4kvEiDO7ZXDC8D3Pb9QQYAnFhc2lE0P1C+imTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18284
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:05:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24166

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Monday, September 14, 2026 1:37 AM
> To: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d=1B(B
> =1B$B>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwama=
tsu.x90@mail.toshiba>
> Subject: [PATCH 6.1.y-cip 0/2] Add RSPI DMA support for RZ/V2H and
> RZ/V2N
>=20
> Hi,
>=20
> This series enables DMA for the RSPI controllers on the Renesas RZ/V2H an=
d
> RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Best regards,
> Ovidiu
>=20
> Lad Prabhakar (2):
>   arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
>   arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels
>=20
>  arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21
> +++++++++++++++++++++
> arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21
> +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>=20

I reviewed this series, looks good to me.
I can apply this if tests are OK and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/284=
5749371

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


