Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E6AC433F5
	for <webhook@archiver.kernel.org>; Fri,  4 Feb 2022 06:51:46 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.41])
 by mx.groups.io with SMTP id smtpd.web10.6156.1643957505459836301
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 22:51:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OdFolB80;
 spf=pass (domain: siemens.com, ip: 40.107.21.41,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiREA3VNK/IqVhmN/O2xIqlgYaxbeIkZr+1BltJuaGWcOPY+MckF3BtFHOGUJ/BK6ZxpiuguPsCidehRyOWRDbiMB/3aD83kSSJcaBWdoyID4QoSJwKAZc7RhpO3lpytCWhaNHGlRitD9Ek1lUmdMrgeWxc6rLF/2b540b8lMxkPSAQT/KiEVvNWdpTrok0mP27EMf7fBE9qzrGszBWVGL579vCRIs8hR2YB5S7h2kkexkkDkr+LbrL2VAxE3/jwi2qjQHexVaKH7OVv7puVZX+z17v/09k+sEBzrKum2KVKz4trg7d2tJEGoLFZouKNMi6q/WfOOq5kufGwWAeRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeXPfqp8niC1Tj1sYsrzI7NXkVftCYyhVBGQ391Krxo=;
 b=Ygt+l+drzs+QjhJt8tFTGvHZW/jeVy2qjETJ8OfKR7aK/EeElacg2I7RNWYf4cQ8vVSoPIEn54MfW0dIWv51EwMPRjSfqgHUbzXpGq3cwZXblBBUo609yAa1S9IFm5xaFn2O1b9ISkguATV3yj7k3H0OAbbSMCXNW/sHxcjD13a303GiblL3nV/bXNMiHg3fIEwkWtw7FPp4tcgMgZMSAbfCq5Rsym8Dv1/6EnFFUonBt5O1V+R5O/j5P1MaLMV7anDWwciLb6BgmRqBS81XFP07zufAP8oGFk9tVDLROKm4vXlVU16dS/Ps4o8Aj3ud/UOtgtV5I/Oc5MOSl7FR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeXPfqp8niC1Tj1sYsrzI7NXkVftCYyhVBGQ391Krxo=;
 b=OdFolB80vdczReENh9G2jLpwB0YeDjo/pAAFCVtLWsYP7wuEO+zo5vwBWEGbAzqcS0hWFc26xwQBOiQzJFMkANymcLpejUmxlfTpp5/MNDqWzwsGFUHZ/Y2NAFKTV6ZENlz1K+eQ9ajPGTs21uTxCF7BxNbUfKvK9Hu0EtkkzYLfINdrK/BdzvuOE0b5bJLiVcYZxSLuwT1WEGBKXlWlb0Swg2To7PEdD3i2PMnMkZ5D1nKrwBVs4B1I6w3sU3XxTjM/4zGAsgNdWR7C3FXIQlMgCRjdr84ta60XrTtjyxkOG8JbKEy8E3rw6PFLPUesBbuAvD06yhh5AWDHHgLO4Q==
Received: from DB8PR03CA0023.eurprd03.prod.outlook.com (2603:10a6:10:be::36)
 by DBAPR10MB4219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 06:51:42 +0000
Received: from DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::16) by DB8PR03CA0023.outlook.office365.com
 (2603:10a6:10:be::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Fri, 4 Feb 2022 06:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT030.mail.protection.outlook.com (10.152.4.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 06:51:42 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 07:51:41 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 07:51:41 +0100
Message-ID: <ffb17cc2-257b-fc1b-0583-372caf19a854@siemens.com>
Date: Fri, 4 Feb 2022 07:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-dev][PATCH] Uprevision the cip-kernel-config to latest
 one
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220204054018.629071-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220204054018.629071-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ecae4c-bd95-4c6e-005a-08d9e7aacd2a
X-MS-TrafficTypeDiagnostic: DBAPR10MB4219:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB4219CCAA1FEB86D8D3E2715B95299@DBAPR10MB4219.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Bk+gcNTC1uR9CblY8f0MOwU4zytKKDXPlXygg+eh56YLS+hj5GkJln5LHDpWuPNERPi5FArNwe7HIm9UNtlH6gwK89LE71DyilCTkOBhWCvgH0HA3cr8RQ8SdBzSSV+qTYiqK4Tbtt+NDv7p5mx5FZvEQh/GGkEs59Lew/40I7qLeSpi8xsw242R4nmNK7nbUC8372RYOrM+JleNU0cXEhf/U4hKr4YoVKss9f7OYYiNHzAj2C4d+9StVLCRQo1dVwUv23XjamdEuwlVnnDW/PbBqaWQrMA3ZjqWkLRUuuyFrl6Zm+NOvlu3U4rUiHP4tpt4z2IQnW62PxhBvT4qhxCzq8vlq9MRCKnKG/YcUGL6MGFK8MaVaovpF+1SNRMn7Rmj58n/dg6znSef3Gwf+etipP0zZmNcbZjH9Kc1YDgLK2Vp25xAmEEFXh7GQf9gCOBkZLAYfubXo8aV6wGQUTcniiOYTcWxF0WeFhh8685twJgeJ4GulyEFWzqqKj+uXV/vSipErOyMxqIaZo8DIYeMw7cNDwMxF2gcmT1/RWE0+HfUpBwddBZmr3tdqRBmlIeLIhBMjzb7MloZiWzvnmBXVRl3csoPuPbtws+yRzNzNwoUOsZ1TZC5mMxG0DCOowfCaAKsj+diUwL7Ovhle/FmWrJvIrSxj815Lq8KgsZ68+viUb1Aha3VCPNBp4TcW1+fOP+uHS7XzJO03l1HCwVgc2Pwf3YmABaLoeJyamI9I9NdUp3b/CjDaDWqRjxQ9guM3k5bxGBsu19WlfufEw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(53546011)(5660300002)(26005)(186003)(956004)(2906002)(2616005)(44832011)(6706004)(110136005)(83380400001)(36756003)(36860700001)(47076005)(508600001)(31686004)(82960400001)(70206006)(70586007)(356005)(316002)(16576012)(81166007)(82310400004)(86362001)(336012)(31696002)(8676002)(8936002)(16526019)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 06:51:42.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 05ecae4c-bd95-4c6e-005a-08d9e7aacd2a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Feb 2022 06:51:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7575

On 04.02.22 06:40, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Uprevision the cip-kernel-config to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  recipes-kernel/linux/linux-cip-common.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
> index 8fa8988..84515c2 100644
> --- a/recipes-kernel/linux/linux-cip-common.inc
> +++ b/recipes-kernel/linux/linux-cip-common.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019
> +# Copyright (c) Siemens AG, 2022
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
>  
>  SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
>  
> -SRCREV_cip-kernel-config ?= "4f80764b80a81f9590e927fb202f358465b322a6"
> +SRCREV_cip-kernel-config ?= "3f527304fdadd163e20b7a5a9cfabaca7506c716"
>  
>  S = "${WORKDIR}/linux-cip-v${PV}"

Thanks applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

