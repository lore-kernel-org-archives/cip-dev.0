Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B914D2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 08:06:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2057.1768896395525532141
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jan 2026 00:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TjFYKx9W;
 spf=pass (domain: siemens.com, ip: 40.107.162.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLqIy6MoGa4wktz8Mkg22kFxrUR/Py50wMCZDpJ1j6ZdPWox9LfB1idwEw4EXFS1zox/JX4i+DU/gFBXzJwH9SIBSmn4adjnOQLwpJbq/EN0hGSB/srOagdOkT4qJ6DY3rDLMToWCLmXKEWocXOdvPH2056QcV2sP9dQDzX49+z06TqqkB/Xj2J3NQMijEsME0S+OUcUWWiCT1EfycTjfFobfL1kZerMHKyKTNl7luskWl5a6/mu1oE+m3XdFKToTACX8tcWboWU4g5f5X/u2ogzViJbxnYqdotnI8AmliNm4Ps8Xbs/ok9xBLJAg274xy14xskysiBBI48keMOGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcmhxNTXIvJQAowLaRjKijgMHVSD7D7iu6zYC0ix+yw=;
 b=q8WdBhJLSVVSpbdOtd2B/u2BK2ISYG7VA9+mrtEbq86EmW7rMrdHZDbv8qNfi4UhbUJdqY54GBeFRl0X90dV6JIX5QvtGpJy573nKJUOA2Md+jekqs/t9Qmxxd76hJOuJXlBwMOu3xRZQ77lVpM7AiCwlqgnRrpYD2cDS68r/62LI278dejR3R1YHJY0NTdz/a4D52ESQqOxrD9moWFi7SdZeZaMrm56lwd12QYoStEJe1h2k6A6oLKj0ohDDuBkwzt/ypYAXrTyPBf4IF5K0ao1GW5YfvQ13TBmYkEk7Bosbnae62zAUTH2yYUGzFJNLMm4pfdIg849MLMxsReP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcmhxNTXIvJQAowLaRjKijgMHVSD7D7iu6zYC0ix+yw=;
 b=TjFYKx9Wh1i6jYbZNbX4VavxKGeR4roiKTsrr6bXUyVPlFrlq575mgxIESDHnFdhNHj/HxvgiHqGnIlgz+sTgee6NFlNtb76pcMo7FzniZt4ZF5dF9rlscKnoF7vXQBdiskWKdeSHOshwWXWyQHpVmFIU2MEAQIL43CxFemHJNb/CvCo2RKqtnBQ9hjASTPu3Mk7JwOHHOn7FWzrk+/kAEtp2G55Xf52ru37cbJTmvitei+ZbI/ns2pKOEPZ0korRf1dmPkV1fgl+1bAgDbf+r1H1YDRziDdTnLfRhz475mf//Ufh/bvEdwDaL33WXgmYE6v6nY0T4KMpPv6iaVGxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:06:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 08:06:29 +0000
Message-ID: <d4211b5f-c043-44e0-afe9-6cd6a18508f4@siemens.com>
Date: Tue, 20 Jan 2026 09:06:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] recipes-core/swupdate: generate
 reproducible source tarballs
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com
References: <20260119061851.120592-1-srinuvasan.a@siemens.com>
 <20260119061851.120592-2-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260119061851.120592-2-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 921ea0cb-6950-427b-2cfc-08de57fad107
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bVo3NHIrRVl2azZkZTRSL24rQmNSZm5vTXBHbEdWUWtldlpEVXlHb3Q4NmxX?=
 =?utf-8?B?ak9VZnVETEtrN3B5NzR3eXgyQkI4SFVzQU8vaUMrVjRXQVZlT2p0cEV0S3cz?=
 =?utf-8?B?V1VTcUtoRWhXME5yMnpPVTVJbi82cTh6Y21OeGZrNTBPSTFyNitxbmFuV1Vq?=
 =?utf-8?B?YjdsYVF5Y0l1WXozL3BiN1FVNXBldXFFUk9mc3V2dnhWNURteHYxZEczUmNa?=
 =?utf-8?B?ZXZNSkNtNEovWWpheUNkYXRlZWhpQjFFSUF1OGw4Y1AyWnBXdlVFQWsrc2hO?=
 =?utf-8?B?UlkyUWxYSk1LbjNpZDBHU2ZoVW14eUFqUExickNFdStTV1lZd2pHQ0IzY2Rl?=
 =?utf-8?B?MXZYOVh3VHlXZFZoSlFrTGtObjJDRVhQTmZOOVdlMUd6T05WZXV5K2ZOR01Q?=
 =?utf-8?B?NDNab2JSa29lcE9qS0g0NXpsTFVyQW91ajFHNEZsVnVmK2hmNnpzNXVRUFlM?=
 =?utf-8?B?VjFIcFFtL2NpZVg1TXV1NXJGQmF3TExaS3lVTGJjcEd6ZmgyTUdOZFl6aldP?=
 =?utf-8?B?V1NQenNrOHc4Zy8xMGJKbXkzNlNiVXhqY1kvN3p6eUNtYWY0YXlxZEk3NnlY?=
 =?utf-8?B?akRBUGV4RnNNUkhhUDc1VlgwaTNVb29nTGU2WHVpYlFaNjdma2s4eHZKSVBv?=
 =?utf-8?B?NGE2UkhOS0I4L3JLSFFqUjlxQWdGVUNiOVR5Z3ZNVmwzMTkwTmtpS0luWGJZ?=
 =?utf-8?B?aE5FNHdmajUyM0hhbGY3SDJqRjZFbVFpeHpPeXRCdmlscEY4SUZhZHZLUzdD?=
 =?utf-8?B?OWVXbXl4cjJ6TEdMeXJNZVhrUGN4dkwrdldCTVdFY2FsSWxFNG9tU0dWa2ww?=
 =?utf-8?B?cTBTaVU4TE1YV1UxZVJQMnl0cTZuTm90bWhLeW4yNnNvMkttZFJZOXZwb05C?=
 =?utf-8?B?UlpQNkp2QVNBZ3QyUFUyYVVGVFNGQ3lKUlVnYUpRY29xNmxOMndITkNUbXlS?=
 =?utf-8?B?VUNQa1lzSk9UL015TFhORlNTQUNvWnd3aW0vbUZyQkNJZ1hHMGxhbmwzbzRa?=
 =?utf-8?B?SzRnR3ZTcUJaeGZVNklIOUlZNWlNRjRIL0srN2k0SWN2cFI2c1BCSTNraXk3?=
 =?utf-8?B?M2t5MExVNXFSTjdDd1p2ZUJwUmR3RWdPUXhobHhsWVA4RXNDQnY5U2FlT3h5?=
 =?utf-8?B?RUlLbGtObHd6VjVGRzlSamRZeFNUY0Q2dk52Nyt0cjY1ZFR2SEU5SVVXcHh1?=
 =?utf-8?B?NlFnSmhYU1FiTlEwV1ZMb3ZBK1BpYUpYMUd3SVhJQ0ZwQ1RmSzIxK2xqeUhW?=
 =?utf-8?B?MkxvdG5xTW4zSm1QQmsxdTFjOXZVRklpdkhnZ05kdDJOVDdUeUlhM2NEbFEy?=
 =?utf-8?B?SXhwdytHUTRUVUJEVlhtK1B1MGhGM1M2Q3JkRE5Rb21OZWRFNEp2UHdVc09N?=
 =?utf-8?B?cHhxell0SHFWbk16S2doKzk2RGQ0Y2dWNHVhSVVLbThhSUJESG1oTTE3TWZt?=
 =?utf-8?B?VVRLSld4VlREcVcxMy93eXJ1S01GV0pVb2ZkWUtGTnVoM1AyRHI0eVA5dmt2?=
 =?utf-8?B?bndYaTM1UEJRZEc4aFJRTTRYdlVtTnhqT29iL29MbXJDNmxHcVRBV2szQ2Jj?=
 =?utf-8?B?dlo4QTFJb2Zqc0ozcXBQRE5pcHRLQ3FLU3AzaFljVUtmcHlrMS9xODc2VXVR?=
 =?utf-8?B?dmRDQzVJbXpCMWQ1dWtFNDlDSjZFZzh4elN3RGIxVFcvWnNpdmtOREZHeDd3?=
 =?utf-8?B?UDdmcGh1b1E4M1pFTXZiV1lVVTRER3hycG14U3VvL3E3MldKd25zUjNJU3dn?=
 =?utf-8?B?L2RCWTUvV2lLN3BZTU9FMXd5WEszSFNobGh2VVlwYkVGVXVJMW4xOHNDZVNr?=
 =?utf-8?B?eGpIdk1Tdk00R2pUaDJzdHBpL1hmL1QvUjFRMXY4K1NuWjNvSWRlbmJVem1m?=
 =?utf-8?B?VEppKzhOMnlnVzFxWGdCdFQrWnNnWVlXYmdYYURaSVB1RmxuNytMN3YycmxG?=
 =?utf-8?B?VE04ck5FcjBsd1hudHF5aGdCV1Zmc3k2cHl0NHF3dWc0UGJnZk13c05KdlM0?=
 =?utf-8?B?RDhhajlOSEkrZG1STXlQc2llQ2dNTWxpenZQVnpuS3haZjJ2dVllWUZZbFhV?=
 =?utf-8?B?MmZIU05uMFJiVmhJaGRmcU55Q0dFTkFJWk5tbUowSzBXbi9uS0gybzFpdzRo?=
 =?utf-8?Q?aXJivvIoV4TjNdvv8kE60r7CZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmN2RmcvQzhveWd4cXJISG03UXVSTXVtdlk3cDRPc1pHaHNFV0wvUUNqWkcx?=
 =?utf-8?B?aEJBZ1ZyVCs2aHBkeUxBNERhMDJpMnF3eU9LL3hMb2VVSjBEOUIyOE84SGtN?=
 =?utf-8?B?K3ZodWt0S0VSQVJFNHhMVjRaaHBXOVM0aStUMlNKa2NxMmZYdUZ4MEJQRGR5?=
 =?utf-8?B?VCs5VFJDYTdHaXBXaVR4OW1TQWlrZnk1QUk5Tk5qYklsRWRVV09MMXNLOFBD?=
 =?utf-8?B?ait0V0QyOU8xNnBWeGNnaDlFck42eFhBOUFqMlZEWmlHTFVXSU5ubWxjd2NZ?=
 =?utf-8?B?czA2L2VyN3d2TVJ2bzRDYXVENUozRTl4dDE2TGkvL1lqTDJGOG1PMi9lK0Zq?=
 =?utf-8?B?eVI1bTNiQ21jYlFleTdiNUVuR0pidjlsWWRoODJwaXRHYXkwcndaT0lBb0Qy?=
 =?utf-8?B?NFRLeEp4NWFIRUF1L1FhbEJOT3d1djYrNXlqOTFjdUpzNTUwdHgwSmF0bitp?=
 =?utf-8?B?Yk0zclR0RnZXUURGTVpqajlldUZ3ci9NNEVmVTB1ZDZhK3ZaRGJBTGNFQmFt?=
 =?utf-8?B?RjJSamROT0JxbjJ3ZzJ0aDhVTzlvOVNNY3dua29BeWdBQWk2MURQUGJNUGNp?=
 =?utf-8?B?SHV6Z3ZKd0tNSkdZd1A3dTZPblNSWFZob09BK241N2NXRVBXazk4cmdwNlI2?=
 =?utf-8?B?SVEySmdHTnhTQkFGU3J4NkxVUlNHSTZSOE5uT3VZTFhuaFYvS2hmc3pNT1E0?=
 =?utf-8?B?S3EwT0JidGVDOUpJd1ZaVzJZS3NlWk5wYlNkSEE3dGhVZ1RoTDVBYkpkQVhN?=
 =?utf-8?B?L3A0MVJvRlVaVDk5ekJzbmNBWVdIUDlibHF6ZVFIUUdUc1lIWlRpL1g3RUJN?=
 =?utf-8?B?WmJpdlhjUjFyQkk4U3prSFJ0UURxeHVRb3Q2RFNvdmtjRWF5L0c1dktpR0M4?=
 =?utf-8?B?aTJLbUxKOGZSS3RxK0NZK0RtUGhreUlMR3pkRVlBTjdWMkhPc29YQW5Yblgy?=
 =?utf-8?B?Q2EvV0ttRElKdklZOTg0OUYzRU0vaUVmRXlTUXRNN1AreEVOVEZ6cU1GbU9U?=
 =?utf-8?B?UjVBVjZrQ2tTdFQ4RVlJdllpNG1SWFZsNlJDdmZUME9UZm1aZWRTNXJDYjZT?=
 =?utf-8?B?RlR2OUk5RytWL09sQU1MUTdhZ3Q1Q3ZtaUd2UkZGQTJ5ejhsL3BkaktBZ2NH?=
 =?utf-8?B?bGVnYWNZcVdwSDU1a0I3MHgxRi9jRXgrV2xibXpFMVFieThHdTBiMEM0RGR6?=
 =?utf-8?B?bG9GVDJhQ0JEWkkwNENCZFVVcEF6MUhaZUcrNDV3Q29mWk5ydllRMWhDSUdR?=
 =?utf-8?B?Kzh3azlQMVdRd3M4VkR5eU1lckRlOFZ3RG5pYjJwOERubUZZVU1Mam9CaVBP?=
 =?utf-8?B?RThSaEozbmlsMUdTNHZ5MmdaVXNndURBL001b1hNMVVwd1RCMDVPV05VUUhB?=
 =?utf-8?B?OXlFb0ZJRk92dzJzblpQQnJzaExiUVF3c0F3QWhQbW5udjR2R3pMcys2SWtS?=
 =?utf-8?B?alJ4V2VGZlliN0pmUCtHYnVkVm5sKytFRjg2QkpDQzkrK2RmczZSQUxjQnVQ?=
 =?utf-8?B?SFN2a011N0FncmJqVlJQd0hhVGZSQnI2STUvWTlmWkNPa0t3SUcyU3J2UTk3?=
 =?utf-8?B?bWxSb1BhSnQxbHFrSlpnUVhyZUhZZ1BwTUFjSTlzWDVDeWw4M3QrWkU5bTN5?=
 =?utf-8?B?MlNXRTM1Y3JlUEZwUWNwTlpvd1U2TC9QbHh0OGVFVC9uaEI0V3dBWUk3Vklw?=
 =?utf-8?B?VHNRV0t1eUNpaDRaYkZ4SEFXU3VTaVJnWnVqZDFqZUtCUnI5ZWphRWoyQWhE?=
 =?utf-8?B?YkdhNTBVS2hHWTlXVDFET2pVK29PWGpHTEFnZWZvT1kyZUpGUUI5RUU5WnpO?=
 =?utf-8?B?OHhpTGE4OTNmNFFvb0xmbGI4d0R3L1dlYUUwNFl4bzcwR1ROVXIvZEV1azQ0?=
 =?utf-8?B?Y0lGNWkzZm93dEx5eS8xNTBtN2h5ZlhxdGI5LzhDVHFKRXFRWmZGdUZ1NTkz?=
 =?utf-8?B?VzBFRFpQQXFOWkZnWm51UHBEWUFCQUlwdEh2bVlIdDVmYXh5SjVMWDdvZ0JE?=
 =?utf-8?B?YTdVNTdRLzI2a3Z1MFcxM2JpaDQ1UVlxbzFldndIQ2RSMStiZEF5OEZ3dS9j?=
 =?utf-8?B?cDhYd2R1Y05ocUI5R21SSDFtNzdjRHIya2pZcnB3ZUVSTDlIdVFoOXo3ZGpG?=
 =?utf-8?B?R1VUOStFcGhkYW9GTkYrdjBVRFZCaUxrVGhCSHYzN3NvR1VEU0V2bCtNZ1ZJ?=
 =?utf-8?B?Q29yMmU3QVNGTHNlL0VpOW1vQnlrUEtGeTJNamxDcUZETGw4aHgrRGpyMnBy?=
 =?utf-8?B?YWM5L3czdi9ma0w0RUZtd2pqcUZ6QUQ1WE9EMUZmVFB6NlVVeStmazU1WTVz?=
 =?utf-8?B?azEySHVORFh2R3BETlkxaGJKNVhrRmZaaDYxYyswMCtJVlliU1RBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921ea0cb-6950-427b-2cfc-08de57fad107
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:06:29.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0nbPkt2h/20K6ednCUSJBz4Jt64JWgN0Pe5qnotmsij/LXeJNtblhKTQfevRqiSr4ErNTVDk6Kni4jWIxRYqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7518
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 08:06:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21684

On 19.01.26 07:18, srinuvasan.a@siemens.com wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
> 
> Apply additional options to the tar command used to generate
> reproducible source tarballs: (1) use numeric and null [GU]IDs,
> -clamp-mtime for file modification times to never be later than
> SOURCE_DATE_EPOCH (preserving mtimes for files not modified by
> the recipe) and --sort=name for consistent ordering within the
> archive.
> 
> Ref: https://github.com/ilbers/isar/commit/f19a4f955111a409b00da98285b9baca8112dd46
> 
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>  recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb | 2 +-
>  recipes-core/swupdate/swupdate_2023.12.bb            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> index fcccc2c..3a73c89 100644
> --- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> +++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> @@ -37,5 +37,5 @@ CHANGELOG_V ?= "${PV}-${SRCREV}"
>  do_prepare_build() {
>      deb_add_changelog
>      cd ${WORKDIR}
> -    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +    tar cJf ${PN}_${PV}.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
>  }
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> index cc01a98..6822153 100644
> --- a/recipes-core/swupdate/swupdate_2023.12.bb
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -50,5 +50,5 @@ CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
>  do_prepare_build() {
>      deb_add_changelog
>      cd ${WORKDIR}
> -    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
>  }

Thanks, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

