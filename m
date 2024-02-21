Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DABDC48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 09:07:56 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.83])
 by mx.groups.io with SMTP id smtpd.web10.9235.1708506473949435822
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 01:07:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ExIc/HVs;
 spf=pass (domain: siemens.com, ip: 40.107.247.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MioeYzTOKJhFDyDLoTUKw/tXc/zmcqF0oeeJrhXfQxxNpZhM22m45AyNRjvpyHIaO2ws3K5UkSzb6Yenf5JUIJCUbIGk3J1TJUVnhVBbFQgXCeZJ51GpHGpbNoaERngtq/Mfsngw7Fdn3N77Mv531wIbzYfuJhuXwS3Zzw6Oi9gfIpnQGz6Zl0HAnBiWEgvJC7qUyL304Akr+iJOGWs9JL3lL47t+Bgx9U/PUK1r0cpz+O3Rt5ZNuF+eQbrNZmdzPJdXjibYlr4+YixYw3MJpqD1Quf5Pu869//cpD7Kg9ROxm2rHrCoTM6RS6q8ZYyFpRU+9EnwZh/5VWV52XfFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtGeaDsZODU9Y8zVKJMuaWb+3xH3rxE5sBUo9QSQcTQ=;
 b=Di3KVvKtv3hb2xF7ai4rBd3a7KEsP5VKy8hAwnl9kZ9+YONA/cfs7FEyYIZlKlpR5KsNBWtbUl1vsBSI5hj/OywRocpVjVsc7NXOUoZKvmCBPJ/E0Hc/nx1YLeZ3ELhxm6sTm6ejK+F6r7nOMq2lCpLrB4Ul5u+1keTxwF7WXrV6wJx98E5Dc1HhfIqJ3XU0V1u+YCfbT/VeCLi1FcCw62yqWdkhhW7vbJas3QzFHZyNKZNg+KIXSi0FZcBuWTO90Q6wFRtvriOCztw49bK1yQOwgi0oaXCwwzTJYBJcw/WyEkq1q9A292SRve7Mg8AYqRlP8q8Z003kSD6JIrvHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtGeaDsZODU9Y8zVKJMuaWb+3xH3rxE5sBUo9QSQcTQ=;
 b=ExIc/HVsaDDi4CL2FegdIvWfuh5MXNrfkyxSMIob+LOs1TGwxnMx+vgC6CNFQu98A7XX/wdxGD+ISppi4hfVAauqKN7akS3eSjR60rFmZsVzfIwOda00dvCurFlOwe5qARmY97aNqGpvn73acgtXoT4PacXFdbGq4cIqKoRVYbZxa9dEVfVyWBhO4tCNnGRiwHOYdkI0vTCB7i4tFpVODu5DCOR9KBIyCl+YYc1wFUFAzO3ui3h9t0H1iDECiFlfyt1Scx7wTkLYEMzHbjwq+3s/FJNR0R/1iwDFV2dJm273nmMB5epaqIVO4lZf5GuUInCUjZ9RkIHZCJGAPy72tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 09:07:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 09:07:48 +0000
Message-ID: <a08892a0-3b69-4fd2-8b01-6b37bc491c7c@siemens.com>
Date: Wed, 21 Feb 2024 10:07:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare
 boolean variables
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, Cheng shu Mou <chengshu.mou@siemens.com>
References: <20240221090005.54520-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240221090005.54520-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3880:EE_
X-MS-Office365-Filtering-Correlation-Id: cb51ba62-a5d3-4209-d91a-08dc32bc9352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GbZlmBer5nv8Bt6O+Ru4lxk5hk7bs/kuf6MVavqCcQ73JgLoBxhTnVrTyLNMS7C2t8znEH+XuqJ0ZuZm8cwMpbwFxmh0oLd047cMwOHasMnG7UG88LJ3cqAn7Ih/rbiEk33Xj825o9afpmAekGCvKald656AwYuirh7waNlua80KypliR/h+iEpfViBYOsBDaDhuv8xk41IQvlcEXM5QbK3ydcctPVpBQ0PQryS4m/jfJeKvu2c2VEgGmpaAKcrzPAnhAQtJq8r/m/WN5ae9Vptpo/dWJ6uzLITMU7HFi4BrCIxvWJAN9y87O9DcrzLOssh+mXOqGfu8t5grhKLm7k3mO30gbF+xfvR5J7OiujFWMb3qJIyoyyGs49AEPspY6gHQ5bFqBclmMYQ0VJKNCN1407Rl+TK+2aqRE9cugTD/WClDpoDv+fwyZI2u0A+QYXWS4ln54yOmzeQ+LtuSsvLmXCnfItKyZ3bggXTFN/GdyAh+flDKZmv2zdwsv9YdianYEYktH28OCsNH+/399xujnhz9O/xabM3reehCr3E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVp6U1pUakdPQWM1NUhZL2g2ZkdkcmdiK1RRYUpqb1RscDlsVW1tRE9HQlBl?=
 =?utf-8?B?NDc0cC84blJSbSs5RlljWG5zVlAwZ1B5UWpBRDF1NnpiWGJYY2RqQ0NRVVF4?=
 =?utf-8?B?UTNLcTNHZWFvQXJoa0lxcS9mWFRSK1oxMUpER2N1Wm5OV2dSV09tbTljSk12?=
 =?utf-8?B?ZUZsQm1tQkpwRGlpVUhGTEx2RjF3K1JOWG9mZmQ2K3g3TFNFY0p4cHgrcHY1?=
 =?utf-8?B?SnhHejR4Wmw1Qnc2aEJBSVBidFkxRzRrQUdQd281R0pIM3Rhb1VCTWJmbjNQ?=
 =?utf-8?B?QVdjSFMvN28yM01wLy83bUIvc0dpZk54aW1zYllDOUZXWjNyaGtzM0ZOSGRn?=
 =?utf-8?B?US96T1BkejhScUxnU09kTC9qa2xUakhxZGFOV1M0UmZzTVJkejMxK3BCckdG?=
 =?utf-8?B?dDkvVzBuUHdHb1VSQ1RvaDVLN0t2eTF1by9FQ21TWjRYMjg0YkV1TkR1bDI1?=
 =?utf-8?B?N3l3UUMyUFhKTVJ0dHJhTTk4eDFRNEVydlp1R1k2b1k2Smw2TDBGVEJJSVB4?=
 =?utf-8?B?aEhyY2c1bWdIWk4wNnFoVGxvclRTTnhDeVJvdk1mcUtOMXZGQzNqNmhLdHVW?=
 =?utf-8?B?MFZFdUhyam5LbkppbU1oT2tPWmJsWCtjbDc1M2NDZnArUUJyTTNicTNmd2Jh?=
 =?utf-8?B?clVpOG1MRzlhUCt6aXV2Ykk5ZHU0MVZLMVh2ZzhXeG5vMW1OdSsrQlVrUDd6?=
 =?utf-8?B?OGtnMDVsMGdNcmJ3cVVpb1B4QkRNYk5XQ0ExcFlEcUhGR3JZQjBuWWRFOEk2?=
 =?utf-8?B?a0tyYW5PdkZ1aHV3eEVXRU4zRkR6ZDVJcXZWUThvYTFiV0xSZEc2bHg1SmJt?=
 =?utf-8?B?dnNGSXNVQ3FoL29WemJybWJSbmhOR05SY3daczF5MzdnRSszaHZlajIxenhw?=
 =?utf-8?B?Z0o3bEJldTRNUEhPZXBRNEJXbHkwVHJUR3NUN1BuZG1rWVk0VmZRejZaWkRv?=
 =?utf-8?B?UjRBMWxZc00zTENpSEErRXEvQzVpZ0R6RE1WQkJuN2NkOFlqOThCS21BZGhR?=
 =?utf-8?B?K0VEQ3BhWjJwaThUTTVkUlhpTzg1Q2I5TFFIZkxnRFMxcFJLaFY4NSt2ZDFC?=
 =?utf-8?B?MzdqL29ZZWxsVWVBRDlIUWs3WmZQMElzRGRnUlFJQXJ0K0ZlajNBOVlLZmRF?=
 =?utf-8?B?NG1BaVRTQktCU2R0RmprTDhMOXlzUktsdnlVQlRCVzRPYUV5MldVRnAyYWVJ?=
 =?utf-8?B?blI2UWZRcVFkaCtHTzc1Z1JzVS9hT3g3VnBwMkliWFVTdHp0ZTNBQjBIV3A1?=
 =?utf-8?B?SFk1eE9MWXdEQnpqbmRDVjRKK2o1S0k4cklUL0c2VFRRNXZTZGNBYjlLTENz?=
 =?utf-8?B?Q29DK2o4cjMydGR1K2hEdmQ0S09XWVJQaFAvS0RjMTB4czFvZXlRekhibGN4?=
 =?utf-8?B?SWJKaHpuR0x4T3dDd2hwNlBVOGJCYithbGxOTjJFWmV1SldrTFVRUm4wb2Vw?=
 =?utf-8?B?T29nd0ZMOXAxNmEvMWdwL05LY2Q3cmNvUnd1RkdoczRhQ3FONEROZjZ0aWpt?=
 =?utf-8?B?VGhTY1FoMXo3MzgvN2t0aWhnZmFvZWhUOGNKeGJLRHVFUDNXK00wVHU3bmxk?=
 =?utf-8?B?Z3RCQ3RRR1NITEI0Z3hXcXdMZGRlWlJGWGdwWmI0SmJaZ3NIdUZEdW5SSEFZ?=
 =?utf-8?B?bEZkL1h1dzJPVG1Vc01GMzVsaEw2M1NrOFZISjl3V0piWkkzdnZXdzlZbkV2?=
 =?utf-8?B?VUZCZ3FBd2dwM05NNDJ5eUlqemlJenJBRnduTzJadE91UC8rQmxxSnA0U3Vh?=
 =?utf-8?B?OHhrcWxlSkxhS0owSHcrRW9xR0htQ0EwbFU3WWlaR09EN285Nmt0QzBZZmtX?=
 =?utf-8?B?VlZPVWdMMHordmg2MStqSkszK3B0MDdDSGttUC9CZzE1UUc4OU9tY3V5THRi?=
 =?utf-8?B?dmRwbjJjcmRTRlVOZjNkZkVtM1lBNllwVnZyV1ZJVVM5WFl1M0t0eGw1YlJx?=
 =?utf-8?B?TWtjRG5GeFJNZjBZblNRZHpiSEgyUnNzUXZQdHBKRE9lMjhuZkltMURxQVFi?=
 =?utf-8?B?UlZUY1FlUVM3Z2xKRktlUXV1eEE5THk0RThrNUdZWWsrWDl3YzRLc2Z3ZWxY?=
 =?utf-8?B?dFQrK1Y4dEFNVFFlVGx0ZG9SOVozbkxmTUNKN2tWVGp1NmZrdGRYb1lJK2xN?=
 =?utf-8?B?SmJZOG9VcTQ2WGNGckJQOHNkbXowOFgyNW54anpTckVPemlnRlI4ZnZmLzV4?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb51ba62-a5d3-4209-d91a-08dc32bc9352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 09:07:48.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JorXl4mMdEdrH9YddEpnt4DGMvUFHnvgh/Yj3UKzfk7y4saHxjCn+4h5oKWADftp4uyktZzp/wrEW3j9fDCqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3880
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 09:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15045

On 21.02.24 10:00, Felix Moessbauer wrote:
> When checking if boolean wariables are enabled / disabled, a comparison

variables - no war, please. Can fix up on merge.

> against "0" or "1" is error prone, as a user might use other values like
> "True" to enable it. For that, bitbake offers the to_boolean.
> 
> Reported-by: Cheng shu Mou <chengshu.mou@siemens.com>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/swupdate/swupdate.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index cb1716b..7a4214f 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -23,7 +23,7 @@ def get_bootloader_dependencies(d):
>      if bootloader == "efibootguard":
>          return "libebgenv-dev"
>      if bootloader == "u-boot":
> -        if d.getVar("U_BOOT_CONFIG_PACKAGE") == "1":
> +        if bb.utils.to_boolean(d.getVar("U_BOOT_CONFIG_PACKAGE")):
>              return "libubootenv u-boot-{}-config".format(d.getVar("MACHINE"))
>          else:
>              return "libubootenv"
> @@ -32,7 +32,7 @@ def get_bootloader_dependencies(d):
>  DEPENDS += "${@get_bootloader_dependencies(d)}"
>  DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
>  
> -DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not d.getVar('SWU_SIGNED') == '1' else ''}"
> +DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
>  # deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"

Are these the only cases we have boolean-like variables in isar-cip-core?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


