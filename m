Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B8EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 14:07:50 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.45])
 by mx.groups.io with SMTP id smtpd.web11.40419.1688998060196598823
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 07:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qblF4ic4;
 spf=pass (domain: siemens.com, ip: 40.107.7.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAOPayYn4GBZm1hDZ7ZrtGkpxNnmKxSiRv9Fa3Ii5u3hZNphFX0+mDh9cAac9gQO71m3sH6jL1cXbLERwBVDypLHm+eJtHdAi8urVyle67z6jtTUlTdnlCZ7l1saaL0p+b14Ot56t4wkHYvtVdGNi2FE/doFmu4k8YJ1RgiRpyJ564vcfhpDBXzvc8oJF4BtKN1PdB9m27O8GOoY0UEqvI5/1BFEQJ3mXvL3p7FM4hcfcOhRZOmKZMT96RuQy6CyDc2z8aU2SM8xZYcn5R9TPARgurNl0f6/8KNGCbq9UNoZlRbaFpCtd3M5FgVlwp9axYy5hbv2EzHoOQfzqMz7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OR2x6wrMBg9zQ+qtbRtFoK8YNYbQi5s5KHg1lejJMQ=;
 b=bn3qL319vOAgTP7I1oRzhHUeby9Mo+3heB97crweGE7jZWmA8pv8mpqE8a2Rex8TSfd1835V9McTocvMEaeSwVlGSk2Ya3bikwBcnZz408/NalnHPUVsjD9aqcMlGggFjrDEeet+PcCc5yQcHrOghIjVWZ4SOKmbYwYDQtQRIvktcDQ6wF4Q+8DhL3FZmrkZtsjFnRCTnPio5dFdLeVxmvpMzXRGWPE7FMgtYgLIq1GNEEkM4IuGzPByz5PnUt0nWFd/4/WdpCAd7ta6GOA4knfh1eOAPnU9OVuhqjarcDmUzymXj9S1k8LGeE2hOeJ2x6QpI5z71i3R68oCWJApeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OR2x6wrMBg9zQ+qtbRtFoK8YNYbQi5s5KHg1lejJMQ=;
 b=qblF4ic4EnIHJHerUn9DwCPzoeyp2UiSy+ptmNdbvH9elX8/P2hoDa1/xtc2ELp//TylPOIcxSI+BvV6IEpqiUzwwDXe4MvXtTre5PDcJgP16PTJXCtDKLsnxoCN2yTXc61Y1/1sif/A6AainVj8WDHjMR6jrg7AoSvfjnyZpMsdibFQqe0HGQjJx5iYPVH8Eds6lG3SEB4QVwO1NU0uA81e/Vb/GoQwAYjV0cgOgz1qhXPRfKKJboHRKKAiRxgI+jf5uLIMOL3XYaHA9EFZCjg1rEoZnN2CkFl2HHhUXI4fxiIWCmJpspMqXCRoYswZ4rXfQ8m3VXO1PUpODqgQXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7414.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:07:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:07:36 +0000
Message-ID: <41310c76-1b56-16b1-b092-1ada0a512ecd@siemens.com>
Date: Mon, 10 Jul 2023 16:07:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to
 latest one
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Arjunan, Srinu (DI SW CAS ES LI PBU RSOL)" <srinuvasan.a@siemens.com>,
 Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
 <1a507755-e6db-3ef1-ff0f-cf863de4e2af@siemens.com>
 <PUZPR06MB574771EFF5FD7AC1026120898830A@PUZPR06MB5747.apcprd06.prod.outlook.com>
 <e2f603cf-2c19-398c-c10e-5eb25e55f98e@siemens.com>
In-Reply-To: <e2f603cf-2c19-398c-c10e-5eb25e55f98e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0449.namprd03.prod.outlook.com
 (2603:10b6:610:10e::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: f30b4215-54fa-4dca-89d4-08db814f0389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ppE3hxXJWnM8c5KMFhbmREN9Z8Hv2NqdG+mNR+2IfCZLJUpi9U0LgRTpyOVvXXkAqqs436H1v37M4rRZ1FC1hXLZK+7U9icto0Bdx5scJ+MVeKNHg5TYR14ycKee7sMu9HVxjgm6D6GnflCHDl/tXrbsZ/eTCllpEWPuAMYN/3xoyAyYgA3vOHIn3Cz6Sx4cwZBfvpKmjz0lrlFvdC8u7OKP9WwMuQqVvekNcLWT3evpDYWRUX3Ahb45VbJKGjLuneyGJrKBOAYyWdccEE48423vxybwzGd1YP4Z0ArWhsscVwFZej4X4AbLt65Q4uLrjkwTJX025DPYMxExf1LGxPiOuKJGvFaEO6LA3DVUbzZvQUpGuTh17xkbUH0HIbgxUMlFAOyMe7SUs7JjsKK2ifxn02iriPdoHSbCtFMGqIG9zrXYQEuagkn4kjYoGP3clKV9jheEc0MOSBdExDaIEZRk2nLTzzrMgbkyMdyJhauQJpGqtkhpO7W9lFIoVK0y3fI/8xtHAc7aYnQXmKKxSdIU1PcLb3bXK0nH1aT/t3fnnO9JChFGnkHSGoGCweOPglvHeAvpzPwpk5tyZxnvJynIBcHKL95l7vp4F28YQRdRpw46Yvu4dAS+fi+b19UMcNBn3nBDqFJrmyEG0rPuQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(186003)(53546011)(26005)(6506007)(2616005)(6512007)(83380400001)(41300700001)(66476007)(2906002)(66556008)(316002)(44832011)(5660300002)(15650500001)(8936002)(8676002)(478600001)(66946007)(6486002)(6666004)(110136005)(36756003)(82960400001)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEtXTmRhY1owdGdnankzR2dmWVR0MVpVREp2SEU0ZkExNEF5Z0ErZTZDKzlG?=
 =?utf-8?B?TVBoaHZRbXdwbldENlhCSzRlNHFkWWJBVnlVK05NeWFEYmhzMUhmWVpGand3?=
 =?utf-8?B?eVQ5NjJwMlhCSkVaQUhNbmQ0cFdHcFVKeEFQY2ZHb2xZQlpDRGpMSUE0K1pH?=
 =?utf-8?B?TjZQQ0pMN2RyNndkVXlKUm9zUzV4bWd6Y003YzZqYXFXZG1SZWFYTkVSMTI3?=
 =?utf-8?B?dUxkS3pUNE1JT0lxZWlIZ3dQbjhtV0p2eWJKQ3pQZHR1WUI4Ylh4d3Y3ajlJ?=
 =?utf-8?B?QVJFY1lnMnRBZklXekdnN2lkbkg0UUJoZGtPTEtFY3JsUndNOTlTOXFsYURq?=
 =?utf-8?B?WDM3Vnd5YXhFaGVscFNBZisrU0pjek9DQTdmenBCazR1NURja0RaKzFkcy96?=
 =?utf-8?B?eHczckNnUE5FQUI3ZHdiSTlTNy93RW5iam14V1pJMmRXNzNuVTVSOG9hVlN6?=
 =?utf-8?B?VW9NWk1MRGxuei9uRmxMUTFtQTFMbE9GOUc5amd2VzV1M0p1dU01RHJ1WEl1?=
 =?utf-8?B?UkduQmlRRHJSUmUvMHJPbDg4dEZSSHFnOGVQS0ZqS09WNXJFYWNXUEwrWUtE?=
 =?utf-8?B?bHlFTy9xeGdraDJnbDA3RUxiakZxNDIvVkxMU1dpQzAycit3ZkRYMGtzUCtE?=
 =?utf-8?B?VDZKZmhGZkJZelBoelBvRDh2VUhNTkpEQ01GN3VHK3ZZeXlXSUlVNzhBRkNR?=
 =?utf-8?B?WFV5OWhVSE9LSkxvMHRNOGx0ZmlGaVhyNS9FTzJDbDR1RS9uNS9JSjFKRGpF?=
 =?utf-8?B?d0VPQjVrbDQrSGU5andqSFI3enBtbzZ0NHR4Z2hJSDVXNURRVnBzNnJuanh1?=
 =?utf-8?B?TEZnYW5rYzJDNmlGclF1WE91Y3daTVJ0NHVYWkNLemt0clNrdW40cXNPdmVw?=
 =?utf-8?B?ZUM5ZWdJd1pJeWtNdi9JQ1g3MC9DNW9NeHNMOGluTVRxM1Y1VGU3RVRabUxG?=
 =?utf-8?B?ZzFBVzEyWkRHUStlYXRtSU9CeDd4ZGRqZitzeWt5aCtHaEpxeFZRMnpod2Zu?=
 =?utf-8?B?MFhYbUFlcDdxUWV0a2I1dUh3QklpaHFQZTJUVHBZWkNKUklCR1piRWtNbjdF?=
 =?utf-8?B?N2FNNElpc2M1Umg4Ym85cUxPQlBLZTd3a3N1a3FSaWJhaWxUTTk3d1ZsbWtG?=
 =?utf-8?B?SGNPR2QxTVRnbkZLRGhCUSt4bERGaHFQR1YyK1hIN3JqdXBRK0FwMGdlUlN3?=
 =?utf-8?B?b3RFVFl5NDkwbVVxbWt1cDhHaWZMNVR2TkRaZUVYNG1iNEwxOWhIZWdYZUti?=
 =?utf-8?B?a3VxM0lRRHNVY0VoOUVaMDkzajNDQXNsOHp1d3lkcC9kOFZ6UXBMMnViR0JP?=
 =?utf-8?B?dHVuTlpoNW9sd01TNmc3dmlPMHZzQ0I0Z1pYcUx6RG92TDE2K2pJSHdIOEI1?=
 =?utf-8?B?RUJzc0ErZlNyRS9nb2pDQ3NML2s3T1NLYjFJaDJ2c1NZK3BCRzBTd242dHFH?=
 =?utf-8?B?NzR3R0JkNWovb2dVRmUxYmQvNGZZZEJsV0Z3RDNQbHR1NDkwZVBXQjVoK010?=
 =?utf-8?B?RzVBUmM5SzcySTBJZmd5Y1FRc2N1OFduVEVLN1YvWWN4QXpaL0UvaDJ0RG53?=
 =?utf-8?B?eWlSaXBYTXZlT3RHNDR2eXpuS1d2QVo1bGxxbDZyNVl0Wmw0aWxDSHFJL2wr?=
 =?utf-8?B?M3p4V1d6TUlUQ2FVdGc2SjFUMm8rZTh5U2NqSjVxUkt0OTlhVHQxMHZHanFX?=
 =?utf-8?B?Y0I4K3lwUm8yV2E4MktVcHk5cUU3WldxdUhaalZSclo1RWNUWS9NKy9PVDBo?=
 =?utf-8?B?NStXdkJaMWRwdVVXaXZsa3FrRGNNVk9DM1dhTFZoVEFhcysxTzR6Y3VieEN2?=
 =?utf-8?B?RFo2dVlrUElOTVZXb1Z1Wkx3RWt4K3grb0dDUi85UGZEKzgzU1p5T2crd0NJ?=
 =?utf-8?B?SHpJUGNkWVQzU2M0eFFTQW10azdQYVRCN3JKSWxHbkkwV014SVFzN3VvZ0dw?=
 =?utf-8?B?KzBwelJLLzRHeTZSekdPYS8xbzF4OHpWTEY5NEN0M2lGcENHeWprczZaTHdP?=
 =?utf-8?B?RXFtWnJWK1dyU0xFMG1TSjVCSkRCWkRNbEtKSnNIUDNibjdieVBGYkVRMmRp?=
 =?utf-8?B?RGd1SXlHTkNpR1lINHlmQ2JkUzdWcURSYWoxNld5eXhLKzc4amozYy9MczR0?=
 =?utf-8?B?eUg1TE55Qk9yN2psMUt5TFhqb2J2VE9oRzFndUsxR2dzazdnWXJhU2hqOUYr?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30b4215-54fa-4dca-89d4-08db814f0389
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:07:36.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDMuZCansh9eh3RlpYP+fMHEwd1TfL3SLAo7Lz1vlgdQvfbYutTHRrqsLyAGbC2p/RyCtcA64AKJOy7iy8LBqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 14:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12298

On 10.07.23 16:05, Jan Kiszka wrote:
> On 10.07.23 15:49, Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) wrote:
>> Yes, it is 1.5.5-3 for [bookworm, trixie, sid], however They added multi-arch support and release the new one.
>> I forwarded to you the email reg the discussion with Felix.
>>
> 
> Ok, thanks for the info. Merged to next.

... with some indention fixes.

Jan

> 
> Jan
> 
>> Many thanks,
>> Srinuvasan.A
>>
>> -----Original Message-----
>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com> 
>> Sent: 10 July 2023 19:10
>> To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>; cip-dev@lists.cip-project.org
>> Cc: Arjunan, Srinu (DI SW CAS ES LI PBU RSOL) <srinuvasan.a@siemens.com>
>> Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to latest one
>>
>> On 10.07.23 14:27, Srinuvasan Arjunan wrote:
>>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>>
>>> Update shelltab to latest one.
>>>
>>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>>> ---
>>>  ...001-Lower-requirements-on-setuptools.patch | 79 ++++++++++++++-----
>>>  recipes-python/shtab/files/rules              | 21 -----
>>>  recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------
>>>  recipes-python/shtab/python3-shtab_1.5.5-4.bb | 28 +++++++
>>>  4 files changed, 87 insertions(+), 77 deletions(-)  delete mode 
>>> 100755 recipes-python/shtab/files/rules  delete mode 100644 
>>> recipes-python/shtab/python3-shtab_1.4.2.bb
>>>  create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-4.bb
>>
>> Debian (even sid) is at 1.5.5-3 - what is 1.5.5-4, an upcoming update?
>>
>> Otherwise, nice update.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


