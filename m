Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EB0C4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:29:55 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.75])
 by mx.groups.io with SMTP id smtpd.web11.23214.1669217390752011002
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:29:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=X3sO1I/k;
 spf=pass (domain: siemens.com, ip: 40.107.247.75, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcqhGM71c6xvPhFoxh9La2i2PQxfeMasV8U3ruqZJGwBbFTJ3OJmMNBNmSLPN0W1qs0LjMoc4bYW1xVXWno2ytaLdiBEQFAu0gIkNzBeIfwjDxtzHyV721TS1o/4XtC2TdCHGOhSCmTkfH9KiGzUtoe1TUZvTvSqTarhDEBmBL2k1FQeYqZJg+PNMS/TwgGhY9diTj1JsmNWtUSa72lOCpl8OQmI53ekQ4a2+odHdRzC1Sa4GhhLHG76Mucym14eFhCLzhgPtObCyQQ1bUkrxWa8Y5g4aUdMptYlDzpGUzDvQ9kDIo/XUt1vwt5m4qYz389D1NE6vigdD7+x10a09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OupTKXhYk9qDM1ix+oJWDCIw7U8jecNDIbZldGGWHDk=;
 b=mC46lCY59sg5ITXkVv9JpV8CkthtJ6gh3xda0bchAXVN9k0kNs9N4ZtKiATIT+f996Hbb2cLabfVjyA+KBNWA/5iolpFR8zlHtgdETIUc1Xb+mexZjI6O2zoBi0lXuvb5+jDl9negbEBARBVjedm+j7j45o+6oRTyaCx41KupHV80J9oZcpUnOtqwiENQFqaGHGSWYOVCCyCetZ+YVDXZT4V8f1KyIMKjDuyl3/Y9EY2GRJwKk7R9a5NwV78JJPWFmQ/tDNAK+3WTfUmaP876HuHfielbA1tl8DNIz6bC5fAlHuf/hs7DT+8Pm4OzF+CRwbAnLDioq5RM6+S/8C9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OupTKXhYk9qDM1ix+oJWDCIw7U8jecNDIbZldGGWHDk=;
 b=X3sO1I/kFIx7WBdwCOXhHM9eSVcJumBOxkK8bXUIKqAbtM+6DZHMCiUt06OCiL1NUY57dk/KeCmZ3wtph+Hv1p4RTJY2D6sKYSVn/74Rr2SH+9odJYcURiq2sCZSujXBpnulPbfj91aflxjDPnjK5Hgo0g+30N24tQIBQlwFPTgUi8EHmYxvp4VGSDEfoeBZ4MslFn6Cz+tvZahbQuMFwNE9Us0kWB/rRDacignuw1h+SQVu/1KPEoDJZqQleKafPGT5RsHe/E32cUOGSXq7S7MMCyGfAMhMpKGLPZz4ZyvNztcq/r/T2y8npc9pM6aLFyulh3p24lSSBPLt5cpEWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:29:47 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:29:47 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 3/7] Include optee into u-boot
