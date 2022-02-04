Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D33C433EF
	for <webhook@archiver.kernel.org>; Fri,  4 Feb 2022 06:50:54 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.56])
 by mx.groups.io with SMTP id smtpd.web10.6148.1643957444879260324
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 22:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QFWNzZC9;
 spf=pass (domain: siemens.com, ip: 40.107.6.56,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV0DfjCxqJpHUYSYk9UVjHtAxJaaQgxxEw4ROHR5yEK4pIMFbsmHkQYZr6GP88knCR8Va0ep2w2TD+hs9StopyM0kYoet8GR1SiAEoDLAlQ3TyBQd2Q+y/V+fkvSVgv4UlOe5T6z2xlsjzoLE4tE+qGmofbq/qEhaazrusxylnDcSoO/bmXhobeEgovg55rqg9bN1Yk1HJeoZDVDyZgrOA3HmkvyC9Ai4e6sEmj0L6cJXq56v7RbQTUBMmpqlvGKCXTPho4ydbXjM3Ns8IIRagEzQcUrgExFr93jmBKVmJH3ozIktxKJLiwZzaeWaf7jXZn7HSPjM3lRy/kHNMyQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44DmBc7iBfs1mLoLVa2MN5ldaHwZAv4Feg2bVcb2I/I=;
 b=iwQFCBGJlAlBBF0nUYAj3NvFy7jf2m9AFpkS+xaHsm+W+/lwHixkuRkrWpK0ECTcB+r/YjAHroe6usNUldMyOujY4i7qxRuJgY3b1I56Wv3fN/8z2mes3OKAUWd/OjLJQ39hq/pnQjdP6YxVjHCic/w34n2/xhCWmW2xARhTMexc7Ra1OIHd94apVNXOR0dWYHBUcVhknoOe4bjqzS9ZETw8r744OIfx2u8JYJlZA2vZNxblVICvqYEpYds/WNz25txHHq1AvpyC7nvVYZs89T0GxgQHKEGflH/MVy0Cc9941YrTYNohaMGfKMfcrS5PlYnphWBMocvRfjvuUlRSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DmBc7iBfs1mLoLVa2MN5ldaHwZAv4Feg2bVcb2I/I=;
 b=QFWNzZC9jV1iUQNjt2RHr7BTY4p3V3ILg9Uop88S7tBipCoc3V4dGNSypntyAYRxnBR3mYVSQFiRqHGEybZc+l8cnfk1c/J4kmF0zRv8v2vIQreDc2e5Y/2RyqOhWdYR5gBhsDG9+rgXvUNuHOxP3whlus6WTbeicdMGofBSZTsmjOIC36X0VO3yaaWDYn/02BYLo2nPYpT43wWdtmr/ceW82XdpXJB0tY3Lbi9c8+TYUmYfTmGicvAKiNu+sscKN+YAhPHJvjLaPURRjArfXfcowfbkYBZtMssgkjjNmoijSn07s3Byj4ObE9FsseFq07ZCeFTTna00ZL63iGbAEQ==
Received: from OL1P279CA0057.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::8) by
 VI1PR10MB3549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 06:50:41 +0000
Received: from HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::30) by OL1P279CA0057.outlook.office365.com
 (2603:10a6:e10:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 06:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT017.mail.protection.outlook.com (10.152.0.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 06:50:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 07:50:39 +0100
Received: from [167.87.72.47] (167.87.72.47) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 07:50:38 +0100
Message-ID: <a102fa1a-1fd8-175c-27d8-d6a8cd548ae3@siemens.com>
Date: Fri, 4 Feb 2022 07:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core v2 1/2] Add recipe to cause kernel panic during
 system boot
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
	<akihiro27.suzuki@toshiba.co.jp>
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
 <20220201153502.14230-2-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220201153502.14230-2-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.47]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f7af898-6ced-46a5-8e72-08d9e7aaa803
