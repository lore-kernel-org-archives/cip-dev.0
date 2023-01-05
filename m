Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30609C3DA7A
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 15:23:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web10.15435.1672932177927204593
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 07:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UvNicC/H;
 spf=pass (domain: siemens.com, ip: 40.107.20.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctd4lL7oYJfbln9+1GPqjmL+oa28+rEsls65v8BWH1iVmlw3VvQ+5tbLWi8STf86LLzpqmrc4/Svgzf3Ad9GBSUDeeMFkYmKnl8tC3Twi1M795mpW6z1MTOY87baCC1+BToOJnkOKUs9kV+zG36NhwLE3613q+3416Lq3sNm8RycUTDWvm7xQwEg1zDMtvBPLNHEoLtKqX8bfpBFjt+HJA2JjKS7PRVehyArsOnwGJOMrFTNntIzymm+X9IZC54TPCMgnEb0JaAEHTc0H5igp2deU//Ho3b0W12Bag8m5UfYfFawNOaTE0K/Z3aGlJThLyxaNaJtn0idBtUyxGM29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txS0lZI6n4J5ZkGQO/hre9g2fgatfKs1UOYGOhmqg9o=;
 b=C7laG8l0p8dr02KMzWwBx2o1fxlwv+PW4FMFC3b4p10ud9wMi7+aE6Ap0+sB1XKei2Dfawk7vjgsYfhq7pZv5wd8slYmILRrCZv8yBWJER+qunOjeZQNkM7eO9nNlZ9YbJREip/0/R3x8zPHPbtzHGBQQlmCJ2LREDJt89WOc9G+ZVUXS3SAUYc5uGDSQa2z3igO87FUQKL2Ub6/S56VZy1SQotkOYZms+GExWgWJUBdtOuJ+YWOVvr6DsxPy7y/vrqsjzwcSB2CVUGbnCq6Q2PH3d35OE4/ikx2iGwYMJbz0ZxJPl1LMHIdwRE9P1CRgU/RPWwoLCs8N2sA3jjfdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txS0lZI6n4J5ZkGQO/hre9g2fgatfKs1UOYGOhmqg9o=;
 b=UvNicC/HGr68SbmMiO0ZuCscgZNRrUSv9TOGBqrkpecjAQiC36qGFrcNOd5iUXj+s3BckQYkXTo7GnLU3OtzfOUZQuYdeXM1pvBXksxpJb1R78WlgwxpFpYK1/qN+f+HV3wejeTCrRZxrQdkwzFyHNqE6j44XrRj94GZ7Qss3ePZMYh33y2XS3xF86CmMpNyD9O5irxr6LyguCGUCNTR5Pua9KfvoYl79vq7f5UC1+UrkX8YyryzGYLus0Y3DSUnW+VujKDtDssZ2W9X35FBfr5yLDpyY5Oqew14dYiuHIOxxQf2CqNQm33bScstmvrwiz2QsY+7wqeQY4Lc445cXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:22:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:22:55 +0000
Message-ID: <5f592607-83da-2ac4-2350-8ad5ef37c021@siemens.com>
Date: Thu, 5 Jan 2023 16:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core] security.yml: Add root user credentials in
 security kas file
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: henning.schild@siemens.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5d42b2-e9e1-4ec3-b735-08daef30b7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QxvIauC17opnxvKZkOjYmf6HQcBrUx7/3iJme2Gv4IUvyLV/62yOvjwx5reHv3JV7/wOLF6jA6WZpn7amdP8ORwcysc12U1uJerW0n8PB+ov3L1Kc1gBTOPvxyhpv968t5woVmssr64XkGyF2mlsKW9ZUlgM9hzxIX8Vh9j74MmXb2dZVPhOPHFLqQOsFti58W/s0iy4EOhxPR45mYUGY4o3VQavRwztqYnmK+E71kFIWbsmif4wmBfdTsSudfbG2JEnU/beslqAOp9NYjRCQTicUVJ0qo/gAnNdyKXfVGZILY/UY4JAGdh4nw2eCWeYwj8HrVhTgTHfSvwQrQYflgFEeDBzt4Xza/cXeSX4Vp7bS9dDaeOOSwDXSVoRPKQJVXm19DbhSXfCKNq8YGyMPXgsCW+NT8TalGP7SdpQu2Ap3gbCYnIm82noEqLY0picy5DOPx1hgWK6CIdxvgmGZcbjxCpaIIdQ1K+3qx2r7QTb61l+DKK7Hwo1RfBnWrpVMhk0DWEu1lBBjK/xdkd1Wd4OmH6jGCKAVi87jqWxZspdu3T0GnU48R6FpryhSy6Pr3z/VyEXMK+XKwLTMUzPClYWXHIzC6iBMrYLzfrDuFkKk/7QYr9Q0r4STUDL6WG9P/bGVN2pyPYVuMNYa15MoPRS2haw99BAheEa9gAbTf9zT+N9DtsqcFh/v6xBR1P7D34MRksA0347JtbXqnclA7vnpHExLz/VmCjJycHmB1E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(6486002)(86362001)(41300700001)(83380400001)(82960400001)(38100700002)(31696002)(44832011)(8936002)(2906002)(5660300002)(53546011)(6506007)(4326008)(6666004)(26005)(316002)(186003)(6512007)(8676002)(66476007)(66556008)(2616005)(478600001)(66946007)(15650500001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmdGbFcySVB0QVY4SkNTVTljWld3UWVDZ2xvd0U2Rnp5bUtyTDlEbXV0SkRG?=
 =?utf-8?B?dk1EcUpSZTFKWDlpcXRlZ2REL3NXeFpWeXp1bkNyTlE1b3JaZnFlRW05U3JN?=
 =?utf-8?B?ZFNCb2lEWmdCZ1gwNzdld1BNKzZsVEo3cy9NMTBqOHdiYm11Slkwb2h0Znk4?=
 =?utf-8?B?d243T1hmWU5PTGJMOW4vVU4yT2pGaFNwVmtQQUNDTHJkQzhIS2hDenRGdWRQ?=
 =?utf-8?B?cUp6ajI5QytTZS9zbE5CZ3dBeUk0Y0ZqYkVnSG5xWjlwME93QlRrSUhMTzZV?=
 =?utf-8?B?Ri9DcE1ZclJxSDFCNWgxYXVId2EwaXp3TnZuR3pTVjE3N3o1MHBaU0hET2pi?=
 =?utf-8?B?MDFhVUhOemdERlV0SU04d3VFQ0FUSmhnSElQWXg5S01La2plNXhGeDNDcXFW?=
 =?utf-8?B?NFJaUVU4TmRtaEV0aWlLMVhtQm9KRlByTDd1SDJJNnVLNlhJVkplbkVBVTZX?=
 =?utf-8?B?VmNNTzZSZ29GTUtnYzZHOHQyS2h5czhGY0U0UXRCeWZybHU4SWxxZXJFN1FN?=
 =?utf-8?B?QXE5dXpRSGF4dWFCUjhxenJ3MFpFUy9jVWkweml1Q3RWT2JNUUJ0dGMreExa?=
 =?utf-8?B?bUtyTGtwUDFPb1Z1TW80RzR5VDB1ZmM2MmRNL1dkZTVDSVcwUWpkL2VJYi9k?=
 =?utf-8?B?aHNXL3ErVFV4bWVKb2w3RWNWd1JrV0c0eEhIT0dYeklEcExrTUJZeVdTaHZp?=
 =?utf-8?B?V1dEeDhaenJmdDFsdnBSSVNZQUxsSzJ1dWI3Qys4OWEvdUZjRHVDNFd3SnJz?=
 =?utf-8?B?KzQzcEJQQ2pTUnJRWE5EMFlUbkdJT00wVTFVVlpvT2RMMmtBVGxlTC9kenc5?=
 =?utf-8?B?Ukk0M0x2RkE4RVh2WE82bTRpcncvWVJlUVk2MnorMEE2b2wzbnluYlZ1RXM5?=
 =?utf-8?B?N2tnZTdhb0Izb2I5ODZqc1VHanh3eFphdy96NmpxZzFZUGpJS3d5b3RPNXN3?=
 =?utf-8?B?ME5RQ3ZvK0ljTnZYSEtuclFzcXEzMmR5RFNlK015eEZoQzlLVWgySXNYN1Ba?=
 =?utf-8?B?RTZKcFc3T3RoM2JQQytHS0NtYkJPcTFSNG42YURTQ2tZWTcrZFRyYW9vUWQ0?=
 =?utf-8?B?MHJwajd5cVNyUXdMRXNoLzArd0JzdVZMTXNtMkhXZXFwZWpJbk9IUlJPWlZv?=
 =?utf-8?B?N0FyNzJZR05WNHFRRi9rbXF3VUx3RzhvdkVvNDUwYXNaR09zcGRtMmVJdERQ?=
 =?utf-8?B?SkptWkhLdmxHM2JhVjQwajJyTUR1NklKSlhlOGd3b2VUSEk0MjFzMy9jeW0v?=
 =?utf-8?B?aXVqTFFVN0NVUWcxRjZaWnZhY2pNOUFLclJ5SGdjbmRmL2ZBUHRaWEVMQUt6?=
 =?utf-8?B?ejZROWY1Y1pPVm9jL3NJU3VwOVMzcjh4VUdmNWExVWNoV0t3M0IveVZEYTJD?=
 =?utf-8?B?YWJ5V2tkeGh6OUFBSTBxV21nYkozem5OdGxLSU95VUhwL2pZL1V1bHF3NXV6?=
 =?utf-8?B?UHEzVWwzOUI5bGU4dTgwMkdMS1ludmxGQkZ6YzRSZDZxVW9lV0svRlVEbjJk?=
 =?utf-8?B?K2htbHA5TlFyZGUrdEdSclU2TDZUNWM3b1g0U2trRzF3cXFvVG80YzIwcDVt?=
 =?utf-8?B?enZ6MEZYaklnSW5EakVCanQvUTg5T1JQcWJyWExyMThkSm5wS0ZQR1NWdE1v?=
 =?utf-8?B?SXpRN1VyZUd5WWY1V0tQRHZJZ1pqSUhaSFM3QTZNWHliQ05ScU93Y2p2S2tF?=
 =?utf-8?B?VkN3SGxzWUhqTG5FbXZ4Q28vYmltbVBocE9ONmJSL2xGdENBUFo3RFpLWXRk?=
 =?utf-8?B?QzE0ejgvd0dManUwQllLSnVTUm5ReC81RjRwaWRiQ3ZQS1FhdEd4UjEvRGt3?=
 =?utf-8?B?c1gvanRidEtUL3ZaaDBZdHBMOTN0ZFAwcTZtSDJhSnA0a0F6QVZuOVhsaGxO?=
 =?utf-8?B?MVQvUFdtaVpvSVFIamxxWkpLamRCMWFFYzNpdFoyYzRvWkMwVjJkcTFudVhG?=
 =?utf-8?B?NHh3MkZaNzlpNlViYjMwcjgyU2pHekx5N1RWSVlVVDNHLzlhbUR2eUZEUzRJ?=
 =?utf-8?B?M3h1MStnT3FESmJrS3lyVG9HUWx5TmhBckZBa3dDbmpKU0U3TnRBanRISTJC?=
 =?utf-8?B?ZmFRQWZrMHJrVmxsMnYwZ2VvYWk5dG5YOEFtdlQ0Y0tjWWlTTmZOTWtVSzJx?=
 =?utf-8?B?OW9DVHA0RVdJUFBOeldNTTBNSVJUa3RHZEZ5NFFJK0oxK1c5T2htWlJ4S3Q2?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5d42b2-e9e1-4ec3-b735-08daef30b7d3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:22:54.9639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR8X4mp2B/Bh0pLNVnJusGlSMetKEGOKZ/6be+3OHKxnUfl9PS+qymOeCG6Z/JAT4mWw+EuARUquOMhNKxuOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6998
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 15:23:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10323

On 05.01.23 16:02, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Security image creation imposes a rule to have strong password in user
> accounts and that should not affect the normal image user account
> settings, so overwriting user account settings in security kas file as
> required for security image.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/security.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index 4e74a9c..c385a62 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -12,3 +12,9 @@ header:
>    version: 12
>  
>  target: cip-core-image-security
> +
> +local_conf_header:
> +  root_password: |
> +    USERS += "root"
> +    USER_root[password] = "Cipsecurity@123"
> +    USER_root[flags] = "clear-text-password"

Then I could apply Henning's patch after that again, I assume. Let's see...

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


