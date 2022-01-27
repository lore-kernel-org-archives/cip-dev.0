Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F0C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 07:44:06 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.53])
 by mx.groups.io with SMTP id smtpd.web12.25174.1643269440141873345
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 23:44:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y/bbMw+f;
 spf=pass (domain: siemens.com, ip: 40.107.2.53,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7rFyqVX2Tkbe9C29tWW1DRne9s2SRZiAB0SQQUvYnLsZ+C3clcYKUfWS8rgrbYonj1YDCLD7WwmbjWGyPPid+zG6f9HddwWZLWlw+eCOF2QwyCQVUsxkfDiZjoT8R8VaDRYtPNmbniwd2j/dB/PAW1E5noCQjQZZG4MxJ+NbFJl92/clIuSZbNFhGmnmdm8En+8oSSGP9t70wyyVaqx3LF3e4iUIB37sQ0DJ4S5ZK7XLCqs+yv+jAluF8QFQ3WlJJ1+Ii91zxq5fdx/CdANTAwvT3yINr5J1u8q+CS56M9TEmHLY80gSmmWOIzscUd45wS+H2a7mIO/mCUUbyNM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH723s0Slh7TCCrcJ3xX+EtB8hv+gwR7tqopFAfMpsk=;
 b=RgQmyWDvSdCupo33ch9M5piwZjKqfmoTKuflfarFnHm9Y5aGEX3UBoKYKQp6QjPHxlTdc3a0d0tQq4MHlyAurJOjcDdhIlgEZHxAwqgP3BG5Y5Oa44NS3u9ZAfdMoGlNh1AXLi06by+P6XrtBY2kb5Rg4EuPElW1Qjw2uFG/XNhzRjB1kiLTRLVfBD4ysEP+2UxK5NNH5+6bAu20nSNC5ql8eKq1fxDehhae4q1flV4GWwQlv/y0ilujEcjW9jxmeFC5zy5hUVTYsb46RxO0uks390mbD/L4vV0bZ9RLjgZOOgI6BxE/IMfOb0cZ9Yzb7GzPin/EkeWz3Pl0OJsOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH723s0Slh7TCCrcJ3xX+EtB8hv+gwR7tqopFAfMpsk=;
 b=Y/bbMw+fq3YZeSNQDJ4OrFWhmz/1pEKYi2nypPkiBmFlq+0f9wU7ZrNX6xPf1aej13/4fp+1OohCGNVnN1fMkz8tYVAxXSPWRUqSP6n0qIogYx0lmb9Xtm2nyyAiJ2X4Cb5xEqmaMcbu4GXJ4fHJJZuVp5HYqK9HnvUjyqGO+jP2bSAQYmj3shZffsbkgC1U8rtI16gUO6So9JoerHBsMtb6jNt2IcxWqJEanWf/EEGoKu7CVfdCCLXpKHa1hieZq+vRQO1cyoMUyvTsDC1kZI4lLOHEhVsV5ur7SjCD94Vlu3hq302fbj5CcpJ/94F3ZcKuzMcduF2p3YsSm9J5mg==
Received: from AM6P195CA0047.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::24)
 by AS4PR10MB5271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:43:57 +0000
Received: from VE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::c2) by AM6P195CA0047.outlook.office365.com
 (2603:10a6:209:87::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT033.mail.protection.outlook.com (10.152.2.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:43:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 08:43:56 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 08:43:56 +0100
Message-ID: <b8e3378f-ccb8-0be3-fa09-0f8bdda671e9@siemens.com>
Date: Thu, 27 Jan 2022 08:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat External
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d807f234-d98e-464d-e459-08d9e168c630
X-MS-TrafficTypeDiagnostic: AS4PR10MB5271:EE_
X-Microsoft-Antispam-PRVS: 
	<AS4PR10MB52717B0FA7AEC7092B41025295219@AS4PR10MB5271.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CIuEl9XQ5isml9ppYgOHpGNq7wXMbR8CC4f4wCrMavHMEd/3CUJURGdslmxP3c9fdvInstA/L1BH9PdoWx7FGXNYkBAVxdClK5XlMrGjrvIlhjdNFUD9y5gDEHNjDLsqCiNuiURy3PAAwkmcRQ6Ots3+ECXPjOxm3T3ozrA6262hTZYsDosn/2t18JD6VBZ0xMEH1klhCFKoDSkXhDX5VUmSAGuDuQgGtzfr+gNeYM3NxiPsUnBETzDnhIgjqJwFXMU1WKMeniLIleijoLnO258/WpJGerCbOLHoS4gVFufMQ/07qxXSfZ6Qy8ONivtqcBoJtej2I3x49x1dqY21akznM0UUrzzr2O7L0OCYjLRcLJ3jyKPrpWNoRtPLUgYJv17J8tPuQ6sGtK5slWCIIzAN19VkIVINtrVxjBoZ7xzVlwL4+PV7RCdtZYeSqzfs90H/QRjGiMnQ41JzlTScv75dqNEQCkBuNWtveo9X9GkunziYVQShVv5bqueyV/fpRdgZ96M0CGcZGqHaBiRDAde6z1fkJZz7N0Y3Uqki+lilOaXbJIh1dDQAziurmO6JhbaA5yXkYNdbFBaeWcNPdb8/dycpM1sFDAjR2mNguJLspYv4ojeSdRuRrFUaSBOBe1T2Co/WEBSIXVlej1v34oQIPYCwxCwudecoIPm7xEphD/hwqN5qAsJ5oItKb/XXO/95G9zOIPXQSA3LAf9CJT1SpgvcyAxvjqWqoCAHGhPNaE5Ysq8SEhjlLRDEdJtZDG9LYOsHmzct4g25lRiDCK9ngXfDsbkZctI57ru+MybdfoUwOaGa5gXu03CLbJvHLk7rLtgcZLWHokD/Bcaufw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82960400001)(36860700001)(36756003)(5660300002)(4744005)(31686004)(2906002)(44832011)(2616005)(956004)(356005)(26005)(81166007)(47076005)(186003)(16526019)(82310400004)(86362001)(6916009)(966005)(6706004)(508600001)(8676002)(40460700003)(316002)(336012)(16576012)(83380400001)(31696002)(8936002)(70206006)(70586007)(3940600001)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:43:56.7108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d807f234-d98e-464d-e459-08d9e168c630
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 07:44:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7495

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

     irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=1&day=27&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2022/01/cip.2022-01-20-13.02.log.html

* Action items
   1. Merge kernelci support in isar-cip-core - jan
   2. Clarify with KernelCI whether CIP maintainers can get accounts - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan



