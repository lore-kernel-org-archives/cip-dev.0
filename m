Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEFFD8763
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:44:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74865.1773751448432291907
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 05:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gWqk9946;
 spf=pass (domain: siemens.com, ip: 52.101.69.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJBhUzvno3c0/a94CSV9VKBUzq46PC939BwlQdO6VLRd6d1hmXyEvqqYYgyprI4vA+bgPBj5Rc7IGbL4+eHVuRQmc2yboZqak/DxdXX4eTehliKZQEJPWstHVDdl6OuHX67VeTkdxqqP31/zgz7rGSBtxMRGhns37mublGUGFTXVrZTl3yln0KQHCNfokRYuKpLNSvcxMBxf9xMUZFeFmmMgbw3woPK58EjBXi6BUjKxCHkBEh6tQk9cUvUpsmT3dMllV3jVcH2WBM2yGntmbqHys9ALS6i0LjETRBgY71Ih1OZJYhDBjpl2MBq3oNHjiZQaFxSQVpk0UjsmEUOboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYGwOVkIHw7I714PAak1277A9GyvuGLZYNAOZteqhF8=;
 b=qksTYJ/n4+fdw9NNZWYKUnxwL3CauOWSlY7NZm0zlVzf4/8ITPmBlEXdrohmMEqC9e89ckJ01dyRQPdHRlHy0Xp3tg6JfTstliRSn6U9GHaA3sgre5DnUyxBM8A26MJJLbzlDMj6yoQSjK4R0bEs6X/BSvp2xd4tTNIX5JBHYRnXeCKJ87oy3+0vSwRFpneIMLR/qUwDoa3chcTEusrmKII7BbOVGXyqXpNTOyl7J/mGOaCXpkNcQm+W+Up0EbfzE1CRqln2rMEBR0k0tKuwY0UQ/hk9Pn6X3xlVAbvXQIGuk7bOpARjHAmYz2pPWd6OCksl4JgT8comshPwp54D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYGwOVkIHw7I714PAak1277A9GyvuGLZYNAOZteqhF8=;
 b=gWqk9946dBS4yl2kExUYHZWncidwR22mjbzXa1af8nHK3CiNFtoa3aM/5GSnn0IjbcbjxkqdnDqmGglRw5jSV3za7UoURqP0bT1qBFqc20ePYZtuTxiAKzM1n6eRjggGdwhUGMCwp6Xo5zt0vwLGTMvRbJsrOq38iR757dhEatB6d5II3F/yPvyFNXUr03p5j3QiHFTGAfpSslue+IEUIAs5YpN4u+1Hdq+cnkkkaMyyLMe861WMddnlJTxj4ndPS+T8s082aqkxHY/mzIHzudyXHfb2+SVGtJJ1ni0jzZ+EDEIc4P7BM2S2Ukep8sfoB+60+qD9CKN77KLScP03UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB9914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:601::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 12:44:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 12:44:04 +0000
Message-ID: <f115196b-58f7-4bf0-bd83-0cc1b69c77fb@siemens.com>
Date: Tue, 17 Mar 2026 13:44:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] wic: Wipe LUKS2 header of rootfs-B
 on bmaptool copy
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
Cc: quirin.gylstorff@siemens.com
References: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260306142213.1273718-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf50cc1-e578-479b-0999-08de8422df38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	IAjQ5SSk0a/tlOx+qerU6InvMbcV/+CvIEtfF3xXLzhgun7UtvpPuJrDFnj/bSCQIXkyWV1qBpAgV6j4B8PvtrXr4Livi0zhjFX0w8dU6MjwODk3rda/hbyimArf46nelHiMKFnj+PoEGxueM3402kWu9qOn7WZx0VY+GWqJwWam0qBmfSFCOvnYnnRdHWXW2xjbFLmZ9Oprj7Yy80OeDA1ebnfh+aVYs4MHbFmcB8oFhbsUqZ/MLhbiflffqnXhuH0mzXLGJqoWuvhCOffFgvS0R5/LGjLfVLr5a+fOk9a/uLFmRpqG9mnk8t5VQ1EbtDctDxXKL55IywY07/K8jJM1eFjllQiEUTRu7yoGMiXaD9WSQeQnQclQGVHfMrFSsUoiOkd2Yyw4jUsq5VkZRFW5Xyz/Xb8PeHOhFl6VQVirxLp844qmA2pYuWPHPO8WvNXh25xIhqOJs4K1Ur7yXKyuNSNQ9/3toWw045NrUj8qB8275VvnNZ2cabEqqYZ3QSTuZ89vKEZAAsiRG6MrN4HysrDd1B07tioBLJDiTas8M3a4inwsMF8dN6dyCdf9xZNm32hXSPOrUxK4fTchaOKdTy1expjR4YFP4yc8UUxZNzQurqwrNoWDoZfUDlfqxq7mswkdvtO4z4UfBRDib45fGEnFN+14ABPW27Pck99YXEk70jgjJYR8+rRn6VJ5A1FayWULEs8PaUb7rfi9a59s5yW/hy1EZ/RSfTCbXVk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0k4REJuY0lNa2RiTXpQZkJ3MjdMMW8vUUIwWGx6K2FFeUlOL3pTMW8welFR?=
 =?utf-8?B?RzFrNysvSnVGS0poekRtREwyMTNnYkZjODEwWFBsdGFzUnpaR2tZcE4ySWY2?=
 =?utf-8?B?bXVmMmhrZ0hwWUVFYWhENkhrS0diTlBvUy9Jakg1WGZyTldyVkhDZ08wZDZE?=
 =?utf-8?B?REpXWFprc3Z5bE5aQU5PRVAvTzNJbUFPZWIxQ1RqSWQ0UFhDYzJuM3JPejJ3?=
 =?utf-8?B?Qm9oQWk3bStvdDRQTHgxc055ZkN5VnJZekNXcUowWTlnNzZMcjR2aXpVbjgy?=
 =?utf-8?B?V29mUjRNYnIzU0R6ZVAwLzg1V1crRjAwY1JHTVZ6ZmdQUno2TzdPcEZMUEFq?=
 =?utf-8?B?T0dMMktrUHJqRHg0citVaXg2Rkx3T1VtWUlmc3ZRZVdzcCszNFE3RUgyYVc1?=
 =?utf-8?B?YXpHc3JoL0lUQnAreVZ0bXljZnZpanJ3M004MTl6TGpWVmNZQ1NKVFBQSzJW?=
 =?utf-8?B?UzVpNlVTOExUeXlBMUlyQkRDK0hzUlhGTnYwMVZ0NnA0R0FaMlNFbFlOVmxZ?=
 =?utf-8?B?SFVnTGVKZ2NWMW9TODVzQ2hqeUphZ3dHN0NEWjVNMElMdk5PejQ4czZ0d1NL?=
 =?utf-8?B?Yi9xU0V5MHRoSWs1K0xMVUhmZy9sSWsrOFI2QzdQaCtEV3owZGFCYkwxRUla?=
 =?utf-8?B?ZGZlRHVXR0RmK1VOOHYvcWdGTWJ3Rm9sdDRud0prNFBiOXl1REcvUnhyMXJO?=
 =?utf-8?B?Wm00SGc3VWw3a1dwcExqYVdxak1VcDdZdkpIVFB1Mk0wNkpYTTBkc2RWSzlF?=
 =?utf-8?B?N0JvK2ZmTkRJUzhER1orU25mM2pUazFlRHB5NlpRNTcxbnB1emh3dVhIMmlM?=
 =?utf-8?B?R1lPS1BXejlHT2NZVlJRQU15R0hQWEFBcVRCRVpnUVdNc2hSTmZ6ajU4Z3Vz?=
 =?utf-8?B?QUhhTCtRRlQvL2lnUEtiVHlwYmRnNURtUkVvekNRVjdzVFQrdUc2MUNkQUJ1?=
 =?utf-8?B?NVhaNEoyWGNuR241aitNc05GR0UzdTNxNXlneWsrdXp0cGtwd21xK0w0bTZp?=
 =?utf-8?B?SzBYNVl2N1IzbFRZcVNmbXJaSWF1dXVRSDJDMWgrdHYzM3c3b0QxcUp4STlh?=
 =?utf-8?B?Qkl0R1FsRWVnR1FVdFNmTEg2UWZXLzdNUUJuZlhwM2tSZjlsMTBrcTBwOFJu?=
 =?utf-8?B?Q0lYMDNFQjloazl0SldDTnNyb1JiYWpzWUt1ZExPU1pqckVqSmJWQS9nOGVh?=
 =?utf-8?B?QzdoZXUya0h4WitNZE1uZHI5eUduM2IrQTJSa21mTGpudlBLV0RsNnNmZTIv?=
 =?utf-8?B?dEJORlU0dkVuSFI3Mll6Y2pUd3ZGbm1XRnhkRnY2d08yUG45RlB3VW8xRStF?=
 =?utf-8?B?MEtqaElNQUpLanI2eExwT09uZm0yazhCS0RPU2ZtbXlpL0FycVl4NzlQcUM2?=
 =?utf-8?B?Z3VNM1ZHSThodTlKeXl5YWFUbS9xRXhZd2djK0FaNkdvcWZ3U1ViWm8zZWJI?=
 =?utf-8?B?UHZZWGFNWGd2Yk9GZEhUTjlxamltRUpkUXg4SVRWUUJrSDdhZ0RwRlJiYmVG?=
 =?utf-8?B?cVE2UnZXcUdpaWtlSGdSU21pZzAxc3NGb3BPNlF0OVpZTXQ2S1N0YUZKdUpz?=
 =?utf-8?B?bFhnTWVhL1FWb1FZN1JEaUhvZXFDNTRmSTJZQUNMWVg5WU9kcEhXQW9YZ05F?=
 =?utf-8?B?c0hENHlXZWZWQUpMUTZRZWR6YUd4Y1J6Y3JKTTNmUTJXRVhmNlNwdU50bmZh?=
 =?utf-8?B?REtnakFXWFA5QXZ3MndUZjFKa0pOd0lPQWhTZUttVlcyNWlLeUx4K0U5akRk?=
 =?utf-8?B?akZGZXpyOGpCUlNhNlpXQ3hTYXBtK2RVOGV2UFZIdWRHQzFLZmg0ZGttUkxM?=
 =?utf-8?B?d2NWdWVtSjZVeHVjblFFNW9PbWFKenpPeUsrbTlrVjl4QUNoY0RjR21VaGhr?=
 =?utf-8?B?aTBXTzZwdlFVRDZwdTIyd2tLMmNUb3FhSXBvSFpjWndzZkJrNktMLzZST0JS?=
 =?utf-8?B?WENZMS9Va3FhQnNhdXdHRW9vMllRVXd0UDkwMWhraGEzMHJpTFZqWDFGeXpt?=
 =?utf-8?B?MGlIY3hnaU11dnQ3OWx1cWcvUHRPT2pGWjcrZlB6NmdwYkVhU2JQbnl4NDd1?=
 =?utf-8?B?M0Z1elR4R290OStkc1BsOXBKVStCUXhxZHV3cFREbnVLeklTN3FkbUxZNkJo?=
 =?utf-8?B?ZU5BaURCRklIa3BET1NDVFJpN05BNnNhVXBSTUNVWk8xN0I2cEhRQ0ExYXZU?=
 =?utf-8?B?K2E0SGhpZGNNWEpGdHdIdk1TVWFPKzJXWU95dFR4ZnVWLzRGdnpOTkRSOFNM?=
 =?utf-8?B?djgxdlQzbjAxT0pja0MwaW03MnI3NEZKL28wUDRKYXQ4dTBnYWJaZmh4SGhm?=
 =?utf-8?B?SzcwWFVLWGw5a3IvMFllU1VnSnNNVnU3TzYxV1BXT3d0QVZCUEUxQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf50cc1-e578-479b-0999-08de8422df38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 12:44:04.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT3kRT/kYBIw6fUvtgtK1GY3dUX2a8OvneU+t48GHCgoxRftGc4HOTWOSXOCgrw61qO6662pPVR+ejznxSQpcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB9914
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 12:44:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22487

