Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D1C433EF
	for <webhook@archiver.kernel.org>; Thu,  2 Jun 2022 06:49:18 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web12.3703.1654152549148260082
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jun 2022 23:49:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZNfDLLlP;
 spf=pass (domain: siemens.com, ip: 40.107.21.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX7VtKHymEiczgadVEw1qm+Xcy5QYH59iznFRqUfXvjzmhiCsodlcBURt393lZtDGTS21X2a+vFxIn5bYCb94x/RF0bxTonjixhwgwJXFzjbJYSSa3hHv8EKo0zkbStM+TaflzKAM7WO6ut5drh0ZSvhzMNTFGyC0YMw0zjo6BA/nOZ66AG6YEDo6zEELQHCct6bvesdEQ3CwstrXZhK6zWseZGTQZVp43YuRZXbB/bm47AZ4AJlFg/G7bU/yWIkELz9WnKTqwwrvtwSmeqW5lxdNRcjU7eOz29+/aFYwzx4QJNWzlelg87PuUuWBwd4g8PbGnqTYS++URL23inX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPSNh7O6+UnS4SaXKCtWcJ0BJNfNA4kWuHgzkGkhTNg=;
 b=FZ5koANWxhNmDWk+7szRFgFZ0CKzZG6ANg+7BFN7hqfUHbvgkTIHDtw6YVkPBnrp8GMJCrCxj5YXySmPbpZPemkuSTL3zJanf6zXV2JuNARovqI1dsUP6IFQihgeP6TPel7v2dTi4dHxItUJ8AXnL9bjLoiN4C5aijKSOL8cV0AewDDg20WyaaSnmKgcJFhWlnDNnE5u27fsll3xwEMC9SDVePtn9rzA940L47yR3YNQfEj8To/EE0QT8J+v+RUeRb0og/kt17BSgQXufOcyK+rKBxt4x3sLY5YIOAXI+9Va+8Wk2xcf49aUPhl/spslf811v5X/pUzYI1eP44gAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPSNh7O6+UnS4SaXKCtWcJ0BJNfNA4kWuHgzkGkhTNg=;
 b=ZNfDLLlPHji03YgzxbBtTBYMSGHeum3m+OiEByAKdgEfeMAbj3gsAtH1dTrlpQXsYPVlCerhG8219kU9SRddcHe1tlw7qGtBWQHAcpJVuk7u8TWGVc08yFgLHeqENYFu9ESoBD/fKuIhTgfoOJy0n8M46xGw+8wcZPKYiZiGwqUHgSTkM0dq9FcwGJLFT+ojez9Jwl+UTgJdv0NoEPurM6xySG1cLhomxxBHVcIzOUgoJYvVsq3ElB4gvcGeVvjrcHuMBl8ZPVtfXY+RAkUHro4WpMic9i3V8KiNBcxGfIKAXndoruC85wcVVGjNnwsRYria91R113dxcnZbWZ72pw==
Received: from AS8PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:20b:127::22)
 by AM9PR10MB4991.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 06:49:06 +0000
Received: from HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::22) by AS8PR04CA0137.outlook.office365.com
 (2603:10a6:20b:127::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 06:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT050.mail.protection.outlook.com (10.152.1.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Thu, 2 Jun 2022 06:49:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 2 Jun 2022 08:49:04 +0200
Received: from [139.22.142.154] (139.22.142.154) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 2 Jun 2022 08:49:03 +0200
Message-ID: <7e707a0a-63c9-71af-ff38-368f3a8888f2@siemens.com>
Date: Thu, 2 Jun 2022 08:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.154]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.616500-8.000000
X-TMASE-MatchedRID: EhMq+2gclHtUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVlrpE34WGjdPo8WMkQWv6iUD0yuKrQIMCCAtDqHg/4Qm0C1sQRfQzEHEQdG7H66TyOk/y
	0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.616500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 FBA5ACA32B28CFD676F0D1B5BDCD363300EFA51BA8DC8430DE828963492B16422000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37565763-e674-4679-1ba2-08da4463fc51
X-MS-TrafficTypeDiagnostic: AM9PR10MB4991:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB4991EE227B36EAB062B6E10A95DE9@AM9PR10MB4991.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xZcdsLAi0SyCTWjE8We02Zk1HuiRPWraHBpsfPkAT/HA2rs4YJMfeUV5ReGkGGKsYwmmrYDKFItACcLIGj+H6Bu/RynayeH8ue+qemaKRtypICYlftcXDo4npe13b8tbCD4UASIroENN7GR/Q9vQiSZr1asMZOS92enmFdxhkApAraml60i+QKcYi32r+frquEWVMM/mmPyJKLGsW6yH7b8ugaIhr8CZ8ZwG/NzX5zTjE9LCF7GykPb94X8i+jgm2+Zdmaoz60Q0a54sOPVMMPFlhp3bjv470gNi7s1g1FE56EdflI7580/qrCiIOa7c2xulv2rLe5xUsivdezJmMRFiVruCzYguLJLQi1K8timR7rcwSWqV992HY8yNnJpoY2eMGUyRdEr55tJxE/eSj2wTJgimEKzPM92656+tWyFX6pwWsHutAP60DRrt2uxpzHXlQXyex6HSRiK9Ixsh5vVIoHQb/6sxgrjdNtokn4ymmlh1eZkRb9QYXEdvN4vQBFouwavWB2O6XV4ypQde/zODMXutzwHtIe7HydA75d4CDpCRm/RT1wGrS1w4kK2Tyc0uA66g1x5/SmV4v2FBn9Uv+8wSpzRlnAHAmedfU3+2PTYO9J2OYDkvniNgydqxQQ0iKoPgbT7oiodwED8kw5uifkkfz/oe5AzeoCvtNXwF016JkLlnf4PVC0kRgu4k8saphZGzRTx8+cvr5cmqP7K8ATh6xRHl5m0zgJdPzkmoY6exbYy/Duu3Do20pJ4eqzZsKiiJQl646Fktkz/r4bXoY95WN4jEMEzvYvpFRW0nDfNV+AKjTDY4LWH2pA7fz2LzlyOWNLB0+tuH+3dgBS0ZMv/vxXLrm7OCTAGz5Dw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6706004)(8936002)(956004)(86362001)(966005)(186003)(36860700001)(16526019)(2616005)(70586007)(36756003)(82960400001)(336012)(6916009)(70206006)(5660300002)(82310400005)(508600001)(83380400001)(2906002)(31686004)(81166007)(316002)(40460700003)(4744005)(356005)(8676002)(16576012)(26005)(47076005)(44832011)(31696002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:49:05.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 37565763-e674-4679-1ba2-08da4463fc51
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jun 2022 06:49:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8477

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=6&day=2&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/05/cip.2022-05-26-12.13.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan



