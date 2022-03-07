Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE7C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 09:41:41 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.45])
 by mx.groups.io with SMTP id smtpd.web09.24702.1646646100001017014
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 01:41:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DwFQ4CdT;
 spf=pass (domain: siemens.com, ip: 40.107.2.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln2p3eEpT7kYDi4pduOuxoG4LLdW373Q4h8DLDiV9oDfF5Pu0qbjfgcN3RsTYSeQLYvwHyKTqxetbdqo+yfSRDG/QumTeVlfAW4pwIN2arK1xRPDvFb/fWXj78hWXLy4ninYj+t/AYh4srn5UbAEU/I5jJAdCEhRWxUXpy8YyXn9IQWjwVXMKBo+VE91xLo4RYB1B71Xtu48IAP4YkNofs4he73YGAcChjEYA4/O/xSm6RAII9GsuGnfY+XeAx5/2XtpwSU49+rMUhAaIRBvYHoh3IcO8KLIxjE1/R9liBnY1YXn2CamCbZE0a6oqF+MFX7JkpxjsvOSnxyoyRsTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLZI+GZqm+74/7VJN+T5eXs78qcT55nLouVd3w6Wh20=;
 b=MNdMj/ejQsPZN1EgBEH8hVRJ2fc82iGf2XBQ6IREkd0jgFnWhMH9JtbVSpZKHaSv3V+NpHxkrb7KSvL+4fhAuvjGasNFQWS+l+TKF0+8ZyndbkxGtEj2pCfVTH2Vl3ZTFhasrYJXMxg7zRGe8KyRkvjN44zhjGuIP78/iDnn2xxzjfAbrgz2Ykxv8q/Ycj7QgkZuxQeVKpMFhdf5qhM+dQvVKxBnpUWkfBScJA41i6bQwvc3Y1DTKd6vweV4+XIjlaoNSS3WYCg/A+6VVS4OdIuGiXzR1+8yUrVRu/ct1vWrDSHpGtP2EknSN548HmIYoaVq+zhhaq2/xrd8uBHtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLZI+GZqm+74/7VJN+T5eXs78qcT55nLouVd3w6Wh20=;
 b=DwFQ4CdT3fsKAAzpc/Op+HFKfk6IEwStPv0jg/YlFGLq0N854YXCcnFtsoC1ifwxOaECHnPQp2OpTNjt1s+scgP9RoGR96jS1ac+9KRXexFkKyMOiMPGa3kvGCklGDA+j4sq9C7aT4JdAla67FtVTVxls0wr1LHmgRq8SNJH86M22XNdzBerMHy6BFCRu8ej/nalbUMlcU6ietLayH8iWPrOmu4Oj1Mfn5WfDEdKgCsaU+qtMdCrCJmYkcQ7jrAJfRvmdviXFaK5dW7t3tubcppM09ajZvEXFy+ZguhrW6pde7ypR4nIEzE+nrb87ZTRTynZn1ccValkXZZ9oQWcFA==
Received: from SV0P279CA0019.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::6) by
 AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:46::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 09:41:36 +0000
Received: from HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::ea) by SV0P279CA0019.outlook.office365.com
 (2603:10a6:f10:12::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 09:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT058.mail.protection.outlook.com (10.152.0.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 09:41:35 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Mar 2022 10:41:35 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 10:41:34 +0100
Message-ID: <f824e211-66a5-e959-f31c-d54e5565c7a9@siemens.com>
Date: Mon, 7 Mar 2022 10:41:34 +0100
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
X-MS-Office365-Filtering-Correlation-Id: f2702b8a-804e-4bc7-ac92-08da001eabc4
X-MS-TrafficTypeDiagnostic: AM0PR10MB2082:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB20828ADE7635983F14DCE50A95089@AM0PR10MB2082.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QhSyg+dr5O6FTBDkMwdrsmUOONY9HgVnjVOX2picMoVTewfFLhkvvrR4QWzLNs54TOzRS907P5zop448McClzbwqKfppHQA8LEmPbzoEByiMBgnFxDPoZPntXxA9hh5FxXyc4VUH+ENQaNDDV9cFJ9t54eYKDy4XKSDH2Ds9L2TBPKrRqv9qDPlDHBtl2sbVZi+UnOB8QVShfukVpJVGIfMTWFTvQD4u9Fggu4ZEHBCs0tzVvdcclnqC8i0tedPf1RzaHTCKbI2o2GyfrRhzVtk2Imw7yx/7CShoAYAvPgm1lxqx3xYwvYO3mOjcU6YzojEFzGHx51FIlmzOHrzTV2Y2/C3pq4nXJsGUfP67SbWmPUnvIBBPs7laRLs3U0kLXZ7otNYbLEWrw6Hx/twO8Qp+T+a8QEg7moUXwNPJBRuEQMMYAYKq+onXv0IKxEQlykQglkW9E9Mk+bUzRYgomG822H/7x/69IefT+GN98Gss24HGHnPEa2jJOL0D8WchVjp0UDIS0H71GMC+Vg23NmZjSonpR7W24YfhHE+34HzN1WSW8jm1m/0b/JwkSsRsnbI6FdLp/8jGwIvpXViW6thjHNQyXkbtx3xJCYiWGHcSL/Jd2a8QDWJwyKWsElHf16LOVX/ymHF0yypGSmlyjrpa3veqtERIpEgl25y3S9Ns2ezXcij9sDPjW2L9XpOJuYj5xQzl7PdvrK4vPtj7g/H3csc2wNA1Fod3U97vZhmGXZ6JEXLQKoso3mPXmujFfSzgRtj7DpKzstUQ4vVh3k19h4JEHzppiMspeIUquCVt7Kl7yw7q9N4YGFnDp8GkHNltIL0KUmd5ajZPfJWBP74YUfVq1T4YIyuzV2a/K4c=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(15650500001)(44832011)(8936002)(84970400001)(2616005)(2906002)(82310400004)(53546011)(956004)(5660300002)(83380400001)(36860700001)(47076005)(86362001)(31696002)(40460700003)(26005)(186003)(16526019)(336012)(31686004)(70206006)(966005)(7596003)(16576012)(110136005)(7636003)(82960400001)(356005)(316002)(8676002)(6706004)(70586007)(508600001)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:41:35.6377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f2702b8a-804e-4bc7-ac92-08da001eabc4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 09:41:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7662

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

Please test before you submit: We have an open issue with kas-isar:3.0.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

