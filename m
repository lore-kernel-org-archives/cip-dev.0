Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD69C98331
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:11 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FURhXI7A;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC64V/2uoI3EA5kLklP/zESZPr8pS58nzOvq+rG4acDWQGYUOVWodnXkvKXzBlaAvUTNYuZ79Os51ZcclffU9ds/W16PAN/RohD8nrVU8kgfPVknhCwXfBrFvVROeD7gbjrmoq6yyQnbStnzlx8ZaOLQkuyt1GIX11nQIs5KpwcsMqXkhshNF0A/vwdq1fNCL9q1xgaAt3loJgFEmnXokZT8ZcQyKifnJK5CJtp2pyVde4NVpjICRrUV8yooog1B9C638sulm535kZKnlqfeTDLbr1HD5SVGuGKQ2Yobft5i8kvi0F0o6C4lJKrwP0xoqyxNz2WULKxZatcAadjuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=lYwmLBi5L216KXdeyLfA3cBjgv2uGoQZhEA6hGpph+wJnzCAVrqG6BiH9UEE3iTKEO+kQCoSzNYl3MCt6xiwP8gzpt++bzoAbhd15hBwuTPLhkeU/BvPIn/zBFqIoAm7byM47oe/qu1FvF0B8Eq7tZ8BueMYRMblGknrzbo9987+hxeB5n6+ifw6MEtXRFLEjIF/bS01CDjsrL9fbMtze10bQdehTQrGoMFn9dAVwJvvy1VJyY6DAfUktVW1x4S45JRaB0bRjKmxP3tMKeZZpg3i2MT7A52DvFKPBaaIkGztVwsrhh5QpMUfTSIhT8MQLvoYBCpqdEa/XX0cA4VdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=FURhXI7A1y3uF4iA7B4VRqFHW3jBOaCSnUDLrB5zwqMiImROwvnMz/oQk+ZTh30jv7MiwvT8xaD25oM+H6GBf9YEC8zutL481Y+dxcVwcJKwuPMQti1l15zfxJtDXg7YAOfvnzNRHYRO7iBdPqhIIBCTr/8xIVKCIpYDb6iKmGM0bYZAmw7gmbTgb7gKen5korwxBkp9zOHMx+aL+iNxymj6aM6Wff0tS6Tcjc5yt2YH6aUBFO7HPX7RS6uFr1lyQ1mgeSdDyO0wOAXENq2JcNsulD+1KyfLkvA0CVXMBQsK7tuNLKTfSJSgbifHt4dpa7icqazKv1uyar/tLhxh0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:56 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:56 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 02/14] Add cip-cis-rules to apply hardening configuration to the system
Date: Fri, 25 Sep 2026 20:08:28 +0200
Message-ID: <20260925180847.622090-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d6a692-a090-40e4-e818-08df1b3010e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	D5a990w6IpJEYjrQyNJ5H031JW5TMGahxSrzS/b+kv0KsEwGesMy2hZoGDHnU5c8TdH2CEHQJ9PWjIo/d1SLDbvHyGVLG0saOJLW1llLlXESRk+cYDwN5VF+GHUjmpW1zZVpAh6nRbMrNWU92xQdkuIybmEmgv1mc2k16bW9CLAqtnNi7LnXCUSVl2SFHJzAlP7kAhLOq0PhZyizPZphrPZlwxZ320c346iKHqbQoJ/0tZzR3kWogL4emqorsy+3u9ANhsjBMnWR3JvK++LJEYKh+kx4jeDQYkbDXinITQGHm4mCcaiQslMtfrCBCtjbTlt/mAjjwWsDlvmQBexAPWX+DcBc91aYtC2tEGvHHL92c/Dcys4OHxM3DyZuIbzGn3OQoOk0Yt1MXiSIkE/+mhuZ1aTy16dUAg+5t1EbZtuW1eCpUFEmMdJPhNORU4kveS9bU8xDn3KIqJ2LHlyyGpeCHf8rPGdkB9RO4JwxmmexWGhri5x2xPwGy/6X/09XMmuWt3I+fgbW6NGmauevHHxhcab9NyS2anPHos0iVxjxEEA6Z3lSBgcHT91I7BU60Q6PkBE0d5i+sO1wD5L3cqXpmrEH5NoF1DZoDwydEWqZ7mH/ZuNMWvLXk/p80yYrGXDFcLo1aE+CqX2E2MxK3tSTiKiAzj6AcnoInMscS40=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7ZteqX5HxpkD9Osac2NdJXc8gb2x5iVg9ZEnYf64fd19uzrOh22YIcfQxBpD?=
 =?us-ascii?Q?1k9gIQ1JQwLO1JMihsUdFHWZQ2gc3kS5+rXzpH+i4TG671iRPkKQF7eRb+YR?=
 =?us-ascii?Q?gYaMgq5ky0ZFqssS0ufhvQsyfamTHZDUEUPIA3ueBQv+F5TP7lS8QDQw2wOr?=
 =?us-ascii?Q?AB+EHUeRv+JttYwDDn51rdH20BOzRtEGXRw7PLjyrDBcWGtMeGrZv7oKHP/x?=
 =?us-ascii?Q?Ox5vUigcpBAvXYeGJZvnCF/iPlnTSl+FQTjEWR8cdcBk4g7tAKNyUUDndlyc?=
 =?us-ascii?Q?UfQnY28T2yNTZ0mqfqivcgumtUMUmFJZ5AbauWNCW/FUdN65CoGdCBD1KjCw?=
 =?us-ascii?Q?UHcUSnpGRvczWgbvkHwbbF1Yge4rPoOhE86G7PeFAOfxvqGI5+r40/N7H88Z?=
 =?us-ascii?Q?uu0isah0l2ZzjGUnwRRg2Ujm9zVwjGbtyebLL+G7WAPaxVIn45REVt+Q3A8E?=
 =?us-ascii?Q?UIV55MNLdcmnpcXKr67XWV8km5sTqW9v1PyV6mxzwuj23c2Wm3jnZnoc3DhS?=
 =?us-ascii?Q?0/47BdPWvlAMwDo9bZvcWKpPdECO9R1eEAydzRQonh+4dRRRFQsh9PqutODD?=
 =?us-ascii?Q?IJjRD55xV2GOihixz8bYcbza6FjhsAkXVrBlnddpAaq0nIEIGgAnoUt5iJJ2?=
 =?us-ascii?Q?LtA3UZPenTX7o2KB633eGOmT0EIws0Z4xKkTA064GOjNHqudS2qTcnKnWjmz?=
 =?us-ascii?Q?247BFmb2dguCDijQaKYY1B497V20nnYI8ziiJRPemoBlf7RD8z6tRFwTL2jM?=
 =?us-ascii?Q?8984y0IF+K7E7zMSna5nkVeCnqliFRtWb7bhDtcGHpq7Gt1ldlWSqiYCD2dj?=
 =?us-ascii?Q?QnfOrskA+3bM/E2C/2c1QADL6BBRgMFPmqYp3vuUW8Ujcoi84yKDgv8vK4GQ?=
 =?us-ascii?Q?aRFoHVpR+CrVJaFSBHw4IB1u73k3xCMo0sXHC20t0pceOrBAUbYDnNtGy+pU?=
 =?us-ascii?Q?aeg/udIcIOhrCvPphW9S9dG4cdnymu0Lfsyyi0FqmXnVAX49VR5KZMIyHmpV?=
 =?us-ascii?Q?ZQn9nh2a5g7vyrLZ3sXCM9nEUrtx/XC0bb6HTqFO8tgGmFIjhXrbCSKfy2rK?=
 =?us-ascii?Q?s8utQLovN0tXHlvKcvSaQVuneei69W6Eb+SMierKcAa1E/Kz7EZ2PjjHGLu6?=
 =?us-ascii?Q?KiE1lslXOKaXy+yvQEoVFOOialejVKl2VGTd+9rRNpGYWlhkFAWBUEVULpxZ?=
 =?us-ascii?Q?2DSgeV0jr+b/MovcRbKEKZ64mIZe0drMm1jXpZABwuovx6yB9aynVl0+b1i+?=
 =?us-ascii?Q?cLF/gwlaFlEu9DNEtp5NJChhVCBHHUG4XVl/fQAZZK7wb6oEEwfeIi0N+dD0?=
 =?us-ascii?Q?fFROj5CSSYkm+w9Tjd2NeGDDuGN9QJC2pqjvMOsC2FqCNUTsgFenUncjnSwN?=
 =?us-ascii?Q?u1Q0IJ4SnztYBddaOL0Xc7ph/rHhYh45t4H7fX7hIYbvLlbCW8TOgdIUl24o?=
 =?us-ascii?Q?okBjbK7oe+KPWrZ793qyhp7/0aBCC568tRWi0Qto7BwlH+xDzyvtjuHPffhq?=
 =?us-ascii?Q?YF4l4ygviR5owluL6v1aVDI93mna3C+wesV9Qjzd0XLMnhEzLgxi/9EQPa3r?=
 =?us-ascii?Q?LXs3viHUxdlZVt8Me4Yv00PeooG9GFbccCgjhK4r5+DxDCe4ZOJ5tbq1a8XL?=
 =?us-ascii?Q?RrCjDDTKrEl0IgHq+Y+tdkwrRF0Otl4nqRHGozLdwtiN9Uxyn8p09Zn6hUtQ?=
 =?us-ascii?Q?cKV3hSQk/v5cUEMKsSVfOuur+mFvl6ihv283QV0CD6Mq/+xbGFG5GQ32p1mv?=
 =?us-ascii?Q?PqRhMKtv+OvfARMui1VUlXdCnzFwAuM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d6a692-a090-40e4-e818-08df1b3010e7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:56.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAQyqIX0XS65NfeUnCNL9tUhq4FNsuEWhvvfjHw13GcBrpX8Mh8KiMEGfQGSojzqJtCFJ6O793y3K3f7UA8vpcrtP3Xk7tJVuG1Px1W0SZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24354

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


