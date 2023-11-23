Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CD2C61D97
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 15:35:28 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web10.93463.1700753719003983229
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 07:35:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Tx1eltxg;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHAy89U0TMOsIC8uujSDTy3mb5H2grpChiT7raMp1T53XsRSa6ZiKkQORih2Eojf/+zQhiAcoiqY5PAuIFdQrH+aI0cNJoL1sQUtcKsBMZJ6XDt7hj/W6So7SCNTBk3b0fQSkkpFMz9BB0gkeb/Qv9Q8pc98qH9gNVThckeh6fDHEQ2Fv+iY7xjS0WdoRHyXYEa16ibTT5iwxIGLoXfd4R5a5/aogbNjNVSXAgZ+8VUAprh1X0D5hvn+dE4m0L0XNvm7ef9vrYCzO+U0LJ1tR2de2VkzqjmR2E192KkHSdrQRlLJzbEV8RxOBULslL2wcxtjTg64m6xJqsxxz/wD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj4fgcnOKg1gL5cVVFl5kon5GkD/QpSPbrwcfWayBOs=;
 b=jdv9JQjfIWztDQJlrljOzANhob4eeSrFfzf3JtR5nVU0QoKZNGwP+qYpoKpnasaF0+JqIe8/LWqmNbjzGLlZEe87D3XXl9Tm6IK0CSjl6CXhvOA4igRxJ9X/p5Gdg04ZphqANBpQhb9IlCqzoLNL6KCzmZxmgirpnnED9l9DYye8ReL2LXBLxDcnn79uwA9wq0HjjUdvtcCqV4GbZtsoOeOoC6JX32QhZDzdPRN7J9f4Zfnu3oGMmn8BolrIpzrbh3vMnbe8McZX6NNTfrbcjqVQ7BRPKJ+Q32awOOzZ5DQm1jdXeoz9Ch2wI5RvH36YinviP8kyZggPea3Ly8TSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj4fgcnOKg1gL5cVVFl5kon5GkD/QpSPbrwcfWayBOs=;
 b=Tx1eltxg8jkhsIv1N5Ylcuug/6fQ7F2rmGAyqOXrsg23/bnLgAqySTDlSnyIwptOyoXqPcrpwJpg9ssySEryTb351c61H8fUOGDfWsFC9twQJ7sECkvUzOCtNPvTr07XAv/L4OmbXi2kb4mVd8y9St9jJZZxTwrlSCcUgIeUkRXEhlYhK6SUEsb3Ukwz1ULE9cNa5ZKVG70Kgzsu40VzSikT02TJuC5Wg5YcG89fWod6aap8MwnZ+F3E25jSAYYI8YBZIl8QdIHrKzjcXXyHjA+FS2FbfmHacmC1CCRooZMHCfWpy7EKACH0l+QSuEvfyt/GlhZaca7Y+m3HHYX1gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:35:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:35:15 +0000
