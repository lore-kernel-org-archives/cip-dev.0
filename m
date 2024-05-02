Return-Path: <schilling.benjamin@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D7AC4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 13:14:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web10.4968.1714655677241213905
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 06:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dtQWX83O;
 spf=pass (domain: siemens.com, ip: 40.107.22.51, mailfrom: schilling.benjamin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhaVPCyY/0h0J7oBIyxsqNfYWm2zCJhaUpSU2XOMeoxixk7hnFollJzBR3FUeaGLUXiuEKZLDOc4u0wB8JH+bL1d6K6iR13h7qWcKS7gBAhRR8Xs3oeueQM0LaL3SvGtWjR6E+EtXfCIuSNtKmlQ9A+0FP7fqzHz6BxoS22sHayaW8fFFDqrgXxCBQ9wjUCSkEtcvASgHSXLimrOH9vx4vRSKeffX32dO5EaK+pKv5AxBMdOjt0uRw385e2v/GVoypX+o2NoI2lQ8ery9CyNGrQGTybLHPAf1EvOJwP/kDStev8gpE3/Hx8bpTr0++r+W05dan90/wpXbYcyOYcouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OqmHSl1TlEWbWZX/j8/wFQqisV0P11HJES/PvXwf7w=;
 b=KcGUS6tSeY2hmt7Kn92ux+dfLDebOf5b72RHkaw//rNvAxyE8ig/yxLWNbEwH5FxSSz2/siRSOYf0C67+GwDgOSeMINQSRh5FoPUyFF/cLdp88jkjGWFWfbs2ABFCDNy13GyNyCUIP7vQpRZcssVwELKEekccUQjClOfmWvfTvD5/7qshRTA1H7+eViyetQ3Hyat5rN3IVHIwtHB6UqqQmcZvYWxxhro9tvMAItwLbo+UGiuqCDwbygkTbYPyI1m+N/D36c0TaYnBcI0bjVo6ePqmlUooGUaeK5lCm2utfJPzi5eS0L5zwL5FRHmJXRS2cATbGKtnMG6AM01G9cXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OqmHSl1TlEWbWZX/j8/wFQqisV0P11HJES/PvXwf7w=;
 b=dtQWX83OkIrSXq9DEYtmOkqKdL0biserpEP9ZfVknfKqPB2bSj2oQkV1A2/mtuMgPZkRR0u3heaTzJ+70JGSPOEGH16cPVpZrsuYDjHcGz59Ieeep+dBBT1hCdsmb3KlQijRap+Qzae2cU/yitna3N3v3YyGFXSTwt62o8F52EX2OjV1CYuMPrOPpV8Es4fRpVlJ4Lh2UhgeImtpFjvqRHauCm4AgEPZH+rqpdC16TUyi0EMaxt4k4ru+ODrCzM3v30oPMVYuMNVSpAUm/RHrFS54C+MigTH0YwfLd/c2WtgQ4tzYBFSJd8leLuGVlIWoyxXr9H2c4tgthsR943Lhw==
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.26; Thu, 2 May
 2024 13:14:33 +0000
Received: from GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b]) by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e3f:ee20:5b20:8a7b%5]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 13:14:33 +0000
From: "Schilling, Benjamin" <schilling.benjamin@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core] [PATCH] Add MCOM x86 target
Thread-Topic: [isar-cip-core] [PATCH] Add MCOM x86 target
Thread-Index: AdqckpcQz3qSMzH8TIiOyax9RYdnUA==
Date: Thu, 2 May 2024 13:14:33 +0000
Message-ID: 
 <GVXPR10MB58375213D66CD4C30A60188888182@GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1d99b187-98d9-46d5-8325-af65e7891a27;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-05-02T13:09:35Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB5837:EE_|DU0PR10MB5560:EE_
