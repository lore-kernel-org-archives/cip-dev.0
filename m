Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289CFC77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 10:15:30 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.72])
 by mx.groups.io with SMTP id smtpd.web11.7764.1685182521586012314
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 03:15:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hdhcRN4p;
 spf=pass (domain: siemens.com, ip: 40.107.105.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYQCgo2l8lB6FExL/xc9gLCjbdPZ/NE3B8zngelLP1i5QJhCb0xE5OABM2ib17EuFuuBP9cRhdywHV1V0EXLCAuIJ6XndSK3fo/bvwfCI4OOG4hopeVlGT2IwZryla8bA/kL+/+EdWHRiw5xBPclAad0SZRFjOILi6eerij6QXcY1PPYcv4bgbr5Nj/hQVn2j7fpA8MILVvvmAotG6664QQrgzxBkZXnFGwMAbwp87I5V6pnwHyYI7VEqPGhYqYKuwF+bXUeWgUe5qw+7PlBQ8tU3/z7zesxB6uk6HiPQaEM1yBYy8p1x+mNhM3vv6UOLe6+V9dKlnpw9QK6xfNjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BgoHDEy8XOA8Mpe/0H51BwWEg37939SiVQuE81wU3I=;
 b=hJfIMG9H3HNN9lBqF36WSUPy36kpsjMYSn1/7JrxTGs/L1gMQ4yivbW5VZaQNK/csqBPI3ZRPKHIf1bwsDwhEUpQMYgtNbJ9GYw+VNJzGAF7BaZPhDlx53NpAYJuENNo7gczExyAcIgmv6gFkmHVJ9o0Vq2cjD5gdul5Fcb/7zabf1vUmuL7FDpk9xZAIpu1ftvZHI6c6HegMtwlrKBfa/OS+lIjyGAiWHDzXs1h4hnvf07+iUWPH/ymAJKLimg6obzdj5zqcwLgXudftLjGhtuNbcdC7e//h8Lq4XIjXLNx0XkpkvYBHsfGXiNjI2qqahJJtEmL3jzYvCSXjjBkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BgoHDEy8XOA8Mpe/0H51BwWEg37939SiVQuE81wU3I=;
 b=hdhcRN4pV2LYAecQidrErAxwYlI5hQqgVRXyp/lLAuPl5SnayiN6B0ReDGVIdg4x+QWewobcgNVKFAcyOhjYfq38XWVyBWEj7k/u/jjExpftjByMqPAs7BBXqc4tu3WwBBtY/nqE1I4L/bLOMlpvl4AoYQArSqdI3Pve+YlglmsZ3AQUxyPEO6gzHrOuweVHah3nPLOVX+XgnBo0DKZv6914psCvTHf9WOPVCKWj82v6XTOQXMLxNCcXdfJeTsd11hwvpg0uzy4tANCLfw94Rot+sPgMpL7PqL+m5Ecjr/m7hUv1DJJMAc1J6yRDTi8IwWVtN1d9aolXeraeyFxpcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 10:15:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 10:15:18 +0000
Message-ID: <03d3ee7d-0725-f407-ecaa-9a9e78806bbf@siemens.com>
Date: Sat, 27 May 2023 12:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] image_uuid.bbclass: remove rootfs class
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230522091850.1699689-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230522091850.1699689-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: af261868-2c46-4b0c-10ab-08db5e9b452b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	anyW0jCIzUnDGplTQxCLd7lAWWRWiXq+p4uFGntsD4yP240rZh3Nm+3tEATVXiVNBMvUu5qBFmyf47uCdgzqoI6IvKEfzlohPAMbFawc64jO9m8UTiMor5LA+GY4brq9/T+Ri/u/8QKfzo1BZIIuH1hb8FdaUUJQuYesd3W1rEKDACogKFNdzJanZqLfl7abdmZoLwfxpka+9w4/K0L8cvKIwpRoYaIlqHfZZDON+XVm7v/xiHTsv/fv4c7YucDaq/ypciFbEzxVjORFc6ldF+Xy48dSeUGBudzt6P+BIfEO0xwQwVtPMLVtt4X6ZpUyU115GVFmYNnSLx+0TuzsMNGlZiJUlgNt2YE93P0cVaF+r6z3aMB2dLWw/HLfrCn4vqD0FR5WO1PNFji2JE2arvxooe6felmyOgacCVd1BnSdL/YRleyHcJaheh/32gotAUgqAN7Dh4pyBinc75LvZUKILIKMIDeTGzgosKosjkRXzOKizEmg1eBCJznyu0RWv7Ob3EcF1paj0fjtxaCMLtWS8WFUkkW1TC+Ukz5YQjjMz7O/knI5+Q9+IDqDvf/3h3yawQXbMGxk92/iGjOA7zfVXILYrS3kyueFJOEykvT+tL4j3DkvsZxSb/84/Z4BbBYzjIjT1+65o78mi8kSjA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(316002)(82960400001)(6666004)(38100700002)(6486002)(41300700001)(6512007)(478600001)(6506007)(53546011)(4744005)(44832011)(107886003)(31686004)(31696002)(186003)(2906002)(86362001)(8936002)(8676002)(4326008)(83380400001)(26005)(5660300002)(36756003)(66556008)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWhXL2hpMlZwRHhTYzdmRW1JZVBsNVJwZHZuQkR2eHlwbFEvZkZ6RFZOOTR0?=
 =?utf-8?B?WTBFb0pUR2dnaEQ0Rnp5aFFQdCs0cXdTQThzNG9tZmtwSnRyVXBPQktVcEdI?=
 =?utf-8?B?czkxS1UwVCs4dThHakM4cmpSK2dTQTNaYkxsMVJEblcxdmZGaG1VbkFaRG5z?=
 =?utf-8?B?WHg0QnJJeXc3c2lPdTNDR2NpOGhUWVBiemdCZ3k0RmFhUHNSaExMMC93d0NU?=
 =?utf-8?B?VUk1bEMvQmRwK1ViTkpsa3pkUFI2eGpDR2ZXMUp0Sy96alVtN05veWlUMjIx?=
 =?utf-8?B?djZNS2VITmVPZnFSNGJMMXRBL2NSSFlZQjM4NFVSaWloeVJNMDVoVmFReFY0?=
 =?utf-8?B?cUtZMHFkN2V1Z0locm9wZVd1Q1FSejRDeE1ydWFQekdWb3dDdTZPMFhSZ09y?=
 =?utf-8?B?MkFwR0lQS1JKWG5DQTVEUnVEMWtvdmNDWGJvb01YSDNOZGFMU29lZWFpOThM?=
 =?utf-8?B?czlHQ1BQdXBjSlBWb3E3L2psQ0oydzlMcjFOQ01HQWFMQlc1TDBOY2ZMSjZX?=
 =?utf-8?B?emppVnQrVDl1a1VEY3ZNY2hreG02WHpTU2F2U1J1b05aYWpDSXVaUE83NnFF?=
 =?utf-8?B?NGZZTTQycERqMGUvWUVRWkM1UkwzT3JpeU5yVmFlWCtCVkwvSU9CdTA3WFg2?=
 =?utf-8?B?N0NYSGhjYzZnWjhrdWVNWi9hTW5nMnlsY2x0YitTaFlmb2FqWnhNc08vV1A0?=
 =?utf-8?B?RmRaYnU3ZVBXdDd0bmtaRno4QVptblp1Z05TaFBCeDZFY0ZsS0p6MmFOUGxW?=
 =?utf-8?B?OGU5aHRnVzhNb3k1RFFGUHJPYmRPRkJCUEdCaURpdWtKb3UxdDlqVWlnMFY1?=
 =?utf-8?B?ZzRrblBDT1dSdy9yYzBOeFI3cE9kNGpIQVRHZ0J6VFFYOXpCdWhKak5pYnNr?=
 =?utf-8?B?TkFxQmlEcGpJUld2ei93OTBsZ0lUeTI0VXdyQ1dwdE9FTnREOVZjQjBLbW1I?=
 =?utf-8?B?YWk5QVY3V0txckxRZm5FVmJMY2FMNG0zOUhYTkV4SFlsVU9kcWZEd3lCVEZT?=
 =?utf-8?B?UnBLelFlSGZXcmhZS3hkcEFDK1REZ3hDTW9QTnVUdmp3VVRDWnlxZHE0eU83?=
 =?utf-8?B?U1FlaFJ6bEczeVN4L052cEN2ZFV0Vk5TZFh6aUNkL0FHTHBCc2NUTXZwSXMx?=
 =?utf-8?B?K29NdnltTzJyWnFWUFdRbnVLTHprbWdYTGh2VjMzWit2eDN3c1UzUGlUaWcv?=
 =?utf-8?B?Sk5WTUZYcEFxTEdDOC9BZC81QVMzd0xVb0U4d1JWL3ZwaEFXMG1yYnAvb0Np?=
 =?utf-8?B?ajlRYmdVK21IWjhHOGduMEZaVXNUUi9WOHlIaHI3SWttUEZXd1pMSmNZb3Br?=
 =?utf-8?B?SXZ0SUNTS0VYNnpTSTVDMHBKT0p4NEtiWGY1TStpdUdYekl5OTMxeVo0NkMw?=
 =?utf-8?B?RzdVaEtxVWVsT2FzRFdINXczcExsSXpuWGxrcll5NkVCUjBzUVV5eHR4MUdr?=
 =?utf-8?B?S1YvZ0o1aXhwbGMwM1dtNkZUN2hqVmM5dkZWdnlZdDdlbmFHQ01Ed2plMFFm?=
 =?utf-8?B?OWI1R3RGNnVQZ0dmdVRjOUE4Sm1keUsrVDNqajRLMnhteVh2NVpRYnpGWnFO?=
 =?utf-8?B?QWYzcUsrVUhVdzFVajRmQWx0OGR2ZHNZcWdCR1V0UE5XR3pMSDM0NGNLVHZP?=
 =?utf-8?B?dG5OeENiajdQUVBnbUF5eGsvNWZBQjkxVzdwemYzLytab1J4alVoQ3N4WElt?=
 =?utf-8?B?MkxpMjdKeUIybjE3dGc2anJmajBHSCtmYkxMNDZzcE82MFh1eW5lSGpLekNJ?=
 =?utf-8?B?M2NMZmpoK09VV3RwSWpTOGRmaHVNazZkcjJyK2VFOWhOSGRteWV4QW1DWGNp?=
 =?utf-8?B?clBaYXh4QjlzTVFjbG1EaHZ4dG1ENFg3dW9wM2grNS9FRFZZN2RFbVo5eHVP?=
 =?utf-8?B?RHRYWlNuNkJFVXdFMzUrTmdEdmk3ZEcybjNpelpCN3JLbmFjYlRHeDM0SUEw?=
 =?utf-8?B?S1pFb1hoK1JTUUNYTVFkKzRGZ09GeEh2dmNNRDNJM25ucldQVHdpam5nUkZy?=
 =?utf-8?B?OW1WcWdHc3ZXNEo4ZFp3bDlyeHhyM1doS0pNQlF4ZXNsSUJzbFdsMXRrZFN1?=
 =?utf-8?B?NFJTU0FsN00vRktUN2JGSHJvai9sSmMxV0dTS1NqNTlRVkdiVGw3N0N0UjJw?=
 =?utf-8?Q?ZGQeWNoGdQlLVqqL6s7//3wLU?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af261868-2c46-4b0c-10ab-08db5e9b452b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 10:15:18.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGC11uK+edyX6smRobFvlvycoezKprcuyuLj2LQ/mr2LGzUpDPmbXMq4YEnLoGoK68AkyKISash9CRfOengfYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 10:15:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11661

On 22.05.23 11:18, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> image class inheriting the rootfs, hence remove the duplication of
> inheritance.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes/image_uuid.bbclass | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 9ffe14d..fa68b2c 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2022
> +# Copyright (c) Siemens AG, 2020-2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -10,7 +10,6 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -inherit rootfs
>  inherit image
>  
>  # Generate the uuid from BB_TASKHASH to ensure a new

Nice cleanup, applied.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


