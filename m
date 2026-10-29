Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9418.1793272611677229324
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 04:16:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=rADK/LuQ;
 spf=pass (domain: siemens.com, ip: 52.101.84.27, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNbg6kN99E0EljrwrECBz4JVQvkMekGX6vkU5jbwEfHk6Trg7zhulCzb6NLsHVvUenHH7PQ+UJYuONPkXHoXlXM1YNFF4WfVvc+S7OVA3I6u08YFjB4HvIy4N4yJJjKLR3ZRTH+k+AKiKSutgSscLGlUjHPYoAypgzW7tO3jwAkzkHZE1CjLUTKOuQqW9bq+PBVSDg7f0KLTVYdT8Ijd6Rk2MIoGNjLx+vz5+uM2ckMpl0HGDyVOI6WRXkF6pKsheCmQR9agra9Y7a8oNWC75ZUG+wiZc9Z7p7OMGzb8c5mHy857G5wZonvcIyn7oF1bV+rfUjBJOLNFjsBDqMkKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3wjPl2dtP2QepIXmewEhWP8t51EmlLL0AgEM8mkRhs=;
 b=opCFrMITI1GRcMdB9eCFgRybgepCBFUmVAnlg1jPW6rC3zatCC1LXFE7tP57/5cr0gaNh9ov2f3avkA/idcQ5xVx6bDKCpbHVOjcsIwRK/v8a3ghq7IRTLqL2qr3l+NMmGto3pRlLdBGYRfexfFl2MKqYIYyerHHwck49RQ/KFx0tlxl/Uqc63cDUJsu4UDK2cbnwfHYDrIvJqMgerSOx8Gbm7QJLeGTU1CtAbnHBUFIBYnfMVUhBvfdlongprP9ti9kZ0HeiuNxZqsitoWvWB3c0BvqqgQxgHgZrU7ExJkEdhxx1ANwbVWEGeAfeuW7oZXUPBHppl3wJRBqkbA/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3wjPl2dtP2QepIXmewEhWP8t51EmlLL0AgEM8mkRhs=;
 b=rADK/LuQDKzUAFvYHJeCw3FGe1oEkIT4LH3XroOfyJXLY6PQGtgU5pNmTXX4UOwtI8QCUIz1QMRdEjU7XNuxsWNKoHltQnSUp7U80oDPxL5ndi4cl8QaUoYeW+VEamHn24I93wY9sIQc+YUWMGKfp5Ct/4ZeNbuaVUyygnP3O6oUrheaGoPR65lD0yH3Fad5ot3zupsgXVH6wgvdkofu/ted+fJiBYbX0No1rUBpsVAlZKPCps243w9wh+erplMIwedc4j+u+aOHr4LE3G2Y6winPX1K/vZ0dp8vi3QjboMbeVmBOKx1gpnTsNzGxNshmlE84Em7bzArb1oKsr17ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GVXPR10MB9511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:16:45 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:16:45 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH] customiziations: use Isar hostname-costomization for HOSTNAME
