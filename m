Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A663C3ABA9
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 07:23:07 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.66])
 by mx.groups.io with SMTP id smtpd.web10.13919.1746170581237117536
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 00:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iwYPAlIM;
 spf=pass (domain: siemens.com, ip: 52.101.67.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW6g9xCe3wFHujg4m35x6iShe2iEG0UpAkdCXyUKzNud+sTLuZWhn8S/CCEwVvd6llu5d/mwaw1liM663wjcjmWpaj1yUf9jwLzoSE7Ma1nQiZCMsE06uxODyN0imf8sKoaJJD3eLgCKlhlKfETLG8h6qhGXbMqtlbjF9+fmuGvtEUaIiR8mChNtP5HBhXx2UcdwJlyDN2tJ8gJVEfYLzK7+11bH5bB4v7fCP9wumFFw9Gj35CGntHKwPoocl20Xxb2hpWM+kMcwWRClXhXdyKjF02RQNpwVge+bLAqnAZbhDbEOLgvwraCEiESpC/fqeXvxPHwGnXJ8lWYmUP74fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iE3//5h8Gczz0CcQvuop/HPJSA7TDmnY97xwYHPNJk=;
 b=FOom5xgYIA/nMYcQ+N0K3m/14CCA9GA4ho4lTWcoy96/IElORIiJjJd1ccgqQ2WnFXNJTYl3JrY4ravQqBi/8ALBg2dgXErK6POH4oF2WkEjXz513twF/TS0p9bOUgXe+Wo1r5hkmclJrJxbj46TuSg/8uqbPrkxqqr37CNqDFSdqmUZm4Izg8il/J2BhLsWjtWYQaKHJZWlSYyH8zomk+n9+XMgdz/HBNtnZmpvoTbE7IMcFCp4wdCi6r7Mb0RLrqBgjtec0lagqDcBUx9dhpcGdNhU2p7pRo7DCSXCLTF78gADIpx3ZkGUU8DGmI5JoPq826/FxG/9N1V3wJrXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iE3//5h8Gczz0CcQvuop/HPJSA7TDmnY97xwYHPNJk=;
 b=iwYPAlIMCamHPCrGctihB7u80gqwahoS8oBpMwAtcJyOYvUEz4Yty2Tyc6xSCQfDsa/Xp38u0wumSQ9fls5JRlm+GVkzCPZ39vCqMtUI8wwJb1L51VKNfJyppV2HK7xaey6QuqdnildwSb7kOmhZc1+v1DL87FdxYK4HJD2BgJyFDmiRDcXPtUBvHF3glGpWJJWsQOoojfA2VIJbYvKvr8zhP/8aTkWyk4pbg27B52i9nAjG+RhljV+X61ZO5LMnwMo5/8xoG6odEbgUpNGIhg0gvMXmDMStdKtfzLq427jtml27MpAVeJyjrFjslkkU8inUrFK89TDeIIoNWpo2Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 07:22:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 07:22:57 +0000
Message-ID: <29c1beeb-3f3e-4bb2-89b5-a84d2b0b5043@siemens.com>
Date: Fri, 2 May 2025 09:22:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1] README.security-testing.md: Remove the
 credentials from console & document them
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250502052035.1959453-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: d6579dcc-008f-47eb-a0a4-08dd894a2951
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEtaTENIN1JZSUJabFpqQVcrczQyMlJoQlY5UW1XRXhkK1UrVlB3U3NZaUxC?=
 =?utf-8?B?UVhaTUgwTXE4TzhaU1pubkN1VlZtZGFVZ2h3M3E2aEJjNlcxSkY2cTN0ZUtL?=
 =?utf-8?B?dXJ4UDlSVnBtbVoxQ3p5NjVJLzh3M3MrejNQRzgwRVZEbzl5bVlacGJDbEFs?=
 =?utf-8?B?NWdLL3ZSMGxEOXF1MDBKRndKU2gvQXFCanFOL0JEZnVma0dueWp3NGh6K2VE?=
 =?utf-8?B?dVNYRHFEOUNWam1hZS9QSlI1c1ltd09hU1pUdy9La21FUWE4SkVnNkJYUitP?=
 =?utf-8?B?dGFETVF3Zm9aVm5mbkI2QytWTXVHVy9pWlJhV015R2QrWmVLcVhudjN3Ylhj?=
 =?utf-8?B?OUZCSk1Eems4ZFdoUVJraWk4NWxxMUw4Vm42L2F3MG9LRUVaREFtR1IrZStl?=
 =?utf-8?B?VGZKdnZ1a0lZRVhaODdnbXZuRGhwWk85ZTNxdHp4Q2dxV1YwZTdwR1pIZWNV?=
 =?utf-8?B?dk1ZMGZ1eXdlQXFnTVV0UkdlK0IwSTRLSXpCaXZqZmdURVdCb1N2ck5WVGZp?=
 =?utf-8?B?Tm5vZ1YzczVQUDkwWm5mUXNKYVdzUHBTYU5NNFlxYUx1M2tNZHBGSjdpLzR5?=
 =?utf-8?B?VE1UMVlsTTlReHBXUFZFczNkZFVtNUJFcVJMSXlsSTZVb2UyVUhoV3pqQ0Nr?=
 =?utf-8?B?VnhuRlQxSFc4dVo3L3VUYi9wbmNRalhib2JxVWhDOFM2MVNzK25WdDJjNnFh?=
 =?utf-8?B?bWRuNGt4TFQ1VHpGNmRKMW5obGF1clQyRDhsSmUvRVZ6ZXBZT1Q4ZnlwQ1py?=
 =?utf-8?B?VWhBUUNjQUJlOWx5b3NmdUxwa1h5TDQxbDIzY3ZpWFpyRXQyT3ZpL1FvUWNq?=
 =?utf-8?B?Um92bEloVHgreno3d3hucHQwdFR2RU9DNVVqTzMramcxb2hYNzAzMUVLNzdU?=
 =?utf-8?B?LzN0QzMraDlnY2xacW55Sy91a04reGlWaE5Ua1BGOUE0OXNKTHVnSUdwOHV1?=
 =?utf-8?B?dHRqTHNWQ245TG5RSnpqU2dJZmxMVG8xQlFHejZ2UkFhOXVRZTVkQlJmUk9I?=
 =?utf-8?B?Tkw3M21jR0wrVmpVUzNHbHBDVFV1V3dUeENyTGpRdmpMekZsdGRhcXhWZ2JV?=
 =?utf-8?B?UDhXc1dIZzl6U1JlMFlrY1FkZXlmbmNHY2Y5RzBpcmVISXAxOGw1eitrd2xD?=
 =?utf-8?B?anVlK1NYdnhnVGgrNHlrY2NkRVNDSzZPUlpSVFRIdEp1ck5BNUl5dGZHdTY0?=
 =?utf-8?B?ZDhNcFk0RDE1V1QxaGprYllUM1NJcEJTWlYzV2d3aVlDMUNyU3VZL3BsOU5l?=
 =?utf-8?B?bkhkMUZZVWJBaGxkMUJzajNxaTVHUDRzbVlqemRocmRmWFhzanlXeGpHNERQ?=
 =?utf-8?B?SjFmMjhPUENZQ3J2Nk5DK08yTlVpd0tlaTdxZTk0blNjSS8zbTZld0tyYTJY?=
 =?utf-8?B?U2RBeGx1U29EeTQyL2ZwSm40dEFFVlZ5T1J0VFBFQTFlNHYzeWh4TzJOT1Ry?=
 =?utf-8?B?T01sRFZydVZTZEgrTUppT3h4WjJyL2p2TDFzMVFqV1hDYTQxUGNibTBlS3l3?=
 =?utf-8?B?aFZHT1NQYitGWnVDaDVOU05FV0pXcTVwMHR3UVRwTlBZSUxzNXZjaTFiUGlZ?=
 =?utf-8?B?K2ZLVzNXQ2g4aGEzdFEzWUVpZFlBQi9TZzFuREkyb0o2WCtmb3RPdFRMbkNz?=
 =?utf-8?B?d2xaay9sSkhxOVhheHFmazlWaWFEakNSTHQwVkIzZ1FKSjE5dnNBNm1Zak9J?=
 =?utf-8?B?VDJycms2SjN6RnZNQWZ2Vnk5UFVYYk5Nc3dWZVprdDMwTUNiSzdVS1NQM3kx?=
 =?utf-8?B?Nkg3bVM0b1daWVVEVW5MeDVySU9HcVdWUUlMVUxvSnRjMGdGNCtBNWZmMzZh?=
 =?utf-8?B?U3E0S1YwaVVnYzE0SjRhNHVsN1I0Sm10by9xczkvc3BMNG5rTjhaZzU3OVNk?=
 =?utf-8?B?V0dXZ1lCYmhmYnNQY1RHcXM4S3BYY255a2QvZzFOampEM0ZiTUJUdHcxdDg5?=
 =?utf-8?Q?LYHTVevXHfs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDh0N3VjUGQ2WUVoTnNUSWpEbExhOTFFTnFiNksvckozdFlrVERjdExiVTdy?=
 =?utf-8?B?eG9sM2ZtOVBBdllRdGZFU3hmdGozdmxVaHpHTElpSjBhOGRObkxSU0E1cTlZ?=
 =?utf-8?B?cHpjbnJFazczKzhhYlowNnF2V2REek1TU0VvZGpYSXp0U0kzNDBQR3pLWHJi?=
 =?utf-8?B?ZmNYVGRuMkpydkJxNGdObHc3aWczeVF4N0xzUDJMY0c1RkQ0QTV4TUdNb2NU?=
 =?utf-8?B?VTlUOVFYaTg1MzNwTmRZN0loM1ltamJtbjFkbG1BMDJHVmNCdmxrdFU1NjY3?=
 =?utf-8?B?VENuRktLYzUyVkJVQSt4L3hSV2NXak9ob0c5c0RhSFNwcWRpbC84a3BXNVlI?=
 =?utf-8?B?SUdIdzg4aklGM2ZpOFNJVCtYbDA4SFkvMkxrN0ovOWJOMzNPUFVxL3FjMUVw?=
 =?utf-8?B?M0hkU2xmWm43VDJMZWZ5dTV2blVtQ2EvcEp3cGV3ejlmMGJiSFhvRGRKZUlq?=
 =?utf-8?B?MmJDa2hzWjZnMTlGRHlwSzk0ZS9ZcGxtdVhNcTliN1E0QlhKYTkzS09YemJx?=
 =?utf-8?B?b2xmVDAzMi9jUlo2SzNCVUtEeGZZRXJhUmlmZTZySENHdnk5akYxZ3doOVNC?=
 =?utf-8?B?b0h0czcrSU5GdzNzUCtnRnBPdS96OEJ0UlV2UkNqVENuak5lNzlpV3d1dHRL?=
 =?utf-8?B?TFhqc0QxSnozRkNmTGt5ckVKWG9jU0dEckdjSkhxMVk1bkFSRTIvWnNiMlZ1?=
 =?utf-8?B?MXpzek00eGxjTTR0QzNmUGVHYm9xU09FeWZrVFdLNmFqbjVGL2JRL1RDTHVj?=
 =?utf-8?B?NTRHWGhEd0dpSkdHbmtPejhlZ2dWRHJqWE5LUzFRM0U1WVg3NXgrRHVMNkJy?=
 =?utf-8?B?eFJWTWhkVWlIaExtSzhTcjFrTEd2eEg2VmlOMzFCS3VhRWxyRlMyb3d1Vyta?=
 =?utf-8?B?b014ZlRYdE5aQlhIYjdBczJHMHVBZVFGQkdoT3Znai9PNnVRK29xUnEyTmZy?=
 =?utf-8?B?d3A0bnNmVzFmdHZLb1BrN1dwcG54dXBxalFJeWszeGFtdU1ieEZUTlh1Nmpq?=
 =?utf-8?B?aDlCYlRnTURtSlFkZVR0RkxGZ3A3eDVROTlSUE5PMzlRemlLK25DTUxyZ3Rh?=
 =?utf-8?B?bEdKN0ViOWF5TDMwQkRLMmpsYSswNFUrbkVzeHhJUlVTNDJXcmN2RFVrUGVy?=
 =?utf-8?B?b1NFOTFobE1KUSs3Kzd3SUFMcnZSeHRmVTJacCtvMDZBUzFvcncwRFl6c0Vk?=
 =?utf-8?B?SGNMM3BlbjhqUEJBZHdvVEdGQkluL0ZlbzMxY2tLMGl2RnNtOGR5dFdlbjVq?=
 =?utf-8?B?bGNUcVQrb09mdXJYZmY1MnpEN3E1SkEzUUlPSmlZT1cwaEsvVlRNMHJ0dUxJ?=
 =?utf-8?B?QkJza3Rid3EvQjgxa21uaEFzTGdpSXJXME4veU5ZSlhReFllQUxUNjFIdUtT?=
 =?utf-8?B?RVEwQUJCNDZzdFU5VlFjSllLSWsvU0xVN3BXNXhzMnU0VXkxOGdTbXY0NmVm?=
 =?utf-8?B?MjFqSmZWVDlMQytuU2JJcDUrRzZVNnZzRnRaWEIwd2NKZG9pbTBEa2JzblRN?=
 =?utf-8?B?THdjR3l5SzJKc3krR0pYRW03cmxOcU9lMTBJL2xMVFNkcmJBNFFRYnFaZVFF?=
 =?utf-8?B?M0d6SVRoM3dTa3c0ampjQXlmbEtNNCsyN0hwZldyeGNrd01UeFo0bFg2Slhm?=
 =?utf-8?B?Ny9FblgvVm9vRkI1WVFVMG1sK1lyUjRTK0tzUldwU3ByLzFIWXZPZDlZYWRs?=
 =?utf-8?B?Nmt4ekdEZ2h1TmJtZ1M2NmxGTi9IRTBoSHpwY3l3eWtvNCs3bkFiZVRJWVg1?=
 =?utf-8?B?NHFiTWtXYVBXVWJVUGIwRTU5ZEZpTVZXNmlmVUtxd1A5S0RCQVowQUo0aVhE?=
 =?utf-8?B?YmR6Vk9HMkxmci9XQUZ1TmtGODY0L1Vlc3NFTUZRanR2U3VKTm44Z1UrRVhP?=
 =?utf-8?B?ei92OGNlT3ViY3RvLzFDNG1KbzQ5UW4vSDZVcHVjdEhWOFRMWHRjc1M3SkdJ?=
 =?utf-8?B?Z1lWdk0xeURpUjFWTU5lMkIwci9QRU5lK05Ic2IzMDNlQTl1Rk9xQm1DMCtv?=
 =?utf-8?B?a1VQbEFiNWZEUmw1UmZyVXpISDVQdlJENnVOOGlVQ1Nzc2dJd0hoZk94N2xP?=
 =?utf-8?B?SW5MRVRBT1dDZWY4MytyRzFxZjVFQ0Z0cEJWZThvaWs3TEMxUmhjKy9waE1y?=
 =?utf-8?Q?/wfqWiWUnWyeWamVwdyix3RcF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6579dcc-008f-47eb-a0a4-08dd894a2951
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:22:57.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS6D1m/mocgFVqfoPUe5Sj6+sL9GlxeWfq8Yx5adrAte+LQo8UizfksH7TAEOhok8FeW1T8PJ9CAUiK/DXeQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 07:23:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18748

