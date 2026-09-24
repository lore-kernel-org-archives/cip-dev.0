Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0047C98317
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:11 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5783.1790249769808718448
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uers+Gbk;
 spf=pass (domain: siemens.com, ip: 52.101.84.0, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrRJd+jPzx4BhH6997HgZwMQzP074zKwQWzMFkPSxPVjnYbuCmZWXZVbf47tn6xPkdcgnleZ/Ud4T2hENcP4INkTO3l0BAGEoLgCua6elygkSYoh2eTJ6EMoJ6LUNSa893MDqldHNwxGNcN6Bv7xE1YTlRkx94AjkGh46tQor2ury2o94fo1kVH6z9InRloVcA3XqoWiHB9KQLelLXWC4Wh0KH+ZyO4sVQIYsd8lAzfim6ceKCZJqTCHUSVTE5/DlKhXvg7lmOnoF6EffI6EWwyAftjhzFuYcuCaKYGErC+QbC7IFTFSQd/zFZgVagurwjxi1DJw8vv6gq33S8gjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=rtfchiE2hDt1M4K5Cw/VJm7m9yieQPhDdPBc55KF+r+6Sjul7GaHDbjspUCUAG1PvyVhLI635SDfdONcYURYBftFeVuWkXmJoIFth8hnonTUabQBcmFkV99k3AJWURk86HMkhEG/DvdbekNNRNdcRJpHaBQNsEmHX0wfntVTyk5FjVOvT1UCguKkNrldplNUqtQEItghI5g0tbNuiNzzz8uqx56TZVX4VzFgEhd/kcK5Cdggnmz/MDO+r/lENHzDv88Av3PGKzTAiWIfPiOK7T/KHH/mlvHqSSdciVIhs3Qu0Nhelq94ZWpgKQFfv7/w7lJgW7wKsdK+6x4r2frIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=uers+GbkGyFC6SCXf68JLBrOVHZYl408RD8/yHRrT7UxaTZaFMdvvKu3e6do1f9jM3y2bln19GpXREWXoFxLx3f/N8W03/K4PF1A7s9A5BLH2pFS9Cf/HpiVt59POX++KnSv+tSzL1xypPwIBmSH3xjZ6ZvBIp56Bi7bq3yhHAuCpJkizVO9VJyNRi/dT24df2kErK26eUIH9LsBf/+sy1C5qQZrwvfit4Gqxa1RPnWbv6ECALyoQeaOpNSRErmMkVj5J/3FvihHr4DZl05N+XM23kQpjGusdXEmF/n62N6PGJgwKsWFHE4KZMLTe+WBN8tfreeBYcLKTnP2j9e8CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:05 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:05 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 01/13] Add doc/README.cis-hardening.md
