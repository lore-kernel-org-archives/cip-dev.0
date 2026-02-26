Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21912FC5911
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 08:50:49 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66161.1772095839725660079
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 00:50:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UrwYQLLz;
 spf=pass (domain: siemens.com, ip: 52.101.65.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axxCJOiws+rUVf1IBrJOma9bqj3QCqzKI0yt/1bw4ZOd8TCEvD/EeJTWXFiRnNL896dDE2BKjcOs/TuzflPtO87I4wAA/wM3sHQqr1I87ERCGXb59IdVP07PaVclV4Hb7SjiFNuu5Fd1NJ5eEZ14GPf0dFi+1dMAMvgCVqUk7tfAGq3+3lCjajtXr2adj1qCnsRfUYI8gJdlPzogUuLUS2/r0CpKqsKcyOISJKNv0G09ZdxXp6ZxIqKXCvD+3gvLbGUhN4dYAQBTKmkjQs1/4MOYq0qRWSFjMFUxK77horoqKUbWHW2loQOf06nBS/D7bjLaVM9DBEMyhQCNsQ2Q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED72k+5R8GjApT8/7x9IOh+kjkq6ugQ9QXqIeayz1Z0=;
 b=tvB+llNEleEVsx1Qc+LdjlaDUi+xxDJvbCrXW+8r56vN9GqeytRcWPJvH9spTlwRwlk8r6kZH3Trog0EylpQ8LlJfOYmDoC8stTu738ThQnQa0Q2x6luk0TidznJ3vKTOp/+tofrDWDF/rQP0RhDiK5JSaZfSg2/jsfI3C7qDcRCFnWld2E9xDp8vOSi8OkVT5iKVUCIZwHBphmI5i+UOtiQ5L6RydYhc43AkAeDH+UNlERgaFJyCkNe0po/g8Wq9Ih/EM7K/E+8YYXa635z/R+zMrAH7Phl9k0JgD+AAX7cUpvcP376hGsrJ682Lm6M+Ny0rMGHrqNt6Vsd7OnJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED72k+5R8GjApT8/7x9IOh+kjkq6ugQ9QXqIeayz1Z0=;
 b=UrwYQLLz6zewlER1fvcX/JWhF2OU77ii7oaGu3kJNF4JcevVs+0f0AlKq7iZ4cfIBsjqXQX0iJmftdnclF8IKLGj8hEj3qyR8AwkXkeLQdBvoJmkfg9mEmfCTldm3xLIaAOylmJ8IWn/WU8X7HvH1x0ns4c8q0dP0B3FrmspLBCcg4EbYCkl0jnWm0I5qHNEw061sziz/vLeLo+1av9M6otVpKqye4QtuXsAGDayswJBLL9UPQu1fuzhvDXdsFU7dNU20biyIp1povixgfEv/L7A1+hvB3M0/YmRx+LblQuGCOZiBWyxKLWzHT2eNkThM9a9GxNZrCfdi2kw8wo3Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 08:50:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 08:50:36 +0000
Message-ID: <e3eb0c12-6ab8-4541-a20e-1f36167c5a90@siemens.com>
Date: Thu, 26 Feb 2026 09:50:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 0/2] swupdate: Enforce signature
 verification
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20260225155226.534978-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260225155226.534978-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c7feaf-686d-46e4-f1c7-08de75141bb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	6FqTqo+caRRm0hBeOkwMmGjVGtL2OGe7zVaXmAsdGNjn8zVt22BXkhAul7Q4BjclM82IRWVvmqoz2MdwB+2cyfH2GeMeGiDKXJMskxHsB+MhfILe8ZOOdCaqkVZ4ijHFK8xENVOu0hBjGSHKGj32gEj4uk5AZIiOzztjrlIbof+pljiQTh2OpSc+5pEU2XFxfheC+fGGiAqkJBwyX3rh22ID/JLvMlor/OGQ5kKHDKnfc9Sa8wDYiE0LEUsQXelhIqE/fn6rm6+LGKKcmb28XVTIpARnYcKsHCcSyIUSOLzf6lhRKJyP1Q31x00qU4faKB/yE9UN4+wDqeXIdUeo//PxV6RV5uJ8yDXGX/7c8zATPtaBqNI6+MRHIsVxfwr72RxUsEGrgJLdgSsMwnjnqKRFQG/zMIz2v8YHBUcBWF0zOImA4pHYSCqGWdRtLAQq9VAzyN19OdrH0ZaoIYYRVUIqSwOFGUzN+yKj+HzyuHi08YFsdKHNaNrqLwhCfl480KxilWfogJWJ7RBRWUrA39da/k06hNkCoVVKQ6Gt/ICeiFAr6D4kUU6lnd1yENtx3ZsVfuWxvgQsgEbN4LwlGZXN2gtVxTreaf/A4IrRLa/DDlzli79G4FhKaqBZWPe3ntcE+1vUDy3lqfSkEyASrJwkpPIJ4tFFsGEdPUcXzfPIdNh1YZwrekDDFuuwWmD6n2abMxvqxMV4RmzTKFW13eQfTGW1g5DM64eO7m1QUrQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzVKMkpXVUJWUFNLWkN4QUhMc1JDK2lwRE50OFdpTmg1TnUyRnZEeFp0VW1a?=
 =?utf-8?B?SzdSTG9ZdFZ4eHZ5dElDM0Z5OTM3VVh4K1gvcTZjRzdrL2dKYTV0THNNTCt6?=
 =?utf-8?B?cXFKR1Frc2FWWW11REEweUhmSnRKSVFzRm1RTVVra1RnWG5rdzIvU2ppVUli?=
 =?utf-8?B?TS9EeFhvcCtlM2RJWXhoR2FDTnQ4TFB3WFp0MFpBWENJdWxiYytIbk9KSm52?=
 =?utf-8?B?TEUzcjI4UC9yWU1aUVBDSHdvb2RQU0FxR0NSUmtveTlZdW42bU1GdzM2cUZq?=
 =?utf-8?B?eUpldFBrb01PNHMwL2hhaXI0NUFiU1ZsVkJRd0thWE44anUwcEoxMDVkM0VN?=
 =?utf-8?B?aTBBSDNUOVFGaVhLR0hTd29sWjNEK3hiTDEzSVpncjA0clZCa3Y5Um9aYjhE?=
 =?utf-8?B?ZzVlTnorSU5aWlJ1eU1CUEh2K0FWOFFZeEVkb20ycVFaYjdmU2pzdjVOZmhz?=
 =?utf-8?B?dnRCK2g3bEhKTUZJcEpuTm5qVnJWdlVoWkV4bUNqL3p0WWNiSmw0K0ZkS3Ur?=
 =?utf-8?B?K2pGMU1BM3Z5bTNIbTNLNG44alFKeHJWWktLY1RnMlowOUsxa1l0NDRMNEJk?=
 =?utf-8?B?c3BaaEl4U2RGdG1oY0ZMR3JQaThub2JwRmtPK1dtZkJSdFdFV2VvY082azFx?=
 =?utf-8?B?SDNYMU1uM0MwdXZmY1hkZU9sM2dVeEx3Tm4zei81Sk53T1BlMUlJdnkzcUNk?=
 =?utf-8?B?WTQwVnRqa0xJM2pxVmNFdUdYU25aM2ZDVHlzUTRXZ3hRcFRRUnBiamcxMjBo?=
 =?utf-8?B?Rlk1MEVhQ1htMWk4L2h6dEVmL0dFUDFpcW9rVWgrK0dFZmxMaWxFS2V0Q1Rr?=
 =?utf-8?B?bk5VRlBkQ3RHUEF1VEtFVlBibHQ5eitaRlg3WmhBQmdUNVpVSmY1eTZKOEdL?=
 =?utf-8?B?NFY2Z1RKVUtJS1hRSXVRbFp4Q0dYTnJMbmpzN0ZSSHVZbDh1Y0Y5RTRYak5s?=
 =?utf-8?B?OThZb21PaXBBUTQ5cXU2dFYraHhNQkpPS29WSy9KRXVXQzZTSGQ2dytvd0Rp?=
 =?utf-8?B?a2xIRDdSY1hyMTY0aUtiRFc3cUE1MVVDVVdXbnJMbXFPK0VHZWFlMmVtYmhN?=
 =?utf-8?B?UTBRcVUrRUZ3elVqeWFDM3VoV2d1eTdGT2FWeTIvYy9FSzVUOGpnYnR5aExS?=
 =?utf-8?B?dVlQQ1REVmtBY01mbmNjNDJ3a01uQ2dMUUlhdXhObC9hdktyNXdGWGF5SjZL?=
 =?utf-8?B?eUVWMHJVZUpIS3FDVGluRmtPQU50Sjd2OVJWNXV1ZllDVFd6eGd2ZHBmQi80?=
 =?utf-8?B?YlBLSnhneTJSUnBjdFdzT2JPS3dYY3NXelZ1aTJPWjBBZzMvK2dWVmlvaXho?=
 =?utf-8?B?VVFTY29XakJNWGtRdkdoaUh0MXptbUFESWxRMkZ3ZFk0Z21vbTB1YUM2VDJn?=
 =?utf-8?B?TXZGQkNCSG9wVVBKZUFlVDZZbGhHY1ZRVFJnRUV5MnpSKytJVFRkdW96b0N2?=
 =?utf-8?B?L2pnK0svOFpia0RXYU9GQ3JhNWY5OU5wTWo0eDlGUW5UblJTMnk1NUM0bVN0?=
 =?utf-8?B?b203ZVhxNXpTeG5UZVVSMklXeG1qQkVPMWZPVnQ5YlBMdDVSQVlydFphMnp0?=
 =?utf-8?B?U2VEaE93QVhnWnhvM2FVMHlKSkVEYXk0UnR2TS9vNjJSMGFXck9SYlRIZnZ3?=
 =?utf-8?B?RG4vRFNPYWxJWXB3VG5kNmJwK1ZIaGMyRkFZQmwvYVVqU0ZwYis3b1NyemdM?=
 =?utf-8?B?bG9Odyt0TkJIQ05aZERxVmE5VjhRbXROTW5QTjVVSVc1bEoycXhmd0Zramo0?=
 =?utf-8?B?alFEZHhKZm11QytaSFI0c2dOTnVCSTRJVTBMVU00eGVvRERydVptQWJsYm1N?=
 =?utf-8?B?Z2owTTQ1TjY1Y29mS2NrNkdOUW5mOEVIVlVLdEVEV0lvQUFaRWJoR2xLWkV1?=
 =?utf-8?B?LzkzSzNkODFKVG03SFZXSTRTUkpLN2RwNDhDNkpIQ3JlUnlrdmcwL3BFNHgz?=
 =?utf-8?B?OG85OHBOTTZndkgrK05mMU9pb0NTaE0ycy85NXVjZlJoMVdFc1JmSndQVzhP?=
 =?utf-8?B?VXJLSnJEYjlKcTkzdEdzL0p0c2JiY0hvSDUzNm5ySnE0Q3ovVTd6V1JyQnMv?=
 =?utf-8?B?Yk1TdE4zZG9HNnVMT1pCaTFqbTZWTTZKT01NbTJsN0FPWlNNWE1mSjlMS1l1?=
 =?utf-8?B?VEtjV1dIWk9nM3RPcmV2V2NuekhwMDUvY0xLZC9pMzdCcFJBMUs1bWdhR1c1?=
 =?utf-8?B?VTJSOW53MHd1d3JFalk5S0JFazhmVElkUXhDRXExWW1tQ0drVHQzWE5ZcG9P?=
 =?utf-8?B?Yk1RUm5iTE0xRU10ZVFvWkMwQk5hT3hIbnVYNU96OTZqZ0Q3ang2U3FNSnVu?=
 =?utf-8?B?QmNIZWJHU3ZmSEh6NG9tMTIybVdORUl1ci83L2E5L2M0OWR6OSszZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c7feaf-686d-46e4-f1c7-08de75141bb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:50:35.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORe6zTd5jQBXQvji6U1bMW1nSiVdza5AjabN/2eH8AKB6k1jNpQGO7hcKa6iWSKXRO3g81C1H8JLouL9mRE9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 08:50:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21990

