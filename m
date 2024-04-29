Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F391C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 12:06:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web10.19155.1714392412535884549
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 05:06:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iz+lpdUz;
 spf=pass (domain: siemens.com, ip: 40.107.22.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOO+Eo4KLtwqTQO54NWLHLysOG9v9xsXUFoqZcb5yEcYzlRurKjj7bq7uYOIfn+aSSZNCWz1zqWcZe7aZg6EgLmRMAG3qrJTFA6vLcMJTIBpfMFTqiEMCve76gf67rHyOZlnluttyTzkzwPlgjI5VZfQoKaZ43gqVDFCr0kjAhnf04mKmX1x5pgCMC3MBUjvX40LrfyQGCGFkDJvdk3V2oOPIMlgDHdDWQ7bILWc3dqDlTYx7x0WQ0rbU6f5vKJ1WxT4vOsXXgODzCOSOJ/NdS18sbye0djOmXeMmSFfmFOglVtaeLs3TMtxVIbB8/L60i9lLPXmg4Cy7ZXML33w3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhOscFj2v9GuPPZOprxkNkFGcHHBCLx0Y5Eh75EP1qA=;
 b=izVqwmtbKHuHTPYRrJAblRd9a/ejFriPzGXLdjhI3DEbYr6Tb3u7djqk1y41TjI1sgw6XSf+xmKLoG6VAEcL6a51Mqm8bHyAmHjo+lcSvDgd9K8vH/DKiMH0+42jx+SWVRzmgbag1s9jkDPIG2ZHrpNDvr5GHCjyVCGYQSlFHg56CG9e7lwoqASaW/3Atd4RGIxNGvJ0cKin0v5hppTtV+xe+HpR5khdBq5S1BuImS6A+lXQjItkf78svS25wlJGHNcbjGl43FFv8tbXqhy/m9BDeXfncgOSD/0NOf6uBc868GyGAqN5ctg2e4ouYLBVop8SW+OovvElDbrdzjkw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhOscFj2v9GuPPZOprxkNkFGcHHBCLx0Y5Eh75EP1qA=;
 b=iz+lpdUzbLFjDMdCsJixqtMhhQ52cEWF7wNGttxhRbsRqBjqZZ8trIo+R9zWr7jVLAB5nEABvVKWzprTk2TBgrXdQeDLM7s4vs+TaQ/m+Mtpf5vFAoIZB4f5erjlxMFX7BBr2+EZHnTifh/WzDVwUa91nFp57C3xukpqxZFa5i9VyYL0MPc39e2DNyGw5NDANfz8CpQ+BEkPulNq3PkurHi8nX8qXVjF6DKdPbLLZkGWVb423FQ/eMG4LAMBumvnqvKsxlgF1fGD9gKaI78i/DPJgdI8trq3OWn0tcpCmO5bD13ojCjJnrJiwCbK1DZRQR4ldpMzIBZI0/veYf4S8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:06:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:06:48 +0000
Message-ID: <e1e7eb5f-6bfe-4e65-9b2d-270c79ffab38@siemens.com>
Date: Mon, 29 Apr 2024 14:06:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] update ISAR to latest version
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
 <20240429052417.736212-1-kumar.rakesh@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240429052417.736212-1-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3614:EE_
