Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E4C61DA4
	for <webhook@archiver.kernel.org>; Thu,  2 Feb 2023 07:24:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.9479.1675322664182112787
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 23:24:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qb2PtRYE;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajm5ugK+epuvOoC2PcaNo0WI7+mdp+c2+sHWjf0NwjGKWC4ukqDCWVC4H4kQ/yEDym2YdoZca+Qw8DWHIimw/m/aGNTrTphyYman7h0zd5mtnwSTRwHqu8Uaisv86bAgcY92dC/32z4xvtldDrGJJx7O7Itdn0WFSBj5gJeCey8/P9EfGowdabsEYzMbJvFwn/uMYiz1D41NRwYC/w6VmlBsHYy9cVHX76HkeodaeqIgOcTMfZB+tPEM2pA3ozGWHSiyRZYXhQSh21IHVxXOqZbWOmeXiRwzfUmtsHJDdxnYT7s3ozWEHldA8TjTFs7br4bB/07w18HOrFOAymmavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDCbyyN8BuvDb7KLdHd3Xm9qsm5wauMrBBl8YXO1ne8=;
 b=KOaRp+luZdsmtHEuSWVLHM0I+Hv2C1RV2c04vz0chcPpIkUoaTzvXMF0E/HRaGDo6NLMOGEwLwxYieft0KBT9tnGdPu436KkNyTejndB7Lx5LtmJD/zvWcSSfUVrfk0EI3zYC2n+PiaYXaLpbifhO6oL3pBAOAiGmaVB6ZfLeItw5FzpqKfyFAvQkdud+Ks5o90zHETP8Bg9WaW56wuTtMZ6Zn8XAQfjURmvMZxCHebEOWFFN+vGFRAxToL0OIy0bfpB5mMiWJP2e6kqJ2o3wsosQ1NvLCSduaArME+vMfqJ+ARXlcTNRcnWBoSfw0ACrx9jqP0KD3/dq6ihZCfZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDCbyyN8BuvDb7KLdHd3Xm9qsm5wauMrBBl8YXO1ne8=;
 b=qb2PtRYEqxpzIi8liObZO28de2P0+/Q2rb/63k5rLc4fXGVfZg5sqUdkji+SvktHCf5EQITpyC/KlIW4LTQGrAyhOouyllUE8wVw7u0SpkHPlolpt8LRuRXgxLVtd+oe0tapbB3bUDX/61Fdwb4t9n9ZcCmGKq2K7egmbyss46JBqch4SuDt6EIhMLF7wliCzrIzGbwCgpSvEh2r6nfwTNSayG+iaVKCoHMk8NhrrpevqiYfiHTGHy7cU8xJy73H9q4RLv5mgBTe20nZHvqipT5411vOYlaGkahpempUxENqSpAO+9l6DkH46rKEsXJO6HdWIND/hyKDmhRS5MMdYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6247.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:560::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:24:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Thu, 2 Feb 2023
 07:24:21 +0000
