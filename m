Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB8DD2E00E
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 06:55:29 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.431.1764917726511238643
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 22:55:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UPjnQsit;
 spf=pass (domain: siemens.com, ip: 40.107.162.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLwPQONXWKQpmOvAk9zsZSzV95Ou91djoTNjloIO12pTOcFluSA99nZe5Ih/tHyV30Ozi7c8DRT2QyYdqw/KQ9hKhdGGwdcFNwHQ/C2077jIyTBHhu6B+m8JGK/mEeGHo9JovXxMqjHtJooU9dsOqybEmVaNLuilQHd94MhUhLsJ8+JnWUKLD/nvRcLWjhPRYDvbqsRIfyOKvHmRLXjkqsGkSFcDu1qsHlKqOOSqKOG+9YRhBATgHdb8ITE3cF7H/5G4jaivnlMAqqmPjboG1o50nszxKBP7yddY79umd29b0mJVy/y3ziWFiVmEjg3VrPWhNfwQ9dnCXCadCbzE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zczUvDZYy9uYJPM1Dspvs2Yu3q112bpgmdyVV+P6yo=;
 b=W01qzklhAU1gIqMTE87hac/AHrkQQHEeqSiZG9I3tBosYhVRSSApJJhDxVP8mIIDqH+jd7bSZ4pBASY7mpt5zNO+0FBs8jWMjH0AgDjkzSq9rEKRxaeTkyM7k1uvMyPvTOvjinpJ6vtjkH1g8ifgZWMlZH30s4TSJ9NOOviuj4OURQO65CCPSzv/4SzXuLBrH6XpiFLmsgO0oYDRvmt9ox8uCNXNREtDDbQLmecwaUlExA5OAi7FIgTTYU3J13mcRpe2qkvABxe/731IzMuE45e9bhrgHy4OhMZWq7epPbdhfF/PUqH2Q/DOap2DfoHxXHG36pCKHiDfsC07xe7mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zczUvDZYy9uYJPM1Dspvs2Yu3q112bpgmdyVV+P6yo=;
 b=UPjnQsitOTxLQ2C9z///q4uMKB0jT6KONi5Q3IxGxoyg57rzGiOXKY67OCDMj0YeuKWPJ+hYjM0VWvkLELoWT5wIy5OZC59hr7g7hZxRMOqPLJsSjUgick9E+9YnvP7IRT/7DYN7Cu7/Bp01YymAvauLW473BUX4k4mImokxhTYK0RuQup9SAbZfx/GxDgMM0HLyXzBIcdpSpLKsZsOsGuWVGOmes2x5Yp2A7yKZKLrsI7mFe57V3JbEe4RfhTSsO295ljAyZ8FDnXI6kGpHcR47j3Tm6vW8GRGx8xVTdR/xEMW2gSk+gLEgIem7Nb0ymYQbcHpoU3IirDHrXqcYCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:55:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 06:55:22 +0000
Message-ID: <74c6e6da-68ce-4eb7-9f41-5a587195b28f@siemens.com>
Date: Fri, 5 Dec 2025 07:55:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip105,
 4.19.325-cip126 and 6.12.59-cip14
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: b5102d14-e03d-4de8-99b0-08de33cb42c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dlNwNGkrQnhuN0NLektwVjg2M0J3TStxdjJ1Mk9ISmJISHM4NzRkZGlZYWd3?=
 =?utf-8?B?ZFJUa1ZZZ2NJdklzL1l0S0kxSlZXUlBDTWpTbVlrcVJyWkhSSG1IZW45Z2Nh?=
 =?utf-8?B?d0dvSE9jc04wTFFweDR6QkhvRjIyNU9HaVpyTHltdFJUd0VFSjNLc0ZMN2VO?=
 =?utf-8?B?dUpId1VZZFFzQnJubEtxQTBWeW1ETURHQUpLMmFaZndFNEgrTE9mcFV0cUUw?=
 =?utf-8?B?TXk5U3oyZE5WL0VxMDJhYjNuOHVVVmFHYmRicXJnb1VLb1hoU21CaDVPdWph?=
 =?utf-8?B?VUFPTXdpSEVXVytmV2NiMGpoRXpwL3NYa2hVbENrRXpOem5UMWdaM2hJS1Z3?=
 =?utf-8?B?UndCZ0VCcU1ocFRnaUQzNzM3QU16eE5JZW5tNEtMR3NBc2lNZEcyN3FJTjhH?=
 =?utf-8?B?cGRwM2tyUERQcDlQOWlEQll0d1hNZk4zeWZRTHdKNGtlZHdGSjlOS0NFQ3Vp?=
 =?utf-8?B?cHlLVWhQTlQ5K3ZCQ3h5cklEcGl1SDBTNEhuZVBZOG80NzBIdk9YNzVEcFRH?=
 =?utf-8?B?NDdFcnpUZVRBRFhKMHlxejJMR0RISVkxSS9YelRlR1JsUVdveFFHNURxdStH?=
 =?utf-8?B?eUNmL2t1UTErVHFpTnFIYUZ3a2VBMEtTQmJhaEJBRkNtV2NoVWw2dkZ5TGMv?=
 =?utf-8?B?WmUrN3RsWHZGRDBDVkZCQndOOXo4ZlhGeHBQazhRbEM5TFdpTHVRSzFJMnpx?=
 =?utf-8?B?c2ZrSGowTGd5alhHNW41b1ZYVzRzN0p6TzYvZEtVQVJQcWFtWWQyMnh3ZVZr?=
 =?utf-8?B?V1AzZHZNWk9hZldCN24xeEdKc3IxdUtWeVpJaGhxSDUyeDJvUmtPYVhpUHRU?=
 =?utf-8?B?d3NzT2lKTStTUWJsTlV6YUhKQ25CK204eXRHV1poblBDbFR2eFc3RlVibW9J?=
 =?utf-8?B?MjhSeS9ieE9pOVdhWnVhcjIzeTBqc3FScmxTVkZEd05CNEVSWTh5TkYrYXlR?=
 =?utf-8?B?a0xiS1hLUXk1bVJRSWpYT2RwVWp0TGZnNDZ6UW5LUkpqZlJYQVYxUnBYRnli?=
 =?utf-8?B?TkM1anZGYlpRSTZxTm56VFkzbm9XcXZDeUdpM2JXZU12VktVdGYycE1ETmsv?=
 =?utf-8?B?T1lhZHRyTkQyWTVqSmNBSTdJMDRXcGVNSTN5TktVZ25EQUNKdEdnUlJ5VTRJ?=
 =?utf-8?B?NHhoWlYveVp6UWltYzZyM2VJL1JTZEkzUDZLR0NBSnlvMENPTDRqV0RNWTRO?=
 =?utf-8?B?OVF3YmNZN0dLY0hBYk5sNXR2NTZkOHNsRUpISDFUR3VhN2lQekM0UUF2N0Jw?=
 =?utf-8?B?REhCY3pTd0M0QXArYS9HWmFwbndvb0RRZlFOc1JOamhPVFpuTkRMM2NQbk8x?=
 =?utf-8?B?R0lCOUxlWWhENGhqNkhtZjZFWXFLSkw4MkIxbW1HenZwVkh6QmJNeGZ2TnNy?=
 =?utf-8?B?YzJxSlU1eW5SbmtobmVDN2RMY2FNVTIrOGFzUnk2cHlhWEFqWU8vWUxCWHd2?=
 =?utf-8?B?ZEdBNGxZbHlNMTFCcTZTbTJBZyswTVhVRWJjZTRmbi9GSGZ1cGxoamJNQUhn?=
 =?utf-8?B?dEJyeWZmTU9jWnoyRlBWK1hHSDh6emFpVzZRWktFTUVMeHYwSHFDSGpTMGVx?=
 =?utf-8?B?L2Y3eDBMY3AzdDQyVUs1VGkyT3ErMXcrTi9lY1JBNGtBSUExdFJ4MG5xdkZ0?=
 =?utf-8?B?Q1NudGh2ZWt5Q2pzRjYzUElVSmhhaWlqOUpONmVLY1I2TElYMlVHVncwb254?=
 =?utf-8?B?OXNmQ1FWdEdNVmYxMHVtaGl4K0lYTXlBMTNpck15Nm5lODd3QUpTVDJUa1R6?=
 =?utf-8?B?T0NxM0pBNHhUSFJtb1BTOWk5Nm8yMWxwWXo5R3VrY0NOZEh1VDhMalNpT1Z1?=
 =?utf-8?B?emNJY1VwSDJTU1ByUkhlSi8rQVMzTWkvZVlNdjc1UkJTTVFaTDJGNFJRWGpp?=
 =?utf-8?B?Y055SUlkTnI0OUlCS3NPMDdlbU9td3lSYmdmZVVTZU1iQkRGRExTSnNJa3Ri?=
 =?utf-8?Q?WYI2QrRy7pshy+j3GZ5Vi/sp2kWsAXYR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWkvTFpERnlhbC8wSkJuVGtKWnp4Mk9ISjRTTGtuUFQxWFNlb054eExhYkcv?=
 =?utf-8?B?Qmx3QW1TOEF3SmNFVTJSOE1hUDNOWXpEMWdEVGZrTnllWFk5VGJMMlBkTlFu?=
 =?utf-8?B?MDZBd2U1VU9ITVFJeC9tQ1ROQWFZZ01DZjVOcUtMNnZEUE93OUVpZzlXOFBj?=
 =?utf-8?B?Ym9zbHNSMG9Cc0JKK3FLcEswZlRIQzhXNUFlMU1LNHMwWHJmT0p4QTUrOS9G?=
 =?utf-8?B?czVvdXRiOVVKMFMzRWJzYVhaaVlsam1hQjRxRERoaTdwUXdKV212T1loT1hw?=
 =?utf-8?B?VWRrVlloVWJ5UnNHQTBhUk85MGF2VlUvdG9rUTgwOXBpMWhuZDZOcXVycTRz?=
 =?utf-8?B?aTdrbHBFK0QrZkJJTVVxWHZEeGE0am5Ocmx2cXZPRmNRelFmdDlpVkd4N0pk?=
 =?utf-8?B?eVNVckNhQlQ5WnEySVVDUHFRMFNZN1VMeUdoWTZjcUo4N0RxZHY5cEtwTUxW?=
 =?utf-8?B?ZUdMeUgrZFpDa3cvek0vR1BJZzNJaXV2eFQvVHpwMDBMVlJ5Nk85QzRxK2lh?=
 =?utf-8?B?cWlhSFFDVmJvcmpBSUMyR1BmZldkdTRadStlVzUwYTdIL0EySHpWM0lBSndP?=
 =?utf-8?B?anNJYWFzelJKeHhIVFdGMlVzUjhpM2U4M3pLTFpBM2V1RFViOTZvZTB0YytO?=
 =?utf-8?B?bnFhdkNtMGhNZEo2bFljU2lBajBwV2F6WDl2STk3b1gvTnVFMkhYQXF6QlR5?=
 =?utf-8?B?RWNSL1V5TW1rUzBGWE0wNHc4N2dNU2JaSVVHc05veFFLK2tSc25sU3daQ2hM?=
 =?utf-8?B?SVpvc2IzbWFISkszcGhqK00yRkxHRGE0elVsb0w1dGdnazFpUG4vTEdBZGN6?=
 =?utf-8?B?bml2N2lRTlNiYzRWVG45WmhLdU1GWlVSTlBVTXFjalVtL3BxOURZanhDRTQx?=
 =?utf-8?B?M2J3MUpzdlNXL2hudFVGMDFxUEVjdG0rdFdKU0Q5UFNFalZQUHAxdjBJR2VT?=
 =?utf-8?B?bm5QdEVEUEhhbkx5T2UzbG5VOTREbVVKZnFya1RDOWpFMk1KeVJhdGovdkJx?=
 =?utf-8?B?b3dWKzZ3WFFKTU5MbmFTamRRSDZ4SzBoVnNsalhaUytYeVB3MkJyd01tWVdL?=
 =?utf-8?B?ZHhiM21IUHhzTTRFSDVleXBOQ0hrdE15RDNhWXpIVmZQKzVxaVFKUDJOMFR0?=
 =?utf-8?B?amluQkhrZlViZnJScXhNVVNtaWVCa1J0eDhXOHJmdExWYzBDcXNTK0k3M2U0?=
 =?utf-8?B?YWZvRnZhblZtRnYrZW1nMFgvTHl4NG1kbk1LTVd0WUxwa3BPTVJaYUJXclov?=
 =?utf-8?B?UklScmEvQ256Zlo0RGhSNVg5R1JuL3ZOc3pxTkl3TTRlT3hnYUwwL3pRakdn?=
 =?utf-8?B?ajA1ZUlnWUhPQzY5ZnU4NXIzL3BHZGZtYkJhQ2dnS0Z5ZW1abnJWWktEOUpZ?=
 =?utf-8?B?bXdRSnFTYWJoNmYxRXNoakU5NzdJZHlUN0dMOHRrcGYybW9pK28vRy90a3Fr?=
 =?utf-8?B?cjNVZkFtOW1xaStEZjYvWXR5RCs1Umt2WTR6MjlEMjQwaXJ2UXFwZmlOZjh1?=
 =?utf-8?B?UkI5ODZHS2xIUHJXS1Q2ZjVKVGx2UkU3MSs4a0dhUkdMY0tPd09PeDEvOXJv?=
 =?utf-8?B?dXN0OVNVMnh4azZTNnhlck5Yb0w0NC9yMXBTeDU2TW5iU0hRYmpIZWl0cmo1?=
 =?utf-8?B?UnVSSEhpWnhtTTQwN2Jaem1IZmNLcFRZU0VFaFV0d1ptbUxMQ0l0dVpvaitE?=
 =?utf-8?B?dStIdllZcFBKUDlQYmpiMnR3akdId3lOdm1qUmRqYi9laUVtMnJnWSsrWFZS?=
 =?utf-8?B?S0xSU1NLN1BIMUl1L3ZhYURIMDdKUkN1Sy9KaVBpUGZRTjhSOVFhZGtxZ1ho?=
 =?utf-8?B?bFJFWVNlQ1hHU2tIMFN4Sis5UkUwNDlaZndpQXAza2RUa0YvUG5FN0ZmQXdI?=
 =?utf-8?B?d0tUWHhzdGxhaHE1OFJ3d2R3eXBMZjRUQjAzVzYraEtVcTZLaDdvMWlHNERZ?=
 =?utf-8?B?Q2RCeWpwWTNRSkt0by9YOXRZSjZjMXlSZjJhMERDdXVKcE9pR09jdG1ERjRV?=
 =?utf-8?B?Rjc2a0JEQTMvbFFXYmlCNi9EMlVJNVp6bVpCRi9CWTB5S0JpVUZJWlFMWlV6?=
 =?utf-8?B?MkdwaFdER25GbU9RK0lpTEdZUkRZVWxNRG9TNE9acnlEOElIWUJvQUxqb2l3?=
 =?utf-8?B?TVVYSmE0Q1UrUWVGQVQrb2pWMy9vYXF0YWUzbi9lNWZnYTcxZWk5WDAzR0tJ?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5102d14-e03d-4de8-99b0-08de33cb42c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:55:22.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dkESFdKmzdV7qpKthtQsp+hyYYw9E2eIF7sQFJbc4A4hCqOps2q1+iLgSlIV6fq/WibRZI8jHg0MlMXcAKtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 06:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20906

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb              | 1 +
 ...inux-cip_4.19.325-cip125.bb => linux-cip_4.19.325-cip126.bb} | 2 +-
 ...{linux-cip_4.4.302-cip104.bb => linux-cip_4.4.302-cip105.bb} | 2 +-
 .../{linux-cip_6.12.57-cip12.bb => linux-cip_6.12.59-cip14.bb}  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip125.bb => linux-cip_4.19.325-cip126.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip104.bb => linux-cip_4.4.302-cip105.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.57-cip12.bb => linux-cip_6.12.59-cip14.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb b/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
