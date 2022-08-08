Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E869C00140
	for <webhook@archiver.kernel.org>; Mon,  8 Aug 2022 12:47:38 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.45])
 by mx.groups.io with SMTP id smtpd.web09.24680.1659962841370123959
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Aug 2022 05:47:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DVet2CfP;
 spf=pass (domain: siemens.com, ip: 40.107.6.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfIcfBMn9Cg+0HSnxYNyV+W6sHTRsXudT6odVPMhO4MnQZ/cDdoZLxaVEkUIAxG8GiEkypmLIvV3Oa5b8jkEAxbcJZHhQsDZkYiz/wLQ5qxAyPKWt+tw7LkyN2GDbccfmpbZu6dkHemGj27+GUliIKOAiM+FRUyTH9EsgexjHCOzNojh3FU62KYqbBPNt92GdjuUVFcoB+6cLFVuK+yYKSKSd9JS+EZJ7lbru8gDQ4lYvsCVyOcW4sHXV4lNfk2rnELMG2mCgC3d3cw4g8xAN1UU9BXEFZ5B0RHZRyvy9tuXRUz6WTY4B2ZQ4ZcDkSj24IRkNgAMlUJoVMqkE0TVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdAdC8snp4lr15F0j26kyBvpgpsFNkydVQKY8Hjm9pk=;
 b=T9Ow+FJBiqLy6gXpZFA78JHABD3FL+zyLTKZIdrbN5mz5CkYWz3brwR81GOmGL+TTheofAKVUQ02zet61yApjaOJyyQhhsHOdWsHh7imvxlsg4afEsJ/trN1/VnSZyl957QqUKz1OycNW2eA16Tkhgij7kKrUZfht6oN/VPQ9WX+si9L38zfOCL/EglB/29DCm32ED+5X140tFJAbFp8/O86pKDogbJp2Q4187Leal+jYWtZLAeAIP74/Y9dj4VbIH+D7EXSL5siX6cd6eWN1p9aSKvVh4AauXlt0UwK0do0bLP1Evw2A/GiKJMAQ+r/v9CgGUe1DD9hVOudkVXjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdAdC8snp4lr15F0j26kyBvpgpsFNkydVQKY8Hjm9pk=;
 b=DVet2CfPoA4MzrAP+RRcIlGYEADu4HibHQoLKM25RNnZxLwdwlU0iCRP2+4C+O7GUgsOFZB9OfvoMYVvTbUCCM+CRpU8UNS5c6na2QzxHQuwWtHWCSKYYIaRQTwRyz1FOeKdxp4BEOsY9TWDrlbddyntF7G/qPlmnjmAA8/4hgvDH46RAQIOpYJI1oun5SADxjfyT3tWHp95bAr0gmS9xT7T32BlXsJYfrRaxXWZ/pAlP6oa/jWKhyacbUCfCltJ3QffCAGOJXmM1X1JLkbwVoxpx0B+Hlx8of0E+XdmeewK2fQXyPu4wOL3m/Ioh5OGsoB2+IyhggecC9EhZIynmw==
Received: from GV3P280CA0070.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::25) by
 DB8PR10MB3658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:132::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Mon, 8 Aug 2022 12:47:18 +0000
