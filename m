Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706CC9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:39:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5867.1790249937042799224
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zy94ZwD0;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umvp/Jb3gWYAmTKc9gQcV13oA97t0jAPwM5G7g5JwB4Z5jRzc8nwkXt+zYuMZ+AoxRrhLB4Wbn37oOd9RI/WQTjbDuRcHR/ld+f0vf+xGIymiHjTTMA1b9C6pSfBw2qktj5mkRlephE9OO0YcTMSBJLbFTLTI4cqLrLivfUwWjbT1Z/vZJD2mB2HaC/XLGkKew2FUXGL6RsyYNX4cCERt+s4BDApkwgm0fWy9U6IyyXVD0eU71aVdooZdGdNBorIxIFB4Ot3YPTufuiuBkMO51Fx2JUZd+rewWa+McRVPioPuNuHJ/h1YrZlJqtRbimmbvsabVbCvHxs4fclVKv0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHwpCXjGAcBjLrYjNEGDQunEOp/YqSB8Cszs7Ujgt8M=;
 b=qN1MZOVbaZT/dwLVPyBBA7czC8LwQ6UsC/IYi82WotAEAhmdMSMCH6MBXeJwKuaNH5FCKW6/AeSlivAB7QEtvf5Vu1CBtNPu3NmA7XDvPHwwXPzJCXBkJNtsFpFImPBO+6n9IoZ3d7SbB2dkeL75GGUo29IC3t26k1ZPRk2h8Xljv1UBDiYEtO4rBnSLKFpX6EvC/pWY/dJOBmY0AzxIu3x6/f8nw+FpOdex0QCKpxQ2ph/1hM8mIfkXZ6Lrcjmm6K1lanT/gj6InhHHV7qTnZ0tWnY0AYAfxAtdZlLqOun1jIEi4vVdeeviETW74xwqEUsc5C+K3HlEMt4iAaXkGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHwpCXjGAcBjLrYjNEGDQunEOp/YqSB8Cszs7Ujgt8M=;
 b=zy94ZwD0Fj7Odp2Ye1OzW4IZpPXvyiG8dKxIoW94rgk8k47BJjWzoAUvSfqctAcmHnl068RNCiMmvakuLvXMImzFeqXeaK5IZ2oE7ERvGJep2l/zf9N+oC2A1OJh7/PWrVvgKl/x7/0wJJRqtrfCsPYE05pMkCq0Z5J7Fs0dj8LMfwZnLYHCTmD/ejJxu0HH/5FJk42OO1mXKkDGJ8uSF/ffYJmgDrDYadR0f8m1TVibAdglSPiqE7lx9352v1N//Mq777AP4Y9nZosQxaxNVE7wgsQoXIVm1553U7EAkFLsM4A3A3I/XscWRk1x+/FCzZSz96utdglwA+zHISeehA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by PAWPR10MB7769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:34f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:38:50 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:38:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 0/4] Add wiping of hard disk to factory reset
