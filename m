Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C58AC636CC
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:44:08 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.69])
 by mx.groups.io with SMTP id smtpd.web11.15981.1676299440533044721
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 06:44:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JZ+g1WsU;
 spf=pass (domain: siemens.com, ip: 40.107.105.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfVPySPQJJO8u34FSKLbbYgmnKhQeVyRWBVys/xkcC+qkvDZukxWSLZDLVQKs2r6oMv1wz3L1UO96U023ujwl0yo+UFSt2ITTBO9abqJ8u4WAb/JQKC16cQKEOLkwtlZ+dIojeHE5HUaggjClJTrFeomMUUhx0rCyRUkUnqxGOxG3l/hpW4hwW96ETOqljkU6SbvQak5KA5h/CFaNDMFSMvYHQ1SZxXweJs+pUqX51h9EMQ8kWA8oCTHIj94sKv49XTWi2BYBqvuFQ78dQ2GH7YJlBKM+x6Sl5CtjoUL8+xibhQTDn2SWCyH/Yb+SANAdlIGEAPeqsQGERbEANeaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNvUdpjmECJ3/2pIICW3FFHkB3eGbBKR8fGed6Ev7Lw=;
 b=jQfGFf2abcAtatfVrT/tc+qRWnhmMBvRVSUdhi28OjXwgLnQ+Mka3jki/7He+aVaDBjV26c509M6TfkXGZAF15HYd75yAfu+UaeDifkk0oxmopXgl9z3p+PZ7HpnIU65xcNYPWJaE939TkW132IAvZxXl76iFg7wHAS1yf0+92uVLBvxOaaT6Q9TqhKXh1U7hxkyVirLR7v0ulF9W4Vhh/yMSc3LUIpx27XIvvDRIVQ6I/NrBC9I5EsVQuJTI5ySxWiqgQ0/mDWX8wrQ4o988KCT+FIhCTqUSyHbTb51eetJ5R25LifeCquZ3olu1nD2sJpUZL6iwSDKr9fJxGCTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNvUdpjmECJ3/2pIICW3FFHkB3eGbBKR8fGed6Ev7Lw=;
 b=JZ+g1WsUpBiwwaqZsyiSW1gAnEJkEEILqaLQADkH9YP5om+qKxTw6GbqOf+dVu2Xy8A3EH1mpcXIAsFcVVdq947UYrqFvoQmhd67C5FFYsN+UXVKreV8G3dBtMiHaBkzEyTFUrbydkXL2WPx1D1O2b7vv9xEqqHnLIwTU2bbTrXmCwTajVtMn2Fkk3gP9KpdbeluFEwyAhR2oxP/bGVP9y6KwstB4HfMNvQYxIPdv9FOR0eI2kdDA9ugpwTen4HRzuwGbgFcuI/Itt9x+8ARhaRYWhF+yrT9uzuUoUcWowBp8fH/Cof3shgm7R0+bbps/mAE2aqu7L4FZ6Dr99Hdsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 14:43:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:43:57 +0000
Message-ID: <be9f384b-113e-f5bb-fa85-51ce9f194860@siemens.com>
Date: Mon, 13 Feb 2023 15:43:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Content-Language: en-US
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
 <f2a2f503-c85e-bd28-aae7-4624283f018d@siemens.com>
 <b0784e004e1ea88e77070d7e01ee048758b02605.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b0784e004e1ea88e77070d7e01ee048758b02605.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f462918-6bb9-43b6-2e9d-08db0dd0bc74
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hL8BoWnq53Fw8hyDV5UPh43Nktd919He96n8yrleYlPW4+KFNkf3tmcUCi1XjTqNba71VSSdQuLgRCBsKJznIxe7851vgyevaUNsG4tVa3rQXMhVq0nmT5Nv1CPDCIyuIAOtrKGM8pCGn1/FrCADqFnJ9T2bsn0aADuuqUv5x48eND4I5v3cG/QZPXQ174P6CNcax2B3kz2q0wZDI7trJXmY/hrvUS6U85eTD3iXTJPOj/ArlbF7LrbiYFlrT0GkMGvRFRWpBbiCX8sdB/ta+7+evbtm31HSeDRdsvB/4r+p1yax7CjF9igyf4Z+lXCD11BsPJfZjwW1yjKMfUfp7IXklIEVTl/0/8Z6SXkjgnm+D38uHty9q8V0g9cqSufQ5KnMKwgZmvWXoZC+EEyLBRF2N/qRrS6cHp1ZMBYAW+NrpR9rn4YUVjZDxzTGlxJWZK1qe1pYNZ6k5WBf3n8qwyKqlz7PZuvGlN+BkU06UABQ3eM4zzwxQ0wg+cg2Pr7WHL0i5KfLwfn5FeDhKauto1BqwCPA7C3WZzazHLPEQA3vfARQL7/ItaPJTGMDyJ/cwjYiTyZeRAasHLoYQ7yDx83G/RjJRKXMd7zOv1TD3ld8+z92Jyurmktkvp0SvNK2VQjySjiONRXAGTRJ1gcO9SFNIp7tZmBr0MPRq+Nx859/W5d/4Wmq3HKiMLSxXv1hlPtrUvXa/jkG7q6I0b2Dq0l7//pDJlbP3mgobRbN0tY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(66556008)(5660300002)(110136005)(316002)(8676002)(66476007)(4326008)(8936002)(66946007)(2906002)(44832011)(31686004)(41300700001)(6486002)(478600001)(107886003)(26005)(2616005)(186003)(6512007)(53546011)(6506007)(6666004)(36756003)(83380400001)(82960400001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?azBqTzN4WGxoZm5TeU5aVldvRzUxWG0vMVVuR3cySUR3ZWZOb3hLclUyc3k1?=
 =?utf-8?B?eWtGNTNpajA2bHRuQzZwZlkyR3A5VmhVdmhEMERTZkYzY2Juek9BbVJVZ0RZ?=
 =?utf-8?B?LzE1TVdjZVlqRDB4cytLUWEvSldRcEZFTVRKUkJmZ2E5azJLZXc3LzVkT3c3?=
 =?utf-8?B?WFEzR3hqbjNJQUEvZjM5ZDVrakJTL1YrU0h6NlAyZ08zS1hOLzQ1dTN3TlR3?=
 =?utf-8?B?bjBIdUpzUlA5bTc5YU1mU1E4cnFOQmNHYndoT3lVS001WGhvT2VKdHZra1hC?=
 =?utf-8?B?TUlQc0MwYlZDbGdPdDZCYkxYa1Rpa2Z1eXdKMERKbnZPSHpXSXpiejFBaUlp?=
 =?utf-8?B?NHhqQVdJQ1dNenp2NDlSMkRZenVnaVZFLzhISkRNZGkxMkZRbTlZcE8vcVIz?=
 =?utf-8?B?S3VvZFNaOW54QkNMZld2Q0tuS0RFd2JjMnBMUTd4TWhvdERiaXFOaGdVWWsw?=
 =?utf-8?B?ckFHVFZpbjNldU9nUG0zVmlzYjdUNlhTTks1Q2E3L2U5ekIvbkhhK2Y1dzR2?=
 =?utf-8?B?MmpweDROV2UrMHk0MWVGd2xVWDMrY2Z3YUZ6dkZadzVpb29zeC9FbThGNlRo?=
 =?utf-8?B?WStGb3I4QWdBams4dGx6NDBHZGFEN0Z1SE1obUsva1ZsRVlNM2tlQlA5NVVX?=
 =?utf-8?B?L05LQ1FJVmhzTkkzRUt5V3IyM1c0VmFJN0FBRHFWU1BldDVJSDB2UTd1NVFi?=
 =?utf-8?B?T0V6dEhtbTYyVTBzTzZRUGs5bTlzaGhpMzNWWVZxRXBhbG9QS2srVXBuWHRr?=
 =?utf-8?B?Y2JPYUt0djBoa0JEOUFZcE9XV2JNVEREQjBCdU5vT2wzS3lGanZOSmRCck5u?=
 =?utf-8?B?bmZwNHg3bTczdDhsa2Y0VlhNd1J2R3lXWmpQcDRKaDZRaVUrT3NkMlk3ZmJD?=
 =?utf-8?B?QjZTN1RENlM1eU45QjJ4WTR0MG9qVE9ON1hwV2dDTks2RXJ3bkVCWXFlWmdl?=
 =?utf-8?B?VldTNmxuSWdZaGJ5NExwVW5paFdqd1N3UlFUTmNEbU1Nd05pRmdSdmlUTVFB?=
 =?utf-8?B?NFp6TkRVejEvUVF1eXB5MWRDdzUybEJrVzU3UWxtQ2g3Q05SaEJHSjdnYTZW?=
 =?utf-8?B?c1YyWk0rSXBKeE1jSXRPSFMwaS9iNHdLdUpGMUJIRkM5ckdtMVB2ZjNFbGhV?=
 =?utf-8?B?Y3Qzc1QrSmxZV3JsNjkvWGJZSXRWR1d0V20vMDJkSXEwVnlLeFlJbTZJTWVD?=
 =?utf-8?B?ei9iTEZMcnE5bWxUYzAwZU9NakZEWUs2cWsvZ2ZpQVc1M3VDMW9RVHNlRUZO?=
 =?utf-8?B?VGRwR2ZPa21IaG5kdjR0NGxtREwxall1RExkYWUwVjBJNG9kMGJqVURqNUlH?=
 =?utf-8?B?d2t5UVdQUlduR1pNU0ZKSnNSMlBRMnVkNFlJbitMUkx1TzRKdFJJUjZWUFp5?=
 =?utf-8?B?emZRcWgzQ2pIQmJ5Tlk0T1NjMDI1SmttVlVCenQ0YytwcTJZVXhaVDU2MmtD?=
 =?utf-8?B?dkFxMDNLTXJHU0NqMFpOUkNLdmRtVDlxMUtJNm1ZY1VtZUhpakxRbnRzZmk0?=
 =?utf-8?B?eHlmdmdsZzJGb2VUam13NDYyYWFZYXYyM0VlUUVrTFk0a21uTmlkeVZvcTlI?=
 =?utf-8?B?ZUFUckVJTGE5SCtVSDhJSlgyWTg2N241Rk5RdXN1RzB5MTlTekRhcUdUV1FJ?=
 =?utf-8?B?RG41Zmo5ZC80ZU5vODRRV0IramFJTkg3bzgwL1FmTWNJSTF1a2tqM3ROTWNC?=
 =?utf-8?B?TTd3cnZydm9BQld5bVVWYlNINGM3elpXRmFuMVcvQytuTGV6blQ2ejNxZGRJ?=
 =?utf-8?B?eE9VUlNscnM0OXFLUWhDUVBZRFJhTTlaVmRieDlaTzFaT055ZWZLdjRab2tp?=
 =?utf-8?B?aHEvSFVCMDNxRFROZXNKZ3pHS3o1QWp4cnlWdFVqY252Tms2bC9CTjROTHVy?=
 =?utf-8?B?L3d0MTlsYXp2MFJ1SUpodWNrTkRDNncvRWUyRysxeXpyRmVSdmYrWFJMVUcr?=
 =?utf-8?B?Ujg4WWU3RjZ5TVNtV2FDUW1JMFdoOGpzSUFFTEljamR0VkptVU8xUktqQ3dH?=
 =?utf-8?B?NW5WOFR2NVoxL2wwRXdMSlQyMlRFbzRITW8yNVRIU3ppZXBMaDVBbGk3L2pS?=
 =?utf-8?B?c2YwWlRUWEhRY1pjcFJranVFdmtHZldjaStVbnFlUUJVelFUY0NINk1uclZr?=
 =?utf-8?B?eVBXUzVxWUk4dFlKZFBIb1I4RDBUeEdtc0RXQmxGL2k0dm1OVGY4VWQ1a2M5?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f462918-6bb9-43b6-2e9d-08db0dd0bc74
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:43:57.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+Zg/An0pnO07qsd4oWAdqIR8MlqkodNXNsiFQ4MvdnOm2wPffCQ3rYUtsVsvAgDOiEJA4SBkd5/0HxuoGTQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5387
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 14:44:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10679

On 13.02.23 13:09, Moessbauer, Felix (T CED INW-CN) wrote:
> On Mon, 2023-02-13 at 12:29 +0100, Jan Kiszka wrote:
>> On 13.02.23 09:57, Felix Moessbauer wrote:
>>> The efibootguard package is architecture specific (similar to the
>>> systemd-boot package). Hence, install it for the distro-arch, not
>>> for
>>> the host arch to make cross-imaging work.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>  recipes-core/images/efibootguard.inc | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-
>>> core/images/efibootguard.inc
>>> index 26026dc..b3fe911 100644
>>> --- a/recipes-core/images/efibootguard.inc
>>> +++ b/recipes-core/images/efibootguard.inc
>>> @@ -11,7 +11,7 @@
>>>
>>>  IMAGE_INSTALL:append = " efibootguard"
>>>
>>> -WIC_IMAGER_INSTALL:append = " efibootguard"
>>> +WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>>>  WDOG_TIMEOUT ?= "60"
>>>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>>>  IMAGE_FSTYPES += "wic"
>>
>> When does this bite us? Current master is not affected as it seems.
>> Bookworm/sid, when all efibootguard archs are available at the same
>> time?
> 
> Yes, exactly. When we build it manually, only the "correct" package is
> added to the isar-apt (because there is no other).
> 
>>
>> In any case, another regression from the switch to buildchroot-host
>> in
>> isar. I had fallouts from that as well, and they are all subtle to
>> debug. Must be documented in upstream's RECIPE-API-CHANGLOG, with all
>> its aspects - please fix (you caused it in the first place ;) ).
> 
> Well... in my opinion this is not a regression but just a bug that
> shows up because we "cross-image". But yes, that doesn't help our users
> much. I'll add a changelog entry.

The original imager was built around the assumption that it runs as if
it was on the target - hence buildchroot-target. That was changed, and
it hopefully will never trigger any problems with Debian bootloader
packagings themself. So far, it only requires downstream recipes to
account for this new boundary condition. Thus, it broke the recipe API.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


