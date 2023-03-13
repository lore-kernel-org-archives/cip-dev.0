Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E764C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 08:08:33 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web11.14824.1678694908570094484
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 01:08:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JMZlbSYL;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niEYFfM/RSHCwWBBFef9r9dNdpKIwyLaMGt7yuvF1h+8NKy1K7ef7MQ320TZX4AMS2ogzs5F1ayc2PUYdpmCItqsAKNqLtU9HI3E9H2EnUmKC79ziDHel7ONYRZ/qsGlPwzo4btiebfnQ4e/F+htbhaFN90+z9Yf8Ylo6v0NSt1saggjTuON6Jb3tOYFLsK1w7jZZ+sRh5Jr+2UrKb7sU+hNCtE2nCW9WgS9zdeaHxwrOFzfzg+Q4kA6mS/QuMF1NzJ/sdeZ2Gut2lBTk/XLT0qD+h6Q6Xej8UKMyR6a4h0feY4Us2SRNo/gCnh1/Q4Dlu/0QoI9XjUoDpUjx/IzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3Fj9xusUEr/saTuEFt/IETh6BxqVgAOzr+vho+oB5Q=;
 b=kBonlvA3pxLxGKruOpC/5VlKOWWQFrfgJg9o6C1CrI7jjze9cVVPoZMZl7ojBYb6fM7xtvkPsrS0EANETOY3DP6JznqnbID8lEZiVybjeGY/8fFz01k7HWdi0y9kXzGnh9WaHLtelg2Ph8jnjoQs+QQvveL9tmnXj5KDGjfb2hamg17WFkzQnFytPqgq4FxjarMPXxXDNRBHQMahWJrpPJkwxxPuIS38ir65jkfAvDB7Ht7kTia7Ns0uAQ7B+QOjnL+yeWFw7w4F9xjEY6lCi4fH8MCZT+9HXVpHQWYkhmP4O4kQEJqiooBQWEimktA9Li1J2XI60qz4GvbPKWYgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3Fj9xusUEr/saTuEFt/IETh6BxqVgAOzr+vho+oB5Q=;
 b=JMZlbSYL5p5TcWc5EdUw4Sk8TzdymJ5oIXkAbQ8f/Yl0ZQCSj667+wzjQMToQxbtDCSb7SdFkdt8ojQBOwtpJ/60bLHdy5U9i/H1uw2VvPFUIzy05+kzb+WBKaEWT+/kvbv4xcium1dByWOmcygEiK4zhrewwcR4QszBKMa2Mca/m2acSRMkSCMAryobwxALa1pHUTtbLw35Bo4IKcKDHUgV2k49MooqE3P3BZOmaSYaa15OBu8ualSQteucxCMTniApf7LlIFqJyxUdJahN0R1nQaehLmCG8rXvC8AfM5DS2Ew9t1Ub51IBovLeObppYXkvZKs1oAJOEXlXsL/1Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:604::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 08:08:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 08:08:25 +0000
