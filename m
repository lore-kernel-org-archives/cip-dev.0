Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA52C3065C
	for <webhook@archiver.kernel.org>; Tue,  2 Jul 2024 16:04:40 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.40])
 by mx.groups.io with SMTP id smtpd.web10.28272.1719936275255104059
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jul 2024 09:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EOMrFVB4;
 spf=pass (domain: siemens.com, ip: 40.107.22.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYzNgt/Dv1Cls/nKYyetGZkzme7ef41LLOGF2ai7ftLCEeq+nj+am3XJGsQGQaMmsiI+kKvDhmn/5V1Jfka/yXUSpmR79fy9J6HWq1i426257Y15p7LdA5YI7DnfBT8cYj9V5vVR4Ru4BZzBo74K2MSVNwV0bP297jcMJbqIGZuBkW37f9lNMNRFTaajhvRHMKtd66Vtqp9nzUXGBC4iLU/Neffh/jhMknaCzVBsdFO+w4nuyMq9fDbvc8d7CK+GD4w0j2VfMQGtOkR6wibacm2Rj7oN6JQ5ZeMe7EJp0LJESLrLYE9G+mnEmNvtJfHCANlrqD8HcAxTDp2PUCwK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwLRIxz1xqSel6CNrNUKvjjWAnaXg8UM6Se0ikJ9ntw=;
 b=LGL9biEG2FAQh6UM3f8zQAoONS13TFcfdbPfBVu3wdg8FEPl/pImX+dlX92OpZuvp51Gp3+vkUyiIwTL3NQfWp0XE6PqFn6Ec66Q4VtIBJdNUbfmFLD/CbjwEIqtKiG4/BOX6L5EDMRcWOMGnIUuCgW5eh5CtXVJjVemPqsBa7BabzZrtLGgARaqPvVW2VEJCrlcj1JovAh7pyOwGWiOO2IzAhJmwsfGH2ia2Qn9YB2vzi70mWVuF/5phL2OB4nF0mkG9NxDkZJMR4RH34jkvDWEzzFOcTwqpuRo+JvyM8zy8tD1/sf+gDxrFcvv8sD1tQSnCMYbndh/rAQwsOAr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwLRIxz1xqSel6CNrNUKvjjWAnaXg8UM6Se0ikJ9ntw=;
 b=EOMrFVB4aHmuUJSkD/yEtL45oA4jBRAQCp7ht/UP3oRxb+PLbJLbdpLu9umV7zNvqxbgO4eIGg18OezRdVlZPEiVfIyVj8/K4b7UKvTVdrTxXnl6lYL+1QMiaBPbhEr6HA8gHvyqbuJ6KfPqMzPFAZ+TimyshKh8nFvJ8J0723y5nPlQGxOgdF5tiN8kKh8kT0bpEgUuBTdAxmobePyXnFJx41V7TUihGffdrAfrR/9FukRYeLZtwok+1TltuM+vOWzfMHQowA4he6NRpGRLu0XYcyJsScPABb7kmmvoZh3rUvEiLB6zScJxr4JobTVTP7hmu3AZg8Z9ZzSqzZssWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 2 Jul
 2024 16:04:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 16:04:32 +0000
Message-ID: <e9bb1b92-ad36-4a12-9a40-2ab6c523ab34@siemens.com>
Date: Tue, 2 Jul 2024 18:04:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ci: Only allow IEC tests to still fail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
References: <063a4e8a-4daa-48f4-9dba-2df7961f5b95@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <063a4e8a-4daa-48f4-9dba-2df7961f5b95@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0245.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 414f9b69-b4a3-4ad5-6938-08dc9ab0a919
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnZ6QXBmYVZpL01XTGZvNDhBeGlwK1BYK24xMUlYaGRGUmJBSFJjeFJucngy?=
 =?utf-8?B?cmdGODh6WDBuZ2R3ZnNoWnlVQXdqZnU5TXZhdzVLUnJSUG5TMVN2ZnhIQjBP?=
 =?utf-8?B?a2pXUFpwaEE1T1Q2Z1h4UHZMTytYbmd3cXY1QmhLckx3N0ZkRmxxYzcxVHhB?=
 =?utf-8?B?UE9oYlRNNjRVcmZsK3NHVEl0eWpGT3FabUJMRmxGRmIvZGZUMG94bEQwYzRY?=
 =?utf-8?B?OEI5UHcvbkZiRTJ5TjVZQlMrNkZpdnMva2JJbHVwM3hkOG1FVTJGYWhiSzFL?=
 =?utf-8?B?SXc5aXZkaHJHdEZzR3F2WmxNWFNSbEhUTE1lelJZRTJlWW9CamZwdkVMbDU0?=
 =?utf-8?B?VjRnbmc3MXc1NFhyelhaNXBveHRoTTlrUzlieFdPYlA0YmJaTVNzN09YWGxj?=
 =?utf-8?B?MmNLL095YmpUWHlCUUQxMXNFUndVaStZTHRQbkVJMHNxdEZCNG03MmVaZVlM?=
 =?utf-8?B?RTZHYW9yYkFXTXJGcnE5cXloSGlXQ0s5MnJXWHVSdFNsbmF5VlhrWUU4N3h3?=
 =?utf-8?B?RDBUOVNiN1VoamVSV3puaVhTdFZhSmdmQkRPS0NjeWh1YitheklJeTMxc0g2?=
 =?utf-8?B?Mm4yOFdwRDhxOXErUTNVUTdtRzJmREZuNmc4eUkwQVJsSjFzNHV1VG1Sa0Ir?=
 =?utf-8?B?ZjVHSkpsaGlSY1BHVXMxejZXbnpJeUxqci9oTzlPQ05hWjlrdEYvV0JTTTJB?=
 =?utf-8?B?NzhubVpWNUtpdHJlWlQ5TnVZU2NJREFaaDNNZTdXcVhrZUhMdzBCMVpSNVF5?=
 =?utf-8?B?cHBGbWxoUzN1cVA1QTBzT01tSmdWTFd6R3ZOSmxiQ0VQeWxKaXhZcXpoUS9X?=
 =?utf-8?B?THpFdCtKNzNyWHkvZGROOE82YUFCTkc4MktGZnlEcmRXQjRaWFArUUhoYkp2?=
 =?utf-8?B?N080RjdqT3VvRmFlY0xyNmIzdWhSYUQ3VWpkdHhIN0RCZFFCdmpFQTlWRExz?=
 =?utf-8?B?d3lRdDhUTHYrT3JnejdBR3NaMldnL3M3UmRBSm5PUmNLbmtxZW5NUnJGcFN0?=
 =?utf-8?B?aXdlbTBTNlNONXlIeGtHdlVNTjhCVGxaVHN3Yk14aVQ2U3U1RWhkMG45L0Jh?=
 =?utf-8?B?YXNCMnBDN042dk9EeEMrWUNVOS90TzhqUDRTMjZTVFBsNlB1V2Y0QVFaeFha?=
 =?utf-8?B?eGlPMjhIcGV1OG9JRkp0dStZWFpUQTQ0azUwa0R2ZEw0TDEzVGpBM2hwVGZV?=
 =?utf-8?B?NFo0MTdkSEdHVXNJN3h1UFlrSEdvTWtqdU5La1dyVDA4K1FqZlBranV4dFNU?=
 =?utf-8?B?SmxIUzVxUlNiK3FGTHVUQTA0M2NBdUpBMG5LY3hPVWVYZzUwRzBabHh3eVcv?=
 =?utf-8?B?ZGNqWjc3R1dVWXBidVdya0orMnVQNUppdTNJaDV1UXJpdUVvTWNzZXRZLzZL?=
 =?utf-8?B?Y0cvb2hTYW45ZVJRd1JsSHFIK2ZTeHg1RGYvNDNabHFTTlFFMGZoTzVuNE02?=
 =?utf-8?B?aEJBSWNQNzNhcFY5cjk3L2tZT0E0Y2IxRXdZNTBscEdpbmw3ZmpIdU8xZTdm?=
 =?utf-8?B?ZnRibmVLREpmV2IzU3c1VG1zcmIxenFGemRtZXJTWXRNZTUvU0NBVmNOMVR1?=
 =?utf-8?B?VS95L1R0YWZnZEFnMWRpOGZOb1c4dzZiUytycHNQV0lqb2VzbHp0QjdtdEhh?=
 =?utf-8?B?bGErL0wzZU9uaFY4NVdyUGhuZ0pNMVVYK1BMZXppa0F0OXU4am1DNmlaR0tL?=
 =?utf-8?B?dGtRV2hydUVuRXk2Rm04RlRPVlJnTzBvdGVRMGZlZjByT1V4VWo4YUt4TGlm?=
 =?utf-8?Q?fynqh8NFKf2HlkIvg8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjlBdGUrVlBzT25MWE1WZlFJNU05Yjc1MjgxSXNUUWJnK3VaRExpY3pyckVp?=
 =?utf-8?B?S1MrMmFQWkpBY3JGY29iZWdldW9JYWhIM084c3ZvOFhlM1FLdUg1ODJILy9h?=
 =?utf-8?B?K2RPS0YwcHhBZzZLbkJtNW1oWGRVNGljUHZnSzF6QVZtck5rSS9zazFBbFVG?=
 =?utf-8?B?MUZRQjdpQVorQm9UQTNGYkxYL0UrcW1RZ0Q1cGZSYmJ4RDYrZnlSUE5XTk9L?=
 =?utf-8?B?LzBEdlRWS29KMzdYbEFUYlpQTTdQUUVMRkRBcE1TbmRnbG1UMm53WE9LUHJ2?=
 =?utf-8?B?b1F3NHFpQndIVFlnUktkNTBiSDNlcTlFMnJqZ1U5OXRBQTFYUW1kNGIwckNZ?=
 =?utf-8?B?NVo5ajFwQloxUEVvc01oRW9GU2xtMHFwbHlsRkNTaHZuRkk4TFNWcHVIQW1O?=
 =?utf-8?B?cytEd0hlR29hSHlBZmRBMEJaQmhmcDV4dHVkZGxldVprQVVIZWNnY25uSXhC?=
 =?utf-8?B?Q2lpdnorV1htK0sxa1RCZ29VV1c0R0hFb09oZEg5bGh0L2p5YUhHVkpkZVZk?=
 =?utf-8?B?a3pWVkovT005MFJwRXFhMUZiVnh6aWpvcHNnNFBweGoraW15WlpuTHV0Wmsv?=
 =?utf-8?B?QjRBQWdybUJqYTlESnJKcVAxRDJJUDRTcEVidVFveW9ueWgwUWVLQVJaQXM0?=
 =?utf-8?B?L2czVVRyUUlQRW9uYVZ0cEdIbTBldTJDYmhvVEJXM1JJbmQ4TGtHU0NDa0M2?=
 =?utf-8?B?NlR4QkErc3BwOC9zalNEZFl1Q0Fyd000VkVwbTA2SGd3eUFGbmc1cUhSTVVr?=
 =?utf-8?B?NHVFNThUOVNUcTJiR1Vmd3ZDMW9DUzlTeXJGSlJscm00N0Rtb05vM1pYeTla?=
 =?utf-8?B?VXBCOGNONGF4Vnc4aWVIY1o5eGtLTldxbmJKLy90MUplWG1oUHVKU0k0Z3gy?=
 =?utf-8?B?ZWlQL3dsbXlOODMzTTdVZmdTakQ1VWpHN3RCaFQ5aVNOWWxFL0ZEdmtialZW?=
 =?utf-8?B?WDVmaVQrbnBPb213VzlzbnVxR244WXhSck9GejRqVTMrc3AzNHg2K1ArM2E0?=
 =?utf-8?B?S3M4bzVBNHBFT1ptZXp4SEp1Vmt3ci9kYVA0aWJmMndZc1pmdDdqa2hjU21E?=
 =?utf-8?B?V2oxd2xIdjZDWjd6RDhFRnplMUZSVU0yTms1UEZKWnRLRFJWa2J2TWZMSWtv?=
 =?utf-8?B?SGI1ZDZMSVJLMlFZbitiY1dNRHJFaHN5MHdPQ2tyN2Y2MXlhbDZZdTY1VUt5?=
 =?utf-8?B?b3V2eWltWEsranM1cjBDNUZPcURhT3lIa1NVMVlWdkFHQy9pQzROY2lUOWFU?=
 =?utf-8?B?Y1U4dVlaVGNRM2d4NGZzT2xGYllXMm4wSVdhNHBmUE15VWFERm1wUGdZMk9m?=
 =?utf-8?B?aHpxKytjYU5ZTkxwQzNWeXV3NDNkcWU1VzBzS3hQNTFnODJNY25XQ0FRZWN3?=
 =?utf-8?B?a2lPSmtaNjJkZUVTN0VHVjVVbWxUaHRwQ1Z4UlJ4UURvRHFMd3NLNEp1bDM2?=
 =?utf-8?B?VE9ScjdqTXduMC83QTZ0bDRJTDFHdWVvLzBkWU96a3JyUEdqbmZrZitxUUYr?=
 =?utf-8?B?TmVnYzczaTNTcFNzWC9LVmhjUktONlB5Kzc2MVA5S0hnZ0s5bVR4UEhxaEY2?=
 =?utf-8?B?dk5KdTczK2xJaG9mRnZkczNsTGxuRnFXenVjeURaRTdzOWc2aEhNS3EyemRx?=
 =?utf-8?B?Smdod2NENjhKRzRwS3VES0xEdENYU3FSeXpTdzI3TDNDcUJVcWJ3dDBqTTlu?=
 =?utf-8?B?N1BiWG10d0xXaWloRnNBODJCWUU1cEVwdXFpbXJjYjMzdVhnTWloUkVObC9Y?=
 =?utf-8?B?cFlUU1MvU3VxNjZjaGVndmcyRHpmbXR5WTM5c1NBeXFsSVlEVUwrMDdFakIx?=
 =?utf-8?B?NDRhMGxndmNYS0xSOTVDL0h5aStrRXdJaDBxV2NwSzFGL3o0N0hReExmdml3?=
 =?utf-8?B?SjErdC9jQnRha3o4c2RHck5TTzM3aUVMTVFoSjBjNFdUVFQ4aW1RTTZObDds?=
 =?utf-8?B?RHdRMXRHTEo1Ukowa1dMRWZib2ZxOGZLNTdGMWZETm9DNnVmMHdKT0Urak9Y?=
 =?utf-8?B?MWp3WUhvNFVXSmVnNnJPUzdLMlNhL1NzQSsvWXpZYlFTNENmMnRJdE5Xb1JN?=
 =?utf-8?B?TjFKay9SNnV0bWN3dThQbXovZ2xzbmpVdGRrWW5VS0hpRXRVVkN3cXo2WmIw?=
 =?utf-8?B?VGRjcWVONWI3VHNSOFRVVXJabENzRmpSN1ZDR096c1MyamM2cnNySndyZ2ln?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414f9b69-b4a3-4ad5-6938-08dc9ab0a919
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 16:04:32.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GAFWM7w5GN8CRFnW0yLKbMCtx45hmFKC5xD/8fFSmu6a4Yw9xjkdOPfUDKhbOxIY7YW29JIZDKYDTu0I98FOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4034
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jul 2024 16:04:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16363

On 01.07.24 07:08, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Secure boot and SWUpdate tests are passing now and are supposed to keep
> that on future changes as well.
> 

And... it fails:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7246397870
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7246397883

I tried to find where that swtpm_start.sh is defined but I also failed.
Can someone explain to me where we maintain these - as it looks like -
lava user-commands?

As I said during our cip-core WG meeting today, I would like to ensure
that all those definitions are pinned via isar-cip-core when its
pipeline runs so that this top-level controls when a test change is
imported. Any suggestions how to achieve that?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


