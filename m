Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B33C61DC2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 07:51:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7430.1787730689853483514
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 00:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ysfzk67m;
 spf=pass (domain: siemens.com, ip: 52.101.69.49, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejIy31EZoYU6SyY13NGToTop74DGNzAOQvUn9u5kD+6CnABjNT60ezcZUWmxcLOTsH9IgCF7gFDWXI4r9o3K+P8pHl0tigB/1ICG5JryKcejqI9aYGDQBeKVZYrXI0exXRXVDUfmL0K0zgjisQIaqDhELb65hQODOcsV4F3J7grAjnC2XqzoJsiYm7AQcByhI313XhKmNQo5dYQBmXw5gpeNnURDh/agaOjne2ie5H36LNQ+d0rwpnrUykrzYtATqCK4WI0fQbP4rCAnwldoJpnVZSu4kCxYCDlmxxPa3/m3YgIzhnMoNxe4JjFaOV6fDI6KIowauP+g3ByJbaq5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc8NKWJ+xz843WZHLpbyFb1cmSAD87NgcyYyiYRVyjA=;
 b=IlDGsRvMavfSUenuzS86oZnLNU43Bz1ljLT/OqqsCS4qpy414kNl++7g5Q5Z+8Rzf1Yg0GkocrvTsc1To3+Z8Mxz8/qAQwZY3VmScXyWwRMhTBIw4+jgST1nFOyDVZ6A+N6Wi27se8HdCdMdQoRsP+zRBv4Glv4Drd/uIMFqPKSFfhaV0Op5h1iMLV9ChxrlT+UA9joUgYzma6IuDIL04hJNF+duF28VExXCbQBdmE0MXQutug1dWngoea0sb8SJ364fjpfM+sDGk/+sGlronW1XVQB/Pz5QjB65DOX1dwYwD9mZe1Y8cx5VBhm/RRYuhaeeENKAHF6SFrchcOZmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc8NKWJ+xz843WZHLpbyFb1cmSAD87NgcyYyiYRVyjA=;
 b=Ysfzk67mTnh+t12zyhLi59Ey7jSKBPC7a2Ab6swKxI/0ZlZpOE06+49iGiv5+egND3ftQImf6gs8k3GQ6iJTjLTqLW5Uc2rdO8lyIdZTfbI8wCYoM1uF4V68iyFdCEYnC14+9vAsq5YuJdCl6VDnKof0nzj+L6YEmDBf9tXPWx2HHdk9LuF6Iq3r3qccBq8eU+UNMa0un6zPO4iUNOFQ5FvN8caxV0YBbzwMtywBV2S+amjVniCLqTulLoiNvKv1xjCNrpeJS4O8F6kwszgV5aKUAYxbt3NScI7pjiDddVBYlu5jOW+rFw+XPiq044OflDJALqF5rJGpWlBBfeqm6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by AM0PR10MB3171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 07:51:25 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 07:51:25 +0000
Message-ID: <12c4eff1-4a75-47ad-b5e5-6ac08dee982b@siemens.com>
Date: Wed, 26 Aug 2026 09:51:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/7] cip-initramfs-functions: Add
 secure_boot_enabled helper
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
 <d55b05021ce583596d62e15daa1beddd6a32a242.1787722904.git.jan.kiszka@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <d55b05021ce583596d62e15daa1beddd6a32a242.1787722904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::7) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|AM0PR10MB3171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4e1a67-0af0-4f19-19e4-08df0346d439
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|6133799003|55112099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	gKLZbZPgTshAaqxPtKlMlbhz9TTSacOO14uXw+fQwb2aUQ+tWjakOTGI9PQwym5jLI5s7C6MyFPZyIKVtarXPapVoQ1xkMVul1rif/OUCVrh6Q6JwJmtAYMM0om8U1+P2KuQqu62B5RCha9c59dPivfSDhfjzMDsE7vxC0H99Md1+FswCnsJRLKv3MuOTVwLYiObi9DsJQ8BCvmG2VUYmCqlhHZdMZ7V2zvWdipKiiGLKeARt6AD0gGcaj18mQQGVRj9yFXKCnvVfIezWWSs+bmjGvqw81GW1nNKujtjXr6c6u/wldiSJ7PxnNnRV2xMsa0mmHg8WZEOn06+YbqELAiPLJuT+VV4preHssqPYSlMkD9nHjn24VNZKGKANfIBaxehLIWqQxwbT9UCSdWY3JFoZdBibnHS2vox4S24E6l6pQ1qkzkQnpO+itrc1EjrQOWMKEFwanV2GU6YfNpvbR57z1daStHiGqfpVmcpqetoQ9fDN9isFkFDx8cBjdFsZs58khxgP3CpzSzroVCNxXqSz0msGoVK/V3w/ecvvz7ghjBlyitrWlpGNTWyBmdMLJrl5a0T/CaemtxrlVFpPni6Kz0o0JrPslyZWhpLocNWBL4VAZgfIvvXO57jq4NVTGbfdj4RIfpz6JdiOFvFHDBfnOXo/GEK73o/8cs2t2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmExT05vTnRwTTZNZDdYSUVMMW1vbnJ1REpyRVBHQkxTazFNU3JvQmJvdWN6?=
 =?utf-8?B?Uk1FNWY4eUtLU0V3UkxHbzBHT3BKTW1SOVVhQXVJV1p0VEFTZ2NCSm5keStw?=
 =?utf-8?B?WFA1ZDVsYUtjVkJaZXJEK0lBVDVUUlZKeHZGZklaM2xoOVY2Z0xvbUJxTEN2?=
 =?utf-8?B?cGRicm5MZXBobno5cnRJV2NtdHF0T2VHM0c0QWdTZ0dPaEZUeDhQRElWL0Fy?=
 =?utf-8?B?S2pYOWZWTzVHMU9ObVpsdngrL0V5WUF5WTlQcXAwU0xPSlJxK2NjQ0pKRlZz?=
 =?utf-8?B?WE05M2drRUl4ZjVxVG9Fb214SnY1bVljNkEvb2U1eVh4aTI2SnJ0amU3ZXJ3?=
 =?utf-8?B?SlZoNFptNkFJTys0UlhkcVdBTGdNbG5UWDh6aFJRR3FjbW92eGlZVkVDMnRW?=
 =?utf-8?B?VU4ySHRxVzRFUDRYRXZqS1o0YTQrbGtQWU9hdnovbHVBdmVKNmpaNFZiaVd0?=
 =?utf-8?B?ODJnNjNXejhqa3ZPTDhQQ0hUalFGdFREaDJSSFlSbjRVMFdOdFJnZmRsMHBP?=
 =?utf-8?B?UTdwaVFNbytZMHZ3cWJmQzFGdmNGZE9oVTZYVHZoMjFGc1l6TmxJYWdKOVd5?=
 =?utf-8?B?Z1JhVjVtWG5zcFFxT3FmcTROelZUYlU1WmN3aEFqYURHZU5yaUptN1owR2FE?=
 =?utf-8?B?RitocmdKdGRzQ0RuM0haWHRJMmJ1enZwZ09OSjFDNHNNYmZRNm5YTDFGK3Iv?=
 =?utf-8?B?WlVCREFmZHFnSml0MmV3RXRjcEwyVkZnOVdpeWVKL0Rta2wzd05BdUlNTUpQ?=
 =?utf-8?B?d1RnbjhrSnNBejBCUzJFb0FjWkl0ZzFjWEFTZkxGek4yb1lKOTdWZ0lOTVQw?=
 =?utf-8?B?NG0wMkkzZm1sZ1d1SHMwQmdhN0RnWTEzMEkvWEw4UDRxL1ZuZy9RZDNmaFpk?=
 =?utf-8?B?NW9seE5BaUZnYVdFdkFuNVE1b083dURtcHA1RE1HOU5kbTMrZ1NVVnJENkRF?=
 =?utf-8?B?TWNCbi9hcHYzNUtCUDVzNjVhVGFqTTh6SHU5S3ptVkZWM3VqWlQ2dW9qMDJx?=
 =?utf-8?B?RkRzTFpFUnp3WENYcUY3SlI0SE1RVzVNVk1IV0lDNDhyRS9hZ0lVSVQ3TURn?=
 =?utf-8?B?TGd6a01tR25pU21zZkJ3b3dDNDF3MTJRaldaNWcvcVA2ZS90Q3B2R0ExSWdO?=
 =?utf-8?B?TTNJN055RWw3Rms4bHRTSS9WOEx6U1VYSWo4c1BkNW40L2JwcDVTREhlaHll?=
 =?utf-8?B?R3JWK2dEdnJoalBqY2Vmd2k3TnZPcmZDYU4wdHVJRm4wd2RpakFvbUZVSWk0?=
 =?utf-8?B?NmZlSWpWSVNpVkwvb1gxN3ZZV3p3UjFxeG9BelBiazFNaVF0WFczSGtuS01V?=
 =?utf-8?B?M3Qzd2Q1NkpVUzdGSnRMWjhmMXcyZjUybUI4eEFRcFl2WHNmYVNGL1Y1Nkt5?=
 =?utf-8?B?MDVQMFovKzA0RUFVMWExRDlPSmtRdEpicmpZTUFIQ0tRbTUvZ0s0WVVhMzEr?=
 =?utf-8?B?OGpEdkM0VkpnbWR2d2EvT1pRSXhTWmJOWFd4QnlRRXdWa1c5UnRkZytvTjFY?=
 =?utf-8?B?aFp3RjJZc1JWWm1IQWJkQThYa2ZhZEpLTXYyVjFzNytzMFdtUVFMWWVVYzBM?=
 =?utf-8?B?b3I2VitLMGRJNFdWTFNiSzBuMGdOK3NpaWVMOXptejIyN00walZlbFp2V0oy?=
 =?utf-8?B?QUxEMzg1VWZMaVUraElDL0cxWW5uRnFkVkhWOFB6SVVOLzhYbXh1VzNMdDRQ?=
 =?utf-8?B?V0JxR2x0QTVZK3ZmMU9TNnhPRVRZRFA4Tm0rc0ZoRHRZZFdYWGFlaXIxVWlX?=
 =?utf-8?B?RVlhWjczTDc0SDcyWDJ1VXZCTGp0U2N2OUJmOExFeDlmRzJ5RFBUOXo2aXdv?=
 =?utf-8?B?andiMkdpc1l6UlNGZ0F4aVgvZUVkb0tzS0MzNGdLTHJoR1hqNlFuVUNJbitK?=
 =?utf-8?B?MjRkdzJLS3BtamRLa21ITXcveDNneExTRU9HcHd1TS8zcmtJWkNwaHEzZy9U?=
 =?utf-8?B?TG0vOFMwaWQwS082YzYxTmZ5YlJqdHdjVmE4TEtsS2g0UTZhc1N0RHV5OEdp?=
 =?utf-8?B?ZUNsY0QvZHhnbklPR3NDNWh2ampOa3VxcHZHL2x6cFhyc1JKWk9IZk84ejhx?=
 =?utf-8?B?eW00YUhrd0ozbURyRVo0TzdoSGpUSVJqQ1ZQNERmTThrYjJZUHQvSmU4SUNI?=
 =?utf-8?B?UkwwdHhGUEVMZnBQNk4rakNzOWVXS2tMajJoam1hNkI5VStaNFBFaG9oRTNr?=
 =?utf-8?B?K1ptWGthQWxKNUxvVU00VkxPaUdIeUVOdzhpSjJpNCtVS0NjRE1VdGIzL09n?=
 =?utf-8?B?QkxHRmh3WGFTVWVXUk45UEVFNDhqMWNycFYzTmJGK3hlSjhJRlFNdzc5aTFv?=
 =?utf-8?B?ZjhtL0wzbzdWQzRFMXVnWS9mSjBCTWJVekcwVmxOVnJ4bGNwT2tXNEgvMERJ?=
 =?utf-8?Q?dRgtkZEXPAwMi0yg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4e1a67-0af0-4f19-19e4-08df0346d439
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 07:51:25.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ66FfqcZOwQNfOmTaURD1NTgqwv8VvLGfDmDWxT9mxG6Nr+99gp498T2R/G8FEhnlGKShuPP2t6yrMoDrtnQLHK9ipsFiTCZX5M2Q3skbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3171
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 07:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24014



Am 26.08.2026 um 07:41 schrieb Jan Kiszka:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Will allow initramfs hooks to determine whether UEFI secure boot is
> enabled. The user is responsible for deploying cmp and mountpoint
> binaries into the initramfs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   .../files/cip-initramfs-functions                | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> index a4c1fed6..f14956d5 100644
> --- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> @@ -68,3 +68,19 @@ scan_for_partitions() {
>       fi
>       return 1
>   }
> +
> +# check if system was securely booted via UEFI
> +secure_boot_enabled() {
> +    efivars=/sys/firmware/efi/efivars
> +    if ! mountpoint -q $efivars; then
> +        mount -t efivarfs none $efivars
> +    fi
> +
> +    secure_boot="$efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> +    setup_mode="$efivars/SetupMode-8be4df61-93ca-11d2-aa0d-00e098032b8c"
> +    if printf '\001' | cmp -s -i 4:0 $secure_boot &&
> +       printf '\000' | cmp -s -i 4:0 $setup_mode; then
What about audit mode?

> +        return 0
> +    fi
> +    return 1
> +}

BR Alexander

