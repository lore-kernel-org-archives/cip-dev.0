Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B2CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:22:26 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.51])
 by mx.groups.io with SMTP id smtpd.web11.1259.1758036143691178464
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:22:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MzFXHWbQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.51, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc4Rz/5e8qzKzUsTrCoWfpzUoePPAdCxnhP0oMhVxcNiUT682opjrQ2Zr2kER5Ld/UQdJIIkeBhOJGH443XsRhzWursafhn14JC4UaMMXGIhIsOQDhEOLGo3f2VQaAm2itBWC13ev9KpA9HUzif7xicqOcVpKwFqOCjDc1OEsDAZYoxmmKMJprQLc2+Hi6QS48gPB4rR67eD6dR175C4CFKHabHDqamq4rpUrBkCmQS763Qh402dkDfdvnDvCuQyrqvDlzPoT0BB7BsBGasGA4g45HkMhwZP5nzLVlXTLMWF2SCvfKqJqnbYSqDk3sKMRrcygyEOATQfn/+Phd0jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWNolxuRlztFM/d/ah1yr7myWAiF7qaVie7Wb0IIKvA=;
 b=pKz5wrYnF89phmz6D2ugd+guVretiNj95AOCK54GYJWXoBZ47VHv1aSEcmpxPpX/PFgMG7xfuikfEZzbTxtn6PwIj2nRRu1cchq1BkreBuNd7iJvzJLA5ikJWRlgIFqnWAVdFP+s/xMyW9HOStcvz8N3TYFZ65eM53bzTT9M18GFaher8ukVgXEP7hryVOLefoqciixSEFdSC8Gvs7qsNnBuVVz05HDSJz6SGF14RCG4RpVSrQ1Hh0dQRpf0B8qw3Oa8BqeZnI/yZZjdMw96igH6uYm8NAMuT9NMqjmund5U8u+qhhKOlH04K/NEtXVi2mvDjOU6/Bm/BATinpiuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWNolxuRlztFM/d/ah1yr7myWAiF7qaVie7Wb0IIKvA=;
 b=MzFXHWbQWB4MjuH+ZrRCmwxApoq9suOIoDdnjwTp1Q9N5ioD8djflxcM0U73Uy1galEm7xWHWm3w9yrSchBGv2FL+cGt6vPzYcvULdaYc6QI9c60JvjeuP6LzXXcVUiv6fc2E0VJqt/4OizNhmT69b8BnAka09t4dV1Yfszz64WmGR2twEW3cnWWwqHv33KeT70XxhYK7WVrRDEI6SipjLF4xf3O0T4cNRGdCKQBj5N2+t1IHht14BsfD1iCEPan7Vrv3dj3exaUu3QHJbx95Ix+7wWZJZpsTZsWkX3fL7cdD3bCPKsAr9x2pktPyI+VDgmdwOBL4IeBtW5l5ujKhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by AS5PR10MB8077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:679::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 15:22:20 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 15:22:20 +0000
