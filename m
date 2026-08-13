Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9509C5DF6A
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16256.1786617571831620592
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=g09rxU6B;
 spf=pass (domain: siemens.com, ip: 40.107.159.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxgCmU8OHX1MxS4NHJg8O9M7C5rqWF+DLFRTE3c2tf7hhE6qvAqccWpXbfXJh9K31KXEzxg5FLgckr/jbYlYd0hOGVxRU2aiX8PSNAUgEQBWrnBbsODkdYn40OM62ebnlavPnMCTip26c4mzNQUVDFD40UYGHls1feEN8XDxizQfShy/Odi4WJVgFI+ErKrDXNqkGhQ3bOT/9NzVwcqROq9d2vyPNX2zTSZDqAg7xLUierHwghK6bYABQ/BUwxeH/YA5dJYTgCZDKKLUgpuc3OxzZ73FCL9tiDlgbsJe1JnU0xdkVdBoXPrmblV7CXM3EeppFYQr9BwEqIGyeNgIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUtcYiU05uauCRnQxpMCC5TGopI0iT87R1X+aKjhHyk=;
 b=CT0v7H3c2En7UtxstNbhzLeODqkrL2RTWoqd03T1FMEF15vHb1T5LLLaz1ABuYZmyuyQtCzRVg2sjsBedi7yZGhNqv0qQs46SJkQJ8TXnLb0IRtpp3hpCVCVZIqkfi4shDuJeDBHU5GOQyKaPGsqulDVPHIIik5Q6gw6U/yTuiDZWglH0Z/He6WZ7hC/+yGOV8ACX6lTwhrFGgq4m54db43JIjkZ7+BrpFkdK7Q891+VeJ08WJLVrJbsWLKZ+mYj+n6Mg3pDDBpdbhRKyKTA/Q/0W+vti0MVOJj1OMTwjS7xLRjHWOOWPSTLeRkHw7dxlw/eb5V9xDa3nmOEQFejIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUtcYiU05uauCRnQxpMCC5TGopI0iT87R1X+aKjhHyk=;
 b=g09rxU6BLfHbZE864CzCeucjmRl7Y1GCyB7L3FjkUgrJHun6Bcwv13k8HHYzG/IQeqSpeipcku4QGqBN32BqzJqtrXMPo2dFl+YHXkOaSrVXa1iPopz52iJLD6E34VacoAc37QpqOM53Y2vgyeaq4QLIOEEIg1ToZyCiEiX8tMqwVpcFEBsPsVztaLCv7tU/JvFQPgixvCiQib6i51wOogwoyYBWSgKS3GhfV0s729hvy0fkwRxVuUfOqZTrANZsZcBtyP/GuKRlTi8rxwS7MjwKpRknCCweS2UgUCXg9h63dJQ3Pbug089FjdXHcd531Er//0Y0CPUQ2OOSBWlBsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 10:39:27 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:27 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 01/12] Add doc/README.cis-hardening.md
Date: Thu, 13 Aug 2026 12:38:51 +0200
Message-ID: <20260813103919.184402-2-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: cc66a394-e50d-4887-5a0d-08def9272634
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|9063799003|6133799003|56012099006|5023799004|11063799006|10067099003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	83DetRAR48jptTglqW6I5QdAaM/3AHZjsT8NrZiD8acpLUciX7wWyDhV2uKzV3sMVFgp/1wqil8+jqpfajsji7TkzunOxeH8h0FAuuA1+OhaBuVQyfuL4JJcgwvkYBLCNcB17gowWDRiGtkj55eh+GIYmzM1Cvq9rHSqatZpc6plPqzIPvvnuEO95Ol9bUqhF62uZ0xQll/F3nZFIOEssNHLMZTbESJvoVSl/2PrjjJikVwNy/8uCEaUaT7QdaqUjUNw+iSRiE9UynQXsA3fWDp4JFQN19qrZBdKLoB7cxngSXvQELTy0Pf0T6guLZJEx5wKQfS5Nhv8j3DU0frj6h/yNE4VFoh5IVA12+3EihtT6Kwcj3ySzcHKHWO1j62lMrXwlhPSytIBhwzc5uUabcOcfDNGtj4UbPbwAM6DplEd2TXm+IpWa4N/7X4TtBqvU0CU2X6QVSbscDrLOLI+Gssu60Amep3Sb5FrUeR1JMtbwAFpiVlLI+lBFbbj8/CPgAIr2C/wC0esZQwE95zVegHkp/dHuMNIKkvVgKoaLCMtzXO63lktFOEMesbCu5V/MnK8j9bviDlS7CYBv65g4AVfulDPgQBRgGOd6DVtQeGmxF6FXYeQICO1XNh9wsxKpUYtlHVI4rYvKbk2dfnsdTGFxDRWeW8NfNtYgUMKQ1s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(9063799003)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wXfV5d80v+15l9SCLqAy7t5xrMVkC02hBkesB9gkAQq1wdW5+e1Pnzw8ac6Z?=
 =?us-ascii?Q?15TZCB5EKz/fW/AYQjO9kiSazT6P+TK6Gzj/oN/IEG2QFTJikJas2aq0weoS?=
 =?us-ascii?Q?i/V0VWp/O1s5ck9IzdX/tqFVzpK4UyGQdOSbkED/OKDZtwH5bf/tni30vAs3?=
 =?us-ascii?Q?+UrVRxuy4SOgfgIL4fXc52gXuru/S/RmfQ4/Rc99aQM2VTlYgw4YXj9wxsY8?=
 =?us-ascii?Q?L4p3D9vnRfbqqAS4PW+Iq4ukXnMqV6S4cAEWv7aLYVh3GWeKibFbpLpWlYE8?=
 =?us-ascii?Q?lzRSVPh37zYXtsAl/zQFCt1QwlGk38GjKYn7cj8eFd3/r0Udro8sOgpBFUnd?=
 =?us-ascii?Q?xfpmNDzyGFFqT3+bRVlgMDsW0P2ljpXlJ6/zbJVUILxuL9lEA6u00Ez+CrrM?=
 =?us-ascii?Q?35RYYW1TaijkF9ZR0qKhIWtRhZw+rZAAArFD9IGtVlFX9pCk+qKNacWfFL9p?=
 =?us-ascii?Q?nfgaS1K0B7PI1RW7BhA1rH+Hqmv6581/LN02qDvWCiqNF6FRT8WVgJA5d1q6?=
 =?us-ascii?Q?iY8oe2IDk51+W1idphYqVvLFr+HUWRsv6gamjCTDgZ2JWUOUvo1yUsJBfn84?=
 =?us-ascii?Q?6ZMPijxOlrgi2/3SHhGwijJlhlsrjI8ZrE7KfoL5rPvzqVMDUSkhOoUTRV0e?=
 =?us-ascii?Q?caBJasWByrhy+T20LJwYxJwvGe8widSs16QGKleoGIIYq9s8oCQ4n3YJTlRZ?=
 =?us-ascii?Q?WWJH0jMtFFFgEAbz5WGdu3j5PTpnluz+4YPB0HWOyMkZ4/zgl3x90ldXLu2a?=
 =?us-ascii?Q?6GVKOl67o2PNNtKJrJHQxffifG7UEnbKDj4GECxN0h7QMpM6URyFvNsvXN5F?=
 =?us-ascii?Q?9AcrpAjBLJoNYCOtIQ9cc5P+nOC8ohPR9RFoOoUzFodBorPunaR/DeOLRcM2?=
 =?us-ascii?Q?QbqMky/5jyqxto1/49ILcgzIi/b9VYgtUOYHsntBzjkb+1fY2Hr4XTJZxoUi?=
 =?us-ascii?Q?JxbXJ4pZmEMIv8NhXxOQqj91s4x9KJSj/Q+//RTZ5ifBq5ccdV2qIf6jOGLX?=
 =?us-ascii?Q?OGhmQELHcAWVeRzTja8Q3M6pOJlC/e7pUzsl6W/JktmIGGoJu7Fb8nznYtYC?=
 =?us-ascii?Q?J1D3JxzMn3G3Kk2ItB/BZ4O8GXKEuMHFtAvehqASRQfmv1+s81AcQiHvB18D?=
 =?us-ascii?Q?geQHXu2p0NUisxPIABEpojG3T9vBjF0rBOH591adPjVpwCy7xPLMBWh/dNqd?=
 =?us-ascii?Q?wjJvGZMMPzbT7lq1rqbVUSOv70rLJeN3b79FxkWCZKBBWWyTXPFPgyDqH3GX?=
 =?us-ascii?Q?rJqwvj0tkgxGZfj9YG6rAmcOTaxk81pYuopynYFm6fHbwNakZT4FFOKouv/0?=
 =?us-ascii?Q?7roUe/Bg1FqMbpmx35SjE0XxQxHkuk6aHqtlY6d5e6aBRWuvOONwnv61Ylwv?=
 =?us-ascii?Q?u26iGuOZNIJaHAYfmUxycB8163knJ+tRGs7h9rwoqNZ8bcgYlOCb2NddPuOk?=
 =?us-ascii?Q?zg9RyGU6pmkuF9ferJrB/SzMH6PtWT8XSDWdGKL+OBpJbgvMCQ82mIqodNM8?=
 =?us-ascii?Q?bs5OdDHqA8tKZ8T9WsUtd61fyDEwvRLYUGYl2GqYQKwPutrniHPQe38X2PFH?=
 =?us-ascii?Q?MiUPzfOjmVy+xk3yQbBdqtrk2MLd2HLyGkWECCMZKj9X/07PuwNNuAnSUKii?=
 =?us-ascii?Q?yqeboGChLGG2MFhrj225gW2AW+Gg3lYfrLLKVh4709sU269LwBOmgTBz23x2?=
 =?us-ascii?Q?xldQozfbtMAxG7ZcP/ZfMeEc0dPM37sHwJ3ZkuaBfMLfwtLA6uTiGLDkal8H?=
 =?us-ascii?Q?+hVJoBs03bADOn1uVdZG0E++1s5ETLs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc66a394-e50d-4887-5a0d-08def9272634
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:27.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycz+aDhA6DZqWHgibJh4zL2c52wrjEi8nsOIRvaEOZdyyHTX6A85ZCih7vIIGB+Ku9zezS9dEnz/JMdzSH8ulIAfAXGcIircEdUkPYWRvqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23917

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>

please-sqash: improve hardening documentation
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md                   |   1 +
 doc/README.cis-hardening.md | 229 ++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)
 create mode 100644 doc/README.cis-hardening.md

