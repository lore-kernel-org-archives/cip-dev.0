Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C7C433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Mar 2022 07:36:56 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.71])
 by mx.groups.io with SMTP id smtpd.web12.7508.1647502614434672811
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Mar 2022 00:36:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pQ5kHTGW;
 spf=pass (domain: siemens.com, ip: 40.107.15.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAuDSbrF4+J3yWnWHdYVdfwVDFN5IgtidVj0UevHWdUzNiWAu+c+TR5njpGTaKWXXB0guRVvyXTldVmCIVGwOATFli2KJFhVDmvtRi6qdx+0xcaGFdbtRAAySnhZ02MQ7nG/Kt5uxtetL1FVMUy8+nBn0VjmTcwDLjLaeVmlrIJ+FZWM4aGpySKwivUzb8qFZ6E53FZJeXMV8i3M9eIO0Fq7ag5tjtS6CGDEI+PfzqEBjGwZjkxD4Xr5xjo/wCqPA8Rm5b45ZEWhaZyhL1217sAFsqhgS7hKQE9lLppwWnSJeE+ZTR5M5zk0Cw+bWknfPG8Gafl2jub6shJnrouvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6Io5OskCgzsbA/S5P526DxOEEQ49k4tp9/Rax98u6U=;
 b=gZsKLw7gzeailsCT/R9NCqxX+KOv2QtgfZXn8jU+5sOFuek1FuHDQ4Cwg49l+cFxrL6//KY560NNLUk9JJ6HAHVQkEuPzmkgsXyNAE6hB3jd5NKgxBGo/OLFvVdDoroTiRIPkflUg4PB6XgAGLgt2DzzJbv5riY111HLG9pD0zbqceM3SfVEYBIn3Ag+NURDfhYWEw38DwGNDjBZpf+fnLRKM+8KOgMT6uzBW/RuQGCCcMrGihhjDl7BnT+Z98J8Jt/bnZ+Ry6cTLUQSyHk4fr0UTPfyyeox/QmgFqbHTsOtMt3vJ3U6eXySfcvz5z4y4d+2SR/rhic/EtAmYyBQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6Io5OskCgzsbA/S5P526DxOEEQ49k4tp9/Rax98u6U=;
 b=pQ5kHTGWb7IVsVB/bsZFZLArmbZMgkybLYFkX7JAjh3aV3YqrZt5VpOvbhsdy4XcVWmK65zSqu+J1zi5M9usRXdRZK+FA4np3y4sqn/HQim2ueSkWcB0gT1Y5GEGoK4r5Mb6OZ3OAwj9TQLLBxwjd3YxeJqQyqzbEGLD6eiGCI8nMSntCqpWdv/c5Dz7k0V0JfsFbBH6sLau+ymtjwXwDOLwrG51+tAhYnjlvkxTTCRqtDETzjrWQrDVEeRlLh+udAT49WxD8mGGAK8JhB08TlqOq10I9D45loLaxPKUSngEFD1MFkaaGhdtiFuDUe7aaD2f5P74QxzFEH03J8pTHQ==
Received: from AS8PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:20b:311::25)
 by AM5PR10MB1652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 07:36:51 +0000
Received: from VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::6e) by AS8PR05CA0020.outlook.office365.com
 (2603:10a6:20b:311::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Thu, 17 Mar 2022 07:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT024.mail.protection.outlook.com (10.152.2.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.15 via Frontend Transport; Thu, 17 Mar 2022 07:36:50 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 08:36:50 +0100
Received: from [139.22.132.215] (139.22.132.215) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Mar 2022 08:36:49 +0100
Message-ID: <28e550a6-79e4-890b-6833-70e3cb529491@siemens.com>
Date: Thu, 17 Mar 2022 08:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.215]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad2856c5-c57e-4658-91b1-08da07e8e661
X-MS-TrafficTypeDiagnostic: AM5PR10MB1652:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR10MB1652AFF3AF0C98ED25691F0395129@AM5PR10MB1652.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SM4UtmjNFX/6XSFHwirmH8Yc4mhQfcY1rfXy2FdgROjsxVYcwkwFUFJ/DqtjqiLn/IIejM7Rg8KIoYCc0WamXbXD8QZVjw063bN/ePsB8dmQx6SclleR33X2bYWvYnb7G5hmI0EmQCuWrFePwnft9Wi4yt+jlfFuwgmUMUS7AhByDQPWCMNcxE0ZI76p561ek3H8Hfk3Y50LlbLOYGeD9yrTnPzxJzNEPkIxMxJJbqH0EK2Rqstd3zcUlacZsihhLETlyKL+rMQNLNVD6mqJBoOjNB6bRMdhyVecTdFlgYSC0BqqSQi02/lrenqzBr4jGa20E/Aka4TdoKSVspq/49Tdd3ulv2vcT0Z/QCepZa7xgyxJfXEmWB30VSXZzajHrRJ+wQUrPspCi/uwPRujTM+ClEbO3+z5h1Am3cqRZesQLAwKhJ2YTvTUaZFfudZZus/o2LaSM3mQOHj9Xa2Tw4esQgvLROzhSyxxSIs6fuxPSImKoGgbEJx/2dSOUfHE0npqY1cz6fzlJPGt30CKMo7uX4dIeEXiNdQb6d7uPwslWwC5XpMZ5LSie2C7cfOToc0FZ9p8DIbHnivOVLIlIo1EONBQF3qxjmC0O2mQIlSYGqeTKAXu9k3DnAuriOYQ6xZRhrFQ+vBITWt17eu3jRoxfl9o9C5dOG8vMMuaH+gP/ZyMWVOnY9IaNj4ThcR8Bl7KVkc3DKs4Z1ANUy8i+YNb3FRCPsOKMjIaQtv2kupwPv9qVKF/hWTupJFONtcHSXhirKfkEPdRmEBkYfnVfUdo3PBNPwU5uvmXxvAbNQ22qsEzL543EoE0ZsG4Bby8suADoFVZwieEGOD4Mr+H07xzUIchl6rfBBN2qRlrtcc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31686004)(47076005)(81166007)(6706004)(2616005)(956004)(26005)(36860700001)(336012)(6916009)(186003)(82960400001)(16576012)(966005)(83380400001)(356005)(498600001)(70586007)(70206006)(31696002)(40460700003)(82310400004)(44832011)(4744005)(8936002)(5660300002)(8676002)(86362001)(16526019)(36756003)(2906002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:36:50.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ad2856c5-c57e-4658-91b1-08da07e8e661
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Mar 2022 07:36:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7774

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=3&day=17&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03-10-13.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

