Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58EEC43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 07:32:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web08.9468.1654587160061185347
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 00:32:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wCjA3WOl;
 spf=pass (domain: siemens.com, ip: 40.107.21.55,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhCiI4XgqYxRPQL9FbfoyASHccFxMbP1mKASn7K+kAXqClXTEZYcucHYmMYBcFf4YEWUd2S/LqJmievjNLgXyg9B8gysGvO0i3OeJQeO/Sw/rKd/SUAWI1++o8g8sMZ9OncWBwOMisJney+jSqgoFijXwXg7KxEIghego6Cq4nLF9NN9atbFqJvIxrjI7a7se39+31SBncL3buebWI4s/o92LmCwNkDmLOBo+7P/lH+nMiHSD6Tgsunnz5x+x2Lhi9RDpLABU+ANIe2UH4WhbiUyAbwsUPXcmVleii61j6Gl+46RAgE3zuZ52Yqjhu9QuXR8VxSK5VrOhLyb5NyZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8SmslWOhXvOzn4tP/1J1N4VG7vdEZNtOlTQDSjZmPY=;
 b=l7wyytBLrzzj+H+C1S0+KYyE/oAAvF0rui2hmvcTxtgSiErOiI/gWz49mK1MMQasnvOBdk6Gp9vpff5idzobt7ZYi2vSUObHZxUa5oiujRr571FYspeAI1e6kqmmOiA5uZRnnoizkLuZCOJtAbwfojjJD2B8j9hgyRT4tliuE6pPGm90L/8UTv/hGbxj9+iKTtA5GKzukYRWjNA6jpRwXvF8ljuUhYV7s3JGl/SRr5o+6WWy47MI8Lka4A7dzEdGXOp6XUboOppzok+Er94LqWDZ+vVyQoCZKcbkN47OsTAJmqP/AHRbW25T+nFnbmmoOppJmbwIR/YJOMhg3Nn4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8SmslWOhXvOzn4tP/1J1N4VG7vdEZNtOlTQDSjZmPY=;
 b=wCjA3WOl2NQAAAbQOGUdCWEdH6Tb5oEREz27avB5FMP6YYNMRmd6I4w1Gm4ko9o61RirMLnNSsBqf0z3ScSgflGVEpoEu3xADuKvANMZmvictO5z/FJnbLCi+eCGGTRkGW+4yrqswiSbEtXvca+a2kV2n1cJrVGWo9VHU+OguINDFYcRhjp4M/iTZHElHHtY/UZotH6ScqGQdZ4DiEteSXPYKAWp4KfEvFkjwrG3HS74FyvoY0OV99+mj5t81j+G97ORCoV3mb7pRRSJ7nqeAok30SKUFQkKymUiBpIQOCeIigyUG4SC4b2QbyhFoOnRHXVXyU8sHHl0gjqamslKrQ==
Received: from AS8PR04CA0043.eurprd04.prod.outlook.com (2603:10a6:20b:312::18)
 by AM0PR10MB2002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 07:32:36 +0000
Received: from VE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::84) by AS8PR04CA0043.outlook.office365.com
 (2603:10a6:20b:312::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 07:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT039.mail.protection.outlook.com (10.152.3.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 07:32:35 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 09:32:35 +0200
Received: from [167.87.36.249] (167.87.36.249) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 09:32:35 +0200
Message-ID: <d8f7538e-e02e-3801-261c-ba8708128d52@siemens.com>
Date: Tue, 7 Jun 2022 09:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] Adapt swupdate and verity to
 use new IMAGE_CMD_*
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <adriaan.schmidt@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <20220603115618.985568-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220603115618.985568-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.36.249]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.695700-8.000000
X-TMASE-MatchedRID: k0MhqeQqGxxo0FBZlmedTrZv+ayzmKtKPg9yfk4YC0Zeu6aRt5rYyff6
	ZSoNZQrIgZeTpSXZZ9dTp6Yz4AquMlFCTa6xepFP4rHWEFH9w7kNtEr0ZCzBXrNE9DxPih7lzQo
	gSLZEin9M+b8yxBqvAzt9QCEcdHOd6EHJvmrwzqntgH3mf5ydyxouJnd72+PtcI7vRACwF0IYgy
	Dj5TiRtYZOiKw+neP1wLdZ11vLmrUrcIfjsadOSAK2t8hsc3EOsEBAuoaUqK+tIAhaF1t67+KEn
	dfG3ZsCkshAoFcG3yQu1yMLFpHhOrX80TaNz00YJQLqj664W4ZSBYLp/taMcTPF07YFM7bTQxit
	uV8iXjsDwV9jYWbSUwzC4kGpAim5kl3wXEsRfvUxUzoUIepvu6sDj+f0M+rfbXa/XdBvrToiznW
	41V9Ms3SZ876AQydEmtN8Lf4Wnd9S1OCag1CMjZdWiIK9uZEU+jikdSWVZvM4hD0Y/Y/a7yLLJG
	CSgZKkQlbYZQoXpOkTgt4grpaSCrFoZt945NhrLF8oHIGwHp59MP+K1g1fXpK9FvwQx1hFELbqr
	OgWzydySYZtwNAWHzupPxrzMY/VKNTWdZLYnbT6QVHiDxiIAcxoADDd6xNVikdH3EQaETU6En2b
	nefhoJ8euMsD0OFmujw9BXXmuOBA8gDohX3tvkbBuA79y78QtFnr648cC5huXgIqq6mQyvRU+9P
	TPHSYhz0lzsrxmqajxYyRBa/qJQPTK4qtAgwIAYt5KiTiutkLbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.695700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 0ACD0F00FF9F06169550208886114319675F9770D89A6A9AAB9D159B5B6632B92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ec93a4-15b8-40e9-cb13-08da4857e486
