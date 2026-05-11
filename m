Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D26CD37BE
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 16:26:51 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.54501.1778516808864018897
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2026 09:26:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LUmYePLv;
 spf=pass (domain: siemens.com, ip: 52.101.83.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDibkwQ5MkIrOZnhF13aDruxkg3IY8aktupk02bkBn6434aICw0Qm9dSD1Nu7hIa5FSo/x3Pi2XwRzcqAb2qGxAVAgCn0q/qpHWTFOnOdMndAtdZIpahfso5qOnRHBatnBb2ZekXiQWGlYoB7OTyv6invI2fCCoS4r4IzeISQnnqX1+jBqfo0/bzESfaJBuSV9YZkzmhe6DEy0kb6jExMWiL+xC14vF6KGTTI5P/cxBYwj0bdeu0F2YhN4c145Nbfsd7rImTzvK+y3HGSmzM2fgrMPcih9JhnhIQL73f8r/ftGcK5RAWaBIN5Q1SYzDqdriUzDLzUmaJ0qYn/W+i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPr3MCJKFTpNJyVqKcbWSQaIGS6VzNBw2VDXE+qw3uY=;
 b=iRWwXyEFXs3YDrtGXd5di0NtP6TiSETpQk6I1NBV8Ih4IvAjxTFI4LMFseggMHC8ZGyDsOzEq6QnctNV3XGcOTnfTO+PytP6uJvZQWywoErzAx5GRvIb2PKFOYXvPZSXud73ILYBwMMi0e5fsi9CYgq+ulXp1xR9LNXKHD2hxKGWFwK9LSmDGkX/lojbvWFI8THeqwS6MjLSB6xyYSxFihMTyFfks2dAY9EDDadxtakyEOasqxZGKbRnGLKJCZadAFS9GVW5Q0pqc0rEMtTLohykC+0kVhb/Lf9aQ1V0PenCbpLlDYNcT2XOqsOfdsxMA+Gdz4h4NfcRqtzllz+Otg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPr3MCJKFTpNJyVqKcbWSQaIGS6VzNBw2VDXE+qw3uY=;
 b=LUmYePLv5vZt8GFbMAbaVcV59AKHfl3JOSOidagAqdV8+uCkDNmooCzhXaIdoCGXeaBtrSzR0FtZi4tIsg8CWD5c0d0zsxl9zyUXx8H92LFcQJOJYglF9dwxeJkJWV7w/WyLGf0BzOz1F+N5RKp+/go6L3gFgNcHiPc+CccUpdUmegyD6HGkjFpSLjwn96li05gVc4PPGPsdVR7O45Wa0dO/BA6p4XahxU2PX/cRWFMAC63jzVzQIX8QZXgU8d70dwM2lFd4QHDIp5ccxXalWMX6BnWsQmJztLO6JrxhoGuuKyLUesKMpu8a9LeEIcSpBX9pFGpg5uo2egNmxfxtwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 16:26:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 16:26:44 +0000
Message-ID: <f3936f46-549c-425a-bd58-c60705be5c21@siemens.com>
Date: Mon, 11 May 2026 18:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 6.12.y-cip 00/12] Backport PREEMPT-RT support for ARM
 32-bit
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
 nobuhiro.iwamatsu.x90@mail.toshiba, Bryan Brattlof <bb@ti.com>,
 Daniel Wagner <daniel.wagner@monom.org>
