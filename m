Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E3C54F94
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:41:36 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.54])
 by mx.groups.io with SMTP id smtpd.web11.14767.1700059295521061354
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:41:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UHrJDRhZ;
 spf=pass (domain: siemens.com, ip: 40.107.14.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0e9x2SVVHRvTAi5feEA5XAL/iUExYOSVHhattk9TAkc7uPQLIZfRdy6yGtpeWgDWJvV2jx4OoPnoNzo/t1oJ46oIVHt2ONh4d8FvcATsZibrg+OdNJGWxI07UZ2neLhrUlea/K/ag3bzucoOkqpYOlDfZOLV5uXoEgKTEMj8fJp39Ew+YYqllzweVz5XbHLLPxF7xTG8QI7kcsbr1wVhb9xTADLB4udWnRlw6cx6ZKaaQZOIgaZGBWfrqSvYvyBVC6168Dsb0Vlvo0G+ScQCyfqAsngiZd83H/CLn6+PZktVpWUe2Hj068fdZsxdHZCq3ZcxjRWdTvOo7oiXo7wgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRUPaRxsyU4kfgkYT+4B+AxPrP2iyrHboopr+FZEmho=;
 b=ZcDxFZmMUqnkVWa6lJXcqbCu1xwSCkfskRP42xtTskkePtSJqCOnsHVzpIhFP99ZutfTObSVRxfL5t3XYe+7oQyPK4rfVfaNt3E+ImgfiH45FoL3ZEpVIs0Tt5VP7e0RtzhieXu40Rf1Vi9xU2qk7JF77pF0Oxqz730RztCnXu0Q3wQelDVSJPlQMdiWMlRBFSx2UEjUhdYCZgHDg9RxbfBK/QxNWuwIGhqnHjGQK//XWx3TiyXw1hAmh1Hin6ka+DjUg0LM1AWBhFfsK4ePY5fYl7CFrD61OQYAkHNxePIMYPjQ2Qc65OPmhfo16U/pjK4n0nMHwrfFsKswJZ57fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRUPaRxsyU4kfgkYT+4B+AxPrP2iyrHboopr+FZEmho=;
 b=UHrJDRhZYW8gyiNgJX0Ii8G7OaXoKPKX475Y/WWYmkYIjKKiEmcOYrREKIMysfb6Y3+KTGSYQWMTrdHSbbYeGDFSJEwM6Z+E0OMUTBucL+09ECMds6s/LwBaodaC+ESHWy+azRZiRRpaiG5kXf07aUtvHdhjWLzA0iV98rAQ5j+R7CxjKSuQNHhp192zR5Rbfm4B5W9q/s35/6WJ8+CMIPH/YRVVQlY0crwo5+7c2gtvBt/4LN2VdKIzyrOmtOhAlvpUQ/lTTtQhAPAkVDaddCP2JzNIBUvFbQa9ap4u784cejlq9AEzzLGp3Rqc2ybVK7GBXwfv6qzjBI+qZfFSHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 14:41:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 14:41:31 +0000
Message-ID: <dd0345ed-759a-49fc-84c7-81c76df292a3@siemens.com>
Date: Wed, 15 Nov 2023 15:41:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] added configurable pcr_bank for clevis
Content-Language: en-US
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <DU0PR10MB68986B841B1C6F0F8FA701E2F0B2A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU0PR10MB68986B841B1C6F0F8FA701E2F0B2A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: c160770b-6e5e-4785-d94a-08dbe5e8f567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aDt3ygcfHqiZVYa9/U7hBXuriesO1XJRuWERna8tTFPlU7drzkfX4I2x6DlMcKPnmSSgp+hlZ1dKm1G/4sZ2q3JxKdrk1WYGoo1DJwnnysucyOYgIFJ3/wt4jkkdOYy2F9ZTwEJruTIRynx3trStDw6U2NVIuvwQZkfJrgX+H15MSBNsMIXbJShJruoSCrjlPE9HJZOFo/9EiGVYli1/E+eEA+e2MabnflYQJzEuXeikqKvE7NDbSGW5ox0B/+ZlostF+Hi6fh0VnNQ4DcD20Nngqte6eHxnE2LGnIGCjLlHyl2dFJIw3zysTT7Vs0uS1N7/KmgHlLJ0YKvFKdOFLIUClzG4d2PWxcfFCHwki2weYDmL3i3fSAkF4J2CAB4ylcsDMVp2v3r9yqPJ2eAIqLq3XpKBJbN3nspPvYPlFrZkuOUXHhI9G9jrVIT2bh1h8Vi5Qzbx8iLWbyR7qQ1n1eMEU2Z19NO/smdxGVRaVkSKXrnHtwp+Hq7d8Z4/0qTUVXtTNsGzfwB8JgJ69eRqwZjKPoNccf2zbqkJk0oL8MWMGGm4NjKOJRqIxu9NZdVJ4LC3RQQhqRcsyHEkMhxOaRwTf1zqVOOiqLZDb4rMJpgqVF8e1Yz+sFg3wt2MkHyPrLVSd6sUwlaOY33/3esYyQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(53546011)(82960400001)(41300700001)(6512007)(6506007)(107886003)(83380400001)(26005)(2616005)(44832011)(8676002)(8936002)(4326008)(2906002)(36756003)(86362001)(31696002)(5660300002)(316002)(66946007)(110136005)(66476007)(66556008)(31686004)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0dwcHRCckgzMnBMZktVZE92eS9kWXdlR3UyNzhKbC9MakNOd09tWDRwUzlh?=
 =?utf-8?B?Qlo3b3NVdUxUVEFWRjBraEgvM1l2djZpZlpqY1BiTm1zdk1TVmd0UCtnZ25o?=
 =?utf-8?B?QlQ0cXM1emVLRHRKUlZISzIvTWRlN3ZFcUUxajJTYkY1UWZYZUlTVmF5ejdP?=
 =?utf-8?B?NG4xU216YlRVTnJSNGFwdUxMK2IrV3plNWRkdlg1clJ2RWc2dHUwejlJVnRD?=
 =?utf-8?B?elIzY29aekNkMnhLdE9hRzdPUDh5cUhLcXN5THM3Z1dWOTRsclFRRFkwZnY1?=
 =?utf-8?B?MTlEUlNlMEdZL1kwWnI5dWpBY1FCMG1zeVROek5QbDdmc2pESWk5ZFBJRVJk?=
 =?utf-8?B?eVRJSTVaSTl6dVRsY1ZibFZrbDJaVkd2TFJuY1RrZVBWK3BnV1liVjhOdysv?=
 =?utf-8?B?RHFKRkUraTM3RTZaNm9kOUZpMEp4Y1hsZ1lYVE1yaFFyb0xGZmgrQWhOa1M3?=
 =?utf-8?B?dXJ6Z0EvSkRReTNtNWNCNTZRSk5MS2Z2a3QxczZLT2tBTVZFeGtQMFIwV3JY?=
 =?utf-8?B?R2VteFNTbXYwYmN6SDhCQVJwQUxBSGMvUjl4dkRHemkyQit0SC91dSsycE93?=
 =?utf-8?B?bkRndmV3UGQrTmN4YUViT2lobXBQV1pxNU5Fa3dYUGhPWkpSeU1GL1NVR2tZ?=
 =?utf-8?B?NUZXYkNWY0xLWUlhcGw3SHZxU3BNS0hiUVNVd3N4Yk1rajhiZzVhM25saXV5?=
 =?utf-8?B?OEx5ZVJsRVgrd2QvaGtKaE9FdlFyelZPOUtEcEI0a0k2UHI5c1VzSU04dm44?=
 =?utf-8?B?N3dtVG1NS3RabVpYa3REdElkYTlKeXFPYUMrTmpFamVuaFg0dFl6aitBK0dv?=
 =?utf-8?B?ZkpGdTlIdTRLc1krSjVONGxEM0JkN2dnZDRWYVI0M2lhUFlIOHdya1c0dzhP?=
 =?utf-8?B?dDcrWnRzVUk4M0V2UytsblIxejJTNEwwdnVSTUNWZFM2MCtoU0JtOXdvODF6?=
 =?utf-8?B?NHVzTWtBTmJWd09uVzRmdTRyY0dlY3c1Zmx0eVdkbzlxb2lsZmw2dit4SFBV?=
 =?utf-8?B?NW83ZGhRN3pUbm5UeFRWUERRN1JIb3ZoZnZ0R3Qzdk1LUWZUcmFEUjB2d0No?=
 =?utf-8?B?anZZMVhyR0xxSHlEaDlVMHA0Rk45Y2pKVkd4SnZPS0dZbGZIbGp0ZWQzdExT?=
 =?utf-8?B?VzNrN09UYmw1a0YyUnFWcTNXbUhaNDVEeWNPb3VtVjVma0l4aGRtdGw3Qlcz?=
 =?utf-8?B?K1d2ZjFLMldnYVA2RVhwN0MrSnEybkVrMUFnWS9JOEM0MGF2a3VNYXIwUDZy?=
 =?utf-8?B?K0V5dzhDcWZnYUk2bGUzTFN1Nm5WcDBDKzNPdmZzOXQ1WGd5bnd0ZTJwa0FU?=
 =?utf-8?B?VHA5Snl2RnNXMUhDcG9sekdZRjY0Sjc0TEh2OVBCVFF2ai9GVzRxTHkvTGhq?=
 =?utf-8?B?NlhQWWtaOU41L2pTZXE5UGlwNUR5ZUhSWUE5c1llTlczSmtKRzFHbmdkc1lr?=
 =?utf-8?B?TTNqM1N3YWNkUStUdjdBWDF4VEt1dzZDT3hVR0JHbWc4UXhCWkdPY3ByejZW?=
 =?utf-8?B?Ynp6YU0rVGs4TFBlSGtONjZnWnFpcWZTbDROeG1qU1AyOWpvTjFLb0pCUFVS?=
 =?utf-8?B?clk4YVdBZ2tnWmNXdmYxNjN1WkU4eE9nS2l6OVVPbmNWM2dNTkQzdkhSZFI3?=
 =?utf-8?B?OEc4b0QwMzA0WW9ESGxiQ1Y1T1Fld3pld1JLMTlJNy9BVnNYWEEzckpIWi8r?=
 =?utf-8?B?U0VkSkFpWGk0dDRwMGZ1ZVBKZ2tTd1ZiekhsOW51ODFvNkNQem40V09Ec2JW?=
 =?utf-8?B?ZjhVSWJSWkI0YXV0dkxOa01lOUROWGhnU3dsN1h6Sks2NXBmVnNQMlJYeDhE?=
 =?utf-8?B?ZDYrWXU0K1phSHRVMkl0cUo4VGgvNHVRdmt5M2lwRFkyWFRoTGR3MytkWkpG?=
 =?utf-8?B?dGFMam5hWFJJeFFPUEVadTdFSHVIYXBTUU10c2VPNTcraHY2QngwdU5sMFhV?=
 =?utf-8?B?OGpzWlMxMjhXZFlpcDM2cFlMSzJPTFA3MkhIak1nRTRwTTlOSjhRNlZOT2lv?=
 =?utf-8?B?d1p0T2dyU3d1aHpaMW1DQTVyYkhyMzkwdHJxTVlPRm9IdWxKVzRWbmlQK2hT?=
 =?utf-8?B?ZC9MRUV5OEF6WnRISkVMUkt2VGxZcnUyTlp4ejkyalpQMGI0bUxqVGVDdDhG?=
 =?utf-8?Q?AzcdpOij+lbMK3DbWYtNYjlNW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c160770b-6e5e-4785-d94a-08dbe5e8f567
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:41:31.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slVal7vN0rcF7PdzuMhLSPQtoG5EmSFer5+T0NPFVZBJM4xnHHzunoDAJIZYdjmPx/iUc6s6ethiuIm7gVDVng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:41:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13584

