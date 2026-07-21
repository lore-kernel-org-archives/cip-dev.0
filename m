Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD42DC4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 10:30:07 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19537.1784629799123273102
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 03:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=F/hOd7Ln;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxOGKIjfHjeUv3Z1ZEwtXfubqyROPZHZ7vzTHnYTh615H6FV/Qd7rD6nDGIacOqX3FWZoNhC4DoW007glQxLHwW7X9fvmfZsyuIixurj4SMeA+JWwAsN7KvhFVoAQZFyBsdrnPI2t2jFvkF/+xlUKij58nMuwTIYZfN3NDysUWqKoX3Pd5AlHeqEUd4NzeLsnWbID3Il+WcV+gfNZCUmUl+WNTe7yoMb0M24QMtXM6lLCWO7AfsYP4jqo9BHPkMESwPXo430qYghsc6evu4+EESLuBYFevTLpO2lrcY0gVour4GbVUQh11+2Qt/+d+JTGyvWRa/zcX73XFbQ9jT+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlK7BiMrQvJcEkR/lKj6zYZbbRSMtSqIxzz+3t4ypAE=;
 b=pI9JaHsov70HGAGPVNN6sEEiYELdk7Ss++kGLwHgasjMD0GJ64RDmF7jMFy0vw9gJTi6BQ0ik/iqDthhdGhtxx3Prf9HX6kh8TCXt7Fk9xXbWWAJKd85Z/lO+c2LZsVy/KT756QajmZzGahGgDvVcXbAJ8MJakTcaqoIIh7B//GNI7EgR3cuKSrX4nXycil0E2NT1QV24CCjmvuy1SF9SkIrmk5iM6rUlxSdloaM3aEOTWC/y1OsehVWZQvGZ4RNOaMh1xuGHztqeegDAOfEF1OI0xn4pYUvTH9HRf40s68rDMQ3idn07MwM3lUgncnEJ/hjTZlSoGsiWQV5TCgpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlK7BiMrQvJcEkR/lKj6zYZbbRSMtSqIxzz+3t4ypAE=;
 b=F/hOd7LnhrfKpQqFHRJnEK1Gue0d704MuFQD/UVli3UXXExsaEV8nmiO7kzOCf5wrj6ziRJFTQyiw1o5vG1ofT0YkfFY9DhKGVnrhjO/sNN38e/0SKPZStA8JdrL/uAKv97PIz3o3cWob8gEy4dtT1fr0SWV48cEIlSoexLinIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS9PR01MB12215.jpnprd01.prod.outlook.com (2603:1096:604:2e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 10:29:54 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:29:45 +0000
Message-ID: <8624d002-2fbb-476c-9dfd-6e2f95f5a72c@bp.renesas.com>
Date: Tue, 21 Jul 2026 12:29:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y-cip 00/23] Add p3t1085 and p3t1755 support
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 tomm.merciai@gmail.com
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
 <al6BmH9GeFHX1hoY@duo.ucw.cz>
Content-Language: en-US
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <al6BmH9GeFHX1hoY@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::9) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS9PR01MB12215:EE_
X-MS-Office365-Filtering-Correlation-Id: b371ade4-4dec-4657-1670-08dee712fb4b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	5B0DrAn1l5qqFaB3vLc1Lv2DNSc9UuEBrwY9OKJ3326O3zY27RTyWFFH1HiEl+K4cIbY7VIKA7PGrWTfasy3Q9CbSHgSfGLJCgNyi6WG5fPPikEzNDEsU0vQpuQQfzlRCYuln+Eifse2xW45zi7nDMYTNE020sJCj6oMkgRbUByqQpLCBJvwvGwAG9f1GzJLJOX++cj+LMEXWjkVIzYJbgB+v5r7pol8rw7VrDuVt2MiZOXQb9ZDt7LBy1gvv8WxR6EH1cIC5LprsPs09Qn5IGpav0O9wp/wdN01qdX4hlqCkSBn56BtC/NVyla9IOPe+J8RXH8GDAcdcczVGI8ENle86BkT0F3//ja3q6hnaQnqeUmax4m3RpOzS7W9QRaxbPvcTieiZqtJOuxxZHZnNYx3Gg3uXQXgIAWORm04zSM13UslCR5/ARAQfX37zhr1cTgcYQcOlyjPqN/MwZ4QalHdOz8unCuUEWn+ZjE2akvW0EF7wGR30fitRRx6cuJR8DGjWgsmlJH7+2SVTLuSuQA7gm9P7hI/RSrxxY/rkn+fz3s/zxoO1CRr18gxiybDBf+cS8N5ysRQpdwHRLrUTn2zoWwO74Qh8qLxNE/73ffN09pmrw7amoTU3LuFzzhUJk8/6CQ/ooHbqNdRAXUt8OuMIC814GxiDV8ffS+IdgI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTRmeFdnYmJOZnFBN2hWcEh2MEpya1VhemM4aWpwUXJkMFRldXNhcW95R0Vv?=
 =?utf-8?B?VFhjYnNWeDR5c3dCa25QdTRGaHM0VUhnYXdaYUpmVE83MzRCbHc3WDNBajl4?=
 =?utf-8?B?Sy93NjNVQjFXUGt2cFlTYm1VWnREa3BEb1FoMzBydkh4VmhrUHUySGtNWGda?=
 =?utf-8?B?cTNDa2JFVGozRUZNeWNsUElIT2hGelhtc3RqdG8xNDN5dEh6ZDdKMW52QTIv?=
 =?utf-8?B?SzNUMlFYNTlhVEU5aVZESS94cmRPci9TbVBXUE5KVlJyWmpRb0FkdUM5bjlV?=
 =?utf-8?B?cHNHRk1pZFJzam4wdHdDY0hIdFduakp3TXpERmY4bXZlbFhPWVFhNTQvRlE5?=
 =?utf-8?B?ZW1KYzY4cHlwbDhMdTdHS214ckI0bnk3dWU5Z3VEL0tyOG1zUHNpeGJvNWZR?=
 =?utf-8?B?MXdmK2pRVTc4STlrcWVpZ3g0VkVDalNWWDVBTkZYZVNKNXRXRTdyVnFwbGU4?=
 =?utf-8?B?OW1LTFVJQ1p0K0hKY01MR0JBOUFBY1dEWGgzS25ScmdXRlJsWFkyZ1RjQnpu?=
 =?utf-8?B?K1VMWFRzUFdIK2hhaW1UcnJnSmF1ZnZnNVcxOUlKdEg1VnNuV2pUZ3VpdUd6?=
 =?utf-8?B?V05HbVhqL1JZODJPbzEzWTFLK1lKZ0xuZk91Q1dtTVVHRUNLeGNjRGkraWU1?=
 =?utf-8?B?U2RhRWpzL3BBb3FIdkNLcDIxQVh3SXEwYTBzRWFIQ0lBaDdlTFFMdnhyNmk2?=
 =?utf-8?B?ekxxRmdzWDdjOEpKRW4rNklqOUtQbEhWS1A0YkhkanAwOFlvUUdGT055Rkpj?=
 =?utf-8?B?VlY1dDJ3c1hYbzJ4RXNQdEVaUUlmYmR3SEJXTWhBWFRTVXR4ckdBTU5rZGlq?=
 =?utf-8?B?QXNJeUFKOEJ2VDFKak5vcytNVkl3R2xHRTNjRWMzcThLSk5xZ2l3MVErbGhZ?=
 =?utf-8?B?a29ISXQ0NGxseHZMUHRDZ2pza0tzSUEycnl4MG0rck10MTkweGJZSDB3T1hl?=
 =?utf-8?B?SDljaUJXamkxMlpBQVo2eEg5OWl3dk4vejE0WUVQT3lqT0ZyUjBoNkJnNnZn?=
 =?utf-8?B?TXU0WVdJM1BOWEd4dzN5V2Q4TEVkOHRQeWdTWmUzU2NmM0dnVGZpZjMwL3FR?=
 =?utf-8?B?cWszZU9hS2RHenpZVHMzK2xIeVp0SWZxa0pTNFkyRHR0WXh0Q09TUEU0S3k5?=
 =?utf-8?B?RE5pYmkvc3g4WUxuWWpJSU16VVFvbDlUbFNzU2NhdzR3cUFsZmYrZE85QmVs?=
 =?utf-8?B?KzdWUXA3RUZaSUNqMmhzZ3UvOFZPUzNSc1RPV1djdTczNDZwT2tnYUZaUE5B?=
 =?utf-8?B?VGpUSk55OUhxMXNwWUtoUG1acDNpZzF5MnBVQUwrejhZeEVWQ0I4S0xBV24y?=
 =?utf-8?B?bmYxdjBoRGM1eFBPRXllQ0VZUmxLRVNGRS9OTUpUUlRTVStRbjljcS9WSFNu?=
 =?utf-8?B?ZnBvMytIaHN3YUJqZ0VJUEorMk53TDdCSG9Ia1lRTmxQS1pEZWN3RUsxMFJZ?=
 =?utf-8?B?aHFJb1NFK2M0M2dKcGFpVFNHWndNVDQzSWNmZE1yTUNuWmpvc05FbStVRVdq?=
 =?utf-8?B?a1pWNU5maXU2ZS9ncGt3YlgyZ0swZldneUNLZERjRWxMZGxaT1VWanY3Yyt3?=
 =?utf-8?B?VENPYVZKY1d0N0RabUh5dENZWkdCUnM0dTBaQWE3MkJWVC9NYXJyZXdtWjRT?=
 =?utf-8?B?TkRBb2xYVDkzMzRhNGY2N2FkVlBUNHNBdUJRaE9hM3QrTWlkRjFyblRvRnpm?=
 =?utf-8?B?d1JzRi9iaWNvUkkrZytZeUZJVjRSR210OUZxZ2R4N1M2K3Z0R3UwWkVwUkw0?=
 =?utf-8?B?d2JLV3NXZ0JXNnBoVy96OFlsckFCYVF4QlhjRHJHK3lWLzhNWWhUOVlQc2Yw?=
 =?utf-8?B?bk9LS3l3YVFXazBTQVlwVzd6N0JQZVJhbkpweVRXcVhCTWl6RFVFdmJHeW10?=
 =?utf-8?B?T0ZYRDBZNWlvNzg5UU9KbUxpTjg3blhudUtxQ2w3MkZsMkhpZ3dXbmNZVGd1?=
 =?utf-8?B?WHg4ZmN4OHBxNUo5R0lhVlNoK28rMVZCdjV1KzhEUjFRc2dIbStUVnN4RWdl?=
 =?utf-8?B?dmlTeXdnaWswQWdQeGkyMGh4WkdycWxYejJ0eDFGaExiQ05vSkV1NmlYNnJ1?=
 =?utf-8?B?WnNiYUFDQzhudVJiZUhMdStkOFlSbFN6UHlxdXZrUXp0aDJoSWdMMTRobytt?=
 =?utf-8?B?Q3pCV2p0ZjhmR1B3OENqU2NCTjA2emtkbE5tZ3Q3VGdUV2xNaTFMLzdTR1VL?=
 =?utf-8?B?Q2lCeHlFcjk5anBCUUd4cGx6Tm4wQUo0Q3NjdlVKYXBQemRyUGdoOXJLaWta?=
 =?utf-8?B?RUx2N25mTDZNeFZLeDEzb3hjUHZjMWJtMGF3ZFR6VHpER2x2OHZyclUrYlAy?=
 =?utf-8?B?YnQ2NG9ncUM0QlNhUURnUm8xSTBDcUd3T2U4bFBxQ0VMQVBiVmV3QzVnY3Vp?=
 =?utf-8?Q?lF5gD2upXLXvSp5wVaH6+DLaaIoUbBfPRCusI?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b371ade4-4dec-4657-1670-08dee712fb4b
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:29:44.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3A/J9JvKEVPFQZz1D8IqwESmMM6rTUZV5nTApRWR3F3f+TzArlaSCfBies4h1y0QMjELA1gM6rADJftMcpHFXuK26PthconMvyuNOkAF0Lteuhov8HicqfNR4PeYGH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12215
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 10:30:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23694

