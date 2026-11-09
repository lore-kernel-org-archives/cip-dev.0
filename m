Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2834.1794217160199813170
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:39:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HmGzqv+H;
 spf=pass (domain: siemens.com, ip: 52.101.84.9, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EccCK7ivf/42iyPzFxX5S9d6006gTsXFvzUmpWU93u42fY+nogoT8XAENYErISOVh8jxS1NSWwuhx+k8364+nmS/D+asuQBira10QCQUrREugZDRu/5tyGGb5jAv70cxJWmoVLF2DosHKoxnLw+Av5oVad6+ioWWM3vidkPQWfO5A3DSMfdzjM/pscFEELfKTwgD0AsTmfNpIwP6uA9K/40FX+ccRGljvkPJ6GresiK29oYy0LFKLYcfIq7O3f4UY4ajkQuIOjuzmAFsNezGpk3AKu0ulTQWYqbLgo2NlqnY6S+AZdhhNwW+moTHwSEjd3QMWWBDwOBspqbzmxd4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUZnUeA0XP+mdsylMQiKTO1lVcyKZFotZCWx4tOtkP8=;
 b=OKUkXEKPBkB7/9r185QOeajliSt6SLw1rXnJgt622LZ7CzVqGvgf+uhkxKUEOnYreHEdhb/M8ia9TtaKGzevnSV5sN18NL3ehzn5VczXKkon+OtA1/tKgkxEHJxsDCu9D9xX9OSHEKAg0iEaxz37NJZ5qRQnWGIOAKcnBSTBOeSQc49gNf7cBrePSYaQv/xvRbZXvd3sG6xFXYGHdQW6rEebMp8ZV9UxfRjw0GCHiPgijpH0cSxCL+f9tQbb61M6y2N0VXBxBaPWe7Fdl+P+AgSEQY1Ql/tZ42u3YYHQaw/3jbHPjKMwVbkaXWCy2Z6VICq+JdMuZH7rjaB1PNZgsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUZnUeA0XP+mdsylMQiKTO1lVcyKZFotZCWx4tOtkP8=;
 b=HmGzqv+Hq1p46basL9Aqs90+LoAYFK9QuX4ky0+LAWf2Ru5bNGoVJ/4bAmvZnDkJhMgUju4AfT4LqthvSONxye1ncG3rjif/JSujjlxC5ahNKZzpf1/wsZfXpWJGkIZPRzxXQE3gFbVHZJAN2YiYbnMWcGo3VFCg4etXlBMHzK15tlgmCC/EQYgVxEnwbU6yK/2iejlwbCsQbBkuOFPng/JbEsJTmoSR7xNAl/oJrsbixi88/5IdmBkoFwfUxRQ6ZKM0LnNAkEPHrx9N9wMQPhL89+rAJBbrld1zzGrL/K5RS4CHqT15INnSfXKhD+UBvqN0Vvq4jA9aUrSEVDiBrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA1PR10MB8628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 09:39:16 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 09:39:16 +0000
Message-ID: <3f24acdb-22d3-43b8-b30f-91c5fadc47a5@siemens.com>
Date: Mon, 9 Nov 2026 10:39:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 12/12]
 cip-core-initramfs-dracut: load watchdog drivers early via force drivers
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-13-quirin.gylstorff@siemens.com>
 <d8f8bec3-8512-4494-8a9f-b3d8d92e6fb0@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <d8f8bec3-8512-4494-8a9f-b3d8d92e6fb0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA1PR10MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: f02669d4-42f7-4859-7827-08df3e45520a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261009221227099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: SMAwoYJIE/C75Nu6/7Ae1ePlzviEdqoGDFlbPW4LYnmQEPXAK8Cv0fKcmGpZjMUHVnj7dMma8I20w2337+RfBzslr+t87iJ/CtXWlLmBxqsElw+TVFMf2WV1jJqce5R5fAvvCV7xQskL9Af8UTa1N9mD4u1QZ7NQkAhzS0vP+HEtoeov6PrPObcKKMuo4V+wgU6CDIzpV8TD4Eb6CQRKDQdENN9ZYfs5tE2jY/XHrZ7adu7RFZ1R/LaRtYYDjIESwSkJ+kgvTeMhY8r9TZf4kk3YNxW/APZUfrqCZJi+nI6OQStmUFw/mNIsV7xArybJUYcmiKnWTGCtAnf0/3FVZ99Eiz2t9UPwmtXFBLVnDFoLXj+enCzuGLAGjLW+Ur207sajrxwlyf0osidyryz8HFOh1rXFuINZBCHGnx5u61AmR0rD9hmKjlNj6px2hxqUuyc2plxsoT8iXfs+ywYDzR/RkkaEXbsYxNCH9m96al1/KQs6HhpkpSa9TGYB0bKNtAlDw3LSznzPL+UP9kc1vFdJ0K2IgF7bN7QWQMYQQDTX401KWfcXzZfGLwFXGrnjaqIS+2GN6Bl0rHjTdqTQhijOKbZKUTHw9fboCIxUIhGRWt3lW7AgiHk36rhCIAcW7t2NsKEG25Q8roAwQdSK28SABAYSFyruz6oInW8PBhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009221227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhsMHROUGdnM1ZGTUU1ZFl0RDlzbE9mTGRjMkl1bCtKMCt4SS9ReGRCaWhy?=
 =?utf-8?B?WmUzZU5VVFU3ZTNHTnpHNU1CZ2JmSDZoRzY2ZG5sSnZLbkY5ZkcrT3A4NU4w?=
 =?utf-8?B?MWROS2VZWnBZYXN0WWYvSDZ1NFZXSGd5TEdhTEdpZ01pTEI1WjFmYUI4VXB5?=
 =?utf-8?B?Y0ZQZU44WDlWd1I5U1JTM0psV2VGOE5YMDF0UlQ3WnYrTFJBRk9xaFFCTkow?=
 =?utf-8?B?RVpkdW54aWF4RFFENWhXV3gwVHdXcVIxeXk3dG8rS1R4NkdVeEFWTHBRSmdQ?=
 =?utf-8?B?MVNMVWJKNktoY2YrcGpRT042S0NSVW9rYllBK0oycTNJb3cyeEhKNG9PTlZJ?=
 =?utf-8?B?V2tieGhIL3pMVFVGRk1JaGZORzFBdE9KM2VxR0ZVSWZ2NTNNanZoVGdJR09G?=
 =?utf-8?B?aTNaL3RKdUJGdGw5Y0xzSlVkQlZFS0tLZjZIRkNIa25BMW1LSDdQdUl3NXA5?=
 =?utf-8?B?V1dEMnVCZ3E4MEhub0NmSGp4Z3FNSDdFQUxMbHc5ajJPbkZ0ckxRM1ZQUzla?=
 =?utf-8?B?Q1V2czYxeE1NUmlheFM1NDZITWtaNDJzb0ZjM1QvcWh5bndkbk1xMFljR01E?=
 =?utf-8?B?MEJ6eVdHYjRTQ2xrQm1vTlorU2t5Sko4aHZoK3BOVXIwU2ljWHZqMzN3eUFh?=
 =?utf-8?B?R0QrMGxqeXRYdjlWLzZFNytQbTd0TisrYlRmVFdhRlltcmVZM1Qwa0JQN2xG?=
 =?utf-8?B?aUN0T01CYitTd0lOQ001dEd0eUhIdjU1NHUwKytVbEF0VmtiTml1YUlKNW1o?=
 =?utf-8?B?Q2F6OFJUMHI0SnQ1SnpTS3ZoSGFhNTZtQXpaTTdNbjNpOTB2QjUyRTJIZXl0?=
 =?utf-8?B?d3RKRXRwbnE0dTRqWWJDYkd6MDE3NnRicTVuRk8rUmNhUlVXdENqTEhyQkJF?=
 =?utf-8?B?Z0dYcUVCbUl0VkI0ejFGZVZRSGt1dGhJWkdVdEM0OEFVWGhvd3c0aFZHZjZ4?=
 =?utf-8?B?N2lwOGVpTHR6VlFJZTZ5YlZaMXU3NllsMEIzOVBwRUQwdmtla1NxWExxcUI5?=
 =?utf-8?B?SFBza0JiakVCdWtyeDNWWTNmZ0dyS0NCdEZ3T1BrU3RBaWNmN2dFL2Y5TFNv?=
 =?utf-8?B?UFdYaGxoWFE4cFlrVjF5Q3hNelFhZ1VPSjRWSk1nT1hTSWFhSThLS2cwaEJW?=
 =?utf-8?B?K2ZjSE0xMW0vTUhzbmpuT0diek1kTlZJZVhmSGVvRWdOMmN1TmIrQ09hMGE0?=
 =?utf-8?B?T0xuUVdKRmZCeSt5NWlMVGhMb3pqWnhBL2JJNlhMMDBqSnU5S2l1UThwSGJW?=
 =?utf-8?B?UmNRUkVTWkRuRW1lb1Exd2RxYTJuL3F5MllQTUh3anoxOHYzaVZYdjQ1YjFm?=
 =?utf-8?B?bThmTnF2V1dnQVZsNzFlRXRsL29yN04yeEN4dW5ZdDZtU2xnOFFuck1mOENt?=
 =?utf-8?B?a0FuWjJrK3Y5WDRtQVNURXB4dkFrckR3UFJYZUVXekpndTFGTC8rTmZYVWxI?=
 =?utf-8?B?c3k3YWw4OUppeXgxbEhWcGRwVUJjd1hvMVlBNzIyYzR5N3BDQ1I0dGJOVStE?=
 =?utf-8?B?a3VGT3U3d1hBWGVRKy9MbDRKWlhwVkhRYWJ2OXNVampQSmdHZFRLcVQzK0RX?=
 =?utf-8?B?cEFXRWt3NGRHaDkxR3Q3R1RrLzRHemRJeW5pVnVHUlB5QmNmQ3NGZkpTSE0y?=
 =?utf-8?B?MjM4V2RCeHc4Z2Rsb1VMQUVmRUhGaWxpUHR4Qy83TjhRVGo1SHhhb3N0K1BV?=
 =?utf-8?B?MWVQOGJ5ajM2OENxSmNyVWZOVFQ2ajFGOFVzRkZsNmU5emc0ZGJTYmkwd1FD?=
 =?utf-8?B?RmtuRHpBbUV4S3lCN01SYlB1UE4zWDlXK1g4djFvNWVJRE0xRlVHWUNQOWRJ?=
 =?utf-8?B?OU01Nm5nU2VhVVJoRGdlcVZqS1hnaFI4d0VIOG9lZzh4TWhsTTBjRDZpcHFU?=
 =?utf-8?B?RTRxdDk2ei9ScjYvR2lsZHZYcnFUWkJmenE0cGY3VHAwUGp3eDdlSEx2dEdy?=
 =?utf-8?B?UXQzbVhqRVprTWlMSHJobU9tdXRjTENEU0p0cDhtd292L3dDbExxK2lxcS9B?=
 =?utf-8?B?eWRNb2NPam8ydXhrWHJad0VrQzJYTnErNXhRZm1URndrbDB2bjBuYnlHY3du?=
 =?utf-8?B?YktJQU1TTFJuTzVFeE5SQkhyei9iZjdBVFV3KzBzeGZIbGNYbFpmb0toaTRl?=
 =?utf-8?B?TTgwcEV4bGhrWXFwdTBJUW1vUG9aRHpacWQvNG9kS2VVVmpXMVFtWVpza3h3?=
 =?utf-8?B?WVVPQ2U3dG5kV1JzUHFaR29MY2ZCcmdUVXJiWXBiRlBSdDE2R2pEbTE5dWJx?=
 =?utf-8?B?K3A2L29CUm9FTDRpMk5tT0RId3R6UEJobCtNb2ZGbk5yKzRCc3d4REUxRkhn?=
 =?utf-8?B?ODY5UEFUR01GZStUVVNWeGNnN1dlUytaNHBkTG00a3RtaDF0cU5BK2V1TTNp?=
 =?utf-8?Q?zdPDoeUHlz7Nu/MA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02669d4-42f7-4859-7827-08df3e45520a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:39:16.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/SpMh9BxSEhoHUgk6CMJVE0woRMgkTnZ9kpQB5H5OT+6sHbQf6U04i1/JxKKcjC0A8ALrwVG6CVLXI7ZaApY8SssMJAV67m5Tm2BNi+AFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8628
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:39:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24692



