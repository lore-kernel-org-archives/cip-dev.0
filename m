Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBDCE7A9C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:34:48 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14295.1763112886915994379
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:34:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tjdAmUmQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPLFERzdBgRByyDsr+4lY81iFVu2QyPBZaodKnlwOtL/SkNnLL7gxMFFnPEdwQNSAqn5hQQmZC4jQ/M2Cff5XIbNXfkmzXdyeyxuz/a4MoQUM1J1IEYlmY/hchfwUnwVEW3W36RHy9UHvCS/VFnayQEgEvSbphkLI2ltgntyjrZGcNK7r6Zy6poOVKgetfK9Zj+H1Iko5UqzuS/cg1zvmh6Vn9a8z2xDAywslz0Gg2lH4HCTi7CKaCaNc4PNDby+x0JWnp9rNo8LPsb0YFlEYf6rq+8lrvnjC7BMRBCOS5oI7HuBaeYBsZ/ZTUmgmgEL/AwK5OO6G3xoZ3IlwV1MJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ9FN8f7zo1xO+32iWP/36UQU/IyxbvSUbzVx9o3L2o=;
 b=AsukGLUoFoJsbBpAyacaZKJ5FbWPMBG4AAjEBEyfWGGQ6kXCfe7JzihQU1mAMu2T4KR0GEiGKzZl/3X+zts8HqDCn5c3EPyBcS7wTLSp0MtSl9dTUyduo0LxJIk2auM4Y4M7+GtkvtVgZFFKYPbGaj8ObfBrjSaSFBpC8ZSIlrwhz6j2BBCup/fabiWTs0Bge2DIAihrYwRsblS6c9NdIQeko2TZbnKg+c1HXoBZcVc/MKX2ITRGu0oCZGoXHPZ0/QOBEGsnHo/1YRl9vV16FBbpIwNU2vkP8eUfda93Dt7pr5Mdu3L2e0vAVcRGBvU+NvdDvj2gJsktQO6WW/K8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ9FN8f7zo1xO+32iWP/36UQU/IyxbvSUbzVx9o3L2o=;
 b=tjdAmUmQ/2VNZdp+vkD7X5XjFUx5HsSMz5BaiOKW2/1DZz0TQJmk4/wn5J4zifY/MmYsZIF6plOBJBc8sJDNuntOK5iMYfKJbq5EPAM+XZqpiK2GXh+f9YWIJ7BOqBDcrLEGHMO442Qydt2dcR4+1SVWH1BDVh3dAWpdTbKrE3TrztcIhju+4A8vvtJWod0cg2GjKZTQmOwcnxhaD+UW3+WSr4jjcrFR1YO6KT/8iq5era7QVB6mSvU5LPCA79r5QxiWwLAgxosNa6zBhmUn9zdXlvm9Np1gnGOMnPtloM/9LcOximRGgbgsxkvsdQ7FjtWt0rHFA9Fzo7wNDON74A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7141.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 09:34:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:34:40 +0000
