Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA8C4707A
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.84])
 by mx.groups.io with SMTP id smtpd.web08.388.1649699138821392447
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 10:45:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Km57v3m8;
 spf=pass (domain: siemens.com, ip: 40.107.3.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPLxeDUxvLRweFlez8P9OsQb+96QrGUG8NrUTGqlPNcqujGBFxt0awvuG6YlbsIaGAZrNTvLXxOE8KYkb9lXG+psJlSbNZ5Z5p7mBvDmH/GrAPKG+figFv3zMfpmjHzTzmOmnDJCVxvCaNyAQwVK5F8VJ8BxWSBQCAbOK5Hu80auXNTUp19pCQa3wS5/gtgtqPfF1MBXXQhFw5YFy/JKicXDqI33VKebjssQ97Nk7dL4e83TczNzFL1Lnuv/tWTbCFp5bn0j2Dut5o+RmOGXbOQjo3Cme85lQKq4eJs0Z/7dR0v63HzLF5LAc5hn0n1YnAC2F1AU5bxqRK5Usve2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaTpDGe/W0bCZ8ya9BV3UuySaqRVvMXw714auvsVbCo=;
 b=JVPVIgSnxTsCRAZlDUc8KD+6T5tvjoVyeB0kTpgSwuJqHeTAJMH9z2AdGMLwgqaaZAkWkaxwxHZa+soYDZiCwo/waVbylahkAPcrCnRviGY0Rz5l65ut1VHG5HGI7hMnU2KiYksj+Wg/jEjaBoMD/gStZtQk0YF9eBCvm++NZeG1OBMFju4J9T8y3xY5x5dTlIFYpl4zPU1YRO8REirY4Dn54J44dAqfAsxdaWEVZvRPKZCwbaDECt2Xh7GSRNyI61DUmJnOVXEhI5wOhGfhlCcIk755rt13yiks7mu4jwB/G5KcKSof7Mkom6GThmIkNyJ4NMJwQdNc5YBvtHQ7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaTpDGe/W0bCZ8ya9BV3UuySaqRVvMXw714auvsVbCo=;
 b=Km57v3m8b/rV0l/aJShuyOP2aga23gly7LdOxMIODovVYgkMpHryW3FhMpiJYUDYPwf0KgDqpIE3H414NSfEHSqsm+uvORl4oyzmMBIuEcMrHnfkeJaiyO9LHhFZr+wEaW7Mq58TqPoNRcooQokYL7PPnVK/xGmuN+zXD7Th/4xyvNoAX2YtLejnVH5sLCZrCK37g7OZUvRBElif0oRoKnnz5eL/3PCbJlsBcVFzkH5VlhsLVcgU4xJnqmKjz+FCilgacHQRAspqYJRO2bHLxXGylMkMCf4YBDi5J0r+2LUMpHKjwRmIQ/jFnjT7wisCZINlnb1WrIIevBnowDIUhQ==
Received: from AS8PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:20b:311::25)
 by AM6PR10MB3382.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:d6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 17:45:35 +0000
