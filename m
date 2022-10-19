Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FCAC4332F
	for <webhook@archiver.kernel.org>; Wed, 19 Oct 2022 10:57:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.44])
 by mx.groups.io with SMTP id smtpd.web11.6380.1666177063315737444
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 03:57:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Iw4ZWdlr;
 spf=pass (domain: siemens.com, ip: 40.107.8.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSPkp8GKVGy+vlDeE/tpoQYQyI+/WMez4ceaG+OivQOCUlRY9/VcqlUq3mcXALAShSmUIcNmydsGkNlwzl6S71+Y821hLZOAUCZlnbU9/CXXe86Hue1hcf3AambFFbuCeGZGIJOQZQR5Xd1iA+ngtvO9eS6m9VhzFHAR0ndyV2M/K0EEsaNMi/i6tTfmeLhocXF9unvsXG1WIOmVqs9aIZ9Bo6QJ/Wm9xhfAR9pDA5X2XCzOlalhXLxHKhllKn6ziR6xMwM/NKVcpKkXj5sYL8DQHPZUwdrUCShu7fLWeF0vbu1xFUZFLWzVXEIlci1qk9u2PNng+yO6s8Czyui99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3ZfQ9+900bNFxfgisCHxGXNhWL8mPqrRlx3IyZv2jw=;
 b=SpPj77+F/PoqFgWUO1R5dg/HdMfm/ujOi/88Il0SOh1ljyZy8cI0cP56TlwyIpGSVB7CTn8z5Hkrfgjve/FBZIZuGoGMR1MDPSRLRXt34FxotdbLlni5qaUBmrPMbhPq0b56PxpQZ5NYPoueJo1BdR61occrgRWgaT0I9ftdB7rWcQCXPEmDRMjeuwrkmW14+TLFhBQUdF+1Muql9RacLQvEnGSjQ1Qe3jYszZgJ7tRNfE7GVY/I+U+/PKmxVMTQPD8zjfvudrr/J96Nuja8ZK0XHLOEzGp20ryDnjrhAaZwMDBwwoCB7mhz+VqLZB/X/SYPRNpD4CEU7UN8P+LBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3ZfQ9+900bNFxfgisCHxGXNhWL8mPqrRlx3IyZv2jw=;
 b=Iw4ZWdlrQ8qW1giuzhhBBxLksJTYWn8zBse1e88n6AVy6UV+EaOrlOvE+V1AnYFT/D2+HA+tR1ffHthxYN2Z5NDhxYxsnWKEW7ce+egjSaaF7rFeqoDqJZsKoNhhiZJc20AubZoyiUi5a78ML+1G1XfYo4NMrnOLmDAltWJf8deGyviKYelIEcGpfBJcXdbulwTIUx79IAXdJSSdQQr3Ndqjvi5PorzOVgEd4wlW7uQ+CT0igbmIpAqlVPEG7bDZmhxRvMYiS0uwTHAzQL7DNZWq3JUE0dCXjKiW8O6IqrUTH2smcut13+C19X8xMD0bdnPXdqzSOBlQSMnrMP1weg==
Received: from DB9PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:10:1d9::31)
 by AS4PR10MB6111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:583::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 10:57:40 +0000
Received: from DB5EUR01FT100.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::cf) by DB9PR02CA0026.outlook.office365.com
 (2603:10a6:10:1d9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Wed, 19 Oct 2022 10:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT100.mail.protection.outlook.com (10.152.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 10:57:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 19 Oct 2022 12:57:39 +0200
Received: from [139.22.133.243] (139.22.133.243) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 19 Oct 2022 12:57:39 +0200
Message-ID: <760608c4-0d6c-43f2-00c8-bc93de8cdeb4@siemens.com>
Date: Wed, 19 Oct 2022 12:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 2/7] add recipe for for edk2
Content-Language: en-US
To: <sven.schultschik@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20221019092117.5291-1-sven.schultschik@siemens.com>
 <20221019092117.5291-2-sven.schultschik@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221019092117.5291-2-sven.schultschik@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.243]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.594500-8.000000
