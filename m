Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71032C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 07:30:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.82])
 by mx.groups.io with SMTP id smtpd.web11.9975.1721287848980700520
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 00:30:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ISN8yr6A;
 spf=pass (domain: siemens.com, ip: 40.107.21.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVqApvbfAO1qKFt34oDbNTdk5QyoQ3gyNuYkFHmQ9wX1fnDz0qwL7394H5rN6QpQVIwoOd6JuClHz1PcF9mCXEQJTi4uUMegp5Uh1+umXYAidA0GUMLmDEpbyjMFERBtXJE5wVUL6lfGsWiGeZ3qQBnk7GUnOyfIL4Ymm+c2mjmfjSjpkY+xGMy3b3UiO2jw3oKV9Wf6A4wKd7iAzJ0CBmLTuFQdxgjMJWhJH3vzB/r1nnCV81H//emnlWqmuUXdSSfUlX+inku9ut4Iw3Jle9ZREqBiMcBj8VocEFoq/WyINkYDSWDoN6xCejWXo9SV/JFbQBS4eFM6G0hQw3w1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtoPWpem6s2MsL3W+Ygc2o8v8zpu+qdt4plgeKbnWfU=;
 b=ckH3pn+qrHAIELauHFAmn6oD5HmeX8sM4X0Mns2wTuwyJ0Ngkj15XlT+nz67BDbVsMEo8owCSUvZYPIFbvbMNrWwGE3VomhRFfCbsMHXdAEAlgz9ADxrl4UaueUEcFn5XKUwxeiqnj0y6yF3PD0BEmmX9WsLpRy6PACPdNBJP+Ep04scOo29+1vHfpbfy+614X9qpZDTBWXawRle7mSiofjbPuFFB9fMaIiuuLk0MqC8cuFnMmPtjkRxJ5utxMvD+0eizJvwSo685EJvRgCL2ciHkut8Akg7WIH6ffSq3Kx1WtkGhUciR1+MDp0y0YNFspQxkdt1fpoz9rrGyxuH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtoPWpem6s2MsL3W+Ygc2o8v8zpu+qdt4plgeKbnWfU=;
 b=ISN8yr6APbzXdc3J1aaHgllgT8sY3TnQzeJzsTViTfM9RIuwB+jwTowunHbhiY/Du/GMz9RjgLLER62EdM7doRTOK4cTbT9j79aLg6i9phsNeToKlaLU5oZ0T5Y5W97aKYf7J/UI28avq9pLfB1egSDVPtIMd9Dlxm8ltocgGQED+NTtykd3/WpJ0v190tjQdG0UIzWPqZSN4NG88KTekivU7HiQBF8dqHM/OoklCRx+c1fqMn4haYkM1NDKbLGUnBsrJgMOz3DYiN/eJavTMZTHWoA7QAIlfH56LgU+hZrj0smJVFxsl3bwLnasyqFwHyi7Fdo0nHIsHpYWJaeSSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 07:30:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:30:45 +0000
Message-ID: <d6bdd6c5-bd0f-4cb6-baff-8330bcdfebde@siemens.com>
Date: Thu, 18 Jul 2024 09:30:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] 4.4.302-cip89-rt50
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <ZpgiKy1r4em0IbEh@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ZpgiKy1r4em0IbEh@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3521:EE_
X-MS-Office365-Filtering-Correlation-Id: d88dcbc1-428f-4c6e-26c3-08dca6fb8980
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHFKU21vMGRiNzhMYXFUZ3U5R3NHeEhkMW4zeXJJdlR6THFMN0FRRi9rQU10?=
 =?utf-8?B?dFd0Z1VObWR2S3BDU3ZIcWR3YlRZR3JFN2Jtd2tVL0FUZUJlc3UrR2c0SVFs?=
 =?utf-8?B?YnhWaERCQXJBRE9FM1BNRmVyRElteDI0TWErdUt1bytVODZ0Zm9USytDTUFG?=
 =?utf-8?B?bnNZQloyUmVLMmgyRUdlMitqS3RzMmQxT2h3RlppNGR2cFlOOEd6YjhVejk1?=
 =?utf-8?B?VXM0bmJLd3dmdm9ta2NkZnJyQUJ5NWdkRVd2SVlGR2FjNDA5RUwxcmlHNUJM?=
 =?utf-8?B?NzVKdjBSczIvN2djSEo5NEtXNmQrdmxWQXhnR00xTXB3N29OVkhpZHVhWlBB?=
 =?utf-8?B?bU1JbHQvbWhiQTJneFh0ZjliSDl4R0I2RXUvSGlXUWYxK3pWSVFwa0hDZzZ5?=
 =?utf-8?B?K2Y2SHRkZEZuYVo1bURWR3VJaGNUVGVLbDZjYXRJT0xzOVg5NXQ5R3E5QWZK?=
 =?utf-8?B?c3VsbHZWYmxxWElxZGc4WjZnTUZ5VVdaSENpOW01SXNxRTczaktpUEhlcU1h?=
 =?utf-8?B?Q1hmRlB3VDBTUEJnQVpEdEsyUWNBL1gxMG16Ny9tM3AvVVI2K1hQSXB4OUx1?=
 =?utf-8?B?dktSRGptdDFmcGcxMUVvNW1qbFNHeHVlZzk2b0hMQ004L2NKSE1CeEMwVjMv?=
 =?utf-8?B?QXJkSGdYdm16VDRXSEFtamFhZ1hNK001RzY3QzhTNnk5dXZqQ3lNOThQWEti?=
 =?utf-8?B?NmpMR1VBK295dnlzcVJoT1h4NVNHYXpwMEgvWUdtdThLTlNYNE8yQ2piSnhJ?=
 =?utf-8?B?MTJNOE5TTVhEaGdKZnhGR1YzdXZXV3VJWmxEY2NIMkZEb3hWalM4djBENjNm?=
 =?utf-8?B?QWFiOWwvbjcyYlpkZldwUWR6Y3d3eEVGVnB0VTdDVGx6OUV3RjNUT2VSL2Na?=
 =?utf-8?B?UzA0eWdWUEdTY0pGa2dxbzFLa0w0K2F0UjVYYUI3bmJpemMyME1KbzRaalZK?=
 =?utf-8?B?SURiZDhnVUFVK0crNGkrQUYzdWpTWDJtc0xCOGh1eFBNaUtmaEpKb1VZanh3?=
 =?utf-8?B?Y09UbFVRMnQ5NUNWNWFMUE1aZmlhSnkvNVFoL3JWK2RwOUw4VHFkOGlEOWtl?=
 =?utf-8?B?UXZ1NGp4SEcyTzdRZ2FTQmNuOGp3QXkvK1pTejRaVCtBZDhJZE1uZnNPSmdG?=
 =?utf-8?B?ekViWjh2aGswZXFOelhwQkZjZTY4K3B1WUw1ajNRVDNvYWYwTGFKL0FXWHMz?=
 =?utf-8?B?ZWkzVkgva09tTVJ2Y3FRTjE2NlNKTXFuYUR4dnBFTUxZbmcxTndnTlU3aU9B?=
 =?utf-8?B?SVhUM2lYTUN0RmI5QmM4cnNWZGdwQ3g2Z0o4UCthUk1wZUxpck92a1U0b0hv?=
 =?utf-8?B?azROT05iRHI2MXFuZlpvcFIwM3d4SDh2c28ydzQ1TmdRb3VVeUtmdG1SZ2NI?=
 =?utf-8?B?N3I1Mm05Ukgxd3BKODRrbWI4SU5nVnh0clpmbEhpUk5uTXN0ekprUU5ZY0c5?=
 =?utf-8?B?bWZhdTJTajluRE8wZG15WlI0MGp6bFMxbktYV2Q5SmgrNGFQRWpkRFhXQTM0?=
 =?utf-8?B?RUZ1bHc2K3R3Z1pZTThWenFraDNrVTRKRnFEa1JJTDZYbGFjbllLYWtzVmVy?=
 =?utf-8?B?Qm1idnJBQ0czVmxDTFJXSTV4RUsyL2pjUTM2VkFnMWNITURPZmhYUXo5MEoz?=
 =?utf-8?B?SDhsWXlOeDVqSnRwL21PT3JQeHFRMUFpMnkrMkhqSk5sNFRBOXNjaEJGenEz?=
 =?utf-8?B?ZUlzeXlwd2M3eFNkdktodDV0bzVmYU5TdFlXVkFBNHd6RGFnSGNhNnhFVjhx?=
 =?utf-8?Q?sUgMiytfCL4z6I1tIE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE5wdXdDTTh4WXVQYTR4bFpSTU9VSHF3WjhUL1VxbCtyK25EaFpBRjRzMjRO?=
 =?utf-8?B?VjQ0elNtN1Jack9mNFlkemNvSGFSa3BZSDhMSlo1Y1VvblErQXJUdkRQaHhK?=
 =?utf-8?B?NUNOblBwdnZUMFV5NklXdFhjSFpkcmlZU2VnYVNLdDk1RzlHWTBhdC9ZOC8x?=
 =?utf-8?B?eHppeHJ4UVlLQ3BmM09SSzl6TnZ6K1NReDJJY3hKVVdVQXhjVjJkSjVzQWor?=
 =?utf-8?B?U1d6T3FQT05INWRQYTJkQk1xdXRndWQxUzJ3OElPaGgvdW1wSFQycGZDU3ZQ?=
 =?utf-8?B?Q2JzOWZTT3d5amtrZUREczEvbGlhZEFpY2dxN3FlT3FVOTdOTUs0cVZ0akwr?=
 =?utf-8?B?SllyL0Z4M21IeEUxUlVER1BCNndFNlB3M3ZCMWNjQ2V4a3pFMFhrWENWUjlL?=
 =?utf-8?B?OG9MTW9RUStUWnpOL3EyR052QWxRbEZUNFYweEVrNEdVSlhSRDZrSFRkWkh3?=
 =?utf-8?B?dnZsanROcTQ5SlZtdmw0cHpsUHpQV2lBVFR6cVZkcjRMcHZVRHAxTEx0NkdK?=
 =?utf-8?B?Zmx0alBvWTRaMlJDRDRuVkVWd1BXTDFkVXhUaXcxNk00a2N1VWVoL0VTY0hk?=
 =?utf-8?B?U2dXdHZmMGZodFFoQ1pQdllCaHhDcnBmZnYyU3VBRVZtRVpCM0ZQUk9YeWlO?=
 =?utf-8?B?ZzFrYWFreWJWd0thNG5kTFhlcmlTWXdJckx6T0NTdFo1bjdJS1dtK1I1Unow?=
 =?utf-8?B?QldFMlZOUmZlZ2F1MUltdU5pUjBRdkl4clB3MmpVM21CMDFFSDVTTWk2dVo0?=
 =?utf-8?B?QmR0a1gxZUExTWZraFdWd0JWcFdWbWFoaWxvMENUMnh2dG03eWFIb3hGNThN?=
 =?utf-8?B?U2Qya3ZEU01yLy9sR3VYZmIrVkxoR20wNndTSUQ2NjNZSDlCelFJRlJJNEhr?=
 =?utf-8?B?dU84RDZkU09xY3RvVG9Ra0ltVlZLSTlKelNVR2lpUk5vNllUNkpuZnZmaUZX?=
 =?utf-8?B?UkQvYUsyWHNpdldjakd3RkF3cXkrTDFsYm1aY3c2OXRZRC9JV05OOVlvVW1N?=
 =?utf-8?B?dTdvMlhXZzYvb3lpOHJBZ3lMOVIvNVUvWW5LYmlhdm9IcTl5R2ZlRXdEdnpO?=
 =?utf-8?B?L3haeXFFNGVVSFZGZWFFNmU0Q0RmVEREd1dDUVNYbWY2L3RlRmpWN1FEM09n?=
 =?utf-8?B?cDVOK3BwNy95TkVvMkdtaGdSNnBFTXlJM3hDMGFyUzA0ZHNBMjBidkZYUzBt?=
 =?utf-8?B?SzYrUGkwT1Z1MlJ4aEl1aGdKTXplRHJjYThGeG1pYnYzVlQrekRlKy9Sd3Rz?=
 =?utf-8?B?MWpxK1Vad2ErWm94bE44aE5BTTdVaU5BWm9NclRnb1V0cXI4TjU4dUlycVNL?=
 =?utf-8?B?Sk9pSGl4MENxZnI0Sk9xbEVrZVE5SVBOK2RjUHRGWkxZb1lYbkFGb3RkV1ZW?=
 =?utf-8?B?c1k3OXk5TFFqNlE4Znc4b2tZaU4wMjBzUTBQaHVqMitlNTlNUElEd0Q1MUky?=
 =?utf-8?B?VTZPbVpFRjl3QlExemVKQ2E3RVMyeStLNDY2NjMzTDhMVDF3cWplcVJjYVlR?=
 =?utf-8?B?SVN1OHNvVUx1YmQ1U0NPK1ZKNWRlSGFiOVd1RjJpZE40VzhYYzJyM3BGVlVU?=
 =?utf-8?B?WDdubVd2eTAxMWQrSDFSUURyekR6VG5kbDc5Tk84dEFENW1MRTBxVEowbjN2?=
 =?utf-8?B?RFM1WExzSkhETTVXcWZHOWh5ZnZGNEhROHJERFIyNnRBRy9mQ2hOd3R0djVh?=
 =?utf-8?B?aGtwc1dTMlpYQUZZYW9jelZHQWZWdjNmbkM2bTZhYmpOQ0Z6bFoxRXRwMndh?=
 =?utf-8?B?Z2J0VFA5NzliQ2xrZEc2bExlbDczeTgzVmFNb2Q2OGk1RTZielB0dEFmT2xY?=
 =?utf-8?B?b2xVSlhZM1VtWktCMDh3Zkk5MjJGNXdGbjdwOG9IZ2F1U0RMR0NIMzNzRlVT?=
 =?utf-8?B?am5vNW9YSlRIMVNVRGw5MlM5NUJCcjVFQlR4NXBYejJPc1kxTHlZcTJCRFdu?=
 =?utf-8?B?amx2WnVUM2F6cnhtQ0hsb1hjVmgrSTBmaFF0OUxiNi9vTmh5ZFNoNlYzRWVa?=
 =?utf-8?B?MmFueGhjMUtDMTR3NmFoUXBlbGtWZVlUWXd4YjBKbUlGQjh2ekE3V0ZaN1lO?=
 =?utf-8?B?RG83UGxCektBeUdXWFVMeGh1Y0hrS0tFVE11dlZiQ1JMT3lyUDBMVkpEQ2FP?=
 =?utf-8?B?S3ByQTYycnd2LzhIYjhZQXJ5MXVLS2NyREVCMmhyT1ZqbUN0NS90MU5ja0Nr?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88dcbc1-428f-4c6e-26c3-08dca6fb8980
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 07:30:45.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtAePUJcVCetXNUJe5XMsE4CSsc7NjG21WY8H+2u/hCIEiu24XWY1H8lLUnYplV/3VR9Bl2wGu3IEXtYBzj1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3521
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 07:30:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16575

On 17.07.24 21:57, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase
> 
> And their content should be identical. There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 

It's not yet there - hick-up of the infrastructure or something
forgotten during the release?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


