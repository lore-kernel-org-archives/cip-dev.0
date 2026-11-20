Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hqy8fxrS;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q509jMSHU0GN9xJn5bkYGixmqxSKhF6DDS3YqmLX7xgWk3BgfohcZDUCmBE/C+m0zPKKXFqfgoytyR7lCZm/pcqAni10GS6olPXg0DHWc5sAt3el7XpgTEmdZ7uuaviYKpMuA2WXsBQrjn/W5d2LtOfd32NKi5OG83J8pV0OHlxEowrZCTTkMbtjiRfiSq2ENqGNXAQPf3StXofm0CZwFJdfAk4PAGMSyAPDOrLONohh0Dj5irMtaLpap3U90ctd/EXqE+fbMVk+8WP4BN7NIGhyKF+qBmy4TmIpvb/c6aWiNKNG9Wu+sDsT1zSrPFUVPCYyWfx+6Ka9slwOc9tp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp9bB3l6rlNg84YKthnAoQ62NfA2N9YIVtYI2g0HRII=;
 b=pWzTV5n41NEvN+iP6/gchwyGd6JfRJHuQRXbErFKYztRU+DkNxW4bUYPbm1HPBr/Xy9z75yrBLN8UWVL8ilo+pbt4cMwAiKsXJabEJljT7ryyCQ/1jJwh9g5OGIGq5o9qEYFtDbs7VtsvvVZgmkXffSDdHSkSslzv1DtA+ctJcCzI5NpLr6sC8C7DSBwoEJIVG0UZH2CeNdGkSteb17lLx7an0AMDH6dzo5kcdboOJAwfRcYHW5VxdCjQ6a1BiqwOCwY3GZ/6J7fYIqxymvizq6dHvgXJBxdeRVpA8l0DHhBfIcN2K9Y0luqk18xSLbsx29jodmK8ZPf1PbYdENfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp9bB3l6rlNg84YKthnAoQ62NfA2N9YIVtYI2g0HRII=;
 b=hqy8fxrS890HV77m9pCvKlaZNPnEkl46G8qv/QcgZX73zT7qVoa/1Ccft7bxqhxpaG7fnKIpo6iDVXrmg5d3wWPGqUsa/AfK763EhT4mP71Ns1GAZF0HnhcNkfWvGfA2RbVF2qHvMW/KdUCI14dp+sEH070Mje3zcytPur2xtDUG0y7HX83FdPjyBGoFX9RBHCg3NcBJBQO8r9bdK7miyuuKNltR+k866807W8YLGp89k3H1mQ+cd+2EVft5sQQSgVV3ME9MojbfAcS8vw+DYP1/qbkqkA5xXFpqqYepU/no6xiCaU8KQdsFGioySNzALxgOuF2X+wbJ2MzZrOrH6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:04 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:04 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 4/8] scripts: add Python LAVA job generator
