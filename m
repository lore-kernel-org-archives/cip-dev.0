Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5505FC30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 10:08:05 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.67])
 by mx.groups.io with SMTP id smtpd.web10.7097.1720087677940237117
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jul 2024 03:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KYo8f7Zh;
 spf=pass (domain: siemens.com, ip: 40.107.21.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA7QJOp4jhGShFhFz0pbGPFgnbF4Sow3qufjgW/n+BN3EO84vOnQhlCoX8T/Yf7hln5zILYeNCLmStPUV43iuLZp+3bbqBJrENIvxtzYCYPVvHlyaQWlG8W+3vKXKMRJcV/0awAspStLDO++w/P0jF5nb279uubfaG8YG0G0QlqBbb3d6kVXDQm+OSemKFSpaycM+5FtASKXZDHAFw8qf1Dt1Gt3KluXDkvACML73SiBRAOlxIONycKURe13IljPAptBPmIdJ5pog3CWafNzlfdyQNbx/GmaA2b+LQth28OiTt7x/kh5GwCKY0WwyUu5wge3Zn96DinfLJQnD1BkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu0IiLUcP3N1A0cjMpA6vyrQpwfsTtyR3SuRKCL0Ti4=;
 b=HgpzWaLmBH7TPTAeU3yy+yOkpxUyc6CNQXGuQrjuTVVDIW7JSBu3v6Rmr5cenp0CuYM7ej5gAOwocwroji1C9/qZKZgDmYGAHXqyVoq7FsGgZ/UIKZ5ReBqminfmJpA0nXyiy2dU/D8/oXL8pxN3/yMnZWw7EYIGkoibqCCZ8l/VGOAR05RXNL3A/PuveGsKVGfN9TRFQWuspmm7U4lz21jwqev8X0/BCOD0ijfGcj+sIVzSLtysxwc6M5N/Nsp7uHjv0unvag7nq/QWpICaC6OsSfKL6BTFuxCUNQWvQSDKaI0xqo1WwfGHWN+b1G0t0uzJb1wVMtn1c99ViiYE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu0IiLUcP3N1A0cjMpA6vyrQpwfsTtyR3SuRKCL0Ti4=;
 b=KYo8f7Zhm6LDb5v1cxiffP8Ti8l/BCYZopFPnKkFtGfTyBP+YoJki6D9AVbvu8Eor+xhhb60yKd9DlG+Q8fxaRg1zVjh6PAPfgMNN5PM4u+0kPbembVJELKhUSF6l/8OXcdl2FmahMP2lZHm4xOLtuGZDwcgu2uUB5Q4UPK+uzkGJgFnvuAiYgHseKmKVySFFAyDeRguEpMnO38mKJHWhEJfoZeIbLcxAycKGzIB7TdhBcgLksUI3dvCc3vjISEShnT1mfbQ+LwQ91FeGQ2L62YoHWeIUNl/ejqtgR/gMGdffxmXEVzyNCK2Kz4bsN4OLFJt5tOCrrQwccunw7l+jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 10:07:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 10:07:54 +0000
Message-ID: <68a430ab-afc1-4594-847d-bd823d44f965@siemens.com>
Date: Thu, 4 Jul 2024 12:07:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] Kconfig: Refactor Kconfig options
To: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240704091803.3250609-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:610:b1::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8be144-5a79-46af-a78c-08dc9c112bab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dWs0S0ZXWWcvOUQ1cXg2NmZLSTlqQ0c3SG0xOEV3L2g4MXBQOHdRc2FUWnhT?=
 =?utf-8?B?T3JISVRmZThDa3dxT0JOMmc1NG0zbU5zZFlDdFgyU1VORnM1ZkZVNDludGc4?=
 =?utf-8?B?bHV2YmUybWhvK0x2aGN2QU5zNGx6TGNGeE1QMnJ1YWRpSzBPVDNrWG12dFI3?=
 =?utf-8?B?OExmbEdJdzlvbFFxUGt2eXFDOCtneTZDaXRZVmVna0g2ZWxiY01xbld4Zlht?=
 =?utf-8?B?Z3ZBQWZKdTBWV2Nnb0NvSTRKQXc5NStpSUhoeEFHb2k1UmpGMkNHc3FqY2Rk?=
 =?utf-8?B?K21QMGw3NHlNM3Mxc0k1QlNCVzJuN3hVQU4xMWdiY1hxamE3VmN6VTUwT3Jn?=
 =?utf-8?B?U2JyV0NNY09kZFBqeUNZUEY1QXVkdmVHemJQQWcvZFFyZkw4eTFWcS9DaW9J?=
 =?utf-8?B?NndYL2M5VlRYVmlDNnJWenhmZDFja1Jqd2ZYRnNFYnE2b2FvVHJJRFF1SVEx?=
 =?utf-8?B?MGdLMjNDQ0FFQy9ZdWFGN3NyWS81SWpDZlgrOTdyQ0ZDU3hCNHhJTGlPYzhY?=
 =?utf-8?B?V1dLaVNtbUJGNkQxMzhaTitzRmExc2pTZVRjdkwwVVl6RDBHdlJSVk9iUVE1?=
 =?utf-8?B?ZU44QzlMQ29rR05HK0phTXZzOGNUNFM0RnR6TGFWaG02VWNJaXRta1d1VE9i?=
 =?utf-8?B?SmxOOWFLcmMrT3lqOXBwRGZMemd3aHBpOWlGcmlYbzZVVDVaNlE0emNySElL?=
 =?utf-8?B?M0xJbWpWMEd0Q0VIZU9Rc3R2K28wWkI0dzNGd01WbjVIbmtHdVNNb1NXaDZG?=
 =?utf-8?B?VW45aUhuTlNrZy9TZ2M0VENWSzkvZGhNck9YR0ppVFBabmZYMEtlT0FJSi9M?=
 =?utf-8?B?dGVneGdmUTFKMXF6c1JvSHVyNUJXU3ZhbnpDaWQ4WVlwSXpUZldjM21XRmN1?=
 =?utf-8?B?bWJLZXBkNFJRYW9EQy9GdURRdWdpK1JTczFuVldNbnRQY2pxTnViSnFoemk5?=
 =?utf-8?B?MHJlRm55ZHo0SWhnWm5yNnB0NUJNZm8rZnk5czF1dStETGpZL2ZIRldaQ1dp?=
 =?utf-8?B?UFhHeFFlNDdhSnVtc3NNUkxuSUlQWWF6elZTc3FvUjk2cjJ5Y3F2U3VBeEVI?=
 =?utf-8?B?U0x4ZHF1S2VLbG04NHYzdCs3QnpEd2paR0FwQjJ3dGVGZm9CRTVFUUhqc0Va?=
 =?utf-8?B?QlRjTFRGMkM3ZHR4WVMvRXhvdGhwVGtoL0lhMDdtNytMZHo4M2drYnhrOWJY?=
 =?utf-8?B?QTM0cXpIK2Z6cTNjYmpWK1BXSlloa29OdTh2V2hHdEhUbzRTdzlGS0VyTk9O?=
 =?utf-8?B?ZUxqb2F1bnNxUTR3OHIwRjFCNGdRSlZLSnAvVWt6OXlkUEtNaFpDdVF0b2l4?=
 =?utf-8?B?c2JQODdUS0pVZ291bXAwbGN4Q2o2blNCY2RCam5XWnp0TzI5enVRMzFpTFdC?=
 =?utf-8?B?TCtvWDNDVktvN1JGbWlGcGRNV09NVm4vNjFwWm5kNTVCV2c4YW12RFFkQW1l?=
 =?utf-8?B?eFpQZmtoVEJNeVZTNk5taHV1ZHBFbVF1TkhYOFNrdjJ3d3NmK1gxSERmc2w5?=
 =?utf-8?B?aTdjU200TGVTWG1ZSjFPNFhaSk1WblhGS3lHaHliR1VmQThCVThzM3VTd2Ny?=
 =?utf-8?B?NUt3V1dYSytFYTJ1cmFNd0d5QTRqai9iN29waWhxek5yOHN4ai9xRGtYZHE5?=
 =?utf-8?B?bXpBTVBabGdLUDZIZmxMd25nVXFHOG8yNllEYWh3cW4wTTYrR1RsVy8yNDFm?=
 =?utf-8?B?UW85S2xiWlNFWUJRZUJWNktBWlpxY2pJbEhTdmx6aC9KZU1NUDczVmJGOWc3?=
 =?utf-8?B?ZEpqWHFqNFNaRThnMDZlQlU1dFF0QTlxMUcyRHN6TjJMY0Y3T3l1MThJakp3?=
 =?utf-8?B?Um4yNUxwRENmbmJseVN0QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHBpRWl6WWtJTjJIdFFGTjNmZGFLZktkR1ZQL1p6YWRXbGhaeG9iaWlKNjBE?=
 =?utf-8?B?Z3l0c2ZhakVhcCt5ZmJNay8yQUZ4V2dMeFpXcVV6MGltMWxlc3R2T3l3T3hW?=
 =?utf-8?B?NHpRUGVVSmczbmptOUwxZnc1bjhQb20waSt3V1kzczNPWFlJcFpnUGpDSHlU?=
 =?utf-8?B?Qk5mUU9yaitsbGc4VE5vNmV1UmJGb0JRZTZPVWtibG9VN1ZMbnpvLzd0YUov?=
 =?utf-8?B?OTYzbmdtM092Q0VUdnd0YUdHVGY3ZElKNjVYTzRqQ05HWEhhVjR1UzFGM2Ix?=
 =?utf-8?B?LzhTVFNzYjc2anhld0hraWpsZzBCUzF4bmxzaXN1VFF6WUhZUjJvNkRnTmZj?=
 =?utf-8?B?MFh6RFFRT0FnY21jNy82dVJ5UVRxNmZrVFpONmh3SmYveTYwUEVGRGlGU2dW?=
 =?utf-8?B?NndhemxqNXdOR1FNa1JKNUQ1ajdtckg0ZEc3cEp5ZmFlZW9VUVNxaDBoQi91?=
 =?utf-8?B?aVVDMTBsQ1pZZDVaMnR5R243TjYrUExIT21NMFNVT0t4cmRMTEI5alczY0hz?=
 =?utf-8?B?d2RlSGRVUE5iTTdXM1R0SmFSbDFRb2pvUUNnVGV2TGIrZzhuQzFsc3JzZitw?=
 =?utf-8?B?UGZKKzExdFdjSklyVnQ2aGJGbXNOTDExSUxCck96S3ZtalpqbWRrN2ZEcjBs?=
 =?utf-8?B?cm9oYVRBaFhZckdNR3I2S0xTdTdSbXJwVTV3dXNqWkFDbUpYbU1jVzNGUWNX?=
 =?utf-8?B?RHBVRW9BS3BNSW8yK1labHkrUEdMSlpxSzZSZXMrRnlweUV4UG5nb24zY3I0?=
 =?utf-8?B?eURJZVBrd1RMc2NOelYyVEhOckxSRkkrOW16bVJaTXVPVFpOUHkzUitwTmlo?=
 =?utf-8?B?a21vZ245S2owUUhvSVd2b1JWVUFHOHVuRldjNHlxTzRBcXkzSFNOS3lEeFZr?=
 =?utf-8?B?dGtkYWt1YnQwK0dCQUdPUFptY0RWakRvM0RaelpFbEdoSHB6RS8vSHhOOVdo?=
 =?utf-8?B?WlMrNExoZUErWHVNdUFLQ3EyN2VnaEJyYVpPQVBRY2FpclJJVWt5Ly9LdlZO?=
 =?utf-8?B?SU5XVE1CQnVtckdBYXdia0hhR1JVQTRjd1ZkQ2h1SXlmUG9NL05uTEdrZWN1?=
 =?utf-8?B?MkhOME5manF0VWtDV0YxV3dFbTdudlJxSGIrVDlEYWVSVHNXSXRrOFRhb1Zo?=
 =?utf-8?B?Njk4OHhWTmIwd1FxQjlTL3BZbWZKeGprc3dDclFkOHBDRjhicTY4R2pyVnVy?=
 =?utf-8?B?dERuYzFZUlNBNEVHT082aGkzWEg4cHBNSWQzYjZaejNqUE1RVjRLbFMwZmh4?=
 =?utf-8?B?ZTRFN1JBM0kwb1pWSEZENWVzSTNSdktYbHNtQkVvRWp5RVZZRTNmQThQRGhM?=
 =?utf-8?B?RmFWQ2dXdGFPRlJHN21jN293VURuSlNtZWI3VDdQNERucENBK2VtbHc4cExl?=
 =?utf-8?B?bFlTOUJCTU1Fc1JGMjhMbjBCYk0zSWJCR2g5aWRwZTNBL1pTcGFLVnBDRk9I?=
 =?utf-8?B?NVgzZDVHMzNSSFBYWkUwSUtteVdIK2J6SWtjRmNnbEVyVVBsUXNTdUJTY1l1?=
 =?utf-8?B?Zzkra2Y5YUZyVkNiL2RSdDBpaWpOZHJkbjdoTGdYZVFiSlRPME80R1hPN3dw?=
 =?utf-8?B?ZDdoS0ozVlU4djAwOEpnR1VxaC94R0JETUVBQTNjWjdVVUNTeXhPMUxraUl1?=
 =?utf-8?B?bm5wMWdVM3dLa2pPWW1FMVRaTml1QnFpRkxzZ2trM1M2TU1KVHVlRnl2VlJk?=
 =?utf-8?B?bitOUlJIWGRTb1U3Z0tXSTlBekZQMXJ6Z1VoSzlrZ3ZvbXpMWmtaZC96enFM?=
 =?utf-8?B?M0E0amIxY01Dc21DYTVZamNNU2NWUWhUYlpIT0pvVDdRVGs1N2JXZVIrTnVr?=
 =?utf-8?B?T1RhL0VvaEZBUFJLai9iTUZuY29TNEVvRXdVNGI5bUdjck9NWXNxUnBibk5i?=
 =?utf-8?B?cm1TWEd1OTVyMGxqRlIvc2ZLTkVBK3h4VitqSzhITGJoZnBKbHNsTmVwVEpJ?=
 =?utf-8?B?VHZUUkRQQVRwa0dEbzZ6UEhKTjlCQ3I0VnhMS05ENHJuZ0U1UzY0MU1SWExw?=
 =?utf-8?B?YTk1LzZlK3prR2I1TjdrQ3J2Z1JiYVRBN3k0dWhQLzFpcExiRGxMbEZRTlZa?=
 =?utf-8?B?VzA3NFlybCtzRlRVeDlnZVdtTTVpcHdSaEszY3paZUJyRFBZS0FXVTcwSHhJ?=
 =?utf-8?B?UVFNdGRlOEtzazNiYTcyVFdoTU9KWjR5Y043Mm44ZnhOakZhVnQwNjZub1R2?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8be144-5a79-46af-a78c-08dc9c112bab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 10:07:54.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bNEQzEThxxD+IoA46X14yFCZcobtNwnv9fkP6MLNH8nK03NklTU8/bFePVfn61YMEMcrHZbfcNDWIZBi7lNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6562
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jul 2024 10:08:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16371

