Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yq9NpYv3;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7z+vdPg96vEZM/L7uxWdlYatZ5iOzwAwbrZFz1a478cSbEEDZd5DbNpZMSuKzLSkPCgR8bbmA/zxnGhUibdHygVM/6gOE8xtU2RJhhKbrfBfXkzgzHpq5Ue49NHrI5aDC3zs4ssu/p5ycR7/37DFewr3FgocFOjdzlm7bWDtpwtsIq1dXRXhlCb9QZwMulkoSRkx5XoO7ufUyzRmMIhV5yYU9dpkYbofnPKO6Wrmuk05MQTkhDToJoiLMs8OVnclAcPAPvnWrN803GhU5mKhRUp4CT6XMSmucOFvw5yPRAm51eJkAON5goHezoDAawH3DBx4JRhzyPFrs3vsQzQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9xS6RpKxg73LimiL0IhgNZ9alTomjfEzqfELJ1XDU4=;
 b=nWZwSeh7tWT1qdBwijHjMHSYZiHOxjESypfEcwyg/v/kJhf3FXHzHSXYLPSVCamnJL4K3SzEwHl8PaQ5+Psxv6Db1348sOfoOHslXmHDssRgCNi6BkTC2ojczo+od9q4CxqdzVqhwYeNeSqUvTAFGDoqRT/56P2tWyLw3BwGEmf3QZje5tVc3V7Sn87adgqtnko06zLiBjYeRRJbeBA5Umcel6G0JPvOUr+GrptLhWjZUq7elffXWpgfSn0Gs2aqMqmd6FUWiOC5/ApDMYiqWF/kl01wyAbE6jxQSd2vH/WOydhb6efPOUiWssY3bvn6C2SFvnz1WQyquaaXoB1N9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9xS6RpKxg73LimiL0IhgNZ9alTomjfEzqfELJ1XDU4=;
 b=yq9NpYv3NReHi8IH4Fm0gygYedP4C/2XzCv2fJCTSNzTYJdZFu/LXBMyCAPeexSgSL4oe9RZbfBHvhE7aZmyA4m0CMazlJu1xU07yX0ojH7OadQIVTS0euYGoD9ttxXOS8byW/zXy+EVb7xUwdFwUJ3Nircz61ReCC31SjmN2sd3LYmiGQCwSShzlMeKkodlpvDl7BFigQBuwSV1SUX6xljI1HSl2EO2nDlv/vcC19+HWJ5kSb8F5aSxLkxkgy19SpmTfmUK5p2VQLMNhavKvzkuH7pKnavjfRLcLaz+cZV+VqdAxLKP6M6nXq+BztwAFDqBf3Fecvow0op9Ji8T/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:46 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:46 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 08/19] customizations: make systemd watchdog timeout configurable