X-TMASE-MatchedRID: ZCcPN3gXkNg5QaOxwNGfvo9bHfxDWoibjlL/hujrw1tl/fN/7Gm4uD8Z
	O44VTPmzS8QrgUwl2ioUgK8mFcTOx6wBIzOlBY8XZulQlvEwXziCrAvdroZEJj8Ckw9b/GFeTJD
	l9FKHbrme87/vN9JpT7wAmz0iQUL1r17vCCwsAX4TExDTC71rlLNUVnqixiMOurQT39WNGISC7C
	2rJeUToVrEr1M2G61FA+FKi+KNuiIXxDANc7MuDtI0jIvsw2qyYJcWKAxFI21X7UpJhGB2YkC+L
	C66ZsxT+32SXw3QiFxvGSJtubGn7Z67GuVLcycuxSdrm2HKzRg/QMF1B4qVfWwTEruL9ObTbXmI
	kXx4Tqu3auNLoz5U2T8tuJW5E/FyxWp9gpjKnjBQkWmGg5unx7RNLOSbg1NYJhFEQZiq2ZQzAx8
	HYox0h/4DDXoaCqk7EoN4n3g9Rrav1EdirSq/xQ0Ofxy/MGEsthfZltvQe7I4ZNXh8UPrII1j+m
	rGi/PFTPm/MsQarwPFwwoXr6TDW4JtD3B8OpKAcEog89Q2652V76rqTtD9zC/MuWzsdN8ZVeAZ5
	VSHdZ2bKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sw18pfNVkFbE/fAS8
	S1I24WPyAxg6s7BtxRVxUeDbuRVoZ/Abl5funQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.594500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 12CAF3E0941B2C372162431412CC1E2A253883913FE3AB199CB0A9260600635F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT100:EE_|AS4PR10MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c87bef0-5120-4197-08da-08dab1c0bdaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WU8wK1d3b2I2bGZvbVVpekZlRDJzTHNLYlZUaHRPQytkcVZzR29xTWgzYnY2?=
 =?utf-8?B?NENaUkR2NkVyZkFwWmhBMHM5cUdHSUdWOWorMWJLYi9nYkwwY0xyNGNiQ1Zs?=
 =?utf-8?B?WDU1S01TVTBPWnpqSkNTM2QxdmhUWlRhdnorSkFwTzQ5RzEwV2crS25UUnov?=
 =?utf-8?B?Z1Jzb2hhRXhoK2dZNGZuS1NlVUpFNGVaK1A3WWpWcWtobmlzY1dRa2w0L2JB?=
 =?utf-8?B?bDYyTmE4dndWeC96NWFyVTgzL3grb3VVVHp5aGRxNEZlK2hBSi96dFFkdm15?=
 =?utf-8?B?MHpYaWJxZTcrdmlKV1VHSkoydUt0WXhFZWdpRFVLNHMybkxNMUFGVDBZS2ps?=
 =?utf-8?B?bXppSGxZbXRnWHh0MzNEZk5iN0Z1S1l2aVNreHR4cGhDR1V0MnRFbHNDK2da?=
 =?utf-8?B?d1N3bjlJc0d4Q1h3Yml3ZGhJRDlxMEZFTWlYa1I1MFFMREN5MWh5SUMvcE50?=
 =?utf-8?B?S0duMGFpM3FqbmdmRjJBWkVrQTkyeWdlczhOdVlBZ2ZjK3ovclhmL01jZzln?=
 =?utf-8?B?cW5BNW8vazRIdW9YOFRxZitPeE1teVpCNHBCWW8yVHpOWFZTM2dvSE8yblRE?=
 =?utf-8?B?RWlZUUxkeTBsdlozL3V4UHFVejdzc3VvbzRRSHN2M3RPUVV2bC9MdHdtM3Zr?=
 =?utf-8?B?dzNEK3RQT1QyeU9TVk1aQUFpUlNKK0UrWU8vY0pTQ0NUZE9yR2VzT25SeUgx?=
 =?utf-8?B?cUd3UVdSVnA5YVFSU0dFVjZNSHJoOU5aSkowVEtLSHN5UEl5ZmhpeVZFSDRt?=
 =?utf-8?B?SGRwQ2d6cUNPMXhHYUxJR1JBaFlZckpIOWJZc29GSlhYeENEUDdGak91YUQ0?=
 =?utf-8?B?Mm5mbWFrSG42Zjdrc2t5M2VDejJVRDJyNjd1ODF4TW5KOW9hVk9ZeTdEZkFF?=
 =?utf-8?B?THpTc09LaGViN2x3KzZZenl0bzNxbDc4VngxbGczTXZOWlVqcGhaOVh0YmlP?=
 =?utf-8?B?UUNOMmZsU1VQeFY5MG5Mb255SXJ2eWFkR0xxQlQyMWZER0k0TmRia1hmZWo4?=
 =?utf-8?B?ZUxQVFovdUxrQXVnMFNEdUd5blhoUWFRcXNoSkNXWUpwTjc4M1kwS0trdGY3?=
 =?utf-8?B?alIya2psWnFrWVorQ1N6Y0hiZmVyNVhvanZPeHMxVUZxSDZiL0EzY1Z3c09w?=
 =?utf-8?B?U2R6VVp6NnU2Y01ia01RdkhDV3BWS2sxeHdJQkJaTzFqMmNuSDFQQ3FxbG41?=
 =?utf-8?B?akdCN1l0VjdxT1RLSmMxbVpkcmtxcHlUMFhRWGR5aW9kcTl2VHdydlVRM0hU?=
 =?utf-8?B?M1hYalNaejVsaE5TM0FxSXlOT1BpMXM1M1VMK3BoZmNBTWVZUT09?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(2616005)(336012)(16526019)(356005)(83380400001)(47076005)(186003)(956004)(31696002)(81166007)(36860700001)(34020700004)(82740400003)(82960400001)(44832011)(2906002)(41300700001)(8936002)(82310400005)(40480700001)(40460700003)(53546011)(966005)(26005)(478600001)(5660300002)(70586007)(8676002)(6706004)(70206006)(110136005)(16576012)(316002)(31686004)(36756003)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 10:57:39.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c87bef0-5120-4197-08da-08dab1c0bdaf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT100.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6111
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 10:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9784

