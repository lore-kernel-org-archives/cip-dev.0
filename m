Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F04C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:18:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web11.26440.1719407878353688883
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m9HvJQwL;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blKJPdrjaqA2cRIs1H58iNR/fWNaeMsaG73u/eqLJpm6uLf+6I76THqNvnAVDN+GnMLCT/PgzAkoFIIMdFFAaHl/36m04UqgTaHSVJBUdnC6E7RXqT9Ov/Errae1tkHXfrSXePiiQmEy49cLe2TN50U4E+6pfBLnGoQyJW58r4d3OcTdKWeJI1wayMvijGjUWKMJBh0L/AXMorzgMYWQriOB//vZPtBZoIN9Zmaz7kd3M59B2HRow3cpTFD9G8u7mG/m0zLL4XgCY3EMoMdROi+8+wYBMhKgiSAY73NLDLYPH06yoU1KjEwE3wPxdt4Cmp6f4BxRBTQrvPggkyWd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPeZKFbKPu/5X/fP2wsYC7/apYv8o6Eih0IUA5Tah14=;
 b=gtlASKm2pHAOtkeuGYA6T7RaNGwJV2gzBRNx3/53UeiYeAZJRILiv5YS0xvO5t9RjoDSFdzrXBn7UIl/RyYOFoP9eAgEDzQwQJBdGhcp+WjqbdO97lSH46kZkneq/XtR1ocSddmrBDP5xjxeIMei9fngxjCvwjAwR06mt21SGh7gXcKUZFxdOIxuhjND/40SA6Bg+L/1tIV/Gn8NIuwdy8GB62Xxa6hkmXktNrYFTEtGvHT51tr2Jl4skz+mEo8oyUraxWg2WeOI5QpQxzRrAsC24uTma0yI15Q7Od+Y+opCrbkq/CPr0RY9mEZnrEpJI2tYij8F9je0kvr0HrN4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPeZKFbKPu/5X/fP2wsYC7/apYv8o6Eih0IUA5Tah14=;
 b=m9HvJQwLXJHQpEXsb0nuuVlV8tyJOe/Dapf99WoJG1HfQSeR2Gd5K8U/HC0yEfKwzmuodxy/YkBgP+BWfJ7StqkJTSWlDGXl7Tv5xXaAl3ToHMWjRk+JOKL8NWkNPkA3sTPidk8t1uup0ebUqendkihvMohX/OYQR0yjOuETeDY8c5PhS8t0wXYuEE40wqOlMU23RBJRqzd8jA4yeM5Z3ebBvTErGwSnKo9jlknwVfIun6C5vBlR9/dmm6XH1j0lFFu6bKBZvZOAM5QUKebk1JNpdURLJkTzZ0/68EVwD+Iw02hnmD8W8tlAlB3nxwrLm6D8UXqWAjbGiEWXOspcFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB7510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:17:53 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:17:53 +0000
Message-ID: <1c50824f-9f55-4cc3-bd43-d01f4e694bf1@siemens.com>
Date: Wed, 26 Jun 2024 15:17:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, jan.kiszka@siemens.com,
 cip-dev@lists.cip-project.org
