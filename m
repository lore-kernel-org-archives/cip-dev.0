Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB312C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 13:02:34 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.57])
 by mx.groups.io with SMTP id smtpd.web08.4091.1665147745252120637
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 06:02:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lkHrxE9E;
 spf=pass (domain: siemens.com, ip: 40.107.104.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghd9DUBZs752pM1B8PfpLv5ZE8A6wuOwgMVCGjG0qOn/hZirqhZ7DNC0zjwvIVEIUvzAM/RDzVnG3Bfh6xzpiU+ylpFbwQJxAVYNDiZ+TYJBXmwluYMR64WpJ3XhE5Rea8LymeVUGOCK3kRuUgHbObgkVdcSQUqfUuh1M6wtzRJNqPABi4Czx05/lflavPHm41N6d2yJeZhgum0RoDf0sF2FZi2QeTMH/udrEAmQo6Yryc40swTiBmN9phJsRH23K/2nh3q3AsamTMyladbr70340F4twhA8O1rTh3XG2WTo+gX319hVhqmcSyitrc3UbkfnNw6fsOi507/A3gmmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIQz5PR1uETcmq6yyG0adIn2oxpMfWOiUal6irCqaMc=;
 b=Pk+5xwuD5nqSYGkz/hrPXsHFj52Vh89JHvtOhrmHgKWSwgYOAmlihTBwLWtIK8AHAIY4VGebbhw/jbwENMg+UFDmoTvMewyXIclwNQiP0Xpy4uWEJNkN0cYzaykTFzsId+uKh++vr60sULNOMYfT6WBWqF9R8BJC8Je9Zz7WdfbbcKwzOue0YOjASXDkXxIJkadS1MOT/hs6QG66EWv4ZuShAUUQmcG8MJ6ZNAJbokKsV1G4Y5FuFb9qER7ID0JwpOGbRLANxr7JDy7lsIbv43Yb00dAFMvqKcq3zC5PJT0tE5ku5IbHa/lnuMchwoUy/6T0MIjNcm9RJ16MXltBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIQz5PR1uETcmq6yyG0adIn2oxpMfWOiUal6irCqaMc=;
 b=lkHrxE9EXKI1b6GRLwowBNFEi2hKlXxvCYEgHUGxAM7yk2HaoPmI9YxM8Qlc9p7IdHQte4ZyXA1yHM0E9ijlJLDe64H8k5wk9Zw9DZ2Ux/fKyAyRg+EDgLKMA7UbVQkibf1Xcimyv4dAEkFm0tsNUdz/cqUZlQ0m7yoDZQ+ywBaELCQN7Bhj0Ymj04twzXwAKhyUO4zXH84FOiA8OlTOJumcsETIw/SO4vNCCpTGIPgMdS0latfXZIzrM4faSkbYomtgqAPUtpXN0IbY3ySg+urSP+DlC50YPTlYg1W5AeHuJqheOvXN2WJ9ote3hTWbh4ssgNE7tXHftXstR++nGg==
Received: from AS8P189CA0039.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::11)
 by GV1PR10MB6010.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 13:02:22 +0000
