Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30554C433EF
	for <webhook@archiver.kernel.org>; Thu, 28 Apr 2022 07:59:35 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web09.7208.1651132766111348705
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 00:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d6YVMBzF;
 spf=pass (domain: siemens.com, ip: 40.107.20.69,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo8cHdFACht71Rb7dUZsLzPoBXncnPigpiEBhIr3gXbZiJwPtCLT8aRRmUMc0JIvDh0SaA5PdfROiOSCmM/KApAo8ypgO6har7LdHqJRNn5WNe7IzJtTumXZljgF67mToNNSEREYTF8Xtn4Bs7fZ4B9TmByDrzmA8GTkGXRRAJtxT9/AVhyPuoeh7iUwswZ7b8TBEQUc1eWmmvAoYGMR/g8OO7TJtz7PQep6BbysS46fZOZejIel1zC2RvpJFvDAWhRp/7SoNZipHOM2fWZK8nluPrQrPgERkrvWgruKvfRMUkBDOLPBKI5WwiMZw3GqqFSNodwNJ7Nu+wlD1g4PdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWzEkQFxkPjkvRa15OVqSXthjxHYnRIskVMJHWLGHPA=;
 b=bhevU52vtC8S2ebSk7NasVt+PHVDbPLqZpIcT6kK9K9nwhh0WqiAxlvU1EeYqmt1BUAaUtpwcKBL9afS6l/yD9Oii/Fil4PZS1Et2QTtRr3Yw/s1aWLEFz7i0V3RrQlNh7VfFbnQIj0P2oJLB0q4NqrxlmjGBVFzlQ/3o7R01GEP8G1lNmQUpsoD59awh4zFAC8cG5Tq5tvS6Pc7FLzW8OuWWPyxLBeOQCWd/RZhyVuBHRH9eXngRFOq776Vj4u8oNeoCjFOljGjIEtGyP9WBKeb53VupPpFFHB1LOGCg+kolIitmVdQQjuZU2iP6IaZ5BHeBIw0AlxfwLEoXeM4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWzEkQFxkPjkvRa15OVqSXthjxHYnRIskVMJHWLGHPA=;
 b=d6YVMBzFig+q6Ss+vXGSy/0WEJhj8Sbx63a6oNLmx0YNtstIT318cGShYinw4P5lcreYUfhF9DAEipT9G25VEd9IpGpQse7fOxKOCiEZCfQzzyrbC7rxXov/QD2faB/bKb0j0yeqf2AyAFplXwRdsKIcJJBKPKS6OapoG5vHd2zB9qsygOwpCaBG5NmkhLybrDnQfVWmr46J4ZEo67sKAl6Qa8EsvFxNUqobOaOkIZVBc2IPkZPVCvvJn49xx2k0mwGZWc8iLK5ek5l08UHihSNqVOdD/eQU0+vsuIeentUDS3rKPQR+Kihg9GJ+KJkdCRBrZSXSe8OUkmx3/60eEQ==
Received: from AM5PR1001CA0036.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::49)
 by VE1PR10MB3456.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 07:59:22 +0000
Received: from HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::b) by AM5PR1001CA0036.outlook.office365.com
 (2603:10a6:206:2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 07:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT078.mail.protection.outlook.com (10.152.0.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 07:59:21 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:59:21 +0200
Received: from [139.22.138.235] (139.22.138.235) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:59:17 +0200
Message-ID: <a3d85ff6-63ba-438f-9a0f-13a184a895e5@siemens.com>
Date: Thu, 28 Apr 2022 09:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.235]
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
 33ED5A23487D1D3C9596391275ECE6F2CAC59927AFFB332A89A23AF2C0049C6D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f420e6d-447b-468c-6a12-08da28ed0125
X-MS-TrafficTypeDiagnostic: VE1PR10MB3456:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB34569173A3653ED6D4D0420795FD9@VE1PR10MB3456.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pe0L9xUthW+qYdg6lI+mlJQPj+gJStWTSm8m4pe0RPD/HaQYzZiQ5n048IUp/BPkCaeRwfqu43N+3r2LK6aErMq1BVL4Rw5u2sACV7wG71MQF3HQqLVaMWKfDHJp9qd3UCxhvxOkGrnHw/VeAT45j/0tPfW/c3i5d9XFA78WU0UowLlEdGViCMqnEdGtLnJl+Yfytf+tSSOR/Airi0CWLL/5Ztz+8S5KaiWryInjbmgSlI+HGGSEoRQte3yzl87UTfFyRppNpQXyofQFr3Aa+4RgtobXQi49x8vxRJ6PmWY9Kq5Mdc9/d3XgHhONkZrNPA+6xHQv+9ZveGS6t2fUj1wT80lkxkZncBuYNriZEuxJ73nblW/C3kRag9d4ExZ4K3AABELCNPWh+R0HRa0wAh2eO7LglyBR55dx1oPx7bEpyKUg2lCsvst8rB8oDAQJ0ZUDcl73tAPUJg0OSg7UM2zwDVzIn8pdSE/ortuFzHWoiSVE6F8bpu6sWLJBf92x8QW4zts5JsUyyvf7+Jw+0oCX6n7/8RT87l1SsKy9TGlXGGNHAHwpskJ9qPXv6Zhc/HtWL05d5oVKsF7NC5hcn9/s/WVncwpM8s0QD9/L16BCkM6ebZPewncqk13XgZ6BonJa+s49ylNyQfHaBCjZP8ssrD//wo6mPr/mqHfOkNB5PTLhbgOuKkPThwiUTysxBCxkgiwLZtQ0h3KabAMsKegRE/ktRvg7rMUsIxosTlGci0zKD1OfcTp6W7A4zQzTtQ+Rbs8n93eBJNJIxqMItf8VOT/Xwqbw0nsuOtcf7/94Ez+LJcSJMRMZLxNzOnOkVUsn61Hrums9E+h6UCvFj84+c3y7Rwb+wjKY3AqSSvPGBbXTJXgJXkvp+TmTjmRB9On9h//QgUlegiTJpp9Ppg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(31696002)(82310400005)(31686004)(36860700001)(6916009)(81166007)(8676002)(5660300002)(86362001)(966005)(2906002)(36756003)(83380400001)(2616005)(956004)(26005)(336012)(47076005)(16526019)(186003)(316002)(6706004)(16576012)(4744005)(44832011)(70206006)(508600001)(70586007)(8936002)(82960400001)(40460700003)(356005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 07:59:21.7154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7f420e6d-447b-468c-6a12-08da28ed0125
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT078.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3456
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Apr 2022 07:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8224

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=28&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/04/cip.2022-04-21-12.01.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB
  - irc bot consolidation

Jan

