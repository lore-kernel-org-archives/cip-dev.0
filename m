Return-Path: <SRS0=yMeT=JK=lists.cip-project.org=bounce+64572+6370+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8AC433B4
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:26:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DCC61370
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DCC61370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6370+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6ZCHYY4521723xEK1aZdnWx0; Tue, 13 Apr 2021 04:26:50 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.114])
 by mx.groups.io with SMTP id smtpd.web08.7558.1618313158391888789
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 04:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2d3hqf66w7PF9KkXLdB9N86Rl9O7q6VZzW7jsYKx4B/eceNxZeX0hxUokFXj2n/C50TKS8JOpLcglmnA86/xRkUbJAf4iVRyTipPcxQLJjQ+Fnq4gqkhPUipvEcFP6rIrBPmNzbdfFSuUeqsy1Mbur5//QrlAH/7OLjC72dkORzEdF9vwnUvAF4wZy2KbBVgLxxre0c8gXtpkDBha+WvlnJ6Q3TEXtVI67/b5UiFB5xIgO/Pp0JbzOZEFse46v2xL/NOYEvAw1/FeS7eCGjYL9zvmqYFCOEDlIYG/rAqUqowixJKKmjL07BTxMcNeC4564Gucud3fFZVa1/jpDiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnC53H8XS718Yy30kAI9Z/87mjAbbh5jygmLBKS6zeU=;
 b=aGP8jso95RTngEdJcSvb0MESOng3Wlcxq56/uQ0RnsfKio8UKCTPsfa0oBk+qVRIc1PpUcMQLgXvz9e8FbRUbYpJNSr6JDJ6Ki3Kzt1tuINfhUezG6rR6KivyNVE/rN8SH7TJeKzQoCdMLKp4T5O+vd/3MYdJJ8fuOMjcprPVMnEwr9ILVqjhA9M2hWaXnW8M+zgmbwh689TFvuC6JTRdzE0VmUw9LFeCqrlr0SS+Cv7SnUVckRE4JBb6OuEFiYduuPR21gdSuRCkXIVG4LpXPHObXpy9elkpOoBqKR6mqeJrbAd2jQW/YR1mByqH1E3br9iTZBUv/JeWoSqpCQdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5409.jpnprd01.prod.outlook.com (2603:1096:604:ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 11:25:53 +0000
X-Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::a1c6:97eb:7268:c2b3%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 11:25:53 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Thread-Topic: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
 clock for CRTC
Thread-Index: AQHXLVtz1UDxVgx6CkinWM1fXXtH9qqyQDiAgAAAXbCAABMiAIAAAPFw
Date: Tue, 13 Apr 2021 11:25:52 +0000
Message-ID: 
 <OS0PR01MB59225BADC1FF451D23669D85864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
 <20210413101210.GC26782@amd>
 <OS0PR01MB592230BE36B888893653B0D7864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20210413112158.GA13447@duo.ucw.cz>
In-Reply-To: <20210413112158.GA13447@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.139.26.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f36f6541-7b3f-4516-ca5f-08d8fe6ee60c
x-ms-traffictypediagnostic: OS0PR01MB5409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB5409D855514FF2C76CA81C19864F9@OS0PR01MB5409.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Fef5saz5hZI895NNmuGAOJYflgEOVOXRXof5xR2mLb5fWsUqX6D4htWSDr0hIG1k9FeB+ZISF9DSLAWA0fC8RiYcnaz6CSnWy5cGzrcenWCzLT5OOlrg0StLhfoAs99djUs61HyFEM6eWSXkC9vd3pMS4r9PZD2HU3VqQYk7PHaVVwpcLsEuEHmrRTWvnpPgA3RXILFFgX44cdk69Xw8H3U3yEPjL7GIoCIDdgYcJe5rYCK0Q04a02+LjGfI4nWRvNpaf1QTXw2ohBS9qbII5nYY4NjGyf9sqV4zRTSPuSxi4iAhF0qLd5bVc38y5KtjfTMcAMhRsASiabSqc4WE04AKiBVIk3VY7cebK3C6GCOxu8A5NR5SsthtUj0pa3PW3tlRXMq3JOH+F5pQuCYl9Y23gsPNbG32hNZxr+xRO55LedgCZZOhQnsBpTx0k+d0F2Qe73ebYf0xFFN4jlflrAUpsz9igsEgxS+Kde1LsN8gVwK8vDZFkNMoSRH5M3uYRh+JUuAATIEO9YH7FI4u+QIc5PkxEbPV3v8I36VvV+0QFjYOD2O6ehK2axQagIsZE1YWldglP1GBK6w2U+GRm063A9iIJA3ni0wDlnmXENc=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?zNyTY3eGSUhaOQ8YDd4cbM6IHLXIY1h3dlK/b2t1I6zkGs6zerFq3I8vRH3N?=
 =?us-ascii?Q?OrB9j1SCvUwCmydMjRVhcu6KxSNI+9G0uKMwBxnnW0FI4zCC0oCnbYw3kU33?=
 =?us-ascii?Q?32T0bLDvfKQucuBUZItLDG6z656JwQbHhKdM7Tbgxeb29aM0OuiymWBRNKPG?=
 =?us-ascii?Q?+VWA0H6UqhXF0wvC8ezmoRPLnHNdXKBclm/hPw94nVkrwqqgXTCd0/4TU2bu?=
 =?us-ascii?Q?RqGpZxjJGs3zAjhMxCDjckROHcv5MDnnoakWJc+Nk/Q20Wcru99G3l5JUQ7y?=
 =?us-ascii?Q?YhzRGzddwiitizswWexg8gLhZCT1jV1cyDLHjOLddTEuuYfcfN+wU9CTOd7n?=
 =?us-ascii?Q?BRCpnt0QxJ/sg7yKQXsxc01gRUb+20jNrSfeN5Et3qvNlOP8vHnJeOzOcmvN?=
 =?us-ascii?Q?koSVT02aCAijTtGlJG794wB2NXMGtgWPq1n5479i8pplHWxDYRgeeZwqdrmm?=
 =?us-ascii?Q?ERg1d1lLrUmvWen3WRt4MK89wyX4uNjdsJakCoeHCyHCiLkAt9+XwNAtFs8y?=
 =?us-ascii?Q?yuXHBK9vxHiaJxoSzJ+8mHl10d90xstq1/HgBKSH0wT4JYbuJppFCsqhVWK7?=
 =?us-ascii?Q?ROOUe0vDp1sarW9X3pk5Ziz08qotHoLt7ZMRAKDCnnC0cygXfvOXtzhnENMr?=
 =?us-ascii?Q?K0DK9UmG0MubHR/G9HM9kBU86dOziruUyS8ndc0Rt3rBG2aoTuznjuf2BgOj?=
 =?us-ascii?Q?W0R8zvbSiJLnxzmy0EAz0HYZ+CNl2Mf0NMsPsEaUHq8nFha1fz+92pe0TQJO?=
 =?us-ascii?Q?0dqqKUNYAFiBk8jRZYv9jvFiMCDq1vgtpu2mPEN0PB+YRqtjMWYBVKyTvYEC?=
 =?us-ascii?Q?4bUPDYbmf/DaPlXB1/44y25/V7WGrylQzbgnlqQVCz+YgjKJxmuN0bCiiFgz?=
 =?us-ascii?Q?soQjYh6yj2Ekd2E9LeOW7W2S3Ix005LCVtXrnWcs/PtJRudFbr/Nx9cG5J7E?=
 =?us-ascii?Q?+Zf1PXeCSQOBMGRb/Be7jHAGk4KpHFM41SmXnYg+GFsPSJMUbQexdVtUxw9U?=
 =?us-ascii?Q?WwtADaj+U1bJ1wtVOcqLNKEURDiXsHlWd5X17HC54111YwbpPKDCnI1Wo2mK?=
 =?us-ascii?Q?KPtLtWgRbOFa2DRNqt6b9FzkmRx6+fB1x27QGR6WgZLXRxlswMW1Prds/+tf?=
 =?us-ascii?Q?JMAgyyUX8WevGvCxJ4xJCn+f5VZ8wVf7yQrB45HnXawLMNqxk0u4VD4ZtlNl?=
 =?us-ascii?Q?F1RyiY8mBvh5LrUuY4Rj+EMD+Yfci8Fd6hOvditiX/alGwD2o7D2yxIOl1UK?=
 =?us-ascii?Q?Q6aNn7VjEpWOLst2Yc/+DHqQmS6BhxEmzwnT/YSZMJesignk9z8OBGu8eIgX?=
 =?us-ascii?Q?2KDz6kkSk/Po9iN0GJhjyIyE?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36f6541-7b3f-4516-ca5f-08d8fe6ee60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 11:25:52.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNi80LZHd95YFvoQE2bzFovEL4j6AW+LterpbE9ytsaPvlOLbaQX2qjiWDHleCl1KMHffTZ+pBQIqQ/OuXtSOJoBzMb/PPZTzUcWVcW9FcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5409
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FHpb3SRHEvFYUyNQytiaFcLtx4520388AA=
Content-Type: multipart/mixed; boundary="JjFso5xwNPQ1loX7fOyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618313210;
 bh=Y+pD+KFflZ2tDrIYZMwcDyd+RH2KLmAYDmVeYRIlXmE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Lfkg6mIvKMrXeRvLLPdHOIncGf3Wur13j4aX/Xz/4NtsIt4vzkyM/B1rL2KcYdwXXIS
 DSdHnFIu2rzX6n/nMOytCWq/+lzgJ61X1cf7J+3ky6gMGVUDUNsbJBvA/0hCQ4txRnsJe
 j507WRsdQxWTZ1TDzH8cbhNT7jfxIjztHvc=

--JjFso5xwNPQ1loX7fOyL
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Subject: Re: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
> clock for CRTC
>=20
> Hi!
>=20
> > > > On D3 and E3 platforms, the LVDS encoder includes a PLL that can
> > > > generate a clock for the corresponding CRTC, used even when the
> > > > CRTC output to a non-LVDS port. This mechanism is supported by the
> > > > driver, but the implementation is broken in dual-link LVDS mode.
> > > > In that case, the LVDS1 drm_encoder is skipped, which causes a
> > > > crash when trying to access its bridge later on.
> > > >
> > > > Fix this by storing bridge pointers internally instead of
> > > > retrieving them from the encoder. The rcar_du_device encoders
> > > > field isn't used anymore and can be dropped.
> > >
> > > The patch looks okay to me. I'll test it and can apply it if it
> > > works okay.
> > >
> > > But I don't believe it is in our 5.10, so I'd like it to be
> > > submitted for 5.10, too.
>=20
> Applied and pushed out.

Thanks you.

Regards,
Biju

--JjFso5xwNPQ1loX7fOyL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6370): https://lists.cip-project.org/g/cip-dev/message=
/6370
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JjFso5xwNPQ1loX7fOyL--
