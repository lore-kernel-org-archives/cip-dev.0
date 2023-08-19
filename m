Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0386EE49A5
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 11:49:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.77])
 by mx.groups.io with SMTP id smtpd.web11.7708.1692445763471011730
 for <cip-dev@lists.cip-project.org>;
 Sat, 19 Aug 2023 04:49:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OSkR1+NL;
 spf=pass (domain: siemens.com, ip: 40.107.22.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZIiitdsaqRqHxx/KK1im2LyEjhRdIWAD840Oy1jcvli1fuZS5vz9ZxuAij5xHYQPmpE3xEltFJK2TfEhds8VkSmpMP5/GWcxXtlHD8AO8htlnegrMAoqWA2JNf6YX4u+Vgm0VFhC3RUm74cDja8V9kI+Z1of1JKl2QaLwOWduv6JVDFd8v1JAjhVGKL1K36r3VBQBV+IwLNkbcocc9DsLfk6Lp036bDulbm/r9AWzKGFbrJwMW9HBdgEMV69+HYzd9dtvzQBB3Z6YBwcPDDAhh3/U/qMF2BBakQe6BqYw9tkcajSj2heP3A4wp7k1J58kGeJL8R1nFdD2mQVTWLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7qKLhFxp2SFIOWw9Q2BMflqisteKZk2ZsR47Vntm/g=;
 b=AAfuiIwlDbu5BP6WgICjkWrHKJur6alrBrsBM5AXvXpVVVnbYlS/0DsoH3ZfRGpZ17IOzXagGThl6BtyU9i0gu9UcQ9OvtCHHdSvMQIxoArZCuTjHDR6SGklW4iKqEilrPcrNX34t56PWOEd+6qbJEpM5eUq1ovidaL2/dOgYVkTCHsC6FQzhFxn3RmsSCAPI1M9A48lRxYOb9HujJ4fzfebRGoj+k+Tg7eKeZjotoIrQJ5vCFaskxpmJb2y05ryR9BGfjIjc6bjCOTFPxQuJgS7P0nnUIzmNSft9x9fGpCpT7qxX/TKvgvsSZqZOd03rmo96Ya7CfEbNtUdCx5qsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7qKLhFxp2SFIOWw9Q2BMflqisteKZk2ZsR47Vntm/g=;
 b=OSkR1+NLFpDAqEt8ZpOIBkZ4Ljml39EJPmNMgECMdD7bzxfFFy5/t5WTneplFP4DlvpTSWiNTP3DIe/RSfWZ1fG15036I6X+pNWyTJBDuhE5k5a+2cW3Cp6XvM3PGmQbQF32Zi1eoYDwdzRszRvqeQkrFEYEZe3K2sHstu4vaY51/+R2jhyh5YsxuNOuX5bKVlsHqwA73oilnmwfpFfyIoCABu2dW6UMPJayM5DtO5VNFpBstbn0XNdhCjliXjk4hH+ZwqmlFaREIbQSvfS8j5leGATKbJRcsD8/aYlvFEJwEhMXdPnlE0Prr91rvFpr7UxUwXSE/v2QEueH3CAFDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5519.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 11:49:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 11:49:20 +0000
Message-ID: <695be8e9-14a7-46a0-afc9-00aeb182d4cd@siemens.com>
Date: Sat, 19 Aug 2023 13:49:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with git.kernel.org snapshots in CI
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
In-Reply-To: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 653003ac-7510-473b-bd18-08dba0aa52e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZBL5u+wi4Cv/Ib6IsvCLjgC3BGC60zCPYp1sSPDGXbBmtvrIvvi8L+QWl23gCOJfGQ0NV7E/Hu4M66JMzWjHLr/CkHJuSbgNbgb2IvgCfLicivgvsd3O1VEekQ5hVidPWX4+G9uqQSw0Yf3XWp+jPDb/b1VrqT3Wo3p86uQq2/ifumBnIglNhV0yDANjaxttTBPy/o7TPg3pQxGhKPpSeAAtBerhsbFxh8OgkYWsDK0LNSou79lu030xEeJ2OuYFpLodzcfN2GhTxx2IIE1NFYMYIwq19/FFmQhJ78qL6mRveWjntTA12YAjFJRPe0attG9tjBxArejcqeGmtOr3a8xGawuDd4lB22XU9cQR5J/QxvYxzoLxjTaI2+AyzcAk9ID8SmyO8ekEfGk4URK5BWKd4rbNbTEBANn7Lkcn10Jo9pOPx8ha+c9JrEhTb9WnDXGBjvtZ4w6rPmYGkAwYyvU6ef/cFnkkjVXz4Q7jafiE49eduBXY1bcmrDgnhMlMbhFT4nAyI01YGAStdtx8/Lr/pTl7HGcuq+43+4Vw4EjD77Z6GwLVUvs3DdhABwIHVefiFv9p7NBGUGjwxZFCfATUtL0GDEkCaG/ncn7Aj2ctiolXfRtHyANt6U3FBSEJUR/vhKfymHZnKOCOxx2kOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2616005)(26005)(6512007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(83380400001)(41300700001)(316002)(8936002)(8676002)(66946007)(6916009)(66556008)(66476007)(2906002)(5660300002)(44832011)(4744005)(31686004)(6486002)(6506007)(53546011)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGhHZ1dSeUY0eFJoOHBKd0taYmNzWnZFVG1qa2Q3TnhHbWhMK3JTMm5CWHFq?=
 =?utf-8?B?MUc2UmhrdWRrMHpnRWI3WHR3emtVS3RkWWNGYVhnU2pYcTBhUnNCUm1SV1JI?=
 =?utf-8?B?MnJ6L0dKalROajdUZjBUTkdNK0ZHZGhpZlpzdmNhR1hqZW83djdOU1hhWDlz?=
 =?utf-8?B?SWRvQUtlVnV4WFBzeHdMaHJodGdCMUhYbzJnS1puTDNGNkhZekFkUk5VZUlt?=
 =?utf-8?B?dnhHTzVobUQ0WE94QnBYZmVjWkZPWTBiVGx5dTI5L2dIRzg1amtBVXA2MDQx?=
 =?utf-8?B?bmhKUGFDLzA1Y2ZLRmJrdE92MHRnVHJkd3hOWm90TFIwR2NoSHQ2OElSTVIy?=
 =?utf-8?B?RkU2azU5UGxtV2hHNXNveDFZSkZyN0d2UUxHenBMRkhlbjhCbTFmTy81Sncx?=
 =?utf-8?B?NVY4a1RIdUNpOVJlUlU5TWFablBvTmZHUDkzUWVYV3BtM2d2Z0pYZHJzNFBz?=
 =?utf-8?B?QUd3b3kxWVdnazl3anBoVTNMU29DZkhXdmJZZlZpakhnMUFrMmpVNnU3YlQx?=
 =?utf-8?B?WjZiZ1V2aWxMYU5wVGxzQk5RakQxT1JvTjVVSEdzeUY5UUpTUGlHa0JqR0pC?=
 =?utf-8?B?cG5rRmtoN08zeTVEQmd2eHc0NlBCVk1TZnNkRi9NZ0RGSGN2bHBUUmJLcW5r?=
 =?utf-8?B?VXJRNnY1S1huNktvUER4VkduZnA5b0RKcWk3UlphSXFVLzVtbnFqQm56dlZU?=
 =?utf-8?B?WjB3UE50cmZKekM3cWRmWjdlRm1oRUpDcFlJY3QvelVKeTJqWDNlYWpkZnhx?=
 =?utf-8?B?Q1ZXWXV4NDAzemtheWRjZE1VSCtqWUFMSXpWWnpaMHJGbTlReXJuREdzb0Nr?=
 =?utf-8?B?dWFzSU5ZdXA3UjRjcU5CRUU4eXlxWjhVUVhpb0xIZGtUSjQ5MWZkSWFvaGtN?=
 =?utf-8?B?UUFZVklHWTZEVUNWNnhOUVh2VWZtTVp3WGlXYTlGSVRUQ3BwTDhEZHFtL3N4?=
 =?utf-8?B?UFZQVVRRSFZlOTFvSEpVSDNnNWtYVE1EMG10QkRObEl4UTZyRU1ZdHpiKzVJ?=
 =?utf-8?B?aVdoUEprcXUzeDZnOUE5UDNGWklLTXprSzVKaCtNN2Z4ams3ZzFJRUYvVkxW?=
 =?utf-8?B?d1BCT1pYd041ZXRySGxUckNmTjY5c1dKTDZKbURXeHUvK2M4MlVhbGJQR1hi?=
 =?utf-8?B?T3l0MHJjNzR4QlNkWlZrZlROMVZyMGN0QUZIWHRZV1dmRmpSaGMvRkVRcHlz?=
 =?utf-8?B?TnlhM0dqZ3VCY0p0UHpaV01DWExna29iVzlWWHZMUDhMYmNzMXUyVzl2bWt5?=
 =?utf-8?B?WVNKMC9aSUh6SHlTekwreW5LOGlHMmxVU2pwY2phQ3pkOG1qK2djb2VEdTI2?=
 =?utf-8?B?SXppbGswQU5UTGYrYkl2SWErOUJ5ZXFhalFSZXVhRWJReXZncDNTaXc1M1NE?=
 =?utf-8?B?aTZ5Z1FoU2t3d0VLTjJ4a08vSkRadDV0T3oyUFFQZ1ZCbitoRkF5UndGYVIx?=
 =?utf-8?B?NnpST3Y4amIvQlZ4NFk1blAvWm56Zk1vUjh1K0pPS0hLSmhQazdtRDd0eEtJ?=
 =?utf-8?B?WENEUUJ0RXkxd2xsYmZuVDZQYmhocExVSUVYbm42SWVqdStEZ1h0REJKL3hn?=
 =?utf-8?B?VHZsdXJpMElab2hmKzdBa1lkcGJDMGJzMXZpUVhPSi93bHlqMU5GTEhTMDBw?=
 =?utf-8?B?TFJZcUUxcG5aMFRyaHpTZjkyMXpKMGFzMGVkZ2FlbWNIMUQ3OUtGaURwQ2Rx?=
 =?utf-8?B?Ry95Y2hibEZ0djBhbHowNWZ3ZUdZOFMvdDVLaUx5cnAwSnpFbXMyLzduSWF3?=
 =?utf-8?B?cnBITC9SaC9xMzRzdDRSYkFGRVVpYXhoWU5SeUNpMU9UZDhWMWdnb1ZCWTYy?=
 =?utf-8?B?Z1I4UDV3SU1scmtwUVg4N293L2Q1VVByS2FuYlVjMnNTWFJTSHJFYWpyL1hP?=
 =?utf-8?B?elA3LzdIcTZHS1ZNNTVPN3Y2TnY4YTJYUTdZYitSKzJ3bTZTN1U4djdjcVZ1?=
 =?utf-8?B?QlY4UlhuaWlLYWVjalJFZ0pHdGo2MVMxRGhJQzM1c21ZeERsbHhUc3QrbTh4?=
 =?utf-8?B?cUQzbWMxdDcvMUJGWWpRTUMwQnhycFFQRlBOR0dVTWNHMVdiTDJqV1IwMW14?=
 =?utf-8?B?ZmdOSTgvaHBxZnZDd3Q3K3N0SXBualdXKzlNMXhJcnFJNGJ0ZUpwSkxFbmNE?=
 =?utf-8?Q?dJ4TEuT/sjROhn0nzo5UZeA9j?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653003ac-7510-473b-bd18-08dba0aa52e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 11:49:20.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAop1JBW+/59bhmuH8de/uSOlAva7zy0IV9f6hvocQ2ZiV33V8pcSSzHPUNxJRLwM5GIlqhBsegvO8gze56a+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5519
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 19 Aug 2023 11:49:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12788

On 16.08.23 09:54, Jan Kiszka wrote:
> Hi all,
> 
> isar-cip-core jobs are frequently failing due to fetching issues of
> archive snapshots from git.kernel.org, see e.g.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4881160724
> 
> Retrying those generally resolves this again.
> 
> I think we tried gitlab as mirror in the past, but that also failed
> under CI load. Do we have any other alternatives? Would it make sense to
> make the tarballs as regular downloads somewhere available?

What would surely help is having a download area - maybe on kernel.org?
- for ready-to-fetch tarballs of our kernel releases. Would that be of
any value beyond our own CI? I suspect uncached downstream CI would also
benefit.

Download caching would obviously be another option.

Thoughts? Other ideas?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


