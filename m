Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4D0C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:38:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.75])
 by mx.groups.io with SMTP id smtpd.web10.10630.1639661915916483489
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:38:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nTwrU3Z9;
 spf=pass (domain: siemens.com, ip: 40.107.20.75,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJPbSWZFbJ8ZAp9ETYumQOXrdIZMVnjdKE6YNDgs5jwV2g4fmvqzxaa9yop43egrW0oYpU4c4vDMZmEvUmmoK0ljrcPViLX3PBn/66WOgBldz2zooamqAppVK8uw2MG8ZY5CTIKqLdZ9OXg4OrKtJQ/USgpb+TiZLVw1mm8uHVuk5gQM/tss12IAmeGuU+Up85++EFQh+P9HqH5H/Zz5QxW0ruDXAzspbO6s0UL3OV/8OD8ZiTuWLA0D+Ado02/Qdcqb6gQ1eTMWBuDBlFf+1ffGbu7Zb3Le0mWwK6hCbqrZqTj/XVAoWoh5f6sWvQ+hCvTDBdsZURDbi7wNE/bMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UsaC2pu3IedNa9QRO3XeEZfKwRoNdtH7wYIP0AwL9Q=;
 b=F/wlJ0jjsLWFuXOpNvniflLGg7C45+kZUbEBvNGh00+YSHTuzGaDF6M7YQf4DqWLFCBnoRaR/SuMVY1xDTYetIYRWqj9t2aEB1FrBeHYdiJ6i4OlVLGklbAiOQWNJ+qNXI2XinN7j1V+1MxuMM6Mm+EYjdcnI295V9EiQEq7OLg7BAXrZqjVyA5ipqKmE+hGT5aOq8Pg66beRw7j9Gz3cqNvv3sfkIOTUkjIaBCAwrg6/7cSJQx6GBdtMWRIl1BuilJ5w6btJY0UBMYVylC5UhulxZqy/C9OhguJgvdgvdBo+JVA9yrce7wcQphvJZ4Jwp50Sn+cWboHg0tEgxjqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UsaC2pu3IedNa9QRO3XeEZfKwRoNdtH7wYIP0AwL9Q=;
 b=nTwrU3Z98BKf9Bu7z7Pa/1z0M1cEJ++c7JxaEiybaW4e6DA9CYa5thn/xyXr9L6ZAsNTzhxAqNFn/+d0WI8Tf5NXC2B30VRg7OACFOqYv2twGUb2A45qxyACEDqiz5McZuio2dDp0jVQX6f4BEqbdvv1S0Hr3bAhEzpDd42TFJRu0Y8JAiE/fSM5cXkHzW9cc572ZwWhHPKlHefPzBH0HKlZZoVVBaMYXLu7hnJXLOHkLL+vZfUvEyKqC4xoqGSnmgsMpVItjlgZ2lFTYs15KK96wzoM8tq/31ZBRXdlnDXsqDmwntrMVtjffzvWfC+qdw1X1Gmu46ffjA20udZ+cA==
Received: from DU2PR04CA0275.eurprd04.prod.outlook.com (2603:10a6:10:28c::10)
 by DB6PR1001MB1271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 13:38:33 +0000
Received: from DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::59) by DU2PR04CA0275.outlook.office365.com
 (2603:10a6:10:28c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 13:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT015.mail.protection.outlook.com (10.152.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Thu, 16 Dec 2021 13:38:33 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 14:38:32 +0100
Received: from [139.22.140.88] (139.22.140.88) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Dec 2021 14:38:32 +0100
Subject: Re: [isar-cip-core][PATCH v2 2/2] swupdate: Drop conditional includes
 for buster
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
	<cip-dev@lists.cip-project.org>
References: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
 <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2ce1cbe9-8950-f136-d7a5-b97b455e8105@siemens.com>
Date: Thu, 16 Dec 2021 14:38:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211216133617.3403412-3-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.140.88]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eafdc33c-3311-4fb2-6273-08d9c0995ac8
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1271:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR1001MB1271AD5CFE6F9CBAF431333795779@DB6PR1001MB1271.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	999wIm9uMZ5gSL+TRW0tvEa9VR/iVVntv3QP6R0fg6OKj3xezTiZSEKF8h9Ob9AesC5hHo2Alj2wB5GO31iKv0isBhSutD2Dy4BOIIHd5X/D/VZmb4gk50pg8dcLbHApgL34abdyyeQ7Pc5wmxb8PwO3180+0vUuYTS2HKOraeyOErFz4jkMK+mJuXw/eqzQPRjiPMb5KNnwdKfZJpswkHtQIJkwDsqz+RhYe1NKYUPixGubjrwTax9Be1thQ1MzY3wsF2toUBFY+SEpUp0dQft9yNIlSFZHD5mkOKqJi+2GxKKl207aB5xKiXzeFLR3XdYhAo+6YEVYjoZ4Bna277io+ZdCVXfGPtErn3wdvmyhI58c82dEB4ihqgcgr8iH/ODrExAXNbRoNZ9EO55+EjiFIvy/DDMcqkV6uublD4N8wss3YWnUX3svjyRhuwSBho08CKELl+8QVmxFpGE7g1SvbS3OCNlPYvI0sn8875Yu90GTo7tpE8C9ySGz5X+/zCCSf3KKzvSviWeJ9G6uUKWQ/9XoydkKPiYLSrBOluWPUkQEwI9DTx5Bxfrl5AQ0u027qJ5dPFuO3E0dt1aXJaUJMV5jZqYrJ7V2YAliidaf+0pGeUVYRsrJLJf6GbjpshpNyBwheO70PJq2QxdS4JLjDupTa0MWfDvAmltK8/R7x1N4xP+iz3LCGjgXjImWxalqY1fm0xloArF2WCsMm83ET7NDDgPnjmCR/IL41oiIXSMO+b4asHlV8l5odcmpvewgt2EEXW/fRt4A3Y8iLxwdMQp6KMN6MBAaIiOYvw3Pt72FwOlwhoMVhETpOjI3fMDLLQ/+EY2IbIOW7/G2Sg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(40460700001)(44832011)(82310400004)(110136005)(8676002)(86362001)(336012)(5660300002)(53546011)(16576012)(316002)(8936002)(6706004)(508600001)(36756003)(31696002)(2906002)(186003)(47076005)(70206006)(82960400001)(7596003)(70586007)(356005)(36860700001)(956004)(26005)(2616005)(7636003)(16526019)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 13:38:33.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eafdc33c-3311-4fb2-6273-08d9c0995ac8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:38:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7158

On 16.12.21 14:36, Vijai Kumar K wrote:
> Stretch in now dropped. The conditional includes for buster is now not
> needed. Those includes are applicable to buster as well as bullseye.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>  .../swupdate/swupdate_2021.04-1+debian-gbp.bb        | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> index a4d67fe..51aacfe 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> @@ -44,12 +44,12 @@ SWUPDATE_BUILD_PROFILES += "cross nocheck"
>  # modify for debian buster build
>  SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
> -# disable documentation due to missing packages in debian buster
> -# disable create filesystem due to missing symbols in debian buster
> -# disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_buster = " nodoc \
> -                                          pkg.swupdate.nocreatefs \
> -                                          pkg.swupdate.nowebserver "
> +# disable documentation due to missing packages
> +# disable create filesystem due to missing symbols
> +# disable webserver due to missing symbols
> +SWUPDATE_BUILD_PROFILES_append = " nodoc \
> +                                   pkg.swupdate.nocreatefs \
> +                                   pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other
>  # compression formats.
>  GBP_EXTRA_OPTIONS += "--git-compression=xz"
> 

So these things were actually broken for bullseye so far?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

