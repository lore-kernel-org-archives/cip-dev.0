Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A415C9833B
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:13 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tY7tptk7;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWnEWX/ml2zw3i7CH8B1FK8xeFnVhUk5eR7XpEpdmKYXTQdBCit2hH+qSydJJGezOW1c+IeD+pxCmDCjhuV9W1TVAAer8w+gT/lGk53xi4u6hey53noUQfDcJhjDMEGOlXu7BRoLfF3iYkmsIGxH6huTNINSMVk4mgPk8wKd54FPOowi0uEQj/8WEp7QJZDj3KBKJ/x/Lf+8k64T4+QNdNdfqS3kBiOV4XlqH80S9tToGAqABS+oeNH7OH7koL1fvQaNKwiSjfZMmplTHhySNnBl5LPjAcqFzre/lYB83MqIkXbHluLl0jJmjuf2Mapz+tBq3j23dEA7fw5DpaITBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=QMsRxoFeJlRyHpew9AfaZ3a2m3aqEOSY+YN9e7YpsCsUiIc1AVOgmwq32j67UUgzXWNhWgw9mkB9F1CJonBxzAzNaQnzMag9jNLh8pgjnMxvK8hCXqtKcxxhDLrb+w+pbxmDbdZaXjt3g8qVa8jzm9EvrKAgefx58PO3Fkvd9kD32sXSUgptLdUcnSRbMMjAQ3id3MuCG0lGDJdc1n3he+Qmp9kauJ4uNPSk3wRd2+XaksxORsyM3jlmK0Hen/E3+ezCR78ajMQWKdqOdntiGn/dZbiB/9Lv6USGTI8mFt8E4YMZcraG4Sj0AOZhEAWu6+rHRhXuVpe/ZuYwRPRkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKFoT2KVo3LSlEjPzInawCz5F9gzs+Tqj/Ef8QDUpr8=;
 b=tY7tptk78ZI11AmVfbKjM+etxXfYpettykopaZGcRgkjfbfrxumxz12/ox3tpgcZeXAwhJvou1HRRB7ZiMzVf3jFX2bsp0mA1hN+cRcpgkx71jZ0zaI4OTXVXexXm+BvQWxMznND7sP06lcl4m6o9UfE4Hdp07FdskkdDZwiR28kGM3oSIopqI2Od2XrxbPICfPhQRrfMQIlD1OsIW53mdIy2nvKi0k1K+imVMYpRnTQ3170TV4xoROAYhIOnqAEviaeQCrE8UL6fazHXI6N8jPh79vDVVjcIFr7dmhGQJ7dDpcbAhvx1Uulxwoen/sid6+kyVBVbo65PAgO8vmnkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:05 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 12/14] Add kas file for hardening configuration