deleted file mode 120000
index e78f72ab..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.57-cip12.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb b/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
new file mode 120000
index 00000000..9294da0e
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.59-cip14.bb
@@ -0,0 +1 @@
+linux-cip_6.12.59-cip14.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip125.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip126.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip125.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip126.bb
index c4337411..6f5e5bd1 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip125.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip126.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d8824967145bbfbb926e16e4c065f43cea2c31a41a2047d44d8a8de66eac5ab1"
+SRC_URI[sha256sum] = "88d02001518e19e4d52fc12ce00fec6db191bbe54f576bba9f6be3bc7fe816b2"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip104.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip105.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip104.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip105.bb
index 994d934a..807b0a92 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip104.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip105.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "73489ea64b015a3539b4399dd233f0ca7e69cb179c0676095c1d587c77c93a78"
+SRC_URI[sha256sum] = "ca3e4c6dbcfca09eff9d2c3c8b3c5c5d76f3a36951551f1717976337bbe46199"
diff --git a/recipes-kernel/linux/linux-cip_6.12.57-cip12.bb b/recipes-kernel/linux/linux-cip_6.12.59-cip14.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.57-cip12.bb
rename to recipes-kernel/linux/linux-cip_6.12.59-cip14.bb
index 320888f0..d27b1114 100644
--- a/recipes-kernel/linux/linux-cip_6.12.57-cip12.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.59-cip14.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "bd5279dce14c0dba16dda09f35b6d2d8224d8251a6575544beca2165c591e1c6"
+SRC_URI[sha256sum] = "ca060dcabf8588adcb702b58777c1a3d68f1eccaf899d39a54a7e6ed8288fcc7"
-- 
2.51.0

