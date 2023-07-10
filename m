Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84046EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 13:40:10 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.85])
 by mx.groups.io with SMTP id smtpd.web10.39896.1688996407465085187
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 06:40:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dWzgfT24;
 spf=pass (domain: siemens.com, ip: 40.107.15.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmgrLkP9soFiXIJoKdU0yN/oiadmz+H5SMfHa1jG1Lqv7dkByJwzhYnLloTAGdhpA6VsIKTKMknGx0YN5GLGn26/iwGScJGgoNT1vmu0bpXmB4YorhjRBLHuYKcInUFeNdkG/P4kMCFd82ioj9E5PFHGD3dmTJ8CZLUyLpu50JsTayisgUcMc5GX3EXTexE5Zs1463CM5pr98Qw6oD0fnVRZJ/uMKz9Q7xHEf8WiQkgNQZ64t4CdDGCwKzw/Rkb64c4Y8WRXc8J4Pb/b37JlBlxVoJYdi0TSANH3EHxWnxjrczOV9q2N3lKxmR1UPrppMMANmwpL3f3EmUpipzI7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6f+Dt2+vg9KUS2B1exSd2VrC/LSPSPVrI8q/+drxFE=;
 b=Y9dV2RRHsYcCBmezKJiSE3izZvpq81lcJVn4vOeFMmJral/TQZt+o3z5QCgQeYWp18/g9tRBb6MG7o3GfSs5dvB81rbmT4zNSVcx391m2zNq540FNCMdR1kVzVW0IhYY1mQAWNEHDXJS4qRTg/2K4MmG2LOXIvZ7qv4VSGQlN5JNJ8/YXulpqYjwqwTBiLi1Vm62xgHL+tJ6r+Y6refD5AzBVcND9tzG8W2bJRVDf0LfaPSVOEJDpOET4cTgRW3n2FxGtmdRKRw3vF6GsEiwM+iaLP3IlO517oOBrmO3shXHvNKVuuwSALOzesUMCeajzkm3Ldt+7V6QgZOC1JUYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6f+Dt2+vg9KUS2B1exSd2VrC/LSPSPVrI8q/+drxFE=;
 b=dWzgfT24c5S8N8gdyZmE71uvsYiKV9vOo0wtE+LCN/jUgdpg/wOGvqL2n3iFK4dSGLXUEaj5vyMc94w1gl5F6CMtoLiGr2BVcvseMxgfoa1xf/Jt/kz7/tolkzh8G81/NVy8VoqIEax3OZ3hqyznfHbNeokjw9M7Q7cO90ns134h0hEhJsPwhBIZr8K2j4q23kqy6GvOKN+UbvXSqVXepeWkFpY4mB56th/XD7X+tu3yuuzkYGSvzTObHkIIWk6nPc1iY5dwhXuD8JOsnM/7yQqzqXNZhzJQx0YgyMFzCFkZhm0OKbn+ULTrJ6yKQZrHbaJvH00XPyLdYfKr+/2Z6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:527::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 13:40:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:40:04 +0000
Message-ID: <1a507755-e6db-3ef1-ff0f-cf863de4e2af@siemens.com>
Date: Mon, 10 Jul 2023 15:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH] recipes-python/shtab: Update shelltab to
 latest one
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230710122756.3741741-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 75152534-ee55-49ca-121b-08db814b2ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vU5+NQt8365IleD7BJkIcXvsD1vxFSpaez2iP8XDA6GGy+pRGRMBWQvmfgNoiOoBA8j5qgqbYnJXnqgGjYtoJ5/D6sn6++jxOFWnCVg57KyMtoPQZtK8DujmvZmhur/xd4zkJNQKgHVUcNkZ3dldcv0bfFyFJqlnN2AEK3VQjO2u6zZAquL83xlxEwg0bPpKm/wz8UAnB9uJlZ4y6tIan8KHoph6y+ohr/9Fre1krvR7MSkcfOmBOP+ywniYzJt6hi8bOnk3VlxNA6PWcc//D0A8FghYldpIuCIj3CJS9TbDfHOiqK59oQftHyk4pjWQwF82mByP84uKj3dOmTM24YRDiOeo86d7KMranH9YnRet9iTOF/T23fmai3gjOZ7FM0G23oWzF6McUJfaCAX6eIKIF9fMhWAUDeIEZTQepJslbqCgzI45lCaADWY1YvSyVtDqdqMI1ygNYb+OdZxIjAnR3AE5wIteSRszNYCVVOsDJxWyQdPNiOff4aPVLDwYst3ISqzI7NHzYQ0QT+y0HtvA1YEzZl5fBfyZlYAqhHMritWrjW6eLs231oGPJRDF/QXivOdhbnSQS96wyFd8SZZUKYZXaEygk50NyJc01pfUg3LAXtP56wi35DVT5i2Fyl5qMrAQb30kxK8t/2SvMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6486002)(82960400001)(107886003)(53546011)(26005)(6506007)(186003)(6512007)(2616005)(44832011)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(15650500001)(66476007)(8676002)(83380400001)(4326008)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXZxT3BFY21VRzFDNVYwYXhsWVpiMlhKOUdwTkFHQWY3YnU5RXhGVmcxVmVC?=
 =?utf-8?B?ZnpRa1liOWpwNlp0ckRJcjlsY3J5UFRmVWtDMWhBaE0xY3VwbGFVOTN6Mmgx?=
 =?utf-8?B?N2lJWnBhR29LUFpoVklycExLYkoxWWJTQ3hDTFhUTmZlQisxNytJRGdYZzJ4?=
 =?utf-8?B?RHVLRnJDayt1ekM1MkNCNzBqU0NzRWhZSmUwbENXQkFXQW5GODNVZHJRL3gy?=
 =?utf-8?B?M0RSbE4zQTZyOGFxampENFpEMHphN0dTblV1MmJORjFuVGhVejZxQXJqSFZ5?=
 =?utf-8?B?bnllV2dRODhyTFF5V01hbFRJYmd1T3J6UytYR2lsZWpiSDJEVURWYThGOVlK?=
 =?utf-8?B?MldHY2JpWW5kaUlxNDJHQVp5MEZiWDRqVUpuT0FWbHZjR2pjTy9tTGdKRVNa?=
 =?utf-8?B?WU5CaDdPTHdKR0JrTThqVGJueUc5aDY4d2RyRDF2RWZ2Tmg0WlF3VTJmUDdE?=
 =?utf-8?B?UVhZNFlkMG9LUDljZHNXeUpBV1ZqaDd4MnhEa29ndjNQNDEzU3lmUmdZZ0tD?=
 =?utf-8?B?MGlsL2ZadVpsa2RabGU3eFlFL1Y3M3RNczRUWE5lTTc0bCt3R2J3MmN4bnhh?=
 =?utf-8?B?Z3BBYWhpS0xtUTVaZXRLZVRyN2E5UElRTEMzTW95K0djdklBS0tSZE1QdWJm?=
 =?utf-8?B?QUtGY1pyNVpJem01WE0wSnhLQno0dVI3emZnY1ErWnFzYjFQWUV4QjRZdmUw?=
 =?utf-8?B?QjR2TllUeDM4VnMvcmpLS092NFd0OGRaRS9VejJXTk9PQ21scURyRDdxNVRl?=
 =?utf-8?B?elJrU0F1MXFlQTNCYmc4UU5oVWxScm91aVhYaTBSc24zNWl1cjBVeWI3TkhW?=
 =?utf-8?B?dXRGSDV3b2s4MlRPRmpJa1lEZ0hUczZVaUxoNy9KelJiYVNlWjh0SzlEYTk0?=
 =?utf-8?B?NW90MVhXcHVUVWxMUXQwRDhRSUFNMWZHUjRYWFd5MC9xdGl1WDBLbmV5eE9I?=
 =?utf-8?B?NHZrYVI2VW9hZVhaWUJLNkN3Wmd0VXhuR0pIVmt2dThPSVRVUzYzQjJZTGlw?=
 =?utf-8?B?M3orejA1QlptaEx6ZlFLT2M2M0NVVmlKTy9XNll5NFhHU2xKM0YzMzYzQVJE?=
 =?utf-8?B?WE5GVHd2RHI0Ky8rbEczdEtxRFArWW42MzJiNjJyZlRBZjVWdHNGanRKTU0z?=
 =?utf-8?B?VHBOcHNTeFhaeHgwV3F2ODduVUhFdG1Qd2s5L0E5bTI3Q3N6NXZGeWNiZnA5?=
 =?utf-8?B?VmhONEgvd00vd0VIZjB3ckFLbDcvWXcra0o1MnduZ0FvUzZFeC9VSFVMb0pL?=
 =?utf-8?B?OE5LS2swakw0WWtHSXF2OXp6NFhMWk9BOW1qVDN0RWhUc3RPa2hDMy90ajUr?=
 =?utf-8?B?eFlhOU51S01SSWdtZ3phYWRoT2E0RjNvaXE1VzZlVkZYUkFpbnVsalBuS1hp?=
 =?utf-8?B?RkZTRnp3WXZQRVVXSkxGeEhmcjE0OEVxMnJnSkxsbjAvQ2l6ckNhYml0L0VI?=
 =?utf-8?B?TGVGaGNNUjJHMTVEejBjVmJwTnNqMndXREFlMU94Mjk5Q2QxTWZ4cmo5QldL?=
 =?utf-8?B?OThXUy90ZGdTWm1sdTlwcFZ6dFpTZ29nMXBMVG9FVGl4YWVsT3dKSnB0NjRU?=
 =?utf-8?B?dXpsRzdkUHc1eDBmbVpZQXlKT2NOY3J4Z0p5MTFUb2xlU3lFVWRRTUJBZzVx?=
 =?utf-8?B?SENRSFZjWHVhaW0wK1JmWFk5MDdvVWEzU0RVTzVUdGtsdENsRDVtU2o1UG42?=
 =?utf-8?B?U3Q2Q2JWdGxhWkpFcDByaUc4am1ZTU5seVdhdXkrZUxubXBCTHczZ2JzT24r?=
 =?utf-8?B?RnZYT1RFc2N4ZTdCNEkxMFo5Q0o1ZUQ5NVdibW41VkkvZmZIbWh2RlkxN0NC?=
 =?utf-8?B?Unp4dVp4aTFKR1doOVVqSkRMbzI0cE00MHlFTEwydFFGQlV5ZE9lRmF6VWhY?=
 =?utf-8?B?OW9YKzZxUUFjaE9VWTk0aUJEUHRxZGdWOHpEN1ZJQjRzQlcySTZ2Ymx2Y1dt?=
 =?utf-8?B?c3NtZDVCckFrbytURFk1UmQrMFV2UVZQQzBmbjB3RE1iV05kb1RLZ1l5cGpP?=
 =?utf-8?B?VHRMSSt0UkVzZVJmbnBDbEh0aS8xai94YUJHS3JsM2JBU0ROaXcxY2x6OGpC?=
 =?utf-8?B?ZThFMU1pS0kyTW16ZHpjUTdNTkFxR2xLTkhSajY4ZXVpeW1zVFhDRWVjTStM?=
 =?utf-8?B?WWZsZVcwZkhXR20wUEJtRmZ5Szg0L3Uvdm1YRnBhR0xvNGpacU53a0d3bkxj?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75152534-ee55-49ca-121b-08db814b2ad3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:40:04.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLG8CXJmktdWOTWDrkVOj29ne/XW84F0FF/yaPX9TKRRefEPBe7TwWDE6ELjC7H5UPPqCYl7wCS0BupbGbvKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 13:40:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12295

On 10.07.23 14:27, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update shelltab to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...001-Lower-requirements-on-setuptools.patch | 79 ++++++++++++++-----
>  recipes-python/shtab/files/rules              | 21 -----
>  recipes-python/shtab/python3-shtab_1.4.2.bb   | 36 ---------
>  recipes-python/shtab/python3-shtab_1.5.5-4.bb | 28 +++++++
>  4 files changed, 87 insertions(+), 77 deletions(-)
>  delete mode 100755 recipes-python/shtab/files/rules
>  delete mode 100644 recipes-python/shtab/python3-shtab_1.4.2.bb
>  create mode 100644 recipes-python/shtab/python3-shtab_1.5.5-4.bb

Debian (even sid) is at 1.5.5-3 - what is 1.5.5-4, an upcoming update?

Otherwise, nice update.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


