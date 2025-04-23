Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8845C369D5
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 19:42:17 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.49])
 by mx.groups.io with SMTP id smtpd.web11.3853.1745437331642964237
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 12:42:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=u4HplX4c;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.49, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcl0XD8lbe6CAdJqUE9mH3kbc+S7MBYEl7WudiFgOayHV8sIzxs8iBWBNDuAiwz5f4s/ZFVnqeTjMTH/1zTGR9HHzHrmB8uN34pxAoyepyfdcAQSPEtpsjfGU/s4BghuRcya7BxxeVSwmzHVA4nhSW9EjKZqpgvNp23mQJILdgVoXlUwMbBwXvQBVbD7fya64Bd2GXpVZoo+VhyyEEAhGzGktLfjfMT7jkAQL4mVRe0dLjHGBt/J9eSaJ8KH/bFky87dwJbEUZnlPAmYjsDhFvHbh0wLSl5xtXb01dhclkmIBdUz+A58wJxWgRW5ab0ZSXqjjqY/siHfDKdE29ZhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvrQGS1wYcTwSjXw2tdnlyewo98nkhCcg12Ha9Sh5cg=;
 b=hC4YJiU1XjT6ZvPKWR32ID6/BmuaD9Roe0oYvfzbyDlaH7cOL2aLCb1bod2XarU+CNr2tzEm7B2XpoHquv97DHHsWC7p9R/i+S/BGgV3EtutzqBLs9o14gtsy8eiM6qq3vrpm3SWolUOBlmKOIK1MwCpAN8nT9LlENvvZCskFMNQrS8aD5V++lXo3xiP/TiRLMcGJ6HK7aadeUdLA80uOTPUjWGwdIEAIsVtN6wEnkgVU4q+3slUQhGXQ+mIrqrahSsuQvwH/htVh2tsQypAsdJrUJ5t7th95FMkAHNBntQoR387ZbyTPB2VbqLcyXS2U+jhPMFQ9TYwqBRmczRAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvrQGS1wYcTwSjXw2tdnlyewo98nkhCcg12Ha9Sh5cg=;
 b=u4HplX4cfaxSYJ1if4emVwyBpGLp5PKBELGmktbQrL2ek0o+esx5AE7BTJA/ggdUKkSDqYw2w6OATBn3wGovECggDuX0EO/5o/0tT8pfFZ3eH/l1RjHtpknt3glmwOqL3ulCvrFY/A/M8ZlSiTN94gahou3cU92x95u8WfUzLMY=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYWPR01MB9644.jpnprd01.prod.outlook.com (2603:1096:400:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 19:42:02 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8655.027; Wed, 23 Apr 2025
 19:42:02 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 6.12.y-cip 03/10] soc: renesas: Add SYSC driver for
 Renesas RZ family
Thread-Topic: [PATCH 6.12.y-cip 03/10] soc: renesas: Add SYSC driver for
 Renesas RZ family
Thread-Index: AQHbtIQjjCgR46jepUqjvjhqWtWnfrOxpVPg
Date: Wed, 23 Apr 2025 19:42:01 +0000
Message-ID: 
 <OSZPR01MB701946B84BD057B7CF877DCAAABA2@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250423181400.13960-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aAk8X/KVkfcYJz2O@duo.ucw.cz>
