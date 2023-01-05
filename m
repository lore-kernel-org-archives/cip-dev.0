Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B46C3DA7A
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 16:45:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.82])
 by mx.groups.io with SMTP id smtpd.web10.17849.1672937150736746027
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jan 2023 08:45:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BxAUdKPB;
 spf=pass (domain: siemens.com, ip: 40.107.8.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxdiECc3nrsaAYgBMQXFpirNDAYwzDbV2wpCrqdv81C554nzH7qW+Iyr5DIod0AN1yhyFlyovjfideRKRO8OiYbo2MrWXWxLlwSLdwfSLsJ61mfMrqIzGr7pGBaMYwYpChZKisp/nJTlRyii7KQ7Ujadrup8Ekf61JkT2avh0htJc+Vip4y+35xw0ROKGxi5lijwZsRiSNOSN0BtYNLVQoQlFvYhwNjrpVluZgu6/EECBgzThJt5yh1Ib60tQY/PvAf6iS5pNQow0X9dGJotDpDTrNgPE/roqODwlwnStaYMnpFj/xUNEOavm37qCzOL/diVz7Donj3QtKbzraAXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwgdZhxVEx1hx+n+h2SJl04764Phfg3OKb3nQI/dEyg=;
 b=W5l/Kc3daVSCSZnLm/RXwDDJOamxqF3Okbf8xigUx1YLuh2gl+7kxS2CTES61GZ8wkLyX6xI3I3g1EE9geR1eLpp8SLqUF83+38A3KxSKCVSGf7pCdgFOnAFCUImJcDo3IhUwB4DDirU1lA/aKcvvXJZDNrTILurTdXAGGvntCyKvTZV7nRnvRv6r2zGd82zQ3KRT7+pJGs2Qki9xNo/U0DAG2sRPh/TO9z2YJVK1GKVNsDnhB8LCrgfstUonlwPEyWU+A9ClXxcqd5UsVQk5RwUlTfLHz4jDXpF499pU7+s48Ut6h+0JqhDRAY1HIGNDAS7EasvBEZ537Af9pKsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwgdZhxVEx1hx+n+h2SJl04764Phfg3OKb3nQI/dEyg=;
 b=BxAUdKPBxA1vINvOozILOSoSIf+ANNBnrM4am7mxSZaA+JDqSfX95iAKnHi/OCKTLrG2FvTePd0MnY+DV/YFLJSlC8+5tJZ8Wc9NaeEO/edkF5vkd7na7hr5ALmh4UMp4ZQ+cgGwQdS1pBZxdIMpfYsswL+Z/S8rJHcEJvTjoI3kGLDFwLxzggP+H7zYAZxNVxu4u3sgvYIvSLAR6CA2A+OzgrMNb9mMadiLasfhZzaP0Il3MRSfH8mucIP0w+hOV80cW0bMPRUP9ZPV4hBAGpMh1lVf3O32ssmRoDZalZh1F8+1/2hOWjZ0yD4qAvbgSKDBxczkkdVWM4aDkXIOtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:303::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:45:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:45:47 +0000
Message-ID: <ad475583-af1c-c0eb-b90b-50496c375d63@siemens.com>
Date: Thu, 5 Jan 2023 17:45:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core] security.yml: Add root user credentials in
 security kas file
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, venkata.pyla@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20230105150242.21236-1-venkata.pyla@toshiba-tsip.com>
 <20230105173359.731cfc51@md1za8fc.ad001.siemens.net>
 <20230105173710.11c19271@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230105173710.11c19271@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f671609-ff0e-48d3-4aaf-08daef3c4ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UeX0xblCIE4CMUqf78PjaXprYakzpHD0QFsKJ5enNs/oOEiGRGOjbpbm77l1VWMJiY+HpVEVix8BXIFraanKwzlpM+ulA0THtSbbjerKLTqldZIKzLhfzhED/yb6rXwIEtqqiqcORttR/w0QJkoFYaeGFLkfmnmGLcsNHIW8IXd4pRco8TJICnVID7mH3tvh4HDP/IQH8YpfIDL8kiijOiPBRI27cgTdqjoWzXE4si1KlFPwu1UZ8znotduBPEyIeQQBZz/tZsqy6yBmT2Uyd+YKV2sQYnTF4JfINDkLjXq9nIRheO8Z1ujmLJr+6EXTVEPOMrn+3furq63OUFPrxiTjiwdzZPkEtZXZXrgwc6tt/GQS3VmcpaC10X1RhVZf6pflTr/u1rIKkXW+jF3yXJM29mICtb6mCwB18efVqLkwCQ1ukhsVLYYdz12fqFpCjd09kGA+kOqCAY1IsB9ZNBeNco8pczxXOWf9z4Ag2Qx5dZ8/MMzAwf+CCa1rLv2fDjodSXb3zwQmdeh1BHCSqFtAH4XTbnpRcTZgNPpmxbVCiFIJhTupw3tRTGxbVX4X1fDYs8ZG6fBzQWr0KSW0lcxDnVxn9KmRvatPrOn61iaMncrskoX6N0vVAQUihqvmsoGNltX3yEHRFFQLZZbcc0G7fMwKUEb9Ncng42PkCeWZsbB8W2Ji1vc9j1QXEsyMFwyZyOXzh+BIF/gM6TtaGvLu995qbU8SEvEVOMVDlEQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(186003)(26005)(6512007)(53546011)(2616005)(83380400001)(6506007)(6666004)(31696002)(36756003)(86362001)(38100700002)(82960400001)(8676002)(4326008)(41300700001)(15650500001)(31686004)(2906002)(5660300002)(8936002)(44832011)(6486002)(478600001)(66556008)(66946007)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?akNZdjlPSmpXZzBIS2RrWkRrelNQaWhBUGxWcEs1dDNEYnNKOHVzajFXR21s?=
 =?utf-8?B?dmhabm1BTEJtckxBSnpZdHFrbjl1UmV1UnZIVWs0RDJyZU9xaDllTlVkcGF6?=
 =?utf-8?B?SE1ySFp6eFR4T3cyUzlOVTBzSDBoREpTU1M0cVpZS3RJWXludmMzRE5SWHVs?=
 =?utf-8?B?OGJlZWJIaXAvMXRUTm81MkVCQW0rWlI2VXZMY2lUSEgyOUhLZ2FOeWNBZGpZ?=
 =?utf-8?B?SkJVU2lweXFPM0R1ZlF0UTFuRmVKd051RTNzNTFEUGgyR1VqZVJaSUdkeld6?=
 =?utf-8?B?Y1dLRUxvOVVGdzNDd25uek5zS0RFcFNHY3dWaEtKN1JmbEI4blZhTFhiWDYz?=
 =?utf-8?B?OEhjUDI3REc1aHBSRW5wMTVURjJQWVljb2MzdEFkUmVxTjdBLzJNQmY3TUhi?=
 =?utf-8?B?NmZwRTduNTVJM3Rnek9qMk5iV1pQTUtQN0RnQ05qNEMyOW0yTlNLanhVNTNF?=
 =?utf-8?B?YlBaaTVPcnlSUnUyTU9aeUZEbmFId3gwVlB6U1djcVdBZWpnK3BBbVdmYmFL?=
 =?utf-8?B?Q01BbVNYYUY1TmpjLytDTkZCYkpmQ2ZEajVkWmVhamZPZDNmdDkyK1JndUQ3?=
 =?utf-8?B?ZjdaODBYU2d2ZGJ6dytXUmhoeDVBckYwdUwzaUJUZVBXeTM3eW9yVkJRMUd6?=
 =?utf-8?B?eXFwVEI4ZDhneHQ3aGJWSWtqOWNSeHE4TnErazJUWjdjOHkvSHBLc3Fad21r?=
 =?utf-8?B?TTZnR1BGRlVzMWhxeW00bk9kWFk1YU5BaVRnSTBIS1MzWEM2RzYyNnNHR1k4?=
 =?utf-8?B?VTEyS1RsK2FZTDhSMFVWYU1DZTRPQWFWQ1AxM2xNRGthM2dWelVaY1Rqemtu?=
 =?utf-8?B?UEdULzlObHFNY1pQdG1SekdDL29UKzFaMTBTazZINU9TR1hCRDZHcE5pVkhl?=
 =?utf-8?B?MXJja05EbjFRN2Z2b0Q3ekNOYmhNZWRqZG1wYjNhcWY3ekIvdWxqdml4alk2?=
 =?utf-8?B?Mm1mVVp4WTI5NnJvNm9YeWh1SG5yb0hIc01SZUpRQ3ZRZ2lGSHpWRzJQaEQ1?=
 =?utf-8?B?RThzSTdibmZtRmc2azU3NXlONzUrTXp1UTBSWVJLM2FIZE5Fc0I4V29aWHdh?=
 =?utf-8?B?bytibzNrOXlsTTJENUQ5bEJodTkwY25qWnQvaUZIbUlNbjJRblNVcmwzaDdX?=
 =?utf-8?B?N3ZOa3cyMHRsZzRCdkplbmN5bDhYQmUzUEExTnJiTWo0d2FQNE44RDBqNi84?=
 =?utf-8?B?ek9tT25yOHY4Mk1QWTlPSkk2NXgwbjN0WjNOQmh6Y0pxdzlaaXJGLzBZMnhp?=
 =?utf-8?B?MzJxQkpVbUg1R0JOa0pSOVcybGFIWHE0anhDQWdwQVBsLzBId1R1dkZuU1VH?=
 =?utf-8?B?STNyYWRhc1daOGhBUU9IUkV6S0E3SUxXUTdkV2o2OFNPWHhNN0NoYnRmYTJj?=
 =?utf-8?B?aXA0YTBWMnRTMkxSc0ZOajNnS3dWWjNmOWRhcUdaZ29sT1g0NUZIZ1BjbkJR?=
 =?utf-8?B?K2Y3TDBvb0kxMm5PT3FDL2dMcEppR3dpUkRMNVUwbEkwNjJkZ1pUMlYrSXJG?=
 =?utf-8?B?Nm05THd1UkhmRjg1RENoelROM2VqWEJtSW13V2FYUmJSVUViUEFPSThVRU1Y?=
 =?utf-8?B?UTJyMmQwNEJ2U29EcC8zaFBFZTlkenI1MERkM3ZpbHM0UG1JUHRqeEluTWlq?=
 =?utf-8?B?NC9oOFFvbWdkN0FCTzdyay8zcnpUa3EvcTNKSTNPQ3NDOW9DUFBGVGhZWXAy?=
 =?utf-8?B?RytkM2dQV3Y5RURPd29PTXdaNXdFamZqMnF1SXIzZzRWcXlsQm8wVmVJOFpp?=
 =?utf-8?B?NXByL2ZxNk9jbWNQZUN3ZVhKNUFlQnkzZW53bmlQNlNha3RjUVdoaWNPSUpn?=
 =?utf-8?B?WjUvaExyOUhUQVkrc3YyeVpaMGZjK29nOU8xV3ZDMXhmUjExVE80emZDcDhX?=
 =?utf-8?B?TStjK3NBTWt4dUFrdG92MC9EYzBBb3ZNM0dPdUZYVzdlR1FRWmFKTnEwQU1Q?=
 =?utf-8?B?Mm5pWGFyakNHbkY4MWFFRjRidDE5aXlodjVRcTVBd1BJY2ZZQ001cjM5RDAy?=
 =?utf-8?B?eU93SjFGbkhBL3hqQmg1SktnbWVEV1h5ajFiV3FVWUxkaUQ4ZXR1WEpsTzV6?=
 =?utf-8?B?Q01Ib2psRXZBKzdzZmJKV2dGZXV2M0wyUDI5a1VEeDROcDRlQjlNSllOdlZN?=
 =?utf-8?B?V2hESGtiRXlwL05WcHdRbUhJQUFvRGV3S0pDUS92aEhzdmNaZ1hYVU1TZlJo?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f671609-ff0e-48d3-4aaf-08daef3c4ba4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:45:47.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHzDix/+zF7OxxwlahHONzuVhSWSPj9BIz00VKpPZtqxOVB0OSLb+sM+1Dt6AL5pxBGg/klPtzuXgFydc1jtcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 16:45:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10325

