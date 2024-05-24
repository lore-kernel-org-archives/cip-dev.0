Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C82C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 10:50:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web10.12981.1716547842825744523
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 May 2024 03:50:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C4NJFcRF;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqlKSxCPiXONNt13sBsn3fmQJh5DomREXwaYvoACntNyRyIcxACBCM5Z/gxhOhucu+94HTR1329wtr6QNMOt2gQHgZI4+7fD7s++1e9/xivR4YTehlq8sVJPuBnKAhkIfbkEAAOAZz/iBC+0Geb1Qqo4eB4SJpgMo4+u5SK3dLJZYxaoZuZAMmM3EQortTf3ryDn7L2AL0xh/qp3u4/6VvStFo2YxQ4K38usyya1cq75+bx+FF1PHXUxNjjNrFq7n8Mu2cVNVWYpk2k+Cajls9ys3Tul55u9rp0C1ci8ugYQ06J9kKZD+bL0nYIE4hdWq8c+U0qjMj9x8lZ8Zmzd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONCoRDdzn46YKMvLM6n+4VicmCk40DEq7vIeiBXZR6w=;
 b=K0r0IqXz9ui7GbkRAssf5aolG4b9E0dNhhlH6Z8W4MR7pxZqkchXCWEdu3hY0Cbu4zsfH71mWziLGqsR869n82J6wfaIRswlUNYql2O6p0aptx177OeBooUbln2LCu8R76r2FV2TKxSYM0XM4sPMLCnIALD060EeaIo7d/D1vPdP13ihzg6uX8UiHzIUbzKUDlpqurIdAKjput6bS3iDZBxSzllyD+AAxeIfKYdtB/wq8jVLuBYn66uT1AcIe6VNE9UkwtQHv3zpIW4FL9krchRYBorry14oPa9GpKtX23yc5UNygQwbMXBTd+k9vDjbMPr1W0pZbV3Le1qjKNwAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONCoRDdzn46YKMvLM6n+4VicmCk40DEq7vIeiBXZR6w=;
 b=C4NJFcRFULg4Yvm0pbP0wSesRrw9YtYJlGgn9knaq5vcaqe1ndqgKhdp408ljWv5nyKtFAe3OvNjD+oh1TJrPPOquq9U5aOcz1HPJJf3NudAFfk8f2h52iWVmKaM1S69Ha70UgeK9IrYH2TseuJpZCeiuqnDvaLe4/3BGP/TbrH3expYRl8lZTVcHdfuPunSJk6kxNkFepYS1NxBr8xeJCCWnXNdb7avrl37SMuqgFj2oNE1Ht1ZueniJh1a+eHJ/9Kg9vm5ehyfW6RRXVzj/EEe050KEUyGxBR8/UY9JLVbRwhQ0r9cUSJBNrQ55c/IR/XrHYcWe/l6JP0ZA1wiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7547.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 10:50:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 10:50:38 +0000
