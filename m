Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF3DD2F00B
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 12:37:29 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10087.1769517443482351386
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 04:37:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nMdn076c;
 spf=pass (domain: siemens.com, ip: 52.101.83.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHNA0vLj78lYTKSKwaB2JVDc3bSsEW2WAMUDVlTICIfSVGLKiSRG73dH67YNROhHLKtBDj/IIbBs+XWd9MgTwK+N0aXFzSNrLJR7B0MxcG22DJOwusQDOKU4WPLoyZMXq+37jGWPbKPtTOTSj7D0hyH9y8V8mxub3XQZtb2Jz08XjyPYBkJBRTarDhApub7RaOjJ85lI8E2uWF033/AJbBHqpivqntQbgZ9PCFoJ9YFSqlBmByuawQMQ67pxLCt6aKYJTJ0JuqkePKa7Gk95TmkyU5Xaz2wMDY0AEGyMRObp4C++QCBVUQUv9i3vMa2Bht73rIkQX5dYLuL8ZjrjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjGsB80kWpN8Nlnt749KdjkaWy60NkbgyEbmcg3j+ew=;
 b=fX+UYtBdpsmUFKfNyuV9xcnlJ8WxqFERJNy+b+i1xKSnEcXaeYnOv8lRQwVjn0a09+VKvVt6QunUVwxaoZK4XyyA0t/wBvGBLHSf5rIRBwPXVTB/SlqzGLCorN9OZQKhUo9gC8F8v/2wExG36eoX7iswojFGu1nhVSbRy8PKOiJLlLB17H+VCt+xxgDRrEmlFTZkoTowV3JI4HGNC2WBwDX6uCJrNzFff4OtaZLn92QSTIrT+RykLa7crhFJ+d05Ucir8cGyyatfsXzi3sScikKqi1aQcgueUjK3nfE13aHrt4JGDFeQP1+nvg8Nqw++teQbJ8QvnKew8Jn66grFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjGsB80kWpN8Nlnt749KdjkaWy60NkbgyEbmcg3j+ew=;
 b=nMdn076cLCfCS6URlAUUv7m7JOcbXLNr24kpsOFuu7ZVzRcHaJxaVJ6VGYPo1IsK2xvvpoPIqPN7uenu9YFm7VkE0Mu7w+sMtg+4M6bOVeWLeEBM4dMjaA6bY3h4CpPe3ADfDwo5CRmuGUNI46vBQm7xLgRNyK9Q+ua09KlrVW2mZo3tHiBRnZWQt/bDd4QuLyTgNJdhdYbRD5wErhf4MKR1t/mWANIyJNKlgVun22WUmZf00xkItNv4iw7FCyc6g0sxr96mwhv0PVRKGYorlNjvS2T7jD7IjLA+vmmW373EvDHy1CMfK5CokhWXlpmlbab8iub9OIYbO+O90/h+lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB8010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 12:37:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 12:37:17 +0000
Message-ID: <02052bb1-e27d-48a9-8a84-e55d653e9017@siemens.com>
Date: Tue, 27 Jan 2026 13:37:15 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.12.66-cip16
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: bb118a00-f7c2-417f-04e9-08de5da0ce38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cE9FeVFtelZ5NDc2ZmwveXBlMTlRSUM2bUZ0S3JobTl4MmdPRlpBWXVaSHpU?=
 =?utf-8?B?NThIaDlJVC9BbVBENlhDZG1Qa2x1UmVCYXgxdU9CU1VzTWx4NUtPaWxnYkI1?=
 =?utf-8?B?YUFsWUEvQkhxd21MUW41Nmk4Sk5ZRVJsVTBVTkJYYTZYTVFCdFd4MHd4U1VG?=
 =?utf-8?B?VDVPTkJuZEZhUm1kbnlvQSt4a040NXdpcGFadW9GOHppeVB3RXhNK2lzTWFZ?=
 =?utf-8?B?OWl4VXpkVmEwL05GMnhPN05tNkFrTEZ6N3hQSDJabk1MZ2ZBMkM1SWRoUUdF?=
 =?utf-8?B?U1NXQ1B1VUZBbW5vMVZTbmRPcit1S1h0S2VIM0MrSEV0SkNPOGZyanVwbWtz?=
 =?utf-8?B?b1o1eHlabXNxdEhhZU0xVUd4b3JxNXFyOVg0UU1JM1gvUTlkVVVib0Y3UTh1?=
 =?utf-8?B?dHV4T09aeXg5ZU8rZGplQzBuZmtLUng3NllTdVdvZ2UrVDRRZnN3RGFydUhn?=
 =?utf-8?B?NDZQYm5ERXc3OFR3M083Vlp1UGg5dUZxRkViSXFMZ3RlbXczMFVad3lTbmEy?=
 =?utf-8?B?cDQ3QklvdjRqT0o4T3grMEhuODVhbGJkb2s0Qnp5NnBhYUQweGcwd0VSaS84?=
 =?utf-8?B?TFozTXE4RzVFT3BkYW1oanA0aGRzSVV2enJUL3dFVzdjb0JTZThUcmJybk1E?=
 =?utf-8?B?cC85d2MvY3gzeUxUUVREU0x5OHVHcU45VVJPL09BQ1pEM0xoWDFPcG4wRHVs?=
 =?utf-8?B?WFhNZTNzMnI0Z3c3WU1LNjBxNkZQVFRibm5BUFJNbW10bk5JZEVZRDlJUDNZ?=
 =?utf-8?B?eHBYT0swdzBleWFnWWgyT09MMnFKVmdWd3dPTE1YY2N2RHJEVlJVcHo1Z2l2?=
 =?utf-8?B?aEI1MDFmNk5DMS9jNU9JRWxOdWpGdVlpcVA4bmcrbzhXK1dRQkNBamJLb3hM?=
 =?utf-8?B?SUJ4Sm9rUFZKbFlLTnBHU2VmcnFFU0R1R2dhQi9DeVJsVzcxbWcxby9OVm8x?=
 =?utf-8?B?VzQ5ZlZIT1NtNlp4TFRXYnh2UUY0SlRHN2JRbXFTOU1lRlF4L1E3SEo2Zkxs?=
 =?utf-8?B?RmJ5NkZpSC90VmNVcDByaGRMcmtjNDNBSUhuay90b0xYbG4waDF3V3pod3gz?=
 =?utf-8?B?L0NPR2t0YVorT1g2bllMam1UYVlSSERnM0Fwb0tOY0dzWHVFQTQ5TnVJbmJ0?=
 =?utf-8?B?OHJFMmtZZXhOekVzUDBBVndWY29PZE1TMFI5WkdFVS9Tc0Z6T2lwMEdaQkJW?=
 =?utf-8?B?cGhRWkRZdUZ1SUxSdjJSZ3pqYzBPc3BNTVdLbVpvWTVtSnZLYnloQWUzcnZs?=
 =?utf-8?B?TFUyZUJNU1RnZnRhbGFMeTl4NTd1T3hTUzVhaUNUSzdiZ1ZOb2lWTkNNSEQz?=
 =?utf-8?B?UDR4OXhQaUhDUmJmNWRoSnNuNTAydVpyc3M2dGNRWWhaKzh2WFB1NUcyT1R1?=
 =?utf-8?B?YUxyUVZjSHcxeFUzN0xuMXorMlBsUndDSWdick52TnZ4ejg3aTZqWTc1SFFk?=
 =?utf-8?B?ckxlTGhFQU1ZREVmTUIzOS9SZ2tlWGtMYVZoTE03YmJVa2kxS3ZlaEdkKy9u?=
 =?utf-8?B?TVp3TWFhbVFlMjhEWVlzbCsrN3VDOWYrZWRYNnhVZys4bWtHVVJnMUIzbmVp?=
 =?utf-8?B?bnUwUERqM1BDdGNVVWtoaUNXTnhES1hCUE0vZVFpV1ZTdjBIejFBOVpYcHJU?=
 =?utf-8?B?S0hxTEVqeXZXMzBaSVl4N1h2dHNjK2thVTI0c0d3L0Y3NDhWTDQwcU5vY2dW?=
 =?utf-8?B?aVF1MHdEM3ZXanhkRy9iclpDTi9pdWd5SnFJaFZGV084YnZ4eUlaOTBTaDQx?=
 =?utf-8?B?L2p4WFVZNSt2OWl1d016R2xFVWFKRTNoa2JWUEZEeXU0OStSc2ROeGZNY2Jt?=
 =?utf-8?B?SnJFYzRSeTZIZVVpM3BIbDJieUNJWDlMcHVIL0dVVkRaM3BRTTNMRW91OGY0?=
 =?utf-8?B?K0pFbk9YUzA2a0FIQ1MwL0tTeEx5R0FkRTl6bFpUMWtkaCsrTEk3UkNVc3l4?=
 =?utf-8?B?Q0R3YzFNU3VQQkxWQ3krbmZkNHBiWVhpdGZjV0IvZVdZSmlQL1M1ZUxFWjlP?=
 =?utf-8?B?bUFzM3ZYcEM5NCt4YTRHK0c3bkZVSk04UnZFVWd3MHhUVG8rVWhKdWlWcFdk?=
 =?utf-8?B?a2EvUGJLbFNtZkF2Vk83OEhnOUZPbHowUmZhbjR6MTNqOHBSdGNtZG5NM0VS?=
 =?utf-8?Q?1vNo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUR5c0kyVDNXbVVoUHNxU0w5TWlUb1dTemZBSDZVdWhPb3JieWtVUGlzdnQr?=
 =?utf-8?B?STBKdWc0ak81U2lTakllWklMRmdFTGJUcmh3RkNQK3ZOWFNxeG92UVJ5aHNY?=
 =?utf-8?B?RjIxRzdQTWdvWklMWUZGL1VEWG85V3lKMjcyZzJ0eXowc01aUGtYSk9pcDdm?=
 =?utf-8?B?blhNcGxNdWFxSEUwN000TXZML2U4RjhhS1QyQVJjSjdPWVZFWHZFMkdIakly?=
 =?utf-8?B?L05tZ2dVSUwwVG5nZEViZllESDR1eVJpclovZkx4LzMzQjUrTStmdyt4TmQx?=
 =?utf-8?B?TDk2ZndHVkR1MWFIdE5aUjJSVlpabXFkLzFaZEM1cDAzSTZsK0QvYUZkQ1ZJ?=
 =?utf-8?B?WURBc2dCYnY1K2ZNam1wY3BTT2lYV1YxaHo2bXFLUExnaEdITElkeG4vN3NZ?=
 =?utf-8?B?U0VueUMvUkppTlVESmJqdS9Jd2RySUwvSldFdm1HaC9jUVQzMTg2WlUwcjRm?=
 =?utf-8?B?YXVrRkFDVXlYVzFvR00wWWZKcnVOWkdMcm40eWtkWUVMTjVScmpFNCtLVDcv?=
 =?utf-8?B?amJiaFRCdlVGTXJmRGdQTTEzdTNnZ1Q3V1hyYUp0SlBSMGtYbGJ6cUR1R1dU?=
 =?utf-8?B?bGFhRVN4aFJKeXk5QXBORDlUU2lDdE1WdVQ4Z1NNOG94STgvZi9LZmNOanpQ?=
 =?utf-8?B?OVY1MGVKZ05Tak9RU05pZEtWZzc2SlZqK1dZd0tKRWpLTW1Vb1dibVYwVE9M?=
 =?utf-8?B?SjlpRWVtZ2xLZ2N0M1ZWOUE4VXBOeHQ0Nmc2Y0kybWN2U2lyZHJKUWQrS3hC?=
 =?utf-8?B?OGQ2YTNsNE1oTVRPY1JWcXVLQW1zc3ErQVBvUkx3dUxnSWhOQnl1UHdBeXYz?=
 =?utf-8?B?elpubzB6MU1sYmk4alRmU050a0lJaVdScHJjZVlCa2ZGdFdzSFBBV0FyUDI3?=
 =?utf-8?B?VWwzRDVDY1FmQjNVbEttMmJ0N1k0N1AxcVhReUV5TUk4dGdHNnhZOTNWQUVH?=
 =?utf-8?B?WmUwWVlKMGk4Ym5pQkxkVzdmcmdYY2J4cUJ2blB2SnlMYVRaai8xTkZZNDF4?=
 =?utf-8?B?ZnBVMWoxbHlKdW83OVR4QTVyK1NSa2k5bGVWRVcxTVI1dVZTVzdUMU9MRVIx?=
 =?utf-8?B?Z0E2R2JEWFRGcEhQVG4rbUZkem9kckV1YjJJSTVDc0FPVk1xSVUzZ0k5b0lE?=
 =?utf-8?B?Ym9pV3BRaDkvakFhWnhBK1NBcE10YXVxUFQwem1qSkxhTkFMUjhoNXFETlZx?=
 =?utf-8?B?dWlXaWxXSHBmQWQrVWNmK0RRWXg4TVhtRm9wR3ltd2syeXJTcXVPK05pcDRh?=
 =?utf-8?B?UG5PRDRiM1NLQzN0bHRUN3JLMy9qdDkyQW01cGlOTjMxdkkxNmwvWG85VVlv?=
 =?utf-8?B?SkE4MHE5eGUyNGdLaWhxNm44ZGxNTEtIOWphY1lqT3haWEdOZUNFNXNMQ3By?=
 =?utf-8?B?OU5vTlE0YitpTEpGYmlmczBjTFh2dDgxalZIWkhxNVBwOFliaG5rL2dsNS9S?=
 =?utf-8?B?bUdoZmM3WGRVMU90dXkxbWc4c1FLY3ppeXNTUFoxTWlHYkhFS01YaFRtWE81?=
 =?utf-8?B?VExENFhsUVZLYUlvNnluWmNXcEN5WXhmNlJEalRzeTBoem5JUVU4Vy9yVEtm?=
 =?utf-8?B?cmJUZ3RhVk5TQ2dhYnQxVVNCZ2djcmFXaHVXYWUxczk0RjBDQzZXTUNwOUwv?=
 =?utf-8?B?M1NyV0xxaVBxK3RPWWhWQnVmVVNGeUVYRVR0Rlp4di9STEVrTlI2dVNUY1dQ?=
 =?utf-8?B?Vm5Gay9NY0MxeTNlSXJEVGZsNm5mZWFXeXZ4cUFLdkxxdWtDbmFmenNzZHFT?=
 =?utf-8?B?TnBGN2MrTGFHeVZKelU1Q2FqaXhJczRDR0pROWJlWFFuWUR4UXZ6R3h0OFpL?=
 =?utf-8?B?R1gxWkFiTlhDV3I2T0VPeWMyRHB1V0E2Z2hzNmRCWGhyL0tsSnVTSzRJUTNM?=
 =?utf-8?B?SWpaZWQvQ2xmNnJ1Kzh2MVhqeXFJdHc0MURBQ2xJNXRjbzFEaUZoOTd1K21D?=
 =?utf-8?B?T3JhTHBQWC80QkY4dGZNaXFiS3BFZ0UrQXJnbFR4Y1JPUDZIdjRxWTladlA4?=
 =?utf-8?B?cWtWay9XeEpvd3dld3NDaXAvaXpmS0hDR0hXeXZoRXJFSkZMa3RlcWFOUEV2?=
 =?utf-8?B?TVJtcDBaeFM5T3YwdzkrTDVsLzVRYTk3bGdheGZEMENZWWxwLzZSRW92cDlB?=
 =?utf-8?B?U0RhTUdRWklCbUpMS2Z4cG9CL1dnUVk4Z0pmKzNFa2N6N1hlVFp1d1FSSlNz?=
 =?utf-8?B?M3B2QkJkdGJ4VGw5QTFHbjNDRjkwNTllQUtHdExnWEcxdmxDWmZlQ2RhRjNl?=
 =?utf-8?B?K0JqREdIZFZlTVdCd3RybUdscDhKZGMyZ3NiOXB0dUtUOGpndnV3eEJPWGZY?=
 =?utf-8?B?N3Mveml2VnRncENFOXdYb05XS2l4NmI0NHpmY3hWemVxVDI1d0JRdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb118a00-f7c2-417f-04e9-08de5da0ce38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:37:17.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p60JalIWkHzsKxikz1AI492KHRvHxOxui07dxeDLYaY1MXPAQMjtflPz8bClc7AF7dXDn0MPwKFIr1Z80YMt7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB8010
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 12:37:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21725

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb              | 1 +
 .../{linux-cip_6.12.63-cip15.bb => linux-cip_6.12.66-cip16.bb}  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
 rename recipes-kernel/linux/{linux-cip_6.12.63-cip15.bb => linux-cip_6.12.66-cip16.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb b/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
deleted file mode 120000
index bdffe30d..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.63-cip15.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.63-cip15.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb b/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
new file mode 120000
index 00000000..6e65d612
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.66-cip16.bb
@@ -0,0 +1 @@
+linux-cip_6.12.66-cip16.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.63-cip15.bb b/recipes-kernel/linux/linux-cip_6.12.66-cip16.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.63-cip15.bb
rename to recipes-kernel/linux/linux-cip_6.12.66-cip16.bb
index 2d206e8c..9db40ef6 100644
--- a/recipes-kernel/linux/linux-cip_6.12.63-cip15.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.66-cip16.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "97989d99f2baab30964df667aca6c98867be24aeaf34130508b443fe4580ebf0"
+SRC_URI[sha256sum] = "8789118bef502c6ed32cab8dcf2de605b08152569a71ebe19ba8d0d4476c5cdb"
-- 
2.51.0

