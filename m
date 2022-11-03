Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A3C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 12:08:02 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.55])
 by mx.groups.io with SMTP id smtpd.web12.18525.1667477273467547590
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 05:07:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sar9MDjz;
 spf=pass (domain: siemens.com, ip: 40.107.6.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Yi37/e/4Atk3Uz1KRITCBdkYbk5f9fZzg7YqNDPP7LVurACL/L0sbpRayKPgkS9796eCe9HFatXaYP1dfbMllMieH/lvTXplVD4j13HQNOXb/o44uEcy1Dz8BGXD8kqCyzXp3oDaGZ0pRDoySe1YFoUc6XzNvsbhHeJHhzC0aJpRsDMZ0XVXNY8nuRSCmS+JnztiSzDZtKY/utfh5vSw1gZfizhBdyip8rGTJ8JDv4KGVJ0P9anA2bLcJuuGOzrpfrhoKWAWevBUNJdiJ96Q9s3QKTd/4yvdgysyhXm0ETA6K0c0I2dSNSsX6dfI2i2F+ps0esIS6mhdrl0y8tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13JgrY4twF/A+CoQVSn4wPHnmEGWHqo5jIYGK4uMmRg=;
 b=TjdLz5bTJr7epn9+M1AR288tpArmlQtacoCDmcP/E1OsOlw91W5BXEUR+FsxAc3z3Ehk7zDKCihH9NwgMVvgrcyS+EEq7AIXVpcHy+4RuaWPT0BcWuJi+XdKSKMOJN/w6NLO1jaVLOlKmqP62utqevV63ZY1i9KtWKF/9/lDBngy0U0yLimOIcmt6bjJZAtVJnFhEr0UqUCpd/LWkzVzkSvt3pacDMu8aMOODHP06EiumXZ0Noq6wW7rZ9aqhkGcf+4S2eaLuU54FEqXGkR27pKKaR2ZA2T2+mu/LuKcFdOxVaYMd1NtEvql7qed/ABKqcq/5QFWseR0DCk2u//Ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13JgrY4twF/A+CoQVSn4wPHnmEGWHqo5jIYGK4uMmRg=;
 b=sar9MDjzqsXUN9XnXCpO8Wk229zfrYTSbsu00NKBnHAtt2+NqOaV8Cqv/5HY8jFPm5KBDgVTtSAieNCAyJF4V49/aXgxTzFQSpqLI8EDjjqrcPBgtI4IXwPSr9+i4sfTBiJKe70yQqw24Uswzk0pF8KuwtEk2LQSDgufqNPUh6AUKi796fj0FLQNh9lAFwHjC1wpOW5YT9kDcSRzgp2N5YoRxHJfvGF7qChetQicYU+xmEUOeE9YBgdMOe9wSyXl8oaDx1Ti111bJZlvYEUDDV6EkV9aU30jLmlTd9RMqTceZ6tX2/trSPFv7tJHSmdiOuP9ALXS5rKhEhEnAl0gLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM0PR10MB3523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 12:07:50 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7%9]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 12:07:50 +0000
