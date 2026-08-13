Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B66C5AC67
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 04:29:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12264.1786595381586450982
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Aug 2026 21:29:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=a+hQUZkg;
 spf=pass (domain: siemens.com, ip: 40.107.130.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1tdiKTq2lFL3O41GpzACkh0PaF/NkM5472qMacEBTs6oExZrsJeZoDR/fZC/HTnc/i8ngkIgOKw7oCZ6/B6fFpq6wUHMTmZszx5eZgk1MYEm5sjvVuQELXJEWBigMtBWhGQv40soYUJx8+7vXG/trl+6S0xHseTlfDEBb86YlshRfh3eu5O7fu/4jNdBzC/c/4kALhY5Ta6WORLMLXelcW/JVhA1ywvqpNs7JXzH60dbXv8VViZChLiK6bp9QNf/RaQ2F+MGjqgwgCrar2u/+CBCS0OfkzWF/wzYCMEolC7Rsqs6uuyYlGcAEeLYNfsWN19JOuC0yw2l6PZqx852g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/1SaL9nVLkO2p5k4ipVbxsT29GOdBozWIJdt95+Mzw=;
 b=Jt9QTu0eUduNmdBNKw8w+IwjnZHJfqfR2nLnE5J1khpZOUrNiRZBsVezF2/XnJ1+YrlHQlO9cQavUM3Jq3Q9GWP+v1OZWxbZvLyUNHmOABHExAlPAUN+sbZLZpk26kPvmkWPUHiEZwMAAPrusbuT/tnI0DCelsb58GgtiLkQBuU6Hbsk/tkDsrqWjtuYFspCtrn8JrK7/PJZH7bMtpT4fucKO6E14GRV789IxwSaUdaeEFho3Tt8HZjM/ntK3uZCT8qB91WMHoL3JD+2ujsN2U8vV1v+0Wz4+IAfJSwWegxpkqvOI7jUSeXa10nsWsXtNCaH4mhcFiQqAW2abaJRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/1SaL9nVLkO2p5k4ipVbxsT29GOdBozWIJdt95+Mzw=;
 b=a+hQUZkgIHMfSsABsNY7rATeFFyeEYrV4iwSpPaPWBkbOnqWS1o9y91n2YlmOD71rT0mNccbYUd9j9c3BvdMHZdkdNqHCv22s+ex1vbUCaeJsUh06jULOu31EvuGXwi6PVLKyzywKm5ns5Tl91vMzIUYGFPD4jqpIJlfmAMYJQONMcjTjilyHYCC0FaPsfbRRKW679ysV4Xqllb0ZEcqdaFCs9vM/t9CApd0AxuZ+BYn4HQf+AdhY/rYlShvF44mQyWks73gl2f7MgWu+FZzcyEDCdJ/7fL+QVk/3OIYWTaV6vLFAdN1lBmMO+1i5ZVWO1LJuI/84fKh08jdasjL+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 04:29:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 04:29:36 +0000
Message-ID: <f9c0719e-1531-4795-ac75-37bda8567f66@siemens.com>
Date: Thu, 13 Aug 2026 06:29:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/3] Enable debian forky build & test
 support
