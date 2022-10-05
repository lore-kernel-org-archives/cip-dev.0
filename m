Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D316C433FE
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 05:46:03 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web11.20426.1664948758451586831
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 22:45:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kx6wkQle;
 spf=pass (domain: siemens.com, ip: 40.107.8.43,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzxiJfyGlhSVgG1mFldQi/Zzy8nLRzqNPV/aM7FDzynrAF0QcgfkLNYGLozhU8HGTtBnehcwrRAVAaQVtZcG70r3VyFU/xoBuJZ15difu5/NHV97nDOnWR+vXmqOO2/X+dwBP3YxGzh+OqLzJBrX6EeD1w872hUr1o2RVgue7HeSP8ZcJLt4ACH9kfDzrRvWIarxXQPGcEb9kqXYUtHm2NnWBFBTOwRJdRrYw4jHz6VPUjI01CL23B6yOs81alc6wMrmpdIj2NG5Z9m/bZe9bQm0H6v3Vy14/TkcBL+sMqLfxl9+WvJv08W3Lek5GpIQMRFaWPckae9Xn62Qa8jOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWq8yawTcghp8wvz8cO7eA8uKutc8ZtzGfW5IqfsjVk=;
 b=Fp0i/FlYomngHgulQGv6C/LDt9dHpsLUPaaeH/HdjyAoDDTnli64X372PsFTAzI2wEuHOw/dXukaM+AC3k7EYNs19XBSPVA7vBDVJtTSc4Fnc6sRDINjs6V+4x80t+qvgphmWZQVU6ZleFxxnAJUPWW1Wr2W/FlFqaScyjQ8/EwuOykwxvhpj5AFgSxP5vlKyeaDYKAS15XE7uQvIg3mAvGoDz6dqHsgy5VZteAMxY6VjV37fJ1FRVGlv6dkoRJ3/HzzTEpPhdf/JEBgzydNJ5g1ZE13/LXvis3w+/Ox4y7+3E1q/yAnbjuiryqhPsh7xEG7jGIPvlWcBRxqOkX0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWq8yawTcghp8wvz8cO7eA8uKutc8ZtzGfW5IqfsjVk=;
 b=kx6wkQleCOQKdbZvTKIcFoKDkCv9j0qkiTKVOpOybK8f8GW1ON6KpDEsFWoOHw0ZL6SN7LBCahUO43hcdkleq1se9EhJQgfMBlUgkH2QNPXGdEIa4pdkZPUZ3yz5jO85DkzU7nklPMzXF7gk+GlxMxXO3UCrtnwTUP8TqXs3gdDfiYPUSulRw61PwH/x/IUuSl+5e5Jmg3nv6PElWg9dG+M3G9M2XP3X6ZtKW8qRomHcfQjJJQILlQ7/q/QbN+kglIaRON6xaEoAa8srh4hq4n3r7yUoez5XVC+WMXTI4wzpVeGMtxSJZ6k47JD77NC0RDsStosPm63Cp92h5i1Uyg==
Received: from AM6P194CA0083.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::24)
 by GV2PR10MB6550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 5 Oct
 2022 05:45:55 +0000
