Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1635C87FCA
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 18:19:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.web11.3220.1754590775144760624
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Aug 2025 11:19:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y3IcQnvH;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAcHCffZmSPuhZzI0ajLHpX9S4dWZrGI1Ls3nihBstZbb82l6C4gFavcWkH4PWJ4qTq6PkzWgHX1rbJI5k21qdmnvTw/YVIdXFX4E6HvYf8fevf0vPSjhAencLPVVfX/d1oDYTYchAKm3lwXRYdaHfJZyRZqvSCbtow2eVIcMU5sbQlaatXbowD/jNJWQ/oSurLZx+eHVKA2qpge8NxdcNmsMyh/1hNAQjTuAz2WdK2FHBvZAU+5yG4NrQX+HMSF4bL0zcA1zEt8MChBoBkKVB5PU2VHCMluf45ahXaTTmetxmKOnvoLbTvi3nGqAPJ4DiD8P0NNuGZB9UxZAWdSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBjSO3/JOnQgF4VhJKFHbT5H6TMgLUrxF/SKccKg7Ew=;
 b=CC0Hxn3TChAF5ZqujPLL8eD7Kr/5K/Im1jo1+8eqbuygoCYH7gykW8gvDZKMk04dleqUB0Uvy9aAy6jgX9VVXreBbRJq2IkY91K2yzdF9N7TQOujbJwtEAZuJN2nhq38kT46+i3RCfT37SmKYT2Pvc+Jghab9fyCw0VDvc4H+U4HkzKGEdBbOQ3cRNOre43OJJbBm/AmTihxI5fv6ZBk/37AfvnfwitAVwdQn7nmFF555v+TXEmHntXmXRAlZD/e1grXuiQBNMvIOouzyVBu6qdUmqkKkkQoScR1UkgCTvBUCm1vJMc27VNI6gHPqtoOnHkEqRLFMsEd9uBPt9U1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBjSO3/JOnQgF4VhJKFHbT5H6TMgLUrxF/SKccKg7Ew=;
 b=Y3IcQnvHmgGoBt6fbMKU3H9DY4YF+9NSkWwq9IEzDyMHDW3NuySRhkkL1Jt0OC5bpaW+a8OdgxHTpmtqMfceLBZ0UIIb0bKC/xj00Kk+5t4B7qesLS40tDuAEbAqtvXky58Yfo9zw/PDlcQpeiQo1fl6MMcTTNeGaYTidf7ON2tnULrqlr213baGhrB0jSCWY1jhkehd6rAVd8Z73XKnAOeLTwb+wfBGJCyx8MJZBMaIptYyCgEkYbJIgQ/Lrhv/QkDqIjb/t8vXLGGvB+XN7qHWmaJRbfG3zceO94TIumGk6d3VOU3ZVYf4TIu2m4TAsyEnHU3Kri+bttPuMQPYWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:576::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 18:19:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 18:19:32 +0000
Message-ID: <297b0d8c-425c-482a-94b2-e79b24beb19c@siemens.com>
Date: Thu, 7 Aug 2025 20:19:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: Update to 20250530
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1754534770-19831-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1754534770-19831-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a7d20be-44c9-463b-39c2-08ddd5def4b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TGhFdDkzYjdMbkRuK1JCU3Uvd1hCM0dNeENlZ1VWQjlnSmc4emlLM250c1hO?=
 =?utf-8?B?TEJ4ZWZ6Smo3aEo2TFJJZXpZbktET3MzSkVMalYzZzlMekt3bDJYK3YwQk45?=
 =?utf-8?B?ZnBYQTdxL2xEb0U1VnUzNHB3RjJGdVdVQmovdEFncGRNOGpKeXlieVJ3RGpo?=
 =?utf-8?B?SFNWbEtEZWFVTkJ3eVBEazlCN1NDSHI4Zms4dGx4OG1ubEg2clhuUGJpMWVh?=
 =?utf-8?B?WGRLY0k0aGgzaStNQy9Zc2t3cGZ1L09mUFJZNGFndTZBT1liSzdsSDBkMUph?=
 =?utf-8?B?bVl3OGtnN3E2dk4vbTRFUERRa0dqK3BuUUZsSldnN281K3BlWFdIZFZnZmRv?=
 =?utf-8?B?Q1o2dURrRmxsb01tSU5jMXNYdTl3Y0xrWEJVVFY0dWhtcG16UFRMN3VIVmIy?=
 =?utf-8?B?WWQ1U1RKbEhpMVVLWUlFbWlQZVNMTlBHUjdBUEtEUWs2Z3BtWkdIR3JPeFdM?=
 =?utf-8?B?UDVjN3VYOUpMc3Q1Q3E5S09ZYkQwL2EyZVgwSWpWUi9lZmRnSlRpazlVdm9P?=
 =?utf-8?B?ZGdJQTNZVWQ3UzJCcXR6SjQxSGFXWGxSL0RzUEZXdGQ2SGdxMVdzb3dVYXdO?=
 =?utf-8?B?WkVVMUpQVWJGdXU2QXZFUG1nVm94RmZpYXpPa0g4ZkhHU3hhWW5FVEpRdEp4?=
 =?utf-8?B?OU5QRUxZVlRYMkRkeTdjMi9QV0ZCYkVzT2tOYjJ4R29uS2NIeXlLdEdYckRQ?=
 =?utf-8?B?bkRSV0kzYUZQSmsxRGRPYWk3ZEdCMDlDbm1OWmd4bENRQy9ENHNEeDBkc3F6?=
 =?utf-8?B?Z1g2czR4cWtIZDFuTnZvNGluVW9UYkhmbDJnZXczUld5dlVNdkMvRHFmOGEz?=
 =?utf-8?B?ZjFSQVNzTHBDbkdyR1d4Qnp5N2UzMWVOTzN5MXpQV2tZeUJ0NWowUis1OUlr?=
 =?utf-8?B?c0hYb2JsL2hQTTZVK3A0YmdidHIyKytpY3FkN0czZmZ5T2ttZzZOYVR0UWlJ?=
 =?utf-8?B?YWFJRS9nRUhTTkdTMmtDYjF0TWNaUGNFMjlLSWJRbVdLa242eTN6MTJ2WE9S?=
 =?utf-8?B?QUh3YUhtN25ENWgzRUgwODM0eE5FYnlTRXVtcEtxZFE2bm9BYWRmZUtEdy9T?=
 =?utf-8?B?QTdQR2F3SDRyNU1OMWlLYmRSV1BYQTU1NTdGcVJMNjdINi9oM1AwcXNHNUxa?=
 =?utf-8?B?YXVoWHd2ekVHLzdnK0lHTzFwLyt5dEhiTU54Ti9QZmtra2p2djZrS0ZxYk1i?=
 =?utf-8?B?L09tc2pYbzVZOUJHWEtLaDV2VVZSVVFUbVlqVTJSeHVMV0lVVHYxU2pueGhS?=
 =?utf-8?B?aUJpajZrcFVHMkx0a2diVXh2VFFPTTdiV3U2Q0JSR3phWE9JSTNyVkVuSlNF?=
 =?utf-8?B?bm9VQzN2NU5TNXJoOGE0RDdlTXB5cDBmb3VNMTIzMXduaGJkdktIWC9NSzN6?=
 =?utf-8?B?alYzbCt6ck1FT2RvdlFRVUdYOTQzK3JJUDBjWHExK2JnOXd4ckJOV3I0WHl6?=
 =?utf-8?B?ek1MV0J4QzcwOEwzaUp1b2w3REgySDVqNUFoMmxsVDZjSktLYXpIZUFJL3RY?=
 =?utf-8?B?M1RCc08xYnlqYjRuSTEvTWdqRGJvbG1vczZiNmt6SDFqRjFuN2N5Y0kzSFp1?=
 =?utf-8?B?ZzBSWlhNRXhWRWc0a0FzdjhYTFVJRzBsa2Rndm43R3d2dUovL3l4d2p2bENB?=
 =?utf-8?B?TVFPLzhTQlJIT0JIVGZ6MXV5UjA0cURsbDBFbHEyc2lCcjRheWFVc2Q1VXk5?=
 =?utf-8?B?UjZwMFBmazZwYXlxWTRHSkdYL3ZaQ3FzUjBTd2l0VHpSQTdCMkE4N2VXeWJm?=
 =?utf-8?B?MHEzM0xHVTFmQWJ4eGJoZmRHQXZhSHB4OHVYa1YwanZ0dnV2Mi94T1dRN0VV?=
 =?utf-8?B?OGR0SXBsMXYra1BGbG9wMFB1T1VDNTVsOXE4dFNuSjhCV3UrUE04clAwM08r?=
 =?utf-8?B?T0djNEY0NmhPSjJ6QWRuYUV1elUrYUhQcWFzMG5pMUE5NHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDhPRTIxMytFbktzSys1SXVXWXh0QnVuRGl6Ti9uTUlPK1hQVnJCVFRMVG1S?=
 =?utf-8?B?Q2R5anU1NTA1RlFoNzI5NUtqbytpNHVINWhyY2twYjNIb0tlQjlqQm41R3o4?=
 =?utf-8?B?NGxNMzRmTTBDM1h1U0tUS01abyszajJQK09GMVM4NU9mem1pNEtHbVdxN0JU?=
 =?utf-8?B?cjM4NmpvNzlMMzlSMUtZMHF6UytBNWJ4aytKQVFwZk5UdFB3dlMrZk1nWlBj?=
 =?utf-8?B?NkhoOTJtc2tRWS82dU5wRi9yU2FCODNOK1ZwQThZNU9SM0hhWU1aSGNtbENE?=
 =?utf-8?B?N3RHOW41ZlpTaG9SN1B1OXVvampFVXpmdXgvdGpOODZlMUdtYmUwSUNiVWFr?=
 =?utf-8?B?QSt2ZERTdStzbnVpUk9jdnZPSWYwUTYrSDVLUFpRNDZ5Zmtxd1pOZmxFSFYy?=
 =?utf-8?B?Z2ltd29EeTVUNW9nMnhnL0R1UzBrVkpvSzZlOEhadTJPUUk4QTYvWHhiajZn?=
 =?utf-8?B?b1JKdkRPcHZndUIyWURqN3BOK3lQN2duR213bU5VK2VpUUV5TnpVN0hDOEI2?=
 =?utf-8?B?UWd6RCtOL2pEOGd3M1pVNlpUMXQ5U0g5NzZSNENCWDV3S1dGOFE1Mmg5NUdh?=
 =?utf-8?B?eTRQbDlKTVV0R3NvOUw5d2FjTjV2ZDNpcS9Ba3NoWGppMjZvUVRmN1NxbmFa?=
 =?utf-8?B?V1laMUtOamdlbnhkblZ4bXVuVmhpNDJqS3VyamczZFA4TXg3UGppbFc3M1Ux?=
 =?utf-8?B?WmVjYzVpeEg5bDJXTnUraTdXZlJSSVBrZEFoelpJcEZ1MUI3MTNUQU9scmF0?=
 =?utf-8?B?a2VmZ2E5emNiNDlDUmlqQkh4c0E5aExxN05lMHJ5b0t2M2Iwb0tEd1dkeDJ3?=
 =?utf-8?B?WmZ2aGpWbS9IYis4K3FTZTNwWmxjOEE4ckRmR2lmNG5tQXc4WFFObUFHRWhE?=
 =?utf-8?B?MDVrNHBzSmRyQ3FCc21HQ3h5TmpKbGtJemltQmlUcklFTzVPNFJWRVNOMS9S?=
 =?utf-8?B?aUhjOGZwSTVSR2ZZU1piQmxOemQ1Q2NxKzZjTEkvSHVZRGFYK21pRmU3RFVK?=
 =?utf-8?B?OWpzYVRTc0NuVXkzUVZsaUxsUjNDZ3pnNmhwc1k5TWs4ZG1qSTVUQTIycjFh?=
 =?utf-8?B?M21JNzJiZ2FQTXB3Mk43VmhIendPNUlHSXhmZ2d2VTl6a2dRaklDRjlnNWsy?=
 =?utf-8?B?QUtGVHpoYUNMU2tSUUQrS3VwQVc0MGk4a2toZHE3Mm9oYWxsM2R4VmJhTUlv?=
 =?utf-8?B?ZTd3WXUwOU44dGl1ZzZwOUxxNnFlKzRBbzFVbU4ySStJL1VkbmttVEpOK3Ru?=
 =?utf-8?B?SS9BSFZFZ1FoMUpTL2h3R0lMeEtQMVV1amNqYUlNdWl4V3k3Nm5wOVk3Qllz?=
 =?utf-8?B?NXlHWkJwOEdLZUZiQjljVzM1Nks1amp2dXhFbDJJV2htR1h3Nlg0aVR0ZEtF?=
 =?utf-8?B?aFB3V3dOeTE5NWVVdmRMN2xUZnJ3UVdxZHVBeUhRb09LTFcyZzlvTVgwelVZ?=
 =?utf-8?B?TWIyb0FtcDVJUUJuS1ZKS1lpTEJqQUh2ajg2dGFid01SYTU5OEtDUkdWU0dj?=
 =?utf-8?B?V3FGaFQvYjdhOURwM3lWb0V6RktBWVJwSm1DOUJwTEZqb2tFYXBQd2MzbHB5?=
 =?utf-8?B?dFBGcGk5TDk0QTJBeTlvc2VybktBb1FDY1ozNnVNQ0lBS2RRQnBRTzNGMHFT?=
 =?utf-8?B?b2dzeW1xV29uc1lLaWZsOEZ4RjdkL1Nic3RhR3NkcUxIMVhxZFNiT20ycTB6?=
 =?utf-8?B?YldMQVV5dStOcUhQbUJIQ1ZTVlRjUmN4cWgzREQyYmx3aE5Gb2ZNUFNWcVVj?=
 =?utf-8?B?UlZZMXBDZXZLV1RKb2lOcnVhYytqOE51KzA1OXlhZjRiV2tFWHBFNWw3UkR3?=
 =?utf-8?B?MkFhVnZqWWFSNWx5SWNZdTUvcmE1Skh6L004YnpzL1VwdlZxbVlRZHdLSFlN?=
 =?utf-8?B?MUY2T21qc2JlczVtK2p2cXozNElkSmVWTFRvL0FlNnhDOVBzSUpkNEVoVlFm?=
 =?utf-8?B?T2VkMzlwWDdWSUlpMWVXTlBybnFuQkI0SEpRenBkZSs0UXEzQjYvQ3JtSVlG?=
 =?utf-8?B?aVFsTCtoZ1VVajZpNjFpY2p3SXFXekFSejRMTWNxLy84TXMzUU1uUGg5MmVj?=
 =?utf-8?B?ZngrZ2RqemxVNW5BR0hzZ3NCMnBNNGRsK2ZabmJ2MXpJRDVOTXZ1MFdaeGJM?=
 =?utf-8?B?SEpPZStpV1pGeWtvcmswNGlQc0lUYmhzT1JoSk9lMVFkVkcvWmg4bGZkck56?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7d20be-44c9-463b-39c2-08ddd5def4b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:19:32.3425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoT5sIRXh91ztfPs/VaMD/G1il49mj/WWPqn57TTWkyT8D26jQLgi6YrD77LKL7qoEqLlxVqo20/gSnEWmpVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 18:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19711

On 07.08.25 04:46, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-core/ltp/{ltp-full_20250130.bb => ltp-full_20250530.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20250130.bb => ltp-full_20250530.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20250130.bb b/recipes-core/ltp/ltp-full_20250530.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20250130.bb
> rename to recipes-core/ltp/ltp-full_20250530.bb
> index 40fdccf..553b58d 100644
> --- a/recipes-core/ltp/ltp-full_20250130.bb
> +++ b/recipes-core/ltp/ltp-full_20250530.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "02e4ec326be54c3fd92968229a468c02c665d168a8a673edc38a891f7395ae10"
> +SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

