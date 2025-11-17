Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29577CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:23:03 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7942.1763382167512254260
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 04:22:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WWwhmX/M;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.66.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPcEzQcWC2tI2yRYSSHJ+shl1mSx3yls6XJiexHpkrQISqr49yV5r5zJxVzih1610h984fy6MUwZfQcCvez1qtl6XBCUO5xin3kPOQ6t1cyg6qaFRDW60b/3riXMCJpCmGQP6RpcKnvp6kTDZWS44SKkuAWWWCU3Ij9N3rvxMaSXX4SY58sMIBN70GcqTLiRhRatOVeHl6hv7f68IgQID91K576OqUj1kcn+uPhPQBDjs3KwY9jLEJlWUjJBRn8JBuhHzqGtH7z2v9voUvaxYXMc/DdFbhKBL8iwVKk0Z9tAR7IenpdX4VteL2d5bfKcaQsaqyCHQl/9MqGOllLsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxa5An63hr2Y3zjYt9KIrYa78tUAwUUOZPtg/gkgwfs=;
 b=ab1L11mwfvWxt7q8etLjshbGPg5LKYiU19VcbQY+VC5/Blp1HKq26YD7d7dNh0LJZzwN69d3MgMLscMqrgd8qLraibdyx1wQgbYS8OVdGhmeLiWRIl636GLd058v5cGrb5uqYx2l6fXQsCTCDDeTpiZ5xuRmrjarU95HSraV1f8+uqz8MUkGApChVLqZbPu/GotUtTJ982ndgb0leiGKpBrRSfp4OBT3EnPDSjE4e05pi6OOllj88KIn3SIPGFZkOkrZJWq+AyzC0MMcKeg8guFS6r5YgaOg00dwcnsTzngbmTnKHnKBiFC0eK99Fkk4jWR6HPZLeXxYKjXeR1vgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxa5An63hr2Y3zjYt9KIrYa78tUAwUUOZPtg/gkgwfs=;
 b=WWwhmX/M1K6M8zdptLz/ESI4GT/1kFFtvL91EpLGwK8QjmEAYNeB2js8JqjyQT7MoOb93kCzBpn9zSc/I5kH6lPue4dnXCHUhRlVIvVw8C7hmVlCJ+TNyAtPGEgXXo6wihRWQ6MiEQRHN4tuw8ahXjevpsVmZdV9KsSyR63E7pXSmojJgFENGAueni/GiB9wapIPoSFqiQjsm3HhLE0hWAj7mQlaj0IBZox3Rw8M+h6FxLkUE7lar0a6v1coycOMh5CqMP5gyzMpNTKoXtUGM9/OyahNB5o7WHQ9/GYgN1M603l5HbdHaCR/OyXeB6TFi/koX8XxPkrH8P4HELCAmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 12:22:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 12:22:43 +0000
