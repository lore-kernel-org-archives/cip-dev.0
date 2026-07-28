Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF476C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:26:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13906.1785252354229330176
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 08:25:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rhDBFK+N;
 spf=pass (domain: siemens.com, ip: 52.101.84.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXZhzCwyop0HPW7RTbLpcCpka1/fkbL8BAv4sbYu7sckkFRZVk+Xvcx5EZUO9/SF1kRJ0gq2czF9adpu7RCxhHYfCHJ/i/eT/D68v7XqNS2EpqsIKto9naWVs6CV/X5TDjLkaMmaMrHUU4Frb3XgLejhip9rHYSLe55b3+fFjTqeXRDxcFn3P4l10FirYs8RpST5thJDtxvruwrK86VpIwy+vprEGndKNaE5VNJ4+zJe2S5pxz97xRZZy6hckZNuy6Qh+5lHh2+jLn1721Gqv0/XQQ2xzMlGlbkKfeRmZGedK2Gx1Q3LCOvccgi13RmQCTq+zy+7RDyF3s7B9s5Bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIi4WdsFFgAkfAaXRJ3FDnWgfn+4WaAUrLHLqUc+xeg=;
 b=UiDPIIhfY8LmWg8ZaFppUDAz4CruJwFn16HYD1b0wJzpFUsPAHZbkmAvJOwxxF1t0J/9xvOiJTYcmbU3zBOHRt1SR5L6OfZ+oWeZmRkgtK1j3WL3ST0A4BzATEiSyD6cKf1rX0vwxyVgzFeKbGLl9UvG3w7iNq5Zsow+wDafRBSGGnqt25u+tRCngbSO4JOsTLWeQNm+iBL0NQOX3IYOwwU6RnhZIdrsx4g/u1RcP81xYc9z/kcXO8R76wPhf1MflTJ/fVl+8+3FZbi25/YI5q5snqWPPGKEJQvf5JJK2l8pB2qvROTpA345uoKwDS4rqyt2tCmY+9RNJMPbrwdXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIi4WdsFFgAkfAaXRJ3FDnWgfn+4WaAUrLHLqUc+xeg=;
 b=rhDBFK+NeO7Fd06K8bpwvHB2IdIzzhLV0tU2On5a6vOYjv6mYQqPlMNWnEAKAox6k0NkptXM5Bs5QTkFpyLFu0EzlYziTSJZQoXjpiPLlB/9osCIXZt5kyrDI6eDAgaJ+EAxmyAYWLtEYwzDbjXqIq0HSLeNKv697k/nfaMw3w89l6oXfuT6V77ARHc24TIo1AclyDge7G8WB+tbb05C9UxYSs5MMeCLGe3W1U+YknMk83wJGU0aBT4d8eYF5g3I6Scq6eBy8U2JN3mod9zmwNy+VyHO8IiMajHEBpoMSl4yB2u4Tnxb929mQK9K+vz25OoJhb2YRYRi/weqhNZ92Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:25:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:25:50 +0000
Message-ID: <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
Date: Tue, 28 Jul 2026 17:25:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-6-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728131231.117214-6-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3302:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fd0389-35b1-4b69-bbde-08deecbc815e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|6133799003|11063799006|56012099006|10067099003|18002099003|55112099003|20052099010|22082099003;
X-Microsoft-Antispam-Message-Info: 
	q5svv9D7+8wxkbyU2NXCWOHvTYJdrKB36YDtLAMzSnV8d/Yl93OL1amaBJNT4aOND9cFVLfd+XM+lD1AlZQqyn3wNV7gNruBwahI8/ho4wvxfL1d3U/yzhBU21j8A/RFa8DCj3SfECZ1njvFEl+l5zlWxS+nYvuNklvc6EWjP2pwVJKnD7nRJs6ngDyTOxuvHjpwqVZpXWYycW0gx8NPi0/9z8Dfq5OZGFGW0enCZU+oymO1cUVJG8DJ53gq3y7dWRR6U5SqQR+gF2Idb31i0je+L4FeDiU/O953VcGGiLvW0xrahaKS6umUJ3EkimwK0BKhMxsHJd0Q/q8sAmY9FACHLy5eU1zf8AnSXNxwFy+RtX3RHS8Ppawi3DrnYElHaFPUGsQIKcFkqJRBulgb/q/Oqg1mQsA8YdDPmWpCC6gBbWb1ePZlyOWYLmf0aGrSrfBUDleIH/wKLow5IQH+dOwuy63yRfLxeFTX3m+xcYVDZ3O4a8X2o6kO83uRAcecemqtHOrx6p9fJEYhtnF+ycQmYVBr3pxAnczjmZBTjjh3AlcnWN2hvFmx6ilkdWUWbdZhqbUp7SV0dvo+FikIhlGBkC8jbfZbdFwvztXmAlmXv8t6GHbmGG0LdYgnjqrg19hL7n2mvcxej34EjuflbmgfAtUKD5Hb6rHPKq7oYDs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(55112099003)(20052099010)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1BleXJVUUwwQ01BdVJ5MmFuNkhQYWFuUnYrUmdiTTV2ZFlBWStUMWQ3YlBM?=
 =?utf-8?B?ek1tN3UrMlZGSlE0RHRYaGU4YlVOWUxleWMzbUh3SVRRMTlPcTQveVNTcDJq?=
 =?utf-8?B?V0Z5b1VyamYvQk91ZTJaWGtyRllpelBNL0Y5S0Rzb0lQRUtQTUY0YnpvQzIw?=
 =?utf-8?B?dFh5NzFWekFWbTdqUmJ4dWM0MER4SWVpVTk2MGFMTmtuVkRUT204akFwRUNw?=
 =?utf-8?B?cWpzN0huY2dIYzJBRHVTQ1JjWWRVanFVTDhwd1ltbTU4bUNRb2crVVFMUU9W?=
 =?utf-8?B?NG0ySmdOL0o2K3YybC85bk40WTdPdFArdE1MUHhsakN4TmRORjF4emVmWkxi?=
 =?utf-8?B?Z0h3OEJLSytVVC9HMTZTV2J2YjE5L0dTN1Y3ZFhLcmlNMU1JTmdRT3lZM1Fp?=
 =?utf-8?B?bDRHM2JDdU50bUpvQ1o1UXlNRXNrYUcwWDBMQXl6bzFyZlVpbmVMT0tLY2kr?=
 =?utf-8?B?REJSbndpZzVSV1JnMUswQ25nNHh6Z0kzdnFOTFNuT0lkNjNTTHRwZDVGSVFQ?=
 =?utf-8?B?WXlSdGZ3SHNnWkFLaGJJVFZ2OVVDOU5TaU9CYktwRmF4U1lNckw1L2hyaEZr?=
 =?utf-8?B?c2Ywb2E1Z2tBZUE1MVdBaXlKU05ra1JiOUJaTm4weXR5N1k5NHRqSU5OY1dM?=
 =?utf-8?B?RWlaMWNOaXpMczNyaXBEUEFuV2N5b09ETWpmZ0FKdnk1U2c0aDRTbU80VXM0?=
 =?utf-8?B?dnhGMUx2N01IUkN2MlhHS2xtYnd0dkpqeHZGMUtDem9QVnErMG1pbmR1eXUr?=
 =?utf-8?B?Q1hvNmkrU25iTWd2Zjl2NXZLZ3AxRWJmTDl6YzFVOVBpSk1YMW40UExoQXJu?=
 =?utf-8?B?VUV5Y1BaZUwvdHMrZzdPUUdJQWtrZnVPVEVzQzVkdWU1YzJQQWlIeHdvTkFL?=
 =?utf-8?B?V3RxWDRjaWlmTDdnbjl6TW5MZGVyU2JwUml4QTVNRjR3Y0lZTi83SndQK2t1?=
 =?utf-8?B?YUwrSnBHMS9VckowQ1FNYlpOQjZZSHM0ZGZsdnV2NzlRMHBscGVTVEdoeWJ0?=
 =?utf-8?B?d0xnTFg1RFgvQ0p5QWY5YUJyVlAxNnoydko4cGZpRFFDdXFRV082MS9UN1dM?=
 =?utf-8?B?YmhKcElpYndGK040c3R1TnlEZytGb1E2VVZvTG1jVmtoWC9NdFVVTEc5RG9p?=
 =?utf-8?B?aDlGWkpXRWVheEdCY1FjT1BRd0tUMlU5TmwzaEpBOEtpOThyOTZsUVgwN3h4?=
 =?utf-8?B?S3YrNFlhU3UwUTF2NlpHcUpCM1lIM0YxL1RybzAwNkh5ZjRGaC9KNFFqRTda?=
 =?utf-8?B?a1NIU2JJSHZhdWVqMERqcTVNREg0SFBsa2xRekNoN3hINWszTU0vVmpwS2dD?=
 =?utf-8?B?MUV6QUFmeU5QL1hoUmRSU2lrZ00xSTNLY3BmY0I4UnlJRjhwVHVMY3EwNnpJ?=
 =?utf-8?B?ZnRZakdCbTR5TWdETGorRXRrZTNQUW8wZGhFejBMSjhicGtERlVIa1hYYko1?=
 =?utf-8?B?bDMzRUlnNWZMbStibEdsRVdDZmlCdUQwLzVndms5b01iSnJLbW1UVE1oSkFX?=
 =?utf-8?B?cGpHVEt1Z1FPczdMazMrKzJkekE5RForV2hSeGRjRDdVOXlTdHViK2Y3NXdx?=
 =?utf-8?B?QzlUQm9TejI1Uit0WGZmYmNUeVY1V2V2VDg0TmsvMXpuOWJQdG1jUzBWWmtK?=
 =?utf-8?B?UkM0N25Idnd0M0hHaS9nZGtaeVpxdHY1Z0k2eXZKdWk1QXNUVE00eUZhV1dT?=
 =?utf-8?B?Q2tDTzJMZ0V3U1orRkRMV0oxVTdxclpib0ZWa3I3aVQ4ekpEeDZBbEtCdGZj?=
 =?utf-8?B?TzVURVgwZjZpQy9oVElRVFArMU42K0d4RW8wVjBYUnNjS2VUcGtTY0VHSVFZ?=
 =?utf-8?B?MTJRY2dLWmJweFZXYWN0ZEhIZ2YwVEc3aVZMa29GUXpRelNQbHdDSkkrY1Qz?=
 =?utf-8?B?cU40S2lESTh4Q1JpbkJuaHB5eCsrWEtCL3M2SFczN1c5WU9WbFNrdXd1Q2du?=
 =?utf-8?B?MGR1RGl1K0NGT0tQT3NxcVIwVFJzaUNKL1I2ZlFjMnMwWmZGUzNWRU5IMWMx?=
 =?utf-8?B?TkNEczFQdVAxV3hkRjhGQXVhbExLTy9vNDB2dE5GQTM2cjZoSG9Qcy9DNWVV?=
 =?utf-8?B?aUh1Wmc1ditxTHhEb1k5RElzWWZyeTlIWlNQNEt6SHFWWXVDUkJJRGRmQmxi?=
 =?utf-8?B?NFF5T3ZLVGVXQ3I5S0JEZDRkL2dDWm1tSy91QVhtTmxEMERyazQxa3c1dXdI?=
 =?utf-8?B?UmZ0bGZCVmJDME1wanp3QzRKQUFzMXp4OStIL05vSGE2UWoxZDFGeXlSbG9n?=
 =?utf-8?B?NThLTmg3dmNaUE5ZdGpWdUU4MmtwRlhPN3FIV0l0KzFNblQzRXlWdmUySHZt?=
 =?utf-8?B?djQrOVMvRWlLaWlQaTIzYlpTRExaczdlRHkyMllRdUUxRStwcDh2Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fd0389-35b1-4b69-bbde-08deecbc815e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:25:50.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qll9/n3pMU04cdTTB4ky/Y9MpuHRUmKZd5TNIquyVu2IkSg70ne+Gxtk8NlsvVr8Fb/VsDFuxvgod4JkbUm6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3302
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 15:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23803

On 28.07.26 15:12, Quirin Gylstorff wrote:
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  README.md | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 435d037..df1564f 100644
> --- a/README.md
> +++ b/README.md
> @@ -10,10 +10,10 @@ from scratch.
>  
>  ## Building Target Images
>  
> -Install docker or podman and make sure you have required permissions to start
> -privileged containers. For docker, you need to be part of respective docker
> -group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
> -rights for the caller (`<USER> ALL=(root) SETENV: /usr/bin/podman` in sudoers).
> +Install docker or podman. For docker, you need to be part of respective docker
> +group (`sudo usermod -aG docker <USER>`). The build requires Debian Bullseye

...and docker will inherently remain not fully rootless (due to its
daemon concept). Therefore, we should strongly recommend podman here.

> +(kernel version >= 5.10.1) or newer to support user namespaces for rootless builds.

We need much fresher systems, already kernel ~6.7 for binfmt_misc
namespaces, at least when cross-building. Practically, I do not want to
debug ANY rootless build on anything older than trixie.

Jan

> +
>  
>  Open up the image configuration menu and select the desired target and its
>  options:

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

