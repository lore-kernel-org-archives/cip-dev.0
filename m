Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C7C00144
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:57:23 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.84])
 by mx.groups.io with SMTP id smtpd.web12.1673.1659592640299404031
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:57:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AlYyDCYH;
 spf=pass (domain: siemens.com, ip: 40.107.7.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOgTU7o6GnlyC0MDqR5f95lONbg11H0ujOaEHTROVbpJMtdRYWxKgeODYBG/s/KfVIPelk6DinjHpbpK7EOJM9nS3a71+jk9JD/7D3iUPZdiFdAeYq1FtTedwlMZEFJqB6/mLxP1tTALp8yiZ/pzkJNb6AMZ2DqlYbcM9lgxAeLCuXaEeEbMJ2oRHBk39bW2heT5AKVVessWs36gM9+plUrPrVpe8keajsRRpuKmvmbO7kb6V0N4zM7o4b/bM2Q/vqHdC1EdqUVQDDOW9CjqbAUYeEqB8taX0hY95scJWCzAoCRDrCRUnJLTeuRFAzO3qxFRhZpU7e8YwyXf+YAAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwRkdRVhLCM2ECD18/WH5jgwk+7c8YAn2mMQCT/UShg=;
 b=Ygizx4g1wcRLW8ce6HAw4uBDgflLppw8kcBkIrr7toFLkrgWs81kvjJUrBjUJRiz5L5NTCYNXEw0VrBBF3GFQ9PFGHWCWB94+kn404VEgiE3fHFRypsIk0rlY2hYf5vUAZsPwCVKwukznJ/nNeA9MwWMKIlyH65v0gewoEsOAkxuxFaLac8Ox91ykLS4CsCoGhbjhJk+YnfJxaoP1y7Tzkce2lGSEwjgm7W6rmKTPiQFown5tPo0CHaCE2bCEBGE+q1eiZWN242tYcyn7BIqnOmXg1QBaj9NMDif+a7tm71JTimaxhzIHmeM3qKAn2x9aSRIkoBgNAKQHVvdDLHh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwRkdRVhLCM2ECD18/WH5jgwk+7c8YAn2mMQCT/UShg=;
 b=AlYyDCYH+dsLPgY/NFcq88R5SwU4C6axewHsB+ajB3jtOn8sJ5MdHlk1NC0At66iJyXiCH0QuvRL6y+EXz1HcTt7tlX5ax58Z+O0TC7TlXiu0YigED9ezkCULcdGwooqS3dc20FgvSE5bQ4jCW7lAuRwY/jIRiOVVBKhABdYC2kEECHyWuhye+ujdj+ra/A/UdodXc5CViKiAjKnh63pN/CcCVP8AKQ1XvAOidczpyyD6snIHaNLgTejACDPHyV4pr2eGxmwbgtDFhoRBkJQQr4v5Ia7ijOGpsJBdFjgtiIp8bgd7qUkjJKUSuz/WIIRkp5D4Dlf1itvLnw3f0e5qA==
Received: from AS9PR06CA0117.eurprd06.prod.outlook.com (2603:10a6:20b:465::32)
 by PA4PR10MB4511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 05:57:16 +0000
Received: from VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:465:cafe::40) by AS9PR06CA0117.outlook.office365.com
 (2603:10a6:20b:465::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11 via Frontend
 Transport; Thu, 4 Aug 2022 05:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT105.mail.protection.outlook.com (10.152.3.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 05:57:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 4 Aug 2022 07:57:15 +0200
Received: from [139.22.106.222] (139.22.106.222) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 07:57:14 +0200
Message-ID: <258caef1-b155-3dce-8f5f-1a571e79e188@siemens.com>
Date: Thu, 4 Aug 2022 07:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.222]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--22.204500-8.000000
X-TMASE-MatchedRID: kxpaLTp5p65UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuENd8z6+a6WjkCLBN7QiqNl/ald
	N464boK+0drU/3/X1SjxYyRBa/qJQPTK4qtAgwIEFY6gDmeXI0LbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.204500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E42394DC0E478B8D2FF9262A1D7956D3B5FB2E5B58B4DB2E1D7CC7011F7D78632000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ace0ac-0a75-43af-7c2d-08da75de2eea
X-MS-TrafficTypeDiagnostic: PA4PR10MB4511:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QTg84/WGTFlNh8m4L2nW2T9vsB1l1u2RPgdKON/gdCtK602KicXeXaKz7C6G5+CyV/Kx+okc90VuMoVU6slbc/Hu44lTQJ0esRRdITDkmQLYZLb72Lpm4kMf4qxHCkkfUDZp5f2rnWK7au7mXnvbYd874MvCtbUaRsgY1TXLZYlfQftJ7gXfb3ZjSJ8YTCjfABcramgJMLC0Igu47olbG/Xdp7rXKAw6rjsnXKMW41fyIZ3xN+EYTzXS26Ka/jlK5YZh9P5fTH7sDeCvteVu7UH0AemqsTYgovGd/56vajvINvXNKy7JvtoPnjsiiE+uwTzmr0qkZONGd95V4AwZauNY3Ez7T+aZF2XoTj+IXS6e4q/G0iTLb6/Ka47XGnKABE5D6Nf5N5uDj5DbJaMExGNItd7ejL+rZ1OcrZa80DlIFf8OwGMQVZTKaCNLlH+D+7vqXQza/yyYqBC0L+U3fvLlZIF7ogfUjcKAoRXQz3jEhtE8aRXi0dsPwNkL42L8UCRpfh3zeDCCOkpOD/Z3c4mHH5AeGD7w13rscjeri3N0vd0VY8eyK6gvF6qLH9syRqB1qpKUfc8NWh1y/j9ueqBdVIFL12LoV7KR699FxrX/uhTwYDn8hEVNXCS4lf0m0k97bHwXPOs6MF8FZKZZGktySUH27bX/NbmOhidRTr5433Ya2c1GtMWsaUOQl/lXBqkKUKiZUBQJrq4e1uh0bs3tgPg3fH2KS4KpmqtWQu+t6xR+x9Wak0NoJDfPccqPSqRlQCgBfTia3mgoP8YG3xH1riM+dcerNBB68fXxqtvyKeQgg9JRWEU+YFSkEm+eLD4WGILzQBzIk2T6IEcN4q11Oghxwh+M/RpY23Dobgzp8VXTfcM8UmpXLkqCxtnAPyFrxwUUjbgV4uzi4Z+VQXXymzz316ajhntJn5XOuVNc+miej+ekuC4yCxpTXoLp
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(6916009)(6706004)(8676002)(70586007)(40460700003)(83380400001)(70206006)(966005)(316002)(2906002)(16576012)(8936002)(44832011)(36860700001)(4744005)(5660300002)(82960400001)(356005)(40480700001)(81166007)(31696002)(86362001)(16526019)(186003)(26005)(956004)(2616005)(82310400005)(82740400003)(478600001)(36756003)(41300700001)(47076005)(31686004)(336012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 05:57:15.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b5ace0ac-0a75-43af-7c2d-08da75de2eea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9114

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=8&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/07/cip.2022-07-28-12.03.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

NOTE that I will have to do some multiplexing with a parallel live 
meeting. If I should be late, please start without me.

Jan

