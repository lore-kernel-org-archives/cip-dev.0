Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD5EBFD37
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 10:08:38 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.269100.1776074915151511989
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Apr 2026 03:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FzTppDkn;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8oq/VfM5P5vsk/HBG2yLVvXwRZ6I5/hOoBsK42t2k1MYmu/mJEQtBap21z7yZMKPxWykhZxvJqNSjef9pgd1tI5+XiAyLxZde6yaIM2RQTBVpXJLbMiCoBFEBwaeeZSFL6tau3JdzvlH32czUX/ICDhadxbemjTthVj3TTFilRRfWebUs9pmD5LROfcDNXvo2ZM9p0lkWt1ehz8j+5mLXPpjshyrTVaR3UuHtodIJNFYrZpD+eb38CoP+1c6PGxTVetSTGKGgpnXDTgw+Xi24OtMoO5mLrApQfLqom/gSeB65xL1emXpiFY0qFD69PfPjZjZKdH1oUgzHPk2P2FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lAGVjgLQBPbu/XPkaMP6PVYTYhrSpv4Wq8piO9+tAg=;
 b=R2fUXydJzpWD5SpQMeXV1EhYkXazqa1DbZLWOP2lfDTk+8cwO9NEhlnNNQb4uxBKAz5qILjIwuatIOotMcyx8cJJDcSoYXA/oGQIozju3hTW1fGfQVD3/lYYEGfa5DptSGl5z3djY0gThogihgfYisNjETnZg3ZOl6gwjfqYFXmlKEZcl5LC4//Rz5Hk02TQ30h/Sqv94wzqRB+NnQjv2Qi53EiC3W4pKNqJ2YOzzZS+Gscjq5ZeYxpN0EJwjZJYky5l014QxUjBaZ0h5CZrQUBMfMk4AVwisKj7xmuhzy5d+rNzeEkb0VKAgtgjyizlwG1dU9OnNLE3jiFMHjpSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lAGVjgLQBPbu/XPkaMP6PVYTYhrSpv4Wq8piO9+tAg=;
 b=FzTppDknrFfshc9m4BQ6xlpDVFFZR5VFN4tLqwn2zSIS7nZKn2vLYKQQFHkRmtFCwLdb2SREieE+F5b/+uLbljCT2QDcn1gEaTJiy2+ZB2Mz3x0aLLdPdUAAEOqUSAlTqeNJbZOCbmqC3VAKLsSHRWkgse47oWXfKg/gw8or690m6WR2T7UHt6O/SzDf0utKx/nbkmuEzST/YN4/x5oCxNN0/NwmnVtqHBx7pBilFCKsgxz8gBtlBvzHoH9GZAEEqHL53fflrySQb40/vYoCbWON+RLHKcnMtGG4xibp3DA0t08PkYpB/f5PC40swoPGYfx7Faf1hqB5mr1wSQ5ziw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by MRWPR10MB9627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:9c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 10:08:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 10:08:31 +0000
