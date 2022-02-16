Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C73C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 16:16:57 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.71])
 by mx.groups.io with SMTP id smtpd.web08.1147.1645028216389908366
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 08:16:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kfpVawep;
 spf=pass (domain: siemens.com, ip: 40.107.4.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6Dn1stsQQ52bqrahz5zfg2gjFzM26nyNjdNY7vZOzbknNz2nanTEnE93WEvsVghjYu/UNk6yjF5CgQBXWhB1HKlpfrq+fsxTi2TYx+GL2yWyYMSOU7Thkl0pti2BjaBHqrSPT4pj8IH7laa7G5PqwQs1n9muSG9RWnawJP1mqLndgAcQoVXF6ElX2Ukg7lVHl5qoSdJgAgLhqoYsvq4Wnsk+Vg85UYY9QtoswKd7ukppac7ysH1IqzgiwHvlbl1OsfqX2NMGwuIer7DRc/sEb1vPu6lShMCDVGHxFkP/iqaErly3Tw5gJco7b/oNJFQPbDxEOOd2vwwFUN7mI/nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDWlWlQ1M1/mhAPqxePoFgrvr0bx+bAzGqXnOj59HzE=;
 b=IIZj+ZKI6gzK7znuWcHtZS5Ie/GCFwVCSr5HUQ1XUy5GCsUb6gCtOrI8QyAF8Pb2qOZzMT7hMb9TjleQMIj7o84AlrYmlm1B635aNujKA0JsVH8qdEEGG6iHl3GNa8Kl2iPYo+Xw1pk+PDXjdeLMZsKI+SzQ5q5M9lSHm+/mNm841Fo4XqINyS5lgWHayelpCdH6DDlxl7SaMyGWu4UzEzLIfewJasqRjWdlfyH4FVFu1Sw34zUYoiAjY/CwfTuKwx/bK3NB3PnVXKl3ELKqgI0qePEQXCC9yd6l2NWabEaladbbF7YOsiDUA9epovro3ea0tW6C2COw7EGyxpdX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWlWlQ1M1/mhAPqxePoFgrvr0bx+bAzGqXnOj59HzE=;
 b=kfpVawepuqJRbeDMCbCEEtVy8HuOg6iDB5orlc3x2YlgCewdkbhd3rFJ/oU1yVuJHo8bC42LZQZoIx3nxlat9eC+dNcYD99eF3RjJ8gL6y9IlcwxTcGq0a9c+dlOE9HxJDurZMFYJSkN6vW8f3sIuNd0LvQcQFop+IctlOd6ybHv0lLv57ovtsPQFSKO6cIKIjCUWKYSjLjUpRTr6DzlPVoEFG2OazblrTKAlU3V/Ud2BesCz+6JY+LMrJfQD2H1uGDSwSc4CRSAwn6cCp6DaldeAnm23yrfbgsP/FdbXOOcvdGaScRWW9W/H2cP3j6gbnDsBctEnfNDYtMGRoDTwQ==
Received: from DB8PR09CA0013.eurprd09.prod.outlook.com (2603:10a6:10:a0::26)
 by AM6PR10MB2887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 16:16:53 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::e) by DB8PR09CA0013.outlook.office365.com
 (2603:10a6:10:a0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 16:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 16:16:52 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 17:16:52 +0100
Received: from [139.22.138.23] (139.22.138.23) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 16 Feb 2022 17:16:51 +0100
Message-ID: <dade869b-8f70-7b4b-418d-00fedf32bbdd@siemens.com>
Date: Wed, 16 Feb 2022 17:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [cip-dev][isar-cip-dev][PATCH v2 1/1] Update ISAR to next
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220216160359.3517492-1-Quirin.Gylstorff@siemens.com>
 <20220216160359.3517492-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220216160359.3517492-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.138.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54ddf2d-cf23-44af-f8f1-08d9f167be5c
X-MS-TrafficTypeDiagnostic: AM6PR10MB2887:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2887B0B62EC53EDFB2EABA6A95359@AM6PR10MB2887.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SXRMbMsLCpdCcJLLAofq4d5L5KqzULQq1QrKut6pneNYe82rMgcMjA598yAbM8vdIT8io5ZBvN5YNL2LHE6uBPiyzaHypXYXf9eQoNnxLk1bqCYuAqb8ZpNr/KkRpS7xcC8y1lwRntKz0BP5C0bKyBV8XBpOmWM6EoMO7eheAQw1ejE0YoDYTzEmhB5A0qc1Q8ZV09s5nvMfRhMOPuIu4TqINr4Ot+C5hrSsD5R+r5syWR7FwabZYYd76jAz4Vr3LCvX3bOJ18LoW28daLJ0rvJE2KexmubYsukUTQ+D+vLzksflK5Z2MoelvcC0A7S7MbTie/SDKwtSV5xwpawqy4h3u7xaKAe9MWGqGRcQFSkAuDTWgx7iL6aMur7V1J+RmyIFntxbbTOvYF9QhLF/I+jVnPpAiRx47sLvey/jZDfklAN9MrbnFhBT3VUyjoScy2hy6AcFHcoYHP76Z0sdQButWQOfuGRnRW5LsVEqvoyUV5MJhUcJAxqhx2xQmBCzCJi7mhkUi79Ea/ZdC1ZLG2rkWY5z6PJs5lcMOYi5druCyVH3E1U7aYXW6NKFcphSI5KxbqtJSaCzdvkJqMr+CH15mGMywiC2YUKYNH/bJgRlcq5fLGpwj8vvS7d0Y/p5O7G0KBVbi0VI0dCClSGxlS8R/q3l9i7MtpXcy9aMx5IPrE+w3yVDyQ5EVQasupCsVjjCbXhQ5HDtSgrWhKUIePtQq/jNzE21jrrJOUFPnA68vRAR6Xx+MZ9gu8fD0FTrSIm9vXQPGb5i9ZuxUmfZl00bwwzQFeu51mzoYb3SEdrHfw1ju/DwmByHcVErGIGScB+hlDqiUVBieqBVNzpDOIm4ugF27qmhkTTTA0NR578=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(498600001)(16526019)(83380400001)(47076005)(15650500001)(16576012)(31686004)(110136005)(6706004)(966005)(2616005)(70586007)(336012)(36860700001)(956004)(70206006)(186003)(44832011)(53546011)(5660300002)(26005)(7636003)(8936002)(2906002)(31696002)(8676002)(36756003)(82310400004)(356005)(86362001)(82960400001)(7596003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 16:16:52.6544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f54ddf2d-cf23-44af-f8f1-08d9f167be5c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 16:16:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7626

On 16.02.22 17:03, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> refspec is now cf3f18a649ff42726677a58b224b9bb58ea4ba46
> 
> This adds Debian build profile support
> 
> The option 'nodoc' is no longer necessary
> as the build dependencies of SWUpdate were fixed with [1].

"
This adds Debian build profile support and requires to update the
SWUpdate recipe to use this.

Along this update, we can drop the build profile 'nodoc' which is no
longer necessary as the build dependencies of SWUpdate were fixed with
https://salsa.debian.org/debian/swupdate/-/commit/d666b84435e1b1abebc6070252872ed390ac4df8
"

> 
> [1]: https://salsa.debian.org/debian/swupdate/-/commit/d666b84435e1b1abebc6070252872ed390ac4df8
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas-cip.yml                                          |  2 +-
>  recipes-core/swupdate/swupdate.inc                   | 12 ++----------
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
>  3 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 9c8ac9f..fce176b 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    refspec: 33b5aa65fa3f28987525799d0731fb4e7050207d
> +    refspec: cf3f18a649ff42726677a58b224b9bb58ea4ba46
>      layers:
>        meta:
>      patches:
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
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
> -SWUPDATE_BUILD_PROFILES_append_buster = " \
> +DEB_BUILD_PROFILES_append_buster = " \
>                                     pkg.swupdate.nocreatefs \
>                                     pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other

Thanks, applied with the above commit message adjustment

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

