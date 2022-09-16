Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B4C54EE9
	for <webhook@archiver.kernel.org>; Fri, 16 Sep 2022 11:32:49 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web11.4871.1663327965481940748
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Sep 2022 04:32:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zGdbHZud;
 spf=pass (domain: siemens.com, ip: 40.107.22.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEpr8KxUJPMrSBBLnSQEm925y2R6ScHULu+7E5kRaZMmpgtaddpkYtfLUMlKb069jVVnaJYztFd99++H/8hSxpTYT4g1cJDt12bnDS5/ZAp3jj+DCwTiBTJkzWI8XloG77Ll8SW6T25o1ZxfRjum35nhdx7ckEFqgifpkozyH2NPguTFu5hHWoDwNXNlrB66OGAj+CLOO6Ig0KNdNcYMS3hOVEyq3pCALpaeIaGKsxx3qhkYhjfytcygD9w46J2B1TXUwPL0x0C1A8osiWmQ4TFCG2WPVX2JE9SyvWShzeCqo/6GSMNBdJQhQKNQzfvxQFzSY3aHBnMEl/jjWg78gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7MrB3up/5eI0/x77OhDx+0IA7lSYDsOogi2qJJ+dwo=;
 b=k6l9g6jsaRO0L+vRUd9egp41HgB//F2GxnWtoUkEgIpxr4iHrJ2iVcf5foxtOg3kbsWeJA9KGPctbLhN9NyLJQFuOLE5IIHhFQ7l+QqYRSx+vsAb558OFoZq5Qs8Z42WsZl47o6d26bTKE963pgBHLN9zl971tJnqZ1ZDV43kEyJ28IbavROMR/47MsRZK6zzZLpOXpFwHDot4AS7rW1IuRP2VbVAwg51Ek+2NKsnF0Xmh2/d1xOIQE8y8HuJeME3uk+y+THbcA5+LpMVw7ECNv1Rhr3LRwYEyfXpY0Vt5ZsUxiOb+6RJzd5/9MmlPnGeMDFixdGeKRqvC5TtGEBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7MrB3up/5eI0/x77OhDx+0IA7lSYDsOogi2qJJ+dwo=;
 b=zGdbHZudL7C3IRWH6KZB6UX5ojPTcVL0ygUI+NMBwxPubC0/1c3S46DzA9JQzAEpTndw1BdTssH6S7mg1DEKrU/5g1Y+uRGHQ4ZRjIJ5KxwYYZFrrV/1ywIfk4rQVhueb9nHqM7E0UEf60Qky7HYv3HwF4wU+c/Y/e6s7i+4eW/GbqxQS0p2pLVQ5+0Ye0CCFqBvB+daSnLFacq57+AW6FnAbRY6qD2PlPilK4BNitQ7UnfMwNgRcUi1QbLrrYiFBu3hQ2QNmEHFVBx5EYliSdWYRN4JSnadNYAXESqMPTQHCKsxVktQoLKQ9Ulv9Z66/QIQmY2t0tXBn33uFDqgXw==
Received: from GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7) by
 PR3PR10MB3834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.16; Fri, 16 Sep 2022 11:32:42 +0000
