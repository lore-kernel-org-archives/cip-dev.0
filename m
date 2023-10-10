Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A944ACD690A
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 08:32:56 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web11.86191.1696926774115513218
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 01:32:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b+iLAtdA;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dslPqgRpxPR2c35Vu/ScweHiyF1b1Wacch0EXjroejQfNxNjtfO/QVdgOwRWCQMROTjpPJx9L5wvlDNLkNimSOoDVpuxCptGVgwv/kve+wSg1vYxI1qaczo+PCZnaQ4Xnr4fhTSbVQ+DXMrdNHu47y/oiOaN4Qz3nK0cr6AVxu322AXTbAmAlllGiTtAQLAFuXPa8+w4F6ZkvCxwIBLoaQ1AVkyiisJX9Tn4VlYH4PGSomIOEul5UN+1F8U6zrlxcgSOP2vpfuDC3HcHmQ3ZgkmEj7ESJajMoMaI1rp3GPXqCpkCG+6KwVsexzFQ5zSekC9D/lPH8OwLR/i5ODKC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SO0ZG32Q7P4vwpmXws+J6N8RWBxq0g5U9Uy3ILL2tc=;
 b=eUrLAekkcaN3taBqE7HaFf7Mlp0ydD5zuvBl6fsE+wJUMXyO5ZW5zMpeYcI7Nx8JYw1gs8X5G7LCYOUGOLH0s2Ks3CV+atUjm11foFTgCXhZmFCoxmlCoII4j7YaOTdJF0wOBlZ77ZulKm9Ke6I6W3E7XHU4s04LRCI5sCbcC8AfCuQhCmOOs/6aroSDEyngRxjfrZ6GrjuBrHujc+Ng91gg6C1Abn1Z6jWqViZh7tt2A4Jq/TY8Wlhyg9qK/3yzBhqTHL8EK1iLMUu8hOO9LLseIt2a8gDDPcWstDKRoABTUgT1/Dj3aTTXATQSmS49yyeXldONXturSjxJ60Vw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SO0ZG32Q7P4vwpmXws+J6N8RWBxq0g5U9Uy3ILL2tc=;
 b=b+iLAtdA+3klDsO+HJJwu/rwpguIOw+vVCGHuD/L8aZsuk1cvpy1jL+wFCMIJXX2pk/kpeVIR4in49aOkS9fWZCyg9nNyCwmnLkGkdUu84xVsp7HqE7NQbXIIgCNy8QjlPXaGS6FxEXTQNEo4bI50uOddABQh8dPpvJe7J2ymQGiVq5+RXh+S04Rr8nNo46CfTAk4rGSUyC4l07BQ3mpO5H4uJl5jZwIWD6Va6icaw3MJW8mRP1BAQiJzb/VxtjWnRQU8gsAycoJvXhI3Dnav3xn3qEcWaxeUU6Zdyzb2Lz/RfWhwgLpsvc3i9kiE2O2Gr4UNZ3/D7x9BoIbE62Zig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 08:32:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 08:32:49 +0000