Date: Thu, 24 Sep 2026 13:38:32 +0200
Message-ID: <20260924113844.3192747-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|PAWPR10MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: df21090b-07bc-47df-483c-08df1a306706
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|3023799007|6133799003|5023799004|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	crkzCAF4V2yFXQ9oRMKaLzmRouUYtPWHkFWPxpPOcYVBngmPaKhCHoXoJZ2ioNkLU5gEhmEVEQJw5N8igcURtTC+mwYhxUHD98srbpZ0yW+IFjFIM0VvV77qp9jGoraah0Q6XeCXlNH7jZvhfdhuC5zJqM6LHqaQvoc7/nRPHrwE84/BaeCiaQcOlPrrNysnAmermWZsqx3dC7rTtL9oY/ipq+qQbiVC0nMzGeIY0l5m/n+DKoDekC0sC5of+KbmepsAZiW0ptBy+4VQKvU6XoKG5ulUO12AMRkQ6EqvKUxfQDjP4kFexWpGQqK2CsjSf1am4iE8rjJl71h9MratK0CXFK1HIblQMmvk9pGmzrWbqwwuumqyRITl3zcfVyme66qyMTEBZsmIbHAzQjxUwqupR0+H0YOh5fOtfAHEG0aXOaKMBhETAMjkaiHJ3PzxUspytaFjcSWlY+Ict2HQrge50++qgJBXL23ZxDlNIQVDz2M/b7MdcbO1RZJuJG7IDJRrIVcwyzY+dxcwfW68ZIMQEPtcQ8PlUoKNa/V+byjHtMhHqEi3cCzYdPKdml3ZtB51OgoUPClKpyJ1RnS+m9E72kXszHklICRR5wrZIeZ/LUfh3D3dTG6ADW4ASJEo
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(5023799004)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jsm8wtRi5338SHA0AUC9U0CUffSpDLHfdFbWD0RvHkbz1s1TMiT+qb5tYUKQ?=
 =?us-ascii?Q?aI7mWLc67zY1AUEuq92Uc7gYKk2eKDUgOjR99hhylt2v1mduo5fP4UH76LhA?=
 =?us-ascii?Q?omespVtRkAeSgc+s6lQxmluNJ0kxpMnBhrSjr684cQL6zFIF9+tfzE9glfcB?=
 =?us-ascii?Q?o1h48gbSQYcyKD0HuvyMYqcqjTiEvr9lYqmo5vQk6E5b6a5w/hHY+DyM0Z/x?=
 =?us-ascii?Q?8+xqZkhaFNKLhrOjms5s9ldKwtmNzxL64xJOcaxa2Roa4+EiD7CoxodlOGvX?=
 =?us-ascii?Q?Ty/yNKEz72mcLwMk3ZYyFMTMu8Y+jLE4JJ8N/18cKmPDeKhSVufqzhC9glZg?=
 =?us-ascii?Q?Zk99kQk0esy2/xZc7K3B8/F9YIBQZkSBA7ytN/zNr3PSox+CBFpVyDfri7zJ?=
 =?us-ascii?Q?0XE+X20pvgv3akVLDdDYnrLRayRAlt8PnOM64vC03oqh44EeF09x+y9O8+yn?=
 =?us-ascii?Q?5VGQoun5L5Z10KPbPEU4jaYfF73xwZatkp1ngJAt2fSPtXIob5hQoiba3VDc?=
 =?us-ascii?Q?wsUhqjPM537FfTh/fM9ad22NOlhj6BcvtHBGVD1WZQj8AkrHYki7GEd/faZm?=
 =?us-ascii?Q?O+WNQhpsPWl/IlqXrk32Clzjacz5bdjplVaC/iH/IbrGVLLXqhTrW8tZkGZV?=
 =?us-ascii?Q?729+6swIyiFOKeDfWX8/gPOows31Wy4oNSwaTmvMNLrxMV6X9AFvwD8mLWfs?=
 =?us-ascii?Q?HY4rXI1cyh456KierASPJCcGMyGZvQcFsxzMg3PHu9DgSc2wKbnSBo69ytTv?=
 =?us-ascii?Q?xmtzEcKKeJB8JfCcqRuIFhfv4g9WqkS43tLHEYEny/HVsEYezU3n/XQc5y7P?=
 =?us-ascii?Q?5fc96Y3iJvMxiizPbKWqNYKP4njOgH17ZQvjbBN7XycalxqTph3D9m3PqjZD?=
 =?us-ascii?Q?gPYlFJ5FiIRu1NItyTE+CELl2an4a1bY+YAy+Y82y5su5yDq0fn5+I+fX/ao?=
 =?us-ascii?Q?t9J9ChssHhemhILolrIw4rQyTy9RYwDx4JbkmwHwebZIedwqg9H1yBmIo3Vo?=
 =?us-ascii?Q?zYlv6ILbpvVlwr0dojdlfzUbSznLFsCebgSJTiYBqHRXT0jWnyQUxacT93eV?=
 =?us-ascii?Q?xia7MEyxxlBX7fY//Nsxd83hEzVVYTX03oBkEfK2t8qv2eb2T4fcy+GaFUHB?=
 =?us-ascii?Q?nf2bVGatRYVJpavMAfoNxfFc6WYutmdVATDkad4Y1z7z/Q1KqPugySgQCkj1?=
 =?us-ascii?Q?v2hdLChcVzhxVLJZ6HX50wqndRDU2Ninoiz/pTCAENFhCLgZcD+WDtB87DaB?=
 =?us-ascii?Q?+wZO6czrhIkBekcx7dpGflimMR4CcRekwEGZx15ZP/NcmLfaPOsNznQA7Crg?=
 =?us-ascii?Q?UTXSGCLMl2DNxmr3jtEdqvy6VzGgsmYX19+kva62/oR4xbDTQyORAht2N2Ai?=
 =?us-ascii?Q?py59DqV0Ev0QnoutpJKTnTwFdtWNOwSTwg7AumBAG43JYKtKhekuwJZ4UWmJ?=
 =?us-ascii?Q?rUVvgNT2+fZSufrXw0F3ZYPOJuiYj7OGOFaYLCh1KzV6zpNt4E/vMeClBZAJ?=
 =?us-ascii?Q?uLWrERGku7u0xWpJFG+qsuSddSDtpXGAdfkmR4f5n2NAZ7TJizAmGAQANmtn?=
 =?us-ascii?Q?tyf74mhHdTAg7YUs3lH8Rh9h1mSoDhEfqqZEjiSUqXaMnDmHTq8RVIzNaDbn?=
 =?us-ascii?Q?JM1YdQTABi0PwfT8HAz3Fw1Mvc8HrLlr8coxUNWA6tUo6UPtnAdCl57ezkTU?=
 =?us-ascii?Q?Wrq3Z53fCT3BF3QvGQLsfXd+91eUzIuGBFcAlyOBAToUwBAZGDkYZPTkeTs/?=
 =?us-ascii?Q?uQnsDecjV4ADSRvXerMEI4o4KR2uznw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df21090b-07bc-47df-483c-08df1a306706
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:38:50.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQqYmqsr3ed2MLilvJduqhdiK5XVJk8lncQetHnnRChLIvpu2kY3pG+tq7nipHLkySTH/QDiL/hje6rViz9efgp2Vfewq/E6lUECqZ/+JnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7769
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24328