Received: from HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::39) by GV3P280CA0043.outlook.office365.com
 (2603:10a6:150:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Fri, 16 Sep 2022 11:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT103.mail.protection.outlook.com (10.152.1.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 11:32:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 16 Sep 2022 13:32:41 +0200
Received: from [167.87.16.136] (167.87.16.136) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 16 Sep 2022 13:32:40 +0200
Message-ID: <b208a6e9-e23d-1e56-8b82-34af7b33a7cd@siemens.com>
Date: Fri, 16 Sep 2022 12:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core][PATCH] Update to kas 3.1
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220914131247.527986-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220914131247.527986-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.16.136]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.158900-8.000000
X-TMASE-MatchedRID: EhMq+2gclHvdDS6etHbe26x38sCrHdkHPg9yfk4YC0Zwju9EALAXQj+k
	5IvvZ1N/B2QWi8BF5Sgs8m1alsmNjbp7747Zmtg1Ta11FrGsOjBGoymhKJvVi3/HTU/OBaTGBgA
	+oehWZhGIXNJdL4wuiJQNdSgLxtlLTdANLWUWb5IoBEe6aSUEd45dVuh2ywvhXmFVlObh0PxBfk
	JWKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCIGsNX5eg/aOVnRXm1iHN1bEQdG7H66TyH4gK
	q42LRYkLeHZhVRXSUPVyFvIkpnUDvDNss/z/qwz7lJGP7ey0YF+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.158900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 AECE0A0E335A371DC07EE422E53468B1833B234706EC6DC6C6BD144224F571D22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT103:EE_|PR3PR10MB3834:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d85c06-12d7-426d-3939-08da97d72af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yYk8aJ7PmdRjh5PVTRP94xzcx/Pu7u3mjA7mB1A6iACutyF+nIDqkQVnz+CF2K0030Yw7adhIKDUqnf5IweIQc0rqaFpw3kNVCo/tYnEiMvqfk0KeFwndLtD+wIZilZ57jTH8RWc4/VHWmHUPWW0ouWqED4cb3vIb6eVi8zi6cWgwx6MP1FLeX5TWm77Ws6h974PXU22W+W9JuV7eVp5oBnWdZfOm0WlrJ2Y0M0MIw/ntkGbVuLqV2sHgVTl2djjkGperK7aO/vVoozyk+6qnJttxo8okl1uvmR2XrdP+djfeSIjVQmjqpeD/RkWFinY1af3/P8zmWIeusWCFuDPIVdQRXj4j9mokLc0gBD55x1AON5pvsf0WpQsg8GJKmTBRa/L9yedVNj2QjpcQYCZa8T2Jg+itV/204XxvI3dapojaiZN6twWSie3z1qrCngeL3NU6wUJx09P69spIEi6RMWbV/ZLOTXklzLaZ7bON/BXDcR0m+3aCHCtwk6uREohupSloCZQrt5IiK8wRTNrKddCCJkj3G4AXPfDtRK5Pj5eR7vHiMpsygsK9j0VlOCY8hfQzk4DuUAQ+Fvvx7ETVHxu0B6uS8wHr6sZwujLySSClBuLp4ihdlL3CdnqF5HKbALcD15iht7xLOP+QWwbUPCnKkeBxN7YPSnbxOlqThRhQ7jD5eDRmn9GIFkTiT3/hlnQPEqx05XqxYa2aJJF8opv3UgqdPSU/qyc8hCy1jaeNPe3q2AjJB9XqE/ncWernBsrfaWoQw5TlgVL0evjKVqeaqGvKMXHbKWFJMZmLNHaNROwyQcHnEM+lbTowOWVSJFlVf8y7C9J7B8hfj4G9kU2UwIHNfke0QGq7iLMApl+W2kno643eUrFgaVJvUUD3CvejyktYqPiL2s8Hj+iRg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(5660300002)(16576012)(478600001)(966005)(82960400001)(40480700001)(8676002)(31686004)(186003)(956004)(70206006)(70586007)(26005)(2616005)(53546011)(47076005)(110136005)(31696002)(86362001)(44832011)(2906002)(6706004)(356005)(36860700001)(336012)(83380400001)(82310400005)(16526019)(41300700001)(316002)(82740400003)(84970400001)(8936002)(40460700003)(15650500001)(7636003)(7596003)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 11:32:42.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 44d85c06-12d7-426d-3939-08da97d72af8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3834
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Sep 2022 11:32:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9496

On 14.09.22 14:12, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update to kas 3.1.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  .gitlab-ci.yml | 2 +-
>  README.md      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 81301e5..ce40b5d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,4 +1,4 @@
> -image: ghcr.io/siemens/kas/kas-isar:3.0.2
> +image: ghcr.io/siemens/kas/kas-isar:3.1
>  
>  variables:
>    GIT_STRATEGY: clone
> diff --git a/README.md b/README.md
> index ff973c5..e30ff3a 100644
> --- a/README.md
> +++ b/README.md
> @@ -12,7 +12,7 @@ from scratch.
>  
>  Install `kas-container` from the [kas project](https://github.com/siemens/kas):
>  
> -    wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
> +    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container
>      chmod a+x kas-container
>  
>  Furthermore, install docker and make sure you have required permissions to

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

