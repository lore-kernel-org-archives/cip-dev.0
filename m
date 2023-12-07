Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522BAC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 06:05:44 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.53])
 by mx.groups.io with SMTP id smtpd.web11.77394.1701929135011874454
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Dec 2023 22:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VhdkjcdQ;
 spf=pass (domain: siemens.com, ip: 40.107.15.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcI7IlNzCSZTtPVCwPdHUEWpPGd8YM4q2PEytQq0S5YQfCTO1A0cz/d6WM/gSD5rRM/q8cfCEjaRbc4taLG3FSrVmRMcm74dYJraDl42dYtZ/g5ABMiRbGLiIzC0ZZEGikXPod6btbccj1Zi2receQxJJAFpgxcTo4ntvkJMRfU3kj6On8c5PkvW7MIZj1s5Lz5IWLz5W6Z3qtsatzg4MJE1S5NpXxI/UTPAmGiMo4SY4eiftYbh8hTanc4eYjKFdkvQCmA+YdALA/rDHtZlSVojwBhTuHr7+L/ayyJD+qpi5r+7tBON4NnVKZGZu/99YLhA/TBCZIIOKFycfIs5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWUWMtBKRmX+OK8jrihjIB8LR2r8NBB9dLLi1215yyE=;
 b=HJbMBbJ6DR4ODs3bEgcPjGadEfMWOXGFzTmMoZs31dMsc2NSdJv8v+iCkzN6/P4UGxuqlcpY9XKVge+Rj+WFyePPi08V+SAtEowR0cpNhg2JBf1GAS0TA8Z6HvzACgSu4zLsz7/lt1F945YtmAEdWVCiHCV8qfzX9xZxb93VbGmfZAEopNqzxX0qeGAn5gjpiBgSxxQ3eJRDjRVoFt8w4/6IQtNxi08guZ70o6aGNtJ+7KKp6kOm5hz8lux2XbY746VxJ73kDvfdEX2W3RiYqWu3mSeoPwuq33OqGNPps31fi5G8BybbTttHk8LUnRBh8M/nxShPyyZlWhr/UCKfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWUWMtBKRmX+OK8jrihjIB8LR2r8NBB9dLLi1215yyE=;
 b=VhdkjcdQT2IThaTC0NV8qU/bcS8UBesyzmi3Si95R7/75MY1TAcD51g2+CZoFPwt3QyZo8K0hbX/mK+zmHDhQJ9HsG/qKYQorBNXp/sn3NMzHeLxwUxv+cX0SmAM/gna/6dzniBgMNnUjWVw1oKvTuM5DjbSlWWJr/+1zXmAaAOR8jZI1oj0dBF53wcvTn3nP52iGkUjP0gyrkMlf9RKc17RFdcEXbWUrc0VmAkIruJ0N0A1TnWcAOfNlj1zaxoagdKp54AazpQnXP73Kqa/7ZfJv5HHIaDNoKNITACCgBk/N5/fx/v6qnsbRYa2OdXkBfzw+LnmXvrB71zYjoWC+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 06:05:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 06:05:31 +0000
Message-ID: <c9fc5654-897d-42eb-acc2-3c6f3f318015@siemens.com>
Date: Thu, 7 Dec 2023 07:05:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 0/2] Add Bootloader to Update binary
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
 <2be59100-035e-4008-9b41-a7758f811b0b@siemens.com>
 <e3bee025100366b12334ac2d707456d871027c12.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e3bee025100366b12334ac2d707456d871027c12.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ee1836-8786-4e85-7388-08dbf6ea84bc
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7U/FkZJvED4wxX+EBGuH/jqO86lqBdc8/Iq4DwGSse96qVssyedm6sOPjtYP50zqV/Aduj7nwBtGsqvXypfOsifemuMQDTwgM5PjjS1KHVk7mNZBr8oLstYkDZT1ONq8siGscjQVyUMAUCG5jQl1Y/Sk9UZ0v5pgr9QrH1AkxyuDztWohhciLbz3RLoCXMBX9tVhvs3Dxf/QI2F7TFbn6/HSucEgoGEJxrqamSlZvtc/3gQo8o2U6zeJk/gYji6GRCPpNA7tWMOFMcmFgUe2OwIm7fMsHwYpe+Z0myioBr/BC7acwFn4O/xRRHOLaD5lglVT6LGqLnnesk2QWsul9+0eBG1DnqxhddehJ6G36ffQX7fV/G7KNgJFChOUsUe2EIc6ensfFc1S43Jwkyfel7euVGEnyoIcqwgdoQpFz8WrJFlurQy/Zl4Vj03LR/T8YcNc9ZKEwpkvbPI6WlF/A/NN3Mfp5hSJ6TWSQKgt5vytmu6ncwyhVNvml438Bjjn3US2cLjtTAT+g4zgXQ1DyNzr2titHk4ywKE9CWVZJNPEXJTlsOGw7g6OLFd7DmFVISRuhupJB/Iie198xGr3GDkoMAuG7a8cXqoprKh6L+syU9HMMpjx0AZ4WH08Vip/Bee+10DnlyclIE0BtH3T3g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(41300700001)(2906002)(5660300002)(15650500001)(38100700002)(110136005)(6486002)(478600001)(6512007)(6666004)(53546011)(6506007)(31686004)(26005)(2616005)(83380400001)(82960400001)(8936002)(8676002)(6636002)(66946007)(66476007)(44832011)(316002)(66556008)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1Qzc252b1hRdG5wcnR6VWYxUHdEMjA1Q2ZEc3UxdmxyT05LWGFhUEduRUNt?=
 =?utf-8?B?OHVmZTdUOFRySW4zeVFFcHJaOUplUTM4Mll5dURuNEpwR1crOGpqZUVuQVd2?=
 =?utf-8?B?bzFQSUxKSlVqNE9JczZ6bGIwcUxCQmw1N0JwL2MrZnAwcVNXVGliMGYweTdh?=
 =?utf-8?B?dDNlalFyd20zVFZYSE5wcUhCbVA4WnBwckdEWmZWYVRmVUlPU3hNa2pOd3dB?=
 =?utf-8?B?WGdhNHJzcENPUmZKK1JKMW5BK3E3YWFCTlpjMWY2UXdqRk9YRkZVd244Y3E1?=
 =?utf-8?B?RTlXS1VuQmFTaExhaWpna3NFMUtsTUNFTVkwRzRjNE45d0RLOVhXaG1UR0dJ?=
 =?utf-8?B?RndFbU9iUm1NclpJZGpKS0dncWVTU1lGMWZmWENGUzFNdGVoR1d6TlJmcHQ5?=
 =?utf-8?B?cFV2eTNiMHcvTEFSUGRUdzd5bFAvUVdZWFlZN0ZnQkVRL1JKWENzRzZMREV3?=
 =?utf-8?B?ZG9aajRoVmJpQkdtcnFBN2Z4aTYxUnZDTFgxRWJpSkM5RDdVQWpzZTJ4S1FP?=
 =?utf-8?B?NUx4ZXNhb25QSDArbitpaXhOZnU2WG80UU9PNml6NlU2YVFBVGQ0OXhoVDZH?=
 =?utf-8?B?dzhDTHFaZEFJQWdHRXpydFhTVlBXM2tCbm0xWWk0U3p4SnJlVFpqQVE2Q1hL?=
 =?utf-8?B?UnQ5RUpsU0dXVk9xNzhzZ0IweW16Q09CVFZCN0JQWElpNkkza3JvL0dkbUVG?=
 =?utf-8?B?ZmQyUjI2Qk00VGozV0tYNzgxQy8zU3JORk04ajJLd3ozejdreGRnNk9sR09M?=
 =?utf-8?B?Wk01V2FneUhaVG9sK3dubWlDK0RyT1NSQjMyQlBMc0Roa2ZJOEc0L1YyY1NM?=
 =?utf-8?B?bFRIQVg2cTRTc0xMZUFpZFhubXpEK01XYWE1WVZ1WUgyOXhrV3RtZmk5Q1ZQ?=
 =?utf-8?B?MHNYSXRpajZkK1AyUTZtblpqRWsvQWpYeVJrTkZyYXJKdm40TjhhY3I0WnZU?=
 =?utf-8?B?ZmVGaHR0TTR1eWZ3QXdndFQ0a1k5NjlDWnNib1h0MXhyRkpzR1VqbUp3T3B3?=
 =?utf-8?B?RzRLb1dVNlBxenVieEQwaGEvRlNMZXdXSFBGeC93bXhOK2hzanltNGhPbHoy?=
 =?utf-8?B?VjNOWHlURWI1TVVrM2VZUExyem5CaDdZZ20yLzV5YzBzSjVveUN2T2U4Z28y?=
 =?utf-8?B?Q0hValpCMGlPMC9YTk5xN0pHTG1uRm1KY2s0YUJaM3ZmekV5VjVMK2pGaWRz?=
 =?utf-8?B?UHhUMFNrVGxOUVR5SSt2RUVpRUt4NFBUUmErQmxCRGxyR3RiU3NKdTJtZk51?=
 =?utf-8?B?KzVkMGYxM1pWYUhFeDg2K3NoOU5qU3hXRC9nMVd1aTMrNHNWMnF5ZW1pSkZJ?=
 =?utf-8?B?d1JMVHlFL0pXZFBQc1dFb3hLbnUzNDBYUGFXYndlMXRHLy9zeVppOEtqUTBo?=
 =?utf-8?B?VEVac3daazlkMjN2dUdUWjk4NzJqcTRRZHFQT0V4ZUJLT1lrZG42QWpVaUdH?=
 =?utf-8?B?MktzNmVTVEU5MHZnUUlxNHlrUC9nL01kWGxHOThybDhMRXIrR216ZzFkM043?=
 =?utf-8?B?bEVWaVk0eUpFeklORWk4MWJkZHArM2pIUHlrYkNsbG5PUDBTYWpnSGpERzZE?=
 =?utf-8?B?U0lCTUxSN1I2cVIyZEFNVU1pa0tPbE12Z29tR0psd0lYOGMxVUw4bTJGVTla?=
 =?utf-8?B?Q0FWTkFzME8wYTNucjdjZzBxVDVlNHV5UXhlL04ydjgwdzFRSXJoZlVKelFm?=
 =?utf-8?B?VFRjbWw4c2JwbVJDaytrSUxWT2tKVlRSc0JHSUtoUG9HNTE3emhZdURWcVR0?=
 =?utf-8?B?VDVNS1VSVmg1dHNPaHBybVNldk9TQUR4dnVrK1crb013L0tFekVEQUFnQ1pq?=
 =?utf-8?B?SzhXcnJ0NXN2dVJYMHhmZU5jU0lQazBIdmdsN0NxUkpjbmxHNjdaQU9hc0M0?=
 =?utf-8?B?enFhajdzc0ZrU3h0TjZ0cEIxbXlka0xLMUIwRGxXV2xXOHl2NG40aDh2UVBW?=
 =?utf-8?B?SnllUHBFdVpTRk9CZmFHMEgwZE5BbUpuc1d4N1R1UW4zaVpIL2w3d3hJNW00?=
 =?utf-8?B?a0c3bGpWUkdsei9LZ1E3Rkh4bGV1V0E0ZkJ0LzUxU3pNYk5LWGkvYkFXU1pa?=
 =?utf-8?B?ci8vNk5xakVQdGR1SmVNQlhzMVhaZVBXUk9FQTVpN1hDN0E5Y3gyZWQydkQw?=
 =?utf-8?B?T0puVlo0YURNVFArTE5ZNjFHUG5ac0xSc2t6ZStXQTFmS3NId2hWejkwU0lF?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ee1836-8786-4e85-7388-08dbf6ea84bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 06:05:31.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6tU8oADrUwYERcKpD1MfbcxIx7m7c2bkRwYkv5fJWE8ftPriyYPlgtYE8akqAsxwT4MV9s9GYVhL1VUzzeOPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 06:05:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13806

