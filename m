Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAFC83026
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.133])
 by mx.groups.io with SMTP id smtpd.web09.19857.1650538264408984109
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 03:51:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=YgulHk8e;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.133,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZycAThw59P7ID1x9MJr9xPeGmnPl1xmYViuDXA2gNQY8yqMl1yk7GGrmXxCw2Zcw3VeQ/yW3K6H19c8GREsdAudY8G9+JJmVT5WFYoqqxhH8/ge8P//NnoheFXdgVV37a5YLuthN2GxEOlBc5XscnJA4Dft7BH0Wcw/swu5MILBuhHdOwnuJqGMUCG3mdT3Lj64lTrGAhAStiNF0WjNMzt2yldwbuAoAY7StJeP9Yj/PeDe+rCc71AHJg071ICMvhiIOl1srVQyB0ZUb7x+kG1+b5qgu6zGKkXCI5u4rIiFNg3q3Qmgd1gUwMbCXXZtq0sZorgaSUbez4VQ9jfogAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trbT5ZZ2RpMybsNE6yMq1HDgfUWdEmD/a00GoWq5/+s=;
 b=CP/mJcG9CgoVMsG3JzNqHdIBfF5+2b9fFHCS9aIOcSwEVsSXtnHwKkKnoEslUiuq202Nt1290W9FRIEFaVunTjcJ9r3FfUjddprATC0Slzd08hhFrmIq+qvoTI33YuAAg6CVji6lmagPPpwRYPPQSDIZvXNaQL0aFdUuVmfkgxamkc4H4J/tUi2VdusrNC78ngDEGfQwCSTASKWjPtxc4wq5+spLCsm7+30iaS9b8tEesrZP6IhylHrX3BXtnsWOn2OvKsN9WMK0LtferKgIP53QArrEfHii+21vJmH/uQI6B115GcVz35cJPZPyB4N1fWdF+fPSzz/+KUlG1OUdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trbT5ZZ2RpMybsNE6yMq1HDgfUWdEmD/a00GoWq5/+s=;
 b=YgulHk8eOMINN+GKqwzcog8vcSwS2+OIU4+s3LuztpN90ZFgXjyc4ZxpUvxy8duZscVjDPntBfX6gYgXmgBraXb6EJ/w0hmMYdWjzqAjRP6l5whfmKg77QNjUhYtdXhxgBZe4/aL1WIXMAf64mXuV9RL9HvJeutWgCpsuY0qr+Q=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB4260.jpnprd01.prod.outlook.com (2603:1096:604:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 10:50:59 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 10:50:59 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Topic: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Index: AQHYVP55INr87SHk8Eu9cb5sTJuVsaz5ickwgACm+kA=
Date: Thu, 21 Apr 2022 10:50:59 +0000
Message-ID: 
 <OSZPR01MB7019ED6926ED5A3D67B52E66AAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420CAD2775ACC96157525E292F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420CAD2775ACC96157525E292F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cc60317-a0b0-4118-dd8b-08da2384d22e
x-ms-traffictypediagnostic: OSAPR01MB4260:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB426063FD94B67669EE4281A7AAF49@OSAPR01MB4260.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mBqJzdUAOGVK0cnLdOGq7rvEnyKG5cwNdGKh/cQKaIlGXmN25F3L5acIzRmbCRFWtx17EeNWd32jk3ZRUlOrc7QU6FEc4ajXgbxVp2jAFyXU3JkcH/KHEDaPjyDljY84BWOOByoVB8h3u2+0u4XUPjPKruQrpaSGt1aqDZOqz/LR6ajF/c7OLGZqhInn2re6iQqMdKjs0uBYw1S2KJnAoe2CY09WGzw+DK1ZzmKSqMN/2HPLRPdc7zib/KWVqMkSL0tSZ1X+uwXPBGlk4HA10x91rnqZrbCr+DBm609Wfffv0i8qMRAeZZ8YUIcRegdwwXVttIpE1EyBwpxA7rsEPUmsQi1F1AmL6j8NGyfD4+Aq6Srzu9jbl/sd8nnDKaDhevKVEoaq+z5RVg80vtpLAlinyLnJsazIPn8jXVdtrbESD8DaCaQdfvTsf0F3p1EbYTBkx3Y0etbqMb/TpueTPY5ElYiNJ+JdczRVBLmUqcSgKhos/kTZZ/Dc8KLzVbf4wqAP3LeQqfZTodfBjHKsXy9K3yI9acopLrHrGtOzE/4ZaesBU4n6K2/dB/Nn/4nOMn8Kc1ejHmBpMqNIn3WULjvQKV4cyaRn1NKtVWtKQtuU95TAkN16K607joyIsaiPpQG5CzpCH4OqTF682DtyEDds6CD9evkgZX3PqBQwVwm5A9PFVffEtXMVQP/ivjBrFBSwxN5SlZTQa3XTFoTR8zYfWbdABNKFHExgyfQqyyntjpoSmG0weXhBsiWf3XW48nMOUffFGr1prFSBcjPvX2uE1Mem2y1yqllkmkLcYCg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(55016003)(508600001)(86362001)(53546011)(7696005)(9686003)(6506007)(33656002)(316002)(110136005)(45080400002)(71200400001)(966005)(38070700005)(38100700002)(122000001)(83380400001)(186003)(4326008)(8936002)(66476007)(52536014)(66556008)(30864003)(8676002)(64756008)(2906002)(66946007)(66446008)(107886003)(5660300002)(76116006)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WkFlcXVTTlBTQVUwa3UrSHIyVGs4OWVITTY3dzNsVTg3c2VKcUd0THBB?=
 =?iso-2022-jp?B?Q1hxN1VvQjMwS0xFM1U0aTBtSW9FakZIVU9JemlzTnRZajdzUTRPVnNj?=
 =?iso-2022-jp?B?T0pkL2h5QkNQWkp3UFlLWmFTVTZJSVhOYjdnT0Y5UlN1NWZhNXZQS2dq?=
 =?iso-2022-jp?B?dDBobGlxaXFvZnRuYzdzSkUvWkpEYitVUjgrU1J0Sm1iczZSOXU4QUhj?=
 =?iso-2022-jp?B?VkhLeUZmYVVac2IrbzA2eG5ieURNSDNDaVlHMEdhalZYY2loZjBqbnhm?=
 =?iso-2022-jp?B?YXltUmpYRVBrbU1YZVFpb0NWRzZQZWNiMStPTW0yMG9BeE9TZjVDSGNs?=
 =?iso-2022-jp?B?eDRYZ01BWjE5aGljVm5kYm9yMFFHM0lLaW55QzBJS2ZPNEM0Q3FmZ1kw?=
 =?iso-2022-jp?B?cTk5TkpvaEVJQUdaKzhnaU1weVdnVDVYQlBsVnVIb3NMRk9nTzYvdjBX?=
 =?iso-2022-jp?B?NFppMWJqTjZ1VFZqNFhRbXRoY09INHoweGhmSkhSRmJBZk9kenc0eHBO?=
 =?iso-2022-jp?B?Y2tsL3NkREc4cDg1aWhnRXV4R0JXRW5ZZ3h3Qlg2bGxzWHBEaFdaYW84?=
 =?iso-2022-jp?B?TXFlYzVCMlEycjRONmFESCtaaFo5dk5Hd3RhSFA1eEw3SDA1cUREbTAx?=
 =?iso-2022-jp?B?NUJNU0hoSXJMVm5Ebjd1SkRDNDJwTy95d0VKMzl4NzV1UCtuMWE5TVd6?=
 =?iso-2022-jp?B?NUVFZy9EUVhFaktHOEJiWGZxd2tBQWtLL0RLcFphTXhSM3lMdXpFUjlG?=
 =?iso-2022-jp?B?elppU21neDZpQ1BCZE9ROFhQNTJFaXJ3YmNreW1FR1NUdzA1YmxhM01M?=
 =?iso-2022-jp?B?bStIU1crWGRTOUhWOWR5L1ltTnJHQm11NVhPOExnSDlvczE1eDNycVpu?=
 =?iso-2022-jp?B?Wk5odm8rOHBjNzhDN0hYekdIU3pUQzBuOC9QY2FHcGw5dGIvaXJJWDFN?=
 =?iso-2022-jp?B?b3cyNnR0VnZ0SFJKdlR0UmJpMHRsRldqcm5mMWZNRWkrc0RNbkZTOVFG?=
 =?iso-2022-jp?B?OWorOVJTanNMU24zZHNRUjl1VlV4bzkwcEJ6eUdGSFIwVTNkSEMvMVFH?=
 =?iso-2022-jp?B?dmdXQnQxUEdaK3pzQWFDSElsaWo0Mis3VU9BSERYa2EzWE5NSVh4eU1N?=
 =?iso-2022-jp?B?dmNiWUVndmFlZVg1NTh1bVJob21SZys2U080NmpXUzBnYXk0UGV2N0xr?=
 =?iso-2022-jp?B?a2VYeGhldDY1N1N4MGxLOFFUcTFFdnlzVXdiY09PQVFMUFNhTmJjMU90?=
 =?iso-2022-jp?B?eStXRkpTQUpVV1pNejZqeTRvb0ZGSEVwdkVISjJOTEtZbHB4N2VUM2Ry?=
 =?iso-2022-jp?B?T2Z2VHBIdFpGbDAvci95RFV0RGdTclhudEQ4ejczcWFsZWZOYmJDT0Vw?=
 =?iso-2022-jp?B?clpOSDJNU1NyM1paWVJRVklBSjBEZWtDWUlSNmFBNDM2cmhkaWUxQ0Fj?=
 =?iso-2022-jp?B?V3kzSTNpU1ZmN0JkNUtWVnpraHRmTDhTS3JPdCtRWklwRVExb1J1dUt4?=
 =?iso-2022-jp?B?dVFlNkp1MXVXMDBsaVhVak9qRDF6UDRxMUU4bmxqWWhhbGQ5Y0VwK0dq?=
 =?iso-2022-jp?B?bVFTU1RrQ1JMbjJrQi9CazNxMVNoRWtrWStDanlRZWl1MzRyUXloNmRJ?=
 =?iso-2022-jp?B?VDBkbUNuRUQyUm1takhJc1Bsa01SYmFCWXJvME5GNFlBVmxCVnJRUitE?=
 =?iso-2022-jp?B?M3MxVnM5cWZYakxHWnArK1dxbG15TmtyWDJuTjhkYzFoeWxQcmxVclB4?=
 =?iso-2022-jp?B?VVkwQjdKMFJVZ1I5T0hrMmRXQU9EU0QxVUlEUXFleGJoU292dThFMmVt?=
 =?iso-2022-jp?B?QUZhRVJSWGlsT3h6V3JqMzF5VjdReTBweVhrbVFRSlY2dUs4bytVR1g2?=
 =?iso-2022-jp?B?NHBvb1lxN3lPTFA0eTQ0c3RLbmJGMkFKTkljdkZHaHFyVGVIQUFiL0Iz?=
 =?iso-2022-jp?B?ZGhRRHdVZ2lSV0lzZnAvalc2WnZwM20vN1ZES3pzT2M0QUZHcU5BaEFJ?=
 =?iso-2022-jp?B?R0htZGppRXNheHBPbWRQeFZMaW81QkxkOW4ybEtqTjlPcUdkY1ZUNHBS?=
 =?iso-2022-jp?B?emVKUlMycVhCekt0NmwvRkRTdEw0cjlEZncxOU5HT3E3RktGc09SeTNp?=
 =?iso-2022-jp?B?TlJYQjc0cU14eHZhU1dLanhuK3NmOC83Q0YvVlB2NzlleXpDU0FBYWxE?=
 =?iso-2022-jp?B?eGlyR0VTNzZTekVEaC9xbHYxMEdrbktrcSttKy9zOS9RWHNIbzY4bUQv?=
 =?iso-2022-jp?B?Qi9RV3QycDZsU2szanhRakhuL0wzcG5WK2YwcW8ySnhQVGFJM3VnSnNG?=
 =?iso-2022-jp?B?ZGhJNFptVkQvSFhrVVRrVDd4cFJPbTVRKzAwZHM0S0sxU3FnbExsWTdu?=
 =?iso-2022-jp?B?b2piR2J1TldvZHpzUnBQQTRVZCtEMFA4eUYwRGlwREtpdTNLKy9heExD?=
 =?iso-2022-jp?B?RFVKMGplZUxoakY2bm55QTBkK1dnY0VYZ2c5VUJqbXFkRGpRUGp3SXBV?=
 =?iso-2022-jp?B?cHVSb2pNanVtQUZqSTJRYjZjWGQ4SVRkTGY0TGhnQ0pSc0FKNCtpSWZr?=
 =?iso-2022-jp?B?MnhQVUtWUHd3WktnL3JIMnY0ZUxRdGd6ajZXdw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0cc60317-a0b0-4118-dd8b-08da2384d22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 10:50:59.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 L9nU3iRZDYS33nVcli3Tv/q+FE7zVk2FWevrf26xgikj9ls33wIwyr3hHNR7CQfgUcjsxK43Uft0GzNv0qVCBkT03PNELN9T8JqJQxgAsb76baofcbn/ByZ0aml943jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4260
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8157

Hi Nobuhiro,

Thank you for the review.

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 21 April 2022 02:12
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-
> dev@lists.cip-project.org; pavel@denx.de
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
>=20
> Hi Lad,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Thursday, April 21, 2022 6:34 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B""#S#W#C"~=1B(B
> =1B$B#A=1B(B
> > =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel=
@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
> >
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801 upstream.
> >
> > Add serial sound interface(SSIF-2) driver support for RZ/G2L SoC.
> >
> > Based on the work done by Chris Brandt for RZ/A SSI driver.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Link:
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fr%2F20210813091156.10700-2-biju.das.jz%40bp.renesas.co&a
> > mp;data=3D05%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.com%7Cc04d969=
d
> > 9c0d44303be708da233402c4%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C
> > 637861003542900587%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> > iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dj%2=
F
> > 49Jn9UomcKR6Muv0IOAII11j6my86H%2BvYVQ1McGaY%3D&amp;reserved=3D0
> > m
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > [PL: Dropped using modern terminology]
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  sound/soc/sh/Kconfig  |   6 +
> >  sound/soc/sh/Makefile |   4 +
> >  sound/soc/sh/rz-ssi.c | 871
> > ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 881 insertions(+)
> >  create mode 100644 sound/soc/sh/rz-ssi.c
> >
> > diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig index
> > ef8a29b9f641..f19bd15c0900 100644
> > --- a/sound/soc/sh/Kconfig
> > +++ b/sound/soc/sh/Kconfig
> > @@ -44,6 +44,12 @@ config SND_SOC_RCAR
> >  	help
> >  	  This option enables R-Car SRU/SCU/SSIU/SSI sound support
> >
> > +config SND_SOC_RZ
> > +	tristate "RZ/G2L series SSIF-2 support"
> > +	depends on ARCH_R9A07G044 || COMPILE_TEST
> > +	help
> > +	  This option enables RZ/G2L SSIF-2 sound support.
> > +
> >  ##
> >  ## Boards
> >  ##
> > diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile index
> > 51bd7c81671c..f6fd79948f6a 100644
> > --- a/sound/soc/sh/Makefile
> > +++ b/sound/soc/sh/Makefile
> > @@ -22,3 +22,7 @@ snd-soc-migor-objs		:=3D migor.o
> >
> >  obj-$(CONFIG_SND_SH7760_AC97)	+=3D snd-soc-sh7760-ac97.o
> >  obj-$(CONFIG_SND_SIU_MIGOR)	+=3D snd-soc-migor.o
> > +
> > +# RZ/G2L
> > +snd-soc-rz-ssi-objs		:=3D rz-ssi.o
> > +obj-$(CONFIG_SND_SOC_RZ)	+=3D snd-soc-rz-ssi.o
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c new file
> > mode
> > 100644 index 000000000000..7e0d3a4485e3
> > --- /dev/null
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -0,0 +1,871 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Renesas RZ/G2L ASoC Serial Sound Interface (SSIF-2) Driver // //
> > +Copyright (C) 2021 Renesas Electronics Corp.
> > +// Copyright (C) 2019 Chris Brandt.
> > +//
> > +
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/reset.h>
> > +#include <sound/soc.h>
> > +
> > +/* REGISTER OFFSET */
> > +#define SSICR			0x000
> > +#define SSISR			0x004
> > +#define SSIFCR			0x010
> > +#define SSIFSR			0x014
> > +#define SSIFTDR			0x018
> > +#define SSIFRDR			0x01c
> > +#define SSIOFR			0x020
> > +#define SSISCR			0x024
> > +
> > +/* SSI REGISTER BITS */
> > +#define SSICR_DWL(x)		(((x) & 0x7) << 19)
> > +#define SSICR_SWL(x)		(((x) & 0x7) << 16)
> > +#define SSICR_MST		BIT(14)
> > +#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
> > +
> > +#define SSICR_CKS		BIT(30)
> > +#define SSICR_TUIEN		BIT(29)
> > +#define SSICR_TOIEN		BIT(28)
> > +#define SSICR_RUIEN		BIT(27)
> > +#define SSICR_ROIEN		BIT(26)
> > +#define SSICR_MST		BIT(14)
> > +#define SSICR_BCKP		BIT(13)
> > +#define SSICR_LRCKP		BIT(12)
> > +#define SSICR_CKDV(x)		(((x) & 0xf) << 4)
> > +#define SSICR_TEN		BIT(1)
> > +#define SSICR_REN		BIT(0)
> > +
> > +#define SSISR_TUIRQ		BIT(29)
> > +#define SSISR_TOIRQ		BIT(28)
> > +#define SSISR_RUIRQ		BIT(27)
> > +#define SSISR_ROIRQ		BIT(26)
> > +#define SSISR_IIRQ		BIT(25)
> > +
> > +#define SSIFCR_AUCKE		BIT(31)
> > +#define SSIFCR_SSIRST		BIT(16)
> > +#define SSIFCR_TIE		BIT(3)
> > +#define SSIFCR_RIE		BIT(2)
> > +#define SSIFCR_TFRST		BIT(1)
> > +#define SSIFCR_RFRST		BIT(0)
> > +
> > +#define SSIFSR_TDC_MASK		0x3f
> > +#define SSIFSR_TDC_SHIFT	24
> > +#define SSIFSR_RDC_MASK		0x3f
> > +#define SSIFSR_RDC_SHIFT	8
> > +
> > +#define SSIFSR_TDC(x)		(((x) & 0x1f) << 24)
>=20
> This is not used.
> If you use it, you can use SSIFSR_TDC_SHIFT and SSIFSR_TDC_MASK.
>=20
> > +#define SSIFSR_TDE		BIT(16)
> > +#define SSIFSR_RDC(x)		(((x) & 0x1f) << 8)
>=20
> Same above.
>=20
> > +#define SSIFSR_RDF		BIT(0)
> > +
> > +#define SSIOFR_LRCONT		BIT(8)
> > +
> > +#define SSISCR_TDES(x)		(((x) & 0x1f) << 8)
> > +#define SSISCR_RDFS(x)		(((x) & 0x1f) << 0)
> > +
> > +/* Pre allocated buffers sizes */
> > +#define PREALLOC_BUFFER		(SZ_32K)
> > +#define PREALLOC_BUFFER_MAX	(SZ_32K)
> > +
> > +#define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /*
> > 8k-44.1kHz */
> > +#define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
> > +#define SSI_CHAN_MIN		2
> > +#define SSI_CHAN_MAX		2
> > +#define SSI_FIFO_DEPTH		32
> > +
> > +struct rz_ssi_priv;
> > +
> > +struct rz_ssi_stream {
> > +	struct rz_ssi_priv *priv;
> > +	struct snd_pcm_substream *substream;
> > +	int fifo_sample_size;	/* sample capacity of SSI FIFO */
> > +	int period_counter;	/* for keeping track of periods transferred
> */
> > +	int sample_width;
> > +	int buffer_pos;		/* current frame position in the buffer */
> > +	int running;		/* 0=3Dstopped, 1=3Drunning */
> > +
> > +	int uerr_num;
> > +	int oerr_num;
> > +
> > +	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream
> > +*strm); };
> > +
> > +struct rz_ssi_priv {
> > +	void __iomem *base;
> > +	struct platform_device *pdev;
> > +	struct reset_control *rstc;
> > +	struct device *dev;
> > +	struct clk *sfr_clk;
> > +	struct clk *clk;
> > +
> > +	int irq_int;
> > +	int irq_tx;
> > +	int irq_rx;
> > +
> > +	spinlock_t lock;
> > +
> > +	/*
> > +	 * The SSI supports full-duplex transmission and reception.
> > +	 * However, if an error occurs, channel reset (both transmission
> > +	 * and reception reset) is required.
> > +	 * So it is better to use as half-duplex (playing and recording
> > +	 * should be done on separate channels).
> > +	 */
> > +	struct rz_ssi_stream playback;
> > +	struct rz_ssi_stream capture;
> > +
> > +	/* clock */
> > +	unsigned long audio_mck;
> > +	unsigned long audio_clk_1;
> > +	unsigned long audio_clk_2;
> > +
> > +	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
> > +	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
> > +};
> > +
> > +static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32
> > +data) {
> > +	writel(data, (priv->base + reg));
> > +}
> > +
> > +static u32 rz_ssi_reg_readl(struct rz_ssi_priv *priv, uint reg) {
> > +	return readl(priv->base + reg);
> > +}
> > +
> > +static void rz_ssi_reg_mask_setl(struct rz_ssi_priv __iomem *priv, uin=
t
> reg,
> > +				 u32 bclr, u32 bset)
> > +{
> > +	u32 val;
> > +
> > +	val =3D readl(priv->base + reg);
> > +	val =3D (val & ~bclr) | bset;
> > +	writel(val, (priv->base + reg));
> > +}
> > +
> > +static inline struct snd_soc_dai *
> > +rz_ssi_get_dai(struct snd_pcm_substream *substream) {
> > +	struct snd_soc_pcm_runtime *rtd =3D
> > asoc_substream_to_rtd(substream);
> > +
> > +	return asoc_rtd_to_cpu(rtd, 0);
> > +}
> > +
> > +static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
> > +					 struct snd_pcm_substream
> > *substream) {
> > +	return substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK; }
> > +
> > +static inline struct rz_ssi_stream *
> > +rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream
> > +*substream) {
> > +	struct rz_ssi_stream *stream =3D &ssi->playback;
> > +
> > +	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
> > +		stream =3D &ssi->capture;
> > +
> > +	return stream;
> > +}
> > +
> > +static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
> > +				  struct rz_ssi_stream *strm)
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&ssi->lock, flags);
> > +	ret =3D !!(strm->substream && strm->substream->runtime);
> > +	spin_unlock_irqrestore(&ssi->lock, flags);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
> > +			      struct rz_ssi_stream *strm,
> > +			      struct snd_pcm_substream *substream) {
> > +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +
> > +	strm->substream =3D substream;
> > +	strm->sample_width =3D samples_to_bytes(runtime, 1);
> > +	strm->period_counter =3D 0;
> > +	strm->buffer_pos =3D 0;
> > +
> > +	strm->oerr_num =3D 0;
> > +	strm->uerr_num =3D 0;
> > +	strm->running =3D 0;
> > +
> > +	/* fifo init */
> > +	strm->fifo_sample_size =3D SSI_FIFO_DEPTH;
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
> > +			       struct rz_ssi_stream *strm) {
> > +	struct snd_soc_dai *dai =3D rz_ssi_get_dai(strm->substream);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&ssi->lock, flags);
> > +	strm->substream =3D NULL;
> > +	spin_unlock_irqrestore(&ssi->lock, flags);
> > +
> > +	if (strm->oerr_num > 0)
> > +		dev_info(dai->dev, "overrun =3D %d\n", strm->oerr_num);
> > +
> > +	if (strm->uerr_num > 0)
> > +		dev_info(dai->dev, "underrun =3D %d\n", strm->uerr_num); }
> > +
> > +static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate=
,
> > +			    unsigned int channels)
> > +{
> > +	static s8 ckdv[16] =3D { 1,  2,  4,  8, 16, 32, 64, 128,
> > +			       6, 12, 24, 48, 96, -1, -1, -1 };
> > +	unsigned int channel_bits =3D 32;	/* System Word Length */
> > +	unsigned long bclk_rate =3D rate * channels * channel_bits;
> > +	unsigned int div;
> > +	unsigned int i;
> > +	u32 ssicr =3D 0;
> > +	u32 clk_ckdv;
> > +
> > +	/* Clear AUCKE so we can set MST */
> > +	rz_ssi_reg_writel(ssi, SSIFCR, 0);
> > +
> > +	/* Continue to output LRCK pin even when idle */
> > +	rz_ssi_reg_writel(ssi, SSIOFR, SSIOFR_LRCONT);
> > +	if (ssi->audio_clk_1 && ssi->audio_clk_2) {
> > +		if (ssi->audio_clk_1 % bclk_rate)
> > +			ssi->audio_mck =3D ssi->audio_clk_2;
> > +		else
> > +			ssi->audio_mck =3D ssi->audio_clk_1;
> > +	}
> > +
> > +	/* Clock setting */
> > +	ssicr |=3D SSICR_MST;
> > +	if (ssi->audio_mck =3D=3D ssi->audio_clk_1)
> > +		ssicr |=3D SSICR_CKS;
> > +	if (ssi->bckp_rise)
> > +		ssicr |=3D SSICR_BCKP;
> > +	if (ssi->lrckp_fsync_fall)
> > +		ssicr |=3D SSICR_LRCKP;
> > +
> > +	/* Determine the clock divider */
> > +	clk_ckdv =3D 0;
> > +	div =3D ssi->audio_mck / bclk_rate;
> > +	/* try to find an match */
> > +	for (i =3D 0; i < ARRAY_SIZE(ckdv); i++) {
> > +		if (ckdv[i] =3D=3D div) {
> > +			clk_ckdv =3D i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (i =3D=3D ARRAY_SIZE(ckdv)) {
> > +		dev_err(ssi->dev, "Rate not divisible by audio clock
> > source\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * DWL: Data Word Length =3D 16 bits
> > +	 * SWL: System Word Length =3D 32 bits
> > +	 */
> > +	ssicr |=3D SSICR_CKDV(clk_ckdv);
> > +	ssicr |=3D SSICR_DWL(1) | SSICR_SWL(3);
> > +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> > +	rz_ssi_reg_writel(ssi, SSIFCR,
> > +			  (SSIFCR_AUCKE | SSIFCR_TFRST |
> > SSIFCR_RFRST));
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream
> > +*strm) {
> > +	bool is_play =3D rz_ssi_stream_is_play(ssi, strm->substream);
> > +	u32 ssicr, ssifcr;
> > +
> > +	ssicr =3D rz_ssi_reg_readl(ssi, SSICR);
> > +	ssifcr =3D rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
> > +
> > +	/* FIFO interrupt thresholds */
> > +	rz_ssi_reg_writel(ssi, SSISCR,
> > +			  SSISCR_TDES(strm->fifo_sample_size / 2 - 1) |
> > +			  SSISCR_RDFS(0));
> > +
> > +	/* enable IRQ */
> > +	if (is_play) {
> > +		ssicr |=3D SSICR_TUIEN | SSICR_TOIEN;
> > +		ssifcr |=3D SSIFCR_TIE | SSIFCR_RFRST;
> > +	} else {
> > +		ssicr |=3D SSICR_RUIEN | SSICR_ROIEN;
> > +		ssifcr |=3D SSIFCR_RIE | SSIFCR_TFRST;
> > +	}
> > +
> > +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> > +	rz_ssi_reg_writel(ssi, SSIFCR, ssifcr);
> > +
> > +	/* Clear all error flags */
> > +	rz_ssi_reg_mask_setl(ssi, SSISR,
> > +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> > +			      SSISR_RUIRQ), 0);
> > +
> > +	strm->running =3D 1;
> > +	ssicr |=3D is_play ? SSICR_TEN : SSICR_REN;
> > +	rz_ssi_reg_writel(ssi, SSICR, ssicr);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream
> > +*strm) {
> > +	int timeout;
> > +
> > +	strm->running =3D 0;
> > +
> > +	/* Disable TX/RX */
> > +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
> > +
> > +	/* Disable irqs */
> > +	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
> > +			     SSICR_RUIEN | SSICR_ROIEN, 0);
> > +	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
> > +
> > +	/* Clear all error flags */
> > +	rz_ssi_reg_mask_setl(ssi, SSISR,
> > +			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
> > +			      SSISR_RUIRQ), 0);
> > +
> > +	/* Wait for idle */
> > +	timeout =3D 100;
> > +	while (--timeout) {
> > +		if (rz_ssi_reg_readl(ssi, SSISR) | SSISR_IIRQ)
> > +			break;
> > +		udelay(1);
> > +	}
> > +
> > +	if (!timeout)
> > +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > +
> > +	/* Hold FIFOs in reset */
> > +	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
> > +			     SSIFCR_TFRST | SSIFCR_RFRST);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int
> > +frames) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime;
> > +	int current_period;
> > +
> > +	if (!strm->running || !substream || !substream->runtime)
> > +		return;
> > +
> > +	runtime =3D substream->runtime;
> > +	strm->buffer_pos +=3D frames;
> > +	WARN_ON(strm->buffer_pos > runtime->buffer_size);
> > +
> > +	/* ring buffer */
> > +	if (strm->buffer_pos =3D=3D runtime->buffer_size)
> > +		strm->buffer_pos =3D 0;
> > +
> > +	current_period =3D strm->buffer_pos / runtime->period_size;
> > +	if (strm->period_counter !=3D current_period) {
> > +		snd_pcm_period_elapsed(strm->substream);
> > +		strm->period_counter =3D current_period;
> > +	}
> > +}
> > +
> > +static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct
> > +rz_ssi_stream *strm) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime;
> > +	u16 *buf;
> > +	int fifo_samples;
> > +	int frames_left;
> > +	int samples =3D 0;
> > +	int i;
>=20
>=20
> Please use reverse christmas tree order.
>=20
Sure will keep that in mind.

