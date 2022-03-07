Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26382C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 12:41:20 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.56])
 by mx.groups.io with SMTP id smtpd.web12.25680.1646656879061780101
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Mar 2022 04:41:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OpoZ4liX;
 spf=pass (domain: siemens.com, ip: 40.107.0.56,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnk2s5SjJv6Xdc3JDmlKk8kF/AZeY1MPAwGCkuGLoR276+Hlg2Bhr2L4AT4UPi89heRaTHyUxGnjEYMH09+XPl0O49mGeuKJ6ztBR2RW341E21pQ3iIOu5amwff/Y+LIkScLvVOGtTp7emP7R/K8tWC95vb6B08LbR8LUTDjWU/ohuG2/P31YUlYeZRkcM8Ka4Cs3jfrj+qEjEsSC6gUDcVjP62pWcbkPjGve9aQIGDGZkcggC1zMmFfdntakBJkPZwnJj0u3/9wqckYgUP0WHKvLuHXqL7jSmd4ckMdTOz6d3r7MwDtRFWlBeUJej23/zuilyKNzm+k2ZRRHea7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ5FpXe7aXv+HEHGcDNiHtDDv5hsPjiLssEs2YB5gT8=;
 b=K4ZGyQGAR+TUf8nsPVsBQX+nRjkXE/B30O/aDrRPxWm/AQOHcieJWiVrfK9wcC1AKBpTnJIvD/3Tw6Tehpu8GaGqK/I+B/meCvbDb87nLZNK3Z/QYHLTFqQILxXWyVg+xcmX5vkbRhWIV00UZEUuPhSoEJVQfLDvQtl2unLczk0uNvWvffGhJQyXOXUsr7asMtrjWNL1Zs8z+oi9MLUdNCVu66ssAI82WwQku5l0WRk4ewmD2eI/XGTV21EV7lAXzHcDth70lPJUpszf945EAYNOwkrVt1HbwrQAnyJXEiDdKZJpw2ANHFKM+lqB653KH96FrH4kiS+ocOppbhl69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ5FpXe7aXv+HEHGcDNiHtDDv5hsPjiLssEs2YB5gT8=;
 b=OpoZ4liX5ZsU/itW93rxvLlrwvdSHueEGoVkzvK8CfdUNo1asgBUNYq8d1YlO2aWfd/6TJwKqfSGforili1N5ss/Zl5ZFozcV8ODmvky+zUuX8ry74JSAE4RpecoO08vNTjIFLfAixjax2hyEYJxQqTxrKLbkkySMjzmY7Yc5ZstEeKVWyX7NMwDbVQb0cK8QF0xEg/uFrbZS3IPKLfyCI/8Am2Kx8zV5zVzDGZKzJL6QTLPksV0jDBoqbkOnR0cpHL3jIhDsNlFHS/t0IWwi5RrlTaBFB8P1rT4HoE+/acY70+imdaoMUFfGsWd6/OCBer7Os8JeuC0KkLcTRVvpQ==
Received: from DBBPR09CA0015.eurprd09.prod.outlook.com (2603:10a6:10:c0::27)
 by VI1PR10MB2032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 12:41:15 +0000
Received: from DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::f2) by DBBPR09CA0015.outlook.office365.com
 (2603:10a6:10:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 12:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT048.mail.protection.outlook.com (10.152.5.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 12:41:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Mar 2022 13:41:14 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 13:41:13 +0100
Message-ID: <d30c95af-70ae-574b-bf3f-8384352078ee@siemens.com>
Date: Mon, 7 Mar 2022 13:41:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] classes: Use extracted partitions
 provided by wic
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220307115053.1972214-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220307115053.1972214-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.7]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a366e878-86e2-4fc4-9e5a-08da0037c493
X-MS-TrafficTypeDiagnostic: VI1PR10MB2032:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB2032A3ED8DFD697F8FBACDDA95089@VI1PR10MB2032.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vh7mxWWj3L0XJChXz/KG692Q6+t03AOvXgQlJ16lm1RgKHg/f/w/MlRfxdt8KOlfYbeO1ltLAdL8YUvc55LDC5dIrz+ytlrYEVlupxQDzfYfuv8CVs9X3lYt2Dl+SVyQwUuyWLIBAc6h/XntpJ6+P2HoAAY5yzul/sd7BlOf0UKZltAkYUAITFdEXeFa6RREUa1CddTd6silNLIBmJ1A/iAdl1TQVS/h8VuTN2XAH9+EGHEKzAQNd5iORaD+UWw7Id9hiPzrhyfeVD8BpNjuWWZF3W2vM8uuqSYX1mRzmaUZywfRfj3qErBcS+LBOgbdRo4y51gdOHKZTqkWvGkoN0s4+9XA/0YGb5Oowl7ssG7DFNw+cOSBkGALGijoINo3d/7Z8+RQshiC+vS9EFS+AfbbjZS33wNgUEYvdkK2BX9dqsZfXtPvm08LSXdrXhVzBF6VSc5aJAxokSUWgusCGjeP2UGfLX9gFaRqlyGxlUGrvaoDzXCsVNKqYWNdMAfMD5tLofXEFoT3BWqbO1Mlm/XtnNz8vgatgcpsUpJmex3FtSjtNqTbMw0VJcNXALuBwAyBQTVTIIuBzQOmONAQTgDrc65BF36n77UJx26QirEKFzfVwiYQ7Fbw1Qj7NyKM75n+YyOa9t0+Ne6xr+lfzWBiikhlx1pFLtwoN7qWJNWdPLs4ntTvYA0D6vkezaA8SMuZrvbvpkc5/yuCkaPXuQIO9fSdDj211rBSRA9QEKMIFKmKYQOnVIlW3IDtd8pmHd0ukNA1AJxvrWPZ5gEwHw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7636003)(7596003)(2906002)(82310400004)(36860700001)(356005)(2616005)(86362001)(316002)(16576012)(47076005)(956004)(70586007)(508600001)(70206006)(82960400001)(53546011)(8676002)(16526019)(336012)(26005)(8936002)(186003)(5660300002)(83380400001)(110136005)(36756003)(31696002)(31686004)(40460700003)(6706004)(44832011)(403724002)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 12:41:14.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a366e878-86e2-4fc4-9e5a-08da0037c493
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2032
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 12:41:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7665

