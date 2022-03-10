Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A52C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 06:50:05 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.58])
 by mx.groups.io with SMTP id smtpd.web12.6942.1646895004046254938
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 22:50:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o2RABsjG;
 spf=pass (domain: siemens.com, ip: 40.107.14.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VM4yVJqkayeJgh6EzI/M6jn25zVxsK8Qa9e7omcC0IDSvxu4y6ywIjg6/cav4zmU7lscvlqg3I9XYP8XxJWdAaoVXyPx9gFEdPKkz+yD6TORV1Dk1ROISK6xMBAAZbXTppLkOoLCAoHX+ebb3apYK5oswP+EMQOMLmBmyJszjyfjV/HLWGAhwqLqZSfmUVdUhzemRQePt2BCkBqx1ij8LcHrOUL81LrdcLzdX2GWX2PjZoPGJJyTtb8Yj7WKSZYDCsE+h4rXOPao8RFkbqDeXOi7AZuhjlYZnh6+ESHDyhYTABwrMBMjqrZDF+hTzVyYH+ooTyStwF7BRpF/jfCl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sJEegvitpiTjb9mkDqFN+/f84mdUv9fRPk1lgjjP9U=;
 b=Sah1Ze2NRjPL0DdqbWrfqIREsD6bsuX7MWKBpwrK2t46h7dT7BRewR49ykn/etzvOtrXjF4gpgg9Y9lgnF1kZZ5UOaD5XsYqDrJgX6nt4d9+CjwJO5cx45bMH0NzvGvdr74Xvm1MxJUiXZ+V1XmGnR8enLFqCtvMSHjFkwEUQfrXXrPGl/IOqwNPifCQ2hcLIyiS8y01OSov3EWf51tMDqXBr0+jfcJPwXHIEbL37ozHPwRfmiI1jG1Sq9nQXD4zClChlFuH+Asm2vQiI90sxlsW2C3Gix2kaFK1APjvmkj1I+f/Z4Avn4tYj4DCMnki30Pi0MrNQsetsXxKFkdn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sJEegvitpiTjb9mkDqFN+/f84mdUv9fRPk1lgjjP9U=;
 b=o2RABsjGsz6zxvQMdtO7xC4OQUdk9IbAuZrIxdM/1C1JeQ4W5NVa3VVX120pd6K4IT7OF+UM/rmU7mgD/NLLMZ/UiLmOtfZ9yNNrzPxNtPWFL6JbBsYBfy8FQMfPuK4QmZI8U1XVbK5VJum+NVnrlxdLyn0dGsg6dL9U8LXoIrxFSlIHAMkwkwY/fN6kVdsvHF5s0c28qWr15L4enPSpTI1nT8u4G0qhnFnwUUaX9otxtOx+xbPxYBSP2iDxD+aigVeNZvT31GhE52BlIFp8g9R89k38aCEj8Q6NXj3PL48VDQGpONiEjQcW3hgeuSrFgU3nhHKxPFBy8+6UDyELbA==
Received: from SV0P279CA0050.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::19)
 by AS8PR10MB4725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:337::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 06:50:00 +0000
Received: from HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::80) by SV0P279CA0050.outlook.office365.com
 (2603:10a6:f10:13::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 06:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT032.mail.protection.outlook.com (10.152.0.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 06:49:59 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 07:49:59 +0100
Received: from [167.87.0.196] (167.87.0.196) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Mar
 2022 07:49:58 +0100
Message-ID: <f93246a9-0821-15a8-597a-f57c1cb11b5d@siemens.com>
Date: Thu, 10 Mar 2022 07:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.196]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71a84fd9-8114-4b70-ed74-08da0262322d
X-MS-TrafficTypeDiagnostic: AS8PR10MB4725:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB47257E5611026975DAF4C489950B9@AS8PR10MB4725.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s3F+Rj7xAydAE3577tATkB4U3oH4yWB27Ts788RhzfmCaEGKMaxVVr5BaA20ID7bhFRgylNnyn8ff15unj0xfvodtzSDOjtibTvzvDxdHZiIhGTjVL8T/O3VIaA3Xd/pTZU6PstPfmLfPftM/ARrFZr6+ZrkWk6A7CHU6oaieoMnekMWg1AfaRmAOZIBs3gWc3lfAJ/9gZ15bf7DphjGjAFxwjcBZLFW0YBI/WXbIrWqKmROFikoET+SkF6DoQ+rNsFGMgSydQ6DFgH0NmUNbhRerSBseIEzMB/bMXK241v8TaUERxVjCwgAGK4IizZwV3L5+aC/ia/1jb/r7xY2WERbYr+gf3WXIlW7DD5IwDi+NIbqePp7qqjZUM1P7RD861zmUDiD+Hmkmt2Nnm0iN8PGeGDMtnAFSib61KyWfc/R+gyuPpZQLn8LI6YJk32h73hWXeF5Bq0CRfI5EU4JnmwxIZozoxpdYE0nq+hYaBa++sqRN1LIZl3wxSH+D3WsiWDlHQCse+xSgUImIwoUIWxnS+noawyrfvsthMet8V2BJ7ofjZ0xrqrkC7pXufs+1NseU3QcVN20kVGi97CZLqYoGMzCcE1+1upgEp7pPRBs9LuQzJqkOmTuXYvzI2G2UE5oHbTgC/9wIT/fzO1uCaD2adKFxTFuKayy0SHkm/V744ofh4wL9B9uJZnxgAyqVSexo4uER7bndhy62gufm2cNrGyOiRhIAoZIyF15vwWg/147eVp7/w5jP4Gdm1ClR8nm8iHYlwEzXZ1zpR4oP0I344isRFSLDPUyPpAi4IeOjW7lt2V9oRcjFhHjpXuByfeKpQ2kPh5sFZuZMp1xZNpchaGY6CmNa9igzvC+Xgo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(47076005)(86362001)(508600001)(82310400004)(956004)(186003)(966005)(36860700001)(16526019)(356005)(82960400001)(2616005)(83380400001)(81166007)(336012)(31696002)(8936002)(5660300002)(31686004)(8676002)(70586007)(70206006)(2906002)(36756003)(4744005)(44832011)(6916009)(6706004)(40460700003)(316002)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:49:59.7330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 71a84fd9-8114-4b70-ed74-08da0262322d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4725
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 06:50:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7687

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=3&day=10&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip-cip_irc_weekly_meeting.2022-03-03-13.02.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Add 4.9-stable-rc to testing - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