On 25.02.26 16:52, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> The self built versions of swupdate (used by default in distros < trixie)
> do not enforce signature verification.
> 
> ```
> $ sudo swupdate -n -v -i demo.swu
> [DEBUG] : SWUPDATE running :  [read_settings_file] : Reading config file /etc/swupdate.cfg
> [DEBUG] : SWUPDATE running :  [read_module_settings] : Reading config settings for module globals
> [TRACE] : SWUPDATE running :  [swupdate_dgst_init] : public key / cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set SIGALG
> ```
> 
> This patch modifies the swupdate configuration files to enforce signature
> verification by default, which may break downstreams relying on unsigned
> swupdate images. However, the diverged default config for signing and
> verification of swu files is probably not desired anyways.
> 
> ---
> 
> Changes in V4:
>   - Split the patch into two commits, one for enforcing signature verification
>     and one to fix unintended modification of the image in swupdate class.
> 
> Changes in V3:
>  - Reverted default value of SWU_SIGNED to empty string in swupdate.bbclass,
>    which allows to control signing behaviour using CIP_IMAGE_OPTIONS.
>  - The dependency on swupdate-certificates in case of signing is enabled
>    is also handled in swupdate.inc via CIP_IMAGE_OPTIONS only.
> 
> Changes in V2:
>  - Dropped patch introducing duplicate config in kas/opt/swupdate.yml
> 
> Alexander Heinisch (2):
>   swupdate: Enforce signing and verification for swupdate by default.
>   swupdate: Fix unintended modification of the image in swupdate class
> 
>  classes-recipe/swupdate.bbclass    | 4 ++--
>  recipes-core/swupdate/swupdate.inc | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --
> 2.47.3
> 

Thanks, applied - in reverse order to side-step any dependency between
cleanup and unconditional enabling.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

