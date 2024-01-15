Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87875C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 14:10:36 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.51])
 by mx.groups.io with SMTP id smtpd.web10.81148.1705327831216285013
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 06:10:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P4Ojo7VX;
 spf=pass (domain: siemens.com, ip: 40.107.104.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXyJ2yDiuQIHqvB1ZOw2m+nrjArwhVnR3jVRjRhoPb4GgclYQqr3cUT1oBt1V6L/TvMgdbQXiuT713s8jA5Hpv15Jfxp6zMFHNxxJFBUhfQEfXa/gfZO9LLckVd9DM15lT/GyNi4UGCTF4TzqrwJN6EiVwv1rRXrhPx272yN36CvP7oSfQ7VzboIgQMXS2zIbwlyFsJHaOxSakJf4FWYECXAi8tjZLKAKJQeR3ft2W9a0k5cu2oPltygf6PImXQ9RHXFlqxLkcBXBEFD1+gB8dbzVqNTogN6YmnWTNkBXbdv2acOVrSoBBM8Ad8SWuIygeIbe4szj6Yz56vONDeG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tUIDeKUmQOBQ1j7kzIPD1AbuZ/k3wmebDIetKmjncQ=;
 b=gZENzPncZJbTi6VWULb8aywM5KcAMypkxI2E0PJMJinoYB8II/dFRw98G6xrojsT7FlTH1V83XVlfkytVbaSI+UbGId1ARWVi+9cfcOX9aflD+DLGvpEeVnFgRVXfK8itUNPBn7+8pHUUKY4tUiEOWJY6oERoJJribUfZy8mQ6EZECLxwAkzL+MXqf1IRXci5bPh2GFGBp/RCsqr8EYwlpy45dDCONJHLZ8RRJP4Hud91fIMeOTegDtwJz6OITOfJEtL+Hw8oO1ZTiCPOf3R5OPvHiM0UTwQyW5CRLYplh8fGpYqkQCjUYtvp6XdnhZEAVqTll0Zv5yDAoljMrZfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tUIDeKUmQOBQ1j7kzIPD1AbuZ/k3wmebDIetKmjncQ=;
 b=P4Ojo7VXccm7RVrzT5IezIkptmpLaF2je+61LEbReAXMxo7G7z0RqIc+rFIjqIRLqqJYWAf6x6OnQ1NKxHRBurm1ZvB7dN7dEFCt0CLLXb7UjJotKXsSZuqF/wLihC0dLDgsj+EVrYBOPzGwkX3TuJcHKZdRHybQSn3T5tFlR6NdUy4krrtD6zKMPxFJZg38aGwLbqyc6XCPWyvpFPGe1w/mfGb4m4a/5A40HE3SAdIuhqIWfX/JFN3YhOiaDiVxLqSYAMyGS3K71BNAMZYzGB21vAV9xOUY9dkFBLZjvK8vj1cXLm6sKVPAxVfVdltJfw3K972QqJkgsTe/LiYGRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3883.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 14:10:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 14:10:27 +0000
Message-ID: <fe9ba4d5-2475-4a1d-a641-47126d57b8fe@siemens.com>
Date: Mon, 15 Jan 2024 15:10:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] u-boot: Update to 2024.01
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3883:EE_
X-MS-Office365-Filtering-Correlation-Id: a75d268b-65c2-4730-c03a-08dc15d3b965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wOb/fY0ZflJomPvjiV175uhi82UJV7L/K2MOUeUhxO798fyrUkPNXKnLLFh3O+Msr7Ue/LIOpd+NEff2KJshDUqjpqvSQRbudqlWFmHg5cvaUJJdjY5THpJfV8ivTcvx8STTZECFdjGRKIc6O23+sqrvy3RQWPWgZ3mgF9yIf1eS3DziDuahi5/9UQkGm/+wZAnRnhOkCtkkRbqkUpMY+TrvdaE9C61YdgYQxXodcxr7hLOWnj3vSe4OItp0KCvfleuPtQmCFvf5LSxr7aD3pMIS+04GcdfW0KzQ+2My9egaUspxVwISGR0Ra/ILjpGjgUkVEQ1rGKXG5yyfeiTIO1TwVisRpYZRri0s3Jeog9ug2XiWd4LVIkfDvskFGf2EbGJRrh49SRfe3r023qyv76aWqEH2ZSHnR9SVSMyxWacWDxHnVJ7GK9EPBCmmSU1M0cNdk5nwro0bIrIaHwQxsLHMnFCkMa1EG4E+7M3P5p5MLJKSanbcsBAUFvHeUdnzOJI1LwIxs6benMVcA8sdETQRnfaT/xxCqRS7xC6HLiRG1nf4Zap81+JveczT6ggpPYAHqUmTrGiMgkKXHIIWAoArbtTf63AzsROSZkwY7mhLrQmA/IMszd7iMBmzB1D2CrRxqYOt6OeBE/1tG4i7sw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(44832011)(15650500001)(5660300002)(30864003)(2906002)(36756003)(41300700001)(38100700002)(478600001)(31686004)(86362001)(966005)(6512007)(31696002)(6506007)(26005)(2616005)(8676002)(82960400001)(83380400001)(6486002)(8936002)(66946007)(6916009)(66556008)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGYrUVJmeDh2aDNSUmxiWE5UWUhyb1QzMUNOUGswMkpnalliZ3duWUk1cDM2?=
 =?utf-8?B?NnQ3aFkxeGlaWDEyOW11Vngvc0ptMkdxaVE4YUt2eUlxMjdtdjN3MWhyMDY0?=
 =?utf-8?B?bDlJYi9oR0x0Q3ptTWhibE9VVFp5eUxtY0hvRjIrSXZ6ZEhEbEZXVWNMRnlP?=
 =?utf-8?B?NDFzMjlRd21DWVRUOXFvWGR1K2QrMlhMNEJ4dVpCbzVBWG91RldwSWxBWWg1?=
 =?utf-8?B?K0dxbHBrTitIcUdyLzJpZE5SdEg4ZlpmSEVOYWUrV0dpMndPa05DMFRPbkxM?=
 =?utf-8?B?UHZWd3NON0pORDNtT0R2K0dkSGR1RkZmTEhGZmtEaXdSSTZsMHBuZGtoaVlk?=
 =?utf-8?B?dm1sdWFqMTA3Rno1blVVTFA4OTNXZ0hmQjBZV1JybkpmUlIydkFNMEVTZnY1?=
 =?utf-8?B?Q3RPR1JkK2pNajBiSFZ1UlQ1UkNNUU5sdTRJUE5HQ0h5d3EvNGg4eEIrSFUx?=
 =?utf-8?B?Y3hpeU1IaDN0T2NjV0VzbXc5OWdicW1qcTFyTFJpT3BKN3M3YmpzVW9lRi9n?=
 =?utf-8?B?SFhwMDZaQjQ4b2NZTDBZYThUcFhMaVRhT2UvZDdTTyt2UkUzV2kxR0J3aEJR?=
 =?utf-8?B?UUZrNS8rR2JOVW1tY29jdE1sa05aR1dqZFN6aW0yRmE4SDBQTDZsYlc2elpz?=
 =?utf-8?B?Q3BWaWVuYXVuYmNWT3BDZFJiZjVSRmhYMFRDNWoyNDhDNzY2NTZNei9jRjhy?=
 =?utf-8?B?UWhTNHdvVWFzZVRaMDN4OXdEUFREREpSaXpyMDJjY2FlTXkrR3ZibUZMRGl3?=
 =?utf-8?B?RkxjK002cEQwVVpTS2RmWjJHZ1lDa0thZ2MrNjZ0VkFPRlQzLzFqcFJCUnda?=
 =?utf-8?B?WGxVbnFac1RYUVhyU2pocEk4VDJIdjIwU3pZa29nTkdFZUJPSTJRNVUvSUZs?=
 =?utf-8?B?Q3pOTkhsdzF5U1J4ZXVoZDNlRUFJUUJtckd2by9Oa1QrTzdtQnBaNGhPV290?=
 =?utf-8?B?bU9UM2VqUVA0bkRTOE5JQWEyWUlndXBEdUQyb0oydHNza1FUbGhTVEZWbU50?=
 =?utf-8?B?VFk3Z1JuZVFXOU0rRzRqMWdVNDZmZnZWN1hBbXBVNFNTczlwc3A0cXhrbGNy?=
 =?utf-8?B?N2crNDF1dFM5V09zK0pqUmVQbC9Rb0dmeEhPRm9iYXBvNENmSFpsSzFoSm5N?=
 =?utf-8?B?NWNBYUE2ODNoQ2R3THhkcXFUWkFkU1FUeGlZUEpML3dvV0V6ZGNrTVVZSTBZ?=
 =?utf-8?B?cHF0L3puUE53ZGJ2RTFyVGJkSHJNUlhxMElmeFBhand0TkZPZ3oydUJKYXRG?=
 =?utf-8?B?YVB2TWFyWDNZN1pKYWJKdCtML3pOMTJsQkFzbTFKckx0ay9hcEEvS1JjKzlH?=
 =?utf-8?B?Mm9xS2dOOGJiRGxIelhtT3BKdCtNTmZ2cWxvb0Mza0dNN0V4ZlZpZnRSanlz?=
 =?utf-8?B?bE94c2V6Z01BbE9PbFZKYjhLTmNFWUxyUG5kdnFtYUhyS2MwWFAzVlJ3N3BH?=
 =?utf-8?B?cmVLU21GeWorK0RYT21yWGYrWTBCRmVKTTA0cWhtSnIyY2FFb1RhQ285TmYr?=
 =?utf-8?B?SXV0UEs5UmRXZmdPUFoyS2laVVRUMVlhcW9wOVVGVmE4aG9uUkRZMlQxWXpR?=
 =?utf-8?B?bHVZVDFObExFYnIvT3pGRmRlZVRuckNzUGtRc2FKODk2Si9UaDhrR3lnVlk5?=
 =?utf-8?B?WXNBOTlpZHNWMSs3RFBxME9FUjFNclFVNTA4YzY2ekNDeU1YR0htZllxVnRU?=
 =?utf-8?B?Z1BtMnJxRnNOS0M3dW5UeDBFb0l2VUFRdm5kZ1RQVGt4ZlZJVERaT29naFVv?=
 =?utf-8?B?WFpLcVpGN3FQdHE4cmc5N3U0Q0RLTjN6bEkwbEF3YkVnRGtubVNzaDhIOUJU?=
 =?utf-8?B?cmtmQzVYNjUyWjkrNm5qZndrYWw5WlVyTEhSQzNkWnRmUldBN1YxYkI5dHp1?=
 =?utf-8?B?VUgwOVBHbVEzc1lwZHdmSjdYYk9Cb0h2Yi84bENPUHVwTXVGMUg4aGhQbkVa?=
 =?utf-8?B?cnFsU0x1UytZaEpvVUhzczJpMG1DWnVqUjJ6akJYRjN0Nm5FSWZjNWNES2pk?=
 =?utf-8?B?M2JZdC9Pc1NGbjFRU0hQU0grNy9xWXVrMWJyeHorc3VRVE02YmxPWHVXV3oz?=
 =?utf-8?B?eERzRVhNZnBWR1FMR3JCaUovVUhRdmNpNDlSdUZ3L0dWNW9PQTVNUXFVYnU5?=
 =?utf-8?B?cm5pWFZ5VUN5dmFIc3haaHVweTd3eVdWUFVVUG9SQmx0SHc1U1hLUEQzaGpV?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75d268b-65c2-4730-c03a-08dc15d3b965
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 14:10:27.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /99aGn28XjGMafesen4UAWRMQ9URBtypISxhxwTXT6Ez5eZOsE2uPcIFgAXCwt1EBuXJwn1jeeJ8gsTwrjKVrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 14:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14384

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the riscv patch.

