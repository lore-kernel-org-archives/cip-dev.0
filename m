Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E45EC5AD7B
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 10:39:45 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27136.1786358372338551924
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Aug 2026 03:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bQFIH13T;
 spf=pass (domain: siemens.com, ip: 52.101.84.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khMFG4JmxGwkIxnXCZehFPXscyrwwUPZBmaZ0Np/c/CCFRv7uLcwBQrwqWS2295xhLEPn0Jdx8UYhUDyaWFDEC27zkmohCC1OcKflXT6hl3DPDTDn77lkSEB5OhGlKM/8Y2GSkR57E3VKxZ1SAQj7ptVOanvG6+LQ8qxiEsPn8REc6dnXkGm6TV9h/Qgbura+YXjUSNY5tWWZjgae077zslq2sfrjWqxQ/UTju9NrzEZcOMKy9dJu1vp8CZPQZ6PdBVYtM50VEaSEkQPgItrKINMGrrPOyEtbNJ/Qyln37YX1YChKU60UPFkv42DJSt+angTZGDGqnPoIUxVgAZNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u56DHMOZAnmtvNq1sAyT4XeDSVYsw61hbpzEkGAyH8U=;
 b=yGIcf4N29IeRTyRbGbXGvDJSSsWBQCZdtGu9A+sOwngLuUTiYTYidDt5LKM4eosjbEx1TXfJeLL/k7JM17TpHTyeDoYC8xU/938dkTsfZPTcEb3gZZuVImJhK79GHY8Yt5HNTQaYbxUfCWGvswdyBGWqgK1tFqpLvMDGifimO1ZTzJbaJ5LTgmNNJBzWlNi2tO8I9hUJ5VQt75J4yNr3op++UvupjcBcVOt3rsx+nDKcdQNNfOHGHECfyuMh1+alEWB2gzATVnayrJ1x8I3cvGhpF9h5Ftyg/Ytw66/sp4xJhPxmg4kc/H1ocreTfF+T5C76iyCPwrbxaD6oNBJy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u56DHMOZAnmtvNq1sAyT4XeDSVYsw61hbpzEkGAyH8U=;
 b=bQFIH13TyZQHtBC3o7AaLM0V9+4iAJc+S8+1rt3sE3ElQ36hmn8nsmIB7qNCiEeRi35nAmmw64Nnzyrrbib8dm6fpeBVof9/2RycbVldsTOZ6E4biUeyKx9xWjiI/7xAhWrEMJmbGEoEfjLVvSRj1Nd3nTNnTHMMURerlfO/jvpJFWg7P+Is3fdJLJv+ssJfB78mwktZKIG++/uuFTLTK/fnW9lpi5goKfv2g5mLZCPUPNSRpLMv0Q093OhUrL9UHGaBfmx6/xe2n6C2ojgEpdO9w4SQzz60D3aC7JGSfRB9khBlq6xBsZbXDVSUmnAkI//Nytwfhm4Nrhe8PsXv9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9418.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:39:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:39:28 +0000
Message-ID: <b45b4dd0-03cc-4df8-94e5-ca3405e2732b@siemens.com>
Date: Mon, 10 Aug 2026 12:39:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/2] Remove unsupported combinations for
 factory-reset from Kconfig and document them explicitly
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
 <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <31174e6a-78c9-4fce-8d1f-dff403e1f6aa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7621405f-044d-45b2-fe49-08def6cba735
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|5023799004|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	MPTs73sOiNMZdkNxE5mExqmCh51okJPnrTkmREKQajZDSlae99MBSa/wiTE8MIG8EwY+WmnkF0/Jr0BGgW4HfV4xYsadswCrudWYhU0arBKi/5p1HZNUXH2gp27u0RL2svrQs8TjN5t06L2GrGqgQzOsd7d5jSBrqmlrjrWph1LP5GAh6Rdc1PNdvNhb2vPn+PWFMt7LamXHer1aAkCQNq7ch0fWAC6RivPZjsTkoOhVAuaaFGVmwh/byP1fzYoh1TMahsNQ8WH3SSKhp0KuZZvp2zjpD+aDyNKw2qwTp3C2clSUw1eRC055T4GFQsXsXC3mS/F17MaXiQG+vF3cKatDjk0f4hQY0WdVsBwppK42UTkyPQTezSimMZSguHbhaA7KzmGEhI50+xFKU/c+Umx7FCABBeRLRQjr5fFN08cpjtRiqmsj4kSDGR+D89MrirMvGh+uK0Hosxt1sVqOsc9pU98TLIueTMxDRYFjpXUKbkHsgy30H3WI98Gaxasze3VAi/R4HhV2/eAROS7fc9bEo1iF0BvC+4OlWy3P7yXRkmn9uVbSmJwqwp0gIk7FaIIc79GBNiCMekYJQuHpeRthaS+GznUvRFjS8lK6tixgCQ6FKUwl5l6NOm9xPBxd5ejC9I9U4TTpITGWphmNBdDQS1NFgtm9IQurOR+WwSI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(5023799004)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDU2Wi9WclMvWWlNUFQxdEJXZ3QraFBWSTUxUUJlelowcDEzUlVVdk5wQ0k1?=
 =?utf-8?B?cStzaTNDNGliV2NmellmdWNISjRlblVlWHhCT1FKNDFocmZ6cHRScXU0bzR4?=
 =?utf-8?B?ZitvL3c4Y1QvOHNsMFRkTUpWWHcyVk5pNWtCWlUvRnNqUnd0em1BN1Nhd1By?=
 =?utf-8?B?MGtkNTN3ZndlWWswOEZQRUxDTzZWdnNhek1TNE9ucWxubUtvTkFaS2Q2OVdt?=
 =?utf-8?B?bjN6SXI1U2hDVVhUZmhrUHJRV3dkeHcvaGR0aXZzOW16MzdWbXR0MDZNZXl3?=
 =?utf-8?B?NllKcVB5eWRqcEFLVSs2dmROTW1WSEJjeU0xb2o4bTRVRm56YStxM2dHdDV6?=
 =?utf-8?B?b0NXSytURGZsM1dTcFJGZ0hZeFNqWkMzbHN0dTlOeTc1YzgvUlN6Rkk5T28v?=
 =?utf-8?B?ZG9rc3haUXBaVzBQWjdWLzBYWnFxWTR1bWgvc3BoVmVGWTRvbGZ2RVlseElz?=
 =?utf-8?B?UlkzbHZWSHBCSlIzOU0yL0U5OEV4cnRwdEkvUXk0bWFLdkRYWGxtR1dOd3Jr?=
 =?utf-8?B?UkdqcTEwbVhhblJCOXcyNFVLazh1djE1NmhKUXNRenlUZFFieUh2MlZkcGNK?=
 =?utf-8?B?ZTFsbVZWSUpUNjJ6T3hsaHloM0hzeUUyc1o0SWJuU004bWpDejNId2RkMTla?=
 =?utf-8?B?OVk2QXlOSE1OelNoOE03RmRFNnJGcFRqbmJwN0dFOXlBS1BrdmFrUG1zd0xS?=
 =?utf-8?B?cml2aktwUjZIQWRieUtUb2RBaHAxUHV2a2l5L1B6dzdZUUNKUWZoVFZHM0JV?=
 =?utf-8?B?ZnNuNm8rT3hSMFNoMkR5anVGZVc1eHZOcTZtUFBQZGVWcWdQbGpQa05FaTkz?=
 =?utf-8?B?ZHViNUFhV0I0K2NtQ3NRVFZsczJGQ2JSSE5WSFVmOUdGUjZ0MGZiL2FudGo2?=
 =?utf-8?B?S01UZm9UOUJKbUcxb2l6cUl1eC9iNmpYbzYvRTl0Zk1lajNlYm5yNC8vNkNt?=
 =?utf-8?B?Y21DNG9mVkJQbkRUc3VVdGw0cXQrdnFZMStleTBHTmR4VDVTNjAzUFBvZTAr?=
 =?utf-8?B?YVpUUTFpQnJhQ3lrMVNCUGZmbGh4SloybUVCWVhlNnpOa1MwQVczU3FFd1lW?=
 =?utf-8?B?U1pVVVJpRlRIUm9hVkhqR3cyZ0Q5WEo2MUFNYjM4RjdHUjdQcUxJbFBhcjFF?=
 =?utf-8?B?ZXpjY3N2MnVnVGpWdU5SbFFKMFBoSmJhcjFSWlBuTXVoZktESk5aZkdBdjQ3?=
 =?utf-8?B?T1N0RWVnS1JQRCs1RVJnTHduMjdOWXFkQzE1K1c0TzBSWVE5dFhNVW5XWXpN?=
 =?utf-8?B?KzYzR1VmMEZMSG9zVmQ1d0h6UUNYV3A5WjVIakVDejgzOFZsdTc1S3FoOUtL?=
 =?utf-8?B?QUZVNU8wOHBhL0dUV1RDQUJudTVidHorekh1SGp5T21xbCtpMmw5S2ZwOEdm?=
 =?utf-8?B?aTBkVWpsZzc0ZlhwNmVXd2o2b0pZZCtVejVwWFB6TFEwTS9YT3o3VDNwWUVu?=
 =?utf-8?B?SkpUSllyTDd4aVN0WG16VWRSUytOQ295MDNKeWJoWTh1eDFHV3A3TDltNGp0?=
 =?utf-8?B?RVNnc3h5WXVZWC8xRlNwR1hwZ0VqVW8yb2o0eVlIZ0ZUd283N2NVWmxPSEFo?=
 =?utf-8?B?QmhjMEVSenN1ckdVSjR2eXhleGF1b3BEQTJqTjJMSEsvclpISEdHS0VrQ2ta?=
 =?utf-8?B?QW5CbWhBUjREWGxHQWNqWjlCWG9zcnZ6VFcxSlF4dTlLOUxsVFFkQjdQczFR?=
 =?utf-8?B?SFF2WjFBYWZwT25aMGhveEcrM1ZUbXFBMjd1OG80UHUrdEd6L0NlbDhBT1cy?=
 =?utf-8?B?dTFicHBEWTRpYkdLSHBzbyszVzF1Vys1dnpWYWwvVGh4N2dkdmZxZUVyNGRs?=
 =?utf-8?B?SjhLZGlzZEhVVnZNVmU4TmkrS2RVSm91MXBlN3JVcjZJWFI2bmswMUdBdzRR?=
 =?utf-8?B?ZjZvcTRlZkVUb2REdHdxTWtWVXV6eWFveGYzaS9xNFlDZFIvS2dGeGw0VUNG?=
 =?utf-8?B?cFlsckNhbmVhZHkwdW56MmpPZjBSb1VLc2NYR3JocTdJUE5RdHJxOU85QXFk?=
 =?utf-8?B?SHgwaGFheGNpalpBZ3E2Q21CTElvM0lOQTNUbUpjSkczQ3I0NVNLSktIczZw?=
 =?utf-8?B?dXB0ajdBSXZSN0tHUEdMRW1RZHVUTDNmWGpMZU1MOEkvRjVtZ2piUWpCaThJ?=
 =?utf-8?B?Zm1BWFI4MW1RWWMzZ1JpVkkrN09GQzFITUI1ZzEvQlBVQjVVN3d6RnNkbWZM?=
 =?utf-8?B?K2tSQjFRalhxWFp5dmlpTW8wN09KS0txd3F0OFVoR3FPY0NZMS90clJ6ZGZv?=
 =?utf-8?B?bW0yMytlRFRmNHo2L2xEUTlXcFUxQW52cFBDVmlSWVZ3ZXhKVU5OQTdTa0k3?=
 =?utf-8?B?UjBaVllMdmh1TXoxWE1vS2hkRDBtcDkzVWdYK0ozMEhUQnpZMVpVdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7621405f-044d-45b2-fe49-08def6cba735
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:39:28.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsaa9dyZFiPkcCwNqcI7COqAJGtuE9csyl6OFui5JKxUe1LvuPqhiZP98F6iQBCq9d98WRmky3Xihb8/cSStwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9418
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Aug 2026 10:39:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23881

On 10.08.26 08:55, Quirin Gylstorff wrote:
> 
> 
> On 8/7/26 5:44 PM, alexander.heinisch@siemens.com wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> By default factory reset clears the tpm. Therefore, keys needed to
>> decrypt the immutable A/B rootfs in full disk encryption setups
>> cannot be retrieved anymore. Thus, the boot fails and the device
>> cannot be recovered.
>>
>> This patch series removes such combination from the kconfig and documents
>> the issue explicitly.
> 
> This was never in scope of the factory reset. You could implement it by
> moving the keys into the boot partition. But this move will create
> another can of worms.
> 

We already have an option to skip TPM reset if not desired or
problematic. Why not use that, or build smarter on top of it?

Factory reset has already way too many limitations. I would rather likto
work in more cases than in less.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

