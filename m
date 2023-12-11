Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323B8C10F05
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 14:56:44 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.81])
 by mx.groups.io with SMTP id smtpd.web10.10339.1702306597550060651
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 06:56:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SCUZ7ZcK;
 spf=pass (domain: siemens.com, ip: 40.107.7.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXEO9TOzrBd1tvvCzqQLoSngxOzsVaORIxEvgl4MuBZ6LpSqrm367hQzjh4mAJb7QlWe768De/eWyhEH3zLH23wJuZf0uGT4hwIkizapbO9WWywDu7T08YNO8uJix6RqnYgcLB3urMY7xEMeTjCCzSlcUKtYB+tYS5QP3GOqBRBErshSezftIWRYCQtRBL9FKmVgyS0uq+qFwAcmW/3mFi6hRf9vmHDJcpJaha2d85xxdqYAknKuiRyUc32ghPAZmUCuIvn1RO/DTzGuAgk8YylrJko+IInjmTrf0qK3QDfhvBUGWoUb0A7nFfXVUEEkNRQvxc7SyhNCSetogCa2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCpeTpEnJzbGNhaSVup4CkV6N7Rj5AUzODCxWKaOFVA=;
 b=UAI76CMKYVQwjo4Aqb7Kmrh23HurTHVDBlOmXvdHe/ciTj6UN6Tq3Chk+Q6XeQzQjMzIFqneMsSjMBTtsiRcgc+/1WRXLEPZZC1ZVd+jjivrkAO1n0CwzvditxcgHLYCgwiMwYVW1knHD05W7PE6F2xjEUjCHBBSe7J7D0nNEwSO8DWWzk/vDh9YE5OA5ydMHz0Sp542/F1Hu3ojieMxFsoAwAkoxc5ipXaJMGLd/MViQTXMo3ZT9lgGdaWImZnLHmlPqOrNor5RvqPsuZ0tmPaxoYJ5tD5ts/LnuYXbaeeQ7gwFCwkiSPW6ccpn3XwUTrvata0r/RZlPFMTu6G+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCpeTpEnJzbGNhaSVup4CkV6N7Rj5AUzODCxWKaOFVA=;
 b=SCUZ7ZcKDMFg6fBPFaHSPAXSnTxt+z5dHho8pBKoHRDZ2EjCRZNPBz6ILgiLHX4OyKiM4yAMnjRStg2rcKKiW56YTnyTriV/rHA1wBdn3A/Vt6e6IDxIu93sbo9TUZv3FyCvzyfhrF6o97C2UDiLaohtvt3VHj409JfMrK7mrFsiz9NOAiHU4QIRX0BBsmidRGENNjaleM+wm9zgmco2iBfJGu3xxk8fWhVlNTHASOr3kZqxiRAHAUte1I5F35jdAoOA/TyUg/MO/WgK/7on5QpbDInAeg5ElAL3PTUNeSZhmaaYK4Y1Khoit5BGl5sP3C88j586Gb3vsiFW7lbfyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:56:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:56:34 +0000
Message-ID: <10d58a5a-7ef2-448f-b55f-ad83bb8714ad@siemens.com>
Date: Mon, 11 Dec 2023 15:56:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
 <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
 <3f622b00-006d-476e-a928-79b0a31dc750@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3f622b00-006d-476e-a928-79b0a31dc750@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 31433148-c320-4763-ccb2-08dbfa595df5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UeRVFInEpTWF7QPDlF6fbbQuLPSRz+FuwV9pMAqpUyIoLIxa1HBXgXZnZlU9742KsIYEBS84nn+xJTgpaTn3WkA0cvrCOQjSUtdUTB/zcWTa4zqhFSW3Sp0riKiwjR0LoxIlVgBQWL3hqT4MGOQvu8Nhkvfl9jGM8hTHWf6Dvf8Yx71LgypW1UR0CIGECrlG2qmiV+yfC+qHhfjBMlJhm1jZoXZubej0lIVk/AmxUR75yZkbQ0H7xzkuhzUWJtOStTL8tkRkhUeDO6RQUgQdr0hTCRU6Aa0iiY2E5u/g9/qQCQnxC3Ngqjja23t7HznEx8fFfD0KCaItbZOX7kgCWL2WCdPAI0tZDCKyh6ZNgdgfk3ux1zVSO0zuXxf4hjxPLTm6ZYo6gvHUijBnhNSdvplC9hdicJmNqDCT5t3hkM+Dm8k134uvAehQAMQZf3OQ7/o+SFPW1kkMXj3x7i2cXMEuM4lLQFCGDsU8gATYvsbjHzr3Uw/dYDvOeb1W6x+lv11P3p3aETiZAnv7ts1KBTh6BTgG+fE1M1rhSJk2DJM1dkR25zz8/c/YCUc2W2zbQ92LcyUehqqZWUfBpEydlMkb91q3Yf5okqrGlc8VdKdJYXW8FrQ5+7r+xkufg8b+9GpHqPqFDYY6l3dMpvwMvI2UakydjFqRBsId1g/8idBS/jnN+RGgdr4qm+3ysKeT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(66946007)(6486002)(66476007)(66556008)(966005)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(31696002)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFo0N0lVMjlhR3NEK1UvYkFHZmFTaXQyYVVKZmhoVy9IL2M5dFc2SndwdjR1?=
 =?utf-8?B?aEZ6dit0dmg0UFd4VW56bU1lbHA0Z1ZSZTFWRFRhSG1lTVFZMi9OeVZoazNt?=
 =?utf-8?B?VHo1Y0xONW9mRnFaZ1VYSlBZVFJVNThXUlllTDQ5M01WTE1zRjZvMytad2s2?=
 =?utf-8?B?WTVSRy9MUnRsZ2VsMitxdVpRRU5CWDNBeVlHVUdGeDZlVXE0QllJY2gxMTll?=
 =?utf-8?B?NVBuaTV0cVRIYkR1cldNd1JCd3c4RlpmMmo5U25mMno1SGNOV3BicitqRmF6?=
 =?utf-8?B?NG1KQStJZUp3SVFLN2VFSy9kc3hsa0g2QjJtTFI5WWNmSllSeHczQUpiaUhj?=
 =?utf-8?B?Q2pyK0wyYXJKdlRuRU9rQUZFNjlGTk5ZM2dFQnN0K3ovSnhYdEdPaGwyNm1j?=
 =?utf-8?B?SDl1Qit2V3E4RnErZ2Z2dUYvYkFwUHZmWjdEVFBqbEorWWFSU0YvbmtMZEl0?=
 =?utf-8?B?cW5HaWc3MVR6NFdIK3NZQ2NEK2hiQmhkYlVtWlVONkFWYmxuUzV1MlJUMkpQ?=
 =?utf-8?B?dHBQSExvZnQ4T3IvTXR1bjBnVnRYazU2aTVURmJKUlpOeXZkSEp6aXR5cENw?=
 =?utf-8?B?UkVkKzAxdVI2TkNRRTdtbVYzMjFxTnhPK0F6bjZ0QStyOTg1MTVUeDl1cW4r?=
 =?utf-8?B?cy9uVkJMVFJGT2dDMElwVXRiM0lYUjdqN3ZRZ2h3cXFsZ0hrNzNvN29sTVBU?=
 =?utf-8?B?bTFIZUpRTWU3NmZYYU9HQ1lJZzZRdzJzL2g3eVo0WGYveCt4ay9YaStGR2o1?=
 =?utf-8?B?Z0xZdlUrSDR2Rk5zYjdYUHNqYXhuWHA2VTFidWlKZVpnMFFWbGhhaUszUm0x?=
 =?utf-8?B?MEdNblB0RWlVbWY3UWV5cm40R1YycG9lbWxUT0dlUnpVcnZGSk1XcUI4b1p1?=
 =?utf-8?B?Znp0dlhmT1J3eGQvaHh6N1hPVjlkWUF0bGFpQ2lnc0NnV2c5OXZoTlgzUjBT?=
 =?utf-8?B?YUN6Ry9hT0ZQakpVQm5rZk9jSXFOUFhvYTJteW5qaVFVakUvbHNXREQvZmQx?=
 =?utf-8?B?blpyMmNHei9aNUpoaWdGc0NlQWVYNFdRbmphT1hKenpERVNIZ3BNWVN6MTMy?=
 =?utf-8?B?YlowQTE0dnFGM0RVWHh6UGZDUjhFNTRJenN6QzBPUHhJb21JU0IzaGxEUEFu?=
 =?utf-8?B?TDdleS9BbUhjQjdseElVYmVUQnhzMXJSdHlUMUVscFk1ZEZGYWZ5d0dWdW9G?=
 =?utf-8?B?RW55UmZjSndXN3FrU2xsQ0xyaUs4K0dIVXd6cTIxV2VYejhRZnhoRTBhMkt0?=
 =?utf-8?B?UlFETzd5OERmUlZ4a0N6VUoxQlVHS0QxVjhKSEpXcVlxTldzYjRnQWpseDVC?=
 =?utf-8?B?QklGUE4ycnV5c2JWK0N2YnozZWk4UnpRTmNMblQ3ZVBraCtGazdWTDFNUE5D?=
 =?utf-8?B?N3Q2SSt6c0cxZ05WOVMzdEhxSlc4SDZ3NUpaeExOOW9RWUtFNEFRdXpyYVRG?=
 =?utf-8?B?SE9laHVhMjZxcmx6N2F5VkV6Y2QybkYxSW9hS0VCb2JGcncwcWV1MG50Y2xN?=
 =?utf-8?B?OXMzK2dKaEUxMS8rWkxDczRRMGJQSzMrQzRKYlIvamM4c1g5NjNtNVVhT1FD?=
 =?utf-8?B?Wld5ZStIUkV1L0ExN0RMQ1Rid01HZStxaE8xNzZaUUhtK1hTcmNGeC9rR1gw?=
 =?utf-8?B?NnJ0ZVNVRm9OQUZuOXlPNTNHL09qenhXdXlaT2NsSVA2Yk5nSDVsZzRqQVd3?=
 =?utf-8?B?Y3JRNS9mUHZtL1pVK0tEbnpTV2pSeFA0MndFaXlUWXl6VFRlUG1QeG51enI4?=
 =?utf-8?B?Z2ZuQVBMaUZwY2xENnJrTGxKZFlqeUZ0VnVtenF2TjM3SnloRm9JL01YN0dH?=
 =?utf-8?B?b1JsWEdDOFVIaFNlM1gvMnB6R3dneXlTV0g5UUNvYmlqT05oaElWdHRmK1Jr?=
 =?utf-8?B?VmhPOU1pRlk4RXhPdmtNYUsxMm5mVitzUVR6Q3Y1WWxKV0puYjdvZkdXeGhE?=
 =?utf-8?B?SUhXeEtUNUVQZ2U1SUU3MG5mYURYdFppcWozaFp3NFc5aWVMUFJ1NDRYOWpY?=
 =?utf-8?B?Zkt3dlNaOWFUL3JNdWhpeWVPRTI5ZUhUMFl6aG5jZ0hJeGxtaUtoSmlMZk5z?=
 =?utf-8?B?WVRqOXQ4ZTYvZFFWOFN6RHJETWNQa01lN1FXbEpaSG5hMUtNRGptK2d5bnhX?=
 =?utf-8?B?NjlObzhTaEFqREdQaEFHbzNrWFdtQTBuci9NUVFMeWMxaXVpWHNJVHRMN2I1?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31433148-c320-4763-ccb2-08dbfa595df5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:56:33.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3E8TUPIHUlJmirBdFeWV8sjnovKQ7Ef946cMzlkz2Z8wTK5CtRCV2P8pDG80Ef0GZ20dD3iNpMc4UhV/6Ez3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 14:56:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14030

On 11.12.23 15:07, Gylstorff Quirin wrote:
> 
> 
> On 12/11/23 14:45, Jan Kiszka wrote:
>> On 11.12.23 13:19, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>>> element is added to the sw-description to replace the ebg.
>>>
>>> Use python as newlines are part of the sw-description syntax an
>>> therefore cannot be hold in a bitbake variable, see note in[1].
>>>
>>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>>> support atomic writes or renames so a powercut can still corrupt the
>>> system[1].
>>
>> "system[2]".
>>
>> But you are not implementing option B described there, just the even
>> more risky option C. Doing flushes before the renaming and after it
>> should reduce - though not eliminate - the corruption window.
> 
> swupdate installs files the property `atomic-install` with option B
> 
> copy file to tmp path:
> https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L185
> 
> fsync
> https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L222
> 
> rename
> https://github.com/sbabic/swupdate/blob/37d13dc2eef557f9bbd10a85ddfc7ba4384740fb/handlers/raw_handler.c#L233
> 
> If this is unclear a will add some additional comment to the patch.
> 

Ah, that would be good.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


