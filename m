Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1674.1794503857182089585
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 09:17:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H0y8hU/E;
 spf=pass (domain: siemens.com, ip: 52.101.65.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA73WD5cv/yZCGW2pBzfS19d899gbWrRN7Q00mvUpmuzdPa8xl0QEQVRU8izQ8gxte68PxKgRGkAzMKFZ6Q4pExOcRIO1J27MecZWVXy9hUB7hwu+n5ro6UmQwC9gmurxmNFTYkK2vLqrbDqhdwyNPhExIJ22lxutAPnCznfTADl9dgmlgL/LjiffV2iaw2dDqeWD9CjSfHqkUOFtMxmQ4JozBSs+NfxcVrNjCbCx16xkCSO4O16jtg+s0Fv/NleywgLAMaZ1EVmGRa3RCNTJwR2IOhOCz3d86Tjz0nDUJ5tmJlQSTAKYqOTfKGXhVXM+TPbpCYhkmSN0AQTSVokJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLWgNOnemhwsGPmIvwhftVi4Qo4o04SmnxUxaHUKuAw=;
 b=vkzVVJFGhQ/819Z97mAm5h0yfbS8Rl+WHBvx8mXxLR04QGgqpOIa6JsaVgNzAAGNNUBKiPvWwlchXnMuX2vuYBgt68+WaeiwwrgCeKjXK2aDI/567LTRrDAj0Ve1DBbNn9EVAFqgov15ZUWqPEj12Mkhk621IcKZLxsNQjkL5IhYEz0BMxS8QxwVP82mLv2estmgxpaFIwH2W/Gs7+uq91jAfR4i9P4Vm5utOGL2A2Ilw2e6LozkZQ4E4JTeT2vHxYGhHKhArwh8oKq7paX+hgGSE7S2mml+vIFnZApc/4M4L1YKjp6E1KkfIS6PEBEOswpIHDZ/c3rDZ/VBaaUVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLWgNOnemhwsGPmIvwhftVi4Qo4o04SmnxUxaHUKuAw=;
 b=H0y8hU/EMVoB75EKT+VVPfuU4oMKR1UtJuHbCAecW94VkZhC76o3MNNURHmOjjgmOJjMEne2Zzodtz+GHvNx3shGe+N7OByxGyPof1UInvSMddTD1f//kOR11I9G/8Qd2tTEEWnxm7uGooq2sbiAjD6D+VRWloK1LbfZU/+R3+NDeXZqXMJLHl1rY17scm3Oi9OSTY1dKcbQvXaM5qYuMFgpzxky2uR/DiH+3/WbqUNE3GAslawJ7dfCSKrGvEDSWduvcu/0a+osPO4giHo/SIcamj7YRNz91aN0UA1JcGWOY5Wy5W/vEMV5T0f2Z0Koearkk1c/2CZnkp+c9Dl4iA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV1PR10MB8753.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1d7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Thu, 12 Nov
 2026 17:17:32 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:17:32 +0000
Message-ID: <e6f91e33-d6bd-4ab9-8d2c-69a684ca6c50@siemens.com>
Date: Thu, 12 Nov 2026 18:17:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isa-cip-core][PATCH v3 2/8] u-boot: Add support 2025.07
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1794466758-28304-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1794466758-28304-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1794466758-28304-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::14) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV1PR10MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8c6b1a-1fa2-4924-f5c8-08df40e0d66e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261022115727099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261022105027099003|261102123227099003|4143699003|6133799003|10067099003|18002099003|11063799006|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: E6Tftk5mesr7t+aJutHGhbERt0NHbiCXTcnpQV0zFAGTvVAVtEEjGOI+zcv00eUvAVR+xVbnglP8oH9a1s+F3HGE1TIn2XkqHyxS6F6zRS2Z+cLULa4k+7KRj5CxvA+PnA4HDPF/GXjqNXkY6aE5AG1Z2qlLSsLN9OaImTC+2BmbFll8GEoP56aNIklaoKHWrCYdFj3swXToOrPC6VoowChCcNKeZbPaJnO3tEzRjKKX0hSLTOJloi7vYx6NceFuJyz3gEf/Csu3apNKcOFdglkuSzP9sZgMcigQBYHZkgP3LesmhbenLJh6bRlG1TPmLQp3BsotOy3y0GyPHjbOOesMyKU8fpBkVsU3nnOHI1cnq6P0QDdQAH9Ab9Nycw5zZ7uUD32T7r1sT+tCaji7jWtCq46++ZZOxRf1QXQiqTSb+4VYbIMpKMXfKBcLAV5PkXLTO+TNeeT0sUjML7GacHPvds5xpuvCXy9EtSip9hpqKk0GVPEEZHyCwfGsmWll7Ucol06bNgflHfVVCtnpktZXFAhZ4OG6MiNukVREmwgMVQe333qtteo7i5f59kkmwjA+nKFREID6y5/6gdfwZv7e3A9b5NIzYAJTwDtvRfOPyT/D0ZZvfnjUzRWiIGfq1Jfl2KGF+9B8R10x0bHYROKW1ytlHG7Kzj18kF7TeHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261022115727099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261022105027099003)(261102123227099003)(4143699003)(6133799003)(10067099003)(18002099003)(11063799006)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti9ZYnI5a1FBT0g4UzRCc1J4L2d3NnIwdHFzNlh3dnFnbG5xU0pWbFFWYUwz?=
 =?utf-8?B?ZWJ1ZzVrb0NrU25RTDF0dTlLTHFyZlg1NFhLNk1UZnhVTVhGOUdwTzB6bW9V?=
 =?utf-8?B?RHczRVZVaDI3UlRIb3Zpc090VEcxRXlIVHRheTM2OGhkZVJjZmNUTUUzeEkr?=
 =?utf-8?B?dWE5TWFlaFIwTjdpOFhhdVlpb0hvVEx5bzYyL3ZMVUNyT1JJWnFEQ053VVpE?=
 =?utf-8?B?UkVzWnArZ0VnTVd4V29qZE9FTDBSZDFkREtDUC9YWDIzZHN6NTRFUmdvbGtw?=
 =?utf-8?B?ckVEdGFIMHRZblZUTHJLemoyM2orVmZRZklaOHNPMHp1cXl2dTQrdnVkSGNw?=
 =?utf-8?B?NFM2Y2Nhb2RCMHhjY2gwME5DNG5CVW5nOUQvVjRMRncyMlc3Qnczd3FMUzJk?=
 =?utf-8?B?d0kzRkJHek1zNlBJaDVhTSt6U3VIc0t1NGZkS1M4Q2lqeDM0VG9pR1pqWDVh?=
 =?utf-8?B?OE92aXI3WGFXU3FLWEhUWnFUem9KYWVOM1NtUmRpdFR1amVQOE10cnEyNXFT?=
 =?utf-8?B?T25MSWg0VWJnU0lxb1NnQ2kwREJQeXlOYzRyTDQ4YUQrbzhyL2RwL0pVWk1z?=
 =?utf-8?B?UE8vY3k5TVBNL0lUcEVLRmhSR1VDSlpzREp4VmtQOU1haTNvUUFuUUZFaXZm?=
 =?utf-8?B?SDZXUk5YL3JGZGZrVHVmUytKYWZNSHBTTy9MUU1TTVVlVEZGYUM1c1pWSnZm?=
 =?utf-8?B?bGRHYmM0L2RuM2JEK0QzNGFQeGdSbkNHdExDdWc3dW83cDlzR0hOZ09ETm11?=
 =?utf-8?B?N21GOFh6MjN4N3doN2sxUng1aitaandZVDZKdzlxbStEMFhaeVBFdG9Vc0Fa?=
 =?utf-8?B?eW9kckVZTk9GZmtTczJERHdhMlExREdrbkJmZTVHdEtZMkR3dFdBVVFkOEl1?=
 =?utf-8?B?SE1LRVNQUTVUSUtuRG1HQTlLQ3k1UkhEVlBVOEZqZWxCOU0vYUQ4dFhoWVkr?=
 =?utf-8?B?dTdaa1J2Uld5SVRqb2xIZW8wU2hzU0xYeWZQRVpoamU0eWxJUU8zSTBzYWRD?=
 =?utf-8?B?VXdvR2NsUGZIb3Aza08rV1FGdFlCN2syb0VTYTlTaDc5Y2hTZG9oejJxM3Na?=
 =?utf-8?B?UzFiVGI2ZkFqTFp6NGl3ejlEN25ZaFNsSWJwQ0dIQUZ0eWltU0N3ZVlmdy9w?=
 =?utf-8?B?UGJTcnNsa0JNRlZnNGc4UVZ1VjNSRDE3SnlMdEZudEIvaWpvNm9JSVpWY3B5?=
 =?utf-8?B?d2h3UkJtUElONGxzR0pvUDlyWUdkclVoZ2FTU09YZzRrOUNoSDB6ekRaTWps?=
 =?utf-8?B?Q1lwNWtENUFSMzRaR01SblUwbWhMUmFrMXZVemVTeUF2MXRhT2NqMzhEY0pU?=
 =?utf-8?B?YnZEK0I5WUJ4STlkbDJXOUh4aEthN0lXa1VpZUJML0UrblFDbTcya20wREdJ?=
 =?utf-8?B?OHcxQXVhVHpFV3c1VVMrQ2F2Y3RaSDZteStPRUVCLy9TYkxrT1M5WFR0MUVq?=
 =?utf-8?B?SU93T2dOR2QydklQenFsV3pRZ256T3lhUFd2Yi9FR1ZoQStQK1YzQmRCNndB?=
 =?utf-8?B?bHErK0s2VEhOK1pqV0YrMkZjMTQ1RXkwSmcyVmEzRXVqQWw1RHgwbkp6aTVP?=
 =?utf-8?B?YzkvZmFUNks1eFpwb2F3YW9ncGwxbGpZb2Q3RnJQY0lTWjJZUlhlWDNvWFV6?=
 =?utf-8?B?eDJGd1V0d2FsWUVtWmwvMGxUQzBnbDlxVTFHa1g3OEFKc29LVWQ5RjRpVkp3?=
 =?utf-8?B?dVo1QkZjOG56bzJtNlJ0amJKWGhDZ3pwNjNzTFhoNUp5N1JjUGlHMm9LMHVQ?=
 =?utf-8?B?R3ZhRFZFYi81Um5EWHNlcW1zbWdWVVJyM01HYzNXSHltaDczUklBTm1DT0Zq?=
 =?utf-8?B?T3hRRnZBcktoZ2xqZy91WCtndmFNMWxOWjdJRUhKQS81d0dWQm9zVDdubW1T?=
 =?utf-8?B?R3gyQWYrMk9Id3VCa2xQeEN6VG9lZktWWGtmYi9LTEJNWTJmS0Y0WFd1SzUv?=
 =?utf-8?B?Q0Z0K3lnZ1BwaDZIaEpxSllLVXpHRnlyWXZHaW1rNDAvdmtoRHpzc2EwdlZN?=
 =?utf-8?B?Uk1RMVJXTVNtTStOU3liazJ0U0pYNUJ4MTBhS2R6c1FaNmZQTDJpa2tWVXhD?=
 =?utf-8?B?R2EwakxOWCt3NGhsaXZXUHdvVEs3bllib1FpdFRCa2lmbURXS3I1amVQQ2pq?=
 =?utf-8?B?Q2N1M0JnSG5YS2pyV3paMnVQZlRhcWZtU2h0YkMybWE0VU10ekp1MWdIQnlw?=
 =?utf-8?B?d0Rzc01odStlaXhvUENNN3NtUHl1VTNITTM4L0lFTWQ3ZmlZaEMvUDlNenF4?=
 =?utf-8?B?SWJqR3ZBcGpZUmZBMGF2QjBaL25LL0N3cFJEYlQ1bEhrOStHYXg4RmtwazFi?=
 =?utf-8?B?V1d4RXVmZHFGRGtONllIUHhlM2p0YTBHTzMxeTdiWlNENWNWZ012QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8c6b1a-1fa2-4924-f5c8-08df40e0d66e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:17:32.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk5/DM/MybA75/Qyh/yrqDKlmmFRSHPaGLgN8lpWWh5Ku9w0bmSMcOTXRHFCCgoBtEiqszQ10AnN1+SBuRv1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8753
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 17:17:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24789

