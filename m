Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B51AC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 12:13:13 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.135])
 by mx.groups.io with SMTP id smtpd.web11.5732.1658837584585557087
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 05:13:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=d6VifI5s;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.135,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n11Tj36kz8vnrUAVPbcHWvv9sgy9PpCQ5Mx+S20aLKscM8xRQ9BZ2gy7a3elJ7fppIriluNmq0Py70mjdRwzOGawTVllDhQZJ1reTIhPj3LrNkNF8uaqZhYmx/ZEM2ZUmM/vyY7Ti5HYcFOzksYzRINcilZ5NG2z+wktYye+wbjKBZyOr0dwRaSP4uzt6uVFMW+nYrR5Cnwqqmx270prE8lsr16GdXB9GSraqTgXtYCRR3F8tLGQuZFHcSDzl2dS0pSitqxegKWPTCLsPmN+Nm2fV3QXz6pQjl/4IEKW9AFKeJvHYrVIzvS81uTdHECjSJEZ0DdGFWJ7cp4LxTIAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOmWV2I4gwPWghP/3IpEOQ6Hi+iaJJq0Xzd9gURLX2w=;
 b=B4kF1dvORW8FTVr6AVUwDguNAAeZQBbvNmktWgCIiDBzWkyRi6Iqh9z75mOUTweutIUHt99F3B+Jz0PKok/yjozCaCeCbRuYm0YnhJoYfIlnt9PtLsePk9EHf8lfr8kXm//Q+Twcukv089ow4TnGCiWyyTZgI12UMd94mU8SrszRW7rmsAnHq82/WOzvfrTtKvCMTaYeJCq7kjAQKXNxyUW9eLDF6c7WtbU0aNTUyKTaWJerTFdcHTdFfhgCbNGMhSXLhf1r2ZDeDGdgU+skgQmVihHIedjG48O6Acao+Dnai++3mkQBKgZJLhWqQ/QLJjJEAEE+9FvRxC2/Mik0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOmWV2I4gwPWghP/3IpEOQ6Hi+iaJJq0Xzd9gURLX2w=;
 b=d6VifI5sUxQemV8/GDRWocyctNBDdE9g4ljvWgTGk67v154hy+fgLtcmIM5xu0xQ/7h39lEtc88CzlH8uQi89v2HsibnNfu7Qp0v8YTA1Dyi3hAoFLpD84KteIUEMmNz32RsHWwdX+4bN2qzLzWtq+h0yzClgaZLppZXrGVPDuA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10012.jpnprd01.prod.outlook.com (2603:1096:400:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Tue, 26 Jul
 2022 12:12:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%6]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 12:12:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
 rzg2l-smarc: Move pinctrl definitions
Thread-Index: AQHYoGiZeBficqChSUeKMK5Sq2jTbK2QYFoAgAArAoCAAAWVkA==
Date: Tue, 26 Jul 2022 12:12:56 +0000
Message-ID: 
 <OS0PR01MB5922FE231AFDE0970F7DB5B786949@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
 <20220715072244.2298757-25-biju.das.jz@bp.renesas.com>
 <20220725205326.GA2302@duo.ucw.cz>
 <TYCPR01MB5933013757A576EECDA6DF8486949@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20220726115149.GB31613@duo.ucw.cz>
