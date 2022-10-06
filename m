Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EC9C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 06:29:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web09.2772.1665037782882909638
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 23:29:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F1NJZCu3;
 spf=pass (domain: siemens.com, ip: 40.107.22.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgeOHqWzR0TjB+23EhdppG9yixfllp8eU8L+OgWNWln2dq1L0S4ovgDOuictVojg6ppVdbDhaoSg981n1GXpEEDpoFy+1rs9IGo6uECy3AUy7QRdzMBTAU9QlI+ZHQFcwTVCBKxXm9tzIANJ7yAMMyeqIaCiTuzY5X8juYYZDnndgH3Peko6TMnWbrUOwrvPJ4/3Z2znb/zLrIi3Ro3FL66X6yXNnmLeXas1ahGTWs6j0bwc6yEO373H45hOyb6Wm1wulQtur4qz326cit6sypL1RmQnY+5b2dcrMWmGa6yDiIaGf95XbCNSiNzkF3Ntst2yuWpvQMwyrsFIbuieHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNRZE+MANxbALbqUqrfTQFXPUpqdSgZ68kV3GOZfwwE=;
 b=k1qNlTpbY5JsIqY7tBL8IvZa5NYetNCobtrReOsE6X+IQYuSdOHuhESbmnsFO+sk4BjLrNHUbYuxa/8Zevxl/i7UFI1HPLUsstxEMtw74EbPtxkf6+/wQ6s3qfGOzX4ZxSWvaVEvfLveruoNO1u1pL1oqK5IgWOwcAyusnmcSO1JM++N8Sa+/6ovvIrWCE2twZh/1mG4piGU8+zenP8rqGoPo9A2qhv9tOBlunby9ugeAsvKHvNDk74LeKutJv6wzsoX9XVQxb4QUErnXn6uUdWAQ2vXXiSoYOBuF/3JXllWJLAfOPG2IUZhSilSHXx2faTnFdUv8XtFp/MNoAaskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNRZE+MANxbALbqUqrfTQFXPUpqdSgZ68kV3GOZfwwE=;
 b=F1NJZCu31KFNYqwxYzTG1ffgxd46+eWV792JJe3ps40dPF9DWvqzWoqc8OHwckVB+WTjHLoKhyVoFKOjlTllbo9tqYKt1KIR1oO1Gnzxcnrntv7YHbPS6Mm2EjebaRwbZD9DU3/W1FZ/l6++hO/5l1tm0Ohaqns2TAL2gFIjKYPy1rBenSJMpyu9SsLj365YvlrfnGoCP9MWYgXuN7mK2oXyRRlxkrGGtNoCmrugg0cCEvNNdSLGJsCiRNbVeIHC1RKyC6K0DLOelxgs7CIQLfAIUYd3THws5XgLjNIdl+egiX3Hn76FwriVSEiO3sHu42KkvplUo3vnKyU3cY3fXw==
Received: from DB6PR1001CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::34)
 by DB4PR10MB6310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 06:29:39 +0000
