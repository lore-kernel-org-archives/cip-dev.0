Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73988F94CB1
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 20:47:22 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49755.1776804439312691952
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 13:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CgZ+hvJQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGRQkbilBYqgGbbeUOEA86ADvCdSEdflAaD3lYxBuCUk3IG7yDplZaFDOzYPg25Vuyk0O9Flpj3MDFt3CfCh3yCpxLEj66tmCCqqxS+lQrPNc+YdjOs7ndfqZ+qKiZig/v0lYaMQxULcXbPAlRAcekesYSyYkQDpJNkHR0Ux2BJlU6LK5I6zruQy9M1GmvFmCchsyRK324O6w/M4Z4dVu67LhFUIO0OgddewY1r4s25uwva7QsnqMYQlXN4/hv+kdFC3N8/hCNGTfebmJYEEb3ArNpZxVNrwFoyh24itCEybFWBVCkgXRPPDVaXYT5c4ODzvGtjbz33IyaSsVZt8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgLc0+eeNhul7yIfWvX7MqbZvF+xcjib+VeCziVbek8=;
 b=Ht/Ps6NASvpQZ3PCOZ/K/mn45ZuQuPAiH703sEY8aszBOt6LOiNVTDuNJ5y8W4O3+cGfBu18C9Dbk9w+QqWoobumlto1xc+12OMURTdWAhIP3PjiPTyMSZs0lHR64cmCblU/yNoNRFTS0YJbB0Wo7SgP7q4qNTrrQqCGEgTc3vC8sV2yUJqEu5MZJ2VNYDlpZ6NPA7J8EE4FqOhE7sckaTyoWLhteA1p/9fJjG3H50yEtPBC4rlxLOHOJyhke31yJmqGuyzwh3PdkTTts042gPTf/j32GZswzwSwbVdLKTJZ5cZ0pYPHK8a5ECUQbRQWG5GqkSfSpAonqfflmzb4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgLc0+eeNhul7yIfWvX7MqbZvF+xcjib+VeCziVbek8=;
 b=CgZ+hvJQcdzOMdYBQ9i+hLXtKl4coG3sYN0OGEvY3j5WpcC8Llqo8YwWWF3Ckf9aqWIQxxzdKyYuDa/yVE9KFNR1EUoNcWmESjzlMRjSfIRRYsctOZsqiZ9Kvdrsl3IlchEzB5PzJDvFTaqHrALZimmcKvyg3ikR+3/yzwHUPoUKq2MO5IUEfUhXSHLMB8BC7Iich9H9px8eu9JqwdCQ1TTy8UwX3KT2vQWVe/MctkQsu7ScpTpPm3Jlcy8/rbD/h7sk7kveaQmUeE21TokJs2BD6fAeHDGsSzXWIIu/5tQTD8NlHpYbWoqTtAYZygBC+8toBw3Rxqc9WQJmedduNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 20:47:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.017; Tue, 21 Apr 2026
 20:47:15 +0000