Date: Tue, 17 Nov 2026 12:28:22 +0100
Message-ID: <20261117112833.316234-9-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a6ef31-c44e-45bd-2718-08df449df05b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: oUkyMYp09qxB5Q7RB0QbWKAX/IdcXBTajzXCazxf0nLzbqBn5IRop0fJ19oicdUwLytt0HB2z8a4MvwXirZO6gBw43zEwnsgoZ88BsN/QafrKuIp25ZtqIGOvGs4dw+In8FTVvuDNOeDIzeEgaPRbjQZQvn2xD4pZ4z7YeqKkdYHJtjXxq3eF8Vcjy5sEPTu9Z0uLFpsGZAcMbYj/P1MgiB6EtNYQoA+L4IO1QPiAOkakgTv23UGiYSuNh2G2BOexpX6IxmZo8T+N9yuWTA4Ab97ANH+deKJ7foWcXAwF5MZ9iPAOk2z3A+preoBJOl8HSSuq/CGh8qnDT9wFYahBPl6K8Uy540GZZXHTV/OhtOIFqbAC6XdVdtf27SJcc71yS7epcv5LWKteime9LfOE9tky0ZA3imNDS37DnXpFOzDYMk8KcLaS9DxsXo6SbzB2/Fk8hCYKZmj5dLXyEb6iLvSRMXYCRIsy1fiWJ1KUbepgyQyOwEDCDejOdIONs0zpXGFWs9En10EHGbl5vPFIrZjsdyE8i6D1g19eKW8S8YqliF7jpT3ezrRCeWeoJmjX+21wdEQedY2GtTgL5VcVtAR6qMPCRnv6ZmoLSXGxKZIp43XzP4wgN4uo0fQAv68uQWZzjDiPpZOI1k2YHm2dcbiDO0hORbU4hOEkPfOhqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8TeKT581yAKqdqLYMRZZ8otOzFFTA74sX8K+MyD3gkjqThlpkI19zmSL3yk?=
 =?us-ascii?Q?MNnZ9kMQPCR0mARpSjHbLaYSnlgImOgUxT0V8MAd3yZgcXyJhvdQErip4Gbx?=
 =?us-ascii?Q?ZpiiH/9+3lUiNJ4IPVEnJ0G3Bmd7RPB0/UPmubO86wIeCK5IfJTKzVcAIJxW?=
 =?us-ascii?Q?VFQo4hj0afrcYi2Kh+18NTV3x3nddaKXxX5rxmIPfTBc6yZ8v5DpfvoZlk2Z?=
 =?us-ascii?Q?HULWb2O5RVyHMvTXKoo0tiyhT17hfaCUUfSZQvUY34oTULd11gQEY6u5A/Ae?=
 =?us-ascii?Q?ftNVY5v9zQkhkttxs7ENED06Sm8Pe0ElvcHKE4g8PdHxXV3gtjgicLpXJVJZ?=
 =?us-ascii?Q?bzYSrfIgjwvffNjo387SvniPBugFpCKzxx79lRePy23XJ7AevfSv6GbbH0vo?=
 =?us-ascii?Q?AmldKla76l5ecRwRi+EJcr+222g7E/k74u5yabaWYanoXv8ZXenzP8++84kw?=
 =?us-ascii?Q?9q/Q2ZJiXzYkPQpeIoRkaTwegoSs+ZKN3pG/6/Zd4A4ptGErbN2SavDy61NC?=
 =?us-ascii?Q?XA/9+P7gwVTjG0KRMI4QQCQBh9RKeuViMO4GCTPPDrmwMHd0niRzgSMjI4XG?=
 =?us-ascii?Q?5x5DYK1TkqWgs9bafn0zJy0KY4Mc/FV6BhkZccYAipN7pnWqbl3rt5WTtFio?=
 =?us-ascii?Q?KXWKcIVy3Y2/6jiiAHteWKSDfmKkf60hcoujcT71GyDaeiENTusxOwPlTggh?=
 =?us-ascii?Q?rbRKk/KcOaQjWIaZnANz+4p087t+oZ4aHwZXEtz5LHY7rqKBcdnpD3ekIJ0h?=
 =?us-ascii?Q?lcC0PsZN6+ImQiXS3IZ1wVhLua/q/2xlfwVP0DqnQiTiYOtxM3b7GLNUKgSU?=
 =?us-ascii?Q?P2XNs0ZsuR+yF9iFRXZACqWt+YpJ2jci25LFzf6JI07hguBl950p/bwkVPJ3?=
 =?us-ascii?Q?3QM+CEH/UywAt39zVg64OHaElS1YHwf5PId3ABUMS6pQwbPD5/KE1nfNQUOI?=
 =?us-ascii?Q?rQ0LtognW4UufsMEdDJKw1LP3AlLLk31o7zQeEcpEEByWinFZD6N3o7psDs/?=
 =?us-ascii?Q?kVwBYqC0uJnbMMljbcLsxhyN3weIxgu2GtDVoSfaGt9jdzEZm+dBpCT4G5Aa?=
 =?us-ascii?Q?dNpmqtmU0bKkeg3Zd4y2nR30VT6vNm3PtI60v3DFvvXlTtSLBWgcOOiZ4cBg?=
 =?us-ascii?Q?4KlSqal2Nqc0FbZmxiBW0MDMVYbN+vZb8E3s7YmYdUxQTqw5p6Y//SnoW9Gg?=
 =?us-ascii?Q?tSUhxerUiAOBM8aAC0J0IiErozO72tyfUoSP+6aDYtgA7Zlykatojual977Q?=
 =?us-ascii?Q?uBrEemMH6v4S7A+huKf9HjXLQQn9a/a+QoI/chOIbgW4SF+TM4IBdm8ZAeB4?=
 =?us-ascii?Q?Qa6rMSaMrLUXIXDmsKdBNbihr6TjsBjhUunRauBgd78JHA3i1dl9i+BNK0A1?=
 =?us-ascii?Q?z56iZirJG3+gpwTfq0rA1VSGsLEtFj+kteDU51j3b7Y/Oy4JR1fFo9Yzmmu5?=
 =?us-ascii?Q?ssZ7w4+qt3kVNDAeZoiv+YaQ18/4ZJcO6qCbrABnSu8Mvafe93SNocbKKzPU?=
 =?us-ascii?Q?W8LUJUEjyPlsayrA10BckZRy0thNXsYQhuqtvfgfPPkjfWinIG2HhjLGaH9F?=
 =?us-ascii?Q?kPvXwTB/ZjEvdHk69NbvosRflf9t5YmKeSXZOGHxhdYKFcaPc52vqNTeXVZQ?=
 =?us-ascii?Q?PAOQAw4LGhpUs4pntB3zvEiL3NUCwJS3WTRV25XtOWZVKRMHJvVOWXdN5G86?=
 =?us-ascii?Q?E2ORaG7NYjnY2wqA7qBi6CsQw8xsy3Snj52U/Lrgl4HNyOPcjJMF2EFQo9Xl?=
 =?us-ascii?Q?byNYwHU6osw0Fctgmkbf0NvvDA2G6x8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a6ef31-c44e-45bd-2718-08df449df05b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:44.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUxUmgHAIjtiPn8fWUEImKxtNx7t8XTRwO7Umlc0+58SWSCb35Q01n8UvBUThHC/0MrJ6HhUcsi25e2GLUsF16FwjeptuFC/cILe6goxLNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24829
