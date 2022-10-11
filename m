Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D275C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 20:15:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.63])
 by mx.groups.io with SMTP id smtpd.web11.12387.1665519333994637035
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 13:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PDprg8xR;
 spf=pass (domain: siemens.com, ip: 40.107.20.63,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8uyjehH7rBsJy0aVqgc3TZRTTvqrwbabZRjL+tdutv/sgeKO1v7TbqbwP4lZaPA27Ja0vg1R/8gvr+b2NXOUOC7CjPFwDJhDYrXvAW762HbEUeBXaMCQHUnFkWDfK9M1RKEp648BCqUZFZHha3/TSro+9JOlz8+al4GfL+p4hFQJMOGeM4XQlrVays6RAtcdEetNPAeL2EmjmbwY/dUdjbCkhqEZBgGBgRhOK/DdNzHhFV3O33v0MSWKSMEh5qbdYD2BzsKHnFpDI3qDV/QeG5Bfz2JBDekwoEMuivogaPpRN0jLB4k/I71vKinQFo9zpGG8yvLQemE6ZjetYXxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+2K+umy+DzWCdWaSUZJdh3eE5d7VRuWwkvLyuAuNKs=;
 b=NIoSR/qVKwgF44kk5jtjd7ERquGk2lOrZ6UHV1UxhYYsB4YTjJT/KBy4/TipxC2tmkvSX0O57iYGlnDxWB2vh0Ib3ALS5llHJNWKrNwhGZ+CKF2tsQRhHVyOx09OnFBIHbeneYKUec5rxJ99TlNfLVcLpjz4FO9ctP/G/jLUN4XKooEWEpuTojF+5gQdBPOqQZeaa+3maiW4lA682bLD+6QE11KgEJElAfHS+TPyotBKhlhZYCpHD65+93TF8Lu5FpSunrxjJG2GKRKt2U2B0JyXzqA2heF2SwHyQZQbYnJx/h5EL6eaiJ+yLvLAdl/94Ng9Va1ZVNVWSTlvVaPtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+2K+umy+DzWCdWaSUZJdh3eE5d7VRuWwkvLyuAuNKs=;
 b=PDprg8xRBEMcqzksN5E0cZfAhK57v89UxrsMCOFgYaxrbdOtajBFdheFpyTrhNjaFmFOzGNw7YjCFI9Boo9uZX0au1ta0f465nAIH3z4dw5IIw9f/BWTQSOxLN0OC/tfLu66Zaukg2Z5sTzDjGTzbLAc93mKxlXYCxaiWw3ggc/4MbolnOuKGz0BLr1y1lhDndwVgSdHqdN295nZd8aW7PHcfkDyAT8ZDjMd9rmgULO0fd2XcJfdQQLU7LJUUAUlyZz2LGpIdoRccsL3Bdrys92CBjZ8gGcGqbZeuqIlFOdH2lc82bmT3GTdbYRp/mluIvyr5d+0g7O+5pjf8P9/wQ==
Received: from GV3P280CA0054.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::24) by
 AS4PR10MB5442.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.40; Tue, 11 Oct
 2022 20:15:31 +0000
