Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C3D0E6DC
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 12:46:59 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16252.1764074808977832017
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Nov 2025 04:46:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WN+bgVkY;
 spf=pass (domain: siemens.com, ip: 52.101.65.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4m189iOX3nUg5OLEif+k0TIOS1+RtU1mZd4GKGByLwtIHoPM5bnjaoUc1GBwj96nR6fb9u+YoO+nKdqs+eg5MHTTPio7nqTqJ2AdJncshp6QE6WqLjjkLPqyTt03na/kzBsU0qd2qSS1u+uyOyZ5AIZii5sa1rqkoyPvjTKKVDXqIajDqIDIx7GCMiRBX6KtlD91+JvijeWrEjWNLTT7R0Ng8tZKNbTiQy7FVO98FU0RbIRu6uB87wgxno9ocKcm7YWGUjrdD9eLiZSn6ZXE6MvWtC3VfEn/wJ9pb8FKq0BTuTJCsDNFlmB12jfcjIqsRKtUwDPg4pAx56/LE05OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T+dKSyGJGUzHqw9a2Dw+MfEPMQeamuxm8j3oZg25fs=;
 b=ndZCeHYTQ4zRTaxJmFbLfJK4n+NWNJC/6Y+6KtqoXy0q2/Yut396YyCf4iSBVJgPNHuW+j3zfY8p6GU24EPLgyUoHE1IRA9WUBhz14zdSUwh/j8SQBn2HQZdEolaF2wAcBkNzzNdqNSjeJRoy63jQlpQyVVGtjxGAOYYIlGP/WkncWbOTWAF0yGySKD+uM73abRmkHhIJEZIrxTp2E301WvIzBr8kX6kRSLPYhu24PmziQuA8e5eLrNtYoraqTF6haZDiMh6AURLqwMJLUMdBAhPnUtgEoTF+859cMiphIcaz1fxQ6DsEOPqAVo74qA6rJk6DZI/QlTawGMWAlppKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T+dKSyGJGUzHqw9a2Dw+MfEPMQeamuxm8j3oZg25fs=;
 b=WN+bgVkYYAUw7tUtUhi+u7RMuITfpaNVcTTw//GiTYV8LyDh39fEE7YkFwRgu8khDWsLcsj60sUola4m7VEscbGOpPj3XcDzbBlBbN4FVhwSwkcIIk4FzNYwjo+Mgz80neh5X/MPyPXTCcCpvTffmbxUg3cVLg3lRDDHNOe+YH4o1OBdwIZTz0i0gpIn2TTrLMq/nNdWh67Tk3aUAOTd3vrqLvHJTe7yse+uUrFj38OhMxNz9sw761SPshWsX6yGkkgWCVhX0M76OakmuowSgM9NxYFSgvCFfaAfSRzU1Dybm2JX2M2v3AfGRXKrH8R8N9pre0kW5rcJYCYHe3g9Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8960.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 25 Nov
 2025 12:46:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 12:46:44 +0000
Message-ID: <79046af0-a90e-4e80-a12e-c128583fa4c0@siemens.com>
Date: Tue, 25 Nov 2025 13:46:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Drop CONFIG_OABI_COMPAT from CIP configs
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Pavel Machek <pavel@denx.de>, Ulrich Hecht <uli@fpond.eu>
References: <630d2015-a1ee-4acb-8100-b941abbd7354@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <630d2015-a1ee-4acb-8100-b941abbd7354@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:610:52::38) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 021a28d3-8ac4-4885-5002-08de2c20b057
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S2V0enRSKzFtcjFxemUrZ3NIREhWTTZrSXJiRFBRazlFQmpLNzgrbFVibU5F?=
 =?utf-8?B?aytkNmJGTlZUNmtKeHBFdXZMelZmVDJncVBIdWhiVjVFZ1BSVzFrQk9zS2pi?=
 =?utf-8?B?VDNoVldLWG5VOVQ4dWltbXlBY3V4dkc2RFJ5Z3A1cldsYXMrc2VSeGxEWjhn?=
 =?utf-8?B?RFFQRVkzVEo2Zy85Tm1BZ05SS2tlRU11VDZ6N3E5WXVxSW56Ri9XSjF2OVJm?=
 =?utf-8?B?eU9tOTNiUE1JNjdOZ3VRZWY0UllQWURWMmN2VllJY1dyeW1BOGloeWg5MUVw?=
 =?utf-8?B?R0MydEVqN09WR0FhbmJtc0FxS3ZScEt5ODZzT0hpMDJNdGMzYlltZUJoNktz?=
 =?utf-8?B?YlZQb0lhQ0ZZbzY1ZDYvTVQ4cTJ6K3BMWHpSdW5tcVBLTFkzdlVRZ1Y5TU16?=
 =?utf-8?B?R1dDM1IrSnhzaHowOS85UFNON1Q2TXl6MHJQU2xHb2NEY0F3MG1VdVJwQWVJ?=
 =?utf-8?B?VlRIVFUwdmlrOG9sY2c4MGF0UHU4RnNteGdoQUZMZVVKZDMybnZ3V1prTUta?=
 =?utf-8?B?ZzFFazlJbHRqWUNZR1I0dUh1eWRGd0U5M1hjbytMODJNYStETjBjY3NyeGw3?=
 =?utf-8?B?Zm53VG9DRTc0N0c0aHI4aWlUek5sSlA2QnI2NnQ4SXV3S3p6dzlBaEZYOE9E?=
 =?utf-8?B?eWZaenZOUWYveFhyQnpUb0ZlbWM4ckhJNFR6UlZ2R1NjeCtQV0JxNlFnMHF3?=
 =?utf-8?B?VnM2ZlQraFZRbGdONXVkbi9BZ01wN0psQndyRVZFUzBYT2VRK2lUVjJRYi80?=
 =?utf-8?B?R0JrL0gxQjUvUWZ2OHA0a3hXWURSUStLekgrRVdDZFhJR3dlWWdtRkxZdjlh?=
 =?utf-8?B?RE9TTlF2RDVUUDJTdkErOTRwMU04Wno2VVR2dGhHOEU5SUJTbnFtbkNxa3FB?=
 =?utf-8?B?djhJOWV6Q0NORWtiWmN4ZFhrWXFQbGJXNlFyVlBJZXVSQVN0NnF2MW9KUmJo?=
 =?utf-8?B?aHkwaGVRdEdYQkl4aU5YMlpxbjVDdG00REdhdnVNY2lEU21CdzNNdjQ2cVFs?=
 =?utf-8?B?WXJOT2dLSWtwTjlkR2VNbUgycTdDQkJQbHRHbnR6YzA4T2lsSE4vMkxsM08v?=
 =?utf-8?B?NlNLM1pHRnNWU25TazZhWmZyQVNJSGVPRFhzcDNjczZValVrakxEL0w0UGh2?=
 =?utf-8?B?REtwWnlDenB6dkVaZUl4VEY2ZCtsT1hvS0poSGhjdjdnWlluakljU0djYXpF?=
 =?utf-8?B?eU9nQlJhaXVxNlZoRHZVVW1EQ0hKQUNBUVEvb2dmemJ6d2RESlpTMEtJcG8y?=
 =?utf-8?B?blBNaVI1ZUN2ZVEyV0JZUERwbnFvZWIrMTVSZDhPT2JsaUU3R21qejhzRUZ1?=
 =?utf-8?B?Rk1kcGxicnpkOVBzTHZjYnRDNlJrYng0dVRVY3RmWmRmMGl5OGpaandqbzc5?=
 =?utf-8?B?WTRvNjZqbnk2VjhYcW5BdW4yTmNqNDViN1oyU1lNV0NiNHJSMlFLVVdGSFV4?=
 =?utf-8?B?bENRbGQ3bWU1M0N4bS85ck05YTNFK2FWOElQb2pNcDFESXhHa3p0MDhEenV2?=
 =?utf-8?B?Q3RyUS9VT2NhYXJONGFnM2g0T3VnM3IvTjhKS1hiRWVpbldhOE5RYm9lQStR?=
 =?utf-8?B?RlJsSUtEd1dWeVpFbUd3cjhlbE1jU2JNR1VEZlI5L2FCVlBvMzNJbzRtbkdy?=
 =?utf-8?B?Ty9tZTN5OEE0RVA4bFQvSXRvMHNJM3pYRU1XdEQ1cHZITkc5blRKZzhsbEl1?=
 =?utf-8?B?dk9xQXIwTWdXN1QxTHJUanU2V1Jock03Umdjd1UzY0g0UHhnc1pNdGlIMlc0?=
 =?utf-8?B?Wk4zU0hJcStFcGV3Wmh6aGJVM2VuSFE4VS9BMGhoSTc2UlBYZkRFalRvTUdW?=
 =?utf-8?B?MVJPbXVMNXg1Vms1K3pjR0tuT0JXSTlzSzlOQVBXQm1VbXNIOGxyWGlKZGRx?=
 =?utf-8?B?S3NmdkgwcVZ0WGtxYkVFWTBSdWFvZ3NRY3FDdWxuOGxyTHpDWk90NlBtVWpT?=
 =?utf-8?Q?v8x+behhI6O+CfkaHrEklFWbGbtkMyh/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blY0T3RuVm1XNGFvMmFITnNsOThHaE1GbmFteWxwWm1SVlFScWhYaWoyQm9L?=
 =?utf-8?B?b2IxRzhtMDhZTmZ5RS9sMHJQWlJJYjdQc1lldHBqa2NVYVdtU0M2VjRZUHpy?=
 =?utf-8?B?VkUyelNwcWhsTGFPd0tXaldkdlUzbTlqMDl1Ly9DODRweXhVcVNtUHFKK1cy?=
 =?utf-8?B?WktvWlRSYnRNVVEvUTdaQ3Q4ekdSSzV4WC9yMEFpeVZqSVFON0xRdDZnanNu?=
 =?utf-8?B?TlVkbXRCRWgxVWU0aUwvU2p6VFFuRDF4SnY3NVlPUmRkQzRHQnJNNGNWSWtW?=
 =?utf-8?B?MVNQdC80ZGdWZ0FwbGgrUlRnOVRsRWRVRTQ2OGFoT1R3blNKWURkbytCMTJO?=
 =?utf-8?B?UmR0ZG0wcDByVVp4RUdBTVcxTUJ1QlU1cStTcUFlSGNpQ21ZYUxzQVdlKytu?=
 =?utf-8?B?R1VuZ2VOczQwSURtZkVSb1JXbjZlWk44RDVEWGg3NGFWbWlwRzBFSk4zTENS?=
 =?utf-8?B?OVZ1Uk9xdjhNdGRDTjYwZ2l1TWNrRy9IbGY4blVrNWlpQ1hnOC9oWDdFVGpV?=
 =?utf-8?B?UzRmNjREVmxiQVlONXJhNVpaS1JoK1d0Nm9qTWxRYVl0Qlc5cVdKVEo2QmNt?=
 =?utf-8?B?aERkekQzRXlLS3R5a0xHd08wMStCYWdzVHZzdXpOLzk1czRRMDZBTGFjWXpa?=
 =?utf-8?B?TjdWbFpCSnFJcHJRTmFxMFV0WWhFbm5jTGZYQTd5ZlZZUVlXN0N2aXFYSTlJ?=
 =?utf-8?B?WkdGTnpWcUhZT3NFWjExWGdyOGovcmdkR1dVcllabUxmRmJUdVZ2UVpBUWlG?=
 =?utf-8?B?QnJaL0dYamRJYnJJSTB4Q29GUFJnTjVCNWhsZk9FWG5td2F6OWNjTnd1eCsv?=
 =?utf-8?B?U1VjUGRJWFlSSHkvSjVPUzZaeFRtNGU2L1RnaTVOVEJSeDRDM29TVjU1aTgx?=
 =?utf-8?B?MVRreDZoTUd4aGJob1NyZXVQRjVGVSt3TXBydjZNUTVIVDRUL1BTU0lCWWE3?=
 =?utf-8?B?Z1N1UHh3VjNGYWdWaENacGUwMUNENGlBaTFCMnpSb3hvQlFmaDdtem5lQVNE?=
 =?utf-8?B?WmVUNGFGOHVlQmtZR3ZUaWRDRjVXczRHTUcxK002eENVWWQrMnJOTzRCTFBv?=
 =?utf-8?B?VGdxOWIzNUhJM2taaXFlK0RoNENYV0tDR2Q5N2wrRm5xWmVOeDR2aVFNTkJS?=
 =?utf-8?B?NTV6UWtIejducHNCSTZwYjhuTnF3cEoyNno5Mi9rTCtSTitFYWxscXNuU0Jp?=
 =?utf-8?B?N2tPQlFQVFNuMU5senpCT0tzaTJaMWdJTjVUME9lTElQa2s2VWtocTA1TklU?=
 =?utf-8?B?K0VyQVNMVXVkWFU4a29nQkF5bTk2R2s3ck45a0ZUeEdGd1FYSEt1SndoWGlu?=
 =?utf-8?B?bzF1dk42VWtZWjZYaWZHbWFIOEl4QnU4OHNYT2xYckRUMWxtOU4yOUl0enR3?=
 =?utf-8?B?bGhWblNyMXVDVU9wN09JTEdQeHZDYmJoY09jbVhIR1cwdzlGRng4K3Z6djlr?=
 =?utf-8?B?dW1TOWNhZHBWeXA5bEVHVjBOazRGWTdFc2RiVU1tMVZTT3gwbFg1Zk5Ob3o0?=
 =?utf-8?B?VG5ocWxKeGJrZVhFM25sKzZaOUdiVGZrNkUrcVAzY1E4Ukp0bUk4eXQyVGs4?=
 =?utf-8?B?ZUNOZjJHTExWV0xlUW5zSUIxd3FpMUxIZ0VabTNxZTBwK01iTTF1UWlyU09r?=
 =?utf-8?B?UHpJZVZiYWhRUEYzRGMwS2ZDSFFobmVGTTJhMlNUSlFPOTZxdmQwaDNVRFJn?=
 =?utf-8?B?U1NSSU1rWmt6Y1ZXenRqUWxzanErMmthbnJLOE5nTWtndjNkT1RzQXkyMThH?=
 =?utf-8?B?ZThOR0gwWlFEZERsanQwdjRvVEw3akwwcCt4RlRZU2I1MzRrcDlKQzUyMEQ2?=
 =?utf-8?B?R0lhS2hzNEs3QnJwWnR5M0pHM1FRQTczQTYzU084b3N2U0FRQVA0dHIzdEI2?=
 =?utf-8?B?ZDF0Z0FOM0Z1MFJJQU44NlVObXBTditPY0pkRjUvdndyQlQ0UHRqNmJuUjFH?=
 =?utf-8?B?SkNqR1Mvblc5ejYyWTNwUDNqQzAzNU9yVFQ5UFVuMzQwbUFiMXVkNmJRYkhZ?=
 =?utf-8?B?MzRoaGRaNnVWREtoTjRTdVF1M0VCRHFzemJsTHpkYXNJMlNTNDR2K2ZkSnR5?=
 =?utf-8?B?enhJYmhqcDhKc29JS3k4TERMM2tSWkJUa0xjUEFpengvRjc0LzAwSks0ZDM2?=
 =?utf-8?B?QVJxRllRK1pBNHU0a0gwSVZaN3B6aTlOcnpJWUd2YmdwR3ZrNnBwWUZpRnhK?=
 =?utf-8?B?Wnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021a28d3-8ac4-4885-5002-08de2c20b057
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 12:46:44.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rikdp1vVzHjdvWUgSu0ZvYzQCwQrcR3G4kh489+hrCTlLp0oT8yxThnr3QCxmTIXZP6jsUTnbUoLNbbVHBp6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8960
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 12:46:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20730

On 21.11.25 09:28, Jan Kiszka wrote:
> Hi all,
> 
> while switching isar-cip-core to arm merged defconfig, we noticed that 
> CONFIG_OABI_COMPAT is currently enabled in bbb configs [1], and that 
> since [2]. This prevents CONFIG_AUDITSYSCALLS in our merged config, and 
> it is also very likely not required nor supportable (no userland for 
> it). Therefore, I just created [3] to drop this.
> 
> If you have concerns, please raise them now.
> 
> Jan
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/140
> [2] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/e28e124c4b0bdbf9d9552a3ee77ba29b4247f86f
> [3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_requests/147
> 

I haven't heard complaints so, Nobuhiro, could you have a look that the
MR, either merge it or help us understanding if we still need that feature.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

