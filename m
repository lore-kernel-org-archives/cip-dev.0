Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5AFC282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 11:44:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web10.11043.1741261475406647738
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 03:44:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lE4+en+Z;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOnxfCj4ifkgLgnBukOnJlbEaa6jpR3fBcJqCBlU0CKTEV/bEX+LAy5hvqJoYaRR+zkSQG2Hc+bniCTnYFm6TupPNhB3tsTWD5Z3Hn/lcc9zt0NK+r+8kOXOfguof5M6Qc50k5A4NP0aG8N9fxz3h8C29ZSJK+/lK4cSWwdkVtzH11Df87ipPxfVDJlzW1diWHMwIbJOz6I8E4Rtrwxv54T8BruTllca7LpsA6zwxrM3LZpW8FWhCNotmWVO5462mwmcCRUlH5Fh/uPu8ASM34pizmQ/as8Jc5jVXTMBhciVGCbhOH/INomleC/dpHL7bY/y4McCyLHBmghzkt2Iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgE5x9HPpntwMc2s7gRa/zc5njzp1z9yYj09+8UkXUg=;
 b=AINzTdtQOR18Pvd0dcdYfzLNJVAWuyF+v3diiQP/MSOqgAW6MXE3NANG/sBF0RyFcj536wrqYKmQsgHBwJak4RmrRf5asuApCD4jJlXvJr+7dRIZCQTiLTwM5rw1jAzv60eMaCMXcAMgQ0LfZE7m8CEbdaJ5/KbHP771CTiHb1kI0B4yT+N/h9XKoxW95EYPbkwmyqlnw38IPTmzPUOGk6I3cAq7SpssSOpf3kzZJHWc8Yt6FsLkLSP27T5o5gs5glbJluXURU8dMzRoHu7HI6SN3Ipz8s0SERchI3xGKGnOKuVM4KWeLIECq7HT4zE+H0n+sML2pTr38Ad0TJ4uDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgE5x9HPpntwMc2s7gRa/zc5njzp1z9yYj09+8UkXUg=;
 b=lE4+en+Zo+I5FkSJoSBmA17z1ZFswhYiQIBrWR6BcI2TEhkWMzN86E0VRFWFw//AHVgz/GkzdY9v/p84VjZln+QX7Hjvl6fXb2jqWvBppzgd3gIstOTDviHkBpI6VLbmP5iKm9uC1jLCCr4SABKlU6aiQbyi+zdXR/VR2sdbQuZJghFqViN3bTD6im1GOOyyP5RN6jQV7krYSj2VoG3bjeWM5uqnERJp9+u/jhPMhaBJWAAA/mdpA8ypI0X5NUT+62zaVeJ58BNUk2V19cRhxOL74DDq2KBYTZIiSOISiLxGOhaQ7O+RMFIVSd5VSG3SXY7ENGy2iFhT5qxwOoyoog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB7158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 11:44:32 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:44:32 +0000
