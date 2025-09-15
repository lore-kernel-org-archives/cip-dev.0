Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E6CAC58F
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 07:53:05 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.6])
 by mx.groups.io with SMTP id smtpd.web10.27024.1757922781740563298
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Sep 2025 00:53:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GI2mhRmf;
 spf=pass (domain: siemens.com, ip: 40.107.159.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNcjmPH2HX5vAmQiMSZy7Tpsi5J3StH36AFRafa104JuH068h3SYBXqyL6WgMrSASW2fma/5tJFfADmjKqAnTE4MxuX9tRyrGmotYT9lHkjhmyrUShb8FcCj3RtxKnzuK4UA+EhLfx/wsytBkM6cD5xxjiXwuaElwjJQQeeZMyJ3n1PEovfbwHrLHCPISa0c2h/lxZtr4sV8Q4CjiVQMGoXfNcktzAfwJoJKCP9cafeahU4hKWcySd3uqxCzkxShkaViNakXJjrpluLFV5FQxvZ0YH/VtC/zKmWS8pf1CC2qnuI+P3xf1vTbJ/3Z++c/IFF03ygZ0LZc5WjpwJioYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+nNr/BcmJ4/W2HPvN5mrpWDkURrOWqWkSb9P/hdpok=;
 b=Wcu384bJcSJirknFHm5rnDHQtt5o+3eklrbpA6WNUOhDrt20M7E7qJX3x8lhNltEeYiedt+9Iba8MnIR9rUnV0yW+cg4eR/9GHlaa26YUsnAA0mYby+A5femZsZPblzTy6POgMJfr9CKl5/Zbl8tJ0DCGzm7nzGSYk406Svb9AzMHP43Wam43ACtM2F2qbFWTEcgzw4542tC/jH86YpFSG/XIEi8xT0u3Zyod0E7B2B8TUK0jQFAUeCrw+eOXrXRGLju7GEsl8yMb5Q6ZUONAup/12VlrCuhuHe/y6pB9Q/G+qJzleSiIJJf/RpHEC140iPMG/2V5d1r66LMeXY8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+nNr/BcmJ4/W2HPvN5mrpWDkURrOWqWkSb9P/hdpok=;
 b=GI2mhRmfnfktrwW8aL9xPb8IkrTCA4wTfdnZTJeyXuVsg1ASrhukM8b+3OvF3aGIBETiwKEbAHnQKzCug9PE+1xsgvuGcVyY9UCQzLFr1CMTtA2Lu4Ij/8dO/t7vpPb/sBmwgz+k8KvO4vwSnzPhfXbG27ToZlLhpkhZ+NW4Q416bqJr/3Tvl2ru4g+LZGmEgKH42tlWHvm5btEILTpHaRr0oe6tAtpGT8bOztCZ6yPl1JhInTA+Jw+6m6uoTrQvhTT7K33mvyvplyeOjPZGZXbTIKm6Cbn3hKye/Qk87UgeI9KZX2VjdqV5W9LNv4tZDPA4c0sx3RirF1rOWcfiMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PA2PR10MB8652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 07:52:56 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:52:55 +0000
Message-ID: <09676e81-ab0f-4f98-ac5e-a9a1bdd51110@siemens.com>
Date: Mon, 15 Sep 2025 09:52:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/7] Add factory-reset
 information to encrypt-data
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-5-Quirin.Gylstorff@siemens.com>
 <f21857f5-b5ec-49de-b847-377403c7de94@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <f21857f5-b5ec-49de-b847-377403c7de94@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PA2PR10MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 20551157-9775-4dbb-f074-08ddf42ce187
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MTR0L2tBV1ZMcVVoaUVLL1duN1pwamZDaytySEpMQ0RRc3QvYlN4RjZ6akFU?=
 =?utf-8?B?ZURmL1BiSkx2YVlDaU9PcTRZSVlTSkI4UjdmYWFWV0JSWXFrZjMzbGlDL1Nx?=
 =?utf-8?B?bUdpVi95eUFKQ0VhK1V2cUJWWFp3VXd3cEVPZ2ZCOCtXNlJ2amVtbkI2RTJt?=
 =?utf-8?B?bFppcXh2NDlpblg3UFdNN3ZTWCtja1VsZjY4YkJzVEloQW4zL05XQjNSNDZH?=
 =?utf-8?B?Zy83bERJSEsvYXo5UnRTS3hJMWpLVUtkVDhsTDlhc0xkQ24xOEFjeUNXR1hj?=
 =?utf-8?B?QjFIcmVsWWdHc3dLekhpazkvaHVJdVhsSDRrK0xvM3ozOG9xdUVGaTRja1d4?=
 =?utf-8?B?dUZsQThJWWI2bEFiMk9zOTcvL2wvVDYwS1RyYlk3OVBhQnVyTTRBcGpmaTJh?=
 =?utf-8?B?THNJS2N2N0dPK0w5WS9pcWhhdzZ3VEV6N1NWM1Y1T0pxbDhhUGpCYXprRCtP?=
 =?utf-8?B?cHRTR2VCMzNKRVhoRklLYUl5ZTl2QVovNTFFMWxzZURiRUxJY0VLV3NuS1k2?=
 =?utf-8?B?Zm8waklxOHdzTitGZkNIWTRXeElyWVZIbTNlT2JiSWNLc0NqSklQcDBwbzEv?=
 =?utf-8?B?TTRQYjJ6SDZ4R1J6dXRhODRDS2s0aXdZaDRCN3M4NitLL2czcEdQN2U1UjZw?=
 =?utf-8?B?UUpsRm5zRlVSa3Z6SWlPQWFQbmZpSGNWaWdpVkIvRnh0d0k2VTdqMXNIVnhE?=
 =?utf-8?B?eTYzMWk3RTdjaDJxNUxJRVdEQWJ4Ylo3SmhBSnZpRjF1K01xSW5NOURiTWpo?=
 =?utf-8?B?a3lNZzNIQ1dkYWs5aThlV3kycnFMQnFxbFcrVVRCV2F5andyZFRhU3AwN2th?=
 =?utf-8?B?YTkxZi9FekQ0TVNsRUEzNlN1aXZldEk2NVZhMkQvTU1aQXZEdmdzTDliWTZI?=
 =?utf-8?B?MFVLTkQvVG5qLzFJRUhOM3YvV0lMSzgxb2hZc3k2UEhHaW40N0hoaiswZWhY?=
 =?utf-8?B?Z0J1VVkvTDYwM2ZwR0VucEFia2FHNnBiTHlrZ0NuUG1YME5Ma2EzU0c3VVRh?=
 =?utf-8?B?RitNdUdoY0taTzJacnNYSlN3bCs4RnhhREw0ckxxM1hEenRqcFdBQWVGbWRI?=
 =?utf-8?B?QkZCeUFiZzFXNjNxaG1US3VaNlhJdTVoQ1MyMDRHZHU0R0ZyeXVmVkRvOExT?=
 =?utf-8?B?b0tkNWFaYzJPbUpYVkxaM2JqNDcrWUN5K3M0eGFkMUdEQUhqdndvMDRWVDVo?=
 =?utf-8?B?Ykg3L1VFWFM4K2xrUzE5MTRmSFZvSG1yZDFtRHU5TWhYVVVwUGN2TGhmeWph?=
 =?utf-8?B?VGJJZk1EZ3AxR05WdW9ESlpEUWhVaHJvRndlWG9oayt2djVOeWE3Qzk0ZVFX?=
 =?utf-8?B?Y0ZsMWk0NktaMi9uUVJUN3Z5d3JJNVlnZm5KK0kveDBYM1pDMXJaZEZ3dFBm?=
 =?utf-8?B?Sm9lMjBBbW1BU3N1ZXRHV0hVMjAyNWZWeWNHVjNwVlErK2lvLzJRUUphVFgv?=
 =?utf-8?B?OWIremJlVTVVVzJoQmhmSDhMKzFjZlRLL0lTWFl3VThmSjlBVXpMaGNSSWJE?=
 =?utf-8?B?ZFNRMWtsNW4ralJNeWRCTUI5SkVQUGRxb3pYek1OZjRsKy9aZzJId2J6aFJa?=
 =?utf-8?B?WWJZSURuTzluNDEyMVNoNUxwVU91S1NlWnhHMHp0UnozZlRrQlRHMkdQSVY5?=
 =?utf-8?B?L1N3WFZYMlB4NnVpRnBEUzhaYVNzbVNtUkxHU05tZ0VuWjJQTXVOZmRLU0sv?=
 =?utf-8?B?T05TTHJKdHF6ZmV4TncrZUZ5Q2FlS3pBa0VRc1FFSFR3Q1V3d3VPMEdyOTdH?=
 =?utf-8?B?Rm9RQWt5K3R5ZnFUaVV3ckJPNDE1bnFRYmdkdHpQUWFrRFZGRVBzUXEvZmtK?=
 =?utf-8?B?eG1rZEtPeGtISWpIc1B4OVgraUhkSWpOTXZ4T09VQ216azRPcm40bS9KU0JQ?=
 =?utf-8?B?UC9uY3BaSCs0Wi9DWHhGNmRkem5SL09MaXNCOTFDd1ZpVUVkbUIvaWlIY1Yw?=
 =?utf-8?Q?VcrOre84s8U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDJ1YTBSRENqa3hMM3B3WExtMzRWWk15dWl6cDdpa1N1T2s1dG9oRzJGZTV4?=
 =?utf-8?B?Z3JiNGw3Zkw1RmMxSHlJcmFHSTJ0eWZBTVlhTGpYODFQaTVVM2wzQXBXL2xQ?=
 =?utf-8?B?NTR6OHhxMTdIbE5TSkFrNWtrWS9OTExOVGZZczFWWFFnN3l5emkxWjI0Z2ZV?=
 =?utf-8?B?aDhMdVo4TVNwQVhFY3V4eVk0cFBncTN5UW4wek5ydTIzak5FYjV4ZitIWmU4?=
 =?utf-8?B?T1pMVEFWeHRBMG94ZDY0d2x1YXdESktMbkVVZlJUeVVhejFvZVplcmxjZGhQ?=
 =?utf-8?B?V0dNRTE5aHVpb085V05SY3ROZERJSEtPbk05M1RudkNQUk9pOS9CWE0zc2sw?=
 =?utf-8?B?Uk55cFF6WWUxT1lDL2JPZy9uVHRBUXNXYSt1RTVNZ2NDY0VnVWpOSDJPR09E?=
 =?utf-8?B?YWpoMUk4TkJpYU42S0w0Q25HRVREVFhwSTQ3dFU1WHNpUisxbU0zZnU3M2Fi?=
 =?utf-8?B?RDN6MTBxL2pERHRvRytma1dhL3B3eUN6Ym5TVnROTUxXOHJUbHh1bmRIWXU1?=
 =?utf-8?B?cjViT0d2aEcrRUFkaVU5c1hmRmhkSmg5TFlFU2FEbERxa0Y5Y2M3a05Ibk1K?=
 =?utf-8?B?YzhPUWFmaEUwQ3hPT2FDcGwvSmVUS280S0c4Q3EzQzd0aWMyQ2oraGdJeHVa?=
 =?utf-8?B?bWE0UVJWczB0dDA5bmVoeUhLbUtONnh4Y3h6SElLL1RmZWRsVFo0dlNjNWNz?=
 =?utf-8?B?amZqOURuenozYzdyMUh3a0dJOGdXR2c5MFh1dno4NmFqdUZoYmt3RjB3RzQ0?=
 =?utf-8?B?M0lrMWczUEZMSWFlYTROdXduZStXa1UxWWZPVnRXY1dWVXRzbTNobkt2NWdT?=
 =?utf-8?B?T21vSW1USlBtZzZiNDZzRDhnL2FjKzgwM1MwYVNackFINjY4aklVd0NaM3kv?=
 =?utf-8?B?UitsVFFEK3oyYWpIdFN2cUNpaHQ5eHIxVm1FK0pBOVoySkF1SGM1NTArcUZp?=
 =?utf-8?B?R3kwOERJd3o4aUxodXlYT1F1TEU1OWN2SU5TNld2RU1TcTk5VVg2MmFiRWUz?=
 =?utf-8?B?KzBzd3FYR2Q5TDNVTWp5VC8xM0VVY1dhczVRTUF0TlNFWit5VFZWdnRzME1K?=
 =?utf-8?B?S0lqVldhandqN2JJSmZGbUh1NzZJS20yNGpqZys5SnkzbjhkRlUvaEgyUklS?=
 =?utf-8?B?bkJIUFBYT2VwYm5YUzR0TjJhZFluSlA0NmFUb2RROHZyODU1T3k1bi95RWJW?=
 =?utf-8?B?S1JKQjlNSDY4a2p3aENOcS9iLzViNEJIeEw1c2gxRG5Zc3pubkVjblgzT1V6?=
 =?utf-8?B?RmhBU041UHpENTZpUU4zLzlTQkRCYytIdmlmTkYvbzVJTGFPdm5Vd0JpenY0?=
 =?utf-8?B?VGErbjZudmI1YXk4QVljekZtQkdKU2s4MS9Ea2l4dE0ya1BKc284N1BmU0dK?=
 =?utf-8?B?Z08raXNxNHpCMXdvT3B5M21RbGp0ZVFEVjVJLzdEYUt4WXlEVlc2aEx1YUt4?=
 =?utf-8?B?NjBFZkJRcGdNRjl3bVZVWWZaUEpMMGlkKytXNGVYaWI0amV1NWtwWC9vQ2RZ?=
 =?utf-8?B?ZlBMMmtxdFhxanUyclk3d1BWQ0J0NlBXdzgxR3ZzUjJHVEJyVkZmNVdNVE1k?=
 =?utf-8?B?OHg2Q2lsMUt1UjlHNXdNZVZRYlp3QmZGYTNmK0wrSVV6ZmZvY0QxZjFsbTha?=
 =?utf-8?B?c0VHWVhKaTVLUTVMdXdrd0pOZ2MvZnI5UnM4b3ZSQ1JYMnJoVy9ST001TVdo?=
 =?utf-8?B?WTUrVWRrNkk4TGt6Qlc4eFg0SzJyZGcwOUpxV3RuWjd4ZTFkWHRGUFZKNVhF?=
 =?utf-8?B?bEdYVEwvbm9HVGdTMWp5aHdzSjUwMTd4TWlaNUdHYmpZOVlNUE9OZTJwMmFC?=
 =?utf-8?B?cVRTaFg3dGJqUlI5VnYrOUxkSjFNbEFTUDl2TXRDSlkxblIvakJaaWJvNTlH?=
 =?utf-8?B?bTkrZEVIUXdMUk05S2h0bmVTOStUbEdPQ0tJZ0hVbHc5SzFzemFOTko4VndG?=
 =?utf-8?B?dStKN2lFQWJLblRmdW1aeW5WVkFpcGV1N3I3UE1neHRRMHNySks1L013WktD?=
 =?utf-8?B?elNSQmJLcXZ5Z2piYzREdVlSK1h0Mm5sRm5OZXBIMWNLOW9YSy8zSFc5dHpn?=
 =?utf-8?B?MHprOTU1NEdvaUdFbldwM0pibFNQMis5ZzhZNGRSS21Vbnl2SWFUZHpNaitq?=
 =?utf-8?B?eEltZlY0UjloQkRuZ2Nvb3RmV3NmN2Y0YzNRd0RtQ01ZNXFESERqZ3dVSDAz?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20551157-9775-4dbb-f074-08ddf42ce187
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:52:55.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weKj1ja3ZPi0t8JMPbEPrHM/W7+GiAUtbFsccvl2GXjZEE7dfjiJ8pMsu5eF+r3RXLQeOAV4Y8AJ41lcGSfRTcsb7KtYfTsXe3IsvogjwI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Sep 2025 07:53:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20050



On 9/11/25 18:22, Jan Kiszka wrote:
> On 04.09.25 11:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/encrypt-data.yml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kas/opt/encrypt-data.yml b/kas/opt/encrypt-data.yml
>> index 3de76ab..4292d4c 100644
>> --- a/kas/opt/encrypt-data.yml
>> +++ b/kas/opt/encrypt-data.yml
>> @@ -15,3 +15,6 @@ header:
>>   local_conf_header:
>>     initramfs-option-encrypt-partitions: |
>>       OVERRIDES .= ":encrypt-partitions"
>> +  initramfs-factory-reset: |
>> +    INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE = "/dev/disk/by-partlabel/BOOT0"
> 
> Hmm, it should ideally be the currently inactive partition so that we
> are never corrupting the branch we are sitting on...
Then i would need to maintain some logic which gets the current boot 
device from ebg and use the other one. I would prefer to solve that 
issue in a separate MR.

I could also switch it to /dev/disk/by-partlabel/EFI but this would not 
solve anything.

The best solution would be to forbid encrypted boot without writable 
efivars should not be possible.

Quirin
> 
>> +
> 
> Extra newline.
> 
> Jan
> 


