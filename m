Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD65D58CC9
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15739.1774343535630028473
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 02:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=eEe0ftvO;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1774343530;x=1775553130;bh=VM7Yb5Uzb38ZOQzCWjrU4XNu++mllUEApM5vX
	BB2340=;b=eEe0ftvOeFSBSbQXraF9ghBFbHaizJARw9zjlrrDO7lF2ZzZtEL+7d7dtSozSPe3E+T
	aeRAv/KnMoQ5FSD1t2Ik4Z3VfKYGNBhmAH1sGaWhvdlWf8QEpD0olRUCXFaWGWao33sfWs80xAGUh
	h7EvYB6U4azxUUZiOT6hRv2wP+Z9BhL6GONe8l81L+wQSrhTy/5cz0hCgLt8m9+IDGYGRewX1lpNn
	R0A2putgjPvhjdaBYd9RycduwoTQKkR2NYuBMt0RKKCqzoc/re6H01g1H++XZY9ZU/xpB7GN7qvkZ
	1znqgJJ0yD//csKNAJqPOg6MGAgFuClhkItVQwgdibxA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62O9CA832611694; Tue, 24 Mar 2026 18:12:10 +0900
X-Iguazu-Qid: 2rWhDx4hdWitRLovnl
X-Iguazu-QSIG: v=2; s=0; t=1774343530; q=2rWhDx4hdWitRLovnl; m=3gjE8fNi688guB4aHlGSec213CH5eTPBSt3DFALpRQc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fg46x23xNz1xnf; Tue, 24 Mar 2026 18:12:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inn8PqLKo43lrRVBizv/JXeNgSGLSFB1PBGMRZuWqabWJmhP5iYzl6quQVk1GdoykBm8GyP6afgHaox0d6stQW6hGMPiH8UYriqj/kBI2sQ6hIgV9+diuk8KgLb0fZ+V5yfxjDx2JlFAi+TrmWdzGv6dIYGh9cuQoRw9KVnNOCa4XDCqKuWmKDrXu0cPPz8+uPHGJEhSJXX+nGTvmErKeOb0S30TCqdlendz7ONyWQ01f1FLALPyPg2AemTaj8m42oc4/gtZxzFObdK9jmCb879H6s4j+mgSbv25n9Opk5Yz3pffqTXFEr+HXk/8XsV3xk17ldfjLYplB9WgBBPKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YgDD+cV+4HFMhsloRb22xi/ydVzMhjcNaSz/1XKm4g=;
 b=BlUAvtKT6RgI/w9H5YZwGDmu+wHJFsRTbxuGbqaYkLbMB7me67MLf9WSu6kP3szJdm0VtGUH4sJCcUaLbtT610u1qQP92SxILheCd2Q9mXPC7NPiC13dW7zdzOQt/atshcLU66Zjuq5mVurlywigWKvztptP4ur8j8woen7Ha/ENPafT8OUgNBaubWoZRy57wGAtPSeph0N/2WL73nYl2Ir0j1jnDtpbOlB809r5U2ofC8Qf30dVYLwvvMjThOjMlJgmr6BrsAllJHC9iz5tmmUnOJ/8zSzyXqajiFJQrimFIHXw+IAfcULJ9+HbQJRpwZFe5Z5EXjnfJMieVa7NiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <iwamatsu@gmail.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/2] arm64: dts: renesas:
 r9a09g077/r9a09g087: Add DT nodes for SCI channels 1-5
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/2] arm64: dts: renesas:
 r9a09g077/r9a09g087: Add DT nodes for SCI channels 1-5
Thread-Index: AQHcsVO/GKVCD+/AEky6bVaw2os8WLW05ZEAgACyCACAB+IrMA==
Date: Tue, 24 Mar 2026 09:11:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182F06F5E63F2AF04700DACD48A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CACe6DC4fGvWoSG=9uU8U3h4prtqY7h1TjWXfjFk0aTz2KTBFcg@mail.gmail.com>
 <abu4UPD2VcgMJdLj@duo.ucw.cz>
