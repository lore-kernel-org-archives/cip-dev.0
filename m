Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4EC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 14:39:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.50])
 by mx.groups.io with SMTP id smtpd.web09.11267.1639665592896027735
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 06:39:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WUf2KuCD;
 spf=pass (domain: siemens.com, ip: 40.107.21.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwNQ1uCvr+t45h+EJrjJZuzRSaZy5hpYGWVhUhk2yuw7ALf7A+agoSkfuD91RgZj8dbDt3p0ZnWLNglUXXfmjtrTJ0rEtbL69I0J7EPFPlaix7haCbNrQ6zGA030psqLVo0l02AhLMT5TKaxrWcP8AnksJGUlENkdD4sK6foYP0L9lUJhIakCG4TKvnxdL7d4awc0ylxQBbataALGyca2MDA6KSRzZV3LJbskHfEgzpbMSHFy8vw3Ht0ltKFT4dyqkvI6m4D86rzc5HYm2nnxKWi6LqrnQUeMg5pKLhIiKF6/agg7xkcITSilYASOOzHwiXlneQIu6UVQer/kIZLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWhOF4jHei7PHSNdF5OsThtluU+6p0aUIMhY8V8g07U=;
 b=L8FIVe9I1Mgf/rOxOP1F3ik+hbn/OFGj5ModMULEUd3EqGd7kTc2WH4vfVun2OxdgXCeXGiqK/QUUw6WbYpqS3ezSejv12SqNFy9kkC8z66zFj4E/n1wP4xolENhGqBTDRKgH6hr05wzu04aRaFHvzyNzl3NHIb4hUPCTHKIQZ5t1GBBRVe/YO7Z4OzdPMDLpcn9bleST0EKYCVY3EvUIMe3K2Uwt8L6zHbcOGE8FXco+6ACCVdBH5XCjr94VPbFcfzKTqLLalXIB5ScCfkVALUoa5G9UOwjpQNA2Dan61+sgNOdbCDmApLK83pzsCrCpP/dGtir6PBHdqEU+Wj2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWhOF4jHei7PHSNdF5OsThtluU+6p0aUIMhY8V8g07U=;
 b=WUf2KuCD3ES52fYomhcRuBZPRxr8mjAkXb0F0Q+B04btJT0Z9nZc2IH1T+hSIF4xEySU4tZsgow2a8v80baFd00A3BvsNZ++vou/5Nd+pFLUG4vtLIyu/s8+TSaRcMIZQ684m14jYFFCnvH7D6vIBc338sEBVpBahIO/PgP0N7z4xaejnIa6onbhpjVjEcro7Ofj6vRH+mJdON7Q8J1jCf7nhZkwVXuOOgtQTjnHWapssJOtJJpS7mEKnVsR13jGtdZvAGUozG8M5TqefQdv2bZ+KhMhg0bzlyqGihEixwt/PGoOu0kIq86XeYWchAumDKij13CXqw/rT4TPRmDdIw==
Received: from AS9PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:20b:488::19)
 by DB6PR10MB1606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 16 Dec
 2021 14:39:50 +0000
