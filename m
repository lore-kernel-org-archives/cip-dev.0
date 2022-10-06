Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F6C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 11:51:48 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web12.4848.1665057099753569348
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 04:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e5QtQzWn;
 spf=pass (domain: siemens.com, ip: 40.107.104.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePjqjtmJBvOZKEb83TzPeR8jvty1OGOciZgOCXU8hevBy92JMi7WsRsQwB6NKGYVmGYT9ohmiZrFoE4v+5qvHleSj+jJqUilYM1UQMvmIz5iEziUioxaMbjdsQ9PIMrFSC+qmj1waHrOGq247cvk9LPwwnKs2jBMSFwguNu6jyM5GOn75RbwVZTVztOqRjqOoLFr91Sdc6aj8uwoI3c4ps5C3Pg4bIIqTW4vIMb+E7chpL7tZuJ4gkXqbxGz2LFwGhV1DCRSw2kvoB3A6A+QR2AZasrpZiIwFZ5FtqbgzR4zDqnDbSNgh3Q6NflgZ348c3FBwTh+t2W2uCm8o4EAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x26o9HxOMFCXRV3vLjp8FE7d/a/ypuw8xy0kxNPLNuI=;
 b=UzK5Ky67AzqgWmzn0AbcvYKZRJLS7Bk14OYhDET1hX3exPnM5UNdN3ukraboJcr8AeNeG69Y9rPbZw44EyPiL21ziRFLyPYeuVZC0KoWlUNUmKoz+JEjz5Ej0wXWMzz1FA75ioCkEGbHCOtw24JLXRPo+qwr4wfmy8bH3pcpOwnB8TPFJUtU3ADDAzvoF1W7hMUT8sQhxem80pKYldrn0+GP5K6xXb91PxBAqD1fZOHhXPmnBZxcAzvbw7x6pj+NqEWLxs30TLkQEQprAfuk+iZverlpXf3cey0vsv1xmryC9xQa2FIENHpVgPoVuVPBX1+Hlvef+ble6Y1OxrJe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x26o9HxOMFCXRV3vLjp8FE7d/a/ypuw8xy0kxNPLNuI=;
 b=e5QtQzWnpXUsZ8zbaS6zzvtj3mHp6izi9MW7rOXuZ3z6JNrRh0V8gr12UoZFReFfskQBh3tEdZu3FJb6aAhTbf3nBdUTaf33RtXKVQxV1Kp0iDhvmDWyC5ZWgNTsMtA4ixTCL0DxUFtMTub7BFvJjw50ePUt3xZAfxsD1fQDFLWs9x7tm1kTb4L7c7x49R03dSHs5vbkKGHUzkzyUCQOpKjOqqZd35CMwNEYOUY4wc58cE/uvIfZGF+wPfr5QrcZEe6kAHcb3HNclW/aL8cGs+QQ3haTuwmEZrVWgXFne/De7lnKSqKaddO2zHbHVLJnw3bFT9x8D7UC57aokhVhKQ==
Received: from GV3P280CA0062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::18) by
 AS8PR10MB6923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 11:51:36 +0000
