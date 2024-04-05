Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F5C67861
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 17:48:09 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.120])
 by mx.groups.io with SMTP id smtpd.web10.19269.1712339287497427868
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Apr 2024 10:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ViAhyeR1;
 spf=pass (domain: siemens.com, ip: 40.107.104.120, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx2WKkRvZilWZJ90+n8jHyNJipkMEVTZfTRFuvvdD8DrYpC/TE3d1xZcYxzrZYOJi5pyrhBIsRIsZqkpurm1H7Um/lQkIrm00F7bmSUkXlKgfCvhhoMUzsgdNq59h7enU3/rjJJ23mblcZwWRsNCkua4mR4EpSnE4hCF7/a/92zlhiBt8/1DvvH4ghvsq4bD7V4G/kGeFqdYLpCy5w2Nr8dWJQwMoXVtVNxpjZjAPWwk63c+mRdXwVYRh8VEu+Fhv3A3KV0+cSNNQMpBkbYkwHMjWQcKeVUwRhKqhDYOCnmEtTwgsqNV96wGUJ//kwdP7xadiCwKBbuXFg9Cxrmh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9mgLRuKbm9dp/Xg77ZJ/Sg1/wgqfkI5UqxVMW/bc10=;
 b=EqrWbF22YsUGHWAWaFPOgnE9FfJUAwJR2zsw5QvGMd2HgmFRBq2Qt2zcNxDOWrIOhN+v8EoeKWNAP1d4IJc7ZshbRtPj3QBbjoqS8ukgB6tbSQKnXTNvkMtbTuRWkC2PCKREjVRfvo/ap8KTFIxIbM1o+MoKwNhb5IwC1iSvg9kL9RKSTcjG6L7TKQANO6rc4ltSFpRE3ETsOO5xNSK9FQZMVWti1KDAakSWx3vLtF963rWZFQNse5EJzvcMP4mSZIQYJs4YZLAyMeEBsy3qvDiyEO/Fv+ARp1RMbcG9ILN+7XKQFZ52JmZxdXETb0v/9wvrz8OvxiOoM9F/QsYftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9mgLRuKbm9dp/Xg77ZJ/Sg1/wgqfkI5UqxVMW/bc10=;
 b=ViAhyeR1JKUGdfxrJnewTHQyEegTnWH3kOPArDmSt1c/ZRKlXxA8CND8XQgJ8QqkB+1RcSePgL3RZACgfrSYN8qL2PvZZYYgiGNiEAP3OMarGv6d+GxbDCrCMvagC2qxYYCxhvWvLdTt7akubdfC+sFoZo6TXGqqNAlXSEUa6MRXjhsGQcJVac2v7tMeED9jmf8/kOXWuQ18jMWeg0OO54HxHKuUyp/hQTwurcl3IZNsmgA9AvU5KiSbXrALuSQ7QjbQ3iY7RFzeX9PSjuPh4lj98Wk8UdVlXyzaJ38w+uKvop8ehylFd1aVw7mMm42z3qMTS+EpAdGfRCc6CBy1yA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 17:48:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 17:48:04 +0000
Message-ID: <9125cc93-e91e-4b98-ac76-dd5364dbf275@siemens.com>
Date: Fri, 5 Apr 2024 19:48:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml: Move
 SOURCE_DATE_EPOCH to layer.conf"
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 dinesh.kumar@toshiba-tsip.com, venkata.pyla@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240405064757.378647-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240405064757.378647-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5935:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yXnJS8ei5TG0rVZKRU0P+rrIOMvzAC779JyF2JHAAtrwlE8p6EoAtbwUgQdiGBxjxXQDpJYgiWsPMKoDXxvtVy2X37gpx9WabLBGkBueM9GGoL31URY7wee5+haeFrknTnz5KvDuQEtGejPOsodXSupn1d1K6xECaiKROuSIcl1cKOr4R1KP/HpBrx4WCykG1cxNbjEyhwR9AB2NoFrokpWnnT2O3ZreeE0z1gvI9kiW7OcLmObUviD2mAFFo52vXCgKGw3Mj+cF2jntTN0cGz+MtpAHLytX0FQ+nF6k851f7zBp7EIa+Xg4oYDNRbVoIF3hVPsbbeaqvNf86m95qGwiIWbO/uTgk06n5x3q9pSKne1chAgLsXAcE+rMbR2YoSwFh/aNF9dCZUZvCyn1SM8mGJ1oYiJTLy0kSqGWCrOAFY+VK5JiyAqE7FEsKDlcm2X9NIbYOFlJLRCzORps4lycR/Z4v+YbVtARyMxG3sRdgLnS8IuKm1p6kdjXZEryXHtQi2E5T80OseZ+7KczcRyh/oSdJJ5hq8R9CBEk4IJSkteat0ZlwHICK+8ZgR6YeBti/wRN4elIuKWKi8dRRXRYciWxEcV7Phg9jTAexFjk6NZNd6MJYQzUnD0e+RZQiaCttTJr58nRHGmahcuqINLeU6vDuHmTvgSVLIGBqOw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFlpYzVzTU43WjRsR0NlVFp5MmNsWjBJYjFBTU9ITTdQYkU4ak5wNFREeFJo?=
 =?utf-8?B?TUcxakdmWmVwWFdTczh3Nkl4QlcvM1RseHRaUkg2ZEY4U1UxYzhHaUlhUlZG?=
 =?utf-8?B?SmNOL0xjUXE0VFora2xkNFBWcHpGUit0MitwdXpuSWVpSXo4elU5Mm9CT1NP?=
 =?utf-8?B?dWI2QmdZbjdPT2FqcHVtdHBGbUdPbXc0QnorZ2VIelNQd2lPQXpSbVRJZ2hk?=
 =?utf-8?B?SjAvYWh3blhzODRlQlQ4UzNFMndIWXBobFpBeVByZTQ5RittRU1TbWpvUG4r?=
 =?utf-8?B?eE9DdGxTcW9LU3VTbWFRemlRSTM3SzROc1lFSFU3MEpzd2szRE1WTyt3RVpF?=
 =?utf-8?B?RjNPNVFnWGFFbU9hRDNtRmZjRXJObWV4NG00NFYzcVMzMlNOUEJYYjFCWENK?=
 =?utf-8?B?QnQ4OG9GbGhLRjMvT2lZTXlNOE1KZ2hzQVpiZEZSQ0Q3MEw5Zm41N24wZE9C?=
 =?utf-8?B?M2VtZURtb05uR2NNWUJEbDVjLy9UVEdONHM1QnF0NCtBWitBMVR4Qm5Bbmxr?=
 =?utf-8?B?YndWZkxTRU1VVm85M2RFZmhwYWt1ODB2L0RHVFRLTVprRFAvWE9uVzlzQmQw?=
 =?utf-8?B?R202VnlGYS9jc1dseFNuRnNrcWFrd1d2ZmhUVWtsc1VRRnV5UmZMRDZrdmxJ?=
 =?utf-8?B?VVFNaStzbFpqMHJCZFNHR3ZRSStBSTVGcmtsU1B2aGVydTNFTXR4Nk1CdWJI?=
 =?utf-8?B?VFpOLzhUWGI5aGxhUVRxVGxTNHdpNHN3eHlKMlJGWUFwSGl0SlNNeUR4NjBj?=
 =?utf-8?B?N1VwQ1lZRWdDMkl6bWhqaW4zN3pvZ1dJdGNDQkIxQjNkcWoyYVJxSzdBV01Q?=
 =?utf-8?B?bG0vbWt1ZU5FZ2FwREp6bFdBL0JuRjJGcjlqeGMwd2EvMXNHZUwvNWtDUjVH?=
 =?utf-8?B?dy9ndkZtb0h0K1VUUkU5Rnp4WXRPbFBjWHFJd1pEZElDSE1CcjUxTnZJRDNS?=
 =?utf-8?B?N3p2ejJ2WWM3cVIxemJwbUx5bnRkd2s2dTJNbWFURStSdXg2eHRMVmhXUGVu?=
 =?utf-8?B?S1ZzZHA4L1JUblRtWEFGSjVITy9iaEJROCtGMlZGU1lmaytaVVUyZVN3Vk5V?=
 =?utf-8?B?aXBTOFhhV0I5ZlIvRkZjc3pZMGF6Umh1L2hYYUplK0g0a25Na3RYU2ZxZHZT?=
 =?utf-8?B?ZSs3UHZlZzE5NDBjT0xmYlliMUJQN3dtV09ucE5weWhoVGVidkpmUFdWOEFF?=
 =?utf-8?B?bzZ6QXZMaUFYR1l1dnM2ZWpqTDc1SHNQMDNOamtMUllFOElMdUwxV01MQlZj?=
 =?utf-8?B?bm9XdHN1WSs4MUxaeXJkeXYreTBpK0xhTEN3TXBhV3RpZ29MbG1FdFluazM5?=
 =?utf-8?B?UjRpUjJ4QVk2Z0lDdytRdFBib0E3SnZBYzlsL040bmtqeGc1UUxDdjVHVVYy?=
 =?utf-8?B?MEN1T0FHdnZSeHhkSVVXeHhLN1FyRU5MWmIrcEt6RXZiOUpDT3lGcFpTRFQw?=
 =?utf-8?B?enlJWnoydkpJQWhwaGpCbWpHeENPektseDdCSnhtL2o4aWhQRVE2MWpzQ09U?=
 =?utf-8?B?aUJERDdHbXpZM3ZoZys3N0QxczVuV1BhQ1puMVRzS0Q2N1luOUpIZkhXRC82?=
 =?utf-8?B?eUxCb0trZm83a3R6YUtFaUwydGFrd3JPVlR5dlNZeGY3aXd3R0hzSm40elUz?=
 =?utf-8?B?NlpOazRhMlJoOHZrM2M1MEtWMTZiY1FKaXhiaU42USs0TFp0a2VDQXZ3MkpT?=
 =?utf-8?B?K0paVzRlRVZiTmNBQVdUVTlWeUZuaXNXZmFDZkZCTjdkeXNJQUNqd2xDVDBP?=
 =?utf-8?B?eVBrK080TSt5UFN4TXRrTUJlUi9TMmI3THdZYjF2N3V0c1Y3cG8rbW9Jb3or?=
 =?utf-8?B?SysvNTJKdGNiV3VkSzhjVkhXNVkxcDV4S3B1WkNIU2c1T2JZd1RZSklYdytI?=
 =?utf-8?B?czcvdGJ6SjRJL2M4cG9lcHdrT3ZZRXd1Y2h2NFlYa2daR1hBSHJqazNyWCtT?=
 =?utf-8?B?em4wVW93Vy9IdWpoS3lWSUJiRms5WVI0Qm1IU0FVZzZ4QW5rS1ZxK05RWXJp?=
 =?utf-8?B?QWlnZ1N2WjlySm1ORlllTHpvRUdJUHVQVkJpRktPbTM1WE9nTzRsL2YzZXlL?=
 =?utf-8?B?MWRkY1EwWEdybjJ6aWdhd3N0M1pGY1VUdDQ1K3BBRWtGZjJGb0tncmRwRVBP?=
 =?utf-8?Q?AYH4VW3U+bZqefz2AZSIzn++R?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cce621c-b781-4ddb-7aec-08dc55988b69
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 17:48:04.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKzabvFgiNJhWPozaepWXtBgrybfqo4Z4CU7wnnwwZIH2sB4jLlE/ASRs9+Dpz3a0pjo632Rg5amdDHD5liK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Apr 2024 17:48:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15495

On 05.04.24 08:47, Felix Moessbauer wrote:
> This change is too invasive. The layer.conf is read after the local
> conf. By that, there is no way for a downstream user to set it to a
> different value.
> 
> This reverts commit fcdbec9d2ab1daebd19e021c2b90ed30d0eeae00.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  conf/layer.conf          | 2 --
>  kas/opt/reproducible.yml | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 82b4084..2c888b2 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -24,5 +24,3 @@ LAYERDIR_cip-core = "${LAYERDIR}"
>  LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>  
>  IMAGE_CLASSES += "squashfs verity swupdate"
> -
> -SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> index bc71f28..5d6a896 100644
> --- a/kas/opt/reproducible.yml
> +++ b/kas/opt/reproducible.yml
> @@ -13,4 +13,5 @@ header:
>  
>  local_conf_header:
>    reproducible-builds: |
> +    SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>      WIC_DEPLOY_PARTITIONS = "1"

Let's fix the issue, rather than rolling back to conditional
reproducibility. You could move the SOURCE_DATE_EPOCH assignment to
kas-cip.yml, e.g.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