Date: Fri, 20 Nov 2026 09:25:50 +0100
Message-ID: <20261120082554.375548-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6111a794-e8e5-4eda-4691-08df46dfeaad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|5023799004|11063799006|56012099006|261009221227099003|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021130227099003|261021123027099003|261022105027099003|261021133027099003|261102123227099003|261021135927099003|261026121527099003|261026135527099003|261028144727099003|261026130827099003|261026140227099003|261022113327099003|10136099003|12006099003|25016099003|55112099003|20052099010|22082099003|18002099003|9063799003|29003799003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ysSuhtu9lyWsrtWET2F8+tdxTNbJDpTh5uOIXHBlZMRjHT1WvwJlfvrjLvQ/itB6yHaS8g3GD/DcHaDbDxEY74zPSzQJuRkuIKErU7C0ahj1hLj4A4HBlGPslwd90Fy0l8FdB5LPx5um0nUGWRiCjsStLb3NfA7IQSLgeRyD6KDt7af6QGnzdV5Cj789plry7xTf3nQfKMO1oy2TDHzweRb7PCXHO2EZao452vsH0x+/cDz/lhFN8YM4Pfmzpm00j37+cG9AdCUlPQsvm9nT1/w8Gcfp/O3sv7zblRIJFsyP3vCozV1rtNarGdJSeSDkHYLfTpa3QjuNr8apLPP/s7qPTyd5EW21QcagOZ9RyCZDYPKHMyVflwQ3tQ0D8N+SuHUI1QPa8LBRVBYlq647JdfqcfIhq/fqyD9N6N65dY3bJSLWkgTMtH9S3lHJRG/uAuQSX32E92kjsHVqCagpnJA7h6X11W2KFBhEuHHgM4C+BzF3czvDRirjZJua0OSBgYMO/yeJjVKRhZ0+aFNLvbboj1hLa6GaOvQWX6N258Ou+Cv6x4vcphJr2wDk32yG3qe4t+6KQrn1itZCUTuQvKxLBe5UeypuA2bKl9JGPqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021130227099003)(261021123027099003)(261022105027099003)(261021133027099003)(261102123227099003)(261021135927099003)(261026121527099003)(261026135527099003)(261028144727099003)(261026130827099003)(261026140227099003)(261022113327099003)(10136099003)(12006099003)(25016099003)(55112099003)(20052099010)(22082099003)(18002099003)(9063799003)(29003799003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivVoa/JjJq319L6aoiYQmFBXOGjxvAG9qBfhLdE7Y8FrYKxxjhdJz+gk9alR?=
 =?us-ascii?Q?0gTaHZLCeDc7XfH9xyE5Cc9AdMCtI8t1oHF9e+KRXvaBPtTWC4zj4vQLeD7J?=
 =?us-ascii?Q?mMjrb1k0N3ivAE1PUoq1QWqiqKUmtiUbWv2/4x5vd1Q+9HFjby+Pg6J26Dtv?=
 =?us-ascii?Q?qSLD7pfJDE50OftXqCt/umL8vSRQa+LEbXhT2rsVdKTGERG5Y08SIsAFlGuo?=
 =?us-ascii?Q?XU6k58AzfY5PtpXYHkBz2mOBxgy+7wOW4NFfNyS7LUTZ+RnAD/iP3/Dxhgsr?=
 =?us-ascii?Q?IQRAhjS9i+N7HLFTbhdGfTbUBQ/ONDTw76ENBSHBBsjvMQXvsTpp75YRMaze?=
 =?us-ascii?Q?igd5qtpMhqoPLTMlKc/7kZKS3OL2IiGTajhRmgGMU0NKGHjgQPkejUl6M5la?=
 =?us-ascii?Q?XuvOODbY9WRno5A87timGl8TePIOAIwTogPQcqmLgVdVUk6QYUyFU86aMftM?=
 =?us-ascii?Q?vsEH7hhpVFtGTZfHVtGK6aMNtzYN9yWvEOxph4Wg+Z0RCU8D4kEyveA6PlLt?=
 =?us-ascii?Q?sigr84idqQTWlkdEur3fg1QgDxFX4jCWUZRvotmi3Y9WJGDseeXIBzSHKDGD?=
 =?us-ascii?Q?e8oEUNyC/aBFMHo6xgKi5+jC+XTrgT+3M4MBVO05JtLpcgh7HPeejBcIXBbR?=
 =?us-ascii?Q?SiJGJr3+t2LTBZQcMTaP7bpNxij5H14AJUXIr3lYKye/DBPO7w1XgwoKLKl+?=
 =?us-ascii?Q?SJaHh127gQcBPr53vlmbgIYXCC2tbh7MERegWtIxzPjtQOWCMhOwYpWk8/p3?=
 =?us-ascii?Q?5z70g1N6NXe4PqbeNO7vrZhKdkRTNBobEOee5z6gJuGtIcLnjOMHMQGd30dR?=
 =?us-ascii?Q?d3EqXRplibi5KI0XVYcYPJEElilGj4EGY5XsrtDXDZ0tFUcCN03yJTUsyBpu?=
 =?us-ascii?Q?j5m/RuAaWqkQfyncgLXstfrHzSUOytn7ZIWnMifOa2N8sdS6Is/dr+De+1Fo?=
 =?us-ascii?Q?Cbhv6JrVaQ2D+lLbx0zx+xk7TL2cYjD1j1Gty1DjY/vzwqxk4GuP6Nahdp2x?=
 =?us-ascii?Q?BDhk4QMDi9FjNyB5y7jJOXfetUU43fK+dQGiG+9trwRmK8Xh2Tq4fP3WW34S?=
 =?us-ascii?Q?JRvys9gNSPyZd4P6aHktdYnruDASlIp7iCTx7T/vsBUf5jgjJgmIuCmSRuSN?=
 =?us-ascii?Q?FaOOclrMDw6vJpZbVJ0W62J4XmsgL+3tXmceFKQJI6pwNI1yxY2YY7xqh/cR?=
 =?us-ascii?Q?upq02IwVoh8oo/0W+zrRFbzaCjbmdbx4sQGqzLlyZ3eUhhkbwx07lk2I4qnD?=
 =?us-ascii?Q?D0qDCRaO/Y6sA6iu5j1kny2dmCHD5Pa2Qv8qW+9msE9zeq/JMN2xADRuLVAV?=
 =?us-ascii?Q?89UPm2rAyxlqRxwhryhsFZVLSZYsXRhA5CIrnJEPAb5il4o5d1WmViuwSPsd?=
 =?us-ascii?Q?giozr9J/r1HybWiXovru62Hngm9GKQ4fAg1D1ZM1iJIjPyL8stFG9q7zKfNC?=
 =?us-ascii?Q?TsfmqDqT0dYFqekjRuhyRUKXDt5NKSipM3MZqFWyOHWOjzNFDFZljFFmDcdQ?=
 =?us-ascii?Q?bzkQQAB+g0wifts1UPLpqODPBJOahnvwnsDTPK+KVc+n6JGpLZ7yBuKJAZXP?=
 =?us-ascii?Q?TDurY4pjNajVXR//f8Fdy864immf+Bzo8CflbPKzM2RVx/YnYV/Pv2KiZQK8?=
 =?us-ascii?Q?bE6oTeXJNNhSyM0+MC5OsrhmnVSMZ1HfW05+PEycoeCaeNQBCnFUcZQwPkoG?=
 =?us-ascii?Q?/XV1ASZY7VjGmfz/GlnasIIyKe3UjSXFQwgnYi4KZLi/ErN5tuL1Bxk/Xpy7?=
 =?us-ascii?Q?HQkyY8Pi9IWQ8Exf7z6s6saF6I8eacM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6111a794-e8e5-4eda-4691-08df46dfeaad
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:04.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eitJBjbyZQAzQmoUJdvdtYtaMt1L0CMQe2qoTCkKxYmJZDHC7zXmOBvMUEPBLG5dD4AgC7JJkvG/IFPLHEqy7N6gL+skjD7MLosgO5kIuLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25032
Content-Type: text/plain; charset="utf-8"

LAVA job definitions were built from templates with unquoted #name#
placeholders (not valid YAML), so only sed, grep -A and cat could edit
them. Edits could produce broken YAML that was only detected by LAVA,
and shared parts were duplicated across the templates.

Split the templates into valid-YAML fragments (tests/templates/blocks
and steps) with ${name} placeholders, describe the tests declaratively
in tests/templates/jobs.yml and compose the jobs in scripts/lava_jobs.py
with PyYAML, the parser LAVA uses. Each rule is a small function that
makes one change. Per-job text edits run before the branch and release
are filled in, so branch names such as fix-sda-x stay untouched.

The old templates are still used by submit_lava.sh until the
commit "scripts: use Python LAVA job generator in submit_lava.sh". Unit
tests are in tests/test_lava_*.py (python3 -m unittest discover -s tests).

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/lava_jobs.py                          | 371 ++++++++++++++++++
 tests/lava_test_helpers.py                    |  37 ++
 tests/templates/README.md                     | 109 +++++
 tests/templates/blocks/action_tpm.yml         |  14 +
 tests/templates/blocks/boot_after_update.yml  |  24 ++
 tests/templates/blocks/boot_mcom.yml          |  28 ++
 .../blocks/boot_mcom_after_update.yml         |  24 ++
 .../templates/blocks/boot_mcom_secureboot.yml |  30 ++
 tests/templates/blocks/boot_qemu.yml          |  23 ++
 tests/templates/blocks/boot_qemu_noprompt.yml |  15 +
 .../templates/blocks/boot_qemu_secureboot.yml |  25 ++
 tests/templates/blocks/context_qemu.yml       |  13 +
 .../blocks/deploy_downloads_postprocess.yml   |  22 ++
 tests/templates/blocks/deploy_mcom.yml        |  17 +
 tests/templates/blocks/deploy_mcom_swu.yml    |  18 +
 tests/templates/blocks/deploy_swu.yml         |  16 +
 tests/templates/blocks/deploy_tmpfs.yml       |  22 ++
 .../blocks/deploy_tmpfs_downloaded.yml        |  21 +
 tests/templates/blocks/header_mcom.yml        |  29 ++
 tests/templates/blocks/header_qemu.yml        |  31 ++
 tests/templates/blocks/monitor.yml            |  17 +
 tests/templates/blocks/test_iec.yml           |  19 +
 .../templates/blocks/test_swupdate_apply.yml  |  26 ++
 .../blocks/test_swupdate_check_ustate.yml     |  26 ++
 .../templates/blocks/test_swupdate_inline.yml |  26 ++
 tests/templates/blocks/test_swupdate_mcom.yml |  27 ++
 tests/templates/blocks/tpm_restart.yml        |  21 +
 tests/templates/jobs.yml                      | 193 +++++++++
 tests/templates/steps/corrupt_rootfs.yml      |  16 +
 tests/templates/steps/corrupt_swu.yml         |  15 +
 .../templates/steps/corrupt_swu_artifact.yml  |  18 +
 .../steps/reboot_without_confirm.yml          |  54 +++
 tests/templates/steps/same_uuid.yml           |  18 +
 tests/templates/steps/unsigned_bootloader.yml |  16 +
 tests/templates/steps/unsigned_kernel.yml     |  16 +
 tests/test_lava_branch_names.py               |  52 +++
 tests/test_lava_cli.py                        |  87 ++++
 tests/test_lava_core.py                       |  61 +++
 tests/test_lava_fragments.py                  |  73 ++++
 tests/test_lava_mcom_jobs.py                  | 107 +++++
 tests/test_lava_qemu_jobs.py                  | 112 ++++++
 41 files changed, 1889 insertions(+)
 create mode 100644 scripts/lava_jobs.py
 create mode 100644 tests/lava_test_helpers.py
 create mode 100644 tests/templates/README.md
 create mode 100644 tests/templates/blocks/action_tpm.yml
 create mode 100644 tests/templates/blocks/boot_after_update.yml
 create mode 100644 tests/templates/blocks/boot_mcom.yml
 create mode 100644 tests/templates/blocks/boot_mcom_after_update.yml
 create mode 100644 tests/templates/blocks/boot_mcom_secureboot.yml
 create mode 100644 tests/templates/blocks/boot_qemu.yml
 create mode 100644 tests/templates/blocks/boot_qemu_noprompt.yml
 create mode 100644 tests/templates/blocks/boot_qemu_secureboot.yml
 create mode 100644 tests/templates/blocks/context_qemu.yml
 create mode 100644 tests/templates/blocks/deploy_downloads_postprocess.yml
 create mode 100644 tests/templates/blocks/deploy_mcom.yml
 create mode 100644 tests/templates/blocks/deploy_mcom_swu.yml
 create mode 100644 tests/templates/blocks/deploy_swu.yml
 create mode 100644 tests/templates/blocks/deploy_tmpfs.yml
 create mode 100644 tests/templates/blocks/deploy_tmpfs_downloaded.yml
 create mode 100644 tests/templates/blocks/header_mcom.yml
 create mode 100644 tests/templates/blocks/header_qemu.yml
 create mode 100644 tests/templates/blocks/monitor.yml
 create mode 100644 tests/templates/blocks/test_iec.yml
 create mode 100644 tests/templates/blocks/test_swupdate_apply.yml
 create mode 100644 tests/templates/blocks/test_swupdate_check_ustate.yml
 create mode 100644 tests/templates/blocks/test_swupdate_inline.yml
 create mode 100644 tests/templates/blocks/test_swupdate_mcom.yml
 create mode 100644 tests/templates/blocks/tpm_restart.yml
 create mode 100644 tests/templates/jobs.yml
 create mode 100644 tests/templates/steps/corrupt_rootfs.yml
 create mode 100644 tests/templates/steps/corrupt_swu.yml
 create mode 100644 tests/templates/steps/corrupt_swu_artifact.yml
 create mode 100644 tests/templates/steps/reboot_without_confirm.yml
 create mode 100644 tests/templates/steps/same_uuid.yml
 create mode 100644 tests/templates/steps/unsigned_bootloader.yml
 create mode 100644 tests/templates/steps/unsigned_kernel.yml
 create mode 100644 tests/test_lava_branch_names.py
 create mode 100644 tests/test_lava_cli.py
 create mode 100644 tests/test_lava_core.py
 create mode 100644 tests/test_lava_fragments.py
 create mode 100644 tests/test_lava_mcom_jobs.py
 create mode 100644 tests/test_lava_qemu_jobs.py

diff --git a/scripts/lava_jobs.py b/scripts/lava_jobs.py
new file mode 100644
index 00000000..c84f22bd
--- /dev/null
+++ b/scripts/lava_jobs.py
@@ -0,0 +1,371 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Generate LAVA job definitions from YAML fragments."""
+
+import argparse
+import functools
+import re
+import sys
+from pathlib import Path
+from typing import Any, Mapping
+
+import yaml
+
+TEMPLATES_DIR =3D Path(__file__).resolve().parent.parent / "tests" / "temp=
lates"
+JOBS_FILE =3D TEMPLATES_DIR / "jobs.yml"
+PROJECT_URL =3D "https://s3.eu-central-1.amazonaws.com/download2.cip-proje=
ct.org/cip-core"
+
+KNOWN_VARIABLES =3D (
+    "branch",
+    "distribution",
+    "project_url",
+    "architecture",
+    "imageargs",
+    "context_architecture",
+    "test_function",
+    "updatestate",
+    "job_title",
+    "start_monitor",
+    "end_monitor",
+    "artifact",
+    "IEC_TEST_TIMEOUT_MINUTES",
+)
+
+IMAGE_ARGS =3D {
+    "qemu-amd64": (
+        "-cpu Haswell,-pcid,-x2apic,-tsc-deadline,-hle,-invpcid,-rtm -mach=
ine q35,accel=3Dtcg -smp 4 -global ICH9-LPC.noreboot=3Doff -device ide-hd,d=
rive=3Ddisk -drive if=3Dpflash,format=3Draw,unit=3D0,readonly=3Don,file=3D/=
root/keys/${release}-ovmf/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,ne=
tdev=3Dnet -drive if=3Dpflash,format=3Draw,file=3D/root/keys/${release}-ovm=
f/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=3D1 -global isa-fdc=
.driveA=3D -device tpm-tis,tpmdev=3Dtpm0"
+    ),
+    "qemu-arm64": (
+        "-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device=
 -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -device virtio-blk-=
device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet -device tpm-tis-=
device,tpmdev=3Dtpm0"
+    ),
+    "qemu-arm": (
+        "-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device=
 -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -device virtio-blk-=
device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet -device tpm-tis-=
device,tpmdev=3Dtpm0"
+    ),
+}
+
+QEMU_TARGETS =3D tuple(IMAGE_ARGS)
+MCOM_TARGETS =3D ("x86-uefi",)
+TARGETS =3D QEMU_TARGETS + MCOM_TARGETS
+FIRMWARE_TARGETS =3D ("qemu-arm64", "qemu-arm")
+
+PLACEHOLDER =3D re.compile(r"\$\{([A-Za-z_]+)\}")
+
+# Filled only after all text rewrites (sda -> vda, .swu -> -broken.swu, ..=
.)
+# so that these rewrites can never change a branch or release name.
+DEFERRED_VARIABLES =3D ("distribution", "branch")
+
+# Wide enough that PyYAML never folds a line (long shell commands).
+NO_LINE_WRAP =3D 10**6
+
+
+def load_yaml(path: Path) -> Any:
+    """Parse a YAML file."""
+    return yaml.safe_load(Path(path).read_text())
+
+
+def find_unreplaced(text: str) -> list[str]:
+    """Return known variable names still present as ${name}."""
+    names =3D PLACEHOLDER.findall(text)
+    return [name for name in names if name in KNOWN_VARIABLES]
+
+
+def substitute(text: str, variables: Mapping[str, str]) -> str:
+    """Replace ${name} from variables; KeyError if a known name is missing=
.
+
+    Other ${name} forms (shell variables), $name and $$ stay untouched.
+    """
+
+    def value(match: re.Match) -> str:
+        name =3D match.group(1)
+        if name in variables:
+            return str(variables[name])
+        if name in KNOWN_VARIABLES:
+            raise KeyError(name)
+        return match.group(0)
+
+    return PLACEHOLDER.sub(value, text)
+
+
+def fragment_path(name: str) -> Path:
+    """Locate a fragment in blocks/ or steps/."""
+    for subdir in ("blocks", "steps"):
+        path =3D TEMPLATES_DIR / subdir / f"{name}.yml"
+        if path.exists():
+            return path
+    raise FileNotFoundError(name)
+
+
+def load_fragment(name: str, variables: Mapping[str, str]) -> Any:
+    """Substitute variables into a fragment's text, then parse it."""
+    text =3D fragment_path(name).read_text()
+    return yaml.safe_load(substitute(text, variables))
+
+
+def image_args(target: str, release: str) -> str:
+    """Return the QEMU arguments of a target, using OVMF keys of release."=
""
+    return substitute(IMAGE_ARGS.get(target, ""), {"release": release})
+
+
+def build_variables(
+    target: str, release: str, branch: str, iec_timeout: str
+) -> dict[str, str]:
+    """Return the globally known substitution values."""
+    imageargs =3D image_args(target, release)
+    return {
+        "branch": branch,
+        "distribution": release,
+        "project_url": PROJECT_URL,
+        "architecture": target,
+        "context_architecture": target.split("-")[1],
+        "imageargs": imageargs,
+        "IEC_TEST_TIMEOUT_MINUTES": iec_timeout,
+    }
+
+
+def add_firmware(deploy_block: dict, variables: Mapping[str, str]) -> None=
:
+    """Add the firmware image to a deploy block."""
+    base =3D f"{variables['project_url']}/{variables['branch']}"
+    url =3D f"{base}/{variables['architecture']}/firmware.bin"
+    firmware =3D {"image_arg": "-bios {firmware}", "url": url}
+    deploy_block["images"]["firmware"] =3D firmware
+
+
+def write_job(job: dict, path: Path) -> None:
+    """Write a job definition as YAML."""
+    text =3D yaml.safe_dump(job, sort_keys=3DFalse, default_flow_style=3DF=
alse, width=3DNO_LINE_WRAP)
+    Path(path).write_text(text)
+
+
+@functools.cache
+def load_jobs() -> dict:
+    """Return the per-test job descriptions from jobs.yml (read once, do n=
ot mutate)."""
+    return load_yaml(JOBS_FILE)["tests"]
+
+
+def job_spec(test: str) -> dict:
+    """Return the description of one test; ValueError if unknown."""
+    jobs =3D load_jobs()
+    if test not in jobs:
+        raise ValueError(f"unknown test: {test}")
+    return jobs[test]
+
+
+def is_supported(test: str, target: str) -> bool:
+    """Tell whether a job exists for this test and target."""
+    targets =3D job_spec(test).get("targets", QEMU_TARGETS)
+    return target in targets
+
+
+def output_filename(test: str, target: str) -> str:
+    """Return the job file name for a test and target."""
+    return job_spec(test)["output_name"].format(test=3Dtest, target=3Dtarg=
et)
+
+
+def replace_in_strings(node: Any, old: str, new: str, count: int =3D -1) -=
> Any:
+    """Replace old with new in every string of a parsed structure, in plac=
e."""
+    if isinstance(node, dict):
+        for key in node:
+            node[key] =3D replace_in_strings(node[key], old, new, count)
+        return node
+    if isinstance(node, list):
+        for index, item in enumerate(node):
+            node[index] =3D replace_in_strings(item, old, new, count)
+        return node
+    if isinstance(node, str):
+        return node.replace(old, new, count)
+    return node
+
+
+def other_release(release: str) -> str:
+    """Return the release whose OVMF keys do not match."""
+    if release =3D=3D "trixie":
+        return "bookworm"
+    return "trixie"
+
+
+def find_empty_steps(node: Any) -> list | None:
+    """Return the first empty `steps` list in a parsed structure."""
+    if isinstance(node, dict):
+        if node.get("steps") =3D=3D []:
+            return node["steps"]
+        children =3D list(node.values())
+    elif isinstance(node, list):
+        children =3D node
+    else:
+        return None
+    for child in children:
+        found =3D find_empty_steps(child)
+        if found is not None:
+            return found
+    return None
+
+
+def tmpfs_deploy(job: dict) -> dict:
+    """Return the deploy action that boots the image from tmpfs."""
+    for action in job["actions"]:
+        deploy =3D action.get("deploy")
+        if deploy and deploy.get("to") =3D=3D "tmpfs":
+            return deploy
+    raise ValueError("job has no tmpfs deploy")
+
+
+def assemble(blocks: list, variables: Mapping[str, str]) -> dict:
+    """Merge mapping fragments into the job, append list fragments to acti=
ons."""
+    job: dict =3D {}
+    actions: list =3D []
+    context =3D None
+    for name in blocks:
+        fragment =3D load_fragment(name, variables)
+        if isinstance(fragment, list):
+            actions.extend(fragment)
+        elif list(fragment) =3D=3D ["context"]:
+            # Fragment holding only "context": deferred so it ends up last=
 in
+            # the job, as in the old templates.
+            context =3D fragment["context"]
+        else:
+            job.update(fragment)
+    job["actions"] =3D actions
+    if context is not None:
+        job["context"] =3D context
+    return job
+
+
+def arch_spec(spec: dict, target: str) -> dict:
+    """Return the per-target part of a test description."""
+    return spec.get("per_arch", {}).get(target, {})
+
+
+def job_blocks(spec: dict, target: str) -> list:
+    """Return the fragments of the job; per-target blocks win (M-COM)."""
+    return arch_spec(spec, target).get("blocks", spec["blocks"])
+
+
+def job_variables(spec: dict, target: str, variables: Mapping[str, str]) -=
> dict:
+    """Combine global variables with per-test and per-target values."""
+    arch =3D arch_spec(spec, target)
+    merged =3D dict(variables)
+    merged["updatestate"] =3D "2"
+    merged.update(spec.get("values", {}))
+    merged.update(arch.get("values", {}))
+    if spec.get("swap_ovmf"):
+        # Mismatch keys test: boot with OVMF keys of the other release.
+        release =3D other_release(variables["distribution"])
+        merged["imageargs"] =3D image_args(target, release)
+    return merged
+
+
+def defer(variables: Mapping[str, str]) -> dict:
+    """Return variables whose deferred names map to their own placeholder.=
"""
+    kept =3D dict(variables)
+    for name in DEFERRED_VARIABLES:
+        kept[name] =3D "${" + name + "}"
+    return kept
+
+
+def fill_deferred(job: dict, variables: Mapping[str, str]) -> None:
+    """Replace the deferred placeholders in every string of the job."""
+    for name in DEFERRED_VARIABLES:
+        replace_in_strings(job, "${" + name + "}", variables[name])
+
+
+def add_steps(job: dict, spec: dict, variables: Mapping[str, str]) -> None=
:
+    """Insert the test's steps into the job's empty steps list."""
+    steps_spec =3D spec.get("steps")
+    if not steps_spec:
+        return
+    if "fragment" in steps_spec:
+        steps =3D load_fragment(steps_spec["fragment"], variables)
+    else:
+        steps =3D list(steps_spec["inline"])
+    find_empty_steps(job).extend(steps)
+
+
+def rewrite_texts(job: dict, spec: dict, arch: dict) -> None:
+    """Apply the test and architecture text edits to the job, in place."""
+    # Text rewrites, in the order of the old submit_lava.sh. They run whil=
e
+    # branch and distribution are still placeholders (DEFERRED_VARIABLES):
+    # 1. test texts (kernel-panic, initramfs-crash) match the original
+    #    fragment text, so they run first.
+    #    Per-target texts (M-COM overlay name) follow.
+    for old, new in spec.get("replace", []) + arch.get("replace", []):
+        replace_in_strings(job, old, new)
+    # 2. '-broken.swu' update image: first '.swu' of each string only.
+    if spec.get("broken_swu"):
+        replace_in_strings(job, ".swu", "-broken.swu", 1)
+    # 3. guest disk name (vda on arm); after 1 so '/dev/sda5' inserted by
+    #    initramfs-crash (amd64 only) is never renamed.
+    if "disk" in arch:
+        replace_in_strings(job, "sda", arch["disk"])
+    # 4. EFI boot loader name (bootaa64.efi, bootarm.efi).
+    if "efi_name" in arch:
+        replace_in_strings(job, "bootx64.efi", arch["efi_name"])
+
+
+def build_job(test: str, target: str, variables: Mapping[str, str]) -> dic=
t:
+    """Build the LAVA job definition for a test and target."""
+    spec =3D job_spec(test)
+    if not is_supported(test, target):
+        raise ValueError(f"unsupported combination: {test} on {target}")
+    arch =3D arch_spec(spec, target)
+    values =3D job_variables(spec, target, variables)
+    early_values =3D defer(values)
+    job =3D assemble(job_blocks(spec, target), early_values)
+    add_steps(job, spec, early_values)
+    rewrite_texts(job, spec, arch)
+    fill_deferred(job, values)
+    # Firmware (qemu-arm64, qemu-arm; never M-COM) is added last, after al=
l
+    # rewrites, since its URL holds the branch name.
+    if target in FIRMWARE_TARGETS:
+        add_firmware(tmpfs_deploy(job), values)
+    return job
+
+
+def parse_args(argv: list[str] | None) -> argparse.Namespace:
+    parser =3D argparse.ArgumentParser(description=3D__doc__)
+    parser.add_argument("--test", required=3DTrue)
+    parser.add_argument("--target", required=3DTrue)
+    parser.add_argument("--release", required=3DTrue)
+    parser.add_argument("--branch", required=3DTrue)
+    parser.add_argument("--iec-timeout", required=3DTrue)
+    parser.add_argument("--out", required=3DTrue, type=3DPath)
+    return parser.parse_args(argv)
+
+
+def main(argv: list[str] | None =3D None) -> int:
+    """Write the job definition for --test/--target into --out."""
+    args =3D parse_args(argv)
+    if args.target not in TARGETS:
+        print(f"error: unsupported target: {args.target}", file=3Dsys.stde=
rr)
+        return 1
+    if args.test =3D=3D "IEC" and not args.iec_timeout:
+        print("error: --iec-timeout must not be empty for IEC", file=3Dsys=
.stderr)
+        return 1
+    variables =3D build_variables(args.target, args.release, args.branch, =
args.iec_timeout)
+    try:
+        if not is_supported(args.test, args.target):
+            print(f"no {args.test} job for {args.target}, nothing written"=
)
+            return 0
+        job =3D build_job(args.test, args.target, variables)
+        name =3D output_filename(args.test, args.target)
+    except ValueError as error:
+        print(f"error: {error}", file=3Dsys.stderr)
+        return 1
+    except KeyError as error:
+        print(f"error: missing value for placeholder {error}", file=3Dsys.=
stderr)
+        return 1
+    args.out.mkdir(parents=3DTrue, exist_ok=3DTrue)
+    path =3D args.out / name
+    write_job(job, path)
+    print(path)
+    return 0
+
+
+if __name__ =3D=3D "__main__":
+    sys.exit(main())
diff --git a/tests/lava_test_helpers.py b/tests/lava_test_helpers.py
new file mode 100644
index 00000000..ac0dd199
--- /dev/null
+++ b/tests/lava_test_helpers.py
@@ -0,0 +1,37 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Shared setup and helpers for the LAVA job generator tests."""
+
+import pathlib
+import sys
+
+TEMPLATES =3D pathlib.Path(__file__).parent / "templates"
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent.parent / "s=
cripts"))
+
+import lava_jobs  # noqa: E402
+
+
+def variables(target, release=3D"trixie"):
+    return lava_jobs.build_variables(target, release, "br", "30")
+
+
+def build(test, target, release=3D"trixie"):
+    return lava_jobs.build_job(test, target, variables(target, release))
+
+
+def all_strings(node):
+    if isinstance(node, dict):
+        for value in node.values():
+            yield from all_strings(value)
+    elif isinstance(node, list):
+        for value in node:
+            yield from all_strings(value)
+    elif isinstance(node, str):
+        yield node
diff --git a/tests/templates/README.md b/tests/templates/README.md
new file mode 100644
index 00000000..decb7a9b
--- /dev/null
+++ b/tests/templates/README.md
@@ -0,0 +1,109 @@
+# LAVA job templates
+
+`scripts/lava_jobs.py` builds LAVA job definitions from the files in this
+directory. Every file is valid YAML, so it can be loaded and checked on it=
s
+own.
+
+```
+blocks/    one part of a job: header, deploy, boot or test action
+steps/     list of shell commands run on the target by a test action
+jobs.yml   which blocks and steps make up each test, plus per-target value=
s
+```
+
+Values that change per job are written as `${name}`, for example
+`${distribution}` or `${architecture}`. The available names are listed in
+`doc/README.lava-testing.md`. Shell variables such as `$LAVA_JOB_ID` or
+`${file}` are not placeholders and stay untouched.
+
+## Example: a new negative software update test
+
+The test applies an update whose `sw-description` is removed and expects
+swupdate to refuse it.
+
+1. Add the shell commands as `steps/missing_sw_description.yml`. Each entr=
y is
+   one command; `${distribution}` and `${architecture}` are filled in:
+
+   ```yaml
+   - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/down=
loads/common/cip-core-image-security-cip-core-${distribution}-${architectur=
e}.swu --output /root/update.swu
+   - mkdir -p /root/swu
+   - cpio -ivd --directory=3D/root/swu < /root/update.swu
+   - rm /root/swu/sw-description
+   - swupdate -l 5 -i /root/update.swu > /root/swupdate.txt
+   - if grep -q "sw-description" /root/swupdate.txt; then echo "verificati=
on successful"; else lava-test-raise "Fail job"; fi
+   ```
+
+2. Add the test to `jobs.yml`. It reuses the blocks of the other negative
+   software update tests and only names the new steps:
+
+   ```yaml
+   swupdate-missing-sw-description:
+     output_name: "{test}_{target}.yml"
+     blocks: *swupdate_negative_blocks
+     steps: {fragment: missing_sw_description}
+     values:
+       job_title: software update testing
+   ```
+
+   `output_name` is the file name; `{test}` and `{target}` are filled in.
+   The `test_swupdate_inline` block contains an empty `steps: []` list; th=
e
+   generator fills it with the commands from the fragment.
+
+3. Generate and check the job:
+
+   ```
+   python3 scripts/lava_jobs.py --test swupdate-missing-sw-description \
+       --target qemu-amd64 --release trixie --branch master \
+       --iec-timeout 30 --out /tmp/jobs
+   lavacli -i <identity> jobs validate /tmp/jobs/swupdate-missing-sw-descr=
iption_qemu-amd64.yml
+   ```
+
+4. Add a unit test (in `tests/test_lava_qemu_jobs.py` for QEMU jobs,
+   `tests/test_lava_mcom_jobs.py` for MCOM jobs), and a `test_function` en=
try
+   in `.gitlab-ci.yml` to run the test in the pipeline.
+
+## Adding a new block
+
+Create `blocks/<name>.yml` with the action as a list item, for example a
+test action:
+
+```yaml
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "check the kernel version"
+        run:
+          steps:
+            - uname -r | grep -q ${context_architecture}
+      from: inline
+      name: sample-test-4
+      path: inline/sample-test.yaml
+```
+
+Then list `<name>` in the `blocks:` of a test in `jobs.yml`. Blocks are
+added to `actions` in the listed order. A block that is a mapping (for
+example `header_qemu` or `context_qemu`) becomes top-level keys of the job
+instead. The `jobs.yml` header describes all keys, including `per_arch` fo=
r
+target specific blocks, values and text replacements.
+
+The `boot_mcom`, `boot_mcom_secureboot` and `boot_mcom_after_update`
+blocks are near-copies; keep them in sync.
+
+## Run the tests
+
+```
+python3 -m unittest discover -s tests
+```
+
+The tests are split by area: `tests/test_lava_fragments.py` (fragments and
+placeholders), `test_lava_core.py` (variables, firmware, job writing),
+`test_lava_qemu_jobs.py`, `test_lava_mcom_jobs.py`, `test_lava_branch_name=
s.py`
+and `test_lava_cli.py`. A single area runs with e.g.
+
+```
+python3 -m unittest tests.test_lava_qemu_jobs
+```
diff --git a/tests/templates/blocks/action_tpm.yml b/tests/templates/blocks=
/action_tpm.yml
new file mode 100644
index 00000000..004ee005
--- /dev/null
+++ b/tests/templates/blocks/action_tpm.yml
@@ -0,0 +1,14 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# ACTION BLOCK
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 20
diff --git a/tests/templates/blocks/boot_after_update.yml b/tests/templates=
/blocks/boot_after_update.yml
new file mode 100644
index 00000000..b7ace1fb
--- /dev/null
+++ b/tests/templates/blocks/boot_after_update.yml
@@ -0,0 +1,24 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- boot:
+    timeout:
+      minutes: 5
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
+    parameters:
+       kernel-start-message: "kernel: C:BOOT1:linux.efi"
diff --git a/tests/templates/blocks/boot_mcom.yml b/tests/templates/blocks/=
boot_mcom.yml
new file mode 100644
index 00000000..d5105424
--- /dev/null
+++ b/tests/templates/blocks/boot_mcom.yml
@@ -0,0 +1,28 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK
+- boot:
+    method: minimal
+    timeout:
+      minutes: 45
+    reset: true
+    failure_retry: 1
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
+    transfer_overlay:
+      transfer_method: http
+      download_command: "curl -H 'Connection: close' -v --trace-time --out=
put overlay-1.1.1.4.tar.gz"
+      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C /home/la=
va/ -xf
diff --git a/tests/templates/blocks/boot_mcom_after_update.yml b/tests/temp=
lates/blocks/boot_mcom_after_update.yml
new file mode 100644
index 00000000..c6bf047d
--- /dev/null
+++ b/tests/templates/blocks/boot_mcom_after_update.yml
@@ -0,0 +1,24 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK (after update, no overlay transfer)
+- boot:
+    method: minimal
+    timeout:
+      minutes: 45
+    reset: true
+    failure_retry: 1
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
diff --git a/tests/templates/blocks/boot_mcom_secureboot.yml b/tests/templa=
tes/blocks/boot_mcom_secureboot.yml
new file mode 100644
index 00000000..b26bfb86
--- /dev/null
+++ b/tests/templates/blocks/boot_mcom_secureboot.yml
@@ -0,0 +1,30 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK (secure boot positive test)
+- boot:
+    method: minimal
+    timeout:
+      minutes: 45
+    reset: true
+    failure_retry: 1
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
+    transfer_overlay:
+      transfer_method: http
+      download_command: "curl -H 'Connection: close' -v --trace-time --out=
put overlay-1.1.1.4.tar.gz"
+      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C /home/la=
va/ -xf
+    parameters:
+      kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
diff --git a/tests/templates/blocks/boot_qemu.yml b/tests/templates/blocks/=
boot_qemu.yml
new file mode 100644
index 00000000..dc92cbfe
--- /dev/null
+++ b/tests/templates/blocks/boot_qemu.yml
@@ -0,0 +1,23 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 25
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
diff --git a/tests/templates/blocks/boot_qemu_noprompt.yml b/tests/template=
s/blocks/boot_qemu_noprompt.yml
new file mode 100644
index 00000000..90c2bffa
--- /dev/null
+++ b/tests/templates/blocks/boot_qemu_noprompt.yml
@@ -0,0 +1,15 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK (negative tests, no login; the monitor test follows)
+- boot:
+    timeout:
+      minutes: 25
+    method: qemu
+    media: tmpfs
diff --git a/tests/templates/blocks/boot_qemu_secureboot.yml b/tests/templa=
tes/blocks/boot_qemu_secureboot.yml
new file mode 100644
index 00000000..f0abce15
--- /dev/null
+++ b/tests/templates/blocks/boot_qemu_secureboot.yml
@@ -0,0 +1,25 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# BOOT BLOCK (secure boot positive test)
+- boot:
+    timeout:
+      minutes: 25
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
+    parameters:
+      kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
diff --git a/tests/templates/blocks/context_qemu.yml b/tests/templates/bloc=
ks/context_qemu.yml
new file mode 100644
index 00000000..caae9f82
--- /dev/null
+++ b/tests/templates/blocks/context_qemu.yml
@@ -0,0 +1,13 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+context:
+  arch: ${context_architecture}
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/blocks/deploy_downloads_postprocess.yml b/test=
s/templates/blocks/deploy_downloads_postprocess.yml
new file mode 100644
index 00000000..29eee1a1
--- /dev/null
+++ b/tests/templates/blocks/deploy_downloads_postprocess.yml
@@ -0,0 +1,22 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# DEPLOY BLOCK (download and modify image); steps are inserted by code
+- deploy:
+    to: downloads
+    timeout:
+      minutes: 30
+    images:
+      system:
+        url: ${project_url}/${branch}/${architecture}/cip-core-image-secur=
ity-cip-core-${distribution}-${architecture}.wic.zst
+        compression: zstd
+    postprocess:
+      docker:
+        image: debian:bookworm
+        steps: []
diff --git a/tests/templates/blocks/deploy_mcom.yml b/tests/templates/block=
s/deploy_mcom.yml
new file mode 100644
index 00000000..9979c5e6
--- /dev/null
+++ b/tests/templates/blocks/deploy_mcom.yml
@@ -0,0 +1,17 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# DEPLOY BLOCK
+- deploy:
+    timeout:
+      minutes: 60
+    to: flasher
+    images:
+      image:
+        url: ${project_url}/${branch}/x86-uefi/cip-core-image-security-cip=
-core-${distribution}-x86-uefi.wic.zst
diff --git a/tests/templates/blocks/deploy_mcom_swu.yml b/tests/templates/b=
locks/deploy_mcom_swu.yml
new file mode 100644
index 00000000..2b445fc8
--- /dev/null
+++ b/tests/templates/blocks/deploy_mcom_swu.yml
@@ -0,0 +1,18 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# DEPLOY BLOCK (.swu to downloads, before the flasher deploy)
+# swupdate -d does not work on M-COM, so the .swu file is deployed to down=
loads
+- deploy:
+    timeout:
+      minutes: 60
+    to: downloads
+    images:
+      image:
+        url: ${project_url}/${branch}/x86-uefi/cip-core-image-security-cip=
-core-${distribution}-x86-uefi.swu
diff --git a/tests/templates/blocks/deploy_swu.yml b/tests/templates/blocks=
/deploy_swu.yml
new file mode 100644
index 00000000..7cc5721c
--- /dev/null
+++ b/tests/templates/blocks/deploy_swu.yml
@@ -0,0 +1,16 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- deploy:
+    timeout:
+      minutes: 10
+    to: downloads
+    images:
+      image:
+        url: ${project_url}/${branch}/${architecture}/cip-core-image-secur=
ity-cip-core-${distribution}-${architecture}.swu
diff --git a/tests/templates/blocks/deploy_tmpfs.yml b/tests/templates/bloc=
ks/deploy_tmpfs.yml
new file mode 100644
index 00000000..2728b609
--- /dev/null
+++ b/tests/templates/blocks/deploy_tmpfs.yml
@@ -0,0 +1,22 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# DEPLOY BLOCK
+# images.firmware (qemu-arm64, qemu-arm) is added by scripts/lava_jobs.py
+- deploy:
+    timeout:
+      minutes: 30
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
+                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm ${imagearg=
s}'
+        url: ${project_url}/${branch}/${architecture}/cip-core-image-secur=
ity-cip-core-${distribution}-${architecture}.wic.zst
+        compression: zstd
diff --git a/tests/templates/blocks/deploy_tmpfs_downloaded.yml b/tests/tem=
plates/blocks/deploy_tmpfs_downloaded.yml
new file mode 100644
index 00000000..2fdd2349
--- /dev/null
+++ b/tests/templates/blocks/deploy_tmpfs_downloaded.yml
@@ -0,0 +1,21 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# DEPLOY BLOCK (use image modified by downloads postprocess)
+# Firmware keys are inserted by code
+- deploy:
+    timeout:
+      minutes: 30
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
+                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm ${imagearg=
s}'
+        url: downloads://cip-core-image-security-cip-core-${distribution}-=
${architecture}.wic
diff --git a/tests/templates/blocks/header_mcom.yml b/tests/templates/block=
s/header_mcom.yml
new file mode 100644
index 00000000..bf140cba
--- /dev/null
+++ b/tests/templates/blocks/header_mcom.yml
@@ -0,0 +1,29 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+job_name: mtda-mcom-${test_function}
+device_type: mcom-mtda
+timeouts:
+  job:
+    minutes: 180
+  action:
+    minutes: 95
+  connection:
+    minutes: 25
+priority: medium
+visibility: public
+context:
+  lava_test_results_dir: /home/lava/%s
+notify:
+  criteria:
+    status: finished
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results@lists.cip-project.org
diff --git a/tests/templates/blocks/header_qemu.yml b/tests/templates/block=
s/header_qemu.yml
new file mode 100644
index 00000000..cdd3c44c
--- /dev/null
+++ b/tests/templates/blocks/header_qemu.yml
@@ -0,0 +1,31 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# ${job_title}: "IEC layer testing" | "secure boot testing" | "software up=
date testing"
+device_type: qemu
+job_name: ${architecture} ${job_title}
+timeouts:
+  job:
+    minutes: 50
+  action:
+   minutes: 40
+  actions:
+    power-off:
+      seconds: 60
+priority: medium
+tags:
+- swtpm-jobs
+visibility: public
+notify:
+  criteria:
+    status: finished
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results@lists.cip-project.org
diff --git a/tests/templates/blocks/monitor.yml b/tests/templates/blocks/mo=
nitor.yml
new file mode 100644
index 00000000..c089a0b1
--- /dev/null
+++ b/tests/templates/blocks/monitor.yml
@@ -0,0 +1,17 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- test:
+    monitors:
+    - end: "${end_monitor}"
+      name: corrupted-${artifact}-image
+      pattern: _unused_
+      start: "${start_monitor}"
+    timeout:
+      minutes: 25
diff --git a/tests/templates/blocks/test_iec.yml b/tests/templates/blocks/t=
est_iec.yml
new file mode 100644
index 00000000..b935bf31
--- /dev/null
+++ b/tests/templates/blocks/test_iec.yml
@@ -0,0 +1,19 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# TEST_BLOCK
+- test:
+     timeout:
+       minutes: ${IEC_TEST_TIMEOUT_MINUTES}
+     definitions:
+     - repository: https://gitlab.com/cip-project/cip-testing/cip-security=
-tests.git
+       from: git
+       revision: 88134a939f06c456d4978db9c050f9afc74c5d3b
+       path: iec-security-tests/Singlenode-TestDefinition.yaml
+       name: Security-Testcases
diff --git a/tests/templates/blocks/test_swupdate_apply.yml b/tests/templat=
es/blocks/test_swupdate_apply.yml
new file mode 100644
index 00000000..45f692f3
--- /dev/null
+++ b/tests/templates/blocks/test_swupdate_apply.yml
@@ -0,0 +1,26 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# TEST_BLOCK 1
+# Fail the job if software update application failed
+- test:
+    timeout:
+      minutes: 15
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update"
+        run:
+          steps:
+            - if swupdate -l 5 -d "-u ${project_url}/${branch}/${architect=
ure}/cip-core-image-security-cip-core-${distribution}-${architecture}.swu";=
 then echo software update is successful!!; else lava-test-raise "Fail job"=
