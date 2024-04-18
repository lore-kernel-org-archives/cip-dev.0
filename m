Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D947C4345F
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 20:27:44 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.66])
 by mx.groups.io with SMTP id smtpd.web10.4443.1713472058450081304
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 13:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MTHuQv6O;
 spf=pass (domain: siemens.com, ip: 40.107.105.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxPy6pGR5XOouHgpLG8pflvNSvYFUr+ZE56DUm96tnbruZerMNnuvasrqrFRDlyDOgzBPHIAa1KkWmNd2qEhrt71roCbxLWhvZV0cQfhEtb0WbDTktmFPpAkMqCgnZ4UQdE7Ei2pwqQ1dAjmppnLH4sS9gxAeBh4jMBkq9ouxk98x4M1kfRRgXp7ZGkqLeKFaRmSnMyLiwSHvMgaNYYy1RuXtX6oXFxkOW/XPTZOi6eNDjejRpEZ2vdsO8+bL3NGp5x4/SHBYhIwAxE5LZgS/4qgUNhqVYqq39sIQaCk9aGrWbYZ1ulrE71NkjX4C/mlK6uN1wduA5tDpizqrEsfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0HvfxHsUh5jnVWRYzTRy/y4MOdWeqQOxfH6Sr8nPhQ=;
 b=FgzL6SHma/XRxxlPY0FnzRsAof+hjHQGiz2khL6oJGHEvSWK2UrQbAhsfcUrdohOYziHC83vFwTRx0zM0vvJL29IHh8RkO+bODS1cSBJr2rD7w9dAHUozmzjd20i8G7rKyKSPB0qyCGaQAyGuLAEwVLCACRJoLXguj1tpwlVmJzyKiNhrAxQSQBPjgQ+VPArz66kdLfc/gXbUxgjwCDgoRMyeS60+OoKxcFKFj7d8CeMqtDfEIziSuahKUCGJ/EuW0R+5SYrfFt9/1Ln1evzHbR0Pl188RGkXTKhotH6LzGOs3uM78/NiflZvIbBhFC+YDTn+R1ujxTeNqj3kC2jIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0HvfxHsUh5jnVWRYzTRy/y4MOdWeqQOxfH6Sr8nPhQ=;
 b=MTHuQv6OKDyfNQf8o1dWDs2GDuo/Q1PS37+Dc60vcZkiAs+p2oAaLoY4a+puYTYLZHDv7JI/vAwIBeFBRFW6Lc6oLo5CA2vfCTXe8m1WTu7wpjViK2Qtn/AevsBQwSj0etNnzMdOE+9S9VER0GQkFNFsVGAB2tELwwHcDq3RqHSprHfqBxFW456GmazRI8fBv0gaEKD1JQvICCC2NzHDVU1KiGixypYdBUbOTRcQ6t4Joecf5kRAglpZTfoX5klg5YAjZ0HWkuPGU8dCx7y/tZmZmTTXVzzdR5S9mRZL49CrzD4HkHEGGITcm74ecfxEjj/DoeAvIukqyloArbfGfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8916.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 18 Apr
 2024 20:27:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 20:27:35 +0000
Message-ID: <efa6a0f8-ac10-46c8-946e-8f41d6f874d8@siemens.com>
Date: Thu, 18 Apr 2024 13:27:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/1]
 recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
 debian/control
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org
References: <20240418110353.584628-1-kumar.rakesh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240418110353.584628-1-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:303:b9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: b54089c6-2c3e-4683-c29d-08dc5fe5fb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QBAFQPVl9oSB6LWxMYZa9xw0TS3RGx2WSvFYsZg0J27ThrMhlJI2nWkLwd6FIQaACdfzOsJeHoG8JA7X92LCUT1A60PxJOBcQ0HuQJQ1r2iOk9awIAFLbeUPycPVlkmUETZprtZRLBibA/PHxjyxohHqZDbmVBD3E/+akGnzXgWFo92KDUptyyihn8cUN2dsSsGrNx14zZj+XGAR5ikjdMoIJGND1H4cSULJvyKpihG/4mCvFduFiwsfmY7F6WeZfdlOIrBwocUU8EOT3edjWdo0Gr4CeG/rXjJm3ORUH/hS9VYMfGlvAlOOw0+Zq3XD7CmZR2uWxq+rEmRZKneAljaCOE4zi21yW5U3lzNFuqaessDo8LJsS/iA8J1cGiBJPoMDtKomf5j58c5GmomNvkAzn3bUbNYrH7/eflgf70Kbcuwy1XfXmaU4lBwhAEcO4zggyBefmCYdiM7RdCodldakubcWn5XePjkdXIg3EF+TVS4jR4rskgtsxkgOV+/oMYDDMwMHwL8uVMZ6QZAjOjwR7AfQcDusLox0w+2hUAMDPpeG6PrO9C8lgMahrH7/1GaVXCaRIsKAV6Q8w4dSIl/JfK1tznrYBrnKjtM/P5L3AeXWypEblgRsMbISGS+dIPwl86rGJ/XL9LzooZ7OjjfAhpjcTq0127XhhI/JOj4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFJkNzNRZ0lsS3phN0dSSWJ2eHFsSG5sSi9jRXB1R0hMT1hOSThWaEFIOUVI?=
 =?utf-8?B?bDZvVHRYb2VGaU53TzZhMVcvV2ZaaDV4ZEo1bXh0N3VEdy9LQmFoQ21DamZJ?=
 =?utf-8?B?ZHcxMlcwZUxOZ1VhZGhZTWQ3dDhqTXA4a29IS0p5dk5UeTZhZ1Q1YnFpaGVS?=
 =?utf-8?B?Mi9WWEpUOFJ0VVUwQzJXWVdWblhHSDFpK3kyRGFWYWQybEZQdGNTT2tUOU9x?=
 =?utf-8?B?cUdLNzFSZndJRjQwbkppeS9NQ1lGTkoyNHBjWmJURE5nNnkxTXU4dExkR0tn?=
 =?utf-8?B?dDNkVm1IVzFHdldmb3Nmc1dlYlN5MU5qcElaYXEyR1lWN0FUSm9ieC8zUEg4?=
 =?utf-8?B?Ni95MEFzb09QNE1RZVRPV0RKRHdUU2dVbmp6SU1Bd0dPY0JHZkRzemwrSGRk?=
 =?utf-8?B?eENJM2Q5SnRMaUN1amJHOXlqSnN6MFhWNnNoWkhXaDJDVndwWXNBckF1aTNR?=
 =?utf-8?B?ZG0vMkZFRndjNVJKWXZobU12aTVPTElILzR1ZSsxdTB1WG5WT3ZqUG05c1VU?=
 =?utf-8?B?Q04xb3VLdzIxc3BObklQK2t0QWRQNHgxa0ZPWCs2M1BzS3BZZnhHN1R1K21p?=
 =?utf-8?B?SGp1MVh1TitLZjZiUFlyNlFLbVRDcnZ4OW5TbUNIMEZER2RvZzlkalMxUENt?=
 =?utf-8?B?cW9aNE9xRUxXR3M3ZzFBOWd5SWd5SDdMUHNLZU1tM3k0VWhqTnhlanpheEtE?=
 =?utf-8?B?Lzg0aUU3dFpScEIxUEFNQko2NUtsc3NWSTJvbVNQVTlJTXdpU0VacjlwQVBq?=
 =?utf-8?B?aVRTeUdDZHlQQzBQWTdxVmtJNm5WZDEvZlUrQkNTcXNMYWlTbytYS2Mrb3J2?=
 =?utf-8?B?YXg2d1AyUXlEdGcwSmtpdml0cmxjdDgwYzYweU16dVNTOFFMRTZTUlNEOTNs?=
 =?utf-8?B?YnpGaTRKT0srSVAvOEUrRWd3NWFNYXpIVjNyencxdkJNUkI1V2VHR0o5UDZW?=
 =?utf-8?B?Umw1UFArdWY1YzZPdFd0dk9BWVhDekErZFlKQU1SbVJ4eE9zN2dUV01WMk1L?=
 =?utf-8?B?blhOTmMrSEo0THk5aXBCcEJXM3FiMjhSUVJTd0JkYWo3Q0M3QURZUWJEaVRq?=
 =?utf-8?B?emMwVVhHc2hncWc3WTNyR3BINGRZYVN6MW9meUdjSm03WG54dnhTV2ZneE5p?=
 =?utf-8?B?UUN4OSt1Z0JiTzFJcFJnT01uZlRFdkZWU0E3N1ZVRnpnb2JCL0FVTFhXbk1D?=
 =?utf-8?B?SDZSSG9WVzRMSGtmeHpvOUZReEFqNVlQTnBDeEtWS0llbzBGQU9GeXd3Vnpy?=
 =?utf-8?B?NmN2eTgzdm95OFlFTkdNbUQ2b00rblUzd29lazBFMkVBaTFSdUN6MWhZbVVu?=
 =?utf-8?B?YU5oVnpFd1gwdERqZjVSS2F1MFJ3d1BkQWV0TEZRckMvQnlNZXk5MW9GN3Vs?=
 =?utf-8?B?NTJNdUFIQmVCUFgyRWc4cXNPVEZLRzdCTGtSaTRoTFlrM0hxN3hxWWZ5TDBZ?=
 =?utf-8?B?WFhmL0JNZHBaRklMM2JlOUVqL3J5dTdmZ3p1bEh5amVYZDk3a2FBWG8rWitZ?=
 =?utf-8?B?OERUT1RacExlNFhzQ0ZqUk1ZbElsTjZ0SDd2Z3Y0dGg0Z3FTOTg4QkdnTDQw?=
 =?utf-8?B?bGN1SllleHVqUnF6c3Yza2QxNVVwR3dqb2JmbzNYZVQ3cDk4ZVZ5ajRmbkRL?=
 =?utf-8?B?RXRoQmRKNUdWNk0xRGQ3T21JVkYrQ0ZzeTBqNEhTOGVjMnVhaU0yVjUwSGJY?=
 =?utf-8?B?ZDkrZUJvY0FFaEYwREhvZDRVckltWUtxd0lQbHFmRFB3NXlQZEtmL1h3d29N?=
 =?utf-8?B?RXlaME81S01NQWNCYjRxUngwTmVIcEtkWEFSUXczTUo1aUowMk9zNzRmSUtj?=
 =?utf-8?B?M2FkWlo5dkJkZ0pQUnNYS1EwaHB6dVM1eXA5eGw5c1A0WGppZGlmUFRLakp0?=
 =?utf-8?B?a0NVckpsamVmZ2FxQnVKS3dJZXVFSTZDbld6aTZiYVZSdi9Gc3NQZ24rYU9n?=
 =?utf-8?B?emRmd1JuTXhiN2I1MVdtVzM1UWRZVENYdUErY3MyWWxsNjFzaEo4ZURab2pH?=
 =?utf-8?B?TzVVcXlLaitwZkRRb3JvcFhDaERuNWZEUFJJM0NSN25oWkxSbnJERi9XN04y?=
 =?utf-8?B?M3czRU5OTVBSMW9nMzIyL0QzL3JuclcvYm5tcGtXVmpGMHFXOFVRMlp3YURy?=
 =?utf-8?Q?PY3vrfwzIoBVlzg40Eis0y2cY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54089c6-2c3e-4683-c29d-08dc5fe5fb61
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 20:27:35.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf7vHvlFGxZhYL57vM+U6+qfX0BeTUuZPwlMLhxoq2Jw6kKzZlBLZ3Y+k7e/qFj8SrVQDm7KBpcJEqzQ56A5tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8916
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 20:27:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15583

On 18.04.24 13:03, Rakesh Kumar wrote:
> Previously, the debian/control file contained a duplicate Provides line,
> which caused a build failure ad below
> | DEBUG: Executing shell function do_dpkg_source
> | dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/control at line 16:
> | duplicate field Provides found
> 
> Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
> that the build process completes successfully.
> 
> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
> ---
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 76233b3..559d295 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -12,6 +12,7 @@
>  inherit dpkg-raw
>  
>  PROVIDES += "secure-boot-secrets"
> +DEBIAN_PROVIDES = "${PROVIDES}"
>  
>  SB_KEY ??= ""
>  SB_CERT ??= ""
> @@ -29,6 +30,3 @@ do_install() {
>      install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
>  }
>  
> -do_prepare_build:append() {
> -    echo "Provides: secure-boot-secrets" >> ${S}/debian/control
> -}

Thanks for finding this. Can expand your patch to cover the other two
cases we have in-tree as well?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


