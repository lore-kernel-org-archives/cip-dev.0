Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2555.1793957794506631824
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:36:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bo6K9uPG;
 spf=pass (domain: siemens.com, ip: 52.101.72.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQjEfGOL3ZMK8uxLRtUYE1c2HYSFYSir+cPf2FaSGaynLtcQoGf2GxwJPkoIMfjJ46BiZc2CFdLVT7bunQcQaVl0tHpwHaDGJhXldLGE+me3tC6SmPoevRAoV7b6WlirE2HZvjvbwHpAP56hZOyp20GLPiosLbQQsB9cGTHuzszfXzR61qe8JHvNC2HKcAHMuBgmgYc88/L9xwiFbOOXdAKY02saeVJlvW+H71t6B4ZRX76C89m9g0hWL/NlZ/CCOgVrH5kyzY/8VhrsPT9eOZA62HQa/7lssQKvAhKjwDXLXcLLlWVZ/36hyDsAuEOxbKmfPDC8/CfgMSDmeJrB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wMzg+J73N9rAD0XgAndsX3noDyXS6O8ATzzweFx8P4=;
 b=BUBT2yDsIN76jxAxgUs+DKPGQ+J9VC1f0MPXGpqtQkwX3ECvalQmik+dEBTT7m50Sfoi1mcLTMJAlZgftJnnyR7bWFxGj1uU1eUp1xXpcRvHWD5b6yAfuLjf1h/dApTjVUFd0ipraJPSt1H9QliV/iLEON8TqxyQeicdwsxs8zFPXh1z6LSgavNUlnlJAsAJOviZCCYM5c//VevjXEo3vOQiNnhKjaCtBZ6PPql8uBummv/AlbrikmZUgKWS3K/Wwg2tMDQ/ZS+vSC3wA7ENBVp+8F/wkeDwf7fT2s8MhncrcXgSeha4M9SPeN5XU/PkLHE3rsw+OiosMUDOsGG9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wMzg+J73N9rAD0XgAndsX3noDyXS6O8ATzzweFx8P4=;
 b=bo6K9uPGhlw2Rou5I4FwBWG1euNAGptlwKeSHxz7zxW1ucoQwT4d0z5q728jEeX8S2jmVujKM8vpm+buXDy3Z07m7TY1UAGzMrRpMvdbDuqk5zl6HSQhSk3mld4e/qnNdJT1aWtCEK1cF3OvcbQutxm7C22V1G/VHvotqNZjwuCnwfLF8bY/ywITE8UGl62iIL9rgpKtN20oaujTKMklRmc3/Ii3llbgxLpNW2P1clR5tZrAsjMudfPOskov7OlJuvmuQKr7r4kIjwZUMQXJSccRoPSpoiXekWs9fwivWq0/1DP2ABU+vRqEZWC/ozzYCDlyJMEhugD/o6JudVlj4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:421::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 09:36:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Fri, 6 Nov 2026
 09:36:30 +0000
Message-ID: <c78acef7-13a2-49b8-a8bd-3c54715e0ec9@siemens.com>
Date: Fri, 6 Nov 2026 10:36:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC PATCH 2/4] u-boot: Revert 2025.07
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1793956065-3316-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1793956065-3316-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9534a41b-cc8e-4a05-7338-08df3be96fd6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|55112099003|22082099003|18002099003|261022105027099003|4143699003|11063799006|261026121527099003|56012099006|261022075727099003|261026140227099003|261009223027099003|261028144727099003|261022115727099003|261021121427099003|261102123227099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: kwFSJYTyqRyhoWIEvOM3YBkWKuiyXMwirkj/SVDgyXaBDm3ptbaVy0H045e7hYM/CTDsli3cNSiODBSLWAaiNFaZt0eKE0RMRfZ10XfYm+J6rYCi6CThxbnf+754ULnDdVHFkbQ3EdwtD5tNh66TyykjoB5TsVsYKZbVUXp039Cb6fEhsmershl/Wt5MGylzqiHd+gF1CLLOh6bMH9Pgn9VR75bgnJTLQZRu32lSGqHAdtuaYYMzKVAZoToQoTtKYHTIsGB7TCgvUcIFwXSLJFwHfptwaA43MzeTkM6gOYY4Dc02ITLntCn/Njirh8QiE2xbH0r4YG0CbeC4ZIQJ9AlfmjIX9bUEWo8V/0VNehbW1GP/UPjbYB+gfrTtUi+7sgw67cUEgRTbAG2IESiOhMvzACpOwlwnCEQw6zFPdi/D3IaQ0ksVUdOQe5Vjrj2rRFjd7t1xBaT/foMUeCwsNZXxGjPMJGzHWmaU27o75rsPuRIw4tQk8jyMZoZDlNzDQy/fTizrl2NrnXEdPm/VRiulyzDgkt0YFFSK4vau9IJXOeEVhLAfbl4bNTkeWTjIRO9KgUzMWm4dWgaMcLX4Gd273RIq8vDpruflvf3KpY39+Yqt+vuyJlGQ6Jw1YtrUOZ9BydkuZqrAjW/TfX02n5uHF52czqWdVLy4/7AIpqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(261022105027099003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(261022115727099003)(261021121427099003)(261102123227099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy8vL1ZWdll4bnJBNVQxSmZyQmxzN0tVMi9kNmFmcHhCbW5XNUwwbGM0aUNN?=
 =?utf-8?B?LzMzTGZVU0t4aWRpM3BONGtiL1krSjdVS28wSXYxYWxSeVo0WkhTQzJ2emg3?=
 =?utf-8?B?Uk9SVHZFOWFYVU1CUVN3cWUxSlRKMzFiaFJJeHR2eWc0TEJERkdhTi9xbEE2?=
 =?utf-8?B?VXloL0NIdWY5eTZjQlcwVVpHS3BaYkdWbDQ0Yk51TGpOK2NsU2pCazhWRG9v?=
 =?utf-8?B?eEw0MlVvczY2OEJHM3hpc0RLaWdyY3NMWG8vMmU2UFpWNm1qNEV6NEZ6N3RD?=
 =?utf-8?B?aGZsNnhPcVpsS2p2TDVUT0J4cVBHZTR3MkVoSmpUSUV5bDZ5QzBuK0g2aW1v?=
 =?utf-8?B?VlRqNWp5UlE2N2Y1WlVOVTJIaTdqUFJRQXJQNXgxaThOb2xmVmVnWTFFV2gx?=
 =?utf-8?B?WFlzeWpYcWdaV0g4bFRRMVY5ZEthNFNFWVhJN3pHbWQ1M2VEckZJZkxEWUhq?=
 =?utf-8?B?RmRFaHliS3pmNzAwbUh1ZjdkNnBCWVpMakQxcGY0K0xqV0pUc1FQdUVpNVFT?=
 =?utf-8?B?V1RnMml3RzRrT3pXR1ZiS1prTFBuTUIzYWIxMldTcEdGaDIyQnM3aDdsQlFj?=
 =?utf-8?B?SHhVTVVXKzhzb2RyMmlUSUkyRG1BandURGxnMEpzNm9WK0FhNEhxWm5QZWQy?=
 =?utf-8?B?TEQ5NUU4S1ZHeVJYeHEwSHhVSzVNa0hNYXdjTEJ3N2ZJU0ZQalVMdklVRmtN?=
 =?utf-8?B?UThuNmJUV1VVQXZLUTBNczR2cFpsODRRWkpyRFdVNXA5dVJmSnQxSVIzbjlm?=
 =?utf-8?B?QWd5NnNxWTFUaExCWC9WRVNzRHBMWjNYMjE3anUrNVZEUVRpWTR2ZXc3VkFo?=
 =?utf-8?B?dkgvUXZGYjM4aXZtaE41Q3U4VUVGMnFpb1ovZHVLb3hwYTlURzFidmJ5YnRZ?=
 =?utf-8?B?VHc5OFRRUEVuaWJubjR2VWlqSmk5dzdacmowTkVWcWkvbkhISGJ5Y3RreG02?=
 =?utf-8?B?V1hhQ0R4UC9qTGhHU1JUcTBEdEo5czlaZCt6ZW43eGNsL09pWmdrRkRtVFYy?=
 =?utf-8?B?VWdZUFZGcnJMUDhBZUlEUU84L0VjcWJKNzJsa1MrM2xaZnRMUXFSeis1clFR?=
 =?utf-8?B?UTlqYlRNeW5TNHd3WUlpUS9vaW5HK1VSRTFseHhjdGtTeEd4ZEVaSDAwdkRq?=
 =?utf-8?B?VVBybEFPQy9LckF6UUQwWHBiS202a1lEUXluRGE3b3BqSlFtSVkrWUYraFFV?=
 =?utf-8?B?c0VWbFRmRFF3b3UxOVUzUHlUWUNFODJ2Mm9uUUtHcGNSdGVwUDAyUmZKdHNu?=
 =?utf-8?B?eXZnRG4zbjVoMXh2NEEzRjZwVFY3SjZGZTJQVlJiVWczMlFlbWRORUdBMmpC?=
 =?utf-8?B?dVduZlNPVTJFeXVTaS9jZ0VZUHVmc0doQlB6VmZ0VEtwZlNaZGs1bUFJdmxw?=
 =?utf-8?B?TXVCaVRFS1lwRFpFRUNoMVhvWEE5QjAxNU5oekxNQ0p4SUE2YlBCZmpzVDJE?=
 =?utf-8?B?dVhoSUQvTDVEY2gzc2RLR09DazFOWm52bkVla0oxcDhyM0c3RGJwQ1RMNDZi?=
 =?utf-8?B?QVpnQ1o5MU5FZVVoblpXN09uajluUGUydmlCTWhoMHRvekRZaFNFelZvN3Ju?=
 =?utf-8?B?aTNIMU1kKy9pWHF0bVRKNEtYV1FubWx0d2QvQzF1ZWFWblY4dVk2ak1SVm1R?=
 =?utf-8?B?OFZYUnhWU2c4OW1pVW1qSWdTNmhMZzBrNGpJRXlFV04vQm5oL2FhTll4cmgz?=
 =?utf-8?B?VW5PUXZNUEdoSS9UTnJTYittSFY4Nld6SlZ1cnIrYmhIRDJxNFA1bFY1a3R2?=
 =?utf-8?B?VTVpRTNCbkZvaTNOZVVQR1hJR1NHaEtJNEZXdWs1YnNHUFJZamxiVE9PNmw0?=
 =?utf-8?B?MnhuR0ZMbTdqU1RJK0hoemd0eE5vS0lMRFdtRS9KdzMyRTlORi9sdlVaQkVZ?=
 =?utf-8?B?ZlBSa0Fqdkh3ZWhjL2RTV3ZzbUxJdXlvK0xxTGtIeHEyQStzMDVqMDhuZGs2?=
 =?utf-8?B?dkhsQTZWNndoZHRjSW5rdVQwRENBTjBDazN1WUNnMko4Q1h1aXdEU0hDdGtP?=
 =?utf-8?B?RVlZMDFMQlk4dVFIbVB3TnBIYmZCTGpOQ3AzdEFxZWtHVzMxUGg5bUR0cWk5?=
 =?utf-8?B?R0ZtRzV2ZmJKc2R6RlVUTmJ4NVFHbzBwSTh4K3FKV2NoekVrTlNJS2xqQzQw?=
 =?utf-8?B?Z3VXb2pBTUM5R0dtcnVJdFFmOUpiZVA1TjF5ZDhyTVFVemQrMnhKVTZ3Z0Rh?=
 =?utf-8?B?dUdjeDdmN1B2UzRkcUFqbzRVZHNSekJPRmZTRUZsQTNzYVBNcU0rUUo1L0FG?=
 =?utf-8?B?anU1REZRM3pxVUliQ0JsZ3NVZ3oxWXhmSE1BRFNqRzFTQ3pRUTF0STdNamJR?=
 =?utf-8?B?R0VMd0F1K3BXc1ltQURiVEJYK3Zabk5ON2dyM1JmVmdVNU9sdUxWQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9534a41b-cc8e-4a05-7338-08df3be96fd6
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:36:30.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kjv1RYXm3oFWHmoiZm6M8xxIr6AwfLkqgpip2Ts5bxEc0KYDD/Sllj0zZqHeb5VnRSt6B5l8IdDJfaTWGu5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8874
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:36:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24663

On 06.11.26 10:07, Nobuhiro Iwamatsu wrote:
> U-Boot version 2026.01 cannot be built in a 'buster' environment.
> Therefore, we are reverting to the previous version, 2025.07, to provide
> U-Boot for 'buster' environment.
> 

Ok, this is not a revert. It is the addition (or re-introduction) of
U-Boot 2025.07 for legacy target configurations. Please clarify your
descriptions.

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 +++
>  ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 ++++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38 +++
>  ...ot-generate-logo-when-cross-building.patch |  33 +++
>  ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 +++
>  ...sector-value-passed-to-mmc_load_imag.patch |  39 +++
>  ...for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch |  90 +++++++
>  .../0003-test-Fix-optee-unit-test.patch       | 134 ++++++++++
>  ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  44 ++++
>  ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |  31 +++
>  ...6-configs-socfpga-Permit-EFI-booting.patch | 229 ++++++++++++++++++
>  recipes-bsp/u-boot/u-boot-bbb_2025.07.bb      |  27 +++
>  recipes-bsp/u-boot/u-boot-common-2025.07.inc  |  71 ++++++
>  .../u-boot/u-boot-de0-nano-soc_2025.07.bb     |  26 ++
>  .../u-boot/u-boot-qemu-arm64_2025.07.bb       |  17 ++
>  recipes-bsp/u-boot/u-boot-qemu-arm_2025.07.bb |  17 ++
>  .../u-boot/u-boot-qemu-riscv64_2025.07.bb     |  20 ++
>  .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     |  64 +++++
>  18 files changed, 1042 insertions(+)
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0001-tools-Do-not-generate-logo-when-cross-building.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0003-test-Fix-optee-unit-test.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0004-arch-arm-mach-socfpga-Adjust-a-raw-sectors-for-MMC-l.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0005-configs-socfpga-Fix-de0_nano_soc-boot.patch
>  create mode 100644 recipes-bsp/u-boot/files/2025.07/0006-configs-socfpga-Permit-EFI-booting.patch

I don't think we need all of those patches. The two targets do not
support secure boot or OP-TEE, thus anything related can be dropped. I'm
not even sure of the de0-nanosoc regressions were already present in
2025.07. This needs to be tested. BBB will most likely be fine with the
vanilla U-Boot.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