Message-ID: <be7c406d-ee6c-4270-b9d7-52b6f24078c2@siemens.com>
Date: Fri, 24 May 2024 12:50:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] linux-cip: Switch x86 targets to new
 cip_merged_defconfig
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e91dc2-c203-490f-1c15-08dc7bdf5917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjVHSG8xMkhLMTl3QUswdm0vVlpsWW10ci9LTGFpNTVUM01nUXc5eDdGb21Z?=
 =?utf-8?B?MmdldlQ1QUFHL0tDa3M3cE1WM2ZMWDhBR2NKaGNlV2VJRUZhb2VkUFAyQ3pW?=
 =?utf-8?B?dGJKcE5hV2ZIOW5SUWRZa2F6OG9tRWppTXdhbFBQaUF1MnVDeHlkbWFvbUNI?=
 =?utf-8?B?VllsNmVmS2hnTGtJZDhsR3pkRUtyU0tpNkJKNmF4cVhzcWdFOEZoUk11VDBT?=
 =?utf-8?B?NkpSZi9ab3pBempDR1YvQkh1SWdwUlptSzhUcnk2WWpLQ2RST2JiT3RRWUIz?=
 =?utf-8?B?bEQ4OTNnZUNQdUQ0RFNubWpEQWpLd2JsRm92ZW5tTFVRaHBsZ3dZMjlnVlFp?=
 =?utf-8?B?T29vUjJzdXVLM0VOcTFpWnZEbEpXNlZuV0k5UWhkSFJ2RlhlaysrWlU0ODNM?=
 =?utf-8?B?cGhGZFArZk0xWnhPQ0lZVHBnN2d6RCttM3ZFOUxHajZDQitreFF2N2diWHV2?=
 =?utf-8?B?ZlB2UThrekxkTlBzT3VzSUdzNGF3SU5WVXlqZC9IUkJ4Rk9nMHBSbSt5L2gw?=
 =?utf-8?B?QXN5ekFqWENiYWNzTWtVbUVZRjRVUGZ6bVl0Rmx4VkRVTUNpK0txbFdwZnVG?=
 =?utf-8?B?Q2Q5bVBib0QzSVhaYWI4bTh2dmJKYXNSdTl2MVZZbUdzWEp1andFcjM3SWI1?=
 =?utf-8?B?RE5zdk5pWU1xYnNsRy9zWTExMmxXZ3RyOUZ0YVh2a3dPSjFxM0NWeUpFYkhJ?=
 =?utf-8?B?dkRIb2wwY1hhYXFydGVuS1RlNUtMdXFkaERGZE9QcU5pdU8zMGN3T2dFYUd0?=
 =?utf-8?B?YW9sU3lJTWxMTkJZRGoxeHlDSVp3dG4vTHl0YWJkeGVsWEZLUGJqYzdBbjNF?=
 =?utf-8?B?bElZNFZGS3NwMVBSU0NjZUxkSGU3aTRQeU9QWDJqOTZ3L1BWMFluZmZMQzcw?=
 =?utf-8?B?Vlg5NEhlSnVib2VvblVsbEtOOU9BTHpJUERwZ21IbDlDeWxQNFE3NFo4Q1Bq?=
 =?utf-8?B?VEd0L2h3Z0Zxd09RWktKd3Z6U0FCQ3lmd2pOWTlGNnBQdUdLOTNEeHYyU09N?=
 =?utf-8?B?cWRtNUtwSy9ERDc0ZzhqQ3VUNkxzRytDRHlSbHNHRjF1UVkzcHpHeGtDRDFC?=
 =?utf-8?B?ZnVDRUxCVXRVUXl1UTdXN0o1aEVCSzRNdFNMVUY5VXhnS29sQkh2OHlURHNM?=
 =?utf-8?B?SUdHcmVTREJITTlIcklVVmxKZmJ5YWc1b2FZbTNwVDA1VFdIYjEvbS9WalNC?=
 =?utf-8?B?N0x3VUEyaXpZUS9DZkNXaWVaZ1d5d1F3SEp2VGJBWktqeEJqYzRJOEhGWEdZ?=
 =?utf-8?B?RXJDTDN6VW1TTElTYno1dGJWUE91dkVVMEI1OGxLaXZNTFB6T3ZUR3JEZnF3?=
 =?utf-8?B?bnV4UWpqMWVNTW1ETFNXSU9SVDA0RHJ5MFRSZEFzR3dSUm9iMTVadStDSVZZ?=
 =?utf-8?B?OUlrZTF6blRwbWdkQ01MMWdJYnBLQWF4S3c1NUIvdVpHMmJ4QjhpOUxIeVpm?=
 =?utf-8?B?ZnVxaTlhYzFwRkxzMDR0UFJHNW9qYzZTTTEwcnNBWnhFditaVGFUN1lZTldp?=
 =?utf-8?B?MFZ0UVE4UzFkZkFyS0luaDdhaE8rOTQ4dHBQTGU0Q3F0Y3ZIOFNNZitZR3V3?=
 =?utf-8?B?VnlNbG00VDJwZzlOM2lNeitxS3lzUFRRT2M3czRwQkhuT1B5UUp0T3p1NUlI?=
 =?utf-8?B?dHYxZmVDNTIzOXZqcVRVL0w5ZGY0REhrUHVGRXVMUEpFdmVRVjVFeFc4aW1X?=
 =?utf-8?B?NEpYTm5zZUxJZ1g3d1JSYk84TnVaQUJsMnZZUkJCcDJ3RGVzM05EZlZnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHkrVTZWbnJpYVFBMkhSaXdCZWF2Q3phNDRHNXdLWjFVNmh6cXFqdWJKRC9H?=
 =?utf-8?B?UE9PV3dvZFAwSGlhMWJTSnlPV3ZGVVVxdWVhUk9aN2xlY3Jyd3I4a052VjZn?=
 =?utf-8?B?eXdtQ3dSaVJmeVZpRkpNZVJYbHdyeDVqeEljMkJuMUwwYnR6MlppNXV0WUNn?=
 =?utf-8?B?clVlWjJuNnVmSzV5RGRaU1Z1RkZSTGdUZ0dkTVVBdTgwUEVjME5WcUl4SUZw?=
 =?utf-8?B?aUY3T1JSYmxBSWlDUXJHa2kwUTlVQlAxek1nQ0g4ZVhOUjd0WGpxTDRHdkZr?=
 =?utf-8?B?NTkzUkJKbVdFRk9Cam15MVZZeGM5RjUrbTlzVUtuYXcvRTJJSTZROGVCdytj?=
 =?utf-8?B?YUNoM0kzUi9JcUV2MFBVZHQwalBkOUdGZWdsTE9uUXJUU3RPZkY5MlBkSmJz?=
 =?utf-8?B?NlUvc0s0N3VTNS9EcktJb2Uxa0RHMm1JVmFzbWExZFBhb3pyeWYwV1lhVE1Q?=
 =?utf-8?B?enhRU1hFZUJDNUxWalNpeUpSMlVIVkdrbkF5dklKby9XeDU5ZkhWNjJhMW9j?=
 =?utf-8?B?K0IreFd0NCtmT1hOY1ZuNGkySEN6ejlnN0d4VTNMV2R5R0JrYWlETUxsMlRu?=
 =?utf-8?B?cnJqQmlwTWl1T0IxWDZWQ3RHL3dsTnBKMXlucUxzOExoQ3F4TTNpbCtWNnlR?=
 =?utf-8?B?enRlRElTZTZkSGk2bEphUmYyeldCSDBRU1RSa2lCT2dyRWltQjdLRVhudjJJ?=
 =?utf-8?B?aTcvRmZmQVZoNEhPeE5uay82bTZZbnQza0J0VEJwVDlDMWFMczh4dDduYzV0?=
 =?utf-8?B?eVJzMGtTQzR4T0o4TEltSEs5Q2VoZXowRmlMdTlZeVVPS0FDbXN0RE55Ynlw?=
 =?utf-8?B?VGNuem1TZUhWSlh3cjludjlCaFA5cWNDWDRUWWpvNmJvSzc2b2ttMVQ4R2M2?=
 =?utf-8?B?TithYmxtM0tQaFY3TjV1Z0V4elR1L2RRQTJsa3E1TGRhdmVwNFVNZjd6aHUv?=
 =?utf-8?B?RXdNNkRnWmNodE1KTWoyTmw0cGMxTEhqQ3oyVWNiaEFYc2l4RXhhRU8wZzls?=
 =?utf-8?B?ZTBOMVg1emZYMGowN3N5UUlRZ3ZYdW84ZnBzWWhZTGRyL2FnQTJlUThkQ2hx?=
 =?utf-8?B?MWE3c2IxZkhPSnVibHZpZ1pXWkNNUXdSVkpUc0V1U2xSdnk4L0F1blRpTVcz?=
 =?utf-8?B?VzNIOHRPa21UWXZkWFI3K2Mrc1JWeUlKOEZsTVVKaG8zVWRhZXErNjY0QitK?=
 =?utf-8?B?M0oraXk1V3hEaTlEU3R1Szc4Z2VObWlEV0ZmQUlaV0NtaVlYL0F2MjAwZnNl?=
 =?utf-8?B?R2xGY1JlY3lua1BGZFhLV1Q5dUdjU2lHL3RWYzZZek9VQzdFdDYvRTJvNXBo?=
 =?utf-8?B?alZ4VDZTQUxST1Z6SFQyNTEvcGYvS1haemZsSXdiZFlrMFEyN1YwYW50SEc0?=
 =?utf-8?B?dWgrRGFiM2FBZ3hOY0JVSzNUdHpEcTcxbWxaNEkvQ1J2aTNmSk53em5GUTVY?=
 =?utf-8?B?b3c1aUlxRk5ncEVmTEp0WFFIR2RRcEVSZXFoTEh4UWJUZER4UXN4N3AyL1d4?=
 =?utf-8?B?MS9kaHRrT1ZKdTdWMjFHU3RqQ1N4S3I1TkJnSTNjRHVWQXZFZUtSalFmUk1N?=
 =?utf-8?B?dDM3RGYyZWRUME9hWHE2VldFcGtDdWtha0prRW1aSEJVcCtySU90T1RxYXlI?=
 =?utf-8?B?WVhwM3hzZXVKeG15VUV3Wlh1R0VqYmVaQ1pXVVRBcXczc0sxVGJueHBhQ0VK?=
 =?utf-8?B?SzZCNXo3cFZTTmVsNzZVTkJVK1ZQbFIxeXJENWlLcDN4blExU2N5RWtYR3hq?=
 =?utf-8?B?a0paVjRwN25KWS9DUXpFeXg1OS9ueFhVVklSbXRQdmNKR2hybEEvUEpkc21r?=
 =?utf-8?B?aTVZY1F5UUs5OGk2cW9ST2hWdnJOdzhodnRYZ0JkYktCeEZPTU5SUVNjRTBx?=
 =?utf-8?B?dTk2RFdHQ01ZWjYzM3lQc1lOc2pFWSt1U1YwYzJFdytIN29TZEtHK3J5c0dD?=
 =?utf-8?B?RFlhYm5DdDVFYSt3aTROcUNpNlVibjltdGRaTVB5RDh6TVFnYWhCRllwV0E2?=
 =?utf-8?B?YkxaeFpxVFA1aWtNWHNmaUhubHBSeW5Na3NEdmIzM0NUWGNwWjZlbTZDb05i?=
 =?utf-8?B?dGQ4YkdtTytoREpHSFowaGNaZjcrdngrM0JkcldJeTN6V0ZTSFU4aTBrcDBJ?=
 =?utf-8?B?TExiVmVHUEtST0R6ampMWDFESzd6eEtTRkExSWVteFFkVnl3MkFwbUFCR0VG?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e91dc2-c203-490f-1c15-08dc7bdf5917
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 10:50:38.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZTneWYas9tIvrFke18dVKV1DlmeYBT2ShdGoZmNwb4aMLJ5JyySZxCVvcawwVP+j+oldTIUUnsMDd9OLMsDJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 May 2024 10:50:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15942

From: Jan Kiszka <jan.kiszka@siemens.com>

This also prepares for a generic x86 target.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/qemu-amd64.conf               | 4 ++--
 conf/machine/simatic-ipc227e.conf          | 4 ++--
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index da7e59cc..d7866468 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # SPDX-License-Identifier: MIT
 #
@@ -10,4 +10,4 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_qemu_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 95e2c9a9..33f82b16 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # SPDX-License-Identifier: MIT
 #
@@ -12,4 +12,4 @@ IMAGE_FSTYPES ?= "wic"
 WKS_FILE ?= "x86_64-generic.wks"
 IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
+KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 40c378bf..6839e1a9 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,4 +14,4 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
+SRCREV_cip-kernel-config ?= "5a81b70b8a158d44991da73cf01f310bcd2bff72"
-- 
2.43.0

