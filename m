Return-Path: <SRS0=AqpU=BX=lists.cip-project.org=bounce+64572+5115+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76432C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:16 +0000 (UTC)
Received: from web01.groups.io (unknown [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426D820771
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZW0+kaW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426D820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5115+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KmSAYY4521723x3VGa0Fxrzm; Thu, 13 Aug 2020 04:43:08 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.129])
 by mx.groups.io with SMTP id smtpd.web10.4987.1597300799957880780
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2020 23:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg6LrKFI3eO+b8en/82GIrv26Lw1TVHnwzd0e+65MP+OGV9h2iRb7axvLl42b3tIo85CdeYDfFjI/7CF8QhoB5udMGs7f7BMwrDoVrKSl09oyR0JwhzHc0ADmPCx8LuU1YhfBngjx64GdLr9LZGH8hyXqq0CZt86Q04Tytu/Pebla24jqPc2UtRSVqoOzfvCWgLnIb3XT/38NKtg6dV3I75033YhajkXR9fFK7kfPLSf0XYdhtHR87Cd+v3ozLn8Di5BFgkRqF7txuWJho7SST5Osz8pYi9yxoZy7KVrAcn6/4gglXBvYP+pKveHJ8HmyWvOhWWnG/3kj+B7bwONBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEgmuJ5it8w3qvFXyixga0jCJFd8PyqcBp35BQLceZ0=;
 b=Md/9jS6V2IdxTQ52kChVottxuqh+oIUawGoTBfLP4ILG6cF4D557Pge9lnez4FjMvioUzfC5l+bs3tgWJ4+kA5/xAFozN+XA6eaWTo7yPp8G4gmRkLpyKVc5rTnEKs93FKjEBjdE91L0m42PPfBFidtd/m1ksjmV0MuZ4sjM4Y6g5680NBGYW8zU0xkw1VHRVMPivmmbb3ftv48k+hL8l0letdYEpaqo0Aby7riwXhOxhJiSl3Q+wHBqKeKKanfgJrsIv8LU2MuzCB1dhEMB9G0C8yatEkjXVraUvT6KNkth5vSJNYCAKTCc794jej4c+QniNFs/gVgXNiAEtAKu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB4156.jpnprd01.prod.outlook.com
 (2603:1096:404:da::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 06:39:55 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 06:39:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] drm: of: Fix linking when CONFIG_OF is not set
Thread-Topic: [PATCH] drm: of: Fix linking when CONFIG_OF is not set
Thread-Index: AQHWb+1lvL7cDuiS6USaZ7Uq3EE5Tak03JGAgAC7PRA=
Date: Thu, 13 Aug 2020 06:39:55 +0000
Message-ID: 
 <TYBPR01MB5309E07DED8A1ACFB0DDA8BA86430@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200811144040.4398-1-biju.das.jz@bp.renesas.com>
 <20200812192435.GA19363@amd>