Received: from VE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:458:cafe::e3) by AS8P189CA0039.outlook.office365.com
 (2603:10a6:20b:458::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Fri, 7 Oct 2022 13:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 VE1EUR01FT069.mail.protection.outlook.com (10.152.3.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 13:02:21 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 15:02:20 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 15:02:19 +0200
Message-ID: <d647085c-b09c-7fa0-a8d8-4af006478baa@siemens.com>
Date: Fri, 7 Oct 2022 15:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH] Remove BASE_DISTRO_CODENAME from OVERRIDES
 variable list
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20221007125630.3665599-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221007125630.3665599-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.604200-8.000000
X-TMASE-MatchedRID: FdhKtQVb1TwDMlIVqipPBcU8jBVxKY1xPg9yfk4YC0a0pHkVd9vKzDRp
	dOU52PyTVI7KaIl9NhcVeUQnf3d3EJmkmEBuTbaAN4LvijDhF85ILCqqosnFtZxVZzZr7+O7S1z
	wNuiBtIQ3ZbGC9oP/O7wAmz0iQUL1r2S+N35n1LfWF5bNfsg8D+SoohD2GVbPqhcdnP91eXGCF6
	GkB9h+DzxZFF39deGHDF2FvWfVOuR7WYr9w0W4wijuLuQXBE1UlPpop9nq2f0VmB5Tjc+E4wYAP
	qHoVmYRxKLCLOyCW5D77lD0ZQU5Mp/pqLrD52g72vvqwiOCcM2V76rqTtD9zC/MuWzsdN8ZTnSp
	wnlY4yGbKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/slUCsvlSHiKovR0X
	/vib7yxesQ8aQiN9rXCTNk6Kxop/9uClLsAk68g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.604200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 143FA05472512411B95372F10C8F03E70C82EB6AF72B45BE11DAA1E132C306BB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT069:EE_|GV1PR10MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f610dd-76be-42c0-2a0c-08daa8642bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ggGvYTjFnl85qMZ/Z4HcIKddYiQj7VQOwgaTaYoZu1kx159z/ohftmneq+rKs1HwY+8CC2GNbliTl/1I92diy9Mh9XrL7AqZrKpRzOsH0j2CAmm3oInZSPI+gGOyEH1VvJ6ePgYzPZVWleY5NNSwyktNpIP3qBakNRfHf7yl8sGw0kU31hCncARUJbvYxUZSFYyzxfAWVvyjexQ7ElUcie0DNyuNbtz2AR1MY7BFzsxwcq3LkTuC8WEHGPyCbScWaGmIGHdFY6qrS75o1731L+bBCV/hZOffugvAYVmtoZ8pSu6iCMHr1MQdE3JzGD+gutb5AZBJfLWfcbQQ2xvWWyaMtEssJegWIKfj+PJ+yZ9vEpC2K4g76dbDFpLwlBWKu6kx3iIt1edex80NtO6gxiFJcR4j8yDNXOylyXISpXizfW7+TniKe+tqVP8W00QX03PajLkP+AKPRGe+PiC/p4LR/LStJHXHXrxQtzIkbjzd9sRjpaUaUVl8o5yIo6tyKAszXXUs0lIqRfyYQP/jZXzKoHgOc4ETpUdtZfsZyxg/adEPBXThGeBHRvZ5RPyQRgF2fB6y30dQt/EqsJZBqzY6kPmFYjHGjyYvZAdq/m+baJJ8Gh0Q9xQ8mef77M+qOMGNJMUPkrDjYXaO8s0u6FWBROkueDyIUTMnVteYTQP0oru42KifJRY+oFNRDT/O+tRF0o/WeA7GCgpaeM4MItozXjC2iBLrQnIf+9uo8wOq+/a1L+omGEb+Cwwy4iZVAB2chrxthWHSHI7qKJRCwRA6iNGOoC9nfcII+84A5DUTMHc3/gzhT7ZHXs38Py1dwq1m3CsaZ22mE6rJt33RWmRPYt21jJ7LJpQqj2Vz76A=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(6706004)(31686004)(6666004)(53546011)(16576012)(478600001)(26005)(110136005)(316002)(5660300002)(82310400005)(8936002)(41300700001)(70586007)(2616005)(956004)(83380400001)(2906002)(82740400003)(186003)(336012)(44832011)(16526019)(47076005)(36756003)(31696002)(40460700003)(7596003)(36860700001)(82960400001)(86362001)(356005)(70206006)(7636003)(40480700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 13:02:21.1831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 16f610dd-76be-42c0-2a0c-08daa8642bdd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6010
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 13:02:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9693

On 07.10.22 14:56, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> In this commit "71039175" onwords ISAR supports additional overrides ie:
> BASE_DISTRO_CODENAME, hence remove the local one.
> 

Ah, good cleanup!

> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  kas/opt/ebg-swu.yml                            | 4 +---
>  recipes-core/images/cip-core-image-security.bb | 2 --
>  recipes-core/swupdate/swupdate.inc             | 4 +---
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
> index b534c50..62889fb 100644
> --- a/kas/opt/ebg-swu.yml
> +++ b/kas/opt/ebg-swu.yml
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2022

I prefer to convert this into "2021-2022". Will do that while merging.

>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -27,10 +27,8 @@ local_conf_header:
>      # Add ovmf binaries for qemu
>      IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
>      # not needed for Debian 11 and later
> -    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
>      DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
>      DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
>      # Add U-Boot for qemu
>      IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
>      IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
> -
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 8ea032c..58a0f98 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -40,8 +40,6 @@ IMAGE_PREINSTALL += " \
>  	util-linux \
>  "
>  
> -OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> -
>  # Package names based on the distro version
>  IMAGE_PREINSTALL_append_buster = " libtss2-esys0"
>  IMAGE_PREINSTALL_append_bullseye = " libtss2-esys-3.0.2-0"
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index f2d478d..72c116a 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2022
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -13,8 +13,6 @@ HOMEPAGE= "https://github.com/sbabic/swupdate"
>  LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>  
> -OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> -
>  def get_bootloader_build_profile(d):
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or ""
>      if bootloader == "efibootguard":

Thanks, merged to next,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


