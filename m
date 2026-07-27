Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FF0C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:14:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30845.1785158067014203733
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:14:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=N1moT53b;
 spf=pass (domain: siemens.com, ip: 40.107.130.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGJtfs4I8BN6i5gagPG7r6xcyVxPVzZTcX+BItIj4tF/LcdONqO006pPiNs39zYW8Unp5lpXfUSflILJYy13xt88PULVvsV4r6RlSzB3aUmcYIFu/8c1V5FsQTqzIHxzMbHQjKLmC2VGjNpQQVY/B9QMdYBBYCNNWwOU48Yv9JEWRJdaReXTOI8VuZG2subejJ7F2Bxf3ejMMXQgkNwJzi5Bk88PJyz35Iq+oYx9QvULKf9J7V7ho9+HLeD1am2oyupoE0Xztip759zLwtnNFH3yRQCH/KDHCdbE1WaEc3jjVfsZP2mLzhRXE0gPhCfmH94t+jNTIHuDJNlobUndWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ/wEH8StCKmosSlQxngDZ8vHl+eu2IqoXlmpDQFRfY=;
 b=pbMQReeRZLdmBJToau1x5MgUYjEy1ULKRlOm6oRiZdGm6FR/dpX2BGMAs7C8NNFbiYfY3Wgb/IUcKUI21U4wqxyZJLDaHM4LLnuTp1SK9MUJWDohlffeJ3Mgc6vWcRKvpqYTnQAcUwI4yOYqI0cuPCZbDeOp1jIU+QhCsj7Hu9z5tcA75hMVzpCrxdkkR5E2HoK+sZaemkh8X5O0dWpZuUNd5Z1vVBr1eviuaJ0/FaPFEf6kAkxwETAULkmCkfoo9d0PUucEYmyukS5mS7hLgR5VWB+wQnsL8FZfUHg2U3k4Yu1jxUtwF3OmfrT6eYq6Waj9f2WTyaUrsAsx6Mt+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ/wEH8StCKmosSlQxngDZ8vHl+eu2IqoXlmpDQFRfY=;
 b=N1moT53bWAOFu6MguVssfVCG8l19kmVjc3V0UDn/GEnaArCOfTDW+ypP6rEFA+hXWf4rjM833clPSAn9qjtXdyf2ns5kyj/xBxj/fjXnrBV4coiOypyX7Z560a5iCeItiKUm/loUEmV2dDC4cVEJqvNR4R5J/0djLcg3GMO/32v1vomvX9RKjdUJ+qqBXrurh/DXoLJyR92SekLuCRJienOqgVGg74mrYHEXJK7sLX0VYuGLSJL5TIE5/zVvL2WkBHJ3Y2ljhE5DMkRgNTEBVvgt16FH+PnHAFbZm203FWI0jb+KD2FM8s9eTvV778s0Rzmw54QUe0I4eaGkNBGaIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AMBPR10MB9305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:14:23 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:14:23 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 14/14] Add doc/README.cis-hardening.md