On 11/5/26 10:05 AM, Jan Kiszka wrote:
> On 19.10.26 12:25, Quirin Gylstorff wrote:
>> On qemu-amd64 the iTCO watchdog is not available in the dracut initrd:
>> iTCO_wdt binds to a platform device created by lpc_ich, and udev does not
>> load these drivers early enough for systemd to service the watchdog.
>>
>> Add INITRAMFS_FORCE_DRIVERS. If set, the new dracut-cip-force-drivers
>> module installs the listed drivers and loads them early via
>> rd.driver.pre. It uses DRACUT_FORCE_DRIVERS of Isar's dracut-module class,
>> which is carried as a patch until it is merged upstream.
>>
>> qemu-amd64 sets it to lpc_ich and iTCO_wdt.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/machine/qemu-amd64.conf                  |   3 +
>>   doc/README.dracut.md                          |  12 ++
>>   ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 ++++++++++++++++++
>>   kas-cip.yml                                   |   4 +
>>   .../cip-core-initramfs-dracut.bb              |   5 +
>>   .../dracut-cip-force-drivers_0.1.bb           |  17 +++
>>   6 files changed, 148 insertions(+)
>>   create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>>   create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
>>
>> diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
>> index 748aaa33..b85666ee 100644
>> --- a/conf/machine/qemu-amd64.conf
>> +++ b/conf/machine/qemu-amd64.conf
>> @@ -15,3 +15,6 @@ PREFERRED_PROVIDER_factory-reset-helper:swupdate = "factory-reset-helper-efi"
>>   
>>   # when running without kvm (as in CI so far), 60 seconds might be to short
>>   WDOG_TIMEOUT = "120"
>> +
>> +# q35 iTCO watchdog: lpc_ich creates the platform device iTCO_wdt binds to
>> +INITRAMFS_FORCE_DRIVERS ?= "lpc_ich iTCO_wdt"
> 
> Doesn't lpc_ich pull iTCO_wdt?