Message-ID: <e7a6f934-5d86-44f3-ae0d-1a6d9b4f4d4a@siemens.com>
Date: Tue, 21 Apr 2026 22:47:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] initramfs-crypt-hook: add configurable
 mount options for encrypted partitions
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260417113651.3923307-1-gouravsingh@siemens.com>
 <9acbeb77-8539-43de-88e9-405185cbd7e0@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9acbeb77-8539-43de-88e9-405185cbd7e0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: c51d95bf-0107-4601-e569-08de9fe72b73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	fiX1wo0qu04dHCsAYLalN7RdjpaoZPyI8Lu/58Ay0swBXuRQbaxhchVq/e06Mt5YNvzbfOkTaGChqukBUyugiRqDME2o4AQ1QWw0eYYuCL1K94LXVodB8TOTKAhu+Kv+RIEjQDZEpd3Q/nJOMjtEMNPPZMNz12Dn5bFOskwGOKnCaB3z1pPFrtoleDjiTG/d4clmF+E9BlBKtyajiUy4HI0C8ILPwOeufGdLyoUam/D6nNEFbPLZxE5YDIJLzYYW7bxx1xt3/b+A693hdwFBVe17HieRksvtEQiniVrtt9kTBTrT4/Mva6pY+DB0oiGDiGs4N9cXEmgHlQQzcqyrNf2ZwrOrCfwHn1c5QxQvI0cTVVggFZ2qqPcjsP0sjkdHy8wrg7DPa+PPV6YNxz4jlMN5PWF9w0uZ5tuPSbYEHicceKb7sfiFXaDsTb0oIt/tldIXRE1oeL4n1VLKwUVBAesbxCgd8SZHs3wdBZCfBY4eZSZNv2X5D5tt8tB/SVlS90vs58J7Bey8omuj5SYkyhLlw5b3z5zxGNUpkoUpDHzs7ASBXY3FxQda48ZnctgCHBKsWxvjVIvnb2VANh1Hmvg6xZWaoyFx42qYOAEt5zPZwcMDozp2jaIvYoYRL4GkpWjVHq557FtYkv0kHCibzccD39uSniS3L5e/T/dityLFON336sXk6BIQstoMXY5YpTEkg1JnWMGViVOxZ6dJd3FtDg3QY/HEZRha5VE5yEM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXB5NTJhTEV0NzcyQjg4L3lNUTl6Vi9zTWVCZkd0NjlrVktycWlRZFBJZ2Vj?=
 =?utf-8?B?NHZsZ3A0T1pDaU5DelIzWU1RNVg0LzlnaFRkelhJZW1RTVU4SFlxc3MzeW5N?=
 =?utf-8?B?S1VXS01mcWVEazhVdlZhTE44aTA3ZjlHUlJrLy8yQS8zVWJBa25Cem1VZ0hz?=
 =?utf-8?B?dllpS3o5RmxJTmMwcnovVTI3eCtvNXpUNTFXOVNaTzJzZ3BQS2RDMXlHeFNu?=
 =?utf-8?B?NTkvUEdIdFRJQVZQMnlwOTU3WHYvTlRlakhtRUsvUGtOVGlLOTJ2Z0RhcEFJ?=
 =?utf-8?B?bExuNktIYzZHRktwVllXTEcvZzE0cHJDbEdTY1lNdDU3THpTRmVielp5OU9m?=
 =?utf-8?B?dzlvZVVZaWI0QnRSK0JQNVlqdURYQU1YNGY4UHNoc3FBcUlxRWNhZTZJUWlt?=
 =?utf-8?B?anZFRDJwMWJQN3BGK0RpWWJKU3JLMWExbnkrTE9selMyTmlDUVc3ektuWWNB?=
 =?utf-8?B?THdnU0xiazZoU1AvVHBVTnhpUk02TWR2NXdGbFVDVmp6bHV0K3dmZS92cWlN?=
 =?utf-8?B?NkU2V3RGYVFrNHFNa2k3cDR3WGlGL3lsTWhrQ2o4ckgrVjdHVmVkelcwZEp3?=
 =?utf-8?B?TCtYMXkxWFo4OG1ncmtNNWRMVmo0cTRkd1pXbHlBa01vK3dzWVluanZPZEdt?=
 =?utf-8?B?MkprUG9BWEpRUGRMUEZOdmphQjk2M1ozcmttZGFHbUVqNzR4SU43eE8rT0lx?=
 =?utf-8?B?Rm1Wc1N4OEdzNkdKSnRYRDdLRFJDaU9vY2FnNmJJczRGQ280aWJ4UEI3d2dH?=
 =?utf-8?B?bERZaTZwMjVieUFMaGRZYmUxRkVKWEJldnBDc0g5czNIeVp6UDYvNm1pOGFE?=
 =?utf-8?B?MC9nQWxpTjFvUjIrejNLdWhxV0JWaEV5S2VMaDNFUHdCbzJkOXZRNTZVbU1p?=
 =?utf-8?B?QVU2NjlFcVpYRHVyVy9TdEdSaGpVKzFvaGw5ZVdhOHBtQmpDZktlUEs5ZktN?=
 =?utf-8?B?WTVsa0FuTkU3SGNkRlpEd2xrOU1UcEZBK2J3TWw5SUE1cnJua0VwSmxoOEls?=
 =?utf-8?B?N0lvM2p3MWM0enpxSERPa3BtbW1UM0pIVU5QVUFhRXc3aVBrZEVvMnp3Tnpa?=
 =?utf-8?B?RWlkQ3J1UHFJSWQ3UDVCS3BUL0hVbTdHQUxYUzlabEJFYkZJTTFIVGUxVjNM?=
 =?utf-8?B?WmkrSmdQZmJjTHI4TTFMM3NGMXhtNGxWaXNHTVlhdE1sMWU0b0tvd1ZuTXM4?=
 =?utf-8?B?bVlvb3c5Sm85QzdnUDByc25oZUVhSzRxVy9TNHpPVjBHL3EvdGszcXUyOVBj?=
 =?utf-8?B?UmF5Sy85MkROYjBVdHRTT1FPaTBvK3JYZFpvWkZ3SmNlT1VYdGtWQ2RoeklJ?=
 =?utf-8?B?cWNJaGU4Q05lekl6a2lwUW9tVlcrdkoraGQxS0VmZi9JbHBUZm9BUlNkTXl2?=
 =?utf-8?B?V1A1Rk42a1BZaHZEb3ZZY09EQ0JRbTcvQUkvNzE2MFpwM3lxSzN6bjFpWkVu?=
 =?utf-8?B?d2xnSkRSZG1rZlpyU1IreWI0Zk84aWJaclpObjF5aEVzODNCTTk5RGhxNjlU?=
 =?utf-8?B?R2h2VzJKQTZ5cGpRM0hiY3hEZDZoMUJDRDFqZlpuZi80SGo3cW1uM1FZeWQw?=
 =?utf-8?B?dHA0TUJydk1xVGJWQjU4NTZxOVFKNlN3bE5Jd0JwRm5IL0o0WkxBZkJNMUZC?=
 =?utf-8?B?WjNEZTVSbGlzWkkwb1h4QklVUWE0MlNVU2h1WkRBcjczY1NVNmtibmlVeHBo?=
 =?utf-8?B?YkxOaHR6bVUxRnZxemJqb2pSaXVOYTkyeFhBYmhPZkdXOVRjTURMaENyUG5Y?=
 =?utf-8?B?eHY4RWVucWJuVVZXTVVpaWFjNmtjR1p2bVRua2JLd0owcktTNFJJdTlGOWYx?=
 =?utf-8?B?MkczOTdsNjlic3VHUm05ZlZXcldtMXVtSy9aeU5HU2djK3VtdW5QQ2JiNnlR?=
 =?utf-8?B?NEVncnc5RlZsUG55em9CK0xHSG1RK2xRbkgyQTlrbnFDcTdPRk5jQkpXeFgw?=
 =?utf-8?B?K0l1UEFrU2VQSWpZUHFINU9qZkRUZ2JhVUw2YVhwWS9pcm9rc21BVWVKUVV4?=
 =?utf-8?B?akcvM1VnZ0E2THJMQlBJMmluQ0x3VHBGV291TGtwREQydkpRMmczNTd6T212?=
 =?utf-8?B?RHVvZWFubmZxN2VoY0tQaU5nZThxSHI5bHNyTHpXMmxqYnpsR3hrVndsSFEw?=
 =?utf-8?B?Nm9VY0RQY0FrUzYzbDRac0IvSnNtT21RZjJMc3hjOWJDV1Y0dVBZK3dmQks0?=
 =?utf-8?B?Vm9YU0dPM0w3dVBkdUd2a1dBTlZLbXdVdVlvcDFiRWR5ZFNXcTl2VWF0MHVO?=
 =?utf-8?B?c3crYS8wREJBVE1jQXpkL0RtU0U4dXpaOEdDZlJpY2NTQ3h2UTlGeHJ0QXp5?=
 =?utf-8?B?RnVqZ201SXl3cjlidEJUcktzVXRDdFNRZjVNM3BMNTd4RWcxSkRPQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51d95bf-0107-4601-e569-08de9fe72b73
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 20:47:15.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukafiptMI2y/CNkf08j92toGiRp7Tu5Zb2Wx+cbUxDiojsJNXUskjEZU6V0rW8xqbT1nB6g03/zjqOXj5cy6fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 20:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22779

