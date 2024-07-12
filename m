Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72710C3DA4D
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:30:41 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web11.3940.1720776633850954268
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:30:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wn6kt02a;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGZUsAMOedRQbW3LTJZAp5ZUZrTfiBgjli1BV24IJmzqC408tlyzCY0kYRES/Uo9ZLJ6c39DldbYJUVH1BvQ4OE1Gek+bPMK8saNV6qLz91Wwb7kSWBSOkFvaCn6i3RXitB6RhBrK2hX2lU89hcQQJ4wWAuvP75IIHT0biqi3SpeIDKmVZINO5ygJfR2+FkB+eGl0i3xjoLb0Tklkd19nkpZTINmLR+HRWHFQdMo7IFXxw3s/cNBniieGzqNML6ozcQbS1SdLKw4AA8BPtBwyNU28bcppjsU+N8+IPmB2r7P2p64cvaY+CGMnFfiY6nx8uknYygZ/HMzTNoCs1dsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEv50irF1eA2iCNodmi/vl0gPns5rluYdL46Ow0Dfiw=;
 b=aM0nN6Sgx5LasQYtF+7fvQRaTKbN+JKCKbYj/D91HRXvAVs8oKxIrAhvRtSxviB5nair8yy1kxBvidnNh1kt/DVPmExupTgG8t6XsEVdf1q0emdPeEqOteSIffyX2Ptl7aV5eAcxaZReADVWiv2z5Q/18MQzfW7UFbPwdkZNby9QrFWNuNqAROliDhdtL78MIHiDCLhk6BX8wDqDYlmGYQs3eZKvAh4Ruz4DxU5nR1ApLmnsWkZZObxxWEiE57SDt9x5hiT9OpdkyHQT9JxgfXvp4lQ/bbH0jMOIc1Qni3T/fsK0UIR4w4JqrBk2IXODOqucHDRU4KuV8XEhPsfL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEv50irF1eA2iCNodmi/vl0gPns5rluYdL46Ow0Dfiw=;
 b=wn6kt02a0rVqv0Ve9652vZPDUQM64umIOWvkxcM/LG9pPaknbhaElq1kqTkcpmIi3b/WLxJANxG/5R2s64fx+YnVJmw3ar1w/W7CISm4fcu3ubXFKbGce4137qBvwbcK9hpjJLVpPVK2dOjopnGWISMKms56vvIUd5ZVOOQ7/zVb1AVFitdBnIKrn8nAhLdgcVpI9zUzwGhc74SwnQCWBoCvcujxgBKqYTZINVq9nP/w5GGVkJQioiqihJxu68VGpr3aaSkHrtgiVO4VOdI5+raTuZoz5kgPSAIq7XpKcrIKuHUJi4pIYcfaklU1FAuYw2V5ohEnJ9zTGkDOO+yXPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB8744.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:30:33 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:30:33 +0000
