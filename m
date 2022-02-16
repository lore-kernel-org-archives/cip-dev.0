Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9220C433EF
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 14:35:06 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.77])
 by mx.groups.io with SMTP id smtpd.web08.12509.1645022105425878696
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 06:35:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fNTkXmWe;
 spf=pass (domain: siemens.com, ip: 40.107.7.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLsw1CfaF35MbtIdO5svll8FyoaTIcXH4WKNwCMFpxPhNo4c4WGncJHhcXMWtoGKquVkY0TuZyeCYZZ1ayTSisx35Tbv7lEteJDIry1TZ5moWZaBJR7GBn9HkEIRZHN9iOZNP46rcmd57KE0ezeWunJCs5gof/EEhs3teQ0UTQmWPpYCi/uZNdsX8aeFlPOtWZTH1+3kh2dv0Q2J3y22cZo8GKbg5iEI0P7VaU/iXEpjVB1l3qb6neWiV98KxAKtQjwh9H4pijgbxa1BQpZ19DknoBmdO+3gA7BTETdKWZaiThkIk7Ju8t+bwXQ4JczD6Z0Wrovn4DCo/JhJMTqZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UDmYD64jOolQVl2uniL9mJEU8mQXqv58o/pgTEYWgw=;
 b=mBRoDpOyxUdSqmRszgbE/cPVFSgcnyvZcB1EmJ91rVjRzt/Ie1pdO9oXsOk9j5wKVGe5zu7t6pNSde1NimCIv61U/ROqi3DYFCxgJ8tz+vUeoCWRM1aOKJZYq+vCYqa5LE0l9voOECYk7CH0biNNEsm5wXBp7OVlseNaV89OhHtBhvaJgIi2N59KunxOReXEzRpE2etd5QFhfHm9LCGLA/VR4CLSjOq6yajVxUxPeC5VQTaozYFcBGErutRwbSWre6G7B0X86CrMVsRuDTCV13ueF1OiYlnndvfUqEipv5DiWwtBoUbdNDYnQI5pls5U5RFYs1zaNOfpsbUaWMtqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UDmYD64jOolQVl2uniL9mJEU8mQXqv58o/pgTEYWgw=;
 b=fNTkXmWeX+wO0au/ZjJQZhgz0ni3W9moHizn5iEsXq3B9SD0GzjBNStVCfDMGankzTHvTl4UxyY0XX6xJTW8mHuBPJ1mAQZl+KkVrejB7HYBm7JxoB4nWf+SQREpw1OiLqwjsX3hHS6jqoTgaYKYeVdN/aGcPYdMBgRLT8QJ5xlcyrCdDKknPA6JGikGTTOBXxULE2SXNx7VSvCbabq5HuYacUOPw4RraXa5iVO2Eq1YKEytcM8f+6Kc2r9NSOWZEQ3u1XA89DwW/rEyemJJQsL4pQd0akEozup0shh/ArsIslLJ6fxeou2S+ApASlaa12QX+Oxt80cNpbtthB6CcQ==
Received: from DB6PR07CA0113.eurprd07.prod.outlook.com (2603:10a6:6:2c::27) by
 PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Wed, 16 Feb 2022 14:35:02 +0000
Received: from DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::e2) by DB6PR07CA0113.outlook.office365.com
 (2603:10a6:6:2c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.7 via Frontend
 Transport; Wed, 16 Feb 2022 14:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT059.mail.protection.outlook.com (10.152.4.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 14:35:01 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 15:35:01 +0100
Received: from [139.22.138.23] (139.22.138.23) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 15:35:00 +0100
Message-ID: <9e70ee9e-51fa-9963-a4b2-f0ce87cff0e4@siemens.com>
Date: Wed, 16 Feb 2022 15:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] swupdate: Convert to
 DEB_BUILD_PROFILES
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
 <20220216130317.3018990-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220216130317.3018990-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.23]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8fe33b0-b156-4cc5-95cb-08d9f15983e5
