Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1EC6FA8B
	for <webhook@archiver.kernel.org>; Thu, 22 Sep 2022 06:44:54 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.71])
 by mx.groups.io with SMTP id smtpd.web08.4315.1663829086432574608
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Sep 2022 23:44:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=e5K+uyZe;
 spf=pass (domain: siemens.com, ip: 40.107.8.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbH9C9miWssJoEgPUdOSHOYziBsrORbVg7v0kPiAUrZY04KbmClDFtDBJKOgIsB1gHhBmyDyKR/3y9vW+d7mRB85dcHy2scZXRFMGgE6M+lJC4XCNsjFYdQnpvvxYOgJFhB/BWMsjAZHAroHWucjecnEt1d3BDt9f1InFkzPLJTYEejKUsmitsGxjaptg+yNBqHkr5r/ARgtXlhTXp+rmWOwrRTQN8pUNZbXqU5+AO1A/JvwQ14mDMAGLSawUQcq+MW1pWM0EwTAPE1pzIvWFIeU9/hRi3ZTTlntXTL//5fbgF3mEYYfcajh8LIir6rAWLpaj8QlbaXB3NewxxX7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOOJlNcpKlIlFi2x6p3Mr0GKF8Hs4YWyapDWhNbRnN4=;
 b=npCEUdZljQiOdukPipVg+j8QFwDUtx4bpw96pOswWbo7QP/3bmD2bV35F6vBQRPf2TMNKb4rc6ppBiHLEQjrrx3YJ6+QXXBzr87Zy7+yFx7o9XifucSf3SKJnL69uM1TzOxpHmunTkJPQr8FPBLK+a1NBlFbddPfkZXPN20lCDto0LG2tiaDUOo8Lq9qL8uQljypHnogQhEr81fyRx+dbYLGZkWHjN3qDauPFyBFQWQk0WSAqTwk6l28fGWccHq20Yj+hAyhkQ9QpGygvAhi4lI8cm5eTmk8ys0WxZHjwMFjG4Wt4EpxdfkGPIS1nZbCg+wsIEL5CkUTljPiDXPDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOOJlNcpKlIlFi2x6p3Mr0GKF8Hs4YWyapDWhNbRnN4=;
 b=e5K+uyZeDyqnCzCe24WaQ7HZb0lsuuQXGzEGTZKocpIm47CJlt3POtxnhuaVvbLdoUiUybch2bUHByM/J7M1go5HbF681K543EWYQmf+K1o+auTL1up7pSr+/5NNyxLE50Ve2c6Jmqd4Qb4xC2yZymHozSgJpQXRr42WYEm6MHsXnwsNXMag0weKnymWKNk4uspLbbPiDut/BTcI0ne58RWasgUp0lBbwCyQ901w3XGADECknaJCK0I74fxdIZuwOftN5H84TIfRFLRZX5Ni/4gnnmVkz0hAymTikYFWoUsv2HCVqEG2N+bXlFjG4WUDuXzELq9WwM6weEFQaXQQMw==
Received: from DU2PR04CA0350.eurprd04.prod.outlook.com (2603:10a6:10:2b4::22)
 by DU0PR10MB6606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 06:44:43 +0000
Received: from DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::2f) by DU2PR04CA0350.outlook.office365.com
 (2603:10a6:10:2b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 06:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT057.mail.protection.outlook.com (10.152.5.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 06:44:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 22 Sep 2022 08:44:42 +0200
Received: from [167.87.49.217] (167.87.49.217) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 22 Sep 2022 08:44:41 +0200
Message-ID: <f60066cf-9e06-25b6-8324-c6a3ec2483a5@siemens.com>
Date: Thu, 22 Sep 2022 08:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.49.217]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.146200-8.000000
X-TMASE-MatchedRID: Fi1yTWlF5J9UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuEdikwbr2sHIEgCPGiZqtI8EN22
	hs7Z5mJzP9LEqj2YniVxR16rhfaxRN8tiIBIqnBkZOl7WKIImrvXOvQVlExsNAtbEEX0MxBxEHR
	ux+uk8jpP8tMOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.146200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 52166F87AF9A0D504B431A008A0947265E499DEA51718E84ECD16D6C843D33592000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT057:EE_|DU0PR10MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 6395f357-92f2-4c46-1454-08da9c65ee53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u1y0Xpc3Kxv14LkfLis8m9l6dM+cD0l8roH5w3xLizFHE4QDv3upK3xRvAzuEhc83w6nSnbAEIBXzJC/kdlJ8L5oe/0ihAbv/JUEuOnkVCLE7Ooxgj3pLNqAzBiys7jjp1bUvxwvO6kMmmChb6jqfQsaC8tQAX5TTcdpjbHcghpHXFefsiCU95vds4CaqCNaxZHpY169Yb2TjtMwdovM9mhNLoZuWJGSSEZfALK2+PzdZHJfa7cW2vw1bCGFbNNuoYK4Ka/XTbXvwgTyyBmriV/V6R79xE8tFnunW4864hAkWkB4tuTXi8tEq0HC5E9S/oLNsMewb0ToM78GRtaehlo14gZhyZaXrq2JWiQnEfXX5mxLsfni85mmMN8XchZYZEbaSRu7HNpf8sl3muBcqlPOZDFJFG3ZbnG0O9MWGiXwRqy4ioHGwUOZ5zL4s+ywq/czLo8QxvcDr1Sv4vXGin5hv/qjJpvzvDYMPT5xpv8qjO1mpl71xRAicMcPjIkxYVo12xfTmxGUXEqW2rMYMnmCzBhOGGiSLDs3g689eoSv/S3Gc7ignqqZQkshugA/D5QAiWKu6JiH86sugwE+/gghBGDFktzlJEC0zEKx2k/ijLTULlgMBVEzH9hdcbW+8EWreW1foUTsT49GpiwykUKs4R2/5ztgTD+0YN4fEFHIv/3ABjm0qjFq+ZoqgvctDN18rnd+2EExQdJoQoPnXK/NbXt+Nx5772C6MfHdNMOa65qvkmiNeQV/3pXMs3WHY7hHZMce4PT+sIX2qmiwdWa1XONBNAf5lJBwNDsTxkOG1wPc8n26b2HKvNTB9K3cRQb6nCeSxcdTlKpgoyGd67qG67jIzn5h3XDAndl/xPru2o08UjslbGRfKfdx4B2Ign6PebUWZopRTDSDFCZI2g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(86362001)(31696002)(41300700001)(8936002)(5660300002)(356005)(16576012)(6706004)(6916009)(40460700003)(81166007)(36756003)(70586007)(70206006)(316002)(8676002)(478600001)(966005)(2616005)(956004)(2906002)(47076005)(336012)(186003)(83380400001)(82310400005)(16526019)(82960400001)(82740400003)(4744005)(36860700001)(44832011)(26005)(31686004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 06:44:42.9773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6395f357-92f2-4c46-1454-08da9c65ee53
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Sep 2022 06:44:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9535

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=9&day=22&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/09/cip.2022-09-15-12.11.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB
  - task distribution around 4.4 maintenance
  - enable Uli to make hot-fix releases as well if needed

Jan

