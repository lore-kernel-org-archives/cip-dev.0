Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE5C433FE
	for <webhook@archiver.kernel.org>; Sun,  9 Oct 2022 08:29:12 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web11.687.1665304148447109577
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Oct 2022 01:29:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w/hn68IM;
 spf=pass (domain: siemens.com, ip: 40.107.20.76,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED652vacv9WrbPwlNqkPGsKDvR1DTZomCINvFp4UxYAaXVw5WiyqTVKbeRTcsc7xklRPhyI4LZHmctPc8S8JvgPFzBm5gJQPG4LByjB83ARHH/mFTfQKB2bYez8sHKo/yIbQyS36l7zjwUKGsupcild61H8tv93ATMeHi+jstwwa6qYQAFON3qFONqTdjoNRzsPB8n0wAyYpU6xFUM/mYfyDPJ3SNqi19AJl9darxen+CLdG+a0iZJbPDngYksVOp1Kef8ioB9WSI3e/zzDA46T9oUzA7s7rWIETJ+U5vj2M04ErBVxWT0DH+ol+VPwxWAUnU2d0rQfh9ASSDhhlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhyuDs45/j2mKDx7N3OUQrFyZxF6ukPgne7PTdHYZuA=;
 b=l8xQBZ15Wr7BIe6akA4eIxA3zNLjilGy/LlxqKOG4YVmyt/WM6NMMp/y92MFjLw90Us83yKLAmZUOqGGpHk8EOPRhpRMcSDJkWOY+umJ1n29/K2DltJbGKih5a9ETPdVzXfs6sA81sQ6H5H7Q4oSSG/zI/Km/uvwJlhDKGdn2R2kwW68jxRmNhhN3h9YNgkAA5pJz0+HKLQPZBqAUFli4q237chOq4rSXK3UiXJgh9Y2q5ZKmkUtFTD1uwzzyDxi3EJeHa7YKQHQIYEXpkBpucTAZlgaGen2+o9rhbpLb460SVPeOrn9L+/EyM1US1fo3GAMoPjuk0TGNoZ6pzAaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhyuDs45/j2mKDx7N3OUQrFyZxF6ukPgne7PTdHYZuA=;
 b=w/hn68IMmW7+/Y3rgIE1obrFE1hIGdxWPoSlIy76/8aNiBg66Dbcws5kf7atzU8K1AYfYv0hu0bUVXjTHh+asegSuoBzuW746r6uaMh/VfIg1IkWXZ7P+hQ8GIj1jJ7eFjQyfRLMXbCulOevzJ4p6zxGd1sx+LKYYR3lmE4PrK7O6kO5hjhAFra6sA6Rrf4zbDgSa/Y/pW56fAq4yk7jaouWimMSUSj/7SCRK+fmaehitGpy7MX9KTEMLS8B+IPxG3dGcSCJoDxBld6h0M+oqH32bT8897YzyTu+jX7ApI0k4Q3Mz6reo0A/DFDKhh6cwlJlzTtDeFMshyGmkLGD1g==
Received: from AS9PR06CA0676.eurprd06.prod.outlook.com (2603:10a6:20b:49c::25)
 by AS2PR10MB7046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sun, 9 Oct
 2022 08:29:05 +0000
Received: from VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:49c:cafe::16) by AS9PR06CA0676.outlook.office365.com
 (2603:10a6:20b:49c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 08:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT073.mail.protection.outlook.com (10.152.3.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 08:29:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Sun, 9 Oct 2022 10:29:04 +0200
Received: from [139.22.105.191] (139.22.105.191) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Sun, 9 Oct 2022 10:29:04 +0200
Message-ID: <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
Date: Sun, 9 Oct 2022 10:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: ldconfig segfault on RZ/Five was Re: Preparing isar-cip-core for
 RZ/Five
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
References: <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
 <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
 <20221007101932.GB25429@duo.ucw.cz>
 <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
In-Reply-To: <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.105.191]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.369100-8.000000
X-TMASE-MatchedRID: irl7E//xM945QaOxwNGfvo9bHfxDWoibL/tBTZzO5Q0sWKt1qrD4oYIX
	oaQH2H4PA1njkhEhkqCBKSUXG3panT4pF0eDRQgZPGiD7E7pfUe4gkDxrhjpU1xWWs3RUcVroIc
	Z8kDSGx0hnmSpmb/95ZVHMRn1pNBtOJjXLVcV0zwwb0BuJmG/LNSefNlpHYemJ7c39BSGIZRzpb
	EmXKopat9RlPzeVuQQQo9AVz98w389TUwxaLlryWDcNRvGTBUSc13t8ebaPKfstdmnk4+gs2WFn
	TVYc+DkwfFIH9Seo2in+DtAMiWC3bgJRK/r+AJF6Zff4Nm6w/yU+min2erZ/f9N7e3lwkwbLozI
	+rhNYbm2zFWqrVN4BZIu8BCNfKQKQY9ube1qTn6Rk6XtYogiau9c69BWUTGwVnRXm1iHN1bEQdG
	7H66TyH4gKq42LRYk+BZU/B1CVGjFBbN4ikmE6KZyZuw35CihZAW7Gmk1MZd+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.369100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 8F2AC28752A35D886B4AFCF674D67F3614B2FC051CED49F7DB3486314F6A572D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT073:EE_|AS2PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 263a15ef-d3fa-42d6-439d-08daa9d05404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E/heBZ3HU5RPmBKz5V3SOb6IX52V2CfdrZJkSe/N1w9wc6hPzrd5lnetppyVloKoNyG+6DlwB6NR0BrLPi2CrbVHA5x8aDNA14Q03LKujIE6qO5AuT7KGjq4gzsT3d5ugv5uS4t3J3FZ4IE5u1yecOIcvRy53vXtYxc2amYW0AZfARPwRCqzXRNiMLhAnFTzLc1RppI1EhAuDHdFSNvcRkPUvPq3649KlY0BJk82JleTHNUph3O49FTEkWoj3FmO6VIphdhM/mzznR6YI+Td4WDkL3GlAmTfvJ6XYulsRHQUX6cqYrZYeHciZga/7+9w+lpNt2BgDbNpKEP902FrxYHy96eOpsrfwB9UOtzkfCeyJ0XLIZAk5wZ9z4YibnnckxgjBw5EolVcVsAKrpyMQ3qFdt0GsF+/HHDXz6P0sua8EeS9RwIDHxNUCOdamAcd6g2OWm/WtDxw82oQEiXWhExiqCI8RBhz9IrAmKU5j/mqGbYNVrUnOm0mqeka/x8tWk/CzilsmACMOpszhZkeltLRzHkRBDQY+zgSa4mTzHB9fWx867iDIRCpgq4V/NVEjyqI3bCng/RzTA64hfycSNVbpv6hvyY9lPej269AyLB5PVeW4WIp83ORZpZCL8YkrPFyVliMJIOUiw0CbV8b2K+/ctqLSYVCDrExZrjDFM4pxxmaqyhL2hCrTmkRbOF3bscO1mR4+j8h2bAu7b5E0Z+d3lIgb5bV0DFy7gQkSkBCjAKmbrh7vLOnnsJMaaMCyUwwTAaBU3bzh3NebFkdkb8/dAixdX2WT9dMTRO8QCNpAzGegtlr2giRo3MR1ErP2YTRBmrT1e8HPPIpMefgH8GVXdYgysv/M79J1FiISp8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(41300700001)(31686004)(5660300002)(44832011)(2906002)(54906003)(16526019)(186003)(53546011)(356005)(82310400005)(81166007)(316002)(16576012)(2616005)(82960400001)(6706004)(4326008)(8676002)(40480700001)(70206006)(110136005)(70586007)(336012)(82740400003)(31696002)(36860700001)(47076005)(956004)(478600001)(36756003)(83380400001)(86362001)(40460700003)(26005)(8936002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 08:29:05.3422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 263a15ef-d3fa-42d6-439d-08daa9d05404
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7046
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 09 Oct 2022 08:29:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9699

On 08.10.22 10:27, Jan Kiszka wrote:
> On 07.10.22 12:19, Pavel Machek wrote:
>> Hi!
>>
>>>>>> I tried, but installation fails - illegal instruction.
>>>>>
>>>>> Yeah, ldconfig is needed for installation. But I get a segfaulting gcc
>>>>> binary.
>>>>
>>>> It crashes rather soon after startup, so I was able to trace complete
>>>> path.
>>>>
>>>>> But I do have slightly different results then you (I think; I'm far
>>>>> from risc-v expert). I did a breakpoint:
>>>>>
>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
>>>>
>>>> I believe it should not end at 0x00000000000385d4 at all. The
>>>> 0x000000000001537e jal instruction should end up calling 0x3806a
>>>> AFAICT, but it calls 0x385d4 instead. It happens during
>>>> single-stepping, so it should not be anything subtle.
>>>>
>>>> (gdb) disassemble $pc,+0x20
>>>> Dump of assembler code from 0x1537c to 0x1539c:
>>>> => 0x000000000001537c:  mv      a0,a4
>>>>    0x000000000001537e:  jal     ra,0x3806a
>>>>    0x0000000000015382:  auipc   a5,0x8a
>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
>>>>    0x000000000001538a:  ld      a4,0(a5)
>>>>    0x000000000001538c:  beqz    a4,0x153f0
>>>>    0x000000000001538e:  jal     ra,0x38abe
>>>>    0x0000000000015392:  ld      a0,0(s6)
>>>>    0x0000000000015396:  auipc   s7,0x85
>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
>>>> End of assembler dump.
>>>> (gdb)
>>>> (gdb) stepi
>>>> 0x000000000001537e in ?? ()
>>>> (gdb)
>>>>
>>>> Program received signal SIGILL, Illegal instruction.
>>>> 0x00000000000385d4 in ?? ()
>>>> (gdb)
>>>
>>> Did you try to compare the call trace to QEMU, where we divert?
>>
>> Yes, that's possible way forward, but it will require some
>> considerable setup on my side.
>>
>> If you have QEMU ready... objdump tells you ldconfig's entrypoint,
>> from that point you can just stepi. In less than 200 steps, you should
>> have sigill... and complete steps that lead to it.
>>
> 
> I've updated sid-ports (dropped the snapshot pinning), and now I'm 
> getting a page fault on the instruction before the one that was causing 
> SIGILL before:
> 
> [  558.490689] CPU: 0 PID: 3212 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1
> [  558.490697] epc: 00000000000380c6 ra : 0000000000015382 sp : 0000003fff9e3c10
> [  558.490703]  gp : 0000000000099da8 tp : 0000003fe9c3c800 t0 : 0000003fe9c427c0
> [  558.490710]  t1 : 0000003fe9cd059c t2 : 0000002acb8f2c00 s0 : 0000002b079e9510
> [  558.490716]  s1 : 0000000000000001 a0 : 0000003fff9e3d18 a1 : 0000000000000001
> [  558.490722]  a2 : 0000003fff9e3c88 a3 : 0000000000000000 a4 : 0000003fff9e3d18
> [  558.490728]  a5 : 000000000009736e a6 : 0000003fff9e3c80 a7 : 00000000000000dd
> [  558.490734]  s2 : 0000003fff9e3c88 s3 : 0000000000000000 s4 : 0000000000000000
> [  558.490740]  s5 : 00000000000105a4 s6 : 000000000009e670 s7 : 0000002b079c8ab0
> [  558.490746]  s8 : 0000002b079e91c0 s9 : 0000000000000000 s10: 0000002acb8fc9b0
> [  558.490752]  s11: 0000002acb8fc920 t3 : 0000002acb80f5d8 t4 : 000000000009259c
> [  558.490758]  t5 : 0000000000000004 t6 : 0000002b0799c010
> [  558.490764] status: 0000000200004020 badaddr: 00000000000000e1 cause: 000000000000000f
> 
> (gdb) disassemble 0x00000000000380c6,+0x10
> Dump of assembler code from 0x380c6 to 0x380d6:
>    0x00000000000380c6:  addi    sp,sp,-416
>    0x00000000000380c8:  auipc   a2,0x66
>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>    0x00000000000380d0:  sd      a0,0(a2)
>    0x00000000000380d2:  mv      a5,sp
>    0x00000000000380d4:  addi    a4,sp,416
> End of assembler dump.
> 
> I've stepped this through under qemu as well, and the control flow is 
> identical. Registers are almost the same, except for some temporaries:
> 
> --- regs-qemu
> +++ regs-rzfive
> @@ -2,9 +2,9 @@
>  ra             0x15382  0x15382
>  sp             0x3ffffffbe0     0x3ffffffbe0
>  gp             0x99da8  0x99da8
> -tp             0x3ff7e77800     0x3ff7e77800
> -t0             0x3ff7e7d7c0     274742106048
> -t1             0x3ff7f0b59c     274742687132
> +tp             0x3ff7e78800     0x3ff7e78800
> +t0             0x3ff7e7e7c0     274742110144
> +t1             0x3ff7f0c59c     274742691228
>  t2             0x2aaab92c00     183252888576
>  fp             0x2aaabaee00     0x2aaabaee00
>  s1             0x1      1
> 
> No idea if that is normal (different machines, different memory sizes
> and layouts) or a symptom of the problem.
> 

...
OpenEmbedded nodistro.0 smarc-rzfive ttySC0


[   12.829622] audit: type=1006 audit(1653987107.735:2): pid=156 uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=1 res=1
root@smarc-rzfive:~# ldconfig 
[   22.278868] ldconfig[166]: unhandled signal 11 code 0x1 at 0x0000000000000088 in ldconfig[10000+68000]
[   22.290244] CPU: 0 PID: 166 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1
[   22.298954] epc: 0000000000030eea ra : 00000000000145a0 sp : 0000003fff9f8aa0
[   22.306906]  gp : 000000000007fe48 tp : 0000003fd958b720 t0 : 0000000000000000
[   22.314973]  t1 : 0000002adf9c3bbc t2 : 00000000000003ff s0 : 0000003fff9f8c90
[   22.322986]  s1 : 0000000000014b0e a0 : 0000003fff9f8c98 a1 : 0000000000000000
[   22.330967]  a2 : 0000003fff9f8be8 a3 : 0000000000014a86 a4 : 000000000007e576
[   22.338936]  a5 : 0000000000000000 a6 : 0000003fff9f8be0 a7 : 0000000000000000
[   22.346897]  s2 : 0000000000000000 s3 : 0000003fd96df918 s4 : ffffffffffffffff
[   22.354905]  s5 : 0000002b01953f70 s6 : 0000002b01953c60 s7 : 0000002b019539b0
[   22.362875]  s8 : 0000002b01953b50 s9 : 0000000000000000 s10: 0000002adfa74584
[   22.370884]  s11: 0000000000000000 t3 : 0000003fd960ee18 t4 : 000000000000000f
[   22.378945]  t5 : 000000000000000f t6 : 0000000000000000
[   22.385051] status: 8000000200004020 badaddr: 0000000000000088 cause: 000000000000000d
[   22.393860] audit: type=1701 audit(1653987117.299:3): auid=4294967295 uid=0 gid=0 ses=4294967295 pid=166 comm="ldconfig" exe="/sbin/ldconfig" sig=11 res=1
Segmentation fault


That was the version I found on eMMC.

I think you have some real homework now...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


