Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04FAC3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 19:01:56 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.25772.1704308513158717113
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jan 2024 11:01:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IRpcIzwA;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSE2D9neJYkjTzzf9n7QQ1pENXBedIWnKLMZzghC1hFXFc+c6xqzlsYyy7TIlHQwIybZ0ms5bRZfXuI+qnLv+7v8IV88ID+42RzoclSuuzV3Z6Dx0fDuLLlYXUQ4FFBf2l6O57xjHjV4DKliYQfv/sqlMICDKVMqEbo6HLn2ouZaqWqVLtfUfCWs90kxxZ2lQZpzAmyL7HGm12ke6vb9dB81OZOUov6MpW3Tvs4IjS3RdAqLwzJwUWIF6VYes7sKL9PLpuw/mJj0xVBRwTtH/bT2gf9Bu6a5tcFrR4pAK4s8B958X/L3xp+7QYFqDfcxcGEVWQd9bpJcGzy4EoKI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8sQow+Bjw/ArZR/MDnx9Pbkb3YLMLABVX9/9t9AnUQ=;
 b=F2728pW5gzM/uYMEdmakFZTPTrpW4ULAU5ZDMwl9M1j465xS08Jt2ZljbOcSg2mT+Qei2Q7NvUTYPK7ETikQgy34EQ6Oe6C3v4YDTU9fOEvqQQBme1KlkVQnDJFqXgVhSqZdbzLyc4TaiNKBiHeLoC8o579ING8KF28ZFqH77dcev4D6AKBt4w2lxT4mVY8JZmYXPrSCrya6pAPoW0EEfAun+ToRJ70BWNB2ETM01M4/e9Bx1wBTU7uPcq8XP8XPbbjVLKkqAME11eRiy1UiQ0+5tK/xoLLv6NGFaxoBRJfoGp0LpYw2jTJSvV8tgQm25lmkl8kTXwrO2JEVsNw+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8sQow+Bjw/ArZR/MDnx9Pbkb3YLMLABVX9/9t9AnUQ=;
 b=IRpcIzwAld5MTELMZwY/URaQoOpC+NzZoq0PoOY3YojrHf7hM0NFm/8QZ2amb12wrOqLtOD0jBFZodLKpFrtgNKnL6Gp/BwFZvvtTIkyZFWToEavGbi0lQVWVbHEBy0f3tqgA1DP3cctKf7W6HNYZZcQfZwv97NfP8Hqfdl98j8NzmwUVLCmPQ3Pnr/O01WW3bRXiehb0m2PYdMvKzCEsPHTUn+Gn908iPrD/2H8mFv/6WbKFYdPFs8/Y6BtLPVFLmTRrM4NZVk6J4oYyb14jn09bbDQsydjrzN/HW/Xsi0twrk66CFSl6E2P4vkT3AfAtgmSc2d2lMXBsMNP24vEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:01:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:01:49 +0000
Message-ID: <3d4582f6-0b37-4658-b74a-9763afcd17d5@siemens.com>
Date: Wed, 3 Jan 2024 20:01:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, uli@fpond.eu,
 masami.ichikawa@cybertrust.co.jp, Chris.Paterson2@renesas.com,
 cip-dev@lists.cip-project.org
