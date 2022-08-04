Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43633C19F2B
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 13:29:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web12.4781.1659619746664304211
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Aug 2022 06:29:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vImffn/g;
 spf=pass (domain: siemens.com, ip: 40.107.22.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AadE6gyjWg+Rn1/3v3hFAtRDWDcKqskgxqKOffF24/ZvCDH8f8MT6crzQOB8sYoVSx8o+IS6fyun8w6Bp80xAgrnippxD1LKfCik9PlZjjG0O5WWBQpgPhxCSHccdRKZynnfl+31Tmt+hN/4MafDrdZDUjQk2053heCsdo7eI6sa9m5OaXln10lSiUpBdS15A7W+pCjGHTpnyoTIeglGkrrHQOUYUbYO9UMl4N/dUfPNI6JUrHWtXJX7PMudM6+4hcvM9WOpoOMGcZeQN+NiWlW91ieKz/ws0TACWdZ63rQcidJgP2Z4QxmK/Wg+/c/pmfqy8DqV5agFtOB+8eZXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flkbqPN4mI+uUP7k9CBjloWgNqNaLIJRwznW175lX1g=;
 b=Czo+ze7GUyIEEL7GAY5mwm/bxE47KkzK+2WqrPtk97jmUK57XO5lH76pjq480D/mEATAQbFrnFsocvoOwAtHWwl6LUC4Ifp+o6tZZ9B/DXc4GDDQq2zOlEmBV8A0GduvGziGcJEzwPraYppHr8kWmX7LSpSF03ntWLnxJOFcJdOpEAe4TbLs6/SzGrZ0SuWnxFrkF78vaiMMgSWoEKJ7l22IRQvHeHh4BqCSjK05yZEUIUnRhivB0lzigIo9JsQ0qiy8HdvheEZe+Lv1yiooO5u0j05ygqtlKy52ZMKKa8ZomVFdO4wykAPzwOAsMHzmApoaz4XbvH7FEyVAwNNIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flkbqPN4mI+uUP7k9CBjloWgNqNaLIJRwznW175lX1g=;
 b=vImffn/gwQZSJKC0x/6wAjZv2/nQmMcD2zZEgNT9grKyetn1SrkobsdcrPx9SSkGcW8c2OjorpsDmI6FFH8u04FIEGAr9n+E8g2L5/8RlWidMiiVf7owViU2P1KZW7BmLkFa3XH2zmybEmWWK7Y5Nc0hTlErVG28Rm3uQHbOLi3RQII/S57zpS+0jiioP+Js2B2x0RV5maauFv5jeaRjo7QeYhXthEQMgmy/iM15eTeSdoIzUU39DiE8uP8KLmCUx9jr76R/qJ3xr6VN2zuo56JOYsxS5hYUkzG3nMx4F8qOSRtI9ahXelY/I5SN7XwiZ6OoukiR0kseJhA6+s9w4w==
Received: from DB3PR06CA0007.eurprd06.prod.outlook.com (2603:10a6:8:1::20) by
 HE1PR1001MB1402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12; Thu, 4 Aug 2022 13:29:03 +0000
Received: from DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::e9) by DB3PR06CA0007.outlook.office365.com
 (2603:10a6:8:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Thu, 4 Aug 2022 13:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT057.mail.protection.outlook.com (10.152.5.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Thu, 4 Aug 2022 13:29:03 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 15:29:03 +0200
Received: from [146.253.17.43] (146.253.17.43) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 4 Aug 2022 15:29:02 +0200
Message-ID: <05d75b54-bd6f-e23b-e40d-c991f664d4c4@siemens.com>
Date: Thu, 4 Aug 2022 15:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] bbb_defconfig: Add missing SDHCI
 Drivers
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220804125437.715852-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220804125437.715852-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.253.17.43]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.970400-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj85QaOxwNGfvo9bHfxDWoib6FoWuW7WfbxR5xjwgMwZ2gEP
	JrYlsf/6WAuSz3ewb22coHkKu1u1b89Y6PkVKszs9YmJ+rCjjhEh4UgUH4JX7APZZctd3P4B9/x
	+2nQH35ItF/hMLav4AQgObFK3SIdMYEH6Ub10NManjcf2c/1El4SH/KD/7QRgAZ0lncqeHqGRot
	hb8yw8wEj6h8vQeZP+6+pbA1zmYaMr59u/gzv5MLUzq8RBkJuGSSOWVJeuO1A5f9Xw/xqKXZwhk
	tVkBBrQeFIQTy0Zb4arusVRy4an8SAHAopEd76vrTzV9bmmzq/3u77HrUaLaK31Z+W76H7qV0lY
	YQWJBpQUTakfeOWj3Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.970400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C18B666D00F9B72E3C98166B1C8CF0F0727A777FC81A361837A01DCFD550E9062000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f4bdb15-6534-421e-b8c1-08da761d4c7d
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1402:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eAAVaANNtkJv+VyK4NCj/lCjZM62Rd5WFCMbLNFgt+qLpKrqxglwuSm8r3jRAEnxpsj5K2J9bOY8IyFmB/ymHFWXmfrqHy1+1ye5YSkIURzB1LfaebVEBL2M6tjvNKQnhBp4m4Bxayti7z2LBm+zH6YIyWNiu3CBi5k7C+wLlHokaDWFylBJOAiiFyyaPhOG39sqhqVkJ69UEZuIRnADAfs5ZnucHJemn5BtRh2WN9k1tlMfImd7+WFVtxxcXBffXmee8/hLj/mVV6WJg5ApO707bHV4bk0HlVKypq+CqLSPvnuOZsggErut7UxieDmuApsNL14X6wWZIeEKF4H6fRYb6+ZDkmfL3zhe55Gjzs64IP8k1Y7dndSZXXSzkWWc6RycovoJm45tkMUc1SFTeaeoFNlJTkXNv9/PWLsy5J2XtACPEIf/zGiB7KWqrrv7AimzVSVrdffMXo2EgZRmEAr7kxD1KlHytu0cQPcBkozDof9QYMseTXbuIq2lmHjg1ZLjhvmqbWHu8uDs3RUrbFynv62PT0oviHLSmw2c3PFjzr8XpP0VzffX0LS8uH3EB49hZNrcQiHBHUnyAXFd/9XEx28SCdgwWIhX8uuu8lhqHZZ7oDr8f5s28YuxlUX1rlzcFx2FZozFYKu8lL9AEdcfMhu8cfjL4ycU+YeLGK4eaM9UamrvmkumBXCOpkcWc4ZyT3M1iLesOry4NPqxRe/tTpFRZsrcBY5oZRTEoJWy9urobsQUikNPqYN1ifRLgjRTb2Bt6FOkDs4og1E2Nu9PA+Gh4So65q4AftJBgb/ku7ZO1biX5YuSteb8dFYcj8FXFFGSTuR0T3DcFdp8Q7MeNMu+mBe5iZ+AxYteu/RbXh2Nc5coIekSm3dAplFRY7urISVvkCGySb9Z4Ar97A==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(36860700001)(8936002)(31686004)(478600001)(956004)(44832011)(5660300002)(26005)(2616005)(82310400005)(53546011)(16526019)(336012)(47076005)(86362001)(186003)(31696002)(40480700001)(83380400001)(41300700001)(70586007)(40460700003)(356005)(8676002)(70206006)(82960400001)(36756003)(82740400003)(6706004)(110136005)(16576012)(316002)(2906002)(81166007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 13:29:03.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0f4bdb15-6534-421e-b8c1-08da761d4c7d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1402
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 13:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9120

On 04.08.22 14:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> To boot from SD/MMC wit kernel 5.10. new config option need to
> be enabled.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/files/bbb_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/recipes-kernel/linux/files/bbb_defconfig b/recipes-kernel/linux/files/bbb_defconfig
> index 31e15e6..8f8f1aa 100644
> --- a/recipes-kernel/linux/files/bbb_defconfig
> +++ b/recipes-kernel/linux/files/bbb_defconfig
> @@ -374,6 +374,9 @@ CONFIG_USB_CONFIGFS_F_HID=y
>  CONFIG_USB_ZERO=m
>  CONFIG_USB_G_NOKIA=m
>  CONFIG_MMC=y
> +CONFIG_PWRSEQ_EMMC=y
> +CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK_MINORS=256
>  CONFIG_SDIO_UART=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
> @@ -453,3 +456,8 @@ CONFIG_LIBCRC32C=y
>  CONFIG_FONTS=y
>  CONFIG_FONT_8x8=y
>  CONFIG_FONT_8x16=y
> +CONFIG_MMC_SDHCI=m
> +CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> +CONFIG_MMC_SDHCI_PCI=m
> +CONFIG_MMC_SDHCI_OMAP=m
> +CONFIG_MMC_SDHCI_PLTFM=m

Thanks for tracking this down. But why still massaging this config? We
rather want to switch to cip-kernel-config and fix any remaining issues
there.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

