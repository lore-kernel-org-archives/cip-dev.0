Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60806C433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 07:49:41 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.55])
 by mx.groups.io with SMTP id smtpd.web09.4815.1645084179408787984
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 23:49:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j5sF47Oz;
 spf=pass (domain: siemens.com, ip: 40.107.3.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTtTI8c18R+DmEzoTepZ8nayI9uWZMPp03Xq5LBINc36hLmsehbnLWa593VJ8pfZ0PsOeXP1t3OBMJhthLAF4EG/24kIWCeS7TJa7s4CwFUSypQpkli2cjFYmmCOa5lD0jSdYhmoOnhX6iPW5j2Z/cH7J1JIYenFy0hjBXv2UYfVYUZ+0UOZDNmFStjFWUZCPfmwJRE2Cn/VIBi/1OmYf/LoVdmdo5tzelLizu+q2naPtfkk9ay/AIjvhCt/JFWyArGmKiE4+6jxzm7uMjbE2K+FM3rfWNf+wuqGBujUXWrHHkT2zXOARhYQ5Q6MRkaLSUInMZ7yCqyWabJkMXwJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdO0nqPt7T53mIhDofaGTebBzE0RmevoyeAzLV+7jB4=;
 b=jhGMkcOAu8I9irfC6zdp3uOqLyjFSp52SAPq2DMPmTjoy1y+tZyikhtDGV6JNwdB2m/ZeOYzUsBu4/Zal2T+1AUXeZh8e8Lllvx6GMtQeZI1bxZZUr6GsRa2w/Xreu8Z4wuyBFO5Dh7cQ5LWpaHXbOd+/jteut1c48zwF9rVZhuh50W9NayqPHPFDyDt6OcniKJ8Tl48MRdu5Kl3Mrr2RbjoakAVwPrpfGIWLV6j4zo7zEY9TmdgFlZPn/cqe7zaLgtTSH7IwJhcnf43n1qCf/mrD/Vkw2SSitYldBsTFmPw1YQ1pUkNX3IfBPqLIiZsOhYgn5w7z+r6giKCFvsjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdO0nqPt7T53mIhDofaGTebBzE0RmevoyeAzLV+7jB4=;
 b=j5sF47Oz3q5N/jFGFRUpnW7wyJMee1FtgTIbTLKuCccPKrhGcswyGGmxyHwJETyeM+Dl0LVCbuoaTkml+345MFmOzIOUCGTOwFyl/xx4+WmpEptbGqJJHKci2nOTco0Bj/raPU6aOMRFnLe+Cg7BNaXfAy8XhSMKPUfzVakliWOm+nAmqlMBq39jAV3WuAWRovDFT9HlK0xg77SIgV7Jx/aIH0AxqkvKbpBgC/if+y7S/090zL2JA7H+IoH9M8ypseMlb8mFNQ6mW63U2/xgniH1aSg7D8MxYdlbEm2hKvVKEwKVv8JL6KcFWMzwREYtgBAszzxUpmckSfG+FTjAeA==
Received: from AS8P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::22)
 by VE1PR10MB3823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 07:49:36 +0000
Received: from HE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::99) by AS8P250CA0017.outlook.office365.com
 (2603:10a6:20b:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18 via Frontend
 Transport; Thu, 17 Feb 2022 07:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT030.mail.protection.outlook.com (10.152.0.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 07:49:35 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 08:49:35 +0100
Received: from [139.22.138.23] (139.22.138.23) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 08:49:34 +0100
Message-ID: <9e112734-7a94-b674-6bea-d1b85f9ac677@siemens.com>
Date: Thu, 17 Feb 2022 08:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff43efdf-bb24-4f33-5020-08d9f1ea0aea
X-MS-TrafficTypeDiagnostic: VE1PR10MB3823:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB3823CBE6974EBE07684C883895369@VE1PR10MB3823.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SKUlzyILTtxpOsxNwDqHLepgdsHNYapwQ8i7HMFtPcG1K+fUPToCZ3aG3et85d4G/gELGE5c98pKxp+KSLp5C6hmSeBpWf5Vrj7YXIFLqSx/QE+K7yk7v0NCUD5ZayaHdYOcIIu0CknsjYI7HDGjSVjaepiOw+qDc+QUz/XmkIQBDteoHxn0p3JnAetxcbzDKF1GpbV0JHoKEkzhV8cl5Q08OC4yKXqdml0HG3xHe1Xm8GcqGtbzksJiuNrTpycR5L1V8Fo1QVdeJAzqRK1v28zIZu/ZW4Ttza7PAIGnpqGRj82d+f3L1IzV57BPAxchygYKQztdgby8dVP6uylzmlYlBODb8e/5U3XpVyS4ENSrIaRiscsZd+MBcvUOzBYPgejUoXJrTdSEIaQdyP0U1NYZUzI8VsXXRwz/6BU/xf1CxFsgDxqVVxxMZM5zOLiuOaBiRUJtclYYDsZbka4kVZIKhJGk5SIWV7SuyaYJEihzEpLAIjgr097SvThNT7Dg7MAVAi+SYEnJ31jotO1MEMucRgYJ6xYC7+PQlbdodbEoIzSGICxQtLznqT7y9h2eGnsmBiaVR+Gfx2LsujdhHcORJPByWJtd/2IynLsuC1WQ3oSIEPZGpt6ulb7hgwS/u1/ou5xfI3WhTxZZtTRDGqhQOoWnhI5Xwh/rZF0dpzq6uT09KJGcM+DNVx6OlJnuJNWOkyi5E4a0JeiwUwlel8yCJ8meL36uZ3ff7akUWnjEYPwoQNnVdz93oT+ocUYm+IWJd12WRRFL9X8rzbbz7VKlmwbbFMrcwkUiUM407qmBdsuCuIWVQQjMerpfBWK+
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(2906002)(6916009)(36860700001)(4744005)(36756003)(70206006)(44832011)(966005)(8676002)(86362001)(5660300002)(31696002)(47076005)(82960400001)(83380400001)(31686004)(70586007)(16576012)(16526019)(82310400004)(40460700003)(336012)(2616005)(186003)(26005)(508600001)(316002)(6706004)(7636003)(356005)(7596003)(956004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 07:49:35.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ff43efdf-bb24-4f33-5020-08d9f1ea0aea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3823
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Feb 2022 07:49:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7629

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=2&day=17&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes (NOTE the new URL!):
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/02/cip.2022-02-10-13.01.log.html

* Action items
  1. Try out KernelCI branches for CIP maintainers - pavel & iwamatsu
  2. Send CIP follow-up on 4.4 discontinuation notice - pavel
  3. Draft press announcement about 5.10 release and 4.4 self-maintenance - jan
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