Date: Fri, 25 Sep 2026 20:08:38 +0200
Message-ID: <20260925180847.622090-13-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f084fc2-7147-4d28-e08b-08df1b3015ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ThhJNQgZv9cObOfzM+YUYu6eoC+5DlGWZEkKLW3hs0w5H/IPLFmbsGp1L/Q0IsA7TRKSnJlsh4IkT2gOib21K72LegzOWLQAEmmyQVyNooBHI3MxyGR7nSAX0Go0+P2e1t9+DMlJ7PNMn3WyEVm6HUmdTqvD4tLXPWkjxxGdbwZUEBUwofGfcokuY1Fl0Jn4HMs7wtWCzAGeU2kZjVUbrjS5jT2tS4/lWWHtsri1Ru9fb05tGDrqaLWq9BXtCRl/6NLVXy8NQLAcauiVElZLziTqokWSTEefCIgLuVlqD5QIsanG40X0KH58mW1VKgXMXidcxZ/EhEv1KZG0lPeVR433PD6V0QNBTy27tYT72FRbsZuKVsSLubRFZ8gswzovD/6ui0AuTfNC6bJghCNPe4bDY/RNNPCuuoEApPm+HT+0olkd/6S0qUQb10my2frkKMrheXnC1wmmKgfcdloR6Usd1me5n7t/CNYRGaKvIlYVJ+PyHTdp6ZMxcpf34w1zKmiSMknuJjb2yrjHtI4J0TA5vfBxsWe/4jqwMBkdT7Zqip8a6t3RWPu8B/Ssjgwaw4Lo+n/izqV4UUzdUPUxO4xlHFu9pk4B9XhhIMbStM92MbE2ExJC93HxlfOsLEK0UytDRevTsfsscNbWaP+98pXko0yHukUpIHR9gV2TieI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZcUHIWfmxsjm37CRRN/B5wq4jktPoTqFQz4x9qfLBvUxLtX+iV3kW4MVzj8v?=
 =?us-ascii?Q?K+JSsB9SnFggbSfXbTpdX4fWhg1hrAOE9tvFNrR2Z+fv6wHTUNA5JDQomUPk?=
 =?us-ascii?Q?0Cz4JIpSjU+izSauyYqB3a8xqczLU0CVJu6+pLg73jPDdh14eMNl9jUd8swm?=
 =?us-ascii?Q?aL1vpVP7l48UDH4FyYBaoEb/lCpzXoo5c8ud5Dza/fWzzbJcRC/F0zHnNyLL?=
 =?us-ascii?Q?8/zgsl8lPyJJ5hmGlFZIG2upHedVGh7Iylkx3APREcgOzGr+dH+DYB8ny+ND?=
 =?us-ascii?Q?kFC2HrUayoXli25inzvTbsFL0o2kKkN8G8fis0fCsDOtPUD644qyTfBRbUWX?=
 =?us-ascii?Q?GSi3490H4ibGBGK3I9WPJRltnDHomSzALEbrxguOtpFZbhKGfyq5UyhbXSpM?=
 =?us-ascii?Q?BsH1mb9ozPYouPI4cCCbXqGUMr/pSnOa0esYiujwY3k6P3YngxtZJJ47KQAq?=
 =?us-ascii?Q?BuFwATjpoq22zZmg0PEEYUkF1zuuZg/goAye2AtFyGJ7NAmXXC0frMDj3Ks8?=
 =?us-ascii?Q?E9hdgJUeX0f+yOQlyfZhRepsbkR01vaySxnSHzMjATT0E58FQqRZjtPTzA3m?=
 =?us-ascii?Q?snEDSpDfOgaE4z8Rms+10PHsFBhkFG7Sl94sWvf0hjNiwvDzak6UEcyjpyOy?=
 =?us-ascii?Q?DHBlC6SOKTbxGTzUUDIvRuBZjtvoMDFi4tvybyONFjCKkG/4o+GIAfBue7ZO?=
 =?us-ascii?Q?yyTMWFDBQ186EtCIQQd9nPs9is93q+WsdWnc/6odKnOITVfJshHDk3LmD2ZL?=
 =?us-ascii?Q?K6EzMB9IncopiGWYk1ToiPMDTia98+jp6+fmhwVYM+Vtuw2zTHrS20OBxPVR?=
 =?us-ascii?Q?aXqmNpzH1AqaDKBcnKSyykbqQ28v0RBBaIjqj0YvD9BYEpvOyjb5ObdXAYgp?=
 =?us-ascii?Q?cAoOpqipZj9QOzSBTtq6/oL8uLwW9jA1S3gFhl5wZBxJwObzQo5ixgDSzNAV?=
 =?us-ascii?Q?7FnhD0EZsUbYRtCOJLCm/H8PCosRGt4gm7p+p9IU2RjBirjIG2jOv8bAMO+h?=
 =?us-ascii?Q?5hz6+V8Svu2y27MgI//ZHsCtJiBxViuqzKIV965eDcG0cdM/4VJIk/wD/Xbh?=
 =?us-ascii?Q?gy1YCMXYAtQM69VH1N1t1RaqtIM9c9gVUnOMPC+RYWX9NE0WkDYA3R0KfEYE?=
 =?us-ascii?Q?+fcpTFgEDriFrMkTivqPMM3c7rhSDVCL/qXUMExNVRM1L8yn+CKtKxrjBmgN?=
 =?us-ascii?Q?JP+UCfTruoiPOB+zEVcsN3fasHQbuh1VHlUlADV3y1UTiOT/vIHu+HUrIWXI?=
 =?us-ascii?Q?vu3VrM6kID+KrW3f/btRU4+QaqN3YjDA9j3g4KYf1NictMKxrdzAvJzY9cQB?=
 =?us-ascii?Q?KLB03IM1smR8W9sjEHzqC/HeCX3qHZFHpTFfXalseUfLj+/LsaXoam6VbIfb?=
 =?us-ascii?Q?c8ZWX4eOZ78gukSVUjQvHPZqycz8MZRq1DzldOqlyTRsq5ZmG6M5X3pBA78i?=
 =?us-ascii?Q?mM9sRkYmIgzBBT5jbMTM5OlBEmov91VPZEsqCIHCTQHrqvuys4GVB+vg2FJe?=
 =?us-ascii?Q?tFe6eF6+a/W+eCjTDBJ07N4kO34EdCmA/jseHvfXiU0m2YEc6PeoQ1svvg4f?=
 =?us-ascii?Q?RXk2mwyJXr+e+wSt4DS9cYZ7yXiuRGITjFfqBkdB4BEvoK9VAqckSyAI/46O?=
 =?us-ascii?Q?byarCzaAgGx/UUIaI/24zrnK3mcqoHpvGBg4xKyl9Zjtx6ZcOCmYzNA13bki?=
 =?us-ascii?Q?if9Cym6n0sa5ztryRRUVeMt2mn4fjkSuigJIoAb7yV8pF4vCx+dZZSYBQRtv?=
 =?us-ascii?Q?OS0iNMN8kWCpijbAdt8A6CTBtXjdWUo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f084fc2-7147-4d28-e08b-08df1b3015ee
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:05.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t98obBY4QoCyaIbqO+OdDG9cm/K3d9Ytd4CNJtfZ3lxCQ37migII/TtTC6qVvN9Ag3JiRdQVj9eSNZZioqG78No5/htXzhnXAXkczaxEF1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24364

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Add kas/opt/cis-hardening.yml which sets CIP_CIS_HARDENING and
CIP_CIS_HARDENING_VALIDATION to enable the CIS hardening of the image
and its validation.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/cis-hardening.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 kas/opt/cis-hardening.yml

diff --git a/kas/opt/cis-hardening.yml b/kas/opt/cis-hardening.yml
new file mode 100644
index 00000000..0f157470
--- /dev/null
+++ b/kas/opt/cis-hardening.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  enable-hardening: |
+    CIP_CIS_HARDENING =3D "1"
+  enable-validation: |
+    CIP_CIS_HARDENING_VALIDATION =3D "1"
--=20
2.55.0