X-MS-TrafficTypeDiagnostic: PA4PR10MB4400:EE_
X-Microsoft-Antispam-PRVS: 
	<PA4PR10MB4400FB8B0F2BFD42B0021FD195359@PA4PR10MB4400.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CAddnVRcQENd2zzl0qpHLTH/nxuidc3KuSIvOHJNUUpKeePtab5lMhRSkcTecVK/O4eNBGYF56/yOHyN1AkgWAB7H912jKzLKk79UKmIgMuCNY7bHPpNMeVNwyXSW2Wg/J3MXYIL7ZujrOikxJ1i+uNthmhgKejo9+VBxZTSvOnGm3Dy7y3ACBZSFw4UTaei31RqWbRrs498Gt9RdBArQBlKe6XdD1lh67+2oPoDXo7fUljxf0vLo2MEmm8bELmbM9nuW9S4l/aVMY4X14P2yuzzCfLmPUWG+CaytXyN9/kUqqBPX+Q+lpT71u1EsMsOf83Rrg4Jdjj79AooahWGcUFH7Kqr/XP6rmPG3gxavAxqrJPbPqUg0q8LPtqf9fsJi2guzmmlD+nkJttBoISBzK/0hZrdovpOSbIve03dlEp0+bORmq/4Rk/LHlGuGLvLatA2+UOi8e7HujctHtup+N7jFLlvJIThqlzPcuaFbfHVL1seXqPVY7Lv4QynVC1hcEB6kvKOzB/DObR9WaMZx7MKaoSYVX6QnAj64N6Iysw4cD7ysjYafeGWuV6oYg/jkPW4nbq5hQ+5XISVxrn4oU6PL+9O9O09u+sgw4d2fbo+B6OLKbHhnr99+QG/rJy5FxNS2VSns6XYxYsi+cnLoPwiJZh2V1tq574EBCaSuQgj4Qy7OtrJ5e3vcvIFUlNrTivSuUwincJnfWNfCCMPKHQpCmTwT4i6X6qLOBPeLoIeJzygf8y7OvyDGbbk6263
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(26005)(186003)(16526019)(8676002)(70206006)(956004)(70586007)(2616005)(31696002)(336012)(7636003)(7596003)(356005)(36756003)(40460700003)(86362001)(31686004)(508600001)(82960400001)(47076005)(44832011)(8936002)(82310400004)(83380400001)(5660300002)(36860700001)(53546011)(6666004)(110136005)(6706004)(316002)(16576012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 14:35:01.6099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e8fe33b0-b156-4cc5-95cb-08d9f15983e5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4400
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 14:35:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7623

On 16.02.22 14:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/swupdate/swupdate.inc                   | 12 ++----------
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
>  2 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 7812ae7..f2d478d 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -23,7 +23,7 @@ def get_bootloader_build_profile(d):
>          return "pkg.swupdate.uboot"
>      return ""
>  
> -SWUPDATE_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
> +DEB_BUILD_PROFILES += "${@get_bootloader_build_profile(d)}"
>  
>  def get_bootloader_dependencies(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
> @@ -37,15 +37,7 @@ def get_bootloader_dependencies(d):
>      return ""
>  
>  DEPENDS += "${@get_bootloader_dependencies(d)}"
> -DEPENDS += "${@bb.utils.contains('SWUPDATE_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
> -
> -do_install_builddeps_prepend() {
> -    export DEB_BUILD_PROFILES="${SWUPDATE_BUILD_PROFILES}"
> -}
> -
> -dpkg_runbuild_prepend() {
> -    export DEB_BUILD_PROFILES="${SWUPDATE_BUILD_PROFILES}"
> -}
> +DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
>  
>  python do_check_bootloader () {
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 699dad3..bf060b4 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -28,25 +28,22 @@ SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>  # end patching for dm-verity based images
>  
>  # deactivate signing and encryption for simple a/b rootfs update
> -SWUPDATE_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>  
>  # add cross build and deactivate testing for arm based builds
> -SWUPDATE_BUILD_PROFILES += "cross nocheck"
> +DEB_BUILD_PROFILES += "cross nocheck"
>  # If the luahandler shall be embedded into the swupdate binary
>  # include the following lines.
>  # DEPENDS += "swupdate-handlers"
>  # GBP_DEPENDS += "swupdate-handlers"
> -# SWUPDATE_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
> +# DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
>  SRC_URI_append_buster = " file://0009-debian-prepare-build-for-isar-debian-buster.patch"
>  
> -# disable documentation due to missing packages
> -SWUPDATE_BUILD_PROFILES_append = " nodoc "
> -

Why can this be dropped now?

Jan

>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_buster = " \
> +DEB_BUILD_PROFILES_append_buster = " \
>                                     pkg.swupdate.nocreatefs \
>                                     pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other

-- 
Siemens AG, Technology
Competence Center Embedded Linux

