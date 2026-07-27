Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF85C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:25:43 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32187.1785162340399408729
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:25:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m9eKOX7l;
 spf=pass (domain: siemens.com, ip: 40.107.159.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5++Qvb6tSHpTmyvkYUY1upoVazKx1+qweJMSTvwuFJsrF0TcxVVEBX+cFRdghOQH2RXzOTiC8d5vNuYURSESp4QB/3zPw66w9EanJYTvUkHUbDtFXE/WNOOsxvuecDKKWXbhPSDRPZtjfyRfK8PhJFUm2qhFuPUVVcE7gExrwOJMZ1Ei4CQP7XW3XIlXsV/AlP6MNYGOUDL8+/427bnsHs6bSllqaDrATHPmzOrexaRWjgdbyzrz/7M+VKTRcW30KqfF/BXaNGz7/VXrWwvtem8BM98Mm2x1QPt5A8EpmoPuwxqFQfGHgp8o0wE1FpFGUBZTFvOd8NMinXyiBepiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzO6sHBfRaH2OoChXdJ+3PQJCn7Kk2kwAg4OeOapaVQ=;
 b=cD3wbZaR5obz8u/G8ohiSuIs7g5UF84AAYE/4CbCXEoTActjFKmmexUuQCUBgcSgWGRaLedxmeKiJ2KYvEvZp7Xk8XGWxtvq2HIQegkhT2cmCyYF+pvM388GaAABV/wwyc/UzhBK1JmSV5Lq8gFcEvznnqc+icbMAvWZZeZ38USx4bTL8hqpi/j+b4m4/QrV1RUBL+ddhf9pqGOjGJy5ZgPeCxuuLKzCZvF92MvLin3WMxzPeHLGSkSC8rRxAEGXZ6snMafT+V4mkvPRM6Oefbopa1Vir3Qbc/ZCsizeAhKb9cxaD4TH4LJmAGP2y2IIKm6w95iySGt9wvGvWDb5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzO6sHBfRaH2OoChXdJ+3PQJCn7Kk2kwAg4OeOapaVQ=;
 b=m9eKOX7lUFiyNhq87fRO1B/um4ZuRJtVoLn5E8wy2SsTL7q2D81x+t0YH88KYtzc9MVLF2om/mQ1BRS5s9ApPJm1vuCOXPWV4KMcWHz/S0wqNaCzcDvji23APmhgfvMf0x6K4KrA9M4UajyH05Wa56uONqNTw6Pec0VMSzOsWwSaAw0F/su/nSHBwQU0NS9eNszFPUEh5rbeSbdFgYaQ5f4NtrkJjBTMJ3Yst/u4oHWRJ8jD56JNIqSf1vu7vsN+KLLJXr/whiMyLN0zNI+Aenio01oVCtrPqDJ0ZJyA4wMhZewoIgnbSTHgqg8j2f2hYLiioquZofONSgdd/kHotA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:384::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:25:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:25:36 +0000
Message-ID: <b53ea6d0-794f-41fc-9773-41b9e7e76f3d@siemens.com>
Date: Mon, 27 Jul 2026 16:25:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 08/14] Add class for
 validating the CIS options in the kernel config
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-9-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-9-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 07040c9f-4267-4dda-21a8-08deebeaeceb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|20052099010|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	FTMFmCOkX85nEO8729c4eZVXOKy5dhfItfeiGwyRK/zvbWRqskPL+C7nx9lx29ZRpb8e0GkPKcTKp8eIEDR9aRu9TKRxdzypXD1jQmmaSbuCYHghdXTO2yO31wKU/Q3MgGiz7ng5+uIhuFSqrkGiw1Xdth5Fj6LtwkYBZjXrFy4uN0ELuSRXxMGbHd6SbfCtFeXBIsUDnzpSYYmaqekBg3K4U6baaERxO11lLC5tJEcyPtMg6dhKBGsRHvr6v9RDMT2589+CvI+D63EY6ewrJQIn+EWDrsgpAwLKd4O0KyqEwTCDX+Esiyv02JiUzrx5WLiu6lQqIgE9uCz5ClOSNGZgF1CTyZHUZT+Jl6vzIwpDy8xNKY1598QwWpVMloE2MqvZfe0ApibBB69Aqjm7fSqFWI4++zT8dXCQKO9vLB+DdWrIp3oOLD049uCy9VzvmTWmW/JLp7+cAjNe9Ni0G/yl9ZLhdqcottOk4Q4X5ZCePkL7+zD7KCW6+ixTgQVJ4mfjgeLQ5inERaFzfJLOOwZDmg/MQAYfX20mGlq85szskknjX3DWE100ONpLC7JvuZlOkb72eI9LiWO2bMbmn+gRC408pfmtBfB0ggOPWOeEmtEtsZVpCo4zLKTfq2vHVJExx1etsbZtookVGTHs0p65ZgHIomk4tkkL1/0BZoY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(20052099010)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzVGZldMUm1uWGg1ZGJKMWxtRDN4Mms5RWs2TCs4UFNrLzdVeEl6L2dWWExK?=
 =?utf-8?B?REFqWE42YVlLM3I4aDl6NDRKRFA1dzYrK1VLSDBZbXFsd28vc2diNEpqUXBw?=
 =?utf-8?B?Z05qaGJjenB4K1VvbENMUkVQNG1NdVRpNyt3dlhjRTZabU1JTmFCNEVRbHFE?=
 =?utf-8?B?MGphdTdEcUxZUUpZOXo4aGZYZ2xSOTExZ0drcVJnRlM5K3FWcFVRQUp5Wjk2?=
 =?utf-8?B?NFZHOUVOVy9yL041NWdZTTVyRW5QWFZGaDE3SFlIWkZwbm51SFJUUmVQZ0Yw?=
 =?utf-8?B?QjByNy9WUW1waysrand6RFRybWo0SWZUdGF1RlR6S1dsUElHbEdpUGtReVpL?=
 =?utf-8?B?RXVhOEhHbitJbk0rb2JSZ0MzMXV2UElNRmIxZTJVQ0xhK1FCTTJDNjNCM1ZI?=
 =?utf-8?B?aEw4Um05VlArL3hkVWdyd3RCYVU3UzZMT2ZJUEZaVDY0RkJBcjJOMThsWVNv?=
 =?utf-8?B?bW4vK1lvWGxIUDMrYmNYSFFnaUtmbXk4aHprb01FWkN4b1RkUGdyV0w1S2Vk?=
 =?utf-8?B?MGc4SWxib2JuY3AxRXFkMnhBMEV2cG5Vc1R2TnNCa0R6amU1K2lCSHhSVC92?=
 =?utf-8?B?Z1k4U3p3QzZaYXZsenNRWWVqVjNTRXRVbTFiM3YzSUhMTzc5d3NJWEV1d2tz?=
 =?utf-8?B?WGtSeXE0NFcwU3B1MGkzdmN2UW9NR3Zhb09XdVFtMVE1UDJjOURPS1VyYXFB?=
 =?utf-8?B?RGxJcmRLVDJ6OXMwMzEwUXlQZTQyQkpBY0lkYWk4NDRuVGRsQzQvTURBVUh6?=
 =?utf-8?B?THd5dkU5d2ovTFNEdHFYTmcweFFtc1F5R3ZBdzM0VkZtZldUcUlHVkpOVU9L?=
 =?utf-8?B?VzZESVFVcW1wZ21ZUUpzUnpJc1hPMUU5YmdJb0RpMjJVb2MrNUxlckFabmhw?=
 =?utf-8?B?VFRaWURpRmtkbElTMko2VThZbzlIN2J1SFZ5bmlUZVpxWEJpZWNoU2YzUmc4?=
 =?utf-8?B?ajZRWlJiSkdPS1pIaVJnOG9kSFdsVjJJTU0zUzJXcXAwNDZVUW9HUy9zRzhw?=
 =?utf-8?B?cjNPNUFXS1lNck5GKzN2MFl3b2JDOHl1UWh2RGxjM0xrdHdhZnlLK0FTU3Yw?=
 =?utf-8?B?TzdFMFY3SEQ4QTZ2em5VNVNiTmNFdXZxSEN4ckdvK1NVS3M3TXIxdWhNdGR0?=
 =?utf-8?B?b0RrNnl0bXpuVm5ETEtZTXgxTEVaVk9MaU5vakQxUDlkZGp4YnRIS0Z6UnJq?=
 =?utf-8?B?NEJidThsa0tkbG5obVNMRExVVExaN3E2N3o2NisvSTlrTkhCNEViRDVCeDlQ?=
 =?utf-8?B?TWxmQndja2xvRWZQNVQ2WlgrK05rSC9MWTZvdm4rSExnTWQwbzgzTTB6STIy?=
 =?utf-8?B?ckt1OUoyMmRaUTluWG1ia1NCb1huTXJRMjBKME9YbHJ6R2hDZWFPVXRSM3l5?=
 =?utf-8?B?TmJ1NU4zVTQ1SlErOTF1L0NOc3ptamtyeTlpS2M1clZHc3d6L21qQVRPYVh0?=
 =?utf-8?B?c3dYNkFqeVBrT3ZZZU1sc3JDb0pIVEU0YU1aaDV5UEl0NjYyVTh2eWZxQTBv?=
 =?utf-8?B?NlpOZzUyaGdrbFBVbkl2ak16bXNzUmljc2VmTHd4cGNBNUYwdVcwbmJLcE12?=
 =?utf-8?B?cml5Uy9ZY1pIMndiTG90K0FGTEhuWElhOURlMlFyTExBNS9KWHVCR0R4aTF2?=
 =?utf-8?B?RGl4bWlYYXhuTHdGVUNJTEUrcytaaGFRTCtyMHhuckh3cUg3SUUzbDh6ZFgw?=
 =?utf-8?B?My9BZkJ2VVFsMlZWNEVyTi83QkFLWVhFaGREQkp4cENmalI5Z21EeFp0bkNJ?=
 =?utf-8?B?ZVV3SU1IWnVHVnc4SHNQZDRGYUVpeUFVVEprcHJ4S2FaVUo2VGs4UDVFRm1T?=
 =?utf-8?B?NElUMFZDVE1YQkZiWlhzK2hvbHJENVU4WkFGdjJZZkU2ZDZ4Z3BoWk0zYnNZ?=
 =?utf-8?B?WThzSlN4eDV0aXA0dVFLcTc3US9sS1pmMlZjd1FlMnhOL2hsUDN2cTlNdUtN?=
 =?utf-8?B?U1RNTGpYWDhLcEk4WkFhUE5QcnNEb3ZNU0ZkNExYL0ZFa2RicVlXRExTNzFM?=
 =?utf-8?B?UkZWYmhidkNXQnFCKzZuMGkrN0M0MnZzWDQxM0lSeUVVT2NyUzFhWGp3UnQ3?=
 =?utf-8?B?NXdqdXVjaEI2cmVydFNsZVJiRmxMRTE5Mks3czM2WmZkNjZsZCtwc0l5ejZ0?=
 =?utf-8?B?aVFkbVU3SGxWTldCc01RYllQTlVvQzFnUmg2Z2piejhMajFYZmJQWUs2UnFj?=
 =?utf-8?B?L29FTythQTdscU1kK24rQXJBSjVUQkNiTjZuQkc2VEttYTkzVDc0VWkzM3or?=
 =?utf-8?B?UzVEY0hGM1VlT3hneERrdlJZY2pJYkI1KzVaMi9LNU5CRUoxbm9taFAxODJU?=
 =?utf-8?B?b3NycStHUTBWYUVHUFk0andsRHJPcHd2SkJjQXltek9KMjlpNzVPUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07040c9f-4267-4dda-21a8-08deebeaeceb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:25:36.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egVWwZx4mTu3IP8jnPTEGQg2OBUvB+knpDfMvV3+VRv/ErwkppE2VZTBpLP0VRkzhMP+hOYPx+gOMCTlmITa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:25:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23776

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If CIS hardening options have been configured that change the
> kernel configuration, this class checks whether the correct options
> are selected in the resulting kernel configuration in ROOTFSDIR.

