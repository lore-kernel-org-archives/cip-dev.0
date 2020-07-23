Return-Path: <SRS0=4tCY=BC=lists.cip-project.org=bounce+64572+4986+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E430C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 11:31:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F3020825
	for <cip-dev@archiver.kernel.org>; Thu, 23 Jul 2020 11:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cgHQgdFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F3020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4986+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3DPBYY4521723x7M9YnEhUYj; Thu, 23 Jul 2020 04:31:01 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.102])
 by mx.groups.io with SMTP id smtpd.web10.7036.1595487366745712250
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 23:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqusJCCkcJIiQiDwssIMjYS7Fq2pwd+Gqar6TQtSwPm6e+lDqqbeWUuPcbKVHpQrWsh4Jpj2g96FPJPr5ArByZ9EwSusoeQL8hr5rKgTD0K2M6SEdZ8mW1TGX9YAgU8dRfhO8xSx+DN90imE2oLUilg6AiWmsvIGHaoJsz0h8ScVHRKxEvOwicj8kwMU5IP07WhhnOcOCaU46WhtD0aEhEk6yWSouCCnqadoYnIwHY01Ggeg3LiI3YEKQQ5tEycpDafj5AIhcb+xmXCENoBN2Ki0i4xnpYshOq8tyi6j3UynPHQxmA+Y4oK0c3VWig26TPOCvXTKMjU2AhSE4AEYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePErJ+EYVJ0ZAdh86RYeOrf3NsGzVD1wO8slT/+ZPTg=;
 b=Epyq2GIaBOfraoPBP1sNhju5cpY2PgMX82OB0KEDGOq3SFoGZkUC6ixBzPUVutUJVJUy+OzVQs3B1u+8ft37Hz7y4siGbEX2srJVfjEc0It1nrMZTHb12QRzsIgYFpKy02dVQNA6yTpaGZPkkHV6LHuAICVTdSZIf/nFOnqljG/QjrUjNmhZidjWA1xt/FfQJxmd/cCZpetrQP1eACdHmY+4RmkLm1gE0tAUYI83Y0Ik8C6Q0Mn9juvcXDKmQcuPd6rwZrOBlD1La1HEHS6rXdm7CZsAiuH+tne6mkb/YYZ1so+/Am833mnlHEyJ59Df5pywA341uTO7tkREhDhfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB2105.jpnprd01.prod.outlook.com
 (2603:1096:404:b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 06:56:00 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::590e:ebc:1f09:f160%7]) with mapi id 15.20.3216.022; Thu, 23 Jul 2020
 06:56:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 11/17] drm: of: Add drm_of_lvds_get_dual_link_pixel_order
Thread-Topic: [PATCH 4.19.y-cip 11/17] drm: of: Add
 drm_of_lvds_get_dual_link_pixel_order
Thread-Index: AQHWYEYTuG4rkvHojUq1QMx26p2b6KkUIGgAgACbCLA=
Date: Thu, 23 Jul 2020 06:56:00 +0000
Message-ID: 
 <TYBPR01MB530969DA52EC44A5164EA90E86760@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
 <20200722163449.3513-12-biju.das.jz@bp.renesas.com>
 <20200722213846.GA16146@amd>
