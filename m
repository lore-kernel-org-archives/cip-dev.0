Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFCD78786
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 14:30:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17937.1766154638640799560
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 06:30:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WrUnj7PI;
 spf=pass (domain: siemens.com, ip: 52.101.65.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld54csPf++jHcRLdJ785RfDd8u6MmEQVYFbIXv1/gsPkG8cTFxDQY2wTUVebeJSasd/nxSyaNEUD4vf7sisJikajGzpJgCsvUr8YwiWui/PkVP8Fhl/tHSlqOZkZ3845B8546KAriOY5f8X4HD7DqaEolA0s4IzKqnvNlX4hvB3vf5pc4RNMbQLJrsbA66dfPHIa4/xcr/jCqRzjWHJ9Qcy9klgk/ErwNyMjQtq5z2h+X7HqosCaZ/Wp0jXCCZbnJde2RHlyGIfaV5Bn0+mEpS7IxUqGCf+r1V1JQUilxJZcuFLdpOuuOIQFYkY6BNXTfYGzCrblMUISw+JvFYSeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/2h1l/5DPnCflWE3loGdlMswn7iDE23zhDY6Nbrm5Q=;
 b=jlLHYpTL275aB+h418qjtUcVefUPJ0ix0GCMGLjRzaT84q3zhu3ACuyjLAz/AgYxmAAELHPm2c30IJy561ZKUiT8stqiyEBmxv+f/x/SReUX3HOR9ueZJDjYQWQSagnBaIQ6yqH+0leXD5GzLfMvGtLS2gHsfrBiZRDklio4ClwYVjR3bhN7ANG8aOGtH9JUAiQJegyFveb7I5sK2sGat5iDFcEQKY4yriYNp/6vDtXxwK9tEo1lhe6SXK1U1zFsKm0Z4KDl5DQk1cuEISmQkJrPj5VQ0ztmx89p0Vn80yulNKoVGxcejgMtYyQIsO1V4yJlJY0CgDaKm4oSk4I5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/2h1l/5DPnCflWE3loGdlMswn7iDE23zhDY6Nbrm5Q=;
 b=WrUnj7PIxfrzhGQL4RqNOt3pN6IKvBSvA6oWNe/654vyOsrxTb9F2Cha5a6x5yBYINwVLHoz80ihWXJLGmi3Se6hYmTMym3+4YF5d9RlNzfo5iUb11yrTpMFfvrbp8A+fF3hMHyGQC6P+9ILCT1Sgc8fT9I3GGmp4ehbRsOuWL0LD7h9CbYRxa/YiHsqOyW4HSfmVUv9sgu8iOaAgpClhg3zQRhqTWTaXMCxYeYFKpjO5Yu8RK78MQzDZHN/MT5ZiNiFncEkEHxVFa2GUZ/Tt1AxZhxWcANtE51oqa8ObPBDC3RnyTRFXbXbpqu7TGfmsMMbqY3rGkGANPht290ykw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 14:30:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:30:35 +0000
Message-ID: <25dc0f6c-e450-45cf-b1d5-f7b9c3c09a62@siemens.com>
Date: Fri, 19 Dec 2025 15:30:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 6/6] Add documentation how to
 integrate isar-cip-core
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
 <20251219103349.1227710-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251219103349.1227710-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7354df41-2246-483d-a00c-08de3f0b2c0d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aVZpVzI0WVMvKzJXbWFqdUxwRlZ6QTdZSXQ4bDlyZ01KclJWMy9jZkxPN3N4?=
 =?utf-8?B?TkMwRzlSaTJaU2dPdmJkakZ6VmNLNUhoMVRQaWpjT1Q4ZGkyNU00T0xsOU9Z?=
 =?utf-8?B?ZXhubzh1ZThSRFI2ckRjb3Y1bko5NHN5S1NOQTJNK2xBeVRBQ0pPRUtNeWZn?=
 =?utf-8?B?ZmRDVUlyUTVDVkNneEJLbHRBVU5lY3dhL25pWHJEM0x4RkhXODVrOTJydk9j?=
 =?utf-8?B?RDVudHFCV0lTaHB4ekF0ODJWYnEzNXZoY0lDeVhtMUgvakVLNHpZSFdMRUZy?=
 =?utf-8?B?TFhYSXh0TjJRd052VmxONWZyMzQ0VE45NEh0L1BEL0hMcG40YnFmV1RSQkRm?=
 =?utf-8?B?eVVBN0lSOHpUWitjTUZBYWtJdVpKZWI1NG5GdWpVTUdIYlN1bU9ydmtiS21t?=
 =?utf-8?B?RGlsR1RwbXBydTdMUE1lZm1SdkQ4VzV1d3hzK0pFeHc1SnpMa3RtLzEreXZs?=
 =?utf-8?B?SWg1dTZibGx4QncxbFRLSVBmdzE4emhPNEpNNUpDYkVsSE85MlVWQVd3d3RR?=
 =?utf-8?B?NjNnZHVML1FDZkt2UTh1Ykk5bnpvbmNzaUZtR21aV1hjcWxzdXJ4SmIvVEVx?=
 =?utf-8?B?Wm9IL0hGSDhHWjFTWndjRmRaL1A5WDVkRmhOVkcxRGtJWHc5MFNtN1ppQ1l0?=
 =?utf-8?B?ejR6azdJU3RrVWoyZnhvMWkzQTZHQXlRblA5V3hiS2d2Zzl2bXNGN3Blc1N2?=
 =?utf-8?B?OVZPa1Z1eWQxT09ha2o5Y2NwbXdxd3FmWmhTTFNzZzBVaTFveFEzUStHY1pZ?=
 =?utf-8?B?UFd6R2owN0d6VWdWUEloTTVsSFFkdzdBTnRHSmtoaWZ1Um1Vdm00TG5pbSs2?=
 =?utf-8?B?RjdOcWhwcmFKTTBrTytLWFJyRTNTL0VuNUVCRHFVTGRBeEZwR3ozWmpsUEdC?=
 =?utf-8?B?OEUrSlBFZXpuVkh2V0dTS2hQNTNhbzRXTkR2WHUySlVHN0VsYjdTZnd1aWxi?=
 =?utf-8?B?OUVzdkJNbDNCTDFzZmVqQVJMWHFvY1UxU3Q3ZzdhM2RjM3E5MlB0RS8rMVdX?=
 =?utf-8?B?Qlc1cjRhM3MxQm1DOENQRlEwTGFjOU1vYWV4eFBpblZzV0hpZXFxWDVmYVVN?=
 =?utf-8?B?OGhlUS9rRzlRTkdZL2owRHhBNlRNakpqQUhUVDY4M2pMeEJEQXFoWWJsbHA5?=
 =?utf-8?B?QjAyRndZcjBiY3JsZDBKei9oVzB3QktWSTJrTTEwdUROQmdYbjVsZmpQMkFN?=
 =?utf-8?B?U29CYzlnYnhsdFVnTFhCQ3hYVEY5MENQZHlvdGRCc0xjVnlTR3N0djRUeGFh?=
 =?utf-8?B?UUVIZ0RGazVGOFV4VzVCRDVGVFdqQjFCZXhTdUoxT0NWbm1DWTAvNHdnNWlL?=
 =?utf-8?B?NFVLdkN6bS9CMGRmekdsSXlDTStkTDhxaFlxRVVFTC90OE1uOGJpb0JWcFpl?=
 =?utf-8?B?blUxVXFpbDdCZjRySGhBRkVLRXpDR0NwNDdCWmVYZUM0azIxVmlhZXFKUjRY?=
 =?utf-8?B?NkhjV2NuWDJTZ0Fxblg3K1hpMUt3OUNnN2ZRN2pDdVVlNXptTCswbFpONDN3?=
 =?utf-8?B?OXkyOERHM0kvSkZuREs1OW9oWUhNbXdNMzNpT21FVC9rV201YVBPYnNTbXR4?=
 =?utf-8?B?cDJVaXY1dVRneERxK2tyS0x4RFA5d0NWMVkzQWpEbHcxY3ZtcThzZ25qVkFx?=
 =?utf-8?B?d0RuVDk5YTJUOXhjcjlaVU14bzllUEgyTE1VYklDVzgrU1Z0b1VGbkx0WTF0?=
 =?utf-8?B?TUo1L1pDK2tleGJNUmZhQkk0c3c2KzArazZyaU13cWp4UmM4blE5WnQ5a3Na?=
 =?utf-8?B?cm5RTVJwaFhRQlFWQkFURkhIc1dWREFzYmpmMjRUdkk3Z0kveTdpU2Y0Wk5w?=
 =?utf-8?B?YUQ2ZjB6c05xRjJnaEd2dWV0aGljVTcwcXRXa0hLM2MvbkxJQWt0bUIrVnhK?=
 =?utf-8?B?SjFQUmEyQU80MnVkckVBc3cvSXJLYWhRUDhuTG1rVUpqOFVhOUFkcEs3UjdN?=
 =?utf-8?Q?vqeM5SGbsqrDq5bpoMs43EpRb11vrJ3f?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjJGT3lNczlvYjRJTnZUcHA4TVpyY29EWVdlZTZIVGhQQUh5aGphWjN1T1NI?=
 =?utf-8?B?ai9OQzhRZ2xHZ0VSSDlLVmE1R2dDQ084MkxpOXl0Q051RFZGd2JYTklwRGNZ?=
 =?utf-8?B?eEQ5cjdIL2NOc3RZaWVnWmRLYWZ0d2k4UUpGZDVyd0cwNkFINmNKUFZLbzE1?=
 =?utf-8?B?SHhnZlFoT3BsN2VicTNvaWRFUm8rZFJodGNIaUcvcDZTVVlXNE50UDh6UVNR?=
 =?utf-8?B?UThpMUdENG1NOWtZbFJobGE0UjhIaTBFcHExSWxVdnNsV1VnYzhxaWNIMDhC?=
 =?utf-8?B?bjFBNU1MaWNkNlZMQzNLYmI3V1A3MnluREhsUHA4dHY5SUtpRkJZOS9ucFRP?=
 =?utf-8?B?eUdHN1I2Z0dpS3VnS3pEVVdOZjU0RlRiWW8wSlp3Z1U4MFVwbSs2WEVaK01U?=
 =?utf-8?B?djBja25sbzY1S3hyb0JTYWNUY05nNFQ4L3pPUy9jTDJIUG45SllhRGpQeW1L?=
 =?utf-8?B?cmRId3dQdzQyWGtPcTVhSlJodXNuNFN4My9sdGdSd1ROYWcwUWNvTFd4MEJL?=
 =?utf-8?B?aVNZbmFTR3ZOSGtXZmtEcnRkS2phVzZVUTYzdStSL1ZxUURHWVRkdEg0eS93?=
 =?utf-8?B?N2tDTFJXS3JjSU1iVFMrWDZPUFVwTlBiUU5LV2RzVFA1NGJKY2x4YndyMG1i?=
 =?utf-8?B?ajVUZG85L3NPY0xKWVVqbGdOdnZEZXZNM2ozMGt5TDBpeFU1ZGk5WDdyd0Ru?=
 =?utf-8?B?Z2pUc0I1b0FyUUtESWkvM0lyWkdiOFgzZUtJK3ViRzg3SEhlam90RERZVEFw?=
 =?utf-8?B?N3UxV0VuTGxFVUN2LzNQb3JaM200U0ZhVjB6S1N4TnVGSWk1alI4K0JoMVdy?=
 =?utf-8?B?Ui81MmZwbWNRWnlYSmhhYk1ZUGFoL3J5L2tmdGxaa2FQVkxxeXF0aXFwaHBJ?=
 =?utf-8?B?a1M4SFpKT1VuUkRINXVHWHd3aDNzL0k3dzZHUnhWcDROUEJSSjFhaFBac3FV?=
 =?utf-8?B?VERqeGRyeFhrcUpyT1VhakFlR20yT3J2QlRCNUdIMTJQVlRLY0gyOGxDREFp?=
 =?utf-8?B?NlN3ek5JR2xkODlMMjFsZllybndWMFNsTktpdGJ2WGUzQnEyU292dHVYZ3dx?=
 =?utf-8?B?SEZwMEFFUU1YUDhJa25oR3lkcmZsQVd4dWhDVXJZN3RkNHdGTjFJLzF4UnBM?=
 =?utf-8?B?R08rb2JRT2dIWDdWZ0g4MlZOUUhZMkEvTnQwNlZTZ2hBQnZFT1pFZW9sN1lu?=
 =?utf-8?B?NTh6ZTAvYVRuTjcyRElPcHN2em5Ka1ZXVnJ5dE13ak9zUFltMzI1NHY3c2Jr?=
 =?utf-8?B?RnorMGhNYlNBM0JVc25GZnltK041aUdqdnVzMThHVG9UbExxZE1JaFNFVFlP?=
 =?utf-8?B?SnZVL0NNTnRtRUl4NEF4OTFDNU1Hek1CWXgycUEwS0NWdGhGR3J3a0ZHV3JC?=
 =?utf-8?B?dlJ3RTc5cFBnSEJCRVdLNTQ4NWVmUHNkMDNPNmlGMjRhN0ZCTlBjNHdmdGJY?=
 =?utf-8?B?eWc3MVE3Vk96SlIzUCtVa3N5UHVNZ1VrRG1OeHZ5VXBqaXIzT3N2bE8yU2ZW?=
 =?utf-8?B?WDc3M3F5MmM1LytKdlJwcTQvUGw4ZVUzOWlwVTlURnRUSit1UWZoRFJha2pk?=
 =?utf-8?B?RndWdDRKUk5uMy9YK0Ntb2V6QStlaTQ0RDNoMURJUkhKRDlkTi9mMGt3Yktv?=
 =?utf-8?B?ajAxU2EyYi9mL2drSExrMG02MEJBWnRreHNONHhVV3k2dTJFMXl0RFhWUFBC?=
 =?utf-8?B?U0VCMVZYc1RtSUFWRUg2cWtVVzY5aDNNaVZnb1AxdE5DNlgxN2luNi93Vmw0?=
 =?utf-8?B?M2RZczZZV3Z4WXptVnIrK0p1YXk1eW1PUmNBbGVheEFxSWF0NFAyOGNzcUtE?=
 =?utf-8?B?UE5FS3hCM3QxdFZoWDNGZHMybFc4V1NaOVlWRUtkd09Wb3hPZkR1VHdaSUlK?=
 =?utf-8?B?Y25Damt4cS9xemNCRkZZbjYvOHZMdDVLcDI0NkJaVStmbDJjNkZBS0tkZGh3?=
 =?utf-8?B?OEY5WThGMVZYZFpSK3VEaHJzZ0lDQzljVUFDZjBLRzd5Sjg4dzNUZkl5THlr?=
 =?utf-8?B?VURmUVVpK2NjcEl0RzllaWQxWVg4U0F6aVZuZndFMm85cmtUS1dhdmt3b3Bp?=
 =?utf-8?B?S3pVTGQ0TzRROXBpZXVmRWpKb2RBVXJnaW5GMkhzYjRHclh5ZkpVKzgzbWRp?=
 =?utf-8?B?SDJZbDRrV1NBclFJcWplMmhyallUS2ZCNFE3QjVTa2FrT0I4T3F1LzJ1cmpq?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7354df41-2246-483d-a00c-08de3f0b2c0d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:30:35.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/NlOqqQFq9gV6HiCn0iFaWmlK1rFLJFdyKm/X5kHrXzV6AK77+LAXnPY2zF+KPSsb6OWzlqtVtil9kz1ZcWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8402
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 14:30:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21181

