Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC434FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 10:13:37 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11542.1777889607014786822
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 03:13:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FptHWoR9;
 spf=pass (domain: siemens.com, ip: 40.107.162.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5VlQ6MUgcTOiAV0WcUwMF/2K39jYdnerOSWF2yeH7tJJJ9W0jtVOkHMxMQ6uiYYrlEVX8VCMulbF03YqdhWhaiu1D75Vd7tT0KL5RKljUIvbFCYD87iTOE2NYw6wL94nX47P8Z+71M5pmH8MfZ29Wj7nXluW94TvfrT1nge/ygU67S0TX75JN6ssA+/aLmHD4AiOlDRLpwkrD9mfnRLprxS/DXlRroZJ3FS0hJYxKReyy7Z2c9ecdO95RM5wU+3GA6hmwyJ1KTYkGg9wbujKbNzqAyIPhl7lAyqxHsoh4im+CvQLJRyrV4rDnSXaZEmVrD+TnDKHPYqPdCAzdd23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9vvfklF4NLw9XVxp6wl6jMpeha+iRDK7mm/4v8ECEQ=;
 b=Nimh/y2FLCIq6HxjPqvjRloHVKFpLIXyqmZFF4QwUM6tCo3WQICGIJgLqoDuI26U1uBDM6L968zysIt1BrqS11IKnvJI+Y0ax4GGmgmfKxBbFI6znU3kaVpnmsfUMsuzwABGfWwXFL+usfO0HuOP3/WEzY5XKH9qW4tkUklbT3HJgx7S3B2kq2t/8pSrQdE3u11j9TEBPN3omSTsh+vCd963GIq4Moxe6tO/E4ODf9d2EPEldXxSecyIw6ZGixzct2nhrSf1NsrYxVt1/7fRBNYzaN096EiQzbv73MewbeDi5xHV2jY1WF/Xx/wrbcQfW2mG80F0QKKFc/t6U1iSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9vvfklF4NLw9XVxp6wl6jMpeha+iRDK7mm/4v8ECEQ=;
 b=FptHWoR9DZpkXcB/U5hVegkPzjcsRE29r+sMdoAbdF6NDKz0XfctUWk4BqD/RcjHdkywM5O6RiNUB4hxm34thz3JeMtjup9tVcirso/VnZ/WqzKQNygcJW+Rxg4ofGqzOV7iJKAjjQLNMv4J+uhGMSSsBxYPwh2Z5Y+LnceNgWE2I6JKhCvUb0eTn/ljaxVDEpK2In4oUHnXs4LlCdyHf6dIzKinsz7PDYZXO7OkS4DU3WbVHBtSDQzb1W/GtMjXCb/zxCpQjp1v7/1B6W9CyydZJsc4C8xlTJNiOSEBSSX1aHeGQujNqLv1MaCtXn2XDc3n9y16iztzUvUIqUYAIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB9348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:59c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 10:13:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 10:13:23 +0000
Message-ID: <0d7fa624-ccaa-4843-ac85-71b2e17b6189@siemens.com>
Date: Mon, 4 May 2026 12:13:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 6.1.170-cip55,
 6.12.85-cip22
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260504093833.739683-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260504093833.739683-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c5edb6-6d40-405c-41bd-08dea9c5c60d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	LnkkVf0akus9UfW3tnkwLQVx2xp5a1HIp1YJVsg+hQMsemgWEZbZExv+cieourl5oCcTxyqCOB29HpKSc0nATdnHzBXZxN+4FPT+s/LMhksd8hP6C8PY8Fjo5F8mnMejo0KV5sZe3uf7xWXzngkLM0gK3wHcXEHbzb1QycL92QPmOZMEokvDJfAD7YqlmXx/FMPznIbo10W/NaxCl/JgPmwvxOGYfIN9ZUZQIGXhwt1s6Bu3AtTCQW4D/YswyLBO/S9vDjeeMTbdOa5zs5aQlBLbYZJwn2GbbsQZT0ggX76cifAne9CfHY+yl7HY1wgdP5ZNnmt29fUQsyZpVRCRbZci67Ycc1AzXLGGC77+FrKBqS9umgUXj7CAsWPyvLegHSUyix7n96CElb/A00YzDey0GwlUu0yTaTXjruJdVLMn2i85i72BEINTb4llROq9AUzEfZUkC7V6fMno4P1s9NHJW55UHD37Hg0yMu0jn8KL7+eLzPNyzVIYZrsezK6FOlRto0rQVv1EqMfhyvfvc5gAkFh2R6TAAs79YStISAVyDgw3wwxJftGs3QiKFFs5lWmb0ObGnsc8Vx6Ea7OkM81yw211hmlex4XIF9CoUCtFg1qH5qTFSyf23MNin/MWBglzEIBTvqGxo9tAgFnRjXSVMjzwDASNRrkNyO07upGHhu0suSRSrvjxZeT6LO6d
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QitKWldWdVhsRTVYdWJKbzJRWkVwUnBQU3crc0k4ckw3R3JxbXVtSmFrZnh3?=
 =?utf-8?B?TGF3V3VOQ3ovTjh6VHNvU1lQRmN2Q1lzV3dYNjQ3czFzRHBpbWNSL29IWnJG?=
 =?utf-8?B?bE1ybUR3ei9URDNtQ2k3Rm8zSklya2RqaWxmTmhKVEEwZGl1S0NsZG5Kd21F?=
 =?utf-8?B?ZEZwRjdvZ3RRcTh4aDF0VG9WNXFGbWN4Q2tEYWhPYS93WlE4RlBaUXRhOE53?=
 =?utf-8?B?d1ZOZEhUVnV4cmVPczc2MXlSMllIVDF4VkQyQVZsRFFOV1BTeHdYaXRzU1Js?=
 =?utf-8?B?YWpSUFZudW9PejFZSU54NlU2YWhKaUpsQ0ZnUkp2V1lKYXRRNVUyOEtXcE0y?=
 =?utf-8?B?d1hDSUFqcWJEcnB4N3lmMUlab2JZKy9KYS92TWNiNmp5WDZvaDM4Q3kvb0FO?=
 =?utf-8?B?MWo1TjErZUhMT3d1UlJaa0NDZ1lwNXNYOGdIdnhUc2lRQmFZcnVxZFlCUGpZ?=
 =?utf-8?B?RzlpY0czOTk2Z2M3Y1hRZGs3SHBOLzVRSnJRWnNtNkRBaE1heXJqUUN5RVJT?=
 =?utf-8?B?MVF1TEg4ZnZXYUZFcCtNV2xZaUhpYVBpZjRyY25TS09PMVRlTlVMQjRKWnl3?=
 =?utf-8?B?dG5rMUlCdmJVVk9MRXJndnhuUmVHbmxxOWRxRE1MWjQzMnZWU1dUQlJFSXpN?=
 =?utf-8?B?aklUSEQ3VUlhektHaTBFR3pNVFNKVXVpSmxsREI2MGw2emRqSGM3WktSTXVn?=
 =?utf-8?B?dURyNWFVbWUzUzBCV2NmM2N6Zmo5T2JYbFo2eDBrT3phN0NVWVNzcXRmOHAr?=
 =?utf-8?B?UXgzMXVaMnI5VHFucmYyZzdOL0JLckdzelJtdDdLdVkzZDJKeUI2RnBScXhj?=
 =?utf-8?B?RW5ua3lHQzZyOGRFSVYrSXhEZVNiYWtCY3FTMEVJR2dqK24xd2p1aTRYY2ZS?=
 =?utf-8?B?Z00yKzVya3lXbURTK1BnVHpKOHNOY2tuTnN1ZEV2aWVnanBFemtMVkdCVzIv?=
 =?utf-8?B?ZERpU0tGdmNwWjN2aDVGZjhwV1lvcUljVC96bU51OVJLWUJndUJGbVJEdHlz?=
 =?utf-8?B?RXVVVzl2S2libFlsdVhwYXFmbjVJUGZ1ejlYeS9HNTRCRDZRa1gzMkY1Njlp?=
 =?utf-8?B?R0tPVS9GNE4rYlRId2Q1K3k4UDgxM1NPZ1hRYTgzdjg1N2pHcTlaUjZTL29M?=
 =?utf-8?B?Y2J2L0lGNmxBVnhrUEVWZ3RrcEVPTlNzUnk3c1luaU5reHU5N1RPWmQ4Q3Vs?=
 =?utf-8?B?eFlTOFBCaG96ZVZvNEdKQjdYbUtoa3NmU1crUGhJa055ZGhMcmorSWZjZXdq?=
 =?utf-8?B?dGNFYUdnemt6UHNkclBZSmNCQkFIQlZPTzhSK3d6djFkR3NYZm1zZFU1U3Fj?=
 =?utf-8?B?QUlOd0hqTWVSNUdNTHhNcmIvNDdqVTRoVUFIb3h2YVBySVZzNW0yYjNBVlc5?=
 =?utf-8?B?TFd5bzZzZzFNNWtEYjFqK0x6Z2x2TUV2eUVKVEpZVEUwSXRNY3NIUitkeWVm?=
 =?utf-8?B?ZnVJVUJ4STNsVndZUXNzZ0htTTM4MDFRV013dU12Wll3TXpJNzhNeEpWbHpV?=
 =?utf-8?B?ZFlQMTZwRzEyZzBvS0VJM3IrWmgxTTJZMk9BUmdFWmhLbW9RcnJwSUxYV0ht?=
 =?utf-8?B?b0t0Rzl0dURtVElublJ6T09FWUUwTitmMlBXWXUxVWl4amdhSktRaGhUQ3JX?=
 =?utf-8?B?YWw4ejhmTG91dXEwcXVINlpVSWNwYWxybThVT3hnRHFEWjAvQ1RScndIcEtl?=
 =?utf-8?B?eHVQa2pGQW13a1h4blo1WFI0UFdyV3c0NTlkR0lpQkZVdkE4c0hIYlVTb2VT?=
 =?utf-8?B?d2UzaDNvMlRkL1UvNkVhVDJHM29OTnpLRHc0VEFpWUNwMmhDalpwRjJzQm9u?=
 =?utf-8?B?K3F0Y3Q2dXNVM1V5RTIyYWJOMmczVldJY3BVNVQ0eHg2RXlScFBiOHBVa2Jv?=
 =?utf-8?B?QW5GYVlPd3RnRDJiNytOeUMvdjlEZmVUMkxBMmY4Vzd6QnZUaGFGM1ZOczcr?=
 =?utf-8?B?MVFjNVRPODBKd2VvMXM1Y1FvV2xrcERsWTFBZHM5Yk0wL0F1TGpYTUVKVlMy?=
 =?utf-8?B?NElMaVdDT0tyTzdtZ2FtdkE3c0lKY2JBanRQUUozNDdlUjV5RXpuSE1uREhm?=
 =?utf-8?B?dERKdEZrOTV5M0drb3VVNWl6b2VhZlkvZGRNU1RtMEYyRThwaXZVVU5DWENr?=
 =?utf-8?B?OVUxVXRJTjcxTWxmaU9LKzBBN2lENUVoYk5SWHhkYWRxcGl1eXkwNWo2RDZE?=
 =?utf-8?B?VXVMQzdYUG4rV01LOGZnSVQvYXRFQlprZXlhd3NzWVFQeXZob2llVkFvTFlr?=
 =?utf-8?B?UEd1WnRWdVBPblR1aGFtQUVGY05zQjdqZVRjYnAyZXJYNGo2Vi92amV5ajJp?=
 =?utf-8?B?bEIxRkoxN0VmMHY5bU1TV1N0OHM5SXduVnk4TTZHNGVEYWFuM0xEQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c5edb6-6d40-405c-41bd-08dea9c5c60d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 10:13:23.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APeR3wrCXMYL6uYnaiLAuctPYCcSYNIVLNYU0cmi4NDIRGomqR5zxW3sxRmBLznWgoK9KYMi7OvOwc0NAuw95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9348
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 10:13:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22860

On 04.05.26 11:38, Badrikesh Prusty wrote:
> Includes fixes for CVE-2026-31431.
> 
> Reference: https://security-tracker.debian.org/tracker/CVE-2026-31431
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb |  1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb |  1 +
>  recipes-kernel/linux/linux-cip_6.1.169-cip54.bb    | 10 ----------
>  recipes-kernel/linux/linux-cip_6.1.170-cip55.bb    | 10 ++++++++++
>  recipes-kernel/linux/linux-cip_6.12.83-cip21.bb    | 10 ----------
>  recipes-kernel/linux/linux-cip_6.12.85-cip22.bb    | 10 ++++++++++
>  6 files changed, 21 insertions(+), 21 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
>  delete mode 100644 recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
>  create mode 100644 recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
>  delete mode 100644 recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
>  create mode 100644 recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
> deleted file mode 120000
> index 21dd76c..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.83-cip21.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.83-cip21.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> new file mode 120000
> index 0000000..ed5ab00
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.85-cip22.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.85-cip22.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb b/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
> deleted file mode 100644
> index 9033bd6..0000000
> --- a/recipes-kernel/linux/linux-cip_6.1.169-cip54.bb
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2023
> -#
> -# SPDX-License-Identifier: MIT
> -
> -require linux-cip-release.inc
> -
> -SRC_URI[sha256sum] = "795cab37cff6fda51255915b419c83481d98624aac9ebbdf63b60da65f5489fa"
> diff --git a/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> new file mode 100644
> index 0000000..a339926
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.1.170-cip55.bb
> @@ -0,0 +1,10 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require linux-cip-release.inc
> +
> +SRC_URI[sha256sum] = "2b0b200234b03aea3ed77de553935512ad42b25ee260e00745b0729ed892cf63"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb b/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
> deleted file mode 100644
> index 9f1e5a0..0000000
> --- a/recipes-kernel/linux/linux-cip_6.12.83-cip21.bb
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2025
> -#
> -# SPDX-License-Identifier: MIT
> -
> -require linux-cip-release.inc
> -
> -SRC_URI[sha256sum] = "e72ddfe5db1a6514bc564f54cc41503a1ba16e651c1f535f25b93eecde2d5f19"
> diff --git a/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> new file mode 100644
> index 0000000..fecdba2
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip_6.12.85-cip22.bb
> @@ -0,0 +1,10 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require linux-cip-release.inc
> +
> +SRC_URI[sha256sum] = "b99c97c032e3516475e90853a3075274cdc64000699fb5425fcff39c3b998b93"
> --
> 2.39.5
> 

Please re-run so that we have 5.10 covered as well. 4.19 should follow
soon, too, but no need to wait for it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