In-Reply-To: <20200722213846.GA16146@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [31.49.74.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8befbf5-5958-4e8a-7bdc-08d82ed57577
x-ms-traffictypediagnostic: TY2PR01MB2105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB21052456797B73856D8F885386760@TY2PR01MB2105.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 mYSbVqa9+ZpjsXX+aFnYj/IAb7rU2uJnY0rBEKy4CvI3z6Qt8dJ1VPJ86Mz64Rp7dZUVM1LFVW83pmDcga7Mrr8gdcoHVIgqvWwAf+SzJAIN7KWE4/G+MLMFba34CCQhA5LACsCJM134R7qkuSrXBXG0eQFJxXDLPIh5txpWG0xMJwxdYPgoNDrSuDclVvCndkKdnxxfgcuKfawFc7Wi6+z2yhh/7iA2o+fQbcBaJxeckEGZ2pGH8XA9rtPwHoR40WYODsMS0kYYtkaFUMBiMqXyQlbqtjEjg3WbkrQkQp8hCOUKJbcwEB5l+64ZzE3N
x-ms-exchange-antispam-messagedata: 
 c8CIQ5gKZYd2au/aaJ59zN2A1WLrj4uwCuWTIiYjTf4AzXMlAFCQFzVHAx6jLgdNtmowSaD3ba6rkl7QMqK5Iy42XBe0RdQ/w2nu9CpXj+Wwd6rdQriEgbcVgSWG+9FsaOQdemCuABzs05edU5kCjEljVoKeYCFDBOJ4on1DcMdXm/KP+7MfJZP/z3NwV7XPbtYkMYxhjJ+9MBTpTsz+dmUDZgjNde0ZSpPXtp+IiWAf2UQ6zlDmncHRGHnT7C/sigvGRIHKH9cyM7mUeecj9Xh7S9vSYIxB1yPH/x7e4as5cmDDQUG2RN/LkeQjBSZiE9E524tCHWbnVpLAdQxcIASkBUSE6J4nFdIMt/yci/X8gGY3bd67eOT0VGILZLQKsbCxABbRd0UiA3Mc4DNrV+GIMP0rLYsODS/BR7NO0EXziZbBuj+LeZkPi7KVc1nSq2PvTqTVjsTSS/7ocP6eWUjCWwe/8hHJU2RCi0yBkgw=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8befbf5-5958-4e8a-7bdc-08d82ed57577
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 06:56:00.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NezN6O9VbTMIj3PLs5rrLK+S2eBi8G5aCs5BNo6CZCEy1lIoOJ7Dbby75A6en+GXujK/AZmYf8/vNQbumn2MHX2+VChwFppfWDM+JWKoHeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2105
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PLj1iWgRyiFk9Cl1uA2XiNWfx4520388AA=
Content-Type: multipart/mixed; boundary="sJBfQv7FjaFvf6v14bVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595503861;
 bh=EMHwvuqYBA+FKByfBSZey9sJy8JrfbbsNu1d0GE6Q+s=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=cgHQgdFIgOuNBBV0YFHLxkByS7DHRbZ1kZUQsW1fwLT8pAyPofZS84C3w80ouwSKzGQ
 HQIMROzTEYNQ8zIijJ5OofTcgkPcCNjO1nFyrvhbre+JYdKQU8x93srKOimhFynsNpSNu
 rS+wqm5/1KO06aWJyHzADjqUwVi/5EtZIs8=

--sJBfQv7FjaFvf6v14bVD
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 11/17] drm: of: Add
> drm_of_lvds_get_dual_link_pixel_order
>
> Hi!
>
> > commit 6529007522ded00b8912c079250620fa7a732166 upstream.
> >
> > An LVDS dual-link connection is made of two links, with even pixels
> > transitting on one link, and odd pixels on the other link. The device
> > tree can be used to fully describe dual-link LVDS connections between
> > encoders and bridges/panels.
> > The sink of an LVDS dual-link connection is made of two ports, the
> > corresponding OF graph port nodes can be marked with either
> > dual-lvds-even-pixels or dual-lvds-odd-pixels, and that fully
> > describes an LVDS dual-link connection, including pixel order.
>
> There is double-free bug here, AFAICT:
>
> > +for_each_child_of_node(port_node, endpoint) {
> > +struct device_node *remote_port;
> > +int current_pt;
> > +
> > +if (!of_node_name_eq(endpoint, "endpoint"))
> > +continue;
> > +
> > +remote_port =3D of_graph_get_remote_port(endpoint);
> > +if (!remote_port) {
> > +of_node_put(remote_port);
> > +return -EPIPE;
> > +}
> > +
> > +current_pt =3D
> drm_of_lvds_get_port_pixels_type(remote_port);
> > +of_node_put(remote_port);
>
> You have put remote_port here.
>
> > +if (pixels_type < 0)
> > +pixels_type =3D current_pt;
> > +
> > +/*
> > + * Sanity check, ensure that all remote endpoints have the
> same
> > + * pixel type. We may lift this restriction later if we need to
> > + * support multiple sinks with different dual-link
> > + * configurations by passing the endpoints explicitly to
> > + * drm_of_lvds_get_dual_link_pixel_order().
> > + */
> > +if (!current_pt || pixels_type !=3D current_pt) {
> > +of_node_put(remote_port);
> > +return -EINVAL;
>
> And again here.
>
> Now... it is only a problem in error path, so maybe easiest way is to fix=
 it in
> the mainline and then backport the fix here...

Yes I agree with you, there is double-free bug in error path.  As you sugge=
sted, We should send a patch in mainline to fix this and backport here.

Cheers,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--sJBfQv7FjaFvf6v14bVD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4986): https://lists.cip-project.org/g/cip-dev/message=
/4986
Mute This Topic: https://lists.cip-project.org/mt/75730029/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sJBfQv7FjaFvf6v14bVD--
