Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E55C433EF
	for <webhook@archiver.kernel.org>; Sat, 16 Jul 2022 14:17:08 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.91])
 by mx.groups.io with SMTP id smtpd.web08.5820.1657981019557203260
 for <cip-dev@lists.cip-project.org>;
 Sat, 16 Jul 2022 07:17:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CsEs/dhJ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.91,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHuGSk9lu2v+ibJHCmi5D2vrcw0PHErh2qDRThpSsU9sP2qeM4odv8pwrXORN8sjbINvcNEGLY3cgy7L1z/XQAW/IfE7uA3zP1kP7IFNphPt8Q9OcMq8pZPGsLBwQSlrZErCaUHRB3c9W+ESR2wAQT0R3GDMwwGwrTSIOq8GZV+Cwyt2ajvP1WVYgxUqI1N4EBwnWGj0RXm9Znx87oJLNdpxfGSE8m7oBmadGcG8/U+CadnYUVRdJNeB5LFlH3mhV5VVfZzyZMj2XVzdzUr789j15Byj5+MJkdPHDrt8HCxSxyWFi+ClvdsvddiegwgTLX8wGJBpTLxVY0ECj0VqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tquTNCiojARSHGhF4yvzUwsaK+1obVd7ZA4pSi+l/7g=;
 b=AU+g9HV0cWXzlvvKKV5Usget3F4B1w/SYBZxPcSxun8BUTDtTVVHfMUbOsQ/QihTnyCH6RJb+U9iMNZSyb3o+hEPJo1QwxgONZ0a0J55Ze1HOWazkIRBgCmaji6mo+DDNEz+cKU4Z8CMrnvrThq1a9adoEvQLs69JTlhI302SlDygS8eRYsxcy5gSEUURBU3ehfz0iDDZxwrEuDpSguCMESzmIsy/m2KcPKMkO5yhL4y8fANgdQ0+TZ9ItqG52jDr6pFhplGaueT8wFYCyCvw45uzCLeJIoFR2N+2n3LP7JyZzzISyCoVZB39OO2a9JZ5WiLvJw8ZpkYhDsBQDgPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tquTNCiojARSHGhF4yvzUwsaK+1obVd7ZA4pSi+l/7g=;
 b=CsEs/dhJ7duUZSK14M2HbOCbTF6P4Glw8MISfU2ELc4+Z+rsm+cFluGbtPNBXQFcNxdH0t3WmjRyMaXdvnU0HXRxL3ElOnEtHtIEJAB7Qtel5qzVyRqKvQGzVAneFiXWh9cOlxz6l6dUtiyATtyIRrdSNQObCMYDkOYtSJ+IanU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4376.jpnprd01.prod.outlook.com (2603:1096:604:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sat, 16 Jul
 2022 14:16:54 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5438.020; Sat, 16 Jul 2022
 14:16:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RESEND 5.10.y-cip 01/13] kernel.h: split out mathematical
 helpers
Thread-Topic: [PATCH RESEND 5.10.y-cip 01/13] kernel.h: split out mathematical
 helpers
Thread-Index: AQHYmB4BBV4LkEa4SE6UqSoW8U9N4q2AtwqAgABSKaA=
Date: Sat, 16 Jul 2022 14:16:52 +0000
Message-ID: 
 <OS0PR01MB5922F49DDC6B6C7155D6F9DC868A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220715073916.2321319-1-biju.das.jz@bp.renesas.com>
 <20220715073916.2321319-2-biju.das.jz@bp.renesas.com>
 <20220716090839.GA5658@duo.ucw.cz>
