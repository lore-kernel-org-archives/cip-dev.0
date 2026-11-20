Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=usJhunSa;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r77nYjWxyC7XQsWAAB41zVuTcO6AEU4Y/oalXm81sPb/2xy/MV1BP3/ADBHy4tFYEVAxndXpUR0TyZuG+B4yopfELO14ffwwUgAVI9BBDDdEeM8wbTxXwF5J9NzHwYZrItMb/uKcteA9GR1gKbdc2qDGGzmlJ48Ye47ea/sMs0PYc4DK3u5tnisUJHQmy92lB7ZUuEExNDjs3ZzF49q9Sibh2MEIFGMdX1fHOjt6t8Mum84gdAbf/BGwsP+j/tOjvDkEOQTqjeDr+rhiDDfmdxJE84U09Yfhrhikfe91+oZBDG5hJLfzNGl7l/P5HirQjoxsmrzQNMAtitJVaiK6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPI0l02SKVpT3Af9wAikh6nQgm8tYEEFAqsxULqo4mc=;
 b=sO6Te/WscV6NYOUqShoF9kIy9BNlkYZy0UDgC1Oll+WUWmFRNFgoGJiXDXoteYpO4XRIpwigqwnxmKC8DNpHHMBl1TJFy3qfmtyJPcTNNnxyqxfFyjeld9q0H6bnCJXOPwOkHKmYv4R1FjCYqlv6U3lTgM/vw90ygJ1b6+ATNOwG1RYyN8tivX6RBrmeXFDhIuLmiLKZkjhXAUFFblOlw1tPxt2q/wfQJAWvAhp4PWVr46OygwqR8SsJVAjH4Q1MHMbdpNu2mVZJM5am+SQX5CVQWlmL6pKg64GBl8l69nhUmyw6cRyrs14LXkgh8mvKYt9YJHzZHrYn2G1pIrC3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPI0l02SKVpT3Af9wAikh6nQgm8tYEEFAqsxULqo4mc=;
 b=usJhunSaRmDD31XVx0Nndwh6YlprhefesU+/8nTNEJmU1+M1QXhQKwmNEY2gcbtxtCJOcVuK+Jj+ookQ3Ty/+8NeDpNEX5IrbLpy5uQ8Nj+/ZDSPag3a++lyv49yhMqSokYoemICGFuvaSO7ggixkMlf5fjvwm+yJpCP1qRHKbOd0C8LbhqW/eDIEG4gWh/WbN7y8XYdO8Y9wskcN8HZnPhdDwbx2ZsXPWPnx3uRgXnQbQ0OsMOgV+iSr8pTHi+Op3l6nDjVx6U5VrKQ9tNbFuQyCDbMA6QHDdSGJR9e6Df0h/WMXej5JdsNx1RbF/QxIbK3IrYPEHXR+JAX95A0lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:01 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:01 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 0/8] Deploy zstd images and generate LAVA jobs with Python