Received: from VE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:488:cafe::54) by AS9PR05CA0011.outlook.office365.com
 (2603:10a6:20b:488::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Thu, 16 Dec 2021 14:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT013.mail.protection.outlook.com (10.152.2.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 16 Dec 2021 14:39:49 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 15:39:49 +0100
Received: from [139.22.140.88] (139.22.140.88) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 15:39:48 +0100
Subject: Re: [isar-cip-core][PATCH v2 0/2] Drop Stretch support
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
	<cip-dev@lists.cip-project.org>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3111ea6a-f162-0ad9-0cd1-1228cbcbd01c@siemens.com>
Date: Thu, 16 Dec 2021 15:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.88]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7fe63df-a7ac-480e-58fc-08d9c0a1ea02
X-MS-TrafficTypeDiagnostic: DB6PR10MB1606:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB160683074E19A4685BEADB0295779@DB6PR10MB1606.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	j2VMkJPH/piQ/P1tKH0wuxdcNiVhV20hOslQ1ullSQp1jNZsHwqnG4uj2cKOsGAlKIbjiIJvMHsXUkpUW2he6pwWYUgNFr/k0Hy7wDyWkggmbJ/d+NCaO8hMinuFR6vZn9SAMCsfuaCFzh6jQAxHQbLEPLC2fY97r8o0L5xBSGZEO00yAJcUC/+0wNufuntzQGDkzUTpuu9NkTmSjmw9CBOurFUA2Bui+XivojchPeuMVJEOg12/5VMK5GcigbGTZXdace5R7rPKeqo7oK6ot+mQMbpMW7lfd+RpvBj8XM4CmpRgZjfJ9y7ECNQhJFgCgwwWUoccTNzfd5jI9t5kCnV5yoSYb9beyOJdlTud3pI6t3yIBlIAy+/iNK2sUKMMfrEczFvjQogKIBQfKWwtXAgwhWdG865Tff3Coa5oQFt2d3axKCKtQJkd6r7Q89GjK3MG+bbk40T53suEUDgVo7vfSCqpG3d6YTGJFvQlOJ6CEUvYO8sEoEDgrLmN6lUzzyCckzejJY3pq0FZ15oph2Ab0B/HqKyN9oIsVyFM8ua3oocv+qcJ/YHS5LP16s5vWWbQqufsLpdXyrDeMzXOJM4uOg9o07GYO9avXATQZ6iN3IfNMXdtLRtuKPf/PKdanPV+GLXPMlIIqH8NtasFv6QaRO74ZUDq+0o0zy6MFe9Dc5jl2WupGRm+eh3IVe4D4caFajI1QKY4hDXsWohY9BXuxobQOF6H9NvAybURI2fhfplw2s7+AzrMNEKDt8BDtENLeI3jv9Pnlw8wTJCy0nkE9qIpt1jXOkox7bI9nhv3qBiKOq6nLMcaIBYuDBBNLT9zrrBJYSq4o3vKQ8Cl0YnzATsgVuTqOPTsWVPB6QCjGAkoV/JtTwHj2UtH2SBxXV4Hc08Dw0gO7yBN13+R5rvdJ5u6SjGiBqt/hYQFUOufc3Fh4n7HV50tdLCaKYSw
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(31686004)(5660300002)(82960400001)(82310400004)(186003)(316002)(8676002)(8936002)(70586007)(356005)(26005)(336012)(4744005)(956004)(16526019)(86362001)(36860700001)(53546011)(2616005)(110136005)(47076005)(508600001)(16576012)(36756003)(40460700001)(81166007)(2906002)(44832011)(70206006)(31696002)(966005)(6706004)(83380400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 14:39:49.7457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e7fe63df-a7ac-480e-58fc-08d9c0a1ea02
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 14:39:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7161

On 16.12.21 14:36, Vijai Kumar K wrote:
> Changes since v1:
> - Change P1 commit message
> - Bring back conditional include of buster patch for swupdate
> 
> This series has 2 patches
> 
> P1 drops stretch support
> P2 cleans up overrides / conditional includes for buster/bullseye
> 
> CI Job is successful:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/430980698
> 
> Thanks,
> Vijai Kumar K
> 
> Vijai Kumar K (2):
>   Drop stretch support
>   swupdate: Drop conditional includes for buster
> 
>  Kconfig                                          |  4 ----
>  conf/distro/cip-core-stretch.conf                | 16 ----------------
>  conf/machine/bbb.conf                            |  4 ----
>  kas/opt/stretch.yml                              | 15 ---------------
>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb    | 12 ++++++------
>  start-qemu.sh                                    |  2 --
>  6 files changed, 6 insertions(+), 47 deletions(-)
>  delete mode 100644 conf/distro/cip-core-stretch.conf
>  delete mode 100644 kas/opt/stretch.yml
> 

Thanks, applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

