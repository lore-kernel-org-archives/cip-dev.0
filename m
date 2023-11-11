Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1329C4332F
	for <webhook@archiver.kernel.org>; Sat, 11 Nov 2023 06:35:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.54])
 by mx.groups.io with SMTP id smtpd.web10.47964.1699684546757637079
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Nov 2023 22:35:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g7ag2NYl;
 spf=pass (domain: siemens.com, ip: 40.107.6.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoTntuQCXPXbNIMLB6/jL35TFa646SJyjfhwpeoBf98nl0FOYsWupWbueo077rSY/Wov9HgXf+hSrQ/4GCy6Se/RD34CU+6Xz5EhXuouOH+Lc2I8Nvj0sZFoX6gp7hehA4TGoH/IdOzNW7fi0uqUJNpT/8Ncnb0qBSrBoSOqFDSUGpynwNuUTfY986wul+2ASV7liHG4o0r0SIu73CzB5hrPeASgv1YTQxiLGZgWj6kaLw38TSD2FfnjcLsrUkkaCO+fdheJtPYbecQUx923S5o2h+4mLlHCRALCyvmex2ahyGAbTzgUwut4ApI3b2OrW5eElTaPoxFteehT8tMrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuUDq3Q4HBly2rWLmh94howRfTSwAayncQ14UgwPIw8=;
 b=T7XeZ3myeGwi3SAwFbct8jM4mxoLeUuHvCz3Wakl4hrvg8S7CT0ABRDNedfhr3qFRLUVvKIOYyyZp8l1TZ4x67As54rVa2SCs/a23WujzeTlFg6mHhi5bvCb29OHtNkup+B8wj8h1EmQD6qXogl9WlAYa3I+yyqj4rmpY4o4MxEbZ3KkHHsVfQKOULHijpiyGipQkMI9GCI6NMx/LX1eLWqfBnocSFe6Ddl8IFlIrQzqx1t7AHeXs83J8H37XBuCg4IrehXsyU/9qVIvVGZ2KLbtTG0nZ1E2Q9gokRf+Bs+Oz1WTeRbbiRey8LcjDIjZDJAp2YQhjdx45e4CyT3qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuUDq3Q4HBly2rWLmh94howRfTSwAayncQ14UgwPIw8=;
 b=g7ag2NYlxaGyNrlZPTCsHkLMdKfIEP0lZ4Xr5r2v2Tk3icQEdaLHV7HsdXG9IdQLyjD1e0O8GsML6OxAaYOSHWIWd5GC2l+R6aSJwEEpi7KyaCxCZIHqr6rejub6I0d/6MgnVV72f+kDHBq7txcP7Jda0Yo/+zx8YTQ1iSAyYdhjylCgdr82hSFDG5/3NGu6/bEV1mbBdRxPjokdabk/qNbHPd/Pr1GypbuUbnOvUoZ+SiarToSrgfET7dQTJm1dRjjYPyzBczDaNnq5pc9meFie+jzcCL9rdQnKz8RNDJ70bT2QyNQ4OufuibELkhHdxovdKe7UNodCjpf+Dov3Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Sat, 11 Nov
 2023 06:35:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Sat, 11 Nov 2023
 06:35:43 +0000
Message-ID: <5a2fe06d-f39b-479a-b845-8f3273d39922@siemens.com>
Date: Sat, 11 Nov 2023 07:35:39 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Confine wic-related imager installations to
 that image type consistently
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e60060-0f3c-4bf8-333e-08dbe2806d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uyJJmscRBHuxBOw1ZaMt94kk+Xcp6blr8z9h1VTxmCGbuzAhxgbgnwPXlKNOXIXeKf+jDHHbWskR8HHZHCIz6VhsTz9nY8PC+/Ol9EJuL50romAgrLOMXoUAZdW7r2LvG37bB6XUj4SP4O31r4DWiX1wtRN32n1fysgxdl8ig82cIMiuGsNzDHdykRX3jWq/iBtSUKDx0REQu+Z1XvDMybhbGjuTiWe0U6dciGoTKAQ6fJ1+/6zEJcmJGPuLULDyf+NqaPcb4q5TIV9ewOQzly+Ldr9+HX16ookaZ3mG4EYKpbTAMKaMxRXaZl7yAPc5BOvg8N7Dn8tzAKXuckb5u7xzTIKtGTktm8zXs5d1m4Ku6iGTADn1xYf7xqpjZvJIPM142pAKTsAetbeOz8uMdg3uLeMtIUlEd+gZbtHvBkpU246RI8xpMPTpKZsFiPu/j3aTM8iXeeJO85YLU/wK+wPhwMbA6G0wqjpIibYrnFstc/ASsYdn3EOr4OVYEK61xeeOhk03nbv+CQH68fkxWoHg2ImT5OvHKp64WmqzRe9TdbbYllfofl6Sk2xQaHxSjtSIOTuX7DiWjnJz0pkpvNH3zYT654wmeTxts1tkMHBcURHfZQm3Bd2UFrkKllSkC5guYjJbhE9z1Z26dVX25Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2616005)(41300700001)(26005)(6506007)(478600001)(2906002)(6486002)(82960400001)(31696002)(86362001)(6666004)(6512007)(36756003)(5660300002)(38100700002)(83380400001)(8936002)(8676002)(31686004)(66946007)(316002)(66476007)(66556008)(6916009)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZnNwN0VHK0JXdGZLUittd0ZzeHM5MWlRMzZPSVgxOFpoaDRiMWZqYkRGdDF4?=
 =?utf-8?B?QVQwMmVpUjZUelJpOE5NcE5QWHFLRTNIcmM4Qzk3UlVpeTBRYUZsT0hTWmxq?=
 =?utf-8?B?c3pPbTE0VUx3ekVJa3lkTm55K2ZlOGk3SFlFMHgyWEdHVTF2eHliUEtlUklE?=
 =?utf-8?B?UDErUFU0bCt0eUI5N1IrczgxeXdqdktaajVSaFA3ODZsaWpIbU4wcHJES0V1?=
 =?utf-8?B?SnIrWWNzRlIxZnFVSVZqMDlDSXhjME5JRHpNa0p0SXR5NzNLdG9KbnlTT3FO?=
 =?utf-8?B?SlFBN3ViOERnUkR3WEthTnI5RmRVY3F2Y0I2M1lXckhYN0IxMDNUYVV5WGNq?=
 =?utf-8?B?ODMxWnVBQnZ4QWlWd1A2eEM0VVNYR0t1WUlDNWtENm9lTDVmY21RcVN3OEJ5?=
 =?utf-8?B?THRheHFycHZBRzdaSnV4aHAwYjdtWTBybXF1MGQ5ekJUQ1gxM3I3Vmk1NWVG?=
 =?utf-8?B?ZDdBNWJuU2d5NGh6VlBSTDJwZUthSHdEL1FuTWxUYnpQKzJNYzJsRDFiNGtt?=
 =?utf-8?B?Qk9RdG9rS0xGVTBUNmNqYXZ2RVpRZXdhRnRxQnh3T2F0WjhDOXBwaHU4UDd1?=
 =?utf-8?B?UEI4WUNGa1gzQzlwMWd2Q09DMHRnRDFqbTdjaldvZlNpTHJwODFPWHl1Qlor?=
 =?utf-8?B?Y3RlVGVGeGpadUpzcFBnUWdoVzlkT0ZPVnV0QTZmczFnWktLNGRoWWZDMWxP?=
 =?utf-8?B?RHNTR0FiNGVTOGZUamNwV2RYUUluTysveWN0ZWNLVVpsaDhwVThCZWc3bU81?=
 =?utf-8?B?MSsxM1VHclU1alY0d0kzcUY0bCt6Q1NQT1owU21jZlFzMGlCM1BCazlWNU1j?=
 =?utf-8?B?bnI2SFR5b2YySW42SW45OXBkVGp6YTJaelQrT3IvTTZ2S0pGQlMxanhwbjhD?=
 =?utf-8?B?a2Y0SFA1VGJQM1d3MGM3b3ZHelUwcDg3VUhFbHNIZXFGMVJkL0Jzd3U2SDl0?=
 =?utf-8?B?bWNTQWR6TTFlY0ZBR1FpSm5IUkhuZThncDZRK1hleVFWbUw4QmZZNzF1MWV6?=
 =?utf-8?B?Q1QxVlNHdnhyU2pkNDh1NWQwcFRtc2hDbE9DWWg4blRueTlUOTc0U1dvV3Bm?=
 =?utf-8?B?cFU5RjJCYmtLdjBwc0c1VVkrR0h3bU5YQ1Z1VitHVTRqNDNMak5mejU2bFhS?=
 =?utf-8?B?SjFzbUtqRW1ieTJGcGZ2MEJ0UGVIL2RpMFZ3VnpMUUQvcHVCRmNQdklyYnRX?=
 =?utf-8?B?V0xlY0dGK296dmpRSHVheTd1L1R4QzZaZnd4MjdNdlp0dzlMRU1uYnZEaTU0?=
 =?utf-8?B?amdTWklJY0IxMmFnSEg5R0NxZzBlUkpzZVZmNVdkZmplNmlFRnpwdW1iTytp?=
 =?utf-8?B?dm1mOGNvS1l0K2lpRytHQjFQU3gvSDAxeUtHRGNzZks3eWNPLzNwbEJOc2lB?=
 =?utf-8?B?U3dBbkJ2UWhMWmFCSkN3VmVQQWgxaWFpWFBMK2ZrME9xVk43T1dvUFV3Tjdo?=
 =?utf-8?B?TzBXMDJ0dzVBa2RxaUxKSkhHU3dBUTBVOHhZbW52VHR5LzVJK1ljbEg1bC9p?=
 =?utf-8?B?THEzQjI4dlNiMThDcVhObHN3Zk44Qk4zRjZaUS90VVplL2pKMTRXdmxyS25w?=
 =?utf-8?B?MmlCMTA3WjB5UHJiWW9XOTFLTGEwdDhUMVpLQlJMdU9lUkdZdFdMRkE3eWV2?=
 =?utf-8?B?bTVyNy9sR2hFWnorUytEY3E1ZXFFbVZoYS9DakZqUDZpQ2Q5T3VITnFNVS8r?=
 =?utf-8?B?eXZyNDFNRkNMaU9XQk9OMEtjTTdnY2RtZ1doYkYrZjU4bU1WZHFFcjRrOGR4?=
 =?utf-8?B?bFlOTEViSk52Q0Y1ek93NXc5TnNTR0FNUXd1Q2FxeHFpWlM2TmZ3ZGRDVFlO?=
 =?utf-8?B?eU5KTmlHRXlvZWY1eGkxR1BRYkNuRTFQMHVzVnkzQXRBcHJoNktWNHVGbnpZ?=
 =?utf-8?B?OUh4RVgxUVp3NS82cFVvVFRVM3lxZGRXZkVDMnVIWDZrdDNRSHNXRkpBbDRt?=
 =?utf-8?B?ZGh3Q1NvOFErU2c2cUEwdkx6bWNDK1VISFU0YW5lZ2RxZXBJYUJ4Sm14dzd4?=
 =?utf-8?B?WHVHUVR1WkR2RTIyU2J1QnhCUWgxVExhVGhjSHpka3JSaWlObzN1QUkzbnN2?=
 =?utf-8?B?Z090cUtsdzFjU3RhcFFUMzRHUEpCS1daRzMrWXFrYlhVck1TcWg1RWRvWXZW?=
 =?utf-8?B?NTZDcFNYeEFkZkY3anlEdDBpK0lGazMrRW5kRjBXOE42UzBVOTI3UXZrT2ZG?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e60060-0f3c-4bf8-333e-08dbe2806d7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 06:35:42.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxBSbl+hwSmSXVjc32NMKaB6VbtNoevB8BUOcHSNBO7u51pcT9T9eewUqN7llmCn25f1ugGfqahvAqzDNeSItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6658
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 11 Nov 2023 06:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13569

