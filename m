Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5238.1794385715625302129
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 00:28:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZG3KUd7m;
 spf=pass (domain: siemens.com, ip: 52.101.72.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO0Jjtqgv62AL8xBke2vOMdpdFh5ojvggROls4QVYaZQN+EwiK4fDMi0KLQYImguI0Rh8uBmENF+vWvEqUUKCihi3LPOSzKhzkbjoHRWAdHiwEDAvUA6FALGnSeOk5WKofI1pU+SyfXtuoxELXHRVy5ktZFPVtrlnTyiZ+iwVKkbbzTWYjya3vhG8cZ1OUOzXZep3Z2t8Sw9gbJE99pUr5gjKKEvjuoeacNt4KOQ2zJsVQ7vJAZ3oYxxt9qFd6H4BeUAv5Oa3kiBzlatbbhxgkX7UtzbRwJrOHNCMFCTup7stQDW1McZnW9jhrogD4rD0ClnNGySdpivt7FNUbxWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+4IMYhSQpDL4tfDTVnNpx3pfKbFixTrUnbf6CQ8pu8=;
 b=rpCk9w7Kslu/5OFP24AHWDNI9iy1kxax+U2dZDJxUSMAR/977be/SwbhbKPah6HvCvLDm8VDHY4QEAC+MzrX+2saTWVVJNCr3V2JDVSykglZetdqs4P1bD7B10UL2g0JK34f1QD01SjTvbsLjHLdBt0RFwE4EBjYTZTAn7zq8txmkLqGis3Q0UuzdJg0SPZQJgNndrtElAaVUA4CL3w9xDaw2wiyqeEk4i+WlakWlNUTNCybyVJHMUi3UrmBLbPQCF7CmmMIZmz5DAq/2Q+xqYwzINBahn59RbsDTEt6c08sdSX05b9HNjP5v8/TKIDAZyrmeUmKFpN0U33pipDdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+4IMYhSQpDL4tfDTVnNpx3pfKbFixTrUnbf6CQ8pu8=;
 b=ZG3KUd7m4MmIth3h0TslYAbh0dRc34rJgydgOoyS/HumkHU2nQ7SBBPJlXSuA4na0PLbILjsS/yHEDJlmlbBTd+allWEAdjsBn0P/iNlZEDa7L2Na4xIAVotUuJsr/oP2APyRccSrJDuvrGt3AAMkpuyKzZLJWUDsuREBr+jMT8d0A4yNq8WCbFqCsvBzqnKD/lOneaVT+GQEsKgx0dSnAIZVy+WQwzYaCDfaS8Mk15KbI1DgzXtBw7hKOmmXO3MufguA8H4Iwmio3lSr+li4HlPXo5aWjR5omn0nfAOYjGR3RlE2Sayuo/vbgbP08yAFxSMlNq+hrsaHknLQEzlaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB9349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:28:31 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:28:31 +0000
Message-ID: <e17ff609-5a79-43a2-8630-28e143dc21a8@siemens.com>
Date: Wed, 11 Nov 2026 09:28:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 03/12] wic: select the A/B
 rootfs image via WIC_ROOTFS_IMAGE_TYPE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
 <20261019102541.672620-4-quirin.gylstorff@siemens.com>
 <edeedc71-4d4f-4f96-84d5-1d9e7313148c@siemens.com>
 <84a4c55f-9786-49b9-bd16-42a9ae3dd0ec@siemens.com>
 <2388290b-53b3-47a7-8a41-39c574732916@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <2388290b-53b3-47a7-8a41-39c574732916@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0444.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::6) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3521da-844e-45a3-74e6-08df3fcdc4d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261026121527099003|11063799006|261028144727099003|4143699003|56012099006|261021121427099003|261026140227099003|261022105027099003|261022115727099003|261022075727099003|261102123227099003|55112099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: AID5rpoJhvrb7RUuiFUaTxECqXuFAgcsXxhYu9Y1GPRry6vXEFTLsgk6otrfxEQw5EQEjmss65Gbgc8UrMYkMx37cSUo3m65RiedS4yz+paKXEJweGYlGJMfsfO6+gLgUMTtaetLh+UnXOUAuqPKSHy2b24b0yjf34Kr6hZa/lN5G2CbZL+LAQwLTdHeFaOLNz7mTOySSFmKn7EC7m13AD6DGDyE85zt2Jt01ZaF4q/HhkWTHLwiLcgcKWSWt6p5TO6xn2b6oC93J5HV8kGSQ8/jwOqLIf4NMo5GSrOxJttyCLgwTZtsrl9zIVUj1UaJMy3862LlhYj/8l2Ncs4YCtKUWUVYp2gtsG9j3B/A/eKPXDmLd6N2NyE5Faesv4mdi6JzGaQcn38iVPML9nYJkC8l4UuWysNlJg+XTE6LFVTV1A2Z3/LsMrZIg8E1h7P+SVgLBJ++0++a9P0Of4HETi6GVGs7rDySnFaNuOzBtCkvUqWcba7+lbXdgCUNMOrIn5GL2QlQWnbont3aDmQP08D0mz5Di0mNR1m32L3yPWtU32KbEf7DKgvghSpbMsgFvWHZZGyiTqqk7QPXCVjuYd9CNHaQRmolZ7gufVMZvf9hw5PHrxBMyPgr5kNYQVgTiUFiu5+7qX6q7VHdYMMU6iifIbzkYQgYc/xLhosvpEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(11063799006)(261028144727099003)(4143699003)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261022115727099003)(261022075727099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L254MWZqdE5DMVJSMkkrZ0txN1lQUGY3RXY3bUU3bGR0UzZnOFVGM2pHRStN?=
 =?utf-8?B?cXF3R1MybGFkRXg1RkhCWk1kUlRDNmF2TUxqNE4yOE9kbXpnUjlIWnl5dENQ?=
 =?utf-8?B?bGkycmw5UUlZdiswOFN4WWhsM2pJS2xnclYzVVpTdWFjVGZHT1VNUnBaV1NU?=
 =?utf-8?B?ekFLSldQZWZwc1phZGRnYi9SKy9sNjBLeFBGUzNTQWRiaGpXYm5zczcwOXJk?=
 =?utf-8?B?Sml5Qmh0UGRNMFZUUUFjZWxqL1dzM1pTbklEekJBTklzSVZmWCtSMytuSjFV?=
 =?utf-8?B?RnhoWldZM2FtblIraFNpTU8yV0dxdWIvOTdEUThaQVdkZjhhQVZsU0pSck83?=
 =?utf-8?B?NUd2VmNxOGxpTGpEUnkySUpqbFZYaVRrY044WWVGQmx1aGI1QUxub0JvOCtk?=
 =?utf-8?B?VkRVVjdBMG9IRTNDaGtBNnoycFQvbktDREFYdnVYc29DaWs4SVpQeXNXdEw2?=
 =?utf-8?B?ZnpmbnU5TEhKZ001U0trN1Z1Ky9vOE9IdjU4MWN6THY5aHQ3VGk1aWpzYVJn?=
 =?utf-8?B?ZmJYY1Nkd1RmbkYzNWcxMHZaVjJWNkZQTGM5VTBWa0V3QXpzZDVETVQzTk1y?=
 =?utf-8?B?eGN0TjZNT2tBRFhwNDMvdU5IMGdWZ1NNaysyMTNVVDFtaDJMNlBEaUF0NUdh?=
 =?utf-8?B?dWFnaXNxYjFjTURXbThNcTZDOCtjV2VBTnRscEZDYk5vN0pzZzdzbzFzZXps?=
 =?utf-8?B?dW1lZVF6Y1NLazV1Y3p6c1hOSjZVOExzSXFqZms3Q0FJb3pwRXoyaTVtODI1?=
 =?utf-8?B?ZUplcGlZSjl5US80cEtDUGYxbDZlN2Z3cWV0Z3d0V243UWQwUnJ0UUFYamty?=
 =?utf-8?B?Y1ZBRGxtNU9iWlp5ZTZWenhjRFYzcWk5bVo0N0NEelJDeW11TGFGVEZOcjlr?=
 =?utf-8?B?a05QdXdCczVIbzN2aXgyWEVpUjhOSW5yL2tmNWd6ZHpuc2tFaGNDcWE4TFdw?=
 =?utf-8?B?eGM3QloyUkpRd1ArT2pKVTMyNFlMc0c3L1VGVk1MTmpia0VOTXpvUHJnZC9a?=
 =?utf-8?B?MUVSVm5GK2lzdUw3a2NXMVRJRFpYemNCSGlVK0VvMHcrTFA5QUNsVTFaU1BG?=
 =?utf-8?B?QkpQaTcwQm1XdVZsRExUZnljbkxqbjVFKytlQzlqZVpPWnhJZVlxRUo5MnVY?=
 =?utf-8?B?czVmNVNsWHBXNWF4czBPQ3R1OG5UdkRoSFRTcThoSkc2aWZodzVEVzVJNW5y?=
 =?utf-8?B?TTZISFcvN3AvdHpKZXVUQXZxczV6RllrcjJha1RNSW9lTzBIZGR4SFk3akt0?=
 =?utf-8?B?OTIzQlA4YjlvcHZXM0RiUWJGNmgvbkZmdGlGbHhEZDNldjY2RHZlTmNiSTMx?=
 =?utf-8?B?U3ljczl3K3k5dUY4M3pyOHBPcCtFKzlYZlJwa1J2MkRZZWkwTC84VGd1T2ox?=
 =?utf-8?B?SXFaaGVlUFZtTlVyTGJYZ3NQazhVZnVtRGVDbmZGWUNNZEsrMEZiUkFHMEVr?=
 =?utf-8?B?T2g4ajV4VzMvZW51bkVFVGloTDQrU3d6K051MWVOdmY0bzAraEdTbnUveXc5?=
 =?utf-8?B?cDdzVC9yRUFaSS9IcUpac1pKdGhUQVZQK3BBZk9WZmJ0ZEpIa2VibklIVUJ3?=
 =?utf-8?B?S1FLUFVNRkxFUDRWUnVsZ2xERmVHTUhIWHhQM3ZVK2hGWk04NHhFL2RQeUdO?=
 =?utf-8?B?N3A5b1MyUFNwYVJoSmNkWWo3bFYwWUhCbmRIMjZpVFZGR1l0aEw1aTFlWDVn?=
 =?utf-8?B?RlByQ213Z0kwKzlscmhXOTJoc1g1Z0RWbWJ1NU5mL3Y2S09WalgxSTl4eVdh?=
 =?utf-8?B?c0dzM1JsZ1YrRWJETjNvRlBXVEJraUsxYjVQMWNWVWJ5RGQ4aWZ2UEpOT1hZ?=
 =?utf-8?B?YWdIZHdwTHRkUGpmRU5uUlhvWHJJNW5yUmg0K0x1bThENmNMWFJTUXRNYmQ0?=
 =?utf-8?B?cWR3V1ViTW1FZC9xQWpsTjVYSnc4ZEFvdjZFd2Rad3lOM25kdzI1cDgvNU1M?=
 =?utf-8?B?L3hMUHdueVRHTXJCWDlCbGEydHN2a1JxalRpSWNMZ1RCWHd5enFkZVVCSjkr?=
 =?utf-8?B?aUk3SlhrZ2YwSmM1TzFVOTFQRUFwbzA2WDZtWk9Bb1lCQ0Z5eUtZaDlFM2d3?=
 =?utf-8?B?dkxzbVh6ZnRwTkV5WUF1OFNMdXcyNGFoUXZaYlpuR3RMZldYVXNmSFhpZ2xJ?=
 =?utf-8?B?QnQ3dkpudkVMbDZGWXIra2laMWxLYkpTUy92QWtwSnF5dWIwWHdhcmRKZC9k?=
 =?utf-8?B?eXAyZmIzQ1FmMnhxTWQ3cUVJdWVlOFppMUhTbjExK2lWSWk4dzRxcTIxd3NO?=
 =?utf-8?B?QmFWY3ZEbWlmb0Rxc25TektzLzFKVjNWM2dTdndkZDczWXMwMThodExvMlFW?=
 =?utf-8?B?UzVTMzBCQzhFdkMxM0REZXZSSlo1V04zZzdlSXRSUVhlN0VkZVNMbndZa3k4?=
 =?utf-8?Q?PAezTBPs396lbQOI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3521da-844e-45a3-74e6-08df3fcdc4d0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:28:31.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7EgeK/yD9ivk6QShy6kYi+DWRDKSEfQVTVH7ncsrM3yRhmPtyZLRaUkIZTi92QbAXMOlBG2mnloZWUADZcO2fgQyMoZ9yopqAuPuu6vYcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 08:28:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24739



On 11/11/26 9:20 AM, Jan Kiszka wrote:
> On 11.11.26 08:44, Quirin Gylstorff wrote:
>>
>>
>> On 11/5/26 7:48 AM, Jan Kiszka wrote:
>>> On 19.10.26 12:25, Quirin Gylstorff wrote:
>>>> The efibootguard wks files take the rootfs image from
>>>> WIC_ROOTFS_IMAGE_TYPE, which is verity if RO_ROOTFS_VERITY is set and
>>>> RO_ROOTFS_TYPE otherwise. cip-core-initramfs installs the verity hook
>>>> via the new ro-rootfs-verity override instead of secureboot.
>>>>
>>>
>>> Err, we still have both RO_ROOTFS_TYPE and RO_ROOTFS_VERITY? This really
>>> makes no sense. Please avoid the latter, it looks redundant.
>>
>> We need two flags or variables to differ because verity consumes a
>> rootfs.${RO_ROOTFS_TYPE} and changes only the file suffix. in theory
>> there could even be a ext4 partition.
>>
>> The only way we can avoid that variable would be to remove
>> ${RO_ROOTFS_TYPE} from the image and use a non coded variant but this is
>> other than normal file systems are handled (.e.g. ext4).
>>
>> Third way would be to look into a separate verity hash partition like in
>> the uapi discoverable partion specification[1]. But that would be a
>> redesign outside of this patchset.
>>
>> Another separate patchset would be to move the partition creation and
>> verity creation into a wic recipe. Which I don't like because it creates
>> an additional wic plugin we need to maintain. The current approach was
>> inspired by meta-security[2]
>>
> 
> Is still don't get from this why RO_ROOTFS_VERITY is needed. It's
> RO_ROOTFS_TYPE == 'verity', no?
> 
In the v1.13 implementation RO_ROOTFS_TYPE can be squashfs or erofs. 
verity is solved indepented. As verity.bbclass consumes RO_ROOTFS_TYPE 
to create the verity image.

And the secureboot recipe then has '${IMAGE_FULLNAME}.verity' hardcoded.

Quirin

> Jan
> 

