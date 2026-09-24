Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE086C98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:40 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=knN90asQ;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCDzqyCK4BBc6zIC6TqwYNuPtCFXxoRro7/nJakuLq37RVx2Besoa9Kol/JJvfMobKZLyvDnLLzP6Xc51xiKpLjmlX9cv54NtS6Q6YHJRw+g4bKylYJkZp6Mz79zi4RENTNPPPCzKVFVtpfUzgNuC7DWxZGNneozNC19ODHzZY5PXkCxh9B61YZ7xMDSXcSExSGx8P2k2O04ECuo6X8eIzqX2m9Oh9FiHNxkox34aYPVBndw0T4/7V0z/bzTTT2OXo2it/q1aLvtTC3aPK25+wdf/rL6fq4x5p6agi+a15n1UtYbHmzEJhJwofyivSTIOEIgBqzCyWbMzFO8apti3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0NvnT+131I1pT/OpxquVf99jdhlrpMScHl2AVfA09Q=;
 b=lC4MTm7fWR74LWLHIdjjMd7YbMEz+y6npzM3ICaDTbGtOQlLpeOaFcFXIMowm6NseDpHCRQkZXbU2VDe1XKrfwivpLQnmfwQaUEz+k0Nkrs86Mt29hOpA96/Mwe8oNJJBlwjL3CvtfCQFvseW266g+NJbVv6wQGF5MAA/XRBf90Dy3KKuh7hEDMJBb0SvRuvgae6S1rVS9k2pa1Lgn+PcmxZnWUSmPTWEtokzCp3gbaWRt+AR2SkCNFT2DglsenJLemckg2m/Xr9rDGLrI5C1qwrUrc0Uec7CHPuHRjNqmOr45f+NCiNXrtvoHm8SB7Jodz5wB6laUXnle+AhhqREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0NvnT+131I1pT/OpxquVf99jdhlrpMScHl2AVfA09Q=;
 b=knN90asQmt3LUsnpGJKOXLleaVgCrHebKOoZuOX2dH4yn+G5lOeJdM/yesH8/O+CUno8lTsO95Bd24BWLU+PjRHIw8iM4img+SeqBYaiMgHOJ7FhTD7mCIZ0SGKPANozvwpmJaiSvmnsLOKra6YKNg2JSVChGTl86eToOVNFJHHxNRL7dDJ6Az6UVtrC/8XKJs3n0PFLvdREDyivaGi/hiwAjRJedwMFUrEJl+H3ivMb28STDwyeGakANTNmkI2ck9XIKsSviD/gcpnF3jqf7UBvewJlqF20rqW2nFdVac9Ygkgkgg0LZDelbcGc3as628fflKAfvks/OUxvIvxZfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:34 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:33 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 00/14] Add recipes for image hardening