Message-ID: <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
Date: Fri, 14 Nov 2025 10:34:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Testing isar-cip-core on the iwg20d
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 432d8f94-c0f3-4bb8-e823-08de2361093e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z01lb2UyL1BIUjNGbFc3RVM5MUs1MitkZDcrMjg5N055Rm9PajFma0xzYnZK?=
 =?utf-8?B?N2FTWlZqTkNMOUpyUFJKeFpWdDN5SkpWV0ZOWkxuYUJqdnVWZ1I0RDJQU0pQ?=
 =?utf-8?B?UzRqbGFuTW9pRjBaT0x5dXVkbnhvdjg4UTZCWjlWb2c4MXUvYi9vWHF2MWlP?=
 =?utf-8?B?aUUxdjFuUG1uWEpYbVk0K1dXcm5NRCswRjMrajczbDVuWTZ6eEUzYTR2WnJs?=
 =?utf-8?B?SDc3VjJsZHNiWnFSNmNpUTNXUitQNXptTndWOWUwYlQyZFhUMjZUNnNsTlor?=
 =?utf-8?B?NkpRMjRrcUNVZ0xpSVBqd0hGTTV1ZjFNREEzTVA4RERYaWcyN1RPUkU1c3dM?=
 =?utf-8?B?Uml2NTRKK2VjdCtVeGc3SmEwdmpIMWMxbGZsemt4Vi9KalF2S0xtWGRpanVX?=
 =?utf-8?B?VXR2TWdLaTQrSlp2SFZxOC9KS1ZaN2l3QVRCV1R4QXdadGk3NlBGMnZIbk96?=
 =?utf-8?B?TTE1UUo1NHU2eHJoY0tNcFZUR0R5YXBFeTNQMVBwWVlNUzJYQVNPRnl6U2NI?=
 =?utf-8?B?U2Q4dGJTTnpQMUVaNkVWV1VCZXBENUg3L21pMzdHVUdQbDlMRk1MMUwxSlJV?=
 =?utf-8?B?d1FiekloVnF6NTZ2eGNoenRMd0M1MFdXSHRDa2VmQndHSHN3d3pkNDErbUMx?=
 =?utf-8?B?WWc5MHVRMGF3V25UcWxURnRES3g4SnJQRkVFdC94TmpXWTdURHR3TXlZeFFN?=
 =?utf-8?B?dnhreXdzaVNRQ09vT0wxTUpUZzV4OGsxbFpIUnFzMnFBREpIUDNjNkNSbFZM?=
 =?utf-8?B?a0lLbTNORVBMSHhxL2huKzNWTjZUTU80RXpCbm8yUm93NVBFTStnSmdNSy9C?=
 =?utf-8?B?eGxkZmhtdjBWR2ptNWhDN204V3R1ZHNPdTBSdVF0dGZrZVhRNU5KdU9xcVl5?=
 =?utf-8?B?QmtOUEhCS0Fqa2p2OW5KM0ZITWVrdlVrb21HWUtHWkY2QXd1enI5dFBvOWZZ?=
 =?utf-8?B?SDhBMFFlSTA5aGFPV3F6N1RKa3JGQ0tGOEdEc3RqbWRteEc1UmFZaG52OFJN?=
 =?utf-8?B?UWRpcHZzK01jbUxrcUkyeitKM0pERWswRkNuaXBpdndpbURlN2NybjlxdWVD?=
 =?utf-8?B?UFg4YmhkWlJkSHdUVU1zenVDd3BCRHhnQjF4OXVOS0F0eTBuMlh6WGNoZ1BV?=
 =?utf-8?B?YUJrUEdzNW55dTZSOGltT2JtRXJEN1pjOU84Vzh5R0pvU2RGRCtyczhHbnJs?=
 =?utf-8?B?T3ZIaXRIU2J6OVJCQTFrY3NDczRyejZnMDN0UFhSOTZablF3ZFRheDBTa0cw?=
 =?utf-8?B?b2RpRE5vVzlDbG5VMnVPZkVLUVZmRnlIeTdpMG5TU2tJVmNKNDgyWHI1dU5B?=
 =?utf-8?B?VmFEZWN6KzNYbThDbkFkaTlLTTFuMktoa2Y1Z25jdlYrMWRRcnNzdHNUeENS?=
 =?utf-8?B?TEJnZlBLVUlsMCsrei9RY0hQSEdGZFFsSkNIeSsyajh2NTJrTk82WTVLNlJl?=
 =?utf-8?B?WXl2aWpWMEFqTHR1YlVqT2RXVUYrZzNiNEl2Sk5iUkUrWEdaTFFROW5rLzhJ?=
 =?utf-8?B?STM3NUhSWjBsVUpaQTR5SmdYMTNXcFdkanppY0w5UkdNWFMzVGlPSG9aRmJz?=
 =?utf-8?B?WFNjcEIvQjBRK3JoNUE1ZUZBZitYVDlScGtKOWxqMFQ1dnpvRzJObkNOVVVn?=
 =?utf-8?B?ZlY1cFV6enJ0bnYrSEZ2MHpqZWpTSXFkcXlkK29LWHpPOHpsUzZSeG5WbExk?=
 =?utf-8?B?UnByVy9maXZMOHgwc2w4R3d6YXg2dTI1aGl3T1I2cnIxZWtPUkRqNlU5SU1I?=
 =?utf-8?B?K3RKNk5jSGhrYU5saTN6Q010RTMzMzVZRys0NzJEbisxSFBBNDM0L0Raenoy?=
 =?utf-8?B?Y0JvcE9LVkRVZHFhNHZCTDN6VTFjeFRHUy9qakRRa2F6am8wSS9Zb0ZFdlFL?=
 =?utf-8?B?TURiSFBPUnduZWgvNTVHTTJhMlFPa0dPTEk2QXlaWmFEWENpVStjVXZjOTV0?=
 =?utf-8?Q?hkdDx0tiBfN6km8jYMVEO4/pDZNdRy1l?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUFUcGRKdFg1aC9EckZ5WGZob3FMQ3dhRWcwWGJuOTBnSVAyMTdtK0NPUnJu?=
 =?utf-8?B?L0EvUVBsQW16L1A4cFZ2N2VLTEhYTGpudG5ycWV3Y25MeUdNZ2FCTUEzUFk4?=
 =?utf-8?B?dzIwZklOWjV2dGlaTndtUUZ0QWs0RUxxeGhpWHVUd1hDMjI5UlA2dysrK3Bi?=
 =?utf-8?B?ODVDRUp6MEdVUlpscTloU3RYVEhhcXNTMjF1S2hTVzNHcU5JOStOYkNGUzhO?=
 =?utf-8?B?YTVOU3J4dklpUE5ER29HZlVRbWd5S05KWUZHQkllSXBTeVdFTmdZN3pibE9n?=
 =?utf-8?B?eW9paTFHZVZXNnA5ZGI5WlhYclRpam92WFlUai9OeEI3WUh6REU5OHY1ZWpz?=
 =?utf-8?B?WmIvUVJFK2NIQ1p1ZmRmQmwzWTNQSDFDMnd2eGhCNTZ3K3Q0eVhhcmZSSVNU?=
 =?utf-8?B?TlJyU3JvZm02TktVQ2FHREhDdmp3S0JPa0tUU3pjRDZOaERGOWwxM3Y4RmRm?=
 =?utf-8?B?d0NnRndhWXQzMFJFRWhjWHZhSkpWdHRoaUxqM2RJWlFQU2VQRmV2RHJnaTlO?=
 =?utf-8?B?T09yemtQQXV6Sjc0UjlRckV5RTRPcEwwTmVJT01JbUhhTHlpQUpqVElJd2Np?=
 =?utf-8?B?MTZHZGhyN2NKbUdkQjgrQ1c5eGpwRVhRWm5LUTQ4TDYzRDhNZytOZDltc2lU?=
 =?utf-8?B?aFovc1ZpR2c5UU5weUp2U0taYW5CZUJ4dWRqM1F4eGxKNTNsOTFDV0tRdHZH?=
 =?utf-8?B?bnl2K1FFeUhsZWN6SkNkWHhSMWc3MjlPTkhvL211WDBRbHBzclovd2NsaWk2?=
 =?utf-8?B?TkRuQ3hPSGk2VzlpeHpFUVlUZWJDUUpRTmowSjljYUxic1p2Y1BYL2RvQSsy?=
 =?utf-8?B?Y0c0TVpjZ1RTRGRDWFdFYnN6eTN4TWxXeGNvMWROdGNXdm9pOXNJZGQydGFr?=
 =?utf-8?B?VWRsWUpBczUrOFBBTDYzYXlCWHE2K0pIYkpvYXl4N0hQZzBrMmdkTnUwK0tE?=
 =?utf-8?B?SEI4aVRpdUZUTE5HN3NBQXNtMFp6MEhZYVNVb3hnUnBlaGQxSVU1Y2dSbDBz?=
 =?utf-8?B?QUcwV0pUZDl0NExhUVFwZW1KUFZaQVVhdlpMeUZUS1pvWEJwck5mYS9FeGN1?=
 =?utf-8?B?SEJxeENHNEFXMEtDaWFYQkJmQjk3M0VnK0lsWU9iVHltVEdtUllYbkdwUTlT?=
 =?utf-8?B?TXZFemdMS3FYUnpZN2JianZsRTlDZ3I1Um1PcktTcUluYkVRdHVFem1wdEht?=
 =?utf-8?B?aTBzbmtBVWFMd1N1U0RMRjF3VC9PRWdlZTluYlYvbUFKd2hrNFUzR3pXWjhp?=
 =?utf-8?B?M2VlaTJUM2VCdEU3YVE4d1JZczhwK2FuT1BJcjYrNlMzejFZSGk5NEFLUEd2?=
 =?utf-8?B?bW8wRG1pc2NVQ0FkSjU3dzlVUk1jK0pYNXZnUEEzWGRXQjVqSTNJcmVHeXBD?=
 =?utf-8?B?ZW5jcVZka2xObWFYWS8xajI5T3oxbFR1YnBYaXdUN3lydXAvSW1taXBPNlZD?=
 =?utf-8?B?R2FGa1JYOGJOR25MTnV1LzVVL2RBeXRpQ2NHSS81NU9wUDZmbVYrdHhtMTV5?=
 =?utf-8?B?VWpIRHNGcm1ybWNBcmRVbm4zNzgrdWpRZitsUWtVWFgrQ3ZmRkJKNk1vVTd1?=
 =?utf-8?B?S1RPcGJ2a0hyQnQvaXI5MEFRNFBUVThvS1ZDcWp0SmpyWWVYcW9YdDcxa2pC?=
 =?utf-8?B?OW91dnk4U0hyNlBjWnhhUlJMQ2J2aFJOd25VSHBIcHhBazNPTmx3ZE03ckE0?=
 =?utf-8?B?TXhUR2ZLNHg2MEcvaG95cXJib0tDb1NTYW5OMDc3NTM1WlFJeTd1ZzNoZUhm?=
 =?utf-8?B?ZjNwOU4rWGJjV2NXRXlNWEQxWTByUGRkZFp4MUpkbWNIT3FZWGVvYm1pYlFE?=
 =?utf-8?B?N0psbHc3WXltNWRVUm1mY1NRdDNoU3d0bnFoNmVvNkFhY3BpT0FMc1RMOEpo?=
 =?utf-8?B?TnJJVk1CTmR6SDEzTWpHK3lGcTFueVFNRm8xc0pURFpnQ3FvSjBoVkRDSWJ2?=
 =?utf-8?B?cEN5S25FTTQvMnBWMjJVSnF2VC9TaDErRHBuVWtzekpCc3laazZ2NGNDbTBl?=
 =?utf-8?B?QTZIbEhWTWxBM1h1amJmT3BNUDBXM3lMU056YkFVbXBvd1lQY2lER1ZaaUdG?=
 =?utf-8?B?cGI3RkJRUCtnNzJJcVh4WDlWb3FBZ2lFZzgyU0VHVGNVYm1RRlJmNk9ZRjdt?=
 =?utf-8?B?QXgvZGQvWkhkMUJKT2V2MzRaQlNPbzRwckVYQnBWU1A3eGJ2dFN3dkNWb0FO?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432d8f94-c0f3-4bb8-e823-08de2361093e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:34:40.8502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RPkkqZATcWnH/xAiYsYbWmDRxxWMuUfWjmYo9k1YlGAGs/ulSsfDmfAiFZDWSoirbE7/0e5iDkWH9oWHq7clQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7141
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:34:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20543

