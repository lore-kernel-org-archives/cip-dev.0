Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F098BC77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 11:35:01 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.44])
 by mx.groups.io with SMTP id smtpd.web11.85862.1684150494519793587
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 04:34:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LdhoAPrY;
 spf=pass (domain: siemens.com, ip: 40.107.8.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4N5h1YiQvw5M09Slt9JUoCwdaoqI8agFrpIHa3viFhtt2WFL8SlWkgHqolN/VwGwAbACp31A7Eg3DWn463EFMCehWFQG9cFbQpmYqLC/Z5J5olZOZNb70uavEuLQnl4GhqW+XzEWL5dXZJvO5JgaM0z/xvZKFyTwzcbRpA5hIS4BIO4QWzW3rFmEB7HsXibg7DEF8M8HE0qcFXNA7J2wteCRVi0TH1dRzJQTMdGih/lx+8jFjWI+6gkG0zHAWr3OEVFWTi2o8MMiK1g/qEoP044Q6jEgYCqQHFh7vmfwvhRlK+QL2yZLKDMu/nfyqiP5A7O6xUEDO6cv3vxShhRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=057mbyCSNryD6BZdXj0zZyz+lvJGZer2zg+kOikm6fY=;
 b=jqjOYXAL7UEtksFgtZKE3GW6bYjfYjwyZRYk5BofqQu4dhNnJ/qAHTFcGtLo3EV8JN2thnoniND7FpONCn3fMAs0O0uYxIDisXxxa6csCN6cefQNPJrlcZW8Tk/q/DZ5GojwMq5EeLnLe2VTR1i2cQV6cc/dRGiAIeQwylahflTqEjzJ728zwUpQUH2lRknSmyI8+Bcp69y9DL9o4ZnYjmRjIkfMftIqE2wQeYJnf9iKiI/xoFCIQyofhZ9GXAyvDPZfb3wAqi/uMzUTx9wyIMLTjcBMD6E7q8HpMnhTP6sX8mqo0Jul+BCdokv3p6mPTrbm4Qzp/JhnaBvzRgpINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=057mbyCSNryD6BZdXj0zZyz+lvJGZer2zg+kOikm6fY=;
 b=LdhoAPrYmsSjx42VqAwn8ymAfT1LLMQqWDYc1OCtMu4rFtEZ+JHJhCaprHoIuxzCywKxYayOD46fEQeXKsgGEf1PG1lkf7MUZTmQfcgOnfBUM4ScJsVIEBe7RTJ223/uytT4PEcHncnjTbhbHos1D5hNIRmuUWDjchLTtozN6FT1F2dW3YOnvPcQ3Sdkl4xc9Ldy8vDq0O0Aus+1IJ17NbcTcn/3gCaYisK3RZrACrl/tmJxd8IMoPhQy52vjj83EY7+1w/YbmUfu7/GoZfOq0N/N894uiToGTqSrWT8diqYHq+sTtvS1j6ICG6tU8bKG8u+HbaNxNsnrNawO35PwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:34:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 11:34:51 +0000
Message-ID: <ae1221ba-9856-49ae-8991-2b47a50eb640@siemens.com>
Date: Mon, 15 May 2023 13:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [isar-cip-core][PATCH v2] recipes-python/shtab: Update shelltab
 to latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <d931f5de-fc4c-c26f-5ada-fdee1607c5ca@siemens.com>
 <20230515112416.754793-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230515112416.754793-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a483b15-96b5-4eb1-f58a-08db5538656c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0yO4nkqfi7n5uuK5JTflXhqHlxnN94QDpBh51a6DH3lCW/7ELy/TPWHuFX4ZI4vQiXFCRaL16xGECDBzgXF3E+TLnaS1sgUlpcNMscPec8vexoJBxX2ZYLSwMGEffXS+p4I4xuM/B3xwPBjz5kr3mqKYfcWhzt5ZaDG6fNn79FJQyxwOa0qsPyxnGRdIVN+syYlOLn4JI2sTU1lRQZSsDcG4t/nrV8Trmexs4lon36zTHGFrs51YkrlpC3bwRtdFfHsHONAoPOoEaCdWXmWdPSIqrk/Y7dbE81vgmqN/mGvVTWJyQRzgUKKc5epMj9cOX3t5rCAs07chBtihzn8ohWqYykHKRv3DI5q0zxOVhuPZSPG+7V2a+N7IsRyUHZE6D6gFhuP91mA4H6T5R4iSql6xmKB1X4foPT7gvNAuLNJzAeL/W6L/aLX81HOT17SSfL+H5ITKm+8tseYFhd/DRD9/Q2uoTv02bU+ZIPFp1EcNf1z0lUh+GuDdB3B7mabI3eYylhbO7XHr8Q5Jn0OHhw+JZzQKUZT/MiB3sh+83oxjis6uEpt4IJ+2F5C9s45vTNMVnydX99aJIfRBao8/tgx0X2Q/ZoMwdFVYcnBT7+JWmzg7Ia3+7TCThBAtyxmO6nbor7s6S5Gjacy7hfasxQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(36756003)(86362001)(316002)(66556008)(66946007)(66476007)(4326008)(966005)(478600001)(6486002)(15650500001)(5660300002)(8676002)(8936002)(6666004)(2906002)(44832011)(38100700002)(31696002)(82960400001)(41300700001)(6512007)(2616005)(186003)(53546011)(107886003)(26005)(6506007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1J1bzVCcU1SL1FtUkprd1FGN3UwREx2U3VqV0xRSkhzSCtVbGxxNElVSXdl?=
 =?utf-8?B?V2szOFpwVzAyZ0N4SnJCYVljT2xja2huVWxLL0YyNnQ3VHFuRGhpUEl5QnVT?=
 =?utf-8?B?SlRUMUtVU05GWDRJbkJYcGgrM1d3LzU3ZFV3K0Z6c0F6R1FRVm1ya0cxMGdR?=
 =?utf-8?B?T0wrR1Z3RUhxeFplOHNjUFRHVU95eTFaR2JFcmxxM082MURPWlVmMGV0ajY0?=
 =?utf-8?B?VE96VTRwQ2NmdTg0M3B2cmI5citEREVTblNKU1pmMFhleHdDNGF6RGx3aFBr?=
 =?utf-8?B?M2ZaK1FubEZxODRmZkUvTTdjRmJyazNyRnlKVWoySEpuWDNzcFRkdk9ZdWRT?=
 =?utf-8?B?RFNpSXg0Y1VyOUpOek1FaytJZWNxRjdwR2pIeis2TXczNlJWa05XQ0JCdjFM?=
 =?utf-8?B?eTZUK1JPMGFCRXV6M1owckUvWFdSZzUxbHY2dTA4dDRKK2V5T281VzJmTUJ6?=
 =?utf-8?B?VG1tazhiT3JUV3JmRXNZVHlpTW9OaTQ0UUM3R1h5ZXJ2WlZRVVJES0pPbnpM?=
 =?utf-8?B?RHJYTjh5WkluM0ZHS05QWlJUaE5XMHhlSExCaFBlNlVtYUdiaHFOcC9MeGZl?=
 =?utf-8?B?T3BGSDgwNWRsbGs3UWRDdWhGQ0VubzlyZlkvSWFlb0JSQ3F1SDFtRUpyVXo1?=
 =?utf-8?B?VUVseHlGYzltbXF5aEdXZ2poRXpjSEdFZ1M3dDFRdnhLMjlubkE2MFlVazJ2?=
 =?utf-8?B?cXpTTHlPdzVmODB1NCtldzRKYXlaY094bisrSFQ3WVhQeGRseVpjRCt3Qk81?=
 =?utf-8?B?eFBoTDRJMklUUVZEc3ZQMUErT0FhamQ0ZndHRHY4Y3c2eERzdzVsRk5mV1Nw?=
 =?utf-8?B?UnBwSklySmV0T1VwUXpReUthMnhtV0d6K3IwV3dXOUNjVEkrS01zdit2L2p0?=
 =?utf-8?B?VnFBQ0hoMWQxZUtXcys4VVh4L2IzdjZuZW41bzAzZmk3dFNBNmtVVStuSEhH?=
 =?utf-8?B?amJBLysxRG40WWZleExWZURCT2FRa0x6SUFYZWhPK0pPVmNSQWFMU3pna053?=
 =?utf-8?B?alV5MkV6dERrbEZSeVNBNEVUclRySU1vcEt5NnRrcm5MNFAvNGd0MjNLQTlB?=
 =?utf-8?B?bU4wZHd3WW1mTEFLYnd1YldZenBRS1ptZUJNZWRuVnR5NXFJbUh5VkppbTdD?=
 =?utf-8?B?NWlrTHRGR1JEU3MyN2JLL1dSYS9haTZ5aEpkVzk4NmV5Qm5KWkIyL0pNVUFj?=
 =?utf-8?B?Tmt0NDBHNDNmZGZRcENUNGhUWlVMem1BQkhqWkRUWXJqdlZKYisxSTVPRDlD?=
 =?utf-8?B?RjZOd1BMRHUxeVZQOW1teVBVVEtiZGJVNjgyNUE3cDBzUWk5Z2d4elU2WU52?=
 =?utf-8?B?SUpLVmZQMkVXbmlFZWdVNlhsU0lwcUdOU2RYaG9tN2JSZjk0U084Ylkrb29F?=
 =?utf-8?B?WGtJc015YTJZclpPS0IxM2lmdVN0bWMyMERkR2ZmaExiREdDczJkRjlLZzBV?=
 =?utf-8?B?UWRkQWFJcDQyQnYzdGRlQU1BS0JZRVRISlRSaW9JbmZXQXhtRWEyNzJkTGVN?=
 =?utf-8?B?U3BPQzgwQllpVzVvZzlkNEpYalpCNCs5YzZZa2pJRmhTa2FzbDU5VklqSkxL?=
 =?utf-8?B?c2d5aTNDNCtHS2F1YndDRlFNU3VDOXdpWDRvZi9wZU0yenppS0hNNTlvRkFt?=
 =?utf-8?B?ZmxLRy9vZkJqY0lSNjg1b21TdWE2aDdVNFNRZERxTlV2RVc2NjBhYnQwaHEx?=
 =?utf-8?B?bFFHblBqZ0FRcURmY3RkS3p3SXVUbEZxRm1vbURScGo5RUpMZFI3c2hidTZk?=
 =?utf-8?B?WnBrZTRhbFFQMTBsYWFSUFE0ZEc5TEd5S2pBWnE2dGh0V1BLTGVQVzlNY3dT?=
 =?utf-8?B?WGJuYVhicWZpY2szeHF5NENYQ2dJN004VWNxQ1FiUlBBN3VqWTdiQUZOMEQy?=
 =?utf-8?B?OGpiMnFCZ2JwdVdyU2lWR2tXR3pGRFdhOWZoRnQrblNsMVkvTEEyZDhORUh5?=
 =?utf-8?B?Zm9BSDJXTk05MjhwbHJXTDNMeTlFb2xOR3crNldrampuRHdWbEI2Y1VjMXFv?=
 =?utf-8?B?aml3RFhSZjl1aUNaMjFHV2VEaDBkU0xUWEc3U3NhUDcxT2FtNzJkMFZRRm0x?=
 =?utf-8?B?dHNybWJwUXgzU05hNnRlN3BCcElPTWsvNi9xM0ZCVGN2K09JeFlmbXRnQzBs?=
 =?utf-8?B?VTZOWXNrTEhGMEFOaTNSMUtkMDZtSE1IVFNhSlhabk5ibmtCZkF3THFmTnZP?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a483b15-96b5-4eb1-f58a-08db5538656c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:34:51.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Y87iNBAlO8E4328TuKi816qfuDtPqK5bLhkP5Wslk277OJC7OBJzpFM//WSByKBpbRkzkMb7H/ES+iQ0upVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8004
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 11:35:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11452

On 15.05.23 13:24, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update shelltab to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...001-Lower-requirements-on-setuptools.patch | 46 +++++++++++--------
>  ...002-Lower-requirements-on-setuptools.patch | 44 ++++++++++++++++++

Why do we have two, identically named patches now when both are only
targeting buster? Either make clear in their subjects where they differ
or fold both together.

Jan

>  recipes-python/shtab/files/rules              | 21 ---------
>  recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------------
>  recipes-python/shtab/python3-shtab_1.5.5-3.bb | 29 ++++++++++++
>  5 files changed, 99 insertions(+), 77 deletions(-)
>  create mode 100644 recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
>  delete mode 100755 recipes-python/shtab/files/rules
>  delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
>  create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-3.bb
> 
> diff --git a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> index dccc2dd..07c83c5 100644
> --- a/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> +++ b/recipes-python/shtab/files/0001-Lower-requirements-on-setuptools.patch
> @@ -1,28 +1,34 @@
> -From d347695c4b173c94c4d8a678a67947de3ee5f186 Mon Sep 17 00:00:00 2001
> -From: Jan Kiszka <jan.kiszka@siemens.com>
> -Date: Mon, 14 Mar 2022 08:17:00 +0100
> +From 0fdef77abad09ad4e1ee35abd390dacdcabf9efc Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan.a@siemens.com>
> +Date: Mon, 15 May 2023 16:35:43 +0530
>  Subject: [PATCH] Lower requirements on setuptools
>  
> -Allows to build against Debian buster.
> +Allows to build against Debian buster and fix cross build issues.
>  
> -Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>  ---
> - setup.cfg | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> + debian/control | 6 ++----
> + 1 file changed, 2 insertions(+), 4 deletions(-)
>  
> -diff --git a/setup.cfg b/setup.cfg
> -index 55eecd4..186aad6 100644
> ---- a/setup.cfg
> -+++ b/setup.cfg
> -@@ -66,7 +66,7 @@ classifiers=
> -     Topic :: Terminals
> -     Topic :: Utilities
> - [options]
> --setup_requires=setuptools>=42; setuptools_scm[toml]>=3.4
> -+setup_requires=setuptools>=40; setuptools_scm>=3.2
> - install_requires=
> -     argparse; python_version < "2.7" or ("3.0" <= python_version and python_version < "3.2")
> - python_requires= >=2.7, !=3.0.*, !=3.1.*
> +diff --git a/debian/control b/debian/control
> +index a63e366..3d24b41 100644
> +--- a/debian/control
> ++++ b/debian/control
> +@@ -5,12 +5,10 @@ Maintainer: Debian Python Team <team+python@tracker.debian.org>
> + Uploaders: Felix Moessbauer <felix.moessbauer@siemens.com>
> + Build-Depends: debhelper-compat (= 13),
> +  dh-python,
> +- python3-setuptools (>=42),
> +- python3-setuptools-scm:native (>=3.4),
> +  libpython3-all-dev (>=3.2),
> ++ python3-setuptools (>=40),
> ++ python3-setuptools-scm:native (>=3.2),
> +  python3-all-dev:any (>=3.2),
> +- python3-wheel:native,
> +- python3-toml:native,
> +  python3-pytest <!nocheck>,
> +  python3-pytest-cov <!nocheck>,
> +  python3-pytest-timeout <!nocheck>,
>  -- 
>  2.34.1
>  
> diff --git a/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
> new file mode 100644
> index 0000000..5f048e0
> --- /dev/null
> +++ b/recipes-python/shtab/files/0002-Lower-requirements-on-setuptools.patch
> @@ -0,0 +1,44 @@
> +From 62c6019bb5bf724cc92f9f1c1fee378e325d3162 Mon Sep 17 00:00:00 2001
> +From: Srinuvasan A <srinuvasan.a@siemens.com>
> +Date: Mon, 15 May 2023 16:29:00 +0530
> +Subject: [PATCH] Lower requirements on setuptools
> +
> +Allows to build against Debian buster.
> +
> +Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> +---
> + .../0001-Lower-requirements-on-setuptools.diff      | 13 +++++++++++++
> + debian/patches/series                               |  1 +
> + 2 files changed, 14 insertions(+)
> + create mode 100644 debian/patches/0001-Lower-requirements-on-setuptools.diff
> + create mode 100644 debian/patches/series
> +
> +diff --git a/debian/patches/0001-Lower-requirements-on-setuptools.diff b/debian/patches/0001-Lower-requirements-on-setuptools.diff
> +new file mode 100644
> +index 0000000..257c054
> +--- /dev/null
> ++++ b/debian/patches/0001-Lower-requirements-on-setuptools.diff
> +@@ -0,0 +1,13 @@
> ++diff --git a/setup.cfg b/setup.cfg
> ++index 77976c4..8857d32 100644
> ++--- a/setup.cfg
> +++++ b/setup.cfg
> ++@@ -65,7 +65,7 @@ classifiers =
> ++ 	Topic :: Utilities
> ++ 
> ++ [options]
> ++-setup_requires = setuptools>=42; wheel; setuptools_scm[toml]>=3.4
> +++setup_requires = setuptools>=40; setuptools_scm>=3.2
> ++ install_requires = 
> ++ 	argparse; "3.0" <= python_version and python_version < "3.2"
> ++ python_requires = >=3.2
> +diff --git a/debian/patches/series b/debian/patches/series
> +new file mode 100644
> +index 0000000..804951a
> +--- /dev/null
> ++++ b/debian/patches/series
> +@@ -0,0 +1 @@
> ++0001-Lower-requirements-on-setuptools.diff
> +-- 
> +2.34.1
> +
> diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/rules
> deleted file mode 100755
> index 2dd07b2..0000000
> --- a/recipes-python/shtab/files/rules
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -#!/usr/bin/make -f
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Felix Moessbauer <felix.moessbauer@siemens.com>
> -#
> -# This file is subject to the terms and conditions of the MIT License.
> -# See COPYING.MIT file in the top-level directory.
> -#
> -
> -export DH_VERBOSE=1
> -export PYBUILD_VERBOSE=1
> -export PYBUILD_NAME=shtab
> -
> -ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
> -export PYBUILD_DISABLE=test
> -endif
> -
> -%:
> -	dh $@ --with python3 --buildsystem=pybuild
> diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
> deleted file mode 100644
> index d03e694..0000000
> --- a/recipes-python/shtab/python3-shtab_1.4.2.bb
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2022
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit dpkg
> -
> -SRC_URI = " \
> -    https://github.com/iterative/shtab/archive/refs/tags/v1.4.2.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
> -    file://0001-Lower-requirements-on-setuptools.patch \
> -    file://rules \
> -    "
> -SRC_URI[sha256sum] = "5e6ef745c223ef1a01a2db491a8ec5c02c8291067328b17695c9a44f5b7d6fe6"
> -
> -S = "${WORKDIR}/shtab-${PV}"
> -
> -DEBIAN_BUILD_DEPENDS = " \
> -    dh-python, \
> -    libpython3-all-dev, \
> -    python3-all-dev:any, \
> -    python3-setuptools, \
> -    python3-setuptools-scm:native, \
> -    "
> -
> -DEB_BUILD_PROFILES = "nocheck"
> -
> -do_prepare_build[cleandirs] += "${S}/debian"
> -do_prepare_build() {
> -    deb_debianize
> -}
> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-3.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> new file mode 100644
> index 0000000..d3e958c
> --- /dev/null
> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> @@ -0,0 +1,29 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2022-2023
> +#
> +# Authors:
> +# Jan Kiszka <jan.kiszka@...>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-gbp
> +
> +SRC_URI += " \
> + git://salsa.debian.org/python-team/packages/python-shtab.git;protocol=https;branch=main \
> + "
> +
> +# modify for debian buster build
> +SRC_URI:append:buster = " \
> + file://0001-Lower-requirements-on-setuptools.patch \
> + file://0002-Lower-requirements-on-setuptools.patch"
> +
> +SRCREV ="5650535ae4a1d34a21b55dc61e3e891d87a9712f"
> +
> +# We don't have pristine-tar in this tree hence use this option
> +GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
> +
> +DEB_BUILD_PROFILES = "nocheck"
> +DEB_BUILD_OPTIONS = "nocheck"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


