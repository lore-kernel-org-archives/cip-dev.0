Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2EA109E53D
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:08 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8740.1773819556608457355
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 00:39:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=g7W/BoH0;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.57.38, mailfrom: kamlesh@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REbRK+QlumxUECM1EOiNpR2MyGMOulo6SLxx+SLwr9pV5khtDYhKxSDi69cWNgoJegs5BdxJBWsSeLVeE+Dck+r2mNq5HKTiOoAP1ofY0ssY+5v2R1/WL3S54J7On70LcenI3EYXDCXrbXX6jF9Gim8WUzt+x4LmTboy+grB4iskTFRoq/Inpx/MUSOC1fjYnePoaspB8/X4vsBewiMEOaMBvoUeNSVzuQ96qhpNzN4Ucsmah8b43Id0FZv4tWF8nfImawv8+OP6+WT0IRxKmRK1127g5PpByEF0YGUbz/W2A+fdSeHhOKZmB8AZwg9eJAXTki9ky94FgqriA1ViLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG5v3VJmL+vvOIRmLs3VQ4ig2P1lmI+BKGxpvTNUk0w=;
 b=MmYaD5w92F+ifutoGo2zupLLlsK893E7zAh6QpwAvG+Ut748YspldXwohEwipACpHYFAs+9QAAGnf77cmnnHzGMUkfF2w6VO47IKenEjUGK/w8X4uzXD0WcV+6Rbgoz5aZpw+sBvV/JoGbzRmI2b77IXgU2m0gDLnju8Rms78FLh71EA+bgo3O3oJ6b5OxPVikU7DHkVO7wx+BoVtYVZXGmnqGAPrY0Z56pmgWMnFfDciHeuE8Ja2Nl604Wn6DuXeaOBqQkdnashnRZuDwm7eP6vIEdoofYRQ+K/cTVcizbW+FP9xMpBW8e/Ardu6Ku966BVdkRHuapv2Zun4vK2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=denx.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG5v3VJmL+vvOIRmLs3VQ4ig2P1lmI+BKGxpvTNUk0w=;
 b=g7W/BoH0M4VuJC8ZmrVlXbpHN1fab2nu1sz8Sz1SFtpzH34QGJEW6S28mHAZ1D6HMYvd40kCLZuFXQ3d31rkO61Uk4+SYo20DbOjAxRhr9kdYN1+PUdBLUqT1J0hv7nBCx+vfCJlpAUX98HHyDUE310z/WMk8k9lH8w4o8+Ndt0=
