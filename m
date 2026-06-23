Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27052CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 07:56:59 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15874.1782201405415582947
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jun 2026 00:56:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hZZy55wa;
 spf=pass (domain: siemens.com, ip: 52.101.65.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcT875apfA00mseRkFN+gpwLT6AHhvLLexKpqIBc02uTEWr+4TKr0h7qlmqUSCRBPMOmiqG80kR5oYJFf1lUrM/eKgtQvUVjyA/cWsZkYG11bj0E5cMNMAmZ7iVFTZV2fkIjpUe/nVTVvvz2ObewAk8rc3BHKy5sQsPtMWmKXG4PqogIorgeuV9XxFnvNlpK6AspQffS8KxLldga855/ZukzfzVc9wehBhCvOELs7DjkYl21keHPp74it2nO3Kw2Zu9S0Rp3n0Sb8cr7rKD32V0R3B2RejBF0ft6mVW6n6m+n4jESbC+1lblYIHe0I72WRAEMuVFBR49g/I153sUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CorDgSUiIA3//IFPeZT6s2L/4yq0EGUj8nIljfU7wC0=;
 b=UOMfdZHaul8u8AVGvRsd+cWZUOPK+ZhycT7itaO5V9NtuqdGEvpCGkyGNWR1W4JGATD3MAZyH2kzAj9vNamxA2wyDfKWE/9onF9JR2EmCOLszifseeWODDdlOLo7DtGLiaQWdNl1FFNsL0jTncvqmUkcd3RE34d/R0ggbniHC68UAq0PadYBaxIu7UbKQM3D2srZLezMxw2Ga4RBY9OXSSFZSjrx5NBt0mYb5oLC0cQbWgsBR0H0/+lSPVdK49+rssmmf88LpbmI6Tj6UY9Uz9qr/cFrn6IwDWS0wV91DadQgH+gmZIwx4Y6hVW5V8R7RrXIrupK79mz1zMFuf8SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CorDgSUiIA3//IFPeZT6s2L/4yq0EGUj8nIljfU7wC0=;
 b=hZZy55waLbxvbK8LZvS84VC2mGpZvOhva3JC4ZCQHkgEPRZWsQzw07d3h6GUmM3z5qPQ5YgZb/Jyq3mtuROklss17iqw6p+5Fi2vNlP+DqiDgMLvErpQh6X77D5Pl1F47GFSsUzXTxSgoyWwFZK4RpjTR6rprAipm2GK0AAXY+zRLQY0RyhMLZXC3vFtIVuU+HzDhRRv4aJuVMPr0Gg6EfIoJ4zogVneiw4jVRJiPWndJWN8f0a+ud7mGabXIMUbg/6QOSdaueWJZZFyqJ7fL4asdquWBU0Gs26gwOYDqQQagukMXDcNoIPsh416uIhnjP7d2vbQlT6YCkueKni5yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 07:56:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:56:41 +0000
Message-ID: <144a2c3c-dea5-4751-8632-2906aace8bda@siemens.com>
Date: Tue, 23 Jun 2026 09:56:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 3/4] Add crypt library packages for
 Debian sid version
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260623073642.964019-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260623073642.964019-4-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260623073642.964019-4-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2a287e-e93e-493c-79b1-08ded0fcf634
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|55112099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Ttcvt2xYWvpXNof42H6WFzK7TB94Jjoyc0P98O1uFbWwtXE4HnGuE2Lh3qeU7q8c6HmL3ouVpaZy6wTQ87MOC0XNpZppAMqCCAn+AjabUqCmCtz3KNHUt/brRRUwqxdj6b/QlaZCVQCt9VygGJi1AWQA6fiz27T01n6JrP4LdR75mxkMj7Dor2BUn2n2xOABgkhl76ixFexmu3SS2mZh8au6WMTHl1Mpy3ME79AD8qnhdmz2smS4wyxs3EEVsSpGt7DouOR7U+iJp5276G1ROT6rUHz/iPdMuIfsyc+FUuzPZ9+tMNitquJaK+Dtz5Jx6hvpShB3ODMUpfFB+TAC5kQW84qcOWB7asdgw/EEBwFXqpj2gwNn500jVsVpou9jZsBy/ux6sKs/MyoEIF8jO9j2eLpdEaVO0QEl9mvfD9xpbEui1GJrciozSWFF9yNNACw1ijN/CItfw4L+2sVfCEjDuBd9Z0iUOFC26hNVPj80WSA9a5wWgO0wZkWepq8czS/r/du2W3tZoFGCrlcQ2PhjgJFzQkboRhXPnO8pIBaMiQOzfBicSCcbhRj9de/5uJVSjj7Rcfi7SXgDR9UqugPTrUR1tQvr48Y1O+lPmQnLijrIsh9dLcEMO+R7U8ExJSDI0TJbLlYS/vsZDYZF4THR3/5QbIG+nt018BSxLpI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(55112099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGlaSmE3SC9yR3JqT3JKMjhYSHpqWlpiVHVDMkRWSVE5NndnRjlmNnBua3BN?=
 =?utf-8?B?Q2JFa25OZUJKZEZGRTU4OVdyNmRFa1lxTHlyS0Z3UUhOQzdjYlNPcDMzT2l4?=
 =?utf-8?B?Zjl2RXJQZUlwc0dYYzlSb29ESmJCR0xoZUM0MHd3NEFESkVpdlRpZm1uRE9w?=
 =?utf-8?B?cUpYcVlnNW95dlpjZHBQdWllUjB6MmxybTl1aUw4RTE0TkpzWklhY1VCbnlD?=
 =?utf-8?B?UmFWSUcrNGc5L1BLVkNRVGZzOTIrMnVrVUUrTUw4Rk1ScjRZZjZoUm5QL0NU?=
 =?utf-8?B?YTZCamNxTFdBdlIvRHVjRTdReEVmK2JvamFuK3VzMVF4MmJqUFltV0tjcDFp?=
 =?utf-8?B?Y3M1RDBienJXZWcvV3MzNVBNaWZzUVU4Z3pVMytvekxSZHNpcllHLzJJUHZ2?=
 =?utf-8?B?bWRGMnlqTVVEWHB2SmprTG12RG1zS3plWXJSd0RJZWVUa1NjUUZuVXJWa09Z?=
 =?utf-8?B?bHhZRXk4Sk5JMXhDalh1N0hSbVFNbWsza0tqelRScytnc0QrVW5YVGZGeFp0?=
 =?utf-8?B?TS9uQ21MajJ4Tkl1elBubDlNWGtURDBmVk5nRmZJTURBOHF6a0tYNHRBUC9O?=
 =?utf-8?B?TGl3TFRobDF0K0hwcjdvUGVYY0FxK01IR3ZaMlRCQ0JpcWl4NzByZGhPNTFs?=
 =?utf-8?B?akxPRmZiK1Vnc0xWOHI1RThybnNNNGtWY09GeXRYQ3NFZlI2Y08rcU8rOHpF?=
 =?utf-8?B?amRCQXR1amdPU1BNdDhuWTdkdEowRGF1ekdWWThyand4Ny9SVythTk42K0dO?=
 =?utf-8?B?SDZ5VS9mczlzbTR2Rmp4OUtaRmQyK2d5S3EvdG5iazU0KzVwbytudU9nOTJz?=
 =?utf-8?B?clMwRjJEcWNaRk9TZVROWXN0ckFVT09iN0Q1bXFRckhnbmlqQ0dqYjA2bFA5?=
 =?utf-8?B?cnV4OEthbU11bm9va2ZMQTM5eDkydDVhS3JoRHB3c2ZJK3BRaHZtcjZhUkUr?=
 =?utf-8?B?M2M4eXlvWVV5Q3dWWHZESFJ6K1d0akcrOEYyMnFhSmMvYnNydmZQWlU2Ukdo?=
 =?utf-8?B?djB3YlBqNVF3eWJXd0JYNjdRNkpCQWttd0FST2I4VnJ5OXo3VjJEWXI0cndm?=
 =?utf-8?B?cE83T1Y2cWFZRHdBdDBlb1didm5RY2d3SWRFMFZRK3hSV2wxNFlpUDVZMlYr?=
 =?utf-8?B?TzUvbHhPU0N1SmpDSDgyRVZYa2FubDNHUU51clYxNHZrRXFNVmhqZ2s0ejdU?=
 =?utf-8?B?NVlKb1V6azVLNnJ0MmcwZ3IrYU9nVU1HMXB3MU1MblFZbldXMnUrU0plRW9B?=
 =?utf-8?B?ZGlKeVBqa1d6RURYMjE1eHdwcUZMM0R1OG9ITk94N0pNZk1nMWxSQmlNTDF2?=
 =?utf-8?B?UFFnTDlzQ2NkUDREbDNvTWdJeVFQdy9YMS95dTVhbDl6czNSZ3JveGU4dXBm?=
 =?utf-8?B?UVVxbFFRMVJOVEZIV0Z6aG1RWDlBRHNoN0tVcStRSGJlc21QVTU4bXM1MHda?=
 =?utf-8?B?THQ4bGpuRGpGaGxTUEFXSy9odzdHcGFPcGU5ald6T3l2WWp3MlY2aXVtcTcw?=
 =?utf-8?B?TThlbms5cGRJdEJiN0pvZjdDVCt2K1NMeWRuaHZhK2tWTkNFMXVHUld0QW9M?=
 =?utf-8?B?bFZxNWQ3MmRocm52djdOalRPMXQrMFd3VUxrMVYwNU1vQTVXNVQzR2s2QVJM?=
 =?utf-8?B?RkwyM3pXZjhqcmk5NHhSSXJYRjVaanhvcWlZc3BHRmtTSGUxSUJ3Vmg2OEVB?=
 =?utf-8?B?ckN3MjgxRlV6elByUjdROGpNR3FqRGZ0NnE3WU5mV0hVcUhSK05TL3Z0TmhT?=
 =?utf-8?B?KzUvZmJuc1dsemoreWJhRFNlY0xONTJIdDNqdHMwaTBsRHUvUmJIT21aWklH?=
 =?utf-8?B?K3hmTzRsMkF0MzVubi9ZOHN6dWhjMDlUS05VVHZ0ZGhFemMwWWtudEFURjlu?=
 =?utf-8?B?aHJQWnNzaWR3TW45dHZLQTRQWEN0Vy9wS21OVFduM2xVVGdFVWtHY0JvMWw0?=
 =?utf-8?B?SjVDZTJKTkdWejRKOWVFOEFocXA5Vmk4a1RmeGhFak9JTDVnKzJUSmZVa1Nq?=
 =?utf-8?B?cmZGa0hKUVlTYzlrdE5DdVdYeE5JNDNlWDhpM3F0SmlHV0FNME5lSHRrWnB3?=
 =?utf-8?B?Vy9mNmc2c3B3VHd2QUcyaDIyRVU4Vit4RnEzTUd6ZmFuelhKM1NlZUNyelY2?=
 =?utf-8?B?WjVLeWh5cmxLMkJMK3pBMCtaZWxaSjJQVjNCZDhReFdxRGZOWkRZcnUzY1du?=
 =?utf-8?B?dng1N1N1SlFPMHJYM09JTkZxcjljaExhTi84ajZSWUNYVDBaSEJ3WjUyWFJE?=
 =?utf-8?B?bmNOM2E1TDVFRWFQMFh5YlV2V0dLVVFobGJPT0M3dnVUMGpqK2JJUmE0bTJW?=
 =?utf-8?B?VkRJSWVVbXYybFpOSHo3dFM2ZnBwai83eVFWaEJEeUUydjZIbTNFUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2a287e-e93e-493c-79b1-08ded0fcf634
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:56:41.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWreLcEz9K+cJ36qhOsTaTfqVqKxoTegbTN4ZTCZ4qiAzz88EmoGQRgmz+EXmi/AmNJZbbCqPWRl+63iNfc6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3174
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jun 2026 07:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23264

On 23.06.26 09:36, Shivanand Kunijadar wrote:
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb           | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index 3cb0520..9132ad3 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -38,9 +38,11 @@ DEBIAN_DEPENDS:append:buster = ", libgcc-7-dev, libtss2-esys0"
>  DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0"
>  DEBIAN_DEPENDS:append:trixie = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
> +DEBIAN_DEPENDS:append:sid   = ", libtss2-esys-3.0.2-0t64, libtss2-rc0t64, libtss2-mu-4.0.1-0t64"
>  
>  DEBIAN_DEPENDS:append:clevis = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools, clevis-tpm2"
>  DEBIAN_DEPENDS:append:systemd:trixie = ", systemd-cryptsetup"
> +DEBIAN_DEPENDS:append:systemd:sid   = ", systemd-cryptsetup"
>  DEBIAN_DEPENDS:append:systemd = ", systemd (>= 251)"
>  
>  HOOK_ADD_MODULES = " \

Should come with the sid-introducing patch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

