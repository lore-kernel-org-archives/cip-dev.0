Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527ADC98330
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:11 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Sj97XOQq;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKqOhxtn+oe7WDYvQMmZIJFCR9HD+A7jf94WEQHwhDmtijXrb+IUZJpTDhriKXveNHzbDdSQNLKUmIMTo4oAqRf9a2qV889pcIhdAM1qJKQ2+mGC1s1VhfmeH1WTjQaEUpKJ4CwltmS63RdIoobXj6tm6sRiGdstpAiT231TaiB4aCN7cgJZrS697BzUKQpRxXvnlRavbHGNK/eMNO8fd1UmqdI86Jh9t/UGniRJqey0Gb9cyTzUGeaymdv09fDZrl20dOzco6PzEN33BMsIJAo1m4c7fNhW740K/pp7vKgO8Qk2eVRIpfxDPMVSzRpGO2H8Gzd0J+vxXRF5CdDGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuVtJkMibfZlJbzxU5quRLoUP21Kgyr26WVvtUySa5Y=;
 b=dczTXUUUQbPRegEhAE1LEapqW7O8v89IdljDvQYVGZrJsYm6k6bZHlUZi0DBK8IKwnDR4ilnEpzGN0t6PRgGXJyFC+hrgLSdoFqO0w4gtkS6INxmkgg0EQmj49PaNGQr5WmW9GYrNydb2dzN/13hgA+wdlt7czFYRVMAPJ1KaPUZJjDBvPdJtUJnVLe//2uM/iJ/TD+uuvVj+M33Ji8SKVq4UoUHFf3Tz6UPELr/qL3SefuHIFdBNVZYp48g4U0NYA57yUKgqnZSs8lo7/dbXddW6vuIwAUfPI11ix2Id4ms/E3XJWkv4j3oPEIYHBNjJ+TPpwKL5fXlOv7Fk1tZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuVtJkMibfZlJbzxU5quRLoUP21Kgyr26WVvtUySa5Y=;
 b=Sj97XOQq1m4DuKkfo8mOAmfQZdE4rxR9q3aeu2tpG/+Btvsp07jquP02w7fhbeKApAm1xqGOCJBLE0lVk981++MdXjDmHSbZPsCrTTmfKpswcmFRAyzIkiXaUKVy3RuNdy3HjFWcxVzZQlkdAUdRh2N+bqqcd1GgKzzM0p/nNylJ1FVVrxN3RPymoVACYMGFK1zklctW8fYsPfPHIY1qtpeJB9YsiIr5LR5INyvepruXbFbAfzYT36va79ii+VixpupTn9VkSRB1aYgBahPOhV+8VxdaNJrzV10iad+gnKXz+hU22F6TW7TMLnVFuabdhouDqW2pDTSAFCCVQzUj3A==
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
 18:08:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 00/14] Add recipes for image hardening
