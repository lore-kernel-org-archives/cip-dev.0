Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FFC83037
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.100])
 by mx.groups.io with SMTP id smtpd.web09.20055.1650539901882294523
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:18:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=P2Y/c2uF;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.100,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJxHdpu5ZPIHTZMK/7G5M/jkKMqFp7asWa+Pi6LiZDbR4k4zYCHsEUwVT3uDBNBqGJktRVV8v5DfPhDW53+rt7cF1LavrtHCXpUTG7nfPCszMp3sr6VO6/PMv993NBb20Z9yNwyUDL/J3EY75EhPdqAf7sUbpRJV/z4nAnYxsDIuqXrVXBTei6c1hh2rInsUD5ZsPBrSgmzxP4ynckz8fiNBftf0k/U+ALVprZnrWDJgVj0nZCcUxlZkTmq7by/LUggFdKRvYal+AycRuUlEheEelY2ijV3ib8Adzf+Cl/JSQ/W6frsJLplruoMWGa3WJXOhAGgqws22DKAbx/hunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmD19gXySk2WWaUbAeKFXv+4PYCcozLUZjnUOtaZdIE=;
 b=Je4iUyhJrTz8ZTdij5U7m+/zzLl0Yj33gc+6q5XbVmATH8zGyC0fd0nvVhOeY8cRLsISUzUEQaGlIrTvz8RQI37PRofECjpeAIx+d1tcrOvP8pqqO0tC6l2clczhpML6ZyZcC6iEHhxbLT6DKdjtc/h3sykwwCg4f/01HJ0jPYhJfSkcaSt5pKl6NXm8FUnGdqRsjE9zUym/tqB7URjh6bXXLHGmNZXMTL2qqAakJPRhXEP0iH6yL9gdfHcjzgroWUq9JMEbKmEVXOWtsHxL3O09sul0utUpC7Ay2NrDzn5QQ/u4Z9TvnjfAXYzU6NlpblbtLnl2ocvcgRodc1dgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmD19gXySk2WWaUbAeKFXv+4PYCcozLUZjnUOtaZdIE=;
 b=P2Y/c2uFdcMVL1AsPj91DVUuqa7gVLnIKEdIRYKhpkLxhZ7oVgq3NLZrv1xnAmyf5Or00XkeIsJOkbAP4TAuIqVYY20QwtrA1rBr5WjEvfbkd8DBWZsiPwi50R7GSNJr8wv5VOhgXMWKEZHQofYpNW41R4B11u+PSoO5VbRoqVE=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY3PR01MB10140.jpnprd01.prod.outlook.com (2603:1096:400:1db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 11:18:17 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 11:18:17 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Topic: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
Thread-Index: AQHYVP55INr87SHk8Eu9cb5sTJuVsaz5ickwgACm+kCAAAPogIAABBBw
Date: Thu, 21 Apr 2022 11:18:17 +0000
Message-ID: 
 <OSZPR01MB70193945CAC69C71DE7C9F3DAAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYWPR01MB9420CAD2775ACC96157525E292F49@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019ED6926ED5A3D67B52E66AAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <20220421110244.GA9759@amd>
In-Reply-To: <20220421110244.GA9759@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5deba8e-68ab-48bd-ec5b-08da2388a2b2
x-ms-traffictypediagnostic: TY3PR01MB10140:EE_
x-microsoft-antispam-prvs: 
 <TY3PR01MB101403AB32CA035D69426C478AAF49@TY3PR01MB10140.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UfSr3mlhhZdz4qu/U6FqHiKVKxEZnvFXuSf8H05y6b+kYlpHQ6/1jM8SOMlWG/f9W2fXL0EtgBpze2hZFICZRJu99PYgnNO2JAxdC2WqvMf4iqhs/OMDdWQxP8j+xusdwRNZiG8XDQlSmm6WdNR9QqhRogo5Pa0kiw95mwr2mCoH2tPU5anJpbsGFcIfpxZQ0tOWtiFo4miapwGnFYcP9DnWIHCXTWpCOetVp7xmyGVpot70sd67187Wq0i1TGP3BhmD4huXwHoJC+CEosBG4Lfufp+VBEL7iybVK6Y9auNOlPT7nOwQFVsUUHk58gNG/IJz6zKNKzdRGsKWoYCfrzRyKmu9Rj7H595JJ1cz6bF7vD2na6HQkZ38n079vS2bHb/3n2WBlqDpKWQkQvQI5IcIigv0QbBwmbv3MohXhSswxW3IXvUhAe9U5eEuslJXVC9z5691pPZyfAsmGMeeLlThjk6wdfGf0mc9I1WhUYPoZp+jmQFD7mW9tMioqAh+41x8cGSFuTOsr2MXJwK+irpJ1Z7VadtlZKppcfGiEchxdphUJMlE51Mufz8btJIVSPNuMysdyYcw8txEXAWyioHZtvGYnLK6twLB5crtJwCwCv3fyYUZPHmXm1L8PhvEcBKwJ3v2qMPsw54kwi6eT6F3uvspyfrLnbesyxikWe06+AeyMgh+bl3O62vHzNLXJLrxcJkeyceTTkLjSlBiEw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(52536014)(122000001)(38100700002)(186003)(5660300002)(33656002)(55016003)(38070700005)(83380400001)(107886003)(508600001)(71200400001)(26005)(86362001)(9686003)(2906002)(8936002)(6506007)(53546011)(7696005)(6916009)(76116006)(64756008)(66476007)(8676002)(66446008)(66556008)(4326008)(66946007)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mMecKtWCh0k5nJ0hksya6Maa6Y9q7YtaLhr3J1N7+Bi8u3FgTdiaCvh6xEBe?=
 =?us-ascii?Q?OWf4fnYvD/lJ5hT3Y2MEmskT1u1dbezxea/ma+orgHdBhHd1noSHgzM48/gA?=
 =?us-ascii?Q?5EXdHXoGcuRoHw0DMvRpC1PkhtRhMT0pWL8sw9oXgKu4KeSyrRcUYU+38ZpA?=
 =?us-ascii?Q?cSWJ1e8LWn0DwLw06eO00g8+MjKtnE212dt8r2EL0Qe52XpwCTQXyyS5lCJN?=
 =?us-ascii?Q?7hn+OkiwKeW8KxtSPnEdX/5SCViIb9uh2RFCa9FSNcQsoUDVMZtaLLK3SQt1?=
 =?us-ascii?Q?iHFOOFm2sanHVlWjUiwLbOs8zmGzXkgfCd9M4hsM9loSjjQX2kTyLWnqOR8X?=
 =?us-ascii?Q?PHtjuPIkmj/tZm7u5KyQNcmOy9YvGVZ14/hCr9N3RHwxiWXhZze2oAACZvm9?=
 =?us-ascii?Q?RZbQCLFpmQop/buqwcAAwdPt9ySwQ48vGX3Pcp4eC5UEAflDG99p/OzAiacf?=
 =?us-ascii?Q?3FSL79UUsONchBuXNkKPJzvRcxXZb2SdClwQK2sPXy+KVQJh+QCIYGdVLIm+?=
 =?us-ascii?Q?6v/ASke1pwA7wl/VAUk7JzgeYr92HeHba4f8EAVsU/OKWXe9vKhvLSh1Gwqb?=
 =?us-ascii?Q?gjr0uWS7SSaT2Gn69ZPO//MMYHkHjjEe/1BKuICuXYRxdhPLXcQPvwY9ZbhS?=
 =?us-ascii?Q?i9vb1bVKNm3Gyv5YnWDGQXj1UkveOiZbEiKf2SmZrCZDE/PNIj9/vpMtfaT7?=
 =?us-ascii?Q?86PoFYbn+6cT62H8z0ekgxfnp+QM6e7c82QB0n3BC6nbNFwghqFWViL6Pep9?=
 =?us-ascii?Q?ZqLC1xLN4pdjDVUaFLYNJr5yMx+5ndW8f9YPOEpDExaDF8dhxBix3UPdwpqQ?=
 =?us-ascii?Q?USaeVCdlOqWayFguCPIEtdYlMxEvYawNlhKW0RWFbu3HVHoojsTizPwhLuDU?=
 =?us-ascii?Q?gwMo9zxo8cvy7ojAXNwfMnDVn6z9x15LfAclGu/MUCQNvC+2Mqnwe0GdnVgj?=
 =?us-ascii?Q?ONpvep4f2EHFOUsro/579CSlnNJj5XcFzWC3pvl+3jrflhb6Zmjz9U5FMNIJ?=
 =?us-ascii?Q?BBsy4oyLiZYWLFo+0UesuPlFyuMHETW7oXy2Vdt+E4ytfD7D3ZbHyI9QgFf0?=
 =?us-ascii?Q?wdrh9ReOwk/gcR4z+eFRuqBHoC0CzxXhhySchkHa8ec09hr1B01eQC42NH7F?=
 =?us-ascii?Q?GwGwb/52yt5Gs3HCnI1iTCl8D8McP9i+KVKuUB42YjoYYfDyiU8OXqa6W/xG?=
 =?us-ascii?Q?5EwJC2fiK2EuTWvFtUp7qikSOuZJTr2/LzrFkfDfo0ZdTqBko5gmh//DTTxN?=
 =?us-ascii?Q?swPXX0Zpj6dfeOUOxLRns1VgRa1k4TqF6otbe2x/kdVdgsAhpRaDMoOudkPX?=
 =?us-ascii?Q?fT5UNCNGX+KkMFjrcZ5qSEUvkqnNZYNfxb61UsQF2yzbINBjmF4UXkMOOCb/?=
 =?us-ascii?Q?ZpPow940YJ3yw83VaLHV1jxGJ3cQiznMPm8ydjPh88ksbbffakOLnvENhzM7?=
 =?us-ascii?Q?eDyNoMAnYBw8Z2MiSsEqYGCR48BuM5QCvDvVs1gwBlhgmHqBS3px2kY5xsLh?=
 =?us-ascii?Q?Doci0qo1NuY+7snIdyoYoQ3N84GqO8/fPSLd/4akQMRN19no8hbL4w0AkkGn?=
 =?us-ascii?Q?t1BVaJt++V10hkTfV0fSU205LeXSUJHyDi7Hhe/IdxjTR89pRdpu1CI/V4LU?=
 =?us-ascii?Q?DdGu51aowz3cPPLREEwKldtryNHWEQpdMMutJlIJxCsBfmKU77fvv1i3lJLy?=
 =?us-ascii?Q?hfIpLUelHm7jqYohQW2VTha/tYu/pAWVQpvKNGVTYVEBnsgv+VPSmeIShs3Y?=
 =?us-ascii?Q?IgClis9ctPl5rOa3vv6nI6DozjOe4C5HruFGUnABnjkLhAMh+1Fg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c5deba8e-68ab-48bd-ec5b-08da2388a2b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 11:18:17.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 z4vnjRZY4V8OPBoZpItkTQP9Gr5JHTeoSYvTnBwu8qSlp/wVSgQK6GiWRTCRkbZU2rWots5JdClTegi2Ml38flEQBxLtJGrhqaRkdrg8HZGBocLhDIOs5d3UoETB/rF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8163

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 April 2022 12:03
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: nobuhiro1.iwamatsu@toshiba.co.jp; cip-dev@lists.cip-project.org;
> pavel@denx.de; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 04/24] ASoC: sh: Add RZ/G2L SSIF-2 driver
>=20
> Hi!
>=20
> I guess there was two comments hidden in the quoted text. I'm not sure if
> you noticed them?
>=20
Thanks, I had missed them.

> Best regards,
> 								Pavel
>=20
> > > > +#define SSIFSR_TDC_MASK		0x3f
> > > > +#define SSIFSR_TDC_SHIFT	24
> > > > +#define SSIFSR_RDC_MASK		0x3f
> > > > +#define SSIFSR_RDC_SHIFT	8
> > > > +
> > > > +#define SSIFSR_TDC(x)		(((x) & 0x1f) << 24)
> > >
> > > This is not used.
> > > If you use it, you can use SSIFSR_TDC_SHIFT and SSIFSR_TDC_MASK.
> > >
Agreed.

> > > > +#define SSIFSR_TDE		BIT(16)
> > > > +#define SSIFSR_RDC(x)		(((x) & 0x1f) << 8)
> > >
> > > Same above.
>=20
Ditto.

Cheers,
Prabhakar

