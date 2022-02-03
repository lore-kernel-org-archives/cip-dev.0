Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB451C433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 06:21:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web08.5810.1643869273056701656
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Feb 2022 22:21:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ewf5S8oP;
 spf=pass (domain: siemens.com, ip: 40.107.8.43,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALs56ElXYjk5zb4lOxQYohmGiih2J354h63+/ZKtON/FEEgJafyiAkrlgvDKNdDrETuVEWrlOmlpcQjOr1YsvztDyLXpETN2Tv69wZRtBCnyhlJ3mMlIIRBHH/+d1FXAXFOdWoTFdNjreI0c8kgkLLfS8NR0DhOylNh7fpbo74/zwS1u4sPctFA1dRWVKZ8mOP7+bmZhb/K5naSUzycDcRv3GaEXvFVGpCIiupYwR9Eqd8lpGeUCPZoyVwHYYABiQOMYarpaJ7eUTTd0vDjyfxeMITszlp2GKjSLyxJB+YTpaOBO7BoRThOiHWhsSzn0EB8EHgPi2J9Eb6OCN4xM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH04WvU4CNDS9NcR6lvtrCRHumKolwO0swGWyN+fohk=;
 b=iL5TOwm3QtumKMCHpcnExqQYk6INzUN1UFtpVrLt9LmDMWYO5U3vIDLoKEe5NGlROCwpFCgKZNkirxgiYmRpYKQs2gbzd2TRFAKM/Qd4VvuC/3SmVOVNmOMPasdONIL9AXaByH/izZPppi2osvDhIBlxSx/KHWgepTenaZMEKWa1hmKKw3ixLpo1Jw5Jjemc59lw2Qp/UaWhaBA7PWpodA12vwKwDli1HOS80aTA7RCYAH+ncR4FfXB2I7KnFf+uSKaet1P4KW0mrPOXiyWVEzrHJ3QQRhRlrjVcuMGuzawUbctacil3n3+T1C2kRBJIU6cqsIFM2mo197R8BxRG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH04WvU4CNDS9NcR6lvtrCRHumKolwO0swGWyN+fohk=;
 b=ewf5S8oP2dm3+I/qXgiVlif7v+59B12p+fSbximcmZN5u9ABSPdEyMkJ0j2dJDCmonsMfB3Zitfuhm4HEjYdtlFxa/y931IjZR+S+PgFecC29StjJMPo5FF2h4Q8lGoOz1JYkj2nCQCfj4yU4PaCAfha0aT1X0wn3rFyrz/qlc7l7SXKKLpJ83d64hl6I1VyYluV4ELUDZU7bhWVqPlCz/OsSUTq5EGNy+qlw2cChkoOAbOZLk8TLJe14vy2YWPqD6P7FR30kwyVK9uj/88ssFHDsmotdH94vcqd9ZsyORI3LVFaM5WC9aFHCYxL4d2k7toZncEe7LuELfjzRlPcKQ==
Received: from DB8PR06CA0044.eurprd06.prod.outlook.com (2603:10a6:10:120::18)
 by AM5PR1001MB1042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:12::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 06:21:09 +0000
Received: from DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::e5) by DB8PR06CA0044.outlook.office365.com
 (2603:10a6:10:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 06:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT018.mail.protection.outlook.com (10.152.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 06:21:09 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 07:21:08 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 07:21:08 +0100
Message-ID: <8fb3690f-6324-306a-33a2-632f7932003e@siemens.com>
Date: Thu, 3 Feb 2022 07:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed1b48a8-f125-491a-ccfc-08d9e6dd5e1f
X-MS-TrafficTypeDiagnostic: AM5PR1001MB1042:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR1001MB1042ED9CB580FDD5406D412C95289@AM5PR1001MB1042.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xpWIn0S4ozZXYw7k2QbZpFDHQUBYPPAxPFKDJB+l+C6nLwWPw6v+zQVzsFjKNuiWcXwchuXRQXD1Z9bHH4f/TL4Z5n40YYdfO2jg4IlKQz/bRHu/jvZqCaN+fjXFgAeBtM0wluONrVVi4TGJOSN+VrlX+O0uYk/upJCX4ifXRB598csleqT0iJu/B2mJdq8CqTrfLMVvmmdoyPz710p3r4ydz8Oqw5avgRwWH3pHI28LLXjdnR/LV1vSsP1AM5OndHm3y7Tpaqqk2bU/pePINnUEY8aF2BCf1nlClmGObEePm1Ht1R7sqM7IJxjxe+XpljkGpQRmNQUQ7c/BGVw+LdhnNvx2+rvaCsWck8CjwhJSWQlFhZcNCa0ZK0OwPokjVCfS0fPk+tD02LGlQhgm2u9dTvmyRScdOr+SXhBjsCUnE9v9QXzSkXy26fyObIUje50ikJcIiVPBEzXJ2b7wq8lBmyEoDyYSUogJxsfLKw+SauprjzQW4y3bOoFcUoW4oosPzYT39Ddxb0kUW6G4khWAKKpaemYp3ttVjIKIQq+IWzj/PKKradEan4nvDhgU6HC8kbp3fiWTPoiHlTNl0GyFLcQj5DeDZ9BonSrcucvJpjfKLVS5BBs021it3m281YJtftio+pXQ8+UZC6ce6AMJ6A5gP2JgfRS8D9OuY8kzmINf12D7SJIEUqDzm798Xyq/tW2QzKwDoKCFdnLhSpHf3xvISTyUJWSB27IjAV2RggGoZw9/5/58AtPtWm00i371Y3g25ZZ+8Vmfci2ktxHfZELtr8/wTT8oBYBBH1mUMEajvf9x7clOEDn04XFLYJvh2CfeyX1QSumv6mVPoGDFKfkHHZUKXKgQ3EtIqcc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6706004)(70586007)(16576012)(316002)(31686004)(8936002)(8676002)(70206006)(6916009)(6666004)(2616005)(4744005)(956004)(2906002)(44832011)(36756003)(5660300002)(508600001)(966005)(82310400004)(47076005)(81166007)(26005)(186003)(16526019)(336012)(356005)(31696002)(36860700001)(82960400001)(40460700003)(86362001)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 06:21:09.0157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ed1b48a8-f125-491a-ccfc-08d9e6dd5e1f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1042
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Feb 2022 06:21:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7566

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=2&day=3&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2022/01/cip.2022-01-27-13.00.log.html

* Action items
  1. Request private KernelCI branches for CIP maintainers - patersonc
  2. Make TSC motion regarding linux-4.4.y branch by CIP - jan 
  3. Draft press announcement about 5.10 release and 4.4 self-maintenance - jan
* Kernel maintenance updates
* Kernel testing
* AOB

Jan