Date: Fri, 20 Nov 2026 09:25:46 +0100
Message-ID: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 540fbf1b-cbd2-470d-5ebb-08df46dfe933
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|260925022911599003|56012099006|260925021911599003|260925021311599003|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qIXQn8uWqT3xU7jKajNSgQK14gg536/HoDg+yiW+OXCWFGNE1UlqEI1ADZ+XtCWjNHieI38zFwXAzjkiKXtZg61jrq4iKesl7/if/Riq5tmPNOClQAAXWjYGu62Jhe//YyJFnhJe09D2lsIqvK3iWxPY045H1tqwuDCl43EbHSpNoszU00G/JIgHU92EF/KKddE/rpcbczAXf/CH1T0+83CPqTfbBXAXFibSlm3QfRRq1GPh56+31qGVp5jiZxQAMiG7Ad/b5R1VoC//XEmAIdAd18AppgfVDQ6TFwE0nujClXIAaqVtzsNpjRZXoch4MstC4tBYxpyibGVxMLf8f25PRP1KeU+pTZMo9pSvTxXGjtvYqsHBOGbzq1AjuDkBlXBXlWKqOSCqs7u+BuzKCN2Nqkq7yXOUVpGNCngKJhHxXsKbT/yPCIn/16V4xD5Kiu8Kqp9Ts2jI7zSjP5W3YHkq3sCfaLtuAJSTcJmEyTeV5RnS5zAJf38x3rMLBmDob7ETX9MGx81ohzjUV0v/MTx5KxTTyS2TzpteLIEsIke5yOK32k1n6B129vHEgnllSfMlRaG1LLCUH/evbFFHkEp5GwywVbkVObCUcOe1uf3nFkmqcu7fuadyRD2EDGnypfUKydR40P7GtXymnpowU/8M21XzWVprSQDwgDwEB2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(260925022911599003)(56012099006)(260925021911599003)(260925021311599003)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m42ra7xvLYy55DIDUC4LkeHLqUN3uIPZ3YYtnazqo0nvGGwoSNhxulLY2EqG?=
 =?us-ascii?Q?NOHOnidRjB285fmUhL6I6oY840hJ4DY2FxIzoXwPXc5EyaOZDHSxuldxj9m2?=
 =?us-ascii?Q?zyC0MPv5LvxZTIQR1bXzTo/+Kdpt2PENeP1rqJsyAhhV1ct4B0byTIgYRrXv?=
 =?us-ascii?Q?rKkEfGfHEykt5nPSHKfyNP4znZJuZ5Qek5t4mSQ0HeQMzIbBA3Zj5nGG/IXM?=
 =?us-ascii?Q?qVeCVf4SRDKzsXKOOLCFqOs7qQjOrEILWuXejQ7PFLaq3IwZ3YE7MuB2fbqw?=
 =?us-ascii?Q?liivtFICMou67gJUwIN4PZuvbDr3Dl3qyinjTfc+LYJlFSDj3oKMgzWIh9v9?=
 =?us-ascii?Q?9dNQQbJkt+xztr8SdOVLF49AeqThxoN6mjQxY1dcYolP6Ij5mxq8VwzOj9pV?=
 =?us-ascii?Q?2VZivFGsBeZ3P0F0WPAOeybWzQzCcwx6G8qNz4fM7HY40EbxfrtkTjCbAQnU?=
 =?us-ascii?Q?2vOlM/b0IpSCyFMk8LKeNqD6H8ZmZtscttAq+KOMg23WjWuDEEPPc8TZ7O7V?=
 =?us-ascii?Q?w8dx8aBXAAic3EbOz3GdPZpVk/c2vjeepXqLb9MlJDKldntwOL7jNjToY6P1?=
 =?us-ascii?Q?Q39uLIEgtAbpKmj/YiUwoC4yHc6aSNJ+HxW/lhXtAQWp4FKXg/qtm5ZGKwD4?=
 =?us-ascii?Q?OtrMWMnhtmXtkTPpxnIvtUHIzHcXrlpRtQRLf7GPUcmGRbCbld4EeztwWMaz?=
 =?us-ascii?Q?tORnHh2ihch/mDxM/M08hk5rRLpD3aitZtJZObDJxB13Av6WsH0tF2aOb3v+?=
 =?us-ascii?Q?2iu5Zsl6JReU3Uw02AsDURGv1VVR4anuD30Fu5S0yH0yB7iyoHISDzbLqGra?=
 =?us-ascii?Q?9UEF4vDAbfZ5RVDu50qoxvtyQ+QfLc2nNRNMdZX3D7Wp6w5Z++u/5rFP7mhS?=
 =?us-ascii?Q?BXIuPl/DbQD9lqRFQp+oK8Apt0xIrLkt3RQFTaUjXI2LJrq1R1juxEnNvhow?=
 =?us-ascii?Q?m0sKTDoXcZ+HQdlHJlrcVv6HNw0DOXBCobTveHP2gtk/T0E7LfSGAgO9hH59?=
 =?us-ascii?Q?h4VELDh4DfTCuFf1IjEwrACQlWMYCvBpTIFBerZcOk7QlOFwBFQmwAMeNxiz?=
 =?us-ascii?Q?+4UoCHklQO7kzDnwOyIidOEesryweLdI8ftNpE/NvjUJYPbz6x8eEt/fZh38?=
 =?us-ascii?Q?/IY11RFrXbpxGXrHggtsJotc6yaVa/Vhgja9S45pLZ3O+vyAJp1XZNtcS3y0?=
 =?us-ascii?Q?0IQsUu6gFLanukqIo2N0pfr8Kn51RbVX2icVu5KujZYSVON2N8sWj/sWN8P5?=
 =?us-ascii?Q?y+mQd4X7VD6lmBIsp9opwj/Tde0Wx/FBugmxvRBDEjvrIlbeZqbC792H8poR?=
 =?us-ascii?Q?E+UmdmuGnNbkjBeIcDmwKMXMicr8RQ0SbR9zPNOgoB8xe2lnTVXWexTtnyjs?=
 =?us-ascii?Q?dN+zx8rif+/MmVMcomuAsCZ78oL/iGQ/wW28uWyeSvDrCbmcSoB1eUc6r2ne?=
 =?us-ascii?Q?ti1TB92B7joixsL7LnYaST6QaKimAogpiEuUteQ0lU/nAsFHrSE8nUDtXm8r?=
 =?us-ascii?Q?kpAijltjslMSIcnGfBrksm56AADsMa2H0KUz7nDMx+BL9xcF+06gCwu0MleV?=
 =?us-ascii?Q?qy5ruMK9XgCQkSl54bDY1y2QT5a8cdeNS3ro0lBscma+R27e0RYP7w3lJuqs?=
 =?us-ascii?Q?rlN498VppkR3TZOM4mCVvUzm2V1KmoFTR0lcKzmpWqwgj99vMJEWmeE7Eb+k?=
 =?us-ascii?Q?N5OsakhMrUsLoKsCE4U7QGa+KJ1X1U75xQLu7xm8GdqpBfzkUIM2nX111v/E?=
 =?us-ascii?Q?vubH1I2b6GKkA4EKHC2eyeg0stOE5S0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540fbf1b-cbd2-470d-5ebb-08df46dfe933
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:01.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMYsGLBbth/Gw5H2daEku9/62769NE9ikWOKCZjr6ERPUPvqymGaZgNPE8L7NifK/q82/aVaieLvemkRXtzWxXt9T1HrXMgBMTjuQncIapU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25027
Content-Type: text/plain; charset="utf-8"

