Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC9DC433F5
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 08:32:10 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web08.3426.1646814728605699237
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Mar 2022 00:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Sauzewzo;
 spf=pass (domain: siemens.com, ip: 40.107.22.41,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAg8B2Pnvt5i4whlNvmRPO9t7Xz1+t6/3ipUHxDwCu290hDVH0L+32zYIo3907+j/jJHKKWi9we7s4/uJ5gjxOkXki1cgMzB9sVaVF1tiYx4vaLIU5612qK+fVWkJT/v5gG23UFC5oTLELsownxOfIVhzUvTnU0NczpJmxHX/0YyuFcgvqO6Mb3Cr0qwX7ZdlakOXMcFTp1veKGGKk9IV0xpspvXt+qzwNxHy+oNXDwu08MljOp5jZkhepJH76P93FhuPyF8HOw4VHgbpOq+FCU3ZHTHa04+Qfdp+IZdPifYtL1OMa/ubtzHoi8tZpqxXqSP4iFRuS8uJ5NXDp90GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUPOUK71VHENxMjYBoIVsjRcM4h5aq56V/V9mzWZyiA=;
 b=G0GmO/9KSwOJ/sbqgKwQIavZHsV5oSYf9A4FStulp69mlYmnGtjcmr1U3zTITgP2XzzhiomGo/DBLKNRJBHUDDiMohfWnNDlqyB7Ih1mIIG3G8A1lAlb8DgWFiae3PHtTFOlPMKQjiHugsAzhtDWhoDA4BPreEuUzbVJCTRm/mLUYjCXm3jqLs+KuSllegGbnED8pL7M3S03IMwJoqIfnvRjcpmovZYfz6DqpH94XU4J4v84XEuMcndSj1OjpeNrdRvsVvQHPyOanotz78y5AxdoYkqF9wnZGeTk65Yo9xNJAEESr828a10qeCWhPR5Gn0AjguKMBb0nxPD8Jot8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUPOUK71VHENxMjYBoIVsjRcM4h5aq56V/V9mzWZyiA=;
 b=SauzewzoN6bqwA+y6PPRFXmFb8RvawpW1oO8pXCFNJ6Fq4csv5WYA5FIVyx/9L3G5wGgU8F5TkFmdqtuAP9OZYOuk3KKXHc+Pzjly7LxKRXwc4zALIQQAjR79fPEyP4CE8e/xFCwHBIQCBo/cpfKc5fjCWv9XXoQiM5TGIQ9OQpb4vhPJAS+4fy7LRisRdeRgq9XOjafRdGWbovGOv1o6Q+/oYAu2abBtNnWOgOQsYfK63M+KhEBdo1/sph3rDzKMwal5pEC4RoMz6iVjIDXnOL6RHPzE0Nv6SvKxpwVc27JW7ZUQEldCcxfgTAoECSB1yXzK+C10/Tn3ekoJAIqoQ==
Received: from AM6P195CA0045.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::22)
 by DB8PR10MB3275.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 08:32:05 +0000
Received: from VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::20) by AM6P195CA0045.outlook.office365.com
 (2603:10a6:209:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Wed, 9 Mar 2022 08:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT054.mail.protection.outlook.com (10.152.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 08:32:05 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 9 Mar 2022 09:32:04 +0100
Received: from [167.87.32.62] (167.87.32.62) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Mar
 2022 09:32:04 +0100
Message-ID: <542f332e-ce28-c276-31be-5cba29dea9c3@siemens.com>
Date: Wed, 9 Mar 2022 09:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] Update to kas 3.0.2
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <ad2edc75-1d7a-6dcb-ce4f-e920bdc36242@siemens.com>
 <20220309081911.958224-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220309081911.958224-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.62]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bddf25-bf26-4ce6-8a9f-08da01a74ad0
X-MS-TrafficTypeDiagnostic: DB8PR10MB3275:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB32755A9AFF165BD65EB08F8B950A9@DB8PR10MB3275.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PfQ1nyDI4LEZZjm3NrcFdh+xsfAfA1RhToSMZyeeW7s+auMF3oBPL6H2YqUJcQVEBXy9VzcKhxwAVYBD4y5av8/YARb056wZh7I4VqUDgkC3whFixviVBkzzyG7cri2swBradAOfRzx8wB1u7RI6mbZQRNNf10Gwa6HI1g5DEITyavP3dLOBxQSLQeyYVFIIxuOT/UQxguS/IUD2TQpUmrQ7QVqI5viKc/bHAKKqrvu9IZUcUVszxrt5BrERM2rCM+QItKdJf+zE9K+YIK8BW8evfdKFC2Qhy+p9b/nqGjiq3I3QMMzD+HFRUUWTnYBHTNaK4c8jsOMddYi9J7Spqepj2qBRTD4+YkcIdjy+UXmAIne1NAS7gHcoAEbvsEkDoO1ClVlpRBe9xTJl/uX1scPXElid70Pe2zW8QKDHDMk4SZiK9rxQkIW/eW0EHzqPdeWGBnl4xbeRwA+WazV8EZk5VJstRywsvETdOTv5tUlh/NKwoYgFkoSuU5w5jaALkA6KCbbUe3qOX38Pin2hRPRgDZQzzwC8VDejKVvi2zx912z7QEICYIKPJAMHox4blBM/73nydX7mqmDK8p/azVMFYRiQIOJyIa7/IpcvBZOTUYSZTc11Q4hpxS23vo3oLKRaoxQ37odoXb8pdRkgLK2UnOkwmpjXYcR/lMM0LD8WKOzAHaz93i2GYOCesElOAFZrMayUjPWqnK+mIYg+4YPH0lSSNGUzT51eNgoSa+7OWDB+O+xR5q57dfbjKDMZd09T1CXvlJ3bz6Qi+DQtEpM7OgW+ph3Viexl0CnZAdg8DUmgd3uRisSSkWIS5stok0xszWF7hmf1fN9avOLvhviu6FeULyreUFgD9oMhYTQLyQzosR03YrkYxuUGxUHWaO5N63rDB8cCXHPe7pZCiA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16576012)(86362001)(44832011)(53546011)(8936002)(31686004)(5660300002)(6706004)(15650500001)(36756003)(31696002)(2906002)(47076005)(966005)(336012)(16526019)(81166007)(186003)(8676002)(2616005)(82310400004)(84970400001)(83380400001)(40460700003)(356005)(498600001)(82960400001)(36860700001)(110136005)(956004)(70206006)(70586007)(26005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 08:32:05.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 91bddf25-bf26-4ce6-8a9f-08da01a74ad0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3275
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Mar 2022 08:32:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7683

On 09.03.22 09:19, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update to kas 3.0.2.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  README.md      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c06c783..e2ed919 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,4 +1,4 @@
> -image: ghcr.io/siemens/kas/kas-isar:2.6.2
> +image: ghcr.io/siemens/kas/kas-isar:3.0.2
>  
>  variables:
>    GIT_STRATEGY: clone
> diff --git a/README.md b/README.md
> index f7cb86e..ff973c5 100644
> --- a/README.md
> +++ b/README.md
> @@ -12,7 +12,7 @@ from scratch.
>  
>  Install `kas-container` from the [kas project](https://github.com/siemens/kas):
>  
> -    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
> +    wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
>      chmod a+x kas-container
>  
>  Furthermore, install docker and make sure you have required permissions to

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

