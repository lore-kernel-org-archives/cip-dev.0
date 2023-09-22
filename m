Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D513E6FE3A
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 14:26:57 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.52])
 by mx.groups.io with SMTP id smtpd.web10.22612.1695392810415706119
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Sep 2023 07:26:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W3S85uFc;
 spf=pass (domain: siemens.com, ip: 40.107.247.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMs5mZInUcHH3R/xRY8aEzDrha8zfDhORfoM2rAt5cQBqLD3uBzkRDSIRHr8/LrQUxcwCYDmlJPhLVpFck7ingdCfDXL6eciQsb94JZ0ZFNq9CO7qC1MtSKoAAV5yGEc4wUvIzTGqPD2LTMP7iLOWSGKLdCCrPCAsWYfloOpXtMba4wTxJxEj6oYJ262t05HgayBWOoxN0vX8859DAnYsMqjMWhKJVlAsCBMaXip7wNp02mcQ2ZNSo+N8VxH2CMnUSJZfUU9M+s3oKbjC000POxmTvNMsm+U6fht+TQP0KIjabWZsCdYiXo8bb4nLQ3jOWagfwhWdXu1NqGuiHtWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+xCdFsZA2QIEiMHlSZl2FLwBVbJ0RGgkEsaGPJONn4=;
 b=OW+J7gOzQcxfUMeiYvhMsGWucyrqfLsHEkdhUhW1FUZfDe4ucOb8iCiG2JEltvOi9VhzOEMTLGZbIddBMKEvs1QsoegARlC/mN1QrqtIotAXtnp0CM1qC9ihg5KzCfLZIYRFjyFCYIOmOVYZeexKKy7SE5d4ZN5+6D1DviVJjwDEpj7NMMsWxpys15t6gkJ/XznVhbnNUYGeJAjqI45JGa2t13TMizUVTnte0OSZFog1TpeFzDb5ZyHogBkqLURwJ7S2L3PAL+p+9WBP7Vd1U9upO3rsHxSYyIToFxI+ChJKkmMIrYeuNf2X2Ew/El+mHoCEygJ8bOX/cV5Ft8P6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+xCdFsZA2QIEiMHlSZl2FLwBVbJ0RGgkEsaGPJONn4=;
 b=W3S85uFcGgqbY25IrXHfZZN3dyU3NyucXLJaNvCVlBo1jT8Tg1LOHnLljLNySQrSu6fj3RSJm4BtzPgyqSlAzvJVt14ikW/wIHmfleqY5O65d+7UIFCCYsi8KdRjl47zBIOytYJfaPPTusl8V6/yGhXMdSLauuTt2nyWzQ0+s+egGtCAXrdyHsyKmjUTc0yoI9YW7EjNKFYOreLLlB+teFCNaamaULkdsYzhvXdfxIGZLGYwwNXpEHfTvKVcz4/hW9rhPZgzmP+wQ9Xp/lcU9c0gBD5Qus7jfSw16UQxJm8FSxMd2zaBSye/5vB4Xb8D7YlyqGJCA5AB+ubB+ZpxPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:26:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:26:47 +0000
Message-ID: <68c3812c-9c75-47dd-b197-761e018ddfde@siemens.com>
Date: Fri, 22 Sep 2023 16:26:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] wic: Use fixed UUID values for the partitions
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230922064904.11232-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230922064904.11232-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0018.namprd18.prod.outlook.com
 (2603:10b6:610:4f::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d49e7fe-9810-4ac9-349f-08dbbb77f3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	24Negj3w9OEEAa0293DW16/DdOOlt9ayOyXlrpVMMekXDIdefcxt1BK5whHSgr+hAAPY8CUmOLRFJUYTEbJqVbe6Wd7+8Y1iMbZLfzakKRcMX3dq0f0Z5NDnpuHRYDXH7MPjnZWZCW4ZWqTH3TN7kmgAUS16pQusZVcxsw0iJ9swuexVnnYI5KQM4HIiKwJuJyv8BUi93fl7UGBivLbIw5P63qbGie6DBfW1RZ1QBeX3OhUegKnfbPWA3maVy8KhHfGouL/DdrsS2MA59i+ghTTS09/Vxq0DbVSnD+OieqgrOh4+PegLNuc8sxLohru8g1sw4TwLEOMM3xXrX+gqG1NbsWevh/SpdPQjohofY0opzoYiRi0Ogz9lwXsA+xn3cfSnk59Wyytj528BFxibBL0W3QHeK5TK1zCQrd8q5YSb3cge9j7dbaQKX/FqNJ6OweM18Gzxpuj+jwdTaRukemtynQpeVEYP9Pzfh30PBABOmZlF9zSFFGMa8nJ/SwUOVqlSc0+I4Lkb0kK9s6Z/ukuax7Bm6J2aKsqS8AfX++g1AiFWcmbCiuwgY+HjIWR0utZqN6vjz2EZean48EpD+Fo0HydWvhPjngsSWDnNn+rtd66MtNSzRQ64nFijL+kJPDYaKNc0KrAgB2OfAB9yAopWUp7JNHJ/WylgK89uLrPyvye3pym3lpYuY9s1FRf3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199024)(186009)(1800799009)(31686004)(6506007)(6486002)(53546011)(38100700002)(36756003)(86362001)(31696002)(82960400001)(26005)(2906002)(8676002)(478600001)(6512007)(83380400001)(2616005)(8936002)(5660300002)(41300700001)(44832011)(66556008)(4326008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXpmNkFwdnhmNTBXTmY4VDFXWEoxeGU4OUl2VEp3aFErWkNncFpVYlhHbm8w?=
 =?utf-8?B?cm50aEwvck1yNWFaSG5MTE41QUdkbTlHcWJFYUtpY1crTWcvRzZ2Ym9uVC9h?=
 =?utf-8?B?TEJkS1Fjd250clFHVlgvOHJnd09jRlJqRUp0MkhkZVhFbnZIbFR6QjJPMXVm?=
 =?utf-8?B?QzRtdkhUSlliNWtnckRTb3pIcWl2SXE5d3kwSnQ5Um9jbXZUQVRUL2xBdUtl?=
 =?utf-8?B?VWdKRTlmNTBPd0VYWGQ4Q2FyS1FNUUc4K3RjdlY4R1lMYTdBblJHeWoyV001?=
 =?utf-8?B?YitIaGpCTmxuSzRtQ2FvZ1FlZXhzMVdLeCtaUzA3aU5COEFUUEZYc0Uwak1s?=
 =?utf-8?B?cXFMdVRFcDdvZFdjc29PYm9KMFJTUU1Xdm40OEZaakxjYWUrTzIzOVRWckwr?=
 =?utf-8?B?Wk1pQnBVSFYvZytwazJZZE15SlFDa0tOL3BkTDRUMFVGN3haREJRUm1yWlJa?=
 =?utf-8?B?QVkvaG16ZHB2djltUnhzaTZDbzBHaXprVThCVlF2MldGUmhuZjNFSk9ycVBz?=
 =?utf-8?B?eDVGQlpOM0RpVEpmWW1BSkFjMDVsSTRXMTZsUlN0UTBSR0E3Y2tqRmw2elZv?=
 =?utf-8?B?cWErTHI5N21iZkx1THJjYUU4Z2tEUFNOQkIzTFpNRHp6bmZXdTFwamxwbGpC?=
 =?utf-8?B?eTR1ejkva1IwcWE3bHZ2QTdtOGxxcHhhTm5hUkk5ZjEwYm1tbVo5MWtPczlj?=
 =?utf-8?B?STh4TVRLNTQyNzhvWjFZVkFReHNlU2tDdTFPTFprT3V2eHJHQkRQeTRuNjZB?=
 =?utf-8?B?bkNJMWRwM0RId056WTJHYklHTzdCVjhGMkNTV2NZOXFjTUtTSTdnU0xYNmhO?=
 =?utf-8?B?WERqelIzOTc0ZVBHYnZZZFhVSE5XN0NUWGEzMzdab2p5UTJhTGlROGhnbXJT?=
 =?utf-8?B?Q0Y4YkJaVVBzVGpzWWZBUjhnS2tELzFxMzFNZ1p3T2syRldlZ2FUdnRicnJv?=
 =?utf-8?B?L2VFRWpLS1FNbzNZYllqZU8za2J2eitOejlSNXp4VnQ0VXJYZHNoRXFHTGFC?=
 =?utf-8?B?ZG5XTGtNVTQ2Tmo3dXl0Qm1CREFlczFvUHpvUnFpWGF4SGNPcm55WGdhaWxm?=
 =?utf-8?B?ekpZZ1o3OGo1QmQ4clBNRUEwL21MLzdGUnNkMitVUVJqZUxkbDBLUUs2aXhM?=
 =?utf-8?B?UjFIM2dQaTduMW81SzdwOUQzb3hvM0lYaFRZY1JDa0xhOFFsa3dNZHRUaWlN?=
 =?utf-8?B?QzFKUjExaGNBL2FKc1FnNEgvcldQVUhkMDFiZ0VCaERCQTJBRHRmVlpzMUJV?=
 =?utf-8?B?em9JOGdDSGk4Vmx1NG1KU0Q2UG1nTlFUNHcwNVNhTkNzbVVZdU5NSmtQeVdr?=
 =?utf-8?B?YVZWTVNoeGpEaGhYczV2S1dyT1A2aWRJMXZESUthZUxlVlcvWjhCMXZvNUo2?=
 =?utf-8?B?c05oTVdBKzZXam5USEFsM2lNRHUxN2hPZzdvUEp6WDNjMzN6ZU5uNm1EQkZl?=
 =?utf-8?B?WDFCdEVwZ1gvQjAwWjhvZFZoakZ0dHZaQkkrSEdDSTJndHRYSStyUEpaWnQ5?=
 =?utf-8?B?STBpY214Yy8wUUpwUGtmdk5SQWtvT3F5RVpiZDZxWCsyUjBITTlRNEhhUmti?=
 =?utf-8?B?QndxQU5NQkJtcXcwSDErak9Ebk54RGVwT2lqNXFaSDI5ZWUrWlc3cVZyd3NJ?=
 =?utf-8?B?ODdYZ0tlMCtvd2tLK2p4YXZzcGM0eDB4MHpGWGxDc2dvTkc0cGZVaFJKbGJT?=
 =?utf-8?B?NWVSbkJKV3huSjFVR0szZUVXdTlGaVJhdmU5RkV3UEhVWE9VS0oxNFEzT2cv?=
 =?utf-8?B?MTJDSnJSMmJqSUNJTHdXbE1jSElMb0l3WDFFMWFMNTJsQnVPS25jV2ZqVW9i?=
 =?utf-8?B?RnlxYklmVUNuNStvOWl1VzM1TDhqYy9KWTlyMEtSS0xyVWZtUGJhSGoyakV1?=
 =?utf-8?B?ZTdDVW02cjBwUUJKSkdZWjdJbXRCM1NSaENiVHRmRmVqZTIxTzhaL0ZQcDhU?=
 =?utf-8?B?L3dUOUdaK2FmbXBtZVF3V2FzbUNOaTRDZXFQVC9WYUtXY0RRMGJQVFRUM2VE?=
 =?utf-8?B?UGlmT01FNnhWR2xNWSttYzVqZnRFWmdaVUJzS1lUazhZTUd5Y0RrQTdYeUVh?=
 =?utf-8?B?MjRzUjJGRDFLNFpFb0E4bjZvUkE4ZEphTFVhbXJUNHBlRVpvM29iODR0d2dq?=
 =?utf-8?B?NGlRVkc3UVl0cXNFZno1cE0yS09wTHN1VytLdkkxZ1lrYmV6WlhvV2kyL2Rp?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d49e7fe-9810-4ac9-349f-08dbbb77f3db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:26:47.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ML/3FsAjzH0rNG5RwtnEivW0JsVYKxsFO4UdNjBE9Sb4aA8oZXONa69AcY+iR8+GsYQII6DD6SUhc/hwtgqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Sep 2023 14:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13211

On 22.09.23 08:49, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> To generated images reproducibly it should assign with fixed UUID
> values.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  wic/ebg-signed-sysparts.inc | 6 +++---
>  wic/hihope-rzg2m.wks        | 4 ++--
>  wic/iwg20m.wks              | 4 ++--
>  wic/simatic-ipc227e.wks     | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
> index 2d4d0e3..b2340e2 100644
> --- a/wic/ebg-signed-sysparts.inc
> +++ b/wic/ebg-signed-sysparts.inc
> @@ -1,8 +1,8 @@
>  # default partition layout EFI Boot Guard usage, signed version
>  
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
> +part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc
> diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
> index c0a9f77..fd3a338 100644
> --- a/wic/hihope-rzg2m.wks
> +++ b/wic/hihope-rzg2m.wks
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
>  
>  # Rootfs partition
> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
> index 14bf8b0..85765f0 100644
> --- a/wic/iwg20m.wks
> +++ b/wic/iwg20m.wks
> @@ -12,7 +12,7 @@
>  # [Note] u-boot runs from an SPI memory device
>  
>  # SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage and device tree)
> -part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
>  
>  # Rootfs partition
> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> diff --git a/wic/simatic-ipc227e.wks b/wic/simatic-ipc227e.wks
> index 9044e0f..1a44e26 100644
> --- a/wic/simatic-ipc227e.wks
> +++ b/wic/simatic-ipc227e.wks
> @@ -6,8 +6,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024
> +part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba
>  
> -part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>  
>  bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