This series changes two things in the CI test setup.

1. zstd instead of xz for the deployed wic images (patches 1-3)

The wic images were compressed with xz -9 in deploy-cip-core.sh after
the build, and every LAVA job decompresses the image again. Isar now
produces wic.zst images directly (IMAGE_FSTYPES), and the deploy step,
the wic-partitions archive, the reproducible build check and the LAVA
templates use zstd. Decompression is about 4.5 times faster (qemu-arm:
2.2-2.8 s with xz, 0.5 s with zstd) for almost the same size (qemu-amd64
+0.7 %, qemu-arm +0.5 %, qemu-arm64 +7 %). Patch 1 and 2 switch the CI
scripts from apt to apt-get and install zstd explicitly in the
reproducible build check.

2. A Python generator for the LAVA job definitions (patches 4-8)

submit_lava.sh built the LAVA jobs by editing templates with sed, grep
and envsubst. The templates were not valid YAML, what job a chain of
edits produces was hard to tell without running a test, and errors
only showed up in LAVA. The new scripts/lava_jobs.py composes the jobs
from valid-YAML fragments in tests/templates (blocks/, steps/,
jobs.yml) with PyYAML and is covered by unit tests
(python3 -m unittest discover -s tests), which now run in CI.
The command line of submit_lava.sh is unchanged. tests/templates/README.md
explains how a job is built, with examples for adding a test.

