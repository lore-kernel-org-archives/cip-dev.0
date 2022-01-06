Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F1C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 08:07:09 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.51])
 by mx.groups.io with SMTP id smtpd.web08.6095.1641456427414536288
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 00:07:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QDQhRHte;
 spf=pass (domain: siemens.com, ip: 40.107.14.51,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxUzGAZxJ6bYGKX64LuxRJdGl0+jwmo1XcZQcScXE/RHPRFcHD4aGZ7QdEqGzDYJSmNd5kNe3x5ZATj1niC84Bojeey0/EcSb1iVhKIWy83wQf5Ji6pIvFPd/H4MCG2ze+bsrrx1NIw0S3yAFLh0yYIDQv0mIlh+WmzBlRwZWMe1wwwfH5zomlynnjHJcJlsm8tV8XPACR0SPUwavq6oVkfQ56/eZhrhStEvAUeAWSXrbPdNLXUC7vG0pA9UmAWk2QAS9y99KXiFobHY8yAMejgxYy24W2NBFua536dKfOaMsbQOdqacOs0ffXOfajiUgrg9TX4SjyZZNjZre87N1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu961MN4zExYGxiA8gj8DFANK4QDpR+mxO9qjlThwhw=;
 b=cxyRvNzQx47IbL1tI9zLCbloCEkCkJq0+pgTaGJl0YVjeQzmP0UMG/bI01ntFoJmKaDlu680IUR7yYoxqzLMf9rZrbIL4CdshAIIRxFZxtBGa9Fhh8girrIKVYvYnIPzgXSgKUJqj24Zq+y3hxa5LM9wU+NzE6bocfaH6Njg7wjppdsM7TePd/C6xsI7Naf7h0QsVWXoMHfCbuUWwdNu6ZhVGm4wdV8SPC3ZENwj+qv6P3UbYOE1sQysirli3ZEBGG9px6K0XTf/wxy+4mB+qnby43XdHDIheE68Za65YwC0+vyYEVkkE/NBLaiJACfoELqqDYmUOxcBh4qEUQYYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu961MN4zExYGxiA8gj8DFANK4QDpR+mxO9qjlThwhw=;
 b=QDQhRHtenBM0Om5E3pBEPD5/gyiJv1M1gJ0yqSICfSMj/YnPcZDClBh0FfI3l90FIAd9zKlvx6N7meHKUR+1Kpxk3wqYZelDrw06RAd2Nzm730DVTz170fPn4rfDDh8TOcEGOXw3mT6H5IyQTQl6VO54Wz3PNRDfaq8lPqNqOh9neDGFmNzNbv5eyjG6tdpBZl7SOql+yShKfS4857pGiEm1mI/pv7RfpivZ/VXfLqxX9QPLJh5LHodRAaqNC6XTgsG4nO0mla4wX0s8isTF9nhl8i7MxJ3Q42Skc5koV5r1cG+b+1E/GfW5RdBvhtBt1LAlBRMtYE/RXWmRQWr+7g==
Received: from SV0P279CA0008.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::13)
 by PAXPR10MB5358.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 08:07:04 +0000
Received: from HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::2) by SV0P279CA0008.outlook.office365.com
 (2603:10a6:f10:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 08:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT046.mail.protection.outlook.com (10.152.0.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 08:07:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 09:07:02 +0100
Received: from [139.22.142.68] (139.22.142.68) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 09:07:02 +0100
Message-ID: <f86e524c-4ee7-2bb7-d146-4858a75de5bc@siemens.com>
Date: Thu, 6 Jan 2022 09:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat External
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.68]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d579d0-3070-4ec6-400f-08d9d0eb865c
X-MS-TrafficTypeDiagnostic: PAXPR10MB5358:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB535834A8B3FB250790522026954C9@PAXPR10MB5358.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LxkzAR3dNljvt3BPLMz8F1mHFUU8fqV9/Gji6dfnGQCWVk42y6ew6BHRisEcrw8Hgdadc1I7Z4MvDPIUc95CimUuUxeKcnXvZRxex1SxGiEE7PKjIgPfQAWlYy0NYofIMtRb/gMU3pmCoN4Ru7q5TMSS5dNhVrKxe3tR8pr8hoyaRLq7KX1qz/4Xn0ISJfi23Ercz1nYhNhMHHhrSWJbT9MVKiuWGuAuQ88Mg9FD7qOD2HDrh3RcakANkAfipgAEvirtVYJgGFLIH9LT7XIZYVKWbKTbatdvWlpL/gDIXp24/lW2HUy/htCfFP71Q8OriPH0MP9rBYJWOassykU9XnTdOgWmKhJzRIVUnF+ayFiqeggd/wP86ubN7c/7kScGj7pMRaJPHbvQhcDdce/8C2KuA9zW6ZT2ThRphzkQ6buM69OwundbQ226RC6/qRd8hu89Oo1QJqSKMkOI6q7ZNiJXLWTszgoIkMh1S2PSfwb02LkjDyhhLoZro81dYzuZ0ENMxXy7j8DoLVmU2pWl7CQiIIhpASajrTdRcRUu6B3m67x4N9ZtOm+OlQ3Y253OW9ZWewJ4TB+GIreFOrSSCs0K6yrafpTbmAysIIeoKwt+wdWG+zB07zBcUhayAeOIKjHnHOp9B+Uc4cCMWeFq16iNQXRLwCx7Y0KNyTfK9WrAQBqCExtNoFXnseXau3aFT1paqv81KJald4H05ecD+mXmJ69JjhDp6M9sjJbGGgnNEx02dv0mLBCAFsjZ5szFjHsHpN1+U2S+vqCBqF5MUa8AHsBWIVxKPoVFIvcih976MCIqSXRLGsth0WzN+VVB8XAyEqONBO7Rk/iYiAOy2psyi89rss9/o5v/Tly/FG7QFqxsAD3XmSjCw1Oz3PdU+4C1aY7rVMUp9CqPqpVeX/x7J0s6orwMz5peDLfWfqZcVpRCAfWZgI6rvCVr1bgi
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(70586007)(40460700001)(316002)(36756003)(26005)(82960400001)(956004)(70206006)(47076005)(82310400004)(186003)(4744005)(16526019)(36860700001)(5660300002)(356005)(2616005)(2906002)(6916009)(8936002)(81166007)(44832011)(6706004)(16576012)(336012)(86362001)(966005)(83380400001)(31696002)(508600001)(31686004)(4001150100001)(8676002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 08:07:03.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e1d579d0-3070-4ec6-400f-08d9d0eb865c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5358
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 08:07:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7324

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=1&day=6&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/12/cip.2021-12-23-13.00.log.html

* Action items
  1. Review / integrate kernelci patches into isar-cip-core - jan
  2. Propose tweet on KernelCI-CIP collaboration progress - alicef
  3. Clarify with KernelCI whether CIP maintainers can get accounts - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

