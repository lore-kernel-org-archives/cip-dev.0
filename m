Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B96C4451B
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 08:15:52 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4341.1784535348438368312
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2026 01:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=boPIKq7w;
 spf=pass (domain: siemens.com, ip: 52.101.72.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo7sZuAzyEkhgOddSsG0u7gVQFIBklAbvsySTpbTIax+LxyGVQSG3xjQPSPbZmtcPEYgGTOs+0U03+lSQcbO+ejamDJqEtQl9A1JYDkLQj7EBpxrKG0WVKhLIL6aEmjMEPo7RY2u61DDoDtBC4TByi80iulwVr449BZ17leuecA3hWqhhBZz2GZlFHflyvSp5QAHFvfehPiq9jQ2vmLtk5IB+M6JzB5TMsFAQH9vwVdOfRWsefNFAVA0ZnLahDjpTc9Q/cgAUJTnWv0RanAMBEKVOUK+ATSoVpM2lFvnFsc1rVelPrOHLvdfLV/u0bXDUTjvl4cSizUdpF91ekQSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIK7hPNMYGc3hSRiEDK03H4M4eqUjxx3i3OFiRviMW0=;
 b=Um/KQ72o0oEZiOQa0Mm+JwCRgup71ex3+h3Jeq3SDgvb/kGABjdoAGTjEtUooF29qlaNeEMdbc9rMe2wnvYnIB6Nu5UcrguCI6sZU4qh3jRvzWWHZS4QhWAuX1jwZdWyxWEHx3kAfpSNnOwdcj1CCrF+9CkxRtPmi5LtXI27PK+A6eKfZln+tS+iMGUi++nqBSv47+BKfbauPwPUIOBsEgHD1gAFMKAQfy+pLYF3b/SbPZmV0nPVP5AXQklVlBbl+mDTE4lVgw1TzPNZPL7eoLE3pf4yH+6yZfFljJiE3A6Fxd9L65mRiEbTuJNuSL7zew27UBTw25qaOVFOugqSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIK7hPNMYGc3hSRiEDK03H4M4eqUjxx3i3OFiRviMW0=;
 b=boPIKq7wh4ki46iThJjJQnH/Zy4Gfr+Mt/vrHexMJWEZ0UDVfJIc/7NeiQ7IHLbS3VNXG0PdpV6y+sG5W8MhQONRxkFSI73ZZU/8Mnvk+qT8/lX4uqCeI8JmMD9cbEcIH0r1MOWlNw6kp97c8kdK2lIq+FoOyMTBfwyp0YZRBAr1N7qHrIkWB7CrhCKUsE+qBoqbPGpdycnsK9sJD1y8OCJPCuTPnHWoHeHM84FtOwuB9lkJU/VdEd7/9dxT+KW04kaVyLDBX1PFNtM3Qzbki+RgBd0FJzdNGETdAm9xCc6Ost7PX6Ic0Zkfiw3qOxLuX8FODEWHJHClu1iVENztQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV2PR10MB6383.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:15:42 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:15:42 +0000
Message-ID: <12faad9e-1d54-4c30-87cb-2279652ff72d@siemens.com>
Date: Mon, 20 Jul 2026 10:15:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 2/2] swupdate.cfg.tmpl: Add
 digest-provider option for signature verification
