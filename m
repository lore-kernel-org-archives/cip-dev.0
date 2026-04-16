Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293F6F8A179
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 13:45:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14471.1776347120603279389
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 06:45:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z/SY+hVA;
 spf=pass (domain: siemens.com, ip: 40.107.130.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao23T+uSxLS9bXAW1CVFHs4hDMsBWvH1IkCWHQeYipjNBE3Cc0J63ZcrZiS0HRzVVi50rfELVnabX3463Q+Nr5q7iBjQdknt9rE4nK6MPfgWk5MopS64ZfDsJezcwVg9o6lqaKTQL0Zxw3z6hFfOv3YUbnu6YWigktfwdXBD1ur7IVSPMtA4bAv0ak/2KRIEH5hDjXCNi7S6dxvSLtfPr0O6nKtXDlDlYQgC48ILQ9WWWEKgEoQo5em4AgGBMC0eI0ZZlSB++K5GE9Ree7SfyUsh8TsXCKSO5WkEUyrgj8QhwfkoXKXNzI52ZLQzqyyQnRU4Fjj1NN/aToTLsbNTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkB2TQ803MnxLKD2Q3e6u218DVZVY4v+b6A6+ZH7lwQ=;
 b=iRM339wvdV+FAxy4PypDijAR9cw6KfL4wGa+K2PcOq6TDqAI1R4VIzPjv0uLp2MPJDgGQbnWPJSPceVk9wWh/F+KnWywdGHbxCUSYoW1SX0acd86r+qZN3IrRiJMVymRCzQD+hXVL/TJI8tiItOrNSrLqhvnxMWAZ1D5qe3lNAt18g9AFPgU6/Gg6OqPvl/L70ruzULEEmgZFVn3LW8NLsaz1PpEhmjMeSNglwjDmO0b0sfPeUTdmhfR+t3qv+yj6I+kqHyjSiScPB5JJzgNh3RoSNiybw+95DHbDYTRmoC96kcDM9lyIaO7HMpBIXWL9CijgJm1/Hz6Ts3lv+qN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkB2TQ803MnxLKD2Q3e6u218DVZVY4v+b6A6+ZH7lwQ=;
 b=z/SY+hVAgPzdA5b3iA7dz5QTC5SWMKdSl6KZqkFsLbN0Nl9i8nNrDd6yu2CiEWFFS+iHTBsCFqRLxZ96CeOK+lc4EOCB/K7URIJoXq2lbSgVVRxooUgHGiyM9RbZSBYkVi7kuYLEpfDBIu10tAOMQfGlSd8K1WSo1gR8T1A74HzmJC3aK0d447T4RGFgBIITrQxnXJUbrblJYqDgdUQLV1VIyjezyI+ubYKlosocbhoR66a7fE01B5MM7F6kX+4qHPLAj7dToUZDKk8JCm4rfpNLSH0hyRV1rByxt7YPgwPVjrru9FJvdcVSQ4w+1ok3YKgcT2sYx1jGGtXN9uMtbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:320::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:45:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 13:45:13 +0000
Message-ID: <a4e9e13f-b4dc-41f4-a449-0f43378b2e3e@siemens.com>
Date: Thu, 16 Apr 2026 15:45:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] swupdate: Remove Debian build
 profile cross
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260416132349.1560392-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260416132349.1560392-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 556c4302-5475-4af4-188a-08de9bbe623e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	T60T3kNNA2DS+VOgVLU0gmB8u3bhZDnoAvXcQ/IBRERvaGLusZw//iugQbEzVGkkdQ/OX7rhgnO5IOQTEj57ckEP7IxzyHCNx8g0WBCrncC9I/pl+o079V4uAMAytwCyyckA+kOS2EMx0ABYlt9sU9fZ2DiwmqhZNKDN8Xv0xwVLH8Wauq6LHSPJmJtVqkXFUV4jI2se39iIrkwmDaYhZ+cjWboA3y0u+k9/jR/FIYyyqngjdQY90JEds2Ch9Ji/0hAu8TuV28IR32Euqa3rJgRt1SMYooV83KCYSSFw3+RE/urw4PHDwRvNoMpgpDFZV/M6RJXaeDydR0sn/vDtu8QKd+p91sTF4p7F/YwTxU7RXGItn+wFqnuj70EKZB5xkPIJNS1Z0LE3Nkb20C48LYdRPYytoU6WOeAtuWDwTwudtPzVavYabWvp8cYzRumJ9mXkaLEHMdRJZO0kp9y1I3zazBPe8hwoes++dDjfQMkPw95BY9umA8kEuCW9KeGESs1Ag2ndpV0F1azBB18fidHUJrNDD92ehDmMtFOp8D4OAUy4dlR/Sim/jknE+GCNTGMLmjYZ+HJDT5maT85SXc+gzjBZwyesTU7SE9djs9O4rkAdzUK82jHmrkRo8kq8mChjOwOH4+JVYYDaBDB7KXFDt/tMRmcC11yyfLFY64z0ykmAYkHFGuC5Dr5Th2Ezsafq3zjx7KKPM7BflfArPAMOU9OmrJzD9Jdn34li02U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1Q2cFFHbDBiQTNzWDlIQ3lvNHJXMmZjQUxQQjlSaGhXV05JM2J5L1dIMXJL?=
 =?utf-8?B?bm8xMmptK3VNcFFmUmcwa1JSV1FWcXU1cDhGY2tkOHA3a1VxVmVvRW9TUDc0?=
 =?utf-8?B?NGpqWGlPeXpWSXFnbTZ4WjJ5UU5BM281TDRpTnJkY3VJM3RHZU5MeERBSEdz?=
 =?utf-8?B?bko2TkU4cDVPcVdPSWdaeCs4M1AzWElaT1VFVWpZa2NyMnZrRjFKMkxxOC9J?=
 =?utf-8?B?ZkoweG9IK0ZveGZVYTBiWXhPbDFGREFiUS80NW4xZ2xaL1QrZHllUS9PNFpJ?=
 =?utf-8?B?ZWhGOEFIcDYyd3hVcnU5cnlaNmtqbkxpQjd2T1N6RTZxZFNodjM5dmRLWTdV?=
 =?utf-8?B?KzcrUWE0RWhjNjZpMms5QWYwVlBUaE1ZOGtELzNZUmk2RjVkUy9nTWtpSXJp?=
 =?utf-8?B?bmZiQWdyZ2tOVURqdFU1QWhVZy8xQURENDRwak5SSjdkeU83akpTOEQ3SE8r?=
 =?utf-8?B?K2RIeC8wSmZQQzdWajhHdWpDb245akFCM1E4Zy9pSndub3JHdFh4S1duZ1RP?=
 =?utf-8?B?dHNGc0czQUFtZHBkTUZrcWl0dWduVnZtLzVqQ2k0TmJQbndaSVE1ZFFJSmVa?=
 =?utf-8?B?eDFTTGpSSjdFT0FDaFl6N3lEN2dXTldtOE0xTFdXTWxnemlhalRpaUc1NTFt?=
 =?utf-8?B?UG5YR0FvaG4wTDhrT1V3N0Ira0NvbXlpZDNkbktyRUpkQnpHaDR6ZjdoMjJE?=
 =?utf-8?B?Q1VHWVhrdGdESTRYcXJmS081VGN2ZVRyRDJweEVaaGZXOW43VDRtVzhvSDhm?=
 =?utf-8?B?TW1QcGFvR3NFcWlrVG91cFdrU1hPQjlEM3NmVmQwR2c1Vjl0bVQzTW02T3g5?=
 =?utf-8?B?c1lzY2pJQVBMdjNHWUJvb2lHWVA0citnWjlVNU1BaTlzVkQ5YSsvQWxWY0tj?=
 =?utf-8?B?cGpvOHQ2c1F4T2RVUWRjZEZQN1NEdVQ4elV2MjVVN0p3MUs2Rnlxb0J6SjlE?=
 =?utf-8?B?UytDUy91bUNncjFwaWhmRlFMQW1xdmNqMDBscGl5Nm5BSTlMSkJsL21uVjZJ?=
 =?utf-8?B?UDBvUUNjelh4U0JXSDFVSi9Yc3JyRU4zNzhvdDIvQWRmRFRudnczZWNqdUFk?=
 =?utf-8?B?YjlpSWZCbFNSMnJYMXhOdG43K0MxbmY2UCtwZkFpSzF1Wm9hSFYyaW5CaFFk?=
 =?utf-8?B?QjRGWEY3cmdGcjVXMzFneFJLU1VzR3NqWXMzMU9rR3dmem9YK2NrVnNYeUN3?=
 =?utf-8?B?WklIZ0lQb05kSDBRSDJ0WGRuaUZuaWg5NlhDVWpQUTdPUFJvM1MxMXZIL09D?=
 =?utf-8?B?UXpGMllOTDdnUTVRSzArMjFNbUxwaDg1amRnZEp4WndiemxJNHNYMWtaUXlK?=
 =?utf-8?B?V09teEdhaDZLSVlLMUczR2NCODBwVy9TdHpDWkNKdkxDMHl6dzh0V29jY3pl?=
 =?utf-8?B?ampNZ2JmMEpENTV3NVNSZXl2cWNqanJ6WVlhejRscmxNZXlTT3A5SDNZNXBU?=
 =?utf-8?B?ei95RG5BSThIQVFvOU1lZEo2Vis3bnNqbGpXZlRKSnUxSFlIbXN2dHJhOS9Y?=
 =?utf-8?B?eWZtZ0RjUVdyaUd5bFRRRGRRTTR1azYwOElLaXhSZjYzeEVWRURuWUlEcS9H?=
 =?utf-8?B?U1hFYVJDUTN2SVZORmV5U0IzNVNnUW4xZmpHeERseEE0OE83T0NoamtaZHo0?=
 =?utf-8?B?QTg2eEo1MkEyeE13K0FkaUo0cTJVVjh6ZTFFMFByWnpVZmx1ZktvMWcyazk4?=
 =?utf-8?B?STc1VE1aejFkYUk1RW0rODlmU05icTVSVVJ5bDJDRE5JNzRKcXNic3orSHp6?=
 =?utf-8?B?b2dVb0lOS1BCTVBHajZvN1hsQmx6SlZUUzRmU1ZMenRSUGVrdTlOU0FSZmVw?=
 =?utf-8?B?enlldThFOHczNDNlUVpGMmJTbVdROUI1V2luMWV0aGJ6Mk1YZ1FJc1RRdlJ6?=
 =?utf-8?B?SmlrU3FzUURRcTlzUUMxcGpNZTJPdjZrd1IyYnk5SHdtNk0yMkgwQ0dZbVA4?=
 =?utf-8?B?ZU9RelZTc1hXUGJtcU5mM21TaXFUZ0tGZzZEdTFmT3BDN200ZlZaY05mU1Jr?=
 =?utf-8?B?eEIxZktMelF4R25ZUVFVemFRZGhBaHMvc0hob3VOVjBpR1Bybi9sUThKUWRo?=
 =?utf-8?B?UUJFSEg5d0lIb2RseHJ5SmVWQXhBTDdSejNwMTl0N05UaG1jUlFwU2t2SXhI?=
 =?utf-8?B?bFBJeEFkbms3RU94OExmMXFLYWliNTNxTjBoSzI3eVAvQVNnT3FqMi9OSjlJ?=
 =?utf-8?B?amRmamxVekJ5WEN3VEI0QUhXVHBhRm9GNUlWYmZaVFNJSXUrUGYvYmJicURa?=
 =?utf-8?B?SDFWL0F0U3E0TlRTM25RZTJWSkt0a2lxWmcySzlKNHpmREx0SVVtS0xnT08z?=
 =?utf-8?B?aDZXS3o4MkdQb0d2cS9Ob0c5bFlrVGdTUnRBU0hZWkpPL1FWcnJydz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556c4302-5475-4af4-188a-08de9bbe623e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 13:45:13.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YDphzlYCprEWmaGVsnpa8F8vwS3Rn6AjS53DUjGTBRDn9zfL2GdpD64va+Lllbc9jANrOddT7LgxNelf0bJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9823
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 13:45:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22741