In-Reply-To: <abu4UPD2VcgMJdLj@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11560:EE_
x-ms-office365-filtering-correlation-id: 3302eb87-e4e0-4aa8-8b69-08de898567a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 NXutVWZGqtUTTCi+WWjMbi4ObMCQcc/eWV+TvY9dKOxyP1jfElQX8RmKjis7yN8KZb+KOEkCVD3JsDB7W016eLksSLX6hd0IChL0TrkQse6q+c4THKwWT0+XgdSvYApPH40F4k7swdlTiNzfcuDRsJ6hC025LVhSNTXRXAS9dcOkCXlDRRJe3iQ7Ryv0+ku4dPY4basmms0O09jfSbocoC3DtaBgmCmXuDHbi7zgYJcDqR4miXMx0Kpk0f652i5rvcclSvneyx3hEPq4nD1SdNAeRtFy39W0WSOcZlkDPWsZh2l+ZlIS6R97zZFaqh3CK7Xo3nh7UcScLVH1W1lGZq8fpvNdZZS0PKnLmbUwxzaSUBLQDnMU+aFxn7le8DhqlagChVa/t0iPTPYElGnRMllP/qno+Np0YiT5W4xcf5+VgnsUALP8e4uakQvuzjlSpSzuqB9JXlADAmcJAGczAGADN9zaRWhE+jd7Etf03ljONkOf2q8PrD6yJjowbHF5SmdmjcPijN4l0//ucA0msOXmrXZlf9HeAOsSVLBllGHIwUaoXw266Qy/z+FVqQC43OA7pAuHfRFyNriqd7NEVz/sQCUG0Y1zUY+AlxGEwTvU13p12Kh2QGeAdJfUzbNUHzZJq0n4WXI9UgiPsUpV85MhHOnZ2LIAa3O4ZI2fIOW2WLHcx6aWhXEA+cVWsAWC80XWLjQ0vA7U4EBrJ60FORICNQ585xV2EOjNTKNdblDj0Vzz6ggXPb24suTaURi40PsULZwwL545eNZEEbkqc+j3fSN2Q72VwPUVRz4BEOM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L1pab3IrUjllRnpKYkROaGVDSzlHTjBzS2tpZXBXQjVGQnpyMGZ4Wk52?=
 =?iso-2022-jp?B?bGNLWnVwKzlKM2FyNFZSYndoUmxHb3JacUQwZndOV25ZNUFjSHNvdUlw?=
 =?iso-2022-jp?B?ZFg0NUZldHJ2YXE2VUF3ZzlmR1owK3Q4VTdiTmNQOHlwaE50V29JUkZG?=
 =?iso-2022-jp?B?R1dXQmlqSnUySExRR0MzT25HU3Bub29LSHBtcHBsaUN0T2RzY0hlYnFD?=
 =?iso-2022-jp?B?TFV6dWtNeVNqTk1OUGJtZXREdXc3K2dRdmZ6dG11RmxLbHpyTE1SRDJj?=
 =?iso-2022-jp?B?R0xIMjFWb1RkcCtWa3VFaHVDc3YvRm1MaDQvUHlXYjZlTFZJTjZwTXND?=
 =?iso-2022-jp?B?SVlQeXFkdk9XN3p1ckVUR0luT1RZWVNNQVNTdVN1aCtUWVlJVzVYeDJP?=
 =?iso-2022-jp?B?YWdtTURYcnFUVExacEpoRHBaZDI3OXQzRktrMjZTd2FGdjMrWTRNeDk0?=
 =?iso-2022-jp?B?TUhKdGdtRFEyMlVCNGt5Z1VZdVpIOGNmUEVtMDZJR0FtejlkRVlDS3Ra?=
 =?iso-2022-jp?B?UmZwbndHZEVBdXpPMDNpazNCYmVtUXNCM0NjRUhpNjV5U0IycTQvNDZQ?=
 =?iso-2022-jp?B?aFVOL2pNOGdIQnRhdmsrSndSTWxNL1h1NHVxQVM3cmE5SEFWVFlUL0NF?=
 =?iso-2022-jp?B?THdJNHk0SXFmbGQ0c0kyenpiNlVVTHVFdU40Y0tPNWR1Tmp4TWx6VkhG?=
 =?iso-2022-jp?B?N3o0cE1jTVNaLzdqTllJZjhwSnZXQ0xKNjJKTk9MdFVCbjREcFVGc2Mv?=
 =?iso-2022-jp?B?THA2SytpcEdtRFYvczgzQjBiV2ZFaVhJaWE5SjlaU1VWK053Q2hJcTg3?=
 =?iso-2022-jp?B?MEVQWHNuSlZWQ1ZYZUhKMWwrdFhjVjNKbmtxRTBiMlozZFZVRGNKK3VD?=
 =?iso-2022-jp?B?T1BIcVd2RkZ4a0xYU09WUSswZE9UNUxQc1pTdCtxWWh2ZWc0ZHppNDB2?=
 =?iso-2022-jp?B?aHVWZUNMM3pVVUt6U3R3U2M0TGRzMVU3Y0xKRGt1RkJITEc2TWlrVnhH?=
 =?iso-2022-jp?B?YjdLZEhkYzgwSmRqRTlmMFFOcWFqcmlNUXZnSzlBQ0dJVVlMcG5yM2tu?=
 =?iso-2022-jp?B?OWJZZFNTc2E5RWtKeEcrcG9SRm5JL2hXQU5MQ1ZBR0d2Q2FhR01BUkhp?=
 =?iso-2022-jp?B?RG1lQzU0UElPcnhIWVUwckxTU3oyOUxnb0dXM0ZPRHMxaGd6WmJGQlR5?=
 =?iso-2022-jp?B?YmdXbytWQmtEM0hqVm4rS3pnMVIwTkpwc3Q4U085bW9rTTZaNWRMbnAw?=
 =?iso-2022-jp?B?OHlQQ2NNSGFxVHZ6WmlSL0U5ZnFzVDRFMS9sdXlqV0lNWGFGRnFWaVY5?=
 =?iso-2022-jp?B?RE1yU3h6SXk0RzQrZCtOaFlYNU1UM2JnVFQ1NDV0WmZ5ZGg5OEJOQ1pW?=
 =?iso-2022-jp?B?RFo5SUUvZE81MTBoeHdhTVFYYkw0dW55Tk04cElXZG5BV0Jnb3dZeXVW?=
 =?iso-2022-jp?B?ZFRkUHRLNm02UDBtNThVU2tRS2lUZUh1M000SzNnOHRycXJJVjZqYXg4?=
 =?iso-2022-jp?B?cTdQWE9iYkYzWFc5emloY1NKQldFbzBrZ3M4bHJKV25haDA3TzNvYnJa?=
 =?iso-2022-jp?B?Tmg3VXRSTGFOVVJubWtsT1ZjZE5iM3F2ZmtMd0FNNDUyRTNHNVlBaTN0?=
 =?iso-2022-jp?B?YlpkaUV3TzkxNHlCWXdBMXRSc0xDdWFEZXlETDg5RnB6aHpyQk9JSXJ4?=
 =?iso-2022-jp?B?S0h4ZnpvOERLSGRIa1hFU2xKdnRTSnViejZ1NGN4Q3p6dUl4YWRRcVBU?=
 =?iso-2022-jp?B?cXc3WnNibjJqL1h4dWR5U3ZwRFM1ZjJoRS9zcllHNWp0NEh0UEJCb05K?=
 =?iso-2022-jp?B?RUl0UzJMSExrVUJSZmlYK3VQSHZwWmRBOUdXcUF1SmpqRHhlTVNZQmxh?=
 =?iso-2022-jp?B?TCtFejNVMnhXRDlGSDNtNHFqQ3NUcUd5ZXNQUHN0ak9KaWxHRktiblhr?=
 =?iso-2022-jp?B?aXNDKzR2T3BMMlJvSmZjd3BMVGs3T3lKeDVIbUUvV3QwNTVDN0ovVWtB?=
 =?iso-2022-jp?B?UHdUd3dCampPanh3eGdyMHZmK2N5RHZjZis1TkViOHVHUnBXOWN4bE5O?=
 =?iso-2022-jp?B?N0RMMjVPalQ1T3Z5dG9rc1AvS0lMYjl5aHV2M1hmMDBVY3V1dDJKRXBL?=
 =?iso-2022-jp?B?dzhhNHRuRUNsVm50U3JWaWdBQVV4SXpheWVqNVgyQVo3bkhjemNYdXFp?=
 =?iso-2022-jp?B?Y0pPUWs3UlEyeU4rUURjM3ZHWEZHV0g1OUhsK252eXVLelNDaklnQWVM?=
 =?iso-2022-jp?B?Y21nYS84SENmSUx4TlY3UnYwTkRBOGhHTTZlMjVyL0Q4KzB2djNMRWhz?=
 =?iso-2022-jp?B?YzRjQTFTc1NLeFVZQ2pKY0ZvNmJjVjlaTm5zaGFnVzNkZmo5MlZRK2w0?=
 =?iso-2022-jp?B?NWFZMmQ5K0pFRzk1OHBlRWRUVGZRbFZKSDdKNWZFOFRpRGJSQitXK1Zz?=
 =?iso-2022-jp?B?Njl0MDVTQzdiNTdmdUdicFk1bE9Ways3TWNxZXg0WkR2VWMwUHZZNzdW?=
 =?iso-2022-jp?B?M3FVWTZhZWRyR2UxdjBVOHRtUCs1cjBMeEIrNUc0c1poc1lPYWVQeEI4?=
 =?iso-2022-jp?B?Nm4xVFBaRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Swh8Ooo2qluMsAtl0VAt32C+jfFVKElHi8ihbxFZ0X3IzJr5q/jcfyRkpZ6bdEGCtAMBMdqUGqI8y+5U4Y/9hdHPjp+bqY6kbcTGeUrFKkCVPCzKVdeZim6L9iHIeP1ofjUwRG0AvrPGUzfUTkCaMVoKR5VpGB/lwSvtKa1GlBtIWHaey+fx88KQ2bcy9XhfqyUvSCzO1EHwsTGMtSU+Aa0fVL3niTSzGVhlMCgwy52Q+Wb8ZSoufFbeOVJYaKxC+qUdTtyuKjfULpdZCAcoNPzSW//YynduGorz7Q23g3E1Cf6RYY9WvScKLTgC4T+VyaNEM8Ur3dYpPrHbgcRyGA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3302eb87-e4e0-4aa8-8b69-08de898567a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 09:11:59.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91nve0pf/FMzyUQUjBV8EqbXHi0m2YPnjO+wM044u9e47MB3l/u81juDSNIRKYGlbxQwoHFVZNjQngmoz8x8amUoUs3TvBGGrPYFKHoRF885v5Zn6OhG9vdMGD5qyiFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 09:12:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22536

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Thursday, March 19, 2026 5:48 PM
> To: Nobuhiro Iwamatsu (Toshiba) <iwamatsu@gmail.com>
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com; cip-dev@lists.cip-project.or=
g; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T=1B(B
> =1B$B#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek =
<pavel@nabladev.com>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g=
077/r9a09g087: Add DT nodes for SCI channels
> 1-5
>=20
> Hi!
>=20
> > > The RZ/T2H and RZ/N2H SoCs expose six SCI controllers; sci0 was
> > > already present in the SoC DTSI. This patch adds the remaining SCI
> > > nodes
> > > (sci1-sci5) to the respective SoC DTSIs.
> > >
> > > Note the patches have been picked up from upstream and manually
> > > merged to resolve conflicts.
> > >
> > > Note, these patches apply on top of the RSPI series [0].
> > >
> > > [0]
> > > https://lore.kernel.org/all/20260309150619.761962-1-cosmin-gabriel.t
> > > anislav.xa@renesas.com/
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Lad Prabhakar (2):
> > >   arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
> > >   arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
> > >
> > >  arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 70
> > > ++++++++++++++++++++++  arch/arm64/boot/dts/renesas/r9a09g087.dtsi |
> > > 70 ++++++++++++++++++++++
> > >  2 files changed, 140 insertions(+)
> >
> > I reviewed this series, looks good to me.
> > I can apply this, if tests are OK and there is no other comment.
>=20
> Looks good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> Best regards,
>                                                                 Pavel

Thanks, I applied and pushed.

Best regards,
   Nobuhiro


