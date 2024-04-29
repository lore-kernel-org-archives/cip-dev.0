Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8FFC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 15:52:49 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.77])
 by mx.groups.io with SMTP id smtpd.web10.25174.1714405967847907370
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 08:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gEGJQHgl;
 spf=pass (domain: siemens.com, ip: 40.107.7.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwrBhMfcSqUqpWuNTCLRpRUyHExYO0OpVUbKilqgxWGFZb965E2YrGQBQZvhFzlQy6/x6IO8PbkpDNdiW+eWb3i9UUDW7IyTBlPdHid9C1Fu8TmnSXhWenZ6cJCCiwCaBdNz8OC8v5c3Ht+3G+QAT7pojYsoqzU9KJKrHyMowXdF2VLAJm+2lLhaS6/Uv76ca8Cdc8iXzgD/+/FiHoxOA29utEM/M1owrWQVnmkJrOefWFqnC3lPDiDx7WGYO7BXTo3ZM+9TUGbb6r+Rw4EcEE7Ah1A2rW/6JHTvlvyQ6koyQI4gf5LenHPlh0DlId5b8vyPVdrvv8SAkh+ThZxaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmsvoi/5f5+ZQMc4s/oUOOKd0LChDm3X59nLw2dM7eI=;
 b=ajDl3yjxa+jTu9FUxa0DjexcIHi54p0j6g/zorf2YrA8mZB2HRUz8iBkFqJ8gnEjBia1tasbQNzqohVkX+BwjsNi+WaVs6r65asJVnNAdS0GK/aXia07x+ttBJvmfvFXZ5SA0q6FANzAr0MUFfr99z+gyVt+BroyW0viAe25fEeRAyhlW/hfKPOi3cdfo6WpTN8HOgbxXIwgMgVoN+/84S21wouwneLJG423FLUmrRVBhZId9UksVndQ+FxB9fRbL7xYqNqyyjZInmSF95jO36vnhJ3OYJvIUxapnqrYlmcWfnvZI3h0twrAi+7Hm+VLqbNRqE9cHBiOfjo+AD4a0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmsvoi/5f5+ZQMc4s/oUOOKd0LChDm3X59nLw2dM7eI=;
 b=gEGJQHglpzas2T3fvGpT6uvh574R/txmSupv2h2iufdH0cWP6Ed3Qm0XSvT76oYUd4vkgIgptKwSYx89CJumQ2jutE0ABfxXsQRilArDM4BcHQLa249nOXatsLfTZ4uowvbtCOKxVSjVXjyaZMM8C+pMzAc1EDxcfHdmSX3WXaSUnnPhAqFol/ToE31GssrhgHcVL2Xhard1QYKa4h7JFLS9Bfu9a8UUylbfzx8B3GZ37WKVpvZ3M/UqnI7AXyzhAXUe+4DHe7RCZoqr/GeVKQD67Q/2A3ATPgL+3e9YvGm+mCfnaXHwzo6DdOvxrCh8mWwwU6dmDBv62p9qHn/tlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:52:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:52:43 +0000
Message-ID: <0ac466f4-d9d8-4b80-ae0b-63d943ec24ae@siemens.com>
Date: Mon, 29 Apr 2024 17:52:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] update ISAR to latest version
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
 <20240429052417.736212-1-kumar.rakesh@siemens.com>
 <e1e7eb5f-6bfe-4e65-9b2d-270c79ffab38@siemens.com>
