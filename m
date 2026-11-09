Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2718.1794216345594927169
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:25:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IX++FHYx;
 spf=pass (domain: siemens.com, ip: 40.107.162.32, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omrbur9gQFE4NmOifjyrR7TjO/ONN0IgBd+QAKVMt8cDtSvouysiLI8c/8U375aS5SH/iY4CpsIJsk0+L0NvrxJU+UPOJ8ItFOtIpzLLT7tAbb6cUNotfTWrHDiQ2yWvEfd4R8JpKv3ezApOb0WyU6e00PNqsA7DHBm5QrxEiKxoNOkMtf4F5KZOgpVR1FY19ssw9C7K15MnvwudplgzyEPnRnsYzSl2C7pIn1MSUElJBBhI9AQrMJPpU6zzBfR6zDVrqoCqgW5sP0RVPI6bw3uFnLrT1Etptqe/0VRoNZCdE7/TWo2U27viYXASRItFNIi4bamG4Pwg5OKg7xhbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkucU1rOThIC1IywlkSxAx7R8Hhfjx6X4htG07GmMzI=;
 b=RsqtVPPiB1fvy3/E5RBwsBfFqp8J+deors+6q9I9krZNRnaTZole5JbOicuDiQo4cXF5SbB23+9hP2zwsokbVHINsiwJ+gZSwZrGYIEY0+AhE45H7Wx1ir2d2C/8IN1RAO3nX3k6JFQfsfS8flwVGNFZdTMIBJQ7ksv3VQDRdNymbkJ2G7BdX5rBwRvMSbjP02RjRl3PFTVf2Ypr/WjUQA2Ne+pt0J/n9719zTAcWMZwDYIV/OpQByafSViVHTWbIIsq2HbgRj1YCgBXpr6qM566KREJJRVK9wmopmMyCWbZJohBz3t2xx7r44SXj5ErvZgUKnKX2tFoMRZb3T1aDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkucU1rOThIC1IywlkSxAx7R8Hhfjx6X4htG07GmMzI=;
 b=IX++FHYxchB0qlEOm7MO9yo2MlCGrtBS1TynuKBo4xQVe0eXnyJBCGUJZBK3aNiv8Zhod1dlPwbwQExlQzcP3CKWvbkVHOjZ0cb2Poux1LYpiF1Ujx7q0vH9hgQU87pbsJDiGWPtzWT3jw0KJzAOhljJyhSKyMhuNLDfxvx6U9aCM+nDeD/GnYiILSnmhn9dGgBlXb7X9EV7YBdELHzeyMeKtmmVCXxKEsE+g9nj7dfRZuSHiEvwoM131wJfhHQH5dffB5vbFUIqyI49s2eyENiA93unlaCoWOG1VZMX2T8H4/rlaoz1LE3lkhhM5+1hLOUEAN0IGUyuA0jprRmeyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV4PR10MB084013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 09:25:41 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 09:25:40 +0000
Message-ID: <53e47dc4-32d4-4c1e-a0f7-c454e8908d98@siemens.com>
Date: Mon, 9 Nov 2026 10:25:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 02/12] efibootguard-boot: emit
 systemd verity cmdline for dracut
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-3-quirin.gylstorff@siemens.com>
 <03a9b0ce-4087-43b5-aeae-a62e6038ca2f@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <03a9b0ce-4087-43b5-aeae-a62e6038ca2f@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV4PR10MB084013:EE_
