Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B9EB4908
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:30:14 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43376.1770895808412498043
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 03:30:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xuVzplZq;
 spf=pass (domain: siemens.com, ip: 40.107.162.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERcRiIrIjckLAdczs/WRfnTw32lFekxlcWu7zVz8wDJ88UIveFMVvWnukYMoxY7Yx7Rmq4i/5WD6shZqDNgU7zw03mcjJ8GhaN4ftPJ+jOBV5McX7rxh8GI7yrr+dsOLrmkPCHz+ty4raQ7FtB4AShJT6fK/GD4+6h8RLhj76WpGjpmv/U7be4ipgtpu3/dau3FduRYh/6v4b6iZxH8xugx3Nr3W/pTyJj56nLTWg+PICY3fbUnmZFNKr7STsINypG5XQA3pytmlp3rZHZz6nHBr6adIr37p4EtuZUWQ6AaDze5qGmjIP1hsxVo0x1vHQuYvptH2RbS/OeZLuDsSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQvEFuYvOm05CV/Qp6kJ2KRKVbU5j2bUsxeVKqe41cQ=;
 b=oCkdAjNifwheN+cUDgqSighjuN6Utq84wChj+g/sBxpTIsSbN3e5WWBkTmYX/ZhcZoL6bjizPkM4BksgM+1RTEZUeI4VJzfI7qbZYI3q2AbUzxvZAoNANJ0ISrTgaywptwoS75qoKBhQ/61gyhHrWGzREy1Oj6YzCf+NcXrWm5vwIO9+0Z0GUgAntajqOoyyk+DqVO/wVZPNjYoPc2CN31+nhvfCaL8Q/rJwiD8/U9ClCG15NW/XpLz24oZRruwnaBjhZcPhWc75xICiLp9jEdiL5679xQ0ui66CLQNvuqL8OHHSbYQBt+A0mc7/GIBgVeiozClOedOPpmzsPJi0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQvEFuYvOm05CV/Qp6kJ2KRKVbU5j2bUsxeVKqe41cQ=;
 b=xuVzplZqZqxViKIj4hxjdbLp55RdCZFBdqFa3iVhwkA0FBL4gSuB6tGXXh63O3F7v29/r3vrtrnJodMjSDCryMK8CouXZddcAe9A5iO4RFKR0fvavL3uOG3dyn6xyvnpfgmJgoID3ud/MgkynPzh0AO8jolph0TT2/gU8TiNfNTe+K3ixrmXh8oOVaH+AjZDVSATo0kZGiBZsuqwFkuZFIfaduMhUf8r1a6oDOySgDShbktJZ7F7sHoKk+ogdODb9SUZkoW9ntpD3H8HKe3Xtaj+jLevVGgnmBZkCtD0sHBSZWUSv22lozwfm830axccTanytISFThaPIb0Od8mH9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:581::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 11:30:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 11:30:04 +0000
Message-ID: <80c5226d-37f7-41b5-813b-f8a18566e643@siemens.com>
Date: Thu, 12 Feb 2026 12:30:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic/ebg*sysparts.inc: increase boot
 partitions size to 128M
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260211100249.21454-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260211100249.21454-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: ab20e3cd-26cd-4b81-8edf-08de6a2a113c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K25kdkJPRGpYWWFkNG54QTEreWxKK1RES2hvbWpHYXVjaGt4a0UwT1c1Uk14?=
 =?utf-8?B?YkJERnJpOVRTZ3JRaWlOc3VtRWZKV3BlUDFQUG9XUVpacDFPeWxOajJtSmNt?=
 =?utf-8?B?YXRwV0oyRU1KTkZuQ3dTRzQxamdmaUR1b05BdmxoY0FGY3U5V1FucnJFRUNh?=
 =?utf-8?B?cmFCdWhJLytDVXRwdHMxcXJZZksyTjEzd2NsYkp0aU5HT29aZTRiTE1meUNq?=
 =?utf-8?B?TFQzZ1ZVMEltQ0JKeUJOSVRZakNMRGxWak12bW9ZdWJ3RVpSc0R2ZDFYRUs3?=
 =?utf-8?B?RlUySHhvdGcrU0tWeWNqbmo0Q0NGWEtWVHZUTzR1OTNSeEtrVUljUzMxR09m?=
 =?utf-8?B?eEVUcVpTNXJwcDNTTjJtM1BLamxPU3lZS1dHRXpyam0vUFZPdzc1RkFBVXZz?=
 =?utf-8?B?bUg2Q0I1Vm53Wlhpc0pFcVlLL0kxRVpMUjhhdVoyTVV6VEFRcGI4YktvUUxX?=
 =?utf-8?B?MWsyWnZHb3J1Nms5MEdmZG5yTnpyeUJTcVowSDRPZEJhWTN6eTUvRE5FdFdk?=
 =?utf-8?B?dnVOS2RKeTBQYVlVVVZsUnl3M3BaS2tVS3FaQ2hWNWpWMWdGWDhBVElnK0tP?=
 =?utf-8?B?U2hBVzZDdjc4M3hSQW9nTlc4RlVhcXAxcU1ZUGE1UFhnNmhHcnZxekVDSG44?=
 =?utf-8?B?NnZHQXVOYjlDYWtjcURwQ1NNallGMVFoc3Fzd3VidzFqRUNVa2h0a01COEM4?=
 =?utf-8?B?eXhsKytJRmFxTHhaRnRhNjh5c0hjQWJiRlNwZ0NKRFZYV0lRanAvcVh2U2NO?=
 =?utf-8?B?c1hkVkk1VXplQ2NzNGVtWmVjMzlzdzdKMXBzcWN2R2JHRG5xMlc1U1lSOVkw?=
 =?utf-8?B?ZlJkV3VpanJ6OVgxT2Q4SmpES1ZFTEltMTZjMzBEYUUyMDN4WmhZRS95Y0Ur?=
 =?utf-8?B?d2kyNnk1MGc5c0o4VzhWYi9pZWFzR0NraE02RFpVZ0RRUG83RlJUSkRDbnpj?=
 =?utf-8?B?UUxId2EwY3BpYUlMck1EL1NuUStRdThsY0NVV0Jya0s5bUJWS1VxbWx3UHRk?=
 =?utf-8?B?OHlqYnNVR3k4dldNa0xVMHNxRTVaSmpXOWhPTlRydXg3TTFYaUJ0dXFRMFph?=
 =?utf-8?B?OGNLUUg0cXB3QTJla2RlZjNFVm9BMURkZExyN3JsU1RiMFpCWk5pYVBYWlZU?=
 =?utf-8?B?Tk9reUwwRmR5Ni94WXBCbGhEbkcxUlJ3bkZjN091YWduaDV1dnlGUTkxZzNE?=
 =?utf-8?B?L1pyUDE5WGtLbnJZQzVJaVVDVGxtbFV4aDV5NUpaNFMzVGdPSFhpWE1KZ2tY?=
 =?utf-8?B?Rjg5L2F2NmRFemREKytSV2lxUzlVanYvVVp2SmtIU3Z0SjdNdytHZHZVQmdR?=
 =?utf-8?B?TXNoaEwzY2Z0dEdJUDRWZlR4Rm4xT1BVWW9tY1VseEt0VE5IbnJSTHdXUXl5?=
 =?utf-8?B?NGZwL2Y2M1BDajBWYllTTWdOYnRwb1hLUkJtTFlCeXpyVERzN3kzL2F6MHFs?=
 =?utf-8?B?R01OV2drL0Vlbk0xMnhaOVZLNnBTV21haXZXbUV6ZUJVYkZEdXQ1dWZDZ3A3?=
 =?utf-8?B?R1c1UU1zK2plY2xuMVUzTnZaZWwwVmJmdGJPaTVRdk1UQyt1eThIRVJ5R3Y2?=
 =?utf-8?B?MDVnU1lvNUFHUjI3Y251S0lYSkV5WGMrRkxhem9vV0tpMG5XS0VmNzhpWHo1?=
 =?utf-8?B?OHNIUmdVdTFBNHFFYnlGSlQrZ0xjcjFtdVhCYnE1TXFDVkF5eXVRbVJSWEFD?=
 =?utf-8?B?TnFoL2F1R3RRREtJNy9ld3VJNlMxT2wzN2RrRWw2OVZXb24wRjUyM2VNbzNt?=
 =?utf-8?B?TFNRRStNb1NLb0kxZWVZeHB1TVpORWZBd2lKMzY5VDdaRGhnaDNiSnRxc3Zu?=
 =?utf-8?B?SW50Qy9YajZHbGExelcyYW0zTGFtbWR6VnNlTkw0N0hBZUxnWDJWbi96RUlT?=
 =?utf-8?B?cmdweWJNMjdrMkJkWis1bXRSbkZzV2JtNWh2Q2MrbUJmbHVVbTE3eUtLdCt5?=
 =?utf-8?B?NEJMZTVYV2hJOGxXVEJjZGh5cGtyaUNJSDVacnRwMXA2M1dhcFZzR0dYVXJq?=
 =?utf-8?B?bG5vRUJ5QkdHNGZsZnl5RW10Q29xRkFGZ2xJYjZxdHNFUXYwRWhCYjhuYWVs?=
 =?utf-8?B?TnprOTFhcGdlS202R3UvUUFxZTI3NUkwZ2xKOWc0ekJzRGJOc3VhMW9KbWNH?=
 =?utf-8?Q?XxvU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dytGeXZGOENsNFFuaklpVHJ2a2t6Q1QvVERPNmg0TW52aDIzZ0lKWDVDSExl?=
 =?utf-8?B?SzBibHVadWZBRVAxd2wzSzlZaC9iWksyMksydVRKQnZmaGg2M2RScUlPTTh5?=
 =?utf-8?B?V0Ivb05PS1VsUnFxVFIyMWxZaFVXZzBmYW9ILzQ2YUJ1M1RKK2tiNHJrQ09a?=
 =?utf-8?B?Z1NVVklwMnEzbWdBdTFRdUx1NHRSd1p4OUNwTmFLRTUyaVcyUGNJdzFsSi9t?=
 =?utf-8?B?LytwVExwUU4zK1R1RmZZK0hBb0UrUzREYVV3L0tPajJrcUlIM0RtcG8ySjZM?=
 =?utf-8?B?Tkk4VWFOT3RTcjdvYklFOXh4VEt6VFh1V2pnUytiK3QrWEROaCtXS2pJSHEy?=
 =?utf-8?B?bGVVcTlpaFlqZkZPcU9mOTkzSllJVVZtNjV4UkU1a0JpUXhRa21FcXVPaUIw?=
 =?utf-8?B?NlpiQ3RRNm9rQzExRk5nK2FydXNIaEMzY01ycld2QXg0dDBzd1R2MjhJQmVT?=
 =?utf-8?B?MGREWEhrZlJEVmtZdHpqREtUMFpjMGZTZUxqTjNFN241Mms4aFpBZFo0UHdG?=
 =?utf-8?B?NVNRMEFqdE9NMVlrNHZmRmNXYy9VQldrZjRNbTYxSjRtc2s1TXF2b0NYVWJk?=
 =?utf-8?B?TzNmdjdqVlNXZnpHUFhZRkpEWktuR21ud3MvMnNaaXF5V0N6aUpTQmZ0WVpC?=
 =?utf-8?B?VkptQS8yN2FkS1FVS0xFY1lEdVowVkd0ckRsWkZpUmZKLzdyMzY0L09sbDBx?=
 =?utf-8?B?UmdjV2RRTmNvVlBuVmtRVkdKMkhrYXNzUkRmRXVVNjRTdTU5MTRWODNZNXRR?=
 =?utf-8?B?Q2M3VnpSa3dqL3p6OXlNdThCdlE5WS8yN3JubGtMSVJqaDZVS3Fjbmt2eEdK?=
 =?utf-8?B?ak5BRENsOW9mT2ppQ2Z0L0oyYnJXRitKRUlOSFA1OFppbHoyVEVnbnVJLzFY?=
 =?utf-8?B?OE56SmR4M3RIZ3Y4UEVRbHd1VmJGTzR5QmV2azJLcnY0Zmhoano4K1pPc0tJ?=
 =?utf-8?B?dUM1TlA5Q0NFdU9oOFE4L1NXSk9UN3lVcmJwbXNuTGtua2dTOTZ3YTVCZ3Av?=
 =?utf-8?B?QzBBTDhuaGVmRmlzdjYxcHA4NlNTdEt6Z3lqdW1JZ2U1TnozSmZYcFlUMklj?=
 =?utf-8?B?UXFpclFmTm9HSU1sckpJMXVLcTZRN1dSVmZoUFpXbzJnazE2eGlNckxybXVk?=
 =?utf-8?B?Y2FlQ0NXTVQwN0pDTW94WEovWmNoRG5TamFoYkJmcVpHeXhFYVFiNDY0OGxD?=
 =?utf-8?B?VjMxQkU0eURqYmwwbDZHeUMvRzkxV2ZKa29PYzZxNVM0QkkrR2JmaEpmc09s?=
 =?utf-8?B?cHdXR2dtWUpaVnU4amJHOVNuNitaMklRNVFTVVBBMmdWYkNrMjBMNHViS3Rw?=
 =?utf-8?B?MTQ4M2FVUmJtNVd4RllKc0Z2cFN2YXZNaXZuUzVXb1U0eEtnNWdNYWRuNGFO?=
 =?utf-8?B?U1I3TGl5VGRNcUI2RjloUDgxN2hyR0pIUzVKWkF1aFMvSG9Zdm5FOUFPZHpk?=
 =?utf-8?B?alhUcGR1QXRiT0lTTHZ0bHVQVGMvcEg0dFN6U3VuSm5Lb0dpODh5SGVrYlNl?=
 =?utf-8?B?aHkrdFM5Z1UzeXcxRTNxWU8wL0kwRTdSUmtzL1VvTUQ5aHN6d3Ixb2ZPS0M0?=
 =?utf-8?B?bngzQTB1VXgzR2ZKU01LSitoYm9xNEVmUEpJUEJ5bXJsY0Qra2pEYUJ0blJQ?=
 =?utf-8?B?TU9PRkhPVlBzVHNEa1d6aXZLaGNPV1hUUGJ0eEhsdUFiRUdCV1lKRSsvb2JT?=
 =?utf-8?B?K2NLZ0ZRbnV4U0cxN0RLSnhpbk9pSFUxY1UzdDdwRy9QbHZhaU1IWmJ1Nndu?=
 =?utf-8?B?dXpIVkFLa0tGcVI0akdMbTJ5VmFmbkpOcWtKU2k2VFl3dHkzbGdCQVpvbXh4?=
 =?utf-8?B?d213NFBIMm5LSWVkcmsyT1ptS1RJM1l6ZTBKWE5YUHAwM2k5OFh0MzBqQlFm?=
 =?utf-8?B?NXF6WUJ6SWorSk14KzdlaHpwTDRCQkNPU2psdlhrbkxqeG1uYndYWmlmSTIz?=
 =?utf-8?B?SlJkMExwcXhNNXFDMlR2N1VsNXprRkc5YzFpK3ZiWHliNnZ5bjVrNUxRWjg3?=
 =?utf-8?B?a3NldW1vMWFFMFo1dW84eC96K3VMUllCbE50NmlvRXpFbGdZc013L0FmaVZY?=
 =?utf-8?B?a1Ztd0xrdWx6ZGRaeFo0ZVRNLzRUSjVCeGJPOHNORjlMdUJ1c2pmdlNuZS9O?=
 =?utf-8?B?Y1VuUm9xR1VGUTlXNlljNzYvV1ZYQktzTkovSFFlL3BXME45dUNIMlA1Q3hN?=
 =?utf-8?B?Z2k5bXFFbEw3Y3pTSTBuaVpYMFZLMVZHeUlMNGpMbDA1SUZSalVNYVZuQlh3?=
 =?utf-8?B?VUdaNXJuKzdlY00vbmp2cnZKL0VLbU8yVmhYam5hdk9kaHlOZ0xLMXFublJT?=
 =?utf-8?B?YlBKV2t4dndmSS8vais0VlhRVS9naEk3NXdoQ0pEUUdsL3B3Z0RDUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab20e3cd-26cd-4b81-8edf-08de6a2a113c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 11:30:04.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3bzohgfYBjxgU+K/iQxhKB0Yrmiw1BDL/hUjHNhPCrUJPnEr1ZoggrMCjKXc5H8u22ajGbGwh1IrWjfE3BrkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 11:30:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21860

On 11.02.26 11:02, Badrikesh Prusty wrote:
> With growing kernel sizes, the fixed 64M partition becomes a limitation.
> For example, on ti-am62px-sk machine the generated linux.efi image is
> already ~58MB, leaving minimal headroom.
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  wic/ebg-signed-sysparts.inc | 4 ++--
>  wic/ebg-sysparts.inc        | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
> index b888239..c35878f 100644
> --- a/wic/ebg-signed-sysparts.inc
> +++ b/wic/ebg-signed-sysparts.inc
> @@ -4,5 +4,5 @@
>  part --source efibootguard-efi  --size 16M --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
> -part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
> +part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
> +part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
> index 7052813..0290024 100644
> --- a/wic/ebg-sysparts.inc
> +++ b/wic/ebg-sysparts.inc
> @@ -4,5 +4,5 @@
>  part --source efibootguard-efi  --fixed-size 16M --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
> -part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
> +part --source efibootguard-boot --fixed-size 128M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
> +part --source efibootguard-boot --fixed-size 128M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937

Makes sense that we have a rather conservative size by default.
Downstream projects with more focused configs can overwrite this as needed.

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