To: Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
References: <20260811090421.3547180-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <c8b01319-b1a0-4d43-9707-b12acb2ff19f@siemens.com>
 <1473907.1786515447555873268@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1473907.1786515447555873268@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 964a8c84-d41c-4e3e-f3d1-08def8f37b0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|55112099003|56012099006|11063799006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Yc6HxdF0kkDP/f5BCDDox4t1GSTxu0A07JvbFh/CRu0YM7DRQVgnRtH8ojgaPogeSCrlojQmo73HJCFevnH6L/Jbtvvg1S6MrDeoGxCl1OFFAs3pmH3F+QSMhHXOgFfqU5+1qRV+dIj1LiAD1j5aoDrYW0de6EBziKi1ry5aOfW7gaAXZXy1QS6QGWpThVp+7TAr/ZvR6nuKt+ywOYdG8lw0whlPUT60BbCD5cTexp7jV5QZvUGeaaz35P+t1pbYOY6jFlhwV/SAZHpcJrvWsrvCMOeSxaQ5Zm9DpksJAWlQzYmSQYizJKR1VKQergcOJukCzh0do9v0sUOq+fvTR+IAqwSQpVOmV6tnhDf4ijVuyXeG/ceLrz2pDU/vGtNcHs4jPFObARuHVsfVRVBZ8GUuDjPaxf+ehdPzAZaBbba42Sa7P9c1tieIVxKavBTNB99z2BxcNTus1rcj6FwfsxOcElNBZK8IRHgq/GV4sNfKWuGwoPFppgVywzvpwPpf5+TxqgUqB1D/UtU0M2DN473SCYQ0yft/jPK4H6cPf7i2uVl7g6MJT4ZxzvA49dw5fsewAJOLDOFiQg6tvE0nJYXII6VaIVz5uUv1TNCWGdbJRKysWWUEjPShZ4TrHCRJGgrWvu5jc9RfsyVGNlcrdNMthue5GDX4omiXj9FIq3g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?irShIReXjKVwfvPMY9Ov/ZH6Q/cXa8bSy0A2vfkhSFtNK7wmnZAqI4D+2l0q?=
 =?us-ascii?Q?LtruY2zXY5ONy2YGz5vbIMSSkksAktr81NG/dgZ9DZcoSSkWT9L5u3oJnatY?=
 =?us-ascii?Q?K5tr1wxl0cx/YJXHM3sokRIX0GR+Dd7b96cQ50UD2rCZW+Qbkvr+7fTQFPkV?=
 =?us-ascii?Q?ghi4BSq7hyMGoIlIbbFl6p0ryR/+rCobp2aWLMxCHOn2VtDc3ZJ2TD1xQatn?=
 =?us-ascii?Q?WAL2nvgVhfFCm6hHORYyOrTWs36fqwZnzPZofWlm+Gxt2sAgzHkw3JB0FJnK?=
 =?us-ascii?Q?iVnbQ3VW4A9zHbh/DIezNfMSTb6PXwq4kMmeKEl7gkoUGHql4yzq9Fz04UM9?=
 =?us-ascii?Q?lXwXt/1JhMWawo5EZpmNKnBvrwt1vH/8oC8RlKM6b8qoPafLUgFLK8mb5jAV?=
 =?us-ascii?Q?QMeBCWfPFBVPA0Hyy4JQycLzhhAxMMprO2lpfrYsKl1KXGlxDHjjMql+QjWY?=
 =?us-ascii?Q?cxfbuN0/CShOXaC7fMQH2MH7k3HUh8l2p4hIlC6i2oiS8FLbZ1KXWL5AAXV+?=
 =?us-ascii?Q?B9Et6MlMS7RLScXN7UbQBJ9ZCwHwQ9Z4l9uNwxjGGpberVsmKaR0XVa/AtHp?=
 =?us-ascii?Q?9VTbQqkc4wqRthp94okTvL/kXmxRIiiKdyss6O2bYPP0dNjRGoGuuZFbkgxp?=
 =?us-ascii?Q?V6He9MV8cGNrY+Idmqnrp8zO7cix+BAzshcxU8sL+SiagJfSNLKOsSsS8y+0?=
 =?us-ascii?Q?M5eB1ViEyCi3cgne1UWAiALWRtG93OsDOSr7BljmCCXEPI/wb8gqrweuVdD6?=
 =?us-ascii?Q?Gv9K6UxVCk3Y8vUgxGEcmMySX4DUD2pZ+y72rZQU+6ET+PWroX0Rwnuz40Mu?=
 =?us-ascii?Q?os7mrClzKqYU1/cxkcK9zlhxzMRxqKLnY85L8B74tukA6GvUSfE758Bdaczh?=
 =?us-ascii?Q?FF44ksO1VLKEqLZBWWfiVaNL4U0eobjMpfD20L8u2oTHk0Rd2EVAVbefKsZh?=
 =?us-ascii?Q?HelcsDuAFj/dAbv+lZqC/F94Z3Cuxp0AMlIhlGiqCKPmjBtGny6Wif30segU?=
 =?us-ascii?Q?vQoE8Wt4ONsLpVhMNh1IfKTMo6k1+HR1JvC8dojPZJldPMVnFq27C+dl4wHp?=
 =?us-ascii?Q?5OvHFzRu9ltiu8S0MM6VUe5bd7Wb3y7oSnJu3KZyi3X79J0ELW9ApUGg1F5g?=
 =?us-ascii?Q?haXEbYYpUEiiozbb/S7AF023hQh8jiqNDCjQdol5Q1Lcs4Teup6jEoWuNTiB?=
 =?us-ascii?Q?ves3Y1DZ5NPgyfUqKL6y3ZsjdIWg6zsMJbBobBGmm5y2Ii9QzeniifePdyHD?=
 =?us-ascii?Q?U4mhkyXQKALTaVTQjbPgPr0XDNhVHLzyZb97b1yPv75bINECRPI3WIJmZNzr?=
 =?us-ascii?Q?2JKFiUXlQ8pB5CjU1/1KXT5T53/CE61Ea8h2brsHJTHJ/A0wKdZQpwj5rrSv?=
 =?us-ascii?Q?YBaqs/CplShfLLD6hAkwmUxDpr+FUzLGXe2BIChOVWovO/bBkBg/QKnxfBQF?=
 =?us-ascii?Q?6AG90GDB+C7XI8VK0pNCHbexvoXw8Img1ByWeUsVDcz7TSmdygaz2XvLDUHp?=
 =?us-ascii?Q?uVVVBLbMiVtRddNKyOEGdWa8KXdHXbqyzvS/VhDnMUsxnsL6lJVMzuwth18M?=
 =?us-ascii?Q?0h4OyZclOzb4P7Mn+hB4tYBwOsNlQv1ReI8esRIoJDOP3k22I9laUvXHjSFQ?=
 =?us-ascii?Q?DRlblLBAPHlWFRc0I8iczy5FZnFgsFdMLwj3FaZJz4IUFL9dbyfJ6b9bx/zQ?=
 =?us-ascii?Q?UvYdBbZgKkcgSe3Cpm71H/jn9sfJ4bc9hW91q1/H8QYWrOHPXlSk34SCyhcN?=
 =?us-ascii?Q?q6ePW9lOBw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964a8c84-d41c-4e3e-f3d1-08def8f37b0c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 04:29:36.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuxK58UEhI8xHVFNYFRH2WmxuWDimINT0LUFOKoHwOXECJZtdk2h7lb31uxbQnyY8mtmlghHaHk9KumUbpD/7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 04:29:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23907

