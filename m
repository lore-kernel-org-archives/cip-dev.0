Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E36C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:33:51 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.7204.1737707620788161907
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:33:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xsz043mQ;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP5AizWz/Q36fFdd/8YXUwQY3+HuO6bAQRY4p16yeECAr+M/hshEh2XLtUoRoZhWRrzn1tEJt7z9No3KIOiBik68fmiAnbVUWVykE/re19ErWl9hpaig3fIsagR1pooic7SyU/0DcwizuJuoL+l3o8a4X7XU18EfyLRMJUivsqDVywAPRFuSqAulVCSQT0EMgGI+wuKBHFs34P2JyQWN0glAFpNT6dfKsiON2X6YICwnpbBZiGCM0H5bor+irbPmfrzRWkckUO7yMxevg1zpS2spnZ+fDpZivVUVuunBt3Fz20UGDhpxyw6/5qkstkhgXEZBJ4z9wci2v8+V8cLpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1QpTxypFcS2zHXCwjWLGcZuxz69ZNdXDGKlFWd9nhQ=;
 b=p6de1dtUFvMOqJetkunP3vKrAfrabk1N27H6Ol73uy+knBgsh25IEy3EDGCzVQp0RLoT99aXoB6cTALT4j2Gx9zt0MK948wn/Cggnxasqx9UJZ1dGPU2TGhjceprCddHwUChFqQz6Jb+9FSNiFxxbVz8ptKp4ymSUJmy4rnsUmdAHLXL3dBmoELRyySZyUeG3k4GbI7FRSnaEIFOlmbZRr5p5DLr7sy8ZlhlEt/qfOmXO/f/I8DktpBsp3I5nneGuroerFdxGELiHEHeQRI3OesAtRKZKeMuEfpyADEeFM/OTqxKfPoc0l+Xlkjwvk276F5d8+k7UHaTjdP4xXVgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QpTxypFcS2zHXCwjWLGcZuxz69ZNdXDGKlFWd9nhQ=;
 b=xsz043mQJDLOMaj87v6Dci2nahl70LhJ2zMOsvAXViui3ZcifBLmrLPMACnDS50VHTE6bh8L/h0u3YQD7fVpD0lK+0WDgcBZVs1Qx0g8FY6FoD8wwJN9B6rngfQVcICAyLf4q4tu/w0Z2EhgUTVRkPkYTyQt76huCcnKKooU+R/k5UwrNxS2P8Bv7ZFkgjhqmbvZ2uzCz+qNyCXM/y5FAU6KVENkAUphjac2oPHymb9x/UsTbH8GEhHpFGbMvQKBZL61os8CVwZL3yaf5B2ziJbIeo9L/axktNKn7+Ed9R2fzyb81+a23KrroBSPzGiKhv+5vx4WLXbH4q0Rta2XNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 08:33:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 08:33:36 +0000
