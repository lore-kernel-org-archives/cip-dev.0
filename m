Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC78CCA476
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 08:51:37 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.41])
 by mx.groups.io with SMTP id smtpd.web11.38865.1760345484247793066
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Oct 2025 01:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CNJHPWyU;
 spf=pass (domain: siemens.com, ip: 40.107.130.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZKE7gDaSEd+daTBiqFocslYPMPYkASNrVYrC+WdHcLw9HllZxQM6pgrwK6KSvtWwf/F5i5tzAzlNtB75ptqw25cbCvbVx2mJDWrF/aJn8t4Aj9Rqm6DtgAHEZ9MtbBVDWSVnwppKxewBln8y3m2IE2oNDmb3s+MrwkNyICt3vGeLhWs6JOs42bLuMZq5lQ0BgKeQPj/bSjaaHQeC7IrQCpuz3StLO0bKMgKbi3+jLf32968qJ61o/jk1S3A6guDnr/orBV7+sYS2L0+h2Y/xciWO2KDLS+VFhJv6HMctC8Kwgq5Uoevz58a7r901Fi5524JJh0Fqu1U9vM24cG9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mLRlRtEvzsWke5gjuumS8JnY2nCrbx9IkqoEGaS+N8=;
 b=ZcNVENw+dfVfv0NMK52nuHH+x4s5x2l5G22FE8V6w3Xs4G1lTh8MNZ4yWAwN4eYgUUMXPRzpL4HNcNMdD+klxQMpVh6OZL+8jupBTNkRbCS7v71+LuIgaDZnzDxZrHOZA5ldRlF31xc9ImHTHAOnKzvyuDdl1N+5jFf3E3AV6DV+8FjxcpHFyiXR/iz2tlLCoHyAcckXAYKjsOiZS24BONGuRIrdKZh4x6PwaZOcHsQyhK6g6S8U0iwqH+/yFx2TVGxgFrbI7cOISlfu05u+HgZUMxKBAMDljwy3JF3y+yFLdwtGSKA5GxfC4pnzKOkAzsFrDJKAFVHo2SxLRN1nuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mLRlRtEvzsWke5gjuumS8JnY2nCrbx9IkqoEGaS+N8=;
 b=CNJHPWyUvoLuGo0eOqoQ3q/bo9yTDW3BM3y5/asGD6kxpGaj15cY+la2a9j1t4URHz1pM4kHMxwVLK7rrxSxaU7aWHR7cov0f8CFc/CwpWxWtynnRwbbScFFNw//MxwNAB4YIEGUVoQawsTQZIrKHuaBeZmlmbOPCbEumoITy8rX2KyIWDe9REnRCu0IwadHp6dPvSxpk22hXkwL4LFypckM3F0qkY6Ua1fMtNa/HVDyy1d4NSPEbNOgsqG0E71uqHGGw7F0pwUjPDnkxlMdGTqEX1xIo5xfh3b2cdrA/d1dEyz5M6pUP7tr5x9ptLz2GpB5prGsxMOxzSlV/iUxeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by GV1PR10MB8495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:51:20 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:51:20 +0000
Message-ID: <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
Date: Mon, 13 Oct 2025 10:51:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|GV1PR10MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 118b49c5-aa05-4f55-e2be-08de0a35adff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a1wwD/loSiT1e2kSwDQzM1BZXzfsH6wWm5tSU1Wf81IuqnxCGCMBRl6la9mg?=
 =?us-ascii?Q?s7pmM/w2Of1xur02g7BMim7plaJQiJqWeKArdUL987Z62KdJuvnEVB4fnKom?=
 =?us-ascii?Q?G539DRkFTiifZ2dAiD81q36wJ8tfkpiyBKCQYUr8G3vYggMs2yotylCOC1V4?=
 =?us-ascii?Q?2S9fKm040vrg2sidB3yfFdRzr7Z3SrJ6NKDxTNABkBDrPhIwXKUIZzICRhjB?=
 =?us-ascii?Q?ExK0pav2Vp5CwgSw01RGevKDDoPa3yjsMcbxfGEVEdrP3+UZRUWvIuu3DpoZ?=
 =?us-ascii?Q?MeJfvHqL6gQGMD0dNh3dFxpmu+7x9SSz1EQmtQ81UHk6q/bK18IpcMe0DC2F?=
 =?us-ascii?Q?hbsGEVDVIiTVb3hO3sECsLz6y/WO2t523KC+Yzedk1l97BWtiWbS4aqJUOV1?=
 =?us-ascii?Q?QCbs7HjbLwZgVL6S5LRQCgoJbKg9fWRZk8PIpbaMacGcfPmHO2c1U7JiS800?=
 =?us-ascii?Q?3+Y/xehfWAC1swAakKe2h4ZeAjeoj6Lewotko869MR81kY2SmtaoABUPJx2I?=
 =?us-ascii?Q?QH5nzPC2H9jELDqPHsOaGf5JuMwbLh7rstqC/mIXXvmENmNTkOQpnYZVeJGu?=
 =?us-ascii?Q?yKNqDfXXUKVZul/iKzU5ktl5OjbyeN5iUeEXAcMd6Zb7sQnjMtf77oPwKImO?=
 =?us-ascii?Q?PTTjraXQ/5hEYLLKsNgr4SVGE8jqsoqzYbaLYhTsUJk7zxaKkFow5Y7fZKg3?=
 =?us-ascii?Q?NGLN73o6qM6gg/WCaroR5B0lCUji8N84UdhnPwKtJxjQuwAp+2adW5LfrdIg?=
 =?us-ascii?Q?mtYmy8VOl1X1Tk89ZsN+fMRtKDRn7E8qSgyAdeIKUh0gUFpvS7mJErM8y9V8?=
 =?us-ascii?Q?O0nqWuL729cQ1+BW1cSLTEh9kTsNTpkGo7WwKUmYqFFwWWeMk8lKc9a9YO4d?=
 =?us-ascii?Q?wuA4hj2VTpiAIEw9h86o0WGNEFODVTYgpuAV/Vt6hNAfiHZtvdyrMQuxCaRy?=
 =?us-ascii?Q?gKi9CROMY4Tzib6+9d6V8VTv7pv5vB9QyyBOGByswkQyraeXnnZHiTEUBrFM?=
 =?us-ascii?Q?GPpc4MHm7VzQ9V3Go7rhZL4dIz0HN2zQhWd1J5sGkUXS5Y88fEkrmICgc/wL?=
 =?us-ascii?Q?5Q1C75DSU0GYyzyDuE5M1jWzUqg+9vCMkeETsDIMx288UuCikAuL5X4Pz1ij?=
 =?us-ascii?Q?JKQAZK/4blXQr1Ul+/QFHNjVOOLTLPGnpFp9Qhf2BidPpcI5Fhw7pmhqpPge?=
 =?us-ascii?Q?ic/gG2bZibOxdxscixk3jihvwfqA+2roTWXL5FjtkbEA29qQK+9xpiyhnP8n?=
 =?us-ascii?Q?guInP1eazHHkm/UaZL9Ig7gDRirmFLFT4U+a62I01HJiCAioPWGLyE+l0yhK?=
 =?us-ascii?Q?WVQsc8sRpGyOjejtNHpkqYTwOEZ1Qu3j/1sRK5XwZ3/DnpLLj9bA8ppHyJa2?=
 =?us-ascii?Q?My3uKw+wRAwhuaUvY6qAQBW/ptscEtdqFC9PTU9mJKfYva4nPQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bp6etZJG1+sNZBMFbwB4WewZrW1S8Nxw1xo/YgFp/ATpQ/HDjX1JkTuOvuuY?=
 =?us-ascii?Q?fyed53cNh0Kmt72A6oeT0NBey7ynVyf7+I4lpN0iuikYdE+kRreFzwz6jEoA?=
 =?us-ascii?Q?6GtGRfKW+ex1THD9jq1Y3HVp4OjhuWqpaf6vlVYxDNpdNo1LYULdf2L+Snfx?=
 =?us-ascii?Q?8OLDOmZc2gJDe1qYtAyvY1bJIHxqwMevZMZW6yW3unEby5Zp99kTRS4bhed5?=
 =?us-ascii?Q?V7QVY9iUiOtY8AyfnetIsjfpF1n/cmyAQNLEdBjPaFWBMqFHBiN4031gKI0j?=
 =?us-ascii?Q?/mHZNYbNd1n9rvf22kvZBQMfsIuMyY2PYIfAP869GrhNuHaZYQFOPN5zkGYP?=
 =?us-ascii?Q?YgOeeFrwA+5+nSNIAh6i4QLU74xTdUFHiIpd5Pg9FLZO501EqBe2FLsa/1SA?=
 =?us-ascii?Q?ZDKoQZMVmmpdIpXeK8Coqy3o/X5t6r7pYfaoIXSiz/416oXm+VH+3zSqcjCQ?=
 =?us-ascii?Q?eJuOonHt4HC5+dZAvgJ93mGKAma3qdy7uVMYORgBvwX/gJF+3vCrjPdSekkc?=
 =?us-ascii?Q?gkUYfJAgUTJXPWh/nNc8Mkf+0toAwm+/n49tc+p8k/jBH0y5Yf1IOpxRZk0O?=
 =?us-ascii?Q?VwMaTNinmlKKtBcaxwniuo/tq8/8QDyPmcgqgm53kLxWlNlmMjuirDH6xd05?=
 =?us-ascii?Q?szPoQ3+hiSciYWRDYnU9XoEZJ9IEYuCa5iW7ar50XF6N81UuZ0pNbcuMmKkE?=
 =?us-ascii?Q?yKctw9tRNN0GDUkAFtI/qYkFlpjE76+l4d5cQ/GqcLUwY7kwT/NNNqm7Im/q?=
 =?us-ascii?Q?iqVPkVlFytcbcWMo4OTH2oKisuY7HBhJXv01luRSKWjyEqVh7b/WUCT1eWIL?=
 =?us-ascii?Q?paiLNJIjs3aQFJ0aqv7LTgLK3Vu9YjxV7EDVrTD6KbXmpM8R1bwlgoPSLL74?=
 =?us-ascii?Q?iUhzau6wuvnJT34IPdIW1zImdy6MjDhJy1x6xVuzxvMfaSjOBx4FjEQU+CKY?=
 =?us-ascii?Q?jm51U6TxTzH95CiLTHMSPXpUTxYycQ4Dp4yBWAO9OMtMbHrsj2XMSrq5f0j2?=
 =?us-ascii?Q?GjWkaCWpCFy1l6XbcuVu6SSB2Etx5+AYSc75kNdq40H/99Y7idHiFHVEcdyh?=
 =?us-ascii?Q?X9zuAMw/rKHXiAQcij24Ufc5LrmVB+5VlK0Uw8qyh4zRSCeNlo2hcZflraxw?=
 =?us-ascii?Q?GWjLVYFL8TZ4NRDiwZ59DvY8kJo9BA0UkCxLtpuzjFrT4SOMSjbExwsc/EXm?=
 =?us-ascii?Q?jqbNFVMgcxfsk4UNJMyY/z81WdzOq20S4jzekxmSmks5jaxpPlck81xmJpW+?=
 =?us-ascii?Q?FMlAdUag8aIt1cnTi2wFRxNoQdOf2dHW3hKB4ioeeZctXZ1J6woyjWk1IkBZ?=
 =?us-ascii?Q?q88jg6BPgZYe5ESoa1XbGMJ9RImwqqsW+czaU0rWGJ02Ti7YNUKpM6/3QLAA?=
 =?us-ascii?Q?dpjzdTW24xvMJx+QzHl8CPzhC7oHHMWhmc9g+u1atq/JLpJuyO6lijHCwoxs?=
 =?us-ascii?Q?XwzIcfS+CQ1tDc7VmZOY4TuBIE/Ds4xK49DPyXkI3kclWbefaTmV4ulmRliI?=
 =?us-ascii?Q?kzJt8J1VeRu7Rl6xUNUz+pNrIpmLsH9epBert+lkYxIrq3LiijE3M6gIBTjU?=
 =?us-ascii?Q?uSJHaeeoj4lXhNBSpsobQ/Sn6gWARkQ5EtDF7+WWYgvPwHGsr6Eu2JrAYK7b?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118b49c5-aa05-4f55-e2be-08de0a35adff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:51:20.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpv6iFlLUzXuUmdxcKwRV9m7Qim+6iCvC9PStvFcVOgTwOZiBS4hM0HJbKiQOd5Ge9PrBYjylah2rgB1NkLePJf1W0KUk2Uqlddjon91cDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8495
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Oct 2025 08:51:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20169



On 9/29/25 15:56, Jan Kiszka wrote:
> On 29.09.25 13:36, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>>> We have a problem with the on-device IEC test now. Retry didn't help, a=
nd it rather seems we are handing during the TC_CR2.6_1 test:
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1151305323=
5#L2101
>>
>> In the above test job, the test TC_CR2.6_1 started at 16:44:34 and faile=
d at 17:39:25 because of timeout.
>> It is almost 1hr time, there are no prints from the device side during t=
his time, so don't know what's happening during this time in the device sid=
e.
>>
>> Another job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs=
/11509181697#L2062 here timeout happened during the test execution of TC_CR=
1.9_5.
>> The job started at 13:59:34 and timeout occurred at 14:56:53 so here als=
o it is almost 1hr time. And same no prints from the device side during thi=
s time.
>>
>> In the job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/=
11513053235#L2101, the test TC_CR1.9_5 is completed and it has taken 519 se=
conds.

I look into last logs and it is mostly 1.9_5 which breaks the test=20
execution. If I execute the test suite again the test will also fail.

https://lava.ciplatform.org/scheduler/job/1313908#L1854
https://lava.ciplatform.org/scheduler/job/1314503#L1847

Also from the inspection of the tests logs on the device 1.9_5 is never=20
finished.

Quirin


>> In https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11509181=
697#L2062 job, the test case TC_CR2.6_1 has not even started (timeout even =
before reaching this test case).
>>  =20
>> IMO, it looks like there is no issue at the test case, if we run again i=
t may fail in different test case other than the above ones and also the sa=
me test cases are working fine in QEMU architectures. some debug required a=
t the m-com lava setup.
>>
>=20
> Quirin had a look at the m-com device, more specifically its worker and
> its mtda assist device: While the last was still running, the DUT was
> actually no longer powered. Logs from the worker were not fully clear,
> but it is very likely that communication issues with master made the
> worker terminating the test early, powering off the DUT as well.
>=20
> Can't we make the master's web interface private so that this machine
> can focus on scheduling jobs again, rather than serving AI-driven DoS?
>=20
> Jan
>=20
>> Thanks & Regards
>> Shivanand K
>>
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of Jan Kiszka via lists.cip-project.org
>> Sent: 29 September 2025 15:09
>> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OS=
T) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; C=
hris.Paterson2@renesas.com; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=
=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>
>> Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
>>
>> On 25.09.25 17:26, Jan Kiszka wrote:
>>> On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>>> Hi Jan,
>>>>
>>>>> I'm already running a test with
>>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf7
>>>>> 1701983e3cb12f19efe9c217f500b9b0868
>>>>
>>>> Ah, ok. Thanks. Hope it solves the current timeout issue.
>>>>
>>>
>>> Not all issues yet: https://lava.ciplatform.org/scheduler/job/1310661
>>>
>>> Will retry once more, bit it feels like our target became "slower",
>>> could this be the case?
>>>
>>
>> We have a problem with the on-device IEC test now. Retry didn't help, an=
d it rather seems we are handing during the TC_CR2.6_1 test:
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11513053235=
#L2101
>>
>> This is a release blocker until we can rule out a regression in isar-cip=
-core. Please help identifying the reason!
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
>=20
>=20


