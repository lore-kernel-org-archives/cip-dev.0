Return-Path: <SRS0=EaNb=JK=lists.cip-project.org=bounce+64572+6369+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF6C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:26:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6FC61244
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6FC61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6369+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oBR5YY4521723xtTQDvm0u1T; Tue, 13 Apr 2021 04:26:49 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.91])
 by mx.groups.io with SMTP id smtpd.web12.7077.1618309089431969142
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 03:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al2v9gXAbbXsCRX8co0U2Mkl10anwTdTdlSAModwgnqGludFpoFKzPF5uc1Iok8PZ6eUyYrdFzYGnsxZVbf9YnmGY3MD1DebX++nWMRbVHIwpCqE49CSvuYJpQg2n4dLzsc3+DkKyUsKpNIjYO7BJpFL/mIZZLrC0VgUsrDs2fngHNrGvTgY07kCxybdlfg0FMTkSQlC9s0qaFLIt+t0Wfd1B4jJH96Xq1VxsxnGj0HiSol/gT6FVyDBkxPhcVLfgwIIcSzLUcjMlmVDznvnnGOxT5SICbK/ROt/8u+JlvqgFuPKfuqwEyxu2TQzojjWQ9k25uuHvYNT3dld7KNgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PecHRt/uVFgMT3n1lHJCmuYCIycXt8sfyZKyyFRA3T0=;
 b=Zr1Rkt8HYQVrN/gojIsxGZ3vyfvgi9zZ14t6v49tUJVHrFmSC/2zHahfTePMpDFJ4i6C+s0iZKzG8dMJtvOawmY/X4iS98VrcGTXNzRiTDV8hhRkaSXtDZtPYq9zRL7iShYjbvwjweTw3/mjwMZYAtMTeJa0vQQNJoxwna5OFSbZUr7TWwrxCaTtt/0BlkBhYtjcaUoP0DqKDCJBQj0kIpUkaBAX0ANiUZ3PzszPHlaZ5dI76MXrHSNRZ9fJuxAhsm0zHPzOZ+EJ1wj2v4jZZ+a6C6Fa9W5adFYIXjqz6IWU5Shuoj7ujKMvOIp4yGcDi04KlQ4wlTQ+yVIGsuanMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSYPR01MB5558.jpnprd01.prod.outlook.com (2603:1096:604:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 10:18:05 +0000
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 10:18:05 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Thread-Topic: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
 clock for CRTC
Thread-Index: AQHXLVtz1UDxVgx6CkinWM1fXXtH9qqyQDiAgAAAXbA=
Date: Tue, 13 Apr 2021 10:18:05 +0000
Message-ID: 
 <OS0PR01MB592230BE36B888893653B0D7864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
 <20210413101210.GC26782@amd>
In-Reply-To: <20210413101210.GC26782@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.139.26.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac78cc53-b7d6-4d63-2ca0-08d8fe656d83
x-ms-traffictypediagnostic: OSYPR01MB5558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB5558AA09979021228FA49C60864F9@OSYPR01MB5558.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 b/ta1twAKDYWYBOVoKvons8BQeW+5O4PxRgRhDu+Nq7jX+R/2VdUV1cxXQTC11WmolOYbPNPgbLQX4ytyNnHfkO8LWu3vpGj7+nxTnKoP03FQGUBqoba5FIdazf8zhOixNZmLv6YEDaZk/FKHsWn7G33VkXDZSZbMvZBkZHD8Pnm9dY6sfZ3AU5fwvZcwSMLLkTxyrs+G7thQUXcxrgQRjBQ9L/J6PufxcaNfe8YgfQwEpnCfuJ+0Q+g1Vub9T6Wz0dXTSNGxSJHms+JYcPqKSaMyE3tDokA+k3q4yaa3KEIJ/TNFfgcd7SlcOtyDMxNdtYFuOM64DF3RYmvEFLfO3kUEzGUHQ2Etne26FGth23Dg4iYdNa66jdKmu2i0QwLnlV5l8eXdlzB4iOZCEDLuAoErtexbeAAsZCV/n0Uf4iFPR5MrpK59eER8Oj8l1QEQlTOEPvqeto8M1cT8URwmqUem+/XFKamZ4zo9029DQ6VL5LdgLXOH6J+19vRqcTKGv4Z4z+eBgdzTKpwa6F58wZHeuUpxnebIa2QCosiK0bOZZg3bRtgjsUiusnAwvRiDHkwwhpopnszlFBeiujZ88ZRuDFFEiK66Dyg4jbHajc=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?wdm2QGDJQjUJC/7pMcUXLVo9IGqMC75ereT66xvoqp0k0+dGkp49+GRqUA7y?=
 =?us-ascii?Q?FJjK/F41We6BM1zXO//Ch5RimfcE8fqGlnBPEG88gXZf/dV2j4K9HWsTB4jm?=
 =?us-ascii?Q?TRYWCiJAwew/8yZO9obH1HExIJzXmXey5U3W3qOw3tQ5ODwuaIwQJvIE9Eoh?=
 =?us-ascii?Q?KJOCIRxLiuaCwKFPAJVxB2TZ4ZAPXeXH6dljCjOq71sDLKOZIlxzqxjFfuiV?=
 =?us-ascii?Q?aCLGUrVRPU3B1IG/DGFHhLPOCQnnH2FMhI26J6ZT8jD/kllPKqQ/D5/CkT/L?=
 =?us-ascii?Q?TiKVSitSG3HTAQJt1/wvp5kcv6VtD79HmDTlePANEPIaNNXxsP2i8I1c6hfu?=
 =?us-ascii?Q?JJ0rPAqBODtpInZbFVX1KxnYJXIjdfyuZ9z/XBtAGt4QKHIOzJH5As0KWwIn?=
 =?us-ascii?Q?+lmyFHBNOl84l36k+UJlMZYaNXHYlHR3lJ9BbfrHthjSXB7yXHQxf8PPIJxu?=
 =?us-ascii?Q?o8bTtB+ywsvaSlQpVI+QaWDo0KCbfW2qQzL0A/HpRXCcv9SSIuX63nQquKSt?=
 =?us-ascii?Q?VwfSfouM2KafXU6k6r2a2F1KXpZtEteHn5IVtlpl2jVJZzDqwSQ9j0/+QDO8?=
 =?us-ascii?Q?XRXVNyEfsZ1oDpbU12T8zQmwc+qjEF6J0A5sFMME+Jpq9IpVPfQaMSR4ltwn?=
 =?us-ascii?Q?dvt47eeuGCkIHaG2r9BXm1qBWZnVkC2uctkZ6SRRcaq3qJaFehyd2lbtKRMo?=
 =?us-ascii?Q?KGQms4SFVwBJewiXaQjTaB/+MEDqR3Ox37eJu7wgcVJ/S0rTjcTQU17K7Goy?=
 =?us-ascii?Q?4RbSoc5Wlry4flLD6YFES5MwxniNlqC22kmirGrlGD2qajJ4LCKypffFm72C?=
 =?us-ascii?Q?XfTC737p5Ki4zUEWjIF5flxLNXJXJdWFwFpACtnk4/fuSskwEE8L8Mr42c+2?=
 =?us-ascii?Q?cEPMNHUOcU1/o7coxLkVVsdQdpr3vJX5YSv/n6ObQNPxZnH/ymmetBUBuuM/?=
 =?us-ascii?Q?nPjEsvn2BLctK4YKg6YsJKjxbtDBCuqYx1FUteogk4ASwPgigNJU6TdeHGQk?=
 =?us-ascii?Q?nq5QS7Y6O097EY9VW7Rj+Sl92HS0zKa1UA/rdMAJK+3yY1y0qQzk0I0c5+09?=
 =?us-ascii?Q?I6pKq7EsDvLDAD7KwhaD1qGvSdixe1Ptm0akmmm5o+babYWaHOrh+rCpcG9X?=
 =?us-ascii?Q?fWf8D5if6XfJMm1xZUbF5jXG9Vc0e1ksOOXrQ83x0J2ec/PNCNft9GCE+vqF?=
 =?us-ascii?Q?F6uoG4GTG+5YHLdcrIPuYZ5xDSO9LPWOHNXSy7fRa0OYL7m7LE15h6tipvpB?=
 =?us-ascii?Q?Q7RMsZOlTKkpBQtrH+zochiJj9leSeunmh0tuQ004v6Q3LdZzzIaCYE3Oi3M?=
 =?us-ascii?Q?2CqUW/W+50ngEl436oqnNbYF?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac78cc53-b7d6-4d63-2ca0-08d8fe656d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 10:18:05.4125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQBzZQJX6fawLQWD4ryWTspvy0BM3aRFk7VEk9UmHE9vuNzCtk80w/omT9vp0gYGFAxy1xxMGhdJw2eS3YwJXOeVBHyXifrb1ixN2xZQD7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5558
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bIBqdGhA8UjStM4o0PpQHTYwx4520388AA=
Content-Type: multipart/mixed; boundary="6opSuCXxTMz2JpHWHhp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618313209;
 bh=utVI3QA6IAtcqAo6k/EaQgD3MnwOokAvm3xst5twTMY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=oHOZcvbAYxRphTASL74DyvvgSNzxLjKkjuZt16opoZSYxBwvZjt3o6FeYXgNtOShiuL
 bqKm2C8B2zfUew0Ge3HOoUON6Ssm2SU11W4khX6sYvIp3kh30/0qJG9GTn9QhWeqgbWUI
 Y5VU/Fzs+3ZG6uGfQWdxxJCiPktLpz+uYp8=

--6opSuCXxTMz2JpHWHhp9
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 13 April 2021 11:12
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
> clock for CRTC
>=20
> Hi!
>=20
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > [ Upstream commit 53ced169373aab52d3b5da0fee6a342002d1876d ]
> >
> > On D3 and E3 platforms, the LVDS encoder includes a PLL that can
> > generate a clock for the corresponding CRTC, used even when the CRTC
> > output to a non-LVDS port. This mechanism is supported by the driver,
> > but the implementation is broken in dual-link LVDS mode. In that case,
> > the LVDS1 drm_encoder is skipped, which causes a crash when trying to
> > access its bridge later on.
> >
> > Fix this by storing bridge pointers internally instead of retrieving
> > them from the encoder. The rcar_du_device encoders field isn't used
> > anymore and can be dropped.
>=20
> The patch looks okay to me. I'll test it and can apply it if it works
> okay.
>=20
> But I don't believe it is in our 5.10, so I'd like it to be submitted for
> 5.10, too.
>=20
> Or just tell me it is okay and I'll apply it there, too.

Please apply  to 5.10-cip as well, since it is present in 5.10 stable.

Cheers,
Biju

--6opSuCXxTMz2JpHWHhp9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6369): https://lists.cip-project.org/g/cip-dev/message=
/6369
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6opSuCXxTMz2JpHWHhp9--
