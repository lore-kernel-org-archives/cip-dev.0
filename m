Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE9DC55175
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 07:42:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38173.1785742932399153703
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2026 00:42:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=R2SjWDAc;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1785742926;x=1786952526;bh=P1zsW5VtPAq/XJAmm+gUUvVbIiarh4Ju2nr9x
	Fk8K40=;b=R2SjWDAckwN5hkAbSbvSHZif+tdEDqYZ41IhdpLI9C62Gclftwd6P7pE4Jw+pA+F/jp
	cT8xri+oIGMtMRIDEdzZw1KE6pjo5AAus3mhV1KrkTjZYFJNrqdlO5/iGbfHX8z9vpdkNadPcAQnG
	jlFVPg1aRV7n7nH4SVplo1dReKRObmdszDpsoZoeoRqtuaauCpNktCMikldAvgmj58UnDx2GWoNwF
	ufzjzCEnzXLkkNhbp2niLdpm12RpX+NNfz0ut0wxHV4Y64wNnfIeoayXUi1ps/CjrDUIL2qj7fks9
	IP1frtM6Qq6Mb/vQvh0ZbaeEMUrok3jhXovEKepLTyXg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6737g6of3153027; Mon, 3 Aug 2026 16:42:06 +0900
X-Iguazu-Qid: 2yAbkFS0MLfdw85pGH
X-Iguazu-QSIG: v=2; s=1; t=1785742925; q=2yAbkFS0MLfdw85pGH; m=EftqGkOr7MmEOlRVBY6Anoni/UM+deG5AnkfpGHoApY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hD7t544ZqzyPQ; Mon,  3 Aug 2026 16:42:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9R6LSvbp1rTBJsZe1DBSdMMWktPTO2T30K/zCXytCct3RVM503P/iS1RQwJk+mfu4bOAoOuJh+xuE8PT33g7f2xOiXFgimlc0Pni7Yjlz+uPZHlUJN+yodKYygwEHu1DYVlODnDRy6G7uTIHZ7pg/s0QCaQU6AD4+nEGefSkg1kxAOYV+L89akj18xN0ZvTRkvj2Xys7iu9J0DbsZVeGc+0tLf9PQo8eo8GWFJnAXXXFHVbrWtm4SFjP7Blv9vDTk097sEPiS3Vaia/4P6nqcL3qctvhDx1RuBXtgDTGCOdAUfxYMumHI2yqR7HdJAUvXKEC2ZJZPsGQDAGfGmK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cksth/oOPbFOTsVbGyz33WNqi0EdXxkDRg2jDCHRfYk=;
 b=HMA9vNrwZoLUUVwwaI8gKmwZ4G0b1oV/kQPCZcVs4PbmZRXVFa5c/gtX37yONVm38nYajqxAX35vv6mMrz7qLu1Ynl3w3AsE2aUW+lny1TBkejP5/x4VcYvii8vq0b1m74E7GLo8H2MwCYMAosUetQxlG5onY4nRXSWVajnwA9vi7yA7xeupiGwwSRQWJzSFP1jFICb6Eo6/qwgKJTdzIpMewdT96QtH4uaFMmR9I85zXP8iKK8jf1RP/b+9FXD5N/qcW1av2FoTghHNasZfr5vv8rUpxMpJzPLq85lCuoMzfIP77nw2G6WnlacExNx8TxKiZi+fNuzBLxuIk2+H0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/19] Add RZ/G3L I2C, WDT, Audio support
Thread-Topic: [PATCH 6.12.y-cip 00/19] Add RZ/G3L I2C, WDT, Audio support
Thread-Index: AQHdIZZCOjIv6v4nLkmqntRxO/x45LaK6VwAgAEKUBA=
Date: Mon, 3 Aug 2026 07:42:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A1CBF30FDD2D7A9AD04DCDD52@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
 <am9mpF90lb7xIyg5@duo.ucw.cz>
