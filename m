Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495D4C9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5783.1790249769808718448
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NUmaOHGR;
 spf=pass (domain: siemens.com, ip: 52.101.84.0, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5xBiw1uuaDR5o2eGyaX34eYDFv1J/UU7CwYtUzvwRxA2B8BdbiyfqbfCqKyMIo1dQBwn1OHBaWMU6W55Ok7O2U0CBMff1at8Cr3cBCIJbnSeUD1o+wNSUuT34wqBiIqR3fgVoUNFcP4dumZ/LXn+qruVLgzzp7H7Yny8araW+SqKSJyh6ByrPWGUKvMeJCjgPYxAoj5rA66AqosyB6h2seTyANIuXp+lC/vwDSV7tf3GVuSGuUHrPgtZapqK1aLmTALMUzwnk51EuOMBjcWfMqqnkXbInMQwYo43aMECKcUhnEpKWmCj7sjZK8iSLwlOWh3jGYkprn+GJi9hhreEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=pH1oM3baAsiV6KINTPeit+6iT2iPjHdrHBQzmdaROSiH/tMSY72v8yz1r3k9DFPLoMYN2g9k6qkN9STZ1YSqZebGM6tMAghCf3zdZ5/VHY529foh3gfY0lZ60Y/jR05SVvKhGBKBuy3gigcXW/0LH1g+uhtmxJ29UcnjqAxT7UzJoDc6bapvWvZ0AU7zLzxlyty8tZY99xdl0xrPkTb29L+y/7mum01IrRmXHMJB5bC7cF3KHtPRucQIUmP5PN6a6tgI5S8yFvh5PyOgAC6UaKlK4nLw1VzgbOXkBBVpWY/Tq4UP9bkDHEp/l4pU/qNELvmlcIORzwCWBYeqaVjsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=NUmaOHGR7oo3R0qY6LZNgBqOwgCUietpBjfYSkFhPPgf+gFr/Qbz35fH8myxbbJ3IVoRXlAycUujR9oApfwFRqiSq55Vg2r2GQVpDBF0oSZP5kuIpiUBM56Wjamtf2EsSvKPX3rEDlxNBCH8PFnblG3s0cNPE/T7k31Bcq+iXcIlWE/wbJeP8F9TT7489Uw/WbQy8yZdzGHA9s1klt3CGhpAnqeCpgz2M+3Ys15Tgde/A8mEhYfsbFeTgMuFwJDq/Uzs5JJ6/t+smw4BMz+//sEMZ/udjBVlEeSrDmKM0cairwjBG3dhq3kdBtEn1HP2QZlVIYkZY3F+wvPeFLXiww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:06 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 02/13] Add cip-cis-rules to apply hardening configuration to the system
Date: Thu, 24 Sep 2026 13:35:02 +0200
Message-ID: <20260924113557.3191996-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: bb629cde-6768-45c3-d6b9-08df1a300545
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	nuqtvRzf8sZ8v2VdT6EOTW2tPNcfz5CPWJYOMrHupZGnXgXcd8Q9gXUiZ6ImnRhDMiNYJr1WHm+C1f2sUZXlk/WPVxeBhsmLfnlu7OtTmwxjm990r/oIk2HjtH8EW9fblRBO0DbQCXLimCovglHphS4r8zrQ+SSPOe0r5lsBDIpApC2WCUBHSpnEGVc4HmAo3iDVW2uCUPdbAtmP9R2v5/jahSNgJE/IgT05KJtuUV+avY9NHC9/1v3P6V6vSyeufkoHKykT3G+OB7r9dze1ajDV+dCAyGa7WppTNP9lXyS3VB78Nc7J+aIbm0g273b82/nz9wX4OhMPMIlKhJ7X9XJDchrx15iU/eD5H1SFxMgD6vjGQQQl/dDQHGBI6nPB6uUnTFFhh47Y3G0MRNsfw5ZKeUblB2Sxw+zZ0f8TJuptCSkS1MD5OlmofWP32mIltoGlIGhVXM8jwYfK7dNwiT/XGNIH4BuS68qH0pD91i92h57IRPfSHCaKUS+KrCKL614mpoweg8NogXQSYPA+lIhKKOyegz+qljoNLFxIqE8wX3xJ89C/xr3+Eo2LbuxTUYmexTVSsUCPGQ+5kqWhkD+3ZRlDAD7czB5OVHRrGXs8OhCwGEZGisGYKIn4W7yEFdHv1cjQdfnh6ZVKO5GgCbLyZ9jYTdfEHh/xNoqOeAE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CgxwrCXYG401zXxWLGdhfoc7Oyu/reoTYBm4XkRMv7cUqMpnJiJbAN9HXbNT?=
 =?us-ascii?Q?UXQeewDdULNSoTsEWfV4L6fe8etFt6vrc2w1T7gnLiyALhq0+RGW4V+YR0my?=
 =?us-ascii?Q?/4JiDrpF6I7iR18dB/FTLTer4WQj7DXoR6Ktij+V56VXelK9eUi3V9PZgmG1?=
 =?us-ascii?Q?RCXJJJYRDmWN22C+DkP/jgiwNnTGa+TTeCjb4hGWhv+JEyerY5ooDl5aqYxL?=
 =?us-ascii?Q?kodQiZHYv3wJMgXNbYGomsaWMMshanzrKQeDBxo7fjIxiywqhXPQWzgpDkaC?=
 =?us-ascii?Q?TMRRfVJvEktubE9mbyi+clS00PedXHHxyLHqHJn9JH5BvSP8Tvkp4VXImJMF?=
 =?us-ascii?Q?0C24dU4yLycbOlCWMZbgXyeBKViXi6+qdWv8USDc3M01RfAGlmQ2ZEPPLr8t?=
 =?us-ascii?Q?6ub7LAxJUF1pmFOj/MACoOR4igXDg2vIenbDgjgxma6bKSEFuwtNiatJKfSN?=
 =?us-ascii?Q?wyE0XnbDOxd8t34XV0qKdxTI6UX3nt7JaGAxjDTDTeBRMYMh1qER9w291Pjo?=
 =?us-ascii?Q?wN6Sf1552dqHbGSRwuvvnXqquSxsLpzH5WmLEwWFfXnv4MB7teuFBI5wAgA5?=
 =?us-ascii?Q?YHFnRkpBA3XLLwcqQgogUqgf0GW1aow7hIGeiX8DMPbTBDZNsC7wg7G1jxpF?=
 =?us-ascii?Q?rjqBE2u2GbmYhac4znmMat+Z/DORxiZTnXHHpAzOiwHXD6FVTxEMhiuXrJRN?=
 =?us-ascii?Q?Fojb/PsdWVcJgvLyISG4WEtA5rteJUWabjc4a4L6A1i0Ol2iDbqXP0GBeorp?=
 =?us-ascii?Q?l5yb0pSAzgjREYSlEfJdBhiIxb8bTOGgDBgVl4GwEGmatJEE+15ZebViAyfn?=
 =?us-ascii?Q?SDZZO/574nz7TMkOWgd3h8cblIQWwv3x1wR8LYb2PkT/z7zMajjWSEF+DBzr?=
 =?us-ascii?Q?kqIwnR+zBTUb/tqZU4vAVLyoZO3b3x5DqbCBgAPzzTRmIbxrdXtcAOiOPBIi?=
 =?us-ascii?Q?aDRbO2dS6pswp1nw8nM2Ltf9ZEZfed4SQbB37vtcuP/APPH0c8dVw5moKFW3?=
 =?us-ascii?Q?DYkwRzKT/EztyypQWBTI6TlvuoIOwZ4idLLTXNDBfomP98VwFxd3y/dSPMk/?=
 =?us-ascii?Q?R2J/jpi4CR04ZxZg08FZsF7dVy1+1f0JMvgWa/xzjKFj+sUb9NS0cdV8aN5o?=
 =?us-ascii?Q?h/5nm0d/g0B3PeH4wRwp9WZCBouohASZtLfveqto+sXCwkG4Rjgf1hqy6P4W?=
 =?us-ascii?Q?Wy/81i6VmT7N14pHOWydksJcfQMHB8eJuQ3wrHcFdxnrNUreoYGElp+egkaJ?=
 =?us-ascii?Q?c57k0aAf6sPFgHSK73FcAWFNBX6DOIPGJoB0qk5cJGmHS8SwL9+BTh7WVmiy?=
 =?us-ascii?Q?x37hRk/rPRvB5VcDC/J2GblFKoLX3RIBa/nUF17aoqF4R6e9EnRYz9mnnCfm?=
 =?us-ascii?Q?AblkugGt04eDqrUt7D2o6nDo1Uh6KILcue/xKCNTPr9K3cuc1J9IDakNUwwe?=
 =?us-ascii?Q?amJUK2qLPyN1z6EMeJxSCrQWbe26ERedHA9pRDqVGaOf5HSawCZw5BAvw/2Z?=
 =?us-ascii?Q?UoSJzy1SPH/Uoe6dQb705CLHwOkORqLVTu+GW8+xqxzUlCrbHDVV/WnCon29?=
 =?us-ascii?Q?d+kK352nknosrARlS1nydi+HdMtZspWvGrJjdIgig1gLYm84lmXhiVOzVNMG?=
 =?us-ascii?Q?Bg9wmVMmhNPCFv7peqlxchmTe/wRuDBbcNfwUHbRZ86pM250cptqeigtnMcm?=
 =?us-ascii?Q?+LB93NhbWrf5dVJx/kB5x4wGMMZ1kwkRiTL7FuMmamSkawVpvtLYtKbneHWM?=
 =?us-ascii?Q?FfRNEq7fQ3d5usa/qI+qsJyeMT2SKWs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb629cde-6768-45c3-d6b9-08df1a300545
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:06.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhG8iEP4stlJPrrG+9h39Lsv/uMIFHxSODvKewMOFhlSazJnupT4y/ZSO8Qz3UN/iuopieXUuwpkKzMNchDmA4+o+7GPg9vcH2tYT1/uzsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24316

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
index 00000000..216e0556
--- /dev/null
+++ b/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
@@ -0,0 +1,23 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
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