Received: from VE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::f7) by AM6P194CA0083.outlook.office365.com
 (2603:10a6:209:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Wed, 5 Oct 2022 05:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT086.mail.protection.outlook.com (10.152.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:45:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 5 Oct 2022 07:45:54 +0200
Received: from [139.21.17.164] (139.21.17.164) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 5 Oct 2022 07:45:53 +0200
Message-ID: <f266c9b2-3e44-5b22-d2e9-5728b9eadb73@siemens.com>
Date: Wed, 5 Oct 2022 07:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "Chris
 Paterson" <Chris.Paterson2@renesas.com>, Hung Tran <hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019EC85B41F057AEB79E630AA5A9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB7019EC85B41F057AEB79E630AA5A9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.164]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.070400-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe45QaOxwNGfvo9bHfxDWoib1xQ2OgXti5UT0vQc28rNUf6u
	GOfv9tMUdcfU63y8xPCtqpWWtMaf8L4vrFmOaS1ERgrhz8k0sVeZlYl0tsn/4yqwx8x+s5lF4oS
	d18bdmwJ1+BANR76ZZ+majo/5OlNgzY3Y/giFSEgiH7ygf4M2w2efQAfaVEc5fTWvG3pXL4RZoq
	85oEW2FHc925yOJXmFiUAxXFIExAFKkAU17gNQnu+lWejEHPhXE7UB2zKfFgAdixvFJ6E5yC6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsHAruZnjhopu+gD2
	vYtOFhgqtq5d3cxkNRvNkDaN+tImtxpFoMA/yRNmehfoLwUSx+tZFPs3zYdmuWVT0Lgsedw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.070400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D470FE4729C3A17BB61627C96F60F00A4D8B4EA5C5036EFB133F8EB05E5654302000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT086:EE_|GV2PR10MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 2090ff6a-c75b-462e-e1b4-08daa694de80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kUsX1qtggBDcG8V+r/diP8UfCONLR7waFA7y+SPh8GbfX5zTx5WvISop0zzRAcj8ivxqPSTjzVlVYhJ4hxQkMh/4YwwC3CoN0ezDrsnVe/O2SsggCv9Wigq7b4j4kzgsl0roa2AsSwc+b/e8NkWlschZaEQWI0MEg9MXTj5QtgwCizJqrnwRYvfMkUWhc9Ro3cNA+yWtlB+S3H8jyDnn3RThyU446ZQ9ywf7pG9JgFmidXE31fXDV/UZFD0Anr3AY4vPXjqFaVXMDWcKavdF7Fl7+UO20IW9fQGEcAZGXOt6vpEUzIeHC0V4Afum4bAdKj3CcLC6IkX+ZqzzUwDJbgdiGKT2qN4HhvtzddbgUlpTvMjmAECkF/OK06guXWk6EYvV7k7+1fAq9ALdpypWxyI4WP37nJC8SM60PXSowYQIa2bxZuB6yrxMUOGziU5sj/NQGMl3zF6Y4uL60K7C5SvPK5MTIWkKcJm05F6S12ZC+toGwq/YeBnTTXB6J6BUZ+0ba86VeJSTgIRu1gmH7BXQ8yUgEpchQUIudIp/5PvquzfuxCu0GUt1LLMUTwP47twR2Oks4s+jMBskbsRpDERljiYEkYQmx6lz2Yg1A3xWBpY/Vjh6hq8Gh7k7YAlMsXR8Rs2nV6Om//VT3rpn07EwZYFJfNNhO8/spBN33D8JOlVZ7NrVcTPq0MJnlx5XDH/YHCt8dFsydosaf1s8Tt7SA+iYGRBW6aNXXD6Mlk22o4vzcZDrehX6/M53ouTf0H8SV5viHwEYV9tzDoINlF2fGj5qE+2cEmEP+yo5GQ0sKMyU7EC0m9TRvIVWYk51bfOBmdsz6BzUJrZlk+jfVg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(7636003)(7596003)(40480700001)(356005)(82960400001)(82740400003)(110136005)(40460700003)(31696002)(82310400005)(36756003)(86362001)(41300700001)(53546011)(4326008)(5660300002)(70206006)(70586007)(8936002)(44832011)(26005)(478600001)(16576012)(8676002)(316002)(6706004)(36860700001)(956004)(2616005)(336012)(2906002)(47076005)(83380400001)(186003)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:45:54.4080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2090ff6a-c75b-462e-e1b4-08daa694de80
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6550
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 05:46:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9642

On 05.10.22 00:30, Prabhakar Mahadev Lad wrote:
> Hi Jan,
> 
>> -----Original Message-----
>> From: Chris Paterson <Chris.Paterson2@renesas.com>
>> Sent: 03 October 2022 21:13
>> To: Jan Kiszka <jan.kiszka@siemens.com>; Prabhakar Mahadev Lad
>> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Hung Tran
>> <hung.tran.jy@renesas.com>
>> Cc: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: RE: Preparing isar-cip-core for RZ/Five
>>
>> Hello Jan,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 03 October 2022 19:36
>>>
>>> Hi Chris,
>>>
>>> after getting qemu-riscv64 ready (patches will come tomorrow), I
>> also
>>
>> Huzzah
>>
>>> had a quick look at the RZ/Five eval board you shared with us. But
>>> that raised a couple of questions, maybe you can help:
>>
>> I can try :)
>>
>>>
>>>  - Why is the default U-Boot hard-wired to a very special boot mode?
>> I'm
>>>    missing standard distro boot - which would include UEFI as well.
>>
> Its just that we used the standard configs which we use for BSP releases. Looking at the u-boot code enabling distro boot should be straight forward as EFI is supported on RISC-V
> 

Exactly - that's why I don't understand that you are not doing it
already. The default setup should be generic, easily extensible. But now
your users need to compile an own firmware and flash it, just to have a
standard boot procedure. And you won't be SystemReady this way as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


