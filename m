Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E0E7719F
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 12:14:06 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web11.15662.1736770436201314720
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jan 2025 04:13:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HYsqI2RD;
 spf=pass (domain: siemens.com, ip: 40.107.104.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8+qulMpOkG1ClSe1NAgi8CPp4XwXnYcodUNdGnp6Th/0zrT8P5kphPLXzSiXR33+3yzqIGWRfL8m4DRaXvLwkzJLS1TA+9Mh3QToT7Uu8v7MesVjBgW5yVEl3qqli+Ec06kTqRubX02j5x5BhUt+HBN78toltFwaJqq/ikjEzxRvO5qqEOuN8js+W4TcJckoiOfZJZfVwpaeCE3JBuzOMl4k4p3TY+Fm14q0R+NwDTrhMBoqzJRvTjXUAvACzBnhUjWdbNpkzjza4IaTvvmo2DRqUQwZXe/RxOGeGjWd+hbhzj2DnyLLts9yGC+oiejhn4AsvACbuiB9bxHCG01bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixIlrtTOSdjzdZfq4UWUOQNPyTD20pPiaAnYUbgED5o=;
 b=SVedKwqcwKcA7yglZvS2dYAKhvNNT+MZCvDavvZheqmYANfciSPYLETlkzE8dGm2clpp/bNHSGMQ/Fx8jKyDTerC6E2Bb0pKmBFBjMV+CbHxitUOqsDvrYWoo2b2DYDIQbXN/X2GuQfaeqBRjb5fkANMgn75hOK81V1cBN8g5hig4WP8dxbPhIrhMhEldSeDVcG9hGMrzpGyEJe04j0r8i8qjREDsN7tmJhKbuiIiJEgoT0OO+mtSQidiBBLSBTj882AMz6vMIeIUC/DgLybOOzMXYW+WpTeU1iyZ6hGqTm2OwXbhWDwudQzSt3o5Za9ad5audW2OmCLpCEswnpnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixIlrtTOSdjzdZfq4UWUOQNPyTD20pPiaAnYUbgED5o=;
 b=HYsqI2RD58jiYCJPk6+qJMqH2v8TYZSLjORNFMvOYw0aaTMpj/LFRYmNmNIK6pzcvQUzjttfkhbTV8XhChOVn2vm+SW85chYfLJsHM4Jzc2qN3ynN0G6g+ui/NFRGH+JvVhYMkyX0CkSlsEPrTuIn7OXogQ5Gf7zsT3wreDJsSQwYWY+v2B2Uyx2WNI+68HXJo31vJMVPevpVbT0UoQMg5k41PRzX7sUMEqafdBaLAoEsGuohepSghb4DxZbCR5JX8nPfMMhN4FnKZ0dAAg1Rp6rVl4rlON2cduzTINT07tDIqdp/iNGghDZD/mScbpV8L6W+goql0XlOp0dYDKF1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7567.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.10; Mon, 13 Jan
 2025 12:13:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 12:13:53 +0000
Message-ID: <d9556cbc-fb9f-448f-ac7b-1bebc21639bd@siemens.com>
Date: Mon, 13 Jan 2025 13:13:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] initramfs-crypt-hook: clarify
 resize error
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250110165253.77676-1-Quirin.Gylstorff@siemens.com>
 <Z4UCKwNrHLXO7+V+@duo.ucw.cz>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Z4UCKwNrHLXO7+V+@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 199b55f0-9e29-4553-9c34-08dd33cbbf07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d21zWE9uK0RMNFQxWmlrUU4rZm9MMjl2RVc2VEd2TVMxQ3YzamNZdkFDNUpN?=
 =?utf-8?B?N2ZMaXN0eDRVaFBPREx2N3NKZG5XYlowNG5TNHhnVEFNNTdrcXBFZVRybTZS?=
 =?utf-8?B?djkyVThROFBWNUNqczNlVkNWMmtMTnEzclR5N3U5RklnTkNZV1JSWk5aVzdh?=
 =?utf-8?B?VklsNFpPY0MxU1lCNmNjdWRpMWJPbEZuVVdsUWpLbU9pc2xpdkduaU9jRm5M?=
 =?utf-8?B?Ums0U2RTZ1NFM041OU1XTmpzRU9zQVF6WlBpcUdsYWxYK1dtMi9ya0JRYlRT?=
 =?utf-8?B?VGRZM3RKd2VtZENZNkFuQ0ljbDE3VFpxNnVwVW91Q3RFQTd6MlM1Nmo1VWpL?=
 =?utf-8?B?L0I1VDcrZ1k3akdkemlDZDY3MVhBV0IvR2M0cXM0UUVwWFNncklmQjJFaWZh?=
 =?utf-8?B?Q2hYODlNekFVbEZEV3lHUVFubldRcHlSSEE3QS9sYzVxOU5sWXhqNTdEY2tV?=
 =?utf-8?B?dERrUy9BVUZhNjJuVng4dkU4eTNWdGdHL2lWQXRrSjg3REZ0Z3N1TVRFWWVo?=
 =?utf-8?B?Q3V0TW1veVA4Y2x5N0RLd1BQSDFTZjV1K1ZyTzRZaEpQbXlxVzhBQVN6OVNS?=
 =?utf-8?B?VEFEYjNpTUpnaVcveDl2aHFQN2J6Y1RhOW56MHdTanJhdDZIdFZmcTdoZ3Y1?=
 =?utf-8?B?djJwS2NHYXJ3TDFRQjdjaVl1ZTdaRWQ0TTUxQXMzMHZ3UlRvVDRtSjlxeXJC?=
 =?utf-8?B?eXlBanRlUzQ1SURYZk5qSzY3ck4rbFpncGZ0TFkrUUQyTjEzcExhSmFwcHlr?=
 =?utf-8?B?bnBwUkM0TWtCb0E1NHV0OU1hdjh0dWlrc29mekFnUWt3WlRuVkx5cjVNSzRE?=
 =?utf-8?B?SEFpaWhIay9MVmRndUZvWktGOFN5ZGFUWE04Y2VJU1UrZ056M1dCaytxRUE4?=
 =?utf-8?B?bWJZTWgyOU1SbzhSdWVpSXo3RDhXS2FVbjZIQUJTcFdoZ0FvV2tEemN6elF0?=
 =?utf-8?B?OEw0ZEZlK0NwdENFZXNGU3pZL29LZU5ITHN3RU10ZlludFV5NExWcHQ0MFRV?=
 =?utf-8?B?OHdJZk9rWEEyUFJSbzY4YngreUZqY2pmR0dHYVlZTGJLaUk5c0h6a0dVdUVR?=
 =?utf-8?B?TUpEb0wzV1lnTTFaaklqRFE1YSs0dE9PdFdpRVZUbm9iRkl6WTZqTXhxVGd1?=
 =?utf-8?B?L2hOUTRBNWdwYU9semdsaTUxKzMwY3JWOVpYaTFwbE12Q3JISHozMXhXMStu?=
 =?utf-8?B?a0ZzZkFkb29RelBxbmpwSmdaSTFSUi94dWlqb3ZLRlZWdDlXcDhreHJZTlJm?=
 =?utf-8?B?ekhyb054ckhtd09lazA2ZlJwRUVhbG9ZM0xUMFNzaEhFWnFPNCtQbGd5alpy?=
 =?utf-8?B?Q0NhVlZSOXVCSDlKUGlTVi8yYUhudnNmbHF1U1RkRnAyaUYyTWpVWUx5OGtv?=
 =?utf-8?B?WDRkYVpkZUNYT2plTTRydXFyclFmelRXSnpDMmdsK0YvUnI5WnJWdW1xdjZQ?=
 =?utf-8?B?eTFuWWgwWk94RXBjdXdiamRqOEkydHBBRm5PSWpSVFUzTmxJc1ByK1Rmamlt?=
 =?utf-8?B?UCtMWkd2Z1BlV3hha0FIN2IxUFBYQlduMC9hNkVIKzBmZ3h3aU9wc2pzK3pG?=
 =?utf-8?B?dW5QQnBGbUJNbVBNb3JmbVFacFN1SkREYUlqNFN0c2JwWjZyQ3JQMXZ6eFJq?=
 =?utf-8?B?SkZVT3g0dFVWaXJhN0QwV0IyaGEwWXFaZHhKMCtNWnRlSjFhU3FLd08zVzhn?=
 =?utf-8?B?ajdDZ0ptY2ZCSnF5Q3phMVJqSFY3ZHVwZW5SWkNmNnNUNTRWSG1nWWQwcWp1?=
 =?utf-8?B?cXliZVFmbnVUMkcwRklYUE9PYUhpYnJDS3NHdkVOYk9vL3lNOWY4R0gxeWpy?=
 =?utf-8?B?V1h0RzdYRGg3eVFhS2htNVc3UWRmSFF5Rm55dC9oUDh3SDJkeU5tR1RMSStx?=
 =?utf-8?Q?21b3b/9AezX12?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0tJazJ6NzFKcHRheUVHN1M1M09DeHJFdk1SRGN4ZVcyRDRkd3BRL2kvL2ZO?=
 =?utf-8?B?Qmh2SGlYc0ZwS3hlSUt1eXd3MWFKSENXQlQ0NU81MGJKY1llODhMb3JTRmov?=
 =?utf-8?B?YXgvTnBsMS9MSThjd2VzZS9VUUMvelA4YUhIK0ZIMjlkWDZnSlNUYkdWT3Fr?=
 =?utf-8?B?cFMrbEI5UjVmL3hLL0pQa1ZESHdPZGtINHhscmcvNEZLTTVrbFlpN0xvSVpz?=
 =?utf-8?B?M2I1dUw2bS9vd1BncldpTnpPR001VnRORW1HelNObE8xY2xMRm9YQWdWRmlJ?=
 =?utf-8?B?UUNrbnR5SVhUVklzdUc4NFFNUzZZRFFyQytNN1FRc05zdlJSZzdDMW0wY0I2?=
 =?utf-8?B?dFZYUmhZeS9xblpsdGZnQm9YOFFoOXpqTENmTWNYUGIrRG1IaGpPdzJhR1ov?=
 =?utf-8?B?cTBrR3RQRXpZenJjZUZMNW9GNmlEMTA1ZERPSnNTQmxNNnNJS0xkZVFVank1?=
 =?utf-8?B?SUtLS3pWS1JWemw5OVYzYkJienBxaEV1bHBQWFg4R0w2blgvU0JhYTRmeXIx?=
 =?utf-8?B?Z3hxM3J1aWREbVFUR3BUMXgrM0NScC9XWEJKSmFPTGs0eDhDbHlSSDhlSkcz?=
 =?utf-8?B?LzVzcVo3eHowNkZPZjQ2aTN1b1lLWEkxOWQxYytNYVhibzVzd1lLVnRuQlVV?=
 =?utf-8?B?KytJMXAyMFpjTGxyeFJIMjJDN1dFS2FSbzMydmsyZ2FtVlJTM2NSeHI4cGJ6?=
 =?utf-8?B?Vm5TMkQrRWx5dEdMTGIyaXh1djFMa3JBK1R2THNMaDlqSHJTQ1EwSk1wZ0hp?=
 =?utf-8?B?dklDWW01RWlmSkVYWkFvUHl5OTFqbWE0emRTRzVBTlpONk9CNGs0RlpaMkFJ?=
 =?utf-8?B?eEdUYUJMKzFWaFpselBRb0phZzY2UDBQdUE4UmZJTlRKUTNTQnlxWWx5aHBo?=
 =?utf-8?B?NHlLQlg4am5wMGRXUHZiQTdGTkVmZDJrZVJ1aDlBODZLTXRBdzlRTVp3NUN4?=
 =?utf-8?B?ajdVMDFuREdKYkRxRjlyS3FjZzZiVXhPNlpqMm15T1l3K1pYQTNGV0pYQjlE?=
 =?utf-8?B?RmRJck4wOXVPR1RTdGc4bXpVTWZNdXpXRHZBb0ZzQ2JWejV6UHZ1TlIya2ps?=
 =?utf-8?B?dEwxbHBMRGNWWHhycVYrNzVBZVUyQ01kM1VrbllZb2JaRzN2cEhicGlrSkpo?=
 =?utf-8?B?bkpxTVRoMStEdFFwaTJLTkRDZGt6TWYzWTIwVythMWhXbzZzWHZoK2dlOUdI?=
 =?utf-8?B?TkFBY01HZHVzSzZnOHBuemh4R2ErV2tsaHE0REgwNzY2Zk9obUtobkhGUTF2?=
 =?utf-8?B?VFBhSWs0Mm9IUkIvWEg5NHFHT0pSd1Z3UThPclU0WnZ0ZElXWVM4UkhOUDdM?=
 =?utf-8?B?a2pnQlBkcmExZHllQXMyMXFBSXl5QUtMK1JxS1NLTWU4K0VCQ05oRGlrdnFr?=
 =?utf-8?B?a2RTMnhtbGRkZkEzVE5zbmp2QWorL2l1OGRrczZ5aGRid1JTR25PWGRCNlJM?=
 =?utf-8?B?V1JuMytsOU9NU2J3WVRjMXNxVS9MdUUwL2FXcVNJOEpHc1ZnanNBczRQNVVE?=
 =?utf-8?B?TytSSzdaTXoyd2FaWE1UVUoxLzU4TTJPZGdqRE1wRTJNOHh1R3FLdGp0S1I0?=
 =?utf-8?B?eFF4cFFES1o3VGtzNlJDalhnMFFHWkxCb0Iyc3dROHp4NTlVY05wRDFSRXpI?=
 =?utf-8?B?UzUySFlid1V2U1JmVzJQVFFlWDI1bHg5U05Yc1ZtRno0UnI4V0tFUzdRVWZG?=
 =?utf-8?B?WDlSY2IvTlBha2ErbEdWQzBka3NPUk50amtFeHF1WnVSQndlNTNVMTE1UDMy?=
 =?utf-8?B?QUN6MERhNXhwMlV6anhGMXlWaCtDZHJYbVB5UzJUb0RzcG1MZXJKV1kybWZr?=
 =?utf-8?B?bHJOZ3RWSC9teDR6SFg0TGU4YjNzQ0xkYU5TQUdjQjlyY1VQYndTOERRNlY0?=
 =?utf-8?B?a0tEaG1hSDArZmxoOE1oZmt3cUw4Mk9VZk10M0FROGRiYURDZktLVERXTXFh?=
 =?utf-8?B?WTR1OTZsU1FhU0pKU3FFSkM3Y1dZRWFmNHY0LzZYbFdlREh1VVY4QW5idDhv?=
 =?utf-8?B?TWlPZHFxbExZU0FabmlLN3E5S0tOSXFjNzUwbjJreU5GMFIyTStnVkFNbm1v?=
 =?utf-8?B?VlY3cmMwSzNtd0dON2tIc09qNkF1VkpOOURMVzNLUGp5WTFCU25Ha2QxYko3?=
 =?utf-8?B?aU1oa0RxWVdCMGcyU3NDaU5vM085WHNHWndLNUh6ZURBd1dIcUV3SWxwRkpN?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199b55f0-9e29-4553-9c34-08dd33cbbf07
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:13:53.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdU+f0rF+V+2ycQoH9OQMLUp2rrXEg2yIAKjXCpRPUyUHdOAgNAfjNbpIo/jsqI65CwzZBh4iWoFszg8CwLTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7567
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jan 2025 12:14:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17534

On 13.01.25 13:08, Pavel Machek wrote:
> Hi!
> 
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Add context to the resizing error as it is was unclear why the
>> encryption can not continue.
> 
> or fstype: '$partition_fstype'"
>>  		;;
>>  	*)
>> -		panic "cannot resize parition. unsupport fstype: $partition_fstype"
>> +		panic "cannot resize partition. unsupport fstype: $partition_fstype"
>>  		;;
> 
> Should this say "unsupported"?
> 
> Best regards,
> 								Pavel

Makes sense - I'm folding these suggestions in while merging. And I'm
separating both parts via ','.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

