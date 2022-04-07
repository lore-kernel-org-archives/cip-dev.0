Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A5C47080
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:14 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.52])
 by mx.groups.io with SMTP id smtpd.web11.3796.1649314170353373455
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 23:49:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LM9ijFsh;
 spf=pass (domain: siemens.com, ip: 40.107.1.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO4ybzKIR0WBuql2n4obHksjIGjnlQjxj4XO2fgMojQ9QA71PfSjr7pAl7HewG862YOGF0g+/rm111J9a3PI11pUcivnJ2VSxntsPeXrV+/SNxfiu2otIIC6agnpCTG3CT8Ej0kxfZE0lpKRek2COXlIeGW5U/cYze+FSkTX39NAbIbPvyaeooVG2ilij+PNF8YE6SXNnKds+S+4fE/zlCQUq2Vt3XpbpTkALav1EDMqRmBUCqad0LjZyR/rgYDeyKyP36yAvkHxcZtZqmvoWXCXFVKpwSJIunaUyXKXizPfO/x7yLIxh9meGVyhTz3yibMRZlTsqyM7p8Kdr7nfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYwddeR8U0vl6uoPQqkqyHkpZYPwi57KTY1rtZsmIkY=;
 b=B2gG/0eVRKrNzrzTJE3dTJkOVsjh+mkzNylkprhgSGac04n2br2nVFPP8+WEwlCFl7MCzSgCdqjcd+PfH++CpSWeRvAJc5wDjtlAPF/rR8avBVZG0dul5u/eOq1ucjXNA54qyts2HDur3iUkPwMVwkYAYkP7KIuBsiHIkD47mZXET2dIGy4h5Qw6wLp2Bm8FOvhu9NQ3i0hL66CgO6OXbWr4XPGi0JEabLz3RL9yBGsjaToImYOuHGPIV9b3NZCBWiFjDE+D5+dpLOuSsb5Ax/QCUxcPR87ZPUWct6sHpm8BWPxWJ5MwGuuqwa0Rm4zzbav+UbiFOGq4VS/ZmHZQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYwddeR8U0vl6uoPQqkqyHkpZYPwi57KTY1rtZsmIkY=;
 b=LM9ijFshhmmEnsSoxdkInk1xT41q7xv8U8SVg3VphIQKle3TBotSzIc9mQ62PNeo0qR64zYAJzAPbS76DPvMulX2jQxofFJHUA6zIH2yXC6ud13unSADGfEODvUBxdLR37EK1A5HM4wNIA1XZLIAeHE3PTDBvaVWzzApqG3DdvdX7fArXNwY3m7N2O8K1cD2tfuu1+IKk1/idK76B0dH/xmFMhRnA0B8o+og4cpeEMHO/PXB5Yi2yUx3P3qcAWqw04Uk1q+ZS1tAYPkH+n+1gp+ALqXQZxW+c1/7vhdGgwdiV3h2QWc4Fg2rIwa4x7JyPTsVkPjs4FqcH3YwL6txoQ==
Received: from FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::15)
 by AM0PR10MB2739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:133::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Thu, 7 Apr
 2022 06:49:27 +0000
Received: from VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1d:cafe::7) by FR3P281CA0012.outlook.office365.com
 (2603:10a6:d10:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Thu, 7 Apr 2022 06:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT056.mail.protection.outlook.com (10.152.3.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 06:49:26 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 08:49:26 +0200
Received: from [167.87.32.126] (167.87.32.126) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 08:49:25 +0200
Message-ID: <76860af5-c727-1ca9-a572-ef505ed51aaa@siemens.com>
Date: Thu, 7 Apr 2022 08:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.126]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.967900-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto23H
	KB4DzLVmzfPQ+MBu+uAMJcHOzzDuM/wTQ33io10KvBA2ZMpJwcYlldA0POS1JJcjGePBisFMh3X
	6cIqUh+myiLZetSf8nJ4y0wP1A6APkvV+z371TK5MIx11wv+COQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.967900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 62473455DF37DED3AD6775173D032D1636C04B739C99E0B46E03B11A8AA0488E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e42734f-05dd-46aa-b026-08da1862c1e2
X-MS-TrafficTypeDiagnostic: AM0PR10MB2739:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB273943B035E2DEDB1F16C9C795E69@AM0PR10MB2739.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	c+42QGoXs5j07HXuXUQCTheYd4nErQJEiRbYQiBYcYLvusjq083WZOeXcJoE027/MVcoWttzuOTiGmNA62WIE8gLUN3GKXiUq/XlK9domVsSJTrJ124aRwl+JBkaKrjzUFsVxE/2Ys9XWHd9xM2AG+o30Ua+JuUmd41TgmxTN6XT0bvmDRv21Jbjo1VLj4EVftiwnR2c+R5xBi42Hms9qvwkhJ3XD0Qq2wqMyCmSAqcKivyrb9oKq/M4yE/0cao4eRsFRhIJxKg1iLJXb+IJWm/dSdHRF/j2nbnibu2WCaDS2jkdEESi0+bvYjb7hKYJoY+kFm+Fu3KTWwVMUb/r9mO9c3eXYDsSPbC7+Tj3kyMp5UYV+U65LQOG6nTfcOXJ40CLdVOCMO8LUZsDvmkKkDT7Zohy0srYH5ebnjiAm/3azX10CT2iqwtTU819OXpJuoJYUmchIf/7rVhqFioXCfALIF4y2ukDb8VptxromDUqWpsT2UsEJAwbDQrQrtDfgs2AX86+Ap89vwxP4NHEpHajwGUW+QcF1CIMr0GuuAKFr3knEwyPDknIKVaXm4IFPfYSzzDZOBqfj5hf6bhZPq7WohWdKkF3u+S/VAOp8lmEvuqK5aGixhVIbLxkMCncJQwLFWHjRVj5c2N8v2ENE5YXeRTUWECfHY/WeK1JUnlkUgpDx0OI528D5jGvUllsEevf+FPVIrrz5CM778raVr7uFQbsReVztRaj+UAS2o3u/I50PqDa3Bmr7I4iJasEvW4Ve2TyVWwWKzR8rkDucMeX6UALoQbDrUO4frNmuUpAvpr5gf2zEHMr3VncpsH1degAq6+w9H3v85K+CKbIv62RWZpURBDizxkAvQvvCcE=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(6916009)(81166007)(70586007)(8676002)(16576012)(316002)(6706004)(5660300002)(82960400001)(8936002)(356005)(36860700001)(44832011)(508600001)(2906002)(36756003)(26005)(40460700003)(4744005)(86362001)(966005)(186003)(16526019)(31696002)(2616005)(47076005)(336012)(956004)(83380400001)(31686004)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 06:49:26.4442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7e42734f-05dd-46aa-b026-08da1862c1e2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2739
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8018

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=4&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/03/cip.2022-03-17-13.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
* Kernel maintenance updates
* Kernel testing
* AOB


IMPORTANT NOTE: I'm unfortunately not able to run the meeting myself 
today due to an appointment conflict (damn DST...). Could someone else 
from the kernel team take over again? Thanks in advance.

Jan