On 07.03.22 12:50, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Newer versions of the wic provide separated disk partitions
> therefore, the extraction code is no longer necessary.
> 
> Rename the class from extract-partition to
> compress-swupdate-rootfs to clarify the use case.
> 

This also resolves the build breakage we see with bullseye-based
kas-iser:3.0 which no longer carried fdisk (which it did by chance so far).

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/compress_swupdate_rootfs.bbclass | 21 +++++++++++++++++++
>  classes/extract-partition.bbclass        | 26 ------------------------
>  classes/secure-swupdate-img.bbclass      |  6 +++---
>  classes/wic-swu-img.bbclass              |  6 +++---
>  recipes-core/images/secureboot.inc       |  4 ++--
>  recipes-core/images/swupdate.inc         |  4 ++--
>  6 files changed, 31 insertions(+), 36 deletions(-)
>  create mode 100644 classes/compress_swupdate_rootfs.bbclass
>  delete mode 100644 classes/extract-partition.bbclass
> 
> diff --git a/classes/compress_swupdate_rootfs.bbclass b/classes/compress_swupdate_rootfs.bbclass
> new file mode 100644
> index 0000000..2a01e59
> --- /dev/null
> +++ b/classes/compress_swupdate_rootfs.bbclass
> @@ -0,0 +1,21 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +EXTRACT_PARTITIONS ?= "${IMAGE_FULLNAME}.wic.img.p4"
> +
> +do_compress_swupdate_rootfs () {
> +    for PARTITION in ${EXTRACT_PARTITIONS}; do
> +        if [ -e ${DEPLOY_DIR_IMAGE}/${PARTITION} ]; then
> +            rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
> +            gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}

