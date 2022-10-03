Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB668C433FE
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 08:10:08 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web10.16500.1664784602327060329
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Oct 2022 01:10:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QGtQoT6e;
 spf=pass (domain: siemens.com, ip: 40.107.6.66,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD+fyx9Bl6y9GCxmYCrcro29yP/eyi47z3NDFAPPjrSnPuOHl9Jqf6NZddpeH54p19lGxDYvvL7Jh4oiR44YpWkdD1tsBza1qFsrQdTjNIZ0vFDqHxAOUmwoUnVsXcHDAq+brpMLsHN1+xj4IEGnZLC536aKtxDSRP7fMXo1V6z/bMfN7WTFzmsRUF6tfU4Zi8y86dczHOabpCdumecYiChIdxkhkniqnu3QdHFV/1IYPzgGkY7ikiykFsI23OlijeLv2/5dbp8oK/74Fskvj1QzTnplMVHBomK0E5Dr5IVznX5Z3wzqtJgqVhi5TI9mU/VKm4WngP+93nsx8uOlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAiictEhNZXIbGxavjM5XFnziqxnbKHtbjLYO80TjSg=;
 b=AnjZyNtrGPcHv0CHF6WpmkqRwjod6BxU+0tn6mIt+qwet7ZVL0Tmx6Lqt1pILzVEbY+17o0t10RcdI5AYWay9CbQXUA5BkzuUp3M49Ehtbfuk52THXcQhaIplPzusWG7e3J+SHkO+PHBq+Hu5qhUZ89d/OvkTEfcCqwPKtdajByWOUCcsz5txCtYGKQmc5OFhzlS5o7ge2xMBXHSkB/x8zzANf8FzCviqsiwEenfEPecPrGsIli/vOtd37yNk/Vb0WFF/ENM9i7geuO5qYRn1Ps+mEuEmGvsK+DFtoZryhJDR3JWlTTnbp0Sw46n/59gOlyvICggZfCVR2XmeOur3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAiictEhNZXIbGxavjM5XFnziqxnbKHtbjLYO80TjSg=;
 b=QGtQoT6etjl2j62IOefwe7N0sPc8i+FT1TfB0XFZQbvK5Gi96fYaCv9XSXuyzBQ1NyroLKHtlFE1t+veN45VLhRfSZJaTCLORvueiPg8opm7PDz8aVk+/TbX7pIUBKZHjdxmw4QfUbWueiPZpuGulEDL7Zybgb80YJ2zANeJC7GO7NboTzdHw6vF1AyWJx5oFfs7DW7JXa2+yp71QqkwJwpEG40B13RKvIBIj34Hsz6iCPBHc82NRBCI3Cq2sEjPtQ/IXJS3eMm9GFp2vUXYjL0wvgffg5NwH+JXn57yNmSSK9IsnIwlDtssKxgVxuWTD4xmeGD71RtJBiGmTVKKKw==
Received: from GV3P280CA0108.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::19) by
 DB9PR10MB7412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Mon, 3 Oct 2022 08:09:59 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::fa) by GV3P280CA0108.outlook.office365.com
 (2603:10a6:150:8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Mon, 3 Oct 2022 08:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 08:09:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 3 Oct 2022 10:09:58 +0200
Received: from [139.22.143.172] (139.22.143.172) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Mon, 3 Oct 2022 10:09:57 +0200
Message-ID: <2e7cceaf-1b0c-e62d-1910-bf8dbe25c864@siemens.com>
Date: Mon, 3 Oct 2022 10:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Status of RISC-V in Debian
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.143.172]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.693400-8.000000
X-TMASE-MatchedRID: B6KhYplEuGfwbz2eQjT6MOz5F5v67Oj3pjulPTq1lMgFxov+3JYvY58z
	6yZBmpaQ78BlMFOIM5kSNHj6zaP5xGpXfRDXG1/z5hbLzcHLb1aXbmjEpvtB825eAiqrqZDK9FT
	709M8dJin7m/OxjmYo/D+6IQMRxU54vM1YF6AJbZFi+KwZZttLw0nL7ev9Tv67CwO4a7b14b6C0
	ePs7A07Y6HM5rqDwqt5ClcaVXxZHX6O/tr7JQ5QQz8OWJmeYyIFa3BYwZLezeNv/iUMc4FGw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.693400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 4C7EAEBD2327475066956D359457FA30A95DEC2D80000C428EEB1F452683DD872000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT019:EE_|DB9PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb23b6a-f552-4414-9e2d-08daa516aa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/4gRwXLjef5NRl2R0gwWR5++GVqI5j6ku3mdMw1ucrEmVNGLvdraa2ixtno86RK8bf9azu1VyayvinH2j5mi8tlr3oieMwvjHMxbr4PLnqxYKoVbvKNEaM4RA954QvYD6Cb0uHfZ0Uywvvl76lbHl2YYl1JpnlfD5620YfOz/CabpAarSE8utTYH3aH2NyJc6i6gjKRTOYY+GNrQwnnR4cofghiMXHOoyl2VDDCfAIGFpb5k4/Phs5EJk0L9VQIDoph3WYGUzft8VQHp4A9AO7BLsQrOIlePQbtBgR0ZE3BZkIyRzdMtlgDWNhJTYUhFRQvtcl4O0YpXGGGKuF3/rTffDAOOEMlwt+LyxLFxEK8c1yLeZ5KmXiqQMBJagcvRYvDAaPWH+YYSarVMQ32GQ9MRo2jawbw/5RKh6wFcYdKHL9roYOWZl2ytIjU1t3gWZrJdeVuf8YPjZGagtJkwuDF+7B0DdTphl4ImNPKgwHYobFzyE2n9sN+wX22EPeMV6Iep+pP0gFxp8BGF4cXM93XL/LpeDQUPlXv+7EiGJj3FkG38y0sjInDr4UO2AkVhNT+SbATGJr1aCYM6mNX/5buA5GReHuar/zC/LZcTM/O+tjLsXbJpK8uPJny3Ox8ON/cs44D52ZNQRNRaBrKBlMG1lAIgoWQbmJ8qshqcMMJTTm0TqcPBvadhsJiXywVbbpHr0CI4cFDF0+z0wM1yQGG3uTZyatH+SRsRHw9hE59IDwaFaVwpWC3HW09vimym5JBKVJHtOxsBZfiOjAUjI+pT87oJcaUMRmFGJj8f0Ua1isfUc64FHoABq3Sd4Pa8o72tCiK/wqj3PynEXap9mKAQXaDkJ+QUf/WSPggn6iMPYsBH3LHnQCxTIflRyp7Utav2ybKcHiRfYa+yv8bA9g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(40460700003)(6706004)(70586007)(8676002)(70206006)(6916009)(40480700001)(82740400003)(82960400001)(336012)(16576012)(356005)(47076005)(82310400005)(16526019)(186003)(81166007)(316002)(956004)(2616005)(26005)(36756003)(36860700001)(478600001)(966005)(86362001)(31696002)(44832011)(31686004)(5660300002)(41300700001)(4744005)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 08:09:58.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6cb23b6a-f552-4414-9e2d-08daa516aa0d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Oct 2022 08:10:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9612

Hi all,

worth to read (also those of previous months):

https://lists.debian.org/debian-riscv/2022/09/msg00012.html

In a nutshell, build hardware is a key bottleneck right now. The
preferred SiFive Unmatched was discontinued so that only personal stocks
can help at this point. If anyone has an idea how to support here,
please share.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