On 12.11.26 07:59, Nobuhiro Iwamatsu wrote:
> U-Boot version 2026.01 cannot be built in Debian 'buster' environment.
> This adds U-Boot 2025.07 for armhf devices and qemu-arm64 in Debian 'buster'
> environment.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
> 
> v3:
>   Add support qemu-arm and qemu-arm64.
> v2:
>   Fixed commit message. Change from 'revert' to 'add'.
>   Removed unnecessary patches from the U-Boot for BBB and DE0-Nano-SoC.
>   Removed the recipe for QEMU.
> 
>  ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 +++
>  ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
>  ...ot-generate-logo-when-cross-building.patch |  33 +++
>  ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 +++
>  ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
>  ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
>  ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  44 ++++
>  ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  31 +++
>  ...6-configs-socfpga-Permit-EFI-booting.patch | 229 ++++++++++++++++++
>  recipes-bsp/u-boot/u-boot-bbb_2025.07.bb      |  27 +++
>  recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  70 ++++++
>  .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
>  .../u-boot/u-boot-qemu-arm64_2025.07.bb       |  17 ++
>  recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb |  17 ++
>  14 files changed, 785 insertions(+)
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch

This patch came with the PCI one below.

>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-tools-Do-not-generate-logo-when-cross-building.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch

We only need PCI on qemu for the eMMC model. But that depends on
FTPM_STMM which is not supported on buster.

>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0006-configs-socfpga-Permit-EFI-booting.patch

Did you sucessfully test the result on the de0-nano-soc?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
