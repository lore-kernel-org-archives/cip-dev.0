Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA58C28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 09:37:42 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web10.10536.1643189861433486949
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 01:37:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dcAy9jnC;
 spf=pass (domain: siemens.com, ip: 40.107.20.56,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDqhnXUEecy95ReNcNt9lwxgRIh6MhnXTnH/GOfLYhMfhfDJ/qFgD+PV6CbjeJ9aao8ZbQs/zXnX2bmYzgNSbWUSue8JQZmvXJmZJt/jiYlx00DXNDNTt6MbPTuHNzrz56S87KONkNlAp9cXvORhiIOiP445TT19t46NhNx3MNWe2RUnQjtyR/+khk6GbslkFbE/PCwZkbr5pe/+gFTIhW8G+z6bkgAq+0firgKFeFaj46enOenT8sjTDbVaHnftNXG8Czf+wELA5+GocrCZ4j+TXeNgQakpb3ZJcvpKx4uvj2OGitvbAWLLrJ7OvB7Pq4VU0FplHUoRbgNCgDoIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzbNleoJB3YuJksUQIa9pevFy6dfkkGhfvallkrAy1w=;
 b=jEtCkaz49megDTNMGwl/796G9x4unSljGrbEDfo0vu8gEoHcoj4CE0RXPnxoA16myhSwXEqM8gOcKGKz3Rr6054V3wZri2570vn58aT9lHgdaa+bq6VMQZbwfhRqQZ3gQRVXKvVVHEgFh1hLhZcM+WIPyvwVacWB96gmUQ2odWIJki326fFDoml+myw9cdVJh3KntgGUv+S2qGVlfd+qTj6dN3MkXe+xO63eA7RQDE6uvpk7jfcs1K99Her6hEvgO6MaKOb5b67x9Rb9fJa+cVgOoQ2Pp8TV+dNAgLugi5YjxhPKnFSDsP7l+DNAYPixPSKkF0a/5k+oKmEiHJQrJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzbNleoJB3YuJksUQIa9pevFy6dfkkGhfvallkrAy1w=;
 b=dcAy9jnCR7tFlxL9BmtkWq2756Oz33AReMgRR7lt+Xtz6qMZ+WdxJwXbKwvI3akqFHb31pcN0l1ctfAPaXT5/+cxLyD18yuNyACl/ZWRCm1P1GFTvu3v5MmhsgQFNrtcioRGp/Bg2tOWuNtoT9+VvC8XXYpbB2NrlEQKi8mMAsFNzrFKb7JXprPtwSdaMiR7xJA36oR7+wyr00K2ZTc9sJcxG6IBbmR27yui+MxS3bzht/684hhsgV+KzKbE8pjcAnT0XuKaQYud11tuKltCG1si9AXmrpUqNrruP69dRD9YbQR1Xp0BvXqpNnKwVBUxvPyJ5wIEBVv29kzgVmib4Q==
Received: from OL1P279CA0008.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::13)
 by DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 09:37:39 +0000
Received: from HE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::29) by OL1P279CA0008.outlook.office365.com
 (2603:10a6:e10:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 09:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT049.mail.protection.outlook.com (10.152.0.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 09:37:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 10:37:38 +0100
Received: from [167.87.32.162] (167.87.32.162) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 26 Jan 2022 10:37:37 +0100
Message-ID: <5de7f456-6428-ed67-de99-797058f6ede5@siemens.com>
Date: Wed, 26 Jan 2022 10:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [isar-cip-core][PATCH v2 0/4] Add cip-core-image-kernelci
 building and uploading system
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.162]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b17f5db8-a745-42aa-e9c6-08d9e0af7dfa
X-MS-TrafficTypeDiagnostic: DBAPR10MB4140:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB41404C9895C5DCB5462216CB95209@DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3nE/zweK+Emu24pF22BXACciJllpqznXEFmH/k+6+To0YSSuR8y3h/M+4mhUocUQDjHVNcjNC8PO2zH24HWAG9KvryuCjDUPSlUyu7AgNH8Jqcmn/Y6yyRK483oQJHMyQPJ1Ml/7sjqE6iB9A8OyqykVkMqyyD8mvoSI4LD6x8lWAZO09vuthRCUAd8ILN3ULvmZcw1GAagbr+I5eTU3dnXj5Y3wHuSB8Qag7i3Bp1a7gx8Skbn62jmasrbPrk99we9ho7KT2qOn7HA8/JOeyLvCvLFtfdTr8uTqcfts3gf5wXPIkrACxX1ZfcV4at4x5pmgB0IML7wjA2YsGkY/sK2Fb6xT0ewLkliO/Pf6niwDzSswmt3T+tILg7h3R/I1LhuYI/QiaRNsF769/2IVNGsg/tnsOKcOdFkya85iPzNjYrSEWy7c9BBDsYJg+m108c9HfgsTESOf10oI/R1x7gdMhTYAku/lKApJaCFL9iBWcn+ZhS2D5x2bFzeDPBQ1mxgg/QFZe5Nia9DNa6/MbXI1hKt/HksxtT3emnMXwXlumxfF4w6c6sAQejLArk7dzDHiBa2zKJa0TEdaGKYjsmOER2OmK6iyxDQmBWcvyD/X69Ae0DReGXmWgPjivaufWuQYoFa5CU81mcL1pi5+diR+vC12gW1idXib3XUyv11x8W4hfRnzYAr6s5njRvtoAXlIeyHSC9uf6jWujw8/s5yHmWQ9tQs9gKWXBpDkz3fVxx4aIcJNqFM77fd3ndKgo2cg1mRTHjJtLzQjZl6gFNWPKp1CRdeXBiNF50Z3p8c+v5ESCFRD8UCSTUl/kVxHxm6oItm3bPwtB6RTlE4aSpVyjpQD+i/566Q8Zp67ksg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(966005)(82310400004)(6706004)(16576012)(110136005)(86362001)(8936002)(31696002)(70206006)(70586007)(40460700003)(8676002)(316002)(336012)(26005)(82960400001)(53546011)(36860700001)(81166007)(356005)(47076005)(186003)(2616005)(956004)(16526019)(31686004)(5660300002)(44832011)(36756003)(2906002)(3940600001)(36900700001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 09:37:38.6266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b17f5db8-a745-42aa-e9c6-08d9e0af7dfa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 09:37:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7482

On 20.01.22 13:54, Alice Ferrazzi wrote:
> This patch series add a new image with settings for
> KernelCI.
> 
> This new image is called cip-core-image-kernelci and is
> based on isar-cip-core general image with some changes
> needed for make it work with KernelCI and taken from
> KernelCI image base settings.
> The cip-core-image-kernelci images are built by GitlabCI
> and uploaded to KernelCI production fileserver.
> https://storage.kernelci.org/images/rootfs/cip/
> 
> These patches are already integrated in the
> isar-cip-core:alicef/kernelci_master_refactor repository branch
> and are generating the images that are currently
> used by KernelCI.
> 
> cip-core-image-kernelci as been tested and are
> already used in KernelCI production with good results.
> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
> 
> v2:
> * drop trailing semicolon from gitlab-ci.yml
> 

Didn't you also want to de-duplicate the customization recipe, build 
kernelci on top of the common one?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

