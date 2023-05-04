Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D8C77B78
	for <webhook@archiver.kernel.org>; Thu,  4 May 2023 06:49:25 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.44])
 by mx.groups.io with SMTP id smtpd.web10.43921.1683182959390325670
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 May 2023 23:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A8EUHoJf;
 spf=pass (domain: siemens.com, ip: 40.107.13.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqYCHIJSxibDLNF2i3eaq6codUOrW5H7Wg2UUdZCL72ydCvD8VIomkw10kUp4UksAWtBfueaU8AjweSUSC7ADpgZ0YXuaald1afW7sVQIjg9XuJqudBCs50xdr1LZYKB9w+YkS5TJw0KHHF5e72McoSEq5LL735CfsBMTQAKr+Bvc0op7bg8WMPFZQHV1TGAWV5mSJVLU+yHgknRwtesEJGdUaQ8YYOnHAhTTuOgKOyKQvOtZNPqhohR1TVwG6UtbrX/ppyqXqvoUBf1bc936eHImdpOOGjU/CmDJXBriVmcfDCYP7RWiCTOmvLyWlUhkWnuq+TWCa2dLJO9OCBAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2CrxRgWcKDwjtVtxyy/9gOT6knoXP41XbfMD0VXFS8=;
 b=R/DCuLqVKRJi4//ZXGXr6pz8dAXMCr81Z2A4STFZ9MkEK9zUpTMFMlJIKTwvMvYE6lMuXxzWL+cQzdn6ksbjVtWThbOXOkVcg4rpUNBVwuLMPgY7lnoTgxuydBSM9MptlOKDslG3LUZkFkEg2I62tjrgiaqiFHDrtKQMMukqrF45vpTjqSWVySZp7N1JGvYJHBY66+O1lh1TgzG1k7iTpRvFMsKTLMtNE0bdx5+Bi38WCUGsWii5/BKBozfNqJA3pWEyrqkLcGu33WNpUFEBUqbu9zP0RLOt19c6DYHsniPVwng2DsP3n/WW7p6W5RDeJNgTiaTewGekXlEdpY6KsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2CrxRgWcKDwjtVtxyy/9gOT6knoXP41XbfMD0VXFS8=;
 b=A8EUHoJfAfpcZvbZfvjqX36M8/lrJuF6tPwD9h94KvUsx+upM2/AETRhgwhrBuZIHcFHqjgDir9GirbvfCd3FujHMRFYvL0OgB49KzTb2n95aidP/6pLtdjnMDZdxJRB9o3vfUuIwFQMsMrtCpmK9nbo1g1psmoCDeX0AhPSG52Q1fYjnyQSagR8ykhuhqBooZTujz1oMETLVteo2UX3ItiZyFA7C16saoXL2ngAs4u4FYjXPklIReGM8vQJq1SCrOFBu97cOhlpqR5G8iM44aF8oztr9qdMJds6UGCj1Mlj0lvtJTp/Uo/+e8NTbmZPd8ahSzEgxeHX4UITONSQUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Thu, 4 May
 2023 06:49:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.036; Thu, 4 May 2023
 06:49:16 +0000
Message-ID: <6ab481ca-108a-17e6-7e96-08245f603de0@siemens.com>
Date: Thu, 4 May 2023 08:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ce2f84-feb6-4c00-e641-08db4c6bad8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I3sv8iuQEjWuKiHHVotXwx5t/1eiwf/k1sssuydPAv6MFwNJG9LmZfOg80H2XLAwSdF6P3avhjwP9/cnaVc1w2OkevPeIwUPMAxcu8CaAPsADv918pHiQLK29hSU1Q21J9NvsqXQ7Y+v8cBTe3eoFojqswQf8E97jfSKRbhAAHynIhQI5lTFvDVWuuMgfy5wsuuMq6jMV25Jn32NitKJHmzn3NKhGDmyFVdDJFGRYI2AQsynWjAWXHnJ4hpSm/fa7zfAGvoC5FcT2QIWBSUoMNrQOb5eMWC/TfW3My2y9dlK160TaxPCLqmjP07zUM2S7kmda/92zZrbrPaeAERS7HAsxe4EfswVGFOQm6jX4x8RQ7l7hI3C7uE1LiJK4prfRCTaM+NxkonjfCqEHOrv+Xd1rGgxDEeg66SuOOoErUve0pJNpARxoB6NtYaNaSBg7nd1XtLzkOojhQpm0RPNKV8niCFCulbHtAQOuCRWMG+v9a+pgv5HvWbZI3qRuR8uc51/ysoq3pNuQrrFal+YXnZyDSE38W6IJyiv0B4M41C+d9gMBuxvab3m7MS00S8E/im2ctjzlP1k3yjCaJVrP2SJs0MrE2Sl6IJp/y8sE+tebscVYrY+bd9xSawvixXB5CDK5mK8jvIrylr4oZQc0A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(316002)(41300700001)(38100700002)(82960400001)(478600001)(8936002)(8676002)(86362001)(36756003)(6916009)(31696002)(66946007)(66556008)(66476007)(83380400001)(966005)(2906002)(44832011)(4744005)(186003)(6512007)(6506007)(31686004)(2616005)(26005)(5660300002)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkZxbEFDSHBmcDMveUpvell5SmQ4TjF3OERRcFUwdEVqOHVLWEhVU2JBaUR0?=
 =?utf-8?B?bzY3eGp4cFE3cGgyZmdvcTA5OGZxQTUwdDkyd0ZScUFpbGxTUHpsZVlHSVBR?=
 =?utf-8?B?OU4wYm11MEtkaG9vM25OR3JsT1cySUJlVHdpa3g5MTN3OGFFQ1hzQTlxMlNL?=
 =?utf-8?B?Tno5ZFlNdmR2clN5OVBTeC9vTlYzK1EraUhSODFkdDNvS1JHU3IzTm1qMjk4?=
 =?utf-8?B?MFFTdjJWSTE5bHI1ekdIbGlUc2NXMEF1bTRRaEIreDRvMmFVd254cldmS3Jt?=
 =?utf-8?B?WFppRThLZUpPRXhEZ3FPSStVRXRqSURrUHhtWTE1ekJKbUhzMEt4aXpFM3Vw?=
 =?utf-8?B?T3lRWmMyMnNLUWJ4cXVWZHAzdzVaVFNiMGdJbUFnRC8rZkp6cmhHUURIVlpr?=
 =?utf-8?B?b1Z5WW1LNVF3TXlPSUpTckIrdVUzbFBEajlqaEdMUHVXajRXakg2c21YekFu?=
 =?utf-8?B?WklLemIzWjBSYld4VlIvTjhkNnNUZnhPdUt2SFJPeEZtV04xbEJPaE9pL2Jl?=
 =?utf-8?B?azVPcXdwcEVGSFdmby9kVzUvbUNZZkJiaG50SmZsQklMTXh4WncvdmhWODBa?=
 =?utf-8?B?TVUzSzk3OXVpaEh0cUh4NFgwOHhPL0pUdjRaRVV4dUF1MVN2WUMxMHlzN2V4?=
 =?utf-8?B?VlNSd2QvVXJ1M3RYUWlzY01MdDBBRVVRK3ROa2VqS09sQTlIWXZwUW9WY2Y0?=
 =?utf-8?B?ZTcvQS9ueDhmdWhlR25MRFRyNkJzWklTdG5CM2lmRWFHMVU0SUtOQnFneFRy?=
 =?utf-8?B?aXMyZWthMERKZUxySWdmdkdLZ25HR1lkM3VvS1RTOEhMcFdwN0NZdklJUmhU?=
 =?utf-8?B?TDVkazFEUlB0YXFtdTYveEwzUngrKzUwUWVhT2hqL0FDQjRmdWNFRTR5QzRC?=
 =?utf-8?B?Y29VaStOWDBsOW01WXhMbzMwbTJEalJUSVZodFg5V3ZXalVmTEE0N1ByTDBW?=
 =?utf-8?B?bm5IVTQrM0E5bEdENUpaK0hLbXlnNjRNUmM3N1ZiYkhDNzZBbGRzbEpkaWxR?=
 =?utf-8?B?U255ZDI3UU5GRG50OCtFZy9KSzZrLzlGRWw4RmRMdFZaU1YrYTRKVzgrK2ty?=
 =?utf-8?B?eXdrVkRnOHpOcU5rWnVaeHczNmtDTDJnblI0b1k3QzgzMnlvUVJBMm1DUWRi?=
 =?utf-8?B?VEZOcEtwa3NmQjNOcEg0dHZ6RW83YWZncXVrZDFYNlNFMGpuMzl1d0dlTDJO?=
 =?utf-8?B?TVRXSU9JNUlaemtQZ2dIQVB0TnVtQXptNVc1TEtya25oNCs4a3pjL1B0dTNZ?=
 =?utf-8?B?d2RQUlBwV3RxY1N0a1BGcWRpbXU5aFBVVmpjTWFTL2t4eGZ0L1gzeEREVVFi?=
 =?utf-8?B?REpWOWE5NWlwcjhQWVJaN1FZYmV6Y1c3ZjFHOWpaSVJ1MXhMaFlRN0tnQ2NS?=
 =?utf-8?B?MU9mT1RnRUR3RERqVk9jbGt3OTlVZnZyVlNlaHQzNTE0WVVuejFKSGNyNHpx?=
 =?utf-8?B?blcyL1JjeDl1WlV3dG8rNG9DSUpzZzVuamFzRzZKT1g3dlpMUW5UcHZLMXln?=
 =?utf-8?B?NTNyREwvMjcwZHdrKzhCN3l6MjByU1dVV3p5S0Qrd1FlSGxPR2pQTnp1T2dR?=
 =?utf-8?B?REtxL1FVYXdSMkRzSEcxWFlyeGM0bWhUWi9ZUlUvaEtlVVVRUHZ2ZkV3d01K?=
 =?utf-8?B?RUpPQkdlN3NBRHpmSW5NaTBxci9VZXI5aHZWMFQycS9KVXlzMERlakxqNEZI?=
 =?utf-8?B?SzlEU0E0UlJTSXpZdFZhQnJ0SW9TSWdWbHR5NVI3dDJXY3h2V1BmeUR1b1dz?=
 =?utf-8?B?SFhxZVFsdzcvVEY4QjRJbE5IU25LWG1rQTJVWnI1bFRxYzdRYm43dHFkU1gv?=
 =?utf-8?B?anBJTTdvWStxTmpDVnphQlRZYUlpMlpsV2VQZ0hjaFpyTVMvaEZqZGVBeEZz?=
 =?utf-8?B?eU42NE0rcUJJanRPZk1zbHp0ckoySUhoVGR1WVVKS1k1Wk5NbVFkSTBHb0tu?=
 =?utf-8?B?aU1LbS9URk81N2ZROWw0YUcxMVpodU9GYjMxOHVWUXZob1BnRjdsSS94cThx?=
 =?utf-8?B?TWoyTmMwcVU4OEF1WW40b2lZdXk3bGZwN2poTms0OER3d1c2NHZVTWF4aGdh?=
 =?utf-8?B?MVVFRkRwV0YxYTlQYUZORDFrdm5LY28wY0RSZFVOZjJOd2xlMlROZFlubk9j?=
 =?utf-8?Q?i8BYHXL9AXJXNkkh8ZX775/FY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ce2f84-feb6-4c00-e641-08db4c6bad8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 06:49:16.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UHmlhWVyW4t+cbY6TE9PpR6baNWO4R6rGJT8ZW3sABqSEdwHOLhGe8kPBAjyVjy/uPLyUQ5WnUqE6EfTPS6oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6963
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 May 2023 06:49:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11410

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=5&day=4&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/04/cip.2023-04-27-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

