Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8633BC98318
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 16:57:58 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3128.1790269075013914147
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 09:57:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C/FG/U4Z;
 spf=pass (domain: siemens.com, ip: 52.101.66.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfQyz87U6s0IQ24jOKzv3Vp3M3x4eRAkPbHAMEH2ewAu91dkagMtiIGt23HmE0xLpCbHnT4sc1NG6+fv1ZH1pUOUZ9YQkn/ZPy3tawFsgHpi334HAB++1CZ2wVblAY4Oy3jf6SkyLKO8JKWJE1fw98WTWaTP5RNl1JT01KU1JDYEgJWULIZfzWlE4iAQRQpP7O3AL2q4ErOmRK/dfVM2ECVPaAF6ah1q7GXQI8gJpG2zS1GgWBqQ31F3EdAniSj1Ir/kSk4vNIMfHAD9g11TK9j7syEqY2qhqVaHJbnKgtNoeVHukmCILoIQ6L7lu0D/CTJG5lHzC9ch4qMCB0Y/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf2zJGlOxbTMvsXEXAQFx/2xAn08s7p8cpaKQm7zeW4=;
 b=UqbogvSYchaMApM7//jwqhIFZ8AW0BjmBjRsF9fqZr4Xk5dVVZo5Xa898oakiZHjpe+VVw+MOnSTf9UqEf/llkJgezDHK0iCWQF5xwuJcNxxFJbqVj9MTuRpH15kPfkiA3JSTOhzVTJBiR1aiyBtNWCLRMWfVrw0XxFdf8gw5whUH81DLGyfpHZM40KbmCI2ddKGigX7fq2KjuVGCMmZYA4wo1NTzbgVWlQIXWixVRoPHnfJtFhPXk6whdVy4radruoWEpUwFmDfZHNZmr5n5fMTdOODn4cRrnZek2DvsTM0Sc4E6Xq6fru/f+kUF0pHO8EX1y8ChaXzF9hwYQHIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf2zJGlOxbTMvsXEXAQFx/2xAn08s7p8cpaKQm7zeW4=;
 b=C/FG/U4Zd42cFyiYMlpTf9XS1R8/bWrbIqOJSCpawOW53ayIeq5mioS34AGDYlNvKPiuM6jlIqVhZQbstZnhQg1zogJBWqvAeJ/V/NWD6UYY4XffplaaIlMGTc+s+mENbkE8vQabE0ulhpWQHJ78Y0Tz0WA+Gymruv1IdtmLcZwsld0RHVWmDzESFLdk35eLjqW9DnZnLbQloQeMNaw4cnlObeuFCgRai/ou//CNdQEkRge8sJqnFY467dCGKDvW7DCawHf2f+w3nbjW/nJyf3GtQx5VcRO7WayaO6CvoX+d31jlO6H6KwpY8PmR43bh8etAgT1ELMOPnDOpPnN3pQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 16:57:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 16:57:52 +0000
Message-ID: <97786b84-5df2-4b55-a675-ab5cb0eb1e41@siemens.com>
Date: Thu, 24 Sep 2026 18:57:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] efibootguard: Add missing imager recipe
 dependency
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: f567d3e8-0ddb-47df-9e52-08df1a5cf893
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|6133799003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	P40E9XXMAGSiXHtZcikQNCpMtA6x0GNuUs6fn7kzuVnIA0NXRwaP3HDqawZogAvksw4qr4k2Q70kR2SAL0MplOD7r7FEIczUKtVVBFoF/oHmBebCMuuQt/seV6SHel+ih8ud/BCOuAXEGmFgyK+D4nvlFqjBmTFqR2dL3doYkiqawy5VXw1Dp1C56ywDzdwFgSI4v6d80uX3uyuH/uW8oNavOPn21npBadD804vl293JYTIWVkk7rv8c7ZGkgqVqRtTW5yJLRzvUv32EU7fmJcmHcrUOLB75hv+fRAhCxoW2Zl/Uzl4oN182JEYYxghvppyszfLZlxN7iB5wQZEKxR17fUQb7wkuwoz5Ju5KRlKkCX9MGLU+kb2UfJkYAB/B8Ar32jAPlvU1KqU+ajR6SieMuck6v8ddvCLTvj+EX1x/HSR//FblxQbHfV1JDsvDwP5dTORCR1+ZTaZ6KeXTxZdrnRx7Xceby5pFbj5QCwa+1CziD8xMJ+NibbZk//IGc1Pf1rKHf7tFQoEFntqMhj/pawD8DKj8FvtAM2hOHxcifSskxf5k8pFKflDwQPG8s+NiII5Y1nUXrnkPUgZfgbFUGAQHVYJFHbMLmNvWy9Bb1DjreNXICp363MTd9U/XYckVewiZDw29u1VUDbkCM6FKUF5wATa5SESb2SxBOxU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aGxRaDZNc3hXQTduY0cyVWxBYnZTa05ML0RYWkp3L1BUZXlWSWozaGRkZHd0?=
 =?utf-8?B?WnQyNTY1NkpEcXlsZllKRWRmYTBkamk5Q1hTNjFBOVl2eXFDTk9ON0NuenY1?=
 =?utf-8?B?NlZGajhSSHRGWUhsZ3JseFdBSXdVRFh6S0hTUUYvNTdSUnpqQ0xMVDRQRFBh?=
 =?utf-8?B?QmcxaWNKVHpUT0pScW92R0FwVGtvV25yNHlaeElhc1JuNCtXTFhZeE9IUlZL?=
 =?utf-8?B?dnc5VnhySlR5QXJaWURjY3pvTHJKcmQ0MHFia0VqcVhUMmtmVS93OW0xM1pI?=
 =?utf-8?B?My9oTVJ2WGZSbnRKNzArZkM5NnlEVjZ3MjVKVmJYQVFyc0JEdHNIbWpPdlU4?=
 =?utf-8?B?czFMaklId0twWHl0bmJnMndHeUdmYTJDOE5MTVFpaWFnekVMVnFybCtwcVh0?=
 =?utf-8?B?UGJXUGlIY1RBUlQrWVNUcFBwSWF3dGNiay8yYi91M0h1RW40RjZ5RTJIMGV2?=
 =?utf-8?B?VG9VK0x2OHV6MG1EZXBHQVlhMlUvZi9PaE04SEF5Ym1rRVdtMnpvWUlQTGRo?=
 =?utf-8?B?ZHVFNWZYK01BdEtHSmsrSnErUityeitWRCs0VjBWakZKZGpaK2JCOGJIR0lu?=
 =?utf-8?B?alVFWWs2cEg1MVZ3ZWNoeWdFeTU0VkZkVGJ5R0NxMHJFamsyQUZ3Y0FYZlZt?=
 =?utf-8?B?QUJFdlRTWDhwbkgwTWszT3RCSFZTcVBvN1JVMldEaTRIZ0h4MjRLZ3NpNlBJ?=
 =?utf-8?B?Y0sxNHlNbUxyRTZaWFpEb2FFM0JSRmJRL1NRQlJsaGpHQUgrakhldUFPNWFB?=
 =?utf-8?B?SFNIOGNDRm5KK0FWSEVhVFI1V2d3WEwwT0JJOTVjSFM4VmJJU01UdzNtMEg4?=
 =?utf-8?B?dEpBeVBEeVk2bERpdEtuZnBoc3dGb3JkY0dFVE9GcDF5UituWDA3RldkeW5y?=
 =?utf-8?B?VFdIOEJxY04zNW5mU1BBTFp5V2J0WitxalplK3ovUUw4K3hpVE9MQVZIOS92?=
 =?utf-8?B?YndqREhrajRjNjFzN1lJK2RPbDRUR1B0a2dlYWxDQXczcEcvSjZLRWdBYStX?=
 =?utf-8?B?Z2tKWWRmclArRFdQVmZxby94VElDRGxRdnpLY0xxb3RnZE5XamZaVnNxeUdm?=
 =?utf-8?B?c0VFWi9vOVJGeFN6S1dBVkxiRUR5SkY0Qzh3MmRVMk1hZ2pHMmRibVl5VVkw?=
 =?utf-8?B?S1B0RVlSU0QrZ1FvYmV2UVhJQU1WUWNIWjZCV1ZKM21UN3J6UE42ODR6aktI?=
 =?utf-8?B?eXI4K0FmNHV0d3MzK3QrLzdjWmpJbUN3a3RhVngrK2tzaWx4TWV5czZoR21R?=
 =?utf-8?B?Y0dEQUVBWVBBK0NYRmdHc0FRTG10Q3ovaVpSTkdwU2RLbHRJck5HcG1tSEdH?=
 =?utf-8?B?UFhKVkZkZ1paZjFXY2FSbWIycjhWR014MFVMbWJCZXpVM05sOTBBSWt2dWlq?=
 =?utf-8?B?SHpuNzM1bEtlRmZ2am9BYXF6d2Q3TWJ1V1BlUnNKQ1Y0NmVYM2pZck9jQWha?=
 =?utf-8?B?enYyRVhJTTBtN3JpMlp0L0NOd0NXZVZ5UzJNc3lMVjZuMHJvQWhkR0tvKzI4?=
 =?utf-8?B?WHMybjRQWmQwQTJpVzdKdHd6Z2ZpbDdPL0Ridkt6a1ovNEpmU1ZNNUtYcHVi?=
 =?utf-8?B?ZXNsQnFjSzVwMkgxZSszajNybkdEaHdoUTFUUHBBK0pGZjVaYXNHcCtTTk1u?=
 =?utf-8?B?a0JxcmRvVExlN2pFbkZWenlEYzlsVDFHUzgvcU5uYVFnenFTdm8yd3BlV1RU?=
 =?utf-8?B?MzhCOXN6aWRaWHZFRG5mb3l5dWwwVWF3WVdBY1c3RlBMWHVCWGVOVkhsRWZJ?=
 =?utf-8?B?UVBsb2pQcjhtK2tUdDNaU0VYRWVZbmorMmg3emxqb0FIcUJPNTV2WnFMR0hr?=
 =?utf-8?B?Mkw2czJYaXQ5UWNMVktnaVNWL04wUXhjTWdFZTRlSW12bi9CK29mTEsrQnNI?=
 =?utf-8?B?OWw2ekRnNzF5aXVzRy9haStMOE13b2o5MnBibGtKMldBUS9mTVIxblhDY1VS?=
 =?utf-8?B?ajBTZTYrUlE0QkhhLzlTSG9FdHd4Q25OMmlFS2VacGduLzVCUktGUk1KRnRr?=
 =?utf-8?B?ZmVOWk1RZ256Slo2VGgva29XV0t0SUttS1lYMGtnRllCRTdLa0NnSk5CZ2Ns?=
 =?utf-8?B?Vnh3ZXU3TjFzb0wrakhBQzlYTTM1UUIrNmZDMXlGMW92ZGpZUGNxUG9pMzNQ?=
 =?utf-8?B?RDZUNmtHck9QVkFURGVNd1YxNmR2dXQ1a0MwSk85R2hYdzRwbGZvR01Qa2t1?=
 =?utf-8?B?cWcwbzVneTFLZ0RVTUhrNnJIMVhVVUF2c3NnNGdYMUE4eC9CeFpOc3hjTkx3?=
 =?utf-8?B?VGtyUHZ2Q2RTWHRveUV5ZjZCb1krbW5rRVJ6SENoa3gyODcwcG9oNTRFaDlq?=
 =?utf-8?B?aEVyelJ2VFk3R3hwSGJTV2hQRUJkdWxwT2JHdjR1QzYxK0JQVnFmWTJQNG1k?=
 =?utf-8?Q?+KHbqUVseq2Rt4P0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f567d3e8-0ddb-47df-9e52-08df1a5cf893
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 16:57:52.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98Qtl1bMto3R1Fhe95aijKtYKbUNuJFjMYswZ2jrB744153eS9WDCRHp1e4xYyO0C+XJvuEf9hcPApjHP02AVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9123
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 16:57:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24340

From: Jan Kiszka <jan.kiszka@siemens.com>

Practically, the dependency of the rootfs on the EBG recipe saves us
here. Conceptually, we need this for the imager as well. Better safe
than sorry (later).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/swupdate-efibootguard.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/images/swupdate-efibootguard.inc
index 2a7afe9d..d85e8569 100644
--- a/recipes-core/images/swupdate-efibootguard.inc
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -11,6 +11,7 @@
 
 IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
 IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
+IMAGER_BUILD_DEPS:wic:append = " efibootguard"
 IMAGER_BOM:wic:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
-- 
2.47.3