On 02.05.25 07:20, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> The IEC 62443-4-2 certification body insists on removing the login credentials
> from console prior login prompt and document them as part of user manual.
> 

We are qualifying an image "as if" it were a production image, mentally
subtracting anything that enables automated or manual tests - including
hard-coded credentials. Let's split those bits technically and document
that. And avoid suggesting that everything is fine if just the prompt is
no longer showing a password - the well-known password itself is the
problem.

> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  doc/README.security-testing.md                      | 7 +++++++
>  recipes-core/security-customizations/files/postinst | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
> index 213fc82..9696892 100644
> --- a/doc/README.security-testing.md
> +++ b/doc/README.security-testing.md
> @@ -25,6 +25,13 @@ Save & Build
>  ```
>  host$ ./start-qemu.sh x86
>  ```
> +# Login using the following credentials
> +```
> +username: root
> +password: CIPsecurity@123
> +```
> +IEC 62443-4-2 certification body expects to remove the credentials from being displayed on the console prior login stage.

This sentence does not belong here.

> +(Warning) CIP users are strongly recommended not to use CIP default credentials for production images.

No, this MUST never be shipped in production, irrespective of any formal
certificates. This here is a TEST image, not a PRODUCTION image.

>  
>  # Copy security tests in to the Linux image
>  - Clone the cip-security-tests from following URL
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index daade83..15be659 100755
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -6,7 +6,7 @@
>  
>  set -e
>  
> -echo "CIP Core Security Image (login: root/CIPsecurity@123)" > /etc/issue
> +echo "CIP Core Security Image" > /etc/issue
>  
>  # CR1.7: Strength of password-based authentication
>  # Pam configuration to  enforce password strength

Let's argue like that: Anything that must be kept for a production image
must not be contaminated by setting that are just for testing purposes.
In that light, having our test password inside a customization package
that could be reuse for a real image is a bad thing.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