Date: Mon, 27 Jul 2026 15:13:08 +0200
Message-ID: <20260727131414.76760-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727131414.76760-1-quirin.gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260727131414.76760-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AMBPR10MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: d25ec200-939f-4ec5-9892-08deebe0f9f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|55112099003|10067099003|56012099006|11063799006|5023799004|4143699003|3023799007|6133799003|9063799003;
X-Microsoft-Antispam-Message-Info: 
	9VTqVEwXm4NOX7lFlbfW7bXLtl8Wd5QlUjORw8RqNmqh39u0t2ln/RoLdvfk9L6thqmriWDoCCMu5rMI/dJadv5As+8ZKrJd0fq1enpzeSL/KbE+xNvozLht9PFT8SXNBTTl3Rp2BFn7xkfwElKSG5kp1bMk88U+IxncyugLPmXVw4QFno032PJ/EXV7kdLHlfT9rdgDzNSv+A0B/+pbFcfOl7MFuBmsqx8pBqwjfvdZLtduVEzrFc7ndEdb4ejoH9pzT+tmC3Whr2KFq8nifNiP/tu5utKFdywSA5P1x31/jJyXFcTiGYiexft+bryDcHhRi1ZzKcSXReqfKjFLG9DPotqC2fPZpajaICJACgYK+zxJXKnBg2WCnmLef/95V6YP9000OOqgprafGlkGjHwzlpH+xlHBG2oyvhx+tZM7NNp1j/nBGJ1JSfkYn0//ThR9IdxhVIoPvc4hbf49Ppzm+tOiUtXOeqvXuETdSAAyb2z25L9Ok9glqF8dOC9yQSd1NkxakNTMC3Lc7SMMp0oAb9I0jJlUQWFcbb0iJPY994qlf2ht0R5YcXd0Rf+BXGAzjzu535td6OnPBO07rPy1Zciff8T5yYpoe4AHlyPacksUI2q5WOCXbKVFRKU4Jv3VbuVSvLPDNo4rq6XHdAH2GeoPTwuQdQ3GFU3CzkU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(3023799007)(6133799003)(9063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/cRaKpiQ5nOtDihCEiCm1aj2wwbRz00AubsU+ph4dzsqvEHvIVRwfq5LsRYC?=
 =?us-ascii?Q?04CJILTW3RV3giCsTyWwVnKK5nvD6SpZ7zgDW8ysciXj0gjNr34FP69bC+Lb?=
 =?us-ascii?Q?uuonSs37AFc1S80XUMUyKs8IDcdvAO4utky5352GIomHu4A7sM37AJR18dBh?=
 =?us-ascii?Q?mNCVhTbeMhrBeq1BQXhAWJZ1EMVHkpSUNEBqq042fpPfy6RPuS/+jCd+GYuy?=
 =?us-ascii?Q?2G3uZBh8UX2gQV73Eo3IdCW0LWH7FiOGj2pVL+1BIVV76EVtY5JkE5LnlmKn?=
 =?us-ascii?Q?61cSUmokaAVM56v8RqqqxESOnu9pBIq/KKL+WXpisbzrlCyCrlGwCxrYY06L?=
 =?us-ascii?Q?McHpdj00EVtfkoctxye5HV8prZ3p+yxtkJrZ/v/hG83QG4eH2e+r1V4hYOLx?=
 =?us-ascii?Q?wv3IfQ2eVSlxJE7SakOheFDwKd2DYMd+bp9X2reoQPB51ir7ES+LGc8FAnsg?=
 =?us-ascii?Q?aVwhTmIoOHkB5JebjDF2cga97gxHf8YV0l3M9Xzu76gjqdKOLyD9S29m+15x?=
 =?us-ascii?Q?NePAoMsQyWS6yi/O4DP/B3hgWnE1U3G3iy6prRCFld7JkHtFv6mi+5byqR0E?=
 =?us-ascii?Q?W8OWXAmsO8YQi9iGI8llsGEPNPp2tZeSHggKnN7930m3XO2HckZsDxrInAeT?=
 =?us-ascii?Q?KGgOO5GF0ZkDY4tpYMWfByBC/UFV2LNV1O1d3h3OM0/NPwsNeucWFaSrpBAH?=
 =?us-ascii?Q?9oi+eZD7g+La6zstenqILbqG3J+kHYpg3pjdrcASm+KVr9C1lTW2t9SxNx+J?=
 =?us-ascii?Q?TKMofqOmlANkPhuJ7tcb2PI+K3t3MojBjPxQZk8mQvfqkW56Yg/PCP5PjfrP?=
 =?us-ascii?Q?0m6oULy4X2ag9rSfMiRA1/n5onSzFQw6EapWgm7waraYaCXbA7rNo8jfvxbF?=
 =?us-ascii?Q?tY9QmeAIV4Ab6+G3op2oKMNfF7aaJ4DPLMahof5YY6iKysDyWR4k1G3wjY5A?=
 =?us-ascii?Q?mosrYXpN6gzNTXDi+RSW9VFb/eYmRMhIdnTrFiVJ6x9DRWdiNlnmTZNXMqV+?=
 =?us-ascii?Q?xm+DNeDvH2Z5zDCd0yPytuyv0clAUc3FEihqwlDKeAygIEUv2l77WL8Y+Lq1?=
 =?us-ascii?Q?RZXCchN8BnPoLkwUE79KmiXaUv2IHIkQkLHqkZPTaj6VjHb0BWr+0vZVkzYr?=
 =?us-ascii?Q?ffqVNesNtFVRLtsGDl9fJ7CV5YcGSDfL5+opuSDNzF6Vn/VavI9AMzkm8bB2?=
 =?us-ascii?Q?C8iInZ2yswc29HJve83fdnRYQgIWZ95chkF7lNwRjWs5aGYKXD4rgQXj8i6q?=
 =?us-ascii?Q?nzEMhkJWofLLjj6rZg1XlCyzp4Jb2nut+2p2kAnhKRFtgptONCLdmmPqXMmk?=
 =?us-ascii?Q?bBrW48v0uxVx3m/UPbzXFcgv9x1L8iN80ypYYKBjM8mwiALXJjpExnnITlJu?=
 =?us-ascii?Q?Rcxj+OILtUjD9sOqAK94E3qvnWumb4EmSlc4yKLXIN4oPnjaSIJqiB3BxYRu?=
 =?us-ascii?Q?gQ0Z+beTafJvBwWnye66lsy1RtLnxzrFKgmVyq+3RUri1ubVvp34nIg9ZSir?=
 =?us-ascii?Q?Yls5Jth6rygugARAXVVODnlHr53z5Rdo89u3kdKTN5bOV9orXKsPJLji2+y1?=
 =?us-ascii?Q?X3YChcCJz/qz5jGA2LZIFL2gzQu/vP5ZIPGYuGdVKAAP+U4CvA10V/TMVUAK?=
 =?us-ascii?Q?rgs7M1+7HVZkwPBx0euxBUTDFFIPQmxNjnn6r3Km3n+DODBSqE85QZSHL1wD?=
 =?us-ascii?Q?6gWYGLWkli+zdUwbcWMlFDPu9jnJWLqilqRffmapTnCuJNVAvM3FMpqmKkwl?=
 =?us-ascii?Q?7ssK0XrcmpRRcBTCwZUiktbkplKUQJI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25ec200-939f-4ec5-9892-08deebe0f9f4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:14:23.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITxsKHTr+AWHUeNxBzciGE+oqaD+uZx8Bu4e34EqlsAJtCdow+Gsssa5m3wWjiV8UUmIgtbQf/MquVh1HwkTpBHWBQWGWLIJ00PRt65X7hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9305
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23766

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md                   |   1 +
 doc/README.cis-hardening.md | 183 ++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 doc/README.cis-hardening.md