diff --git a/README.md b/README.md
index 0c797f33..7511bed1 100644
--- a/README.md
+++ b/README.md
@@ -59,6 +59,7 @@ The following topics are in separate READMEs:
  - [Update and Secure boot signing](./doc/README.signing.md)
  - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
  - [Factory-reset](./doc/README.factory-reset.md)
+ - [CIS hardening](./doc/README.cis-hardening.md)
  - [Release policy](./doc/README_version-release-policy.md)
=20
 ## Community Resources
diff --git a/doc/README.cis-hardening.md b/doc/README.cis-hardening.md
new file mode 100644
index 00000000..de2087de
--- /dev/null
+++ b/doc/README.cis-hardening.md
@@ -0,0 +1,229 @@
+# CIS Hardening
+
+CIP Core can generate and apply a selected set of CIS hardening rules duri=
ng
+the image build.  The rule catalog is derived from OVH `debian-cis` and is
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
+  but skip the validation support. Only validating is not supported, thoug=
h.
+- Hardening and validation configuration must be overridable from a
+  third-party layer, for example through a `cip-cis-rules-config_%.bbappen=
d` that
+  provides a checked-in configuration.
+- The default level `2` configuration must harden all generic settings.
+  A conformity level below `100%` is acceptable for this default because t=
he
+  remaining rules are product specific and must be completed downstream.
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
+- installs the `cip-cis-rules-config-${MACHINE}` package
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
+The menu writes configuration to `${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.=
config.json`.
+To use this configuration for hardening it must be copied into `cip-cis-ru=
les-config`
+and added there in the `SRC_URI` and `HARDENING_CFG`.
+
+For product builds, copy the generated config into a local layer,=20
+
+
+```
+FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
+HARDENING_CFG =3D "example.config.json"
+```
+
+add
+it to `SRC_URI` from a `cip-cis-rules-config_%.bbappend`, and check both f=
iles into
+version control.  You can have multiple configurations checked in this way=
, and
+select which one should be applied with `HARDENING_CFG`.
+
+The JSON format is validated against
+`recipes-security/cip-cis-rules-config/files/scripts/config.schema.json`,
+whereby `apply` controls whether the rule is enabled.  `justification` doc=
uments
+why a required rule is disabled.
+
+## What the hardening package installs
+
+The `cip-cis-rules-config` package is a configuration package.  It install=
s only the
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
+- `config.json`, the selected rule set,
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
+from the kernel fragment and should carry a justification in `config.json`=
 if
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
+With validation enabled, `cip-core-image` installs `cis-validation` and
+inherits the kernel hardening validation class. Validation requires
+`CIP_CIS_HARDENING` to provide the selected CIS rule configuration and gen=
erated
+kernel hardening fragment.
+
+There are two independent validation stages: a **build-time** check of the
+generated kernel configuration, and a **runtime** audit of the target.  Bo=
th use
+the same selected CIS rule configuration, so they verify that the policy y=
ou
+picked is the policy that is actually applied.
+
+### What is validated
+
+- **Build-time kernel validation** verifies that kernel options the select=
ed
+  CIS rules require to be disabled are not enabled in the kernel configura=
tion
+  that ships in the image.
+- **Runtime validation** runs the OVH `cis-hardening` audit on the target =
and
+  requires full conformity with the selected policy.
+
+### Build-time kernel validation
+
+During the image build the generated hardening kernel fragment
+(`${CIP_CIS_HARDENING_KCONFIG}`, deployed to `${DEPLOY_DIR_IMAGE}`) is com=
pared
+against the kernel configuration installed under `/boot`.  For every kerne=
l
+option that the CIS rules declare as *not set*, it checks that the option =
is not
+present as `=3Dy` or `=3Dm` in the built kernel config.
+
+A JSON report is written to `${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_REPOR=
T}`:
+
+Each kernel-relevant rule is listed with a `compliant` flag.  If any rule =
is
+non-compliant, the build fails with `bb.fatal` and names the offending rul=
es.
+The validation runs as the `do_validate_kernel_config` task, before
+`do_rootfs_finalize` (`cis-kernel-hardening-validation.bbclass`). It runs =
only
+when validation is enabled.
+
+### Runtime CIS audit
+
+On the target, the `cis-validation` service runs the OVH `cis-hardening`
+audit (`hardening.sh --audit`).  The audit checks the *selected* policy ra=
ther
+than the complete upstream rule set:
+
+- Rules disabled in `${CIP_CIS_HARDENING_CONFIG}` are converted into overr=
ide
+  files with `status=3Ddisabled` during the image build
+  (`generate-overrides.py`) so the audit skips them.
+- SSH overrides from the hardening package are mapped to their real audit
+  targets at package install time (`postinst`).
+- Non-CIS rules (`99.*`) are dropped from the audit (as they highly
+  opinionated and not part of the CIS hardening guide).
+
+The audit runs in a temporary CIS configuration tree on a tmpfs mount, wit=
h a
+bind-mounted `/etc/default/cis-hardening`, so it never modifies the runnin=
g
+(and possibly read-only) file system.  It succeeds only when the reported
+`CONFORMITY_PERCENTAGE` is `100.00`; otherwise it exits non-zero.
+
+- **When:** during boot up the `cis-validation.service` oneshot is trigger=
ed
+  after `network-online` is up.
+  It can also be run manually with `/usr/bin/cis-validation`.
+- **Why:** it detects configuration drift over the lifetime of the device,=
 so
+  the target remains demonstrably conformant long after it left the factor=
y,
+  not just at build time.
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
+### Comparison to `security-customizations`
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
2.55.0