On 07.12.23 13:23, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Thu, 2023-12-07 at 09:09 +0900, Jan Kiszka wrote:
>> On 06.12.23 22:33, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This series adds the, possible signed, efibootguard binaries to the
>>> deploy dir
>>> and adds them to swu file and sw-description to update the
>>> bootloader.
>>>
>>> The new entry contains following information.
>>>     {
>>>             filename = "boot${SWU_EFI_ARCH}.efi"
>>>             path = "EFI/BOOT/boot${SWU_EFI_ARCH}.efi";
>>>             device = "/dev/disk/by-uuid/4321-DCBA";
>>>             filesystem = "vfat";
>>>             sha256 = "boot${SWU_EFI_ARCH}.efi-sha256";
>>>     });
>>>
>>> Should we always update the bootloader or should this be a optional
>>> addition to the swu?
>>>
>>
>> This should not be the default as the EFI Boot Guard is a single
>> point
>> of failure. Updating it should only ever be considered if the
>> consequences of not doing that would be worse than the risk of
>> leaving
>> devices bricked behind.
> 
> Yes, this feature should be conditional. Normally you don't want to
> update, but there are some cases where updates are needed.
> 
> How about a variable SWU_UPDATE_EBG?

And we may try to shorten the corruption window: write new boot.efi,
rename old one away, rename new one in place.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


