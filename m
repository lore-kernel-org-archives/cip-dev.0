Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F73C982FA
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 11:11:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7589.1790075511287668706
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 04:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VrXiWKEE;
 spf=pass (domain: siemens.com, ip: 52.101.66.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbomWw5BBg9pTIhuBy0LTixM+LX/F/LREg8Q3SxnRn5Ew1se3uPYETxsZR0jlpwUzRQk7oMpOX/VgycNYg/htffZ+1UPmUfs9dVgfGV6+Kod5TxiB7kOnNMUEqMwCQkExRG2Q0gpKt8WTrSEzszA0cNGhcIcONhTUu1ku1gB3epy1pKt43PdN0aUaR0nj54clNopn8HoIphmHlt3M2F5VhV6KDO6XFrD7gY+f6PldzfxXm78akijt6vDTMu0RQ4TghJ3L0qRbrkbz47bJRbv3uK7+JL41jWX+kaUCDC7HsqaskpNav+jH2Vgiu+KeVCGQkmQ8sjC7x2gY1g4oMMP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ1CAseXDIy7uy3AVNKNhU9ev09GqA5Qc4qMxaxn2as=;
 b=hDXUndXwkWLgu4yPD0wJpivDisq2nQLURH8MvRNwT8/gapVrU5C/iYO8Sj97f/TTVXUSgK6UwA6etIhX4DUgop06/FEV3v8NtZ8+xYrpIN75phnDmquPlGKEdttjFpBqfstiGaSVmVpHQqQ7z6/2BZRjoeAz1fCylIwoTQJCud00ONL0Ocd1WrjfAWikNC1BTpnpMh6m06VRVG9Xy7sYw4Oup7dXLCvNquBgCs1OQ4oOX7/dq4UmSW7nswnfOmCdCDrIHbfWg33twEuE1nn95fUSG82F1azC2aOAgLXQLgYLtO0TGagNL7jzumBDx94qoZGe9nkBdGF88/7+vtCRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ1CAseXDIy7uy3AVNKNhU9ev09GqA5Qc4qMxaxn2as=;
 b=VrXiWKEETIrZICOFduC/dY8Kr0r3aDeWsm4OwC4Zd/HpFlPwLw27Bl4wRfXDu8JUVLarpGhbWxLo0xqCC4GDyoxhkaf9t12jxYqZoZjlnEIS2bOP8vcBrvzq74EXZ+XdtA/03Gs2Dbt8dFxuX4zD5SSSHvSJFA81MxWDHVjNxANLTNRMJfXXs6Hf7NCNTRi6mWvNz/CiBqnFB7YEvMu6on1wZpBXu0zaEyL00TltztOq+HprWqoDh0a5zRlG2kJns5B5Pj3rkX42MzGE12p2tVmqvKx8ALgA+krLwHtTzj44sDTXC8kIwZzhEqXm/9hM+TTqmzu9anihYMooVL0xFw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB7993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 11:11:46 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 11:11:46 +0000
Message-ID: <c0b977d2-1c5e-4cc9-90d7-9d130cb125ad@siemens.com>
Date: Tue, 22 Sep 2026 13:11:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 1/2] Add support for Renesas
 rzt2h-evk platform