Date: Thu, 29 Oct 2026 12:16:35 +0100
Message-ID: <20261029111638.101749-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GVXPR10MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: d19f544a-1f86-4e24-fca9-08df35ae1db0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261022115727099003|261021123027099003|10067099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YUT8CTDRZeZ+S0WYcKYL5efD4HgvD2Mr0mg98DflfVH5LF+iBGWuRmY5dBT8NTDjexLK77HHpzqXwTYSNXrN/Vkhn5pAxre8FUtQKXr7wKcilCd0Ha28/MFxJQv6q0U1mRC4lhGH3s+0lGX9zPeJ/Moz26QOjK1a3av4N9H8nbnJQmMAuC803uvhkElbrZ8sHNuj64CBACgQF5tUgppZTrOpwnvsrH9Om5oXFRpKXKLW+WbwK9coHy4VGQ072AHgwXHufpK86CQ6yg9NMYR2uTqhBwpwVa7LBujg3t0vvtBQpFAZeQP1gI3KK6KqdFb8eZOJK0WeiGrlS3N2fhbwgOXm6nM2JgF1TZfSB9CTIxAf4kkaDtB+KhUiQES+eT+RUrqlfVGWFm8PhS23BbNsQfwe+78utQJsN26HM+zpFhfJEFi4ANOqZiTyGHCSD194tQeHNy86evow7AZBBkRJ/m98Ze8UQhfrz2joWoC8NhPX6cEnoxZd/LtNDTGyalE0eXMRu1zadvvpaTqt4ujQkllpbst/68fODM1Zl5f50+h14G+xD8Rf7TmfCqZY6p6EJcUANF4/T9AW5GQCZqu4MPLOv6qIvoJxAIjuKFyqACPoBqoMpB++UI9yiVukkXgUHrhQCXrD0lPeqdvgW3PsbG+I/UuBrWz/uyzCKBeraD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021123027099003)(10067099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5yBbPfzkgVuxuBUUihdBqATCfi95Yw0sMew84rSHBKaSCmzz+5/GcAOL1q5?=
 =?us-ascii?Q?l6rQyj8WXrVB1Cn8786b97+Lrxatra6Fwq0DEXCuVxSxB4JpS2DyikH85DUt?=
 =?us-ascii?Q?ZBIis4SFpSd93HYebf+eqz2uAbMJWIOPljFqNvLkHPMwajYgZ8wOS0iKIFM5?=
 =?us-ascii?Q?2YwUYT2OAwmnECxFp9ouP9/3w3XKNeYq9uU9B0SDem9p4Rhep+tEfQx1hc3v?=
 =?us-ascii?Q?R2W3ibTkBg1XqhJZmNluF8KvER+JUS4Oospr0/0BUDigSzPAv9YwLzeIKNMc?=
 =?us-ascii?Q?VuVNB+UfnnJWefsN0FzpfU8uv0ApzULwUDAXdx/WuXkizpiL/+tbrfO24X7M?=
 =?us-ascii?Q?Le/LaHdfvzia4cIxhv79X6bUM5uugBoZyJRCP3v6trs6UhvfYcuPKf+RIsFS?=
 =?us-ascii?Q?5hw6tEIe/ahakIltz1rGtjTbqaKbPi4UaXBeIsfmn1zuqVIm6GJ7JlCHdVhZ?=
 =?us-ascii?Q?9W4YFyLjp/1wzCml4aeIN6cBHas7wKQC0+ScijgE+gyKxJjqjo1YiLl8U+TF?=
 =?us-ascii?Q?BCQjCzSsfxKtTrGnVIG27Rf4Pykw54O1h4bGQ5xwBOGBbs3EbUiIzv1ThwUx?=
 =?us-ascii?Q?1zsw1F1IUr4Tg4RgCRyhAI2Um1eTAHPt+x/PbnGFAIXB/K4hKjR01I88semB?=
 =?us-ascii?Q?949ukFYaiaSlfbfUuCCC3241Ll8X/OfcxJ8Yj/OlyS9PKW+tNzgiN39FHmgp?=
 =?us-ascii?Q?jBTcT/fkcnDr+glArT0H5/r9vpzKkw3JoTlKsBeyejLUUHcM8ZcvwZ2Pu8HQ?=
 =?us-ascii?Q?NlocuexbRjDEQXj3322P1cJs5vD4ha/bgZQxKJDbl5+4WIGZsAmXdVPNUiqU?=
 =?us-ascii?Q?Cc4NrGllVwTAbKBK9GCLWcjua6fQTqbrQUXz8IqdELFqGhgdKI/HwTpKbiPh?=
 =?us-ascii?Q?IOdkg3BWNdiBvOfQkQrU2WAId8VweO+EwEiFzrXqxic3q2imt2RAZUnAclZX?=
 =?us-ascii?Q?D4Up/7HoDgdlU1W7SX4VtiywhaF85FUSGYDnFZv4z3I3XGiu2bIByya080RI?=
 =?us-ascii?Q?qkX9H1cbZ0RcSjlsncESVjrIV0Sx3h8nosmMbWcYDXqkYdF4gWtHlAkIfHMv?=
 =?us-ascii?Q?o5bkfC6ekUOc8dyy35B+97SotplO2nxJEN3L9OFT+jIv339WrU9f4EpFsZWq?=
 =?us-ascii?Q?nO7/a52+EnOApLOZOUCQJKQ3N/CkKc4RrNNP3bKrB7cRsswncv+jPebUd6pI?=
 =?us-ascii?Q?PLt2HLPFerI06WbHxt4dznaiAs29p7XW2PzZ6IounmnUwnzN9HZzzXSftml4?=
 =?us-ascii?Q?YFDXKcHhlqQTQgzuzE2KOcGKr5U0ajpPs9ExV/Khvm5e7uHNdw0aYM7nTn+E?=
 =?us-ascii?Q?bdNPeq7u99gFGv8jObwYODpxQToh/MpkhtaxgvilswX5MGjlsQWbkkVZKG45?=
 =?us-ascii?Q?7IS5unsFg6zQqjgiTNvCwPl2UA84kvmeNq+SBlGqszekJisufQMkoBRFIIgd?=
 =?us-ascii?Q?bT4cQLBmkYOWAw1E6/DDDWLJQ+CT2QqpIn7/S2GQoQFFlb51EaiOdZubmAak?=
 =?us-ascii?Q?sw0U1KydnLMHgiKMMTuMbfjVwaj7yiG9pYqX1rcWTng9qyzGTaPii2/I+r5z?=
 =?us-ascii?Q?GHWZfF/WLgrBqhHkps+mmUApW6sBR3Y+Y9L9w+8ufe+ximcZJB/eO/dwSfhN?=
 =?us-ascii?Q?7ovHKoH6LHoL5tbJa4iyDhs1034aiw5wH9dQo4nVb8Kexm6P2WWva/4a5M0G?=
 =?us-ascii?Q?V0wGN4FAuhKbY2WtjwbUvEo7azO42Om2ER56x13zxLfwKJ1gdfWJDlQGnoKl?=
 =?us-ascii?Q?LfIl/rbpvD9LeqMjBQfUtVV/YCNIINY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19f544a-1f86-4e24-fca9-08df35ae1db0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:16:45.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiLMWuOTlIPyMX9wkdEI8JDrEZn13PDjseXXkqRduxWG4Ru+XpdMDjb1YMXYbsBAvXIT1/yn2ThFSiku9yhEDknOauG12yLCTdpT//4BhzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 11:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24567
Content-Type: text/plain; charset="utf-8"

This removes the postinst template of the cip-core customizations
and also allows to reuse the `recipe-core/customization/common.inc`.

Also add `#DEBHELPER#` to postinst to add the by debhelper generated
code.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc                |  8 ++------
 recipes-core/customizations/customizations.bb         |  1 +
 .../customizations/files/{postinst.tmpl =3D> postinst}  |  4 +---
 .../customizations/hostname-customization.bbappend    | 11 +++++++++++
 4 files changed, 15 insertions(+), 9 deletions(-)
 rename recipes-core/customizations/files/{postinst.tmpl =3D> postinst} (70=
%)
 create mode 100644 recipes-core/customizations/hostname-customization.bbap=
pend

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..888f12f5 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -16,23 +16,19 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>=
"
 FILESPATH:append :=3D ":${FILE_DIRNAME}/files"
=20
 SRC_URI =3D " \
-    file://postinst.tmpl \
     file://ethernet \
     file://99-silent-printk.conf \
     file://99-watchdog.conf"
=20
-CUSTOM_HOSTNAME ??=3D "demo"
 WIRELESS_FIRMWARE_PACKAGE ?=3D ""
 INSTALL_WIRELESS_TOOLS ??=3D "0"
=20
-TEMPLATE_FILES +=3D "postinst.tmpl"
-TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
=20
-DEPENDS +=3D "sshd-regen-keys change-root-homedir"
+DEPENDS +=3D "sshd-regen-keys change-root-homedir hostname-customization"
=20
 DEBIAN_DEPENDS =3D " \
     ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-re=
gen-keys, \
-    change-root-homedir \
+    change-root-homedir, ${DISTRO}-hostname-customization-${MACHINE} \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) =
\
 	if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=3D '1' else ''}"