In-Reply-To: <aAk8X/KVkfcYJz2O@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYWPR01MB9644:EE_
x-ms-office365-filtering-correlation-id: 68c78076-43b8-4598-c9ba-08dd829eeb44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?+n8191ov5DxiA9N1THMValb21ZOZhJdQOPcIcK5tM8gWmIyX5V68ICb7SvAu?=
 =?us-ascii?Q?V0QZxuxhSnLZcdTK331hYZ2U0pD6Mu5QgfSaLdwdtAAvT+9C6EM4mptiaUUC?=
 =?us-ascii?Q?1SLTe5oopJNhiybEJfL5ilHx6wig+RjFDrRKKZNdhxJWz1tlWc0fWVcmQryq?=
 =?us-ascii?Q?iJ+aD/5XOHQXV8sitcyaP0c1ODtUFC41pPop5gJ93wuwssOl+F0iq00jeSpb?=
 =?us-ascii?Q?NbUs89Oj51sbjZgdqxMW+cACER76Vy5V0fB6TMycC4Wy4sPGQOZKidbVKUqh?=
 =?us-ascii?Q?YpkOYkiuVNUlRS08SyAOXbB7pILHas4Dyhfa1CwcnZdkZVABNNKUCOTsEg2R?=
 =?us-ascii?Q?qYReXgklbewWG4Pj3AhBtSaQ+o+tXW6PtTq+e0HALxyAeGgjQcLKM49KhmVx?=
 =?us-ascii?Q?Yd0Yy1aAwhtJ2VEp21YeQDBZnfchyr4BC+5WvTW/aVaFjqIo5Gbm/WrBTS9D?=
 =?us-ascii?Q?7M2CB+KvxJAyXkkt4KK5fAn2jeGIu/oDAM4K/iS5v7kGmXHTMApG2Q6GCAmE?=
 =?us-ascii?Q?psLhtgzyqciHjM28y0eqmKRvoNHGrLsZAIjkVbvC6ZzY1tqgA+qPJhh2SmEv?=
 =?us-ascii?Q?JLBv4U7NAMvnTu1z/fH4NdSxiSiSE7zimDYEdPflYodEvvxzswA5k0CuqKFG?=
 =?us-ascii?Q?Ax6FB8UF8j8yhKzM6/TZw2P5BBlWUCNjZwFMweBi2LHNpzvenCrbclW7ly+s?=
 =?us-ascii?Q?Q9tZinoiBghUoGUb8wzmGh5WdM6OftKA1P55GENvawHE5ZopCpSEE4n//NSp?=
 =?us-ascii?Q?T3hS5xofz6H8sEjSAFW/0WvyOIp23wfNTuezSX67Xut/oLqorHCVzPn0aKWs?=
 =?us-ascii?Q?ezf2Ec5N0twdPfxBAMELpNhWLMbK51O/7U/YZ6FHTKpOITzjneoV9IXhfsQi?=
 =?us-ascii?Q?vBQyVN51sbr6HW8mrzaCkmYirwmcrpMzS4TsqK9SsxTz4/sCz2p659pQpuNV?=
 =?us-ascii?Q?9iqpo9uRscjagBvQIw6pCGM2iEbgk76kpdN/MgRXq2fNdCyLVhaoLk6Rjt5b?=
 =?us-ascii?Q?q3zbaiXCDMcP2CpnWvJYy8MdZoerI1ZTnq1hCUs09ZNgmWriGsygyTje+ESu?=
 =?us-ascii?Q?sEu3X2VXPjR/UusXB9Egyobh71IfwZfPqE8hNZkEB/X3jU3PiEyypQkZbL/X?=
 =?us-ascii?Q?Xo/xwJf7w0umvs5/qHoNm1QxBvcEChtx8Mg+EwwChFjXGt+Fp7n4sVw/f1k8?=
 =?us-ascii?Q?SORrocgEbVwM18eyN9qY0k0unGwT9qIUTMadWulcGGFy076U5VjYD8U3JYnQ?=
 =?us-ascii?Q?siSmbr4EeYJCzpypLu8Ofsq0qRGdiFlCVMtXi7wq37hInKKj3vGnSCpsbONb?=
 =?us-ascii?Q?ID+ksohT6LLBfO1fF6J8FjuCiJkdSxEqMM3UMynND+qRUnryHtdpkekKG3zq?=
 =?us-ascii?Q?8XBLyHvuhvJgooogw0hr5jn16DaLaw9wtNM/Jq06fdHFp8RAAaS78Zb+USbu?=
 =?us-ascii?Q?c/+hs/Db6zxszSHK5tqX2L7Ea7r4+Sa+JGbrfrw6ubZKSW95aNhrTrlvkAPV?=
 =?us-ascii?Q?UO7zWYivurcd9Ck=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7k8rTkfOAl9uWtFfv+QdwVasSpfm/kD8XjuM10tpO9xtr+ifjJMGdXN2/vZU?=
 =?us-ascii?Q?THG4sgItqx01v1cdWOWXeceoPf48ZzQR7vskjPv/Q4YuJNg8H2kYAHLJwY8k?=
 =?us-ascii?Q?aUw+veAV9y+/BwCMTZg29UzZfK2QzB4ODKE7DN7hJlmuBcf0GAvMM2WuJ3tn?=
 =?us-ascii?Q?E3HFl5SLToUOPHXe+W5gvhCE9ixfSS1K/OYvv6zNSWK9o7EGmxHCgrvAQTOR?=
 =?us-ascii?Q?29bVTFVqfwjf9Kfv4Azi3sk5MIaTT8Jp09MIoyWFv2QgcmlJiDkCPQIU61O8?=
 =?us-ascii?Q?Un5Yp1/rSQNdIu9n9WoYdRDjifO+9+7uZXi2TIIDO4HFLck483xU3i6crRE0?=
 =?us-ascii?Q?fJXVBvvtkkNPC1WGLLBWKn7M4UVOzorkmZaIxQWr8JD++HC1ln5AudMa/R3o?=
 =?us-ascii?Q?Y0fWLqwOutkE6HiGFSTZBV3WfD7dVl2QNkPU3BSXMxo0j/JyUNI5A48eTArS?=
 =?us-ascii?Q?dd0SbiTYOfB7UXnPpFODUnbDPzuJjjmtoe71yvFxSqG+qTtvomFaLMoBeOr2?=
 =?us-ascii?Q?wKsvKdQPsSbIrY676BBFWR3VF4PdNJrZnOnTB0i/75xibwtCAcZmTRwcJiiI?=
 =?us-ascii?Q?Gs7Uawq8wUirg05+UB9XvX/JS1R5Gy9e7GYR4MwNXCAwQwNVATFyvKXGTUOI?=
 =?us-ascii?Q?GA5IuMGC/oXUGKufRk9Z0k/jekFJdUi9TuQo3KsFoQueCggDCbQKO3dEvGzu?=
 =?us-ascii?Q?ZAUGcEp3GAia8560GVMGhe6RzjBoyeAk9lyJ6S4dVKbaUp5OBQppZLnWmVw+?=
 =?us-ascii?Q?6j57E/4GIjW5mQEHBhlDB7dyhrEq/VyAkLuWSdITYxQKgaK6kQPKnfe5MWCV?=
 =?us-ascii?Q?9ZQyv0g8y3bGTd6R6QyOFv+/wijA5Y9S5ivKNAQ5+Fca/PYpw9TdzKHbIaho?=
 =?us-ascii?Q?iZb1n4Bx0EoDBDJ25sePeFow4VleNNBvymxmWxNfjMn3qJ18EDYN1Cm7pe5x?=
 =?us-ascii?Q?l8D3ySo+TlQt+dNJt5FRfOYtnatt8+iF/aJIaIgCZjko10L/yBENWIMibwtD?=
 =?us-ascii?Q?5kt2ugeu/74pTguqX3QxLgIFhCrODKo1wyRofnbjU8HbyMMN7XXRtOYalIkf?=
 =?us-ascii?Q?C06d7jzmXww3I/JbqlWqN3jv3Un1rQanlPTvLZE9vOlXi2nVhb0uPgSF88Kq?=
 =?us-ascii?Q?JmGqYO/7WODgP9Yy6fWSJghVJKhp/6jo64NHQ0Po5iRGBKo1ZXb7phwr8lsq?=
 =?us-ascii?Q?rLuYDg5HHgcTbwxGVCMOU2m9ke+DcQ6RZgGVvnMUwjiP8J4eYRPWCBCgaWK7?=
 =?us-ascii?Q?20MnYdAqA+YmeqhYiQxMUwGERcP99/PMFvZVE65uvN05XfFulALar62ViLUk?=
 =?us-ascii?Q?KR7NNxmD/Lw6AV+ggiIUBtJnW1wC78Hv4UzZlEiyN6bdQ/lhyfeTIKvM1GTV?=
 =?us-ascii?Q?euR9Gx8YFPn58IflQuY1uJRHJ+MI8TTXZUSRDrdAugcKjtUqQj5424fHjHbv?=
 =?us-ascii?Q?FAvnx2FVg77EfVkNmZxSzOzq6RDjPDb3yBZGsn5YwfcxX85uQP47kizK52Oj?=
 =?us-ascii?Q?M3zebhh+RmEOMpmp2H4IdLfiFjkD1+qNyyIapR7+bdi5gjJ391XXHuy13hB7?=
 =?us-ascii?Q?PsBpSiXwqB86xHJkngwvwvjmM96NTgeU0v/xwu6hzohzO5kplpmD3Q9+aEb3?=
 =?us-ascii?Q?VPqKadth9eHVdJs+n47V2zw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c78076-43b8-4598-c9ba-08dd829eeb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 19:42:02.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voO6Lz2OPVHkv1X/FJSLknJMc5KhApo2ODAl6kXBCPBBUMofYeY9upb+Zop+h2j8lIEEN5XZrZLCxxpp1fAzb6sS+ho6jMTpG1IvOWrLZigimI95qPLw41j8zdPE2woY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9644
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 19:42:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18582

