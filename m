Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B14C5DF68
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:49 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=TB0myANc;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv63bv07L0JAyxK/6QCPLkbd8PnBQ0LydH6yNzZf352jYX6a3mrajTQOdMExau3Wb+6213Fe+LpGk63F/W+aJBgZnYu1Rl4+HIOlYvvpd+D8D2HJemrpvIBA7qdV3puXL0oN4Q0T2iTiRp8bFX7T9SsAyf1bzAVBlcnI+2Svot8m4kFZiLeybINLrf+YP0kh5F7cn+hCauiytjbRtOW/3iGpiOPSAWSjCj11Pw/QbriUWGrkkRiePeOhCPHl3/7PiTX6m3ex0Cwwyhidcmfgy8VE0cppAxTYSj/vYdDYDvBbaBn/Xoe4RpW3id0pvzClQG24BR/naDVNV/wVDuQ2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7HliivO561f+la8hVMZSwaAdEl0WZm/BhQLsAT/bkk=;
 b=VZZvWCeyIi1rYQlLtbhDAs4DAwH0D9OSlRdyEjQO9xYui9D9iMO4k2UBTQCPKYrcYs7kdBeZPGr5hffpa1keOxjN7TmW8RqK7B24DXRrqwrTCeXqpjQlEmkItFymloI2TgaS+VPLRFZu3I1tZ+Z5tRAEcMpup7J/lvPk1JNWUuGC4Z7ea6GK+Sl3mmBCcLFOhNaWBSaDhtL3oFy1aK6vVCGXAJCo0K2bsW/YeG68AN8x8efTckGAyBpQjKHLgrR7g5a9MLF7hoPxLrvdyS/iklVlV+7Klc17K1Rm7mX3qGLZMwarwSLcIVZDtosp1ptEjN84Vq+pluzOze8Tm+2HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7HliivO561f+la8hVMZSwaAdEl0WZm/BhQLsAT/bkk=;
 b=TB0myANcZdDeEhEcWkqPvk4NQTYiC9D5HpLQrL79lyAjoTa3UYDcBVUoXdIRqLlil09TES+Rkix5akgLi1se95sJ1abs90fcINeZkBcrJu3jD76Nqkvsw1MZ6uw1NjnFH2WnF5MagNmdI5hayE1p1vgKgdVNMcf9svOlhguQ03O3pJw/x1evFMV1/K8QqoqmWMHUXIqQpEutzI4loNYGDxRJgIURmND1JavNiC7rjFLEa9fFfLEHKUf2ubxRPf//1ANq2aao7DmOKTTdp76Z8SkntkdL46yLqWlmT52X0RRPlVyxc3W5fAQXia8t4Y1q+UDHtboigJBF9KMhKFrDZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:34 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:34 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 10/12] Integrate cis-hardening into cip-core-image