Content-Type: text/plain; charset="utf-8"

The runtime watchdog timeout of systemd in the rootfs was fixed in
99-watchdog.conf. WDOG_TIMEOUT sets it now, the same value that is used
for the watchdog of the bootloader.

Setting WDOG_TIMEOUT to 0 disables the watchdog of the bootloader and
now also the runtime watchdog of systemd (RuntimeWatchdogSec=3D0s). This
affects the machines and images that set WDOG_TIMEOUT =3D "0", for example
with kas/opt/disable-watchdog.yml.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/cip-core-common.inc                         | 2 ++
 conf/machine/qemu-amd64.conf                            | 3 ++-
 recipes-core/customizations/common.inc                  | 6 +++---
 recipes-core/customizations/files/99-watchdog.conf      | 6 ------
 recipes-core/customizations/files/99-watchdog.conf.tmpl | 6 ++++++
 recipes-core/images/swupdate-efibootguard.inc           | 1 -
 6 files changed, 13 insertions(+), 11 deletions(-)
 delete mode 100644 recipes-core/customizations/files/99-watchdog.conf
 create mode 100644 recipes-core/customizations/files/99-watchdog.conf.tmpl

diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.=
inc
index e6142351..b567df2d 100644
--- a/conf/distro/cip-core-common.inc
+++ b/conf/distro/cip-core-common.inc
@@ -45,6 +45,8 @@ ROOTFS_IMAGE_TYPE ?=3D "${RO_ROOTFS_TYPE}"
 ROOTFS_IMAGE_TYPE:rootfs-container-verity ?=3D "verity"
 OVERRIDES .=3D "${@':rootfs-container-' + d.getVar('ROOTFS_CONTAINER_TYPE'=
) if d.getVar('ROOTFS_CONTAINER_TYPE') else ''}"
=20
+# Default watchdog timeout in seconds. Set to 0 to disable the watchdog.
+WDOG_TIMEOUT ?=3D "60"
 # Watchdog to service by initramfs hooks during lengthy operations like
 # partition encryption or factory reset. In our integration, enabling
 # fTPM/StMM implies a U-Boot-based firmware which may enable a watchdog ea=
