Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138ACD11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 12:33:17 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17400.1764246793743541239
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 04:33:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Q+BSHfVC;
 spf=pass (domain: siemens.com, ip: 52.101.69.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np0DI35i9C4fRUA5b2GDPbTAEaQGnZ1/Q/g28+B6CM8JUC46XAYVDtm/yFoBgD1I6Zy5u6Sbyl4phN0wc1UqfTXt5cz97HFSj/+2Yj42nDXbPFReyWvuh4udCrsgE0D3GZVfcZ7vgxPZT9EowJE1Bx6Esi7VSGHrD/zMzcJsSXC5ZtFUmffltgF1wRG4sf22/vwKt0L73aY1r0yNNaRWD5+c0E2qLfyQPrEoJn2OHP1IByjvmPiM6eb/5mto0NE28tb6GDI9JgxZxDKRfz+1rX7Z3n77I9wPOM6+Z6wda5ac8akfI+Ab7UTjuHMaVnTlus+SYHzvpMOnJAvfwxGe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jLkUNlW3lX6Hok51pqPtVHieMtkgu4o505dZxg+bHo=;
 b=E4uaIU1F3cfAkmZXFwLBZUUpl+ry9SYR0Kstqtaq3qicl4HRn+m7n+WYxuaMcsoA8n4uYBfuwSJ2mzONEZ1R7JzpqFP9ZoPPFTaz+SR6Wq5U/GOheStV6lTEvlAVgxQyLEYL3njvC/QIVecizDJt+mauxGerGrRjGyccxgSmbEuwYD61HbsngDgIStPg3bnyB3CmFgRDgesDQDgkznYCx+LaPsY61HjUVmu6HYAA+FBOPpMBo4jRP/XSSP/7pfGpoMjtgAz7PLAEzaZx08AWtX2hkozjBYRkpgkWj9nyna13X1QC8L8cZKAoDtfUpfAAM5NzddEObCcI/f/we6+rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jLkUNlW3lX6Hok51pqPtVHieMtkgu4o505dZxg+bHo=;
 b=Q+BSHfVCDTQjdR7nk9iUSVBMoYPy4OP530aRDIU+IC5zkSaHCMrcF+M1IsjvOkIOQISWIcc85TM5UdvmTIe/GlyFZiWoraGi+CTORBG6CIvwdybm4zJdx2PxToe+2VQNdvrbe9mvK30ZQ4plFpUrToQ6emtbEaeBeyOIBzsenz8S4xQWjWCFZMH/HNiuhPTW8Zcl4IsZamlt+zBbrOcAC/UR2Hf+SAzl49/uPMONHyEYGxMIpFHjWgIi7RiJdVbuFgaOg0/Y65ySB3T/CiY41R/PQ+QSem27QF7z4jw/NQtauGKFIZyFHdaMKgO3NvRXiWnpLX0hdctk/pOqPBg/kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 12:33:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:33:03 +0000
Message-ID: <bd77fe86-79cb-4ad6-a177-fcb5e63ae3da@siemens.com>
Date: Thu, 27 Nov 2025 13:33:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] recipes-core: ltp: Update to 20250930
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: felix.moessbauer@siemens.com, cedric.hombourger@siemens.com,
 hemanth.koturappa@siemens.com