Message-ID: <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
Date: Thu, 6 Mar 2025 12:44:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: Gokhan Cetin <gokhan.cetin@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: fefdf1bf-eb7f-4a29-e0ab-08dd5ca442b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eUVDR2xsN2FLdS84L3N5NVZQeGd3R2NkS21hOHkvNUNXZXdpaWRPYUR5NzhX?=
 =?utf-8?B?dDE2NjdWdXdKZ3E1eXVuT1FBbkJhVWdwLzVxSXZVUXBnRjg1Sy9KUExMUWdS?=
 =?utf-8?B?MzVMZnBrQTVNSVkwMzFLanV4a3pkK2NyZEtsWE02elAvSHRmcngzNFFYTHFu?=
 =?utf-8?B?ME43ZFlXZ0ROMzJuMUlxcEplVWdHb2N1akhwUnVGQ1hOSklXTWwzN2NtNXg4?=
 =?utf-8?B?SHl0TVN6WkdneE81WEcxVERsUVczbmhFL0ZoelU0Z2N5WFJDdU1QOUJzZk1y?=
 =?utf-8?B?bzBFVVFXK0VQa1Q4QmVlUEZpb3FQQnpKZFRwNUFGbFdyVngrNUVXM3BCTzJO?=
 =?utf-8?B?U2sxdWNIRWZISjVxa2hCVjNSRFBRdWFqb1hrMWovY2VzdDF4SHlFR3BKVHBl?=
 =?utf-8?B?dHdYcEFDTnpiOWZURldtOVNKVUZzeTRQZUE0UzhOVWR6OEtNUlhDdVErb3VF?=
 =?utf-8?B?VHZhS2EzYjBMemR0TjA0Wm5GODg4ckJ5QS9kQ1ozbzBvT2xodWpYT2UvTGV1?=
 =?utf-8?B?RTRxN0swa2lmMjNlY0xPaEhzWkVnb0ZUVmpIbnp5dG4xczlzY1YzZzgzM0Fw?=
 =?utf-8?B?MERJamV1cXBFZ1F3cFFsenErT1NSNmh4aGM4SHFOdUtzU1IwdEFlWUhhTkpp?=
 =?utf-8?B?Z3k1blMraVJvcTdLdG1YcnoyeGh6LzhNVHpGam1GdW5IUjFuZVlEYXBodFJt?=
 =?utf-8?B?VjhaQ0Uzc1N2WUxuSjAxY3RjK3BBL3p4ajFpQytrV3p1VFF1WGN4by9tWkU3?=
 =?utf-8?B?OVNROW02dHU3aitJKytFL2g0WUozR3k1Qkxsa2VGME5ydEpRK0ljRjhCMFgw?=
 =?utf-8?B?aW0weDRzVTUvR2pvL29QbjQxYzRBRkJKWjlvVGw3MExJN1RKOGR1WlJwNmdn?=
 =?utf-8?B?WjdPbGNJb1NiaUxMWDIxblE5clBGTDNyczJ5eUZ2VGw3cXVwaHhHM0dMdm5w?=
 =?utf-8?B?ckRqdGJOeFlBR3JiRmdtSVdvMzh5Tmd0UjdxeHM3ejM3bVUyVnFld2xZVXV4?=
 =?utf-8?B?dWpTVlY3N1d2UVV4TnNCVjVsbHN1QVZzV2JJYUFpZlpVWGpjRS9mNnU3Tnd1?=
 =?utf-8?B?OWVUYW1iR29STmlndDMzbjdkWldDaXZGcjZjQTFFUzdCc0ZSRDRaTjVDUmNP?=
 =?utf-8?B?SEhQb3dpTExLRFVQa1BvTlhYTFNHdVNTTjYxV00xU2VCOVU0Qklsd3FJcDV3?=
 =?utf-8?B?TnY1VEhvVTY3MkJpU2g1VWNEZmF5SmVpcUtHd0lDejB3VFBQcVQvRkJWSGEz?=
 =?utf-8?B?aXVlcnU1VFBWYkJ3cGNKWVd2cHpQcWhEQVhGTzE1dDRsc1N0bm5SbFExQ08w?=
 =?utf-8?B?TWMzdWR0akYwb2xMeDFjNXlvS2diMVVOTUtnL21GTFhHNkR0amtIUWNjSXk1?=
 =?utf-8?B?eVRmTjFsYWFGdDNnbUhaNkdleVpOSU55UXd2cWtnbjVrNG9Dd1lDck95WXor?=
 =?utf-8?B?eW5OMjBhaXhnQjZCazNXcWFtSnVxTmpNeXI2cW9ISGlrQ1lTVmNuQjRYUjI2?=
 =?utf-8?B?YUJ5VERYM0QrS2Zwcys4OWVJNXovaEFvaWxBNkZ3dlRLYm10NWUxc2JWWm5P?=
 =?utf-8?B?SEx5SEVlTFBaRDFNNExjNFdDVU1MSklyZ3puK2JIblpaKzhwSmtZaUFqVnlO?=
 =?utf-8?B?TmRHWXJNNUZyYnhOMW1aSUlIWStGeTVOc1kwUm1nOFNPc1JvS29aTnJxd3ls?=
 =?utf-8?B?TlRPL3FPSFVKaTA0UTVnRHR5bWdyKzVrOUJuWFRYZWxqUDN5OHc1Z2JhWEMx?=
 =?utf-8?B?andqV3ZGa3VDU0RCcUFtcVVLSHQ0bDlLSHZ1VUdETGw3dEUwNGVZS21mQjRC?=
 =?utf-8?B?amtGcy8yQ1RVc3NLTGJLZmNWVCtWQTZidDgvdkthR1ZRMWpkSldMTHBYNHBw?=
 =?utf-8?Q?+Hy4HA4RqXzOc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUI5dmZRREU3bTFhSXdicFFsM29Zc1BtT3ZURHYrSmRGMzQzMG9ieGF2RHRM?=
 =?utf-8?B?VTY0NFNOaEZadlNTR1VleE5IVnM2SFU2SzJxUlZRTWl6QTY2N0c5QUw4OTNa?=
 =?utf-8?B?MW44YXg5WlphckJ5Q3hLNHhRSWhIQ2J2UklvYU5QalFaYkRGSGFIelpTRHRG?=
 =?utf-8?B?UHhKZVB4dlJhY2RpczI1YlMwVzJPVmc1OVlDKzZwS1YyUStvTENyay9IaUZX?=
 =?utf-8?B?TmN2S0JZV2ZFV1dqaUk5OHU4Tzg4WFJDUmJvSTdwOUJPZ0hCYXFLUGNycTl2?=
 =?utf-8?B?TjRoWm1Sc2lKL2hWU1VTYnA4REk5clFaRkhjaXdLOXRScCt1UXV1bHB3Uytr?=
 =?utf-8?B?eGZ1eHNPTVhUMnZ1bitPUHppclZpSzhRdHBLMTg2KzJWTmZ2ekRVd3M0Mitp?=
 =?utf-8?B?Ryt5clBEb0VrQU5EZTdFVXZPcm1aYnNyMm1yUDV6MHZqM0t3VDIxT29BbS92?=
 =?utf-8?B?dGVmTURPNUtqYmhtWXNwMGxxUmtiaXlqeWpjbjBZNDl5K0FrVWtVaVBmVmMz?=
 =?utf-8?B?aEFKMHJHbHp6a1lMY0pUMzA2aElxc2VGcDVHTXJ1ZlB5bG1XVkl0Q0Z6ZktW?=
 =?utf-8?B?M3NyMkc1djhxTENNUElSTmFNTHE4Z2NOMEZTbHhLZVBkRmhaYURRcThvTEF3?=
 =?utf-8?B?SGlrVWQ2eGdrVXJmSTJEMnJ5OUxYM0hVWFptUmhMNS9aOVVDZUhOOERKLy9U?=
 =?utf-8?B?Z1N2aWoxakFrTURvcG03KzFocWJta3phUW91Vis3Y3ZpeWUzV3hMaUJkMTlh?=
 =?utf-8?B?NXpzcjlDa1ArUVpDNXNVUWVZVEtlY0RNSmN2d3ExOTBzRDlkd1BVcXhCUkVx?=
 =?utf-8?B?Q1BtVEI4Sm1kb0JLS21lb0pBNE1UcVBtTytmY1l2YXRnQ1pyVWVMMVhieGRU?=
 =?utf-8?B?T0x0S0tIL0U5SVdlZDZRUGdPMHdUME84bzBvcUlrQmlIdlE1WmorakduL3FR?=
 =?utf-8?B?YmhLcXIvMnIxbDZaK3k5VFZhTFY0MXYrTXhGOVY2RXJJOTA5bGN2L2p5cURX?=
 =?utf-8?B?WmJ2QmFsZ2lJNHVTbk00R3YzZDg5a29PNEVVMHRBYUNKOGIvMmhRdTUxUnBE?=
 =?utf-8?B?WHVBRnpwWnU1OEpGRHJQWjZvbFRsZWsxV0ZacFFGOUp3azVDVGtvYitVT2ti?=
 =?utf-8?B?bnNkNnNsSS9nL2JIVkZ4akhVTEE1d0J6a0J0ay9DM0JSQXoxOUVxME5JajNu?=
 =?utf-8?B?L0JQRFRHenQ0Q2ZnUllGYm05QzJEZFUweTdvTUtET0JPSXFMeXhHRGNQT3dy?=
 =?utf-8?B?L0RkV0FVR1kyMmwwRCtVMkY3dnRJeXZZMnE1WGNJOU1OTGV6TGI3aEJ6OHF5?=
 =?utf-8?B?ODZucFcrR25IdisrSTlUMWpTWXZlRnFBTFlodUxGajlWTzBUM3hYYjJpUUd6?=
 =?utf-8?B?T0J1dWlqcTJzanhmMG5PbStvcUVWc0UxeDI2VHN6OGFISVNkcGFaR2FFcEdo?=
 =?utf-8?B?VFVRWkxsOTIyNW1pOG8rYlJpV2JFT2Nsak1rbmJyUERuVFM1TnV1NE1UeTM4?=
 =?utf-8?B?c1NpV0l4MDJXZElOQnpGQThOVHV6S3A3YkxneldRSXBvN3ZRUm1HZDZCOUtG?=
 =?utf-8?B?NUg5SDA4cTJ1Z3o5OEVsalJ4UE1XQzdxR3gyUmdwWVQxTWdkSWRoZzZXQkMx?=
 =?utf-8?B?V1gxYjIyd0t1WiszRUZ1bVlxQm9sUFhQNytWRHNuMCtTMTB6SzJwZFZRNUtB?=
 =?utf-8?B?VWVoYzN1VDVIWCtNSXQxV0FFOHhidC9BZDMvR0xCSmpYSDFPbzFiSWtKMFV0?=
 =?utf-8?B?NStkNVROL1k5cDNydDNvUDRKanhWREhMSUdoS0ErY083K1lpMzRWNUlJYzZE?=
 =?utf-8?B?UXRkZEtaYk8vSzlib2Yzc25PRnRGMnpXVHg1UExQY2JQcndEc0taNFhaZ0N3?=
 =?utf-8?B?akRqZE45NGFacHE5cWttdUdBTmwzV1RBejhNc2FKZEo1MVhXNTRoV1p6R0Ja?=
 =?utf-8?B?QWFUVno4allNMFI2MDNvYmlnbnNEbnljT3lMUXNadXRvTlVGUFk3THdOSUhk?=
 =?utf-8?B?YVc2M00xRzVCK3hFSjJ0Q0s0WXVhWUV6QmJSUDZyQzdaQzN3U0hLdDQwK001?=
 =?utf-8?B?ak1kcjNNV2IxZjJUaWdiR0tybUV3M2dGZFFNQ2tFbHlKT2Vodnh3cVJsWXho?=
 =?utf-8?B?MzJEMWdzVDJ1bllCZHpZNXNzTWtJV1hSRHprU2gzZktkelZnY2hFazNGNk9N?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefdf1bf-eb7f-4a29-e0ab-08dd5ca442b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:44:32.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkIRxJwB9822bFnjwzysJj82WLaXVUjzXJrXXP5p6lreg6HhtK0GWf8oDJxeKyxo6+3nYPCzWPsggw7GLQ00Vv7rdu853ueGXn+w8RSDM5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7158
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 11:44:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18055



