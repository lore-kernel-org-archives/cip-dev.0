Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BECAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 16:20:43 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.44])
 by mx.groups.io with SMTP id smtpd.web10.1760.1757607634754380853
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 09:20:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FpJukj5U;
 spf=pass (domain: siemens.com, ip: 52.101.70.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQauNSUxB2pIBlpxSuY8jibTPpPHS8vVCoS17lmblp99+eOoYZy0loHcGpAJ+qBcvoMQf7yistjVA9QQiyl9wkYoYjCEuOsJ60rLqeNzBgnVsSjXKezzc6aO9Y8Ht5fot1OX432I7H48yibQNH523FcgNa5lljD2n1FdhirAnr49sX+Ob6m/OggnmLJVvegUIm5MSrrPpxizdNbGhpKmYWbdibXP5m1td/yrjo70rF++FhB7mvHkpVNILw+vecAwGSV9dFxmYeZWLbDaOofG1xo0FGx0jAmUUNCQaVZ+LRw1wBVqmpwU9qQfmf7cpnhV1JQLfYhH7m7QBoxloGkMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV8Q6MdY1YqWpM2hC43/nXd9w7k3T+36a41FhBAX4R8=;
 b=huXx/oSbCke/qNuporYJRV9LtBLg7greRus3vCjBarL0gFMfGCUniJoV4puor0jt6au5if5vu4aXqDXxC2TYaPIaL7fd3JJP3vcCXxIBGcsRnX4i+AR2Hnk9BgljgqVtcKgOgh0U95dqISeBp2Lqb3dOq/U3zSa48Wjsw16rXR4DmX/ra6PS+geoKeo+ztlCguiNRkkYLCT0oQgn4DEcy3cAF/E3wlmpQ4mf81ZrYjjCTDAhFLZKfqprlcfJAq1PvDnhCPFBZE7a/wkj7t6nv5D7G5oLyeWDSn2hSOlc0FNsBMPgrQob34eBd1xjl43rRqmhF7Y5ATscEqIkPW+axA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV8Q6MdY1YqWpM2hC43/nXd9w7k3T+36a41FhBAX4R8=;
 b=FpJukj5UF1Um1m5Tf0JRfQcQsHlf9DlVEuezA1FPnLZgR+2eV8OEhZVzWITRkdU1RYV+DZaY/KPS9s951ZiY4WpxPMvOdABZVOOr/ugdz9BCcscBYNNk6H2KFpNUPrlY1rMvja4Lo2aLagPW8nzXOttyYw/KPGUC22mYweYsCkgKvh2mSKa6+Wef5OGOTIdrK3FId+SLuQLAoGxSs3CNSLkKwA0EiVRAZiXFim2K1umQvPRK1H7to5P+d6m44/jCsu3PiNZsE2RC15NmVn70jnmDhzeR/TkSL6vDsszTxTag3dXYEcL6TXwAj8kK+zwgI1OOIgFI96/WfwuV4een+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:20:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:20:27 +0000
Message-ID: <edae4620-52a3-401a-b9c5-3013a64d99dd@siemens.com>
Date: Thu, 11 Sep 2025 18:20:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 3/7] Set
 PREFERRED_PROVIDER_factory-reset-helper for all machines
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904095231.2039819-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7151f15e-e99d-4428-2a21-08ddf14f1e60
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TjMzZnhUUThGblovbGxRaWh0NnVsU3hFdllmbVdzNmtKQ0ZFSklJckZMSEx3?=
 =?utf-8?B?MHBYQ1g5V0N6WnNBeUhnU1B1MlZXbExZK21tcXpvWEdrWW8xckNLVyt4RXpU?=
 =?utf-8?B?N3l5aFk1YnFidUNQTExieDFmT05aSTZrbzF0bzVRQ2xXYVd3cnJCZFM2UlM1?=
 =?utf-8?B?cGVFK2dzWWZaQjFLVDJMR1ZTczNMa3BzeXUvY3V3VC9wc1FZRU1PTW95Ti9T?=
 =?utf-8?B?OFQvNU9PdkRPcVZNbW8vbTRwTldNRWczM2JBN2ZlVXc0RkhYd3RuRzJHRFhF?=
 =?utf-8?B?a0Z5bXEzc3FkbDFtVGFwYU1aTFNhTjhsUHZqMy9Fdzh0dzRLeVRIa3FLSE9H?=
 =?utf-8?B?R2d4WjV4aldNMVQrMXFhdHR1UFo4Qll6cjM2dFFOR1VTMWRWcTB5RU9IdVhs?=
 =?utf-8?B?NUMzbGppODlBQU1OdXpSWXZVTnRETVV6dUNYN1o5ZmQrdjVtMGkxUGJyWk5X?=
 =?utf-8?B?MnNCbkpKZnc4MXpZMFpBYTF2eE44MmdUNUtESEFTRi9TNlQxQ0RYejd0REtS?=
 =?utf-8?B?R2wzdEUvTUhOandHdERRRlhRcDN1bU1LRWZWUyt4Y0F4NWk3QWkxZzVOUUJW?=
 =?utf-8?B?ZHNNWXJIak1DUWNiRTYrSGFqRDVhV1g4N1J6RkhBRTFYNzdZRkVpZTIrbUtj?=
 =?utf-8?B?cnJ1MSt0ODhkeHFXUWMwbHYvQXBCcGNlWjJWZ21rTGlUYTRqbUFzWk5XSjAv?=
 =?utf-8?B?cTFJamNFSVkyVkxJODFuUkllaHdpZEYvRFdycHRONmo2Ukx0eDdIRTgzVkVh?=
 =?utf-8?B?YVplSzRNM0ZvQ1pGTTJyN3czOExmSHlObytrWW5sTUMyT1N6bDZkTktVUndT?=
 =?utf-8?B?R0pDOU91RUxCSWhvN2kyY1FrLzNJUEhVcjQxOC8wV3B5em1DeVVSck9iTXJH?=
 =?utf-8?B?c24zaVBNN2N6NHRzQ1hDZ2pjQ0VNSDB0dk5kdmhkRzRYQmczcXk5eVZ6Umx1?=
 =?utf-8?B?eVpxOTZsR0lLV0UrK0JrL1hrUXFQWDI1dG1Nd2dEc0FQVS9xUk1iZjd5dFlF?=
 =?utf-8?B?VXNaekdUbHFwM3pvdjhiVEVhRHJYZlVBVXo1WDlYNnRLVWw5NGl4VkVmL2lm?=
 =?utf-8?B?MWE2UVE2N2J5VVdBWWZ0OFNKZFlWZUVvTTFoZHhFaFlEZkNVSFNaa1g1ZGlJ?=
 =?utf-8?B?MVZQYk1qeE05b1FZM1lUT1pSZ0RLdDc0c0hpYm53VFBLWlFmSTlvR3B0K1gz?=
 =?utf-8?B?OWJKTWkrcTFvQXBzWkM3TDYwdXpSb01kVHVNdG1YajlDQnRienRxOUlwUWpO?=
 =?utf-8?B?cjZqR2Q1L1lwZGI3cXZmYWxxeitRUVM2VlZETXh3WE9KajhnTUZ1ZnNWUDVZ?=
 =?utf-8?B?cnpyQ3cxd1JRTmVOd3AyTGJLWlBvdmU1VWpjUDNvTGFrZjNmUTh5dWxob3BZ?=
 =?utf-8?B?UW1mRnArV0ZDYVFRZ0RuQUVWN2tCQzIwY28xV1dpZ0RBdnBidDJvcGw0V3Zt?=
 =?utf-8?B?cGVBK3ZKVENrVG9PQmV0ZzMxbU5acHl5WXRnNFdyYktuYTVSN2FJZ3ZQNlFo?=
 =?utf-8?B?TmdUcDJTWkpVWkFGaTArcXNocDNUSGtSVXhWQks1RjB2WUVMUllOazNkZnd6?=
 =?utf-8?B?SjE0azQ1RkJycGs1c2R0bzZGWTJFS1JzRU95MTRVdUhxN3FlUkhKMEVLVExQ?=
 =?utf-8?B?ZmNPanJuUmF6MjUxekVjTlVaWjJOS2JWbjdhajdYUTFsWmRRVmErNXY3aFB3?=
 =?utf-8?B?dTkySHA4Y21tb2FWSEhLTzhmZW5SVXdKY3RPaC8wdC9iNmNWdU9rWUE3ZUtq?=
 =?utf-8?B?N0EzRGNGS1RFVC8rNlBNL2FOdTltSkhKOTZjOS9Wbk5qVVB1UXhmeFFmQ1gr?=
 =?utf-8?B?QkdNblhWNnNZVUlrbUsrcG45czUzRzAyMFA1c0R0NVZCUlkzNDdmNk9VaW10?=
 =?utf-8?B?Vzh2N0x1b2U3U2VYUitEYnhRN0FkZ1BHQzdXUXdyRS8yM0EzUXI0UzZTU2Mr?=
 =?utf-8?Q?9EjyvQuLGs8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjdkU1Qrc01QbTJZaUJjM3RSU0xQR1VmV2kzc0txWHVNUWlTYXdNVFVTdDVD?=
 =?utf-8?B?aHlNd1hvT2xaUFd5alRDMzhwc1J2dGMySmIrNzV1N2t0KzJEQ0tYVDh6Y0Ra?=
 =?utf-8?B?UzdnQ0NLWlJENFZWU2ZvcU5id0pLd0MxeXE4SkFjeFk3dk85TDNxOGlTZ3M4?=
 =?utf-8?B?UWhkUnFuU0l1aXRldG1OTFhCcFFWMk9BQmZWdDZ2K1R2a1NaV0FXYmdyWjhJ?=
 =?utf-8?B?QVZLUmRtR1RrU002ejA4S255MVZBWmZ5a1ZTNlZrK1JscjNSNlc4S3RudDVL?=
 =?utf-8?B?RDAxdmZvUHYzaER6Q09CSFhHVUdOKzNnV21XN2o1WEVOVTNVb0IxVjdJbHJq?=
 =?utf-8?B?cWtCMUR2L2h0NGY0U2pkcGJyNlIyOXRyWFBwVEdLdGZmcm9Hell3eEJqZ24v?=
 =?utf-8?B?d0czT2RQMXU2akx1V0l4RWQ4TFR4dzVsUW96Lyt3UU1hMjhYMEtzLzlOUVZR?=
 =?utf-8?B?dzRiUzFrazdUa3Z1ejhHZGIrVGVKTUl6T1ZsMU9yMk5yLzVxbHhOaDExM1RK?=
 =?utf-8?B?Tm53WXNTMm9DU1pXYzVjS21jVVFsNVduMXlZcWY4MHl1OXlzK3dMMWpKS041?=
 =?utf-8?B?cm9xL0JVcW5FUmlUN1p2NFZrVVVmYURyZ1RZWlYrNHFRN01Ba2R5cU5sZm1i?=
 =?utf-8?B?bjFncEVEcytyWnRQNlhlK1ZDQ3JPbmtBb3BXQ01qOU5RdmNDcDRxcXNSWFhj?=
 =?utf-8?B?YTZSU1Z2cUlLeTA4OVhkSkF0eVN2TEhXRy90NEQrb1BtNDVVUEtZdEg1Qisy?=
 =?utf-8?B?clYwMzlmZTBBbXFJM3RoOTAvYVprR0VaSXVmcUVUbk1NdFdoS3hvRUFEdlpU?=
 =?utf-8?B?SW1xeG0wQXgzcXJzOHZMTFJCOEdMOFJJYkczQzFvenJUc2hiL1FRUTVvZDB2?=
 =?utf-8?B?eTNRbUVycnFEUUtDRmVNek82c3FxbGkwWTUyQmxJT1JpY2FiaE5PRjE0U0JF?=
 =?utf-8?B?RWdjMXoxOGcySURRMS9Ba0VNNTBJeUswN3pJc3JIclI0MmNTR1pqNGJUYzhV?=
 =?utf-8?B?d000cHQvYkVVSW1lSWllK3NsMy9HYmJ5ZEtnQnRuZThHSUZQVmJkR21Vd1Q5?=
 =?utf-8?B?THI2QnFqOTNEY1ZQRnZpc3gxaG15ajNvRHJyYm9PeXFSdlBDR0dCVFE3WFN1?=
 =?utf-8?B?RVdNNVZTakFuMUZ2ak9MZ2t5Q1hhM2NQZWdpc0J2TnBVL0g4dURLVzFJNXBO?=
 =?utf-8?B?SzVSVzdSWk1hZTIzUG1sQjgyTHh4TDUvcFJUbTZRUmRyZCt2MnE4YXdiTC9S?=
 =?utf-8?B?SGV1T21IazB6VmJ0cjBwb3BTTFE2RUt4bVdab3ZBMnlFanExdWFmNmt5QXIx?=
 =?utf-8?B?cjA2R0JkeExxL1pUL0NOYUoyTHJCYUFuRUNINUc1cEFDZ05WSkJyNERqMnFR?=
 =?utf-8?B?VXdMSEpsemUrN1J6WTJKN1lObDJ6SlFGRkZUL3VTQ0p1VkRyVkZHSU01a3pD?=
 =?utf-8?B?SmcxQUlPM0pvSXNjTTVhZE00cGZvLzFJMWQrUTVnanpmd1V0aXhPZjY1Skk5?=
 =?utf-8?B?Y1dPWXpJUm5hV0puLzZ0R25aSS9XdG9tNUlmM0MwaEd2SCtCSVpFcEx0ajJu?=
 =?utf-8?B?Z1M1ZVZrOE5yK1JaM1hKZUZrSU1BTzJRaXJiVHJ1U0RzYXZRQUJ5cU5wemVC?=
 =?utf-8?B?V0ZuZ0V0ODNNbzlYR1lOTEx2clNXaEZOckpnQnFtdGZzbGY1bm5oMGdUcFV3?=
 =?utf-8?B?ZU9yeE0wYnVWZWNJNG94b1krdFo1UVdjWEs5WlQrWWdWS0lyK01ZR3h6bmZ5?=
 =?utf-8?B?dDBDL21rMEcydFhnM3FMdUdKM1NZMG16MEpZZ1FQWWVzcEVPZnBnSXFwK2pY?=
 =?utf-8?B?WXkzTHZ3OUI2OWkrZDVJeUUrdmtXNFNOblpCZWZvdkdGRGYyRFVIY21RejlJ?=
 =?utf-8?B?d3lHVWRUbzVBSlhhZmljZ1NQeTNvRTBvUjUvZmJnNTl4RkIwdmNWTFd4ZzB2?=
 =?utf-8?B?S2VoeS9veEpYSTM0b3ZHTUx5RlN3azQ2U21SdGZ5N2xMa2FPQThVSkpnRVZa?=
 =?utf-8?B?UTBCeEM4RGowdENmYmh0SGRqdTRVODFLTkcvZzdFNHJlVWRWYitsMnZvTVNI?=
 =?utf-8?B?SDJVaTllLy9UOCs1blJvR2FlZXNCZEJKSENSQU1iV3JLWkc3Rmkrek9FMjh2?=
 =?utf-8?B?Z0IyOVZxckhseHRwUnhBU1lZMmVIcTN5Ry9iR0F0MjBveE5zTUEwVWw0ZWtY?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151f15e-e99d-4428-2a21-08ddf14f1e60
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:20:27.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyCmPt31gWXupoZeztZ8JZOPRKFcT6TJjCx4kcNHp82f2Ffos2FoKe9y3v2Xd+kethBTbcQXaCtLNJp7xzrt8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 16:20:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20042

On 04.09.25 11:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> We use in most case the file helper as:
>  - QEMU arm/arm64/riscv64 do not support secure mmc storage
>  - QEMU amd64 needs writable efivars which are only available in
>    cip-core if secure boot is enabled

Nope, we already have it when switching to SWUpdate images. Should we
switch to EFI unconditionally? May also simplify the start-qemu.sh script.

>  - efivar wre not tested on the targets bbb, hihope, iwg20m

were

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/machine/bbb.conf          | 1 +
>  conf/machine/hihope-rzg2m.conf | 2 ++
>  conf/machine/iwg20m.conf       | 2 ++
>  conf/machine/qemu-amd64.conf   | 3 +++
>  conf/machine/qemu-arm.conf     | 2 ++
>  conf/machine/qemu-arm64.conf   | 2 ++
>  conf/machine/qemu-riscv64.conf | 2 ++
>  conf/machine/x86-uefi.conf     | 2 ++
>  8 files changed, 16 insertions(+)
> 
> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
> index 8c42ec0..f9ef832 100644
> --- a/conf/machine/bbb.conf
> +++ b/conf/machine/bbb.conf
> @@ -20,3 +20,4 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_de
>  WDOG_TIMEOUT = "0"
>  
>  PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
> index 0b3acf4..447745a 100644
> --- a/conf/machine/hihope-rzg2m.conf
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -20,3 +20,5 @@ IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
>  
>  WIRELESS_FIRMWARE_PACKAGE = "firmware-ti-connectivity"
>  INSTALL_WIRELESS_TOOLS ?= "1"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
> index f5d5dda..401ca57 100644
> --- a/conf/machine/iwg20m.conf
> +++ b/conf/machine/iwg20m.conf
> @@ -20,3 +20,5 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_sh
>  DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
>  KERNEL_IMAGE="zImage"
>  IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
> index d786646..643996c 100644
> --- a/conf/machine/qemu-amd64.conf
> +++ b/conf/machine/qemu-amd64.conf
> @@ -11,3 +11,6 @@ DISTRO_ARCH = "amd64"
>  IMAGE_FSTYPES ?= "ext4"
>  USE_CIP_KERNEL_CONFIG = "1"
>  KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> +PREFERRED_PROVIDER_factory-reset-helper:secureboot = "factory-reset-helper-efi"
> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
> index d2dd81f..29adaa5 100644
> --- a/conf/machine/qemu-arm.conf
> +++ b/conf/machine/qemu-arm.conf
> @@ -17,3 +17,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_
>  WDOG_TIMEOUT = "0"
>  
>  PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
> index a2c5e53..cdb94d5 100644
> --- a/conf/machine/qemu-arm64.conf
> +++ b/conf/machine/qemu-arm64.conf
> @@ -16,3 +16,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
>  WDOG_TIMEOUT = "0"
>  
>  PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
> index 36d6d94..25b19b0 100644
> --- a/conf/machine/qemu-riscv64.conf
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -20,3 +20,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_mer
>  WDOG_TIMEOUT = "0"
>  
>  PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
> diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
> index 33f82b1..28ef245 100644
> --- a/conf/machine/x86-uefi.conf
> +++ b/conf/machine/x86-uefi.conf
> @@ -13,3 +13,5 @@ WKS_FILE ?= "x86_64-generic.wks"
>  IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
>  USE_CIP_KERNEL_CONFIG = "1"
>  KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
> +
> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-efi"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