Content-Language: en-US
In-Reply-To: <e1e7eb5f-6bfe-4e65-9b2d-270c79ffab38@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: ba751fdb-b82a-4552-85f0-08dc6864683f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d2RYTVBNME5OWnRJSjVtbitKc053SHRMckFIREx5VEZ2c2JRMjZnNE8wWTVH?=
 =?utf-8?B?WkV3d2lKaUk4WmxsZndzWjNIeUZ4RkdkTDZPaEtjaFZRN2V0VmgxUG5SckFX?=
 =?utf-8?B?Z0xaNzB3eVAyNHBEWE9neVJyL0plTEdCMGlham9ON256WTE1aWlRMW43eDhT?=
 =?utf-8?B?TENDcHhveVFTWHc3bFNOMyt2cDFSejczN0xuNys3aEljOWtsM0tjOWl3aHEy?=
 =?utf-8?B?M2daZzhVVHplMjB2cDJCZmZpUEYyRmU5aTRibTl3aGdJRUhHVzJuLzlmZGpU?=
 =?utf-8?B?Q3NpTnJUcWRNWnpSdm5ydFdYb0VEeWtBNVVkZE9NTmxSbGxtWm9OYkwyVmlC?=
 =?utf-8?B?TEpqcktqRXN0aG9OcStiRUliNjFEaE92d0ZkN28vODVhQzVLZkFOZVc2U3NH?=
 =?utf-8?B?dURRMXFZcGhEb1YxVy9PdG1rRVUzUWRLdWM3YzdnYVY5djBTaWZ0c1M5MTFW?=
 =?utf-8?B?MEs0cG95aXVHTE1YT1h1bjdRVmJmb1FkQXlSYnp6cHhQREFIMDkvWmpxbEt6?=
 =?utf-8?B?M21HVmh4a3RxemxTMm03Kys5VmVQbE9nYzhLYXZHejRVcCt3elJuQkE5MDRi?=
 =?utf-8?B?ZjZtQ1d3UkxSbzZSamdJS0lpUGJxRDZSMUtXbnhoZ3lkTU5CenJmL1ZGb2hS?=
 =?utf-8?B?c2NWSU5XeVY0MEUySE9aWENnYzN0RVlwQnVFaXY2UEFmeEh5NWJBU045Q08x?=
 =?utf-8?B?WERXcFZjbkthc3lYQ1dwbDZEbm4yRzA4MHQ1YXlBeHE1MEJjZFpWQzdmbE9U?=
 =?utf-8?B?R0NmOHJvNE1tVWplQkhZWjU0cHh4NVRDQ0tQWFNpUWh0c3hJVTdpdGRRWGZT?=
 =?utf-8?B?dzlKWlJnWkdiVHRseDNqc29SOGJsRlo2NGc5NjlXdml6cnNXZ0tnTit6cklt?=
 =?utf-8?B?S2NmbFF3UUk1b1huTGxsTHNKZVJ0MGhIckhNaHp1WWgyTlNQWkVnOFZZeXM3?=
 =?utf-8?B?b1hndEYyelE2K3N3WVZiZlBlcStGOTBMbWo3cGlKNjR6amlsMmdVSjFxSEpa?=
 =?utf-8?B?OVFhMk9IREZYVzQvbS85ZGxWclM0UENDdE11YkdTdmpPbytHRzhNdG16S0RO?=
 =?utf-8?B?SUU2M0prUFdnOS9iZkZxSERDSnlEbWZubmhnTHZEcUhjakFFOTAzajN0U2ww?=
 =?utf-8?B?QkFITWFZTmw3N3lXSkZaKzdDc0ZPWGN5ZDBwM1FNeTZmU25zeTY5K2pQLzRt?=
 =?utf-8?B?WDdwK09oZnBYS3p3ZE1FMkFMOFlGd3hIL2p0MXg4STVFbWFLdzhGek9pd1ZO?=
 =?utf-8?B?S25mY3JUNjF6WHdLZzVWK3lvMEE1M04vTjNINnVJdGI4MzlhVm9Vb0thSG1L?=
 =?utf-8?B?bkd5WjRRUHJGalkzKzlJemdPZnVCcXA1L0FxL1k0aTh4Ti9PVXJsOUJPMEE5?=
 =?utf-8?B?bnI3bVBRMndjMldMSFA1azZTcThrRXJIalQyYm9ITlpQWUd5cldFWHF3TmNG?=
 =?utf-8?B?dnJNKzFaTVk5STNGMER4cURPUkdCTjlSWk1qbmR6NU1PbnRDc0MxSUdtK2E0?=
 =?utf-8?B?UkhJbncrNlkvNmtHWkowOUZNWEs3T0hxWW4yMkpmVk9NUDdVOGlYeUs4amk5?=
 =?utf-8?B?N0RPZThBNk1Ba2ZwNFExcXhaM09oUi8wK0xVQ3JPQVZVaEFybjZLVmNNV25J?=
 =?utf-8?B?REVTRzdEU2RjSlhHRWxmU0FRQ1pqdHVRWmp4cnNEdWxIS3lGNCs1a3hkKzN5?=
 =?utf-8?B?MXl3OGhQdThLOTc2eXlrOWNrUzhESGFqazNsT0ZqVk5mNEx2NWtFRTFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkZhY3BhaHd0d0s1dnY2S2NEWjJMSGwrTk03ck9JS1FVcmNEWnlia2Ezd09M?=
 =?utf-8?B?akpBYVNDQU9qRXRpUTlHc3NucytmMzlha0dEZ08yWGJGRUlWTHUzUjJiOS9I?=
 =?utf-8?B?SlRORXRiQmptWWJXRFdKVS9ZcFIzREE5SUFLRDgyby80bGpyL0k2UU9uNm01?=
 =?utf-8?B?NC9NOUROdmc1ci9HQ2lEeHJDN2ZROUJiM2oxOE1tVFNiRU12N01oRHNSZnZn?=
 =?utf-8?B?enhtc1RocW1rd2dzV3Zlbmd4eTNPT2szbzZQeWw4a2Fkako5V3pjdXlIbXlq?=
 =?utf-8?B?RFk4SVhvbmRIdzdoZER6RkJGZks3ZytlaXJPbE5JaUROa2pGMjNjc09QSVZy?=
 =?utf-8?B?dkg4YkorY1lDdVh0WFVyeTZ3N1FZMmlaU1FZN0tUUWd5WFZHcGFOL0trRFpX?=
 =?utf-8?B?NTZzc0JyTms2bCtUeXJ6cGp4ZUdURHVUbExiNFdTQzlmSHBSY25VT0hyWTJB?=
 =?utf-8?B?cHBEQzlzSDZHVFFCL3JJN09yd2pjYkJDRVdDQ3F2QUNtd3pxVVd0N2E0NGxz?=
 =?utf-8?B?M09pMGg0UmhNTFZyRFpocU0xRnF1eDRTbkR2VTZROTVaRlU2Y2dhenlma1Bj?=
 =?utf-8?B?Mk9uK1hhaHNUc1VlTEF0YU10Q2FqV21RdHJPN3gwQWkzTnlyR0U2bVpvRjA0?=
 =?utf-8?B?RFM0Yk00UmIyWjlxMkY3L2VmV2NoeFBnSWdFRTNXVUMydzhGTnRZaFE3M0ta?=
 =?utf-8?B?UDFuUjUrWEhhNGNLM25vNGk0R292U250aUlUTmVuUGNkeVkyQi9WaU5DSDVC?=
 =?utf-8?B?Y3NnM2t3Yko3bjdvYTMrK29JMFNyQVBSWkpxMUlnL0pycmlSUWtRYkhHeXBB?=
 =?utf-8?B?UUd1MmRYWU1Na1B2KzNHb2lXZGhCMTdvUjNzcndLdnJDZjYyc096YTcwQTF3?=
 =?utf-8?B?NkVDanNuVmR0amZkZFJCSWRxVDBnRWR0RWxITHZlNWlKM0hXVHEzSUF4TGgz?=
 =?utf-8?B?Mk5EY2c0V3pmbm9ZL01SRHBwcjF1b3JkdEZsU0ZBY2g3cGJpaDZ5MU15aDBi?=
 =?utf-8?B?OXRhbW5WU3Q2UjZHc0VHazdKZDFFWFVaSUZ1M3hHZm54SjZVZjhheTFoYjJC?=
 =?utf-8?B?K3BlRERqeU81MHp5QkovMVA2bG5UOEx2OHNzQkExanZ2VEh1aG1ORFdYc1V6?=
 =?utf-8?B?TStISjRWZlQ3Z0JBRkZXV1NOTk9yNnhPbUlkaHlMUllMSTViWVAxUkptLzFM?=
 =?utf-8?B?L0VWWFYrNWF6VXB3eVhIZGtENVMyWS9TQ2xzTTZ1K3dUVHRrbm5wZHQxRlBj?=
 =?utf-8?B?SlFjRjM3bVlUMFQ4eU5IVlllOGtOa2ZrQzI1WEtwWHJXTmtjcTREZTRQWGFS?=
 =?utf-8?B?TGVRVVVINWRTMFdUWmlCM1ZRTHVNL3lDQnUxaHV5d3prWHNNZVkycDJHN2NX?=
 =?utf-8?B?MHRoNnFsU0NldThubHRzKyt0R255TDNuc3dqYXRiQ1pldHRsK3dyYm9ucWlL?=
 =?utf-8?B?bGVUU1cveUJTblc4Qm4rNDZTbm1NWld1bkI3ZjcwcUJLS2JiVzl6a0huNE1z?=
 =?utf-8?B?czlsd2xCaTVrYWlSY3pCV1RlQzBHVGcrNzJvcStvc0hMUTY1TVYzbUY2N3VG?=
 =?utf-8?B?MS9nRkxHbWw3cVBBaDNhQXdWS1ozUklwYkhnVnRSVXU3ODRpVFlUdnVBcHdQ?=
 =?utf-8?B?ZUpkajhld0JEcnY5TjBudXRFbGZRcFFOVTNnVXJpREc0S1Y2Q0hpc3ZvYUxx?=
 =?utf-8?B?bHV0cFFxNXNrczBHV1VVZG9lSkcremJRN1hJRmw0N0dURlcvQUI1QTJra2VB?=
 =?utf-8?B?bWVDWHVtbGQzYjBpa0RtVnB3cjc4ek1tV2FtYWtkMFFlNWlpcG1yaWNycmFp?=
 =?utf-8?B?Q0h4dllZM1orRWZwTWF3dnRBZjRFdlZnUWU5eXNzbnQxSkF1SVFOVndINDJi?=
 =?utf-8?B?ekFkdzgyMTUwV01BM2RndFVpWmI0WUxyay8vbE5aWHYrN1ZqYlpxNnV6Um5Y?=
 =?utf-8?B?bE15T2xPUGkvL09hOXpJYmdzV3BQNlp0ZFBPckdyc0krc084dUlUcmpscEpv?=
 =?utf-8?B?b1lZK3hXVGlGR2JUaFhlc1dNcU8wWGRvalAvVzU4UWxCQVp5bTdOZVArMkZH?=
 =?utf-8?B?aDlUNWtUZDVWT1MzYjA3enRDNWxhRTRhUWhjYUVvb0VxYmVNVE5vNlA2Vm5r?=
 =?utf-8?B?ZlFtNWxGVWdyMVNNeTU4bGI1bDU5VS94NnJlb1B2ZnBPOURLUGkxZjJxeG1N?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba751fdb-b82a-4552-85f0-08dc6864683f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:52:43.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyXXxrjkGI0IzukJsq+Louvh/SEFB5QUYpmOxDh18n1w5Bv9qRPYFEJxB/jI+Nm23So6sb/ps/njfB9XQW7vyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 15:52:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15783

On 29.04.24 14:06, Jan Kiszka wrote:
> On 29.04.24 07:24, Rakesh Kumar wrote:
>> One of the changes is DEBIAN_PROVIDES, which is required to
>> resolve the duplicate Provides problem in secure-boot-secrets
>> to ensure that the build process completes successfully.
>>
>> Signed-off-by: Rakesh Kumar <kumar.rakesh@siemens.com>
>> ---
>>  kas-cip.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 2c3c8b0..b098dc0 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -22,7 +22,7 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
>> +    commit: 55833bb33a04fc93eec1c325ee72c298b5bbb802
>>      layers:
>>        meta:
>>  
> 
> I guess you meant "PATCH v2" ;)
> 
> Thanks, applied.
> 

Dropped again - we need to resolve the duplicate provides in lock-step
with bumping the isar revision, or the build breaks in between. Please
send a corresponding patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