On 3/6/25 10:35, Gokhan Cetin wrote:
> These changes split the signing process into two stages.
> In the first stage, the `sign-secure-image` script called by the efibootguard wic
> plugin now uses a hook to create a detached signature.
> 
> This allows downstream layers to provide their own signer scripts in a similar manner
> for the second stage, without having to overwrite signer script or partition's source parameter.
> 

This patch does two steps at once:
- switch to pesign
- split the signing process

Please separate this steps into two patchsets. Also you need justify the 
switch to pesign.

Quirin
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>   doc/README.secureboot.md                      | 37 +++++++++----
>   kas/opt/ebg-secure-boot-snakeoil.yml          |  4 +-
>   ...r_0.2.bb => ebg-secure-boot-signer_0.3.bb} | 16 +++---
>   .../ebg-secure-boot-signer/files/sign-ebg.sh  | 34 ++++++++++++
>   .../files/sign_secure_image.sh                | 38 -------------
>   .../files/sign_secure_image.sh                | 55 +++++++++++++++++++
>   .../sign-secure-image_0.1.bb                  | 27 +++++++++
>   7 files changed, 154 insertions(+), 57 deletions(-)
>   rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.2.bb => ebg-secure-boot-signer_0.3.bb} (51%)
>   create mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
>   delete mode 100644 recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
>   create mode 100644 recipes-devtools/sign-secure-image/files/sign_secure_image.sh
>   create mode 100644 recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb
> 
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 8ab67a8..a7dcb6c 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -166,8 +166,8 @@ local_conf_header:
>       INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>   
>     secure-boot: |
> -    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
> -    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
> +    IMAGER_BUILD_DEPS += "sign-secure-image"
> +    IMAGER_INSTALL:wic += "sign-secure-image"
>   
>       # Use user-generated keys
>       PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-key"
> @@ -347,13 +347,30 @@ host$ sudo umount /mnt
>   ```
>   Launch KeyTool.efi binary from the built in EFI shell and follow step-4 from the section [Add Keys to OVMF](#add-keys-to-ovmf) to inject Secure Boot keys. Otherwise, consult the manual of the specific UEFI Firmware.
>   
> -Use the recipes [secure-boot-key](###secure-boot-key) to provided the keys
> -to the signing script contained in
> -[ebg-secure-boot-signer](###ebg-secure-boot-signer).
> +### Signing efibootguard and Unified Kernel Image
>   
> -### [ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb)
> +Use the recipes
> +[secure-boot-secrets](###./recipes-devtools/sign-secure-image/secure-boot-secrets)
> +to provide the secure boot keys to the signing script
> +[sign-secure-image](./recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb).
> +`sign-secure-image` exports the attributes from the efi to be signed and requests signature from provided
> +`ebg-secure-boot-signer` package. Then it imports the signature into the efi and verifies the signed efi with
> +public key installed by `secure-boot-secrets`.
>   
> -During building a efibootguard based wic image the scripts contained in
> -the recipe ebg-secure-boot-signer can be used to sign the bootloader and
> -unified kernel image(UKI). If the keys are stored in a HSM the script can
> -be exchanged to sign the artifacts in a more secure way.
> +This layer provides a signer package
> +[ebg-secure-boot-signer](./recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb)
> +to be used in cases where both public and private keys are accessible at the project directory level.
> +
> +If there is a scenario where the private key cannot be accessed, such as HSM based signing or
> +server side signing, `secure-boot-secrets` and `ebg-secure-boot-signer` can be provided from
> +downstream layers for project specific requirements.
> +
> +```
> +PREFERRED_PROVIDER_secure-boot-secrets = "<own secure boot secrets>"
> +PREFERRED_PROVIDER_ebg-secure-boot-signer = "<own secure boot signer>"
> +```
> +
> +The package `ebg-secure-boot-signer` must install its signing executable on `/usr/bin/sign-ebg`.
> +This package may depend `secure-boot-signer` if it needs access to secure boot keys as done in this layer
> +for signing or verification purposes. In such cases, secure boot keys should always be searched
> +in designated locations as `secure-boot.pem` and `secure-boot.key` located in `/usr/share/secure-boot-secrets`.
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 7d8ce65..f1eb782 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -25,8 +25,8 @@ local_conf_header:
>       INITRAMFS_INSTALL:remove = "initramfs-abrootfs-hook"
>   
>     secure-boot: |
> -    IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
> -    IMAGER_INSTALL:wic += "ebg-secure-boot-signer"
> +    IMAGER_BUILD_DEPS += "sign-secure-image"
> +    IMAGER_INSTALL:wic += "sign-secure-image"
>       # Use snakeoil keys
>       PREFERRED_PROVIDER_secure-boot-secrets = "secure-boot-snakeoil"
>   
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
> similarity index 51%
> rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
> index 83289d4..3c002e6 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.3.bb
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2020-2022
> +# Copyright (c) Siemens AG, 2020-2025
>   #
>   # Authors:
>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -11,17 +11,19 @@
>   #
>   
>   inherit dpkg-raw
> +DPKG_ARCH = "all"
> +
> +PROVIDES = "ebg-secure-boot-signer"
> +DEBIAN_PROVIDES = "ebg-secure-boot-signer"
>   
>   DESCRIPTION = "Signing script for EFI Boot Guard setups"
>   
>   DEPENDS = "secure-boot-secrets"
> -DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
> -DPKG_ARCH = "all"
> +DEBIAN_DEPENDS = "secure-boot-secrets, openssl"
>   
> -SRC_URI = "file://sign_secure_image.sh"
> +SRC_URI = "file://sign-ebg.sh"
>   
> +do_install[cleandirs] = "${D}/usr/bin/"
>   do_install() {
> -    TARGET=${D}/usr/bin
> -    install -d ${TARGET}
> -    install -m 755 ${WORKDIR}/sign_secure_image.sh ${TARGET}/sign_secure_image.sh
> +    install -m 0755 ${WORKDIR}/sign-ebg.sh ${D}/usr/bin/sign-ebg
>   }
> diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
> new file mode 100644
> index 0000000..9139165
> --- /dev/null
> +++ b/recipes-devtools/ebg-secure-boot-signer/files/sign-ebg.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020-2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -e
> +
> +signee=$1
> +signature=$2
> +
> +usage(){
> +    echo "sign image attributes with secure boot keys"
> +    echo "$0 signee signature"
> +    echo "signee: path to the image attributes to be signed"
> +    echo "signature: path to store the signature"
> +}
> +
> +if [ -z "$signee" ] || [ -z "$signature" ]; then
> +    usage
> +    exit 1
> +fi
> +
> +keydir=/usr/share/secure-boot-secrets
> +
> +openssl dgst -binary -sha256 "${signee}" > "${signee}.digest"
> +openssl pkeyutl -sign -in "${signee}.digest" -inkey "${keydir}/secure-boot.key" -pkeyopt digest:sha256 -keyform PEM -out "${signature}"
> diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> deleted file mode 100644
> index 213cf8a..0000000
> --- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -#!/bin/sh
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2020-2022
> -#
> -# Authors:
> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -set -e
> -
> -signee=$1
> -signed=$2
> -
> -usage(){
> -    echo "sign with image keys"
> -    echo "$0 signee signed"
> -    echo "signee: path to the image to be signed"
> -    echo "signed: path to store the signed image"
> -}
> -
> -if [ -z "$signee" ] || [ -z "$signed" ]; then
> -    usage
> -    exit 1
> -fi
> -
> -keydir=/usr/share/secure-boot-secrets
> -
> -faketime_cmd=""
> -if [ -n "$SOURCE_DATE_EPOCH" ]; then
> -    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
> -fi
> -
> -eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
> diff --git a/recipes-devtools/sign-secure-image/files/sign_secure_image.sh b/recipes-devtools/sign-secure-image/files/sign_secure_image.sh
> new file mode 100644
> index 0000000..8456867
> --- /dev/null
> +++ b/recipes-devtools/sign-secure-image/files/sign_secure_image.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Gokhan Cetin <gokhan.cetin@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -e
> +
> +signee=$1
> +signed=$2
> +
> +usage(){
> +    echo "sign image with secure boot signer"
> +    echo "$0 signee signed"
> +    echo "signee: path to the image to be signed"
> +    echo "signed: path to store the signed image"
> +}
> +
> +if [ -z "$signee" ] || [ -z "$signed" ]; then
> +    usage
> +    exit 1
> +fi
> +
> +keydir=/usr/share/secure-boot-secrets
> +
> +tmpdir=$(mktemp -d)
> +
> +mkdir "${tmpdir}/certdb"
> +certutil -d "${tmpdir}/certdb" cert.db -A -n cert -t ,,u -i "${keydir}/secure-boot.pem"
> +
> +pesign -i "$signee" -E "${tmpdir}/elf.sattrs"
> +
> +if [ ! -x /usr/bin/sign-ebg ]; then
> +    echo "Could not find the executable '/usr/bin/sign-ebg'" 1>&2
> +    exit 1
> +fi
> +
> +if ! /usr/bin/sign-ebg "${tmpdir}/elf.sattrs" "${tmpdir}/elf.sattrs.sig" ; then
> +    echo "Could not create signature file for '${signee}'" 1>&2
> +    exit 1
> +fi
> +
> +pesign -c cert -n "${tmpdir}/certdb" -R "${tmpdir}/elf.sattrs.sig" -I "${tmpdir}/elf.sattrs" -i "$signee" -o "$signed"
> +
> +rm -rf "${tmpdir}"
> +
> +sbverify "$signed" --cert "${keydir}/secure-boot.pem"
> diff --git a/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb b/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb
> new file mode 100644
> index 0000000..cdc2d16
> --- /dev/null
> +++ b/recipes-devtools/sign-secure-image/sign-secure-image_0.1.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#  Gokhan Cetin <gokhan.cetin@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +DPKG_ARCH = "all"
> +
> +DESCRIPTION = "Signing script wrapper for EFI Boot Guard"
> +
> +DEPENDS = "secure-boot-secrets ebg-secure-boot-signer"
> +DEBIAN_DEPENDS = "secure-boot-secrets, ebg-secure-boot-signer, pesign, sbsigntool"
> +
> +SRC_URI = "file://sign_secure_image.sh"
> +
> +do_install[cleandirs] = "${D}/usr/bin/"
> +do_install() {
> +    install -m 755 ${WORKDIR}/sign_secure_image.sh ${D}/usr/bin/sign_secure_image.sh
> +}


