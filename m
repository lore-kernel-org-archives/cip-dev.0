Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FCDC5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:46:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31653.1786373165157295927
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 07:46:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=woRXzHnJ;
 spf=pass (domain: siemens.com, ip: 52.101.65.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFy3zgoreV/geWj2JhEh5TqK0IhMlK4ixhP/XsHpld7tbcMg/IEWlajvlMZZtRY+Qkhlk7MfZmfE/SViETlsQzn/nbR5BqS54vdfC8Zn84SGfPbzFCLYHS7fnWYHQpsUXiaQ6nlytBwALFimuddQLdkVPtHiGb5AdISxjbud1R/uzXrbIesnFCeIOQxk4+2Daotm2GUXrEwDBsNUq1lBdg70E/jP0uGPA9IpdvNZ2AS9yPgx6lROHLk7Ws5p33xn0/4EeFAHNGRAUwN2lyypyPObZ6lSSWEvpYlWEiMaHIsOhV7l5dS7TLvD07f/i6+YeMNt3ih/DqGLnFK1qf8RRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srkW0HwvpVALkn6hSGokPPn0J0PEDcgB3/1BuEJTV0k=;
 b=nm4ANPu+RwfAAe/XaOZ1hII9zOupUIYXgNmx18UdtubeC2URmE3tyMZsiTGogMTHJTjhFmz6S3dQz40li5pMHRlMJPC3fBKgo31aIBU4OJQyMdgCkLvHlIr+k904fODMOWHC4cu2P2sI1PCA3mqE9szluC/bh1vGNUauLBW7UgnVRxYAZVOJ911kO2FqyP7dk1/IDn/IC+IFt/tj5x2Sb/ieEjMXkUfDAuXF/bTN2UzTeK3Q+ZQa4ElHVsIrsTmm0CuNKB4g/J7IBjl97qEEaeZVmwEPXnwzLOmfOtwoXGyxP0c5MBpkLg+voA4iXxH+QiUdlTng3B9os96O0PeYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srkW0HwvpVALkn6hSGokPPn0J0PEDcgB3/1BuEJTV0k=;
 b=woRXzHnJDLDW3Cn5lVFGfCYbaRU5bQfnEqAgrJG5vxHBuuIbweS7jxQUuSdJMmxr4e6qY0ceWkfc7YzcpM/ww1XUUouD0gxZW9Bv7YlA6BIRj/hwzW1xUPz+xsAsBqxiXwU/1Mly+zhK8ygwllBHtr01HZjE/VjSp3gG0f0soO+MX2uD2l2yVwgFv9ek/30SOiOy5QXXOx+BKlp2Bn/yfVz4/SjBUJazRXYL+onDezFIBwiE6u29cdfxedxxu2eFAbsZ6RFQCY5hnvxCkt7nHSBAntBoegZQ7wzFKn6Ri9u3mpXf/92RQLvVzC7QC/fr8C7rVaos0iLhfwUGWWGx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:415::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:46:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:45:59 +0000
Message-ID: <c703b275-cd05-456a-8aa0-724dfee32911@siemens.com>
Date: Mon, 10 Aug 2026 16:45:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/2] Enable CI image build and test
 support for forky
