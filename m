Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C954CE8D71
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:15:06 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4907.1763144103833660127
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 10:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sSe7stSU;
 spf=pass (domain: siemens.com, ip: 40.107.130.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAZ2PM7PAHlfK2T4ydPJZPS94zNy7JAaJ9r0ezT/5SV7GPE7dTIXupVb1vBSesb2CVwabO4T+8HeLWIEkSf9yxVlhbGX2h47TZlXHuLQsNB68zUeufdLqNOYXtoR3vPTeptr3SK4SBj8/Y37/t7zOcAQ/I9TfwPyQuWShXEG2QeICtdrYrpl0uMTif0y3fgTcCzLDB3KVMm+PrJu0VvcEOaDgTp+BSlS7d4Bj+HpkaiuTxhLGfvR1XNpAOhZ28vU7JHdKQy5Xco+U29Ib0Z2RWXqv4G0T1dmV9weYmIZdJVG7wEGv3no9eBCqLUzuDV9HfpfPbi2oQgMIF9NOAkd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQXVrnzKjqxSTs+A5FalvcpvOLvqynRc7jaj+lYq2ek=;
 b=ZBF1SVEay+bDrpE3s6ZN9CSx7yUSAtaQFzi9LnHA0A8oyrIuSpJ0HwmBQjbd5fi+jK1J9XHWXJxggxB5egmUsakZ5+v1OBWNcIaJl+JgoUhrBm0TMg3094cg8v8/QyuYkeCvPhl+RGyoLR3HcnXb6BXpyHI0e74YIpyUWVZwbQhD6kPmOb2ximQniajnjk7/yOYrY/MvgaUrNofHCSZtMPA6MzUiJKNUr1g9JCYLFOFgYnX38AFRXGViYaMH64hHr+Z7uI9LBbGiz9EsSYIPnEswjXUKxR42KluPJ0xV6crLBVDal9a4UfwNbpscwe48Ac5zI5hbmDIlurgKdoMXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQXVrnzKjqxSTs+A5FalvcpvOLvqynRc7jaj+lYq2ek=;
 b=sSe7stSUxZcJOAxYQoiV4rJ40w27uWMnnjP4GEFSroyjtX4BdpGrM+5JPIG+svplvijtEGymx7A2aFpKo+eXgybm2fSaqxLaq4DltMiPctwd8/X9kYa2c7gF7Cmv61s0cHPam0B/GjA6T8BVLHLxJrBHnW9kmqOLm3wTLpr6vK/lg9ZhQtAqBgB74gUZE8E5B9qVmz3miKKsazh8JNCVgK3Ou/Z3qEIW6bVdXvMSxosUByforYlPSrntZDPhx8vHQfgmY8sav89TiF2VbArv5g+3S5iJIemO8fvvJw5XwjXiyo7cmZlI1x+3eIsagtKKip+FFEYVBfOtbkosmnbvLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 18:15:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:14:59 +0000
Message-ID: <06516819-4fd6-4177-a5bb-9d29e5442038@siemens.com>
Date: Fri, 14 Nov 2025 19:14:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/5] Add cip-functions to
 initramfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
 <20251114111925.903740-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251114111925.903740-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0058.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 258f090c-09b6-44c3-49b8-08de23a9b90c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OHBFbk1DeFpJNlMxcVdDNjJQSWdxUHpYWTQ1M25YUkprSGM4cS8yVjl3ZmZO?=
 =?utf-8?B?eWJ4aGRGbHU1ZGoxQ0gwcTZuMFJXWXlPUmZpTDZMMjVYNmtGNEdMK0JySDdz?=
 =?utf-8?B?ZzR2WldxZ1poL0xCSmVlSzhrL3JnN0w2WXAxUG1Cd2t6MjBGbmlvTzNCZDZz?=
 =?utf-8?B?NUF5Qld5bEtVa3psbFVnUCtybUZjN1VnbnNKcVc1ak5CVkQyNkRjTU1WN01T?=
 =?utf-8?B?Rkl5Q2ZiUDlFZ2hqbjBPSmZUWkFqVG0xa3RvVGN4OGNQbnJodzFsZTBzWFpk?=
 =?utf-8?B?aW9CL08rdVlxc1lGM0Q3QzBZYU0veEM4TTlvNVJiRWxBZHpZRUVJaEovUzM4?=
 =?utf-8?B?eFY5RjFyS2diVS96YUhZOTdndkxOVUEzMkJJTjFDK1lGcGdzcnBPQnhIeWpo?=
 =?utf-8?B?U0ZzWDk0VHVOY2wyaEZEMmkrb1JaMW5EcmZ4L1pkbEJ5VlpzTGVqaWxPbnRa?=
 =?utf-8?B?NnlyQjR0bjR2NUVxbEpuQ1NZYVEyYmQ5eFRpWTNocUxwSUlDNDBKZWlPUWZt?=
 =?utf-8?B?QlZ4WUVGaVZDc21zVEY5ZnpnYVFhb0ZBNU5SYzVYK1E2MEdCZVU5NlFLcis1?=
 =?utf-8?B?dGo1SUo2aTZFb1NHV202R3I3dTBvNUllUzlwdFV3WFRXZHFVeGpCb3U5Z1FS?=
 =?utf-8?B?aUhCQ1EyWjhXOU4rekhkbXhYUnA1RnRvaFVDVG1zeithQkNFUDArV2oya0Rp?=
 =?utf-8?B?emk1UTJ4Q2JvZjh1S0FXZitGcXM4cHZDSHgxbWxvN2RUeXRJeDgzM3l2T1Nx?=
 =?utf-8?B?UU55NmFxQUZSMkRDQzJad2sybU5jSkI1TllZb1FKQ3Fvck5aYkNTMnBMVWRv?=
 =?utf-8?B?bEo4R3YzTTdWZE9saXlZK0FlaC9mbVpuWXR3MUlSSW4rWldLdERFOWZxa0ta?=
 =?utf-8?B?bFJPb1p1L25FZ3J0MUkwWUIxWjAydVI0bHVnMGVwVnZQb2lyaWpReHFhdEdQ?=
 =?utf-8?B?ZnJSRTF1cnF1L3JiSnhSczVWVDVsQzZFYW1aK1JFMno5VVJKZ0puTGJ2Q1pB?=
 =?utf-8?B?Z0l3RmYxWG5rZU5ZdU5Sc0o5RTdBMFVVNjlqcFNCaklkVC9LTnFxM0lZcmdU?=
 =?utf-8?B?WjlHYjhRUGpCdVJxY2NncU5DeWJzODZMYU5UcmJEUFVYdDJoNWFZMGpkNXlz?=
 =?utf-8?B?R2RKczgrWWZLY1UvT2ZkbkY5aERtUWwzeENYU05iQzBFOWhMV0g3NXdFek5y?=
 =?utf-8?B?YzZhSEQ5cWUxdVJYVDYrWFRScHZxa2VzakNHbDNZYnVyOVdoai9HdC9HdFJ6?=
 =?utf-8?B?MWdhMHB6YlJOVDROYThQcVUzSjJFR3RKelgycjlpbW5Id0d4dzZGYlV1RTkw?=
 =?utf-8?B?T0c4alhMeTREOVRIRmZkK3YrZTQ1dnh5K0oyYWR3SU51dDRDV3JEQkJkWmxI?=
 =?utf-8?B?R2pINElpSmZNeWxzYld3WGpHVEs2Q1A4T3hEY29sWFZmcysxd2tIOHdWWTdk?=
 =?utf-8?B?Q0JPdGFTemwwL3FJS2YyZk4vNzdKTnB0cGo1MFlTVXFiRUtjczlsekd6TDRh?=
 =?utf-8?B?MitrT2VWRzFOZkl0SUVHbmc1V3RDczZwOW0wZVZkakcrSGNsV254MGZMOS8r?=
 =?utf-8?B?VTBVM05xRGgramdkS0VGZzVXdGtic1ZCS1puSmVTK205RUNhNG9WTlBaUG5X?=
 =?utf-8?B?bEgzVHlJeHBoNXAwcnhGMzRlTW9XZTZZWFpvM0hkQkZZM0JoQ0NrUmpVQkNR?=
 =?utf-8?B?cG9hekg2TFE0NUk1ZE1HMm1nblZaYTViRnVzaEwxZkMrTGhJbTNlSjcyNFJh?=
 =?utf-8?B?ekJlaVVpUHFVb3E1MEh5cnBudVFKSlhtVTQxNWlsSjljOCs0Tkp5L2c2YjlP?=
 =?utf-8?B?RjN4dy9lU3NkSndnSkxqN1UrMlNPVGhPZ2lQRldrSGJmRlZFOWhyRkwza1Br?=
 =?utf-8?B?TlJoOEVWTlNWaDBVVWo0a2o3cFdBZXNzYUtDemlXNEt1dHJpQjFwenZnVjNG?=
 =?utf-8?Q?M0UT1o/mN8sWqT3DRLCMD49NII8c9Mp6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmJkbTBNMTFXeFFZcy9YRU0zVUo4QmdseEFxMUtwalRqR0hUaWRXZEQwWkd0?=
 =?utf-8?B?UWhiTXphZTdET0JVS3JpRkFpYWdyaURzcjhzYTlCOEFRNExTWkp6YmpsT1Bz?=
 =?utf-8?B?bEY2Zk5haTdCdzhWSHhTSEpWdWN5anlsQTF6NWhubEYyR2ZWa25NdHRFWG91?=
 =?utf-8?B?ODc1djRZdDJ4NmZXVm9XNjRwYVhVZ01ROWs3N3Q1emU1b0pPc1MrcTRKamNS?=
 =?utf-8?B?anFQWTlCRFJNcWdoMWNzUU5FMjd1Sk81andIZVQvanhmODlwZG1mRmVIaU9H?=
 =?utf-8?B?RDdRL2wwOWdRRTJ3NDdCWVlXbEl3eTRhUkV5ejd3eTY4QVFYN1lvQW5WT3M0?=
 =?utf-8?B?MlZtdzFQTXp1M3BrMXFXM2xROVZBakZjYmJJZDNyNEx5VVVYMXJIY0ZIWnNv?=
 =?utf-8?B?NzJYd3hzMjhKM2RGcGNUK2pJY0FKZ28yWUdkMVc5dFdEUkNCOEx5cHdpWnAx?=
 =?utf-8?B?akNVWTNTTGxMc0JkcUtEZmltejRZMUlMTFhuYU5jb0NNSmpocFZTR3ZZaWRI?=
 =?utf-8?B?R1ZLNzdtYWNtZUo1dEo5bGJ5cHplSzAxOEM0OVBmeGI3R1RyWWgvRVRjRlVk?=
 =?utf-8?B?WExBa0g2dHJ1dW5LenFnVXpaVWlOUE1wckJVWXR3Z2R4ZlJqbmVtS3hqdWNm?=
 =?utf-8?B?ZDErcVhreHhpZFFnVnlaOEJkaFBlWkVSb2NJcUU5dW5GOHlUNFROVGczRC9u?=
 =?utf-8?B?RGNzamxyeEpOYXRLL2I1akNkV011MUdidkRiYWdoS1UrSytZTWlVSyt6OUZu?=
 =?utf-8?B?NkxjeE9BUFlOdTRlSXdUVmpwdDc4Y25aRnZVSXVya2dxOXllUFE2RUpCUlVu?=
 =?utf-8?B?VXBnanNMK3hqekpxeTNXT1YwRkVmeEN5cDhEOFVxb1FLUWdWV0dtSkw0enlB?=
 =?utf-8?B?b3VTSFdVNW5SUER1b3NFaG40OHJRRjZTNHF0M3Ezc1dQUlUvemdpVGk1ZGU2?=
 =?utf-8?B?NXVIbVBsWmJHWTJ1Y3lBenVXancrWkdYR0NwS3FTZnVrSXgveDk5RU1jeWpR?=
 =?utf-8?B?RE1LT3J0akF6V2VvYy9uRjMxWENyT3FuZmhLdmVsdG9MRy9zN2c5NGVtdlhi?=
 =?utf-8?B?dHBsa3FDeHBXejY3aGswbnI0T3VpS2RXRG9JSlJPT1FZWXM2eDluNVg0MGRv?=
 =?utf-8?B?T2xjNDRVNTk0eDNZTHZEbGdkUVNzcmdoTXZVREQvRlFwNGZCVStaNWNQb3N3?=
 =?utf-8?B?V0haNU5ReWhvYmMwUzY1T0M3RlgrVUN0am1hVTloaDdkOS9icmFZZGV2eDRs?=
 =?utf-8?B?cWk3eHZQSWF0NFhuV2FwcENxcW82YkgxY3FLaUVydXJib1ZIdk5iQXJhb29p?=
 =?utf-8?B?Y0NGalZndWx5N2dSYm5qVGhOeUptMk1aQ0pWc3RDM2ZVdDdCcmViWUYwMERk?=
 =?utf-8?B?RWN2Um5iMk9RR1hwbjh6Wi9zOHB1c1VpU01YYjFHRXJaMXBobmZLbEF4bFZy?=
 =?utf-8?B?elhVRDhCY1JKRmlBeEhlc09xRkxwMW9mUS9DY0oxMFVRdDJqcG1LYjRRWUZF?=
 =?utf-8?B?MG1oT0RpV0JhOGtYdUVMZHQwMkJjS0l5VjlMTkYwTDBHZG9tWm1sN2RFSHBz?=
 =?utf-8?B?MFNwaXJLWEtaRUorKzlpd3ExQWR0UmhjaHdidXEwdFZWei9pNGtGY0w5RkZk?=
 =?utf-8?B?Ry9mZ2QxS0VIOTFIMWFCN3pZN2xJVWJnM0JmMzVDOTFuTjVuWExoVmxFT1Rs?=
 =?utf-8?B?Z0Vtb2ljbjViYVJzZGdOWTh6NkUrQThWWUdqNGdVZi9YbWJ1VEYrRWVWWEdO?=
 =?utf-8?B?SFlaanVmSGhpMnErRFVBYnVtbWVxVTJQQ2pxcXNob0xmSGFaSHZ6azVjNzNG?=
 =?utf-8?B?ODZlWkdITzM1YVpOQmRaRlVJTkZCckJ2bGdPdG1lOEVCaW10N0ZnZ3pBckpN?=
 =?utf-8?B?VXJYeFZrZmx6TzFtb1IxQlRIbXFvdTlDZmFjTmJtRXdZSkZHcDY3cnJ3UzhC?=
 =?utf-8?B?d1k1dWhIRmJnYkhOam5pNkJTVWF1emF5RVlUWm1SSFNzSGNuOExteUUzUnl1?=
 =?utf-8?B?eUthR21uelFnRjdPanR0QXJrM1QzSldxOERERlAxSmFQOU1pZHljc1F6NDhY?=
 =?utf-8?B?QjlvWFZDSytscVRKYlhwblArWGZIYVVBZ0Jla0tOdHc3aTlDQ2VDakRTTWpZ?=
 =?utf-8?B?NjZ3TEVOOGJzcDg3V1NXSksvWHNEenJMUXFtRjUzM3A5dThjOWxnRXcxY243?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258f090c-09b6-44c3-49b8-08de23a9b90c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:14:59.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frbaBYC9oTOFTIIgaJgx42cYdHNU1uCgCWSWod5IJLJabOr8k8O+0Idy68+9yPZSPwKDAppnNctLnBJf3zKHCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 18:15:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20568