Message-ID: <df99cce1-ac33-4294-8930-5012f24077b3@siemens.com>
Date: Tue, 16 Sep 2025 17:22:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] erofs: Set UUID and
 SOURCE_DATE_EPOCH with empty exclude dir
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250916120952.1771209-1-Quirin.Gylstorff@siemens.com>
 <cd0fa7c6-dcf7-4caf-af60-2931ff4acb4b@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <cd0fa7c6-dcf7-4caf-af60-2931ff4acb4b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0440.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::19) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|AS5PR10MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b96f7b6-dcff-49fd-ff59-08ddf534d3f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WnhhODFiRnlkQ0ZwbHA5cHZvdXkwdWtSMlZyMkU1eW9xaXNsR2Q4Sk1mNS9t?=
 =?utf-8?B?VUNabVQzZXA4K3gxZng4RjRKN0FhSUJUTllvK2lhYTRGZzVXK1ZSdFZqbUo3?=
 =?utf-8?B?S0lhWnljUVAvRk53bXBxbFFWQ2ROYThUQTFLR2Rwd1ZOYS84MVBFYzBIdlVV?=
 =?utf-8?B?VmlabWtUK1huVFk4NXRxRlNqalhSUVVFZXJYSkQ0RUNyL1lGR1pOK0tjK3Br?=
 =?utf-8?B?bFlVd3A0L0dQaDAyMWdGSDgvVEN0SnBZRXlMa1RCQ1BJaWF5VXAwbUFtVEdS?=
 =?utf-8?B?WStuQURoQ1c2YVNVaDN4R05IMkppSjU1MDZMV2ZWcEsrYVl2WnVhbXA4TzNm?=
 =?utf-8?B?SVpuK2RFWDIyZ3IwcXBwUHF3UDVBYWo4RXMyNE9QWmpBa04wa2dTU0pHZ09n?=
 =?utf-8?B?TEEzRmh5VkttV2hxWVFtQUJRbTFuMmN0QUl3bDRGV2c5SUE2NHdJRHdVTFRn?=
 =?utf-8?B?ZjJhUURuVy94Wk91OGlsVXZocjJMNjFJWmRnSW5LckkyeTZQaDVmZ0ZIMkVJ?=
 =?utf-8?B?OVIyRDVuZFh1WGQ1ekh2bWZxeGNzT21PcXROK1VpQytKR3ZrdzlJdkxITVJV?=
 =?utf-8?B?T2tCS3U2a1dYQm1BODVDMmdjNnN5SEpLR3JEYjRDZnhnR3BpWS9YMHpXd2Rz?=
 =?utf-8?B?RHUzMkJxeFVZUVdXNVFKREVNQm1CM0lwazN0Szl2Q3c5UzQwWTF2b1N4OU9h?=
 =?utf-8?B?Ulk4a3Q0SXFLeWhqcisyVWpNOXdoUStMM2xISmdGelVGWGN2MzMvbXFzcEJk?=
 =?utf-8?B?eFJ5aWQ4Q2dLZS9jVi9kUG9RZTNOanBINnhITGFJRCs2K01OV1R2SWQwUGp6?=
 =?utf-8?B?TEpwRUY3bXlWSnZwM3V6Nyt3VzRoRkNwY0s1QWRISmhodXgyUDVkdTN4Z00y?=
 =?utf-8?B?SkhBT0pFVmsvVEV3YkthMFhwdXgzaWI4Mmo5MUV4VnF3RGg2b3dlMkZEMVQr?=
 =?utf-8?B?UmNiSUpCaDF3WHpLVmxyeVAvSk1vMTRldytjUUE1aFBYQ0ZZb21XTmtvYzAv?=
 =?utf-8?B?UXp6b0RsY2hXRE12SkVacW5FSTU0Vmd6dDQrbi9RcUdkMmU1b01BTUlhakpj?=
 =?utf-8?B?c0plOGd1d0tYN1M5a0FQMjgxUzR3eFE2M1NhTTF1RWwyb01ZS25CNE9HYUhS?=
 =?utf-8?B?eVdIUXY1UzlXYXFFbEdGUTZYb1l1d1ZLOUNyWWgvN3ZsNFlpT0hYVThmdkNI?=
 =?utf-8?B?KzJsUUVuTE9leXJtdkErbFY0bGVzcW9WZi9lWDdNcnY3R2dTb3ZVZEYreHZR?=
 =?utf-8?B?MSs0WFdYUGliUk9obGJscWdCNFFDK05LR0p6QjUybmd4Sk9IaUEwQUJHRUFt?=
 =?utf-8?B?aFg0TTBYN216L29yU1JVNkxGeEcwUXJkdXhCZTRJSEg3MnpubXNJamQ3WHVt?=
 =?utf-8?B?ZjlLQVFRRkowenM3RHlwRkFFY3NsUmhwbzN0VzZKcHg3T29TcW05cUZ2cTZU?=
 =?utf-8?B?a0Fid2tPK2VoWDM0b0s3RkFpdmFtaXBKUHdJNGd0TFYxN2gxR0lCd1FkK1BG?=
 =?utf-8?B?ZVFQZjNoZ2dHcWU5cCt1OFNqZFRZdmlhb3ExTUh5TEgwN2xpNjEvOFBEOHdG?=
 =?utf-8?B?K2xOcWpPYlV5UlZNWHBjVjFySzJpdjRVdm5oV1hwWFUwRnF5ZVpFdUlRNnNI?=
 =?utf-8?B?RVBXc25ZbnVBZUZreFZQTzBGYjN1TWtwMVpPVVNEa0lwaGl4UWpIWHFUcEVs?=
 =?utf-8?B?Q29SQ2VFNEU1dXZwMmtPU1liMk9DcnNpdGNXYkkrY2tRVDhFQTByZHF4a0Uy?=
 =?utf-8?B?V1lvZ1ZCNi90V2QzRk1wNFZMS2h3Q2RpYjMvWDhIRFJveHl1S2tYQzFVSnFz?=
 =?utf-8?B?TWg2Qy9ydzBKQVd0M3A4cUFyU3REVVdaTVFPWE1HME9jbGtKSDFKTXJPUFdp?=
 =?utf-8?B?SDllRE9aaCs0d3R1N0JVdldGN2VDcVNmUDdyWWtsSE1QWWRUU3UxbjI2RzB5?=
 =?utf-8?Q?uxpw8vZo9XM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bldQcFN5SndqeHhPdUlvRnF6R1dUSDZ1UGI1YUtVOXhYRXpRMUxvSG5RV042?=
 =?utf-8?B?S0ZFUlRGMHdZUVoybSsxMm9QMllUWU9SSG1YRHp0eWRHSnlhWnZVaGZzMXlO?=
 =?utf-8?B?QnBQbmZldC9mVGMyU0tYL0xxSnI5c3ZFLzJxMHFCbzYrUTJlU3NqUDVwNkZl?=
 =?utf-8?B?Z3YrZktlSlpjcVBtYk9KazRqZEQ0a2J0UmlmQTBtN2VkZFpHLzJKUS9pZDho?=
 =?utf-8?B?OWptL1RBbndKTjZPc0pTbkRoRHBNVzF1SjI5UU52OHRFRnROWTlVOEtqME4z?=
 =?utf-8?B?WVVoaUc2amo2aFZLcFZ4Mi9LVnN5ZlJVVjYzUE9FcU1YeVd3Z2krOW1QZ29w?=
 =?utf-8?B?VXBsVnlvdytJRDN4YU1ia3c0LzRHNW92alN3T3Iwb3Vud0w3ajdncFgzYWJ4?=
 =?utf-8?B?OW5BTGlQQVY0dWJ2Z2xqNnFsaENpYzZnL1hUUHUwQlMwSDlxVzVsMFZEVmZJ?=
 =?utf-8?B?QnBxY0NPbW5jM0RIbTJCNTUyaVEvemU5OXh2SHYvR2RzWGticVBFbWdwcHN1?=
 =?utf-8?B?dWpBdW13Y0l3K3lMcitDQ2JwOXNaNWV0UHFkTUJXbnJ4UndteEVKellLalNS?=
 =?utf-8?B?TExZbTcwTkpzZWhuRVFKRDh2VWExMmhSR2djMlpzeTZnTlorL3NBSDJtSUJl?=
 =?utf-8?B?Z3h5dnAzbXNjN0dHWHZUNWVFcWFKczVtWFFVZDA0QS9mcUtpaW0vUFdkVVF4?=
 =?utf-8?B?MHgvTUpFZkl1UEFpd25hUTh1Z1dZSjJvdGxYc29heHpaTmtkb0xxdHFvWVh6?=
 =?utf-8?B?WW5Mc1kySGhNdFdzQWlHWCtqM0dGSWtDOW5KZjIxVEZLUlF4Smg0cUVCTEZ5?=
 =?utf-8?B?aFgzYW9WSVFRWWhUcDRMcS9Xd0xlSFBvNGd2cUgxcmJrTTVFTEU0cjRGWTJk?=
 =?utf-8?B?L3V0azNEakowSHFmMGtIUGN4NEMwcEh4VmJGNzl0MFJOYzdOZDVnZEFuWjZI?=
 =?utf-8?B?U2VISWoxbk9aVDdkLzdyVVpDZVE2VUowYkg1UkVpeWJKSEs4OVArTER6dVA3?=
 =?utf-8?B?VDNmTWxTREUrQmhCRm9OcXRJK0paT2h6YnM0eTJwVExreU02cm8rQ0lMMUtu?=
 =?utf-8?B?YXJvTm9Wd0Q5YWFRaDJpcTN1NTRXdlQyaDVkMDZjQkJycHlncUsxTytQc3BX?=
 =?utf-8?B?Wndad2J0SFVNczU5M2Fnc0FVSnJvNyt0YTNEa1NydjlqM2QydkErYmNwaWd2?=
 =?utf-8?B?eDVFVHNNM25yclhlNzJ4aEtSMGRJMGVoUkpnVkswbDZkZVpKK1BGVEg0RkJl?=
 =?utf-8?B?TzZRY0prRWprZ3d1amx3WFgydjRMd0NIdWFPZ0lNZG5uWnlRYUxTS3JnRW9T?=
 =?utf-8?B?NnFSN3gwUWRieFU4UWdvZXN4MWFVV1VaeWZBbkVUcWN2U1laWjhPS3Q5eGln?=
 =?utf-8?B?T0J0eGRrYnNBdXRiRG5HdEozU0duV2pJSXZSZm5sQ1U5MWRTOUp0Zm1YM0U4?=
 =?utf-8?B?NmFiNzZxMHFuRk9Dbm1tWWNvMWZNamxOeWVvcVpvTHpDTHJnOFR5QkVueDkr?=
 =?utf-8?B?VTRtaVgrK1p4NG42aFh6RXRzdDF5UDk4dWNlU3BKTUp0bWU3dnFuWnZIS2ow?=
 =?utf-8?B?b2hWOHlPdktJZGxTTFl5WGwyUDVaMEdwSEtPWjNldTQ2QjlMc2tLYkNPbndO?=
 =?utf-8?B?OTdPRFIwRWNGZjRHbVVBWmE0OXI1WHQvRjlMT1AzSXYreS9BeVZsMWpWcncw?=
 =?utf-8?B?SzhGQkt0REM2RzduMUVidlVUdHBnaEFsdzE5aHVURTYrSjE3T2hHL2RUM3VE?=
 =?utf-8?B?blNEMTV6enBXenlDeTdxZnlZRGJhcHoxc1RvZ0t2TTc0dlFNdGhzSFh6a1BG?=
 =?utf-8?B?UzlyZjEyTG1wRDBuZmptY2M0MHI0SXNFVnVkUEU3RWpVOUExQlZhS2hURjkx?=
 =?utf-8?B?clZiK3VadXJ0Q1RoN0puMU5keFFLM0ZLcFdDUW1hUWNzMVNtY0dpWW5reHho?=
 =?utf-8?B?SnBDT0ozdFoxRTVvNng1OUhOY2tYbnVGU29qd0RHdFlnWGZoOXpmOFEvT0Zx?=
 =?utf-8?B?Y0JtdXVMLzNYWnFqd1kwMXpJb1QzNElCVkdXSDNSS2YwcGlSOGhPSDZYazVo?=
 =?utf-8?B?dXFLNDVqdmcxZ25Kc2g0YVZVSU5mRSt0UklhSmd6NkNHd3luL2QvTVFGTGNO?=
 =?utf-8?B?Z1Zxamt5TGU4bjN3UnZaVWZQaE1MbDdVN3V6YWFvT2hxRWtuVXVkOW0zTklY?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b96f7b6-dcff-49fd-ff59-08ddf534d3f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:22:20.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 160xryZZkT+hZ5R31uqcCE1avVWuBv41oC6ZfYujAb+Mik+xvSM1L8z7Z2sGbcs9Zv+s4ZREH2JRtoRUj9b9P9GNKVM3oGwOfgESt7oociY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:22:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20062



