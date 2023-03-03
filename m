Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E07C64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 07:23:24 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web10.18156.1677828194535241017
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Mar 2023 23:23:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ekgC3kQ1;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf5OQxsCcoP0K/X+W6x/qDLIA779vB6rWLGl1DoA/akINeTubjHLPlbi4UnpFus8T9ofcQXkKyk1lnQAR+o9999IkMtXS39GG/+qzleNpOJALzufJmBwn8dexoyLt3GpCQmWxBdjMri63DP0N4Jt1qHWFQ27hNjClEqfoE+QAu6zSRJCr3s9oVFL/QcUHJz4yFUZzhyF3YvUVyZQDPMcn79ISA6KvzopirVrRtpR8gd5n7T+0croSlkw+iIVhTp/+KXpc0osx0umPwE+JKfgejuiztaOXOeoJ7Cp6z07qF+01H0rMICzi1iKYAAiBr1GKhx77FwhCXkHtFJ4oA1qQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG3EbbMxGbxbGxotKp1okLDl9i4nVy8ItnY/SvuY35c=;
 b=JCUm3aikSkoBGi2em9Qjl203XlR4jRH64MjHbohZoh7EZMS4zb+wo+eaqlY+0ihqRVSUeqzQO70N9wlO1PElurM1uP5wJMhbvV9cmIYvgzQI9NHMbYqIFgBgDQcHWwhBX8bqCpNt6woGp/u6TZ18Hy4ctd/6TDw0CcSKhXt/3goWevSjcdCGTL6XTA5An70bewr9D/N14+ySXxwzgeM7dQ4pwARC6/zg8fTji7gW9vtCedSFUKEXJD5pvyDzeqt22Lm8ay3d5lpUxSJfw+2UEPJRjh6ap+/45dUj2lYZ6+zrQk7H2rXLXh+SKzHZMjv+cu7j03mF3UrvZXtNQaZ8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG3EbbMxGbxbGxotKp1okLDl9i4nVy8ItnY/SvuY35c=;
 b=ekgC3kQ1g4AFeTZDVYFjSaMI7vmcnUqwTcbEZV4/k7BVY+EgAHWeYtZaFdtAbRkPi1xCkKCJZtQMjjtx/jDhzX0VIEWSEdz7EYK+EYEB5cpTiu8HbR6d97AtZVGpyKurZQE9k/hbvTCcvGHHIFSl4wnjAJrs3UUZziYuJkB6sOhzLYlt9nxHCj3wsSKWwFLsb2Iw//xAYrdjqTtaRboUCcQkC6TkHXeaLFZKEyxIJg/Ak9K1cXgQ3XvW2yf9VH7E4XT2sQnDOAMdvWPYYbU+OAIYuRSb9bpap4Bg1z7RyiGVhfsNu0S6BUfOv9AAS6GEDya5GFp6SDnGkFAMFu2XZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Fri, 3 Mar
 2023 07:23:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 07:23:10 +0000