From: Jan Kiszka <jan.kiszka@siemens.com>

Consistently also means to avoid WIC_IMAGER_INSTALL which will soon be
deprecated in Isar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/machine/bbb.conf                | 2 +-
 conf/machine/simatic-ipc227e.conf    | 2 +-
 doc/README.secureboot.md             | 2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 recipes-core/images/efibootguard.inc | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
index c8b4aaad..5cf3a0fd 100644
--- a/conf/machine/bbb.conf
+++ b/conf/machine/bbb.conf
@@ -10,7 +10,7 @@ DISTRO_ARCH = "armhf"
 DTB_FILES = "am335x-boneblack.dtb"
 
 IMAGE_FSTYPES ?= "wic"
-IMAGER_INSTALL += "u-boot-bbb"
+IMAGER_INSTALL:wic += "u-boot-bbb"
 IMAGER_BUILD_DEPS += "u-boot-bbb"
 
 IMAGE_INSTALL += "u-boot-script"
diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
index 8bb3e808..95e2c9a9 100644
--- a/conf/machine/simatic-ipc227e.conf
+++ b/conf/machine/simatic-ipc227e.conf
@@ -10,6 +10,6 @@ DISTRO_ARCH = "amd64"
 
 IMAGE_FSTYPES ?= "wic"
 WKS_FILE ?= "x86_64-generic.wks"
-IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
+IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
 USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 2b73d10a..e93266d1 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -167,7 +167,7 @@ local_conf_header:
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
-    IMAGER_INSTALL += "ebg-secure-boot-signer"
+    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
 
     # Use user-generated keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-key"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index e0833044..7d8ce65f 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -26,7 +26,7 @@ local_conf_header:
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
-    IMAGER_INSTALL += "ebg-secure-boot-signer"
+    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
     # Use snakeoil keys
     PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-snakeoil"
 
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index c66ab701..0f26b7df 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -10,7 +10,7 @@
 #
 
 IMAGE_INSTALL:append = " efibootguard libebgenv0"
-WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
+IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
 IMAGE_FSTYPES:append = " wic"
-- 
2.35.3

