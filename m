Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34756CD4851
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 09:42:47 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71916.1778578962968427041
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 May 2026 02:42:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b/sRDcxM;
 spf=pass (domain: siemens.com, ip: 52.101.70.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N86zMMHpR4X+9Q3NP+jtN07OiimI45k9A3v1JeRpOV881lnoOA+KSL7z7DcZNr7SVNv5+L3bUWtaUuBKPBby9g24gPhHotM2nPCfA1tAd5FrN9JCbRdbLoSTHChSfdb27/1HmntC7TPsETNGJm4L619Atsrghy8a1N20VkqUg3ljpxqQOxwSCUT1mIlO/9Yx4zYTjHRC6oSlRuo3nTIFLmDS8gBT3Z8Aq7MmX5rihz+tP+BGpe8PtC94YlxbMsnuiho4CeSIdxMw23SkFocwMWkw9oi3XhHjhVgRm0U+CX7jDaPJvu74ojh1bb8QkhNttOmF9zX6hE9aDyLEQOmPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3P4RDJ7QDuTjhvZsZOWIFsfu/8RIfV4RwK1GezxFgE=;
 b=ZvIuIg2XNuKSt3nhGvgE+EBHdmeBwECFzLl3Y7xp3iEAgFIZ/2yQQ+z61/Qql5gzY0SSMSRtpgX517k6m8rCB116py9pqNRn86UR0p8NI27YsXBomuEmzueFCCXHoRv4oY2N/AFmrBcKOD+2R8vrmVo5ugQelutqk40y6ZorHOuEwZNXtIVkuSHQsapYLAypuvR6J2L+3Fk1MEnRyGb2TcvAvUYcDnV3hv+k0ZJPxkFFRBhAX4f4u3lZKrmh3fiWhTyj1r5l6dKMD44CPC7drZk6aXQqkX+uiHhpa6eyUdIeQDObIjC77FZ7bExBMhfIVKtAC/nwIZdJZ3dllZ68tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3P4RDJ7QDuTjhvZsZOWIFsfu/8RIfV4RwK1GezxFgE=;
 b=b/sRDcxMmjklKgimCMHP2ZvRAJ8ZZsOkkdKy161mOrHXrNMF+zH+8gGuOq5yeFhbnvDgvcJkk0WzAB8PQlQPnvrUyu5wCTJY9JKwku8L+rsTbnQc9LU7pwe/Ms2LCUf9ObxQxSxF55CCf/IGTxGgAeoSgAadHJJx5NoLRwlZTWNiJSduSgNsmSyyQmv4p4P3YRkYnVY8YwIoW55b6xog3AYTmX0htLIjDAiN4cJkm62XWBuJTxLrxuJySeUrKranrfByHrn4L4EPskEIPhtVwoTtiFMPxXAeImX19CdSpA0Wn51IENE3S/SLN5F4M3pC8HBVSgxnkLWDKtUpJ8GUTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:42:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:42:38 +0000
Message-ID: <b5320228-57bb-4563-8cd4-9b6141716e9f@siemens.com>
Date: Tue, 12 May 2026 11:42:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM
 32-bit
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba,
 Sebastian Siewior <bigeasy@linutronix.de>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
 <agLgnPxH1GISELm_@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <agLgnPxH1GISELm_@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 308bac9d-c270-4f6a-b731-08deb00acd9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	LFJfdH5hDTVfNkJs3R5N5mrUX2C89J1NGhdDoq2xvsWXKyw5DfNCRvIN75bZ7dkx+y0XJ7Sxr/m1oMUACX/SuESQRte65jBLy2Mm9bjjd9zP6hWJqsbvN1UjJNt7C/DMqJvZNW31CKDvpfn5T4389Yglda/EOMrKP2sjJAxmPdC2iI5K9KVMFcSb46dbZztvuuWGOkabn3nIV9T4cR/MwKLK2SmTZ/AUUw/S346gXbe9kNtOjzSOatX57mo9l5xNlaNNLyBg553lAqdeqNQZaWJpubiJ/z87CsDxE8rOM5A0lzuHXZf1gy4bsMrEef3M2NAhUptnqs8aRioOQoc4kYXZ3WyRvsX0OdoU9a4+fCgaMcDX7svVmE1ztKQ9UyBTyry3i3zn9t1oWzGWItZqC4djU16yiyskNB4mOd4/HiU6bE+hUifW9aldZPw24HK8caVBNcLPuCAhfqxVY/cK+u6RSUNPc65jAYjLeWF0S9vo+0gl1OKefOAlcv8E5rvYuOwpfvJiQiGJOdW968Sj2JzPbj0V5yxMdNzUw/eLS74nFsVCk+PpLqANtDiI6iML5hQbAW36IW1bcCS/WElxhiT0KLg+FG+Z23UBoWHkBhneFdr/28HyRiN/OqyTWVc1nq0lvHlriBNmTBllzvUmtFb/GKeGjLRVKTHXHJZKUjuZzLXqVuqi3Z1rJ8e7h0Xh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGtqNWNTUXE3UmVEa1Q0K05VUkpXWHhWNTc5K2Q3ZEJMS1NmN3RGMlc0N3Bv?=
 =?utf-8?B?Nk5URDdXcjdJdWJNUS9MNWIxRjczTnB5bFBSK2pNL1N6d1JYMzZnVmRKMWVz?=
 =?utf-8?B?THBsT1E5VlBMM2dFQlZ4dlhHYVovTmNSbXU2ckVSeXgxSEx4cGE2eVliVEc0?=
 =?utf-8?B?WVlYeEZKSzhlR3c1eVRiOWl1NzYrZzYrNXlqLzZpOGhLOE1NZDZEMmNnOXlx?=
 =?utf-8?B?bE5qVWdFckphV0FVNWU3TWo5dkgzUW5FRlMyK0JZblp4S1ZFUk1ZZjB3d0NL?=
 =?utf-8?B?RjBIeWROK2RTcVZJT1R2aGxlNnpJNzdEdFNzMmVCOGpidUQvQUZVTDVoRHht?=
 =?utf-8?B?ZThjTUZDd0lYb3VnZEFWamxHL0RPRkhNREtpdGU2M1NSdkR5SlZmOFBrak9U?=
 =?utf-8?B?UE8zeDU0NEJRQUptTFIySkxHZExkQkVkZktQMXZESE41SlJ3bU5JT3BaSVN3?=
 =?utf-8?B?c2xXS3c0QUhaNTJ2VkNhcTRIejY1NGVTRHZPd3VlcEhTV3JWSUlCOWhsK3VK?=
 =?utf-8?B?V0E2WlZPQ2lLNUQ2NjB3bVJXQUNZSVFBa2FVNjdJMEVnVG1zUmk0cjRRMFAy?=
 =?utf-8?B?djNTeGJ5RHBUNk1ZWWlCM3J3NDBDWlRxQi9kTDZlYUs5ckZEaDg0WVp2SnJI?=
 =?utf-8?B?MnFNdWtXVU4wUFZnSGU2T1JBMTQ3V1VZbFJNanNTRU1vQ3dFNjcrV3VJbU52?=
 =?utf-8?B?b3ZrajRwdVJPUUpOQWdsVnAzSzRScFkxa0kyU28xQ3dQYlZvWUpsRXp2Y3lV?=
 =?utf-8?B?a21Ma0E3U2V5WUg1QU93dERpT3RJVTBFeHkvZk1IQXdBbmp2dWtIZVc2N01n?=
 =?utf-8?B?Nnl4Q21Fc05BLzhINFZ2YTVJYlN1eThPSkVpOWdZMzN3UE0xSDZrVldOSi9n?=
 =?utf-8?B?ZVNGWHNBbzB0RG53UTJ5T2Q1RzdKR0lLcE5IcWdVVVZZTGMvM1lYZFVKakZk?=
 =?utf-8?B?T0NBb2h3WmZURFNUUVA1VTlsTWw1ZmFwZVIvMDVPRncwb2N5MVNxa21mZTEr?=
 =?utf-8?B?b2tqSGNZVjZBNWJsazdIV0QwakN3RkZNdnZ6blQyUjFpb1ZQNkNkWHBOaGgr?=
 =?utf-8?B?WjY2VjdRUnFYYVNCTzJCZ1hjUkRWZG5CUjhnVXFmdWN6cHFaUCtQZnhidTNm?=
 =?utf-8?B?dVRZeHZHY1I4UXVabzBjbWd0V0pweDhkVWVpbld3Wnk4VU1qTzRkNkk1NXpt?=
 =?utf-8?B?T0ZGbVJUMTdCbWJ3SDVjNmRFdVlOcm5zZXgzeTBDa1hMbDZKdFV1Qkk4NzFS?=
 =?utf-8?B?MVNTV0hCaWExcUljYUxsR3BuS2hBaS91a0o1djFsaFdyeFBYRUpwdWN1TUpP?=
 =?utf-8?B?Q0tVWmlkSnRUQUVXK3BTcXVHMkZsZG52blY3WWhrSWJwaGYxSmNmUkJGMitp?=
 =?utf-8?B?TmxyRURjZks4UUxQTkc2NWR6cE9rTi83RzR3ZVNYZjFDZkd5Z3ltcld4U3RI?=
 =?utf-8?B?UWs2eHZlR1dySVhqRkY4RzBKdlBYVEFLRHY4RlVMR3BTSEJ5aWZXZy9WQkRl?=
 =?utf-8?B?VmtDcDJOOEl0bit0eWxVQktYbi9uN2h5aG9sWGFLZFpLb3EvNFlGVHVOeHdS?=
 =?utf-8?B?SGh6NXRMRHdMcWlQSWVTcEF4djgyV2tFS0UvTlJDRDFQelNFOUdDZEtiUVVB?=
 =?utf-8?B?bElTSmdBQzlXL1RrbWhaSndKZGY2WnI3M21qN0tPaWZOZjJpSG1aOHlmeUdJ?=
 =?utf-8?B?dnlkaGYyS3BMYWdNdGtKVWhQb0NMeFZuSU1xdDZ2aHFlSjQ2TlJDN0U4Q2dZ?=
 =?utf-8?B?YWNTVkcxaWZLTTFXMmJmQ3c2Q2xhOVlBODRPNEc5Z1FmQUpFVzZNZURtWUI1?=
 =?utf-8?B?NlhLQkI4anBPWnl1UVZ1TjRSQzhHVThoTVkxQ1ByYmR3QUVKbDYzM0xxV2Vt?=
 =?utf-8?B?TmRESGpndkFWeEkzT3BOcWtSSnBaOG9YdERwNjdZNG9GQUFWeTdzUFZuYjRp?=
 =?utf-8?B?VGUrY2xxa1EvSGRkcmpCUkJ2am5NUnVjdHNQYWRzaEgzNEhaVkdSRVVzQWFX?=
 =?utf-8?B?WE9iaUk1VTNsKyt0Qzl1eWoxNHRvUFBaUzFTZkhLRHRqbFBldzJCTzE2QVdI?=
 =?utf-8?B?UXAxclJJQk1YcGhMVk9PRVZLSENrTkpXdGhOeFlHRTBSaTh3YTEyam5EZU1h?=
 =?utf-8?B?eERham10NmE5K2NxR2NKOUcycEt1SmRmU3ZkK2cxUDV5ck82MWRuMU0yWlRk?=
 =?utf-8?B?enJQaXVVa1E2OGRPYlZveEpMOHdLZjFDQnE1OTBDeHpMSXgxbm1YRFQ1Zkpa?=
 =?utf-8?B?WnhyeSs2YUZ4dlJMREZkbUVIZXJ5TTRpRWkzL1hwWkFLYjFYVUY5cndHODV3?=
 =?utf-8?B?VkdFenVUQVBtdkpuSlZ6RVlxZGFPWHo4VmJIeHVhblpmaWs5cDNTUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308bac9d-c270-4f6a-b731-08deb00acd9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:42:38.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6poHo+fUxyVMuj/NeqjmiP0SmuiAzdF6J7FX2QMtYziE1gnrcLpRa2OC8i612uimDMyY+oKeix1/ZQzK5kHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7069
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 May 2026 09:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22929

On 12.05.26 10:11, Pavel Machek wrote:
> Hi!
> 
>> A first attempt to backport the recently merged ARM 32-bit support of
>> PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
>> all looking for feedback regarding completeness.
>>
>> This may also be valuable for 6.12-rt as this series should be able to
>> replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
>> Daniel.
> 
> Patches look okay to me.
> 
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
> 
> You may need to sign them off.

Let's wait for stable first. For the rest, I'm happy to sign off the
final series, of course.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