On 16.04.26 15:22, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The cross profile is automatic set by ISAR_CROSS_COMPILE.
> 
> This avoids the following error with building bookworm or older in
> trixie:
> 
> E: The package cache was built for different architectures: amd64 vs
> W: You may want to run apt-get update to correct these problems
> E: The package cache file is corrupted
> E: apt-get update failed
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v3:
>  - correct comment
> 
> Changes v2:
>  - drop setting cross seperate from ISAR_CROSS_COMPILE and change
>     subject was swupdate: Set Debian build profile cross only if ISAR_CROSS_COMPILE is active
> 
>  recipes-core/swupdate/swupdate.inc        | 4 ++--
>  recipes-core/swupdate/swupdate_2023.12.bb | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index 497b1c2..4038e7e 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -37,8 +37,8 @@ DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>  SWU_SIGNED ?= "1"
>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> +# deactivate testing
> +DEB_BUILD_PROFILES += "nocheck"
>  
>  python do_check_bootloader () {
>      bootloader = d.getVar("SWUPDATE_BOOTLOADER") or "None"
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> index 6822153..89785b6 100644
> --- a/recipes-core/swupdate/swupdate_2023.12.bb
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -39,9 +39,6 @@ DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>  # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>  ISAR_CROSS_COMPILE:bullseye = "0"
>  
> -# add cross build and deactivate testing for arm based builds
> -DEB_BUILD_PROFILES += "cross nocheck"
> -
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES += "pkg.swupdate.bpo"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