On 9/16/25 17:11, Jan Kiszka wrote:
> On 16.09.25 14:09, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
>> set. These variables should not be depend on EROFS_EXCLUDE_DIR
>> as the are necessary for reproducible erofs builds.
>>
> 
> Good catch!
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   classes/erofs.bbclass | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
>> index 2743bd1..debf097 100644
>> --- a/classes/erofs.bbclass
>> +++ b/classes/erofs.bbclass
>> @@ -17,21 +17,20 @@ EROFS_CREATION_ARGS ?= "-z lz4hc,12"
>>   
>>   python __anonymous() {
>>       exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
>> -    if len(exclude_directories) == 0:
>> -        return
>>       args = ""
>> -    # Use regex to exclude only content of the directory.
>> -    # This allows to use the directory as a mount point.
>> -    for dir in exclude_directories:
>> -        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>> -    d.appendVar('EROFS_CREATION_ARGS', args)
>> +    if len(exclude_directories) > 0:
>> +        # Use regex to exclude only content of the directory.
>> +        # This allows to use the directory as a mount point.
>> +        for dir in exclude_directories:
>> +            args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>> +        d.appendVar('EROFS_CREATION_ARGS', args)
>>   
>>       import uuid
>>   
>>       sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
>>       erofs_uuid = uuid.UUID(int=sde_time)
>>   
>> -    args = "-U " + str(erofs_uuid)
>> +    args = " -U " + str(erofs_uuid)
> 
> Hmm, I think you wanted to write "+=" here, and that is also why you
> added the space, right?
+= in my testing doesn't add a space. The parser should resolve this but 
in my testing this lead to something like this
EROFS_EXCLUDED_DIRS="boot"
`boot-U`
so the space makes it in debugging cases more clear. But you are right 
we could simplify it by using d.appendVar(..) add the end and not two times.

Quirin
> 
>>       d.appendVar('EROFS_CREATION_ARGS', args)
>>   }
>>   
> 
> Jan
> 