On 19.12.25 11:31, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.usage.md | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 doc/README.usage.md
> 
> diff --git a/doc/README.usage.md b/doc/README.usage.md
> new file mode 100644
> index 0000000..b11152a
> --- /dev/null
> +++ b/doc/README.usage.md
> @@ -0,0 +1,55 @@
> +# Integrate isar-cip-core in an Isar layer
> +
> +This document describes how to integrate isar-cip-core into a existing isar layer and build a
> +A/B root file system which can be updated with SWUpdate.
> +
> +## Add cip-core to a kas.yaml
> +
> +Add the isar-cip-core layer to a kas-file:
> +```yaml
> +  cip-core:
> +    url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> +    branch: master
> +```
> +
> +## Configure the root filesystem for A/B Updates
> +
> +Add this line switches the root file system to a read-only file system
> +with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
> +An additional image type is generated with contains the update artifacts.
> +
> +```bitbake
> +require recipes-core/images/swupdate.inc
> +```
> +
> +## Create a image description
> +
> +Create a new wks file to describe the image. It is recommended to use
> + [wic/qemu-amd64-efibootguard.wks.in](../wic/qemu-amd64-efibootguard.wks.in) as
> + the base for this image. As all necessary variables are set.
> +
> +## Set variables
> +
> +Generate the uuid for the root file system partitions. These variables are used
> +by SWUpdate to select the update partition.
> +```
> +ABROOTFS_PART_UUID_A = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
> +ABROOTFS_PART_UUID_B = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
> +```
> +
> +Set the certificate source and mechanism to sign the update artifact.
> +
> +```
> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
> +PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
> +```
> +
> +Set  the variable `OVERRIDES` to `:swupdate` to customize the initramfs:
> +```
> +OVERRIDES .= ":swupdate"
> +```
> +Set the boot-loader to efibootguard which provides a mechanism to switch between the root partitions:
> +```
> +SWUPDATE_BOOTLOADER = "efibootguard"
> +```

But this is already the default - why setting it then again?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