Message-ID: <529900d1-3093-4161-a2bf-c574db49aaab@siemens.com>
Date: Fri, 24 Jan 2025 09:33:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] customizations-security: add
 curl to download LAVA overlay
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
 <20250124080659.469424-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250124080659.469424-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 563d7676-b237-4496-497d-08dd3c51cbb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TFBZR0N4QkNvVHhKd2xWRjVkQUlqTnloSmdHMVdKL283KzZSSHF0bEFVeDl5?=
 =?utf-8?B?bzliMEVkZWh1MkF0R3JzazdsbzFRS0ZmVDU0Wk42UEFEUUFCejFkNE9FNGRO?=
 =?utf-8?B?dDVWUTNMdGNUUHExU21FVVkvSmVUVWRwWnZ5OVVaU2FrTjkxR294WXc5WFhm?=
 =?utf-8?B?NU5oQTFhRVVvMDhEWFlyVFRIV1kzQzVJSGZEc1E2UVpiTC84eTRnVkY2UzBD?=
 =?utf-8?B?Ym5od2tCM1p1VDdpZi9VaGhMNFJXRFpxT3RPYnZwYXJ1NXpLWFdQMzZVYjVK?=
 =?utf-8?B?aXBzcXhBdDB6Q2lsWmhXb0w0ZTcvUlR4aHJHY3NWN3dvZzE3bzgrWW1idnhr?=
 =?utf-8?B?VlB2d2MvaVF6RjlKZFh0WUJNWTVWL0tFQ3V2VEhCMjVjaWZGSXRqeXJTdnRm?=
 =?utf-8?B?QVI4NkhpMXlnRUpPWUFhS00rUHV5MjlHREVGZVM5ejVIdXhndGZ3d2NHczE2?=
 =?utf-8?B?OTNOZ3NkckRhbHl3M08rSFJOVUNQY0hKaHB5REhQczdyRTc2TktMb1Y0ZHBB?=
 =?utf-8?B?UHFaZy9IRFhhSVdKODdoUVNZdVFEbHZWejJHRElzNFZqbnBIeklsRkRKOE1k?=
 =?utf-8?B?TU9HTU5mWkR3SnJRcEhSeUk0WEZpOEJuNDUwZkVidklnUkUwRVpaWks1RHpj?=
 =?utf-8?B?akQ1WXkvakF6Zk53Zjd5ZWZqV0lXVTJ4eFFsa3VMaWVnZnhBOXdmeXloS1N0?=
 =?utf-8?B?NGdxaUFlY2xLbWhBY0RDZTNQaExqUDhUZ0V1aXRNMStOdFhwWXZ2Z2U0bzRs?=
 =?utf-8?B?N1A2VW9aaS93amxBUERHOE0yUS9YbCtxcjJNdU02elI5NnNoQmJFV3Jna2ky?=
 =?utf-8?B?ZU5XWWxFeTJGWXZhMDlwZDhDOFJBSEF2YkJmYjVvZTMvUUw0NUh3dmJLN0xp?=
 =?utf-8?B?YnMvRUhsNDFuWitnQWlYOTlTT0k3QUQvYjhIZjF0NWZERVFFVE85SjQ3bjAv?=
 =?utf-8?B?M3c0ZUp1UWF0VmlMRm54T2gySFJ3Ymp0ZS8va2pxbWhXWnZGYWxqZ25odXA5?=
 =?utf-8?B?QVNrd2g3eEpHejFGZllhekRNZVAwMi9DUkdrcTF4Tkx4cnJlT281UGJ0cTQ3?=
 =?utf-8?B?ZGoxbkE0TW9BR3ErdytzTm01cE16em1yMmV5VzhTeUhCT2VvaGpsWnNVUWVS?=
 =?utf-8?B?NjM0Wld1bVl6UmtWR0JZRnlzRjlLZUY5N3pUWjNzM2RvVGwzOVgxN3lxa05O?=
 =?utf-8?B?VlJVZUpRN1ZlWFZTUHlsTExxK0RkN0JhTk5jaTJwaUQvZDZkVmk5d0R1S1ZH?=
 =?utf-8?B?U3JZaTdHaTFBdTJIYVNPbFh5U0dZMVh2RG00c1FicFNQdzFpR21zY3pQa0VO?=
 =?utf-8?B?NEtFYTVHT2E1NnZLNlc5VmV3THd1VDM5SGZCbTFMY3NPN2NabjdveHExRkpi?=
 =?utf-8?B?bVYxTHUrMG4zVmowUyt4dWErMGlyM3ZWVUR6SGFiUUJncG9tMU5Lb28vdXRy?=
 =?utf-8?B?TG5wUm0vNjdyeWNJeUJTeUk0blNLcks0UXlXbjR4c0V1SjBEZG1FMWp3VVp3?=
 =?utf-8?B?VEFNQm9OcU85T2IwSnBoaGQrUkhNNE9ITTFBbDZ2eEJzR1RiT1dldWZPdldY?=
 =?utf-8?B?M3R6MG1tdFM0VlJ3UW5oZzlIdkVETWE2YlpiTTRvamxrbGZmU1NKaUgvZ1dt?=
 =?utf-8?B?c01zeHFQcTNxWWpBRm1rUU1hMzB1b1RHS1MrQlE0NjVraGpjL3ViT3ptQ3ll?=
 =?utf-8?B?SmVpaEs2ZVBqY2NDNytOdG55SjJlbWdsa0JtMHhXZ2p0MU1ON2VHZjgyNXl5?=
 =?utf-8?B?QlRXVTduMHNDS0xpQ21tdTRmdlR1YUNxTzF3RVBrY3JtUW85YVlORzVqNDJj?=
 =?utf-8?B?elBSRnVDeGQySlVxS2NRaDJlNXpYM0pGWG1UcHlRNlNqeHZtcjRGTkV5QXlR?=
 =?utf-8?Q?vS6opsLeFV1wB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dk12TXIwam10T1NDbWVKcjExdXFJcktMSEJZMlRpYXFlVXZjZzg3azdIbVE4?=
 =?utf-8?B?U1V2eVROdnd5Wm9rS2w0ek9TbWdUbC82NjVVeWNmU0w5Sjc0YVkvT091eUgz?=
 =?utf-8?B?R1pacWl3ZEJqblVBOU5ZbWZUa3pVT04vaDJmS3NJTnNGeTU3bVQ5Vk9iRmdl?=
 =?utf-8?B?L0tVWXJyTDU4eG12VlFIOVR1S0FxYlhUWkJ2OTJNSG9vV0Nza3dGTWpENHpI?=
 =?utf-8?B?ZUNtNXpKQllUY2dyaStCdmg4b3VMdTRPbzQzTjRXMXdzTmk2SUFQN1c2eFY0?=
 =?utf-8?B?M3lXZC9ySnNuY0ZPamVaL0hwTE82dWJSbVkrbDJTUXhNUW5FVXNRQWRPUXEz?=
 =?utf-8?B?c3ZwMGRuR2NSWklqSUtVRjJYaFlTUk9XL0pDRTB3QXR1Q0RTTW5keEhHUkU1?=
 =?utf-8?B?OXQ0MGRVYXgyVTRXRzFzQ05BRkt1NkpNa0xpZ1l6ckM2UjB2aXR1Y05UbjFn?=
 =?utf-8?B?bDZ1Qjc4RVhSSGNuWjRIME9RM1Q5TXB6RGlQbm1QQStYYkxBaUU2NHdLMC9E?=
 =?utf-8?B?c2FoenZmTnQrdmZGUDJOQjdKcTJyU3pzeG1DV0ZVQXZsaWJnc2pYU3YrZ0dL?=
 =?utf-8?B?NWh0REJyQ2JUNEdjeDU4clZrYXRvSWY4SmYraVh3UitwZDliREIzWkthOEZX?=
 =?utf-8?B?QVNudW5KSklzQXlqUzM5emF4KzF4M1N3ZHVZUXVTeXdobys5S21QSENRMWRI?=
 =?utf-8?B?SjJvYm1EVUJBQk5VbkZ0YzNNbklOWm5YdEs3cDFBekk5WDZLNVpIenJWR1h2?=
 =?utf-8?B?ZXV0YVY3VUxoc2tUaURYa2lWTU4wMDNvd2JraGlNWEdGeFhGMWt4WTl1ZEJR?=
 =?utf-8?B?ODYrb3dUWStYeDhiR1pSVVllS1hCMnBWd0xqV0E5MjFQdGdHRE41QXBFcjJG?=
 =?utf-8?B?Y2VsZ2VpNkN5MGVxdTNZZXhSTGpQOXdvOUR2UTh5VitTRFcvQTZXd2duVXQ4?=
 =?utf-8?B?eThLNld2LzZxWXlqK2NRQTZNWmpDNVhKTGFwaVRBZm1RNjhRQWZmUmNlUnRz?=
 =?utf-8?B?MlUxbU4rTm1CNFl1a3gvenpsZTdPUU45R1lQakxoY2RtT254ZlVJZ3V6MHUr?=
 =?utf-8?B?anFzNkxzekN4Y1Z0RzhwcytpWGRVcTZDZDMxdk1sam9jZVNRN3kzeVliWG12?=
 =?utf-8?B?d0p3SHNvSUp0MUU2c1VXNWlrYllLbytoc1ZxY3hmTCtXRVBoNzIxM1g5KzVI?=
 =?utf-8?B?YnJFNlhqK0xvTGFJOWdZbGZMWDVEY0lNUmJDSWFKRFh4dVdvRHVDTkVmc0t0?=
 =?utf-8?B?RjBHeGg4d1dkZTBKenRhL1krdlVlMERSSGg4RXlPQUhvZ21GY2Q0YTIyRjdM?=
 =?utf-8?B?bmNaWkIxdDVJMGtLUm9aVHRYYkUvL2VwbFZHV0pPOVdtaUJsb0NQVU83RC9S?=
 =?utf-8?B?Slp3YXZ3V2tHS0pEZ2lpaDd2S1FrN3kyMUU2TjFVdEpVeW5KeFJZQ09xR3dZ?=
 =?utf-8?B?V24veW1hVHpnZ011dVUwbm5NQ2ExUjR1Q2lDcG9BU1VmMkE3UEZaOUxKaGRl?=
 =?utf-8?B?OE5yTGttekdsZlgzblFIdnMwbURPa2dKY0htVDF4WHpUL2R6MkdZS0t0Tjly?=
 =?utf-8?B?d0I1RUVtZUFnZGRWTnJqY3ZLTHhQeThjblR4N09ya2tObnpCQzNUbzJDWEVs?=
 =?utf-8?B?cjZ1Y2QwR0VhYnAwL01lU1lFNmNSczJkSlBoL1drZ3c2aUtmelhNSENpbFFO?=
 =?utf-8?B?SjIrSkJOMmx4YzFrUEp4ckJDRTdUV2x1MTJVdVpXVy9CMldGRXliVXJVSkpx?=
 =?utf-8?B?ODRZVlNmME1sbElDbDJHZit2NFVOWTRkOVNSSjI2aWRXcWEzQ1RjaTdyNlFu?=
 =?utf-8?B?QlB1aENXQXR2bzV1TG1xc0QyNzVuNFVjdVcrNTJ4SVNyREJ4RThsbjNpOXo1?=
 =?utf-8?B?ckdlVnBveG51NTZ0RTFHTW50RVRZazRwMVBTZEpROHR0aFdOV2Q0b0RBMFor?=
 =?utf-8?B?dHVtUTdjNnR1enpEdEdqblZnSWVCenhaUlphVXF6dWFXdktHZG9kK0ZWR1FR?=
 =?utf-8?B?TVN4Z2pXdTVmeDZZZGN1OHZEeUpKU1U0Y0pNR1F6ZzFuSFR2WHRYOVJXM0Vi?=
 =?utf-8?B?aCtqeWhUMVlUYjdjVzdoN2poaFVMcDEzclRoM01STko4Q2Rpd25jbEMxcitk?=
 =?utf-8?B?OWRDeXpKcVp4MGpQb2drblM1RmRFaG1WKzV2eE1aR2I4RnFSdkJHWDRWdDFR?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563d7676-b237-4496-497d-08dd3c51cbb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:33:36.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxPIUA1PQWU9JATetCvjImOmcrIFn2jIl+nxSD6BLF/lvVeapKxXtT+/mdE2JobWZAvATkd87WSEaY5ea5p+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9165
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17621

On 24.01.25 09:06, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Lava generates an directory, in LAVA called overlay, which contains
> all scripts and tests of the test stage. The Device-under-test
> needs to be instrumented with with this overlay.  LAVA provides the
> possibility to download the overlay via http or NFS. We use curl
> to download to the overlay from a http server.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/security-customizations/security-customizations.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 75a6a99..9fbc2a5 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -18,7 +18,7 @@ SRC_URI = "file://postinst \
>             file://ssh-pam-remote.conf"
>  
>  DEPENDS = "customizations sshd-regen-keys"
> -DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
> +DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd, curl"
>  

Shouldn't this go into some test version of the image?

Jan

>  # Package names based on the distro version
>  DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

