Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C0CC61DA3
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 06:11:02 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web11.27596.1678083058100011236
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 Mar 2023 22:10:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YKxSZfy1;
 spf=pass (domain: siemens.com, ip: 40.107.13.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLDGI3wnAL9SzVJyXdMMz4QZ7BI1H64RPpyiTgePpwb7ltnqdJSxkbr/HbPETiJax5TyFFQ7x0qLkP2zKfj3St3FHwVrNr/fhDd/WoTlWxXkjrq+6Q+ZbXASx/OAA1LnCZGlodOLBccgfusAT28J5a9R5x5VbptTmxI+Zighb8Zl+AFP5hViAJQvQhqde0iVUETzjYWHVQUTfloQHxdG9RHHOpHzj3W5JAK44eSkB6oYUDaywMzGaHdfeJ2/sq1rbHba/7mAnSxjUuhrxgA0fxA/pHQOoLs40pLHysNFOsXtIhiHkpX33IzfNsZ0t7jhlPgK9jbozz6I+4M3gybOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wvA1ywfW3erIHuFy2UO9zrKPsAdi+IkqMSj2z/FTKk=;
 b=MilE/vhggyp+Qs68IfM2nskZF3OBNQ3abn0Z0wNnIBfkFA16gUdd5dLvGQEQqzn/tmf2MKiwxHyF5R7Jdh1wEfgjynbe60BJlREmZeUhD/BxJ21RLQgccgMtmXr7QBXfZmEmAQQuXnYmaT3WsWN3XyKJqPxDEV0nNnhnAMbIujwCfspoksz1Ov2UhPJW6qDh5Mab+THx9n/y/PPJ6MoH/ebwvL3H/U67zIKjIVg/cGAC79nJPa9fWnDp2D8Kcf/0vZA10GVmXBAndNzz9WmF80akMFHqylCn37TrHrdIcpEuttJCQSHX1EC1tFh4R4vAic3avTrHjFj0pSeagZAaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wvA1ywfW3erIHuFy2UO9zrKPsAdi+IkqMSj2z/FTKk=;
 b=YKxSZfy1nxjWltSoMFh80QZmcJWYlhGGKjmqWZFW2ZZ0Nn9VIeYebKUXTD1HhsfG9ceS5df1Ya2vN5Dto1JkdDNTi19r54JEWjkcLVY1S5kKv2BgNiTcLEbe4NblKyCNpcCgpjnqzpDHwylmx/wP3BauB1RMgzjD2BHOfwo6nYkLBlKsnBJJF4lx37HfL/gu41CZgEBovANevdXdfCQxEK2YEDNZ9AJyb1nkU9rrP+IILyxrS1q37osOfaehP/kBkSSJQY4teshcwvZgqLwWRTWYY/IhG9dpd8F83y2aLp6ChMS4E/G2ROrIeajZ/IBpe5QiuWoeRAfaQLVnizOCjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15; Mon, 6 Mar
 2023 06:10:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%8]) with mapi id 15.20.6178.013; Mon, 6 Mar 2023
 06:10:53 +0000
