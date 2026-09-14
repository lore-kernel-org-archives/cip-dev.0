Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA19C88E72
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 15:46:17 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.754.1789400770850707805
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 08:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jE94WYvo;
 spf=pass (domain: siemens.com, ip: 52.101.69.27, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llto2suGyYnXTbUGugCQWIdliqvyt1PXlgrRw7OK1EUj6gUPTxozqM08YHMeBiKDWeqsxaGU+cWgNACzru4eBIco2dYB11i4evNnFOL6Ei6GuI90daYEo8nyb0SAkg//krmmXnqVmY/aJbfSnQfTC+2Fd2CeMvxGjWqOl9KoGlbZE2dmOq4ykGyHiZVO8Sf0oLi466bCGbSyvTxFSDFau+RhjJV34KXsABicLbyoaKtJUDSmq2lxM9jMdUzfR2Kt8N4LsuJZsfOOQTtbimp5pRWuDqXSm8rmGWp/JUTYobYN+iGqB+NP6uDkP12H/4SPSddYSqdbaFDmEgbAYT1mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0ZLYDjDHAHTx/lAq7VXQunbjzZsozFU3gXX9lam6uY=;
 b=qKGSnop6oDXTRuIQi/cfv3NiHzvmvmfsZCl+EmWCqO90HuhbVF0cb6OD1w6wKCXaz06G896vADNd012TCZEjq41vRcFAywvFn3tFMcnbjni6JYTAL94YYuV90lefvdfIxJuZanCXArDASmjMYJobnmuAjqmT5VZAtJrBZYMb/dH33Sx4y9+RWImBLeUX1wMxTmPxo4476y801Q/h6mm5qI3mvhqiRS6FmsXZ7wrEf44rNqvICobMrb4qOQkXlG4B4ui36iTMwkdP4F5z/frmxMK6PYvtyxZ36jMBVv+2JZbiaZBRDHZ1XNKxhA5JOfRsgZawZGrrZ7TW+sJHA2BQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0ZLYDjDHAHTx/lAq7VXQunbjzZsozFU3gXX9lam6uY=;
 b=jE94WYvoBp3GJV9zjLlWu00PhKxTF449Q2CZI4CoRa8VxYCTjFKM4M1jixMxDTkqjz/jTbwpARFv+E2I6oJxYPGKyDpTUorIpAI1MPWxL62ezzNR7bznPJnGMxyAbGcneiPAG6isZ87py/F9lv3jtqvJyWPbU5QHHj/fSZnn+pNqfVK+z3MQ9erHYiYUrmNgqXE8K40CQ+4r1Djcf4SRyTOKcuwRD3QuEpRlKRGSMCAXCA9zn0GCR+C28Pj4aBlohCRuSu7BJNr9ML2YHOneujNjsIxZxBKbhgx1TVT2znzxp+vLnjtp3cpimLdBaYvdi41hzxJ3x8AL5DsrgMbQrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM9PR10MB4039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:46:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:46:05 +0000
Message-ID: <e6e65f01-2a78-4a7f-b329-4a35e53af1fa@siemens.com>
Date: Mon, 14 Sep 2026 17:46:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 07/12] Add class for validating
 the CIS options in the kernel config
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, clara.kowalsky@siemens.com,
 christoph.steiger@siemens.com, dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
 <5cbd3567-d84b-4a87-a029-b6bfc0ac2b43@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <5cbd3567-d84b-4a87-a029-b6bfc0ac2b43@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM9PR10MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: d65bab72-060f-4475-97fd-08df1277497a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	MiOBO0Ve09IaDHRrRq2Pf8s52EgN6vTdprlq0Ila2AqNgJL7pb3ggE/GFARRiLoQKu7QR9n7z/1EjyNl7rsap6WZU0iWcZQNlCtlH44n/783wTfun9aNfnurasG1XaBGV5xL6RqykahQFXzXo20HoDMdikEXxmKWYTZZ0z9ApmEKdsYj6w4dknP9p/jcdCbjTPfvKgi5LjRx+QmtOfwBNEevn5WjgzqcUmk8sdEx282u+BstK49fiGIrDvJsfgbTU7TBnCPrW+opSVJH+VP5wcfwQJkA46bpO+LOxHEsiUZaFm0GYbd8/Rr/7Nw1gP0Pcwsw4EUQ+0/XJgXEt2AI0fOa4r+hypm7M7OxucOMvQumPG1HD2QXX5K4nE3DQVG47Nuxkiablbjz444nsKzx2w7t8U15M3V4GdvRoHobfgzfJByiM1c6Agk9G0rOJlM71H46vEThOF8EI3UrNm7jMnwpcR4L3Oo2OK3TCzf/aD9y+UIuFZzKjEkskTJSh7N827ULkqQRruEzeyHD98mTov2qKJtMPjR1bQfiGXnUQ5kwP45Q/W5pYwNz4AOZiof60mfPRy3Zj+yWw+N0UPiDoaP69U+DY9572Tdv1r+5n+v4HMKZetzRRmkn6CYewVTi8t4r/w1HTYM+gVSqgDpGV7EnoLAWyXI+mWP0ftJCI6w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1NGaGRhY2VXMFhkV3FEYW5WN2ZML2ZrTjB4NC91V1l2OVNrUERiYk1ra0pa?=
 =?utf-8?B?YlVyQjgwTkE5TUxoSjJ6UjBma2M0YUtFTThWalptYjh4OHA4QS9IS280cWs3?=
 =?utf-8?B?bG9PNzdjNktCemRJdGVhRWNCbVRveW1SeTJJaitRbXhWQ3RQWWtVU0pFVnpC?=
 =?utf-8?B?aWVXcS9aTmQ4VGJodTZmRk5ZZGp5ZGF2Y0xaWGR4M2E3dE1ZdCs1bUZJSUNF?=
 =?utf-8?B?UEdGTWdiSEpvNmt0TGlEZEpMV0FGUjBIeVloZHk4TzU0S2NHNlo3WE5CMCsv?=
 =?utf-8?B?c01NWlZvM3N0dmxvTXI5NlNONXJSSTJUNzhXOCsyVWQxVUIyUGhQRmlvOXFo?=
 =?utf-8?B?MWEvUU9OV0VZOHQ4TnBBbXl6WllhejNXNHp3SWFnWUM3TEMvTEdQaDVOS05H?=
 =?utf-8?B?aTNFUmFjK3dGV3ZMMEMxVk1TK3MyczNYLytMUk5jSVdnWXNOT1AwbmJJcUlP?=
 =?utf-8?B?a1RhU29QL01xM0xaYXRoNytKazIxOENlTXpRQ3paTEdQT1pxL05tT1RmNXM5?=
 =?utf-8?B?eVVwcVZLU09Lbzg1RmpLTHVrRXl6ai8zbGJrN2RyZHFWMHZzaWUrTkx6R3d2?=
 =?utf-8?B?bGxHbGJiSGZGeTROZ3JwK3RKWDBUREZvSFF3dklBQlpsVTU5bjZ3aVl4S0xS?=
 =?utf-8?B?MDU0OE5BOXI5RDF1K2ZKV2sxWW5pRkZRZW9tSFZPTFM4TnZzMGFqOGRJVU1m?=
 =?utf-8?B?cEhQRjMxU3htRnNROHhkL1ZxMDA0SGhWQkRWdkh0M1U3TFk4SGtlQWduazZi?=
 =?utf-8?B?aUVvb0dnQThGV3VVL0VrOGJaMnJZOVdGUENWbVpjRjA3UXpOWG9MSmlHc2hm?=
 =?utf-8?B?K3QvWFpjZGhLeGtDTTVrYXpPUFBZL1k1VFF6S1BRMVJtbjIvd0swZ3loZFpO?=
 =?utf-8?B?cWhGWC8yWENIOXlxT09HakJyclNHRisxeTYzUGMyY1I5NzRpYWV2U3VmZFov?=
 =?utf-8?B?cDN1Ti9UR2NpWkdDUGFJTXlOT2NTNEZ0SVRoUUc1YzlJTERuaFFXVEZhVXk4?=
 =?utf-8?B?L3ZNSUpsdkZEazJYUFMwS1F0NlkzY1NlVHJLWTl3N2tXSkQ0Ti96Sjg0YVlu?=
 =?utf-8?B?amxDMVRuV1NXTFc0WCtXM3NNSjBwVFBWRU83OXpGRUxuSkJMT01HZUpmOGly?=
 =?utf-8?B?Rit2T0VXT0VWTElVOGpMYTMrdU1nQVdlYTgreXBjQ1VZeXFDdVVFd0hsU05Q?=
 =?utf-8?B?Nm5ocEFIRjlyRlFyUlFmMFM3a0toMWw4aXkzQ2RvY3pGaVBZUyt1eVVpSisx?=
 =?utf-8?B?UGUvR1hpUlFJam1seWFWOTJVKzNwOVB3MnN4NXJjWG1NQUpmVlRuN2JsZE1k?=
 =?utf-8?B?OGFLU2orUmZCL2tFWXZkMllTYUc0Z0dHN0l6MGVYcm5wVUI5blRFTm84aXRO?=
 =?utf-8?B?NVFpeGpPNGFzSlFySkRrWjhLbU5XRktyV2FPY09ldWlLS2hYR1JwNHpMZzBM?=
 =?utf-8?B?c3hXU05TenlTVmxRdVdwa1UwL1ZZZStPV3hrY3lHeERaWkZkaThEbWs5MEli?=
 =?utf-8?B?NDlEUzRxdk5RNlVHMy8rWHJwazd4Wlcwem5NL0V5VU9ZV0dMdjRCMy9OUDBV?=
 =?utf-8?B?WTJKN0pkREhUeGpodDN1aVRVSEFTcnkwVFA4M255dDFZU1VkQWNYVk5qRTNS?=
 =?utf-8?B?d2JQNFZnZkJnajlFeDRNcTZ1SWRwbEQzT05SWFBxT2JGdjBsQkJqbWdrTWcw?=
 =?utf-8?B?UzZEZ0xJOUZvOVFOT3E3c3ZRZGJXY0ZDQy9KYWkxc1V6U3N2b1ZKWDByUTJz?=
 =?utf-8?B?bFJNQmcxUVBsYys3OGxwV0J5TElGSklVL1ZPU2w1Y3ZpN2pyRC9HaUNFQzR6?=
 =?utf-8?B?c3lQQS82ZjNKRTYxbWtxN3ZCWXhOWTRMdXpPdHNLeFZrVmZtTy92eEdybWRP?=
 =?utf-8?B?M1ZCd3hnWVdEMWRYM1FJcFBMSGVxeU14VTBISkpvR2VZbkN3RmhVU2hFZ0Va?=
 =?utf-8?B?OVRvRGNEVk5DaWxHSUQweGVaL1VrQTdVQ3dORXU4cmxsTGJET1VYa3FVVmI1?=
 =?utf-8?B?NVdtVENrQ0E5QnVPTE1MdzIwTDZKRUwvZ0JOemVGaTBwc0k1SjArMGh0K0xX?=
 =?utf-8?B?amZnSzc3dUNIZ3d1SjkxUGlJN3ZPdHdSVE1ObGhKTVp6RmtjRDROZWpFQ0tD?=
 =?utf-8?B?bmF5M2hsdFZPcDFJOWVXclR1Wlc3bEQvd3AwM1N6ZlVlcnRKUllDZ1ExNVBo?=
 =?utf-8?B?L1FYVFhlcnNYYTFneDlwOStmcEdrY3JCUmdmZ01nRWF1UER0NjFLS3czL2xB?=
 =?utf-8?B?TXV6bCtZUUZxTmp4eVkwNGFPdnZ4dkkvdnFmckpveWlUektnSGtwRDNERWxs?=
 =?utf-8?B?RVlGaGZ6YlZORmxaSWJHZVNnSHA3akNPdFdidlFkemtOR1dpTWhIazNiM3dZ?=
 =?utf-8?Q?Dc7cyiic9G30BGJg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65bab72-060f-4475-97fd-08df1277497a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:46:05.5212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaspLy8yzV8OaS4gqpmxaXEltd8HNDjsTGWyR90zacp0n99r3uB7dli5v5MhxApS7vPDbAlT64dFiyK65yagUS+YRU0JXry1QwTZfbSXLZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 15:46:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24178



On 8/25/26 7:00 PM, Jan Kiszka wrote:
> On 24.08.26 11:46, Quirin Gylstorff wrote:
>> If CIS hardening options have been configured that change the
>> kernel configuration, this class checks whether the correct options
>> are selected in the resulting kernel configuration in ROOTFSDIR.
> 
> I think I already pointed out that checking for some random file in the
> rootfs is NOT reliable, specifically when there is no config deployed.
> Please check the config that was used to build the kernel, possibly
> leaving "signature" if the check passed which can then also be
> runtime-validated (if that is really needed).
Currently the isar kernel build and Debian build all deploy the kernel 
configuration into /boot.

We can add for example the shasum of the kernel configuration to image.
The question would be where to store them as the should not be in the 
rootfs if for example a kernel only update should be possible.

Quirin

> 
> Jan
> 