X-MS-TrafficTypeDiagnostic: AM0PR10MB2002:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2002700CB86E72F0E819A78095A59@AM0PR10MB2002.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7N9vBqeE6CpR+aN7hNYLkLl5K1PJ6WXQdPOXUEp003oO2RkYA1RI+1SKFj7Eam5Y0GV8SElNGnAsxGkVBhAEgZpjUsx359CKxmnhi0TM8G4xqNPvTgrl/PDNn3HaAdtEMGS0spO//FK9IgXHNPK53ys/b9h0ZAMeNsNNH4Aft94OWHk/fQYnu6ec1zW+6jWhmjUFv7lUrdtRms5PSCB7JXX/cFa8DMCGsWsjSmQDsfcs+I6PKQM9RFVQE1w+3RNSRhjtwy7Y/Fv5eSPqy/U+EzWoU5+tN7qz0zhB+06wro95OnwTt0cwv2fadDdcUb8ABTLMxpIrmo+BmdQDQOW3J4EvisbhRIToK+SUhitvktoGo87gG06kGO9NNwHqCE5G9iPHwTfY9ZXfe/pGSNaKZF0LZ0oVsTznrcNdBovj2ZX5552BUtt3hrNDc0DkHSEt2uQUzL3s7zAVZE58QiA4UpGxEYMhLdIPCMq3dI+CyrGdHekC73q7ipAO4QCb7khWO7RSbu8fzasqgQ+0XMJqINI5f9JOoYK6P5D+c+aAcrm6qqYcQjXWeDdJxhq2VQkMt3C+liVgpKMu1vjQ+VWkaXjvGruRSs89dfKnhvUFLLMc3brAL+L8M83xFNXArQynFL8McK6fDdrAm9MbWB2v8aQtbqOaot+3x1HCE/9h0aRp+vPjl3k6ER95Ixx09AXb4Os0zo/kbxBgh/tXFYH25PzfgQvnoPSYBahD8xUPoOEqIxI0awV8sSqXnqWb3RV351uTbY37h0eVyJMEJGYn5b8+fZaEW18gYqta5XL2Zod/kx7eck4GzbpiJyrwiO81
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(82310400005)(83380400001)(53546011)(70586007)(44832011)(508600001)(16526019)(86362001)(186003)(2616005)(956004)(40460700003)(8676002)(2906002)(31696002)(110136005)(6636002)(47076005)(36756003)(6706004)(336012)(31686004)(82960400001)(70206006)(8936002)(26005)(81166007)(356005)(16576012)(316002)(5660300002)(30864003)(403724002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 07:32:35.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 67ec93a4-15b8-40e9-cb13-08da4857e486
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2002
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 07:32:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8500

On 03.06.22 13:56, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The image types wic-swu-img and secure-wic-swu-img were removed.
> Rename `squashfs-img` to squashfs according new naming scheme.
> 
> To use squashfs include:
> 
>     IMAGE_CLASSES += "squashfs"
>     IMAGE_TYPEDEP_wic += "squashfs"

Now that squashfs is converted, that class should be pushed to Isar
soon. Will "just" need a test case there.

> 
> The modifications for a read-only root file system are now part
> of a bbclass which can be include directly into the image
> recipe.
> 
> The modifications to generate a SWUpdate update package are
> also no longer part of the image build process and in a seperate
> bbclass. This class needs to be included in the image recipe.
> 
> To create a verity based image to following line need to be added
> to the local.conf or similar configuration:
> 
>     IMAGE_CLASSES += "verity"

Maybe verity could go upstream as well, though it is more specific and
may not make too much sense without the full image integration. Still,
worth to think about it.

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...u-img.bbclass => read-only-rootfs.bbclass} | 11 +---
>  classes/secure-wic-swu-img.bbclass            | 15 ------
>  ...{squashfs-img.bbclass => squashfs.bbclass} | 15 ++----
>  ...{swupdate-img.bbclass => swupdate.bbclass} |  8 +--
>  .../{verity-img.bbclass => verity.bbclass}    | 51 +++++++++----------
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
>  kas/opt/swupdate.yml                          |  2 +
>  recipes-core/images/files/sw-description.tmpl |  1 -
>  recipes-core/images/swupdate.inc              |  6 ++-
>  .../initramfs-verity-hook_0.1.bb              |  2 +-
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
>  wic/x86-efibootguard.wks.in                   |  4 +-
>  13 files changed, 50 insertions(+), 76 deletions(-)
>  rename classes/{wic-swu-img.bbclass => read-only-rootfs.bbclass} (75%)
>  delete mode 100644 classes/secure-wic-swu-img.bbclass
>  rename classes/{squashfs-img.bbclass => squashfs.bbclass} (66%)
>  rename classes/{swupdate-img.bbclass => swupdate.bbclass} (92%)
>  rename classes/{verity-img.bbclass => verity.bbclass} (78%)
> 
> diff --git a/classes/wic-swu-img.bbclass b/classes/read-only-rootfs.bbclass
> similarity index 75%
> rename from classes/wic-swu-img.bbclass
> rename to classes/read-only-rootfs.bbclass
> index 41b2164..6f91f66 100644
> --- a/classes/wic-swu-img.bbclass
> +++ b/classes/read-only-rootfs.bbclass

