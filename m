Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4853C83033
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 20:11:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.64])
 by mx.groups.io with SMTP id smtpd.web11.50551.1751314283075727711
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 13:11:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kxMs52OG;
 spf=pass (domain: siemens.com, ip: 40.107.130.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwhvZnaatBWs+QXmrQxC2HGy/uBbqMfNk+NH0rGzGtoQmI/npUKbB9v3TX5YyCBI4YozE76PPqqjpzBccX0eqCawhF1+/zVHo4j+4F8D+MeU9/HhoxhMzkM3RvF1fIU0088kC9qqURwTFqbl3PO2tftcZbhnOvq9gs2IsWjb1DuT0OyqEYpDBtPKccuZHZs1P1Q0hFza1Ayf7fWqIFbGbCiRaGNqPRoHDm7V//cQnSUGFga3ZF6SSb8BnVbqenZHROtoD7kBngFkzSbUOvjhtTVSs5M+FguCO1Lq7F5P+FI626ZRvCyeBt2xP+thflsXF7v2ODnwZhU1s+3S/fCzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySVvwG8FjmntgDCQ9i+a5ALmq2S2QEo4ZI5FbTUu2UQ=;
 b=VaGC/kL2MSOc6CNlVRMdmRrK33mKfGz9brUMqVrm61TukXyAvQsPpkAYjqIjniudYqoNHK/rxnVmyKFELwFOOWiJMx5Nx+e4gcfoqnYP2I+f7MlTi34LwzVcDRGfbvjdsqRb4uNUt1rFZPc4DXaAgDMq+ou8jJRoL8FPrIv+8w7dj2ORLxWJTcg4zhxeLJuZJwcCMLGdYCUt7oz55DuW7W6KKqF89K/emOk88tto7UveB5JAeOnMxZ182UE7QdzhMlmk7d0h32ViTIigcvfZCqWaYaAILgxDneSxgdWWsewFp7yKPSjezks+lnr0b2gNVkvJVUmZMWoqhGIc9z25Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySVvwG8FjmntgDCQ9i+a5ALmq2S2QEo4ZI5FbTUu2UQ=;
 b=kxMs52OGEocvBY0ZSC/2QAPA+bs2GBjyG2aJ2PxDKSI+Bql4V1BvhgqRp94p0V1ViNYtqG2hJXdpZJfq7vL04LYGXhvyE3xsz9KJtWxQU3IBsAxbxFV8UkKxaEW9yQA6GoxdRS2R+B43tKgY168a3ZlQdc/it0O7pbIRVkLo51Tla3YYQoENdCGUQI5yS7WRAw+M7wt5CGYtnH8qjCrED2cunKMqdjar1qvPo2vPlMVBKjQ2p/VVQY5tvaNuMI7UlJ8t8XnvLKmrPzrAF6IqQnq36DUflpDp9K2YSdWRVJr/ukWj97ZWGIfG9M8Go7hObsUMeqzwPLJ8vIYRbV+Dmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 20:11:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 20:11:20 +0000
Message-ID: <2fc7ada9-53fc-4fb7-90dd-45d275c90501@siemens.com>
Date: Mon, 30 Jun 2025 22:11:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 0/7] Immutable /etc
From: Jan Kiszka <jan.kiszka@siemens.com>
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
 <881c1466-0b98-4f48-9faf-0c7c65cbfc57@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <881c1466-0b98-4f48-9faf-0c7c65cbfc57@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ffece9-eee9-4e9c-c2a0-08ddb812470b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WElOKzE5RUh4TVVpTGlqb1B6UTNTRFRVWDBnWXRHYit1a0xYQkNGa0JBWFJh?=
 =?utf-8?B?dlh1cWtPZExHU2pGK05mVjlsQnNpdjk1ZFFTT3ZzUm42WW9CdERCNVNRUnBR?=
 =?utf-8?B?dUY1VFljU3Q5YW0ycFgwMWNQZjRMQ05hL0IxSlA4QXNseXdpYU85N01mOXJo?=
 =?utf-8?B?NFNHUHZRVXp3eEhzS0ppaTJic1h3eVZFdWRZUGpvM1ZHVmpHZlAzK3Y0dEE0?=
 =?utf-8?B?K2VXQ2NjMDBpOVRmcXp6N2plTDFtdEdFYkFuVUpkc0thRXc5QXdQamJuQi9s?=
 =?utf-8?B?dU14TkZHWUNkQ3dVZUgxand1UU9RaUFWVE5rY0dyV3M3S3gycVVSNENCTDJt?=
 =?utf-8?B?SGhHZzQ1NkdFRUZOUUhBb3RMK1JyRjAySTFYWjZsOXA3WlU0N3hxdEVyV1lq?=
 =?utf-8?B?N1BCa1UwVjNGYnprb0RSMURXaklhWk1lNWpyREdvcTF5VXA4bmh5cXpON2hs?=
 =?utf-8?B?MUJYUFp1V2lmTW9EZ1hhc29oc0IzYmtmS0o0UVk3V2M3ajFPWHRlV095Njhn?=
 =?utf-8?B?K01FakNLRW0yRGFmUERHMkxBV0RFVWhEZmsxdVl1cFIxajJDeDFtUHV3ZjYz?=
 =?utf-8?B?a2NsYzVXaHBzWEtKSE9nL1k5ZTRyYnVQSmlMWmJsYVY2T2xqemltak1oRk1M?=
 =?utf-8?B?ckdTb3NRNGkrOFNFSC9udmJ3dkpiUE9tUlkyZytpV3NUYTYyNjhZc3dvdVBV?=
 =?utf-8?B?aG5UMWRuVjhza2IydU1WOFR5N205Q2FOL1FyV2Fwaml4MXN6Mi8yVVVGZVp4?=
 =?utf-8?B?VDQ4TkRpVTRxQU9iUWNQL08rWExBY0I5Z3RITmExWnlCS2ZTTlRRQ3RoeVJZ?=
 =?utf-8?B?M2l2enJ0WFIzaDBsc1kxWmRpdlBxU1JhaHkvMklwU0IxNkRBS0MwQzdYWUdN?=
 =?utf-8?B?eGxIQSt6ZzROUWVSKzJqS1dtYzUxMExvVUpXUWxjVGFML2cyRzBpWWZBUlJy?=
 =?utf-8?B?eFBySmhEUW1ma3ZYaHdsRjJmZ01BaWxwM2szYm9aOVhyZUFtUWxnVm9vR0ha?=
 =?utf-8?B?L2xNeHQ3SndnRmI1Y1ZTc01ZYjMrd2pZZEFib1RyL3kwS25DU2FOaUhPeUM0?=
 =?utf-8?B?bk1JTkRxYUFOTkE0UVBxbFB5Zyt3YUs2dWkzV2h5SHloalFiSzlONGlQYVJ6?=
 =?utf-8?B?SVBVUmZIWlZjN3FIQzVGbVRBUVBmeXZCNkpRd2twcktrNTdtQ0hVM2IvdXRs?=
 =?utf-8?B?N0dDcWIrWHErMEYxcDNOaUVCRU5DWHl6dEpQclk1TEtnYWY4OXJ5enNFMGpy?=
 =?utf-8?B?M1lXSnpJbmRvMDNPT3BObEdXMnBCdUpoY0RYWkcyYkFVNWZONHA5ZTlJeHpw?=
 =?utf-8?B?a1l6Z2QwRktScmdSVjhhNjRqS2pYVVpDWkFoTGw5cFVhRjBCUG5LSm83Rlgr?=
 =?utf-8?B?d2R6V0FiUS9FNStyVkJoWGlWVW9SQW8wQUFSN0J1SkFQdVNmS3AwUlRyVFcv?=
 =?utf-8?B?dEl6WURXa0lSNkZkT0hadjlCSC9FSEc1d083R2lVUDhGd21HdXVxVjNQWXpm?=
 =?utf-8?B?aEhyTmkzL1paYU0rRjVOaWxDSXg3QUR2UVZ4RU5UOHZ3QzEwNjc5eTRrWUhl?=
 =?utf-8?B?S1Rsc1ZMRURNczNHUXQ3WUlJcFZUbEd3YzRXTXdRckc0cDkwTi9QVXQ3QStl?=
 =?utf-8?B?dnFWTUk4a0hyblk2RWR2Sm5pU3RNbjRyRjhXdlp5RW4xVHNYQlBQRnZUZ3pr?=
 =?utf-8?B?ZCtZWWpZaDk0QWlCSVdUSlh6SG1NM0VhWXFKM1hDV29HT1lMSnNGT0cwVG1S?=
 =?utf-8?B?WXE5VjZic2VnRzlZVksvREFWcHNlZjI4TnM4Tk5TL1dpeDZoWkQybmpZRSsv?=
 =?utf-8?B?eXhNdmphZm0rVnB0S2JCZHhxVmRvSnBKSG5lUW1YTGk4cGhWZGFlNkN5RnRT?=
 =?utf-8?B?NDBYWElNblZESFZZK1ZNMUVFN3Fxb1pmNS9VU1VjUUJPVUZDWkdVWk9JWWNI?=
 =?utf-8?Q?aI/1urwk7xw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUZQOTd1eDU0aFN5QmNSQll2REs1UFZWNCtnejJlNERuSE40OVNQZHN1ZC8x?=
 =?utf-8?B?cnZUSTVvcVY4RjZLQ25LSHFOQjUyQmd3YWlnNTdERCtJYWphd084UjRWd2Nw?=
 =?utf-8?B?ZlVUQ3NOMkFOWE5TVzRkWVFRcGRhcjZldnlwZWliZlZxSTRWWlBmOXArcS8r?=
 =?utf-8?B?cWJZNjRtRDdHZmtSYXdyWkJLdlhKY3RGNEVQUHlBWWFHUG1ZYzdQMXNJQjVn?=
 =?utf-8?B?dVZNSFhnZjlZSGo5b2U4dUc3OFUyZlkzckJlaTVOeHdRcHIzbUg3ckhCR0Yz?=
 =?utf-8?B?L0xZM1ZNa1V5T2dTMWNTMVJVeDFUeXVnZG53NEkzWUtRc1VZU2ZERCt0REdM?=
 =?utf-8?B?c09KRTZwamlLMG40RGRWRkZFT25KOGt2eGtrdnZGNlVPclhjQ2lvME96eUVo?=
 =?utf-8?B?bTJhMmV5T1FzUHNHM2VlMFZMWVp2YVVkL09jVStLTi9KWjlCZTB1RWV5c28w?=
 =?utf-8?B?UVFXSDV4ak1rUkg2MDZEK3BCUTFyWG0rT3prRkJkcFJETm5mWm1Sazc2ZVBs?=
 =?utf-8?B?bnVhbFFTMlMrT3FKalExMzlCRHZlQldmc3R5VkxScmxTRmdibzR1c0V4dDRS?=
 =?utf-8?B?T0REYkF3ZFZaL05hTnlGdjh2YW9yT3JIN0xvN1o5alVSWitGUkJDRXVERFpC?=
 =?utf-8?B?QzBZKzNvM0dWWVRpcEkyMWZJUjQwMFFaNFg2b05ESWJUNEdYbjduTWczbTZl?=
 =?utf-8?B?dEdWWlNFQmhNTitySlE2bGlGQ0tIbDc3ZTlzYk0vaEpOWld3aENJeExZamZU?=
 =?utf-8?B?RU5Ua0VDTXRUeFhNOVNBUGswR0N0a1ZkZG1LazR5dHZpbjdDTEp0clBhVEUz?=
 =?utf-8?B?SE45UDhydVFXMGtrUDZyRFlWcFBXWHo5SEhMMDRDRTNoZjBKZStlNHQvOUJp?=
 =?utf-8?B?OEhySENPNFl3OFNjamN6ZjhtVTNwcm9wZnB0K0t2dFp3N2Qycjg5TXRVenVF?=
 =?utf-8?B?REZEVG5pZFM3NjJOMHBnOXNQTkZXdlArdC9aeHM3ZWpxQU1KVDY5Vnp0VXdh?=
 =?utf-8?B?R1hxQkg1bUdJZ3VhaUF3emk0ZGxjOG5uOC9Sb0hmTDNNNGhrY2RxVDJUYUxO?=
 =?utf-8?B?Y0hZR01vWjlNeVo0MUNrUzNmbDhkakRTUEpwaktpUCtRc1V5ak1PWC8yVVFP?=
 =?utf-8?B?ckFaak5XVUYwVDAwcU9EVThSTHVoVVJkanhvNTRLeUxza3g2MUo0SXN2SUgw?=
 =?utf-8?B?cWM3SzBUb3lSSy9FR21WZkE0SEJ2Mjl4eWlSTXlXSE54b0ZFWGZCd3RWVm9D?=
 =?utf-8?B?TzY1dUx6WWRkTmVPRWRUc0p1RE1UdG16Tk9lTkN4YUZURVFkY3JnTFRBS1Zt?=
 =?utf-8?B?VUwwT1JhYi9QQ1ovdUJXU1g3UnVCRDVVdk0yTWZBSnlBeWM5QmVTWmJRcDBX?=
 =?utf-8?B?bDFTY2w0T3pNQWYyN002VnIza3d0dWV0SlZ1ZzZ1M2tYN2tBeVFxMUlKZUNU?=
 =?utf-8?B?YURwbTBBck5Cd25JTlllUTFGYk85M3AveE9GN2J3d29Lajd2MjZVTjRVZkVW?=
 =?utf-8?B?Z3lJV2VYalV6ZzJITUtpQWpkRHpLdXVQaERvRkU4VlR6SDJGTnBnZ2RaNDdj?=
 =?utf-8?B?WmtFcDZDSlZIbGsvUWxQVVNLYWNWUmlqU3NrQjJVcWVhMmU1bjNRUUZFakxZ?=
 =?utf-8?B?UVBMNTIzeWFpNHNxcWYvdFo5WWFmbGxzZnJTcUtUMnhXU3dQRHV1ZUZrL3kv?=
 =?utf-8?B?YXVNM2NSQVpqdEFXR2lTUEhDT2JmSGZZOGxYMVZWQTQ0QXlsZlJCNVRSZ1lN?=
 =?utf-8?B?WGh6aUh2bFlzZERHbUNaNTdyM25PM1ZhbFBzL1M1SlhCNUExelV1V0F1NHZJ?=
 =?utf-8?B?TFFIaWozOXQyMTEyb3lNUVpNdVh4VnB3VzdHV0VQNjJ1U0Z5dURza2x6VEpL?=
 =?utf-8?B?bDV4K003ZjhFck84ZlRKYVNMNVFMRisydi9FMEx4WEFMWUZPdVZVWXREdDRO?=
 =?utf-8?B?R2Z6d2FuTnpzcHUvL1RHL3FXWEFVSXRoNWpqeFpndmhiUGRGdnl2TzhNVy9Y?=
 =?utf-8?B?YU5tb3lFTEVJREpydEIxd0dab1Y5WXR4ODlxd2dJSW10OElYY1RnWjdlNThY?=
 =?utf-8?B?OXV3WG9NOFJYVjQ3aDhFTS9mU09GVWduaUllSHpFWkttbFFFamlveW4rWHZQ?=
 =?utf-8?B?c0JRbmJxZmVhRFdOTjgrNDRVZTJ0TmR3SlVHZ0lkVVgwTnZPL0dqNlVvT1Bq?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ffece9-eee9-4e9c-c2a0-08ddb812470b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 20:11:19.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPADu9fTAzM8rowQHGJ2LzrAC/WWDJP8ssThy8codrjZeAaOKKutqIewbUkxZMcK6GNwWrKuFG+13syS/XvHfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 20:11:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19267