> > +
> > +	if (!rz_ssi_stream_is_valid(ssi, strm))
> > +		return -EINVAL;
> > +
> > +	runtime =3D substream->runtime;
> > +	/* frames left in this period */
> > +	frames_left =3D runtime->period_size - (strm->buffer_pos %
> > +					      runtime->period_size);
> > +	if (frames_left =3D=3D 0)
> > +		frames_left =3D runtime->period_size;
> > +
> > +	/* Samples in RX FIFO */
> > +	fifo_samples =3D (rz_ssi_reg_readl(ssi, SSIFSR) >>
> > +			SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> > +
> > +	/* Only read full frames at a time */
> > +	while (frames_left && (fifo_samples >=3D runtime->channels)) {
> > +		samples +=3D runtime->channels;
> > +		fifo_samples -=3D runtime->channels;
> > +		frames_left--;
> > +	}
> > +
> > +	/* not enough samples yet */
> > +	if (samples =3D=3D 0)
> > +		return 0;
> > +
> > +	/* calculate new buffer index */
> > +	buf =3D (u16 *)(runtime->dma_area);
> > +	buf +=3D strm->buffer_pos * runtime->channels;
> > +
> > +	/* Note, only supports 16-bit samples */
> > +	for (i =3D 0; i < samples; i++)
> > +		*buf++ =3D (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
> > +
> > +	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> > +	rz_ssi_pointer_update(strm, samples / runtime->channels);
> > +
> > +	/*
> > +	 * If we finished this period, but there are more samples in
> > +	 * the RX FIFO, call this function again
> > +	 */
> > +	if (frames_left =3D=3D 0 && fifo_samples >=3D runtime->channels)
> > +		rz_ssi_pio_recv(ssi, strm);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct
> > +rz_ssi_stream *strm) {
> > +	struct snd_pcm_substream *substream =3D strm->substream;
> > +	struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +	int sample_space;
> > +	int samples =3D 0;
> > +	int frames_left;
> > +	int i;
> > +	u32 ssifsr;
> > +	u16 *buf;
>=20
> Please use reverse christmas tree order.
>=20
Ditto.

Cheers,
Prabhakar

> > +
> > +	if (!rz_ssi_stream_is_valid(ssi, strm))
> > +		return -EINVAL;
> > +
> > +	/* frames left in this period */
> > +	frames_left =3D runtime->period_size - (strm->buffer_pos %
> > +					      runtime->period_size);
> > +	if (frames_left =3D=3D 0)
> > +		frames_left =3D runtime->period_size;
> > +
> > +	sample_space =3D strm->fifo_sample_size;
> > +	ssifsr =3D rz_ssi_reg_readl(ssi, SSIFSR);
> > +	sample_space -=3D (ssifsr >> SSIFSR_TDC_SHIFT) &
> > SSIFSR_TDC_MASK;
> > +
> > +	/* Only add full frames at a time */
> > +	while (frames_left && (sample_space >=3D runtime->channels)) {
> > +		samples +=3D runtime->channels;
> > +		sample_space -=3D runtime->channels;
> > +		frames_left--;
> > +	}
> > +
> > +	/* no space to send anything right now */
> > +	if (samples =3D=3D 0)
> > +		return 0;
> > +
> > +	/* calculate new buffer index */
> > +	buf =3D (u16 *)(runtime->dma_area);
> > +	buf +=3D strm->buffer_pos * runtime->channels;
> > +
> > +	/* Note, only supports 16-bit samples */
> > +	for (i =3D 0; i < samples; i++)
> > +		rz_ssi_reg_writel(ssi, SSIFTDR, ((u32)(*buf++) << 16));
> > +
> > +	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_TDE, 0);
> > +	rz_ssi_pointer_update(strm, samples / runtime->channels);
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t rz_ssi_interrupt(int irq, void *data) {
> > +	struct rz_ssi_stream *strm =3D NULL;
> > +	struct rz_ssi_priv *ssi =3D data;
> > +	u32 ssisr =3D rz_ssi_reg_readl(ssi, SSISR);
> > +
> > +	if (ssi->playback.substream)
> > +		strm =3D &ssi->playback;
> > +	else if (ssi->capture.substream)
> > +		strm =3D &ssi->capture;
> > +	else
> > +		return IRQ_HANDLED; /* Left over TX/RX interrupt */
> > +
> > +	if (irq =3D=3D ssi->irq_int) { /* error or idle */
> > +		if (ssisr & SSISR_TUIRQ)
> > +			strm->uerr_num++;
> > +		if (ssisr & SSISR_TOIRQ)
> > +			strm->oerr_num++;
> > +		if (ssisr & SSISR_RUIRQ)
> > +			strm->uerr_num++;
> > +		if (ssisr & SSISR_ROIRQ)
> > +			strm->oerr_num++;
> > +
> > +		if (ssisr & (SSISR_TUIRQ | SSISR_TOIRQ | SSISR_RUIRQ |
> > +			     SSISR_ROIRQ)) {
> > +			/* Error handling */
> > +			/* You must reset (stop/restart) after each interrupt */
> > +			rz_ssi_stop(ssi, strm);
> > +
> > +			/* Clear all flags */
> > +			rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
> > +					     SSISR_TUIRQ | SSISR_ROIRQ |
> > +					     SSISR_RUIRQ, 0);
> > +
> > +			/* Add/remove more data */
> > +			strm->transfer(ssi, strm);
> > +
> > +			/* Resume */
> > +			rz_ssi_start(ssi, strm);
> > +		}
> > +	}
> > +
> > +	if (!strm->running)
> > +		return IRQ_HANDLED;
> > +
> > +	/* tx data empty */
> > +	if (irq =3D=3D ssi->irq_tx)
> > +		strm->transfer(ssi, &ssi->playback);
> > +
> > +	/* rx data full */
> > +	if (irq =3D=3D ssi->irq_rx) {
> > +		strm->transfer(ssi, &ssi->capture);
> > +		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream,
> > +int
> > cmd,
> > +			      struct snd_soc_dai *dai)
> > +{
> > +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> > +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
> > +	int ret =3D 0;
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +		/* Soft Reset */
> > +		rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
> > +		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
> > +		udelay(5);
> > +
> > +		ret =3D rz_ssi_stream_init(ssi, strm, substream);
> > +		if (ret)
> > +			goto done;
> > +
> > +		ret =3D strm->transfer(ssi, strm);
> > +		if (ret)
> > +			goto done;
> > +
> > +		ret =3D rz_ssi_start(ssi, strm);
> > +		break;
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +		rz_ssi_stop(ssi, strm);
> > +		rz_ssi_stream_quit(ssi, strm);
> > +		break;
> > +	}
> > +
> > +done:
> > +	return ret;
> > +}
> > +
> > +static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int
> > +fmt) {
> > +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> > +
> > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +	case SND_SOC_DAIFMT_CBS_CFS:
> > +		break;
> > +	default:
> > +		dev_err(ssi->dev, "Codec should be clk and frame
> > consumer\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * set clock polarity
> > +	 *
> > +	 * "normal" BCLK =3D Signal is available at rising edge of BCLK
> > +	 * "normal" FSYNC =3D (I2S) Left ch starts with falling FSYNC edge
> > +	 */
> > +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> > +	case SND_SOC_DAIFMT_NB_NF:
> > +		ssi->bckp_rise =3D false;
> > +		ssi->lrckp_fsync_fall =3D false;
> > +		break;
> > +	case SND_SOC_DAIFMT_NB_IF:
> > +		ssi->bckp_rise =3D false;
> > +		ssi->lrckp_fsync_fall =3D true;
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_NF:
> > +		ssi->bckp_rise =3D true;
> > +		ssi->lrckp_fsync_fall =3D false;
> > +		break;
> > +	case SND_SOC_DAIFMT_IB_IF:
> > +		ssi->bckp_rise =3D true;
> > +		ssi->lrckp_fsync_fall =3D true;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* only i2s support */
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_I2S:
> > +		break;
> > +	default:
> > +		dev_err(ssi->dev, "Only I2S mode is supported.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
> > +				struct snd_pcm_hw_params *params,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> > +	unsigned int sample_bits =3D hw_param_interval(params,
> > +
> > 	SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
> > +	unsigned int channels =3D params_channels(params);
> > +
> > +	if (sample_bits !=3D 16) {
> > +		dev_err(ssi->dev, "Unsupported sample width: %d\n",
> > +			sample_bits);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (channels !=3D 2) {
> > +		dev_err(ssi->dev, "Number of channels not matched: %d\n",
> > +			channels);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return rz_ssi_clk_setup(ssi, params_rate(params),
> > +				params_channels(params));
> > +}
> > +
> > +static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
> > +	.trigger	=3D rz_ssi_dai_trigger,
> > +	.set_fmt	=3D rz_ssi_dai_set_fmt,
> > +	.hw_params	=3D rz_ssi_dai_hw_params,
> > +};
> > +
> > +static const struct snd_pcm_hardware rz_ssi_pcm_hardware =3D {
> > +	.info			=3D SNDRV_PCM_INFO_INTERLEAVED	|
> > +				  SNDRV_PCM_INFO_MMAP		|
> > +				  SNDRV_PCM_INFO_MMAP_VALID,
> > +	.buffer_bytes_max	=3D PREALLOC_BUFFER,
> > +	.period_bytes_min	=3D 32,
> > +	.period_bytes_max	=3D 8192,
> > +	.channels_min		=3D SSI_CHAN_MIN,
> > +	.channels_max		=3D SSI_CHAN_MAX,
> > +	.periods_min		=3D 1,
> > +	.periods_max		=3D 32,
> > +	.fifo_size		=3D 32 * 2,
> > +};
> > +
> > +static int rz_ssi_pcm_open(struct snd_soc_component *component,
> > +			   struct snd_pcm_substream *substream) {
> > +	snd_soc_set_runtime_hwparams(substream,
> > &rz_ssi_pcm_hardware);
> > +
> > +	return snd_pcm_hw_constraint_integer(substream->runtime,
> > +
> > SNDRV_PCM_HW_PARAM_PERIODS);
> > +}
> > +
> > +static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component
> > *component,
> > +					    struct snd_pcm_substream
> > *substream) {
> > +	struct snd_soc_dai *dai =3D rz_ssi_get_dai(substream);
> > +	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
> > +	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
> > +
> > +	return strm->buffer_pos;
> > +}
> > +
> > +static int rz_ssi_pcm_new(struct snd_soc_component *component,
> > +			  struct snd_soc_pcm_runtime *rtd) {
> > +	snd_pcm_set_managed_buffer_all(rtd->pcm,
> > SNDRV_DMA_TYPE_DEV,
> > +				       rtd->card->snd_card->dev,
> > +				       PREALLOC_BUFFER,
> > PREALLOC_BUFFER_MAX);
> > +	return 0;
> > +}
> > +
> > +static struct snd_soc_dai_driver rz_ssi_soc_dai[] =3D {
> > +	{
> > +		.name			=3D "rz-ssi-dai",
> > +		.playback =3D {
> > +			.rates		=3D SSI_RATES,
> > +			.formats	=3D SSI_FMTS,
> > +			.channels_min	=3D SSI_CHAN_MIN,
> > +			.channels_max	=3D SSI_CHAN_MAX,
> > +		},
> > +		.capture =3D {
> > +			.rates		=3D SSI_RATES,
> > +			.formats	=3D SSI_FMTS,
> > +			.channels_min	=3D SSI_CHAN_MIN,
> > +			.channels_max	=3D SSI_CHAN_MAX,
> > +		},
> > +		.ops =3D &rz_ssi_dai_ops,
> > +	},
> > +};
> > +
> > +static const struct snd_soc_component_driver rz_ssi_soc_component =3D =
{
> > +	.name		=3D "rz-ssi",
> > +	.open		=3D rz_ssi_pcm_open,
> > +	.pointer	=3D rz_ssi_pcm_pointer,
> > +	.pcm_construct	=3D rz_ssi_pcm_new,
> > +};
> > +
> > +static int rz_ssi_probe(struct platform_device *pdev) {
> > +	struct rz_ssi_priv *ssi;
> > +	struct clk *audio_clk;
> > +	int ret;
> > +
> > +	ssi =3D devm_kzalloc(&pdev->dev, sizeof(*ssi), GFP_KERNEL);
> > +	if (!ssi)
> > +		return -ENOMEM;
> > +
> > +	ssi->pdev =3D pdev;
> > +	ssi->dev =3D &pdev->dev;
> > +	ssi->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(ssi->base))
> > +		return PTR_ERR(ssi->base);
> > +
> > +	ssi->clk =3D devm_clk_get(&pdev->dev, "ssi");
> > +	if (IS_ERR(ssi->clk))
> > +		return PTR_ERR(ssi->clk);
> > +
> > +	ssi->sfr_clk =3D devm_clk_get(&pdev->dev, "ssi_sfr");
> > +	if (IS_ERR(ssi->sfr_clk))
> > +		return PTR_ERR(ssi->sfr_clk);
> > +
> > +	audio_clk =3D devm_clk_get(&pdev->dev, "audio_clk1");
> > +	if (IS_ERR(audio_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
> > +				     "no audio clk1");
> > +
> > +	ssi->audio_clk_1 =3D clk_get_rate(audio_clk);
> > +	audio_clk =3D devm_clk_get(&pdev->dev, "audio_clk2");
> > +	if (IS_ERR(audio_clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(audio_clk),
> > +				     "no audio clk2");
> > +
> > +	ssi->audio_clk_2 =3D clk_get_rate(audio_clk);
> > +	if (!(ssi->audio_clk_1 || ssi->audio_clk_2))
> > +		return dev_err_probe(&pdev->dev, -EINVAL,
> > +				     "no audio clk1 or audio clk2");
> > +
> > +	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 :
> > +ssi->audio_clk_2;
> > +
> > +	ssi->playback.transfer =3D rz_ssi_pio_send;
> > +	ssi->capture.transfer =3D rz_ssi_pio_recv;
> > +	ssi->playback.priv =3D ssi;
> > +	ssi->capture.priv =3D ssi;
> > +
> > +	/* Error Interrupt */
> > +	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
> > +	if (ssi->irq_int < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI int_req IRQ\n");
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
> > +			       0, dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (int_req)\n");
> > +
> > +	/* Tx and Rx interrupts (pio only) */
> > +	ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> > +	if (ssi->irq_tx < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI dma_tx IRQ\n");
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt,
> > 0,
> > +			       dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (dma_tx)\n");
> > +
> > +	ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> > +	if (ssi->irq_rx < 0)
> > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > +				     "Unable to get SSI dma_rx IRQ\n");
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt,
> > 0,
> > +			       dev_name(&pdev->dev), ssi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "irq request error (dma_rx)\n");
> > +
> > +	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +	if (IS_ERR(ssi->rstc))
> > +		return PTR_ERR(ssi->rstc);
> > +
> > +	reset_control_deassert(ssi->rstc);
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_resume_and_get(&pdev->dev);
> > +
> > +	spin_lock_init(&ssi->lock);
> > +	dev_set_drvdata(&pdev->dev, ssi);
> > +	ret =3D devm_snd_soc_register_component(&pdev->dev,
> > &rz_ssi_soc_component,
> > +					      rz_ssi_soc_dai,
> > +
> > ARRAY_SIZE(rz_ssi_soc_dai));
> > +	if (ret < 0) {
> > +		pm_runtime_put(ssi->dev);
> > +		pm_runtime_disable(ssi->dev);
> > +		reset_control_assert(ssi->rstc);
> > +		dev_err(&pdev->dev, "failed to register snd component\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int rz_ssi_remove(struct platform_device *pdev) {
> > +	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
> > +
> > +	pm_runtime_put(ssi->dev);
> > +	pm_runtime_disable(ssi->dev);
> > +	reset_control_assert(ssi->rstc);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id rz_ssi_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rz-ssi", },
> > +	{/* Sentinel */},
> > +};
> > +MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
> > +
> > +static struct platform_driver rz_ssi_driver =3D {
> > +	.driver	=3D {
> > +		.name	=3D "rz-ssi-pcm-audio",
> > +		.of_match_table =3D rz_ssi_of_match,
> > +	},
> > +	.probe		=3D rz_ssi_probe,
> > +	.remove		=3D rz_ssi_remove,
> > +};
> > +
> > +module_platform_driver(rz_ssi_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L ASoC Serial Sound Interface
> > +Driver"); MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > --
> > 2.17.1
>=20
> Best regards,
>   Nobuhiro


