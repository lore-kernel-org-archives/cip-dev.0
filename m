Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6463C433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 13:59:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.44])
 by mx.groups.io with SMTP id smtpd.web08.7474.1665496783694728946
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 06:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PxrdeI3j;
 spf=pass (domain: siemens.com, ip: 40.107.22.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlfOAqw3rsPlElKAa7DAyou1Ze9O6Q/xrs/yZgKZMP8fc2pKp/IZJh2v7smgiG2FOdP0VHV0zhVd2daXn5DoPtKZpaufPBf3vRxiXcPCujxzo3uPUXgXpwG4roIoyA0xv4RuMVosx05Uxi4H/ZPh/CGe19asaRgz8juAbyqM4LuBlyZRjqeLb4uCgxkvb857BeE7RRx5rMQH5AsLjmq8bypJVszoYFzZkSJNyKpQLsn+DBDEDCZmoZoUL8HuluaTfosIO7iWNjaPh0muXi7zMW/2EGZ019NZIoqMf06wBPMB83X8w8ndwEvRfaCAdtCTvYBfhuc62ZgOgyMIP1040A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUoCmy5hH7mlfrQ5U4LMJb3A6bVy8TfcH1OB/EQPzdQ=;
 b=XiV7RHPW1FziQPN1RFq9LATvR1RE0U7clcFglmctItDfZnauPQGHbsIugNuob4MppoFmXR1q/QX8BnFjq8O7aCn0v3HXUwbFC2HtSd0SpSpcS0oLzDkLk6eZuRo36kPFF2qdXlVjGbagG7G2pMAwWzwWj1O6EschcoibLvvYrQuqgg9QBTV3jv4F4l0RnW/dxZlvgAxk3GzWL0XUmSiperCl4c/2BLMc0llGrgTy1mlVLttcL5cEiVHSClgDUR1v5uYITG0xBT1ziXaUCWwRrg5lUsboR/qqI9wT9eCjZ5qnlzgh/RsVqFnyOzU1UYDesWqW/F5BPXguSiI1Pp8+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUoCmy5hH7mlfrQ5U4LMJb3A6bVy8TfcH1OB/EQPzdQ=;
 b=PxrdeI3jWIehefDVCOVJqhyFQEeinxasq2hsdrNywaebcrG+mA+Xswwo1BW7fMlH7EW4RvVLhU/d2+IK+C/p/T89Q5SJfCaCnrDHJAfa6CKw0Vywbbl+z/qFx8lkJRvpd6Gw2IV7UlIrreN+C7zTYDG+nTXCgZ/ebt9WcR5DS6g2ybWkQO3TgeZH3tC8pAB/e+F+34UOOrftMJ6onzreRuTn0pPNLSM8IPzIC9aC2Trl312XAiwNxBjDdeGdj1BO/A9Qy5WxPL8IFX5XFlu3i3iKsphRNIM+5r7K8f8+R7J4mGNlNBtNrQjbI0LzgojkPfvHJcUH8kaiXT2ZnQylAg==
Received: from DU2PR04CA0285.eurprd04.prod.outlook.com (2603:10a6:10:28c::20)
 by PAWPR10MB7151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 13:59:40 +0000
Received: from DB5EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::43) by DU2PR04CA0285.outlook.office365.com
 (2603:10a6:10:28c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 13:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT093.mail.protection.outlook.com (10.152.4.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 13:59:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 11 Oct 2022 15:59:35 +0200
Received: from [167.87.52.10] (167.87.52.10) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 11 Oct
 2022 15:59:35 +0200
Message-ID: <d1f34062-1403-b8dc-f4a6-abf3fae82b94@siemens.com>
Date: Tue, 11 Oct 2022 15:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core 0/3] Update secure-boot documentation and scripts
Content-Language: en-US
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>, Quirin
 Gylstorff <quirin.gylstorff@siemens.com>
References: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.52.10]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.044100-8.000000
X-TMASE-MatchedRID: zzMRqZEINU7dDS6etHbe24ImQ9+0uxVGSBgsfuUbPhv2b09s2KGDsAvx
	MaV6x4s8C/U4++8MvOwJfh8gHD4nu20i/QDeFI5bsvNBemC49yXGt2xdLsY3ZCoiRKlBVkYInKp
	Qna4coUApXgaagqPrSMhyPab4fvVvK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063
	Wh9WVqgmWCfbzydb0g3n8eBZjGmUzkwjHXXC/4I5BlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.044100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 47D79E800FDE39974CE1D5539FC8511DA3663B2C0001596D0D327C749332F8A32000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT093:EE_|PAWPR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a14860-cd18-4b0d-e99d-08daab90d69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tp3el8W5VsSagdjl5E6iOB44Qb8MWQzCuedRKs8RFGewU+WriIocPpxKVvV97GSX4XqgNAflvgAunOwUGa95+LRBUs7n9sY193T5i385KVzWLEDywUTZsNFQuWB/RkrvbxBUyNYDrkQPBEyl1yiMfgYXgMW6MJJtS3nyS2u00JEwxKIEruGlHSOq63oACmX9BOgyL1V+qltnSnYQaZnbRyL+aDisJ+ygzaKykkWLgruRYggEqf193l8vQTEzuCMCaAGzOGyPJuL8bZzuTILEjGmx9VFc1HiP19qAjVKszi4h3WDut19qzHhNmfJRpCV96T+MgJhEAAM+6c+ewqa+TMugPMWUVZfLstjeTfj8IyCvQ7c5peXbeYihzkjylCCyyhhB0GLKdTdooVBt79w+qaGuLLE0jtjwA1UVsDs39IVllyQHYAVAIKq680vjebRrvwKRBIfTTHBkh7eZHDz7Q2B/UV4dmBY4P2hdflT84c3wEnIVRWVIlXIsu0QJcKE2D03ZLVNUv0vfCI7wyeO35+Id8VpowVO6BkqgnsuV63g6nO7CC8NTyDiA5cPx5ofOI+aFVquSeC9Lki5ZjM6tiNpvNaYGtqxxSck/1SPkcF2fHWxuTyWkWoOmMi5ODVXGU5OHC28zDrC2+RS/WVc8762dbisgCRp8oSmGvdsty9UVzQ+hm+VuZqFasaLzlvWi/kpZ7SZrzHNXhSLn72zlJtq7nLYHvQj0SX6IBkPAvlRR60qvpobnZOCO+/UUITuVN7F8S2vqMcDzkd+/qNGUDdTqGPe6olEHM6DglaXN82NKPLNzD+X1Fzk83Q0wj9ukYNVbcOOknF7+Z7ZDqgNqfIBCsSteH1K99Etn8yRu0Ug=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(82960400001)(82740400003)(47076005)(40480700001)(31686004)(4326008)(86362001)(53546011)(31696002)(110136005)(81166007)(316002)(6706004)(16576012)(956004)(2906002)(41300700001)(26005)(70206006)(70586007)(15650500001)(54906003)(186003)(36756003)(16526019)(8676002)(107886003)(2616005)(478600001)(356005)(5660300002)(40460700003)(44832011)(83380400001)(82310400005)(4744005)(336012)(8936002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 13:59:38.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e8a14860-cd18-4b0d-e99d-08daab90d69e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 13:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9719

On 10.10.22 09:02, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> Update scripts to set the default distro version as bullseye and change default ovmf files to use 4M size.
> Update README.secureboot for user-generated keys and bullseye version.
> 
> Sai (3):
>   start-qemu.sh : Set bullseye as default DISTRO RELEASE
>   README.secureboot.md : Update steps for user-generated keys
>   start-efishell.sh : Use default OVMF files with '4M' size
> 
>  doc/README.secureboot.md  | 55 +++++++++++++++++++++++++++------------
>  scripts/start-efishell.sh |  4 +--
>  start-qemu.sh             |  6 ++---
>  3 files changed, 43 insertions(+), 22 deletions(-)
> 

Looks good to me, merged to next. I had to rebase patch 1, though.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


