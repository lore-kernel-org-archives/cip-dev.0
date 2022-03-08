Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A9C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 17:03:46 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.49])
 by mx.groups.io with SMTP id smtpd.web09.10761.1646759025463527775
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Mar 2022 09:03:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XekwIbzV;
 spf=pass (domain: siemens.com, ip: 40.107.0.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dx0Ec5vfvC42xBzd08JFryALzMta5LBrDvtL7Lm6DS+HDv7g6czdhsvEzNUKYU1KcMk+SZsj2E83qUx5t1O8v8cS7YHvyGv/MgooY6m0UFIus1Nf0oLffr3pU15xnlXmALWN7KAScPTHe7mxmkdZLEJ+SzeI6FtX9dSyTLP7m1Q09ndeUYI2GNGwTZB8nQr+lV3osdo3Bqexwlq3znAjSqhiNwQ1Vr5ZpAseuX61O3JBLEWoFANkUXYdNo1WFc67y81vbBZYOwLNHqk9uEdGPxOr1S78zBbEaMjGPtX8tsr62aezno73zmQY+gT/YntIokHBpW+kZt1hRg7cce9Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s8C9J1NRePdON+poGEh3b1Tuf0t3g6AQcZHO71/Z2s=;
 b=GY9H5VxSYDjW1InjWNB7YfoKI12uSGal4UHkSrjV6jilSkL3MsTZ/TfyKMJrYuBrh6WYqKlltXT5g0iu9BQ84VfPr4If+o7LMHHZaSu8Fko9AqKcpudEiCA3nztHIRZHUdk388mgf5cEhqncFZ+4j3tu/6qhvXc9j3+54l5XALS5awK6IIHS+FD165mVXNoMoyc2uxwrQwdaW29d0swrKzwnmJ81Z7JOt5J0aTyqEF+CoO9FpBzDq9QJcL5W3FfPfVZ8HBu92JdH9/GxME10S+gp507UdAVk2d5Ih+14NOO4ABWxrjPfGf7uLLb9SNdaOzxfMTTQhUQbrfWGSEpfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s8C9J1NRePdON+poGEh3b1Tuf0t3g6AQcZHO71/Z2s=;
 b=XekwIbzVixuVxqTt4f8gZtHo3OByVncj2DBn/Ln7Uiod2hcr1CdgpYaXZs08GoqK2LckeKmWrKXbM72/Oc7UswPJHvdutqBBR8+D1tBgWse7jyM4Gr/Ixg3jTfSTACTX0ZjonQFAi2uDUk4jQywpj/9YKAp/3Ym7kmhDhY2Fx8eUZer35ZZfwZIKK1KuktrSkBWy++kaSJvtlvXl44V0dLznN5NsfBr6wlkm1lxMuBO4lzkvJztRmJSAqfcYq2FrNIII4mrsAfh6+eK2EODIsPTf9O2DtTPycasrKsZQZ2qFHwkbEiiPsU+C+/fbqkiliDXPsCGhYFCdY2NTypE2ZA==
Received: from SV0P279CA0063.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::14)
 by DB6PR10MB1606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:38::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Tue, 8 Mar
 2022 17:03:39 +0000
Received: from HE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::a) by SV0P279CA0063.outlook.office365.com
 (2603:10a6:f10:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Tue, 8 Mar 2022 17:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT026.mail.protection.outlook.com (10.152.0.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 17:03:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 18:03:14 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 18:03:14 +0100
Message-ID: <ad2edc75-1d7a-6dcb-ce4f-e920bdc36242@siemens.com>
Date: Tue, 8 Mar 2022 18:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][PATCH] Update to kas 3.0
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220307093403.282069-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220307093403.282069-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.7]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d5fe81-320c-4d7c-539f-08da0125975e
X-MS-TrafficTypeDiagnostic: DB6PR10MB1606:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB1606E54424F915C9729FC06395099@DB6PR10MB1606.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4P7Efjfu6lIXVkPUpH5nmyO42LL+TUIfjSjMA+pPiPmGL+ghZhog5NfLl44cjO1SumU8aSWgQ7tDM7oes1KyeNIPkFHV6gaXBguFV2iRqHulqQGCGAswzExuK5O+iXTQjm5kMtBZBZi+Bom+DU3SLQ6ixf+suY7SAn927EQ2F13Vr2JXMNpAyEIGejWwSK+jssG27mHWlQWQ+/yRsnHlKUtr1Oxb2AnxOSVQyMMmA+yNtvQpLb1kYef24ALVIlL0zFmtGquMp65l7QGFlZT3qoUicyZRoBViFXu9zXanePh05doX3fy4h8pRwcWUwhNrPjrIZEVNkHk3TmJJ6Y1E2AZ3djCCRUoo6uvGz0xhVlEz7soFpuRrZkBwu5aX4oBF9AGXlLdCmlvOQvy213bwbtsyYMpHj0hGsjFxYT+VyWC51Tpp6pBetNxdfPUqul3PUqHxaiCrQvjUjaGPxfx2RX6EXNBOgXQ5FyilIW9do+F7lHAU4HfvRFNuIFjGGhlHn17OuohBUYseNE9YMSw9k81UGYCtT0pkMbBLiKqpAwFAIBzJCPsfHHH5hBSZ1c4dZoH2OvoGJi+AmI8bF0oOyrYJN1W7ri3ZPaaBiVxbf5oQ8caGO0Lv2mlwJAjd5oka3hWTxbQZpzhFKTMrChkgqHZUVQ1x47GL5iG0dN+pVueNu8mpXTUX+cAToAWVSAYZytEhthiDC6m6szFoj6Uk5QIw1MUoXg056DILE8Fi8y3b2o8NpoCSOMnkA0sxh/TbxFEXQPz2v9CPZ4f6IiLdqlnRmkn3QvCWrCwcQSNIPqWJWkuoeevbUQPCNJiQdSFoUQaehWuJT0pUNfZjq+v8YU0wOdkP1N+mTCXR6URprfyOje9R+wgwQOXWkldBn9VflW6fkLSTjoQ/pRwXzHQMqw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(316002)(36860700001)(40460700003)(2906002)(84970400001)(82310400004)(5660300002)(6706004)(356005)(81166007)(110136005)(82960400001)(8936002)(508600001)(16576012)(956004)(2616005)(53546011)(70586007)(47076005)(70206006)(186003)(15650500001)(44832011)(16526019)(336012)(83380400001)(26005)(966005)(31686004)(31696002)(86362001)(36756003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:03:39.0524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e0d5fe81-320c-4d7c-539f-08da0125975e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1606
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Mar 2022 17:03:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7671

On 07.03.22 10:34, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update to kas 3.0.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  README.md      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c06c783..f573da6 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,4 +1,4 @@
> -image: ghcr.io/siemens/kas/kas-isar:2.6.2
> +image: ghcr.io/siemens/kas/kas-isar:3.0
>  
>  variables:
>    GIT_STRATEGY: clone
> diff --git a/README.md b/README.md
> index f7cb86e..fc4ddbf 100644
> --- a/README.md
> +++ b/README.md
> @@ -12,7 +12,7 @@ from scratch.
>  
>  Install `kas-container` from the [kas project](https://github.com/siemens/kas):
>  
> -    wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
> +    wget https://raw.githubusercontent.com/siemens/kas/3.0/kas-container
>      chmod a+x kas-container
>  
>  Furthermore, install docker and make sure you have required permissions to

Please give kas 3.0.2 now a try. It should finally work without
undesired side-effects.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

