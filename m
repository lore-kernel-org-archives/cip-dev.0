Return-Path: <SRS0=4VuS=CM=lists.cip-project.org=bounce+64572+5407+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948AAC433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 18:01:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEF32078E
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 18:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tnvdia5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEF32078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5407+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D3VKYY4521723x9b0JGFETZs; Thu, 03 Sep 2020 11:01:19 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.114])
 by mx.groups.io with SMTP id smtpd.web10.20313.1599156077976795236
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 11:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZRcsEQDX9UdHxCoPNrFbV/9eYo1erVu3URNkg4Q+YKvsh5QayIrt1obHDfrSOTjdytm+GBycvKF1s9wlU9pkaX9gyl/CV4wrhpy5AUenCklc0ujLLC0c45tJDZXoBRkTtm5MXTiNBFikjSprBjUMxczP8L5dFFBoLoFHtGWqcOUW+bYTFEw2UFAqyeKAUBjB92V5z+3JLViFrj3wfcVf8fWXmY6EQdJMm80tOqt8PJZA8PnXOEkS6eGasxtZfC/+aPdrvykZQBSg8wPr2c7BCE0yvFly1rXZzopba/BQ8wCzmKXU3cnRz5pntSLhWwy7N37WC8wqvCEFeVdginhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mck48bl8cy0Iw6gQVwsJRGipg6zK/xGmSUI8rVAhkYQ=;
 b=DYLDha1tjUvfucy7XC2JW0ZE/MevB+OZZDcqrJMvGCba7sB4CxcutLxfnatT/uUvNRv6mvLrKXV0HlAsy7EjkE+abr9VDkmt0JXsKHPWXD8oKXeBMFZLk5mG0L2LMLPlJgaOU2aebjfSRKHA7klygiMxQlDUQ+l3bJeW9lgXKKbyHTew1F62DsV1csovIT16WYVPSLoc0XYuU5UJAxIf0L8HyQCrvuck7VvRYs+sgKHlXhaQ0uXSKOJvdwXHD/9z25oHcZrmWXh6r3kZRwVhcBG0DVhMEdjFiGfSPuP5YAN7FDA6i/+KNW4vpWkfh9OqxVLjisLBsWB2ZNafdll7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OS0PR01MB5444.jpnprd01.prod.outlook.com (2603:1096:604:ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:01:13 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:01:13 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Thread-Topic: [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Thread-Index: AQHWghtLReioRgdiI0ao08ZwYbp1R6lXMv0w
Date: Thu, 3 Sep 2020 18:01:13 +0000
Message-ID: 
 <OSBPR01MB5048BAC612ADD9CA1A3F143AAA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903175431.GC7795@duo.ucw.cz>
In-Reply-To: <20200903175431.GC7795@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27e6f3f8-e4be-4490-a72b-08d8503358f0
x-ms-traffictypediagnostic: OS0PR01MB5444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5444508E82191510A1202048AA2C0@OS0PR01MB5444.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Xuat+4N84WEQ42Y8z/BxCqz3QYpbmwbm2dRsGbIdH3YhpQlpgt1a5yCBtTWYcRJFoKaRk6m3Z033YP6rn5qn2f0L3iWPorFxx8y4hPWEpeALTEV3+LCYTySgqGNfPxiXTyHZUr3QuWUj6r3lX2eR9d7LAy8dNgxgKgcu8bUeK7YK+NKXgCW7wFTFYYa5MVWZ4uqQPWMn/NRcf8iEQVVy9rtKpJVLmQimkpBTGOJOoYiH0Zcq/nbz1PD/taDJbuaFzrGElZcCxtVA9OMP1yoWrNGTXwOEHgyWnvlUM1rUHWn665Yo0DCeakK8L9ZcDja6/ox5bwJY1zenzALkuYSSdQ==
x-ms-exchange-antispam-messagedata: 
 vyJfvBYto1zbwIf44JwoIvTE9o8/kshmxi5fYukmjbTn5tWrC5p9QOAVlpIGIDIjjVh6rPZ9OfP6qOR3ScXF4I4wgFAXIx6ni82bsXTZL0bR+XVfoXl7xMwJwzn+XFJKiDzV2Ao/LSFgdd1Op+YI6pCkcV/d8ExO0ucgAiWSqAJSlU0BPnvBNnEoWoPOnxmmL3oK3JTtkPmwYbLJ3NeFtdPQK4IIbCWGenpBOCkNf+VDlAGr0JfGBBJBGT1ECidhTDEmKwYOAzWe+zMOS3MnzuvGRf9Il9j3hjI8j730LiCo+zddDm4p7bbKsmCklSsWiIzLTrnrZU/Jo6tFez01yMfOXS2vj4gSla7coXH+A55jf5nFn3324oeMyVRA9n1Xuf0b2fWVZ22whz7LqCqk+fHkrCGA8QiUqYMnY3Pb8ZQwxLJO/td/64DtCGpKAKGZraPiGr63QhHMY2TSV4MJRPNu2GAhDEdYUEnviHSmT2c+x0LMzVRJs2K+mZjlbTpiKX0q5CLp5yDCL4nffWzxM5t8Bma714n6Zm0vlJ8rXtptVzIOyQyc5BRqh24TtKwChO5Ha7tMgf4hB+SG1naNbLA+zzKYdTsAGsTrFdQyhLdztt9MU3gJPVDxVYouppkklycgsO98tYxvuWs6q0BugQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6f3f8-e4be-4490-a72b-08d8503358f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:01:13.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTfHCPkQOSoxqqdOPaIz+XN8lkk/MCKryI6Ry4j8CcBltgnoZshYw9oFvwcf1EALbM8wBwCWAh5kFuhl/omj9DOizg2HK++7OBfIw4+ADM/ILQzqqNf8VbhtDfwLhzE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5444
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 66Q1rRmu6XIO3TjFOYn5n27ux4520388AA=
Content-Type: multipart/mixed; boundary="YLbY7caoqKB19BTChDXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599156079;
 bh=qKYEInSJdBsIEu17vV1I4EqSv5GQZDJqsvTV3/VhflQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tnvdia5Sp8JhnnULqBbLZDtLmN2t9AtiAEiXT9L/5gGiq5OcPffTvQNvR8Fo/R0tekT
 XdZBUZ+GTo9NE4fAR5QkzqXaeZk6R+c92b/IPfX8k/jZmuGPe3821AFFfCRSbFxDDS9Qf
 mufZJ+aDEfyX5sL1CHfFg2yKj2u6oFcgZzs=

--YLbY7caoqKB19BTChDXO
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 03 September 2020 18:55
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
>
> Hi!
>
> > This makes the driver use the data pointer added to the gpio_chip
> > to store a pointer to the state container instead of relying on
> > container_of().
>
> Okay, so this is a cleanup that makes sense for mainline.
>
> > [PL: Fixes 6e52cced1aa58 ("gpio: rcar: Implement  gpiochip.set_multiple=
()")]
>
> Does it fix set_multiple? ... seems so.
>
> Fixing set_multiple is possible with this oneliner, right?
>
> > @@ -541,7 +532,7 @@ static int gpio_rcar_probe(struct platform_device *=
pdev)
> >  irq_chip->irq_release_resources =3D gpio_rcar_irq_release_resources;
> >  irq_chip->flags=3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
> >
> > -ret =3D gpiochip_add(gpio_chip);
> > +ret =3D gpiochip_add_data(gpio_chip, p);
> >  if (ret) {
> >  dev_err(dev, "failed to add GPIO controller\n");
> >  goto err0;
>
> The patch is okay and now I understand why you want it. It would have
> been nice if changelog told me directly.
>
My bad.

> Can set_multiple use container_of() too? We get less differences
> between 4.4 and 4.4-cip that way, and it is still one-liner.
>
It could use gpio_to_priv(), but since there was an commit upstream already=
 I just pulled it in.

Let me know if you if you are OK with the patch or I shall post a one-liner=
.

Cheers,
Prabhakar


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--YLbY7caoqKB19BTChDXO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5407): https://lists.cip-project.org/g/cip-dev/message=
/5407
Mute This Topic: https://lists.cip-project.org/mt/76607574/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--YLbY7caoqKB19BTChDXO--
