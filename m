Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EAEC05027
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 19:52:34 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.82])
 by mx.groups.io with SMTP id smtpd.web10.1687.1675367553702645779
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Feb 2023 11:52:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KpQ3qfwd;
 spf=pass (domain: siemens.com, ip: 40.107.15.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKke8LKRJ4U4gdt6jvn37AHc7wmBtedQ9bMb2dfdSQNJZ6m90RimuKPx4g3yoVZ0K9QCsYazzu+DfQA5V5Usw8Xd+RWGCbyIl8FuVreWgAQgYSBDoWepvnQrPN1Bi75KW8mGxIgQzP/h268j45w5kvkZu7DJgNfi0Bw394n/1J9oNYVybPBeChYjg/o/y7Or0PxfLrReytVJ3SiPoZJ0bNHWbbNz7RmwVG7Z39al3XZmAxBmfkeuvIeNlWVvVzk6n8WNG+qk4fv3Gjq8uOL1Qk94nj8YBXP5tCJ54D+FIY2mZpX7ALImz36Jv9QOp+kle42ByyoO8sgXjM4tXPFVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUrqH4h8PD9PsTOZFbvHWnm/MfFG5ySf3NH12w9mL20=;
 b=UWBxwuex3Qgmu8q3Md4t+gMWepVhVWMDOrQwMvOpjVfzo78hBWd/HSSW3D0N2zF8T7XdkMEJsaAOTS0FNT8F2K2hpgccXCuxE1koppOamtHrfLyJKTs8p27N3kwaA1YIY9sQLTN0LP1M5iYdKnuXSx6Vnx77FCo5W15UeAoQ77KBP2+epJ2CT6u1hlK+nLt7DlsBvemPvh3tQZZNL4uYWT2/Tx2BYbnurKLq28hwX6RyHl1cIJVTvBCuRAzsucSHD0VJjQtoW133gKIdbnqJ6G6LF4dQZRg64s93KGQo5dN+nB3w+7JAEWG+7hxzDL9Ayd1dZ+xK+wZhzgSzLvK37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUrqH4h8PD9PsTOZFbvHWnm/MfFG5ySf3NH12w9mL20=;
 b=KpQ3qfwd9qRzvHNempADSsb61J25fA17n9wjCOcrWizruXbHT4uhNZw6SFKF5TCSvnKCF3wx6LmiJFuskRnqFTN9Anlo1ZLr7UTn1wocz4dabtWIkA65qjOidcFmufwhBynX1v0BhxjLUol3oZt2TQzGY9qRuOnBvapg7wM2pSALRkeM3MRAz+s2BcADxcho7LbOweXHRWxTWXSjLJZqcTc8Zjww6s3KLQneqzl9Sva87Gs23UZHhBuqripTrvIzP5I3DdYH3mMLrLnzy8IxuvsDigORvaX7K3suqlBgkvay2c9JCevxQ2pF8Zzje9JSq1ad2en2rmiTh8mYQPEmCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6388.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 19:52:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 19:52:30 +0000
Message-ID: <952c30a3-dd95-8ff0-3617-3a6eed0464d0@siemens.com>
Date: Thu, 2 Feb 2023 20:52:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] conf/distro: Use cip prefix and
 snapshot postfix for sid lists
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230202150607.824537-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230202150607.824537-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5befd213-0a7c-4fc9-7a8a-08db05570490
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q1Rp6PjQI7wglLgGL5yqqggD62J9vXtlX9whnU/W8W+I2F6pome/LM0GHo/ydlJ8lXW3fppqvdH659WQLCxuu/ehZMnWXJrFaMc+ClM9nXDb8oWTo6VVjEA3rwPS86YuRTVC86tfFyuZHpqCCE7gNmFLOdNpVC8KQ57BY57woPFPRMvxF13XAnDS1wRH9hY5lPi7GCj9bK7m+k+PEb3rQ9Dnl4i/aHa+AOorICMT8eU1cU+HDkGiY01PYagS/7mf+5XdwYKePSNtz2u2EH/qodsPnkt8Y5U+PgWsQC/3agi0va72pjqHU7AfPe3r4j7Tx9/FXWiU2TbEpEGfGploPhTaIGKYNhmtCNnRI+EB+rfMv4VCTlXv4/P7wgVPcyfYPX48yvWxsNuKan49CF7zl9tK3RatiYi+gruy/wZ07jRsmJ+h6ukHJitbncs0kFT1sq65eERQSmYih6PlFOiAgexooycqmNwso7E2iMkfsGJUDhWsQ+pddntM+uWTOUQNNWdsZwisCCxPCEuIhWulkD8z7CO6bGTNSH00vQVOmM/qm6J5HJLoreWLMfrSLD0NWYip4yOn9uwCwrcxcOLpt7IicFviZ29b+fDLMzVcbWZ9xQli7SF/Vl2tWwmO+9mdlNvWxMdRsc87KS6YCJxBd0t+fL/WOS9eoyV/PSTl6oOteoxBTZ0sbJAoC6HUgPH7fmqkh9mAlObjSsua39Wb6fjrnteLwpZ+OgR9/+wYZLWr4s7ariy/ZAb22bvHecWkJgzUaS+WnsGdYfdAAgZE0w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199018)(6512007)(36756003)(186003)(6486002)(966005)(44832011)(38100700002)(478600001)(31696002)(6636002)(316002)(41300700001)(82960400001)(8676002)(66556008)(66476007)(66946007)(26005)(5660300002)(8936002)(6506007)(6666004)(53546011)(86362001)(83380400001)(31686004)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHBqT2tReG9ZRWNDeVZmOW9SOUhQQ201Z1o2Z1JPSU9ncEdkblA4ZWU3a1Zm?=
 =?utf-8?B?L1JiMHVQejREQm50eC8xbDJiSHdYV1piT0FMY3VFSmVoM1haR3ZTSGlZem5Z?=
 =?utf-8?B?TVZPSXhOb3FVbXhDcEE4c1RSbUR1Qm9jdWRncDVEaFZLcmg3dTdWdmhEVnQ4?=
 =?utf-8?B?SUZNaWhhRW0zRkV1bVBSU3o2ZGJ6ZVBid3UyZS85NVU4SmdyU28zM1I1OTBI?=
 =?utf-8?B?NHdsTCtGeEtDYllaa1Bya0ZWQ1lCUUNJSzFLTE9jNmlKYUU0c2tsM0Z0d1hM?=
 =?utf-8?B?bmJObHVVZ2pjMG1vREdMQjNacWpGZSt3c0FOWFQ5K0JDSms1ZVpIYVdERVBp?=
 =?utf-8?B?VW93KzVhUnMvWExhR3FPUlRPMHdjNHJTNXM4dlcvMWZ3Y1JhMUNiUG5kcmhy?=
 =?utf-8?B?dkdocXhGekJTekg4Nkl2RFlSdzRJMTk5UEUxNk9TQkxFOUFTdUZaajhiTFhj?=
 =?utf-8?B?UkttRGhCU2czcGhIckNqUXordDZpNU1MRGpwM2w5bDVTT0FvZ3FpMGZpM3o2?=
 =?utf-8?B?KzdoQldkZXFVWjFoNGI3YzZnbWx4WFdDaWN3dUhqUkxFaDE0NC9kUnZRTUh6?=
 =?utf-8?B?SlFxTnVlQ29KeWxvd0RVUVJrTVJRZnE5YnZ0dXQ0MlhZTExlUUE1TTJzRlBk?=
 =?utf-8?B?OUYwSE5CZUN4cXh4c3dDRWE5RFpsaEEwR000UTA5UitGVm8raGdiUElJQ00w?=
 =?utf-8?B?Y2VUT3o0M3JTZ0ExTUVvc2FYcStJNFdoTWZLNWE1aWE0bTNIOVh3Yzl1SjJo?=
 =?utf-8?B?dEZTV3kyMTlieWJWWDlGUGhycms4dnl5dktjaDd2d1hiMjhEYlVIdElLNTA3?=
 =?utf-8?B?QmlRNWRtcU94OTN0RW5oODRwVWZ6YVpVSDRocGNvbHdObDdpdU1rZkJRMXov?=
 =?utf-8?B?RUtoWUhHZVBoa2RoNFd1TDhaTVQ2Q29ZUGR6MTcvd3hYNWttdkhhamNjSlV6?=
 =?utf-8?B?TVgvQ0ZKWDlQWEZpOWIwL1l4eTBiY2RaaURxNC9rTlVXWmZqRmJqbWxVNGtR?=
 =?utf-8?B?Q1lKVVY2RUNRazV2TUVCRkVtWXExTmtoRHBua0pQU3RHUERaYlBvZUUwMEtC?=
 =?utf-8?B?UmFrQklNaVBvWDBwVThEOXlidWVDeWxwbjE1dVlIdEpzamtuV29KSmN3UlN6?=
 =?utf-8?B?dVRMdThQUzZ6aFFDNGxtcXBRUGNHUFZNSWdrdnljZThPQlVZQUF5Ri9uNWVY?=
 =?utf-8?B?WStuOEYyRnl2VVRRd0dpSmllbHhOVk02Wk9nMGRmT2VQcFVZSjQxellMdU5x?=
 =?utf-8?B?YTVNZDhQNm1hUE5VV21GYXkyQXVYYlBLTE9hVG8vVlVVNmsvRExhd0xjQ3Z3?=
 =?utf-8?B?c00rdFFuQ0todjVlK3VsNFk0dUpWZHNNVU5IdnlUTXg2aEViSFg3NFJVNFli?=
 =?utf-8?B?dXdkc1RqeDdNUWgzOUE2ZnQ4MDdiUkd2QXVKOFVUbXBKN1p0S1c3cUYwVFhK?=
 =?utf-8?B?Uy9kZVBmMFdQSEg2N2Y5T0FkSFRvTHgrejlKTWcrS2tSajFMZEVuTUFpZHFS?=
 =?utf-8?B?OFl0Uk9TdUhGZnFWMURET2IxcnE2KzBjK0tOTUxrSStrb29Lcmphc3NhVXdm?=
 =?utf-8?B?bzF0cVBzanc0M3NGbjZzM0Q5WEFMcFJNMER4Nk5GN3pLeVJSRkxOcVBVd3JJ?=
 =?utf-8?B?Q0U3ZzRFdlIvbFNuY2JzUHRxcTh1eUZCTjN2SzB2ZTR0SXUvVTRDOXg3ZkpD?=
 =?utf-8?B?aHNHN2NCTVRFY0hoRmlxdmZLVGlDUEZJVHp1djBVUTh1am1hUzJNd1ROdFNF?=
 =?utf-8?B?SGVSaTJXV1dDbElHRmt6SjZHZlRIZnRQNzl6NFV5MVhUMWM1OTQ0SmtyWHdr?=
 =?utf-8?B?WVJ2emlYSnNFOFpjSHlvR2dJTGYxM2dmMjNYRWxBWjJHVFBJUnhaVGkxWEFy?=
 =?utf-8?B?bTlmZURwWHp0ZVRNOEdIV3lWWUVIalE4QllCMkdlbW8xbURmTjVXd051RWJi?=
 =?utf-8?B?dThIcnNtUmJEenJSbFhCSnluUXhkTXUwc1JjcEdPMElmWTBVTGcyNVdqQms3?=
 =?utf-8?B?UFNVZkxQVE1wNy8wTUxUU0hTRzZUL0JMTEkvZXY2cVNxa1FKMzd1ZWZDTDZJ?=
 =?utf-8?B?SUNwS2JhS0xFQnN1aUtzalFYb042RndkNWg5TFpFeEpIbWlWRER6Zit3VWZW?=
 =?utf-8?B?VXNqcTZyd2pHZWVqbVJPUTc5UWpnZkZWWTRMVUlsRjB2b3dJSXcyQ1ZIN3dU?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5befd213-0a7c-4fc9-7a8a-08db05570490
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 19:52:30.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGoSbNro4cT6lxdI8aH8aTBCXLSpb0/tGkT+wrCCVH/LhL+ertIgA5+zqzU5jW8roqxe1UEDtnjJmC8lojvkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6388
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 19:52:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10574

