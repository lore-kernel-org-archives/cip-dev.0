Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D783C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Feb 2022 07:07:33 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web09.7084.1644476852048328620
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Feb 2022 23:07:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f1kpb6ib;
 spf=pass (domain: siemens.com, ip: 40.107.20.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4OsxHVwB9MdrzyZkEEp6/ArZ1khHoQooCyg/5pnuhmf5nbL68jg1eKzdI0dPvh7/3WEhsONmt4V15zZXcMKFVQMEyll+5ynrJvTL83BOuG+72T6OUdLM0AlZZFH1lX8dhk2zQIzYZqrOXaYnNxhxacZMMZUn9XS5H+PQ5Trp16c46vn6a4ygo++oN14oe/KIcH0ofjwj+QtfPd88Cqw6lIcumAXlII0M/eBUu+kDud/UX0lOqosoomTpajt5jW7eSRASJQU+zgEAmNfsruqAWXY/55sTXiP1+DnrqLacdXfSoi7DLjt2xa05FLqC6uFe0Lj5+XgOJiWmst0zMMxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkd1v7OMymOsLTOOcGppXyBsrEWk47eJS7QbdtKwpHo=;
 b=icyK94Jd6NMqYTnZ7HNTQfrxYoLfcaQY34jnMM49iPi7GA21Z6kEDCPckX0JMdUDrzS1fTHlNA4xCe+wJ+Lqpqoz/VCx9slJB/XbjAXpJwkS6hRbKmyfaypDcqTTUlyZyUvkWNi6C72oM32bIfY8f6BKJb0CiOPlcKmE8Lo97phd6z9jAH/4xv0Gy6wGaTHUzGFO/rrKOuhqqZQHwm6E0YgeSexZQmXmduKuXZheXsB8vZKFreHRWiBg0JJvuODZXjDFJsRaqb8MPO6Tstqpwu5VqtwCCCwENJrhHTvSKx8zwcuoVNaOk6i/1o8qWZvk3v/jgl/dvOavr3yZqhp/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkd1v7OMymOsLTOOcGppXyBsrEWk47eJS7QbdtKwpHo=;
 b=f1kpb6ibsllqL4QQIuj0OWSk5OtliyF16nIzUtqq2mBWSmPVNykJ45WQ3U2O0/g9V7DcAyrLXAGvGxykV2xv5Q9xK1cNxItHEzJm56HJfKlx1XuCi9kOSoyvAbjlp9wI/eNEae3fSs3A/F+cn2RO1cvwlU6U+dWg5fHiTHeWezJY/0lGmSat+ALexDCsS6faZ7+I0Lygicb8kwUrlCrFq7bvZtoakhTSsz77U4MpsM5V02Mxp4b5XzzOxW9YC0S/UJS0bpDGMlB3I7PBYeIAU3fcpCpL4NrhHQpGLqEcs/ETvZ4DHddr4SXf1z5votvt+b8t/xVk1POUx8NaiZ7OcA==
Received: from OL1P279CA0012.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::17)
 by DB6PR1001MB1446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 07:07:29 +0000
Received: from HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::8) by OL1P279CA0012.outlook.office365.com
 (2603:10a6:e10:12::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 10 Feb 2022 07:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT034.mail.protection.outlook.com (10.152.0.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 07:07:28 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 08:07:28 +0100
Received: from [139.22.138.134] (139.22.138.134) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Feb 2022 08:07:27 +0100
Message-ID: <11ed780a-19bc-4aa0-63ff-ca41cc6cac91@siemens.com>
Date: Thu, 10 Feb 2022 08:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.134]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20717301-cf89-40db-af71-08d9ec63ffb6
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1446:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR1001MB144671FED4701196915B97ED952F9@DB6PR1001MB1446.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vmf3q7fk15mAywI77wkfyHXzaX5hK9Xq+yoZTs98gLoqygYYaODZ1ibS88N2mo6BJUuADsufkYfMWBPwccFbQxVLL1HP/6hFCCxRvWnvxm45Cn0Vj5WAdiPslb9HZL2KGWXtW7z3zwJs8npwJ9kPU1nKjZ2i6iOZAFD4DBYvvUQ79mFG3EWxS3JZBCzTUWOjvXuFqqWJzXXk/jZNO6yDZeMrRqmh02D5svBFr8Ifi4BLyRS1B6kqELqC0oNIyX0kV0Pg2g6aeigIJvgVNJYEfqGVAZ/YP1sxGiYG4+3UfpXDgbntjYAnBfL9+jR5WXf312FIVJk5buWurVQoEj27bb0XNl+03ki7wqT6tuN86s2GvCtb3sFJJGN1oOP4GB3ahglmhkn5lZaMuaqAmkejm/VqREA6En71ABwYMWYod/Wl1VSgKf5LZKQUQ/entqVS+XO4e75Q6FcKYotcccdTJ/AQh5/vmXD4eeaJ3rNojk8+NH3EyeUFLjbTglNEAgjv7ociBQJIlgnm7NTz2hT8SV0puxV3mS4z2wuD7fCr8cY1Ih5jfqT2V9xfZ/Y32uY7jRhRHYx9DD+aWpPj1USpvCfcRjNaDfBGknSgmYMQ5JneQlONnYL4WrHu46z+T4C25DVqJQ7MrDERGPNGHNqhQOUw+1eEqHnSKOAKdP/gV/P/Rqqy/qNHd7LkfapVVyen5ydk95C6Ruuj6ka0PSVmzQLNdSYD439jaR8lPzxKUU0n5orfjxjcWEAN7q61brFl4vgWOpodLLBWEKDW8kI9Vypj9QAZ8hmsYMRQS/pcmctMuvskYHBFoSoF0wMSsQ8YC4hJbl3ok3XJ8C/A0HPvq03IKRSjmo6eDp/e/FNhScs=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(44832011)(336012)(2616005)(186003)(26005)(956004)(40460700003)(4744005)(2906002)(86362001)(47076005)(316002)(356005)(82310400004)(6706004)(6916009)(16576012)(36860700001)(81166007)(8676002)(5660300002)(70206006)(8936002)(31686004)(966005)(70586007)(83380400001)(82960400001)(508600001)(31696002)(36756003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 07:07:28.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 20717301-cf89-40db-af71-08d9ec63ffb6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Feb 2022 07:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7589

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=2&day=10&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2022/02/cip.2022-02-03-13.08.log.html

* Action items
  1. Request private KernelCI branches for CIP maintainers - patersonc
  2. Make TSC motion regarding linux-4.4.y branch by CIP - jan
  3. Draft press announcement about 5.10 release and 4.4 self-maintenance - jan
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

