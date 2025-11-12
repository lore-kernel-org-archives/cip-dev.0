Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A773CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:25:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8027.1762932314091446132
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:25:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o2nDdh9v;
 spf=pass (domain: siemens.com, ip: 52.101.84.10, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdrDbJioltLBuAvsGW5uqF4UMYWK6kTDSMV+o2GunHOAeQ7e3PP7vRKc5DfEMqpEvril+Yb+GLa6Q4UYSBo0gpAhV5appaDziuPNi47gkvTwcxvTfNoVrGLKHhgcDbxQnPjhSK2qytp7UYgFyoJFeU0VdL+5+ThrQp7WnVc0cFnenhaTdWE/XtYWg0EccDUJ61R62w7ul24mY8HiRiTBkbGK3Dvo8nEbQDjtU1Ehbcu6f8LD4prflu5HJ2JHv23IfrfUfGf8HuMNVFoXgqB6cS85hUk4MB7TW6/meRbyOyqm+yWtDgNrJJK3xI6GI1peHQQcjyBeFge+w1OvAb7EuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKxgKiljoiKx6XptzBPeXl8Stmj4Fn1e7xM7WebrT9E=;
 b=ODWm08lfG6EWRX1mdWehwxsmbK4gpFvlrpW2CpNVvUuxwhOOUAAmpTt1dmUL0UHiWxrXuRKqxnQu4MXKOKGUYV0dRYdP7Oi/Xlh7nMT2THKQ/4uMnyclxA+WnU58rmpQG0oIywDH+8nK5tPapeMj7euXmxYj8zIdF1SrRFWiDE1yIZrQ8jAY9P3wraEZ0VMW+SVKLX4cSvJ+ZDmMUnPcLsuhhoZVJD07g5xeiL2L13HKnI4Q8xCyOEci+41prat7CfSq6DiYaqiSzMIcZi8Y8Yg0MrIEfTXv0vE2ItIUXqrExLU4WpWfEBV9NWlF+yuw8AHSphWApS+x7XkT7IslhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKxgKiljoiKx6XptzBPeXl8Stmj4Fn1e7xM7WebrT9E=;
 b=o2nDdh9v67hvkzzy8t9EwpA/+VRO77x+bO4XEV/YxdH8dV1sE0bIBnOS7K2Ng9HWNMPTXt+CNoH1eRyoMSHU16CgLEaxe7VyJ31Xh5h3SUy1KHa3x2MCKNhUnAB+T6HNSn/DtYr2AM8IJeGCo0zCGMsus7qOkX8oJFMEUKFoLQVqBpNOwR/50jaOlixrqTswwlpOOLTfJ6P07rpO2E+DNOwzc6e0nsstOUSpPbCOQMJ9dusfpaZjIpjggNLzgqHpN65mwITo/7s4jc5KUGlxN1eKmKf2ehyPwU6bLURVFf52XW4xhnzRzHgh1V8VXFpn6tpaLU6+QUeufO9zX0bH3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:25:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:25:11 +0000
Message-ID: <18f1c614-730b-4ed3-a138-c2ae2c74c65c@siemens.com>
Date: Wed, 12 Nov 2025 08:25:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 3/5] Kconfig: Improve modeling
 of Security features availability
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251111164508.1707234-1-s-adivi@ti.com>
 <20251111164508.1707234-4-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111164508.1707234-4-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3815:EE_