rly.
diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index 748aaa33..6cec9b97 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -13,5 +13,6 @@ USE_CIP_KERNEL_CONFIG =3D "1"
=20
 PREFERRED_PROVIDER_factory-reset-helper:swupdate =3D "factory-reset-helper=
-efi"
=20
-# when running without kvm (as in CI so far), 60 seconds might be to short
+# when running without kvm (as in CI so far), 60 seconds might be to short=
,
+# for the bootloader and for the watchdog serviced by systemd and the init=
rd
 WDOG_TIMEOUT =3D "120"
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..5b1196ba 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -19,14 +19,14 @@ SRC_URI =3D " \
     file://postinst.tmpl \
     file://ethernet \
     file://99-silent-printk.conf \
-    file://99-watchdog.conf"
+    file://99-watchdog.conf.tmpl"
=20
 CUSTOM_HOSTNAME ??=3D "demo"
 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
 INSTALL_WIRELESS_TOOLS ??=3D "0"
=20
-TEMPLATE_FILES +=3D "postinst.tmpl"
-TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
+TEMPLATE_FILES +=3D "postinst.tmpl 99-watchdog.conf.tmpl"
+TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME WDOG_TIMEOUT"
=20
 DEPENDS +=3D "sshd-regen-keys change-root-homedir"
=20
diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-c=
ore/customizations/files/99-watchdog.conf
deleted file mode 100644
index 1f38c559..00000000
--- a/recipes-core/customizations/files/99-watchdog.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-[Manager]
-RuntimeWatchdogSec=3D60s
-ShutdownWatchdogSec=3D60s
diff --git a/recipes-core/customizations/files/99-watchdog.conf.tmpl b/reci=
pes-core/customizations/files/99-watchdog.conf.tmpl
new file mode 100644
index 00000000..0475eb69
--- /dev/null
+++ b/recipes-core/customizations/files/99-watchdog.conf.tmpl
@@ -0,0 +1,6 @@
+#
+# SPDX-License-Identifier: MIT
+#
+[Manager]
+RuntimeWatchdogSec=3D${WDOG_TIMEOUT}s
+ShutdownWatchdogSec=3D${WDOG_TIMEOUT}s
diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/i=
mages/swupdate-efibootguard.inc
index d85e8569..076bf5ec 100644
--- a/recipes-core/images/swupdate-efibootguard.inc
+++ b/recipes-core/images/swupdate-efibootguard.inc
@@ -13,7 +13,6 @@ IMAGE_INSTALL:append =3D " efibootguard-tools libebgenv0"
 IMAGER_INSTALL:wic:append =3D " efibootguard:${DISTRO_ARCH} efibootguard-t=
ools:${DISTRO_ARCH}"
 IMAGER_BUILD_DEPS:wic:append =3D " efibootguard"
 IMAGER_BOM:wic:append =3D " efibootguard:${DISTRO_ARCH}"
-WDOG_TIMEOUT ?=3D "60"
 WICVARS +=3D "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_A=
RCH EFI_LIB_ARCH UKI_FILENAME"
 IMAGE_TYPEDEP:swu:append =3D " wic"
=20
--=20
2.47.3