On 21.04.26 16:10, Jan Kiszka wrote:
> On 17.04.26 13:36, Gourav Singh wrote:
>> Introduce INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable to allow
>> configuring mount options for encrypted partitions at build time,
>> following the same pattern as other INITRAMFS_* variables.
>>
>> The overlay hook already sets nodev, nosuid and noexec mount options
>> for the overlay storage device. However, the crypt hook was mounting
>> encrypted partitions without explicit mount options, relying on
>> kernel/mount defaults, leaving the same security properties unenforced
>> for encrypted partitions.
>>
>> Changes:
>> - Add INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable with a safe
>>   default of "defaults,nodev,nosuid,noexec"
>> - Expose it via encrypt_partition.env.tmpl as MOUNT_OPTIONS
>> - Pass MOUNT_OPTIONS to mount_partition() via mount -o in
>>   local-bottom-complete
>> - Add INITRAMFS_CRYPT_MOUNT_OPTIONS to TEMPLATE_VARS so it is
>>   expanded into the env template at build time
>>
>> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
>> ---
>>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl     | 1 +
>>  .../initramfs-crypt-hook/files/local-bottom-complete          | 4 +++-
>>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb         | 4 +++-
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> index 452714d..787172f 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> @@ -8,3 +8,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
>> +MOUNT_OPTIONS="${INITRAMFS_CRYPT_MOUNT_OPTIONS}"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
>> index 064e41c..d8516bc 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
>> @@ -36,13 +36,15 @@ esac
>>  # get configuration variables
>>  . /usr/share/encrypt_partition/encrypt_partition.env
>>
>> +mount_options="$MOUNT_OPTIONS"
>>  mount_partition() {
>>  	partition_dev_path=$1
>>  	partition_mountpoint=$2
>>  	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
>>  	if ! mountpoint -q "${partition_mountpoint}"; then
>>  		mkdir -p "${partition_mountpoint}"
>> -		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
>> +		if ! mount -o "${mount_options}" \
>> +             -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
> 
> I re-indented this part during merge.
> 
>>  			 "${partition_mountpoint}"; then
>>  			panic "Can't mount partition '${partition_dev_path}'!"
>>  		fi
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> index 18a10a8..c0572f2 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> @@ -95,10 +95,12 @@ CRYPT_KEY_ALGORITHM ??= "ecc"
>>  CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>>  # add support for btrfs encryption
>>  CRYPT_BTRFS_SUPPORT ??= "0"
>> +# mount options for encrypted partitions
>> +INITRAMFS_CRYPT_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
>>
>>  TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>> -    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>> +    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OPTIONS"
>>  TEMPLATE_FILES += "encrypt_partition.env.tmpl"
>>
>>  OVERRIDES .= "${@':expand-on-crypt' if ':expand' in d.getVar('CRYPT_PARTITIONS') else ''}"
>> --
>> 2.39.5
>>
>>
> 
> Thanks, both applied. Special thanks for proving a testcase along this!
> 

OK, patch 2 was not a testcase but an attempt to update the existing 
test cases. Unfortunately, it failed. I'm using now this login command 
(fixed up commit):

 - if mountpoint /home; then mount -o remount,exec /home; else mount -o remount,exec /var; fi

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

