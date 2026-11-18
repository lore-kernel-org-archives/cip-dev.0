Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11826.1795006500885356502
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 04:55:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HfvFC8Gq;
 spf=pass (domain: siemens.com, ip: 40.107.162.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5NcxFHOJ28F+SkLSK8kYrwgJCn4wZVlSsseOK4CJReZeSNA52QLy9xRiZI+abwcG8zTeeQiz6Ef4Vtmb+0SNDzjfc/psNgRS6FgSd+qWSoORYtu/NiNKAelP8ZSy0sy8lTykPshZbUwFPlwZkO6RqGiGMQnCSb4VurprPCfuQzZmMzzIn3nODW51zhUvR1xB5wmFr14ewFqc2izqVF+2e+Pril4+jmBC2zjKH7ya4N93omFiylCc1+1q34AoOH06W/NiQcOAyH7C/QHaFFGGiQbIlaylB0tZZ2TXxwOx3Z19jkiybarfYRwD+ShLEsSni8bi4EITATBljyRAYyQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/ipR2GUFz2CaWvPcwS1JuHEht1YKj6w0WCt+VNMa9o=;
 b=ey8KxuqCICJZxx0xjUU7j/TtlRIICK1aQw52aTapEWhfUzOR//l6wn60UNuC4NSJDjqg9DvwMFGeseOhFW3dQi2pS7bmF1tCcCHv2e5adWC4Xx4DkGb+/+hb/oKjkm05ZP6rZ5l/7N/bgYBdKElZZpTqdzFBflK22irNumNcZNk6ZzcYDCHX66z00lfMN7dSuNjjkdwiQuX+zJkTJmSgjK1zT10hmGuvZ4V0R5refBkFu4AVcP6wXtVvE2GgwLdptGgbIFSa1bh5C6jljIw8nRj4EYrzw7NwaJ1oN0LLHnEEQF1EKgLhdiuxFGll5TQ7U9RzyicxqkUD+lrJrudR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/ipR2GUFz2CaWvPcwS1JuHEht1YKj6w0WCt+VNMa9o=;
 b=HfvFC8Gq6RradIHyQ2veQsIVmG4Lb89gGxhh9s3GrNwDGjJiuYRZnh73cwpUwqKmHSSOrS6RAXs140sNMtvcsKwgQb0UWJuMdeeNoBw23uPo7EGlQ+BEmavUoTZbhc8I2+Z4XiL9wUctGRQqiVGVyTAk1UP+Qa4PmmF/NULapGMpdYf1jWc0kqsEC3vfLVIw/TfO85zNUq0WQxKArkPJxFEv7nCazgcXs7oww3qk4jdKA2GUAlGyHD+RyTi4tbkbl17VyrD/R+iYow5SEO4GIi9RDWnna3MmeVkg8DWwLQH2Kw5U4FJzCyqaXenBvuYxan9bYtkuI2honiAPTjD6tA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA2PR10MB9067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 12:54:56 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Wed, 18 Nov 2026
 12:54:56 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][PATCH] Drop ext4 build as default