Message-ID: <41035499-e6eb-489c-b6fd-088928dfb6dd@siemens.com>
Date: Thu, 23 Nov 2023 23:35:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC] swupdate: Add symmetric encryption
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20231123102923.1405219-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231123102923.1405219-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:a03:100::49) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac6040c-7ed7-4c25-6059-08dbec39ca1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HHCRKEk12uGKUaDqixFIohXlH958pW8NEOR5+Y/P8uIavC5u/QBVQ6vt2qEnjWVTFnqXtOY3YE+rmJSv5lcrFU1vb92RcMAHIS1t2ZLmhhL1FHqUrv2D+4xEMH+6g1QJ1gw21XzR+T+Vssc0PpIzURlzvvGDtFgW5srieN3lgWvi5kzP4CRSd2UBcDEgW4YyuHFBur6yU1na/+EkQl7ErIsjOc1BgGzl07WTYK11GAu7kqj07sRKVYxdgBX2LQla1gI4Q0dKK4BPhBgxSql1KaOAGNsJHVTZkeOqr1ErZ2mDrnGT2ASObAb3OCCWdfF+M7BGvjs2eJ6o60GcKZ0aaMRPga/gizwyZlRq9SSTVwxL7sMKAmvXguYYzg7g7H4v/GgngTgMLQghYn50dkPAIyF2a4695pRyjAGvSoY06DfGUM9b4o9sEyozjC8+vEZxJm2exR9DoW38P45AsGLhis7gReiyn0lvQ17MzjxnHCvf7UbgWZbJECPLofSb413q67umsp4fbdVRU+nfC6kYNgTuwBnQSW2ooc7QL6lVfYa9QqRIdQMfijApA9IJvk/obvmXpuQlbgDeeXnmenFE57Pjw55OkDhkz2V+VnR9U/4FRD14njEo451qjMNeqq+gRuYIJijygsaA1p2NHrYQcA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(6666004)(6512007)(6506007)(2616005)(53546011)(44832011)(8676002)(5660300002)(8936002)(41300700001)(4744005)(6486002)(2906002)(478600001)(316002)(66556008)(66946007)(66476007)(31696002)(86362001)(36756003)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RlNyNUJ3djkzMTk1VUVOMmdSeHc1eGN4SEdwYTdMWjN1TTdUVElDS1VEbHRn?=
 =?utf-8?B?MzE5VFVJb3RFc2N3blBnRk1xQzBmREV2YTRKKzYwTzlndjR2THA1Y2EvUU9s?=
 =?utf-8?B?NWUzUEpNSzZSNUZhOXdSMFdMZno5cStsUzJSV01XRzdtTUl0TEtlT3piV29C?=
 =?utf-8?B?ZFA5d1R0Sk9SQXdkeStrc3lkZzRrUHZuMDdUU2Zpb2g1VE43YXp0THJUZlN0?=
 =?utf-8?B?TkkzZDRMQnBBSGdPa0tUb21GWXJ0eGtYcGJnR2lTamhGYjV3aWEwTEoxMUxC?=
 =?utf-8?B?R1RIY3duQkhNSnBOMjdlTk91QmJ6R1NMS0RsV1IzUGJEazY4NnJCQnI1V2Z3?=
 =?utf-8?B?ODA5ZEtOaEg1Q1RxUnBlSmJQR3YxNjRHWjFSWGRGVHQ4Y1EwVWZqZlJvLzlR?=
 =?utf-8?B?Q1h5NmdXWjRtOWhLYk4xbitveUZLaVFLY0dOTlB2dDJpK25wQlpyZjA5V1Uy?=
 =?utf-8?B?eDdnS3ZsUGFNY1I0emx3N3l6RmxyY0pSWE0xVGR1MTFDNEhxM3FRbzNpYXVU?=
 =?utf-8?B?dWFoS2NkRVNSRlRYTnAxaUpIbWkzTTdlZUpLamNwclFJaDZvVk5ESEFySFhF?=
 =?utf-8?B?RDB2RUdSbFdNQUxZZU9BYzQwSnNoVXV3TXV6L2grcEhRcmVIcU4yUXZLT2py?=
 =?utf-8?B?R2Z2Wm1BUXNwWHVxcUxqSlFMVk1ZUU9EdnQzc1dXaWo3d2x2QWh3RVVPd2th?=
 =?utf-8?B?Q3QyL2MwSkNBd2hpTG5EVUNkbEJtWjVmVFRlc1pvU08wZWppYmhVWjRSdHNV?=
 =?utf-8?B?dzNFT1FRN25kUUgveEJZVmlJWnNyc0lpdnlWKzBmU1J2azl0RVJGQjB2Rjl5?=
 =?utf-8?B?RFJKaEtzM3FLWXNIVEx1ZnVKZWs1Z2hhdHB4em1LWTJaRnl4QnorMnJvZ0Ix?=
 =?utf-8?B?cHJlQlRkRHFBZmllTElmbXViZFNqSldmZ0wySzlSY3VDcndpaWR5QktXSHph?=
 =?utf-8?B?MzdLM2Jnbm9zZm41LzQ3WUFjbzBEQXZMSkYyVFJ0emF6V2I4YmZxRG1mcVAz?=
 =?utf-8?B?V3hXVmR0eHZpQk5KQU9WQ0NOZnVvNHZRMzE0SnBSRnFwbDRDSXc2c2tzRTlI?=
 =?utf-8?B?aUF5bFd1NmJ5QXgxRmxXRkQ2Nzc5NUFvUEIyS1ZkelZzQkN6NU9vc0ZobWVL?=
 =?utf-8?B?TGw2d1RZZG96eWlPKzRady8rblNwS296VnMzcktXN2N5QW5lY0thYitYaXB5?=
 =?utf-8?B?Sml6S2dzbEcwTjRPU3pvbW9YK3VVNkJySld4dGhhcTNTdENvV0FaMHpOWlNq?=
 =?utf-8?B?K0R5Z3Arbm5TN0tBSTBWb3pWSElYb09HU09QRlovNjNFN0V4Zzh1UUxzYXBI?=
 =?utf-8?B?Vzl1NFY1bnFsdkkyUlZpMXc1U29uV2IvcTR4NDdDYmQ4aWEyUkhMaFYvQmlm?=
 =?utf-8?B?YzQzWVIyREE5LzhGWmFET1BXTzFjRFpjWGQxc1dpWUVHdXdPVUFQcnRRcS80?=
 =?utf-8?B?UjBkcGxKd2V2STB0QmVKVXZ6S3hvK21XRktSZHVCNnQ1MytNeXpvck9odU9Q?=
 =?utf-8?B?aVBNVnhTekhrNkswSmFkV3VMSkFqUUQ2MGRUREpwZTQyYWJoUWU5Q2FDUHR0?=
 =?utf-8?B?SVo3TENBZzJRMGZPWGUvRi84ZW1uN29IYkNmcDluMHVGaUVmWGQvV3E0WHp3?=
 =?utf-8?B?ZU5IVUlIcmNJTlpxdWFYUkQ1UG44bWVTNGljckZuYTlNN3o4ZHczRGw2aHJM?=
 =?utf-8?B?cmRtTjJsZDdKME5hTGZ3QjZjcWVKR3JUelloejc5NnE4MHo4QUYzeFUrRURG?=
 =?utf-8?B?eE8wcXpsc3ZPZXQ2b0FJOE16eWhVT1BVSEhLV0RBMW56YWs4U0t3UkVnTFV0?=
 =?utf-8?B?SFVDdnAyOTg3cHdMcUJXNEdtcU80WUZsb2Z0cjk4dlNMQm5GdHZ4UDdwRzVv?=
 =?utf-8?B?RG9lYktrNTVpZmJpQW5zREF3OHdoaE5QamlXUU92NnVaSmVQNmJKV2F1UVdG?=
 =?utf-8?B?U0svbnJ6ai9OZFJJdDN3eUNCYlVPWUNBeVhnMmR2VmNZNTUrZmlPdnk1SkFL?=
 =?utf-8?B?OCs5QzZCQ3BtYWhVeGFJWmJ1ZyszMlNjRmxtYWNwZkhpSk4wd2JmTW01Z3lm?=
 =?utf-8?B?K1NscmdQN3o5OTI3bzhTTFIrYjlwMFQ5YkhpaUQyOWg4Y3FjcnRSUjUyWEth?=
 =?utf-8?Q?fmSBu61hEr1p7HPiqhzjvBfXc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6040c-7ed7-4c25-6059-08dbec39ca1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:35:15.4325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: is8ceYm8+4x1EOTVx0pMMsS0KmCAGR3DNRctOfeQW9qhjz2mti7VV2edY/L1CPgZFFrNn99Sd4+r6aUSPUbx9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5993
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 15:35:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13672

On 23.11.23 18:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> by setting the variable `SWU_ENCRYPTED = "1"` all files will be
> encrypted with the symmetric key SWU_ENCRYPTED_KEY and
> SWUPDATE_ENCRYPTED_IV.
> This key will be stored on the device to decrypt a received *.swu.
> The default location of the key is in /etc/swupdate as it can be
> encrypted.

But how does it get there for initial deployment, given that we do not
pre-encrypt the image that is installed on a blank device?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