Message-ID: <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
Date: Mon, 17 Nov 2025 13:22:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:610:118::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: f51aa1c0-cbd0-4bc1-2349-08de25d401de
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q3RSQ1BJeHBvN2czVE52b1I4eXJUaUZYbG5zYTU0eDNwSmo0SE9mMDVQVjhz?=
 =?utf-8?B?MlgrQXVPaTNSVlRPUFVtems0R3A2MzJiQ2FhRGg3L251KytWcy84d1psZFdZ?=
 =?utf-8?B?Y3RxazFkdUlIelNvS1FsR0gwdzA1Y2JtbWxGQ0JjclVoM2g5L3RSdWpaUEhO?=
 =?utf-8?B?SHdxcVptNlJXV1JmL01UQkVjSWNQVzFoWktxcG9iUHQra1N1UFN0bS96Sm1i?=
 =?utf-8?B?RzRPVXdHdWdRdG00alV0Z2x5cmdQU1VORHV6TlVFenVTdHJvVVViTXZTV3d5?=
 =?utf-8?B?YVBMOTRBNFBEeWpiMGVaYjMwM2FUNWU3ZnlGOFpRM3RiKzZneFpESVJLS0tT?=
 =?utf-8?B?dlVXeXRyeEZ1d3NCYTVBWmMveldpbGtJRWo4bEIvTjdSQWVRVjZMMldoU3lE?=
 =?utf-8?B?SzZNczVzQVBFd0gwUVdGbWRSb2N0djlGNHpOMmNJdUVxYzlaWEhGQUNRZzVP?=
 =?utf-8?B?MitDQ09LRnIyMTF3a0RyQmxlNFJyL2hra3NkVFBzRGNzQjBmUmtnYTBJaEti?=
 =?utf-8?B?NmtoWnBDK0JBUTllMHdEV0M1bE1Sa2hvMzREcnBCQ1NDbnNlZU1WUm8wZWIz?=
 =?utf-8?B?NXpyRjVTdHFIVktQUjM2YWwyQy9IbDMySHVnRytZaDNRcWhrVzVsVW9CMG1h?=
 =?utf-8?B?SlowODVkSHBPck9HdjNvNlJjam9vMFR4dWFxUjVod2x5V0tDUFhMMUR2M1lF?=
 =?utf-8?B?N2JRZXZIVVFyZmxFRU1NdWE5TDJQeGhOUlJESlNvdm9ObEl5ampxMVIxd3l0?=
 =?utf-8?B?SklsZUNHb0Y1SjlGZVpKVmM0TWUxSmIzUWVEZThkbFpza1Boa3dTeldXL2da?=
 =?utf-8?B?T2IxelJVd0R1L09WV2FmcmV0eE5ZK2ZObTIzTUx5YzZKcTNGQmYvekM2eXNO?=
 =?utf-8?B?eXNMcmwrYmJwK3Z1R29hNHBxVms4N1hVeGQ1dWpjUklCOW1jNHp0QlBRMWs5?=
 =?utf-8?B?K1ZmSFNyTmp3ZW9kcytWdXMxR1pBWVpHSmluaGZjYmRUWDVHemFNU0dRNDda?=
 =?utf-8?B?T2pjdVZzNlR5aW5jMzJWZUF3NTVGYUlncFlVTU1Ja0ZreTkwTXVWdk9vaUFG?=
 =?utf-8?B?V1Rtc3JPRnVpWFpkajlHa0o2bWRucXl6MmRBVDVOY1d2bGIvMlNQSG1KdGpS?=
 =?utf-8?B?NE1scVRiYldBb3ZNTVB0L3phMkYzWjRSUE5HWVJWbW96dmc4NUsyV1E1T3Bl?=
 =?utf-8?B?b2N0Q085OEpFMlFGYUJDM2ZhZ0wxS04yU1dJOGhlNU55NXdXanBnekZNdlFs?=
 =?utf-8?B?azV0akpMajRpS0xjT251YmpJeUhQZHdjTVhnektXb0hLQlp6ZklaVTZTRkdj?=
 =?utf-8?B?c2ZwZ25GYVZUL01lRWp0TW1BbXZ4STJXdTRtR3JnZGRQU3Q5ODdNOVVwV2FH?=
 =?utf-8?B?bWhSMHBxTWJsOFhjMVFBZUVlZkNCVk9sUE9LTURoSXhWdXNoS2FnNlZtLzR6?=
 =?utf-8?B?aFpCZHFITjB4dWxWSExrVVlGdjVtV0E1T2RtRFBHR3dyWlBxYXllNEhnNVFH?=
 =?utf-8?B?aFhvbmwwVkd5T3g2cE1nYXU3akYyM2JnWGpLRStFSWlIa3RsNUt4a0ovcURF?=
 =?utf-8?B?UndnQ1dHU0RXOGI1bzNXbGlCalQwQXV4WVNHUDVIQ1dZOUdUSHZtY2tyOUZM?=
 =?utf-8?B?QWF0cXZhbUM3NWdydmQ3eXJHaXk3VTJuTU55bm5WVzBWdnk5TEhZdFpwWFVX?=
 =?utf-8?B?MkRMZks1UHpKTllIRlNUaE9KYXdkanZaeWhXUnJGaWZjR1ZGbkR5M1FFblNM?=
 =?utf-8?B?VGNESDIzSjBnQzgwWGZ0aXJWUC9RdC9UcWlpWEVpYTc2YlN2RWdwWjJHZUd4?=
 =?utf-8?B?L25IZC9RRDBXSDNJTTFrQit5N3VValBQb2ROaVYrL2xqYnpNWE9wRU5aMkxD?=
 =?utf-8?B?dUpTZVkxaVF4UTB0R0xEemFYWldTQkFvY0psSnBseldCZUlITklPckVQMk43?=
 =?utf-8?B?TGtFalBDcWdjcnhlYTMzaHN6eU12bmxYYTlCL0JYRy9iVFk2aFFHWEN2YzY5?=
 =?utf-8?B?NjNLR2VWNTBRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wi93dGtuNmtRcmRncEpRWll5eU43L0dEVmxVZGNWd2tBZTZ3K0U0aW4yYkFV?=
 =?utf-8?B?YU5IY2VyK3VDaHVrVjNTa1ZSdE5Gak03MmMyZzVaUjhWNEVaY3IwY3gvQmh1?=
 =?utf-8?B?d3ZZcld1SXlJNTYrK3NsWm00MkxSS3l0QWhKN1hhVEgyOUhRUG1UUUlWN2Ur?=
 =?utf-8?B?Zmp4dkdJWVpJN2RWOEJSdHhlKzl2eEVEbmdRTTVWUWFSaEJzeVlwWmNsREJI?=
 =?utf-8?B?YzZ0WVl4RUtScWd5dzdJSGJMaEtCRk1HUEtKQ3dvckx0akpLZGlmV1BmY1NJ?=
 =?utf-8?B?emM0eGhseGZYNVpQTXFmNmVHN0tVLzlwZ2prcmt6MmppR1hoeStjTWw5ZTg1?=
 =?utf-8?B?MkgrOUR2aDNvcEx1ZUdXWVJCTVl1NDl2WEh2K2F0cFN6ZWhvWmhqWCt4eTVP?=
 =?utf-8?B?eE1rZm9Tc1dsN3F6dzJTblM0TkhGck01ZTdwaTdJR3QzcHVjRGhGTlBtM0ZR?=
 =?utf-8?B?N2t0SlI4d2kyaGc2UFpaU1o1Qks2dVdrdmNicmdsR1hmOXRseWo2QW1JZHpJ?=
 =?utf-8?B?b3llbURhbmhYM0FKQU9MSzhiVnc4YzJYd3ZHLzNhRWEvU3VJWUlpVklnUFBl?=
 =?utf-8?B?YWN6ay80SGxLV1M2a0JjdWlTUzJxTDJqVklYVVV3cEplK0YzMFd0OWNoTk4r?=
 =?utf-8?B?dEhsdW5XR215VUpQUlZQRExYMUYrYVZYQ3RJMEMxdXB2L0xtZkhJOTkxYmxV?=
 =?utf-8?B?Tk1Fekg2Z214enVqekhsa0tYSnNYWjB2dmF4cVJoRzBUZTFmaWxPa1BBLzl3?=
 =?utf-8?B?ZmVoMXNXdE94clNtMzZiMWxGeEJwVERDQkJac0I3c0RxcjZPYmZLS0ZLeHFi?=
 =?utf-8?B?am5HU3JScHR5SWY1YmpYRVllZTgxd0Niakl2bWxlaWhDaFZNSTRienZadzRs?=
 =?utf-8?B?SldrQzV2T3I5QklwdytNTkpVajJMMnBNUjZRenpGSzdEMDhpSjI1WVVEb2Jo?=
 =?utf-8?B?K1k1S3IyTjNTWE1PTzlYRTBTeWtnNXltdStGYm1hNnVMSzcxVmlrRXF5eWtQ?=
 =?utf-8?B?dWdheURUbkRuR3lCTkptUkZ1N0RpUDE3dnR4VmdyaWFaUFBHNWVDbWhSLzY5?=
 =?utf-8?B?MTRsWXRZbHFlZVFiK2hjODdteFNDZWI3aUJSZ0pvVmxtcEJJenhnRlJSNWJZ?=
 =?utf-8?B?U1drQmR4MzVnSFdKS2ZIb29aVzNGSC8waXhDckxucXNKaGhYdVdFMHBKbjRp?=
 =?utf-8?B?NThvemlHL1BTcVRyY3JMcXdOYmkzVXN1TFRlejh6djdiY1hzc2pGSjAwY0Qw?=
 =?utf-8?B?clZwUzlIZ2JJT0NMRnNybUhEbkNSZ2liRjhYM2RHU1NkeWtyeXRUbVJreHdk?=
 =?utf-8?B?NXg4bm8wRnJ2eGNqZnVuT2lpcGZxdzhTOUJYUUZSeDNpaVdRRUQvKy9EOEN2?=
 =?utf-8?B?Z1EvUXNDMkt6a0tRT0daVDEvcE55VUIxaHNWaEtkU05aVmpteisranN1aDRG?=
 =?utf-8?B?YmJSRlcra3pSSnc2ckhFaGduSTdVRyt6SnhpL2ZKdExsV1d6dHFtK0JXNHBX?=
 =?utf-8?B?cEtLQ0JoTjV1aVVJUGdxZWNQc1NJUDVxbFlaVC9Sd2xGcUhPaG9WUnVwZzhY?=
 =?utf-8?B?TzdBSjVUcUpjWGhHN1ppRHpGcHdySW9jZHF4VElVbmlTWnQ4UmF3NndwMThj?=
 =?utf-8?B?TWJhQWt1Yjg0emt2NThwNFhkNFdBZDdyTG0waEVacVJ3WTcxZFRudktvelVK?=
 =?utf-8?B?TDdCQ2JmTW5wOWV5UG0rbUlZSjRaY2dvTUFSVzNkZXRYekVvdFovNlRtTk5t?=
 =?utf-8?B?TnliNnFVSVpIbStvYnF4Z2JRZDZsWXFTVktQT0hibmgyUG5oTElVNkxXS2lS?=
 =?utf-8?B?YjFacy9ldmsybTRVNFo0WG9OWXZDeFBpczVwWDVYU29VK0UzQXNhbDRMVmsy?=
 =?utf-8?B?SnAyNFZsdWdHTmp6RW95TExrd0pEdzlUeTVUSVM3TkxMYzAycnUwS1MrbHpF?=
 =?utf-8?B?aVpBZlZwUFhudE1rb0xNc0ROa2hBc0dGV2p2ZTNwM3A0QlVtYURDYnE0R0RD?=
 =?utf-8?B?aFhPNGwwMFY1cmJHRDFNWGl1ZVpVM2V1cERCYmhNUWI4UUlNRFQwMXozQ2Q0?=
 =?utf-8?B?Y0d5R1V1MjdkVmdGUVpKSmtUU2hhUkVkMHN6cWdzaUI2ZjNFME45VXljc285?=
 =?utf-8?B?ai81WUxYWlc4NUxTUU45N2UwWnlQeUxSVmdlQXQvOHp5ckZobEh4MzVOd0I0?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51aa1c0-cbd0-4bc1-2349-08de25d401de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:22:43.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7mp49mUOjRf3nQdjCC5Q4k1WJ3hPyHyaT3W86mtIq009Nn5LWqQ3LqEdlbm6qOEF2pkVnYNO5rBeniyOt3PAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7721
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 12:23:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20580