Message-ID: <998b7abf-4a8f-4f22-abd1-e077eaf68bba@siemens.com>
Date: Fri, 12 Jul 2024 11:30:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] initramfs-crypt-hook: Speedup disk-encryption
 reencrypt
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-4-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712081143.1376952-4-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d786d0b-d37e-44a1-729e-08dca2554760
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RjNtK2FVcmtLMklnV2tHcXpsVmVUMG5MOGFvUE5FUnN4YmhFTzlJM3BEbGVK?=
 =?utf-8?B?MndxaHYrSGFzb3VheXZNd3VUMUJZZUVNSUQwUEhtRlBTU3pZY3FtRUZpR0k4?=
 =?utf-8?B?WlZsbm5QR1NJNWNWOURiWHFBRE81djRnT3hNUXpnd3c0ZzhKQmRPOVQ0U3NQ?=
 =?utf-8?B?S0pqYjM3TkJUa1hFVkw1MER5ZTFkZy83L0lGNUhIemljWmRkS0FtOW5PTFNk?=
 =?utf-8?B?ZkFOSkw4b2xSLzJJVGM1NTRBbnZvWWJLc25vZmgwcGhkSnFLRzBlODZHaXpz?=
 =?utf-8?B?UGgvQlJYLzZsc3FORW5jeTBnNngrVzNLajJlWEMzZGl2T3VCUndRSjhqb0hC?=
 =?utf-8?B?MTQyWThyV1p6K2Y3Z1AzeUdpS0FydzVITEdERFB5eStra2VYR2J5K2cwT3RD?=
 =?utf-8?B?ZWhlY29mNkZ3N0NldHVDRWNKT0RQYldaci92V0VYemxxVzJpYmh4RWRSSHpI?=
 =?utf-8?B?SWNrVE16emVBL3l5NkNzcC9EOCt3ZWo4QjczYmtHakNyWWsrL2tSRitmMHNX?=
 =?utf-8?B?Wm1vVWZxRklleWRFaDYyc1F4SnlCazVRN1dlTXFCbVd6dExMdnB4U2N0eDJJ?=
 =?utf-8?B?SFdieGZKY0lhQzhRcXBXa0xTQ1FHOE5pb25BSGttZVgvN3VuZGdxQkwzWmlq?=
 =?utf-8?B?bC8wMERxS3hlS1ZQcERoZ1R4SWZvL1pFK1JsLzdnNXZoTXRqZ3ExZ3dHVlBS?=
 =?utf-8?B?WTZIR3BzaVk5NElDZTYrVmczajNKc25WZlFCeEtsZ1pEcmJMc1BTM0g4SWtW?=
 =?utf-8?B?MzdiMWJubC9QYjdwQzU2eU5wWUIwVU55NmEzTmFiclhXTXVDQzlrdVR5YTlM?=
 =?utf-8?B?Y21BVU5sNGRDTXZsOUVGb01LSEkvcE9NT0tQWXV5ZThpZjllRU9pNC94bUlp?=
 =?utf-8?B?MGtveDlxZTNJcVFqS1BaL1drNGpoVnhiMnVwVzhYdFJkMmVkNGhsbTREeiti?=
 =?utf-8?B?bUNTajAxYzdxd0dTck9oNE1EM2FSQ3A1T2NCbFN3WHozZ2o1L0padDROQVJP?=
 =?utf-8?B?ZjhxU0ljaVRPUUN2V0haeVFkbXNxTmVaNjR4RnZLTytmYnBMV1JoeUp0YWcy?=
 =?utf-8?B?d1Rxc3BqWjJ1ay9JUkxReVZ6TEg1MFdITFR2S1BOSU83T3AwTUJwOXlmM214?=
 =?utf-8?B?VWNBZzhISkZhOFg5aGlEOEtJZUVHYno4VEd0MERDMHppTXdLdFpxMmVRTFJQ?=
 =?utf-8?B?RENIZXRZOFlpUUE2R1JrNjcvWFFoeFRMSXc2aTFDZ2Y1b2YxblJDNFFmUmEw?=
 =?utf-8?B?dmtSODdIYjZpMTZDdUY4MDN2anJxemFyYk00d2tPQk5UV2kwbnkwWDRZa3Yy?=
 =?utf-8?B?WWI1NzhGS1kxaVZJQ0ZIb1dhZXUza2hET3JxVEg3M1VWRXVNNHZtWDZDczE2?=
 =?utf-8?B?dTdhVXI0bTloa0pWTUhIUTR4U1MzcjAvaUFTWmErVGZMYzJoS3JHZmZqc2ZW?=
 =?utf-8?B?a1J6OExpTVhXS2NxTkFZL09pUUFEd2xDVEVhMXAzcXR4ams4Q29IeXVOL2F1?=
 =?utf-8?B?RzdSZWlMYXh1RTlaNFI2SUxaNk1QMFVtSlpYUnE5RVgva2dDUkxEbnFYTXhU?=
 =?utf-8?B?RENJZm5mckZFK2JWUFRWcHpLSVJpUUcxSFkrYzJaMjcxSGExR1BiK2Z3WEJY?=
 =?utf-8?B?QXRWMTdld3YyU3dvclI0NUVhajFzZXJ0K0VZY3NMVXk5UWtPc0p0aGEra3ZW?=
 =?utf-8?B?UFdHZ1htSlBLNVlzRmxIQk1lTkxTU2RsTXU0SWNmZmFLeGp2WC9aOWxDTnR4?=
 =?utf-8?B?THliOHpRTnV1SjJQaVZCdEhiU0NTKzl6STBoVnlBUkxiZi92NU9Tbk83dEYw?=
 =?utf-8?B?c1A0bzI3RWlyM0VpMXFuQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUhNYWY0bFpHRnpqSFVIRjBvMXBhVGY0UE5rQXloa0c0elozTnBZVnJDM1dD?=
 =?utf-8?B?TDlkSXdFMTAyNGFTKy9KWEJkRWl4NjZUNTVYUEhTdHZUTWhXM1VKQXR3czdD?=
 =?utf-8?B?ZWE2bWN3Yk1Ta01zT2Z5dTlnZ0tKeVVSNVROR2M5TFRvVFJTazV4Z3lFam12?=
 =?utf-8?B?UWJTQTY4akNZY2JrTThENSt0cEY0WnlKZmRlMzljV0p3dzdsQldkWERZUjZp?=
 =?utf-8?B?Uk5zUzNZRkJ2MHp5Y2VLWThNZEFxTWlQNlNmMVhGUVRqZDlMaW4zSjBxSG5I?=
 =?utf-8?B?aTJpVWIwcGZlWjJHanE1R1loQi85U2RualZKTk0ydG85OFdVRVU2YlQ1WTd5?=
 =?utf-8?B?Q1pQeDl4OXp6OXdpdEUvMVd6UDZsaGhRM3JCVFhBWVl6OWdRREZvU0l5N0VE?=
 =?utf-8?B?NHRka2YxdHJqUkYxV3FEWGR0cm1xSlIvaTRXbUtvSFE3UUxhd2ZlcXBMTUdz?=
 =?utf-8?B?bGR0VytweWZOWlJIMWJoYnh3MGs1UTR2QUhFb3h1T2NORUhUbEp5U0dOZU9H?=
 =?utf-8?B?aGoxeG5mZkVYK3QvVlRnT0FlQWlIMHpoOHVaVnJ1YUh1bmNGRUlUTUlOYWMr?=
 =?utf-8?B?SHEwaGI3Rm9JUlVzV0dOWlVqUDRqMTc2WmJRZktocU44U1Q4bEJFNXdVckdC?=
 =?utf-8?B?UkFPNGdaWVZhUVZaQ0xCWCs5Umt1UWp6OGFudUpzT2dqaUJPeWpZMU5JMjI4?=
 =?utf-8?B?WWg0Z296UGRvOE1qUHpwRS9GcG1FYnhoSDlsM29qeUYrRVFmYTI1TThHTmpP?=
 =?utf-8?B?MmFIaTlHYXBOTWlXL3RscmgzWTZ6a3RTdVBpMnhDRTNNUjk5WncrNkxYN1J2?=
 =?utf-8?B?YXgzUS9FbW9CeXcrZWVtNlJoaVlDUmdqcTMwZlllTUxFd2lWMUdXU1ZJVk5q?=
 =?utf-8?B?NzZxaVI0b0ROV3dWRHNUR2U3UmlFcDVLTjgzdCt3OEx3aExBK3NaN3B3S1ZO?=
 =?utf-8?B?RE5tbERmdFRkcTYzSDNRZThFQk5JWFNSbkwwZEdSclZXZDZxUm00ZVFtT2pk?=
 =?utf-8?B?QmVPRk9VYXFYVEpvR3NUcmtVazUwRTJJcDF0bHFiMTdwdGU2V0FuM1Y4cHJn?=
 =?utf-8?B?Vk8wVlEvd1VPTlRRSjVCUE8vM05WZjdXSENONEQwWExMeTh6ZHRmZzA5Ujh1?=
 =?utf-8?B?dFRIdE9mZExuVTZhMnVmT3NMdzNrYWVIL0pNY0dSRG51MWEyZEJrdExyU0Rp?=
 =?utf-8?B?ZzBWYmNuNWo2R2tiem5qZDJ6OXlSTlU0MlR6MmxPRkNzWjJXNHhvMVpBMnN3?=
 =?utf-8?B?ZW44Y1FFazJXTThSeFJxY2RnVjZvblo2T0k0NWx2dU9DQ0pBbkxOOHUyamVh?=
 =?utf-8?B?VWRVMjYwdnJ6Z1BKYWNXSmo0dHpnWFdkSVBNSmFrOGVORVdMOWxaazJqNGRB?=
 =?utf-8?B?aXdWbU5EWExoR0s1WWYwemtjYy9Xek1vSm1GRGp2T2t0QlNVSlRLOW9VT0hn?=
 =?utf-8?B?emxvNk5RRHFvYWFMVlFOWUJoTlRQRmZjUUFFWVZTSVJBbXl5K2F1Q0RkanBI?=
 =?utf-8?B?YjF6TG44aEgrNlc1NnNVYXhVSWhZS25CdEhMRjJmbk9TMkFtRHg3ck1HWFhv?=
 =?utf-8?B?SUh6STdDM0VaTzZXWjI5V2Ztd21oa3lVUStpR2Q1OGJCazVHNWdSYzY4RmFF?=
 =?utf-8?B?S0JJWGh0TkthanVZTEtCMWM5SytidDZlK3dwVFNyY0lTWUs0VTZQVGIya21x?=
 =?utf-8?B?VDV1QlpHZWpzTDhmbkdoTVV5cm9VS2NnTFhldXRHVW1pZWxEM0RyWUVHZklD?=
 =?utf-8?B?OUlWNVBaRkJ0WVdxUXdpcGh1dmkzMVVOVE9YSmhyV3BlVGtuNkcyTUI1ZjlO?=
 =?utf-8?B?VzJsM2tzTjFRcFRDOEpXYWYrQjI4RFdZb3ZHUXVDNk5ZV0w0RjA1a3lMbzlK?=
 =?utf-8?B?dnF5cTY2L1c3M05TWElrVSt5NGpSVEdIdjZGcUxUdjhRQ3dVNWhoaWViREZO?=
 =?utf-8?B?bjFyMm54eUlOdVU5d3dDQ3YwN1RsYnNTa2ZRRDM1OWZyMWoxZWE2TDNmb2JQ?=
 =?utf-8?B?ZStDS04wSW9pK0FhQ0o5c2c5Q0l4OUlSZzlXR0tscjNIcHE3VUExeVpuMnli?=
 =?utf-8?B?QVhuZjR0dUpvK1RmVTNJNHJNNndUQmhvTExhR0FFRTN3Wkt6ZzdLVlk0ZTdi?=
 =?utf-8?B?cHBaUmxQaHlKV1AxV0N3UWhTSTdRREJXSjFPQUNuOVdDYXlOWEhGKzIxL0JK?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d786d0b-d37e-44a1-729e-08dca2554760
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:30:33.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjpDQqC3Tya79WZkTnubYodvOPyaiRoKnik37mzjojYB0XapOTFD6JVeWsu1AD2sYtPTJI+BUlhGerHdn5mSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:30:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16466

