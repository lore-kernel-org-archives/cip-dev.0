Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1735C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 07:40:41 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web10.7218.1639640440233257813
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 23:40:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g6lYN9h+;
 spf=pass (domain: siemens.com, ip: 40.107.8.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Odl0hI/svQkJKqqsBmRKNRlxJ/pOo9PBAQhvi2MBSLtdzli9Z5FR91VmEPVamGkGAZQWeJ3M/UGYd/DgplUEZUIqksj4SnKGGWNga0VM2Hnxg1djI6MQPcS4V2LgBdCUMml04Z+V32WfrRdlZnqn0gn3UxaGbzWUYLWxT5E0IkN27hjYEHbxhq+aDah7kLO/yw9HI2OZSWLomjc6YDj7DSpR/cyre62hK1U9F2duFIuX1TX9dxq/5+8OUBzuA3spCdP8+T2tJ6d31rB9RMOYP9VHw8sU6t54HEe7PYkkiraA/oaK0/OLqd2VhtX05HPHbDU7TE9yirsb+AiDxvjGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gcv2qV5qFlGgu9aZmYoIk7TUCvU+LDEht/cUnItbpGk=;
 b=GhNL6g1qyVsvOnHEumqGduytR7jpLSi6z6PUL49G6uYsP0P/SKhXeQGrl/oFLbgJOY3K6OT0RJwb3uKOtS91t1B/1kyMTx4V3SGBpqBBfrQQYOuO9EzU2vxuKDjJnC815EuhgqR81BCu/Erlq5yTYmfr8gmAb5w3wIFhLhymNX7ppeNe4ykWBGTMsmYxyMlzw92GlyX71t9vzHgNe9s9tpXMI0+L+KTATTVGLOv8I1fBbEkHcqYekP2T5ZrbaORwKcPjqepI7ZiM2R+Vj3JmQo9T69Ay5pH1jOQAxd2YWSItm08iwLuObw5D2YGZeB+xn9neLv65UOi71g/l28VEOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gcv2qV5qFlGgu9aZmYoIk7TUCvU+LDEht/cUnItbpGk=;
 b=g6lYN9h+ZsnvRzxuUYWtZUOxbWiB9yiKo4mnka7NhZq9qit8r0zrfjVvysLRfC+pc6jgQz+CY6I0KPBm6oimGB6xZXIlWaGGTAEZ+uQkqiRYV9CfGgGhAWSs9J/rBVez1u5Tn+2BJddY0XSBSF65shplWRgdbc1qpqt0gua03bXS1ULa8f0Nq7NUr2QgHmpBe9EjFHBoqIMcgQcwC6b9IlwtDDHOiEpukZJ5ufRJRvTAzrwm3jLua17lVNpueexLGE/PteVU76XGmkxZgKe6GaboE5ULrxErLNRoNqWGu2dWQCxopISnp9tbg/PT+fBwxyTzlIuWKp8KjmP5l8Fx8w==
Received: from SV0P279CA0069.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::20)
 by AM9PR10MB4596.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 07:40:37 +0000
Received: from HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::71) by SV0P279CA0069.outlook.office365.com
 (2603:10a6:f10:14::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Thu, 16 Dec 2021 07:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT005.mail.protection.outlook.com (10.152.1.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 07:40:36 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 08:40:36 +0100
Received: from [139.22.140.88] (139.22.140.88) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 08:40:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <af9221a1-1821-7ba1-a337-8220cf9b29d8@siemens.com>
Date: Thu, 16 Dec 2021 08:40:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.88]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69036b90-7360-4cc9-690a-08d9c06759b7
X-MS-TrafficTypeDiagnostic: AM9PR10MB4596:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB45969BAE56592115A30C431F95779@AM9PR10MB4596.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tCYo/9Ib09ZxQ46MGjQIOlK4mvDqQ7vguN+H35aFxmJMwB+cCvvh7+YvaDEYNRWS6mQlVmMjkniLMJyuygXSyz417zyEe+ZFUmm3OHP3xL4341YQY7ZT/2vO2tv+w72sGBw9leKei1mKDj/CGvwS+hL564ViZFyRGphlUlmNwwBnPHR8jPZwmZ/F+QtHzsdkirmUcR0pdsBJ6s5VoeMCX3aZC8aC00tmhJPbolvlnQE2QW3Z6+Huoa+wxSEJk9sDTzWeY0z/Irl7x0V/R6F48k4FbFzm4PabSEMbwmmyN/DFZXDVnLq7v78nMU8mD3yjJBPD1MTasVIygOCLS1894PBpP9yO5fIm+IWZukYfwJvCUqGRy5Bn76r6KRN//SUIY2aO28sIEMzSnEVAvwQfUEESBjOT+k9/TcCQhzPQtvRUnH0a9rBoxKJATiCrle2JJdyndDyFAWIQa/sGkdUG6/kUTuMBinlpCmCxeVEdmbAleiAXFrh4o+fOyEeiHwdzhE7Ja5tU5xidfU57qczcV3K1Pj9X5pnzhyz4oFafNUjvY4gP2tAJQOw48E1c+OP3F7jJEemgZOmZXYGrbBY+d2ID6ePMWaLp85c7NKX6kmmvH70mpbR61F1lF4pzs/GHChcjRHSyGAj3B1VC01mqqPho+tgiAH2VlIkuIhC1fFPjUjSDXOMjb9dwmcVcIQGxrE01v26cgFbAUBC0kz1FdnRmmF5stI3CRn7S6dCIbUSngHegn7Xh/kDBw7raRBxtuhdULZfDf6cnf2pKXKgpPmQQP5vzkvLq7yq4RiI71z87lVPex6fMjz8F0xdbyONyxKluDcP1CCtBY5bLfiEjTV5ttbABcD/WXvmxOUEHdm1gjQEheNQntd4eCAluJFOsIH3KbVPFTk9PfNkRUSL4Rl1UwcvQPc7ivIqUrPbeimL/AxVrJNRVRNkmRKeuT95R
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(5660300002)(2906002)(8676002)(44832011)(31696002)(4744005)(31686004)(26005)(2616005)(8936002)(6706004)(6916009)(47076005)(36756003)(82960400001)(956004)(81166007)(83380400001)(966005)(36860700001)(16576012)(16526019)(186003)(356005)(40460700001)(82310400004)(316002)(70586007)(86362001)(70206006)(508600001)(336012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:40:36.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 69036b90-7360-4cc9-690a-08d9c06759b7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4596
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 07:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7116

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=12&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/12/cip.2021-12-09-13.01.log.html

* Action item
  1. Combine root filesystem with kselftest binary (finishing) - alicef
  2. Propose tweet on KernelCI-CIP collaboration progress - alicef
  3. Clarify with KernelCI whether CIP maintainers can get accounts - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