On 12.08.26 08:17, Kunijadar Shivanand wrote:
> On Tue, Aug 11, 2026 at 10:09 AM, Jan Kiszka wrote:
>=20
>     On 11.08.26 11:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>=20
>         From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
>         This patch series adds the debian forky based image build & CI
>         test support.
>=20
>         It enables SWUpdate, secure boot, security tests in LAVA and RB
>         in gitlab CI.
>=20
>         NOTE:
>         - The existing .reproducible-check-ci.yml is updated to support
>         forky
>         images reproducibility check. No need to add the exta scheduled
>         pipeline
>         for forky, the current scheduled pipeline covers both trixie and
>         forky. The forky builds and RB tests are kept with allowed failur=
e
>         option as true.
>         - Updated authors list for .gitlab-ci.yml & .reproducible-check-
>         ci.yml
>=20
>         Shivanand Kunijadar (3):
>         .gitlab-cip.yml: Change CI variable to CI_RUN_UNSTABLE
>         Enable the support of Debian forky based builds
>         Enable CI image build and test support for forky
>=20
>         .gitlab-ci.yml | 152 +++++++++++++++++-
>         .reproducible-check-ci.yml | 72 +++++++++
>         Kconfig | 4 +
>         conf/distro/cip-core-forky.conf | 13 ++
>         kas/opt/forky.yml | 15 ++
>         .../files/forky/PkKek-1-snakeoil.key | 30 ++++
>         .../files/forky/PkKek-1-snakeoil.pem | 23 +++
>         .../swupdate-certificates/files/forky | 1 +
>         start-qemu.sh | 2 +
>         9 files changed, 310 insertions(+), 2 deletions(-)
>         create mode 100644 conf/distro/cip-core-forky.conf
>         create mode 100644 kas/opt/forky.yml
>         create mode 100644 recipes-devtools/secure-boot-secrets/files/
>         forky/PkKek-1-snakeoil.key
>         create mode 100644 recipes-devtools/secure-boot-secrets/files/
>         forky/PkKek-1-snakeoil.pem
>         create mode 120000 recipes-devtools/swupdate-certificates/files/
>         forky
>=20
>     Thanks, applied.
>=20
> Thank you.=C2=A0
> =C2=A0
> You may need to update CI variable in pipeline schedules=C2=A0 if not upd=
ated.=C2=A0
> please change CI_RUN_UNSTABLE_SID to CI_RUN_UNSTABLE which triggers both
> forky & sid jobs.=C2=A0
> =C2=A0
> Also change the name "Weekly Debian sid & testing builds & checks" to
> include forky as well.
> =C2=A0

I had adjusted that already. And "testing" was chosen for keeping its
name stable across the forky->duke->xxx migrations.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

