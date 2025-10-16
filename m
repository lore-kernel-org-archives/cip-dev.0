Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C58CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 15:58:58 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.15])
 by mx.groups.io with SMTP id smtpd.web11.1086.1760630333904280116
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 08:58:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=l083TTAN;
 spf=pass (domain: siemens.com, ip: 52.101.84.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVO5gesMIGRzUAQP+fUIzscqOuZxNUOujYsyMclfuCq3KR64lKxeYwToDj4pU/s9F71/ODlzO0zhFKFCd6AvfnPpqZsVfxYWDLx+oSw8aBQE4DBhHOUvh12jzXtvNQBlBbvfKew7fNSIoJc7EAMyJGGcQPm/az0waoBuWzowbchkaJmUNtD0YFdJBZDQqj8J6VxjR4/rMiIAQbFG0D4qyepgOWivTi0B3Izeqm5IgY8Dzw94Aan58MRev3/Ws3DswxyGPnym8ZNe73N0b8er2qHsYB36bTUUOPsV2Nr00AmxZgEq5QKmZLiRhSKGyL9MOT0Ao10y/QCANNCo7XlcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdkbrxtSAe5iLxejxn6Lk+Uau81dqo0lH1dkMoVB0es=;
 b=yIrgqerinw8DeoxiqHm+Z9PB16waW8zpIzebQInmHtJK3D/lkryBIjNDNJ52Xly1ONv/asx4hYnM6gnkn87VCR83CbqqoyTPdF2ok7Xo+KdqzbbXHR9i7CVIynxhZbXe9R3xkpnbQzPnbh4RQ7qUzeRvpIPrA+5vRKZnGkDM2D3SkXdcbiCVU3KzAvrlgJi/rAsAWtrSZbsUOxUB2t4ZiaP2Y2Zi0SlY+DoRNh00hUyDVuKs4NGkBp4CMAPz6BG3AUBdy9rOuTEkEgZ61mrGPE60piQbqL1Nw9U+6fzG2ATz+DfJBDcUp56O7QfptnG9YeYVIfpgTySQogNgIKh/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdkbrxtSAe5iLxejxn6Lk+Uau81dqo0lH1dkMoVB0es=;
 b=l083TTANeMaKcI48ap6VZ6yDS4ZRdSYya5AgFiBjWkJxA29ZPtJSaunJYDqYPAANnObvP7681do2Z3icaStXfqTiyiOR/mzXC8ZVz6MlmAW9akcOyZtYi1Cea7MV+iJPh2W1I5E5bbl6HO0kKmg4DgsWYXRjGOZMqQEPeTrsfINCVrSGc1Lw0V45GLJbZaAfqLWdd+/6AJNaayl2ShIhmrE6d06fJ6WZaWTJT7ERfB5+g4K/4tQPtfp+d12gQ0NyAN/v6CBD32bG3QRcIAVodrj/y/3uLa0jJihYyKRrrUBC5dc92T1JmqK6CuuziO8AzqYh1NighYjLvLgo8aQapw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Thu, 16 Oct
 2025 15:58:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 15:58:50 +0000
Message-ID: <cd3ee231-1b18-4a06-8f61-cc3fcbb5103b@siemens.com>
Date: Thu, 16 Oct 2025 17:58:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] image-tools-extension: Limit IMAGER_BUILD_DEPS to
 do_image_tools task
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "isar-users@googlegroups.com" <isar-users@googlegroups.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Schmidt, Adriaan (FT RPD CED EDC-DE)" <adriaan.schmidt@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <143fcb5c-c8bb-4292-8cf8-760fa366020f@siemens.com>
 <336625dcdad7e66cd9798300b845cfac336b5a8d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <336625dcdad7e66cd9798300b845cfac336b5a8d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 848e2e30-139c-45c4-cd10-08de0ccce5e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEVKZGxYSktNbEVHcW9yeE5FSFBhYkhnMTBzWnl2TW15SnpyaFkzQ01HQWtM?=
 =?utf-8?B?cU50TzFJNGgwVmFTcTljNGJ0clppSUkwSkRDTHZ2bHIrM0pFQWQxVDVKK0dS?=
 =?utf-8?B?dDlkS1dRc3lxdDhhdEtJczFKcGlJVXpHM2JQdkJFSnlMNmJhbGlma015czlY?=
 =?utf-8?B?QnROTGpuMm85RDRpZjU1M1g1c2N1MzBZRnFIU2pEMjVIYnE4bFl6UTdnOUQ2?=
 =?utf-8?B?RlA0bTZMQlJIREJHVG1LMFJxVHBBQkdjdXgxNzZWNlQ2Qi9TanI0U1lsWWdM?=
 =?utf-8?B?UWVWR0RkdmVsWVErNmpPZFAyeVlPZ1E1RkRIanlEMUV5Yk45YmdwVjNiSGRX?=
 =?utf-8?B?RmFsb3FRL0ljS3l6Tkd1V3FrZHRjSmUrNXExK29OVGp4cXZwU3A2MklqSGR0?=
 =?utf-8?B?TFVMc1dlRDA3cXNYSllXcWxaUTl4cThuSVRZUFhnOFRDK0RWNDZQTENqc3hr?=
 =?utf-8?B?L0tvb0drZjhsaXRkNmFPclV4bVhqcVJCRkpzRXdiZFpUVUFnckRpRGxybTlJ?=
 =?utf-8?B?eTltNm5IYUFLQXU2UTZJMGM0Y1NpcHo0LzZWTnlHL2N1aXcyZ2x2OUkxbzhp?=
 =?utf-8?B?enNLeXFOOEo4b0R3dUxrK1l2UnJuWkxMb2M5TXFPS3dtbVNUSktrMDRBLzYx?=
 =?utf-8?B?WmRSZ1BNQko2QVFDR0NnL0pVaU5hUjZxaEE0SW1FWkQ2TlFMOVZlOUFJcERI?=
 =?utf-8?B?SGREZkRJS3Q1WHppdUxYdzk2dmFPVXVWVTJ5QzBsZ0ZjOVpSa0RhMVpJQkk4?=
 =?utf-8?B?ZGlCd1NVUTk1MDNRQnlrajROT2kya1k5cElnYzhNSnRaVnVlUUsrRVR0aXd5?=
 =?utf-8?B?aDQyR2N3RjlsT3k5Rzd6ZDdHOGFkYXN0OUpPeEdjVzAxT3B1Tk9FaGhLdWVR?=
 =?utf-8?B?WHVWMWd6K1hvVEx6V09rb2htbm5mU09Md28zaFBSRlJOZFNnemVlNFFPTXE3?=
 =?utf-8?B?dUQ4Z2oxU1hqYkdtckxoaTR0VStIU08yd2hNZEh5cnlPcXB4QTJWVVE4MXVr?=
 =?utf-8?B?TU50Zmd5TDZNVVpHeXdzYUVKWTBHUXAyY2k1V1VBakUzTXFYZE5aNmk0K0Nl?=
 =?utf-8?B?eTRQYld6ZWRGM3V5aC9NUWVFaytaRjk0QzNhM2JsYndMT091cGxmMlFjdVdT?=
 =?utf-8?B?ckY3emc1R3kxZTR5M0U1cEtoSVBCTTNHeFBsaFpXZWFpR1lmZTVob3JCclRO?=
 =?utf-8?B?ZzRXODBuZVhxL0NDQnpTTGplMXV1OTVoUUZZR2tuU3pQMi9OQXYyL1pZNW5z?=
 =?utf-8?B?eU1kUm9wRlBOZW1vNitha2EybzhxbnQxeHlnUzRyRFJVUlJJdjFYZlFOZllW?=
 =?utf-8?B?Y3BpRGhhL21yT1Z5WFVZOHJLWXU3eTdPTGNOVCsxdWxpa1RBZDRtdmpXVW9j?=
 =?utf-8?B?RUtNeEV2QlVuN0dIS2hscTVBWFN6Q0p1WE5pRURQQWJSSUw2dVlkOHJtRjVa?=
 =?utf-8?B?OTMwU2p6UC9kMWNrTjM4MWxMRlJKckVudXE0STRIcFlHS3Q4WkRiTGV1c0tV?=
 =?utf-8?B?UXBsaXZTR0VvOVhIbWs5QVBGOTAyS0pVSFRnUnNIa2k2RmpzVmFqL3RKUkEz?=
 =?utf-8?B?NVNtUWZuWlFwVGVhaysrblJSam1VMC9ibE5BZkZkTmtpdlVCYnkvSmVlcEtX?=
 =?utf-8?B?cVB3M0p5MUh6R1d5STRwREh4M1dtQjA1aTdGcFROYWRyNURQV3RTOS83eG54?=
 =?utf-8?B?RXBLQUFNYnQxZEVnRDdlR2llSDlCdXgreUJaVFJmSG1Obkc0Mzk1QWhnSHhK?=
 =?utf-8?B?R0pmOFFUTDI4dkJOU2FEUEpkWnEyUjdTMG9saStlRXMwK3RHQjRVQTUvSlN2?=
 =?utf-8?B?K0NHay9ZTEU3cGpPNnN0WDdSTWRkVWtNQ2JFMEpkeUJ5U1hpR2U3d2s4REU1?=
 =?utf-8?B?UzNSaGZyamNOYk1aZE1qL2lLa0d3bGhuS2lmRDRXZ25xbEl4MllWdTQwd3lL?=
 =?utf-8?Q?ZYDUAOp5Ce3dNVozsNmw1TGXSXhJyfnB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czR0U1JRWDhBRkpEWThHdDZpU0krOHRYcWk2QkhQNmlKTzNzV3FXeWZxdFdr?=
 =?utf-8?B?eDVBOTNGOE9tT1YrN0M4V3ZxRlZPbmZLbDBlSC83OHNoSzZ1ODJadVd6NCty?=
 =?utf-8?B?MjVqMzRSa0tIa3h5TkZ6cnFGOU5qVGYyUklmYUdjc0l6L05JdndEeFEzakc3?=
 =?utf-8?B?eVh0My9OUTJzbDZiL0hrWitxYXE2WjVnQjV2SlRLWHdnVytnRE0rZWhoL1RS?=
 =?utf-8?B?SVd6NWNCSW1aalREYnFJL0tSN0d4VTJCTW1VL3U4eTRmb3BhUWR3Y2ZPYzkr?=
 =?utf-8?B?dEI1SkNJZE5JdTQ3K0FHdzBmVDRpdEF2VGI4K1BIZTN6U25TaXhocVJTQmpi?=
 =?utf-8?B?SE9aVjVsTysrM0ZpcnJ2MFdrbDZ5cWEwSXhlM3YyZytUVElEbC8xTGtwOXBQ?=
 =?utf-8?B?d2w5T0ttNURlek51VUlKQVlSdTJZQUJIdDNGa1lFQ3lxSEtpTVc1M1U5dDdE?=
 =?utf-8?B?ZzZMMjJCUmQ3cnptamZQcktSK254aFJxS0ZwdTZ4QmNhLy8xZDhabkdhclk1?=
 =?utf-8?B?TWEvaDg0Z0xvSEp1NWZqQVhCVkFrL3lQeEE5bHdQaTJFVS9lTUVUVGJva0hY?=
 =?utf-8?B?MVIyZUtJY3NOZzZ5L0tjckJod2p1NnBPSmY0Mlg0Yi9RbDFLa2FBN1VXa0tQ?=
 =?utf-8?B?MHFCMmRuNmNIV1hVMEpUZW01b1p4aEJmc1lTRDZsZEtDWXVKblk2SFhDSjFw?=
 =?utf-8?B?QStHQ0hEbmlkc2c4NkdsaVdWSlRVc0JrS1VCeUxlMkxEeTluUndhQ3lnNDAx?=
 =?utf-8?B?ZUhxalNCL3ZTbDJSM1lLVFhNVGFFWXoyU2laMUkvNjRoTzZzb1UzMGcrYlFj?=
 =?utf-8?B?YzZnakc4bFllQUQ5MjVVQ0FqL0h0RS9IczVudjBwcEVlUmJuQTJ4S2VIWjZT?=
 =?utf-8?B?QktKOUNjSng2SFVrY3ZlcFhMRjR6OFU4UG8wT0dXeXBaK1NudzZGVE80NG9a?=
 =?utf-8?B?ekhvUjJ1cWpZVVo3OTl2ekFHYWF6NFNDVlBPOXlNU0FKK0p4ck9JbW02MDBC?=
 =?utf-8?B?UXIxZ0p3S1VDak80VUs2cEVHa3dyWHc2Tk01Tk5xR0w0cWUrNkFVNU5DNGcz?=
 =?utf-8?B?WXMxTHU1d1dUWHRhK0NwWm5jeFJvR0RXdzgrS01RNnJkcFRZMWtESjFHSUV6?=
 =?utf-8?B?YzhIU09lTjVlcnM4VmlKc0lhWHdDODF1cXVaT3hMbmE2azZjbHhlendST1hX?=
 =?utf-8?B?OCtpZWVWdll4cjhxbElKbXdGNGV3K0wzU2ZzKzdwMkJteVE5T01WNlpLUnRO?=
 =?utf-8?B?Y0xoVVZSTHlsZXcrVUpWYXc1S0lDU3IyOVoyVytSdFI2dzNMd3psNy9yQ3BS?=
 =?utf-8?B?U0daejR0cGRreUZWeVAzRCs0S0h4MFFrQVBiaVl4RGVBQkh5Mk5pWDJncWc4?=
 =?utf-8?B?ZTUwdHI5a1hpQ3ZUeW92VW83ZmhhWjVJUS9PRFdNUm5WTkxmeTFNK3ZESEtN?=
 =?utf-8?B?RWJqY0RqdjBVM2NCenpVZFpHNlpGeEF1L3VWZW9oWWRoY1E5ajBCNkRTSlU5?=
 =?utf-8?B?UnFqTk1heThBUEM4U0krNWt3N0JNZlo3MmVNdytEWElpSUcvbWx6WDlaVjh0?=
 =?utf-8?B?amRFRVNpU3ZqQ0VDK25ZZXNLRmxSekV4SU5EWFlCWmdGY0h0Zk9wc0hxMVVm?=
 =?utf-8?B?K1E5eG85OUxTWUY1bzNYa0hvS1FkWllxcTNBSHUwY1p5aHhmTDZ6K1F3UVls?=
 =?utf-8?B?QktXaURGMVMvVnNsMXZOaDNweiszTkdlVVZFaVhDcjNXWjFvV0ZPWE9NcTRs?=
 =?utf-8?B?Q0xMZlU0akZVUk5xRWlaOGgvLzN3MHBsYWxQRmVwYncvcnNvaUVmZ3VJVTRM?=
 =?utf-8?B?MjBScUFtWWI4SmhiWDk2UjR0RjZBK1JpM3RSaStRRitUQlk5ZkQ5VlFxTnA2?=
 =?utf-8?B?OXVUMjlUcnNTRFVSS29tc0tEbXR3UXplc1p2bHFQc3FIUTBxSE9JN0UyU0h2?=
 =?utf-8?B?YVZ3R2IweXN1MDBmU3drak1kQkl0bkhLb3QrdHYvTGFURmlkSEpkbU9jZ083?=
 =?utf-8?B?UzdrekRPdko2NGJ0VlZMeEllZ3B2ZkVhakY0c2tMbHNwL2c4eEFZQ2d1Y0ZT?=
 =?utf-8?B?V2NQQ0tyVXdCTG9OMnlhRkpCVVhGdDNUb3hkOE95bGpNMnZydzNjbmsrRGY3?=
 =?utf-8?B?TVBBMFYycWZJNGJSZWdsYllJcnlsbnRYMGRjVTFHMlVBa0pKWWFWK2o0TGpx?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e2e30-139c-45c4-cd10-08de0ccce5e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:58:50.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZrAeJSFhd1bVWg1bSwrQMzNMaAsSSjtpGwxS0E9kA+95PWs/pCWkOZPH0x72asLVwj9rcThLWHsMxPN8f9TSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7725
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 15:58:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20191

On 16.10.25 16:41, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Sun, 2025-08-17 at 18:20 +0200, 'Jan Kiszka' via isar-users wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There is no reason to let the rootfs_install task wait for imager build
>> dependencies. This also avoid rebuilding the rootfs if only an imager
>> dependency was updated.
> 
> Hi, this patch breaks the swupdate (:swu) image type in isar-cip-core.
> 
> While I was not able to locate the root cause, I checked that the
> swupdate.inc correctly appends the needed dependencies to
> IMAGER_BUILD_DEPS:swu. Also, I saw that the packages never appear in
> do_image_tools[depends]. Where they get lost remains unclear.
> 
> To debug this, I recommend to just look at the dependency graph
> (bitbake -g cip-core-image, grep task-depends.dot "...").
> 

This happened to bite me today as well - only fair. I'm debugging it
right now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

