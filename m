Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1971.1795163170332787988
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UznrUMVb;
 spf=pass (domain: siemens.com, ip: 52.101.65.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9JKRtgPJ3OK/yXIvpBhQj+AkzU8E1Q5h1CFQoy8ygz/pfzuKlJn1cT05JX9PlxQbolEnSgQVduGGiuVNOuQ4DgH3l3tuScDCPKZLl6xwBxSBcEKmdVo8gNS9z7XRm0iS1LSolACeh9rGXJXltyHLQdquEZqq6Yg4r2BSK6t3272p7grvhya/kzaazZ8bEdsV79K2+9NH95zhrrbTvtNpizdG6jMvIS0b2x9w+8pJa6f/6Ev7BfwasjaXxkEnS4cRtX17schFrm2HO5F50bfzpwuyKkX1ZMzhTZKpDfR+qVyELW5ep3C5F89MSOz3KWplCSL3ak2xsONrI/R1U73ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY6cico2HsF+23gLTNvUNepMbjXKA+CVXJxGcKkdl/4=;
 b=QLJ6IZGii4m3g6mDo4ImQzgZ44HFT3fEChll3czNaidrcvSfl17SZ7vhSeE+JMkKWIV1VeAM/LKZbNlG/ObbBwKWVYgSjnv9xBcJ4UHCIabFCJMcNUO/GAsz+i7xEoynn7FskHGMBRN1OY2o//X40RjYjJoAxM9v64vayGTPagPgjwwhpxD5p+zg9o94gkU69wrTuCFbX0ovyfx90nk8avw44mKmpEuGcLMXxxDg03jzgToHFGxtQTwI/D8y6XUNFSuZBOtURsJuxsYI7q4Mbc0xGQgawp/feVPwVRyfiJlBfmqJlst/ZrXIBWm7QPuFnraPETjcxdvLFtnmCvYZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY6cico2HsF+23gLTNvUNepMbjXKA+CVXJxGcKkdl/4=;
 b=UznrUMVb0f13ZCHQ+zIRnWlXfUqyJEgP/wSLnl2aeZySvggNv8oO5MZewyisAFaB6DQAshz/3wZ5I2iYr5AzqWL5X1ARS1UrUa7SrKDe/i36OXIej9IPoECF7gDl92C6Ss93qsdanoMP5X0uLy3nrg+pzLV5wshZZn/UoSweeJr5YFgmSfE044l/A2Wol81/IBMdysm/ECAFcKJMb55RTUniL3WPbZ88f3vyfDfjOEJT1ZBgRrdch4RBlfJbZNlvfPw5i818KSYaoQXMxm30Z8OFp5MZXM/jUh9C1OSlG1EKPYpKnasY9q3g3aT3p/kYs8R69yQypMH1Ns8om7rsag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA4PR10MB5705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 08:26:06 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 7/8] scripts: use Python LAVA job generator in submit_lava.sh
