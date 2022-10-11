Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1D6C433FE
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 09:30:39 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.78])
 by mx.groups.io with SMTP id smtpd.web12.5202.1665480628624210945
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 02:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lKGc79yP;
 spf=pass (domain: siemens.com, ip: 40.107.105.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNZRrSDT/Xa1cuxKLjunuBrAC4JdN0r5zkVRHVeGGsGQLIjp5bKx+XddwFmR7x+hocG+HUoea1YzlN3IXWTn79VVm1UVmLeiClGaoJN6Z7AzuA/0f4V/YNCJG8cLOzC5gALJ2EYgLnZJqoyrNLL8ei4Q856QSnWsvgtsgDnYfCH6M+zI4WURBdLW4El2TDDlCSGZuTQfkmmUOYVWRCcXXfBZAhAelhGABnn8yrZ/sRfirFR1H9oGtjZet7IkdZoSvl0ObS9Tjk31JMNIbOZjDAZKoX1fhUKs5riR/isRjs8ufcW54hg+6dzfRDwgEzCcCKsNC7hRlGAqR3V0kXpboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weblL+njUR6RuCD0wQwTKdMlfYK+/ZUSI76MRII0Kyk=;
 b=Ns7pimaLRzUc2jkr3OxBywftgMQOhwkyWY3A4TyU9LL12Pf+xaLCf3EfZjKzRZvQbyY95m1qpyRVpCIsbqVbnlKFBx0oH6TesN9iWnokLUqK/eJ77x6jnkYF0tq8QrSjXcwCcaZgX4DKxkL9BATdGXa0mFEgkg+vHvfL3om6Ik4MRSVnckJRhOZFovy9w/m9ltVsbO8fowkYAiWyFkgCsBhIZka7GzWE1PPXcAyY0r4p/uSKCh5ORtrKVeAJmhz4xF/EBPopEj3GeLN/8+LAIwgkulMT+dExWHzFAnjIvVtqIgF9sqpYGElkw7uN+fwFrwZdoVe9MaHxPoprZzl7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weblL+njUR6RuCD0wQwTKdMlfYK+/ZUSI76MRII0Kyk=;
 b=lKGc79yPxyoVGJEHb+fU4rK26ofW/bLDOGJQ00k4a1z6gcnSXCktZAv24e5sQOmOEHoJVwPFAYJ3MRq7XCdB4uDIYCa76C8JcCdkPOjj8jpMmdD+zbh9+zMN2iW1eVg3pnimMeKFh9DgNMqQI1uD8yDaGqa+39eVvmiR9i9PAVUqtslWER2z9nMwv8pn2y8tuH1ASbIZPsfS2Se+1EQYNXh3YBjPxXVlY502VzD6CFh0YvUvpI59FyCj3pd5X2OXDBQ07eBri+AOr6jNYJH51HEqyxtXNpo62C+wCFpacr3qOnFXAYiHfuSBYY24PF2BP8cYazankBOS97/PNXnAvA==
Received: from AM6PR08CA0007.eurprd08.prod.outlook.com (2603:10a6:20b:b2::19)
 by PAVPR10MB7114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:318::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Tue, 11 Oct
 2022 09:30:25 +0000
Received: from VE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:b2:cafe::88) by AM6PR08CA0007.outlook.office365.com
 (2603:10a6:20b:b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 09:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT049.mail.protection.outlook.com (10.152.3.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 09:30:24 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 11 Oct 2022 11:30:23 +0200
Received: from [139.22.42.78] (139.22.42.78) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 11 Oct
 2022 11:30:22 +0200
Message-ID: <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
Date: Tue, 11 Oct 2022 11:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: Pavel Machek <pavel@denx.de>
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
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.42.78]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.148300-8.000000
X-TMASE-MatchedRID: 5kZRuoL5N6g5QaOxwNGfvo9bHfxDWoibHodpx3o6GrsReM8i8p3vgJOe
	lX5LtjzRS8QrgUwl2ipA5vsURxCrf8H0U7+Fkd9nVDbs0z7KrCW/yjNcwjTwjCD3NF+wUeO91B5
	mjfppvWAz988bphElUWXX2yw+lwql8Z5fKpgDJPB/c62vDEKjiwgD4C8clR7V9FQh3flUIh5Y6L
	gY9oGvvxpVO2HYVB+VilvAb18i4hM76gVE1zALGgBdiROqoR5+Wka1mm48bXrc5sCn51kus8wEg
	2BXgIwXUOWdq5i7P7hPRZO5z2m2vNgyeBj5cgkC3yF7x87VPePEE0j2ROR/IP9N7e3lwkwbpWOB
	fK9L1z/e6dEbvIyrxb8/DuMc8aEuaOd0XSdhKYpGPQ7oAgOiYKLxUep06WOoWykFCbrZmkcujMj
	6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfpGTpe1iiCJq71zr0FZRMbBWdFebWIc3VsRB0b
	sfrpPIfiAqrjYtFiQTqo8a2nu0Pm7QuZzRMHFwY45fzxkJfqC9AxLZttEib37cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.148300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2A7A275FD71709D331952DA98CD177895A12C148796BD5F2DEF4400BEDAA9D9D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT049:EE_|PAVPR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a7f9e7-2c8c-4c86-7ad0-08daab6b397d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ACxtfqFECmmfgIfeeTqy37Ok35bJrko/xxU76sN4j4RSBZ7HSAnAmJJPzngyfwHCOgKc6EuMAYkRji6j+JjCR2sFREItjaKK4926ezzufNInyxyvP2HG/zVCh6OS0wzYdVTyihTG1V3FL/ulYU7/7bK353iJmEGjS5xiCZCWqJQrKc7P+ZHDqykUKbvRUVkgZ7rV+dRxU6czSmdo2GZWXmW7nCA/RAPLRkSoqfq034lEdlMm4Mnruj6x0MjxOfWV7TCxQMEpjaDzbVpSW0NwpA3J/rPFoLVOijGDFJbuLD4GtrldwlE/QBsMHpMd6VZZyawPcOR7+HBCJlzgHlHZQkdHXRK5bdofSg8VjubhiJEBMc2/THGO9oF6SqCLlF/xzz3F0ksLFg2510ss9mxMy7Nbt+oYLoHno8ye+bukfMgRA8lwbphHG/wKWfz9XB3XnUgBmTIVnw8v7l0MkZX8+C0i0SVmD78+mrEfr4J0ZILd2pcL1MgiqU2qV9GTgQu8N1SUOGMI8U/EtWkM6RQUA+EAmcTQ5ffcQmo1gCrx21UCrjwfw7rtLcyLxWLJgMVhLSfVoyzlk6oT4Ug24XDEjXHWas6ArFKt7CW+d9BU1bSFtFRfaaQyKXgyprxCL9NCuLcWIJZEAr7WC05W9q5AP2CYOPWbXWUYz4EEKwXPsLXxqQ+6RXVFpNhNEjmFFx88GspRO1sD6SpzwvYMkkzFOkh2CGrDgRcHhsjdlF28A/6uBUY+o+VxJfqkyd5k9IxCNuXebPvJMeja5b5QPW56O2eAtOp2quIJ6JdxK3u9SXqZxCLY6zyxGfmtNOtC8HwX94iaCCZR9U/5LWgrgo+Qlp3KJCG/akSvdfFOI1neCR0=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(336012)(6706004)(356005)(26005)(36860700001)(2906002)(81166007)(82740400003)(53546011)(16576012)(36756003)(82960400001)(70206006)(8936002)(186003)(40480700001)(110136005)(478600001)(8676002)(40460700003)(316002)(31696002)(70586007)(4326008)(41300700001)(83380400001)(86362001)(31686004)(47076005)(44832011)(5660300002)(956004)(2616005)(16526019)(82310400005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 09:30:24.0096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 08a7f9e7-2c8c-4c86-7ad0-08daab6b397d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7114
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 09:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9708

On 09.10.22 10:42, Biju Das wrote:
>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
>> isar-cip-core for RZ/Five
>>
>> On 08.10.22 10:27, Jan Kiszka wrote:
>>> On 07.10.22 12:19, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>>>> I tried, but installation fails - illegal instruction.
>>>>>>>
>>>>>>> Yeah, ldconfig is needed for installation. But I get a
>> segfaulting
>>>>>>> gcc binary.
>>>>>>
>>>>>> It crashes rather soon after startup, so I was able to trace
>>>>>> complete path.
>>>>>>
>>>>>>> But I do have slightly different results then you (I think; I'm
>>>>>>> far from risc-v expert). I did a breakpoint:
>>>>>>>
>>>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
>>>>>>
>>>>>> I believe it should not end at 0x00000000000385d4 at all. The
>>>>>> 0x000000000001537e jal instruction should end up calling 0x3806a
>>>>>> AFAICT, but it calls 0x385d4 instead. It happens during
>>>>>> single-stepping, so it should not be anything subtle.
>>>>>>
>>>>>> (gdb) disassemble $pc,+0x20
>>>>>> Dump of assembler code from 0x1537c to 0x1539c:
>>>>>> => 0x000000000001537c:  mv      a0,a4
>>>>>>    0x000000000001537e:  jal     ra,0x3806a
>>>>>>    0x0000000000015382:  auipc   a5,0x8a
>>>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
>>>>>>    0x000000000001538a:  ld      a4,0(a5)
>>>>>>    0x000000000001538c:  beqz    a4,0x153f0
>>>>>>    0x000000000001538e:  jal     ra,0x38abe
>>>>>>    0x0000000000015392:  ld      a0,0(s6)
>>>>>>    0x0000000000015396:  auipc   s7,0x85
>>>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
>>>>>> End of assembler dump.
>>>>>> (gdb)
>>>>>> (gdb) stepi
>>>>>> 0x000000000001537e in ?? ()
>>>>>> (gdb)
>>>>>>
>>>>>> Program received signal SIGILL, Illegal instruction.
>>>>>> 0x00000000000385d4 in ?? ()
>>>>>> (gdb)
>>>>>
>>>>> Did you try to compare the call trace to QEMU, where we divert?
>>>>
>>>> Yes, that's possible way forward, but it will require some
>>>> considerable setup on my side.
>>>>
>>>> If you have QEMU ready... objdump tells you ldconfig's entrypoint,
>>>> from that point you can just stepi. In less than 200 steps, you
>>>> should have sigill... and complete steps that lead to it.
>>>>
>>>
>>> I've updated sid-ports (dropped the snapshot pinning), and now I'm
>>> getting a page fault on the instruction before the one that was
>>> causing SIGILL before:
>>>
>>> [  558.490689] CPU: 0 PID: 3212 Comm: ldconfig Not tainted
>>> 5.10.83-cip1-riscv-renesas #1 [  558.490697] epc: 00000000000380c6
>> ra
>>> : 0000000000015382 sp : 0000003fff9e3c10 [  558.490703]  gp :
>>> 0000000000099da8 tp : 0000003fe9c3c800 t0 : 0000003fe9c427c0 [
>>> 558.490710]  t1 : 0000003fe9cd059c t2 : 0000002acb8f2c00 s0 :
>>> 0000002b079e9510 [  558.490716]  s1 : 0000000000000001 a0 :
>>> 0000003fff9e3d18 a1 : 0000000000000001 [  558.490722]  a2 :
>>> 0000003fff9e3c88 a3 : 0000000000000000 a4 : 0000003fff9e3d18 [
>>> 558.490728]  a5 : 000000000009736e a6 : 0000003fff9e3c80 a7 :
>>> 00000000000000dd [  558.490734]  s2 : 0000003fff9e3c88 s3 :
>>> 0000000000000000 s4 : 0000000000000000 [  558.490740]  s5 :
>>> 00000000000105a4 s6 : 000000000009e670 s7 : 0000002b079c8ab0 [
>>> 558.490746]  s8 : 0000002b079e91c0 s9 : 0000000000000000 s10:
>>> 0000002acb8fc9b0 [  558.490752]  s11: 0000002acb8fc920 t3 :
>>> 0000002acb80f5d8 t4 : 000000000009259c [  558.490758]  t5 :
>>> 0000000000000004 t6 : 0000002b0799c010 [  558.490764] status:
>>> 0000000200004020 badaddr: 00000000000000e1 cause: 000000000000000f
>>>
>>> (gdb) disassemble 0x00000000000380c6,+0x10 Dump of assembler code
>> from
>>> 0x380c6 to 0x380d6:
>>>    0x00000000000380c6:  addi    sp,sp,-416
>>>    0x00000000000380c8:  auipc   a2,0x66
>>>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>>>    0x00000000000380d0:  sd      a0,0(a2)
>>>    0x00000000000380d2:  mv      a5,sp
>>>    0x00000000000380d4:  addi    a4,sp,416
>>> End of assembler dump.
>>>
>>> I've stepped this through under qemu as well, and the control flow
>> is
>>> identical. Registers are almost the same, except for some
>> temporaries:
>>>
>>> --- regs-qemu
>>> +++ regs-rzfive
>>> @@ -2,9 +2,9 @@
>>>  ra             0x15382  0x15382
>>>  sp             0x3ffffffbe0     0x3ffffffbe0
>>>  gp             0x99da8  0x99da8
>>> -tp             0x3ff7e77800     0x3ff7e77800
>>> -t0             0x3ff7e7d7c0     274742106048
>>> -t1             0x3ff7f0b59c     274742687132
>>> +tp             0x3ff7e78800     0x3ff7e78800
>>> +t0             0x3ff7e7e7c0     274742110144
>>> +t1             0x3ff7f0c59c     274742691228
>>>  t2             0x2aaab92c00     183252888576
>>>  fp             0x2aaabaee00     0x2aaabaee00
>>>  s1             0x1      1
>>>
>>> No idea if that is normal (different machines, different memory
>> sizes
>>> and layouts) or a symptom of the problem.
>>>
>>
>> ...
>> OpenEmbedded nodistro.0 smarc-rzfive ttySC0
>>
>>
>> [   12.829622] audit: type=1006 audit(1653987107.735:2): pid=156 uid=0
>> old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=1 res=1
>> root@smarc-rzfive:~# ldconfig
>> [   22.278868] ldconfig[166]: unhandled signal 11 code 0x1 at
>> 0x0000000000000088 in ldconfig[10000+68000]
>> [   22.290244] CPU: 0 PID: 166 Comm: ldconfig Not tainted 5.10.83-
>> cip1-riscv-renesas #1
>> [   22.298954] epc: 0000000000030eea ra : 00000000000145a0 sp :
>> 0000003fff9f8aa0
>> [   22.306906]  gp : 000000000007fe48 tp : 0000003fd958b720 t0 :
>> 0000000000000000
>> [   22.314973]  t1 : 0000002adf9c3bbc t2 : 00000000000003ff s0 :
>> 0000003fff9f8c90
>> [   22.322986]  s1 : 0000000000014b0e a0 : 0000003fff9f8c98 a1 :
>> 0000000000000000
>> [   22.330967]  a2 : 0000003fff9f8be8 a3 : 0000000000014a86 a4 :
>> 000000000007e576
>> [   22.338936]  a5 : 0000000000000000 a6 : 0000003fff9f8be0 a7 :
>> 0000000000000000
>> [   22.346897]  s2 : 0000000000000000 s3 : 0000003fd96df918 s4 :
>> ffffffffffffffff
>> [   22.354905]  s5 : 0000002b01953f70 s6 : 0000002b01953c60 s7 :
>> 0000002b019539b0
>> [   22.362875]  s8 : 0000002b01953b50 s9 : 0000000000000000 s10:
>> 0000002adfa74584
>> [   22.370884]  s11: 0000000000000000 t3 : 0000003fd960ee18 t4 :
>> 000000000000000f
>> [   22.378945]  t5 : 000000000000000f t6 : 0000000000000000
>> [   22.385051] status: 8000000200004020 badaddr: 0000000000000088
>> cause: 000000000000000d
>> [   22.393860] audit: type=1701 audit(1653987117.299:3):
>> auid=4294967295 uid=0 gid=0 ses=4294967295 pid=166 comm="ldconfig"
>> exe="/sbin/ldconfig" sig=11 res=1
>> Segmentation fault
>>
>>
>> That was the version I found on eMMC.
>>
>> I think you have some real homework now...
> 
> What is your conclusion? Is it tool chain related issue? Or cache related issue?
> 
> Or
> 
> Something else ?
> 

I have no idea and still only limited knowledge about the arch and this
SoC. We can just rule out by now that the issue is Debian-exclusive.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


