Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F8C77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 10:16:00 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.51])
 by mx.groups.io with SMTP id smtpd.web11.7772.1685182558208812671
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 03:15:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u7vvvOS7;
 spf=pass (domain: siemens.com, ip: 40.107.105.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx8MfxqeG4WeQeQGPJOsr2/NEqNav3tZBGQ/xLzDxjxfpcTBjmkNZLpJXi1gE0GmZsm6bHnKTwxiH/3oJ4EJ0pK4F0R3K3Ceo4Q2Ryq9vzCW+OvArmniixtxYQppX2zQxQNZeTcOwjheg/LT+itT2v8EFqlHDOZqks0g2vm42f1tgKns6Gy8gyAASYI+kXAVs0nXl/58oNT1q2bVSKp34JreempH3XClEBwBzb6AH1gbstsEolg3rxaYY03SWoNu/Y3qULrhOcEWnoNBg/2TUNee0Lzdf7WqznSHQKLK4ndzbCwCRPRo+xsLAriTdZb3p1vH4g9sHAFXndKqUNu7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j3tfjKBxceZ1fl1iHfnjymaLo8YObm/OL8WxCZKoMY=;
 b=NDpHRTSF6UI9vMB/z8wrHumBtqOqI83gi939JwUh5JFKUWRETdvtZR8qLHcxC/ZDrupuVTLhhy2a2ep5dQ50hawnWhiFyNkGt3ZhVr07vDWfR+zsy7Ma0zUFbJ8SOV1pVAjqEiQtp2TiLKTwQ6xBO1NhKFmTGt7RoHauV5zC91BJec4RuPFMiQmIUGaNLmCyu24MOupD71NlSh0WajVwXblf+vPhsYKoKwNr8tIYt+xhrXs9zA/hULyl5QvCt7xDYE9WcGo44+U6JtY5JqWthacv1BuWb7bU7jcIxJBsjlSkuICJIFELdFx9Hob6ewitM5EyGeKHPwuGARicSP71LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j3tfjKBxceZ1fl1iHfnjymaLo8YObm/OL8WxCZKoMY=;
 b=u7vvvOS7+owgVxWyvjQojFl+IkGr/u8WxWymnzhkkORa7BhEMT3w3gwv3HKxzI780vu/qWYyTsq11AQMTEWl/A06YSpccuh3V94dNXGsLmKLpbnqMz8vGk7/5VVt+9rgl/QRRTkSkzewzY5D8Wa8DI+BsELodvzuTRaSuRu3OhlnkoLzjha9IMMxjKY3IL75An972kMy05wdyHZSa98JJqb2LA3CamfqOmFXIA/3k3VPukFcqPafH++2dAiHi1TEAMloHTUkhfWLL6sDOEHf21tam/r76QRwBhDm1dRy0q0tcEQ1LSdXR3WX/g340Lg4EZleRQFGVxFNpqbZnQqEVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7935.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:470::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 10:15:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 10:15:55 +0000
Message-ID: <37a2f36f-9172-9360-b014-0ebc62f7725d@siemens.com>
Date: Sat, 27 May 2023 12:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] classes/swupdate: remove image_do_mounts
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230522101734.1700221-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230522101734.1700221-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: c347a8a4-ca53-4e5d-1a9e-08db5e9b5b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hQ1pvwwpqvDymgdpSissH0F7j0h7V3n2caj3Tm9Y8UI4D4PJeGf0yBdUDDp2/MvUBy2fkz9nngzN4P+j68RYwXcSZ5PHThW5tYLTgfF9VYiob3ccZ1PL0mQdjazayCwjGWaaHOQll7XcKy2DVcTXkIDHW3esVfTeTah2x5GyccXzzqJIpwjgjkjM4cdfNoSzbdlFKpC8j3faFzzoXsbKqTwUMBsBgx69lahXf5GUErphv9bmyVo9HnERTw0JZHVY5ch+KQtqMtSfV6lmHAslbNKlezpLqUKgrbw41KZgEouTfxM7GH4+2NxvMyomQEObp5EJUVd/tHgn308sCdEAJGFweqpQPaLqStuejVjYQthOe0tx6aQepG67sYzmPMIFaNCH581BYh07gj1HU6OT9VwPR8lpaCtwKzpWusr4Lt9mOToPwbFh2C8nuaGpmpDY+1x86JPXk04lG/Igh+864MExnoFh6mqLe3PkwZLt77bqYAVeITUcQ6bM+K9D5XOFUtjOLnCzA7zXk/yTu5m2DEYFCTiTfRvxNPdJb5rJZRZI8HPRfzdSshfljAt98BGCzeGMtn/mVN2X7F9dqay/gWGqhJS/N+IG80OW2HyD/QgCzYjDaPbeMAEbgzT15o3glQKgKzldMAZjNy4FqZF55Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(316002)(82960400001)(966005)(6666004)(38100700002)(6486002)(41300700001)(6512007)(478600001)(6506007)(53546011)(4744005)(44832011)(107886003)(31686004)(31696002)(186003)(2906002)(86362001)(8936002)(8676002)(4326008)(83380400001)(26005)(5660300002)(36756003)(66556008)(66946007)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFdEdkFRd251Q1VQOG9qbFpsajFldzROZFUwTXV2b3J4blNZWFRVSnBMYzcw?=
 =?utf-8?B?Zm8rODVXK1JuSy91QmxzYkFER3FYckYrSyswYjJNTTFuUVM0SVZDanJMbWdi?=
 =?utf-8?B?bUtrZU1QMjNzZ1hLbDh5Wi9naDVCZGdBYVNoMm5tcGFWQ3E0NWhVV1M1RTcx?=
 =?utf-8?B?QTJwMFk0RDNiRzJhNktoQ3pmd2c4eStZODhVZUoxeTd2bG52QUswNVc0OGF1?=
 =?utf-8?B?M3k3c0NqZFpwbXZ4ZisxRDc1eS9oVlhVUWM1d3pTTzRDY0JMY2Vpd0M1ajVw?=
 =?utf-8?B?MTNJckovQ3o5d2VvYjFSVDRIU2wydzNiTVJqcTI1M1NNZEhodnExSFFTU2tI?=
 =?utf-8?B?cjFqanZ2OXRsVUtHemJoK1FxZSt1S2w3K1NCMERlb3JQMWpsSS9yeDQyaDNV?=
 =?utf-8?B?VTNKYklNOVhwbjQzb28rZWpFM0dEb1hra0pmaVJoU1JSQTJuZGhNV0VNRHBo?=
 =?utf-8?B?d04ycTFjeEkyNU4rLzJXTXY5NXlWbTY3ZVY2VnFKRDdqNUV4TG5STTNaWG1J?=
 =?utf-8?B?OHFXelNLVFYvRWVwRlloSy9pclV0a1V6YU9KMlNRTVdCcFFBcEpmcXpZRDhJ?=
 =?utf-8?B?WUpzY0k3dXZRbEdQa2wzbmJkUFR2RkdSUDFKSWVldzJ4TVNUZjhSNEdOTnVt?=
 =?utf-8?B?Z2tpeWZ4ODBGWkpnZlR5azZWN2xJblY1cUJDdTU5L3AzN2JwY0cxR0pWU0E5?=
 =?utf-8?B?bXpDYVl2K3UvVFA0WDVsM2FEMS9sSnF6dTlMRHlmdXlMb3dNVk1jQ0hWWlh1?=
 =?utf-8?B?M1JWQWZ2cUpIMUtiYjZJYlZBbzBLOWJmUkRtdW96TktHdFV0V2k1SWZVMVhP?=
 =?utf-8?B?Wi9OaDlGbnlHN2hka1lmbDVQWE4ySG95OC9KdG4rMFJHb1NjUnVsSUFFRmxu?=
 =?utf-8?B?aEsyN3ZIUXpRemxLV2gyUng3dExIbWd5OUxxSTd2MWQvaFljM3pDa1MxNjJp?=
 =?utf-8?B?Mld2UTFVUG9XNFNBNUtwOTFqcWpadWdBVjFSY3hzb3BNamNnMGc1NDErMGRV?=
 =?utf-8?B?QkpWdUpDcllkNnZJM3h2cE5kM0JQZjNrb1JGQzNXODB4VzA5VWIyQndtbFJL?=
 =?utf-8?B?TkJuM2dGWXZaMUcxaUhCbnJ1UmwwdG1kSEhhRFpqbjdYNHFTOVNDWTVacXlz?=
 =?utf-8?B?UkRGRGVCRllJWUZLQmVEWm5uRUpnQk1wdWhCNzFHaUkvMmQvOU9HTFJZQ3U3?=
 =?utf-8?B?NmpTNU5hUmI1bTllaEozVUpWYmxOZk5lUGdBMGtqOFpCdzNUWE1UZ2hTMzcr?=
 =?utf-8?B?OU5KbEdZMDkyVmxCdGd3akNzcXR4QnhjMGhHNGs2T3FCeHRVcFA2dTFtUEFX?=
 =?utf-8?B?bTBQUjZhU0lWa1JNY2hzR2l0WGI3aTJUSXEvNmlJUXkzYThpanFYRjh1NUdr?=
 =?utf-8?B?cHFYSU14OHM4V1pONlpOTTRUZVltQndqVFVjamtFK3VKaGFQeVhxWlNZL2ts?=
 =?utf-8?B?a1F0NmN0S0NMWUh5UGxWbDlKKzlCMFdRNHJTeGNyaE9qTkcvVFhYV0lKS3lt?=
 =?utf-8?B?Q2paNzB3T0VhT0tzS2xOQWs2cmdyYjBJZVNRMHFIUms4RW9FNkZ3WDdjS1I5?=
 =?utf-8?B?Y3ZoV1VScjYxVE9BRmRZUXZmQWs4MHVQNGlwNHMyWjVuMnhmQnY2bmJLV2Z6?=
 =?utf-8?B?U3hKaVNDdnVBblBkM2tRQm85T2xtNlVsMFgzbkkrbzQxUGNpay94MHlBZFZp?=
 =?utf-8?B?QWN5OUtDeDBUNDd1SmdYZFdkNmpTcGZTc1ppYzRVL2M3QnBReVFuUStkblE1?=
 =?utf-8?B?LytiWmppeDFuM0JUcHhpQmtOL0FTdjl6OUtSMWFmMTZDZFlOdHN6U3ZUZWxO?=
 =?utf-8?B?Z3dzcEx2TEFDL1hyVEd6aWVDMHJVaXhPQjM0NmViSkk0QnNLOTlldGZrR0Z0?=
 =?utf-8?B?QVA4eC9IaUllSGRJZjYwRXVRVU9CelBoMUl3Umw3bExwM003b0xZMUdlaytM?=
 =?utf-8?B?REgwS2ZaRTFMeUt1MURlbERkcmZnbHZVYktRd3ZjUW1FcklBd0h2L1phQk9m?=
 =?utf-8?B?NE5xVWVleHdTYitFd0FPYVZEc00veE1WSHQ0ekZ0cTBwd2RGTHlpSDV6ZFBU?=
 =?utf-8?B?SCtCSWx4b3AzTHhrQnI0TGdlNktUdThnSTFXWGE5bXI4a3ZrNmlzZzFwRVEr?=
 =?utf-8?Q?+5rCKox9wy2N8olTuuoYI/bNP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c347a8a4-ca53-4e5d-1a9e-08db5e9b5b33
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 10:15:54.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/1DF0B4SozCWDMl9GgjJ42oPXJ/j2oZZLWhBh+2iVA6eTFNCZwHbW0chdzbLeeX7Ev0aqtyVP86UDi1EA7SNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11662

On 22.05.23 12:17, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> When we hookup the IMAGE_CMD:* for image generation,
> image_do_mounts is inserted automatically, hence remove the duplication
> here.
> 
> Ref: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  classes/swupdate.bbclass | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 9a4d509..9f34760 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -97,8 +97,6 @@ IMAGE_CMD:swu() {
>          fi
>      done
>  
> -    image_do_mounts
> -
>      # Prepare for signing
>      export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
>      if [ -n "$sign" ]; then

Good catch.

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


