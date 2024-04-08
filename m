Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F41C67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 17:53:53 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.118])
 by mx.groups.io with SMTP id smtpd.web10.113913.1712598829123510188
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 10:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bKr6h3eA;
 spf=pass (domain: siemens.com, ip: 40.107.13.118, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKv59LOf4xsUfba02xNm2DNe5KK+KdahgnfJ2qXnwI5NEgAria5eIVzAi0vC2Zl7sFu4d8VzTHZzM/1UZTSUhEyWD009g1bE3fcv5vo2Ub4Ys6fM/+ncTMhkBrK25aRIXjlszzQoM6pYWbBm83b1KsbDcifHpPzEmGGjxzwH9u5tQRS+Z5uwniilMaCeHwcHBsWauSOx0WBDCGFdtXky54m2WXYElQSADiYrGK1N4TSgIG87vheKYiZ8JCFN6S4mgv/IwXqOJ0Lz81hqxsy27ui4xepOQRkGMivsoIg4frdbmeOyd4A6YPNB7hUIK9rhvxAmJregKZkAH/nnPJTLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q49RwulaFV5NUkcje+q6/3V5T8jo7+9a2MmdTZhaWg=;
 b=k+Jf/NxGYFp/5QyPMJPqKKadqgNkZycbCUTz35H/8TdV2ErUn4qmOX0bUBfXh4z1sI2VBD10sv/rqXlf8XZLoj48Xsb8qlvRtEKEI1nG0mBmvUkoGAM3YB36XVGEv87GflFUXsWB9bpAdHm5C3zJKovGKZOdsDn+dDcPUUSGro0hXA7hDCpJhKCgEDEQHGY6LfD/Lsj3pjn+P5cNoShA+1oeguUfLRo1HbNDOjXL/uuv53jHU5prZ71OcVuuJKADZ5Ll+NifanXv8z9D86J38/eudamnjfDZOGghpqvj2Q4twVoob9D4Vd3WA28Z6R0Q+gGBppw+riu6kQZEL8Z9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q49RwulaFV5NUkcje+q6/3V5T8jo7+9a2MmdTZhaWg=;
 b=bKr6h3eAMAa8NT5dx1wcDr+6CrqZnWJJz02zwDmR6yQEqZjXkFZWMxJgH8KvMWf0aZ3vHwdCX/6M21bAZo3EwdiIJUgIIT+Za92IhazQ+RwV4kUfoHkYbSyZE+sdgsmPbIQMyU3MvSLOAG5S73Q+SwYbysDgQBRxqzNrFddwJ+pcIuOHI/2N0c8M0MQEo/CGVH4F0nr2CnDygtfdPoDIa+1jJRZW+O73SOx8/c6x8RSH6tAWB4jaWymgFnja8K8rZqWhVcY8N5ecbv9Q8+CtpMuRxT7RlhGgWWM2Hxz7rmrkus3YNBYc0/AwRDCiru2079uoIMrOPvEfD3S0LelLCA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:323::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 17:53:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:53:44 +0000
Message-ID: <4afc5f8d-a212-473f-b560-2b187a09f02e@siemens.com>
Date: Mon, 8 Apr 2024 19:53:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v2 1/4] swupdate-handler-roundrobin: Increase
 revision for Delta Handler support
Content-Language: en-US
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
Cc: "shivanand.kunijadar@toshiba-tsip.com"
 <shivanand.kunijadar@toshiba-tsip.com>,
 "sai.sathujoda@toshiba-tsip.com" <sai.sathujoda@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>