X-MS-TrafficTypeDiagnostic: VI1PR10MB3549:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB3549FA58E4E07F0954C3387195299@VI1PR10MB3549.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gDyG8jxppntxBwYZ45oOMndi0swafmXShqrOQDxrU7pSlE84qHwOox6QuUK9oCpNTpzhtae8TJqGbUS3cwgs9gwo12tjgJx1hPjnGHV+Y2Tvw+uV+auRxWEzGbrKRnV2WiRZA173iQpZxC00Tv7kWUtqFYrtn04aoNGhDYNEe0R0/ng0ZiNaKH5SdqcgN28drEgQSZNEUFUtPTtf8EZsjot2S91mG4rhykX3wFke6l/r9U0rsvF0zZH1d2m7+hM7JufksPKSQUDlPbXC6ktcdrkpoTOQ31a7ABHsnUdwksIqYI0n04EpGy8bLEAq3VuHW4L3X6lqscRSGnGzw/ixTXaG5y4e/NtsoiNMKMHVNYxJrDxcXt/uYuWLU/HLjOeMm+q23XHGlnEUqDc6hNHCUcajkxz+oNiFNuBnanJI68PYxUHVWoi7NXWXi/GuZPbyto+VxZFFqrdv9OlKksbls0wzKlJt+iTG3WJBawE3CE7rn+GWEOuEs2IjVAeTu+0xR/mB9Xn2ZVIyXsfHU0Q3dm+ByVNqkJJnOpO5ybkR2TZJnbGNco4+J1Uh2lPlYXYAY2ng67jwU4WzyaYutQdBz8WVwMItfdQAT+1YwDb8rn97O880uWS6/Vo5m6bYk3kbyb1yiFC0HULZaUhnfVO71HPwURe87j/tSycgMZvqk+1vGtMJtGhSkxGaWIfTRfGL4i0frNxg96rQwuouZj3JnBIkxE5te4I3sAQjahXnhqvF5XsCpWY/BdT4n+DZhkNM4z4qoCTG1od6b3PX7pOQgw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(82310400004)(8676002)(8936002)(81166007)(4326008)(70206006)(70586007)(82960400001)(83380400001)(110136005)(508600001)(956004)(2616005)(53546011)(316002)(16576012)(54906003)(86362001)(336012)(26005)(186003)(16526019)(36860700001)(2906002)(40460700003)(44832011)(47076005)(31686004)(36756003)(31696002)(6706004)(6636002)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 06:50:39.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4f7af898-6ced-46a5-8e72-08d9e7aaa803
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3549
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Feb 2022 06:50:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7574

On 01.02.22 16:35, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This recipe adds systemd service to cause kernel panic during system
> boot.
> It helps to check the swupdate-rollback feature.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  kas/opt/kernel-panic.yml                      | 18 ++++++++++++++
>  .../kernel-panic/files/sysrq-panic.service    | 10 ++++++++
>  recipes-core/kernel-panic/kernel-panic.bb     | 24 +++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 kas/opt/kernel-panic.yml
>  create mode 100644 recipes-core/kernel-panic/files/sysrq-panic.service
>  create mode 100644 recipes-core/kernel-panic/kernel-panic.bb
> 
> diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
> new file mode 100644
> index 0000000..47df7b1
> --- /dev/null
> +++ b/kas/opt/kernel-panic.yml
> @@ -0,0 +1,18 @@
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
> +# This kas file adds systemd service file to cause kernel panic during system boot.
> +
> +header:
> +  version: 10
> +
> +local_conf_header:
> +  kernel-panic: |
> +    IMAGE_INSTALL_append = " kernel-panic"
> diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
> new file mode 100644
> index 0000000..169a97c
> --- /dev/null
> +++ b/recipes-core/kernel-panic/files/sysrq-panic.service
> @@ -0,0 +1,10 @@
> +[Unit]
> +Description=sysrq panic
> +
> +[Service]
> +Type=oneshot
> +ExecStart=/bin/sh -c "echo c > /proc/sysrq-trigger"
> +
> +[Install]
> +WantedBy=default.target
> +
> diff --git a/recipes-core/kernel-panic/kernel-panic.bb b/recipes-core/kernel-panic/kernel-panic.bb
> new file mode 100644
> index 0000000..511febb
> --- /dev/null
> +++ b/recipes-core/kernel-panic/kernel-panic.bb
> @@ -0,0 +1,24 @@
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
> +DESCRIPTION = "Systemd service file to cause kernel panic"
> +
> +SRC_URI = " \
> +    file://sysrq-panic.service"
> +
> +do_install() {
> +	install -v -d ${D}/lib/systemd/system
> +	install -v -m 0644 ${WORKDIR}/sysrq-panic.service ${D}/lib/systemd/system/
> +	install -v -d ${D}/etc/systemd/system/default.target.wants
> +	ln -s /lib/systemd/system/sysrq-panic.service ${D}/etc/systemd/system/default.target.wants/
> +}

Applied already to next, dropping the extra new-line in sysrq-panic.service.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

