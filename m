Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11461C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Feb 2022 18:42:21 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web08.15449.1644345739408498572
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Feb 2022 10:42:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gGDVtDkN;
 spf=pass (domain: siemens.com, ip: 40.107.22.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+yUMcavhUPoOQ944nLPct5E2OH4+PZpj16uwjIa5yuGaeGHJKX6zqi2vvo76kQV7S87imo4YCEHcWcwuVTRLNvbPqEpjQfQY+IdpEgOE1DjV7koXXMnbjWdjq8lrGyiggjaLR0SVsX7dceHSiVTPtyrtvfi4tAoK0+JUTfNKarHDlb1fD6yXTsQFPCSf8k/ZmOZ+iQZiekkHDh/GYJu9rfQVJ+cgoneXxhh7LwZWTggz6iu/QBw7kGK7PmvBa2BTOcpSrltkX/j9GiaghETGFW8l9rf4dfAWNpBDNOq+xB+jztO8+/eZEi/znZpZ2dTVocYIqakzUuiw+jV+XH8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRKstqBcYxMS2FWYrK9RqkVbez80Yo5aEnalMSrARi0=;
 b=NBRWA/M4pUwhP7NWXgwQZfFrAIYjgZgfctiqGbwyrU0z8Trr0LwBBb78vG7YQXyF9NHcc5ssojwMekM43sPWeyzgt24OzV3DZ2xQOt//2n3VbuokT0gzAyrdK9cCVhs65rNqhjU3Ma0/ZSK/kxN3ypyzeC1H3lKxIhTMb7WRDJUPB+v7sgmNgcSkutJxn0hRfzFkf2fiC1pa4cxhpSDT7bxbO8TLlLnPylX0+gSfgLszRLlqRJmkCwDJLYtN+H4s/t5A+F8PBMkMxKDoOmD9RD1Yle0b3y97ABjBsGtZe74ACer0NQ6P7V9SXsoDi0308lg6MKpYtVWmW0PHzfsNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRKstqBcYxMS2FWYrK9RqkVbez80Yo5aEnalMSrARi0=;
 b=gGDVtDkNUHSeIOj0kyb/8lcnEmQb6R70dID+0RmI9fZ/MnU9O5T1mij/4cWs6bhb7N4J25bqABuu4PPx5vkv9E3W7cLV2kn4zbc+g9J1xMTgnLGeU6fNpLAVD7sIfETNFDoEqbG2dsrJwV92c3YBCOzxvkkhYxs4XGV1dL2XwZBQyzAl9RznKwuBemkIRkm6ACLzWy43DiYvTkONTC73il7EnfIthTZ2YKNdh3fcqFqDqTcNP7ascdHlCzJw3F9F6DS9NhaX2/65NZSgkIJnzVjaF02NXqXJwphI65j+gze6FEVVzPixSv3sRk5cR3zjRTxWT4ljjEs24d2T038/7Q==
Received: from DB6PR0501CA0014.eurprd05.prod.outlook.com (2603:10a6:4:8f::24)
 by HE1PR1001MB1259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 18:42:16 +0000
Received: from DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::c) by DB6PR0501CA0014.outlook.office365.com
 (2603:10a6:4:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 18:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT035.mail.protection.outlook.com (10.152.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 18:42:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 19:42:14 +0100
Received: from [139.22.137.229] (139.22.137.229) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 19:42:13 +0100
Message-ID: <543f8d9c-551a-bfea-ff63-85764a326b36@siemens.com>
Date: Tue, 8 Feb 2022 19:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core] swupdate: use latest swupdate handler code
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<christian.storm@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
	<akihiro27.suzuki@toshiba.co.jp>
References: <20220208114101.22800-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220208114101.22800-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.229]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f24ef5f-d3c8-4c5f-72b9-08d9eb32b9da
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1259:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB12592B03B77E1FFCAB426889952D9@HE1PR1001MB1259.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W1Hq/lDpRnL29xfKSzRZRRaNDiXpY/GZBzmb8EeF5+dFfh4KoU+77qK/f3pa0h387S3bKsIxiNqabGMucsCF7NxeZC+ui1Hfr9iCgKvI7hbKch8D5XUg/zGqyX2lpP9EWR0URl84ZzVZp02KtZoMNHBzSNAAyJ0RI/nz82a+GJRQGmuFjQOdUzqJxGvo4u37XJuDIKFU5qjzFMc/puLuB6sbMiHXaKMksNWgKQuwK+Jrz5kP+WQrxzLZpIuFaG6fCsMorVD14XhKM7X7TKONvJLsRJee0lHix+eflByK+VJg4CA6I3LjTymaT0aB8tE83oeKxro2HoL8cOE+awSUQVz0j9OFJpaBmK/sk4NQf7ARqslMLHA75NlWxNXRJ6IjuqnGfMXZzqFOTvBy/tL4wdtWNuAtOrQX9do3pTqk9W3ji0hxlCzKoQiZqX1jAaoqyx8cVuu0iJGUtPuM/WttoVe9qIBriIZLp8QH21wt0R+QvXKRga5CGKGQQxKsIxWNuTHxC2IAfMCjMHNu1VncQZd8Xwk6KHsjt2+yQG/gKIroJ816dCY483irEJfqtso6efTvC+YO1qq4ak+dFghsub7tr8lXJ5FAE2BuCZ7ohNMX8WK86bgAOFaxrtoGhDG2c3cnNH6BPAZZ5Wf2OCXcn7GMxReWiFIColxlL8Rv9cWozQ19wEwhn+qngG7AqvqHnkY5Cj9BJBicovtSYb+WxRe08wG3xWWdh0aUe3D5DLVkf6plAm3ikU6+46pncbnkcJR09HQXBn78w4BkmEXD/uRekUJC8YRnhKfePfXMWIvzBEJqxiaXHhZDBlPNBPoAoD0eDATCk9qEewisy6IZO36IrZKYeVXZVPPdJf7H3Xwr/wNMdkCOyajAgpxO1qLE
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(966005)(82960400001)(956004)(16526019)(508600001)(356005)(2616005)(336012)(110136005)(31696002)(81166007)(31686004)(5660300002)(36860700001)(26005)(186003)(86362001)(6706004)(6636002)(53546011)(82310400004)(83380400001)(316002)(36756003)(16576012)(54906003)(8676002)(8936002)(44832011)(47076005)(4326008)(2906002)(40460700003)(70586007)(70206006)(3940600001)(43740500002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:42:14.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2f24ef5f-d3c8-4c5f-72b9-08d9eb32b9da
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT035.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1259
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Feb 2022 18:42:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7586

On 08.02.22 12:41, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Latest swupdate handler supports to update the files with dashes.
> 
> This fixes issue [20]:
> 
> [20]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/20
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 3a5a51e..90803a3 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -13,7 +13,7 @@ inherit dpkg-raw
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "ba4c5ae8e664a9624335753cb152e6e264b3f518"
> +SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
>  
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

