Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67EC021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 13:16:49 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web10.10290.1740662199204591004
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 05:16:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xu0unxT3;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4jxfZgidOm2k2LmsKt27AypcLoGvnlyEGgWlDep+bGkbuTJ88ApK61wt+yuSIpGjmmj1PwmDzPhzTGA/RbCh3kebdXwO2pQQAQj8QgJvry9bcNXhSyEX5oJHY55heivLuxaTrlO0lWUH4uOQNEWUjcY7Z+AjE48WGQRsakS0XzDjij48YnOBHlsZ8k0ZMbiE1ia4HugrYezkrJQTCVbe5NGP7GZof7RnuqUCZuDrDBQ/BfseZFMn0Iunnr1MseH5hdp/waiYLQQCGyqHNx1Wkr+Vlmqsp1gmOI0CKo7HmoXaeYl1Ia5XZGK5+1s27xDo4+moE2zjCCJrc0uz3isbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poNU4SZOQRQ/UpVEX2HyydR3EUUxvlWyKCsw1u+NWbY=;
 b=J+qyWEbujnU3JMtu+wSNAR60yi1Jx6eCnzdExshc6IkmdZo2fcpykRF3UlJ11lD4D/3J2yuQ0vwFXhm/M0T2+sDH9oq1XnLCDeNkJS0zspT+l7vHrSUNJXNqvt4x67yCpdQgpgelcKYRTrNT3QIkr4+bQu+kK6DQosmAzIHBt+ZW2Jyvceg4OaoR03ORYB4AhqlIB7cRok2o6V6lNjj3LXFcVYiIirmeTnOKHGJOcvv4PkY/DFmRaBnSb4uXTsEfhnkr4GBT6Y858Krj/o2yYdTYKrhICCZVLdP2CHS6N038qqHCOQzP/VSIgiOZ7RWxWI+JqYzCXp7k/ajX3KskOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poNU4SZOQRQ/UpVEX2HyydR3EUUxvlWyKCsw1u+NWbY=;
 b=Xu0unxT3r3q1r/n3RL1LzsgVI3jkxCEAslqpeawuy/hO3djaIUS57PWF+BsmaBhRU27LQD1dZAHBCvpFHcL9Q4yJF3ztpqrwSWM+PRP1oQ3L8dtfHM3bSA/8jSnh8bRtSk5TmISQSFKwrDsXtRHHNkQnbUYX6Y0efQ9dNjSdmxprWQcx0iJqWtgh798mV41QjhOyoGyQqDfCJOVIE0Nu+p/IKcSZ1xMA6kl9xmIRSUgJb9l2ZlGMcyh22o1v+liFRA5tNCj80j5vEqY3r6lf9mp+SkM9OoeUvEpkO41Mpo+l9IyFtO1H9LmKTfp03fCnA2VANsMUowcQLD7/sDf7ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 13:16:35 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 13:16:35 +0000