x-ms-office365-filtering-correlation-id: 5af205f8-a9cf-44da-b145-08dc6aa9cf39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?yhAVAsR0NOCw+6c2zK5zz1A/RTUYmupv551YMhL7TGhRB9C+T0tYdBnkZ5HM?=
 =?us-ascii?Q?pr8j/fm6QXgdwGHPj2ylcm7KkJxqH7gDmGYF4EU+QALEIu+4aantbbwRCAPW?=
 =?us-ascii?Q?4bn1N2w+RaBJTPxZ+p/NYV5TaKvYKWYTrL2wUuaXoGAeMToqXuUCdrKVlnue?=
 =?us-ascii?Q?coefQL7WJ7nI37TZQ/wGrO5XJthV8eBXvKfB12bPCJs8PjzQRgp62l1rng1O?=
 =?us-ascii?Q?mHA0Oj6uTymaH4D6pKZCK7DRK5TCO0Vi7EHXQLYiNZst5uaIprPxdwjddYXG?=
 =?us-ascii?Q?DAoQ0uffTvSwPjhtophO7HPrY8zu701CkkkOd6F2fkRCnzO2ac3D9bqPt15w?=
 =?us-ascii?Q?RhtQ/lXV5MNu6195FOt68fQJd07zuL5pRme/Ta+5AWWpPS9zXNLsg384+MhZ?=
 =?us-ascii?Q?tu/dhpAt467aws+Y6mtuaRe993zEIyYaLDLq91atMY/CuNN9G5SnqeadSxrU?=
 =?us-ascii?Q?4PrObVMXWunFVDYL8TtWNgeYWloW0YL3JdLCufuQg5kJPsw0loaSANguK0iU?=
 =?us-ascii?Q?3X4BFE7EYJKuzGP028EfPj/pe6NCbNvnyk9+Eay7FUFd2D/TnWgNIXpMPAPq?=
 =?us-ascii?Q?OVMzbwfMkxKoJlVIAO++2+/1kA7fGpqmnrYZ+CznRATRjtYqUH8SUqW8xnDm?=
 =?us-ascii?Q?CIecPSGuLBCpKd4evKsRJrseceCrCOgRT5N2l8J1C9AazgRF4oFpI3PIiX/9?=
 =?us-ascii?Q?2ybGj7JdsnKNJTLycFZ4LUX5hmK4tu2400qqQN+SNGrgQ4NSycJi56T9cjgz?=
 =?us-ascii?Q?ZMH9UPGpvH5s0xyDRIISCDdopMgzS9p6crdOR1FXN+BowWFGd9DEAFRcXGRP?=
 =?us-ascii?Q?gQXljnBMvO7xtLc7otyxLLoFI5JIIeIV49sgbfWl46YAbwWluwvUov/+xZKh?=
 =?us-ascii?Q?FZ7IZAxieNvz496ORvJTsjwqYPUJB6JRjWM5VvztP77TU0/WdevwLZT73+qy?=
 =?us-ascii?Q?pqHWCorUGdnjSmvuvuVAuEBB9WSTIuOcHvXzz1Ta8Mwts3eVRVB8ljxpIv4x?=
 =?us-ascii?Q?IbEeO31IPSeBskOns2CZA9eVZPHVQwPR0uIPQtYc8kag5cp47Ms7CWvj02TJ?=
 =?us-ascii?Q?954E22o4ep7LtmHw0kMLQIsn7KU0sifWE4tE8u256O+3gq7b3sa1B7Km46F8?=
 =?us-ascii?Q?8MMou2omUBbgRLnEpVGjsdxgX310SOtDRxA5r0SsFwtJ8FVdDQvS1P/rGrKC?=
 =?us-ascii?Q?wr+dempcj61S5ieXmRf2uylCTgg85oUfbx5s68Yq7ubRWK8azk11EwU7s3ld?=
 =?us-ascii?Q?h+aEV959TgTxPsG/ZHgK7kJB1giSIxQ0LMEkaH5rzwHJZJ8L4YBBtELGIxEz?=
 =?us-ascii?Q?yCPT1PAOl7S+TTwRea0k5wJg8/gkEOqSFwwKndsI59CFKA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zE62b3j4vAZDDhUU8nszJV1MxBdeHMXWuZom00lb+0GQuQWx6B0iNW9340jK?=
 =?us-ascii?Q?Qa5xIXdmHnEwB9toiRnJaGf0wW72H5yL/GZk95upvQ4Qmrjb/hU4FGOwuInP?=
 =?us-ascii?Q?AQwwob6kra6CqXxOijGd7dUZgMzneHxgd+JSx29C3CTvJpMzN4IK1p87eAmk?=
 =?us-ascii?Q?aJaGz+yf5TJtv/TJ9RIj3drXxCZJHp3Q19e8lmkVNTPTZGmU1739yZXxtSIn?=
 =?us-ascii?Q?8dWR39q3K9L9WKc0qZEBnnqvPeRlc9UD7VWVCnepDgCHHPY5sw+bOtR2RsU0?=
 =?us-ascii?Q?5d8mLOSDtu2bBT7kLAyUdvWlXYy2M/rtgUd4diuor1sVa1kIp03WMJio+ATJ?=
 =?us-ascii?Q?AbNMPv9CKfEF971KYw7l783nLjV46l/HW4uH3POJmqaTvgmqeKQamvHvmhrf?=
 =?us-ascii?Q?flz9C41Fk4OflntOLP5n3GmPnvY5SUisFmKLIeJpoKyB33UxF9vYxqJLN+Zx?=
 =?us-ascii?Q?cib0uL4MvucsGQv+98oCikJe3TM2fML65wiyaK81cM9g+6LUb+6AODNXy+KF?=
 =?us-ascii?Q?/NHM9mTTAkW+EH/733+NxsFC0rr9Yux/bkecAnp12GfYjQ08x+T0fc8YG3ve?=
 =?us-ascii?Q?t34gcCsX7MzJBrD1Nj2VUEQLaoM9aL1cnP+lOxrYDD/48N8TNlIAnT6rIvzt?=
 =?us-ascii?Q?cSc3PxNfxbfp6IUIeqq4UbI4C3CNdEV2hNxIuLW2c0sqfPM57QJ95gdJ78Kg?=
 =?us-ascii?Q?AeF++3P02LXUtBxrpwXSbAl22rJws90AtG77WYjqVuPm7YFNsqkF3Ty7b5oB?=
 =?us-ascii?Q?mfXaK/onDcYAr9+Li1UtkpC2zpEeRT5TJ4Jsku69ksqMq3WFIME/qgRGz8/g?=
 =?us-ascii?Q?wA1B7Qqd8lUehcDmGaKdm8sheP9WcZUtSOpe8Z5gU5ZidVZuTIZljlCorwrY?=
 =?us-ascii?Q?X3sXWvdkSdNf9BT4BQbDb3MWEghOE03DHh12e+LHJdLbEGRsDwO3soYd1JqD?=
 =?us-ascii?Q?PSwXTb2BksmIPp9Ywr676bkQkKFgr3G/bajUb9+4xSXPucrPJOpleQFU3aYG?=
 =?us-ascii?Q?tDObsJ1904pshJlNn7ZfooCXZ8JeXBxXrcOeCcK2xApxVboMTLJDTyx5cslg?=
 =?us-ascii?Q?O35pXG39k9RmYU6OVq1lwf7BkwWHAIg+Y5M+o65uKy9D7fOe9Az4KwCaZK+u?=
 =?us-ascii?Q?My3MEAttJZr1hchsez2YiXezIgJYvdudVmgVbeBTMV+Sjx/3fFYkqAfd8py9?=
 =?us-ascii?Q?8/q3UwMT7U8Cg7RW6lXW166b/POdkwQG3sfHav902IyadBitOWMdZN4v0f4v?=
 =?us-ascii?Q?DUvdy7GuYZZes/wg6tqeI2b6Vp6GFQ0ZGdJZbPahxx77q1BX0sQdv+NHE+S/?=
 =?us-ascii?Q?hjoqMkcTBPC8O2nJrJoiFxVzEcK7uptJIxq20C+Tc4k2TbVzZam96lJ9oyXe?=
 =?us-ascii?Q?7qGyHB7qYUB70LCpeDY5dbSBnoVSMpw55dNU2uO8WBiUQI9CSzYqbwjoDjk5?=
 =?us-ascii?Q?Ys9uGbghB2PRl70r2xC0QR74TyYDL3OChdIh3lr55cQ5EgZPBihaMi1T00zc?=
 =?us-ascii?Q?Kv9DgE3zC9fm22AbAvFJwYZ9BXlMhFVaOUyccnCvUQzfnWBqMvm1Mra5aZHD?=
 =?us-ascii?Q?H/f4mCMXU97zSSKBJOWYeEgE3+aFqYQ61X6/5GP6xINquPezAQo4U0Ulgtux?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GVXPR10MB58375213D66CD4C30A60188888182GVXPR10MB5837EURP_"
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af205f8-a9cf-44da-b145-08dc6aa9cf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 13:14:33.7944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lvODvd3LApiY7JFXkUikcamx4FXve5omrdI3VrdQfJm/WL7LV05+YhOB4f3v61QNeGPloWaN6+yt58YAhdmz1fm7Bj5l5/Tm/QjRrm7PiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 13:14:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15808