Received: from HE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::29) by GV3P280CA0054.outlook.office365.com
 (2603:10a6:150:9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 20:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT024.mail.protection.outlook.com (10.152.0.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 20:15:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 11 Oct 2022 22:15:28 +0200
Received: from [139.21.18.118] (139.21.18.118) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 11 Oct 2022 22:15:27 +0200
Message-ID: <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
Date: Tue, 11 Oct 2022 22:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
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
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.18.118]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.512400-8.000000
X-TMASE-MatchedRID: tvpRZv6Yx1Y5QaOxwNGfvo9bHfxDWoibWi7t2dR1S0aVUcz8XpiS9DZl
	Y6a4lRLZwJa/c39cf5Z5a5jlCfYvEssa/vtKhbyFYUsdgbbgf666LacOIlEHv6JVTu7sjgg1nrr
	V5UnUVY0nXBZmkoVhSQFfgVTicugFzlUnZ/pDQ2eh/o4FZ060+RDmAkR0f0rqJNzc11O35noO9z
	+P2gwiBTtctZCezmMoyyjsfD8e79IFGPl7f2/94cRHVbsXvW+Ixile9V7rDZVLQaU8f2RHciDiV
	mfWTJMNUsOUOXBaFw2oVB4D3nL7ijjZYh7kebJ3nArk+q2OwUsZ1VI1DVL4ZZ1U1lojafr/AQ8m
	tiWx//pjjMm9SMavFXW7HSPhvJoSQiL76oEZoLq9aUis95CJVq88naeSWWBZpKSqN+Z3dp47F3Z
	cdQmMK/754++Cp0gqQks1KHhBIF0T14JAeJ7ZoqdMya3b6yFKle+q6k7Q/cwvzLls7HTfGa85fL
	DYlgpSmyiLZetSf8nJ4y0wP1A6AKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.512400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5E3D5E8575D2BCD0DB6C000BE487F3AF7AFC88EFE2CCBBBFF7954EC210EB8D932000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT024:EE_|AS4PR10MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b08ca9a-92b4-47e5-1894-08daabc5586d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1kqgPS48c5ILsRI+lP4e5WT9JP0g+4CWVTu0WVNzCkjb4wulyuoPkm79Q/u4RO0hTevT5mMUdA8irw991qVkleJ/jRAernU+RtpzFZswJyjq9q/mLZ48ZziMCW8cWudyxPeEH2KXbXi08X7V1wBCXB4+hh0WCcUS62H432zkHiZHVy7aIviIkpweEyf3U/27VjEfH9u/EUQZwMKORda9btyfRHcsYvUgcfj+NjaXKQaS4vJlbNlYotWYpHMIAKgoHTpVuYIVsaPKR7SaixzTx2rpBiOnRA9z1IWztk2IiT+poI79mvnSiibQV/uFv3QOsbr789BbrEElLlA1BI7+K1xU7+LqiCQsXnK3vMXEnJi3Nv18Z4M4iJUEqZzkZ5E9TBxPzzm9nyT438xCBlL3D0t8UcZQJgaooqEK45oTkS+9zW+mGVY2YGqlDCT1kiZMydPUsbvbrm453WgECHov10ANdcLhA1NsHXR52/V5GxG75rOoh/LM4sAK/HkWYpqRgzv7puVmOmRMzEbLlq5/+Ksxw/ZBXZluhRZxC42K0wfWQUAwGVUueISKQCGa5qes/VGOlbszZxRvfk+irHhxKZDotyGUlqv/1PKKFYWjhYztquK574yg7lw1QW14QkaoXKlj43qzdjeVJeB8FedteZUq4sSP1KLcG0oKVjyhbzEZSeLsLZlUgMepCvJsXFW1T+OKPcljaJMhb3DNUKW/+EecdrmtyCUDxs9AUpxdYZ1d5wpQQJKBsZOe8Bw0A4VSdilyx0aGj6Cztn+25iMsVWH+ZyjFDxL10kcfomeowYvTJ9I2LWI4X3sQ9CUzt22VnKCHKrMWy9O2KnRwIBtKitK/rxTiMdWnsbBL3DAarKO/kExXkX7kgyLBa27LCLwh2ivIhqblHvAKOeZYCZis5w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(31686004)(40460700003)(47076005)(83380400001)(186003)(336012)(16576012)(41300700001)(8936002)(53546011)(36860700001)(82960400001)(36756003)(82740400003)(956004)(2906002)(316002)(2616005)(26005)(356005)(478600001)(4326008)(40480700001)(5660300002)(966005)(110136005)(86362001)(44832011)(8676002)(31696002)(81166007)(6706004)(82310400005)(70586007)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 20:15:30.5860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7b08ca9a-92b4-47e5-1894-08daabc5586d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5442
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 20:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9731

On 11.10.22 20:51, Florian Bezdeka wrote:
> On 11.10.22 12:34, Biju Das via lists.cip-project.org wrote:
>>> Subject: Re: RE: [cip-dev] ldconfig segfault on RZ/Five was Re:
>>> Preparing isar-cip-core for RZ/Five
>>>
>>> On 09.10.22 10:42, Biju Das wrote:
>>>>> Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re:
>>> Preparing
>>>>> isar-cip-core for RZ/Five
>>>>>
>>>>> On 08.10.22 10:27, Jan Kiszka wrote:
>>>>>> On 07.10.22 12:19, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>>>>> I tried, but installation fails - illegal instruction.
>>>>>>>>>>
>>>>>>>>>> Yeah, ldconfig is needed for installation. But I get a
>>>>> segfaulting
>>>>>>>>>> gcc binary.
>>>>>>>>>
>>>>>>>>> It crashes rather soon after startup, so I was able to trace
>>>>>>>>> complete path.
>>>>>>>>>
>>>>>>>>>> But I do have slightly different results then you (I think;
>>> I'm
>>>>>>>>>> far from risc-v expert). I did a breakpoint:
>>>>>>>>>>
>>>>>>>>>> Breakpoint 1, 0x00000000000385d4 in ?? ()
>>>>>>>>>
>>>>>>>>> I believe it should not end at 0x00000000000385d4 at all. The
>>>>>>>>> 0x000000000001537e jal instruction should end up calling
>>> 0x3806a
>>>>>>>>> AFAICT, but it calls 0x385d4 instead. It happens during
>>>>>>>>> single-stepping, so it should not be anything subtle.
>>>>>>>>>
>>>>>>>>> (gdb) disassemble $pc,+0x20
>>>>>>>>> Dump of assembler code from 0x1537c to 0x1539c:
>>>>>>>>> => 0x000000000001537c:  mv      a0,a4
>>>>>>>>>    0x000000000001537e:  jal     ra,0x3806a
>>>>>>>>>    0x0000000000015382:  auipc   a5,0x8a
>>>>>>>>>    0x0000000000015386:  addi    a5,a5,1342 # 0x9f8c0
>>>>>>>>>    0x000000000001538a:  ld      a4,0(a5)
>>>>>>>>>    0x000000000001538c:  beqz    a4,0x153f0
>>>>>>>>>    0x000000000001538e:  jal     ra,0x38abe
>>>>>>>>>    0x0000000000015392:  ld      a0,0(s6)
>>>>>>>>>    0x0000000000015396:  auipc   s7,0x85
>>>>>>>>>    0x000000000001539a:  ld      s7,-406(s7) # 0x9a200
>>>>>>>>> End of assembler dump.
>>>>>>>>> (gdb)
>>>>>>>>> (gdb) stepi
>>>>>>>>> 0x000000000001537e in ?? ()
>>>>>>>>> (gdb)
>>>>>>>>>
>>>>>>>>> Program received signal SIGILL, Illegal instruction.
>>>>>>>>> 0x00000000000385d4 in ?? ()
>>>>>>>>> (gdb)
>>>>>>>>
>>>>>>>> Did you try to compare the call trace to QEMU, where we divert?
>>>>>>>
>>>>>>> Yes, that's possible way forward, but it will require some
>>>>>>> considerable setup on my side.
>>>>>>>
>>>>>>> If you have QEMU ready... objdump tells you ldconfig's
>>> entrypoint,
>>>>>>> from that point you can just stepi. In less than 200 steps, you
>>>>>>> should have sigill... and complete steps that lead to it.
>>>>>>>
>>>>>>
>>>>>> I've updated sid-ports (dropped the snapshot pinning), and now I'm
>>>>>> getting a page fault on the instruction before the one that was
>>>>>> causing SIGILL before:
> 
> In case the requested page is a page with PROT_WRITE only (no PROT_READ) 
> it might be related to
> https://lore.kernel.org/linux-riscv/20220915193702.2201018-1-abrestic@rivosinc.com/
> 
> AFAIR all stable branches have that problem currently.
> 

Nice idea. I quickly hacked that on top of the rzfive kernel, but it
didn't change the picture, unfortunately.

That said, being able to test linus/master would be very valuable here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


