Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B3C3DA59
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 11:01:27 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.58])
 by mx.groups.io with SMTP id smtpd.web11.35346.1721041276988215929
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 04:01:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pazaHyaj;
 spf=pass (domain: siemens.com, ip: 40.107.20.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ht19U/7j9NYxhBUOXTI542z/UiW8+okA5b7TuKm1chvdKiw3mG4zMGp0afOzfOFrL2xApmPwpq1ivf+bAQerxtvv2za20ROZMxAxcn4e1eLjL1sj7pzy3JtzNvImsY1ASYbIVNOfv4plCyyjrk8Io8cgSWR5G0n3GS+a5IGpWXnf0ju5PcvwcFvw81ZxtPcMaSDLUrWilHzhJkPBZ3dn0sOtCnAHU0Ej5/3howWrgWdjtGV7EEiYriofNiLyVggAhPMXHPf3GM/pvLfKecV84bsQPCCId6i2GEePKa4+gHJ9CSzhFNWFLucB0t+1gNYa6Epns1EC2cYPBEAng5XzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fax/0xtwCBHPmPzItAoOciELKvaI+ZtAQVuE/1ePIag=;
 b=ITTZt9YlLjACHpX6ETTeJpXO9xdf4F2dOr5NdU7X5r8L5ncHQL/l182qTcrB+Mvg7StHd8YOQLsTbVhFOdFj+c4xm/7lxs4Nja+CljIu+88AoQGBqJciDd+vqYy06TaNLT3SU1MCVaXQIAVqoffUVHiOGJQd5OPbNmmxAHYt9JlJItPi0N7cyR6XTGUbphsM84rH5vNVB1KUsYVHxtFm2/AFNMxA9zNjoleUkbpMcHxt4sA3eolTRWdOGttXaioUOC1tO0LAFlWVKpTc83XfG0Bzl9IeFPfh9KYxNxItIv64wszzS1/CYwy4NlLC100HNQ6gg7X4EG38EOZork3n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fax/0xtwCBHPmPzItAoOciELKvaI+ZtAQVuE/1ePIag=;
 b=pazaHyajSeV6SOq7VlYnL0ZePp1gO1e+7TJ7UXoA4VseHMhnvaAJ8wpBWW0i0W4fJA9mETMflULrcLd8Q88RNX7AZJJnhuAjynmb/YfM5mqJ2JGH863jg0P7BEde2P7iS1nQ42AnPwmaRF1G+4Oa8BCC/3Ee26jRzfhQQ2OV3Q4j7+vb46evfIPSE1QoZx8LrHDAG0PefkuElKmwvaxAWHiOtJGLoNCYAqH1rUi3hUAb/U1UlWwuNkDD/5LfGr4IU2oSnt39lVlrocx01dAKKKWbManHgQnWY8AzTlyixpT2kH1mFCkjSE2XTzOeN8Cpe3GdfZaNerKsB4y3SIdN0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PA1PR10MB8871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 11:01:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:01:13 +0000
Message-ID: <c183806d-c3a3-4860-a8f3-a4e4c12c82f3@siemens.com>
Date: Mon, 15 Jul 2024 13:01:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.1 2/4] initramfs-crypt-hook: Provide full losetup
 executable
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240715093424.632716-1-stefan-koch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240715093424.632716-1-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PA1PR10MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb274fd-04bf-4dfa-7db0-08dca4bd70ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OG9RL3RXMWlQNk9HU2Jsc29wano2QUt5TENQYlVjWEl6NXEzUEFmSmZqSjVi?=
 =?utf-8?B?U3dXMEZLejdnbUdRcVFUeFJhMVN4MkRLSXFZZkl6bzFuMW5IQlB6MUhVWDhR?=
 =?utf-8?B?RGlqUmZ1M01saEdUdktKR3VWc1hHZGc1WVdGWDJTRHlXOUVRTitUa0J6M1VB?=
 =?utf-8?B?eHR1emRSajVxYjAzemVQbnkrUGVaTTdiTStvRlRscEZ6WlBVWGZQaUhNcEFF?=
 =?utf-8?B?bnlmQit2UDFNdWo0eGU1bDdTTDZHSE15cHRJbkJYS0Z3M2xMc01SZmxXeGQ4?=
 =?utf-8?B?TC9ubnFjdzJGb1o1clVXWVJrRyttNkhvSmNiMFZ5VGZLTDQvYStzVlFDT292?=
 =?utf-8?B?U2pQVFF2YU5ML29IZStZY0RQS0YwMk14OU53ZGNnQ2RIVk5MbUI1bld3amtD?=
 =?utf-8?B?UWV4OEJHQzlySWFlUTk0NDhUZHZqQXdjSENMRm0zRmp4T2wrVTUwL3lHL1VW?=
 =?utf-8?B?S0dqRXR4QnM1d1A3bEV1Q3l3TGhRQUZBL3RidmJqQ0tFVXlMQ2RCWGQ4VENT?=
 =?utf-8?B?bHZLSUpRejdvOURBZkhPRUR0TS8vbWhhVmt5VlR5eVNUWVMwRTRiTHA5QnEy?=
 =?utf-8?B?enVwVUkzMG4xaHQ3Zy9lTkJZQjFLUGZwMTVUKzNuT0UvNXlndEhjMFl1NFpz?=
 =?utf-8?B?SEdiNk9LOUlxVi80bnJoVEk2cVBpV2ZkRWxJcDkwcWpXanZXd1U4blFwcHlY?=
 =?utf-8?B?MmJrUVNoRlhYdW5mVFVsYXMxYmpFQS9kam1OMHR4MmZPbEx0T3dkOXpEMVdr?=
 =?utf-8?B?VGttZVMzakdQQ0JoKzRkYXBWM3FtOWZ0d096Z0lGSzVlQ3dBT2RSNTEzRUM1?=
 =?utf-8?B?RGlLWkVtekp3MEdCQTU0Rk8vaExaRzcya1ZTUFF4SS9MZGRxbkgxU0laNjBU?=
 =?utf-8?B?UGx4VHZDRGc1M3Vpdy8xSFFLaS9uS1hiTFBIZnd0c25SWTQ1MlFMR3E0dnpE?=
 =?utf-8?B?QWRPS0tGdDBNWmhOT1ZkZmIvLzVuKzBneTVITTNXdCs3d3pHU0VWSnVWbFdT?=
 =?utf-8?B?RTJxQWR4RG9wRXJKK1lDditXaUhYS2VEdm1PRDBvanRZRDVrc09pUDB4TTYv?=
 =?utf-8?B?WDJ2Q2hrOTkvckRnc0Z1ald0Qyt0SDd3L1dNbTNZaUZnTFJ0eXlndENEODdh?=
 =?utf-8?B?eDFtMGlxeDNKUHVlNDJzR09CUG1WRldJclg4dmQwS3cxZTZuZkxDTVJFeHlw?=
 =?utf-8?B?OUVmTmxML2pCMENzczQxNWV3WHYwWmc1VVpFdFg3Z1dsbzV6eDZFK2traWRD?=
 =?utf-8?B?SzAwR0o2UGRkYS9kOEdScnQzUW94dVRzd0JLWTZTTFZKRk85WUd5NHFRWWJl?=
 =?utf-8?B?UjllQmZrNVFSTkVmQ0hkRVFDeGMvM29lamFHbUlJclowaHNLSWhuOHFtNk5s?=
 =?utf-8?B?SE5wTTRnTVVRd0FnNlkrcFdpR0FMRVA2REtiV29aVkpEYTRXSS9TK2JyQ3N5?=
 =?utf-8?B?cXNJajdZK1NaK2RRVkZyYjBXNTllUkxWR0cySEdtbkRKajdEVllUNUppb21p?=
 =?utf-8?B?U3pybks1SEFZdHRMTXpQbkErQVQvNFczYjY2dU1JNW1rbUdtbHNGQlhJcWEr?=
 =?utf-8?B?ZVZsQlIwN1RvY2R1RnpwSVUrUFhNRkFJT1c2UWNoSjZUZGlsMXUycURCa0oy?=
 =?utf-8?B?blBsZzFzVDA0NzBZRWRkTWhYNEc2bDNOVEdVakFWcEJ0WHZpY29FUmUvMTBn?=
 =?utf-8?B?QjNKalBHNjAvSFRqMTM1dVBaV1ZGd2JRZTFsc0M0SFBiMEU3bDZpQko0YmVi?=
 =?utf-8?B?cjg4QkZwODFLWEZuZFZ5VHdmT3VuR25Rb0F5Ri81TVRMejVvRVBWMkxuU0JT?=
 =?utf-8?B?R3VIN3NHcEZlbzA3UG4xdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzIraEdzSk1rT3NGZjJnZVVwSDh6M3J6Vzk1eGUvRmx5MGt5bnl4SHRUSkpz?=
 =?utf-8?B?cFVFS0twNTNRblpMZG41NHhYa25qblFXRHBaWTVnMmpONDNwUHJxZy9FemxZ?=
 =?utf-8?B?MzM4djV6NlFRVVhDa2xPalJ1YUtYcFE3TWxmYll1QzRmV1Y3WmJGUXlHYkVy?=
 =?utf-8?B?eXNJWExiRUQ1VGtTZ3ZHNHJjQS8zcmxqL0hET1V5T3JhNVB5NWRkYWd6WHRE?=
 =?utf-8?B?TmVsSURIYWdkYm1XZFFGVWNoN1FJZURET3lnMzM3S0VDMWZCV2liRHhzUHp3?=
 =?utf-8?B?a0xGNFRESEJqbkNhUU5FTkM4Tk5RRHJjdThPTFBWWVN5a3R6UDE0WU1rYUZR?=
 =?utf-8?B?TWdKNisrWmtSb3FYU0tLS3ZxSHVOM05KMzlvdk5JZVAzcUFTeGlPVkVSOUww?=
 =?utf-8?B?ZXhPOUZjek9qY2poY0NzeU9IS0N3Z3NBelVEQWVyd0dZNDEvaHJSZ0NndVBw?=
 =?utf-8?B?Z3ZMSy90eWI4MFBFWkEyMm5zOEptYnZDOHo4UGl3amNaV3IyVEZmYlR1aWJH?=
 =?utf-8?B?U2c5T0pFNGljdXExYWlRSk8xVzVTK3pYcEZGNGRsR3pqcCtMb1FuV3BqbXBK?=
 =?utf-8?B?dUhyOVNzNXViOEZWc0tjOXlXdS9KbndlQ1g1dWNyVFhLdEgycFEvQklBWUxR?=
 =?utf-8?B?MGJtRFVwQkEycFk5QzNmMDI0UmpoYXpQajI2OGtyUWJOektidWVIaUhhR2Vz?=
 =?utf-8?B?dGE4dTR0NUh1eTdkZnBOVFkvWE5uaExWb280WW1PdURLR2lnNGpTNnJQWlR4?=
 =?utf-8?B?cU5JdkdxL2x6TmticmFEQklZdVgxYUNXTCtwZGY2NnVEU3VSMzhXeUNGQ2pi?=
 =?utf-8?B?NWFPenhyekFSMWxMY2k0Tk43QkdYTGN3RC9jN0xYbXVQOTRjL1BkWWdCYzdv?=
 =?utf-8?B?SS9PZGg2bG0rVWo0dndCQWtxN1NSRHI5dFIwT3RIUnNwODA2cVBVOSt4NGNP?=
 =?utf-8?B?VGtFTG9TOGkwOEpaR0s4UUc0NFdtbjdsMld6QVF1RmtScnkva1V4ZXBETTI2?=
 =?utf-8?B?L1VrNUxSRytiYkVZSkxJYTI5YWxCVVFhR2NDTzNtempyNzg5ZEJHRFplSnBU?=
 =?utf-8?B?QXZ6WXBJWU5sQzlYdkVpWGppdU1tWnk1MVB2R0NUdnRKRnNYUGM4ZHNOaDNU?=
 =?utf-8?B?aXJJYlZHS1NwYTFHSjhhRWcyN09abmRPVU16RHFKdEZLZWlQYzlUQ0FRQzFh?=
 =?utf-8?B?aFJtdk9zMXJjN25yaWtYMFVwVzdQdFMzTkNaS2g3a0dhVDRPOFFnWE9qUzli?=
 =?utf-8?B?YVdZblZ2ZEg0QUc3NHpIOXh6dE85K1dkWU4xNC9VemRYRGxDMFJXSGI4UjlI?=
 =?utf-8?B?VFlFdE5IUmlydWRlblo5YlREaHM5ZytLQm94NUpqdlhuVHEwVUMya3BGY0xy?=
 =?utf-8?B?eXNqTUJzWWkvYkxZUDh2VFVmNk1aU0d5NzZEVlpNcjIycWV6bG9hNzBQVjQv?=
 =?utf-8?B?enAxTEhmQnh1bEEweSs5U25nUlZvU3RrLzZCdGxoSHFYZXZBZ3VMcEhQeEVV?=
 =?utf-8?B?SFVZcGUzTVFnMHVjRktBVzZZNFhiSmo4djlYaC9FTHYvV3FtRjd5Y0tIUE1R?=
 =?utf-8?B?Syt1bmd5NVY3WFlPUFEzVkZub3ZYWGVGaGQ2YjBDOXJ0dXcwZVp6VzJ6SVdL?=
 =?utf-8?B?RUpRTUw0L1ZBalFjdC9CTHRUQjFjRkxJazhRNGhQZnYrSVQ1L09xZkF5cExr?=
 =?utf-8?B?eGFrUUtsV3duMlNGRmNvcFBVTTAxWHhTamMxUG5rbHVINEtoM2hOWGd4OXl6?=
 =?utf-8?B?T2VHeHdhUDA4RVh6S016SWJUOWUvSk8vajAwZVluVzZNV2RGdFkxRVQrdVMy?=
 =?utf-8?B?SHdzK21VbGtnMzBHMDM5b1d2UGlBMm5oZnFGRERwTHJOSUltcU52RUd0N1BY?=
 =?utf-8?B?QkQ1T3I3RloxWjhhYnNBQitWQ3Vmc1hnVkxldDEySXByWDI4QTQ2b29RWDFP?=
 =?utf-8?B?ejNBZFRwRHNGVDJ2M2FQRGwvTkRxU0tQZVJKbG4xcGx6RmtYTkdSa1BHSXkw?=
 =?utf-8?B?RjMzdUlaT25QVktmaVBGZGJ3KzNOTnI4ckpqWDU2V0ZpZTdRc2pNaHUvZnZq?=
 =?utf-8?B?WE9ORVVPS3JQQkRaOXJVRnZPUGNzNmJzYm1TQU4xNWx4SDFUV2VlWmpLTlM4?=
 =?utf-8?B?N1QzVEdONEoxOU1YcTZydFlwRkNmRDhPUjhXRGtGY1d4K254T1BFczRaK1lv?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb274fd-04bf-4dfa-7db0-08dca4bd70ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:01:13.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TDfLddZOU8vH0+l/l1Li9J6xs+TZOZQj0yb9BNHuUzzJ8oESo44q0RYkJ9AHW125sSeWw7Lb3WrgU9YDYvFnU9ILSwk4BBZQoFkyGfdyHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 11:01:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16491

