Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A1CC433F5
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 06:11:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web10.1108.1652335859233273243
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 May 2022 23:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rABq8mku;
 spf=pass (domain: siemens.com, ip: 40.107.20.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/fgpm8hel93detbjvF9A4nE1+oW+SNemXy7n1ljKyrn3XoWeUS14TPHoa6hO5OUcnjHZADd6djAULhwUVHIdNHMBCYgFoMQZj2NqaPGCORTrp9vdAEXvsGFp7WQbYHBmap/9hfb9Kx0DRupR7Y59aoJE22QBMFfy1Dr0LLyPLSjDtx9SzigIM9FgHW3Q6BZiE8TcqE5oIZkR1WgUR37pEt37Yj58u4sWwUEtdAb2prPaQEdvlbzawr5eLw7aqRzXJZXwe7pM981TbWIQkHtkzOtsmoNZoTePLZ+AOlH6t9slrkSEc2EA0wRERVyDcmXi1hFJzUoF4G3MuPqoQ/4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+setBjyJkUfbXHKONrej6eeaJIeXshFV+OvM0GhQ5I=;
 b=I7aJWKbu2OAPcbAeVtZSwshf7tc4RB30mD8BZkSgSowuHcSMQpxnaZB0vYpT/T5SnzhbC9HYGIdK33u7apNjdo9a6AwFSCZtTs2O79v5G8iTCAiRpXKfyrw2ci9hzYA19/QlPfN2LdH9we4Db908L+2LSqycKilKi/kLSQIbgocs1+dVPkaL2XLGbpVlMNuIRxhWJX4hqBotaZV9zqfWArcnXuX3a0yYUqwi50cL3m6yG3VOStumou9tf9HSMl3sBMbklrlvc4IkLBxK0s1Heyre0LYzOM1nzSe/CB8Y2jLsfTqX5mIUrLy1+sIgTr6ddIy7dwz3y7ap+Co86Y50Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+setBjyJkUfbXHKONrej6eeaJIeXshFV+OvM0GhQ5I=;
 b=rABq8mku4ArCDI/e96ZkxXq6DOuV99rOTb/igZcrSSVoRSrFWn6goohvrjlYTK4SyMf3zodVikelvdyDIz4c35nX3rqSDpfBR/hymPJMaqiw4pLXW2RcrRQdX/IevMAuDgvtqjwO+5tMlIIVEvSa2lo5QHC/psWJ2XHe9ARq50uXqom6340C7uxEES5lfdmEmgcoJdMJrzErTuY8g63A70liCSE5swx/Q2axHKK0OzoKNJfimqBqGTfoSiVKhptz8a3t08BShF8p4zoy0Nau9XTs7DFDzQ3D2lbZkB+JAmeW7kR3154Y+SYVs5FbDs17aEOlgDl4DylxqsA/anzvJA==
Received: from AS9PR06CA0066.eurprd06.prod.outlook.com (2603:10a6:20b:464::11)
 by DB8PR10MB3593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 06:10:56 +0000
Received: from VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::9) by AS9PR06CA0066.outlook.office365.com
 (2603:10a6:20b:464::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 06:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT036.mail.protection.outlook.com (10.152.3.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 06:10:55 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 08:10:54 +0200
Received: from [167.87.0.83] (167.87.0.83) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 08:10:53 +0200
Message-ID: <3ce4350a-d5a9-0d46-56c0-efcc76d53ed2@siemens.com>
Date: Thu, 12 May 2022 08:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.83]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.977900-8.000000
X-TMASE-MatchedRID: RfRf601lRZFUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVlhs8uimgHNCgj9S01KNC/gKHc7YsBPi4pGTpe1iiCJq71zr0FZRMbCWlioo2ZbGwdmzc
	dRxL+xwKrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.977900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 520763D4134866D8781A91028D1E5C54300785DA919A4D79039AB9A4481A7CE32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d340d1b-57f5-4d74-5acf-08da33de2cb3
X-MS-TrafficTypeDiagnostic: DB8PR10MB3593:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB35930805611752D58232F20995CB9@DB8PR10MB3593.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	44x+eegoYkwVO/0mPEJFUM2TZRtYctWrYzmk712A8PrO5LcwUB5dGB+MixVfVxEnF6X8z5SaVRFNT6L4AII2txjz/QlYf+AnFFUSRuJB8fV8szN90agdOOQ6jTHK1fcD3FbT9fibwnLEfBqjdAAz9xWG+STdTbpOEupirUOhaHBGPWsnAM5Vo1qTFyPqeA+gtvF6J4T0oh6PDyGBDsTsaFBoCbf7S+rdmKtzMaKyTeB9qIvFVEiPJCqjmgiFpxeyO6WxuNjHtAR9j9hOVur5HCWn4hdB08UKGY+xd7dg7NkcsPvf3RzNfy6vH43n+VzXeEqE4BAkWQvRKvJp/rQdmlEs3GZUGiGDgOZ9GLyhuieYOz9zPo4vgaPfeXXOIKk/BQeAJjqrXz11dVOOnQ4of9WjuN7EDwzkc8hYwGtam/BU76dbQhgDgaeYhf147COtWvdWiJN8dQK79jLExptGdz0LgtBST0ZIUzjmNzMZnyXHDxwRs7y5VgJb/RSZGnUaqCdm5fm7I0kimcZJq8qQ0tyOexLkST5br1X6sf0d/umHuA5Se8rienlWDRVHlqOorwKtgLD95JmPE6hYGeBzq1DxjRWY51+q9x8/wppOZa72d+bkGI9G8GWgCEqvQXkM/afvau/4B/FQXF3480FaQAg8sOf0bbapkrzRtwI3wd1zw2YBsLAluKz3v+04t3038myD0xri98nMTgZ0F0voS8hW0+7AJT/ZVQKS+zycZyEOEdOH3qp6wMCQpeqYNoV76PbXP5FT63OW7D3BOWyBm9jOHvDdGyOvCeY4RNUkhIcEAHJjwaZcDw0GE/GLwNSTJAe9fU0iS9tFFKYmcXRjKPt8NBu48SBONw5Y6nK1+us=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(82310400005)(36756003)(70206006)(8936002)(5660300002)(2616005)(956004)(8676002)(6706004)(316002)(6916009)(44832011)(4744005)(2906002)(508600001)(31686004)(966005)(81166007)(82960400001)(356005)(31696002)(36860700001)(86362001)(26005)(186003)(16526019)(83380400001)(336012)(40460700003)(47076005)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 06:10:55.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1d340d1b-57f5-4d74-5acf-08da33de2cb3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3593
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 May 2022 06:11:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8324

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=5&day=12&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/05/cip.2022-05-05-12.01.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Document CIP kernel release cadence in wiki
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