In-Reply-To: <20200812192435.GA19363@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4527f22-942a-431e-f1d3-08d83f53b0fa
x-ms-traffictypediagnostic: TY2PR01MB4156:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB415667FE7B5928819DDCE6F086430@TY2PR01MB4156.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 xKCgkFlzlTWqQ5jGrDewS3GJM++NxzoNOt1sfqQjPvBXg6OMirjI4QNonR6BKb8b3+EDLkufyzZOnr9qPVmg3KKOL0WiEV9wLjn2kFp5EBidtQOFQ0YaPZBRgBTimurdrcg0n5c7VqhDjxGqhsQlaFYT9JoPSA1IlVHft57kE897yMeV3KzU8ZgdGl3CA7tQ/MaRynT+hUd6Zy55OWWl2Al6/L2pP+uUb6oD9pxdXEz/eYd/j00VBrFU0ZvuVN4nIxInJOci7C95DHXJmCXvWE4vC1zrXu/Gg6X38yqD3o+D8B6dQcrEPN0KA0GtY0YZ0SmuGqiQ1+K/Q2/LUgFfDA==
x-ms-exchange-antispam-messagedata: 
 ecRuwCImAUKOVEuIuHjqdBOkpcJZwbUV/JTMZr21m3c9n0dk9aioAo+lTIJdsKnvVuuJbiTlBlFEZzFzCp4FEPgERRK8yHzhuWwfHr7mnSGZq4Tk+3vQE9l24YXmOJDlqXPFMlgSrCZ/NJ2VFAD56czi/diyIRWTMJVNvUnH0BWs4DT5ykC4qpwk4rUUCsAUqV8g4LLvJ6aAEn3ozTH9vALwXPy8Luuuv3/sB9OrPilVBjj3ZOrReVpTQuuMiPscAO2LEGyOgLdXdRpUStqC+p4YxEmm3lRpX+Rvjq6jMZoVkBiqsc6PeIzqC0mOoTmEezEnDJCEERnnUjeYoIOIG+yELjOIzJN1TBRFcENXefgZWc16rVWIHJEsxlMaLqcoiUky6Ezcl3Nu+/snti8dVKPoBGWWrCo+0dZouOBQlEuWNZJe/eaTsK6x9orBDYEzoTZzBWlV7o/mOQxnUMohyh4TeJ0pEVNRoAfZOfdJUqUie8yb8/HjViTNOehhouoPc2XvtIOodJYgBG2/hbwsjTDq2t+j7Ll5pwXdE5MUuU6yA6Znnz1mK1bwcN8J9CGwMACh4KyQJIXipBhGROf96/D+Y7HsdrV6mUrfcZ8QILtiP2JJahEMDFCJ4oT8q71K6KuUURzNqCb6f77juYYgKg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4527f22-942a-431e-f1d3-08d83f53b0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 06:39:55.5632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsQAnIw4ZmOitItsaU1HaVy2FtFfcI+f4wfHazE16OHTlbGYKL7BKuYgfyvIbqvf/ZOsOu8MBEVMuCyd9a80t+1e/z0uII4f1pjtk8qKAFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4156
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7MiulEYTXHVYvbf3G2GmcZBfx4520388AA=
Content-Type: multipart/mixed; boundary="7iqfSDoeZdvA2a1zrt12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597318988;
 bh=/IPpr5mUe9ZLu8HGkE2Jip0F+jicCIWlun8DzjUiFjA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZW0+kaW4nYUu53syhzgy/icDDfqd5xwOIFMm2sw2MGTzP2SHtNW/03zGOKn291G2Fz3
 qZ1HjJ06nnh7emvZGHWq4Ml0qSVVqvN3xuSnjpln4/6llxgkDjiuc8AgDGHLGQUBTplBP
 4F3Ko3siJKURz6GJswm2+IfzCoV4w27sFRY=

--7iqfSDoeZdvA2a1zrt12
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH] drm: of: Fix linking when CONFIG_OF is not set
>
> Hi!
>
> I assume this patch is for 4.19-cip?

Yes, it is for 4.19-cip.

> > commit 528d06d41b80a4acb2a9efd33bfc87495147f75e upstream.
> >
> > The new helper drm_of_lvds_get_dual_link_pixel_order() introduced in
> > commit 6529007522de has a fallback stub when CONFIG_OF is not set, but
> > the stub is declared in drm_of.h without a static inline. This causes
> > multiple definitions of the function to be linked when the CONFIG_OF
> > option isn't set. Fix it by making the stub static inline.
>
> So this is pretty obvious, and I'll likely apply it.

Thanks for applying it.

Regards,
Biju
>
> Best regards,
> Pavel
>
>
> > diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h index
> > 8ec7ca6d2369..b9b093add92e 100644
> > --- a/include/drm/drm_of.h
> > +++ b/include/drm/drm_of.h
> > @@ -92,8 +92,9 @@ static inline int drm_of_find_panel_or_bridge(const
> struct device_node *np,
> >  return -EINVAL;
> >  }
> >
> > -int drm_of_lvds_get_dual_link_pixel_order(const struct device_node
> *port1,
> > -  const struct device_node *port2)
> > +static inline int
> > +drm_of_lvds_get_dual_link_pixel_order(const struct device_node
> *port1,
> > +      const struct device_node *port2)
> >  {
> >  return -EINVAL;
> >  }
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--7iqfSDoeZdvA2a1zrt12
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5115): https://lists.cip-project.org/g/cip-dev/message=
/5115
Mute This Topic: https://lists.cip-project.org/mt/76127518/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7iqfSDoeZdvA2a1zrt12--
