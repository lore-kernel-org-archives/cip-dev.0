Return-Path: <SRS0=v42w=CJ=lists.cip-project.org=bounce+64572+5340+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B31C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 15:08:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001FC2083E
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="e+0gpLgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001FC2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5340+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IwzXYY4521723xRfYlTE5oS7; Mon, 31 Aug 2020 08:07:57 -0700
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.112])
 by mx.groups.io with SMTP id smtpd.web11.55119.1598886311965767118
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 08:05:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDxKVpjIgjM3t0jyYxRGbhMGiDwNmkFB2/IH7+yEM/JGkncP9hB5EprxBAzwQsL4qViuPWH/NVbkI5QNUe9Oa4ZJTPxmG6XOLxJe0Drnq8DkPGvTM0h5R9qIadYeuP8xXpy3xeR4ipTIo8hjNTJlAyNWiEAA8pAsrU8hEESnxGtlAIm4DsKkovEKumkxfTMHhkTsWd9zIEdMlrZJhGTnhGG/wvKb6DcRF4R3SrqzDOcK047S7xo30ebqsjz9HtRWM9U6WWBaqcIxGoNLdJo87Ae7lJzJ9hRyrOghIt6Z3ELzGhb/LDk7lwhxNSrKWvErs47ugRSiR12EtUyDnLOjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9nBbVuoOtLhbzx61dR2iqDUR72qOccoYqrYWuRM2TI=;
 b=dEQetbVUgq0scZrYfm4yfYcmFh5exb+3nqXMkQ6lwx+D2O2M7rjyaKBx8hfKA/Haa5Dy2CY1YWxz7n+rixp/i/a4TTkWHjjeLH9ikLm0qPHt0U94liPLpUv7YN1CC13EU7HWbY6n4P6q9ycY50DLCzHxJVelI6LtkV9NXccunTKXGbbmFlHwLdBXUv1U6ghmfZAMYXa2zzUUtJV9yYHVxxe06WZffobz0IahN0kYrurRSzvK9To938zG6sQeqm8wdmWAq5E10sez2VXGwdbPIdFrhYuyLMeVqohf+U/Ip5W7iJuFtBvUQDssOnJx2KrLNwIM1NsAAtiur2TnyI61ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB2105.jpnprd01.prod.outlook.com
 (2603:1096:404:b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 15:05:07 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%9]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:05:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
Thread-Topic: [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
Thread-Index: AQHWfVHFEviCVkSlvUyHdcIxSa/czalN14uAgAEjUACAA1qYkA==
Date: Mon, 31 Aug 2020 15:05:06 +0000
Message-ID: 
 <TYBPR01MB530997F5A99C20ABBE793E2B86510@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
 <20200828182857.GC10270@duo.ucw.cz> <20200829115136.GB19324@duo.ucw.cz>
In-Reply-To: <20200829115136.GB19324@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96147fa3-2038-488c-0f35-08d84dbf3f52
x-ms-traffictypediagnostic: TY2PR01MB2105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB21054E5ADE929C48A108897F86510@TY2PR01MB2105.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8VLmOmdFIz84BMDF0NJIF23rI3pulSj5VVSAizt64vOlsZH/uU5Gpib8NeqU8SRsViC7eX0CJ1QhVJrlH/gnV5WyAhAGfoscEh/THnZi6EUvCUJA/9/BtzxRU5szP/oNfz7JBbpAyzwNAZSpIFS6SYJNLvaZK//F2oQyKed6pibHbmkzVoAVB5VisLk9ICi77oNLpicVi1orcEH/qhrbiZs5e6m9gOd+hYRa+b+RYoJfTMfeoZUuqf1HZw6EbgbEasx8t1O2qf1eiTZe+x95WoLu2GNg64yljCvdAcva06gfDNDNaIVXAwItvIOQN+CMj7McsEpsTMhzTL0UNla3nw==
x-ms-exchange-antispam-messagedata: 
 gohQKLaw0NCKPcpYVLfRQMT60Q6/n9N+oofbniopE9L/Rt+3+a801LT4CoAUBLBzM+N8u6sJCYVw+qUEJsISCTuVEKbrVMnA7NikANBAvBo99tI3Ymi1xY7CFeKK7wId3FwwKJrq3s696jLKnnC6lWoj+diyT7lYnu1X/3Ca84B0/MLPP2F3UwjUx3kb4xjOONfEkpl/Afi3DV7R1+CtlHoxodYBhsgrk5vjC0Xj74qDW8AcIrGqQymYLGaK4bNAydg4/+9wCWchrVX+zuJ4/Z2EJJ74zIf32WvUv30NQ0lU7OIeDRDkvf/OUf+0RsdhRX0L+Mxqp+p/IJU9jhTx/uQ41ToqZJL8xJ6RnqKyhlSizNpRXI8lNFQT1g3l6jscDAc6pWUzG3/C0puUSCLOwauQNzDC01MjqbMsG9kS8LrggGUAQEFssiEb9HrlnUkb8U0H9PrABrgLGSzt5r/BlXBmcAoBnYQS0q3JqA8ze2cM84AS+pSg1ERxbZbdB2p0KSTxbDk9iiat7yZ2x+9FuWTTHpTaSnwhuYNr2hNNt7WwSMfPgm6XtM3KddDux72ApVR12G/IKBPumeJWKSGHwLPQdjyFy8vgvqwW3ER8bpy1ZgGFsh393B5jJlFqYOelwR+fiohp5RJ/3+aAYykiOQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96147fa3-2038-488c-0f35-08d84dbf3f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 15:05:06.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HccJZ0Jc6Wt+nvdoSjfXEgNO3I9b3BjAgJCxi+OciPUMfoRPqwLZM6JC2FTZ4yHaMC8+JkzXG71zXtUT0iSHYhCjI2hskfSuvVZkhNs+lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2105
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pKEyASOxWAEw3myGXbESApdSx4520388AA=
Content-Type: multipart/mixed; boundary="1Wd7RwjK5RuDY53rX3gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598886477;
 bh=/ZLpN0m2b1+l8ThdkJHNMrPc+2zU0QkCMVuMvtwRg04=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=e+0gpLgTcL2sc6CcXHsYajccLZt0fiQanJndNEGZWek5BDAFY7vU3VwRfbBMCEAZ1dY
 t55Yz39vkYgNh9Qw/W3uRGCVUboe2/AA1ci4uGUZtizWtLe4XhshVnFsWBYAE9nE027c2
 gnGA1GiozEaVeuPsjqcI+qUXqc3+aVJJ028=

--1Wd7RwjK5RuDY53rX3gc
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Pavel.

Cheers,
Biju

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 29 August 2020 12:52
> To: Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org;
> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
>
> Hi!
>
> > > This patch series add basic support for iWave RZ/G1H platform based
> > > on
> > > r8a7742 SoC to 4.4.y-cip kernel. Most of the patches in this series
> > > are cherry-picked from mainline.
> >
> > Series looks okay to me, I can apply it if there are no comments (and
> > if gitlab cooperates).
>
> Applied and pushed out.
>
> Thanks,
> Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--1Wd7RwjK5RuDY53rX3gc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5340): https://lists.cip-project.org/g/cip-dev/message=
/5340
Mute This Topic: https://lists.cip-project.org/mt/76477073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--1Wd7RwjK5RuDY53rX3gc--
