Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E2CCF2D6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31404.1792405559440302034
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dH60wJZX;
 spf=pass (domain: siemens.com, ip: 52.101.70.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icUMrK8FU2wAphol+C5m8LWfZkiUwGUiwIaCgAuxNq1N9knqpY+hTJVoPErkdIBOF1EYo+UMJPZNiiP16Y1LBhYJsVAinSVPZUHQs3kvyP79lczlCTaE5/550/EmtSNgVNVsFQ6XeB8FjDjl3MdTuUQwEOx9AjZlenFkvyltJOdlTnzsFC7CFkRx5XnfOp6mOTWvWR8DYh595P3TLzLKUgQdle1PZnQfd9VimhpYEIz10+HPMSgULKcX33wlGENEz2968j5mKdUk6Xe9/xovvHqGnUfC3Rm6wSgBQHVuwsNKp2gkZIAz6B4LN0QHqsIP9hrR0pYAcah5Jfkdtf85WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZljMv1OgPIp4gtGGErbadbHmQC50rfHDzZMom4ovBEM=;
 b=czWwMKN/DkuQSr+tUUhLOvXmDKwC2bKxaPvvdYerfLJa0G/E5FhoHM5Shizi2mqUVtopYq+ly/tWLJboqzdvWFzOOOSNYIzLarRmHReoNJtsD4CGa9COV3WnDW9JS/QTdc7pyvEs43ndyNX+yLO34PCK25H6EFnTAWIeOVc0/DGactHMpRqHvokjMLDpBGewXMX9ANuLzW9dO+KS+drVmjXsG9FI3hoiNTKZwMUXtDqDftf1dFW3fA4Z2AqRAyeBHtWBgODFgeXS7b3B+ZTPa8+YK3covzux32ENsLdUpopaDGvbOC1g1QEJCl2yBW1ioMNOLSuAaZ9Q6U2KWh1d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZljMv1OgPIp4gtGGErbadbHmQC50rfHDzZMom4ovBEM=;
 b=dH60wJZXQDzvOgjouhePtcivKjN4l6Kme633IXpN2BNSVuWhx4K8iH80Q+sVDPEZoZb3UfF9b89r1mJ1OXvYWOmXPbU1srF/Ya4JR+pItP3/jp4Yd5RXiHEboYi9vMXlWrQWpMHcFLs4TNH4oU7Jl9Upj//xsuX+T6q/OBNJZowBwXApgdUXa51DGsAJRvmMj2b7BQjYMc/ViTVld6LzNfK4p3Y9At335JwQLZb3Q8irt+xQakvQJ6sNeODN3w7VfJahRrM2aqgwh7mRJCUIfIgi3H9J5puWrEh0cQKN1gugwh/Tq1Ef+pWTBPK4ppPyLAQ1Md0X2pLbowwwQZsd8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:55 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 12/12] cip-core-initramfs-dracut: load watchdog drivers early via force drivers
Date: Mon, 19 Oct 2026 12:25:23 +0200
Message-ID: <20261019102541.672620-13-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 78128cd5-ff7e-4338-549e-08df2dcb5b91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|261009223027099003|261009221227099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Z54h4cB7TsIR8e3JkPxiDwKuFuXILs2D7lvwrswRDByKl1Hb2dBhHme4BpdfmnIFITHIltjxpBVDe14TY9kQwDOWYN4If3ASDgjfC7FlsJI/ZGEqQ/oDyLbXFROkssmk4K8khyyYDqJrvTWK89j9EkpjrRYWWNoGowJVi9k1ULgQ3bBEQW22raUUDlxQcJ9q6J2G01OBzU+qSv8DQd6vP4L3VRv2wx3MsWPEt1QjYN06ngoG0sQMjv4B1zZNhQnPW7DUw0wNi4ApXOrNPwC7xFZnCiq79dKmhlZp+L00RGoXfM9XphuGzEzP7OmARmCR+z8XdUbsTsO5BJgpJUJHZ86J1Iv7vQflKrBqWoGdg0DyspFPF+bYqVo8PH+ZA/RsxDRJ+6Ygh9T7PD3y/5lOSW/0K8fzdMNW2O2lCyd9MfGzkJqmqlAWHbBXolN383Rg/h81b8ExEvlag/l83r5erm9LtzjmsOI2nGYTVuiHKswmyTZyYImqHarXnvDUixc1HkR2QJgCp+mOKo6FkvEmZGmxf+C9nA8IKtgApYWWad9EviL6pKDszAXdaDJCGLCODhD2AvNJKHKGHzdabkbqMqLUYpuabPcsi82JiVUAtrHtIsEmous3eZ6/KJDQHuboRIe51BB3gblmAPfwxtLP2QtDxZaHrn7tBf2YAvJKGNA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(261009221227099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z3j2yJywny2W66mK1xqcA/vyulaq7fwt150w1Xh2crvjLi2zeJyde5k1PXYW?=
 =?us-ascii?Q?cDHMZhZE1bnXow7tyuBboLYyEnT/j3h8HR+GAv/XB63KHodUFaNUr/tbIdc3?=
 =?us-ascii?Q?bjrJuW5kx6XN29T+FkmjrpQXpiPrZ01iuZBNWnL+pHulLLCCUtEqf+rCbT5j?=
 =?us-ascii?Q?Dc/06Qt0LFw5Rc7xaNyJok0q/8eVVeftqlL+GxbmZkS9JI47Qpr42vYHoaVg?=
 =?us-ascii?Q?ALXsSrAyvwG98Lah9gluzqwTKU7DXvAOw+9qQPAZXFKgiOWSde0nwUnHBIBk?=
 =?us-ascii?Q?X5V9CC4gOskwynPIq+OcP5dEh8HMwuWKkcq4oT6XRWNCq1MLA7gOBxa8mohR?=
 =?us-ascii?Q?zWtiQGzZlTdvXSFwVUtO6+s+jElM2/h8pkEuYIoonO98eWBjm+94aP0O2twD?=
 =?us-ascii?Q?oC9y5VcKpUlpekuWuFduj7ieymnqVlLDCVhZrEYO5ClPrYJxHgRNP5F6y0Gt?=
 =?us-ascii?Q?GVCcU5vaE6IUqjvmN4RITBfJK2vl+1VBvnIkiIkteqCzE5cb7yTbLGKh6mRO?=
 =?us-ascii?Q?UsTMYlRShrvbD/MI58lD3dwLZ/i62Jz1z+DSfTn+S0DEWuaJXwdxzzNnup9N?=
 =?us-ascii?Q?eQ/LoG9vp3+Auvn9d2Hl1oA83QIAC4qhhy5/0JLPdfGrzNDIfT7W3Vk/qSex?=
 =?us-ascii?Q?kT8bX01HA/LALl7PsCaITLYZMTlod6n9Y1d76EXXJJB+lPJJNqvioY+3kDXn?=
 =?us-ascii?Q?81Ka+MXeXdgqUN1nDRiYn6/2MnjtSYT0/syZuIiMzdk5+Nrsr2MFjx/Srpx9?=
 =?us-ascii?Q?8Cx1xc0pnugAgpNnwYghJ86RNNS6KaKMZ7zFsrIRqWG8YtXs0p4GMpEtvuVv?=
 =?us-ascii?Q?nai+CpVv9/ojGpwYuNm7qXVON0txJJJsm6Nx/nUDLhGs7isXiV6GX/O2Xcrb?=
 =?us-ascii?Q?J0vgXoacN5TMliOxwCk+MJoo5Va0HLR5gtjGng960MEQVvkZ8CdSvsqV1awd?=
 =?us-ascii?Q?/EqvhlfzP0ic8F/BXw/0/5SuQt8cy88HKIdh3vR0a/BR5qnay4NXYLNiwD0E?=
 =?us-ascii?Q?AEWgkxKlLasghy7aSFLGd38ytaSm3U47pxos0RqsGfW5VyHgqXCSp4CXr5ZU?=
 =?us-ascii?Q?dWevh264gNcw6+cKCNae0vjzSMeJ5aH1W8Lu8iOieHYbJmeZFLLbOsfCk7ub?=
 =?us-ascii?Q?whZ9bS60hgDb+MKOGSuIgvyhvSPA4m52HAUFSyYICQO0ZZqnzw/UGcjMibLV?=
 =?us-ascii?Q?crErxXSJPy6uDnaXMq7Uv4QBwSQ88hfubmRog9zh+nXLAWwRMAzsr3n+3dMt?=
 =?us-ascii?Q?qFkGBGuDxUY7YMLJv/HtzfcCXhEaAEf/ZHRiIREkZRoYs2ykxD7TgK745zOp?=
 =?us-ascii?Q?QAasxydOxqQn92MmLzm0vRyGGojsZXKFKbWmmDoCBevv0NneX3c4fY7NhQ+l?=
 =?us-ascii?Q?Bgu1wZxNxgiiTyFq7rhX2ch/2+7625xwxNrBN6YaprUlsf5aRPrg6uz5z9r7?=
 =?us-ascii?Q?cx1JAWKifwrXtPivuoRnea6QMf2ADNIfmzpAGaa3EKM9DbpPxEj3o0c3KeUK?=
 =?us-ascii?Q?oHFlGdpNZFa3R6kKOV72U35HQKHIIXKhEe2nCj3Lkrm77REXx7xJpkvAVs78?=
 =?us-ascii?Q?wmJwcM2mOdlUc1e7cJMBfU0kSM3OKXWeuhfKj6L+dND4lVITH2pUSR/T0IEb?=
 =?us-ascii?Q?aqRdVamTA60ctGfdenOnevqfCPh/zV48dyHFxm3SAQ+fqmSVaTWfNvljQrk2?=
 =?us-ascii?Q?uE6nGJoobQEZ7NIai+jOGwhf5N9kbg0t5GRslj1SLxQ+dJNfBAskX7Keu0hU?=
 =?us-ascii?Q?3Ra11D7F/eO78jpEPOUiwkMNc58UeJo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78128cd5-ff7e-4338-549e-08df2dcb5b91
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:54.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOAxd3R/HrHBDFZs3tEBhpdmLFbXCNGv+4PAAdoi85MrXXngaBQjMAu3d7AJRjA+jbsqP/x3Yzs0f4K3Wivaq3ikTTSveN5zrA/rRuAkYoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24492

On qemu-amd64 the iTCO watchdog is not available in the dracut initrd:
iTCO_wdt binds to a platform device created by lpc_ich, and udev does not
load these drivers early enough for systemd to service the watchdog.

Add INITRAMFS_FORCE_DRIVERS. If set, the new dracut-cip-force-drivers
module installs the listed drivers and loads them early via
rd.driver.pre. It uses DRACUT_FORCE_DRIVERS of Isar's dracut-module class,
which is carried as a patch until it is merged upstream.

qemu-amd64 sets it to lpc_ich and iTCO_wdt.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/qemu-amd64.conf                  |   3 +
 doc/README.dracut.md                          |  12 ++
 ...acut-module-add-DRACUT_FORCE_DRIVERS.patch | 107 ++++++++++++++++++
 kas-cip.yml                                   |   4 +
 .../cip-core-initramfs-dracut.bb              |   5 +
 .../dracut-cip-force-drivers_0.1.bb           |  17 +++
 6 files changed, 148 insertions(+)
 create mode 100644 isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVER=
S.patch
 create mode 100644 recipes-initramfs/dracut-cip-force-drivers/dracut-cip-f=
orce-drivers_0.1.bb

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 748aaa33..b85666ee 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -15,3 +15,6 @@ PREFERRED_PROVIDER_factory-reset-helper:swupdate =3D "fac=
tory-reset-helper-efi"
=20
 # when running without kvm (as in CI so far), 60 seconds might be to short
 WDOG_TIMEOUT =3D "120"
+
+# q35 iTCO watchdog: lpc_ich creates the platform device iTCO_wdt binds to
+INITRAMFS_FORCE_DRIVERS ?=3D "lpc_ich iTCO_wdt"
diff --git a/doc/README.dracut.md b/doc/README.dracut.md
index 2a59cd08..3f26d772 100644
--- a/doc/README.dracut.md
+++ b/doc/README.dracut.md
@@ -58,6 +58,18 @@ default recovery script is used.
=20
 The initramfs is built with `--no-hostonly`, which `cip-crypt` requires.
=20
+`INITRAMFS_FORCE_DRIVERS` lists kernel drivers that are loaded early in th=
e
+initrd via `rd.driver.pre`, like dracut's `force_drivers`. Use it for driv=
ers
+udev does not load on its own, e.g. the watchdog driver serviced by
+`cip-watchdog`. If set, `cip-core-initramfs-dracut` adds the
+`dracut-cip-force-drivers` module, which uses `DRACUT_FORCE_DRIVERS` of Is=
ar's
+`dracut-module` class. qemu-amd64 sets it to `lpc_ich iTCO_wdt`.
+
+systemd tries to open the watchdog device when it starts, before the drive=
rs
+are loaded. After that failure it retries at most every 5 seconds, so it o=
nly
+takes over the watchdog if the initrd runs longer than that. Until then th=
e
+hardware watchdog keeps running on its own.
+
 `cip-verity` does not open the verity device itself. It ships a udev rule =
that
 runs `cip-verity-match` against every filesystem partition and publishes t=
he one
 whose dm-verity header UUID matches the identity on the kernel command lin=
e as
diff --git a/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch=
 b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
new file mode 100644
index 00000000..df652e23
--- /dev/null
+++ b/isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.patch
@@ -0,0 +1,107 @@
+From 061e42be73d410405bca189e876efa3034cd55df Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Tue, 13 Oct 2026 14:31:28 +0200
+Subject: [PATCH] dracut-module: add DRACUT_FORCE_DRIVERS
+
+Some drivers are not loaded by udev in the initrd, e.g. watchdog drivers
+which have to be serviced by systemd before the root file system is
+mounted. dracut provides force_drivers for this, but it is a global
+option.
+
+Add DRACUT_FORCE_DRIVERS to the dracut-module class. The listed drivers
+are installed regardless of hostonly mode and loaded early via
+rd.driver.pre, same as dracut's force_drivers, but only if the module
+is part of the initrd. The module depends on kernel-modules, which
+evaluates rd.driver.pre.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ doc/user_manual.md                                 |  5 +++++
+ meta/classes-recipe/dracut-module.bbclass          | 14 ++++++++++++++
+ .../dracut-module/files/module-setup.sh.tmpl       | 10 ++++++++++
+ 3 files changed, 29 insertions(+)
+
+diff --git a/doc/user_manual.md b/doc/user_manual.md
+index a134903d..09ac080b 100644
+--- a/doc/user_manual.md
++++ b/doc/user_manual.md
+@@ -1877,6 +1877,11 @@ It is controlled by following variables:
+=20
+ - `DRACUT_REQUIRED_BINARIES` defines the binaries required by the module.
+ - `DRACUT_MODULE_DEPENDENCIES` defines dependencies to other dracut modul=
es.
++- `DRACUT_FORCE_DRIVERS` defines kernel drivers which are installed into =
the
++initrd regardless of hostonly mode and loaded early via `rd.driver.pre`,
++like dracut's `force_drivers` option. It adds a dependency to the dracut
++module `kernel-modules`. A machine can set it with
++`DRACUT_FORCE_DRIVERS:pn-<recipe> =3D "lpc_ich iTCO_wdt"`.
+ - `DRACUT_MODULE_NO` defines the module number which prefixes the module =
name
+ to determine the execution order. The default is `50`.
+ - `DRACUT_MODULE_NAME` defines the name of the module which is used to in=
stall the
+diff --git a/meta/classes-recipe/dracut-module.bbclass b/meta/classes-reci=
pe/dracut-module.bbclass
+index 6fce979a..6d32a4ac 100644
+--- a/meta/classes-recipe/dracut-module.bbclass
++++ b/meta/classes-recipe/dracut-module.bbclass
+@@ -22,6 +22,9 @@ DRACUT_MODULE_PATH =3D "${D}/usr/lib/dracut/modules.d/${=
DRACUT_MODULE_NO}${DRACUT_
+=20
+ DRACUT_REQUIRED_BINARIES ??=3D ""
+ DRACUT_MODULE_DEPENDENCIES ??=3D ""
++# Kernel drivers installed regardless of hostonly and loaded early via
++# rd.driver.pre (same semantics as dracut's force_drivers)
++DRACUT_FORCE_DRIVERS ??=3D ""
+ DRACUT_CHECK_CONTENT_FILE_NAME ??=3D ""
+ DRACUT_DEPENDS_CONTENT_FILE_NAME ??=3D ""
+ DRACUT_CMDLINE_CONTENT_FILE_NAME ??=3D ""
+@@ -71,7 +74,18 @@ TEMPLATE_FILES:append =3D " \
+ TEMPLATE_VARS:append =3D " \
+     DRACUT_REQUIRED_BINARIES \
+     DRACUT_MODULE_DEPENDENCIES \
++    DRACUT_FORCE_DRIVERS \
++    DRACUT_MODULE_NAME \
+     "
++
++python do_validate_dracut_force_drivers() {
++    import re
++    for drv in (d.getVar('DRACUT_FORCE_DRIVERS') or '').split():
++        if not re.fullmatch(r'[A-Za-z0-9_-]+', drv):
++            bb.fatal(f"Invalid driver name '{drv}' in DRACUT_FORCE_DRIVER=
S")
++}
++addtask validate_dracut_force_drivers before do_transform_template after =
do_patch
++
+ python do_add_additional_dracut_configuration() {
+     workdir =3D os.path.normpath(d.getVar('WORKDIR'))
+     module_setup =3D d.getVar('DRACUT_MODULE_SETUP')
+diff --git a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tm=
pl b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
+index b38ae50c..9fc5af93 100644
+--- a/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
++++ b/meta/recipes-initramfs/dracut-module/files/module-setup.sh.tmpl
+@@ -15,11 +15,16 @@ check() {
+ # Module dependency requirements.
+ depends() {
+     echo "${DRACUT_MODULE_DEPENDENCIES}"
++    # rd.driver.pre is evaluated by the kernel-modules module
++    [ -z "${DRACUT_FORCE_DRIVERS}" ] || echo "kernel-modules"
+     # ISAR_DRACUT_DEPENDS
+     return 0
+=20
+ }
+ installkernel() {
++    if [ -n "${DRACUT_FORCE_DRIVERS}" ]; then
++        hostonly=3D'' instmods -c ${DRACUT_FORCE_DRIVERS} || return 1
++    fi
+     # ISAR_DRACUT_KERNELINSTALL
+     return 0
+ }
+@@ -38,5 +43,10 @@ install() {
+             exit 1
+         fi
+     done
++    for driver in ${DRACUT_FORCE_DRIVERS}; do
++        mkdir -p "$initdir/etc/cmdline.d"
++        echo "rd.driver.pre=3D$driver" >> \
++            "$initdir/etc/cmdline.d/20-force-drivers-${DRACUT_MODULE_NAME=
}.conf"
++    done
+     # ISAR_DRACUT_INSTALL
+ }
+--=20
+2.47.3
+
diff --git a/kas-cip.yml b/kas-cip.yml
index 13251a75..04345552 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -25,6 +25,10 @@ repos:
     commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
     layers:
       meta:
+    patches:
+      p1:
+        repo: cip-core
+        path: isar-patches/0001-dracut-module-add-DRACUT_FORCE_DRIVERS.pat=
ch
=20
 bblayers_conf_header:
   standard: |
diff --git a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs=
-dracut.bb
index 8541574e..ccd6b7c1 100644
--- a/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut=
.bb
+++ b/recipes-initramfs/cip-core-initramfs-dracut/cip-core-initramfs-dracut=
.bb
@@ -20,6 +20,11 @@ INITRAMFS_INSTALL +=3D "dracut-config-cip-overlay \
                       dracut-config-cip-watchdog"
 DRACUT_EXTRA_MODULES +=3D "cip-overlay cip-verity cip-watchdog"
=20
+# Drivers loaded early in the initrd, e.g. for the watchdog
+INITRAMFS_FORCE_DRIVERS ??=3D ""
+INITRAMFS_INSTALL +=3D "${@'dracut-cip-force-drivers' if d.getVar('INITRAM=
FS_FORCE_DRIVERS') else ''}"
+DRACUT_EXTRA_MODULES +=3D "${@'cip-force-drivers' if d.getVar('INITRAMFS_F=
ORCE_DRIVERS') else ''}"
+
 INITRAMFS_INSTALL:append:encrypt-partitions =3D " dracut-config-cip-crypt"
 DRACUT_EXTRA_MODULES:append:encrypt-partitions =3D " cip-crypt"
=20
diff --git a/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-dr=
ivers_0.1.bb b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-=
drivers_0.1.bb
new file mode 100644
index 00000000..db3815c2
--- /dev/null
+++ b/recipes-initramfs/dracut-cip-force-drivers/dracut-cip-force-drivers_0=
.1.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-module
+
+DESCRIPTION =3D "dracut module loading INITRAMFS_FORCE_DRIVERS early in th=
e initrd"
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+INITRAMFS_FORCE_DRIVERS ??=3D ""
+DRACUT_FORCE_DRIVERS =3D "${INITRAMFS_FORCE_DRIVERS}"
--=20
2.55.0