This version switches us to the bootflow mechanism. The boot command is
simpler, but the secure config needs extra care to turn off all non-EFI
flows while keeping all switches that we need and that normally come via
too brought CONFIG_BOOTSTD_DEFAULTS.

u-boot-common is actually version-specific as it carries the sha.
Reflect that in the file name. Using ${PV} for its inclusion only works
directly, not via u-boot-qemu-common.inc, so do that from the respective
.bb files.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix secure boot

 ...iscv-Fix-build-against-binutils-2.38.patch | 55 -------------------
 recipes-bsp/u-boot/files/secure-boot.cfg      | 17 ++++++
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  7 ---
 ...t-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} |  6 +-
 ...t-common.inc => u-boot-common-2024.01.inc} |  9 +--
 ...022.07.bb => u-boot-qemu-arm64_2024.01.bb} |  3 +-
 ..._2022.07.bb => u-boot-qemu-arm_2024.01.bb} |  3 +-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |  3 +-
 ...2.07.bb => u-boot-qemu-riscv64_2024.01.bb} |  8 +--
 9 files changed, 27 insertions(+), 84 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
 create mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg
 delete mode 100644 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
 rename recipes-bsp/u-boot/{u-boot-bbb_2022.07.bb => u-boot-bbb_2024.01.bb} (80%)
 rename recipes-bsp/u-boot/{u-boot-common.inc => u-boot-common-2024.01.inc} (74%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2022.07.bb => u-boot-qemu-arm64_2024.01.bb} (87%)
 rename recipes-bsp/u-boot/{u-boot-qemu-arm_2022.07.bb => u-boot-qemu-arm_2024.01.bb} (87%)
 rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2022.07.bb => u-boot-qemu-riscv64_2024.01.bb} (65%)

