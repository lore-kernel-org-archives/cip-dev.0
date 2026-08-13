Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E6C5DF6D
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:39 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16256.1786617571831620592
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IGdD0ARt;
 spf=pass (domain: siemens.com, ip: 40.107.159.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVzrPTAur02XTmjVplD3eY6Sj2t+BpMqwzVRbwVzrVR/WQqho0YiAKJnznHCFjNJTA+0Sv5sNTXjZ1VZV9eNuHbnGXqZpULGJihytGbCDVsNYGGbd58fKEMMyfMRa0OfrlnbqkTWNkVHG5EyrmnF17JbvUs/5BSHtDXU70yVoUyo17/vmA1KH4GjW500VaHxq81fKnlUV8YZWObx5wZNw4qHfaFX3a9ZVNtEes3JDwSYZNI/kxrwyJfjUIxqpBdKT2qnaoLv6xgZmXHH2nmmQp/yojAUU/6wW8dviRWvkui6Roni0K0EfwXNOhhsl1kWhyFaq9Ip2cHE2a+12d61Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaZFubbC88+IrmjgDlSG7zA84LvYkWjxwndeaeEEy0o=;
 b=mLj9sfypYnW/5L22WV5zmSdc1rXntAW3uJWnGLy6oco3hAd0FGH595I2+CUbrfmCElqGpan8+idIZ1V0sneko80OBhz+MxR5liW30ZSRS296n6GZeIRJ9UqASvvgzuTYB1G0aCU4d/8ufmJ6oQR1lRLzC5fCDEzgUXUJURhlZE5VrcNAbdopQyHuoNzjO/DloBAxMEuO0gLqqrre/Wh02ukSWVV1cF46MfXP+CKs2pGWo2eibiW/T51I70eEtmWUnkvD/3NEijeVaxzOYLulfqXyMRWCaG0ciQGxMiPpbwSwYfcMzWrAYbafXTHakotEV/BKkhY+kPIv0rDctNf8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaZFubbC88+IrmjgDlSG7zA84LvYkWjxwndeaeEEy0o=;
 b=IGdD0ARtRjR/lW8h4r33ouLsgVyDf2wJ+acmCz6cTKTlfI8ZlQrWr1l+sML0Us3cRUM5AkdeHLDn+Q7VhtKS0Ur9c7HdoX8pQDESo3as8xuxf7v1/4pePGCh8BRCDz4R6dcjHdIwkMvbogsMuig4/pvfvXjLiMKUv097he6whGWiw+8KK4iy/GOc073yYEa/43QXJjTOb7/NPyaoqUftpFlx850Q6rgpdRctrJ0yM4cQA9zBQQmfOpsFEMgWB3uBZ6F9/90aO+E5KztvsvM+ij3ppvw2K/9QoaR8lUjK/yMpf4vF28+ycPM70IHxYb3muz3koAaFarUbeLVDWN4FSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 10:39:28 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:28 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 02/12] Add cip-cis-rules to apply hardening configuration to the system
