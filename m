Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14708103E2FF
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 01:53:54 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12414.1773280424051484768
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 18:53:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=c76/I/Vh;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1773280418;x=1774490018;bh=nsy/xrwaMrAH94EBqdSc+1nDQ52nuT6DpPPut
	x8dQKw=;b=c76/I/VhjGI9LMBuUHdJzja2oh7iQroS27yLFhAzvTiHYYJIrqVXi50nbcpJkk9ut1s
	IzjWST66ZNr+SKOmmng2dBpnye0rF8zbmngeWA9+cTlsP1OXsc/PHT+oQ/ktfXncUoXiGpfEw9bzN
	OyKwa0mUndLapCIRO5d/hFif41i6FX1UlNvp7aW+JjBBqOxAq0YB3wKncYhZSiU113i1uWhczvuOs
	xW0PXRCEiQM/eiI4oLqJWM8rX8k8quXFQ/tOOg238Kw1m3H3y0wUJXmXSekpVThhN0CUYRCw3F6c6
	hktl+MIwxZmCFyLseqgsaY1jVt5UvaZESdA7u7mXm53g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 62C1rc2l1468684; Thu, 12 Mar 2026 10:53:38 +0900
X-Iguazu-Qid: 2rWgYFujCIs0AIJpzj
X-Iguazu-QSIG: v=2; s=0; t=1773280417; q=2rWgYFujCIs0AIJpzj; m=29GV4PehzwhvqbXlhMaGtbykXHCczYhEQzIpaIapvUg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fWVyS6pLXz4vyh; Thu, 12 Mar 2026 10:53:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGrnQgXh6LRdtD1DYvzWS9M1SFWyfzGekeTO/UP94i8aVinmkOw8D2Vs7wCG9+Aljx8aGnka/D5g8WR8rSbcUYnXfjn2zEWazHqh4BGKvI4PuUez4jH/Zo5JErbqbHbOe5ZFn0GfosltOIyGsN1IU26EsH1uFpRgwg4LCScE/HJ/kCRNNXL/moEcf9wrh0NIHUQJzEdjPrDEv4MMp0Z8Heq/PUaDDSHIs8UBRxLfWU2g1O2PjLdUXUnqCBVYxoOTWQdlwwncVxgRUm1GkDp3AK6bB7olQNTiJ+08ZALbCxXIk3XO0MM+rfNc+8xPSpYMJfRza2uVLwYsXg/aLtGEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zus2F8EyewkS89MS3G/A+jIQFw7ECzyFqgX01B3IGJk=;
 b=FUDtZ/xjwsela99Tg4JzSpBLdBhSW8m0X9EC/4avcATZbdGvg66tp4+VgN55gQzQ2Xbn9hTDqBNpD3nkOTbtB0tOpDaxrKpZQnQK7/m7ig2wUr+Z4eiXpfjZU+VwtgX4UgU7mDBIUm6qOarFLU3/fHw2RNMNVOdBhVkbfPS5+p90XolwRF1IlShp5ki+gozoN6tkeoQ7Azd4wiFe1uVHD+kjJSXgcDAAnZkWlQj4ubSMypBpzN3o09Gi9RSOrhtkHlxkogW0Wg+6QB06yNWAvp1lF0OJ3zf/x7MgcwBjuv5xbTCWPnFVLWUNFG+olQtHd+bGAlSJjET5Pm1EUZGGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/6] Add suspend/resume support for
 RZ/G3E ICU
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/6] Add suspend/resume support for
 RZ/G3E ICU
Thread-Index: AQHcr5mHLQBs40GIGUmS2+7SFINv5bWl2yuAgARLVhA=
Date: Thu, 12 Mar 2026 01:53:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818488AF0AD0C69677F5CA4CD44A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
 <aa6CH7BewI/LNNPi@duo.ucw.cz>
