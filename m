Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F1E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:03:21 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.44])
 by mx.groups.io with SMTP id smtpd.web10.149684.1734692587744256795
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 03:03:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h0FnKakH;
 spf=pass (domain: siemens.com, ip: 40.107.22.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZQtFqzxcgQS27DL+2GVkuS4CVqCt4XWOUz1DqGDqnNGe2ZJ1RfqrPhrpBDpE3DQGLuX4mo73TeqFS6FQ19+5gcDliI7xIDJMt+gkIsEBcypXYzZ1tstLTY8NQBbGyId4a3ds5Gr0Po8XC1OOO8C88Oh3lga/gRdpg7ROVC/QIdq6z1TUWIWeIsU5sFpvn714NyyYjaAG8fXEHrd/m/qcbNqkM9id+H26BxZQ9q4/6n7IGkif5PGy1iZOplFar/CrBdUWg2G0mRrVce0XYMi4fCDX2X4zpWvXsGranQLazyMg6ZypFkccwvMR4nByM1d8uzitB0sZbBMIZ8rH6I7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYkbQ1JAckudDN1igHfNdcsvScD4zkbc8uMDlqceJRM=;
 b=ToDq1WZCeybRZU0bGGQt7rrevK72XehbWgzKf7vgE7ljtOnnHyXlFPivRa63eaPO5ce28UjrcfLIp8NoJRrv2UzxLawWzZV0sTMcsMSahHlq8oSigsnzKDuR/+HLeSys4jhEbpQyjV4fyXhFWHZOnEJDALADPOhj0b1UWYfTV6QHnm+vRpA1/MM14hcHPUofTMzL1U30YuUfyHeCcvoLSSweRZBqNrjPzKKqqPvssfJIbj6w92zKEpv5SRtGLp9zVtCRFdb+ZpFbWkWGB7wpJlx/phzoBNC5BXAB4S77pYrX3Y26WC+EMdAUNy/Es5QAOj2BnVnFzE7B2xx5tKo1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYkbQ1JAckudDN1igHfNdcsvScD4zkbc8uMDlqceJRM=;
 b=h0FnKakHI92xJymE4C1aC44HPAkfTvqP3Gud83eMp0ds+FhFAnXXBq5W5IZAQaJBDn+gPlcyGmNNIF0GgaxlWx8OPxYe18/TAvxMUX9cIAeWB9E3B0jbmtqyeme5pUngNJNLiD+NQvxdGLcgoxJx+HS0VY2vUHdxuP6hKEX6gGh2sGbYA+mMKrYZEwCvB9oTI+Sg0JhZe0VhZIA+WVPlP206sOKnWIiERG4D+as/iWj76+DA0a8E0Qexljafzqjg6/qaW1n5atMxiGVzest3Q9XPdSQAQpt+52AGsGDaDZMTzixNN1a7ojWQuoeUuJo65E34sEYpdj7M5E4EstfM3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.7; Fri, 20 Dec
 2024 11:03:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8293.000; Fri, 20 Dec 2024
 11:03:04 +0000
Message-ID: <5e4cc176-e945-4cb9-a3b1-bf2e4320a4db@siemens.com>
Date: Fri, 20 Dec 2024 12:03:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] continue boot if not enough disk
 space for encryption is available.
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241220103918.1165341-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1c5fe8-45f3-4b19-0757-08dd20e5e05e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SkMxTzZWTDVsamw1WkViQWRkVGxVcTlCRlBKdUlsRzQzWlgxcVF2UTBmSDhF?=
 =?utf-8?B?THgzaG1TSkVoRkQ2MDhvR20veGZYSVd4a3h0cWlXTS94YkVqenMxM2ZyMWhE?=
 =?utf-8?B?U3JHcmVuZWw1Sld2ZG5YbzViVERjU3dWWkNXL0JWK3Z6VWhjMGtmejJyb3d3?=
 =?utf-8?B?SGNmend1RllySWFBMmlIZkExS1Y2ZE56bDRtdDBqK2VWbTJhZURnNnpEbkto?=
 =?utf-8?B?UTBtYStLcmJabWhRUGV1QXJ2QWVpRkUyTEtlK1crb29xc0V2WUJsU2Rxc1c5?=
 =?utf-8?B?cVdGTE5KaXNWZGZ6TnZBaThiNTJSbmYxTElsb0tqdHZTNk5FTUx0d0NPWCt6?=
 =?utf-8?B?MlY2R1IrdnhlQ1c1LzlyUzVHd2dpNEVadDFXMDFXZDlDRldlMEhjUy9GcXNB?=
 =?utf-8?B?UnFQeTM4REU5VGFsL2s2WEVacHJPb0ZENWZ0YWtydTNKcVVTSVpEYnFESTJU?=
 =?utf-8?B?TnMxYUdGU2Nmc1A0TkkyZWdHRHZGcGJHTE9FVVJTYTJXQUM4bXNZOW10eFB1?=
 =?utf-8?B?YXhNbmNYeDJuc2ZaMWRVeUVUNk9kZHlIcjhaaU1mQmxwdUJtSE1iK3Q5ZUIx?=
 =?utf-8?B?MFNGVWNTRFRBVFphRlRqV3l1ZytuU2VvRmJUUTJoeG03QlovZm1qYmdTVWJS?=
 =?utf-8?B?QjlqOGN2aTFmeXpvZzY2bTUyT3lueHFzVkJsRVZkVmVoT1JzQUNVb3g3RnFL?=
 =?utf-8?B?eTErdllWejZpdEJkSGgwTlBCMDRpZlpuWko2d2RodzF5SGNCT2lTQk1WcmRY?=
 =?utf-8?B?OE9pd0RXWUJJNUIyRDJpaFIxM3l6YTU1NzFCT2ZwSnRad0I5YnlnaXFRL2d2?=
 =?utf-8?B?QnRkeE9TUFhabDd2T21uajgzNkljcmhDUGJROHNSeW1kTDNETjhQeXpyZUhO?=
 =?utf-8?B?ZnZCWVR0aWxhbDVYM21MVFRKZlNicXRxa2ExNHZnTldWUjBMODd6aGZLVjJJ?=
 =?utf-8?B?aUVWR1JWVWQ4Y1FxUDlScXMrNmtiYmpYQkRwbG1BZks4bGJaS3lMdGZpZ1JP?=
 =?utf-8?B?Y3h1cTN3S3ZHNDBmeHhmY25qMTdwVXJZUzVlNGxXalhnY0plUWFzWXVOd3Vl?=
 =?utf-8?B?MTEvZ0U5c21mbVZjWHdNYmdxd3RQUldyMktKWlJyeng0L1dLT3pRcFYvTzhu?=
 =?utf-8?B?SHZnVFlZS2REeE9Uc2xRWGdYL1NCMVZEQTloZFdGekw2SHo4RmdqZU90K0dT?=
 =?utf-8?B?WmZ5b0JUMzRBRDZtVWRmT21obUNQbVZ3RXo1SVRsejE1YlZRdklPSWZrcURw?=
 =?utf-8?B?bUIxd2FHemdPNlg5NnE1VWZMTkZNUHc0akN3WnoxeE1RZm80cWh3Y1Z1dVJx?=
 =?utf-8?B?T2lJVjBHMWJ3dndOVHU0WDFIMG1rWWk2Y3kwWGVvVXYveWpNQTNHQXQ5ZDVt?=
 =?utf-8?B?Nm81NVFrVmpFVDhSL25lNVAyMWhBNVh0REtEcUt1eURiUENwWE1GWUF0bmhD?=
 =?utf-8?B?QzNLd2w1ZkI4cHVCMFR3bXhITi9DSGg0dGRtSkpHWlROQUJ1V1M0V3ptK3lq?=
 =?utf-8?B?N0Rpci9ITTZUbWlQM0pXOHRORUppUzQ3alU5RGN6NUViWXRiZ1RRRGRML1Jr?=
 =?utf-8?B?RHVOQnBpemFrcHVSUGVMQitsaEhnT0dWejhUZTVMLzkxUE0wRE9teVRVdVF4?=
 =?utf-8?B?c2JTVWRpUDM4bGp5TzUvTCtPVWhyTFdnU1lZN3kxcSt3ZU5sVEZXUUxGZExJ?=
 =?utf-8?B?a0tDV0czTExzblFiaXZNdGdpWStnUUtBU0FpSENFeEhTYmoyTTJGNEtvU0dw?=
 =?utf-8?B?OUd1WGZGekJldXYySUdsSmQxYWJ4WHNhcFBaY2lsbzBzRm9XNlNSWWZEWEt0?=
 =?utf-8?B?SzVzTG02aDBwcnFBY2kwejdOTkE3TXlXRnNIMW90SE9JeE9pN0MzSmMrRW1V?=
 =?utf-8?Q?ospBxykCLBuC7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVVsaG5IUnlzTGUxZHcxa2ZxWDJnSUdtdXZPbmpWbDIrcXpOQStxMGZPdXJW?=
 =?utf-8?B?UFJkalhRUTcvNVg3YlRKMFd2VlIzYVN1dE1DQlJTTTJGL3pBS1Ztb1lOR0lR?=
 =?utf-8?B?RTVZTUpFWFhmb1RKZ2wxaGpyZGYxWnRBVnNoK290RFMyT1IxaHNiUk41bGhN?=
 =?utf-8?B?dEJxa2ZwME52a2JTR1o1d29OM3o3cTFSQXVwTjB5WnExYU9SS0Y4djZ0THpV?=
 =?utf-8?B?QytFRWJyU1Y1MmFxQ0lBVTlDSHVvSUZMYmd0L0RjMlJ2QmhKTzlJeW40NVU4?=
 =?utf-8?B?dXlmc3FZVTZ1dlFiVThiMmpuS2lDWUN0ay8xbjBzUVAwb3dvWStSc1RRTmxV?=
 =?utf-8?B?N3QxSHV4OVl4OHJJc1NXektrQUREbEowRnRHalJHYlh2RWpTSFp1VmRGRERW?=
 =?utf-8?B?dDNMZDhFOXVzekh5Rlg0QUxpUGZTcDRTZnNIMEJ4ZGtUTVk1Y1ZaSGNNVllo?=
 =?utf-8?B?WlUyMjcvTlAyRktnQ0dVbjdBTmdzTDdTSTgyaWR1ZHNXcWJ3TCtKZXI0Lyt2?=
 =?utf-8?B?MUVUQTIzY2lZYk9waEdRQnpOd0xzWFJuTHNiVU1WTjg5MVA4VUxOc2NKU2ph?=
 =?utf-8?B?bk1vTXdUcEV1cEUwQVVnOUNBM0t5ditlL2hSdU0xUmNQV3JJdGVrWVJlQVdW?=
 =?utf-8?B?U2hXWWd0R2FodExvaUloc0VhNjNLNHJ4dVd3ZVg5bVZDVnhRRDBjYlFndXIy?=
 =?utf-8?B?emM0OW1wTEtyMjVTZ2V1ZG9UNEhadHh5VitvS3p1VCtwV2pGczN6OGRtTUl0?=
 =?utf-8?B?TzBhVkFBcTJDYVozTURMUzNzeTVkcTh4SUpkUktVTWREVEcwL3lGT0UxZWZE?=
 =?utf-8?B?S0pldWppSThFcEVkWnRFWXJOSjJnZVJVSEQyUVprRFJWSEtTWXFRbjNsSXBF?=
 =?utf-8?B?THUxbjA3U0Z0czFlUDNjRFlLZXJTNk9nbWU5M1pWeWt4ZHpISWp3THNJck16?=
 =?utf-8?B?SjJSSS9qZnBNNU1PazIvSmJMSXFyeDBjSWlhMWJCYlVKZ3NQa0I3UW5HMTF3?=
 =?utf-8?B?dHVIbmw3ZUxPQ2p3YjJVSEExcVJWd2hWeHllc1FOOG1JRllISGNQZk1Nd1Fa?=
 =?utf-8?B?WXdROWhlZ2psUVErU3dvd3BNQXhVVmU5b2puK21temJsZGFaQVp1Wlo0ME4y?=
 =?utf-8?B?SmpiQmlxNWZGWTRSTlpZR0gzMkd1a0k5RkJnNXhWa2ZMUmdPUlBTRlA5VjRt?=
 =?utf-8?B?TUdVTmFWS0gvVi9FZmtIUkQ5M1hWaHdOKy9keFlJZXNRcjJYRjBVN01jMUZP?=
 =?utf-8?B?YjV2UEhYbDQrL0ZHbnlYbEdoV0E2bTc3QjRQZklZRVlZS1FRZ0NCQjQveVJj?=
 =?utf-8?B?QkkrMWNra0E2ZWUrRm5UaXBVVTYzNVNGNjd2ZTZrVzBYb1N4dVBXakFPa0oy?=
 =?utf-8?B?Q2N4a3c3YmRCSENiVFpLalY3MjQyb3RINklQVDNGK2ZXWWthaGdvc0RmOHlT?=
 =?utf-8?B?Nmg2a1FFVFd6dGxrdS8xakdCd2VaclI5MFZRWWtPemNRK2RZdjBpeWEwcDd6?=
 =?utf-8?B?RnpiQTRtY2UycGwxV2o4eUltbzFXblNEdGdlQVBoY3lrUEJKUGlKRkFnZGQ0?=
 =?utf-8?B?ZitlSmxRU01MMDdJMUlEWVFhRDJjaHRmRjE3elcvOERKMmc3cTM0SnhYWlJP?=
 =?utf-8?B?bEVZWEtWdXJudkZzTXVwdlVvWEkxbGExQThmN2pYem4vUnYxZUU4aXh2QitR?=
 =?utf-8?B?M2ZlZlErMkswTTB0c3lMdEI0OHh2K0hBNng5VHJwWm42T2o0RjE0bGEwa0dP?=
 =?utf-8?B?UmhhV1ZVSnRPZlZwVzN5ZllKZDlUdWZ2WHF5OCswWWl1Q0krbDl2MVNtb1Rh?=
 =?utf-8?B?R3VxNVJkWUY5RjJHQzUvTTNidWtieXo3NmpnVlB4Y1hqb1F6QlM2eFZjMity?=
 =?utf-8?B?RExSR3lpVGora2JibTBJT1Fqa3QvTldGeXJFTUpXbjhvMFhzZ3RXVERiNnFo?=
 =?utf-8?B?RnZTK0s3My9lVFNNN0V1WDZZcmVkYlIzYkRqVmdzVGdRWERNTUszM3pVSnVz?=
 =?utf-8?B?WlVtMmlMNDd0WjJoZ2VvZm5sUEZpS040Q21sWm5iWmVwdHRPTTlKMXcxK2kv?=
 =?utf-8?B?Z1ZONlB4ZVcyNUJwV25TVDBLMHhLK0ZDZUtBUDZaOWtpREVzK0l4Tzd1Rkgv?=
 =?utf-8?Q?Qxktk93tWimXxB6G5Pt6+LNaA?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1c5fe8-45f3-4b19-0757-08dd20e5e05e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:03:04.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVZ58Oq3FUeQ874D63fogPthaVVfDJKCYq/y+6UNgcS0jG+5x9b64E9kmrKRepr+UyootuSF29x9TP6sMWVqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 11:03:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17485

