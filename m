Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35711.1792986028611485544
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 20:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fq6Uhymz;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9mwc+B2Rh4v68cdFl4849ZsV+oSvP6s2aLpAjDka/tStPQwlkduyfqhO8uirPiLyvDc4tAnswXHT+JsidsfobUzFOUUV4xielHODcu45z9pXIzDkkMRiQKL58/N79kdva4m/FaX23RPBiGUGadiiOGimf4LEYYEoYvktg7jOYwKUSolPGIN+ov86t2BHqLOQmcw/cCFWN+78RiXvW1+HtPwTUGq0seJhTccoaY3zEeMwmKh9ILEMEPA3Slg1BUinncrDaYzm1E1bYbLnkPVJne7zGOBd1CgtP+EULNblD2uYLNNlYS2271HpPhrnbO5WZZ75Rq95J1STiVObnlMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTnyhz8LwAewbuvRGr1f9QJHw9kUjuL7E2c72wwCE4k=;
 b=oXOYTCzT0IQAxND1LuzCJrRyIWGk8GSMHR2PdKA5xc1uqb1hSskKDhtlsYhH/0CsdpBofq3NCteCKkABcIbLO15Z31fChriXCtWEP+8Ze5qvNsA8wRxlIT20rFh9ySY0zMU+0x3gUHuYnpM56nr1h2Fvtbf2BxD/d3CsvvfLXVuicUsaNPw8EtV8yLqQHpLEMW5KMzfegr+kH4wVG98NU+ic9YS6vibl3N9XmzMV4yDSILIzWgGRyGXJ9wF1CUfcWvAYoseu++SGS+vGD3svQs29q6HRyy9TAZDlFeb4Qt0Odp/0nj3yfA57BI6Xq1fFMkDc/h3kWMv1DBQDDmiWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTnyhz8LwAewbuvRGr1f9QJHw9kUjuL7E2c72wwCE4k=;
 b=fq6UhymzJ9cK8tymtugdCeDebPK2/XKPQGaMg3AIjlmQGxxFS2gMtejlU4M0sQI1lsOVUVpBx6Q+2YroLS12cff5J8ZiIGsjAlGPa9kgYSnWHQobEm2yMDd5J3rCtaDYhAWVByX8fLL1Cbh7nXbzMDt1Q59T+zhh5uoLUFg8zCUscy3nnHBNlg0rxhTIh5E7DdMouM8Na4IWyp6VifCvj2LT8lgiuy2rcEPxt/4q66aaS/PTNUM1Wb80cpCx1WurLRuL5ofAx8aXokyzE5l3OKTOjdNVRLtabzSlpKv/CVAIn71kdhIpLVjOnpy8K7nwz2yp4SPG7bbS85qqAgcCrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5425.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 03:40:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Mon, 26 Oct 2026
 03:40:24 +0000
