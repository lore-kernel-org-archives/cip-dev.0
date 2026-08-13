Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F7C5DF67
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16256.1786617571831620592
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PY3FNMSD;
 spf=pass (domain: siemens.com, ip: 40.107.159.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5GerXfE3uSl6ptHVjaSpOf7X2blUyP80pjKtmVv7f3tCC5Z8dcrcC/hHJbSegC2K9M5ek7Mp6BGFVf7CqyqAcd+3YTDywfUzhg0kwXD8CuZWY6CHrZKrfWgkHB1R1Dnd07Eikf4k5zw5hJu2/+57YJlsEmlNZaGzyBxbwQTjp8Ht+dCu+vA8QKUlCeKKoEYyykl7VMhIrE4ELl7kuMRbbrhHI/Py+FhC5KCnCALIrps2/O8GMb9JHzKH7nN4iEkMxbVujgUxfDC+IhKaK7bJXk3aTRs9KdSxSGY5k3jvP8kt+xPRFhImtEV70UST76U7BYL2uPQ6vKzTUmoa1g1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMBDI+c8RugmyMU55ycSTyUcst9HRWesn5k/Z4ezeQg=;
 b=TfoRQbHxtuOpQPVuT8tKfKr9jQpxMdztqFU6qph/3+GX9BNYyoF5zsqAKpVptgmNQoWZVYR9QZ01zQ6W4wmYI8UIGhAQ2EomV0RFFNrCICstO5+bVRBo2dqWdLE+VgsUpGiEsm1IZ1u8vj8n8+6K0bDIXffiBfJn2RNob79puH5QOAgZKGFrVRENrIvTlFcadX1qWfG9of4QMstQaUrrpVlHsGva25ROBiqgviTsrSwTmwIgN/D3kBJKdjb2UkxF8g7nHV2uNAdwVhtINefssAB76sBKA9iilRFsxmE2nXRawYViL9Be4z8KHHvElwlcVEZNekVBM46h0ZIn82KbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMBDI+c8RugmyMU55ycSTyUcst9HRWesn5k/Z4ezeQg=;
 b=PY3FNMSDA1YThP+gY7wz/zXlqnT3noqDK6z+aNEs0yj8y/X89n4TbTjcOQxWt3LM8nvfsE7OqnwqTvlIVT/OgfliONz24YYIlDySAnjFBftBTd1R0Cb4otv6EoDJ9NiCI9fg9Uo+Du095vC2aQu/7GRmTtG8aQtp9DbEnq3sOMVaCgrtd+sb/ZxchWvJFlnwWTpUxFzF4Q1Z41Vpq/XYK5I/T0Jb92K3mbZ1TzbcfJ6ZzkHLwggcGmJEPc9FLkSvGr/kLXQpbNYzS1rui3GfdRfs1/cqevHcY72XTS49EZY80kBJHbT/W/LjlCiATY77q470uBtNvGSc+3uGeX4dgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 10:39:26 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:26 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 00/12] Add recipes for image hardening
