Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11271.1795689023333075748
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=H4QH+Wkb;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEXso1OU6Hca2xY6WZAIl7UMxMboxxc5ALHMb64WfwzgaEhEazkgT/cWFBziS7d1CuebnZdUnsVgz50HI3fjO2fcnN6fsSSRRM4TjW5VDLqLi50eDZSY7g34L5hrh/93pTVv/ysBzfZjqrgwuLxRWsYopD9RkfUW8wcU1yNFMZ00lBxVBU5OTvcQzP7TYLT3SBnSI5ad8hgk/gmLg1YIdiMDgbLKZ8gMt7lEtArMi3gRZf/3lry7tlfNdS6j+aLuf4cIB9pTrwZ1YMA0myIfN6yJ1/ZPnrVPaQWCc1bK2Aly4SYVZMugdW1pzxioNjUK9H//uwoMPGERwQ+u9cQC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spNOkwMKaLfHuGxpLUqciVTS7Y1RV7MYZfDmTtvviio=;
 b=x3mpB1xV52HXc0ClAwAi9XagOUWd2AgAm6NAuoB0PegNWf2xKguBcLs4nIx6y1AYVHeVyth+wAqBJkhlBw7qoitXzyoetVrUsvTZufeFlFt/ZwSECNGmZzXBjQMMlRNOzHlTo4kUG/WMj/uWNpxuoHi/pPtlARaVdudGkNkXnqNt6C4z0fvn+Whxv60ykmy8LWhrc7+z+V+xF6uv+oTHGmXbZwrcGQExtFXe0MkduQoXOFIxH0bwivRTxWM+r95FvKAEnuBvNSEk8/WsfQyo7sTqK6rt8/m504dY4vUjPd6FJ5IonNGMG0Iqv6uf8EFBma368CeHi3Ymq5C8pvUnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spNOkwMKaLfHuGxpLUqciVTS7Y1RV7MYZfDmTtvviio=;
 b=H4QH+WkbKutSOJ2xh2eV3ktgeZuj3QfemjIWCUyOnpUfRJHvxkPD/so/Jho4E4cjV5VjVGVNIt5JE9jpzfZafN2RySkwrgSZ28uzpGj23NCPa8yn45bLmVYTU75k6Fc1hk1MfqJ15i+SJD7PII3Es3CNeIQdkBGTewtnZR20nKzywW1HOkZqHxt35YbnZjQNq9TFL8BmgaQLjv188cSc2j1gnNpAjXiGHVAHE67L88SzbkE1IfzDfBCwg7ctVwdlzbCyLDPR/ttgsM7akowkNfNHBn/gsqPjoGTX59wvvQ+q1ogl/c0HBNk+D1niOvbcQvYGwJEuz0OCIpZ+hnYDKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MI7PR10MB209735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:30:19 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:18 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 09/21] embedded-dracut-modules: add recipe
