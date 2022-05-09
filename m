Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF28C433EF
	for <webhook@archiver.kernel.org>; Mon,  9 May 2022 13:19:45 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web10.31512.1652102383043496828
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 May 2022 06:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KvxfV3G+;
 spf=pass (domain: siemens.com, ip: 40.107.22.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKJYhcDcbROhfkqpJ/yBaKevaWKjW60Peo3ITxSHk4fnqLOMoPw0fpGBRQv3A6h8nDCIDjEqYKLDA1aMr022lzUDCt16kpsOc8ddm7scs5lV3yL5yDlybEpe1jSmUajR/BVGC25nAnmjxuYxLdR1xGT+bN6msfnFtyOetRIS9BZ36dXnwik3c5940eEnIk8+fta7e7Bmkp9ZSjYRytvh7ZoJo8wOXPDX+wbkeG+jIj32pb37WvaRgW+sQWuVCioFwKjFWSPeQemMSCSIgKu2gfOKMsI3+BtdX4cvKQ8udS1xMSeQKcFZWOOSDD2Zsgh08DKbvVYJIJ57BMM/frsmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cu+u/AL2TEkh/GnJ3VT0sr+ndafR71P1Xc1b28LNmW4=;
 b=ayjHNOXW7lgTAXcT0NXzhKEQzdJx4Tis5+wyM6TZXTLIDmzoqEJey98nHz3FqkG/goBwCk3BeC8BhVNABrh8xs1irGtYO75n+i9PyrJwntuYbcgRi4u8Q1Alp5QIIBOqEFysDeyRRiOkTh0KH35/929vCvu02uK/NtkyYxaDXzYy3u4qFGgoR86bVW6LlCnbzHcszJXw7G+VfFk90qX/O66v68pKC7mXMhcI18gNGgx2tGXZbV+JU3WzK+wbBuK95EuEqlhY2DXpZM6bNUpeQ+fUDAVV9MMVEekriE5eOFDqMalWodyfNR3McruSkmiO0f4d0W9Jiik6jgQrZvapkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu+u/AL2TEkh/GnJ3VT0sr+ndafR71P1Xc1b28LNmW4=;
 b=KvxfV3G+OZcwpMFQ6/Xkx585LwGFGyF1omarvkgPgxKtdUQx6Kb1sMD+D1RVU/jPYlzTjGkoIZIm1ManX7BCufQ1x415nq4nJFmCbWG72zEUPgzu6PTGlhR3eL/6yyQTyct1Ot7bnAGMQHeIpxk91TTrNjJc2QX9yyPaRNi074xIaHVcdTDylFLhP6Eo0OmIsOHbQ3Wsemm0L5nQYm3nz51pOe7Ykzo7ksm/2O8aKXFVNUYoR4eWiKjQU3CVRTNaomdhrLGFyCtWCVe1H5NMl8/t4CqYjLt1kbpwGmoFnPsTfSsoxGscPbxXWFg76c5EguCz5OUtovnXK9RV76QUkw==
Received: from DB6PR0201CA0021.eurprd02.prod.outlook.com (2603:10a6:4:3f::31)
 by PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 13:19:39 +0000
Received: from DB5EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::84) by DB6PR0201CA0021.outlook.office365.com
 (2603:10a6:4:3f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT027.mail.protection.outlook.com (10.152.5.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:19:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 15:19:38 +0200
Received: from [167.87.0.83] (167.87.0.83) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 15:19:38 +0200
Message-ID: <26e6479f-6273-5a80-e56f-2b5c862efe46@siemens.com>
Date: Mon, 9 May 2022 15:19:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Update SRCREV
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220509101512.677739-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220509101512.677739-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.83]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.858500-8.000000
X-TMASE-MatchedRID: SPXcha2wtZzdDS6etHbe26x38sCrHdkHPg9yfk4YC0Zwju9EALAXQvio
	Isi7Sa0ggCOzL6v7C+em2AO8c0o94vGwUUhZtzr+3tp7FoZbCBJkbZZpQYfY4dbgzPjrV+wcMVx
	/3ZYby79IyDY579vwTJ+FqTi6pivIl52eY1rK6QzJfkpcq3Et/RLmJd2F/yFuXrumkbea2MlNej
	dAw/bX3xdHcHEd3javlSG36bKvRcz9Ktxj1mXhOuMSAZlt9hpXFDf/GgM78iVUs0TDb9X0Q0jI1
	dwe+QhroqwDjNjTZr+8ozyo7WOjviDo43Wk5cxFv/CfDioBi1YRaPVzxrheZolSWYvdSPSY45oD
	ENe4eeskt9BigJAcVmQiKyC1ofOhI+rhpvntdArvEIEamxTF+X1b439cTWEv4M3l0EeXvQ2CeHf
	YZgVO5lWFxdHdn1FZ9Tli/YRJMCxMbUCnd/iP0wit8x0W+xqjlFKRvEp4lziGOUGPCmibUyg7JA
	mHu44osp5O052MzLoFy697ryXmTFNJhYpzkChdsSaKE9/EoAvNgU56HvTLO461Z+HJnvsOLozI+
	rhNYbm2zFWqrVN4BWQzoQON48kSF9I3HgybRyEyh2C7EeKtC01+zyfzlN7ygxsfzkNRlfKx5amW
	K2anSPoLR4+zsDTthUfR2rvBju59CEIFVHpQLQsBK3Fa5K8mITqizGk7SPrfBXaF2kP42axAM7z
	NNhMu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.858500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 1825C155DADC8EFDC9EF376E031FF0F4B07CF0F7CF994E0E8434BD29D530C6622000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4440a8c-f836-4393-1f1a-08da31be923e
X-MS-TrafficTypeDiagnostic: PR3PR10MB3802:EE_
X-Microsoft-Antispam-PRVS: 
	<PR3PR10MB38028343AFEF9AB4759A8CFD95C69@PR3PR10MB3802.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+/EDFLSMQIMvtOzn0vo21uijeReel2nSXlb1WcVuKCSOo+CUfkj8qKgENPM/60DTpYv6p4b82aE6A7vgNWAPQVTVo2VfJhvnbUvcxGK+NM3o/6ZbnawtTPAEpHF9dcx4wUR05pgH8ZT1NCiu/08/7gzvYsEc+g9d+VvX3U2BAHY9HLz1fC4TYkA9YAv36xvgjIdlV1d7uSHz9Oqd/YzxHFRBVQrLxo5K7ZVNwjvofQvOvLGubZu8WlvpBVbGMPxIlZgsbaef3NMQTL2fvxgrviNdhpoWqFiAoDIHp21vGsTpPD8RgtyO69zIGAhabQNJJnN8HPxTKac5Ec31+sEExNMmhDpzPSjU1imJoo3Jf2+sSuEVL50n87GTEXCZU4fgfHAfXW/I0QxUv2GrT5/94Xm8qeDIFhDLd/+1VdrXUiKbktJcrQXT2regvqliRBY/49XSNd2eOLfPgP+6kHGrneCvWTHdQnSfkE9iaxrx6V93o4HnkELgUQ/SJxRjz71gGB50YykcwU5rINHLhIps2iCP5k6kBTLsWu+HFBWGkNjYR7BY3ixUHQyeRwp7jBdnWR4LrmMSU81oWNp+wZLwzdaWKmh5tQlAs4hMf9RJ1812jVzqopTAMN8g+3yUWvZyCtRWUd0JpZgvaRqt+i+ZDpeg4F57aQWNoB3I4wFy+AM6SsvTLJp/yeYA29O8HRpnlp0ZE7NRZxXdy6hW5SqEXBDPk1GYSA3TQR+jYuk6xLAFWASp2wJToxvwTeNjKXWMaGGIJ8AZXwV27qYbetFX1a2pVxHx/YZmHDyFdv0XYQUWlBLcCjQr/AAxdFceFnmoRbAAOGsU0qAcYhqOyiAe7hMF/tBNyOFOxrPm9dLjHLg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(956004)(2616005)(8676002)(70586007)(16526019)(31696002)(186003)(47076005)(70206006)(83380400001)(26005)(86362001)(966005)(498600001)(16576012)(82310400005)(110136005)(6706004)(53546011)(336012)(81166007)(8936002)(356005)(82960400001)(31686004)(40460700003)(44832011)(30864003)(15650500001)(2906002)(36756003)(36860700001)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:19:39.2714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d4440a8c-f836-4393-1f1a-08da31be923e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3802
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 May 2022 13:19:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8272

On 09.05.22 12:15, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Update SWUpdate to commit https://salsa.debian.org/debian/swupdate/
> 344548c816b555c58ec199f31e45703897d23fb5.
> 
> This contains the upstream version of the patches:
>  -debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>  -debian-rules-Add-Embedded-Lua-handler-option.patch
>  -debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>  -Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> 
> The available build options are now documented in ${S}/debian/README.Debian.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes in V2:
>  - fix build by setting backport option
> 
>  ...SWUpdate-USB-service-and-Udev-rules.patch} | 24 ++++-------
>  ...onfig-Make-image-encryption-optional.patch | 42 -------------------
>  ...les-Add-Embedded-Lua-handler-option.patch} | 10 ++---
>  ...es-Add-option-to-disable-fs-creation.patch | 16 +++----
>  ...ules-Add-option-to-disable-webserver.patch | 18 ++++----
>  ...h-to-fix-bootloader_env_get-for-EBG.patch} | 11 ++---
>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch | 40 ------------------
>  ...repare-build-for-isar-debian-buster.patch} | 34 +++------------
>  ...option-to-disable-CONFIG_HASH_VERIFY.patch | 29 -------------
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 20 ++++-----
>  10 files changed, 50 insertions(+), 194 deletions(-)
>  rename recipes-core/swupdate/files/{0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch => 0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch} (65%)
>  delete mode 100644 recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>  rename recipes-core/swupdate/files/{0006-debian-rules-Add-Embedded-Lua-handler-option.patch => 0002-debian-rules-Add-Embedded-Lua-handler-option.patch} (83%)
>  rename recipes-core/swupdate/files/{0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch => 0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch} (89%)
>  delete mode 100644 recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>  rename recipes-core/swupdate/files/{0010-debian-prepare-build-for-isar-debian-buster.patch => 0006-debian-prepare-build-for-isar-debian-buster.patch} (58%)
>  delete mode 100644 recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> 
> diff --git a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> similarity index 65%
> rename from recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> rename to recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> index 90c8d98..239b389 100644
> --- a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> +++ b/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
> @@ -1,7 +1,7 @@
> -From db391d1dd34806ae6694205b08b4661318bef37b Mon Sep 17 00:00:00 2001
> +From 7925d016efc3e9ebac10a465f165135f21c5d799 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 7 Feb 2022 09:28:39 +0100
> -Subject: [PATCH 07/10] debian: Remove SWUpdate USB service and Udev rules
> +Subject: [PATCH 1/6] debian: Remove SWUpdate USB service and Udev rules
>  
>  The current implementation will install an abitrary SWUpdate binary
>  from a plug-in USB stick. This is a major security risk for devices
> @@ -13,16 +13,14 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
>   debian/rules                          | 1 -
>   debian/swupdate.swupdate-usb@.service | 8 --------
> - debian/swupdate.udev                  | 2 --
> - 3 files changed, 11 deletions(-)
> + 2 files changed, 9 deletions(-)
>   delete mode 100644 debian/swupdate.swupdate-usb@.service
> - delete mode 100644 debian/swupdate.udev
>  
>  diff --git a/debian/rules b/debian/rules
> -index 12eb0ba..76fce01 100755
> +index 95d4d48f..ff8b6726 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -101,7 +101,6 @@ override_dh_auto_install:
> +@@ -79,7 +79,6 @@ override_dh_auto_install:
>   override_dh_installsystemd:
>   	dh_installsystemd --no-start
>   	dh_installsystemd --name=swupdate-progress
> @@ -32,7 +30,7 @@ index 12eb0ba..76fce01 100755
>   override_dh_gencontrol:
>  diff --git a/debian/swupdate.swupdate-usb@.service b/debian/swupdate.swupdate-usb@.service
>  deleted file mode 100644
> -index eda9d15..0000000
> +index eda9d153..00000000
>  --- a/debian/swupdate.swupdate-usb@.service
>  +++ /dev/null
>  @@ -1,8 +0,0 @@
> @@ -44,14 +42,6 @@ index eda9d15..0000000
>  -ExecStartPre=/bin/mount /dev/%I /mnt
>  -ExecStart=/bin/sh -c "swupdate-client -v /mnt/*.swu"
>  -ExecStopPost=/bin/umount /mnt
> -diff --git a/debian/swupdate.udev b/debian/swupdate.udev
> -deleted file mode 100644
> -index b4efd0b..0000000
> ---- a/debian/swupdate.udev
> -+++ /dev/null
> -@@ -1,2 +0,0 @@
> --ACTION=="add", KERNEL=="sd*", SUBSYSTEM=="block", ENV{ID_BUS}=="usb", ENV{ID_FS_USAGE}=="filesystem", TAG+="systemd", ENV{SYSTEMD_WANTS}+="swupdate-usb@%k.service"
> --
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> deleted file mode 100644
> index aa20ab6..0000000
> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -From 5d78de76eab1218494c714e9816152e4d821fa86 Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Wed, 29 Sep 2021 15:28:21 +0200
> -Subject: [PATCH 01/10] debian/config: Make image encryption optional
> -
> -This can be use to ease the setup with SWUpdate.
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/configs/defconfig | 1 -
> - debian/rules             | 3 +++
> - 2 files changed, 3 insertions(+), 1 deletion(-)
> -
> -diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index 02681e5..b34168e 100644
> ---- a/debian/configs/defconfig
> -+++ b/debian/configs/defconfig
> -@@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=y
> - CONFIG_DOWNLOAD=y
> - CONFIG_DOWNLOAD_SSL=y
> - CONFIG_SIGALG_CMS=y
> --CONFIG_ENCRYPTED_IMAGES=y
> - CONFIG_SURICATTA=y
> - CONFIG_SURICATTA_SSL=y
> - CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
> -diff --git a/debian/rules b/debian/rules
> -index 864add2..08b74a1 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -41,6 +41,9 @@ endif
> - ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
> - endif
> -+ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_ENCRYPTED_IMAGES=y >> configs/debian_defconfig
> -+endif
> - ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
> - endif
> --- 
> -2.34.1
> -
> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
> similarity index 83%
> rename from recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> rename to recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
> index 1d6a247..9ca5002 100644
> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
> @@ -1,7 +1,7 @@
> -From 19969a388e414db84e54a706e9227c301b0408a2 Mon Sep 17 00:00:00 2001
> +From d262afcf95e617eace2f4207d4690587841d8882 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 11:32:41 +0200
> -Subject: [PATCH 06/10] debian/rules: Add Embedded Lua handler option
> +Subject: [PATCH 2/6] debian/rules: Add Embedded Lua handler option
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> @@ -9,10 +9,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   1 file changed, 5 insertions(+)
>  
>  diff --git a/debian/rules b/debian/rules
> -index 19870e9..12eb0ba 100755
> +index ff8b6726..e1df4f06 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -68,7 +68,12 @@ ifneq (,$(LUA_VERSION))
> +@@ -51,7 +51,12 @@ ifneq (,$(LUA_VERSION))
>   	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>   	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>   	echo CONFIG_HANDLER_IN_LUA=y             >> configs/debian_defconfig
> @@ -26,5 +26,5 @@ index 19870e9..12eb0ba 100755
>   	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
>   	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> index 08ba9b9..c6f84ce 100644
> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
> @@ -1,7 +1,7 @@
> -From 17d962a9b43f5debaed85affc6dccb2c471bffe9 Mon Sep 17 00:00:00 2001
> +From 404d1f73f791babf3dd4546fa5f671f7717d6179 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:15:56 +0200
> -Subject: [PATCH 03/10] debian/rules: Add option to disable fs creation
> +Subject: [PATCH 3/6] debian/rules: Add option to disable fs creation
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> @@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   2 files changed, 9 insertions(+), 6 deletions(-)
>  
>  diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index b34168e..d011deb 100644
> +index ad28854c..d8e260b6 100644
>  --- a/debian/configs/defconfig
>  +++ b/debian/configs/defconfig
>  @@ -9,12 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
> @@ -27,12 +27,12 @@ index b34168e..d011deb 100644
>   CONFIG_RAW=y
>   CONFIG_RDIFFHANDLER=y
>  diff --git a/debian/rules b/debian/rules
> -index 6705140..983e122 100755
> +index e1df4f06..2ed88ad2 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -45,6 +45,15 @@ endif
> - ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_ENCRYPTED_IMAGES=y >> configs/debian_defconfig
> +@@ -44,6 +44,15 @@ endif
> + ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
>   endif
>  +ifeq (,$(filter pkg.swupdate.nocreatefs,$(DEB_BUILD_PROFILES)))
>  +	echo CONFIG_DISKPART=y            >> configs/debian_defconfig
> @@ -47,5 +47,5 @@ index 6705140..983e122 100755
>   	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>   endif
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> index eaa6fcf..c670ee9 100644
> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
> @@ -1,7 +1,7 @@
> -From a02a6d4385f314601ef5c7094ecb26f5b5c3f134 Mon Sep 17 00:00:00 2001
> +From 9e5313a9fe784e55bcf25dc0b61573aeedcc11ee Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Mon, 4 Oct 2021 17:27:11 +0200
> -Subject: [PATCH 04/10] debian/rules: Add option to disable webserver
> +Subject: [PATCH 4/6] debian/rules: Add option to disable webserver
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
> @@ -10,10 +10,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   2 files changed, 4 insertions(+), 2 deletions(-)
>  
>  diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index d011deb..337fcce 100644
> +index d8e260b6..c365f9ce 100644
>  --- a/debian/configs/defconfig
>  +++ b/debian/configs/defconfig
> -@@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=y
> +@@ -6,8 +6,6 @@ CONFIG_ENCRYPTED_IMAGES=y
>   CONFIG_SURICATTA=y
>   CONFIG_SURICATTA_SSL=y
>   CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
> @@ -23,12 +23,12 @@ index d011deb..337fcce 100644
>   CONFIG_UNIQUEUUID=y
>   CONFIG_RAW=y
>  diff --git a/debian/rules b/debian/rules
> -index 983e122..6078ed8 100755
> +index 2ed88ad2..58742a6b 100755
>  --- a/debian/rules
>  +++ b/debian/rules
> -@@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
> - else
> - 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
> +@@ -41,6 +41,10 @@ endif
> + ifeq (,$(filter pkg.swupdate.nohwcompat,$(DEB_BUILD_PROFILES)))
> + 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
>   endif
>  +ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
>  +	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
> @@ -38,5 +38,5 @@ index 983e122..6078ed8 100755
>   	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
>   endif
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch b/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
> similarity index 89%
> rename from recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
> rename to recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
> index fd263ee..793bd7a 100644
> --- a/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
> +++ b/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
> @@ -1,9 +1,10 @@
> -From 09a736a651ae05378d9ef8018589c9f834b729a6 Mon Sep 17 00:00:00 2001
> +From 962f4b81ac1202e536628bfac822a22b8d7b0b3a Mon Sep 17 00:00:00 2001
>  From: Jan Kiszka <jan.kiszka@siemens.com>
>  Date: Tue, 12 Apr 2022 08:01:21 +0200
> -Subject: [PATCH 09/10] debian: Add patch to fix bootloader_env_get for EBG
> +Subject: [PATCH 5/6] debian: Add patch to fix bootloader_env_get for EBG
>  
>  Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
>   ...ix-do_env_get-for-anything-but-globa.patch | 38 +++++++++++++++++++
>   debian/patches/series                         |  1 +
> @@ -12,7 +13,7 @@ Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>  
>  diff --git a/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>  new file mode 100644
> -index 0000000..f99f7ee
> +index 00000000..f99f7ee6
>  --- /dev/null
>  +++ b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>  @@ -0,0 +1,38 @@
> @@ -55,12 +56,12 @@ index 0000000..f99f7ee
>  +2.34.1
>  +
>  diff --git a/debian/patches/series b/debian/patches/series
> -index 8c5564a..98628a7 100644
> +index 8c5564ae..98628a77 100644
>  --- a/debian/patches/series
>  +++ b/debian/patches/series
>  @@ -1 +1,2 @@
>   use-gcc-compiler.diff
>  +0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> deleted file mode 100644
> index eb19e5f..0000000
> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -From 8315d5ff8168fca1bd3752764e71f98e8b55f2ad Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Tue, 5 Oct 2021 10:56:25 +0200
> -Subject: [PATCH 05/10] debian: Make CONFIG_HW_COMPATIBILTY optional
> -
> -Add option for qemu.
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/configs/defconfig | 1 -
> - debian/rules             | 3 +++
> - 2 files changed, 3 insertions(+), 1 deletion(-)
> -
> -diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index 337fcce..6fc1137 100644
> ---- a/debian/configs/defconfig
> -+++ b/debian/configs/defconfig
> -@@ -1,5 +1,4 @@
> - CONFIG_SYSTEMD=y
> --CONFIG_HW_COMPATIBILITY=y
> - CONFIG_DOWNLOAD=y
> - CONFIG_DOWNLOAD_SSL=y
> - CONFIG_SIGALG_CMS=y
> -diff --git a/debian/rules b/debian/rules
> -index 6078ed8..19870e9 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
> - else
> - 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
> - endif
> -+ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
> -+endif
> - ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
> - 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
> --- 
> -2.34.1
> -
> diff --git a/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
> similarity index 58%
> rename from recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
> rename to recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
> index 1d476e9..f3b9bfc 100644
> --- a/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
> +++ b/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
> @@ -1,25 +1,24 @@
> -From c9661853aea11f090b5936363b0bae10fe6ebed6 Mon Sep 17 00:00:00 2001
> +From 33ce7123621f5da43cc8be730e916451abe84239 Mon Sep 17 00:00:00 2001
>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  Date: Wed, 29 Sep 2021 16:17:03 +0200
> -Subject: [PATCH 10/10] debian: prepare build for isar debian buster
> +Subject: [PATCH 6/6] debian: prepare build for isar debian buster
>  
>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  ---
>   debian/compat  |  1 +
>   debian/control | 10 +++++-----
> - debian/rules   |  4 +++-
> - 3 files changed, 9 insertions(+), 6 deletions(-)
> + 2 files changed, 6 insertions(+), 5 deletions(-)
>   create mode 100644 debian/compat
>  
>  diff --git a/debian/compat b/debian/compat
>  new file mode 100644
> -index 0000000..f599e28
> +index 00000000..f599e28b
>  --- /dev/null
>  +++ b/debian/compat
>  @@ -0,0 +1 @@
>  +10
>  diff --git a/debian/control b/debian/control
> -index 192c4a2..9318fa1 100644
> +index 192c4a2a..9318fa12 100644
>  --- a/debian/control
>  +++ b/debian/control
>  @@ -4,7 +4,7 @@ Priority: optional
> @@ -46,27 +45,6 @@ index 192c4a2..9318fa1 100644
>                  libubootenv-dev <pkg.swupdate.uboot>,
>                  libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
>                  libcmocka-dev,
> -diff --git a/debian/rules b/debian/rules
> -index 4dc9e17..370ca3d 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -19,13 +19,15 @@ endif
> - 
> - override_dh_auto_configure:
> - 	cp debian/configs/defconfig  configs/debian_defconfig
> --ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
> -+ifneq (,$(filter pkg.swupdate.mtd,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_MTD=y                  >> configs/debian_defconfig
> -+ifneq (,$(filter pkg.swupdate.ubi,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_SWUFORWARDER_HANDLER=y >> configs/debian_defconfig
> - 	echo CONFIG_CFI=y                  >> configs/debian_defconfig
> - 	echo CONFIG_CFIHAMMING1=y          >> configs/debian_defconfig
> - 	echo CONFIG_UBIVOL=y               >> configs/debian_defconfig
> - 	echo CONFIG_SSBLSWITCH=y           >> configs/debian_defconfig
> -+endif
> - else
> - 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
> - endif
>  -- 
> -2.34.1
> +2.35.1
>  
> diff --git a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> deleted file mode 100644
> index a5207ee..0000000
> --- a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -From 2776a4817eb91be3df001e04d548a702e9f5291a Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Mon, 14 Feb 2022 12:27:43 +0100
> -Subject: [PATCH 08/10] Add Profile option to disable CONFIG_HASH_VERIFY
> -
> -This change also enables CONFIG_HASH_VERIFY by default.
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/rules | 3 +++
> - 1 file changed, 3 insertions(+)
> -
> -diff --git a/debian/rules b/debian/rules
> -index 76fce01..4dc9e17 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -42,6 +42,9 @@ endif
> - ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
> - endif
> -+ifeq (,$(filter pkg.swupdate.nohashverify,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_HASH_VERIFY=y                   >> configs/debian_defconfig
> -+endif
> - ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
> - 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
> --- 
> -2.34.1
> -
> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index 7edefe7..086911b 100644
> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -13,23 +13,20 @@ inherit dpkg-gbp
>  include swupdate.inc
>  
>  SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
> -SRCREV ="debian/2021.11-1"
> +SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
>  
>  # add options to DEB_BUILD_PROFILES
> -SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
> -            file://0002-debian-rules-Add-CONFIG_MTD.patch \
> +SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
> +            file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch \
>              file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
> -            file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
> -            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
> -            file://0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
> -            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch \
> -            file://0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
> +            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>  
>  # end patching for dm-verity based images
>  
> -# deactivate signing and encryption for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
> +# deactivate signing and hardware compability for simple a/b rootfs update
> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
>  # add cross build and deactivate testing for arm based builds
>  DEB_BUILD_PROFILES += "cross nocheck"
> @@ -40,11 +37,12 @@ DEB_BUILD_PROFILES += "cross nocheck"
>  # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>  
>  # modify for debian buster build
> -SRC_URI_append_buster = " file://0010-debian-prepare-build-for-isar-debian-buster.patch"
> +SRC_URI_append_buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
>  
>  # disable create filesystem due to missing symbols in debian buster
>  # disable webserver due to missing symbols in debian buster
>  DEB_BUILD_PROFILES_append_buster = " \
> +                                   pkg.swupdate.bpo \
>                                     pkg.swupdate.nocreatefs \
>                                     pkg.swupdate.nowebserver "
>  # In debian buster the git-compression defaults to gz and does not detect other

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