On 19.10.22 11:21, sven.schultschik@siemens.com wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> provide a recipe to create the BL32_AP_MM.fd binary by edk2 which is needed for the qemu optee generation as dependencie.

dependency

> 
> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
> ---
>  recipes-bsp/edk2/edk2_202205.bb              | 34 ++++++++++++
>  recipes-bsp/edk2/files/debian/changelog.tmpl |  6 +++
>  recipes-bsp/edk2/files/debian/compat         |  1 +
>  recipes-bsp/edk2/files/debian/control.tmpl   | 14 +++++
>  recipes-bsp/edk2/files/debian/edk2.install   |  2 +
>  recipes-bsp/edk2/files/debian/rules.tmpl     | 55 ++++++++++++++++++++
>  6 files changed, 112 insertions(+)
>  create mode 100644 recipes-bsp/edk2/edk2_202205.bb
>  create mode 100644 recipes-bsp/edk2/files/debian/changelog.tmpl
>  create mode 100644 recipes-bsp/edk2/files/debian/compat
>  create mode 100644 recipes-bsp/edk2/files/debian/control.tmpl
>  create mode 100644 recipes-bsp/edk2/files/debian/edk2.install
>  create mode 100755 recipes-bsp/edk2/files/debian/rules.tmpl
> 
> diff --git a/recipes-bsp/edk2/edk2_202205.bb b/recipes-bsp/edk2/edk2_202205.bb
> new file mode 100644
> index 000000000..5a773bf77
> --- /dev/null
> +++ b/recipes-bsp/edk2/edk2_202205.bb
> @@ -0,0 +1,34 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Sven Schultschik <sven.schultschik@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +HOMEPAGE = "https://github.com/tianocore/edk2"
> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
> +LICENSE = "BSD-2-Clause-Patent"
> +
> +inherit dpkg
> +
> +SRC_URI = "gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https;destsuffix=git/edk2;rev=edk2-stable${PV} \
> +            git://github.com/tianocore/edk2-platforms.git;protocol=https;destsuffix=git/edk2-platforms;rev=3b896d1a325686de3942723c42f286090453e37a \

- gitsm (see patch 1/7)
- please factor out revisions into separate variables

Or can we also address the revisions via release tags? The recipe
carries a release version number in the end...

> +            file://debian \
> +            "
> +S = "${WORKDIR}/git"
> +
> +BUILD_DEPENDS   += ""
> +
> +TEMPLATE_FILES = "debian/changelog.tmpl debian/control.tmpl debian/rules.tmpl"
> +TEMPLATE_VARS += "BUILD_DEPENDS S"
> +
> +ISAR_CROSS_COMPILE = "0"

Why?

> +
> +do_prepare_build() {
> +    cp -R ${WORKDIR}/debian ${S}
> +    deb_add_changelog
> +}
> \ No newline at end of file

...

