Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3BCCF2E4
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31402.1792405553417919648
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Uy0t0Jvs;
 spf=pass (domain: siemens.com, ip: 52.101.84.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdsHcBmnS8ACBXmV5eRiovPe9GvtTTlGv/OiV6sH1Z9FVMzdw76wnOSlloQMiqIH2xqNCsAnpGW0dgKiT5RDZgCD3PnlbJwGZeYRu8GWxyVABFwZiz+jvDZ4M/zkPnqnBiCcalF2YBHZX2eAr6LpXepxatXpqf1F3jwwzAFOVIKnkF4AFTrMQVvOPKVIjLVgu6mP2G3hfTF5P4/CvJBD8kOJ5H4gUUZKPiYAxw7mD1wQn9vcNVWozprbxZm31/la7k3sDCpgnasus89gn+GvXxk4VGMKckHAQkJA/H2jCPyZus1OLnEzImmgNhf16IuU2vHsyi/tgZgEUUj3MSHWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uq6suQrxpeFZSl19HN9ocRix1fIK+MbXr2b13cwFF4o=;
 b=EgMcEi3hycJ0cZIBvUoRQ091DkssF7SJKSerFbie27rrlBqA2NGh7MC5w+cOkzJLfGSq3cHDEBbZhkSxlziIbLDxbXRB8RSmRUbukdiBzUW+3U3eMRKySiuCcrkpfRXUi0YYWN7thk2wKT6NMdC5DBcodPCjY9vmEn7J1dD8XS9p8+QaEJkw52WJpCn6bCiA8Tf14F/PIqK49aKiDM0zPRSn9x0DJVqI7tbqqUu3aBIO+hSCl4WoI5HxuIkHo763GMQ+aQbCbdGZmu5FHBDqcoI6eHAhlmeU7q8PhbrBpJouQc67OHudK0AgjloiMnmeb9cBEBxNPdFt2zQj1AoQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uq6suQrxpeFZSl19HN9ocRix1fIK+MbXr2b13cwFF4o=;
 b=Uy0t0JvsIXYbO7oZ/YouPx5njRLCKaPBvtz67SnuyOuN/GjlwaNuABJRYl6NeEOgSCvUtb1kLEOPwq0JW4mQCYJOVy5hcTBZnedmzM8lrdDuLiX8c7+OEFRck8//I2qSQtcEL71I3BhxLeMzapHV5Rv64a83NUxQOaoGLhczD9Mp7PXl/vBJ3diuykr3/CCver3Qy4KU/PVMbexiAtkPnx6C1XqR5yblvIg1jmBHLcqVQusNbWwPVqjnjRlJmZUic3wP6CnW9qdATJsTPd/flzEE+gRFHGc7dhSfOmplkmvQ2PFjqoaTuJgD5dNo8Q5VR9ObYwdvgs/YuKjfOfMYyw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:51 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:51 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 04/12] embedded-dracut-modules: add recipe
Date: Mon, 19 Oct 2026 12:25:15 +0200
Message-ID: <20261019102541.672620-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbb94d03-fb59-4e81-67bf-08df2dcb58e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ui71RlX4FUVGEPHQaiU/bRZKlEw1wCDNIdizGudE6ZJZN+u4S8w1m3wz4k/SFQh4HOrq0SPNUV+pBXu2O4nl8rro40Kb5nO9PKmwwxh7W7kw69Uc/OKmQy8CdIz/JjHlE/fl0MKsmYsJpot2Y0D1WbSWEO77D7EDQ8tpHLh+fu8QEucBcwI89MCKImtvMDmqIRYRYV3CGXr+t7+0kL6tB+ta5pahjSvzdOShFC0HlBTs2mkHCr7/HJnG20tRrDu+aADqaE+UAP0/8z0MTnBcksmtXOIaCEZMeqNvEZ9d+i97uXOG9Aa1ecK523Ea/eT5INeKf4bcU7PCmkm9s1C9NMGFuJbUPqerrie/lyyHwEAi7qJi9aBHdBjYKsSUi8Q8QNo7dOKeZtBGtgRxfew4n4bU8wGzG9MnbdHKnEQ6YXbArsOzJoTDhPvHTge3AbTVVcLFng5CbmKfQGri7q3i+JaDge2Qt8ESi82Pexb+sWoFPX91poCdp7XuhiwS5C7HejIwnOLRkxE1qQpkvl15qvVN4LoGkYJUkMcYX8iTVR4uBvAvwVXc/xnNVhRMaNl6L9aH+g9CC03XaYqCxDtXa/+ol2IZSfqIh/acBkbkhSSXwvAcsYq6xnJkGEsXhn01ySfAHLH9gyqfiRZxyYKL8lamDadhkAuLYWFM6bV61UU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yU+NTF5yd3mSlLYrrsrKck+jtXlyL1/lPn0nSLjC55IdGCnANQ3RYo8Rmr8i?=
 =?us-ascii?Q?qWcpFec7O38JegkXAxcFq8hnuy3RgNmulbcEG2Yypd3eksnF0+XdQcxTOi97?=
 =?us-ascii?Q?0hgPyDg8b62lbXcJPH8uYO6glawjso0Q0xRBfRk1/uQSFM9OfI3jUECEM1zN?=
 =?us-ascii?Q?C9OzqUpkFAxYCEvflnxNXoVutVhutLb2/m0Wz224/AXLnA1pNDU8YcoFEQ5S?=
 =?us-ascii?Q?v9XqCgW1F5HZX3NMf3RnEnRq5bDLksHObA/8xb1ef8hE4BPxVWeBA7/bEEll?=
 =?us-ascii?Q?6JFRmczIKfLLDjIe5OexmK1qfHNyks46So4Og+2OYD/zKztO+U7fQNZMtJxE?=
 =?us-ascii?Q?y2sreFNcS/DqCIfZhvHpneQDgWt9YRhiaJ2H9nJpbEZoeMu9XBEklUuUNC21?=
 =?us-ascii?Q?O3kHFDpeWK1auMefQdjlu7swMaFoY8VUDfP3S5n67l/eFMhnJ5HVfkMIXhLw?=
 =?us-ascii?Q?S7BLL2WScZzS3Qju9Ujkl4Rx9crM+wJ3jSZ8VqMNPmVVNROf30V6hbCV2Zwd?=
 =?us-ascii?Q?wXd1AsUbGuiM+iROfxRsymFvMzUiI6tR5wo6D7juSIXLdb+JWvJkj2hKqZe6?=
 =?us-ascii?Q?UrqiLRQTtQPfLGmgiPkP2D9t7ihEtSSFv/j7FW15i+I7TMPefboF0EX86yv8?=
 =?us-ascii?Q?QaRM0P954xP1Jprm5LRsH2NZ7bKcrzIjCvFsCgzO2koqrefFj/bgLOjcY+H9?=
 =?us-ascii?Q?ab3zJrixx/3wOjQAB14Rh4gVZBATkKPDRYd6tjdhu1n3VtaPGsIXlClhqu4g?=
 =?us-ascii?Q?1t1N04fOEzaLothemgMTCu4VFgdcAl9fmdb9VRsUv6En60GyYkf+yRpvV3BK?=
 =?us-ascii?Q?D8B0RsW/8ja63u74L0uJExFwxEVIfr+TV1ztsq5rnA2UpwK53SkZ5yhtXvnQ?=
 =?us-ascii?Q?F8TEz88LTnwBHQn095qRXp9suD0iwmU+rh/3CSOP/DyVnw3vBBYkhbzXsRA9?=
 =?us-ascii?Q?sU0n74G4eHoIoyhQZ5m6hrWDSyWbZGlIGekiiZpDzU3NNApJf0Bt1xaP6qgN?=
 =?us-ascii?Q?qs0B8OI41hP1yxehozULeyvhDj8OQkvrm8oCXxgqC3J3D334FsJffAZogRLr?=
 =?us-ascii?Q?y3e2mSH6OJ+9HPMMjvODsEaZbTrtmiXFlsGS1X3PD3rGf2Od3M/t444W/Vut?=
 =?us-ascii?Q?l7r9aGqoFRtzEaNcCrBmMOjLgT6dJqWNg5rNelhj9EoMp6Hko+yoxsM5f0fE?=
 =?us-ascii?Q?zQiSBeOX3gL4RxTe5+y7wtbtFfmYYHGfdW1AhdIBnQY/nUiatItzjRqQLn+f?=
 =?us-ascii?Q?N8Ex0cn65eHupgQk+y628tH2A6AhXcthr12vKau5eghsP5E0ZRJccDdv9IBh?=
 =?us-ascii?Q?kWgkSbp7yazGgP1NZUSrbpWWkcQCjoupqysL+VaDHRipYJXX0z+eKNIq2u9Z?=
 =?us-ascii?Q?slU0ACHNc1wiFlMKOrK1u9u+ggcrVVnjKUX/xxNJjebmEuG01vi4m5b6JNKQ?=
 =?us-ascii?Q?yoLgU35KLZEXDnW10e8P2z5ueVqRFL+iAvEEjOjhugHKwxranY1NZ4FvNY9h?=
 =?us-ascii?Q?uaeoTtIHbsipyEYGl+pm7Gw8KGcpILsUhnM+T3A05Nk4d7ycieMsU5wXQIMT?=
 =?us-ascii?Q?8j7NqiUthPN0oA5PQaqKHG8xbTFkrrhka5pQ8elVVAujOX5sI+TvUOMM92oj?=
 =?us-ascii?Q?tT0N5kGil0q5tOegcqbhpBfkM+pmrDBv19u61x6Oe9b7/MDWkLUFbSC+mgy2?=
 =?us-ascii?Q?f7lNhD3k9Rdj2YhUPL1/xXUvVb9XxRKE+oE+qAxBxcUO5TS1p86iefOpHEpU?=
 =?us-ascii?Q?Mm2QfrR7p86xtolXdcHBBO6r5/JYDyA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb94d03-fb59-4e81-67bf-08df2dcb58e9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:50.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbgW7Qo72ElDyGO2/bGUuoP7kO4K182rvAuhWs9T14rGfbfeq44nI7a5TC6te2XZTauLZJeMihY6EtvbiOHqNcYh4PPytOgInc1xC0HUpY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24484

Builds the dracut modules cip-verity, cip-overlay, cip-crypt and
cip-factory-reset from the external cip-dracut-modules Debian source
package. The modules replace initramfs-verity-hook,
initramfs-overlay-hook, initramfs-crypt-hook (systemd backend) and
initramfs-factory-reset-hook (EFI variable) for dracut-based initrds.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../embedded-dracut-modules_0.1.bb            | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

diff --git a/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb
new file mode 100644
index 00000000..5e7cbc6d
--- /dev/null
+++ b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1=
.bb
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+DESCRIPTION =3D "CIP dracut modules: cip-verity, cip-overlay, cip-crypt, c=
ip-factory-reset"
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+SRC_URI =3D "git://gitlab.com/cip-playground/embedded-dracut-modules.git;p=
rotocol=3Dhttps;branch=3Drfc;destsuffix=3D${P}"
+SRCREV =3D "5fe822b058bcc9e035da4ac5056b7219b8c3d9ba"
+
+PROVIDES +=3D " \
+    dracut-cip-verity \
+    dracut-cip-overlay \
+    dracut-cip-crypt \
+    dracut-cip-factory-reset \
+    dracut-cip-watchdog"
--=20
2.55.0


