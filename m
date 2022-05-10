Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435EAC433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 12:21:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.50])
 by mx.groups.io with SMTP id smtpd.web10.9012.1652185265790199476
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 May 2022 05:21:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qPPtuITg;
 spf=pass (domain: siemens.com, ip: 40.107.8.50,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5LPs2rdUHBQezaSEaz4bMejkwwSLhUFqsUNs8Yv2NX4ENf9yyfJIqn1T3wnm91GpkE+OC4Cl9sunRH2Xq+uTrh9h+1BXWgmm6rReF6NPNz0/OGs5nAimf9q8dQqZubLX/BVWqZiBsSXpEGPG48lSW1CaQS38Dj4RD4zZeRGjjaVeIdPzKRvIAE89CaFNypzV8WNtQb4pSG0j50dTBhJgxBa9yPlVyiL31p0u4PvKw5u1YjnzdfjIu0S7KjoWpijjncUuitBb8ailmxODkO0Kx/aACtG03Ww+FXpbdHrKVYPiwnkA+eN2KEc0r4nZVDk4+kbM9ZHgOpXhYa8dZhp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCg575nHQeeEqAMNZvZuMtQ58kfZb26T+4mrvIs4/YY=;
 b=Gvn57EHUMj2arq+KllPfJTGNoDMAQudNp8+dN5wbypjeOp65yKyhOhmSf6xadsICgA3ZKBafniIuDC+yI3Ocz32MKtlqDeK9k8szu+IAhajdaPD2vxlk07I33QdOjqSam1/A8MM0cqNUahAZju54thgz96cKhUDdsaYFJ2IrLkZ2llRAegz/UjsrJ9zWOaYjSTAGsRUtTBQWfBPP5+j6uVk/7lh+Uow256Pm/QN5UYDJVmoCRvTw0KgHlpsvXqzqFtjZubwBqCaQsms7ek6c248MWhyaJhri28wI1TYOLuanQelwj7g1oY4USvk4x2htzS5AfBPpcuxahfP0HcDOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCg575nHQeeEqAMNZvZuMtQ58kfZb26T+4mrvIs4/YY=;
 b=qPPtuITg5hLrCWt8P1ucQ4wk336uj0VR04sxQhjPYmrkYM6JOh+7ROR1ggfv/OsLtqTchY9JvGylt2nnQRR5QTUhb4GfBzn4HOhsGg8nMXlybHXGj5OtCfJuA4ahob4sCLWYBDh8Q+27qry1s9vSGF2fFe8Va/hb2BucKVvgZOgrwI3Q51LX98VOOYhipyJJmrn68kVVnd2Kjn3j1GFxO7XwEFwdzJx/IWkddDRvoZ6L4H1kJBdQ9Lww2CYV9MQ64GFC/YibA4KFfZLMJIteufagY5lscfreSlXqka/DB/QHTqxUGWiEBtEhCBLX005FM/JlxVyxhdcPFNf2Fbjgfg==
Received: from DB6P18901CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:4:16::16)
 by DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 12:21:02 +0000
