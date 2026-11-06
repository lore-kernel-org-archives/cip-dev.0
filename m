Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2026.1793954708355639112
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 00:45:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aQroGVlv;
 spf=pass (domain: siemens.com, ip: 52.101.72.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWTkjDXn5Tp4iO5X5az7kPYPWZbxCdLp7o8nK926enMu0hXp0BIdRJ0djkyRoHTYqqBONraQt63THlb/39qvRAENBbTjFPjejfCO72nZV/lZQY1+q/T4sfFiV+lye5uT/QzhBIns9ikdaCTb2vaL95B0h0crg8P3ELggX5BPviOU2XsSV1IknJZLCyo+qFavbeVoW/ojbsA3l/q8H0mdYd89UhnjuJ0W6gwcM19k84tqw6zc3bHWAM+C4I8b7xb2l9BDoazZ8Tsq4OuXju1mTiptwtcEeI9OyldQOGsStz5x346p+w+Q9HapKh17aZBrzg07vij3EO6xNBszzoHXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyiPtDE2eSIPpWHjsNxlwV9S/309f63vSfXHFx10J+s=;
 b=q/tCT5qWtJgs3GstRnmLgjfi6V2mraZx9CLBlhI9jDleQRCtbsonJqpSWCmkWWpAE55QKnDn/OqVTFr/guJyOmyiwETepmSlUtCsrle4PQElW2P1j3x4TSayIDSe/3nOLb6ccf6tMQD9MGtrgYI4OLCzICrgnPYyXXm8mEz9EdjDalR7Ef216GGnSO/YZDiel2coMga7dm5vj4sonfqJ5lAzxSE+wFtDnj9xQWinXXYphv0oCMKQJXi20rHLBlO5/jvBzTt4oW6HimzH+dYBB9F0pGkG1FTAeFWQoLEhG0Jhgr1Mj4+pn7skR6HFmCTuSf0Z4RHe33TGakKaTn8cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyiPtDE2eSIPpWHjsNxlwV9S/309f63vSfXHFx10J+s=;
 b=aQroGVlv2mb8uVkwkciozTinGtlv+QSYUWF5lQ5a3nkkCXZEQxZ7+bS3+D1k/IRlNyC1xv+wc6ujLASEu+sm1PB1RXQ/hrOOkE0k2E/91ypfHRGcZ9cfaOvd7eXdQknFFgxJXKPdE5tY2gxHZE6DuicopJk0Qx0YcfHlT+wqKTECcbZaGRnDYMn6WuVm2yzDkTqnbNiQGGRoBNsJzdHG3Zp5Jf2VWDDrq5DmAbkd8caxQa41GmRgXg3ZFcLBP/ElIBN++uM5GeidaeSpkkoXlaZv4jsXVui69REZ9j58cflBm2WQ0Ks6OHVVd+rANBsstJPNaRZtZvknk5RcoUaTrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5748.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:47f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 08:45:03 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Fri, 6 Nov 2026
 08:45:03 +0000
Message-ID: <3ff69438-414f-462f-816d-5c79dba37cc5@siemens.com>
Date: Fri, 6 Nov 2026 09:45:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot: Change the mirror URL to
 u-boot-project.org
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
References: <1793860204-10428-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <427d1f20-29a1-4772-81f0-35eadb4d7f81@siemens.com>
 <3013916d-0b1c-4976-87fd-1bd2c8414ce6@siemens.com>
 <TY7PR01MB14818EA78FCE275C31089389BCD762@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB14818EA78FCE275C31089389BCD762@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 04caf6c7-72ae-42df-e11c-08df3be23ff0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261022115727099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Lcqd7yU+I4OhO7xkkEmGCXbsfcBik/q1V/TWbmA58uUBbia0NOheJ0/23mh+i4gt5d1qFJM4rCO2VFRiRjuLDO02MCoM+PNZMhevWP/r0S9LQYisyDq0avCm3Uq4lMEYEHqZ7BetWtLhKpMDsDjIETh1cftgu4m58gSeagMPikWuu7TLMceAJWcPZHb9UaTfxNErUPDGWB6fGEO6p8d+dwNHfGtyPYp03rEivBpwfOqvt6H1y5LaqZ8m52maZgVkKVzL1rA3x29lH4SWO2mJuap1lWUq34R8yqAI9Jy6MJt+2456/duPCbUfe2gzjOnPrBiJH2A9kiYYI0fngkVQ7mH/P63d6fWNkRQ/Afgg11bbvC/9Rky0Sm53aZsD1JgdCfdnoFO52ldJalSp5sIYnPRhJWAFCMevJztgnYdAddcNoZCX7duFNbWhvcYcBf3W5odAPltjgkf942OQOlN0KTAk1oBbyH75S8AgY0a9pgXwWdBNEZtT7Rz7n+1zjmRzOZhXJ02eh3zbYB79CZjnNEd94lsl10u2nKtpxS2nVGwHjD6tUl9zEFyed7pNZCSIBbBXa3ZVFXMeGRZmFU0uQAl+yF2SVlxPn6t+aH0vI2WcUHF6s3UowdseGByz4bVxEZzOKwqA9ISS/MYQUaRkQrh0Zm4T/Ax6nxl1+fraYwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpEK1ozUFJkSmRPR0xCRmswT3M4eFJURE1SSVpoalhJR1ZoUVRKemxDcVJa?=
 =?utf-8?B?aDBvNXQ2MiszNzgwOWFUWExnRTlwN0JnTUNQWWhpUkNpVDlYYVJhRmhDUGo1?=
 =?utf-8?B?WXVId2xwTjkzR2tOczQrTXh4YzJDcjFkcFdwdFhDcWI3eC9rZ09pZ2E5NGZ5?=
 =?utf-8?B?WGRabmZ4YUg3b0d6cXhTelZ4b2Y3bDBxVW1SdEhYQVZOUE9xeWQ4Y2RxcUdt?=
 =?utf-8?B?Y3hKYUIwdzZST2lCdUJ0dHl0S2s1Y01Da1hEZ0hBUkVtd2lDMExNcmtrMWhW?=
 =?utf-8?B?M1ZxZjd0NFVYQjRLeHJMMmZUL0hDY1QzVEpHNnRGYjBXOXY5T1JzdmdUM0h2?=
 =?utf-8?B?bkd3eVlGbWFSR3Y1R2N2YjBFUjhyOU1vMG1QSkczWlNaOG5WaEtZa2dYYUJ3?=
 =?utf-8?B?R0VBMDVGR1pNOUdVTmlvQ1R1U3FrbkcrN09nL0RuRzNDU1lDcEVCa1JPV3Fx?=
 =?utf-8?B?a1l3ZEFRbEJkbzZEc1dNMjYrTkp3SExYdDZNaUFZWGYycnJBYXJBazk1SGMr?=
 =?utf-8?B?ZERacEVQZm5VTVp6L0hlUHdJSldmaGl0Mko4eTlURi91Ujh5NnQxZjVNSmVq?=
 =?utf-8?B?S2pBK0tsY1cxdDdHM0xFWTFZUUw1R3FMVjJnZmtiN1JMZ3UvWmwrdER0ZStz?=
 =?utf-8?B?elhlK2dBSmhvSTJuOWxHaFRoNEpXejExL0s2WmNvcGdJb1c4WjFFN2xMM2ZZ?=
 =?utf-8?B?MmxBNmZLSlhwcHFTb2JGMnl3aTIvUkg4bmQwQjg1YmxPRU9GSHBYZ1hSN0FT?=
 =?utf-8?B?SG9GT1RrbHpBWTQxdUxGNlY4cXA1V3BYc1h5WVYyNG1VU3JkbXhCUkZHQ2pY?=
 =?utf-8?B?ZXJ4c1J4Y252QXZISlB2cFpOZzU4dzZDZk9Ia0tRZ2owcGNxWElsUU5kUEFW?=
 =?utf-8?B?KzRJSGp1dzd3KzB4RmwrMFlrMXAwMGZ1MngvYmVQOHBUOXlaTWhMZHY5empt?=
 =?utf-8?B?Y25wdW1MTFRxV1pMTUVUMDhNbDFWdVpWUElDNVZtUDF4cm5aTGE1REFGUTVH?=
 =?utf-8?B?blZVZUtENmF2RzJDSnNidys2eHlkOXF4YXBPRHlOeEpCVkhWbDNaM2FmTlJJ?=
 =?utf-8?B?S3NoK0xWb1k5TjJ3cGhGUUs1Z083Q0hkeDRuN0pWclo1VGxSK2tpV3ZjeTUz?=
 =?utf-8?B?WVJsdEJXemJ3VmlSeXo0QWphcG5sR1pFN2JjeVFEWENjWjA5ck9ITDRGYTRl?=
 =?utf-8?B?TVRaZW9rM1lpd2xianV2K2lUMWRQN1N5ampWV3plZnJSS1FVVk9JZFRhY3BL?=
 =?utf-8?B?L2x2MmNlVXBjT1p0eUNmTXV3c1JyTTgrVEVocU56V1pkYkUwUlBIMUcvc1ZV?=
 =?utf-8?B?OUJuT2pJdU0rV3JsZGozSFVlQUIxYkFyRytwdjc2amg0cUtSV2prOWpUREdz?=
 =?utf-8?B?RnN6WUppYlFHSm9NVFlQcUlGQituZXA4NkM2RncrMmc1ZjF4bnlRNWhRelhB?=
 =?utf-8?B?QzYvaWtCZjh0RkpnUzhYWnJha1grbW9McHlVMDFpSzQwTXYvVHdBSHZYaFkx?=
 =?utf-8?B?VjRKdFdnVWxRZmI0bjRwc3JKcHRTK0gxY3YyMkNHK1krczMvdm9rL2EzS0Z3?=
 =?utf-8?B?eDI3NTZRZmJ4S2x2Ly9GektBT2x4R0NpMUxkUytpSFg4RFNOV3FYUXFhNmZr?=
 =?utf-8?B?N0VaSkV0MnVtczN4ZjlHb2V6eFlVbXRVdk9lNTlTdWw1aGNVQkVpTSt3TVUy?=
 =?utf-8?B?NWo5MnBIUWFNVk0yS3FyQks4bzJCSWF4cW9HcmZKT2VNSlBDSS9NUVNERHBi?=
 =?utf-8?B?MUFjemlUWmM2QS81dFJDWHY4dU1mUHA3ZDFvbzNySUwyNnFkOHR4azBRSytG?=
 =?utf-8?B?a3FuZ3JsNkR2RVJSd3VCY2FjMlp5MmpCallLNFg0ZEJOMDdMbFpIZ1Rab2JS?=
 =?utf-8?B?bjZCM2d5aGNKUjNHRzZxcGdLVEFzZVNaUE1HaDN5T045V2NlV08wbkoxVkxN?=
 =?utf-8?B?UkhYczYvcWgrOStWaVNjQ0U0eHdlSWtuSW5mSyt1Y0ZwRUxPUWE0c2NubU5q?=
 =?utf-8?B?SGlaaElrZWRNcVh4cHZvK2FIU3ROWWhhTjc5RDlzSldSQUxEUDV5b2Qzam5i?=
 =?utf-8?B?QVdTZnlBUHZGeFZXUFVwUGZkR0hIa3FXamRQcEdQOHpUZXdUVDIvTW9MVUtC?=
 =?utf-8?B?SDZSbWJBQkRQQmpUbXVtcnRWck5acVlvMW52cGtOM2I2OWZ4YU9wenBEdFRa?=
 =?utf-8?B?aEMvVUMxbnN2L1hhdTd6c2xyQVZYYzk4UXhzdzZSRnRydTB4SlhwMXhCVTRT?=
 =?utf-8?B?TnJERW9XQ1hUbTNiQTNSUWIwU1JWREpJUlVLaWVKeU9wbmNlR1BGVFR4bkxC?=
 =?utf-8?B?ZUJpMEZQdjFhc3B3bngwc2VJeWJJOEswVmdnWUVMU216UXVMUjlzdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04caf6c7-72ae-42df-e11c-08df3be23ff0
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 08:45:03.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pvd+01GJySvYPBbtyayPruAsPd0zsCHNUmQBY02JYpWkciSf/5z1SdR46IjFcqhgOMBFDUNYfTtxpEcW58SgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5748
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 08:45:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24655

On 06.11.26 02:21, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi Jan,
> 
>>>
>>> Thanks, applied.
>>>
>>
>> I additionally had to drop the out-of-sync and actually redundant S assigning in
>> u-boot-ti-am62px-sk_2026.01.bb. Now it should build.
>>
> 
> I also noticed that later and was about to fix it. Thanks.
> 
> BTW de0's u-boot build fails in the Debian 10 (buster) environment.

Probably the same issue with bbb as well.

> This is because U-Boot doesn't support older GCC versions. I think it's
> necessary to have rules like not upgrading the overall U-Boot version and
> fixing it for each OS version. 
> 
> Do you have any thoughts on this?

Hmm. None of these boards are prepared to test full images in our labs.
We could fix their boot by providing less or unpatched older u-boot
versions. However, that would mean manual testing. I'm almost inclined
to drop them from buster builds.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
