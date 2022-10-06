Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B96C4332F
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 06:50:06 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.70])
 by mx.groups.io with SMTP id smtpd.web10.2819.1665039005326008703
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 23:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YtYZI0Gd;
 spf=pass (domain: siemens.com, ip: 40.107.7.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqRJNA6MXfwUYCUOaGrPg2ZxT/xBbhbv5dGYY2alE7Q9+NGapPcWbh/tfBbLzAK9vRMjU71Bz8BnF1v4B5gPYryo8O+PfKGE4ENKylFNb1aDBGcJvZFTHLGw+DPU0hpkcN+MGwNhE4HU/RFv7xnaG89hdulM/gI+YoczCnEIuXEhpeHTRrh8TbmE0GcUMrF3Q5kieZQJ2cenCQ4ao5bbOIpyNFM8OinGdBxCisbzYaAl7DOSarHM8nAk0RVzIKGxQEiRmxxGhCgb3mQpzzgcNdtrv5x5cLMJKKwi+Haxa7L3lLs7KT18Pq3FRrzxh0xoqgh+QFFwzNky552njp4wwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvopbtoZP/X17xsqp0hpSzv7MYIbjpQyXZf8Y7MXqSw=;
 b=LKvMhMYfd68SHNrz5lnJSMNGmwJOVmHv0+ERBOxXIocXyqXocuzQXkuAJA3y85QluGQfLEE1DpxQiySleN1jidJUQtKM9M7QpKzzrdnS1fJw4oNAj5NI4KfQgjp4MmIUxvmHTsFv8c7qcG0JpMg8iMr6gHG8YvELRU8rckwFCTY9Y8/5G6B7yufDNKUoEhiXe4JAxHj+SULVl4ZukJM1c/JeV1pGkoy6P31wbDJibEE7soIgczm0i2uag2Sdpn941JpJzlhkbBLuOL2w4zVPvGzLUEIxUUuSUT2lQOyiyy0jnC0g3o+gfRYjYYKJxwu7mV6fu1WfdvczTxIdVC6prA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvopbtoZP/X17xsqp0hpSzv7MYIbjpQyXZf8Y7MXqSw=;
 b=YtYZI0Gd71PzBE6Wpqawc391g2eKKQlgXfs9q/nrNsV9QKSHnmUysmtncxWSKhvGZYy7S1nC/sUX4m5CWsLngh+RATd+9dldRewzMWWYOwdWUowAdRywLtMfp1DFpCr6BD/LQGcmFYIpSwLomas5xZLuQtutrPJYAaZ3XH4g354DAeQ5+C3fR47NNh2OuPQuf68EDdA76lbuRLudk8HN2322z5Ud4uUjsMuKgNGGa51xzsojSGh2yH/VoTQmzTgdsqXqV7z5TI2xsrptgSHJuDOZYOdx5JytKKWkB2x1xFzlUMR4wHCtdl1FU5s5ZWeH9vIN0rqm2WWifyt6BuaECg==
Received: from DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) by DB9PR10MB6355.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 06:50:01 +0000
Received: from DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46a:cafe::7c) by DUZPR01CA0089.outlook.office365.com
 (2603:10a6:10:46a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 6 Oct 2022 06:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT101.mail.protection.outlook.com (10.152.5.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 06:50:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 08:50:00 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 6 Oct 2022 08:50:00 +0200
Message-ID: <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
Date: Thu, 6 Oct 2022 08:49:56 +0200
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
In-Reply-To: <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.967000-8.000000
X-TMASE-MatchedRID: 5kZRuoL5N6g5QaOxwNGfvo9bHfxDWoib6FoWuW7WfbyqFx2c/3V5cQ73
	P4/aDCIFSSUXkvSVAdz0dx/sdf8ZrkpFzlllNChRpjvSX6R5aD68GQW9yBIzIqchFrOB9kanAGq
	L073hbdW7cWJuGra33DlCRr8Hb3qi6vC+COmi8QTWogTgJ+knjAcO+Ovs7EaQ5Qo03mEdwAF90W
	xuEwFz7fVwK4O2mShUESnP3J1QtqehYKrIigvDWTiTClFNtmdWYVRIfIQwLJdKpXJ6KgA9xYvkw
	Jz527bYyRCAqETTbfXQMhdPcbHjBbaLZ3eKreMVTOCfjMgXeEvd7UFoG7wd3fSG/+sPtZVk0Y5w
	B8cprq4W6M2A15L1QEE96ETnbx9bqCv7lc1HWktrsa4n6jVE9KiNnhLeTqD4vHKClHGjjr0ujMj
	6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfpGTpe1iiCJq71zr0FZRMbBWdFebWIc3VsRB0b
	sfrpPIfiAqrjYtFiRLsIevKYvr7NHBEKs//Z/+kzpl7MQf9WEhpmJa0N7IRX7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.967000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 058FE964607D3946A02E6D5B7A1D18350428ECA83B151539C70BEB0B15A5D4A92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT101:EE_|DB9PR10MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ecd0c5-0cbb-4ada-bf9c-08daa766fdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ge3jMl+0B70yhrGrk5AXMeV4wuWwfRfPD+K0GaUe4oHkjN+zOPjjs7JuvzJVMTdf7dB84O3PsV419PI6UgJL2pZ3BnHzNyyj9y9fAEhAh3Al8eGezzSPRwC3OydZ1wu+vdn2FjGmk41+F63dfG18JUMMkvYOjefU069IMCwgyUECykfHgv5gIeDJD0Az1laOYw5hM8z96bNBQzEsotl8HPv0rcRp40+FiROuArXi3TBGXAfYD3f1mCc7w1xfYj/9gCYaNdsWtTvsc0kXEeF/nvn0PDX7DM80h/3dwN3kXm5J2ln6xyXhlalPNxnQvNza28IB6eyISXevkrkwJIQ9Amc2C5MrgmMOawwrMC+TD27/HSvviN292S3GFJ7LqL/W3owN9ND1T/i5TVQELvEuQOC4wMAn6rI8RM2BdGkDrUZHOnmvXgkS7rif33CfPagiHdWfESYsIkkyYc+jHWV3bRFTTtg+AAH7hG7dCNvbxD+ilFXmFhqMdiP2ubYKlcu1MpRu9O2vNaZ29NOi+zlLh2wbtIa+oGG5e8ISC4uHcYysWHS0ZX4VZ7O6XyvjXlqJ0SfkD8wOzmIXHgBEfvnJUb13ewIPMzWuKDvgWuS+AkfygNNuWh6/vjFv6lPSk1o9/KOY2nrzv49VDnFA9Am+7iYWP1UoUKAt9aXmMfQsdjmRoovUcG0ZDrmYHe6zArhmSPLGjPc/DpFrmZcLkT4efaT3YZ6cbLTon7MC5e8sdQ+AAxZvBpXpzOVPGnnc90wO3gA7P06AYSOq6Nzxi+T/ivRn+ajrfIQuCG3+Q95kRuL7UbWuRlJfmYv2Yq7iJqCJbmgr33rKHl0x2y2uT636s6FWdAKgd0ExstEltt15838=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(336012)(8676002)(82740400003)(7596003)(26005)(86362001)(7636003)(36756003)(44832011)(356005)(40460700003)(70586007)(16526019)(5660300002)(316002)(53546011)(70206006)(6706004)(186003)(16576012)(2906002)(956004)(36860700001)(966005)(31696002)(478600001)(110136005)(8936002)(47076005)(6666004)(2616005)(40480700001)(82310400005)(41300700001)(83380400001)(31686004)(4326008)(82960400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 06:50:01.0960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e2ecd0c5-0cbb-4ada-bf9c-08daa766fdba
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6355
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 06:50:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9656

On 06.10.22 08:29, Jan Kiszka wrote:
> On 05.10.22 20:21, Pavel Machek wrote:
>> Hi!
>>
>>>> But due to the weird U-Boot setup, I had to add some hacks, rather than
>>>> a proper boot process.
>>>
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/rzfive
>>>
>>> Test by flashing the image to an SD-Card switching to SD booting on the 
>>> module.
>>>
>>> Maybe we can find a better solution for the boot procedure before moving 
>>> forward with this.
>>>
>>> Anyway, now we have a real distribution on this board. Pavel, can you 
>>> re-check what you observed, if those issues persist with Debian?
>>
>> I believe I was running Debian; two versions and Ubuntu, IIRC :-).
>>
>> Can you check if ldconfig and gcc work for you? That were the
>> roadblocks I was hitting. If they do, I'll be interested in details of
>> your setup.
>>
> 
> Hmm, seems the issue persists:
> 
> root@demo:~# ldconfig                                                                                                                                                                                                                        
> Illegal instruction
> 
> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x00000000000380c8 in ldconfig[10000+83000]
> [  297.146768] CPU: 0 PID: 497 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1
> [  297.146775] epc: 00000000000380c8 ra : 0000000000015382 sp : 0000003fffe01c10
> [  297.146782]  gp : 0000000000099da8 tp : 0000003fda772800 t0 : 0000003fda7787c0
> [  297.146788]  t1 : 0000003fda8065a8 t2 : 0000002acbbda7a0 s0 : 0000002afa2ec890
> [  297.146794]  s1 : 0000000000000001 a0 : 0000003fffe01d18 a1 : 0000000000000001
> [  297.146800]  a2 : 0000003fffe01c88 a3 : 0000000000000000 a4 : 0000003fffe01d18
> [  297.146806]  a5 : 000000000009736e a6 : 0000003fffe01c80 a7 : 00000000000000dd
> [  297.146812]  s2 : 0000003fffe01c88 s3 : 0000000000000000 s4 : 0000000000000000
> [  297.146819]  s5 : 00000000000105a4 s6 : 000000000009e670 s7 : 0000002afa2ec850
> [  297.146824]  s8 : 0000002afa2ec710 s9 : 0000000000000000 s10: 0000002acbbe39c8
> [  297.146830]  s11: 0000002acbbe3938 t3 : 0000002acbaf2610 t4 : 00000000000925a8
> [  297.146835]  t5 : 0000000000000004 t6 : 0000000000000000
> [  297.146842] status: 0000000200004020 badaddr: 00000000a01253cf cause: 0000000000000002
> 
> (gdb) disassemble $pc,+0x10
> Dump of assembler code from 0x380c8 to 0x380d8:
> => 0x00000000000380c8:  auipc   a2,0x66
>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>    0x00000000000380d0:  sd      a0,0(a2)
>    0x00000000000380d2:  mv      a5,sp
>    0x00000000000380d4:  addi    a4,sp,416
>    0x00000000000380d6:  sd      zero,0(a5)
> End of assembler dump.
> 
> Do we have any instruction set restrictions that prevents the usage of 
> distros on this CPU? Under QEMU, we come along here as well and execute 
> this without problems. Some infamous Intel CPU comes to my mind at this 
> point - hope, history does not repeat here....
> 

auipc was introduced with ISA 2.0, around 2019 - please don't tell me we
are on 1.0 here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


