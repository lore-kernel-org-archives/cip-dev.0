Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097CAC021A2
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 07:01:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web10.45428.1739170859755498848
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 23:01:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TmUAjBX2;
 spf=pass (domain: siemens.com, ip: 40.107.22.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZTTr5+EeOufzIoTfZWYG4cpkulfGBiTvO0/1+tsNaIkXNnTWkZGUk8iE1VmYspQbNR7Ia4NW8GrAXatGAH/68jyJN4TGRqPK7UNZyAm9G8JhTQ3vW0sbHKVPb6lDkrrEICM26t2KPmtB6Yq4TvR4fj1dhZt/F3aTtwc6xGnAGDXB2vLWhw9QCWPDjGQmDKPHFSlU/1NYPjyhJ4PrxYhFf6rZ0laIgduWK3JgoapWdTTVEC84QXW8kSwBSuDG3pOnzQ+3wX3aZSCoq/07KQQfV4CO9lCc94u+MRRXp0+v0ugVQvGl6evTxdjwr9FNi2KjPTxo/eIhoxZUzn+q4gWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg2lljXhF9qRjdhw4pGQ6nIFRhb0RKg+iT7ajncq8Ag=;
 b=jClEek5urkLfV2Z2goLrVKdPF2OZi2l/mGPinC6xnTrzqyyRBSkLdKgZg1pd5gWx55SXAZdRXCQr+vmGJJieMa74gnJ8pLlbpWcNAWToXcrQ8s1ROeARIzyZ1DXPKOGBtL69ZVjccRJHwQk73eNLnxZ3vNj7Nk10X5ptjMEO+HYPz6Pf1jXqO2KZut8vlbEraNWfFdaAJ1EP13poEJTnzy9/LK3tpO/njhVjFKAO7FyTO5WxjDRKCS8j+Ahc5RQIrDsqIhyTrEOICMV7z2L7djVM+HpaqwvXaR1d6HtcexxynK3oijj0gnnmwge3cBWjHInhHSIEBtd/sanEQNKVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg2lljXhF9qRjdhw4pGQ6nIFRhb0RKg+iT7ajncq8Ag=;
 b=TmUAjBX2O4glXWohNnqveoCuRDnFPRbs575kdOETWs6G78ylw+VHMYcO+PHi+D0WXyvqPYrw1107MPwFKwSf/H6dltARCsV94LwfeuAq1wCQmgeFRnMRDDJrUyvU3JowSokHObRlfyVt1riMa1wI4tGGpd7CkU0cbam/z2p3qYsIfZFcJs7m1g7V9IE8UjkWiSHg/NWqF3BcCnKwHto1lrvWIY0UOP4Pww1IwXgCI/49WB73O3GyMhlt1uQRB9hJ2JanzfseRvrvHSsvsF5aeuHMZ7ZHnCd+liauUIe+PppaT5ttFCanQOIcD1fC1rMEQe6uDSD0AEgpBqKJlpyHhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.7; Mon, 10 Feb
 2025 07:00:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 07:00:55 +0000
Message-ID: <9be57472-a1e8-4142-a61a-32e6e7717c62@siemens.com>
Date: Mon, 10 Feb 2025 08:00:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1 0/5] Automate CIP Core testing on M-COM x86 in
 LAVA
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 576610f0-2ed6-47e4-c138-08dd49a0aa25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RkRBaDYxYWZCQVVQYWJEVVlYRTNIa3E2QkdkRTRZMXN4dGtVSkVuSW9WanVz?=
 =?utf-8?B?UDhwbDVHcVlOdmsxdkFlWWc5bzhMVzJ1M0FDbXprWkZKUjZpSHdYOFEvTmFt?=
 =?utf-8?B?Y1JDVGlYdm5BTVYwVDBtSE9hMUtsM251dmpaSFcrRWR6R1lGWC81QS81SS9D?=
 =?utf-8?B?bFEzdUVuTFo3c1ZCN0J5dW85aHJFV1hiQkpWVlp6NXlyTnZkQ0NXZkNzeXhu?=
 =?utf-8?B?QTMzV1lPUG15SFc0d09wNjhqbDJPMmtDbU1wN3dZcUlGWkRvbXAwZk9sSnJr?=
 =?utf-8?B?UStjYUpiM0xGR0ZJdDlUUy9SMjh0MGFZblVDTUJMZWJRU1lESTJBWnNDWVFQ?=
 =?utf-8?B?K3VFb1dXNCtxTWNGdnNsa3BZRWFIQlRaOVcyeVNKenFRR2VKZVNpMmxXQzZ6?=
 =?utf-8?B?TFpUYy9ITENKN2RYaGJZV042azdKQktHTjFnb21rSmV5SVUrRnZBMDIyTFpB?=
 =?utf-8?B?SDhCTWYxWVRabU9sNSs2R2xmOFY3eW94WHRFKzNlYlFiOU01NmZwbVhoSmVC?=
 =?utf-8?B?czhkTW1vOC9ZY0VMVXp6TXNzbC9hcmNDRG1md2dSd0wxdEtmbWE0VUZFN2h1?=
 =?utf-8?B?aWNGdnZrd24rRlNYTE1TaytSczZVdENwM0lnQk9TRDYzeTBPYTllR0tzQWRm?=
 =?utf-8?B?SHpkeEQ2QVBneWJHdmtwMTM2dFBVUEM1Z0gvNHA3Y2VTcmFSTmJNNEdFUmpX?=
 =?utf-8?B?VVJlUmV4OEhDOWxKdkttZWhIRnFOa3NoOW9tL1ZvczU1a1doSDEvWFJmRjkz?=
 =?utf-8?B?MGk4NW1HUHdSYVNSdG16V3hSbFZ4a1djTy9INk9BS1JibGdabEJiVTB1SU9M?=
 =?utf-8?B?N2JUQ0JzODJ3TVRyYkRrY0hkbkdETEZYL1lrRlptVWtyYk5PbExOY0hTUk9o?=
 =?utf-8?B?WjdLd2lJVjdVWVRUdjlXOXpuczJmd1FKdnc1Z0NUOWlpdDhKY3lpMEFMTzE2?=
 =?utf-8?B?UUEzY3hONzNYQVRpZmFEcG4wZWQrNWdMQnkzUGZWb3JwVkQxbVNUTlhCZVZY?=
 =?utf-8?B?TGovYmJvUkt5ckhWdkRlV1hQZjhaMndTSGhQM1ZCNnpZTE9nQ2E0bGV4dXUw?=
 =?utf-8?B?OVoyVmR4c0pOdVNsL3NoUURRUm1vdzRwYVNDTjZaam83blkwNEViUk5vcGRL?=
 =?utf-8?B?cXNqOTA4SmV2Mm95MExjb2pkRzl6Qlk2WkFPYVpWbVF5blh2cEFPanMyeldZ?=
 =?utf-8?B?YUk3MWpVb1RrcDJTMVlHSVlkSHFQR3Rpdms1MEtOY2phY2hsaXA3Nld3SzBi?=
 =?utf-8?B?OW9KdGx4R1IxZ3VwOGFqcVphZEpwcWpaNjFEdTBSS2dqYm96Wm8wYXNyYnJa?=
 =?utf-8?B?Q0hNckpCeVI1SXJpYnpUbnFnYUw3d0I5NEVXVStBU0lnSG5raEtZcUJacTR2?=
 =?utf-8?B?cTdJVlQ0UkE2NDIyTThjVFJmRStLT3dMTldkVzNpekthSGZVOHFaOTF0NGJi?=
 =?utf-8?B?RS9ub3lVRFppOUxDd0R5aEpjU01QcVBOQ1ZvTnB6alJzSHU5bzNYYWFDV1VB?=
 =?utf-8?B?WUJVYlBlRzMwcEdMYkJMbjlHdXh1dzlGL0xyWURZeitsNk5WZnhheDdTY2ph?=
 =?utf-8?B?VGxMWEVKMjBSUkxQdDNMcHBYQkNYS3dYSGt1WUw2NGp2R2NoYXVFbERObW1k?=
 =?utf-8?B?Ly94OTNRODNIcEs3QnNkTlJ0WHFUK0wxU3czblhCazIrVGJxcFRYNldNOE1i?=
 =?utf-8?B?dWNmVjRjbTc2b2F6WHBmd3prM241ZjlPS2JFdmRlbEpmZVdmUjJLTmtrUHNT?=
 =?utf-8?B?NDBSdWxGa1NvY1AyREIxZ3huTk5GVUt6VUZaRGxYaUtYS1BRYnpPOTBqcmJr?=
 =?utf-8?B?bjBkakxtMzFYb3BiZUY3MGR4SCtZMjZrcjBldDNDd2pTWjNyVE1rekJQSkto?=
 =?utf-8?Q?MO3Wos2HzHxcb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Lys0OWxXQ0JPYmtnblBBdm5pb0lRcUhJbzU0a21aMHR6MFVMOUdpOWNnR2F1?=
 =?utf-8?B?K2R0VnFQYWM5OFFzWDNnaWJwSEM2UVB0ZWJkdU9NMmhaMnZ6eEdtZEgyWnp4?=
 =?utf-8?B?WVh1emN1UmNHMWEzS2hXSUFERTFTS1FmZENxLzh5RlFYaU9TRUhlYlVhWkhp?=
 =?utf-8?B?SVg1RDdZK0Q4ZmprM0NuSDZOa2Nkdy9ncTQ3WGFsNEh2dDlmaHhHUXQxU0Yz?=
 =?utf-8?B?d0syVzZmYXBJQ1FlNEk2YVB5b1VTQzJLeWdqRGMwU0o2UnZKY242Z0ltVUVW?=
 =?utf-8?B?TlovazZVekNwV2NyeFVKQ3lBeTVYam9GNkhoeDdHcmNpTUZ1K3doRnZlT3lB?=
 =?utf-8?B?SThGVU5oZ0Y4Z0hzcndBVVh5UVhXT0FIUFJUSlpvK29sNmxEL3JBMjdPK1Rw?=
 =?utf-8?B?WkdjelJrcGVBRzZvNHpmbU5vdDd5NklXbmkyaXp4R3JvZjVFM0QxUGh5MkFa?=
 =?utf-8?B?SnNNRWorMzdiUUNhZCtrMXRPbW5keUJpcFQydk1JRXlZYkNiWFNPNmxhYVYw?=
 =?utf-8?B?UW5LN0lnSTFCdkRoSFUxTVJkWXFmZ1JqeWUrcFhmeDdDci96S2Y0ck4ycFMr?=
 =?utf-8?B?SVp5QjZoZGN2aEJuYkErU1lZcDA4OEt0NW85dUF5SE5nd3pxS1QxK21CS3Mw?=
 =?utf-8?B?elExOGU0V2Z2clBTY1VCY1paN0x2QVZDNWVXY2ZoTi9icXd1S0o5clpFWkRH?=
 =?utf-8?B?SHpLYVc2U3dBcE1nZmozbzlWcmhiRk82eVJkNzNDb2NiK0lsNXFmOTV5RVo3?=
 =?utf-8?B?R01OUVUyK05adGdIRDFRS3gyUlU5amhaV3l4RldjUlgwL3kyTlhITVJhVCtx?=
 =?utf-8?B?b0g1bVVUL25laGR6SmNOazUrSUJiT0JVQnRIeGMxbmp2QTRhUG9HaUllMWhp?=
 =?utf-8?B?a1BwQ2FuTk1uMWhsbS85cFJLUW9SSU9GOC96djZZRnRTanF6WHNscGVqZEJS?=
 =?utf-8?B?cWl2MGg0TWw2bUxGdGdPQ0xNUWlUajMvbHZoMVRoU1IxWWFGOWJuNDIydXpP?=
 =?utf-8?B?a3NaaExBeE1tU2t2Q1l2dkE2M3RET3Z3azZKRWl3M205K0dQdFZ1anNNVlFj?=
 =?utf-8?B?dlIzdjc5N0x5VDVuLzl6WUV6YThvQWx2Y2JGdWZqNE5FZFhIc0FKVjVxY1hw?=
 =?utf-8?B?Vk5nSDRFSUNKbjlSSHEyK1ZId2dTMmR3ZUtjZDBpTnlETDcwU25vV2JTdE9m?=
 =?utf-8?B?SXM0T0pkSVpQTnJiczlvRlFOL213QkduN1VBbTg5dWNDbVhTWVM4TlNiOUZN?=
 =?utf-8?B?MWRtYms1ZHdtcEU5bDlsZThFd0NTUENlcWlVazBkdlFZeHNVZlpWV2UyWHpi?=
 =?utf-8?B?MlJTYXhDR1BudjlDdXdBSEJja00xdEwxcGVFMVVqSEJIV3Zsb0k0N0dJOGxI?=
 =?utf-8?B?UlJ3M01DYkgxc0h2QzJEY0RLZVdnVmZEMFZuQUk3RnlOUEplOG1PWi9ZMEdk?=
 =?utf-8?B?THdxRFRZYnZFWUJKRWR6THRVa3hVeTBWTUltQm5sdXV1dXRzQ0oxMmVXeXls?=
 =?utf-8?B?V2w5WWxDZm5RMVVYcXR5QzFkK2cvTmEzUG1hSVZnN050N0RHQ3ovVlVSaDV2?=
 =?utf-8?B?SHhDRi9hcVBBOE1ra0JENDFKUFNwZEhkUG0xWngrVW1rZDZpUVBDcjR1dU5Q?=
 =?utf-8?B?RkFLamduNXRKcGNuSE95cHgraURLVytVWGpMS3Z3VU1XdHM0dWRrV3Zya1Nz?=
 =?utf-8?B?bXRvMW9BYy9icGFRUTFUNGhKUHRzNHNyYlE2SjdoYXA4MDQ1Q3B1NHZmUUw3?=
 =?utf-8?B?dHRlQVhjUVIweVRKZzJCZ3c3S3F3bU9PQlJCbW5YRFJWTC9BeFNFSDRabXpI?=
 =?utf-8?B?bkJ0cHdYM1VpNHl2bnhBb2FzTHYyV2c2cW11d1dMSHpwcjl4a3Q5WTV5OUpS?=
 =?utf-8?B?WHppVXQ3RUswNlZKb2psVW1nWk9GT1crS25qQ24rcHVWUFFsWWlKampiQXBo?=
 =?utf-8?B?OTJxeTMxWFprc0ZtSlBVNWtRQ29BWEIzMkxwZExYM2Q1aGhPd3N3U2tzOXpq?=
 =?utf-8?B?ZlF0ekg0aCtFYzNyZy9CTjdwT1piYXk5RHJYT1I1cFJuZUp2MWRWd29uRkVk?=
 =?utf-8?B?akNHdWZUTWVFS0dCYWtjTzJDc2F5N2NSNnJQdndmVXRrZFNsWmdOa3hkZThm?=
 =?utf-8?Q?2j7B0d7nq39CAguEM0GSsRPP9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576610f0-2ed6-47e4-c138-08dd49a0aa25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:00:55.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQmoFA7RpEf8Mzn5gfRXGyuNISldhLR8eAOnDpe7c4PlEgWy8AAT8gNe10g3yF+R9g0UJNALstDSv3fRYoCMpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 07:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17797

On 07.02.25 16:04, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches add template files and functionalities required to generate
> jobs to test IEC layer, swupdate and secure boot features on M-COM x86 in LAVA
> environment.
> 
> sai ashrith sathujoda (5):
>   swupdate_template.yml: Give different names to test actions
>   tests/templates: Add template files required to generate M-COM job
>     defintions
>   submit_lava.sh: Include functionality to prepare M-COM job defintions
>   .gitlab-ci.yml: Enable building v2 x86-uefi target to deploy its
>     swupdate artifact
>   .gitlab-ci.yml: Add test targets for M-COM x86
> 
>  .gitlab-ci.yml                                | 25 +++++++++
>  scripts/submit_lava.sh                        | 38 +++++++++++++-
>  tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
>  .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
>  tests/templates/swupdate_template.yml         |  3 +-
>  5 files changed, 133 insertions(+), 3 deletions(-)
>  create mode 100644 tests/templates/M-COM-x86.yml
>  create mode 100644 tests/templates/swupdate-test-action-M-COM.yml
> 

Is our lab now ready to run the tests? Or will the pipeline become red
when I apply this? Just asking as I lost a bit track where we are standing.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

