Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5EAC88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 11:56:54 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18246.1789387009662307042
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 04:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=weAvJVmq;
 spf=pass (domain: siemens.com, ip: 52.101.83.64, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyBZXGoO2PuETIpMbk5vOF/gs12uMbA0vg9Lw51KozNNAc/TFaKBEMh23Xybqx7yWxy35AqTNn2IoTjNUhK6uMIk38TsCLSQWSbIjkrnXfHkOaKeqfvp1u1EBpxOz5lvcNIVmqgyIjTOZTlwyPlwkKm0BRR796YQ9vsdwXfLw23tAIDmKMtIg4WnrMoe6h6Qiqc7Y3oADTDXdidvbA5459QJ6ezJ9cabt9zD7PfCdR9cr1othK9i5PRLRxBQBF100CkvOiCZCYoxUubxRu+bbqR/kBuvBsloYC4AsWCk6KntLQ8mq43OTsURS3ABLrGByhllecE6olpDRLR3ZVNQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EttshAP96n/D8ZF1V0pJ59jKKUkLpsNR6VwvehVSCf4=;
 b=C7iBv4kJWjtq8uuSSoriqgMlIGAqQnaZsG3BarCYwYF3KLjlGYvCHCP1EafOCJX1lnRvcoLb1EtMtBSd77vXPXWVhZjLy0K1R1uVddTx9Gib/mGxglXxhHQX/0IsW9/gqUpf2A0Kll3dthkvaNayYUSRy32gChWc1c0y33h0yzaOABUzhauXb4uayIT+KPl6I8sOJGa/VOt21dNl2T6pE2qmXDIteeDb2P76U0JYMX831Ai64X5ZbP9eUoXfMi/BDHYifmgY6Cm1tTeN4lw+IXD9tJ79JxiCDZj/bDIZUY47wR83Bi10wPLu/7IO/6CywItQ6syxaLbOSMV0aeH/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EttshAP96n/D8ZF1V0pJ59jKKUkLpsNR6VwvehVSCf4=;
 b=weAvJVmq4WFQ4oaHshCnPk4eHiKEDxUjRUGuXR1OOFhmcTQ0iy6Je0jGwTNlVsEnFMBlTcoZmE6rKMdAhr2Y9owQrFTkkekAg+K4XCaMgwcGlhUVZAaZFbon+vVd+tnh7OX9gc4ztDdijjwRtfY6ZY+DRvQ0BO8ABT21hVGhnrMQThSXLRap2tM7AVImkeZlscBVdIkxUs4ZoxBgctqKR9O7KYkLmgJVwwxiLQn6Yc2356TWSF2OLLOdygVeTUtMPsKc7ERT4dsKmQGJ+okpVjnvJdt46Q5++VdEaaJvuSlK9O1CbatBr75L24+Ed7L9cEpFfTHHMgDN1YZNbmDmYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAXSPRMB0039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:56:43 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:56:43 +0000
Message-ID: <56556171-da4f-45e8-b52d-af82ba8ac985@siemens.com>
Date: Mon, 14 Sep 2026 13:56:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 04/12] Add cip-cis-rules-config
 to configure the hardening according to CIS
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, clara.kowalsky@siemens.com,
 christoph.steiger@siemens.com, dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-5-quirin.gylstorff@siemens.com>
 <8f436767-7dfc-4281-8df3-9cea9bac29a8@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <8f436767-7dfc-4281-8df3-9cea9bac29a8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAXSPRMB0039:EE_
