Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7861C54E68
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:36:41 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.46])
 by mx.groups.io with SMTP id smtpd.web11.23946.1710873396287436795
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:36:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UJYPZYYe;
 spf=pass (domain: siemens.com, ip: 40.107.6.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnnsiVuYfgTIyIzGBNaSLwyNazSjS59SokylMgDerOiHlcIIF08x9AXgHT5RrvpGmEBE1bLr+sr2SLE/1l576T+9N16VHRe4+Ud7EfEnIJdvNevPfGdbSivdw5Vlcg8MoOrWDGjeh7lODg5ZFxaq/N56R8FYa/bDScom+b1ooEDgBg6cMJfchua6PsxbgkFKNek5L8VYjDVLKduE//eICtMWkd2msIekVzPSYfqKtImMRyHkA9qv0ItNiiziJ/4F06Xuupo01KZZi+JlWq9CLRidCNM26YXVhoe6lLHhhtqLooFFre6r+ZiqFF1WUtbPagbAFKSP1aaEmRKUF33cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USbFkF1KCEvsqN5KwTKuEqNe874Wq5DoZ0k2a9oT03g=;
 b=X+6sRAu62AEhYtmJI3585K2qDZP+sDF5CGchNluNC1ia1Ap7nIaxVSCAjG7BDFkMu6f/nulLYi3ngx97zqk3S0WU6cGFWRnl+pfvo2vl13ldn1+96w6SogZc5Vc6pUJw8GmCEEfQWNJRxPZVw8zoCvum8buIIo+QSWbNda803W/TCEZ9fwh1rSGKJsxuYh/5JEWCC+Sw+S4eQJW8oDp1a2cHsWixxgtchnOiujFpL0R1LFtwVGWc26RG0HPJKRM+zYV2S+P5dqVJycBe2iAcjUxXBb2XOl3URjGd5E92Dw0as4DaIvbhLQtYoXy5WGgSgwJU8UbjrfRH2Vgjp5F1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USbFkF1KCEvsqN5KwTKuEqNe874Wq5DoZ0k2a9oT03g=;
 b=UJYPZYYeBzX6xvSS7xDL9NwJo4rW/A5ZZI1pfYUITjxcSOW4tCB/c2YxgraHSrMxKN8+zZTuBVYd/g+MuRHrKo+ixDg9JYpUBzR+71AyH3DBTHitL9eNb3n0E94kcjtZNE3AKxdrhJcJyCTEoS04QhurmOA0c/6ImHH7ZM/Yhg0e2DtWxk1bmn/BPPtc0Dwpcha6nokERoc4p+Jic7r7kefPhgMo4e+TqcQjreHHsMZG77pv/cPhXWjIcd5LZlxWpS0nMMveCF2vlmas3fcEILdF/QYT9g5XQaRN0R3Ckee4trbAPSMM2Y8uYShbu+xSZOTuikAzXo/5F/PqD2m8kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 18:36:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:36:33 +0000
Message-ID: <393b19a5-432e-4ffb-a98e-eb4928f7831d@siemens.com>
Date: Tue, 19 Mar 2024 19:36:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 5/8] initramfs-crypt-hook: add flag
 to make encryption optional
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240319182026.1571362-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 774200ac-1564-477f-f975-08dc48438044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TDE58AUmsUWQfpnKWP1l9dWmr288OJVXh6BNn3ho5zuD1oKoUZhAwtTxTABEZdg4mY+CICqbNkQlagU7rYTTWF3gU66ZUg2ItCM93beFEVp/Ko9Jo8S7v3Q7yMja/c+GEI5njBDSARaocvUgCzJImfGEUcUi1oXRxiQucY9GUrhurOqUvv2yT3jeoiMFRzFpd1cTrDyJN7KeIbSOk+fe8vbM+ePZGIEFUs1AGUu107MrPrQbtyHigbv0XptboBX8v2qayVyiDNuor8ThhV1LlSlhAInMNTph1hCFbcr5+CMXDFf+CnxESuZ2K0TQLmRSZ+T1nV0R0K3DDoRG8BUgoM2rTI3MeCBsqGCLw01i8mUDMJigy3ay2cHHklyI7sVX93VXLTNniAvUNRMwKS1zok/XQOqIFyvN8qLucqdqulTDuVGd6DX5Yl3HlIqWDVitH8EQLNX7ju+HbtXaAm3WBu8mHM8atG33xnmIuuC5A4i83o4bDzEcbkg3tQF1kGh/BK9zhLuA9DyLx31ZIpSgRFNCJ0QIAdGs42n3QLAijgDSXJqsSA/9wXkaLgSft5GGjoXwk5KMTrV+f8emC7V882NaN9A03hSqfFXZvh21QTm6UuaFG58rPDjbx0JuewA8MLd8glP7JId30DtSXHNNbSF1J+oe8nZqnVf9H93g/Kw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVlyQkY1NzhCZHlkNmdXT2x1cStBWU9xSW1sS1d0OEpZZWFVUld1eGlLM1V6?=
 =?utf-8?B?NGZ2eS8yTHVETkJPcW1IR3Jnc2ZYV2pNWWJRaTlPU1ZsaFBKOVBWdGkvVWZD?=
 =?utf-8?B?WnMxQi9oY1FCMlFZOC9oRkN0U0grRGExb2xyQUlqeE5uaFVZdXZLT2lrYnZi?=
 =?utf-8?B?VDhlb0FVMlVTbFRiclFaSWF6QUU3ZlVoazcwMjc5YWp6eGNoSnlMTzZ2MGo1?=
 =?utf-8?B?MmhtbUw2bnRPbHJVMXh3RkRuUXNlaGxlQ2lHNm82a3NwWFRXTHhTNXRJSER0?=
 =?utf-8?B?OTN2dU1MWEljRkM5NFYwT09SRmkyNldma21LVVh0NUF3ckZDSlY3MDJUeUJk?=
 =?utf-8?B?TWVZelJveHgyeEhscEo3Y0RmYmFYN1grbCtQc1VNd21ESmtlMkF0SjdBMUZG?=
 =?utf-8?B?RU8wYTU0SFMrT2swM01Ya2hNaE0xRVgrY0pGcFlEeERzN1VTTlZHY1VRYkgv?=
 =?utf-8?B?QmVJK0t0SmJkRmJ4KzZyOHQ2Y211Rk8wUWh5c256Z01ldlZFU284dnBsbkRP?=
 =?utf-8?B?Y0tNZU1LbGZ1UlBuMWdPVmg3QngzM1g0RUdDdEVFMkdyTFlUbGRQeEdiVkpW?=
 =?utf-8?B?OGhpWk5ncHltLzl0QUNtNHh2SCtKRnk3amE1cURCWW1EdUpudGFQRE9wSGpq?=
 =?utf-8?B?N0U1YlBhWHkvMkFidFVaWnlhdHpvVkNqM1N1M0ZXSlJnSmlHOTZEbDFyc0Vy?=
 =?utf-8?B?V3Bjb0JSUE5WeGhxTkZVeVc4cHJNK1l6V3RFbmpYbzZYMHhhWE9CWjFLdVo4?=
 =?utf-8?B?TExQL01JMk13b21NSDJKQUlXdXRNUDk3MmxtdDRkMXFGQUl6NXkyZjRCZjdh?=
 =?utf-8?B?OVp5b1hrMldtSDZESTA3bENFTnpIRzJlbzF6QkhTUWZJZkpxelhmaXQ5eDEz?=
 =?utf-8?B?RDI1cGVBUnhQcUtQc3FPWm9VV2pvY0YyRmRqT0d4T1E1Skk5dkpmR29ncEtl?=
 =?utf-8?B?MmhTN083K0hvRWJKR3BWOSs0MjB0eDR0VEJ3YW5HcXJQNUs2SEpFM3ZyV1RN?=
 =?utf-8?B?N2hHK0puK3d6SUVUUWFneTF6ZXdJSElFNnZPYXZCK216VEJtQkoxdDVHbjlE?=
 =?utf-8?B?QTAxY0pMSjM2VzA4c1RjWnNuVDdaK0dCeVowdWc2YUM4WHNsZXhwMmpNdHd0?=
 =?utf-8?B?a29WZFNBMTVrcWZYcU1CZ1o3TndOUnZVUnJ6cFg1VUVCamdjaElCNmx0R09L?=
 =?utf-8?B?U1VxbXllaVgzQ1gyZG1YUGlZWWFsa1I5REgxODlrNHFjQmd3Sk9iU0N4QmVh?=
 =?utf-8?B?MzV0cHdyeFdDRVJHTHF5S21lVkY1c2xxMHdZYmFLUjFudVdwSHRoK2tVaUtR?=
 =?utf-8?B?TzF6MytPTUo1aFlOalRYTFRZUEZ5cWttVVhxb3FJTENZZHpLTE5McUxRODFQ?=
 =?utf-8?B?OGhXL1lEa1ZBd25CcEY5OE9DQisxOWRwSUF4UUJWL2xvdEozOTZ5QzZRNURR?=
 =?utf-8?B?Nm1ON05SUmpHSVlEeG5jRkxwOW1GL0ttRk5qeDU0Y2cwcWppRXBsaEdaRGxm?=
 =?utf-8?B?SmE3R1B4Z3ZuZEFnMUE5T1QrZFo4YnU0NVg1eERTS3NvdVhSK2xNclFkVCt4?=
 =?utf-8?B?QUhKK1Y0dWdkYmhidUVaWCtZV3VOZWZVTHVyYXdTUU9XZjFOOXMzK05FT21n?=
 =?utf-8?B?WlFveEVteExQeDlmdjVZZGpjZElZM2UyYzZRR3E4R01EQ3JsYkFXeGNZY2xj?=
 =?utf-8?B?K3FWRHFGQk1qb2NPZGZ2bXBGM1dFMThoYXhBakE1NXFFdzdiWTJtZUp0MHJq?=
 =?utf-8?B?aDIvdmxyUXFGa0RqMmU5cGNKbDgxSnllZUJ1Um1rMGJtSzc2dWFTN00wcHBs?=
 =?utf-8?B?amlKbXdnZ1NCaXV0VHNWVjg4SlVtSnpFVkl2bkRYaHFJczVOR0M3dXBLTHpN?=
 =?utf-8?B?VFNyMzBRVWZTTndNK2xBVWlYZTZXUTdkY25ta3lWaDFSQ3ZDODFXVWhUVElO?=
 =?utf-8?B?YlhyZFRMbkszekV0YmRQTHFmeEZhdVo5R3ZqSHZNdUxKK21XVEJmSS9kVWZ6?=
 =?utf-8?B?K29KUm5jRnRjOEkyRkVyR1ZLOEI0MGgrcVRhcW5QS1h6dVMwczdQYU82UU9u?=
 =?utf-8?B?THhpMVN2ZzVHMjl5eEdraCt0L3JiWVRKdlNCaUNpUW92RTdFdENsbnRDSEhY?=
 =?utf-8?B?bmRYNFA4NmM4UW5jd21GaVo3a2YxZklyaGNPZnlKczBYaXllYzJyZ2VOL3ky?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774200ac-1564-477f-f975-08dc48438044
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:36:33.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYclusJRQrWm6KI0g6euN2WljnY11hTXNnjG3kNjIxFgt1ritAHnvw7miyxlXcn98mb32Cq8tPQ3M6ZYwoBaww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:36:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15376