References: <20240320103229.1078738-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240320103229.1078738-2-Adithya.Balakumar@toshiba-tsip.com>
 <7e2c146f03dc50cd1ae7778bf7b3bec7d8e10d91.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7e2c146f03dc50cd1ae7778bf7b3bec7d8e10d91.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VfZm7zC5USXnD7gvQ9WTxtTuRfreMB4ZKIzfJCeVV96p/q6G+zodAYx7sFxNxgyiRRqo1B/OhzIpf8ip28zXq18bgmiZh6MEn3fZBYAkQpACidiXMC67FYwV6gHs6C6B1TFo5yN50kkHkGBT9PQhmfSTNY/Ei/xIdNmAYGy+dlqJxVA1VoK5BazUr0PQlEcI23QlfIaH37aYNcfe93mc6q3/F9ts11qt1lui+OEbRTDuqT8uAFP02gk1CARkQv28VOa82BZ4ywjk6/fJZbE/McciN0USWgzqG3vZxicL/g6u6KVzymELwEVMXPd0Y5i3RXq9kc2YM9E4OOTaR/eMg2SQzJjemu4MLSIWBdS1n+hUxfFgKtMFYIH0e619E092D2o/srQ9G91KzZe/NpWnFiiJ3hiyERrToj8/jPlRk7HcJ/Zrg92rvWKMN23oQ0Bep+r6DSbyS9L+69CUuGcaTCjPKxN2j8PxDvUDQ1GEexNdmb43I4luo3e/zCoZz1vBDSH5VS3UFnajUM9cjvTy6bbvdutDLPO+MTHjGPoyCy1BQvvS7CTLG+GciP4SBjKQKtZzT1OoHxSEQt+2EPNn6lQrk/YZjbw6r3Tc6bKmgtYUfFJWTytVnVz+2uXrmTxv3PbFpliZNZusTSRn6vPwWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RW0vNVlpbHl1TnhDS3VWTzBmMk1MY2pTdVRZcnJGNzRUemVreW16dWJsaDlL?=
 =?utf-8?B?UXVYdXF3VGY4V1ErM2ZGZ2RlUHlNZUxyL004eEdRU25HQUI4RVRoM3l1cjR3?=
 =?utf-8?B?blIxbEF0VmhxSkhsc0ljUExWem5RZ3JZNTQyMlY3SFZyRWJnME5wT01aclcw?=
 =?utf-8?B?WlJoV05OTjZWVVArR01xVnRpQm9XQ1YwY0k3bWNwaU1QZDYzSkNJRVpwZkFX?=
 =?utf-8?B?UFBnRGxtcVNZdHl5VUI4YnNVK3B6ZjlFcXJUc3pQWCs2K1BVVFZQc0RtUnNV?=
 =?utf-8?B?QVBuRFFlMkIzUUJCejdwMmJhM1hEelNDNGdtRjhSMVdzeTFQTUQ4b3h6N2hi?=
 =?utf-8?B?V1VzRUtuTlJxWWJORThJNmZOc01YVWZ5cHpubXY1UkU0d1FrVDV5UHhhT1Fk?=
 =?utf-8?B?V0lSTnpKcm9oci94UGR5REZ1TklTVU5lajhyV3BRS1IrZXZJUUlzYVJwbkxU?=
 =?utf-8?B?SURXT2hrK0pGYlNiUEsybW80eDlBcmFjSERjUVdxcFJJUCtvMVRIMEYrMnRp?=
 =?utf-8?B?cTJCTEh6dzBqU0NJRVZWVy9PZWlMbDV5NExhYmVsREpGekIyME12UlRzY1VN?=
 =?utf-8?B?OWF6Mm1CZGxkYVpvalUvNXdnem5IUFFiYUppcVVGL2prWm1qOStoWkZGZTcy?=
 =?utf-8?B?enlRaklJZE9VQ2JuUnZRallpTXJVbkxnUFRIbzFMbXBHbmVMaTdLM0FhOVpr?=
 =?utf-8?B?L2NsbzZWczQveGZlMUFXa2RlcDJ5NHlWb0dUd0pINkFzNGFGMlB3bHJGOTJ4?=
 =?utf-8?B?bmd3MTBXenJGay9yMFlybyt6OCtqNnRzbzR3OWJUQTN6SklEQVQrV0YyWGNR?=
 =?utf-8?B?TVp0c1FJanVOUDFzYnNsVzQ0b05WY1BYbWdaa3lNNEdjRHV5WUY1WS9xS2pH?=
 =?utf-8?B?cHBaUytobkJlYnJWTU5WQ05DajdZQ1NBZmdNU2ZKWUZkdGpNZmRMS2dFNVh5?=
 =?utf-8?B?RDBPazlKM2xLT1BjKzlsRERmY3UwcW84TUVTbTBNNEJPb3EvZjY4WStVZUk2?=
 =?utf-8?B?anNwc0NHR0p2RzNwMWpUek8xTzVoWmVORUdhWFdqUEcxbWZibVBpQTFpbm8x?=
 =?utf-8?B?elpNbzdHMnBpdlFJUW83clhUellMazlVRG9tNzdNWWI3Y2pBUXljK0dpWFlO?=
 =?utf-8?B?NnhTeDduNktHQUg4QXBmVHpFMW5jR0xtdHhmOWZLQ1NRbjlLZCt5Z3I2K0Jy?=
 =?utf-8?B?WGxhbXRKd290WjNmdEQrWk5OVlh2ZFZUcjA1OHFsNzdnNG0ycnJsZzVnWDhs?=
 =?utf-8?B?MzNvSVZ1ZjRydWRsbFFBaURQd0htWWpjWmpmdjdWdk84NlBRK0x0K0l4TGpM?=
 =?utf-8?B?ZTFNTUpwVDBXZDFFRHBkd0NkNHl6UkhwNGJnbVZOb241S3hiZW9JbWpVenAy?=
 =?utf-8?B?UzM3TzBoNnk3aEFzRElQZ05aYmUyc2ZpLzdka0N6aUhxcG1sa0JJWjMxeFZn?=
 =?utf-8?B?U083b0czcE8zTEVmTFlaaTNXTlZ5YkYrTjVWZ0orS3B6VFJJOGQ5SCtRRCsx?=
 =?utf-8?B?UEtSTURCNktUazBYcy9nbjZDeHZCaGxMMkdER3FRQXBkb0xCRGxyV3REdFhK?=
 =?utf-8?B?eEhUNTNDRFZUbWJSV0RtZGVybDlpQjNHZS9NNityZ2N6SzE5QzZjYzY1SFc4?=
 =?utf-8?B?U2VnZUdaKzdmeUZnQXhHTFhmVHFvZStmdmdkUzlTeWRza0JydWN4VXpLNG1V?=
 =?utf-8?B?d3E0aFJMbzNpNzVlWHBMM0FmLzBTNlFMV3VKUHowNEpGRVlpOGp3VkpQQlVy?=
 =?utf-8?B?dDJjNVVLSjQ1UHdhbkFJWGs4YU5iV0lacE5IMUFEMG4zdWJ5VEtScEYxclN4?=
 =?utf-8?B?c20vSjlRT3FXMFBuUlJVTE5HSUFBc1dKcm5ldzM0VWZSSEZVZ3JTM0w0MmEr?=
 =?utf-8?B?cDM2K084eVI1UzhWUzVkdVVITjVibXBONERPL09VUVk2OHR5V0lraVM3Zkxl?=
 =?utf-8?B?aWtJcTlIL0FLeko1U1dTdllWcy9DaWhlTmpoRU16aXkxd2tIS3MxYkRONG4z?=
 =?utf-8?B?U0R3UzNzSmgvRmVzUURpekM2MkNZd1dYZXNIU1RZNW40V3hVK3ZQRHpqekJq?=
 =?utf-8?B?NlJiMi9KV0RUaGtHRGtpWlRQZm53b1NOUU9nODBzWTFGTDZxRFliREp1QnpF?=
 =?utf-8?B?NDRNTjFzR3VzN0RHcmdvSjBlTUgveHV4aXFIZll4VjBoTjR1dGtldHpaeEgw?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bd6231-e262-4553-8894-08dc57f4d59a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:53:44.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkyZrA971/WJx1B1tddMCW7evOryi4BgTNwvKwTcCFZ5F9fA9MqTZbbUpDmhV0Svtz9Ek4kENHphXdWz8GXsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 17:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15509

On 03.04.24 13:57, MOESSBAUER, Felix wrote:
> On Wed, 2024-03-20 at 16:02 +0530, Adithya Balakumar wrote:
>> This revision allows the use of delta handler in swupdate for zchunk
>> based
>> delta updates
> 
> @Jan: This change is trivial and needed independently of the delta
> update. It can be merged without having to wait for the rest of the
> series.
> 
> Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> 
Thanks, applied already.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