Message-ID: <e14ea36f-6126-f9ee-e994-c1fbbe79e1a0@siemens.com>
Date: Mon, 13 Mar 2023 09:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 2/7] KConfig: add option to
 encrypt data partitions
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230309102821.307140-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: f5686cbb-d3e6-463e-caeb-08db239a1eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q9LeItJQADyCHCEaaD4v/snAOR8oiBCKmqrZIUHdGpfqrvNrzVg4GjMlNsdohMfkoGl92aPFLlUhbIimMn91Dz/OGstcpEEB83nQo9ol/WXLJz7/dPzR3CFHGgiFEoLo+VNSBj0C7wheFWp3y1kjnhVGqA7eKlM1bPpABLA7LKEBIXKzUDo+7TN1Ir5kDPbn7UnK3X8RHd193Z/b2pp4rgSeLxcGSqOxAwV+U5UxI+mJoHqneVJkBrszeo7dADxpEsiazP7KN6q5ut73/9azlobjlDFM+QALG/ABXRco7aU6S1uhZsSxnk3O5iSL9HveQm0eX1lIieF6b73vhTrXbwRXAeki8wZ5HZQG4PTMO0H1UiBiVy5jUZOCzfCsS8lOgcISRnaXwXDuHQ8Emxqo340pdx61NC40mmT/AVFSjckEzcFSIL4kkHsjvQY4zPwJravWK2TGNA/euR6BCiQ/BEK8RMg1aAOgVim/BIPhNoDQApao+Slt4Hzw46rz36Fv2Rg9mgHakTLrAP1rUhIpTeIx9QZc93dX5ygvUKQTz06Lji929TK9BSDw+HuIWTsRHtrXYHWuhcJI2Lg7p4Yt+xFpWkINsWIf997YkqsmvoNjwooFLCYy8xheuIIcyu/gH5i7FPX3aC7hyLzzD0yEKKnrIEQRb/zA/V09kZfEPVmucCMtljTCdXmLvAwN+74wA7MB+mFqsV0WL+estGe5wz++FS1cPqYMTDVGP48u3zs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199018)(31686004)(5660300002)(8936002)(2906002)(44832011)(82960400001)(86362001)(31696002)(38100700002)(36756003)(41300700001)(478600001)(66476007)(8676002)(66946007)(66556008)(6486002)(6666004)(2616005)(316002)(83380400001)(6636002)(6512007)(186003)(6506007)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2pmWDhlK1NOUUhESHhJS0QzTTdxTlRlaEQ4V3FZeTd5cXVBMGJ6RnJFMGFZ?=
 =?utf-8?B?SzZtd2JHNlFCd1FNYVd3Nk5peEhLdlU1YVdXN1hSeFhhN3dnaHNxVHRWbW9n?=
 =?utf-8?B?VkhrbnZlRy90WTdxVHZUT0FoQzcvU005WHhzeW1oNGQ4Y0phRGRGSDJoL0NK?=
 =?utf-8?B?ZDBweVBqb2ZKWERXTk0zS3ZJZEwwejRiRzhWQ0t3L1AzeU9iWXZPSXljRlNS?=
 =?utf-8?B?S3VMSjkzanJIYUhjV3VLZ0tpU3RaMTBhZUcxVjc3QXN2WStPSmEzYXhXTXBS?=
 =?utf-8?B?OFRZSnovNlFZRGt5V0dvOXI2bis4cVdldEpqV09odnEraDM1TGNvL0Yyc3JY?=
 =?utf-8?B?bytVOGpETWE5dGdtSFIyY3JTb3ZmM0oyeXM2U25qdlUwanBqb2ZFME1qNUF4?=
 =?utf-8?B?TzcvWGJnN1M2dDc2N3d4WXkxL1JsSWJHYjBJYVFlSzh3cGpUVGpnMFBxWkFv?=
 =?utf-8?B?MmdieWNzMW8zUWJFVWMxUmNkZDRrTEJUU0Rvb2x1eStWN3FIV2FacUt6bzRj?=
 =?utf-8?B?QTR0cGJnYStLYVA2Qk0wRkxTMjBUamRpQlJ0anJab00zMUQ4QWI2RzVOZ09x?=
 =?utf-8?B?NVd0WXhEcVNiQ3RTQTdkSHhZZjV1WkVqV3lpd3Y0UVFVVjd0SUMvaVJkS2JP?=
 =?utf-8?B?Wi9ITjFzRzlKSVZtSUo2RkdZT0Z3M1o5U0Y4UEthcFlrZWMvTHlTdituVlVk?=
 =?utf-8?B?TUl4dE43V0VNK2MvZjZRTWlHMktMSTNkend6bk9xOXY4YnByVy9RZTFhUzYw?=
 =?utf-8?B?Qm5yRlhMdFRDc1ova1g3dTgrK1VySy94ek5NSDJsd2lpSElnR2tYdkE3WFds?=
 =?utf-8?B?bVZpUjVoa0sraWhZL0dUVUc2SWNSeG52NlBoRjJUdzZJSE5YSDlrVHRRYmhC?=
 =?utf-8?B?bGc3R0JIZWw5djcrNm9aWG0zdFZSU0Q2ZFN0SU5BL3FuVjBLR2wwSTNySlg0?=
 =?utf-8?B?cVY1TmZKWHpCN2F5RDlJTFFrRGhzSnFPOGsybzJ6TGlmSFVNVzVrdmp6N2Vl?=
 =?utf-8?B?T1NFcXI5U1pmWTNPU25SNXNIcnBaVldHd005akpqQkRuSnJvd0NBc1RtaDdm?=
 =?utf-8?B?YzgwcWprY0piVWdEY3ZDNDF3eElSak1ScncreHA0a2d2aWFXRmRsLzkvR2Ux?=
 =?utf-8?B?aWRyLytjaHVmTTBFYkJDa2ZEaVNRQWxiR1BsK1BMZGUySnNwTm0yd2JPc2d0?=
 =?utf-8?B?YlBWOTc0SzZlZWpCd0lLcVNRcFBFU2g3OWttMU4ra3VrdTRNSlhWY2Jod0lt?=
 =?utf-8?B?bzkvRVV2SmtGU1RWKzVUYVhiQWV3aHlLQVBvS294cHdzU2twUU1GRTdPMjQy?=
 =?utf-8?B?RnMyNkhpL0FkRFBxY0ZUYjFpRk1tQkU3RFk0OTV6OEY3TXVsRTIvR0FGalhj?=
 =?utf-8?B?L2dSNG1vMzlrUEthbThTVkF6eTNHai9aTXBVeGFCbVNiQzEzVWN6TDk0ZnMy?=
 =?utf-8?B?aTZjWWZSMlgxZzdqL1B4dENzNmNZQk0yY3hxTnRGMnFDU1ZZMjlBRE9mMXBC?=
 =?utf-8?B?emRDS0lLTUFTWm9waE1Scm5hSzBKL2lpTGxiZHBCWTlRcjNsTllvKzYxOGJZ?=
 =?utf-8?B?a0tqYjlQaUF2alowTndkUEhaV2NxWHdjanlzc3R5WU83eG05TUw0ZGNaK09n?=
 =?utf-8?B?dE1iVlQvcS95V2xWb29LT1BUY2QxUERPdTBGK2h0cU41akdlcXlqUlhwMzZD?=
 =?utf-8?B?SU5MVThKb0ZxclBQbnN0VnV5bkRrV1l6VXFpR0luYzQvSnlYdnhBelp5MnNT?=
 =?utf-8?B?eGdtTi9Vb3NRejRpNjRlMjZEanRISFpNcGcrdXRLZFpIb2NKK0wxdy8vbDE1?=
 =?utf-8?B?dm56RXVYbzZWcUVzVzZUZUlKQkNZWEk5SmlIT0RKLzhOTjhzbFZnd0x2eStU?=
 =?utf-8?B?RFo4ZUNHdmg4MkdFc3ZiOTZnU0g0bHYrYk95bFBsNE9KWm5kN0RnbmtYTDZE?=
 =?utf-8?B?TlQ2dWxRZ3RvK295bERZVEJEdTBqdGZscnN0WGpNNk44QW1OY1hDTCtqcUgz?=
 =?utf-8?B?RC9LL3hWeXNHYk5yNy8rdjJROEpOOWVrUWU0MkFScjB4cFd6eEtNVytZMGoz?=
 =?utf-8?B?cEtZRTdTZ01kQU9EckN3ckxhR2p6eWhRNHpwZFpxd2JuZ3RYeE56ZStjeGp4?=
 =?utf-8?B?ZVRVV01ObElzcEcwS0ZvU202bmd4ZWdhSXZQVlVNNHhyZ2pzR3hCRXNhL3l0?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5686cbb-d3e6-463e-caeb-08db239a1eb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 08:08:25.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eskEQ7sJlwfXrSrYdkMPwIHWygN2T75taA1e9pPLugPgEuzZUeOUu8/1Ce7i6vl2mbsQSrnAnlA33e1JDwucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7348
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 08:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10993

On 09.03.23 11:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 7d72094..cafb04c 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -193,4 +193,14 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>  	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  
> +config IMAGE_DATA_ENCRYPTION
> +	bool "Encrypt data partitions on first boot"
> +	depends on TARGET_QEMU_AMD64

This depends on IMAGE_SWUPDATE. Logically, it only makes sense in
combination with IMAGE_SECURE_BOOT, so I will add that as selection here.

As the TPM emulation is not hw-dependenent, I would like to add other
QEMU targets as well. But it seems we need to flip kernel configs there
as well first. So, this can come later.

Jan

> +	help
> +	  This enables LUKS encryption for the partitions /var and /home.
> +
> +config KAS_INCLUDE_DATA_ENCRYPTION
> +	string
> +	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
> +
>  endif

-- 
Siemens AG, Technology
Competence Center Embedded Linux