On 14.11.25 10:05, Jan Kiszka wrote:
> Hi all,
> 
> as I still have the boards with me, I "quickly" wanted to renovate and
> test isar-cip-core on iwg20d. But the board I picked from the stack has
> an ancient u-boot pre-installed (2013.01.01) and has no clue about GPT
> or the right name of dtb file to load etc. etc.
> 
> Can this board only boot U-Boot from SPI? How do I refresh that safely?
> Or can I also make it load U-Boot from SD card?
> 

With some tricks, I meanwhile loaded the zimage that isar-cip-core is 
generating via the old u-boot, but that is not giving any output during 
boot:


iW-RainboW-G20M SPI_LOADER(DDR3) V0.20 2015.07.16
BSP Version     : iW-PREWZ-SC-01-REL2.0-Linux3.10.31-PATCH004
 DEVICE SST25VF016B


U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)

CPU: Renesas Electronics R8A7743 rev 3.0
CPU: Temperature 50 C
Board: RZ/G1M iW-RainboW-G20M-Q7

DRAM:  1 GiB
MMC:   sh-sdhi: 0, sh-sdhi: 1, sh_mmcif: 2
SF: Detected SST25VF016B with page size 4 KiB, total 2 MiB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial

Board Info:
        BSP Version     : iW-PREWZ-SC-01-R3.0-REL2.0-Linux3.10.31
        SOM Version     : iW-PREWZ-AP-01-R3.3