To: Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
References: <20260728085519.3615499-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260728085519.3615499-3-Shivanand.Kunijadar@toshiba-tsip.com>
 <1fc13594-a7c6-421c-82fc-e8953bd07458@siemens.com>
 <1113502.1785299204099110509@lists.cip-project.org>
 <1187398.1785750444675558966@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1187398.1785750444675558966@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b2611b-24a2-4d5f-e905-08def6ee17ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|55112099003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Ctj+YgPSfBWhUa04ut1uVCy/tgRBSCGwRfzjDvLygcYQ6nqHqquLyi16UfxCxlH6+soz6q6j+vIJ9juDmixgCYMWbC0oO/kKKFT9QpvU46c4moIO3LetW2TNrCx++9YMbH+iH1i1wvPBdemtHKJu4QTRiQJkk8EBm1bgqxaBg30BMhNtm/mkRePv21XtolJfjLFasCQKvP3UD03xdK/mX9dM1rlWbrmY4actgDKLPQnkw/U/0jj0MiSzBCc0lk2kFZSjooY3muh1Ilgj93VbDlyV4IVeZsmsZG6U/7HcQq5LFIaV1LkfZjFkOKNaCq4TlYlEfroYNtWGRqlUY6pIDRXBbKjhOOCgaWO5Dh7p2AMi/LL5qMZ/vS8VqTzaiBln721AWjJLyO7eIB0NrjQ2W7RfMKH2KMvSL6gntuu43HHD5Lnbb8HWxqqDhahidn4PhS7HVXOdoWw23NFsFYguDCRuEXPFCt3yZKg7WA023xpMhjEoBfwJSsQd8xTRZf+KJBw1LRv/9HI0qOMC9KD7bGLLYywiq+Wu+ct0UfiOEGJJydyRuYuaj/ILe7dcjT9yL6Sn1BiD+PCybf4sXzufbwEkqKT8SCSmwrRBsSyfRehjut5LQANMKT8f3BwCqLZFh89BTxlZxk/LI5xFzAWUse9f2wicFoSpS6Oc7SpuWlg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vSGeGEvcfxEQk75IgTFUX/qyXnti7HJiGAj3CUiMW/NnAApMSSoWuq2U8Kkc?=
 =?us-ascii?Q?ibDstSu86io6QCP7m1/oCBLmXxUFtdr15vBg2tFMa9UvPr1xjAc8UXSjXTJT?=
 =?us-ascii?Q?Xwxa9PG2HEKQ4+t9XmO/oibZUEsaul7VopnRFceNkJ/z9/i4cBz8DpxwzF4y?=
 =?us-ascii?Q?qIrjh4+EvBq4jlFwgMLEI2yoIDF4+lvaN2auES2ZzCdXs2SZAH2rolyb1FiF?=
 =?us-ascii?Q?RVwe9xdMLShv1ZL3rv0Aonoq5NJU8NEOZ/a+e8mlzyV20O07lbOPWyvEo/iw?=
 =?us-ascii?Q?fH0LoLgTiDiFIM5oYT1R4dHe7m4NUTfBmpZY7EM4fSeV/qBjTo22S8Ndy4XD?=
 =?us-ascii?Q?/reDeU2iKoRk/2SG49lU4x/V2nKLR7mn4Ni2aMQCvxwJHHnszxjSqWrfRKBU?=
 =?us-ascii?Q?usrJA64VFWUCwXkQaFafEM76fp94OFuiyiBqinW56bHtMKQRuyYhFYyA/yCo?=
 =?us-ascii?Q?X+u2oSLMOKeKMNJA+r3hyVFAlnrkXjucvwgkxZ6bz8VcPOfKuPTf+iBonIx6?=
 =?us-ascii?Q?cuh/mDTufFwOxOYMSZi4F7cbK5vT4YRrElTbLQrkGo0MYdRBtjE8T9FR+zAo?=
 =?us-ascii?Q?JRN0MxcYSUveIed/1dkWXTmAPsoh1wtkmKOdQLEIOYtkspzCb1c6T/POvzi4?=
 =?us-ascii?Q?VTZJrlC9CesUUQWtMKqPJfgLgO3HPp4rB+lQQc8F8HfmhTLoq/x32bXYbPlr?=
 =?us-ascii?Q?iYA9NQs2X6HPGMq4X2MdSkWgMJJJms642sheMCzyzC83BFdvICadjvZToO8w?=
 =?us-ascii?Q?a2rnCLlPIuB6kBr5IltmJT/C1HgFioE7k1UEFlEaIQCRsnIphk8ZPH2QTHX3?=
 =?us-ascii?Q?rUYvnsMdkWhTZCn5++aGY95rP4jka/ddRHHsZuPs8cc8Wpcr9fYB151v59N3?=
 =?us-ascii?Q?KD70VRN7YUahQjdxWPKVJSPHg2pXe24l1k9uQomT4p9X64fqTOrdwWZToGee?=
 =?us-ascii?Q?GON83Yru9h8uR+Gyr/yXJTM8doURNzh5mN1i82NiGXSpVsrlMTQ/xXNWdWpl?=
 =?us-ascii?Q?OmS5DJ+5L/QjqMeJIkYb/uGnUfE0JzQz4SoMxI3Q0uLCu5+IAlnXOc/IhMVv?=
 =?us-ascii?Q?28jwV8EcPuxrpUuoQMwAHAAXqmy6n568gMTrnMjKDQazrtRjNyu6iBS4Ep0R?=
 =?us-ascii?Q?7xqRw4oh9unx3wPG6XTWRtwTu1yzBWmDV5e/QhsCWs6I5bOltEj/LwtbyN3q?=
 =?us-ascii?Q?xtX4tM9onFwXhd/bxsbZTjBtWbldhM0meqY/puWxV1w+TxYs3BKqReoIqSNB?=
 =?us-ascii?Q?3DgDGw6ZRdSUBvCkIY6yFxHIuxHhWZgRjAxbGA4ryUI9wzWdSIghLlEjJLkt?=
 =?us-ascii?Q?xiOlM6sZ0kIMy2msgs7yEtQsrWvtAuryC1df2LovKAYHNKhmqgDMgC8iQCjQ?=
 =?us-ascii?Q?2pWECBOMyof5zAxeiTjPlYp08XLm/F0fY8y+gqyMO0esZPLb2MVHKF2KPQaH?=
 =?us-ascii?Q?uhPtTvrDXi3GOpvfhdX52W0UbV4lbkD0QxxrBNWvua0tO++DqOryN2L2ELja?=
 =?us-ascii?Q?C6rXwj9UOYxmiT3a2IHwPyQh/Az6E9qu9BCHNyMm+5E2WPfmbMuAEjAS0XHh?=
 =?us-ascii?Q?xnpxLUzKz4SgtKGOPZPdERa9hbDEilWwSUIyjHsih8Eh2R60TtoA4IqA6epC?=
 =?us-ascii?Q?QKX5IcFslBjEI9hPuncZcPgDKLCviAVD9bvrMlyjccSq2J8p3vUyKxf79lk6?=
 =?us-ascii?Q?K+o+EEtDljoe67dr8SVyvAHoOeONX5MKNm1EcaS6DlwOO16MmvZnctB7umcF?=
 =?us-ascii?Q?w77e9VvYG2ytec+EBElZyOSr24rPdT4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b2611b-24a2-4d5f-e905-08def6ee17ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:45:59.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0QObA6e+vwA3HYIpjTNI2kKr0LWcQRMlZQY2GfHWpcyO8qztJc/BrYJvjdu1/XF/4lDcmApL4rTWsHm01aCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 14:46:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23887

