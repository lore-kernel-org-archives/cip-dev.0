Return-Path: <SRS0=HR+P=CE=lists.cip-project.org=bounce+64572+5260+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66340C433E5
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B182087D
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="a9zyCLHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B182087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5260+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wmpyYY4521723xHX87PEwyXN; Wed, 26 Aug 2020 04:35:16 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.123])
 by mx.groups.io with SMTP id smtpd.web10.8580.1598433375418067321
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 02:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M79753YNPT4B+ONdKnmzRBj3iC8Aklq4M4wot/gpI4LHhmhoV/S19+5oYEO36rzvanq1ulFmH+r5fwr02CADyPbY0Dc6edkN9WJOn81cjiLZbvRqv79h2F7GQXhGh7Yei55UeUNd7tGB1eigvtFjRc/sWcePFMhgelO7CKKNhmqmME1GpLO5hrDB8WfQ5oEe5L/zpJYIZDrrHvzqGcvX8/b/wwy+zembD4ZmvUBa54crqEGZux6+wWZp7YvDtd0S/ZIMmWYzRkMH4nXYDyJqH82RVLbSFc/N7673TRCHAA6JOz+S6NFbIJB9cYi7x8cJhbqMixEbuhgTQjmNXgwCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcJmboNNEk6A7A5U/EZwjDpCS6bm6K58tdE88ZBRWMc=;
 b=RxedDVYjPH3sYFsBI2Hcmz/cZDTcKEH1vwk8lI4k6f4Zb/ufuIKp48LfJQYxOOwrqz0u4g98OPdRFxZ4PSWfIQFiMja6pc9IliTHUt8A3pEknpz8wVB2mQx5nNbxT4z2jwrYIJNgxnuBbrJPfRYfek/CD1cIpYkAnuk8rnk3bcb8gwVMdC9cPxtSqo29B7v5r3QOpt8UprbwcETf899gugEGlWk1cifqnhgnWfS/dpk+Wg9kV6eYIInSXXP0IKcxaU4UyhxOOxtC1LIGsmo48C8ujoOk8wjAbUJY1hlwh5aGqVwQBWFRJupZoqDpo8MhmD6JWfaWRyRFuxYwAzAQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB4330.jpnprd01.prod.outlook.com
 (2603:1096:404:10b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 09:16:09 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 09:16:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Niklas <niklas.soderlund@ragnatech.se>
CC: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove temperature bound
Thread-Topic: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove
 temperature bound
Thread-Index: AQHWeuK6XTx19eY46EuanJGrB82pyKlJ/UYAgAADzACAABOzAIAACEcw
Date: Wed, 26 Aug 2020 09:16:09 +0000
Message-ID: 
 <TYBPR01MB5309063B3B29E3D938729B9A86540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
 <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
 <20200826072132.GA7244@amd>
 <TYBPR01MB5309A40EDFAF9156799B296886540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200826084538.GL594558@oden.dyn.berto.se>
In-Reply-To: <20200826084538.GL594558@oden.dyn.berto.se>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d5bdbf0-c291-4abe-624e-08d849a0abbf
x-ms-traffictypediagnostic: TY2PR01MB4330:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB43309D827C307B98FF185FEA86540@TY2PR01MB4330.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 3N3SmtTRIvNir5gBON3dJ84Rq3uR++QIfPBSU8cR+SYQxRYgSbd83d3x0zKVEOsZVXs3IGFpX8RU/9jzIPb6cbG7p9QdsnuYY62D231vGaaEAWd7xHNk84utWIIpX9613w8RJIImsYT1Z74UtH/qQfM3O+O1cGsdtgE10ZGXdKvIUhy1I8GPIgkBp7FVfibdr50IUVEZvgLlToEeu3CsIo90duZmY1DW+HbTpTsu7bQwSDeTcXjpXxFrh295Z7Uacvj8A4fFn+xppnwEfvCKHuX15FRhKuYZLL47jk8BhhnMnIQ9XIeInfZ9b4lOJFB849gL8x/pRAntCsLe/pkQKw==
x-ms-exchange-antispam-messagedata: 
 dUeyFocWr9We2lE1fXLRz4S/pUabhZCPPvtg+N8Bj/7YQrljjc9MTntooTqSFxVuASlpLziAowk45n2h9ezguUQv5hkJL7e0x1/6F//PYDe0Un1he2ZZsJV5Az9r1m4uMAxK+mkF7S8oa0yp60d0GZPVwLuNIJ6bKTPasguR+AvWKiznuLMIBU1nAYS88Kqqosm8553sqdorl/ImCPHg+bP6Yv1IbJkMODp7Bj2rjklQ6tYapzyKeNaLph77ZMRaN0FV9TNKZhhQDic0ipc8C5+Co3sDzKYY46p5sadkGpCODupuGslxGG0JHdwGcCCzsDfOsVh15uK4o3Pa2n5kyJ8DuiILd89EVMktGZvbOXqP5LgsfR8F4EgBO9mLsCSiaOHGT/CjGYa5/sMt/YFxD0IhnNLfJS6+9RkyddnESFUCRcgxvHKInX0v68iIoP2zPvYkmPNFscX5lEM4zIkIcKAILL6OZb2YIdXSPqje81D8O3EoVkhynV4EOXgIf4Uf72N12AoWUgLHs223G9VFGR7+CH+77RujPJlFu1mMpZj4PlF1EXCTYXLuhgHhahM+YsHiCzqANJ8GBSDJ7k6XmU8oWIsD7ozjv379pYSZnf+vmI6k/H14Jo4jcsWcmyqxQUpk/HGCka68P09UqkWt7Q==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5bdbf0-c291-4abe-624e-08d849a0abbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 09:16:09.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtsOUImyMgEvL9rjAM5bMDH2a468Mu7/iNNDEpq36hkTaZkk2wqxEY38P3DLdMkWIcgjP+7yy8QUxIcxdTrENgjlNGm8mhOPdxWJ3VBOUh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4330
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wNufZ4EPG849Ys6cYyrm94vSx4520388AA=
Content-Type: multipart/mixed; boundary="6Yc2LafnYKHLXXWsLL84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441716;
 bh=ULeqkxde/Ve6e0UMiyp7qpuMy+qPUVKxT2bQ775JGiA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=a9zyCLHOpCBAZZ/vgS5mZD8I6B+0eAnBsqD0AajGRYzT2E2PEqxGm5BEsZjMHWoshB3
 YeGJeLY9ytzzvkmey67TFIHHUVjcxlJ56iXFB4IudKszx6hmjePlKUCde0LGmtM7J4/IE
 r4TZjB01skSlI+te1LTkB8pEUhUU7SzmplM=

--6Yc2LafnYKHLXXWsLL84
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for your feedback.

Cheers,
Biju

> -----Original Message-----
> From: Niklas <niklas.soderlund@ragnatech.se>
> Sent: 26 August 2020 09:46
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove
> temperature bound
>
> Hi Biju,
>
> On 2020-08-26 07:40:46 +0000, Biju Das wrote:
> > Hi Pavel,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal:
> > > Remove temperature bound
> > >
> > > On Tue 2020-08-25 14:21:48, Biju Das wrote:
> > > > From: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
> > > >
> > > > commit 0f510a2457cbbba18a98492bab1bf540be57ebd1 upstream.
> > > >
> > > > The hardware manual states that the operation of the sensor is not
> > > > guaranteed with temperatures above 125=B0C, not that the readings
> > > > are invalid. Remove the bound check and try to deliver temperature
> > > > readings even if we are outside the guaranteed operation range.
> > >
> > > I'm tempted to ask "how was this tested?" :-).
> > >
> > > Sometimes sensors have glitches producing very high values in normal
> > > temperatures, and it such case clamping can be useful, but I'll
> > > assume your sensor works ok.
> >
> > Niklas,  Can you please clarify?
>
> IIRC I was asked to remove the clamp as the hardware team had tested the
> sensors in a wider range and it was judged better to report a reading eve=
n if
> it was not guaranteed then to clamp it. I have not been able myself to te=
st
> this change myself and rely on the report from the hardware team.
>
> >
> > Cheers,
> > Biju
> >
> >
> >
> > >
> > > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > > @@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void
> > > *devdata, int *temp)
> > > >  tsc->coef.a2);
> > > >  mcelsius =3D FIXPT_TO_MCELSIUS(val);
> > > >
> > > > -/* Make sure we are inside specifications */ -if ((mcelsius <
> > > > MCELSIUS(-40)) || (mcelsius > MCELSIUS(125))) -return -EIO;
> > > > +/* Guaranteed operating range is -40C to 125C. */
> > > >
> > > >  /* Round value to device granularity setting */  *temp =3D
> > > > rcar_gen3_thermal_round(mcelsius);
> > >
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > > Germany
> >
> >
> > Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten
> > Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf,
> > Arcadiastrasse 10, 40472 Duesseldorf, Germany,
> > Handelsregister/Commercial Register: Duesseldorf, HRB 3708
> > USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg.
> > no.: DE 14978647
>
> --
> Regards,
> Niklas S=F6derlund


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--6Yc2LafnYKHLXXWsLL84
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5260): https://lists.cip-project.org/g/cip-dev/message=
/5260
Mute This Topic: https://lists.cip-project.org/mt/76406706/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6Yc2LafnYKHLXXWsLL84--
