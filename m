Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6631C433F5
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 07:15:09 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web09.5920.1642058103240998503
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jan 2022 23:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UxLBjSD5;
 spf=pass (domain: siemens.com, ip: 40.107.21.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgPQk0bLXqPabluHqB9ZnyYMo9j45z7Vzr5iQWLFYSfAiHeDkjVAEBquKTvPwG/tSsP8/ukEvgLSvrW3sHXMciER+pTgjTi0s2Z1sJmMaordmnPbT07EM0XixV3RqFFcVrx4XnPqK2e9ivktwfYe/TvQLgxbQ6ZlV0ywVrHd19XCX3GfdVz2+ga2sNLcLtt2aQn1acw4IWS81mTiqe2Nk7wK5zA5tHGIgchS/VXyOLNgA3pvG41DsmISLda1Si+uZtLA9hK5WuLrehFKN7iurOgGZtZSxyrbglJ6yOMonU8x6JbzgavwEucrpRUX7523Ii3yn+KbXsHthrXQiLNOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SofykCA5dgR7xSNCYH/uQ/Ht+IZ2KoO4ns1Thtzq20I=;
 b=VxsiYXN4w4cdd/VjWBUEXABVEmla/wKSmiPmtNvgZ9pLwHcNPq2nQvCuObIqZoOc3Ti3ZqY1qt23yKi9yxHxOSDeTBntlGlvzChHrk+v1UdGK0W9bfne6Hsb/Wu7OysLtON3/zzfcakbkCa3M2DuBrX9kzWETIIf6SBmaj7MOLdwsfY1EuWLPsMnIjQQDeJgqImedHjCdStvJ3ppgcReQLkITSlFPo8Ml88JxrkMEY1k4ZMrw1zt+lRVR5e4RwPE03obZ39X4Eoofy51D7FS/KgaRKeQ7nJVDBDfwy/3Ahb5sTYmuM1LP+5f8u+OHoZGuUrDpmFNdwVv4ILlalSS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SofykCA5dgR7xSNCYH/uQ/Ht+IZ2KoO4ns1Thtzq20I=;
 b=UxLBjSD586n5i5HWDiVEZ+23nMe9tdRz2J4IvArVIHtGs7RezQucyfsZVu6otz8pCD8fb7rX0Ar7AuYNqPbC/7sgTKGCrRMf689KXITOisJg8kUCJwtdISJfJcKqzPPYJSf/uYZLw7ypG9W6+cKJ8ua6oB3xCKJhZB0o0vQVA4K2HAdWJzlfbTC0XOaY4hk/N0BweRVhlpSvRys0DnC5ls9u3hiKlGlf2Ljn/LN9l0ViXvQM+HIgml1QRngkiyY602K9Y6iR2NdHPSB+MN28Pk8vzFcPsRUs6s8r3KaKUgN6akV8WqXMfsNlVt6DxR6zvxKJLTbhKDL2y6g5qhUT1Q==
Received: from DU2PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:10:3b::7) by
 DBAPR10MB4042.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Thu, 13 Jan 2022 07:15:00 +0000
Received: from DB5EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::4c) by DU2PR04CA0002.outlook.office365.com
 (2603:10a6:10:3b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 07:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT016.mail.protection.outlook.com (10.152.4.255) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:14:59 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 08:14:43 +0100
Received: from [167.87.32.227] (167.87.32.227) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 08:14:43 +0100
Message-ID: <4a2e3d90-c06d-1de9-2bf8-17b6bd240321@siemens.com>
Date: Thu, 13 Jan 2022 08:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat External
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.227]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c44da7c1-ad2e-4337-b2a4-08d9d6646923
X-MS-TrafficTypeDiagnostic: DBAPR10MB4042:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB4042976682DCEFB8174F530895539@DBAPR10MB4042.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VgKMIC94TxoyUoLCmEyhJAmWlAA4dDUMDoxfuZsoU56r32t4mT2kjzH+1lfrANR98M2pzdprAGhHDbq647DMTFeaq0rygTniytmfWdGKpGWPGcMGailHD2lxJ/oh1jBK0w5RJ1nK8sBUYBGGMy1WG96BOJ+Ug+xaV0ylqNpok2S9w0eMSRwN1HN8C2lBsHluCr4Qh9ZlKgiYJIgEnsF1FllfxYETmnT94mNuq3GKfG9ocjW4zm/CDGQguXY8cV59yTZGdPTJihXk/yr71ryGa9/Bz+z7Rc3QAAOTNRy6n+5CYwANweQF2pTxV8ZKoP/+vupyY0BZlaI3RYOlcGaAbr3tFnq9AZVvZbcSo9QmWPgufN/3R1zPcXtBGcyOm3r9i0NFPFOWt58Ui9LevtqnjXyzhhHF7HdHURV2BoP/Ibn9y4t1lBgnQdB3VT0KtO8tdWMjHR1nqhqQELqF/kHNExmVAF/IRVKgLgBN/9J7c/yly8dMAPzTRUOEIT5ipNTw0QXVq6RVfZIeLfVTo/MZ5ZXe1KeSxQwMf6+/803cQeYsOKavOP8PaRZ0QLce+DtD+HDUDpxJ2hNW52QBSVltjvM/h8D0vMdJtRURV6PeFke3lCrHFp5/iZYW11sL6pdX5RIf37mOaHoG/+3FT/YbHgeQPfKKXmdZrdf2o2/yut/w5kuJthq37v8iz5egURAxM/8AsdnrKw4mSRN/XLy4QFCV8v3YNNYDYDuZ26kspi8sKAS/4AwXIXJvBoTeLCM0W+tDYHv10a/Jc7rcnIsaV6DVS/mfEsp9221BZq+wR430+WHNZF4kDkN7E96W37tTYJxt+DAVI3FKdCRnMGgeeUNyhhV9gpEAXrYFbCf3tdczmNKnokiShVCtyrbKJS3oBJR//SJx+3QyvQX0dZV5MxucEjp8Sb5FX+GIlbF7UCrfLQH/lW+MEr8edX3dfHrA
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(26005)(81166007)(8936002)(336012)(16526019)(44832011)(186003)(4744005)(83380400001)(956004)(2616005)(8676002)(82960400001)(5660300002)(47076005)(356005)(86362001)(36860700001)(31696002)(82310400004)(6706004)(70206006)(316002)(36756003)(966005)(70586007)(2906002)(31686004)(40460700001)(16576012)(6916009)(508600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:14:59.7875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c44da7c1-ad2e-4337-b2a4-08d9d6646923
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4042
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jan 2022 07:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7456

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

     irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=1&day=13&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2022/01/cip.2022-01-06-13.08.log.html

* Action items
   1. Provide v3 of kernelci patches for isar-cip-core - alicef
   2. Propose tweet on KernelCI-CIP collaboration progress - alicef
   3. Clarify with KernelCI whether CIP maintainers can get accounts - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