Date: Thu, 13 Aug 2026 12:38:50 +0200
Message-ID: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: adcf55f7-e403-48f8-9dcf-08def92725c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|20046099003|6133799003|56012099006|5023799004|11063799006|10067099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	11QHhBkEQUOZh4W4RvKInUYb/6cUKhNOz27V6kZ5f8sASu6Fk77VT2ezurKJrWlsOrKAquxbNMIhoDlp5fKIuj8EXCZGdo0ffVzH5263pwj0y8SPz9YFrDuGeinqhFfgBYpEK6f/V9Y8oWa8Wj6sA7RDHa4Az/yQv67dp9MIe/ufprv3jJ4lYbIqmV/95fVh9FZxj8NMWzTuhOhrOlqXjxgxqRjDQmcDDl0VNNIM/7G8mrZfJ3t/lSmEuJF82tY+m9vgxflXfJH66H/mqydaBDQz6whINHbSchtZe7PDmQN4W5HowF83Yg2QcTynpE9Csv3LHrZPqI6sVSVz/6Dv79oMRED49Y7ZbrLbVv84dtJvKwIgEGXShoBF1bsdnA6+xiSpZhpR85XBeBmm18EbB3j3kflkOXdVu4Zk3DjbXH/d4MCOEuyxIjRd6F8fnaNMJnA3SdxD8R6HCo+gGJEpLyduqcImlz/EAz2ZLKEMZnCo8na3bJWDeFhnbeNmJi444VlfNbyZ3bnxIadfWAHAfqMxkDCmMwQL5sPxEdZkgKVu1KLu4UWsguwOOpDV05gwL0oniUJ4ADfuW84IN7b+lsTYSzTzNVMWkUlU/lxhO1wCF4hgCuulqjs3I28/Q8lj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(20046099003)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uKmMTHC+Y0m5lH93jH3c8fL1IxoGo/OZ7+FcOLIn6JCHB+xeiasBQJVL7Rwv?=
 =?us-ascii?Q?pSgb0RHyCUXsJgjCkuiLv6pCA6thmPSpWJmqEOiH9JGtB40rowOBQPGRbszy?=
 =?us-ascii?Q?B0fQM5D/y4L5u4Giyvgt8S0zswM2Obbv3shhWWqlir8jpaQsDTCn330G3zZn?=
 =?us-ascii?Q?MHVjt39UWUR3ZalZs/mLFsb2WWnDTAJJZ1OusWgkzL0ZF9B65hoI6hL7osLO?=
 =?us-ascii?Q?4hUf1HWe9f7Ce7KUBHcA07YFPrGb97n9RJAaMgNxk0q5szFBEz163eQ2wI1Z?=
 =?us-ascii?Q?+5lcAlhRm3GsaY24xcfjNy77leaAQH2Qz9t55oXQA7aQIwaAOF/wcSz3Vo/E?=
 =?us-ascii?Q?J7UM4sCoZSV9upZ9aa7MOCspcVw0Z6nCysTNYBP0ov2y6TmJecItF+0odcIh?=
 =?us-ascii?Q?h5p12GNaRx8U4PV4LBURkphw16laxB475osKmMpxu6gWiGIQml4Y0GZxjgN4?=
 =?us-ascii?Q?NQfgbFhGYdk7FF8nJz8lCLfAvzyoOsTClXXpXaPCFxi6f8RRM9QI7Hk7qiu7?=
 =?us-ascii?Q?mrzv0H0yUIpScp1CKZEnHnNgwIZy7oSDy2IrLd7UIjhOUFgP9YufFsGKUvDm?=
 =?us-ascii?Q?MQgot3O1MWj2SI5xz023ryEyARDMNlRE2SI/JlmJATktJJhrppNlhT46vfBE?=
 =?us-ascii?Q?x9QVbVbwnOJsRpv7bU47zvLY8OCyTRpGbjRLS3OKEfVz1G+Ttsw4yEq3d03L?=
 =?us-ascii?Q?qY4DvAklwfCM19/o2S5XscTGKpoD5pc2cQYbbLC+4/ZKvQH9CWi6jcGUF2U5?=
 =?us-ascii?Q?7xfAp8bWA6NwjFN5olNweYviPrezduE51PvqjF9gfZixSrp5Gz898jNXWgnB?=
 =?us-ascii?Q?1DD6ox458G7B9rJTJjrZw9/pfCauOhE6ZibAUhYGkDe6K7P0ZqR/hypKhWN3?=
 =?us-ascii?Q?Ctx9FOl3aetoK1y33IT3hteB8qLeFQrrnpIDrkO3SvLyj6aOm9SGCQR59qk9?=
 =?us-ascii?Q?CM0h7+7GBXO/tYyqEgoLvZZdjKAinQ4wtEx8WIHyMNb7DrPLSdxP/VBPD7zB?=
 =?us-ascii?Q?cra2IwZtZiMIhtiWmMg9bkDx98BaWcwUg+cPCtcc3Fh82W9NpAoEclDzkuO6?=
 =?us-ascii?Q?RlSgIxiuRsuG6xHdavEw0YY5y9G3HSlMH4Zcb5hIP7/hGyQOGyGXEIfpH0Me?=
 =?us-ascii?Q?+Wjrqql7GAkjKA8AEskz2BYfY3eiD5BC+HciJuDjG/a1wxrxy07AKjKUEoEQ?=
 =?us-ascii?Q?Jq3EjzAz0q5ftw3JlaKgdcsEcbPfQUDqCZ7sQ2NYEAzytaWhOqsedL5xSvXr?=
 =?us-ascii?Q?Nk1r7lZEDU9mEdkV8EDJB5A3c/83t2tzcXyu2/B5OabHuH7AOoUwOVvrYh4o?=
 =?us-ascii?Q?9+ZUV8KMU7fwnxAU9lhrJMwpGPwFegamnRpdQIoAoWcX9aLd8CGDWqqKY87i?=
 =?us-ascii?Q?PGFXSlfcyOid3f+/jEmW14GQgPfGozNdskGZvMVtFhyGKz5kBSYRNp4qRS1Y?=
 =?us-ascii?Q?REVPjMMdkCZzmZr4PJ+4Mp9I/9QNlY5GgOAcep1PRUsops203Ufk4c2EJTTb?=
 =?us-ascii?Q?DcJe9uF+4JCTBMsAc3su58/l7KqXai07/BIhrcPPD3oNLwEzprX0HLCsnTCg?=
 =?us-ascii?Q?YmCUV70qMI6W2jNfEwdGIu20e72N8ux2c2PbaYGH8wrVKRI4azLos4JkTLMN?=
 =?us-ascii?Q?8w27oi673tWgHf3LJVCO/5KWaZmKFf0rVv3VHlCOI2ukD/63xa6H1XdVdLtL?=
 =?us-ascii?Q?Go66p0sRyiNMoQLWsztUDORytqnIPop17OKXys+mO9LJdcmG2edEHKtiT3Uf?=
 =?us-ascii?Q?rp35vVSbE76Fqi5iyI8/mO5EkRmlI0o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcf55f7-e403-48f8-9dcf-08def92725c6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:26.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G907t5qqDxso6W5DsR+ASkCrMG3T6gJDroeFi7pDC7u/YDOsh+UiuI5sCQOkcFaZpZqlgI+4DTLgD4lVGZhcrPhN9LRl0AcsVGjY7fxcNPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23916