On 14.11.25 12:17, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This package installs functions used by multiple initramfs-hooks
> introduced in isar-cip-core to de-duplicate code.
> 
> Currently the functions are:
> - wait_30sec_for_condition used by the hooks for abrootfs and verity rootfs
> - find_root_by_part for abrootfs and verity rootfs
> - scan_partitions for abrootfs and verity roofs
> 
> make increment posix compliant
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/cip-initramfs-functions             | 69 +++++++++++++++++++
>  .../initramfs-cip-functions_0.1.bb            | 20 ++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
>  create mode 100644 recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> new file mode 100644
> index 0000000..0bb6f23
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# check condition with function given by argument 1
> +# if the function does not return true(0) check after
> +# 1 second again and wait for 30sec

"Check condition by calling function given via argument 1.
If the function does not return true (0), check again
ever second for up to 30 seconds."

> +wait_30sec_for_condition() {
> +    check_condition=$1
> +    if [ -z "$check_condition" ]; then
> +        log_warning_msg "No condition given do not wait"

Is this a programming error at the caller site? Then panic?

Or is it a feature, and we should simply wait 30 s unconditionally, and
without a warning?

BTW, the message is broken.

> +        return 0
> +    fi
> +    time_elapsed=0
> +    while true; do
> +        sleep 1
> +        time_elapsed="$((time_elapsed + 1))"
> +        if "$check_condition" ; then
> +            log_end_msg 1
> +            break
> +        fi
> +        if [ "${time_elapsed}" -ge 30 ]; then
> +            log_end_msg 0
> +            break
> +        fi
> +    done
> +}
> +
> +# only for abrootfs hook and verity hook

