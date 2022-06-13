Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6422BC43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 11:03:16 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web11.4486.1655118172797132505
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 04:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RE+PSrXk;
 spf=pass (domain: siemens.com, ip: 40.107.20.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOzECFdBaI0MVOLQDeRXWMRGZEzuRRdB3S1IRd8PbeEYvpt67/aKs1hIkCmoNNGGMMhySxEWhkI6PjVh/Rjh4YNgRZjC6RL+5zs/1VU9Xp4luVqAeTKzwwMJv3IHURMn+/iWCufuTTg8g7zdVjOmEM0tb68j27PxyeJ/NA/PXTuyUCTvwhmwDpc7hZthpXabeWWEVf9QFL0Y70wyqMYE1EcVt6xqmer+OZ8oYlDKHTuOYF83gj9dVUPT8dTFxilUkkow6QhmFRvnLs/wNCj98QYHSqVqzsH86XiPtzSJ6LU0Fq4VYCYtl+gxKaVxT56kC2eNTpQEmAz/Zn1CT0Hwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63MdWbDpb2cfvzlx8Ts7uVcVJqeSgT28OeKT2+A7FAk=;
 b=jGkpvCPgylZ9+6Ihtx3gR2JkkOsGBggir7h7TfNA+fswvfsPiQHIz4n5QEq+AeR2oBI7nYqHDcMidg/M6O8KQ/Ib7qiPyipKQeCb68+26NE7C7eCKgP6xcbr8fWjHD8plIbzF+gwtcsMuaElCun5ZDwV/cLHdpHlQHGQj/ZegEYhK1Vkh2Uwd3n5LYshqwuj9nsDZmRTgHQn1whHzjdHy7s5q3IrZWduGOZ8HHUhLolvIJrr0ACRvlItch9x8+AdSe0tISwHQif0pCB3y+vqmfBRhBsx/4KY0h6/jPTjtEML8YvYPDrRE9l0nOvnIiaq2hDblY16/UzCgYol5CRy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63MdWbDpb2cfvzlx8Ts7uVcVJqeSgT28OeKT2+A7FAk=;
 b=RE+PSrXkxCf+tA2Fk1xjKKGO7uKR4EjrsKzWRZeiMT7Y/xPm3VDd5KuyYahGX0e74q1KHfFBLeL+d29BY0MCIKbnmjC6KGDq4jt5hQi/UfrUdYJeLZCPDuJpY3CzA0Yy77k1QEZKHEDdm+qDpjtaAp5NoJ7aKHXIF8AplPDc+UJhZER+Ad3R/5AOXtIrvWDFD1MQSwrZQJcCnzl1R7A7wLpwnrAa6cAqJV40A+KL9Xtyj9TxX+HRFnQOkx1SJJLwbKP7TkBbbGhW4di80mVkuAdAssbnF4pepQHRtdpf0+J9cmI9NCGVw6Fqm3Lfs0MvJtBkWEoQwzLq2PBSPTyUXQ==
Received: from AM6P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::42)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 11:02:50 +0000
Received: from VE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::fe) by AM6P191CA0029.outlook.office365.com
 (2603:10a6:209:8b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 11:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT103.mail.protection.outlook.com (10.152.3.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 11:02:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 13 Jun 2022 13:02:49 +0200
Received: from [167.87.5.173] (167.87.5.173) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 13 Jun
 2022 13:02:48 +0200
Message-ID: <8e61b3d7-78d4-a0f6-9f61-81ad6cb2d088@siemens.com>
Date: Mon, 13 Jun 2022 13:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC v3 0/5] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <adriaan.schmidt@siemens.com>
References: <20220607100806.133889-1-Quirin.Gylstorff@siemens.com>
 <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220610113302.1225351-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.5.173]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.297200-8.000000
