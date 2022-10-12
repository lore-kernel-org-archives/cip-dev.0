Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C545C433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 10:18:28 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.57])
 by mx.groups.io with SMTP id smtpd.web11.18500.1665569902292153269
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:18:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LRll1kYN;
 spf=pass (domain: siemens.com, ip: 40.107.14.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxWvMBG+QHpy5j0aujR8iQOB4fLFRtBi7VaqfS95HbFQSevc8KITHqVJudX1lrentMNEmPqHFG3/PyRnlPKgXpU2YBioEsFebXrxm9QUUmwL6Y0/Tekeo85HMbKWdY0idNm7kfy7iHkRBh+WMaX4e4d2nxQpfcNYivY5DH5bt1iQVh9Fu0RTgFFcJEeK3chDqSI8sqScZ4M0zM9Njsk4STHB2sEapUHTt1h1FjNOifn3FMbKkokbzo7+hbH3jjBHsmX4mxx+0HRy0Jumk9eR/85geawtsXRQSWBf3A+nujPcAFbc4D00vs5Dwbmv6mZhUcOqeWSwI0VKPyzM/ASkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd3Y04GlY/84Zm5okUZxzyhuflZE0coqLVaL5SWuzWM=;
 b=Gjng/DC/9nGaYUU6nuGF5yW4TQbtfnhcQ41vnP36+5wgMi6lrKSl0vX5x9ISfuKQ/E+TKnWLvUzl5yw2q5fUhZL7B5q2i82dNqVFTxEnj8i0+qN65okC6yWoaHiRu6P0ndb19NdERYgCRMgG/t3Ba6zLo8EDWNY12w2HVgqtAgwcbcFiCxGFX1YgZVhJQMg0w6JXmkFQdjxTTKga+T2A3eN+CtUj58lynatrF33jHqmeXkKhjPTidrWGWSgvZxQtajwCLZdypzVq12hnoBoIOWFTuBemPDQm8l3MSy1og72VPhXUywQTeZbZi1QbqKNLXfdXtJ3B5IZ98UABo9ItdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd3Y04GlY/84Zm5okUZxzyhuflZE0coqLVaL5SWuzWM=;
 b=LRll1kYNAIWxS+4QWV+kZnl1Uo+4dGx2PM4Q416yWdFzVsQDsPyRZ5RzShR+Vt+uyu8DBeWZfTbJOk8KLPMbnsnzZsNkwV3WioJyzLr0vlfl3Wynt+1fPgxvJycaSc7Fw3WFG5ahAIidrU6I5Lt1yZsKAai6mDJRck2kBG76+iW2evQe/7e/1oszyxW39swk8ONYDDaMc7k0Sxk11tMitcY0G7Hwq7nupQAEmcB78lO6GotMPsDg+1biAWBEo6qb62Sxo260U9BBEgJCqdL3TVQQ8za2f15oruc9wmUADnX7fg+Y6RXVgpVXdquz01ITQ3J4orxOvTP/ZPBWxhqcOA==
Received: from AM6PR08CA0024.eurprd08.prod.outlook.com (2603:10a6:20b:b2::36)
 by GV2PR10MB6576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 10:18:18 +0000
Received: from VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:b2:cafe::b7) by AM6PR08CA0024.outlook.office365.com
 (2603:10a6:20b:b2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 10:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT102.mail.protection.outlook.com (10.152.3.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 10:18:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 12 Oct 2022 12:18:17 +0200
Received: from [139.22.133.11] (139.22.133.11) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 12 Oct 2022 12:18:17 +0200
Message-ID: <ce77a883-c6e1-aff5-f660-a3a2947dbc26@siemens.com>
Date: Wed, 12 Oct 2022 12:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 2/3] fix: add squashfs hook to enforce load
 of module
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: <quirin.gylstorff@siemens.com>, <pluto.svc.chengdu.cn@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
 <20221012100641.2986740-3-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221012100641.2986740-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.11]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.985000-8.000000
