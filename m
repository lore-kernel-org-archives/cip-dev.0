Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D70CAC598
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 08:45:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.54])
 by mx.groups.io with SMTP id smtpd.web11.28059.1757925912052012203
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Sep 2025 01:45:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cqRj+VJu;
 spf=pass (domain: siemens.com, ip: 40.107.162.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhZWy8/7nLYFxdez50KGVgCIGLxd56btPIxrqP37Sd7bsYp/AbYM28MPliDjvsPt72x/wEJhlUJQIT1PFzHcPHKxdmBSCv8PXLWrIeuDHKQW+AoburpFWfjr7vmZo907ReqSVgFXoU9K6k0z0zK3k4V8KZbMXs+np2RSht7iLuic/YUWGopyh5LzNpVb4qDLqszy98My3UizvmUhM8mGBq4qwP7KcJ3Mov+XmGRa2CjK9oO56DRtowg9EimePvu0NKT0mFaYpGjrfkMa5rpSglocHNMZDaiA88yHOw/PxYzDyAbQKFO8lWj6VXFnhxyjTQ4a0Gp3CrHHW0R6xpy2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubGX0WR/EwOwnsQit1XyOnVnSvaXlfXiXxkJ5xCWkm4=;
 b=JVWGfp6HVaFdDlUcVkJo+DVeG9nRmALiv62d3qOitwkkkBQpQ4icrHS2Pg0RjpMK4n+zNjO97fzwOzsw8q0ys3blx7G/pIDp6xaYPFOrvT57RvtGKrlECsy07W9ne+1GU5rcSGSYfKl0n9gNw5a0RJpYrzhSTW5ShnoIWPwx79Ko8JTmKRlF9+qJA8qo5tp8BdVwPacUikrHNUdQbkv/0x1nKo07EV7D7GKzpJ5HDuCsPC8i2hh+C15Se66Rew7L683Of15OmiTsRriq2BHvlQNBdfkh21VHS/fAaleZBS6m/zpph7TDjLqGCvgXVXBmvWb8w1poeu8wj+LK+R3HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubGX0WR/EwOwnsQit1XyOnVnSvaXlfXiXxkJ5xCWkm4=;
 b=cqRj+VJu1w5doQ667esbgPZ5xg+uPIHcRFLF8B/zS8MTMsUTrePk0NQkf6OET9d4QNR5x1T9yOJ+MWWQV3eGpny/VD9Aqfq/5JxNgKwpNGsw/BGtEMiFrXnckLULmtzWSofNcA88DVC1Rqu+h2UghNxKCf7HOAn+R5QNYVyaUa6IJLRs1zIlE3opC8XRFaOMRN2V0UZGR3PfwqZJl3erfAVGBZhMFy2dMQkfSSaQuD+6cyULscOvHlCYsdHnoylr2NEIt6H4QnukX1qUUMfT52x0ICnR7RF2WkUOcoArERfKlxrmwlvF83EY6eaU62u9rNthgbGEY/9WvfoQmfQbRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PAXPR10MB7629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 08:45:08 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 08:45:08 +0000
Message-ID: <f0bb6cec-71a9-419d-ad5e-3208b2321aa2@siemens.com>
Date: Mon, 15 Sep 2025 10:45:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 3/7] Set
 PREFERRED_PROVIDER_factory-reset-helper for all machines
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-4-Quirin.Gylstorff@siemens.com>
 <edae4620-52a3-401a-b9c5-3013a64d99dd@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <edae4620-52a3-401a-b9c5-3013a64d99dd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PAXPR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: e0aa61d6-f00a-48af-1aad-08ddf4342ca1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WFl2cjh4TnpzRDdCQ3FFZlZCc29rcUx3NWZlWHE4WFZNdTY2RFNlamFMVDFl?=
 =?utf-8?B?dzMrR3dGYnBhRjhpbVJaQUdWMFBuL3E5UjhkR0h2Q2h6SlVjcWpSenJRM09U?=
 =?utf-8?B?cXc2bWJmZ0dWNnFlejNFbTYxS2Evamk5M0trTGhGWmZGbWJ3UXJFdDhZU1pU?=
 =?utf-8?B?Z09wanJBSlZ1NnJJQlF1Y2YxSlVLZ0RKTktNOE5JaHVSdElyT3JBTUhlUDhH?=
 =?utf-8?B?L083cm9QWEhkaU93UzVjVzViaHZlaU56TjdrNjIyTWlZN2hNMHU5cDVCMmFj?=
 =?utf-8?B?SkFWOFRyWi9nUWlBSU52NHlJbzZ1a2FhNGxUSUdHSFRVZTBTWWJMS3JVUFdi?=
 =?utf-8?B?UFFNL1hvVDkrUyt6UkVCaG5lRyt4VWFmYmtSMkNKd2Z6bWxGRTRjUXhLREpI?=
 =?utf-8?B?ZENMamp5Y2xsdmFhMmJzcHdQcVY5T21XZUlKUFZSUXNia1dHMUVHZmFEQVEw?=
 =?utf-8?B?VFJZYXNUVkhQVU5MY2NDRHNnM21IczE0Y0hHRUkzMDExbkF1Y3prUk1uci9F?=
 =?utf-8?B?TnRESjRZc25tYVZjSE5xc003L3lwa0w4bUJ2azAwdTlOZTI2N0gwbklLNWVq?=
 =?utf-8?B?RDFLWVJSSy9iSGZZTGhOaDVjYmYraFJ0Tm9MSjlmUkJoaVJwRTBPVlJzNGdL?=
 =?utf-8?B?QU1VSk51OXZzVnpNYmY2a0RQOWQ2TERCdjR6aXhGZE5XeFJwdG9QYWI1R25q?=
 =?utf-8?B?amtCSjJWTmh5dURSYStGNzRRb3BwRTBoeHNLcWZYSFlNbjhvSFFnaTJBazZi?=
 =?utf-8?B?YkxTTERFR1l1RHFlVzVOdW5FWERNeEdHMEg1SUxFMnh6Z09wbkg2b1dxb2Ey?=
 =?utf-8?B?S2VxMktnV2pJejg0a1NKSWhSMUh4T3V4a1dub1pLTXprL2MzR0ZIdHBXRVhK?=
 =?utf-8?B?MXhGc2wzbFBCTFdDaVNYM05JQjhNS0hvOVNvMzRQZU9seGVHcllWY3JNN25r?=
 =?utf-8?B?TDR6ZHEvWC8xV0RIckExZnVwb3ozakJnTlJmQTZUSEhiTTAveElxaG5ialE3?=
 =?utf-8?B?Ry96Y1ovVXJGMUNOUmJXeS9QelhoRUF0dHJraEtYNjVlSkNTa3VIejlLRFdm?=
 =?utf-8?B?SmRHSXNOZ0M4dVVBdFo4MzBLS0xjV3d6TXhMa29PNDhTQVQzRnQzelVlQytM?=
 =?utf-8?B?S0h0QmxtK1FqbzRwTnduTHNsU013bDNtSXNRbGVTZjRNcjVGMlZUZUs3a3Uy?=
 =?utf-8?B?S25Ma0pMRXNNTndvM0J2QjFHQ1Y3SWcxMmt1RGU3R0lMMm9BTldzWVB5SWo0?=
 =?utf-8?B?Z0QyNDh6MHdhVkJRSUZrUzFPVmt1czliTTZRREFWNjl5MEtGejF4NnQxa1pl?=
 =?utf-8?B?MVkreHgzRVpGV2lpRFJEU0JhS29oU3VEdkpqUUJOSzJXR2FtbW1vZ1NuZFdR?=
 =?utf-8?B?andoZXRjT2IrY1dHWTlKWjQrVGhQWDlwVHhPS3BUSHA2ZTlad3hFNHZOVFFn?=
 =?utf-8?B?dkRpKzlEWVZrdEUzdjBWNmJ1dzBENXYzZzFiRnFJQVRFVU9pWE5ldHlsdEV6?=
 =?utf-8?B?bzRLT2RlZXRCNFdGUWJ0YUVYZHYvSThEaitrMG9aa1E5M3g1UTg1ODhraldS?=
 =?utf-8?B?TlhUbVVuMVpuRnJNc1hOdmlnbG13UDZMZXZlcHVsOFRLYmI3azV1ZnBqeVpJ?=
 =?utf-8?B?SUlGQnFEYm9CTGJiMFQ2VThCZS9HZXNTSExZNmZvelVDUjFZcVRmYXFFK2Ni?=
 =?utf-8?B?eDRBVWlpV29XQ2hUWmY1cWZjT0NGVHBDTjY0RkF5L1hOMlRVbW5ScmpNdnhY?=
 =?utf-8?B?cXBYSndHOFBwbW54VXlrL0F3SzgvS3Q0TG1KeHoyQzN2Y0pZWmNrc1dJYUVD?=
 =?utf-8?B?cUFHcm9SckNlSWdHWE5oOGtGV1FlcnFlK01KK0tTZUkrSjgvcXNPNS9ENGJY?=
 =?utf-8?B?OG5pS3pIQ0dRU2l6Um1lZXRkWURqSXRNL1p6Z2Y0YlNwRVpKYktycVFVa0px?=
 =?utf-8?Q?SQE9gZK7gKw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkQ2TVdpQzN6ZVk4OEltLzgrOGMxdU1SekJHWU5NMFNiRGR2ZkxrclVldGpK?=
 =?utf-8?B?UFc4MFppYWpjVUhpaXR4dmFxMVppd3E1ZHVsR1Y0cmxkQmN2amxtUklMNlc2?=
 =?utf-8?B?Z2cwZjl5K0NmRmdlZnJDNjlESmZFS0RqNmRXSS9wdHFoWXU2b0ErVlJKd1JC?=
 =?utf-8?B?QkhMMWF4SGV4aGZXT0E4MG1TOFZ5SXR6cjVCVysvSmhDNkhYRlVMalEzUllO?=
 =?utf-8?B?c3RyOWtpc3NRRlE2OHJoZ2JzYjBBYnVjdXVnVStJb25wZmQzYXBuTFp0YUdk?=
 =?utf-8?B?THdpOXp4eDBSTkFKVDRScEQxUVNlS09LaTZvYmVWVjJCTGlGV2FKRHk1YitW?=
 =?utf-8?B?K3dXVEhhRTBMVDBqaFg0UWVDeU5KN3V0dXVJTGhGRGJNZ3hYSFdZR0pSSkFU?=
 =?utf-8?B?em1PSXhLdlJzaHI5YVdSeVgvbFZZeURHYXFsQU5NSEp2RGh0R1A5Z2dNZUZ3?=
 =?utf-8?B?SWdadDdiZFlqcjlVdS9TQjFQdzR0Ums5aUpYY1ZtcHZVT0ZyYTVQdnZsUjJo?=
 =?utf-8?B?RmN4UHkwaEozY2E5NlVLcTI2bWhZYm9iRHRXNFdxcFY5bmcwN0dHa0E3Qytt?=
 =?utf-8?B?eGV3RzV5S3AwWFlveCtTTWs4WnpHQkJ6a2ttRStaelhTS29SNmZBdmEwODh4?=
 =?utf-8?B?T2V5MHppWEpaZGRHOVZDTTBHT0VKbjBtVkljcUwxOVpXQkFURlhoeStnZm1W?=
 =?utf-8?B?eVhRMGNPVUtqVGZWVVE4YTV0QVFYNHpUUlQwSjVBN1JucHZCVCtxdkloL3F6?=
 =?utf-8?B?cC9CL1d3dS9TTXd4WG1TdmFqUUwxYUcwODdGSm1IcVcxMWl1M3RrcnpMbmJU?=
 =?utf-8?B?Ykl5aEdqbGlUWVZ2Yi9mSjFIM2JYTHlSL0FQUlFwN1N2ejRPdlJSZTA1U1ho?=
 =?utf-8?B?blNtVG95UExzOEZpQmV0TXloaTdmY3ZrQUlLc1doOUpuR1c0b1hOc3IyMHpV?=
 =?utf-8?B?ZmZzVEYrN1hGQ1M5VXBqWm5IeVA5bGZGdVR0VWRCNHFyT2pxNU5USFlzN0Jn?=
 =?utf-8?B?cEJ2WDVEeGpWWWFUTjNPZ0xjZ082MWQzc0NSdldBK3Z3VzlkdWM4N2dBb3J1?=
 =?utf-8?B?UHE4czhBRDExcTBNNDZTbFJIdDBGQmxqSm9vdGZaOStRQ0xuMEdCM2k5ZEVO?=
 =?utf-8?B?aDJOTVNqUkxKakdHeU9HL3QwbXczOXhMdGVGV0pUMExkSC9rSGs4STYwOWMx?=
 =?utf-8?B?aVJpU1RyTHBJL21maWZ3VGdqWUNUZytOK2ZYQzdXVU1TMlZCUlUwaWhhb0hq?=
 =?utf-8?B?eTJuSUFhOXUxZ2l3OU5LMm1zNXg1eU9UaHNJdXNhQmVqblhHcDNwajYzOUJ4?=
 =?utf-8?B?OUppbzgyNTdVMUhDUEYzMWgyTmJQVlY0aGhCMTJmUGdBUVVYSjZqSFplb0RX?=
 =?utf-8?B?WkJoNkhhbCtsdm8yblZ1d3BZQThUa0pSSkJFNzFQT3RuOFRDVWVoeTNQSk4y?=
 =?utf-8?B?a0p5WCtZWTN5YStNd25LVmt2WExsYlNRait2VnhuUk5xRFF5b3FFQ0dzSGFF?=
 =?utf-8?B?alJYYTZCcUR0QS9mak1Dc1BHTGo4dnJETDQzeGh1ZkZnbVVucGZoSWdyaTVP?=
 =?utf-8?B?OXpXV0s5VXBIRUpsVlJ1QXlYbm9icCsxTXZacXhQeVkrcUpTRU1YYUFvZk52?=
 =?utf-8?B?QU8yS3JVT0Y3WlB5U1hUZmxlSnJpNUtmRWFVR0RSRTZNc0VUVDlYU3YwdXdv?=
 =?utf-8?B?cWJqNDJyWktZY3JrTkVaT29KY0VMVFd6Y2dWbjZ6YStKWU8wSnhLQXZCNzE0?=
 =?utf-8?B?NzZzQ0dmWUVxdi9TdkQwcEUra2ZqVUZ5Q0d6U2RBUmhONDNlblEyQUFMdWtk?=
 =?utf-8?B?V0xUWmd2RFZvcXYvY0phMGg1YS9ZRXY5UUdFWEh0S1hPcXJZdFZiZHhPaGhn?=
 =?utf-8?B?ckwxWklpRXcvb0JlRDhIUjV0TXUvVFdxZzMwcFpNNmVQV2xFU292S24vMDhy?=
 =?utf-8?B?eXVjT3czN2h6ZU82akpuTElvTWMxbHBEM2pkVDJOaDdLS3RQOGJZd1JrOHNK?=
 =?utf-8?B?K1hhNmk3M1d3cVNlWnVFQ2htbnN5cys5d25NNjY4aU1tUWVDemdscEp0NWNS?=
 =?utf-8?B?ODk5enJyRFRPeVcxRitLN1Z3Vy9GQTFTaHovUVZlSE51T1hNbi8zNFNZZFFV?=
 =?utf-8?B?UVRLc0FScXZ4QTRZV2tLWlVkcTJMczNLOTdETjlHOGNKM25mWDFzczk3TXFO?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa61d6-f00a-48af-1aad-08ddf4342ca1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:45:08.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RZzi0Cd6PoUO9xsUs/hJTsvRhCJ8zvT8Q6/6HswtfsfgyYikV6kHBOQC/sdIoynd2BcQG0NewBzoS8cFyRQab9b1D2BcJ1AC+wjcCGvmWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7629
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Sep 2025 08:45:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20051



