Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7741FC9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:09 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yL3aD6AU;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APnbYlsLQXx493M4xUun5NnngKnOwfjpApg+FXTYKtqwDlAKUyiFoevCy4st4O01UA9bHZuSneIeEclmmyFI7wCQjHTdCgHYs3WJcBN5Kozw1B1RQA8HCc8OX84488L6lSZ0S6f4vIFu5HCuiqKRW7ejyYK/iseYl2r3HSFPgi7d1wB3ZGLJcCkrrPRNPQQ8d+hOGwYW/NjYgWsZgCsT8eJKXS0uvHPZgEH4ccNmli8m337JMmZCedw2hcLw6q3YOWEUsBQje+4SwatsOABrP/lz1pEGCufmKMWk3ryoj8nsUaLyMze1KhFGohDs0J1PmvqsTgR6yxcbgKImZX2FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=K2Csg8HNJaKhT5cqiJAJHeAToBE8UgmVyDnBU/HaloJKtxWgrJbWuIRTlOaHNnJvfSAZD4sXsAhRj6V4Ghdmppehz1WULUc8o9qXVvqJM9+jcmezm9yHazcjtKTqfnIB3pRlqQyZuuWud+PCjPq/tGueo1QR0ffwkYiWjdka+Uy5oyv2A6NExdx73AmdPfh8CeLvJjYQds9i0DY+4ROYOThOGKDG0baxT9zTOqjnooH7yo96M+UtH2BdmPOzFoq83Hv1JNP4WaxamGZ3mSiMkXIvrFLXKVj2ostGb+J2W0egw3+czunUPO8u6+tKDaiqsaa2lHYx+6akekMLYQYnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=yL3aD6AUhmqc/z2VnpGwMyJCFCO9MHZecZZkgx+8Qxbk77y8rZ6AssM7L4cXzQZpP1b7kcj/s5KY/W4Rg0f6dfzYkcUB3htGdkVByFCb0W22R63BD+/yg15wmTAvoOjAFlA/vNjmkOsXItR83dQ4Ls7eH8CX9Q9H9jvwZuw4htt9tcEqg8w1Fqxr85+JgroprVQ2I/4oqWmVb+/KrHx9AZtKKM3qrfgaaTdpS7Q5cdJmgm9D4Oq/SSG8B+akKkXm2mQYD04OL3ft8ZBhH8MFb5E1BW7HPe5QtFBFoVcn0THpTqPUuNDGcxwVDzkEATH7hJ02IdRTzrf0heY2hSKPYw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:55 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:55 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 01/14] Add doc/README.cis-hardening.md
Date: Fri, 25 Sep 2026 20:08:27 +0200
Message-ID: <20260925180847.622090-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: d3500f37-5e11-4b5b-54b3-08df1b30104c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|9063799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	xGDJLez8apNV3+2fvlzsg6v88jw9aSJjqP8SKFEoT4ztflC1IXHTEoCcXIvSCtE/LaT3PCCsseAQOxI3ooZMBxm1FXfsql6MprvgEx7DRIZsL8D7UM1Gn7KcLDyYWkcjGrnCnvyWIX21AcnIcgq/AuwP+MwbbUlmQIWZUf5VCJ1r1u9Mxb3pe2roxRDRanLIpCPiFJHVUiDUGV3RN8g7yBPtEwa1UvJvNdZwQHaCASDO8rPueg8cA/rqcakFRbAJNALVpxAK74d+3WJfa1Pgu4ZJy6gVMvfUNoFlhXz1K9nzHoNXC3o3yZbSiA7IPXl+0dU2HgdhywxPYy47VJpnDf/2lNPl8ZLFl8aMGF5NlmZ3xLnWUHpel3kmtsVj4qQUJfkraiE0bra746d+StZNSd0qoyrMqppd6a6Ou9fKqwt/vPFlX/EGiTonWzT3eSyKjC6HBGf8HtcK6f4Jtsb1DGHbTVuBvWo2lAltqMDRajSTnf3rSNThRWSqf5mvtxdwCe+j1ELDexM67B9ze3MPWUPNtdqMuLq38wX9QojudkmYQn1I7zpXSvmcxZIz2WbTkE5gyXXF9AlLgkX/kbOm6pCv7a2oD/jXIRWr8QZVhml5tZ2PjmBG3zlKo51BYUmH1p3bRLcR6ohHRlxRxiJmvXgeEpTGCE/rjkVhfsej8Ek=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(9063799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m/BHVGByAluRjOq0hWZAzc22oQ72tp2XqECCoCnM87cLUJlJTZ+LuvuQ/gbV?=
 =?us-ascii?Q?+B1yrTZFJh8PjyFQ6go92xeAwZtdTu8zbXha09C/K+MmRNJ907QgJSxDob6m?=
 =?us-ascii?Q?rXeosG0l05OjaNJSEOZWIBtbiUfbkT7O72W9lyGNgHQCLNoZFOtOAwNx4oVx?=
 =?us-ascii?Q?057a5ZQhftiG0MUYEc+ALv5RTI7g0CeF2Okr1lKj+hAgAlaU5YGIwz0O3clt?=
 =?us-ascii?Q?LeN3adTgGG1mLzpSYRah0c9jQ1n+BvjzOTxtWUnlT6vV10vQEqo9PAPDerk0?=
 =?us-ascii?Q?UNe/vtrYtdc0MXSbtldcF9rFr2NwrrJtIZIU6ayFhQCBJjeJalKxbqbFYYYY?=
 =?us-ascii?Q?LzAibqXaIxN4SJHgdLEjr1jLdqYigfL6KLkwJqtI7sVKyeqivAvrYXOZmG5s?=
 =?us-ascii?Q?Xbjf3URbIM+CuxaFO0sEIVTUINhJrqEiVnQUnQV3+Nk682KHLKs2YJ7V3S2X?=
 =?us-ascii?Q?eQtHZAXyNjrcENXJXz/enNlAPY8NRpf9LmSwODwKBJF57UvWLXpPSAb3ZzyI?=
 =?us-ascii?Q?cI/PyMpUMDyAZmcUUmasEGCv/ZPCtGnPuODK4mIdjD0wNFUH11H7Lhenn35u?=
 =?us-ascii?Q?I9yrY6UJwwYh1UUiNW9fxB2wfC15Y8LDyXPGZfb4fn1gxpQ0cNpE6frYbSiI?=
 =?us-ascii?Q?UWB7iq3YEEQvGSRHxcKklUJjErHZ9XJZeQ/BQlqRo2kyfl6UOek0lt9k6sRV?=
 =?us-ascii?Q?GOCizEaFVySJiQS+eMLo+7I5bI65TC1FURJgeInnMe+9rMkALGkE53r8sLN+?=
 =?us-ascii?Q?gVIhfR3dRqOIR3toaNx4U47U1f1Pzs7Tj1hvwa/m+XosTuGYLIXf4OH+Lpr5?=
 =?us-ascii?Q?lgC45ihNDpYzKYE6szK76fzQfgBvBHQ5Qz2nOFNZE26XDHZP/Gj0E9aBThlb?=
 =?us-ascii?Q?DGu+278vVQtPsElEz+yLYDMxaRZmY4ixj1/A0LKhpgHhPvATs6w4KRfkvDzU?=
 =?us-ascii?Q?pWRUWnG8kXK63N5ngFPKbZYrbMQV941HUWb2Pwlurr1rdTJRWGIwEix6Z2MO?=
 =?us-ascii?Q?rM3R+vrbqn4MM8EQWTXNT9+Bl+f0eYUHFgJkOd5/0m/QQfnQWJWjvv+5y0o3?=
 =?us-ascii?Q?z4clRAdp0FxXg+oBIFrobPxmm1zF0yXfJfnLpusjzMF5FDhCKFwH/FlRsokU?=
 =?us-ascii?Q?FRfgUiK3pZWg1oWFEgiSYpuD6h5lt3MlTMcWEJhkxmC/A9wmlfsGI6X95kQK?=
 =?us-ascii?Q?kbHP8UqsbxX1mbIqNfMZljfnx1GiAqqgHhvA7d01AEjNM7zITgbm1i9WPRu/?=
 =?us-ascii?Q?PyaaG/aCzo3T/CauosMLkBuu49NR+VvPoI+mPC/2FX5f4NPI1Lxcc/5hNNHS?=
 =?us-ascii?Q?fkIC8Cn/2yIIkgbOEyUr8OmuCvSg34+mT49M91n8ReKpPS8NczM6BcxWkgb1?=
 =?us-ascii?Q?Qx2ruVJKvK2tDtqmpR1m7Q2SfZSsy2pXucJbLbpGDyYv3jU4/0zHCK82DliW?=
 =?us-ascii?Q?oisk2ERT8plp5lgxk32c9PlLF6ulM8CS1b8ONNy91Q39YAo4IZ3icpZ2yBUI?=
 =?us-ascii?Q?uQT7Men76s0lTQXugDZ4GCkW2W0sqP5ajNjeNzPWLo/jjSYR035JlxsXZIY3?=
 =?us-ascii?Q?VKcTY39YvWRml52SWyjW1o3M9spbbl5Z3OWmyfS4gcXQAdzpOwOV3UfIL2D7?=
 =?us-ascii?Q?8uVh+vEAAV+6WsCpkXcjF+sCT5ZYtuRfrtcyEScsg9lPyH/2T9qgyPdR9EqT?=
 =?us-ascii?Q?TTkyXKhuqSx7vpdKCLEmn3SmX/EFLV9Kb0fBU7FsiNTzgkGdRTXHcuXq5CLQ?=
 =?us-ascii?Q?8xQ6laIVBVo+Nc04DrzLiobxB6MzIeo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3500f37-5e11-4b5b-54b3-08df1b30104c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:55.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAqAH2N2Ja4L+7QRc9SPtMmCdrqTWfm5m3vHlu3f+XvqEg5gPikOQvI6g2R5OILQ6SxEppFk5i7XqAefSF7WQaAkFOZBE9KWhdQtzIFHNyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24352

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md                   |   1 +
 doc/README.cis-hardening.md | 283 ++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100644 doc/README.cis-hardening.md

diff --git a/README.md b/README.md
index f84adadc..026ab434 100644
--- a/README.md
+++ b/README.md
@@ -62,6 +62,7 @@ The following topics are in separate READMEs:
  - [Update and Secure boot signing](./doc/README.signing.md)
  - [Encryption with TPM2](./doc/README.tpm2.encryption.md)
  - [Factory-reset](./doc/README.factory-reset.md)
+ - [CIS hardening](./doc/README.cis-hardening.md)
  - [Release policy](./doc/README_version-release-policy.md)
=20
 ## Community Resources
diff --git a/doc/README.cis-hardening.md b/doc/README.cis-hardening.md
new file mode 100644
index 00000000..c87ffffc
--- /dev/null
+++ b/doc/README.cis-hardening.md
@@ -0,0 +1,283 @@
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
+The menu writes the configuration to `${S}/${HARDENING_CFG_NAME}` in the w=
ork
+directory of `cip-cis-rules-config` (`config.json` if `HARDENING_CFG` is n=
ot set).
+After the package build it is deployed to
+`${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}`.
+
+No default configuration is shipped: a build with `CIP_CIS_HARDENING` enab=
led
+fails in `do_check_config` until a configuration is provided.
+
+For product builds, copy the generated config into a local layer and selec=
t it
+with `HARDENING_CFG` from a `cip-cis-rules-config_%.bbappend`, e.g.:
+
+```
+FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files:"
+HARDENING_CFG =3D "example.config.json"
+```
+
+The file named in `HARDENING_CFG` is added to `SRC_URI` automatically.  Ch=
eck
+both the bbappend and the config into version control.  You can have multi=
ple
+configurations checked in this way, and select which one should be applied=
 with
+`HARDENING_CFG`.
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
+With validation enabled, `cip-core-image` installs `cis-validation`, and t=
he CIP
+kernel build additionally checks the generated hardening fragment against =
the
+kernel configuration it produced.  Validation requires `CIP_CIS_HARDENING`=
 to
+provide the selected CIS rule configuration and generated kernel hardening
+fragment.
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
+- **Build-time kernel validation** verifies that the CIS hardening fragmen=
t
+  actually took effect in the kernel configuration produced by the CIP ker=
nel
+  build.
+- **Runtime validation** runs the OVH `cis-hardening` audit on the target =
and
+  requires full conformity with the selected policy.
+
+### Build-time kernel validation
+
+The generated hardening kernel fragment is checked by the
+`do_validate_kernel_config` task from
+`classes-recipe/cis-kernel-hardening-validation.bbclass`.  The CIP kernel
+recipe inherits that class only when both `CIP_CIS_HARDENING` and
+`CIP_CIS_HARDENING_VALIDATION` are set; the check is gated by the `inherit=
`
+itself, not by a task flag.
+
+The task runs `after do_dpkg_build before do_deploy_deb`, so a failure sto=
ps
+the kernel before its package reaches `isar-apt`.
+
+It compares the fragment against the `/boot/config-*` file shipped inside =
the
+generated `linux-image-*` package.  That package is the only place the mer=
ged
+configuration exists: Isar compiles the kernel with sbuild inside an ephem=
eral
+chroot, so `merge_config.sh` writes the merged `.config` there, and what
+remains under `${S}` is the pre-merge staged defconfig without the fragmen=
t
+applied.
+
+Both directions of the fragment are checked:
+
+- options that a CIS rule requires to be disabled must be absent from the =
merged
+  configuration =E2=80=94 `=3Dm` is a violation as well as `=3Dy`, since a=
 disabled
+  filesystem must not be buildable at all;
+- options that a rule requires to be enabled must be `=3Dy`.
+
+The task writes a JSON compliance report to
+`${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_REPORT}`, by default
+`${DISTRO}-hardening-kernel-${KERNEL_NAME_PROVIDED}-report.json`.  Every c=
hecked rule is listed with a
+`compliant` flag and a per-symbol breakdown, where `actual` is the literal
+string `not set` when a symbol is absent from the kernel configuration:
+
+```json
+{
+  "rules": [
+    {
+      "rule": {
+        "name": "1.1.1.5",
+        "description": "Disable SquashFS filesystem",
+        "compliant": true,
+        "symbols": [
+          {
+            "symbol": "CONFIG_SQUASHFS",
+            "expected": "n",
+            "actual": "not set",
+            "compliant": true
+          }
+        ]
+      }
+    }
+  ]
+}
+```
+
+If any expectation is unmet, the kernel build fails and names every offend=
ing
+rule, symbol, expected value and actual value.  In that case the report is=
 not
+deployed; it is left in the recipe's `deploy-hardening` directory, and the
+fatal message names that path.
+
+Validation applies only to kernels built from this layer, because only tho=
se
+receive the hardening fragment.  An image that uses an upstream or Debian =
kernel
+gets no build-time kernel check; for such kernels the relevant CIS rules a=
re
+enforced by the `/etc/modprobe.d` drop-ins installed by `cip-cis-rules-con=
fig`
+and verified by the runtime audit.
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
+- **When:** during boot up the `cis-validation.service` is started
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