Received: from VE1EUR01FT070.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::75) by AS8PR05CA0020.outlook.office365.com
 (2603:10a6:20b:311::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 17:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT070.mail.protection.outlook.com (10.152.3.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 17:45:34 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 19:45:34 +0200
Received: from [167.87.0.22] (167.87.0.22) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 19:45:34 +0200
Message-ID: <9ab75a3c-e548-ed7b-fd95-1f19784a43bf@siemens.com>
Date: Mon, 11 Apr 2022 19:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [isar-cip-core][PATCH] linux-cip: Fix 4.19.233-cip69 kernel
 recipe
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <d0d3e2dd-9392-9a0e-515a-73191bbf297d@siemens.com>
In-Reply-To: <d0d3e2dd-9392-9a0e-515a-73191bbf297d@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.22]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.769000-8.000000
X-TMASE-MatchedRID: a2rrTcOVXHk5QaOxwNGfvo9bHfxDWoibH7OvhmslZN185pjA/x1xfviH
	64jt3FfEJ5j+8uuerKIs8m1alsmNjRhPwomP1hVVr0S4gY8rBUjeis2SlzEdhD8Ckw9b/GFeccH
	dhPR3x3IL9Tj77wy87GBt9mS7pKVTeoqVs1ZLrvCG184Y5LIraU1+zyfzlN7ygxsfzkNRlfJq8/
	xv2Um1avoLR4+zsDTtH/zyL+gBqiy3HbG2tESnXdH5UewzMDM4Gn5ywdKdcbY9W5CCyNtfVg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.769000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 688A839A813650C70985E7E665770429F3EEF02EFDF40362E2C24BA9D9C62B492000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96cec368-832d-44c7-fb35-08da1be314f5
X-MS-TrafficTypeDiagnostic: AM6PR10MB3382:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB338258D561E3621AFDA3C1C995EA9@AM6PR10MB3382.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7WciOaRQzphZkAwn2EKg1IG9BW4syI/TZCQnjVO0luWiRBtS96jIRvWGGCA1CUYYwqP6MdsmiiRotcNt2yNWyXm0qXUVEHkFWtjDSlcntF8bstDosPCKqnZIUhgwZGWn3GAilwX9Sp4nEnYFfvHkYoPT6ENg2b79MEKEKPrnqYH5d4YOXylWVsPsnmeStvah40kNjm2/cq8Zibd1mKGwylJJXGNlqOwT2m56Qzg82gb58iNRT5M8vTZpYdSOGbe+DH1vnfoqvZ+hUF8/9HfTsTmi1zcXieZNwDmcurSnsILWHzC6dMa9++qrBzb/FrcdMH8Rip38FYogNpRPwqPTQODwwmaaQu3YTMWStgNvSOCZVnbQvdRIqIK4YgnfUiul+yNtoBQ3dM9s/RI0nm/kuo+mEkF6QWlNW0I4wjnIyeaLGMRaqBZiF762YLXspYD1HRV4yM2+J7vng0ufSxVSqzXOyS6fyz+P+hNyg+aPgD1Bqeu95bvSxo4RRN0DEz4iVe3pQHJFz8ErO/qa6EWEPeBHpxzgmyY6LUm8Xo2UxNDh4Ubmn48HZWBMBD7ESb4MhyKzFi74aabX++n+tmIrPvPCKlUb6/F+QvoJClVVDxOE2QrjRSgQApdQTAajKBZ7mLKOMhTFkDQaBkTQ9iJUgtsSAIvCgKmZ2m8oRvX1m+YQ0XkH9NTgaaaCOgMb/AQzzWEg8T1qjmcOnFtNAn/ruuYZLIz/b5uGsaQ6zwk07DAfv1tpplG5D/C/wHzJy1yLxsBjM6oaDIgr9lI0u45weA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(86362001)(956004)(31696002)(40460700003)(53546011)(16576012)(316002)(6916009)(6706004)(81166007)(82310400005)(508600001)(70586007)(36860700001)(336012)(47076005)(26005)(16526019)(186003)(356005)(82960400001)(83380400001)(8936002)(4744005)(5660300002)(8676002)(44832011)(31686004)(2906002)(36756003)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 17:45:34.9068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 96cec368-832d-44c7-fb35-08da1be314f5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT070.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3382
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8027

On 11.04.22 18:42, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Was misnamed in d8705169c831, but this is not revealed by CI as bitbake
> simply picks some other version.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> If someone has an idea how make the CI build fail in such cases, I'm all 
> ears.
> 
>  .../{linux-cip_4.19.233-cip69 => linux-cip_4.19.233-cip69.bb}     | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename recipes-kernel/linux/{linux-cip_4.19.233-cip69 => linux-cip_4.19.233-cip69.bb} (100%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_4.19.233-cip69 b/recipes-kernel/linux/linux-cip_4.19.233-cip69.bb
> similarity index 100%
> rename from recipes-kernel/linux/linux-cip_4.19.233-cip69
> rename to recipes-kernel/linux/linux-cip_4.19.233-cip69.bb

Strike that, time to update anyway.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

