Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E0C433F5
	for <webhook@archiver.kernel.org>; Thu, 26 May 2022 07:12:41 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.55])
 by mx.groups.io with SMTP id smtpd.web10.17006.1653549159625823433
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 May 2022 00:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Lsdz7iMr;
 spf=pass (domain: siemens.com, ip: 40.107.0.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIb+g8xRx//M2QVNFoJUq162o2A4lRqUly8ueqrhaw1F7I2xcNgiGa/4Je2ztLuesH+RUh4KJm5H9EHcO4YjMr3luQzMLtNfkyKWCdytfkKDgB7CzGaKXWWo95B8TVPWiT5F7JFz2YgG1cuHq83kDBWo1EssTAFU4DJ94IGnJPZ/YlHwtBqnzoEnvT19GYKE+4UQfdVTAs8eS9vqwguosGkQ/8MvGAF29Dziog847eJWpZf6jG7wso41tJhBVimPOgvzUwfa09lRbckprNSkFvcrpDU2DkSMeW6Suqzu300O1AMqxJ5Z+MxM3v2CD2QK7j4xPKwV+oY9ryfpsQM58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPMDaHTwPkpM5AsPGmiBCUFAZNyEOHs1hATSmfYW1f0=;
 b=Or6HV2ccvob3BWg8jmn6GMNl8Tfe7Pj8AJW/aFid4FHdVYaUdChf4S73u7kL9UFzVEdJNo89HlInjREjdVY3gJr5THPBbWmZciZTOV12PquTRTzYCvpEBdDUYyqifZqXZ9mH+WzeLgnRxnK2kDzI0UyI/o1i4fG01kHsLT2spaNG5YOVo90qYp1GYIVwLU6j78nITGyN5VjElX7gNEJ7M/tz6YlJ7gGWE5Hzpr2Zen7dAzD2RKW4wFK2ujqkafU581EkrN/Ndbj73PoH5GIbuADDPM+eFh2FW3OzSXXVRe1DFYR0XprFJu+oDB1TBdiM3Bpf5kH/d48ClgexT6/cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPMDaHTwPkpM5AsPGmiBCUFAZNyEOHs1hATSmfYW1f0=;
 b=Lsdz7iMrjQ5sVy27nq98gKqeb2uwgep4Nm7N/gKzswjsQyUXiVFztCMqMhNojGcJRicjU0BR+aM7pheyrkOe0G0g+3UpNFmRmY0bSTW7vPlZDAw/bDZHeC3IoNRS85pNZ46908OPXLrA8uCc1GDOg8vmuXaZcgnTimVBxmUxPjY1Oq8gxFzUk6P/RkgE8mDWGOiEjVliHEJ95/C9YNWdsuBWW9gVonOP0lIrhJfqxqvinpH1prmuOXHE4f18S21Co6+Ixm4dXjDrkcfLS/zxLpsLGUQmGZrpXnAaXDmeE+DE+N9Y30UZAMdEkCussO68YdEKdc7sK0YsvwLmggdhOw==
Received: from DB6P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::31) by
 GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Thu, 26 May 2022 07:12:36 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::b0) by DB6P195CA0021.outlook.office365.com
 (2603:10a6:4:cb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 07:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 07:12:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 26 May 2022 09:12:10 +0200
Received: from [139.22.142.41] (139.22.142.41) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 26 May 2022 09:12:10 +0200
Message-ID: <2552c0cc-11f3-1dfb-3528-b16cd845ee4c@siemens.com>
Date: Thu, 26 May 2022 09:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.41]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.616500-8.000000
X-TMASE-MatchedRID: EhMq+2gclHtUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVlrpE34WGjdPo8WMkQWv6iUD0yuKrQIMCCAtDqHg/4Qm0C1sQRfQzEHEQdG7H66TyOk/y
	0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.616500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 BF52C1E7380A1DF046EC424D634563FF4D913B1D3A0F70EBE376AD2DD369D9452000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d0a5670-5f5f-407b-6a1e-08da3ee71bd0
X-MS-TrafficTypeDiagnostic: GVXPR10MB6005:EE_
X-Microsoft-Antispam-PRVS: 
	<GVXPR10MB6005E553C569F3594F099D9F95D99@GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TjMHY96eDBj4LtN7ojb3Vf8eWWSf0mCniauIIJfUtvdiBENCrMy3sC5tQI/hftQOjNWsf4ZkWus5q8ytwUGP5TJjfHDJQyUB76XjCvTMSRIjz+ooBbn3P6lGak4JuwuW5qEzULJlKD66ZWV1eAzM6STTC8BwkSpU5odJiqw42bpHawfzSRgfrOwRZo1p7nb9vmKZcoW/D9BQLwV9hPQo/+lHca4yCgmTk8uvedS5MUWwH+tuvB6YHa4BwsvG1/fI6Hek/QUGKK26hnidpk/J5vpsEQurOqJvzPp/jZdsD/fh7onKPNgv+PCbRvbqvmUUnRq8QsVP70TyaTVtrKW9wCiiNVHrY0XeR6Cfr1L7KgLxEj1ximOHBZCs2kEgrer9xJWb30Ka9zkrNXX93951ybB8mwYv9FYsJgUFxUR1DQL1YlPfO3vX3e9USWEzTyw0J56+cjX7AUM9qShz+Qu3zxrOgiVbrm2Vk2LIo4P4wXe2vZWOrk+xgafsDGXyYEQ1kmaJWs2RLKDLU0jlva3PCVFHK1fuUvL4pu0+MbxzC5liZI7Q53y+U9jdMLOQSMFz52ixKB8aD6yjImesilkenSCKAn05MlVYshXYia60aBV3H1O6WGyjWRDgD+j6BQd0cKjZhDDJpkxNmhLCLzYHHRD1h6VYkN9bb6TM8S5e7eZt1VqT+USQJok9jXlBULCK+cDRkJABQIRgx+ZOaBbTVtI5dPihc5iudyPPeUVnlsVO0NZJ2sEgK7QZTxumk4DcUoxBVLbdKe6l3D5R+Korc6oWMkACmcGKXyvuxSiXdvyN4Sgwac19QM7hja6BK1Ts9YTAxRjxX6KUU1zQi2n42yK8iDgkVKFVZuajBgZ6iBk=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(16526019)(70206006)(26005)(966005)(2616005)(70586007)(956004)(31686004)(83380400001)(36860700001)(8676002)(186003)(336012)(47076005)(508600001)(5660300002)(2906002)(81166007)(356005)(316002)(16576012)(6706004)(82310400005)(44832011)(31696002)(6916009)(40460700003)(4744005)(86362001)(82960400001)(8936002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 07:12:35.0732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0d0a5670-5f5f-407b-6a1e-08da3ee71bd0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 May 2022 07:12:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8441

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=5&day=26&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/05/cip.2022-05-19-12.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


