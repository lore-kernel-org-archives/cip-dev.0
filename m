Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43811C07E9D
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 06:31:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web11.7403.1664433058378092418
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Sep 2022 23:30:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rRtr6bNC;
 spf=pass (domain: siemens.com, ip: 40.107.20.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQyBHFjaCXpm7fvyxsApGdt6/9qMTolGY7YTNWP/KvMpm6J1vglIpqJx/CCfq8fj+REnk0eGsVH+oG/XJiNvclbRHyCfn+KOZ8Ylw4m7p03Nx+JYP6CsQpddPvcm0nJ2RT2leYp/FmHvZ4mYdCISNncZy5cmrRO+SJU3E20Pv82pMXLWz76LnsbhI7mG+K4rEph6V+p++gt7JwTzrmfQbNtWKva1wg3WXYzP8oco8HoO7FmnZzuu7ib07q6aSMQFhFEUUhr30l8spw7dOVFQfWzu8O62gWG3+tpC8mb59azqY6B9xPUfWddQocpaKf7ACZLJr/SWuXh0SJtBp6Tf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBrJAJoccGIqcIVedcUrBRftG1sfS5EdaNgY6TRd2l0=;
 b=BYPyZiGVqxi+6fKeEBdcCg7U5V5DKHEcr7oVCs+MgG1dUz+wrYJFOu+GPSXtXo7J68i0Aiet7G0ajpi+v5plBbXPp9cWNIWUstx4sN29INsJrlOUwPeSEUUOlPZH2MdFX7BEsM6FiYvlgXRcD4Qq1u/ZrIYm5Hpem7N+4yvx2iFHsPTf8bhIzYP7S7HgFP/ToXIfW1Hdtoblc3m6NkBicZKwDCS0Yx8udU9SuFlT1Pa8q4kno52RMustny5VGmag4Sccv25k1VB9TuKwSRCqy1ymtRjybBObh2QEgjHvdf3Yzdz22Tp9Zq9KRq3yn5TixrYf/xEv32XdYH9sqdnH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBrJAJoccGIqcIVedcUrBRftG1sfS5EdaNgY6TRd2l0=;
 b=rRtr6bNCuN0ud8KIc8thnrqzIFln2yHbuxYBn+eyYqe0GuxEpTlxsZi8CKACzR3S/w1loAZh1z6t76x9MxFoRrEx1xSx6nu0imhbyL9lBZWqwKqGnIMyvEtHNN3Zt2mZrrAwJpE4y1vyB81/FLm2kVlTCV/LjuJNy/soqpcgbZ82VGVqdHHGmNy+QisGR222+uBLHWhSPUS9sEDnfqE9otx5dbhjloOQf8LW1lyu5NL1wOtn1pFvjgxx4s+LOsSOKNmvQVKHFvWoCgV9FO1pNR4YRbrlLHfcbUeDZh8o22kOKlqbFdDQCzzngg95LPB2haFTlITOXcP17Bq4zpXAUw==
Received: from DB6PR0301CA0029.eurprd03.prod.outlook.com (2603:10a6:4:3e::39)
 by PAWPR10MB6854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 29 Sep
 2022 06:30:55 +0000
Received: from DB5EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::4b) by DB6PR0301CA0029.outlook.office365.com
 (2603:10a6:4:3e::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Thu, 29 Sep 2022 06:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT095.mail.protection.outlook.com (10.152.5.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 29 Sep 2022 06:30:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 29 Sep 2022 08:30:54 +0200
Received: from [139.22.104.172] (139.22.104.172) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 29 Sep 2022 08:30:53 +0200
Message-ID: <222c550c-97df-4bbf-1b80-bc0266b923de@siemens.com>
Date: Thu, 29 Sep 2022 08:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.104.172]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.697300-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj9UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuE5UcZtwNsCro5f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQAbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.697300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 81C1488975BA819B6B970C8667BB749B0258B46BA4FD3958CDE1FD59DCC8F7342000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT095:EE_|PAWPR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfe92d6-7c03-48fb-cb07-08daa1e4299b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qEXfdbdodtexJOBlDiPlt5eOOlayIcHmigP6T+HAd7QZzvghp4LGnonAYvMYaSfmB6P03qMAr7WM6NcxNwcltDZcWK7mYMPNs135h4pq3Qq0ucqCzxmZdaxTKu2iKZIu0ky22Gdr6rroqWEWnYSeT677Qh+U2SepkmEvn6tgVJX5rd54dhRSL1TSmj2oPI8LXMejyxHZ7yAeAVbCc9D0EX89p2xkDnIEdscy1mYI+K+OxRwuadAEj/QohASdNFEewyxWqApiOF5LrzRqXdMZwjLRkDbS3o59milAOT3TZ5x8freEJZ2vepIaBAu5E3+vpIfX9lNFFtfaUpM9J/Odq9+WBKKmeeVEysovxiqTW7ijBnAzoM2/OPvry5dZhEvJFS/EGk68faOIoWX4UCQJ7uge9j3Ff/apv2QsClFbkGtrMH9aC6YAgy67nSB2YYz0/GNyN7FC5yDst2pV01VeocsEokEzSdQ3l32VpwigMyVQhVYBYqFGlbXG/NWIYzURARvzqAtwt46qdL1NQeXeJ7vEPmhJ6YP04Rs/Wj7tN1KKLyHKBVTJMksLc+G3h1z/TSPUO0Q6C1L2bF1hftMel0/7pB+3z14tq8DafKuvDLFu6c35Qz6xi5NRFisM7bnyAGIpgFhoFBoYC9noMqROAIxX/gZ+VsdIV7t+EvM/F8DdRY/WCV+c3Ni+RHMKjsc90251Ih5FeeoTVsnlZlNWJJemah7LwQyA7OBS9EcxVLS381OKNWUU32+bKwEp9Apm1dowRYPOinC19/1dKYbTH1PDfRDqoMDBVFdNQpVcJ5XcOCj64goAoG9ucOpD8bHS1vp1CYxzgnXbMlgamB6/nnxXflnObkI4aLvx5jqDCKCd7eWarwIzijR4i742JCEtOyFFIPL40HPlGel9AKrzJg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(336012)(26005)(31686004)(83380400001)(186003)(16526019)(47076005)(8936002)(6916009)(82310400005)(82740400003)(31696002)(966005)(478600001)(2906002)(2616005)(41300700001)(5660300002)(4744005)(316002)(6706004)(16576012)(36860700001)(8676002)(40460700003)(82960400001)(44832011)(40480700001)(70586007)(81166007)(356005)(956004)(36756003)(70206006)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 06:30:54.8412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bbfe92d6-7c03-48fb-cb07-08daa1e4299b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Sep 2022 06:31:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9574

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=9&day=29&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/09/cip.2022-09-22-12.01.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

