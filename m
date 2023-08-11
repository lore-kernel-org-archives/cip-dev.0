Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C91EB64DD
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 04:58:40 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.68])
 by mx.groups.io with SMTP id smtpd.web11.36669.1691729915159605863
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 21:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gVHN/QdD;
 spf=pass (domain: siemens.com, ip: 40.107.249.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUtkYzCzPnPg8ec9A+5rBH5+c+j8El3+YHQMpTb5vAO25QXSN8RN72oEXsflA/vIoHo6ymBw7e6YGHTdxjlBgKDFgc//kikqCF4dhNNllPg/7dLRUQWyUbGj+atAfQBk2Jtx7s69cJr0hWqVpGnzifOb6eSVfRvSMmHA81dJqlucVdv9Re4zuPvXjGdz68GDXdXbP1kJTAyp3RAk4DbefbHGjSqFz7rFULGB4o3soCM+DwzMT3E9x+pZ9o2na4rIqW37bODXHZIJw44WU0IHqOj2pwO7WjnHEia9SpN1n7tOxB0JwaGRmZj/IXJ1vQmE5YOofma4tmdZ5qXB8fwZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol4kITYmNbBoL+mXB3aX36S+Gt1qHncG2sjw36Fd2rQ=;
 b=iaCQvVbdJdMGYKn8SWdGCBTUGQe6vCZChcpdU3bFHYDVyDIXAlxTfpg7DXlGOCPM0Z+2JeQ9zn3ubPdBk4He6TqzcPnhRCEEtFAseHqJDaWfcY8likqjNWqsGS+BcIrHqghzBQ8QVxsBDAKmHBv/Ny+W/WL+DOCLxiAD+Jk+aqQjhM6U3UMj7a4hFayamLVL/bzHnNpSOu9auT8MWB7+QXnTfJwoEqLcc431yjspSGFp+6/z3Zi7qTUPutODp+zDj2rU/RF7kb+3etwgOpmXjGib+icJsb2PKfwbO97AULBv5arFfrtlu8Ffqwy8h0fvrZa0GyIYZq1Ju5POOqwO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol4kITYmNbBoL+mXB3aX36S+Gt1qHncG2sjw36Fd2rQ=;
 b=gVHN/QdDFvCXgenAcT29Qs+jWoHiaDpCYh1ZNClONgbVx2VjES5LDrbRg5mD5RWCFI6CPdjIj7wNu3QCRH1SPlc1A0klE3tyBKsR7x+vmIj6qbsF8ynaTV1Wtj1d8k9dzAfDjfsaZVp04zwU9ycG/lMkeLHFP3zWZ7WnyOi/yCpMUxLEGY7QA+XH4KIN97IG22l+MBv05N2DKB5Q6eUJSbpPMvzEI/dHmerDKKlYNP3SGIdrN4V7eMhOS49S1PpFk9ZXqrx9CHWzZuR5kTVF9vlCb7d5vPSinJXWoicMQmPupLUBW7G8kq1fm64Y7fGqfkl6XhuODWoO2qt4VydXmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 04:58:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 04:58:32 +0000
Message-ID: <722deaff-534a-45eb-9945-b2605acf4969@siemens.com>
Date: Fri, 11 Aug 2023 06:58:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/3] Enable signed Software
 Update Binaries
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: c522121c-c3cd-48f7-6f7d-08db9a279cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z24IVvRhR16neFz2WQ6Cd0CEVjJzxF1PYyMJppNCitBoomHl8ZjUwGpcf1ajSGuTP6OZSE8P4tCF/xHOQoF174tUpcTHF9sGqCj0hOoR93X+dlufOdArLkJ2NnTpt/164H7p81HQERpx/M104MZ6h1Sd1fyqQDhwnejsXhsJXgwIFnzmy7qvrZKaW6Gk7yUXfCM9ZPm/YJLBTVGnmPfl3e+JSx4+6QStSVc3gMHixdgu1NgGsA44hCxMm4itGqT9tJkBs1YALrv/R+A0agENjgqU+0YX5s0Fen/XmkX86osQhvTXP+oZ/97R1ebr/UomlvqVRPDtvt3C5WigkHH8LCmPp6+Lz3dZ5pPDQ1FEowAnqf8SLWHMY37W1tEwm4jPbdbKnA5XswLp8YZaQzeoOsUsxEnXvUEMt8cL/1PM4AXlYnzU1fpgXTwEEdKV6N3GmWx80/cd3Rh7WxnM08o1yf+y4Fxq0HMsTFfLSZw9MN4hY8HPMm+6zsy7ng46dGsNwxgrJRLY8uL1SwBI3Q/oPJjID0GJqDCHl0cmNIv0XbEu+mJ+y6wcCrTRjJFLtPGFVBzd8b0p78w41tEPjw0MgPcVxe/EUIx1OnY5HIFz8FJuhA0EIIpOHFIPkUvFifaUqdruHbUsth/lNQ0kM+E5Gw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(1800799006)(186006)(451199021)(31686004)(66946007)(6506007)(66556008)(66476007)(26005)(478600001)(36756003)(38100700002)(31696002)(53546011)(2616005)(83380400001)(44832011)(15650500001)(6486002)(41300700001)(316002)(2906002)(6512007)(8676002)(86362001)(5660300002)(82960400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXBXR1FqZ2tWdkJyT3pFdDYrNUE1U3hLR3Y5cHVrNnhDVHpNVTZWZjhPdVlF?=
 =?utf-8?B?S0pRUWRoQXQ2aDFTeXRob2hYQ1JkdUZsL05ka3lZK2ZHT3VpNkRucG80dWVD?=
 =?utf-8?B?SjRreE5uNGhnY2RWWWt3TmR2UzVnaWw5QnFiSlZaTWNTSUo4am16elhnRm15?=
 =?utf-8?B?YkZLN2tEWlk3bHpxUTVCS1d0d2RINUw5bHB6VzV2dnFvWjA4bWdPSUxlNnJC?=
 =?utf-8?B?djJEdnZFSFZWQlZEbU9wVnJSZHhhOFhTTEVEWEFYRzJ1NFlEbG1ELzFBNllo?=
 =?utf-8?B?Z0N3enZHYnlBVlcrK3NWME5UNnAwUnFrdnpIRGVla21zSks2K0RYYUlWdnpm?=
 =?utf-8?B?akhTdG12MkFyM2MvdUdhQUlGakpzd1loR2U2RVFuNmk1Z0tDYVByQUZXaUow?=
 =?utf-8?B?UDYrZWM0L1BSdm1lakNwc1E5bjR0Y0I4cExBOVVnZW1ncUszQUxlcmtoTEtY?=
 =?utf-8?B?dFhrRmEySU1BY1JDQVZHWGtQdEtMM3M4RFRNUndHMSthV1RWOVZjL0poYzlp?=
 =?utf-8?B?ZlR1WFVFei90eVdnYXZZN0MyYmxGUmlFa00zYm9ENkNkK1c3WVdFeThpbFVL?=
 =?utf-8?B?aTdKWWpXNkpDRVNSUURJNDQ5aTZuY09FUFJjZ0JkbW5relNJbkN6WlRpd2xJ?=
 =?utf-8?B?UFNkcFc0c01ZUit1WGhLVjZndytGL0VvOGMwN0VaNVJPYjJNSUlZWGxoS3Az?=
 =?utf-8?B?MGN1ZTRUYS81RWEzUWRJbTdpTFFYTll4aDlVL2tCODY0ZFJIOUk5cnZxdVhj?=
 =?utf-8?B?M2JVb2xFOERsOEhKWDhMODJiWXBKWTdKcDJUYU01akt6N0lkWmsyc2dMNTAx?=
 =?utf-8?B?NVUvYVhTY3JmeGZQRzJlWk9iVmQxKzBMaE1WYTFBRjNQT3NURmtxWHhtZzJK?=
 =?utf-8?B?bThjaDlHRnp5Mm9xMzVldVVodjNkajU4VUh6ZU44OTRYVWtXZXFqQ0RlWjlx?=
 =?utf-8?B?Y3pMK2NNOTJLV2tPY3cyY2xQWW5HOUx0dG9zMjNXWWhTTTE2bHV0K2hJZGZF?=
 =?utf-8?B?ZlF2SUFpb0pORVNabk9ySGloK2o5NVNiZGk4eWI2REorOHgvVmE1ZEFya1Z1?=
 =?utf-8?B?TktVdDZSbjl0Vy9xU2RWNHkyU2hROVhYUDZvOU5xOVRDMEhDTFZkT2JlZjdX?=
 =?utf-8?B?SXVJQnFQZXlua3Q4ZC9nZldtQmJjMS9ONVlTNkNRRHJwYjR1R3hPU2NsRlk3?=
 =?utf-8?B?Nm4xc2FzSWlaSVlLc0ZvKzV4SWlJc1ZIQ2h0cjFTQVFxQmtxZTduMGdmZC9U?=
 =?utf-8?B?ZlRIRmxjM2VuV1JBbVArcGx4eEVQRG50OGtlUE95UVpTRGVsV0xJME5HazVS?=
 =?utf-8?B?TSs2QlM4emx3azhPZmxUdzVZS0Y2YWRCZWFESGlPS2xzbG9hQnU0eDZKZ1Rj?=
 =?utf-8?B?c0pVN291MVlsdDdWK25adGtTY0E1VUtxdGg4b1BLeFN5RVZURjBKSlplYVpo?=
 =?utf-8?B?c2RZRkEyNWUzRTNrZ2cycGJXZEcvQ2tjWnRuWVpDc3k4UmIxYnh6aDVZbXg0?=
 =?utf-8?B?cXV5Ui9zSnp2NFdRTzQvOEcvcjVRQVUrQyt3TVRxbTZpaWo5VHp4YmhaL0JK?=
 =?utf-8?B?NE9LOU5QSENyeDViWWhNbGFISjV4Y056VXJCV2p6RVFmV2dJU0YwY0cwaVJM?=
 =?utf-8?B?MWdIMFBlMEJsUzgySUwwVG1lM1g1bWMzOUNZMkxtVG5hUmoyRk5OUHpKeWZH?=
 =?utf-8?B?OTB1MU42M3NvZWYyK0FtT29pc2wzejRDdG4xTUw0T1V1dWFkUjVBeStzcENl?=
 =?utf-8?B?enh1L2duMWkrYUhyUXJIampaeG5VeWdHL2dkK3J3MXA1NVF2NE5LRDhvc0FX?=
 =?utf-8?B?dGRxeDJZOGZJazIwSzhJNGRGWDV0dnhmMGMyWFM5b1VkM01xVnFxN0tYNGR4?=
 =?utf-8?B?ZllTTjhWa0krcjdzRnpoNThoY1B5czdtWDRUYkNhZHI1TlA4Q0dmZ2VnRUE0?=
 =?utf-8?B?WVZrWEdoUFRocWV3cWZKcEN2Yk1tdFhFWmZQRWtldEZPb3lER3UreHN2TGpo?=
 =?utf-8?B?ZUVNNS9qNUVlZGpKazdNTnNoUHhLMUJvbHorc3NFcVJlV0dNTmVaSjNCZVd2?=
 =?utf-8?B?Q3B6MUFDTjRnY1Z3dmxGZWN3MCt3R2NvbXIweUFtUlJYLytUWFdjd0hlRVY3?=
 =?utf-8?B?ZGR2TGt2SGwzOUFxMHpwdnVuRTdTR0RUblF6UVp6NUFkMHE0V0U4UTZmbnB4?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c522121c-c3cd-48f7-6f7d-08db9a279cce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:58:32.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+qpXDrZB5D9xSvgDKXdpxVOODWmUKGKaUhQOGWsoZxzaAo9JFeNP5sYfTIuIkuJGL/+1taGVHQCVDfEHxWOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 04:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12610

On 17.07.23 12:54, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this patch series SWUpdate applies only signed update binaries.
> Also the signing will switch from RSA PKCS#1.5 or RSA PSS signing to
> a certificate based signing.
> 
> Changes v2:
>  - use Debian snakeoil keys and certificates
>    from secure-boot-secrets for signing
>  - fix typos in commit messages
>  - fix author name in recipe-devtools/swupdate-certificates/*
>  - enabled signing in swupdate.bbclass instead of image recipe
>  - moved dependency to swupdate-certificates to swupdate.bbclass
> 
> 
> Quirin Gylstorff (3):
>   recipe-devtools: Add recipe to sign SWUpdate update binaries
>   swupdate.bbclass: Use new swupdate-certificate
>   swupdate: Enable signed updates
> 
>  classes/swupdate.bbclass                      | 21 ++++++-------
>  kas/opt/swupdate.yml                          |  2 ++
>  .../customizations/files/swupdate.cfg         |  1 +
>  recipes-core/images/swupdate.inc              |  4 ++-
>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  9 ++++--
>  recipes-core/swupdate/swupdate_2023.05.bb     |  8 +++--
>  .../secure-boot-secrets/files/buster/bookworm |  1 +
>  .../secure-boot-secrets/files/buster/bullseye |  1 +
>  .../swupdate-certificates/files/bookworm      |  1 +
>  .../swupdate-certificates/files/bullseye      |  1 +
>  .../swupdate-certificates/files/buster        |  1 +
>  .../swupdate-certificates-key-snakeoil_0.1.bb | 18 +++++++++++
>  .../swupdate-certificates-key.inc             | 31 +++++++++++++++++++
>  .../swupdate-certificates-key_0.1.bb          | 17 ++++++++++
>  .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++++++
>  .../swupdate-certificates.inc                 | 31 +++++++++++++++++++
>  .../swupdate-certificates_0.1.bb              | 14 +++++++++
>  17 files changed, 160 insertions(+), 17 deletions(-)
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bookworm
>  create mode 120000 recipes-devtools/secure-boot-secrets/files/buster/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bookworm
>  create mode 120000 recipes-devtools/swupdate-certificates/files/bullseye
>  create mode 120000 recipes-devtools/swupdate-certificates/files/buster
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> 

Ok, other than minor details I adjusted, this seems to work fine. Merged
into next.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