--_000_GVXPR10MB58375213D66CD4C30A60188888182GVXPR10MB5837EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From edb4f62f1f11252bc82d34325130e072825d75ef Mon Sep 17 00:00:00 2001
From: Benjamin Schilling <schilling.benjamin@siemens.com>
Date: Wed, 10 Apr 2024 17:21:11 +0200
Subject: [isar-cip-core] [PATCH] Add MCOM x86 target

This patch adds the MCOM x86 as another hardware target.

Signed-off-by: Benjamin Schilling <schilling.benjamin@siemens.com>
---
Kconfig                                    |  7 ++++++-
conf/machine/mcom-x86.conf                 | 15 +++++++++++++++
kas/board/mcom-x86.yml                     | 15 +++++++++++++++
recipes-kernel/linux/cip-kernel-config.inc |  4 ++--
wic/mcom-x86-efibootguard.wks.in           | 14 ++++++++++++++
5 files changed, 52 insertions(+), 3 deletions(-)
create mode 100644 conf/machine/mcom-x86.conf
create mode 100644 kas/board/mcom-x86.yml
create mode 100644 wic/mcom-x86-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 7c19640..89f7467 100644
--- a/Kconfig
+++ b/Kconfig
@@ -43,6 +43,10 @@ config TARGET_SIMATIC_IPC227E
               bool "Siemens SIMATIC IPC227E"
               select ARCH_AMD64