To: cip-dev@lists.cip-project.org
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260720045903.733394-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260720045903.733394-3-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV2PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f14df87-64d2-47b7-b84e-08dee6371759
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|4022899009|23010399003|366016|18002099003|55112099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	9EEHAah4e5OETpCgnNAggdUchZxFa7FTWk82AgO7TVmYiT0Rn+uvjB+MuXCq19zV/UO8k8fwcqiYTrWBUhvqcYCoB/exZRVZ8Wjs3thLUpN89BGO1TEWjIbJswHXlhUbX89HkdYEO6EFNy/gkUgm9cQ8npOJ0e7AaE9xg0kwl/E4xIRaMZxwxnuw6jSwjLujp3HSxco9Ku1mZ99Dh0q4L30oMJk6eNFc1Ab20/oeaTOq7oc1KHnZ+c0vW0NXaIrk1hH/xJtUisCgMZPuHwVwdiQrTSfM++rT0RvCTL0SU5NuV3GzzEJZfuG86jwOj6+kW+K2Wjuq7SCFWovTPj13tl9cN+QOuhffsx9Bw0RToPqwOrimvapFTmCDBsuoiKJ23zK0LRh4ajiR/b5tkjUgMpri5M9BQFXrOfmXnSGSktyo1Yp1el/NJiogsbM1DlwfL+ewQztrS/KUdDZ1GH+ddDHyX+46tYLL+Obsrk73I0f16H/Fw5FENDJJXxOi4MToQ9n6LctcRbBTwRkMsA5eJnr77DGnro7Mm6EBUxRrtE3qwZintFM7f1TZY+pKZvKN5tfSWGeOjYF6T1qi45J6yUbPsaCcLjckg0//U7ixEnXGLJLWkMUGdeW349WSVWbz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(4022899009)(23010399003)(366016)(18002099003)(55112099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MURWUjJ1UGt1MGE2UXowNlhoQ25LZy8vUFlFWDNPWDVmZmZ2OEdzVExEN3V2?=
 =?utf-8?B?RFJlOFlzWmRXQWxrNExVNmpzUTc5bnFRZVJYLzlXV3FLTmZhTUY4bW1VZXJ2?=
 =?utf-8?B?U3RxelB3ekVoemZQci9rUE1DUytqM05TM1RLN2NhVlEwUVZXT283amJ2TjdL?=
 =?utf-8?B?a0E1bGxNZlhuNkpXTjkrOCtyYXV3NEVVS0x1Smgrc0EzTkVLSHU3dTBUS0dn?=
 =?utf-8?B?bFV2bHp1UTJBdFQxbW4wMW8yTzFaeUZkNmJZN1BvOUhjRHVPMVBoK1pXeklx?=
 =?utf-8?B?Mm9ndEhaMUhoQXFPbmtkdzZWaEVITjUrMStTQ3huYWQ0aG83Qk9ZTHBBaFRI?=
 =?utf-8?B?Y2N2cTZGWHh4Z2xYdUI1bDl2dkRPanJWbUNmbVBhdEdBaldxWHZ5WitCVEhh?=
 =?utf-8?B?WmNnQkdlU3p1c1JWbzQ5UDdIRTh4azl4dzQvNS9EcmlBVFpyaVpHelo4dlVU?=
 =?utf-8?B?SjQrVy9zVFB1c2RHYlRwSXdPTWMrMnhDa1dEblJ3L0JUeHlZbDdiUDNTcmJi?=
 =?utf-8?B?bnBZQ2hNdHpyTnBrYWorQnhId3Z5ZDNmbGxYczVPd2FyOVdEYnVoVHp3TFdG?=
 =?utf-8?B?aWhXaEhUTGVWdUxyMHZCODcwQ2FSZHhTOEhuamROeVFmdTBSUUpicTBqQ25a?=
 =?utf-8?B?dUxRM1NtOVN6SG1ZSEJ6czJ4ZjlMOFdLUWVoL1ArKzF2eEJoMTVNOUxZbE9r?=
 =?utf-8?B?Y1U4NFVlM1RidzVIUTlnVjJtdXV1WVA3L1NiRUo0R0E3eXNJLzVNRFVJdnln?=
 =?utf-8?B?Ui8wS2dTejN0WVZ4YjdQdzBkZkFGV24rMVkxV2hVM3BKQkpTZUk1eEZlQVhN?=
 =?utf-8?B?YXVlbUZTZnJPcnFrUm5CZFhlUzlMTnRwTStmSE0xbm5Qdlo5aUgzQjBZbU42?=
 =?utf-8?B?REdIM3JwckF5d2x0c3pQL2tBQ1NIZkhZRGN0N0dmK28xOWs5SGZVbjFOeHRu?=
 =?utf-8?B?aUlzSUJ5cTluU1ZFSDdvc0xuU0hZanQ0RlBxY0dZTzMwVDZ6ZktuNytWNVZB?=
 =?utf-8?B?NW5kV0JTNjV4Q3hzZVdra2g5d1QwR2Q5bUVhQnFkSEo2aEp5UW9qQ2d5bU9p?=
 =?utf-8?B?R2pOMXlZOWhoS1JaZWdSbjBqWnFBai9OWHgxcVZVRzNVMHVKR2d0cGhkZmU0?=
 =?utf-8?B?T0h5VE1uankzMy9Md0NVY09LOFkvK3RqQVZJb0Qwenl2M1cySnFQN2x3L0I5?=
 =?utf-8?B?RFVaSDF0K0ZQRlFVOXlmUmJPaHV5dE8yeWhyTmpXemx0WG1zMjRrZERsK1lH?=
 =?utf-8?B?T2k0NHJlOG1vdys0Z0lvYk9rWnFHNmFNcE5rMHl4K1NhSzQwY1NYZElkSFFk?=
 =?utf-8?B?NmxKTDlWMlBFQkVMQ0plZ2ZxTnBjNndSN1JFaGt5NmVrT2R5bHpoV1NZTzJj?=
 =?utf-8?B?UklxVzFiVEppNEpydkk4bkFJRVVlTUJLSzlhbkpCN1UxaXljaVp3RVd3UExU?=
 =?utf-8?B?VEVwVU5BTEpUMEhqeDRCM2lGSWpWRE40R0RYd3drb0ZaOGR6MCtRM1pRalpG?=
 =?utf-8?B?VGUrMnBtTGVPVmVPTVJHVzFlK0tjTTk1YzdBUlNHd01XQ2xaeUZOTndvcnU0?=
 =?utf-8?B?WWtiUjBURWJmVkhQNjZWZHdQU2Fna3Q3ZHEySXpsOXFleU9jMVdrUlRCK1Yw?=
 =?utf-8?B?TTVWUldsb1gyNE9rUzFUcit5MU4xTGs1Nm54c2ZJOTNVcEtQbmpueGJaRExh?=
 =?utf-8?B?bVNJeEhBclY0Zmg4ZEVpL0U1aU82RURBUHBpTDY4OUZmNUdRQ3hDeTRuOXVH?=
 =?utf-8?B?VExYZHh0QnVLMU1tWEVacTRNYjN0OStBZGhvMHlyU1NZYlg5ZWRZSWRlVDZv?=
 =?utf-8?B?eEEvR09ndmdRTlZxUVlhbThKRlRwSXdPcmo5a1luMjFaOE1XbkxhZHFJd05C?=
 =?utf-8?B?MWxwaUlKVFJyWEtLUkE2VndzeDdHY0dBWW5ORnFUUlhhekFzNDNVaUhQZVRo?=
 =?utf-8?B?ZncvUFdNclhWVVBKSVlwaU9UZ1gvMGNHUm9YTGIvMFVzVHVST3plRW8yVXNk?=
 =?utf-8?B?Q28xMWMyKzgrTm9ndGx2VURtZUtjZ29MelprYU5OVCt3L3BhOE5rdmV5d1U3?=
 =?utf-8?B?ZHN5aHBKbGNjN05ncEp3Y0N6VDh5ZWh0WlF4RWJ5d2lleCs3bDloQXNOUC8r?=
 =?utf-8?B?bmxTZEUvbXpFRXVHWndmUDdtM0pjaVpTdjJlaUY5QlllYm1uYnRnQ21vSjBZ?=
 =?utf-8?B?U2VGRCtqaDhlam93ZCtWNFJhZHprSzZySGZGNENtY08ydkF0ZjZtMVJkeHBh?=
 =?utf-8?B?MnRQUE55Q1kzTGZGUC81U0RkbXpPSnRBS0VpRTY4NTZ3U2d4Mkl4QndMdEpu?=
 =?utf-8?B?WEZJZk4wOG9iUHJ0UUVuUGZQK2tuak9RS01BbmIwQkYrZVF4aUV2MFJsclZN?=
 =?utf-8?Q?FmD776ECNxfOrKnA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f14df87-64d2-47b7-b84e-08dee6371759
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:15:42.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZJO95gNI49V2Lb8uKzydO8riQwmeZluYWI3FxyYpx33a/2vDP5nbjxiNt5WNgBwkIi7FWR0FLfcw79xqRzClo5Qi3gri8JPpLtEzfo+uiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6383
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 08:15:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23674



