Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9485EC61DB6
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13172.1787564853370840972
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=NtutN9Cg;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2hiBWkkBPud4Ff58aAtwfn0QncfHYmUdNUabnSpb845Z1DwbWUKwJTY5TykKKVeNAWv4GG6sc0D7xZxr4zwfPvJ18u9TIGdUe3mU0tZB1zMtulHS90WxmnRKQEitcO+bQYjRzQyudGGRnahw9aUPnY/s6r+scn2hB/SG+Dt5mhkKt7EhzKb8HvranrHbwNgpMCdjd9cpt/yyRngGI0xv8LhSE73iDzXwutfFr3JZLu+A/Qw0ETF/lDMKJb8PodXJZdp7eQ/WTRTJuN4dx3xGzTdgPLFUrd9r413oPvJMibKu5W75f0RaUfiBKn7z7g7beXBdfrjBDiXXCDFCb0C/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaZFubbC88+IrmjgDlSG7zA84LvYkWjxwndeaeEEy0o=;
 b=If7PwuiXCu5gLqiTSlcxoRQvEz0PGfTfdAMs0JMWZ9TO53p79VSLTfDc2rsNhdNetZiG8U/CmguO9aM9mht910S0n5ZsR9Iyb1YWCm1pkhQYZGknmyJmJYiRP/v7yCJUSK1uL+Z2CbSmfQLEXtbpPaL+YwcpnSN++EO/etxnS8muT5fDW4mmPHJDNkpJorOXVaEh8RI5U+GooJwHku3ELgvIPqJLuoHdw2T2Wj3ADCzB1lIbCAU2lzPKJKCWPKS/uMAFDQMWWGVAgr4nHb2/LOfCjn/0YXji3YGs6C77ol0IBtsOFqJ/yWG+Ju9sSksNvXLSGYiZJKK8UCmfhuX2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaZFubbC88+IrmjgDlSG7zA84LvYkWjxwndeaeEEy0o=;
 b=NtutN9CgOAP7z4CgVvYtZYzOqu1pP1zwCzooKCEW1HvgtCW5lm4CNyvb4sYWoXJx2BOQJVB6lfwBT5qrsgavj6Gy3r027STOqf1XVWM251Aj+FwS5j98f5tr7c29/uwOaAzoba76ksTZxmaOEGRQkm5qHH+bp7vQwCDp1XNUPKoq6wFBu5Fm9aijPPjd2Lrx5ngcDfy5uWJ+wPqEpA05QPkl5QBAMDGjRmDMPLeSzBpwXxgGfyd4jW5cNgxH3iQRDHvJfhrJxHPaNF0NiSuwAQah3dvqIpHTBIxyTsVwq2htNdQqnONKbvEkXZ+cv/OeVDgbOAoPd54ZDfvassaKgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAXPR10MB5760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:30 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:30 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 02/12] Add cip-cis-rules to apply hardening configuration to the system
