Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C5C433F5
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 07:46:01 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.79])
 by mx.groups.io with SMTP id smtpd.web12.8550.1639035959638219832
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 23:46:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oxoIHi9J;
 spf=pass (domain: siemens.com, ip: 40.107.5.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4aihS3o7jPqay8Zb5xndinI0y1P7j9RTEJ2YTDlkEUIvKiLIt4ePNf/jfG84dIyPKzEJMkEWyH/MmHJbmtdeKTBqsGrZllu0dGSIXsSejkDq2OjdZNaACX6LDV/dmX20NmXVH5oLUslPcoEeqHvVl4qXdellsD6kD06aRL5/Wq6ynOVoOSKL0oRtQFswJH5Y78SeNcrvuWvlvaVYOdBLRvOIHY/fM2Gf/5lRYYf0VzC+rHTkCebaPvApT/iyqvXV5ixAjnPzClY3qASoQE11ZmrdOzPWxGsuexZA/tjGCbUowAOrUhLRmApJI3TYAIf/PWYA95fSCCXhPt5o2TY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0gz4xWW1dO2HbmeoWtLSCBvbCh9gmTDsG0TNLwZHco=;
 b=Ve5OJzahhuY78IWoog7y8w5OAm+cCfMub83F78Xm7UGXTg0E+x0CvYD1fFUDVAuYGU2l6eIJYtGQueEAqQThYpYP50+r43k17tkeq56CS9LDcytoZUzcI601OL+I/I6GGehd3vCoIrOvlESgL9XtLgxu3iBE0swJ/MODXQpyQIIMX4O6jJ6QGLnpsRDvW0dHVjH1m+58p0BgO+P6mV7X57XDGFUGGfyvt32PrGFn1hxzPiqY/ZYrSpVWKwDxS1PlYvziowRLlywkHxSxJo7QTsNgkyfNs0mcLtRiB2uJHlGIGR2JA5fd+4FUp4wsPBrMq4uHoajpXGoRXu7Gg30WOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0gz4xWW1dO2HbmeoWtLSCBvbCh9gmTDsG0TNLwZHco=;
 b=oxoIHi9JTSDJaemHc8pFMdKjJismD+qcyOlZdvcLIhvJNGjpY6fSVFuad1xbpkfs3L5tzIo1t4t+V/rJM5fvhm6Ev3/oRNEyg1e1H5OMb3fY/6S5eXFKecb0EPuLp+6webjQjIymvYv7tbVN4knFDHrCh2OnZDBNVyYSG12mnUl0w4Jy1NMMa/2XTofdY8uGnrljcINFDgba91qOl56s0owHR+2QOS+KI73EJKaaVj3+E6muQy+CfLsAE4om9rSzC61Rw7mhDhZMM4Lym1IDINwcAYyNe0jlMeWHzsRQflReOVBW/VS4KAXQEOhKxpgW1ijV9rGnZK5YedNj98NBYA==
Received: from SV0P279CA0001.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::6) by
 AM9PR10MB4513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 07:45:56 +0000
Received: from HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::c) by SV0P279CA0001.outlook.office365.com
 (2603:10a6:f10:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 07:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT011.mail.protection.outlook.com (10.152.0.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 9 Dec 2021 07:45:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 08:45:53 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 08:45:53 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Message-ID: <1f7940f2-fe0b-d165-5150-1eca0d1dbdca@siemens.com>
Date: Thu, 9 Dec 2021 08:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff47e36-4a7a-44ce-6949-08d9bae7eecf
X-MS-TrafficTypeDiagnostic: AM9PR10MB4513:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB451365126AFCDDD2B48C215495709@AM9PR10MB4513.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AfIFkCgdcI9vWF+VHe/zGPC+VbKONSHblpxO7bdhk2sTOp/QZwerhJxZTlaiNY7Ht+fvSvt6uUmhNuT7dVj4pX5WeV0h5j1nc1+JhjjReK8HUq61JA/6yGNHU+KQH1sIFeh9eb8KC8nh8g3ky0TSVZa7ehyAuqhcWJh5oBW+4oigZM6YJfBQ8H5EJBX8SAbFAU5HAfFiapXi+8ckkU5GQGkZZMSFIHTPPnIrx193ozLjCH8bkCUJ+nyLsW9lAjYLqMhCw0Q6Dq+PVejggRRKem6PNzBVu2jpSUdl6fSRsm5bHi5z02K2sHV6Zf/XlHnn52MkhoUJrIgxwIJDYxq+vgj/BKvnKhfN5RTHMN3UG8I8FdOACO3xTQrZeB9igUbmIxtKGoIxLCYXOAr2peETnaiVRVGodsfCgk6i9aTJc0Y9yrh4UhRC66n5Ni09Rqs4/gDiUJAUr31j7ZFuCGLFNXjpaKt1pVY4c4kGWaJK6RyL0q5qENgi1bcGxSQeOLXywjBtwTmX59vbxy0mRNY3mgrPVKtKyQ4UFiLlv9kuQkVUII8lNB2CZKebLgIbclXWlKytg+tYbQt79Iw9h4t72KYZlufbAbHePLPWMLUVw3qoJ7MYhO8fzuL8Z1Uw8UM0H1B4muw1J8WttJlLC3rVXq0ROBg2jl7s5NJDWJB7AyccwH2T51mTRQf2wXwO0v1JYENKv62CTxFMKtWPWl7Tq8JsMSmFiWXIaKHzjkThyLcBYEe06Lqxf6Q3jnrQABMzj7140DT94snygnP3jL2GU9lw7n3DhqdTqu5Oog9saiiVFe/RturVt6brlWcDq7WI5ouoUuYZUNCLZxGsDw/6P3YaQ0IdYxygFVHDMqTtQOJefLED5o9dsCZctJEkD2dE
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6706004)(508600001)(36756003)(31696002)(86362001)(5660300002)(8676002)(956004)(82310400004)(356005)(186003)(83380400001)(8936002)(36860700001)(336012)(16526019)(26005)(6916009)(82960400001)(70206006)(2906002)(81166007)(2616005)(47076005)(44832011)(4744005)(31686004)(316002)(16576012)(966005)(70586007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:45:55.5636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cff47e36-4a7a-44ce-6949-08d9bae7eecf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4513
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 07:46:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7077

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today.

Please note that we moved from Freenode to libera.chat. Our channel is
the following:

    irc:irc.libera.chat:6667/cip

Furthermore note that the IRC meeting is now scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=12&day=9&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:

https://irclogs.baserock.org/meetings/cip/2021/12/cip.2021-12-02-13.01.log.html

* Action item
  1. Combine root filesystem with kselftest binary (finishing) - alicef
  2. Perform initial comparison of KernelCI results 5.10 LTS vs. CIP - iwamatsu & alicef
  3. Propose tweet on KernelCI-CIP collaboration progress - alicef
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