diff --git a/README.md b/README.md
index 435d037..f9f4f01 100644
--- a/README.md
+++ b/README.md
@@ -60,6 +60,7 @@ The following topics are in separate READMEs:
  - [Update and Secure boot signing](./doc/README.signing.md)
  - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
  - [Factory-reset](./doc/README.factory-reset.md)
+ - [CIS hardening](./doc/README.cis-hardening.md)
  - [Release policy](./doc/README_version-release-policy.md)
=20
 ## Community Resources
diff --git a/doc/README.cis-hardening.md b/doc/README.cis-hardening.md
new file mode 100644
index 0000000..104818a
--- /dev/null
+++ b/doc/README.cis-hardening.md
@@ -0,0 +1,183 @@
+# CIS Hardening
+
+CIP Core can generate and apply a selected set of CIS hardening rules duri=
ng
+the image build.  The rule catalogue is derived from OVH `debian-cis` and =
is
+exposed as a Kconfig menu.  The selected rules are exported as JSON, conve=
rted
+into Debian package content, and reused for kernel configuration and optio=
nal
+runtime validation.
+
+## Key design decisions
+
+- CIS hardening is optional.
+- Hardening is enabled by a single image configuration option,
+  `CIP_CIS_HARDENING`, plus the selected rule configuration.
+- Hardening and validation are independent.  An image may apply hardening,
+  include validation support, or do both depending on the product workflow=
.
+- Hardening and validation configuration must be overridable from a
+  third-party layer, for example through a `cip-cis-rules-config_%.bbappen=
d` that
+  provides a checked-in configuration.
+- The default level `2` configuration must harden all generic settings.
+  A conformity level below `100%` is acceptable for this default because t=
he
+  remaining rules are product specific and must be completed downstream.
+- CIS `99.x` rules are ignored.
+
+## Enabling CIS hardening
+
+Enable hardening for an image by setting `CIP_CIS_HARDENING`:
+
+```
+CIP_CIS_HARDENING =3D "1"
+```
+
+When this option is enabled, `cip-core-image`:
+
+- inherits the CIS hardening image class
+- installs the `cip-cis-rules` and `cip-cis-rules-config` package
+- applies the generated hardening package to the root file system,
+- adds the generated kernel hardening fragment to the CIP kernel build.
+
+## Configuring rules
+
+Rules can be selected with the recipe menuconfig task:
+
+```
+./kas-container shell <kas files>
+bitbake cip-cis-rules-config -c menuconfig
+bitbake cip-core-image
+```
+
+The menu contains:
+
+- a hardening level choice, currently levels `1` to `5`,
+- one boolean option per CIS rule,
+- justification strings for rules disabled even though the selected level
+  requires them.
+
+Changing the hardening level in the menu resets rule selections to the def=
aults
+for the new level.  Existing justification strings are kept.
+
+The menu writes `.config.json` in the `cip-cis-rules` work directory.  To =
use
+this configuration for hardening it must be copied into `cip-cis-rules-con=
fig`
+and added there in the `SRC_URI` and `HARDENING_CFG`.
+
+For product builds, copy the generated `.config.json` into a local layer, =
add
+it to `SRC_URI` from a `cip-cis-rules-config_%.bbappend`, and check both f=
iles into
+version control.  You can have multiple configurations checked in this way=
, and
+select which one should be applied with `HARDENING_CFG`.
+
+The JSON format is validated against
+`recipes-security/cip-cis-rules/files/cip-cis-rules/generator/config.schem=
a.json`,
+whereby `apply` controls whether the rule is enabled.  `justification` doc=
uments
+why a required rule is disabled.
+
+## What the hardening package installs
+
+The `cip-cis-rules` package is a configuration package.  It installs only =
the
+files for rules with `apply: true`; rules without implemented snippets are
+kept in the JSON selection but do not add files to the root file system.
+
+Implemented snippets currently cover:
+
+- `/etc/modprobe.d/` files for disabled filesystems and USB storage,
+- `/etc/sysctl.d/` files for kernel and network sysctl settings,
+- `/etc/ssh/sshd_config.d/` files for SSH daemon hardening,
+- `/etc/sudoers.d/` files for sudo hardening,
+- `/etc/security/limits.d/` and `/etc/security/pwquality.d/`,
+- PAM snippets under `/usr/share/pam-configs` and `/etc/pam.d`,
+- chrony configuration under `/etc/chrony/conf.d`,
+- helper scripts under `/usr/share/cip-cis-rules/configuration` for settin=
gs
+  that require an install-time action, such as file permissions,
+  `pam-auth-update`, and `/etc/login.defs` edits.
+
+The `cip-cis-rules-config` package installs the generated data artifacts u=
nder
+`/usr/share/cip-cis-rules/`:
+
+- `.config.json`, the selected rule set,
+- `hardening.cfg`, the kernel config fragment generated from enabled
+  kernel-relevant rules.
+
+The same artifacts are also deployed to `DEPLOY_DIR_IMAGE` as:
+
+- `${CIP_CIS_HARDENING_CONFIG}`,
+- `${CIP_CIS_HARDENING_KCONFIG}`.
+
+## Kernel hardening
+
+When `CIP_CIS_HARDENING` is enabled, the CIP kernel includes
+`${DISTRO}-hardening.kernel.cfg` as `hardening.kernel.cfg` through
+`KERNEL_CONFIG_FRAGMENTS`.
+
+The fragment is generated from enabled rules only.  Disabled rules are omi=
tted
+from the kernel fragment and should carry a justification in `.config.json=
` if
+they are required by the selected level.
+
+## Validation
+
+Set `CIP_CIS_HARDENING_VALIDATION` to enable validation support in the ima=
ge:
+
+```
+CIP_CIS_HARDENING_VALIDATION =3D "1"
+```
+
+With validation enabled, `cip-core-image` installs `cip-cis-validation` an=
d
+inherits the kernel hardening validation class.  Validation uses the selec=
ted
+CIS rule configuration and can be enabled independently from hardening.
+
+Runtime validation uses the OVH `cis-hardening` audit tooling. During the
+image build, disabled rules from `${CIP_CIS_HARDENING_CONFIG}` are convert=
ed
+into override files with `status=3Ddisabled`, so the audit run checks the =
selected
+policy instead of the complete upstream rule set.
+
+The validation command runs the audit in a temporary CIS configuration tre=
e and
+succeeds only when the reported `CONFORMITY_PERCENTAGE` is `100.00`.
+
+Kernel validation runs during the image build.  It compares the generated
+hardening kernel fragment with the kernel config installed under `/boot`. =
 A