Message-ID: <b66ed9d8-2d90-4519-88b9-21b72f596928@siemens.com>
Date: Thu, 27 Feb 2025 14:16:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 4/5] initramfs-crypt-hook: implement 'noencrypt'
 option
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-5-ch@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250226095921.168962-5-ch@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 854950be-4687-47a1-4149-08dd5730f5c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3pPZ1gzWDZVRXBMaGxBV2FJeUlsZzJTUFpBUTMyWW1XYU5XeFQySFgrR1V5?=
 =?utf-8?B?eFJXMWlTSUxuTGFhOEE1TXpuLzZ2KzlVUEt6UytYVEd4RG4vaW44U1puNXBY?=
 =?utf-8?B?bEpyRlIrYXp4Sk9GbnlNdGt4QzdNUllVVmFxeURqSnF5dWN1a3FCOG00WnJ4?=
 =?utf-8?B?cTk3bm81aXo5a3psVmVQZTNtZ1hvNm9TQ3dmTmtzWFJ2eDc0Z29oV1M2OXk3?=
 =?utf-8?B?Z29tdzZuR0d5NnRrQTdIbHBYaHhyK3B6L25VVVpoQ05iZ0hSRWwyNzBGT25M?=
 =?utf-8?B?cFl3QVkxNkpHd1RjdVByQjMwZXdWS283eVo4eXlvbWVzT25Tb1VnTU1JV1lI?=
 =?utf-8?B?d3ovS1BjbDNaUHJrSnp2Q3dVUkhGMVNPdDBEK3ZySUQ2OVNhVG1DaWlNY21B?=
 =?utf-8?B?WWxFOW1YTG9UNndaVlloN3JOM3lhSEV1N2JjdmRwZ2d2WUNWaHdncnJScjRv?=
 =?utf-8?B?UCtYNEt0YUZCN3VuVXBqMEM1cDBVcUgvYzhKWUM5dkJ4cTN1UzNmSncwQ0lK?=
 =?utf-8?B?MWdyYXh1VHZBczl6UlJpK2FQSlhoVjlpdkRGN0x4M0orZWh3UWUwODdaWi9F?=
 =?utf-8?B?cEN1ZUZlQkRkM1RBRExKMXB4YTNaSHFIWUlSa1FKNHQ1STBhMGtlVWlPWnZI?=
 =?utf-8?B?bXlReDBsRXJWYURPeTB3cWNTUTRTTnpGNXMybzZKYVRBUkl1UDM4STB0SStK?=
 =?utf-8?B?RG9RelZSU3FNbU1GejAyckhiVTc3bHhlU0F1MjhUd3NZZVdpWTRIMFJLRGZr?=
 =?utf-8?B?THFmT2ZvRVZhckwwMnB1WVdtSnQ5M2NvdnVKU3pRN1U3SHQvNXc5cm5UQ2g5?=
 =?utf-8?B?SUZrNUZBNWVRczZmWmFFMzAxT25tY3BJcW5Ic2tSRmNsMHdnM1NWeVRHcUxp?=
 =?utf-8?B?azNLYm1rakxDU0Z1MXg2bWpSQkREMEovcXZzZzFQZEpBVk50UlhBeHdMM3kr?=
 =?utf-8?B?aTkxUHBlNGJweC9hWGxvRGhnamd3OXFwU0hncktxaDZOS0lsTWhicXp3UVNz?=
 =?utf-8?B?dzJqSjRrNFU2TzZVVXlzTlBCSENTa0NMTUd0b3gwNG9MbWRHOVBUTVVMVHlB?=
 =?utf-8?B?NXBBTktrQmFPNmFvUVpJaEwxYy8ydFEwWWRxT2Jla1o1ZGk1ZG9NVkZSc3pR?=
 =?utf-8?B?Tmw2ekpPMWYycUE4d01vbGZ3RGxkbHVaQlRRKzNXWENlYkl0YXBRS29KZnEz?=
 =?utf-8?B?bXNmSWtWRHRvSWU2ZDU2T2Z1eU1XQVFCeVZFUUM2UmpudWd3MFNBQnpVTnEz?=
 =?utf-8?B?NndhbUZuTmU3c0hnY1FpL0tyNjk4elg5cFdNT1hvNmVkdnZUSWpsSmtVQW41?=
 =?utf-8?B?K3dCdUhWWXF5R3lUbkNuMU1ncXp0MStSa1pERklPN0RyS1lSM0k1dTllQzlv?=
 =?utf-8?B?STlDSXNPOURFVkVIV0hVVzNKblFzdW1DRjlvbzF3QlpKNzE4NHFESEdBL2N0?=
 =?utf-8?B?bW4renhaVWpKaGdYVGZ5ZGJpUU1WdWRzZXpTOG5FN2NHMjJCU1YvOW5jckNV?=
 =?utf-8?B?aWhCeUFySUUwSm8rVWdMZzlxTE5jNktxZGZwcHJrUGd4NWV5MzRYNXo2bEd4?=
 =?utf-8?B?ZDNiTlRWY1hXTkg2UzJnbE1SZktxbEdvYTlrdUdCRjR5Q0dsbkhJem9MeGh5?=
 =?utf-8?B?UUJSeW9jK3pYbC9XeWVrNklxcHBKcktXSEQ0dHhCZVV1bURKUVc3YTdWTFVO?=
 =?utf-8?B?M0JINXVPUlFuUTlsYXBUZkc1WDJpRWNaeEtlM0JxMWxkK1E2Z296TXdHSmp0?=
 =?utf-8?B?ek9HbjRQWTdITFFlSUtZZ0RMSUJnb0lTK2tuclY0UEFiVDJhbHliV3lMTDNx?=
 =?utf-8?B?cGVicWgzNWFuMUNSUXdMdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cURFTHdGd2cwWDJRMklTRUtHR2llQnpvdmVtVXkrMDJqT1ZGQ0VnQm1mc0pu?=
 =?utf-8?B?YjlTZzAvdkI0SDBvd0ZCQms2S3R1VEYwbUZ3MXZxa3F6ZmhOeTQyR3JwNXJU?=
 =?utf-8?B?d1d5TC92OVo1ekczQ2liSFUxV24rNURHWFBsZnFoc1VpVG5obVJSSFcxZ0NX?=
 =?utf-8?B?R2kzb2ZkYWFJS1ZEb3p3RzlZR2xjbmZhTlNXRE5nbURIakw2VklGL0pCQkg1?=
 =?utf-8?B?RmRsZDV2RmVSL1dBaW5FeE8yOHBYeWwwQW82c3l4TEFzUTZmVmtkUGoxZVh0?=
 =?utf-8?B?Nm9VdDNac3JGZjEza0VzT2dEWDdCQlZiZE8zdG8xQStyWmVvOTVoanZ5YzlL?=
 =?utf-8?B?UU1yRDBpR1hRTk5CTVZZSlAwWTNHeG5welVyUVBxTWRGMlE3czluYXFEVkdn?=
 =?utf-8?B?TVBKVFBFb3YwdlkvZm1nQjMzZFdQVXpqY2E1dWIxNmdEMFdrMW5zTzJXN3Nm?=
 =?utf-8?B?cXloZkR1L2IwaTdweGx1eUs0UVFBV2V0dWdadm1mQ0hCckZVdGpqTmRabUEx?=
 =?utf-8?B?U3dsVCtWUDhzN1EydXVxV0p5MmZickY0ZHFDNEpHUE5MNitRZHE0VjFLdGdB?=
 =?utf-8?B?a3RPTG1XUHRoZkNGZUhYTzczZC9Mb0dlcjFrVU9OVEUrT25DeFhVKzlOSll4?=
 =?utf-8?B?VUpnVXJnV05laDdLdm0vSFM1aE9NeDlSZzkwdU9nK0dmdGNEWlAyMU9iRTlJ?=
 =?utf-8?B?bUlueTEyNFU4ZnY2MGVNbGJyQnVwanNRaUJiU2NiWndzVE5CZGR2UEIzdXly?=
 =?utf-8?B?dVpNUUJ3V0wwMjFLNDZ3eHR4Si8wUExQeE9pYUhIajYrc29XWjFJM0ZIOGlS?=
 =?utf-8?B?eFV1MmRqWHM4a3NlTzI4bGwrWTJya2tzVFpaMUh6QnBWU3VFblpZYlFwWG1k?=
 =?utf-8?B?QkF2VzVub2I2YmcyNFlwNmh3dE9BaWZGcnl1bXluN3VhNmlqUmloNmVFRFJz?=
 =?utf-8?B?bGN4TVNzUlU2cU5UWDR2WGlCd1UyYmhlTCtTMnRhRTdtNU50UFZkNWRRTldv?=
 =?utf-8?B?QzhIc2hsM0gwcHhKMWJ2RkljbFhQTGtRckc4cDl2TUxHMTM2Wm5jdG0zUTQ2?=
 =?utf-8?B?S2dRbStiV09ETW1SaDNxVmZpbFhGRmRWcWhkY0E1MDRPYVUwUnRuVE5sYmJZ?=
 =?utf-8?B?UlVQM0pjUjlUQkt3V0NxKzM4UUQyMEtjTHJ2cGFjRS9XNU82K29YTDRSbzZT?=
 =?utf-8?B?TnFLZTBFWldWOE1abDJ1bVdkSkpYc2tKTlFJMUJObG52QWNYL1RGZU9JVldS?=
 =?utf-8?B?NXhSMCtHdG1yRGlUay9jY3h0TWNhUExHRjF5d0pkcXZWd1JFNGpFSHcwNTJL?=
 =?utf-8?B?eGdWdHYreG53bUl1K2hzaHVGREg4QldYSDNBRmNNUnB1dVJaZmR1MW1RZUlm?=
 =?utf-8?B?VlZ0ZVVpd3JVUE0xdkU5MmNlT0RTbGFaSEgvNU1PTStOenlyWW9jNE5UdUhU?=
 =?utf-8?B?aXFWSlVIb3RhYVlJNWZVWERINVpVdng5cE5lbHBkdElrZStueDg5RS9VUnQr?=
 =?utf-8?B?b0paSWxGcGJBK0MrNWpwdmUvSEFpSjV2Z3QxTHhGTDlnR3FYSmVDMko5VWhU?=
 =?utf-8?B?eXZHZUxhczRSOEF0YXAxQVoyM0hGMHNNTkNNc3lPUDNsRnBMMzBHaCtUMVZF?=
 =?utf-8?B?bTIzQ0UyREJOWjZ6OG9IMVZFend5aHN6ZzBET1VCbFZFeHFPM1ZGU3ZCb1ly?=
 =?utf-8?B?Wm9MczB4cWgvaDUwNXd1aTB6OTVNTlJ2amJjL1U1Wm1tVURiK1p0NENZaVpQ?=
 =?utf-8?B?cVFWbGtVQzB0V09meUVRS3FIckFKcStBZGhsSEZUVTh4Q2dXOERWOVNXQmFO?=
 =?utf-8?B?dHFuNVVkNzlWb1gwVlIwRVVmUmdkMVNXVWZENWlmQk93cG1wVE41OUVzMGor?=
 =?utf-8?B?czdmelBCZTRZbHhxN1kzWUxmcTl1R1hkRit4aXdOUjNBSEh0NXJlbVZvZHVF?=
 =?utf-8?B?d0lzR2hMNEtzR05FdkxPVUVFdEVYcEpCRUUrRzRWOGRtdnVNTlI0ZndwZXVX?=
 =?utf-8?B?ZDhGcjgwejdSbTUrV21GL3V2SWNhZjVvZ25GTDZadzc0Qk11QTBrOEFPTG1E?=
 =?utf-8?B?T1ZvdDV2Ylkzdko2RGV4TjZ1b3VKTDdqWW5zcWJMREVrdDFndWlQVkR0eXJq?=
 =?utf-8?B?WW9wY0d4UHlRMng5N0RTSFdmbUpidWt5L1ZJOU1QOFlVOEJ6d3k1Y2Z3eCsz?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854950be-4687-47a1-4149-08dd5730f5c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 13:16:35.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9txnelh65lvrc8Ho0HPCm9XEuNDUY9fk8RD+eFYVyQaJ9lENDSpmKMzVl3ldjPWzGJtPwbR0vBA+fg+VJKtf1t0S3YZR1NPHGBa1vBYykDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 13:16:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17939



