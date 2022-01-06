Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D2DC433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 13:43:58 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.47])
 by mx.groups.io with SMTP id smtpd.web12.8517.1641476636327850717
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 05:43:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ARoMQUSH;
 spf=pass (domain: siemens.com, ip: 40.107.8.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRmxuIhqzuMih/tNHVr0kDFUOJ8rleXEH09fm8Rkov7Y62Cj+hCM+1VEWWR5cAF1MGr1HAhNPWD/xBEW5Ajm0wKibXXf3ysvXA+ok2+yxJMmjLawhMGdDok8EyJS642LL4rHDDYy5UomLydGHajcrJ0Z3wAeP5dQE2vaMCQAiXpwnEsAjiNyOT+jrEY3s0ZPoKfDUMsXN7QvADhgeN1Vp0TCCwnqNnYIZYJGeG/y0BfUP+rHxRUeInyBh1QzB66JrMgccOoAUCz30nRODeUaCWI6e21lgIIfwLVRzbZh47BWCuTmk8KdwLojHq3IfMdhGO7RY5Prg5cyTNHK0ZzdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAEAYrtIuUvDbNh3R26cQ3gnVoXSWfxt22NuWjiZ2Ok=;
 b=Ri6g7UBfM29HKTuhZNfyXN29xr8F21oYQcDrosCZ0u8TDwE2r89Dh+IXN8Q4cl+r8Jhgj1VzyjcIu26QOsu87iNacl1lxCJkamxeSn/2Foomc81JHCS2tDZgVbHS+kiSjw9u83LpwGhEYjIH60Y/SMCTICdEgnVkOmag3BB7VJNbuMyx8WaSqWYr+4Hmo1QdncHWI0fhZTQZT9FEJ+HfRJFz3RA9x9bi/ZfNyD/GiNxSMm8KRq/kutvF37+4G21cPeIggtiq3NnU1uX5tgL83lvn4ozS6cbto7lLB/0Ckl3mHNrsPqfNSFQK8F5XMuUjA/6szkqtTmc1aYkxCDIOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAEAYrtIuUvDbNh3R26cQ3gnVoXSWfxt22NuWjiZ2Ok=;
 b=ARoMQUSHcHYCurNQ8dzwR4kBmOT4lO4fBWAB+/AaqKu7Qck5g+0FrjfwwHfKE8ARBECCUUYQoJoDm5Lne2Otdy/xQuZbFwHpmOp7G4RxRa9p9nnsatb7CBxQF5OtG1wQTy6xJpyh2DmHcEkDCPVueu21XXtl6B2xm+Xl6w1pmGQoaXcxExr+idpEMgREjPhbREQkZWaknYkDlhunF+1pudpkAm5WwtHOoJUo8Iy40NkJWG36S9mRIWAdJMfcNm5dCTwbGE7BFyuwwvlvdx3bLXPUn0AbyvUDNKR0RMJZBU2m5LgeJ0471YH0KlgHb2mEzsBH1GCdaD26LBkdyUvYpA==
Received: from SV0P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::12)
 by AM0PR10MB2372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 13:43:53 +0000
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::cc) by SV0P279CA0007.outlook.office365.com
 (2603:10a6:f10:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 13:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 13:43:52 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 14:43:52 +0100
Received: from [167.87.72.7] (167.87.72.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 14:43:51 +0100
Message-ID: <3052fa77-ccd5-847d-3bbf-f78d6a1e008e@siemens.com>
Date: Thu, 6 Jan 2022 14:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building
 and uploading system
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.7]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93c26c79-5680-47c2-f8b7-08d9d11a93e7
X-MS-TrafficTypeDiagnostic: AM0PR10MB2372:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2372EB9EBDB219AB82C83964954C9@AM0PR10MB2372.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GzSCEt/u59RzMAo4snOXZAiasjWAayMuKFW8gwx9yToqu2up0OIEHIQTCMvRdGC7SO9jUZamIM5YsoHySRaiBF6lcTUN3R8wAI+Yqe3psBxuQCBe7N+/WOFzRKiwq3Uw0lkT6TRHkihfkRulk2icywGnA6Sr7qZI/Ft5T1IyoMfXzid1q8eqOP3PgRvoOkY2CyTN0vskAnM2HmuclwQca/+cHRfWusK4toPq08cH35mvOjpyAFMZn+nvAkuEFvKGV5YBdlTEuRnhpeOwrqiCeaoT8Xy0AOkg5KqZjvKsWUI094qCe+KBuO4fjZMWEk27Yjt2lOrNv51Y47Qw5ay9ogo6Char4hg04XIaa+5Oe/fDDgCsArlrtOBHgL8k1CY93MkYjaRsTSPtGkKoIGrDXtbZktHzYzYi5b0Nq9x4IVZ0SbAtkO1w0ANAFHq3HLSQ9ONcPt82gtj2aBBvqDnIBO0oBgZlMawYJM8Og41RyhbCZU5mIBiz0l/uO82utm1LxKqNz4GpCfEmZeAvHD/i9nNxrxwHDFQrfqLGVEFsVlr7DVNKsXPWuR6lv8wZGSVZnvCGJOtwCpYYHw++vAzC9QQOB5LEEtwIgPrgEOAz4TG8u/uyOr1QD1bdooix5bRocOBnUgBZsJprEX5D115yLoYS6m0m8beiHB2A6x4C0GxgXJG+tHa782S4rDLRv+1ueDT1SJYg2MSenCeI2a6J5/1aKwrlfiLTV60QzedC8KOApGt8xW9eBSE/bkwm+dGYmbPZD15bL8mGozAvQ5KQHp9mqTQmhkqEtpBBoiMpyVHdVvqvlmqHonIMz/vhDNRWljVL9j6x+62pulA7tkWZ3m8ahkZZp+y7+lxnYmNU6hdO+rHTd19gdgEIVqBWV9i58n2rRdDCuydGMYgH0vAdTEg0sKKS7NAANxDvixjUkDSQcbgXzRdQZskF0esc58eU
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(44832011)(31686004)(966005)(86362001)(36756003)(956004)(498600001)(186003)(8936002)(81166007)(2616005)(82310400004)(53546011)(40460700001)(5660300002)(2906002)(110136005)(70586007)(31696002)(83380400001)(70206006)(36860700001)(26005)(356005)(8676002)(16526019)(16576012)(6706004)(47076005)(336012)(82960400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 13:43:52.9600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 93c26c79-5680-47c2-f8b7-08d9d11a93e7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2372
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 13:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7332

On 06.01.22 12:16, Alice Ferrazzi wrote:
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
> Alice Ferrazzi (4):
>   Add cip-core-image-kernelci
>   Add dmesg filter needed for lava test result
>   Add script deploy-kernelci.py for upload the cip-core-image-kernelci
>   enable cip-core-image-kernelci
> 
>  .gitlab-ci.yml                                | 40 +++++++++++++-
>  kas/opt/kernelci.yml                          | 16 ++++++
>  .../images/cip-core-image-kernelci.bb         | 16 ++++++
>  .../files/99-silent-printk.conf               |  1 +
>  .../kernelci-customizations/files/dmesg.sh    | 23 ++++++++
>  .../kernelci-customizations/files/ethernet    | 23 ++++++++
>  .../kernelci-customizations/files/postinst    | 34 ++++++++++++
>  .../kernelci-customizations.bb                | 35 ++++++++++++
>  scripts/deploy-kernelci.py                    | 55 +++++++++++++++++++
>  9 files changed, 242 insertions(+), 1 deletion(-)
>  create mode 100644 kas/opt/kernelci.yml
>  create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
>  create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
>  create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
>  create mode 100644 recipes-core/kernelci-customizations/files/ethernet
>  create mode 100644 recipes-core/kernelci-customizations/files/postinst
>  create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
>  create mode 100755 scripts/deploy-kernelci.py
> 

This is v2 of https://lists.cip-project.org/g/cip-dev/message/7264,
right? Please flag that in the future.

What is the delta?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

