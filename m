Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D9C47DAF
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 20:18:32 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.75])
 by mx.groups.io with SMTP id smtpd.web10.3728.1705609110246273934
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 12:18:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rOaVp1PZ;
 spf=pass (domain: siemens.com, ip: 40.107.104.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz0MPuri48wTnornTa74/rGQMog7k/gOAVile9DEtFXIBj6qxDdv/skcVZavwD7k3za4Gc9NAYDPiH1Fj2J2N4fLL7npOBtiKo/fLtC6cf4GihVdacyE0e5+5azrIfPXWGHqsPOLRgs5usSW0IeXMCBL6O1S2Q3iC5ErH43FsZJJmqyaPheL/42eYIGpRHY4oBbKTuUCrZFyI6lVdeUuBF8gbb3/Gz6eoZ90PIdWxhkmwy1SsLUEeKzH6Qc3jNDXLdEENHrrOmXMmLeBajorSlMZRLyjRFifYwsTW4j4LZuED0yKBn1VEWAzlB0Jctby0pFOBsjcrxHh+FPU0/y8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yVuE5A0CfXI/PrXXWmNsx0cVXecG+jsU1QlOWgvHSk=;
 b=Zix0ykBN8xZppIaGKrfrgcqSBgWJYVXmZxRON1SbP981HkzA48nwrtmQ4O1JEZY1AUSiHicsxWbfYCyeBvPPLbdI0FN2k3O9QldRrDXtrhrnnTLyrWazP+rHeSqNUsrljrDZn3z8/ZiVwLmPHivQdb1RKyUUu0M1fyefXVfJR9IZELv1/boNb4wa8dWD65n4lIeegg1B0tBOTNlJtAfRWhbZM7YGrwiQ4diAEUb/gradFT/MtCtJoGsU+eOi6Ty5T8Wws3iRoC7lz+wvH9fQd9Ny4d26eTWnVToyaCx6YUoXcW/mbuUMPOH6/Zth2AxE2SAM6UGw0QsZ6lobD3poJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yVuE5A0CfXI/PrXXWmNsx0cVXecG+jsU1QlOWgvHSk=;
 b=rOaVp1PZuOpG8fzaQnuGRT4sSl/pI8Jt90LEUwm6+FEBhyqRqXG22kKUAgHPyYvyD+06vVVJhNxrxgHYZiBaLt8QhbrGS2bP/1gHiB4qEgfV3AzkIxOhufKxWnDdiLG1IEmZslL6mxG43PQB4bWc/ozdwtnxTtfNsl5IWLKM03XHY77BPr9IH9FiF9FAELht/Zsee6Zx9qi+d82FaP0QN25GqNIFO0l+bI66hXg+TFvisYD3Q71WB6tnDb2S76N32PBlg8zkttJBxj5jLetttBNm1M1caL3kyuVgjugLBmRUaMioEb2JvSfC1m6dSPhFeKTyGKlKCyxz0a6TJaCfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 20:18:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 20:18:27 +0000
Message-ID: <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
Date: Thu, 18 Jan 2024 21:18:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] efibootguard: Update to latest
 debianization
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
References: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
In-Reply-To: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 40710370-f0c4-4a5c-5e4d-08dc1862a11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GfQWNzaHuZ9ipRNtW9yVc+yzfFYUP3s/Po9xClDuWDxR7opAztjFVN/n9yZfdZZzNhp2q5XxGqcpLPLLGRGRMYyI45s97joXhCTmH/2NtnjIgrBXIgfw4zRnANSga38vCXhNb/tNFcd/1n4P2hEWGLIcL1dpURPsvz1ewDmCux1XQ0hJJN1NevDHkwWx9C67KzHHcQfJTx7wmWoA5SPTFzMRs2z79CBM5ABZEphgNtey/YxEt3YsXLw64c1zKsfn7Adw5aAYHiPWZlywEYiOwP5QlmANSvBJpEeKMaNjht5lO5nqAlhelglX9FoDWgLzhYq/uUDNqlFLhwNg+nifs6gvyS1OUzBqifSLPXcUp6FK5H9ySBW/wHF/F10LBly10jA7d7X2bgGoNE7w3F1uX5LkwIw2/K7l/+mUSiAPU28gIisFiKoaRUWq+zb5WinRsF9IpFmjyerW0btCRYVCIb9ivSbJ9csBSaPggvKrjKdOAhSFhGJDSPGr5TgPrm2WeA5d/WkIUYWlGPk7H8E7Ay4jUhhIV67Yml9c5JwGyDjCVc3qRrvumuYRnePNunzJV3HDYbVi+OgtCN5jNsMuOFIhMp4fnK66rhN5b4kRNEgwOBDPaYfo8lbDO9Elliq8qe/wnDq3SynX0/b433/3WQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(8936002)(8676002)(38100700002)(82960400001)(36756003)(2906002)(86362001)(31696002)(41300700001)(5660300002)(53546011)(6506007)(26005)(6486002)(966005)(478600001)(54906003)(6666004)(83380400001)(107886003)(44832011)(2616005)(316002)(66556008)(66476007)(6916009)(66946007)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmUxSEtDTE5OTUNaV3FvQS9pdEFqYnlPMjM4eWFyays4MTJRdWV0TTVlOW54?=
 =?utf-8?B?NEVaWXVCM0YrMExjS2RNdTJiN3Y1bmw0S3hEUkJJTlBiSkdxa0JIbHE3ZGdC?=
 =?utf-8?B?QzlvUTMxMVFybXVBSmRNeHlrZzlITFZBbklxaThKWlhjSzcwYmV5bUM5N2tl?=
 =?utf-8?B?b2lWVitsSzNvMHFoQStMTFZVM29pQlluNW5neCtzUFYzT2V3NnFNUmp0SXlE?=
 =?utf-8?B?bUNIakVtRUg2SU02T2J3NjFkb29MekxoN281U1MzUE1kOG01aGZ0MERKMkdM?=
 =?utf-8?B?QTkzb1J2c1AxMzRUV3p2WDRwMlp6ZVJWNGJJTWl3bUNnbVhYVWRFcFRTRm1a?=
 =?utf-8?B?djNYZXlBWHIzRDVxSHV2Vks2Y1VaZWN2UWhweFhTMUxNc1RqOGNXUkxCM01o?=
 =?utf-8?B?cXpCcXVTR3BXcHRlakx3eS9GTHFjZHdJL3BSWmFhSTBWMkhQbVZmeTdjNkEx?=
 =?utf-8?B?MGZRU2NKUG5MckY1WGlkZVA4bndpUFplZHZ5WXBiYktDMmExem5MMWxkMWN4?=
 =?utf-8?B?eFhJSFNEeExLNCt5TGhHNkJUSUdHNTRCQWczUng4eEJHQW5ZRGRyc1Z3WUZi?=
 =?utf-8?B?TWEwQVFiY3FHTVkzdWNGVjM3Mk9Id2JaVGtrTHRneGFreTVvNk15ZHNIdUhO?=
 =?utf-8?B?Z2ZVcjR4V3JPaVFuellZUnJ1WCt1UWIwdjkwZzMrNzNCQVNUM2RVTVJYN0JP?=
 =?utf-8?B?dVh3eVJzN29IZjN0NlJyRklqbkVtejUvS2I3SHBrT2ExWWxOcGdBOVZNb2lj?=
 =?utf-8?B?TWFlNldkbFNKdml2SlRlY3JlcHR5OFhTVlF6RnN5TVg5aklYOUViNm0rSXNo?=
 =?utf-8?B?aEdSUFVzSDJ6M0pTOHdRWkZQdUIrVHR3eHQzUTdxYjE3MjNnaGpXWE9LTGQ2?=
 =?utf-8?B?MFZ5elZpYmlNRmhDeGZOWnZZdFp0NjFlc3BheFBJVTIrQk9OZlNQajltVE5p?=
 =?utf-8?B?aGJiMTBpZStLcmpYd0lqYVRsT3NLLy9sUUEwMHZ4R052SHowNmRZL2txelBI?=
 =?utf-8?B?c0N6eDFJWXI5M3RYeWVWTW82T25yY2hXSE16Ti9BbDdvVEQ5MkhhNEU2NTBs?=
 =?utf-8?B?SUhTOVR6T20zblVzeWovSWhENktGT05vSCtEdy9DS3g2TEhMY3FLQUlONzFE?=
 =?utf-8?B?SXpKSCs3djBnYnhKbTZZZU85NVMxdGd0QUR5WTJiUVZ6alFtSThKVnpmQlBF?=
 =?utf-8?B?d0xENGVBNHFBZEhib2RpbmF6Z0ozY1ArdER2YW5rT0c4T0VwSGY4UkFBN2Vn?=
 =?utf-8?B?ajZtRHI4cm56a29SaTZVeHExMVlZbGZLcm9SV2tYLzN0bnlMTFp5aytCV1M4?=
 =?utf-8?B?TjdXQ08vWHVPVkVFVU92TkswYklUOVB6aEI1S0dqdWN0TUErZnNHMjBiZjUr?=
 =?utf-8?B?T1BpVFI2Q3c5YjhVdkR1WFFURExyOGFJTTUveGk3b1Jpc3V6Q0NzS2c1MFg1?=
 =?utf-8?B?L3B1UGRwWHNEMGxCcjlBUForR0RFU3JNUml2Qy8wYm9LMStYM3FqbW1QNnZz?=
 =?utf-8?B?SjNubFRlZnF6a01reEc5VmxyWUpOTXMvS2tiVThTSk9icHFHdThJMFNFallm?=
 =?utf-8?B?SlhEeExESFFuQ21FZ29sazljRlVYUjkrRDRveVZ5U0toQzhpcVNjYis3cWcr?=
 =?utf-8?B?SVpNbEFrOVBKN1RpL2pzNzUyWXZ1ZXIweTNpb09qZE5PVkxiMEVuU1dOWXJM?=
 =?utf-8?B?aDF3RjlBaDc1ZWUyYm4yL2hTQUdNSUQ5azdLMjlQdjM5OCtDd2w5bWkrUzNE?=
 =?utf-8?B?SWtoYXJXSmQ3bm5vZ2UwU0tEQXkzM1JWdHg3MmRoV0NXMG1PMEp2dlNhTHQr?=
 =?utf-8?B?NkRLeEt6bmN3RTBBV3FRL0RNanVMeDJScW9QL1VkcUtMOHFDVWRWVS9ad3U3?=
 =?utf-8?B?eC9HVGY1Zko1dUVuYXBJRXRITmhnZVdGdjllbk5ERUEvQ3cyRTVmbTJFdVQ2?=
 =?utf-8?B?SHc5TjExUFppU1QyeXh4dWZjZjhlRVVyR0FyNnNZaUtBdWhPSHE4Qi9lRDFW?=
 =?utf-8?B?TVZiS3dGKzVLZkE4TEN0RGMzRHVseTJiYUFiWmVmSEhxR3Y3ZzR5cDY5d2R5?=
 =?utf-8?B?OTM4TlZSbjE4Q293MENwUFJPNGZWbVRUcnNLRUZNdzhxQmRKRGduWjF6NnpG?=
 =?utf-8?B?S3M1bWd0emVzbmIwL0pzeSthZXAyTEF0dGt4cHlIR1hrQUNPeExsZGdqTG5n?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40710370-f0c4-4a5c-5e4d-08dc1862a11c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 20:18:27.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qx9tB7F7JfH0m6znkao44unfWey7/Kn+XG39cqzNEHLQemFgbxgeiyAJNnK8V7jHNmT2pq+rZaKA0Y83P0DBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6532
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 20:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14409