References: <20240626114715.70823-1-clara.kowalsky@siemens.com>
 <20240626114715.70823-2-clara.kowalsky@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240626114715.70823-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: da00dede-c35a-4e27-b040-08dc95e262db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?REpwMVNLcW5YWmo0dDRld1RWWWNsREhqZlo4Y3ZOaVVPd2Z1WlFFNmFESzBD?=
 =?utf-8?B?dUpiUzVKWUlxZDNROTA4TFpncDZ0QTBYclhrVi9ObFRPSjFjMkhmYkYvT3Y0?=
 =?utf-8?B?VWpGZ1ltTTduemhvMnlqWXdSVkNlcFlkSVlsVFdRc3gzN3ViNjZVWDBneFMw?=
 =?utf-8?B?SnJWVERVMUFUUkRTVmErUkl3UmQzYjhTMDlITlcwbHFoVWprZUhhcFJLVG5Q?=
 =?utf-8?B?NXZ4YXJ0SHUxWU9LYXpmTEthL0N3dk9Oc3pNZm0ra0RUYXEwR251cUsxeUQ3?=
 =?utf-8?B?M3JUMThOMzhQY2hzcy9Mb2p2YnB0cFNZeHNuSHRNeW9OSHFnZVd4amJQRFd3?=
 =?utf-8?B?djlXYkhkWGI4YTJmdTBMWGhodU1UTjRFc3FGSURUZ0FsSVY1YUNUb3FYWlcx?=
 =?utf-8?B?RzZXZlFnTTFRV3ZzL3A2c0xJWVdxUjFUV3BrZG15b2pFcmxFNVVKcVZQbFkr?=
 =?utf-8?B?bXltTXJ5d2QvRFlQWGJzQytPTElDY2R3TVg3RjQ4b2pZQVRjb1QzS2NmUk1M?=
 =?utf-8?B?MWVudFU1ZWdmTkVoOEpGK3VNYWxmOXlpOXZyUGt4d2JuNExjN2Q2clRZdnlE?=
 =?utf-8?B?dklEOHJ3eWs1Szg2SkRPSGpTVHJ0c2JOQkJZeEtQbUNGKzBDWFh2cktMWXZ6?=
 =?utf-8?B?TUN4YkQzbndZNTZVMVhubE5rNkk5MFVnYTg3aDRROXZ2ZFlvOFg3OHJURFdV?=
 =?utf-8?B?UWFFaFRiSFZBYnJyRHhQbDdiODNLNDl3QlRVOFJNOVdNeWJTQU13MTlnL0cx?=
 =?utf-8?B?QzhLcFhSK0JhbXAxSXdQcG9PcUpJandsOG1kUE81dUZPM0prYnhHSEE2ZEtK?=
 =?utf-8?B?U2lzMW1yTXVIbE10OWlnZ05uTDA0S29YNi81YytFN3YzNFozZ2xIWncrZTNq?=
 =?utf-8?B?UzRKWXRka2E0L3BRa3pGMllSOHFTeDBZcXBaSWplVlZXSG5GNnQwWmFxdVJr?=
 =?utf-8?B?TXA5Y3loUWRWOGNKYW9IemxWYUZLR1R0YUd2QjQweFpRUHl6bzIyRElxL3BV?=
 =?utf-8?B?OGk0K3grdCtSQjRaaGcwVUlHbHJ6akVkRkR2Y0VEWXJka256bzNGS3NqREJr?=
 =?utf-8?B?eDdqTXl3bHM0aTZ1VHpPOXY3eGhGU1F3dGQ4ZmZHTjRBWTllRnNCNnNzRTBM?=
 =?utf-8?B?WU94Y0MyaEMzeHlUT2o2NFN1amRPdW4ydE84d1N1akFsUDRqUEEwd3hhTzhS?=
 =?utf-8?B?ZXFyd0N2TkJaMUFCTlNKUzhHSDZuei8rUjRManZNeitvZVZmb2c0ZHkrd3VL?=
 =?utf-8?B?aTZZZDAwQldZcGRPT3U1NEsyVENvRjBSVzUvTlN0MndLdjI3UEg0T2lUU1Zp?=
 =?utf-8?B?VzZCOElVTHNOWTc4NTNOTGtqOWhzSlJJYlFLcDUwVWYrSnU0eFQ3RCtXbE9u?=
 =?utf-8?B?ZUozejdBRnBzMjRXYkZiajVwNk4vMnBvTWYrR3dwbVBFc0hCWVhzYytiUWlE?=
 =?utf-8?B?NmxXNDYraU5PRHMzY29QbXhHKzVsbW5WVGx4NXVaQ3RDN0NFTURiV2xMcUJI?=
 =?utf-8?B?bVNXT0dtYkdEN0FkOXVnMGQ2SjVQSGRKUGxzblNqY0lEQmFGM2dNT2FnbnRz?=
 =?utf-8?B?UytDcWxTY2Z2d3o0WjA0UFdEemthaVlaOXljTXJQUW1VZTFoWFpBNWdtN1E2?=
 =?utf-8?B?ZHIzM0ZYWW9RamVqblRGK2ZSUGlOZUVDa2lQV1dERFB6cVhHb0NOV1lGSWxx?=
 =?utf-8?B?aDljVVJWU2xVbHltcE5uWG5YVlpINHFyQ01qZUFxeU5vVUNHNW1rMWVCYTNp?=
 =?utf-8?Q?GXk+rfrsoVS11VNbbTKNP/r8WymAJ+Gvik7l+AP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c09Jb0JYcjhPMi8xanZ2dzBLZWliN3ZhQkNKNmdMY281N3lDQUV1VkcyejJi?=
 =?utf-8?B?RnlESFFBN2o2ODBsdzRTTkhQTHQ5cko1dDVwRk5ZUW5ZNHgwZ1B3WGx4ME53?=
 =?utf-8?B?aUFkUGhacWFnSkRtazAyeXg5RDVqN0Uyc1pKdjUwQlNTb0w5OTgzV1VwbS92?=
 =?utf-8?B?Nk04WHdadEU3ZlRubldxOW1xWEgvRmlOV29XcVpXUmNveWlPY1MxUGtBVkJa?=
 =?utf-8?B?aXdIeXRSZ3FwL1NlUUxSU3hULzZoNWYrZE4wRHRQNjZYdUNEY0thdUs2VitI?=
 =?utf-8?B?K2xYdFU5VmtvelB1WVRJS3lyekN6dTFGRjRuSXZiZHdtMTJlOWxycWhNOGxo?=
 =?utf-8?B?dGVzUGdEbTFqRlNCVE8wQ2dWanBCemJ4UTlzNkpkQ1JTcnczVGpQQlVWU2J4?=
 =?utf-8?B?Zk5JOEdhek5WdDZPWER2a0haSUE0bnNMbWhDNWdobGVERlI5Y0dudnBFVXZh?=
 =?utf-8?B?RVdHYjkvTndlaTdYejd4Q3ZUWGhFL2RWZ0oxbjRzSm9CaDlEYmd5aWFHdVkw?=
 =?utf-8?B?UDR0dTlYelhXRFNsMEJrNFIzaDlxdlNaYks3RU5uaDJ5dlpVRmc5NEc3YlM0?=
 =?utf-8?B?NGtZdkFKVjNjdGVadU9CbGUrNHBXSHEvRzVnZDYrUWhpN2xMTzducG5mMmIx?=
 =?utf-8?B?bHQ4Y29ZVStuWHN6OFB5SEhqaG9Nc29WUEUrYzVYMjBmZ3ZuWUlOZTRMMmlK?=
 =?utf-8?B?WWxsODlwWFc4VDlVaDRqYk9jT0w1M0hJa0RLWTVzWnYxU2dNWXNtdDhYMk9r?=
 =?utf-8?B?L2VzRVFScTRUTnhFSTNOSkZzZFl0Mjd3UXdDNlFrWFF6TXZKdmdsMVMwMjV2?=
 =?utf-8?B?Ylh2bUdRWU4wMFkrUXBGelRicWNpNGFIeUFvczcwQmZkRm1ndHY2NFlvQkIz?=
 =?utf-8?B?RXlVcklyUFJ0a2xJYVhkc3dOeXNBUUZ6KzFyRmxzVXBXaFNKRWc5UW1sdHBK?=
 =?utf-8?B?eGYremp4WmlBT213UXhkdXByWkdlWEg5ZmhrbUtqZHlOdVY4ZlB5ZXBXYUx4?=
 =?utf-8?B?NTRMZ3JFNVRvLytQMzN1WGw3MjRZbDlZdzBsT1J0a2NKNUVseXVDZzd5V2s3?=
 =?utf-8?B?NzV6V1JSRTc2R1lvTy95TVFoTk5uaFRRdGQ0Ym1nMVhKaWQ1M3diNlI2WVVu?=
 =?utf-8?B?OHd5dEVEdFZVc1NkaHdQc0MzSTJwY1RZY0VoTGpBTGlGUG1QdFNBY0J6YThw?=
 =?utf-8?B?SWNrN3d4KzlodHVKRWtRSUI0eEp1L1ZzaEpJWmdHcStBRnUrbjdUbkd2bjE3?=
 =?utf-8?B?TVh4SElaTE9lMFMvSjlHc2k4bVFCUjZ2M25Ha2s1YU4vMFZhQ3ZqRU5TU3pI?=
 =?utf-8?B?am0rT3B3dXRjUFF5dmR6ZUptUTRJMWt4VDlRWkoxOXBFZ2gyQ0pVNWVPY2dU?=
 =?utf-8?B?cC9zK2M0OWRHQ1JwcVIzcVlFNXdneXkwYy9yWktlVkhOOGRSb0w2NGdvcDFT?=
 =?utf-8?B?VkV2ZWFmcExpaitlVjNPdDNMRVkzZ3RXTDF0elpqT3lQNTJERXFDakN2Q1E5?=
 =?utf-8?B?T3lnMitYckh6a0k1cGpTL2M1SmlEd2QzOGZqUzVJYVlUNENFMWRDamdGcVBV?=
 =?utf-8?B?UzZBVEZDUHZYMnR4cERrT3BYK3JHWWVObjhPNzFrWnhRV3JzRytTZ3o0SS8x?=
 =?utf-8?B?dVRjSmhJbWFkYTFxMFdpVFhTOC9tdG1jYlkrZ3J3ZjJ5cUdCTDBtYkFodFMw?=
 =?utf-8?B?UldheTc2dDJ6bTRhbFRTdmIwa2VvME10YjNtVk1BdTZEc1NDc0FXVFB5YTR1?=
 =?utf-8?B?M1NiL2Z1UUpDSjk3MHJyeWtydTJIYzkvejEva2pNY0J4YmVCeUtkVjh6dW9x?=
 =?utf-8?B?Z1hyYTF1NDM5YnJUbHI5SnNBYkovYmd4VmhrdnRRSFo1S2FhY3NkMlpSNFVY?=
 =?utf-8?B?WHNReEhPWmFhR1Z2OHg1clEySzlyTXhndkQ4U1R0aFhJNlRCUkwwZWc3S3F4?=
 =?utf-8?B?YUZEWjNGYW5BTlhXaTVSVkhRRW9nQkx1djVPVlBGTkhtYVR1WXNYNnpEaFBi?=
 =?utf-8?B?aWluTGtFVUFiUWUyYXVNeDlWZlVWbnV4ak9EODVHd1Bab3dKeTArUk85STJJ?=
 =?utf-8?B?cXZ1cC9GV1N0cjBRTVIzUWNHNE01QmxLTC85V3NMNlF6NFRnOEdTTGpGYU5P?=
 =?utf-8?B?aFBSbVhTWERjOVVBQU9PQ0pleHdlZ3JHQWx6WisweWNoUWl1OStzZC9TcmEx?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da00dede-c35a-4e27-b040-08dc95e262db
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:17:53.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzvLMcQzBaDfMkKmJ+r4lLJbt+Q6NYITAbSjsQcYTy6qQue682ZO7jlQICG+76olfNZ0ARWdzPFGGQCY2QUp1P5qXa0JwcVwImX0I7lK68E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:18:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16326



On 6/26/24 1:47 PM, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>   .../initramfs-overlay-hook/files/overlay.hook             | 5 +++--
>   .../initramfs-overlay-hook/files/overlay.script.tmpl      | 8 +++++++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..7a9f737 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -23,5 +23,6 @@ esac
>   . /usr/share/initramfs-tools/hook-functions
>   
>   manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
Where is hook_error defined?

This is a self defined function from the encrypt partition initramfs recipe.

Quirin
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..6b404c6 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -34,9 +34,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>   
>   root_mount_storage=${rootmnt}${ovl_storage_path}
>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>   
>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	if [ $partition_fstype = "ext*" ]; then
> +		if ! e2fsck -p -f "$partition_fstype"; then
> +			panic "E2fsck on ${ovl_partition_device} not successful!"
> +		fi
> +	fi
> +	if ! mount -t ${partition_fstype} \
>   		 -o ${ovl_mount_option} \
>   		 ${ovl_partition_device} \
>   		 ${rootmnt}${storage_mount_point}; then

