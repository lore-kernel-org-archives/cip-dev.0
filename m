Return-Path: <SRS0=ZjIH=CF=lists.cip-project.org=bounce+64572+5281+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D4C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944F222CF6
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wNXEk52F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F222CF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5281+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rm2fYY4521723xlOFbwG0o44; Thu, 27 Aug 2020 04:35:24 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.97])
 by mx.groups.io with SMTP id smtpd.web11.13215.1598510578537689289
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 23:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yt7DYgnO87b7VrMXUnslmSS2qVtMaDfn3qMAjY+ZvOidOH/huKBxaeIyx2AlwObi5yp9gCsHe+hL9UDfQ+Yag+qwFDshmzHSKa3ct0zVdF5bR2IkdMPJSiZZcaiccVH1b05OVJRg5Hzt2MsHzjBNrTnRDod4/EXhTSKaKuq8z2CNju9DIZYLOzf1B8pVF0Iaai7qSLcRDjxyg2T0mu/cQvbO+Ky5e5fbWyDacifJM1Yv/G3M2hJ5l30oi5D18m4yjQ5u7xF6if/9I+iCotL1n92taRFXGIyZTFbNXSLtO7per0J8qxlcp4/lk7aW8XqECOWNT09pVuitmOMOv/C+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWv7/ojdYO85nqKzgamhN9PLBAIfCBPD9GC4Mk3l2KM=;
 b=DGDJUyQZMBLKsxFPWNUmGq2e//mDy34EQHFCAso+tGefGQ94X6RnizxVY7xLK+KLtnTJeDOKPm/vjPcp198bsVL1ERMgYDNz/c3wI0YU1Kx99+5EUWXQ8FqkB8q1jKoUIgT19ex9wpHuUXqZdPAvrDXURWE2Klc2JJEB0A8AUpfVJpW48iP8wdAVlHo4j3i8eeMpovrbd/2/yjAwLbyb0sxGPLPL3dArnyJG17iTT99bKDgwxW3sNVsudJxINCVDdtm5NHK8be73OUraFPq/eKsqlxbnwkN8JiFoiG/6rbJphbhrZ1ytEe7R2RjVEO6KaJ1J5OZsHXMPIc5yPzs35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TYAPR01MB2094.jpnprd01.prod.outlook.com
 (2603:1096:404:4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 06:42:52 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::c141:37ba:af8c:b2ee%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 06:42:51 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add support for
 [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Index: AQHWe5sTPMVwRKFHTk6T2YjLVWDZRKlK7XkAgACTgfA=
Date: Thu, 27 Aug 2020 06:42:51 +0000
Message-ID: 
 <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
 <20200826214624.GB15974@amd>
In-Reply-To: <20200826214624.GB15974@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.154.85.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b8a5778-49a9-46b2-3e79-08d84a546bd7
x-ms-traffictypediagnostic: TYAPR01MB2094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TYAPR01MB2094B37E2EB26F7872236B0586550@TYAPR01MB2094.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 JC0FiIUvhVzFai37ZX/WLjx/2yAPegj8rrB3NQfTUV3HmyWKhkYOL6R4CbSPBhXm0kZ8PzxhaTB0bFi4ItMuf5za56by0cSR7lWu/j12Ag2EJDEUcMwS9ndBuvXEX3Lzfy3MQJr4Kh6X4PhpKz+Y1A94zPnLcbPbmtjJ7+MUHwitwnTQ5n8gbP7cEoZ4lpmcIj2+BSW/aVpLUHDQqnclSpvyBW6JzwHF7cLwHc1xt1VT+z0AW4y88hxOTeAnliR8YXnYsepyk1LQ9c6cEpGFNfKTUbhDxXw9dpHcpfsq4XdIh/a0A3Cijk5jyufgjGsKDykqrCOCCttc7zD/o6vjJQ==
x-ms-exchange-antispam-messagedata: 
 0welvDFKvztdvPumOMMCSQQCuOkChQ6spBARtDvePq/OLWxQYTwkb5IciSPyHNsY4zyGWE/gsjevbzUoody1GSkYOju/azHvu6vOKdi9SOjoQHmaShpOqGOamrvHt8WIFP9nmTGjo9h9KKhNZwLJZI+WVDxIqIMFg/T34dYcFt7n4Ctq9csUs8Y6zS0LuXk1l3NS3sV3tAHNFIHLDTNQfUdX5EvUYlBwhdpu1tZdju2T69d4NFL0obsTpM+N0PJr/I1/rGtiKaSTvRpiP+hUALob+57AlQAb/EiKqmknisjxV1ItivctxwSSqgn2LcEG8oUzYuWn5zbcrpjyo6nWTs2Nx6QJrlMD02Dq2fxJ4fUda965gBvHchvMpK62TkzwHgvN8o8/Bhb9kXmFeHmYfiScstw4EbBjLu/nffqdY4B1UxxwrMrKRe65y2+QeijMRwFnH7LEOEpzwiqzR607HD8RK+y58AkRrxoSW1IXmghCzDCFth2/RgGOxIslf6bXbnfJNIRGM98jOcstlM83bX8LNNeGOhjqTiaDjzHhanuMvbt+DcWNirDo1bl9O+lVxV+vTkjnNI5sz9eS13wM6ROKpx/T5fTIXazdTRWT9emuYxkHoa0OF9gcvvUUs7bRHxQ0nkAxGliYXz9PO1c1tg==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8a5778-49a9-46b2-3e79-08d84a546bd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 06:42:51.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0FV3Hf4n2s/1Mp9/q7zS67SzZi92dsjUAGejw0tQttY3vdL5+q911eKXZ0w42HqgFRHdsSobJmV8W3CWXiBjun1qN36U9i56+g3Hw+eA/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2094
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OkGRH1ilun34ZYqYB6dBIk9Hx4520388AA=
Content-Type: multipart/mixed; boundary="RGK1kmsS5YzsT7rrjVgw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598528124;
 bh=UG85uyvGcU9SFRCoHeYz33JSqPY6S4m2LESFM0kjn38=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wNXEk52FrjLUlvYKA7BS5eZ/taf/FfU2aq70m67j2XEcvRU1UItlcp3/7IFlCgzM4CY
 +muU8ovrlRE3p1kVjHuPb0eHeofUz7VI+zMZ4IvpKT/Fv2R23ox92NjiwbL8xZW2O7PEL
 Q1Qs4MA/bUYS/lmboDXyUqlKGZXeFfmt0SA=

--RGK1kmsS5YzsT7rrjVgw
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
> > Add RZ/G2H SoC support for [H]SCIF/SDHI/I2C/RWDT/MSIOF on 4.19.y-cip
> kernel.
> >
> > All the patches in this series are cherry-piced from ML, except [1]
> > which is a new patch similar to the workdone for other similar SoC's
>
> Series looks good to me. (But gitlab testing does not seem to work, and i=
t
> would be good to test it before applying).

I am  not sure about the failure.  If it is related to testing on RZ/G2H bo=
ard, then

I guess  RZ/G2H boards have enabled watchdog in u-boot with VLP 1.0.4.  So =
our RZ/G2H boards have enabled watchdog in u-boot.

The timeout is 60seconds. So if watchdog is not enabled in kernel or  Watch=
dog is enabled and there is no watchdog daemon, it will reboot after 60seco=
nds.

In current case, watchdog is enabled by this series. So If you apply this s=
eries, then next thing you need to make sure is watchdog daemon is
running or stop the watchdog

or

For cip testing, we should disable watchdog in u-boot.

Cheers,
Biju




Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647

--RGK1kmsS5YzsT7rrjVgw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5281): https://lists.cip-project.org/g/cip-dev/message=
/5281
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RGK1kmsS5YzsT7rrjVgw--
