Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4C1C433F5
	for <webhook@archiver.kernel.org>; Thu, 19 May 2022 05:49:56 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.50])
 by mx.groups.io with SMTP id smtpd.web12.4279.1652939390590111486
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 May 2022 22:49:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qjEsF9Fp;
 spf=pass (domain: siemens.com, ip: 40.107.3.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT36cRiMnKwn48opyb13N2eapfOOCc6RcnQbgDzpt88UyK2gq4JeskyaeT1Gzbqpx3K9Gmv0AuJ8AIQZHsiPjkeQ/JlIOpY8LhqoroMN0+AaoJnH5dCnKesnZiYThpwdaNdh9uG6Q1lNIMLTbiEXw4Ts7jpVAFMp6jLZRJ7bg00nS48ip+HIZEeg+YMlkLgVWt7QthKCg1+hSMlKZmVjBpKCxpNHUGEAhga8bO45lgnWmZuH8usyjisO51ex/9URPMddUfn+gPTEQRdtda09C2Gc98/HZ8/Mb9UA4ZHw/sr+x328w6gPWazAh0FYLJvyswXV0IOixkk9zCtaE8Z7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QWY4DbCDgOYPyKULrqABoDy7/Pm2rC/vNygAEBJ5ow=;
 b=hNhruakBzTd/P30px2+VFTlXaLGT2zWZzzEYTZRqetPHfpjid+5A2hP5Pg3fjwKx49lEq1r2uFuLwccw7Wd1+xxDM3TPpadx1tgy39IZoMjg5YVZi4DPYMzmuG25KiAxk8JhKkHefUX90AIWNzlu2NIWS+6xROSgtDqMP/Is+DTB/+VDRw/rNf3hrSqlOk68k9g6YEoKRmxnRxDmzyUUL+LoNrLSXREjauS86Co/edlbGqlQBcRlHhMq9l7OUMQSW0c0DQnl3tbe1b9yIxqEs7AWtJ/PQs9QJHVpeGhYy+rDU37SZ9GMVBNuZtMjReEBIkYNUpYVqMXRjLpcifyvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QWY4DbCDgOYPyKULrqABoDy7/Pm2rC/vNygAEBJ5ow=;
 b=qjEsF9FpvwQ76qCSLeIlMBxAFMnsXcvve9ZWH4P8Q8GjL6i9YKi+enVsJ0JdiXS7TQr2kLcxe0l4GPl3OuAmrJBebgt5LYKq/2qlilFm0J+HDGndJ67Ypfq5y/rG36I7RbXhzXL6fh8aFicSSwY/DprihbCgYHs8yib3WkyekkEg/RCYVDNTM0ajUJFsIQ9UUB6gEOVzWrFwIqHEIPbxnzm+F4p9Adr8kaAhzRAeubfDQufAZZQmlHR3BN5uAs3ZqCDFN9QOQwtblQbNrunFTA1gQJUSiipQYwnEzcZZ23w6VeJD45GXJw9aWxHsTzloQ1wfHSDzhOqfQZRpUxXvWA==
Received: from DB9PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:10:1da::31)
 by AM8PR10MB4755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:368::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 05:49:47 +0000
Received: from DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::c4) by DB9PR05CA0026.outlook.office365.com
 (2603:10a6:10:1da::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 19 May 2022 05:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT075.mail.protection.outlook.com (10.152.5.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 05:49:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 May 2022 07:49:46 +0200
Received: from [139.22.139.96] (139.22.139.96) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 19 May 2022 07:49:45 +0200
Message-ID: <4b964b4c-763c-d27b-8fde-0851e9c5cfff@siemens.com>
Date: Thu, 19 May 2022 07:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.96]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
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
 6688FD6BE65B8F1097C35B9AB8564656E03907C66084BE1D59D31DDE40A1377F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 078d04b9-8ba7-4427-f283-08da395b61aa
X-MS-TrafficTypeDiagnostic: AM8PR10MB4755:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB47554B810B4E0A85012C8FB295D09@AM8PR10MB4755.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mtsoJKMXaJg8SpXwPT+ynoghDx4RAcGPSaYLsh1ARb+5M52kVfW6Jzy5uf58EQapRZQVTq39qWNCMpo5ApxE9ka/TSb9Lw+zgvj28VOyMCyzNlu9+y/k/TFA9eEdMa6WpS/2N7Cfln+sFIB60ydNOS/+EXn/JtwEogC1QJ16tKUoEeOGhniuNnqER6EjmE7/AB+bXlmqzVhjWJsU27vsG6OW0kfyDBzDujaKNWxw7Z7t5VjA4v0wMosoCguLh+NAIhco4yuuBhqjTunlstw6aQxnsZuWa5Kmmc06TuRM0mLuO3/i1g8rnpSBJssz2FCN7me+/GrnMOV03Fs+XKYjBfT3fcDHb8wd4oYk00C96wJqnSD2Io8CvnOtiZ8EIDVSECYE9kRsJd1e+sjTU++2x7+Lw4wtwOJYAGkRJPDoNXfsu12iZ39+63hCFXO01Ya/PQDeqXwYc2lIUr4JccMRECpfmYD2auV31L3RLBSX9/uijEBK2Bw0Gr2oDvyVusxMMaltibi/+E3JfYn+yz45YUe0I7ETb3kf1EX3MGLDfBIz3XZy8dbDVsfFrheY6PJVVg/oPejUf+zTm2e+k6LrS28Tav18LK0rLUF38I1cGxI8wQ89kiIFV1lfPBvs5bZLKyt5y/PoJDR9F6wQWypVJO4DiGHKtceP6w+XuONky4+QroCvxlIyDaDHp/cR/GwwJdiIYDFjtmT0ZOpgepJmxdwRQbYeEyWxoHG0IWZUwn8jkLTWDyoAXJ/LR7BY6OILSQDIrA3wIorZ29sD+zAgfz7GyI28qRaAxJfQM/HkaqKchkyVY+OIvevNZZ22gIZK
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(16526019)(956004)(2906002)(4744005)(8936002)(336012)(82960400001)(31696002)(47076005)(44832011)(36860700001)(31686004)(186003)(356005)(7636003)(7596003)(86362001)(70586007)(36756003)(83380400001)(16576012)(40460700003)(966005)(26005)(70206006)(508600001)(316002)(6916009)(8676002)(82310400005)(5660300002)(6706004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 05:49:46.9121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 078d04b9-8ba7-4427-f283-08da395b61aa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4755
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 May 2022 05:49:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8413

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=5&day=19&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/05/cip.2022-05-12-12.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