The generator uses PyYAML (python3-yaml) because it is the YAML parser
of the LAVA server and dispatcher (lava_common/yaml.py: yaml_safe_load
and yaml_safe_dump on top of PyYAML's SafeLoader/SafeDumper), so the
jobs are parsed and written the same way LAVA reads them. It needs
python3-yaml in the lavacli image. To publish and test the new image
without replacing the shared image, the image tag is configurable
(LAVACLI_TAG, default "latest"), the image can be built from a web
pipeline with LAVACLI_CONTAINER set, and such a pipeline only builds the
image.

Why RFC:
- Feedback on the generator design (fragments + jobs.yml + small rule
  functions) is welcome before it replaces the templates.
- The "latest" lavacli image has to be rebuilt with python3-yaml before
  the LAVA test jobs of this series can run. gettext-base stays in the
  image, so older branches keep working with it.

Testing:
- Pipeline on an earlier version of this series (lavacli image under a
  branch tag, before the review fixes and the added CI job): all builds
  and all 38 LAVA test jobs passed.
  https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/3089202=
185
- Unit tests pass at every patch from patch 4 on.

Quirin Gylstorff (8):
  scripts: use apt-get in run-cve-checks.sh
  ci: install zstd explicitly in the reproducible build check
  ci: deploy zstd compressed wic images
  scripts: add Python LAVA job generator
  ci: use a tagged lavacli image and allow manual builds
  ci: skip all other jobs when building the lavacli container
  scripts: use Python LAVA job generator in submit_lava.sh
  ci: run the LAVA job generator unit tests

 .gitlab-ci.yml                                |  46 ++-
 .reproducible-check-ci.yml                    |  12 +-
 conf/machine/bbb.conf                         |   2 +-
 conf/machine/beaglev-fire.conf                |   3 +-
 conf/machine/de0-nano-soc.conf                |   2 +-
 conf/machine/hihope-rzg2m.conf                |   2 +-
 conf/machine/iwg20m.conf                      |   2 +-
 conf/machine/rzt2h-evk.conf                   |   2 +-
 conf/machine/ti-am62px-sk.conf                |   2 +-
 conf/machine/x86-uefi.conf                    |   2 +-
 doc/README.lava-testing.md                    |  52 ++-
 kas/opt/ebg-secure-boot-snakeoil.yml          |   2 +-
 scripts/Dockerfile.lavacli                    |   2 +-
 scripts/deploy-cip-core.sh                    |  10 +-
 scripts/lava_jobs.py                          | 371 ++++++++++++++++++
 scripts/run-cve-checks.sh                     |   5 +-
 scripts/submit_lava.sh                        | 220 +----------
 tests/lava_test_helpers.py                    |  37 ++
 tests/templates/IEC_template.yml              |  79 ----
 tests/templates/M-COM-x86.yml                 |  54 ---
 tests/templates/README.md                     | 247 ++++++++++++
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
 .../test_swupdate_mcom.yml}                   |   8 +-
 tests/templates/blocks/tpm_restart.yml        |  21 +
 tests/templates/jobs.yml                      | 193 +++++++++
 .../secureboot_corrupt_rootfs_steps.yml       |  10 -
 tests/templates/secureboot_negative_test.yml  |  84 ----
 tests/templates/secureboot_template.yml       |  70 ----
 .../secureboot_unsigned_bootloader_steps.yml  |  10 -
 .../secureboot_unsigned_kernel_steps.yml      |  10 -
 tests/templates/steps/corrupt_rootfs.yml      |  16 +
 tests/templates/steps/corrupt_swu.yml         |  15 +
 .../templates/steps/corrupt_swu_artifact.yml  |  18 +
 .../reboot_without_confirm.yml}               |   6 +
 tests/templates/steps/same_uuid.yml           |  18 +
 tests/templates/steps/unsigned_bootloader.yml |  16 +
 tests/templates/steps/unsigned_kernel.yml     |  16 +
 .../swupdate_corrupt_swu_artifact_steps.yml   |  12 -
 .../templates/swupdate_corrupt_swu_steps.yml  |   9 -
 tests/templates/swupdate_negative_test.yml    |  94 -----
 tests/templates/swupdate_same_uuid_steps.yml  |  12 -
 tests/templates/swupdate_template.yml         | 135 -------
 tests/test_lava_branch_names.py               |  52 +++
 tests/test_lava_cli.py                        |  87 ++++
 tests/test_lava_core.py                       |  61 +++
 tests/test_lava_fragments.py                  |  73 ++++
 tests/test_lava_mcom_jobs.py                  | 107 +++++
 tests/test_lava_qemu_jobs.py                  | 112 ++++++
 69 files changed, 2077 insertions(+), 828 deletions(-)
 create mode 100644 scripts/lava_jobs.py
 create mode 100644 tests/lava_test_helpers.py
 delete mode 100644 tests/templates/IEC_template.yml
 delete mode 100644 tests/templates/M-COM-x86.yml
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
 rename tests/templates/{swupdate-test-action-M-COM.yml =3D> blocks/test_sw=
update_mcom.yml} (82%)
 create mode 100644 tests/templates/blocks/tpm_restart.yml
 create mode 100644 tests/templates/jobs.yml
 delete mode 100644 tests/templates/secureboot_corrupt_rootfs_steps.yml
 delete mode 100644 tests/templates/secureboot_negative_test.yml
 delete mode 100644 tests/templates/secureboot_template.yml
 delete mode 100644 tests/templates/secureboot_unsigned_bootloader_steps.ym=
l
 delete mode 100644 tests/templates/secureboot_unsigned_kernel_steps.yml
 create mode 100644 tests/templates/steps/corrupt_rootfs.yml
 create mode 100644 tests/templates/steps/corrupt_swu.yml
 create mode 100644 tests/templates/steps/corrupt_swu_artifact.yml
 rename tests/templates/{swupdate_reboot_without_confirm.yml =3D> steps/reb=
oot_without_confirm.yml} (93%)
 create mode 100644 tests/templates/steps/same_uuid.yml
 create mode 100644 tests/templates/steps/unsigned_bootloader.yml
 create mode 100644 tests/templates/steps/unsigned_kernel.yml
 delete mode 100644 tests/templates/swupdate_corrupt_swu_artifact_steps.yml
 delete mode 100644 tests/templates/swupdate_corrupt_swu_steps.yml
 delete mode 100644 tests/templates/swupdate_negative_test.yml
 delete mode 100644 tests/templates/swupdate_same_uuid_steps.yml
 delete mode 100644 tests/templates/swupdate_template.yml
 create mode 100644 tests/test_lava_branch_names.py
 create mode 100644 tests/test_lava_cli.py
 create mode 100644 tests/test_lava_core.py
 create mode 100644 tests/test_lava_fragments.py
 create mode 100644 tests/test_lava_mcom_jobs.py
 create mode 100644 tests/test_lava_qemu_jobs.py

--=20
2.47.3