Received: from DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::6c) by DB6PR1001CA0024.outlook.office365.com
 (2603:10a6:4:b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 6 Oct 2022 06:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT062.mail.protection.outlook.com (10.152.5.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 06:29:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 08:29:39 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 6 Oct 2022 08:29:38 +0200
Message-ID: <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
Date: Thu, 6 Oct 2022 08:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221005182151.GA16437@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.625900-8.000000
X-TMASE-MatchedRID: qeBAs1OleyY5QaOxwNGfvo9bHfxDWoib6FoWuW7WfbyqFx2c/3V5cQ73
	P4/aDCIFSSUXkvSVAdz0dx/sdf8ZrkpFzlllNChRpjvSX6R5aD68GQW9yBIzIqchFrOB9kanAGq
	L073hbdW7cWJuGra33DlCRr8Hb3qi6vC+COmi8QTWogTgJ+knjAcO+Ovs7EaQ5Qo03mEdwAF90W
	xuEwFz7fVwK4O2mShUESnP3J1QtqehYKrIigvDWTiTClFNtmdWYVRIfIQwLJdKpXJ6KgA9xYvkw
	Jz527bYyRCAqETTbfXQMhdPcbHjBbaLZ3eKreMVTOCfjMgXeEvd7UFoG7wd3fSG/+sPtZVk0Y5w
	B8cprq4W6M2A15L1QEE96ETnbx9bqCv7lc1HWktrsa4n6jVE9FP4madnCuPcXmFVlObh0PxBfkJ
	WKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCAGLeSok4rrZC24oEZ6SpSkj80Za3RRg8PYXYN
	QBqZvEv+Ol4Ohv9SxJLNjBbXxTgQyV2rtf1m/7wr1QlhZA6gI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.625900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 FFFDFFD26AEB9C6774D7941F668244BCFFE001F123CA80EB46205D4B2FC4B1A42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT062:EE_|DB4PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 868b8274-241c-4690-a08e-08daa7642598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C9YyDgbKWrnaf4fK2cehYDGqypxkX0ktBomXgs+zmtf4zILrrdTwIKNg5dvB+b8t8zhEMfbw9eMQT+omp8edl7C6yTq3AA1sAAOUBb/IyTJWcUJoBowyhJUxLO5tlaQAzfNIej3dttvI4JA54pOOs0L3uPkKnTKWHZb6ipiE55jpwPCsQSpYJObX243JvCJlT7n3xImqrJzoOmIvPvRmAzU93uhxe+K0vSomcAJ4AY7Oepf3UN2PqkUU/3UocEYAE2nd+XNcpxq7XfsezTgmu2lTzRpxu2E/z9+UE2GvwGhuzuFjThUWI87Wlewrx2ZJkqdJMF4U/ztzpJ30E59tWaRx78fvCTV67wMjZMbU660d0sEn3GEgFVrkKzKDg3JpisIztvt2snajMsYXEu0E/gmdncSVn9FkfM7rQ6qX1eE85CJWUJ8TRmMDSaiXcf4Xs0dwWGj/79PDUwGKWVQTc7auQ195QPY9rVPItEZ9vw/DXO7VQwPfSkY6GzIks2B488ojLIPyGWI5owjqlQb5BuIXuouQS+miknigHtMQIuBMHbjDwTfXXv41fiHF2QDJnjHHbVYip1shSaQ7IMRiu6jSO456eqpDkTWt+QR4JBIFvzHBc23a4Ca1Vvn2AaUgXYXB53UJjsLxpOxTd+YNqySa9q1DgpEWup/npcoJQ6WgTzXLiDGDE39bqEXBGQrREkC0DvO4LRC6H3MGua34nSo5sfN1Mf9c7zEFyePmhssfQELgZWb8WxFIuRjF1FxRSdPXGiRgl0MLiZ0vApe06Z1+jUZbZMdzRMIn+aucD54sXFSn8C8qGVK/VhXXrJAnYvKuh8jMLeA6L0TgmXG8mmyTV12aPXXg1fB0AtLR45Wy5yJbFyNy0y9gG7CvaeKeHohj7GHrJXda1lFopP0fMQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(31686004)(36756003)(36860700001)(82960400001)(82740400003)(86362001)(31696002)(356005)(40460700003)(186003)(40480700001)(47076005)(2616005)(53546011)(44832011)(5660300002)(83380400001)(16526019)(2906002)(956004)(26005)(110136005)(70206006)(70586007)(8676002)(4326008)(8936002)(16576012)(41300700001)(336012)(82310400005)(316002)(478600001)(6706004)(966005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 06:29:39.4940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 868b8274-241c-4690-a08e-08daa7642598
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 06:29:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9655

On 05.10.22 20:21, Pavel Machek wrote:
> Hi!
> 
>>> But due to the weird U-Boot setup, I had to add some hacks, rather than
>>> a proper boot process.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/rzfive
>>
>> Test by flashing the image to an SD-Card switching to SD booting on the 
>> module.
>>
>> Maybe we can find a better solution for the boot procedure before moving 
>> forward with this.
>>
>> Anyway, now we have a real distribution on this board. Pavel, can you 
>> re-check what you observed, if those issues persist with Debian?
> 
> I believe I was running Debian; two versions and Ubuntu, IIRC :-).
> 
> Can you check if ldconfig and gcc work for you? That were the
> roadblocks I was hitting. If they do, I'll be interested in details of
> your setup.
> 

Hmm, seems the issue persists:

root@demo:~# ldconfig                                                                                                                                                                                                                        
Illegal instruction

[  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at 0x00000000000380c8 in ldconfig[10000+83000]
[  297.146768] CPU: 0 PID: 497 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1
[  297.146775] epc: 00000000000380c8 ra : 0000000000015382 sp : 0000003fffe01c10
[  297.146782]  gp : 0000000000099da8 tp : 0000003fda772800 t0 : 0000003fda7787c0
[  297.146788]  t1 : 0000003fda8065a8 t2 : 0000002acbbda7a0 s0 : 0000002afa2ec890
[  297.146794]  s1 : 0000000000000001 a0 : 0000003fffe01d18 a1 : 0000000000000001
[  297.146800]  a2 : 0000003fffe01c88 a3 : 0000000000000000 a4 : 0000003fffe01d18
[  297.146806]  a5 : 000000000009736e a6 : 0000003fffe01c80 a7 : 00000000000000dd
[  297.146812]  s2 : 0000003fffe01c88 s3 : 0000000000000000 s4 : 0000000000000000
[  297.146819]  s5 : 00000000000105a4 s6 : 000000000009e670 s7 : 0000002afa2ec850
[  297.146824]  s8 : 0000002afa2ec710 s9 : 0000000000000000 s10: 0000002acbbe39c8
[  297.146830]  s11: 0000002acbbe3938 t3 : 0000002acbaf2610 t4 : 00000000000925a8
[  297.146835]  t5 : 0000000000000004 t6 : 0000000000000000
[  297.146842] status: 0000000200004020 badaddr: 00000000a01253cf cause: 0000000000000002

(gdb) disassemble $pc,+0x10
Dump of assembler code from 0x380c8 to 0x380d8:
=> 0x00000000000380c8:  auipc   a2,0x66
   0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
   0x00000000000380d0:  sd      a0,0(a2)
   0x00000000000380d2:  mv      a5,sp
   0x00000000000380d4:  addi    a4,sp,416
   0x00000000000380d6:  sd      zero,0(a5)
End of assembler dump.

Do we have any instruction set restrictions that prevents the usage of 
distros on this CPU? Under QEMU, we come along here as well and execute 
this without problems. Some infamous Intel CPU comes to my mind at this 
point - hope, history does not repeat here....

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