Message-ID: <b5374492-fbde-4111-a8f5-6b6307bd82c2@siemens.com>
Date: Mon, 13 Apr 2026 12:08:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip131
To: Ulrich Hecht <uli@fpond.eu>, "pavel@nabladev.com" <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <459507685.15146.1775979436923@webmail.strato.de>
 <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
 <1743542625.76882.1776068229391@webmail.strato.de>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1743542625.76882.1776068229391@webmail.strato.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|MRWPR10MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: edf6a3c4-d7b9-4bdb-fd7e-08de99449d31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Qsygu3dYS/mebngesaqcJjhrbqEqDWt/mni7S08pBmmUhRWz/4otFNXvaGIEGt08Hs1tQ8Tys/nTfk+eU0Zj3KomRpNE7SwyEpfp45Ua0dRIN94nsk3J8Mc59ur/PVcuNC6XFfTSMhrNc2oRAtaD0Qy8s5suYmtVd4DTf91OKHZjoKYfeR8VWSPYV9FFVP8F1jeuDkmSRWdWsugrVcDMCcE39vyIJfKdB8gWuaaBNuf1HCxpIecrdM/rBvdXluLVdPr0grkFsF43A9xvQ2PvSgdbSIwPuFQqpiZEHCBEcZW6pRH0ae9ejVvLuEVvPSyv8AhAK+HeTJjSwN8JnwMzheK4TTMvikyn/mHA+fxXw9rPAPD8xnNvtLAItgHzJTqfh9uwEA87MDTNvGu4rxKf9CzCTTEErXRbuMntmPJeQwSYH1Rsalt4+SPzOGVUdaMTRNJxqSZli+h1EsbHjKfFq1eXYbaDeDd2+OiSQAAWACu9/N0opGKqs8Ua8KQ6rKeQojc5J4qbu/er/w1fRJplb7NmIOrIepstYSRCLFxj/W5WNVXKmuNVh+nJ8CfOvkf7FGKs3EmRIfrM6De25Jw+HXyVFMXkVOCyUSvkYZ0UCeJPwfH6c0AyJ7ZwR+/PPF+iXtoGVZXbQksIKEIT/wBe5thcahfXwBVEc0rU5PNSDUC2Bi8iWhJPVuBWJPSiW0G1fodFqYD/Y925ZgJN9EbZcFiNmw3+QuHy5uZBLJl0bjk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0V3OG9NNHNOQXBoTFhFbHpmc09sVXZKdmZPUi9IeC8vQjBuc2tBMFd0THNO?=
 =?utf-8?B?ZUZpZmxqdVh2YlBSVXpLMFd1K1lDUERCa0M5bnVDLzNiQ29uRzk0VXYxRmRT?=
 =?utf-8?B?MVE0UXlVTFRFNSsrbDYyeGZNODBPWFdWVzZnd1I1QmIrcXBXYTR4QVhnS3U1?=
 =?utf-8?B?MHMrSzJuUmc2a2NZaU5KYUlHVU1Kdjg3UDVBN0svazlCT3Nkd0hlbjZIWDhT?=
 =?utf-8?B?eVUxT1I0Wmh2WXl0UzNxNzErY2FsbFlvSlBSZ2xPckl3NGxVS3RHM245NTV2?=
 =?utf-8?B?enZGTFUrRnF5UDdIeGhGR2VFM3pzdlJkeHVVemdQcEhrVzdHT2JwMHpESzlW?=
 =?utf-8?B?bCtDZ0FwRTZxa1BOYmxyaCtBUDNzY20xQkR3eUluL2crRGt1LzhJMjUwcnp5?=
 =?utf-8?B?eDl1c2M4RjJPM3h4dkdEZzAzQTQwNG9wbi9WNXFPVGxxY2lKTTVkdkRFVXJR?=
 =?utf-8?B?NHExS0l6SWlyOExna3czWks3RFppRm1PYTJqQkszVE4vZ1JVNi9rUFZkdnR6?=
 =?utf-8?B?ck1zMTJDYkFielNjcURIWW1DUkpmMzI5UTFUdDBSam5rdktkR2xIdW1pd0JF?=
 =?utf-8?B?LzhpUGlzYlVzWElEdWlhUGxZRXZWNXVCSklJWFVVSmRzdnhKanJJZGtVWTBh?=
 =?utf-8?B?QmxZcWlCSlI0d05IbUlMdlRLRWlBeUJjQUFYSGt2YTU1MjY5dnlEU2Z1Q3ZS?=
 =?utf-8?B?MmRuZ1ZkSUFvR1BjTmFOUUJQN3dRRzR3RWtmdWlCQnlkUkc0RVE5b3htTmlx?=
 =?utf-8?B?RkljV0t1WkpGRzJWWXU4Y2ZDdk03UFk1THhqczhPc1dqZDdwbVQyQkpHQmxk?=
 =?utf-8?B?TVVwOWFVUUU5ZXd5ZXRXcElzWnhWakM3ZWtwcjZoSHowQkFxL3dGTnp4cW0z?=
 =?utf-8?B?S3hKRmFDcHJrUzQ3eWpVR0paYXB3U1BJSGtyZHFTYlcyU29sYTlFajR4cnU2?=
 =?utf-8?B?cnNJVCtaZDRGWHlqekxSNTg2b1NBeVlOUE03TlJ5SE4yR1JKdnYwWWY1ODJx?=
 =?utf-8?B?d281d2UvcW1ZeXpKZ1Zad0JBVnVHOVpjU2syRzJaRDFjdytpMk1WZHBhUlk0?=
 =?utf-8?B?SlJZU2ZqR3RKSy8xRlZOM1lNbUUwOEUzdmxxYmoxYm1qZk9QZXV4N0MyMTFa?=
 =?utf-8?B?ZGxmSk1Td0hCMnB4d2NXWk1uN3k2dXJLeEF1aG5sMmtYcHF5UmtmeXJ6SXlY?=
 =?utf-8?B?UHVZNStXdnVlU1FsbTZHNXFQMm1lTm5hakNVQ01xQk9Wb0tuelNvNm9IdkxO?=
 =?utf-8?B?QWNocUlrQTlzUk5VV0Ixa05ITHpxSFAxK1NlSTNBUDhYVGwzdDhNZnBsZzVy?=
 =?utf-8?B?OG5tbnFJWHRQNXY2L1NuWFlYTk1tSE1BeGwvRHRxV1RuUndmYXBXdTZobzRY?=
 =?utf-8?B?MHRZWnBlT08vZEQySnpLa2w3VHE5ekRWOWRnUHJWUWwwVzFjb2pEZkpESEZM?=
 =?utf-8?B?OFhyQ0xvdkwwU0pIclQvSUZIWGlEeTRuTkV1aFpkY1Rya0ZaTTNxVFRKcmIv?=
 =?utf-8?B?WjU2dnJRd2lSd3Y2WHN5dUN3UmtwZHV2aGZ6djBuVDhSUU5nc3Z2MnpNcHVJ?=
 =?utf-8?B?ckJHeVhYUWhtNExzOWVpdEFMN2hHSjQ3YmVXOFJqRkYwV0NWdlJLUGNHVlZn?=
 =?utf-8?B?R2htTklHYllJWUNPVUREcEtDUGdxNmVoeGlpL0dMWjBhU2M4OFRZSm5waXVm?=
 =?utf-8?B?cTFNL1VrOTZ1aW40LzV3ZkFuaW9YTlZPWUxNb2sxVGVvV0x4bm5aeC9wWlcy?=
 =?utf-8?B?UGhXdVFhYlIrcVRmWHlvUmZoTHZtWkdKODJHMHM0enJiVDJxcWorZ2wycTFy?=
 =?utf-8?B?aVQyUVkwdTBhcEVmMVN1bktVUisxclZ6OGhOODU1NUtmalR5ZkZmL0Y5aGFq?=
 =?utf-8?B?akU3QVMvZVpoVHhnWmtjR0p5aFBvVHVwL0RsanZha2lCVkNuREVFeHE4aHZQ?=
 =?utf-8?B?U05wUXd3SmRZRUhyR0tnbW92enp4TDVjcnd0ZUltQ3F6REI2L3RvUmNCRDN2?=
 =?utf-8?B?TEo1b2pUNnZEajhIYzFTbU5ydFJ3bUY1Qjdpc1E3T1J5SW43U0VDQzRRQ1dY?=
 =?utf-8?B?cGtjZGxOU2g0K3ZiZStwVGNYRnBmYnZoSmF4M0c3QWxJRko5QkZ3bC9KVzVK?=
 =?utf-8?B?U243aHltMWNqdEtLZWtTaDF1TG9UajBhTVBESERMRDkybm4xTnpvSkR3VlJR?=
 =?utf-8?B?VUUrSDlLL1NWRi9MWmF2Rm4vLzc1Z2lFbURtWmNNenp3MnRNZi96b2Z3aHlj?=
 =?utf-8?B?ak1KczJIYyt3SGk2d1doT2FvZnFVeTQxMFRjdzVYTUhUd09uQ3IzZDIvMm9v?=
 =?utf-8?B?a0orMDVJUzErY3JZNm9YSHVCckU5UEZVVXFRdTA4MmN0VjNiSFMwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf6a3c4-d7b9-4bdb-fd7e-08de99449d31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:08:30.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRV2U48aFboRuZjVe79ryZBHEq269N2epS9wT4sBcdTvr935nyhaRBKe1Mb2G1FgaGNLkkaEhNBnxRnkWQ2Ueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 10:08:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22679

On 13.04.26 10:17, Ulrich Hecht wrote:
> 
>> On 04/13/2026 7:36 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
>> Looks like we are phase-shifted on 4.19 between regular (-cip131) and RT
>> (-cip130-rt47) again. Was there a particular reason for timing things
>> like this?
> 
> The release dates kept slipping towards the end of the month because of large 5.10 releases. 5.10.251 was very small, however, so I used the opportunity to release cip130 early to correct for that, and now try to keep release dates in the first half of the month if possible.
> 

All fine. I was just wondering if you two synchronized upfront and
concluded to continue anyway or if a chance of aligning was missed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