Message-ID: <a1518b5a-d015-3dd0-9249-ba73700f4918@siemens.com>
Date: Fri, 3 Mar 2023 08:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v3 3/9] refactor(u-boot): deploy via
 sstate-cache
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: daniel.bovensiepen@siemens.com, quirin.gylstorff@siemens.com
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-4-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230302152659.2096307-4-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a8411a-e184-4a94-d262-08db1bb824ac
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nX0OxAaurFp1QgKVMzr6NytvcyX1cl6MtFlKWSEGz0l3w1JI5oQYNr3T/G6pwtlH46xkaPBsV3cXRLCcHhQLE3RSyzvzD7MEXTvKie337KhMkioitM9kmaEfX3tzkd95/rf9JSf/zk74ybJA3HxU/nZmm3wAc4uXqihhwygIF8oYXOlS7GcxWs9L1hgRbFPgs3Fpo3QJKlWUeBkbMs8MFJKXEv2fH2NPsRcP1mi7OOWcugTooAEDgc5iUnHfpX7r2cIHTeNFPyHkkKSVXsp7GE8zKPsIPFy1mJQyt0/Xo5jG334dzqItXPf1K+tVDfUTce0CHPpyGOHasvUynYS89hH7rH4k0qAnV4rK6ob2Qwi+39RgzKvZQlXKpgybR9HD1E6DmBYYeIyUBETetSk917qbah3SRWUIGliQ3HQgMM51WIwDQZyENowZazcQfRLdzCU2q7BlxVs0AO++yCEZG0EpQVLoumNo+F29zB0U+H72cSsozlnaDHqd555av/zvaCJzlf5s6gBbRL8t02aZwLWwsa3DImJ8h5ZCMQC5nPVbo3twt+/NUeh/d/P11XAg46pSSzdKto6j+gXc9WmnTlmG0VMiwnKORlKaV7HYpKEChBqhkBwgQAjnrG3pNgrhUPtiDjMrEIw7Zira3Rnr+wN76TnJKtRJOboErp4IAYfI/ijcGBQiwwfMGy8ngEqNKDPJs37o1+08oX6pL6jlBOAXU8MJfATpcMNtazw2+co=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66476007)(31686004)(83380400001)(8936002)(2906002)(44832011)(5660300002)(2616005)(82960400001)(41300700001)(36756003)(66946007)(107886003)(38100700002)(66556008)(4326008)(8676002)(478600001)(316002)(186003)(86362001)(53546011)(31696002)(6506007)(26005)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUZYVXVPZE1OUHJac0N3OG4wNXdBaGxuY0doUW92L2M0eDlUS1hETlpYajRI?=
 =?utf-8?B?MkxtNUQ3WGtZRDgvTjNXbGRkcDV5aGlCTXBRaWNvYWl4c0RzeUdaS0xEWUZm?=
 =?utf-8?B?ek5NV1FEMUtOWmsxUmFjc2cwK1BKZGRuU0xybEtLaUpwL0lueVhIdmhMR1ph?=
 =?utf-8?B?bGZ5QW91OGJVb3BsbnBrNWZwN09mQ21ieUp6SndLN0dsZFVOdXlDdWd5NzZL?=
 =?utf-8?B?Ukw2cGQ1NVZmSElNU0ZXY0cvMi9MV0pCSUJseCtxT1JpN2h4MHhZRjY4bzhV?=
 =?utf-8?B?a1M2WUhOY01JWitwTjlEY2t5NUh3SU1sN1E4dzU3SFFOZkIxUzBqZFFTdEF3?=
 =?utf-8?B?ZFhmOVBGTTB1UHBqUFEwcUY1UjhXeFlpdFNoTjUvNldiaHFvdkl5M0xVUDAw?=
 =?utf-8?B?YjFVV0huR25WYnpsV3RZZU56TmtNdVRKYk1QK1R1c2VIVVMrajdmNkx0NjRx?=
 =?utf-8?B?UEYrc3BHc0F3NW8xM3JNSG0xNzU5QzNFRGNzMlhvTldZZ1hkY2gxN3BIbG1Y?=
 =?utf-8?B?Y3I2SjVwRkMzVmZKQmxiMlduQXZ5VERnME13TFlJUTN5clpCcXlzbWJNOHhh?=
 =?utf-8?B?aFQvanQyZzJxTVJaVnNUd2h3UUYrTHlaUDhoVGpQNmxqdWI5LzFrWGhySkxU?=
 =?utf-8?B?R0dWUXlmRDlUUFd5dHhFWVNIbFNoSGYrZm5tcWc4SncxSktJaHo2eTg1bGEw?=
 =?utf-8?B?RFh4RnQ1NkNCakdmRjVWV2RBc2xQQzFOV25ZN0xXQ2p5YndKUjh1cUxDQkpG?=
 =?utf-8?B?TldDNU94cnU3MCt0OGFWMDYrU0xRRUZOcmpvb2w2ZS9HWkQrSERzRU9LSWVK?=
 =?utf-8?B?bEF6SVQxNUdpOEZDSmU5QVJvL3ErSHIzaUw0ajVRL1NYTGZ6UFZ2aGRNbFNj?=
 =?utf-8?B?RVYzdGVwRlB0cFgxL2VKRk4vUWNoOFV1NEJVVytTWHRteWhQM3MvS1J2UG5y?=
 =?utf-8?B?ZVo0c2JoMzJuT1NibUNMOXAydjZiLzBRMkpkSWw0bU1pT1M2SUt3V2s5UlFj?=
 =?utf-8?B?N2pxcTBTSnZ2WmJnNE1QbjR3aXZoM0UvOEx3dWdOTjhEVGxJWkZrTHNiM3g3?=
 =?utf-8?B?SGhCS0ZuV01XUWRuTWkvY0crUVdzWXNXRWlSK1lPUmlLeVgyamhNejNjZFJi?=
 =?utf-8?B?b1dmK2Y5Z1VNOXEraHdxWkl5Ti9LU3BGLzdHOTNUM0dKRStDZ3drU09pSWlC?=
 =?utf-8?B?UDJBTlI0dFVJaDYxK0dGU2d6R0hiQ0FCL01VdDF1QVFCMTRmUG45ajFwWEpT?=
 =?utf-8?B?WWpnZWtOYzNPTHdxVWYzSjNYbmdyVTYxT2xiSmtyc2J5WTlrUFBsVFV0ZFMv?=
 =?utf-8?B?emFTWmFqSmRWN1FOT0lXS2lNNmlTakJEZTBWaElWM250OVQrMmVkRFdXbktW?=
 =?utf-8?B?YUpSS2cwVllzOUdXanNSSm0vS1NHUEJVeENhNVRHbGdmVFJEcWRDaUZOelBV?=
 =?utf-8?B?QWhoS3pJakhiRmt2RmhnNTdIV29UaWlYcmFhVklOYXlnd01yZk84ckhmMTI2?=
 =?utf-8?B?RWxISG1haHFRRFErR0U4Y0kxbXdzNkFFN1V6dE5iY2cyNS9qbXBEOFEvbmFu?=
 =?utf-8?B?ZE4rc3VBSHpFRFIxUktUSDlFNWxCQVE1enJMdk84T296UUxQZElZNk9IdGdX?=
 =?utf-8?B?ZjlJUmtNWXNHdE5ZbVdscTl1My96TEpxRHhSYnFTTytwSkltS2FxbUZBcEp2?=
 =?utf-8?B?aEZmTzU1Y3BVZHA0MzRoZGE0VzZUbWhkSExFZTRIZGJSWE42VXVZdmwwS0tI?=
 =?utf-8?B?N3ZqV21KdHZyb0hGa0RGaXVEdkcvWjB1Rm9KNElFRW54Q05OWFlEYnlTRE9Q?=
 =?utf-8?B?RjM3Qm9ESnZsU0Mwckh4b1FPMWVUNm55VWE0VFZWWEY3dzZ4Ky9BZGdWMnRJ?=
 =?utf-8?B?aU5XVEl6YkY4T2FjMS9BY0U3U1dYT2taTjFxUm1WQUZrUXp3SXA3OWhJK0s5?=
 =?utf-8?B?SmRCaUJPMEdEWjdTNld5TXh3NGZXZlMwS2NtWXlCYVZOS29iUlVZV2JFaXNw?=
 =?utf-8?B?ZGJ6UHA3QTh2OGFzZjNHTnpBZTV2MUVld1hTTnEyM3UwNzRYVDQxUzBTNEgv?=
 =?utf-8?B?SFBqQ1lFVEY1L2l5dEdFWFNLc1psQnh0ZXN6UUlQVmdiWGE2bUdUd2N3aEVU?=
 =?utf-8?B?RmIvSHpndFgrT0VSOEgyemRmcU5VRkhWU0N6d1crZTZWNzVkRVM5bFF2RzVi?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a8411a-e184-4a94-d262-08db1bb824ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 07:23:10.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFENUGaOB4E5syVREjBAv6PG06qKgHkZbYNfeuC1Y/5SLf5NwlmHlnpUUYLh4IGn6TYeJQ3vxFpARzUtay6HYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 07:23:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10895

