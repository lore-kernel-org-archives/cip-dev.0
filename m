Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F2C48291
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 10:31:15 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web10.60243.1707129069330101530
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 02:31:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=efXPGcw5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.96, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEYBI7JUa+sGgj7i/ybDjtFgtjEskHR4fI/hSKJQKYFs0nYzDyLKEwL/ezgiIhfFrhNjg5C/NKOzgZB1LhrVF6YsnYBCwB3CHPa61kthFl0AAMP5uHuDtKdKL7nJfHvxr1WyT7rYTLl3HBRw0KRb0B2DRvNQaoCGCxEGcLYaF1xxc6zweKUf+PFOZRGdV/d3uckYz/ilgbZAWpNHuSaG+UUgpbfRganydArfC8Am4IJzM+bzNsI9z07Eglt8jr/L8/bdpR4WGn6Uyr/vWlP9QHvkM4EqttgHJXDf/T3E5uUO/xRsxan5KeuSx3LOkaGCgD5o7Vy69jlisop/0UUp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xpa9JrRIm5kUVuA3DUA4mMBZqey3B6ZfoCBN9Jd8jc=;
 b=O7wkH58Nr21EVxWagmn3ESTpAaaxBcFEAsf2cTtQ76ke+WSZtIIQ98xwPg2KeK6opJUxQZ3/H5tpl4WKoUtFE+INxBqIoJWz5j3hq8YT9PJuay+SmIgD2yPNlw5gsaf0IgMfZ1/eiadZGEQD1n8ALsq1kSbl1Qe0Ku56V3yuTwl2bAuZUpodQARJqAzmZMmrrJVjxP7zh88UtLmfnkAITeP0YJmLGbMWmhDE9EB+2o5aFDD158ebr33J8otbU1rortqlzIjnRV9wmAfXawEU099dl5MfoM9YR5kED4H58QLY5iHLcwf/Gaj9I9kdddRuOqTv8zl6sVEkcTwCRmhyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xpa9JrRIm5kUVuA3DUA4mMBZqey3B6ZfoCBN9Jd8jc=;
 b=efXPGcw5pix+aEs+mUHYqYU1bVKZEu6TDf/F8OXOAMX6hVrH8eSnpra9DUj8lLGhDNESLAW3/RL7I4jX1xihsLl6YxQNYqddA+s1OBnVBBct9Ff9uRl2E23/Ml1CT8Yjapp/y0stYBKz8qVfqQYUWhbjSqa5Fo79tz1Y9QeYoD8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:31:04 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::deb5:2f61:e3a4:dd66%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:31:04 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: AQHaVDlhz35XwbGvJU+n7DaOll4U2LD7hwrwgAAI1gCAAALIoIAAAUaAgAAAUXA=
Date: Mon, 5 Feb 2024 10:31:04 +0000
Message-ID: 
 <OSZPR01MB701978D54B1903F070CBFA76AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZbowIA9sDtDExkBU@duo.ucw.cz>
 <OSZPR01MB70199E2D7FE8CF56D5536481AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <ZcC1HtNcQJ4dhXNX@duo.ucw.cz>
 <OSZPR01MB7019ED91EF71CADDE4476BB6AA472@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <ZcC4hRzi3Gv78bFq@duo.ucw.cz>
