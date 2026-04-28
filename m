Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE6BFF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 11:06:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10817.1777374401520712270
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 04:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hNKf2vBm;
 spf=pass (domain: siemens.com, ip: 40.107.162.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV+9+Z3mOaxPtCq88kKSxe08HPQKVvRROM3aBDgPb9J6WENVNaDfycYdd0CZmtrN7MWM3i0cSANxEm3W9DMPN5ijpkpw0+Irv0X66tO4AqgYWbm1zaY32XDWqs0mcleZ3Hhnox2wR5gbt38EK/57LyPh7qJSZ7F8w4gCAGxb04TljqDlX1bGUQgfouxVIS/Lc3X/A7AFtXOfg4lyt4fpcBh55TfNxxl62NIYIOvrZ10XrqVSEuDZPQu6Y8X5iBDZRrH99o/cfyF4sUASjU7SX0JfiKGwiZ0JeEAWByMn/irLCiHVvDht7NrMQz3pbIU/K6UIzHYgHDkYNrF2KMbHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wULlRJmovpt0ZJiQzZAJjxVuX/3dcViDpcqevhMVksc=;
 b=jfMGFasmBTg5kyoOlYoZOYkTZV77bBaMbYf4bwaMomH8+h1nwg2KP+XCVhsH64fuHYon6dBGfgMR8+L9eht4evqLLpdHWj/VwEmzuhmNe39OPlk4mVVOqYO5hjHyT4qO5tcU1x0CE/5NOnf+qCfRO6s2S1QH7sZA7+oT06NpXdLMpdiIo837EAGWo9H7kiiUsdRlXpzR9/0CQwSa5U1n27tvfEbCF8TssXSA+/6Kg6HijCTjc2olGAbqnsDjVQ+S96KMyYWqcPkCN80KHxWk40+cB0ledhI+ktNlzhykQbKeKcp0y5D/3ZLsRA2a1p+CyGpb3oew6KJ6f6UI7mFKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wULlRJmovpt0ZJiQzZAJjxVuX/3dcViDpcqevhMVksc=;
 b=hNKf2vBmwizWayZ8I2qUSLyWSHxxpef1UHdw7LopiLlsXkY80V84KpdVP8KYyTupfPZESbsESPSdgt8w6doieicP3Df5+OaxRllhYq181jrsk6TQRE8BzbitE5MudVCrbwB1vTCt97solzble6slw2mYfApP4+kGkc8icMAVnG4Ml/SqRxwzCppi2Q1ZZuJZbqo0JsXxQE6C6TjSevFoENo0HEpzI8AO/hq5nGYkmRGACZQYBTXjXWURsSMNQLTTZzmfIE+MYEeE+mD8ePLDtLAqZWJhx/fFx69ZdFn1Da3+g4+gPStGFVa90SpoqrIW3yQVX8FhVj1+4Oja3krKcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:06:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:06:36 +0000
Message-ID: <981c2046-989a-435e-bba5-819884ff94ad@siemens.com>
Date: Tue, 28 Apr 2026 13:06:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] crypt-hook: Check if WATCHDOG_DEV
 is set and available
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20260428091124.1765253-1-Quirin.Gylstorff@siemens.com>
 <9c22fa0d-faa9-46d9-9c3a-7030e24707d0@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <9c22fa0d-faa9-46d9-9c3a-7030e24707d0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd172a1-c15c-43f7-4860-08dea51636fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	Qpec7/sJeY9I/m/HedkzNzJR2xgWWBLLBzr9VG8enlCHLpnkSfrrX0qwij1Nv+7xRh5MtjB2mK2wFcDwSqoVetGFmrRKV1f0qLIrBnoUeE3e06LVOog71EsugIQo90H4lf4mobfiI6zgZMTWvf3gWShu1AqbN5donBlP4HSBs+VvyGef2r1aqKplztNdLaJ9yMMfaiSFNP6oin6ZBIufrzNzIkpXE6K//WiieYvegMBNXfxr4PctxXtmd3MCDFIgfNq5M5aDfixdl1Yi1S1pNZPKjr2heeCFt96CmWDtsW9wgWVOuX1n9LfQ6+UHBH6QlaKT8EZqvg6iRJZZJOkU4GSBReXnoAEhF8Lp2ZSpe09tP8CUQyAZ5L7MRHLi3OPt2/hqr7ShG7hopV32NnXxKm6uFemoE8CxN+Vrg1xCtvygbBeCU3cRM7Rax8HvEY1ZNcPu+9osERhJFIt5GwgzfhErtU33Rh5LFLFd8PshBakgFk9cbsgeLTzqzcHl+A9S23ASuVKH3TFu/W6OC7SFYga3XHycx9fHuoQ4IN71sEXtrLKSNOA6rK4OtHhBNcpLR3KjS1anCyieFebjoXDeor6gQnElLMtU2NiclfGTLw5Folecvj4bCJU3/AUP0bap2ivA/diOwB+4DhIuIN5/71RdAT8BksjnLOdm6AzARZj/qWwx/9WwXvxjawhyZqu/QkkCTbIlyGgJV0uRE6Fj0MxlnLHFHZGs6V3mGdQsWQg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWpHd3RYeXExamp4S1NDcUxwbWVINHl4L2xSd0tPOFdGUCtEREZxVjI2SlND?=
 =?utf-8?B?N3F6bjlPMVVEalVpY21NU1hUQmhQVVJEQzMwc0RpRmlKQTZkcFphLytuT2Nn?=
 =?utf-8?B?M25YVzFDTzZtTEh1VW1NMiszR0M1K0lTM2t1SWpNME55SmhxbVkvWUxwdWZD?=
 =?utf-8?B?a2ZQNUQwNXUzU0lxL2FRcDFQY00wckhmbE5malhYQVJvTUdVQnA1MzNNNEN6?=
 =?utf-8?B?RlE0VXNqRVJOYkUxV3hQWWVCeUUwbXlDUGJqRjBFZFBNMjl2TDBZdTd3OGlB?=
 =?utf-8?B?QVFRaHhrUFFkOElZR0xlR3RFTnZpeG9oQWNsSzQ5eFVnRi9ZSW5PZVBsUjF5?=
 =?utf-8?B?NnE3bjF3RmhrajNaTk1aeERLVDI1V2FSNTJ4d3g4ZnZzZTdqaWZLWFlncFpa?=
 =?utf-8?B?dk96S1NreGVuV0FCSmlQS1JhTUxtL01Mc21RYkNnbHFFY3VMZ01TTkFDdExV?=
 =?utf-8?B?RWNrYlRHeUd1bFhZa2lxQjN0TTkzcnU1djN6MWpoRWVrZUpnOW5GOGpucXQ3?=
 =?utf-8?B?SHNlV1F1dHhoY3EvaHpDUkdYOExNOUt0bzNYNmJzc0syMXVQQ0duOVdscjRO?=
 =?utf-8?B?TXFIdzhGZ1ZBUS9QQUJVanZHSysrOWRudTRrcVB6VWFCeGpQWG1pNUpiZUdK?=
 =?utf-8?B?MWlxQ3NZNXErSW9LQ3NvRy9oVm5sU1JmSEJuL1RyL0ZRc1V2dlh4QXhoY1hG?=
 =?utf-8?B?ekR6cjRDMEFrLzcwQkpvR3BMOTNFRmR2RmRiRkYrSmxxaVAyclBKS0lWSElh?=
 =?utf-8?B?Vy9sUDZNNlVIYk9hTFAwQzhxeVRPU3pnUEh6dG5LQ1RSelVyZGRETFdZL2po?=
 =?utf-8?B?RFVTajRRUG9ScitONURuS2djTXY3MHpWSXJ6UjV0cFRVSWR5c2tkd2RTRHgw?=
 =?utf-8?B?TCszVHdZenBqVzZaNXQ1dHpQNHpWWjJYWEtlVlhETHpHQmFvVmlPMXpKUTRk?=
 =?utf-8?B?V245Unh1OHd0U3JkSy9ZUlh6UW10V1ZRYVZUaXhBSXpjcFJYOVpWaGpucElM?=
 =?utf-8?B?MXZ4UjNMVzNBbnQvSEEzeXR2SnJxUTF2S2x4Vm51NDNwQlJaWm40UjNJTVpK?=
 =?utf-8?B?QWExandNbVloV0puQktqZWtBcThJOEpCeXJSSTk1T1o4eXhsQ0lYS3MvTzVR?=
 =?utf-8?B?Y1YwVjlFTHJIcE12UnA3QThVVE1URW5BNm5DVitycU5WQjU2dzNXb3hVMTBa?=
 =?utf-8?B?OVY3aEYxNVVvZkhReUZBU2YyUHJqSjRzTFFXSFhpeWREMFVxaHB5bjJYQk9x?=
 =?utf-8?B?SHFQYnVCZXUyWXZNdzJWQXhCblJLODFvdG1KM0twSlZYV05VVkRsdEtZZ0hy?=
 =?utf-8?B?Q3UzYXM4YmpQOVQ0V2RnNlZucXYzZHRrVWp3eEM1Mi9QRml5TmlYTzB6Qk1o?=
 =?utf-8?B?ZVBBdVFpT0NIZi9yeEsrL0hIU1lnNy9abEVnVUdzWUJKZjVnOVhQVElWclBK?=
 =?utf-8?B?ZjJCZ1pMTUFLMFhQbjYyQXBWcTRSZ2hDRFVHZ21VU3VZZE9JK1kvbEdvZnZY?=
 =?utf-8?B?UmdsUmREZjNKeVMweVladW1DL0dCK2NQbG80MmZDM0dKc1NxQnJnRDllTFlq?=
 =?utf-8?B?c24yMXJpZFRac3FzYXQxVUkydUVpU1k4NnJBZnhqNlhSejBXdmZoRWJqdUZL?=
 =?utf-8?B?RTZIVmVoenZNMEtrb09MTDUxaWNDMG0rU3FvNDlyU1NOeVI5KzVzVFpnRlN4?=
 =?utf-8?B?NVpnUHFodm5lRjFPN21tRTJuaE9tWE1Vd0Q2ZEhpaXpLQVpFcmJ2cGMxWFFu?=
 =?utf-8?B?TjJqMjF4VnVCbGpLNzhFUHp6VTJvdWE4cjhhMmhFWFphZURVQXNmVU9Wcloy?=
 =?utf-8?B?ekdPUTJEbFBkWU5QaytqVEhZamE0Z1U5Z2pVYkV4YWlsemdDUkF0QWtrclVl?=
 =?utf-8?B?YUtmUjVuYjRXZ09uek55M3JCOGRPeGtOWDFXN2pyRHdYWWYyUndOS3NPSDFQ?=
 =?utf-8?B?Q2RrUUtVL1FKaWtQc1hzNFFCdWljQ3FYUmdFY2pPMlFESUZzZ3E4UExhNnJV?=
 =?utf-8?B?dUVQVjF0ZlhEcUREeXRKZmVIQVROOHoxRXVFaE9oNXlycm1Xb3BaRFFtV1lZ?=
 =?utf-8?B?ZEpFbmVBeHU0Q0hWZWJYSTUvaGxmTFgwbm9yZnM1MDBac1NYaWN4N2IvemFB?=
 =?utf-8?B?UERldUlhOEs4L0lVU3gzQmYrbURNT0ZIVmdVWWRjcWlKb3NFWnpKWW00dG5o?=
 =?utf-8?B?d3dHczV2aVY4TnNRaGQ1cFBoVFNzbG5vZkFlQUFaNk12ZnRmL05RTm1jZUM5?=
 =?utf-8?B?Z0RLMkZTQlRBNElFQzZ5Zko2YkZzUytBb2tvL1NJNzJhdXR1eFErcWZIMFU3?=
 =?utf-8?B?clYydHNONndzTisxaE1LQTJMYXNyVUlhU1ZsdE50TERDUVpsM3d1M2J4cWRM?=
 =?utf-8?Q?qXxHSFIeKINSpWSw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd172a1-c15c-43f7-4860-08dea51636fe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:06:36.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Sw4kIvbYJ4QxYxCT3K9cfMAkbRjmUOOIXMlG/lE0XdeO3V+cwYrT/TTSY1kVkL42pcEGEGg8iNFCzsyHv+vwSNTUOFxqL2AoFJ7cE77OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6127
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 11:06:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22816