Date: Thu, 26 Nov 2026 11:29:55 +0100
Message-ID: <20261126103007.2922985-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MI7PR10MB209735:EE_
X-MS-Office365-Filtering-Correlation-Id: dc114f48-c0aa-45cd-0b4f-08df4ba84473
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: h1VokQYOpDIvYOxD9kS50VycqLMwvUmf8m7baag3BbrgAScJCOx1S/knetHz86zrWKIIiIyPEZRqr6v5IucEiW+X6I2lgKu/UqZ6CC/1mrYzQY4AIEXGSHV2Jobov7p2XZ83KqIFWWKlJZRbNg3OYMjyW54bmKTEaYqu5eRzSQjZ7Ub47WPZk51Qy5IXE9s9T6Fjxcpqj6yVYn5W1JHI0vkDpLIQ0ijHpsWnDhSX/z8E0PVX8YAOVJqohO3Ho081hTuQSU5CrZPkg9OmjRt8xDMdJh0fMIYcPpteX3h6vvSuHqol8Bwj8VSD/sN7wpzmFpjKwV+gsOFWunMWmkA8b2qXYinG5O4pJfMRFM4MlZK3CfkVMAY69yUHbChDh3ftgsDsbRrLduD8KgyqFTNVGg7I47AXD5WYPLcifl4mnM9KbXKvgRNXlyNJOEz0EtWZcAdBrc3SF+3ZslV1GCQ9yzaOweYGvmH3XegomFVMCTu7T/PTCbclG55uV9TTFkuRn770o/Jk0nEgdMDw/4nQPVpVBMer8IQ33082iG/pRIDAGiy0SGU9TdVOhEpFy/Ecu29pOw2IPtIU8UD+ZoHCAvmVvNAvrAziBIk+P9jBqoxeqMb8FR1ZysvaR1Owx62Lkh8p28TeXMhtzeb3fuZ8x7PpN8qOEGra2yS4rqfz440=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhkqmYsFjcbyNYlSrOzhkzt+s2elKguZwpLr4mkzi7AiPSoY0y3L9xqKePGY?=
 =?us-ascii?Q?22gxkjsQxeqIk3AAVuh3vfo6Xsofp1fqduR8bYZuyZIYdjL6PkZP3T8WCBK/?=
 =?us-ascii?Q?Yne1WaUVKzm7l3wfTFjsrV+IldCyVncEU7f+BhEopGyiFLM6Bgzj+wFDkwLZ?=
 =?us-ascii?Q?lDY5LZMUdHn6pLNyj4bjP5HfGIhALKICSnxH84EV96nZL6ITem6s/9vCruJq?=
 =?us-ascii?Q?TFv8IvlzDCrE1NQAFxb3//2fMaiLtjtt81X+58PQZPl40t12/j1cc4CxOV7W?=
 =?us-ascii?Q?5fivpTfJUCQTeScDRqx5DXcPVnWsgqm38Yew10Ycvpd55CDA1Xig6gqLRgPA?=
 =?us-ascii?Q?dOPCFzikwrWE7ioQvbx2aULrgQpH3cqUg0e2+7QcQnU4IQC9JJV43AnI3Rso?=
 =?us-ascii?Q?A1u6GEwshaAdrTMm3NaqSeLrg08AAK/f19mcR08ruvZjBLAOgSkBSD0+oG4E?=
 =?us-ascii?Q?NF4aGn0bCHEYPxFvhmWTL2+q980+3S8MPDg6Bp7HarKUWNV0T+wKnBUVEq8Q?=
 =?us-ascii?Q?xBWdoe4/5SOlOSjz6lUTiVVPsb8IunSxbjsj5qCPwGdr5JMOp6ZysAPcz2l/?=
 =?us-ascii?Q?RRF7ZlhMz1PNnpjQMLQl7PKVZkUtjQYzIXe3ToZHea3vjTnGm3I2Z8aNOTe+?=
 =?us-ascii?Q?z8i8L3SPpo6nHNa3ztFYM25FerDfqFFrJiUNAZOVzBAMFP3JVgBC1GtDcJf8?=
 =?us-ascii?Q?CIRfxy+HiUeuWodzFZjWzXS6IUE4VSodAEW3jMynWOMqPZfhSaKjgIqDA1AR?=
 =?us-ascii?Q?gwE+qSoCK2miofiHgjtLk5A96oArQ/lDZkMsQesEN8m9ahGqxvxJ9FwPxaPT?=
 =?us-ascii?Q?Om/hShKz+7iP53Dy0htE7rIvJ9T3aV/mYb4H26L6jNdiH/IcM1+nADS823YC?=
 =?us-ascii?Q?37XT29P3kEWiQrKYLX71gnLFy61sSEyyMuSLF0esNdCcWoSV0nFEqb0koSpt?=
 =?us-ascii?Q?xd7zWJD1lG0mVEUmQ+BjCRz3GAft0EppPDl5noTmJWAtzUVi6VluAq+Z27sY?=
 =?us-ascii?Q?sJEdRfZ2cegOJaIajR3wkTWOwa+TxZpnZ8J4wCnWM2/sQ4VC9LvWHzGYjX2O?=
 =?us-ascii?Q?PKDc+960YeB/f34TkggfzlP5bhlVroWpRcbvniRp7cYYDEr7+gP7m6WS/1Zu?=
 =?us-ascii?Q?cbhpNifgT/eTHmuP9BGqqv1jTk4sEfm72gZJuJNsX3OV7Y+a2pe57MHtd/bM?=
 =?us-ascii?Q?HaEDp23sjeIbHU1h6Wwbjo7qU42whfWcgp63fs2DO6Lbadwdk15K0WhSCUO0?=
 =?us-ascii?Q?ZVpflpkI7iTJvw9HRxqLpqVU7qtNNRtORm54WU8koZCj4jm3xa/Vqv6ImP8p?=
 =?us-ascii?Q?PH++O2HcVNd6LG1+kIQNFtUYxr5kzLqxrU4H3wptxO0k9ZGxMDnJ7QSRO3Na?=
 =?us-ascii?Q?k57BOvSaFX+XakVf/Z5cRR18PeigqtxwVS3StZi/l2OBAR72BOlk2f7HU1ef?=
 =?us-ascii?Q?ulgK0fHo5qGEhOFvksoJ9tyCkHs/eFQx2mGmbgfQaaworfprEmnn4RHnEEfZ?=
 =?us-ascii?Q?A6XMm3J23nM5qPSKOJT5eahYmR6iPh3LRg4IuEMH1jhji/GpwoT3HDJ7s9pW?=
 =?us-ascii?Q?1/XRckGxw9X3NNJGIcPscUg+SMvijLHD+SiczUPSk1N4d2UwIRoxvymgsgDG?=
 =?us-ascii?Q?rJTJlDl4a/v5TN9T7gzFzX0k5IsYZwCefcvLMtwGfcf73B/Re4M++Cylv1yH?=
 =?us-ascii?Q?BmmQArALDYRm69NGYVr3yaedw21XW/FARnY8TQR1GEj6loJ+lx1S7ZS7nakE?=
 =?us-ascii?Q?xCQJbLbP1/KzY1B17GRsqIP5YMfNnrY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc114f48-c0aa-45cd-0b4f-08df4ba84473
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:18.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCjTkHi79uZOR9Rb1W7lOV5s9MppGrSWzViJuimAnXmxV/GGJj2pffd23FqanD/khtwYG/F5UD7F2DWUUsgQVHLA6h8eql53ALEYclX/QCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB209735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25091
Content-Type: text/plain; charset="utf-8"