On 17.11.25 10:19, Biju Das wrote:
> 
> 
> I have attached u-boot.
> 
> Please check

Will have a look, thanks. Can you confirm I received it correctly?

sha256sum:
224c1cff35b672c886afa94e3c857c7218bc75db179c97f48ad53b6592e5a167


Now I have a somewhat similar issue on the HiHope V4 RZ/G2M I unpacked:

U-Boot 2020.10

Wanted to enable EFI booting, but U-Boot is likely too old for that. If
you happen to have an image for that thing as well, that would be great.

Jan

> 
> Cheers,
> Biju
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 15 November 2025 07:53
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>> On 14.11.25 17:15, Jan Kiszka wrote:
>>> On 14.11.25 17:03, Biju Das wrote:
>>>> make -j4 uImage UIMAGE_LOADADDR=0x40008000
>>>>
>>>> This is the command for building uImage.
>>>>
>>>
>>> But Daniel set up things for zImage back then. I just discovered
>>>
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/do
>>> c/README_iwg20m.md?ref_type=heads
>>>
>>> Maybe that whole thing was never tested again this way after 4.4.
>>>
>>
>> Tried with 4.4 as well now, still no success.
>>
>> Given that the eMMC starts a 3.10.31-ltsi kernel, I think that U-Boot on this board is just outdated.
>> I would test validated U-Boot binary if provided. Could also save time when bringing this board later
>> on to live in one of our new labs.
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