diff --git a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch b/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
deleted file mode 100644
index 6f8a2ae0..00000000
--- a/recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
+++ /dev/null
@@ -1,55 +0,0 @@
-From 5df4b2299f86933fa79aa3bc6a3986fc7e55b7e0 Mon Sep 17 00:00:00 2001
-From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
-Date: Mon, 3 Oct 2022 18:07:54 +0200
-Subject: [PATCH 1/2] riscv: Fix build against binutils 2.38
-
-The following description is copied from the equivalent patch for the
-Linux Kernel proposed by Aurelien Jarno:
-
->From version 2.38, binutils default to ISA spec version 20191213. This
-means that the csr read/write (csrr*/csrw*) instructions and fence.i
-instruction has separated from the `I` extension, become two standalone
-extensions: Zicsr and Zifencei. As the kernel uses those instruction,
-this causes the following build failure:
-
-arch/riscv/cpu/mtrap.S: Assembler messages:
-arch/riscv/cpu/mtrap.S:65: Error: unrecognized opcode `csrr a0,scause'
-arch/riscv/cpu/mtrap.S:66: Error: unrecognized opcode `csrr a1,sepc'
-arch/riscv/cpu/mtrap.S:67: Error: unrecognized opcode `csrr a2,stval'
-arch/riscv/cpu/mtrap.S:70: Error: unrecognized opcode `csrw sepc,a0'
-
-Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
-Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
-Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
-Tested-by: Heiko Stuebner <heiko@sntech.de>
-Tested-by: Christian Stewart <christian@paral.in>
-Reviewed-by: Rick Chen <rick@andestech.com>
----
- arch/riscv/Makefile | 11 ++++++++++-
- 1 file changed, 10 insertions(+), 1 deletion(-)
-
-diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
-index 0b80eb8d86..53d1194ffb 100644
---- a/arch/riscv/Makefile
-+++ b/arch/riscv/Makefile
-@@ -24,7 +24,16 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
- 	CMODEL = medany
- endif
- 
--ARCH_FLAGS = -march=$(ARCH_BASE)$(ARCH_A)$(ARCH_C) -mabi=$(ABI) \
-+RISCV_MARCH = $(ARCH_BASE)$(ARCH_A)$(ARCH_C)
-+
-+# Newer binutils versions default to ISA spec version 20191213 which moves some
-+# instructions from the I extension to the Zicsr and Zifencei extensions.
-+toolchain-need-zicsr-zifencei := $(call cc-option-yn, -mabi=$(ABI) -march=$(RISCV_MARCH)_zicsr_zifencei)
-+ifeq ($(toolchain-need-zicsr-zifencei),y)
-+	RISCV_MARCH := $(RISCV_MARCH)_zicsr_zifencei
-+endif
-+
-+ARCH_FLAGS = -march=$(RISCV_MARCH) -mabi=$(ABI) \
- 	     -mcmodel=$(CMODEL)
- 
- PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
--- 
-2.30.2
-
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
new file mode 100644
index 00000000..95371626
--- /dev/null
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -0,0 +1,17 @@
+### Secure boot config
+# CONFIG_BOOTSTD_DEFAULTS is not set
+# CONFIG_BOOTMETH_CROS is not set
+# CONFIG_BOOTMETH_EXTLINUX is not set
+# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
+# CONFIG_BOOTMETH_VBE is not set
+# CONFIG_BOOTMETH_SCRIPT is not set
+CONFIG_BOOTDELAY=-2
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; echo 'EFI Boot failed!'; sleep 1000; reset"
+CONFIG_USB_STORAGE=y
+CONFIG_EFI_PARTITION=y
+CONFIG_FS_FAT=y
+CONFIG_EFI_VARIABLES_PRESEED=y
+CONFIG_EFI_SECURE_BOOT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
deleted file mode 100644
index 6111007c..00000000
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ /dev/null
@@ -1,7 +0,0 @@
-### Secure boot config
-CONFIG_BOOTDELAY=-2
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv scan_dev_for_boot 'if test -e ${devtype} ${devnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo 'EFI Boot failed!'; sleep 1000; reset"
-CONFIG_EFI_VARIABLES_PRESEED=y
-CONFIG_EFI_SECURE_BOOT=y
-CONFIG_FIT_SIGNATURE=y
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
similarity index 80%
rename from recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
index 6632bb6c..e727c5af 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2024.01.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,13 +9,11 @@
 # SPDX-License-Identifier: MIT
 #
 