On 04.07.24 11:18, Shivanand wrote:
> The security target should include both SWUpdate and Secure boot options
> by default, so add the missing secure boot dependency in the security
> option. Also enable kas-container menu in such way that user can select
> individual features without security option.

This is too unspecific.

> 
> Signed-off-by: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 96f590a..f73c8f2 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -163,11 +163,25 @@ if !KERNEL_4_4 && !KERNEL_4_19
>  config IMAGE_SECURITY
>  	bool "Security extensions"
>  	select IMAGE_SWUPDATE
> +	select IMAGE_SECURE_BOOT

Why is this change along not enough?

>  	select IMAGE_DATA_ENCRYPTION
>  	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
>  	help
>  	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
>  
> +config KAS_INCLUDE_SWUPDATE
> +	string
> +	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE
> +
> +config KAS_INCLUDE_SECURE_BOOT
> +        string0
> +        default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
> +
> +config IMAGE_SECURE_BOOT
> +        bool "Secure boot support"
> +	select IMAGE_SWUPDATE
> +        depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +

Inconsistent indention.

>  config KAS_INCLUDE_SECURITY
>  	string
>  	default "kas/opt/security.yml" if IMAGE_SECURITY
> @@ -189,15 +203,6 @@ config IMAGE_DELTA_SWUPDATE
>  
>  endchoice
>  
> -config IMAGE_SECURE_BOOT
> -	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> -
> -config KAS_INCLUDE_SWUPDATE_SECBOOT
> -	string
> -	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
> -	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
> -

These structures and dependencies exist for reasons. My feeling is that
you are breaking things, but maybe you just need to explain better what
you want to achieve (besides enforcing secure boot for the security image).

>  config KAS_INCLUDE_DELTA_UPDATE
>  	string
>  	default "kas/opt/delta-update.yml" if IMAGE_DELTA_SWUPDATE

Jan

-- 
Siemens AG, Technology
Linux Expert Center


