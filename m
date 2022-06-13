Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B063C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 14:25:37 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web11.6518.1655130334167561657
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 07:25:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pOsH8IHu;
 spf=pass (domain: siemens.com, ip: 40.107.21.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWfMdrfLlh8hN2YpsSYx35vyjdUAZd4OyuzYB0AzZJ9t0V8yGsDbfGOqBv/QbMcB2umRsu/nKXEKbkQyz+yATYTRKwGmOkIgPCQOBvURYDA7lGE1wJIBF7tVGnMdvY9EwcaKYueuTZpqQV/4AN4EOlrQJ8FAu4/iGNe8Nor1tgJKWhQAIbgXrK56aBSiTtjPGRISXrq2BwKzQ9ICSKhV5FjGo6Ig1TgH8vZFvYU9lVJa42CezBdgAmF6RoKP5bL/8RvxdFiiPglNwLYUeF+BbfzTT5CIcDCqBfWItxEcaWok6e8kcWzPDseKU13mVsr1dT/uE7CbigRA/T8xOdQ0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0EJJRSlMswbP3Ij24nyuzTLoj0xgOUR1WQyEovfJx0=;
 b=O1cpk0+jMTzB0G9ggOkBDCIDZNCgOiHmq2J7/HjCmyYGkNMjUN/bWI97FsE8W6bByPyS7uV3gGeihKgzsIxVOcGOGWwbKPxYO8cHaPQHarni4nS8Ka/wCA/HDkS/QujeSaaz/1uPdupbMu943JBcEItzaijuoOWOVEnJ/3NH95Hwl1zlxTxtVmDuGaJtF7CLszB1hirPsZuOTYgYHqQLgrUFecKU5Wl5nsEGLbvoPCQQKUfAFdCq1ZW0aBbKRFSg9absp5Dl/E1RB+iwQl5JbrbHa96lUC+FXX5WdNOKI//kgktCKpIp1mgocrWi5mzmpvSFTEHXMR/ejpfcYZH27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0EJJRSlMswbP3Ij24nyuzTLoj0xgOUR1WQyEovfJx0=;
 b=pOsH8IHuqmZfs2IPnuVgRpH9YDIU35pE+D2BSWK6OSuswiYv3h78yJkK3rbw/GIbr1LN2vadb3Uj0L48tqneby8iQSVC+A8CUIXHDbjlSdoiueUYLElLp+ZJxLKajAybUNwgXSuQWHtBqCfYemqS8K7T9iC+OzNIh0XCbFe3WBnWCDXQk0ZPwwTt5ea8+ctQoAlxVOc8KgK2bIL4zQYLkXeyxVwW9rkL9+XpRoIQ0NiTtPCCLkg+LADf8QKeh4R7bat6LzJHPxfEb5hZGcWZDbfClBIf5++4HIWAY3RsXRFFcBHW4mIVsGPYG3Jz4YcOiIDhPr85jr3JZFsqb0fULA==
Received: from OL1P279CA0040.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::9) by
 GVXPR10MB5789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Mon, 13 Jun 2022 14:25:31 +0000