There is still a "wic" relationship in this class, no?

> @@ -9,16 +9,10 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -SQUASHFS_EXCLUDE_DIRS += "home var"
> -
> -inherit squashfs-img
> -inherit wic-img
> -inherit swupdate-img
> -
>  INITRAMFS_RECIPE ?= "cip-core-initramfs"
>  INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>  
> -do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
> +do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  
>  IMAGE_INSTALL += "home-fs"
>  IMAGE_INSTALL += "tmp-fs"
> @@ -37,6 +31,3 @@ devtmpfs	/dev		devtmpfs	mode=0755,nosuid		0	0
>  EOF
>  }
>  
> -addtask do_wic_image after do_squashfs_image
> -
> -addtask do_swupdate_image after do_wic_image
> diff --git a/classes/secure-wic-swu-img.bbclass b/classes/secure-wic-swu-img.bbclass
> deleted file mode 100644
> index 5e8e48a..0000000
> --- a/classes/secure-wic-swu-img.bbclass
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021-2022
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit verity-img
> -inherit wic-swu-img
> -
> -addtask do_wic_image after do_verity_image
> diff --git a/classes/squashfs-img.bbclass b/classes/squashfs.bbclass
> similarity index 66%
> rename from classes/squashfs-img.bbclass
> rename to classes/squashfs.bbclass
> index c22d7d6..376ddfe 100644
> --- a/classes/squashfs-img.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -9,9 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -SQUASHFS_IMAGE_FILE = "${IMAGE_FULLNAME}.squashfs.img"
> -
> -IMAGER_INSTALL += "squashfs-tools"
> +IMAGER_INSTALL_squashfs += "squashfs-tools"
>  
>  SQUASHFS_EXCLUDE_DIRS ?= ""
>  SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
> @@ -29,14 +27,11 @@ python __anonymous() {
>      d.appendVar('SQUASHFS_CREATION_ARGS', args)
>  }
>  
> -do_squashfs_image[dirs] = "${DEPLOY_DIR_IMAGE}"
> -do_squashfs_image() {
> +IMAGE_CMD_squashfs[depends] = "${PN}:do_transform_template"
> +IMAGE_CMD_squashfs() {
>      rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
>  
> -    image_do_mounts
> -
> -    sudo chroot "${BUILDCHROOT_DIR}" /bin/mksquashfs  \
> -        "${SQUASHFS_CONTENT}" "${PP_DEPLOY}/${SQUASHFS_IMAGE_FILE}" \
> +    ${SUDO_CHROOT} /bin/mksquashfs \
> +        '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
>          ${SQUASHFS_CREATION_ARGS}
>  }
> -addtask do_squashfs_image before do_image after do_image_tools do_excl_directories
> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate.bbclass
> similarity index 92%
> rename from classes/swupdate-img.bbclass
> rename to classes/swupdate.bbclass
> index 1437c07..c3fc303 100644
> --- a/classes/swupdate-img.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -18,9 +18,9 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>  
>  IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
> -do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> -do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
> -do_swupdate_image() {
> +do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
> +do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
> +do_swupdate_binary() {
>      rm -f '${SWU_IMAGE_FILE}'
>      cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>  
> @@ -91,4 +91,4 @@ do_swupdate_image() {
>      cd -
>  }
>  
> -addtask swupdate_image before do_build after do_copy_boot_files do_install_imager_deps do_transform_template
> +addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
> diff --git a/classes/verity-img.bbclass b/classes/verity.bbclass
> similarity index 78%
> rename from classes/verity-img.bbclass
> rename to classes/verity.bbclass
> index b7d7f08..bbc57b0 100644
> --- a/classes/verity-img.bbclass
> +++ b/classes/verity.bbclass
> @@ -8,13 +8,16 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
> -

Unrelated whitespace change.

>  VERITY_IMAGE_TYPE ?= "squashfs"
>  
> -inherit ${VERITY_IMAGE_TYPE}-img
> +inherit ${VERITY_IMAGE_TYPE}
> +
> +IMAGE_TYPEDEP_verity = "${VERITY_IMAGE_TYPE}"
> +IMAGE_TYPEDEP_wic += "verity"
> +IMAGER_INSTALL_verity += "cryptsetup"
>  
> -VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.img"
> -VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img"
> +VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
> +VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
>  VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
>  VERITY_HASH_BLOCK_SIZE ?= "1024"
>  VERITY_DATA_BLOCK_SIZE ?= "1024"
> @@ -37,14 +40,28 @@ create_verity_env_file() {
>      done < $input
>  }
>  
> -verity_setup() {
> +python calculate_verity_data_blocks() {
> +    import os
> +
> +    image_file = os.path.join(
> +        d.getVar("DEPLOY_DIR_IMAGE"),
> +        d.getVar("VERITY_INPUT_IMAGE")
> +    )
> +    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
> +    size = os.stat(image_file).st_size
> +    assert size % data_block_size == 0, f"image is not well-sized!"
> +    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
> +    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
> +}
> +do_image_verity[cleandirs] = "${WORKDIR}/verity"
> +do_image_verity[prefuncs] = "calculate_verity_data_blocks"
> +IMAGE_CMD_verity() {
>      rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>      rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
>  
>      cp -a ${DEPLOY_DIR_IMAGE}/${VERITY_INPUT_IMAGE} ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>  
> -    image_do_mounts
> -    sudo chroot "${BUILDCHROOT_DIR}" /sbin/veritysetup format \
> +    ${SUDO_CHROOT} /sbin/veritysetup format \
>          --hash-block-size "${VERITY_HASH_BLOCK_SIZE}"  \
>          --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>          --data-blocks "${VERITY_DATA_BLOCKS}" \
> @@ -55,23 +72,5 @@ verity_setup() {
>  
>      echo "Hash offset:    	${VERITY_INPUT_IMAGE_SIZE}" \
>          >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
> +    create_verity_env_file
>  }
> -
> -do_verity_image[cleandirs] = "${WORKDIR}/verity"
> -python do_verity_image() {
> -    import os
> -
> -    image_file = os.path.join(
> -        d.getVar("DEPLOY_DIR_IMAGE"),
> -        d.getVar("VERITY_INPUT_IMAGE")
> -    )
> -    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
> -    size = os.stat(image_file).st_size
> -    assert size % data_block_size == 0, f"image is not well-sized!"
> -    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
> -    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
> -
> -    bb.build.exec_func('verity_setup', d)
> -    bb.build.exec_func('create_verity_env_file', d)
> -}
> -addtask verity_image before do_image after do_${VERITY_IMAGE_TYPE}_image
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 3f2a794..2822cef 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -23,7 +23,8 @@ local_conf_header:
>      IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>  
>    secure-boot-image: |
> -    IMAGE_FSTYPES = "secure-wic-swu-img"
> +    IMAGE_CLASSES += "verity"
> +    IMAGE_FSTYPES = "wic"
>      WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>      INITRAMFS_INSTALL_append = " initramfs-verity-hook"
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 72429c6..c2bd15c 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -23,5 +23,7 @@ local_conf_header:
>      CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>  
>    wic-swu: |
> +    IMAGE_CLASSES += "squashfs"
> +    IMAGE_TYPEDEP_wic += "squashfs"
>      IMAGE_FSTYPES = "wic"
>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index f5cafeb..1eb7758 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -16,7 +16,6 @@ software =
>              filename = "${ROOTFS_PARTITION_NAME}";
>              device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
>              type = "roundrobin";
> -            compressed = "zlib";

Why that? Looks at least unrelated.

>              filesystem = "ext4";
>              properties: {
>                          subtype = "image";
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 64887df..2ec767f 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -8,10 +8,12 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #

Please add a blank line here.

> +inherit swupdate
> +inherit read-only-rootfs
>  
> -FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
> +ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4"
>  
> -ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
> +FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>  
>  SRC_URI += "file://sw-description.tmpl"
>  TEMPLATE_FILES += "sw-description.tmpl"
> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> index f0d2d68..60ee8da 100644
> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
> @@ -28,7 +28,7 @@ VERITY_IMAGE_RECIPE ?= "cip-core-image"
>  
>  VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>  
> -do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_verity_image"
> +do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
>  do_install[cleandirs] += " \
>      ${D}/usr/share/initramfs-tools/hooks \
>      ${D}/usr/share/verity-env \
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index e097eac..0e298bc 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index b3bbed4..3b8dadd 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index f60ebcf..c71253d 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -3,8 +3,8 @@
>  
>  include ebg-sysparts.inc
>  
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

