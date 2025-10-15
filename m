Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE6CCD195
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 09:26:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.58])
 by mx.groups.io with SMTP id smtpd.web11.11588.1760520360064694926
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 02:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qcp8XCHw;
 spf=pass (domain: siemens.com, ip: 40.107.130.58, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfDK4GvGXM6ilifjWu11oUEW25xdqXVy6cxaHHEarCJy4lIkcT9UIw63+KrTYoHiWZrIZ0VZ4PVx+wTmAwxIoqCfBqtHPHIbAcUXWkKbaF5XOOnzQUo1npu18kap35V/Akkm7c5V8/1BjralZ8aMcpJuvA/7b0lvgGbH7ihIXIj0Ax1eK8z0e7P3lmg4yP3a6F1Quq7D1jve1mNNBv5E73drUTC1mT/wBSVcFzfhSue6NsrGp5TbFNQ/ejg1fxObDr4zZX0fMenFUQUP+WueCu8L+g8RPnaQka57ME3PH1hBsvrYiT0oGcIlrZtZZWqHy8mmgqUpVdg6emE5JAVzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4d7IenQSf6/i0Ni0uEWwHwXA0T869vsUhSAL+puER4=;
 b=cXMbC4wNmNRXG11wy197zVh82L4ItYmpBBBatLuRIVr/Cs1wAfh6g3XTiUmQxUfKgTcjAr19P8+Tc7lJ7OF4OVDKkSCgzojoPViuw/84beMmpnwGY4sqlq9ZejkgNtN413tAVmBYXuc30smluWEecx866ASLx9eTlTaAwCDgHJQZVmrvlCynj67AiRbS3UhFE7WRmSpriykLiO+3zs6qSBRqoo6Yfm7G8ZQuFa1hdv5T1AS7ZP5nc6k7dNQQ66YJQZW9AGgr4IvbnGshbu+tflMezTv/Gomi2Y5275vag5zB7pKyDzehmqMhdImbRS6ycAnRgxvN7wdqqMbTKQG9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4d7IenQSf6/i0Ni0uEWwHwXA0T869vsUhSAL+puER4=;
 b=Qcp8XCHwntdyOgxQ5MxAw9LKBVFWcobOFzmNgOpr2G1oTFFl9K8KWmxeXtxAA+iAXN2Af/FZSWMTC9TvuYchnFNKngDN3W41tHZEF9qC69CLWjh5VCIw7DXMBjby70M5EvC8t+X9JrdUGfddqOtL8K6Yr3KyuvtBv9j+8LKaq0swmZdjl0DqZDXBK5r8ndCYR7JaakManOqEzlzeiE+qUXzOqqSoTU8Zm3AC/hSle2ycmC3bLATf1JfrQSgUBXSgRlablOiw34rNH3ij3VBrAy28eD4RKaO3xOB2g9ZIdidisVDYikeqbIoCQeBJv22CfIECJF5CYh1x7sCsMiyhRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:25:54 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:25:54 +0000
Message-ID: <86499842-6098-43d0-8e45-caecb3fd18be@siemens.com>
Date: Wed, 15 Oct 2025 11:25:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Adithya.Balakumar@toshiba-tsip.com, Shivanand.Kunijadar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com, nobuhiro.iwamatsu.x90@mail.toshiba,
 jan.kiszka@siemens.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::12) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 653bd041-d72d-49ef-94f5-08de0bccd716
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TnlPZ0dqL1RvbEJSTlVzWkV3VjdDdnF2ZWd2NHNZbS92VGxwbzdpWlZGK2Vn?=
 =?utf-8?B?NTgzY0ZDYithenFtc2NVTmo2bDJXaUtCMHpIK201aEFlNG9VeHIrQS9Lbk1C?=
 =?utf-8?B?ak05SktrQ25hQkY2N29Vb0QrUjE5d21iRkRqQzNxak9mazhBMldhMDBTYXFm?=
 =?utf-8?B?QlFyM1lzREhJdHRKZzNGUTYvY2ZYdnQ1ZHNESGVoNmV5dm9meEF3c0xITGdR?=
 =?utf-8?B?SklYdVN4TW5HRGVkUjN6QnpxRVBhYzZCOCt0QVl5OURHUU1VandIQlQrS2po?=
 =?utf-8?B?R2IxdmVGeWIzSWdYT1VVcFJ1cm9xdXAwRlBnL0lPMU00c3V3cnZFazA3Y0FE?=
 =?utf-8?B?bTA5cEN3M2tNUUcyTTMyZFlVbk9EMWhGOHhKOFVxazVZdm5FSDE1TVhPdFly?=
 =?utf-8?B?Y0c0VWNrZDVtenYyakJLTkY0cW9xcGNHSWRTR2RFSlUyUjBkY1dIMHNFK2hm?=
 =?utf-8?B?V3pGMlF1bmhKaC8xYVNiMHNqVTVuNCtMcHM5T0hhcDh1VmlsdFB5L2l3L1ls?=
 =?utf-8?B?OWJ3Yi9LODNaWjBlalNUK3ZldmMwb2xnS01rZWRpTTl2cSsxWDBub2VvMzRD?=
 =?utf-8?B?UHBPM3dZeXlnenpXa1VjcWRJbENDb1hkN3NORjcvd2UwUDhmWFdtOE00ZktM?=
 =?utf-8?B?eXVFWmJhSTFFYnNwWE9GbUpZNUVkOC9WL1ozb1BZNEVyc285dFBJeTBIamN0?=
 =?utf-8?B?N1I3a2UrK2pEMGlaemRPUnlQdUNCMVJweXhUNHg2ejMzWFZEZHpTUUV3MjVC?=
 =?utf-8?B?K1BnREFwb2FXRnpUMDdVSGNNd0hoV1J3TjNoTXlwd1YveE1iVVNPSGR4WVlY?=
 =?utf-8?B?bk1wVjBqSVlhYVNBNFQzR0lvN1RxQmEzWCtRNHh4WmIwWTk4OXU2QWFIVzhV?=
 =?utf-8?B?eFR3TTVwZ1VEVC9LZG9hQ0psaTZvd3I1N0cySTdBU0F6VmdFSkwvNWlzUTdN?=
 =?utf-8?B?clArZTAwRUZoWThHUTAzdkZRTWFHeHZzTGtTWWduQWtzczlPakNYQm5IelpC?=
 =?utf-8?B?MkMyKzdzbTU3WmNxWGRndTFyU3BqNEgvWUhQenBZYy9pczZLTGMxTENQdnFu?=
 =?utf-8?B?QjhLbUJyOHFldjdmZE05MU9ISEVmK1dLWm1UQTJYMlAzQUc1dDVoR0tKM0pQ?=
 =?utf-8?B?TzIzc1hZSWxJeWlrNWoxa1hCU1REeitnSFdUaWZuL3lmU1E0VnJQOHpXc3BP?=
 =?utf-8?B?K3hQRGQ1TnVJeGZpcVZxdHRMYkx0WExIKzRWY3dmaCsybWk3R2tJdXFUZFUr?=
 =?utf-8?B?RVhlZWRpUFF1MUNlcjlleE9JTjgvMzUwS2J1eEE2dXQ1WnpkSHdjNWpxTXlF?=
 =?utf-8?B?aGk2S2FlcDFVOTl6RnJ2ZC9IaVpLam0zOFY2ZjRQTDFyb0pYUHBtdEZXRjZD?=
 =?utf-8?B?ang0aitrOXlTa0djd2xKNVg0VHhad0tSMWNWQXZkenBKcE1NSHJvdTdNWlly?=
 =?utf-8?B?ZVlmRTlrT24rM3NvSzZsZ3FsM0RrcCs2dXBRYzNycXU3ODI4WFdUSHpTU0xN?=
 =?utf-8?B?NE9GZjhNTGRNeG9sVzlEMW5pSGdna2NvMkRJdEtvMUdMc1NVdWYxVjRVaXZP?=
 =?utf-8?B?YXVTcE9HM3grMFJtVTBGbnlLTW00NFl5NEx4TGpMNVRRSERpc0s5WDUxVnFv?=
 =?utf-8?B?WFFsUDBvYllPSWRPNklVNzJsTElTSC9hUFg3eEIyaTh4bytwdDQyU2hUSk5y?=
 =?utf-8?B?Ym1ndDdrbXc2dWEvbUtXVk1IQmJIUFFvMjZEa2ZsQldQL3RkVHBaUVRRT3ND?=
 =?utf-8?B?MG5Vd01PdDUvbTBkbCtXYnZmdU9aQUJrZ3dzY3p6T3lMRFRlRWFXYS9GeUxl?=
 =?utf-8?B?ZlNVZE51b2RnUW9hMGM5VjlMYkJMbnk5MDUzYWFWTElUb3BkNHVZb2pQMmJS?=
 =?utf-8?B?bkwrV3ZWcW5UQXNwMEVKenJXb1FBSlFWaG9BRG5zVE45RHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bm0rOTZNeWJNanlkNTBUUUwrMyt3dXFaQkVDc3htSFlzck9nbC84N09LMVow?=
 =?utf-8?B?bzJYcGJHNi9GVG9pVnJMT1l5TlM3aFNDOHlIMjBMTHI3MjBPVjh3bW5oM0Fs?=
 =?utf-8?B?RW9kYmNkMmQ2L3FFdTFsNDZ3OTlCZDcyN1RpaVFtN1YwRitqTUFXZy9ocCtr?=
 =?utf-8?B?elpnd2RUeXpCaDVaN1VjdEZHRkVuWTYzdTlqRzl2NjY4ekp2V0dnY3Z6UGFa?=
 =?utf-8?B?MDhlK3ZjYjh2YUEyVGZDM3BHeXlOZWYyVmVpbDQxRHRhR2xYY1ZhenFuVUky?=
 =?utf-8?B?anpkYnRYZ09iajlJTmhHOU1BNTRWeXVTQndobmowNW11MlI4Z1JHVGRJZ3lF?=
 =?utf-8?B?VjVPTTh5aFRrdi9jUTRYdTNBbDE3Z1pOazdRSXdxZjc1VUtQUEh6VGI1NHJG?=
 =?utf-8?B?WW5qVzNtMGllZi81T0FBQ0VmTVMxNDdRRG9VUFB3ZGc3R3hiZmtvL1Z4bDli?=
 =?utf-8?B?cmJjWWEyNnlEaTRteTcydnRTM00zMjRlYnI5TUpNb0Q4ejJYeXVjYlZrd1hL?=
 =?utf-8?B?NWpkR09OWjI2UVcvWmN1RUtpV05HK3ZucDJuUURtdGpNVVQ2dXZsaU0xZllP?=
 =?utf-8?B?cXM4YVdocnZUZFNPcjdEdzJhWW1qTnFJdlFPZ2dIVlhiUmFyYTRyZEs5UnBz?=
 =?utf-8?B?VmQwdE1MbkVkNkJ4SnNBVEdvek5MU2xEdUVBcWExTDRaWjRpbDR4Q0U2SGh3?=
 =?utf-8?B?QjNCZlRNNzA4RHEvS2RUbjRBbnVIZjFIR1ZxaVZXVEYvc2kxcmJYbi9pZ2VC?=
 =?utf-8?B?SlRLZk5hajh1UDBkQXBKdm04Y2g2TGs4WGIxakp2MU4zcFI2TFcvZnBlSVgw?=
 =?utf-8?B?SFpzK0d0cXI1VVJYQ3N5U3dtWHZIQzUwWXpONmJUMU52V0Q4QTZuaTF5aWVM?=
 =?utf-8?B?YWlwbDJlYzFvNlpNUU83V0JFZnRLZzJneU9WUC9hYnFFV3R6SjY2VHEvRmgz?=
 =?utf-8?B?a013YVRWUkJYd0lkZHhlbGJIT1lCYUNGM1RBWnVBYmFDb1ZLV2crRGlFMk0z?=
 =?utf-8?B?MjJwU25KZi9KL2pwWHVLdVVwQlBDLzJEQUhBcFdsQXFTOXowUVNYaEo3Q1pr?=
 =?utf-8?B?NEhSeGZwK3hBNkIwbUdCZnorWGFWNXppRG9QUmtQR09NbDNhdDRBaHZDSm9C?=
 =?utf-8?B?UzdLWHpoQ1JnY3VDRmlYbkM2NFNoUzUxU2lsd2N4Q0dmcmRuT2NUYnZXaDl4?=
 =?utf-8?B?NDRmWncvNHh0citZdUlXeTkzL1lhV3ZpbWdhTE5Pd0c4WEpUSGZ1b0w0b2tZ?=
 =?utf-8?B?NHUvTnNUUkxwZkgwNzI5ZHVMWU5RSlpnazhSb2JrYzVEYWo0ZnhhMXkvR2wz?=
 =?utf-8?B?RWlSdVhzTHp6VGo5bkZVc3h6TXFFdXFTdkl0a0RWRkdpbEdPM2MyUWdvMk5I?=
 =?utf-8?B?Q1pTcDg5NEl0Z2xyODhhS1g4OHhTMnFjblhVWXJpVmZsbzI2a05NYitzdE1G?=
 =?utf-8?B?QjVlMjlZV0gwYW5JTW9OT096Y2ovczE5dW9OUjNZd1loQWF6a1N6ZUJpU1d6?=
 =?utf-8?B?R29uK2U0RGEvbWhBUXhhYlAxM3Jwc3hmQVY4eWZIVHdNZmhnWFJhd0VDcXQr?=
 =?utf-8?B?YnFua2tRRWRkdWp6cllHNXcxZUQ1TllKL1R2a1NZYkhQRE1HTUdPanlqRGJK?=
 =?utf-8?B?ZjFrd3Q5RWNVRVdnbitzZkY4M1NiYVZ1L0I5YThuUGtNbEIveXpaU041WUph?=
 =?utf-8?B?QzZ2YXFxRDNyTW5XV3NTdktKNWNUMUNvd2oxUW1IbU13VU1PN0d6RCtrOUY2?=
 =?utf-8?B?K1I4M3p2OVh2OXNUdFdWUm9EZEpBT3h3MC9VNjlNNFY5VjBBR3RIeWtZTE9D?=
 =?utf-8?B?RkFWVEFoMThPaWlhbUVUQkFIcFVJSVBDcnBPeHYxYjVWVTc3dzBUY1NwSk5w?=
 =?utf-8?B?VkxycS9jd2pIUTdjZUIraEpFZU1ZYjhtTVpwdGIrUE1rWDNsWnlpZUdNTTZF?=
 =?utf-8?B?cURkTWQ2TzZadGNxVkhtVitkOUFMMkovVXFVSjM5MWRjRkZVZTdXdkYvWFZH?=
 =?utf-8?B?WjhLQUt1aTEvVWdadkNCamVNZXc1YmM4MHYyOWpqcEMzcFhsdWRRQ01sbHZQ?=
 =?utf-8?B?cE4wcHc5MFNlOVhEWW9HdE5ibjh0RHpubUpFKzUrZlpDNEdtS00wNXNYaUhr?=
 =?utf-8?B?Yy9IU25HV2N2cWZ0UXliaDREQStIaGllU05jMUprdCt0bzlmZjBLcW9IREJ0?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653bd041-d72d-49ef-94f5-08de0bccd716
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:25:54.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxHzAtfPnJawW9QarqvJFFxqKt49hAKG3Kic4nQAj7JHQLJpXSyErQGyDs4BvPG2uXKYHl58lNa+yybFz2OsweRwAJmYaGPowM9NLMkfhdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 09:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20177


Hi,
On 10/15/25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Sorry to jump in here.
> 
>  >We may have a kernel configuration issue here - or a real CIP kernel
>  >regression. Going back a month to a passing test, we got this back then:
> 
>  >"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
> 
>  >[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/ 
> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar- 
> cip-core/-/jobs/11344068159#L1724>
> 
We still were faster - the last successful test on September 
https://lava.ciplatform.org/scheduler/job/1309843

were the 1.9_5 test did take 298 which is faster then the now measured
712.

Quirin

> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
> QEMU IEC test jobs have always been quicker and are even now.
> 
>>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
> 
> As far as I recall, I don't remember the IEC tests run this quick on the 
> LAVA M-COM. Apologies if I am mistaken.>
> Thanks and Regards,
> Adithya Balakumar



