Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07213109C028
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 14:42:58 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23923.1774449774888740540
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 07:42:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Z/dwFWcS;
 spf=pass (domain: siemens.com, ip: 52.101.70.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecrv/GFkRo6EtmZCk6nnHglo1qUrFx3yhpTIJaUHgAKN9NRfJXl0mt9FaSIi9nhZw9svUm2yjT194SAu+09U/FEQcxupkKE+L3bP6X8sEJ94gKz7Y0ERusAOjkRZTeGUAFw6A6BeTj3e7jwUfO+Ozm0Zk7Ok5ktoeqDLUnEjIwz7xGdC7XneRWDza/sZ9SQSYOHWX5xh1KEW5q3U4VhEH084ZQdSIZm0bUjYRXUpdcYhAXzxc/mgJ1+PgODpSiaz+xBTOucBnD9Iztwq88GHDK3/F+NNvRBxoffahcKj+XaaA2ZVufZuhsf8xzLvnIxwpg6DBnu+gJQ5uREvI5rbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObYBu5y1Uo1I2XB9i1OP4L6FfvLf8FQqiJMHebPXinU=;
 b=iyjXZ7dMGKzS4F9HQn4YVZDj+S9Q3DUXq9+DS3GEJVAlcntq95QPWocDYgeq4sNaBd5LAsQyo9Ht0Ncv3kTgi4rGFsSetqvU9WOk7UAuaM20bvO0lo0pynIhb5eDai41X0VKEkCUoJFLEFCsxivl+6aySfqy/8FUowj8Qf8uOTWzG2boZ3l8eGXXYpRMBrOIByyMoAgYuwdUeaLfXIgF7xeYB4mogAQTw0iJbKQW4fTjiseACdq8dxTXo7Xfn9R557tydCdtPJTgzLFUtja+4vEEfRJuQa5/uH1QqoYunyuqsdE6aTrnjgjgGdWXPLHMxt7fDpj9n326iJlUM7N7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObYBu5y1Uo1I2XB9i1OP4L6FfvLf8FQqiJMHebPXinU=;
 b=Z/dwFWcS8RiMTpYSCwOL0SxXdPmBAIL4Xc9bCt2ji++NBdM/wDWBgFQJsvh2hZ8t8azTHIIlrXaEkVk3+co3WT2d5ffJO5Hk/q3vGHY+hYq/D29vU+XrOTlqfwQVYOi47oDqZ3yIO8GlCwYKWoluPzWB9a8FeZmE6AREBRusbbe7acjK0qccK0m/zM4wmmDscAzqb7L/0okTiNcwxr8LPuPFXK+/8H0IWPtgoPfGKZDjhqJMS7k8trOFHU6HWVnWyCZ53u4Zqxd3lyAbQ7datwbd/0Bod+X0dMZS8UOfLZCGZWh7PgXSV7BFVnQU/r6si63vtGT4QwZI5BDVv3vLpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 14:42:51 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 14:42:51 +0000
Message-ID: <f3a9caf4-d8e9-4648-942a-5a2b6406db4f@siemens.com>
Date: Wed, 25 Mar 2026 15:42:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] chore: add efibootguard to imager bom
 on affected images
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
 <20260325092333.1651628-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260325092333.1651628-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:5b::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3500:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c429e9-69d7-4263-383c-08de8a7cca3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	BFNTLZADQiFHK6Ddwh+zy9p2fIB1ER5rZgSGz9KMmNcJfzcYYGpZ+Q5lyY/mxBj8cT8CIZrUMY/zAwkTmY7VT6hX7m6jnbf8vVYkcKoE7fLPocDtf0ydCe66TveY5wtu1OI14LXWvpKGTdI7c3Kren+IEust4H6u59PBC2P7ZHg38vpr25mu6wvvOhSqOIyn11OB/6l/7Mwk8/QxLZbq4XiY2rEXt6fDo5+zIdnrxezzqicTDpkUvZkB3GEzygMvXYQtRK9xcyTUpIwJouIBuV8WAcMzEO0LYthONwaLViIcQrRgNbdzO+FPMtq1ukzmMCYLsb77cWUuAlWi4LpquBaESyxQfxFWODN0rqpaqrEs/2qk8P4jM8B/6jG+kOYvqExcek4XT56AgSmPU9tA3J1USGX03HrLBMFntySsmAusf0eCvbh6a/mv+5Eubu8dmSPqR3GEhY+TTrdlU4YdcU8r8okckT4svOrFsM3IBijOhPk+finLB3Pw8CytNVQ/Gbt9ItKdW+DWtraCOhiStRQSX4p48kmEYMv/rxsP+W41aAGCSSpg1h8mPqF66YadUs5Mc4Nf4VqcflBdDs0/sKzIX38vbtC75cTx0aYr5aG9wxF03P5l9fHWtHuovXDXxhgbiITGf5GIhP3zdyo3gdXZwxbLVm2yTy0y2Gf14K9+Ys9+6Nxk5basp/pbNToUZ54nPAFANivdvX7vBMtT+Xmpo55Xya0M9T7ouay66wM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFc1TUlCNyswL3prdmplY0FWVjg2LzVoWllndy9qdzRsdkNybTBKRkxYZ2dT?=
 =?utf-8?B?ZWs2SnJkNXdzUU9wZXBCZXFQUzZucGxWbFpQUEJYSFE1LzJvNDJ4WTVZRFZ2?=
 =?utf-8?B?bVpKWFQ0d0FLdXpLenBpckYyNG9FdTlhZi9UZGZnOUFpV2RQMzZzMzQrcmxU?=
 =?utf-8?B?VjNLODdBTCszYlJaZnB1STA3Nml5dGRPNitBU0t1SnpaU1J5Nm5jUHBOTjFh?=
 =?utf-8?B?NzFPN1RnMEx3VjlraHFjdEZLZXFaMkFtM0RqdHlJT0FFTXlZY0xnRFViOFk3?=
 =?utf-8?B?Sks1cERManczSUlCd28vTkJEMVJjSWZ3R25acklGazlHSTRuRlEwUmJjckhO?=
 =?utf-8?B?a1RzZWhFcklSTHBsM3BoUUY1VjJjWGhOTnYyRjI3cWxUaVBHTTN2VEJCMWtQ?=
 =?utf-8?B?RW5CTzhhMG1UcWNRaVFmK0EyV0RoSHpMeFN3ZVZFb2I4RTlUaEU2Y1N6MVpV?=
 =?utf-8?B?bWl5MVgxYXB6eG8zYnlmOVJEU0ZGS0JPNWk4aytEWEhpcGszSUxUMnoyd2ZU?=
 =?utf-8?B?MkZkTTE2YkFCR2FBU0cyMk5kRm9EeFVKNjE1YnB4czhtSjZlRmpmdVVyamlF?=
 =?utf-8?B?MWNOU3c2UGFPMFY0QXhpb25MT2Ywa0o1d1ZkV1dkdW8yU3RsZGoxbGhRMnZU?=
 =?utf-8?B?ejR1bGx0SWtiOVZZQkx2RGFWOFcxdWM0ZjV5Z2FyVEo3RTFRZTI2RjJlWnRw?=
 =?utf-8?B?SWNkaTN5YjBieE5UdkpzdFFPR2lYd0tNd0J6OUZoNlB4WTE0REJzTU5aaENY?=
 =?utf-8?B?OTZFWFNKVnF5UE9yWlpJYytmajFtdWhFMHpiQzRMeXc5Q3hSR0kzRXRaYUhB?=
 =?utf-8?B?WjBFTWIzRXQ2OUFubXlVSmNkMWhtUzdMVlc0YmZDdHFaTEIrU0F0WjlsSjY1?=
 =?utf-8?B?ZnlWSmNCNGNDOGN4QXpXekljQm9Vc2dsT0xSOFdnZllibnJWZEd1NEs4bEt5?=
 =?utf-8?B?Q29Xa1FOcXRWODY5ekdjd1FSejhteUlMTHQxMEVuODNBdG4vY09kaWlsWTdm?=
 =?utf-8?B?cDMxSXg3eFVXdlpWM0FQbkRJVUtWVmhGbVhsb2hQanhuQkpwSmRlc1ZoMjIw?=
 =?utf-8?B?cmE3R3ZQaFhoS3c5RGcyZVlmWFVlQlpBMXpOenVzOFRla2RnVzA2cjkzcXZG?=
 =?utf-8?B?RDZEMG9vcHdXL3U1TmYrd1Z3WjV6dDU4RTd2ZUdvdVV0OXpRbmZNc1lNRnRx?=
 =?utf-8?B?bzRpU1ZaVUlzaXJBN3hSSVppVGpsd3FhNURnQTBVbEJnL3VKVmFVeVk1K3pa?=
 =?utf-8?B?dDVTNkxxVFF6NlVyNHRON2g3eW9uOEgvSnJYeTRObFluK3l0SHN2ZlVIZmcr?=
 =?utf-8?B?cGdyTmc0R3NvK0o4Wi9Gek1Gek9DTHF4cE95eGRQL1N4S2RVKzlxWk1ka3dE?=
 =?utf-8?B?TE5ycDltZWFjYVdCUno4TDBqRk5SVmkxY1NlYSsvRWY4Y0FkUURxUi9Daklr?=
 =?utf-8?B?KzMwakptMjlIZHg1RGxXRHNocWlnSXBIVGpIeHNFbEJDZEdHTkJmNjltNFdy?=
 =?utf-8?B?a0JqUUxKYXVZbVZQR1BEajhHS3NSYXJpTEIySndxNnhOUUNFTWtraHI0c0lx?=
 =?utf-8?B?dDIxeHdqOXBzQUo4YU15aUNtT01HeGdjYzJEbG83MklrRncxcUkzaUpUeXNn?=
 =?utf-8?B?Nnl1c2lWWFZXeTl3SVBXQU82N0c1c1NLY3crZ0pIbWp1NHZHb3RYR0FJY0xR?=
 =?utf-8?B?L2Erck5ZY0x4UkJ5TG42bFBxeFAyT2FxSUtZWk9ablJtWlpFQ3NXYm1HVDlH?=
 =?utf-8?B?RXFZQ29OUWd6M3RCdG4zQ29nRDJMOGpISW92c2lvclp2SDI5VkZDNnNQeUh5?=
 =?utf-8?B?TjZOKzJqekxWVnBHSy90aSt6V2JhZzVIVzE4dHlRcWEvSEIxa3U0NDV2TXhB?=
 =?utf-8?B?dFBkOHBpLzVURHpXenAyYXQwMGw2U2t6VzUwSTluaDl2a1dRTTdWM0dNZ1V2?=
 =?utf-8?B?cEtiQTcrRUJGUDlPYU9rN3lyZjMrNm1FSnh1bGZ3S05HNXdIVit0TURRUXVC?=
 =?utf-8?B?SFhhZUZHOW1tOTNOdWdLUDNldmx5bGMvNlZsWnBRNitrWlVkOFBMVkwzYm5S?=
 =?utf-8?B?NThrS3VaNnJUdUpMZHY3UkVTRkl4Tis2UkNDS25aQ290L1gvbmw4eXo2SGly?=
 =?utf-8?B?OFc3TXdRancxOXVEN3JWV1hTTlM1QmJxQ3ZHSDgzK3pCSUlWaVdwU3VHVmk2?=
 =?utf-8?B?bTMvRVRVdEd6TExrMnN4ZGlOVTRWU3c1a0FRSjhkQ0JhYmFFdnE1YXh3VnUr?=
 =?utf-8?B?UC9aUDdiVDRnMzlDNjArVkhjNHFSb2dFWmY0c1g3VUNyd3pSK3NRS3dxalZQ?=
 =?utf-8?B?aFpxOXMySkFmVjFGRFhSUlhrWWZmWldaYmdBdkRna2QrQ3FtY2dQZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c429e9-69d7-4263-383c-08de8a7cca3e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:42:50.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgMG/nFDWG61nxdvVCzDR6VZ92VSF5u7polB5hFdJpQ7/co33ebqU9DHnLU74NvOjuScRaEarL2AcFUbPZbxWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3500
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 14:42:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22569

On 25.03.26 10:23, Felix Moessbauer wrote:
> Efibootguard is installed during imaging and then parts of it are copied
> to the boot partition (e.g. the efi loader). We now reflect that by
> adding it to the imager bom, which also is added to the SBOM.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/images/swupdate-efibootguard.inc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/swupdate-efibootguard.inc b/recipes-core/images/swupdate-efibootguard.inc
> index a332dbe..2a7afe9 100644
> --- a/recipes-core/images/swupdate-efibootguard.inc
> +++ b/recipes-core/images/swupdate-efibootguard.inc
> @@ -11,6 +11,7 @@
>  
>  IMAGE_INSTALL:append = " efibootguard-tools libebgenv0"
>  IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH} efibootguard-tools:${DISTRO_ARCH}"
> +IMAGER_BOM:wic:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
>  IMAGE_TYPEDEP:swu:append = " wic"

Thanks, both applied, even that late because they should help our SBOM
quality and that of downstream users.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