Hi Pavel,

Thank you for the review.

> Subject: Re: [PATCH 6.12.y-cip 03/10] soc: renesas: Add SYSC driver for
> Renesas RZ family
>=20
> Hi!
>=20
> > commit c1aca5588279fc341a2e12d61e853bb1fd4c72d5 upstream.
> >
> > The RZ/G3S system controller (SYSC) has various registers that control
> > different functionalities.  One of the exposed register offers
> > information about the SoC identification.
> >
> > Add a driver that identifies the SoC.  Later the driver will be
> > extended with other functionalities.
>=20
> Nitpick:
>=20
> > +++ b/drivers/soc/renesas/rz-sysc.c
> > +static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct
> > +of_device_id *match) {
> > +	const struct rz_sysc_init_data *sysc_data =3D match->data;
> > +	const struct rz_sysc_soc_id_init_data *soc_data =3D sysc_data-
> >soc_id_init_data;
> > +	struct soc_device_attribute *soc_dev_attr;
> > +	const char *soc_id_start, *soc_id_end;
> > +	u32 val, revision, specific_id;
> > +	struct soc_device *soc_dev;
> > +	char soc_id[32] =3D {0};
> > +	size_t size;
> > +
> > +	soc_id_start =3D strchr(match->compatible, ',') + 1;
> > +	soc_id_end =3D strchr(match->compatible, '-');
> > +	size =3D soc_id_end - soc_id_start + 1;
> > +	if (size > 32)
> > +		size =3D sizeof(soc_id);
>=20
> I'd expect sizeof(soc_id) instead of 32... or maybe 32 in both places, or
> maybe const int max_size =3D 32, and then using it three times.
>
Agreed having `sizeof(soc_id)` would have made it future proof. I'll make t=
his
change upstream whenever I touch this file in future.

Cheers,
Prabhakar