In-Reply-To: <20220716090839.GA5658@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dca47dc-7969-4856-e94b-08da6735d4e2
x-ms-traffictypediagnostic: OSBPR01MB4376:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zTnMGWKMz1seboaEHoQN87vE/DA0ALPJyZHMzgJq0OJgTM1uDZkkg6PvHqGB/joEQYfcrdEOdLHQ5OSFpSxhXBd8Hf3UPvSDQeijd4FteVUcRMTCdK5PfF5iJ7zix+JMNW0eshIEcTutEGKdmUL9QmxnfyfrpKQ2rxeUojSsZJt5SGws14rrBFbQ/yOHId7iw0fx/EW77FlO9jV3M4KwfVwdQ59TK791mQCtccFbCjUlPT9f5hmR9cz9lFmCUMYHaDyeozdRvmP5oD81BS/MFi7x84Z46YvrNew5tYqr+AS1YiAeYVteaOf9OSr+KgrOLGcsyVMFnEKK0eV3LNE8BuCM4gW9NPmYptysB5QpLAMaDlpRWSFiJQkwx/gljA9gKwQY50Ub5Rt7/YTSmUnCPiMop7SJSwIgZmZKOsh0t7JbDrMkN+ZU3KKNI6TY9DJj2c4FhwvT7wt+TooySnKN4xWLEIhxTDBp9PVqgrN/+o+DZd1e+oAbrsUI+ofKMZvytHqUzP25i4GriMWjeww/TI6c4HxLn+QCSZOU/epE95eFYQRBjDa4zDTlvvSpqmOyUwsV2p4wlbYOijsCzZxtNiaoSVQDHvxgFetginlO8XOQ3aEKDDx8LHU09Sw4npKsa3DcRdwBZPSnRWN43MkjWnun9YS5CDzvX4h1k13pOR4hJps2y4dNBEJ9Ww+yKdYtm+p9tCTgRwy82RbFB2MiKG8WyisiZOkgO/sC0cPqtHNL+76iakBOKqSX3fHJ7ILut1TRCGP6pqcMsQeFIxFUFkNxEfWof1/53Kknki4Xbur/NRKO12rdE9gSJAfsi7RU
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(9686003)(26005)(7696005)(6506007)(41300700001)(71200400001)(478600001)(5660300002)(52536014)(8936002)(76116006)(86362001)(2906002)(54906003)(6916009)(316002)(55016003)(66946007)(8676002)(4326008)(66446008)(66556008)(64756008)(122000001)(83380400001)(66476007)(38070700005)(107886003)(33656002)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YJ+EMMkeQdbVq4iRzUh1iJsVS+Wiim7PfnA4kbb4Vq3757PSkspATMytEld6?=
 =?us-ascii?Q?TgRXHe/E3IJhXbllbSyiZt+uZOiwcYiPmTfkxAvBTO2WaMl+iQJUTW3QuZSK?=
 =?us-ascii?Q?SgmjBSMo/gytIDm4P4SC2Zd3thjwH9XqY184JtiXAgq8a4zMXMICUfxRTIK9?=
 =?us-ascii?Q?cn+sk6VYndGyNg3DinjrpfasIe/nLCYILbHAVI2jPfEwrH2TKIJw+JTRCSMY?=
 =?us-ascii?Q?NrhePiQPT8P/yIhmH7OVD1PdkSYSi//eJ3YmhaWjsNntvjvV6gsHjrijbZ7U?=
 =?us-ascii?Q?TZ8vMyt1UNmLYGxZTJlwOZXdafZoyRPl3+9qmqauazWw8Z1Hyhco7Mxmw01z?=
 =?us-ascii?Q?uE/OykdcZpy4/HcfaIQddNvyxJzasFGHBZo65CLg3CzgAe59jW1r/llge1MJ?=
 =?us-ascii?Q?8z8lMtDdxdoAB2LCjk4SZY2EKgaKcxt85s/Kd4l+a3kKmVlbku0PT9YIBWG8?=
 =?us-ascii?Q?3i0Q6QlSenDuxMQxRWC9fNRFxSLXhY8ZPFKa5ofk/QTQWLTleSCkpD+26OIu?=
 =?us-ascii?Q?2xUEr/Xyl6zgAexgv9slWKTC3VNVpPiAZ6sJVBGH4386ezbkWpWIhs4Hv2jW?=
 =?us-ascii?Q?c/hsCgsyhRssRQdMhDTzAvhHPeiLyQbYE9TqJ2wg3d7lpUHgEN0YasfCfcyw?=
 =?us-ascii?Q?eOxBkigzBZaSyFB38A22huaC34e5PZPGTaUAzRr4zi4wLOUyru10+yIEnb1V?=
 =?us-ascii?Q?ymAaowx3yZPdobrz96eFEBts0JHP9/z6OB9jwfwN1C25ViVLuGr2RwLp23y9?=
 =?us-ascii?Q?HnWUQhwosyupvChs9BGF85Gd7M94uKVdlPgAIu3551zq+o4OYGE9Kkkp4vR3?=
 =?us-ascii?Q?tKNk9v8GdRzKAFhrCNnhkqYn4EjqOjYgvYdyCVgZGgmhnDp7OgLwdEOl9jPO?=
 =?us-ascii?Q?EXM/3Xk25MYuUkDcqsgPcyuRLk0mzOBx36GfuWjlonPHkCUU9OOavmnCiFIU?=
 =?us-ascii?Q?cUHGgkQvhZ2PrA/1Ss6xriOvUXqtbgpIcM3v7r20K/1c/6HTJzE+jT70olnW?=
 =?us-ascii?Q?FRocPpU/LfMjgoyouVDm97XpjRlqsEvpRZc6GOeQk/ifFnhk0alnhor9Pjji?=
 =?us-ascii?Q?PddA7+yl4B+MNXrj+B9Us6YEPr68cC3A1xdNawEYzEcx4IerJ7hv6FN0grFi?=
 =?us-ascii?Q?WwLvP0ZQA+tYB38+6FETN3plTdxsqjmfXWsvWKMHH1kB9OobcM/wiwdGQSAy?=
 =?us-ascii?Q?qMKTQaONUYI6a16KwHS6GgBU0/rY2sQldIh87GuCvC0goO2rUTTLvjMD7NEv?=
 =?us-ascii?Q?c8gnN94EsXLnq/ZZ5mzJdpQYkQcZwr8n5M8bWy+ypSIPj09XOZM3G4J/LefQ?=
 =?us-ascii?Q?4DJ61k9nKpXtkZV/ZRoNh0X+3DsIoQ5aPUkd4ddyW+eziYYG4+1k/kXLWubW?=
 =?us-ascii?Q?3vMC1zMUYfGAV5JniVY7Qy6Sq2Ep+8VXo2QAMd/9LzSHDMnEZgU/74VxvgHG?=
 =?us-ascii?Q?rs4enOsPNNpmxGOnIDowGyFn8m6GGV0Iecq6GjgkkeoJq1An4uADz3S8xlCR?=
 =?us-ascii?Q?pg8mOTmDxGLkHSSdGB8S4QAmS4jUd4VKE3p9/oKO8iGToI1joBki5q1XPhnQ?=
 =?us-ascii?Q?UHxDI1hmVg0cJrZvToIaoSBtqpurY1KxJmjgX2/H0Prt75l77xy8PcjUk/CC?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4dca47dc-7969-4856-e94b-08da6735d4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 14:16:52.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 xpJ6ZCZcGTRJPanW4OKtKUhOxGIQlUQwxo8ltcPiOUsAUw1PQW8jzT29WhCJLDcxdWymSxoovNC91SFDW9iilmcZOyOF3kBG2d8na+6i8Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4376
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 16 Jul 2022 14:17:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8839

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH RESEND 5.10.y-cip 01/13] kernel.h: split out
> mathematical helpers
>=20
> Hi!
>=20
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > commit aa6159ab99a9ab5df835b4750b66cf132a5aa292 upstream
> >
> > kernel.h is being used as a dump for all kinds of stuff for a long
> time.
> > Here is the attempt to start cleaning it up by splitting out
> > mathematical helpers.
> >
> > At the same time convert users in header and lib folder to use new
> > header.  Though for time being include new header back to kernel.h to
> > avoid twisted indirected includes for existing users.
>=20
> This is rather intrusive for two lines which we really need, and may
> cause rejects in future.
>=20
> I'd suggest identifying the defines needed by the driver, and just adding
> those. kernel.h would be acceptable. Or you can add math.h with just
> defines needed, but please avoid code movement.

OK, will send v2. By adding needed defines in kernel.h and replacing driver=
 include
math.h->kernel.h

Cheers,
Biju

>=20
> > ---
> >  fs/nfs/callback_proc.c        |   5 +
> >  include/linux/bitops.h        |  11 ++-
> >  include/linux/dcache.h        |   1 +
> >  include/linux/iommu-helper.h  |   4 +-
> >  include/linux/kernel.h        | 173 +--------------------------------
> >  include/linux/math.h          | 177 ++++++++++++++++++++++++++++++++++
> >  include/linux/rcu_node_tree.h |   2 +
> >  include/linux/units.h         |   2 +-
> >  lib/errname.c                 |   1 +
> >  lib/errseq.c                  |   1 +
> >  lib/find_bit.c                |   3 +-
> >  lib/math/div64.c              |   4 +-
> >  lib/math/int_pow.c            |   2 +-
> >  lib/math/int_sqrt.c           |   3 +-
> >  lib/math/reciprocal_div.c     |   9 +-
> >  15 files changed, 215 insertions(+), 183 deletions(-)  create mode
> > 100644 include/linux/math.h
>=20
>=20
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