> diff --git a/recipes-bsp/edk2/files/debian/changelog.tmpl b/recipes-bsp/edk2/files/debian/changelog.tmpl
> new file mode 100644
> index 000000000..8d74dfe7a
> --- /dev/null
> +++ b/recipes-bsp/edk2/files/debian/changelog.tmpl
> @@ -0,0 +1,6 @@
> +${PN} (${PV}) unstable; urgency=medium
> +
> +  * EDK2
> +
> + --    
> +

Should not be needed as you have deb_add_changelog anyway.

> diff --git a/recipes-bsp/edk2/files/debian/compat b/recipes-bsp/edk2/files/debian/compat
> new file mode 100644
> index 000000000..f599e28b8
> --- /dev/null
> +++ b/recipes-bsp/edk2/files/debian/compat
> @@ -0,0 +1 @@
> +10
> diff --git a/recipes-bsp/edk2/files/debian/control.tmpl b/recipes-bsp/edk2/files/debian/control.tmpl
> new file mode 100644
> index 000000000..1f1bad7c8
> --- /dev/null
> +++ b/recipes-bsp/edk2/files/debian/control.tmpl
> @@ -0,0 +1,14 @@
> +Source: ${PN}
> +Section: base
> +Priority: optional
> +Standards-Version: 3.9.6
> +Build-Depends: ${BUILD_DEPENDS}, python3, dh-python, uuid-dev
> +Homepage: ${HOMEPAGE}
> +Maintainer: ${MAINTAINER}
> +
> +Package: ${PN}
> +Depends: ${shlibs:Depends}
> +Section: base
> +Architecture: ${DISTRO_ARCH}
> +Priority: required
> +Description: ${DESCRIPTION}
> \ No newline at end of file

I suspect you could also generate both files (deb_debianize).

> diff --git a/recipes-bsp/edk2/files/debian/edk2.install b/recipes-bsp/edk2/files/debian/edk2.install
> new file mode 100644
> index 000000000..e5cadccf3
> --- /dev/null
> +++ b/recipes-bsp/edk2/files/debian/edk2.install
> @@ -0,0 +1,2 @@
> +#! /usr/bin/dh-exec
> +Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2
> \ No newline at end of file
> diff --git a/recipes-bsp/edk2/files/debian/rules.tmpl b/recipes-bsp/edk2/files/debian/rules.tmpl
> new file mode 100755
> index 000000000..11e4ae8cd
> --- /dev/null
> +++ b/recipes-bsp/edk2/files/debian/rules.tmpl
> @@ -0,0 +1,55 @@
> +#!/usr/bin/make -f
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# SPDX-License-Identifier: MIT
> +
> +export WORKSPACE=$(shell pwd)
> +export PACKAGES_PATH=$(WORKSPACE)/edk2:$(WORKSPACE)/edk2-platforms
> +export ACTIVE_PLATFORM="Platform/StandaloneMm/PlatformStandaloneMmPkg/PlatformStandaloneMmRpmb.dsc"
> +
> +# https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cross-compiling
> +ifeq (arm64,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'AARCH64'
> +else ifeq ((armhf,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'ARM'
> +else ifeq ((amd64,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'X64'
> +else ifeq ((i386,$(DEB_TARGET_ARCH))
> +export TARGET_ARCH = 'IA32'
> +else
> +$(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
> +endif
> +# When cross-compiling, or building with a different version of the compiler than
> +# the default `gcc`, we additionally need to inform the
> +# build command which toolchain to use. We do this by setting the environment
> +# variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
> +# **GCC5_AARCH64_PREFIX**.
> +# export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
> +export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-
> +
> +
> +export SHELL=/bin/bash
> +
> +# ENV Vars which should get set by edksetup.sh
> +export PYTHON_COMMAND=python3
> +export PYTHONHASHSEED=1
> +export CONF_PATH=$(WORKSPACE)/edk2/Conf
> +export EDK_TOOLS_PATH=$(WORKSPACE)/edk2/BaseTools
> +export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/edk2/BaseTools/BinWrappers/PosixLike::/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> +
> +override_dh_auto_build:
> +	source edk2/edksetup.sh --reconfig
> +
> +	make -C edk2/BaseTools
> +
> +	build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc)
> +
> +override_dh_auto_install:
> +
> +override_dh_auto_test:
> +
> +override_dh_strip:

stripping you can likely allow again when doing a true cross-compilation.

> +
> +%:
> +	dh $@ --with python3 --no-parallel

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


