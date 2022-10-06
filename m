Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3773C4332F
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 07:07:46 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.60])
 by mx.groups.io with SMTP id smtpd.web10.2921.1665040062114605782
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 00:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xPoWmpsO;
 spf=pass (domain: siemens.com, ip: 40.107.2.60,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx7AiQBvQIdoeBZMN2j6KrZwl1aAtlc5tE2FAOjIfUTdxxefQuicJka8/Euyp+sbhW6+YFyGEEMR6YSBipcjqj+kUhxcB9ZZTy84OpTXJTkT5XpmbYFnDWIV4ax2Mxxmxt0pFXSnDj3PI3pEAhqBygMNLHTJ/oHZe5q3hJtgOZ6mxL/pYskrFi8ze6YLLEHoO5VkeU+EfTqqc8zthqYJgEi2TnQMZAX5HZtSVp5mJnQ/9sbHJmY4ETMK/hjfWylg1cpGVZ3GxFGwWV3jnNlA3wILzrjfQxEQIThzyrkq4f9Ej2h6nEpwhfga+NMDE59RaZpa8ku1Gg6DFiXXwnP5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1/+zaMixsf6e6SsjCAumXq95ecP49eYKlGY3KDQfn0=;
 b=JnRTXY8vIdPpBpyMC1adWa3Rblggy7NNQSmAlSO4fLMY/vqBeDrL5Fz81A+cEC3aFhDTDT7aCucf2fZwI+wViKvHCNxA7EU4zMjslWnDLQpAAVbvReiQ1z3HFdGtWKmh9kJOZEARYQ/ggIXIjg1hV2kMEE3mxupX7b6mEg0TFbsONmlFSoPBZGL4RS2XFn64w6hX1gfHMrLAynD6pT4zlnE473iRu1lwxLE4Gh1yJz68s4clVMSAvgcwPvcYRXyw49d4prsekDlaxw3gVuemzcSKpsDDoztgMdyaT15GwtRLI4MzVxSTmwdT4dFPy3lxc8ceihDhgt1459y+jmQMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1/+zaMixsf6e6SsjCAumXq95ecP49eYKlGY3KDQfn0=;
 b=xPoWmpsONcQK1NV1DtzULnQgyoHUx8siyfgaR8QQD6gN4jD8JhN8kuvhkx46dCJxJyJgyL5WP2pjd09Q3o3l76seNY0ltWIj/njWCe9lasYSATztijDBwTqE7l+aLJDCjje2qUJqTxhd1ElKsNrptS4+19c3AYUENdePBhhWSktQZ1c6qqOateRfJu/lLSlETjqLMfxL1zoicBLK7D73YlaSNbm+IUhLEiL70If9gicHfLQ3D7qinxgNjMM/EDIZCGeQpVt+cq/QldFuAU+Z5A4Q3cctxqei7m28SsvWXMNgyIDV2XNQMHYH2TTl9a0moFhTlsJvEDhAzh/ZHn9YDQ==
Received: from GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::32) by
 DB8PR10MB3548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:142::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Thu, 6 Oct 2022 07:07:38 +0000