Received: from SA9PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:6e::27)
 by PH3PPF3EF78961B.namprd10.prod.outlook.com (2603:10b6:518:1::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Wed, 18 Mar
 2026 07:39:13 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::3c) by SA9PR11CA0022.outlook.office365.com
 (2603:10b6:806:6e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 07:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 07:39:11 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 02:39:02 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 02:39:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 02:39:01 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62I7d0kE442933;
	Wed, 18 Mar 2026 02:39:01 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, <dinesh.kumar@toshiba-tsip.com>
CC: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifier MIT header
In-Reply-To: <1aae01cb-60f6-4f63-b611-aeb940a9f1e1@siemens.com>
References: <20260316-license-v1-1-5bb039f50c05@ti.com>
 <ff1b96aa-44e2-408c-85cf-abae3ae9593e@siemens.com>
 <OSZPR01MB851533DF594CC6F32A00B996BF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <0e193c29-a351-4405-a2d1-a102a7ce4c5f@siemens.com>
 <OSZPR01MB8515AD7A41E51815382BA4BFBF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <1aae01cb-60f6-4f63-b611-aeb940a9f1e1@siemens.com>
Date: Wed, 18 Mar 2026 13:09:00 +0530
Message-ID: <875x6t37u3.fsf@kamlesh.mail-host-address-is-not-set>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH3PPF3EF78961B:EE_
X-MS-Office365-Filtering-Correlation-Id: a45d65f8-ef34-48a8-4f12-08de84c172a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	23/F1gIdbZVYrPfCFnqL0vtO3gFST83R1xmebMzycG2lmfHWSsDa+41s86OzgHvxVT0vCzTp4UvMpPk+6HPNDiP5DE8aMBwBmQOr/ekSN9PQSxv07eT4vM7H7d9r/og1BjpnZ7tlJ5fFubx6tHpqQ5CSanv+e3K6vcs50Ms+xDwdpBIIYBe7LmEAvQZsK55jDr3VpaN8WMExQMHh//+1mirs+vD09McdYjFrubBo0EfaVsWKntlJgyhZvWH2K3vRn8x9lfi0U6CtE2ezQ0IzaBUrQTHOPKq+CPN8PIqLlbocFoLyGfyfTj4Zw3LVUMIbVRGznucWYoi0eH+aJ9IzrT4plBEGb4gwwjw9rnHbhi2NYzF7i37Ze+ib3ZmzbzPqp1Qh1E38YkgX2TwYYCH9ii5xoktH0Zc7hNb8gIuhaQIUA51jWE8oJWPTq6w4NhwkjO6hcbeqPFdNtZWqWYO2CTwLTXm9heEcxwo9ast71pgo0XmQnRBnNsffR8U86VhgIytGrXZ4yd7veTfErtHfMPI2waT5CgL5FO9OmcZCwJqXeVYi7r9WyP8p0uwGhnG1UArrnuTw7fjj4wvlJg/xT6LmTfmO1oZ2V9bRE2bqLFE2HNS/qhWsQjGtqZwX9NspxvPqZFERD1K03BxRQ4nOI24xrZcMVCiTV0V3Umw2OGWCMVRosAZRnJbB2C71hdNFvRYsSXq+g3NWUwnKV/PjHgzmfqKVgbykVqAk8pW7LJGYJFznhULnZstbC3wugVHq0DZIW5jtu1P0AlMhfKimNQ==
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	q/3askUNc1KS/RKpzWuKab2Y80w6PjhmY5Hk9JW9gUDh4n/lE0N/RuDsP7Say8wN5SbKXOjRZT0IRxhei3lcqwV2qZL3tf2sw27LLainoutQfsBKIP4o+/xOl28YaNqCeZ+YPBExarB8GGLQT6Sn1qWJx28XupK50erV0IEwujUDczQmSiFJcpbGq8GyGem76StogvpXJJkzh85nAAxav5Jktpb0fyU31UEhD2NzMBwl6Z+Iox+FDMzdK9+0+Sew03eQVadSO8ZJJPVQRc6w+LEV/529iIU5q8Zprl51UgjwrIBAvbBijmq+g585XKkoz/WbyHkRX0RQ+GkNXb0ngAUquzVcX/IEy1J7S2x09RxMp5KXhGV88uDbxiHjtcsbG/dq+v8VKZiEZg1KL/VrcUbplcnidyMaE57VXHAg/+12hmCncr+ksRBJOPWac4w3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:39:11.9348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45d65f8-ef34-48a8-4f12-08de84c172a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3EF78961B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 03:00:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22572

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 16.03.26 13:19, dinesh.kumar@toshiba-tsip.com wrote:
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Monday, March 16, 2026 3:53 PM
>> To: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <din=
esh.kumar@toshiba-tsip.com>
>> Cc: kamlesh@ti.com; cip-dev@lists.cip-project.org; pavel@denx.de
>> Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifie=
r MIT header
>>=20
>> On 16.03.26 10:27, dinesh.kumar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>> Please refer my response below.
>>>
>>> Thanks & Regards,
>>> Dinesh kumar
>>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Monday, March 16, 2026 2:17 PM
>>> To: Kamlesh Gurudasani <kamlesh@ti.com>; dinesh kumar(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0=20
>>> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;=20
>>> cip-dev@lists.cip-project.org; pavel@denx.de
>>> Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT=20
>>> header
>>>
>>> On 16.03.26 09:34, Kamlesh Gurudasani wrote:
>>>> Add missing license headers to shell scripts and YAML test templates.
>>>>
>>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>>> ---
>>>>  scripts/deploy-cip-core.sh                               | 3 +++
>>>>  scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
>>>>  scripts/generate_secure_boot_keys.sh                     | 3 +++
>>>>  scripts/start-efishell.sh                                | 3 +++
>>>>  scripts/submit_lava.sh                                   | 3 +++
>>>>  scripts/update-linux-cip.sh                              | 3 +++
>>>>  scripts/update-ltp.sh                                    | 3 +++
>>>>  tests/templates/IEC_template.yml                         | 3 +++
>>>>  tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
>>>>  tests/templates/secureboot_negative_test.yml             | 3 +++
>>>>  tests/templates/secureboot_template.yml                  | 3 +++
>>>>  tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
>>>>  tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
>>>>  tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
>>>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
>>>>  tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
>>>>  tests/templates/swupdate_negative_test.yml               | 3 +++
>>>>  tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
>>>>  tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
>>>>  tests/templates/swupdate_template.yml                    | 3 +++
>>>>  20 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh=20
>>>> index 623c216..1e08e47 100755
>>>> --- a/scripts/deploy-cip-core.sh
>>>> +++ b/scripts/deploy-cip-core.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>=20=20
>>>>  set -e
>>>>=20=20
>>>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh
>>>> b/scripts/generate-sb-db-from-existing-certificate.sh
>>>> index dddd9b5..42d09dd 100755
>>>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>>>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>=20=20
>>>>  set -e
>>>>=20=20
>>>> diff --git a/scripts/generate_secure_boot_keys.sh
>>>> b/scripts/generate_secure_boot_keys.sh
>>>> index 8be0569..28ae34c 100755
>>>> --- a/scripts/generate_secure_boot_keys.sh
>>>> +++ b/scripts/generate_secure_boot_keys.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>=20=20
>>>>  set -e
>>>>=20=20
>>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh=20
>>>> index fff8a6a..86e2ddd 100755
>>>> --- a/scripts/start-efishell.sh
>>>> +++ b/scripts/start-efishell.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/sh
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>=20=20
>>>>  set -e
>>>>=20=20
>>>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh index=20
>>>> b3180a1..a4d20ec 100755
>>>> --- a/scripts/submit_lava.sh
>>>> +++ b/scripts/submit_lava.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH  # Chris=20
>>>> Paterson <chris.paterson2@renesas.com>  # Sai Ashrith=20
>>>> <sai.sathujoda@toshiba-tsip.com> diff --git=20
>>>> a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh index
>>>> 5fbfa57..df306b2 100755
>>>> --- a/scripts/update-linux-cip.sh
>>>> +++ b/scripts/update-linux-cip.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>>> "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>>>>=20=20
>>>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh index=20
>>>> dc8b947..321cc3c 100755
>>>> --- a/scripts/update-ltp.sh
>>>> +++ b/scripts/update-ltp.sh
>>>> @@ -1,4 +1,7 @@
>>>>  #!/bin/bash
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>=20=20
>>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>>> "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit diff --git=20
>>>> a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>>>> index f8558cd..148f07e 100644
>>>> --- a/tests/templates/IEC_template.yml
>>>> +++ b/tests/templates/IEC_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# IEC layer testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> index b6f6628..5c47b30 100644
>>>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install -y fdisk"
>>>>            - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-=
image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Ds=
ystema '$0 ~ name {print $2}')"
>>>> diff --git a/tests/templates/secureboot_negative_test.yml
>>>> b/tests/templates/secureboot_negative_test.yml
>>>> index 2fcdbfa..a8e4226 100644
>>>> --- a/tests/templates/secureboot_negative_test.yml
>>>> +++ b/tests/templates/secureboot_negative_test.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# secure boot testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/secureboot_template.yml
>>>> b/tests/templates/secureboot_template.yml
>>>> index e29b64a..0a075e2 100644
>>>> --- a/tests/templates/secureboot_template.yml
>>>> +++ b/tests/templates/secureboot_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# secure boot testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> index 8d64b05..f4f4043 100644
>>>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install --yes guestfish sbsigntool"
>>>>            - "guestfish add cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/boo=
tx64.efi ."
>>>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> index f097ed6..6ab334a 100644
>>>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>            - "apt-get update"
>>>>            - "apt install --yes guestfish sbsigntool"
>>>>            - "guestfish add cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>>> index 56ff106..69c9cb7 100644
>>>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # TEST BLOCK 1
>>>>  # Fail the job if software update application failed
>>>>  - test:
>>>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> index 2fad3fd..043867e 100644
>>>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - cpio -ivd --directory=3D/root/swu <=20
>>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>>> s wu diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> b/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> index 74c9217..3cdb793 100644
>>>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - dd if=3D/dev/zero
>>>> of=3D/root/cip-core-image-security-cip-core-#distribution#-#architectur
>>>> e
>>>> #.swu bs=3D1M count=3D5 diff --git
>>>> a/tests/templates/swupdate_negative_test.yml
>>>> b/tests/templates/swupdate_negative_test.yml
>>>> index bb79b07..250eaa8 100644
>>>> --- a/tests/templates/swupdate_negative_test.yml
>>>> +++ b/tests/templates/swupdate_negative_test.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# software update testing
>>>>  timeouts:
>>>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml
>>>> b/tests/templates/swupdate_reboot_without_confirm.yml
>>>> index bfad106..074eb1a 100644
>>>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>>>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  # qemu-swtpm.sock will be gone after soft reboot.
>>>>  # So the swtpm socket need to be started again for proper reboot  #=20
>>>> To start the swtpm daemon, first the existing one should be killed=20
>>>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml
>>>> b/tests/templates/swupdate_same_uuid_steps.yml
>>>> index 3ff2e02..8329055 100644
>>>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>>>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LA=
VA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-=
#architecture#.swu --output /root/cip-core-image-security-cip-core-#distrib=
ution#-#architecture#.swu
>>>>              - mkdir -p swu
>>>>              - cpio -ivd --directory=3D/root/swu <=20
>>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>>> s wu diff --git a/tests/templates/swupdate_template.yml
>>>> b/tests/templates/swupdate_template.yml
>>>> index e1f71a9..9a3366b 100644
>>>> --- a/tests/templates/swupdate_template.yml
>>>> +++ b/tests/templates/swupdate_template.yml
>>>> @@ -1,3 +1,6 @@
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>>  device_type: qemu
>>>>  job_name: #architecture# software update testing
>>>>  timeouts:
>>>>
>>>> ---
>>>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>>>> change-id: 20260316-license-c5fcde3618d2
>>>>
>>>> Best regards,
>>>
>>> Thanks for taking care! Here is the list of contributors to these files:
>>>
>>> Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> Chris Paterson <chris.paterson2@renesas.com> Felix Moessbauer=20
>>> <felix.moessbauer@siemens.com> Nobuhiro Iwamatsu=20
>>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>>> Quirin Gylstorff <quirin.gylstorff@siemens.com> Sai=20
>>> <Sai.Sathujoda@toshiba-tsip.com> Sai Sathujoda=20
>>> <Sai.Sathujoda@toshiba-tsip.com> Shivanand Kunijadar=20
>>> <Shivanand.Kunijadar@toshiba-tsip.com>
>>> Srinuvasan A <srinuvasan_a@mentor.com> sai ashrith sathujoda=20
>>> <sai.sathujoda@toshiba-tsip.com> sarath P T <Sarath_PT@mentor.com>
>>>
>>> All worked on behalf of a CIP member. Furthermore, the default license =
rule from the README applies here:
>>>
>>> "Unless otherwise stated in the respective file, files in this layer ar=
e provided under the MIT license, see COPYING file. Patches (files ending w=
ith .patch) are licensed according to their target project and file, typica=
lly GPLv2."
>>>
>>> So, I will merge this the next days unless anymore brings forward any c=
oncerns.
>>> [Dinesh] yes please.
>>>
>>> Dinesh, the file list you shared directly with me is fully covered by t=
his?
>>>
>>> [Dinesh] No, there are few other files such as .wks.in, .cong, .cfg, .i=
nc, .tmpl, .list not covered by this patch. I think it's fine to ignore tho=
se files until someone has any concerns.
>>>
>>=20
>> What is the difference of those files to the ones handled above? If we a=
lready make the default licensing rule explicit, why not doing this consist=
ently?
>> [Dinesh] They are mostly configuration and data files, but I agree with =
you to make it consistent across all files.
>>                 Can you please proceed to apply current patch and we wil=
l send another patch to cover remaining files?
>>=20
>
> Let's not just scratch the surface but do it consistently and
> sustainably: Which tool did you use to identify our gaps? Can we embed
> it into our pipeline?
>
> I just tried "reuse lint", but that gives more complaints than just the
> missing headers. E.g., it reveals outdated SPDX identfiers that we still
> have in use ("GPL-2.0" and "AGPL-3.0"). If we completely follow the
> REUSE spec is to be discussed after sorting the reports.
>
> Jan
I tried reuse lint as well and looks like bunch of things to fix.

I agree that we should do it right way.

for Best practice badge, isar-cip-core is build tool and not end product
itself, so we don't really need this patch for that. So I guess we can
take our time to fix it the right way.

Let me know what all you need to get fixed, I can send some patches.

Regards,
kamlesh

>
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center