Message-ID: <b11649d3-74d2-b170-ab24-369fd829b5eb@siemens.com>
Date: Mon, 6 Mar 2023 07:10:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH v4 0/8] Add swupdate support for riscv64
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230303124820.2209954-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3913:EE_
X-MS-Office365-Filtering-Correlation-Id: c414373f-da0a-4272-e508-08db1e098ae1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kTcMOCM4YqJn/eEzqyueLFFaOu9LJv4AVvXgbi5j8SHREa/+fFGaXsdDhsT8b4yylU/8yWA+vKA24KBTlXhikfWfJFGY6vOuG5rpbR54RrMAdLk55jlV4qjXGsRDMzi+711e5mAeyi0gkc4tjD946nNgq+V4GIllom+8WqSwX7Q8iNY1Ne0mJ4hl9AfhO/yMHjAMvQocLPJIBYeLSMmsiwibf+AK3b2PT6bbjrzuOymGhYTYMkIwnaaNmy94RdXGpa1G8Bot1AZidWAGh5PqwXVLEltg4fLf+RJ/AIRGbdXvm1xEwm9uwjs3LXUy1tz/2Qi2TLxrljBB9WkMZHqyNKdJEZNQOWMZpTkOeyDbBB3XhtphW/ujL26Z64Ig1BHnuiZzjC185xRkDfy6uzXIH4WB6tb9MRv4WCEMUpnLQZMh3DKvtM4wCzX0Ple78RuvX4BM4K+H0+y0Tc85yqXeyo2D38IvVS2lJg493D4T/4K9PZ3ins3k6GqdKdFUXDNatjfKh7AqFlbOS5CERPfKik030cofY8s5/j3Xv11Z6g/7V8ndq2gdo4nHmkl2cXA1qfudDpAvgcUtuCHqyxqbaBBetd632/frA6MIuKGdfg0tI5zNYcV7xrCHvWlP0dNOnyeWTPz/uhOGYbjdVufr+TiTpVh0AVqv/vumGF7XjX3Pk8xDVdMxHdKKXasyo28DI/8AiP0oxW0viEevmd0P61eXAWcEbTRSFRrBn8+BBzI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(36756003)(83380400001)(82960400001)(107886003)(6506007)(6512007)(53546011)(186003)(26005)(2616005)(6486002)(41300700001)(8936002)(66476007)(66556008)(66946007)(86362001)(4326008)(31696002)(2906002)(8676002)(5660300002)(44832011)(316002)(38100700002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zmo1cmZ0RlNiRWJiMVowRWErRG1kZndZajVDcnhRN3FwclJLdFNLN2tqdXhE?=
 =?utf-8?B?SHlqUjdJWHI4R3F5TnJZRzMzZU9DM0NYZFl2V2luUGUybUVWNXYyVUo5elRI?=
 =?utf-8?B?bWQ2WlR4TzVYcTlmRUlkNm5vYzByZmxNcm56MXprNkp4UFFGbVJVcXlBVkdT?=
 =?utf-8?B?QVlHMm1yeWo5ZlhNRVEvN3hVemVUSXRtbG9xU0xvcHpOeGUzM2tpby9vTTBm?=
 =?utf-8?B?YXdjMmNFbkQyTGI1VkUzVHFFd1VhYS9CSGw4TEJvWkk1Q1AxVk5WeVViQ3lt?=
 =?utf-8?B?M0ltSUVWUjdlYTU0MHJJNENCczYxWUpIUHNKaVBsdVpJbktvaFdtRUU0T3NB?=
 =?utf-8?B?T3ZkeG1DMmkwUTdTZUNYdHYvVWtDUm84cUtVUStBVTBXNFA4YWowdEczaFBZ?=
 =?utf-8?B?aDhRdklDKzJWcUxLMmVmMFV3c2VTVXlyV2ZEazExd2ZSbU4rbjRBRnYyZnda?=
 =?utf-8?B?QmNxem0wQVlaOFZQRURRSmN6cUhaWGJScU8yYjZjZVRFWXJZSm5VSDJRN1BV?=
 =?utf-8?B?cGJnQkJXQUdiczkzaVlYa0wvckRHQVVxYmtMdlo0dVFpWWcxSkFhSER1ZE1X?=
 =?utf-8?B?ZXRIOWFzRUw2ZEVCaGtualJwbFNxYWxNVWI3bDlPSnBIWU9aOVRuTVYrc1dU?=
 =?utf-8?B?VmhsREVpSmpUOWtEZGtXTEdITjAxQktLeHJTMmZvdkFLbiswU1hFYTh0Yncz?=
 =?utf-8?B?RWk4ZHpZUDFmUGxQR01vc3JWN0R1NGxSaGFpM0hUUUpCYzNZTGNmdHlyOXlY?=
 =?utf-8?B?a3kxSGd2ZE1qVitwK0c3WTc1ZFg4aTRiL3FCb3ZhR3Axb2ZKTDdLUzliWmtY?=
 =?utf-8?B?VDVYYzJsUUdodzBiejRCTFNSNGZEdVVNZnVuckZ3NEtSbTB6Y0lQdVZYTU9H?=
 =?utf-8?B?WjZkTm4yUEVNNWRyRklET3QvSEV1TXVqelJIRFVtejBtK3hZM2FweHJlVldZ?=
 =?utf-8?B?U29EcWZFTTlxMDRBRmVSZHhlbDFjU0krMXJRSFdKdjBJdzZQeHJsSEI2VmRm?=
 =?utf-8?B?MVRJQWFFRldWNDRZOSs1SGVVNDI1dFFzQ0QwemtFMHM2WE91dVFZNS8xRzFa?=
 =?utf-8?B?V3VUZTFMc3djT3JKeHV1Vzh2TzFtdzV3bTZkNnRLNnpuK2pJdzNGL20zOG9B?=
 =?utf-8?B?OWJZZWVjN2UrOG50R3lsWW9ZMTBWL3RoV2F4bjJ0TFIyajRKLytvS1hIMGlO?=
 =?utf-8?B?MHk2TlM0Znl2OWFuSitXWGFGTU00YkRCbTNhQ0RraEZYVS94ajdGMm5YU000?=
 =?utf-8?B?cWtSbGhRWFNFV2NTTWVaZDNyMkk1cy9Ebk9DeE5VSzNjR3NITnlNdGJ6MVZr?=
 =?utf-8?B?V05yYVpMTHZHdEZVWlRWSVBDMHBmRUJkakhnNG81L0EvTUJidE9xOW51Ykx3?=
 =?utf-8?B?T09pV251WitBZmozakxvN29hYzQwQXpqaWo3YjNkazVjL0FqUWt5aDJEMVFP?=
 =?utf-8?B?T09yRVZlSG9YRGppMFBYYkZ5dkFuM3JMTDc4dGFsMWtDVzRRcmN1RzJDZGh3?=
 =?utf-8?B?eXlabjk3amFJajNNNjFHQWNEYW9TMTVKN0k3SlZUcS9yQ2g5LzJIYlFtQ3Fo?=
 =?utf-8?B?RkNRVENJNnpvL21mMkpuTlEyZTlsQ1RPbHV2VFFaRXh0dHhvVG1IVW1rTzhw?=
 =?utf-8?B?OUhwbzZNL0ZtRmdWcjk5TjZHYklWY3RneXF5dXd4cHpyOE5teERxdDBiZG5l?=
 =?utf-8?B?eC92QjVTS3RxTmhYZ014TUI0VXJneDhPVyswK0UwUkg0L3crbU91ak1UYWNm?=
 =?utf-8?B?cGI5Y3pFNEJHYVErR1llK2YwdFk5N240RythUmhzeFNvTzN3V1lzd2NlTENW?=
 =?utf-8?B?bXJVclpCcWZ2UkxSazcxTkZYN09CdjFCKzF1cm1NbkYxQllreTZvT3NsT2Mr?=
 =?utf-8?B?ZUJaalhPVGNtbDdxR01CdnZCbHhYYlY3cFF1eUlmSDJSUk5rY0YyUi83bmpO?=
 =?utf-8?B?cDU2c3pLeVRWUUV1b1E5VXkyNnJWUkNVNjc4ajl1cENRRkhMNlJZN0QrWHZp?=
 =?utf-8?B?aVE4ZzViSWpXaS9WTzI4a0N3WVB0N0o1NDVSdzZLQ1FERGNYVExIQjlhWXpu?=
 =?utf-8?B?cEpLcUlWMi9aWGRoQnlzZmNhSTRPUGkvT0p1M3FCd29zdUlEcjQxa3JoeCt3?=
 =?utf-8?B?di9PQ09wRXV5dUYrYkIzaW8xbDRjTkxqeVVWK0VoejB2SWc1d0cvN1lTNGZi?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c414373f-da0a-4272-e508-08db1e098ae1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 06:10:53.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GFjHtGw2EU9ut4KOq7wwZQm1bKvxn2Irg/haduGpX40JYFBlRDqwOYwkoJOL2hq4AfgY9n1oXL1evKsWLGCsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3913
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 06:11:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10933

On 03.03.23 13:48, Felix Moessbauer wrote:
> Changes since v3:
> 
> - rebased onto next
> - add patch to clarify situation around watchdog on arm*
> - u-boot: remove irrelevant patch around FPU
> 
> Changes since v2:
> 
> The v2 adds the required infrastructure to test the swupdate support
> in qemu-riscv64. This includes the following additions:
> 
> - update of cip kernel config for qemu-riscv64 machine (for non swu case)
> - refactoring of u-boot deploy logic as preparation for next patches
> - u-boot + opensbi firmware for qemu
> - addition of linux 6.1 mainline kernel to support EFI boot of riscv64
>   in qemu
> - extension of start-qemu script to boot riscv64 with swupdate support
> 
> Changes since v1:
> 
> - rebased onto next
> - ebg: fix changelog version (no <orig-version>)
> - add swupdate support for qemu-riscv64
> 
> Please note: The EBG support in cip-core needs a major rework to be in
> sync with the upstream debian package names. Currently, sid cannot be
> updated to a more recent revision, as this breaks the build (multiple
> packages with different names provide the same binary).
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
> Felix Moessbauer (8):
>   make reason for disabling wdog on arm more precise
>   fix efibootguard for riscv64
>   wic(ebg): add support for riscv64
>   add opensbi with u-boot payload for riscv64
>   enhance qemu-riscv64 machine to be testable
>   add linux 6.1 mainline kernel
>   add swupdate support for qemu-riscv64
>   start-qemu: add support for swupdate on RISC-V
> 
>  Kconfig                                       |  6 +-
>  conf/machine/qemu-arm.conf                    |  2 +-
>  conf/machine/qemu-arm64.conf                  |  2 +-
>  conf/machine/qemu-riscv64.conf                |  9 ++-
>  kas/opt/6.1-mainline.yml                      | 18 ++++++
>  kas/opt/ebg-swu.yml                           |  1 +
>  recipes-bsp/efibootguard/efibootguard_0.13.bb |  3 +
>  ...01-add-machine-type-name-for-riscv64.patch | 39 +++++++++++++
>  recipes-bsp/opensbi/files/qemu-riscv64-rules  | 12 ++++
>  .../opensbi/opensbi-qemu-riscv64_1.2.bb       |  8 +++
>  recipes-bsp/opensbi/opensbi.inc               | 45 +++++++++++++++
>  ...iscv-Fix-build-against-binutils-2.38.patch | 55 +++++++++++++++++++
>  .../u-boot/u-boot-qemu-riscv64_2022.07.bb     | 22 ++++++++
>  recipes-kernel/linux/files/squashfs.cfg       |  1 +
>  recipes-kernel/linux/linux-mainline_6.1.bb    | 18 ++++++
>  .../wic/plugins/source/efibootguard-boot.py   |  6 +-
>  .../wic/plugins/source/efibootguard-efi.py    |  6 +-
>  start-qemu.sh                                 |  8 +++
>  wic/qemu-riscv64-efibootguard.wks.in          | 13 +++++
>  19 files changed, 266 insertions(+), 8 deletions(-)
>  create mode 100644 kas/opt/6.1-mainline.yml
>  create mode 100644 recipes-bsp/efibootguard/files/0001-add-machine-type-name-for-riscv64.patch
>  create mode 100644 recipes-bsp/opensbi/files/qemu-riscv64-rules
>  create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
>  create mode 100644 recipes-bsp/opensbi/opensbi.inc
>  create mode 100644 recipes-bsp/u-boot/files/riscv64/0001-riscv-Fix-build-against-binutils-2.38.patch
>  create mode 100644 recipes-bsp/u-boot/u-boot-qemu-riscv64_2022.07.bb
>  create mode 100644 recipes-kernel/linux/files/squashfs.cfg
>  create mode 100644 recipes-kernel/linux/linux-mainline_6.1.bb
>  create mode 100644 wic/qemu-riscv64-efibootguard.wks.in
> 

Thanks, applied to next with the mentioned adjustments.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