On 02.02.23 16:06, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is done to avoid infecting other layers with the snapshot version.
> 
> Reported-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-sid-ports.conf                             | 1 +
>  .../{debian-sid.list => cip-debian-sid-ports-snapshot.list}     | 0
>  .../{debian-sid-ports.list => cip-debian-sid-snapshot.list}     | 2 +-
>  3 files changed, 2 insertions(+), 1 deletion(-)
>  rename conf/distro/{debian-sid.list => cip-debian-sid-ports-snapshot.list} (100%)
>  rename conf/distro/{debian-sid-ports.list => cip-debian-sid-snapshot.list} (81%)
> 
> diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
> index 0b369bb..5f41bfb 100644
> --- a/conf/distro/cip-core-sid-ports.conf
> +++ b/conf/distro/cip-core-sid-ports.conf
> @@ -14,3 +14,4 @@ require cip-core-common.inc
>  
>  PREFERRED_VERSION_linux-cip ?= "5.10.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"

Blank line here.

> +DISTRO_APT_SOURCES = "conf/distro/cip-debian-${BASE_DISTRO_CODENAME}-ports-snapshot.list"
> diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-ports-snapshot.list
> similarity index 100%
> rename from conf/distro/debian-sid.list
> rename to conf/distro/cip-debian-sid-ports-snapshot.list
> diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/cip-debian-sid-snapshot.list
> similarity index 81%
> rename from conf/distro/debian-sid-ports.list
> rename to conf/distro/cip-debian-sid-snapshot.list
> index bf0f7a2..46d34d7 100644
> --- a/conf/distro/debian-sid-ports.list
> +++ b/conf/distro/cip-debian-sid-snapshot.list
> @@ -1,2 +1,2 @@
> -deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
> +deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main

Is that related or a separate fix - or even incorrect?

>  deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