Net:   ether_avb
Hit any key to stop autoboot:  0 
iWave-G20M > pri
baudrate=115200
bootargs=console=ttySC0
bootargs_base=console=ttySC0,115200n8 ignore_loglevel vmalloc=384M
bootargs_mmc=setenv bootargs ${bootargs_base} root=/dev/mmcblk2p2 rootwait rootfstype=ext3 rw
bootcmd=run bootcmd_mmc
bootcmd_mmc=run bootargs_mmc;run fdt_check;mmc dev 2;fatload mmc 2 ${loadaddr} ${kernel};fatload mmc 2 ${fdt_addr} ${fdt_file};bootm ${loadaddr} - ${fdt_addr}
bootdelay=3
bootfile=uImage
bootm_low=0x40e00000
bootm_size=0x100000
ethact=ether_avb
ethaddr=00:01:02:03:04:05
fdt_addr=0x40f00000
fdt_check=if test ${fdtforce} = "0"; then dynamicfdt;fi;
fdt_file=r8a7743-iwg20m_q7.dtb
fdtforce=0
kernel=uImage
loadaddr=0x40007fc0
stderr=serial
stdin=serial
stdout=serial
ver=U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
vin2_camera=ov5640

Environment size: 803/8188 bytes
iWave-G20M > run bootargs_mmc;run fdt_check;mmc dev 0;fatload mmc 0 ${loadaddr} zimage;fatload mmc 0 ${fdt_addr} r8a7743-iwg20d-q7-dbcm-ca.dtb;bootz ${loadaddr} - ${fdt_addr}
mmc0 is current device
reading zimage
15151616 bytes read in 685 ms (21.1 MiB/s)
reading r8a7743-iwg20d-q7-dbcm-ca.dtb
41327 bytes read in 5 ms (7.9 MiB/s)
## Flattened Device Tree blob at 40f00000
   Booting using the fdt blob at 0x40f00000
   Loading Device Tree to 40ef2000, end 40eff16e ... OK
Unable to update property <NULL>:mac-address, err=FDT_ERR_BADPATH
Unable to update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH
Unable to update property /iwg20m_q7_common:vin2-ov5640, err=FDT_ERR_NOTFOUND

Starting kernel ...



Tried kernel 6.1-cip and 5.10-cip already. I guess I should put this 
aside...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