On 30.06.25 22:10, Jan Kiszka wrote:
> On 30.06.25 20:15, alexander.heinisch@siemens.com wrote:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> **NOTE:** The patch series appended to this RFC mainly covers
>> handling of /etc/machine-id (see below) in the proposed solution and serves
>> as a basis to estimate additional complexity ro etc introduces.
>> Thus, be aware that some of the patches included are not to be applied
>> on next, (yet), and therefore, this patchset does not cover all
>> cases and introduces some regression on the images built
>> (e.g. ssh-regen-keys)
>>
>> The setup used for the PoC was built using:
>>
>> ```
>> ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml:kas/opt/ebg-swu.yml:kas/opt/readonly-etc.yml:kas/opt/machine-id-on-var.yml:kas/opt/config-on-var-demo.yml
>> ```
>>
>> ## Background:
>>
>> During hardening activities we identified potential
>> security implications of having a rw /etc.
>> While this most certainly is a problem when attackers gain
>> root access to the device, it prohibits unnoticed configuration
> 
> You likely mean, that rw /etc "allows" unnoticed changes.
> 
>> changes by tools running on the system, as well.
>>
> 
> Can you please elaborate more on the actual threat model? I'm not a fan
> of adding such complexity based on "something may go wrong".
> 
>> Further discussion is based on following observations:
>>
>> 1. Many services don't need to be reconfigured during runtime
>>    and shall remain static. With an (rw) overlay on /etc this cannot
>>    be guaranteed.
>>
>> 2. Having fine granular overlays won't work either, because
>>    some services rely on files put in /etc directly.
>>
>> ### Systemd:
>>
>> Systemd maintainers suggest to have full /etc rw and
>> put immutable configuration to /usr.
>> While this theoretically could work, many programs
>> don't fall back to configuration on /usr and if so need
>> to be reconfigured (efforts not estimated yet).
>> Further potential to reconfigure services (permanently)
>> is still not prohibited, since in case of systemd
>> /etc has precedence over /usr (/lib) based configs.
>>
>> ## Proposal
>>
>> Therefore, our RFC proposes the following:
>>
>> 1. Having an immutable /etc
>>
>> 2. In case of non-epemeral, rw-able files use soft links to /var/mutable/...
>>    In case attackers get (root) access, this still impacts those
>>    configuration but the rest remains static.
>>
>> 3. In case of ephemeral, rw-able files (e.g. config that can be regenerated)
>>    same can be applied backed by tmpfs and config service / tmpfiles.d
>>
>> 4. In case of rw-able dirctories fine grained overlays are ok.
>>    But most probably on hardened systems config tools exactly know
>>    which files to touch (so use can be limited quite exhaustively).
> 
> Are we the first to propose such a scheme? What do others do to achieve
> similar protection goals?
> 
> And how many services will now need lots of fine-tunings in order to set
> up all those links and folders?
> 
> This sounds like labeling a system for selinux: Can be done once, all

...labeling and creating the policies, of course.

Jan

> looks nice afterwards, and then something changes, people loose
> overview, and the whole concept erodes until everything is reverted to
> normal mode. Such an approach must not only technically work. It must be
> *maintainable* first and foremost. And I'm missing the latter here.
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