Date: Fri, 20 Nov 2026 09:25:53 +0100
Message-ID: <20261120082554.375548-8-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA4PR10MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bdb29b-8c5c-4d55-5c67-08df46dfebc9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|20052099010|261026130827099003|261028144727099003|10067099003|11063799006|5023799004|261021130227099003|261009223327099003|261009221227099003|56012099006|261021123027099003|261021133027099003|261102130727099003|261022113327099003|261021135927099003|261009221727099003|261009220027099003|261102123227099003|261009223027099003|261026135527099003|261022105027099003|261026121527099003|261022115727099003|261022075727099003|261021121427099003|261026140227099003|55112099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: sJBZ3W9ZrDqBaqwnHWIFZsH0Nk8xsL4GUgOERBF5lAtBcdhlJx3dV+wIE1oDjG4aYvPxJI8aA+8wacVILNGXrkpWJIofK769X4qjvm7fgZ50u04iTHxnuoBQTb033+b8r7N8ismuu0EstqE8+gvds3tAyJIACB91sPD3Rgd9Dv7wligy5IqjzkrooKN7L99DJ2Cg+wCUGRWVkzu/LHQvOZgJPhnO91HD5PgAHEUyqmqSRQnjQ9/EjMMPe8g79jbGOBcZlI+wj7doq9OoJZGa7yIBGNq55584ftv8BSYAxjlzgPDjxKAQFiTgkDqJgMPPlCDm7n0316oC0uqUKRAzMO5GzlWA6W8VySbarHDh5wJonUrMlOLCNpyKqqwgTMXumdLg7/FScW5S4JA7klBhd9dRRGt8Y+25E7p4L+7BeZ2h+lazv+Mp9IkGVQ/fHO8bpriXYU/MTZsWL+BCKYdQGNPX0szcaFDS5zbZte/7Gh9osGx5W98gsq/2gPPcUrtnTCsw0heTDv8DjaTgJI9Nga3suBagBy2jN8NBN/8M/JBY7+tGjjFk/b5dWNwkW9GJPj3/zi2arqpJ1m/czZfvFqjN59lh1OrAIgfxIVAZ4ERTQZItcfhVft2SgC8O7Rv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(20052099010)(261026130827099003)(261028144727099003)(10067099003)(11063799006)(5023799004)(261021130227099003)(261009223327099003)(261009221227099003)(56012099006)(261021123027099003)(261021133027099003)(261102130727099003)(261022113327099003)(261021135927099003)(261009221727099003)(261009220027099003)(261102123227099003)(261009223027099003)(261026135527099003)(261022105027099003)(261026121527099003)(261022115727099003)(261022075727099003)(261021121427099003)(261026140227099003)(55112099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DD+XsK5GcryrZbgFSu4tVTcjtHRT0sMmqJWzNiMU7l/3WYkRqPnGWU+QGa4D?=
 =?us-ascii?Q?ywDMWKM0j9Py2Kpk66v9WHd8QzAeswVamr1xhZOgsxJKelEZZ29QLW6JpiGP?=
 =?us-ascii?Q?cLGo4eINwimNjc9GhC4Q8gU6aPHg3nabYga94WdSW6oz8JzY6sERXBuf7Yls?=
 =?us-ascii?Q?AV0jdal85oSAWxqNAu8yrmF/ckYZy46pSgj3IgmbhNJU/e/FDyboBaQ43T2g?=
 =?us-ascii?Q?Q8Y15vtMCQ26utwJ0BXtbzoTmbkx5b8wYaOZX9MTkB5yvGXmGn/lNm59aAm5?=
 =?us-ascii?Q?mP4b8Q1i2tN7zplEAi+5tW6UiegFfAdqOlAQDUyl+4sWMeu7qzP1dl5ZN2w6?=
 =?us-ascii?Q?TKjnRExBth+uTO5+rrbVj2NqjIkvm05VGs5BXiPYeAfx+/okjUC97x66wZv4?=
 =?us-ascii?Q?Ryb4MgBNppkX9V/J68Svnhm7mnVW6ZqsTd4dZOvClSHC2NqW2w3v37ZKXBC+?=
 =?us-ascii?Q?gJ70kU8EmPmVLh+eCIuW8piOozYegDZjeovB2IAlMSSCIRDya4cmWZO4Fe5Y?=
 =?us-ascii?Q?fdQ+fxbYAPkORkfPq2i/h86WfbO+RnVwWgPQoCM4CyuxWeFYaUWk9mqcT+B2?=
 =?us-ascii?Q?4Kv5awrSnEglvkaMu63isISaQLJPDCdnNJPEeOh6PE2AgFgDiP+ooL2vKjiV?=
 =?us-ascii?Q?IoQrAzby2/39yUj/q6jxR0leuWAWroBxN++v214vb7Q3MDyxUrI4LWWMdBHz?=
 =?us-ascii?Q?Xcal9asroGvpOHrYIhnRAQU8X6ecSw+vmjNKmy/xwUpnZaLQPi5CEw6muKxi?=
 =?us-ascii?Q?RdNTcoRORylBIfvd6DP+4G+wsPNVM9Cay+24v2m+5wDk8bgh8eRHbAWrEw1o?=
 =?us-ascii?Q?e15UAzu4nFsxHIYreBVCJi3BnCQ4ohz3pTTM8WBQuoRSdlvYKQL7IHyHI6ov?=
 =?us-ascii?Q?ifPx/tF930LttZER3Bxe0rI9H37HJ/CLTUOGShU2qGSrIHQEFRrcQZHB3Buz?=
 =?us-ascii?Q?XlmtrrY46Ur09wJ7YcvRmWG8H7y3vJ+9RZA/aRK8vBlRDTsSecLqR77wRf6Y?=
 =?us-ascii?Q?cHb9oS0/KXJ6MR/sPwIqTP9ChCFJt8EhgOLlqcKycxI4S6CgjgrQ3XACH+PV?=
 =?us-ascii?Q?hCfCxcr1ErhiKI7bFMqRe5MJsBIc5Aa6lueH7WmJD6LGWt0IeR0qnTQ6wsVa?=
 =?us-ascii?Q?oSzTcx8i7aEpU3wY6kkdCL81xakY4UOYT8ncHK7KrQre2bMTBYXWfvGaRoT1?=
 =?us-ascii?Q?L6x9pnYX/LYDigkZe2R9KWPO6E/TBYhZBVFgHoX0bhZ65mMIHs9Tt8+yk/pM?=
 =?us-ascii?Q?no7cNiN4aIy0oBVap7octYjvf9n8hTmLKMW4p3R53Fw2bzA9i8rABGtCjsK/?=
 =?us-ascii?Q?5k7xalgIZ1c9CD0HIKsfqn/EYrwHE0Vses++WmIzb55pTqW6rdgYgJnjcRQf?=
 =?us-ascii?Q?pEDyObiQd7lnEMtX7K450BJhBChdwsuCan5Gk//3HpF+gX3W8wZD/1FJY99n?=
 =?us-ascii?Q?+aaqGGyyRuZO97/9VEARuyb+0WGCrtPxawRZDcgkr4KTTPC+R4mxohHO2+MF?=
 =?us-ascii?Q?NvYsgdSejyMEyUQwk9lrTDJs75RXy8UUtCCRqzYq536ztKfJxjIdGVDJpWGS?=
 =?us-ascii?Q?Zorb30aW0jFyiYVZsAZkk9he3YzITYxzLRtque1dzrMe8VzYW8qc+mX3myB/?=
 =?us-ascii?Q?XhxuSz+8iqm2e4Faa364hmAdfxQMXUxqqY8AHX8IDrJTLyD0MpFso8ZvGK6b?=
 =?us-ascii?Q?RhVTWeKoZFDKJCEChewYBz2Yo3MYY6XobSJm6VuA1Im8jWYc4ZLZdduWeKqp?=
 =?us-ascii?Q?0RUsAMmd/gGUHjpl9XJIzDdCPmmr3bg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bdb29b-8c5c-4d55-5c67-08df46dfebc9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:05.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYfxpYIFlj25vxBlitbzs5dyCZam6R52Ajt2fAaSx867UysVtSxVbfCDJnsWCR+ZabNZe+JbWIrsLQXjGlrtV7/f1BwOt7QViWPBxrmToWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25033
Content-Type: text/plain; charset="utf-8"

submit_lava.sh built the jobs by editing the templates with sed, grep
and envsubst. What job such a chain of edits produces is hard to tell
from reading the script; it only became clear by running a test. Errors
in a template or an edit only showed up when LAVA rejected or misran the
job, and every new test needed another copy of a template. Use the
generator added in "scripts: add Python LAVA job generator", which
builds valid YAML from shared fragments and is covered by unit tests.

Replace the template handling with a call to scripts/lava_jobs.py. The
command line of submit_lava.sh is unchanged; generation, validation and
submission stay as before, and the temporary directory is now removed
when generation fails.

Remove the old flat templates (including IEC_template.yml and the
M-COM templates), so the fragments in tests/templates are the only
source of the job definitions.

The lavacli image needs python3-yaml. gettext-base (envsubst) stays so
the image can still run the shell-based submit_lava.sh of older branches.
Rebuild the image (scheduled or web pipeline with LAVACLI_CONTAINER set)
before running the LAVA test jobs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.lava-testing.md                    |  52 +++--
 scripts/Dockerfile.lavacli                    |   2 +-
 scripts/submit_lava.sh                        | 220 ++----------------
 tests/templates/IEC_template.yml              |  79 -------
 tests/templates/M-COM-x86.yml                 |  54 -----
 tests/templates/README.md                     | 208 ++++++++++++++---
 .../secureboot_corrupt_rootfs_steps.yml       |  10 -
 tests/templates/secureboot_negative_test.yml  |  84 -------
 tests/templates/secureboot_template.yml       |  70 ------
 .../secureboot_unsigned_bootloader_steps.yml  |  10 -
 .../secureboot_unsigned_kernel_steps.yml      |  10 -
 .../templates/swupdate-test-action-M-COM.yml  |  21 --
 .../swupdate_corrupt_swu_artifact_steps.yml   |  12 -
 .../templates/swupdate_corrupt_swu_steps.yml  |   9 -
 tests/templates/swupdate_negative_test.yml    |  94 --------
 .../swupdate_reboot_without_confirm.yml       |  48 ----
 tests/templates/swupdate_same_uuid_steps.yml  |  12 -
 tests/templates/swupdate_template.yml         | 135 -----------
 18 files changed, 227 insertions(+), 903 deletions(-)
 delete mode 100644 tests/templates/IEC_template.yml
 delete mode 100644 tests/templates/M-COM-x86.yml
 delete mode 100644 tests/templates/secureboot_corrupt_rootfs_steps.yml
 delete mode 100644 tests/templates/secureboot_negative_test.yml
 delete mode 100644 tests/templates/secureboot_template.yml
 delete mode 100644 tests/templates/secureboot_unsigned_bootloader_steps.ym=
l
 delete mode 100644 tests/templates/secureboot_unsigned_kernel_steps.yml
 delete mode 100644 tests/templates/swupdate-test-action-M-COM.yml
 delete mode 100644 tests/templates/swupdate_corrupt_swu_artifact_steps.yml
 delete mode 100644 tests/templates/swupdate_corrupt_swu_steps.yml
 delete mode 100644 tests/templates/swupdate_negative_test.yml
 delete mode 100644 tests/templates/swupdate_reboot_without_confirm.yml
 delete mode 100644 tests/templates/swupdate_same_uuid_steps.yml
 delete mode 100644 tests/templates/swupdate_template.yml

diff --git a/doc/README.lava-testing.md b/doc/README.lava-testing.md
index c8c606e7..bdb2f567 100644
--- a/doc/README.lava-testing.md
+++ b/doc/README.lava-testing.md
@@ -1,19 +1,35 @@
 # CIP Core functionality testing with LAVA
=20
-This document explains how SWUpdate, Secure boot and IEC layer are being t=
ested using LAVA. The tests/templates directory contains functionality base=
d templates which are extended to LAVA job definitions which tests the resp=
ective functionality on QEMU amd64, arm64 and arm architectures. CI jobs ru=
n until the final health of all the submitted jobs is reported.
+This document explains how SWUpdate, Secure boot and IEC layer are being t=
ested using LAVA. LAVA job definitions are generated by `scripts/lava_jobs.=
py` from YAML fragments in `tests/templates` and run on QEMU amd64, arm64 a=
nd arm and on M-COM (x86-uefi). CI jobs run until the final health of all t=
he submitted jobs is reported.
=20
-## Templates
+## Job generation
=20
-#### IEC_template.yml:
-This template is extended to three LAVA job definitions which runs [IEC la=
yer test cases](https://gitlab.com/cip-project/cip-testing/cip-security-tes=
ts) on the QEMU security target. Here is a [reference](https://lava.ciplatf=
orm.org/scheduler/job/1143475/definition) to the IEC job definition.
+* `tests/templates/blocks` and `tests/templates/steps` contain YAML fragme=
nts (header, deploy, boot and test actions, test steps). Placeholders have =
the form `${name}` and are replaced by `scripts/lava_jobs.py`.
+* `tests/templates/jobs.yml` declares for every test (IEC, secure-boot, sw=
update, kernel-panic, ...) which fragments are used, in which order, and th=
e per-test and per-target values. See the comment at the top of the file fo=
r all keys.
+* `scripts/lava_jobs.py` assembles the fragments into one job definition. =
`scripts/submit_lava.sh` calls it and submits the result.
=20
-#### secureboot_template.yml:
-This template is extended to three LAVA job definitions which checks wheth=
er secure boot is enabled on the QEMU security target. Here is a [reference=
](https://lava.ciplatform.org/scheduler/job/1143474/definition) to the secu=
re boot job definition.
+Generate a job locally:
=20
-#### swupdate_template.yml:
-This template is extended to five LAVA job definitions in which three jobs=
 verify successful software update, partition switch after reboot and check=
ing whether bootloader environment variables(ustate) are updated. Here is a=
 [reference](https://lava.ciplatform.org/scheduler/job/1143538/definition) =
to the software update job definition.
+```
+python3 scripts/lava_jobs.py --test swupdate --target qemu-arm64 \
+    --release trixie --branch master --iec-timeout 30 --out /tmp/jobs
+```
=20
-The other two jobs i.e [kernel_panic.yml](https://lava.ciplatform.org/sche=
duler/job/1143642/definition) and [initramfs_crash.yml](https://lava.ciplat=
form.org/scheduler/job/1143643/definition) verify the roll back feature dur=
ing a fail case scenarios.
+The path of the written file is printed. If a test does not exist for a ta=
rget, nothing is written.
+
+Run the unit tests:
+
+```
+python3 -m unittest discover -s tests
+```
+
+### Adding a new test
+
+1. Add new fragments to `tests/templates/blocks` or `tests/templates/steps=
` if the existing ones do not fit.
+2. Add an entry under `tests:` in `tests/templates/jobs.yml` listing the b=
locks and values.
+3. Add a unit test and the test to `.gitlab-ci.yml` via `test_function`.
+
+[tests/templates/README.md](../tests/templates/README.md) explains how a j=
ob is built and walks through examples: a new negative software update test=
 that reuses existing blocks, a test with its own block, differences betwee=
n targets (`per_arch`, M-COM), and a new placeholder.
=20
 ## LAVA Setup
=20
@@ -21,9 +37,17 @@ The above mentioned job definitions shall be sent to CIP=
 LAVA Lab for testing. F
=20
 ## LAVA template variables
=20
-* `architecture` : This variable represents architecture of the QEMU secur=
ity target on which the test is done.
+Available as `${name}` in the fragments:
+
+* `branch` : The branch on which the pipeline is triggered.
+* `distribution` : The `release` assigned in the gitlab CI configuration f=
ile.
 * `project_url` : Default value is `https://s3.eu-central-1.amazonaws.com/=
download2.cip-project.org/cip-core`.
-* `branch` : This variable represents the branch on which the pipeline is =
triggered.
-* `distribution` : This variable is assigned with the `release` assigned i=
n gitlab CI configuration file.
-* `Firmware_args` : This variable is used only for `arm64` and `armhf` arc=
hitectures and it has boot parameters for the U-boot firmware binary.
-* `Firmware_url` : This variable represents the firmware binary artifact u=
ploaded in cip-project s3 bucket.
+* `architecture` : The target, e.g. `qemu-arm64`.
+* `context_architecture` : The architecture part of the target, used in th=
e LAVA context.
+* `imageargs` : QEMU arguments of the target; arm64 and arm additionally g=
et the U-boot firmware binary as deploy artifact.
+* `test_function` : Name of the test.
+* `updatestate` : Expected bootloader environment variable (ustate) after =
the update.
+* `job_title` : Per-test part of the job name.
+* `start_monitor`, `end_monitor` : Boot messages monitored by the secure b=
oot negative tests.
+* `artifact` : Artifact manipulated by the secure boot negative tests.
+* `IEC_TEST_TIMEOUT_MINUTES` : Timeout of the IEC test.
diff --git a/scripts/Dockerfile.lavacli b/scripts/Dockerfile.lavacli
index 763ed4dd..ae6b8b35 100644
--- a/scripts/Dockerfile.lavacli
+++ b/scripts/Dockerfile.lavacli
@@ -14,4 +14,4 @@ FROM debian:stable
 ARG DEBIAN_FRONTEND=3Dnoninteractive
=20
 RUN apt-get update && \
-    apt-get install -y --no-install-recommends gettext-base curl xmlstarle=
t lavacli
+    apt-get install -y --no-install-recommends gettext-base python3-yaml c=
url xmlstarlet lavacli
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 11f3a5c7..d1669f7a 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -10,11 +10,9 @@
 set -e
=20
 ##########################################################################=
######
-LAVA_TEMPLATES=3D"tests/templates"
 LAVA_JOBS_URL=3D"https://${CIP_LAVA_LAB_SERVER:-lava.ciplatform.org}/sched=
uler/job"
 LAVA_API_URL=3D"https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP_LAVA_=
LAB_SERVER:-lava.ciplatform.org}/api/v0.2"
 LAVACLI_ARGS=3D"--uri https://$CIP_LAVA_LAB_USER:$CIP_LAVA_LAB_TOKEN@${CIP=
_LAVA_LAB_SERVER:-lava.ciplatform.org}/RPC2"
-PROJECT_URL=3D"https://s3.eu-central-1.amazonaws.com/download2.cip-project=
.org/cip-core"
=20
 WORK_DIR=3D$(pwd)
 RESULTS_DIR=3D"$WORK_DIR/results"
@@ -26,17 +24,8 @@ RELEASE=3D$4
 COMMIT_BRANCH=3D$5
 IEC_TEST_TIMEOUT_MINUTES=3D$6
=20
-# Export to replace the timeout variable declared in IEC template
-export IEC_TEST_TIMEOUT_MINUTES
-
 if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=3Dfalse; fi
=20
-# Create a dictionary to handle image arguments based on architecture
-declare -A image_args
-image_args[qemu-amd64]=3D"-cpu Haswell,-pcid,-x2apic,-tsc-deadline,-hle,-i=
nvpcid,-rtm -machine q35,accel=3Dtcg -smp 4 -global ICH9-LPC.noreboot=3Doff=
 -device ide-hd,drive=3Ddisk -drive if=3Dpflash,format=3Draw,unit=3D0,reado=
nly=3Don,file=3D/root/keys/${RELEASE}-ovmf/OVMF_CODE_4M.secboot.fd -device =
virtio-net-pci,netdev=3Dnet -drive if=3Dpflash,format=3Draw,file=3D/root/ke=
ys/${RELEASE}-ovmf/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=3D=
1 -global isa-fdc.driveA=3D -device tpm-tis,tpmdev=3Dtpm0"
-image_args[qemu-arm64]=3D"-cpu cortex-a57 -machine virt -smp 4 -device vir=
tio-serial-device -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -d=
evice virtio-blk-device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet=
 -device tpm-tis-device,tpmdev=3Dtpm0"
-image_args[qemu-arm]=3D"-cpu cortex-a15 -machine virt -smp 2 -device virti=
o-serial-device -device virtconsole,chardev=3Dcon -chardev vc,id=3Dcon -dev=
ice virtio-blk-device,drive=3Ddisk -device virtio-net-device,netdev=3Dnet -=
device tpm-tis-device,tpmdev=3Dtpm0"
-
 set_up (){
 	job_dir=3D"$(mktemp -d)"
 }
@@ -45,193 +34,6 @@ clean_up () {
 	rm -rf "$job_dir"
 }
=20
-# This method is called only for arm64 and arm targets while building job =
definitions
-add_firmware_artifacts () {
-	sed -e "s@#Firmware#@firmware:@g" \
-	    -e "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" \
-	    -e "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/${2}/firmwa=
re.bin@g" \
-	    -i "$1"
-}
-
-# This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
-# The created job definitions test SWUpdate, Secureboot and IEC layer
-create_job_qemu () {
-	if [ "$1" =3D "IEC" ]; then
-		cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.yml"
-
-	elif [ "$1" =3D "swupdate" ]; then
-		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_${2}.yml"
-		sed -i "s@#updatestate#@2@g" "${job_dir}"/*.yml
-
-	elif [ "$1" =3D "kernel-panic" ] || [ "$1" =3D "initramfs-crash" ]; then
-		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}.yml"
-		sed -e "s@software update testing@${1}_rollback_testing@g" \
-		    -e "s@#updatestate#@3@g" -e "s@) =3D 2@) =3D 3@g" \
-		    -i "${job_dir}"/*.yml
-		if [ "$1" =3D "kernel-panic" ]; then
-			sed -e "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq t=
riggered crash@g" \
-			    -e "s@\.swu@-broken.swu@" \
-			    -i "${job_dir}"/*.yml
-		else
-			sed -e "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continui=
ng will lead to a broken trust chain!@g" \
-			    -e "s@echo software update is successful!!@dd if=3D/dev/urandom of=
=3D/dev/sda5 bs=3D512 count=3D1@g" \
-			    -i "${job_dir}"/*.yml
-		fi
-	elif [ "$1" =3D "secure-boot-unsigned-kernel" ]; then
-		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigne=
d_kernel_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_unsigned_kernel_steps.=
yml' -e 'd' -e '}' -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-		cd -
-		if [ "$2" =3D "qemu-amd64" ]; then
-			sed -e "s@#END_MONITOR#@Access Denied@g" \
-			    -e "s@#START_MONITOR#@Cannot load specified kernel image@g" \
-			    -e "s@#ARTIFACT#@linux@g" \
-			    -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-		fi
-
-		if [ "$2" =3D "qemu-arm64" ] || [ "$2" =3D "qemu-arm" ]; then
-			sed -e "s@sda@vda@g" \
-			    -e "s@#END_MONITOR#@Application failed@g" \
-			    -e "s@#START_MONITOR#@Image not authenticated@g" \
-			    -e "s@#ARTIFACT#@linux@g" \
-			    -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-		fi
-	elif [ "$1" =3D "secure-boot-unsigned-bootloader" ]; then
-		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigne=
d_bootloader_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_unsigned_bootloader_st=
eps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-		cd -
-
-		if [ "$2" =3D "qemu-amd64" ]; then
-			sed -e "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" \
-			    -e "s@#START_MONITOR#@Access Denied@g" \
-			    -e "s@#ARTIFACT#@bootloader@g" \
-			    -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-		fi
-
-		if [ "$2" =3D "qemu-arm64" ] || [ "$2" =3D "qemu-arm" ]; then
-			sed -e "s@sda@vda@g" \
-			    -e "s@#END_MONITOR#@EFI Boot failed!@g" \
-			    -e "s@#START_MONITOR#@Image not authenticated@g" \
-			    -e "s@#ARTIFACT#@bootloader@g" \
-			    -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-		fi
-
-		if [ "$2" =3D "qemu-arm64" ]; then
-			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_unsigned_bootloa=
der_${2}.yml"
-		fi
-		if [ "$2" =3D "qemu-arm" ]; then
-			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootload=
er_${2}.yml"
-		fi
-	elif [ "$1" =3D "secure-boot-corrupt-rootfs" ]; then
-		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_corrupt=
_rootfs_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_corrupt_rootfs_steps.y=
ml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
-		cd -
-
-		sed -e "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verit=
y device corrupted'@g" \
-		    -e "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" \
-		    -e "s@#ARTIFACT#@rootfs@g" \
-		    -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
-
-		if [ "$2" =3D "qemu-arm64" ]; then
-			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_corrupt_rootfs_$=
{2}.yml"
-		fi
-		if [ "$2" =3D "qemu-arm" ]; then
-			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_corrupt_rootfs_${=
2}.yml"
-		fi
-	elif [ "$1" =3D "secure-boot-mismatch-keys" ]; then
-		if [ "$2" =3D "qemu-amd64" ]; then
-			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismat=
ch_keys_${2}.yml"
-
-			sed -e "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" \
-			    -e "s@#START_MONITOR#@Access Denied@g" \
-			    -e "s@#ARTIFACT#@keys@g" \
-			    -e "s@#POSTPROCESS_STEPS#@- echo 'no postprocess steps'@g" \
-			    -i "${job_dir}/${1}_mismatch_keys_${2}.yml"
-		fi
-	elif [ "$1" =3D "swupdate-corrupt-swu" ]; then
-		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_s=
wu_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_corrupt_swu_steps.yml' -e=
 'd' -e '}' -i "${job_dir}/${1}_corrupt_swu_${2}.yml"
-		cd -
-	elif [ "$1" =3D "swupdate-corrupt-swu-artifact" ]; then
-		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_s=
wu_artifact_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_corrupt_swu_artifact_step=
s.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_swu_artifact_${2}.yml"
-		cd -
-	elif [ "$1" =3D "swupdate-reboot-without-confirm" ]; then
-		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_reboot_without=
_confirm_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#REBOOT_WITHOUT_CONFIRM_STEPS#/ {' -e 'r swupdate_reboot_withou=
t_confirm.yml' -e 'd' -e '}' -i "${job_dir}/${1}_reboot_without_confirm_${2=
}.yml"
-		cd -
-		sed -i "s@bg_setenv -c@echo No update confirm@g" "${job_dir}/${1}_reboot=
_without_confirm_${2}.yml"
-	elif [ "$1" =3D "swupdate-apply-same-image-swu" ]; then
-		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_same_uuid=
_${2}.yml"
-		cd $LAVA_TEMPLATES
-		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_same_uuid_steps.yml' -e '=
d' -e '}' -i "${job_dir}/${1}_same_uuid_${2}.yml"
-		cd -
-	else
-		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}/${1}_${2}.yml"
-	fi
-
-	if [ "$2" !=3D "qemu-amd64" ]; then
-		add_firmware_artifacts "${job_dir}"/*.yml "$2"
-	fi
-
-	sed -e "s@#branch#@${COMMIT_BRANCH}@g" \
-	    -e "s@#distribution#@${RELEASE}@g" \
-	    -e "s@#project_url#@${PROJECT_URL}@g" \
-	    -e "s@#architecture#@${2}@g" \
-	    -e "s@#imageargs#@${image_args[$2]}@g" \
-	    -i "${job_dir}"/*.yml
-
-	if [ "$1" =3D "secure-boot-mismatch-keys" ]; then
-		if [ "${RELEASE}" =3D "trixie" ]; then
-			KEYS_DISTRO=3Dbookworm
-		else
-			KEYS_DISTRO=3Dtrixie
-		fi
-		sed -i "s@${RELEASE}-ovmf@${KEYS_DISTRO}-ovmf@g" "${job_dir}/${1}_mismat=
ch_keys_${2}.yml"
-	fi
-
-	# Target is received from gitlab job in form of qemu-"architecture"
-	# In the template context field needs only architecture excepting the dev=
ice type
-	local arch
-	arch=3D$(echo "$2" | cut -d '-' -f 2)
-	sed -i "s@#context-architecture#@${arch}@g" "${job_dir}"/*.yml
-}
-
-# This method creates LAVA job definitions for M-COM-x86
-# The created job definitions test SWUpdate, Secureboot and IEC layer
-create_job_mcom () {
-	cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
-	if [ "$1" =3D "IEC" ]; then
-		grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir=
}/${1}_${2}.yml"
-	elif [ "$1" =3D "secure-boot" ]; then
-		grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_template.yml" >> "${j=
ob_dir}/${1}_${2}.yml"
-	else
-		# swupdate -d option does not work on M-COM, so .swu file is deployed to=
 downloads
-		grep -A 7 "deploy:" "${job_dir}/${1}_${2}.yml" > "${job_dir}/swupdate_de=
ploy_download.yml"
-		sed -i -e "s@flasher@downloads@g" -e "s@wic.xz@swu@g" "${job_dir}/swupda=
te_deploy_download.yml"
-		sed -i -e "/actions/r ${job_dir}/swupdate_deploy_download.yml" "${job_di=
r}/${1}_${2}.yml"
-
-		# Remove the deploy to download yml file once it is placed in the job de=
finition
-		rm "${job_dir}/swupdate_deploy_download.yml"
-
-		# swupdate test action on M-COM is different from the test block used in=
 QEMU
-		cat $LAVA_TEMPLATES/swupdate-test-action-M-COM.yml | tee -a "${job_dir}/=
${1}_${2}.yml" > /dev/null
-		grep -A 14 "# BOOT BLOCK" "$LAVA_TEMPLATES/M-COM-x86.yml" >> "${job_dir}=
/${1}_${2}.yml"
-		grep -A 16 "# TEST BLOCK 2" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_=
dir}/${1}_${2}.yml"
-		sed -i -e "s@#updatestate#@2@g" -e "s@overlay-1.1.1.4@overlay-2.1.1.4@g"=
 "${job_dir}/${1}_${2}.yml"
-	fi
-	sed -e "s@#test_function#@${1}@g" \
-	    -e "s@#branch#@${COMMIT_BRANCH}@g" \
-	    -e "s@#distribution#@${RELEASE}@g" \
-	    -e "s@#project_url#@${PROJECT_URL}@g" \
-	    -i "${job_dir}/${1}_${2}.yml"
-}
-
 # $1: Job definition file
 submit_job() {
         # First check if respective device is online
@@ -329,17 +131,25 @@ get_junit_test_results () {
=20
 set_up
=20
-if [[ $TARGET =3D~ "qemu" ]]; then
-	create_job_qemu "$TEST" "$TARGET"
-elif [[ $TARGET =3D~ "x86-uefi" ]]; then
-	create_job_mcom "$TEST" "$TARGET"
-else
+if [[ ! $TARGET =3D~ "qemu" && ! $TARGET =3D~ "x86-uefi" ]]; then
 	echo "Invalid target"
+	clean_up
 	exit 1
 fi
=20
-# Only replace the IEC_TEST_TIMEOUT_MINUTES variable in template files
-envsubst '$IEC_TEST_TIMEOUT_MINUTES' < ${job_dir}/*.yml > template.tmp && =
mv template.tmp ${job_dir}/*.yml
+SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+python3 "$SCRIPT_DIR/lava_jobs.py" --test "$TEST" --target "$TARGET" \
+	--release "$RELEASE" --branch "$COMMIT_BRANCH" \
+	--iec-timeout "$IEC_TEST_TIMEOUT_MINUTES" --out "$job_dir" || {
+	clean_up
+	exit 1
+}
+
+if ! compgen -G "${job_dir}/*.yml" > /dev/null; then
+	echo "No job definition generated for $TEST on $TARGET"
+	clean_up
+	exit 1
+fi
=20
 if ! validate_job; then
 	clean_up
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_templat=
e.yml
deleted file mode 100644
index bf7279e1..00000000
--- a/tests/templates/IEC_template.yml
+++ /dev/null
@@ -1,79 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-device_type: qemu
-job_name: #architecture# IEC layer testing
-timeouts:
-  job:
-    minutes: 50
-  action:
-   minutes: 40
-  actions:
-    power-off:
-      seconds: 60
-priority: medium
-tags:
-- swtpm-jobs
-visibility: public
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION BLOCK
-actions:
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 20
-
-# DEPLOY BLOCK
-- deploy:
-    timeout:
-      minutes: 30
-    to: tmpfs
-    images:
-      system:
-        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
-                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
-                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
-        compression: zstd
-
-      #Firmware#
-        #Firmware_args#
-        #Firmware_url#
-
-# BOOT BLOCK
-- boot:
-    timeout:
-      minutes: 25
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-
-# TEST_BLOCK
-- test:
-     timeout:
-       minutes: ${IEC_TEST_TIMEOUT_MINUTES}
-     definitions:
-     - repository: https://gitlab.com/cip-project/cip-testing/cip-security=
-tests.git
-       from: git
-       revision: 88134a939f06c456d4978db9c050f9afc74c5d3b
-       path: iec-security-tests/Singlenode-TestDefinition.yaml
-       name: Security-Testcases
-
-context:
-  arch: #context-architecture#
-  guestfs_interface: virtio
-  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
deleted file mode 100644
index 01adee94..00000000
--- a/tests/templates/M-COM-x86.yml
+++ /dev/null
@@ -1,54 +0,0 @@
-# Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
-# SPDX-License-Identifier:      AGPL-3.0-only
-# This program is free software: you can redistribute it and/or modify it =
under the terms of the GNU Affero General Public License as published by th=
e Free Software Foundation, version 3.
-# This program is distributed in the hope that it will be useful, but WITH=
OUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE.
-job_name: mtda-mcom-#test_function#
-device_type: mcom-mtda
-timeouts:
-  job:
-    minutes: 180
-  action:
-    minutes: 95
-  connection:
-    minutes: 25
-priority: medium
-visibility: public
-context:
-  lava_test_results_dir: /home/lava/%s
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION_BLOCK
-actions:
-- deploy:
-    timeout:
-      minutes: 60
-    to: flasher
-    images:
-      image:
-        url: #project_url#/#branch#/x86-uefi/cip-core-image-security-cip-c=
ore-#distribution#-x86-uefi.wic.zst
-
-# BOOT BLOCK
-- boot:
-    method: minimal
-    timeout:
-      minutes: 45
-    reset: true
-    failure_retry: 1
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-    transfer_overlay:
-      transfer_method: http
-      download_command: "curl -H 'Connection: close' -v --trace-time --out=
put overlay-1.1.1.4.tar.gz"
-      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C /home/la=
va/ -xf
diff --git a/tests/templates/README.md b/tests/templates/README.md
index decb7a9b..2c7c36ed 100644
--- a/tests/templates/README.md
+++ b/tests/templates/README.md
@@ -15,10 +15,29 @@ Values that change per job are written as `${name}`, fo=
r example
 `doc/README.lava-testing.md`. Shell variables such as `$LAVA_JOB_ID` or
 `${file}` are not placeholders and stay untouched.
=20
-## Example: a new negative software update test
+## How a job is built
+
+For one test and one target, `scripts/lava_jobs.py`:
+
+1. takes the `blocks` of the test from `jobs.yml` (or
+   `per_arch.<target>.blocks` if set) and loads them in the listed order.
+   A block that is a list (`- deploy:`, `- boot:`, `- test:`) is appended
+   to `actions`; a block that is a mapping (`header_qemu`, `context_qemu`)
+   becomes top-level keys of the job.
+2. fills in `${name}` placeholders. Values come from the command line
+   (target, release, branch), then the `values` of the test, then
+   `per_arch.<target>.values`; later ones win.
+3. inserts the `steps` of the test into the first empty `steps: []` list o=
f
+   the job.
+4. applies the text edits: `replace`, then `per_arch.<target>.replace`,
+   `disk` and `efi_name`. `${branch}` and `${distribution}` are filled in
+   only after these edits, so the edits never change a branch name.
+
+## Example 1: a new negative software update test
=20
 The test applies an update whose `sw-description` is removed and expects
-swupdate to refuse it.
+swupdate to refuse it. It differs from the existing negative tests only in
+the commands, so it reuses their blocks.
=20
 1. Add the shell commands as `steps/missing_sw_description.yml`. Each entr=
y is
    one command; `${distribution}` and `${architecture}` are filled in:
@@ -32,8 +51,11 @@ swupdate to refuse it.
    - if grep -q "sw-description" /root/swupdate.txt; then echo "verificati=
on successful"; else lava-test-raise "Fail job"; fi
    ```
=20
-2. Add the test to `jobs.yml`. It reuses the blocks of the other negative
-   software update tests and only names the new steps:
+   `$LAVA_DISPATCHER_IP` and `$LAVA_JOB_ID` are shell variables on the
+   target and stay as they are. The last command decides the result:
+   `lava-test-raise` fails the job.
+
+2. Add the test to `jobs.yml`:
=20
    ```yaml
    swupdate-missing-sw-description:
@@ -44,11 +66,20 @@ swupdate to refuse it.
        job_title: software update testing
    ```
=20
-   `output_name` is the file name; `{test}` and `{target}` are filled in.
-   The `test_swupdate_inline` block contains an empty `steps: []` list; th=
e
-   generator fills it with the commands from the fragment.
-
-3. Generate and check the job:
+   - The key `swupdate-missing-sw-description` is the test name, used as
+     `--test` and as `test_function` in CI.
+   - `output_name` is the file name of the job; `{test}` and `{target}` ar=
e
+     filled in.
+   - `*swupdate_negative_blocks` is the YAML anchor defined at
+     `swupdate-corrupt-swu`: header, TPM, deploy of the image and the .swu=
,
+     boot, and `test_swupdate_inline`, whose `steps: []` list receives the
+     commands of `steps/missing_sw_description.yml`.
+   - `job_title` ends up in the job name (`${architecture} ${job_title}` i=
n
+     `header_qemu`).
+   - Without `targets`, the test exists for qemu-amd64, qemu-arm64 and
+     qemu-arm.
+
+3. Generate the job and validate it against the LAVA server:
=20
    ```
    python3 scripts/lava_jobs.py --test swupdate-missing-sw-description \
@@ -57,38 +88,145 @@ swupdate to refuse it.
    lavacli -i <identity> jobs validate /tmp/jobs/swupdate-missing-sw-descr=
iption_qemu-amd64.yml
    ```
=20
-4. Add a unit test (in `tests/test_lava_qemu_jobs.py` for QEMU jobs,
-   `tests/test_lava_mcom_jobs.py` for MCOM jobs), and a `test_function` en=
try
-   in `.gitlab-ci.yml` to run the test in the pipeline.
+   `--branch` is the directory of the build artifacts on the download
+   server; CI passes the pipeline ID. Read the generated file once: it is
+   the job LAVA runs.
+
+4. Add a unit test to `tests/test_lava_qemu_jobs.py` (M-COM jobs:
+   `tests/test_lava_mcom_jobs.py`). Check what makes this test different
+   from the others, here that the commands are in the job:
+
+   ```python
+   def test_missing_sw_description_steps(self):
+       job =3D build("swupdate-missing-sw-description", "qemu-amd64")
+       self.assertIn("rm /root/swu/sw-description", list(all_strings(job))=
)
+   ```
+
+   `build()` (from `tests/lava_test_helpers.py`) generates the job like th=
e
+   command line does, with branch `br` and release trixie.
+
+5. Run the test in CI. Add one job per target to `.gitlab-ci.yml`:
+
+   ```yaml
+   test:qemu-amd64-swupdate-missing-sw-description:
+     extends:
+       - .test-cip-core
+     needs: ["build:qemu-amd64-base"]
+     variables:
+       target: qemu-amd64
+       test_function: swupdate-missing-sw-description
+   ```
+
+   `.test-cip-core` calls `scripts/submit_lava.sh`, which generates the jo=
b
+   with `test_function` as `--test`, validates and submits it. `needs`
+   names the build job that deploys the image the test downloads.
+
+## Example 2: a test with its own blocks
+
+The test boots the image and checks the kernel architecture. No existing
+test action fits, so it gets a new block.
+
+1. Create `blocks/test_kernel_arch.yml`. A block is a list with one LAVA
+   action:
+
+   ```yaml
+   - test:
+       timeout:
+         minutes: 5
+       definitions:
+       - repository:
+           metadata:
+             format: Lava-Test Test Definition 1.0
+             name: kernel-arch
+             description: "check the kernel architecture"
+           run:
+             steps:
+               - uname -m
+         from: inline
+         name: kernel-arch
+         path: inline/kernel-arch.yaml
+   ```
+
+2. Add the test to `jobs.yml` with the full list of blocks:
=20
-## Adding a new block
+   ```yaml
+   kernel-arch:
+     output_name: "{test}_{target}.yml"
+     blocks: [header_qemu, action_tpm, deploy_tmpfs, boot_qemu,
+              test_kernel_arch, context_qemu]
+     values:
+       job_title: kernel architecture check
+     targets: [qemu-amd64, qemu-arm64]
+   ```
=20
-Create `blocks/<name>.yml` with the action as a list item, for example a
-test action:
+   - `header_qemu` (mapping): device type, timeouts, tags, notification.
+   - `action_tpm`: starts the software TPM; `deploy_tmpfs` passes its
+     socket to QEMU, so the two go together.
+   - `deploy_tmpfs`: downloads and decompresses the wic image.
+   - `boot_qemu`: boots and logs in.
+   - `test_kernel_arch`: the new block.
+   - `context_qemu` (mapping): the LAVA context; always written last.
+   - `targets`: only these targets get the job. For any other target
+     `lava_jobs.py` writes nothing, and `submit_lava.sh` fails with
+     "No job definition generated".
+
+3. Generate, validate, add a unit test and the CI jobs as in Example 1.
+
+## Example 3: differences between targets
+
+`per_arch` holds what differs for one target. From `jobs.yml`:
=20
 ```yaml
-- test:
-    timeout:
-      minutes: 5
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "check the kernel version"
-        run:
-          steps:
-            - uname -r | grep -q ${context_architecture}
-      from: inline
-      name: sample-test-4
-      path: inline/sample-test.yaml
+secure-boot-unsigned-bootloader:
+  ...
+  values:
+    start_monitor: Access Denied
+    end_monitor: "BdsDxe: failed to load Boot"
+  per_arch:
+    qemu-arm64:
+      disk: vda
+      efi_name: bootaa64.efi
+      values:
+        start_monitor: Image not authenticated
+        end_monitor: EFI Boot failed!
 ```
=20
-Then list `<name>` in the `blocks:` of a test in `jobs.yml`. Blocks are
-added to `actions` in the listed order. A block that is a mapping (for
-example `header_qemu` or `context_qemu`) becomes top-level keys of the job
-instead. The `jobs.yml` header describes all keys, including `per_arch` fo=
r
-target specific blocks, values and text replacements.
+- `values` overrides the values of the test for this target: the arm64
+  firmware prints other messages than OVMF on amd64.
+- `disk: vda` replaces every `sda` in the job; the arm guests have a virti=
o
+  disk.
+- `efi_name` replaces `bootx64.efi` with the boot loader name of the
+  target.
+
+M-COM (x86-uefi) is real hardware and needs other blocks. The `swupdate`
+test sets them with `per_arch.x86-uefi.blocks`, and uses `replace` for a
+text that differs on M-COM:
+
+```yaml
+per_arch:
+  x86-uefi:
+    blocks: [header_mcom, deploy_mcom_swu, deploy_mcom, boot_mcom, ...]
+    replace:
+      - ["overlay-1.1.1.4", "overlay-2.1.1.4"]
+```
+
+`replace` is a list of `[old, new]` pairs applied to every string of the
+job. Use it for a small change of an existing block; for anything larger,
+add a block. M-COM must be listed in `targets`.
+
+## Example 4: a new placeholder
+
+To use a new value, for example `${swu_name}` in a block:
+
+1. Add `swu_name` to `KNOWN_VARIABLES` in `scripts/lava_jobs.py`. Only
+   known names are replaced; any other `${...}` is treated as a shell
+   variable and left in the job, so a missing entry is not reported.
+2. Set the value in `values` of the test (or `per_arch.<target>.values`).
+   If a test uses a block with `${swu_name}` and sets no value,
+   `lava_jobs.py` stops with "missing value for placeholder 'swu_name'".
+3. Document the name in `doc/README.lava-testing.md`.
+
+## Blocks to keep in sync
=20
 The `boot_mcom`, `boot_mcom_secureboot` and `boot_mcom_after_update`
 blocks are near-copies; keep them in sync.
diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/te=
mplates/secureboot_corrupt_rootfs_steps.yml
deleted file mode 100644
index 5c47b306..00000000
--- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-          - "apt-get update"
-          - "apt install -y fdisk"
-          - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-image=
-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Dsystem=
a '$0 ~ name {print $2}')"
-          - "rootfs_start=3D$((${rootfs_start_sector} * 512))"
-          # The value 96 is squashfs superblock header size, so skip heade=
r and corrupt the data after that.
-          - "offset=3D$((${rootfs_start} + 96))"
-          - "dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-#dist=
ribution#-#architecture#.wic bs=3D1 seek=3D${offset} count=3D8 conv=3Dnotru=
nc"
diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates=
/secureboot_negative_test.yml
deleted file mode 100644
index 0814b868..00000000
--- a/tests/templates/secureboot_negative_test.yml
+++ /dev/null
@@ -1,84 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-device_type: qemu
-job_name: #architecture# secure boot testing
-timeouts:
-  job:
-    minutes: 50
-  action:
-   minutes: 40
-  actions:
-    power-off:
-      seconds: 60
-priority: medium
-tags:
-- swtpm-jobs
-visibility: public
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION BLOCK
-actions:
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 20
-
-# DEPLOY BLOCK
-- deploy:
-    to: downloads
-    timeout:
-      minutes: 30
-    images:
-      system:
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
-        compression: zstd
-    postprocess:
-      docker:
-        image: debian:bookworm
-        steps:
-        #POSTPROCESS_STEPS#
-    timeout:
-      minutes: 30
-    to: downloads
-
-- deploy:
-    timeout:
-      minutes: 30
-    to: tmpfs
-    images:
-      system:
-        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
-                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
-                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: downloads://cip-core-image-security-cip-core-#distribution#-#=
architecture#.wic
-
-      #Firmware#
-        #Firmware_args#
-        #Firmware_url#
-
-# BOOT BLOCK
-- boot:
-    timeout:
-      minutes: 25
-    method: qemu
-    media: tmpfs
-- test:
-    monitors:
-    - end: "#END_MONITOR#"
-      name: corrupted-#ARTIFACT#-image
-      pattern: _unused_
-      start: "#START_MONITOR#"
-    timeout:
-      minutes: 25
-
-context:
-  arch: #context-architecture#
-  guestfs_interface: virtio
-  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secu=
reboot_template.yml
deleted file mode 100644
index 2a150b8f..00000000
--- a/tests/templates/secureboot_template.yml
+++ /dev/null
@@ -1,70 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-device_type: qemu
-job_name: #architecture# secure boot testing
-timeouts:
-  job:
-    minutes: 50
-  action:
-   minutes: 40
-  actions:
-    power-off:
-      seconds: 60
-priority: medium
-tags:
-- swtpm-jobs
-visibility: public
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION BLOCK
-actions:
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 20
-
-# DEPLOY BLOCK
-- deploy:
-    timeout:
-      minutes: 30
-    to: tmpfs
-    images:
-      system:
-        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
-                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
-                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
-        compression: zstd
-
-      #Firmware#
-        #Firmware_args#
-        #Firmware_url#
-
-# BOOT BLOCK
-- boot:
-    timeout:
-      minutes: 25
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-    parameters:
-      kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
-
-context:
-  arch: #context-architecture#
-  guestfs_interface: virtio
-  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tes=
ts/templates/secureboot_unsigned_bootloader_steps.yml
deleted file mode 100644
index f4f4043a..00000000
--- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-          - "apt-get update"
-          - "apt install --yes guestfish sbsigntool"
-          - "guestfish add cip-core-image-security-cip-core-#distribution#=
-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.=
efi ."
-          - "sbverify --list bootx64.efi"
-          - "sbattach --remove bootx64.efi"
-          - "sbverify --list bootx64.efi"
-          - "guestfish add cip-core-image-security-cip-core-#distribution#=
-#architecture#.wic : run : mount /dev/sda1 / : copy-in bootx64.efi /EFI/BO=
OT/"
diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/t=
emplates/secureboot_unsigned_kernel_steps.yml
deleted file mode 100644
index 6ab334a1..00000000
--- a/tests/templates/secureboot_unsigned_kernel_steps.yml
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-          - "apt-get update"
-          - "apt install --yes guestfish sbsigntool"
-          - "guestfish add cip-core-image-security-cip-core-#distribution#=
-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
-          - "sbverify --list linux.efi"
-          - "sbattach --remove linux.efi"
-          - "sbverify --list linux.efi"
-          - "guestfish add cip-core-image-security-cip-core-#distribution#=
-#architecture#.wic : run : mount /dev/sda2 / : copy-in linux.efi /"
diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templat=
es/swupdate-test-action-M-COM.yml
deleted file mode 100644
index f86c4faa..00000000
--- a/tests/templates/swupdate-test-action-M-COM.yml
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-# TEST BLOCK 1
-# Fail the job if software update application failed
-- test:
-    timeout:
-      minutes: 15
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "Test software update"
-        run:
-          steps:
-            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JO=
B_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-x86-u=
efi.swu --output test.swu
-            - if swupdate -l 5 -i test.swu; then echo software update is s=
uccessful!!; else lava-test-raise "Fail job"; fi
-      from: inline
-      name: sample-test-1
-      path: inline/sample-test.yaml
diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/test=
s/templates/swupdate_corrupt_swu_artifact_steps.yml
deleted file mode 100644
index 043867e5..00000000
--- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JO=
B_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#arch=
itecture#.swu --output /root/cip-core-image-security-cip-core-#distribution=
#-#architecture#.swu
-            - mkdir -p swu
-            - cpio -ivd --directory=3D/root/swu < /root/cip-core-image-sec=
urity-cip-core-#distribution#-#architecture#.swu
-            - dd if=3D/dev/zero of=3D/root/swu/cip-core-image-security-cip=
-core-#distribution#-#architecture#.delta_update bs=3D1 count=3D256
-            - cd /root/swu
-            - for file in sw-description sw-description.sig cip-core-image=
-security-cip-core-#distribution#-#architecture#.delta_update linux.efi; do=
 echo "${file}"; done | cpio -ovL --reproducible -H crc > cip-core-image-se=
curity-cip-core-#distribution#-#architecture#.swu
-            - swupdate -l 5 -i cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.swu > /root/swupdate.txt
-            - cat /root/swupdate.txt
-            - if grep -q "Image invalid or corrupted" /root/swupdate.txt; =
then echo "kernel file corrupt test verification successful!!"; else lava-t=
est-raise "Fail job"; fi
diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templat=
es/swupdate_corrupt_swu_steps.yml
deleted file mode 100644
index 3cdb7930..00000000
--- a/tests/templates/swupdate_corrupt_swu_steps.yml
+++ /dev/null
@@ -1,9 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JO=
B_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#arch=
itecture#.swu --output /root/cip-core-image-security-cip-core-#distribution=
#-#architecture#.swu
-            - mkdir -p swu
-            - dd if=3D/dev/zero of=3D/root/cip-core-image-security-cip-cor=
e-#distribution#-#architecture#.swu bs=3D1M count=3D5
-            - swupdate -l 5 -i /root/cip-core-image-security-cip-core-#dis=
tribution#-#architecture#.swu > /root/swupdate.txt
-            - cat /root/swupdate.txt
-            - if grep -q "CPIO Header corrupted, cannot be parsed" /root/s=
wupdate.txt; then echo ".swu file corrupt test verification successful!!!";=
 else lava-test-raise "Fail job"; fi
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/s=
wupdate_negative_test.yml
deleted file mode 100644
index 950368f1..00000000
--- a/tests/templates/swupdate_negative_test.yml
+++ /dev/null
@@ -1,94 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-device_type: qemu
-job_name: #architecture# software update testing
-timeouts:
-  job:
-    minutes: 50
-  action:
-   minutes: 40
-  actions:
-    power-off:
-      seconds: 60
-tags:
-- swtpm-jobs
-priority: medium
-visibility: public
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION BLOCK
-actions:
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 20
-
-# DEPLOY BLOCK
-- deploy:
-    timeout:
-      minutes: 10
-    to: downloads
-    images:
-      image:
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.swu
-
-- deploy:
-    timeout:
-      minutes: 30
-    to: tmpfs
-    images:
-      system:
-        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
-                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
-                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
-        compression: zstd
-
-      #Firmware#
-        #Firmware_args#
-        #Firmware_url#
-
-# BOOT BLOCK
-- boot:
-    timeout:
-      minutes: 25
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-
-# TEST_BLOCK
-# Fail the job if software update application error is not as expected
-- test:
-    timeout:
-      minutes: 25
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "Test software update by modifying the files"
-        run:
-          steps:
-            #TEST_BLOCK_STEPS#
-      from: inline
-      name: sample-test-1
-      path: inline/sample-test.yaml
-
-context:
-  arch: #context-architecture#
-  guestfs_interface: virtio
-  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/te=
mplates/swupdate_reboot_without_confirm.yml
deleted file mode 100644
index d63e8833..00000000
--- a/tests/templates/swupdate_reboot_without_confirm.yml
+++ /dev/null
@@ -1,48 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-# qemu-swtpm.sock will be gone after soft reboot.
-# So the swtpm socket need to be started again for proper reboot
-# To start the swtpm daemon, first the existing one should be killed
-- command:
-    name: manual_kill
-    timeout:
-          minutes: 1
-# Start the swtpm daemon
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 1
-
-- boot:
-    timeout:
-      minutes: 5
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-    parameters:
-       kernel-start-message: "kernel: C:BOOT0:linux.efi"
-
-# Fail the job if ustate is not 3 (failed) after reboot
-- test:
-    timeout:
-      minutes: 5
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "check boot loader environment variables"
-        run:
-          steps:
-            - if [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $=
2}') =3D 3 ]; then echo ustate status failed; else lava-test-raise "Fail jo=
b"; fi
-      from: inline
-      name: sample-test-3
-      path: inline/sample-test.yaml
diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates=
/swupdate_same_uuid_steps.yml
deleted file mode 100644
index 83290552..00000000
--- a/tests/templates/swupdate_same_uuid_steps.yml
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JO=
B_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#arch=
itecture#.swu --output /root/cip-core-image-security-cip-core-#distribution=
#-#architecture#.swu
-            - mkdir -p swu
-            - cpio -ivd --directory=3D/root/swu < /root/cip-core-image-sec=
urity-cip-core-#distribution#-#architecture#.swu
-            - current_uuid=3D$( cat /etc/os-release | grep IMAGE_UUID=3D |=
 cut -d'"' -f 2)
-            - swu_uuid=3D$(cat /root/swu/sw-description | grep IMAGE_UUID =
| cut -d'=3D' -f3 | cut -c 1-36)
-            - sed -i s/$current_uuid/$swu_uuid/g /etc/os-release
-            - swupdate -l 5 -i /root/cip-core-image-security-cip-core-#dis=
tribution#-#architecture#.swu > /root/swupdate.txt
-            - cat /root/swupdate.txt
-            - if grep -q "'configfilecheck()' failed" /root/swupdate.txt; =
then echo "test verification successful!!!"; else lava-test-raise "Fail job=
"; fi
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupda=
te_template.yml
deleted file mode 100644
index cd1c98cb..00000000
--- a/tests/templates/swupdate_template.yml
+++ /dev/null
@@ -1,135 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-device_type: qemu
-job_name: #architecture# software update testing
-timeouts:
-  job:
-    minutes: 50
-  action:
-   minutes: 40
-  actions:
-    power-off:
-      seconds: 60
-tags:
-- swtpm-jobs
-priority: medium
-visibility: public
-notify:
-  criteria:
-    status: finished
-  recipients:
-  - to:
-     method: email
-     email: cip-testing-results@lists.cip-project.org
-
-# ACTION BLOCK
-actions:
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 20
-
-# DEPLOY BLOCK
-- deploy:
-    timeout:
-      minutes: 30
-    to: tmpfs
-    images:
-      system:
-        image_arg: '-drive file=3D{system},discard=3Dunmap,if=3Dnone,id=3D=
disk,format=3Draw -m 1G -serial mon:stdio
-                    -nographic -netdev user,id=3Dnet,hostfwd=3Dtcp:127.0.0=
.1:22222-:22 -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-swtpm.sock
-                    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm #imageargs=
#'
-        url: #project_url#/#branch#/#architecture#/cip-core-image-security=
-cip-core-#distribution#-#architecture#.wic.zst
-        compression: zstd
-
-      #Firmware#
-        #Firmware_args#
-        #Firmware_url#
-
-# BOOT BLOCK
-- boot:
-    timeout:
-      minutes: 25
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-
-# TEST_BLOCK 1
-# Fail the job if software update application failed
-- test:
-    timeout:
-      minutes: 15
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "Test software update"
-        run:
-          steps:
-            - if swupdate -l 5 -d "-u #project_url#/#branch#/#architecture=
#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then=
 echo software update is successful!!; else lava-test-raise "Fail job"; fi
-      from: inline
-      name: sample-test-1
-      path: inline/sample-test.yaml
-
-# qemu-swtpm.sock will be gone after soft reboot.
-# So the swtpm socket need to be started again for proper reboot
-# To start the swtpm daemon, first the existing one should be killed
-- command:
-    name: manual_kill
-    timeout:
-          minutes: 1
-# Start the swtpm daemon
-- command:
-    name: start_tpm
-    timeout:
-          minutes: 1
-
-- boot:
-    timeout:
-      minutes: 5
-    method: qemu
-    media: tmpfs
-    prompts: ["root@demo:~#"]
-    auto_login:
-      login_prompt: "demo login:"
-      username: "root"
-      password_prompt: "Password:"
-      password: "CIPsecurity@123"
-      login_commands:
-        - if mountpoint /home; then mount -o remount,exec /home; else moun=
t -o remount,exec /var; fi
-    parameters:
-       kernel-start-message: "kernel: C:BOOT1:linux.efi"
-
-# TEST BLOCK 2
-# Fail the job if ustate is not #updatestate# after reboot
-- test:
-    timeout:
-      minutes: 5
-    definitions:
-    - repository:
-        metadata:
-          format: Lava-Test Test Definition 1.0
-          name: sample-test
-          description: "check boot loader environment variables"
-        run:
-          steps:
-            - if [ $(bg_printenv | grep ustate | awk 'FNR =3D=3D 2{print $=
2}') =3D 2 ]; then bg_setenv -c; else lava-test-raise "Fail job"; fi
-      from: inline
-      name: sample-test-2
-      path: inline/sample-test.yaml
-
-#REBOOT_WITHOUT_CONFIRM_STEPS#
-
-context:
-  arch: #context-architecture#
-  guestfs_interface: virtio
-  lava_test_results_dir: '/home/lava-%s'
--=20
2.47.3