References: <cover.1777964226.git.jan.kiszka@siemens.com>
 <071e371c-ef56-4296-a001-0ad992b79bca@siemens.com>
 <20260511135739.uPbxWz1w@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260511135739.uPbxWz1w@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 26da9181-77bf-4570-ece4-08deaf7a16ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|11063799003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	fetHFHX9LS7ruQK4EOyFMOkCdFLZgaGKQyiBkVTA4epVefrsi3L0j77/4laqKRMoMRJO3O9h+mo1ns8fd4r1lObbdx6/XS2unvYjL0IGJMLe0U0EsWjyrXzG1cH494fgo/Ze7rxB+kbrgilogedbccr4wWdmXNjn6oM2iHNvsMV6rkK5W21Ff23JPByLVE8pk2JBcZeMlwpKRbVkP13ExsaiuG8LbxydG2VK/92T5gDygugwqnR0TQWIBPFcGUd75EPLCT9gk6zWVpQzlqGcnGCrdMuEFWvB5Rz6JYvSNdLwNjg1r4OEDTtOt2lTeDvUojLw9Sysz5XXKPd6EXwW1qumeqQN2rddcG//8dhCIlYJyF7hYRfZXD4AGUYRnvs1WBVxLIFNNvZvYPghDv3amDZnGqZcZWkHouFdEb/indqd6BeUDLqe9ndcKyv0+XtOEyZyElXGZLGKaRnUE3CIrRS9oyRbmzwKHxNtM/la0lZCfFhwDeEYEJmA6mFdbKUSz7yp4FC7VipAfEiMdVoxjLgpTpCl9x6rIUYIs5OkzXn+amJthiM+bgye67l/QPyHBHDR5ROGXUloA69mANxhjPdVUTN8e4/nUbm1uarjDa9hESBoIq0YLbqDPfOUgXEDbuvdXr49nSuRB5PYQVEyz4V3EUtMOZJYsUbvgftSi1amXMBSi8IDXnRiy9jZd7jj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(11063799003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1NpZUs2OURFUDlFZWFKV1RBamk3a00zZktkSUNFZS9OQmJzamtKUm9KVVZi?=
 =?utf-8?B?TURtWUJvTHB6aXdvZXlCRmp6aWIxN3dscnlVM2hrcVZwUjhmQWdYN29sM05K?=
 =?utf-8?B?SHplZEFneWV3YVlXM3lrU2RCRTl5QlZoVi9IN1ZwMDN3Vk5rU2tJb1RiSWQ2?=
 =?utf-8?B?bEQrTkk2WHBudFNDbFl0UzA2ZVB1QkVpWnJFc3JkbEV3V0FTQnJLN2FzalM1?=
 =?utf-8?B?Tjg4N1owaGNuWURyU2dMVzRnTXF1OFFhVkxJcXZYc3R2blI3SDVwN1VkZHdE?=
 =?utf-8?B?eXBoMGdIdmEwL2QzMkE0azhsN3ZSWEIreXorQkdvNTloK1UyT0srQ09rOU16?=
 =?utf-8?B?YmtTdVJ1eHRyczN2Q1FxeUVNWVNEdnovQnBFbXNYZktIV1FNRWY1cWZuZ3g1?=
 =?utf-8?B?TnNVR1dhbHEwOWtKNll4ZEEvZy9BRDZaVk1ZbmxENGhWcFh5dEVWMHpiV3pC?=
 =?utf-8?B?RTcxei9iczZmUDFMVTZaSVllTy9jRzdldDBrT3FmM2FXL3F6STl1NXpuMWFR?=
 =?utf-8?B?T29qWS8xek1scVhRb3hYV1JwYWJITVNnTzVkVnNsR1ZiUE9kbkRpcjhOU3pr?=
 =?utf-8?B?VU5HZER6STI3UXU3elNQMVlyTmRpODJYMjd5bkg0RmVpdlVjcGRpN0x3RFM4?=
 =?utf-8?B?VW15aVBaaHg4YjBtcjVzRk9vRURERjdzczlIczFQaldmNHhSeTJBcWtCV3J4?=
 =?utf-8?B?MG5wTyszOGF5d0cwY2ZLY3UxRzA1NE5WaHlPcmpBUm9aeXQwZ0l6N1RxclVC?=
 =?utf-8?B?VGRpMithMXdJYWNlUHNjU0VFWkhyWWF5T01ySC9IcDh4eG85SFNRRDZWQWpz?=
 =?utf-8?B?NCs2WGZKL1Q1cVJZdGhjSWNnSmR0SWNkMDAzcysydmY2L3BaRXlZYWJJZ2lt?=
 =?utf-8?B?R1EzWGJDL0tVM2tpQ0ZuOFZIN2JRSi9lM1BMMlZKakVCZFhBR0lrNmh0ekdM?=
 =?utf-8?B?NDRTT05YVmlDdVlETHpNZ3h3OUJXVzVPcDZoUFFWSGdUa1NmSkNINHZwR2RC?=
 =?utf-8?B?THg1SEdqdGhnczllbGRHOExxcHR2a2tMRHZLK1NOelpKTXlVSEpxOEVWRDZl?=
 =?utf-8?B?Q0svWGxOR29JWG44TW82cG5uVmIyVmVwWkhoRFVnYnN3L294QzRXeDdhNmNq?=
 =?utf-8?B?ampBaEM5QXhHSmpTQ2NmS21wMnlIajNnS2FlanY3NEs0VWdNdkdoWVJOdFcy?=
 =?utf-8?B?QTRVQzQ1ZXpucHNWVlcrUGVYdDdNc1E4YUFQUWdDdzI2MEIzelF1a0FLRVY0?=
 =?utf-8?B?eHVnazhYbXR1Rjd1ZU00WUYyaGFqOG9VbVFDOUYxRjlhZWR3dktONU5CL04x?=
 =?utf-8?B?UUtmQThsdW5mdHpYNnJUZzdyS2Q1ODhscjlRbG1kNmR4Z0lUcmUxeG1WbENM?=
 =?utf-8?B?K1RJQWhlbU1QVmllQ0E4aGozdUJZVUZJUFN3TklqaW02L09NVklKMlRYR083?=
 =?utf-8?B?Vk9mcUpqZlpSMEVXVURBb3EzczV1NFZ6SndQSGlPVGZtUGl6QkNJRTM0Q3JC?=
 =?utf-8?B?L1E1eVBVZGpXVlZUVWhZZ2hkYlJtS0FQdUlPTjJNVGI4N3V1OUVUYnhmRVE4?=
 =?utf-8?B?NndCNHlsQUdweW80YUZkWVBpS2RRT3lNK3VSNmlkdzJxSnVQYWJSYkhWVUk4?=
 =?utf-8?B?UXorZnVGaUhZZ0h5NVdNeDk0a1ViUkNzMDl0VWJxTnV0aXpMVXpCTVBVRWVo?=
 =?utf-8?B?WTJRY2I4Q01KUnFTendXbGFwTHhyZVo3QngwWlVkakxFMFY1RGZPSGw1WTZl?=
 =?utf-8?B?c3hhMzF3aVpId1hUcVZJZjhJVkNwRmM1ekt4UEkxVXRXeVY3ME5oUzFBcDg1?=
 =?utf-8?B?VVQwZ2xRWUtteEVLUDBNKzV6SmtNWDFPQnBBRVdjTlcrdnF2dW5RUVZ3dnhX?=
 =?utf-8?B?SnVPU3JGTG43dnJvMGM1Y1ExVmtWUkJibmNKQnBJUXY0RGg5Y3JFWkgxM29Z?=
 =?utf-8?B?TzI0UHJVMEF4eGEyRXhDc21qYVhpRXFKLysrTDBxZU50dGRZUnlXVUhUQnZQ?=
 =?utf-8?B?L0laN1pseEFmeXZNU1cxNmZVbnVYUE5SSWZTdlUxbjFST0NxTGtISlJMbndi?=
 =?utf-8?B?S1NsU0dWWHJyV3JhMUlBMkxOenB1RFZHS0VseXVaa0hwSHpkcTdXcE13NWxU?=
 =?utf-8?B?Y0JLbXhoOElsNWFKbElhWUh0N0dCQUpYQTBEcjd0U0hxZFN0TUdaL0ZIUS9C?=
 =?utf-8?B?QlNQd1g1bWRxRFNxUnZtSXU4aDNkdW1QUVAyb3RxQTcrd2c5Qm0zREdwMXJQ?=
 =?utf-8?B?MlFtNUw2M29meXRUb0RvaU9vZDBzUGgzSG5SNjFDUEhUb01RekQrcmRWMVdz?=
 =?utf-8?B?T095TmdNTXVJU3AzL0pzb2JDN3FtS1paOGFON3o0OWhZdTljUDV1YXhzS2kr?=
 =?utf-8?Q?T5fh0LmepjM5PIvE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da9181-77bf-4570-ece4-08deaf7a16ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:26:44.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P990n7nTucDZE7kGJCGFEpJHTU+08mJsFP2xtPjSvJU0EEupDM2KWBbnYGAIbOU4hLYltiO41h8nBWDKoEFHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6419
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 May 2026 16:26:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22919

