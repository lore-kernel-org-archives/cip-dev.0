Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE7C433FE
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 05:30:00 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.85])
 by mx.groups.io with SMTP id smtpd.web08.4185.1665638991893811178
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 22:29:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BQJ542q6;
 spf=pass (domain: siemens.com, ip: 40.107.7.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2mdnp6RQKXgbMqptzEeNA9uzUjWa1r0WjITgOU5WbwjYmjaAB3ZGO62mHyED+tyRdgMFKzxzB2fhR4hZaYOmxKL+xeU8EoB6h1pc2DHw3xDx3Umzz4DAj676JSHHWBrXip4rT4iOmKxaqtp0U0m68qHbjS5T3B/YoN+HC1yaYgRW936FKx/dkYrjtqIYggYTgy5MA3PBCSRNzDWYIL4mH242mP80ZE4olbiVeGQx4bO+pMjMGh2TYvFgmPLk1en/F8HIkxhDXYi108kA8geJvVowsSr8NGZkG9aapoEJ03cBoDb/eonpiqJyEVNIBsNy0/eulcMf7b+7t0M8rEYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK3aI6+la1/0Yrkhh9b5p5udHlPf9P1ZP+1Iwsdljy4=;
 b=ZRT2hgup3TG7zj/megfHjBqYe6GsXPVer+OQO1jrBgBXGZH1JPpfBW1X84Bcef4ckUQD+vJq1w6lWBgYwEIm7mclqQSnuEqEgt5bG3WVEzEUSM5P8FIFMgqgTcRFubrFgQqZWmTiQpbdt1GotFxc1Wix+yxExUMzkmOuMuIi7eWXTbwGND57pZvzhJSKwR4KJkaFS6bWf30SCmrhtOj/AB+V4bSYYeMui2YDDJE5W0/UIXbWXfHvPtpiYzGd5C7Lm8EhnckwW2PN4Ed9WZP3Rf4PLt5iItHCtrao946w9WYP3K8UwzrJustWHbx7dTGZxN7Z0zY6oeBYlJ5YaBZtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK3aI6+la1/0Yrkhh9b5p5udHlPf9P1ZP+1Iwsdljy4=;
 b=BQJ542q6uh17kVtONCHl2XHUBFv+g7qR+KehLjbEeJGTmEw3rylBk4rVJHGAGxTEPCOpTa3a+udfdL6xM+IIBYomon/uU6cIR40eoDZ5zqqZT1La3o1m/U8F+Wmemdg9aPzNd4pa9diVZQkh+Src7KxbJAuLAnHX2V1d3mnr6u1rRYAPDJV/ZGSJrnzd16ppvP7jvuoZxa53rXaKiTUltR9KgKEWrAcl5mOtlVdYA3V/eFjXCJhMQgaaiyF4H6GZoWftDtPIzUjmBWPLMNa4QT7WGzMtWjjOlN1cC+lMQiF95+bXsvGzCJ7HPs/NplhmKYVZircY5gP+9zNpm7vQ8A==
Received: from OL1P279CA0039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::8) by
 DBAPR10MB4041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Thu, 13 Oct 2022 05:29:48 +0000
Received: from HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::8) by OL1P279CA0039.outlook.office365.com
 (2603:10a6:e10:14::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.39 via Frontend
 Transport; Thu, 13 Oct 2022 05:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT046.mail.protection.outlook.com (10.152.0.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 05:29:47 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 13 Oct 2022 07:29:46 +0200
Received: from [167.87.51.246] (167.87.51.246) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 13 Oct 2022 07:29:44 +0200
Message-ID: <1a398699-0450-33f6-ba42-1670238ede2e@siemens.com>
Date: Thu, 13 Oct 2022 07:29:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.51.246]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.424400-8.000000
X-TMASE-MatchedRID: RfRf601lRZFUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto1by
	NCHOgAtejMOEZ5AL0SVrTXesWFJ+jZ+ntuToZZ7uNkO9xDRPYVTX7PJ/OU3vKDGx/OQ1GV8mrz/
	G/ZSbVq+gtHj7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.424400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: C2017149F63EEC1AA11B8D42811155DCD1253CB65538DC9AF9D19D106A2CB9EE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT046:EE_|DBAPR10MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee96ef9-afb8-4d3f-1077-08daacdbf190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	y+zuNq/j663epjrMzUwAcewJ0fqNwGLd7ss5NIS8UZK/on/Du6oloBDXVJ5wZo7Kkabo/XVgZitho3zrZkPHGi/eSVXc95kvTmg1UINskkwKLe4jDwYBFJoCRSIh5cLQONrJ1DYGTsM9wlEyT6X8cIvHKufiAQkntQuVuQOsiwgMbPWZxBdC6zU8GOgFKX6WfjKasX5cviSzlIVHy9j41wy/klNEBSINENGPw4zQ6kULbWs7n4MrOUQHHGXiRiHheywZ1kHw3RZT7ds2JxNVWPqFHzBgigPpiPSssitFQ6GKt5iAR4O2kTAkQfI9MoMwdN1E348GDp4gm7ZnLGrhLZcIKWr1ZfkMmG1j0kPUziUBvF6BjP7H1n8F49+Z6sgBOSiV0V7LFPpnTFZ6vgGQJ9hpb157SILJt26ZEseXbf2Id4hXAslx8qdpXSsUUn2uULFCapgsDi3W+XxeuprbV5dGpUddz2vZPb8tP3P4kvEGoaexNgaBGHK6PJNrR4HGPPk+qg90NMqrbNd1BRrRs8Dhy1wphmJRhzYz1tlyfWxP1H8eqg2jtFzU5QrqViiWsZsyDL62sRRGbgzTOHgf4HyInZ47fjGGDIXn0G5slljuLecG8dJWMKuHyUyGqcgZSqWRddMKgMZSsCHEqbyslZNwNaWittoxUmZbR5av3Epjdl/zMy63+1uSrpUoCI/6nu64ANdh6cpbN8Hx20eVb4bWaAylLhK55hFUyArVW0rlXww8W/Ts2hc2LRN4yDZlipkZsy38do0JNbKWnXzXuatQFgLiJ/xMFKrbz9rdDvj2W2YTf6RN5Sgs4OEQGCgDVp3xKHqcMFG1KAmRg9sXCf7oXgEw3x4FtfKL217d1fcqwqNNIW/wWGTcWJbym9eZr1tnkc+kfgnmqWAtvNooaQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(31696002)(40480700001)(86362001)(40460700003)(82740400003)(82960400001)(356005)(81166007)(36756003)(16576012)(316002)(8676002)(6706004)(70586007)(70206006)(6916009)(44832011)(2906002)(186003)(4744005)(8936002)(41300700001)(5660300002)(336012)(47076005)(16526019)(2616005)(956004)(82310400005)(83380400001)(478600001)(966005)(26005)(31686004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 05:29:47.5818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee96ef9-afb8-4d3f-1077-08daacdbf190
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4041
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 05:30:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9748

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=10&day=13&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/10/cip.2022-10-06-12.03.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Add qemu-riscv to cip-kernel-config - patersonc
  3. Report retpoline situation and plans to TSC - jki
* Kernel maintenance updates
* Kernel testing
* AOB
  - input for effort plannings 2023

Jan

