Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8560D489A4
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 13:47:56 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6227.1768571269569274382
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 05:47:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w26xJ/UA;
 spf=pass (domain: siemens.com, ip: 52.101.69.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vlf3MMRiRP64hxGpApo8cFZ2dwaNmdraDjKwMbwQns0wK/sEDFXeloGlLuNUYBMm96sxIepzulg2hZs5lFcy8eG1MysFwoSXgP23sDgO9XkvsT7YP3YYVRwkDUiH8eRzMwXwqLDnntc4Jen0i/xHjSOuLykDrrKnliKi81/43rNNr5dzo1hIZQBYWbGaW62w3A3T6LNECNPlLKVZ5e5kKNvNHrRtTVqJCbF0Rc0wB2WbZpSKUVzoGUlZr/lwAXTKgctmtkOR9O+/IoEdYpoCCG/ZWKPFjoMYA62S3CwY1rrqkCIMP1tApJS7xSibRIyUrsnME5wDYVoip4YvVSYJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud+lj5Jr2AUIBDprz3geHpdgpWxNSWaAivjwAISRQIo=;
 b=pdacRNFqVs+B8F4h8JQWmyTJ7oa+KBgtR7xkWozWrh3lmxCNUvTx/Ldb3jC0wWyjoFNFbEDPawnlBDd4A4XephIljDA852wFf1lli8Z0G5DMrpaNAj+CI3657Me/kYyZTnoohvXlGCH0UZVmuzNpv9JXMUXb52JEQ2GXvVbfe2jYBhsxMDbI6TgwJh59OwCvRU1S4Drz53JTYEvgNXlWkm4GT2Ej4pZU8JYoBLwBFTlhMHJygYeIO2DQ/PlpZWHmYPujDhirsrHqKr1iMKnO5DRi5l98V7Fz2w7uwt53pfqIxcC6gxy1RBRUtHSCNjI9IFsA8T8bIpcEZUI4HNFtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud+lj5Jr2AUIBDprz3geHpdgpWxNSWaAivjwAISRQIo=;
 b=w26xJ/UA/59Uui0UhW5YWpOyj+HhSvGvOhPBCIzBFiH7HE+Z2nkuJB7m79/JHKiMzGu37zMyMEClOWJr0MbTVAVYBVbeXkqwSGGycP2dykmZ1bOyewlxTyhHP9KCu6Zf/A5qg10j94blfgE/glolca2vpB/865WTm6NCucLjq7Svp20U+zoxfHc4q1Ce+zyWTk5a0CfYs+A7e+FFZQcKtX48nGOTnC9OwnkRuk1RJocM4sh1R43ZtudqtZRJQXF5OrxcG2qynSAthB/2i2u/Jbkf5elnP2iStP+aBugwjc4a7N3AEljXS7t1GdcrwsrEmDkPQTN+9gnjsFWS03R3vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB9PR10MB5353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 13:47:45 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 13:47:44 +0000
Message-ID: <325d650c-f9c0-45db-b878-ca9e9d3a636a@siemens.com>
Date: Fri, 16 Jan 2026 14:47:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 1/4] swupdate-config-wfx:
 Recipe to set configs for wfx backend based updates