X-MS-Office365-Filtering-Correlation-Id: 1986365c-1ece-431c-f78b-08dc6844d8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a2J0ckM5MmJUMkozMjk1NDUzYklndTYvN1dGeFR1Y0hxK0xjdU0rRTl1eHlM?=
 =?utf-8?B?TmE0VTFFdkgySEN2M25HMTdjVkk5WGJzRlR4b3MxbXJVRU1ZcVZDaGxsZVBJ?=
 =?utf-8?B?TksrcTJBMXEzNkNlcTFMbUx3ZEptTjN6dzh6UStQTjJ1LzU3WTBIa3BKU1hn?=
 =?utf-8?B?bld0a1VCUURkZkNLUC9DTHJzYXM2WThEVk9tNm5wR3RDM1BnOENHU0N5NkdB?=
 =?utf-8?B?Ykthb3lNV0VEN3Y0dURPOGRtR3hGZkNlZVNZNStLTnNqQkY3clZ5UmZxY2tQ?=
 =?utf-8?B?NEloKzBrSUdjSU1UUFhneFBmODBmRHNPTVZsaGVoOVlieG9YVStZSmk3Q2RV?=
 =?utf-8?B?OFNKazV5NDUvRFJaYml6NmM1aDR0dS9zWFpaY3p1OXJYL0VaQUlkcm5tczlr?=
 =?utf-8?B?TW85QW1nYTJLYU14RXZUa2VJbFU1VTh5aHVwQm1CTDg2M0crdjRzYXJmckFL?=
 =?utf-8?B?MEhEMmZSTkliaVMrVFhGdFhTelJSYk0rK0JZTVVZczhxajgxSnBFU3dBVEV1?=
 =?utf-8?B?Vjh0WmpMZTdISUsra29KYVg3RU9nL0o0ZHhLT1lCWjA1TmkyeTZGUzdScC9h?=
 =?utf-8?B?dThyVm5PeUltRmxDYXhpNVVTd21wTDVoa2pkYktGYnNiYVFIaEZQbStGNUN1?=
 =?utf-8?B?ZG9MK0xsMU5PVXpackZmTERiU0d0NU4wQkFSbHZuN3l6K0pXWWhBVmRwd2lv?=
 =?utf-8?B?YjdZQWJMM3AyVTZ3ZDhJdVM2NzY0WDFyVThlUzkrc2RkZkU0N3VEVWwvcGsx?=
 =?utf-8?B?eW1sUVVNMDJkZGd2ZERKYTd5bkRhZjNRZEExbDNndHFxN2FhZkZqNmc0NmVz?=
 =?utf-8?B?YlozcHhzc1AzZWVtbWxEVjlNMEZvUHc0c2hCTXhNNzR2anRRbzg3TmE3NC9X?=
 =?utf-8?B?LzNzdUNqbXMzVWdtbFFTVDZWSHRWR3IxaXViSHV1QWQvZGorQVpvWUJ2TFVB?=
 =?utf-8?B?M1NUNXBzWktOQWNZTTZ6dkxqQXBTVU5CR0hxQTBnQjBuT3Jrai9CWURjQVRl?=
 =?utf-8?B?Z2lRSW9DSkhjQ0JjVDFzaGNQc2hjZXF0cDRudkN0dk4yU094ak5aZDEraEk1?=
 =?utf-8?B?WGpQRFVoMk5IT3h0UGRZQkg5K2R6QU02MUEreGNCSU9LdjFKNUlqdFdQdHFX?=
 =?utf-8?B?YUlVRllIYlp3MjdiRmt6WWI5b3UzRHlxbmtiZUdwMCs0elMyNlpUUklFaDRr?=
 =?utf-8?B?cENia1dySVNoYUhDcUpVMXhNNDh0Vnd6UVlpeDdncytuYWdpTnFjbmMrdC9p?=
 =?utf-8?B?UDRMcEpYS1VDR2QwZWxGRlNMeTJtbGhGM0pPY2I5UDFrREo2enNEZVd5Rk5O?=
 =?utf-8?B?RlBhbGoyYnI5dkhDSTBXdFJNbDJDUGIyeGg5elpMTUw0Q0Nzb0hPcm9xMkVR?=
 =?utf-8?B?eHBzVi9WUlRZb2V4OHY1dVJleGJLVlpoV2N0NWZIME56WFBjZGliZnZ2RE1m?=
 =?utf-8?B?YU5sTjNwZTJ1elQ2eXhqT1crdFEwR05Ud0tJaVE2UGNTanVwSG1ORENkbmxJ?=
 =?utf-8?B?SGpUYlU0dWNOMkRaUlg4OE83SUFtMlpTcUg0UUtnRmNIWktKaHZSU2VJd2xX?=
 =?utf-8?B?UWdiTFNNdllIa3JXa3pOb3hHQ0hSOEthVWVzdGQzT3BjbU1DL0ozVUJyaG4x?=
 =?utf-8?B?TmVNMjZNd0lYbG5pSlByUzJKalY3cFBFSU5PcGxBZ0lwS0psOEpPQVdKNmds?=
 =?utf-8?B?MHBHNHl0RlVnZjJCZ2hYRlVZbXFXamhWN1p2QVNCN0VGSTZ6ZWFBYVdBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGdtMG1ZQml4eTZoY3kwaGM1dWVhUkxacTlPczZScS9UdUhTcDRzeldOZ2dv?=
 =?utf-8?B?RHdWNlF5Y1NoQ3BiR2p5cDFkU1JDZWtpU1g2ODVsYWU4UHdmL25WTnVmR0tZ?=
 =?utf-8?B?OVpLRXhsbjdzRzJkYXZ0dTFmNUM4TTJYOFZmOFBTNVpXcm90eTNqRGtTN1dq?=
 =?utf-8?B?U0hxY25aQklLWEtjVm1mdGFnS0JCSzNDNWhtS2NzakZZbDYwSFMvQmpSRFlL?=
 =?utf-8?B?OVEvaThKNTF5a1pIa20xdG9ucXRVVzY5dDgyMFh1Q213RFRURzVBaWp2N1pq?=
 =?utf-8?B?SW1yWVBqekh1QVpWL2JENEVheksvT3plZG5VS1p4MFVoYXFMa1E3bWFuTVJO?=
 =?utf-8?B?RzJWcVVnYUQxcVBxU3g1OHhxQWdTN0l1TVBvY1Bwd3J4ZEJQZFcrVHJKbnM1?=
 =?utf-8?B?YmNiUnRmZ2J6MWtnNEMyTDI0S2ZyeTA4OHllQTJ6Tk5EcWM5c2hsZjh0aU1Q?=
 =?utf-8?B?Nnk4cWhVRGxaaWhySHVzU1RSVnRsTi9UQ1NucjZ3cllkTkJZUUE5ZTF4UDVS?=
 =?utf-8?B?cnJWQnllUy9oaHFOYkJyeVlQdXlQZVFDWFErYmxERnVYR0JTeFQydXNYcWtq?=
 =?utf-8?B?VExRdGpQemdKK01lbHpDMXB5REhRcWZuVGVjNldPRmtvM0VIS0NzOVF1U21C?=
 =?utf-8?B?UGVhQlpEdWJnMFJOSHVoWG1ZR1ZnbzkwV1FyZVZnWmNaTGpjZ0ZWU0JYOFha?=
 =?utf-8?B?cG9XM3UvdUN6UE93UW9Db3pIUmZ3VEtPWmRsalZvVmFkRXFXYytJVy9UeVEy?=
 =?utf-8?B?SExrRDVEdVhCREgxV2dQK2ZNWWJ1ZVViemtQSDY1WlQwVnQycEwwQWV1dEJl?=
 =?utf-8?B?d1c2a1htbGhGSm15eDJkVDZ4RXNGL3ZXOGtqUDZrQjBYcGVYOWljNExRZndw?=
 =?utf-8?B?djdvaHd3alFYWG9DMVFHUFo5ZEl2V2xwR2xkVGNMajdtWjJGVjl2SVZZa28v?=
 =?utf-8?B?STA5T0YwSFoxWG5SQ2p4WXVYMzJQYnFadW8zc2pncTRhRCtrc0poQVJtcUNP?=
 =?utf-8?B?WFRKVkg4N283cUFmdXBNdExkOTlMTmdVMWhqRUtCZG5LcysvK2c3RFJrZEFV?=
 =?utf-8?B?OXViT0tVU1JwR2puWXVzeGRHYWtmdzJRRTRyN3UxWUJ5N2JHcmxOS1pzMVZz?=
 =?utf-8?B?UC9KU1c5THlHOXB3bkVpQ3FidmUycjZQU09iRXBlZGE5bzJNczBSSFNHbUw3?=
 =?utf-8?B?WFBHTXRsWFBCeTlQblg0QVdqQm1kUjVxcmFhU3ZwMzlhNnJsSVBSQWZnRm93?=
 =?utf-8?B?ZWZ4cWpCVlMzeVFVZ2RwUCs4RDNNdG94bFltTDVNUmR0eXFLZHgwTjhzcTgz?=
 =?utf-8?B?QUs0Q1F5dFVBa1FnNzlveWhoMk9MOFVQNkNUWXZWNmRmSG1IS29ycWU0UDBv?=
 =?utf-8?B?TXhWU1UxMDdlTlE3N1lRbGtWYlcwVm0ycEE1T1YzOFhXekdlY1poOG8yNWU3?=
 =?utf-8?B?R3ZrcmhzQ3pvYlc5NXVQbTBoMi92TFZUVXRrWVFBZ0thTEZ2TElZQ0ZlT0Fz?=
 =?utf-8?B?cWNKL3JUTzd3djFGZ2dsbXJ6MmI4TmxXRzIvZFk3U1NaeVFMMzNaRVFDZ25i?=
 =?utf-8?B?NEpKbDRSLzY0TWJTVkdQUmszTTk5RDdyMWU0dzl3dldFdk5hWHZkaitsb2RR?=
 =?utf-8?B?NHZVeHlac2FkM1M3Z1dCYWpyYkN0YzM1aUxRYzhxLzlob21vWGNtM3NzVjlG?=
 =?utf-8?B?VmNUVTQyOFhjanpZaW1xRG1zM25hSGlkcnB0SXZYK0tEcmtLVmdnek1mYlBk?=
 =?utf-8?B?Y0daUmcrZ2ZEQ2xHUmVOWnpZOXFJSTc5SWt6WGQ4Uk5OK014V3N1WERsOUdv?=
 =?utf-8?B?NXZOM3JBcHlEbDFSbEV5RVA1Ty9jRk1uQTZXK0RBZVNoYjdKMWlFSEc2bEpl?=
 =?utf-8?B?Mm9pMzBvZ0gyTXA1a2V1cEZiM0Rva2JvQmYrS1lXQWFYYjErYzlNSnFpaGVI?=
 =?utf-8?B?bHlyU0IyYWxKdHA4UUpjSDF5VEl3QTZJekxacXpoK1cvK0JydS83N3h3Z1Rw?=
 =?utf-8?B?K0FFcERtMFVhcE43QW9MdlNoVDNGUEhFaFpmRGVWcGRuRnQ3SFZaQXJQNE41?=
 =?utf-8?B?Sk9GdnJQUlY3QXQ2aUNmREJRY08rQTB5Um1jYWd6RUxMWkZiR2E5OFJLUDFn?=
 =?utf-8?B?RFIrOWZwNXdJdlZSYTFTeFFuRHZIamk5U0NtU21YT2JwaWxINHk4U3ZtOHF6?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986365c-1ece-431c-f78b-08dc6844d8aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:06:48.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddjf0LoVYq9bfpfMViIqn8d/Gb3a0/PfEgIXsVcdAVsquBULVZ+sdDenqq9AHwcDygdxMtUJeCekIF+lgq77Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3614
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 12:06:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15775

On 29.04.24 07:24, Rakesh Kumar wrote:
> One of the changes is DEBIAN_PROVIDES, which is required to
> resolve the duplicate Provides problem in secure-boot-secrets
> to ensure that the build process completes successfully.
> 
> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index 2c3c8b0..b098dc0 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
> +    commit: 55833bb33a04fc93eec1c325ee72c298b5bbb802
>      layers:
>        meta:
>  

I guess you meant "PATCH v2" ;)

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


