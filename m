Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9139C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:53:56 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.86])
 by mx.groups.io with SMTP id smtpd.web11.88522.1740401635851681511
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 04:53:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KaTs9Au0;
 spf=pass (domain: siemens.com, ip: 40.107.103.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reFFo5KuAEO5vRI0rmWmlNB9cy8UA2BfnXdnpNKBqHRXHo6QZpVOh069zGSln5zlF2omDpJd+u7rIQVIsz9nT3+m6dbDGB3v/Q54bkLDpwp8bNfv2mYTEAHLtgj78bwLagMldYWPUwr9GR/uFxuJTslYpFnj7fdNIYg+/6kCzkMI3L5BHb04tMBKJuyzEiGwn+hWmytvWiwsyxZBgnW+FFp/PiaS6QhK8Hs/4on1oBVfC5Dkn76FppF3BT3SQACqK3NYTUYunlo3S4X8Sx887gV8g6/jT2/J+ONMU33VVyji0SxKsCtcS+nGUPwaOIlQ7zXEK03STSUM1/7lebtHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHzpqat5rqNEysAo5BCjuRj9hKjlBDw1TEHAOthsShY=;
 b=JZmRp/xmSdPLaYXmy+otOCTXwK40KYyLPjJ0ldtOZtkDtioD5fCO6Uecnsbecqf4BHTne+JJFmtiOzVRWcelSY/wQBLb/nQDnEEirh3DAgmiD+8oogAXYzAGiesT9y06fqwn50KUXK8fV9G87BBnuuAhDuNi03ZZ7O13MSqQzUL9gp2d975yqKWfrasWMezwcjYdp/ZeNl1nafWz3kP1P92cuA1vvub5eG8Mn9vktRiBZS1ojQ51oZcp0kl2TcOhwnOsg2KpKz03Bljx6Uoy3FTOKR2irbAyn5RNtJb/re18xlbtHKdeCDrjGH89gj31lwiSA12j38xXwf3Ui0KtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHzpqat5rqNEysAo5BCjuRj9hKjlBDw1TEHAOthsShY=;
 b=KaTs9Au0yjcTsicsG9DHavkZSFmZ5CUwqLjYIALHmnoBKXQCpCacYtjUpesgWqK6FbYgUjjWDxUGG3j36XZkJu3zFtxIi8rh8tVKz+QIkeZKProZElh1fxmG1tS6W5v5BO7G7LZlBMZJ2qbe2kOmCR0OY4TFlkvS08LTOn6/by+ZQc3QrwV68pHO8Xawo4xBkPx9P5eWPwKUE715bFyXPXDtwXxSRhUVgO5LfeNTct1mmqB+0Q7ccWqxp0Pl0K9PBSdZboUEpBEZxFO4L/yLSvBZvK1jf05Nx4ghq926GbaKL3UgFvLZGoYjq8llgI2j3kbslEKNacMlmmnasF7uzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 12:53:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:53:52 +0000
Message-ID: <3455372e-70c8-4524-9d99-116d991c5221@siemens.com>
Date: Mon, 24 Feb 2025 13:53:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <20250217100024.42995-4-alexander.heinisch@siemens.com>
 <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <c4af6328-d4b6-4bfa-ba32-0d66b2abb1e6@siemens.com>
 <AM7PR10MB332040EB4740B51F543A8D3586C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB332040EB4740B51F543A8D3586C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:610:e4::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f24f9a4-d485-4170-f3bf-08dd54d24a4c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NW1mcnVBZi9seG9Hb1Q2QzIvM3JqYkRWKyszaEpzSjVmSUZZL3lRQk5ZbjZ0?=
 =?utf-8?B?dnFzakl5VzN0d3QwWWZFUnJnZUI4M1ZFYnExQmx2YjVuRmxiOXJlT0JsZTlG?=
 =?utf-8?B?bnF0RldKQzIvYkhEK01zbnl2U25sUVp0b09qRmhJN2ZkTmxNenpiTFh1Rjh4?=
 =?utf-8?B?KzB3L0dCTFZnRjlVYkxacDJjSlRVQnd4OS9jOGM2R21WaFVhUGV3UEwxTU9y?=
 =?utf-8?B?UUpHVG1vdk1SemZKTGFvNmFmdkthUks5MjcrQVBMOVk5M2grRVlOSTF4S0V4?=
 =?utf-8?B?b3B0QVlobURleU93Uzg3ZXl4dnpPdmw1Vm9UemNCYlI2M0h1WGcvQTNZUGpt?=
 =?utf-8?B?WHYvaU1JcnpSR0NnbHNMK29mT2NWU3FBczZtbnAxQ0EvRzgvYkpqWC83aFJo?=
 =?utf-8?B?SWVoU0tXWXV6Sm53RkRSejBMRXN0Z3VLR0lDbHcvQmZibm9WeSt1TlZWOHZj?=
 =?utf-8?B?ZEQ4aEpxSFBMd2R5U2hMQjJDZlFlUWtPdCtLY3ROYXphYm5kcVR1M2dYOU1U?=
 =?utf-8?B?WVRpNDhxVVR2TVJRRXE5WnBxcmZneE40VmorbzlLMEJ2c2ZNRGxka2dMRFhH?=
 =?utf-8?B?aE5TNlZMdnJFS1hsaldJT1o1WG03WHVSUmw5ODIycHBuUjYrWExZbUZEY1pV?=
 =?utf-8?B?anljN1UxWVdPelppa1B3YXZ3NW9mbCtwaGVseW9qUkFJOG9tTEZacUhVeFFD?=
 =?utf-8?B?eUR1Wi90WGNGNmVqTGdYNktBWlI1SGlncVFvd3Zja09IMm42bWkwV25ZcWZj?=
 =?utf-8?B?RWEzUmd6dVpBcnV0NlQzdkVkanh2UXRkVTMzQ1pPZHhJMThOZyttWWs5c21D?=
 =?utf-8?B?cXlNN09wS2NVYVhHdytrczV4aEIrSnJvOGxnSmxWVXg4cVNLRHRKU2o3VXgw?=
 =?utf-8?B?bHZtTHZEYkc0TG5iQ1pyNVc3QTczM3lRVG5zVm80UjI2UkRodStuZndDTFVH?=
 =?utf-8?B?YThEYTFoS1daTDZLZG42QXpSeTNJVTkvMzAwVlkwUE5tS2VXUzhQdGFqZnNa?=
 =?utf-8?B?OWllVFVxVWRFRjRtUStGYkdzK2ZQa2lZLzFObEFwS2RoSk9uWjJrV1doRDFk?=
 =?utf-8?B?Q1l3eGRobGRDSTVHR3FsZVRPTDVHdk9icXJoY1hqTzA5U05mSjVQQkVQRERz?=
 =?utf-8?B?R25pYkFlSWxXd1RMZ3VFWCtneG5IT2N6WFBZMlh0ZytMZlV0TTJtVndoOGhw?=
 =?utf-8?B?eVJGT01IazFRbURad2QwM2VNY0V2MDBLcG1qc0Q1OGlVY3V4dDRibkFNRXAx?=
 =?utf-8?B?SjR3bjJFeFkyaVJFdldNcjRRYmM3KzdIOThKZGtzLytZM1gvRk5VVzR3R0xJ?=
 =?utf-8?B?UW9UV1lRS0NyYWZOVCtqemdlNXRzMzJIUkwxV3JsTmcva0Q5emtMSHh5WUdH?=
 =?utf-8?B?Q1FYMjE5QU1HSE9rZzFlQW4zT2QzQWlvcU9ib0hyMEh4UFhNZ3J5d1VNRG1I?=
 =?utf-8?B?S2NEbEd6M3hPc2VuSVBNWWxFZXFJalJGNUVDOGVZTWduRnNRSC9VYjZpVG1M?=
 =?utf-8?B?TW9ZVjBHN0wvcW9UamRESytFR0ZZM0JxY1VVTkU2Q0p0SkJ4YnVWZXlET1hF?=
 =?utf-8?B?QW94d2NQZWZRWTZWZ0ZoZGo5NWxYc25EcE51cnhtUHJDaFFuU0NCOXlpYkhx?=
 =?utf-8?B?NVJWUmxuNUFralhKYjFkWHVKUzV5Y21SUjIrbGQ1Ym5LUzFrYmh1VVg5UmJF?=
 =?utf-8?B?VVM5bTVhQ0VHTFBvMTNVeDFIOG5QNlZYaGU3SzgyMFIzazRoRU9oQjNHa3Jy?=
 =?utf-8?B?YUdXeE5IQXJaaFdoRGQxU1c1eUg5bHdCbFNTVkI4NFA2ZFk5R1pTeVpySEhK?=
 =?utf-8?B?VDd5UW1XbjhaY3BBemNPVjArVjNpejE4MFVLaHFVSkFTbk5lcHJieG04U1Mv?=
 =?utf-8?Q?qkP6gWZvBU08U?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVRZZGEyYUZRUXpRMTJST2xIWTRyRUMxSElhVjRyQjJTNnowVVo0WWtCWnpi?=
 =?utf-8?B?YWNBVm9wMDcwM2dvMHNXM3J0L01IdU8vQ1BGQkJiRXUvdVk4dVl2aXYrS3E1?=
 =?utf-8?B?QnNhK3YxRnpGSHpqZ1AvUXA2SEFjSGJxRytLdWNEaHlTVVY5QnVBb1VaN3I5?=
 =?utf-8?B?V001S0ZhN20yMjFnUWE4NTVQQnp6M2dpT211K2F6ZEFNb0F5WjFPQlJCeUI1?=
 =?utf-8?B?Y29tOGczQitLNkphbnpDVUl2MUcySHhFVlJmQ1hLT3AwQkNkaDFRc0pra1Q3?=
 =?utf-8?B?VktaRU1lYmRqY3FyUXU0akJHMUNaOHk0WE9aS3UzeVZHRGVmVkk0SmpmMVJG?=
 =?utf-8?B?VStpU1lyc3hYT1VVOWsveFE1eWswNWlsNkZjYlF1ODFTblE1WEVBTEFISFJX?=
 =?utf-8?B?Tm9xQ0ppcDI3TGtnQ2JZWHk3cUptb1ZiRmlxYzYvdFZLS3I4UFFEYzRxb2dM?=
 =?utf-8?B?UlNUaHJOL25MYTRUSVkrOUV1WmRyVFovY1VqSE9nYW9nSVVVRno0NFRSR0ZP?=
 =?utf-8?B?aGM4bFVmU0s0dmp2TVNSTjhsUHY4djlLYXZLWEc5aHRVR09tN0VTNFNLWXhE?=
 =?utf-8?B?NWljL3czZ29EdlBPbVQ4dCtrRGFneUZod1VqVU1HMURVeCt5d3dBUVRpcTVI?=
 =?utf-8?B?VjFOcmRETEc5UnNTcmZ0L1JQSU5TYkxRaytTNkVROGxYTUtWKzdud2s1L1Ri?=
 =?utf-8?B?czdteW9qRWdWRWF0N3BHVGU3Ny92VGdwWjd4Sy9BUDZRQ0pRWTV4K1VQWm1j?=
 =?utf-8?B?M0dMVE9SWUI0T3JYL3BhdEdHQU5aMGhqb0JsMm9Eby9tQ3dGUXpkM1ppR3pT?=
 =?utf-8?B?WW9PZDcyVWxFMlljVHZkN1JMbTJLUjhucURKY2JEYmcrcWxDdjlvSmVtSnpw?=
 =?utf-8?B?MHF6b0FUckh3ZnlxbmdSaEdId3drU0w0R1g3dTRlT21ZYjI1bFUyMHVUR0Vr?=
 =?utf-8?B?VlowWWh4T2FiOFJHNmRLN3lEajBzTnhrQkxsWnduRXZtancycTdvZWFudVpX?=
 =?utf-8?B?Z3FNdERvKzZIcHVsR2t3MU1YODkxelRRckxOZ3Q5bUZnQXQxWDVuZEdYOHRI?=
 =?utf-8?B?M2lienVKLzUvMTF0WjVNeHZ5SFh2L3VCeTdkZDJLRHZwN0h6Vkl1UCtmUXlt?=
 =?utf-8?B?R2Q4NlNNRGthUmN0bGQyRzZKQXN6dy9pOXJ2N2cxT0x6anYyeUphWHF1YTZk?=
 =?utf-8?B?ZzZKRDBsd0J4YUZZK1JnbHpTRk5Rd3VJQjd3bTJjUEVBcTFNUU9lMEgwMzZx?=
 =?utf-8?B?KzM0Uk1CV2VRLzFIdnloTkV2UkVGK1VoZTNoZVF3VmI3MTJpVit6cFNCckI4?=
 =?utf-8?B?a2xUMUJuN2VQNHRhTFU4TGYvakhjY1NSOEtTR2RSUGJxeEUwei9TSnNQd29l?=
 =?utf-8?B?SXFuMWdPa0w1c2VVNFZZdXkxWHhxVm9WSUNuYnBOcjJ0a3NzU28zenROSG1X?=
 =?utf-8?B?NmF0SkxjaklvUTN2RlRiRW5sN0lXbXk1eFg5ZjYrZDN5UXloWmVxRTVjUnpa?=
 =?utf-8?B?ZGpNcVhieEc1eUtEWGZtZlpzcklEeDYzQmdJeWdreFZKTmJ3Znl2Snp2aFdC?=
 =?utf-8?B?Tnp6c0JtWGxkeGlmcHVISk12YTZHbVNPZW55VjdTWno0VWxCYzZPRU9URStt?=
 =?utf-8?B?ZWxaU2N5QmVlUkpqb3ZENldtSlZKVzdKb3Qzd3RLLzExTVZDZVY4NXNKaER6?=
 =?utf-8?B?d0c4UEpTSXFEZDlpVkdKM3dxcC9hYnRWVmJ6RHpNUDFkS0hqeG5IVUVVOU9j?=
 =?utf-8?B?cmJ5SzIydEZncEZkY2t5NXNpVlVBcWU0RWNxOUhQdXdBS1VEcUxYd0UwMGcv?=
 =?utf-8?B?Sld4UHZsNXVKODRoT2ZwczJmWi9tak1lMHp4V3VsZng2WHRNcVpKSTQ0VXpF?=
 =?utf-8?B?TEp1SWV6ZTFzWlV6TFcwUHkydkcrb1hOdmUxUjZJd2NlZnUrVFVFVlBMOWlt?=
 =?utf-8?B?SmJMS24zR3h5Mnh4SC9iMGpORm9UV0tUUVhrRG4wdUhQdjlPd1VPRTdHMFlj?=
 =?utf-8?B?OENpRjQ0MW1VeW9PMDVtTS80WmtIL01iQUhZVXNmcmNpK0hvUXB5VmdxOUxj?=
 =?utf-8?B?M0Fxa0V3dEl1UFJUZlJJMVVGZTFDZG5sUVAreURPc2RBdlhzY2JqSXphendD?=
 =?utf-8?B?M1h6RVNock1KNU9ETEhoek1JWmhNVXNQNkhBQUxKVkE3VDZxcnVKTndMemZj?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f24f9a4-d485-4170-f3bf-08dd54d24a4c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:53:52.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 965XfQXZrQs7hKDNhj7fAj4n1FDyGAsFmmdprsXVBHGWvsopujGzKkalvV1HyTROmDepAgwhnXSpX3mehlSDNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 12:53:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17895

On 24.02.25 13:49, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 2/20/25 14:00, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>> On 2/17/25 11:00, alexander.heinisch@siemens.com wrote:
>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>
>>>>> In addition to the overlays for e.g. /etc we now support persistent 
>>>>> overlays for rootfs as well.
>>>>> To enable this behaviour you can either set INITRAMFS_OVERLAY_PATHS = "/"
>>>>> or extend your existing config INITRAMFS_OVERLAY_PATHS = "/ /etc"
>>>>>
>>>>
>>>> I would like to avoid that anti pattern of creating an overlay over the complete rootfs. What are the debug case you need a full overlay?
>>>>
>>> To be very clear: This is not meant for debugging in the field! Never, ever.
>>>
>>> The intention of having a root-overlay for us was to have an easy way 
>>> to develop and extend recipes based on our existing images. That 
>>> means, we wanted to have the possibility to install packages with apt, 
>>> or copy additional binaries, services, configs on the device without 
>>> having to rebuild our image all the time, still maintaining to have a 
>>> working environment as close as possible to the production image.
>>> That enables us to develop features in a debian native environment, 
>>> still being close to the features present in the final target image.
>>> After being confident, the steps done and changes reflected on the 
>>> overlay can be transferred fairly easy to a recipe and end up in a production image (image without the overlay).
>>
>> Ok, this still does not explain why
>> Overlaying `/usr` should be enough for these use cases ?
> 
> I explained that in the thread with Ludwig: 
> "
> Probably that's the case for most partitionings. Still having a complete 
> root overlay is more generic imo.
> But I am open for that!
> "
> 
>>
>> Also this kind of testing  ensures that you will not find issues realated to read only rootfs in your packages during development.
> 
> Same holds true for overlaying /usr. Once I have fundamental parts of the
> ro filesystem overlayed, issues may be hidden during that time.
> Anyhow, as said, this is only a feature we enable when developing new recipes.
> Once the recipe is done we rebuild an image without root-overlay and 
> testing is done without such overlay!
> 
> TLDR: I am also fine with overlaying just /usr to simplify the setup.
> The initial idea was to have a generic solution for a full overlay
> including custom downstream partitionings / mountpoints for external storage.
> 
> But I have to admit, it brings additional complexity and if we decide against
> such generic approach I am also fine with that!
> 

Should we simply revert patch 1 until it is clear if we still need it
(in a different form then)?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