On 11.05.26 15:57, Sebastian Siewior wrote:
> On 2026-05-05 09:02:02 [+0200], Jan Kiszka wrote:
>> On 05.05.26 08:56, Jan Kiszka wrote:
>>> A first attempt to backport the recently merged ARM 32-bit support of
>>> PREEMPT-RT from 7.1 to 6.12-cip. Only lightly tested so far, first of
>>> all looking for feedback regarding completeness.
>>>
>>> This may also be valuable for 6.12-rt as this series should be able to
>>> replace all patches tagged with {ARM:,arm:} in v6.12.79-rt17 - adding
>>> Daniel.
>>
>> Grrr, CC typos and misconfigurations - at least no overshooting, it seems.
>>
>> Daniel, Bryan, lost you on CC for this series.
> 
> I made the following:
> | ARM: group is_permission_fault() with is_translation_fault()
> | ARM: allow __do_kernel_fault() to report execution of memory faults
> | ARM: fix hash_name() fault
> | ARM: fix branch predictor hardening
> up to here for stable
> 

Great!

> | ARM: ensure interrupts are enabled in __do_user_fault()
> | ARM: 9459/1: Disable jump-label on PREEMPT_RT
> | ARM: 9463/1: Allow to enable RT
> This would go to stable-rt. This does not fix anything !RT as far as I
> can tell.
> 

Ok, then they would be equivalently relevant for 6.12-cip

> The four patches for stable have been sent.
> 

12-7 = 5. One is "Allow to enable RT", obviously needed in stable-rt and
-cip then as well. What about the other 4? Not needed in a backport?

Thanks so far already!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

