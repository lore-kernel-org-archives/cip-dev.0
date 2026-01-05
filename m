Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E81C2A079
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 08:57:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60517.1767603424860962880
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 00:57:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=S3X/v5Ta;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.50, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS6cpu4UibvEAsDqhcYBPMqHirfaykP36wjM7U3kLWJVQsxEqAJ+7vw6rh9AM43AUaZ15Aw1RiehReFg7YaWHpGtCA0fCNSIXjvBRjhzNC+CUjLkDrLkKaD14XMxtMdVCHyetaqLGPjRbY3CW+mQfXPRAFAkD8XeczmVGF062ZFtV8WQ9CESvJLpzlzpl6ZK2wQZCSWeZcRNbmdKvQEjqoWnkfioVW1QhzWvhYrhsvIvvZgd5wpGNXx3pN/3qoSVKdUvI4qLX6/pVobyI4dnoVnxrctKOwj4DYWlgw8H3C9YidZcsRMwzxRsGf/vsPoqtJJbQeRomEH0qUQ+64DtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8TKkJikXWQE7zqrC2wI48BIwwz94zQlanN82bGtNX0=;
 b=r79lhy//ZusEEcMk3B926AbPdnpLS9FxWiVClecZSOz0OSoxOHRznPKxYO7MDKxxLaiXaSTRMbMwKURG6X7Xmeo86dgY1yxVUFKogSAZ5uDSE/qf7ZbX/OVUIyYxMIx5gZNYJ6UldRDCEclzOK6iktoVmgRChoHaP+Muv5hJ6apVLBCh0KXrn98yyM3sE/hCmBzsATuvj8Ey+MyuNuYF9HyP6CVWAkFJueATvA1l+HizkI83UaiU9XlLfcPQ/xAHFxfx3+wEjtUN6w05PxFRdL4ylljRLg0Yp2aYHYOFJAIPlfKZrbauvWimgeQc+w0BL6Sy5EfrlNmw8UQzHMNTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8TKkJikXWQE7zqrC2wI48BIwwz94zQlanN82bGtNX0=;
 b=S3X/v5Taf3WRgF0S4/NtR3foXZLOgmtWEdUUS2X9caPSWmDoAaOW1Q9geWIT/j1LuuUR5E924iqXYH3+HXdVE4buoqJYveCGPLujcaRktF3MpDNcEt8+BuiQO+euPdzZvkdWGE3b2LjXP+9oBKQc5HqBkpKG7QSd6U31Gb6l1QA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB9380.jpnprd01.prod.outlook.com (2603:1096:604:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 08:56:59 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 08:56:59 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	biju.das.au <biju.das.au@gmail.com>, "pavel@denx.de" <pavel@denx.de>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth: Add
 .init() callback
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth:
 Add .init() callback
Thread-Index: AQHcbyLtDmWrq4MzoUiD5y8lvBCts7Uxn7mAgBHESpA=
Date: Mon, 5 Jan 2026 08:56:59 +0000
Message-ID: 
 <TY3PR01MB11346085A1D0ADA73A4FE5AC08686A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251217070100.3680-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB148186310F13C51C8FCF15658CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148186310F13C51C8FCF15658CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB9380:EE_
x-ms-office365-filtering-correlation-id: 2db979d3-5bcb-4d5e-48f7-08de4c38630c
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8PdOSNC8zvcTIs+ltcKCqh5kbVdkR8nDO6oopENfmSB/jzeCPWJ3BJGLvmn+?=
 =?us-ascii?Q?3YmYR3zPj00t5bydig3XKG2SAsnRsg13grqG+hkdWj/hSmbQmvi9gKJ++oLk?=
 =?us-ascii?Q?Rmo6d+RxI6LHRqHBZN/EPHWJiA6Yv6yfykpfAf7Zc2CtrI4Ul17wUysgeDiB?=
 =?us-ascii?Q?6cWfBf7iyDQ7te17HDXvT3GZ3E1b3f39nVIY+F5pHFQlkJTYOCWie9x4TPb/?=
 =?us-ascii?Q?5epgHVhRISY4BalahULwwDMTBdRBfGu9PwT11yLH1gJoL7BbAr5+638mqaSb?=
 =?us-ascii?Q?y4YRx6EPS2ODDsosu4PLls5UBDBID8W/mrvIi0tDBpTehJPCV01r1Upp8dW1?=
 =?us-ascii?Q?1PtcU/7k5xhLhkq4gi/y5eV9CDB5y7xXeZ3jpJFEirgSiiv0nw0veN9uj3ba?=
 =?us-ascii?Q?ziWuaZi0FevfebX6AHZbdXGf3lfY5v9rTBc3Iyfmp3XUdo7KV47pR/0RPgfw?=
 =?us-ascii?Q?S6XyTV2sd+bkJjg0gpVT3e2ALA8jRFMGhbKxrfbkVzt04nmvONkukXumyL8n?=
 =?us-ascii?Q?L3COysabrdKdUN0mJHmp63bgBKNMAJbWcGM7ZijMlWILyqVGax5eMfZ2GCY7?=
 =?us-ascii?Q?fadhXX6mZQtxPyztaPb5pU0V/vVAQlLf5IH0oIIHpr8nrP65OTDibykoh3j6?=
 =?us-ascii?Q?OeXG7CoYwVKp3IZVmvt23IRPVTipghmPESJXBpiceH4kjvGRmOv3qVwYn9Qt?=
 =?us-ascii?Q?fYOgrL0cnGpNBhA8azZqA4inFpxL6Kd+MiACPYj7/wpinua+TU5RZe7UuXTv?=
 =?us-ascii?Q?dTDS8MGr5xEC35q0aZXxlqWk4d3JJH5zEUHjP9OJ2/5e4ZnNZweUhEnuXX7v?=
 =?us-ascii?Q?pwaphPIfGnNk02ulKJP5wVOHuFQSNKMXVHVAYNCzAWJr8ZZZc4HffK9deABi?=
 =?us-ascii?Q?TM3+djPl7tSxTvRLBS7SXImI6JmcjR3YPD8Hf1CKYSv50mZchTuTpbgyLLsl?=
 =?us-ascii?Q?w1nndDFKnhOVk+5birMYr/ESV+j5t85ayUA9x/6bYd7ST0FW48PAUJ4YLxpK?=
 =?us-ascii?Q?cblfjF14QDpPvMFfDmpV6OLTgVxt5tVIFFinUmWBpHZLRFrI2QfjZumRTzla?=
 =?us-ascii?Q?qhoPE6AkBBFYwicOMvuask/U2ks+0l0eQYJgG72JjxQ3rd9eoTizjOh4ma3+?=
 =?us-ascii?Q?dmQis3FY1Wi+BIJT0iVSxYrQ1GWb+HvAsYj9FXPVXAhXQePJRzHv23PG2xV5?=
 =?us-ascii?Q?NyodMIrWnEXRCCXx1Ki/Rnp8l/zcubs/da2ZU3+3nfQHh3fK4NERGVOj10rl?=
 =?us-ascii?Q?0uoIVAtN6xFLtt1rUeqgD4TW3acfDVkZWZP8W1SO37RJOTW97pARIAPf5Phs?=
 =?us-ascii?Q?4rT/s1na6vmuxPf/GMdZtwH3oIvTBSPKh5uDap0rTaw9TUgp+YtGQUQwj+IV?=
 =?us-ascii?Q?Xt78LDr+/8rKJtkoA3St6zzJXx+U3AGPF/vp+yt/BsaGEzH9krJS7scMuH6R?=
 =?us-ascii?Q?FKc5PwNzKX6lyepOnT+hI/0tHVETzlbLXzE7rfg58dnYNU7VSpQO+L8HB4Ew?=
 =?us-ascii?Q?ii7nVtOmuR0n8fMMC1P6lkAhLutEt3L6p37h?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?J7Yi14qBfW/xcw719RXQysR4qyzpQbvnhv64/YzD1yfQj/jFwouoTUd3PZ/4?=
 =?us-ascii?Q?wxvdxkh2Cf+NgCpVncn/jS8YTp7cPOCVS11Rfbf2s41UEqPPlTcnZoxBmHJs?=
 =?us-ascii?Q?gfFUYwGhvaVYpe1HqV3JNB7Nzy00g4nH8S2+FiE6y80UEgfXdXuyAgWFryEX?=
 =?us-ascii?Q?jMRkvDMaxhHlMu6aCv754npNmJM4F+kEGA1KL2KY52dftbeb60sGGoAvnaNs?=
 =?us-ascii?Q?1C4o3YgpA6QJxhpmQRtL0SPLu3r6gqfOJhzOuHR8Wuo7xMcTiy4f8dRmJe+b?=
 =?us-ascii?Q?RuxCpvEyRXwpVfOHUmg0xYlTterjNQkMolhvKA7r4u/7mIS7pMwcFcpHzxJE?=
 =?us-ascii?Q?smS0snNDReRiOxCrB9y7TCmLy5BozSqn+ZsA1ALQ9HutIWmHxAWU2LBZTSst?=
 =?us-ascii?Q?iaJMsE1yZuC8jnIg7U0ox9IJcjUV4vp+VaHn8HkrJ7ptlaAHD7Ywxsrjj0CO?=
 =?us-ascii?Q?YigdO/f2N4iRPeu8QvY8smZYwxYto06AEUrDBB+7fIToAXgE2ckTZcNOEKUl?=
 =?us-ascii?Q?Wh5zETfh+QzNT2J9e26hTK/lQc4TL02polqK+ZrjGv1kPpIk0pi+CiKqe5Fb?=
 =?us-ascii?Q?oq5pn8FiyMiRGrrdoss08JIB/HZTsO0fbvJ6TJ1iUm33eEyV0ctR0CYCNgJR?=
 =?us-ascii?Q?4oXQ8wfPBJKZ0yuaN2sruJcUP4/tOoMj9BN0Lb3BqrMNujHPZzkK2CgtwEIo?=
 =?us-ascii?Q?M6fgduu1Am19209Hx+2dmDFvY0397WslJgcfVa5SrGIAisbVCWwZ6Bqu9xF0?=
 =?us-ascii?Q?Xg8R/x7Sjr3+mlkL9HxtR5kkRZbir8PcUHjnuTCUGoW1dB4hreUPw3KhdnMQ?=
 =?us-ascii?Q?MoIQfl72gtLWxLbir1xZ0LmUGZO7baKQiiYfUPq0mdxrCuXZRgsyi0A3JTHY?=
 =?us-ascii?Q?2NIV4+RX5a7zfuB1QkQUjLB1ANer1hkx07n0NaB5sKPFch7ePwAT2sBEEPta?=
 =?us-ascii?Q?lfuylV67zsng6ioGMAdPikyJS2dWRL2sjKN5U0Eth7FptzWhDkpBSlnSKsyZ?=
 =?us-ascii?Q?YiAl/uctFhxkv8QrMSoF2WcZ82f7g8E1QOO/tisZ+ZdnkAbb/75/jLCEVHvt?=
 =?us-ascii?Q?9eR5gUO0oGpmZEAUqVR3xoyGXA/hLlr31HuEpVH0hPMWt+LGIi7jeXEwpYCk?=
 =?us-ascii?Q?uvJsqjsHigwjgh1ndDLrORROrKVTGWvcNrA0TF88uGd/cKIpN1c8IuGOSIbb?=
 =?us-ascii?Q?oc5xcKlNzcNqXUSLBfErTp2p0t8ynsWLjFc2/x9tkFEytlH0khyKsKR8vMte?=
 =?us-ascii?Q?G+ECRjV8iRzfBiNRMJas8pSMCHDVf6K4v0ME5m+AzTdEpyUz8s7KWyLOsIqF?=
 =?us-ascii?Q?GjJlmao+00TtRgXYNuXXOXPgenXEFRaJtzQe54rhnCo5XpZLVxhKwQFBfz+K?=
 =?us-ascii?Q?VuNJUf6vEor/g4OD/gsBg2CTlB01KZ8Fxmg/kcsxzm2ZNR2TfOQcIOS9FYE3?=
 =?us-ascii?Q?G2eerZKPLprKvKE+VnTmVOtZ94LBzYa/6j0sMuqBseZk7kmCHZ0y/nyp7E1U?=
 =?us-ascii?Q?DgnGAMY0hn3QblFHsUfujJJ2gUlN72fb8DV/XA0MrARA3QLn6XwS6NCUmQbP?=
 =?us-ascii?Q?sp1MYZOKlo8c1BrCG/6Bsxe5KtkjCNhrsIYZAZ6YUMdismbJgEVq7kcwoemL?=
 =?us-ascii?Q?iwjTyIl3nYKbX5tfwzc5MNR0jc9HzZhVl6Ej4/mOM3mivNpkFDwhXhYYgIZk?=
 =?us-ascii?Q?S+Rky9Cih1a9uqDTGLnTl+LzZUhbY5FAUoUw/Yjl5xEby6TILfKZ8+5II7Ut?=
 =?us-ascii?Q?Gh0GHIFtdQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db979d3-5bcb-4d5e-48f7-08de4c38630c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 08:56:59.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nE3bSNWU1A49NE4aI/IeJPiib/kliFM+81BSaoWeOL9uMWA72XtV4BxYIPRlJNLNnrY53dA0Ssh4teS2DWjW747pytywwTwGGvRTl15VVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9380
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 08:57:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21307

Hi Nobuhiro-San,

> -----Original Message-----
> From: nobuhiro.iwamatsu.x90@mail.toshiba <nobuhiro.iwamatsu.x90@mail.tosh=
iba>
> Sent: 25 December 2025 01:37
> Subject: RE: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth=
: Add .init() callback
>=20
> Hi Biju,
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Biju Das via lists.cip-project.org
> > Sent: Wednesday, December 17, 2025 4:01 PM
> > Subject: [cip-dev] [PATCH 6.1.y-cip] net: stmmac: dwmac-renesas-gbeth:
> > Add .init() callback
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Currently clock usage counter imbalance occurs as .exit() is called
> > during
> > suspend() and there is no corresponding .init() during resume().
> >
> > Add .init() callback to support balanced calls across suspend/resume cy=
cle.
> > While at it, avoid code duplication by reusing renesas_gbeth_init() in
> > renesas_gbeth_probe().
> >
> > Fixes: 709bdc1cafe2 ("net: stmmac: Add DWMAC glue layer for Renesas
> > GBETH")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  .../stmicro/stmmac/dwmac-renesas-gbeth.c      | 37
> > ++++++++++++++-----
> >  1 file changed, 27 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > index 42cba9dd967c..5c591c7215bb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > @@ -31,6 +31,28 @@ static const char *const renesas_gbeth_clks[] =3D {
> >  	"tx", "tx-180", "rx", "rx-180",
> >  };
> >
> > +static int renesas_gbeth_init(struct platform_device *pdev, void
> > +*priv) {
> > +	struct plat_stmmacenet_data *plat_dat;
> > +	struct renesas_gbeth *gbeth =3D priv;
> > +	int ret;
> > +
> > +	plat_dat =3D gbeth->plat_dat;
> > +
> > +	ret =3D reset_control_deassert(gbeth->rstc);
> > +	if (ret) {
> > +		dev_err(gbeth->dev, "Reset deassert failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_bulk_prepare_enable(plat_dat->num_clks,
> > +				      plat_dat->clks);
> > +	if (ret)
> > +		reset_control_assert(gbeth->rstc);
> > +
> > +	return ret;
> > +}
> > +
> >  static void renesas_gbeth_exit(struct platform_device *pdev, void *pri=
v)  {
> >  	struct plat_stmmacenet_data *plat_dat; @@ -91,22 +113,17 @@ static
> > int renesas_gbeth_probe(struct platform_device *pdev)
> >  	if (IS_ERR(gbeth->rstc))
> >  		return PTR_ERR(gbeth->rstc);
> >
> > -	err =3D reset_control_deassert(gbeth->rstc);
> > -	if (err)
> > -		return dev_err_probe(dev, err, "Reset deassert failed\n");
> > -
> > -	err =3D clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
> > -	if (err) {
> > -		reset_control_assert(gbeth->rstc);
> > -		return dev_err_probe(dev, err, "Failed to enable clocks\n");
> > -	}
> > -
> >  	gbeth->dev =3D dev;
> >  	gbeth->plat_dat =3D plat_dat;
> >  	plat_dat->bsp_priv =3D gbeth;
> >  	plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> > +	plat_dat->init =3D renesas_gbeth_init;
> >  	plat_dat->exit =3D renesas_gbeth_exit;
> >
> > +	err =3D renesas_gbeth_init(pdev, gbeth);
> > +	if (err)
> > +		return err;
> > +
> >  	err =3D stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
> >  	if (err)
> >  		renesas_gbeth_exit(pdev, gbeth);
> > --
> > 2.43.0
>=20
> Looks good to me.
> I can apply this if testing is no issue and there are no other comments.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2232108=
556
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Gentle ping. Can we apply this patch.

Cheers,
Biju

