Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9E3EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 06:10:54 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.87])
 by mx.groups.io with SMTP id smtpd.web10.7048.1689833446730218613
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 23:10:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rzisC0MR;
 spf=pass (domain: siemens.com, ip: 40.107.6.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhvCWjmZq9qtXxi2hY0TKf24DqTFW31trO9FRrBOYhT04W4c7EgZzbOdjg7wIODgNxsiEAsl+kKg/BYLc/YM6kkawNPyed+oWPCi+juK40LyDIq9Vy/goAMR77wqE+VdYSw3or3/5RisvSgGU0l57z2DgI/LbKw3yKIILpfrsXX3dLItbkX1LMT5ROnIkCah9K9jzg/XXUDdUEgGb7Obb0vFnd61yDfYf4V7wJQgtXthVySOoB3Fd3jFUA7s5N+JLP/zc7P2DdroZyVghvdgXbUAUTvqMxT0mcjFgLm2xso2lfId8saCLz4bRD1/nc/7Bt/iTlw7Xuiu8Rh86//I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hJYrDM0zbaoBLwBx3VtZAJw0SesqoKLxarLpEzlNN4=;
 b=E5mAsJfcMNiFW6EMUWAFuUFk9jV0VubB2jzvfxVSIO8fmk2BbiJ+OFXAyMQ381qMEXdxlz0Ao2vNdUdc3Xl5fYJntaz8ETVquPg/dNaIE5H1yheJVK8vDy/IEUCkYlSj4s82pSXNo4+PBGNolL1xl3jDOy8TTKqE4DV/0Bps2iC49x6UylLdzqHhuYqxTRhrDieD9Yl7fvmy8yqlE1JV4/k5+4GdUDE75/krKrxNvRRAsAQ0ykqcyrmlKR8F1/BLaETkEOz1KUb14s3wIfUtgYQPKY8LRXvPn1pDLIImf6m1rOusI+iXLgN8tM1lYbA/qy/TjLNrBKa0rGPJYugCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hJYrDM0zbaoBLwBx3VtZAJw0SesqoKLxarLpEzlNN4=;
 b=rzisC0MRF9n5G0tF8mCUfpdBd3MqP/L6SlceodDOBgkVRnIWv9V99uhDXAncet5yKJZ4LYgXQ78SCafjxbNXPh2wYQbGKv4I2Z/fKJPipVlNVsV9VRVNB4yChjg/bgBKPgK2Skt+aQgTm457PGcJstGprHBLY1My5pMo+I43lPoeUmPjQjPKuKGbqs8PmhPWrNeY6zF7PSrzfZYiakCwmPAikn9ppr3s/i7PZykBnnu/h2RrMvC9vmMNRQF/G66XcjwDBSarMr6d6VXbTbKapHnKkYSSBSfdxLZrCM1kliTNBYaPTt5hmRgrfj/ctmQTNXlpf4D5mjN3reCayuKNrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 06:10:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 06:10:43 +0000
Message-ID: <f63504cb-a8b9-d4ca-f0ee-935b8d8d81a3@siemens.com>
Date: Thu, 20 Jul 2023 08:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1dd83f-cd24-4649-c0fb-08db88e80cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fYiP+cNWovRMSambgXdRWB92O4oxY0OsTSjEDCiBRv34RBabv1tPB2ReiFWU1u9iNUBzRE5zHJ4Dt/YSr6GC875WvwgZLUn635TOwIXkm4IMfqkqmPjlm1Q6brWUn6ERApNH5S0tCejbfYjj38IqaFqBgvwgrv+rpxkJyRrdGCxmE9k8dLBuXMhkp5tOF8yaLsYP65DkViDBVe2J3+67mYuh3RJmq66pVmZ1nG+cW9/5KOyR2ktBJXgkdb+uNn6ZBYBQ4uRHy/OE48DckV4r2UHEMqk3d90o+sDrRLt0Q2kyk0i/UK3pc6qLj7lieVDTUc2c6nrmc8bCY1Uq1ou4FXiH13HsgIG/jbUs2pc0MR7rG+HPTELI+JUs9maqg+kQQXpSdol39ZpuahVD9NkGEPTxz2c+Lu/ya/eSyX6ky2mxO2TqdTxf2Gwd/LPgmZZr2rCubqMXBqB+N0IDyTpoN5KA/8rhUIVy77oEtglVJlDSIqg6BaX7rmqCZe984K+WaB5FQlmgm5ueVMsxQYgKmKU8N59emwBCTOTFmOGh/G3jgtCAyw8udW22Rhl0DdxPOj1KgNZrsE+5Qhl/j5PZtQapOILz68ZdjoGQm7JDdXNM0i8wGOAVJZylWYmQ6io81+COE/3rCgTO3jqbNTieRQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(966005)(6512007)(6506007)(26005)(31696002)(38100700002)(36756003)(66946007)(44832011)(5660300002)(2906002)(4744005)(316002)(6916009)(8676002)(66556008)(66476007)(8936002)(41300700001)(86362001)(82960400001)(478600001)(83380400001)(6486002)(2616005)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q01RWVpPVlFDazM3VVdwOTR6Ykp6d3QzU01jOVl0SEV0SHBmY20xUXlHWUZF?=
 =?utf-8?B?SDF1UEJBZnhBeG1CMCtvbmRwcFllRU9qOUZaZlhGcE9rQ05HNjlQZjdtdWo0?=
 =?utf-8?B?YXhiR0QrbEFvYmlnTW8wd1ZON2RvSnNuK29MOXZtcCtZUktZTnkxbWw2cWxT?=
 =?utf-8?B?a3dBWVhCbmdVbnhPbnc1Mnc0SnFpTzh3S0hHV2xabXFxc1lwQ0FrVUVFUkJV?=
 =?utf-8?B?dWJ3ME9mMmxCalVXZGdDK2xhZ2Y5NHpIOTFic3NGLzYreG5sQnVKOFdQdDVV?=
 =?utf-8?B?N21RQ21taVd0NjRNNmh5TkZMU2k0L1BQZFZxaitZYnkyS3lhWUtETW1yYjhH?=
 =?utf-8?B?MndLUXhPL1RmVk11RWxTMWpQenVmMTFydjBQdEM1NzlTYkhrK2xrd2pINFQr?=
 =?utf-8?B?TVNxc1kzYkpBQ2pIMmpjUkQ5TnMrTlRqZW40UGxLRjNCWEhFWjhQTWFEWXgv?=
 =?utf-8?B?Y0RxdXJPTmFhTHBHRHdablY1Ym56U3VEajEyMFkwai82RzN4cURSeXp1WWdV?=
 =?utf-8?B?ZzNaVXR3S0JrRkludFhHV0wzb243ay9GanltenhWaTZqMFU5dGh1T3JyZ2tU?=
 =?utf-8?B?cm4xczBXbVhodkY3YzIveWJNQWU4bTdPY0lQaUVMT00zTm9wNHBlWXZUa29D?=
 =?utf-8?B?VEJFaHpCYjNEVmtVSnl0YVdqWFVvSDBKREQ0MHYrTkJhTHlUOVpITFJWOG5r?=
 =?utf-8?B?L2RyRDErZXpFbmU0T1pyMmg3cWlldkVnNzRmeE1yckJob01IdHVFUWRBSGVI?=
 =?utf-8?B?bmMyQXBjUjZrWlV6WXhEU2hURy8vYnFMWUpYcEx0SGMzaFljZmNzdXpBdTUx?=
 =?utf-8?B?NlVzSG04UkNwMjBHR3ZneDJBaVZabnpmYWdGQnpiMXczbDM2UzRBc3hMRzMy?=
 =?utf-8?B?a2NOakJSQjc0eHVMTmJLbU5CTUJjcHpNbEFReHNGdDMyZWJ0UmpUSnlzWnJM?=
 =?utf-8?B?QXh3ZE83bzFRZngrT1BlQkwybkFFSHovYmd1bm42RlUyS2o3d1JYQUdaZnZy?=
 =?utf-8?B?QWZuN0xFbm1ITWhWaDZaWXlrR095VEk5bDRqWFF5bDNzL3g3b1ZSZSs5VVVS?=
 =?utf-8?B?NUNTYmY5bXE5ZjZHVHlKM0x0SllsTVlaWFhRb2J1OThrWWVRYTJqOS83SEFM?=
 =?utf-8?B?K2hlU1c1Z1ZHY2NhdERNN1dyV3RvKzgwOTg3YXJaNmEyek1IT3piWVF0ZVJi?=
 =?utf-8?B?TWxDVVlrei9EV2daSkRQVllQQzZpYndYVzRwWTNPTW16ZVFiYjQ0SG40SXda?=
 =?utf-8?B?eDAva21Da3BxNDZZZWViTzlmdmRqME8vOUdOVlB5OExXN0JIeFh1Rmo3M3ZZ?=
 =?utf-8?B?ZWwyNTB6ZmJrSW9jRVB6TnhrcUdOdjVVdkdmSll5MXk3UForSlBoU001ZkxP?=
 =?utf-8?B?VThpYWFJaFpjV1dFY0hPSExKdXZoaFdvejcrTW1xdkZPbDdqZktrTHRVZDhU?=
 =?utf-8?B?YW5SMDdCUWR0MjFUdG4zL2duNTFOMGc1U3NkTGZZMmlZc2UxaWhDNy9IVUZ5?=
 =?utf-8?B?RzFUdG14UWhia3VQUzJPT3RKd2RzQTJ1SVRHSUVnc3V0aGN4OXVKdjNBT1da?=
 =?utf-8?B?OWdOL2xCMzhDNkFxZThJRkNQbkpha0NXaDRIbmRyNXROK04zdnB2MGk5bXZa?=
 =?utf-8?B?YjJuT2tCVkt3QmVDcnNwbDh3Y1BTa1ZqUWtleTgzNC9CWGRaQkR0eVpkdzcz?=
 =?utf-8?B?cEtnZVM2U05IZ0dSOFkyT0RuMUhRRzZxNVduZnE5REd3azdic3YzdUEwTEd5?=
 =?utf-8?B?Z2ZzVzVRVEIxcUU0ZTdnYjhiT2VNL2ZCVG93dTRFUnhaMXliakMyWnZDVjAz?=
 =?utf-8?B?NjB4SFg0OTM0TlJRMU0yaWRsby9MQW1qMkdFV2kwUE10NXBXRmN2MW5EZnZM?=
 =?utf-8?B?eWRjQUU5Z2MweHRva3FybnR0OE14S0VwWUs5WFhPTlp5YkFtd2llZEhwNmNo?=
 =?utf-8?B?ZDNqdXpBV0JDWFFrdWc4bk13OHhuZUxDNGNuMWdRYzVOL3lsLzljUFdtbHZX?=
 =?utf-8?B?L1BuR1d4WmtoMCtxN1RjQ2Z3a1JQS08zL1RCTUVRaS9IUVdURnpJR0lmYmVB?=
 =?utf-8?B?ay83Q0VhQjhZLzl1YXI0clNFT2U3VEVLa3AySkRSeERtejBQOWtKWDQzdTVy?=
 =?utf-8?Q?HnJ3QDxZEjgJfdlMEWa/huhzS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1dd83f-cd24-4649-c0fb-08db88e80cfe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 06:10:43.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG7KV6NgPixK16Y7pqgNCi5XSQf+iegqCh0FC3+ZzxCvN07XV3lU7rpLruL/c9iMYGnHeZeP5Iykv1RQezhObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 06:10:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12440

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=7&day=20&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/07/cip.2023-07-13-12.01.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - cross-check wiki updates
  - /me absent for the next two weeks
  - iTCO backports: stable or cip (two maintainers, two suggestions ;))?

Jan