On 19.03.24 19:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to use same image on device without or with a disabled
> TPM.

"device with and without TPM"?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.script     | 20 +++++++++++++++++-
>  .../files/encrypt_partition.env.tmpl          |  1 +
>  .../files/encrypt_partition.systemd.script    | 21 ++++++++++++++++++-
>  .../initramfs-crypt-hook_0.1.bb               |  1 +
>  4 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index f271e85..6e2713f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -47,6 +47,7 @@ partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
>  pcr_bank_hash_type="$HASH_TYPE"
>  tpm_key_algorithm="$KEY_ALGORITHM"
> +tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
>  if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
> @@ -111,7 +112,24 @@ for candidate in /dev/tpm*; do
>  done
>  
>  if [ ! -e "$tpm_device" ]; then
> -	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +	if [ "$tpm_encryption_optional" = "true" ]; then
> +		echo "No tpm_device exists abort optional encryption"
> +		for partition_set in $partition_sets; do
> +			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
> +			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
> +			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
> +			partition=/dev/disk/by-partlabel/"$partition_label"
> +			case "${partition_format}" in
> +			"reencrypt")
> +				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
> +				;;
> +			*)
> +				echo "cannot mount partition '$partition' as it is marked for formatting."
> +			esac
> +		done
> +		exit 0
> +	fi
> +	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
>  fi
>  
>  # clevis needs /dev/fd create it in the initramfs
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 5d28dc5..bb93361 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -4,3 +4,4 @@ SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
> +ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index ea267ac..2e6691a 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -47,6 +47,7 @@ partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
>  pcr_bank_hash_type="$HASH_TYPE"
>  tpm_key_algorithm="$KEY_ALGORITHM"
> +tpm_encryption_optional="$ENCRYPTION_IS_OPTIONAL"
>  if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
> @@ -124,9 +125,27 @@ for candidate in /dev/tpm*; do
>  done
>  
>  if [ ! -e "$tpm_device" ]; then
> -	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +	if [ "$tpm_encryption_optional" = "true" ]; then
> +		echo "No tpm_device exists abort optional encryption"
> +		for partition_set in $partition_sets; do
> +			partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
> +			partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
> +			partition_format="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[3]}')"
> +			partition=/dev/disk/by-partlabel/"$partition_label"
> +			case "${partition_format}" in
> +			"reencrypt")
> +				mount_partition "$partition" "$rootmnt""$partition_mountpoint"
> +				;;
> +			*)
> +				echo "cannot mount partition '$partition' as it is marked for formatting."
> +			esac
> +		done
> +		exit 0
> +	fi
> +	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
>  fi
>  
> +

Extra newline.

>  for partition_set in $partition_sets; do
>  	partition_label="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[1]}')"
>  	partition_mountpoint="$(awk -v var="$partition_set" 'BEGIN{split(var,a,":"); print a[2]}')"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 7f732cf..54c91fd 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -50,6 +50,7 @@ INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
>  # clevis needs tpm hash algorithm type
>  CRYPT_HASH_TYPE ??= "sha256"
>  CRYPT_KEY_ALGORITHM ??= "ecc"
> +CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \

Jan

-- 
Siemens AG, Technology
Linux Expert Center