On 05.01.23 17:37, Henning Schild wrote:
> Am Thu, 5 Jan 2023 17:33:59 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> Am Thu,  5 Jan 2023 20:32:42 +0530
>> schrieb venkata.pyla@toshiba-tsip.com:
>>
>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>
>>> Security image creation imposes a rule to have strong password in
>>> user accounts and that should not affect the normal image user
>>> account settings, so overwriting user account settings in security
>>> kas file as required for security image.
>>>
>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>> ---
>>>  kas/opt/security.yml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
>>> index 4e74a9c..c385a62 100644
>>> --- a/kas/opt/security.yml
>>> +++ b/kas/opt/security.yml
>>> @@ -12,3 +12,9 @@ header:
>>>    version: 12
>>>  
>>>  target: cip-core-image-security
>>> +
>>> +local_conf_header:
>>> +  root_password: |
>>> +    USERS += "root"
>>> +    USER_root[password] = "Cipsecurity@123"  
>>
>> This looks like a pretty hefty interface change and should maybe be
>> documented somewhere. Note that we should use that variable in
>> recipes-core/security-customizations/files/postinst when appending to
>> /etc/issue ... or the value ;)
> 
> And in fact we will need two packages coming out of that one recipe if
> we use different passwords in different images. Building two image in
> the same tree would likely cause false sharing and whoever build the
> package first wins.

We don't build two images in CIP. This kas config snippet simply
overrides the one from kas-cip.yml when appending it.

In the end, both passwords are for demonstration purposes only, obviously.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


