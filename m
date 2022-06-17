Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37795C43334
	for <webhook@archiver.kernel.org>; Fri, 17 Jun 2022 15:03:01 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.87])
 by mx.groups.io with SMTP id smtpd.web10.31452.1655478177811775043
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jun 2022 08:02:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DFJqPZFC;
 spf=pass (domain: siemens.com, ip: 40.107.2.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7of2Gohje0tNBXEzjGPEioak5deIMNgr/ETQJckVOxTPkaaO0ytZKOKQa+ncN61NRHgMKtaGeqidTGpu8AJuwPWHP3BqZllNAkw/JbcesniUhaXx2zDuIFCyKuGcU6IPcPnubOSKp1uKlN6hoyh6CKtUXjG21ZxmmIyDkmxMoGUWMs7OTa+QYRbRWk4PqAxFAjKuSC0hLjwaUooZjb4AD2+q48Lx+1i6aP/NkPL1pqiKmHy99pyyHgP3lfThBN3JodnGU8oDeuOy/eSF+p75PU+neMtk1D+vONXzScCYPQEtBmVQrGcymTn//GzS03mMuV48nvXnZZmOdIVAiVPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Ny+brUs411DJWBT29Yf5VFH/nOj0B2DSQza48ISUI=;
 b=Vyb7q2jt8OtyLN/XcFBNvvc2++CwbYTuUdkNLdiywtQoZ2gLCiW5+Wcgcg1caPB16Qcqtf3r89oMnGwJ8waq1KOGKMF8VPD8eDTHbTVCBD58zBJ553HEUDc7sMPpHqGrLQnrZSQZXY3TfdKxDkNF3wBGWJ8bzy+/pRXwqFC4UsYRWK+tH1XNPxTrYtt+C/A3efv2xdnCH45n3QD9OKlBQ4G5k6vKI3t2MbZbgk3yxpdzzECfM6l8b95qds7VtTWoTZiIH1VgrILK398yJxd654zm865Zcl2w9YT7ZP2FPLjBTg/D/qtVCYiDvg+wr2y9/lmSgZjI7My/yGwM6XiQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Ny+brUs411DJWBT29Yf5VFH/nOj0B2DSQza48ISUI=;
 b=DFJqPZFCpGwlqlWr+Rw4eO4zyDADT9sM0TqEA1Dr/TQ8/G8Wz4nhiku3uxcAclcl20IRM02IEvPJD/2huMmAkeJ21+UlhMDZ6fqrtAk+IeFOjUvaQweNzYYrAQtchACgq+uLPLlF3R3J/wgJnjRw0WOSKhhzEFNlX2nq2Ld1kJRzcU46MKg5/dq4sktEzUNjNsGiOafb1/8Qq/DFjTgs2rPOgdo0SUJ8/6U5fNaP5pI/H72hx93Xu3GlepOsxeokAu1to28vZhNMrVib80rTeIl1vJbr+LbrHmPv69fbFPo6lgY3NGfgpYVCWC3iF2ekmvsuqNAshuXUE8S4r4EOkw==
Received: from DB9PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:10:1da::26)
 by AM6PR10MB2614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 15:02:54 +0000
Received: from DB5EUR01FT023.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::e7) by DB9PR05CA0021.outlook.office365.com
 (2603:10a6:10:1da::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 15:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT023.mail.protection.outlook.com (10.152.4.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 15:02:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 17 Jun 2022 17:02:53 +0200
Received: from [167.87.35.216] (167.87.35.216) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 17 Jun 2022 17:02:52 +0200
Message-ID: <36fc490e-dd45-2922-e7cb-6adb5f675877@siemens.com>
Date: Fri, 17 Jun 2022 17:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core]
 cip-core-image-security.bb:libpm-google-authenticator debian package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220617144440.1846381-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220617144440.1846381-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.35.216]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.917200-8.000000