Date: Thu, 13 Aug 2026 12:38:52 +0200
Message-ID: <20260813103919.184402-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: e47a6aec-c307-465a-2a53-08def92726ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|56012099006|11063799006|10067099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	qYCbNq4XkX5bAgwe0qTEU0/6+qMpEQLua+Xb9jnk3QkWB7WQ5+zpAHuNcd6ENgsg2KDvBtJwuLfBXN0+u0AETKOWq4zokS0Nzq520kejdmEJXqL+mevYK2Ji74xhkWmxrge+9vfTeONo0fMKwK6yDfm5LppXO5Wa8UF2dvuPc26q5BqGaqh2LZFW5OCnB//CT7g9pnvZvuQWGjaDAygLZ6REo2byrdBYn1CWFWQ2eKqV+7NzafPMmmWQ2957ylx1HhvUoLaywo8QlcMHLsGPpyorFfk6ZaAE1L/Bf8XFMCkx/WYfAA6CpGzbyz9ZoSp2dcQZ2AWfn1BCztVbO1UvsjMZIEEinI/tDm2CTSY4J0jucx6BbRq3cQM9qvT/K/T/90Bl2DeTIZJE+7ERIBhGE5X/SyHqsLUxdzKwsS04P3xnZoO66Fczqt849BvVUZTFWRHgG78QhizxQr8GZAtIwdy6YaBeH2z0oTu8H7vApgavgr08Wo6RgAHnrS/RleUtIgJxoY1rIJjTj/pUx2MHW+djOThG9xfHELDBdU/RTHKC2nSH2xgTJXwls/PA+XKrPYbSQ0pz8Uk/k5wFj7CnvxxLJE1JnrGWOU1hklhG++aHZWD42csSjYXMgd0n6vt4iKDCQfCMBKJSSkJrb6msepukt1Bce+gZOzL2wZ6/sjs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HWre78IqxEr2Z9ksCSEYL2dWLO82wCeFqGvrP02MARJHb47jX1zAdoUZn9lJ?=
 =?us-ascii?Q?UrjFHHCfqgUHyq63+7E/ccgbWZfCpBTcbJMaLwnGyBDshf1FvSvuK39uXdep?=
 =?us-ascii?Q?UguMFY/QqvGmEh9qGdUv8HHkhajNOMEKuPZgeDty0xEN16hwx9S3Ok6dXunl?=
 =?us-ascii?Q?LFZSVNj24yVNLASTurI1DQpGqR1MRAMqfbgWyOoHHzEIWRVva0tvym8jvtPG?=
 =?us-ascii?Q?gyH1GmqsK8kU12J6Y4qGZt9SgNQ77YF40dqf1JoGRE8GmpsQDwm6XPa7+9CA?=
 =?us-ascii?Q?6+NHFu2mX2alw8f8sVFilnbZuWWNQ/U+CLcwuisNDSjm2YRT0gozijvDNgni?=
 =?us-ascii?Q?G3RRw9hzXPcZVZ2JDM2B1TqZuaUIVtlOSwbOgooT0NQn7lSSLbFGAq2AMZ6d?=
 =?us-ascii?Q?Fh9Sd+NdTZDGiHzusmgW1ugp8ExXmA2WhjtkPBXxYhQQnOfuuUWAeivYhJxW?=
 =?us-ascii?Q?Ee5YZMDwKNjNReHvtCEkEnl0xHifREM0Rk3IYKktybdcAsORFkGXFE3sGm2a?=
 =?us-ascii?Q?zahx3XNlr9OOMGpK3lUHl2+FI7YBzSgGcoJyQlsEaSFaZRF1XPUrUginNV/5?=
 =?us-ascii?Q?SpG0XcydFF+vJ1H1Hg7V124yX/dlZukbmNSgJtjEe6RQVrLq38z7gkDdurv7?=
 =?us-ascii?Q?Wi6F0IlhrdS/98l37WLbDQPp9VCGFDT1ehZ8hgR5dOi6slVHbG2oijC5i/Tg?=
 =?us-ascii?Q?EPaAiuoJHRLCOIQZBuAI0eLbMkBs7Gnkg+lIa2J3hr1ORgzBH6KPCONP2Gsn?=
 =?us-ascii?Q?EZQlZhRSmM3K2CqQsS1XboNO4draPwf3zKjYz7pFoYGSTmOvkddQ5xAJ5Mno?=
 =?us-ascii?Q?kOOJZFLto/r9sBz/viOMOfej1C3snI0mjKvlozxT9AxtyBRB1VS6voPsERau?=
 =?us-ascii?Q?bsoKNwXt/nNdMHRzDnx2N49jYRTzC6LfAl0Zxsrqpc8dO5LXGc1MNxkYsy+j?=
 =?us-ascii?Q?MFfMWz1fS39R16eLQKgK7uT1K46AzC5q0fOyZxrWgPgOPU8FcVLm+2vT95Yg?=
 =?us-ascii?Q?LKwOBZLj+ac0C9tjRYYif0yps6Ckuxo4hklef30bpX+j3mfCttizxEfn921k?=
 =?us-ascii?Q?ArZZ4d1Ps3Zs8KxHIBS4GNQmgScaByi7w0ydo/kYHZ0LVG8rV+WAOB+WyBgW?=
 =?us-ascii?Q?LEiFcO9feFn1mfp+sUr0ueENgI/gCt12T0Yhh4pAIzJ+xZqzIpJhf4wDmB5W?=
 =?us-ascii?Q?LtT0AZT7SOrN67Y+6AsbwaYFwVX7/yMmi1jVG0WGnzEIH/dtLfOSyTf6yx85?=
 =?us-ascii?Q?D6E9ZLxbFeM5QQbSbqqkmpysCxFFhebq/hdVMT/7nGu69R08I3O+uSaBY1Ud?=
 =?us-ascii?Q?9zN+hDWxj9Z9BoXUxW9Hl1F8WInt97wSDj3VD538R6nh3rj1a9Aca5tfzpjH?=
 =?us-ascii?Q?3073cUjbgG+ajZy3gD8ABLh3ucfTz88slgUmt3jeFdUFlBMaEUjShIE3U7X/?=
 =?us-ascii?Q?TJtaMLAAnkoQNAw1Uezu7aodxc4aLd0JcjHZfCsbcTGgbI3ZHDPxyQfkVZ4I?=
 =?us-ascii?Q?RCxKr0H02GOghKMuN9SH5JMUNOed6nrFLqoZTKoA7ORhdneIRPSc9VQAD8ik?=
 =?us-ascii?Q?ogPJWSood6SLYhy9cBDYTUMXMFaVID4q1W3/aUauX4+R7+AfUHFI6BwRmiEa?=
 =?us-ascii?Q?iVwuogUsct9xC/r8BlEc19GP1jq1yMe+eqGm+/qeW0Fwzardb1j5JcBq5CU7?=
 =?us-ascii?Q?8nn9fled+IqZWfqjVzeTWfITiyoqNxwW2C6x0Vncxti721oYaHeaWxza4gun?=
 =?us-ascii?Q?3VnmJSUJrFAynSraHKjuSUPexxHyjd0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47a6aec-c307-465a-2a53-08def92726ac
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:28.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BnowmyabbQebAPGu8XJdVQsiRVh28J03ICNXG4bbDPTH67oaVXtI+5HR6ytcCc3P4khoAYPMRmuBBYz5ahy0wChyKNVs6lUsWihQtK0rcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23918

This package uses the configuration from `cip-cis-rules-config`
to generate a Debian package containing the selected hardening
rules.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb

diff --git a/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb b/recipe=
s-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
new file mode 100644
index 00000000..976f7d16
--- /dev/null
+++ b/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
@@ -0,0 +1,23 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DESCRIPTION =3D "CIS rule overrides for CIP based images"
+MAINTAINER =3D "Felix Moessbauer <felix.moessbauer@siemens.com>"
+
+SRC_URI =3D "git://gitlab.com/cip-playground/cip-cis-rules.git;protocol=3D=
https;branch=3Dcis-debian-13;destsuffix=3D${P}"
+SRCREV =3D "094acbe4926840f924c35b0526ee4f316984f891"
+
+DPKG_ARCH =3D "all"
+PROVIDES =3D "${BPN}"
+
+inherit dpkg
+
+do_prepare_build() {
+    deb_add_changelog
+}
--=20
2.55.0