Builds the dracut modules embedded-verity, embedded-overlay,
embedded-crypt, embedded-factory-reset, embedded-watchdog and
embedded-sbcerts from the external embedded-dracut-modules Debian source
package. The modules replace initramfs-verity-hook,
initramfs-overlay-hook, initramfs-crypt-hook (systemd backend),
initramfs-factory-reset-hook (EFI variable), initramfs-sbcerts-hook and
the watchdog handling of the crypt and factory reset hooks for
dracut-based initrds.

The package is architecture independent.

The source is fetched at tag v0.1 (main branch) of the cip-playground
namespace, pending a CIP decision on an official location. SRC_URI will
be updated once the repository has moved.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../embedded-dracut-modules_0.1.bb            | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 recipes-initramfs/embedded-dracut-modules/embedded-drac=
ut-modules_0.1.bb

diff --git a/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modu=
les_0.1.bb
new file mode 100644
index 00000000..023476e2
--- /dev/null
+++ b/recipes-initramfs/embedded-dracut-modules/embedded-dracut-modules_0.1=
.bb
@@ -0,0 +1,24 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg
+
+DPKG_ARCH =3D "all"
+
+DESCRIPTION =3D "Embedded dracut modules: embedded-verity, embedded-overla=
y, embedded-crypt, embedded-factory-reset, embedded-watchdog, embedded-sbce=
rts"
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+SRC_URI =3D "git://gitlab.com/cip-playground/embedded-dracut-modules.git;p=
rotocol=3Dhttps;branch=3Dmain;destsuffix=3D${P}"
+SRCREV =3D "8f0db0d38007cfca04531f8106721b4da5056710"
+
+PROVIDES +=3D " \
+    dracut-embedded-verity \
+    dracut-embedded-overlay \
+    dracut-embedded-crypt \
+    dracut-embedded-factory-reset \
+    dracut-embedded-watchdog \
+    dracut-embedded-sbcerts"
--=20
2.47.3

