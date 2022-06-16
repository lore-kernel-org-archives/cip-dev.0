Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3602C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 06:46:11 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.59])
 by mx.groups.io with SMTP id smtpd.web10.14961.1655361961650614130
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 23:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oIiaoGaU;
 spf=pass (domain: siemens.com, ip: 40.107.7.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc9XBpI89UpkqDLoPCVy0hvterLlz0l/+rsid5kTLp0mfAHo67+ZKiL3sh76LKTr7bCJVK01/h3yGJVcZM8ND6/C7uTSuwfIh1aWVTcWIrZjdiZYQ+3oigoQ9QyD790A/0t5uT/nIi9PWVP20Lf0pszlmDSXVuT1sX2BYfag+2k81xvUZc4z/OdAT/9AOiISo/rcbiifUDNbz2Km59xryt70bJYSZeOnQK5/GmVRSKWiYMBIR3IrAu6OQ3PWOXwZSQl6OR6h/zkw3H5GfBcuNSuDaIRmUGlldeOBS/zpwQIiYlh7PMK+LJxUTU+AXAPuYSqsFz4VRKG7oBLTp2fwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXBwwy45aPTzo9dcHnDJpayKlPHAJguUN22JXIhwPtA=;
 b=CjdNk9a0NdnqRnkp4FMAHIf8vU2mctT9zYZFhhjssV7LDm4QyHUCF4XZZiqye1AOKfh8iK9E0euNzNlWcRP5KC8I9xmsjzp+9tj0KiAfxR84DNN0C5mW869UGWGBSWQn8NpB2OzeRuwksjg5yGzottmDofZn0YeqVGfpgVKfM1xkFMh/sKpAUA2hTQ1dxIGMvcVaLEfHCTvTEbq1Aqnrss/UcY/0eXOUuUj4GDVLS/IWqAwh/ElFZ9kCWclXVnNpID7PhN38V4cZQ/JDYziE2RqjyC3BbWNNsOmccrxixYfyEgyOhigXJIi8ioRYk+fPdPUIevSHEhe/ZW438Y0Xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXBwwy45aPTzo9dcHnDJpayKlPHAJguUN22JXIhwPtA=;
 b=oIiaoGaUIMqyQelj9lQBLGgzu8QWt2ubqgBpYNVYrl8sthKxYr3OS63g6CgkqNR75qqtj7PkfYpGpx9ReLj7ngYJ9xv1Dg33Oaha3o+JxncKLbcQ21spkOdkTdKMJyZzIwIk5bFKfk+8ZXSFJzz7peid0NUwNCW1tf8spXhWtCxa05T9nCra1SSONM+LtuJWgwdiM+l4BgM7ZA0StUUPWRx3V1XtydP3kDVm3+444uTkdDpeF6tLVGEMcUXfjJyRi6McNMUPPckM6GrqH+X9KhfCpn2wc2YQNHcDfdeUMiycMTe6buhLzLbRqJkRCL6WHhR1mw0jg70Nl7/0Mad9qA==
Received: from OL1P279CA0003.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::8) by
 DB8PR10MB2665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.13; Thu, 16 Jun 2022 06:45:58 +0000
Received: from HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::85) by OL1P279CA0003.outlook.office365.com
 (2603:10a6:e10:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 06:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT015.mail.protection.outlook.com (10.152.0.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 06:45:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 16 Jun 2022 08:45:56 +0200
Received: from [139.22.104.253] (139.22.104.253) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 16 Jun 2022 08:45:56 +0200
Message-ID: <349a076d-208d-c8a1-056e-1e2ef6102e1f@siemens.com>
Date: Thu, 16 Jun 2022 08:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.104.253]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.680600-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtrrXu
	yaLdFR2N9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4inZm/Y3MNbKgYWo9dIuk10AkgXPI5D5JuEk8h
	agIbaGmmyiLZetSf8nJ4y0wP1A6APkvV+z371TK5MIx11wv+COQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.680600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 FDECBBA4A82AD000F49566D751457D80BA2FA262E97F76CCEEDAC0545D71626B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb8f9ab1-c584-4363-754a-08da4f63de44
X-MS-TrafficTypeDiagnostic: DB8PR10MB2665:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB2665B6E76F0D8EE142D1376295AC9@DB8PR10MB2665.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I7KoX6mYwE/ydVOz/Zfdddy4iNQqCW/j06QFVecYhsb8LcAbvo5HnaSLp0pbzASKuqAOswH082PVkHFKKSvq6F3WkVFGcl81+ZXxB+keZp1pgULcYHUwxS1ZEFvtgl4zzC18uaUHbTvtsJ5XDG15B+oLNRrug8HD7M3f9Q1oU/v16XFZb6zbdE07rx6ShDl3hF8BIzexrgXgA9OFO4Pyx2JSmofm3/CxfKnKjZwBe3TAnNdMyEL5bxyGCFA9GPTx8/K+E/Mm68Db0yhDymjCOI5BdVK0nRg2WsC1Mv57kmrkLkyKj2ym+ypl/3wnHmxAGjJTQp9oHrbi99XfgwRKcMd4WCwFiqnMFzlpqn+Z2Ekv5pDYLu7FNrWKZvSGL+9p7ijP3pFRO9rgP20+yMcl0rvwbSs2I3WQL4C8Tc9yP2px5GVuF2qcg1h6feCpwasLA7nwmhtFG0unCGErmPHmI9obEwpjaAP2V35WLUBvkpowdkzg19KA4z1hONUe+vwG/W//ohoNljLQZLaE8fsEQ9wFUqxaKFq8f7z2DxBNpfHSwPtxjQ+vkq7NmaW7n++pL0gS0yLz4UCkYbdFsrug9dpPepfnTBzGsp3YiLsgT6b/NECoogXJZEFBsEUCWGXgqGvD2sIWq8QQjNHPtOyUOfIIX3yZ7ze7mFSidTYpCj00r6v9NQMbSchR23t+3IUIqOG3Dpz0OiIa9XVOyKhXMuht/JhLLmmlntTc/VonaA0ZUfCu+s2sI8/wz0kVLpw2/gXZKVUmCIl+YjM/DpAu0vmImvkd7q9eWloIFiHsbsHGjv4ZwB9SUumTZ3eDBqHYX7c9KOej7k+YQdi8S77f1vbvfYNzZ9C2KdpDp9YdYD8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(6916009)(956004)(47076005)(6706004)(2616005)(70586007)(81166007)(36860700001)(316002)(16576012)(336012)(8676002)(70206006)(36756003)(31686004)(5660300002)(44832011)(356005)(82960400001)(8936002)(966005)(508600001)(4744005)(83380400001)(26005)(40460700003)(2906002)(82310400005)(16526019)(186003)(86362001)(31696002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 06:45:57.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cb8f9ab1-c584-4363-754a-08da4f63de44
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2665
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 06:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8568

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=6&day=16&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-09-12.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Check cip devices on kernelci old pull request - patersonc
  3. Update https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware - patersonc & iwamatsu-san
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

