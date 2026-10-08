Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FDECA600B
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:18:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14034.1791461929356403480
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2026 05:18:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Agjsr+Rn;
 spf=pass (domain: siemens.com, ip: 52.101.70.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTI+ikwVQzJ05DhgDjWFI54N+a1Uth+4jwNoJvq+JSJYuJ789noCCz6wIh2SLbJaTs9/emFf3pcMbs7odwF1cjtcDRnUflBp180vs8hw8Bbq8Gb0I2QB8xygr3CVeThOiGRWXRrRsLI8iccHeXlusPpuWb61+R8JzjMDJvHddV1n5AVhf9Q/ECU6BxVNZtFEvA+T41uAAnwck0vkF3ROjuMWFomJy728I8WHerxDWv1SkqWktLvoHp7Ahzz/FlcEsrv2ULM3SwkJUznTmAEoXZizSWYJJdl842KDSAbLbbClSrTIqwSSi/T0pj0mr29auwDfAnGi1heGYpkJSM872Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjutdKVBewxawQRFpd7WbwiPOsCdE6NlXB7psaUZMmg=;
 b=j4qJ5oPlVt+jYVlKUKT0vo79kS6YpcxspfbhwtW1IKwPma6NcBI9A4He0i52fcM+uV8YPNsJWoY/9H1oBd8chgWtXgDdVyQU9oJm1ihRyuBsy2cXFT9vz7fTQQCUac2r8eEVdLP7gsxHjpVWsfAtnklouciBA3x/9j5X766o6pN9t4yQnppmXJIxiLuXKVFl7DFCqofOGzxX5Ip7q4BaFqktU/918pueO4W5EagUur4SbIH3blrq9jK0iGRJ9MHLRujh81gVZmW5K1pBxmV3OQ+J38MqjS9UMzOjDNV62m9NdfKgHmVm7YqxdWU74tlrShd5IsOqJZtPRmC6rx+LTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjutdKVBewxawQRFpd7WbwiPOsCdE6NlXB7psaUZMmg=;
 b=Agjsr+RnQtXVvg1DcD/y7VmFi9RKnHkKkcOgn7rzVdSGH//c4B7vk9iJUcoqi6DBq/zyNuPyAclOBVL9tEkX9lIPQftByUqlS51z90OPPh4QyibHv/x9x4trb5xLQkbPUPixLwnm/b/Hw5oJKEXuCl53Tb6LlCg3/K6tEcnTp1liCSk20a6qI/mWhefKNTK42kXjpP4t5wtC3jD6YIL+iGfyK1+uZoUWu5pfdzxo+LqsD3nicts5C3jDdn8j5IH5gmb+NLAWsvHFCJRmYVOlhVe1mqz6nUbL7E4MP1pO4zgOnuV/NDbfB363aAZuf10xFMl3r88mITtsL9ji+lIbJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAXPR10MB7927.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:24d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 12:18:45 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:18:45 +0000
Message-ID: <c20b75d3-96ac-4c30-a3c0-9819268df5c9@siemens.com>
Date: Thu, 8 Oct 2026 14:18:44 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] swupdate-handler-roundrobin: Fix Lua version for bookworm
 and bullseye
To: "Prusty, Badrikesh (FT FDS CES LX PBU 2)" <badrikesh.prusty@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Shivanand.Kunijadar@toshiba-tsip.com"
 <Shivanand.Kunijadar@toshiba-tsip.com>