In-Reply-To: <aa6CH7BewI/LNNPi@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB14870:EE_
x-ms-office365-filtering-correlation-id: 8d06d1a4-8e17-46d8-f885-08de7fda292a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|14052099004|38070700021;
x-microsoft-antispam-message-info: 
 4vgHq1RSx2n4si26oB2+e5RJQcz6xQaUWajxtcqkA1VLnhv1IZXGPbtkLM0RJ9ARXEMhJLw3uOTqBjJu9dY9M/FBcORNLC+iPTrV8ZTBBS8eaXUx4ibVlCZaLNpk3UK3Oqm93XQVmC+EjXsKHn3gnWsvWbSsoEGjnvOy+2k+aS2HYNfJyD39txhaa6uUspOQT5gsu9WFfn4wU1v9E9diZ+WW1j8Uu4020tLrJQiSd1II8YKIZZ4v+84tCcyJ9r7W9Do7Au38bR0JFeLkAqzsQ3ZCn9axZNiXKWgi+5yEajVLQg8PMZtCR9Vi6H2SgBe8VnVUMzNSewveglmjLqDKPTm1GHyVt9ySwJdQYwCDFSdxY/tDmq1iXhnIUJoQAk11EAmWdWitAolLDZXDfKUUxD0tVTzRj8DuzsTzlbHuQD41qeozLKssbpx70azZmjA6onB1k5GX98OmyJ/lfpD+fJQj8S4x2qXzPko+rZ4BHwC9wZleUWYRYxi2kCDV7aduTOApuDpiZFdF7UdPTj5++0mf/GxVooa20CocE0doIrexCNHupRXUsZ3U4OHj1vo7QpfmAAmm7YjPV/BSZZOsj7VyjXquVqGGob90qBkxTSgLikMEapgZN8b3wb5lJJyf7FOi27dYISRhrU+1SRk3wPJNCYicKgahmtE61Vyh3v0xwjjFU19TBOrTtgQQZwTFoL6ojgFg3Wty3mCNRX5rJJRLaE/fcvBpvskXfsaVujio+gY1cAOqpqJotMoK4tFhv3Js65cY/wlsSE/dhtuA5LKhGJ2jnusVTLpA4Smg/XA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(14052099004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZmJGd0t2ckxXckJJWTZCS0s4dDFPK0o1b25PdFJFNTNEL0dHRGVYcVFq?=
 =?iso-2022-jp?B?UWlpZDBzSm12QWVCeWxBQ1BXdURGcXJ6bkJhclpySDBQY1kyZ0FYd0ps?=
 =?iso-2022-jp?B?OXBjTEh2TEVoWkZtcUk2SnArWVAzN2RHbEdzSWhzOUlQMWt4Nlh0T1ZK?=
 =?iso-2022-jp?B?YUxHOWJWWlNubzlIRFdyVjNuNlhnQndWRnl2SmpiS1RoS2Z1K3FIa3ZM?=
 =?iso-2022-jp?B?KzlqUXdqT0IxRVJ6c2c3K0ZNT1RIWVp6bnFjK200NTVMYTNQYkxreTRt?=
 =?iso-2022-jp?B?SklqUHJ1YUg0blB1Qmc5UjRhdkJxeDZTRk1wSHI2RmhGRkZjdStidTVi?=
 =?iso-2022-jp?B?RFFwczJIRUc2RjExeG1XV1hUckZUY2N1elZ5RW5hdEtNYStYV2o3Rnk5?=
 =?iso-2022-jp?B?QVJzZnZHS3pRR2tTZDY3QndtaVBRTVdZRTZXcVMwdzQwZUxwakljUCtR?=
 =?iso-2022-jp?B?U1VNc2h1eHRNaGkxRWhHblNvbVRIU0IvVFdyRUtTZmtBVk9TRFlTM2lU?=
 =?iso-2022-jp?B?V3lRYnN1U09JZExHTlVtbWU4QWlkVzlaQkJFQ3VHSUpMZGVmVGJCaEpT?=
 =?iso-2022-jp?B?RTNoUCtiNVhpa3Q3MklDNXZHbnlpVG9neDUxcGZqYVgxOUVIdlN4WS9F?=
 =?iso-2022-jp?B?d0xYS2RMQ3MvbEtxODZkRzM4d01OckZrUXAxK0padEV5VXRMQTk2YXNR?=
 =?iso-2022-jp?B?bXMvU01PZFAzckdVZk1wUXNMcFhsbERjTlJ3MGUyNzFEUzdxN1VWZHow?=
 =?iso-2022-jp?B?VjFZMFR6UXVTQjRCcUFSZnNEK1BqKzNuYWtBb0wwc3Y1ci9FTzBsZnlK?=
 =?iso-2022-jp?B?a1lFOUQ3SHBVVXkyRVZLNDlneVU2eDZJSmNTT2xka3dqb20xeW5uYWlX?=
 =?iso-2022-jp?B?REJ3TU1NOU15MXNLLzE4cXFRNU4rdkRWdktobkw0UHBBTnpaamR6Mng3?=
 =?iso-2022-jp?B?ZDJqbEczUTdzL0pDRklUSjdDTmZYYmNSTEQzK0tyQXFEL3lld3ozL1NF?=
 =?iso-2022-jp?B?K01nSm1Ia05rZ3lZVFFPQi9MbGdqV3hVdmcydnZaTEpsTzJkZS9qeVRp?=
 =?iso-2022-jp?B?T2NKTkdmSmR6NXZhTEhwQk9VY3lTKzlsdWNhcmZlMktSTGNFRkZldTVF?=
 =?iso-2022-jp?B?S2pDTHovMEZEbmU3UUREWHowWmlUMWZwQXBoOEtrVkhVRUVXaGRwZ3pV?=
 =?iso-2022-jp?B?SXhKRjFWWXFtTDNPdzZVMng0SFRmTlQxNGNteVhEcmdkcEFLemZ5bDlC?=
 =?iso-2022-jp?B?VzZ2SGhyKzBXWTQyYVZrbFFvb2hWMUZTdmk3WWJjYWNvY0xCaitpZ0xi?=
 =?iso-2022-jp?B?MjE4WXEzQ05xY2RaYzJOVjVCVWdBdm9ON2tjbTRaSXdydE5mRzdjNDJJ?=
 =?iso-2022-jp?B?U0lnZS9wVFliWHUwMDZTdjkrcGVXUUVtaktDUFdhaU8zMlF1RU96TnBB?=
 =?iso-2022-jp?B?WHkvSlk1dXZNenVJSFRYeE1aZGFHWTcyS0dVVm9vVDhIc01kQXV4TmRx?=
 =?iso-2022-jp?B?SVVVRXdwSFYzNy9vNE9kSFhPcnZ3Tkw4dWk5TkhkQVFJaTExSVZ3eWdG?=
 =?iso-2022-jp?B?bDI3aWx1VGwxSFZva2UzMnlCL0hpL2UvNGI5NURZeW02aDhPSkYzQUgy?=
 =?iso-2022-jp?B?WlRtcmhqQUMxNDBVaEp2VHh6YlQyZTlKUC9oT1RBZGZ2ckZ2RDlNQmdF?=
 =?iso-2022-jp?B?bENENytCU3ZuN0NRTStqVURsNnNoSXE4ZStJdFFtM0crUGlUTUxzd2hS?=
 =?iso-2022-jp?B?Z09QN3pmb0gxVWczNjRhRmcvVkNsTnMveENnNUU2YndtZUV0VU9CZlMy?=
 =?iso-2022-jp?B?VGUxdFVXcjlTeXdsQ3V1SmZRYm05OHRXWTArUUpnVkdyWGx0TTVLTTQ0?=
 =?iso-2022-jp?B?VXp3dlVBK09aR0s0dWtHUjV4M0xyLzY4Z2hZZFNVZC9GK0JBMlRkb2pO?=
 =?iso-2022-jp?B?UzdvNlB2dGlNS09vSXgyNzdzOUVoUEVSLzczdE5zdGpZQTJXV2JkUnFP?=
 =?iso-2022-jp?B?VVV4ZjJaWWdpY2k2TUJ6T1lyMTRPckt6Vms0ZjBFQUZqcHoxZzlmYU03?=
 =?iso-2022-jp?B?QUFOOWdBL3pwZlM4WktpdGNIdElaWXJaWjBXVHhCRXFWc1pxYzlXT2Y4?=
 =?iso-2022-jp?B?akpYUmYwNGJ4WXBoeklIcFNuOENIUU0rREczNzR2THYwL25BYzJtNnN5?=
 =?iso-2022-jp?B?MEFIUy9DUHh2U0t4RitGWVBBTnVXbi9KKzA3VHhsVzEvYVl0UG1qejVI?=
 =?iso-2022-jp?B?cGRRZEdnWWlFdHpkeHdFM3VuREVWOHhkeFZxNmt3VEJhUzF5S2YvN0Rm?=
 =?iso-2022-jp?B?cU8wQ2FZd2JXSDVpUzFnRlFMV0FQOVNjVyszU1lKTTN2QVU3dDZSTWFi?=
 =?iso-2022-jp?B?MUNxc1lDVnZCNW44NWJXalM2NVRObDlyakxncGw1SS9aZDQwUk53M2h0?=
 =?iso-2022-jp?B?YWMvSkFsdHVRUERUcTFucDhLVHN3b1RjZW91eFFTQXhuRjJRQm5XRnJj?=
 =?iso-2022-jp?B?dDJVUTNia2pNVEFwMEZLT1pka3kxQjRWQmROUGNHODE1TEZIMDNhcmY5?=
 =?iso-2022-jp?B?aTlSZTN5TT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	pQhfhLRIzmDDaY6oxTv10ToMvldpbH5X9UHte1hoXxq5y9qHPi5pf/Qi0uqP/0ABvEkgYZjBR0Eppr8ComiLJsv8w1y0GLJcwB3L09sVvX5Wnu6OoNX02R61mcZh3OSmSkn8si0BekESV+dmQoDcQQsqniEtnzp3d7ym8996mhwuEC3+8csicQS3QidAW776UbNsLzAu03joFMqjrLzEXSTjNKOlV0nUTQo2f66RAkDG1sGnaTKZw97E67exnfxdjpVmt53W8wWSFTvbyHBKs1eIICastBEd3tc4QFwUwuTkVtmXRKts4IK39jqooeGbB3iLsydJxAhohuDpKuUrwA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d06d1a4-8e17-46d8-f885-08de7fda292a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 01:53:30.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tcc0EFohsAdnIE2PWc31uSgejKlcRybKKh38a3X2+wxKNrE9QBNioWApf2qsXKE/YgXGi2/3bafCE5tMrMO9B8Dm2Og5F63euJns5YlGWEvQgLY5Rj4UFKMXTSFS8pK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 01:53:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22347

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, March 9, 2026 5:18 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/6] Add suspend/resume support =
for RZ/G3E ICU
>=20
> Hi!
>=20
> > Add suspend/resume support for RZ/G3E ICU(interrupt controller unit).
> > Also add support for CAN FD-Only mode.
>=20
> Should be refactored in the mainline, but that should not block the merge=
.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I will apply and push with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


