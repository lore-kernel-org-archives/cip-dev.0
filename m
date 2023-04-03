Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B47C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 07:19:53 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.44])
 by mx.groups.io with SMTP id smtpd.web10.64215.1680506386578269045
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 00:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dhUAY5Ga;
 spf=pass (domain: siemens.com, ip: 40.107.247.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b68eHIu0krS7lp41EXzgwxIIdIuCTkW8Shaw4I3xfjEQ1Od9cjsN10EETptjrAq7PnzGO1li0qqzWwChxuuyFws17ciC2IAoEeqgBte6IhNW2WirDHyEPoowQ8LBv8VRDTa6SYtUL/at7vOsM95sz24l27YcwtcRPllFggiNAfoTgBAVlAUea+SF0GTxevT0LWtLvC54zEa67VoGaWpOrPx4r1Gw5iXRbb8rZZTcj6zUAwhXksp6w3lioYtpnRYlbHwJt78soqMCl3nOcfx0oB7cSPkGIz1bEQKmPjyBSOS7kuPET5QU31b1a+Mib+g83ZITh8XgE0bGg0tGq2rsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXsyjNGDhAtYm5S0Id9UuBwyPopk6PX4RdW9L7EIOPg=;
 b=g/uu4SsIVDX9jebrZNO5bOO6E3szeAXNPl3PnMVpvEtS5oqf0YrvNOapk2U0nW/AzjsqqOz2927UPR5LF8LaceLo/nf1PMcy+nqRdDEE5wrVFzlxUwtHKQB+6N4bEJZthxjo7UWdm2goiVU2L44OPeNac2i4ejaiAqT6Xh4isURWg2N8xzLNHGFhm1aGDQKsdBJGGmlMjMuaRLTna/RmzMAMJfo3LeQ51uaZFM4G7oy08MUEyreeOjq/NG2OTwbEhTDB5rFplNlaE/UEZqzuWhmOUyL26FMTneI8BakCCZqsC57T4+qkHZA52iMyHkYn2IZHjUFUaSchCr9jEUBRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXsyjNGDhAtYm5S0Id9UuBwyPopk6PX4RdW9L7EIOPg=;
 b=dhUAY5GaFvEDQvgfkEAr9VbgVB/Ut8awNxaY7xpMPIo7ETdzeBM1dB+cMS01Qt+gxAUQUxcf34zW5A8Ac33QgWQf6bDm2qjEOdPGhV7wvDnjuk2o4YMPzButTexth3rHdMOq37U0Wen4NpHsC2zeBUdl/zMDmXuR1zH2Jt3CPdf+ZpV/3P6W2u6leJpx00e0DUwxHOSItzIVXeUzOb6iA//y9tdQRMpR46FPjiYd4aQ/+FE16M7aVl8ozfg2fAWPvEKqKIOqKk377F+iVz0tiahZ680I187SSOdXiz3ebmeeyTsexhexSUQfe6u5b/D+OWEAVmDpEvucll+cp8XRYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3338.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Mon, 3 Apr
 2023 07:19:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 07:19:43 +0000
Message-ID: <9e0a53b6-115b-5e1d-7f4e-b3612a6222c3@siemens.com>
Date: Mon, 3 Apr 2023 09:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH] make postinst script report all potential
 errors
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230329082426.355870-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230329082426.355870-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3338:EE_
X-MS-Office365-Filtering-Correlation-Id: 673ff3cb-5583-488c-fdaf-08db3413cbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oASUkCOZQsgiCUhTj0YaQq1SnyQCCsQNyNOi78/gkSOFO91nNez7czPkn37RKGZ6fgVRP6kWWgulaGFKt993A+jnVlcaTZ3wZiBJpqUIHWo7qiN0f4TcjBaK7K8pPQwWNLiuVg9f+vjxI6oLctK03NLIkA9aYM8+fOwoJwA3fKbgWORMxlnJER67WQn20FuWskC85+aH70JGydBEcdwsGZ3QNGHOqKA6l4jFAOrMFwkQflGHObJA5jPpDmgKRXZ42O1kO2J/qh/rcYRtF8tYMmzDXrSuLqWpNOkol9fToono54N/g5Cii9iPywundaqw/TdPAP++tQ2Zs5TIxMf8kmeLqulY8MJw+vHan7ZJnd2/A6+dtkkmT0RFJ3nhEQgeAfbMGZqJnUWpINeSm93eby9+ecmwwYgQP9xJN21sMiwMhdOGuri8YujqyE5DRk37ZOCgvJFCW7QN+k4CzQ7TTUAnLgYzflPL1zGHCSUU5ZE978nUsl6/mTgKV7bO/X2cU/2VkbanJkGuLkcB9CojZpmXE6fnpuJt2Uvy3QXe9pwRpwTHOPP11WDKwhJ2MN6RXsIXRXeMQli7PKhqbqUoj4iBNMebw+oiI/QNaaocqb1Klz0Zx4AACQYMTxdV1JwritoHf+MrGoqZe28b6etVfw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(4326008)(8676002)(66556008)(66946007)(66476007)(478600001)(316002)(8936002)(44832011)(5660300002)(41300700001)(82960400001)(38100700002)(53546011)(186003)(83380400001)(2616005)(6486002)(107886003)(6512007)(6506007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rk80SDMrWDNjU1c2TkVjVGtycUttZ3UrYXc4ZU54TXg0bUJsSHNWd0NLbEZo?=
 =?utf-8?B?bHBXaEVnQmNUeEpyNlFRazVDWU1VT1k3OW94cjA0UFlTWVZEOFV1VTl6ZzNl?=
 =?utf-8?B?RXZFU2VNeFltblRvY0c0a011TXZrUE4rSzZ3OFY4dmJPdHUzdTdXNS8wczJP?=
 =?utf-8?B?SHUxaDJrZnEzV2hDMXl6SDlkV0F5WFdiWXJpV1lTOW5oeGM2RUNCNWFoRnpx?=
 =?utf-8?B?TW1FZTQ5eER3SWNPSXdOb0YzcHVzQTdPM2NQa1Z6ZTJhSGxxcloyWitSMTZr?=
 =?utf-8?B?KzdNcWtLSGZ6NE1ieERXYjZPbXhkVWRMTktIZ3Q4QjNUUGdERmVEUzcvSkZB?=
 =?utf-8?B?VHU3djR3RGdsREIzM2dubURXb0FPek5FU3hxczZFSk9OZ1ZaYjNwSlpib2Zw?=
 =?utf-8?B?bGlyVjNQb1B4Zmh0LzJaL3k2Vm8yMndaRkZUeEdaMlYyeWNCNVJyU3pXSm9U?=
 =?utf-8?B?bXRoMC80SHBNVEdrSlJaRmRNWXRTb3Y3aFlGY0tnOHp0Q1RPcTIyNlN6ZmEx?=
 =?utf-8?B?U2JqVENkeGNHcG1SVmNsUjI1alVEMmFrVVJPR240eFQ2TGFaZWkwVEo0bC95?=
 =?utf-8?B?bFNPVzlmbW9VRjNiRlNrcWNPakVnampiVDRRRlV6YWtOSTNWMXVuWk1XUTlY?=
 =?utf-8?B?WmpjS3RnNzNQejNjVE1TTThsQ2c5bkFleThsQ0lSaUtpcWVMay9KbHJPaUdz?=
 =?utf-8?B?N3cvZDcwTk9abHJYSHJ1WWdMTjU5bUphYTgxcm5TQ055YWlMVmFXQmFFZTZz?=
 =?utf-8?B?dW5XZXV5WEY0MUZUT3hLNDhsYzRYSjREak9DT3B5aHdOTUFMZEs1U0l6SVIx?=
 =?utf-8?B?Rm5uT3BvQXordmFDR1IzR1JMdXJOZjNIOFkrVVlOVmt2T1lTMGx0am9waU5o?=
 =?utf-8?B?UzJCOU5QTE13Z2prWlhvVzljeWdiaGRXMm43clg3ajRJRVVMUVJCTEt1QXR1?=
 =?utf-8?B?K1c1SGVNcCt1WGlOVzRNSnV4RG8rRk0xWDJYWTRXUjVSYmU4bGRxUGZzalQw?=
 =?utf-8?B?bCtMZFBkZTJNOEM3REJYSXhnQk5xckpLcjRqTGxlR25TOFBiL2NNNGZOOFNU?=
 =?utf-8?B?N2lEaVBpdm5KcStJRGhLaHZpcUFhNUEvOWlsWU9uTGFDRFFIcXQyWFV3a05B?=
 =?utf-8?B?eTdoVzNaeW5yL0ZhR21TQ29rM0JuWjBIUUVwQUEzMjJ4RlFSMnc3OW03TVVF?=
 =?utf-8?B?QmQ4QU8vNHZuSFNhME0vUXhETTJOenpSTkxJdExmSjNVbkFPTUQwMkhmV3Nh?=
 =?utf-8?B?UkVKMVpHTWN2KzRnYmF1TFhiVEkwY1ppaTNIWTFxMTNXNXhFT1dPZTBYNVFN?=
 =?utf-8?B?S0c2OTcyVGR2N0dVR1ZEN1VJV3hVUm54Qy9JUmgxUytGQ3doM3k1WFByWjlB?=
 =?utf-8?B?YmtXcWVFMEQ5OENQWFFiVmtxSEF3cGJta2RCR1lNS0o1bU05UlZXSDBzSHNj?=
 =?utf-8?B?RXFFclZGdWNxTmM2WGxMRHZmcEd4S0hobTNUeG1JcHN2NkZmdWY0VWcxc0Z2?=
 =?utf-8?B?TXRDMXhGalIvb1RYSERHbkdCRnNSQktyTklWNFhvOVMvVXlLY2hYNVZXOXh6?=
 =?utf-8?B?b0JOZjQrdGtwU3BRSHBYRkpacEYwUGQxOGRMc3ZsUU54RXVEenZ3cEFVV0VJ?=
 =?utf-8?B?NXRMb3NsbmxKa3BqREJkdGhyMFhic0hJcEZDVkJFNmVCcE5IVTVZc09JRlk1?=
 =?utf-8?B?TWtMUFc0QzM0VWx3Lyt2b1pCY0s3QU1tVmRWcDNmUkxPUnMySW9UREY3UWhE?=
 =?utf-8?B?ekVQMytiRjBQb2U2MERmVTk0QzNiZ1Z6VnZMWjZXc3FWdDh2c2NwWHAydnJx?=
 =?utf-8?B?NUdDSU5zaVZuaTFqa0p6ekxNbzlFangzQ2RsQXpmNG1UTi9NZnllbFArK1Vz?=
 =?utf-8?B?OWkwWGpvV1NwY2wyOWtITVZDU0NpQlRzcVFubmN5TWZlelpwTXBhaDI0U3Yz?=
 =?utf-8?B?TEJieEV2RzFseWM1ZVRYSzJwRjM0N2xVL0ErOG41Y2p1amo1b1FieE95aGRL?=
 =?utf-8?B?Q3RHUFVDUnVDWFlhUnNKWi9pUmR4czNtYjFuTlE0dFZpYjd3SHFDODYyL3ly?=
 =?utf-8?B?eGNSdks5d0xURTVjcFM5ZVhlTWUrMXVUVHRldC80VEhzcXlYVXJ0RDQ4ZktT?=
 =?utf-8?B?Q3N5UHUyUk1yZnU5TXVxdldPWUR2aWV0VlNBR3B1Qm9OZmdvOGh3bmZ6V1pz?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673ff3cb-5583-488c-fdaf-08db3413cbc6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:19:43.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILqPIj1TAmpdv3BIoV0+zLYrcI4Th74ioTNFKmhYnrOJDRM7xIbg/aoBY3scnh3VUnt7cFQm4mDQ5s5ArHAZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3338
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 07:19:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11144

On 29.03.23 10:24, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Let us try and make sure that all bits we have are executed as expected.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  recipes-core/home-fs/files/postinst                 | 2 ++
>  recipes-core/security-customizations/files/postinst | 2 ++
>  recipes-core/tmp-fs/files/postinst                  | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
> index f6184d6..ab0db84 100755
> --- a/recipes-core/home-fs/files/postinst
> +++ b/recipes-core/home-fs/files/postinst
> @@ -1,3 +1,5 @@
>  #!/bin/sh
>  
> +set -e
> +
>  deb-systemd-helper enable home.mount  || true
> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
> index 167bab1..77a2713 100644
> --- a/recipes-core/security-customizations/files/postinst
> +++ b/recipes-core/security-customizations/files/postinst
> @@ -4,6 +4,8 @@
>  # Security Package configurations
>  #
>  
> +set -e
> +
>  echo "CIP Core Security Image (login: root/Cipsecurity@123)" > /etc/issue
>  
>  HOSTNAME=demo
> diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
> index da41046..39067f1 100755
> --- a/recipes-core/tmp-fs/files/postinst
> +++ b/recipes-core/tmp-fs/files/postinst
> @@ -1,5 +1,7 @@
>  #!/bin/sh
>  
> +set -e
> +
>  if [ ! -e /etc/systemd/system/tmp.mount ]; then
>      cp /usr/share/systemd/tmp.mount /etc/systemd/system/tmp.mount
>  fi

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