References: <20261006033242.301666-1-badrikesh.prusty@siemens.com>
 <4853f7c5-df38-431f-a7cb-7b80e2a781ee@siemens.com>
 <JH0PR06MB66564EFFFD8AB7076AD5375791952@JH0PR06MB6656.apcprd06.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <JH0PR06MB66564EFFFD8AB7076AD5375791952@JH0PR06MB6656.apcprd06.prod.outlook.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAXPR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: dd950e0b-22a4-4a9c-86e9-08df25364c71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|6133799003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xAytwcuPBGtyP18t0qJ12RN7FtShRmOOg5/WVdio/ndD3MZJziroDfpmFF7PtIh4aiuF/Urc2ZlK7IuEfCKeOjdK/LWcy4U0vEaeJ/wWu20mROG8KJzSgrU3fuTnT0VLvJulXPhippclgN5EOpxxhb6LeyDP23EIeIenDG5i5d9kyEhIJtb92DpDK8juYJyNJdHmhF46d/6HL0ow7z/H7EF5O6gQ6rkk0zXAjyJjj9QCTt7jtecamTOX5zbjZnw8YTgJ7Hul4hDVu3/pVeiYH3rzcW8OW0Ra5rfqJk922BTjsspaf5e6hSKdE8wC6KaZTEAKBoyZjv9LHHrpKEQpctkIaEXeqgtj8i+cCpsKWkHiKSrjhThkKPMFfiU0e9zXRN246DVHikXjTsEWbkaQZO5oIkG1dxrOO1H494fexcY5kE/02auRiSyhdkvknClVCsfV7FQSY1WsiVWdpd87bTNT4Jf8uzJhuSg/4rn2QrY3PQVK8eRvNWnidlW7g9WDNPnHucLu7fqdkDtjlUIM1eWfqOLQBOKZsZyIY3imIgit78O89jnXBOAJQqd4Xn1uZZ/4sL5brLK26nnIV4e4Aw4lrHiIqL6BHT+CQX9+oablESRANkRw30NhVXWGzCZBMFnQFtMG8M0TBRNbl+xkTOszoDKfbDIPsfUMIWrOwsk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(6133799003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QnhFUnRsZEg1TUlCcmVpK1EwV0gyd285Y013ZGdSVVZER1lUYmNuZUlRSVFq?=
 =?utf-8?B?TkFGa2xudytmY0lrQkVWR09xbjQ1V0g3KzhlV2I2b1NzRmZZZTJzaDNwMUVG?=
 =?utf-8?B?TXMvTDFGVEU4TFUrZENQR2RGWmwxOWJ0UWJsUDY3OTBoNzBubkhHOTJuSTZK?=
 =?utf-8?B?YWJQK1RKS2pROGFmRzN4QndUYTdwelZhR3ZhUGF1cjkwQkQvb0dQck5CVm81?=
 =?utf-8?B?RzBJOHhHMnpyU0NhT1Y5MVhxVm1Ya0VoTGZkTkFOZGJQVUVDclgwY1lpVzdw?=
 =?utf-8?B?Zk5KKzMrY200M1VwbHVrcFQ0Nkt5bXRNTkhzMGZXN21TZDVXbGN6SGM0bGh6?=
 =?utf-8?B?Y1NsL0VBeHVuSzYreExxZStHN2VUQ3RPckNjZ2o1Vmx4TTNWUUhmeW05ZXcv?=
 =?utf-8?B?UUl5N2g4YURxTitwLzFmSHRkVHh4Q29oOVlzYkpmMjJ0U0VHYWU1QW9zWkhp?=
 =?utf-8?B?TkpySFVJbFZQc0tPbHpPWkdUQy9ONGdCL2FjdXN3a0ZFM2kzMU4ydncrOTBm?=
 =?utf-8?B?aWxiaDNuMFgya3pVZXVKb1Q2V0M5bHg0Vy9WU0tMNzRTMlpEWnZuVmV3QjhI?=
 =?utf-8?B?VWFrNHg4c2p4dDI0bDNVSENUK2c0RCtEdnhpU04xUmtvcFg3dEZyRE5lbnVK?=
 =?utf-8?B?MVM5UVI4cDk5QldKK2J4eGtMbWJoOU1vcExvTG9yOWRLd3lNa2dlekVpSFkr?=
 =?utf-8?B?UFFSaGhVMHAvT01oY2tZcnRZUDRoNllaN2JIZ05VT2NMeVJZc3ExRDJqZzYr?=
 =?utf-8?B?VEJQZUlvV3Boc1U4bXpWR3BwVmN2Yi9ueGxKRXBucGJZRkhJSmdXM2RvMzZh?=
 =?utf-8?B?YzArMmZBa0p4N1l4RHF3SU1UVVNkdTBXZFQrbDVlQldsZmtDMlZVbnBOaERT?=
 =?utf-8?B?RWozbmUxYkY2WHpBK0NGVURncisyZk1nem1rWXJycTNvNWNUOTJ2YlRWaDlP?=
 =?utf-8?B?TW1XQXdjRW9SZUcrTEFwbHBNY2ZLVEpVSmlML0NMZDlldW4ydjc2RmRyc08v?=
 =?utf-8?B?MmdLd2tOVEhkMGtFRnBLemhOQ0w4dng5c2h6cWVyMTZ1NW1LRUpscVJCMXlO?=
 =?utf-8?B?SjdMRDJ6dlZlUytkM1UzYnM1SldPVXg2b3dwZGFmTy9nZVl0MnR1MHRxK2lj?=
 =?utf-8?B?cXVIM3BpNFpsMmYyRmR5MTV3RFhUeCtXWEVqL2d0T0gzVnZpZk93OVJETEVW?=
 =?utf-8?B?Z2F5TW13VEhVZWZmRTJOUGhENTlhd1E4cDdIMlZzZ1pEQ0tzRkViVjB5RVg1?=
 =?utf-8?B?YjNoL3daK3dtWkpCVjZUblpjRXZXaU5TODZxNExobk0zQ0xOZC8vNk9ySGNS?=
 =?utf-8?B?VThpS0dzRHFtdDFGb2JLWFFEd3VaZG5jeDhFYnJJMEF0NWZ0cFIvWElYWmJB?=
 =?utf-8?B?ZEVMRXNJTUcybTlFVjlYNUpnY244d1BpRUtLK3dMb1BzRWhMZlB6MU1wVUZ3?=
 =?utf-8?B?cEt1ODBpWUpNLzlnUWs0Y0UyS0h6N0dHTW4yUUUzbFlQYTc4cGxiM0Q4Z2Zm?=
 =?utf-8?B?eElzTm5FTlZCRnpzWDBaWTNzQW9XMkk2ZzFVSmpobUpjbSt3elV1Tlg5REhX?=
 =?utf-8?B?NmdjbkZoSmx0RGlKTXFGamV6Q2xmR3NGYkNSZmpTZWFaZXhwZkVuR3BOL3hW?=
 =?utf-8?B?d0xkb3E2QVQ0clpzY28wSndJc0NMaE9UWXl1YVJXcnZBemtNOGoyU09Gdnlp?=
 =?utf-8?B?VG0yd2hlbmpSQXprSkU5MWl3UDBVY2R0alUvWk5HdVpxWmFjWjZSZFJIWDAw?=
 =?utf-8?B?eEtMMVZmMFpCZWZMZlZNQi93U3VybmpHRGk1ZjFYOEFCYXBuOVdKVWMvVEc2?=
 =?utf-8?B?em9GanVUemY4b0RXSEVVcXU0UHVOV0dyMTNiYjFFYnc2SUMxWDhXZW1pMGhw?=
 =?utf-8?B?dTJPcUEweUdHeGtJbHJKMW9xLytsZGl0dEloVlphQ09pMmpGTVJGekRaTDdn?=
 =?utf-8?B?dlgrMnptU0hYZHBIY2FqVU1zbGxDdGltcVZNbTMvOXhqeFNkWkdyUHVraHVt?=
 =?utf-8?B?OFptaE5SZ3NIT25uUmhvdjVpQnNvbHVDam5ibkEzRkV2Y1RJMDhJeE9mMzhK?=
 =?utf-8?B?azdXbVRaM1cwZm5tYmgzaXdLeDVocWg5VWl1a0tFMEI4US9kdVFyeEF6aXJY?=
 =?utf-8?B?YWtrLzRGVUhRSG55emlvbU0vS3A4M3FVWGthby80SS9IaTI1dTNtcElGNFY5?=
 =?utf-8?B?NEN2MElTVUZUNjFKWURCQTBiNVBVaWtYdWhLZ01GUUJuQmdKVGdkZDR3Qkk4?=
 =?utf-8?B?UnVBa2ZNTUdNeUJvZTBuaHZvMTBCVHY2VVF2ZXFiUnZGZk9mSFkyTUxNOGRG?=
 =?utf-8?B?bGNDUDdNbjhLSnNITWczQU5yc0VUNCtuNnJsWllnaHJJd0FxL2Nudz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd950e0b-22a4-4a9c-86e9-08df25364c71
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:18:45.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9XqcnQW8A1y4pwikn66JVHaNzyozgJ9IQuSzOJY8AQxli8rUDb819k2eNvoVCUFmUTonOcFzfTgYRVHYpTioA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7927
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Oct 2026 12:18:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24440

On 06.10.26 11:39, Prusty, Badrikesh (FT FDS CES LX PBU 2) wrote:
> Hi Jan,
> 
> I triggered a build test with Debian Buster and checked the liblua version, it looks fine as mentioned:
> 
> ```
>> ./kas-container --ssh-dir ~/.ssh/ build  kas-cip.yml:kas/board/x86-uefi.yml:kas/opt/ebg-swu.yml:kas/opt/buster.yml
>> grep -i liblua build/tmp/deploy/images/x86-uefi/cip-core-image-cip-core-buster-x86-uefi.manifest
> lua5.3|5.3.3-1.1+deb10u1|liblua5.3-0:amd64|5.3.3-1.1+deb10u1
> ```
> 
> I tried booting the wic image in qemu, but it didn't boot for me, it is stuck here:
> 
> ```
>> qemu-system-x86_64 -nographic   -drive file=cip-core-image-cip-core-buster-x86-uefi.wic,format=raw,index=0,media=disk   -m 6144 -smp 6   -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE_4M.fd   -device i6300esb -watchdog-action none -netdev user,id=net0,hostfwd=tcp:127.0.0.1:2222-:22 -device virtio-net-pci,netdev=net0
> ...
> ...
> ...
> [    6.715105] md: If you don't use raid, use raid=noautodetect
> [    6.723136] md: Autodetecting RAID arrays.
> [    6.726506] md: autorun ...
> [    6.730546] md: ... autorun DONE.
> [    6.737420] Waiting for root device ...
> i6300esb_timer_expired: I would send APIC 1 INT 10 here if I knew how (XXX)
> [  320.315352] kworker/dying (107) used greatest stack depth: 13760 bytes left
> ```
> 
> I'm not sure if there is anything wrong with the QEMU command, but the same command works
> with the Bookworm and Trixie images. It may be a different issue specific to the booting Buster
> swu images, which we can address in a later patch.
> 

Did you use start-qemu.sh? Which kernel version was this (or which kas
build command)? I built with 6.12, and that worked.

Thanks in any case. I've applied this patch to next and finally pushed
that for CI.

Jan

PS: Your messages do not seem to make it to the public list. Please
check for bouncing errors or anything else indicating problems.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

