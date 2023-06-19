Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216AFEB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 16:30:05 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web10.11980.1687192198864699956
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 09:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mVorHsQ3;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMRbF3F0N4/65IWVraWgG8v3AiFFbZk2oWAKK5cu7vzfDxx0o07GKrS6vc3V+rmnezjdpLwWsFy2QrlbsppDdgB+2mD0StRGwYQyOX7CIsDzHC3pJAjz24KUnOmQO5VGRRz9RfFG9J8HeL4tOdvXGsN5UemZTAM33tEkuv8VokW7PMhMucMUeXDvvOaCdpRJIatZn1C27cELW3KjeFu7EmwwuVKROJHE2W38EliapZSE/RFj2ITb8B5B6R8xlNsA586auh9m67RqMClfmaZ78Je3UgPsDk3hsg/+I/lEeVaTSbLikDCdjLHC6q4jx3hyXt0LFH9Exuj4zjTOwUA96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqQJZeq2AuPN+aiR/w5I9sup6U63N98eq6l6v/TODo4=;
 b=Ta5IAbee8CHCAOsDxJ/8w2MsAsMKJ07E9KTgS+uC91Zmnf08iVsHT1A0GY++KwqqC5LOiWR9LQuYxWjcfDxYo2jobK1fhObToiZ/XubY1wIcya+OTnPQ7lDwcqNKMs9UwkEJsoXR3BcOeT+3GYekpVc3QwDTddWgMZ+8oNiIp49SLbw6HiOB+SGOBNqTcUaPbhDwbEbjpGhq0R4kiOy8xMQYWOSWMfhtiY2v7aUP/kbofmP/6KLCu/r8of1FWxj0kd1Y3tFaRVkrA6qypJchmN18UzeRtYecD8hS8XKTzmj1bHF9Hcp9CKCIcDQrRirjErWcc/ZXBwVBFQCtnV/ueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqQJZeq2AuPN+aiR/w5I9sup6U63N98eq6l6v/TODo4=;
 b=mVorHsQ38ZQJBJgGl6VbB1s9aYFnqkx5ehoMaDRnAlhchDMUYcA9ZFfxtYhpGNiiail4s1GcBOVnl+ZxSvD8ilGcTxQfdwbGTUgEJTKsnH3hK1e7Njh/tHrn65yw6yubRvgxcLnFWiZPjOhhIhZY8XvuwvdqFFCc9KpMXDcTkfnXvCVEr7azbsBk3JCr/3Yn676M/qQTarZLMfq9Ve6gq2mZRZAmZOH+PnNiNuQKIP4ipXtlMJ9UtKNuGt3rvDFmcxLsM5jvitTFiCN/C7a6jDXX4j6lOD8nJdLQf539cSwQBZEIvvF6DBajd3WVOUBgALoaRVWzVr4ENAtJhSSwyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5595.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 16:29:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 16:29:55 +0000
Message-ID: <5854190e-efc4-3adc-24b5-b913458ec821@siemens.com>
Date: Mon, 19 Jun 2023 18:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] swupdate: Patch to add the missing build version
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com,
 felix.moessbauer@siemens.com