On 7/20/26 6:59 AM, Kunijadar Shivanand wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This option is introduced from v2025.12 onwards in the SWUpdate package.
> It sets the crypto backend (mbedTLS) that the SWUpdate uses to verify
> signed updates and compute digests when multiple provides are available.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   .../files/{swupdate.cfg => swupdate.cfg.tmpl}             | 1 +
>   recipes-core/swupdate-config/swupdate-config_0.2.bb       | 8 +++++---
>   2 files changed, 6 insertions(+), 3 deletions(-)
>   rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (77%)
> 
> diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> similarity index 77%
> rename from recipes-core/swupdate-config/files/swupdate.cfg
> rename to recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> index 3e2b45c..44d8d04 100644
> --- a/recipes-core/swupdate-config/files/swupdate.cfg
> +++ b/recipes-core/swupdate-config/files/swupdate.cfg.tmpl
> @@ -2,4 +2,5 @@ globals :
>   {
>       bootloader = "ebg";
>       public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
here is semicolon missing.
> +    ${SWUPDATE_DIGEST_PROVIDER}
>   };
> diff --git a/recipes-core/swupdate-config/swupdate-config_0.2.bb b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> index b48e3d1..584706c 100644
> --- a/recipes-core/swupdate-config/swupdate-config_0.2.bb
> +++ b/recipes-core/swupdate-config/swupdate-config_0.2.bb
> @@ -19,12 +19,14 @@ DEBIAN_PROVIDES := "${PN}"
>   
>   PN .= "-${MACHINE}"
>   
> -SRC_URI = "file://swupdate.cfg \
> +SRC_URI = "file://swupdate.cfg.tmpl \
>              file://hwrevision.tmpl"
>   
> +SWUPDATE_DIGEST_PROVIDER ??= ""
> +SWUPDATE_DIGEST_PROVIDER:sid = "digest-provider = "pkcs#7mbedtls";"

It would be better to pin the version for the previous versions instead 
of sid.

Quirin

>   MACHINE_HW_VERSION ??= "cip-core-1.0"
> -TEMPLATE_FILES += "hwrevision.tmpl"
> -TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION"
> +TEMPLATE_FILES += "hwrevision.tmpl swupdate.cfg.tmpl"
> +TEMPLATE_VARS += "MACHINE MACHINE_HW_VERSION SWUPDATE_DIGEST_PROVIDER"
>   
>   do_install[cleandirs] = "${D}/etc/"
>   do_install() {
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23670): https://lists.cip-project.org/g/cip-dev/message/23670
> Mute This Topic: https://lists.cip-project.org/mt/120354799/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