Date: Mon, 24 Aug 2026 11:46:39 +0200
Message-ID: <20260824094721.2636375-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAXPR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d20666-5fa5-44ac-7c94-08df01c4b6d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|55112099003|22082099003|18002099003|11063799006|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	XTr+EW0bWcyNFvxCBxRYMEcogMkN+b3lG+SIkf/vXL3HqEMViemMQxG74TNQRCBIH4QOTqBcYmEh5ZiPRz3zS7rVO4sFAHoJHPGsM5mZdZPEWagQIMgIZdfdeUI94pNE6ITe+YRE/earig88eSrXwQBuSyecDUGrFhdWYpW3tg6Og+jYRFhyyDDR7r8dL5VoH2dS/tE6aHzwnAoXP/kSZCdQVnaigFunrQLvJi4S/q1bJoFuWSH5Zn/8wAEuXoUtCvsKSs0Qzb3xs4DqCJnth1V0twnKD4mYMcj6PsycUwJJhicoeWTz6zY+EkPRIZejm52N3QQmAkg5czfHArGTuquOfNrshl+7jvcHE3J1c1pGCArrFY1esMRgXt9ySSBfrflwgiCAOxmbJn+U5JuIgR3ln4R+yq3TwaQ6BwrQtRDiGEoWmuWJa0wGO+QHwJs4DTBW/sFhyei6Hh7ckSydTeupDXHcAQxc1OY1a3A77wxwVVUZqxGvjASQpXGl331dE3CreSjYSG7iCgBzHYUddV83Ud2C5qkjJdBGs9xNYEOIGgIVhRaqbNX2j4/zv71n0bvjmEQ2VCBVdsiEvV/secCPdSZ6/SYBbkChBo23dmecsHIEdolR+zLoCGR2hveQ4EShED9oh964WWOGjrw3ZbgfDjKtypsgtW21iKIyYnI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(11063799006)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zeA//A3UhtRC9125q7mJtCeI/fY6E/sgpxJYK2HrVMFIrEpW/V7WhiKki+sv?=
 =?us-ascii?Q?NlZaLXb0H9fipedhRuOjiYow9wL8s4fSFC6ashfmgECMOMMeZSbBK12HGw57?=
 =?us-ascii?Q?Qx5qxvEtTfS5CWm2IAW3fKG4vuf+NGlziVP4FVmEdh3jA5GXh5Fen2ktMYXB?=
 =?us-ascii?Q?8RaJVOgTL2ZawBqU3kOoe3qhU0Jx+d7YxTm72KB1kMRcC7Gh4L8hy/8ln+h0?=
 =?us-ascii?Q?g6OLBZ6oPBm+lbV238dW2hj9lffz9scwwOt2FdTPFH8PU04PW0Wcgq9vrrdq?=
 =?us-ascii?Q?fb0UVIZPE2UDY3KmAX1qalYVTWMB+FpCrkEoCIw8hcFVflxvpU9/UPASXu6Y?=
 =?us-ascii?Q?PGfZRYMlWQfnZ7ehD6ePI8o63HRPviPE7+JBhlS/gExCTHhx8CXfVVgsEnIa?=
 =?us-ascii?Q?HMeewO2p2beK30Wca+4PeubX1faPWGkvfcr8QHZuXZZCnqLqOhh31DPkXZMh?=
 =?us-ascii?Q?ZhuPK+TQq05Wkt8eNSrPuZgyscR1L22DEtMc7PQKq9/LKfpJ8RAZEbbBrlDC?=
 =?us-ascii?Q?/WzJhOZTtsq2gCozCT55jAkt+xldjvD1JjnMrXYfQa9+YaX/iV4M6wtLKa65?=
 =?us-ascii?Q?4FfNzNRu7YXSKKGP3lQdvcdy2vlQ1BTE06dQvPufNv4ZogfO/S2rfjYV35/n?=
 =?us-ascii?Q?5KbqAH0mzl/Tdc30s8OtU1Znl6Y1AX1Fgpw68HMdvs0c6mFU442n4WdGAXgZ?=
 =?us-ascii?Q?9RkL1jzaFbOeADE0fobgzOB7YItMYU4woKtiXlI5SFU2DthXMz5Rdo9fjUvo?=
 =?us-ascii?Q?T5uK9rhdtVgnP9ONkntZvjq/NG/jvl66AfNOCEQ0T96XidTLXLy0t57rYPif?=
 =?us-ascii?Q?rVW70jJlqFFkY/8h4IZAVtFTEMAraT4M0zQwg6Mas4OVOzgsL91aEwnrmGXk?=
 =?us-ascii?Q?xODIivrOH9+/hm8lBaXvsdpY/dNODNyK/j/dFEV1Qy7obBMh5jThjcpmDqb0?=
 =?us-ascii?Q?x6AzLhFIgsotHU4wEYVO3ESHYGlURbhvcghkO5IkZ6jtJpPBWt3Z+pQDopz+?=
 =?us-ascii?Q?63Y78Lwe7fY7SCoGEMwERWIu9+9PMhdE5vFUbL6Hu3dTjmyoAiz1IBfdAVl/?=
 =?us-ascii?Q?1mLR0vOD17AY7vrMDEaFxywYxV8fBG9ib1oy3Zh2lR2Gh1Y7IbFSKnh3afBS?=
 =?us-ascii?Q?U8S8SsxdJgbqrspjQnw8GUv6gyxvfyWVv/Tkw+WrLEIOXQpD3GS5AvEqH24i?=
 =?us-ascii?Q?tf3PrtyTbjDTW8SQgls2LN83CKVDayBLpRPJ4Er5/rUv+5E2Wwan1qMokOor?=
 =?us-ascii?Q?C0DeWbU0kEEM1sIvbtEJa2ISf+fwOmhWkVuFQTGBxdc027DDTO334XCUI/T/?=
 =?us-ascii?Q?af8+lIjOIa6g+bNrJZtODOle/p4FIQ46NUuoPiJD7vR6Dzv3ZpHPkLX5hQ+W?=
 =?us-ascii?Q?+BT3UaSDpePuCQuEGwmMt5W2H38hp67lhUBqiNRawHAgbcq28dXQ7kTsn7ea?=
 =?us-ascii?Q?/j/JyOIcxK1gXzvqaHgGPE701YOjT33lgib3rL7XkVdPyEuHhVABWXHUNAyn?=
 =?us-ascii?Q?9ii3U+ZykRpBfEudryvebkl0SbMoIlNHhoqkvJII+uf74Lu9eiNfgto2DtXI?=
 =?us-ascii?Q?TJjiFcJN9Brmfkd+8a2OBsih9cevxzGvatFwVo6rVKC0rV5NcF6O1PQR/OR3?=
 =?us-ascii?Q?jQ5PshB7ydsfXukSkAk22nYFJOoekedyW/Ne6XewEAEQIY4pBRyzJabSClS5?=
 =?us-ascii?Q?bycEO6///zocHCdtBKf/Q2gFxs3Dk4gG4p0hEhAYopJGudkkhnupcsyLkqiG?=
 =?us-ascii?Q?DFyyCNl2M80yV89VJdCzeROF5x2Uu2o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d20666-5fa5-44ac-7c94-08df01c4b6d4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:30.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbJYSZ8DqaFgqeMxm66hfDa042NLaBFZ7k0Y70Mzw1Y9t4k9MaGBcj6qVSJ17LY/gS4vOS98EC/X5RBz7oeM8BBBXrY0s7UTDOs4XM+X27s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5760
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23983

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