Message-ID: <214aa9df-28c4-0189-1cac-b438c715a341@siemens.com>
Date: Thu, 2 Feb 2023 08:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae774e2-b22e-4915-0a43-08db04ee80e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hXcsjTOl+jLxPEtjtHm36/2uF7m/VDZXhadPD/gfTPBrz/kp8zFTFp8gdQxQpnCE46cMWFplEBekqPiETI1eAY0BfCbducx3P7KrQYhI5S3vq+BS2U6uEbSMkrWamHcoPA7qA/KLUS3jO0qOvobFTs5ggw9438MinzseiysDPWU6kh35+fBPKIp7MAVX4MMaMWlJqNAxb6o76f8aalyWrhRoD817ao3Bnk7jNlYCQqvtOBnyr+zrSa5V8bfSMBdX2b6zx48BSnFgYn7NjVIYhAqHVe3vnwfKxZhNlsr/l0QsPhKyrs1COnjuhy/GKmtcEfS6i3tAM5QvrZJKpPAaMQGh0nj8sdJzn6SUvuTuJfQYfrjCfy8LRJLH+fnkZkuFDcajw9dk3ki9nXtGocqCvyphFJBYA6nglzqCVccl9bQd2l92hdxxV7XxgaYQiBHl1e1gQfTCAn6lxSQ4U+NODz1zJn70kheoCgD0I3jTi60pnx4K4pPQ/UC5lzEyiczmqb4Al4/k/8b0+j4sFnKfeljCx2TXiMXtZpiIgIuveoB26siTizlZvUySkEYauacXH51f39lGmYrcXdEUlo0Y833aAnI+RVnlxVvuHxBMmAMw8YZHXuXL+9YD0ATzQiN7dBo7jcLhgV8/sHvjoP3eAVXXanyNvxUY4DvH2pzthy6MrPgn/MrmE+2Ibln54EZ+wgIsMVVywSbYvO0E+AMbZ8OpMpuX+AWhgXTWjTMxrkUf5W0QzeViuEcBuw+xx7h5SvTXp4wMm6WU17U0+fOpXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(478600001)(6486002)(316002)(186003)(36756003)(26005)(6512007)(6506007)(966005)(6666004)(86362001)(5660300002)(2906002)(44832011)(66946007)(6916009)(66476007)(31696002)(66556008)(4744005)(8676002)(41300700001)(8936002)(83380400001)(2616005)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTdLclhjTk9QVzViRHp5cEdKckFHOFg5UjdYUFkvd29NRCttTjUzUXFMaWRP?=
 =?utf-8?B?L2NrL2pJY1J6Q01URTNBSzdDVm5IblB4eG9IRmhObXBDbnRDODd5SGdvSW51?=
 =?utf-8?B?Mk1vcUo0UmxVKzRGMjdJeU5SRVVKTnJEclArR1BPUXU1N0VBbG90R0k2UE44?=
 =?utf-8?B?bDFONmlCcmZTR2JPR0RYN1d6SnByQTFNVUhJenlXS3E2RXE1enV0RXpKcGgv?=
 =?utf-8?B?ME42OWN6YjNUZlpWcUVEL2U0VFovK3o1T1JTRUlZWVJhc2NVcFVSS0JsZFBX?=
 =?utf-8?B?Sy9nMlIvQXBnRnlZT3grZmRpUHhWTEJBcHIydW5NcTAzUHRPQVBsbFNaLzQ0?=
 =?utf-8?B?WDhyZW82b3VGY2Y3SURvYnZpVnZTSzJDUWdxWWNBY0dzMEY1bWFNc2VhMHgr?=
 =?utf-8?B?cS9EaklVSEVIb1RQUDVTdTJ1Y3loR3pIa3VzeGk2SVNZR3JoeGxGMlZsYXVt?=
 =?utf-8?B?aUh1K0k5YnhuYWJESDBJTVI4bm9BR0FyaWlvM0hTTjN2cEphbUI4MXBzRURy?=
 =?utf-8?B?aWJncmg2OW9lMERPWlZtQVpQdWhmbjUxbVRqbXQ0MkpuVERLSFNod2tuQjFY?=
 =?utf-8?B?dGt6L2JWY0w2WThmNmpuTXNHbFMvcTdaRTV5bzJGTWxLTE5PQ3RqcGZRWEZ2?=
 =?utf-8?B?eXlSNTFzdmg4cTBOdTFKV01FOEh5MGZuQXYyUDgzcXZxU2EzeklPZGxTVWE3?=
 =?utf-8?B?TXFzUVhSeDZlUkJidUMyTk1RcDNIc1VrdGxobnpRcTlxL3h1djRJaG8vVHJX?=
 =?utf-8?B?b1J6R1k3YkdTc2N0cXJBWW5pcThEdk50dk1ENzUvVzFyeFVBaEFXZ09UUkJN?=
 =?utf-8?B?L25naHQrY0FVZDhjeUQrek9LdS82MndXblhwUkNCbjRacXdGaCszN3ZuZno0?=
 =?utf-8?B?QUZxaFVpWlFVdm9UUFNLa0RWNnBURlR4emw2TStvakRiRitvMDUvVGdXYzZC?=
 =?utf-8?B?YzlHdy8ydFVzajU4Q1VhNVJxRlpqZHRyRTFkTnhXSW5KVzRDaEZnR2ttYnVT?=
 =?utf-8?B?UE0xQUhYaHpkbUpvVUtWbk5HVFlIV1dhOHRvZ1V3dTRtRGwzQTFrSytXbHYw?=
 =?utf-8?B?allCbTNIT0hZaHp6V0syM0ViZ0pveXRaVkorcTN1UFQ4cU9Pa0lnN2pwVGor?=
 =?utf-8?B?U3lCb3ZFeGYrK2dYZnJJTkN3VjBnQnhMNWF4TkFuMkRndUtYL29NaWEwVFZJ?=
 =?utf-8?B?MkV0RVdORTlRUWxsMmI0ZS83K05LSGVCQ3FLd0V1UFJpN1c3S0l2aEI2Tzlm?=
 =?utf-8?B?dWkySTV5M3oxRE0zR3ZJTmdQOWNKVnlzVUpOZS9kbHRrcWV6U3NjTEhvMEhr?=
 =?utf-8?B?c1FJVUdEZzJKRXRwMjZReVpPVkJlRlUxSjJ6d0l2Y1JFeHU1dzFySWF6QmhD?=
 =?utf-8?B?YkI2aVJUN0o1N1FteE8rWkpnSmludlY3cjBQbk00ZVNHTmRxa3hKV2JOUEF4?=
 =?utf-8?B?Tjh6V2JuMDlYRnZKckFueWlyL3hDMUVKTTRWUHlYK1g1VGxpc0lZd1o2RFRZ?=
 =?utf-8?B?d2N1WU9reTVOeXMzSHRCc2wwZk9xdXRyUU0rTkJvOVhub203cTlqQlBuMFRl?=
 =?utf-8?B?eEFmZHMxWU1LWXdjSDZuVzAyc05jc1dyanZjbExUSXQvZGs0YVBOcHprenV1?=
 =?utf-8?B?QXZoYk9jNE82VWdNZWdjSjJsVXFrUUgrWTY0LzV1Y2FCQnp4YkJLWGt1SnJU?=
 =?utf-8?B?ODdYNklsZVZOcnE2LzcwdUlCcnhLOUt0RXFNd2Zwa1VVTUNxcGpwYnVUVmk5?=
 =?utf-8?B?cUNoeTJxUFV2OThpWDcxSC9WMUY1WUR1ZGpiYmlKcmdKdWN3QTRKT21GQ203?=
 =?utf-8?B?d004c1RUbDk3QkN6QzduMGY1YTliaTZ6MEdMeGd0VkZXTlNQMjFpK2kyZEVO?=
 =?utf-8?B?cm8rbnpEUFYxRU11RHB6bHIyVjYwYjBiYzBLUnpaOFhCdzV0cUFXQytuZE5Y?=
 =?utf-8?B?ZHIvMUhYdDNxckdJNmFkRjRnbmd3aEVFcVhsMzkzZy8vUUdubGRuVGY3VFRt?=
 =?utf-8?B?UWJjU00rM1BmU1NWVzZFVzVEd0Jkc3l1eGdMS1pvajdVMU53TjQ4alBuazVC?=
 =?utf-8?B?SUJHQkhKVEx3NnNxWkI0OXVuRlRpOUF5UzVyd1IvTlJtaTVqcENaQnRjMnJZ?=
 =?utf-8?B?NDdPZlRFODNuNkc3VTBHdGZjcHJaeGFxVVU2aWR0TG9CNk12Rk90ZFdsQVMx?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae774e2-b22e-4915-0a43-08db04ee80e1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:24:21.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JO1GGliBUG2RRlvitzmrjpQdb5R8CL9v/E1AeYVUMmnQyj+57MPgboCs81LJRIElmMPyY8VuPCFTjkiwA39i2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6247
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Feb 2023 07:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10565

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=2&day=2&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/01/cip.2023-01-26-13.02.log.html

* Action items
  - enable more stable trees for testing (patersonc)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
  - status 6.1 LTS testing call of Greg
* AOB

Jan