On 18.01.24 20:50, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This fixes cross-building and allows to use python3-shtab in bookworm
> and newer from Debian directly - at least as long as that version does
> not include the Multi-Arch hint that was recently added and that also
> our own shtab recipe uses. That one, in turn, is incompatible with the
> :native suffix that was now added to efibootguard's dependency. We
> therefore also need to switch our shtab debianization to a version
> without Multi-Arch yet. What a mess.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> I was considering to hold this back until python3-shtab 1.5.5-4 has been 
> uploaded by Debian but that would delay our CI testing of riscv64 
> because cross-building python3-shtab for that arch is currently broken.
> 
> Note, though, that the generated swupdate image will not boot in qemu
> because  the 6.1 kernel (just like other upstream kernels) is missing 
> https://lore.kernel.org/lkml/42c63cb9-87d0-49db-9af8-95771b186684@siemens.com/
> 
>  ...bootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} | 8 +++++---
>  ...{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} (89%)
>  rename recipes-python/shtab/{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} (91%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> similarity index 89%
> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> index a7ffb00b..83be2a4d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2023
> +# Copyright (c) Siemens AG, 2020-2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -24,7 +24,7 @@ SRC_URI = " \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
>  SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
> -SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
> +SRCREV_debian = "22b173a3293c976c9dff2ae92085d7ed995f6768"

Someone reset history on salsa, for the master branch - tss, tss. So
this won't work anymore.

Jan

>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  
> @@ -34,7 +34,9 @@ PATCHTOOL = "git"
>  
>  inherit dpkg
>  
> -DEPENDS = "python3-shtab"
> +DEPENDS:buster = "python3-shtab"
> +DEPENDS:bullseye = "python3-shtab"
> +
>  # needed for buster, bullseye could use compat >= 13
>  python() {
>      arch = d.getVar('DISTRO_ARCH')
> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> similarity index 91%
> rename from recipes-python/shtab/python3-shtab_1.5.5-4.bb
> rename to recipes-python/shtab/python3-shtab_1.5.5-3.bb
> index 7a5cfd2d..f20cdcf7 100644
> --- a/recipes-python/shtab/python3-shtab_1.5.5-4.bb
> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
> @@ -19,7 +19,7 @@ SRC_URI += " \
>  SRC_URI:append:buster = " \
>      file://0001-Lower-requirements-on-setuptools.patch"
>  
> -SRCREV ="8db4615b2c3ee0a9332b6030687e1179fcfc8670"
> +SRCREV ="3cdca7c8f4ead23c194c4e8a84e2631989e26b3c"
>  
>  # We don't have pristine-tar in this tree hence use this option
>  GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"

-- 
Siemens AG, Technology
Linux Expert Center


