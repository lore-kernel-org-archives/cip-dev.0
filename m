Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D7C77B6F
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 09:33:40 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.70])
 by mx.groups.io with SMTP id smtpd.web11.5207.1681464818646076838
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Apr 2023 02:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NsUutDxL;
 spf=pass (domain: siemens.com, ip: 40.107.6.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpm8IFsJWxm9++zQ12l/TGWV98wDSfkK84KNtHooV+fCHSzUftyOzzG+ZttoopytwJHvwmPp4O+TBSQEALPuYkvOSglo/KzqDVSyuochogMPabPzCNWUicIWpGmyVpJ96lh9E4WXHFE5suuzyEx72xhuq2m9VbEnuMU8aTh6NzrZ4EBEwLQ4jVewjMguACqUYJbj1+pywuQC/zv7rjtQVSdqLrKNVY54aDRBcerctatJq8aE3YzICCXiFtI6vwMjJeUJd/CUX9yZwH5wYy0X/jRok5hfeLB8uLKKCsxGvDRVlnAoHbl4XBv0eyv16RxQkqqbrT8ns2/oV1Y+iaYdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySYK5vDwCocXvyQ+f91seNtb7TXVAAgBEgNzabAIzUQ=;
 b=DVaatKuwkKMkCUlCtRcn7mH8WLAM68c5Lx0QNM8BFZJd7Bboh6KfOShzEZ7Z60wb2uxDoagh+Kv6DeNZfzsvdhlRUKJePHGa6gc2s0rC9N2sU7ujanRxwPg6kKOvshG+0zCmB4Cm1/Axya8aQyn20QFvAGiUDdcAhA85ehwDSAUy6XjwaLZ34BwRnZI0RhDNDkOay0sbnMVYNzjazacur2i5KvOi7DItI1UaUi+5RlLSATSC/mDqgsOU7ZpAOLvwe+OKr/zHWoMd/OeaTlgBNhrW7MTm83iT5JN5ut4PjmZ8lZXbMGL95W6H3359kQSttR6ExNa9V8tScTju38NYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySYK5vDwCocXvyQ+f91seNtb7TXVAAgBEgNzabAIzUQ=;
 b=NsUutDxLPWkOciShW0u1Ct54sTdExt2WNoumnMfSv9YyEGgB8TxcYkTQ6FrARsNPrBgheQrCD19S0TQ8D5B3e12vzMXttHQS6evFKrGHYb+kNIYY74Kplx3E3m/1MYzqs/LPuo3LB2eNbDr6QWCuvqFct1U63KjsXP1FtaXJzFjvMVTj/L8pmQAjInn2eqEg+UMSh9uEIocuohTgU67PG85S3DZJ6PLoSijAk3CLyNzy908qo7dfatD6dGKg+UQUDhB4GbPdiLRarUfxHvlCwAd2ps/VgQQueyi47AwDhZ1yu7VsqY0kr0YuSFB5u3+JBsT5X1cLrehYxXkvDyRytw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.25; Fri, 14 Apr
 2023 09:33:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Fri, 14 Apr 2023
 09:33:35 +0000
Message-ID: <f9ae5295-5534-1ade-80e8-159f623d5e8d@siemens.com>
Date: Fri, 14 Apr 2023 11:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH v2] add support to limit resource
 consumption of squashfs creation
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com
References: <20230414092408.679342-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230414092408.679342-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:205:2::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: e2895c59-9d9f-4b31-dfd1-08db3ccb51f1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XbE14OPiU+7LreSS+tWbqeaOTd1+6EXNu2Y4rGNla9Ip9gY3M6drUWqCOaTIHfwQ8XGsEKRSJLGSSxLMQXcWqWoOIwi1pEgiC4J7wTAS6jNntT4JZHxfTbzPGeKmfx8vMhFk8qCV+rn5uup68mmUSEIgnHHNft0hpO6fWZoga1rPbEwzCYX7/DeyYQnSMGlkaVLm5fiGh3iTyXykyieDXTfkkpEWE4Cie1JwSrh0FY9h1RZQPGDU6X/Ff0pV1EOr6mP5doCntnz/x27b8kOjk5d9npQbQ2cjwYrEJPGnozo/7VVVJcKEGhOC1yoV6D9w2c8Ab+J/KkIybLxDRDR/gwD+326vRVG0m8lP+0vTUrHO81GnUbyS8eqCyqHKP9bEtSSFnQVl0jkhpDNWdUpMgXcNMqIUfQUY9dCc4i5nC8C0invn5G5PAitXGyGQ0dCegFByv2Z8kTFvva5KBigjiGFHLaN4AVrGACNWXhJBUWEWoI+jSQwYlon0zawb49kDB1qR++oDj1AxAD+KPZb7Q/hG9eL/HFzcuShFtRlzJbSoAhzM4djFz1VPSjhkI/F5xkpuf+ph1EsheoYPwGPky2DKr7AcOLwAUk1lZHBSs57HxzB9D8BMz+zSsf+kk4gvLxj1RgfkZJHjLjyanGfX8g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(31686004)(8676002)(66946007)(66556008)(66476007)(6486002)(4326008)(316002)(41300700001)(36756003)(478600001)(86362001)(31696002)(6512007)(2616005)(6506007)(26005)(107886003)(6666004)(53546011)(83380400001)(82960400001)(5660300002)(44832011)(8936002)(38100700002)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTN6U1ZvMXNIK241Vms5Zkpxb2FMc280NW1hNVRMRXhNUmdubmdXNUF3NWN1?=
 =?utf-8?B?KzJxaUIrSHYzVjNiOFBWNkVlaEZDeXB3cnZjR1pPZmVyUUlJcm9CZldpdG9j?=
 =?utf-8?B?ZDRpS1hieUpOUm0wamF0a3RtOWREMm9XMXVoK3VrT2c3b1VCOXlFcHN5TjZC?=
 =?utf-8?B?eTF5QzQxdkFrWkJubVZNbXJJVWNTNFBaRmxiam9xTFdPYXVVWHMyQnBlODND?=
 =?utf-8?B?ZjB1L0VnZERjcysrN1huT3ZGa0FPUXYwNkpRSHBIWklia0xRRW1XeU52MW40?=
 =?utf-8?B?WWZRcVh2cnFHaDl1OWZXejdQRGRMeHNsaS9XNGN2WThKcGdzMHpqbkR6cU94?=
 =?utf-8?B?aGNWcVdMZ0JHN3hmdHhTS3ptenh3eWZtVDdrSU12Z3lzWlVuUTkwUmx5aE1k?=
 =?utf-8?B?Ti9rN0xaRE5HdmF2Q3c3VHliTWpzVmhRZm1SWjdRVXJJQi9td0NwanlkdzE1?=
 =?utf-8?B?RGxlaWhlSWZNNFlScUdzM05xR2ZoQTN4SlBIOUZWTWpOcWU5YW0wWWYrTHRK?=
 =?utf-8?B?MU5lTUhYc2pzSXBlbS9DVzIyeFFOU3pDWnBrSlBteGFGdkxJRFFBUVF6cDFH?=
 =?utf-8?B?aFNYMlVodmdrQ0VXZWgzNHMwSzMybGRsWk9yVnBwbmJyanB0SS9IcTAxTHRj?=
 =?utf-8?B?ZkY1SEtqdjREZGlHbE1hSk4ySU1ERGNBdnBuTmozMk5VRHVxbHFTQXlUdkMw?=
 =?utf-8?B?d3dUajZGWWo4dGFsZzBzMFFkMENtbVZXb0JBS0dkN0xHOHZWZ2ZtOGJKaTN5?=
 =?utf-8?B?RGVrRE9iMStFYVFTa1d2bytmelpJWlFvSzArRmd0Wk83aURFc09wUHdNdVNS?=
 =?utf-8?B?bElzMGhqcUUwZUhvU3ZlaElpOUdiQTBzZW04bnpKZytQTm13Wmp6dmZmME1h?=
 =?utf-8?B?K2N1Syt2dG4weFViM2JPdlhLVUFlOHZKYWsxKytFazQxZU5sWE1rOTJCcG1L?=
 =?utf-8?B?WVV5d3dreVZQNjFMa25xTUdBcTZ3dUt2ZGxqb05RcnFybFV6S1l6K2lGbVV0?=
 =?utf-8?B?TGFRbFg0N05BV0x2SEE0cG5uUWx2b1p0ZGQ2ZnNzTVBXdHltQU5tRVdxc0kw?=
 =?utf-8?B?MEZjcVV3TkpUbXBzMEdUd1ViOTRBcUJndU01TmF3enAyWUpkcXFWbndkb2hX?=
 =?utf-8?B?a2RXcWxBUDhHNk91dW84K2Y5cDVOYldHTkhaOE1SaWpwYXFZaFg3OG04WENF?=
 =?utf-8?B?amlkMFlhbXVLd09oWFRGaUR6U2xuckZncFVvYXlBalJXREt6ZE5CUENMNzY1?=
 =?utf-8?B?Zm43Y1JFOFEwaGc0SGpIWllmVWpHeXZtRnF6Rk1GS3ZMQUUwa21NTmlmd281?=
 =?utf-8?B?REwyZkdPUlRsQW1jY1IralVzSnJNZFpuRk8rUXdOTDdDSlB4RWtkMXdUVGtw?=
 =?utf-8?B?S3U3WXh2SXhuWnBRQnpSazY2clNtUDlRTjFOcWhNQVB4Q3U4M3h0VEJob2g3?=
 =?utf-8?B?djRyMVIveSs0L0pLOWNBN2lyb2JEVnk2NDBpUmo3UXA3MENkMEdsaEV4b09q?=
 =?utf-8?B?M2VhNXZpZ0tnWlNrbjMxM1N4M2t2M245N3ZZb2pRWUdWZndZN1RKajRzUmc1?=
 =?utf-8?B?NzBONDJzaTIzdlE2WjdTRkdqUzFEZmpuemtzUHpMQlM1KzYweWs3UjY2Y1Rr?=
 =?utf-8?B?SkdEd3JZc0xRNERBNFBJVVBwcDZSOWJNWHBsckhuUEU1Rkt0RDFZVWZQNjVV?=
 =?utf-8?B?U04xZTl2ZVp6cGRFNG94ZDJwQXJXSk50cmRpNC94WVpBQTNkamJ4UTNIVXJB?=
 =?utf-8?B?Q1I4Y0ltVmkzT2tSbXlHcHRjU1lZOURuWGYxQ1hNaVhkNGt5ZlEyOTdNVjFl?=
 =?utf-8?B?QU0rYUlTUkc2bEhIN3A4aFNQRnFDM3ZBV1UxMmszN0RwV1VpK0s5TmZRbE1Q?=
 =?utf-8?B?L3drODRtTkpXRmRnL1V3VSt6dW0xYkFDdDk4azRKQXJKRHF2clNrYWJqNmlL?=
 =?utf-8?B?aGlKOG9UZDFVczdPby91VDBqa0NJOFBOK0dQT0lRYjYyWHpDVHhuTWRnT2w1?=
 =?utf-8?B?OWZCTHVxcmRGaGFta3UwUHhVMEtjMUF6M21ZRmhnTTVhaGxvaTJwNWFtQWdn?=
 =?utf-8?B?TitWenVzRXpXQk1wdEFobTZwWDhpaWpKOTVTSTU2em9SN3krd1ZRRnM4NlRE?=
 =?utf-8?Q?RNX+kdhZuEQxrJiQ7z4g3kQEt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2895c59-9d9f-4b31-dfd1-08db3ccb51f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:33:35.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CWafMR88uL04+ucEyIJdOOIr1duKi6lS55RlzadQwIFLdNF9Edw8Dntml3Dli2rWBOJDKpdhWDsH7YA7pnLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 09:33:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11203