-require u-boot-common.inc
+require u-boot-common-${PV}.inc
 
 U_BOOT_CONFIG = "am335x_evm_defconfig"
 U_BOOT_BIN = "all"
 
-EFI_ARCH = "arm"
-
 do_prepare_build:append() {
     echo "MLO u-boot.img /usr/lib/u-boot/${MACHINE}" > \
         ${S}/debian/u-boot-${MACHINE}.install
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
similarity index 74%
rename from recipes-bsp/u-boot/u-boot-common.inc
rename to recipes-bsp/u-boot/u-boot-common-2024.01.inc
index 0486cdaf..69427322 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2024.01.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,10 +14,10 @@ require recipes-bsp/u-boot/u-boot-custom.inc
 SRC_URI += " \
     https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
     file://rules.tmpl;subdir=debian"
-SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
+SRC_URI[sha256sum] = "b99611f1ed237bf3541bdc8434b68c96a6e05967061f992443cb30aabebef5b3"
 
 SRC_URI:append:secureboot = " \
-    file://secure-boot.cfg.tmpl"
+    file://secure-boot.cfg"
 
 S = "${WORKDIR}/u-boot-${PV}"
 
@@ -27,9 +27,6 @@ DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
     openssl, pesign, secure-boot-secrets, python3-openssl:native"
 DEPENDS:append:secureboot = " secure-boot-secrets"
 
-TEMPLATE_FILES:append:secureboot = " secure-boot.cfg.tmpl"
-TEMPLATE_VARS:append:secureboot = " EFI_ARCH"
-
 do_prepare_build:append:secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
similarity index 87%
rename from recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
index 29ca0a55..9ce62937 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm64_2024.01.bb
@@ -9,8 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 U_BOOT_CONFIG = "qemu_arm64_defconfig"
-
-EFI_ARCH = "aa64"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
similarity index 87%
rename from recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
index cdad19a3..8540bfc5 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-arm_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-arm_2024.01.bb
@@ -9,8 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 U_BOOT_CONFIG = "qemu_arm_defconfig"
-
-EFI_ARCH = "arm"
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
index b222155c..0bf7b621 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -10,7 +10,6 @@
 #
 
 inherit deploy-firmware
-require recipes-bsp/u-boot/u-boot-common.inc
 
 U_BOOT_BIN = "u-boot.bin"
 
diff --git a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
similarity index 65%
rename from recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
rename to recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
index 8dfac457..43b9e28d 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-qemu-riscv64_2024.01.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -9,14 +9,10 @@
 # SPDX-License-Identifier: MIT
 #
 
+require u-boot-common-${PV}.inc
 require u-boot-qemu-common.inc
 
 # we run as OpenSBI payload, hence use smode
 U_BOOT_CONFIG = "${MACHINE}_smode_defconfig"
 
-EFI_ARCH = "riscv64"
-
-SRC_URI += " \
-    file://riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch"
-
 U_BOOT_BIN = "u-boot.bin"
-- 
2.35.3

