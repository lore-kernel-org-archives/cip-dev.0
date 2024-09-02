Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776CCA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 10:26:08 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.5])
 by mx.groups.io with SMTP id smtpd.web11.35619.1725272757832594758
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 03:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=q/eBMaL/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.5, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkxBlZNIp6INKA1auivEM1vRS9oZsezKFxUH4lEGg6AS13avqFLZS5/hKIk68HgEWWknedbW+jFgvmetx0sXdCF1eDHZlRU4APZVMDdrHpFoDUG73icdR+d7hq3usUDL7pf2bfWH0DRauLI3P6vm0NUL3ui0S6f3obcsePmNTYqJ5p9VQcrYSSm2qWGhK4Z5JsHiW+S3x9RCVYI6kdU4fuNS5EB4TMxdwoWI+cxSXCPupQ3fiEQoOR3EydcjWbClybm3iWJKEJkdAuz1Jn3TAsWTW7Nttm7oBGLhvm1Tb8oteRaSSiJpFii6dmq+53lbDFW6cJm+soQz2523Js1CJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6//61Jwp85yVvAFQz3Gkn7MWWXQGoqQJCS19zVKjU4o=;
 b=N3VitJbTH8OlTijZavEfSq/+KQGkUIA+14a5PV6c274zJxtjMNsB6BeaCJYpz/1zw8P82wJsRzJ0cOPlLUvpcXcEPnWL/9grn94vRp9Jq8MNN7jAyodV68/E5PJsK71vUeSdKmFpvkyKYYy2k7oaAC44oTSqjKj2sNW6LoySNJubFEeTjbdLzTlErrudrMdL+5KwNpNOAFjdve7Db8k9HdBczfQAu3ZT2vkeGpkIqJK0TKFReKjC1MbIDlsIPf0SsKCU50WT9EJbpcueV82C67Nsp+17R8l23dEXRhskOn3xcuWW8VeyslEeTxN/Nw8VCJ8fx6s2TNQb4B/UQaGLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6//61Jwp85yVvAFQz3Gkn7MWWXQGoqQJCS19zVKjU4o=;
 b=q/eBMaL/yIgajQa7DoiYHI9IJvzlAvD4EbLpd+qfyMBXcDVGlcBFmNooMEH/kMmnwfpe5oXrTASRtq+3b/dHIXy+r2ujTtXrU/ya4j+KC56b+6JrEEk+5ib4H8ojtAlUe1dWT/UuU/64Q5708KqZPt8IbJKgqjrDwGfQ/DlXxac=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6063.jpnprd01.prod.outlook.com (2603:1096:400:4f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:25:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:25:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Topic: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Index: AQHa51a1/DXyCVhcIkGLqZDjDGY1xbJEb54AgAAEfZA=
Date: Mon, 2 Sep 2024 10:25:52 +0000
Message-ID: 
 <TY3PR01MB113466E4088792C918A52067486922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-13-biju.das.jz@bp.renesas.com>
 <ZtWNFuw70nkB37EK@duo.ucw.cz>
In-Reply-To: <ZtWNFuw70nkB37EK@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6063:EE_
x-ms-office365-filtering-correlation-id: 338c1f00-5181-4f75-5325-08dccb399f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gxSBRlp7Ylap32SqaKQTyUxEwM1YAb2s24PIYLFws3rJGHPrpv7KuyH7zphZ?=
 =?us-ascii?Q?1SBuNTYbCiu1ye3CuapaIOOZev3KEWYvAmECzzzlfzEO6eHN1epIIbRg5hKN?=
 =?us-ascii?Q?+1kC5SW06pY5yRTEnjk7I8n3TF/FDk28kfpph5TjiNTjepX2631zcslL92I9?=
 =?us-ascii?Q?6M+LFvoDvNgYiP/Dse/wsShedhc8ZH+6NS7zPZPbkyRFDA+9qsciWaSoCjdw?=
 =?us-ascii?Q?FKPWQl4V398fazdBrTM/cp4K8tdzjJicSmIRd+S35bX8G3CXYb27CPc4aT54?=
 =?us-ascii?Q?2s9iaYAXTYtUdckUJcq9S2RP06K6UDJ38MZ/QfkqetzAyUfs9uJneVnpuFkD?=
 =?us-ascii?Q?ejBsOKUyvDxHCKyeo+HKrK5i2dgbez8X9LA3DA7LmojFCuQNQG9ah4MHDjRg?=
 =?us-ascii?Q?sgkwDByLu+BO12/3kdayJcJiBkmQztMH9faXe6XXaHeV0fwXIbmIYPrNToOO?=
 =?us-ascii?Q?dYL9I/8MXLHgYFyXqLXNHPHBtQtdDHnuQPT3kHUxa2PwqBQae3mu+naWNcXt?=
 =?us-ascii?Q?jBYOPXPZnIy1Q7AX5p/HKZKSEccs1kUZdalX+ygPrAlppVTFZAhOi+zlST5/?=
 =?us-ascii?Q?47JD2xW832Ltm2QBMjDRbVDBYAgNtGlIfe23vq5+TT6NaiC3/TujWvFFxYcD?=
 =?us-ascii?Q?ueeUz2zbeHuuQpOE+Sd+KbBbHCRjeigu5GCQjPRnAMuVBu2ACctKAGyYR5pi?=
 =?us-ascii?Q?w3pjWtYeuIaI6rumrdtjAThEY7UQ49Zh8W1BMjQ3nM5nsjz1eVF4krmO3kmo?=
 =?us-ascii?Q?I2kZ83o/Ex8XoPYqyk37dsh6Uz5PsvvQkSvhrRjW5FTorvI99x3otxYOg0o+?=
 =?us-ascii?Q?YoJUeLlFzEAPp5ubuDn/Q906JTWSVi7ICWhl2t0MNhUucQ3id7Hu8lpwG3c5?=
 =?us-ascii?Q?v4LmtCyAbSweVu02SBY+GfL/gb97KYnmX6kHNe9ImmPb0M4ynDSL2Id9NNJs?=
 =?us-ascii?Q?ODiltNO8NVGhkYsVAMkla4FuqqXLZS9061Q4pgk2CWRiYWZ/kraqYz/QeI41?=
 =?us-ascii?Q?pnzcZjjisWgYnItatUcMdOpGUUZFAibAzl45CXhsdo6LLgaExfjUiHo2qNnq?=
 =?us-ascii?Q?vT98mz6uNQkNsirh5rf5SVO/uQ2xDigervFljWRUm2C/7u4rFviLjA3IMVWZ?=
 =?us-ascii?Q?P8itG7WUH/IGBtJO0KHZ++7+YrQCFku1iGz1yG6PLEmjwbbqdbnJlEcOzaQL?=
 =?us-ascii?Q?do4R3bIM7AUwYYPHNfcNKTGKiQlRjCWZzTWoA3uH+XN7y20MTFBteiamvkfm?=
 =?us-ascii?Q?kCZNTt9vSF8jun2YXaRiP3pQPfrG2KstO9XOZX/Pak87mDDedrJDfG4Dm7A9?=
 =?us-ascii?Q?hsKbrL6gE9lVqIv+jEEeZiwZhyOLKfegB0JQMwhZW1V2kUeZCeZWEla4CMFF?=
 =?us-ascii?Q?q9gLJxlrh4BuROGT+o1FeY6pEwlPUZwVqNjqiy3wMnYS/PTvVg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pfteW6JAQEk97bxB0NHJK0Et8sZPtJG6udtTKjwq7WJLWB809/UhBiKY9EQi?=
 =?us-ascii?Q?6/VcQ2DRGEXcTwQhv0uYSPa7m1D2amq2MAlv9Mobk1ZkxeXVli7UczO29Ip0?=
 =?us-ascii?Q?OY6kH9id4MHWc+dkvjSyOvn1a/dXQ2M2wxnVTbST1x6lV99/bafyWicPjr31?=
 =?us-ascii?Q?TSPYLUlQ7x+CmImnURlmxiBHRYJYhQx/AtJSj59bk1B5mqWbIfByj0O4Jpb6?=
 =?us-ascii?Q?7V/UHXuJdrZBlSxU5cosp2qJ/Lgw6P/oTxOqa22SAWb7zsb6YEjpa/ayiFVR?=
 =?us-ascii?Q?Bu7wCAdTeCzmUq9NFMJUtmWqrKp5RGkI1+iCwvMqPUmkgXIF3wwQdbwa0C8U?=
 =?us-ascii?Q?sQ9/YL4QnGAqsgsZb/9Gmezknk0T7MRgrDhT/rae4ks2MsDF3JU5A95dAha9?=
 =?us-ascii?Q?Hk5rPVzdl0bSN6Jvd8N8MdrcqvinNJ0n6ao/dySfj+XwOLy2LhW10ouvQkWM?=
 =?us-ascii?Q?Dizs7nhhL8dmeAbi46yDp8VqyT+PXTCLjFoDMYqGSmaD+cOrr5Jcqhu+UZRg?=
 =?us-ascii?Q?x2tz9Ac8Q120HNdhmlyZdFP5tVDtZUX2ql18QGEIYUDVTV04B4DrQFuAR3nK?=
 =?us-ascii?Q?371lbYbkSSdkqx37dFrXKpMKW1ITVJ+B2kIhO6JsWfOAcKlvpViHwmjC44ZH?=
 =?us-ascii?Q?VyhHGIjHwOlfQZozq+AVMk3rYuLCSJhY+wxHEtksGJqS/4g2/LpbartBf0xe?=
 =?us-ascii?Q?GJh5+Iu3BLzKni4H6ZH3av4Onv9pu5kcMSF+KmBA/jsUl0vSXckQ1PURrmfn?=
 =?us-ascii?Q?WuQFYGZ0kP4mj7TkMBIcENmNxuSSKm5f6YRsLDFxIzpqeHjLABxjqmw4D7XV?=
 =?us-ascii?Q?6RUG6K8EyxmNLRqirmyMPVQlU1eUjD0x+ku9YpJd/DqdVsH2ZOWQfsjTEeC4?=
 =?us-ascii?Q?Q5OQHoV3tS7PaC1GU5m7wha+XJNFIVryQdlS735ki0Jf6cJ/sxDRsr45NGvr?=
 =?us-ascii?Q?DK8Y7Df7+i6Tkl/t9U2mupw6GjxTUsvDzKmGzf7y2Y49XIMVS+D8uajBzyws?=
 =?us-ascii?Q?tzkBjjywM6lZ18y/q3NK3Msc6rmhEY0v/0b5McQxiw1FGa8sfQjPrINFyWAa?=
 =?us-ascii?Q?xGX/f/R9O+LGKvifjcrPLQv5omzeaoe+JLFbgy9g+D6TtRgZG+HJRk1dNvLO?=
 =?us-ascii?Q?DrUVju9VpVUN0eu5Y6SsgPjKEFgY49/A+UjAHsjQ5wcc7+hJXz/FT8BlK9VF?=
 =?us-ascii?Q?anNgR4JLjThfqPFGD3v8CPwxYvuDFVvSVlOSZ4AJodnorqcs1SLgXq4eJqVe?=
 =?us-ascii?Q?BDWvdHixgL94lvZHli98EWjNmKZ8keQuN4IByEmd4uD8OAnsnhkMXBb5rOL1?=
 =?us-ascii?Q?K0SX5NO6qT0ve1C5Izo/yqBmoPVTVzLn99qR+ItaQ3ai9XOlC0wmYyLb9RV0?=
 =?us-ascii?Q?lTBsrX6BqJ0sV+KpiKE30QzUpX6saRmIMhV4FKw9kvY7WxdQGXqhmfUxHZ+K?=
 =?us-ascii?Q?egtQ76U92lO7b3P947ZbcjEXlvEnWyYR4uqGJjsvToJ4LIrB0JbKn5IXB/QS?=
 =?us-ascii?Q?kXhn4XDcPwZiTpW1RBcQ6GIvK34lEk+jaIhidelC8e9WsRn/vSHfR+BqzXYw?=
 =?us-ascii?Q?ivSvficfU1LMzeHuJLFtB5IfbbdEh1bhas8IH9dr0WtMBKy+uCQv4cFBlJJV?=
 =?us-ascii?Q?XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338c1f00-5181-4f75-5325-08dccb399f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:25:52.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zweuTTA7+/ZSA/aaS4dvaKJ1BYHWHP9ZwhTAyfdyE7GwlLWYEMqdGI4bxlWD/aqU3cg5wMTgwJU0q3Fare8uuWtD+B5GjhRjCY8rywyebl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6063
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 10:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16841

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, September 2, 2024 11:02 AM
> Subject: Re: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L =
CRU driver
>=20
> Hi!
>=20
> On Mon 2024-08-05 17:43:05, Biju Das wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
> >
> > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> >
> > Based on a patch in the BSP by Hien Huynh <hien.huynh.px@renesas.com>
>=20
> > index 000000000000..9533e4069ecd
> > --- /dev/null
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > @@ -0,0 +1,1057 @@
> ...
> > +static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq,
> > +unsigned int count) {
> > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > +	int ret;
> > +
> > +	/* Release reset state */
> > +	ret =3D reset_control_deassert(cru->aresetn);
> > +	if (ret) {
> > +		dev_err(cru->dev, "failed to deassert aresetn\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D reset_control_deassert(cru->presetn);
> > +	if (ret) {
> > +		reset_control_assert(cru->aresetn);
> > +		dev_err(cru->dev, "failed to deassert presetn\n");
> > +		return ret;
> > +	}
>=20
> Should this just goto the end, where you already have the error handling?

This issue addressed in patch [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/drivers/media/platform/renesas?h=3Dlinux-6.1.y-cip&id=3D1382caeac1db07dac=
a8e3a006ee693eaccaa235a

>=20
> > +	ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
> > +			  IRQF_SHARED, KBUILD_MODNAME, cru);
> > +	if (ret) {
> > +		dev_err(cru->dev, "failed to request irq\n");
> > +		goto assert_resets;
> > +	}
> > +
> > +	/* Allocate scratch buffer. */
>=20
> "buffer." -> "buffer", for consistency with rest (and yes, this is really=
 a nit).

OK, Will fix this.

>=20
> ...
> > +out:
> > +	if (ret)
> > +		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> > +				  cru->scratch_phys);
> > +free_image_conv_irq:
> > +	free_irq(cru->image_conv_irq, cru);
> > +
> > +assert_resets:
> > +	reset_control_assert(cru->presetn);
>=20
> Add label here and jump to it?

Same as above, fixed by later patch.

>=20
> > +	reset_control_assert(cru->aresetn);
> > +
> > +	return ret;
> > +}
> > +
> > +static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq) {
> > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > +
> > +	rzg2l_cru_stop_streaming(cru);
> > +
> > +	/* Free scratch buffer */
> > +	dma_free_coherent(cru->dev, cru->format.sizeimage,
> > +			  cru->scratch, cru->scratch_phys);
> > +
> > +	free_irq(cru->image_conv_irq, cru);
> > +	reset_control_assert(cru->presetn);
> > +
>=20
> Do we need reset_control_assert(cru->aresetn); here?

As per the flowchart in hardware manual ARESETN is sufficient.,
Figure 35.55 Stopping Image Processing Reception (MIPI CSI-2 Input)

>=20
> > +	return_unused_buffers(cru, VB2_BUF_STATE_ERROR); }
>=20
> > +static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
> > +				   struct v4l2_pix_format *pix)
> > +{
> ...
> > +	/* Limit to CRU capabilities */
> > +	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
> > +			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
>=20
> 320 -> RZG2L_CRU_MIN_INPUT_WIDTH ? (240 -> HEIGHT)?

Agreed. Will fix this.

Thanks,
Biju