On 20.12.24 11:38, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Encrypting a existing system with a full partition will lead to a panic
> during resizing. To ensure the availability of the system continue booting
> if the flag `CRYPT_ENCRYPTION_OPTIONAL` is set to true.
> 

Is that not overloading the semantic of CRYPT_ENCRYPTION_OPTIONAL? IIRC,
it was introduced to handle devices that lack a TPM.

What exactly is the scenario we want to handle now? Misconfigurations
during image build should not be papered over via CRYPT_ENCRYPTION_OPTIONAL.

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/local-top-complete     | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 834dea2..f86cade 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -79,7 +79,11 @@ reencrypt_existing_partition() {
>  EOF
>  		e2fsck -p -f "$1"
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> -			panic "reencryption of filesystem $1 cannot continue!"
> +			if [ "$tpm_encryption_optional" = "true" ]; then
> +				return 1
> +			else
> +				panic "reencryption of filesystem $1 cannot continue!"
> +			fi
>  		fi
>  		;;
>  	squashfs|swap|erofs|"")
> @@ -94,6 +98,7 @@ EOF
>  	else
>  		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
>  	fi
> +	return 0
>  }
>  
>  expand_partition() {
> @@ -236,7 +241,9 @@ for partition_set in $partition_sets; do
>  	case "${partition_format}" in
>  		"reencrypt")
>  			log_begin_msg "Encryption of ${part_device}"
> -			reencrypt_existing_partition "$part_device" "$tmp_key"
> +			if ! reencrypt_existing_partition "$part_device" "$tmp_key"; then
> +				continue
> +			fi
>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>  			log_end_msg

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