References: <20251126044710.230439-1-arulpandiyan.vadivel@siemens.com>
 <961f92e5-473e-4271-94da-b94575a93d38@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <961f92e5-473e-4271-94da-b94575a93d38@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce0fc0c-61f6-4031-d540-08de2db11bb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RmViVVovRmFhQkp6RndWN1pNVW9IUlJPTTdCa3RNdkJBTjVGYVB1MnJoL1hY?=
 =?utf-8?B?eGxDTmtiUHJmenVpZXpZSTZ4S21GUWJJUTRvcCtrcG5IZUpPRDdlYm5WQ1J3?=
 =?utf-8?B?aXJxQmlMSlpxUnh1dHl4VDMwZDFvQlpPOHcrUWhqQWhjeEU5NzVqNWQ3QWZo?=
 =?utf-8?B?TTNIS0dISVA1ZFJNN2cweGNHb0lRN1MxczBBd3hBT2QvY293OStaSC9hdUhu?=
 =?utf-8?B?MlNKMVNsMGNuZmkzY1lWcFNqY3lGdTF5TlpnZE4wVWtHNUQ5MG5ZaFVZaVpQ?=
 =?utf-8?B?NUo2cFNzbkNzSHg5OGtHVU9CM1B6eFFJRWFidENwRTZINEExM3JWZlh2NUF0?=
 =?utf-8?B?S3FQZlZBSTRUSTFuc1lxanBkUkovREJ5bnhlb2xYQURqcUxIbzNxMkV1RzVi?=
 =?utf-8?B?aVNoSUVOcnpJMkVSZU43Uzk0eTlnamxpdjljZFBIL0JGcDkyZnlZOC9NQmhC?=
 =?utf-8?B?czdsWHNlTXkyS2RGbEdvVUJvS1Q3dVYwT3cwQ3c0aXYreUdkcVRZVEllYko2?=
 =?utf-8?B?Z21wcXpzLzVTenloeW9ULzhRRVJDeTJNbjBoMFhIZXNjUFp6bE5uRVc2NUVI?=
 =?utf-8?B?T3p5V2NncWI3Smpsb2NwaHI3MmF0OXViYUZpVHdPdEZXUGpkS2hkOElTakwy?=
 =?utf-8?B?akZRaklXbzdzeTRRUjE1Rzg1aGN6WTZPeStQaVdQc3ZjeVhXVnBjYWR2Vksv?=
 =?utf-8?B?MzNuc0w1Q2xCUHRZeVduUFJicjZWN2pMMGF6QS9rYWwxeXh5NXFmbG1rLzhj?=
 =?utf-8?B?MjhZVDZjeUFPYW5rYzBqNnI4V25rQjdRR05HeE5pdkhWZ1pCVE5yTEo1VkMw?=
 =?utf-8?B?Ymo3R3BKWm5EYm52eDFqVm5tS1U0UzRQOG0wZ1cxSVFtaWVUQXhJT0xOTCtI?=
 =?utf-8?B?UzN2MFB3NzRtYWJNakNZeEFiNTBHTjZnTGgvS3JtbW9ZR0xwMTV0bU90ZXJh?=
 =?utf-8?B?dEJRYXROODNuR3I1ei9sZ2lzWXptQ3JpcmJWcXJEWDNCOVRMcCtncnRGYWVS?=
 =?utf-8?B?cEpZTU9JVHVpL2F5eWE0cStmR0RhTklqZEd1Qy9NU1U5VENnTzE3VXFvS1BV?=
 =?utf-8?B?eThlQjRwbVNtd2ZVM1NYV1hON3RaYmhXWHhBWnA5My9YUkZCTnFQZ2hsVXhr?=
 =?utf-8?B?ajhqTVhKV1ZoRnhrRVZaQytObVNneDE0V3YwOFQxNllhQ1hkbFJIMEZyQnhP?=
 =?utf-8?B?VlJBRXBFTWFMNGlFS3dINDZYQTR0elNyUGFCdHhnRGJSUTJsZzl1S3RGQlQ1?=
 =?utf-8?B?ZHhFQ0NxdXhmelZmNHg5RXJMREx4dkp1WmZYTVpGZEZNL1pLbUgxTlJMRjB6?=
 =?utf-8?B?akk2NS8yenZTaGNYcllxUmo1VUs1NytwQWhNNTdQUHFpa2s0dWtEd0xsdHpp?=
 =?utf-8?B?K2NGa200VWxneXI4TmExbFgzV0tzay9XbVRYTUg4QlN6Qm1BZ3RKeGRqSlNm?=
 =?utf-8?B?Um0yZGQrTG5mMzlCemhHUnZvMzRiTldDVW0yU0JRZHBoOHVudUl1RTg0bjJ3?=
 =?utf-8?B?M2o2bjgrUi82WVJMVGFKczVWVm5oOEhsdEpyN21DQ2xWZmNuZFA4N3dnbGZa?=
 =?utf-8?B?RzZQZkQ1SitvNXBBNXV5Kzhkd2J2cXVabTRYNUpPQ1oxblp1SThGcUgyRkJ4?=
 =?utf-8?B?TjZuVWdHRWFGelJOWHFSb0FldHM1Y3Nodk1aYjRQOVVQbDFJakUwS1BGMHlJ?=
 =?utf-8?B?U2tTTEtmYWhrdUZPRGVXVW0yQUpWakx0b3M4RUlzLzU0M3lsQit4TnpLanln?=
 =?utf-8?B?dTdZeVZnMWxjN0MrMGU4RWQrYTFWZXY3dytQbDdVVnQ4eE9iK3dTSFJIbHZV?=
 =?utf-8?B?TEFJOFRnQWplZDhWSmEyLzVWQlpyd2lRWnNFVjNSZUo3YzBhMEdaY05qMjd4?=
 =?utf-8?B?eFo0ZThneWwrcDRucXM1Vkc5WWhpMEQ0S0FJa1ZGUFJzRFIyR0pxakNVL1Zz?=
 =?utf-8?Q?oVohukk+wzat4TZT4epBr654I/UG/HsC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3NsYjh1cWdTUzNHdC9wYXVVajVPQmoyQ0FCUVNtQjgwZnpSelF2Vlc0Q2xz?=
 =?utf-8?B?cWRiR2lKbE1mZlFncHZaQ1ZiZXRoZ25VOU1STjRCcG5oNDAxMzNJZlg0NmxO?=
 =?utf-8?B?alZKSkZYSUFWNWZyMUdvR016TysyTGtnNFpPSFowUFJqbWhlSkdLZ1E0MUJ6?=
 =?utf-8?B?eHM3YWE1bmh1UlAxdGVsanBaZW1mKzRTMk5MU0dNRngycUxIeHpsWWRKUGRT?=
 =?utf-8?B?cmZHYzdHcklEYm5QQjNSNG1tWjFNSnVGUGdTL0llU0JKL1NZejZnd1FueWZw?=
 =?utf-8?B?VXVhekt4aHMrNFU0Vm5BOXdNQ0V5dG96UmZYWXVYMCtCS2JEZWpaZFJiSEUv?=
 =?utf-8?B?Nmlkb21LYmJldGtEOXhQL1BZUUhuUW44YU02ZmdEYUx6NjdGMCtOQjU4cWF6?=
 =?utf-8?B?aDVCaUFiZzFEU3FRUmx1Y0hXaUR3RURabkUxMGM3eVZQY2Q5YlpFZWVPUXhO?=
 =?utf-8?B?cm14M2dxdVZTWUp3czVTOGVFY3JpUkc5cHA4TUxWa2RabkVOT2J6dG9sYmov?=
 =?utf-8?B?N0pSRHZDenE1SG9iZnN0dHlscmMyL2JXOGZ0QVNZUUhIS2xxcXUxSUc1MHpM?=
 =?utf-8?B?L016WGxwMkhlL1FJNWlEZFE2ZXZ2dUsvZXB6Zmt4MHEwRUY2d0czR1RJb05r?=
 =?utf-8?B?L0RQYU1maWNVTTJUamRyYng5NDB2Q20wS0NRYjdlelNmMnM4YjMzcHhRZXRY?=
 =?utf-8?B?Q1hDbmlmSVVuQ0NmTGc5aU9JNlRMVFh5QkVCT1J0Tm1KaUo5SGo4SytQWUhZ?=
 =?utf-8?B?dHA3WWRhZEZqWW9qb0o4ZU1nL05GeWFCaURnODBhTmd2ZXZRdGtML1BDaXVV?=
 =?utf-8?B?Y1k1SjFTUlFzRVZwVWZBWE1OMU53aTdnS0V1NjBIakdHZHJWV2drZG9NZ212?=
 =?utf-8?B?cHhIQk8vRWRNSFhSZ0JHdHMwOTh0akRQM2VuYlBMejBNc0FGb1k2K0ZoT1l0?=
 =?utf-8?B?MTNyM2RjWGJ4blJKK3A3NnlWS2JMN3hOWHM0SEh6cHV2Qk9wenpDSGRQLzZp?=
 =?utf-8?B?QW1GUkRjYy9OQmZHYnZhVU5YQmdxUU1zNFZCQ2JOTlpva0dlZXRVTWxUVWFs?=
 =?utf-8?B?ZmZlUWl6NFI1TG1iaENKdEtpSGRrV1NzM3R2eEVIdzQxZVowK0RwQ1lsRzln?=
 =?utf-8?B?ZU5NOXVOdFRwZjFOZTVuSno3Uklham1wYVJycVF5KzZzYjBKaW5BcVJDcHpG?=
 =?utf-8?B?WFBwR0hVWEtSbm80aHVJaWhlZjFjV0RIV09BWXAzeDlYaHpwNlBuZ294UU9R?=
 =?utf-8?B?ZkdKMVlGQnF6MnlXUjhzejNCUnlrL3dKRDV1bHVoQURMQW9XU1ozVFFqaWVl?=
 =?utf-8?B?dzVOY0hWNW90Z3ZzcUxlQ3h1WkRNNUQ2cm1TcDQvUy8wWnJWWG42cGgvUUZr?=
 =?utf-8?B?dFYwV09Fb3RrSFhCOUNlSGI3WW9RdzlBYWZRQjNGa0pvRU02Q2NYRW9zd3FG?=
 =?utf-8?B?dHpiWHdFOFVDc2lzOWUvVUVremNCN2Rma0FQeHhLNnJzMjJJR2lWSzkvZ1Nl?=
 =?utf-8?B?N0FnczNVUlRNYm03SjRIVmlwSWhMWkdOa2hsL285WlYvZkdmSXVreFE4d1Fn?=
 =?utf-8?B?M2JhWWszN3h2NEFpWVpTNk9WYjgwS2pWMEZWS2taOXlnblFnWkRFcm1JN2Ft?=
 =?utf-8?B?empsMGp2VXA3b0JIbDBNN1kxaFZCMVZrYUhWeXUrNlE0OHJZdVpZY2JVR0FF?=
 =?utf-8?B?MGV4ZERlN2ZBNmQ4TUFyaUlCSUt0Qk9WZkUvYjhQKzhjdlMxUnV5ZzFwbFIw?=
 =?utf-8?B?SFBoUkJhU1JHNG55b3VDSHBPdmlNT3ZMVm1lYXMza2dubFFEa2pwazA4NlFr?=
 =?utf-8?B?dHBjMUdqR0IvSFlsM3hnTjFLa1JSZGJaU1lxTDFwWWZnZnM0VFpNZjZROVZ5?=
 =?utf-8?B?dEduOXFNbHIzY3NCRGJieXlYcGFrLzlja0VpNWNBelFkb1RiTUNlVVhyUm1I?=
 =?utf-8?B?aUdmdUJlekJEMm1TczFDaWZ3cHlQZTRnUGRWZ1RKWlRJU0EvK2kyN1dXSG1V?=
 =?utf-8?B?NUxTODU5KzM3VG9GTHQyWDQrQVQwTmpRVUZMcUdXeGd5cWRvb1htN2FQbW85?=
 =?utf-8?B?R0VmK0xucDhjc0lnRmU4aDEwalM2Qk82N045WDNGWWVvazUwTHVOb25Pak5s?=
 =?utf-8?B?OW9vUFgrd3NUNElxUVN6ZHRkaXplTEZnWHlSVURUTGVON0hDTGlVSCtYciti?=
 =?utf-8?B?NWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce0fc0c-61f6-4031-d540-08de2db11bb5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:33:03.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT6hBgf0/uSKGykql1GRlDyjsHnnpghxLXhEAcFbEPXSwRk2kXU5n0kIWWv7AejIRB2SNuWMaCWxoSB8jaqJVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6354
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 12:33:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20756