Hi,

On 7/15/24 11:34 AM, Stefan Koch wrote:
> - Avoids using a busybox losetup executable that
>    doesn't support the "--sizelimit" parameter
> - The "--sizelimit" parameter is needed for introducing
>    speed-up of disk reencryption with the following commit
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
>   .../files/encrypt_partition.systemd.hook                     | 4 ++++
>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb         | 5 ++++-
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..72033d1 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>   HASH_TYPE="${CRYPT_HASH_TYPE}"
>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
Why do we need a variable at this point?

If there is no reason please drop that variable and use always the full 
losetup.

Quirin
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index be8c117..2ace533 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -19,6 +19,9 @@ esac
>   
>   . /usr/share/initramfs-tools/hook-functions
>   
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
>   hook_error() {
>       echo "(ERROR): $1" >&2
>       exit 1
> @@ -47,6 +50,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>   copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>   copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>   copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/sbin/losetup "$LOSETUP_PATH" || hook_error "/usr/sbin/losetup not found" >   copy_exec /usr/bin/systemd-cryptenroll || hook_error 
"/usr/bin/systemd-cryptenroll not found"
>   copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>   copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 72de5b6..1679133 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -9,7 +9,7 @@
>   # SPDX-License-Identifier: MIT
>   
>   inherit dpkg-raw
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> +DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>       awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>       libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
>       e2fsprogs, tpm2-tools, coreutils, uuid-runtime"
> @@ -57,6 +57,8 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>   # in a newly formatted LUKS Partition
>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Path to full (non-busybox) losetup binary
> +CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
>   # Timeout for creating / re-encrypting partitions on first boot
>   CRYPT_SETUP_TIMEOUT ??= "600"
>   # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +70,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>   
>   TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_LOSETUP_PATH \
>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>   

