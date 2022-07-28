Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2995C04A68
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 07:11:25 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.44])
 by mx.groups.io with SMTP id smtpd.web12.29643.1658992279514709036
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jul 2022 00:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rYRmVZwp;
 spf=pass (domain: siemens.com, ip: 40.107.13.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht+p3IzZ7Tnv38ecBBSBQgWek5mOOOZtCT4lvyykabTkkasyvjNcT0uQuXsD+JBd2utre/ykzZkjiHRkjbV4jP4eeANj/usDyMHFBEL++45ePyGGAqkhbncKue4Si6h1ZrUlas8n1sC1YFaR3h2MAhTm0gZc+HuiTFMVbvT07f7QZUh/e1H9yGek04nXbh8Tpq5eshHM36Dc8kgqscjbGkdtgR8tzra4Uwr4voekHQ8Y0erhvYERspGMQRGO89Pg01nFUsU7G/lsBB8CxCm0fB0jlcofkRxLNE+aJPJKO6MhcMgn4Ijq0UcXuby0OBCLgVTtKYCXadIHwGetFtjUig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFW0x9gMIuiHHE0dluGsQXWYlHDQGmKK/2juug7asRI=;
 b=aBJpUKmZUmIODg8jNSpYJd8Xd83RqVNv87andtHoxaulIMqFz2W+Hg82m6HVs1OjfaYaMV7KfnDF0jqpubVPMSPivQmcnOre/y7uUedvnQANTXOGZwdgSkUATEw5eFZQa8zw5PlZYJ4qbhS8slQNCU82qnPjZREI2hJ/x9mg2iYS9VfoG0BM4CVFyh5DR/3mmOEOnt9jhwKpQb+wBCWZu/8b0k6MGr/zAnisNIv8VJoF67o3mcJoF92cxCw1IhJCg8YGoaFTvDnnXtiPe6oF5Cu5JE3U/hzZ7GkUvunNd+KIG/rhu9WgpkPBxgLNEJVUMw/4S59MoyJP78cmrmjaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFW0x9gMIuiHHE0dluGsQXWYlHDQGmKK/2juug7asRI=;
 b=rYRmVZwpfqzTOGq+f18bQVtQ6lHetUsQKvVUeY2mNB84x86I6h4K3MziP0mqj//agYTw4MKaXM39F7UkP4uyR4oDyLfSHKMCyq00/w1z370NqblDnOGMOU98rmT4drK5JJjE+zZJrJYwBdz7ssBYuqAw0Uu9qJ9QKAhnpEi8rtoju6x2YqvcO06fZPxFwNN1GvEGc9Dw6OPFA8ec8Lq+YD7PC03XS3tc/2naS4W509nfm061sirkYqRE1L27rb6p2KjGkOpr9oga/b+vX8qYqjVd8E+MoSRa7VVxGlvVF6JU8jJNLxI0tzL2lp9JSP71xPy/FySKvzUguk8ZXCAUbQ==
Received: from DB6P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::26) by
 VI1PR1001MB1343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 07:11:15 +0000
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::2) by DB6P192CA0016.outlook.office365.com
 (2603:10a6:4:b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Thu, 28 Jul 2022 07:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT007.mail.protection.outlook.com (10.152.4.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:11:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 09:11:14 +0200
Received: from [146.253.20.91] (146.253.20.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 09:11:14 +0200
Message-ID: <fd0af4c9-2576-b998-9f13-c5c4b9aa6402@siemens.com>
Date: Thu, 28 Jul 2022 09:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.253.20.91]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.697300-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj9UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuE5UcZtwNsCro5f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQAbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.697300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 DC6C3073AF7A79B58A8F8610DE5354AF1D852836418DB687AF569B715A2A5AE52000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e9c9b2-445d-48cf-3e32-08da70685c59
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1343:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cQ/AHc7mOwG5SxZYTU3XfcSix5ZiMvJrzbffzFggKl0FPu7UN3BYYUl6jjh1vEoPJ4sr0WIb54LpnKgYw/QFh6gUNghquLPzO2yopZKWb+qV5eCobYU5ukoRNGDulSXFf5a2D5RoARx1zFnB37qLsEWpXjZqWuIZneADIChyWWguLdATuj+bwXIytE2KrhVre2Y5nhUdvgTrXpE6EIqrymZXiUW4TM0mSvCiyTHn2FBRMoXlJUuqGPtyYRbG8CwD9YpB5ZmvWfBV8P7V7Az6opzRzWMb2FPCxloGhwvQfz7ClgoByTajEkIMy2UpxEC6iyIak5FTLSG0OzFb9MzxSYZZ/3HV36Yny8rE5EQlIlfcHqI6keLgRbY5yqNpgnV+2Q3ulV2H+R7sfKUYWfzG/LyR96qAaPmzj1n7v9ER7n6f6Sy15wP9Pu12pEZKcsQSRRw0xRKUiGF0YyGMCtCjIDI3gi3XUQzybuC2m8j5Jv3PvhU75P43UHJVWzIAUS//6ZYJFDHpyTYvlfWWyIPfHg886P0opJ1TIlVGuC9p2xnfTp5fTz8UIznON+YoBG4fuSGUF/8q5NcZ1SbfmTAlfF/CoMbCeosVGl3sQVIHaJXABe7u+AtwoH/ruHTRdavWgbjE5LLH9hH/weWkWTeZC/eV7aiGVVOY/hjPgobTyENSwo3+uzZPnk8LVBKOUB+NyzWjMsVulh7lOhxl+zDYTib8j8kengjRyT4CGS4qVN02IbhNRrXw+zQ9JpBr24fU+Q/h3tX3MCTfIlrmPOZvABjdQIYzmkLw6t0XGiBlZ2+kF5JTQE3KT1rr6bYwph3kuL2fwxiS05ThFlhvnRICa1FHAnWtsrg+bHTdEYhvwOOAPhiC3eSsXKZZiaGhT8g+Zo/DPlbl4tPJRNuJtbhhDvWqZBLqc9U3BiGoffDnSwyNDjPrltWmjAlNfBUloLN+
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(40470700004)(36840700001)(16576012)(82740400003)(316002)(31696002)(81166007)(86362001)(36756003)(966005)(82960400001)(956004)(478600001)(31686004)(6916009)(6706004)(336012)(47076005)(26005)(2616005)(40480700001)(8676002)(82310400005)(16526019)(186003)(40460700003)(70206006)(5660300002)(8936002)(70586007)(41300700001)(4744005)(2906002)(356005)(83380400001)(44832011)(36860700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:11:15.3983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 29e9c9b2-445d-48cf-3e32-08da70685c59
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 07:11:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8957

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=7&day=28&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/07/cip.2022-07-21-12.09.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