On 27.11.25 13:31, Jan Kiszka wrote:
> On 26.11.25 05:47, Arulpandiyan Vadivel wrote:
>> Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
>> ---
>>  recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>  rename recipes-core/ltp/{ltp-full_20250530.bb => ltp-full_20250930.bb} (69%)
>>
>> diff --git a/recipes-core/ltp/ltp-full_20250530.bb b/recipes-core/ltp/ltp-full_20250930.bb
>> similarity index 69%
>> rename from recipes-core/ltp/ltp-full_20250530.bb
>> rename to recipes-core/ltp/ltp-full_20250930.bb
>> index 553b58d..279ddac 100644
>> --- a/recipes-core/ltp/ltp-full_20250530.bb
>> +++ b/recipes-core/ltp/ltp-full_20250930.bb
>> @@ -11,4 +11,4 @@
>>  
>>  require recipes-core/ltp/ltp.inc
>>  
>> -SRC_URI[sha256sum] = "27586ba78eac1e40cd422add2842f1ad70f09fea55da3bd6a25e10feb786d4f2"
>> +SRC_URI[sha256sum] = "048fa4d69ddbe8a94aa15da9bdc85713ab07a0abbc3de2b8bdd9757644aef1e4"
> 
> Thanks, this change was already in next, though.
> 

Even in master for weeks.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

