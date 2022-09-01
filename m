Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7506DECAAD2
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 06:22:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.47])
 by mx.groups.io with SMTP id smtpd.web12.9015.1662013313943318689
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 23:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jyYfeymi;
 spf=pass (domain: siemens.com, ip: 40.107.21.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+E3zRSBayYnmRomGTa37/9cwwBK72dnueXs7X8bDVrVRBfGwMmiynDCiRLPITACTtgTcwuER7+I94Jiraba9iAIQXaJsaBcSthfdQsE+9zk2FN0iYUiY1z2B+TouFPAx3waa8rZXEHcfn9MqN7EUnbfzauK9uUk57IrMYANCGcuUK2ZHPYMPF/csskAJAw1aSDYX9eAbOPdT5a0azUT/0JbeHRF3ygzutZ9N5TPkJsVIOyOh3bieKhLJ4kO9kpJP8my+MIt8JyFGoZrRaGn3yBfh1TVo2/0FGzCNwjVbxzYb2AahNLNoKp/gf+0PAYHuaAJwgpZ2EnEGFNYuqL8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iruBe/N8CYUDH5H4MnmHpCxiiJlZxipzITXNZKGU96w=;
 b=R3zeMoOrAcD+fqP21zemjgBvsm0jvbbDxhOiy46PQ7zqFp7j9+7DukuuTI5rmPX7DnxEfILwaOB4kl7BgstMjZOc5/hFjTaGOyyd0dddJaunR7EP9XrWvCs9588KqZYnrj+eqjfoX1FcYUi7Fihc/bEiInPPpjprT2avkpejzL7eCJGHpBL4/mgz0py3WtVMRyjnRGwH4I+42soMcaAdfXcncl2KfbMW10GnGndUcFqLpuBn7WFwSIR7FRYaja3IcMoJVV1xOlogcps/lmDhAxLI4ykpR0yxLv4x7DtcIXjx8HfeCJhq6lNm4SRx1Pj4APr3tU90SxdDmpGav+8UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iruBe/N8CYUDH5H4MnmHpCxiiJlZxipzITXNZKGU96w=;
 b=jyYfeymiwXr3x2oAYND9ojWRfoh7J/p3MMm++GpQ4UHJ3adCtFQrBtnWys1bWn3rmqD3+jz/n1O3N2A7TVulTBIh/EZFcgPILc2xWZMro6h45PBdeWO1sTO0EwTa+kbaBW47/P1gk/q+BtXODKWFAB/wsL3wtnUMTsSVxTwTeSmjWex4+8TLNcWMUKBQcr+ABFSUfdoPmE/1v/gkn8SqYSXUzgrQBfac+Rcn3SNyEbPuikPOHBM5nBhHG8lWQnzQltoD6YDlQ4CGzTDcrqDAlbzmr4O869ouzs8GdTq5uy1gyn+nPpiVzbKP1rbfSwByt1HioAmXScyOvAMIOcgPrQ==
Received: from FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::15)
 by AM7PR10MB3828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 06:21:50 +0000
Received: from VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1c:cafe::2b) by FR3P281CA0024.outlook.office365.com
 (2603:10a6:d10:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5 via Frontend
 Transport; Thu, 1 Sep 2022 06:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT072.mail.protection.outlook.com (10.152.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 06:21:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 1 Sep 2022 08:21:49 +0200
Received: from [167.87.15.236] (167.87.15.236) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 1 Sep 2022 08:21:47 +0200
Message-ID: <7567fa65-0e34-95bb-b6d5-2a1df649ade9@siemens.com>
Date: Thu, 1 Sep 2022 08:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.15.236]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.281600-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuEKV1cF8KK5vSqFx2c/3V5cX0tC
	KdnhB58vqq8s2MNhPAir3kOMJmHTBQabjOuIvShC24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.281600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6F5DD71D3D1FA002298155065F392D90C431AF21304E342FFBA7FEE83ED0B70E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2cdd28-56df-4c4c-c6e1-08da8be2412c
X-MS-TrafficTypeDiagnostic: AM7PR10MB3828:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0W37tPvhHB55HuFd4HCs0y/0Pf356ZvqUYGx39QMnugvoJhl7HudiXgiMBtBEZej68rFEOA1kZ5hAIem+ud1W/fDVMBnh+MhG/Y2B3IAKwwT5dqmYlDDNVNe5r64PpabBTH2G/bg8kNd0+8++kHJGqddpfaJGyODLBKQnZYkrR5xiC2ibo8UMf/ZtP7ScJdfnay7UM6ad4k7eUhte0JZaHqIX9x+DqyJHxrE5X//q2dMaF48FcetTpeWROQspidUsWXUmqH2eQymcdSWqE5fr10rpG8xpkxd2Oph2Vdf4p4LMF0unEDSMgvQpWFr+OmRSQSdd5oRfCCKAU9KyHulBAUPXCliCO4QnVKJ+HzUPjCjEzjKhlEtZVweMtfK20ZNLVXWeYWakin2lT9r+hcNL8gTeCKcLIHe7KmNg+XWjVgla7opbZUF+YD01hd9Y6EH9QszWIMkqKRQSXlzbWngJAkK2f0/bOexKGp8iPyudJpA0m5WVLSC5m6SRCdhqisTfhS588g7fORkwF18E6io/JH59/lSBzhXw6WHZxfQP/PwrDTupVX6jofYoHN/ZL/b0JgOkvL2D/ETxXSnPGoUneZ6/CgmIEHj0ZKkpAWPpFpUjIqhejpjfqv9Qgfv4rdTmf7s3hNQwC+lLVeN4TMtz6+NA4zt+JVCuxqn7aOCg4xXDK+to8T/5E/nB//A60YlZ9NUBGX7cvSNcYPV6YhENkp5zIELPKmttZGLo91CHVAaGOfE4ayFhfPzH0bYtIGCgSLCRW/jR+Jbt/Y5JLV5ZsHj31LDlg8f+4Ab4ttWwt4H6UV7GjDcUhdFg0rVWsCGSYeHFM5NYEKwbAjBnqS1kjv/xGmbZrmqCTksCkVaQo8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(70206006)(40480700001)(2906002)(8676002)(70586007)(36756003)(6706004)(966005)(316002)(6916009)(478600001)(2616005)(956004)(186003)(41300700001)(82310400005)(26005)(16576012)(356005)(40460700003)(83380400001)(36860700001)(47076005)(16526019)(336012)(4744005)(44832011)(31686004)(5660300002)(8936002)(82960400001)(7636003)(31696002)(7596003)(82740400003)(86362001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 06:21:49.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7d2cdd28-56df-4c4c-c6e1-08da8be2412c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 06:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9403

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=9&day=1&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/08/cip.2022-08-25-12.04.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB
  - TSC voting proposal: Add RISC-V as architecture to 5.10-cip

Jan

