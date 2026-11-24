Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16024.1795519813097710238
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:30:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sb9xgYVa;
 spf=pass (domain: siemens.com, ip: 52.101.72.0, mailfrom: christoph.steiger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+c997UeeToXIsNEVtk8bwPvkHH6Nk8PwxW/8PlKIn4pQkvZrM8JI8foc978K+1oPdL+Ik2JYWG6KcBPGG1x4Z3YLROEBgSLsK/5s7RhOlXYOtMYm/sM5HS+01nJCfNAnyZ06rn9K48qmTKxpECQCAm739bu7zykEKk96u2uZsx0Jf/Is6AWrzxJ45B8HsN+FXdZ/0I32jiigrEmaWLqOCl7aShzLFq8v98UQizwAgScLfAzBCzl4CzbUUOfrZWsgsuZQWkBGhoBCaCb15DG4OJvIxlDy9FBvF4xy5WwpugPlzRjXbAy0rQEPq6uRiCNQ10VzUcebVhgLNnqQNfevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIIoNgmUtPCRPzu+dV8DbBrtz7wsQxeThxkXo6Gf6fk=;
 b=YmGBtK1ppVcRddR8kKC0jdEtSqie2MO/GF2qGbxf9ZxNU/I1E+oHdjzgXZmgaPD29Ck+IQTFqfyTC4G1wo9t2HHmyFgnaeA5BANL+guDEIJNjlDlD/TAprePavI2SgjMEuaRnj0wwRfNJufqevncK39C+exqm4SD2glHPA2lp+XP1jlOVLK+syzVGCWSkWt2dP0M8IUktE0ayomKEc/K+i6dK2hhFn/x/g2tAiwtIeVdF/1FxHyL7BqdOJoRQWNwdIfXzhoA2TuuuMNP0Y2EwIt0rlnCLYFwlX36e/MK5ekDplKwNgjPHPsrAOVJY6c2CRMfOzLnkEtI1tgw7e9BZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIIoNgmUtPCRPzu+dV8DbBrtz7wsQxeThxkXo6Gf6fk=;
 b=sb9xgYVaZcyDTTUuVfj+5bfTWuth5Cuq0JcLCE/pqWFjpaH/4m139XjFqoAdCHk+rQq5wLE2i03sWLGX+ljbJ1c+urkTqNsxuydKNuItDzr+NJIHghe1jWGGrAWctcSZdds6tgwDCL/0dwtj9fkb8ywZB74HJVj5SymCawhV1ZY60rZbWQbyJNhK9RUCbG3lV/yg08KM8UEUejEQ3DU+kEIduXiwzeKWHwTpuldEbPiqvAOZIee6ZSumW8YPvDqcNejdcilf5tCNGs44nb2DyYPktkd1TKyL808Fv1SbRMjDJ6bIOUC1zgtegK6q3ebrG0ij+NFsP2ewdnckKNrdOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cf::9)
 by VI1PR10MB3263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 11:30:08 +0000
Received: from AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7]) by AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a827:e723:4265:20d7%6]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 11:30:08 +0000
Message-ID: <0bcaab92-0216-448c-b075-dfb5ca57fddc@siemens.com>
Date: Tue, 24 Nov 2026 12:30:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Kernel Vulnerability Triaging and SBOMs
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org
References: <b62df3a5-fc1a-4fbd-a81b-0ffe38d8d854@siemens.com>
 <awVzBxSqWVci3OZx@duo.ucw.cz>
