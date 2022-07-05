Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F55C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 18:08:30 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.79])
 by mx.groups.io with SMTP id smtpd.web10.87674.1657044493549751237
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 11:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p8lNEdgc;
 spf=pass (domain: siemens.com, ip: 40.107.21.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8p+YToSkOzgcM2Po2NrRakbugRFhsRiCrzRnX8vcCKr1kYDVFTWEj6Z23dfdZv0tAVWhubhTi15Lq0/QEHUbHvGmGh1ZHBqejVYN/y5QH836uYSdkZTZYAsG3eObqVJEqBKnBeWRxmff6ajxGAZc/pzIw+qeqiM3W5zBFeGR5rzLT/4Gua5gIF5Hj6RItUUQJZDG4IVzvfhgMhCTUulcPYSCI9UOwg24/b5jJkCTkMQDWFcUEKSxSKZfTY5ng6fKU1AmNzBr+/6VgENYMdLAybWFKbx7J98NXWpQtMq0cXCOs7IhWCQbWajjEF8+3VnxFosgFdhOFhZx60PMLKCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ppm4Y4QXMCTJsNJBmrYd9Kg6dOldjKRU/iKspyX2Csk=;
 b=edV6h1qLyz2KHJSb0BLsV+PT9Of7jDSVj0eDSxEutLbIUeAwLsPanZWl07WC8DqDlswphbfIEGVEKbVZE2Q+iA8U/YDM+hqyTNVS8LwnHhLs1WDa00DAe2lgIZkWOC1tjALhW619KgE/FXFIozT7rVgus0k1cMc/XUFmFh7eG/e6MKWwGamfzQkyWrCnwRur090PmJyl42JxAFVvOCCmFewdqbXbBLjfTX7MUYvm/L/qGPT9KzfgRoQyJifOvJC+MDhjAT5bBZXSHw54iNahwoJVRcgMupC+0K9QPhpMbmG5R1iv48HJVBrLz3FMFTYwL0b2qnaK7ERhB95hG/Gb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppm4Y4QXMCTJsNJBmrYd9Kg6dOldjKRU/iKspyX2Csk=;
 b=p8lNEdgcKYONRL8RRPou1zPPj0ucwd5xIgCPHauY9Z1da1+xLhQfnlQjQdUQUlvp+oAXq/XcPFefbtrmCV+vzCmkXiY1srTnAbrq8roAY2SaWKVZczyY6gU4a+8fmxp8HYcM+9Oj2rg1IPBEQclpPh+d1QeNtS7KrHqO+OQVuLjFqMaOiryqWgzY99tB7zprtjTrBuajlduGkEbQIgSU4DSagikQuyua+lJOr9OmMaJxy1H37HYtVqi7zdHL8Raej/WvyITeQu2pV12ALGIMXL0En9NvbCOOnQlGhTvE7AGEXbo5DhkhaOaL5DmFp6wm3D0KGl9/Vq5uZYnDbrZvvQ==
Received: from SV0P279CA0049.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::18)
 by AM5PR10MB1841.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 18:08:09 +0000