X-TMASE-MatchedRID: 0lZ3oI+t/5po0FBZlmedTrZv+ayzmKtKPg9yfk4YC0a5kFk6DtF9f23L
	B2YI359FB+A0yBBPPYwMyjRdBmXLaAlfxg5ncm7ilYUFo9LzIpmMPz8Goa6fXUaMPBFKXyAUYFs
	T/TpvJqYH8UzOewTxw4A+sls4Cb83sA502JwhhUHfIqy7qrBQpy+pYxwv+BZOZf3zf+xpuLi7xm
	CZDXrutalOQjQcrzOloSnPJtmDAFLJIuRHt43jisKHlSQGL2ITmv0Xhs8HK83HrhS+VKSDcfioI
	si7Sa0gR/DWCqF4RMtGIzSvkOhmQMFNIBateifd1KgPgvd6AVq79isbN6HBSq0gCFoXW3rvuc86
	7ad8vaOmOWRsO8Mnh9plr2OSXbI12hTOUzxi3QgaqbdRy6ixDZl6CJ4B4pivT7O/YHJhINCRgLe
	uORRdEpQBR+Vr4iFospdaYS9obcSXLJHjo+8i085462iIVZCxrWL/xQJnm46eAiCmPx4NwLTrda
	H1ZWqC1B0Hk1Q1KyLUZxEAlFPo8/cUt5lc1lLgOMB0shqXhHqr87TkOG6x8uJYGAPt2yTE7Zda2
	YirSZtnR7RoQaTPJtAVj/vYocOb
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.297200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6F49A48D8432D9B8D80888A1F56B6656AB982BA7C005D3A0773A729206551C452000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: decb8d6e-9568-46f5-52ac-08da4d2c415a
X-MS-TrafficTypeDiagnostic: DU0PR10MB6318:EE_
X-Microsoft-Antispam-PRVS: 
	<DU0PR10MB631841A8CD6A7AF670675D4A95AB9@DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6tEkbXjfOcp9EQj/fw4NN9F6tgdbB4QiUVapwwqaps5V/7+Cj9EORCLHD9hQ1FJivNpEBT3Lcjq++DZGIH53IIDR67sAN54KJ17tgF1ZbdJM1AhfLiSeGUG7z6HqChX+Mx4I+izVF/f4AODagXCB71u/QIpK8kJdDtVOZBSHTOwreMU1+PELHl9L4c+bYaiXiDQbe9qEOFOj4OQ8jvlblfPAboGwKzvyJIO2IKtCAqTiHV0YcagsHjYN7Yv3p8MqtpYxydxslPjxI6u+3l9/VQEABsrdxi0wXW1smvEn/SibaIUf99ewgamBFAbJSti8/epPchpDSa4bpjOOiQgwRziwkg97WX5IGUCgQX5wNG5eaCnF5h7vQD7im2F9w5/eKxUJ9kSVubaiv2qOlSYREkbKUamJ8X/4+7W0rigKYnPVMJxeilvXUuyQ1vogTaB6QmMh2Ek/iH4r88fRUsBJ1nfQK5kSiMNLn9PVbWdNQi3bdPIzvL666z8VcMeYEibGDfYZBc9W5Tx8xX6q+Z7au0JjIxYNLw621D8bQGJTFJ7ODnmY4lwL/cFjLcFGy7rqhJVSjdIVbd0XX0VhEitHsD8dCELgHPBNdtN5ZDAm3LmIMUXSgBeTnCAej/VQ02EwxFoPbGGUq4Jk9QR6x2ONhyUYGUZrHZKTlV7nY4oYM4SSKFDhSA9CVL4aymiCPT0mirESvAsBlmdhYDm7kbkOoDLnLcX4ls3R9aTr99kZcN3IyHhj0dJHRxM3ie1+nzcjJUd0QENzdNS9b8BYt1/6oO8fC5kk3hw8pXOXO2dNPvVkkRwrlOrlE8J5nUTZR5WdfVfrox+w2x3uPOTwVnkpIdixC0vzy4Va75G3EMECpKjKHq3gYCHJGlqiQW6pqr0LY14UTBJAhhp092GSABiSRg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(508600001)(8936002)(16576012)(8676002)(70586007)(966005)(2906002)(40460700003)(2616005)(956004)(82960400001)(16526019)(26005)(31696002)(336012)(53546011)(86362001)(186003)(31686004)(81166007)(82310400005)(36860700001)(356005)(6706004)(110136005)(70206006)(6636002)(316002)(36756003)(83380400001)(47076005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 11:02:49.6165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 decb8d6e-9568-46f5-52ac-08da4d2c415a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 11:03:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8551

On 10.06.22 13:32, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
> ISAR commit [1]. See also ISAR API changelog[2].
> 
> This new feature remove the *.img from all wic images.
> 
> Also as new naming convention image recipes no longer end with `-img`.
> 
> The image types wic-swu-img and secure-wic-swu-img were removed.
> Rename `squashfs-img` to squashfs according new naming scheme.
> 
> To use squashfs include:
> 
>     IMAGE_CLASSES += "squashfs"
>     IMAGE_TYPEDEP_wic += "squashfs"
> 
> 
> To create a verity based image to following line need to be added
> to the local.conf or similar configuration:
> 
>     IMAGE_CLASSES += "verity"
> 
> The modifications for a read-only root file system are now part
> of a bbclass which can be include directly into the image
> recipe.
> 
> The modifications to generate a SWUpdate update package are
> also no longer part of the image build process and in a seperate
> bbclass. This class needs to be included in the image recipe.
> 
> Please check/test the interface changes for swupdate and read-only root
> file system.
> 
> I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.
> 
> Quirin
> 
> [1]: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
> [2]: https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#changes-to-image-types
> 
> Changes in v2:
>  - update ISAR to commit 1000df8e98b9a5849a7897698039687fd0cdd7d3 to avoid
>    double gz compression for tar images. This also allows to drop the patch
>    "0001-Fix-permissions-when-splitting-rootfs-folders-across.patch"
>  - fix image option `kas/opt/wic-targz-img.yml` for ci build 
>  - fix whitespace errors
>  - used compressed rootfs in sw-description
> 
> Changes in v3:
>  - adapt build of u-boot-qemu-arm64
>  - fix qemu-arm64 swupdate build, adapt wic/qemu-arm64-efibootguard.wks.in to new image names
> 
> Quirin Gylstorff (5):
>   ISAR update
>   u-boot-qemu-arm64: Adapt to 'Do not use shell environment'
>   start-qemu.sh: adapt to new image names
>   Adapt swupdate and verity to use new IMAGE_CMD_*
>   scripts/deploy-cip-core: Adapt to new image names
> 
>  ...u-img.bbclass => read-only-rootfs.bbclass} | 11 +---
>  classes/secure-wic-swu-img.bbclass            | 15 ------
>  ...{squashfs-img.bbclass => squashfs.bbclass} | 15 ++----
>  ...{swupdate-img.bbclass => swupdate.bbclass} |  8 +--
>  .../{verity-img.bbclass => verity.bbclass}    | 50 +++++++++----------
>  classes/wic-targz-img.bbclass                 | 15 ------
>  conf/machine/bbb.conf                         |  2 +-
>  conf/machine/hihope-rzg2m.conf                |  2 +-
>  conf/machine/iwg20m.conf                      |  2 +-
>  conf/machine/qemu-amd64.conf                  |  2 +-
>  conf/machine/qemu-arm.conf                    |  2 +-
>  conf/machine/qemu-arm64.conf                  |  2 +-
>  conf/machine/simatic-ipc227e.conf             |  2 +-
>  kas-cip.yml                                   |  6 +--
>  kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
>  kas/opt/efibootguard.yml                      |  2 +-
>  kas/opt/swupdate.yml                          |  4 +-
>  kas/opt/targz-img.yml                         |  2 +-
>  kas/opt/wic-targz-img.yml                     |  2 +-
>  ...when-splitting-rootfs-folders-across.patch | 35 -------------
>  .../u-boot/files/{rules => rules.tmpl}        |  2 +-
>  .../u-boot/u-boot-qemu-arm64_2022.04.bb       |  6 +--
>  recipes-core/images/swupdate.inc              |  7 ++-
>  .../initramfs-verity-hook_0.1.bb              |  2 +-
>  scripts/deploy-cip-core.sh                    |  8 +--
>  start-qemu.sh                                 |  8 +--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
>  wic/qemu-arm64-efibootguard.wks.in            |  4 +-
>  wic/x86-efibootguard.wks.in                   |  4 +-
>  30 files changed, 75 insertions(+), 156 deletions(-)
>  rename classes/{wic-swu-img.bbclass => read-only-rootfs.bbclass} (75%)
>  delete mode 100644 classes/secure-wic-swu-img.bbclass
>  rename classes/{squashfs-img.bbclass => squashfs.bbclass} (66%)
>  rename classes/{swupdate-img.bbclass => swupdate.bbclass} (92%)
>  rename classes/{verity-img.bbclass => verity.bbclass} (78%)
>  delete mode 100644 classes/wic-targz-img.bbclass
>  delete mode 100644 patches/isar/0001-Fix-permissions-when-splitting-rootfs-folders-across.patch
>  rename recipes-bsp/u-boot/files/{rules => rules.tmpl} (96%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

