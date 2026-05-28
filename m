Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23638CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 08:44:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6437.1779957865742335961
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2026 01:44:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=r0iLmcvo;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1779957861;x=1781167461;bh=N+0UyEfec5cEXA+XIQJbS7gyFtC4kOZ8J/T+T
	V1MxZw=;b=r0iLmcvoEB+z1RJXOCAmMKtYcgVPsLKIcS6QIzdIe5XXaUS9EpP9Buy2RQA+XzXJt5g
	IEJZqEBO5tWGbZaW4NEmkN6/IhidW1H36nb+R2CwEHI4zQOiajnIVEt0ITpyyzxf4gtPc3LDJ35fI
	2wtcY9hZt9lVUjLeP50GztpblVRPbUNjZm/yyjAau9nfoJ/tgyAtOH2VbVEP7EuL3FsSkuJIiGu/u
	+tOBaCxqTr0YE40VYP+qZxtEfx/VZo3kOxLyDKf10Hncb5+ALQ26klvEj/OXXKb5ZzqDf+ETxUvdC
	7u9Dj3EVSpaarSpdsb3W8LO/ENk4m3rexn7EoxID2yRg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 64S8iLRp3893159; Thu, 28 May 2026 17:44:21 +0900
X-Iguazu-Qid: 2rWh7qEAD8XDuM7WVM
X-Iguazu-QSIG: v=2; s=0; t=1779957861; q=2rWh7qEAD8XDuM7WVM; m=BkFqhiMJz69KftgQr1WvnNY//nXL1xq488NU9mGkPDw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gR0Qr28J8z4vym; Thu, 28 May 2026 17:44:20 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrxIMgaL4jfG5dkdPGxdvm4l9RC9ERc6CWyV9/J+JgEq/Bv9l+yDaTcWEXGq9QzWifUUtYOOn/7SCcI9SSqUFNNk+ZeemJ6h0etWhX++OUR4vrB5UVThvwdracIT/qwkTn5UHpTM9Ndk4imZMHfruCZPbiyWLoVGvtX5QX4uYCBSlDpj7946PAkeRPTmlTTyhUDJWXXrnx7u5vqQNh1HW/j76P2MMnTmOst7L99A4JkAuKnbLUWbb290RIhw5Aq/wAPsVezZ/zZrYrInouMxN8qhrtY5BR6HmWAy6EE6qF93jvtjhki3WFyWPXAn7x4nh+zK084AWPMcZCdV49+IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d83QslBxvzczkifu1WlbaBrPywTPG32QYvtxWqhrrTw=;
 b=KpV9f35d77UStXclPSF8oBGpRyXcneufcCIStGY7ee64CMXD+TT0Y/CsjEYzeg5wkLRBPzdn+hIZrePHyVQWgvEGP+IlY8w0Bt4/HaywkctV9iqz18WkdZ7HnQGC09YUqYO1Yy5tAlAS9f3Gj7SzSgDNd/KQplfNHJ+i+Ma99X16SSLHkaGNO/QcVBK8nksNnvHH+tsNo6FWV50Q6Z5gJ2uFLHJHuw41rbsTnhpBXq4lFCw8N3IQ3IH1iogzljlYb9wjmsJ1p1+jXLd9FgYGsA9Snnks/FF0jnVLTh18gTk8mBcbNQUIJalylIU7rq4TxDcSOeM+B65yt6ACIyX+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Thread-Topic: [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Thread-Index: AQHc7fTjQsFZwnOFvUK03klPmNjpArYjH43w
Date: Thu, 28 May 2026 08:44:17 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181C49434347D36238191ACD092@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB17856:EE_
x-ms-office365-filtering-correlation-id: c445e9ff-6431-4a58-1fa2-08debc954e03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 l27Xq0/J0JExRMwPWauvx8VnLeNZ/0HTfKbfZEEPdvxcyS8Unh+1DFn1xVBYdy5KJFDij4/xRXwFZXu1SXTLoAQuZRCg09CYznM8jpSxisRx/yFqAVY00gOUnGzSsUP30jlp7/GvWZSyFgJkgkaF8KMwDUqG9b8//MDFAoAFdntqCq/wpfaYRHiycldYPZImhbKxIg6yQiHmydzD8fZoZUZpoU/HSyvx8R76WAxPukdvY5YRxMa3zu11wteBxmdgozfMVUMWBVjzrj3iuENrF2gXra2IvadAuWSwa+/H4N5PYYRmGNENYyp31PN6CXfWLDt+L9umtJzKs7EhC4gOMv2IwJb208wgfFc+QFZaHqjUjhWXpvRfwpFgj9sFFu4cyANWt1NFZXqdWDvjfLwNGB1S6R5C2+mHo0NMABtkbBOmFZwkJ11/cLWro1EvyDfStIi+VodwaMkqh1Xx0i5U//v/sCBQTf+cczx71vFIigidx+eEi9OSFKiuAQQT8HrxbeSL2yeUsddSq0rXXX6pk2QVxStG2qLTP5FaTi+Iecq7HoYnNaQerLD/17i30PN/7FMrTQkVROHMeYOsgY0hNKFIpbmS0pKIqdsfM5CybAPaqUC5i65kG/M/c7GEXAnisGzOjizftPNiSY/aq5/y2LuT5Ft47rO0MFnuOFSr42fNgOTvIxdEc1WgAQSkzRXULRgWH3IxbxpqeaoViVLSyVSH094VNbDidXSbMMVJQ5ebRWLUgvfjbwePZ8k44tw2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WlFoR1NmcElPNmI0RkUxbmVqNndNL2xhQWpBQ3VaS2p6OGhSOXJBZ3dT?=
 =?iso-2022-jp?B?K2p0M2NmNGRsQ1ZIOU5pUzNRZld0blF5M2FHZEFrbDRkUHJSVmxST0N3?=
 =?iso-2022-jp?B?eGxmRnFSRSs4Mm1OQUFYck82dmI3MlVQTzNKbk9jWWtOU0krNHdkVmpY?=
 =?iso-2022-jp?B?azhiRXBNTUNSY0J6WWVKOEFRZjZJelBUZVo4dElzb0c3cVVvdUdkRmhy?=
 =?iso-2022-jp?B?NTV6WW80cHBhZEljdUVVSGxsOHIyUDE3dXR3SjFzRXBJUHVneTlNLzhN?=
 =?iso-2022-jp?B?U3BrcE9XcmNjdnJZTDRDeGc2azFkSjVWeFhlSFd1eEZwZ3hBcnRITTQ2?=
 =?iso-2022-jp?B?Vy9qQzhIdlU2akRtTHhNVDdXRGJhMjhaVldoNjBiSGdYOXQrR3htMXlh?=
 =?iso-2022-jp?B?SXk5MThQQUlhWkNPS2RnWUp4d2RZdkNuRkRqdHVjQjdJV1h1N2NUc1Zr?=
 =?iso-2022-jp?B?WlhyT1picTJYUDkrd3lPTkZiN2dKOUdPclZZUnBMait4RTBBUld1a0tN?=
 =?iso-2022-jp?B?U3dEZnpMZG1rZ29kWGJnQ0h5Qis5bk5QcXgvNUZDbEp0dlR2S2xyeWll?=
 =?iso-2022-jp?B?emxJZ0hGbTZpWVB0QkNlRThGMWRDdlBKbTRnT3JoQWdLSjRyQ3ZLZ2lh?=
 =?iso-2022-jp?B?d3I5bHB4bTFjY0NiS0FyWXhHNWVOSG1TbVI3aGpZKzZ6VnJHZ1hlVEx5?=
 =?iso-2022-jp?B?dmlwbXFNczdYZzVqMHBxVnZBa3c2Y0NPei9hV3MvOGpadXJsSG1KVEN4?=
 =?iso-2022-jp?B?eEhLdm9LQ0xyYWZTSEdKOTJ5dE5Xcm8zbWhaRlBZeWdQVTBaUUVXR1ph?=
 =?iso-2022-jp?B?ZmdETGtrU3hnRnQraUFFMmlPY0szQXJpdjJDdzNJSmx6V3lBRWRUa0k1?=
 =?iso-2022-jp?B?b0k4MWFaQVlmV09UTVJKTFZ5UzZkOU1wWkdmZnhiK1BFTmJjTkRSSUVt?=
 =?iso-2022-jp?B?cEx3Q3RUeU5rWnlCVUFTeHZzVForSWtuZ1ByRUEvUFNzMERKYjJWc1Qx?=
 =?iso-2022-jp?B?Vm54UnZTSU51ZUtHNlJaTWNTRTNGcGw0Q1kxSHMwc2pNVDYzeW8yWWdQ?=
 =?iso-2022-jp?B?T2M3Y0JLV091WENWUzFMVVYrbmx1dS9LTnV3RTc4MFFQcFAyb09MSzVZ?=
 =?iso-2022-jp?B?SFNVL201WE1mZ3d0cVNhT3RmQkJsSGxaUlQ4ak4xWUszQ0hNbnNFMS9U?=
 =?iso-2022-jp?B?UHRzUmI2RW9iU0dRYXAwZS9YNXBBeVdQb0xFd1FUYXZsZk5CS01pcUN4?=
 =?iso-2022-jp?B?Qi8zMHFCdnhpUXJnMWFqZHd3MGduY1kzazlkOUt1VnZ1SVBOQUxlc3c2?=
 =?iso-2022-jp?B?WENTMjFRMjAyZXdDS0JMbE5mOWpPb1Bub3RnYW4rWW96Tk11S0h2Snlu?=
 =?iso-2022-jp?B?NHo3aUY3NGRnSFptZm5Vdnk5UVNBMnovcW1GWTV2UHV6T0RjTWNiWDNI?=
 =?iso-2022-jp?B?d3FKTUxsVHNmbGxvRzQ3Q3FkWmdZUmVYVEN1TlBVSmxraHArV2VQS2Jp?=
 =?iso-2022-jp?B?eDRvRGYzRjdkMDBGbkEvK2c3Ymdvcjk0VjBKQXpDOVNKYkgvK1NHdjJQ?=
 =?iso-2022-jp?B?Q3crZlFmZW0vK3lNUFRjeGFJU1d4STJ4SzZVMnpnaFIxdlhaK3FOYzJH?=
 =?iso-2022-jp?B?bW81SHovSTl1eHVCVFE1OTgrY0JkZVp0dVRFYXYxWEdEdHNmTEZHTzJ4?=
 =?iso-2022-jp?B?eXo4cjFpOW9WcFp6czNRUytOZ0tyZGViT0gzUXlrVHdFbW02VE1pOU9o?=
 =?iso-2022-jp?B?ZXZmWkE1Zzk0NGlOMEJWTGNVdDdjWlh2eHo5L244Y2xuSmN3bWJLUzA4?=
 =?iso-2022-jp?B?S1AvWTJXV29WQ1VUSEUvTlJtTmVSdmhpMnQvTWtrS1o1UjlzWjlad052?=
 =?iso-2022-jp?B?RzJyNEkxTis1YzlnTWJPazVwdGNvVldEWk5jSldjRTRPVlNEUVBDWDFo?=
 =?iso-2022-jp?B?SHlXTWNoUjJKU0F4aVNsNUxiRGV1eXdDRUc4cmVjcE45aEZPaTBySmFp?=
 =?iso-2022-jp?B?ZGNYUHJnMmJCQnlXRjRIM3JWeE0wZUozMFZjVW9WQitldmFTQWlJSE5i?=
 =?iso-2022-jp?B?b0VEN2NrV05DS2g4ei9HK09uR0pid2pVVnlIUVNBMDlHRGhkTXU3Z3Rv?=
 =?iso-2022-jp?B?QnQxUXNoQm9QT1QzdG9HYlB5c2xxODdXeXU3OEs5eFQ2clNJblBHV1NW?=
 =?iso-2022-jp?B?aVAxNEFyT1FiOEpNZWl6WnNrUzJBOWVTaDJVODZ5K2ZjUDVuQTErZ0tl?=
 =?iso-2022-jp?B?VE9hYWhNWjZQbXNhb1NsNnhKUVJjSEJCempJQllzempORFR0eit6Z3Vv?=
 =?iso-2022-jp?B?RnNTTDVsNHA2T3dtQXo5U0ZjZkt2Z0dPK2VJak9jSFhxckFzKzZ1Vk9l?=
 =?iso-2022-jp?B?QUpFR1k3aFdQM1I5cDBDOTVXR2pWTFdkSFVIVlVIdmFkeWQwM0JFMmFh?=
 =?iso-2022-jp?B?UlpWVStEbExpbVVidGE5OTlGbmFOcklucnRZR0xQUTNmWmNyWHFtTlR6?=
 =?iso-2022-jp?B?bnc2VFBhZ1NkV0YrOENjaGlVUUxlZjJaZjByUXRnWm5OeDM1RHRBditW?=
 =?iso-2022-jp?B?REhiTGUxYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Ux8p6hamMSp2lRhO0xX3hp46CrjSty++jlA2lGqKxFrmP0in9oF1izbKDNj202mqFuRb4IwbWeplXQabFCJkKg+yywHhqMtLIum9K7Yo5i/jhgoLsIh5s2NW8yniV/acs8owZB2lXJG/xLVMaVAuppOPxIImIlv8ZvXk26Di7RsNbUQXmpKGkhvA1omjzkmuINnZgxnAWpMJomfBdJvO0h4P2xSKlCkFGMzuOOqGRVRbB0+Z8x4IEXo/E9mAgdE1I8hyyPz1MLaoXyzagv8itSlg3+UHv0KJtxI8mIQj0K+VBzCXzkFFev/IfoMCWN9FAVEOhU9NKgQsV4D1nQq89A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445e9ff-6431-4a58-1fa2-08debc954e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 08:44:17.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tnLUuTsZ+Lsz6cyud4SscPxVmgJPL6LjyAbUCuoPmCblEVC3XtXxS0oDcmcn9vPwc38rn2Xj5uy+OogO3Dk9fz1AMJLILTQZv1uZ/0gyer4e/I2AoS//z5KrB6iVFPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17856
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 08:44:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23036

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, May 28, 2026 1:21 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
>=20
> commit ba9e1b5254783528e10b45b1f0fb40e21f4ff88a upstream.
>=20
> Implement I2C bus recovery support for the RIIC controller by making use =
of software-controlled SCL and SDA line
> manipulation. The controller allows forcing SCL and SDA levels through co=
ntrol bits, which enables generation of manual
> clock pulses and a stop condition to free a stuck bus.
>=20
> This implementation wires up the bus recovery mechanism using i2c_generic=
_scl_recovery and provides get/set
> operations for SCL and SDA.
>=20
> This allows the RIIC driver to recover from bus hang scenarios where SDA =
is held low by a slave.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Link: https://lore.kernel.org/r/20250501204003.141134-1-prabhakar.mahadev=
-lad.rj@bp.renesas.com
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/i2c/busses/i2c-riic.c | 53 +++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)

I reviewed this. and looks good to me.
I can apply, if test is OK and there is no comment,

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro



