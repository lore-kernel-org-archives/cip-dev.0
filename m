Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A8CC25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 14:14:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web11.18168.1716473679558403047
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 07:14:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JkcRQYCN;
 spf=pass (domain: siemens.com, ip: 40.107.20.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjRRoWX9YoLuaCMelB84xIedjU2U+AfD/R5ui6wBAATOK/2u09OoYRWrhtjSmjfmkmbsXEpMLrs4lL/s8/EKcF5KQBd341AYkqXyEY17qJxR8pdjZSQnUGYnI5PJZk0Un1NnBSCxTVKFNhN2OivLK2bsCEUHzNGVVxQbel/y32yVikewWgphkjBurQXWtSRspkKUaRO/x6nmSO7ufhhpgWcUMeK5W4bDb31FdbjkEu0vBA31UzX3Q9M1hw2Dt8u4PMAfc3iqIoZLmQnTRimM2LJvGEPBJiywGFiWphr9PJ2sY1b2h0lK8/FCLDJU3r6ll5C8lpG2g+AEkMMNP5MPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMvBa+dRXb5Lp37b7G8ltUiprlC7IhXdOMZ0YtjlmE0=;
 b=ftYBoiMR6saGdzvfkeVrbv5Am4OvWIqBoUBnfPwXi+GoHSx/peiHX/UuARc/3Rno5t7LPKT0UOc5cJw9BVOSFxAOKZ5eX/2dKObRXVZEi4Fu8SfWjxIScCwiKP96STADP+ifil8InNqOXbo86RlxLOAIJyLZXOCKyTq069l1qMKwVj0XLICtb38fAK0chcdkygUu2TaEtLNnZTTA0mYuNWqtiDaA43aNuZxckX5kNVxasil13s9TfHiHajapYK4DMhqBBcmGrPBwEK+YrVyWBee7rA5+BmCB8DxzynlG9k995sGycII/TyBBt3auzZ3+pNrI4C4qoeCZw1mwYbC9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMvBa+dRXb5Lp37b7G8ltUiprlC7IhXdOMZ0YtjlmE0=;
 b=JkcRQYCNwmlCNznzwUk+Nx7hXLj9B/XRFQT8y0hZmlC+IwnYRUK5cLeePALQr4nhIZfJSLOer6U6WVc83eZ39S1V7gR3QLCQSCsJ7SMizqdIfizsvOoOhFnHbUaB9dQKP39N6Me6483IbolB/Mf+Bf7Yqb3bD++eEinG4jtODnqJFUTdhzstBGzdQ9a1mzQrm0NQ7UiO9ECbbUImuXYCM7++cilGebyzl6x0Qmp4z4AXs4tV09/Pj0RYz4k/HiUyIML6FzF78St4eQJCTr6YYKBmXtiHUOy+Yx9HZ0sziQOzoOL2Thbc7w9LNh/KqZsa+wXM0yts2iaWQ3UNbr1BcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8919.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:14:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:14:37 +0000
Message-ID: <828f24c7-6bbd-4a5b-b294-8b3e14e6b912@siemens.com>
Date: Thu, 23 May 2024 16:14:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Add missing mountpoint to
 crypthook
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240523120326.1702505-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240523120326.1702505-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aeaa491-497b-403c-1c4f-08dc7b32ad7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M0p3djk0SW9SVGxDcHBLc09mQyszdEl5dTQ5eVZtejZscE5HV3BuaHFFN1ZF?=
 =?utf-8?B?YXJzQnlCOWtsTXJJNzRMRkVML2wvTUFRczRkdEVUQ0J5TG0yeEkwQmhEUC8x?=
 =?utf-8?B?NG9ZTEFqN2ZoS0ZQalRQbEhKSG5JaDNZOHU4Y1lHOEM1b3UraUVMcGJtQTZ4?=
 =?utf-8?B?U1k3TUtrZHRUeVUwL1pUMFNnWmtDRWZwZ2N3cnU2NjdVK1FmSVBmOVU4TTBZ?=
 =?utf-8?B?VEU4V2FqT3k4Y01wV0ZGWDZFczZHaDdEdU5MNG1Eb0xDU213U0FPRlB0dlB5?=
 =?utf-8?B?VGMrR01ZcHRSckJRN2ZKVDMwYTJxRDYrbjVTMVRPQkhRRjRnQ0dBbU9tYmo0?=
 =?utf-8?B?c2tTcVZvYmtpcUt0YldqVlAvdmpxQjZHVklXVXFrMkR3Yll0OHdmWGk4K0xY?=
 =?utf-8?B?S282WHJQRks4TWZpYkl1VXhMTTF0VWFpM3pEMkVpUVFpUmhEaXZTYWlKZDYv?=
 =?utf-8?B?RVhlSXBDOUt0NUMyU2FQVkREOUYvNDNoeENNK0p0MU1nTWhMbUIxM0Z4eFFQ?=
 =?utf-8?B?a285VEkxZmxKZ2tkZDNBVUJtUFRxQWhHNnVvK255dW1aRUUrTTlkSzhKTFM3?=
 =?utf-8?B?TkNSQ3k2ZjZ4dmo1LzBoL3k2cXN1SmZRMUJuMXljSE5XRzNnY05hcEdPWlFP?=
 =?utf-8?B?MG1yUnpURENRUUFFNHZ5QllFNmdTb3pGcG56ZGdROFRvaFFUbFQ4aHJITjVI?=
 =?utf-8?B?MUs2dS9YTGVDUlB0R1R6OTFCcklmNG9aejZmUHJuU1pPejV0MzY0OG5NWmFH?=
 =?utf-8?B?NGNxa2V6anRnbFo0YXFhaVcwSWxwWlVTMDRTL3dvWUdkYU1pTDJLblAzdDhp?=
 =?utf-8?B?ZGcxS0NkcHhON2VCMjBnbHo5cWFCT3IvSUVhTlg5NGpTUkJEQlk4d08rNng4?=
 =?utf-8?B?R1B5NEhKR1RQV21LZm5CVnQ1N0Y2V3VVekxNWG12SlRVK3IzcXh4bmZIWmdZ?=
 =?utf-8?B?RU5qV3VTTmd4M1c3RndIeERBZ2l6UXFwRXF0cFo2NDNrSXJhc2dVek5rK3Vt?=
 =?utf-8?B?WS9xZ3BybTVHUkJhZndPdUpBQ3c4NUhUd1RCL2gvUjN1dzhzemV6aG5pRnBn?=
 =?utf-8?B?Wmt1WS9sdnI4aXpjVm1jcWR6WWZKMWZNTjFRRHRqOTlSQXUyb3VLemJPaTVJ?=
 =?utf-8?B?SWs0VzI4Z0hGaFhUWThHRGRZejNOSlZvZkg4ZzRlV1hpakhJeC9sbGtZdFgy?=
 =?utf-8?B?TTNVVnpmOXpMMmVqd2laL1lPQWFneDFlakZxTWV3b1lmU1JVbEZiTFlJL284?=
 =?utf-8?B?cTNFQWNjaW5RTm5NRjFndWVtL0ViWHkvUmpTZkF5T0JWRkRoUXc5dWlxOWps?=
 =?utf-8?B?THl0NEFOKzQ3RXR0MFcxZ0FpdnI2Q2lrOHdTeC9aeG93WmhQVzdsekRmSkJo?=
 =?utf-8?B?ZTJaV1F4VGJ3UXdrU2RYMEZDRUhlUHdUMm45Lzc0UjVHMnZWOHBuUGxnN1JC?=
 =?utf-8?B?TTVQUU04SGZVaXVwdEx0NTVzY3ZzQ2dYblVTT2M4V2JJekZHYmhCeTl1OVZJ?=
 =?utf-8?B?MGV2dXpBTktLdmJPWGM5ME5laEN3cXFmMGFjZzJKSnFRWnNha3JleW1adWNv?=
 =?utf-8?B?TVVYdm1rSTFOKzc0QUxwdUp3VDRkUVcvMXN0QUJwaElLaTE5Yk03Ukt5SEhR?=
 =?utf-8?B?aGFLMDdiMU9OQ0FnRWtiYmpWV2tFN0o1aUhsWnowN0wvVWZmM2JwSzhLTnBo?=
 =?utf-8?B?TXFOMWh6aDVPN3FydkIrQU8rRlo0WTJTTlBFa2paMy9ZWjVldkIzUklRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFFyQVlmcUNwbko0WTVoUlJiRzZWR0NZa0JmSTF4YXZ2Z05QV2xMb2w1emVa?=
 =?utf-8?B?Z3NUd000UUdwRzFYMWpnWDJwbWlyeDQwUVR2cnphcnRJZXRYR01HZmUwOXpV?=
 =?utf-8?B?anQvakloRnFhNlQyaTRRWGVENVRVa3JNSzdMWjIzR1M0LzFpcVd6QUw2U0xl?=
 =?utf-8?B?akRoSzhGMVU1NG4vWVRBa2pPRnh3bkJqZWJEb0ZiU1JGYy9qc1pVMDFraHRC?=
 =?utf-8?B?cml2b1FlbWhodjI3YVN0QjhzUEgzK1ZrY2RCV2tBL0hIejM1MXR5VVpyQkdw?=
 =?utf-8?B?UDdDOXZKQUxDODVGclcrMXg4N2x1ak1ETlNNbTVsUHFiNWhRS1c1YUEzRHhE?=
 =?utf-8?B?UmV1UDZoMXZGWWVWdGtEc0k4bjNYU3dGWXNOWWMraXVBNTg2WjN4aFBnc3ph?=
 =?utf-8?B?QXpUQkk3L1lVL3JlQjgyZUdYbC9xd1QwVTFNTktJM1I4ZWVpTVYwL3BEam8w?=
 =?utf-8?B?TWM3SmMxcWo1VUxERWN0WlBZVVExK0xYNUNVbk05VlA5MW9ZQ1lmOWJNcG5C?=
 =?utf-8?B?VnZRRnU4N1JFcmlkcUM1UkdtUHRnYXRDZWFZRHZWQS9DQzNtbzQ1WStmeFU2?=
 =?utf-8?B?dmVSV28rZTh1emVYS2FoN29UWCtkNXQ2YlNoTm5pckFqeVhBTGIyNUZyNDRK?=
 =?utf-8?B?eWlucWlFQ21wTE1rVW4xRkNzaHRLNmFOZG1GY2hVT2lJWkIwUVRXQ3RVWVE1?=
 =?utf-8?B?RUFTNGI3ZjhFTVhUTWtINjVQWmNDUU9oeGR4bkwvOHZEN014SWRYV0VSWVhK?=
 =?utf-8?B?ekdsYk4yalFoNzJZaXFRcGQzaFNxRTJ6S3dzY1dLNDdBTUt4WXMyKytXdHZQ?=
 =?utf-8?B?NS9QdVJwNDBqWWpOUE5yQjkwUVhabnVxUDBHWVVrME1EYjB0Vk1DYU1tbDRv?=
 =?utf-8?B?dHhsSlp4dkt1N29HcllTeE9Ta2V1WFRqdzdZd1M5U0tmb0V6QXJxdEIxV1NH?=
 =?utf-8?B?MlNFZWo0MXNIWkdzNnVscUZxcXkxa1ptT3dZWnB3blZwMHo2UUhiclBCRGl3?=
 =?utf-8?B?bmd0UVJkeEFBYTZhM3dKVEovQ1Q1VUhENnJrMzF6SzVTQ0l2RXJkMlJlRE91?=
 =?utf-8?B?RVZOWXl5Smk2ak1aQ3JxMmtzU3EyNHhvUmJaaWJlRWQxaWxpYUoydjE1MHJ2?=
 =?utf-8?B?d1I5MkFYNHdsSlNieE80ajdrY2lySEdPbzZQcHpwVkk0dVJldG5GRTF3SmxQ?=
 =?utf-8?B?MlUwQi9pbTBYWUduRzdzbFlVbm4wRXd1U1RaUEJKOEd4eEUwbXBHRXNMUUY1?=
 =?utf-8?B?dk5oSnZTcTJtVnVGVGo3MENWdVdERGRWWUxSUXU1TFZLa3FWaG8vRnUzT2or?=
 =?utf-8?B?R3pmU0g3NVQrZCtlaWliTklJZkpCeWo1Sm9QTTZRTCtwSUlkOWJVS1NkSzNZ?=
 =?utf-8?B?L095ZDN1NEVVNzdsOFN0YnZWbENtYVlBb0Z5YmNPN1VRY3I2MERudWd1M21y?=
 =?utf-8?B?TFZZYUlVOGQ3VGFldVFRYk1EVldFTXphOEUwa2JOU3pKOE81L0I5S2pNTjF4?=
 =?utf-8?B?RTl4RHNDVWJtNEJYSWROS1NjdDlSREoyRkNiQlNZVlJDQnNHdkZheVdpU1BO?=
 =?utf-8?B?dlRTdzg5ZnVQdVZZMk5qY1VPdEN2ekhGWVk0dzBCanV2ZndKUkxsYjVNOFBZ?=
 =?utf-8?B?QmV1c04raGhqNU5KT1plR3RqUEZIQTdYMXZTSktyOFRQTjBVOHNDYWIvUkE5?=
 =?utf-8?B?dzdXVjJuRG9vdWFGeDJPK2ZxU25WVzZPTXFpZ0orcHNEQTJoaHJPUFpNNHpN?=
 =?utf-8?B?eDAwdTZyQTlVbnRnUEp5TlM3ZHZhKzF1Z1A0dGtSUFBIRWw5NTd5emo4clpM?=
 =?utf-8?B?WjZvRy8xMXI2MW9JQldIVm5RbTdHZjFyVitQN2lBOHVPeGFzRU9LVGdJeUFX?=
 =?utf-8?B?TkZyczNMcVlNRElBTGV5b0ljc1JuYklML3oraHdzZ3kxSVVNb3hVUmE0d1d2?=
 =?utf-8?B?ZzMwcmV2cHpwdEhaeERaTDRJTzAwejNSdldBc1JPZ1AxSXdJeVdqZ2ovYURt?=
 =?utf-8?B?SnMzeG1GbUpGRXNMblluTGZLSXZ4aC91eUhLWHF5dVRHcUxjdWMvSDJnZXRR?=
 =?utf-8?B?MDBGZ1pvZzRQaXpHYUxMSVZSZWEwZUxvTmZma2g1RGhxUVF4OEowZGhvWVRQ?=
 =?utf-8?B?QkIvb1dYZnI3Y2pZRTFmaUZJQ3IyS0NadFpadE8zVjgzaW1SeHFEYTN2cWhl?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aeaa491-497b-403c-1c4f-08dc7b32ad7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:14:36.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5HMZkAWUM5lRp5ZQWO5TvDE1lk/rSpl82v6XM1RUlLLxm64Z+6uwaFZINhruqlWAK+GGUivU0HJJWa7xioO7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8919
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 14:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15937

On 23.05.24 14:03, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The crypthook requires `/usr/bin/mountpoint` to avoid the error:
> 
>  "mountpoint: not found"
> 
>  This was not found because other hooks already add the binary to
>  the initramfs.
> 
> Reported-by: Wang, John <johnxw@amazon.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.hook     | 1 +
>  .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> index 0644eab..4e62ef7 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
> @@ -73,6 +73,7 @@ copy_exec /usr/bin/pwmake || hook_error "Unable to copy /usr/bin/pwmake"
>  copy_exec /usr/bin/file || hook_error "Unable to copy /usr/bin/file "
>  copy_exec /usr/lib/*/libgcc_s.so.1 || hook_error "Unable to copy /usr/lib/*/libgcc_s.so.1 "
>  copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
> +copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
>  
>  if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>      copy_exec /usr/sbin/cryptsetup-reencrypt
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index 19e0fe4..be8c117 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -53,6 +53,7 @@ copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrr
>  copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
>  copy_exec /usr/bin/basename || hook_error "Unable to copy /usr/bin/basename"
>  copy_exec /usr/bin/uuidparse || hook_error "Unable to copy /usr/bin/uuidparse"
> +copy_exec /usr/bin/mountpoint || hook_error "Unable to copy /usr/bin/mountpoint"
>  
>  copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
>  if [ -x /usr/sbin/cryptsetup-reencrypt ]; then

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


