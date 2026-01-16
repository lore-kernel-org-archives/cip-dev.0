Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1553D489A8
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 13:49:06 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6258.1768571344777226039
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 05:49:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rHHakD7/;
 spf=pass (domain: siemens.com, ip: 52.101.66.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxCESHh91+aMbOqFdOCRNw+aJ7e+Afyrl58U7R7fN69KNQbkhap2cFjZCxKndsXIwxFcL2KXs3Aw07kWfU/X1xLXg2jLaiXMffSASwMrVkpBrgA07050B+XYoh2LlE8PEyd9nfGpMLstBr+js3YToWBVXvuyvUcs+lqigPsyBFu4ydSL3eNi78+BGylBWnJT5CU78hzDgEoqffSEW8UyHm4RtmdxwB0kyl5ciMFo4TRnAjk/suGZ1wHsz5VIaBMFX7Fb/ZTuFrei9Gcj/b/hfQcGxpEHVVyM0uRRHfsWts+G6JBrJD55izA4LTaRO5JjH0pc7ArFNUMSG+9ZXl8Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMyR2tmiyvzIizTc6QjVygqTm8GQ4BBzCRFvs9caQys=;
 b=XOi1b/WooYDcGq854W1f4djfnD4VyPy/GIVkWBNPr64q4+Zs0ezd8FgP2x8FeEUs60qIcri26wOAadw4THVs+zrIfWyXc0MhMOtLxDZ3Q86q/VYdz0Ol2kHHKab5raZ3DWYiZGLXYnLTgoVoFmJqm3gRwv2JuDXjOBr85HqTy5vFPhvZPawblc5AOom3PHw/ZkNVXvgc/u+GOlmMGymVSpM3c18eHT+rIS6Os6/mm1cerK9y0aailOA5VDO5rEufhlH/TA+hmuF9zkYoy3dL3/3zAG9D6UgADj5JFn5z5FHZim9HHAJrqx47rREg/vx30GhCnq6/YeojBJB6QzeHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMyR2tmiyvzIizTc6QjVygqTm8GQ4BBzCRFvs9caQys=;
 b=rHHakD7/Yv2Ya4gdXVUl7CFUJ+iAr3rm4jGvjQg7c8TaMv6wbDV56hdMAnQihHwmw8nyxzG2bAVJS/PcAJb5L6GOcD2W+gnrMGs3unrYNNeLoK0lxE1EZFlpfA3GYqNdfmAjMWg90ieweB+rN9tdKHHqLgn//yhxUrPc/Szj9O5RzLPYBStVa6fKCOzV6POmwcuFWFvfBroD/WEnglPA9uPJsXirf0139MWYR5eSO+fv4D4ykgLMwzHC/5Y5LF0KnWz5VaeLZvu0kz4ryMP7kWQoh9i9JGCRmAm/Hs8kW5JYeJrN/XW97wRvNpQOoT74D5Xufzj0RiyNMxnHavobSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB9PR10MB5353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 13:49:01 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 13:49:01 +0000
Message-ID: <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
Date: Fri, 16 Jan 2026 14:49:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
To: cip-dev@lists.cip-project.org
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::20) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB9PR10MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c7f47e-5826-4539-f22b-08de55060102
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDd0YWg3dmlVZFIvbENzRVFxZFpoc3dGblErY1NNT1I2L0xTa1docXJReEN1?=
 =?utf-8?B?b2lwZCtJcGh4MG5UTjlXa08zd1QvNmVPUkhKQjZJV0xxZ1pKN2prZk9RVHFR?=
 =?utf-8?B?YUxyUnJ1VDl5cXFFOTROUDRBL0pmRko3d2d2UTlsWUtjaTB0aDBER0d6TWNu?=
 =?utf-8?B?eEx1MTJhSVJtUnA5dXpGM1drRjZxaVl4TW5MbHFLbWlvY3RyZFAxWTY3dGll?=
 =?utf-8?B?RzMxNENTQUZsd20yRi96ejc4c2lKVVA3UDFZTHZhYVhOMnhLZHlJLy8xR0ZU?=
 =?utf-8?B?M1Z1UlkvL3pHNDYvaDZtbGo4YWplRDg5cHlDcm5kZ0JIM2VESlp4OG9sNWFI?=
 =?utf-8?B?VldHSlB0YlhmRDJ0VVNFeEFtQUR3aStLL1VoR0J2Z1p0VnQ0VHIxcERqejFB?=
 =?utf-8?B?UVo0b3JOQmlMTURra2xUUEhvYUxTWkR6RU9YdzBRcHd5cUJvc3p4U3ljK2w5?=
 =?utf-8?B?SjJoaWpnNDliaW9FSDVocktPaTc0VWxLL1owT3F5Lzd1ZVEzREhLMUk2VUxT?=
 =?utf-8?B?cHFpZlptcWR5aEV4ZG9YT1dFd1k2ZkFyOWxDbS9IbUtTbUViVGtwRmg3dnhm?=
 =?utf-8?B?VCszYVROaU5ET0dhYkpvYnlTRzNLWjlQRGFlK0Q2UUFDU2FZVlNDM1o1MkZ1?=
 =?utf-8?B?Z1BJTmVrRTMwWkZ4SkxtYXVaZE1ONXNYS1lhUFdCeDNZdDYydXFCcDg1VlRp?=
 =?utf-8?B?SDlwd3RjVU5CYXFZUWxHaTUzajczVEw3b2FTTnh1T1U1eXVUczdZOU1rbk5n?=
 =?utf-8?B?S2lGN0RqUXZOUUlZUnlYaEVqVVRoTUMxUk1RVm1NZkViNFJ3S0tBeXhQcWgr?=
 =?utf-8?B?bnBrMmY0bldkdTh4SjREWS9ZUEN0eC82UUUva0dMNENSN2YrQ05SeTlicEdt?=
 =?utf-8?B?d3JIZTNTaTkyV0RyQVkvTFpwVlpkZE9aQWUrYnFRbzZtS0F1YjVqbHR1VkVz?=
 =?utf-8?B?NW1NLzVhZ1pWTkRQZVJRVGRRNWw0RXhYVWZlU2p3d2FiZG1nSHZmNG5sc1Z6?=
 =?utf-8?B?cnZlanFkblRBaGJWTXlxcDEweXpkYUZabHY5czhDRTF4Vlg1MnNScnRMUFJz?=
 =?utf-8?B?bVorTE0xbkVHM0h3NHlXVVE1SlowMmJyQVRZV1ZvcWNxYnRHOEhSaWovV09n?=
 =?utf-8?B?MDZuVk5TTzFsRFAya2UwL3IvakIyQ3BLcUxtcWRVMTVBNi9uaVZDOU9qbmpI?=
 =?utf-8?B?L1ZXRFBCM1lXSWxPaG5wanByWWRKb0xtYTBpNUNDeDZzcVhmamdoR0srS3Fp?=
 =?utf-8?B?dFIyUktROWtFT2VoLzlPekMybVhqS3E3ZGdpc0FKaDdHL2RvMldNWFV2dXZ6?=
 =?utf-8?B?Vm1CRmZDTm1BTGtQa2haeVdLTDRpaUpaTDNIZllRTGptVUJQUkVkVGZFSjhC?=
 =?utf-8?B?SGRGaW9jRVp1eFFrbTZQNzJWSVc1NXh1UGtDVCtSOVBNb1d2RzVsaE1XbmIv?=
 =?utf-8?B?VkNmYUFQUFVvY0FTNU13Rjd6MVBQMEs1a084a0lkRzlQeWVoaE5SR0I1ZUJG?=
 =?utf-8?B?dkpsNzRMTU0vWFhsRnpKMDcwUklIVStBbHEwdjFLTGp1MFhqN1IzNGdUTWFu?=
 =?utf-8?B?bzh3Y0FTVldEY041L2NGbVZhcWxUVitDc2UwRXZYb1FKVkV4RzlSVzlrbWh0?=
 =?utf-8?B?MmRTc1Vsa3U3aE1zdVJxTkpWWGlRQ3FIZHBvMWRGc2ZIbExXK0VqSnRXcmlT?=
 =?utf-8?B?NEJZRzM3anJEV2t0T1dTTFRHNHNBU2FpdndleFdFbFVmWnVOc084dTNVaUx0?=
 =?utf-8?B?bkk5THlZR2VOcU9QcWNKdXc0RGlwaEx0TzRTc2NJRGFIWUdKbnRZbWIyandT?=
 =?utf-8?B?QkJFSXk3ODdLZWdPNkRBSWVoMHBQZkwzbFprbGt0dlRjU2ZMMWE1bUk2Tyta?=
 =?utf-8?B?MDMzZnpBM1hCMXgzUDRxYVBIMjJFcVpSbkFEWURUZURxU21ZaGd5NUg3RkFo?=
 =?utf-8?B?WDdpbmtHWkZIdS9LMWhaRVQ3WlEyVGNoUHZFNEVvQU1tbEN5LzMwd1dReU15?=
 =?utf-8?B?eDdQSTRDWE82YTYwMkVaa2pPVGo3bVlRc21KQzN4OHhzbENUbnA0NTRIb2Yr?=
 =?utf-8?B?QVhGZHVCTHh5K1NETk80YjhxcUZQUXZiTTg1WW9KMW95TTJQVkMyQzhhWUxp?=
 =?utf-8?Q?tXm0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UEhSRHdUdjljZTVHcDJ2eVQ4RkVwMWt1bzNSWkZwWm95RVhnMThpTk1kWS9B?=
 =?utf-8?B?OUdFQUN6c1daYThnQkdhaktyQndLTTFmUERiWjY4YWt0NFpSK2t0WU52OTR1?=
 =?utf-8?B?L0duYWpQNWJXQzJqT3dnYmVWcVp1Ui9tejJ6eEg2TTduSG91SmlpNjRReDNl?=
 =?utf-8?B?UXl6THNUU2htbzhiZWJZTENKWFdUZHBSTE56MlozcEozRnBLVGdaOEN3ei9Z?=
 =?utf-8?B?OHB3YzJtdk5SM2hHY3QrZFVhWndhNW9mTkJkVlhUU3FGZ2k5amZTVGE0aVJT?=
 =?utf-8?B?VkpEeTZqVXZ6d09qZk81Lzg5bTVPRVNwVDZhOHFTbWNOWWFnOW5YYVlRaWtE?=
 =?utf-8?B?Zk04MENoZDJxOTRRRE1zT3YvV3g2Zmd0aytmSDBxUjlBdzVJSlVsWXFha2RF?=
 =?utf-8?B?dmh4VGROeU56clJDZ2lIQmJBSnZuWmtvVnJWYTQ4VmdOT1J0U28vRjlObzJI?=
 =?utf-8?B?ZVgyUngxTDFISnNTNXJMaVlZUnFoOFNJdnRYVjJLcE0vUFd0RjNXUVdKQVQ0?=
 =?utf-8?B?Vk0rT2h2dkx2QnNVK3EyVDhCUG5sL2RybGVZTm5Yckx1Zi9XWFJsRHBTcy9F?=
 =?utf-8?B?L2tiMXdNNStxQ20rNlVMb3B5eUs2MnNzWldzMGVCS0NYSytncldRbEJsbW45?=
 =?utf-8?B?SmtsZms0YWhQUFQrMnBWMWJxczFDVEhUTUR0VFVzUExqMUZWVTBCS2wvVG9w?=
 =?utf-8?B?RVg0MVZmRUF2Z094TUNScldpQ1V0OTdPVGxDTTZ3T2M5SlUwSnRrbmQ1Tlpi?=
 =?utf-8?B?TENxc091SE1oNmxaRURNaHhlbWlkdEh3UkJxWk1RZTdkTWwvNU1MaWlIdlIy?=
 =?utf-8?B?TmlyaDYyTUQ3a1N2dXJOWFZZNEp1aGVmaHhHTG1rSk1jYXdxM1JZWFZ1aXh1?=
 =?utf-8?B?S21DNGwwQnN5QlBpaFRhVzA1ZWVlSExGQmZudVZ2NTZ1azl0cnJWOU5SYnRm?=
 =?utf-8?B?emZaL0RoTmVaRHBybEpma3V4dzBiVVdZdSt6cTNUTWZ6QVZ1QXhXNU5BT1hR?=
 =?utf-8?B?R0ROcDVBbVV3T3JId3J4VmhxNUZtcGZrTSt5czlONEV3QTcxK0xvSThsdmgw?=
 =?utf-8?B?Q2ZVZEVJQXZNTUdieTNUZGlXT1dhMlRlL1pVa1cvU3hZTjZPU3lyRVgwUXcy?=
 =?utf-8?B?RjBzV01pR0FPeDJXQml3eGJhUnh6WE53SlVEbk02MVQ2R09JOTlNRVRQMm5V?=
 =?utf-8?B?M21yY3JhdFJWNWtzblB1Q2xrdzl2bDBjQVpBbG5WdlJQY2FPeVNnazI1RlZB?=
 =?utf-8?B?YlVVV00zWlVxT0JiZVVQVkwyVGplcExBOUhyTDBrOEhtYVdLQldSa1JwSlBW?=
 =?utf-8?B?T2hVVCtOZnJ5aEYzRmZzdzRVbC91TW5XVnNDNFlkcC9PazU3T25Bc205cnk4?=
 =?utf-8?B?M0Rpd1hwelZqdlBUQVFrZnd3S2M4SW9UdmFxdThuZkVycnJNS3pLZCt6cldm?=
 =?utf-8?B?ZXZ4VVBVWVQ1OFFTM292NmJqREp5OU1OV09yaWw4Vk9lOWR5amp1aUJ6b2dh?=
 =?utf-8?B?dzREWlRLSHY3VGJrcXcrUnpEbitmY0NVcXhKL3Y5Si9mRHlmVWptS2E3NVQ1?=
 =?utf-8?B?cjdUWTViSkxkU1VsZ1FFYU92RkgyeDZwTUdBZmZrRzBpNjRYNm1HYnVoaUZS?=
 =?utf-8?B?SVBEd0ZQMHo3WlpiZ0pLdEx0OGt4MDAwTFRza2NRMHlNZnI4bVFjbmNIaTRF?=
 =?utf-8?B?NnBjOWh5RTZVaWdCZVNTZDc5Q1FRM3NIc0x5aEhHd2hzMC9uNkYrUFhuSkZt?=
 =?utf-8?B?MThnbjFNN0VJektUdTBUai9JWFJudFdNNzZvb3FTVVRjcHZVdndteGpIRkg4?=
 =?utf-8?B?L0tWOWo0OTRUUG1SRXU3R0dDS3NMNXlFcUdRZitzeFNDMTRvK2l0NE5iSWFO?=
 =?utf-8?B?UnZmdk9pZENxeDhMcGY2eUpTZjRuRTI4aElaVzVJb3d1YmZ1cG1VZ3N6amwz?=
 =?utf-8?B?WXkxeGVxRGZpZFNFeFc3RWxvZy9WV202cEovQW8zc1BybkFYNkc0U1lWTXdL?=
 =?utf-8?B?VkQ3c3JFSGZpalRsbm01SndsNVRVcTduQXRUU2JzQmpjRFpoS2tHZ0hXTUdU?=
 =?utf-8?B?NWZGK1VKb0xmMTNoM0ZwVVZlNjBjL2huRitMRVBiOG1sTGlhV1ArbEJpRWh2?=
 =?utf-8?B?elIvS0tlakY3UDZ1U0hVUzZXR3UwYmZFRXQreDI5RTdnRUhsM29RQlovUysz?=
 =?utf-8?B?cVo0eGlKaTZNMWxBSUtJaTJlRUxpYXk1QUR2QVBQa0MxcDBzNUJxcjB2Nld0?=
 =?utf-8?B?QnZOVUtHWjVxYytlb2g5Yjg4T1ZkckNwbVFTeVZVQW1pbVZjaExYLzVubWw0?=
 =?utf-8?B?THViSHdVTFl4UjFPc3BpdkRSY2NUZG5zeDBHVyt3OFZLY3dRd0xiQ3hseEI5?=
 =?utf-8?Q?R0EiSWGgcaUDNFRo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c7f47e-5826-4539-f22b-08de55060102
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 13:49:00.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2hkHaFRgNeJxRYn+8hVoDg1PZjbwntM1EszZ1AJtFOkD83AlThWQrboqKfQ3ifeYX+xPZq70sUdMQw7CJoRarlOZLqM/vxd3ATyOu7Zh4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 13:49:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21639



On 1/16/26 12:49 PM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> WFX_URL can be set via the Kconfig menu. Enable wfx backend based updates
> if WFX_URL is set at build time.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   recipes-core/images/swupdate.inc | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 7cd816a..7041058 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -57,5 +57,9 @@ python() {
>   IMAGE_INSTALL:append = "${@' swupdate' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ''}"
>   IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')) else ' swupdate'}"
>   
> +# check for wfx url to enable support for wfx backend based updates
> +OVERRIDES .= "${@':wfx' if d.getVar("WFX_URL") else ''}"

Why the getVar pattern? In all other cases we set overrides with a file 
in kas/opt/.

Quirin

> +IMAGE_INSTALL:append:wfx = " swupdate-config-wfx"
> +
>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>   IMAGE_INSTALL += " swupdate-config"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21635): https://lists.cip-project.org/g/cip-dev/message/21635
> Mute This Topic: https://lists.cip-project.org/mt/117296113/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


