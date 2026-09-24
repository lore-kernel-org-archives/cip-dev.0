Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA0C9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=agT6m886;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P61Pn22zUjOhvOVAkJPKgFWyouRL0JubmO3yxvMHSwje9zPUBx21aYNwvyLkTz/3uFY//1PN2Daru0OZ2ljxEUVPrCDt+wF8iifEILvNlI79dlnxyrlvntdKPYmbDaEUIQUrfHrUkrcmC/tqb8NspXGAJx0kx02jR8si6Rgp2/u8BS3fA0htj+t+dIlZWF6KBZ6tZJ/JO+SoNu8kDJ1KvjATTRN/e7W68SOcu5BwpcZKkL7x7+lMlMLs0Vjxwf9Pgc6PtU3Phoek3GP2ZajuAUOgTwcO2wUB1FMGZHVJH/EAhejb4OWOHkVsOSgfX57/Pu/R+pGVSU5sgKm4V9OoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=YK3lqc7rW/ikuBC7mmHLnXHrYBhjD3jJc0FuOF1NrhTC5uHk+7HAbIPgOAgRmXHqZzcxU8+5PhmlPPIsWi8pBxfrNaTmMsOL3wRqYpQBekrU3NoODY4hYzUqGBfVpcfu/DbKNHyJ87ui0nurbGYQEleNVsTYCdQ0rQwx2WOgbfZVMPAj7jAB2275LrGkNe9hJyFMI6NhcND6p+af67n2gbSRnNBTlftvLhs1sQxHOjbGTqC7Hw+POZ0G+bwcLORyGpza47S38sInFa3edAdmx5pbofa2z5/QwRPA47cUSUBwrwIeGc4p07cYTqTTHPe3b+dQNGszFxylQhUN7dBmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS5z445dyKs7qlVBAyEuFL6Zcx20WaDeLcTmyRduEw4=;
 b=agT6m886uFJz0Fh/tVzp2kvkATjmdgt9bVcVkRa7ZW0ONejcLGhTxzA4aI8IN4WR5k+Mnl25pborcCgL2cbrFMGKc8fEPMDlaA6DQwf1XkwKhK68IKvySjIt8xcp1iih9MEpDRyNRQWfaz5G8Ui/OvVTM9hd670cPMfZncg/yXUoOK6yuiJeGMw2gOxVl+V0Fk5HrwK3V3pqCueXUJd0QNf862pIR9QOUb17Z24M9Wmwz8NxSDB12e3wN88Q8H3SGylygM2rgL6n6jhPgMWIlONTtNiRTGKjnk53eF2vo7qmZq/5tn2YBeV8Gpf6+353kOCNjmvITv9+85fDmhKJQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:36 +0000
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
Subject: [cip-dev][isar-cip-core][PATCH v4 02/14] Add doc/README.cis-hardening.md
Date: Thu, 24 Sep 2026 10:12:11 +0200
Message-ID: <20260924081226.2844456-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a261140-b788-4936-8b98-08df1a1396ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|55112099003|9063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hVFaMoqexjnJX6o+dZMVaxVy47nW5TD3Z5wEv7IrmN+deYRoMZD6DFvcKIrwFhficLdmbMAQrxCmYCPt4mU+p2D9z1zIO2sMwLte6sxdcd80I6fLsCf9vOnx4iZn3K5fwXDl3wFY+8RJx9mb3mO+flHqWoDj2mCAi5wgDOPNCYP4eXP81OJziKj+teMAPGeJ4b9iV01D8weFcILwGkucL7RoV3Z1C5IAMp3gU9SmdttTMXgg5KmGdQa+3s+q6JEiQ5wzFVU8wD0qVzuGBHu5QpeKT3LWUAD9ILUCmRIgWQt/LAsX5UxEay6Wk7iZCkhNmNItqh/ZcAU7zblDVr9z1wbcAxWVS4zAPA/DHCncRf8lvSrVHxJOkyGtaxxqa2OoPkKPgL6d95aoLSJTjKb6Bt97ruRHraQO9DktC+yDTHpJ6OkPg++vtuRkbvcZt1K2CHBSM2it5JLa02K52EjfU+tu/R5BqT2006r0y1zE6LpX1ZCoW22rVUJ3lBZdSd/wfaQxwC6718JPNidZte8NTmDz7fdRXmggmSrBBn4ymB/Unhvjx9jkA5xDvUYBdpDFXcnOMdAZqJKBf4h0CkZTvaLp5KmnFzVlhVAs51WwUbkX2sGGjfbpcvihhI0IQVhJlEa3UFN+/XRUvNRoeVT9Kci2d2leygqyZHEB7W7Oo3I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(55112099003)(9063799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0rSetJcdjXonbyL9QGw9mNZsRa7SGVZg+ZSGIulR8ZhpPUUH7vQK8Y7WoMif?=
 =?us-ascii?Q?vBOGrIhuGdIDmU6z8MmJ9rkjm3vQimQqzW6iRYZKDtz4qOcHbnMt1FkNRTn7?=
 =?us-ascii?Q?WWG8DyKx2njektDho59BkQta1sNPU6zB6RajJNSIKn2EOqdQgo8m3hhDicNM?=
 =?us-ascii?Q?ieieuK0HQvfqNoZ7YobGooum1+ojTGXfaGJ2QzyR45E+I1OcuuE/F3iRq4Qe?=
 =?us-ascii?Q?ynZrA1FTsFMsZ1qB8LZYvBl2Oi+s6agakXwkx57rLOi1my47VHovbWPHdHwI?=
 =?us-ascii?Q?/ZVSiE1Xaqz8W1V5RmilaeHpv7+s1VykwkU3q8qLnjDRUUalGG5y/huv1LiH?=
 =?us-ascii?Q?m67dxGTGAPu2Ya0Yp5ujMpOfZ5tLlNOIqqo9SnXdpbK0jApb3pP+MP9lp0zV?=
 =?us-ascii?Q?Q/BgdUMNRFGpPnMDI6k7a8AhonNAAVteZtW5duEJryDkQsvZVjKAsvPUu7Sm?=
 =?us-ascii?Q?f69cXBfn5R0M+mlGFPz8f+4/+w2cuteW7Dqles0OOQPWbC9/Lk+r3bl0DJvo?=
 =?us-ascii?Q?JWCxQ0uP6bUI/q19JsblzvmNRXZ2mNTs+JUoyksEXeNib3MJqgwZqmdfVKm+?=
 =?us-ascii?Q?4cm4DgLbC2VYa+mOnas+l9B52hadyN5oeJRdnjiMTFHnbJedXvLqXS3ncSrG?=
 =?us-ascii?Q?rslYw3DGpxP7LqfMffUuYz512oSOj6xAKTM1IdjTOhAg5QV6HR5GNqtP+JDt?=
 =?us-ascii?Q?cdxWFyU4M22EelBlvv29C0iytpae236Gi8gnVib9sbS9ejDQdrNsm2FFP1lf?=
 =?us-ascii?Q?nJLSO0F5ZlacTkVpP8c9cDGIujHNNjtFCaVLFUNYTtskr6PkHAYMcbeSyUhr?=
 =?us-ascii?Q?rWfovP1/AF+gp+G7Ruu9PumomLOCl9FOOaga+RUFMz/m/a/udVLJsYwet1iO?=
 =?us-ascii?Q?vr5WpJqUolU1IMu7zKUMoyVmRNKZP9FqCCotDM8qYcf5Qw/49+tItvA4/foO?=
 =?us-ascii?Q?wDEFCgyjAAq4veS5G7KTmSyPveDHcUJ1nB+cPBnv77f2FiDbw2HmXMjrLMVL?=
 =?us-ascii?Q?oKsI53cRUAIpJBArFF3twDTGIC9L1sxD5gJNH/6VG5HerJwJ/hJzvM1aZEct?=
 =?us-ascii?Q?RSCv7eqVgkD1LbszVJewFIzEU8m02pcMuP/Gn06Bl1jk9jjOpNaMw+EDWoQD?=
 =?us-ascii?Q?PFGlJ7ZsOGos0jsHb3LwA7oL9/OqVfEgz40HSqOjXlbFfRLSqkuKhYnZaizV?=
 =?us-ascii?Q?2SGazgE76bd7RrsiSZbq1dtDFuKa2HXXJvNtAzRrFcUbuGScem7HRVI7iDYh?=
 =?us-ascii?Q?9uv228RdJtKB1t02A3V4IvE4CYd4gaRaRWGEF18k0cIkfQ4I6Kd/9sBNaO4y?=
 =?us-ascii?Q?PdHPfmQBLnbhpuFLMXnLzgtEkGLrBX9umVTmSDnurT/AaAWihpUMMC1JTyng?=
 =?us-ascii?Q?UQ5fAmO/jtzvtAosJf7ViwsGE7MVz06LIyBYcxnPIgPqwhvmApBj/VK7ywT7?=
 =?us-ascii?Q?3hSpMvHdFELlWT9Vj8VxHSN5mRm+QoItnRmnQdFL+90h5Oqd+5DPddWJdLY8?=
 =?us-ascii?Q?ndwbdSFWDw/nQmxeiODEPJxrH0221cD4+4V1elYbeOMxCRVYfLo7pAgPQP0t?=
 =?us-ascii?Q?xQJoaPEiY1yFafMuuAWFnA0JQcVZL6CzERxWKQoCk+vgHm0/YR5Ue/japYTX?=
 =?us-ascii?Q?DlyniHcNGY45OCeUCmgw+LwWMY9f9GO3gmqJLg0vHQ6zO4u0XhVJnom5PbSk?=
 =?us-ascii?Q?nYT3O6r/KghYkL7/bpd91CFLPGAYODSVlE+3ZFNas8k25LIrSfxBAL0N5THi?=
 =?us-ascii?Q?lVyNtoaN/B3XnzaogPKCr5lSMw7HJus=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a261140-b788-4936-8b98-08df1a1396ac
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:34.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP2uDG9q5cvSTYZZzbJBDbe3AZmTiCPRvzX76sdIpELhlOxZJHF8flj0nlu1C6B0laJYO1VO5lQjw/V4rDHEqXgvhm9hqjHQ7+xNsXi6yMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24289

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