On 4/28/26 11:14 AM, Jan Kiszka wrote:
> On 28.04.26 11:11, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This avoids an error message on systems without the given `WATCHDOG_DEV`
>> and allows the user to disable the watchdog by emptying the variable
>> `INITRAMFS_WATCHDOG_DEVICE`.
>>
>> Reported-by: Stefan Koch <stefan.koch@siemens.com>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/local-top-complete    | 12 +++++++-----
>>   ...ypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>   rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 4f3eafc..fa4980c 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -2,7 +2,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2023-2025
>> +# Copyright (c) Siemens AG, 2023-2026
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> @@ -64,10 +64,12 @@ if [ -z "${create_file_system_cmd}" ]; then
>>   fi
>>   
>>   service_watchdog() {
>> -	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>> -		printf '\0'
>> -		sleep 10
>> -	done > "$WATCHDOG_DEV"
>> +	if [ -n "$WATCHDOG_DEV" ] && [ -f "$WATCHDOG_DEV" ]; then
> 
> The first test makes sense, but can't the second paper over bugs, or at
> least make finding them harder?

If the second check fails, it means the kernel does not provide watchdog 
device.
If the watchdog is enabled earlier in the boot process we are already in 
a reboot loop.

I would use a separate check for the watchdog device and print a warning 
or use panic to indicate a miss-configured kernel.

Quirin

> 
>> +		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>> +			printf '\0'
>> +			sleep 10
>> +		done > "$WATCHDOG_DEV"
>> +	fi
>>   }
>>   
>>   check_partitions()
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
>> similarity index 99%
>> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
>> index c0572f2..331a662 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
>> @@ -1,7 +1,7 @@
>>   #
>>   # CIP Core, generic profile
>>   #
>> -# Copyright (c) Siemens AG, 2020-2025
>> +# Copyright (c) Siemens AG, 2020-2026
>>   #
>>   # Authors:
>>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Jan
> 


