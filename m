Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A60C9831B
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=j1aXYVrr;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QT7cN4wtlH5FULl4NY0EEFSeXPNZbKY+cKNjddthFI4dPY2wMKeuL0++XWzp6qDajCDdaFvd7Fdy7bPKgbmK09Udkg6S2+Z0j6cMl0VGhfI5IkWpSeZryYMyetk45gahI6jKOkpVN4yOylDH+gMzALJNzdUkjNY9QbXGv0h6zccLqQ/gLvoXe0tBmyBzlzYkuOJg/N6ve4k4vPgsABZKgiAHupj3gj00UORl1bWT4YDcJZ+yNHUGQZhRUmPvJ35olPGryeph1/cpWtiwwgxz6Z5ZL6d7KTtezSn+AVjw8QkeL2Jr8pWOmpZib0n6E50XHxjzhDNYGmW1v+ddg7O1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=LDC5j7vFXf6TNxzSWOs6F2mzzUe/3w3ZOajO67neCn6PLnodqM7t+UU99glsibP9Hnf6FpXJc0iDKNLJzLZYKk9z5I7sq9tIPRuxlZW8rXvHCk0jZeUzKbkoo4otJl70wVfXSiCe6of0jHiov0+owxKGVUsK91SOOyZ1ICuqu+e06gIGz26p3/O9K3iQrfIr9FXHJslVWB6HxYAE6lnUQB9TV5yPZgmJAVwn9sfp718yDbFP7y+AF3HrxEd2UbbS3H6kSqBi1wwX5qYRH/Tp3zLb3aGY6utdm+IT693CFGek0dpr9Uxakf56W8MvWqcqYSI8PNh42ZZ7e/+CQN+yQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKAFHyYcAPvyCLqaAA8Lbnq7vny4cl5dlysROGED/qE=;
 b=j1aXYVrr83GURNIxGftAuAMEVtMcUkSZjPMw5Bd4l/KGC7nwHxTNij53ukPWw06Fx5T9T6ZP7/Z3iuFJBFcnUcaGeWhWfTmT/oxx+7B1N3zhefSlezWb0MYqcebN1AGlk97yL9TYdQWI+SD1jHy00jFJeHYIdFiC8lbsBOimIXIF1IPYvKfW6/Eubidcsk2ftbPN8MpYQDgf/iKyxrQjkIYfApi8HYhsr1YsW9dF33hmelktZqHmMFo2twnh6tB8XLm+g7U93S1SXLNsDdJNSlElNTjdgGQNnak8dpbFe6kAS0cU60+7StrMSQyBp5SBoLdtbubnzN0xY+hBscNKOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:38 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:36 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 03/14] Add cip-cis-rules to apply hardening configuration to the system