Date: Fri, 25 Sep 2026 20:08:26 +0200
Message-ID: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: babe486f-e452-44cf-1295-08df1b300f9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|20046099003|260925022911599003|18002099003|55112099003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: 
	WKUDu4CAO7Aol+nn9pv1vFpSx5jno3r5vJSpJRkrNTgl8FwBZU/SOy2+8hbTU3dzRjRCD0nWKEvBhjz+xdmXaspHRZCMzfifMj6s+b1T6zUnMzEbO/eI+4EDh9xI09qmuczefMqk6JT8qeiYBSUJNhaDH8UN+aHY/CiWZ6kfIUDQcI2Uygkewzn7ZeQlUe50P4pA7eldD55JBYsGnBWCTg4vOqPkG9cUtk0Fa36JiAuniGjv2VXu/QmUd/vcj70L3ksEy5fsRLlR1bxlHesKhCryZKttQMnEzM9XI7o0PEFCsAdOtfS4jLlHxi77qR+x71rkZjHLtfcjOLgVZkfN0VAS07X6r5zvyG4nR9RKi870wlYNkP3IIocKWXm8UokFD+AXfXtkCvb6V/fVOq4Tgww3oHT6U98fXwJx4jcgJ5BtBJZm620ajqftIoM478bVmUt3Khu3YZekCwQWqiT03bNn9l1IP/V0CQ/arJlkMml97PPvF/xgvwSodOWUT+I9s3PLtqYwEESwbX7eoTDQEHux0VckpqiT3HHk7BYg1W6W6olSIEn24pyKIMAZwrfQVvbdXahQTQDYZfjG0hqBpSWDcrNtTSXt9eh2vCkm0L3oofosN1HPSz0Fo6i81bJt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(20046099003)(260925022911599003)(18002099003)(55112099003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u1RRzQmJZhS8oZFkw2yfxmhZHeFHGXtcx2LMQbi8QNvpfm2MQjgSeGFQ9WeF?=
 =?us-ascii?Q?yIRb9w0+0oreIwuDqEnl8sxA+Q4JfcnbC8kpTW6IiyEEMxJwARQOJVNFW0+k?=
 =?us-ascii?Q?uy1N30ZBqhGFi912JXyYSGzN/oBSFbaRxv7vNJnywWYU1kCwaez21sqc5ttG?=
 =?us-ascii?Q?DU4AmZMffENwUx43tXqxpmB0k/+IT7SaXXhw62DzuMrWspowrgRbPZL5x6xO?=
 =?us-ascii?Q?/uZePHwaEzUvsnw8aXSL/gQx/P9mBb16PDoO2h/DEoy4ZXj6QRz7e9sF6HSd?=
 =?us-ascii?Q?TQWgy26aE5LFhv0SvNjJYHDbuMPJlVGGGEmTyqGPS3Fah5flPf7FaIPWPcQV?=
 =?us-ascii?Q?m7sx6h/dr8vMudpAA7/PYcwKyqbovWE/z9OX3uJA7ZGN5LW6iEZgEjIAIQ4V?=
 =?us-ascii?Q?XMBo6++WLSAHR3CoLtZwu/XcwX5XmPRF+EVEOR1TvrydZ8CixTP6zCEF9hQQ?=
 =?us-ascii?Q?8mvPhnnmkLrGl+KhxJm+D61dqnpYOaPE8wjiAB+D//QDBJa5kiNRj5UaEoBJ?=
 =?us-ascii?Q?5x8CT5fRzZN+0WEE9Bup0jPSiaMnDrPN2/X8NAE+hHN9dHKE9/5zJIBPnqHW?=
 =?us-ascii?Q?OK0LR0nPm1lzA4DTCGE64QcnqGSH5BW47L0UF2mXlj+NRQaVLqruF618iwLt?=
 =?us-ascii?Q?SBIvswkzGy95oAktsRE4VsjYr9nBUcFhfsv68x7Bk+FadupgxwfGVX6RwKeO?=
 =?us-ascii?Q?N1YrIgqsxvdp65b3XeYZyYDDgr4lEv07qUiHEOCOJpBfAPXJ6JPbklnGavq+?=
 =?us-ascii?Q?xrJSNDpkChQQGBc98qniKRol04FvA45/y/0Ap4IWgQ9WZ8++9ghICVlk3Va7?=
 =?us-ascii?Q?r9KotqALEQakFi1Dr76nPts4aYsaLAFR6ceDiGUQpuavKQ4rdL43Vi+pxZy+?=
 =?us-ascii?Q?XQjGZj5n+dTwCw5T+gRuxFzEnBtzhA51vryGkPN9BYdbADh4LxeUJ0dyzjBo?=
 =?us-ascii?Q?dUgE7sxz2sbHJ96/o2qP/7l0kHWeodTOxQmWpFKNVWUrLLLFvMcoMbb/f1Mf?=
 =?us-ascii?Q?l2z2tWNBfu+Cr04TPoa8COkjg+M1RgctywBW5vIdXm0xBWy6Pmo4DRzVTifF?=
 =?us-ascii?Q?KwUkrcAAyxxGZei2TeOb4tusfLlfu8Nrg0zt9GV9tDLyjYVvnpaLObqGygaJ?=
 =?us-ascii?Q?5eikNxjcZHZm1hPWdFx6/wym4JK2VTIJgeeofR8ADlvYxgKGiAeEow0m38/5?=
 =?us-ascii?Q?JTzYs6bfqRKHSZLn9EfC/VMwCKgdqPelUGgPP7jEuxa1SA3uifA1XrF/ynrw?=
 =?us-ascii?Q?qpk+ZdIXehGmhdicejJRcAG+OWS/pzJ0GOfzfUam0SVsjOWNrdRa6NzMSwxZ?=
 =?us-ascii?Q?PXLvjqUJyf/MHytcl3d5S+3dEcnbAkFi+h1KOxgISY02Bf3RN2uStp9CIf+U?=
 =?us-ascii?Q?u3Gx9VWwZeJ+piwm3rv+E+JTIo18As100ij45IZSLaYBNxBZH03wFoyEW0Hw?=
 =?us-ascii?Q?HiArbAsyA/cA3jWHs4x7zPVJaXZpk5aktYqJPSOZu06TaFyCrIHOh5qh1i/B?=
 =?us-ascii?Q?lbhKIMYxNcSmwu0DqGzOPq6SAtlDCzIf3blqcecMvP9eATAIXLovbqh4eEH8?=
 =?us-ascii?Q?+WGF3K98ezwWrrdA2xcOxvPshoPgQkQPNQ33sqBQQScRNDV+2qA9+P+dwDrq?=
 =?us-ascii?Q?ZLGK/b+oTIdaU7Di0F4tZj8GmkExojqHJNj1aJtBiayR1clzcawjIgGGrfts?=
 =?us-ascii?Q?7imExUqDqfVX5HIu6r1k+np4yWUQ99Ig0GxO/9pDjXWC0yl1AneYza196oDD?=
 =?us-ascii?Q?NdPFKlpQUSq6KzdazzXh4/SUd11ofYo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babe486f-e452-44cf-1295-08df1b300f9f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:54.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXxqfD1on8E4/Sk9IdeH0gg3C7wj1/TEsFs4YExAL7HGKsdFSTsIJuIA1I2gKccw9u6acDrX+ZeObfHZYrXqcbnOzFHANlX/ejWS8UVrK+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24353


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

Changes v6:
    - add ci configuration. This adds a ci.config.json which is
      generated from the default settings except it enables squashfs to
      allow the ci build
      Test job:
      https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/16743214=
042
Changes v5:
    - rebase onto commit 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
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

Quirin Gylstorff (12):
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
  gitlab-ci: Add hardening option to build

 .gitlab-ci.yml                                |    5 +
 Kconfig                                       |   13 +
 README.md                                     |    1 +
 classes-recipe/cis-hardening.bbclass          |   52 +
 .../cis-kernel-hardening-validation.bbclass   |  260 +++
 conf/layer.conf                               |    4 +
 doc/README.cis-hardening.md                   |  283 +++
 kas/opt/cis-hardening-test.yml                |   17 +
 kas/opt/cis-hardening.yml                     |   19 +
 recipes-core/images/cip-core-image.inc        |    3 +
 recipes-kernel/linux/kernel-hardening.inc     |   18 +
 recipes-kernel/linux/linux-cip-common.inc     |    1 +
 .../cip-cis-rules-config.bb                   |  159 ++
 .../cip-cis-rules-config/files/ci.config.json | 1760 +++++++++++++++++
 .../cip-cis-rules-config/files/postinst       |   31 +
 .../cip-cis-rules-config/files/rules.tmpl     |   19 +
 .../files/scripts/cis-hardening-to-kconfig.py |  350 ++++
 .../files/scripts/config.schema.json          |  124 ++
 .../files/scripts/enable-cis-rules.py         |  333 ++++
 .../files/scripts/gen-kernel-config.py        |  165 ++
 .../files/scripts/select-hardenings.py        |  616 ++++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |   23 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |   17 +
 .../cis-validation/cis-validation_1.0.bb      |   52 +
 .../files/cis-validation.service              |   11 +
 .../cis-validation/files/cis-validation.tmpl  |   65 +
 .../files/generate-overrides.py               |  103 +
 .../cis-validation/files/postinst             |   52 +
 28 files changed, 4556 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
 create mode 100644 doc/README.cis-hardening.md
 create mode 100644 kas/opt/cis-hardening-test.yml
 create mode 100644 kas/opt/cis-hardening.yml
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-con=
fig.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/ci.config.j=
son
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