In-Reply-To: <am9mpF90lb7xIyg5@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB14795:EE_
x-ms-office365-filtering-correlation-id: 9612b4bf-3776-4759-cb90-08def132b58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 63COqMBy3a7aN/ymZMTZakQhKgs25UhhNlup033qDHITliztR3WGBCzTufX0x4pvcdwijmcxuomopl8EXFE9hiYZxpRzcrhZpFi5bnsQbxOL0t7jOUy+JCoXb5BQm8GHqeKypUW2sbGu0OzH3u5/hkxMKQUWNK8ykuHodOkkTbaNJrEIZ9SL4IWeYKQSWnhKfu9H4lPtxo6m9rLE3+O/qCEwTOGLkaWsjNJoSyT8inP91c7lA+HQX3Wn9rPNInLzBEdgE/ORt5KX9qKwce8CTLt2nUteVsgTkseFDMGNEn0raAfuATFZy+9ijAeygeHDoEKPNjMa55wh/Oo6km147p0dfvxI42TVw+vSkaX13uVuDyobk8BdotliFvOiigRPELUeOkY31lPJlNnPmuU1cNK6hvQ+I3BtXrOcffAUA0QYxVDeM/dV04xOHUg+L2twJPvhMjcmVHq5CZEQNRiJiReVLgY5oWDz00YqaM8kUn71XmpRrEbSEpLX3cN81Ku83aF7kFMAaWaccrSu6IINxYuOTUi5BEFTppV9V23kiodZjp/GlbUbe3Qj23TisGxvfVxC76T3wRMl8YOrDm7LsJL/2b/qwX9oVvW/Lygmrf3taopkOwmd6yBkn14yUOG0Lr39AW3e7PdwGkwhLzvOn62Bw+t7hH02SYI38sPBVta5xczhdS7ubutXsWqNELXHcE7VE2zbgPJiT99y5gEaSUCohd0ZHh7GCOdgqzFS5as=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WWlReVZlRjdkcWtFSE9IdWNYVG13WjhyWjZ0UUhpOVNwREFhVWdUUzZ4?=
 =?iso-2022-jp?B?QmppMXNzQmJLMStTZWZPalpBUWN0WlFEK3oxcDdBZDh5MVBHTi9jMnE0?=
 =?iso-2022-jp?B?bFJYMGIzc3BoTnpsdjNyM2ZYMUVCTkF6NWQxcmpidUo1cTdIN2R4ZzhO?=
 =?iso-2022-jp?B?cVRGbDhHK1FkS2VNODVuUm9ESTYwV0VrZUZlL004NDVheG0vakxUVVdF?=
 =?iso-2022-jp?B?VWZ3ZVVaRGJaUlpobDdlaCtoYzBaV1JueGpzTkpKUndBRWpPN3c5OEJ3?=
 =?iso-2022-jp?B?ZjV4ZXZINGJvakdmbFpBM0l2L1UwaW5TVG5CdlB5VHllM2tUT2pVcmpo?=
 =?iso-2022-jp?B?clZJeGF1bis1OE9kb0xIUzZwbUZLbFJHZ2F1N1RvdXEwcDVhRnM5K01H?=
 =?iso-2022-jp?B?ZzdLODVtSDJ1YzRTOTRMK3gzVVlwQUVtS3k1Q1JOV0p0cDFxU201aXM4?=
 =?iso-2022-jp?B?ZVVKRU13YmdpbU5OenRMeHNJQkx3eXdPME9CT3UzamkvOVJzdFpYa2Ez?=
 =?iso-2022-jp?B?U0hJazJPazZUYmVuVlhsVjNScTg1bVFBWFduTVBpa3dUWVY0U1BGOTlP?=
 =?iso-2022-jp?B?NE1JZDlrSHA4TEJETDBwYStHeTFTMGY2UWlmT1BiTjZtZVlrbHphZkFQ?=
 =?iso-2022-jp?B?cUVwU1AxQkJrdHh0Nk1CeWdlNlBUUUhhdklxdjZUMkNUY1lIeFAxNkI5?=
 =?iso-2022-jp?B?cmltb0RUZ05KS0c4dnRXVUYxSlk2cC93aWwzWnFrVllVYWJwU2paUFBz?=
 =?iso-2022-jp?B?UnpoOW1ZNWxrUFhEbUtnK0oyd3RSdWtoL3YrTXFEM2xWRExLRWRSSGtC?=
 =?iso-2022-jp?B?NUpJSjdlci9LTmM0d0xvcURnbmwydWwrZHVkTlFZQzB1cldtRnNLeitx?=
 =?iso-2022-jp?B?RGdjSm16anRmSmkyck5Cc25GcTQ3SmtvVDJDNnRqR1Z3TGdSOS8rdU8z?=
 =?iso-2022-jp?B?SDBvQithRUQzYmpzSnRGWVNadDhleFZCYThtZHp5NWloMzJGTmlhNUlV?=
 =?iso-2022-jp?B?ZlFsVTVEVnVubmRlY1F5SkNxS2tyMkxKcithYmVZQjcyZ2lrQUd3WTlS?=
 =?iso-2022-jp?B?WkJCRzM1R1gwNHpxVy9DVXp4Z1F2UC9GUEQxOUgyNkt6Uk95YVBLMXVi?=
 =?iso-2022-jp?B?V2tuYm41cHJsWVdVQzdQTXV2ZVM5NDUxUXRuenRxV3N3K21jVFZpeUhH?=
 =?iso-2022-jp?B?ZWkwL1JaWTB1aXEvdFNKaU95aDBLR1J3YTRVdHc2S1JCSmFDQWtyMmxF?=
 =?iso-2022-jp?B?SVBiREFtaWRLdFVZR2k0YkR3QlZUNDdOU2RMQXhvL002OXlDQmw4Wnc5?=
 =?iso-2022-jp?B?ckpSYlFYdFY3NnhZYStxT3hwMGw0UG5nOEpLb1RWZVBaT014TVpXOXIw?=
 =?iso-2022-jp?B?NTh3czJjdlVSd1pyL0tDdkp3bkVLUHFRT3ZIbWp6Zi95a1Y1Zkdtc1E2?=
 =?iso-2022-jp?B?Z0NZSmgvd0NZUkd5WlI0dTYxOW1vQlo5b2VkNFVPbUgyeUtja0E2ZkhM?=
 =?iso-2022-jp?B?SDNXdENUYlNzKzhiNE9jQVJSWEN5ZmtMSmN1aE1HSmNvQXppMG1QOGQ4?=
 =?iso-2022-jp?B?T0VOaTRzcncvN2ZuaDZqa1NuOVVTUmFxNWphTnZZTTJ4Y3R6OWFOaG9X?=
 =?iso-2022-jp?B?QnlyNmI4d3lneUJLTmUyNmx5OWhoSC9CbEg4M0pBUkpFV3BtRmM5YzY1?=
 =?iso-2022-jp?B?WW51b3VoOVRCbTMrV2JqYitWNEh6TjBJNENRQkd3ZWZWckZXM1lDQWV3?=
 =?iso-2022-jp?B?NitER1FUTW95ZUZrQ1hIOVFqamFETWVNcjFpUnZtRittcEVqMkdCUHJt?=
 =?iso-2022-jp?B?VktDNTVGRFUzRUlqUFRNTFNKNk9DSG5yVmxSdnFrMnJWdmZML3NaQTZK?=
 =?iso-2022-jp?B?ZVhqRWRvMlMyZ21DWXJoVWpoVDFQRVZzblBGVkx6VXZ6b00wSlBwS0dv?=
 =?iso-2022-jp?B?RHNDeGlhSHpwNFhCQ1lHaDZKZnFxTmN6VTFISEdWOWh4KzRlYjV1dWVo?=
 =?iso-2022-jp?B?YXluc296ak1IWUZ0NEJJVnVZVlRIMTQ1czJ5MkFtUWtoUzVhcDAzc1pE?=
 =?iso-2022-jp?B?VDdrMFppQ2JrTjhtTm82VkN0aUhGMGFIV0ZHV1B4NGVpRExvcHFTUyt0?=
 =?iso-2022-jp?B?eEVEYTVWRTFFZnJXcVJLcnRqSGVCamZRb0dTNXdzQ3F0OVdkenJubmR1?=
 =?iso-2022-jp?B?QzJQSWpLUlJubXRYMlVudFFHb1ZXbjl2aityd3NERzFpTFR5VitYSXI3?=
 =?iso-2022-jp?B?SHRXOE44YnZkZHpuZUdEMEZPL1ErWFQvajB5SjdVaFRlLzM0MHRMZTZp?=
 =?iso-2022-jp?B?ckRReDdXc2YyU0RFRW5QVG4xTXludEpDYklUcTQ1ajg3eFNRZTFoeDdo?=
 =?iso-2022-jp?B?bkhBSmtITGUwTm4xUjZocWJDb3dlNXhHL000NmowZ0FQbmpoQ2E0SHQ1?=
 =?iso-2022-jp?B?b3h0dmIwQjRYb01qTEtIcys1eGI0cGFHUE5yK283cnFvWlFXVWlHZE80?=
 =?iso-2022-jp?B?d0RNYnhwSXF3VisrcTI1UEJTbGx2d0V5UjN3bkZTRXNxY2pWLyt6MDlL?=
 =?iso-2022-jp?B?eU5sS2l4az0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	aXrZdSBgTohf65GGXsRFNELB/ybwcBm7jRN9pXrV1ctJkX+DH5Zr4jPdORARVj1PveFKMZ1GV4X5i2oNBpqkgktDRogmT3NtQNfHcD4aLTRzSmmw7nUChmkrpAW4FXr7hJVSK2at2UGJIS8SVsK+QU0aKK2cjPwkAXAHHPv7xt+dtUcdVOQ2xyJwFNv39XT2ngheESzVdacDxKHhx/UlAJgallFNsZFqzIBDnAjGnL2P95g+WDLCf9Dp76cQxou324RsDwqt/OsAU1oX4Rw+pW5kIyRpgf/wVioUYCGLZOtx+WDXg2ARzhieQZJFvBfmfVdRLVrfAYKOWtE4+oZT+A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9612b4bf-3776-4759-cb90-08def132b58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 07:42:02.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AA4l+DE3bYLUZeYpEqMjiJsUKmA1HxC91X83jtmKKpYYPIzpZpyf3cTHSXPI+ToRGAaGpKlIsfcnfYh/5FRrHndYghBhcjRTd8UNIggSxVvfyE1ztRYBE4EdWUT6ZBqF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14795
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Aug 2026 07:42:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23851

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Monday, August 3, 2026 12:48 AM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>; Lad
> Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 00/19] Add RZ/G3L I2C, WDT, Audio support
>=20
> Hi!
>=20
> > Hi All,
> >
> > This patch series aims to add I2C, WDT, Audio support on RZ/G3L platfor=
m.
> > All the patches in this series are cherry picked from mainline.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I also reviewed this series, looks good to me too.
I applied with Pavel's Reviewed-by tag and pushed.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