Message-ID: <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
Date: Tue, 10 Oct 2023 10:32:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, minmin@plathome.co.jp
References: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:610:e5::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4396e395-5f92-476f-d9af-08dbc96b7c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tRNUL1vdzrHUmO3FHGNTodw8FA88NSCoSovbY2U5qHB+IQz93gv54+Y+lWKBWAYb344mMdJLmxDxrIdIfa/NNSuXXgcKBiIGXaW70F58oq6g8Mug6XQ+zxJfN7hxtQrnYbJP86QR9QRFzrrBkKk8YHPK7/hudbKuQ3n31AwHusISRAX0maGkRWBZcGGvm2zIlF5M3Q2EA1BbFylciOEbOKLDwafgAV9+2HN+osCzFAiFm2vbYZIHE+XFaIm8VMqoBl2y2MlTswZca2UHPVxsFkwDEid8OrzhcuCBY+l/SKl3genjs7OGyjTWSkr9DPgIF3bo+Ftx0bHVS+g/4uO9DBgURYwU2VwpUjHVNWIZJ3STjtjK2noTsJF69Qlanfavh8ewyaLL8W3XuWtzTfbww7ci01KjAKuNIlCHoLa8lYwj4jnPkjGgN9Yhn2xK8DyHtu/ZlqTQyU+ay4nNr4mxWNF0v4gD8zJWbxntOIeo9YsDK8YzoJhQWR/+GPIRODZ24lBv3W4veoURuac2qe/1DFj4eO+dsQp0KZJ2tk5zcVtBPNpcDgoaEAg15rcbTsbK8xnwwHLd2wXVOUDOrS8r+1nrT36uB2ff/7IDqQFcGrYOWW3xkGWi+TbTRwlKJa9eB1Y+B/srESXTl7gYGI1xTw5FpGmmpsjIf8gH3Eitd6c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(83380400001)(6486002)(6506007)(38100700002)(6666004)(2616005)(53546011)(82960400001)(6512007)(478600001)(66556008)(66946007)(316002)(41300700001)(66476007)(6916009)(31686004)(5660300002)(8936002)(8676002)(44832011)(86362001)(31696002)(36756003)(4326008)(2906002)(151773002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkJuWTBoK1VPV0FHOThSQnJLaW1jTWpqY0Vkc0Rqb3dESTNqdjhlcTAwbGdG?=
 =?utf-8?B?d3VsNnc2Q2RRVWpmb1dGK1pqMlZRNzVZT0x4eDEzZS9yN3hmNGp1c1VINE41?=
 =?utf-8?B?Uk1pbXBEOEZLYXVBL1czZG9hdmwrUGNmTWJ0blBLb3M2ZUNwWVFVNHBWN2Va?=
 =?utf-8?B?VG1XWWxyTzJuOGJUSkhGbjIzU1pRRTlVYVBxeVdVUjY4RHdQM2hkcFlPUWRC?=
 =?utf-8?B?U3dGSEhrSGoxNzdYWEdCeW9WN2djbjNFb0xDK29vdTdaV0NOQlBWTHZ6TFJO?=
 =?utf-8?B?M0k0bDcrNTF2eGdjdWVORFBVTzd6VnFZWVV4L1NQQytJNEVhUmZWbmJMNnRD?=
 =?utf-8?B?Z0l2dE4wR0MyblU3U1IrZUJ3TERSNkljbk12N0dpZXBBelkwQ3dyRHBWSUJ3?=
 =?utf-8?B?Rm50QmJ5bEJqYk0ranlhRmUvUkhxcENHL0pQTVJIZWwyWTVpR0RmZ3JnNmhu?=
 =?utf-8?B?YXQ3K1hIWHhvRjBUSE9EUXExdFhLSUdyek0rWk9BQnNseW5pNWFhQ2c0MVFR?=
 =?utf-8?B?anhJWFU4ZkwxWUVsVXlUcm0zdU90cUZqQWNvMFVJblhQNzR3V1ZKYlczT3RO?=
 =?utf-8?B?amVrVGJUSEJtK3hKSjZKTzRXWE5SZk5qcEF6VDhrc2dYTWxOa0UrUlBhMU5U?=
 =?utf-8?B?NEhMU3ZHMWVIQlhVSU0vTTdBQ3ROUmxwWHFUSlEzT05aaThJMU5WV2dhNFNC?=
 =?utf-8?B?blpjdDZEMldDSW4yRHZqY2hWWXd2WEZwcUx3YjBobXYzc3NmSFRqZlNoMUJn?=
 =?utf-8?B?RmdoeWRYemNLMDZmdWNqNWYzWFVjWXZRUFJNMTUxR3FmV2U5N3gwbzdLY29n?=
 =?utf-8?B?U2M4eTdORHZFRERYQ1JxODJtNTRXRWF2ZlBhMjJISEtSWkpUbEQ1d1lkMVpG?=
 =?utf-8?B?NnlZWWxWN1NXNW5KS2xwNml2aFNnaWlBWGE2aWh4RlFnMEZ4ZEQ5YXhSbGFC?=
 =?utf-8?B?ZjNuQ09IMlFReHRlcnRzcW9FbjBkWHM2L29XeEMvaXB0QTNISWZQaGFaL09D?=
 =?utf-8?B?azd4dGFTWFlBZzhhamhneG82RHluVlN4YUd1Z2pRdmI4VlNaR0oyaUk5U1FB?=
 =?utf-8?B?eVJhMUtoM24vQzc2aFdpcUVoaGlBa1BIL04yelJicUJONk11aHY4Z3N6TFg0?=
 =?utf-8?B?L1hsRHA3dHNpZUU4S2JlYWF0ZGQyR0xlRXlzSlhndDFYd3Fhb0V5MTdoNkpJ?=
 =?utf-8?B?SWl0MlVnM0cxK2pYVjdmWDZXZE1pWStNMWNqL2RKMmlITkZXbFlCWTRBS0wy?=
 =?utf-8?B?RGtpUGY4anJST3RFNWZ0SkQxWnhJSmN1RDJ6aGRwaUZTcGNTK21SdDh4SWt2?=
 =?utf-8?B?cVVaVkliUEVpUFJ5WnMyWk9GdHJ2TXVxbkh3WkhiWGJsR3FuRFhTNE5WdnB6?=
 =?utf-8?B?MkNHVkRpeXA3UlRsOEI5MXhCUW8ra1duckZHZWZ5SDhPenA5dU9VY1FKOEV2?=
 =?utf-8?B?eDAyVVVDeHFrYUZ1cnYxTEVMZ2Z4MzJPbmJ1ajNKZnBSWWN4cDZvTE1ndGw0?=
 =?utf-8?B?KzZ2alNRWmxDSVoxeGNjcGRTME5oWE5ZSWZWSEJ6M01kdGY3K1ZDeG1pb250?=
 =?utf-8?B?RnA1RTNVMXl3ZWR0MEMydkhXT25MQngxeEhNS3lQWEZuWEtVSjBRNHBIVjU1?=
 =?utf-8?B?bk5CYnFPSTZIVlk2S1ZNZDhZcU1KRkNRcEZZRm9XNkp0Y0JweS9FM3EyN1Zw?=
 =?utf-8?B?a3pXTWZ1UWtyQXVPTHZ0QjBMdzZCc2VWR0R6SGdCc2RwRjNuVWxMQmpRdDFC?=
 =?utf-8?B?QndaZ0YwU1JTMnNRandFVVUzWTRYZ2o3M3JORkpCNis0WkxqQWk0TFhWSit2?=
 =?utf-8?B?V3U1YmR4YUZjMlFYdzMzbDVsYVdBSGRodDQvTys4ZTE0Sm0yTms2cmIyVXBR?=
 =?utf-8?B?VnhoNVNzVHVLSTlmY1RCTitlUUpMVkZiK0RFTnFTYjFna1BlV0xYS2NUdHZJ?=
 =?utf-8?B?L0lyUXBnQkcwU3lPUE1oNXN0eFB1RWppY2FUS0QvQ3ZFSFNxMWU4b1NqSm9O?=
 =?utf-8?B?Y2t0aERrR2ZKc3BGT3ZabHJhNUJpRTV5NlhCeTFoeHhTQ0RGWkdWWFRyYi83?=
 =?utf-8?B?eDNWNFl1K1RDdXR2c0s2SmpDOG5ZWFZ2Z2hXSEZ3anRydDZtVS9xRjhWSHRG?=
 =?utf-8?B?OGk3SG9mNWdibmQ2ZkZ6UVJMV2hCSGg1VkhUdFpYNlcxKzlpTEN5UGQ3eE1U?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4396e395-5f92-476f-d9af-08dbc96b7c90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 08:32:49.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Od4lG25nADkDftPYwydPpvvgLsb9DHNcPTNmOTC01oLbBhsrkGU/PVnX3ilRuzzNbDR2VVEJcJPfwzV5XL5lLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 08:32:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13345

On 10.10.23 10:10, Nobuhiro Iwamatsu wrote:
> This adds configuration files to support Plat'Home OpenBlocks IoT VX2.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> 
> Note: This commit depends 'https://lore.kernel.org/cip-dev/20231010080305.3762206-1-nobuhiro1.iwamatsu@toshiba.co.jp/T/#u'
> v2: Drop patch for wic/openblocks-iot-vx2.wks and use x86_64-generic.wks with WKS_FILE.
> 
> ---
> 
>  Kconfig                              |  4 ++++
>  conf/machine/openblocks-iot-vx2.conf | 16 ++++++++++++++++
>  kas/board/openblocks-iot-vx2.yml     | 15 +++++++++++++++
>  3 files changed, 35 insertions(+)
>  create mode 100644 conf/machine/openblocks-iot-vx2.conf
>  create mode 100644 kas/board/openblocks-iot-vx2.yml
> 
> diff --git a/Kconfig b/Kconfig
> index f5ea5af..be8bbc2 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -67,6 +67,9 @@ config TARGET_QEMU_RISCV64
>  	bool "QEMU RISC-V 64-bit (riscv64)"
>  	select ARCH_RISCV64
>  
> +config TARGET_OBS_IOT_VX2
> +	bool "Plat'Home OpenBlocks IoT VX2"
> +	select ARCH_AMD64
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -79,6 +82,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/openblocks-iot-vx2.yml" if TARGET_OBS_IOT_VX2
>  
>  comment "Kernel options"
>  
> diff --git a/conf/machine/openblocks-iot-vx2.conf b/conf/machine/openblocks-iot-vx2.conf
> new file mode 100644
> index 0000000..5c144a3
> --- /dev/null
> +++ b/conf/machine/openblocks-iot-vx2.conf
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +# Copyright (c) TOSHIBA CORPORATION, 2023
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "amd64"
> +
> +IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "x86_64-generic.wks"
> +IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/plathome_obsvx2_defconfig"
> diff --git a/kas/board/openblocks-iot-vx2.yml b/kas/board/openblocks-iot-vx2.yml
> new file mode 100644
> index 0000000..6951e2e
> --- /dev/null
> +++ b/kas/board/openblocks-iot-vx2.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# TOSHIBA CORPORATION, 2023
> +#
> +# Authors:
> +#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 12
> +
> +machine: openblocks-iot-vx2

That's still generating a separate image. Can't we consolidate the
differences, like you already did for the wks file? E.g. have a kernel
config super-set?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


