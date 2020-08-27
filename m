Return-Path: <SRS0=+5bH=CF=lists.cip-project.org=bounce+64572+5282+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8150C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EE220738
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bCtr950E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EE220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5282+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NmsUYY4521723xbsHVQ8XKFX; Thu, 27 Aug 2020 04:35:25 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.95])
 by mx.groups.io with SMTP id smtpd.web11.13480.1598512001300499213
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WulIwNoy9Of4hI4bTyQlSUJZkbeeO8pY3KCRH63jkN3mi1PnR9vvMTQ6hQWBlTGJw75/ar/TTZlIwNDWNjwdvT5lZHKtQN2e81A4nCWQ//cw6JMpAHsDqcAc9sEAXubJ3jPsV/TFjjRrlwv8n9YGoj+vGjOqI0xcpzfUbzbDFXSro5UWsUhkCaK7/1LYAMB9Tf7OZ1huOvoOJ4TymnFBMf9MeagoLX26qvaCpz80yP3Syd/R1W8BRhVj5lp0jAbhAneTdJ4KjMnTlNiBlPjpVI3neNVL9OiJvAlp+cGLvlS6mP1m21Eq/3YIv2NRHduTflddQmTviA7aVk4Cr6NCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKeHm3/gvQYMrv2vagCgVhZGVQi8ZtQM41JH4ty5ymI=;
 b=jNqb9FkO8Nr84BGUAv/kKRvolecJY2TILcWa+F9HraRsatoYrmNHR6VCITKvskQU9mKkcqPFPEMJJIUhW0LwWpSLGMyfXt+jKsB9BGmaH+7KkGF2u/+4DepCKNcfHue2FVAjlHcNxCgTgwGckWkaMbPRVTuAbvtCItPZLi/Dio4OL/wqbnsigGf7jaGW1huh9AR8qHxYILhLoK6MAAErz9gJwD1O457eudUmPmcmNSLpBlr0wT05QHUEPM8SxLDgmnZheQ+xf6yQYDulAkotYcCZDALEeFFmlQshpIQMk+T1n2iy88bAbn0EWSDcYv2tJIlFiij9am5LRh7SXLLcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB3773.jpnprd01.prod.outlook.com
 (2603:1096:404:be::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 07:06:37 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 07:06:37 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add support for
 [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Index: AQHWe5sTPMVwRKFHTk6T2YjLVWDZRKlK7XkAgACTgfCAAAcvgIAAAGkw
Date: Thu, 27 Aug 2020 07:06:37 +0000
Message-ID: 
 <TYBPR01MB5309F4A53E0487828CB66B5686550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
 <20200826214624.GB15974@amd>
 <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200827070003.GA20517@amd>
In-Reply-To: <20200827070003.GA20517@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cd2819b-b5b0-49b5-3140-08d84a57bda0
x-ms-traffictypediagnostic: TYAPR01MB3773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB377388CEB9403904A46EAB4D86550@TYAPR01MB3773.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 P5M4i4OJNid8RfqwYNJXijvsC662EHtVmb8tDiuHZTujYL4pwY6SMuv3zd+3jTJkaoE/vLZjkmxXC5JWSRyFfPlntxSvTZ0mW4OzVyN6wTWqL1bOoAHbROR5REda3isYyO2u23ATFY13VQ7FvxF9MZZXAnPbhjB/fzbMh2RLgxraL8MZCs8ddaqApUdJTsOC8CcG5yB1XPhLKe+F8v8JsQ49a5AxwEETdyar8bwdXAL2L2VG5Xm2zGFOJi+bzhCqxAL8d8lEkyzJzpplRSfORBllxMQulVKlqnqvYpyiNcRj0rqqh8TlomAZCbwI2W470nzHDdR9VyvqKbB0L1W1vA==
x-ms-exchange-antispam-messagedata: 
 FeWCcGgXF7/qJGLBHnQL2Ydk2Zb8x6PuHQ8Tx2VN6q3/NZI5KChk4qQuy3wmzFeM1Dlm+/8VklHp97yi6N89fIbR4p8gziEurUTHPvYSCjR8X3WKwp5FPrPowBkD9476dTfm/ydFiqxv0C8rwxlwZJojeMziNlh2c5v6RpdOVzgSPkBP7fnlygQeF8fl2szUjyBWdzYJ8w77DV+4y9BYUDR6/t2H1kaWdvQ06Err7xSRd/NN461/urGg5jRuASyZxjBmGiY2KQ23/NGKXm5xV17KVNuea6/5T+aOpDMAeB0HUYiahx6DrHzCbT7qxPCepQzqwhJJhthwUcO+tQVRnUYeE9XLbPQX6S0AxJzeBNYY/cugpX07Y1wVBEbrHH08vo5dA9RaBRp4aP++iwygqw1otMEGJJHH5Z8vc9wEOOOQtHiBvJYl/d/0KQbQjN8zxHc/32ZszeJWMcSyeKkUvql1gTIaX+/bjeDQwC8FDaJp/NMZ7oXW9pN8+CIbP91AUGZuzDHy3n9GTwjviQL55mvWk/+41bGLS/jeLlfWpQvRNEdXx3EPPAAA7U6ub+MNYKA4KjrGh9owAVCLsKSHY9KmVcV0B6L9RECZD5aK5G/llIZZf9p3gbH/wp+xtX8fzt6JVZKmwNnOrS3+j8xHRg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd2819b-b5b0-49b5-3140-08d84a57bda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 07:06:37.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fy9vCC0TDrOVYAMeBt2g6otu49IJLw8y2jgF0+ieM+8ukfrHhCP9p9Tg715NRNsPcnB2RKlDuBqf5G46riCaf3UUpkKtAs4ArhEYfCQYv50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3773
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wkEKtlbMUndvFIR6m8maGfRnx4520388AA=
Content-Type: multipart/mixed; boundary="sd02DEE7DUS4rZ4sWgVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598528125;
 bh=q/z+wfB0/Ya1yjeSOU+St0+E/VlygiLw23wOalCHYao=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=bCtr950E+rmEOy57NEaK29YOH7hRcGAGDdcHOOsgO+pERVfVpqBMjwwRAmfwD2fcUBc
 KAo86zvsUDJ44IuP8u7NHaQen/CT80v1O6Vg32/neUYGP9HUUKNa7khTJBw99v8dypr1K
 JmluZGYKeb89/5nJxu+6odeuEGZ+ciS6X50=

--sd02DEE7DUS4rZ4sWgVM
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 00/10] Add support for
> [H]SCIF/SDHI/I2C/RWDT/MSIOF
>
> Hi!
>
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH 4.19.y-cip 00/10] Add support for
> > > [H]SCIF/SDHI/I2C/RWDT/MSIOF
> > >
> > > Hi!
> > >
> > > > Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on
> > > > 4.19.y-cip
> > > kernel.
> > > >
> > > > All the patches in this series are cherry-piced from ML, except
> > > > [1] which is a new patch similar to the workdone for other similar
> > > > SoC's
> > >
> > > Series looks good to me. (But gitlab testing does not seem to work,
> > > and it would be good to test it before applying).
> >
> > I am  not sure about the failure.  If it is related to testing on
> > RZ/G2H board, then
>
> No, it is definitely not related to your boards. Nothing ever builds... i=
t can't be
> your fault or fault of your board, but it just prevents testing :-(.

I have applied the entire series and it builds fine in my environment with =
linux-4.19.y-cip(4.19.138-cip32).
What is the build issue related to gitlab testing?

Cheers,
Biju


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--sd02DEE7DUS4rZ4sWgVM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5282): https://lists.cip-project.org/g/cip-dev/message=
/5282
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sd02DEE7DUS4rZ4sWgVM--
