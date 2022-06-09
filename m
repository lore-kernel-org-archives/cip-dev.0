Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97CC433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 06:08:00 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.45])
 by mx.groups.io with SMTP id smtpd.web12.7166.1654754872055366268
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jun 2022 23:07:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z8Al6I+i;
 spf=pass (domain: siemens.com, ip: 40.107.7.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjdg+zO00IKjQS8+SUQ5uOJC8AZLbChypZX+EIv9EH9B7KQlKWiUtESBZHaZGMp5eBDDBsNXzR4vJiNmyHONk+VBFUBb26LrFPB1LsypSVc4EtxEMdmlZUUVARm1g4+H6ETn/HRegH152VfMmT1xBv5qwzPiczBDqxrmwsyY8dmaW/J89KbRL5CDlA3QsVq8TP5GyHnNNGt9gjfGsm735R8Ev0Vkp+FkN8bql6lijcboPQX8h63BLcyxPb2T2boiV5WHcnkcfi3Yziwpi9Q7mWjEBY2RkZcAj7xLKd8uTG5h32hlbHyev9R+yRu8fz09U0YYSYJ7ExorFiAxVCz9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uko/Pc/MBN96VfPdJN6LO7O/1DvndEy2E8OnLIwj638=;
 b=Wwe7L04SyGCIbdBR9Lh/pu/0wV8NvA8Qty6C/9ChglmV6emTIo62lp2smq4wENCneWwgrtx7Rxeqwkj09GrRBwunKnLRxnHldQF8QNmCT43W+dmsdadk/B3NQe5TAGETOGqm+Mg7BJvyXqpVWlxPGCvbYs+ZOzikTwtMdnsccVtsTTOLiFg169q978RQJy7xhVoYSCYr9hbSnH3AO2a+pv52uy4bCLSqShGL2bF1y4k7XwI5zObjPcIIFUvd4YAQTowkaWs27X/jfbGEt2oCGc8e5IGRlDMOMgzQjCVgOXUy37YfiH+c2OiSRILPkP8BpjwGGfsuMAjD2nET/fVLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uko/Pc/MBN96VfPdJN6LO7O/1DvndEy2E8OnLIwj638=;
 b=z8Al6I+ikJK0o088hc3uI890TB19oXhiEMr6y2Y/Iwm7zCxPiU29mmiqdiE9l+jiR+ZWmzVd3jO5SXiYSHGo16YMhAzfhBj6yEYUk56j55qlyAuA5ZbkejXI1vXPHsuKxHeAyfxFzReAxSYg4VvX++gcoJj2KKQSdcdI2+KtJO1sDvLr2UjfBD4MGrtwvw4JYD3F9IieaI2Jwr110n/ExJfiphwrJ7FhgVOB4GOhgetys4r3qEMq2lbIVSGosm4UB8mwfP+NHPsq7bMpAu3XFjLjeTtCVgX73bdNU6P2NHwprpLxwEoX+fItnxxabGe4UsHoYQ5hWciI8SkETF6Rig==
Received: from AS9PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:20b:46a::34)
 by GV2PR10MB6281.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 06:07:48 +0000
Received: from VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:46a:cafe::69) by AS9PR04CA0049.outlook.office365.com
 (2603:10a6:20b:46a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 9 Jun 2022 06:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT026.mail.protection.outlook.com (10.152.2.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 06:07:47 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 9 Jun 2022 08:07:17 +0200
Received: from [139.22.107.113] (139.22.107.113) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 9 Jun 2022 08:07:16 +0200
Message-ID: <8535fea8-ee97-de4c-7a23-8506e9d22233@siemens.com>
Date: Thu, 9 Jun 2022 08:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.107.113]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.870100-8.000000
X-TMASE-MatchedRID: 72nS2hokiaRUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtrrXu
	yaLdFR2N9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuEtX6aAeatX5ydVNZaI2n6/30tC
	KdnhB58vqq8s2MNhPDFsa+Yz2ePk1BIVsvVu9ABvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.870100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9C5FCE36475853B35AD65B51BAAD6A2AD02199D976A040A4AA3957AD81DEB18E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05efffbb-bc0b-4088-522a-08da49de608e
X-MS-TrafficTypeDiagnostic: GV2PR10MB6281:EE_
X-Microsoft-Antispam-PRVS: 
	<GV2PR10MB6281CA6118C4B27611A0C7EC95A79@GV2PR10MB6281.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZqoPjC3p1OvnOmEXUnn266J172ZCVq7PQ6auAKwV6w7RygyKxdgG7SONFGc1oMtS9OGhO76eQT8CcgYZDDkbUax2k4NanbYhWqAum1+85kb8Sg/FeOFztGP6EKjUW0JnJ/0Odec7wIxli+qEqPYVpBJ4ySiokkYT/DURvuGZs2MAxW06PUU8XcnRyZd4y8ZL3C4MZseT+PgUqsGBapW6BzFOfZodRuOVNjuqAlNMqgqxjDyiXWRarXs0lkycN150AQT8Yak1GlICmpE+c1C/LXxb8H2iWgolg3G693OYJzh69+G1ECavBSSTbb+OTFlyJQeI2teL9AR05UqLkyMghnUTFkKUNzGLGcCJLl7e63V1vEPaZFRrellYyso3JHrAzX3msMB9phPwfGIt8QiL3ua9Ky7/eBpt/aLfvDj99DX5oBuTOImFE+FFCncNlVc8pntDdkHB1UeJ3MIuEGT9uLrsXs9XwwHD+xH7BDW/tEupjkpKTJ5M3ZVeJU23UHUwsbaE6iahPRsoGJFuBFc7tWbHwPcOgJvdw5BKm+hTXPEB181+xzlzheo1i84SM2r53g5NgHYA5atggIrk3VVI8t4bCLYFKcgcKwgskYKpdi+Cj5S0T7kmivMcPf/Yc1qgyZ3puVNntNqne49etoqDVGh3iLte6ACjZqu13zwYslOgMmQPx+CXwHhQvghlSslCiyg3OSMczfa+b99N8i648cdvxYOwH/63sGi+UA1oAZ+jc1drPBmBd7uYeusvv39i7p0fnYfzpD8uGqF7i2Y5aHo8PT74meOvu+sAI9Wkoy6xgRx756HxyTjhTZHu9llONoDmcLWrU5fGe0uhmhPOKHmf7ZYbdkd8ZkSk/VEobAY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(356005)(16526019)(186003)(44832011)(36756003)(36860700001)(31686004)(81166007)(26005)(82960400001)(31696002)(336012)(4744005)(316002)(956004)(2616005)(16576012)(47076005)(70206006)(8936002)(70586007)(82310400005)(2906002)(6916009)(966005)(8676002)(6706004)(508600001)(86362001)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 06:07:47.7385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 05efffbb-bc0b-4088-522a-08da49de608e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6281
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jun 2022 06:08:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8520

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=6&day=9&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-02-12.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
  - Update https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware
* AOB

Jan