Hi Pavel,
Thanks for your review.

On 7/20/26 22:14, Pavel Machek wrote:
> hi!
> 
>> This series adds p3t1085 and p3t1755 i3c sensors support into linux-6.1.y-cip
>> kernel.
> 
> I see support being added, but not being used. Could you provide some
> background information?


I3C devices support DAA (Dynamic Address Assignment), so once the driver
is enabled at defconfig level, the controller will discover and bind 
them automatically, no static device node is required in the DT.

On RZ/G3E we already have I3C enabled [1], once the driver probes, it
finds the right devices via DAA.

Some results from testing after enabling the following defconfigs:

CONFIG_I3C=m
CONFIG_RENESAS_I3C=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_LM75=m
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y

root@smarc-rzg3e:~# cat /proc/interrupts | grep i3c
146:         11          0          0          0     GICv3 709 Edge 
i3c-resp
147:          0          0          0          0     GICv3 712 Edge 
i3c-rx
148:          0          0          0          0     GICv3 713 Edge 
i3c-tx
149:          0          0          0          0     GICv3 721 Level 
i3c-start
150:          0          0          0          0     GICv3 722 Level 
i3c-stop
151:          0          0          0          0     GICv3 724 Level 
i3c-tend
152:          0          0          0          0     GICv3 725 Level 
i3c-nack
root@smarc-rzg3e:~# cat /sys/class/hwmon/*/temp1_input
29443
root@smarc-rzg3e:~# uname -a
Linux smarc-rzg3e 6.1.175-cip57-00064-g14df706f84ef #17 SMP PREEMPT Fri 
Jul 17 12:14:21 CEST 2026 aarch64 GNU/Linux