Content-Language: en-US
From: Christoph Steiger <christoph.steiger@siemens.com>
In-Reply-To: <awVzBxSqWVci3OZx@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:6cf::9)
Return-Path: christoph.steiger@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR10MB9423:EE_|VI1PR10MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: e066b216-f21a-4c92-ca46-08df4a1e4ae6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261028144727099003|56012099006|11063799006|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261102123227099003|55112099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n105GNM38f68kuwTMyZebzJlb677GA9QXZ/QNT9klwvNWqXcz8DrMovCk7bU/Hmj2H0JiqiB5hwK18FTTAUlY4PdTcNyhZgM3WyHVQX4DEZWgCIFPJaj/GUl8QhPQuWdYKPFfXXX7qMBUnjuprv9MuedfUNvX1y6OFcARrBuPuT3oLk/uQoYbd28bA96NtTROmBho3sUgJj+7S2tTJsXPxnoNd8LQfXc9l3DfPgOx5wFBz7sl2XU6NfP4gaKGil7nutr63vQjRKCFtfpWZWbP5pETf8MVvBaFuH+A0EYouClAv/ZkzXkOXc01rhueKfhQpGqOQpZvE7jIYXxdREiWscTrOuI039FreRpafXQSYqKyEsur3pkd/SOtWz5nOFy6/5mlc7FbHNyAMZia7Uf41VQe0JINCSrsz+8QoRzFV7gB9twK/XuCEQscUxmVwzp9QnzWZRpJxamtvAGJXuxMLSTY6tfVFsQFvgww2EYbVUj24ln9x1p4L+h+e38sArjAK76p55CF7QIJUK6Frug5IsU6LUqzdnVJy4tZc9GelEsoLmIXKT8wGeeBRcQmw+0206qZtY4RYiWHwO6uKiGRZ4dJ0PA2p6U26LUwgPBc9QeCpyKeFszLZLKNGOQtTnH6lq7jfH1ZzScWGe4cIPuQWnLwLWqOQgojxb5+LwYeAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261028144727099003)(56012099006)(11063799006)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261102123227099003)(55112099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlOak9MU3B2SmxVa1RlbGFjK295QTJ1aS9MS002VzJ5cmYrTExEM0FzOW4x?=
 =?utf-8?B?dE54bDJVRHlYV1lTYkg5eHo4QmplMHhJNEZjajcreWZPc3BoY2FmS2VCN0pO?=
 =?utf-8?B?NjlCTVNWUXhkM3I4MVNJdC9ZYXlMdlo5YklpclYyMHVZSDkweEdBTGs3YjRX?=
 =?utf-8?B?M0NJazJCTzFSVXhoVDNiYmx6YTlrY1QrWFhoZDZrRldIVjM3bDBkajJxODFT?=
 =?utf-8?B?a21zcmlBeG12QjE2dGFkcWE3cXZmbzFsdk1WcDZZZjFQTzNOZlpUR3VSZzdj?=
 =?utf-8?B?a3FwN2Y2VEY3bUVXczVCMmlIRkE5aEtSVEpxQ0lCa2VrMHBvVTc3RnFTVEIr?=
 =?utf-8?B?d2N0TlkvNUJIK2xqTTJCS1VyRUhVS1JKMFIxYmx2Qkh6YWJQWnNtQ1BXVHQ5?=
 =?utf-8?B?ZnNES3NkOVZMS3ZkeXBiVitzTWtrRkRJbCtZTzdyQ0ZNUVdrS0Z3SkllV2dF?=
 =?utf-8?B?SHlXb1p6ZTNNajNZSFg1bzlQVzh0NXhra0xNR0NDU0dhOHgxcjJndG1teDU2?=
 =?utf-8?B?T0NQdDZxR1QzUWlGeHE1VW9Bd1dXdDNZTWRMQnlkSWp5MHFnemxGN0RJM3Nw?=
 =?utf-8?B?YWY1NEtVMGtKZG4relpZdytsbXpCS2xUdTVMVno1c1F2dHZhbnVyamdTek5l?=
 =?utf-8?B?cWVpK3k5NmhKZUV0MGEzd0VrYnBpRmpzVTIrV0ZINUZHNmxmWWxudzQ5U3NT?=
 =?utf-8?B?U01mZTErK0dlaUptaWlVQ2hVS0FtWm9RSkZsS1ZUUFRzbEZBdVNLa25YWnpH?=
 =?utf-8?B?TU5EeEY0U3VnRUxGMVgySXRUMHBKbStGVHIreGpGZVhLNTRkZUJ5ZStLNEJh?=
 =?utf-8?B?dnpHRC8xVFVkZ1ppNEszbHRDaEdtSFhVWGNpa2JZNnQ5ZmNkYUhQOWRvWkdj?=
 =?utf-8?B?cjJhTzM0ZjBBV2FCcTFFNVMzckVMaCszaWp6Nm9UNDhWdC9iU1NGa1h0OS9V?=
 =?utf-8?B?THNERTlxZ3huSFREb20xRVU2enBJWjNMbTRkVFl1L1lyYVlBRjR4d2lxMnRz?=
 =?utf-8?B?d1hlS0piejZlTHZUYkZmdFV1VlJ2UHpNMUpKSmNzR2ZxT2FBcERKZTdhTFpM?=
 =?utf-8?B?ZVBSV0QvTFJYSS9SUHlQQWxPb0FHVkR3TXUwZlVkamZLVms5SzFyc2VXbHVO?=
 =?utf-8?B?a1ZCYktJdFByRW4zSExCRVY1RWs5Z1ZhTDVkZTU0WFlxaksyY3ZQeWwwd2lU?=
 =?utf-8?B?UnpiR0JpT0JnQ0IvZ1h0clF0c1ZhaVc3SVIzb1pNTVRDZmdrNXcwLzk2M2dL?=
 =?utf-8?B?YTBUaStVV05qeG1tYmE1eS91VlVhUU1sWHdDTE5hY2h0VDhlR3dKcnFzZ1ZD?=
 =?utf-8?B?RUF3OVdiUG1iQmh1WU82aHZnKzBGTklHYjFCVk9oL3E0QXVZd0w4UDlNRzBV?=
 =?utf-8?B?ZFRqWWd2dzBNRWY2Wmp0RVdXVEdJMnNtR1o5cXh2WTl6RC9Ed215ZGdBY21s?=
 =?utf-8?B?NTE5QVJZTDMyWnRSOXBzdXI5MVRENzBPRDlTOWkvRUtsaDVrc2RnR0dPb3NK?=
 =?utf-8?B?OUt0L1lJVDdva1BHNG9nR3pXNnl4U285cWNXQ2htNE5mVXlBZ3F2UmV1RWRt?=
 =?utf-8?B?cy9obGhGeUpIb2VNaVIvdUpraVRSazZwem0vWStpMUJOYnRPUVZCVkpGSTdI?=
 =?utf-8?B?NzFXSm8zZURMcmowUVdnOG95OVI2UE8rNC8vZ3o5NzduMXhBaUlON1djcGwx?=
 =?utf-8?B?OXpxNWU3NHVXQllSZ2tEaHViZkJxd3Jvb2pzMUxvNnl0YUMwd3doMVNQYjV6?=
 =?utf-8?B?UG4rNUVuY0cwV3R2N2lYZXVrcTQ0bjNXbTJGeVhsbGxONFl2Z3BQU1F4aHI0?=
 =?utf-8?B?ckhDejI0Y0FkQjkwbnlWQmdpaW80ODJnSG9HaDFWanpwSFNFT25GbzhjcXhK?=
 =?utf-8?B?QnlGelZiZFRURmlGK080c1UrSnN0ZlB1cjJkaWYrQ1dSTnJIRFl4MmRrd2FI?=
 =?utf-8?B?VVRIK1pibkRvT0RQQnlvSWdTNkFyWEtlaWRnMnlvT2wvL094MmRONEIvL0dj?=
 =?utf-8?B?N29pck5Fb0VWTTJ6WjNmZlpvazJDMENjcC9uTCtVZ3ZiRFY4VlV0RHpKQUhk?=
 =?utf-8?B?NU55U1V4MGdVeUNXWVZZNzYrTTgyb1BCRUp3Z3VCOFFLSXpQSnBIV1NJcndF?=
 =?utf-8?B?RjNuY05welBWN2kwalZIV29BSjdTUnFkVkZ5cmNOUGRIUitMWmJFQVhOcngw?=
 =?utf-8?B?TU9tRXRneFNQQi94aTZ4QWF4bjFBUXh2N3REcFFLYllhM0hiSGgyVVpyUGZD?=
 =?utf-8?B?UzNqTG1CaVdUTm5tYlVYVENQWWFQbjBaZDFUZ3JMbEE1RlV1eDY0T28zalc2?=
 =?utf-8?B?QjNJQmZkOHAwemQ0TS9TN3BieE52MWF1dzJWWEpuWnhtbFphMWo2VjhXbmVF?=
 =?utf-8?Q?f97UiP2qzzjdtYxw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e066b216-f21a-4c92-ca46-08df4a1e4ae6
X-MS-Exchange-CrossTenant-AuthSource: AM4PR10MB9423.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:30:07.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NDnedTXmjYHIBCuogc4kvhuWe9V/564sWct5G7vlF7if+FFHOPR7YG38XeSJmm06uJKM4HazYD85+OdYvbhIhd9DMjIT8C6slDCAU1tweM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3263
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:30:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25060

Hi Pavel,

> Hi!
> 
>> I think it would be a good idea for CIP to also follow this approach. This
>> would give us kernel SBOMs, easy triaging and access to all tools developed
>> for yocto and the mainline kernel.
>>
>> For this, the following things need to be done:
>> 1. Backport the SBOM series into our SLTS kernels
>>     This should be pretty easy except for the v4.19 version, as some
>> prerequisites are missing there. The series consists of around 15 patches,
>> but is solely confined to the scripts/sbom directory.
> 
>  From my point of you... I believe we could apply such series to -cip
> kernels, even through it is not "hardware enablement".
> 
> But I guess even better way would be to submit them to -stable team;
> -cip will automatically inherit them from -stable for 5.10+. These are
> not "bugfixes", but I suspect -stable team may take them. You can cc me.
> 
> Could you do that?

I actually have been talking to GKH about this already, but 
unfortunately he does not seem to want to provide this for the mainline 
LTS kernels. Excerpt from the the thread:

[Me]
 > And another thing about the kernel SBOMs: IIRC they were introduced 
in v7.1,
 > which leaves the LTS kernels without in-built SBOM support. Are there 
plans
 > to backport them? The scripts work just fine on older kernels from my
 > testing.

[GKH]
That's up to vendors who rely on those kernels to do so if they want to.
Otherwise, just use a newer kernel :)

> 
> Thanks and best regards,
> 								Pavel

Thanks,
Christoph