Message-ID: <2fd34818-509d-567e-0de8-1eaddfb2d975@siemens.com>
Date: Thu, 3 Nov 2022 13:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Adapt installation
 to Debian upstream
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20221103083643.14912-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221103083643.14912-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM0PR10MB3523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3330f255-24dd-4ae8-ce8f-08dabd940755
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QteSrHRWPSUgAq6bkMHJmZ+b069tdkNxxXRLwaailxNELDcjNaAcygkeqZHk0LY1wUQ9KzE+12oDePWXSlcE47k8gaPWNyCAvwT1cGUjTGQcrdK1g4c7dsZuqfCUlqRZ+9IE/OgySBt7xLCKlYyfZrSUY1Q4+0D+MBK92qD8t2NA8PxdPhKMKIjTLFoVBn+VhGz9Lw+iPBFAZwCWxL1MrrtgyA56ddyhbyMmYNQ2rDC3r3QDQ1CMA4QaIyjzddJ7pO8e21xKU9RgIU9B543pnGPpHaGlGZrX6IlPbEJdbEB/AdPjumM+zNyHVtRm/34Xb//WSc9uraLg+AieYMdzXS04oDpoUuB8dpHaeImZ6XPPLc2o1I2u96kOjCaU9wtnzhTG9NE9aCqcgY39k6LbwFHZmupnal7keJSOLHw4lDaY1lfI1BHjkMfQ79+p2561urBH6XsT9Y2kuY2/faUIt/6vWF/mXJJX9XSjay6KNEZljRi4Hm94mMtNBc0775142iVFmoTsXi8o062whi7ikeTt72q4bO6BRIi66sguY76Azg3XPAgZ+1uuyy0s3/GLOPoNZHrbfbYOe523uZEzCYUoim5GjHiDcGsETnmRxrh0J3m7MyCOvoHnQdPTO/ATtVqEw/RETtfFKbNzaWeRog6UBrabF8YYENxj2dVzi0491SHVyM4n69Vn2eXlubgXrQe7vYNVpypsmoLZ+t9/U/uHTWF570FqsJs1pFCLBWwL8E4phiD7HLRF5lfGNpThOLa0ZQUQgZTZLUjmJfr87s6YRAfxD2zIokQKmTDcgekJ4pJBC9Xld5E4AK/xfHbtCs2k3LfnxSPtBY1fhxsiHQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199015)(31696002)(66476007)(83380400001)(86362001)(26005)(5660300002)(82960400001)(44832011)(2906002)(8936002)(6666004)(41300700001)(66556008)(66946007)(186003)(966005)(6512007)(6486002)(2616005)(478600001)(8676002)(38100700002)(53546011)(6506007)(31686004)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2FENVhjYkRWcTRVOHpYaXBGWmR5R1VDamxsV1R0d0t0bmdDTWdXN0hKUUZr?=
 =?utf-8?B?ZFBXRGk5VGd4bjJOTmF1RzRvNDRTSzJXUW5saGRVS3JoN1Q1ZUJ5WEFEeTNN?=
 =?utf-8?B?dnJ4cTNORW5TemJ4a0dISkZsYkJQTnphUlVVTnVZTnJBSHFRZkN5YVYvQVV6?=
 =?utf-8?B?bDZUcTVDNVB0L2FsbGxWZUNUdGpmak40WmVZOG5peVM0dFVNQUdJc0hyZWNu?=
 =?utf-8?B?M2JZN3hWRWQ5RUxsamw1S0FLRU84VTNtRHBpWEorOTl1eGhpV1FoUHloS0hT?=
 =?utf-8?B?bXhsN0lnQnBCakFLTHRQaHB5QW1hekJUQWlHdjBCSnU1N2RDSFpJaVJKZC9n?=
 =?utf-8?B?dmZsRnR0VWJqK3VqV1ZmU1hNMnowMDh6ZDZnRlowYlFzTVZ4bjNmSkpkdXU5?=
 =?utf-8?B?ajBDTGl2bEwwQzZxQnhKVmlzaU9CQ1Awdm41eXdNSXJmWE1JdkQ5aUpkZmtL?=
 =?utf-8?B?Ym16RUFvY3FTN09nL3BYQjZlMHFibHN4TzdrR1FHZDZVcDhUOEk5QjNoc3FN?=
 =?utf-8?B?QndpUzEwYzk5aVFhdHp4SHUzOWlkeGlDdVUvVW5NKzZWVTFaeFk5aVl0cElh?=
 =?utf-8?B?bUN1T2ZHVzBhTHRaRld5a2NuZWJTY3Y3WEd5bkN4Q3Q4QTcvY0tRZzlNUXVH?=
 =?utf-8?B?VWhzcGhlM2J0Mi9YTUVTOVBBMnVaZnYweE5qblVzcFRPanJzMVB5M2gvL3Bi?=
 =?utf-8?B?anRqS20wYUFZQndxOWhnRGtGTGZIUlo5QjNQZTE4RytMUFdFaU80bFpWNmxJ?=
 =?utf-8?B?Smk2YklPMWpZb3kraG9WU2krRDBlOVRmN1daYXV0eVFJc3phcXlQWUNPTnJq?=
 =?utf-8?B?TmExK3dsZmMxYmQ5ZlNQSmdvZ2RsSmNxVUhOSHdGUlduZHNWdlpHanYrRHNj?=
 =?utf-8?B?b3JLRURtbkVUcVRJTHQrZjNGTWl3OXNCZStLV3g5clk0SjVoSU1CREUrK1Ni?=
 =?utf-8?B?L1BGSG5GTUNndTA2VzVYQVIxZmg0Z3lsK2JaZHQ5V2lZUmszMWIxVTZ6TmNO?=
 =?utf-8?B?dlpTRi9vWC9TZXVtV1NNR3V3cGxKcGFmMXh5WmtXQ2ZQZFFieUdvVzVlT1gr?=
 =?utf-8?B?Q3ZHSmFmTFBIcU1lZ3ZKMHdKcHVZQ2p3YmpMbHB5S3c0ZzVOalJhQkVHWUth?=
 =?utf-8?B?T2NYeEdxWUpBcitVd1NaYVZlNThvQUFvRzVVbFZSRFNVU0tBOU9BcnFJV1o5?=
 =?utf-8?B?enVhS1RZTWhoUW83QmJxWUd3N2IycnU3WmVxeTk1bDBlM3JNeUFtWlYydmZ2?=
 =?utf-8?B?Z0tNdTZzZm9UZVR6TnlNR0M2Vmx6RzRrbjlobkhrQWR1bnV2bEZES0F1ZVpK?=
 =?utf-8?B?NXlIaER6UTl5OGpSTlBBNVpQYXJqeldUZ1VFcDkrdmx3ZmJXNDdGU1BaK2Q1?=
 =?utf-8?B?NDlpb2tvY1JqRGdveGxEQU9xa3BhbnRia29lRXZ5M3U5cldFclVPTzRPZTlk?=
 =?utf-8?B?SS9vSG5wb3lKZ09tZjdEak5ZVmYxZmFDakZBM0x0NTZ2dlE5WTRtLzkvSEJI?=
 =?utf-8?B?OEVxMTdsdlh0b3YrRmpUcW5YRGd3d1Zib0ZpMXh2elg2aHhpSWZIVGRpelgv?=
 =?utf-8?B?c3gwcGgwbUdaUXJWVWN6S0pqb1RtemxRQmVhWUY3S3M5NHl5eUhLUnd4Y0R4?=
 =?utf-8?B?cU9hVkdwZ2NsMFJHclc0N1RKbExjV1ZoQUtYSVlLNDdBRk9DL1lONi9hS0N1?=
 =?utf-8?B?ZTlYUDBzbnRoWU9tWjFzcWRzYmNQN3JLMlUvZFVrczFPRkRTRGRIV1hoVFNi?=
 =?utf-8?B?dWhwdmg3NnkyWUVaUWF5ODBwTFpKZGZpclArcC9FNFUwZmE0dERNa3duRnFq?=
 =?utf-8?B?aUdkU0ViQmpZQ0VzanVrVjlkN2k5a2VoekJjN2JtbDdxWmNZTjh3MzUrUHhQ?=
 =?utf-8?B?YXJ2YnNMcVVPZHJnWXNzdXVXSHJIQnRKeUwxZTVRbU9EWFBneHR4NWdOYTVX?=
 =?utf-8?B?eHk5cmJZdHJSY0ZIVEE2ckM5eFVYTkR1VXJXeUJGcjUxMUhoV1pyeXMwTnYv?=
 =?utf-8?B?R0dzMllMVmtnR2ZzaFJhRE44NXpiYjh2Vmt6Uk1JZmRkZnJpeFg0azI3TUw3?=
 =?utf-8?B?VFVZcEprazJqNmdlYzJZV3lYeU5iTFVJendmVzNOWnJZc1hoYzVNUS81UnVN?=
 =?utf-8?B?WDdWZDJsVmtJZWQ5bC9OZSs4blYxc29qSFhNbnRVeGlHK2VyU3FPNWxxL1Ru?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3330f255-24dd-4ae8-ce8f-08dabd940755
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 12:07:50.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tABMUNXAAmR6s1T9dtCPUxIIQiXXOuzl17ZjcGl5dL4HL1Eqrj0aJS9gUB/IXlXPo3BWaLDhqJj02HNlgo6q2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 12:08:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9915

