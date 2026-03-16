Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC99CF46446
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 10:23:40 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47571.1773656614461353560
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 03:23:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YS7Af3Cm;
 spf=pass (domain: siemens.com, ip: 52.101.72.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwpFzj+7Rz5QZ2yPqeL1O8J/6mkVfyqAc/88+9ff/jYyxyo6WJIBrsyQtnc3MdWinpuJWW3i20/HslPyb35Ed72T7+RcwFYXcSyHnOI80CE9LcZVxpbPg5XtH5VbDbg/3nfuZxG9wErbLeqSp24uewJl2opaRQgsrWMMsILHP8iAgyWUzHpPjAu69v30dumn6rJlWi2PpI3hszZIzjtNaDaXScSHfZC+4rPef0o0nQWlHEADu4mZCNO5nkWTGjpFCR57q8uT2BLkJiuLNT0nN9vNe1wB+TSpQI8DiW0z6qPt41lmrv2dkergTATqdwo/ppkP16Hg1BLNeYB7cEEgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeOBAa78oKJnVEHmJzwmB8NUU1sZ8Ut1prb569/YTb8=;
 b=gi4/BTuXTf6BfkQoUyXteF2MDqkcsLMyBhboYula4IT2wjs0UkFQszIZ4z67rle7iXOa/JIWRIrplVOYzgcXQTn5fm8YqTvwCXbOePbuMI9nSOL5K0fiTkqQH8vWu8nIij7UuzyEGCqED8zbXDnQMRUcGOg7MbPGVAOmFCLWQMg5xZw38VVmd9eFM/eIuEW4WHsogD6bmMuGEFFdbDkeFV82QeViINkLHSiDLgiQ1ydQ9UEwn1sgH9ntRlxt0pUgSsXWaSfRzIf9+YgTFqAAuv/MJcyRRW4kbn0HLjQ0DLRZKoGKZJYRR2AdlfO3xgfs2uYFqPXS6nLJJqIQgzojZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeOBAa78oKJnVEHmJzwmB8NUU1sZ8Ut1prb569/YTb8=;
 b=YS7Af3CmPU2I/UCMFVH0QQtahGkcZeE6e2IYQ0/Osugaxuf66QsEXrBF+ViV83w81l/Je5SQQiIDphsZxzlhuS/cYe9a4iJM5gX6uupNUDpda+D9aTCH6Pdv90O83xXDlSR40t+BwqJZyOXlSWiunvtiGGQuhSdcgPMFhZHYBV+iSRbTM9ep2QuWA81PnEDUbCKL6HqrAsFjChhauZWtJz0F/iQTnnEghmTtF1Q2WCsdIbPAitJ2t11N94EZl/l4ip3gAe730sSH9VpGHcIZtjgfMW1eIXDdF8qqBkDhgYTw6IJLcCTKthaY57Mg50ljoDDsnUDaJa0w3Mlk3VdwYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 10:23:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 10:23:30 +0000
Message-ID: <0e193c29-a351-4405-a2d1-a102a7ce4c5f@siemens.com>
Date: Mon, 16 Mar 2026 11:23:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT header
To: dinesh.kumar@toshiba-tsip.com
CC: kamlesh@ti.com, cip-dev@lists.cip-project.org, pavel@denx.de
References: <20260316-license-v1-1-5bb039f50c05@ti.com>
 <ff1b96aa-44e2-408c-85cf-abae3ae9593e@siemens.com>
 <OSZPR01MB851533DF594CC6F32A00B996BF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB851533DF594CC6F32A00B996BF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CWLP265CA0546.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:18d::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 45662dca-dc1e-4908-1050-08de834611ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|55112099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	yuLEs6n8eyzQ+CLizjrawXJUT9vn4k7eLBGmTika6bG/hdCwA1XKVN/h1IsdupleGimmtsWC7ojJfsqFFY/rYEJzG2StfBGefAEo+nHWT8xDw1Ahpl2hjDoGoII6eiFxJUVUcLCk/66qrs7EgVF2y9grl9hVIQbYQ/zUPOmU5QcrgHKdcIUTi7F3SKvpA2GkwairbOd1mY7s255Pk59pD6j3fA6bdLtNYbQ1llxyLvSEGPts91qlp1xCBimKy5FwruKf8AvRaNoAdwf87Qph3rRTY3S+mABbV/XNkXfmjbMDefT9pxL5X8ukCbmlK5KzJjk/U5aE8VeWOnGK1QKosa7Hoaijvu/J1fW/32ZojEwDjYLDhRBJ/Iy7mYkCvtEYS5YXu0jEOrd+2ddkRuyi3ODaRWeudJ/FwKEJHnJjXYj44ht0dXd4pz/WmBugCpBXCbuIuCEYqxA1awtRPN4LH0X5uJRgwOy1mRxFTG9XyGcX7c/5/PbuSyQXRu5Hh42Kfb0f9aVd5MAZCTv5nsLgcnlBW+WoHEX5wgoNFltM+mvJAxaU1aX0dRuEQ6Oq0AxS2chaBzQKNwt+fvLWCIyG75XZD7NnZlIQHnPcNMJ7ajyxqOtBOe5uuGSN0eR46IcHmAWfEM6F9BGZM+2NWJj7Lcx03D/RorbItTh2Fi2XEfl9I4+vsXLXX9QfZzhZfmD2r2xnxeDh6xdpnZ0dJ4xtHux6pwj0pDbc6/N8iSsuY30=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j8gy2ecCCHUCcd4hm+yFf+acSj/rEMaqlf5TqAomk3AFRSSq10Dbe5FYgmCi?=
 =?us-ascii?Q?jGLuI9dk8v005DJ25OoWdutKs+q0U/kJdyxoZ0ydZR6Wkqo/rL05UdafzqfB?=
 =?us-ascii?Q?lTBYE8K3GsnMdSwU8M/P+rK+CyEBW8Zm6cyPZ6yu9D3csd5/ZsKar9GWHCnf?=
 =?us-ascii?Q?mHWCYGaONXGLgq/lw/iahsKDyJ7Jgz5Wk8r7GI4a/n+3N0xp7pcL9Fdg1jTl?=
 =?us-ascii?Q?5+wu8hZSkFKCv8VJiQEe1jrX0BUBlNysfPab/OkYjqHCIiv3zeqQw9AP/kyC?=
 =?us-ascii?Q?ftFIFviIUFLHRXD+ELbGClENXPblnwW5PmPCDhKB14UZus6q2XsHKaZ9nc85?=
 =?us-ascii?Q?bgslZk1zflo06jgvOgjz3r+QiQj6bqFB8g/0E56PWcbj313rW5u9xt8WkWOr?=
 =?us-ascii?Q?GxGUjHYSUpy5kgj32JsZIEl23i0/roomN4uW8aKJWeRBm8SaPgKiMgeS9fXO?=
 =?us-ascii?Q?IBw8Bqisy58fwdfZhau3BvB/w938sP5iK3sziiL2jcvpAWazjsCfzQjEDB1e?=
 =?us-ascii?Q?TnCZQ8dlup8+8ILglB8wEqu1WJxI8spkO3PwkZOif+DkXS4j5rSBUq9zoGJj?=
 =?us-ascii?Q?QBbOCzEEK9b48Y2FRa3oG75/7ZX5xKJr0YvnEdnyZMBreNv+wkD2SKgl4bkb?=
 =?us-ascii?Q?h1n4bonmi15+scXYkUjuvAtO7cKi5MrY+ZEqFBGBouXAZ2ACbHdwWAXJ3lpA?=
 =?us-ascii?Q?v6IfuHS0EShQBSngmIV1UaLcgqOizArGOrykjoS/YK+Dqz6nlIhWXoiIO16e?=
 =?us-ascii?Q?tyZ0k6Oq60HzBwyLu0s67hoWxw+QS/AL+KLw3kCMWTbGRUvuQ6l/a6rC49NL?=
 =?us-ascii?Q?bdYVVR1vHUmdMx7cB/BkVYRidV3yTa6/7WMbqpfMNWoufHabHLchys3fnMfp?=
 =?us-ascii?Q?qEHVWQDn2DwFqbqsz8T/E89KWpHJkNrqLDRxCmJpb4jkTwDNR1tXkMhCkTKu?=
 =?us-ascii?Q?k8mMMyXUy8ruo5GwFal+fGFRN72bo6eOtfVLZk0EXXu3BrYYGCWpiCSpPPXv?=
 =?us-ascii?Q?CDSbjpy+pcz+yJwOB04Rj48O6npYpVkStDKDJiiIhw8gwNm/YHeH0p6Pysy6?=
 =?us-ascii?Q?Bik/z5JZepeQj50zozTQ/O9oVnNFyR7Srgl/CaEIf+LwZ1G8XdJQwczSwZNe?=
 =?us-ascii?Q?Y8U7RTBDH6BLPfjCMeqsp2rdpWMmrH9ZGHWpL7C7+LgrbWnuDq7LTUAh7Vky?=
 =?us-ascii?Q?qef6B4YoXsDqQV0w/8SAquRX5kKTx2nYtK7gEKEhQc47mothJ7Ezchl0FVt6?=
 =?us-ascii?Q?gskUQX9Lm3CBakB2ixS8zEW64kp5+AVrJDgZAaN04mdkihl380cFvOFDHR7E?=
 =?us-ascii?Q?+L5g71mQX8g6K64sjcj1Q66rBKxfJX2crVVqmgTBdBs8H8tRTvrtmzqamONY?=
 =?us-ascii?Q?tJblFrrXbyaPBon3KnvX1C1/gr1lF0cq3ysg+9s6I886zRBjGmtLB2vfsS3H?=
 =?us-ascii?Q?mTpP8se17wpoUhAyTotCM5M+7kkR8CWkZdEzhn5KmDJ9JGKLNYGDriOniF2l?=
 =?us-ascii?Q?B7lfTPdUlhJW2NAw1akz+GnTOQLX2uhOkHY4JQfv82X578UWar2Wp/t6Xl7I?=
 =?us-ascii?Q?H6segXHlFvxiZqy4tRHPfApK6qc/NWTfCrQWzESE52ker+s1TlH6IsBpZ7P+?=
 =?us-ascii?Q?ZJ6TIP2JpJnOimZcOKSaji+hdB+joGYnFU7yaDUAvcVaAF2QcWOkdDTzFOPe?=
 =?us-ascii?Q?ZsKOhLkg2A/GIKcZc2CpwFhK0Eh2VfCuCjoqXUzF9m0oBJ86X++o8xb2dsy7?=
 =?us-ascii?Q?05lcBciaXg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45662dca-dc1e-4908-1050-08de834611ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:23:30.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2kp4Cs9SKpVU9dO0xwdrncb1Nx5PKZmAzQpZyHxzZ316gtS89PjCUF8sNZ5wVOLOV6C5wFjTuy1UUoK1oXNhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8322
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22378

On 16.03.26 10:27, dinesh.kumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Please refer my response below.
>=20
> Thanks & Regards,
> Dinesh kumar
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, March 16, 2026 2:17 PM
> To: Kamlesh Gurudasani <kamlesh@ti.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; cip-dev@l=
ists.cip-project.org; pavel@denx.de
> Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT heade=
r
>=20
> On 16.03.26 09:34, Kamlesh Gurudasani wrote:
>> Add missing license headers to shell scripts and YAML test templates.
>>
>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>> ---
>>  scripts/deploy-cip-core.sh                               | 3 +++
>>  scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
>>  scripts/generate_secure_boot_keys.sh                     | 3 +++
>>  scripts/start-efishell.sh                                | 3 +++
>>  scripts/submit_lava.sh                                   | 3 +++
>>  scripts/update-linux-cip.sh                              | 3 +++
>>  scripts/update-ltp.sh                                    | 3 +++
>>  tests/templates/IEC_template.yml                         | 3 +++
>>  tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
>>  tests/templates/secureboot_negative_test.yml             | 3 +++
>>  tests/templates/secureboot_template.yml                  | 3 +++
>>  tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
>>  tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
>>  tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
>>  tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
>>  tests/templates/swupdate_negative_test.yml               | 3 +++
>>  tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
>>  tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
>>  tests/templates/swupdate_template.yml                    | 3 +++
>>  20 files changed, 60 insertions(+)
>>
>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh=20
>> index 623c216..1e08e47 100755
>> --- a/scripts/deploy-cip-core.sh
>> +++ b/scripts/deploy-cip-core.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> =20
>>  set -e
>> =20
>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh=20
>> b/scripts/generate-sb-db-from-existing-certificate.sh
>> index dddd9b5..42d09dd 100755
>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> =20
>>  set -e
>> =20
>> diff --git a/scripts/generate_secure_boot_keys.sh=20
>> b/scripts/generate_secure_boot_keys.sh
>> index 8be0569..28ae34c 100755
>> --- a/scripts/generate_secure_boot_keys.sh
>> +++ b/scripts/generate_secure_boot_keys.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> =20
>>  set -e
>> =20
>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh=20
>> index fff8a6a..86e2ddd 100755
>> --- a/scripts/start-efishell.sh
>> +++ b/scripts/start-efishell.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> =20
>>  set -e
>> =20
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh index=20
>> b3180a1..a4d20ec 100755
>> --- a/scripts/submit_lava.sh
>> +++ b/scripts/submit_lava.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH  # Chris=20
>> Paterson <chris.paterson2@renesas.com>  # Sai Ashrith=20
>> <sai.sathujoda@toshiba-tsip.com> diff --git=20
>> a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh index=20
>> 5fbfa57..df306b2 100755
>> --- a/scripts/update-linux-cip.sh
>> +++ b/scripts/update-linux-cip.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>> "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>> =20
>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh index=20
>> dc8b947..321cc3c 100755
>> --- a/scripts/update-ltp.sh
>> +++ b/scripts/update-ltp.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> =20
>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>> "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit diff --git=20
>> a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>> index f8558cd..148f07e 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# IEC layer testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml=20
>> b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> index b6f6628..5c47b30 100644
>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install -y fdisk"
>>            - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-im=
age-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Dsys=
tema '$0 ~ name {print $2}')"
>> diff --git a/tests/templates/secureboot_negative_test.yml=20
>> b/tests/templates/secureboot_negative_test.yml
>> index 2fcdbfa..a8e4226 100644
>> --- a/tests/templates/secureboot_negative_test.yml
>> +++ b/tests/templates/secureboot_negative_test.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# secure boot testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_template.yml=20
>> b/tests/templates/secureboot_template.yml
>> index e29b64a..0a075e2 100644
>> --- a/tests/templates/secureboot_template.yml
>> +++ b/tests/templates/secureboot_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# secure boot testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml=20
>> b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> index 8d64b05..f4f4043 100644
>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install --yes guestfish sbsigntool"
>>            - "guestfish add cip-core-image-security-cip-core-#distributi=
on#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx=
64.efi ."
>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml=20
>> b/tests/templates/secureboot_unsigned_kernel_steps.yml
>> index f097ed6..6ab334a 100644
>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install --yes guestfish sbsigntool"
>>            - "guestfish add cip-core-image-security-cip-core-#distributi=
on#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml=20
>> b/tests/templates/swupdate-test-action-M-COM.yml
>> index 56ff106..69c9cb7 100644
>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # TEST BLOCK 1
>>  # Fail the job if software update application failed
>>  - test:
>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml=20
>> b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> index 2fad3fd..043867e 100644
>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA=
_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#a=
rchitecture#.swu --output /root/cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.swu
>>              - mkdir -p swu
>>              - cpio -ivd --directory=3D/root/swu <=20
>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.s
>> wu diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml=20
>> b/tests/templates/swupdate_corrupt_swu_steps.yml
>> index 74c9217..3cdb793 100644
>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA=
_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#a=
rchitecture#.swu --output /root/cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.swu
>>              - mkdir -p swu
>>              - dd if=3D/dev/zero=20
>> of=3D/root/cip-core-image-security-cip-core-#distribution#-#architecture
>> #.swu bs=3D1M count=3D5 diff --git=20
>> a/tests/templates/swupdate_negative_test.yml=20
>> b/tests/templates/swupdate_negative_test.yml
>> index bb79b07..250eaa8 100644
>> --- a/tests/templates/swupdate_negative_test.yml
>> +++ b/tests/templates/swupdate_negative_test.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# software update testing
>>  timeouts:
>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml=20
>> b/tests/templates/swupdate_reboot_without_confirm.yml
>> index bfad106..074eb1a 100644
>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # qemu-swtpm.sock will be gone after soft reboot.
>>  # So the swtpm socket need to be started again for proper reboot  #=20
>> To start the swtpm daemon, first the existing one should be killed=20
>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml=20
>> b/tests/templates/swupdate_same_uuid_steps.yml
>> index 3ff2e02..8329055 100644
>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA=
_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#a=
rchitecture#.swu --output /root/cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.swu
>>              - mkdir -p swu
>>              - cpio -ivd --directory=3D/root/swu <=20
>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.s
>> wu diff --git a/tests/templates/swupdate_template.yml=20
>> b/tests/templates/swupdate_template.yml
>> index e1f71a9..9a3366b 100644
>> --- a/tests/templates/swupdate_template.yml
>> +++ b/tests/templates/swupdate_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# software update testing
>>  timeouts:
>>
>> ---
>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>> change-id: 20260316-license-c5fcde3618d2
>>
>> Best regards,
>=20
> Thanks for taking care! Here is the list of contributors to these files:
>=20
> Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> Chris Paterson <chris.paterson2@renesas.com> Felix Moessbauer <felix.moes=
sbauer@siemens.com> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Quirin Gylstorff <quirin.gylstorff@siemens.com> Sai <Sai.Sathujoda@toshib=
a-tsip.com> Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com> Shivanand Kunija=
dar <Shivanand.Kunijadar@toshiba-tsip.com>
> Srinuvasan A <srinuvasan_a@mentor.com>
> sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com> sarath P T <Sarath=
_PT@mentor.com>
>=20
> All worked on behalf of a CIP member. Furthermore, the default license ru=
le from the README applies here:
>=20
> "Unless otherwise stated in the respective file, files in this layer are =
provided under the MIT license, see COPYING file. Patches (files ending wit=
h .patch) are licensed according to their target project and file, typicall=
y GPLv2."
>=20
> So, I will merge this the next days unless anymore brings forward any con=
cerns.
> [Dinesh] yes please.
>=20
> Dinesh, the file list you shared directly with me is fully covered by thi=
s?
>=20
> [Dinesh] No, there are few other files such as .wks.in, .cong, .cfg, .inc=
, .tmpl, .list not covered by this patch. I think it's fine to ignore those=
 files until someone has any concerns.
>=20

What is the difference of those files to the ones handled above? If we
already make the default licensing rule explicit, why not doing this
consistently?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

