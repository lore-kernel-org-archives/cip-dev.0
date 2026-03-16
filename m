Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6038DF53D69
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 15:30:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53296.1773675021707734067
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 08:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pk49cZS8;
 spf=pass (domain: siemens.com, ip: 52.101.72.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux3Q4QdS5Fo1KOrH2VsRMHks3K51O4BkHLG0rvPBZSorPSJ9kPJgC0zS/y4AxJbffylEGLN0Nuwy9/Y59NTdNKgaj6jok1sWgp5pyFwohx2ADXyluKqkdjKTZymNwJyPpZ3yXvmOXz1+eSMlf9XSQDpIOpcRtzHFWf4OkEM3NwyEqDjN/5glJs69k+u5rzI0kwiFiAEOi8byBlSQI/XLDG+Goz1+S2dCwPHRGts8n4eYaNgP5PDxvPj7HN2xgKo5mCdEZ/Sdg03LGZBwY0Cy6kGUrPvzbX6vt1w7T7E8O80C0xbIaNEO1yuPwHQw/1G5VN6mOKa4dA5rvAUqXgDP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNPulsv1QAub2h/WnGtDz74KWrJpjKV/8xB0pHFYhEA=;
 b=WcfAGs/u3EK7p6SN5YtG3+inGDusX4QuAYhkXoNZUFZDzl/Xz2mBcYFiibY6EIdXKxdEm43gj0gv/qzuQQ1/lIBXXnVsKlLvjqdNQS1y3RhzHDRQAosCijOfc/+67bBQkr8I6WoAmFv/Na4u9Kf8ty7r9W+Mbel9aIr+waILkga7/q0BSaniVk2myutpu5uKv8Aa+FJMwFN+VtkqGYmMpT/z1Aclh+VMk6+GEj6lYe4rWrA5H+lWBjLfMmnpyq1vElfQTb0lBzn6DugFGoR/gEdXGaiYnvWNubvfCZlRY9uP5OpK27kk+P7wnyleW6Qw5RmPJnXMZGHBQ3qe1EVCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNPulsv1QAub2h/WnGtDz74KWrJpjKV/8xB0pHFYhEA=;
 b=pk49cZS8yoY5S92Qaez/+opNp+z94ZmqxysmUB2YTkC88yGnCp9BN3Ia9RuSEguVi6yH9l+l4WCqOpcDUzv+9FE/iNHRtmcr94TZWEJBohBHIffqAamcdEG3snFOY6TVjpx/9nt3eDw34oB5qq54Ptqjy6xjmSr+xYhD73f9lm8GbYfQzewRIxhhCysT7Ym1ZI9IhWvceMk20vQplDLbvTD7NRxu9SlwgiUuDL0Q1Yre8EIR/DbwgI4F2ACPdXUsfrNq2M4B85lBp2a2xUb2Cg8G+kCClbAsRDYqmDDX2ONIdvY8WlHA9s214IK+GsM3kp17UtW06SIOOgKzdk4jwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 15:30:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 15:30:18 +0000
Message-ID: <1aae01cb-60f6-4f63-b611-aeb940a9f1e1@siemens.com>
Date: Mon, 16 Mar 2026 16:30:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifier MIT
 header
To: dinesh.kumar@toshiba-tsip.com, kamlesh@ti.com
CC: cip-dev@lists.cip-project.org, pavel@denx.de
References: <20260316-license-v1-1-5bb039f50c05@ti.com>
 <ff1b96aa-44e2-408c-85cf-abae3ae9593e@siemens.com>
 <OSZPR01MB851533DF594CC6F32A00B996BF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <0e193c29-a351-4405-a2d1-a102a7ce4c5f@siemens.com>
 <OSZPR01MB8515AD7A41E51815382BA4BFBF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSZPR01MB8515AD7A41E51815382BA4BFBF40A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b8349d-5408-4846-d28f-08de8370ed8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|55112099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	aadYzyX14y8sH4txXnp0tAaLyoVjVFTHQvp4CCPibgKlo/YiPMWEQqXjZD2K4H5+BzD/dcVOyNP7y0sj6h6+59bXjj11ejvlX0Oc6KhePJa8+ELZYLNFLVHnXd6Mof+9/L/ou6AnCL/rrVjiw6F6y3GSv++oCiDJKtJx9yXw86pTyK+ZKs2n4O1mNCiGGVrxfjl6UAI+7QNHjYMdi6a3c01T7D0wwEIJJPMNOKCJ3+ETtWkONn79kESV8Qr5WYNO4O+CSVXynTPQDgSDsEBbEqLgvMBRxKjuKQ46wksbvWDieaNUBcPtq/cpQF9+7pKfuD5KA01haoVUnd8bblKnOVAZA972nxqK9XF8b1Fpl2ku+5WiKb5+0tZ6xnSUDU7M3LaYcHVFHn/VdyWDMJfYTazD5IJo6FM7m4ZzCtBgUVVbxigagJB6vYVRHeBowuT+FQ20Dh5ObWH5DW2WmWWA36U//yKylZKl7vPsmLWtPAwaWJJs2b0jPUTAknEkz8um6m89PTauKQMfewIrDLQvfqjFcRuXkEi5Ul0azcHaGqnQuF/Srfk6B3g9aFWxeCR9pSrrqA1o/+KOU+kJpIFEgxeVyG049p651B7rK6Dlz8BYUHSklOyr6z9qGS+eWZXfPGo6hYfzwef0520gPU2vs2EH17e1V5dbqIwebKzCNzLcvrjI/PjmiqY5O8C4nQZTVCLqyUjyglSln4E2epziX56r6wXDY8HXSY54Xz3Jwkc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(55112099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Hp7fzCPgtsEhvZAr/BrIOJDoA2aq0kGq25IYyHwN5dDQZ9M1xqmKvA2CyNKl?=
 =?us-ascii?Q?vpLA7KbSWpPdZ0bjKDFKTCXIjUsaekoD0+ZefEnEd6oBHbd0GnM3Ec7uwEix?=
 =?us-ascii?Q?z/fowGeJGM3z/iQB75vSGcjQxR5+SJi0HqyzrgiLdb7PY5bWdnWPC4RiEgAs?=
 =?us-ascii?Q?oyfSynQfz6ahJgjFnlZNe7ZNhCzc3umLjveu2sSYV2XVlz+4QLbJ0atJiZ8c?=
 =?us-ascii?Q?ytgiYS7uq4J6NzoUYQOXmzjgEzTy0QM7VPQxOuVbnI1dWTtycXLzuz6h/EY2?=
 =?us-ascii?Q?frUG7YTx9SDsBx8IGVutiCjAdS/XdqbJupFcwR7vTTIqpfbDtAtQ1omyC6m6?=
 =?us-ascii?Q?WamhXDfyYGPJWMXRl1iGoAH/hTk5nt5hllRdF74SRpx/cFpJz7Qm3ZlMM2eG?=
 =?us-ascii?Q?Y9ALt4xDft53sIS93k+2I1DhxO2d1dkAzzYN7AYERpbECJENU8heCLkLFkVt?=
 =?us-ascii?Q?6Gq0RZWE7hswD206y2NLxVy51wFRb1CjGiFjYcW46k6mJA34uriEY6lB2aKH?=
 =?us-ascii?Q?2mSk6OVUlZE/Fzqt5kqjkUAEnvs4bhNy+hslX0vNn1PnwsmEkU6X9ZTbghWb?=
 =?us-ascii?Q?+RLtLYE1KpelKeB3KBGH/cOMQP/W5k65y/74D/dtZuCDFbPLjW6zH+R2MFvI?=
 =?us-ascii?Q?0odfWkqL767T4Hybqil4zESvbG/OP2zRsUZfZ4s5z+p4NhmL4wTWz237lYVq?=
 =?us-ascii?Q?eUL+ikJsXoQvBEjmQNdc8eyWWmZkSjzg9WEmXrgHFS5vV6eOh4AewzW/rhBN?=
 =?us-ascii?Q?LVAKMoAUD3wyMnmgkDaiBybprDatMU1RZ9PRqp+Emq2VYyuxSS9IUNICQskq?=
 =?us-ascii?Q?sPjDtXRjcIWnFyISdZwgMDqotthwWa76vZkjk+vVQYoGcTBzyZkfXk0uH2UD?=
 =?us-ascii?Q?fm3icOkY72qyN/DYzvS1plonDBM2dndKuLXBs08++KO9kvMmKokSEMcKMCCQ?=
 =?us-ascii?Q?bhzH1Eylew3s0tOLNtR2BNtShecpr03d/Gma1t71Oe2HUkjaUmwhb3AErGRy?=
 =?us-ascii?Q?h4t1ro1PC1jqI/qUHUp5+vHlDY+Hk3gtZAGnLdZd0KmijJTdZMhxGodt5blF?=
 =?us-ascii?Q?G7jUCEqQJ1GNsxk5UFpjR/UIH/HszXt7tMBabDifTdYwPt9pI0Xn9+UiTKz7?=
 =?us-ascii?Q?v5Zn7uiYDoh6S2ySJTS3Ut3GJfWWp+Y+W76ny2ND/kfFaXCY4zMWGSx3gnhY?=
 =?us-ascii?Q?S0x/rMYVwP/OqDnnkG11b2t0pv7rPEJA3oTaq9nBxxZwcvlRPuZ7GuocioZv?=
 =?us-ascii?Q?WMqOgGRBHBLx5Y6twjk7WMP2BfneEu3w1k/ILkG5winZDV3psG7AzicwN8l2?=
 =?us-ascii?Q?3423EULHVCMSbrS9iqsO6r05SluBGk5BrIDKwx5RQeFHGGXmQfdSrRRwdJDD?=
 =?us-ascii?Q?3IiaxNO6oAtJEkWeoR23df4MiB+GMsSMAQyNyFFmIRDm1gBgaMbdm4Vro+sV?=
 =?us-ascii?Q?ZazIMs/9WRzwnWVaExCEt1rHoc7T+6JbNobnVEMv/FZCaJY4Es+JtnnKuF9T?=
 =?us-ascii?Q?AVO96vEaBgoeYF9jZIFq9Da8ZvKemxjLqeWkk5SzBp2xo3ihHt9gmLKfCgHK?=
 =?us-ascii?Q?v6djFWyHD8K16Cm9ggvbAuSp0gVUkHb7XAmRSxUcuKjO6dqEN9Sh4SWpYrx6?=
 =?us-ascii?Q?Dd0k7oUajyZygJtONOFBIpx8PqZcv7f/6hIL76Q9Koy78S1izxLdkct+5RnJ?=
 =?us-ascii?Q?6lVnlY+GtjMQmWLSzg3K+Y/2VXQy45mJSpmK2HvHu4ul1vjc0iN3jz7hPuaO?=
 =?us-ascii?Q?6BZ/Je2ylg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b8349d-5408-4846-d28f-08de8370ed8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:30:17.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypJfQxhVy3vy32XTRTr9abPux2Fk/hrmZ3yox4UeFF1peBk6SdP49nkyeXFVwV83vVz+CUsDXy7OMvbvPlKnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 15:30:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22428

On 16.03.26 13:19, dinesh.kumar@toshiba-tsip.com wrote:
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Monday, March 16, 2026 3:53 PM
> To: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dine=
sh.kumar@toshiba-tsip.com>
> Cc: kamlesh@ti.com; cip-dev@lists.cip-project.org; pavel@denx.de
> Subject: Re: [cip-dev] [PATCH] scripts/tests: Add SPDX-License-Identifier=
 MIT header
>=20
> On 16.03.26 10:27, dinesh.kumar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Please refer my response below.
>>
>> Thanks & Regards,
>> Dinesh kumar
>>
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Monday, March 16, 2026 2:17 PM
>> To: Kamlesh Gurudasani <kamlesh@ti.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0=20
>> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;=20
>> cip-dev@lists.cip-project.org; pavel@denx.de
>> Subject: Re: [PATCH] scripts/tests: Add SPDX-License-Identifier MIT=20
>> header
>>
>> On 16.03.26 09:34, Kamlesh Gurudasani wrote:
>>> Add missing license headers to shell scripts and YAML test templates.
>>>
>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>> ---
>>>  scripts/deploy-cip-core.sh                               | 3 +++
>>>  scripts/generate-sb-db-from-existing-certificate.sh      | 3 +++
>>>  scripts/generate_secure_boot_keys.sh                     | 3 +++
>>>  scripts/start-efishell.sh                                | 3 +++
>>>  scripts/submit_lava.sh                                   | 3 +++
>>>  scripts/update-linux-cip.sh                              | 3 +++
>>>  scripts/update-ltp.sh                                    | 3 +++
>>>  tests/templates/IEC_template.yml                         | 3 +++
>>>  tests/templates/secureboot_corrupt_rootfs_steps.yml      | 3 +++
>>>  tests/templates/secureboot_negative_test.yml             | 3 +++
>>>  tests/templates/secureboot_template.yml                  | 3 +++
>>>  tests/templates/secureboot_unsigned_bootloader_steps.yml | 3 +++
>>>  tests/templates/secureboot_unsigned_kernel_steps.yml     | 3 +++
>>>  tests/templates/swupdate-test-action-M-COM.yml           | 3 +++
>>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml  | 3 +++
>>>  tests/templates/swupdate_corrupt_swu_steps.yml           | 3 +++
>>>  tests/templates/swupdate_negative_test.yml               | 3 +++
>>>  tests/templates/swupdate_reboot_without_confirm.yml      | 3 +++
>>>  tests/templates/swupdate_same_uuid_steps.yml             | 3 +++
>>>  tests/templates/swupdate_template.yml                    | 3 +++
>>>  20 files changed, 60 insertions(+)
>>>
>>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh=20
>>> index 623c216..1e08e47 100755
>>> --- a/scripts/deploy-cip-core.sh
>>> +++ b/scripts/deploy-cip-core.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> =20
>>>  set -e
>>> =20
>>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh
>>> b/scripts/generate-sb-db-from-existing-certificate.sh
>>> index dddd9b5..42d09dd 100755
>>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> =20
>>>  set -e
>>> =20
>>> diff --git a/scripts/generate_secure_boot_keys.sh
>>> b/scripts/generate_secure_boot_keys.sh
>>> index 8be0569..28ae34c 100755
>>> --- a/scripts/generate_secure_boot_keys.sh
>>> +++ b/scripts/generate_secure_boot_keys.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> =20
>>>  set -e
>>> =20
>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh=20
>>> index fff8a6a..86e2ddd 100755
>>> --- a/scripts/start-efishell.sh
>>> +++ b/scripts/start-efishell.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> =20
>>>  set -e
>>> =20
>>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh index=20
>>> b3180a1..a4d20ec 100755
>>> --- a/scripts/submit_lava.sh
>>> +++ b/scripts/submit_lava.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH  # Chris=20
>>> Paterson <chris.paterson2@renesas.com>  # Sai Ashrith=20
>>> <sai.sathujoda@toshiba-tsip.com> diff --git=20
>>> a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh index
>>> 5fbfa57..df306b2 100755
>>> --- a/scripts/update-linux-cip.sh
>>> +++ b/scripts/update-linux-cip.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>> "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>>> =20
>>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh index=20
>>> dc8b947..321cc3c 100755
>>> --- a/scripts/update-ltp.sh
>>> +++ b/scripts/update-ltp.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> =20
>>>  REPO_ROOT=3D$(git rev-parse --show-toplevel)  pushd=20
>>> "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit diff --git=20
>>> a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>>> index f8558cd..148f07e 100644
>>> --- a/tests/templates/IEC_template.yml
>>> +++ b/tests/templates/IEC_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# IEC layer testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> index b6f6628..5c47b30 100644
>>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install -y fdisk"
>>>            - "rootfs_start_sector=3D$(fdisk -l -o Name,Start cip-core-i=
mage-security-cip-core-#distribution#-#architecture#.wic | awk -v name=3Dsy=
stema '$0 ~ name {print $2}')"
>>> diff --git a/tests/templates/secureboot_negative_test.yml
>>> b/tests/templates/secureboot_negative_test.yml
>>> index 2fcdbfa..a8e4226 100644
>>> --- a/tests/templates/secureboot_negative_test.yml
>>> +++ b/tests/templates/secureboot_negative_test.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# secure boot testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_template.yml
>>> b/tests/templates/secureboot_template.yml
>>> index e29b64a..0a075e2 100644
>>> --- a/tests/templates/secureboot_template.yml
>>> +++ b/tests/templates/secureboot_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# secure boot testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> index 8d64b05..f4f4043 100644
>>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install --yes guestfish sbsigntool"
>>>            - "guestfish add cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/boot=
x64.efi ."
>>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> index f097ed6..6ab334a 100644
>>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install --yes guestfish sbsigntool"
>>>            - "guestfish add cip-core-image-security-cip-core-#distribut=
ion#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>> index 56ff106..69c9cb7 100644
>>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # TEST BLOCK 1
>>>  # Fail the job if software update application failed
>>>  - test:
>>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> index 2fad3fd..043867e 100644
>>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAV=
A_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#=
architecture#.swu --output /root/cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - cpio -ivd --directory=3D/root/swu <=20
>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>> s wu diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml
>>> b/tests/templates/swupdate_corrupt_swu_steps.yml
>>> index 74c9217..3cdb793 100644
>>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAV=
A_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#=
architecture#.swu --output /root/cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - dd if=3D/dev/zero
>>> of=3D/root/cip-core-image-security-cip-core-#distribution#-#architectur
>>> e
>>> #.swu bs=3D1M count=3D5 diff --git
>>> a/tests/templates/swupdate_negative_test.yml
>>> b/tests/templates/swupdate_negative_test.yml
>>> index bb79b07..250eaa8 100644
>>> --- a/tests/templates/swupdate_negative_test.yml
>>> +++ b/tests/templates/swupdate_negative_test.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# software update testing
>>>  timeouts:
>>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml
>>> b/tests/templates/swupdate_reboot_without_confirm.yml
>>> index bfad106..074eb1a 100644
>>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # qemu-swtpm.sock will be gone after soft reboot.
>>>  # So the swtpm socket need to be started again for proper reboot  #=20
>>> To start the swtpm daemon, first the existing one should be killed=20
>>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml
>>> b/tests/templates/swupdate_same_uuid_steps.yml
>>> index 3ff2e02..8329055 100644
>>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAV=
A_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#=
architecture#.swu --output /root/cip-core-image-security-cip-core-#distribu=
tion#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - cpio -ivd --directory=3D/root/swu <=20
>>> /root/cip-core-image-security-cip-core-#distribution#-#architecture#.
>>> s wu diff --git a/tests/templates/swupdate_template.yml
>>> b/tests/templates/swupdate_template.yml
>>> index e1f71a9..9a3366b 100644
>>> --- a/tests/templates/swupdate_template.yml
>>> +++ b/tests/templates/swupdate_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# software update testing
>>>  timeouts:
>>>
>>> ---
>>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>>> change-id: 20260316-license-c5fcde3618d2
>>>
>>> Best regards,
>>
>> Thanks for taking care! Here is the list of contributors to these files:
>>
>> Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> Chris Paterson <chris.paterson2@renesas.com> Felix Moessbauer=20
>> <felix.moessbauer@siemens.com> Nobuhiro Iwamatsu=20
>> <nobuhiro1.iwamatsu@toshiba.co.jp>
>> Quirin Gylstorff <quirin.gylstorff@siemens.com> Sai=20
>> <Sai.Sathujoda@toshiba-tsip.com> Sai Sathujoda=20
>> <Sai.Sathujoda@toshiba-tsip.com> Shivanand Kunijadar=20
>> <Shivanand.Kunijadar@toshiba-tsip.com>
>> Srinuvasan A <srinuvasan_a@mentor.com> sai ashrith sathujoda=20
>> <sai.sathujoda@toshiba-tsip.com> sarath P T <Sarath_PT@mentor.com>
>>
>> All worked on behalf of a CIP member. Furthermore, the default license r=
ule from the README applies here:
>>
>> "Unless otherwise stated in the respective file, files in this layer are=
 provided under the MIT license, see COPYING file. Patches (files ending wi=
th .patch) are licensed according to their target project and file, typical=
ly GPLv2."
>>
>> So, I will merge this the next days unless anymore brings forward any co=
ncerns.
>> [Dinesh] yes please.
>>
>> Dinesh, the file list you shared directly with me is fully covered by th=
is?
>>
>> [Dinesh] No, there are few other files such as .wks.in, .cong, .cfg, .in=
c, .tmpl, .list not covered by this patch. I think it's fine to ignore thos=
e files until someone has any concerns.
>>
>=20
> What is the difference of those files to the ones handled above? If we al=
ready make the default licensing rule explicit, why not doing this consiste=
ntly?
> [Dinesh] They are mostly configuration and data files, but I agree with y=
ou to make it consistent across all files.
>                 Can you please proceed to apply current patch and we will=
 send another patch to cover remaining files?
>=20

Let's not just scratch the surface but do it consistently and
sustainably: Which tool did you use to identify our gaps? Can we embed
it into our pipeline?

I just tried "reuse lint", but that gives more complaints than just the
missing headers. E.g., it reveals outdated SPDX identfiers that we still
have in use ("GPL-2.0" and "AGPL-3.0"). If we completely follow the
REUSE spec is to be discussed after sorting the reports.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