Received: from HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::6f) by GV3P280CA0020.outlook.office365.com
 (2603:10a6:150:b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36 via Frontend
 Transport; Thu, 6 Oct 2022 07:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT069.mail.protection.outlook.com (10.152.1.52) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 07:07:37 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 09:07:37 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 6 Oct 2022 09:07:36 +0200
Message-ID: <83385491-c786-6a8f-8a26-09b833694bec@siemens.com>
Date: Thu, 6 Oct 2022 09:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Pavel Machek <pavel@denx.de>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
In-Reply-To: <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.192400-8.000000
X-TMASE-MatchedRID: tvpRZv6Yx1Y5QaOxwNGfvo9bHfxDWoib6FoWuW7WfbyqFx2c/3V5cQ73
	P4/aDCIFSSUXkvSVAdz0dx/sdf8ZrkpFzlllNChRpjvSX6R5aD68GQW9yBIzIqchFrOB9kanAGq
	L073hbdW7cWJuGra33DlCRr8Hb3qi6vC+COmi8QTWogTgJ+knjAcO+Ovs7EaQ5Qo03mEdwAF90W
	xuEwFz7fVwK4O2mShUESnP3J1QtqehYKrIigvDWTiTClFNtmdWYVRIfIQwLJdKpXJ6KgA9xYvkw
	Jz527bYyRCAqETTbfXQMhdPcbHjBbaLZ3eKreMVTOCfjMgXeEvd7UFoG7wd3fSG/+sPtZVk0Y5w
	B8cprq4W6M2A15L1QEE96ETnbx9bqCv7lc1HWktrsa4n6jVE9KiNnhLeTqD4vHKClHGjjr07IFM
	OvFEK2FB3AZ+9IiUHfvF8AwG09ofvPrWB/m7DX4MVmko7ltH0le+q6k7Q/cwvzLls7HTfGctDHw
	9RrCNbmyiLZetSf8nJ4y0wP1A6AKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7CEVh9APZQuOGFkDQ
	vnS+FIpdMCXSEpmm9xyve7UuQso3Zn0/j8Qxrs=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.192400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E9D7230D02C2E412977A10616021FE560BCC9D25925C491685D1BB370C5D9DFD2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT069:EE_|DB8PR10MB3548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7a5737-a8b5-4bb1-254a-08daa76973aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LbstYavPG3BwwHz9na8I3Ajx87ZMx3yEV1T4YREu20XRVCHXZ6OE0lYRsihvXAIqWTzrOlmozfJNYZ8qEEXGmloh7GbH9UBoIhtNgJ9v3SQ6/e/k0ZyYx7IHMgkAlVccEgoINtZuaD70FF7aNBPrJf1YVe/8msaztRxxcAPSwo7KzuG+xKAmj5KjaPKWezkVLgv43ncM92Vbdx/EIYlbJmlE7t8MaPi2Q96UD7rnmSbdK59Rg/aDOYxKf1rMU1GrU3ozz1VTy2eDIDuei1jEaw8hbOvjLwGsJn1fxvSLHCr3faD1Ne8FF4gnVD+b4YkBacKyN8tRDF3R/H2J4bfiMAi7K/54MWYrLTMYIgGCoH5KwkZTU/BnCe4rqi3IutL0KEBXxhB8hcSWeLuVY0wmdrU2NjsDFTifFPhvk5Zm8lENmGxrkUvmYyiaReqtzT4ahEcxy4zxNgS7wJXge42KaNwJFp637BgE5mj4kOgVf13K71ZhVKqS060opVNUtfqkPy5LOnse3NxcyOvg+nKDpoYB9+2OrU16gui82aIVSXA3+SICZc6VDd98UqXQjhP7Qj0qPTPQ0ofSOXeuuVa7Ecu2J8SEKDo53vgAKznynjpD90TA96MfS8B+O3rUcCLtpe8PaGiYNnfHsR7vhI+jriCunD8IbgqGDToNXa799vbkdmxgufkBbsR30qC0EPGKjyhmkmvcDQDDcwszIjlUBICV79NT4Rx0f9t3f6cFHleOenierg68O+1uAhIbA8dgPsNopIXRa/f9QiwTI6tZI+cG4Qs82BSLbi2Fl5eaVv1IJdTDIwAoz/gVi26+qvcnxjj9OVse95HzewY14qFsAuSiHIbwXLsJpwaZAa3w6Mvri7pvUY+Tpd9A8Ja4yxaeZUs6RyCUtS4R1P6SXxJDIA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(31696002)(36756003)(31686004)(2616005)(86362001)(40480700001)(81166007)(356005)(82960400001)(82740400003)(36860700001)(26005)(82310400005)(2906002)(83380400001)(186003)(47076005)(16526019)(110136005)(5660300002)(40460700003)(956004)(966005)(53546011)(8936002)(44832011)(16576012)(6706004)(478600001)(8676002)(336012)(70586007)(70206006)(316002)(4326008)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:07:37.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8c7a5737-a8b5-4bb1-254a-08daa76973aa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3548
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 07:07:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9657

On 06.10.22 08:49, Jan Kiszka wrote:
> On 06.10.22 08:29, Jan Kiszka wrote:
>> On 05.10.22 20:21, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> But due to the weird U-Boot setup, I had to add some hacks, rather than
>>>>> a proper boot process.
>>>>
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/rzfive
>>>>
>>>> Test by flashing the image to an SD-Card switching to SD booting on the 
>>>> module.
>>>>
>>>> Maybe we can find a better solution for the boot procedure before moving 
>>>> forward with this.
>>>>
>>>> Anyway, now we have a real distribution on this board. Pavel, can you 
>>>> re-check what you observed, if those issues persist with Debian?
>>>
>>> I believe I was running Debian; two versions and Ubuntu, IIRC :-).
>>>
>>> Can you check if ldconfig and gcc work for you? That were the
>>> roadblocks I was hitting. If they do, I'll be interested in details of
>>> your setup.
>>>
>>
>> Hmm, seems the issue persists:
>>
>> root@demo:~# ldconfig                                                                                                                                                                                                                        
>> Illegal instruction
>>
>> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x00000000000380c8 in ldconfig[10000+83000]
>> [  297.146768] CPU: 0 PID: 497 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1
>> [  297.146775] epc: 00000000000380c8 ra : 0000000000015382 sp : 0000003fffe01c10
>> [  297.146782]  gp : 0000000000099da8 tp : 0000003fda772800 t0 : 0000003fda7787c0
>> [  297.146788]  t1 : 0000003fda8065a8 t2 : 0000002acbbda7a0 s0 : 0000002afa2ec890
>> [  297.146794]  s1 : 0000000000000001 a0 : 0000003fffe01d18 a1 : 0000000000000001
>> [  297.146800]  a2 : 0000003fffe01c88 a3 : 0000000000000000 a4 : 0000003fffe01d18
>> [  297.146806]  a5 : 000000000009736e a6 : 0000003fffe01c80 a7 : 00000000000000dd
>> [  297.146812]  s2 : 0000003fffe01c88 s3 : 0000000000000000 s4 : 0000000000000000
>> [  297.146819]  s5 : 00000000000105a4 s6 : 000000000009e670 s7 : 0000002afa2ec850
>> [  297.146824]  s8 : 0000002afa2ec710 s9 : 0000000000000000 s10: 0000002acbbe39c8
>> [  297.146830]  s11: 0000002acbbe3938 t3 : 0000002acbaf2610 t4 : 00000000000925a8
>> [  297.146835]  t5 : 0000000000000004 t6 : 0000000000000000
>> [  297.146842] status: 0000000200004020 badaddr: 00000000a01253cf cause: 0000000000000002
>>
>> (gdb) disassemble $pc,+0x10
>> Dump of assembler code from 0x380c8 to 0x380d8:
>> => 0x00000000000380c8:  auipc   a2,0x66
>>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>>    0x00000000000380d0:  sd      a0,0(a2)
>>    0x00000000000380d2:  mv      a5,sp
>>    0x00000000000380d4:  addi    a4,sp,416
>>    0x00000000000380d6:  sd      zero,0(a5)
>> End of assembler dump.
>>
>> Do we have any instruction set restrictions that prevents the usage of 
>> distros on this CPU? Under QEMU, we come along here as well and execute 
>> this without problems. Some infamous Intel CPU comes to my mind at this 
>> point - hope, history does not repeat here....
>>
> 
> auipc was introduced with ISA 2.0, around 2019 - please don't tell me we
> are on 1.0 here.
> 

Nope, it must be some other condition: I've found those instructions in
working binaries as well, and I was even able to modify one on-the-fly
to run the very same op-code there, without any trap.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


