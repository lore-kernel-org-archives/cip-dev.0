Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D5FF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 09:14:49 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8785.1777367687415620062
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 02:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QaXF6w/F;
 spf=pass (domain: siemens.com, ip: 52.101.69.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWIxZBPPqWCOlYERNow9i9jGnfckBfpXfZIdNzWZjxWtMxYfTkQGXnaLWw3j6Ar6e1abOCYM+RLWMFBnVwYGMhDQMizSqEa2mrJTv7BQG8KQPaOSYE050BIH6q7k+7FYP7BE3wXA0vF2d3lfuiMQdA1NQYOUp2x3OCxbSAQIW1JVDwuQE7QyZ9RGggCMdhDf2DGKwDlkTEILQgnTWZGhgROz6mkCoIE6pV0YuzNhhF0tUjJyUKWDQTv2A4JgpEWE0ktzcWk3/RAtFOiiZMd/iS2jWJvjp0WHxqIXtV/furdpRe3p3TDlzGiGzx4TJJRvppAF8znYKVxncwEnqRjlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lNsj6L7povN6ejDEyhP+w0qMMkBOT7/94kOaeHArck=;
 b=mOC5QMvFwzwMdPVVfNvGscsdBG1KRF1KE09ZydDtE9wNB3MkzyT7wowehfWdHWZkimNPfF8X0qcLJXqsmsfUU+0a8acexgwEpCe0vraZG5XwmqLKtO7ObfqRfwhJpwFSWAIVlsGpQLmYXUppgCX7oP+qYVOpatHb4WfkWdS4FqXqH8U0v2fBEjmLOojYkitRCDRATl5LbhHGfwMrjW1OMyXVTE6RlVJS+16WcLls2MVRPwQntLK0gpEnz4z5YiywJqNqsgmiFFwW050lhiL5GIb9yRZWR9kiyEc1O6at78zINokTUMqSTyI7JAdAxD92PpX4Y9C+6TxQ4SbEeUTTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lNsj6L7povN6ejDEyhP+w0qMMkBOT7/94kOaeHArck=;
 b=QaXF6w/FPz/Ppv28HnMqDq1HzVBxuGmIlFxBMDfglsFIIVFUDYREZSvLItgi4Zd003/t3/GU+hwpM0tqifEOGDODsNZ6FoS2uEqUd7tlI4nl27tzorqU4dnxoIz8FGKnlgYW8u26EYV8flgOCMqMrZeXfEy5UXk8RAM2nLolUTamv6l3YuBOW7vDk1QjoPrK0pSWfvSoQfC9MmeQVG5aNTlyLvhNEIDiZFLDgVcJm1tAaO7vQi0Su6XdtmMxXJgRfG7yggns+0v31yFxxOFL20kMXitcCsIj890Q6asEG+yv1pDd7H1bmTMIZbe/bleLWM6TMU91evR8VQg2bbaH5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 09:14:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 09:14:42 +0000
Message-ID: <9c22fa0d-faa9-46d9-9c3a-7030e24707d0@siemens.com>
Date: Tue, 28 Apr 2026 11:14:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] crypt-hook: Check if WATCHDOG_DEV
 is set and available
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260428091124.1765253-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260428091124.1765253-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fb2dbc-c56e-4499-bc3c-08dea506950f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	CUJwD5JwFjNRHZLVAijP3mSRe+wZ2yZUSjEa/RzgQ5mlNWFe/LQ9jIiD4aD3ryvD+J0MqMMZ8ivASmIXh9ex14qTHR3v+jsITEdVxNwWhLlmyfg2hl0X5KWlKSCVASvl5KY1YZKSdvrzhbxLpjTKhL1vwfl4p4Eridp0YFt1p6zh8PIX3nmL6x9q/iXn0UEeSu2MctmPrYsAkOHtgikqM7eNE9XYjdFwfklisBdbvMnqeljbO0AqZXMCQI3E7ksEr02r3ECTKPv5VfNElgFgy2W82fdLF0aeFUpIk2+HXQ7Uzhzar4HUk6v45ZbrzqHt78FcBz1yma3ybl2MsbrFtPTGU6j2e2JPzJjeKiWQerSmlHLTAMmTZswLKGyHTMZdIKCOHw7PJrDFepwwCbvUlMQovuxc2ImWMj7iADUDLEq07offLwGJqqBPvBYdk4vFuKkdML/OC1b4KjlTp/v3qq/WbfRaEq2ZO+Y/aokX5ZqIg2/KomgIHgYPsruSvxJxVBmO+PrUuDrw6qgRuB+JEQC0GwLX7twp4+SflUbhepVj+o0Sq5F3HSdblBuipIkXiADKjrRumTyB3C2iM5Fh0AX9R0wnGlz3xBypupgjuUpnImKZK3GT4Xcxt3W28kIwRQT5G6Tmv3wVTexlQIyFvcdSV6Zmu4bzJo8A+H1hHdQvs0nVf9MVchu/FDIL7AFAdTPEEOCs/YNgnICbkRGCTgPL4Il6rfwlKca+eSNo/wQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aGNIckZ0NTcxc043c0dab3orank4UVJJVnMwVjBrWEFpZE00QXY1MFRPejh2?=
 =?utf-8?B?dnlKbk1mQzZQT0Q5ZEJ0c2lyYU9ZdDdmSXJkcmVneC9QR2Y5aUdJdEFHTVlZ?=
 =?utf-8?B?MjkzbnpEdXBaUVpKemh2NncrVjJKcDdwK2c1OXpLcTZESEU2M0F6b3dYMWNv?=
 =?utf-8?B?Y3hvTGNtc0tBV3cvdjJmNVp3anlFdEFBb24zZVIxU1RpSW1tMnIrRXE1Nmoz?=
 =?utf-8?B?dDZmbXZrekJyMGdLeDN3Q1dLMWs4MDlodlhvTXJob1gvOTFkbDZ4aXQ4WHU0?=
 =?utf-8?B?bUEzbkZnV0NDZnV2S1V5ZEVsZ2tLMnBQRHlvWmx6SmNQcFRONFpvU3B0QWtu?=
 =?utf-8?B?SHJibldkYmlxRVorQmdGK3dsbXF1TlZXMkU0eXNIUlF4cDVhNU1YVE1oRTUr?=
 =?utf-8?B?Zi9GNG4yMkhrNllZWDl5ZUt4U0hPUzBQQnFnOU42RW5RMmU4UFlHWmRJNG1I?=
 =?utf-8?B?NWo4YWx4cWxGa2M2RzRmdEF0OGY4R09VcTkwTWFKdDRTSWtDbGR1M3pNWE5i?=
 =?utf-8?B?LzlaaGdBZ0tkMkJyOGJOejZNTGdmVFRrQlRoNW9ITjlWSnVMUmUvVU5XUyth?=
 =?utf-8?B?WmlNTGFtS3hXY0s4K2RmRThWTlBXQ0tnRjNSaWRUQ20yVjg1dnhJdGNuWDlB?=
 =?utf-8?B?Rm03VGJYWEpQaTB0aUU3eHJkVlE5N0R2eGUyRDRFVEFLdm5YTGNBRS9nNkJ0?=
 =?utf-8?B?OXdLcDMzQ1FVem83UUF3OHB5dmVadzFtNVVrUWFQcVhYTGtsajN0VEJOVHJH?=
 =?utf-8?B?eTdZV3JLWnl1QWxoSGoxUzNlSTN0cm8yOHVOdlNnV0JxM1Rvd1VxMmVlei9a?=
 =?utf-8?B?YnROZEtWeERjQ1ZnM0hId1JEQzN3RnYxaWJVY0g1SXZSOVE0N04xVERJV1c5?=
 =?utf-8?B?WUNOYlFoelJWbkxuM0gyelNvMVI5TndmTDhLc1ZPbEcvMDFTQTl6Qm91MGRu?=
 =?utf-8?B?d2pHTEtaY1pmZE5ydXpaRnBZTm1sSTVXRzBCTkVXaUNKSWo0Ri9CaXNGVXNB?=
 =?utf-8?B?QUlQVDA3ZW1NYkhoVnhMYVRDTXlnakhTbHRwL3ZHMGxZanZWN0hXa1dCbTBy?=
 =?utf-8?B?bzBEdVhNam9BM3pEQnZ1R3pUT3VIajE5QlNlYlN4WFlZbXNNbG01d1M0cTl5?=
 =?utf-8?B?ZUdFN0ZuZnJNU3NsV203dGxURHRVb0tlUTE5TitiYkliTjhzN2h2UUl4L1Ar?=
 =?utf-8?B?bDQxZVB5UWEvaGJMN241WGpDQmRqUDRobjJiRnFkd1NIcm84d1RKYmZvZThX?=
 =?utf-8?B?R1NDS0RtSWw5TXQ1SGpVNmt0WHd5Ny8zS0k1YnNOcEFzVlFXMWRmY3NUSTdZ?=
 =?utf-8?B?V252OGdwbVNreWYzZU0vQmpPSVVrbndCUUMxelhZUURDQ1pXTkZ6TG1hdThP?=
 =?utf-8?B?cDZGcmVZOGcrSHgzaG8xcngzZDNZWHZsbHV2bEtwWkxvZ09jQmpxeXZLeGUy?=
 =?utf-8?B?aUw1RFllNTdpZWVVdkRXVE8vQ2JlZFVuUk51WXlNSitNV3hvV3BwczNBbFdn?=
 =?utf-8?B?ZmtzcVhHT3o3Z0xsWnlhcS8vZ3lSVTVOSWsrR2lSRFZkbFloUkEyYUtOYWpC?=
 =?utf-8?B?ajBVR3Zxb2VUS2Q5dW90ck5Tc0xzQ1plUkxDVFFFVk5FcWdqV0JZbTR5YTYy?=
 =?utf-8?B?S3RHNEVySWUvWlVzRTBQc2FqazB5aTY0RXRsZy9na0s4WndpUkZEUjlwM2lr?=
 =?utf-8?B?dnpsZ1VQQ0h4S0l0S2VHREJmREpFRExQV3NENlFtdTc3NEFwVC91Y01aU1Jx?=
 =?utf-8?B?T0VHNWhtVVRiOGpobE4rcUxKZFFOTVBRQWcvMmJldmNaRHFpUUVDMXhxOFNH?=
 =?utf-8?B?UUhmZFhPaVI1Sk4xNXRUVVRSay8wWEd2ejdSSVlOZVJJRlZTMGVmZDRwN3Mr?=
 =?utf-8?B?MEdwblZlWldKMjhZbkN5S1oxUEVnL1lvaTk4M0F4ZzNQZEwwRlBZZ1BVTWZT?=
 =?utf-8?B?SGxlZlFablpvMndCeDVDZEpteFBJSkFiMnhLenhOMEpQTk9lNFJ3WWs1WTYx?=
 =?utf-8?B?Z3VkK21rdHpNVzQzb2k1UjQvdUFnblBrQWFqMWJ3bytabXBYTmkwSzhNZ2JG?=
 =?utf-8?B?K3gwUVNTdTZCcldmeU96OFNKcDdiRUVHNHU2S1JlcXRyODgrK1BtMmI2Qm4y?=
 =?utf-8?B?MUhZK2tTQXNJN1podHY2Z0gvM3FEQ3hMU0V0STR5b1RVQ3Y1THY2MEV6b1RN?=
 =?utf-8?B?aDJaT1lHM05aS1E1VCtGOE1NaWZkSEsxczExbFRqSUtQSS83dVA3S05jU0NS?=
 =?utf-8?B?YnFrSHVNWTB0T2I2Z2pYMVB6SU9jUEVId3FZY3NsbVBJSnNkS1h0aWVtcnp6?=
 =?utf-8?B?QkhEU2ROeEh2Nm5kUDJ1YmFWb21zY2ZydlFUbWVpZlE3ZTNsM0ZuQU04Rlc3?=
 =?utf-8?Q?l2ULVYf+k4jYXz8M=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fb2dbc-c56e-4499-bc3c-08dea506950f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:14:42.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH5kKulMhA4zNBhBEjnkKoNH7qSd4ieDorV+yS8Ifp3cPIlS7bqLd+2D8rFoaMh86tXvGjN6Nw7wvI5+c+pLFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9126
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 09:14:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22815

On 28.04.26 11:11, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This avoids an error message on systems without the given `WATCHDOG_DEV`
> and allows the user to disable the watchdog by emptying the variable
> `INITRAMFS_WATCHDOG_DEVICE`.
> 
> Reported-by: Stefan Koch <stefan.koch@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/local-top-complete    | 12 +++++++-----
>  ...ypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 4f3eafc..fa4980c 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023-2025
> +# Copyright (c) Siemens AG, 2023-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -64,10 +64,12 @@ if [ -z "${create_file_system_cmd}" ]; then
>  fi
>  
>  service_watchdog() {
> -	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> -		printf '\0'
> -		sleep 10
> -	done > "$WATCHDOG_DEV"
> +	if [ -n "$WATCHDOG_DEV" ] && [ -f "$WATCHDOG_DEV" ]; then

The first test makes sense, but can't the second paper over bugs, or at
least make finding them harder?

> +		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> +			printf '\0'
> +			sleep 10
> +		done > "$WATCHDOG_DEV"
> +	fi
>  }
>  
>  check_partitions()
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> similarity index 99%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index c0572f2..331a662 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2025
> +# Copyright (c) Siemens AG, 2020-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

