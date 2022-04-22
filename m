Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902DC352B6
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web08.5056.1650606486012438468
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 22:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yp410EIi;
 spf=pass (domain: siemens.com, ip: 40.107.104.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgZisexkxuo9DTuarV035vDnl5Y8pWgZeKkz2Wao5HRsdW0aDowV+Rq7afsZ+YwqbW4j9nS233OuKl/bksxMJC8NaYJ6m5wjY2yTMf8Fhs1Fo2/CUVe3OBFikiGBC5yu47ThDdh+NweNMeRa0G5xGLho025S1eEbqgYwVrVV0CG5iaC2VnkY2f4HJiPuB28JUzb0qSla40/gl+h5ugUMFdqTfO2R5WoybXf6ZNWSeIgEXlSIUmglclysmfSAtqEmJaRl9Db7P43ZrnD8kX3upgLmS2xIKDKlRAacB+c10mQ18D4GFvWvqy6+uekGPKE6nNfkPos5RrgjjsCjkWUD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeAdLqBUKhEAmx6+ndMdKVidXe2lV3gGeUvIHzTwcIM=;
 b=NCpQ3B5M9379DV7Clr4BcyRk2jWDny39bhCsZeKwMrjx4258CAsldGer5pw3XSoPHnh1s9Hy1oT+aovLbqhVF/MiTKDH++9nlj8TrTm6JhhyH+GTb95ZHBszYi0EXDbT6FhvZzSkH5QtfMzIcLEldD4x+6uCbXBt5Hz6CyBzWyBDEmSSgqB1IQMmSWpFryybviO/c+1vC6tFUzAxZrMqyf1KBgeWEBcAlA9WFXErZOYgsGu1s1eLLAJ0mKon5zBz0j0cA893TVBUrl3JlUhvel3bUeRVO+txrbxVs/MGDEMDjSQYp7BfXaWNIiwf/8KnwCMQAZEez1CE+0mPDmWAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeAdLqBUKhEAmx6+ndMdKVidXe2lV3gGeUvIHzTwcIM=;
 b=Yp410EIiUyG7JwDsNUIRg1PXYAxsO92fDr//jYLx5QXE47FZR+0NFxZPsSUg0Y7393lOImD1tv11soOl52atxA0XZP86RrRDvtjZQtm7IJjWIoXu4dRPjqukAYd2dDYAslqA5XsV9iq74Zl4L8jPFARYzv87RjRaaYPEu48Yjn8vOBBIehCuaeoOaNqVTmqTAaSUI0wgtlKVUR7VU1auWcJnHJ+f3wWcfw+NU2nmms4/datlGw2NalA67GVvCObJAwTub0Obo42aH7Sqw54go9sVQVTNoBgb4YQftuZaiCfTG0HkNB8HZpMjXFaVUVGEc8ra95yL4OdxfadU/Eryfg==
Received: from AS9PR06CA0402.eurprd06.prod.outlook.com (2603:10a6:20b:461::20)
 by HE1PR1001MB1020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 05:48:03 +0000
Received: from VE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:461:cafe::79) by AS9PR06CA0402.outlook.office365.com
 (2603:10a6:20b:461::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 05:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT015.mail.protection.outlook.com (10.152.2.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 05:48:02 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 07:48:02 +0200
Received: from [139.22.137.211] (139.22.137.211) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 07:48:01 +0200
Message-ID: <962465f6-8d5f-93d6-1a51-51658c80e167@siemens.com>
Date: Fri, 22 Apr 2022 07:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
X-Mozilla-News-Host: news://lore.kernel.org:119
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: gitlab quotas and linux-stable-rc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.211]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.163900-8.000000
X-TMASE-MatchedRID: QgO3wnaYEb53WKlfFhapwv0y/zCScxLti4F4IRlS0JInTBdLg83j/1tX
	gpRlmDcoS1xpm8wQIbLnO0Xw669hMDnpSV66h8LNXceIjcCAYPl3GG3gHRhx115hVZTm4dD8DKv
	LdahoIESbKItl61J/ycnjLTA/UDoAA6QGdvwfwZaX6AMUixGku2rz/G/ZSbVq+gtHj7OwNO0PXZ
	PurZ0hS9edcd4L1CKrS7q3Bp/4+zFRBHA05COsQkDhRYyz/Oi2
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.163900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C98B8D9B4608EE24DE867F048CE227E32E7FE617FE2F2E9CFC8F7D05DF4E97662000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e3e1a10-a74a-4151-72a9-08da2423aa60
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1020:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB102084ED84FE6444F85704B295F79@HE1PR1001MB1020.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tbVspc3ijuf0esy4/yvXrsSqssyahxcjUWOJ5D0leKXmlXhwMvvjEVivGYtvMj8AfCZ0gcy3b2VqXM9Mk4cEGqrjRO0a15WGXhlZelJlwO5tO3gS2iGahkNokDp2wNWp2EoqOCWWwU/D1b7OWXjX7V7YS9g0axsHCz1VkytF+D5kkKvJMOWCy0ZA3wAAqRI/vyX4qNopkzCzYvJ7kAaDEQjNq2XKq+KdOd6bZAg+qsaVw/1wuQdJa6g4SKWzCwsZSJ2hID4TnTH/RJ424nBbv+BRkD4XWHvQ2zgHT/hpM7qCID9MIfz+It/U8M8wqQoo63uPR+rPDqmjAK4QWMH164xDRxyW4+tRn61BvpZTjey90c0oiUDdSi13IWBI2NTMEO9ZAkWstI61q0eDESUt3Pd6eL+dRYDU/WQ97xGSVP0S7nbpHLK/fyV7CrndU5y6NxzPcNHWoYJBWSTqZlpH5vAXTidg7tIYYtmHmifGSNLTvjSYqB7MDkpnUtnSKQuVkba02ahs6TAf9w6DLwku82VFeNMaRc+C3cw7g/c08McSXa9GjdjTJmmUECfpNLvTteTV/qFhnwViy8I5ZyE+rkP7M0e1SBoRanpfoi/621fhyfcg0IbTA1gehacQcNhsssBqwZSLt2RVyS06GjGHUVXA0f6ZhOiBUpf/+tiKoqCRZ6+RRrZOJahsaDlyh4p2OmObLhJTbssFAU2zznF/lu6UeOG/htD0L6mhqGNMvT0aDDAaoJTgaDzapSwWc1A880NYKzZlP7Vz7AjpXEXQMDcN2j+6ck9RfKeLqkiVy5WENcc84B/eRGaNIiTPr+VN+MDxv7siJlN9b9WFUcs2Iw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(5660300002)(40460700003)(558084003)(2616005)(16526019)(47076005)(186003)(336012)(44832011)(15650500001)(356005)(7636003)(7596003)(966005)(8936002)(16576012)(70206006)(31696002)(70586007)(6916009)(6706004)(86362001)(316002)(82310400005)(26005)(956004)(83380400001)(36860700001)(31686004)(508600001)(82960400001)(4326008)(2906002)(8676002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 05:48:02.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e3e1a10-a74a-4151-72a9-08da2423aa60
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1020
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8173

Hi Chris,

seems gitlab still tracks linux-stable-rc:

https://gitlab.com/groups/cip-project/-/usage_quotas#storage-quota-tab

Should we simply delete this project, not just the repo? What is left in
that project? I don't see anything.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

