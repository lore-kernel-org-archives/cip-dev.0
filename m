Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DCCC4332F
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 06:21:04 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.88])
 by mx.groups.io with SMTP id smtpd.web11.6555.1666246856756859485
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 23:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Byr+vjNq;
 spf=pass (domain: siemens.com, ip: 40.107.13.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmujL4LOUQoP6sCEFYm7c13BghQ+q1FrJPNsiLmKZ59kMAFwUO8JDiryrUegxUrzjmd4arvErJmJYs4UEheLcFLzN++bIfOSh5nG3pc6SJJ8o40lh6yrTAQqhD4z9OMAq1V8fC/i/OZ3tk5XV09GjKRNVK6k8vyfSZIvBfHKOruph+7JzK1RnDM1zdhyQFfXTHVC8CivHtZ2Q3yPA8oNwjOkq/rqULK2zAPGlCSYye1Dzust7qyoRSaLl7gvuytKXnPMDEGDh/aMHsgAkeXlXLutf/T/dvh1mWbu2Wo0PBBUGtbGF3P68cUXHFFg6nTlRibHm9/ZoLvz3FANHIyISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJhfH0ebCxHGG0BQqPZRCPxLBsSUQGG5zs0qyP7GmXY=;
 b=oNPr3E4ioLsBLJDbcIOnaz1T1MgRuCyAhSs+LDN9DiWgME+WE20JSt5AOxoNmOdr1E1d7G9PxCsm8CEEp5UdUySE/PBQVOfJsRiIc3TfqztI7Oa2na+5YwM7cCg5M9CXuIll2d9920wPIpkxqBlJOft4uS3n8P3wRSV+VlAnCv18PNmGPDPLtxXl0eC8HM7lhJZeI7vZIDUMZ6c/jz+kONmiYK6yY7WaTgqYcuYlk3Wsvxr6S+dNAllPyocq1aZpS5Sb4LWGWOvI845PLMz+JOCXuWIsUsemuwzFEy1IR5e3YJrAJVVhd7xK0zfpLYrm1X5+JxWNc+1cFA5wH1mWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJhfH0ebCxHGG0BQqPZRCPxLBsSUQGG5zs0qyP7GmXY=;
 b=Byr+vjNqH11He70xiIPvg+MyTRCOof8nM/EkjFQTu+ESriNuczueXwJ5zHnlt2cAuwae0IHY/OuAy6zTlSfcpavo8MLrjyfGALV5QD0gdGEoSO4ObgQoVt3l85KSB7edPK2AkyT788msffusoOSt+XXx8ZkQ1IplPVFx2erIXcCZKSnU3wyJ8+aoI7nCYNuD8um0VZFhFOGnq50qP5YVFEDQpTCpAynw6j4XczN0r+/XOmuHgJemXNylp3eRoRPojiWpn39Tl0eBaiVhBCA35rWnWRgs4t9cwQZYHZmL6SnNgludh+3R4W2vm4JLhVBTlLCFDP3ue3vjO/UYmtbKXw==
Received: from DU2PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:10:3b::34)
 by DB4PR10MB7040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 06:20:53 +0000
Received: from DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::cd) by DU2PR04CA0029.outlook.office365.com
 (2603:10a6:10:3b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.25 via Frontend
 Transport; Thu, 20 Oct 2022 06:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT097.mail.protection.outlook.com (10.152.5.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 06:20:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Thu, 20 Oct 2022 08:20:52 +0200
Received: from [139.22.107.40] (139.22.107.40) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 20 Oct 2022 08:20:52 +0200
Message-ID: <a4352f03-8004-f9e6-af0c-acc5f3f4f4a7@siemens.com>
Date: Thu, 20 Oct 2022 08:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.107.40]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.815500-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/RUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGLqhcdnP91eXFlu8
	AJBkPNML9u2sKFA/N0ImdkknPE0j7i8zVgXoAltkWL4rBlm20vZiFQvkZhFu1q8/xv2Um1avoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.815500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: D3BDB366EE680A83B863EE3A372A3245E1598BB08F248FBD10703EAF5956CECC2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT097:EE_|DB4PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb173f4-6482-4f9e-2952-08dab2633d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0VQEL8XliemtgnHaVQN2Mgfmby8gbjeTyKMX/G5bJCvL0nFrrcxWr635HPWZaf1mAT/L5SUbYP5nME2CS+QSb7JOAqXKajIRmp7SIJKTVflGVZuOuwOZYGT1L0vOxcPoGmaEPsvhIpvoZbEBIdm+Itl/Mxhed2z27Rio+z9fVWfCjOoP99MrVWkCWZRbHK3HGCEbwZU9hWwc3GdT5fAa16wL+3aND5CbBfdas4sytXg3AuHQUIc+Sa4UbWujhbhF5YFY2MrW9lg0vmFe8QKG6BhC2TecFFO06Qf4SaVEpezQcDAoX1Ky0ZwanQOfFqUgApgsFiDocYSUXr9KDR9X+S9HQEnD4vSnmi0l5T2oMmuIp3PVCimAwXCHA92Mosh+6ZRytPVMjtWvyEgCen9yUepVAvRTtcQVGWbluYPIxX8eUYfpZjAKx+2La6araBCMt29xGf1GWh1c8OUkpJSvnKrTAS2pMk05ifR6i/0WLLa12CqW6jyT42fqYWcUfmhxuUH3O+rRalL+ZpsO/0BoJMqtlkNLnMgWEaFZhuJoxuTgjpXTv6nWX1lGlvvUtM8FLhNV5XZJbxyCGNZyfpZOW2l5EGbHD9q5+JxY+CazazJKL78Oil5q+y7BlYyLH8On3hjDYedzNw8qnYqgUgXFg6zt0BkkuAHG6vyrLix7KmpE7NwPrR4mxvNNQBiKUE8IH2ymtXTopHGp6Vm3zb9/+mos1quf795zn7PUguagX48O9PDX1pgh+MvSp9EyE9czz7XjaurKSA5Pn2LD/ksMJUCJravpDuqyFOA+REamAMlAmjY7LZIBJjCMuX3bR+n7SifDeNf0m89bg7BJoE8/KLH5lIbBWYnHwT3B2oZ7UiZtQpzrfvKWT8RU5C10j61MJoep554Wa4ZnnUIV0p9FIAI6+37XBerIFbS7wsitqw4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(316002)(6916009)(186003)(956004)(40460700003)(2616005)(44832011)(16526019)(2906002)(41300700001)(36756003)(4744005)(70206006)(31696002)(5660300002)(83380400001)(16576012)(8936002)(26005)(8676002)(47076005)(86362001)(336012)(70586007)(6706004)(81166007)(82310400005)(356005)(31686004)(82960400001)(82740400003)(4001150100001)(34020700004)(40480700001)(478600001)(36860700001)(966005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 06:20:53.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb173f4-6482-4f9e-2952-08dab2633d9e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 06:21:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9794

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=10&day=20&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/10/cip.2022-10-13-12.03.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
  2. Ask Florian to support with 4.4 kernel-ci reports - jki
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