Out of curiosity: gz is not a particularly recent method anymore. Does
SWUpdate support more? Or not in our configuration?

> +        fi
> +    done
> +}
> diff --git a/classes/extract-partition.bbclass b/classes/extract-partition.bbclass
> deleted file mode 100644
> index e9de8fc..0000000
> --- a/classes/extract-partition.bbclass
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2020
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -SOURCE_IMAGE_FILE ?= "${WIC_IMAGE_FILE}"
> -EXTRACT_PARTITIONS ?= "img4"
> -
> -do_extract_partition () {
> -    for PARTITION in ${EXTRACT_PARTITIONS}; do
> -        rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
> -        PART_START=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $2 }'  )
> -        PART_END=$(fdisk -lu ${SOURCE_IMAGE_FILE} | grep ${PARTITION} | awk '{ print $3 }'  )
> -        PART_COUNT=$(expr ${PART_END} - ${PART_START} + 1 )
> -
> -        dd if=${SOURCE_IMAGE_FILE} of=${DEPLOY_DIR_IMAGE}/${PARTITION} bs=512 skip=${PART_START} count=${PART_COUNT}
> -
> -        gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}
> -    done
> -}
> diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-swupdate-img.bbclass
> index 431939b..1715c8a 100644
> --- a/classes/secure-swupdate-img.bbclass
> +++ b/classes/secure-swupdate-img.bbclass
> @@ -21,12 +21,12 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>  
>  inherit verity-img
>  inherit wic-img
> -inherit extract-partition
> +inherit compress_swupdate_rootfs
>  inherit swupdate-img
>  
>  SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
>  
>  addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
>  addtask do_wic_image after do_verity_image
> -addtask do_extract_partition after do_wic_image
> -addtask do_swupdate_image after do_extract_partition
> +addtask do_compress_swupdate_rootfs after do_wic_image
> +addtask do_swupdate_image after do_compress_swupdate_rootfs
> diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
> index c8532ba..3a09721 100644
> --- a/classes/wic-swu-img.bbclass
> +++ b/classes/wic-swu-img.bbclass
> @@ -11,10 +11,10 @@
>  
>  
>  inherit wic-img
> -inherit extract-partition
> +inherit compress_swupdate_rootfs
>  inherit swupdate-img
>  
>  SOURCE_IMAGE_FILE = "${WIC_IMAGE_FILE}"
>  
> -addtask do_extract_partition after do_wic_image
> -addtask do_swupdate_image after do_extract_partition
> +addtask do_compress_swupdate_rootfs after do_wic_image
> +addtask do_swupdate_image after do_compress_swupdate_rootfs
> diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secureboot.inc
> index f048497..b619b50 100644
> --- a/recipes-core/images/secureboot.inc
> +++ b/recipes-core/images/secureboot.inc
> @@ -11,8 +11,8 @@
>  
>  FILESEXTRAPATHS_prepend := "${THISDIR}/files/secure-boot:"
>  
> -EXTRACT_PARTITIONS = "img4"
> -ROOTFS_PARTITION_NAME="img4.gz"
> +EXTRACT_PARTITIONS = "${IMAGE_FULLNAME}.wic.img.p4"
> +ROOTFS_PARTITION_NAME="${IMAGE_FULLNAME}.wic.img.p4.gz"
>  
>  SRC_URI += "file://sw-description.tmpl"
>  TEMPLATE_FILES += "sw-description.tmpl"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 06ad5af..2e9094a 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -11,8 +11,8 @@
>  
>  FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>  
> -EXTRACT_PARTITIONS = "img4"
> -ROOTFS_PARTITION_NAME="img4.gz"
> +EXTRACT_PARTITIONS = "${IMAGE_FULLNAME}.wic.img.p4"
> +ROOTFS_PARTITION_NAME="${IMAGE_FULLNAME}.wic.img.p4.gz"
>  
>  SRC_URI += "file://sw-description.tmpl"
>  TEMPLATE_FILES += "sw-description.tmpl"
Thanks, applied to next.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

