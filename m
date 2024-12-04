Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0383E7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 08:19:22 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.40])
 by mx.groups.io with SMTP id smtpd.web11.9212.1733300359246358530
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Dec 2024 00:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=roWKUctO;
 spf=pass (domain: siemens.com, ip: 40.107.241.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhtnQnLgxRWsFhtkrP5BtO+gMGVJnWlbFPp/8+nfFbPfz7waTpLTfSstla/tF2vLd841pLy1whs98LrLGsxJvYoaouafGDkEFbpGzlv/VMBGx5plTJY748t2Gs2p+Jab4I+mgNgEodFqgPpwUmeY+4NU/HASrMK4eX4lfQvAqZp8kCiRzNAfQccdOwei4cXDp652vIk4z0g4FPsBBWTsfPqkdVUafsb7AYwWuY88ULz3Na2EG9wEquF/TTxYMs+4dqqFNdA5gCGBO/lVIisPS0F+rSFWqACePQUY0rAgim4ItWVQsj/WA+Mt/bnTB07MNICGtPQB74vn9D+P7btOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyAv4W+0acGIIArWBaTpU5ElgOo9lTa0RK2LuJl5oLw=;
 b=XJmbfZYFnU8kT0UW97m1VeRbVSkLrH2sl8tT4X2/R/9N8Wpr2LP0TnBMGtNesf7E/5bD1nfq8edFMuUAObXNSO6LkijT58nBXSBOAkBny7wn1kt0lFmol9vTHzwfV38SqDwfLesUWnBg9mGKm4Vi1WOc2Ntc8p3ea/xN4aUOBmOCs9ourMtdmVgPy2/YPtG+AIlGeBhIORTmD5PzHk+TsveWi25xZ/VLphGod+qM2RHmDN3htHg7cWcQqmhhIYe+C4kV9NUzN7rgb9U1S+dIp3Q0nyw0wUfQhSMdDd7mCrizxpyselwlJZ4f3t0PUyAa1sOBngOcpD54ENn01gXOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyAv4W+0acGIIArWBaTpU5ElgOo9lTa0RK2LuJl5oLw=;
 b=roWKUctO6ZTa4vJbxB8rj0OVbz0M5I58T99d8mZrTsOV9fFUjYfRZWSTPS6qZ9W0t6UjOHAvC6HgS1veUd5XWr8hcQO/94iEzmSb657XZJFWHu8q4mE9Kv86hEULZxe7BDi1SnVJH43unwG036rmbRb3s/HBprXLjYWBc0Q5s4x8CeNNv4chX+ZiEFdyu07ymIj4pQc7C85ioQGbW6Xg4TzqZZ2XvgaSsFy1XZcz6+vwY3cJivNVSOTgcirVADlV3B4Kw6K4GNs6a0zAA5RNUuV762p7vZE3cQ8AxunGRi6nW2/rOP9Dg9QrY6lkLyBuvyd17V1+cU8voe9mybETIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.9; Wed, 4 Dec
 2024 08:19:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 08:19:15 +0000
Message-ID: <c7636d57-2406-4d87-a46d-10d2150adf18@siemens.com>
Date: Wed, 4 Dec 2024 09:19:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-initramfs: remove redundant
 initramfs-tools DEBIAN_DEPENDS
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <20241203070034.1124199-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241203070034.1124199-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: a38d79f7-95cd-49c8-86ab-08dd143c578f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bGVLdE14STJRWHJ2ZXlYaUg2Y2QvUjc4d1kzejdqRllYb25FbnpmL3hrYUk4?=
 =?utf-8?B?SmgxSTVNK3NKTUk1aEUra1JnZXYxWTBGZEZjb0J4KzB6MXRVY0VBNGJsNUJo?=
 =?utf-8?B?cElnYk93eUFYMGlpZE4zeUlxVVVQUk5QaFVicStSSmtPMVBUQ3E1bldLYS9r?=
 =?utf-8?B?OHIvbGJQdURnSFlFVmI0cnBTNHNmaHMxUU1jREUzUHJmTXNmQ1haRENqVHJm?=
 =?utf-8?B?b0dlMyswd0IweHFOUFEwaG8wYStDK0NiVUh2QUpHTGhJdEFOMGprM0NBdlQx?=
 =?utf-8?B?VC9qNWRRQm5lQmxJc3R0a1U1Ym5iMC82L0RnNUNqVSs4NGVBUU8ySXRpZ0dC?=
 =?utf-8?B?OFN0bGZYMGp5ZS9YM0RxaE9PbXVxUENObnJUMU84RTU0b1p2L0k5d2RLZThN?=
 =?utf-8?B?QXJzWEk2VWJrMlFiL0gvTTZzUEh5dHhJRlBOdHpzQnRFUjg0Q2MvaTNDUEFl?=
 =?utf-8?B?TzR3SFBZbzAwL3I0ZFZFc0JvaTA2bC9kZFNZV2d5ck5NdXRybHVqcXNaS2w0?=
 =?utf-8?B?WFArajdqVWV2QmMvSExmNEJTUkpnKzhaYWRoQnZ6SmFVeEJyUk9sRVhSbVpV?=
 =?utf-8?B?OTJKVzljcFgwc2FiWDUyUGhibG9FWXlyc21WZWhpUjVBWWozUkVUbEhrN3hD?=
 =?utf-8?B?aGRNSDllKzlsYmJDd3lmL0w4Sml1MExSRVVOWHBUdWxLU0NUQys3NnB3cmRx?=
 =?utf-8?B?QTlaLzJDVitUNUlGU21TdW11WHNNSk8yVTlFTXR0VE9vL0UyeHJEdEpsN1NH?=
 =?utf-8?B?ZzBnVW5WVGNFRFpyb2lQQzlXRngrcWIwbmMxdEhFUEFnZzc5SzBGYjFXaXJt?=
 =?utf-8?B?TzN6RzBQaWhVdzFDRmhVSDRxdmE4YnVTSkRKeHh0amN4THN1YjRFNmtsWnl5?=
 =?utf-8?B?V3lSZzFxVGI0SFpvRGNzc3NNejFuU1Y5N0VLcnVCaG40WFFIZ0hPc1dQQzMx?=
 =?utf-8?B?ejI3SGFhNGRVck11NGZWbFFROEZJRHNmbVFWZkZCUnhlaFR2Ymlrdk5RTEhQ?=
 =?utf-8?B?a0JOcUxGQ2NaY1NXNFdBTDdDa1A2MUVqQmJyeSsrZWpLcnkwSXpqNmt3a0Rm?=
 =?utf-8?B?Y3o3WVRjdEtGN0IyYTdjd1FuVkp0cDUxSk1KSlRvSVdzdnYvTFN2Ny9YRVRo?=
 =?utf-8?B?d04zUDNnRW1ZcGtqSElMLy9LQUNCcHdHaFJDcDNlQ3pNejNKZi9tTnN0a0Q3?=
 =?utf-8?B?VWxzbWVHb0poSVM5RE1IUVFhdGpMN0ZFVXlERG1IWEgzZ1d5M2hBcmZIaGNw?=
 =?utf-8?B?Ui9WanQyMERCcTlwazhvV01pL0NJNTFORHlSZ051OEJaTldEYmdJdENHMFk2?=
 =?utf-8?B?cGtobE1OWXBlVVQyQkYzT1lQZFlnSmNCYzVXY00wdnNCalhKM0NYV1FLT1E1?=
 =?utf-8?B?bHM1VkR5OFlaRnBweXJGM3QxM250eTY1dE4xMUU0cjR5YTliUUVLcFFZUGdv?=
 =?utf-8?B?QlNLMTBNZXhTZ2RzQkVOY1lQS2ZoNWdRNUxMdnI1cDVhZE00R2dtYVdtbXpy?=
 =?utf-8?B?L3NxYkNqWFk0M0ZoZ0NoMmJwOVJndU9mVWFnam8xVDJXNlNWYzlia1dERzRm?=
 =?utf-8?B?eTFNWi9yaEk4VGNaSTlSNFdNcU9QQXlGcFpGZE80QlRRbDYyVEpaVDJwMmVL?=
 =?utf-8?B?STExaDZPWjIxZkpUR29BQWpPTzM5L2ZjOTRIWkY1QTkzUzR2Z3pvS0dwRk96?=
 =?utf-8?B?K3BoWlZVRm1maS9qTmREcW1BODYvRk5yYWl1SmRYdjR2QzJ2YmpqRUFQVDVv?=
 =?utf-8?B?cTdIUkJEOUYvL3JnendkNFNTd09zdFNucmMwMjFEMzdHbFl3N0QrbldxQ3lO?=
 =?utf-8?B?NlBTSWFVbHdiekx6cDVPdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmRTQlc3a2NiaWltV0hxMVVkam9sMk5MaGlpdE00ZXdmbUJ5MzIxU1BpbDFj?=
 =?utf-8?B?TTJiSm5vZWMyamhYRDVudXM0RUR1MllmQzJqK2NUYm5ZWUdTN1pRcm1oenB3?=
 =?utf-8?B?c3J6NTNkdWN1T2lSOEYzRlg0M2R1S0YvY0FqYmIrRnJiR1FkSnlBUEdTWFY5?=
 =?utf-8?B?VVZwZTFsQldtSzVuOVdqOE4wbkhnZDQ1dHY3WW50MlZYV2ozOUc4T2hzVkhx?=
 =?utf-8?B?S2FicFVZcWVJLytEeVJlSHFQSFF6NWVhOXBNUzNIMlFvbWVGdUR4MXdCdUdy?=
 =?utf-8?B?Q0JBNUp1WjVXK25UNk84cEQ3cWowK01qRDdNSjdvendjK2V1c3ltNVg1K3Z4?=
 =?utf-8?B?NFhwSk1ESUNQRWNaazZueVZFUWdhRHNUYnR1QUdWbWVYQmNnbnYwOWtkRTlB?=
 =?utf-8?B?QSsyb3B5Y05vN0NSVHBHUDI3Y3RxNHhtbnRESmhENkVZRTdjK1cwR0MzY0lE?=
 =?utf-8?B?UHlrbDhsejVPUW56T21kbEtXUytWWnJTWlZGazVybk9zVmVsL0ZFUUUwOVlN?=
 =?utf-8?B?aHdINHNrSHlTUEcwUFpLU0d2SUNPdlNkcEVzS0tYOWxvVFZtUkRweWgramd2?=
 =?utf-8?B?NmQ5YWg0enNzZWZoMEVaNWxZYW9xT2RMSGpJYWw5dWFtM1RCKzl0SFAyU1M1?=
 =?utf-8?B?UFJZYy90TWZRWEVDYmV2ZGNjVm41djNpSkRsTWxUd1NEaURUa21BQmlSRE9r?=
 =?utf-8?B?YmJiYkNkQ3g0LytJOTZBa2tCL0pUVmd1Wi9QeS9XY0JDd0VvTUp3cDZUekxk?=
 =?utf-8?B?Z2pMNjJtK3ArL2hXQm55THhWV0lZZGtiRlUxNE5uOXNFZHdsQ25aZW9rNitu?=
 =?utf-8?B?dDJGZFlhcnBjS2xPdXpoUWxib1BJWXV3SXhaaXhCWWhNSElJMVgvWlM0enNq?=
 =?utf-8?B?MVVDQW1KeDVQZzlYcUcwUUh2VlVXY1NLU0w5Slp5RVlSbWpJcGRQeW44alo4?=
 =?utf-8?B?TWhRVUZ0UVJoaGgyend6K1NINXdvZmRMdTVSeXBOQ0NPaCtjdGp5Qk9RWVAv?=
 =?utf-8?B?ek9NeHd2ZEZYTTY0TXFIM3g5K0dyWUloeHF3bmNZd2xPQzhETVFsS1dncHZj?=
 =?utf-8?B?TXNDNHgvcmRlaG9RUVlKTzYzL0xtbkJZZ0lhTjdrYlliQm9VbkN5WWJMVWpm?=
 =?utf-8?B?NDAwM1lWemRjK2cvc3owcUliQTZCejZzd3FIK0l5ZUxERHlqRUVOYVBxelJP?=
 =?utf-8?B?K09XbFk4T21EeGhTYTBMZDdjY3NhaFFHRVYyWW1WRWJ5bkpPYmxja2haR2JG?=
 =?utf-8?B?MmFKNUZTcEtWZFcrK3lUM0NDV1FYcXJYYnFsWmVPcGt2UUV0dUx1SUVwajNj?=
 =?utf-8?B?TVlTdXRLc21Pc044K0wxaDU4YXQvL0Z4NmxZdldHRGlGRGRYUytQR3B2TlpJ?=
 =?utf-8?B?S05ycTdEeXBnakVBdFg3ZDNJeGFSelRlaGZLYWUxME9aU001clJRaUxCQU9z?=
 =?utf-8?B?VVM3Titwd1luYS9uQzZJVHFqWjdWZG51QW5XK0R4MVhEeDVPV1ZIcjd5bXF4?=
 =?utf-8?B?S0orWmsvVkZxRXZ0RGNyNUNqU29OMzNtUklRRzdzWjliUE9TMFQzTjhmbFBT?=
 =?utf-8?B?M1lFNktpTXIxNzZUZjJVUDVINjA0dW9HajlOT0RCRWFIbTFUY1J6bUs4OTVF?=
 =?utf-8?B?M0liS3RNdXpqZE14MTZsSURwc2JMSFdyU1ZkTWhlbHBnVVlpS1hMMXl0ajZQ?=
 =?utf-8?B?TkFxY3E5OUdxOUJXTzcyOFRVdGpWajFBUVVoRDhXOElZTFZER1pYN0oyWkVH?=
 =?utf-8?B?ZHhCTkUwQjNIaW1CV2R0c0I4RWNKWW5zbmZ4UzhRVkZSeE1PcExWR2RPalI0?=
 =?utf-8?B?ZWpJMkRZM2ZYbkVzK3krb2Ztd2tkbnVDd1h5a2FjYUJWd3N4U0FKcitLWXNJ?=
 =?utf-8?B?Y2l1UW9MajBWNUc2c1pFOUJORzdxMTRqblhFQWRPVlA4ZjBTSGRmU3RhWk9o?=
 =?utf-8?B?L0lDdHpyU2grQklUSGM0OUNNVDhYT0lEczJmZ25kcXNXTTJkNi9NWW53RDhw?=
 =?utf-8?B?Q2lxMVJpcTZ4eE9iVnUwTlVGTW5LMDJ6WnFybmM0QS9CM2hscWxDRXEwMS9S?=
 =?utf-8?B?aHBzdWxYbmpoam1MZ0thOGVOU3BYRVNVdUdnOFNnbHF3cXBYMmxIR1dwdHFa?=
 =?utf-8?B?bXRQNzBIWjZGeXA1dmxDZC9IT0hEaUtHR2o0cHY1TG52TTRqd3Y2MStLbXJa?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38d79f7-95cd-49c8-86ab-08dd143c578f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:19:15.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMhpduIV8RTE/stPiQNW/eV0LHBFrvSJCamdrYlMQQDIbxe74pBN73ON4GXp1mkY4QgR6+qkuT2eNGVBUBxs3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Dec 2024 08:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17325

On 03.12.24 08:00, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> With the inclusion of hook.inc in the initramfs recipes, the initramfs-tools
> defined in the DEBIAN_DEPENDS, hence no need to add it externally in the recipes,
> just cleaned that.
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 +-
>  .../initramfs-verity-hook/initramfs-verity-hook_0.2.bb          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> index e6ac1e9..a9e4ca2 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> @@ -40,7 +40,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_MOUNT_OPTION \
>      INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>  
> -DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
> +DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>  
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_ADD_EXECS = "mountpoint awk e2fsck mke2fs"
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
> index d8f62bb..a6c4666 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
> @@ -21,7 +21,7 @@ VERITY_BEHAVIOR_ON_CORRUPTION ?= "--restart-on-corruption"
>  TEMPLATE_FILES += "local-top-complete.tmpl"
>  TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
>  
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
> +DEBIAN_DEPENDS .= ", cryptsetup"
>  DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
>  
>  HOOK_ADD_MODULES = "dm_mod dm_verity"

Thanks, good catches, missed during refactoring. Applied on top of the
current patches as these are "just" cleanups, not fixes.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

