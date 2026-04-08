Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A85105D991
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 01:15:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.96531.1775610902291239493
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 18:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=QIk/Ky32;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775610899;x=1776820499;bh=itRjJAhYCYVMTLXTpB1NO9MjW77Q7gedtmnM1
	ljRxqo=;b=QIk/Ky32HpvIa1sg1x6EQ1Lfcc+VZ9tnTdKWlqzPr8yADi+ZLcf1oVlqrUh+c3R67eX
	qdFRuOEJrE3EIBr9RhQZZvhYrAbyD2RCuDbO8aEPHQtP0+yNka9DjU29XOM5IT6Dh9ApE9fKGOlgT
	Lt/qIKPAqQ/OH70rZRzI3Rb3jhjQLv6W44k7dDRsRcKJjQuyI9V3nrLLDQOxTpd+njN5KLtw5XwUk
	8w3JBmAC3zqQE/7mqbmZ96+sHuf8ltTW2OKuR5adA8dvK4ieWlvCuvsbqkn2xPK0wX2levJSdgEW4
	KyNMU5Mo9/R10gjl2lYvTow8n/PTDQIHhA7P1uPTfwCg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6381ExgR3297476; Wed, 8 Apr 2026 10:14:59 +0900
X-Iguazu-Qid: 2yAbslxpJ9XypKMOf6
X-Iguazu-QSIG: v=2; s=0; t=1775610899; q=2yAbslxpJ9XypKMOf6; m=FiYIsjbPZYjyZOUDQfX27Z/RQ9EjrGJTrab0biW7Pdc=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fr4qQ6FsrzyPZ; Wed,  8 Apr 2026 10:14:58 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xD08Fxer+J0FQGSljVCEARS9Pb2pGsrk89IBB+9szHUH2qSFjTrsfsHCKG680c/2W2F4qggZTdl5eMR6LDJQfit6GWctIhc2FC66sORmy91wYCAwoK6C9RNVN+vkPQZRRm0O+JqZc1Xk0fbvg7VHWfoh92/zb8+nSopq3lIj7FjOjNjoyalfLTONx0CRyrEQMB2K2ZWQm5KQK7IuupJyX/G+dYgotJU1Vy4MdLbe2AAIWrUlMiqPPQl7KshzmFzZMoIoFMjpD8gM/4vv0ijNoGmwM+Fx8PlnKnA1VM7YLy9jcXLl+nXJW7oXapZgBk1jdGrKnGSeYesvZm1WNACwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGSyazepbnRjjX+h+PVhlkGVArpdMGN2ZCr52SvQ/xA=;
 b=nIWBwpjWctEBeWPd/tg6RarjRVvx/IL6A4zhBMgVFJ9EtNz9D9unfnmUOfL8pVuFdB0scT7pSPO2WMzccCL0R6s79grtTQFIPkaA/7QfpJQool1R0N05yquzVXL5y1oqItUNt+qYsxVUASV6iwMpVctCk0JYi0DFyY31P0U7iVoz5iVFra6xeFjYoeUK/V8sH+3MGo/fn18OzNaXY60vS+/f0+PVIh+bMp7exps7oMm+RNLLWOjFJlreKyj4uE+RzAo3fy8MQiwbhhnvmFYa4OF/pGEBPmls7Ht1i/Gh/p9XKErQIacxPsfZYdYCTONtZi4bLCrKp9Vz9STxKShlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/10] Add CANFD support to RZ/T2H and RZ/N2H
 SoCs
Thread-Topic: [PATCH 6.12.y-cip 00/10] Add CANFD support to RZ/T2H and RZ/N2H
 SoCs