To: Hung Tran <hung.tran.jy@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260721114828.1390-1-hung.tran.jy@renesas.com>
 <20260721114828.1390-2-hung.tran.jy@renesas.com>
 <4db6bf49-db59-46c2-a627-2567ae26058a@siemens.com>
 <OS9PR01MB17501027233C38A8D0D49E0FCC6872@OS9PR01MB17501.jpnprd01.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <OS9PR01MB17501027233C38A8D0D49E0FCC6872@OS9PR01MB17501.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: cc96587a-9191-49f1-9e73-08df189a4a89
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	yPpv78Z6aji1t4DAXQXPMtEhioRcWeAOhiJEF7RG1XeR/8e2yUDINJ6i3YXxfR9nLN5w8GRBZ0OZepD9mZAHplhcuVqBdybK+LLrLrMx/4HlzwFbtWy/ANFiaL3Zg5ApxTf6Y/7/duyC/qqvTnmqMVB0NPiR9SZzBGw/oztRRN9h/BMJYOGiDxQY0m2PabpZ/L+AaEHZlvgq2aJ1ZyII6uRue6qWNAdhDikEw18s1MOoiTGLU9xRJviuMnOkh5P4DPNHo1WV7aP1OLMC3mvWryLwAzX0yRzJJCKwrgmZhc7G6wApaek+2TuyCZ5LHPF8D6OTaspIjFa7gnh0g6CD3JmaRKxZNChWX5yiyJd25TAbaIstXTqYyISFPrnM+QyCqkqjKrdP2hBRWnozwmfYfNEejfErngNZ3E9CqwN4lJeba3WX4xg3Gea/M+57DZyoKBb9KhA0d/dKCp3aykyO85VI8EU0nRpTWMWC3pdT/+ltZNjCdd7mBjEHXETrjmv8KSsANkWh0qDs/y0eFlrTfIQ1sOTssDn3khzTHw7rfgBQ4HpLUhVZW+xQy8W4U+daLaxxAF782jJKH7FEL24WB3mRIB/N5CD69ww009zMx2HWcsX/7afnrzXxHdg//OUFFFrihz7d+jLy/ZOVyCYYjn+bxjgASXYpOpecOiEbhrA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUUxTndjenN6UldpWXB2TkVGMmFydVJrK2FQM1l0Z243YWN6Nno4MnJkblMw?=
 =?utf-8?B?TjhSQXFEYTdrTnNRYVZ6eHJ5Z2NwTWI1aEYxd1AwSXg1SW5Kdjd5eVBHMGZJ?=
 =?utf-8?B?ZGRiVW54akFnb0pBQllpQ2wyOGN3UG5hTWVBUU5VdkYzZWtFSGhKczk3WkNS?=
 =?utf-8?B?V2pXaVpLdEgwNytBemRWZlJaTGRKQWZUOEExZlYyRlZjbVVHa21lR2Y3UUUx?=
 =?utf-8?B?NXl0elFSckZKOW53ZEhPOStEc2ZGTUZiQjFJZkZzTXNhS1dCRUVEcXBkaE5v?=
 =?utf-8?B?MWs4VWwrRk54MmRCQWlTQ2MwbjdoMk1EZ3ZsVm1qK0xaMWNEWGF6dFluSjlL?=
 =?utf-8?B?QW55cEhicWJxTXJ6U0tXWURheWxMb2U0WFgrUlI4cGYvRWZkVVltd3lzamZM?=
 =?utf-8?B?Y2lFYk51clZlTm1vS0Y2SEhZK01HUGE4UEZURUQzMU9ud0xVeEI1dnp3c3d6?=
 =?utf-8?B?d05XdWQ1QzNhKy9VQUJUaGhxM3RBTFQzalVGSDljd2l5R25hck56b2VwaldX?=
 =?utf-8?B?alB2VFNqTGJCYmVPclhTY3ZJV0k0V2Vwc1VRcVVtNjVOczNNU2xOQlJyQkFq?=
 =?utf-8?B?RXNQYkkvcEhlbm0vL0IxQ25ja0diNVY0Q0ZYV3Q0TEdNZ3AxUXlPaWRzSU9h?=
 =?utf-8?B?bzZwaGhhbzhxaDJtUk9zZTM4ejJseWh2b2NiWndoNVV4M2p5ZkZsUHdZaVND?=
 =?utf-8?B?WTF4MVd5R29iNFhBMnF3TVB6SUtNTnp6L0xNRERqbkVaRmtRaHg1Q1JhK0xx?=
 =?utf-8?B?dzlKdk11bHF1U1ZjaGZVN2g0UjVWUWFtbnVqMklVU29mREpVd1l1dUorOTRr?=
 =?utf-8?B?S2k2QmpmalA3eE5qVjhmYTdwRjlQTk8vblF1SXlSaENoMzZzL0p3YXZKNU9D?=
 =?utf-8?B?M3dWYTJGYWNjK1J4TS9iY2V2L3Y2RTVBejVadUtNaVIvbi8ybjNrakdqaURy?=
 =?utf-8?B?RDRkZTZjemlRakFIR1lwVi9xQVRlZDNPakhTK3JVK3dxNHBVT3J6QSt0Wm5C?=
 =?utf-8?B?MEEwd0RvQjc0V1prQVE2QmpON3NOaXk5OVQ3QXVVditFdVQ0cDIwVnQyQndE?=
 =?utf-8?B?VkJ1WjNEeVhxK2pxa1dCb3FpZnR5dWx2SWFmcmdaWTN0WGtZY2ZyaWRLajgz?=
 =?utf-8?B?VDRDT3RESHBETUMxdlMrTnNJSFEveVNJUEw0TDlJOGVnZTR6YnpINUljdkpp?=
 =?utf-8?B?U21GMVpoQ01VVUNIdDZkQUMvSVZ6TmJTQmhSZHdBZisxZDBySEp1M1h1MXN4?=
 =?utf-8?B?SmlaZEV6RzRqejhtVXVldTdOd3hOUzNaeUJiUzRhZitkZXlka042TjVJSEhB?=
 =?utf-8?B?cUVSTk82VzZ5bmJqWFhYcEFadHhscTlBdmh3SklGOEJxZWhYVytlVlgySWo2?=
 =?utf-8?B?MUQrNUtFR3FQZk9ORTZwUyt1WVFzdFRaSno3bExNd3g4d0NLellRSlJoOUd4?=
 =?utf-8?B?M21VMVYxNXRMYzdsRzc2MnN0NFBicXhOL1Jhc2MrOVdWWFVrckpiN25EMUhT?=
 =?utf-8?B?cjRNYjhhSERuLzY5czg1QUFieHhUTHJQWGtnNmg5TG5YellvdEREcWpLWkVH?=
 =?utf-8?B?MngyUVZwcjZVdllSTmw4VTk3Ti90N0FLWFJmNGo0bXVLYzhrL3EydmJOVlV1?=
 =?utf-8?B?M05ZTFRqZkljYXdldDdhNkowSHpDdTN0NUtPNExzSjhISWE3NG45d2JJWlpv?=
 =?utf-8?B?NGNaalk4Tm9QdWcxczVwWGtoYXFHY1dHVjB0dXpkQ2JEN1B6bHFnTU5MYyt1?=
 =?utf-8?B?SGNTZk5GdC93aDJoUkhoTkxvenp2YnRsd2lwOStKd2pNV0U5ZG5rQzVjbjBK?=
 =?utf-8?B?aWxPd3NpeGV3VHBOZ0ZUekgvSjlaRm03a2ZsTWxtOE04eHI3U0hUaDdyRTU2?=
 =?utf-8?B?NzRUS1E4YklsZzE1KzlFZEc4Y3hXMzFxL210aU1iZ0ptTjdjOHFvdUM3VGIv?=
 =?utf-8?B?YXpKOTNTdnpod242ZDZDRjgvOGluUU5rd2JJb0Q0Y2RQSHlIVnpPcUIvUG9r?=
 =?utf-8?B?M1B0OEJsNmJsUU95cHhlMlN6aXZJc1hYOUVoRVN5WEZLa09MLzMwTjFmcmxJ?=
 =?utf-8?B?RFhxMm5Reld5VzBleHNwT2ZwUHNQbGVWK1FwcEJDSncyMGowZXVlZXpldjNk?=
 =?utf-8?B?RUM0SEJVdHhWb0tadGUrZ0VLaTk5VkxRMzUwcjFaZGcveGVLSkIzRjRwdjQw?=
 =?utf-8?B?dEJBem50bXNIUGRmMlgyL05lN3pXd1d1NzhMWU9kZDhKb0ZROGIzaVlMNVVG?=
 =?utf-8?B?V2s3U1lreEU5TGNyeTk3TE5kUWhPaXVZTlYwY2t1NmpFbHk4UitxR0d4QU5D?=
 =?utf-8?B?N0huSWdGSk85ckJyYlBGbTR6dzMvOWcxc2poc2ZFMXBhNUE3d2poMFo0aUUw?=
 =?utf-8?Q?k4bg5IuTVDdqh2w8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc96587a-9191-49f1-9e73-08df189a4a89
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:11:46.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coz24YbQoqKak9djlUYrkaRDaWud4WcquPjRhHt4sCYeGPbMqOOD7CPEchkEufQAfElhlLuV27l2l/DT5oBkHaigfvhtV7GD3Hb44ROF4X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7993
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 11:11:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24261



