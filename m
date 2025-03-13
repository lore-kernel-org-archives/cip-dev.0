Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE5C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 13:08:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.44])
 by mx.groups.io with SMTP id smtpd.web10.14167.1741871312589102099
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 06:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ybRw8EBT;
 spf=pass (domain: siemens.com, ip: 52.101.65.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orn8czBiRCHCyTBx1miexGl1LWQpDCD0nUUnZkWpM1miNS2FQKpkyyYhXkCQGclFpk+YrVvHKNNlSyCH1MV2I7wHE1+LeOt0xBk++t57SA4ou2hzVBluXmJqsQaPoaCXR++JgcRwC38THdKa52uRuiYL/FsUcHUp8XofshARv4UWaXB1hW/eO611fMEOK91f0GsNSMlun1R2XVlTVk+R4+tlOUAFS7b3sDncOGC75HoOiglZ/7rVqdHhqpAOQdscEWdGYFBOTDy2rR1GcpC8jgiF1Jwaq+d3Gt8SncXsaxCNRJacJXuNdyvhNFZ9v1v9X3c8s9ttxJ3uRiQnZDpeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dVzcvDKmdZ0fvLDKIXWOh39wTSRQHOb3J8s4X+qrDQ=;
 b=LLcnRNRjH9tA090fP14vyXjWe2LtYgKbYwVDpY0UO4NyVwSKG13nOIm4G0n9VClDnYOLHbwy6mqGVN1d6TlrEWYxp8LlzA9cqrBpdOGGLP/DbBhHRy8NJIFAaw5ekcGB+WTr35bxRrpE9k5AAFIJYEBBFyhS1DsYO56JPJbQ1cHMoverYIMZI2B5JmmaGxZm5jRDTWE49KSmtEjNfyQkPagSlel1+8cmROri2QMoCxEo6rFFslDEs1PaZcTKGL36UmZQx59YXIOCiINTRJluaGbl9cl2HZKC96RraJQfq2yC584Xbo20IgMsxCVoFjJCJ9cNZdimu0lr8NaB6XpErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dVzcvDKmdZ0fvLDKIXWOh39wTSRQHOb3J8s4X+qrDQ=;
 b=ybRw8EBT7RheOCDpkUXjYilFjA6lfo/zGkrnYH8RXWptvTi9TfETX6ygyvSYDOAuNWJ7UVjHv8VAkwpvxkbPDqdOdmF8A4nXcA5PMoQvP3Lg7BDJlZMW/eT6hztsFCRu1cpOyak83DfeZ1gmLHo4mTt8gK1ogzLppp+vmyzUHADKi3f7GqFu9qnIQbJmgvhu97jqFLdFdLZ+z4ZyvHTcSbU4H/sYMsLr27a0ytJ3UZH0v+1VOuxIiKH2LdtIGskO7LdJH/1fOEzXgAJLDt3pohUHOwP06pXjcrhXYB/pIQtkynX6GOefO6qja67Fgxz1yaKT4JeiE1BtG43JUyP1lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 13:08:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 13:08:29 +0000
Message-ID: <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
Date: Thu, 13 Mar 2025 14:08:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Mailing list inventing addresses for people
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0450.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5401:EE_
X-MS-Office365-Filtering-Correlation-Id: 22658cf6-9421-449b-e899-08dd623025eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V0RtMVYwUEhJMUtRUDQwdEF4QitudThCODFhTGRLOWNHSVRpYWdFbUNHeFdr?=
 =?utf-8?B?bzdSMFJjRXdKUGRTUWpxWDN4dWhvQms4RGJBZS9pcmNiUnNOYXpWNkdLcVRV?=
 =?utf-8?B?eWVqczZiZ3dmTnEzNEdDM0ViOHVFSFJUYmt1ZU1VQVJ6SXFIdG5vZ2ErNWJp?=
 =?utf-8?B?WFZPOUxpNzdaQk9LR2laVUxMWXBuMDAyWTRZZk8vcDhkZHpHaDZPRTBiRFdG?=
 =?utf-8?B?aUozOUhTU21EM1NlV3dCaGtLOU9XeFBXMldaRFZ6VkpQdjJhbkMxMzNLK3ll?=
 =?utf-8?B?RDZ4aWxFUEVSdTNxM0h6UlNYZkNvc29aYmRZaUgzak5vN0R4OHhmcE9EMXRR?=
 =?utf-8?B?aUdRaGNKaGNpSkJKVG92bVlYM0ppOVNUQVVlaVJzMzlLdWQ2L0dmTHFTL2lG?=
 =?utf-8?B?R05scXN0QWZ1UmV1SlpPOEwwZGFKS1NKZitqOGN4K1lOMmtLRlBsODVHZFpT?=
 =?utf-8?B?QmpUZFc4NlRQVzVKREV5blY3WEZGbFRxelZqbjduR0c2QVV5VXZmYi9XZlN3?=
 =?utf-8?B?SXdHNmlGYXN2R3Z3cWFWSVlyYmVSRFZOUTltdTBhL3VVd1h2TmlibHlKMUdD?=
 =?utf-8?B?UmVpZlQ1Q0tvOGI3L0kyVnJaN0Qxdk1TS2M3bm0za1kycjNGVjVITURpRkx6?=
 =?utf-8?B?YUZmN0hiOU1OMDJYM29PUTNqWFZCZmhRdkY2ajZRY3N1ZmU5elR5U1lVUFhl?=
 =?utf-8?B?Smc4SDlIanpodlVrQmVibkJHUTRieXhFNk9FVmFydThoUXVPeXFSVUhUamFn?=
 =?utf-8?B?cC9ya3JSVlE5TnlPdS8wRlFwa2RZdkNuY0FRTjBFd29VRTRIMncxWTI2UWV2?=
 =?utf-8?B?RVY4OS94ZGFDMWNVb3M1cFBMcXFob1VWdldwNE5hc3dqT1p6R0czTWxBcUxo?=
 =?utf-8?B?VW5oL0Fkbll4TjVJZis2cGV6N0N6di9pa0Q2M0hnUGc0UVN3MGJIWUgxTCtV?=
 =?utf-8?B?aUk3WW91QTlCakVSajVDamFKZFJPQmF6SW1OeWtZV2tVL00zS2hZVytUazMw?=
 =?utf-8?B?bjlEODZyS0ZjWllrU2ZzcG56NEpiTCs5NTEvTGUzRWhkSUtWcTlzMlVDajRG?=
 =?utf-8?B?ekZMUnpzaUJvUGxpVXBtenR3Z204YklFYlhsTjNmV2tMc0pyaTZLODJDOTZj?=
 =?utf-8?B?TmhFUEhsR1B5VW4rbGNBNFhub0owaDUxamtrYlRLWm85M1lUMmZDS3pobkJI?=
 =?utf-8?B?dkNxaUhYa01tVHphQjI4NVRvRHJaemllS084VEtUKy9RSEIwZzZCaFlKdmE1?=
 =?utf-8?B?SXZyc3MvaEMrYzRXSWJCbDBIYWdlNlVCa0pTaUlRcU1LMnk4UW5lcGx5TU56?=
 =?utf-8?B?S296djhVTW1LNCtwb3hlZFhuSGJGZHdCUHRwNkk0L25FUWdkbXJtSjVsa0pN?=
 =?utf-8?B?UGJDQjhXMFF4K1ZqZmU3czlxLzMrbkVFMlVOUDhZZ25Xd3ZQUExKVUg4d21G?=
 =?utf-8?B?N3FrN2tVcVVybk1uYXc4U21MZ1NLRWFORENFbG11V3lqdVY2TmxSYngvZXVq?=
 =?utf-8?B?RnF4OXV5VitIcTRXRE5nQWVqWXJHdkNWQTF4ZHpBUXgwVFFtQVE1TEYvSVM5?=
 =?utf-8?B?Tno5dkMvL1lnOEJCR0Y2ajd4SVUxY29ONmc2NDh1NFMzcUlIekFRNUMxZ0RJ?=
 =?utf-8?B?T2YxT2pFa0N4N0o2cUR0Mmp2NVFuYlJMdmVFcjJqVG40bFhIa0h6YTNocEQ0?=
 =?utf-8?B?QktVYUVrOUgyb3BOUGVSWDdCVXlXUU9iY2M0Tjd6YVJ5L2FkTlVzekFMb0d1?=
 =?utf-8?B?WllxRU9zQUNLN0ordnVYNkVHcGVFZHZPOENDa1FQTGwxRUFXeHFqRzdlY1pN?=
 =?utf-8?B?a2N1ekdTU3NEdTNVaVQxUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDdLcmFoekRqS241Sk1WeXQreFhxckJQTTUxN2VpRHNPNmRqeERRY0RFcDFY?=
 =?utf-8?B?NU9oTXlVcTU2c0hWdUZ0KzZEbnJidkdzL0kwSEdoS0F0SjVoYUxwL3h4UFZO?=
 =?utf-8?B?a3p5SHlIejRBMnNjOW9JZysxR2pVeGgra0gwdVRRR01IMlBmdkVFR3E2enV1?=
 =?utf-8?B?R3NRVGtzam1pQWxvc1E4OE5raldqVU9JMFJCZVF6UFk3T0R2Z2l3TTV5bEZI?=
 =?utf-8?B?Y3hVb3pvbWVrb01hcUFvYmh4UjhXOGcrdytWTVZkZnMyQkpEaEhRZzBlLzJr?=
 =?utf-8?B?SnMwMVdRZmZCRm02VGliNjhXNTR0d1YzYjF6dDduWGM1cm5Ta2p5eHBiYkc0?=
 =?utf-8?B?eFdBc2p5REpKZHZKRXR3bUROendkY1g0T3dYNlB1SGcxdXNUdzdaNGJRdyto?=
 =?utf-8?B?Z3poVmxWTGdrM3did1hiRzAvM25GZ3FPMTFGbzhWY1pzOXlNUkpDclZ5bmgw?=
 =?utf-8?B?SDlkdUErVE5JS21qZXZOL0tzaFZkVllNeE5WQ3dHQmlKMWlhc29Cem1GVmht?=
 =?utf-8?B?MHYrRXZUeW5id0NzOXFmNXBSak82cWk4L2Y2R01NY0dObU0wcnlsZ3VZOVkr?=
 =?utf-8?B?N2Y3cGw2V3RBa05tY04vTGxBZ1V3a2o2RTUydlpadjl6NmZRNGJaQ2ZqcXph?=
 =?utf-8?B?d2lIOHlkTUpCdmkzcGxTU3pOanhpSkNTcCtiN2dLUlJFdDRHMzI2ampnZzhC?=
 =?utf-8?B?QmxRNnhLYXBiVGxwVlE5ZWw1eHpkQTFabUJUNkkwTlcxMm1Hdmt4Q0lpdENG?=
 =?utf-8?B?REZMMkx4REhoQ21TbVdaZmZMZ3ZYRDVjbU5hKzhybGhuTXpsYjVoR3lhenhD?=
 =?utf-8?B?V3Z0Ly9lL1BiSEVTS2VwdWZXRlgwOCtOZlpSK1F5ZERpNDZZTzlLaVNOVFZR?=
 =?utf-8?B?REQvM1NxMmNQaGlJUzV3aGRBQ3BMajhYdnRLUUdKMnJPS1V4eXFnUlMzSWZF?=
 =?utf-8?B?RGY5ZlVIcWNrZk8rM0VBSVRMZ01WbVp4V2pHUmFsZjJFcUdlMlBCdFhObjVq?=
 =?utf-8?B?S3JLRnpKUlE5M2FkQW1HS3EvZS83V2UzV0x0QkRWYnd6c2R4T1RKbTdjYlho?=
 =?utf-8?B?dWE1OG0wRlMrR2UvZmlZNDZwR0s1QnZzN1grWktIQkhrc3MvNmFwVi9lWEY0?=
 =?utf-8?B?YlY1L3dMVjJNdUR2UnMzaDZKRFhlRmhKWU4vOFo4OHUvbEFxSmFYNjI0K3F6?=
 =?utf-8?B?cnVLa0VrcVZ3Q1ZGL3RIZ01PdnJqYUpoL3BodmtNR3Y3MmpVZjhGcDhDZ3Qz?=
 =?utf-8?B?d295aVhTN2xOcEpPRDgzbTJnbzZCRjFEWlVjdE13R3Q4cTc4VVhRZnJOKy9Q?=
 =?utf-8?B?ZHRwLzRzMWt4R2w2WmozUzVaMmkrOTkrd0pOcFhyNU13UEEwN2NsTi9obmRE?=
 =?utf-8?B?NlBPVmZMU2swd1lqbkhOZDNuUHJJd29BM0VmdWxuWWNPOUk1SDZmSUhHWmp1?=
 =?utf-8?B?NHVUSWRvWnFjRWRsamNTNlpvdzE5c3lMYWwvU3craXhSVHBBY2JNTkNGbWJ4?=
 =?utf-8?B?cHJaRHArR0RtVGwrWE1NNTdVLytueG9aQTd5Z3dxQXAzZUhjNHBPWjlwQWla?=
 =?utf-8?B?N09YSHczQ3JvNnI2dyszLzdNc2ZSYnk2d1hYaXNZK0Y1bmdWWmh5Nm5xWk1q?=
 =?utf-8?B?Wlgxb1JTLzl6VWdicDlvMjBHbmNDSFF2U09rK2I0c0QvNHVndGNGOElIMUFJ?=
 =?utf-8?B?WXlFcmU5b0xOMFFPRGMzN3ZKYTlFQmxZMEN2WXFLRlg5anFYNmJ3WDJCTUFj?=
 =?utf-8?B?TE1wWGFYVmRLOUpHbndMWFFQVHBKaXNjb1hyS3BuTzRjMHNCY1J5eFFRbmM3?=
 =?utf-8?B?NXh0VENVanBvOC9TZzltYWdSMWdSSW94MWdwT2ZxaTdnY014TWhHL1EyN2Js?=
 =?utf-8?B?M1czeGt1SWR0UW03S0pWQURoYU5MNEUxTU90WnpSckFPWGc2bGIxNWlEQTJk?=
 =?utf-8?B?Q05XZ3dRdzRBTHI1VlhOMDloRzVoUDJBU0MzTlRaaTJ2cWdhbThiMW9oTkJX?=
 =?utf-8?B?RW9oSVMvMzB5eEdnYVJPYy9WVHk4bXpsSHIra1I1TmZGSUhPYVZvaytOSE5a?=
 =?utf-8?B?MzBiR0c3czRQam9PRWpJL01hbkxZYmU2TjM0VXRXSDZ4ZS9rQmRvK1hlbnpJ?=
 =?utf-8?Q?KOaIlDsDdQIDkkuqZWQ5noW6C?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22658cf6-9421-449b-e899-08dd623025eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:08:29.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufsPZJL/k42PCsdkDfWg3lGNVrx+W4egtspswmj8FEWeKkGv+Z0GIRvsc+/ErnTjJ2xU00bt+bcXAkjVi5Ez6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 13:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18196

On 13.03.25 13:34, Pavel Machek wrote:
> Hi!
> 
> Mailing list is doing something ugly with From: addresses. I'm sending
> this email from @denx.de account, but it will forge From address to be
> something else. Why is it doing that and who can fix it?
> 

Can you point out an example? This one received us as "pavel@denx.de",
see also https://lore.kernel.org/cip-dev/Z9LQ6u3m4LRFTCPM@duo.ucw.cz/raw.

Jan

> It is annoying as it will break signatures, and it makes communication
> difficult. Plus, it forged my email address and invented fake one.
> 
> Best regards,
> 								Pavel


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