In-Reply-To: <ZcC4hRzi3Gv78bFq@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS3PR01MB10187:EE_
x-ms-office365-filtering-correlation-id: 6f4e8c52-4b96-4968-b821-08dc26358ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YPpmNXCatGkf5o4titsLmw9KU01oHCB5uuLjY7KAPlA0vjtuSGfaPGnNVBDZz5xgzX42v9IRitQicOgIFZLwjM4seDrEYPmK4F+TQeZGPfJDpWRvZcwnXYIsD0UHfHpC+4v+bgmqhVeQSkkD/nsXhBlWI36ssDKRgym0b7knb3DwDKsLjt4+OkEfZWJnK7YfPDanAhyxCXUFye1hbgq9yZsXScyr1rFD8I18z1osw24jxwS0ZRJvDZxGKrF5FfAsHbEaIahRjKdh7yeR0AJTkSb7mA6w3jkBKHbEJWdwJtkNn87+vKm0k8yN5khjdLLY0A1PLoGNStcJt8Uv19BbnJLFsQH97GEI1nX6o7LoJoLlfmg86Ldo98rpYnMMtZQAMmjQtZgMiZMELIeTo02Xg4nVisspBbxOqZvgkAOvWfnZ/fVUXpsLQ32cW/ZE0L+T7ocsrZKD/6D1pskDx5o5Ldil9VfEnv83MILRMvJj2ci+gwxVtXYhT5FIul5jxYDNnqsn/JL1guGX9ZT78QLeViVeEhy5G/MP4RhxY4Bf/R1gZz5mXNTQkbLzvW5Ys5hMSd46tzvwJky6nDsycFtl9kS4OGNr26Mw5VQmKcMtqzBtMu/AN5BpGn5lpIk7DAX2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(122000001)(5660300002)(38100700002)(4326008)(8936002)(66556008)(316002)(66476007)(66946007)(6916009)(8676002)(76116006)(64756008)(52536014)(66446008)(478600001)(54906003)(2906002)(26005)(107886003)(71200400001)(33656002)(53546011)(6506007)(7696005)(83380400001)(9686003)(38070700009)(41300700001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ywEhltjuz6DdPM9lYVaMZR1CaWboJTwiiwEsv8PJxr9mxEh3fL+bNq0D2t2P?=
 =?us-ascii?Q?j9lyZTIX+E1m+rmLeCNOjFu0tMijG6GAK2qpKzEoeKEc+OH2zUdduuZTBRlh?=
 =?us-ascii?Q?spe4ZugMcQ5Xj71xMdlPSccNeejQ/EZPBWhznxUpeB/GbKu+josIuau6oK2t?=
 =?us-ascii?Q?89c+32z4zrJDPvKEEAQUDOp/Qi2816CJceAYqzFhiZ0yi5Y8uAQUUpdxYszv?=
 =?us-ascii?Q?nezW5HqYmqsdvAAir22B1z737ZsZcahHoBdXGtWQAlIjm8YIqsVN6RkdFGpy?=
 =?us-ascii?Q?0WnPKvI+bT15Tu1abAnq1wdS7Idr7kWoh5jKsZzg8n+OiZ/u0o1SR0BziO2g?=
 =?us-ascii?Q?vgmZu177V6KMDYG0K6WiNj7Db8fPJmFoulfWt9E9XqVgUmC7zI+EeozdS5nY?=
 =?us-ascii?Q?mq49QElMmTYdCEO4f3N50V223W0sI0BrcgUuxHkv6KTQ7LgYgnEQdSk0uOkl?=
 =?us-ascii?Q?6t2gKV9hTV2blWPOJvfCbBUlz51kSPFvy1/9lj0ZP9clGlPrkS+xuefBsZPA?=
 =?us-ascii?Q?h/QkqdYcpIwP9OcdgQWBMZe72Bab3rxZO+dSHe5vCXeE/NFB3LzCA0KRminJ?=
 =?us-ascii?Q?Nnetf1g0fCkD9X/4cuOyWLgPADYhBm7W4zfp8+xTA9VUnnMyDCbOtBFucB8N?=
 =?us-ascii?Q?SC9wQvh+BDBOqQV2PXKDGLerB28rj1olaSmhubo8zLC6wAwutnLuz4ZHCzhh?=
 =?us-ascii?Q?iWZT3/TK1yWMew4Pv1w31u3RrOxg1Bwcp2ODYUriKwR1LzUF+7mrAGOQhabj?=
 =?us-ascii?Q?7B3xLzMHhShATBqRgUv3054/fw4xyU5Tyv5/BPm7aEyhrOcQOr7OlrpXpZWf?=
 =?us-ascii?Q?BAKGSUGhvUiz7x+O86qIvCGm/uQLg8qiWzUhq72eYQmIBVwifERyqvu1fuP3?=
 =?us-ascii?Q?4DsXWjKYM9fBawiY6LFpA3BYKPN9USj727BiA84IAgWnXt+MBvxPxuIahKB1?=
 =?us-ascii?Q?VvRrG5u6j2/VfgeS5FSznmbb/ECv6Hj6olnwyou1q3D4KxYnims7iO8ApozJ?=
 =?us-ascii?Q?IsY8XPIVWPd8wiDMStc/83yP7hUyD+WF5ezFO/o0EdlJbn/N5YJ2/rTXMmkF?=
 =?us-ascii?Q?6Tl5q/E240pGzCeMjiHBnEwwyhliwnfr955wCJba0ck9PE1qdXO+A00IUyxY?=
 =?us-ascii?Q?Is774Cx8yTwMRQt06b3CDusp6zAbOX19IfXkWvaS8CPnvh8LkQZGjHg1ASLm?=
 =?us-ascii?Q?FUq9UwEf7osW9dRB3EMIM2C992WzM0xEYxHmegfRVe9pktAHHsZ5U3GyiCDj?=
 =?us-ascii?Q?+XtsoPnkHgSw+p+rNQIn4C9zU7La26UpGWsv3ZbZX1R7NLgxF7xkcEltXiY/?=
 =?us-ascii?Q?0++hM+1V9uNhbwDvmsdJX9h4lWqs1HkJ8oBTfLWaWeGsZwOxRbUjwOCFaWJI?=
 =?us-ascii?Q?7S/YhCY7iuzRxEpACsj8+Ubxr7ozoF8F7bp3TY9gYGpFUgqOvAG8foxV9U6A?=
 =?us-ascii?Q?Y5wFbUma3wcKUO+JnYGLg1NlUGMm1I79q93B2viUMWw7/Pj8vwh23Ui4H0kg?=
 =?us-ascii?Q?LqvGzaq6Krd4vdTil5thwY9+CpK/JlHJeH5K01GUDITFLLZ3Du4GnyxN1oLj?=
 =?us-ascii?Q?3Ehuui2sDPoumUiQ9gq0AgwmIqzWtnCdeLDiHsEhVQRxo4un52vYk8shKcLU?=
 =?us-ascii?Q?sr9w9WSIVtFALXBfTMNEnwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e8c52-4b96-4968-b821-08dc26358ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 10:31:04.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiEWbHf0RVMhimBHeOd3rE7lV5Pd1dTeweTCYhXMDAl7tCv80tieOGEYw9E6gcW/j8OWTPQYvuwIUQ9pq+EQDfvqf0DbcQoD+0QOXfIRI+ngOFWlnWXNvyu/zMedkv3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 10:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14666

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, February 5, 2024 10:29 AM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Nobuhiro=
 Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 5.10.y-cip 00/39] Add support for Renesas RZ/Five=
 RISC-V SoC