With this patch set a partition marked for factory reset is wiped if
- disk encryption is disabled, or
- disk encryption is enabled and the TPM is *not* cleared.

If the TPM is cleared, the LUKS key is gone and the old data is
inaccessible anyway, so the partition is only reformatted.

This fixes the missing wiping from issue [1].

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/164=
#2-no-proper-wiping-of-disks-if-not-encrypted

Changes since v3:
    - rebase onto 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1

Changes since v2:
 - Move the TPM clear fix to the front of the series and rename
   INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR to
   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL.
 - Keep CRYPT_SETUP_TIMEOUT instead of renaming it, it now defaults to
   the new global INITRAMFS_SETUP_TIMEOUT (fallback 600). Documented
   in the recipe. No deprecation warning needed as nothing is renamed.
 - Add INITRAMFS_FACTORY_RESET_TIMEOUT, also defaulting to
   INITRAMFS_SETUP_TIMEOUT.
 - Move the INITRAMFS_WATCHDOG_DEVICE default (including the ftpm-stmm
   case from b31ad236d5d9) into the distro configuration so that both
   hooks use the same logic. Recipes only keep an empty fallback.
 - Split the target -> target_device rename into a separate patch.
 - Fix commit messages.

Changes since v1 (RFC):
 - Wipe automatically depending on disk encryption and on whether the
   TPM is cleared, instead of requiring an opt-in ':clear' suffix in
   INITRAMFS_FACTORY_RESET_DEVICES.
 - start_watchdog(): check both parameters, use log_warning_msg()
   instead of echo.
 - Drop /run/watchdog.pid, the shell variable watchdog_pid is
   sufficient as start_watchdog() and stop_watchdog() are always called
   from the same script.
 - Do not add the psmisc dependency and do not copy fuser into the
   initramfs, both were unused.
 - Keep the blank line after wait_30sec_for_condition.
 - Add fix that the TPM clear was enabled instead of disabled when
   setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0'.
 - Drop the RFC prefix.

Quirin Gylstorff (4):
  initramfs-factory-reset: Ensure that '0' disables the TPM clear
    instead of enabling it
  initramfs-crypt-hook: Move service watchdog to cip functions
  initramfs-factory-reset: Rename target to target_device
  initramfs-factory-reset: Wipe partition before creating a new fs

 conf/distro/cip-core-common.inc               |  9 +++-
 .../files/cip-initramfs-functions             | 36 ++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/local-top-complete                  | 23 +--------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} | 14 +++---
 .../files/factory-reset-script.tmpl           | 50 +++++++++++++------
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 17 +++++--
 8 files changed, 103 insertions(+), 48 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (92%)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (72%)

--=20
2.55.0


