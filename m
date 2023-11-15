Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC55C54FA5
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:41:46 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.77])
 by mx.groups.io with SMTP id smtpd.web10.14767.1700059304970493963
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:41:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g44w82KH;
 spf=pass (domain: siemens.com, ip: 40.107.14.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdhdqbIaS9fOU6g7PKJ+ICu2E+5XWLEzJF1YnusFQSJYTV73MPga9sGiEMlQZDXRZYgOMiUEzC2zbSNifZCskwVx+F0Pql4o3e1FO/BIEboMB6e0d69JR0b5in6cyAOt/1QfK82mc83vXGCiVBYIC1V+iuuLl3hopPvN8PAzqB+CC6guAqYCZzeeDXzw4cYMBTpSCdTUKrq86OYaPCklBCGOsaAUX3iExu2bb66vThDmLJY5kZxF2Frxf7RU3/a+91Z1TRSldmCvNwxoJ4LWd2jG1KULyBcn4nBg3TR7pv0ctbTbjmi0A6+wv2vt3PvYn046G9ygkYETUiUX/JTDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNkInsYKptWtWRVgXKOHPQkSfnRr4xgZo5o7gV7ZaTg=;
 b=DDqVejza5pCeVPs9wqH+Hrs0fIiiiSiV7NUC1+rXlqmGuo+ChajQOMK//DYJJkp7DcyDbn6KztXGNEVzPVISNdNeBZnRvJcrveEgNl/NKbRekdBRACB22EwbDTYS2GWFnOUs2jzcDoBTi65yAY1fWC9VXVuqN6fo+ZO0kIiF7CJmK7+4N7562w1rUoVOMCMCdp83E/LM2g3flIvzrNH/vjcT0Cqomte3cuZSXTHrlMvEFOk/445biNtrzRsF/I+IQMvcrfPHqoZRoqHZR8gGLbo9/GJDgx25GGJsOyqF615K6G5MftgKZSQq5uF3Scep6UaW+1tIyY5mcEZcku4RqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNkInsYKptWtWRVgXKOHPQkSfnRr4xgZo5o7gV7ZaTg=;
 b=g44w82KHLe7VNbVPPwMo5tY10NL9NBEmMartMZ9y91hxDvWe4qYbLJcdpZTgr20pMZRVdR4QEWQmlox2Lt2K0AwgW1iI7Quw5ZuPDYSPwAouw4i23HW1MkD9R/8enEisnLhpfmPUMpYvhwfg8NEjZPNK4p3EL0g7SzIdpGkJsh7WNB2IR+82l8wo+WT4mC/KN2qYbR3YG+tX6+924xjOoyt3T1Kbdq5zZM1YOcVw247B9mkSOL/lMib0cbd12AWrl4GxTSmyK/Zw0JWKW3fWU0NDUmGODBWoQcLty69DeHATt3RMeUp488/otGcn5JTau4t9HuYtegGvwjeEFYaM6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 14:41:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 14:41:41 +0000
Message-ID: <07c96d4c-f84a-4dc7-8dd6-f31dbaef6e8d@siemens.com>
Date: Wed, 15 Nov 2023 15:41:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][Patch v2] efibootguard: Update to
 efibootguard 0.16
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231114163908.1199673-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231114163908.1199673-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 80254c08-51b6-4cdd-e15e-08dbe5e8fb51
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q4swci96D9kdSn62ZSy6GA81lnwki51clEW4kIyfY9CQAK3qh2Su0NvlyzzaR8l1ya2wxgP3wVLXrATzcagO3o2ALMH9zW0CnCyeXPBuk6mpuyikWkSmjvZBnrHaS0fgorsdmYszIrECYeobdeAy67KPwKN2eqQTVUDxdWBYksDAK4xULFh/LUtKDNWm5SPv0z23XTMk8aUPoQe58ZR7oIgCIs1zf7JdytwY2gC1xpiTLF3AFQSguKGBagI+xD+CgwVoE4ixxhXvxKtgdVX8H2THPTx4lQvQCuqH34lyvKC0MIXhySSDTsp4F1Or7ep8TLv9MtxrHDiuZ4WbiQl0Lp2rcn+cZc01Cs08g5f2Y34sGpWcC8jAgDegmS5BBNBhRaicFErf5AYeBtg+bwN8TNe3QqCfJkp3nCnn/+upHoEyFCDwNmJlLyVV52Hl9ASlZLWKxQDAEchIXNUSwRPNQlXu29EsZ1eYPcHaeOv8GHAeslz6CD7OhYpS8tRLL2q7SfajmdsGdUnGcs1AosTpMX1rzQhGrhQecViWpsUi2pszSu1i0bSFrt/77LDxGH6ovsnN3wg3vrS6aVhsvDAKHibf79bEO/s3LuuQJ8bMMIe8X8dFLORVb3lMpEcOaokpugx4+y/zVQEMnPrELL1bz9P38Es5LW0yQlQQt0SL1VM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(53546011)(82960400001)(41300700001)(6512007)(6506007)(83380400001)(26005)(2616005)(44832011)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(5660300002)(316002)(66946007)(66476007)(66556008)(31686004)(6486002)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0RIQ3BobzlMYS8wdUxTbU9vaDJNVXpnN21ETmQ1RTEyMHpDdWdGMGVRWEMv?=
 =?utf-8?B?bDlxY1JOclZiQTJJdUVCTnhDN3RNcnFSU2t2QVRwUXhzR1FqRmVTYStCTDZw?=
 =?utf-8?B?UHRqMXZBWWtRMXY0eVpUaDcxTTNSYzdGSXRZTEIrYkowdzlJTG4zTXVGbS9k?=
 =?utf-8?B?RDJObDdqM2NoZjdpNmRRSlNDQUNkb3R6MkI5QXNEeG0rZ3pxcUdjdyttaXpE?=
 =?utf-8?B?REgrOWVwcEtuZGlkeEs2d0NDdXUxdTZRb0Y3eEsrVUpCMmNScGt2TDFSUjRo?=
 =?utf-8?B?VUV1aEYxeGo5NWE0SGxaVGd1RE5TdmN5YXE5akM3TTMxTXhDRFlRcnJmUzc2?=
 =?utf-8?B?cC84bGgxTlppanMyVHo0ck5pWmZCQi9Dd2JVaTNod3JucjRiN0JyMXNLT1J2?=
 =?utf-8?B?WW40QjRUakNxNjE2RUJURzdGZGJnQmUrZ1JDdG1KZnozTW03RGIrWlFhVFhl?=
 =?utf-8?B?ek5iNVRPVEQzUzEycWh4RHNzNGhNaHQ3MXA0bld1clNZTy9Gb2djOTNkMkZF?=
 =?utf-8?B?TXlOMGd2a0tjWk1ZdzRVS05jemwrTVZaRUJxbGdVNkFNZ1ZuZjhHcmRaNGtL?=
 =?utf-8?B?VVNQMUI3UlNFNHZKVGRROWdORmZQc295ZHZaaXlrQVNDL25RQTZYSlh3bElS?=
 =?utf-8?B?dTZ3T2dEcTFOWkF5Kzh3L0RDYnpFOHo3M0pmc0E5QVJDT2cxVFJLZnd2UC91?=
 =?utf-8?B?T3c0OC9MSE1pcWRwdjMxUWFreThqaC82cWZtd1d0Z1NMNkhFS1dCaER4cHZD?=
 =?utf-8?B?dXdGaWhEZjNBMzhldW5VZWQ4YUlabitQeHhjcll4ZndXQm05Y0g0Qm1LNHVC?=
 =?utf-8?B?VGc3aDRhcUdaTXFBajVRZmJwUFYrU1RCVnE3VWlQTFl2T05RWFRHSWVTUlB2?=
 =?utf-8?B?NWRubFZJdWJCMEIzKzlqZ0pWNmVrMHRQR0VObmEzOXNkMm1QRDFjOW9qMHhs?=
 =?utf-8?B?c2FKMFVQcUl0SnkyLzl3K1E1bnRpR2dkOVJrQUsycDIyUDNaZmY0ak9pcmdV?=
 =?utf-8?B?NzJqdlZPRXJCaWlJTDNoS096QkJ5VTRKbFhLMGQxcEgvRVNKS01LbTRUeDMv?=
 =?utf-8?B?cGlmaG1VbTJyZU1yVEtYNXFLS0ZmWVA4bTc5RGJRTlRzb05tUDZSLzQrWXd1?=
 =?utf-8?B?R3QrTURrQ0ZGU3QrZlV3ZTFUZmR6VzFVRjU0U3dDMHJwdlUvdzBTS1J1NStW?=
 =?utf-8?B?a1F1Mkw1VUJqaU9nVFZSeTBtcFZ3NWRudG5QbkNnLytkRllBWVdSUGFGZlNj?=
 =?utf-8?B?RGIrbnFOOGE1SXNUODZlZ0k4WWFqamlkcFJOZm5rdUpPaUVJbnhmTGl0ZDcy?=
 =?utf-8?B?RlpRamJ5aE9BVGxRWHREWGFQQVpoZUV2djFiSGpINEJRQ3JIWnRrTnlPd0JR?=
 =?utf-8?B?WVVOTjd0TGdEeklSaUh5M285ZmJYUEF5NHo4dGhLWGFDMW5wdHA4MnNxMWN5?=
 =?utf-8?B?K2xINVlyU2tzRHJBY1puNGQvRHR4WW1jR3JuZjFtdEhhdUgyS3RPK0k3REs0?=
 =?utf-8?B?UUcvWVpMeGlZTm1sOUF1Q2lNcWh5amhFOUFzMUZld3NhRjV2VnRVL0g0a0do?=
 =?utf-8?B?SUVmODJhWllzSTFRVGJvOTBwWTAxcVRodjVzYkpjbmVsN1ZhOEJ1V3Y5bk9a?=
 =?utf-8?B?THZuOU5kNGg1YUZrTURkR25GOUVmRWxqS0EyWVkzd01hdDViN0JiNjMrTFhB?=
 =?utf-8?B?TjhDTG9Mb1NoKzlra25pTVp1ZDAybHZNOFB6bzRWYmhnSUdIOSt1QUg5U0JK?=
 =?utf-8?B?cGdVTmlwdmtpZFBvNEN1WHcrSW1XbUFTUXNxWGdiN2dMWitTdmpObzVjUU03?=
 =?utf-8?B?Wk9DOEtQTkRHaHRSU0lsdFptVjdxbEpUdzdlVGpPcjZEYlQySDF5Ym1nR0t0?=
 =?utf-8?B?TGtERWVnWnd5QlBRV2h6am5wVEtLYWdIMXVpejFGcXRzTXBYV292UkphOTNP?=
 =?utf-8?B?K2M5QjdyV1VsWGN5bTk0Y2dWcDNIZ3ltMUJ0dUR0MVFKcytPdnZaaDJNZTVn?=
 =?utf-8?B?bDBRSk1iQS9GNE5iVmNTQXBzdUZSc05IZmFzWHZuRjBJNStOWVJXUW9aenYw?=
 =?utf-8?B?MGNaYWQ5Y1hackpXQW1nVVVTTGZibG9pNHI2S3pjUlh4SFg1OWh2R0dSanB5?=
 =?utf-8?B?SWpGNTFSZ25ScGw2SHBIN0hEcnVaTVVCdktnR3p4S200VlRqdXRaVllOWFpK?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80254c08-51b6-4cdd-e15e-08dbe5e8fb51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:41:41.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6rZxu34aQfrf/OqPQ144QV+VAlQz3rDKGjZhRbi+SkRrCWevOlCQZLowsr23BzASKpgCE1Lx7SwWKLNMN00dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7564
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:41:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13585

On 14.11.23 17:38, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...bootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.15-1+cip.bb => efibootguard_0.16-1+cip.bb} (75%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> similarity index 75%
> rename from recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> index 0cfb6da..a7ffb00 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> @@ -16,13 +16,15 @@ LICENSE = "GPL-2.0"
>  LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260aa954499f7abaabaa882bbe"
>  MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
>  
> +EBG_VERSION = "${@d.getVar('PV').split('-')[0]}"
> +
>  SRC_URI = " \
> -    https://github.com/siemens/efibootguard/archive/refs/tags/v0.15.tar.gz;downloadfilename=efibootguard_0.15.orig.tar.gz;unpack=0;name=tarball \
> +    https://github.com/siemens/efibootguard/archive/refs/tags/v${EBG_VERSION}.tar.gz;downloadfilename=efibootguard_${EBG_VERSION}.orig.tar.gz;unpack=0;name=tarball \
>      git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
> -SRC_URI[tarball.sha256sum] = "9d2d46913ed8013056a3c2b080a997e68d78d92a1051ced06fbfefa93353bb7f"
> -SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
> +SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
> +SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  

Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center


