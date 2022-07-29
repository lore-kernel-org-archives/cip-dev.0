Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB593C00144
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 09:00:42 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.72])
 by mx.groups.io with SMTP id smtpd.web10.5904.1659085234888777954
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 02:00:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jQnrZz1o;
 spf=pass (domain: siemens.com, ip: 40.107.2.72,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyTHk62xt3kIVNjKSR6wVvQW/tcXdatZjXHUjbDaRkvSL6TO99ChEEldbhsbaNPGCFBX+TaZutNfvbSIcebPJj8mEs43nj3+7i5cT8IEWoEUyn443M8WqWb555JG9CrtZcB2QLHhUuK1OZNoWiiZkKFKVqNfDUKxOUfnzjYeceJlYbPDXKsEaQobAd3w9BiCah7VybI5ycoxA71YTxv7VmuiHvVeYuKeWD/y0KDrSdHEFUXaNLOAgXuNmz+3KuO4fnQrrWbpVHs+CayfMpoou9Siw8rv7p3hXmcZki2Vj6w6ZgoHVS2Y7RIZHEiUNHsRgwKic8I7N/Nopt9Q89yahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuD3zd+PzrpeZZwMV+oemVRXNrzmfpcjYpXpf+LxZpU=;
 b=IwwvPuKPEWQuoqCnghnHswJrqB7o3Lzrfs/H+htT7Ccpr03RbU45exDb+KzvVpAd8HBW0fcuyhngU60KN1usoz9Wn9S6L65vWKz61BUNhPxEFTdtlU1a68pcZEnfdi0E3viRGo6wubRKMai9OsWB3Y9HzdQRKJucBqPmcHPGuKXQFtmo59wX50PrBjqfsR1VcSg4uy08rvgA3GrbHmuS1RhnGAh8JscaW+Bll5FF0dpj7r7XnTCpJ9igH1opMKnfs0WhxW+zCkr+m6vHo64n9c4TBX4U5WTHKUZgwyuPofmcF2wh/5ifU3lfA+URfeKl94HG9PTQAQEnt8fkS5DOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuD3zd+PzrpeZZwMV+oemVRXNrzmfpcjYpXpf+LxZpU=;
 b=jQnrZz1oOz3T99BOuYXDNijiaeUJQRfb+X3eP/OC/RCnDIQjnVu/YwGqWVp/Ef0Dpjw1CRA8g3SeF7k/J33jPmAnKRhv4NqbcF1HVwQltJb42XzyBQAJgU9aDR4f1hRSh9Eus7Di25drGNYnapWBjaE1QgG13wn9Ivyz2lt2MyS2E0ZDtH7fcqESWRBoxnXO5QvhEUIm9yI6bP6Fp1wZQXsVqGdAPNKqVdJJ3UnH/SoMtAR1c0J2ZmBo7oh1B844h6qrp0oaPntY4A4+96ZmC56u1ithE9t7twaDQ3rbeRyzqkgwRmxeL/xAe5TCbnh6bOdLFMTU1gSWbTzyAZv5lw==
Received: from SV0P279CA0023.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::10)
 by AM9PR10MB4990.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 09:00:31 +0000
Received: from HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::c8) by SV0P279CA0023.outlook.office365.com
 (2603:10a6:f10:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Fri, 29 Jul 2022 09:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT012.mail.protection.outlook.com (10.152.0.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 09:00:31 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 11:00:30 +0200
Received: from [167.87.165.107] (167.87.165.107) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 29 Jul 2022 11:00:29 +0200
Message-ID: <60fe0d55-2e00-9c39-9673-8906a4f3f004@siemens.com>
Date: Fri, 29 Jul 2022 11:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] kas-cip: Add patch for
 linux-cip with CONFIG_MODULES=n
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
 <20220729083931.419731-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220729083931.419731-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.165.107]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.469800-8.000000
X-TMASE-MatchedRID: AQ9SOYvqpDY5QaOxwNGfvo9bHfxDWoibx1/NuoFDMxSJUlmL3Uj0mJtc
	YV58cc5ijiLABC6i+1iJ5e2rLEsnzF+WX5ltWJuFvQ3ZmbMWuLwIoZsIlwjKBk+zv2ByYSDQKQN
	hMboqZlq2ZO4LLn5VSnCY/+t78W/mTtDq+0o8imjM9+oUDdmM37HX51AM69eE9u1rQ4BgXPKWOD
	D/yzpvd3CHlyx4X5j2BeQVmFIt/YYme1U0dqkwKwvXaO85D6XX40xNy5a/HnZ8LCAHuMHCRleOO
	wzb8N/GCkKOpUQuXBW3/nyANa4v2PyowVEbTnYpLxxHBMdDc7oy7wvC8Uc6HW9OepgphdNGfS0I
	p2eEHny+qryzYw2E8LLn+0Vm71Lcq7rFUcuGp/EgBwKKRHe+rz+jSdUs0QL21LGqi0sTkFaQZQC
	7P931PD8hHAcjAPuawHiDuBQ1YgM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.469800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 F74D91ED3B17268318E90C0619BBB6840BC6D7C07EBBE893CF78769677BCBFA62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eeca244-60ec-4eca-40be-08da7140ca73