On 9/18/26 11:20 AM, Hung Tran wrote:
> Hello Quirin,
> 
> Apology for so late response...
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf
>> Of Quirin Gylstorff via lists.cip-project.org
>> Sent: Tuesday, July 21, 2026 7:33 PM
>> To: cip-dev@lists.cip-project.org
>> Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 1/2] Add support for Renesas
>> rzt2h-evk platform
>>
>>
>>
>> On 7/21/26 1:48 PM, Hung Tran via lists.cip-project.org wrote:
>>> rzt2h-evk is the new reference platform for CIP project.
>>> It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
>>> This platform is only supported from CIP Linux 6.12.
>>>
>>> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
>>> ---
>>>    Kconfig                           | 12 +++++++++---
>>>    conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>>>    kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>>>    wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>>>    wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>>>    5 files changed, 73 insertions(+), 3 deletions(-)
>>>    create mode 100644 conf/machine/rzt2h-evk.conf
>>>    create mode 100644 kas/board/rzt2h-evk.yml
>>>    create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
>>>    create mode 100644 wic/rzt2h-evk.wks
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 438234c..6894e87 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -119,6 +119,11 @@ config TARGET_BEAGLEV_FIRE
>>>    	select ARCH_RISCV64
>>>    	select HAS_SWUPDATE
>>>
>>> +config TARGET_RZT2H
>>> +	bool "RZ/T2H EVK"
>>> +	select ARCH_ARM64
>>> +	select HAS_SWUPDATE
>>> +
>>>    endchoice
>>>
>>>    config KAS_INCLUDE_BOARD
>>> @@ -134,6 +139,7 @@ config KAS_INCLUDE_BOARD
>>>    	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>>>    	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>>>    	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
>>> +	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>>>
>>>    comment "Kernel options"
>>>
>>> @@ -149,15 +155,15 @@ config KERNEL_4_4
>>>    config KERNEL_4_19
>>>    	bool "Kernel 4.19.x-cip"
>>>    	depends on !ARCH_RISCV64
>>> -	depends on !TARGET_TI_AM62PX_SK
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
>>>
>>>    config KERNEL_5_10
>>>    	bool "Kernel 5.10.x-cip"
>>> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE &&
>>> +!TARGET_RZT2H
>>>
>>>    config KERNEL_6_1
>>>    	bool "Kernel 6.1.x-cip"
>>> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE &&
>>> +!TARGET_RZT2H
>>>
>>>    config KERNEL_6_12
>>>    	bool "Kernel 6.12.x-cip"
>>> diff --git a/conf/machine/rzt2h-evk.conf b/conf/machine/rzt2h-evk.conf
>>> new file mode 100644 index 0000000..5cfbfa5
>>> --- /dev/null
>>> +++ b/conf/machine/rzt2h-evk.conf
>>> @@ -0,0 +1,18 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) 2026 Renesas Electronics Corporation # # Authors:
>>> +#  Hung Tran <hung.tran.jy@renesas.com> # # SPDX-License-Identifier:
>>> +MIT #
>>> +
>>> +DISTRO_ARCH = "arm64"
>>> +
>>> +IMAGE_FSTYPES ?= "wic"
>>> +
>>> +USE_CIP_KERNEL_CONFIG = "1"
>>> +DTB_FILES = "r9a09g077m44-rzt2h-evk.dtb"
>>> +IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
>>> diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml new
>>> file mode 100644 index 0000000..90261dc
>>> --- /dev/null
>>> +++ b/kas/board/rzt2h-evk.yml
>>> @@ -0,0 +1,15 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) 2026 Renesas Electronics Corporation # # Authors:
>>> +#  Hung Tran <hung.tran.jy@renesas.com> # # SPDX-License-Identifier:
>>> +MIT #
>>> +
>>> +header:
>>> +  version: 14
>>> +
>>> +machine: rzt2h-evk
>>> diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-
>> efibootguard.wks.in
>>> new file mode 100644
>>> index 0000000..ca18bec
>>> --- /dev/null
>>> +++ b/wic/rzt2h-evk-efibootguard.wks.in
>>> @@ -0,0 +1,14 @@
>>> +# Copyright (c) 2026 Renesas Electronics Corporation
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +include ebg-sysparts.inc
>>> +
>>> +part --source rawcopy --sourceparams
>> "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --
>> uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-
>> 3D69D8477DE4 --part-name systema
>>> +part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align
>> 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-
>> 8483-4772-8E79-3D69D8477DE4 --part-name systemb
>>> +
>>> +# var and optional home are extra partitions
>>> +${WIC_HOME_PARTITION}
>>> +${WIC_VAR_PARTITION}
>>> +
>>> +bootloader --ptable gpt
>>
>> This looks like a generic ab-update wks file. Can we reuse some of the
>> other wks files?
> 
> By "reuse", I assume you mean creating a link to other existed wks?
> Yes, it is possible to reuse some other wks files, like qemu-arm64-efibootguard.wks.in
> However, this wks for rzt2h may be updated in the future to add bootloader (allow booting using bootloader in SD card).
> So I would prefer to keep this as a separated file instead.

Ok thanks for the info then write that please in the commit message why 
you created the new file.

Quirin

> 
> Regards,
> Hung Tran.
> 
>>
>> Quirin
>>> diff --git a/wic/rzt2h-evk.wks b/wic/rzt2h-evk.wks
>>> new file mode 100644
>>> index 0000000..4a4af6c
>>> --- /dev/null
>>> +++ b/wic/rzt2h-evk.wks
>>> @@ -0,0 +1,17 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) 2026 Renesas Electronics Corporation
>>> +#
>>> +# Authors:
>>> +#  Hung Tran <hung.tran.jy@renesas.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --
>> label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --use-
>> uuid
>>> +
>>> +# Rootfs partition
>>> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align
>> 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --use-
>> uuid
>>> +
>>> +bootloader --ptable gpt
>>>
>>>
>>>
>>>
>>>
> 