Date: Thu, 24 Sep 2026 10:12:12 +0200
Message-ID: <20260924081226.2844456-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d01aea5-b50c-42d7-9afa-08df1a1397a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	p7wXzFkikr8YTGMVFwOxs39qcjMBCJnGQZ/K1rlZcmnCkmCqI5U8m699C11b26phcxSysswyS8vWzwv96F0MOX7GjrX9YCiNxR/++/V37naMTI2VRViEXt4VU0YEd7EibOvwp1meTiHTBSJEO/iIbPztd1BjvlIPsNox++vg4cm2MmDNq19k9p+ZiZ/my+aqJOKpYCLb9ijivctZ8D7F8Ca1AHZSJcPt+kyHSkcZES1uZMxH2qTocTVrqP+v0UsJCaMxJFKvDFEdostcq9yKJHOdo+InuykSIrNDrpo37kB3pbcOm/U4RdWusJ7xGglcdw/Y2SNy15GMgNg8v/bHVzdsxwu0Yzwy9QiwUvJ3PrOOSwoVBJvVXiCexs5fB3n5r/FhU6IiMvLHAtDemSrCu1mFzizNqUACxC6buWT6d4SRhFMje0Z+ROIA4PjNaInJk9AJFoKaJWoDTsIfZ0flfybDxC5+yuwAtbYOog726byHU5KZuFciF5iaDmu5LfpPjDSxigXnwyNHDXMRcKzIrmQEwfSXr56Qvf6yMmraUvNnQWGtLX11wjOZxmrGlW9bGx8Gi92HLqPqWRK2ftWJbgHLxGIT0rCy9GnW8tsRfvH60603kRn4d1jsEa5QiyOHQscvyjV8e3VUciV/KWB2juTDhedP0CdiFzbV5k7egMM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a02Iywb5QdCaGx7f1EqiIiHZhjIkqR2ZD/wPkEumQ00rfxNVuTmLmxglNoBh?=
 =?us-ascii?Q?Gih0L1bW1152lGgROe0mgvVleEze0bgBDjLEuUbKKQ2DUTpKEzFKhTLZEKsm?=
 =?us-ascii?Q?lpj0hy8m4UIxjxhvLsA7J+PHkBzB97l+4djzgGyu/FhYhG9OTZIwN+Nf/6wk?=
 =?us-ascii?Q?kFBS/qb8tYlcLQvVVhdQLNfkLMbcRL3RKhZroERpLZDKkjKREXLPs9ADNmDd?=
 =?us-ascii?Q?oU1E2ALPIuRZJ7lZJlNEhdHquteC2jiUaTk+jLqkh5N0xnSTATCewxe2JmzA?=
 =?us-ascii?Q?rVC/gCY7MHC+VfOKsd/txKy+/4gvKaNsXBVgntoU/6A5xwe3b04lbxQcTFqd?=
 =?us-ascii?Q?74WGZ9BdyscPLz6Zp9VTftlgZXXiADaYl8LCHi85wwP8bcaD3Ioks7jqx7MK?=
 =?us-ascii?Q?xMlr/tegr7NS4oJpKsSivEIbE5OmMUOYE5cFURfL/dR8nFV2QySKo3ji+tSh?=
 =?us-ascii?Q?PbSr0se19m153Uax0UDxt22bAzJan2HPvSExZN8yDSykLPLhOeKOKiknGCVX?=
 =?us-ascii?Q?s7sHC2XOIUXjxFEpFMdHigV3g5/UbR1FqP+jDs1fVrhNSbIMUTmgdpCXRZvY?=
 =?us-ascii?Q?CAh6egf/9uloi5EerVtSY91FCl7Z4+VL0fzEDl/l31jJ9zAADdd5tPVyEhB3?=
 =?us-ascii?Q?tzwssclNX5jGlu3ugomhSmB6eEpp+9Qv0yLhKdg+TlpbuwLplX1CFzwzL38U?=
 =?us-ascii?Q?jvU4uLHrFYTA3GA0T97t5JmiMU7Fd66mEaDopEIsJDicRLApdc1LQFGHQtXC?=
 =?us-ascii?Q?VrRqJxeoDUVq00pqBZJ7++zTgKYkU/ru4uCzC3H3Ov6xP5xSew23VsE1VaB3?=
 =?us-ascii?Q?/e5s++MklYn+kRiQnYHWlXCzLrMvFlBaOoqBo0mqdtfOCxa0B3FKzSEbmrAV?=
 =?us-ascii?Q?J7Ox//lnLXcbk2Fwc0Tzv1TOmA0yOTE2OSuTvafqriZGSDCTbqgx6GIaXGHi?=
 =?us-ascii?Q?bNMlK+TRc5Ff6SGfejnvNc6qTDPzjCK/lwXjItJP44DbjTCbEmchEteLIF+N?=
 =?us-ascii?Q?LaQ62vtYSOmkT+Dw9WB4FtXKiRkc9bb8nC49ULYLuDZhnwWY5jiwOy3ZYDby?=
 =?us-ascii?Q?G15qSF07yCybm2/7Wxp/Y6N6ZWhh4ju+DvhsC8PslHiYH0mo7rPCQ1TIWnc7?=
 =?us-ascii?Q?0RU1xg3uudDENJp4ZnlM/tlDAIDHTXBYWXS6nZLOXLM0jaA5wzzF4fsoEnVc?=
 =?us-ascii?Q?dMOGAQHTF2F3sjs96ObuUN4l2a/ErhUSdJakeZWPnDqLU62/uJqzteEFZxdM?=
 =?us-ascii?Q?ELt30vNy9R+Ua8LFIgouXeSErlSylpg/RgUY4Xf928fNxhP+qHndBH4GCAoV?=
 =?us-ascii?Q?X090UZs/8vuMtBfd1idhetLrA/xUwAL4mlog5lS2FCD1IXpO6gfmZabH4MyM?=
 =?us-ascii?Q?kBHrt/qO+eg0XayaUV/R1dJBnGlhlZYs2uctniwdDmMAPgoJKp2y50410Uxl?=
 =?us-ascii?Q?nwGv/mAcnUitl7Kr9t1lz8NhVImRh+feCjhFz3ecIWqdu/mcuYpDEx4JheUo?=
 =?us-ascii?Q?zgmNQBxS5N6b6HU4PcZ3UBjg8oezzJ2+ruq1tcvOcsywWnyv0UgfCiCOFFJB?=
 =?us-ascii?Q?PhASsSMOGu30/+OUqVNCNx8q9LgOh3FE/4wqdStKC4YIuuWN2p5LU/imo1qP?=
 =?us-ascii?Q?u12J0qwoqxGz0DZ8nP3UM1kDCnYY5AiH9wd2vWVphxJ//DcwYCPVCcRqWAFy?=
 =?us-ascii?Q?f4vNzWYWWEwdcmT45s7n4Z6OWkQZtaqWhr6bVTm1o+5WMmRmIzl5n5VJEEq9?=
 =?us-ascii?Q?lHSCgAKfwu+BVCUaMgJ+nrUkUHmSeRk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d01aea5-b50c-42d7-9afa-08df1a1397a2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:36.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDx9C/i8WllN4gp22RpTH8gTvOkYN85JRSfrtbbY/xX04rvx7K3cavvccwqS9TAiPzWd+pqlXDwvH9BvrJhr7A7OKODVu/PvTvgnKD8r91I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24290

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