I don't think we should document the user in the library.

> +# check if the device "$ROOT" is valid
> +find_root_by_part() {
> +    found_root=$(blkid --list-one --output device --match-token "$ROOT")
> +    if [ -n "${found_root}" ]; then
> +        return 0
> +    fi
> +    return 1
> +}
> +
> +# only for abrootfs hook and verity hook

Same here.

> +# scan paritions for the root device defined by

partitions

> +# the function find_root_via_image_uuid

Should we make that find function an argument? It's not provided by this
lib, so it's a layering violation to call back.

> +scan_partitions() {

Rather generic name. Maybe "scan_for_partition" because we are looking
for a specific one?

> +    for part in $(blkid -o device); do
> +        unset found
> +        for scanned_part in ${scanned_partitions}; do
> +            if [ "${scanned_part}" = "${part}" ]; then
> +                found=1
> +                break
> +            fi
> +        done
> +        if [ -z "${found}" ]; then
> +            partitions="${partitions} ${part}"
> +        fi
> +    done
> +    scanned_partitions="${scanned_partitions} ${partitions}"
> +    find_root_via_image_uuid "$partitions"
> +    if [ -n "${found_root}" ]; then
> +        return 0
> +    fi
> +    return 1
> +}
> diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> new file mode 100644
> index 0000000..a94d03f
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#

newline

> +inherit dpkg-raw

newline

> +DPKG_ARCH = "all"
> +DESCRIPTION = "helper functions for cip initramfs-tools extensions"
> +
> +SRC_URI += "file://cip-initramfs-functions"
> +
> +do_install[cleandirs] += "${D}/usr/share/initramfs-tools/scripts/"
> +do_install() {
> +    install -m 755 ${WORKDIR}/cip-initramfs-functions ${D}/usr/share/initramfs-tools/scripts/cip-initramfs-functions
> +}

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