On 12.07.24 10:11, Stefan Koch wrote:
> - When "CRYPT_FAST_REENCRYPTION" is set to "1" (consider security and
>   data reliablity aspects when enabling):

Where are they documented?

>   - shrink partition temporarily to minimum
>   - encrypt shrinked partition
>   - expand encrypted partition to maximum

Can't we rather generate a layout that starts small and expands after
encryption?

Jan

> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../files/encrypt_partition.env.tmpl          |  1 +
>  .../files/encrypt_partition.script            | 50 ++++++++++++++++---
>  .../initramfs-crypt-hook_0.2.bb               |  6 ++-
>  3 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 72033d1..9f3df4f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -6,3 +6,4 @@ HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
>  LOSETUP_PATH="${CRYPT_LOSETUP_PATH}"
> +FAST_REENCRYPTION="${CRYPT_FAST_REENCRYPTION}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index f943aea..e768b54 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -62,13 +62,16 @@ service_watchdog() {
>  }
>  
>  reencrypt_existing_partition() {
> +	reencrypt_device="$1"
>  	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
> -	# reduce the filesystem and partition by 32M to fit the LUKS header
> +	part_size_in_kb="$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
> +
>  	partition_fstype=$(get_fstype "${1}")
> +	# reduce the filesystem and partition by 32M to fit the LUKS header
>  	reduce_device_size=32768
> -	reduced_size="$(expr "$part_size_blocks" - 65536 )"
> -	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
> -	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	reduce_device_size_blocks="$(expr "$reduce_device_size" \* 2)" # 512 byte blocks
> +	reduced_size="$(expr "$part_size_blocks" - "$reduce_device_size_blocks" )"
> +	reduced_size_in_kb="$(expr "$reduced_size" / 2)" # blocksize 512 byte
>  	case $partition_fstype in
>  	ext*)
>  		# reduce the filesystem and partition by 32M to fit the LUKS header
> @@ -84,9 +87,31 @@ EOF
>  		if ! cryptsetup luksUUID "$1" &> /dev/null; then
>  			e2fsck -p -f "$1"
>  		fi
> -		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> +		# shrink partition temporarily to minimum
> +		min_size_fsblocks="$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
> +		if [ "$FAST_REENCRYPTION" = "1" ] && loop_device="$("$LOSETUP_PATH" -f)" && [ -n "$min_size_fsblocks" ]; then
> +			# set encrypted size for expanding step
> +			encrypted_size_in_kb="$reduced_size_in_kb"
> +			# minimum partition size
> +			min_size_in_kb="$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 byte
> +			# shrinked partition size (reduce_size + minimum partition size)
> +			reduced_size_in_kb="$(expr "$reduce_device_size" + "$min_size_in_kb")"
> +			# set loop device as reencrypt device
> +			reencrypt_device="$loop_device"
> +		else
> +			# continue with default reencryption in failure case
> +			FAST_REENCRYPTION="0"
> +		fi
> +
> +		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
>  			panic "reencryption of filesystem $1 cannot continue!"
>  		fi
> +
> +		if [ "$FAST_REENCRYPTION" = "1" ]; then
> +			# use temporarily loop device to simulate shrinked device
> +			# because cryptsetup uses device size at reducing
> +			"$LOSETUP_PATH" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1"
> +		fi
>  		;;
>  	squashfs|swap|"")
>  		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
> @@ -96,9 +121,14 @@ EOF
>  		;;
>  	esac
>  	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>  	else
> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
> +	fi
> +
> +	if [ "$FAST_REENCRYPTION" = "1" ]; then
> +		# remove temporarily loop device
> +		"$LOSETUP_PATH" -d "$loop_device"
>  	fi
>  }
>  for candidate in /dev/tpm*; do
> @@ -182,6 +212,12 @@ for partition_set in $partition_sets; do
>  			reencrypt_existing_partition "$part_device" "$tmp_key"
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +			if [ "$FAST_REENCRYPTION" = "1" ]; then
> +				# expand encrypted partition to maximum
> +				/usr/sbin/cryptsetup resize "$decrypted_part"
> +				# expand filesystem within encrypted layer to maximum
> +				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
> +			fi
>  			log_end_msg
>  		;;
>  		"format")
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 1679133..76ce72c 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -59,6 +59,10 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  # Path to full (non-busybox) losetup binary
>  CRYPT_LOSETUP_PATH ??= "/usr/local/sbin/losetup"
> +# Fast reencryption state
> +# It uses temporary partition resize,
> +# consider security and data reliablity aspects when enabling
> +CRYPT_FAST_REENCRYPTION ??= "0"
>  # Timeout for creating / re-encrypting partitions on first boot
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions
> @@ -70,7 +74,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> -    CRYPT_LOSETUP_PATH \
> +    CRYPT_LOSETUP_PATH CRYPT_FAST_REENCRYPTION \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  

-- 
Siemens AG, Technology
Linux Expert Center


