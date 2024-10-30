Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF6D5CCAD
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 13:25:34 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.65])
 by mx.groups.io with SMTP id smtpd.web10.14694.1730294456988488729
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Oct 2024 06:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qSQHMnQD;
 spf=pass (domain: siemens.com, ip: 40.107.105.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3qv812WF/x4O/vzX5VsPWA8gurPGeesT/Vm7GxJu40tQkFjcb9sUefTzEaAetoAmGR4kxm5TBG06YUDpYSlPEcsphOZMnZ60bn9bnl6HH4QA68blALP9qjYwRGL2JdKYaYY1emm9k7W+RESE5I4FRz+8cn6MRAUOwR4p+E1wvcSPmNIr1UB2qc53Ttmk85B14FXFNjOa9ww3XUpQZ0tQ8PoPVUdUW6VDJlvnAz2Tm+TT838RmSe1ixknnaURehzOtkBIZQriZGI+hp9pfOjc4dtD8l5x+l/L5KO7sWFj72BAbR3OyT6ks0toQbR2CkGvGVrePPBiAx2z/HAA+Ykbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KZnGI+KrTw1HT2aRewcIs2H+dskpgXN4bM8AS+ISB8=;
 b=g7bhLbHfv7p6RddgfJ6LL6U4rD0+ebuXojYXU9Bxn0mEH2PbxNMHf+2rwqTeb9wufjXGAayoycXgsK9xxuQ5J6H8TVAcb2ilNY00xVOp8pcyMOCwgkGQ8VS0RP/GDJgQ23cPkTWVtDTgYOaZPexa3PkR1iy+52v3gWX/PVUDlqpS89EV4k0xnugtGpogrBqeQ99pVd3WYjOy2hzcRXTasbt1R506seQYQ6HWwKcJNLbAtZDfPB7abuFe0zZcMYnf8raLP9NWI9c4CxctBd8kfPv8xi4H0BCTcH66XvR/pvWTOk3I+/Oj9dpSZQCQixzZKjgKQmb0yKZLkCkQhucMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KZnGI+KrTw1HT2aRewcIs2H+dskpgXN4bM8AS+ISB8=;
 b=qSQHMnQDmNv1mGEaEZZaVQdQsH7xWr64KAVnKOf1eCGdUBiEBNys5myrYc/JFBvrd5Mk3s0uIGCPBUHHovo4By9rIGP9CB3EYbsQuIh2nbVdxfHWVR/3NIgbg8OIefAnvYVi8EI/bt2S0W/HBHE+tN/C4dysmWi8AkBXT1+aKao//Q+/oSX169X1KoUHAwcoKtf9V6v1jD1kaWZajSr8WTDwEo3VfNcYsuafvfPvlZxsIcQGdC5+rRznkk7jBovpPk3V+/pg52Jmzi2HFWBZBVMNYKv79q6EiXCGJ5ScBy9yGY05wdkUJYFaT1ZAG00Nokk9egD0bl/zuyHuzi/COQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 30 Oct
 2024 13:20:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 13:20:53 +0000
Message-ID: <fa83e565-8950-4ca7-837b-1c513a119bfa@siemens.com>
Date: Wed, 30 Oct 2024 14:20:51 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] qemu-arm/arm64/riscv64: Switch to
 cip_merged_defconfig
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e91063a-f439-4e35-25e8-08dcf8e5ae12
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MldGclJqYVRubHc3eG9yOEl0MTlFZ1BKUU5iZ1lJTlRPWGorV0Y1MU41RCtQ?=
 =?utf-8?B?ZHJHeThxdkdkNUVHRUxpS2xoa1RuaUk2SG03ODV5MjVWL3JmMWQxRFljMW83?=
 =?utf-8?B?Nkd6QlVxS0s2KzcrSkhPOXFkNDZDUE5YblhwN0F2Q3NkK1Z4SUlDaUxobFdw?=
 =?utf-8?B?MHdYT2pWRHRoOVJkWFZ0ZXJ3b3lYeUU0Q2JiMmx3U1RZblpPMW5BT0xUaXNo?=
 =?utf-8?B?NDRlQjlkWUJvWDdpNjFoR1dHYjVPSk1JaVdTRWtLbjZ0OWprcjdVcFNvc09l?=
 =?utf-8?B?cjVoTDE2Y0tSMmtZZnFNaUdLTVVHN0xlbzVVaUdLT1UxdWtBU1lNRXlPYlJl?=
 =?utf-8?B?NHU5K3lpTEgrTWRHWUh5cVFIWVBXU2RIdE9DN2tRbUcxUXpoUWpkeEdBbFdi?=
 =?utf-8?B?QSsyNmlISERxSXFwN3I2blFSenRwZmRKNloweGZjZDJkL04xYXdoL2t0eGZu?=
 =?utf-8?B?UFdrd2FBcm9JbGZMU1c1NTRzaUxFZXhoalYyZTNFNlVVZVhURk1rV1NreDQ2?=
 =?utf-8?B?bkNKSEVKL21Rd2V4YTQ1RWhUTWZtUjZTWHRiZXNoNmFLNG81L1BpZjUzRk1w?=
 =?utf-8?B?bEpsMHAzZXZTV1BaUmEyNGxTRUg2UERTYUZzYnlxTkVpU2NVd2ZBc3crMzA3?=
 =?utf-8?B?ZlF6c0tWc0JsZld6VjZxam54cXllZUkxcWhrb1k3QXdNRktvR1BnemxiSGQr?=
 =?utf-8?B?MzhtbE96amh1cE5VMW9kWnlxWFF2YUtSVFkyekdqRVM2OHpBKzVxMnRKRGlT?=
 =?utf-8?B?RWVCNjFDSjlzR3BYTWhoU2l0TTZ0VTdWbnNubHQ3K004akRvNmJ1WUIzU3Qz?=
 =?utf-8?B?d3RMblRieE5LM2lzcXJDcEt0b2xoeGNxL0hXeFZsQUQ5T0hpaklOVzVlL2pi?=
 =?utf-8?B?bE51Tm9SWFJnbnlBZU8rOGtTcklSanhwaTNwU1VnTXhOMGpvM2pGOW5DN0hB?=
 =?utf-8?B?dC9uWkFUTmJpZjQ2T1ExS04rZEczTzBJWUljRDc4a1M0b2paaTNja3NDMjJC?=
 =?utf-8?B?MUFvZENsMXhYMVZqYTdRUlZoWU5MeithSXJjZDRkR0NJcUZ5ZDVzbWJ0ZWtO?=
 =?utf-8?B?aU9RYWsvNElQZGp3Ym84TFZXKytVSEo3eDFZMmV0VTNnSUxtajhHT1lMOWt4?=
 =?utf-8?B?SmgyQllwbnZqOUtwdm9mZGVOeHBLc29XVzNGZk1uZmcrNnVHL0p0UmZWNGRn?=
 =?utf-8?B?dG1nZXREVC9oblkxMm0rUEY0ZzN4TkpPL0xpaTI5dW9DdG9MZmo4RnB1a1JL?=
 =?utf-8?B?UGZRalIwcmVWbFlMV3I1dmo4VTQ5MW9YQTFiaUxiVFdaMjJWN0h0dHhTYjNk?=
 =?utf-8?B?SWRTaGhyeHBXY2hMcm1ZZ2Z2RzFMTmJuTFlFdkczWHd0Rm5wL3lPcEF6N0pu?=
 =?utf-8?B?MWl5Rmg2NmluTE1oOU9JUWd3c2NUa2E4MXQ1SDNwVlBvMlozSmhBdHQ0THFh?=
 =?utf-8?B?cXA5Tkpxb0Z1YkU4Q2FyS2lNbitPVWdXTWw3aXJhQTJSU3lUUmxIMUNZT1Y1?=
 =?utf-8?B?blpGeVJGWEVramZMK2N5UzhRMmVTOXVsdktNL3BGZXo2RldZYisrUW9NWW14?=
 =?utf-8?B?UFZ2c3pZQUIwbVJZRHJVSGRqeElaUXNIaUpyOFoxaWkzajhwQ29wZm9xL0Zj?=
 =?utf-8?B?QzVMU1lIdlRmWDZ1b3EvdnZNN1NpSU56R3JjcVI5aGh0WDd1Yi9ONmVwMGxi?=
 =?utf-8?B?d1hMUmwyaTdhdk5qVWFkUmgwRjJnbWVVL3ZxdStHZWY0UjkyYnZsNjgyU2Fv?=
 =?utf-8?Q?ohJXzKe6ZKIH1DBugyOnqeMO7wCzw1QtTfuvaHE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXJLYk40UUY3ak5jbFNCbFpvemNwUlV2eUVpQVllVXQxME9lekFvWVpyR1FL?=
 =?utf-8?B?VWxzaXg2ZlVqMEtNOEhhL3dIaG9UMHhpc2tSWEpCQ1ZHYTlxNUExVmg5blF0?=
 =?utf-8?B?UVcrdi9adTZVTkYrRytjaDhJV1ZKV2NpbVpRNHRjTCtRLzU0YmE3V3pRb3VL?=
 =?utf-8?B?cnhLM0hST0o0RU1pdzBVaTdFbTFZYUEydjY3MFlJQm1OdHZ3QTBXMUdiMnM2?=
 =?utf-8?B?L0t1eWxGRzI2WFVVUnhadjI4WTRmT2NhY204UjdEaTgrdCtBdGp6R3Nkakcr?=
 =?utf-8?B?WWFkUk03RzArWHUzUmJ2SHhuT2JhY3JTUWNOa2k2NnJxQVdNYmRwWkJlbkEz?=
 =?utf-8?B?TnZFRWxPb3R1bFF4MDduNGNIUWxpTVUyaWhISFZRWmxJRmVGNk02UENkY0lC?=
 =?utf-8?B?TnFlQTJISmRCR2lrSkdwYzlsR3pHNGZSeUN4MG8zM3UzR3lFMnFBcTQweUlu?=
 =?utf-8?B?UnBjeHg2Wm5wblFoWEw3ZzNNL3p0WGNVRm80YkdLdFEyUUhrVkYwWCtGTWdM?=
 =?utf-8?B?WnFOOHNmVStKWEFGVnZHMS8yNzQxa0FFNEIrZUswb2VLT3YvNnljdmZWQzJn?=
 =?utf-8?B?d0FyK2hTRFZrdkRwZVpqeGZjdnRFWmVmTW5GSXBFd2c1cXIvb1pRTkJoTUti?=
 =?utf-8?B?TlNyWGs3aTZRNW5MVldIdHRwOFdBUWtMbkkvN2R0ZzNsQ0VpWUhETFI4VElS?=
 =?utf-8?B?d09sa2pReFFYQ1VkakJrZjg1UGQ0WDk0Nm5XNThxdzJGTEYwVjlRNkdQZkpC?=
 =?utf-8?B?c2Y2TTVHbE1JYmdhVWlOMU5RbXZUVDBXZkdaVUZya3NQblZBR2k1UElHUEZy?=
 =?utf-8?B?Qm9lczFzWGdmM1F2QjBqMmQwTDBlaDBQS2FET3J4UlQxRnZvWjgzQnJqdGd1?=
 =?utf-8?B?WkpXNW1FVGROd3pJQ2pFajdHcHovd3ZyclQrN0ZpRXpMcXVPdG5ubzRNV0k3?=
 =?utf-8?B?M0hRVlNuTEgzc2hXOUZEZmdLeEpsVnRZb2RCS2c1UngyeDJtbGxYOWFQcjdI?=
 =?utf-8?B?UmkzU01zRU93TnlmdHB2dnJ6aEE5b2krWTByUW1JUmplOVEyT0JsWmozSktj?=
 =?utf-8?B?N0I3S1FXYW1GdXBzWlVpSkNEbUhTUzUxZUxucFZjWk92eFVKdzlDOHkyRkxM?=
 =?utf-8?B?bVdycnI4bHVHeEEwMFJ4UUN4WkMzQ0xLM2cyb2xOdThYOG4xYnhsR3NNS0Vq?=
 =?utf-8?B?UCt4RWwxVmFTMjl1b2p2ay9hUkErSTRuaG5ma052QW9IVUM5R1BaUnRTK3Nq?=
 =?utf-8?B?NSsxT1VTeGdBWmxDdm55WHc3NHllbDRvcHlsbjhJMGFIQTRhdFNnVndIcU1L?=
 =?utf-8?B?OHJvYnAwRnJzM3UwWTA1WmtKOS8wZ25PcktidHp0Wmx1SVVZRVVkMEFsdjVX?=
 =?utf-8?B?RnFBTDZNbTIxNFNTRG9KczRDdjhkaG9ZMUlTb05XcjQvVTBhdGJsL3RtaGhj?=
 =?utf-8?B?aVlyWnBBN0p3T21RVit3V29QendHME5wSFcydHY1RkhlZCtoTE1CVGJxQzF1?=
 =?utf-8?B?a0NTSjFIcVJpeTYrZkhDcjJNNm9KSXFNcnNQN1J4Ry9sRkYzZTlWNTZNTnI2?=
 =?utf-8?B?cXZOSzJzckppQUg5bzltciswVVo0eTZYTkRmN2lER04xd2Frc3MwYis3TURk?=
 =?utf-8?B?OWdVUE5KMmkrT0lqcEV1M3dmT1lTVU5jNUhFR2ZWYzJrNmpQeTVQeFplK3pD?=
 =?utf-8?B?S1hPTUxCcHFJOXM3SWlTL2NiV3p3S0V0ZmFUY2N6R3hKaGd0YnMyTXdKckJV?=
 =?utf-8?B?SnIwNDIxZCtmSFE1eFFjWmJKNDc5aWlKWFlnblFVZEhmV2tkeGZMelpLbmww?=
 =?utf-8?B?Z3dzUlp5b1FnaFROWmRua21zczVXNWIyTURsOWVrYWJHUHg2d1RCc1ZISUZj?=
 =?utf-8?B?cFdaaTNWODR5aFFOQlR1YUcwWW0xbW5oNmtCTFNyZVVrSEJyY2hUc1FYaS9z?=
 =?utf-8?B?NDcwMnAvM0QzZmlNQ3JXVk91Y29jbWM2M3l5ZkwyV0xod2x5N291R2hLT1dM?=
 =?utf-8?B?ZWpWa21kWDZQRVAyc25SZVl1N2JMc0JDOUt1UnBicmV6dnNxbXVNMHc0ZXRn?=
 =?utf-8?B?ZW9oUFNCdjJhL0lMd095elBxSVRzMDZmK0FOUkpOY0FZYjdhTXQvKzNiUjBF?=
 =?utf-8?Q?FphhgfsWMDL+ExpBO4Cc388wY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e91063a-f439-4e35-25e8-08dcf8e5ae12
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 13:20:53.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9NK9aaXwoleyogH5y1VXzrYiurFn+9uOIEJ0geyLuhoGWuAFKHALp1Uv6oCk3F+n8OfHN8M5wR7/8KYBZAlPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Oct 2024 13:25:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17121

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to pick up all common features someone brings into the
merged config, like we already do for qemu-amd64.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is actually a so far missed pre-condition for the EROFS changes in 
https://lore.kernel.org/cip-dev/cover.1730289107.git.jan.kiszka@siemens.com

 conf/machine/qemu-arm.conf     | 2 +-
 conf/machine/qemu-arm64.conf   | 2 +-
 conf/machine/qemu-riscv64.conf | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index d2dd81f4..17c08832 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -11,7 +11,7 @@ DISTRO_ARCH = "armhf"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 7acf1079..a2c5e53e 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -10,7 +10,7 @@ DISTRO_ARCH = "arm64"
 
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/qemu_arm64_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 02bb60a0..36d6d943 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -14,7 +14,7 @@ DISTRO_ARCH = "riscv64"
 IMAGE_FSTYPES ?= "ext4"
 USE_CIP_KERNEL_CONFIG = "1"
 
-KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/qemu_riscv64_defconfig"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_merged_defconfig"
 
 # watchdog is not yet supported in our QEMU executor for this platform, disable it
 WDOG_TIMEOUT = "0"
-- 
2.43.0

