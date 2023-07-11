Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7CEB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 16:09:47 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web10.118.1689091778600590867
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 09:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=czaAl9oE;
 spf=pass (domain: siemens.com, ip: 40.107.8.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THNbgzNLFG+DQCryB412yHRhO6wTk4tTXYQXbgW2iDyHLCqhlRG02qym4CK9KxOdIq2gHlPh2Lu/ijE7gq7fabkoyzGQpH95i1rftG5DPB6dgs0Mo/CTc7+/LHug49PfFkcD6B3U7zZUWvePl6Y362CRmA4Vag75rwIJr6GocNEQ2QAelhKUNQ2loqMLU8KIy09TfKKdQmqpoqGPiUqQa5yBzrKjV4x45u6sKAaCRjbzTxmto/zMlpEhH05JyDTdWNcEupq1skMA+mSdMA7193zVpb7OxiEEdi6Vpx//VW1qFrPabyUa2GoQHcXHGV5CMlvNTSezD4poa9poK2/zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlDQEU+HSS06FV0ZMWQ9steEm4oVGIjkiurJn/QPU9Q=;
 b=esahyzdmdR0elN18erWlY09CtssI0JcPGfHH7YmGe66yrkLMNURC8lwoXhh21tkzjn/saQQj8xE6qH8Fs+hApum88RU0hfn0nesqAXkKMR4sIBuKfDrPcd+dflQDaRne9mRzEkp+1DHN2H1sKghb+YSNuvUu1LXjconYbTLkMIKgR5H1rZW6wx0mXP2JUoQvZc8j8tqhR70htgYUof7rlXJe9o6lQzJnlIUDRvW/mDx+41wiy7dUtWpzjbMTF9qHT428lp4yNk6zuvYq4+Rm5u+2q0mCfsqmXDIBdKpPsL+OFnpe3JkjuUX2bXo2qa4VaSI++bb1Dm61y70oRr833g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlDQEU+HSS06FV0ZMWQ9steEm4oVGIjkiurJn/QPU9Q=;
 b=czaAl9oEeS+ojtacFbpZcRkzeu0JWc5S5MB48cZbJ3Q3Qdn4CE7LN6tc5sBfjbas8+qNGTkdyvamE3kByHhHTGPhvjAEKoZgtln1wWRN55TKjGBUDbawI0YirgTZf+O2EWFIvj7Uaana1c7Wxq/9vxg4BVHc5t8a2CFEESoHDHtwZGpm8yL779xxcNzsg8hsK1hjzIdU/FzpEulvRKZZOJ7cH5obeaMmlm+Cde+5IjwPcU3B5nBb7IsSqKHhbgiQBP0i8lUgvL6f0G4cPxJCusfbve6qZUF+aBmna0aSdTiNUoqLwOW97B3UQ8edsQb5om0ujYqY+nWPFYnSEwy9jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3772.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 16:09:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:09:35 +0000
Message-ID: <36842105-2853-624d-eec2-98e81108acd3@siemens.com>
Date: Tue, 11 Jul 2023 18:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core] Kconfig: Add additional features to security
 image
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3772:EE_
X-MS-Office365-Filtering-Correlation-Id: 027afb5f-783c-4962-5d15-08db82293864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/hHFawVv9lA7uUsA3SiazZcZ9sHotjBvnVCEeHcmaAqNZ3oSjMEiMBdiksykTIN1r4JNFbgNDYsv3RcimpSc9mynOO+XblA8X0EiqQx5MdUbaFXsp/ROe530hKq+rNeAa3YR6nwMqsUNpXYWFn63Fyk6b1zrfzN8+MW5S7ItG2L7mXOx/0Oc3hLn9Vq7Zv2iignhnBWZ7EEKAFqBD5xY4G3tjz6TnfHKoXhuVc5ovdUQ5y+w8o/svFEQrcSQh9nGCvYWP0xPevDiSREyKxsZhKKSLboI7ySvet16yendCe4tjS5wpcjsNCejVqKEpuK+ce+iN2RsX0m7HoiuGQ8ZuKsJ5/Raar4Pa9EHsAN0bu4S1QyoJZTfy/xfTjYPGk+dL+ZbztJZAGFqjvWiQIs3iV+qhIn40CtaxO777mJ3qwNY3cB/xLA2TrPfMo9YE1G/hNdH1BmBTuIVESr2UZ9AyPNGoV1yqN82uGE1lPFoxhky/VZTejfMO+i7HIOQnpdh/WxK/wgNhKeYCCuezxf7VA9mS3gFYTtr3w2lAYCCIj1xL9NIkLMdM1oCwD5+TjR7T6618x/IySt3G2648gzway9ljuHlT6/EVy493mTXAVsTeN/HT0wsXY0U/QK/DY0aZCVdL4rIx7OOlh1mMADxSg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(186003)(44832011)(41300700001)(26005)(5660300002)(6506007)(478600001)(8936002)(8676002)(53546011)(83380400001)(6666004)(82960400001)(66556008)(6486002)(15650500001)(2616005)(36756003)(4326008)(2906002)(66946007)(66476007)(31696002)(86362001)(31686004)(316002)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2NNT1FqK0dOQTBqRzlaVldsTjlXSjRoRVoydlpSVDZGL3ZRTXFaKzNoRnFo?=
 =?utf-8?B?Nis5ZnluL3M1U1dlc2JnU0RvVEp4U1pwWHloRXJIREFWaWZGQjVySnBGZVl3?=
 =?utf-8?B?d0IwaWV6bS8wR1BlQm5oUU9wQXM3aWVSYjcyY1VONzZJeEhlbnFsS1BhaGFq?=
 =?utf-8?B?cnhPSXN3ZUVqOExIVUg3RVRLN2RKSEVBUjJhaGtXNERSbmxsUTlkZ1JzOUJv?=
 =?utf-8?B?TDA1VDF2NE9vMVlnb1pJbGJEKzVNam1VOVZWb1VLTHBzbm9UanpUNjVyeXZI?=
 =?utf-8?B?dnZraFhiOW9JbUtsR2cvRGtXNW10L2xhSjBTOWJGNUdxSGpETDJ6TnRmM2Vx?=
 =?utf-8?B?UTRpVTJxbGxVN3ZtajhYdHQ5U3FrRWplU0s0TlVzRGpLQytrVGpYSWt5Q3Fo?=
 =?utf-8?B?MnJlR3o3eTg2aXk2eTJRc2IxMUMxcHVpRHF1bmNrYjMrb3MxLzVkOHBTdGR3?=
 =?utf-8?B?a0ZwbWN6Tmx6TWpzcnY1RG1zVjI5TGFNdERWRGM4OGJqdFVtd0RpdHZmbnhK?=
 =?utf-8?B?S2dZb0dWYkpqZnlxWm1ocHhtdWpSR3NQR1VxR1FvTUdmMmozenNOYlQzZmpi?=
 =?utf-8?B?NEhvbUdRVW5zaEwxV0FUWjBINUVxY1l6OERjRXo5ckZWemF4QUp4VzY5elQ2?=
 =?utf-8?B?eTNmVTVURENmc3h1V1BXbE40aVRQYUJtM0JqNXZ5ajVveHhqYjlVSlJ4bVRx?=
 =?utf-8?B?ZElMNytXT1ZNbUdWdmtoNU5ENWtUWFQ5cDVkQWVLcXdOenorOFV5QnQ0ZzdE?=
 =?utf-8?B?RlpxTFVIWk9iSXdIM0o3QmdmRjZXYjRKV3BteDFvVFRBZ04yVzJKMDM0Yitx?=
 =?utf-8?B?YXROMWFQSjFwdmg2dnExSTNZOGJRKzV2NWh5Q3RRRnVJMmdTOUFNOG43dmNL?=
 =?utf-8?B?YVJWQmF0eWo3aUE5N0FBSDJWODhDZG1yUzk3aHZxRzZ0cTlueGpJUzJ4WHVP?=
 =?utf-8?B?R1ZFdS8xWExURVlqT09aUlBJVi92b3djd2g2eTdVdW9JSFhzYzU0OTNYTFBK?=
 =?utf-8?B?WllPNWwrOExMT3FOUXpUamFRRDNtcFd6TkY4dVcrZU4rRWJjcFl4RnYxVVov?=
 =?utf-8?B?V2trSWdpN0F6aEdqSGUzSHo1a2xwU3AzQzhBd3RsWFMxT2NKTUFteEtqbGVq?=
 =?utf-8?B?OU0yQWRFMUN2UksyazBBMm1MQllQVDg2OW95SmUySjdkcUx3N0VXeFp5OERX?=
 =?utf-8?B?QnJUYmVGdWxxSmxYQU4zNFZFdUxoMlNYMnFTVWtrZFIzUGJaOW1BWGU5NFhw?=
 =?utf-8?B?RE1SdjduREpDY3FTTmdGbFRPUXJQdkd1clRTWkJFdHlzKys5THI4VERqMnZp?=
 =?utf-8?B?L1diOWcwdWtZazE1YlNmY3pERUVyWFBCNGN0U0JjdTFQRlFkdE9HYXFLa0VE?=
 =?utf-8?B?U0NmZmc1L0xNbmM2bjNQK0dBeit4K2hGK3F3MTFnVEhkeUZkcnBlVUlMdFdN?=
 =?utf-8?B?UUF2ZzZhRC9hZCtsYlppeGRycGp5L2RIeEUvbnd6bUV6emZXZHNLYkxaT2tI?=
 =?utf-8?B?bzFsVWF0VUVTVmQraklrNVBJUVNQZW5YVkM4cHowVEg5OUVSc0J6eWhubHdq?=
 =?utf-8?B?ajR1TnBhMlMxNFpjbk5XZmxmbkRNT1ZrMHFrSEpMeGlPRzZXK2R3S1ZIbFF6?=
 =?utf-8?B?TW1FbFBJQkY3VHJmMHlCOE4yemp0Z01LaGVlcFdiUGdqM2pqU285NlIycmI0?=
 =?utf-8?B?dENvejdKbXc2R3k2SHd3WkhCd0hyU2NoQ1RmZUdJamRtVmtzai9JN21teWRE?=
 =?utf-8?B?QVFPb09qMWQvSTVvZktvUld5emFhTW8zQW9lUm0rR2UwSmRjR3pZKzR6dFZG?=
 =?utf-8?B?bXRmdUt2MXo0ck9UeEtoY3lhWW9aRldPY2dLcEozcnhUSEVmODR1L0FYS01P?=
 =?utf-8?B?M1ZYMHpYRXd6WUFxUHVxTzMrU1E0eFdMSlNlODczd25HOG5LdFdobUV6WU5u?=
 =?utf-8?B?MW0rR3k1SEhZQkxPVU5jQTlKd3pJY042SVNmZ1JvWU50TVZkQUJnUkRRcWpx?=
 =?utf-8?B?eHhOQWdGMlg4VjZMVkd4dDB2NzBJemp4WDNyQi84K2VuUFMvZ1YveDJKM291?=
 =?utf-8?B?OVJwNWZHM0M0dENubmdWV2FJNjNwSWJ5MFJrbW9HTm50WlV2RnZqTW4wSndX?=
 =?utf-8?B?TFNHVU9WclV5Z0prc0cwN2xwQWJ4V1h1alprTDhVWDBJb29kSkNRUFdLY3ZS?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027afb5f-783c-4962-5d15-08db82293864
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:09:35.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nB7wiY4Nzla1jrxvhm2t3KbtPshQCE8jr0r6JNpZFCxRRQW2n41E4kaz1JgLM2uUrZTBkrs0TVqCLgHIsh+DTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 16:09:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12323

On 11.07.23 15:38, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> 
> From IEC certification perspective, a security image is needed which has the
> below features along with security customizations.
> 1. Data encryption (CR4.1)
> 2. Secure boot (EDR 3.14)
> 3. SWupdate (NDR 3.10)
> 
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 94e807a..a9c3425 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -171,6 +171,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
>  
>  config IMAGE_SECURITY
>  	bool "Security extensions"
> +	select IMAGE_DATA_ENCRYPTION
> +	help
> +	  This enables security customizations, data encryption, Secureboot and SWupdate, all in need for IEC certification perspective.
>  
>  config KAS_INCLUDE_SECURITY
>  	string

I rather think kas/opt/security.yml should include
kas/opt/encrypt-partitions.yml and any other kas option needed.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


