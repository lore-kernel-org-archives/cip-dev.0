Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEFFCD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 10:37:38 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.web11.35789.1725273453081848069
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Sep 2024 03:37:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PKpcEz9+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.0, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0LLtZGHggx5INDFoz7WpJAXqLuHrAATDnERfqxCmEyZAa/zbOEzTayyOIPzwHOE/E6MYAGqYSlheEy+NTz78P1QVvW10zZcKHxarZpYfYZPEOq9DYKcl7dGd8TfbFudeqavrhUcQXm6w/l8IiaaM7vGayQRZM+nZp7UKz3xQ4kKk9u9ODYIS9TFs+vIkI6ACNAg9DromfKn2G4GmIeBSxPWr1dBICRYpaoQsIA+gCSmgz0U6ulnWcBBrFceUx93jTY5Bicr6Vi3R3O3tTyYEtMAqIK9rsbrDTOiktkhblx88P2G+IL3zjaGmbnc5gHKtNKIPGxRWa5Z4UG64oG6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5uU6P+f1uA8e4cIb4IROxm2IpA2XibDQohXSSezZq8=;
 b=qkkwSnbuol+QkZdHxMKXrmuYcefhue/D7AKZLMiWeGtyNRD6pNPlSntoKjDF9LrLe/2agbjrjYAxkTD3mFtWwlr6Elof8f3bMPZYBlVPGliKNj9uconyD+UwuVgnyEadafjv9/LJK3bV4qvUMqXLPMvvCmbSQu+yefwLhVWItWUwnJ5F4j/nYTMoiAPGfEgXb6H6Nm9D0hFz4MrVdesR4Ud2DU5VNMV7jZj0xb9PpwqcuhHJR8Efx/rJG//oWcZCzPT1UrjyA9JBw1ObCYzck8tCPDkG7oJVBuiXR0xWq5yWjzISXTVBUdJXWZdn5JVtDzOEfJIektm4mX3YRQa4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5uU6P+f1uA8e4cIb4IROxm2IpA2XibDQohXSSezZq8=;
 b=PKpcEz9+KqTwdYtPi+mlOlpEtE4fJTJwJ6ZDDuZricNMwTSknQDoESAeri3Hn3LTLPvhv2ljCvsNneLki832038tupXlVKlrxbu0bjMablf3Rm5y2ahW+yFWxJuM3YymOzDQwBu8fsx5MuJkp3LBXmGsRgad4r3igYJycmhlZks=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11842.jpnprd01.prod.outlook.com (2603:1096:400:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:37:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 10:37:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Topic: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L CRU
 driver
Thread-Index: AQHa51a1/DXyCVhcIkGLqZDjDGY1xbJEb54AgAAEfZCAAATHEA==
Date: Mon, 2 Sep 2024 10:37:28 +0000
Message-ID: 
 <TY3PR01MB11346965450842865A686A7F386922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
 <20240805164342.211857-13-biju.das.jz@bp.renesas.com>
 <ZtWNFuw70nkB37EK@duo.ucw.cz>
 <TY3PR01MB113466E4088792C918A52067486922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB113466E4088792C918A52067486922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11842:EE_
x-ms-office365-filtering-correlation-id: 84f0fbde-fef8-488e-8f9d-08dccb3b3deb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?aTBLc7T9kk6WuFQ/BgRRuWvUBDB3Rn00FCYjY9A+aNoasHa3ixE4VXrFrtgk?=
 =?us-ascii?Q?DvpabWfu8yaXw/yerkAl8IAP5RhaEa12JObh0CVd3idxthzb2wHYTusfGOFR?=
 =?us-ascii?Q?yiURmLtM7n8Hl6mfQuFKHft4Fb4caRLVy/FhH/zzfa4Rqoqw6S2lsFsun7CG?=
 =?us-ascii?Q?Ihl5DPFPwqxbKizEJdRANaaY+fjMLBqDKWJ79TSJxoimOtel8QinGugfO2RK?=
 =?us-ascii?Q?LpaNrtj8iJ87bR4Z+U6iAp/kg03pRv56PS/RYx3XkZLVnYN7GSQagTIx3kYj?=
 =?us-ascii?Q?edbxNtrFNQDMwAiekeeRn21+/defqwre3WLwdBmXGK8Rr2sv36hNzh/DtLOS?=
 =?us-ascii?Q?4pa05FdHygqU/CjypLdrIVMb7c3RE5pm1ukY+kRdnFNehI3I46sUggkgHLQ7?=
 =?us-ascii?Q?/GIpuSPzwE6qtws584maWJMMgtE/4/joIQ5VnTM247J+7EaQoepX1lHMW5/U?=
 =?us-ascii?Q?iZPxmQRGZgb5dGVxFHh/7AUFa8HtS/Lkf5mi/RxjdClZB7HWknNZGTejwmgh?=
 =?us-ascii?Q?EBVe0s7b/VaunXCg0eLuR5oN1qITnYZq7NLRrN9rKAWCkn7U1FeOFoM5Op6Z?=
 =?us-ascii?Q?n+OZTb6YWj1Kctod/EFqrTEiM/g7Hd/NAzFiybpUiesjSuJWzk2XHYw00HB7?=
 =?us-ascii?Q?iMNO7ECBa58QbwsjdnQt85m1VnYfn6m5hCxoOrGh0GPxeWGo7nMjpCCvi7Vh?=
 =?us-ascii?Q?FNRFF0d6IsT1udmbzRSYjawqj+nDhXfqNpoV1XrE6spaSdi08OoP+d+IqeMC?=
 =?us-ascii?Q?kE4LR7TeuVK4gbkQiKzad2tc9npRYHmsB11NpcPJpXorIa75qUolvav5yuEg?=
 =?us-ascii?Q?hmiX9b2WC0Mh8P5+iMHQ9tkzghfmxY+u+DDUmtRNNtLJvUcIZfsNMHMH8d+P?=
 =?us-ascii?Q?1VYHfKvAazuZX+CmNDOCeE0GPLdwTXK1UXAyE425F4r9Xpbcsyc+ytUQ7grX?=
 =?us-ascii?Q?MKRgWo96h41Z1vL9B2h1DSFWRZx16pBKof+p/m4qwjik7hCUa/pNrvtv1iVF?=
 =?us-ascii?Q?jb8jfcM4OoJXKnYp+0cOiA13P6eST0E9NsBIcwfrZhmQ1K9uGeIXkQkiCeD9?=
 =?us-ascii?Q?5otdNcDQy5qNH9mCuAev/mfuBQxUV5F9GJaLqEh9IzplFfL+YP/ebABbo8EV?=
 =?us-ascii?Q?Gs3GUc6U8aEbV5ziXj5BbOKgVjx/utyEBm4ImQSEcaJ5V9rPE3xigDNSqan4?=
 =?us-ascii?Q?ylL1c5+0r3+mkpowT41Q7jrypI7dnFCCWDJfTQRiXBp8oc43Rf28DdggkE09?=
 =?us-ascii?Q?5Il3M1ubk5Vay/gn9vl4qAM+002jHihI7WIHNnKg6hAgdRdOoV3sYwepH1zP?=
 =?us-ascii?Q?cEV3rOmfXN1DXFvXpSdJJwhlLxwumej94BM3hO+1YpsLru8+hSnYOTufeAug?=
 =?us-ascii?Q?AKkisUM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?O7KbP0k1gfYf3LoHX8X5k/KT0hBb2/skU/cpCPM3G792oZ7tQ0yryzSAvMpO?=
 =?us-ascii?Q?5tIozjeny4QdtIywDIz04x06aFtJwDFeiGVki1RzhhR45Jk+jLHy48fGCLaE?=
 =?us-ascii?Q?O2cdBB3DRYlvLgI5w7OSf8tBC+qBgsuIAQhIbiB/ckYXtJJKsAuxDeO9XTmk?=
 =?us-ascii?Q?+Wd8nGEiBMjurqOZ70QL8XxtZCxOD3bOl70T34wHgKH4V/KZSz8rmgWNTqMe?=
 =?us-ascii?Q?7DxxsEoU1jUN3oAAG3InnGFkUVH1JXbU/lDMkjSvjQm6VanfrsxmOcro1ywV?=
 =?us-ascii?Q?8pRakU8mRjkyVxlSqPFqgniJL7991h2T1eGcasdvcQFTehOzZMwMT0sLtski?=
 =?us-ascii?Q?+Ji6vh7DZJYvgFBmNWkRRPLbvAvzFQxPCq3yqmTIeFKw7UZUsfKPrZntLOvY?=
 =?us-ascii?Q?vrnMVRg/e1uvJh8PlMMuJq2u0Mc9EpYDhFDSn45t/NmS/nGiNuaSy/xxijSy?=
 =?us-ascii?Q?PtttC/7bKSyedZRHPZdFV7pVIwkNSU+sH2qtqFrkR387eA2dU43Kr+iarwcI?=
 =?us-ascii?Q?F8r9zXj9PjiPdwLcG1OEepIf1tn+On8/9fyiUa49puMqwj27vJCUroDgM8t6?=
 =?us-ascii?Q?wneSkK3tapm7IMkM9B9ch91Di7Le/GeOybO92oraMq//p7iYO2SwcwFw2S7J?=
 =?us-ascii?Q?Y3POwVEf6g7IPSCO5+gjolgKTGKeSuNilhbrax5/v+zu3Vq1GbLHH0I0GNvk?=
 =?us-ascii?Q?DhnXHhfMUOCW0AnV9iGKCP4jUKe2aBd3J55mXLh4tvP43WTwN+OM5DOYisgd?=
 =?us-ascii?Q?mpHaLI7o6TU+Zs0EVeKnNM8+5mA+vFOAgFU+xcgL+sZ5Uh/ujluMsOr0jchb?=
 =?us-ascii?Q?Mm8hduH87a9KaY8SeFsz8ZzEp3Yffqsp6cX/ClgpWOKvUyIecLNbvce/1FNM?=
 =?us-ascii?Q?2oY4Wk5N7+VaflMWXhJoaCOqws21YMWAb6xJffK55LiakdUbi/nKj1F+r95q?=
 =?us-ascii?Q?9wazR4I3z5mhIjvOamUF3MEoehCocorqeRR3TWWytCOJY1TtNR9A9XPILANZ?=
 =?us-ascii?Q?kGYmsH1F9uv1OQvT1j+5sZ0p8LHIM/19ZNT8YG8AEyNKeXIXmw7dgAzEoh9D?=
 =?us-ascii?Q?LKU3jK+7AvdEsetkaTcGrjyqLKFXSfkkxLAM85eZhy4i+cgvSlh3jeGUCjKe?=
 =?us-ascii?Q?2NC48pKzE5IxYQRI/uXGfOD1LXoK5k3fFbyq34yWqKp8CqN68vUPA7iEbyxD?=
 =?us-ascii?Q?gVpXO1p+AAm6YWCsr2wYFCzY8q4tTRQIYrtnYjXywvqcWVu8BLygsBcQn092?=
 =?us-ascii?Q?LDQObWq9G/uQHrlmXsfP5EJe5ZVquTZ0tKwBNd+6JMqJ6JrTfTOne5kszfwA?=
 =?us-ascii?Q?NOKkLUNr/NeX6SP1dsNHXiZ9LTMcYTJ8ysuuSr+Sxsbjuswj3Hl/xjZqPhnU?=
 =?us-ascii?Q?X3RxMe54H5hC+UFBP/OK8VeL48u+VFyQDOkDmiObIcwyG2bii+9oQxyIZ/Ev?=
 =?us-ascii?Q?FOAMA/9bYtexg1iiZ1rLtE4VMApTFXExDZZjzrDPvUZvvVQFrzkHfCgUARlA?=
 =?us-ascii?Q?bIjibl4rv3G57PZcsEiD5mwioS+JQoY8dj7D0tBRrheFDlWma8yRIJS4KWM8?=
 =?us-ascii?Q?R/BZb9FaDQfda9c8Qdz3Pg7wpWT12u7bifO6PUVP1dM7+OOTXJdJt43wkcZZ?=
 =?us-ascii?Q?7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f0fbde-fef8-488e-8f9d-08dccb3b3deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 10:37:28.1751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JB71MuaNoPOJd0dtE1MNz1W8mR/r3ASRAejh03q8G+CR2uMVfFfuq3QLQiAPb0OdeM1DD9Zc/JNhlxUdJpJ7XK0tJZ9BsUQwDNQRjzqZ6iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Sep 2024 10:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16842

Hi Pavel,

> -----Original Message-----
> From: Biju Das
> Sent: Monday, September 2, 2024 11:26 AM
> Subject: RE: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas RZ/G2L =
CRU driver
>=20
> Hi Pavel,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Monday, September 2, 2024 11:02 AM
> > Subject: Re: [PATCH 6.1.y-cip 12/30] media: platform: Add Renesas
> > RZ/G2L CRU driver
> >
> > Hi!
> >
> > On Mon 2024-08-05 17:43:05, Biju Das wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > commit 07fc05bd0a797dcc34620869933993e1cbf56b98 upstream.
> > >
> > > Add v4l driver for Renesas RZ/G2L Camera data Receiving Unit.
> > >
> > > Based on a patch in the BSP by Hien Huynh
> > > <hien.huynh.px@renesas.com>
> >
> > > index 000000000000..9533e4069ecd
> > > --- /dev/null
> > > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > > @@ -0,0 +1,1057 @@
> > ...
> > > +static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq,
> > > +unsigned int count) {
> > > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > > +	int ret;
> > > +
> > > +	/* Release reset state */
> > > +	ret =3D reset_control_deassert(cru->aresetn);
> > > +	if (ret) {
> > > +		dev_err(cru->dev, "failed to deassert aresetn\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D reset_control_deassert(cru->presetn);
> > > +	if (ret) {
> > > +		reset_control_assert(cru->aresetn);
> > > +		dev_err(cru->dev, "failed to deassert presetn\n");
> > > +		return ret;
> > > +	}
> >
> > Should this just goto the end, where you already have the error handlin=
g?
>=20
> This issue addressed in patch [1]
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/drivers/media/platform/renesas?h=3Dlinux-6.1.y-
> cip&id=3D1382caeac1db07daca8e3a006ee693eaccaa235a
>=20
> >
> > > +	ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
> > > +			  IRQF_SHARED, KBUILD_MODNAME, cru);
> > > +	if (ret) {
> > > +		dev_err(cru->dev, "failed to request irq\n");
> > > +		goto assert_resets;
> > > +	}
> > > +
> > > +	/* Allocate scratch buffer. */
> >
> > "buffer." -> "buffer", for consistency with rest (and yes, this is real=
ly a nit).
>=20
> OK, Will fix this.
>=20
> >
> > ...
> > > +out:
> > > +	if (ret)
> > > +		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
> > > +				  cru->scratch_phys);
> > > +free_image_conv_irq:
> > > +	free_irq(cru->image_conv_irq, cru);
> > > +
> > > +assert_resets:
> > > +	reset_control_assert(cru->presetn);
> >
> > Add label here and jump to it?
>=20
> Same as above, fixed by later patch.
>=20
> >
> > > +	reset_control_assert(cru->aresetn);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void rzg2l_cru_stop_streaming_vq(struct vb2_queue *vq) {
> > > +	struct rzg2l_cru_dev *cru =3D vb2_get_drv_priv(vq);
> > > +
> > > +	rzg2l_cru_stop_streaming(cru);
> > > +
> > > +	/* Free scratch buffer */
> > > +	dma_free_coherent(cru->dev, cru->format.sizeimage,
> > > +			  cru->scratch, cru->scratch_phys);
> > > +
> > > +	free_irq(cru->image_conv_irq, cru);
> > > +	reset_control_assert(cru->presetn);
> > > +
> >
> > Do we need reset_control_assert(cru->aresetn); here?
>=20
> As per the flowchart in hardware manual ARESETN is sufficient., Figure 35=
.55 Stopping Image Processing
> Reception (MIPI CSI-2 Input)

Indeed you are correct. HW manual mention to assert aresetn and we are asse=
rting
presetn.

I will verify with both resets(opposite flow of start), if it works then I =
will go with both.

Cheers,
biju

