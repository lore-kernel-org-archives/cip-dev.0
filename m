Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABEDC6370D
	for <webhook@archiver.kernel.org>; Mon, 11 Apr 2022 17:18:01 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.46])
 by mx.groups.io with SMTP id smtpd.web11.32153.1649695377259159331
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 09:42:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hTAz7lCE;
 spf=pass (domain: siemens.com, ip: 40.107.0.46,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeJrMEK8SCw+RE3xSvFNXFWxuE+IE3ylnvw02JKZu1SHxC87J+uAUrCjXiTqJqeW+GIBLE7bR+PIYMgpFDyl0KQ8+7B1/8zhPZRv2KJacGMoaFSnwy1aRyaH2OPlJMnjye4jZAWSOXr48ytiqQXYhtiGwkUh/Hjb7DMY0KSh5paaj2LQ4LaESbH6x4uBLo5NpG9r8yywd45FyW+OSLmaufzuICGMKo3g4jRuVNJosQhVjoREOpyjxvsE31CUZ8HbM75bomQyNY4N0pct3xNUALNzdjml+0thSsrc/4mvmwZycG8T+hQX/QJsOW8XClUJl1JsFDLwxhonakNNdpXUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfcFfUEjx/+22tSB5Su20KXbNutoBln5e4Klb6PnJFU=;
 b=csfBrHRlGKDY5sAC5vJadxdiCw0pt8UIGIlqbsT/rx30ZJOMS9ZVpV/BgJKzGhlgzfOBWyo/7wKlgSamNLHk+EJO/jPKj9xxtReWBNcMRetHoInao6YQnvm/twXRmOHd44iRYFeY8e9hd8lwOXfnevjMuZrRupbrhoz0vSYWH+m5fdEs6N/JVT6gVNI/5VMZbpSBCQfCnocGZ2NWgk4WzATdzJ8Xo7330gGY+/UutpgCm9wNWr7tfTtcHjmWi59d8wTv76RxLmM/APzYtn+rRb7it3kbYH0g4MDy63Lq0jbb6irherDcxGmFH/uGPt69KPYHyz306vJ+tyoIWGCbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfcFfUEjx/+22tSB5Su20KXbNutoBln5e4Klb6PnJFU=;
 b=hTAz7lCEG2lnx1rLxwD4dXpGaIWFf2HFd8MD4IerZVkeSusFlHpdYCunSQyp792zksSVmDP3kj6rnLh527BrQbBapmYoEQQ+UoG6nnnbsm0oZYc9QxSsneyhnbcTJpU/irs2hq6+Hf+8sNo8S/1xdL6zLiiHmo5qC04jp+ROYazrNieLNCkzwhFTh15SKiB5J1ZGgL/aRVW4Pv2GPmP5S9nNGtxwvwiirnkTztz0TwzcJq+ZWbu5sgGJu3CKXcLnG+bPca4svIWsFC09T8PuYI76JHhLGKq3t1VdT60g87G9ZuPcKAJlcxPF9w6PPD1cJ6Jl4qNMmZ1MILb7y0IwCQ==
Received: from DB6PR0501CA0046.eurprd05.prod.outlook.com (2603:10a6:4:67::32)
 by AM6PR10MB1925.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:42:53 +0000
Received: from DB5EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::9b) by DB6PR0501CA0046.outlook.office365.com
 (2603:10a6:4:67::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 16:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT103.mail.protection.outlook.com (10.152.5.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 16:42:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 18:42:53 +0200
Received: from [167.87.0.22] (167.87.0.22) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 18:42:52 +0200
Message-ID: <d0d3e2dd-9392-9a0e-515a-73191bbf297d@siemens.com>
Date: Mon, 11 Apr 2022 18:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Fix 4.19.233-cip69 kernel recipe
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.22]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.149300-8.000000
X-TMASE-MatchedRID: U06Aa/vFA2RzUhUGDp9t1G7xXiWN88ME2KBFGySUvAwD2WXLXdz+ActD
	Hw9RrCNbB/FMznsE8cM2cXM415/krsspjO0Eu0H1HXzNfyfm1EFNfs8n85Te8oMbH85DUZXyYxU
	/PH+vZxv6C0ePs7A07Y6HM5rqDwqtphqcSheXOXXT4rxu/TrqGbYiaBRa+pFFH/WtuvxvXmIy0Y
	gzprcmRQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.149300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 852CE9887408DA37A5F370CACF37129A9668D300A0FEF318CE2F2E517FC78E7E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f67087-244e-4da0-fb76-08da1bda52f1
X-MS-TrafficTypeDiagnostic: AM6PR10MB1925:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB1925F6D7F1F468D43F05542995EA9@AM6PR10MB1925.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KskxQBf+KBsyFVYpC192etcZ6tv0HOjof3yVXY5A2cHnKeyRIQ7wQJHpLZHH1FLynee5ih9q+b4fWgh06n84Um4Yu9MafpUVtfpw5ng9f864+f4FgGaWYiZYaB9PAr0lsRnr+Pz099onqB97yhVyC/+DDt/dk2NoX5175BvVE6FssgKXWfBVmgR/l4yi3SM0F3GRHETGnlbqqCsTMJgQ5qgC4gqqCRCFP2s8xRba1tluXqq+d7tDSuwOp89obaNzpR6uvgnRA9/JsduAoaSav9z0Pa/KD0brCpuxc/oS0FGD+UlYGtO2qKPbEHZcCbZ+MkvtYG3RSR80wvXGTWLqdJYw3Ei1NNyJbzg02f4w9xXM2KxzuIRkwGR9SI7ZuLhkl3e7DpR110I7E0muRAGhEOhtScPj3QvxLJcU8DY0MpDzG2qdPUH+aXgDvwuYIE+ADkxpYlSvb9AGrffJl0MB0h5rx/52u7QjkzEQyTqQoWq8+ZwUN2zo6EPBFedyknfDR0ZVAAIRmqIW/f6i2b5fU5wV6lu1cMtIw8BXiwgzqS/+E6AquFgkWuIQzEutva9OpLrOMkGNeXlQIkaKI8Db2E8sf3IfvpZeAPgNwsCdzELpcqtRXlQ1HGGgB+vHUNuN0/WVebyV3MWaAQA2yCFa54i4FKEq4+9qgWzk59KtGv94myxULqmRsZZ3qoefF93gEL5U56lC8vLkoJ+LCL9j+Uc8KoUMnMh+buHSFkZVqIhbcYAIymCaG1wVIqHXM1hWWLIfR9JksDbkTZ5fMiDdOQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(16526019)(186003)(2906002)(83380400001)(36860700001)(26005)(47076005)(81166007)(356005)(82960400001)(336012)(956004)(82310400005)(6706004)(6916009)(6666004)(44832011)(508600001)(16576012)(316002)(5660300002)(40460700003)(36756003)(8936002)(70206006)(31686004)(31696002)(70586007)(8676002)(4744005)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:42:53.4132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c8f67087-244e-4da0-fb76-08da1bda52f1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1925
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Apr 2022 17:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8026

From: Jan Kiszka <jan.kiszka@siemens.com>

Was misnamed in d8705169c831, but this is not revealed by CI as bitbake
simply picks some other version.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

If someone has an idea how make the CI build fail in such cases, I'm all 
ears.

 .../{linux-cip_4.19.233-cip69 => linux-cip_4.19.233-cip69.bb}     | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.233-cip69 => linux-cip_4.19.233-cip69.bb} (100%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.233-cip69 b/recipes-kernel/linux/linux-cip_4.19.233-cip69.bb
similarity index 100%
rename from recipes-kernel/linux/linux-cip_4.19.233-cip69
rename to recipes-kernel/linux/linux-cip_4.19.233-cip69.bb
-- 
2.34.1