And what if the rootfs was minimized, got that normally useless file
removed? Can't we validate an actually built kernel against its
effective config and then carry this validation report forward to the
installed one, maybe linking kernel binary and report with a hash?

Jan

> A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
> the CIS rules for the kernel options were correctly applied
> (compliant: true/false).
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../cis-kernel-hardening-validation.bbclass   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
> 
> diff --git a/classes-recipe/cis-kernel-hardening-validation.bbclass b/classes-recipe/cis-kernel-hardening-validation.bbclass
> new file mode 100644
> index 0000000..184da7f
> --- /dev/null
> +++ b/classes-recipe/cis-kernel-hardening-validation.bbclass
> @@ -0,0 +1,110 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# If CIS hardening options have been configured that change the
> +# kernel configuration, this class checks whether the correct options
> +# are selected in the resulting kernel configuration in ROOTFSDIR.
> +# A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
> +# the CIS rules for the kernel options were correctly applied
> +# (compliant: true/false).
> +#
> +CIP_CIS_HARDENING_REPORT ??= "${DISTRO}-hardening-kernel-report.json"
> +
> +DEPLOYDIR_HARDENING = "${WORKDIR}/deploy-hardening"
> +SSTATETASKS += "do_validate_kernel_config"
> +
> +do_validate_kernel_config[cleandirs] += "${DEPLOYDIR_HARDENING}"
> +do_validate_kernel_config[sstate-inputdirs] = "${DEPLOYDIR_HARDENING}"
> +do_validate_kernel_config[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
> +do_validate_kernel_config[depends] += "cip-cis-rules-config:do_deploy_hardening"
> +python do_validate_kernel_config() {
> +    import os
> +    import json
> +    import re
> +
> +    deploy_dir_stage = d.getVar('DEPLOYDIR_HARDENING')
> +    deploy_dir_image = d.getVar('DEPLOY_DIR_IMAGE')
> +    boot_dir = os.path.join(d.getVar('ROOTFSDIR'), "boot")
> +    kernel_config_path = None
> +
> +    if os.path.isdir(boot_dir):
> +        for f in os.listdir(boot_dir):
> +            if f.startswith("config-") and os.path.isfile(os.path.join(boot_dir, f)):
> +                kernel_config_path = os.path.join(boot_dir, f)
> +                break
> +
> +    if not kernel_config_path:
> +        return
> +
> +    hardening_config_path = os.path.join(deploy_dir_image, d.getVar('CIP_CIS_HARDENING_KCONFIG'))
> +    if not os.path.isfile(hardening_config_path):
> +        return
> +
> +    report = os.path.join(deploy_dir_stage, d.getVar('CIP_CIS_HARDENING_REPORT'))
> +
> +    kernel_options = {}
> +    with open(kernel_config_path, 'r') as f_kernel:
> +        for line in f_kernel:
> +            match = re.match(r"^(CONFIG_[A-Za-z0-9_]+)=(y|m)$", line.strip())
> +            if match:
> +                kernel_options[match.group(1)] = match.group(2)
> +
> +    report_rules = []
> +    with open(hardening_config_path, 'r') as f_hardening:
> +        hardening_lines = f_hardening.readlines()
> +
> +    i = 0
> +    while i < len(hardening_lines):
> +        line = hardening_lines[i].strip()
> +        cis_match = re.match(r"^# CIS ([0-9.]+): (.*)$", line)
> +        if cis_match:
> +            cis_number = cis_match.group(1)
> +            description = cis_match.group(2)
> +            config_option = None
> +
> +            if i + 1 < len(hardening_lines):
> +                next_line = hardening_lines[i+1].strip()
> +                config_option_match = re.match(r"^# (CONFIG_[A-Za-z0-9_]*) is not set$", next_line)
> +                if config_option_match:
> +                    config_option = config_option_match.group(1)
> +                    i += 1
> +
> +            is_compliant = not (config_option and kernel_options.get(config_option) in ['y', 'm'])
> +
> +            report_rules.append({
> +                "rule": {
> +                    "name": cis_number,
> +                    "description": description,
> +                    "compliant": is_compliant
> +                }
> +            })
> +        i += 1
> +
> +    if not report_rules:
> +        return
> +
> +    with open(report, 'w') as f:
> +        json.dump({"rules": report_rules}, f, indent=2)
> +
> +    non_compliant = [r["rule"]["name"] for r in report_rules if not r["rule"]["compliant"]]
> +    if non_compliant:
> +        bb.fatal(
> +            "CIS kernel hardening validation failed. The following CIS rules "
> +            "have kernel options enabled that should be disabled: %s. "
> +            "Details in %s." % (", ".join(non_compliant), report)
> +        )
> +}
> +
> +python do_validate_kernel_config_setscene () {
> +    sstate_setscene(d)
> +}
> +addtask validate_kernel_config_setscene
> +
> +addtask validate_kernel_config before do_rootfs_finalize after do_rootfs_postprocess


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