To: cip-dev@lists.cip-project.org
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-2-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20260116120347.1733494-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB9PR10MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 899dfc34-9601-4154-390f-08de5505d37b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0pjTzVicDQydVpoM0FEN0lYNml2U2VnMFAwc1NsVTN4N29aMDU1T2RQdWZr?=
 =?utf-8?B?aDJwazI2WjF4T2wzS09xMVlYeDE3U0thMnppdEdQWUpQMHYycmhxdGVjQVdL?=
 =?utf-8?B?cXh5eVZPeW5WMWQycmVObG4rNWhWNXJ5MFZjaXgxTTBMVE9vcElxczBOcHlx?=
 =?utf-8?B?Nmx4NFIrenJqMlNPY3F2a3d6dGNXcms3V1Y2UmNrK24zenQ3SDNVczc0eEh6?=
 =?utf-8?B?UmRlM3ZLYTZVNmE5U29IUk9jekE2SFpmcjk2c0Z3TDNDbncrSUp6UGNxcjll?=
 =?utf-8?B?NXlmcCtIcGY3ZDRUcERUY0UwVkFVd0pNaE5VNmE5TXdZcmRETmJPVFBJUTNL?=
 =?utf-8?B?Q0kxdjdya3lFbndxUjJpZ1NMbU5ybWVBWEdScFU1bmFHNXVUNVZxU2FKMGRB?=
 =?utf-8?B?S21NWUVBTGwwWlVCbHRGT3RNYi9ZQXpqUVVSRTl4MEtydHZXQnNUc3BYV1B5?=
 =?utf-8?B?YWNaZ25vbnZhb2d2OEROQTFiVUNxaEh5emhMRzFlUnAyV2hwb2hiMmNJT3ZB?=
 =?utf-8?B?eVZsR2YvcEhrbndCYTR3NHIvQWk1czBkcmR0TWZ2aHh1VjRIVERhemJ2cWFl?=
 =?utf-8?B?Z0NRQ0lwOU1QNjdpQ002RjM3TDRrc1A0TlRFbnRDT2gxT0hJNW5iQkpzSUEz?=
 =?utf-8?B?M2Q0VVp0R2JtamdRT09FZjJPYjlCa3Q4U3M1YUdMc3I3VkhyVDF5blU5dnVr?=
 =?utf-8?B?UGtzMFg1c3k5bDdYVUJGOG1ER0gzSDZ0TExHWFovZWpSWXJCcTJjOFdHUlNI?=
 =?utf-8?B?czIzR2ZINlB3bDZPT0pxUGtzb2xxZ2JIK0JFWHVHKzltTFpzTGxmRmpVZlZX?=
 =?utf-8?B?YUFpU3ZMdDZIR3BFNTNaekpENXBQaXlubjlCVXlJcGFvbUN5dGJaNWdyMlZU?=
 =?utf-8?B?dzY3L2hCMEIwb1JlNFk0Y3o4eXQ0OURvb2VMbWJFeis0RTBLWG0vQjBCcVRI?=
 =?utf-8?B?Q3hNVGk5QzVtdHVMZlZCWjFTczdUUFQ4L2hyZFJYOTU0akhFTkEwclBEWGlq?=
 =?utf-8?B?TFg0dGxXbXNRQ01SV1pkY3c1ZWlKSmVLSWVnZ1dmTS9kaGoxM3NRN0R2N3hp?=
 =?utf-8?B?bkpCbnRmbS84dnM2ZGpkd05nM3oxWmE4b09vOWFFWUwwaFJyajVScmk2K1ZP?=
 =?utf-8?B?NVdYSVh4OHlyR05abDZjQTk1TS9yaDRJdENhZzlqL2cwdDk3aHZWMDdGTXIr?=
 =?utf-8?B?RjFvOVk1V2pQMWYrRlQ2TUszajhCODVnVWM5ejRYdDZ5N2Q0b0pJWHVqNGVB?=
 =?utf-8?B?KzZTTlpYaDg5dkNFbStkZEE5NnM0cmZoZW9wOGJ0M0I0eGtoODQwSHUzWW8r?=
 =?utf-8?B?bDJzc1NWQWJxcTdyVmF1Q1dERXVaVm9URjBkSFRITW5BODR4SGJVVHhHUHMx?=
 =?utf-8?B?bWVBcmJLTHM0bnRkaDhZMUFCNll4dWMzQjNCaE9ZU0N6Sk13K1dhQUJVY3RI?=
 =?utf-8?B?c24rYk8vTnlOUFFkZW0wSDBkaU9QbGdQMkg3bm8rempyakVPQUxsL3hFY2RY?=
 =?utf-8?B?aWRBbWJpS3pLcGhtQS9VUU5vT3ZNMWkvRVNvVWdoOGtqTTc4NldTUWhUYkxE?=
 =?utf-8?B?RjhPVEE3dlNGSlhsVjRSTm5MVEFIcGRoaFhpOXhyMG5kQ2Fxay9FaXlIdnNu?=
 =?utf-8?B?YmJMaEJsS251bU9rNWlDbnFyNGZVdDBaQ1RKNDgzeGlUOUVDQXNvcExQeHh0?=
 =?utf-8?B?aEdkTitmdnlEalNSd3RoOURkdWN4QVRTaTVFWVVxUWtkREk0Nmt1eFVzTTNq?=
 =?utf-8?B?Qzc5SFIrbVZ3OTA0SHduUUplS0k1UUM1WTFGdXNLQU1lZUc2WTBwTTQ1NzND?=
 =?utf-8?B?Mzc2OEJBSmtPNWFzZzRSRUtUd0lIOHpkSEsxaTFoVGZZdThMWi9FYUhMbXhp?=
 =?utf-8?B?S0wzMXN5QzZHakQ0b3M5d1JpOEQ0TW9pcFc2TlVrN2Q0Y0Z5SUtySDZkYmJR?=
 =?utf-8?B?ai9Zd3NhaFF2ME5zemx3dzg5R0xOTEJVSXlnaSt5Rk9uSHcxdDYvZ1o5OGJX?=
 =?utf-8?B?ZWU2cWxWVHQ5TFhRcllmL3pIUndrMjM2VC8rYTdQaUVub0NRTGJHeHN4dG5O?=
 =?utf-8?B?MzI1d2RYbVRXL3FzRHBjL1RkVU8rK1F0NVkxcDh3dVdOaGEwOGhYdWRuYndU?=
 =?utf-8?Q?OyQg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjY5U21ONDdFY0ZFQjBvR3VvbUkxWW00cU96bmllVXVnQUpFbkhsNzRqOFBH?=
 =?utf-8?B?c0x5aTdWWmVjcldMcWxuSTFhZnkvanFXZzJHdHlXL3FPZVlXYVRIQzk5Z3BE?=
 =?utf-8?B?cVhBbExnYWM0N3pmNVlpays0VjlBM2VEMHNtN29sS1FycWV3YkxoQWJlQm95?=
 =?utf-8?B?OGwrZ2lLWkpEZTRzM3NBZ1BYSjdzOUxSNFlTVjlVTlVOZjdoam1wWHpzUmxX?=
 =?utf-8?B?d3F1UXAzVGlqN2w0czB0WW1UdW40bCtaQmY0eGdHc2tIVnNYVzNaNnMxNTFk?=
 =?utf-8?B?TENJWXg4bStBcnlJR3Via2p1bWF2VUN6ZTN3QWRGaFRsbGFjQXl0eGd3YVB3?=
 =?utf-8?B?aFJ6WGlwV3JrLzNhVmt5Uld5SHpUN1ZCMnRPZVFYeVRHcmhHQzg5TklTakRw?=
 =?utf-8?B?cUFaWElUZ1BicjBCMXdOeXhVQ3E5aHRTc1BHY1dUREorc05XaDhvM2lLNW5D?=
 =?utf-8?B?Z1VlTEp0TDUzeVg3ek8wSGJ2dVlLVlRnWmFsVWRtbTgwNWZaRWZHcXlvRWJu?=
 =?utf-8?B?OXJWRVI4WDFnbTE4M21jVTZqZjlJSkE0YkJwa0xjVDI1VVRzSHZuQVp6cTE3?=
 =?utf-8?B?bWpQQ2daMVNMSGl0bVF4eThZSmZvY2kxTUdnUDdWVmNhMnhsTHpOVVdkKytU?=
 =?utf-8?B?VGx3MjZyQUI1TEIxM21BcXE3WWE3MDVuUFhaNUVUdzNhWHRWTWs0c2F6aFJB?=
 =?utf-8?B?VjdscHAybUl6RmpRMkdXZlY5Um9ONndmbkt0RE9XS2hOTU00OVptbmVhRHdo?=
 =?utf-8?B?eGVkQ0xqTEtZczlJOEhibStIc25uMkNvUWNIQ1ltcVJleUN6dkZCM2o3TFZH?=
 =?utf-8?B?L3FKYi9udTBHMEFLZG9MZ0M1SUxmd3Y2ekdHMHNzMTZUVlJLd3RlR0NBWEk1?=
 =?utf-8?B?MGZoSk0rQTUxS21PR2hNZWM1T1E0UUUrQVdPaFl5Z2VUbWZ6SHNLNGk4MTZi?=
 =?utf-8?B?L1IxYzhkSW5Bbm5vNUtsR3ljOFlVYzFBUHhqM1lVKzFzclRsVWxKMFE2OCtk?=
 =?utf-8?B?V2dreVA5T3RianJWaUJzR1ZPNS9KUDROYVQ5aTlKWGduRnpoU0N4QktCeVpC?=
 =?utf-8?B?TTFSNFhJQURwUm0zVWpIWlZibUl6cjdVdm4yTk12M0dIbWVybnFSQTJDVWZG?=
 =?utf-8?B?YmMweksyTWRjVmo4Vm1wdXNHSml2MTFubXlaK3Q2RDJTM2pFUXNvRm1UUWlr?=
 =?utf-8?B?SmdSVGxVeFJBNytEb0lDQmI3aE80S1l6NGdmb0hpTytmNC9DQS9ZQjIwUTBJ?=
 =?utf-8?B?aFN6VTNqQThKeDZhcGE5d3dYcjNiMkpTaDNwZDZYRE5SSUN0d29odjM2K1JR?=
 =?utf-8?B?SjVPRzVkVVlPTTJOeGdNODRxRHNHcmdTMTF2TktPRmJMZHNmV1RMY3ZqS01k?=
 =?utf-8?B?UU05L29VY09NRjRCYUNvMHk5M2xsQ1hPc2hQazZDN0hubEpJbmZkMEJLSUdQ?=
 =?utf-8?B?V3o2MXp1WjdjbVViZTZBRmZ4SXpZRUszRVlEeHVpQVl2dWJqaklSY2xQaWMy?=
 =?utf-8?B?Y2FrSnJmaTN0MFdqcjMyMXYrMWpMdVU2SzRnL1VqNDE3cXVoay9YZnhkbTJ4?=
 =?utf-8?B?U215cm5ad0tpKytaYkgwSVJoMkV3ZmhUNDZVZzhEcFF5U2Jyano2NXQxckVv?=
 =?utf-8?B?R2l3SzhVa0NYWHU0enlKeXFDZzEwR3pjSjk4MVArVWF2SS9reEpxNlZ6VmR6?=
 =?utf-8?B?a2Z3ZTlmMkgyOEtQM1lnQXlNU1VnaU5GdW1ZQ2Nra3l0MGRaQjNZQkFsOGMr?=
 =?utf-8?B?NVNQdXBTOWV1QTVtQWJPa1dVNmxuRXZSb2F2QVdram1GSmFqaFVSa0pzVzhH?=
 =?utf-8?B?WVUrcFg0TThMTkc4cDlFNVJSdHFTZ2ptaklhZk41c2NNS1djQkhCTTEvNmdl?=
 =?utf-8?B?L0FmL3hpSm56RzRNMG5DQ1ZFYitGdDBNUVZ1NS8yVy9UZXRhODRNS25uRnBs?=
 =?utf-8?B?T1F6eEVFVTR4bVJmRytCT3JQa1dHVkhBUnFRS2hoWmNVc3N2ZVd2VjRZT3hV?=
 =?utf-8?B?QlcwMHBqUTZyT1VOOFY0ZlZuVGRYUWJZKzV4SExRNFkwYktGdUNZdUgzaE5K?=
 =?utf-8?B?cXdWbm1rLzJpT1VYc3hOK01wWCthV244emF5OFZqNEdtZjZxaFdOOWFIb2dE?=
 =?utf-8?B?L2hQcGNUcDh1VzBsdTVWR0s1N1BjZEVQVkxGcG16M092SldLVC9JOXM0bEZr?=
 =?utf-8?B?WGtobEVJeFZZVTR4RThKSmdZTUNQZlFVNlhkdmxoQTdCT28yR2MyU2dGeHJs?=
 =?utf-8?B?VkxyUDhnNVhzQnRVVWpNcmJKOGdJTFJMMjV3dXdiQ3RSSXpyZ29LdzUyVUhr?=
 =?utf-8?B?SnVOQTlvYS9kc2dkNW5ISTNYcXFqWE83eFcxQ1dsRHV3RE9qR1BId2xWdTdr?=
 =?utf-8?Q?qbIhoGfeVM/X+YOQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899dfc34-9601-4154-390f-08de5505d37b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 13:47:44.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwEYSj8yMNcWGPEvMLr4bFfqz/B96ejCXrPSKPlBLU3P+4pcIkSPXbpgPdu7QsdO4nuRyqSCg5f+nDGx+XaRvgHJOlQOKp9E59Kjr5QMBN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 13:47:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21638



On 1/16/26 12:49 PM, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> wfx requires a unique clientId for each client device for targeted jobs for
> each client. Additionally, start SWUpdate in suricatta daemon mode with the
> built-in wfx lua client.
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   .../files/suricatta_wfx.conf.tmpl             |  1 +
>   .../swupdate-config-wfx_0.1.bb                | 27 +++++++++++++++++++
>   2 files changed, 28 insertions(+)
>   create mode 100644 recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>   create mode 100644 recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> 
> diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> new file mode 100644
> index 0000000..744b426
> --- /dev/null
> +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
> @@ -0,0 +1 @@
> +SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
> diff --git a/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> new file mode 100644
> index 0000000..3569888
> --- /dev/null
> +++ b/recipes-core/swupdate-config-wfx/swupdate-config-wfx_0.1.bb
> @@ -0,0 +1,27 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2026
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES := "${PN}"
> +DEBIAN_PROVIDES := "${PN}"
> +
> +PN .= "-${MACHINE}"
> +
> +SRC_URI += "file://suricatta_wfx.conf.tmpl"
> +
> +TEMPLATE_FILES += " suricatta_wfx.conf.tmpl"
> +TEMPLATE_VARS += " WFX_URL"
WFX_URL is undefined in this recipe, e.g.:

`WFX_URL ??= ""`

Quirin
> +
> +do_install() {
> +    install -d ${D}/etc/swupdate/conf.d
> +    install -m 0644 ${WORKDIR}/suricatta_wfx.conf ${D}/etc/swupdate/conf.d/suricatta_wfx.conf
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#21631): https://lists.cip-project.org/g/cip-dev/message/21631
> Mute This Topic: https://lists.cip-project.org/mt/117296108/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