Date: Wed, 18 Nov 2026 13:54:50 +0100
Message-ID: <20261118125450.620231-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::6) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA2PR10MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: fa144111-18db-4b26-d7a9-08df45732596
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|261009223027099003|55112099003|11063799006|56012099006|261102123227099003|10067099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: As1LiG4XQ5qlU9nIr9OQACHumkrF86pC4yaCA4QAoehBpLcEth1xrckqkGXmofgE0Am6QrgEzN/BYFA3hH8KzvKbIbRF4YliM/B1lP1SoVI7ntw381/+AiWH9lNYlGuNwOxxgv82mU2DalQ2d566iDizZttauVPjSjWwOLMLCzGMCXkJIfT3LsN4kJx8uJFskWqcq/6mfCQ4xsHjsR9ydiU+4AHZXu55LORF6bs9rA5o2cIssDhxRMHiqcC62tgqfyiOYFrBWyVcBqI8KYPbUzvJ9md3W1lGgvIKyHVuQbvSyqvMK8t6MmUSZSAYPMq6JeNF7FT9l8kJYXAN+flT7trYTTwOZjTr9pwtTWhCmJ/pnYBiHWfEJoIPnhXVshTKdE0KWROil95SGalyzDdQSIeZHBkckWVroKCBwfsuVMTnQWUUzCYsk7DIZD/rAu/7e66U+FfJsgiSZCVeS0ZLCCpGnPnVMFxUegV2ZZOxM9PJOY/rv+zQzLnZghYFZwMaBWbJJ9asX/Ja8UYHJnjPjnYbs3V27ifMTeGBuQkS7JpMA4QRy2U6zgU7ONntIiyjcSLNtzbNE5ksEGk6/ajtZWU6hvy5oERhlGobY8yPlqRh2OB4TZrztehdyvUrk8wXNIgcdKAKuxlERFauApaFDStzhTQ5YMsyuiTmamIxujE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(261009223027099003)(55112099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcPykvEPcMhvV5TAO9Qn7cv22iHOljT8nUztSj9fvDY8Z+FvWcz5ccKSEnUH?=
 =?us-ascii?Q?GV7sqbDkJFAd/Tqg0iaKO9hgqhUi+L0kzhgPJTcEFzrPnUkO1VVmKWjeoy6h?=
 =?us-ascii?Q?8kM4ULu6qs05zKm1kMkfyTDhcuvjsTFdaItGBIicgOH6umUPTU0Bq5ZsVv73?=
 =?us-ascii?Q?e+T1k/57rkCIvYGHr+s0pbNdaX6yBZlj2ZP6oK4itK48iOC9t4uURfurel9V?=
 =?us-ascii?Q?hJu72Kf30803EOdUU9E2310CtDllZR1kSnka+Vd72av/fjCYvNFo3aH0UTj8?=
 =?us-ascii?Q?Gr7H3DUu4xLecCYXUHn0+U2JDvSNlRnrrYyTuUozERVti562nXyiu6DHrmVZ?=
 =?us-ascii?Q?k4O3P7yeVs7+wRiHSS6/4MnEwoD+pyYA6XezQ7P3VA9trvqNEyw3crhOdDmk?=
 =?us-ascii?Q?CRYEJmUdbQAY9xyj8EVJ4HwvaAAwCEH8ewranUUKndwbDOM9HrXYA9lgVzYI?=
 =?us-ascii?Q?cNasy2gE1ipAJIzL/ezK00n8+VxnZQFI8A0YTwj4SHzpmDtL2o+U4vxVa01i?=
 =?us-ascii?Q?KMCHqk0WagwkXN2cxwjC1dVmpnrqVwOfGfeizSZ5PPpwZh/fT2P+LYaxrZXK?=
 =?us-ascii?Q?uDIEm6f2TQm274nSAqt4XIcEZck8Itl8ALPMmE0v6vdZSvj+FyAc9N3ZDhKz?=
 =?us-ascii?Q?GBkn8UlRPp4N9dzRl1cQnTL1fwrnrUy352kLuntE/0b2C6ypfZQyZKcD6StF?=
 =?us-ascii?Q?0ecwkdaZRYXyvHh4dyEkyxPOPExol7c9mFd2fIGXjBlwRxcAE0b37SqJi+4X?=
 =?us-ascii?Q?vRBIfL95Oc1agEGjZWA1EMHfDjNA9/qD9QTZ9kp8qRRFwW1DiseBSYwZ2tai?=
 =?us-ascii?Q?Lj1jbR/4FA2Xys0VFe3tYtX+0e6qi+3hqZSt5b1bgMpFv6Ec1LqBafbL/3mo?=
 =?us-ascii?Q?nFA4D9VZZFz3GgfqyTPyXCbIvfAJJ7u/Ry+FtY6FprAvYsAPzxqxyubS0/5s?=
 =?us-ascii?Q?G7BVsEZNr291EfqA0W8RnJwvD+PH8g0E+/f95wSFP5ox4O8TVsO2Un3q/xvq?=
 =?us-ascii?Q?rA8UCGPrlGyHXqNGdDXN/K59txMzGban3yQlCem/XKJiHYATParQnZ0wuSrN?=
 =?us-ascii?Q?yGi9Plo08dk4GWNQcpH/2hdn8I5kiIDsOU+N71Bq8W1Alhg62unMsZoUFgPL?=
 =?us-ascii?Q?gFZpYQIrg230aFgKJdXzg6ePr2BAlPK8nigwaYc8t5jjbFsOeifDvEbUwilz?=
 =?us-ascii?Q?suwdqdXMtFJDpL2NTDbNIApjZJ3oUCKUIlerkM8WP9nLRjSRxKjkF3KdYbTE?=
 =?us-ascii?Q?9T3m/nIcA4LKWyENodp3TeU6fQsvXNKaCeIceeWYt1v8WKjMvJoYyOq8N5+E?=
 =?us-ascii?Q?sbydeY09C+K4Tia9qm2gVywzON3yze12csCEZo9j6PS2cu9EtZ7IHTF1Jtzg?=
 =?us-ascii?Q?8jmX290G0DNMt4QgwIm35N0z/YbCtqID+P/AoP2j2BcLvxNBT6y42V8dlmrZ?=
 =?us-ascii?Q?o/SXbWQ08MN6v+hFTCpn3FlIza9zxproVCjT1Dnpw4VmuWOriJu5QqUkPgcI?=
 =?us-ascii?Q?59amrYF0ChYklpSCKybHXKDuM08+oQ1sW+TMdeVeIcnnGb/m+8CPD8GcY9jR?=
 =?us-ascii?Q?IK5kHiiJHKifmwJ05LgwY3cfx2hvJOjvpLcxyujBRaq4er9DJYeN4eNdEeN+?=
 =?us-ascii?Q?n2tCwqoMZ+dwR3KPkEYXo0IKLNi+HOYOy9JI86FiTtYMvG1qvW15J51xIrBY?=
 =?us-ascii?Q?6n3/7Ubn38uq0OOgeudZj0LSNhFdksMg8+aBwf8oEZRkjMP86XO5TbdpRohD?=
 =?us-ascii?Q?EvQndNNdodp4lSxSTRc1n32PsR+d6qY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa144111-18db-4b26-d7a9-08df45732596
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:54:56.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw88zCADhV0aSKDcpo9r3tFkLvAX2bA33bOnVWasb+Erl49H3g3mCprLVC3Dk17fW9fqqX62nlN34sS4QSjHsXVWXifFmj4zWI042kq2HjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9067
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 12:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24954
Content-Type: text/plain; charset="utf-8"

Only the no-kernel builds and qemu-risc64 require the ext4 build.
Make wic the default and set ext4 via a kas option.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

This needs an ack from Chris and/or Iwamatsu-san

 .gitlab-ci.yml                 |  3 ++-
 conf/machine/qemu-amd64.conf   |  2 +-
 conf/machine/qemu-arm.conf     |  2 +-
 conf/machine/qemu-arm64.conf   |  2 +-
 conf/machine/qemu-riscv64.conf |  2 +-
 kas/opt/ebg-swu.yml            |  5 -----
 kas/opt/ext4.yml               | 18 ++++++++++++++++++
 7 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 kas/opt/ext4.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bf21e744..b9a2895e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -71,7 +71,7 @@ default:
     - if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/disable-watchdog.yml"; fi
     - if [ "${security_test}" =3D "enable" ]; then base_yaml=3D"${base_yam=
l}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" =3D "2022.12" ]; then base_yaml=3D"${base=
_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
-    - if [ "${no_kernel}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/no_kernel.yml:kas/opt/targz.yml"; fi
+    - if [ "${no_kernel}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/no_kernel.yml:kas/opt/targz.yml:kas/opt/ext4.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; f=
i
@@ -173,6 +173,7 @@ build:qemu-riscv64:
   variables:
     target: qemu-riscv64
     use_rt: disable
+    extension: ext4
=20
 build:beaglev-fire:
   extends:
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 748aaa33..09b322b6 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -8,7 +8,7 @@
=20
 DISTRO_ARCH =3D "amd64"
=20
-IMAGE_FSTYPES ?=3D "ext4"
+IMAGE_FSTYPES ?=3D "wic"
 USE_CIP_KERNEL_CONFIG =3D "1"
=20
 PREFERRED_PROVIDER_factory-reset-helper:swupdate =3D "factory-reset-helper=
-efi"
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
index e0fe9603..f689a85b 100644
--- a/conf/machine/qemu-arm.conf
+++ b/conf/machine/qemu-arm.conf
@@ -9,7 +9,7 @@
=20
 DISTRO_ARCH =3D "armhf"
=20
-IMAGE_FSTYPES ?=3D "ext4"
+IMAGE_FSTYPES ?=3D "wic"
 USE_CIP_KERNEL_CONFIG =3D "1"
=20
 # watchdog is not yet supported in our QEMU executor for this platform, di=
sable it
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index 314d1430..24afedfa 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -8,7 +8,7 @@
=20
 DISTRO_ARCH =3D "arm64"
=20
-IMAGE_FSTYPES ?=3D "ext4"
+IMAGE_FSTYPES ?=3D "wic"
 IMAGE_FSTYPES:append:ftpm-stmm =3D " qemu-emmc"
=20
 USE_CIP_KERNEL_CONFIG =3D "1"
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.con=
f
index 2158a964..44975e29 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -11,7 +11,7 @@
=20
 DISTRO_ARCH =3D "riscv64"
=20
-IMAGE_FSTYPES ?=3D "ext4"
+IMAGE_FSTYPES ?=3D "wic"
 USE_CIP_KERNEL_CONFIG =3D "1"
=20
 # watchdog is not yet supported in our QEMU executor for this platform, di=
sable it
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index bf540796..e28f523a 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -30,8 +30,3 @@ local_conf_header:
     IMAGER_BUILD_DEPS:append:qemu-arm64 =3D " ${QEMU_ARM64_FIRMWARE}"
     IMAGER_BUILD_DEPS:append:qemu-arm =3D " u-boot-qemu-arm"
     IMAGER_BUILD_DEPS:append:qemu-riscv64 =3D " opensbi-qemu-riscv64"
-  drop-ext4-images: |
-    IMAGE_FSTYPES:remove:qemu-amd64 =3D "ext4"
-    IMAGE_FSTYPES:remove:qemu-arm64 =3D "ext4"
-    IMAGE_FSTYPES:remove:qemu-arm =3D "ext4"
-    IMAGE_FSTYPES:remove:qemu-riscv64 =3D "ext4"
diff --git a/kas/opt/ext4.yml b/kas/opt/ext4.yml
new file mode 100644
index 00000000..b9a3a80e
--- /dev/null
+++ b/kas/opt/ext4.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 23
+
+local_conf_header:
+  ext4-image: |
+    IMAGE_FSTYPES =3D "ext4"
+
--=20
2.56.0