=20
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/c=
ustomizations/customizations.bb
index bf6e7175..3f931b8c 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -13,6 +13,7 @@ require common.inc
=20
 SRC_URI +=3D "file://ssh-permit-root.conf"
 SRC_URI:remove:security =3D "file://ssh-permit-root.conf"
+SRC_URI +=3D "file://postinst"
=20
 DEBIAN_DEPENDS:append:secureboot =3D ", efitools"
=20
diff --git a/recipes-core/customizations/files/postinst.tmpl b/recipes-core=
/customizations/files/postinst
similarity index 70%
rename from recipes-core/customizations/files/postinst.tmpl
rename to recipes-core/customizations/files/postinst
index 62e9a1a2..c65e2d36 100644
--- a/recipes-core/customizations/files/postinst.tmpl
+++ b/recipes-core/customizations/files/postinst
@@ -14,6 +14,4 @@ set -e
=20
 echo "CIP Core Demo & Test Image (login: root/root)" > /etc/issue
=20
-HOSTNAME=3D"${CUSTOM_HOSTNAME}"
-echo "$HOSTNAME" > /etc/hostname
-echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
+#DEBHELPER#
diff --git a/recipes-core/customizations/hostname-customization.bbappend b/=
recipes-core/customizations/hostname-customization.bbappend
new file mode 100644
index 00000000..2fb4dad5
--- /dev/null
+++ b/recipes-core/customizations/hostname-customization.bbappend
@@ -0,0 +1,11 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+HOSTNAME ??=3D "demo"
--=20
2.55.0