>=20
> Hi!
> > > > > > This patch series aims to add support for Renesas RZ/Five
> > > > > > RISC-V SoC, support for this SoC has already been added to 6.1-=
cip kernel.
> > > > > >
> > > > > > Sending this series as an RFC as, 1] Support for Global DMA
> > > > > > cohernet pool is added 2] As support for non-coherent DMA is
> > > > > > missing for RISC-V core,
> > > > > >    required changes have been added directly in ax45mp_cache.c
> > > > > >    (ie patch #26)
> > > > > > 3] Patch #26 has been newly added, rest of the patches have bee=
n
> > > > > >    cherry-picked from upstream kernel.
> > > > >
> > > > > I quickly went through this, and found nothing too crazy. But as
> > > > > this adds whole new architecture into 5.10-cip, I guess I should
> > > > > get confirmation on the IRC. We'll also need to add this (and RIS=
C-V qemu) to 5.10 testing.
> > > > >
> > > > Now that we have agreed for RISC-V support on 5.10-cip, shall I sen=
d non RFC series?
> > >
> > > It will be same as RFC series, right? :-). So I guess no need to do
> > > that, I believe we can just review and apply this one.
> > >
> > There is one small change in patch #26 (keeping changes identical to up=
stream) and rest remains
> unchanged.
>=20
> Okay, so let's regenerate the series, and prepend the patches from the pr=
eparatory series as I did not
> apply them.
>=20
Sure will do that now.

Cheers,
Prabhakar

> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

