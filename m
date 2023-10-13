Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66CCDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 08:34:58 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.67])
 by mx.groups.io with SMTP id smtpd.web11.34069.1697186094243390883
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Oct 2023 01:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HUPTw9oG;
 spf=pass (domain: siemens.com, ip: 40.107.22.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkG8J0ecsip+DRPYS4KY0zwYpnKZPFT4QmiL9oYddqBSUbwZ4NRbG7ashtqZXn5wd76v2T1s4ajZT6/RECtNPIMLDJ1x01Yt1abr0jUDcg7Gr7iyBAIKN8Kk5APpW0SUDq121jKNbXif65GEUf9UPTB+50vPajbIBhj0hTLS8kDf5jB7X05cQxyEBaii9Kg2OkM8Bn0S8l7XhIozCgEWLxfqUxwQQRrW03j/J+zX6L1t8DWX5eZ36Jc/Ui7PDr1dpZFS1SZONElfexAxlfjEm9ZbhdCnaU3WsyoaZOeLkxgRaHzrumAh+9IY1Qg39qaAqAPLoxUQLdZmafRiZmtwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNpiI818DWiSU4N8gIOxFC6LXylyeONlmZapD1Jk8uU=;
 b=R8u6g8ronN6diujMf4eUXJKsdMm51k844uupihkl97bemsvvcLQ1LVOnNsLa9EvF9K321ijDJGfIpBgOQc9AywhU/7+eeogeT/MhCyuVdVfVB95BTIVPwGniGBpkzFJnwKjRa85Mfkg6xnM7VORs2XUgXLBT/uEfEvFP+GIxBXLlVcB8KR7VhUHGPjTwlU6GDTU7k9/ZKL1NqeO8deQxOMeTqFW6qVO3Um6/zGMFORCYoqVcaBKCk0ysfIye6OftPsYs+FsKBymeMn7Cd9W1blMoxKTkJ724Ik65FSIgQdU0edPU4/Rlp4I7XPFjQGl0A/bkAPLUdtl6SDgMKV0aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNpiI818DWiSU4N8gIOxFC6LXylyeONlmZapD1Jk8uU=;
 b=HUPTw9oG7c+sDfhDGYtvruUc6uhmlJrYdJIxGxPDdM6PsFRISDh4clnanb49uqgWOXveAyoxDGWCBwHX8+c6Yqr3GzNwkqTmc1b4dZoYPchUVnUWiM/6ZtREgcEx9R7f/YRGIkILDvXYKWhaz2vPDllZL1oaBsL4WFh6vCDHX63OmYxbEuFtDPRI+0SmxGVQO71BZfpOgX5FuLTo0v7BQNqi88euCsdOTDRzySj5TQcaVCHpimUPUJ/6Ru6wYvj/K11j2dM4yHfyN50Ecy/hSEmh/sR2N6GqhfY699QN/z0xEuqtW1hCK/eboGU3Pr2JPQmlmSZLICiD810loKl0+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:34:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:34:49 +0000
Message-ID: <447d8a85-5b05-43dd-a210-410061005254@siemens.com>
Date: Fri, 13 Oct 2023 10:34:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] Add support Plat'Home OpenBlocks IoT
 VX2
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, minmin@plathome.co.jp
References: <20231010081034.3762306-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <3781349a-2426-4fc4-9e9e-1d543112375f@siemens.com>
 <TYVPR01MB112457EF240E3EE05EF931A5592CDA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <e922619e-545f-40aa-bfdd-9c716d6d1413@siemens.com>
 <TYVPR01MB11245513900059273FA943B3092CCA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYVPR01MB11245513900059273FA943B3092CCA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: d4277fba-4536-4c84-6c6c-08dbcbc74339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XpLAi3juFXy7yOcdXnyRXN3PlRJskCXDbgnTZLb+i5e+QWSvxh7NpZlmpNkb4kV0gCpHMN8+1zWphSw6l5NyMqhJC1YM7jWYu85/PZdfQDBEpgc/ZqbOQIC6Dsrfwxzj78pkmI5Zy0RW4zltzmbLMTo2/hZE5/E7M9g8N0B5VVpyIVRAhnRAcM92twsH4D4R+GD11ZBT36zAhbw17ml2iWj4bY7LLXYN4Td/UwgfspGfJwD8TRPX1mTRUdMhhh+kZ9TwGtB73IwYNTQ+Mv8dkYOoF2gOUthFFYtfGC7vcwWv4SgqAj9zr3KGTA3RYO0RlCqqo0QXqoWrljjjo7+q/DwkEO5uWjy8cjTwI34beXOTcIQYqDhmX3gqySbOIRlxc53/prTzJA9WkkHIy0mqL6bnSNSrsK2Uq+M9xklT6vn6CHPiPmtZuc22+h0LDLDuAaPZu2rqaRIMFMrST5xIVzqtCAvUBgzH4l9baOT/c76JUN3lrnXhh6dURIBzfAI52Ex/r2pChVtf683j1c4TTcMukdrFeB+wpHCu9oXQm5c3VrBrlhGEGbgSxNBkO2H4K1Ac6awIoqGQRNSlpPyJNWjX960IZ601JThrrt7H+XsDPd7XAuK1MwO1gq0ZEJlxx/2OtyvlWnmwxIoRAvddp69Vtt1voj2CrbCAuvPZmJI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(53546011)(2616005)(6512007)(6506007)(38100700002)(82960400001)(31696002)(86362001)(36756003)(478600001)(83380400001)(2906002)(6486002)(66556008)(66946007)(66476007)(966005)(8936002)(6916009)(8676002)(4326008)(41300700001)(44832011)(316002)(5660300002)(31686004)(151773002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THFvR2FUK1FrRVpISTBMdXZNYk5waVliTkFOZEdHTmNCZWtUM0h4amNiVXBD?=
 =?utf-8?B?YUxTMlVVZDR2Q2dvbTZvbWk3Z0djOEUvemU3b2N0Vlk0ZFpaNHkxMUErMEQy?=
 =?utf-8?B?RXAwcWFIc0dGeE9Gak1mYVBsbGJqc2lhdWRzR1hRT25XRXE2bmcrcHdobm4x?=
 =?utf-8?B?OS96SnJSZnVLWGtlZlBWUFQ0ZFVlY0tIMGpkbHdnYmJyZEs5Z0gwSWoyVVFk?=
 =?utf-8?B?WkVUblVETWwrWmg2Rk8vemNJaG81V0RrQnJhUmhVQlYzbkZOU21WMUVLK1pv?=
 =?utf-8?B?Y1ZHOHduNnhTTVlwT1lWOU9vck9UTWEwMHpNYjF0YlVYMFpKYTFBR3RhZkVB?=
 =?utf-8?B?NkI1aVhtUWQ3V0xGRGxIdldQd2JJcldqRzUrQXFJL0pvWUtPT2l5S2d6LzR5?=
 =?utf-8?B?MHVGckk2WHA5VEoxemFNcStTY0lVdGc1Y1RGTmtLZjFXYjkzMFYrc2UyS0w1?=
 =?utf-8?B?dlRrM3hVWEl6UFJaWGIrTXlPYWgyRGpUZzVDSjNhc1Z6aDQvT1U4emRxOUFz?=
 =?utf-8?B?clFHOXVxMzNwZTgxODY4WTcyZVNFNHdrMjJGN0JBOFhlNjNhczJTYjN6QTZa?=
 =?utf-8?B?dEt3NEc0SXJxTzhkRy92OFZTd1BLaXFKVzcwWlRFdExLbTFpdGdJR2F2elZE?=
 =?utf-8?B?WVJncWVueG1KYWcrVjY0OTdjTjNaT2VZWlFYaUgxVW16VnVXZzZUREVOSE1q?=
 =?utf-8?B?M0k3TWljanFDZCtMUmJjVFRHeWhvYzdERjErUjQ5ZHlNZ0lEdHdlRm9ON2Rp?=
 =?utf-8?B?RGRMWk9jMDFBT1JaRmhrNXkrcmxaTFZENG5Ld0Q3d2I5cDdaKzREVzd1Qjdi?=
 =?utf-8?B?ZG9TTEFBL3FwRWhialBVUFY4NlNGb1ZEWUVMTm42dStGM0FIRDVxN3k0Q01R?=
 =?utf-8?B?ZllKNVNMalg2d2NIVEpPRDlObXNFdFEvZXBaSmZuSzdvcmRYc1VGYUFGMEdv?=
 =?utf-8?B?MnVCek50KzR0K0RvZjJRak8raVNLYjF3cDQ2UUdxTmFLS0lCR3g5cVJwNGxq?=
 =?utf-8?B?TGlBaHhHL08wa1NiMk52RFUxTW5jS0dBSTZqMVV2Zi9oVGk3eXJrb0lkMjk0?=
 =?utf-8?B?ZmFQRy9EQklFUEh0MTRqMEtTNENvME92OWZ0SkJ3TEFKMHlhOWJxZkRySDBw?=
 =?utf-8?B?b2dBSXZMaHovT0dkRjdBLzFyRDlLcWVmNjZaSjJFNFBhdVVHSUFCejlzN3dJ?=
 =?utf-8?B?ZVFiU0RQWE82K3d3QUxXQmxGMUpXUUxmeno5T3lFdW9kQ3VHbmEyeGQxQUtZ?=
 =?utf-8?B?czU4NFVRL2NOSHZqR09vZFo1dzBtUGNCM1FtOXl0b3luNmJCZWtuWUNvSWZV?=
 =?utf-8?B?KzA3enpOZTlqbkFZN2lFOU1vNUhsbmlRMkJFeG8vUVIvWFA0ZUg3M1k2VkRO?=
 =?utf-8?B?OUMvcERqQ3NyczU4N3U5Ty9CL09XaXlhNVhNUXhKNWhKcll0QUs4VE13T01N?=
 =?utf-8?B?Q3NxY2lSaXhEUmZVVTNaRmhGN2NleDFLUGdjOWdCeHdFQlJReDVDU1N1MExF?=
 =?utf-8?B?WSsxRmRjUm8vcWs5SUx6NUhFR09iMFQxQ0tBUnlWeXN3bTVWUnVzcCtiOGts?=
 =?utf-8?B?ckF0OVlVS0V4bkZCZnVWbWFlaFJ5TWt4ZEptM1Zmbzdmdmw0TmNGaWJINDJY?=
 =?utf-8?B?cmRqaVFRWmJzWEpTa3JCaEM2cTdFVi83eGtvcUNIOUgwcldROWppUFA0cTJh?=
 =?utf-8?B?MlFRTkNwRk9qUm9GampncS9ya1pEU0JORDczY085WXVrSHgvSzFiVTJ4TmhB?=
 =?utf-8?B?bC9YaEtMbld3Vm8xakV6L1NoanRRSjVJTzNzaVdsekxFY2YzbVJjWHRwV1M2?=
 =?utf-8?B?Uk84R2x6ZlhOVE14TmVreVJHcDRCaFRmYUR5SEcvTW94eUNRY1UrZmhEcTN0?=
 =?utf-8?B?dnFNanE4akhuODNHRmdEMW5NaktEZzFrUmpGRzl5ZGlybHR2clNYZjIzZ1Yv?=
 =?utf-8?B?MC96aW9pOFBoUVZOSzYxMHdXUWRTcTQvV29PaDQ2ZVMzNGNTN25BNnl2dm1q?=
 =?utf-8?B?OVk5cDlaWDRyUlQ2NWVNNEIzcTRsNFJHbXRtc3RRRXNxUXlpLzBoSU9ZSW5m?=
 =?utf-8?B?SzRQLytJK0FueVFQclY3Y0RySDJyZkdKQ29sQXNna0FEZTVmR1V6dWZTUmM5?=
 =?utf-8?B?M3QrV1JZbTZVbTZ6TnA4L2pQOWVxcjF6TmxHRW5ybHE3b1E1YUc5VnpackRZ?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4277fba-4536-4c84-6c6c-08dbcbc74339
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 08:34:49.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/ZKPJI4EZ+9selNDUbgjUseCB8PINy59/dsru7Y1SH/jn+WQYLCSG/bxueMJTWYNHzDINdi+ZOxErRD12h8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Oct 2023 08:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13395

On 11.10.23 02:03, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi,
> 
>> On 10.10.23 15:23, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
>>> My understanding was that it only targets wks files.
>>> You are proposing a generic **OS image** that will work with other x86_64
>> reference HWs.
>>> Is this correct? If this is correct, we need to create a reference HWs common
>> (super-set?) kernel config).
>>>
>>
>> Exactly. Just proposed that also in the TSC. Open to hear if there could be any
>> conflicts/blockers in that direction. But I think x86 should be rather
>> straightforward.
> 
> Got it.
> For example, I think we need to align our thinking on how reference hardware providers handle things 
> like test images and test results.
> Provider kernel images of CIP kernels would like to share them when running tests, etc. However, reference
> HW providers may wish to test with kernel images optimized for reference HW. In this case, I think we will
> need to configure the reference HW as before.
> 
> BTW, I created a kernel image by merging the kernel configurations of VX2 and IPC227e, and checked that it boots.
> There doesn't seem to be any problem.
> 
> VX2: https://lava.ciplatform.org/scheduler/job/1019349
> IPC227e: https://lava.ciplatform.org/scheduler/job/1019328
> 
> Best regards,
>   Nobuhiro

So, what to do for the upcoming isar-cip-core release? I would not mind
too much merging this for now and consolidating later, after this
release, if this feature is time-critical. CI will not grow with this
patch as well for now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