+JSON report is written to `DEPLOY_DIR_IMAGE` as:
+
+- `${CIP_CIS_HARDENING_REPORT}`
+
+If a kernel option that should be disabled by CIS hardening is still enabl=
ed as
+`y` or `m`, the build fails and the report lists the non-compliant rules.
+
+## Notes and limitations
+
+Some CIS rules are inherently use case specific. Examples are partition la=
yout
+rules, firewall policy, SSH access lists, password ageing, and rules that
+inspect existing users or files.  Configure or justify those rules accordi=
ng
+to the target product requirements before relying on validation results.
+
+The hardening package will **not** install additional packages to fulfill
+a rule, for example iptables or ssh. These use case specific packages need=
 to
+be installed by the user.
+
+### Comparison to security-customizations
+
+The recipe `security-customizations` sets some hardening options similar t=
o the recipe `cip-cis-rules`.
+Because `security-customizations` is part of the certification efforts, it=
 is not modified. The following sections
+list the touch points.
+
+#### SSH hardening
+
+The recipe `security-customizations` contains hardening rules for ssh. Thi=
s table summarizes the differences from
+the cip-cis-rules:
+| security-customizations | cis-rules |Comment|
+| ------ | ------ |------|
+|ssh-remote-session-term.conf|cis-5.2.16-sshd-idle-timeout.conf| adapt cis=
 hardening to lower values of cip security|