On 9/11/25 18:20, Jan Kiszka wrote:
> On 04.09.25 11:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> We use in most case the file helper as:
>>   - QEMU arm/arm64/riscv64 do not support secure mmc storage
>>   - QEMU amd64 needs writable efivars which are only available in
>>     cip-core if secure boot is enabled
> 
> Nope, we already have it when switching to SWUpdate images. Should we
> switch to EFI unconditionally? May also simplify the start-qemu.sh script.
 From our feature set i would say so.

Quirin
> 
>>   - efivar wre not tested on the targets bbb, hihope, iwg20m
> 
> were
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/machine/bbb.conf          | 1 +
>>   conf/machine/hihope-rzg2m.conf | 2 ++
>>   conf/machine/iwg20m.conf       | 2 ++
>>   conf/machine/qemu-amd64.conf   | 3 +++
>>   conf/machine/qemu-arm.conf     | 2 ++
>>   conf/machine/qemu-arm64.conf   | 2 ++
>>   conf/machine/qemu-riscv64.conf | 2 ++
>>   conf/machine/x86-uefi.conf     | 2 ++
>>   8 files changed, 16 insertions(+)
>>
>> diff --git a/conf/machine/bbb.conf b/conf/machine/bbb.conf
>> index 8c42ec0..f9ef832 100644
>> --- a/conf/machine/bbb.conf
>> +++ b/conf/machine/bbb.conf
>> @@ -20,3 +20,4 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/cip_bbb_de
>>   WDOG_TIMEOUT = "0"
>>   
>>   PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-bbb"
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
>> index 0b3acf4..447745a 100644
>> --- a/conf/machine/hihope-rzg2m.conf
>> +++ b/conf/machine/hihope-rzg2m.conf
>> @@ -20,3 +20,5 @@ IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
>>   
>>   WIRELESS_FIRMWARE_PACKAGE = "firmware-ti-connectivity"
>>   INSTALL_WIRELESS_TOOLS ?= "1"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
>> index f5d5dda..401ca57 100644
>> --- a/conf/machine/iwg20m.conf
>> +++ b/conf/machine/iwg20m.conf
>> @@ -20,3 +20,5 @@ KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/renesas_sh
>>   DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
>>   KERNEL_IMAGE="zImage"
>>   IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
>> index d786646..643996c 100644
>> --- a/conf/machine/qemu-amd64.conf
>> +++ b/conf/machine/qemu-amd64.conf
>> @@ -11,3 +11,6 @@ DISTRO_ARCH = "amd64"
>>   IMAGE_FSTYPES ?= "ext4"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> +PREFERRED_PROVIDER_factory-reset-helper:secureboot = "factory-reset-helper-efi"
>> diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
>> index d2dd81f..29adaa5 100644
>> --- a/conf/machine/qemu-arm.conf
>> +++ b/conf/machine/qemu-arm.conf
>> @@ -17,3 +17,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm/qemu_arm_
>>   WDOG_TIMEOUT = "0"
>>   
>>   PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
>> index a2c5e53..cdb94d5 100644
>> --- a/conf/machine/qemu-arm64.conf
>> +++ b/conf/machine/qemu-arm64.conf
>> @@ -16,3 +16,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/cip_mer
>>   WDOG_TIMEOUT = "0"
>>   
>>   PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-arm64"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
>> index 36d6d94..25b19b0 100644
>> --- a/conf/machine/qemu-riscv64.conf
>> +++ b/conf/machine/qemu-riscv64.conf
>> @@ -20,3 +20,5 @@ KERNEL_DEFCONFIG ?= "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/riscv/cip_mer
>>   WDOG_TIMEOUT = "0"
>>   
>>   PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-qemu-riscv64"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-file"
>> diff --git a/conf/machine/x86-uefi.conf b/conf/machine/x86-uefi.conf
>> index 33f82b1..28ef245 100644
>> --- a/conf/machine/x86-uefi.conf
>> +++ b/conf/machine/x86-uefi.conf
>> @@ -13,3 +13,5 @@ WKS_FILE ?= "x86_64-generic.wks"
>>   IMAGER_INSTALL:wic += "${GRUB_BOOTLOADER_INSTALL}"
>>   USE_CIP_KERNEL_CONFIG = "1"
>>   KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/cip_merged_defconfig"
>> +
>> +PREFERRED_PROVIDER_factory-reset-helper = "factory-reset-helper-efi"
> 
> Jan
> 