Received: from HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a::4) by GV3P280CA0062.outlook.office365.com
 (2603:10a6:150:a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36 via Frontend
 Transport; Thu, 6 Oct 2022 11:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT093.mail.protection.outlook.com (10.152.0.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 11:51:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 13:51:35 +0200
Received: from [139.23.75.87] (139.23.75.87) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Thu, 6 Oct
 2022 13:51:35 +0200
Message-ID: <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
Date: Thu, 6 Oct 2022 13:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>, cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221006114326.GA21855@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.75.87]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.181600-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKA5QaOxwNGfvo9bHfxDWoibpljg/F9ExYT+xRIVoKNMvAGo
	1vhC/pWj1R/ptYWR8C6ffYZLd4eHV0QD9vOU9UhOq3USk769Wfv9WTVChOPp5v86OKweA/McNmV
	jpriVEtnAlr9zf1x/lgu8AoAyfG3Rtsxh/o0Z5xa761Rb2kt6b8obPoJ0HIwCYKm742WlIN7J5S
	XtoJPLyEbtou1PeiP7Qo9AVz98w394ML3dRSv3JzLnedZgy93Rpm5FPBlNpd21PiMh4ZF39e/kl
	6iUzyK7rFjA6CZN1k1gbfZku6SlU3qKlbNWS67wM3frSRH3MdRccQ8eam5EfTl/1fD/GopdnCGS
	1WQEGtCO8R6rqACRhqu6xVHLhqfxIAcCikR3vq+Z1YUK7b+J899wTRwOI7bp+9rQmh+idA9aXJT
	/pOxbivW26lTuPvwC
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.181600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 938A3DE3945A25E49C87F4EA66576B9D980BE9284B0C79B0573C48DA8C75C6642000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT093:EE_|AS8PR10MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6752d987-85ef-476f-54a5-08daa7911f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HTh01p3l0+OTKCS6ruXZ4t3bnlZAk1jKMjtybmrIguxYSQ7n6N353Bidw6+jNqEFToql94PzoP/cqpFdEmBA8+6KeaF6c3Q2VMnACTWMEuy1jOgTvZBwPBPVu3gpJ/wutbaBNMfgfJI2UoR1vg7q5NNBF5a24DBrxv0cpHlxhSrwty9U0tGvw0VjkYwl1gyA1PFlIOtfyjmo/4W9CX6ZrE9qPIocfDDpCtt5PWyyTYQLTkP+XbMOVaOylblzzuR/rMebVg70szN610DLt8w8mefctMtzmPbkIOZKQd5bdw1rrEWoNwh5oHM+qisztjimz4XmykzDmiF8W9k3NDx3S6D32FM6plBu1P9EuIIZRbhLIkM0IGiwmRF5IONHan//WHCdtFnGfWUNEQe0LtEAdYtvaUS8rE0SewfhafMR4CnhWQkbjXee2BD0T0xI+mNsys/4v71g0PMnCYkl/5Nxn2CgSi3/poZQVB5IuuAmpp7oPADW3NrX8W2DkEarvciYOt6ec3T6eMlucLreiGcqFP4UM57eKXiQBqsfS9GrvZBpTl43A8fQLhTaxWXNwckGcDt78B7Vhv8O6D7hfiZW+sdZ6R5DfBvUYN2+zrBkknToPduNnO2egJBPag1IMPd1AJI7A0aW6zPtHy/X9QuWyIfRc1zMzmWjAUzVsrQIAJyYLLmDKhrwPlFTqW1s3C/vBv5q9epHKEwiJ4KEArBBJQIkoAnigB+eHe47lT2wdLVCPm0p+qpwDCZt7DQmKX73BO2uLUwk1MzlIBkYwtimdLmqDTI503GKNWQy1y81aHkfQrX26nR4gnprILMH+J9o3yiJ3zvc+tReoQJ3/rjxkOLr9jiLXIy/QepCHWpHui8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(70586007)(36860700001)(8676002)(16526019)(186003)(4326008)(2616005)(956004)(40460700003)(2906002)(53546011)(26005)(8936002)(31696002)(31686004)(86362001)(83380400001)(40480700001)(41300700001)(47076005)(966005)(54906003)(36756003)(70206006)(5660300002)(6706004)(478600001)(6916009)(7636003)(7596003)(356005)(44832011)(336012)(16576012)(82960400001)(82740400003)(316002)(82310400005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:51:36.1356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6752d987-85ef-476f-54a5-08daa7911f39
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 11:51:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9663

On 06.10.22 13:43, Pavel Machek wrote:
> Hi!
> 
>>> Can you check if ldconfig and gcc work for you? That were the
>>> roadblocks I was hitting. If they do, I'll be interested in details of
>>> your setup.
>>
>> Hmm, seems the issue persists:
> 
> :-(. Do you get gcc faulting, too?

I tried, but installation fails - illegal instruction.

> 
>> root@demo:~# ldconfig                                                                                                                                                                                                                        
>> Illegal instruction
>>
>> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x00000000000380c8 in ldconfig[10000+83000]
> ...
>> (gdb) disassemble $pc,+0x10
>> Dump of assembler code from 0x380c8 to 0x380d8:
>> => 0x00000000000380c8:  auipc   a2,0x66
>>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>>    0x00000000000380d0:  sd      a0,0(a2)
> 
> auipc is something rather simple. a2 = pc + 0x66 << something. Not
> sure how it could fault. Plus we get "illegal instruction", suggesting
> it is not some other fault.
> 
> Could some kind of self-modifying code be involved? I guess some kind
> of debugging/watchpoint is not probable.

No idea - but why should ldconfig be self-modifying?

> 
>> Do we have any instruction set restrictions that prevents the usage of 
>> distros on this CPU? Under QEMU, we come along here as well and execute 
>> this without problems. Some infamous Intel CPU comes to my mind at this 
>> point - hope, history does not repeat here....
> 
> Which Intel CPU comes to mind? Pentium with its fdiv bug? I'd say
> recent ones outdid it :-).

Quark :D
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=738575%22

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