; fi
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
diff --git a/tests/templates/blocks/test_swupdate_check_ustate.yml b/tests/=
templates/blocks/test_swupdate_check_ustate.yml
new file mode 100644
index 00000000..9c9fbc6f
--- /dev/null
+++ b/tests/templates/blocks/test_swupdate_check_ustate.yml
@@ -0,0 +1,26 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# TEST BLOCK 2
+# Fail the job if ustate is not ${updatestate} after reboot
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "check boot loader environment variables"
+        run:
+          steps:
+            - if [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $=
2}') =3D ${updatestate} ]; then bg_setenv -c; else lava-test-raise "Fail jo=
b"; fi
+      from: inline
+      name: sample-test-2
+      path: inline/sample-test.yaml
diff --git a/tests/templates/blocks/test_swupdate_inline.yml b/tests/templa=
tes/blocks/test_swupdate_inline.yml
new file mode 100644
index 00000000..6c8f258f
--- /dev/null
+++ b/tests/templates/blocks/test_swupdate_inline.yml
@@ -0,0 +1,26 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# TEST_BLOCK
+# Fail the job if software update application error is not as expected
+# steps are inserted by code (see steps/)
+- test:
+    timeout:
+      minutes: 25
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update by modifying the files"
+        run:
+          steps: []
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
diff --git a/tests/templates/blocks/test_swupdate_mcom.yml b/tests/template=
s/blocks/test_swupdate_mcom.yml
new file mode 100644
index 00000000..b1f8556d
--- /dev/null
+++ b/tests/templates/blocks/test_swupdate_mcom.yml
@@ -0,0 +1,27 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# TEST BLOCK 1
+# Fail the job if software update application failed
+- test:
+    timeout:
+      minutes: 15
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update"
+        run:
+          steps:
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JO=
B_ID/downloads/common/cip-core-image-security-cip-core-${distribution}-x86-=
uefi.swu --output test.swu
+            - if swupdate -l 5 -i test.swu; then echo software update is s=
uccessful!!; else lava-test-raise "Fail job"; fi
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
diff --git a/tests/templates/blocks/tpm_restart.yml b/tests/templates/block=
s/tpm_restart.yml
new file mode 100644
index 00000000..7bc470ec
--- /dev/null
+++ b/tests/templates/blocks/tpm_restart.yml
@@ -0,0 +1,21 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# qemu-swtpm.sock will be gone after soft reboot.
+# So the swtpm socket need to be started again for proper reboot
+# To start the swtpm daemon, first the existing one should be killed
+- command:
+    name: manual_kill
+    timeout:
+          minutes: 1
+# Start the swtpm daemon
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 1
diff --git a/tests/templates/jobs.yml b/tests/templates/jobs.yml
new file mode 100644
index 00000000..95911cd4
--- /dev/null
+++ b/tests/templates/jobs.yml
@@ -0,0 +1,193 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# QEMU LAVA job definitions, assembled by scripts/lava_jobs.py.
+#
+# Per test:
+#   output_name:  file name, format string over {test} and {target}
+#   blocks:       ordered fragment names (tests/templates/blocks, steps);
+#                 mapping fragments become top-level keys, list fragments
+#                 are appended to `actions`
+#   steps:        optional; `fragment: <name>` or `inline: [..]`, inserted
+#                 into the first empty `steps: []` list
+#   values:       substitution values (job_title, monitors, ...); updatest=
ate
+#                 is the expected ustate in the check step (`) =3D N`), de=
fault 2
+#   per_arch:     {<target>: {values: {...}, disk: vda, efi_name: ...}}
+#   targets:      optional list of supported targets (others: nothing writ=
ten);
+#                 default: the QEMU targets. M-COM (x86-uefi) must be list=
ed.
+#   per_arch.<target>.blocks: replaces `blocks` for that target (M-COM)
+#   replace:      ordered [old, new] string replacements over the parsed j=
ob
+#   per_arch.<target>.replace: same, for that target only (after `replace`=
)
+#   broken_swu:   deploy the '-broken.swu' update image
+#   swap_ovmf:    use OVMF keys of the other release (mismatch keys test)
+
+tests:
+  IEC:
+    output_name: "{test}_{target}.yml"
+    blocks: [header_qemu, action_tpm, deploy_tmpfs, boot_qemu, test_iec, c=
ontext_qemu]
+    values:
+      job_title: IEC layer testing
+    targets: &with_mcom [qemu-amd64, qemu-arm64, qemu-arm, x86-uefi]
+    per_arch:
+      x86-uefi:
+        blocks: [header_mcom, deploy_mcom, boot_mcom, test_iec]
+        values:
+          test_function: IEC
+
+  secure-boot:
+    output_name: "{test}_{target}.yml"
+    blocks: [header_qemu, action_tpm, deploy_tmpfs, boot_qemu_secureboot, =
context_qemu]
+    values:
+      job_title: secure boot testing
+    targets: *with_mcom
+    per_arch:
+      x86-uefi:
+        blocks: [header_mcom, deploy_mcom, boot_mcom_secureboot]
+        values:
+          test_function: secure-boot
+
+  swupdate:
+    output_name: "{test}_{target}.yml"
+    blocks: &swupdate_blocks
+      [header_qemu, action_tpm, deploy_tmpfs, boot_qemu, test_swupdate_app=
ly,
+       tpm_restart, boot_after_update, test_swupdate_check_ustate, context=
_qemu]
+    values:
+      job_title: software update testing
+    targets: *with_mcom
+    per_arch:
+      x86-uefi:
+        blocks:
+          [header_mcom, deploy_mcom_swu, deploy_mcom, boot_mcom,
+           test_swupdate_mcom, boot_mcom_after_update, test_swupdate_check=
_ustate]
+        values:
+          test_function: swupdate
+          updatestate: 2
+        replace:
+          - ["overlay-1.1.1.4", "overlay-2.1.1.4"]
+
+  kernel-panic:
+    output_name: "{test}.yml"
+    blocks: *swupdate_blocks
+    values:
+      job_title: kernel-panic_rollback_testing
+      updatestate: 3
+    replace:
+      - ["kernel: C:BOOT1:linux.efi", "Kernel panic - not syncing: sysrq t=
riggered crash"]
+    broken_swu: true
+
+  initramfs-crash:
+    output_name: "{test}.yml"
+    blocks: *swupdate_blocks
+    values:
+      job_title: initramfs-crash_rollback_testing
+      updatestate: 3
+    replace:
+      - ["kernel: C:BOOT1:linux.efi", "Can't open verity rootfs - continui=
ng will lead to a broken trust chain!"]
+      - ["echo software update is successful!!", "dd if=3D/dev/urandom of=
=3D/dev/sda5 bs=3D512 count=3D1"]
+
+  swupdate-reboot-without-confirm:
+    output_name: "{test}_reboot_without_confirm_{target}.yml"
+    blocks:
+      [header_qemu, action_tpm, deploy_tmpfs, boot_qemu, test_swupdate_app=
ly,
+       tpm_restart, boot_after_update, test_swupdate_check_ustate,
+       reboot_without_confirm, context_qemu]
+    values:
+      job_title: software update testing
+    replace:
+      - ["bg_setenv -c", "echo No update confirm"]
+
+  secure-boot-unsigned-kernel:
+    output_name: "{test}_unsigned_kernel_{target}.yml"
+    blocks: &secureboot_negative_blocks
+      [header_qemu, action_tpm, deploy_downloads_postprocess,
+       deploy_tmpfs_downloaded, boot_qemu_noprompt, monitor, context_qemu]
+    steps: {fragment: unsigned_kernel}
+    values:
+      job_title: secure boot testing
+      artifact: linux
+      start_monitor: Cannot load specified kernel image
+      end_monitor: Access Denied
+    per_arch:
+      qemu-arm64: &unsigned_kernel_arm
+        disk: vda
+        values:
+          start_monitor: Image not authenticated
+          end_monitor: Application failed
+      qemu-arm: *unsigned_kernel_arm
+
+  secure-boot-unsigned-bootloader:
+    output_name: "{test}_unsigned_bootloader_{target}.yml"
+    blocks: *secureboot_negative_blocks
+    steps: {fragment: unsigned_bootloader}
+    values:
+      job_title: secure boot testing
+      artifact: bootloader
+      start_monitor: Access Denied
+      end_monitor: "BdsDxe: failed to load Boot"
+    per_arch:
+      qemu-arm64:
+        disk: vda
+        efi_name: bootaa64.efi
+        values: &unsigned_bootloader_arm
+          start_monitor: Image not authenticated
+          end_monitor: EFI Boot failed!
+      qemu-arm:
+        disk: vda
+        efi_name: bootarm.efi
+        values: *unsigned_bootloader_arm
+
+  secure-boot-corrupt-rootfs:
+    output_name: "{test}_corrupt_rootfs_{target}.yml"
+    blocks: *secureboot_negative_blocks
+    steps: {fragment: corrupt_rootfs}
+    values:
+      job_title: secure boot testing
+      artifact: rootfs
+      start_monitor: "EFI stub: UEFI Secure Boot is enabled."
+      end_monitor: "reboot: Restarting system with command 'dm-verity devi=
ce corrupted'"
+    per_arch:
+      qemu-arm64:
+        efi_name: bootaa64.efi
+      qemu-arm:
+        efi_name: bootarm.efi
+
+  secure-boot-mismatch-keys:
+    output_name: "{test}_mismatch_keys_{target}.yml"
+    targets: [qemu-amd64]
+    blocks: *secureboot_negative_blocks
+    steps: {inline: ["echo 'no postprocess steps'"]}
+    swap_ovmf: true
+    values:
+      job_title: secure boot testing
+      artifact: keys
+      start_monitor: Access Denied
+      end_monitor: "BdsDxe: failed to load Boot"
+
+  swupdate-corrupt-swu:
+    output_name: "{test}_corrupt_swu_{target}.yml"
+    blocks: &swupdate_negative_blocks
+      [header_qemu, action_tpm, deploy_swu, deploy_tmpfs, boot_qemu,
+       test_swupdate_inline, context_qemu]
+    steps: {fragment: corrupt_swu}
+    values:
+      job_title: software update testing
+
+  swupdate-corrupt-swu-artifact:
+    output_name: "{test}_corrupt_swu_artifact_{target}.yml"
+    blocks: *swupdate_negative_blocks
+    steps: {fragment: corrupt_swu_artifact}
+    values:
+      job_title: software update testing
+
+  swupdate-apply-same-image-swu:
+    output_name: "{test}_same_uuid_{target}.yml"
+    blocks: *swupdate_negative_blocks
+    steps: {fragment: same_uuid}
+    values:
+      job_title: software update testing
diff --git a/tests/templates/steps/corrupt_rootfs.yml b/tests/templates/ste=
ps/corrupt_rootfs.yml
new file mode 100644
index 00000000..e48f29d6
--- /dev/null
+++ b/tests/templates/steps/corrupt_rootfs.yml
@@ -0,0 +1,16 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- "apt-get update"
+- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y fdisk"
+- "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-image-security-=
cip-core-${distribution}-${architecture}.wic | awk -v name=3Dsystema '$0 ~ =
name {print $2}')"
+- "rootfs_start=3D$((${rootfs_start_sector} * 512))"
+# The value 96 is squashfs superblock header size, so skip header and corr=
upt the data after that.
+- "offset=3D$((${rootfs_start} + 96))"
+- "dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-${distribution}=
-${architecture}.wic bs=3D1 seek=3D${offset} count=3D8 conv=3Dnotrunc"
diff --git a/tests/templates/steps/corrupt_swu.yml b/tests/templates/steps/=
corrupt_swu.yml
new file mode 100644
index 00000000..7bcc9eef
--- /dev/null
+++ b/tests/templates/steps/corrupt_swu.yml
@@ -0,0 +1,15 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloa=
ds/common/cip-core-image-security-cip-core-${distribution}-${architecture}.=
swu --output /root/cip-core-image-security-cip-core-${distribution}-${archi=
tecture}.swu
+- mkdir -p swu
+- dd if=3D/dev/zero of=3D/root/cip-core-image-security-cip-core-${distribu=
tion}-${architecture}.swu bs=3D1M count=3D5
+- swupdate -l 5 -i /root/cip-core-image-security-cip-core-${distribution}-=
${architecture}.swu > /root/swupdate.txt
+- cat /root/swupdate.txt
+- if grep -q "CPIO Header corrupted, cannot be parsed" /root/swupdate.txt;=
 then echo ".swu file corrupt test verification successful!!!"; else lava-t=
est-raise "Fail job"; fi
diff --git a/tests/templates/steps/corrupt_swu_artifact.yml b/tests/templat=
es/steps/corrupt_swu_artifact.yml
new file mode 100644
index 00000000..2c2ce0d8
--- /dev/null
+++ b/tests/templates/steps/corrupt_swu_artifact.yml
@@ -0,0 +1,18 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloa=
ds/common/cip-core-image-security-cip-core-${distribution}-${architecture}.=
swu --output /root/cip-core-image-security-cip-core-${distribution}-${archi=
tecture}.swu
+- mkdir -p swu
+- cpio -ivd --directory=3D/root/swu < /root/cip-core-image-security-cip-co=
re-${distribution}-${architecture}.swu
+- dd if=3D/dev/zero of=3D/root/swu/cip-core-image-security-cip-core-${dist=
ribution}-${architecture}.delta_update bs=3D1 count=3D256
+- cd /root/swu
+- for file in sw-description sw-description.sig cip-core-image-security-ci=
p-core-${distribution}-${architecture}.delta_update linux.efi; do echo "${f=
ile}"; done | cpio -ovL --reproducible -H crc > cip-core-image-security-cip=
-core-${distribution}-${architecture}.swu
+- swupdate -l 5 -i cip-core-image-security-cip-core-${distribution}-${arch=
itecture}.swu > /root/swupdate.txt
+- cat /root/swupdate.txt
+- if grep -q "Image invalid or corrupted" /root/swupdate.txt; then echo "k=
ernel file corrupt test verification successful!!"; else lava-test-raise "F=
ail job"; fi
diff --git a/tests/templates/steps/reboot_without_confirm.yml b/tests/templ=
ates/steps/reboot_without_confirm.yml
new file mode 100644
index 00000000..dcad0b95
--- /dev/null
+++ b/tests/templates/steps/reboot_without_confirm.yml
@@ -0,0 +1,54 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# qemu-swtpm.sock will be gone after soft reboot.
+# So the swtpm socket need to be started again for proper reboot
+# To start the swtpm daemon, first the existing one should be killed
+- command:
+    name: manual_kill
+    timeout:
+          minutes: 1
+# Start the swtpm daemon
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 1
+
+- boot:
+    timeout:
+      minutes: 5
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+      login_commands:
+        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
+    parameters:
+       kernel-start-message: "kernel: C:BOOT0:linux.efi"
+
+# Fail the job if ustate is not 3 (failed) after reboot
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "check boot loader environment variables"
+        run:
+          steps:
+            - if [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $=
2}') =3D 3 ]; then echo ustate status failed; else lava-test-raise "Fail jo=
b"; fi
+      from: inline
+      name: sample-test-3
+      path: inline/sample-test.yaml
diff --git a/tests/templates/steps/same_uuid.yml b/tests/templates/steps/sa=
me_uuid.yml
new file mode 100644
index 00000000..d9f1e4a8
--- /dev/null
+++ b/tests/templates/steps/same_uuid.yml
@@ -0,0 +1,18 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloa=
ds/common/cip-core-image-security-cip-core-${distribution}-${architecture}.=
swu --output /root/cip-core-image-security-cip-core-${distribution}-${archi=
tecture}.swu
+- mkdir -p swu
+- cpio -ivd --directory=3D/root/swu < /root/cip-core-image-security-cip-co=
re-${distribution}-${architecture}.swu
+- current_uuid=3D$( cat /etc/os-release | grep IMAGE_UUID=3D | cut -d'"' -=
f 2)
+- swu_uuid=3D$(cat /root/swu/sw-description | grep IMAGE_UUID | cut -d'=3D=
' -f3 | cut -c 1-36)
+- sed -i s/$current_uuid/$swu_uuid/g /etc/os-release
+- swupdate -l 5 -i /root/cip-core-image-security-cip-core-${distribution}-=
${architecture}.swu > /root/swupdate.txt
+- cat /root/swupdate.txt
+- if grep -q "'configfilecheck()' failed" /root/swupdate.txt; then echo "t=
est verification successful!!!"; else lava-test-raise "Fail job"; fi
diff --git a/tests/templates/steps/unsigned_bootloader.yml b/tests/template=
s/steps/unsigned_bootloader.yml
new file mode 100644
index 00000000..13592a77
--- /dev/null
+++ b/tests/templates/steps/unsigned_bootloader.yml
@@ -0,0 +1,16 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- "apt-get update"
+- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y guestfish sbsigntoo=
l"
+- "guestfish add cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
+- "sbverify --list bootx64.efi"
+- "sbattach --remove bootx64.efi"
+- "sbverify --list bootx64.efi"
+- "guestfish add cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic : run : mount /dev/sda1 / : copy-in bootx64.efi /EFI/BOOT/"
diff --git a/tests/templates/steps/unsigned_kernel.yml b/tests/templates/st=
eps/unsigned_kernel.yml
new file mode 100644
index 00000000..d9bd5845
--- /dev/null
+++ b/tests/templates/steps/unsigned_kernel.yml
@@ -0,0 +1,16 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+- "apt-get update"
+- "DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y guestfish sbsigntoo=
l"
+- "guestfish add cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
+- "sbverify --list linux.efi"
+- "sbattach --remove linux.efi"
+- "sbverify --list linux.efi"
+- "guestfish add cip-core-image-security-cip-core-${distribution}-${archit=
ecture}.wic : run : mount /dev/sda2 / : copy-in linux.efi /"
diff --git a/tests/test_lava_branch_names.py b/tests/test_lava_branch_names=
.py
new file mode 100644
index 00000000..99a21b0c
--- /dev/null
+++ b/tests/test_lava_branch_names.py
@@ -0,0 +1,52 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests that branch and distribution names are kept verbatim."""
+
+import pathlib
+import sys
+import unittest
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import all_strings, lava_jobs  # noqa: E402
+
+
+BRANCHES =3D ("fix-sda-x", "a.swu-b", "x-bootx64.efi-y", "trixie-ovmf")
+# (test, target) pairs that run the sda, .swu, bootx64.efi and OVMF rewrit=
es.
+REWRITING_JOBS =3D (
+    ("kernel-panic", "qemu-amd64"),
+    ("secure-boot-unsigned-bootloader", "qemu-arm64"),
+    ("secure-boot-unsigned-kernel", "qemu-arm"),
+    ("secure-boot-mismatch-keys", "qemu-amd64"),
+)
+
+
+class BranchVerbatimTests(unittest.TestCase):
+    def test_urls_keep_branch_verbatim(self):
+        for branch in BRANCHES:
+            for test, target in REWRITING_JOBS:
+                with self.subTest(branch=3Dbranch, test=3Dtest, target=3Dt=
arget):
+                    v =3D lava_jobs.build_variables(target, "trixie", bran=
ch, "30")
+                    job =3D lava_jobs.build_job(test, target, v)
+                    urls =3D [s for s in all_strings(job)
+                            if s.startswith(lava_jobs.PROJECT_URL)]
+                    self.assertTrue(urls)
+                    for url in urls:
+                        self.assertIn(f"/{branch}/", url)
+
+    def test_distribution_kept_verbatim(self):
+        v =3D lava_jobs.build_variables("qemu-arm64", "sda.swu", "br", "30=
")
+        job =3D lava_jobs.build_job("secure-boot-unsigned-kernel", "qemu-a=
rm64", v)
+        text =3D "\n".join(all_strings(job))
+        self.assertIn("cip-core-sda.swu-qemu-arm64.wic", text)
+        self.assertIn("/dev/vda2", text)
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
diff --git a/tests/test_lava_cli.py b/tests/test_lava_cli.py
new file mode 100644
index 00000000..7edcca5a
--- /dev/null
+++ b/tests/test_lava_cli.py
@@ -0,0 +1,87 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests for the lava_jobs command line and its error handling."""
+
+import pathlib
+import sys
+import tempfile
+import unittest
+from unittest import mock
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import build, lava_jobs  # noqa: E402
+
+
+class CommandLineTests(unittest.TestCase):
+    def test_mismatch_keys_arm64_writes_nothing(self):
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "secure-boot-mismatch-keys",
+                                 "--target", "qemu-arm64", "--release", "t=
rixie",
+                                 "--branch", "br", "--iec-timeout", "30", =
"--out", d])
+            self.assertEqual(rc, 0)
+            self.assertEqual(list(pathlib.Path(d).iterdir()), [])
+
+    def test_unknown_test_exits_nonzero(self):
+        with self.assertRaises(ValueError):
+            build("no-such-test", "qemu-amd64")
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "no-such-test", "--target", "=
qemu-amd64",
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", d])
+            self.assertNotEqual(rc, 0)
+
+    def test_malformed_target_exits_nonzero(self):
+        for target in ("qemu", "foo"):
+            with self.subTest(target=3Dtarget), tempfile.TemporaryDirector=
y() as d:
+                rc =3D lava_jobs.main(["--test", "swupdate", "--target", t=
arget,
+                                     "--release", "trixie", "--branch", "b=
r",
+                                     "--iec-timeout", "30", "--out", d])
+                self.assertNotEqual(rc, 0)
+                self.assertEqual(list(pathlib.Path(d).iterdir()), [])
+
+    def test_main_writes_output_filename(self):
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "swupdate", "--target", "qemu=
-arm",
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", d])
+            self.assertEqual(rc, 0)
+            out =3D pathlib.Path(d) / "swupdate_qemu-arm.yml"
+            self.assertEqual(lava_jobs.load_yaml(out)["device_type"], "qem=
u")
+
+    def test_main_creates_missing_out_dir(self):
+        with tempfile.TemporaryDirectory() as d:
+            out =3D pathlib.Path(d) / "a" / "b"
+            rc =3D lava_jobs.main(["--test", "swupdate", "--target", "qemu=
-arm",
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", str(out)]=
)
+            self.assertEqual(rc, 0)
+            self.assertTrue((out / "swupdate_qemu-arm.yml").exists())
+
+    def test_main_reports_missing_variable(self):
+        with tempfile.TemporaryDirectory() as d, \
+                mock.patch.object(lava_jobs, "build_job", side_effect=3DKe=
yError("x")):
+            rc =3D lava_jobs.main(["--test", "swupdate", "--target", "qemu=
-arm",
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", d])
+            self.assertEqual(rc, 1)
+            self.assertEqual(list(pathlib.Path(d).iterdir()), [])
+
+    def test_iec_with_empty_timeout_fails_early(self):
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "IEC", "--target", "qemu-arm"=
,
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "", "--out", d])
+            self.assertEqual(rc, 1)
+            self.assertEqual(list(pathlib.Path(d).iterdir()), [])
+
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
diff --git a/tests/test_lava_core.py b/tests/test_lava_core.py
new file mode 100644
index 00000000..bb21c456
--- /dev/null
+++ b/tests/test_lava_core.py
@@ -0,0 +1,61 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests for variable building, firmware and job writing."""
+
+import pathlib
+import sys
+import tempfile
+import unittest
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import lava_jobs  # noqa: E402
+
+
+class CoreTests(unittest.TestCase):
+    def test_build_variables_context_arch(self):
+        v =3D lava_jobs.build_variables("qemu-arm64", "trixie", "next", "3=
0")
+        self.assertEqual(v["context_architecture"], "arm64")
+
+    def test_build_variables_imageargs_amd64_uses_release(self):
+        v =3D lava_jobs.build_variables("qemu-amd64", "trixie", "next", "3=
0")
+        self.assertIn("trixie-ovmf", v["imageargs"])
+
+    def test_build_variables_imageargs_empty_for_unknown_target(self):
+        v =3D lava_jobs.build_variables("x86-uefi", "trixie", "next", "30"=
)
+        self.assertEqual(v["imageargs"], "")
+        self.assertEqual(v["context_architecture"], "uefi")
+
+    def test_add_firmware_adds_images_firmware(self):
+        v =3D lava_jobs.build_variables("qemu-arm64", "trixie", "next", "3=
0")
+        deploy =3D {"images": {}}
+        lava_jobs.add_firmware(deploy, v)
+        fw =3D deploy["images"]["firmware"]
+        self.assertEqual(fw["image_arg"], "-bios {firmware}")
+        self.assertTrue(fw["url"].endswith("/next/qemu-arm64/firmware.bin"=
))
+
+    def test_load_fragment_corrupt_rootfs_keeps_shell_vars(self):
+        v =3D lava_jobs.build_variables("qemu-arm64", "trixie", "next", "3=
0")
+        steps =3D lava_jobs.load_fragment("corrupt_rootfs", v)
+        text =3D "\n".join(str(s) for s in steps)
+        self.assertIn("${rootfs_start}", text)
+        self.assertIn("trixie-qemu-arm64", text)
+
+    def test_write_job_roundtrip(self):
+        job =3D {"z": 1, "a": "x" * 500}
+        with tempfile.TemporaryDirectory() as d:
+            path =3D pathlib.Path(d) / "job.yml"
+            lava_jobs.write_job(job, path)
+            self.assertEqual(lava_jobs.load_yaml(path), job)
+            self.assertEqual(len(path.read_text().splitlines()), 2)
+
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
diff --git a/tests/test_lava_fragments.py b/tests/test_lava_fragments.py
new file mode 100644
index 00000000..f6f83644
--- /dev/null
+++ b/tests/test_lava_fragments.py
@@ -0,0 +1,73 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests for the YAML fragments and placeholder substitution."""
+
+import pathlib
+import sys
+import unittest
+
+import yaml
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import TEMPLATES, lava_jobs  # noqa: E402
+
+
+class FragmentTests(unittest.TestCase):
+    def test_all_fragments_parse(self):
+        files =3D []
+        for sub in ("blocks", "steps"):
+            files +=3D sorted((TEMPLATES / sub).glob("*.yml"))
+        self.assertTrue(files, "no fragments found")
+        for f in files:
+            with self.subTest(fragment=3Df.name):
+                self.assertIsNotNone(yaml.safe_load(f.read_text()))
+
+
+JOBS_YML =3D TEMPLATES / "jobs.yml"
+# ${name} forms in fragments that are shell variables, not placeholders.
+SHELL_VARIABLES =3D ("file", "offset", "rootfs_start", "rootfs_start_secto=
r")
+
+
+class PlaceholderTests(unittest.TestCase):
+    def test_substitute_replaces_known(self):
+        out =3D lava_jobs.substitute("a ${branch} b", {"branch": "next"})
+        self.assertEqual(out, "a next b")
+
+    def test_substitute_missing_variable_raises(self):
+        with self.assertRaises(KeyError):
+            lava_jobs.substitute("a ${branch}", {})
+
+    def test_substitute_keeps_shell_variables(self):
+        text =3D "curl $LAVA_DISPATCHER_IP/${offset}"
+        self.assertEqual(lava_jobs.substitute(text, {}), text)
+
+    def test_substitute_leaves_unknown_shell_variables(self):
+        text =3D "x=3D$(( ${rootfs_start} + 1 )) $LAVA_JOB_ID ${file}"
+        out =3D lava_jobs.substitute(text, {"branch": "b"})
+        self.assertEqual(out, text)
+
+    def test_substitute_leaves_dollar_dollar_and_bare_names(self):
+        text =3D "$$x $branch ${artefact}"
+        self.assertEqual(lava_jobs.substitute(text, {"branch": "b"}), text=
)
+
+    def test_fragments_use_only_known_or_shell_variables(self):
+        files =3D [JOBS_YML]
+        for sub in ("blocks", "steps"):
+            files +=3D sorted((TEMPLATES / sub).glob("*.yml"))
+        allowed =3D set(lava_jobs.KNOWN_VARIABLES) | set(SHELL_VARIABLES)
+        for f in files:
+            with self.subTest(fragment=3Df.name):
+                names =3D set(lava_jobs.PLACEHOLDER.findall(f.read_text())=
)
+                self.assertEqual(names - allowed, set())
+
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
diff --git a/tests/test_lava_mcom_jobs.py b/tests/test_lava_mcom_jobs.py
new file mode 100644
index 00000000..1cae7c20
--- /dev/null
+++ b/tests/test_lava_mcom_jobs.py
@@ -0,0 +1,107 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests for the MCOM jobs and the IEC test block."""
+
+import pathlib
+import sys
+import tempfile
+import unittest
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import all_strings, lava_jobs  # noqa: E402
+
+
+QEMU_TARGETS =3D ("qemu-amd64", "qemu-arm64", "qemu-arm")
+
+
+def mcom_variables(iec_timeout=3D"30"):
+    return lava_jobs.build_variables("x86-uefi", "trixie", "br", iec_timeo=
ut)
+
+
+def tests_of(job):
+    return [a["test"] for a in job["actions"] if "test" in a]
+
+
+class McomJobTests(unittest.TestCase):
+    def test_mcom_iec_has_timeout(self):
+        job =3D lava_jobs.build_job("IEC", "x86-uefi", mcom_variables("45"=
))
+        self.assertEqual(tests_of(job)[0]["timeout"]["minutes"], 45)
+
+    def test_mcom_job_name_contains_test_function(self):
+        for test in ("IEC", "secure-boot", "swupdate"):
+            with self.subTest(test=3Dtest):
+                job =3D lava_jobs.build_job(test, "x86-uefi", mcom_variabl=
es())
+                self.assertEqual(job["job_name"], f"mtda-mcom-{test}")
+                self.assertEqual(job["device_type"], "mcom-mtda")
+
+    def test_mcom_swupdate_updatestate_2(self):
+        job =3D lava_jobs.build_job("swupdate", "x86-uefi", mcom_variables=
())
+        text =3D "\n".join(all_strings(job))
+        self.assertIn(") =3D 2 ]", text)
+
+    def test_mcom_swupdate_deploys_swu_first(self):
+        job =3D lava_jobs.build_job("swupdate", "x86-uefi", mcom_variables=
())
+        deploys =3D [a["deploy"] for a in job["actions"] if "deploy" in a]
+        self.assertEqual([d["to"] for d in deploys], ["downloads", "flashe=
r"])
+        self.assertTrue(deploys[0]["images"]["image"]["url"].endswith(
+            "/br/x86-uefi/cip-core-image-security-cip-core-trixie-x86-uefi=
.swu"))
+        self.assertIn("deploy", job["actions"][0])
+
+    def test_mcom_overlay_renamed_for_swupdate_only(self):
+        for test, overlay in (("swupdate", "overlay-2.1.1.4"),
+                              ("IEC", "overlay-1.1.1.4"),
+                              ("secure-boot", "overlay-1.1.1.4")):
+            with self.subTest(test=3Dtest):
+                job =3D lava_jobs.build_job(test, "x86-uefi", mcom_variabl=
es())
+                text =3D "\n".join(all_strings(job))
+                self.assertIn(f"--output {overlay}.tar.gz", text)
+
+    def test_mcom_secure_boot_checks_kernel_start_message(self):
+        job =3D lava_jobs.build_job("secure-boot", "x86-uefi", mcom_variab=
les())
+        boot =3D job["actions"][-1]["boot"]
+        self.assertEqual(boot["parameters"]["kernel-start-message"],
+                         "EFI stub: UEFI Secure Boot is enabled.")
+
+    def test_mcom_has_no_firmware(self):
+        for test in ("IEC", "secure-boot", "swupdate"):
+            with self.subTest(test=3Dtest):
+                job =3D lava_jobs.build_job(test, "x86-uefi", mcom_variabl=
es())
+                self.assertNotIn("firmware.bin", "\n".join(all_strings(job=
)))
+
+    def test_mcom_unsupported_test_writes_nothing(self):
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "kernel-panic", "--target", "=
x86-uefi",
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", d])
+            self.assertEqual(rc, 0)
+            self.assertEqual(list(pathlib.Path(d).iterdir()), [])
+
+    def test_main_writes_mcom_job(self):
+        with tempfile.TemporaryDirectory() as d:
+            rc =3D lava_jobs.main(["--test", "IEC", "--target", "x86-uefi"=
,
+                                 "--release", "trixie", "--branch", "br",
+                                 "--iec-timeout", "30", "--out", d])
+            self.assertEqual(rc, 0)
+            out =3D pathlib.Path(d) / "IEC_x86-uefi.yml"
+            self.assertEqual(lava_jobs.load_yaml(out)["device_type"], "mco=
m-mtda")
+
+    def test_qemu_iec_has_test_block(self):
+        for target in QEMU_TARGETS:
+            with self.subTest(target=3Dtarget):
+                variables =3D lava_jobs.build_variables(target, "trixie", =
"br", "45")
+                job =3D lava_jobs.build_job("IEC", target, variables)
+                tests =3D tests_of(job)
+                self.assertEqual(tests[-1]["timeout"]["minutes"], 45)
+                self.assertEqual(tests[-1]["definitions"][0]["name"],
+                                 "Security-Testcases")
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
diff --git a/tests/test_lava_qemu_jobs.py b/tests/test_lava_qemu_jobs.py
new file mode 100644
index 00000000..b5092d25
--- /dev/null
+++ b/tests/test_lava_qemu_jobs.py
@@ -0,0 +1,112 @@
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+"""Tests for the QEMU LAVA jobs and the generator command line."""
+
+import pathlib
+import sys
+import re
+import unittest
+
+import yaml
+
+sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
+
+from lava_test_helpers import all_strings, build, lava_jobs  # noqa: E402
+
+
+def monitor(job):
+    tests =3D [a["test"] for a in job["actions"] if "test" in a]
+    return tests[-1]["monitors"][0]
+
+
+def postprocess_steps(job):
+    return job["actions"][1]["deploy"]["postprocess"]["docker"]["steps"]
+
+
+class QemuJobTests(unittest.TestCase):
+    def test_unsigned_kernel_amd64_monitors(self):
+        mon =3D monitor(build("secure-boot-unsigned-kernel", "qemu-amd64")=
)
+        self.assertEqual(mon["end"], "Access Denied")
+        self.assertEqual(mon["start"], "Cannot load specified kernel image=
")
+        self.assertEqual(mon["name"], "corrupted-linux-image")
+
+    def test_unsigned_kernel_arm64_uses_vda_and_firmware(self):
+        job =3D build("secure-boot-unsigned-kernel", "qemu-arm64")
+        text =3D "\n".join(postprocess_steps(job))
+        self.assertIn("/dev/vda2", text)
+        self.assertNotIn("sda", text)
+        deploys =3D [a["deploy"] for a in job["actions"] if "deploy" in a]
+        self.assertIn("firmware", deploys[-1]["images"])
+        self.assertEqual(monitor(job)["end"], "Application failed")
+
+    def test_unsigned_bootloader_arm_uses_bootarm_efi(self):
+        job =3D build("secure-boot-unsigned-bootloader", "qemu-arm")
+        text =3D "\n".join(postprocess_steps(job))
+        self.assertIn("bootarm.efi", text)
+        self.assertNotIn("bootx64.efi", text)
+        self.assertIn("/dev/vda1", text)
+
+    def test_kernel_panic_updatestate_3_and_broken_swu(self):
+        job =3D build("kernel-panic", "qemu-amd64")
+        text =3D "\n".join(all_strings(job))
+        self.assertIn(") =3D 3 ]", text)
+        self.assertNotIn(") =3D 2 ]", text)
+        self.assertIn("-broken.swu", text)
+        self.assertIn("Kernel panic - not syncing: sysrq triggered crash",=
 text)
+        self.assertEqual(job["job_name"], "qemu-amd64 kernel-panic_rollbac=
k_testing")
+        self.assertEqual(lava_jobs.output_filename("kernel-panic", "qemu-a=
md64"),
+                         "kernel-panic.yml")
+
+    def test_initramfs_crash_replaces_success_with_dd(self):
+        text =3D "\n".join(all_strings(build("initramfs-crash", "qemu-amd6=
4")))
+        self.assertIn("dd if=3D/dev/urandom of=3D/dev/sda5 bs=3D512 count=
=3D1", text)
+        self.assertNotIn("echo software update is successful!!", text)
+        self.assertNotIn("-broken.swu", text)
+
+    def test_mismatch_keys_swaps_ovmf_distro(self):
+        for release, keys in (("trixie", "bookworm"), ("bookworm", "trixie=
")):
+            with self.subTest(release=3Drelease):
+                job =3D build("secure-boot-mismatch-keys", "qemu-amd64", r=
elease)
+                text =3D "\n".join(all_strings(job))
+                self.assertIn(f"{keys}-ovmf", text)
+                self.assertNotIn(f"{release}-ovmf", text)
+                self.assertEqual(postprocess_steps(job), ["echo 'no postpr=
ocess steps'"])
+
+    def test_reboot_without_confirm_replaces_bg_setenv(self):
+        job =3D build("swupdate-reboot-without-confirm", "qemu-arm")
+        text =3D "\n".join(all_strings(job))
+        self.assertNotIn("bg_setenv -c", text)
+        self.assertIn("echo No update confirm", text)
+        self.assertIn("kernel: C:BOOT0:linux.efi", text)
+
+    def test_no_unreplaced_placeholders_for_all_tests(self):
+        for test in lava_jobs.load_jobs():
+            for target in lava_jobs.TARGETS:
+                with self.subTest(test=3Dtest, target=3Dtarget):
+                    if not lava_jobs.is_supported(test, target):
+                        continue
+                    job =3D build(test, target)
+                    text =3D yaml.safe_dump(job)
+                    self.assertEqual(lava_jobs.find_unreplaced(text), [])
+                    self.assertIsNone(re.search(r"#[A-Za-z_-]+#", text))
+
+    def test_check_ustate_step_uses_updatestate(self):
+        text =3D lava_jobs.fragment_path("test_swupdate_check_ustate").rea=
d_text()
+        self.assertIn(") =3D ${updatestate} ]", text)
+        self.assertFalse(hasattr(lava_jobs, "set_update_state"))
+
+    def test_updatestate_only_set_in_values(self):
+        for name, spec in lava_jobs.load_jobs().items():
+            with self.subTest(test=3Dname):
+                self.assertNotIn("updatestate", spec)
+
+
+if __name__ =3D=3D "__main__":
+    unittest.main()
--=20
2.47.3