Received: from HE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::fc) by OL1P279CA0040.outlook.office365.com
 (2603:10a6:e10:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11 via Frontend
 Transport; Mon, 13 Jun 2022 14:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT061.mail.protection.outlook.com (10.152.1.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 14:25:29 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 13 Jun 2022 16:25:29 +0200
Received: from [167.87.5.173] (167.87.5.173) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 13 Jun
 2022 16:25:29 +0200
Message-ID: <95306f48-f715-7fa2-1241-d641cda69a26@siemens.com>
Date: Mon, 13 Jun 2022 16:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] .gitlabci: add qemu-arm64
 secureboot and swupdate
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220613123417.1200092-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220613123417.1200092-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.5.173]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.172100-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiM5QaOxwNGfvo9bHfxDWoibNtywwIf5ksWqFx2c/3V5cVSM
	dQR/r3Ee/0sRqdZstnZAHOg8qEtqyAJ69tzmkV7SGRz2fUwvbbWb6lvlo0eypIC3+Rng2NqjhVD
	nkfzD7uaeI1jwWXaeI5/r4ta+5ZgHheDJAd6wrjIvHEcEx0NzujLvC8LxRzod9u1rQ4BgXPJ9LQ
	inZ4QefL6qvLNjDYTwIq95DjCZh0wmBvd3Ao2uOgtuKBGekqUpI/NGWt0UYPAU+bzSE02caKSj1
	6gEU5xjAn1kH4dnh78BT8iKw09cw9yKUsrD0S3W
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.172100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 F185AFC19B1FBA1D3D7E4410A78FA96A45BCDD92DDD75F6879DBBB700BAE54322000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a270e13-e0e3-4bc5-3ee9-08da4d489179
X-MS-TrafficTypeDiagnostic: GVXPR10MB5789:EE_
X-Microsoft-Antispam-PRVS: 
	<GVXPR10MB57899EAFA4AD65CC95E9651295AB9@GVXPR10MB5789.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Un0n1PAkfmJIqIaLK73XAnmRwqC0I9GmbXl+eMY2SE1y++rLBAaf9nsrbfz/5YwuK/ExuKZ1UPd1FTrDEdTu4m1cF/QuDy84nqLl+v/fqBP2vAznLIzXZG6sh6dcgo70vGs6DKemfWQ54hL05SnJNmTPDpbnKFeJwDReUuVhgIFKjutFePKX5koCMMsnOgkOyao1PG0eAFPJkGmnqZYFlL11WNrXwC9E/PPTuXpdWwBGYJEa4sAaJixCbtCuMHyvTN5LTvl+BZpWSr54C29knkf8TKDOymv/CjAePmosJU6iXQwjRYX1wdunHFCByy/92vkh0td2MZ+yDrEv+ScoEkyyUxVcf94+Cux8aPUIz+volBv4sdU885CPrTDD2/VYJ0rPB74BBBcsR34k1pZ9rUChwI4uq16URPysHI6t4umT+PcsFF/OaaAMzlrBN5LNsV7B9ya9nTGDum2JUAmrw7r4aAh8vlqD8Zi4Bf0VsuIk8K9vsWmfwS4J/9DzpzNvXCTpOZFRawib8BOVhFrBok3TlSHngLxSu1H9BhNqBP33B19FJxZjIfT1yERmfz/Y0RwYyDQSOgBoA6BfdgujPAO1anliJazIwS/b2JkqTzT1svLPDimu/4egulfX6u/u/GbYgqMHfHaj+MIZBNGATXjP5cx+2dNYIS2j1+0LXtFA3NWdVzCjdT2flubxctlo2dOxS5ijTApuyX597ofQFyl0O8vRM1+Sn/w/xOpSebF5n4qzFrD1i1uuURdoopFMZwgbW13jFmaaQo0IfC2BA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(508600001)(5660300002)(8936002)(44832011)(82960400001)(356005)(36756003)(6706004)(81166007)(16576012)(110136005)(2906002)(316002)(70586007)(31696002)(86362001)(8676002)(70206006)(40460700003)(83380400001)(336012)(26005)(2616005)(956004)(186003)(16526019)(53546011)(31686004)(47076005)(36860700001)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:25:29.9159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5a270e13-e0e3-4bc5-3ee9-08da4d489179
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5789
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 14:25:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8553

On 13.06.22 14:34, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes in V2:
>  - remove qemu-arm64-swupdate build
>  - add qemu-amd64-secure-boot for Debian buster
> 
>  .gitlab-ci.yml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 75856e1..b1a4dc0 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -218,6 +218,18 @@ build:qemu-amd64-swupdate:
>      targz: disable
>      deploy: disable
>  
> +# secure boot images arm64
> +build:qemu-arm64-secure-boot:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-arm64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: disable
> +    deploy: disable
> +
>  # buster images
>  build:simatic-ipc227e-buster:
>    extends:
> @@ -249,3 +261,15 @@ build:hihope-rzg2m-buster:
>      target: hihope-rzg2m
>      dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
>      release: buster
> +
> +build:qemu-amd64-secure-boot-buster:
> +  extends:
> +    - .build_base
> +  variables:
> +    release: buster
> +    target: qemu-amd64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: disable
> +    deploy: disable

thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

