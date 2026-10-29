Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13356.1793284609038949834
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 07:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WyvdmGkU;
 spf=pass (domain: siemens.com, ip: 52.101.69.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5IfZXrPOUFtGfxMDSc7UZzDWK7Fh8/M8onQEkoIO/GJhF61GmQA1heplgsVi42xNyUDRNp15d94vJAe7kVXyaX7DE603cI0gLEj7J180zuAbFXSNhFd4ku+AK6nzRRqOG22M9M5qe1CuyV6pVDGv4D/3QXlkmzHM2/eujunwoSGdMvO6aikup/6u3t3umwMyzHcU0WwGhPjKhD1qOa8ae6qLZ9rvvruMXrR8VwxbrWIg+ismM9XX7ORdsDh4j2T++QEdTR2l+U128M2tekSx8szBqNGiGo4i2sFPet6sXhh1D7yBvQe57mMsDHx+QjVPMv7/F1B2GV/dfP+UtZMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5g7qbCwuGcW3uWZyZazoeKBwVttbBYGGF/XjzHWpAE=;
 b=fn3e1zS/6wCH8ewUoBgc9pmNOwFQBzwgQ4q+B6zZSUDdbGeyadY4vapMA8haYIW+5J7wbNF05cBqISuKWVsY5X8kkfZWnfwxmi68JnHa3KThA9oiJeVC3qWve01dR/h6W5Pel53u5SSdqcC0w6+nRsUq0fbPe8gm0pG+0hFqCLf246GIyhRJfJdiEcd3opGGIfsCtVkcWGggqmfQ9QF2qkppbDmpkm1PPIa1JMKX2sl4mAw6J/Thc2Q1L/b/toR1GZPE+JTHvQkzfICnhLb7j905MkFGqo0kbDyhZ4sbHQ7VkKiJwOSQKcAEcY83eSnFzGmPXmU813x8/X0x0I+7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5g7qbCwuGcW3uWZyZazoeKBwVttbBYGGF/XjzHWpAE=;
 b=WyvdmGkUtn7bK0CJBdg64QKbDspCDJFu5RAVv7/fHcTiAaYaVi/0KloQ8T1Lhzn+vwpXkY+YkODacj8CQLCwumqPZYYL4V/H1ULJQIFQCD7rE3O+KZznv4slqC6u5BkAutIyU2KT6QPy+nUkN2CU61Rs0RoZaMcdS0WaCC9DaPMV+tBbQoSUDRtM4awkTlg4qkAMZUl0mBOZxR9zb0oB83mExpLcW/wZTLWe0rD3felIdhvTeK8YueEdsS2eCeD3CTNbwCr6eSV1Pe/QjGMOjGTvCOeDyUnVjbDaoiN8bwY8wVqfKVjpa+U224B8EW/eZLL+kvd1zsDjOkrC3wVUWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by FRWPR10MB9324.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:177::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 14:36:44 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:36:43 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org,
	lukas.rabener@innomotics.com
Subject: [cip-dev][isar-cip-core][PATCH v2] customiziations: use Isar hostname-costomization for HOSTNAME
Date: Thu, 29 Oct 2026 15:36:30 +0100
Message-ID: <20261029143637.404080-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|FRWPR10MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d8fd5b-4640-4979-92c2-08df35ca0da1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: TIxprnIxHnHU3b8RPv+wrmjiO2z8kJR9Mham+QjFUL3cy3aDePbd2i8ycQ14I6GNwubGqNNE2eHEYDqq1l8Hsxifyf0MRqn/TFxTgzlQKreQPZ3MV4T6ubSgArb8xRln77mfn+fT2SFqbM9oHzNbqz83sNa0BmFEIFeP4Ql6yvcmf46DzKWt7ICsN8EH6IAMRIr1byw/THDfiZKXtnLlZOA9uKvOfhF+zx+39NZasMHdtzR+2zGBsXoytPk5beayMvVGFO4p/W2BSJGBbGgSVOMjvuZNDjUFxACO9hm7Nx9QeTR7+whirhw9Pg6drNn7S+laLdKgi1rVwrSOB1cz5XSh8eJvpsG/sx3AWAmsCfTJVJ24bYZF2LcjKCCDEtQW/tqe/P+LfevK9UY16k2vlDkW86zKtz8Ak1OVZ7EGBdnPdL01QLL4yZsUUjpZLAvc65sr7QhcoylMK5ezDy1wn6FsuIaizXxe8dGhfl5N2i4kZuorSalUPYCfzT1eMLg3DpZxIlNo5ixw3rWxIUzA3OdysuM7gm0f/eiytUXuydz5+QYGQdcoKXIY2ad5Pnvy/PGpdEh0Xf07uye9YGfE6ftYUIgO4FoPXPwRMDVGLFGOx5sFDba8vZum5eZC7r+Fh6X4HH42zqpFb1pzF9gwMspINqy4jXQQuV5H+6gHI9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJ9rPt9pTsCTQDfMdhSLBK0zL62saSorHn2S07+Ea0SUBMK5BDmrhoIWoDfk?=
 =?us-ascii?Q?3SIrvW2xaCK/lOY02M8glGComduikT81gfsfjkUjgwZYlAfsrqMw7vGQaQC2?=
 =?us-ascii?Q?QuJvaFW/2mLeRF0pHLf/FFvggtLocIFTcHviGl7y9NSeIjvc6aUbPyNAfzN2?=
 =?us-ascii?Q?TojGJgQF0Ba2TRIeGJfujv/akrRaph5DuhQns8uJFWPb2YCwL6ymkZzoHiYY?=
 =?us-ascii?Q?EsEqqqv/NgDww71cNb7KbEqdQbpMwaFGuBGyzoj1gS+55lK2qMByp1K4v5Lz?=
 =?us-ascii?Q?+2MoZvQGpow8vQ13Fdq/xK9RNk+AbMHAbjk05H7msMD3rnoJrbdJOqn9BYTu?=
 =?us-ascii?Q?/WayZ8gmhKPkp0siJRpeAASuk7dBP4A6ZnaRUTq+VtBrYv1zNgVgMkt/ONKI?=
 =?us-ascii?Q?R5MqSdvzTi9mc7F8g46H9uJ3ejZfLGAPNUnhpaMQ62UxdsagAx+kZhl8U3g8?=
 =?us-ascii?Q?dyYiZcgFove/jzm4zO1qh4tR6JIUK1Y3/iZLRrrrEM6Wxcv+uVCQ6KtuVKby?=
 =?us-ascii?Q?b6WjKUgH29IgSRl3zsgTaQ0GlWlKJFSXbPC8Jj1RTfbPlPyelVNaLo90m6LA?=
 =?us-ascii?Q?7lSs9Sa3Gf6scxxdC+uPzWlTEva59ZKc82SYAm53BiY7a5DUBIu8heuphnYl?=
 =?us-ascii?Q?lvJLB5CH3U2L9u9WFHgNSE7ptaVjHVrhaEz4G92dRjDQSwPefHO1Tw1fQcs+?=
 =?us-ascii?Q?i2hJGx1ZkcfjE+bmP1eiTb1DHD0o0cmYEBn0f5i5ZodcFXeJe2DS1+07zy7h?=
 =?us-ascii?Q?u7T5rqftT61j1RklAHX0QTDhNWj8ebZ6fWOv+U2zVWvX7f0/H84u8XGQxcQW?=
 =?us-ascii?Q?I+K00Rrejn1yvmpkNlXAxrXMMW18BB9szQl2dAOyDv1ginadhE+gtOCAZZaL?=
 =?us-ascii?Q?9P4TmqLTY9llg5x91M/ZipFrZ0MJuP6Z5WemKblCkU0pbAlMuJKyba+IsOFM?=
 =?us-ascii?Q?T18/2JNNjdvvkQPQMMJ11BhiZcTjXKVBGnQLFbsPQmt799IrPUup3kg+X+cm?=
 =?us-ascii?Q?TLFxhmmY5FHidqLPwpeDNJuMIyHtKq707vzqa+ZjU26QBzGU5E+4ShZqcbxr?=
 =?us-ascii?Q?0LB9krbGrrUfUopast/KHSQypsZPC2kFBqruUhrZfnkPfeJGlauim2VjuQMj?=
 =?us-ascii?Q?jDOm+Pd0tjO4Rm+78xSP6njrgmNTgXUGKJY1DW5EbWF8RbRLQSl+op8AmGe/?=
 =?us-ascii?Q?3p56RC8nQrNZ/8iCbLM6YEmXg3xJU+5J2XnQHCGgasjUAvr+h8sR/yPgnooa?=
 =?us-ascii?Q?W0Q/RydzWfU2OaHz4+QcOnS8gtP6hgL6o+6E/gjqAHkLz9cfG1gLB9uXkpZg?=
 =?us-ascii?Q?un+MFGe5juyMExB+aYKMYddebVFs2ngMVIybtPvfkzLn5mqsBylFokdTAVi6?=
 =?us-ascii?Q?dtCyJdKhRaa+pBUCpZDGsM1ik9YyyPGS5ll9okro1THiy1VSsb9TQ9V+XgA6?=
 =?us-ascii?Q?g0fjmXLVfEO3ZJPAMBRxlcq8za9HkXvUHzoGakG9icvBfSvQkAn8qpNI4t+S?=
 =?us-ascii?Q?iKNDrbehSXj5LkiIJ7WmyxCAeT1Ury0Lu77ajccjHlDgnS1+6iqCshAhHPZp?=
 =?us-ascii?Q?yBxEd0MQy1SUpjJX2LsJ/Q+AP+5ESpD/YHi1hkKy/A4z6e+zoTaEZAND+tqZ?=
 =?us-ascii?Q?oUXDODMNdbRc7ohs6YUT4tJcG1ybzSU2d0202ajlXjqZG5M3KuRNe/aL46cR?=
 =?us-ascii?Q?ti+MHkkqnx4YXPHHMODgH2unNRB97xRSMiO+UV5JDVOaQW7oqo5O340ifGWS?=
 =?us-ascii?Q?iwDU2RDmUGn7Q9hxl49GyLlTRBzwxsg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d8fd5b-4640-4979-92c2-08df35ca0da1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:36:43.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mEDMCLvhUKsSkie4PtU0qq6wh1ISxneye80C7XBfzPUoGnl2YVv0P35dZMFm3mahePmJm2R68Lq5v6HNqUsh/A6vIXmrKmPMt2Dje3lX5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9324
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 14:36:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24574
Content-Type: text/plain; charset="utf-8"

This removes the postinst template of the cip-core customizations
and also allows to reuse the `recipe-core/customization/common.inc`.

Also add `#DEBHELPER#` to postinst to add the by debhelper generated
code.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes since v1:
 - Use CUSTOMIZATIONS in image instead of Dependency in common.inc
 - fix missing space in IMAGE_INSTALL:append:factory-reset

 recipes-core/customizations/common.inc                       | 4 ----
 recipes-core/customizations/customizations.bb                | 1 +
 .../customizations/files/{postinst.tmpl =3D> postinst}         | 4 +---
 recipes-core/images/cip-core-image.inc                       | 5 ++++-
 4 files changed, 6 insertions(+), 8 deletions(-)
 rename recipes-core/customizations/files/{postinst.tmpl =3D> postinst} (70=
%)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..60bc5245 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -16,17 +16,13 @@ MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>=
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
 DEPENDS +=3D "sshd-regen-keys change-root-homedir"
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
diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd7..ba942a0b 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -11,6 +11,9 @@
=20
 inherit image
=20
-IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append:factory-reset =3D " factory-reset-helper"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
+
+CUSTOMIZATIONS +=3D "hostname"
+HOSTNAME ??=3D "demo"
--=20
2.55.0