Received: from HE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::86) by SV0P279CA0049.outlook.office365.com
 (2603:10a6:f10:13::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 18:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT083.mail.protection.outlook.com (10.152.1.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 18:08:09 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 20:08:08 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 20:08:08 +0200
Message-ID: <779f0e84-a41a-a25d-19a4-b8fcd988d62f@siemens.com>
Date: Tue, 5 Jul 2022 20:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: qemu-arm not working with 5.10.126-cip11
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>
References: <8742d63f-0f50-e327-6fae-204c9b89448a@siemens.com>
In-Reply-To: <8742d63f-0f50-e327-6fae-204c9b89448a@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.097900-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiM5QaOxwNGfvo9bHfxDWoibSnGtPuNZB5wC4mcWVH6HR0+c
	rEA4+nhZKsMDWBh/KG8ysnXxUIjx+wtbuvccFRQHVAjxRWP7XBH9WTVChOPp5oIK2tjTqNotPqN
	ie8gbBOto5YsPsbyLXZiwHgq3jkZWK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHb056mCmF00Z9LQ
	inZ4QefL6qvLNjDYTwIq95DjCZh0wUGm4zriL0oQtuKBGekqUpI/NGWt0UYPAo6xvra4aJjG9uh
	TWyggfLj4FtjVIUDqNolofDzEAonEd5hikrcf0r
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.097900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6D3221413676A88242723B904770E9FE83E8D01CC80389212B2EC9C6D296707D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39b7644-d229-496b-f810-08da5eb1514d
X-MS-TrafficTypeDiagnostic: AM5PR10MB1841:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Viq+4w2+7qVqcxUq3jUQuv2n0ssYWVpGS+WMJV49jdYwR6dHZEqib7Oy9GH7VmhtoC/H0eD4VHZyoBRrAh0qgkrvlHOntF0zzWxDbGmDbGsALTMxaGS1v9yNK742UTnqwMfqKmREU1nLC0l4sTdW6486QtQIu37Viq/Zp1qxxOtpem09RgH9IHS5VPIovSb7pWswumwgfm/DvopQUUMIcwCrcSYFclbImw3qHHzRXO0zfrJjIggkh1MAqtVCxOiq8fVaNanbK0Xq5Upr1M/CrSyksKf6h5hMWWg04cIe2zPjr+vFVG00IRjszQH1IzRjP7alw+p2+FC3EGd3NmaAj04DUZ8HHgs1xPR/DCd41iL4VlE5XdF0yxfVXRVcTzDlYNLe1ItXJaoMcyS5vcPA0LLdAjV/EXgCUYc0hbV29AZTmoi+BofSVrvzhp55FHejk+vBxvGoIxxsjp90ZtOG8opxwdHDrDPTxMMMM03TRLvNkC9CEmNnT/bGZjxPpoNJqSJFHy4hYifXL6SHliajoGAj8u496QYFgbdRCg2GKdFY3Ui7IITkOcGIisA4jpNr06OiQrNAPos+7TklwJE7aADNrBkPpEwCoekAZ3KMwoqbloyYMwKBtxBO35RTLVFZ57AvjqvzybLpojIC0BnG8ZdC+rJihd8KBkXjlLHNW8mt/IOlNBBiwQWd6RjqjTpA+qg2wJmJTqWASuEflaDhJh+IGIMvaHgYgZjMSQmTKSjUpr50kGkFU78BmTC4zZLly07cTtW9AF7350IAnOUyINCRIwGIKf2QxQ0h2PLOLfLWgEmrL9WavG9v9SL6w3/EZKjX0cRob1mxjhanISgUNS2sbEN3KyB7XrOvb+ZeVE4tUSlFAdhhtOC20jYZKnx/iCG9F8a7zxlyzASh063AzwDkSwQaYu/D7ASALkiQNNiIaKMYTvFjYA1+vXj6L/HY
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(40470700004)(16526019)(336012)(186003)(47076005)(40480700001)(110136005)(6706004)(70586007)(70206006)(8676002)(956004)(2616005)(31686004)(36756003)(26005)(53546011)(81166007)(82310400005)(356005)(82960400001)(82740400003)(40460700003)(36860700001)(86362001)(31696002)(41300700001)(2906002)(5660300002)(316002)(44832011)(4744005)(16576012)(8936002)(478600001)(966005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:08:09.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d39b7644-d229-496b-f810-08da5eb1514d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT083.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1841
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 18:08:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8685

On 05.07.22 16:03, Jan Kiszka wrote:
> Hi all,
> 
> it /seems/ (still double-checking) that there is a regression in latest
> 5.10-cip regarding the qemu-arm target as built and run via
> isar-cip-core. Not getting any outputs from the kernel. Just rolled back
> from next to master in isar-cip-core, and it works again. Any ideas or
> similar observations?
> 

Not a kernel issue, regression of cip-kernel-config, namely [1]:
CONFIG_ARCH_VIRT is lost. Now trying to understand why that happened.

Jan

[1]
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/commit/8dc2e5a1772c1d7aab78028a8a1db1ae6e6ed9d0

-- 
Siemens AG, Technology
Competence Center Embedded Linux

