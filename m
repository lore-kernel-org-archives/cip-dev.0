Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53104C433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Mar 2022 06:32:44 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.82])
 by mx.groups.io with SMTP id smtpd.web09.8282.1646289162353866477
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Mar 2022 22:32:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xjdyk2Ud;
 spf=pass (domain: siemens.com, ip: 40.107.5.82,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXwz+x5ZcmhvoPInqFVW+l+fSlCx66nz4AL2zY6czVDTXJaxlGq/YjBPKIdif8AfeCCszK0i4j2WpU/5rC9I5zj/fNgJC4Q+5wVmxg5uBX64q5eH+sRTrdm8Wslyzo7y5hIVLHLH6nyXcfsrkPbEhpZkV4VGHO4UVDKArlIL9+mgO417wEw8Aw02l46e8MT8qEYZMEaQD6lRCe8l4N4AjIB8p2hKJ0Dz4MD6HQ8cTrqPCCMpTnLldoxYa+KOr0BoUaMUBPAW9FArxvCMfuFUSs7Lge64HXasGmmU2Gy336YSwAs/N3EbdjgRrN9sSA3aL04Hoyxc90cJ4y1HMrnwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAJVr8icUidG3ijB90XPvihuKSUquSAECXS6DJSsgVQ=;
 b=AMApdAxyIflGe1SmbpalMxqFvwERBoKP/LaIG4o2aKYZfoQ3XMrdYBKkUaHJ0XUUH0SAU9tYLma0ZppQfevwUQZAx8Ins3IUdesn2oFsn0C1VGlBjOe22bt0wh5cuXJLzoZYBavikHr7WYRu0Ji3sfa2Ani/pv+SB4HjoZb5MociKSJijRTUbGpmFuhGRba2dkznje6jjjx1wo8nMj+WfnTznA+WyNNEiEZhoupnxygVKwnE9vVOQ8Up2K0n6L6OCHMEirDPjup51DE1LN8FczN5hQ6luWBaxoQ5g8layPC+CxCYrHj0m9SsaS77rvMNbm+DU+BcxSEXRpKM0t/I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAJVr8icUidG3ijB90XPvihuKSUquSAECXS6DJSsgVQ=;
 b=Xjdyk2UdROR9eIZJrVcCorjLG8Y89ccveTBKHZ7SN/uROY8Bpry1S3cSbSTzuu2UYwzjnhHi5zUZoELtEEnVjLbnumJNyZqPcEn0oLY2N4VeGP8VY/3FXDNorcUsNOxpF4LXg9g//M6fBPIau7uswPePV2rhp97Cxzj+rfU0rhmHThTk5k/PpqH08cmWP5WHnZ10HX1xNPybcZ/DM5cTU+y2wrMyq0Bj0oQsuCWAZ1OMxsBxHcKS8Av1NY5luQv2jz5n6PSGRuVOFN16vebuD/6BZk76vH4BXmrOg8q3B1OSvVTFiDbBQDqVvgN1FSVWPSy4aKtH9yL/kw76GXoMUg==
Received: from OL1P279CA0045.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::14)
 by AM8PR10MB4258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 06:32:38 +0000
Received: from HE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::c) by OL1P279CA0045.outlook.office365.com
 (2603:10a6:e10:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 06:32:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT049.mail.protection.outlook.com (10.152.0.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 06:32:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Mar 2022 07:32:37 +0100
Received: from [139.22.140.166] (139.22.140.166) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Mar 2022 07:32:37 +0100
Message-ID: <bd7db854-103c-dd4b-d476-e7b0f6d704a8@siemens.com>
Date: Thu, 3 Mar 2022 07:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.166]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95eb5e1a-c185-47b0-3d4e-08d9fcdf9c70
X-MS-TrafficTypeDiagnostic: AM8PR10MB4258:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB4258B1C1E1B89515A154825595049@AM8PR10MB4258.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9G5S3yUNnkZMghrFigJ9AL+PhLXpeos8tjPmnmRXU5t1wRb+uzYGG+ZR9Hti+SjbkyH7ef0n5zzszA2G4AfJwi1rvus2pADqEg4ibHdk/rd7D6uC03UZIn/75TPvhzbvbyMBTRRT5VoMyuX/49Nam3EA/76RzlivG6XmqC4kI6SkJC9D+ltgAJikXG6DdvfiqTXTBUFhdqf1A3TZMWC+JV4jn/I0KbOP4yiAtaPA+mlQSj2H8lmS6vsRDOotc8YTknSHCTZBPVwGiEJoJzNr6RyhpV2bOWxYU5s8nuaiiZDR99XWv4u33RG/f7/5/hJ0Ag3UJ+mxjRwlWyUcaoW/K2LyyHTwuf2JDfK8fwgzisJsq6ArJSCdzF7jnnoRvrt75LzONouEB1/BYfldBZpe8GI6OnT+4OA/erLsMMJ9otTBGOhTdSfmamtKflC/6/uaqcW3EpNl0attfEMO484ANrIJAzloWtcsX7fQO2QpjFjWSVfiZ6HhHwTRJZDlF5bOg7A0u/OisFg4OkwTilS/LHZbVJ850FrjHb3hIzNVMHJmsnh7w8xQF3c33vWJxWj9M5xnV6CWfPghIDDT7Bl3SRUgQX3Wgpmp1vF8Ua3HDSUVQC8Hui54Lr/Av57D8CDEDYrVbhXYHbMJVQdb3aTQ26U3oZpVBwa4BiiaD44KHa9AhZj8KhKN6yHxc3jW1jk0yreRYEr4KyajYmPoB4GAwUcCRU0WG6/Vcavy2UTVDc/40MEnMHdPTJwyankuHTz2lck5/lzTc+syn9zXdHycSPuQjQyCnVzEErxOR0B96/b6q/pENxsE3w/7kanI60kuPz4oyifk4cqsZcrCS58xpre7YReY3rXjAPHoEPoYMD4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(5660300002)(47076005)(2906002)(70206006)(36860700001)(44832011)(8676002)(26005)(508600001)(2616005)(336012)(40460700003)(31686004)(186003)(956004)(82960400001)(16526019)(86362001)(966005)(16576012)(316002)(83380400001)(6916009)(36756003)(31696002)(6706004)(8936002)(4744005)(82310400004)(81166007)(356005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 06:32:38.1362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 95eb5e1a-c185-47b0-3d4e-08d9fcdf9c70
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Mar 2022 06:32:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7650

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=3&day=3&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/cip_irc_weekly_meeting/cip-cip_irc_weekly_meeting.2022-02-24-13.01.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


