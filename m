Return-Path: <SRS0=80eS=CN=lists.cip-project.org=bounce+64572+5416+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0533C43461
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:45:26 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668D92084D
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WBlrBjw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668D92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5416+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DgVzYY4521723xSvRlIM4E65; Fri, 04 Sep 2020 00:45:26 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.109])
 by mx.groups.io with SMTP id smtpd.web10.33412.1599205525185271513
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Sep 2020 00:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH/tYfWPDhcdKHN2Db13Ov3b4EUCmEbqQ7NoqouRiQKu9EYs5zjWG0HawPo1/LMUZT5rSw2e1+Fv2Bvg37WOe6acpHT4TxO5pErnxmdD60shqawfBnJ/IBqPpsBakt2yDU5/ii/1Bwqgp+y0Jh9P5LPUnEx1DBsDHEaeqKkOosHU8NuUUkfplnO6j9p8CO8gR0RzpZA3jFoCpocj0HaTo3M0bTf7Z9iMuI74SUp5ekFmTDmpAQoem9ekjzhTi8DSvOi2tqSjdURP1pcvM8CWiJ7ajq5Y0B7Xyf3xvYYuuKthhUbme58fo/KPVM9Imfy5LtKgCVayJQd/U62ph2VYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr96/0JAb2ddo9EXgkzLUzek/1eaCv+xKU9l2T9qHw4=;
 b=FO+YPho+LmgQxjbgE/dRCmItT4oHsSob7kollG9c+iSl8IujUDtlXFwhwiGKRYxBayeY5r3ats2T0EV+z9YkFW62nbjIyOMbf2Xx3XRRi6XLhSu6FiBfQgPK/HVeBneKZBT2EqNapJs+iDy8xXp3OfztgQ/wHH4JeEME8VB46Z1/T3JrQvPPeHd13HqC2zZ1+oj7Zt90GDwSqpH1lXn5UEpVODZpxTcHAf6hxIrSuL+ibTAcdnhhEFIjzSQkzyUKyF5PaVvecd7pb4Hm/zb5dwRPdD/G11oAlhXuEef9IukuiMIAUqvkGA7r/A8Oci0asAdEyQcj65E1AAJivd+CNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB1703.jpnprd01.prod.outlook.com (2603:1096:603:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 07:45:19 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::cdbe:6988:b51c:51a3%6]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 07:45:19 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Thread-Topic: [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Thread-Index: AQHWghtLReioRgdiI0ao08ZwYbp1R6lXMv0wgADmlkA=
Date: Fri, 4 Sep 2020 07:45:19 +0000
Message-ID: 
 <OSBPR01MB5048C5D63E5DF533E9AA5822AA2D0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903175431.GC7795@duo.ucw.cz>
 <OSBPR01MB5048BAC612ADD9CA1A3F143AAA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB5048BAC612ADD9CA1A3F143AAA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 373e7bd4-aadf-46af-54f3-08d850a678c6
x-ms-traffictypediagnostic: OSBPR01MB1703:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB17034B18C7E1918C3F76DFFAAA2D0@OSBPR01MB1703.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 T/K3Lw65gT4aeg0wag29slsyRZCzgk1QqusI5HT5O/M9DkYmCH6x6gYunTU0SN9K1gEE+2AIRpBynYG1qO2asITYQfl7N6mCi6raR/Q/Gl/BvMavm+F8gv/jC2BD+/XMuSTuk8DEpagPvaBOHCn200VUcQ06j5lY0gXYqnOOCUUGlRnvrhvOfmOTbp4u79U01XFqwThw1dLXBoRg0wzML8WF0I2GFYhUW0eyaFD/uxkbq9eGQUfxjCb9ppZEH/pjad+CaMGLDQRtakP9XD+pAIpfeZ8xzlnvd/PNZ5xSSltOdDrjZwzLGe2Tvmvo9tDhe4XaMCOtDXSVwtF7BirCTBdG6+SlnOjJRxXJAswt4cpYwXxbCRpsgLFu70994uzjzpmEMoHpPvLZyokpITF4cg==
x-ms-exchange-antispam-messagedata: 
 CgDzTPxVFRiB7Y/HdcYDGJiBrFV2YLGKHBy6aRj+tp/ulciVrmQ2YAPkz8XzronLgM8OSp+5cc6pdk1u2Ka2xBFJA1P7kjDAgUe2eozF6l1io8LRy8OHlksou0g5SU0DsHOtkIA+YtBAMGafBhgNC02q7C+XCBRtd8qs0OzgFJAMxKZ1jD7QuNXF9r8aOeQ6eSk/uKLi8yFtqG8B122zV2xtXwi+If2xcvbpImE5/ze8kNpFDxSfO/gGVcA1VwsQDFi01r6KUfhKLSguems5wnBAx1ToCQjaT5QuzYugQZwIcC1x0ldKRg3W+nc6Hh8OW/DBZgzEvk8jTYDtFP7lyx3MBKH4CePaVvZeO2tlwEQC1ETI9l71tLHnF+bkrZFeeMAU0HZ3OjXVq0ZiBcSloZHghl+IpLNwF20MWIsDZ2B3fsgBj8WFP5nyg0ZIQ+k0x1dpmRmwgc8P89gZwqUzdLvdzDKbLaNc51HCqjJ5LAvyYoyhBrR2p5PxUWK5tuR0yrAQuycmUYBw4x7WUUlPBMuCkNxjMie/k68LjaK+P9pD+k++xY45TxBdrVCPzWdXVivsgALZzv8skXFAubuYB4N8Qew5FoOCzw64OVcd2QHPOOSM74r1uH9Mm9nq5TcP47a7F/L3/BLBl1Le5ZoYuQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373e7bd4-aadf-46af-54f3-08d850a678c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 07:45:19.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juIPHQQn3jU0ym2IHTAF1+2Ymg7CqjPRGB7nW//RxMyDazBGePpdHuNDJRmSD1fLvPRJ7ph1du7iPF8QRwEYKlu9SAf5qpsC3jsmvpVJv6fqw0Q4MD+QSXfyXcp7JSlG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1703
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2xsfAZbp4fvIlvFewaDG0WAIx4520388AA=
Content-Type: multipart/mixed; boundary="bzqGpmzD30a1CnStRSeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599205526;
 bh=gCyCssaHm1YkGIUlqQez97ykvRMp8VTVLKp3KjYBzZU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=WBlrBjw4IkUPp9/HPuQ2ppuYkPYaGpKwTenqN7IuX+in86V5mhOEXJkU9ipP6UvlGNb
 JfTqXV0jqCkUBVhur6u82yY7hvkHrck6FVYnKozBo63hiKmhjfm0flJl4IUzrBRs4tnv3
 QAUt7Ibe0pYOyHv5vxoCHCBshBC0ah/tZQs=

--bzqGpmzD30a1CnStRSeI
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Prabhakar Mahadev Lad
> Sent: 03 September 2020 19:01
> To: Pavel Machek <pavel@denx.de>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
>
> Hi Pavel,
>
> Thank you for the review.
>
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 03 September 2020 18:55
> > To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamats=
u@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> > <biju.das.jz@bp.renesas.com>
> > Subject: Re: [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
> >
> > Hi!
> >
> > > This makes the driver use the data pointer added to the gpio_chip
> > > to store a pointer to the state container instead of relying on
> > > container_of().
> >
> > Okay, so this is a cleanup that makes sense for mainline.
> >
> > > [PL: Fixes 6e52cced1aa58 ("gpio: rcar: Implement  gpiochip.set_multip=
le()")]
> >
> > Does it fix set_multiple? ... seems so.
> >
> > Fixing set_multiple is possible with this oneliner, right?
> >
> > > @@ -541,7 +532,7 @@ static int gpio_rcar_probe(struct platform_device=
 *pdev)
> > >  irq_chip->irq_release_resources =3D gpio_rcar_irq_release_resources;
> > >  irq_chip->flags=3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND=
;
> > >
> > > -ret =3D gpiochip_add(gpio_chip);
> > > +ret =3D gpiochip_add_data(gpio_chip, p);
> > >  if (ret) {
> > >  dev_err(dev, "failed to add GPIO controller\n");
> > >  goto err0;
> >
> > The patch is okay and now I understand why you want it. It would have
> > been nice if changelog told me directly.
> >
> My bad.
>
> > Can set_multiple use container_of() too? We get less differences
> > between 4.4 and 4.4-cip that way, and it is still one-liner.
> >
> It could use gpio_to_priv(), but since there was an commit upstream alrea=
dy I just pulled it in.
>
I have now posted a oneliner patch (https://patchwork.kernel.org/patch/1175=
6155/)

> Let me know if you if you are OK with the patch or I shall post a one-lin=
er.
>
Please drop the current patch

Cheers,
Prabhakar


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--bzqGpmzD30a1CnStRSeI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5416): https://lists.cip-project.org/g/cip-dev/message=
/5416
Mute This Topic: https://lists.cip-project.org/mt/76607574/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bzqGpmzD30a1CnStRSeI--