Date: Thu, 13 Aug 2026 12:39:00 +0200
Message-ID: <20260813103919.184402-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: f66b6042-e5b2-45c8-ba9e-08def9272a51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|55112099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	esMAs/Hw2ielHa6tUd99Ovv29OCt8isOfstMavs0w6CVqsg3ovlkynwOXCP7VIR2DYB0da4V5osklMGJ780xk9Zh8Nzg2cC7QSAeGqsiuBs14FX6Dr5lDcevK2t2BicHujtPnuurUhDapII3VV0yzxKJvVKdQF8qbDYOd3UvL6HJcDmsMIpldEvwvgSxyxWdC+JJ/3Hd/QtM/q2UChYtpIcvmnVaasybM8V8geBZ7Vip3v1OxATTxB1yYdyWegv2jeh9mwDcBGktoT7fjAwW/7OSAC13ju/5Gu0ODBsun5fcQP+A86XfDu1z81TouYbDOP66dlb38uHWUYxl/S/bdXITYGnyq3EzSBLetKPpUFFMMqc5qseXacLgmwM6cXztaLEUFJ+IHv1HqQcoUkD3jfsPDs/wjYLqrWjMHKR0qnGJuig0iwyhP1U5/OC9BBskyPaTX8Qnewh29M/J0dEQLc9Sxni1q8O+mtb5EKlP/1W6G9Ou31raJgxc1Gk95QIpgfsAyPm8yfX6O1wPQ03EiesGt1VpbrRcXah0PGuA6XqmTJgF351vIJumIZCw8sgYK4noUpiqa5jnPAXRMUDwKaZKbAAf+kBf78OquOH84EENGh7y8DhplezSs6nTNciPsId/cAbrP9dqHq9RG5ZY3vu3fYM4jJpHRYk7NikQkHI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hoVGMqHyzcIRN/Zo49krePXWE++7lTMXqGS9czP48+RrTL9Zjks8MU0M7XFv?=
 =?us-ascii?Q?PKO+rKpVQm2MjLyZ1JLDJsJ1qoGwZb50wU6/KrP0TgndXFXHjEliQZtHBp/m?=
 =?us-ascii?Q?p2ctIMHYGMRhD2VHPOv8sFf2RZJHM8/0hM1yaDvPaR73Cuh7OOux67U3GOun?=
 =?us-ascii?Q?gYGsTTEJiD0gT63QCiSmzmBCbMOJBazDjweLRfeu2GXcNKv8ypKbu9dCGTXH?=
 =?us-ascii?Q?6j9R9Koe4y1WT8gc81/jUmuCddlPGKgyq6Z22AtzwXucMNgn5V5XSEoxuqQK?=
 =?us-ascii?Q?muDDC4rRKb7LIi9WQfDw48zu3oHTEKzCTtk/KZ3CeuFE4KmulTqgZoGuoaLK?=
 =?us-ascii?Q?6oyN90UAR3yrQAuH8Zbe6Ix6YIpYXTVmNLKmoEDkk9XGhgK5RQgthqLMc+iY?=
 =?us-ascii?Q?3r+Q/ofkHYloGzZe833p2TYr16eQZC12aP3psnFt2yBbrKo8BRCa0xV9qW91?=
 =?us-ascii?Q?1canjJeUdqe2jzh7zu8czXBx+KeW0gd4M1pLXI+f93LvvTnk6POnpHCxV2H8?=
 =?us-ascii?Q?YzXoL3zuxEr820jepKBR+gqBUFnATfXrqYAj+no/biydvKqf0sQ9RivxExLK?=
 =?us-ascii?Q?GmYwvKdaxBF2hZTVFoiy1wt2SBCns8CJ/36LDcDcYBQma7EPD89BNXV4JOtW?=
 =?us-ascii?Q?xrlZWYNQ2DG7IltCTiigAZaIq6eA0Imh23rD6GJC9PQ72PQZIOUsFiDnzzmQ?=
 =?us-ascii?Q?2xW0JvoDKpEtIkMOrVLmFL/fgX7GMK1BNTiPuACbNst3BPNL+lTrp4yUwXUV?=
 =?us-ascii?Q?zfO69X/CBAm4s/6QmrFTq0i88Bqo9EbLgwTinRQ42fEbavL2fY9N9ooGpN7c?=
 =?us-ascii?Q?PYNZx4+O28lXtPneLHxbUdJAkeFCE/Wb3+SkQt61AlKtZtb/bYMDa1YtQ4In?=
 =?us-ascii?Q?jkHj6IqF4SabdUAx8zdqYlRcWeUGP54FcHkRgy2/eIi7pyEMUrkx8wivTVwN?=
 =?us-ascii?Q?24YYVOVRnWI32+doGsPd3lgVlcWUxE6Nv+DniJt+J4An0bAWmGEwLWJyTEDx?=
 =?us-ascii?Q?/wjAzM+ehrTOc7crcpSv4HKTO8aahNNRY/li+4TWyLrQxDfPBGnD5WHDBrBm?=
 =?us-ascii?Q?HjHZSU4JJlIXIBRgUxW2lyYGvJT080hkr/zx+9pZBoXwC5UHvQhHGghHKfj0?=
 =?us-ascii?Q?T4tOlgXHqbrM/GCm7Xl8dSVh6yBjDNmfz7oC5BDK5ykvtYG9Hj/pAFb8oq1E?=
 =?us-ascii?Q?/ArGeDylCdtGt53S+CjOulnb6KO3kRTK0Vfbj5sjySYJ9Egz5p0FFM65MWqJ?=
 =?us-ascii?Q?ri0Mi0TugI6NPg4tFp5ua50V5zIYSJpbL+Fm+9FcZ9hogYXroT0AC6HHBCDX?=
 =?us-ascii?Q?SLk6qwDYfYxkrPntbJCeEpoOiYhCdJfVADec0HHHD3gLm9IZv9QEL/WccWmM?=
 =?us-ascii?Q?sMtz36vk9KkJi2dwtnQDl0UXEUQV9v4c/QGkKcLZ6T6WL+H5Ij0jUo1Bl1jv?=
 =?us-ascii?Q?zy2e3aSGNjNZHorAcCf/TzE52P8Hr9OLe3U4aAqUgsqgY3y4v3+tnIn1yjCw?=
 =?us-ascii?Q?88y7oX89wy7O7EbUJo8SmR61rpffjFGtg1f813K01MBEyhf2s/df4ORx7RxY?=
 =?us-ascii?Q?+fEjoBveOE+1pf64gzEyAHkKPp1zN0za0n+PTnVtbYZqlR5sFlOIimYmPIUZ?=
 =?us-ascii?Q?qlxMRSMSpRVzB3IYM1UtJba8+8T0hxbOhWHewLRcLyWaeFqZUhcdEYF1s96V?=
 =?us-ascii?Q?Sky4Qrf2FWmC5jErPvan4rYQtTsJb41DQ1vR+66qure/oMv1C3x+8L/j4qNx?=
 =?us-ascii?Q?NYJJAjigP+AgAj7cPGp04RpM3kehPU4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66b6042-e5b2-45c8-ba9e-08def9272a51
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:34.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7+Qp4NfjApBXuGePt8KxCMBc+V873m5xhZLY7fICIAEvvBUtfCh4Tz+LRFH1nwNu8PyyQKUtSP0txPnOG1oiLNMt7t6XyeDEDANecB1UpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23925

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.inc    | 4 ++++
 recipes-kernel/linux/linux-cip-common.inc | 1 +
 2 files changed, 5 insertions(+)

diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd7..0bcaf094 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -10,7 +10,11 @@
 #
=20
 inherit image
+inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_=
HARDENING')) else ''}
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}
=20
 IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append =3D "${@' cip-cis-rules-config-${MACHINE}' if bb.util=
s.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+IMAGE_INSTALL:append =3D "${@' cis-validation' if bb.utils.to_boolean(d.ge=
tVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 65335238..25197910 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,6 +16,7 @@ inherit linux-kernel
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
 require recipes-kernel/linux/cip-kernel-config.inc
+require recipes-kernel/linux/kernel-hardening.inc
=20
 KERNEL_CONFIG_FRAGMENTS:append =3D "${@(' ' + d.getVar('RT_FRAGMENT')) if =
d.getVar('KERNEL_NAME') =3D=3D 'cip-rt' else ''}"
=20
--=20
2.55.0


