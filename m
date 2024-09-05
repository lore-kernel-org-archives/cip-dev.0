Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF483CD5BA7
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 10:17:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.44])
 by mx.groups.io with SMTP id smtpd.web10.6010.1725531460157758538
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Sep 2024 03:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=eVSz5V8K;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.44, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgXuErRbvu1iR13Vhqx8TwXuAT8bftUiIcQ5UcyJPvHgzqxuhJgMfxv9HgeaIWXf1ITd5qlouKPQ4tpHD9QKnB6zv9FREdhSQ5Xg7YVhdPRusZnEP2M4oUFmTiIk99HyfinbCOn77zagubN0Z3OgEMDttez2xzWslTPKWFXOmmBtgmtafQ6SP9KgnfMJCU/D9IbUbud9drpkygNgqzxFnw8Mu4JYrGYQQBIRKrVmUMKMMbmMlXUL22fpOejEwiATFFlkmbQvdK9tbRls3UMYS14Kmzj6w4g/M0b7HsW4E329jt1Cgctyk2k4FeKd1pNLd4g/Srb87JBmaQqZd2KoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMTPgNL90yudkm94dtJhHGfETSgifVaUGMuW69sZ08E=;
 b=UpwT+eBFrqmHldMLfgH4uqllQ9dth+/+t4nk4UHHUeDU7+4UkdvR1QDONY1tlgzma+QS2r24ckOyisH+eLq8sTTP/UT7kknD8LZdfhShEW4FENyUbFfffgVZaiIb4wlWd//owtrYUDDfC+qCdeqeZXkr8jVURSuOIHrxbT0uQzUNF9/Xq5dcHAar8iaKr5Kx6hYDxaYszRGmYH2QRZTqi+WaMlg8XC54yjRjukcq+kILe35NZMnnsG5k6YvPpv6xepXWNTXtIMeljSko7q9KQQyisIfJwo+KqXkTLKfn9Zn8//uJE3nUXCaAiXxth9pE7p1ScJlHCJEoy+FLTXpWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMTPgNL90yudkm94dtJhHGfETSgifVaUGMuW69sZ08E=;
 b=eVSz5V8KkJA9ZQLHnhIiZkbEkJDicbhcpKUQCBQJo1uXHAot8zo71beJTAj/BNolIvR9cxxSP9zvTK/jDTmptGRCwJcUl3gSMkTtD/8dF2nMvxbRFgBP7AJKUaIEzdh2UTPsYz9rj/U3HKQGVLhQIRVBfmMo4FGpS8x4WZvFvVE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB6720.jpnprd01.prod.outlook.com (2603:1096:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 10:17:35 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 10:17:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Topic: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Index: AQHa51a1/DXyCVhcIkGLqZDjDGY1xbJEb54AgAAEfZCAAATHEIAEsXXw
Date: Thu, 5 Sep 2024 10:17:35 +0000
Message-ID: 
 <TY3PR01MB1134617D338E77468D852A8AD869D2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-13-biju.das.jz@bp.renesas.com>
 <ZtWNFuw70nkB37EK@duo.ucw.cz>
 <TY3PR01MB113466E4088792C918A52067486922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346965450842865A686A7F386922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11346965450842865A686A7F386922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB6720:EE_
x-ms-office365-filtering-correlation-id: 6ad85326-fb03-42d3-4197-08dccd93f613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ArHAc3wAQUTVS9PbStWmBQsjuORMrCUzfgPt5PplwDYPEa4FRr34E/6KgVyl?=
 =?us-ascii?Q?SyoHZPpsV19RiSyPgGXa3zyToa5bnNdzpG8HysjHACbGynUdvdXpBCSJR8lk?=
 =?us-ascii?Q?5bEQ1XWRdqp31LkJO0BjUFlBR/vq7TAtasRRLVBI6LoG3oUAh4M82sTRkZoi?=
 =?us-ascii?Q?pTwnmn1kUVwtWKb20brexD53Xnw+1z8snGdTK79xKxG5R56ecPf789bw3wdQ?=
 =?us-ascii?Q?9uDmDv5gpYRG44b6zGeIfxf+Tc9XtaRYpv1JhRJCIuWMyFlGW8Rk3FnkKrZl?=
 =?us-ascii?Q?W31acKctwZpnQWbJxNyPA9BfGF0hBxphNa6YGtxhi0hTvqwFQ958n8ybMQtE?=
 =?us-ascii?Q?rMXOpPQPVMeyw1ueP3BXYi77aQNRL2EDCUX3RKfv16nQBDy4uZ50HXzG4Eq8?=
 =?us-ascii?Q?jxBcS4wxM6iEDxp0Ofd0lo/bGnBQliFO8P8CeAbfnRylSuE+APq0LYzzaU4+?=
 =?us-ascii?Q?9e0HKRUtxizGqcoA7lA9xAbPTtiq6dTbk7HUOxUx7JpANuDbxyQn6TYQ2OvT?=
 =?us-ascii?Q?D/iktdxHWM+59b4KeIy78+1YutzddNnPXfEnhlqcVtePOLOriuwkGFxgAb7Y?=
 =?us-ascii?Q?MC6T+UpQV6QzoPg1n94ikEXK9BAonz6UFsr5rAiCoYlMo1RUJhZP7mLw1bYB?=
 =?us-ascii?Q?BhYK7HtUJfBPWNbPjsQgsmhob39w0WM7M0aj/L3pu7Cjq/IyYwDLqxHBjr/e?=
 =?us-ascii?Q?Hc3pFbX2C3fiNkSX3hKj+hGXDOzCoD2DPq5vxp75HUCWEWlvOA3mQi9fz5yz?=
 =?us-ascii?Q?xvTxrR5DC+p3t+kl4ZppfGqFybXjaRBoR5u//dG7REzYY5+GYDvb6IcV4qpG?=
 =?us-ascii?Q?58YSQqnDqqgK+L210m9hq69AQVjM/fgvF/iwBVVTYB9yUyB69aVtxzrb8QYP?=
 =?us-ascii?Q?VPzXckMme/fLy9I53xnwzbMDq7k5cIBgonf15e5lg6rtslyHt1I125Z0FyOv?=
 =?us-ascii?Q?gs1V2FyD2AU8UAx75ELs0NkYsWMK8/GalHjfzHnC0/Cs+VDzW/r5deQBGAgW?=
 =?us-ascii?Q?mZX67JfoOqTR244He3yAtY5G/QI6xFEd3FKGXslSP2qrkV5kcelz6kEKmxJi?=
 =?us-ascii?Q?sxp8gYoWoLtzDjAlgS08y0HuOrl/DprFHaQIpDFB38sCzhN7HgfmwoYapcEy?=
 =?us-ascii?Q?Bbm5/pzC55Do5vbC3+0jkDpbI3Vq4NjxafCLoM/UfJCPKAJWkHf3jUWg/n3j?=
 =?us-ascii?Q?KGyEi03deKvQuUuGB9GS3Yk8L/Niq03WeR5X+Ynz1uEhFGGT5FfH2qRnPJIM?=
 =?us-ascii?Q?0a8/oK14JqGtVsZGq2iao9Kz5q3V89Bvyxe8Ig3NmurkyWmi0DIJlMOH+Khf?=
 =?us-ascii?Q?3OcryrS7sOZOPaDAJkDxwx+BUYZD0Rv6hhEMPMZZl7dLwXlZSfhcwu6O16eb?=
 =?us-ascii?Q?vXeh3YA=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cMe3McUQ944g+8bOEmZXQ10huGX0C4CGsblcpVey5oTKcGv4jSEFEsNDau1g?=
 =?us-ascii?Q?0sBvJ0pzTns3/uIw1QdTXSCPVP+zOqpN6BO/NxWjmWCFvhGTZZFj5NCFmrFH?=
 =?us-ascii?Q?0yWEM8S9nTQZ6Clze5BKZ/Vh8AhDDwA0O25LQMDHmiBtauTr60Lx4/wtE8xh?=
 =?us-ascii?Q?mSUb7VfAR91sSsOFmW9h4LAQMrvZeQNL1cvSX7ZxmxCkqA0DeCcjBOY3+6uL?=
 =?us-ascii?Q?aOXZCNVwvmKMue7ukqgV408sDsL/vm9KDQj/RIO7L6SZmaQE1GqHiAHS3v6N?=
 =?us-ascii?Q?jUx9BPaDq5H+V1dZRw0ZyzWbcFhsMJ9l9lgdg8PwhLJJAZ59kaURuXFWj3/M?=
 =?us-ascii?Q?2Ns9WjZwWctX93vYzf7SDQDLa8HDu5GObcQg4KLkFcr3MVfPxj+eyTjfPyjw?=
 =?us-ascii?Q?IucGaPRO4Vq+T6K2ilasvgQTuk9pN2tLV8/qpiRf9JyKm0gdCloFY6S9ee4w?=
 =?us-ascii?Q?zU9SsWNoPxymNspMRjIPEdoBJpz9oc5k/RNOSTfBv3IEtSr0GWNGK/ycjoj2?=
 =?us-ascii?Q?AQQHBljLyHvX/+Eb2p0ICUAHBbO/KgIgDsGwYr3NcwpHQuiWA397mjFth/Tl?=
 =?us-ascii?Q?m9Heo/cYYc8Vynb8QDtCIU5XnmMd+lEc2ZU627Op2QyTnAZVwHwwuSqXVMeO?=
 =?us-ascii?Q?MeOK7uxxbu9UY3liq0HW6wVi9XafNQNJGfDv1BCd6MKKYUR8BAdcB04uvpt1?=
 =?us-ascii?Q?GHwQR8ltsve1Fgyks+mo/ZK4ynnzdQZp1dIT5Lm2qAz6g7rY1CNlE8vEv3Xv?=
 =?us-ascii?Q?sq7rFpu5rJze4V8kWcdXJl+aSwYflXFZHlPmbOC2QcpLIqwKRLJida+IKTOz?=
 =?us-ascii?Q?x+BsGoovsGpjS9ZUTyQ64CBoTV+zrzAN5hPWWDmufXNcwZZjU519vourz29/?=
 =?us-ascii?Q?QjOaKRQPIxdLGBmULegX7Xg92c61JWsPreKHfWkNgjW/N4lSIW3ZGBcsjgfH?=
 =?us-ascii?Q?kxv7p5ymKV+K0DFXbiKxeUJJ28Uvx6q19ho5GSn5p5lFKuSxilTAO4DW230H?=
 =?us-ascii?Q?7Kt4D6Yqt5GeIptOEThSrRQwmED/FxJ9QYl0wCU5YsCqJvvd4m3zqlAmzWtb?=
 =?us-ascii?Q?0sx/1tkBwLfnr1yAqvfpcr/USF4vq6fe9pBMfMrxHy/XL3bivZQ0WWiDK6qO?=
 =?us-ascii?Q?1m6i0NnBu31WJdkAxirg+eRc7acbTUhD+or5t0/PMSvPaGG93+7THtjXZ/NR?=
 =?us-ascii?Q?3y/iRI2ppFOIMSmGLcUXcVCYHbf4HfzuWxjcYm1ZnUouVD1LYIAeSY+39En5?=
 =?us-ascii?Q?WLyjhXQM6tQad9jiq2Tm0V12lO4qm8BxA0CCrWQpWujXFqbbcR8J9Mk8o8PP?=
 =?us-ascii?Q?fHu7zhYuXd3murQuJQrAc0TbXD0IFFL3/BI/ydIqAh1phRQ1NtIPYImv6bde?=
 =?us-ascii?Q?3+Uu03NJTOM5rCUQhMshOlpX/Un+hKcFggPPjGPDuDXUQy8HHKMOByIO6rmR?=
 =?us-ascii?Q?et5vbXlJK4RcLP+wpUHN2xyWXS7IsAVMSsfHwiDCm3BWatl5/VjLZiJJJwjQ?=
 =?us-ascii?Q?+oDIi0sZBE2yLrz4Y07SxxTwkWAKTsjWu0eZBnFzngraA7HA+lDA93vMxVBF?=
 =?us-ascii?Q?tisHuc1YfogXSbTyRL6eyIQ3lUiScQVBKdgc4AAXZ2FsbzmKyAWLLY5IElFI?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad85326-fb03-42d3-4197-08dccd93f613
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 10:17:35.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pjdn0w+2qDXWk7MzSYZ9HjUQvyhayxrMqxZ/tXZAiLZB9MIANgkREZJGhEc6dNGKYG4FzMRqRUAN/hNk8X4r4IftwBtx3aLrA0pFTk/VShM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6720
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Sep 2024 10:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16850

Hi Pavel,

> -----Original Message-----
> From: Biju Das
> Sent: Monday, September 2, 2024 11:37 AM
> Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L =
CRU driver
>=20
> Hi Pavel,
>=20
> > -----Original Message-----
> > From: Biju Das
> > Sent: Monday, September 2, 2024 11:26 AM
> > Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas
> > RZ/G2L CRU driver
> >
> > Hi Pavel,
> >
> > Thanks for the feedback.
> >
> > > -----Original Message-----
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: Monday, September 2, 2024 11:02 AM
> > > Subject: Re: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas
> > > RZ/G2L CRU driver
> > >
> > > Hi!
> > >
> > > On Mon 2024-08-05 17:43:05, Biju Das wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
> > > >
> > > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > > >
> > > > Based on a patch in the BSP by Hien Huynh
> > > > <hien.huynh.px@renesas.com>
> > >
> > > > index 000000000000..9533e4069ecd
> > > > --- /dev/null
> > > > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > > > @@ -0,0 +1,1057 @@
> > > ...
> > > > +static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq,
> > > > +unsigned int count) {
> > > > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > > > +	int ret;
> > > > +
> > > > +	/* Release reset state */
> > > > +	ret =3D reset_control_deassert(cru->aresetn);
> > > > +	if (ret) {
> > > > +		dev_err(cru->dev, "failed to deassert aresetn\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret =3D reset_control_deassert(cru->presetn);
> > > > +	if (ret) {
> > > > +		reset_control_assert(cru->aresetn);
> > > > +		dev_err(cru->dev, "failed to deassert presetn\n");
> > > > +		return ret;
> > > > +	}
> > >
> > > Should this just goto the end, where you already have the error handl=
ing?
> >
> > This issue addressed in patch [1]
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/drivers/media/platform/renesas?h=3Dlinux-6.1.y-
> > cip&id=3D1382caeac1db07daca8e3a006ee693eaccaa235a
> >
> > >
> > > > +	ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
> > > > +			  IRQF_SHARED, KBUILD_MODNAME, cru);
> > > > +	if (ret) {
> > > > +		dev_err(cru->dev, "failed to request irq\n");
> > > > +		goto assert_resets;
> > > > +	}
> > > > +
> > > > +	/* Allocate scratch buffer. */
> > >
> > > "buffer." -> "buffer", for consistency with rest (and yes, this is re=
ally a nit).
> >
> > OK, Will fix this.
> >
> > >
> > > ...
> > > > +out:
> > > > +	if (ret)
> > > > +		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> > > > +				  cru->scratch_phys);
> > > > +free_image_conv_irq:
> > > > +	free_irq(cru->image_conv_irq, cru);
> > > > +
> > > > +assert_resets:
> > > > +	reset_control_assert(cru->presetn);
> > >
> > > Add label here and jump to it?
> >
> > Same as above, fixed by later patch.
> >
> > >
> > > > +	reset_control_assert(cru->aresetn);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq) {
> > > > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > > > +
> > > > +	rzg2l_cru_stop_streaming(cru);
> > > > +
> > > > +	/* Free scratch buffer */
> > > > +	dma_free_coherent(cru->dev, cru->format.sizeimage,
> > > > +			  cru->scratch, cru->scratch_phys);
> > > > +
> > > > +	free_irq(cru->image_conv_irq, cru);
> > > > +	reset_control_assert(cru->presetn);
> > > > +
> > >
> > > Do we need reset_control_assert(cru->aresetn); here?
> >
> > As per the flowchart in hardware manual ARESETN is sufficient., Figure
> > 35.55 Stopping Image Processing Reception (MIPI CSI-2 Input)
>=20
> Indeed you are correct. HW manual mention to assert aresetn and we are as=
serting presetn.
>=20
> I will verify with both resets(opposite flow of start), if it works then =
I will go with both.

Rechecked the code and flow chart, the current code is ok.
aresetn assert is called in rzg2l_cru_stop_image_processing().

Cheers,
Biju