X-MS-Office365-Filtering-Correlation-Id: 808d1a37-5b56-4aa4-a656-08de21bc9d3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VG5hNE9OdkN4MXljbXppUDZ1SUNwamM1NldSaTZ6Q1lMeitGVTJ2QzJraith?=
 =?utf-8?B?QkRJVkgxMzZoeHluekl4RkRlb2dBS2RDWThjMlMvM005bDI5dE9qZ0ZwM3hX?=
 =?utf-8?B?Z1VTcmFqeWlNOThvTG42cjI1OFZmczMweWI0L3N3elJMK0dzRW9nOVN6SVk2?=
 =?utf-8?B?OTVQZ2xqN2plN1JtZVRsQUJmNWp4L1NuN051TzI3SmlkYnNLeFdYN3k2ako1?=
 =?utf-8?B?eGtQbnpDSHBPRlRQaS92WmxCaUN2UmZRcjRXWUd3ODVHNmlyNE1RUjBmTDVl?=
 =?utf-8?B?NFhaNmEzaGlMbUJOaVJMdzB4eGhEOE5JQXpqWXBsYnRsT0QrS0ptL1E4UFVp?=
 =?utf-8?B?alpTVFBNcFZ0d0pPQnZyM2phaUdvRXBHRU9iUVRic0JsOUlvU2ZUVXloUlZs?=
 =?utf-8?B?dzZyYVRueG1ER3VJbS9oVjN4SXEzTzd0dGpKNDhLVXg4RXYxeHZodStqMnpK?=
 =?utf-8?B?cGw0MXpONUM3Rm1OeUk1RWZHQzRIVzREb29NRjdMOFhMaWdGSkRaeEJZbDZu?=
 =?utf-8?B?UmhWZmI0RXhLWmYvakc0ZG4xS0NMQlZFVFVHZ1diZjFNajFxeUpKWEtIMklu?=
 =?utf-8?B?Q2Erb2t2ajBJam9IZ1BwcFQ0blpNQmpneWlPRXhVMml6YzdINEJVZ0RpREVj?=
 =?utf-8?B?OUJHanQ4UjRzZ1d4N0ZiU0NDdG01Q1E5MnhSL0QvamhjSWpaczRZc1o2QUxj?=
 =?utf-8?B?T1lLR3NZQnpyRkUrbHM4cWh2TU94SW9SK3QxYmZydnZEdjl2Ny9sUXRWNkxG?=
 =?utf-8?B?Yjl0VXZMb052eEVLVkZ0R0J1dmhIZWROcStLUE1JNGtlM0hMbjBGQzdJYkRC?=
 =?utf-8?B?dy92YkpJeVI0WmIwMTdIWkd6dlhKbTZaV3V6bGRFd2lIYlRnb0lOTXMzQWI2?=
 =?utf-8?B?OFFxUjFNVDJaem0xZDIrTGkrV1NPL3F5cWt4Tmw0VnhHV2lYWHlRYkNCUHpD?=
 =?utf-8?B?UXpiaDhTVEZzcXZ0NW82SThJd2MyMDgyWE5sMzJnVFVHM0ZPbmNZWnZxajJj?=
 =?utf-8?B?aGRna3VkMGNiZDljWCtlZUNyMkhFbElyUWFGMjdKUXpUV09MeGZqTm5KeDdK?=
 =?utf-8?B?MWxvU0QyK2VBR0pFdjJXUzY5VEFsb1dQWFl3T3FUenM1aUxWRkhRZ2twaFZQ?=
 =?utf-8?B?RWUrWG51YnNlZGRNYTZMVE1UM3dqVnQ2QnFGSVVvbDVDaHJBUDBqMStoQ2pE?=
 =?utf-8?B?b2l4dkExV2pzdVR4aDFvZGhDbUI3UTZwaDhuVlNGa1N6NkMxb1ZHdmplbzVw?=
 =?utf-8?B?NnNTL1FFUXo2ZHFVeGM5aUk0NGxQUVlEVEU1WjRyWkQ0Wk0yamlhVGZ0dWhF?=
 =?utf-8?B?WGdQSkdRVGRmMmJIS3lEWHVSU1VBYlh1ZEZGMjBwWjhoc2dYVlV6N20yWkhv?=
 =?utf-8?B?aWRBUHpNRnJSMTBMaDAybkdzTXlza3JmNWl3Slk1L2hYSHVTaFIydElSck9n?=
 =?utf-8?B?U2pFYTlabTNCY01XMlRQdU9HOVJ0a2VZWk9NMkZVdkZCRm5TMm1ucjhZOTZJ?=
 =?utf-8?B?cytLRW9IQXdWcVpBNHdTTWJndmt2T1U1Z0s5LzZDSU5FTzREbHc3R1BDMnhw?=
 =?utf-8?B?V2MxWVB6aDRwV1ptT3haS0ZVSDJzTUtLU0h6YytNekRTUWJ0dllQYjdJUmox?=
 =?utf-8?B?Y1dkaldCTVo3azlqYVA0bUx6M0t5dndBc3J5UHJRZ3g4YWs2QjdjQ2kvTExL?=
 =?utf-8?B?VkppYXFxeTJDNUJGZHZ6OG91TytHUWZ1blJkWmJJRkRlbEszZ2xsbVRmMUFK?=
 =?utf-8?B?aGw4YTVEcWtybEpRNXBNcWpxL1VRbDZtb1J4cDNaZDJpZ2hMa1FRb1UyZWhj?=
 =?utf-8?B?ZFFFdTczeWVidHRvaW1XTGIzN0R4dTQ4cFZ0a1JROXVDNllNdGRPcDFycy9w?=
 =?utf-8?B?eU5XU1U5QVRvWkJxSlJmTTFjTlZhR3RGUjMrbExaOG1nYmRlWWFIYmxScUgy?=
 =?utf-8?Q?llrlCtssNT7EU4BGb4589hfpDpBaIMdK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yk9oZ3hjZGdHUFBNQzlWWGgvb0wxNklxeDdaUmxqYk1ycUhHLzNDVHVxdExm?=
 =?utf-8?B?Qk43WkNUajJYZitpaFRSQWdDb21iWVA5QklLNmRoYkVLV2ZCWmJzS1g4MXR0?=
 =?utf-8?B?OGtUa1l1MkJsUCtuOGxQZStoZjJFSlFKc2x1ZW1IM1hvWXk5aElIa3pOTzlP?=
 =?utf-8?B?T2g2S1ZiQWdxQzlWMDRVM1o4UnU1aHB3OFRZdmpYdXdJYUdDcE5IaXNoclJj?=
 =?utf-8?B?SkU1ZzluMGhPRjhSMVA4ZjBMTjMyL3F2ZUl3V3U5dk9sZU84L2g1OSt5aUpS?=
 =?utf-8?B?S01QK2tuOVFOSHhkZGw4dHlid1dCY0xRNEVnd2gzQVJFWVZXbkhDcGNXbGZo?=
 =?utf-8?B?Vkk5WXJXWE91OXJ5WDVBaWpIaVpIOXd6VHdwK05TaUVwU1JibEpPVW0xY2sz?=
 =?utf-8?B?dWhLRDN6SEEwbjdlWTBzMldueWxkUFl5SXhBQ3U0bnVXdnlGbGM3dVI0UE8y?=
 =?utf-8?B?dDZVdEM2Wnh6RVg4NjhWT1J1Z0RMTm5XZFFjMENqQjZxZUNuTnlIL1R1OFNF?=
 =?utf-8?B?Q29nbzVpRHVWU1BTSVBHUWFUcjZrTDJjZndxZU4zaEYvKzFDV1hLSmxNeitP?=
 =?utf-8?B?d2xtVDhlRFJab09KTWI2eXJGWkN3TE8wNGYyL3ZVUUE3NVQvS0VXc3ljOCs3?=
 =?utf-8?B?WHpRWi9QYzh4OG9EZlh3SUc2KzFzdWx5UzhNVkI5d2pKZlAxdlBRSnBsNTRE?=
 =?utf-8?B?M1R4ZFNFay9vcm1aay8ydDgyNVVZbXhUbjhUUHFzeWNoREk2SzRXeFBhRWNz?=
 =?utf-8?B?czFXTElsT2o1QkZXNlBDZUVMUmFKN292blFBWGtuZFRmY1NIMFc0ekVHM3Ns?=
 =?utf-8?B?UGJveFFGay84NlVXS2xMenFqMS9tUyt5N2VuNllXVlBHUGNVSVM0ZGdrcEVZ?=
 =?utf-8?B?N213bnNRWXNFS2IyVU5FZHNtTGNWeGNKNkVSWFNMNmxraktwWjJWNjcyaWQ5?=
 =?utf-8?B?aU45QmllN0NzdlpUbC9PQmx1eG5IR1AzQ3N5djUxdXVMSUkxWWVqekpIN2Rv?=
 =?utf-8?B?V3hRQis1NFhaSzBhZnEramhHdXlHUVNnUE9QcW1oRW1pM1hoTHhncnJ1WlRl?=
 =?utf-8?B?MmpLMk15c0lQSUl5TjlxSjVpSml1RFUwY0xjcmR1U1VtL2p6dGdYNVlyUVNP?=
 =?utf-8?B?RkZ5NElwU1pvVVBsNk9ObmxObElrdWxrMHkzZXBndDc4TmNYQkNvbW0zQmI5?=
 =?utf-8?B?UHZmYmdnUkpmNlJSbk1iOWFCNGl6YlpSSHFCS0hPU2NuNXVieG11UDhtNUIw?=
 =?utf-8?B?R3ZjT2R1TnowREQ0VHdqK2RqNm1RcXNQMUtPUlFoVUJVTkZiNHgxdWFNZ2NI?=
 =?utf-8?B?aEQ1c1V6czF0ZldYSDAranZ0MG5MMEtIWWxBNzBjb29vMVY3bjdSUG5nWUZP?=
 =?utf-8?B?S3luVFE1WHEyNFJzTHRMbTFMZENKS0FZdk1wQkZIdjhHVll4ZVg2blpVbVVO?=
 =?utf-8?B?Q1ZYSDZjSDRMbG9uY3FrU2U1UFozcE8xZ0UvbmFrZlFNZHpHbGFxcUI1OTFD?=
 =?utf-8?B?WDdGSjZqeGlIVkQ2SmpaeGVzeEpVTGgxSzFwSERKQUwwZUJrN1hjbkFvY2th?=
 =?utf-8?B?U2phdXErNFBPczcxaG1hY2NDRElrdnNwaHgwR0dyRno1anM2N3c4dDBTaGJS?=
 =?utf-8?B?MHhkNjhnTTJETEk0YUM1N0NIbGg3TzlKUDlhTjl5MnNLMDB0dkZoTGhtRFNX?=
 =?utf-8?B?QVdReGcyYmlNSndtZjlDNWp6MkpYbVFDK2FFTFhYUWJKU05TQlF3bnhmZHk0?=
 =?utf-8?B?THl3YUh3a21GRi9VcFRCNm9HZWk0SzVPZWUwbVg4NUhmaFJDaUVFaDFNZ3dI?=
 =?utf-8?B?a25wSWNGeVpkWTVCbUExek9QNURBK3Mxb2hkTUtXSnBzRElJZHZaeTVBaTVu?=
 =?utf-8?B?R0Fob2FGdDQ1Mmk4Tm55bjVtMVJCRHdRKzFrS3RkQXU3Y1NsN3ZTOWduVWJB?=
 =?utf-8?B?OEUwOXJyeDFKb1lxQjlXMHNwd2ZNTjFhNHNGN1AyZHgwTEtZTSt3alRTTVpX?=
 =?utf-8?B?cm5NQ3FxZEtOWnJrTURWR0VCSU1xT05VbFRGWnUrc0Y3dktXa0cyeUdNU1VQ?=
 =?utf-8?B?b3l3bmZNRlQreWZsYXhCNlhmSGU5SFZNMkYveHV0SE0vU3c3b0dlWlFyMCt6?=
 =?utf-8?B?bGQ4ZG1wVHFwUXlaa1ZIaXUySks4MFR3QktORDgvWXIvSXdyWitNekxsOHdQ?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d1a37-5b56-4aa4-a656-08de21bc9d3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:25:11.0185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yeyzX2XfSGPxG76nB7NIocgTX09+uIzHn6CKyE4ccq+aiQwN3FnR9ZP+hntB5fLw1H+iaC5ZvZwA5DHvBTYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20511