On 03.11.22 09:36, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows using the Debian upstream version of efibootguard
> in place.
> 
> Also add the new libebgenv to the installation.
> This fixes the missing library from issue #47[1].
> 
> [1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/47
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-bsp/efibootguard/efibootguard_0.12.bb        |  2 +-
>  .../efibootguard/files/debian/efibootguard.install   | 12 +++++-------
>  recipes-bsp/efibootguard/files/debian/rules          | 10 ++--------
>  scripts/lib/wic/plugins/source/efibootguard-boot.py  | 12 ++++++++++--
>  scripts/lib/wic/plugins/source/efibootguard-efi.py   | 12 ++++++++++--
>  5 files changed, 28 insertions(+), 20 deletions(-)
>  mode change 100755 => 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb b/recipes-bsp/efibootguard/efibootguard_0.12.bb
> index 88dc2ed..721b9dc 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.12.bb
> @@ -26,7 +26,7 @@ PROVIDES = "${PN}"
>  PROVIDES += "${PN}-dev"
>  
>  DEPENDS = "python3-shtab"
> -BUILD_DEB_DEPENDS = "dh-exec,autoconf-archive,gnu-efi,libpci-dev,check,pkg-config,python3-shtab"
> +BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
>  BUILD_DEB_DEPENDS_append_amd64 = ",libc6-dev-i386"
>  BUILD_DEB_DEPENDS_append_i386 = ",libc6-dev-i386"
>  
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> old mode 100755
> new mode 100644
> index d3ea007..01cf974
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> @@ -1,7 +1,5 @@
> -#!/usr/bin/dh-exec
> -bg_setenv usr/bin
> -bg_printenv usr/bin
> -tools/bg_gen_unified_kernel usr/bin
> -*.efi usr/share/efibootguard
> -completion/bash/bg_printenv.bash => usr/share/bash-completion/completions/bg_printenv
> -completion/bash/bg_setenv.bash => usr/share/bash-completion/completions/bg_setenv
> +usr/bin
> +usr/lib/*/efibootguard/kernel-stub*.efi
> +usr/lib/*/efibootguard/efibootguard*.efi
> +usr/lib/*/libebgenv.so.0*
> +usr/share/efibootguard/completion
> diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
> index 82e9e0e..9c3b916 100755
> --- a/recipes-bsp/efibootguard/files/debian/rules
> +++ b/recipes-bsp/efibootguard/files/debian/rules
> @@ -1,21 +1,15 @@
>  #!/usr/bin/make -f
>  export DH_VERBOSE=1
> -export DEB_BUILD_OPTIONS=hardening=-stackprotector
> -export DPKG_EXPORT_BUILDFLAGS=1
> -include /usr/share/dpkg/default.mk
> +export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
> +include /usr/share/dpkg/pkg-info.mk
>  
>  override_dh_auto_test:
>  	# we do not run the tests; that avoids having to pull the fff submodule
>  
> -override_dh_auto_install:
> -	# install using Debian's .install files rather than
> -	# make install in order to have a proper package split.
> -
>  override_dh_installchangelogs:
>  	# we're not interested in changelogs
>  
>  override_dh_installdocs:
>  	# we're not interested in docs
> -
>  %:
>  	dh $@ --with autoreconf
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index f9b232b..3d6b2d7 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -187,10 +187,18 @@ class EfibootguardBootPlugin(SourcePlugin):
>              "armhf": "arm",
>              "i386": "ia32"
>          }
> +        distro_to_lib_arch = {
> +            "amd64": "x86_64-linux-gnu",
> +            "arm64": "aarch64-linux-gnu",
> +            "armhf": "arm-linux-gnueabihf",
> +            "i386": "i386-linux-gnu"
> +        }
>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
> -        efistub = "{rootfs_path}/usr/share/efibootguard/kernel-stub{efiarch}.efi"\
> +        distro_arch = get_bitbake_var("DISTRO_ARCH")
> +        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
>              .format(rootfs_path=rootfs_path,
> -                    efiarch=distro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
> +                    libpath=distro_to_lib_arch[distro_arch],
> +                    efiarch=distro_to_efi_arch[distro_arch])
>          uefi_kernel_name = "linux.efi"
>          uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
>              .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index a754ee1..2d16fe3 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -59,9 +59,17 @@ class EfibootguardEFIPlugin(SourcePlugin):
>              "i386": "ia32"
>          }
>  
> +        distro_to_lib_arch = {
> +            "amd64": "x86_64-linux-gnu",
> +            "arm64": "aarch64-linux-gnu",
> +            "armhf": "arm-linux-gnueabihf",
> +            "i386": "i386-linux-gnu"
> +        }
> +
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
> -            distro_to_efi_arch[distro_arch])
> +        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
> +            libpath=distro_to_lib_arch[distro_arch],
> +            efiarch=distro_to_efi_arch[distro_arch])

These arch name changes look suspicious - or does Debian do the same
for, say, systemd-boot?

Jan

>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
>                                               part.lineno)

-- 
Siemens AG, Technology
Competence Center Embedded Linux