X-MS-TrafficTypeDiagnostic: AM9PR10MB4990:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jeWsSeRGKTcxZVcwsLeyR0SZVxLCnmI5G/8JsCCFAPl/+JkdKdLrF2+EOdliA2Re7O0/NY1OCqSM9p0ObS7HjSy8a4h1y0DGGt4LvFtB7HKFCmm37pKAPI3cU7lD1QAtNqoqMoGXBFRmofO7Vdm23+aMyNs5lQH7zfkaaC5auMAF1JOLL4mi7RGvhRbaygqPbTtMgtZNyDx9yCg7/cfLymqFRAsj0QKiMrcWD/OYOAWqjUnDFOnn2BjLtFh/rxSKKdPyNaxo7wY2Z86kp1uj8gNsLwumvTB47sCv/aLqcPoccy63sE+ouA4JfF5lUKz6MN7FdjKOXKDOm1gHwHzd67nkMqVP/AbPdcd+kSnZQVUA0lFAb4B5WHdTModJyvL7gDPdduUTntUJCvDKmt7CGMouRTvJ6W3in0G4Aor+ylQTNfpnASUgd7x13E9U4WMj4jK9Jxh0CsDkUqmo6fjl5rp3e3EQF/5sbG8EcTw5npT55bocY3VeX8hbxQQHsbuht2EPVuhlwXHgc1Wo5DHiUhBvvdgLHDg7T0JTpIqX6r6aeiu9lk+iFUzFZbov1UOdyEwVWVae0Hn0i0G2Lbtby2RKC9815205EFZ7cyz8YDgxM4t+vWOH2DRPSPEal8QdxqGxj3LC0OyaqX37e/inKQLOjazqx4AbM1ocjq6HCB8P02+WQtuhkahXwmrtBb9EDjM/TLa92iIx+jk9/VQsDkKIWcOlLvgN9waZZ/6RpBaMeUGyjpMxDhwEh4aGdBrj+/tncdjniIk7dXFNoYLgk2qpp5tzxba03c3UATogWGnyuJQeRzmhvoZiSbNOsr8DZTfOrbNQZWVA0ws37lva6YwmKlbsoqmJ4zSKAkMKjzMppDwTpFGyj/xoY47KughwI/6CJfsGeI+bZ97jwvomGQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(316002)(53546011)(16576012)(336012)(6706004)(47076005)(31686004)(41300700001)(26005)(31696002)(36756003)(40480700001)(86362001)(8676002)(70206006)(70586007)(110136005)(40460700003)(83380400001)(5660300002)(478600001)(36860700001)(82960400001)(356005)(82310400005)(44832011)(8936002)(2616005)(16526019)(81166007)(186003)(956004)(82740400003)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 09:00:31.3949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6eeca244-60ec-4eca-40be-08da7140ca73
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4990
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 09:00:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8978

On 29.07.22 10:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an error during the kernel build with sbuild if
> Modules.symvers doesn't exist as find returns 1 if a name
> could not be found.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 +++++++++++++++++++
>  kas-cip.yml                                   |  4 +++
>  2 files changed, 37 insertions(+)
>  create mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
> 
> diff --git a/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch b/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
> new file mode 100644
> index 0000000..d07c36d
> --- /dev/null
> +++ b/isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
> @@ -0,0 +1,33 @@
> +From 6ad8f9bb92d3722ff5eb60f09e5ef75ba5febcbd Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Thu, 28 Jul 2022 16:24:16 +0200
> +Subject: [PATCH] recipes-kernel: Check if CONFIG_MODULES is set
> +
> +This fixes an error during the kernel build with sbuild if
> +Modules.symvers doesn't exist as find returns 1 if a name
> +could not be found.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + meta/recipes-kernel/linux/files/debian/isar/install.tmpl | 5 ++++-
> + 1 file changed, 4 insertions(+), 1 deletion(-)
> +
> +diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
> +index c6b5059..909b01b 100644
> +--- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
> ++++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
> +@@ -173,7 +173,10 @@ kernel_headers() {
> +     (cd ${S}; find arch/${ARCH} -name module.lds -o -name Kbuild.platforms -o -name Platform) >>${src_hdr_files}
> +     (cd ${S}; find $(find arch/${ARCH} -name include -o -name scripts -type d) -type f) >>${src_hdr_files}
> + 
> +-    (cd ${O}; find arch/${ARCH}/include Module.symvers include scripts -type f) >>${obj_hdr_files}
> ++    if [ -n "${CONFIG_MODULES}" ]; then
> ++        echo Module.symvers >> ${obj_hdr_files}
> ++    fi
> ++    (cd ${O}; find arch/${ARCH}/include include scripts -type f) >>${obj_hdr_files}
> +     if [ -n "${CONFIG_STACK_VALIDATION}" ]; then
> +         (cd ${O}; find tools/objtool -type f -executable) >>${obj_hdr_files}
> +     fi
> +-- 
> +2.35.1
> +
> diff --git a/kas-cip.yml b/kas-cip.yml
> index a39820f..5a43cd1 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -25,6 +25,10 @@ repos:
>      refspec: 64c755053d1252d183757b294cf9849fced64799
>      layers:
>        meta:
> +    patches:
> +      fix-hihope-kernel-build:
> +        repo: cip-core
> +        path: isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
>  
>  bblayers_conf_header:
>    standard: |

Does the patch depend on the Isar update? Then maybe merge it with patch 1.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