Date: Wed, 23 Nov 2022 16:29:02 +0100
Message-ID: <20221123152906.75323-4-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: b1538344-276f-4634-f31c-08dacd678e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YzI4Gr9FpcvaW8fMIx4J4vfN2FFwEX2OEb4PkVoY+y5UwbUYsdbT5iqne9Iu49BZjHan+a4QO6/r3LZugQ8rbcItetxvKeIvex0HDWdRVnJdf8heGcOdyVYRI/RF4KGRMg8qRb+2SiNY6jTWbsuOaXSDnRPcf9tUTjXF9N5SeKbJ61fz5h/0n6v8wJIesf70a+85IshIPDnToexVBq1EP+dwJTdCZZnhuTVtNVrM8rl8ZwjV/uPxRbnFBdFBWQEzyiaXNylxfla4C6G/CZGW29qjfSfid1JmwuYgjBJRC3964w320BWAyRy2dHag6z1nXj24Hy66dO5p14hehYtlWvwU3um4HQy/EdFZ234OFccgZrKgy2UUJzYcF5fZDEFS1iYgRqHhLrt+XWzYaBxkCrHN4C6kh2U+KCeoyzmuhnHcEq3QghcO2EIxRU0aD/HauyMfQMkPtuzAxylV9g4wT6tgwUiO+eIV51hsuDTIG6dAURtCjhbTx5S+VUWjZibyZpB/wMHdRO7TmiV48PXARg+rqZ2uNRnhM/KszDV+QEI/nK7VJqd7ywbGSKn3lz2maKuL5SfIi1CQZd/m7f+2Z+ODg2l73j5YmPi647mVdWutuOWI3YPU+4c+I5vI1kefBJMNVhtWvYpkdQvcOG+AIw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(6666004)(41300700001)(107886003)(478600001)(6486002)(9686003)(4326008)(66476007)(316002)(8676002)(1076003)(8936002)(26005)(66556008)(66946007)(186003)(5660300002)(36756003)(6506007)(82960400001)(6916009)(55236004)(83380400001)(2616005)(86362001)(2906002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tOIJLYNrboMuUya9ImJiPo/Vpiu5eBnF/rr5VVJy/Hy68K9mXTAKS5WVbOpO?=
 =?us-ascii?Q?7A2e5j3b1tgAeVijzTa+ZJ0NK2JBEqRXdbSwQCIqDgivbkyyT61wZotvOkxD?=
 =?us-ascii?Q?Waz+uVhIgm+GGO/atIsj9JU5UF267LGlAoGsvRcHHz+HpbVRHY0ejhkaLxq2?=
 =?us-ascii?Q?CMuYz9WPCoTvtSxU00vvU4gDc2KuthQUu4aMLcRQdWVn4UegXY1Rcn/2lm12?=
 =?us-ascii?Q?r3JqGvCeBejM/yl3sIZ99e+xVQtL2d/bsMEb0PdF12dcxUSyKIi5JvsQpr6T?=
 =?us-ascii?Q?ZBzK7Sj7Z5dC/Dle+hQIlFJP3RnZTNhttfsobuW8FlsyNcMoGlNqgWuLirvy?=
 =?us-ascii?Q?ulLb2r7PIoXa7Ep3ZpH9pprZ9b77dasRSuZNagGb110m1X6vzbeGNbs/jxYN?=
 =?us-ascii?Q?8esRR6muTls82hqNyApON1Yb+cSzSntvRDr0OBXdDI1EpWTox0aEAAsm+Y1P?=
 =?us-ascii?Q?RhSOtcGnqNXWZIjuOf4Jxk5+aEaqycdU2aULc5Ov1RgPmR8pTrNtrVTAJTCD?=
 =?us-ascii?Q?66RIx87xxMSFuiCzDBydFG2Sekyq6dE0hLfzDp40exofR2qGK87s2vIpeKoP?=
 =?us-ascii?Q?z+XiX6AHjf0jdVROoydILQXLAdxBT4bB2CNGfLTPJuW4qqCpdR1MJmOCXH+z?=
 =?us-ascii?Q?lNo2TQcmI+RLsRr/3D+hiXt2MqZAnGz3M0fXauKTUOKgeGU3LFU4YWpeVZ6q?=
 =?us-ascii?Q?wBOKvlDaHg9Tj1Ujy+xjPa9m4QGNq4eg1HhxvZBHMg+3Zztde1/skdiS6kBn?=
 =?us-ascii?Q?gJwjxfwOksIEzQVnzKrkDaxP/dScf/6WaQ3IThhPSGkUIQEHpFfWWkD0zcfU?=
 =?us-ascii?Q?DmgOXmBk6NMSot52At7vceJtuyZ48/tRuavbpZb0JYv42f8rbOr5iDWuajlZ?=
 =?us-ascii?Q?8+zKvOqKxsLOU4doAQlFNG7J14TRJJIo2jC5Lt3YWbpVvMJh9DbuTecaYRNI?=
 =?us-ascii?Q?v/Yan5zGlwjxOnsM0c1PeDD8rykVkc3SW7DUcBXpej0lW6fQNcZzMNV23W+f?=
 =?us-ascii?Q?pGOtMzUQX//KKwE0S+GXrvtiAdkSHAIaSa6Ul3Kp69ttC1GlhU85/ZaNwbgN?=
 =?us-ascii?Q?URkPOvivKPCjeBmk6B4itXiSaa78+pWNg7WYCgi92DKA02Pr1vuWLCqi11IE?=
 =?us-ascii?Q?AU1fr9bxhIwJ1fKBSUltMCcaGz00u3z8raBOBPQhDYytv7P0eA8mNRGTAuvV?=
 =?us-ascii?Q?bTzgyMm62QX+apkMQ/1G+lPRStgvESQzGQH0APG7BIWIqS6qqFKEPyJTjEl1?=
 =?us-ascii?Q?uk/iNtspW2X1j8tbqENOulEOLBSFBeWyRMrxwzHWUuj5kxoraN03oydG35xt?=
 =?us-ascii?Q?8s5AyGlxgzuU8+8AO1g/N4atLVDKYuY6E5JblkQCgA0Qkw9ZaFfEVIfMnvi1?=
 =?us-ascii?Q?UktiwFwW+jiBlEm1hL3FK8aup1RuCE8zLkCdcLphpyl/um1nQixZYpYOAgAI?=
 =?us-ascii?Q?x5hHZbnmH68u6j1GGztF+BW1GAxbjn6HEQY5mZeoBgDMduAK5tS3hUkxsnrP?=
 =?us-ascii?Q?oBQGc665sRhvMByou4G9ccU4/flscKb3S0zGMX16mAfuiJhR1muYhPX15J20?=
 =?us-ascii?Q?H3GxR4I0o4u/Tlig/emq/hgJJAYfvw/xdVztfpp5XkCwdoJqUFfbFoEhYwNk?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1538344-276f-4634-f31c-08dacd678e32
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:29:47.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaAThFdNBk22OMJSrkUwFDcxoBfiJ3vm2e2e87saDmzqtvjkiKEYOsvn+0SABXLF1N7T7GhjfMeePnjPybc+xA2OKZVUaAw64+ELuca23ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:29:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10093

From: Sven Schultschik <sven.schultschik@siemens.com>

Optee is part of u-boot In the secureboot scenario to use optee and RPMB as=
 secure storage.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 9 ++++++++-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 956dcbf..2b75988 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -2,5 +2,12 @@
 CONFIG_BOOTDELAY=3D-2
 CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
-CONFIG_EFI_VARIABLES_PRESEED=3Dy
+CONFIG_EFI_VARIABLES_PRESEED=3Dn
 CONFIG_EFI_SECURE_BOOT=3Dy
+### OPTEE config
+CONFIG_CMD_OPTEE_RPMB=3Dy
+CONFIG_MMC=3Dy
+CONFIG_SUPPORT_EMMC_RPMB=3Dy
+CONFIG_TEE=3Dy
+CONFIG_OPTEE=3Dy
+CONFIG_EFI_MM_COMM_TEE=3Dy
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 0a9a15a..802fc50 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -13,6 +13,8 @@ require recipes-bsp/u-boot/u-boot-common.inc
=20
 U_BOOT_BIN =3D "u-boot.bin"
=20
+DEPENDS_append_secureboot =3D " optee-os-${MACHINE}"
+
 do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}=
.deb" | \
--=20
2.30.2


