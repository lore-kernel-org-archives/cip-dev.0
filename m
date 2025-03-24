Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B3C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:26:32 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.37])
 by mx.groups.io with SMTP id smtpd.web11.36787.1742815573484050756
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=0EMuWuMf;
 spf=pass (domain: siemens.com, ip: 52.101.72.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihepBKQhx6xEk3e69cZcsnvQ4AwoLh2KGKoTCZq/fW4+KtiYRKe7v7H1V8xsDFB3SSmM8+96aaVTEcibQf12+r4hWssXqBZ83ouEEOAmRY2gpck7q3TIYpGARdmkyCI9XACXbe8fhrSF8uBrTNQJtWGXQ8x3oHXe+OKBKf4sUFrj32or4Mjago31sBStyy3MYhRKxFUUgSZc1QSRd9eOwjKNT2EQ8CT2OquRRJ26X31zlUetMwA1lLz+DI1N6R320GeYOd9oEhxS/bZtii9iNUCQb16bLFKBPRMOYTIHCDR941ZB5+mXyQnwYPZd2uptdVmCid2v/Cfmauzi0muR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB70erLlPHoPrJSKp5aCkh2xbrj4ynHzg6TUiTnwLyE=;
 b=lVDknkP89IGl/Xt153Y8a86QJP6WXgi7tgVo4GZyvx2ZMSyrXwVRsFJQAdlbA6NEmdoFJqcnT+jnxoXxQsZHUaBzG92QHzXRx5oP/GfqpzT8mpd7+m5VnqrDDjdIVaGrZXfrczwTwGF0XSKwiIMGR2mZufeRMdyT5yc1gSG3qYLyfdoWSiEjruNa7h7M/GR68soDmX60m0gfxfqutqJ92WxRkTECRqL3FMZz+0kXouzC9PCysDwh3jYv3hjhoRUjUDPPDOooOik5dhkQ4IPM+C1TUIjGGD0+GXMI5NC84Z9Sa2IOCzXxNnIh73dQepuXjOwAKppdsfl92pMnPKwRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB70erLlPHoPrJSKp5aCkh2xbrj4ynHzg6TUiTnwLyE=;
 b=0EMuWuMfXMYNDc/dr22g1l4/6F8sZ39Yua2UCW8Wrjjp39D+mV3tllmxi2VIYQwM995LAZ2WtrmpAhDIvn6zuu50HU1qOb29sYbjvtIHlg/nRCUbpTmXqXKUaMmRUbEhWwZNJ8gcVEGS1hUAmhR4NrVzj1B7nkVgyWOMtPCNJ6/2TeIWaE0ziL8odBqKTFa2NefbSamr+hAYkKt5UZh27ZDrUJMbdrvRkZ6+yoLFdTmqTugmuOyJg+jNx5i4ypCt7vsFnl8PNfabs0KWdGxEfaiidZttA2VXsQNkR3nKJkBsIWuCgfafUaP8Pdx0CldfI7+hpEKsT7rHIjFik2pCGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:26:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:26:10 +0000
Message-ID: <28906b8c-c545-4335-be6e-b5d3a428c62f@siemens.com>
Date: Mon, 24 Mar 2025 12:26:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] isar-cip-core v1.7-rc1
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <6cc51480-03b6-4d42-b9c4-191b6bc17e0a@siemens.com>
Content-Language: en-US
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6cc51480-03b6-4d42-b9c4-191b6bc17e0a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eeab1d1-0849-4b3e-34e4-08dd6ac6ad51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T0h2ck1pRXZaV3hSSnRzR1VFeUplQThpdktDQVdpR2RuTWRjaGhLTWFueTU0?=
 =?utf-8?B?TmVHZzJSNHhNZ1NzVFExcHpqNEZVbkJqSmZoQmpJZmtwMnBqYVhZU0x3YWxh?=
 =?utf-8?B?dlZjTkxOcjVmeGVGREdYMEdYcC9NVWdFOXYzOTQyUjVKZTZac25jMXg0N1pF?=
 =?utf-8?B?TlNSL0xaVk5CV21ybEd0cWtnay9CbzN5eWtxNnJiZmxKRktUdVFPb0tIVmVq?=
 =?utf-8?B?NkNVNTY3SlJEZkpuSzl5MUlCWjdYNk13WmxxYnpaSGg1Z05SLzJ2MWNHYkpQ?=
 =?utf-8?B?MnQ4V2VmeXcrS2lzUDN4ZXBPbFBvNzV0VHlKRDJtU3RXWmNtalpMQ3FiTUFM?=
 =?utf-8?B?YXZWc1J3TlUwajNScTRMMUZ5ZTdxRFloZGh4YlFiOXJCVlgxN2N3RnRYWTRB?=
 =?utf-8?B?WWhPSjNzOWxhUnV6dTNRbDJJRGw5OTV6dHFNaVBGazZ0a1ZpSklWdWQ2V3oz?=
 =?utf-8?B?NnVDTHdhdTl5dU9RUURLTURmak1oNEZzMk5CVDlTZTBvNzl2TzBJeCt0djFU?=
 =?utf-8?B?d3pMUmJxSjdYMWZGVm5LWkhFbllVNzVJVW9LMHA3Z2VvWHJETjNmTzAzeWs4?=
 =?utf-8?B?SWhMaHFmYmV5RmRDc01lVERkYnRtRGJVaFMyNjh1QmQ5SHhqM1BWbUN1RE9R?=
 =?utf-8?B?cG42VTRtSUtQd1VuVVhIZHNISjVyQkhvekJpeW5SZ21Qdk1GdzNEVzJpZ1hz?=
 =?utf-8?B?aGVyM0sxcmxBRHJzRUlSWEE5ZUY4elE0cnAxRVNDRnQ4a0ZhY3FTZVBncFky?=
 =?utf-8?B?cGsrVVltN2J1UVI4VWg1M25IUEdFZ1EveW5HSTJQNy9mUkFKajZ6NCsydzhH?=
 =?utf-8?B?b2RGMGt3dGhnRVByOEJsL3loR01teTlZcy8vV2hDTUZjajE2WVBTczh0bkRm?=
 =?utf-8?B?STN3ek1pb0VhM2xpQnBDcXNBMEJHN3NTL3g4K2VxZnZWQmhhK1A3QUN2QkRn?=
 =?utf-8?B?VXN1YmVtU1ArQ1F2aW5VR2JWMENIa0NBb01SbG9UNS9JdlhoVEdtMW05TE1R?=
 =?utf-8?B?RGZlVFdSUTRnaWYvcXVEUytwQVZsQXhxRUFva1FHNmhxTWhSRzNiZ1VNUzI1?=
 =?utf-8?B?bWY3K2lJQStROEFQa1FuK2RBYm9pRzRZd2gyRGdoS0hLR1paQjdrYnVLdkhs?=
 =?utf-8?B?dkFTZUl0SHFRK1duTHZJNVVkQjZGS3hlVnNzL2dHdG9aUzBXa0QrTmxnVnVq?=
 =?utf-8?B?NGovV0dkNExGTWpQL2xicjAyei81c0dqV3FQQUMrUkNuRXB5OTlQRVpaa2p2?=
 =?utf-8?B?aTZ3eUFHZ2tHV29UM3pra1BMM1VRZFY4endUa1R6UGFUdXEwY1R1ekVvSWQ1?=
 =?utf-8?B?L1d6TGZSNmVROHZnM2o3eEs2NytLUFZaQ2VweFdBOGtML29TTWZ5dlFXN2VY?=
 =?utf-8?B?RnpGRmFWNDl2WWpuTk16ZGFadFJUK0MyamR3dFVJNzVpNHE3T3o5TXFROVV3?=
 =?utf-8?B?REM1WnNxV0xsNisxeTFJWjZLc3dBRnJWbWJXWnByWE4vQnpDNHZGRDgrcDEv?=
 =?utf-8?B?M0M4UURiOC8vM01uaW9ZQWtlYW9mZ0NpZmNkdTFQc2l4d1kyU3U3b1hzemxY?=
 =?utf-8?B?RnhZeUZVT1Y1Q0R2RDRDWjdHd0VMQk5vVjdrNGc3aXkyckc3NVl2VmN0YWla?=
 =?utf-8?B?M1NiVWFJU2E5QVc1NVhncnFBUE9zM2FtVzJLelZBclNHRFAyM2orM1hiWm1J?=
 =?utf-8?B?d0s5OVB0UU1wQytRY2FQVi9IVFdEeGk5ZFJId3NhVk5FbWszMytBR05EcmhM?=
 =?utf-8?B?MnkyUnlSMC9mNVYvMlM2MTNHUERlRUFyUUxsZnkvdHNoTHY3N3BYNTJxblRo?=
 =?utf-8?B?cjFidlVTcnpXRDBKRGsvQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0VBM0NzZ3hEYVhzM2diMTRmVkFSOURURmpIUGJLMUIxanpBZ1ZhTFJaZHVK?=
 =?utf-8?B?WC9heFhrRVRKNVoreXcwQktKMDI3bzErMEpJYVN4dFFFc1N2UktIOUd2YWJQ?=
 =?utf-8?B?ZktEb2pQNGo3SmRzK3paMkJLakxzeGdCd0JtNTY5SDU1TVpXVVN6eFJSMDZo?=
 =?utf-8?B?RXhNNTEzbEx2OVB5dG95N1E5eENRNFJGSldrQ0ZQdDNYKzF1RUJlWHRGS1dP?=
 =?utf-8?B?L09tSmFGTUZNR0VUem9zZFZvUmR1WHhFNVBLdzVqRGpzTjFlZm1CNFZwRlpl?=
 =?utf-8?B?OStUSFhtZG9SZHUrTDZpTWJGVXhmTU1EWDAzM2o1cFF6emY5YjQ1OUc5SDE1?=
 =?utf-8?B?VUIvNXlsV2grZU9veHlOYjZNcXFOODliSGR6VzRSaUpYa2lDdXgyVEZZNGlN?=
 =?utf-8?B?b1ZXZ00yVmdKaDdJVm0yaXlvYlpTMlZ2TmdlbVBpQStsR2JhSUc0akx2RWh0?=
 =?utf-8?B?WmJ3OERrY3VjcmQ4N2puejlkZmlxTHRGcGNIWEN4WDUyY2hpallJS2V1N2FI?=
 =?utf-8?B?Mmh5RmR0VnF0QVVEOUhpMUF0dnNxMC9iNFBpd0pxM3pjb3lYYTNmWHAxZ00y?=
 =?utf-8?B?cUIrbzhHWkg0TnVOVk9tVjh6UklZSlRvWnllajJndEFsNmxDVFBXWGl2Nm1r?=
 =?utf-8?B?RlB3d2JqMWpKc0lOUm93UVc2ZUpDVXNvWnBCcVM3M0VacXRwOGN0N0RwVDV6?=
 =?utf-8?B?UytRdXNONHc2STdjbXpIeW1pVXZJSGcvQmRKeVYrN3FjVStCL2FUNndSN3U4?=
 =?utf-8?B?Zno5RDNrNTVjUEsxNlE0ZU44RWkwVmxQL2tEcWtlRzFuNVF1dldiYXdNL01j?=
 =?utf-8?B?ODJGejgzeHZYR0JzdnN3QXd1Z21PeU9wOVhnZ0NXa3FNL05WREQrZzdSY2h3?=
 =?utf-8?B?VkZBa1JvQmhRK2tTSHc5VWdUSmhLRlBFSlFjWjE2ZHpCTWJFMkUwcGdrYTkz?=
 =?utf-8?B?cUJhUit3VFNqU2pZNjZLekxEa2JkemlVd2NDQmxmZDFoWU9ud0xVbkx6emxm?=
 =?utf-8?B?WnpJWXV6c0ZWcHVFMHBDSGdXTjNQQmwxa003NzVzSm9uSUFsYlZ1b3ZCYlN4?=
 =?utf-8?B?bUkxNTBBSzZlaGFrWmdMeDBsaCsweDVUOVMyRmFGOUFrN0RMdDN4Zm02Y2tL?=
 =?utf-8?B?OVVCTUxScHFVSHJMeW9vSDVuLzhZbmEzZC94b0wrSmhNZlpxemRNUGNKNVdj?=
 =?utf-8?B?cG84QnV5azRyRWt1WTVMRXFhVWZjZlRBeGRmc29jWlFEbGdhRXA0UEUyNy9t?=
 =?utf-8?B?T0F5SWlSL3RieWFjMnlDejR0RmVhRXo4bXlxSEFzMXAzU1l5WHlLd0s4d1Bq?=
 =?utf-8?B?MVBpRTA3SEZMRjYxWFJzNUJXWi84TlYvSHU5WXV1QmgwSElKNysxaXRRVHhC?=
 =?utf-8?B?RWh6aThpODZTRlJ4MjlDYW5qTjN5VlFFSWxra29tR1RzRGVMWFFWRTRhRlpF?=
 =?utf-8?B?eWdCN1JDRkI5bEo0ZHRnNVFYUWVCRVh4aDd4RTVxVXcwMnVOWXhmR1Q0WGhr?=
 =?utf-8?B?SGxHREE4amJLSm96Q3ZDRkkvcG1UdnR0ZUQwaCsxUVFQNVdXOU5Zclk2eFJs?=
 =?utf-8?B?RFE2enhnYkI4SzlUOWxtZTNGS01yMndYZnpJbFFPTFFZTkVMYXJoMWNCR2dP?=
 =?utf-8?B?amhjQzQ3QXJvb1NLYVpiMmpoNEhrcUFPY2RIY1dHK3ZvU3ZMaW5KZmMvajZ1?=
 =?utf-8?B?YlRiSC9SRnJMV1c3VkxRNzNseE9zTW9YaGlSTzI4ZVJiSmpJU2g1M2thaSt3?=
 =?utf-8?B?RmsxcmFsQnBqWG9BQnE4Q3lXTVNBRzVncStLMUdQc3dXTlpJS0I0eGIrZmd3?=
 =?utf-8?B?V1ZRMGdSWFdIdWp6U3R6UDUzaFZpUWhlQ3lqSXliVGJVVU5aYkhXTTFCVEpC?=
 =?utf-8?B?NnlRSlVPYTlSMSswYjVzV3drdExqWEdLQXROMVZ6ZmFRT1cvUWwyK3psKzlv?=
 =?utf-8?B?WEFpSElPWTlucW9PTGw4YzFJLy9xWC81TERTU0x5STg4TGh1YjBqclIzTU4w?=
 =?utf-8?B?OGNTT0RETXo3d21TZm5WbStmektMbVJPNWVLTDF6ZXZlakRGQ21Qc2VGWm5Y?=
 =?utf-8?B?QXREYTk4VUxHYi9oQ3hQMFg1QXNoYlpBd3dkNTlpaDBlcW84UnJkUGxDcWpK?=
 =?utf-8?Q?88gYZV3krTmP9SSVYYWT3gQwg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeab1d1-0849-4b3e-34e4-08dd6ac6ad51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:26:10.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTHvF1oPW6EAKWY/Lwh3y6zNe/65bxbg/6XLX39fGSmRpimgs+37ZlIhHFq3iG/fyVFMAl+2ZcFQAss7a2IYvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9131
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:26:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18341

On 11.03.25 06:57, Jan Kiszka wrote:
> Hi all,
> 
> here comes rc1 for the next isar-cip-core release.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.7-rc1/isar-cip-core-v1.7-rc1.tar.bz2
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.7-rc1?ref_type=tags
> 
> Please test carefully! If nothing goes wrong, the final version should 
> be ready by next week.
> 

In case you already wondered why there is no release yet: There are
apparently regressions around the IEC tests, see [1]. These need to be
understood first, ideally also resolved.

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/128