root@smarc-rzg3e:~# cat /proc/interrupts | grep i3c
146:         11          0          0          0     GICv3 709 Edge 
i3c-resp
147:          0          0          0          0     GICv3 712 Edge 
i3c-rx
148:          0          0          0          0     GICv3 713 Edge 
i3c-tx
149:          0          0          0          0     GICv3 721 Level 
i3c-start
150:          0          0          0          0     GICv3 722 Level 
i3c-stop
151:          0          0          0          0     GICv3 724 Level 
i3c-tend
152:          0          0          0          0     GICv3 725 Level 
i3c-nack
root@smarc-rzg3e:~# cat /sys/class/hwmon/*/temp1_input
33456

root@smarc-rzg3e:~# uname -a
Linux smarc-rzg3e 6.12.95-cip27-00043-g6eb147c1a999 #10 SMP PREEMPT Fri 
Jul 17 15:20:19 CEST 2026 aarch64 GNU/Linux

I will create also MR for [2] and [3].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi?h=linux-6.1.y-cip#n135
[2] 
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.1.y-cip/arm64/renesas_defconfig?ref_type=heads
[3] 
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/master/6.12.y-cip/arm64/renesas_defconfig?ref_type=heads

Kind Regards,
Tommaso

> 
> Anyway, I'll have some minor comments here, but those should be fixed
> in mainline, first, so they should not block the merge.
> 
> This looks okay to me.
> 
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
> 
> I can apply the series if it passes testing and there are no other
> comments.
> 
> Best regards,
> 									Pavel


