Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C81C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:58 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.149107.1783337689818112206
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 04:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vFM4IPps;
 spf=pass (domain: siemens.com, ip: 40.107.130.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlsIy5DnxtLmMBqRGq/ecPVsus29uDvtPEb7cfXObQ3njP2vq/O6iPQ0S539awwxSLBSNGcFj8R18th2gkV2MCrUHULJkvQcXPCutDSsgpT0V5YvNCL/Yiv1mvVBQtlLqQxloOCU7gr+Rx0og2gjnfRd7tTyeTnaqNjmAC6SO7lYqCeWpvauX8hoggHqnVnCtAFGZeN4iHMa2hMpV1bpu8nO6oTX9R51TRkK6bNfhxK39bY0KvwL8RTzoln0MQUDtk9PcceaULvQTNx2h2jBrQYkOnpHbkl5w4seTDxFcmOOyBC3iGGSqj+nmUW1j1BeQIR/7VIhDLFudqCD/Pk7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLfNu7+C+iW0OsYyMq5yiA6zCagLZLa/PSP9YcTk9zA=;
 b=gDmrIcGt4Oe7d3Lb1KyqYkJHCD+mxH4gaq7V+h0tq6t9hmWB2LaaMyBJ8miqapt9MeK4gCPhMrPbUgO48P2n0f8hNm0LB3T+1jvuL5FiozvSTq9AeF5CbJBsU2qTwEgvI7E00Q756nY7ufjGc3t8csfkPUUz1i+BnRG0GdbBzPnOTdDyaibzbEzb/05R5bzW44uJhNTJwrxHYSxg6eoZCSyY26AIWBf2TuETkox0SuCGq7+zCFt1NYFyv8cL9ltlO5QyLabxFWWbufGObTEg3V9kPjZI8wi4YfbJgT2H8nIDkv9iUNkHFvS0G/MK4ZaDz8K4IM84dicrbgaV5FsM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLfNu7+C+iW0OsYyMq5yiA6zCagLZLa/PSP9YcTk9zA=;
 b=vFM4IPpsN62uZWyJ9bklxZGpqJMzcocRQfkdLUp75ew2Z5Knd1K/n5aJYABRCctXZXGkhjJUns/h3QLJKq9mQOfi9wyM4nM7NLE3ghfWzjgWe6nt45Ypar1a7nno25Oceu9WQV/WtRhaT75z6SwHBWhIUzcc2v6kTmq6Ar1mu0+629nLGnk0zp3hCUYr4IYjPjaaLK5S7gHrtBACynoYXyvTdI1QGzd8sTqEMDBu0LUwv8p4r1rApRo461bi3DRCTmNiA4w6YVpkXBwks1SVZjH3vuJ0Dzb7nlGvJyUCDcth5oZ729HVVC0SDxZSkewtG2oCofhmQrFNLWp3m/KAeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 11:34:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Mon, 6 Jul 2026
 11:34:45 +0000
Message-ID: <4686e19d-7585-4282-a409-3455d18a427a@siemens.com>
Date: Mon, 6 Jul 2026 13:34:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add support for Renesas rzt2h-evk platform
To: Hung Tran <hung.tran.jy@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260630085743.2655-1-hung.tran.jy@renesas.com>
 <61336493-b07c-4330-b395-0ceb67216490@siemens.com>
 <OS9PR01MB175019B1B1575056D1BEEFB31C6F12@OS9PR01MB17501.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS9PR01MB175019B1B1575056D1BEEFB31C6F12@OS9PR01MB17501.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0395.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: e9815df6-e52d-4735-3847-08dedb52943f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|11063799006|4143699003|22082099003|56012099006|6133799003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	FK+GQaa22PwB3sR87goYuvY4XKTy1Kriaqx+Gkr3dKiXUgVqLnVzp8vEUDyW4J+ifT2ujBAP+MKyKISGEz2QtqHeWksn2HBXJ/KJ6h2FEuwkz88oPrhKDvKb2esXPAaEL4gU590kvsn2wISh0kVfn+N/fwKgbNIQ6pjNZHHa3/Lrm0GBAY0AejO1RcUndoFXSM31enr0GSclUgCe8sHdsQjsVOCcDTOlSz6OXlYnkrl7zlSSIyRfneN8fMpWH/ujgycbnIkB2guOTnRgHEYbFylzPdNHBDiR4Acx6QB4rrfCiLPeCJIsJbb9B2zUbcEXChGQMKJXeUqhpO3KOE8HIkYsvGMaORR4pcBJAM5DW/2qLaNqUpoZyZnGW/wSIv6wOs1t7Vmsfp0yUpTVsg8Yt3cyANvo+2CQ2O96RSkC7po5tT9ZbSmLZ7HoZwWaQ1lLr6Alv2fcbfCxhB01OOal0RbpGb87OuJ/PNeB+OJI9i+jzDgqmo81HnNmAWbBL1Mma2Om+jcatNEgt/xN2b4dmxrVQ5R6HzZunqa42TkR9R3ahYe0SCrmijgbWZ3CIwSiT4pIXduXZgAvKPZltbleteYiLKbPUBWDpmo1ZMH3l4AbhtFxBaj9W/wMcWMrcjPabEs2YI9G9o8c/1Z+t1o1C6X3zG8ctqXOVXQlQlmPQgg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006)(6133799003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M0t1encwSkhjMFlyMk9mSHRIUGFwVHYzclI1NzJKbjlUNm5nSTRLclBaa01O?=
 =?utf-8?B?S3BrT2h5S1JFZUd3dmdTZFlxRklXLzdkVWtjbHJuNi9HWElRNWxGblhvZ0J3?=
 =?utf-8?B?U0VFZUk2bmxMc3NWRDFxRWlGeDMvTUFuYThwQU14cjl4TDdoTlV3TDQ2VS94?=
 =?utf-8?B?V2ltYyt3cFRYUkxsL2JCTDRiMy94c0swaUNwK0o4LzFzYjdtd1FQNlFoTGdU?=
 =?utf-8?B?UUwxaVdxR3FWaFk0d2xzMk90ODN6ZTBsMWllNENnU0JVbDZJUkpKTjEzMlA4?=
 =?utf-8?B?SHhlM3QzZHovL0xnQ040c0p5cFlzdW9YZWJpZjNna3lIaEkra2F1STQzQ01W?=
 =?utf-8?B?bEIvRThaMUNuTGVzMFhpY042aGZPemIwTWlBR1NnUlUzdVZjNEpwS0ZzZkVM?=
 =?utf-8?B?V2I4eVo4QVZVMVJLZndwRVJUNGNHNk9Nc0lkZzA3emNZa3IxSHh0NVRjbTFz?=
 =?utf-8?B?MjlWSUJlN3VSZ1EwTHF5T1NmUmNiNkxRY3RkQWtycDVOa1o3OVhwaG9mWkpH?=
 =?utf-8?B?d3VNRkVWUlZpK2RJWlY0MXJrdVJEWjhZd243QU5pNHg0RFIzUWt5cWF6ckUw?=
 =?utf-8?B?Znc3bGk2YTYwM2FTUWJYRCszeEFpT0hCZEk4Qi9LdzF0QnI2OE1wNXJ0Szda?=
 =?utf-8?B?eVpFbGZYLzYzeTZpc29oTHhNM2o1ZmRNWkpiakdZdzJWelMrenRGZWQ2Z2E2?=
 =?utf-8?B?US9HclJzeDVNYlB2STNtK2xOOWJuMW9yd0duVkh5blUyVkl4SmxnNTNZNnVx?=
 =?utf-8?B?QWJNajlzRnhZWXppenJmNTBaOWlxVCtSODB2NVpublVYc3Z2QVhoUU8xQVdP?=
 =?utf-8?B?eXV1TU9GcnJMR0d0TTRZcEM2Vk1CcDgwaWdBZDhGaldqTjlTaThGZEZBQ01p?=
 =?utf-8?B?RjYwRTdSSHNuYmNGSkV2Z3ZJRzBkcllqQ0tyK0N5WmZzdFBxNnBrQnl3T255?=
 =?utf-8?B?a3haZWt3c0lsQnFLZmRBWUkzeFR5SlY3SGtSYmJyQ1FDb3c3QnBRZUQzR0t3?=
 =?utf-8?B?ZWtuZUVSY0tCRldKNElmNll3YUNHcWRMMnV6RnNMOFY3VTUwdk9yN0MzV0Fh?=
 =?utf-8?B?bzAzcFRyWFBiYitEa2thVHJhR2ppcUNNd0VvR1JjSkg3SnJ4TEZVTzk1TFd4?=
 =?utf-8?B?MkpEd3QwSWd1UW1adkNCeGpEMlJkcGoyZmhkV01BMnJycmxPSW1icDdZL1BE?=
 =?utf-8?B?YXFSM2d3alVMSWZkc0lTS1FRejQyakpMYzhKcXNsVXdqc3dBQ0MvVmxtbWll?=
 =?utf-8?B?OTlQNWtDemZYSmpDc2ZVUS94NFN1QUkrcWx0OVQ5REtMYUhIZjcySzM1YTBE?=
 =?utf-8?B?WnZxRWw1b2lseUJQUzhhQldQY3JUVjVuaGREMERXWDBtemVERXVML2hraXdz?=
 =?utf-8?B?bkx5cUNHSjYrcHZqV0xGQ3ZEN1d3R3lkdDhVeFRpazJraHZkTU1Pb3JJeEF6?=
 =?utf-8?B?c1RvOUxRV2xvblpFazBKRmhQWHJNa2tGa01hajJ4QWs0a2lVaWZ0aWJuWEpV?=
 =?utf-8?B?NCtpZmh3a21rc05TTVd1VzZVVjlhODN2cUc2UFdTK2xxMW9jeFY2YkkvT2JO?=
 =?utf-8?B?ZW5LcWpBWWRGcmJiWmo2Z2JjZWxtYmxrbWRoY3M3ZGxQMEsvVHZYL1F1MmRP?=
 =?utf-8?B?dzRxT25UaC9RTlVXQmtYeTRKOVEyd0EwOTlhcEVydUVSVEpkdEo5eTZFZERr?=
 =?utf-8?B?ME1oZ3lTOStma0xraUtKc2V0MWhENU8wQi8rLy9UMFJFSlEweGJVcDZCT2Jo?=
 =?utf-8?B?YktvOG9tcnUxbXJZQXZRcEljKzNQSk9qd1ZhVlFJSkF5NndCYlFjMUFwZnp6?=
 =?utf-8?B?VHNMeUFScU5VOWpQMS9HUk1JaDR1SkpuTXFpVWk2NGhXVUhyVis2ZWdweHll?=
 =?utf-8?B?eVFPTzVtYVYzdUYwQUxCMTc5WVVscU93R05vTVVKNnpDWS93Qk1kNmdSQ0ZL?=
 =?utf-8?B?R0N5ZzByVGhPQ3ZPMS9GSGpiZzFPRE5tQjlhc0xDQkN3dkRDbE5YWjgzNUFh?=
 =?utf-8?B?WGdsOS80ZTN5NncvT2owWlFZY1BwZGN5UUljVnVHTnRUM0RiYm1mbEE5NUtz?=
 =?utf-8?B?UGJYNGl4anAwbUUvRm8wTXRSendPOUJjMkh5L2dsOXdDZnFxK2pTenF4S2Yz?=
 =?utf-8?B?bVNFS0VqR3NBSk9kVi9KclhhaWFzZWtlcnhldHk1ZXAzQ01sa0pyNkN2S0t5?=
 =?utf-8?B?UTdaNnF0ZlVjR0FPNnpLd1p5dm1qQUFjdFNHSFFidGU4OW5jZDJTdjBiTXFj?=
 =?utf-8?B?RVArRUl1Z1hSMGxIV3FXalVnd1pRYVVxdmJFNklUaTQ5S0ZYVzdSZmdHWFFQ?=
 =?utf-8?B?OEJ1dW11MFFpVG5YUlFtaWlkaW5xYk82Q2RXYThGclYxaTg2SDhFcXZ4Zzdy?=
 =?utf-8?Q?gl3rdqLqojge3P1A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9815df6-e52d-4735-3847-08dedb52943f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:34:45.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZFgXQ2k8ZdBn6AS0Xeob+OR5Q7LUixdIzb8TXQGPNlZ7H7/yH4J91PhJj0tRtv6nvbkb5CunwU9+D9s7M5T1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7727
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 11:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23461

On 06.07.26 13:29, Hung Tran wrote:
> Hi Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Monday, July 6, 2026 4:13 PM
>> To: Hung Tran <hung.tran.jy@renesas.com>; cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH] Add support for Renesas rzt2h-evk
>> platform
>>
>> On 30.06.26 10:57, Hung Tran wrote:
>>> rzt2h-evk is the new reference platform for CIP project.
>>> It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
>>> This platform is only supported from CIP Linux 6.12.
>>>
>>> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
>>> ---
>>>  Kconfig                           | 14 ++++++++++----
>>>  conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>>>  kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>>>  wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>>>  wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>>>  5 files changed, 74 insertions(+), 4 deletions(-)  create mode 100644
>>> conf/machine/rzt2h-evk.conf  create mode 100644
>>> kas/board/rzt2h-evk.yml  create mode 100644
>>> wic/rzt2h-evk-efibootguard.wks.in  create mode 100644
>>> wic/rzt2h-evk.wks
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 44f2337..879a31d 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -119,6 +119,11 @@ config TARGET_BEAGLEV_FIRE
>>>  	select ARCH_RISCV64
>>>  	select HAS_SWUPDATE
>>>
>>> +config TARGET_RZT2H
>>> +	bool "RZ/T2H EVK"
>>> +	select ARCH_ARM64
>>> +	select HAS_SWUPDATE
>>> +
>>>  endchoice
>>>
>>>  config KAS_INCLUDE_BOARD
>>> @@ -134,6 +139,7 @@ config KAS_INCLUDE_BOARD
>>>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>>>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>>>  	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
>>> +	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>>>
>>>  comment "Kernel options"
>>>
>>> @@ -144,21 +150,21 @@ choice
>>>  config KERNEL_4_4
>>>  	bool "Kernel 4.4.x-cip"
>>>  	depends on !ARCH_ARM64 && !ARCH_RISCV64
>>> -	depends on !TARGET_TI_AM62PX_SK
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
>>
>> Hmm, both target exclusions should actually be redundant to !ARCH_ARM64
>> - missed that before.
> 
> You are right, I did not notice that either.
> I will resend the patch with this part removed.
> 
>>
>>>  	depends on !DEBIAN_TRIXIE
>>>
>>>  config KERNEL_4_19
>>>  	bool "Kernel 4.19.x-cip"
>>>  	depends on !ARCH_RISCV64
>>> -	depends on !TARGET_TI_AM62PX_SK
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
>>>
>>>  config KERNEL_5_10
>>>  	bool "Kernel 5.10.x-cip"
>>> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE &&
>>> +!TARGET_RZT2H
>>>
>>>  config KERNEL_6_1
>>>  	bool "Kernel 6.1.x-cip"
>>> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
>>> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE &&
>>> +!TARGET_RZT2H
>>>
>>>  config KERNEL_6_12
>>>  	bool "Kernel 6.12.x-cip"
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
>>
>> Thanks for adding this. I think we also want CI coverage for this.
> 
> Right, I forgot about CI again.
> I will add CI when resend.
> 
>>
>> Are there plans to enable secure boot & Co., like we have for the am62px?
> 
> Hum, currently there is no plan for those features.
> I will check whether supporting them is feasible.
> However, currently upstream support for the RZ/T2H in TF-A and U-Boot is not available yet. Therefore, even if support is possible, it will take some time.

Err, that is a bit concerning, given also the problem I faced with older
boards and rather... historic firmware versions. You have upstream-first
for the kernel, why not yet for firmware? Specifically U-Boot with its
missing stable branches will cause some challenges when requiring
downstream for features but latest upstream for security.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