X-TMASE-MatchedRID: Am/bhnZHfiMwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0awWQIt56582zim
	0TkqdUteXcwgKc3gFlkWFZo+2Qlj9EHz5VM62tSTZIK/vRWIBgtiWV0DQ85LUqXZvcUfKhsohVD
	nkfzD7uZk2Y4pEw4KnjK2ieu8M5yxQsutS+v7Ac9wSiDz1DbrnZXvqupO0P3ML8y5bOx03xnLQx
	8PUawjW5soi2XrUn/JyeMtMD9QOgChMIDkR/KfwI2j49Ftap9EOwBXM346/+wo0HIEc7e/mo6qE
	A//3As0DlnTLub63KiP7pPTMaD243usHkf35QjX
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.917200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9B628AA258E39DBE5C7A5C57CF3C3F59736E0F88A68344ACEE17295DADDA81AF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31d05110-81ca-46a4-5434-08da5072745a
X-MS-TrafficTypeDiagnostic: AM6PR10MB2614:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB26145DB21091E8D36E10614C95AF9@AM6PR10MB2614.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N5Ud2bod49q9Z6AGgv16EXad953pOXiilR8UYyCujYopkSAuo8q5wP7dwlxDkwP3q6hKa+HFnYLwaDOwVEfrHy2eN3m/KitYcVV/+pVv3t4gf6ZHvbwgogJq5boSh5VigU8PXC8dW7EGmI0vNnu/ZlzOwFZi/E/GOeFT+396y13XD2aApLFMnYLBvK02adDqU+2j2IvGrTcBre9Fi6ex5N074VDY41Iv8ZiS8USqhRieJ44yX400WUrhcmu9VlmY6pjdlVlYpmec9qaqAqgpxtWIzLq9KlsPobqNdYVGTqG9Uw2P8Xs7K5gAIcD4y7ICEK0EzsBRasAOIu3emLp3xnjn03YIPsbQO2/H+oJiLtwYfeaaK4tWTctp6HCZBkGG73lipgSYejTS/207iWc+kxw2W+RF2YQ/p60SLW5OJ+j+WTCfYGus84vIRWgDuZ5LVp/dLnub8FJpva2hYQy2qvGtDlXh9ljpohSJX+J6YWf5iKn/ZbRyoemGSehb/O6qRh5+HE6WQUuWTRU09CDftzryK7e4t3M5zahjCsbki/IvoUAelepRRxAJXjLHTVXyBwcJmp79DjyzJC8OwlE032mWJIAWTa4v4YreDx9Meqkkb433i1VyphgirM+y3fXW/YCav0s1ALQPB6blFr3Z0YXf/RsAW/avk/Wr0fNj4Numd8OlxtdznlBAFAaSnyaeCuDQ2eH5Yn2LRxmPtDLPP/kqGbQ/DlhKSvuFrkmkz1qlOZ1qQEcWnK3simByH+ad79te8K9XJ1XRMkhOCJpGDQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(4326008)(4744005)(44832011)(2906002)(36860700001)(40460700003)(336012)(15650500001)(70206006)(54906003)(82310400005)(16576012)(6706004)(53546011)(26005)(508600001)(31686004)(83380400001)(36756003)(2616005)(70586007)(31696002)(86362001)(110136005)(8936002)(8676002)(186003)(16526019)(82960400001)(5660300002)(47076005)(81166007)(956004)(356005)(316002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 15:02:53.4135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 31d05110-81ca-46a4-5434-08da5072745a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT023.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2614
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jun 2022 15:03:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8578

On 17.06.22 16:44, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> Added libpm-google-authenticator for MFA authetication for remote and local session
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 3ea544a..e56d279 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -32,6 +32,7 @@ IMAGE_PREINSTALL += " \
>  	audispd-plugins auditd \
>  	uuid-runtime \
>  	sudo \
> +	libpam-google-authenticator \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"

Is that thing configuration-free? Or will the customization recipe need
some tuning as well?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

