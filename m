Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D912DCE79AD
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:49:30 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.40])
 by mx.groups.io with SMTP id smtpd.web10.30604.1695188969206982501
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MSkvjJ4E;
 spf=pass (domain: siemens.com, ip: 40.107.13.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIlDaWhOcn7kICn4eHJ0DKcST7nSkG17w9Pw94CMP4mdueTQXIC5HRx5pd6DqSTZ5Og8QBFUd92/Pu1Zs4aqFMuZ6Js+kXAtFs1eTVLoJsRoP4LZc1XeuSeSphuaxXmB+OhdFHFQzlyNnES37EM5K9iYY5+96M5qDC5doC3/s6Onet/ChpIwGkmWeB3erhp/ZiDGPzemhW1+mbtyh6M8+xht/lB00gOtglQ14zjN7k3xYn/rcmhCdgibdeZTWH8OC/Zwba32gqpS8kwRZ/3ojR7Fo+qnX/cd25T9o4K9Yv+ymIqxKrPZItMVDm41RLzsuAzS/BEOSjZZlg/bcuA9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15eL6vBvD0RJKP5e3Mi1aMzUXG8cGH7IhAX0BWq9lZc=;
 b=H7lHNDpvXyWbsGcFwnoMyRQCJTz+05Gn7iCdKTG+14CeSpYNODeyB69e54PifG3AtEqyIrjivwZ+xJzw8nlKNfORpJhx7hiUpkXdf9TVXlwqzzYxPc+QwHk9lklIcWqdJ7k26IzQeUjCk4JGkNekw+gRDR0Pa4BB6NgdP7lYZT4ekj6QX5YU7eHli6jLXhvZNiaOC1PTqZj3IOG3YOdBkGJsIp5dowh48hJIYERMWPrnTGkZNaa61IMQQAO+PxyG6DyQ5GlxkKhImfXiZozayyFyfPL2V9lJmMkIRlBAZetD9Uk18CRrMiDtkOCzbbERynNqSifU4s8uaOwWmVUsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15eL6vBvD0RJKP5e3Mi1aMzUXG8cGH7IhAX0BWq9lZc=;
 b=MSkvjJ4Em/5ldNyGCOwVDYx0aiYm8U4S13jLrE5zWa87EU5dclD9IYzwKL3y/HLYTMu0sBHEy3TD91wthp/gW9zJb4BDXMSvQ6Filk3P0X9Xltt/pkYnbHG87W2+oNudxHA8A7PrTTr9kG/RVah7nkFim3urgkvfHkil54iaLedpsJa0X+XEWMGyPBcnfD0t/0ZDbNW50On7LcSnlDeMLHtQ0PRdswp2exw4rDug7kj3wLPXD/KK9PA6JLpqSsaDvprQVAQcUz0lNts2t5lJMstTlOxTE50m27MZWutMz4SEEpK/Jl0h3E+YGskveUsx+MGvGp13iA05BwoWdv+jbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 05:49:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 05:49:25 +0000
Message-ID: <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
Date: Wed, 20 Sep 2023 07:49:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.194-cip39
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Cc: pavel@denx.de, uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
 Chris.Paterson2@renesas.com
References: <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
In-Reply-To: <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2c2134-ab2b-49c6-0d36-08dbb99d58bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Eto8JfUAQtEh2G/vZP/WDrJcw+yvtWQCTAIjviUyUkpTLGpLLqx/I/u8K0C4mVa329EWKebKhugOY47yShXyJF/2GdyM73O3qwsbfA3piablzqkL/v/Ovpdsu/b9BrE6k2gF4JP/FAf5L4d285bvLcWlF5XKN+J+SXgg5q1CgtNb3/qx59ssV0lTF4PrB3LLIMw3yRjQzGL2keyiNXV3ucRa4rn9BG6uSgVK//mxcv9Vij7s6lubeCHLSAvH+CQPxDLI+PhmPgUL1MQjSRJSZM1euYwbsQTw401AyD3Qq12lPc9JR0OUg2y7xK0BxO9Q1vZIPl7E+pdyfvhL+nD4KN54C4iwMw/53xyULsC7/Xdm74zzAs8PgsMGPbcYBME3g+F3DvnNPbYuhcwwkBlexfGMvHsczanWcgorkT+K76vTiHEIgzvMmFkmV2MF63RqOnwtPLIvN78TP6Js7KPTFcrdwOfgoR6IJyztaA4erjvMIBY1dpomfOSGdckWQu1/7TNeeHeinvmyeJ2w8SYRq9+AAAbPL/2L/hFx1w71Nzvhdj573I5LD6lvydK2g/LykVDCE7E2Xao5IoJsO4Lz1IijwAdw4q15EL6yVc9YGhVRyAB4Byrq7diTwmIJZHRS5HWLA2trNXuQxeYbRL6ISA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(6512007)(2616005)(6506007)(53546011)(6486002)(6666004)(83380400001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(26005)(316002)(66476007)(66556008)(66946007)(4744005)(41300700001)(2906002)(5660300002)(44832011)(4326008)(8936002)(8676002)(31686004)(478600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkVudGJNZUJYVVFPTklOUnF1VFlGbWdmcVBmMkdQaTlKVXZFZ1hzL3FYZDJC?=
 =?utf-8?B?NCtSUnVSdUkvTGdhK25OemtaMDErVjRlc01zSERrcDNaUjBNZ2tVMDZ6SXdl?=
 =?utf-8?B?WCtJWE0rV1dqQmZMUXdrelZoWXluZ2tPQTJPWUMrNnBpMWl6ZFJ3UHlVWTFu?=
 =?utf-8?B?T3JkLy9UZFAzZCtySmNHNkJJN2FHYWlNcGdJNzNITzBSVUJYbnJzdDFEcDhL?=
 =?utf-8?B?cW5lVWliUkdCcEdoZS9aemZ0Zzl3bWs3UUJBempzbWppUTRxZlA5cUJoeXlI?=
 =?utf-8?B?YUQxWmRYNU54WEFtcGJlTGkwYUd0Y203aEFwNGVpWmsrazE0cE9qQ0poLzZ4?=
 =?utf-8?B?QzkzZTA2dGVpUzEycDhOSWx4K25kSmZlcFZ0ZzVFWEtFMzAwaElnUEpaVmpY?=
 =?utf-8?B?RStLaHNIM0JaZy8zZFZsNVZiWFIxaExUNHZIYm1lQ05tcGhueEF5a1hyeTNk?=
 =?utf-8?B?V1RmUWQza2hjM1VsNmU4cHhmMHp6TWhGR1ZkeW5ERis1VW1GaU1TY0J3Nk93?=
 =?utf-8?B?dEozNmxicUpjMXpidTc5R2phVEkzTlVPTkdhaFRRdlJINzYvOTBwSHEyU2ND?=
 =?utf-8?B?ZEFkem9hakpzMHIwdFl3ckZld0g0U3NiSUJVL1ZUYmZ3V05NZ1hyTHBxYkFo?=
 =?utf-8?B?Ry9UZUpCK1FKOXgvSHBiNHdPQUlVNVRDMC8xaDlQbGJFNTQzSnlGMU9TU0dv?=
 =?utf-8?B?N1hadHhUeGtFVS9pMlZ2TkVHNTJXQnlBNW94bFFqR3puTkdYRlRKL0hzVDU2?=
 =?utf-8?B?U05UZ1V5aHlQL0RiMEgxbFg4bWk3ajBDbDNGckUvWUYzM05hKzNSZnpnK0lV?=
 =?utf-8?B?UnA2MzVPNzMzdGJRcVp2RlFUQUNkbCtrQUxjL0FnaVJJOFl3YUM2MUNWVWJp?=
 =?utf-8?B?T0o1NThPbHIyWnNtSWY0Wk5ScE1odHYzZ2RQdklNL3BoM3VmQmxiZzk2a0Fl?=
 =?utf-8?B?VG42YUZrSVhJZWlXNUZwWURDVjBqMHR3NzVLK1ppVU5mZGhadDY4NXVXNnRJ?=
 =?utf-8?B?aldhbkJ1VGh0Z3haS2ZlM2llcXZLNUdKeVcwT1lEWFZmaVQrb0VxUXZDc2NI?=
 =?utf-8?B?VjNCbUpaeGVJRmFXN2xCdDdsZjVmKzBXNHVteVBFZmQ3MjR4N3RhZEZ4aXpU?=
 =?utf-8?B?U1FqQ3VPSFAzREkwaHlLNnN3OVIzUjA0Wmw5ekdSTFh5d2xoRXNDQ3RxNFA5?=
 =?utf-8?B?OHMzTit3YXI3TEFpbG1TM3RzU3RzclBnbUpVa09RZFFoNjR3TEM2TEg3YVFs?=
 =?utf-8?B?dVFBajhYT3VKS1hCU2N1L005T0FteXlZbHVtUVRXak1DY3JXTDhTQVAzM0xY?=
 =?utf-8?B?bCtMdVFNd1NIakdlVi9yVHBXKzg4S2dxOFlqYmpzbnhvSE1UU2dab3NkMHVH?=
 =?utf-8?B?aktIeGhtRlNvVFdVb0wxMHJxN1liUElGcER2YXdXZDk2d0tuZFh2bCtzUVM5?=
 =?utf-8?B?RDQ2R3lONnR0ZjByKzBuMjlxdXRYOEV4S0l5cTRzRW03YUdBRTRuTFhLamVv?=
 =?utf-8?B?cnE0VWZhU2MrK1loa0dkaXB1SEJLa21XVGREeXl4ZXk3OXhQTTZCWEtpVVNV?=
 =?utf-8?B?YTdmWnYrcnVCTCt2b01jZ3NxWnBoOHpEeXhPd1RCTDhBdzFHOWNqUTlMV2tv?=
 =?utf-8?B?cFVzbzA2NjY2WjFOR1p3K3FjSFRkSzRsTDU3YXdTSkQwcUtla1c4czduN1ZX?=
 =?utf-8?B?U3VUaGU0bnJ3cDZkSHJoL2lmNVRLUm5ucHptT2NVNUkwdDRVMXJMZHI4ZTY5?=
 =?utf-8?B?NVR2VWVxbW12RW5CaHYzRG53Z0M3MGp2TllhZVRKdkNZaWtEb05WREk5WEdE?=
 =?utf-8?B?ZFVlWURDdmk0NTJNNTIzenUxSHh3dFAzZ2V1WlMvaTBTSVhSU2o2RFNQNGNa?=
 =?utf-8?B?cGtLREc1MmZ2SXdhSEc1YVp6d1RSVVNWSjFZY0s2L3NhQU5TeEFqRnlPaFVI?=
 =?utf-8?B?ZGFFVDR5TXlLVEV2K3FoTmY5N3R6VEpKOFhhYitpbmxGczlPL1RVWlFVNnlH?=
 =?utf-8?B?SkF2bXJ3WGttMnFqTWJtQ1FVZGRBTVpxQ2hEV25mblQ4OFV0RG5ya244WXV2?=
 =?utf-8?B?WDZpMUYzdVE5V2lEVzdmbDBWZk5DaDUwZEE4SDZDalVtWDZPRzBrSy9pMjA0?=
 =?utf-8?B?OG9IRFVGejNCMmN6YmxsbHlzVnBaQnF2TjFuOFB6czBjeGdyRVJvbVM1Yy9a?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2c2134-ab2b-49c6-0d36-08dbb99d58bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:49:25.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohUZdrl0j3OqcQGcrtN6kQE73uMWgjokMybpVSY6FPfbygD2CFXgYv/BqvDPUmrn3kMwUPCLZOtbqp/nXh2w0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:49:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13177

On 20.09.23 07:39, Jan Kiszka wrote:
> On 19.09.23 14:07, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>> Hi all,
>>
>> CIP kernel team has released Linux kernel v5.10.194-cip39.
>> The linux-5.10.y-cip tree has been updated base version from v5.10.191 to
>> v5.10.194. In addition to updating the base stable version, this release includes
>> bug fix, RTC and MTU patches for Renesas ARM64 SoC.
>>
>> You can get this release via the git tree at:
>>
> 
> Please don't forget to feed
> https://cdn.kernel.org/pub/linux/kernel/projects/cip/. I'm seeing more
> releases there, but not yet 5.10, and there are more gaps. We really
> need to switch our CIs to this source ASAP.
> 

Just refreshed
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/, and it
seems a mass upload is on its way - thanks a lot!

Now that the folder is filling: Should and can we structure it in
subdirs according to the major kernel versions?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