On 02.03.23 16:26, Felix Moessbauer wrote:
> This patch refactors how the firmware.bin is deployed to the
> DEPLOY_DIR_IMAGE. Instead of directly copying, we now deploy via the
> sstate cache. By that, the cleanup is automatically handled and
> potential conflicts on the filename are reported.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-bsp/u-boot/u-boot-qemu-common.inc | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> index 0a9a15a..4d8b240 100644
> --- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
> +++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
> @@ -13,11 +13,21 @@ require recipes-bsp/u-boot/u-boot-common.inc
>  
>  U_BOOT_BIN = "u-boot.bin"
>  
> -do_deploy[dirs] = "${DEPLOY_DIR_IMAGE}"
> +DEPLOYDIR_U_BOOT = "${WORKDIR}/deploy-u-boot"
> +SSTATETASKS += "do_deploy"
> +
> +do_deploy[cleandirs] += "${DEPLOYDIR_U_BOOT}"
> +do_deploy[sstate-inputdirs] = "${DEPLOYDIR_U_BOOT}"
> +do_deploy[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
>  do_deploy() {
>      dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}.deb" | \
>          tar xOf - "./usr/lib/u-boot/${MACHINE}/${U_BOOT_BIN}" \
> -        > "${DEPLOY_DIR_IMAGE}/firmware.bin"
> +        > "${DEPLOYDIR_U_BOOT}/firmware.bin"
> +}
> +
> +python do_deploy_setscene () {
> +    sstate_setscene(d)
>  }
> +addtask do_deploy_setscene
>  
>  addtask deploy after do_dpkg_build before do_deploy_deb

Also this one will already go in.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


