Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE0C433EF
	for <webhook@archiver.kernel.org>; Thu,  2 Dec 2021 07:29:53 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.85])
 by mx.groups.io with SMTP id smtpd.web11.5385.1638430192084155800
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Dec 2021 23:29:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EGE2nvwf;
 spf=pass (domain: siemens.com, ip: 40.107.0.85,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGGJIQHTS2tw8GPy+RfmZvp4HtA5YSrnTRVeyveMarnbl4RMGo2N89FLmD2gLgys99iuqYxcTy9XigcKndp+xsqt6gYq0sEp8QMy2XrtWIb4Zcz7mQt2it8ETj3+K9NMu3P9/+2l4pVoXo2+RHT8ga8vNXASTAS8zyabPHSVpWqsqXYKMv7WmzcWROm9M/uQ64e9gAa46PIO+vOw2iLG9SJs4yklHP1VdEM4a8IajeP7+KfDuyI+wbGpGaPOhLIX8iKlKhrmF4HTNX0BqPaBRkXSjBEF8fMN5bMdxv8g52PTO16zyDn5RM5jxlOE83oFXZSThtNJIEG/4hHJSulaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5Z1RLQuSixIwRLoAbc6EVe2xx8VhOEjaw18Uo4JPlw=;
 b=UYGnbnmtoyYTYKMcjxcDRGIl1uxK3S9jlLtSAepAOKYvecl3MHsWjvq9DHepojWXaouHhMhhz4cOhzdkp/cNAYXwzgSE80Qc0oYd5KjZ7Fs9UVUkxMk6eQ3dyIHaFWiqqd6NWtzuaCUUmFMeT7rFbu5vxFgdpirAajAbK5EhnyAHLGddSSLGnGOYHUlTRtV4RjKnmpMpb+RiyK40FIp7yTXdaDPzAMjJ23lConHoqoGzO8h5AlqABmCwiE0U30AuQ1EF+XEa1oeIH6adCIWyQ0GBDdnBbaynRB4nj/pqN2UP/8jX2pc2bMRaliqzhhw8nZRVgalgOgBwFOc7G4BFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5Z1RLQuSixIwRLoAbc6EVe2xx8VhOEjaw18Uo4JPlw=;
 b=EGE2nvwfcRsVV3IjzzVLv7BdtOuUkyEmZ5yxLNnfJZE+OB/K5nvB54ckBgKQysIynGViDrbblKE8sQ1eYAlw26sITLRc4ndcbvM8YlkuZCaVrfgZi0afJOOeCzVMpEmWv4k7a4DnFXbVR/jYnDyV0Xvn92Y1iL/hr3jcvkSRXu3jCHGTl//bNCplA6oeQ1+D5LHXP5cYQvnXN6qNgj8kVFvUO83CF0bSJilcTuNBpYpJ+BGkcqDURNaUc3NuSDbgmbqAWiGa9Y8uwou9gc/FuMWCsawkMcWF4CF+KmEvi8GUVOLVYgYKm691lpiW2zujRePnPX67pdwFPIsrlcCCvQ==
Received: from AM6PR0202CA0040.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::17) by AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:182::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Thu, 2 Dec
 2021 07:29:49 +0000
Received: from HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:3a:cafe::84) by AM6PR0202CA0040.outlook.office365.com
 (2603:10a6:20b:3a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 07:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT046.mail.protection.outlook.com (10.152.0.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 07:29:48 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 2 Dec 2021 08:29:47 +0100
Received: from [167.87.0.139] (167.87.0.139) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 08:29:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <47b34fd6-fcdb-21dd-640d-a1acc203a768@siemens.com>
Date: Thu, 2 Dec 2021 08:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.139]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94a1919e-b1ca-40a2-e871-08d9b5658580
X-MS-TrafficTypeDiagnostic: AM0PR10MB3154:
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB315473517DC1C8AFAD0E9E7195699@AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IINHgapUO1qA8bOTlaPI1LgJZrIRB65M3T50VWIablgR6lfltBxr7TfktZXU5NpQspMMwuZ0+QcPynGI9PR4lq4CN/JroVtLdrI9QYg0EJ8s1Tm4U4Q0OYZ41rSJlphzrAnz1lVaHEhRDVj7x2EZGAbAlDn0EDNEXZgqSJlwBamFfBiwQDP+Jcn2kVRsOLe0CyUHV6rJryfWXpdTEzX5gi6gzu7P10bPSqadDq+hd8683VcTN7pYgcIHK51/Fdie57OUPyp/+iVZMyuPs76RNU5m6lFpV3Xp4WozIiqswVwG2qCw9Pftgn7c6ETnzJ0la1un6M9asnXVO+efecoFk7YYb9KWI3GqJ3MjAuM3bR9B2UlbMcykidrDrC57MxWy/Xd8SGfyU2/QynuZ/FzSYRPv7GK2HtaHnsM6/jqc6mudo5EnQyC+GXY8x4D4zdmGwfu52p7IkmmDz15xr1EmrLI7v/UnsPssE7FNAhzavonoAj4c3CgVGox4UVOnlyx6g29VkTZUKop9hDA/pOprcaS0ACUxaHGue/FyDPe1rdX814FASSnhG2tjYX4obZJUBx/CeXYfSiU/ehQ+BusPH+8eHZqgpy9mB7rB7BFYLAS5T/FmA0KapJ/YM2WTIf2XCTZekCAF6h3B2u4htUX23nPIaRjGi6dn6x7sGNt2E+y6Cas2IIuo32xv5Rqd12s4Y1nMPw7HNEUY9l0zbhMXXaWS1Hwdz07H+3cq97GBVr3q+gYjQowXkXSC/j0dKw5XAvpNSEMQhDw1GhHStLSePciI8pa6yK0LEIvDT5G2HYiJmPtSdQEH238iP15/N7fcPwH2qfGIXI1VTqQQwLvYdAJpc1WnmIpAn84H3bxNzDdf2IikFqEubB6j8JMYtp1nxBTdcyUYxes3xGzBclYo7A==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(16576012)(4001150100001)(2906002)(316002)(5660300002)(186003)(31686004)(86362001)(26005)(16526019)(36756003)(8936002)(47076005)(36860700001)(44832011)(82310400004)(508600001)(70206006)(70586007)(8676002)(31696002)(7636003)(956004)(6706004)(2616005)(83380400001)(6916009)(356005)(7596003)(4744005)(40460700001)(966005)(336012)(82960400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 07:29:48.4939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 94a1919e-b1ca-40a2-e871-08d9b5658580
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Dec 2021 07:29:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7058

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today.

Please note that we moved from Freenode to libera.chat. Our channel is
the following:

    irc:irc.libera.chat:6667/cip

Furthermore note that the IRC meeting is now scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=12&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/11/cip.2021-11-25-13.00.log.html

* Action item
  1. Combine root filesystem with kselftest binary (finishings) - iwamatsu & alicef
  2. Look into S3 artifact upload issues - patersonc
  3. Perform initial comparison of KernelCI results 5.10 LTS vs. CIP - iwamatsu & alicef
  4. Propose tweet on KernelCI-CIP collaboration progress - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

