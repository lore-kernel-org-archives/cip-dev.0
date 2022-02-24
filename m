Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64769C433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Feb 2022 08:40:02 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.53])
 by mx.groups.io with SMTP id smtpd.web08.8010.1645692001285050640
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Feb 2022 00:40:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kSKzHMCa;
 spf=pass (domain: siemens.com, ip: 40.107.15.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HF7y6P5qzqWggdEkSe6Kw0cP4wkIAElEl5Zd6WE5suaKMMD0yNj+76VhTflxSz324fQxCyajLpqpWbvATCcg4aBrC7EIE9hU85UCeaxmrGiPvGQhnGwllx3GOkIsibnUmjGg0p/SnkODagCOAr6Nw1loMfUyI1axdBYaOjRnt3mJbPo3fZNwfN8v4Y0blQKZVwhkaX1Is0RROkka/L/l0PM5wtM5TNljSGZug0NH5+dWyWc8I9qadcYKDI46ko3pPYoeDs5AekkXd+NAvNBD8nk3J9rSMDxNpwW1bGb7NESVHZvsap0OTxFo7BgyKWSyxZC2Rab+WWssUIIz6EgJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKYF8HMCWSgv/URcTDRKh/uoOqFE1ujIhiVN4sgzm+c=;
 b=P4PABvnBh1GemBY5ksZGn4S8JZ7ChNQyK5/Er2/DppJHffvafd/znJkvqLbQ/a5TKEnz+pPZh7qsrbB3tTw1WKzz9emmASa956NYtji2Eh0GbQ67ohXkEQnr4hIs/gzwXrB2OEKPF8uXuwtK0Ewm8jMnM0Q+EEaJvydagSdfAr7qN4h3xFfX7wsMJ3w+nVUnMnzW3pWQfCa3y6N5qZrIyqYHLUaVFG6t9v0sS4CiEosNnXGMFESavAJQugTMApq5JXdJoO0g4f+Sah470yj0K0N1Zfb5snnebQIACyNaBLc1Ezuh2+5g/p9JA+4KeDNX5t3M8oaNdQC94A7Kwq/0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKYF8HMCWSgv/URcTDRKh/uoOqFE1ujIhiVN4sgzm+c=;
 b=kSKzHMCa7fPe8ruCUC+s87ZQHKWAEO3waEVvv4owEiRWE3dAXc+UWMDckS/Zb6EUok2s+hRR/+NY7dVHRBXd6Z7DYNCJC2q5HcqZ3Wx6uepgkl1UhL+SKpb9X4Y+gAHGm/2GwE4F4TBOZZeZHAEjIs62Srnedb+bCULy8yZdui3G56wv+xfFpupBL3v8Zpq3Xumu0R+NG39WdlEBJdkx0t7OxeTrA6guA3IR9JAyTltAxSqF0q4UfxPKlUFaMDscH7Kp/sIOYXmIU8NSkHTGlO4TP7vdSJAqDmuDaAfQIngzq0SYOa1JxKn6SizAvgNWWfSwNxazZtF1v/xsj6dJZw==
Received: from AM6PR10CA0094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::35)
 by AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Thu, 24 Feb
 2022 08:39:57 +0000
Received: from VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::ac) by AM6PR10CA0094.outlook.office365.com
 (2603:10a6:209:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Thu, 24 Feb 2022 08:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT054.mail.protection.outlook.com (10.152.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 08:39:57 +0000
Received: from DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 24 Feb 2022 09:39:56 +0100
Received: from [167.87.72.233] (167.87.72.233) by
 DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 24 Feb 2022 09:39:56 +0100
Message-ID: <850377f6-0497-8961-4101-9e5f31d47fde@siemens.com>
Date: Thu, 24 Feb 2022 09:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.233]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A1A.ad011.siemens.net (139.25.226.107)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a2e5012-cb87-4b18-3d6f-08d9f7713cb2
X-MS-TrafficTypeDiagnostic: AM0PR10MB3571:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3571B948C00DA6C6CE9A74A4953D9@AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0pM7iR4/dQc8F1NcV1m4NkKhlm5+HM54skFfCVOcMtMQxpe+Nn3KzGTwBL0tgsWDtVRFL7/IdkVeKJNGA/e8ZBOAW+n28uS2FS7QAjtJLFiolnMN0oaYwAu7H21RjrglyMFOJzi0+Ts/KLkztiPL4QgZQsWj8zCM9i+5abgTKvsyzBX9uKyRFF51zz3k720+DAtQofcz9gA/QLCAbNhagbsWz85xZR2EMY1kYMKMYmJcTNNNvMvu+N0P+OkSf9WLLZpZK+3IB8M84x3ryrzKTB58A0iNgQ3JX9V77eUZqanwn6tR5FnoWVCJ5f4spTWb/tWKg+PqmPD/afyO0I8oaKRvrFmcN16b3uvVctbzm4py38nF7Z/vdZSF62JymWl/g9xOF+Cewp3iErUa9LZ8WXYxLtdxmOW+BMXXSvWYJBJUIuvE8PA78oZxifcuVL9ZqJSGrkkOKNd444OpaTESz37DhvfBbkgYwzaXpQNwMmDYSTLdIaseaeomSqsbkXcdpTBlL8hZnTZ6rR5Qtb3A8vtrb9A34WFt7QZ5HjQxkk4cR+W7MxcBXWte5dY9l2Sk32wgXcMPXzkshSc7WNhBMIq1pozN/SD0CgVg2ST0dydVqCDxwz/xNjPmtL/Rb/xvTR4Q558ajqngIpvNqeGm/92kSKx6uadJvENaTxNlxZEkgzGqa+2wsVRTPGsvQQh+qGdLnLwSkTc38Waai2VsGoE+hgAn4olqJ0LlGwFN2jwWMjdfgqfCNQvsMIKWxp3l47hFxUvUGV/BuFUDe+W6y4Cc5EcalK/v7ZZvTYk9DRgbKLr9VnLUf8M6hF1fqS8EXWN6WdrYZL+vZJ2XhPTXF+JnuXzVHAlSvsKx8S2q+6E=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(16576012)(36860700001)(4744005)(2906002)(36756003)(31686004)(83380400001)(8676002)(5660300002)(6706004)(6916009)(44832011)(70206006)(70586007)(8936002)(31696002)(336012)(82310400004)(956004)(2616005)(47076005)(966005)(40460700003)(498600001)(16526019)(26005)(186003)(81166007)(82960400001)(356005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:39:57.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3a2e5012-cb87-4b18-3d6f-08d9f7713cb2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Feb 2022 08:40:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7640

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=2&day=24&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes (back to the old bot, the new one still has problems):
https://irclogs.baserock.org/meetings/cip/2022/02/cip.2022-02-17-13.04.log.html

* Action items
  1. Try out KernelCI branches for CIP maintainers - pavel & iwamatsu
  2. Send CIP follow-up on 4.4 discontinuation notice - pavel
  3. Draft press announcement about 5.10 release and 4.4 self-maintenance - jan
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