+config TARGET_MCOM_X86
+             bool "Siemens M-COM X86"
+             select ARCH_AMD64
+
config TARGET_QEMU_ARM64
               bool "QEMU ARM64 (aarch64)"
               select ARCH_ARM64
@@ -73,6 +77,7 @@ config KAS_INCLUDE_BOARD
               string
               default "kas/board/qemu-amd64.yml" if TARGET_QEMU_AMD64
               default "kas/board/simatic-ipc227e.yml" if TARGET_SIMATIC_IP=
C227E
+             default "kas/board/mcom-x86.yml" if TARGET_MCOM_X86
               default "kas/board/qemu-arm64.yml" if TARGET_QEMU_ARM64
               default "kas/board/hihope-rzg2m.yml" if TARGET_HIHOPE_RZG2M
               default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
@@ -190,7 +195,7 @@ if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
 config IMAGE_SWUPDATE
               bool "SWUpdate support for root partition"
-              depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TA=
RGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 &=
& KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
+             depends on TARGET_QEMU_AMD64 || TARGET_SIMATIC_IPC227E || TAR=
GET_MCOM_X86 ||TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_BBB || ( TARG=
ET_QEMU_RISCV64 && KERNEL_6_1 ) || TARGET_HIHOPE_RZG2M
 config IMAGE_SECURE_BOOT
               bool "Secure boot support"
diff --git a/conf/machine/mcom-x86.conf b/conf/machine/mcom-x86.conf
new file mode 100644
index 0000000..21bcd1e
--- /dev/null
+++ b/conf/machine/mcom-x86.conf
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH =3D "amd64"
+
+IMAGE_FSTYPES ?=3D "wic"
+WKS_FILE ?=3D "x86_64-generic.wks"
+IMAGER_INSTALL:wic +=3D "${GRUB_BOOTLOADER_INSTALL}"
+USE_CIP_KERNEL_CONFIG =3D "1"
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/si=
emens_mcom_x86_defconfig"
diff --git a/kas/board/mcom-x86.yml b/kas/board/mcom-x86.yml
new file mode 100644
index 0000000..28c4674
--- /dev/null
+++ b/kas/board/mcom-x86.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens Mobility GmbH, 2024
+#
+# Authors:
+#  Benjamin Schilling <schilling.benjamin@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: mcom-x86
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/li=
nux/cip-kernel-config.inc
index 40c378b..7acdc0d 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -10,8 +10,8 @@
#
 SRC_URI:append =3D " ${@ \
-    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protoco=
l=3Dhttps;branch=3Dmaster;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-=
config' \
+    'git://gitlab.com/benjamin-schilling/cip-kernel-config.git;protocol=3D=
https;branch=3Dbs/mcom;destsuffix=3Dcip-kernel-config;name=3Dcip-kernel-con=
fig' \
     if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
     }"