This patch series adds the option to harden the build image according to th=
e guidelines published by CIS.
The patch introduces the following packages:

cip-cis-rules-config: user-facing configuration, stored in .config.json and=
 configurable interactively via Kconfig.
cip-cis-rules: uses the configuration from cip-cis-rules-config to generate=
 a custom Debian package containing the necessary hardening configuration.
cis-validation: an optional package to validate the hardening rules.

Additionally, the kernel configuration is checked against the hardening rul=
es.
This patch set is currently developed and tested for hardening level 2.

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

Quirin Gylstorff (10):
  Add doc/README.cis-hardening.md
  Add cip-cis-rules to apply hardening configuration to the system
  Add github.com/ovh/debian-cis for the hardening validation
  Add cip-cis-rules-config to configure the hardening according to CIS
  Apply hardening configuration to the kernel
  Add class for validating the CIS options in the kernel config
  Add class cis-hardening for post rootfs generation fixups
  layer.conf: use variables to control path of hardening config
  Integrate cis-hardening into cip-core-image
  Add Kconfig option to select cis-validation

 Kconfig                                       |  10 +
 README.md                                     |   1 +
 classes-recipe/cis-hardening.bbclass          |  47 ++
 .../cis-kernel-hardening-validation.bbclass   | 110 ++++
 conf/layer.conf                               |   3 +
 doc/README.cis-hardening.md                   | 229 +++++++
 kas/opt/cis-hardening.yml                     |  19 +
 recipes-core/images/cip-core-image.inc        |   4 +
 recipes-kernel/linux/kernel-hardening.inc     |  16 +
 recipes-kernel/linux/linux-cip-common.inc     |   1 +
 .../cip-cis-rules-config.bb                   | 162 +++++
 .../cip-cis-rules-config/files/postinst       |  32 +
 .../cip-cis-rules-config/files/rules.tmpl     |  19 +
 .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
 .../files/scripts/config.schema.json          | 124 ++++
 .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
 .../files/scripts/gen-kernel-config.py        | 165 +++++
 .../files/scripts/select-hardenings.py        | 618 ++++++++++++++++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
 .../cis-validation/cis-validation_1.0.bb      |  51 ++
 .../files/cis-validation.service              |  13 +
 .../cis-validation/files/cis-validation.tmpl  |  65 ++
 .../files/generate-overrides.py               | 103 +++
 .../cis-validation/files/postinst             |  52 ++
 25 files changed, 2567 insertions(+)
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