Received: from HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::c1) by GV3P280CA0070.outlook.office365.com
 (2603:10a6:150:a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Mon, 8 Aug 2022 12:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT076.mail.protection.outlook.com (10.152.0.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Mon, 8 Aug 2022 12:47:17 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 8 Aug 2022 14:47:16 +0200
Received: from [167.87.44.42] (167.87.44.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 8 Aug 2022
 14:47:16 +0200
Message-ID: <f91ed3c9-b811-fa42-b889-fd25f3a35825@siemens.com>
Date: Mon, 8 Aug 2022 14:47:15 +0200
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
X-Originating-IP: [167.87.44.42]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.047000-8.000000
X-TMASE-MatchedRID: 8xNMUprDHac5QaOxwNGfvo9bHfxDWoib6FoWuW7WfbxR5xjwgMwZ2gEP
	JrYlsf/6WAuSz3ewb22coHkKu1u1b89Y6PkVKszs9YmJ+rCjjhEh4UgUH4JX7APZZctd3P4B9/x
	+2nQH35ItF/hMLav4AcnfymxuFRJbPtz1AYjlRAgrTjOzG0SO0agvFkdUGY78+4Fj9EzRyxzdKR
	Njzo2IOLcIt210bWgIYG32ZLukpVN6ipWzVkuu8IbXzhjksitpTX7PJ/OU3vKDGx/OQ1GV8t8dW
	DYdvqmp1GcRAJRT6POOhzOa6g8KrcSRI+4OwM00YObGije149W8FQB6Aoiamq/TjdCg7/xGVaHL
	HCyArls=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.047000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D104B70C6DC15E70311E55B06691B6C67354E81200E861BD56B4432F404B294D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58efaceb-8e21-4de4-4ad5-08da793c2050
X-MS-TrafficTypeDiagnostic: DB8PR10MB3658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LL5h1nopRO2bTkWOF89pbSouHDUwYXTIk3PS8wS2GypENa5P+G5J5HaZ76yuin+RFLCiwshCRFH4vhuOR3rlfHHWOACkBWkYt2NDzWboYdkmmEtGjJqEk33kBjQoMh4fT062zS+Ai47Qs2OrkgXyu2FGV/QuaA2AsFsdSBG35M0wZkZitW7qDs6xKAfRWgXZQ3+Fx7bRecs7VMsUD2gxTM4mtYoXwKiaX/7rT+GTEow3PbARO+PjtLn4za5ATZA7KfJ+CQcBo77tEGXSn+HCV1JPehQEVCkAmM9Syp9ueBb4wV2pgG6t8SZC9+l/rqL/9cTPqbGVRCOsiMs2rH/ntFx2xGOUhQVN9qnpkd2GwLwncdbHdVX7KRuvmn72qnqNseXbNi2jIjL3dUgVF6PblNIIj4LZiGd4zLIJpBnNOinjHNzLEOdBrH+sVRYgquCF/gLzfds93Y7eQx4rVgVjvkAA3PdccZOBXLyACRiRsl7bTdSVAVcj+FdtD3BpVwgA9++a299o6l+He4H7A/hLJKY2awIh06Q8GV/kHfH5NMW78L4eN/sG3LayhYLZnNLd3k/ICkXfxUCxroj3U+z25AUbov69Dt7o9ewrtyjrKuMog8ll/WRxn3Smt+/gp5V7sMpudpDMTffs6ioOS3SCfr5fN6saZANciQ1yYGx7Arz2EQqkKPHGglb+pfgjruDPmEKWcyMOnVxwLVaMvzIIY5vDjmwtDo+oyVBI3iKOh/pr0Li35zeIMAhF3MHHbhQFZieB0YxIhf9M5BLPUQbc0x6dwyu7Bqk7QBYNWVQ4k6+qJIGN5i2fBWEfTlDo+/cFyRGj9SlKGitwzK148pDQsxYlF1nIJf3VfeamOxrCxwpjuBajBIdo87xIzg9UDM1MFR3dKyqPkMqU4XAVlD46hA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(8676002)(8936002)(70586007)(36756003)(70206006)(16526019)(186003)(336012)(478600001)(40460700003)(316002)(16576012)(6706004)(31696002)(5660300002)(86362001)(31686004)(110136005)(41300700001)(26005)(83380400001)(44832011)(53546011)(81166007)(2906002)(356005)(82960400001)(2616005)(82740400003)(82310400005)(956004)(47076005)(36860700001)(40480700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 12:47:17.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 58efaceb-8e21-4de4-4ad5-08da793c2050
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3658
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Aug 2022 12:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9139

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

Not needed.

> +CONFIG_MMC_BLOCK=y

This can become m.

> +CONFIG_MMC_BLOCK_MINORS=256

Not needed for our setups.

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

Those two are not needed.

> +CONFIG_MMC_SDHCI_OMAP=m
> +CONFIG_MMC_SDHCI_PLTFM=m

I'll submit the required changes to cip-kernel-config for 5.10.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

