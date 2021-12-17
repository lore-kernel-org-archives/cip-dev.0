Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C30EC433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:52:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web11.7061.1639752720562765619
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:52:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TsnBNvIo;
 spf=pass (domain: siemens.com, ip: 40.107.21.85,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URe2NoMqHd8CigbYgtR883no2VyqcEhVOUis29jNEPt5IVHNNO8BlA5qzeWtq8o9fI4Ox6MLPhw5CcWw1zuLb5tJE9uPH1GQDVsxCgwfCvm4ArVCN6bJfK1g6rGKH4XDdchHDrACbm6PVvbNCCrDXBamCNu/jceW4e/l8kmuLMSYf3DwK/o12AjtsZ9OL5LwTGIQhDjB2DQJ/TZvBwJY7muy2WKBUZlTSC/fdbsMuN0gQ4G8vYnl2eyV8Qc9Zz8/iQnf2hv9G36VUElM6YHJL64GQ2JJuaS3iP4u6TlEVd0xb0Je0KYevJ0peeiZ8s5Jm+pOsPsSH/VsxlTZ7rLqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2o5KTaxmTkZdzjULRsTbKc3ZYe1Y22TXA8/mKU/qwc=;
 b=kmY7l3t+H3OChiWKtU6oMMahHxUhEBvaiS3gTF5g5lakVlQh1bI+/WO1+6kvWdOvgCatT3hAFj8D/qxyni/b3CvDZhSutgvC4kDZ9hlXVTzkNDCMUxpwdd2MPsr9cIs47MtS9TObLNXGUnn1k8dnVKprmAmyZ6lCTHOBzNVrm5TvXI8Icl9oOFmjjwOH/KXQiu/Zt97gc6L0eXQoaKcyRCIjG2emOc2rhe6XKyShKkYpmLh+AySSfoY1xWXHaa2mkDusWq/N6q8J2Vrq/vT1thwilWqRakziZ3IzZmj6/2LyI+Db9LSXp6lUGZCu0khDHc/x46D6CCZDoOU4CgZ8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2o5KTaxmTkZdzjULRsTbKc3ZYe1Y22TXA8/mKU/qwc=;
 b=TsnBNvIotzIHQG50ioDgDVZ5b/rP6G6Qu1Qr7ZN8dM054QkHh87N33r90t9cr8xxTf2cq7u9TApsFZ5OSXBGO+HPZ8kklProHEM3b1OlSxxkmhKfcZKjakkZqxjxPpynpBKIivAzDNPvCTfWeY6WDsdTDo6z2V17OqCoG5EIAvCDwroQjRNCgsGbEz2EDg6e24FXmsZ3tkpF92HQEKUl9MfH1Lqh308aP0cKBUcIlejwR7Qiq7oZDG28DLr9sYXXkDQmYiWYdTKYBosC5t18UvtRIfeYH95Zhk8YOi7vnRUeIOjDESiu801WS1FQUNBX4AkudU6K4YSmjp5wlZP8DA==
Received: from AM6PR10CA0063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::40)
 by AM8PR10MB4177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 14:51:58 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::7f) by AM6PR10CA0063.outlook.office365.com
 (2603:10a6:209:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 14:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 14:51:57 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 15:51:57 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:51:56 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] Make read-only rootfs a inc file
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <24fa8401-eae7-a9c0-6f10-01dfcd991a3a@siemens.com>
Date: Fri, 17 Dec 2021 15:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217135015.1189442-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04427ed-0570-40c5-7dad-08d9c16cc625
X-MS-TrafficTypeDiagnostic: AM8PR10MB4177:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB4177880D2E677EBC6CBD313C95789@AM8PR10MB4177.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r1CJyRK/M1iScZsHdgCYYXs+9C8b++sj6x9ykwaLw2yyRiL5BR0beLl8BzbNK9PoPZz4JKPK2Tb0TUiiwKzdCgiZzTLGsA3O4031XsX0CBDH4jZjsyei9jRk0wIz/sWUd5wTlfLYDEWKqva2HERsIlFXOZRZ+z6RMreqMQvzMDObk0Qaf01+KhDVUpB3ylB7XHvLWD/PFJPHmxjHcoFZ14maDPIi+VinZ3sA+1fH7Sw/GDJz5O4aanG3qz6VWymGzfQnLASkM3rXaTGsYjeoweb0f9+c7FZtoyg8pyp8cvmKV1xGYJD8rTcke7HCuMmJ5r2g+2jjuVzbGBaCMzrFWvjVseI1/1yTGi5cXPaZPggsjMUKx4fwl3Pqdv7aRlD62VrpghpcplqO1HPF/GAT5f6CLSiUUKW3VtzSC7FzqNDOZ8DASQgYtLEOi1pkweB8ZqtyRs0SIalb9vIMVQ+13E7vWTRO/4LqVn8kTOLBqA2NKVmJPdc4jH+0k1lyQDqGy+1Y7LTWFZfX9s/gfSC/lx5h3Zha3WeNO3anCaV7bTJDVW97kQFQcInqnHn7Fpx+l/KwROHgbr8qzPasxhGrw/7m2v8TgNCzOOpSiQQVVQZNzydbVR54uWrTaEJifZjKbjEUQxxOmWCjkg4UsWc7jD+hh1azHjfah1T3ySS7cG6ib77V9EE2j0OhQbBulREsbq1Id/TCGfNOCyENAbMjrAKTc+/CZPsYRm0HtKztWaq/aCe0yEmZ9/ghORwp2EhXI36J7jOw3GNr956aN0VjriSmDH5Ryyjw39Nf1jj4aiGU3Dm3mIudEHXDApjfA30zSd053gRyXvTazzQPSulwUIM+X3mo1JecV9Viduii3p8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(110136005)(86362001)(53546011)(36860700001)(2906002)(70586007)(31686004)(40460700001)(47076005)(8676002)(5660300002)(26005)(31696002)(83380400001)(8936002)(336012)(82960400001)(6706004)(316002)(81166007)(186003)(82310400004)(508600001)(16526019)(36756003)(956004)(16576012)(2616005)(44832011)(356005)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:51:57.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d04427ed-0570-40c5-7dad-08d9c16cc625
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:52:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7184

On 17.12.21 14:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows downstream recipes to include the kas option
> and use the include as base without recreating some parts
> of the recipes.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/ebg-secure-boot-snakeoil.yml                  |  4 ++--
>  recipes-core/images/cip-core-image.bb                 |  3 ++-
>  .../{cip-core-image-read-only.bb => read-only.inc}    | 11 ++++++++++-
>  .../initramfs-verity-hook_0.1.bb                      |  2 +-
>  start-qemu.sh                                         |  3 ---
>  5 files changed, 15 insertions(+), 8 deletions(-)
>  rename recipes-core/images/{cip-core-image-read-only.bb => read-only.inc} (78%)
> 
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 1cfbacc..807b0d7 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -14,16 +14,16 @@ header:
>    includes:
>     - kas/opt/ebg-secure-boot-base.yml
>  
> -target: cip-core-image-read-only
>  
>  local_conf_header:
> +  image-options: |
> +    CIP_IMAGE_OPTIONS += "read-only.inc"

I think you want _append here to that the default assignment in
cip-core-image.bb also works.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