On 14.04.23 11:24, Felix Moessbauer wrote:
> This patch makes it possible to control the number of CPUs and the
> memory usage when generating a squashfs. The variable names used
> follow the imagetype variable scheme.
> 
> Especially when compressing a squashfs internally with cpu and memory
> heavy compressors like xz, we inherit the issues we had with the image
> compression in the past. On CI systems, where many tasks might run in
> parallel, this often led to OOMs and poor performance. By providing
> these options similiar to the other imagetype options, we give CI
> administrators an easy way to control the memory consumption,
> independent of the other options passed to mksquashfs.

If this is targeting CI tunings, we should also export the related
variables via kas to allow pickup from the environment, not?

Jan

> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v1:
> 
> - add reasoning in the commit message
> - no functional changes
> 
>  classes/squashfs.bbclass | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
> index a06c501..b14768c 100644
> --- a/classes/squashfs.bbclass
> +++ b/classes/squashfs.bbclass
> @@ -15,6 +15,13 @@ SQUASHFS_EXCLUDE_DIRS ?= ""
>  SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>  SQUASHFS_CREATION_ARGS ?= ""
>  
> +SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
> +SQUASHFS_THREADS[vardepvalue] = "1"
> +# default according to mksquasfs docs
> +SQUASHFS_MEMLIMIT ?= "7982M"
> +SQUASHFS_DEFAULTS ?= "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
> +SQUASHFS_DEFAULTS[vardepsexclude] += "SQUASHFS_MEMLIMIT SQUASHFS_THREADS"
> +
>  python __anonymous() {
>      exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
>      if len(exclude_directories) == 0:
> @@ -31,5 +38,5 @@ IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
>  IMAGE_CMD:squashfs() {
>      ${SUDO_CHROOT} /bin/mksquashfs \
>          '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
> -        -noappend ${SQUASHFS_CREATION_ARGS}
> +        -noappend ${SQUASHFS_DEFAULTS} ${SQUASHFS_CREATION_ARGS}
>  }

-- 
Siemens AG, Technology
Competence Center Embedded Linux