References: <20230619155321.475974-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230619155321.475974-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b525ca3-a4ee-4fd2-3571-08db70e26a5b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	miH80oRXkT2OCi0+IDgi8tLmyjwkSYrQptVw0ouPuekOSk2FIfWPhZR4Y2kDeuYUL6RO1CEY/1PYMYJza53IHdA/InS64/W2apio2iSQaqgZM3zcMqDxcXggED0zN21Eg3HjNIqyupwhFCsajSoQu3WO4i54LYacr9baRMuT7VQeZbPOUHBA0h84Hay9/sP8cxbBojwkr0FWhRt5rNpekm33gAorqQ5WGOjaUlduDiaQKsPff87P6oMBbemPsq+YFha6c5m23McvMD4QKxZTNL4JB2zNJtjgHJRJ1JlNfHn0pdCmlaGbN+QIdiWrBDY2ggbqC4XIoIHU7PdevZSs1mA7ZPgHQyvwqQwx5yI8IUzhWvm0sS5QDjfhukhrAJRO0nxvRdyZlpmeeeumrdhqObJ7tFcTpgc8v0PDWAP9NngBMFCxCZbqFf7CQgHoVzCwolxIas67gbSQN56MkFDaCpDdC9vtDgvW5COJ7HcDrzfxilvIGgJoPM8e9lPzREE2tnn4vVOcm+TJihxDv8pd5jQfbq56837ACiQVelYfViYhAyE+8o8PKOPeXhVw/iIoHhfXPWbgsXpb3I1BFHe5O30JCOlZF3Qm6abSsBfgP1GjK6nRIgYg5F72gKsOD8mhvxAJq/g6oYEReRA7EAiY6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(5660300002)(44832011)(8676002)(8936002)(6636002)(66556008)(66946007)(66476007)(316002)(38100700002)(41300700001)(86362001)(31696002)(2906002)(36756003)(6486002)(6666004)(186003)(53546011)(6512007)(6506007)(26005)(2616005)(31686004)(82960400001)(83380400001)(478600001)(19627235002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THcwa21MZFRuQndFM3puS1R4RnZCRHpjTDNVYm44V1hjb2FGZ3VLUTZQdkJ6?=
 =?utf-8?B?NWdnMjdNejJERDFhWUdCZDFGNmFuVUVNWGx5THV4WlJPNTZlYUFqVDRiZnBP?=
 =?utf-8?B?b0UzczllZjZuMHVjUy9oeXlLQzF4M09RQTR6Z0ExRnFDWis0TTFHTU5od0Rw?=
 =?utf-8?B?RlJzOGxMVHZoVVRRNmZIUEVsZXVvWUE0dUV3WUNHUHhYSUJyUTE3YXZ2ckp6?=
 =?utf-8?B?dDBWeFlQOUpCdVh3RWdGTDBOeHdpRlF2T0F2bmZyNHBMZlh0RHJvVjBFYnhT?=
 =?utf-8?B?NytvOGNXV01ocHplWUU2VUdvL0N6c3ZMWWFucCsrWVZBNW40NTBMbWg3V2h5?=
 =?utf-8?B?aGdITlFXVzkxSUVLc3gxdnhRUnpBanJNVjdHTzZCRGl0c0VlRlQ2aGszOVFH?=
 =?utf-8?B?MDU2bi9Rck9rRzQxNVZsQURST1BWUTFDQnFzUkVIcEo2c1pBNWRVMXF1WlVT?=
 =?utf-8?B?V05WeW1pUGQ5U1BsTDZwT1E0MDhpa09FcGdKZmlvRVQ5SCtOTnNKUXpTRDJ3?=
 =?utf-8?B?dk9vZWxWTGs5WEpNckNxN3lGL1BROC9zRDVoS25QSnZkZ2loOGQwWU43L1dH?=
 =?utf-8?B?eFRqb0NZUnIzUDRkeVdhSVVPM3hZRS9DMDk2QmloOUl3RjVGcGJDZXhVMWFJ?=
 =?utf-8?B?VEdvZnhCcVkvT0I2elN3ZHhsVWhNaDYvRGRUM1pMN3R6RXE2a09pcWVrVEdv?=
 =?utf-8?B?RDlveVVZOFl1WWRlcnh3OTNOU2FRMytiYXhFanVQaEQzZWk0Q0xZd0dXQm1k?=
 =?utf-8?B?TXdwWlU3clpyeVh6aEhSOE40cGE4Z3ZVdWtvVVZGUWhGdkFETEZIdWZnRHhI?=
 =?utf-8?B?eUhVU2orREh4bzg1b0F6K01UQnZiVGJjRjVTR1lWUlJvR1NLdk1xRUw4N2lh?=
 =?utf-8?B?NHhGYmYycHliSG5GcWwwdGE4OCtkdS9sZUNmcEpTbWRBeEVhZHdHVVNOK3Nz?=
 =?utf-8?B?R0pJTWpUblJBNStXUExIcUVadWpyeVRwWDFxKzhrUmtqaXp2Y0VoR0U2eDJL?=
 =?utf-8?B?enVLN2gxQW1saGFITkJEY0V5dUZjeDU0WFpuM0NncnFkRE9mYm1OVVhEa3Zj?=
 =?utf-8?B?ZW91a2NEL2NiZU5kTXIyNUNyM1k1SWQrNXRZQ0drQXc0MnZnYkowUis2WVRC?=
 =?utf-8?B?RE5OZ3NaVVlRNWVlQUJoc0grVHFoNVdLVndUNXI4QkczWmpHY1lwMThCelRQ?=
 =?utf-8?B?QUJnOWhBK3QzN1FhenJGeVJVNk1nVGYybXJwSWlvMFpvZ2RmVHl0dU1aRVJH?=
 =?utf-8?B?d1ZFUGJibU56RjBCQTZDcTNLT3MvbVBoK2ZhQUEvdG05em1nQVhGQ1Q1Vmw3?=
 =?utf-8?B?cTBITjhHS0RvYllVd2hjcVBrTTY2U3krOTJzNVhncUNnR2VkQldveEc1OUgy?=
 =?utf-8?B?RDcyVmRmbnFIVDNTVUJhbFN6MTJmRmk4ZmloTy85bXkvV3dqSmlCb0VObEhE?=
 =?utf-8?B?L2w5dUFsaUNERjQ3d2FLK0xaamhmWXhGS3dFOXV1R2QwMy96ZldUbGdyZ1I5?=
 =?utf-8?B?bXhISitDRy92c09jT0JBUVVhd2Ird3l0WEY5RjdBdlBZdytUa01KNzJ1bjZH?=
 =?utf-8?B?M1dvdVREdGVRbmxmeWJYUkV4NEE2SGJpblg5RWgzSGlrMHRpQUZUQUlDQVFm?=
 =?utf-8?B?WFUwRTl6dEhGdDdVdVlWNjlkdWtnbEVkcmIxV3lIM3Mwa2xxbEZENDM5cXpL?=
 =?utf-8?B?UUp4MCtYTTZrMUZwWWxpRmFUbHFZbzdsWTU5ZTdQclE2QldpS2wxNWpYMEtY?=
 =?utf-8?B?ekE3cG96K1Zwd2NxblRSRjFwd0ZWeWFSVk52eFZNWW1JNmVVSnhsOHl1eWZO?=
 =?utf-8?B?Tkt6SmNZVklqR3EvUjVjSGxYRXpweGFzcXdQTnBxd25QSnZoUWRFOUp3MUhT?=
 =?utf-8?B?U0JUdjV0NnY0bGNHU25NQUptQjBBY2YzMHBXRit4cStBdlg2N05Hb053ZE54?=
 =?utf-8?B?cnQyMElOZVkyNXU0QkVkblZ4NEV3KytQRFptNlcrekgydXNEQUhSdzNnZEVW?=
 =?utf-8?B?M3FCeExsUHVNQ2NYOGNPcnpVUTZ6K0FQbnl0bnlCTFAvSSs3NjNVczZ1dTI1?=
 =?utf-8?B?eVo3eHA0RGIrR2NIbGFhRU50V08vd2tLQUlncys4SWNSQVJZZFNWQ3BibnZU?=
 =?utf-8?B?YVpHZ0xtaXRSVFcwcUNHSE4zb1hDUFNPMUZEbFJPNW5Td3NkNmNwaW9UN1Q0?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b525ca3-a4ee-4fd2-3571-08db70e26a5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 16:29:55.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZAimM4rZQA0o4hLSr1iXW3DLo1zpbHT5w6pVnxTnReqOKO3rgXFV34Orp+5R1PQbodYKAQzZgA9n/DEGPWHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 16:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12080

On 19.06.23 17:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> swupdate generates the runtime version only in a git repository. As
> the Debian build uses a tarball for the source code no version
> is generated.
> 
> This patch uses the version included in the SWUpdate Makefile and the
> debian/changelog to generate the version string.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> This patch is for swupdate 2022.12.
> 
>  ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
>  .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb   |  9 ++
>  2 files changed, 103 insertions(+)
>  create mode 100644 recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> 
> diff --git a/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> new file mode 100644
> index 0000000..efc584b
> --- /dev/null
> +++ b/recipes-core/swupdate/files/0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
> @@ -0,0 +1,94 @@
> +From 48963be5c3cd33ed9f36db52130cbd1dda3ed007 Mon Sep 17 00:00:00 2001
> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +Date: Fri, 16 Jun 2023 19:43:38 +0200
> +Subject: [PATCH] d/patches: Add patch to add the build version to swupdate
> +
> +The build version is only set if build in a git repository
> +this patch allows to use the version information stored in
> +the Makefile.
> +
> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +---
> + ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++++
> + debian/patches/series                         |  1 +
> + debian/rules                                  |  2 +
> + 3 files changed, 49 insertions(+)
> + create mode 100644 debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +
> +diff --git a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +new file mode 100644
> +index 00000000..480b67f5
> +--- /dev/null
> ++++ b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +@@ -0,0 +1,46 @@
> ++From 40b3d8036ba08da2cb0013f5fefd4736b25dca8e Mon Sep 17 00:00:00 2001
> ++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ++Date: Sat, 17 Jun 2023 17:56:18 +0200
> ++Subject: [PATCH] Makefile.flags: Set version if git returns no information
> ++
> ++This set the swupdate version if build in a non git environment.
> ++E.g. pristine-tar build or from a release tarball.
> ++
> ++Also allows to set the EXTRAVERSION from the command line.
> ++
> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ++---
> ++ Makefile       | 2 +-
> ++ Makefile.flags | 3 +++
> ++ 2 files changed, 4 insertions(+), 1 deletion(-)
> ++
> ++diff --git a/Makefile b/Makefile
> ++index 9f6a33a6..56189688 100644
> ++--- a/Makefile
> +++++ b/Makefile
> ++@@ -5,7 +5,7 @@
> ++ VERSION = 2022
> ++ PATCHLEVEL = 12
> ++ SUBLEVEL = 0
> ++-EXTRAVERSION =
> +++EXTRAVERSION ?=
> ++ NAME =
> ++ 
> ++ IPCLIB_VERSION = 0.1
> ++diff --git a/Makefile.flags b/Makefile.flags
> ++index 2bec8468..f69ab5e8 100644
> ++--- a/Makefile.flags
> +++++ b/Makefile.flags
> ++@@ -7,6 +7,9 @@
> ++ # ==========================================================================
> ++ SWU_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
> ++ SWU_VER = $(shell git -C $(SWU_DIR) describe --tags --always --dirty)
> +++ifeq (,$(SWU_VER))
> +++	SWU_VER = $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> +++endif
> ++ export SWU_VER
> ++ SKIP_STRIP ?= n
> ++ 
> ++-- 
> ++2.39.2
> ++
> +diff --git a/debian/patches/series b/debian/patches/series
> +index 5638bbf5..12324569 100644
> +--- a/debian/patches/series
> ++++ b/debian/patches/series
> +@@ -1,3 +1,4 @@
> + Link-config-to-swupdate-www-path.diff
> + Replace-Font-Awesome-5-with-Fork-Awesome.diff
> + use-gcc-compiler.diff
> ++Makefile.flags-Set-version-if-git-returns-no-informa.diff
> +diff --git a/debian/rules b/debian/rules
> +index 57da4ca7..f645cc6e 100755
> +--- a/debian/rules
> ++++ b/debian/rules
> +@@ -17,6 +17,8 @@ export DH_WITH=--with lua
> + export HAVE_LUA=y
> + endif
> + 
> ++DEB_CHANGELOG_VERSION := $(shell dpkg-parsechangelog | sed -n -e 's/^Version: //p' | cut -d + -f 2)
> ++export EXTRAVERSION=($(DEB_CHANGELOG_VERSION))
> + BU_SWU=
> + ifeq (linux,$(DEB_HOST_ARCH_OS))
> + 	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
> +-- 
> +2.39.2
> +
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> index da44ae5..4401bd0 100644
> --- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
> @@ -20,6 +20,7 @@ DEB_BUILD_OPTIONS += "nodoc"
>  SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
>  SRCREV ="aa9edf070567fa5b3e942c270633a8feef49dad8"
>  SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
> +SRC_URI += "file://0001-d-patches-Add-patch-to-add-the-build-version-to-swup.patch"
>  
>  # deactivate signing and hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> @@ -37,3 +38,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
>  
>  # use backport build profile for bullseye
>  DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
> +
> +
> +CHANGELOG_V ?= "2022.12+dfsg-4+cip+${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +}
> +

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