On 11.11.25 17:45, Sai Sree Kartheek Adivi wrote:
> Model SECURE_BOOT, DATA_ENCRYPTION & FULL_ENCRYPTION via bools that the
> targets can select just like SWUpdate.
> 
> Also update the IMAGE_SECURITY to depend on these selected bools instead
> of targets.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index a6af745..adacf6a 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -40,6 +40,15 @@ config HAS_EFIVARS
>  config HAS_OPTEE
>  	bool
>  
> +config HAS_SECURE_BOOT
> +	bool
> +
> +config HAS_DATA_ENCRYPTION
> +	bool
> +
> +config HAS_FULL_ENCRYPTION
> +	bool

The preconditions are the same for both data and full disk encryption.
So, just add HAS_DISK_ENCRYPTION.

> +
>  choice
>  	prompt "Target board"
>  	default TARGET_QEMU_AMD64
> @@ -49,18 +58,28 @@ config TARGET_QEMU_AMD64
>  	select ARCH_AMD64
>  	select HAS_SWUPDATE
>  	select HAS_EFIVARS
> +	select HAS_SECURE_BOOT
> +	select HAS_DATA_ENCRYPTION
> +	select HAS_FULL_ENCRYPTION
>  
>  config TARGET_X86_UEFI
>  	bool "Generic x86 machine booting via UEFI"
>  	select ARCH_AMD64
>  	select HAS_SWUPDATE
>  	select HAS_EFIVARS
> +	select HAS_SECURE_BOOT
> +	select HAS_DATA_ENCRYPTION
> +	select HAS_FULL_ENCRYPTION
> +
>  
>  config TARGET_QEMU_ARM64
>  	bool "QEMU ARM64 (aarch64)"
>  	select ARCH_ARM64
>  	select HAS_SWUPDATE
>  	select HAS_OPTEE if KERNEL_6_12
> +	select HAS_SECURE_BOOT
> +	select HAS_DATA_ENCRYPTION
> +	select HAS_FULL_ENCRYPTION
>  
>  config TARGET_HIHOPE_RZG2M
>  	bool "HopeRun HiHope-RZ/G2M"
> @@ -71,6 +90,9 @@ config TARGET_QEMU_ARM
>  	bool "QEMU ARM (armhf)"
>  	select ARCH_ARM
>  	select HAS_SWUPDATE
> +	select HAS_SECURE_BOOT
> +	select HAS_DATA_ENCRYPTION
> +	select HAS_FULL_ENCRYPTION
>  
>  config TARGET_BBB
>  	bool "BeagleBone Black"
> @@ -238,7 +260,7 @@ config IMAGE_SECURITY
>  	select IMAGE_SWUPDATE
>  	select IMAGE_SECURE_BOOT
>  	select IMAGE_DATA_ENCRYPTION
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on HAS_SWUPDATE && HAS_SECURE_BOOT && HAS_DATA_ENCRYPTION
>  	help
>  	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
>  
> @@ -281,7 +303,7 @@ config KAS_INCLUDE_EROFS
>  
>  config IMAGE_SECURE_BOOT
>  	bool "Secure boot support"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on HAS_SECURE_BOOT
>  
>  config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	string
> @@ -294,13 +316,13 @@ config KAS_INCLUDE_DELTA_UPDATE
>  
>  config IMAGE_DATA_ENCRYPTION
>  	bool "Encrypt data partitions on first boot"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on HAS_DATA_ENCRYPTION
>  	help
>  	  This enables LUKS encryption for the partitions /var and /home.
>  
>  config IMAGE_FULL_ENCRYPTION
>  	bool "Encrypt rootfs and data partitions"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
> +	depends on HAS_FULL_ENCRYPTION
>  	select IMAGE_DATA_ENCRYPTION
>  	help
>  	  This enables LUKS encryption for all non-boot partitions on first boot.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