X-TMASE-MatchedRID: FdhKtQVb1Tw5QaOxwNGfvo9bHfxDWoibMz0EFG5lnW8aLqFbxdotGa15
	LjjfKZ5ReJ2wUW7zU+M56GdZxUF9VtmqIsW3VRTwE8PXSeMI5jizV1diHrOnxy0x8J2DopENnyq
	/bcbNBBjfUZT83lbkEK6PKQSZCnDqquZNDw2pL4r7uuADRDIwrI1pcgBT/7NsXrumkbea2MmbYJ
	TL8pwAni196sn93sBvKlOONM16uHGMNUzDpMm+4bbkksBtHjUaEWj1c8a4XmYmZusHWPhfCnHv4
	qNcyiZVRqYP52QLif3Uizka+GYZvLGjPy19ZYXTb8sRH38VoJGV76rqTtD9zC/MuWzsdN8Zy0Mf
	D1GsI1ubKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/saW/rR91uNnIQwLc
	3cy91AVScAqu8EQFjiVA21XAriM4rC75Yp1PA4Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.985000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 92246138D81603C58AE948B1AE9E19C6871CB2DDB43AE3287F38EF61025B200E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT102:EE_|GV2PR10MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e4d78e-ff2a-4562-55f2-08daac3b14f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7pszoiWvKTaOMLyB58l4OvRh0IswUoIv4SKX0JiUdTmzPEktNWCI67Wo2U0EhmGjFhgImYT+aR48kLGGkPweKo0HQPxlw6WnHAs6DhFBqXq2QKdnVW2rXOMtN9PdR8zVxkUipZOexUyQc/vgtB9pVx4VaYPNqfoT3fg48NKF9HGnLGA60emrzOuRYpkbePq6POKO0herdQh0IpkinXNShxCC8YyrWewHVr6fCtgmVpn/3LKmGVqd5gltVgKf/9ikB/l0dOLTnzbBtHtpchIOsYUaLZvlA4zYEkhT2LsgXy2aORaoMRDCDUPV+JRJAO6T2qkqgMjm02TdxAJuO3wY7XRstNmai+7EGtl0nK0MFwyeZLaOnP7IV5Jrljw5vcLHCWxib2Kp2uiKY/4qeF91so41BTcHKqI4TJzleko9/Qe1RuBPC95kpIZ0VqFoBcS/REqj+LHvR1HB90rOxoKFh/wi7gdLG6GwhwfKXpzMErK+HqjVFR3rUhiXvkGfnak7+hCgXeE1ppI1InuDK8v23HtbARynw7jRWOCPankK1Oh1ERKQWtyfZ+DGcj9dElur9nSuDZtLmA4Q5Q1KgBskGP82uPEjd7dAHRb2PwuEv+7GVkpcksjhLzOF/K0rVf3CmpaSSBcdNW9bAOjtcNVOEfGHytM/HvMfLU4lOexyT5Y9tbsIAmohrwH1i06amGycAxSIlMDZGtMZpwvgPZBZ9RYutWNc4v7MsqgZHAUnNFUjeFRS6zlX4cAuQWSEUbIvKXL0kQd/dMauZ2Y4ThTvzW0G+mgvpQoifu43n5zAA0a1Kq1PbC0CkZ/JPZzOPlZdsDF7L0E8nuX96hYVEnOsBI0xTaJ5QC6DRNZK/MYoBNo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(36860700001)(31696002)(82960400001)(356005)(81166007)(86362001)(40460700003)(36756003)(6706004)(40480700001)(110136005)(16576012)(316002)(478600001)(8936002)(83380400001)(8676002)(4326008)(41300700001)(5660300002)(70586007)(70206006)(47076005)(336012)(107886003)(6666004)(44832011)(2616005)(956004)(82310400005)(2906002)(26005)(16526019)(53546011)(186003)(31686004)(54906003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:18:18.0301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4d78e-ff2a-4562-55f2-08daac3b14f2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6576
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 10:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9737

On 12.10.22 12:06, Felix Moessbauer wrote:
> This patch fixes issues when using a stock debian kernel, as this kernel
> has no compiled-in support for sqashfs.
> By explicitly adding the module to the initramfs we ensure that it is
> available.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas/opt/ebg-swu.yml                           |  2 +-
>  .../files/squashfs.hook                       | 25 +++++++++++++++++++
>  .../initramfs-squashfs-hook_0.1.bb            | 24 ++++++++++++++++++
>  3 files changed, 50 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
>  create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
> 
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index ce37c36..914c743 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -22,7 +22,7 @@ local_conf_header:
>    ebg_swu_image_options: |
>      CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>    initramfs: |
> -    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
> +    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook initramfs-squashfs-hook"

squashfs is selected by kas/opt/swupdate.yml, so this should rather go
there (at least as long as we control things via kas snippets).

>    firmware-binaries: |
>      # Add ovmf binaries for qemu
>      IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
> diff --git a/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook b/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
> new file mode 100644
> index 0000000..0b9b208
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Felix Moessbauer <felix.moessbauer@siemens.com>
> +#
> +
> +PREREQ=""
> +prereqs()
> +{
> +    echo "$PREREQ"
> +}
> +case $1 in
> +prereqs)
> +    prereqs
> +    exit 0
> +    ;;
> +esac
> +
> +. /usr/share/initramfs-tools/hook-functions
> +
> +manual_add_modules squashfs
> diff --git a/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
> new file mode 100644
> index 0000000..332278f
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
> @@ -0,0 +1,24 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Felix Moessbauer <felix.moessbauer@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +SRC_URI += "file://squashfs.hook"
> +
> +DEBIAN_DEPENDS = "initramfs-tools"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks"
> +
> +do_install() {
> +    install -m 0755 "${WORKDIR}/squashfs.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/squashfs"
> +}

Looks good otherwise. Though it's a pity that we need so much
boilerplate to add a module to an initramfs.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


