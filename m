Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5818FC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:15:43 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32263.1785161737942490292
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EiRhterZ;
 spf=pass (domain: siemens.com, ip: 52.101.66.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYwnLs6JWXXQlhjOdEky6/fILoWkqEq17GbjkXC1UIxWpoT/MGzLVyr4zHK2VmDu4BBk/aYHPf23pmMHyb82HmsVJEj2eskK1jdrMRqQigVOPX4TppAdYADRH1sqcyCmNNUhbO3DSEL2C1Ssd8IwCq/QDCuCVAPg/5F+nPTsRrsS3NVD1idJoFxxgC4ZjvA1Uqp8IQ+XIPxS3/atE40JbjsGwhxY1UERMVuDqQLO4f9CCKmeRUYvt8YcNbKtc+yLAXMA1tGq9uDWDt42XABO1IZk8mr1HwkGiRyxM4KpWgH0H8Q3sImYmYSrt6gKOVpyRw/sJDyVUMdBl1lI+LvcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtKKtHthgGCFaTYGhyFbxLlz1+JXcOAbeHgpAjlHVnc=;
 b=be1IW/bRw0DgskEXxd9Yam1r9S7w56bGpdi8ZE9zWSAFsruGt0V8/9s/+qd9WAHt+2TLhifU2rsYyxRGbZ5BVEO/vxuwvfGy4pTOJzUY3WdqjRWlS+s4WgDvOhUt5sFyM7nbSCd+DsX6iX+jNDojKCYwpBr2a4smNfOQIhoI4W9epqsTw4cou/HOiQrzv3JJJRmLBudgRulVMTC4NxLV6DnWalhsNPFYfr4QznVo8obkmltJ0Gtgzo4WBgawBI2qA5vLT2fQRuJZC8QOFzdk4tLkI0AbxufewamV4TJqsL+MLNwdOq/NGahlWaRdQYs5SkoovhtfPq0gegJhAA1UgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtKKtHthgGCFaTYGhyFbxLlz1+JXcOAbeHgpAjlHVnc=;
 b=EiRhterZd39u6Le8do6mCmEnjZNn9VBdjCwwfHWs754SjGIZtvesLubtIhbkRdq1icUrT6Vzmh21mxaa0SSklGT2zMsmqCGhr5SAajl6WsK0BA6wscSwr+UL7L3zxkX6dvi8HpkO7Go/GEy23oW8S+M9gqtVf5mtrhU5TDQ78c7/gfbenYiCho/I0VY1leoYCL/bD8HQJIjG0B104wFWe8aBP8SlGdO4xXnV3Z5cPhTo/fndTPSQgfOJjN+S05JVSKI4YK+OxfkjKDz/yN8feLpqcUTLX3vil7gSu6xqng4suqmXWii+zAXG8ztLZRajumZr5nwBgjqoNpGxBZ3yvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:15:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:15:33 +0000
Message-ID: <8b468826-7373-4558-a6fa-903efba8c002@siemens.com>
Date: Mon, 27 Jul 2026 16:15:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 04/14] Add
 github.com/ovh/debian-cis for the hardening validation
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0263.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1c77b7-bb89-4ad7-bd08-08deebe985bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|4143699003|10067099003|6133799003|3023799007|55112099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	eNJk2ETh/2iDAYulUtSjGxKHibIapnBRCSLfjouhUVN47RO5T0LnCvAyA7VwL3GLRZmkgPBUa+45X9pl+ierM0vz0jABeHQu6ih6NoqpLBX+FcM4oPXcdvhKqdzW5IAvZw0XOG1GFbBSTA5y4bsHU1VpfUeMhqDRescFjkZXqiEO+9U41KI8mHEqg3ITkIaNIz4LzKxkVpFWgQdtcKjjc9UQaATqBmND2e2SEQgR+hnU0SXG2ocWhhM5gW21/MFXHP47L2OpFylf6uPxSIHpf8JUyeuo0oISNOvgVxVqEpfAWiOC1oL39TC1eI8HGsjE4IpbQN/VWUcugWCxHPeSakWFx5INxpVGb3B4Jr8/bDt7HyBFArCCBG6P3w86SOk4pgKYSYQTWTVxhI/rcKyMLLXxUwl5vM+LqcWZ30jxQRoLsfzBUaXf2Dz/yxGVgSAvia2y/XJp/49hwE8/zWOW9vBfOPwA4AMi+GOTW3vC83Iz74KbKBCl0Wt4E7fMMNYcCk9snn8Y3vMBKrLsioaRAt1PE4cD1pWPcJY0EKhNfpRgwI8mg3VRdafzHjMeRWn7r/unKx16nLRHg9Wd1sNlBZrqktJmsMyQSWA3qTV+IpwMvc2HbVQrABq9yXuh8WyY2aesy/ENB8dOChP8WDHvTrZEeaLZlX3Qdd6q04y5Rs4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(3023799007)(55112099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2NyMEFmdjU2NVBpRmlxcUt5ZHQ3VXdxSHhhUWZNeGppLzBnMGprRXVkbnJF?=
 =?utf-8?B?Z0grQVlXNndSVlNKT2szUWI5YU9WQXQrOXJBNkFXc1NZTy9mR0J6YlF0Uzlp?=
 =?utf-8?B?SVRnTlIvWTU1ZXZpeTBPMzdOZVB4c2lPTy9IdjIxeTVWdFZxVEYxeFZLWFBj?=
 =?utf-8?B?YnYwUmRjMVI5NW1xNDdDMnhSemUxdGpjem1vand0bmgwMmkyQ1BVWElVbnQ0?=
 =?utf-8?B?MkZzdm1RbVRMRjlBYjJMc25UQjVQWmIwSDlJWkNGN3Ixa1RUVFVwWXZkNnNz?=
 =?utf-8?B?S0NmcDNsRFdPTjVxcUNlYytJeEdZM25sY3hkbEljV3lIQ1Q4L3RWNUdaZmN1?=
 =?utf-8?B?SGx5N3MxNUpraVJxODU3UlA3RXZ1bUw4eURNeDE2N2hoYXU4VXlNeCt3aE9L?=
 =?utf-8?B?Z2NHbk15cDNNRERSV0sybSttU1VWMnE4OU5rbGRoU0t3WGRzWTZPdkgvbWk3?=
 =?utf-8?B?OVdPSkd2QTJMckZHdElEUFF6aG1SeTFwbVpJWDJER1U3d29RV3lqNjF1SE9k?=
 =?utf-8?B?YlJMWjhXUU9DQkZibDZGcnFQSUludHJnMkFOTVRmTWpjWVRHV3NjY1VIYXNO?=
 =?utf-8?B?WGlxWGFJcS83MThrdnVyYjcxS2NOZEpkZGF6dThMQkpzV2Z4bTNVaXA1TjFx?=
 =?utf-8?B?YzZHdGFVRVhZR3B1Mkg5WmVCdHh1Z2lwN0p0emZTbEUzMU8ySloxTWJJU3hr?=
 =?utf-8?B?MnlDdkhFa3hHNzkwRHpXQlVaLzBYcTRoM2xVV0puR01vUXd6dUdEVlp3YXlK?=
 =?utf-8?B?T0tIRVpaaE5UT2pQZ3c1bTBiQU1mdzVyRXBTRnNjUjRJek80dm0xcnRyRklm?=
 =?utf-8?B?eUJSYXZWRDEwSjlSTm9IWjBZcU9qWDBBYXpSc0J5SWZ3Z1lqbjU5ZC9Ed2Zj?=
 =?utf-8?B?S0l5NHRlVnFCRTN1U1VWY1FiSEZoeTdZWnNCdXA1MjgrcXFFS1l1dHlFeFgr?=
 =?utf-8?B?WDBNK0pPc2Z3MTkyWlRwZzE0Yk9CMVpZUkx0amdnQlE4UUxsdVBFVjZMVmhj?=
 =?utf-8?B?R0x5alRvazd2aWVUY3RaQTBvWncxTDM1QnVZVTk0eGRlTS9BKzByTXhDV1h5?=
 =?utf-8?B?cUtiUUxqYkZUV2Y0c0ZqNy9IMkJXWGZHbjErcmhjanZtSWtwaUFOcXhYeGZW?=
 =?utf-8?B?TXVZdUE0cFp4bDhzZjFPeEtoVGs5cEJkc0hHV0NMa0VNZG11TlBGbWVqNFVQ?=
 =?utf-8?B?VTdkbDZCY0diUEtVSVJwVG8vRWRwTk9zZEl0cEZaSllQdERUOE5va3NSS29Y?=
 =?utf-8?B?N3hmSDR4d201MjlBNk5Ha1B0TUpvRzFQTTZFMnZZdUVOTWdock1KdUxHaVZu?=
 =?utf-8?B?RWFCN0IvSGNJSEJTSklOMlZvY2NEZXY0SnJoUkFZT1JpNGwxOUVGYnlQYmNE?=
 =?utf-8?B?L0FCOW92QlFyUzlIMTAyc0Z3NUU3SDJiMVB4THpsRjRKUS9McTFxSzdGaUxr?=
 =?utf-8?B?a1BDQ1c2NjNUMlB2cTlDb3BlNnFsaFRYZmNjZFBBQmJ6N0NZWlZLV20xRmJ4?=
 =?utf-8?B?VCtLZVcwWXhxNlZMTkpnSk9VTG9zeDBnaCtHcTcwaG9TWFJsZHR5MzRmRDZ1?=
 =?utf-8?B?U1pJUmRQVS91WnVCZlZJK2JGdGtlV2ttaTl2dm9ydzlYMGVmQlgyRXAvZDJ2?=
 =?utf-8?B?cmV5QVh5UU5HQ2JmSWNGdHJDbXRaWEM5UnV4M2tjK0dWanhIZkZETXlCMHRP?=
 =?utf-8?B?VHY5ZVpzcTl2aGNtS3dobTZyOUhWNGVPYkk0b2FDYjh6QUtuNVYrZURPWFJy?=
 =?utf-8?B?c0dVZHJuOW5tZlE4ZnhidFFhdWJ4UTl2dEpuWlNEQ1NqTTVBTlA0ODU0aWxE?=
 =?utf-8?B?ZUFqVnlsZ29qNnpNeG5kaEdyTXkxNVZNMnA5NExxM0xMZHFvcW52RUZXMzRo?=
 =?utf-8?B?QWQrVFpESFFXU0hxbWlyUFpvOFpxNndSaU5XUFJZejkvMlg1U25WOGp6T1Nu?=
 =?utf-8?B?VjlvTXZOYW55SjVtWjl6V3VJUVRiR2FYR2NhS0I5N0lZTERnQVhyT29lTUtF?=
 =?utf-8?B?RnJhRTJBeG9mUksvWGxIVjVIQ2w1OG9GNXMwdXhFRnQwM2lqYnMzT0tGZjhL?=
 =?utf-8?B?SmtKc0p4LzJvdTVheW83N3RoUjZhUStXWlhXeFNQVU9YS2Q5dzZERTAzWlZa?=
 =?utf-8?B?TEtlbDFzOFJXblhWZTg4MTBTWFdIT3h3M0s4di84UnlYQ1FyVWJQL0IwWmV0?=
 =?utf-8?B?V254UHV4aWN0Rjh3ZnpYVGtIY0JVRk9VYXFBMVRNSTE0RDJ6SEp0Vmo0ZTJB?=
 =?utf-8?B?WjJGNVFCUTlZYjVPRVFoUDhFSUhXZEJOWDhYbUVKbHNHd2VIcTV4VkFkVVRu?=
 =?utf-8?B?U3NoRE5NbXpSMFV5bVNHempnNHhiQnZDRFljbkpPUTFBa2RISncvRFprVFcr?=
 =?utf-8?Q?fvkp0//EgpPjuYZw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c77b7-bb89-4ad7-bd08-08deebe985bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:15:33.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9svMQ5FA9Zg/fsdZeDK/6VvzO5Eyu5eugvX9Mpse257tOj/Y2Pky5qPnyzF0rFkc+h8SgV4wiENuWFk7q5bDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7019
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23768

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This creates a Debian package out of https://github.com/ovh/debian-cis/
> to validate the hardening level during runtime.
> 
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-security/cis-hardening/cis-hardening_4.1-6.bb | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
> 
> diff --git a/recipes-security/cis-hardening/cis-hardening_4.1-6.bb b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
> new file mode 100644
> index 0000000..bed2dae
> --- /dev/null
> +++ b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
> @@ -0,0 +1,6 @@
> +inherit dpkg
> +
> +DPKG_ARCH = "all"
> +
> +SRC_URI = "git://github.com/ovh/debian-cis.git;protocol=https;destsuffix=${P};nobranch=1"
> +SRCREV = "efbd5b35ba32226e8950d52bd3f3444c702bbd84"

What is the lifecycle of this project? As CIP, we are linking one
specific version of it, and we may have to bump it at some point in
order to fix bugs or add support for newer Debian releases. When will
upstream drop support for older Debian versions then? Will that survive
10 years?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