-SRCREV_cip-kernel-config ?=3D "ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7"
+SRCREV_cip-kernel-config ?=3D "50f7039f6c1486be2f1e1b2ca0ddc300895e44cd"
diff --git a/wic/mcom-x86-efibootguard.wks.in b/wic/mcom-x86-efibootguard.w=
ks.in
new file mode 100644
index 0000000..6382ff7
--- /dev/null
+++ b/wic/mcom-x86-efibootguard.wks.in
@@ -0,0 +1,14 @@
+# short-description: x86 with EFI Boot Guard and SWUpdate
+# long-description: Disk image for x86 machines with EFI Boot Guard and SW=
Update
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.squashfs" -=
-align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0F=
C63DAF-8483-4772-8E79-3D69D8477DE4
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
+
+# home and var are extra partitions
+
+part /home --source rootfs --change-directory=3Dhome --fstype=3Dext4 --lab=
el home --align 1024  --size 1G --extra-space=3D100M --fsuuid 1f55d66a-40d8=
-11ee-be56-0242ac120002
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 2G --fsuui=
d 96be3374-4258-11ee-be56-0242ac120002
+
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1=
 "
--
2.39.2


--_000_GVXPR10MB58375213D66CD4C30A60188888182GVXPR10MB5837EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">From edb4f62f1f11252bc82d343251=
30e072825d75ef Mon Sep 17 00:00:00 2001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">From: Benjamin Schilling &lt;sc=
hilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Date: Wed, 10 Apr 2024 17:21:11=
 +0200<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Subject: [isar-cip-core] [PATCH=
] Add MCOM x86 target<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This patch adds the MCOM x86 as=
 another hardware target.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: Benjamin Schilli=
ng &lt;schilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Kconfig&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 ++++++-<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">conf/machine/mcom-x86.conf&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 15 +++++++++++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">kas/board/mcom-x86.yml&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 15 +++++++++++++++<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">recipes-kernel/linux/cip-kernel=
-config.inc |&nbsp; 4 ++--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">wic/mcom-x86-efibootguard.wks.i=
n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 ++++++++=
++++++<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">5 files changed, 52 insertions(=
+), 3 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 conf/machine=
/mcom-x86.conf<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 kas/board/mc=
om-x86.yml<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">create mode 100644 wic/mcom-x86=
-efibootguard.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/Kconfig b/Kconfig<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 7c19640..89f7467 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/Kconfig<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/Kconfig<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -43,6 +43,10 @@ config TARGE=
T_SIMATIC_IPC227E<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Siemens SI=
MATIC IPC227E&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_AMD64<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+config TARGET_MCOM_X86<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Siemens M-COM X86&quo=
t;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_AMD64<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">config TARGET_QEMU_ARM64<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;QEMU ARM64=
 (aarch64)&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; select ARCH_ARM64<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -73,6 +77,7 @@ config KAS_IN=
