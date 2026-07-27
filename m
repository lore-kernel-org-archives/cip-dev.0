Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D9C531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:21:53 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32089.1785162106415381299
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:21:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=odVXBOHy;
 spf=pass (domain: siemens.com, ip: 40.107.159.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RByXduvr7SAOmLtRqaIIdSVb4sRbYUabb+JtMFpl3ZzDdWjJxEpz0bNRwcKxV/BgSR3oKVE9sxKaC0KG5XETTXdY9g1TDRslnbaL7xyWC2emDEm9Oq5FvXmT8w76nXe/D+vvCYTwC4jGOozMsoZ1VRo3BdmfUEZvYW9y9x3UuDlEp/TAqZxlB4Up+zHi4u7/IKF54Ih3h/P/jaXioSnOak+tjAvwvYNICwlxAZclTAweNxuhgw9tLoRDOqYQYSgU9z38odDd73ZTTLPDcDEz9+xeNFSIiiq+mqR5S8dXx3brp6BxmEHW4+y/JDxccDmPsDVpKSEitMPJF0DFmfDOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pedPv5wUk9vLk+hBSnmdG8bbc6+5IVwGplj94h9c0RQ=;
 b=tTJOHP4Use+6BDtG/Gwd1xpKPIicasIUHR70TVzqeziycSqj0MA3HyzP6+uFEX3gK3rF68Qfle5glod3ibCgPRlqQQM5bn1ZFTEwZLM29ikGLqReJvBeTSvCdpgLZXGwBAClk7x1+rZ4FRrDXlveoFc7OriQ3/kWDN2jZkvAPN+uvcX3Xf1f0p04533VaNc4KEYXeh/b3jP8pnE30vJnCEiBZWYplm/72v2NxQJnbR9eAVdLKKMujplzOIcYAfeQCsR/XAEVAAElg0SOi+JPz8wfOkzXa16bFdRcLUISMJ7amZyVWp0VdjsZ+lGpxDcnbg1vbRMwvitO1ydn9I7PxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pedPv5wUk9vLk+hBSnmdG8bbc6+5IVwGplj94h9c0RQ=;
 b=odVXBOHygpbqllafMnGXrpMVpcSNGU3n8+6AQA1QE+YN6BhgK6vA5D0bqT5hVBm0K5pDay2xpuTmFTyDdZqAcYQEsGlYxakUNOUagdwsU5H3g7/CLh6ZqM8AwkfOxlLfPgyCekpclqK2arr1+Vbe8wnDDbXvuXDfqjv8vd1C/3fImhO472Zzttr0n/tmilcSJTn/tfQ7vDQz4fokYn5HLsddbQLcmazglLsPSw8SlGBNqWMRud1ZW652TBAghd07RNkzuFK+nci/jeEN4PaKyGFTkkL3yoZaLQKB+B7f6haYoQ9mTzkbEpmwWKIaxM5N3X5HgnzgieRtTp3HsWk/jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:21:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:21:42 +0000
Message-ID: <db84a10c-e0ef-4ae3-820a-3bb5198b263f@siemens.com>
Date: Mon, 27 Jul 2026 16:21:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 06/14] Apply hardening
 configuration to the kernel
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b03c3b-a571-4b7e-be1b-08deebea6189
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|4143699003|11063799006|55112099003|10067099003|18002099003|56012099006|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	iG/G+D1VwIX3S3MPTf4lFdAp7ISRkK2uzvxuQBdUw0tfD0FmxbL9qJJ6rg5SxI3lL59TNvK/rCbteSpxth9cNmsCSpEVHW9Cp3i7/6sEGTSKlXyWq2uUAYo0qTHHpMzhlSlcT9FCIhsdMPW9RM01QhjmPn6iz7KICt0wRYFwZ1YnByLMykYTBmwkMUmW8vKSi+RBlMvUHwXhLTa3fqNVjdANc32RcJk1ofqsYGRQomwdLXIDDdZqyvVV3RBokbrBZXAHmmBZyHZCoX8c0XYK+2Wntdl2FfVqZ+ggF73ErhsKSZuklLKhF94KrBD59hbswJXBd6mIFPysz5kcbMQNWoYfneujKenKms1VF37YP0HtnP2Goph/My9jNlMsT6O8NMBOM3XacY3qfJlb8j4yuzH5JHnx9FzUAF9IUIG9fygsyt7sTEwy2SbRoOKwk03KRzkottQhdMp2BfcpbI1tj5ktyhh8/63VXxLNLgINN16tD0zFNv1jSru34j1YpYSzcnmRXxTsdDPXrfhfUscbs7aD11ep7NhObN3VR1stnzWDTGRSUORIIV6kLq31yPHbO3e9czS+WT9sH+2y3fYuRSbJ/UjUrxvRw7miHZgJ121sVHpUdB+hWw7hZn3EpydIBHYQN8NmF7Cg9csqzJNVIDUADTjuzhmWrujfNR0IRGs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(4143699003)(11063799006)(55112099003)(10067099003)(18002099003)(56012099006)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2dmU2loWlVmVnN0TDYxRDlIVi9iaFZxTTJZZWYvVmtSQWhqbWd3bjcyaXM3?=
 =?utf-8?B?aDJ3M3JrYnFiNjVpeU8zR0xUdndWdjZLRWdONngvUjUyTkozdXNDMGVrWUcy?=
 =?utf-8?B?bndJMHorTHVNVlhQV1VLbzR6ZitFaGZJU09KUHFFOVM0MzJ1RU9mZkpiRnRD?=
 =?utf-8?B?cThnUCtPdHJ0VnZLNWpxc29YeVd2V09uM3FHeWQ0bTY2My80Rk1YQ2l5MnZD?=
 =?utf-8?B?bzRNWG5LVndLdXRTaEpWbGp0MmswR0RyMzdnSHRvVVFGMER1R1ZGMG5ieXdM?=
 =?utf-8?B?SlRQNTF3alJiZk1lQ1M1SmlqM0tvamhZTHZ4N2hDd1RhUzJRUXJmM1VFbmZu?=
 =?utf-8?B?Sko5RTJ2SnQ2Y3NPWmhMcTVDTDVCTC9Ubk9UQ3k2c2xuZUxpMS8raTZ2VVFp?=
 =?utf-8?B?RlNsR0lmQzFsczV3Sk9nWnIwV0RjNlhjMFJtMVZDRjU0K2VEUmc3M3NDTTBa?=
 =?utf-8?B?SVN0TFdsQ1pzR0dvbXBxckw5UkVidS9pMDFURzlJTUtYZG9hSGdKR3V6V2hB?=
 =?utf-8?B?ZGZib3hGd0VnZ1VZSEI1TC9BL0dqUzl3d3N4QldyNWZHLzNYV1JMZjBIL2or?=
 =?utf-8?B?QVdKQzZ1aE55bTJlVmQxbkhtUVlTYVQwYmc3SGtZa0VFVmgxcmxuZjhQWWZF?=
 =?utf-8?B?dWZRZG54ZTV3QVVoZjJuc1hPbFZIQWsvYWFLSU44cjlDMEY4clc4ajVidkR2?=
 =?utf-8?B?bkFGcnRnSUZVbW1yY1RaZHFzSW5XeUdoQ0I0UWZPUGZ5TkI0SFdqZzAyb1RV?=
 =?utf-8?B?MnNyNS92Y2pTR2J2QkhvQjZ0V0I1R3FoT3BPZERPRG9JcjNGT21rUDdLVjBZ?=
 =?utf-8?B?bnJod1NPTWVsdUMwaGFxOVFjM2pyRVdBOEN5SWszTVgvL1piQnpwRjRXUU9n?=
 =?utf-8?B?aGtxSG1jN3AvaTVkYnZPK1NmWWlsRlVSdDUzR3FTR2EyZGxtRzMrQXhvYzRo?=
 =?utf-8?B?Z2c4U01MK3pYQkIwUFdDOWw1MGtwLzU1ZHlEOUZnS3owS1JoTHBwQ1pQeEdj?=
 =?utf-8?B?VVI2WmpOVFVsbzJKa2xyK0NMRFQvTFM2WWlwY043Vkw4TmFVbXF0eVF1c2I1?=
 =?utf-8?B?Z09VVW1PRFU4RVRWdzRyZmZNMTVTNkZNdW9PS0ZpODB5YXF2enRuZmx4ZTFj?=
 =?utf-8?B?MTBnMzJvWmxWSENPWFhjWnd5MkZHT2taOURTaVpUeHFRV0NTdkFMODJwSnY0?=
 =?utf-8?B?b0dtbkN6Qm5DYjFiMkZqYS9aOEFUdWhPWEdmNEVOc0ttaDQxLzBVUmd4NnV5?=
 =?utf-8?B?eUNNZTFBZkdMVnQ4V2JVMmEzOWgwM3NlblVsQ2dPTDY3cG1BNmVCQlEvYkQ5?=
 =?utf-8?B?OFhUOWUzRVM3dStHTC9VQmVtMTdxeDNldG54RmRuZlJZUmJzUkNLVUZieWdH?=
 =?utf-8?B?YVVjYjRUaDFaU3pkd2NyWThia2xkRUVPNy85cHhNdk4zV2ZpSmpGbHV1Q0Ns?=
 =?utf-8?B?cHFVcTgydnpLbkI4cW1hWUd6K2l3azFwUks2YWJnV0hob1RXRUhvQmg1eExy?=
 =?utf-8?B?RjF0YWYra0tvem9SRTlZektrZVNOZWExbHE1Q0hFcHprVzNtTVowS1ZMV1JE?=
 =?utf-8?B?dVlFM01NclZjQUw1Umkzb1cxOHZOMmhEem4yNFk0UzBFY3dsYUNYaHA3Ukxi?=
 =?utf-8?B?QzN2bStiOURUNVN3MnFCZkRTZXNZdlJPVEx6VlhDZWxjOG5XbForem9iK1lE?=
 =?utf-8?B?SnFTZWxNM2JJUWVoaVFmYysyMU1kcjV0WG5ETzVIWHJxTGNJcGdmVk9lSk5j?=
 =?utf-8?B?alhkWStML0FqZW9PODlYZUF6aFlvZzlrbVpXdTBaNkNic21DV2tJRnNQWmM0?=
 =?utf-8?B?em5vRFZpTHJuMFFxZko4Zy8wMDNDR3A5bzREaW5ic29sWVhzZUF1VUNjRVM3?=
 =?utf-8?B?VnJRcnJEMWJ6NE5tZTQrTmhmT3FsT3VkbHNkOXovenFzMkhXdnZtRVBIZHBi?=
 =?utf-8?B?YXllQWR4OXpva21zV0FIRDRmWmI1a1pjaWV1NjNiQU92OHNnVzUxK0ZGMHBU?=
 =?utf-8?B?ZGUvVVd4Q0F1QlJLdldHMDJsSWVmWDkvWG4xeHIveG1TSGFCZ0lCYnc1OEUz?=
 =?utf-8?B?aUlsbXdZSGhqWG5YTXMvdG5DK0pyZHEwczdscHN2dUpoYitPQ2RBRG5zWGdJ?=
 =?utf-8?B?Y2hMSVp5R1hrRW4xTHphc2s5NWIxWWpra3h0Q1k0bkRwbFdnUithajRPZkpu?=
 =?utf-8?B?M0hYbmtPc2NTWkJFTnJwZlpsdFpISzdMNHM1bkF2clhxM1VvZEJBUlZlaHJl?=
 =?utf-8?B?TzNReFdYSFJoUk5OVkJ6WHdpc1NDdm5wYy9pQVlPalJVdU9IdWNuUll0TVhM?=
 =?utf-8?B?Y2RUZHgzODIzNzlqQzdXck9kY2tlVk82NzkrR0Z6UmhaK3I1YjJzWnZyVlpE?=
 =?utf-8?Q?/mD8vaHrCM+73u7g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b03c3b-a571-4b7e-be1b-08deebea6189
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:21:42.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxZbjl0IK8iICk1w819wkXshkNLHlOQ8kE8mhTkhLHaGdI3d8M+PzOdsdHuDkGjLDTRgXQ3q3oyOWu9qduXR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:21:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23771

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Use the provided kernel hardening configuration options in the kernel
> build.

Err, no, this does not do that. This just drops a dead include that
could be used in an own kernel recipe, and only then it will have a real
effect.

> 
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 recipes-kernel/linux/kernel-hardening.inc
> 
> diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/linux/kernel-hardening.inc
> new file mode 100644
> index 0000000..2b22fca
> --- /dev/null
> +++ b/recipes-kernel/linux/kernel-hardening.inc
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +OVERRIDES:append = "${@'kernel-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
> +
> +KERNEL_CONFIG_FRAGMENTS:kernel-hardening += "hardening.kernel.cfg"
> +
> +do_dpkg_source[depends] += "${@'cip-cis-rules-config:do_deploy_hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
> +
> +do_dpkg_source:prepend:kernel-hardening() {
> +    cp ${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.kernel.cfg ${WORKDIR}/hardening.kernel.cfg

Why does this need copying? Can't we just reference the right .cfg file
in SRC_URI and let Isar do its magic?

Jan

> +}


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

