Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12148C433F5
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 07:05:56 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.50])
 by mx.groups.io with SMTP id smtpd.web10.7771.1664867151249729207
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 00:05:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cyZj1SEZ;
 spf=pass (domain: siemens.com, ip: 40.107.20.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VizAGbB0zvH8OuKGDKRCB2lM27qH+5Mq4oChW7e9zwV75otxGhnU48M6/lkPTRstfWovTQ+kUAbYTgtcfxVoiUM3zBwsa64HI1nMiwudK7OKnhDH6VghmHXsYlYvb8i3S/pMXDmo8utIJBcsuJAwg5wPGsmejfMZLjx+KPOhiyGW8t6AxQ6/hJQXXd1cgGydtjaxepQbDMD9toUJfdPN1G2DoJvy7Z+ZAaenJ17pIvYjoRpx0UVIDxnBXtY546kiXxyclzgrKG5+ddL+IMCqZAnkBnN7driVr2nOIvxgpunpNwJ5xX1bQDwbCHw1R8ynihw0P8t4iuAiYVeNZ2mMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9LC4Mc5Y/Y5gc5X4HBLMumjAtEMmNUjGJeyqkm/fck=;
 b=AK2QiDw3knxMNd9rqeYlZKqTVzO5nAPONH3Zx+BpwuzfARZvuJIF0Cs4G4ne3J6b7w4lkkOLsA2GCfYK3Un8U6+Nwvzf7Lf3v/ALYIe55lrPMupWGSEML8jt6XiOrJLt0KbMn4DDfmG7r9+eawqBMBO8X3VDvaf2rvqoF80Cqbx1Wy948eD92H2ih58SRvYaeTjO9+p1i6Mnbn2WYwJDF+ngP4PKGrv7zEaRjiA24p9j5NgUkaTsDyR4J335chmWWWcgY5HKaWI4TQjxvGGSFZ1PjkFH46C22y1Ta5PE/FlC68Uxcos+9m+Xu56VIutX43tq+sFfoKjJ8bKzBrkOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=denx.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9LC4Mc5Y/Y5gc5X4HBLMumjAtEMmNUjGJeyqkm/fck=;
 b=cyZj1SEZQGxKQXan6pYUmgEKi7c+8uVpEwLqailmBDFl0SWP8rdwiWSHbJ8Z2ExAwnnZHECnKZaiTpwfWn3JffGIJP/tWSPmz3OBN33a17xdLfFMUkgJiibPb3OYTd6jN6l8P8S4OQLALlr69S0xqF7NxGBxOrbwKjTyydNCirG4gROOpylOZB6tQh1LZP6rUE7Oe+3SAVm1MLgkpNcgpDf290INm0XK0qE6W3b+Ra4jQd8SHgowncFbZjJ6u7G+7alebBWR+PRlmbxYeP68XvhZZJxroChNfB+NvjszTw7vkairHxAZc3I2bVsCSHamVY3qWaxrZZnw6BUNgpPU8Q==
Received: from DB8PR06CA0054.eurprd06.prod.outlook.com (2603:10a6:10:120::28)
 by AS4PR10MB6087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 07:05:48 +0000
Received: from DB5EUR01FT092.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::75) by DB8PR06CA0054.outlook.office365.com
 (2603:10a6:10:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Tue, 4 Oct 2022 07:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT092.mail.protection.outlook.com (10.152.4.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Tue, 4 Oct 2022 07:05:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 09:05:47 +0200
Received: from [167.87.50.151] (167.87.50.151) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 09:05:47 +0200
Message-ID: <59d2c31a-8a76-cd35-58ae-44e1bfc47bd2@siemens.com>
Date: Tue, 4 Oct 2022 09:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [cip-dev] Status of RISC-V in Debian
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, <cip-dev@lists.cip-project.org>
References: <2e7cceaf-1b0c-e62d-1910-bf8dbe25c864@siemens.com>
 <20221003185510.GA9636@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221003185510.GA9636@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.50.151]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.052900-8.000000
X-TMASE-MatchedRID: Alur8Cs15mw5QaOxwNGfvo9bHfxDWoibnZzvVk+DChsrLrt2dsmOfvio
	Isi7Sa0gSStniYWNNsMgF2WRrDw5igcvukT+0cmEoZcXk5vI61ivMyWwzFWyi/SG/+sPtZVkOhJ
	9m53n4aDMLDwgrsK1O+vqWwNc5mGjtsAW347q0cVUZ9ABKSaJUDjYiT8OT8PhtKV49RpAH3vESS
	xPxTa9gxlLPW+8b7SaFl227EhadMGkAZzoFZCTkU1kA/urPNIDmbDQJ3bRqO2VSBCoZUyqbNGOc
	AfHKa6uUVUEnD5pC21xfYJim7iceJNAHEbyceNqLxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzyj/T1
	af3UZUCbKItl61J/ycnjLTA/UDoASF8QJ3WtfEPJzqAJgIs7jt0H8LFZNFG7bkV4e2xSge5zroQ
	Liwzpwvppfg9Jl26SGu9SkuQRoWigMFOaPCmg9WA7bUFBqh2V
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.052900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 993BE364A8EE82D1E74134C020C94D0C837D6A3A9813AB76695E1C39CCC16FAE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT092:EE_|AS4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a52ba0-f773-4228-fdee-08daa5d6dd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qSqTu79enpjyBSZHgEuVuJYVHLh5cIhZ0pFQSmjHNIEucGBSLo6zLT/3KtKD2nL4iRnWXXehzo10nGW+JrV6KBDtOnvLkec84a22rpW7vaQ6/E0ODBOfX6dVUCyVOMSZ80gcKzlegKzg4zULL9CHRKXU3vTUG0xQsPG5WdTQLckKQKb1UdUpKmSmeCyhdLitkeLYCrnZ6VyiEsq9oJM8pBpdEizHjBWNEZzuwQT3soJl33342vXXoeFzX9Ex2W+fGvNa8ly2Iv5uViVoEihYZGLAYq/+Op5eAU5pID1RuzzXf5799IKSGme9ZbJhN//sZQ99XAZyuvDqmzYZONbs6A7NA5q5Q0cyuR0VEtPvteYy17UF1tSIh1zGQ4Z87veZFd0pBQUrkZiR3wpoQF+iKMqAe+m9w/8jEcGe6LVfDdBkgFVpq2xOE8tsRvAoLCRrMoRxGv4cglud3L+xIYfHjwb1hjCdATk+L/bJs3ju/fh0eVf6ImucDfqW528x1Y4UP7Cd8fDmJBi/llQsbATtq/6gMs6sMeGISY0QISZJZZKd0XQ+yOnEVhsKU4SeUhnT/vCDeW/dbAwwkt4RggvVVgaJRkg8WQGplNvktwPAkcU2dqTIQAipu1kwE+t3dBZsNhUsMOWUiKmjQn158xU5fiugfCjBFm7X3QhaK3m+jpXhjZag5Y80qPDvMY0qe6a//D4vM9rUKbZPHbHpXHgEfed6yeIL6l4Th/J9h45Nqtt1W1kCa3bQjAsSpTEhrlTZrqIOw2gRJ0Veui6yIsZrB+bEgGcVY4vAnkxCecruMcuFozrfrQD16Pw6G6SHRFQ0rCAwYYQrRqiPCaH+zMO+lyKjkXgXKhQN4uYhnOxr/4w=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(8676002)(70586007)(70206006)(316002)(83380400001)(41300700001)(16576012)(36756003)(478600001)(6706004)(4744005)(31696002)(336012)(110136005)(40480700001)(86362001)(8936002)(47076005)(36860700001)(7636003)(5660300002)(53546011)(26005)(7596003)(31686004)(16526019)(186003)(82740400003)(82960400001)(2906002)(2616005)(956004)(40460700003)(966005)(44832011)(82310400005)(356005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 07:05:48.3065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c0a52ba0-f773-4228-fdee-08daa5d6dd79
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT092.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6087
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 07:05:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9618

On 03.10.22 20:55, Pavel Machek wrote:
> Hi!
> 
>> worth to read (also those of previous months):
>>
>> https://lists.debian.org/debian-riscv/2022/09/msg00012.html
>>
>> In a nutshell, build hardware is a key bottleneck right now. The
>> preferred SiFive Unmatched was discontinued so that only personal stocks
>> can help at this point. If anyone has an idea how to support here,
>> please share.
> 
> There are rumors that powerful x86 with qemu should outperform SiFive,
> that could be one option.

This is what the RISC-V porting team does already. But it seems to be no
option for an official arch by rule. I think I read it somewhere, not
finding this anymore, though.

> 
> Other one would be this, but I'm not sure when it will be ready:
> 
> https://download.intel.com/newsroom/2022/manufacturing/Intel-RISC-V-Fact-Sheet.pdf
> 

What do you mean exactly?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