+|ssh-pam-remote.conf        |    -    | no rule implemented in cip-cis-rul=
es |
+|ssh-hardening.conf        |cis-5.2.7-sshd-maxauthtries.conf        | 3 vs=
 4 |
+|ssh-hardening.conf        |cis-5.2.23-limit-ssh-max-sessions.conf        =
|2 vs 10|
+|ssh-hardening.conf        |cis-5.2.21-disable-ssh-allow-tcp-forwarding.co=
nf        ||
+|ssh-hardening.conf        |cis-5.2.6-disable-x11-forwarding.conf        |=
|
+|ssh-hardening.conf        | -       | AllowAgentForwarding is allowed acc=
ording to cis rules|
+
+####  Other hardening
+
+The script `postinst` of the recipe `security-customizations` contains the=
 following changes:
+|security-customizations|cis-rules|Comment|
+| ------ | ------ |------|
+| set password creation parameters with pam.cracklib| | parameter differ b=
etween the implementations|
+|lock user account after unsuccessful attempts| - | no rule implemented in=
 cip-cis-rules|
+| Concurrent session control| - |no rule implemented in cip-cis-rules|
+| Audit storage capacity| - |no rule implemented in cip-cis-rules|
+| Enable Multi Factor Authentication for Local and Remote Session| - |no r=
ule implemented in cip-cis-rules|
--=20
2.53.0


