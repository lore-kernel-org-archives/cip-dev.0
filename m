Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C15C61DB9
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13172.1787564853370840972
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sNnEGN33;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiYsg8c8GY6RxpGhYw+z+ioZDV51GcMEcxw8wTRLduy+VXdtboXADTHZPbv5VS/N7MYDPMr3UOhlUtpGtGuV2TzyU8JfOuXg4/KCwUGTpHyQUWtqSOeRQ4QyFWFOdOvvP0C+Iuy9WcO2HeoqInnUHTPkWgj0hXr1p/Pw6iZB2VknNemaWkaLl1R/hsxS7zKCGww/KRgTLp7M13v600UxbTFo85yYBousMMkxFPtCMcA9VRoW5cYPBX9mXhmuVucSxGIU1OizihFV+Gk1C6SR5+hE3E1vRx8bzAKKdPYVYdwaBBsYK/zhJ2kSu8kH+zCYUmj+HGw1RlnUSDPa7sp+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5llynbDu4Xjvzacg7ojr1QCh90AhUfS8IpTfpkbr86E=;
 b=gNsEBQUx97/Bddoau/jTx+iOwEg71qvrFCn/VGGz+n7hLanR09TGeeGKOYl/3kw445jRB9FBejeihfg0LpAzHAaaj5PcU3kCyjYQVnPz3jc+hcrktpRLw3AaZV3OnedGVI3/H/6dd6UG57Y5l3BaNmZnUYX7TnNzOQWTBJWbdZk7gUUZZlU5ZKst5AX0q5rps+HeWoNJhj722az+xsq14WIL6KLr8MOJc/udYnm43XlI+DgZPyYuMHjKrOJ0aCqVlUyOsQAAUqh00Uwu8U9TOOndPz3SHYGFKMtDax2ixW9YcpOuqs8zutL/qJ1LWl/WFPpssfFVC/ycCD9lMsdkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5llynbDu4Xjvzacg7ojr1QCh90AhUfS8IpTfpkbr86E=;
 b=sNnEGN33+CYfm71+iVP6CfC6lZ8t56DpMfehGm/4jX9cmXI8DsQqkaEN92ck0ymCKzTSekPXniuE77mnFcnWDYNIZWw8IHupfs7jPqJuyC+p38jAFC8BLp6cBhUMdWcoJe2/WgIcco9yPfdSdknMmXZOWCmS1rtacOY/FTfehkz8jRRjZGo9EqhdjDDjeXVFMEw4gTBMp7Ak7SdxqhxzTdt9VVkMBHsesjsBa2VTFDLaB+iChXH5DPcVhdG2xK8p9q8Xym6PRFsWJhpRotHIp6Ml9Vlchi6LMtEuL0XgEdtGwsZ1WVmQtnVSYEE7ViFJ1p/GLQzAA+whlGHqA7QFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAXPR10MB5760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:29 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:29 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 01/12] Add doc/README.cis-hardening.md