Received: from DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:16:cafe::3) by DB6P18901CA0006.outlook.office365.com
 (2603:10a6:4:16::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 12:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT062.mail.protection.outlook.com (10.152.5.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 12:21:00 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 14:20:55 +0200
Received: from [167.87.72.34] (167.87.72.34) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 14:20:54 +0200
Message-ID: <96356bc9-65d4-ac2c-a0aa-a7f72366afd7@siemens.com>
Date: Tue, 10 May 2022 14:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [cip-dev] [isar-cip-core] cip arm64 build breaks
Content-Language: en-US
To: <Venkata.Pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: 
 <OSYPR01MB554240252AF3065DB21B6004A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSYPR01MB554240252AF3065DB21B6004A4C99@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.34]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.068200-8.000000
X-TMASE-MatchedRID: XYZjbEcsSe4wrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0aOtWfhyZ77DlvQ
	xoz1O6zP5DJ1FS+XdBO04vzFLkB1g7iCYUFPl9B4NdOTnSYE4m/qxcmMNzMKOQPZZctd3P4BurO
	lC+PL0QBT57wC03bQsR/8AjnXlbL5WFwNJfisIv3n+ZInlqp/My8oE1Ngob6l74lOop8Led/zZK
	DA1/pIrn6GI3uK7g9ZCbnwpPijjXWWkqk2IvguWiAFwbhTQBBrNtywwIf5ksXNLuo9SGsuJi6My
	Pq4TWG5tsxVqq1TeAWSLvAQjXykCkGPbm3tak5+kZOl7WKIImrvXOvQVlExsHAruZnjhopu+gD2
	vYtOFhgqtq5d3cxkNbT1o6X5fhsHeDwPIR1xN9CoPBYEeRd6+cOXOsimCRhkMfyYgsII1vo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.068200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 987BAA1EC4C80081A3AF6149C95F954EF18120B983BB85CE3F3597E70183BFDF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75bad90d-c637-4b7e-339d-08da327f8bcf
X-MS-TrafficTypeDiagnostic: DU0PR10MB5726:EE_
X-Microsoft-Antispam-PRVS: 
	<DU0PR10MB5726DEB17082B7754766D13D95C99@DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CDAOf8h+QLkEPT8dWOTo8N8xzf+o46QKIVw/KE1DLcFsbIw6iWELFc5y+R7GvIEr3SL1C7nquF94pacWpL/szNWHwPMsS7haZ7uGEAcWfvGRifq3AMfUjl8r5Bw+w6Wd9y7HUglW+C4t1LLbBkJxsJNLB8JXYPdG+YtAHepsO923EXw6yrQpG9L4EPu99E8J108rpz+Sm2dGjao6+bEMOR3MO5e3VmM4dE/UgDThCS+xAU/Mfsv35i7qbIHyylLfeleixX7rNYWffY8z2fLTj5UARSTJKN6qlkZoGLRwQoTHDZW4mruAO9DUYgX7kAfWY6dDLd196Lt4QVZSTOHIQMU4YJn5UzLEBFwgquFAdr3CWlA3Pw6H/1CSWtAkDApf7bUSvD6is/GVzMhBc1wjEmCysy3cnZgnR/KVIPYHLYB+vQ6yRRlOWkBFJNTz+hoTDI/vR7YYJOlIpikABlYwFGSD1Dd5EOl/qdZmO9q3g2EgDyv7SSNZuoxqZO+PXZE5Cy/nPLb+JZ4SF5LKCWMKN6ZMRg2N0MHVW2CMhdWiMZnQxeCfUc1PLSEYETj0tyvWi0LOplXhsufsE6vl3OTG1MWjg97JPaQG7j2N4LTTOVrS9QubWgQS+I/FwgiMk19N/PCzJfa798DL1QhaWZXHkwdrtMjMpOl4jEbwe89PTcLcrccpvSIIdtTLzM/SdwubgUdgS4K7uoWrB5tYxMz+HQ9MWMp/OVGKWZFd83J4Rqq+vigmUbA30wM1Ik3girGXi7Fcyw0g5eUP5P2cFaCkaw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(336012)(36860700001)(16526019)(186003)(83380400001)(82310400005)(44832011)(2906002)(5660300002)(36756003)(31686004)(956004)(4326008)(8936002)(31696002)(16576012)(2616005)(8676002)(316002)(86362001)(70586007)(6706004)(70206006)(54906003)(110136005)(26005)(81166007)(508600001)(82960400001)(356005)(53546011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:21:00.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 75bad90d-c637-4b7e-339d-08da327f8bcf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5726
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 May 2022 12:21:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8285

On 10.05.22 14:06, Venkata.Pyla@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Thanks for the work to support secureboot in arm64.
> 
> I am building the arm64 image to check secureboot support in arm64, got the below error and do you have any idea about this error.
> 
> ---------------------------------------
> $ ./kas-container build kas-cip.yml:kas/board/qemu-arm64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml
> :
> .
> I: Extracting liblzma5...
> I: Extracting zlib1g...
> W: Failure trying to run: chroot "/build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/rootfs" /sbin/ldconfig
> W: See /build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/rootfs/debootstrap/debootstrap.log for details
> WARNING: exit code 1 from a shell command.
> ERROR: Logfile of failure stored in: /build/tmp/work/cip-core-bullseye-arm64/isar-bootstrap-target/1.0-r0/temp/log.do_bootstrap.307
> :
> .
> ---------------------------------------
> When I see the bootstrap log at the end it shows "Segmentation fault (core dumped)"
> 
> Thanks,
> Venkata.
> 
> 

Is your kas-container recent?

Do you happen to have qemu-user-static installed also on the host? If
so, please try to remove it then?

Note that CI also passes.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