On 2/26/25 10:59, Claudius Heine via lists.cip-project.org wrote:
> In case encryption needs to be enabled via an update, while still
> allowing the update fall back to work. One update step where encryption
> is supported, but no reencryption is taking place if the device is not
> encrypted.
> 
> For this the `noencrypt` hook is implemented, which requires some
> restructure/reordering of the `local-top-complete` script.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>   doc/README.tpm2.encryption.md                 |  3 +-
>   .../files/local-top-complete                  | 29 +++++++++++++++----
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 3f7e89f..515348a 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>   ### CRYPT_PARTITIONS
>   
>   The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>   - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>   - The `mountpoint` is used mount the decrypted partition in the root file system
>   - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>   - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
> +- `noencrypt` will not try to encrypt the partition, it it isn't encrypted already, but will open it if it is. This makes it possible for an image to support encrypted systems, while not encrypting anything on their own. Useful when updating from a system that is unencrypted to one that is, while supporting a fallback system.
>   
>   #### Encrypted root file system
>   
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index b907ea7..1214a63 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -216,22 +216,41 @@ for partition_set in $partition_sets; do
>   	if [ ! -e  "$part_device" ]; then
>   		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>   	fi
> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
> -	# check if we are trying to mount root
> -	if [ "$partition_mountpoint" = "/" ]; then
> -		echo "ROOT=$decrypted_part" >/conf/param.conf
> -	fi
>   
>   	if [ "$partition_expand" = "expand" ]; then
>   		expand_partition $part_device
>   	fi
>   
> +	# If partition is already encrypted, decrypt and continue with next partition:
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>   			| grep -q "luks2"; then
>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +
> +		# check if we are trying to mount root, set ROOT to decrypted partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$decrypted_part" >/conf/param.conf
> +		fi
> +
>   		continue
>   	fi
>   
> +	# If partition should not be encrypted, continue with next partition:
> +	if [ "$partition_format" = "noencrypt" ]
> +	then
> +		# check if we are trying to mount root, set ROOT to plain partition:
> +		if [ "$partition_mountpoint" = "/" ]; then
> +			echo "ROOT=$part_device" >/conf/param.conf
> +		fi
Is this check really necessary? In case root is not encrypted the Root 
partition should be given by abrootfs/verity/cmdline ?

Quirin
> +
> +		continue
> +	fi
> +
> +	# check if we are trying to mount root, set ROOT to decrypted partition:
> +	if [ "$partition_mountpoint" = "/" ]; then
> +		echo "ROOT=$decrypted_part" >/conf/param.conf
> +	fi
> +
>   	# service watchdog in the background during lengthy re-encryption
>   	if [ -z "$watchdog_pid" ]; then
>   		service_watchdog &
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17922): https://lists.cip-project.org/g/cip-dev/message/17922
> Mute This Topic: https://lists.cip-project.org/mt/111393564/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


