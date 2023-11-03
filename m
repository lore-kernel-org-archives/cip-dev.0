Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F3C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 12:12:55 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.41])
 by mx.groups.io with SMTP id smtpd.web11.49366.1699013565034752778
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Nov 2023 05:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zGr0TjXz;
 spf=pass (domain: siemens.com, ip: 40.107.6.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSSunV3IqMfPjtT+9Vpzo5CPQsFvFQ418Zvy/E1mDL8qhqNr2OTEc31SYFDOpa8dzimTK1r9nhz6BmBzbgXeY2V0KBJBqSYen0qHcerYnZPRLiiETDDo2RLEaAdwjnZP3FMQEfFKx67e64Pe/gi92iHTQ0V1K4onaR44w30jGtP572PcIZ6RW0qUi9S2+u1Cku045rF7O4+OARaOM/thonRyuoB2WFHfPGI2G6250tVwFEAUHyyc5E4V9L1Af22Oyoo+99a86BUYy/w21LdzeaAwZ10RtSEnSueGr4/ckrgTo1IiRj5Mfd7Qou/H0ZzwpmOAPHt6G5SgLVqymLR4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSb68DrTVSIcNOJF261cletHaBSBi62LJwV8WPhnxXU=;
 b=FJprxydKdd5Pr2fnIwRLuLd1pJmJ3E74yWP2xt06v3HJLovFr1sk+XimzdgEi/ILHxXEB/5ivEpg/ydhfRt4w6/NJxQa+5UY3URqT467AseM0JHXtjMYV459e6OcXGunSgtYt5hJwIVwct2yEgkl4rymEmMv4/oHi94F0IJmvWqLyrWiUBmpF4H9cTCqQwNsYJmjbFy7O68nS7i5MZ6PPoEVps06jtxzUIdNp8W87WQOaaseNlaeKqoVHihsLZKhJjVBU1hR4QoEAng9xACPWwU2n0n9YQ1bnnrhNFQgta9yvheBxH6qydl00LjlTGzoJ1RI7acr3ezH2WvrbUfpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSb68DrTVSIcNOJF261cletHaBSBi62LJwV8WPhnxXU=;
 b=zGr0TjXzI+UYs3b5DWDww2/QD6Xrl30KHTsUb/SZLFpR/tKkT/5gkfl/rYQnesA8t6N4TGSgL9OhVQyZBsbpBs2q9oH24oWgiC98T0yl7HKHPMdpuRh5HhuXcfyTiLh2adSWpt2VKotof9g9l9WEkWIbnGtzRfUN0UCB+d8k42pDdkiXNK/8gJ4FqcP4alKn4sRL9l3AdmOWATquBsifhVliZIeYpMkU7BeGqgxSs7rRIIW9ypVOLA6zAbO5c+GnIOGXXAUnhPCNqqCxPXdjK1Q+GqCvZaORkodaDDWYxj5BKjt6O52/e6nYOkFLom9fpLxlGplScnl4AN88qdIKaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5448.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 12:12:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 12:12:42 +0000
Message-ID: <ee3397cf-d9e3-4888-ac84-ce53a8a516de@siemens.com>
Date: Fri, 3 Nov 2023 13:12:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: about "x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs" in 4.4
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@denx.de>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
 "masami.ichikawa@miraclelinux.com" <masami.ichikawa@miraclelinux.com>
References: <1974154422.1865436.1698902356282@webmail.strato.com>
 <ZUOHFBqa5PycOF8x@duo.ucw.cz>
 <1467992071.19758.1698927166477@webmail.strato.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1467992071.19758.1698927166477@webmail.strato.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a542d7-2526-43a2-d6f2-08dbdc662de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H8sF7tfQPPRW20PXbJHni8mnWfCJGNXXi9pTUa9Z2R3uWrTxkFHam9qRH8xmZjoZxYhuT1wJR5Bhg0S71EPUM5jQxPf1E696EizZ1giljwjLxlDiaKyI3c0Caio74g4elcSW0yp4kvRSaGCJ/pI4yLQFEYy6C1JZaqevrngTkWrhnkthzZdEk19DvrrYDLEPTR8E3k2GG/g2W72ZuCq+VGRAM4A7tg0aPcOt4JUzOkWHQdG69VHZOK4srvdU+U5bbfOuDvZh1opCY0CeAPem00F6NHAvR+Ups3/xwq2VZrRTGCdaoZXozabC/sMRYdEjErnRvXVfFa4crhA2BYep6XRdEeEixFFGYMb5m/eTPo9eBmm4IFG9pZwhut2eVV2l1IUBhMxk3IWvNFD31VonR62y26ZTPhW7ML2DUGPbOTfbTox8Bmc5L+31YUdgmvMlTGtGRL89pzj1p/kM+mit5jOv4wK8EcbjJHR6liR+LYTeYMnmQHS4VddR6BM8jnrVjgfj2HVEMNKpf1H79o/kqcVmsQknaBaIHuAF51vXFSG+wqWCvfmVv6kZUMB7UMJ7OZnFERYvcODPRH9x1/MGYJ3YPlLS66TCOf1RYNHphbupgTJR+DTeeysNR6XAXjaOMBwr7/K1FMLAcJsmWdmL+A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(6506007)(53546011)(6486002)(478600001)(2616005)(26005)(2906002)(41300700001)(5660300002)(66946007)(54906003)(66476007)(66556008)(316002)(4326008)(44832011)(110136005)(8936002)(8676002)(86362001)(36756003)(31696002)(38100700002)(82960400001)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFBFeW9wS1FXa015Y3BkbitqemU0eVVQeDFjdjRhR2RXOWt6dm5wT29BdVVu?=
 =?utf-8?B?SzduRVQxRFZkTDYyYVlqUVpKYUxTMjdiazBiS2JpQjNiek5DMnJQUTlpM3Bp?=
 =?utf-8?B?YXdPcTgvNnRrQWhUMG9ZU2RKM2VOZkNxeDdOUlNWbUFPL1JuZU5qbWZHbW5V?=
 =?utf-8?B?dGlOSm5nWWFqTTBSdjZyZWhVSkhIZ2htSUpiS0JrZTBHYXRwaWtlbkprUnp0?=
 =?utf-8?B?S1h5Nnl5QkhnU2c0OTF3a0xFV2pCVWJWaGdzU1RUZWo0d3J2VXRKOUZ6YURO?=
 =?utf-8?B?OStETmZrZW1COHZYTjFXcEpBOCtwS1FaTXAvVUdsUjg0MzduY3dSNWRjYXFC?=
 =?utf-8?B?bVdyN1l4SFVrcXVUclJGYk9BNEFPNVRsNlZuTzNEUUk3RkcxOWxNeFEzUkZ3?=
 =?utf-8?B?UGVmNG9VKytoVDVmNVZuR1B4em9jb04wcm5kckhwMElZSW0rS0llU1BJM2s3?=
 =?utf-8?B?N2VFRHBtL2R6cjZEbERabmhxMVpFRDllYUZBdE5DVjBJMjVjV1p1Tm5xb05J?=
 =?utf-8?B?b1BMSEhZWXFrbXZXeTNxQlc3QkkyZytXOUpRTm1NZERUdUNTaFcwaXErUWJO?=
 =?utf-8?B?UGY5UWNVQkZLRVZoWW50N1FYRzNpWmVRb1VOdXpKRWlLRXMrcVRTSXdCQWM1?=
 =?utf-8?B?WllZdWloMDgzU1l4b0tQRFB2TXVCWFdhaWJ1bkl0UmR4MHVvYmpwTWN0cXVH?=
 =?utf-8?B?ZFF2SWRKN2l1Zmp1bDRTWFRnQm5qQU5nL0tWcHZGSTZYc00vajhqRGRIUTFy?=
 =?utf-8?B?dXFCYmp0bm1yQlNLZVdlZnNGZk9EdXJ1R2VxWUxDRk15WThaZ0N6RTZCVHl6?=
 =?utf-8?B?NHVPWHFqSDJxRlhUNk5aSFBSQ0Z0UDNxcUQ0TU1wZjZsTnd1ZTJGZVJHWjZY?=
 =?utf-8?B?aXNncE1sY1lueWdXbCtlVVIrRGNmYVFPUXc5ZGw2TGdWdVZNaXQ2Vm14RmNQ?=
 =?utf-8?B?azJibHZMOFJEM1NoaTdPcmVYYVBibFNPNDlMUzR0UyttT2ZOWCtaNzBKSThT?=
 =?utf-8?B?alMvMWMrc2E5RkZmTlpJOG10TUFlVG4yT20yQmRROXdpU2R1VlEvWHhkNU1K?=
 =?utf-8?B?eExka2prMzJmQWtNL2NDQjlqbnZyVXE2dUppcS9jY3hzb0w2eER4KytrOGhz?=
 =?utf-8?B?RWVFRzYwV1RjZ1BLR3ZPM004ZFV4OE1LNHVnWEdHMU01dVBvOElaTHI3U0Iy?=
 =?utf-8?B?dHZiMksvODZMWXhoZmJPTlg0WTd1MG5xcmQ5bndMS2FMU1YxTGVJQzRLRDFL?=
 =?utf-8?B?b2pQZVBoSUZqY0FlbTVoVCthZXJrTDRaaEdwcUNyUmJLSmZ4Q3FTNEk3eUZj?=
 =?utf-8?B?VlpXM1MwNUlxUGtSV2VXaHNlU0VjZStnWGhEL2p4bTR5YzRabTFRVGZwcXhv?=
 =?utf-8?B?ODUzSzV4b2hSWnU1b05uSURQRkZoUkJhZUtMQU9aM3YvV3BaemNDNjhSbDcx?=
 =?utf-8?B?cElBYjV5bndSN0ljVHRUYlRJUzliblJKYWVEM0dQYUcwM004RTRYbURib2Rz?=
 =?utf-8?B?Z1o5U0hyN2tZWVRUOXk1cGhDVFJjYm52SGhpYTVxQ1pQRHpXQlN5dVdLdWt5?=
 =?utf-8?B?ZnUvd3RCamkxV0tGS1NrVml4V21DY0NSQzF0R1M4R05VS0o4cUFaa1QyRldp?=
 =?utf-8?B?dzZhTWRVWU9pR2lhNFZzTGNqVzJmb2tXeWhBQ1VtLzVraGNFeE1sVHFnUG5R?=
 =?utf-8?B?QndVVFRNQXMzU2lodVBxVWVFNUpnbGh6bEVjZ3cwWUJpKzFMR0J0U21ObFlp?=
 =?utf-8?B?MnFYTlVCTS90dnJNSmQ5OGp6TGJadm5BdUs1OENOVzkvOW1JU3RJZVV1Mllq?=
 =?utf-8?B?OWxLT08zMmE3NnQ3MXJkb1BGUWF1endRcFV3VURlZXY4UENjcDBBRlArNGlB?=
 =?utf-8?B?d0s2bVIzZFluaDZIQnVuSFJwRU5WWkZFVU9aT0E4QVZ6ZVpyQU9McHF5NElw?=
 =?utf-8?B?Y3JrQTBpL2ZnUEFjdnQ2Y29sSTBLMmpyREJmWmRhNms3QWg4ejdHWkRxeU5h?=
 =?utf-8?B?ZmJiVEk2MmtLeCtkdnFSQU1lWXh6Y1JoZUYvdTNkTklWc0ZzTVptdEo4eGp3?=
 =?utf-8?B?dVhpUjdvSTVUQnNXREFGbnIxWWpVMEJwWWZMWFF0QVQ2WnYxTFVod3BPNTVa?=
 =?utf-8?B?LzJ2aU9wS2VTMTJNS2FlWEZGOFVlanRqVmo4ZzJHOFpBZXZoZ0dEeEs5b255?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a542d7-2526-43a2-d6f2-08dbdc662de3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 12:12:41.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXjbxHzhTwWm/zWRVEM+/eX3SH0Ph+qiloHcNvEpJL2uQBuYuN8oWM7y/+bA4t1E2WT24ybJaCcAgIFibeVbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5448
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Nov 2023 12:12:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13533

On 02.11.23 13:12, Ulrich Hecht wrote:
> [Cc cip-dev to get more input]
> 
>> On 11/02/2023 12:25 PM CET Pavel Machek <pavel@denx.de> wrote:
>>> I'm not sure if that should be in 4.4; maybe somebody can offer some opinions:
>>>
>>> 1. The platform affected is post-2022. Do we care about such things?
>>> 2. It requires backporting of the whole AMD cpu erratum
>>> stuff. Annoying, but doable.
>>
>> I guess it might be possible to re-do the erratum stuff with less changes.
>>
>>> 3. Not sure if it is actually required or not:
>>>    It's a fix for an actual issue (spurious undefined instruction exception) that is triggered if STIBP mitigation is _not_ enabled.
>>>    AFAICT we are indeed not enabling it (not backported), so unless that is done by the firmware, we're affected.
>>>
>>
>> I'd guess we are affected. But as we were not backporting previous CPU
>> bug workarounds, it will not be easy to backport this one.
>>
>> We have "KNOWN-BUGS" file explaining
>>
>> "
>> Not all speculation fixes from 4.9.306, 4.9.310, 4.9.319 and subsequent
>> kernel version were merged here. These affect mostly x86 and arm64
>> architectures.
>> "
>>
>> I guess explaining that listed AMD cpus actually need speculation
>> fixes for stable operation, and thus are not suitable for 4.4, would
>> be an acceptable solution.
> 
> Sounds like an attractive solution to me if nobody actually needs those chips supported.
> 
> Does anybody know of any use case for Zen4 chips on 4.4?
> 

Unlikely, and I think it is as more reasonable approach to list this
issue as unfixed under 4.4.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