Date: Mon, 24 Aug 2026 11:46:38 +0200
Message-ID: <20260824094721.2636375-2-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b6be1f3-69f1-4853-353f-08df01c4b667
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|9063799003|55112099003|22082099003|18002099003|5023799004|11063799006|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	riEnqlZzkFi3VWYWmce2cx7Dlyh6H1vkPcAaR7UJZu5YPkbttET5JYLqAb3zz2poEZVAmg8BMsWbw1f0uguacxwXHoU1Wg6oxthh10flPsSDFhAJIHykmaAuLkKMNPM5rbYEukY1DJj1qxQOAIcuZI2kA00Ir2tGOZ1EEY3FPkD2HLlnXwVw+9ylqj18WVEDfMMYQYpnaON92sIMrnXt2Fj9aetbPX7d5cA9aVJKHObJlllXeBVP2Ck50QviWoTRHdjUkkaoBB45nF9OcW1TrC/P6WOUc+iHz5pqY74cIvubDlVp9+81KYD5sL8rUlChYFEpVVjwhR/E51r2uGbTSAqhdW+eYnrAWNublFVJbctm+3XG0dw20+BBWTyBQKivXNPgeNqO7xDXFX4fHezBvyHWGIY4fRr3NqICTIaXgkxTrG0T+oGn4E5OZE/EYqZQT12JW2cKXHGX7iI+faOjztl5yKx1MHIs0KPFAmaWLIRQM9J0NhXBH0XmkmFXZBYB45HpJsep6GrJNnyjiZeg9FXwR/k/NSTO+7KcIA/K0ZzD3y6zQv1J69jHoIGE6RxEuJhWxbTxnF6+Un7IrDEQj4POxhKYcIWU4wNoFeXQqXEg5rNVZ3BbraWX34g2Fa02kJcKhAhhHUm9nDUol0az+KKRdvYRtjVDKk5q8NCM2Pg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(9063799003)(55112099003)(22082099003)(18002099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8Zr09jaf9hCzpxL1VkKccRGcQBBONIYZZOTWItIUWMbF9Qk+sUjEmEWEFlSU?=
 =?us-ascii?Q?EpFxEJw4SqySIkjlqT1M4NZRkxCKhb/j+c7RMSeEqZiB5MC7u5NOQwH9vfLC?=
 =?us-ascii?Q?QgKvJVFDbc3cFjIGPMfwYij6kbsg01HhtbUdwqsNpDlYJLVwpMBUr/STRtxk?=
 =?us-ascii?Q?AnaawTFV7p70KOM+U8i6uTu44QyusVEa7UKcvojCERTsnMvcefYuN2Jz833Y?=
 =?us-ascii?Q?+VwiTqid+UekCLkmkkHuV1+esQZy1VDFfogTx6EgqsrJgszqKcL9zFziQUsS?=
 =?us-ascii?Q?8Ge+qeo7WqxfWYBzj1/e1EqEKxsE2A5/0HIENQWDLJGlisoPkNLZ5ixK1bA/?=
 =?us-ascii?Q?muagxAPw+uE1P2QH6GWMNTUl4aD7Ed8QvCaLadPkykamhVxTP7lFnFv8Jbqx?=
 =?us-ascii?Q?Hnpen8Yw1mS/bD/hygz+hFRozFogcMq2Rx1gYOFBorul68+DhrGPQyocmWac?=
 =?us-ascii?Q?87Db60ZOJAUMIJ1iC2ubNIZtj3U8er1ALaVPekGJcZ0RbAEs/VyHwlLgD93d?=
 =?us-ascii?Q?1ZIOPAG/7jl0e/8fYWY5SYTM1canc9q1fMp81ZGtmvcH23gSq2WX9pKZ9V8/?=
 =?us-ascii?Q?UV8psibqExrdqYEk7qCNj1RzmTaEMsHwPmCgAIHfO4M8kwivoRN9ogIYnI+m?=
 =?us-ascii?Q?Y8qKu/zFljRpH4sd1gfz1ikBd3Ubw63tS1i0KYl550bKyqKX2eJNVD+Nr0i8?=
 =?us-ascii?Q?e3DQgMSTf3Gsb3qCkup2BYluLmUbnB7kxG+fd18vnPsTWCoYLjOU29NMrbgB?=
 =?us-ascii?Q?IvU2qS5nkHrTWuxYnkSB7/s3mhkiyh2Y4cP1PvouPvsPO2+zZMaRPio3SKaE?=
 =?us-ascii?Q?x8S3tC90QBq9IsAQxHyXil4RtexrvFrY9tsaDlebwbYXpgZdc/THjSuhuB2x?=
 =?us-ascii?Q?dNqvGGqNWQ6a99Gmcs437CvzH68R6nAkc2nCAHO8ijdxv3zbTjgl78Yej61h?=
 =?us-ascii?Q?wUiYeZojoWS2clfFwdOF31UHGS+z42fJQe1tYuSRTT290imos8BzigCla7vi?=
 =?us-ascii?Q?8uaDBJ60uEVJsgQMCR6kTmwJh0XROFzvV6nhF22TgafoEY5RQWGbdWxQnam+?=
 =?us-ascii?Q?3BBkPD5mq/fDutjQt0J9N054D/jaZeWbpKG9PLPMIlIPXyVTkwNyyLLDyLWQ?=
 =?us-ascii?Q?1egvBBzjROWYZdVvIF4ZyduCDtA1LhCaEljnE3eH8/Ayha4Z5uiw/iDv0ZUO?=
 =?us-ascii?Q?oNJTj0QoEJEv92dqBKaTryCRJl27u+Zla8DomVfSFxQEdGVtUrRhMj88eUum?=
 =?us-ascii?Q?xVTk51+04cGG19ZCN3DZ6u4BvdW1GPi1VfBQECpQi4CJXetCSf9XHrtCmIO+?=
 =?us-ascii?Q?AiZ/tu7kWLToAI39jNgTGpPa4YLCprIGN1JqIPuIr3FtM+TOvZP7lMmbzC5J?=
 =?us-ascii?Q?n0cHjJ6faUHn4Fi7hcU3+zcWx6Ix+gwsAPiXovzUW4APOrbpNPJAyMTG7Iek?=
 =?us-ascii?Q?z5M4qmYtep2SJxF+7lyggOnHxq15mawuxE3+DAXDaZot8G1/AvomoMG/VjGT?=
 =?us-ascii?Q?QP1JzJCsdakh3GytcpaOlujY9xEZJ5VeQE0V2lyKdyATlAQxDRMikUmZ2xOn?=
 =?us-ascii?Q?JFXlZfUTblq9Es5P4S+0AoucRKPJcLG4lgyp5vuYXhUQy0m6zDdxHb0My5AM?=
 =?us-ascii?Q?DNlq8fgKZr8Oqmb+2dIDUkZKmhwOo1k/eiysfcI/k+B9P4o+7q4giCcqZ6VS?=
 =?us-ascii?Q?nLZ7KdQpOH5GfGKIbOikdhHt/qU3YaTRWe3+b5ag0Vkm+lpZHPJXkREQ7Cye?=
 =?us-ascii?Q?+ZrYS0BaKUpn/PdZbcpHekpWbAD4gBs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6be1f3-69f1-4853-353f-08df01c4b667
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:29.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/FOn4m8+L0Q/9i4+4Ua7R4pm3hjTdCtnOmw7BL0+jb3s0TUoP896ib8ggmi00kFdSv6exbe1hmlEtLPXhm+oKak9MYg0UizQpMMuGG0U1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5760
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23982

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
index 05291744..0029da42 100644
--- a/README.md
+++ b/README.md
@@ -63,6 +63,7 @@ The following topics are in separate READMEs:
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