X-MS-Office365-Filtering-Correlation-Id: 820f4809-0960-4a0d-5497-08df12573db0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|55112099003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	bHpqTHqnTSeREykKxjnMOTo0Iy5+Xm40AGVnzGJkELX3D/BxNThMVp0ZurFGLAplhP+FN25VijQHQkBw2aBwpbZ3OFiU5AVsU3TksM4sQFn91goZnxjyD/vJEY2jx55IqHTmB9cegsrGtoyN/7uQ99JfjE+39HsrKp2tuU9pf93bKUINEdzzoLqC3uo8fcTj381SyZei4Q4Ao87kGuUqCpm7w+gvWTR360HiwWqVdPTI/hlBcG5/rn6DNBprP/5XUy2ZEiq5+s9blefJotx1OTbNoHgrG23D1ElyRzcnL7q9122R7i0lUlL9SDbkvKlPMnLz9JQcRZY99tJuMGuZSqNrxoQ/TRQBfgLQExbC8aOhJQPXmrYAEVKSR2i/aAEJfr9kTMxpLOf10QI/qEp84l0ugLEKHydJUhiVKi/t+LSTYT2ETIp420eDeLiMP3semgUIBZvS94PzGLTCyKtFGxBCejNnQ7t9mVmRAl+UQrBHnXwDtCUXSOnmdcifhHNyomK9Pf0jym7hPKAXtl2yRE1ghzzutuWjhrS6jovL25XcBylgEVpz74JYPCTDpcvPjFgE9wUB9fVolr3d2W8qxtpb7Afcht7oDcEugoW5YhssPbbYPT1h+aG1jhraoLJ5rv0bycv8oT/8SbIVjObfkAGn8aUjhOH0EAgvvir9fLg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(55112099003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjZDTy80Y0lvQnZsRHpld2NCdlovVWE0bkhYcUZBWHcrbUlPWGp1T0dNK2kx?=
 =?utf-8?B?R2xmYXhmTUxaeVJ5bDVqS1hPUzZ0NlVJOTNZSk55MlFiQ3YxbVJBQmMwQWxL?=
 =?utf-8?B?MVhPNlU5a0hMb01rSU04V2F2bnN4SVFIeFh1S0NQZkg0RjVRc3k4RWtSZ2tJ?=
 =?utf-8?B?T05XOVVxckgyYmxvcHFTVTBBS3ZyakFXT0toQ0VOZUtJeVoyQmptUVY0SkFa?=
 =?utf-8?B?U2UrVXdjK01reXVxV0d0ZUR4aXROVXZlWU5KdkNIVEs0Q3pIWm9PRTE5eUhD?=
 =?utf-8?B?K2dCR20yeEh3ZEQwUzRqT3BKcFZFTDcyRVdOMWp1ZFFQVlBJT212ZDBnam11?=
 =?utf-8?B?K3YzSlp5RDF3bGV4dFMwTDd2ck03OWNIVC9pT2hwWTFQSmorUk8yWTZEUjNP?=
 =?utf-8?B?akk5d2UvQkx5aEQ1WjFoMzdnT1lYaHNUbHVSYnIxYVJoV3hOYnVYWjlmdlE4?=
 =?utf-8?B?d2ZYQzdQNjRYbWd1LytpMW5oRkFxMGFSakVXU0Q0bU1lc1FFNHFxK1hEc2JB?=
 =?utf-8?B?MTdTLzVZRHZoakdORmNsaXo3eXFMWGU0LytHaEV0VDFKMU54MzNtNTJqNHUr?=
 =?utf-8?B?cWJzS1NsQVMwem5OUjlaS1hyeHpSUVBoN21JVFRhalNydTBMWVFXRWNtQ1h5?=
 =?utf-8?B?OTdjTnVHWjJ1QlBBZHZQQnZlMGZ3Tm4yTEpoSFY4ZGtmL1Vjd0g5MXBJbkR6?=
 =?utf-8?B?YXNMQjlZakZGUGdvMHJQS2ZKM2cwKzJYNzRlS1g0ei8rTS9rVlJKVWNoaVpo?=
 =?utf-8?B?dUNjMnkrdnlYZlY2bkV3QURtSVRWV3h4VWsvUHFiMnhhaDg1T09jNWJuOVBw?=
 =?utf-8?B?cVREMHJ2dmdURE5ESlVaVTBmV3lJREpJT01adHl6a0hZQ3dCVjlCZ1RJWGV0?=
 =?utf-8?B?R3U4RFhiYlRPRXRKeHJLQU1odDRtVGJyejd5NVFYbXl0YkFlSXhFNUIxeGFJ?=
 =?utf-8?B?ZlAzd2ZYdlpLaXBKdjVzUlVIU29KMWRRdmpDclJML29jeUt3MjA0clZhSlZG?=
 =?utf-8?B?QWdUT1htQ1dYbzR3eTllWkd6cVphTHFnL2ErMXZMZGNocDg3MmN6OU5TckI3?=
 =?utf-8?B?R0pGR3hKdVU4VGZaS1VQc1cyTWpOalFTLzMvVUxkalo1TE5sdlVVREZTOEEr?=
 =?utf-8?B?Q0RMUWhSM3hhUm1uUWt2MVZyNGcxNStmbDczZEwzU09VNXg3d1BSdEl3UXNT?=
 =?utf-8?B?bkUrYzRCN2gwTGllZ3RtOGZ2UHB1aGZ0d2RYV2h6MTU4dWROdldvZDMxSWJT?=
 =?utf-8?B?alNETW5vRmR1U2I0WTVMMkJpU3RwaFI5YnNjVDZ1MkFoc0tZL2s1bkdIWXp5?=
 =?utf-8?B?cHV3RjRHbStlL2ZxT1pjVHJLQUhFckJBMkd1Ym5OazVvekVxN1VZU3lhVjBI?=
 =?utf-8?B?SEJaWHBLTTdYUjVreW0ram9YVExXUjZKSUJDQkRuaEk0V0VXQ01xSEdlTWd1?=
 =?utf-8?B?V1dzNW1lYVk3YjRhVkJDUjh1OWlaem9nT1lzTlgvZ0pHOTRJT2o2N1Y5NkV0?=
 =?utf-8?B?L25ValBScUFTZXYvVnpBOUFkeHdOdWV2clhYbkswUjArdzFONWNBRW9tR3dM?=
 =?utf-8?B?bmRpS0UxQlYxS0hZZEJNSFdnVGJPZFB0R25WcVZjQ0NMSmdkemsxNXpqaGhi?=
 =?utf-8?B?SWxNS0RRb0k4VmFOa2NFbDVyRVljTHhwZGEzUnFyVFlKeERHTEJIZTVHbUJh?=
 =?utf-8?B?aTU4SFF4RmFkMVBmWTVmd09EMXdSVnhPYlk5WURWbTRZMHZwWTZHLzdEMlpT?=
 =?utf-8?B?YWw2dCtwN0ZFL0FkMWVDM3VTczh2TUlRUUtGUWFreFNPcnNJWmg1N1pYYnFi?=
 =?utf-8?B?cGZjMGtUWXppYUgxZEQvaXN0NGNncWdUVHpMeVRabzVjYm5qNWYyWDJHc3BL?=
 =?utf-8?B?Snc0STZNOFM2RzdZY3p4NlcvWEsvS1UvR093ZTlheE9vbC9iYU40WktaQ0do?=
 =?utf-8?B?VDE3dUxDNjJ6TXEzZUxYTmRCeFFFdnV6VEh2ZndjUnFtUnFBVXBka0t1akMz?=
 =?utf-8?B?TzBadjhwMURLMzd6aURhTjNzcStXSm0yK05IQUFUUUQxa3pLT09FYlJibTMz?=
 =?utf-8?B?eWQvbHRtR0psdjFkYU5oSnY3NVhITzRMdERqTXMvYlZJVCtzNjBwRDFRM1dX?=
 =?utf-8?B?Vm1kNjlTY2NxMW9QOWJXSkd4QUYyNlVxNkduQnZoZGgyZlpjTERBOWhKSTVm?=
 =?utf-8?B?dXd5RFFjeGI4dkdlOUtGYkc3ZlFuaVFicjNKV0h5b0N4WUhadTR3ZUNnU2dO?=
 =?utf-8?B?NHorKzl4cXZWaFVvSzBja2psNENHVUsyeEVXb3dSSzZiYXVKalVKYUQyREpa?=
 =?utf-8?B?MTdITUQzdHVnQzlZci9YbTF4WWUzbnBvNmQwWU8wVjFZSnVGK0lOWERmc016?=
 =?utf-8?Q?WBnKl0+U22KVk6ys=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f4809-0960-4a0d-5497-08df12573db0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:56:43.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0smxVFiFSHmih3ewT/AmzS50ZiIXGqLA811kf+0ZgaHGxUahAkt18BP2pPNGjhR+A8NR2zj0GeAzP7Z8ube9FQ9o5jcMo9LiLIJRyNHFv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXSPRMB0039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 11:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24171



On 8/25/26 6:54 PM, Jan Kiszka wrote:
> On 24.08.26 11:46, Quirin Gylstorff wrote:
>> The `cip-cis-rules-config` recipe allows to create a use-case specific
>> hardening configuration based on the CIS hardening rules.
>>
>> To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
>> can be used to generate the hardening config interactively.
>>
>> After the package build the generated config can be found at
>> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.
>>
>> The package also provides a kernel config snippet
>> `${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
>> to apply kernel hardening during compile instead of a runtime
>> configuration. If the user changes the config.json all followup jobs are
>> tainted. The code for this is from
>> https://github.com/yoctoproject/poky/blob/077627338ac18aeca34bfe0c52777fab38e2e0c0/meta/classes-recipe/cml1.bbclass#L37 .
>>
>> This packages generates the Kconfig out of cis-debian.
>>
> 
> And it needs some extra deps on the host side, doesn't it? kconfiglib,
> newt. This needs to be documented and possibly and/or reported clearly
> when invoking. Make sure to also test without kas against a clean Debian
> base image that only has the Isar deps installed.
> 

No it does not require kconfiglib, newt on the host side - We use a 
modified devshell to install necessary dependencies and execute the menu 
config.

I will test it with the base image to be sure.

Quirin
> Jan
> 


