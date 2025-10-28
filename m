Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9773CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 16:05:09 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.60])
 by mx.groups.io with SMTP id smtpd.web10.15903.1761667500018142587
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 09:05:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=na4oz3RG;
 spf=pass (domain: siemens.com, ip: 52.101.66.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVtDJ+F8kX1vCaLj7/0NeAxtfwyOHteziCN7Zd2sEssy036+74jd4CYlo4wP+MPqd1Sk+X0kN9ZM466IOhr5owqgG5lop78n/0XCI0QcgiqtSFzQV1MiUGDB8tGBUS/OJ45J3giTUU/X4lQmBPIlEv6AG5HNhKGGZCx413IGot9iLh8MFfhTxQME+4Hv1mWiX7Qk7BD3CjBrzn9b1tFHnuLQ1+lFWoXQpAfdva+oxFTMELlsAYuzwv4r2yGxenY8xnI00tcjZdi6eFi0qvv64x+WYNKxQZvJx0yit8RN5APACqVr01iEd1zjoBE1yfZh3bINIJOvcQsW3f4bCJY2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNRZ4kLbK7wYx2i6gjwI0zccx7qux5nnozfeh+dSidc=;
 b=c3Q9S6LQ2aI3SxoYW9mb1hMmUU8RkNjkDPA3Do1H8BARZ2zLJm90P6apeIReRR8qrbGFwKcFH4KjrWQeFTg0rEubrtkIubSf6OHupULBl7V3lEqq+kZaKapPo1pKMWm++VxcXLWxKezSWqTzpvsyO/dDxX6xkHtL/hJZeSBVhm1RalKm3ep2XdnAV4NaDmsmyOaYl4xwF5sEQ9HLkb/NbiLytlnGLExJvCEdic1nRZqwrDVsgAxhAmdQqfW7CqG/En57j9ErtLwu/+SXeJwDQ+HHryaQfmkLRzW9N/sjXpz20wRfha9A0jvwHvbXVK6VPQpcLgDoDdCjvxCaleejCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNRZ4kLbK7wYx2i6gjwI0zccx7qux5nnozfeh+dSidc=;
 b=na4oz3RGO4zMbGJhFnQNSanpgJBulMinnSjrLutJN5ghri3Q+GJ3z9ml65gj9JZFXiKiEZfAQ6xppCDvvc9UdI0Kxsr5AgoBmzrX37O3ExznRf+JJBzF4rNVC++dXRkoZn/BbaZIVnmPpY8mugqrd37Eau4eLpwBXU2RFX6WfS+qmasetjaLvf/7/CZAJZkGFuL965pmtFbHZwj+2lBYTY41AJL5MNNwEgw7EilGCj9222aId/jK1whPhs96hCStGI1w21vRrJpPrKXEXAby/mgfD0qNX8DMdFF894MNk5CgfSgAonZ4DQTvOsCGieYKG1Bijkeer/BwDFc/+we03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3245.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:04:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:04:53 +0000
Message-ID: <87286d13-6e1e-4cbb-ab14-a8af38037b8a@siemens.com>
Date: Tue, 28 Oct 2025 17:04:49 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Subject: isar-cip-core: Shifting defaults to trixie?
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3245:EE_
X-MS-Office365-Filtering-Correlation-Id: b2908e1e-18ed-4ebb-df8c-08de163bbb52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MU1FSldUdWd0WWloZG9hVW9jVFVIRGY3cnJWK0svQlN4OU9TM0xhK1lrY3Y1?=
 =?utf-8?B?Q2ZST21aQ1pVTlUzbGcxVjB3MlFFVXFiYitQc3QwWmF3YXZRcW5nTVdNTDYv?=
 =?utf-8?B?MVhOL1NzaFRRMWNLU0xnUm9GK04zenE3aTNlZVFISEpKV28rWVVaejZSN3d2?=
 =?utf-8?B?NVZKQmt5aDBYM1JiaE1ibHhZVTRUbW9LbExYVHYrTTBSbEw3T1B2Nk52dUJj?=
 =?utf-8?B?S3hER256dXFqcWE0WTZNZnhIU2FlNy9ra2V3M2FTT3JvRExWSVJyU2FoUElT?=
 =?utf-8?B?aGdTMzFLVHhqVklqS0hpY01JM2FNWXpnTTFWTGhTbTBwMlBVSGhkWlIwMWM2?=
 =?utf-8?B?U0R6UzZ5NGZOaitsM1FSRlFxOFB6dk1hLzFiNW5uSi80RDdEa004aWVrN3M3?=
 =?utf-8?B?SXZKbFpFUkV1RjlIdXRnWk85bEt6M0thZlpHWkFBMVBpSXNqM3pleXNnQm03?=
 =?utf-8?B?bmM5L1dmYWh0MXVKcEpCR1c3NFY3ZnBEekJvOHc3dnUwMjdzcDZObVB1MkVw?=
 =?utf-8?B?eENZLzBDM284bHpmZjFuM2FGVFN1TE5PT0w5Zy9vVmFraUNkV0dZL1hkOVVq?=
 =?utf-8?B?a0FtdjRiNERBSlBTUUh0WGdsVEprUDlQa0NEYjJHZTVVbTVPSiszTUEvV1Vz?=
 =?utf-8?B?ZWlxVS92a2t2ano5Tk9xMjJQWEhUTEE1THRmV0t6dHRwdkNwc3FOWUFQNEFG?=
 =?utf-8?B?a2RxWVNaRnNzcUtyL3hLaXlnUjdiamV2WU5wZHhqVVF2eUkyUnlvb2RLWmFN?=
 =?utf-8?B?VHNEc1Zmd3lVeWFnRENvay95cWQrMTZzbUMxZTcraGxXWUZtbXdJZmhKMGhz?=
 =?utf-8?B?WUowRTcxT05ReHJIWC9BRTAyRzFhWStrUzF5ZmpoSVo4Tm5wU2l3K0xUQ3FL?=
 =?utf-8?B?M0lGNnNMRUsrOXNwQ3M2eVlPQzdDTDFubzh3NDA4R2hZcG53S01zNEtWWXAx?=
 =?utf-8?B?QTBNQ3FYdUhKdFlEd3B3REpST1ZxNS9qUGwxTmY1YndKYUpmMjJYWkpaNE5R?=
 =?utf-8?B?cWRZcHpCMEVEK1VrR2Voak1FZnFWeU44c1c1b2g0dVZ0REdZVkZiRm56S0Zu?=
 =?utf-8?B?NjZ6dUVtQUd1OGVGWThGTWlPSWg5dmVqbzdVRFp0OERIN0xWWVloWW5WdVE5?=
 =?utf-8?B?QWR2Vyt4aDUzNFVRUmtkY2ErdDYvSEF0WDZZS1pGSEtEaXNYMEkyM05kd3pi?=
 =?utf-8?B?UTMrN05xbVZXUUR2YUpzNnVCR3YrVUtzTkpNR1JUdUJsSnJNeXVtUjFoRTdO?=
 =?utf-8?B?SU9tMlhtUi8rOHVZUFVnbUFQbThzWExWREJQR0ZOdDZEejRHc2FLVzUvd2hu?=
 =?utf-8?B?SExtbStWeEppOVVQOXVpeG5UeTRRYytUYXJDY1FPRk00L2dvSmZabll4UXFW?=
 =?utf-8?B?N3lKdHF4RFMwdTlycnA0MDY0Zks1R2swSk5kWC9EUEVsN3BoN1EwUmNTRkpX?=
 =?utf-8?B?UmhNSk5jcGc1amRZTGtVYTV4M0VXOWxuQnl0clZCbDg4dm56eTZoajFSLzRj?=
 =?utf-8?B?VHdzRlBXYkF0T2FsdTF2QUNxK3M1M1pXcFgzZTFUMWh1TjdTQmQwVmoxK0RR?=
 =?utf-8?B?WTZoTTV4amM5MDNtMXMva2JadldPYzJObkk2a2U4VVI2TVAxODZNcnJaaitj?=
 =?utf-8?B?SFNaN3p1QXBGdDlzd08wQTYrMDh3cjdzNXVZSkVDNEk4aDdmZDNtZU04UTE0?=
 =?utf-8?B?RDlDZm9Mb0xWcDZwZlk5NXJSSFNxRkYwdXJtbjhRbUJzdWNMekN6YXVXMU1X?=
 =?utf-8?B?QVhiK0lxR3E1cTlrd2dHOHRsQWtjNm9SVnczQmpWa3gvZXREcVNnS1V0ckN5?=
 =?utf-8?B?OVNNcEdHMUo3NkRUNFRIazQ0ekNGdzVwSkVITGFQNmxlQlR3SUd2RWZtUE0w?=
 =?utf-8?B?MGxzTVFIcDZsbWdrU0FzRjQyckw0ZGt4M0VmZUliS2NzUDA1WlZHQ0xCblhB?=
 =?utf-8?Q?ZsoPXVDjD186Huhp2cQsNgj/QKSey1Ix?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dThnd0VuRlFjSTZjYWJoelZSbzFzVEd1UmY3bWRhSUQ2MGkvNXA0bUJZRm9L?=
 =?utf-8?B?WmpJNk95TlRHL0NiUkhyb2h5RU5QK0FOcWdSbDFRalF5eU5PcVFxWFBiQzgr?=
 =?utf-8?B?NTVjMFlURjdGcEZDL1Q4YnpweEhjN1d3UXpPQUFDWUgwUG1HV1NWL0J0SCtR?=
 =?utf-8?B?VWZWMXFCY21Db05tV0ZYSTg5dTlLM29oUlF4OXFlMzJwQmNwb21iT2VGamhD?=
 =?utf-8?B?L2pTSFcySTZ5Zm1pS200QlNnYUR6RS9XcEFqdHRKWHVXNDR5QTFKaVdFbWZ5?=
 =?utf-8?B?NWpYc2pnT2FnakxJNUxIZ2Rwa00zZWl5c2lXYU52VGlDZ2d6azd6RG1zZUdI?=
 =?utf-8?B?WnkxY3gxSkNrWlh3ZnVjYU1KQWJObW84U2tiQVpVMHBiaDh3d3Jva1RoRm9F?=
 =?utf-8?B?NnRjK24vY3JPd3F5NDU2RVNYYUFXQ1dqRTUzMTRIYmUveEtEVC9BWS9LMnJO?=
 =?utf-8?B?OHdYMGt1MkltekJuMUp4cU5nVmhtbHY4eXN2WERac1cyS2J2aFM1K213NHFV?=
 =?utf-8?B?b3NYdWw1bVNlSnJsOCtwZ3MybjhvZlluU3dhUWhUYk45akxFMy8xdkZoWTFQ?=
 =?utf-8?B?Um1UYXZjWmZHNFlRVnF2R2t0SENZU0RJdmltRmRpOGtudlc5V0lEOVdMdW5L?=
 =?utf-8?B?RUozWDNNWGVTeVBXMC9jeFlBc1RPa051cGZjT0Y2MTF4WTlYbDduUHRYYmEz?=
 =?utf-8?B?Z0d1MVhPUGJMKzREdTdqdlVieHNxOU5QS2sxNEhvWGoxU0JiUW5DQXNoK0wy?=
 =?utf-8?B?VzFOYmNkTDN2NWY0dVhTV1daeG4weS9NNEcvMko4dlIrc1JVTEFpNFBKZDVj?=
 =?utf-8?B?WVdibXJRemFLSUN6OUlVbHBCZW9BODY1eVBMekJEczd2NmdvWkMwdjZrN2Ru?=
 =?utf-8?B?QkNrVVNNYnZWODdNWjlheVFNVDZJL0tIMzlhM3BvRVI3SW42TkJXOU9walBK?=
 =?utf-8?B?dU9WS29zeXVtTHBNTW5VdlZkanVwM2oyaDFZRFJJUVUyRTN2andFbUhJbWtv?=
 =?utf-8?B?YXJXZzV3cGZtSUZhUTNnN2YwYWhvKy9jQndFNEJDc2ZBVUl6MzZvSXNWaTdH?=
 =?utf-8?B?Z1YvNnZQOXhvajlaRUV2QW10WDVEVjZPRFlmdzdEQ1BaZXJ4aWZzZjlldWdt?=
 =?utf-8?B?b2tXK093dG9EaGVpSW5FeDFiNWtzSno4NEptek01c2lQcGVacnAyQVlsdkNx?=
 =?utf-8?B?dnErcnU3NUo0dkN5UDlnRkEvaWYrRDVvTjcyNVo2WDg1bFphdWdtMnNid28z?=
 =?utf-8?B?R1phK1ZwWmYzQUIwTmRmczFhQm9jYUR3dzltQmpxVzF4anlzWUNFbnovb2Vi?=
 =?utf-8?B?T1BSWjZKMFBJMWdFcThGRGFzZEI3bW8xSXhmaXNUL3ZPTGxZdTl5Nm4reWM4?=
 =?utf-8?B?N00yM2ZmZlhSc0lQaXZDbVVlZ29sL1l1THJkQ0g0S3FyWXp1SUtsK29rNnRT?=
 =?utf-8?B?alNTT1hUUVgvTFcrVDl5RXY2WFhTbTJBLzFvQmpseEZoalppTzhseFNRcnho?=
 =?utf-8?B?WTMvUlZGUzFKeUNmUzV1alhGbjJna0ZuaGlRV003Tk5XVWdNV2UrY1VPZTYr?=
 =?utf-8?B?VHJJTktXWXU1MUI0MS9pOGRkOG0wQmxuU0FqM1d0Ukk2OFV6VENMamtyUGNY?=
 =?utf-8?B?L0EzQmxzbkc1NUtVS1F3Wnh6US9kR3dCd0ZtRitVbnIweVhnZzc4QXY1VXpw?=
 =?utf-8?B?ZkNvcXY1ZmJrTlBEM3dCNHFhellFellJOGJPQUg3RVgyOXJUKzRtZVBoSjVy?=
 =?utf-8?B?aW1KV3NuQ0dZTWdhTmlZVkZwUHovdmc1VHJIQUpjbmY4LzMzMExvQlFMSTg2?=
 =?utf-8?B?aFJtK1pBWWxIdWQ1T1pLQUlqWUQ2Smpkd283WTlBWUlVMFdyV3dPUHBjUHZM?=
 =?utf-8?B?eTR6SUovYjNsQmdIWUc3MDE2VkFmUCtCdEhvaG5xU3UxWHdhRnVUSlh6enph?=
 =?utf-8?B?NXRuY3R3cHYzdmNKUHRveVkzUmZabklDT2ozZmZzSEIzTlU2M25GTW1YSWhq?=
 =?utf-8?B?bTk4NDVQQmNGRnlJdVJaNitDemtRZS9RR1FxcjFQSGRkai8remtPTHVGaTlP?=
 =?utf-8?B?WVpMNHpMbUFSUDFBNGVKK2J0N0xLdXJwbUhMMUcyc09EZlRuU2ZvazVZb3l1?=
 =?utf-8?B?bUdIZkJvSVNOUjJrZkZ0TGFzQmJWY0pDWGZDcDkxMkV1L1pneFg2ZEEybHNT?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2908e1e-18ed-4ebb-df8c-08de163bbb52
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:04:53.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh+9xMg8ZGU/2z1CvLAFHVtKVP/OQLfiWwBoAc9hoSBB/hEaoUevzvsmXeYTsVlQWw2BEQsFQ4E1nfrA9YrPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 16:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20266

Hi all,

we are currently still preferring bookworm over trixie in a number of
places in isar-cip-core. Likely most notably is that most of our CI
build and runtime tests are bookworm based. I suspect that at least
parts of that is due to the ongoing certification work which was started
on bookworm, right?

What can we change or add to move trixie more into focus?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