In-Reply-To: <20220726115149.GB31613@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e25c8bc-1a7b-4fd2-661f-08da6f002c94
x-ms-traffictypediagnostic: TY3PR01MB10012:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o80SFC0OcPkKd+Szw7A5Sm/L+qmJc+wo8phFVwvko5qkHpivmK2LFSVU3mtmc1olhWYP1F90ytWrP2R94/hzvjOUGT+vGLIGkQ0ZiAFI1pbIlrcajBBEwwL5KzOKTrtzhM4jQWwfCuI1f5xl3G550etKuLIMAVGqPD8noLGrkOpAigE6H6L4paCkx1ZzoUgipUyRh2UrdbvogcRrkIPPCx6+oRs4dHP42QiXzsF3mb+ac5lqdTuclW3KTZc5kGAzkm05EYT0pVrHaUt2y6hI/0EQ2gqj2UqU/F6E1aziKdTxqEscAz0VSEqKcuhwbzpD9M39vTAGBoKV7H49yvg3I0psSM21wXZGXrkGTR2eEL0qmV1suZ21Pf/NNxaiO3UQU9YyqCKGKUp+fh5pUTwPfX0nxhI7or/bZ5wfv2bOjc8ra7RvMGixYd2bqi5ZuMcC44gxUW5RhIR/rlP+8yOdggteEoBGsYIEvenGgzjP8iWtedXIOZJGO2iaU3XBdqLaHwYnykxsTBH0BfxESOSHN+1GznyDcBpo4zRHmLntjk54kgWy7cYkjMWvIV/UomnEyQTrANVawhdQfimL6ZgYwG/gpdOT7tB8X0AdVj85SuUr/OAsLJbLJRzogV70nsz0Z04UA3VNyA+RxxDIvIgfvYDKATZj56AEKkqCknfGvhi4s+IDqHOodkiH51hU2iaNxeSvSk2e6rL2SLbXHSJo1/rEWcmPDdIuWae0l70QCQjzhKC5wEVyfiVHrvvOh82GVWX+KWyb8JFOF3/lnY8P2SlO3If5+9IV7V8xW2PtX5m6I/TgjpgP/M9aHgDtKnlw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(54906003)(9686003)(26005)(6916009)(33656002)(38070700005)(86362001)(7696005)(6506007)(8676002)(4326008)(66476007)(64756008)(76116006)(66946007)(66446008)(186003)(66556008)(55016003)(316002)(107886003)(52536014)(8936002)(478600001)(5660300002)(122000001)(4744005)(41300700001)(71200400001)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?VGAHF5MCmu1VKA7dQrv/fuBEgR14mzeGAWj+hhXKqMCmA7xHLiM2kPPmnK66?=
 =?us-ascii?Q?G/nrLRhd6W9bmPdVmNhUm0G8V9csJqlJF0Q7IFXsBTDlb0bMXcuTZdYdWHvR?=
 =?us-ascii?Q?ilWpv/evshBzFrzrk1v/Mols5YB2enHLuVIQUd1lWtWq8p7zh696tMzgTsj2?=
 =?us-ascii?Q?SNcLz3v89WGNGcJKYMUJpeldu67s7/jxVxRrzpd0TJcKpSIMvPFNalxx8t0+?=
 =?us-ascii?Q?kSQZZgUZwc7OQIlBSTBetWTc17hS6qXh6wG+zRleITbDQjO+vYU8NIjC2LVs?=
 =?us-ascii?Q?VFIv1W3+JaXS5OPVHMypEy2YPUQdpbYaF5+66HNBtrMHUyeZ2nUYrs4nCfk0?=
 =?us-ascii?Q?BDzkT9y6zYaY0IeSID+jr3QAh/V45dozKWzEW0o1BlBW4MZeQCuWju4ApvvW?=
 =?us-ascii?Q?mbZiL82cwHGqBsHRiw6K+IuEvp/mzrg8Oo9yxRjDGKI1/T/PWCRfqS6a6OIO?=
 =?us-ascii?Q?5NnlQ4f375ota4qwZNjiM43AollJZ40a3JgwjWJTPYDFEZe0VWN8hEGdsamY?=
 =?us-ascii?Q?AvtSO5twoaN0NYnM51ppFeKOEyJbEWZnsDMQtLrJHZPLiASttkCcte48HFKu?=
 =?us-ascii?Q?Je9gCwF9+utcg7fnxS0/NG6spxDAmx0S7rTsW3nf61rDi9WSh/T+3I71BaRl?=
 =?us-ascii?Q?1n+rug3TSYoi65Ga5qQssfsTmu/26KqzazKB5OU9PwVL5oM0ok89Cfij4l8Y?=
 =?us-ascii?Q?PrR7Ml9o1ZsV3cfsz4XPGu3/KclPblMkIAmfo0uzGIP4kc+Fe0Pji4a+kmd0?=
 =?us-ascii?Q?InYwp9QelWp4aqPDpzb32+6hRLapdi47vXFO29qUodUStat3a6hMwfKGAcg4?=
 =?us-ascii?Q?FACamP/+gN58vaN935PTy/vW7C5uobShII5Nyo0rkR8+iFq4hpzxIM6lnOtx?=
 =?us-ascii?Q?nVk26rTAqC6/NH48OXiV6lyPdtMq1a7avcfXua4O5bh/ACXxboRxrKYrQvH0?=
 =?us-ascii?Q?fXgm1yco1+mhxMy5C4jiO323WxJw9+maUYiBEXJ5eWziw2FgBNmHDOv0uEn+?=
 =?us-ascii?Q?2sxFo4N18f08TF3/9zijmWw6disLr1vw8qv68hK6CqTFKZ5Xsbfq+yZvVaT5?=
 =?us-ascii?Q?wFwGv6QyKcmi5lYWep3dd+TJLhKJia5QeFVmGN1/8jcRsWq7OKnEas4VzTwT?=
 =?us-ascii?Q?M8RFWqC2KTbDEbFYzymjh1kUK+urR123tNX4y+7EBQFwCFVuIGXTudfrapzA?=
 =?us-ascii?Q?9wdqW4vXiaBZYOJtVyCbgE73Ag2CZO2S+r+2Uv1tbsRAPk2T/yPFoH1Cz1fy?=
 =?us-ascii?Q?I/HcdYY+gkozMVEyUVRrtMBf8h6zD0T8fcQ8Axz33GDmzTlYCVcjFCk/71d+?=
 =?us-ascii?Q?Y9Jq8DBnZJLBqmEM7piir0SqCZrkAYJ/DZFrU9SzCVA3AyH1OXQEA+rdmf5C?=
 =?us-ascii?Q?NhXRPSjYYkX/EjaMuCb/YKULgS45oNbbJVlRMz6tb/B7g5ciKDIZ/HRbZL6P?=
 =?us-ascii?Q?4bu+G/VQ6z6IvBQvg0sw6Ij1qpyq+iiHjlMRUo5em9ztUY/t7Y9NcqcA5dGB?=
 =?us-ascii?Q?Ot87cTsRhSObRhLH4yN1JFm8YiKbQZfqHdGdA8w1ZlmPabbuNhb1BZTtuuPO?=
 =?us-ascii?Q?K/2iETea4Hcw9dEwuKhCzgo0lh+rrzizzgXCbiN3lE9fcSOKhISsPZ+eBZd6?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6e25c8bc-1a7b-4fd2-661f-08da6f002c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 12:12:56.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 jYBAOGZN5HVNVdfN1C2niL2j6eJm4a8VfH3M0smUPFG9O9RRYtST47LehOiytekPlUp3MILqNM3jYrnDnncbn1Q5wd78ZYqxMT+XvESmlDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 12:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8930

Hi Pavel,

> Subject: Re: [cip-dev] [PATCH 5.10.y-cip 24/24] arm64: dts: renesas:
> rzg2l-smarc: Move pinctrl definitions
>=20
> Hi!
>=20
> > > This really needs subsequent patches to be useful; plus, git
> > > complains about blank line at EOF. Anyway, I believe we can still
> take it.
> >
> > Will send support for RZ/G2LC next week. Regarding blank line, Will
> fix it in mainline.
>=20
> Thank you. The blank line may be "too trivial" to fix in separate patch.

Ok, Next time when I get a chance to touch this file. Will fix this as well=
.

Cheers,
Biju