Only via udev. So it should be enough to force lpc_ich but I need to 
test it.

Quirin
> 
> Jan
> 
>> diff --git a/doc/README.dracut.md b/doc/README.dracut.md
>> index 2a59cd08..3f26d772 100644
>> --- a/doc/README.dracut.md
>> +++ b/doc/README.dracut.md
>> @@ -58,6 +58,18 @@ default recovery script is used.
>>   
>>   The initramfs is built with `--no-hostonly`, which `cip-crypt` requires.
>>   
>> +`INITRAMFS_FORCE_DRIVERS` lists kernel drivers that are loaded early in the
>> +initrd via `rd.driver.pre`, like dracut's `force_drivers`. Use it for drivers
>> +udev does not load on its own, e.g. the watchdog driver serviced by
>> +`cip-watchdog`. If set, `cip-core-initramfs-dracut` adds the
>> +`dracut-cip-force-drivers` module, which uses `DRACUT_FORCE_DRIVERS` of Isar's
>> +`dracut-module` class. qemu-amd64 sets it to `lpc_ich iTCO_wdt`.
>> +
>> +systemd tries to open the watchdog device when it starts, before the drivers
>> +are loaded. After that failure it retries at most every 5 seconds, so it only
>> +takes over the watchdog if the initrd runs longer than that. Until then the
>> +hardware watchdog keeps running on its own.
>> +
>>   `cip-verity` does not open the verity device itself. It ships a udev rule that
>>   runs `cip-verity-match` against every filesystem partition and publishes the one
>>   whose dm-verity header UUID matches the identity on the kernel command line as
>> diff --git a/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>> new file mode 100644
>> index 00000000..df652e23
>> --- /dev/null
>> +++ b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>> @@ -0,0 +1,107 @@
>> +From 061e42be73d410405bca189e876efa3034cd55df Mon Sep 17 00:00:00 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Tue, 13 Oct 2026 14:31:28 +0200
>> +Subject: [PATCH] dracut-module: add DRACUT_FORCE_DRIVERS
>> +
>> +Some drivers are not loaded by udev in the initrd, e.g. watchdog drivers
>> +which have to be serviced by systemd before the root file system is
>> +mounted. dracut provides force_drivers for this, but it is a global
>> +option.
>> +
>> +Add DRACUT_FORCE_DRIVERS to the dracut-module class. The listed drivers
>> +are installed regardless of hostonly mode and loaded early via
>> +rd.driver.pre, same as dracut's force_drivers, but only if the module
>> +is part of the initrd. The module depends on kernel-modules, which
>> +evaluates rd.driver.pre.
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + doc/user_manual.md                                 |  5 +++++
>> + meta/classes-recipe/dracut-module.bbclass          | 14 ++++++++++++++
>> + .../dracut-module/files/module-setup.sh.tmpl       | 10 ++++++++++
>> + 3 files changed, 29 insertions(+)
>> +
>> +diff --git a/doc/user_manual.md b/doc/user_manual.md
>> +index a134903d..09ac080b 100644
>> +--- a/doc/user_manual.md
>> ++++ b/doc/user_manual.md
>> +@@ -1877,6 +1877,11 @@ It is controlled by following variables:
>> +
>> + - `DRACUT_REQUIRED_BINARIES` defines the binaries required by the module.
>> + - `DRACUT_MODULE_DEPENDENCIES` defines dependencies to other dracut modules.
>> ++- `DRACUT_FORCE_DRIVERS` defines kernel drivers which are installed into the
>> ++initrd regardless of hostonly mode and loaded early via `rd.driver.pre`,
>> ++like dracut's `force_drivers` option. It adds a dependency to the dracut
>> ++module `kernel-modules`. A machine can set it with
>> ++`DRACUT_FORCE_DRIVERS:pn-<recipe> = "lpc_ich iTCO_wdt"`.
>> + - `DRACUT_MODULE_NO` defines the module number which prefixes the module name
>> + to determine the execution order. The default is `50`.
>> + - `DRACUT_MODULE_NAME` defines the name of the module which is used to install the
>> +diff --git a/meta/classes-recipe/dracut-module.bbclass b/meta/classes-recipe/dracut-module.bbclass
>> +index 6fce979a..6d32a4ac 100644
>> +--- a/meta/classes-recipe/dracut-module.bbclass
>> ++++ b/meta/classes-recipe/dracut-module.bbclass
>> +@@ -22,6 +22,9 @@ DRACUT_MODULE_PATH = "${D}/usr/lib/dracut/modules.d/${DRACUT_MODULE_NO}${DRACUT_
>> +
>> + DRACUT_REQUIRED_BINARIES ??= ""
>> + DRACUT_MODULE_DEPENDENCIES ??= ""
>> ++# Kernel drivers installed regardless of hostonly and loaded early via
>> ++# rd.driver.pre (same semantics as dracut's force_drivers)
>> ++DRACUT_FORCE_DRIVERS ??= ""
>> + DRACUT_CHECK_CONTENT_FILE_NAME ??= ""
>> + DRACUT_DEPENDS_CONTENT_FILE_NAME ??= ""
>> + DRACUT_CMDLINE_CONTENT_FILE_NAME ??= ""
>> +@@ -71,7 +74,18 @@ TEMPLATE_FILES:append = " \
>> + TEMPLATE_VARS:append = " \
>> +     DRACUT_REQUIRED_BINARIES \
>> +     DRACUT_MODULE_DEPENDENCIES \
>> ++    DRACUT_FORCE_DRIVERS \
>> ++    DRACUT_MODULE_NAME \
>> +     "
>> ++
>> ++python do_validate_dracut_force_drivers() {
>> ++    import re
>> ++    for drv in (d.getVar('DRACUT_FORCE_DRIVERS') or '').split():
>> ++        if not re.fullmatch(r'[A-Za-z0-9_-]+', drv):
>> ++            bb.fatal(f"Invalid driver name '{drv}' in DRACUT_FORCE_DRIVERS")
>> ++}
>> ++addtask validate_dracut_force_drivers before do_transform_template after do_patch
>> ++
>> + python do_add_additional_dracut_configuration() {
>> +     workdir = os.path.normpath(d.getVar('WORKDIR'))
>> +     module_setup = d.getVar('DRACUT_MODULE_SETUP')
>> +diff --git a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
>> +index b38ae50c..9fc5af93 100644
>> +--- a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
>> ++++ b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
>> +@@ -15,11 +15,16 @@ check() {
>> + # Module dependency requirements.
>> + depends() {
>> +     echo "${DRACUT_MODULE_DEPENDENCIES}"
>> ++    # rd.driver.pre is evaluated by the kernel-modules module
>> ++    [ -z "${DRACUT_FORCE_DRIVERS}" ] || echo "kernel-modules"
>> +     # ISAR_DRACUT_DEPENDS
>> +     return 0
>> +
>> + }
>> + installkernel() {
>> ++    if [ -n "${DRACUT_FORCE_DRIVERS}" ]; then
>> ++        hostonly='' instmods -c ${DRACUT_FORCE_DRIVERS} || return 1
>> ++    fi
>> +     # ISAR_DRACUT_KERNELINSTALL
>> +     return 0
>> + }
>> +@@ -38,5 +43,10 @@ install() {
>> +             exit 1
>> +         fi
>> +     done
>> ++    for driver in ${DRACUT_FORCE_DRIVERS}; do
>> ++        mkdir -p "$initdir/etc/cmdline.d"
>> ++        echo "rd.driver.pre=$driver" >> \
>> ++            "$initdir/etc/cmdline.d/20-force-drivers-${DRACUT_MODULE_NAME}.conf"
>> ++    done
>> +     # ISAR_DRACUT_INSTALL
>> + }
>> +--
>> +2.47.3
>> +
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 13251a75..04345552 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -25,6 +25,10 @@ repos:
>>       commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
>>       layers:
>>         meta:
>> +    patches:
>> +      p1:
>> +        repo: cip-core
>> +        path: isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
>>   
>>   bblayers_conf_header:
>>     standard: |
>> diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
>> index 8541574e..ccd6b7c1 100644
>> --- a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
>> +++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut.bb
>> @@ -20,6 +20,11 @@ INITRAMFS_INSTALL += "dracut-config-cip-overlay \
>>                         dracut-config-cip-watchdog"
>>   DRACUT_EXTRA_MODULES += "cip-overlay cip-verity cip-watchdog"
>>   
>> +# Drivers loaded early in the initrd, e.g. for the watchdog
>> +INITRAMFS_FORCE_DRIVERS ??= ""
>> +INITRAMFS_INSTALL += "${@'dracut-cip-force-drivers' if d.getVar('INITRAMFS_FORCE_DRIVERS') else ''}"
>> +DRACUT_EXTRA_MODULES += "${@'cip-force-drivers' if d.getVar('INITRAMFS_FORCE_DRIVERS') else ''}"
>> +
>>   INITRAMFS_INSTALL:append:encrypt-partitions = " dracut-config-cip-crypt"
>>   DRACUT_EXTRA_MODULES:append:encrypt-partitions = " cip-crypt"
>>   
>> diff --git a/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
>> new file mode 100644
>> index 00000000..db3815c2
>> --- /dev/null
>> +++ b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0.1.bb
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dracut-module
>> +
>> +DESCRIPTION = "dracut module loading INITRAMFS_FORCE_DRIVERS early in the initrd"
>> +MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>> +
>> +INITRAMFS_FORCE_DRIVERS ??= ""
>> +DRACUT_FORCE_DRIVERS = "${INITRAMFS_FORCE_DRIVERS}"
> 
> 