Date: Thu, 24 Sep 2026 10:12:09 +0200
Message-ID: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd2b4e2-1f49-417c-3453-08df1a1395fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|55112099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info: 
	eggtP092b2Y4VRJs+kY5mBhfKhnDZ/Jjx1cujqiLvRlpAvOsomOIOKi/1eNw2nFOaNF2u0IzMXusAddPFt4pAoCv5jv4/eT8p9fPYya63j0DL6YzsQvoGh+7f0Nk8tW5DJRbPj70Pr1EJxHuMHquSKvJeh5pRuaHKUu8IIlBdnnzmx0AuRj5P7SecEtRvraGSYBuzkCociTAu3AdZKqzTO+fhPMpHQEtlgf5WyN49F0O/PTqU7XoI4cM1codXEDLo1TxiKaVmFB+btyHqbEOPORoldPUunoqNrdd+SrDaN68gFJUDcRuCdMKn95l7FWRqAq7w0pGtS1QOhPmor+Y+5HdwQOjc0auda8eUpUODZep6HYTSFF0fSKn/uMj+CaaY+URHHW2AAsysm9NczeRiZS066FopQxuNLD9oDKE5+/YA++2VpW/90u32he6oMqBOTSe6j+PWztdyywZrONLBxFY2Nsn170WoHvKt/hwgZhZHBFDZT+AapD+bZ8qZGojCbGnaiCO19RF+8Dl+0AwBQ5TAMyTwidh7oLKMry4OLCt+1mgsA0JD5UrLoArk/eMPpQZU1eHcrgt8crR3jQP/R+47wYfR+Hs5EysiPUi2dDB1OYBNwzqP64VIvwkWOxk5S0/Qmui1rOvEGCM4Ouh7sCwCeLEaBeJYvRfK78dFnc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(55112099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UPr6XzxvWj+B2C64oWWSibmIsubAvM6MQOxDWZr2IjtLjZo+I0TygkKBwWjh?=
 =?us-ascii?Q?vhdRduzFKQeG9A0GYOFHGexC6AC+RaGrW+9i/65Gwyw/w+BxLnJxjEfyBHFL?=
 =?us-ascii?Q?81Up0Xag4/ioBCaLvuHGmjeovgOcD2QG0HBoZwK90Sy4/I8wG7Kg6Fnxtgpl?=
 =?us-ascii?Q?d2OmBah+5I/L8s3j1/7AfcKLmpmovyDMe+FhlATJUkdIv1mdIkYCdv8q7Hx7?=
 =?us-ascii?Q?QyVf3/FFgtSORFC0lDNKLCY0m+e3ImOoPiBjzv3ruB+eiHBmWpmpNpU86DXH?=
 =?us-ascii?Q?Xl/yaeA11LixC17CR0BBYi+PFJ5Z4yyhzsIURBgIl/onj2o/S3Z3MdqnHN2l?=
 =?us-ascii?Q?UkuYLxwToi0NAELJiHxzRYoxJsVUvulDW8kaEFmL2Zp4wOZmM7RqtZsLd2RO?=
 =?us-ascii?Q?1MHiv/bb9nTUVnMJ4fWvGNGRrPt3F1cVdkYI8lNJ/yzph5A1IPvKwdyCqVVg?=
 =?us-ascii?Q?qecYTZKDrO27uit3inWowzHY2Nv3HbPAhxmez38sx7pMXR9vuMAsafYKqUs3?=
 =?us-ascii?Q?Kv/Iw9epILj1UgwOHOjx1d6Wxi4yJBmX0e8UBnF1TefJ+kXOrjYz8c04pux4?=
 =?us-ascii?Q?QADTbHcieA966m9vyqN5pzIfacMDsMfEVM4cBDhedxF2uxRNvmkmmhY+yt+g?=
 =?us-ascii?Q?mDr04kSm2R8qXufoilCX6v4SIVNfB7FT5UC11HfExYtOrUnLA5hh61SZwUcc?=
 =?us-ascii?Q?havfmeZbdJvUmxDdb5ElyLNPhNthziZIIN3BnuKFcOGHiesx8DDKIA1Tgic+?=
 =?us-ascii?Q?Imqju5UhCQPJRf01w7lzKPino2MVV0hpG4pGAoFJPk1EAwqik52yqIzARveS?=
 =?us-ascii?Q?7QqDQ+iFJR0qjLhs1p4uDWByyHpXfoVtSLKgBYDUr9Ew77hC8rsLvet3QRWB?=
 =?us-ascii?Q?f/4Qdcyp9pvI57ToRe/ccQVFNNvpSpQZord9f7lBzIwQ0w3fGZXKm/+ufV15?=
 =?us-ascii?Q?PcwcEyaiIIOZ2dQM9xysv2JfHliSPffrlM4/LDZsKD5dH3rGsxb7c16lMZFl?=
 =?us-ascii?Q?vCMd0kgkZ8ltzt9prFe+nfDPccN4yxw5bhGwxgU2Cx0xaZijOgskRGRL4E5z?=
 =?us-ascii?Q?qKU2hrVZ19duI8qQC5BajEB3w3Py3tSiV9Zjys3rjuMUpXOtC3cBhsUcHQIc?=
 =?us-ascii?Q?jMZv7qx0D0of2GFGjRmh5xNllLq9lxOBiEBItDyZdjTGyIgKToDwxPWoAQfL?=
 =?us-ascii?Q?g3JEJiiQoLjC0eZra3Byoj1W9GeJH1CRbBzhnqVqKdySOwuwVG5IfIvdK6fq?=
 =?us-ascii?Q?Q/wayb0k5NG2nxZCySqLTs1UV1hc5R0UrHKMp2UpTshCblx3GWwONEiG2/hf?=
 =?us-ascii?Q?nJI8e+o6spql3wcRe1jbFRdCDwU6624Q4hOAxKTbrQKrEeGfJLnaCOehgTuo?=
 =?us-ascii?Q?4V8sudPrTfaJCxbHLOMY6uMGjhRgEk/9wBichng4dIIoZGXWWcChn1hs0leA?=
 =?us-ascii?Q?/lE/JIN80bZVFdByURSE/qjR6SurbXJaVBdz6/TdocVXZWffPnHqjtdO2hDU?=
 =?us-ascii?Q?uooiGUIje6tgAqxATHsVikwKK4bWLEMTheHhYWDPKHIa6zM5PpGbuEJNg/EV?=
 =?us-ascii?Q?mS+XEO1Msx9HFrtbklEWPKGn0QAhp8BL8+dJEL8EdSxCwVuc6//CxkbVuwt4?=
 =?us-ascii?Q?cWIi60yRYHS+9KppBZSN7wYg9lcxOkR6zaUEfuxNphX7dcNP8C2x9ppIgsHV?=
 =?us-ascii?Q?w48YT6IdfT7pjQNkLZkH9fmkNPaFKQc/6MiWXDqXPkKi1+QqtoA+M1r59aHf?=
 =?us-ascii?Q?Pxp5zOVx2xDtZS/wNccGa8dxUAry/0c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd2b4e2-1f49-417c-3453-08df1a1395fa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:33.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0untPd+SaFLiKwvuCyAbETwHdLPMIOpKRfdEsacCCgdx+gAZvbm3e97yOYjL5nFU3teckADaoQRe5THNVanQkDneKwUUS7RChr+EYTQC5O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24287

This patch series adds the option to harden the build image according to
the guidelines published by CIS. The patch introduces the following package=
s:

cip-cis-rules-config: user-facing configuration, stored in .config.json and
configurable interactively via Kconfig.

cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
a custom Debian package containing the necessary hardening configuration.

cis-validation: an optional package to validate the hardening rules.

Additionally, the kernel configuration is checked against the hardening rul=
es.
This patch set is currently developed and tested for hardening level 2.


Changes v4:
 - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
 - Remove redundant addtask for prepare_build
 - Switch cis-validation.service Type from oneshot to exec
 - move validation to kernel recipe to avoid issues with kernel config not
   being available during rootfs install or validation of a upstream kernel

Changes v3:
 - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
   better task dependency management
 - remove json schemata validation during menuconfig read to avoid a
   issue were outdated config cannot be updated.

Changes v2:

- rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
- reorder patches
  - README is now first to explain architecture
  - layer.conf before arming
  - kernel and image are armed together
- use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip=
-cis-rules
- menuconfig now uses devshell to be independent from kas environment
- generate config.json and kconfig on the fly
- bugfixes
- rename cip-cis-validation to cis-validation
- remove CIP_ prefix from variables
- rework readme

Clara Kowalsky (2):
  Add cis-validation to validate the hardening based on the CIS rules
  Add kas file for hardening configuration

Quirin Gylstorff (11):
  Add doc/README.cis-hardening.md
  Add cip-cis-rules to apply hardening configuration to the system
  Add github.com/ovh/debian-cis for the hardening validation
  layer.conf: use variables to control path of hardening config
  Add cip-cis-rules-config to configure the hardening according to CIS
  Apply hardening configuration to the kernel
  Add class for validating the CIS options in the kernel config
  Add class cis-hardening for post rootfs generation fixups
  Integrate cis-hardening into cip-core-image
  Integrate kernel validation into linux-cip
  Kconfig: add option to enable CIS hardening

Shivanand Kunijadar (1):
  Fix file timestamps are not reproducible for EFI certificates

 Kconfig                                       |  13 +
 README.md                                     |   1 +
 classes-recipe/cis-hardening.bbclass          |  52 ++
 .../cis-kernel-hardening-validation.bbclass   | 260 ++++++++
 conf/layer.conf                               |   4 +
 doc/README.cis-hardening.md                   | 283 ++++++++
 kas/opt/cis-hardening.yml                     |  19 +
 recipes-core/images/cip-core-image.inc        |   3 +
 .../single-key-to-efi-certs_0.1.bb            |   7 +
 recipes-kernel/linux/kernel-hardening.inc     |  18 +
 recipes-kernel/linux/linux-cip-common.inc     |   1 +
 .../cip-cis-rules-config.bb                   | 157 +++++
 .../cip-cis-rules-config/files/postinst       |  31 +
 .../cip-cis-rules-config/files/rules.tmpl     |  19 +
 .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
 .../files/scripts/config.schema.json          | 124 ++++
 .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
 .../files/scripts/gen-kernel-config.py        | 165 +++++
 .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
 .../cis-validation/cis-validation_1.0.bb      |  52 ++
 .../files/cis-validation.service              |  11 +
 .../cis-validation/files/cis-validation.tmpl  |  65 ++
 .../files/generate-overrides.py               | 103 +++
 .../cis-validation/files/postinst             |  52 ++
 26 files changed, 2779 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
 create mode 100644 doc/README.cis-hardening.md
 create mode 100644 kas/opt/cis-hardening.yml
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-con=
fig.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
 create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis=
-hardening-to-kconfig.py
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/con=
fig.schema.json
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/ena=
ble-cis-rules.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen=
-kernel-config.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/sel=
ect-hardenings.py
 create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
 create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
 create mode 100644 recipes-security/cis-validation/files/cis-validation.se=
rvice
 create mode 100644 recipes-security/cis-validation/files/cis-validation.tm=
pl
 create mode 100755 recipes-security/cis-validation/files/generate-override=
s.py
 create mode 100644 recipes-security/cis-validation/files/postinst

--=20
2.55.0