References: <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
 <e6b43450-52e5-4529-8006-de503c30df7b@siemens.com>
 <ZZWmz5ZxB10Suz2T@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZZWmz5ZxB10Suz2T@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef6249b-f6a0-4442-abef-08dc0c8e70ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AseubBAK7zFp0nwIKYtk/j6dZ7EM3Oi9GOjQEzka2teXspyEXvQ6zuXH0Cr+c0Et0xRkSq/nDeBfVt2dbjftOh7sxTFNs6jvIQowjVksT/htkCBKXLjacVXRjBAhq5057ZBZSr5FO3x53VMkSBP/sqoHD/2StBPM0n1jg2dOGJ5i1pwE+OUebx0TjsCZtQ6pb7+qufp9oN3uSkuUYpu84lWX0mA/t1+Ji0xGsquxuXkRuKT6lgR0wbMGsm6W445o9tYO3M887xHDbt8s97UVOOd49sGflYcXfgU7dz419Klk99VDRfWzaH1fwcCqoyo9i7OxhSCAlWOWm4m6px5pbz3opwa13lBf0vfDrjxo8o8abeFf+7GxSD/feGuCq7XDgPAdSZ4vIqrf3RIXHT1EStS6DLQUNRnteiZ1NenqoMRtZAW5WqgWAo/YLEolYdRKnlgHQSIm/r+lMQr/oKOQbMgYyxLdXjtl02L0KUyDM+6sPgyEk1kVkR7bfhDD700IccyPys4Xe4cfDLXUdNBaBW/cPirlUHEjoLRCX2FwaHskDscpRujvd8SV41Sas0lTDSG/KGhQdMInrSfjJ1EySj26tMvOUPddYQ0aD49PjnN2wRmSjxLC8YHDoQYyVmdeE7GGV8erYRqNg/mvbajWBw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(4744005)(4326008)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(6916009)(31686004)(44832011)(2616005)(26005)(6512007)(83380400001)(41300700001)(38100700002)(82960400001)(36756003)(86362001)(31696002)(6506007)(478600001)(6486002)(966005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RHpISDdPNXNQYVc2UWR1eTFqSVNQNTc2dlBQRndLZG9ueGRJcjUycXozVjd5?=
 =?utf-8?B?aEQxeTk2eGo2TGIrTFc5QjhMYnRaWDFPVEVvejdxV1lLZHRIR1BXZm0zaW9L?=
 =?utf-8?B?c2lWUVUvVW9BdnVzR01ZNURiSmdDbGcvc3JGcFNSUWc2RnB6RXR5OTNqZEZs?=
 =?utf-8?B?TkxBa2dGVnBzcGpMRkk0alRCa2t3SjMyNkhENGdXd0ZWcHpUWFJnTUZMVHBF?=
 =?utf-8?B?enB4LytWanloV2l4Rnd5VDJCeUFNV2c5NHVWcXVXM1JiMWo1SGVwZHVqRk9k?=
 =?utf-8?B?Nm9wMG4ybGVDV21WdVNQOVhZL040OWxDbStjdy9xcGVYNExqWDNyQUxzWkNm?=
 =?utf-8?B?NjdpaS92c09KbysrVjRBMWF4SlRoUXN2SEpVREc0Zk9JcHNTb3I5OG9QbGhP?=
 =?utf-8?B?REZaWTg3bzZZclFzdFljM3pLL3d5NG9hemFCRDBhVFNPalhiV0I0QVJEQ2gr?=
 =?utf-8?B?MjNWQWF6TXd3aXpRQzNTdW9UR1U0NzZlNFNRMUdRVFNRNFFDOHpqNmFiMUsr?=
 =?utf-8?B?Zkx3c08wZHNFQU9vL1dDS1JJRGwybWZSbzVDVFh5K01uOFZ0N2xJdnZraVor?=
 =?utf-8?B?Y2VLRTFPc1VxMThRL0ltc3FvUXk4K0FudmNnajFvQlREZXBaM0x6ODVsNWNF?=
 =?utf-8?B?Y2luUGlQeWlrMlkyVDhvK2hEK1ZGNlF1dHMzYmN6ZzVHOWlhRUFSQ0pMV2wx?=
 =?utf-8?B?NTJrem9jMEthK3lzZGgvZmVLN0dpR2V3Q2hBbW1rN3pQOWJpSUs0SXZtU3Q0?=
 =?utf-8?B?SmJyVGtSRElLV2FjQ3R3Z1BPM2ErZStRUXIrdjVJTS9FVXRzRVk3cG5mN0Iv?=
 =?utf-8?B?UlRrbE9xS0dGalIzWGNBbmVYclNBdlQvT3c5Sk1paGlNQ2phWHF2T2VXQ1h5?=
 =?utf-8?B?NFRtMFZRMXNZazRoTFZZMUxQSWVBK0pZbW1ZTStIZWhQMFVIY3diQlBkYWFL?=
 =?utf-8?B?WWFjdGRSeEt6NFB6SHhjeXd6MzlOcUM2bzdCRVJCRXF2bTU1N1lWNGppSVBO?=
 =?utf-8?B?eTJuaHA3K29yb2tELzhMMTloSUwxTHdLb2pna1lrd2Z3SGpOZkdLcy9oK2dq?=
 =?utf-8?B?b2Q1eE9FVVZscGxHVkU2OHc4WVpnZGxwbVZRNy9sSzdod0hxNllMVWZSblVK?=
 =?utf-8?B?Wmh0dGczREp4VXQzeXN4aHU1WEVSZDJHV2xQbTFJVnhIN05INkZnbkdmVTJh?=
 =?utf-8?B?TGhaRDBIbEhZb1JYaXpoNCtvNHNXcjlKVzROYXU0U3RvZUVybXZOeUtLeEZ5?=
 =?utf-8?B?REpDK256ZTcxRTM2MFpLY2RRSUVVSG5mT05pL05tZUdoQ1BycEhDUkxlY1BH?=
 =?utf-8?B?RUFxelNyTzNVOW8xekpJYWpnd1E1QWp3K3ExM1ZJaUhXbzhVVW5VdkFzSldl?=
 =?utf-8?B?VkFBUVNQekh2QW1FZXpHV08xSDVZeUJJakFFK0d3VnF6ZDZHc1B3UjJzSThE?=
 =?utf-8?B?Qm4ycUR5Z1orZFZOTXFzREtkMnpyUVpCVG5pRjFMamI0amh2UTVMcW1jYXhz?=
 =?utf-8?B?VitzRUFpc2ZMd0pjdk1qcm8xMzFXQTh3OE1EUFhaamZSTFJLT0dXNWU1Wi9K?=
 =?utf-8?B?YTZ4b3RPUnRBRnE5eXNSckVZOTRJRkUzUll3L0RaaU4rNkxndGh1cjJFd2hI?=
 =?utf-8?B?Q3Yyamwxd3hmc1R4bUdXclFqbHdVUTlPQ2FIZ0tQZEl4WmRwM1FkWG9FUG0x?=
 =?utf-8?B?V0Vrc2Y0Y3dzY0xqaFB3djg4ZkhZNDFkVTFVdVQ0eDg5cmdvcXova1JRTFgv?=
 =?utf-8?B?QUNMWjBlU1BJR0dxcWUrZ3NvODFscmw4Q21aY041ZHBoUitJbDI1ZTBXZTRy?=
 =?utf-8?B?MWNFdlBoa0VpaTJRUmxrcnBmV2svWFZtLyt2Yk5Ga09PMDB1c0Q0WWlvTTVp?=
 =?utf-8?B?RzYybERPeGVyOGdlN0xKSFFvLzdrVTc0aGNZdkpPR2YvYyttVjJUSGNsRVB4?=
 =?utf-8?B?Q3YzUEU2SVRIaDRuNDZsUWRJUlVSUUYrMXJrUmVIQmc5NnpaTjBLV29HdFpo?=
 =?utf-8?B?eGhyWGkzSnJ3UWVKQWFpd1VwaDNqdi9yOEFKK1VhRk5tV0p1WnZoRWQ2b25J?=
 =?utf-8?B?QlBaL2Jwa3Z1aW1yQnJFWkJDQS9xR3NEbGxicmpXY2JnRFNOZ0w0bkpJaFNH?=
 =?utf-8?B?VnNLTkE2VDF1T1hTQlc2UGRCVUFIOHcyaXpHVHNIczRxZVRVTS9uWUVCVzhh?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef6249b-f6a0-4442-abef-08dc0c8e70ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:01:49.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZbP3o6cPJdllUHcG3TrGVNnWMFiBP/GaRiS/IzPeefXqhVZ6K5l90Rl7wItslxtaHe4nsVvnPjGP85HRblFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 19:01:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14250

On 03.01.24 19:26, Pavel Machek wrote:
> Hi!
> 
>>> Seems v6.1.67-cip12 was not pushed as tarball. I only find the
>>> corresponding -rt release there:
>>>
>>> https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/
>>
>> Nobuhiro is probably on leave right now. Could someone else help out in
>> fixing this? I'd like to update our recipes to the latest releases.
> 
> I ran the script to generate/push the signatures, so the tarball
> should appear in few minutes. It looks like v5.10.205-cip42 has
> corresponding tarball, so no need to do anything there.
> 

Perfect, thanks!

Jan

-- 
Siemens AG, Technology
Linux Expert Center