Date: Thu, 24 Sep 2026 13:35:01 +0200
Message-ID: <20260924113557.3191996-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: a342e45d-f610-4d18-5ea8-08df1a3004e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003|55112099003|9063799003;
X-Microsoft-Antispam-Message-Info: 
	8nPxNkpBR8S4DJ1p/rhcNa2eSOXhsFamPhXK4GLguam+zw574+uyYXu9ZkXXi0ncSoo/yTbLw4AyqL+MLre9TRblDrEwRNjVxjiYRUbgs173KhabFyXmetpWEs2gZoyKuaXz07wE+QwsK0+mwbdjuSM9Yltok+BljdhXnyOG9hSjSaf03CTDQhq6fJZrcWn19FLNAAb9Qk2tLrsA90/CoqeiMohYU8shq5/IBXuaDyjhOIhLbcDqZXjOz/Wg/U3spo5aQ9z3ClZNW0B16Fa0XdXav/LgY/GUX2QIgb9uzBrgUfYnCPAMnXPFMmVhkJShR2OmyPmbIFfQBZh7GRppXE1luSCbnyGlOEcLp/1ohY/A5RLViLJTcmwtOX9TTw69jw6DxenuSl/Ixg+/0cNfZAMCBBfTgz9ijpptkudI6zROKuBtwVyN+uyxJNk0UIcIDhu6Li1xJmN2JeQZE9ndy+vHIqubRfJbCfDKx8vDa9EybshnBtkF4hHTDmGXbkOi3QP7uEu4Z51UNX3oMsA0utzKdo0sh2uZzZu1HUgtjrWs4xdePu5jwb0/4lIAZyHHWdc4HcFVEARTxjH5kqoOE5/Hh8/LMpmzRw/ccehGv1WcvdbhXRnaEonqhkRHNoZgKRd6OrAe5PEJ59URTDeS5wg3p4Gkkl0IhLS5Bf84cj4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003)(9063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K8o7h0vtEI6ooKFQduU1Ku5grB5TrrIADdQTlek9zWcH/LqWWRAtkBxeKgzV?=
 =?us-ascii?Q?s0Q44hO+DvE7rrNqhmK9a2Fm8ogASnHKnuf/8fs/PaBNOsbjmtBC0hpezp/V?=
 =?us-ascii?Q?8g2mtSl0ljjrg/Th5IZqAcL0ugYDV3JWGont+hGJhGF2CVjEaSPy9hh5jiF0?=
 =?us-ascii?Q?JLjDihTbuo2GyuCLdN9VmMxgATV8TEnNNcLAr3JXbGcssWkY8og+zm5ZOhBc?=
 =?us-ascii?Q?jE1GYjIIFx8wV8KISjuuXRnbPuBjRa4InKAzNH7/hBlneu1jhaht8C3Oa+NJ?=
 =?us-ascii?Q?jrU6P8Sn+O4RkzwR42mcl7D8KSOmoeVwWtjzg52OPrAd91Cd7NHNxGyhrHQK?=
 =?us-ascii?Q?wVIMYb22cQcaaS5HpNulNRbGyfKubQTTszQARH2z7bgLXEFIlq5LmzK4OWaY?=
 =?us-ascii?Q?O/1/Qw62Hz+ikSQ6FksLqZvj1sDu6EhgH2YA4FVScJkkB7Qv0Bk1bFiUgLk2?=
 =?us-ascii?Q?SmzzfB0TU8CUPPkL8nQnoKcLYXUr09YNYFeVoXVTakTAJ+++UGUxTCcC/EL0?=
 =?us-ascii?Q?yBC7ykiehRfebBo1cHtAdB1d9wFKcyTL1XesKuxGZDFpWh9a9QQ++noesgOs?=
 =?us-ascii?Q?ellsCnKBWc90IRUpuqvrzTnbM4VtYbITPQ0yOMKhPe4TvCi/RYbmoF4aI0Lj?=
 =?us-ascii?Q?swH52crk4ITQp2y3v9fYRMolpe9qrK89uv6LW1Uv+GqFDnsbUR/D/1KOq6wJ?=
 =?us-ascii?Q?k/OR2YBH6HbNJ/Mq15PfjMEmKN+R5IcS5U6aahFEyeboKZPoZyOF0t+TLqL5?=
 =?us-ascii?Q?oQkFRiTKAA4Fz9+kuDh0v+IMoG3D+bmV8QRdR3P7LxAuX81Jsj3Qy9UtptjG?=
 =?us-ascii?Q?nLMZPsH51Fa8fNSd2JrGNl4W+Vnhcxem9Sa4FcA3f3R4LWR29NL0prvAnJQs?=
 =?us-ascii?Q?u85/jM6FUWd9559lLve0+nkGMPFyHkin3ztqrzEoM8LAYpxyPVoW1UBWC6mO?=
 =?us-ascii?Q?BKrRWxESSHsXNkEVuBlFVPPxOFYjbwoLptPfv33ic9TGbXYefXLvUMQtl4np?=
 =?us-ascii?Q?W6FQTZaBPCk6IT6K+nhjD18ff6Gtry/UKdZyoUYjXxjpqM1LtFQbEPb9KPvs?=
 =?us-ascii?Q?PKwR6DBoghaVXSAq5AiIrsLBsPNM816sbOMZ1HRBrqedE2SCUFTZKjXUebMb?=
 =?us-ascii?Q?xsQvtWlIJzvp2/7fVvu6Sy9gGd2mrkUOoJoNLYJnQLaOuIMupHuuTuqGxaYY?=
 =?us-ascii?Q?MAwB8Dd4u8MfZN3L/bbUycHRLNHgB2aPRLuutMImlIF8dP5tLsRXgM71ZjmO?=
 =?us-ascii?Q?2T9IJIchM2VAGJyhBo4gHQo3lYyrh06mpEfWKMKjT4jUbxB6V9g6rjXo8QEC?=
 =?us-ascii?Q?ZnT0SadI+k2CO9PgSsIzJLbP7dzzs0hR7zDTALyKQm+/MvLpW2A1qpr6qhUl?=
 =?us-ascii?Q?ppHr2aaD1tZ+vveNbBjTQmBu7lsu4kolx/iEtbYsy0lG+jx97oRdVzeddhQD?=
 =?us-ascii?Q?ry2YRdMZngdaTdsBTwhVwp1lJNkyEB7bDWzNe4yWTvGF8ba8+9VkMfpZR3IG?=
 =?us-ascii?Q?S9vAXCLEQM5tafdDrMs0CkZVk5wiDBUhe3V7suORL1oqI6d8l8ho3g7hEGrP?=
 =?us-ascii?Q?R8jGyH6nchnMyG3M3pkr4gtKgf5gokBro/0nWIklxkRfFihy+dZnyqwozsw4?=
 =?us-ascii?Q?/8KoF5ZdOEs2LOKkea24cLDR8v3lOs+V7Art2v7pbnwFISsIsu47kFZIWcqK?=
 =?us-ascii?Q?rjy2i4RTPXc1T68Asfx/PCOmxdALzQSVVkDwsPTjlCxx61ei5lyftIOib9WD?=
 =?us-ascii?Q?2dolapeVP1nOH80kQTNXlid0/MrNDSc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a342e45d-f610-4d18-5ea8-08df1a3004e1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:05.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pK4Vqo32ZnRhXFqV9JF8ssl+sFDmF3Fi831ks1IkrO0LMsI6IPDnFlWq/Og+zgSuLjEh+roh47zufnW9IsKBVbBP4LjQQrwtLeoGDYKvT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24315

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