Thread-Index: AQHcxn1zfzmxoJqXs0urfMN+U7yH07XTfHUAgADgZUA=
Date: Wed, 8 Apr 2026 01:14:55 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B1FE8E5C467B5C0210F9CD5BA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <adTvgIpQ8U4hKUxL@duo.ucw.cz>
In-Reply-To: <adTvgIpQ8U4hKUxL@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10352:EE_
x-ms-office365-filtering-correlation-id: 7180c73c-9d50-4047-159f-08de950c3ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 
 PZtF2xnoowC6GxLrTVPCG+cUlta3WzA57DP7gLsAsGnDtBWlncEDrrESr3eQquLWlXWDfS2Z/y0DP6czHozLwLQwB7GSwHKBlDDRHzADy54l2T2Re++YWklFgLe/JIZQvewnyYmUMTu7l3J7uOW3/5miVdTrjn1C/qatEt2AINkerjUNw+SwqEZiwa6Z0WN3vlSdHupoYAsM8XrNZhZJeGkd4RQtQvDVvC6M0LfxAOIIQaq3/4EhJxXn7cAwoBgv1i0WS/2+fUrQy2joMwlGIpi5Um+wE9pIBh4cCyYXrdJjFA+RLG1i3gAjZfvpo17kpETi3bNpEgXux/KQTMfqDsNSZje9L2SSwgcs5rzRPWC5uShf2ci1gTz5sSUkWys3EN3rCih10oYkaDhun9/FGHx6pGzLda7Q0ewzlTaXmag/5qRYz9Ns54qRPHlps8HsyHqMshq0cqaxLg1kG8UxzIFV8Nf/uE8lZsk0PcUuyePBHy7Lv3lsJusUja5TyR4vV5ef6+Ugb4GuOaGctsozM2EPCUBJZ78xxAhOksK82fCpNmSEF0MBrF/rFS2s+69RoACJk9VmTmN54Sj4g4rlVnmSXvS3PtGEMOe7l0+G4DyF6qKm+p7moAW0mdgDnm5+0uQpBkR7aBLTuUr1CxUUpa63r/XZ0Ga6cnFEOEzY0Q/hDt5ODu6iTMrq0aIGbOQAQU8cVJkWDEWFLlB71l2Thmh7T5zvjXPHUwNZWXhm5paeMd3X0tsxIf1fe8ZkT3LXq+xOy5EHGpolfPUoImW0uQjOETXXpwedRGS2F6I3hm0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MEhoWVNEUUM5b2dHNFVvdlVEM0NrQzVYNXJWdzRPV3pweUx5MGZPS1ZC?=
 =?iso-2022-jp?B?NmtlZ3Z4T3NxMFpSWFdHSmRxTW8vSmJOb3dvNmE0a0xBNzMyaTk2NTBQ?=
 =?iso-2022-jp?B?NGxVbkRzZko1Umd2RnN1L1hPSWZpcWVuZEdMdDExaUliL3BBcTZGbGh1?=
 =?iso-2022-jp?B?dHJjZXFMeXhBR2ZVV2IzSXdXemd3eE5iZU5mS1hwb0ZjNTgwb2hIdFpL?=
 =?iso-2022-jp?B?dGtlS1Q0WXBKY2pSWSszRlJDU2hIbWJWbGtUazF4UlZQZWFkWmFYZ3o2?=
 =?iso-2022-jp?B?blpOSDYyWmRLYXRqWnN6N21iMERrM1lZN1JRcjhndCs1S0FhR2NDeXRO?=
 =?iso-2022-jp?B?d1VLUlFCYnptRVoxV1JxWXhiV250OUs5RmdkN0xDWkdXVE5uMGVTZFFn?=
 =?iso-2022-jp?B?RXE1cU03L29vTld1dEcvc2N6R1orSDBFeitlM1JNMVk1K2xTeWM5TWNU?=
 =?iso-2022-jp?B?WVJNUWZyR2pHRkJKTWZsVzJPaVpRRVBEdmpoUFRZVFA0MkJ2QWRuY0xz?=
 =?iso-2022-jp?B?TWRuWUZKdHlqYWpVd2puSmFpbTlCaVBDUWJydzhOelc3RE9SQ2xvYnZt?=
 =?iso-2022-jp?B?RHh3ekZPTXFtbUppRXV4R3dSVk5SN3NwSHgwcWhGSTY3MXhkZ1VpOWpB?=
 =?iso-2022-jp?B?RWFFVTNNTzRXcFVZUjhicmQyMjhJVHJWODY4eFlwTHBYWTBlb1RpK0tE?=
 =?iso-2022-jp?B?c09POUZaUDJHR1BpT0NvdkN2dHlqTTZCb21EdlJBU3dQQlpVbklxcWZa?=
 =?iso-2022-jp?B?WG9POTg5T3lBbmZ0eUpXSE81UEtrYkE1ZFBvRVluUjJhUnNQenZwNWJY?=
 =?iso-2022-jp?B?bWdCV1FDeDlqYWJlNGNIZUM5ckRzVGc1eTdGZ1lrVVZZTURIdkhpbWJJ?=
 =?iso-2022-jp?B?anZaOERmNlF4RUxmeDVZeS91SHBoeklXclEwd2dBbUhtaTZkZ3JoZWlO?=
 =?iso-2022-jp?B?TWhqaVF4ZnFadHRmYVJ2bHFZcUZkZ04wc202R0hTeWNvZTh4U0pZelRT?=
 =?iso-2022-jp?B?MEdYelNRTlYxeDQvSDlMZjVLWExYLzBGLzdteWlEU3VsektSUnJSWmR3?=
 =?iso-2022-jp?B?TUNhTjhsY2hiRmgxUGFHUGpLQ2VEUXBUK2pDTEhqVUFsMk1wbnp6ejU5?=
 =?iso-2022-jp?B?Q3hNSnRLdUtMVllGNDVwNEpBZGhHSDFDdzd4WnJTVU9LaGxXR2FKeWg1?=
 =?iso-2022-jp?B?NTFHSHRFYStPTW5iZ2RqMFNsZyttTG1KZWxGWG1sMGtwbmx6eHNESWdj?=
 =?iso-2022-jp?B?NTRoZmVEQi8xMVNoVitkN05oR2lUYWVpMGdneE13bzEwUWpiVnBKTmFL?=
 =?iso-2022-jp?B?eDlQckM4WU1qVm40REZzMi9Ra1AzZllLN1ljUzZUQTBOaS8zU1ErL0t6?=
 =?iso-2022-jp?B?b1BhbjlnV2szVjFFUG5MalZ1TDhyQXc4MkJtUmN5MjdDUUtVZlJIZ3Nq?=
 =?iso-2022-jp?B?cVN4WnowTGFkYnkyVDgwdDYzanFNNFd1NUNLNWh3Nm5HS3hPemFwZ0dv?=
 =?iso-2022-jp?B?dE9PSDRDUkdRVDFaaFNTYmIra2tXZWF3b2N1ZHlwd2ZVbUZiTjJoUWpE?=
 =?iso-2022-jp?B?dFJBS1owVWllM3BPanBEelo5NXByUkFNQWg0WGZtZnhBajc0RjFYLy9L?=
 =?iso-2022-jp?B?cFNsSFF6SXlnRjFPdHhDSlRscWNza3hiVlVMdlBmSkJUZnVESWtxS1oz?=
 =?iso-2022-jp?B?TVVqaUovMVNtZXZqVzdMN3NrVkxqUk1HWnBnamhJRWIwU2FpNTFBSW1Y?=
 =?iso-2022-jp?B?enkwOGxZRWp3QmpTN1dETHY2eG04djBhckFjblNocFVQb0ZuUHhRK1lu?=
 =?iso-2022-jp?B?SXFId3dzOTVlRW9rSjQ5T2RUWjZRWllBVDAzRnNoVDcwdW02Vld4TWFx?=
 =?iso-2022-jp?B?QUVNNTVicjNoVFZ2clFyRjVxenBtWjVUdjlzWXBnR2JsVENjejhYZEx3?=
 =?iso-2022-jp?B?TjRkZUNtSW9mdHhxSGZXaFZnWDRJdHBmL2hxUUhwZW9OK0VvVUpTUHpZ?=
 =?iso-2022-jp?B?R3NjaExDMENQa1NnWlRJd0Z1bHVVTkxSNkp1NG9ySitkSXEyTmVzQWJP?=
 =?iso-2022-jp?B?bFFwYnVuK1dGT0p0TWRaK0kzclpoWitGME1QVEQrMk9wWTY4b2Z3dW1E?=
 =?iso-2022-jp?B?QTZwdTlydFZaUzd5eGkrUmE5YXUvamRCelVoNHlYMjdtS2RubXRrNkQ5?=
 =?iso-2022-jp?B?RFJQb1h1Rk1HUEhyTFNCQ1YrSW4zaTNySWxPUTR2Smg4MzBta0drSkJz?=
 =?iso-2022-jp?B?Qm9yZTJtaVREN3EvK3ROQXQvMXJOalF1cFg2dHB6WkxNK0swMFBZY25y?=
 =?iso-2022-jp?B?a2p4eExVWEo2RHlTdEtyZmxQazFrclVJT0s3b2tnMXZWTkJielFJcjkw?=
 =?iso-2022-jp?B?YWIxY1VUWUJudDdEdnE4Q0hHVStkZ09KOUZsVmZOTmFYOURBeG9GcmNZ?=
 =?iso-2022-jp?B?RWl2MSs2S05CQ01kVjBNSmQxU0RWYzdOMUdZUG5ZWmpzQXpnZ0t6Znpi?=
 =?iso-2022-jp?B?c2l2Y2xNU1YxWmpjcURPTDVISVhmQTZnZjR0cG1xTHBYL2dwNm1mcjFH?=
 =?iso-2022-jp?B?MDF3Nklxbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	EWPTedaWAT0WS+mhc2YTtnDgv7ET+074QqIDIvEoAHJJAS1A/i8cMVoPgoj2W8/Vcsz+FOq0zy87aaxKGx3VOa2unzTh8ZUe2ML5IprIcnwJjWpbFw7GIC4uuw2qPcLqleJCZhE+nOhG32kerP5GQzjS0CxBQvIreFqmztK45a3s7+V69ShMNiMfdt4sDsLu+PbABMmUU/6EGNcrBBn5flV4+aUK3YmwrgHSojm3LBC1sgh1ZS7RnxgfUR4b9bcq3PxJW7v63GB7sGdK17MdWYLTQ54lFpNR3PaFOSL4/HaAifEcs71OvO7LZWAaZGZJ5avqCjiBWLP5Yl5EXfjdbw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7180c73c-9d50-4047-159f-08de950c3ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 01:14:55.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CuVTA65YME6M/dT+6thW8JXXmAnwjC3ouvR2dKk2rCbIyVq9DOYW5107+My5VZB4JNGWIV+SUtj5zvhG9HzafiGD6Wo4cToe5HhVBMB1fSAzzGwmZigNU8JyuKxyqNDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10352
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 01:15:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22635

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, April 7, 2026 8:50 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 00/10] Add CANFD support to RZ/T2H and RZ/=
N2H SoCs
>=20
> Hi!
>=20
> > This patch series aims to add CANFD support to the Renesas RZ/T2H and
> > RZ/N2H SoCs and enable it on the EVKs.
> >
> > Note,
> > 1] All the patches have been cherry-picked from upstream kernel 2]
> > Patches apply on top of commit-id 7c78ffe0f95bf.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I will apply and push with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