X-MS-Office365-Filtering-Correlation-Id: 28da76f0-4d4e-4bd1-2150-08df3e436be4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|55112099003|4143699003|11063799006|261028144727099003|261102123227099003|261022115727099003|261022075727099003|261022105027099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: i3j6aWospAJQhsHDuC1DEX8ZsuAMiTGcCw31ofPfxGiXEc2+RJc9kcvBSz2tsSbQQZPWHKwJZyeX2Lm4DcBhlWWcCZ7F9FayAX3iKbFvNx8HVazzZ+xEqL+EwLEf0kUC0e+1zLm60qpzs+F7mk/0IIy/wvirWAaV33opXEwBYqSqjpoCKgroc1dDxiaNvJP3ccqA8FR9D5G7UjYS5SWATPWaxkyzqRYDyUhFfLWnHNMjxMhdAftrasSB/10wbQQLcLG/M59djeCsqvBjpm7TTgxzqpicu9AHYVdMzh0bzibftmA35mEL8xPYzr4lX35XEfVSAUqP5IQh2zSPNXv1AG4ltPfs29J7oO3dBQZId5tqsEy/BYSJHekaQgafTuVyQCk4oaUJ3x+Lk9pQH4UqeCDdqc2MjIBdfhCgAkYhexSivoV2HnkHmgE2d8AslfZti0TYbX34TVMhw9EK2NbQqwPSHhbi3mF61jFxDCo9sVKdBooXUSPRenS6DNm4vMv8/TnKdGFTv2Qfudc3b2elBZPOC1P5K8ntIhDSgwunjzBc+XKSs26dcsKZ1eUrL2gpTW1uzjn2vt5Y41DtLdYL/z7RsPUOxK0OBd1f8Zu/l4012vGWLAEVs9v9botK4MczlB8Z4y5VSWrHkry6oAh1zHEHUAcpt8LVoAptuBYwAsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022115727099003)(261022075727099003)(261022105027099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ExVmNVZlN0QWMvOHYzcUhjU0cyOHc0ODVjVUNPRWhvOC81WlAvcTZnY0F0?=
 =?utf-8?B?c3hrZzlmR2MvdUJrVlJhOEluK3NqMmJJM2ZuSFoveDhUMHJaSzNTN1I4V0Mv?=
 =?utf-8?B?T3dzalhXVGY5L3hYaytZVkhvV2s3WnpsNVpHVi9YYlFnM0JIQkFHdS90cUpQ?=
 =?utf-8?B?M1JEV2RqcDRNd01JYWcwMEpuT3U5QVYxZlNoTm9VekZaZTJodzBBU0llRTJC?=
 =?utf-8?B?UGxsdEVKbVFDTVNZZU5JRkJsUVlNNVdFSUxXK0FMcWxqK1RKZDRxWmh5aGhj?=
 =?utf-8?B?cThzS0kvREFvY1czK2ZpQy8xdGd1Rnc3NVpRMUNrNVNiS0ppRENWcEo1RGQ5?=
 =?utf-8?B?aXFqNFFqbmh6UTBKa3V4SnVEU0VTdlJrVW54azVkeGVja3RlQjRNbFN0NVp1?=
 =?utf-8?B?Y2ZEbUhRU3pxS3JTV2NDSzY3MEQzQkExY0dib0lnak9MVlZsR3haY2dGSGVi?=
 =?utf-8?B?RkFXUDEreVkxYUUvb280amptQkdlNS9hc0NUZEowWERuRVBoTTM1UEhCYXRw?=
 =?utf-8?B?ZzFUVms2a3h6azYrT3JxNmN2eUdUQUQyb0JXSWR3V0FtbkZSUUJmRmMxN1Zu?=
 =?utf-8?B?cFBsZmxTUHZkYk5zdVdKcUkrU1dYNjZxbTVyV3MzUGQ1aXNGOVNMUk1QOWFP?=
 =?utf-8?B?dHVvSGRXeFcxTVhhYkxNZWczZFY5UjNSZUZsalZteWNGQkQ2WkRUQkk5Njc2?=
 =?utf-8?B?UWZQSldrblBOa3BPYmNwZmN6QVQrVVozTzVMNUhhZUlmZGZuOFJWY2g2dmJ4?=
 =?utf-8?B?Z3VDelRSRXVTVGRna3R2RTQzZzM5ZW1LcjZmcFA0UE1pNHpENytFWHJiMEI4?=
 =?utf-8?B?RTdJOG1wYWZjREV1MEJUcmgxVDh0NmVQQ244NWhVSjd5ajFBbHpycVhRRVJt?=
 =?utf-8?B?bXdGZjVYbHhwVTB6amtndzBVcmdKUlV6c283bVF4SzB1czdrc1NDVVZ4L3pR?=
 =?utf-8?B?eXFMSC9wTU1UbEhqTDZwcG94cXB5czRaclVXNlluUEFXQlI4RjBybmY2WThJ?=
 =?utf-8?B?NHl4OHp5Z1UzR1gwN3dMVkJaMDFuUWdSVDk1ZGNRaFJrSlg5SHZyWTVpZWhp?=
 =?utf-8?B?R1czTjBNVG5VUUl4Q1ZjbUZodEZBZTJ4WGtqSXlMVUVCcm1Xb1k2aitubFlp?=
 =?utf-8?B?MXNsYVhtZEhYeVFiakJMNm5LOFNiUUZRMm5aVjVzNDRBYVdFWUhrRE5UemQx?=
 =?utf-8?B?WWMzNWNPa2EwSFNxMlpoc0lVQ2ZJL2g1Qk0yc3NuT1MreENEaW51YUU5YndV?=
 =?utf-8?B?RmJXdDFSUjZoeXF4eHR0OTJubU9lcTFYbHRjbGhIaURtSldpcnNSTGlpWUdz?=
 =?utf-8?B?YytVRWY3bmNmUXdqUUIrNHhhK0dWd0RBM3NWS1BIUmFHa3VkTFNKWS9Tb294?=
 =?utf-8?B?UDFSNlBkZVc2Qk1sM21YdEF3Rkh3cDc3eHpnN01BckhrYTFCbUhjd24zbndQ?=
 =?utf-8?B?N041TFNiVnpWSnAveGhGWFhWeklYKzdaTDgvcVNhTFl2dTBWZk1HcFJlUE55?=
 =?utf-8?B?Z2NkKzhZOXFONGpnWlFia0tkdldlQnNlc1ozdmtEREFwZnFHSjdUVzlGNm1I?=
 =?utf-8?B?N0lWZWhLcUkrWDR1OGIrUWF6UGtKbjJ1THZmV2tOd0c4M1NjOFR1R3AydzZS?=
 =?utf-8?B?cGpXeDJXbENOYlpHNXJ2UnBqdnk1ZGFxTXo2Q3lrNGRYVW9LL2FEVWFrcTVC?=
 =?utf-8?B?cjBvMU1uQzUrcDJycURUbWhDUmd6VUszdmRBQVNHNXNIVEJKTmp5bTVQcjFM?=
 =?utf-8?B?UkdFYXEwVGNiM09XNGlqbDRFTEQyTlk3NDI4cFc2RG1WTndkVm1ULzJnUFB5?=
 =?utf-8?B?MTBJczNTOWxzc2J5OEZSRDh6Uk1vcWt0aXZia0NtWno3akMyUTlRRzBQNnU4?=
 =?utf-8?B?dWwrQVJaS1U2bjhyYkRtcGxGSll2ajZvTlRYQ0JKc3JZUWdQSjk2K1JxZ2xL?=
 =?utf-8?B?QzR4TWJoN09NaFVSZWlvS2IvL0VWaCs4VS9qOFE0L2hVT0IwQzFWSEtmV1hM?=
 =?utf-8?B?cFE0MEtSdm5NVFYvRXpFSWtsMTFUbTBwMkhEcGZmMXIrLy9nRmlpR08zVHcx?=
 =?utf-8?B?emh0ZG1vZ20waEJXWXl1U2dGRldyWjZJYi9QOCtZOUxOZC9saUhDOVdhYk5Y?=
 =?utf-8?B?aGx3b1JXQ0JLTi8zWkdqMlhYVXdpeFdjcWRhMVZ6MHZQNnp6QmdFTFo1RVkx?=
 =?utf-8?B?bklpbTJMVXFjb0RudmxyZElkZVJJTGZSMVV0aU1MZUljWXJNaHBZR01NWldO?=
 =?utf-8?B?WXRtNGVCbmt1di9sc0JYZkJkNGdRNXZFOGF0RHpHMEJWM0VvTEJhYnIrNFNT?=
 =?utf-8?B?cGZ5bHBaZWdCY2hPUGl0YXAyMlQ3STVIWUdrTmxLZkF4VlZVdHdxaUVjQzZi?=
 =?utf-8?Q?CgGnsqnoXH0P8SJA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28da76f0-4d4e-4bd1-2150-08df3e436be4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:25:40.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6gY5fWWt4znr4nVO4bSlx/JKJ8qZR3UYz7XSVEFdtRbOirv02BNajOH0+AOW2hQNOkqLw0vw2fpQWPyXki/0v+1v8ZlVty2+BFeCg1vRXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB084013
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:25:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24690



On 11/5/26 7:59 AM, Jan Kiszka wrote:
> On 19.10.26 12:25, Quirin Gylstorff wrote:
>> INITRD_CMDLINE_STYLE selects the kernel command line dialect for
>> verity. The default "initramfs-tools" keeps cip.verity_root_options=.
>> "dracut" emits systemd's native roothash= and
>> systemd.verity_root_options=, with the data and hash device resolved at
>> runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
>> INITRD_EMERGENCY_CMDLINE (default "rd.shell=0 rd.emergency=reboot"), so
>> that a failed boot reboots and EFI Boot Guard can roll back.
>>
>> Also drop the LABEL=var entry from the generated fstab. /var is mounted
>> by the initramfs (overlay and crypt hooks); the additional fstab entry
>> makes systemd manage a second var.mount for the same filesystem.
>>
>> efibootguard-boot: use verity root for dracut without secure boot
>>
>> The dracut initramfs has no abrootfs support; dm-verity roothash
>> matching is its only A/B root selection. Without secure boot the
>> default wic layout (ebg-sysparts.inc) passes abrootfs_root=y, so the
>> unified kernel image lacked roothash= and the image did not boot.
>>
>> Promote abrootfs_root=y to the verity root cmdline when
>> INITRD_CMDLINE_STYLE is systemd. The wic .inc files cannot be
>> parametrized instead, as wic does not expand BitBake variables there.
>>
>> efibootguard-boot: explain a missing verity env file
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes-recipe/read-only-rootfs.bbclass       |  6 +-
>>   .../wic/plugins/source/efibootguard-boot.py   | 67 +++++++++++++++++--
>>   2 files changed, 66 insertions(+), 7 deletions(-)
>>
>> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
>> index 70152de2..179dcb98 100644
>> --- a/classes-recipe/read-only-rootfs.bbclass
>> +++ b/classes-recipe/read-only-rootfs.bbclass
>> @@ -17,6 +17,11 @@ IMAGE_INITRD = "${INITRAMFS_RECIPE}"
>>   
>>   do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>>   
>> +INITRD_CMDLINE_STYLE ?= "cip-initramfs"
>> +
>> +INITRD_EMERGENCY_CMDLINE ?= "rd.shell=0 rd.emergency=reboot"
>> +WICVARS += "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE"
>> +
>>   WIC_HOME_PARTITION = ""
>>   WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
>>   
>> @@ -76,7 +81,6 @@ image_configure_fstab() {
>>       run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
>>   # Begin /etc/fstab
>>   /dev/root	/		auto		defaults,ro			0	0
>> -LABEL=var	/var		auto		defaults			0	0
>>   proc		/proc		proc		nosuid,noexec,nodev		0	0
>>   sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
>>   devpts		/dev/pts	devpts		gid=5,mode=620			0	0
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index ca97d7d7..5a5ec1c0 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -36,6 +36,7 @@ import logging
>>   
>>   msger = logging.getLogger('wic')
>>   
>> +from wic import WicError
>>   from wic.pluginbase import SourcePlugin
>>   from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
>>   
>> @@ -89,11 +90,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>>           boot_files = source_params.get("files", "").split(' ')
>>           unified_kernel = source_params.get("unified-kernel") or 'y'
>>           cmdline = bootloader.append or ''
>> +        cmdline_style = get_bitbake_var("INITRD_CMDLINE_STYLE")
>> +        root_mode = cls._resolve_root_mode(source_params, cmdline_style)
>> +        if root_mode == "verity" and source_params.get("verity_root") != 'y':
>> +            msger.info("efibootguard-boot: abrootfs_root replaced by "
>> +                       "verity_root, the dracut initramfs has no abrootfs "
>> +                       "support")
>>           # the verity cmdline format is identical to systemd.verity_root_options
>> -        if source_params.get("verity_root") == 'y':
>> -            cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
>> -                % cls._get_verity_opts()
>> -        if source_params.get("abrootfs_root") == 'y':
>> +        if root_mode == "verity":
>> +            if cmdline_style == "systemd":
>> +                cmdline += cls._get_verity_cmdline_dracut()
>> +            else:
>> +                cmdline += " cip.verity_root_options=panic-on-corruption,%s" \
>> +                    % cls._get_verity_opts()
>> +        elif root_mode == "abrootfs":
>>               cmdline += " cip.abrootfs_root_options=%s" \
>>                   % cls._get_abrootfs_opts()
>>           if unified_kernel == 'y':
>> @@ -152,6 +162,21 @@ class EfibootguardBootPlugin(SourcePlugin):
>>           cls._create_img(part_rootfs_dir, part, cr_workdir,
>>                           native_sysroot, oe_builddir)
>>   
>> +    @classmethod
>> +    def _resolve_root_mode(cls, source_params, cmdline_style):
>> +        """
>> +        Return the effective root selection: 'verity', 'abrootfs' or None.
>> +        The dracut initramfs (systemd cmdline style) has no abrootfs
>> +        support, so abrootfs_root=y is promoted to verity there.
>> +        """
>> +        if source_params.get("verity_root") == 'y':
>> +            return "verity"
>> +        if source_params.get("abrootfs_root") == 'y':
>> +            if cmdline_style == "systemd":
>> +                return "verity"
> 
> We should better handle this compat case at recipe level, when invoking wic.

Currently these params are hardcoded in the wic files and this was an 
idea to make it compatible to old versions.

A possible recipe solution would involve a ebg-sysparts-verity.inc and 
would not be backwards compatible.

Quirin

> 
> Jan
> 
>> +            return "abrootfs"
>> +        return None
>> +
>>       @classmethod
>>       def _generate_kernel_opts_from_file(cls, filename, keys):
>>           env_file = None
>> @@ -176,8 +201,13 @@ class EfibootguardBootPlugin(SourcePlugin):
>>           verity_sd_keys = ["data-block-size", "hash-block-size", "data-blocks",
>>                             "hash-offset", "salt", "uuid", "root-hash"]
>>           image_basename = get_bitbake_var("IMAGE_BASENAME")
>> -        opts = cls._generate_kernel_opts_from_file(f'{image_basename}*.verity.env',
>> -                                               verity_sd_keys)
>> +        deploy_dir = get_bitbake_var("DEPLOY_DIR_IMAGE")
>> +        pattern = f'{image_basename}*.verity.env'
>> +        if not fnmatch.filter(os.listdir(deploy_dir), pattern):
>> +            raise WicError("efibootguard-boot: verity root requested but "
>> +                           "'%s' not found in %s. Set RO_ROOTFS_VERITY = "
>> +                           "\"1\"." % (pattern, deploy_dir))
>> +        opts = cls._generate_kernel_opts_from_file(pattern, verity_sd_keys)
>>           cmdline=[]
>>           # fixup for root-hash to avoid an error in the initramfs search for the
>>           # root option in the kernel cmdline
>> @@ -188,6 +218,31 @@ class EfibootguardBootPlugin(SourcePlugin):
>>                   cmdline.append(f'{k}={v}')
>>           return ",".join(cmdline)
>>   
>> +    @classmethod
>> +    def _get_verity_cmdline_dracut(cls):
>> +        """Emit systemd's native verity arguments."""
>> +        opts = cls._get_verity_opts().split(',')
>> +        root_hash = None
>> +        rest = []
>> +        for opt in opts:
>> +            if opt.startswith('hash='):
>> +                root_hash = opt[len('hash='):]
>> +            else:
>> +                rest.append(opt)
>> +        if not root_hash:
>> +            raise WicError("efibootguard-boot: no root hash found in the "
>> +                           "verity environment file")
>> +        rootfstype = get_bitbake_var("RO_ROOTFS_TYPE") or "squashfs"
>> +        emergency = get_bitbake_var("INITRD_EMERGENCY_CMDLINE")
>> +        if emergency is None:
>> +            emergency = "rd.shell=0 rd.emergency=reboot"
>> +        return (" roothash=%s"
>> +                " systemd.verity_root_options=panic-on-corruption,%s"
>> +                " systemd.verity_root_data=/dev/cip/verity-data"
>> +                " systemd.verity_root_hash=/dev/cip/verity-data"
>> +                " root=/dev/mapper/root rootfstype=%s ro %s"
>> +                % (root_hash, ",".join(rest), rootfstype, emergency))
>> +
>>       @classmethod
>>       def _get_abrootfs_opts(cls):
>>           abrootfs_sd_keys = ["target-image-uuid"]
> 

