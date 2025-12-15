Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8C4D5B16F
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:14:25 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48094.1765804462567523458
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 05:14:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FZLjwScm;
 spf=pass (domain: siemens.com, ip: 40.107.159.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9TpjNgVJWAxWss2mb7YyVwQoHqCDZPdkOMWqi1HBM4sIcq/+FpoksF7m49UVMNqBXeQmebg1hlfHwVfu5CmKDTZZ0/RjOQqjxlnb/xmopJLr+YkS6YSIy/NaKHRRvSBXWqCYIUcYe8dKPzCiHcpdB2PYK1Qf7oRMqhYKDeHU8ezxTWV/6iJRySab55Q0vqckNIuNu6Er1Q6rj6SZuMcjTmBoOap7Knzvh0/mLbHVsTayYZ5v5sPk4ofFU1sa+kJsw8B6hAF6pk2icLpUVtfFRvTSUDj8X82dgGnrim7BK3lxOd/FkzrN71ZAemeu7phTgfUK8aQ/L8+BDDcqc5oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VKxy61bfQpMojC1BHcBStGFIxoYhx7M26lbQ42XcQ4=;
 b=IJHnYm7pOPqHF1JZyGWSACksn9r81BSyHeJ7gVWGti9Eg28xwbStBgCiaNqDB+zLfWaq9T8i6bHMu0GAMBzso+AtHs5o24IrCLnbDVvXhbabRtM33sXLR007EE7uzEstlsUTh3j6vGdqR4aSDtynDIZeEMK2vAt7VYZrbulD3wRY26nxoYBhrKk8TmNY7cWy4DoAR7Ji/d8G1y1rTDpXuypb/MeHRmMOk0rQirWYigeEzjd6f15oMlaDSbpXcb/ncH5UomQsdPxwCsWlzzt+A3S3vmInowvJtX2ZRke93a1FUJ1jPiocjnbfEl676jt9x28dmsvzOUIf8CV4wCjd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VKxy61bfQpMojC1BHcBStGFIxoYhx7M26lbQ42XcQ4=;
 b=FZLjwScmQzSh5GSXOO8ap/t0LF66FCmIg3EzeP4WW0dCxoUKkZMx5+R/MbLa9gToq/2O0eMbO2XmOjduaeoJxqYe8HLV3lq5l9UJ/Pi+/lK67K+Dnh1zIu/Q3K8l92aJh4VBtSkDSeNJ6BXxfdzPjvuYajnF3uJnlOo79tzG57V0glkppv2s/yWtXEI8mNtwuG09+Yp6LAbP0NWJ1cDFIZQ27t6YccuLNTcs1ng+VECCYP29rz9sSewuEGg5VTibMb5fq18JtN3KjlZHJZvdBalBBN37ekD5Bm5LGY04hiLJjCzWMSULW1H0y/8rcY8Cf4x/npiG6tZv7V7t8GbwPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5346.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:298::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:14:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:14:16 +0000
Message-ID: <103d8690-317f-41f4-ac5f-1ef30624aae6@siemens.com>
Date: Mon, 15 Dec 2025 14:14:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] fix: ensure that the
 partitions are available
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
 <20251215093719.323668-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251215093719.323668-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 46da02ff-e6c1-4c5f-2856-08de3bdbd90d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Tkp3ampQM1drRTBtcldoazRKTklrYXF4d2tHbm1CYWM3bm11ZmJNVUxEa2kr?=
 =?utf-8?B?SjF6d0thWXhtaWJlcGsydXVGMi9wL0lzU0J3djQ4MGFLVnJQUVU1RW50b2dt?=
 =?utf-8?B?WTJsRVYwdXpWdWgvcGhsMEtDQlZwSDhwZVliejQ1SHQxcEZ6dWVUWDR1L2hW?=
 =?utf-8?B?OGhXSE0zaUNXQWhNUmsvcmQzUzduWHY0RHZlclZjSzk5ZHo5bFdudnQ3VEk1?=
 =?utf-8?B?cVQ2UVIycWhOR2FnYmpJTDY0cjRQaXM1OElKOW9zclIzR0diaCt3NjFZdm9F?=
 =?utf-8?B?Q0NwRHRmZ1JNbDRyTzFxeTBoS2NzVjlLazc5blRVN1R0dnVIeHA0UHd0cGRo?=
 =?utf-8?B?ZjhnUStueFkrMExkZ3JkVFI4T3J6Wi9wemdXWXlWVGNwQWxzcWhiY0tBdW4r?=
 =?utf-8?B?MkZPbVN2MHVIUmQ2TlFGQ0ViQjAwMDEya3dmNjJTRHV3TlF3S1daN0dwb3JN?=
 =?utf-8?B?NmFMR3VmdXlub2xGZW1Xc0ZHNlBVemM3M1JZSmF6VDdRaE5QR3J3VG4wNzhH?=
 =?utf-8?B?SUI2dERtQkZnT1Y3dk80UkFCNXhUcmViL1VkZldlVGxhRkFzSkkzclp5NFdj?=
 =?utf-8?B?YXk0QnljclVCNFdVNUE1d3lmQVpiOTE5WnphYWVFWlVvNjR1SG9BUC9yRVZq?=
 =?utf-8?B?VmloR1hkNkhUSFhnbGhTRGlsWUgzREdvbVo4Y0pYZm9KVENDNE9xWWllV3RZ?=
 =?utf-8?B?aDB0QTJGZ3lmTms1cVJTcFNudnFsM0N4ejYwSVQxV1JXenZzbDgreG4xS2Fo?=
 =?utf-8?B?RkhXclRLeUVZZXQ1dEdxSGF1aGpOQXlvcDVtbnZqbWh0Y2pSeWcwM0VkVVNF?=
 =?utf-8?B?ZTJGWEpEYTZIMkQ1L2hQaXp1VDNiQkhMcmgzeHlVY1Y4N0RWOGVlMnlCcENl?=
 =?utf-8?B?aEs2U0s4SFFHMGR3Z3NYRzhrY29tdnVXME9oZG9WTTFJdGtFbDlpeWc5U0xX?=
 =?utf-8?B?bVlrb0pDUXpNZUt4YUFYbm5aa3g5MW5ONkFFNTFuMk1ObXNXMDE0cXF5bVl3?=
 =?utf-8?B?VDY1QUxLWlF0Q0ZFRlJJbFRQSjVNejdnUnBDWVFBNDdOampoNnpNV0lySjFP?=
 =?utf-8?B?aHVWQjVuVWtEWm5MY2lTUWZqbC8vQ2Y3Qm1TeDRRMFA4THl6Mm1SaFRWNTVa?=
 =?utf-8?B?WFliNXpqSUNoV3NRUTBhaW9kMDdiZlQrSjFTMWJIMnlhU1Q5UUtHYnlFUldu?=
 =?utf-8?B?YjVGbjZuVjlhNkdUcTJ1bXlNcXJ0L2lZVzBJdlJPOUR1QnpEMWJpL1RZcCtt?=
 =?utf-8?B?dlVTbEtZSDZmck5UUzR2TkNseVE2dlFoVXNzUFJabjhnV09YYktMQ2FYeS9G?=
 =?utf-8?B?THo1YWVGSjNrZHZ4eitFYnBBQkpCaUtRQjdEdTBrd25FZEUzcFRRUW5raUxI?=
 =?utf-8?B?emRzbEVkRzJwK3lEdzZwdnJQTEpZQjhSU0tGRmd2dDFmNnBaZ1FzeU1CRFVU?=
 =?utf-8?B?Mjk5K2ExSFRTTncyb1VOQ0N3dFN1eUFCSTNZNlk5N3BBRVdSS2tBa29nV3Fh?=
 =?utf-8?B?eUJIUTFDazNkTXU1dWdsUHNxMGJiMUo2aHJwTGhoUGRLNHBQL1dJTnVqb2Vm?=
 =?utf-8?B?RzB4aUVvRHpiblBUNnlVazlrbTgvK1BCaWsxYUk5L0FPaGEwNVg0ZzJ2NWVZ?=
 =?utf-8?B?bldSRS8vcEtMc2o4Y0E4NjJWb1JUdmtpNTdkeHVObGpuVGMyNi9rTDNpS2gz?=
 =?utf-8?B?TjJLU1hFUlJrdXQ2OVFFM0FYK1pCVlorQVA4RUdLblU2WERmRDNKVEllTUZu?=
 =?utf-8?B?VVU2cmpBSHExbXlwVXNCelNCUzMzQW5wREJFNE0xSVZJQVk1b3FXWWpoQ01a?=
 =?utf-8?B?RXJQb2N6VE9VUGo2cFlKMGoyb21pNVFuc1NXNVlzL01JaitVZlY4a2k3UTBs?=
 =?utf-8?B?VGF6a0J1cEpwVG84dHlUcnBBRzBXZWVjUUxmWE1Yb1BqWkxROTBtbk1YYVBj?=
 =?utf-8?B?NjlhSHhKSjFuTm5rN0NuQ1hyY0RpNGg1MDdkZHFHMEwySDZFVjZYdk13d1hT?=
 =?utf-8?B?VURrSTB1ZmJ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGlneTArWE8wRkZqZzhERGxYMys4S0YrR05jNFd0bi8xNUxjYkdBT0NMR1dq?=
 =?utf-8?B?T0RHb1Yzdk1nbzM0eVZhakQ0aFMrVHlhRStlVHFFYkk5a2M0ZTJvRXhoSnJ2?=
 =?utf-8?B?angxc25hc1BYTDk0Y3Rpai9yb1pZV0FZVGhtZHRqdzRPS1lTdDZZTWdZWm1k?=
 =?utf-8?B?ZXFybmU3RTZEU3lMS0paOEFEVDRqNmprdndzcGdlWmdWTEd6VWdvcUtBWjV3?=
 =?utf-8?B?NjVrcXhRV2xWczVWY0lueS9Xc29zOFYxbTVEM3JvbzRJbHRON0FrRGlQWmlQ?=
 =?utf-8?B?dTB3eUFlRkNyTzVvM1RYb0JxNUEyNWp5VGVwOE1HRWZHZWdlYTEwMTNiWGdt?=
 =?utf-8?B?TXo2ZEY4M1YwTlJwVlZUaDRtU2VrQ2QxMEtrcUN4Z3BrOHZnaitsNEtyYyt2?=
 =?utf-8?B?RGdvend1YVNHTUtiSTMxYWIzOTZ4aTUvUkhJWEx1WTJhNGRhbG10WUtQaVlF?=
 =?utf-8?B?RS9wSTFVd2wxSU9rWW45eVo2VTl4WDY0QzRodGE1ZnRKS09IanNVRmg3aGYw?=
 =?utf-8?B?UEJ5UktWZkJxSFpiK2VBZnBoUVpka0FCd2ZyK1RJQjlFNDdKaHNUQXJUSlJv?=
 =?utf-8?B?THNMM0ZDc29uSC8zTG15bXFrYURybWhwUU9nbWs0d0xFYmtSYXJTQlhsL1RS?=
 =?utf-8?B?RE11Z2ZlZE9jWkZaVWFwRk9sdDBmWVV1eGhQaTlWMWlKODBmSm16VE9EQ3Js?=
 =?utf-8?B?QkhvKzUvbVhUSmtkdUlHK1VCQ0kyNFZRaHhuNldKcjNQaW52K3BIckJLbVJv?=
 =?utf-8?B?UXlmMkcvbGJ0bm9Vc3cxajNnbTNsV0IzVTZvV3YxeE91MkE1K0Z2dnNBTWtj?=
 =?utf-8?B?VTN6R2R3RGErYXBqNUNvQjFqSWFYaE5pQUtkbUdnaVg1M1h5T3h5UDQ1ZVhZ?=
 =?utf-8?B?K1pmRFI5SVAvSFlocG40Uk00akYweERibW8yWk41UUdDOUtqYXEza0xMZUEr?=
 =?utf-8?B?bFprcFRSR04wd05LNkRqR2FWWlJJWGMwenZJUTg3dm45RjBaTkZmVXJycUFP?=
 =?utf-8?B?eFFWd2ppRW56UC96OWxlaEp1T3NnbFloajROS2oxYm9JY3phUi9uR3hlTDlF?=
 =?utf-8?B?K3huTUhIMzREUG9PcnBHNFdXNHR1dXpXNnhkdTYwSHRwVGlheFZKVXFmNlhl?=
 =?utf-8?B?MU52Yk9lSERRL3huWVBicHpxbUZnYTM1b0J4dUV4N0VPNUxBaE5yeVRrVlZh?=
 =?utf-8?B?RG91MTJHVjd3ck9hK01yYVNQdEp1TVQzWmc2OERYVlE0TUlJUm0wYk9IOWFj?=
 =?utf-8?B?REZQbGNTNkxhektsRit5Zko5dXUveFdnZ3pRdmdyNDNKc2sxc0ZLN3o4LzBi?=
 =?utf-8?B?YVZtRVBMdjFmTFdSNTJRNEt6UzRwRzFMNmNUVjR5a2Joei9GTHdBakpzdC9v?=
 =?utf-8?B?UWdEVEIraEo0MjM2K2pVOUQvKzkzc0VPMitGd29YUUJoOVpzRUQ4YUlRNVc2?=
 =?utf-8?B?QmdkS0tLcmw5dWw4N3p5aFB3cE1hekxpckFDcnhncHc4djNiSk91VVNvRTY4?=
 =?utf-8?B?aTMxVnJBalhzbVk4K2djNjFPcTJzY0lDTEhwdm1kQWNXZE1RQmtPRFlpTE9h?=
 =?utf-8?B?ZmJBcUtBQWtyM0xoSkFlTFU1Ny9LUzVQdFlGbTlaNDVuYzFDNkhBNFpGNElq?=
 =?utf-8?B?TXcrd0VmdHMxUXVYaWZsYThTT0tyMVVUQmV1VFFVOWdjTjNGeEM0eDNSZzF6?=
 =?utf-8?B?K0RJakd1L3c0ZWRtOVV4UTBWd3NTdHl4R0x1TzExWmFUMVlyWVNPNmkxdkFj?=
 =?utf-8?B?c0huam5hMHhoZEt1bm4rUUZmOGoyV1hKeFVxbEhtZVhqTTZwVkhDYjlJMlln?=
 =?utf-8?B?WFVscVJBSm1qa0MyWFBpYzFieXVDUE5RcmMzUHFlbjBqWndYWmFIbUpTcjFy?=
 =?utf-8?B?ZmUrVUx6VUNRY0t4Q0Q0UjFRNFJ3NmxZdk94R1FjQWZQVFIxUUxHZEdOb3A3?=
 =?utf-8?B?MlhFNHZUUERjZlY0RDJiOWt4NGJ2aGhzbkJPQndRUUExQjA2dzBlTmFRSkZk?=
 =?utf-8?B?a3VybksrRWh1RE9BK0UvUDNzRGVWaW1EWFpGU0U1TEVJZ1lDN1FjckloK1I5?=
 =?utf-8?B?VnJiRWx5dVl5QVNVRld3VTRrbkxhKzVPZnJVZkFMVi9Hb0FFOUgrQitlR2VN?=
 =?utf-8?B?V29FeXpmUjBkVjh1ZGs0WnpBUjR4SCsvbXByYllpUlVUVjZTbkp3d0xXcjAw?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46da02ff-e6c1-4c5f-2856-08de3bdbd90d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:14:16.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z//IKilkr75reLrUD28rMb46KkRbFrNxyL4Si3wXPkCm/Bd6kG+ie65T4sAMpLVN9vQLaUlB8CUIztbN4WOXvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5346
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 13:14:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21061

On 15.12.25 10:35, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Check if all factory-reset partitions are available. This fixes an issue
> on Debian Trixie where the factory-reset cannot find any partition to
> reset.
> 
> Fixes
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/145.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/factory-reset-script.tmpl            | 18 ++++++++++++++++++
>  .../initramfs-factory-reset-hook_0.3.bb        |  7 +++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index a6c622f..f0ad40c 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -9,8 +9,26 @@
>  #
>  . /usr/share/factory-reset/reset-env
>  
> +. /scripts/cip-initramfs-functions
> +
> +check_partitions()
> +{
> +    found=0
> +    for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
> +        if blkid | grep -q "$(basename $partition)"; then
> +            found=$((found + 1))
> +        fi
> +    done
> +    if [ "$found" -eq "$(awk -v var="${INITRAMFS_FACTORY_RESET_DEVICES}" 'BEGIN{n=split(var,a," "); print n}')" ]; then
> +        return 0
> +    fi
> +    return 1
> +}
> +
>  target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
>  
> +wait_30sec_for_condition check_partitions
> +
>  if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>      log_begin_msg "Factory Reset"
>      for target in ${target_devices}; do
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> index 16784d8..95fff71 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> @@ -30,8 +30,11 @@ TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>                     INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
>                     INITRAMFS_FACTORY_RESET_CLEAR_TPM"
>  
> -RDEPENDS = "factory-reset-helper"
> -DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
> +RDEPENDS = "factory-reset-helper \
> +            initramfs-cip-functions"
> +
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, \
> +                    factory-reset-helper, findutils, initramfs-cip-functions"
>  DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
>  HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
>                     mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \

With now (almost) every script testing if some partition is there or
not, I wonder how much time we waste in script running later on and
re-testing this. They will not wait but may still iterate over partition
lists and call various binaries. Not necessarily a matter of this fix,
just an observation / wish for optimization (if needed).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