On 06.03.26 15:22, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> To copy images `bmaptool copy` uses a bmap file that maps regions
> that actually hold data. That means empty regions / holes in the file
> are skipped by the tool and thus those regions on the disk do not
> change. - That's actually the feature why bmaptools exists.
> 
> When reinstalling an image configured to use A/B-rootfs and disk encryption
> that way, this results in a LUKS2 header created for rootfs-B during
> disk encryption setup of the previous installation to remain on the target.
> 
> The problem was introduced in 63eef2b4fb5feb393f97cecc4f432688403ded5d
> by not copying the rootfs to rootfs-B in the target image, which is actually fine,
> but needs special treatment in case of encryption.
> 
> Based on discussions in V1 we decided to generalize the fix to apply to filesystem
> headers in an A/B setup without disc-encryption as well.
> 
> Detailed bug analysis is contained in the commit message of the second patch of this series.
> 
> Results:
> $ diff build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bookworm-qemu-amd64.wic.bmap build/tmp/deploy/images/qemu-amd64.previous/cip-core-image-cip-core-bookworm-qemu-amd64.wic.bmap
> 34,35c34,35
> <     <!-- Count of mapped blocks: 201.3 MiB or 7.1%   -->
> <     <MappedBlocksCount> 51525  </MappedBlocksCount>
> ---
>>     <!-- Count of mapped blocks: 196.3 MiB or 6.9%   -->
>>     <MappedBlocksCount> 50245  </MappedBlocksCount>
> 42c42
> <     <BmapFileChecksum> 342e6fd7e54d934a6a5391be5ece8876fac877987c8c7ebc555521c26d24c27a </BmapFileChecksum>
> ---
>>     <BmapFileChecksum> 8c364ad4cb66847195f15a1f65b695f393d375c6a59a7edf3a24de88bb3b0295 </BmapFileChecksum>
> 53d52
> <         <Range chksum="c036cbb7553a909f8b8877d4461924307f27ecb66cff928eeeafd569c3887e29"> 332032-333311 </Range>
> 
> We see the mapping file contains an additional 5MB region (of zeroes)
> 
> 
> Following commands allow for an (additional) quick test of the patch:
> 
> 1. Initial Setup:
> 
> ```
> bmaptool copy build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.wic /dev/<your-target-dev>
> hexdump -n 40 /dev/<your-target-dev>p5
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000020 0000 0000 0000 0000
> 0000028
> ```
> 
> 2. Some modification to the rootfs-B partition:
> 
> ```
> $ dd if=/dev/random of=/dev/<your-target-dev>p5 bs=1k count=1
> $ hexdump -n 40 /dev/<your-target-dev>p5
> 0000000 fe36 6a22 775a 442b 76b3 7ac2 fb49 68f0
> 0000010 43a9 92a3 d2eb 4b6a dc0b 4c89 5ad9 cfcd
> 0000020 8f5d 5f1b 72cf e5f7
> 0000028
> ```
> 
> 3. (Re)installation of the image:
> 
> ```
> $ bmaptool copy build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.wic /dev/<your-target-dev>
> $ hexdump -n 40 /dev/<your-target-dev>p5
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 0000020 0000 0000 0000 0000
> 0000028
> ```
> 
> ---
> 
> Changes in V2:
> 
> - Fixed missleading parts in commit message
> - Generalized the fix to wipe filesystem headers in A/B rootfs setups without disk encryption as well
> 
> 
> Alexander Heinisch (2):
>   wic: Added support to set sourceparams for empty root-B partition.
>   wic: Wipe rootfs-B headers on bmaptool copy
> 
>  kas/opt/swupdate.yml                            | 14 ++++++++++++++
>  wic/bbb-efibootguard.wks.in                     |  2 +-
>  wic/beaglev-fire-efibootguard.wks.in            |  2 +-
>  wic/de0-nano-soc-efibootguard.wks.in            |  2 +-
>  wic/hihope-rzg2m-efibootguard.wks.in            |  2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in   |  2 +-
>  wic/qemu-arm64-efibootguard.wks.in              |  2 +-
>  wic/qemu-riscv64-efibootguard.wks.in            |  2 +-
>  wic/ti-am62px-sk-efibootguard-secureboot.wks.in |  2 +-
>  wic/ti-am62px-sk-efibootguard.wks.in            |  2 +-
>  wic/x86-uefi-efibootguard-secureboot.wks.in     |  2 +-
>  wic/x86-uefi-efibootguard.wks.in                |  2 +-
>  12 files changed, 25 insertions(+), 11 deletions(-)
> 
> --
> 2.47.3
> 
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