CLUDE_BOARD<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-amd64.yml&quot; if TARGET_QEMU_AMD64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/simatic-ipc227e.yml&quot; if TARGET_SIMATIC_IPC227E<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/board/mcom-x86=
.yml&quot; if TARGET_MCOM_X86<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-arm64.yml&quot; if TARGET_QEMU_ARM64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/hihope-rzg2m.yml&quot; if TARGET_HIHOPE_RZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default &quot;kas/boa=
rd/qemu-arm.yml&quot; if TARGET_QEMU_ARM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -190,7 +195,7 @@ if IMAGE_FL=
ASH &amp;&amp; !KERNEL_4_4 &amp;&amp; !KERNEL_4_19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;config IMAGE_SWUPDATE<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;SWUpdate s=
upport for root partition&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on TARGET_QEMU_AMD=
64 || TARGET_SIMATIC_IPC227E || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TAR=
GET_BBB || ( TARGET_QEMU_RISCV64 &amp;&amp; KERNEL_6_1 ) || TARGET_HIHOPE_R=
ZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on TARGET_QEMU_AMD64 || =
TARGET_SIMATIC_IPC227E || TARGET_MCOM_X86 ||TARGET_QEMU_ARM64 || TARGET_QEM=
U_ARM || TARGET_BBB || ( TARGET_QEMU_RISCV64 &amp;&amp; KERNEL_6_1 ) || TAR=
GET_HIHOPE_RZG2M<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;config IMAGE_SECURE_BOOT<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool &quot;Secure boo=
t support&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/conf/machine/mcom-=
x86.conf b/conf/machine/mcom-x86.conf<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..21bcd1e<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/conf/machine/mcom-x86.con=
f<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,15 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CIP Core, generic profile<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Copyright (c) Siemens Mobili=
ty GmbH, 2024<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# SPDX-License-Identifier: MIT=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+DISTRO_ARCH =3D &quot;amd64&qu=
ot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+IMAGE_FSTYPES ?=3D &quot;wic&q=
uot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+WKS_FILE ?=3D &quot;x86_64-gen=
eric.wks&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+IMAGER_INSTALL:wic +=3D &quot;=
${GRUB_BOOTLOADER_INSTALL}&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+USE_CIP_KERNEL_CONFIG =3D &quo=
t;1&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+KERNEL_DEFCONFIG =3D &quot;cip=
-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_mcom_x86_defconfig&q=
uot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/kas/board/mcom-x86=
.yml b/kas/board/mcom-x86.yml<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..28c4674<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/kas/board/mcom-x86.yml<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,15 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# CIP Core, generic profile<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Copyright (c) Siemens Mobili=
ty GmbH, 2024<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# Authors:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#&nbsp; Benjamin Schilling &lt=
;schilling.benjamin@siemens.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# SPDX-License-Identifier: MIT=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+header:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+&nbsp; version: 14<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+machine: mcom-x86<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/recipes-kernel/lin=
ux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 40c378b..7acdc0d 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/recipes-kernel/linux/cip-=
kernel-config.inc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/recipes-kernel/linux/cip-=
kernel-config.inc<o:p></o:p></span></p>
<p class=3D"MsoNormal">@@ -10,8 +10,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;SRC_URI:append =3D &quot; ${@ \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; 'git://gitlab.com/cip-project/ci=
p-kernel/cip-kernel-config.git;protocol=3Dhttps;branch=3Dmaster;destsuffix=
=3Dcip-kernel-config;name=3Dcip-kernel-config' \<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; 'git://gitlab.com/benjamin-schil=
ling/cip-kernel-config.git;protocol=3Dhttps;branch=3Dbs/mcom;destsuffix=3Dc=
ip-kernel-config;name=3Dcip-kernel-config' \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; <span lang=3D"EN-US">if d.g=
etVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; }&quot=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-SRCREV_cip-kernel-config ?=3D =
&quot;ee86aca8abbe7a41536bcb53142fbf0f57b1c9b7&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+SRCREV_cip-kernel-config ?=3D =
&quot;50f7039f6c1486be2f1e1b2ca0ddc300895e44cd&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/wic/mcom-x86-efibo=
otguard.wks.in b/wic/mcom-x86-efibootguard.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">new file mode 100644<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0000000..6382ff7<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- /dev/null<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+++ b/wic/mcom-x86-efibootguard=
.wks.in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -0,0 +1,14 @@<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# short-description: x86 with =
EFI Boot Guard and SWUpdate<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# long-description: Disk image=
 for x86 machines with EFI Boot Guard and SWUpdate<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+include ebg-sysparts.inc<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part --source rawcopy --source=
params &quot;file=3D${IMAGE_FULLNAME}.squashfs&quot; --align 1024 --fixed-s=
ize 1G --uuid &quot;${ABROOTFS_PART_UUID_A}&quot; --part-type 0FC63DAF-8483=
-4772-8E79-3D69D8477DE4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part --source empty --align 10=
24 --fixed-size 1G --uuid &quot;${ABROOTFS_PART_UUID_B}&quot; --part-type 0=
FC63DAF-8483-4772-8E79-3D69D8477DE4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+# home and var are extra parti=
tions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part /home --source rootfs --c=
hange-directory=3Dhome --fstype=3Dext4 --label home --align 1024&nbsp; --si=
ze 1G --extra-space=3D100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+part /var --fstype=3Dext4 --la=
bel var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242a=
c120002<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">+bootloader --ptable gpt --appe=
nd=3D&quot;console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk watch=
dog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1 &quot;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.39.2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_GVXPR10MB58375213D66CD4C30A60188888182GVXPR10MB5837EURP_--

