Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4320EC433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 15:55:46 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web12.120.1643298944811486392
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 07:55:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xf82uQ9E;
 spf=pass (domain: siemens.com, ip: 40.107.20.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCO64KiKJjZoh5NqMl1r+BQduDB1JAdShqJKTZzA0ONMrdUsW10wpks4wE6oKZn0Iw/RWPmCT1Z9wvLXwJFZm2DFhvpmqHheZfAO5GQzx09Go72NH+MFqjSpkGpTawDXY/mEW4riZr9mCRN73Px57Gx4c9aKODPvbjztztrrXmy8RNEkuTkEjUSRodMv3WcpDx34N7lXXGPLoHDqqZglQQzOtlaFWk1D1lqEnxZbXesHUVdvLnnGsdzTyP7bT1yLsW7we/O87fZHN9yWUTiWGToS9W6YeSs7h1HxX0y/3MOIaGRMEBAoVq+8XHDvdDLm1iuBqHRgmqMqwqIcIhdcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBpJHhxmjfyQThG5QnmY10AukQITep1aQeoKPJyXmKg=;
 b=AyuKjDt58LYd5+adE7RZuyd+Ldvq6B8F8z5TfPuGlZbdWnl4SzkFCZZwSKmJPVIty1C3hydGG8pIYDTMzgmDT+KfbRtzqdn8uE5Xq931XP2UH4R1CO1rBF3DxtuIxCQx4CwYPmjzhPgJmk9wpbaillubH435mMvWubyw8k2iwPP13K9ziXd8RiWV/bToKEu+CBGQB1b2Vy0yKf1NT+Dpy69PJzedjF1RaEzE2vajolIsdbLi+haQmrxoS6A0s5Q/oVeccE/sOvNnv3VB6Yq7sOv+aUexJIn/zuSSlIeP8CBDeAtPBA1fqBKraFAIKzYMIjgGQc0KKt12Y0ZPEm+1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBpJHhxmjfyQThG5QnmY10AukQITep1aQeoKPJyXmKg=;
 b=Xf82uQ9E8UimFh8nxb4QPjcVh2zugUyjdTr4wdvvyNqZ9N1NP69rDu2rWjYK/VhE+dyJf1zOBq26QKYmc6FDzTTteLb4XrEbLhNFdx/HOjNDoRtWEQi42HwR+s64/xkUtoVmXh+JfMiwlbH4XgjoiCL47TnqdTTfZ/2hQ/TEL/SyHN6D9YzKPgOTxIVVjBdI4R4YSkWXMRyE0Ew8MJKFgo2o1+rh1++Y1ZbiP4z/1yP0bi6Ir+eD8fBqiuFkDxEy0YgXeFAwfwOLwcwCENYTVldBZ3cAHhHGZCNk/u2EsJ6lpYb3N5YVWqB7SnTT+WhrO0onwFIB+KQwzsHNk129sg==
Received: from DB6PR07CA0163.eurprd07.prod.outlook.com (2603:10a6:6:43::17) by
 VE1PR10MB3917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:55:42 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::36) by DB6PR07CA0163.outlook.office365.com
 (2603:10a6:6:43::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Thu, 27 Jan 2022 15:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 15:55:41 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 16:55:40 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 16:55:40 +0100
Message-ID: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
Date: Thu, 27 Jan 2022 16:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core] swupdate: add recipe to cause kernel panic during
 system boot
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>
References: <20220127142042.6692-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220127142042.6692-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e13d85a4-b48d-48e6-5ce3-08d9e1ad784b
X-MS-TrafficTypeDiagnostic: VE1PR10MB3917:EE_
X-Microsoft-Antispam-PRVS: 
	<VE1PR10MB3917B5EC847799FE5F948A5395219@VE1PR10MB3917.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lu17xxLEBXgz38tOc1RSWPll2Ki5MhCdh0XWKYkQ+H1sTkPf3mdwR5nS7c7nn9Vs6ShIVQg0+8vNWAyR0erSdrbaMF/U7BgytaMqjzFHspzjReQtFKP8tbTTAyzjA44TNKZ+Qjyr+bHJjv0PiWyzeyVf3dXdhYSSPFLAm+zM3WQnFA3GYctoHF0YgAVyMDBXPccGsVdfIhKZGSmrQAmv+GI2MMyAgaN2a4en6eFStZKkeW4emtDoezrrMFR9qymR2GvrKHa+uS1SEMWb+OhRhMAJnyBxOmwh+XMWpk7U/WWUUs3hfVt+WdOlFmoRm1nrc9Qx4KWHpXljlCJ3MheQo4IMUG2TBLMmFtFM3pDo6Nz5OVS+7SWCJglRUND1sMSOaLVBAmh3OyaamjdwbaM9FYBQaa10vYaP5DXCiAiysxnTWVd0zkX+gawWM/oZ9n89mWPoIXnMALjqV9NUunEA+ElyC9yoIOycK04+gd49Zi6BcaEvquT0NKKpy34yi3wztrLhRBAYMzClOEIhKPGk8qKXJvnd7T2OCF47B1GK8I5h+asRW8zVvv4mtiWVtY8La4gVSM1FIdcwnF+8AidtO9LbcJH3rvRYThTV3XXPNfLknIVn3IS86ps203kWriu0WF8uURT05+pivUMbQGHMgCBBfBHx5ai0YCIJph2mwawrE9QApgSoHRs0af8JDKNxXSvvOyiSvyzTDAcP/TTWWGOQVrxKKpTLPtkhD/5UboE7hRQ6azeKgTIbXc/fszIwcbWQAVM4816tJ31O2FZOsQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6636002)(6706004)(8676002)(36756003)(110136005)(31696002)(5660300002)(8936002)(70586007)(70206006)(82310400004)(81166007)(4326008)(16576012)(316002)(82960400001)(356005)(956004)(86362001)(31686004)(36860700001)(336012)(16526019)(508600001)(2616005)(26005)(186003)(44832011)(47076005)(53546011)(2906002)(83380400001)(40460700003)(3940600001)(36900700001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:55:41.2651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e13d85a4-b48d-48e6-5ce3-08d9e1ad784b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3917
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 15:55:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7506

On 27.01.22 15:20, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Cc: dinesh.kumar@toshiba-tsip.com,
>      kazuhiro3.hayashi@toshiba.co.jp,
>      akihiro27.suzuki@toshiba.co.jp
> 
> This recipe adds necessary scripts to cause kernel panic during system
> boot, these scripts are required to test swupdate rollback feature.

Valuable piece in the puzzle! I would just use a different name than 
"swupdate-rollback". Effectively, this creates a broken boot, not only 
for swupdate, no? Then call it accordingly.

The fact that a broken boot will trigger a rollback under swupdate is a 
consequence, but not directly related to these changes.

> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   kas/opt/swupdate-rollback.yml                 | 19 +++++++++++++
>   .../files/sysrq-panic.service                 | 10 +++++++
>   .../swupdate-rollback/files/sysrq-panic.sh    |  4 +++
>   .../swupdate-rollback/swupdate-rollback.bb    | 27 +++++++++++++++++++
>   4 files changed, 60 insertions(+)
>   create mode 100644 kas/opt/swupdate-rollback.yml
>   create mode 100644 recipes-core/swupdate-rollback/files/sysrq-panic.service
>   create mode 100644 recipes-core/swupdate-rollback/files/sysrq-panic.sh
>   create mode 100644 recipes-core/swupdate-rollback/swupdate-rollback.bb
> 
> diff --git a/kas/opt/swupdate-rollback.yml b/kas/opt/swupdate-rollback.yml
> new file mode 100644
> index 0000000..a3b0e28
> --- /dev/null
> +++ b/kas/opt/swupdate-rollback.yml
> @@ -0,0 +1,19 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2022
> +#
> +# Authors:
> +#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds necessary scripts to cause kernel panic during system boot
> +# which are required to test swupdate rollback feature
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  swupdate: |
> +    IMAGE_INSTALL_append = " swupdate-rollback"
> diff --git a/recipes-core/swupdate-rollback/files/sysrq-panic.service b/recipes-core/swupdate-rollback/files/sysrq-panic.service
> new file mode 100644
> index 0000000..ae868f9
> --- /dev/null
> +++ b/recipes-core/swupdate-rollback/files/sysrq-panic.service
> @@ -0,0 +1,10 @@
> +[Unit]
> +Description=sysrq panic
> +
> +[Service]
> +Type=oneshot
> +ExecStart=/root/sysrq-panic.sh
> +
> +[Install]
> +WantedBy=default.target
> +
> diff --git a/recipes-core/swupdate-rollback/files/sysrq-panic.sh b/recipes-core/swupdate-rollback/files/sysrq-panic.sh
> new file mode 100644
> index 0000000..a3c1bb7
> --- /dev/null
> +++ b/recipes-core/swupdate-rollback/files/sysrq-panic.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +
> +echo c > /proc/sysrq-trigger

Why not doing that directly in the service file (/bin/sh -c "...")?

Jan

> +
> diff --git a/recipes-core/swupdate-rollback/swupdate-rollback.bb b/recipes-core/swupdate-rollback/swupdate-rollback.bb
> new file mode 100644
> index 0000000..5c93bb5
> --- /dev/null
> +++ b/recipes-core/swupdate-rollback/swupdate-rollback.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2022
> +#
> +# Authors:
> +#  Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "Script and service files to cause kernel panic"
> +
> +SRC_URI = " \
> +    file://sysrq-panic.sh \
> +    file://sysrq-panic.service"
> +
> +do_install() {
> +	install -v -d ${D}/root
> +	install -v -m 0755 ${WORKDIR}/sysrq-panic.sh ${D}/root/
> +	install -v -d ${D}/lib/systemd/system
> +	install -v -m 0644 ${WORKDIR}/sysrq-panic.service ${D}/lib/systemd/system/
> +	install -v -d ${D}/etc/systemd/system/default.target.wants
> +	ln -s /lib/systemd/system/sysrq-panic.service ${D}/etc/systemd/system/default.target.wants/
> +}


-- 
Siemens AG, Technology
Competence Center Embedded Linux