Message-ID: <19016a76-d057-472e-9593-244ee707b507@siemens.com>
Date: Mon, 26 Oct 2026 11:40:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 00/14] Add recipes for image
 hardening
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 hirotaka.motai@miraclelinux.com, dinesh.kumar@toshiba-tsip.com,
 "Nieddu, Pasquale (SMO RI LCE CZ SEC 2)" <pasquale.nieddu@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c84a61e-e0d9-47d7-669b-08df3312de2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261009220027099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|260925021311599003|260925021911599003|260925022911599003|10067099003|56012099006|3023799007|6133799003|20046099003|18002099003|22082099003|55112099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: kBoYq+XjPxqXL8DgF56cyRr9fgaDbTvuT9nq+qkYN/iwjiuPV1oB6/JgDf0UW9MxnDy2hlf45uww4bWkIMT8uZrXEsqs1q57PB6sbmT9YgIEqKXjfachXZi4drYZvkrzR+0fLBHF/tHh5ej4F62gYtL5FbszCRasSDnprYpXl53jLpfsJ/zQ9a/HPBlOJWWmXXCvibJhPYKK2f3aq7q/YaCvkQ98FZhBwK/0QhW9Ik7mDMtAYpmiHipii8gWY7BX0sredKTwwtLR8iTqqImLurMnmhGUaslqWOlBxhLY7aaKris5djunn4BauyTA9aZgPQbyp4gFztFGIxr/EI1To/4VYiEfHQk9q9biCByQWkPXFMm/Pp54fPRzyGdPXzqU2MqMpQMkL5dC8W9fwojiq/G4qf7d6Mw0+LFrMLL0UtCeZGF5VJBS5mtsRtOKV43Lb7A/0v2AyDDi3YqbCbDTPr1aXSP9YlFrW0uNws1Oi045J3rHgkghJTr7R6LHOG9qCfuYgRSfUHwkUfoOkijOnKKwUIHM1U0ohRKBKxYjbcdz+C43aY/7uLR1syubUIQDGbh1+55dNKQPjLLKN/LR4b2Xi0LUcH3IXokC7RUV35cSJFN+L6fHoVj0AIyJ+ZtA7dilcK7l0sA6L4mDj0U8YUk8HRXpED4L+0yxcadCp38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009220027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(56012099006)(3023799007)(6133799003)(20046099003)(18002099003)(22082099003)(55112099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1MxT1pyTEZtZG9BRDN6ckdBcVpXcjAwM0NnUmRHbHoyNmRrOFJTRXlNbXRO?=
 =?utf-8?B?bVdFTzJMbFZUaHNOVENFb1lrc2IvOEIwNUZqcWFraURaeExvUDRzdE1mbjh5?=
 =?utf-8?B?clAzU2lXZEpwbzkyMEJ4S1AyQ3BsWnBZc2xjQmhObHp3RjVURTVOK2hGT29G?=
 =?utf-8?B?blJtOHpWRWdjYVp1WW1TWGEwL29NOGtCK2ViTjQwTmh6QnVvakxpdjBNK1Fn?=
 =?utf-8?B?NVFnZTdSU09EWDA2R2lXYjh4RGpUTk5DQTNESlVRUFFuTXhqSGpZbHdBSllj?=
 =?utf-8?B?Z21VNjV4Szd0Z0J2Sm5IaWRJeXlLTi9RWjh0Z1MwWXZYRHRVeGxNemhFWmQx?=
 =?utf-8?B?VXNxcWRqa3lDbERSbjExR3VpOWxxdFc3TnVWdmNrbTZNVElkSS9vWWxmMGNQ?=
 =?utf-8?B?YzE1SXZRKzBBVFE0Zm5CVEs1NDM2eVZITURoZDlWZlA2eU40bFBhUmtkOGxm?=
 =?utf-8?B?TlpiRGhXNHFEWmdCMk03U2lidGFYUnZNalY2Qy83TWZGMFhOLzlZUmFPS2xR?=
 =?utf-8?B?SE96S0ZVNExTU3EvaG9hRzNlTE5rMkFlcm9MYy8rWXJuVlh5cFNvYVk5SkZm?=
 =?utf-8?B?MEo2d2tzYXRTVStlMVVqSndiNndrL3ZmWWFHVHVmek5oenBvemhxeVlrbmM2?=
 =?utf-8?B?YkVNMFgwQmtWWFgrQWcwZ2ZleEx2cTRvLzlnU0Fqckl1ay9OL2JDZ3FzQitk?=
 =?utf-8?B?R3lRK2tueC90UVQyT2VBWnlDQ2szays1dFJJNWpqY2g2YkdrV2luSU56dmNs?=
 =?utf-8?B?WVNnV29HcTBkY0JRYTArVXJKZmcxRlpOYkx2YmUzamNobmJkS3lyOU9TbFVo?=
 =?utf-8?B?MUJuNEhvbDhnT08rUXNxVS8xcDVpaGFkRDcxbXJXZGFMRi9KZUtFMFk4OGN4?=
 =?utf-8?B?QnpPWG8zYXdmRWVBMTFCWUpSM2dkUXhjMTJnQUIrTHE2UGJqR2loR0I5dGNB?=
 =?utf-8?B?QlJkNTFZN2FsaVdUbjNuL0Rkb1ZHWW1qTUoyWUh0QktZalJiZmk0VVFRVU9p?=
 =?utf-8?B?TFBsa0p3NTJUcytxN3hxem1HbEE0STE0QnJuSWNTSnpKTmVCY2FGYUJkUXVj?=
 =?utf-8?B?dWVvajl2Y0dwNVJ6N0VFdWtLQXpDMjhiMHZkOElNUENacGxZZ3pTRjlTREZD?=
 =?utf-8?B?Y1dVWHFTOVNEN3d0WUF0SGU3UWFUeXZ3TFVOeTZ1SjR3azRhcStjZFpzUjIy?=
 =?utf-8?B?M0czeXZQbnJiMmF2cFU0cERqdW5nb2hyS2N1N2g0Z29OQlNYLzVuZWc0UG5Q?=
 =?utf-8?B?emNrQkQxMVdMbDB4djhlVE1Mc242TTkxYjRJOHpJODFQa3VrQUtyMXlUOUky?=
 =?utf-8?B?M2htNEFGN3MwNTJmeGdCWktvY0NHNE81VFZWSGd1Ny9IRWNJc0hUY0hyWmdp?=
 =?utf-8?B?SkZpdmxHS0d6UU53SktHakMzWHhuRUNjdlRLTWRFK1dZRXF0Z041VUM5Wjcw?=
 =?utf-8?B?TVE2dGkydG4rMEhldlc3S1hBRWpnMThuT2YwQTlEaXY4ek5PcUQvZmhFVlph?=
 =?utf-8?B?aXNPOGlJRXpiTUthSHhIQ2RWQVRKSEdSVE0xbEoxMU83bVNGUGhJVEJPMzRL?=
 =?utf-8?B?YndtclhNa3BDSEFlZ1NNMlFPRzZuU0RjSGhYZ25vMk5tR29pYU9QRWtRSVJM?=
 =?utf-8?B?dkhWVzdPSThaZTJHNUMwbk9vRVVHakxnQTdtbGtuc2E5YUxMeUR3WGlacXgy?=
 =?utf-8?B?TmEwZXh2aXZuQ21OU3Zqa1B5cGtoem1uTzBQK1pzZFhhb1FhZjU0TGd2RFNv?=
 =?utf-8?B?bytjNmVYdnlYRkYxYTJrZE1jV0ZYYUc5OStmTmczbXRmYVduTHJpV1g0UzdU?=
 =?utf-8?B?OUZRc2pnVWo3aHZqMUtSekc0cDlVelkrdjBaSGhLMDdUYkM3RnpGNFE4U1Vz?=
 =?utf-8?B?QXpod3ZMbmVHNGRlOTR6Z25mbDFvd3U1TnNDYVdzVm50YjBiZG9FamFJS1JC?=
 =?utf-8?B?Tkh2L21xT2thWWx0Y0F3WHM2WUpmMU1sNk4vcFN1cExWWEJQaWlTaS9SWjJ0?=
 =?utf-8?B?ODU3S09oWnNYNGVjeVA4djU0cmJjWko1eUV0b2pibmt0dVYzaDVqREdqNjM3?=
 =?utf-8?B?YlNxRW9VZmplUndWWHpyTURiRGxrTWY4MmJKRG9ScmViMTNrZmNYMDg1bjB0?=
 =?utf-8?B?eFp1WTUwT2ZQeXBlZ3hGVW1HR3pYS3hWSzJVNzFZUUlxbCtWbUdJZW0vUTgr?=
 =?utf-8?B?cE5BU2VBamNwb2Q5K3ZrZWlCNWNtOFBLWDhFc0pIYTEyN2dDWHg3b1hDeXJG?=
 =?utf-8?B?QjN4enFJMGVpV09TVnlFY0dyRlBuc0ViT3lOOXFqQVhBdm1EVXhYNllRcWhr?=
 =?utf-8?B?L3BpR05XbTc2T2E4WHJkdWxZdmJUKy9xQjRDcUQ0KzhoK1JZL0krdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c84a61e-e0d9-47d7-669b-08df3312de2c
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:40:24.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiG+Auu088F2xGPFxsZMRTI5k1/q4VHl4zyPke9ULBSod5NnjbCs092Dm9KOrvxJG1SJjNoJY/bp/6Q5gB26ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5425
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 03:40:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24535

On 26.09.26 02:08, Quirin Gylstorff wrote:
> 
> This patch series adds the option to harden the build image according to
> the guidelines published by CIS. The patch introduces the following packages:
> 
> cip-cis-rules-config: user-facing configuration, stored in .config.json and
> configurable interactively via Kconfig.
> 
> cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
> a custom Debian package containing the necessary hardening configuration.
> 
> cis-validation: an optional package to validate the hardening rules.
> 
> Additionally, the kernel configuration is checked against the hardening rules.
> This patch set is currently developed and tested for hardening level 2.
> 
> Changes v6:
>     - add ci configuration. This adds a ci.config.json which is
>       generated from the default settings except it enables squashfs to
>       allow the ci build
>       Test job:
>       https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/16743214042
> Changes v5:
>     - rebase onto commit 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
> Changes v4:
>  - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
>  - Remove redundant addtask for prepare_build
>  - Switch cis-validation.service Type from oneshot to exec
>  - move validation to kernel recipe to avoid issues with kernel config not
>    being available during rootfs install or validation of a upstream kernel
> 
> Changes v3:
>  - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
>    better task dependency management
>  - remove json schemata validation during menuconfig read to avoid a
>    issue were outdated config cannot be updated.
> 
> Changes v2:
> 
> - rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
> - reorder patches
>   - README is now first to explain architecture
>   - layer.conf before arming
>   - kernel and image are armed together
> - use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip-cis-rules
> - menuconfig now uses devshell to be independent from kas environment
> - generate config.json and kconfig on the fly
> - bugfixes
> - rename cip-cis-validation to cis-validation
> - remove CIP_ prefix from variables
> - rework readme
> 
> Clara Kowalsky (2):
>   Add cis-validation to validate the hardening based on the CIS rules
>   Add kas file for hardening configuration
> 
> Quirin Gylstorff (12):
>   Add doc/README.cis-hardening.md
>   Add cip-cis-rules to apply hardening configuration to the system
>   Add github.com/ovh/debian-cis for the hardening validation
>   layer.conf: use variables to control path of hardening config
>   Add cip-cis-rules-config to configure the hardening according to CIS
>   Apply hardening configuration to the kernel
>   Add class for validating the CIS options in the kernel config
>   Add class cis-hardening for post rootfs generation fixups
>   Integrate cis-hardening into cip-core-image
>   Integrate kernel validation into linux-cip
>   Kconfig: add option to enable CIS hardening
>   gitlab-ci: Add hardening option to build
> 
>  .gitlab-ci.yml                                |    5 +
>  Kconfig                                       |   13 +
>  README.md                                     |    1 +
>  classes-recipe/cis-hardening.bbclass          |   52 +
>  .../cis-kernel-hardening-validation.bbclass   |  260 +++
>  conf/layer.conf                               |    4 +
>  doc/README.cis-hardening.md                   |  283 +++
>  kas/opt/cis-hardening-test.yml                |   17 +
>  kas/opt/cis-hardening.yml                     |   19 +
>  recipes-core/images/cip-core-image.inc        |    3 +
>  recipes-kernel/linux/kernel-hardening.inc     |   18 +
>  recipes-kernel/linux/linux-cip-common.inc     |    1 +
>  .../cip-cis-rules-config.bb                   |  159 ++
>  .../cip-cis-rules-config/files/ci.config.json | 1760 +++++++++++++++++
>  .../cip-cis-rules-config/files/postinst       |   31 +
>  .../cip-cis-rules-config/files/rules.tmpl     |   19 +
>  .../files/scripts/cis-hardening-to-kconfig.py |  350 ++++
>  .../files/scripts/config.schema.json          |  124 ++
>  .../files/scripts/enable-cis-rules.py         |  333 ++++
>  .../files/scripts/gen-kernel-config.py        |  165 ++
>  .../files/scripts/select-hardenings.py        |  616 ++++++
>  .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |   23 +
>  .../cis-hardening/cis-hardening_4.1-6.bb      |   17 +
>  .../cis-validation/cis-validation_1.0.bb      |   52 +
>  .../files/cis-validation.service              |   11 +
>  .../cis-validation/files/cis-validation.tmpl  |   65 +
>  .../files/generate-overrides.py               |  103 +
>  .../cis-validation/files/postinst             |   52 +
>  28 files changed, 4556 insertions(+)
>  create mode 100644 classes-recipe/cis-hardening.bbclass
>  create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
>  create mode 100644 doc/README.cis-hardening.md
>  create mode 100644 kas/opt/cis-hardening-test.yml
>  create mode 100644 kas/opt/cis-hardening.yml
>  create mode 100644 recipes-kernel/linux/kernel-hardening.inc
>  create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
>  create mode 100644 recipes-security/cip-cis-rules-config/files/ci.config.json
>  create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
>  create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-kconfig.py
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
>  create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
>  create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
>  create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
>  create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
>  create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
>  create mode 100644 recipes-security/cis-validation/files/cis-validation.service
>  create mode 100644 recipes-security/cis-validation/files/cis-validation.tmpl
>  create mode 100755 recipes-security/cis-validation/files/generate-overrides.py
>  create mode 100644 recipes-security/cis-validation/files/postinst
> 

Winter is coming, and so will the next release. How can we move forward
with this in order to get the code into that one?

We likely need to make the cis-rules repo an official CIP project first,
right? Dinesh, will such a proposal come from the security WG? Or is
more general discussion needed first?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