On 14.11.23 06:01, Sari, Sercan (ADV D EU TR C&E) wrote:
> Configurable hash type for pcr_bank information. clevis will fail to encrypt data when the TPM has multiple banks, such as SHA1 and SHA256, adding the pcr_bank information resolves this issue.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.script                    | 3 ++-
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl    | 1 +
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb         | 5 ++++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 899f20e..6d8f209 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -40,6 +40,7 @@ modprobe tpm_crb
>  tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> +hash_type="$HASH_TYPE"
>  
>  if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
> @@ -61,7 +62,7 @@ open_tpm2_partition() {
>  
>  enroll_tpm2_token() {
>  	if [ -x /usr/bin/clevis ]; then
> -		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
> +		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'","pcr_ids":"7"}' < "$2"
>  	else
>  		panic "clevis not available cannot enroll tpm2 key!"
>  	fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 52dbd00..bcc57be 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -2,3 +2,4 @@ PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
> +HASH_TYPE="${CRYPT_HASH_TYPE}"
> \ No newline at end of file
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 3c3f6bb..3b2e6fa 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -37,9 +37,12 @@ CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  CRYPT_SETUP_TIMEOUT ??= "600"
>  # Watchdog to service during the initial setup of the crypto partitions
>  INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
> +# clevis needs tpm hash algorithm type
> +CRYPT_HASH_TYPE ??= "sha256"
> +
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> -    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE"
> +    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  
>  do_install[cleandirs] += " \

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


