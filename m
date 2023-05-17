Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4139C77B7A
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 15:38:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web10.53476.1684337926530068777
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 08:38:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yJnFWuvH;
 spf=pass (domain: siemens.com, ip: 40.107.20.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fql2FKwyEQurYTLXPT31ypjocQehOiMogvByKj5HSbA2l4b9JSkgPdgkcvoq2aLf1DdfItPO0mOSY5eyh1V9j9J0aTdSeI8X85wmpoGlxga8ar4OiHG8YKFntGOKvEpB1y8zub65zrrP7jR5/iF+RyX6p+Jy1ficZ7c6xmFll8WZv/LUzn/w1CXlc635AqTUWb+j01Pg5UlEykVc8fkj8eMGTJbwEBk3pZXJLhzTObBfj/MhTapgXus9Jl642ayonnWOYbJGT+1mw+PUcqOq3KCURtHppjfGL+bwoApzZtEgL91WAhZ2BZUQSLbk/XaqKp2N455GaLI/hXuYNq1O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIes3QZeBsXkgRu+Msh+ak+nAXVQIuCfx4VhlX95ttk=;
 b=KwZ0rEjBqk/9bs96m5DjXGS2FPmBT5cGhx25JUBwFmt9cLmlR9dS/UT/K9P14LfhmYQmSXfovq2OZRNOplgFO6W6TZQc5mN9NnWDM3a1MqX/+IkZlp40lIo0IpgiYZH7pHtnsnkPlaN54+TJHtx7hF9oiliBOVFHTyvLeH/YU/gbdP+siEgmzYcs0YOfxnI4PuvOzHexRuHr4QtzqtBxV/P9nbY8kbo8gMjSemaUcWOGHRgqCNRfM8TW9lc9Rq2h/oYt7CqqqkF0ebREbz6T+T1xuRbZdfRBvbenJnyUHwtkMQdfNvkrbSOIVselj8ZvBcoD9W2yWlJNwvMkUcdVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIes3QZeBsXkgRu+Msh+ak+nAXVQIuCfx4VhlX95ttk=;
 b=yJnFWuvH3E69amfGMP0A/W34EKWalk9JzFaicau9N1SkaV5PMGUhxpZw9/XhX5FnzXLh37aT04eajE0vJeUCDQHzyqqlfRBF1OxmSvp500IjImSk8PMXPvJL8BjNWzAvjtG6m9wa1+jKSjAE8FCgBobA6klgVaB0023SUzUTazdRRMKVcullsyZuFPAKq8hf9p2Ma4m9z3O9itSD9BufjnOoKiRrXOmgXy6w9US1DeSkf4To5TT3QEZTNBIH1MyFjoOJh0ogbFQPGY0gRX6PL2yN4lBNbH+FxM46lCm9hoQ/gW2EInGRlnMErzq4OCuxCC4/z45zawtzaW4l9oQRBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 15:38:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 15:38:43 +0000
Message-ID: <87ba1522-983d-c43f-2ff1-941cdfe6043e@siemens.com>
Date: Wed, 17 May 2023 17:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] classes/image_uuid: Correct
 task_order
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230517115802.1416043-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230517115802.1416043-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: c1070391-a009-4544-efe4-08db56eccba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MbCQ1tPmlpOXS4aXdC+VAPwDbtYsb2tiZEEwsQXSL62vLL/mh5Ce0aU1sh0wGpuk9R+ZojoWd1KtqhnBYDAbhKp7ivGPEG3Kb807FUbOuAV4VpX8M5ER79hHlegCOpw8cFT7VvNBpNkUk5sb6WbKsrhSSd29idX32bx9LAQt62hrj/p2JwVJYl/xCWU/WXP5YjPpr26Tg/9ufeJSD/h59lOD1e4tTcZpKD6uaHSX2bvi2RdiVYLElYkcHxnoD6qldMbSK/yfOlHyaASrKA3v1CO1PlsAC/RUyRXmx2uaiCJm3ZNF+yIemvoCAFrk6Vmi9j/eqhm00QVB3TPv0UIjQG8Rrb39jzo0b2IYoWReVPA7iLzdNBJx8ZAn/H/yjVlssviLnR/XMnyria8V0k6ZeIpn3L64J7UL53NRb7/U3Fkx1LnvOEHDKXGCUPyhcprJM8FFbmDwjqqATjtcUFGC4N6eIwwQqKSq7hEwmF0WstV9kLBZJGD4r03P0H0HbppIKMd6EKzNCIJYD/boysdfPzb4wc8MwlKME/e7SOHBFgU47Eu8C5gdLK5pYiikvOqCRdf645+0dnDQqn4fx791AJ2Fa1eLKNd9y+x3ZPgotFouGVIj8ZBMC0NGjMyYUMb8C3V87K5VSKt8A1/9cMTnACf2oRrwqU+JyfGYPNrs6eKTeGSwginseutVtSLgJ36t
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(44832011)(8936002)(2906002)(66946007)(31686004)(8676002)(5660300002)(66556008)(66476007)(41300700001)(86362001)(2616005)(478600001)(82960400001)(6486002)(36756003)(6506007)(31696002)(53546011)(83380400001)(186003)(26005)(6512007)(38100700002)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2c1MUJSU2xwZ0Vqemlzbkw2NzBJUWhld05aRzRXeGhJMWFUK3FaNk5idVJy?=
 =?utf-8?B?dC9PcThlajF3VTZidzFORmluSWxHOGNuMTJvdGMwSk1yOUhMQ3BPV0RZL3N0?=
 =?utf-8?B?enBvTG1OUTVyWFBWR3QvM2pzZkJMMzJLMFM4RXhScHNuK29saG5FTGhORm9B?=
 =?utf-8?B?T29kTGtpMEN6QytOTnhVY1ZvZ3hsWDl0dGhwMlRYY1lIZE81L0x4RVBtcGIz?=
 =?utf-8?B?dndzYkJiU3k0a0FlMDRmL2RwK1dyem5iL1R0NWNEclh4WGoydi9YcnVtNElD?=
 =?utf-8?B?eEhQSDRuQTcvNER1aDd1bnIzRFdualBmZ3oyR0NUa1NJQTFnWW85Y2czL25E?=
 =?utf-8?B?VjdOSE13YXY4RE0ybmRLOWtGUmw4MjZaVlltVzlBV3hoMUIyVEJSUnB4VXh5?=
 =?utf-8?B?U2g5UXVVSWxvMWs1cUl6YUgxN2c4WmZ5V3V1Wk9DT1VaVFdkc1pQTDVyRHRr?=
 =?utf-8?B?NDFSOGlsWm55SklFelNaNjNrYzRvSkxMdlNMejdXYXNya2NQSVhIMTBvUTRN?=
 =?utf-8?B?c1FSTmE4THo0NEhGVTYwb2pmQ1ZKQWZ5bURVUStxRHg3SFVWTkhUOUI2MHMz?=
 =?utf-8?B?b2wzSFVHKzNGem1iMVJtUlVvNm9kMjUrRitSMDVGUExKZjRUSXFyODkyRVBO?=
 =?utf-8?B?RHNTK25JMDFwMnh3VjFxTk9Pdms4ZzBteXdJY3phYU91UGhYbHJuakplTldV?=
 =?utf-8?B?VHZQNmhMZjFUTVVybmtJcVN6dTk4RHdER2VueGFYMlJMdCtMVVFBK0o1QStB?=
 =?utf-8?B?VktzdU44K0dmc2JCb3ZFL3IyM09YR1l3VUhNK0daTDczWTNtdW1CU0wzMENO?=
 =?utf-8?B?ODBoTUtNTFZyalAvUGJFWUl4c0NXeTNpY3NCc0ZZL282WnVXUjRVNTdxcE1V?=
 =?utf-8?B?UStHVmRmV3ZCVHVJMXBLaHFacjRkaHZIMlc1ZnRQLys3ZUNJd04rSFJhRTdj?=
 =?utf-8?B?SFhGcCtXemxkekdoMElUcE9CbzZuTy9wMVozV0dVdks1T0VQYlFxR0tpUWU1?=
 =?utf-8?B?NVpoNXpudUwzOWdiKzNxQUt5aVVwM25MUkJvbnZTNlUwWE5aU00rRHhSMC9w?=
 =?utf-8?B?NndYVGxxK0NXekJnNFhBL3NvbjRTYk95WUEzTWx4eXBIZTNpWEZKbFQ5cjhZ?=
 =?utf-8?B?d0gxNVRzZk1wYnU3VzRXWVd4NVVObUtrK0dCN2RsQ0lERG1FTC9rdjQ3RTh6?=
 =?utf-8?B?VmYyL05rVk5ad2NSMkYzV1pycVZYbXIwZlczTCt1RExXZUtBVzUwczRadUdR?=
 =?utf-8?B?U2s5c09ic0lGQ3p3YmdtNng5L0RUTE5FQy9wclcvRi9Lc3ZXekJPOWw1TWFi?=
 =?utf-8?B?dHJxaDk5am96RWZreU1uVE00S1JTeGcxWXp1ck02MWZieklCcVNvN1dmNnl6?=
 =?utf-8?B?K1U4MWFLTU5mNzBjUVJDUmlxSTY2bUQ5ZElZWXd0dXZ1YjZYY3k2dkJRMkNX?=
 =?utf-8?B?ekVDWXRHeGY4cFBHVzZYblFkYklCZHl2V2hMN2JCQjlwSFVvVmlrTmd1VGY4?=
 =?utf-8?B?VDhFeUxHYjc1SEJHaHI5eWVYUnpvOEJldVFRUTByQXhvVWdSbytLUk1meUUv?=
 =?utf-8?B?aDRud2RuUDJ1Q0ljUWFZWVdsLzBmZysvUkdxN2ZaN0Fra3Q5eEVESWptaWlv?=
 =?utf-8?B?QXlqeDNmckJJd2dEa21PazNhdjRWRjJBNnZON2xTc29oQUpWTnlpUTh5TU1W?=
 =?utf-8?B?VUlpcTlnVW5rNVVEMnVkZ2daN0hyMFQ0T1FxSTNSekU1ZFRVTkhHSFJrVEdR?=
 =?utf-8?B?MEZMOTdvVFRNRDZvdStaNUwvcE1MVzVPdGdUdWlNS1lmSHUxVVd4T1V4NWY1?=
 =?utf-8?B?emVlcWlPQ1hPdmQzT09XeDBENU9KTGZDa3lsb1NoSlY0RXc4dnZIeGxBaXkr?=
 =?utf-8?B?eXc5QXUzQVZSbERraDZvSTNHUjkvVDNHM3ZWU3RzZjV4dDBOekxGMDQ4NGJ6?=
 =?utf-8?B?Q1l2Zk9JSjdqM3ZFV0hRekErbGM5SGZjR2NVd1YvTVdacllZSzRDdnRtK2dh?=
 =?utf-8?B?V0lSS1RRZHJRUkw4aXZ0aUZHRkJtRXAyTUp3aUhkcngwZ0xwekxjQU9MYkhM?=
 =?utf-8?B?aEQ1M09kOEZQeHpPRGJDSTloQVNqRGR0VkRUdmY1ZUxwdEpDWkpad1NLUUhp?=
 =?utf-8?B?MU1pZnIwaGxNUTczeU02SHhpOThyY3VDRHN2a0YwTEJVUFh1UGRhcjhBeXY1?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1070391-a009-4544-efe4-08db56eccba1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:38:43.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xClLw3NMPrRV1E3CvMpyZlHpoiuvZAGls7wuS0NkxGDjXtqUIwS8I/zKZHhtWJtWDvohD2UvvkNZq6ggP27/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6654
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 15:38:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11507

On 17.05.23 13:58, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The file sw-description is generated from a template and requires
> the TARGET_IMAGE_UUID. Therefore the image_uuid needs to be generated
> before the template is evaluated.

But that image_uuid is used by the swupdate class shoulld not really be
known by image_uuid. It's a problem of the user, I would say. Can't we
tighten the dependencies over there instead?

Jan

> 
> Reported-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/image_uuid.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
> index 9ffe14d..1578a88 100644
> --- a/classes/image_uuid.bbclass
> +++ b/classes/image_uuid.bbclass
> @@ -54,4 +54,4 @@ do_generate_image_uuid() {
>      echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" \
>          > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
>  }
> -addtask generate_image_uuid before do_rootfs_finalize after do_rootfs_postprocess
> +addtask generate_image_uuid before do_rootfs_finalize do_transform_template after do_rootfs_install

-- 
Siemens AG, Technology
Competence Center Embedded Linux