On 03.08.26 11:47, Kunijadar Shivanand wrote:
> Hi Jan,=C2=A0
> =C2=A0
> On Tue, Jul 28, 2026 at 09:26 PM, Kunijadar Shivanand wrote:
>=20
>     On Tue, Jul 28, 2026 at 08:29 AM, Jan Kiszka wrote:
>=20
>         On 28.07.26 10:55, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>             From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.c=
om>
>=20
>             Keep these jobs as scheduled and can be scheduled to run
>             every week
>             just to monitor and fix if there are any issues.
>             Also set allow_failure:true for these jobs as forky is not
>             officially
>             released and there will always be some build & test issues.
>=20
>             It includes SWUpdate, secure boot & RB tests.
>=20
>             Signed-off-by: Shivanand Kunijadar
>             <Shivanand.Kunijadar@toshiba-tsip.com>
>             ---
>             .gitlab-ci.yml | 148 +++++++++++++++++++++++++++++++++++++
>             .reproducible-check-ci.yml | 72 ++++++++++++++++++
>             2 files changed, 220 insertions(+)
>=20
>             diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>             index b53def4..b15c5da 100644
>             --- a/.gitlab-ci.yml
>             +++ b/.gitlab-ci.yml
>             @@ -8,6 +8,7 @@
>             # Jan Kiszka <jan.kiszka@siemens.com>
>             # Quirin Gylstorff <quirin.gylstorff@siemens.com>
>             # Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>             +# Shivanand Kunijadar <shivanand.kunijadar@toshiba-tsip.com>
>             #
>             # SPDX-License-Identifier: MIT
>             #
>             @@ -63,6 +64,7 @@ default:
>             - if [ "${release}" =3D "bullseye" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>             - if [ "${release}" =3D "bookworm" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>             - if [ "${release}" =3D "trixie" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/trixie.yml"; fi
>             + - if [ "${release}" =3D "forky" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/forky.yml"; fi
>             - if [ "${release}" =3D "sid" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/sid.yml"; fi
>             - if [ "${encrypt}" =3D "enable" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/encrypt-data.yml"; fi
>             - if [ "${factory_reset}" =3D "enable" ]; then
>             base_yaml=3D"${base_yaml}:kas/opt/factory-reset.yml"; fi
>             @@ -399,6 +401,57 @@ build:qemu-arm-base-sid:
>             separate_home_partition: enable
>             deploy: enable
>=20
>             +# forky image builds
>             +.build_base_forky:
>             + extends:
>             + - .build_base
>             + rules:
>             + - if: $CI_COMMIT_TAG
>             + when: never
>             + - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNS=
TABLE'
>=20
>         I meant we should migrate both forky and sid under this one
>         CI_RUN_UNSTABLE variable. Now we would still have two of them
>         and would
>         need to set them both in the pipeline schedule.
>=20
>     My idea was as below,=C2=A0
>=20
>     - The CI variable CI_RUN_UNSTABLE_FORKY is changed to CI_RUN_UNSTABLE=
,
>=20
>     =C2=A0 however CI_RUN_UNSTABLE_SID is not changed in this patch serie=
s, will
>=20
>     =C2=A0 update in a separate patch as it is not related to this series=
.
>=20
>     =C2=A0
>=20
>     And it was mentioned in the v2 patch series cover letter, I think
>     you would have missed that.=C2=A0
>=20
>     let me know if required I will change CI_RUN_UNSTABLE_SID to
>     CI_RUN_UNSTABLE in this series only.
>=20
>     =C2=A0
>=20
> Any comments on this? Shall i include the above change in this patch
> series?=C2=A0
>=20
> please let me know, will send v3 patch series accordingly.=C2=A0
>=20

Please rename CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE before introducing
forky as another user. Will easy to pipeline maintenance.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

