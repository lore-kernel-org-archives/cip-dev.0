Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F6E94628
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 11:28:54 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17613.1770722929774426753
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Feb 2026 03:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tPp9A1Dr;
 spf=pass (domain: siemens.com, ip: 40.107.159.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi+Xd+7Z3xeUOWmiiqVk+zASSZcvvkjMN8x1S6kORUkrugFHTqijt08RMM8un4wWzgBF0znh7i6AEDy3a9C9vhMcPXarAi8rD9Vt5aq8nHaCA8XbrU2Bg+0ZeyIwR4Moy9k4Bao8dI5+GMT7MNgNlvV0RgIczVQE3Vt80/96hb+NggUzrkVVBg5yVEmPvzGKlfUzKCBYZ5cQo1xgPnLTUcNHKWBDya9GaA2Km1hZMTczw5OxN9XpXcq74X5HzhB7rAh3bqWLyKxidcBvOIjN8Qq2kr5zz5BDWMwGgH3sdYf4G+CImJztAxucjVCihDTOFDec6/N3Qj9Dn8lpzbW8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae5xvEbyDHnjXDLzuzxxwvWzrka/svSwL7OtE+w2Jo0=;
 b=gz0s4Ys+3jqWQbbDN78crt+/pgAe++PR2pfszc4AdrTaaJDR2TIye22adeTtj9qAQiEhOAANeBAcsP/pN73X6icXPq3wn2oJoIS8oVwwEJ+5vWuHCGZXC9IFwwyxxkBqw2eQcRjwkFRup6xzjOJ4/OzoKnOC66w1cJBh7lRpAfGd2prALnH4fRCgS04BKC6F4du3t2jIyd8CSA9funjEQP9tJjvViUXAmO2XbE9fRZuxrtN0qM2f1WWPnvOvK3ZXGE64aBZsi8nKCiP668Qsx3Ex5hJLCbAR3Q5MxvbCC/Q4+CHPCgtB5cszxHgSlpWdA94/COHZRCcd9/g8XVwOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae5xvEbyDHnjXDLzuzxxwvWzrka/svSwL7OtE+w2Jo0=;
 b=tPp9A1DrPpGXwJGyBzxySEqgB/tSMJXgC57UdfpSyPQbwwRAr7d/KWOENgRfHOtpPrv7tnKwE/E5J5tkRGGVRIpIWDIMlOcFJH94AWnV7hT5URDmN4q9CSs8gB5e93UZ4Zg2yT4VqS8h2Iw4mg+tAl11VV2FQPkljvoF6kjgymFGInWIModdICtiuKpiP4g6/uGkD5bIlFPdoiAzE/WaSE24CGoG8FdGMdbTWBvQT1Y9+uBlJNbhzrI7plaDyG7l6i8nFY28fnZiJm3X+KoIN1M4sU2Y2e8vWe/twEjjNTWzrwZTaghvtEUBzxd6mmkpgyjqCGQFcuWSfbkqcQre7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 11:28:45 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 10 Feb 2026
 11:28:45 +0000
Message-ID: <377c16c6-c735-4519-a933-b7030001838f@siemens.com>
Date: Tue, 10 Feb 2026 12:28:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] doc/README.factory-reset.md: Minor
 corrections, verification steps and what to look for during factory reset
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 koshiro.onuki.h55@mail.toshiba, kazuhiro.hayashi.f74@mail.toshiba,
 quirin.gylstorff@siemens.com
References: <20260206101504.239074-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260206101504.239074-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: c262616a-8e55-4f46-47dd-08de68978d39
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MjlmVWhJQXZvT05Hd0xacWNlRUdKNVE2aUFZMklRMHFlRENvU0NMZGhrc1dI?=
 =?utf-8?B?Y2taQnlEQ1R6YnVkTzZUeXNwOTVHazNwYTY1V0FoenNWd1BHWEhXdXNndXQ0?=
 =?utf-8?B?Z1RwY0tYQlU3a1JDdHVudW95b1pwYlEwcUNWUkMwZDVZcGlYWXhEMnh3dnJp?=
 =?utf-8?B?bDNMY3hHaWx4cThldXhadWFTU0RUK040QWNxeFpjK3dlSkVFbHJ3dmVBeDNw?=
 =?utf-8?B?NW9RcUlNZjBhVXJJbm0rdDQvT0t5b0VFRTFWSWROWldhN2FZdWwwQ0w1OFN3?=
 =?utf-8?B?WlRTQlB2cWcxcGlNSjk1Z2ppcW5BeU0wemx2Q2FyWWtZQUhEd2ptUUxSRGVB?=
 =?utf-8?B?MHU1S0czcEV2eEVENkhqTGNtakVnVGttazAzQkJrSjNzWUluQVFOemd6aStL?=
 =?utf-8?B?clNvbGxuVFVjVk9LR2djY3JaSnU3YTBRRC9XMlp0RXA1N2xKZ09uYm1Bc3Rn?=
 =?utf-8?B?MXhiU29wUkw0bW1CT2ZHU3ZLY3ZRRTFkUG5YMW5SZkxZUDVTWlg5bDg3QzdJ?=
 =?utf-8?B?RlVBVHArbHZRT0RYMms4Vmh4dlgweDZMajc2QUFrYlpjRGJyYSswVDhjWEV0?=
 =?utf-8?B?a1ZUYVoxM1Jkak8zbC9KS3VBTG1WVklDNTFWOFZDckxMWHE3cnlENm1nSmND?=
 =?utf-8?B?U2d2RHB0NTlxQThkWDVKK25UZC9uQnFUWGVNY3R5VnFhSGJOZ1hDZkhQTWll?=
 =?utf-8?B?K2lQVDllZEd5emZsd0V4VzJFeDVoTEIxTkNpa1IwdWZzaC94UlloQVViZEM2?=
 =?utf-8?B?ZzI3OW9wTlpCMEx4czFNZ1EwVzFQbEk3ZUVsZWJnaHpLVVMwalk3eVpaZkJw?=
 =?utf-8?B?Z3RjbWlseDErRnZ2RXhyUFN5QTFEWWNac3lFdG5Nc1Zxek1XbnMra3FDaytq?=
 =?utf-8?B?T1lQN09rNCswbVJBU2N4NTNxd3dDK3V3ZkliZ3YyaElxZU81MStVY2pNVTVP?=
 =?utf-8?B?TEg0R3FpSVNCKzdKdXpsWDI0bW1WWEhiSHd0LzZhUEliNjZMMG5wcmZpRzBT?=
 =?utf-8?B?dC93V1FKV1krdXNzb0lHQVltYyt1aFJ1elFZcWF3dFJXUDF6K05rT09hSm9C?=
 =?utf-8?B?UlRuWFBUaTZteC9nMTh6WnJLakdlMDdBNm0rek9jdWtSNUtCTVdQS1RoRlJm?=
 =?utf-8?B?dENlU2dnZDhFNXl5dHRSREFUSnQwV3FKd2pXWVkybTBjZlZRcGw4VHI3Q2pJ?=
 =?utf-8?B?L1RtbnFPclhlelhUS3U3Skc0SmVkQW9BTzZ4dGpPL2VtOEpJZENveXZpOE9L?=
 =?utf-8?B?OTBHK29TTGhRY2txMEx5R1MvQm5FRUlwcm9EN2VRdXBWeStha0t0cEVpTjFs?=
 =?utf-8?B?eHJyVUxObHdBL0pUVm5HY0p4SEp3MWFCVGJrRDQ4UGVIVTQwa0V4ZHphMEJ0?=
 =?utf-8?B?SGpNcmpZRTV3Rkh4YUtoV0pSd1hRVUJjSzhUTEU4WTRSSkZoSytuVkkrMTRG?=
 =?utf-8?B?MjRpQ2RLTEcvRXRKeFk4czJSa0FtZ045TC9UVWJKYzdZc0kra3FMYnlVem4r?=
 =?utf-8?B?UFBLazB3V255d3AyMzJRaHk1aEprK1lIcEhPZXg5MVBZdzllWHZoWnU3NmVy?=
 =?utf-8?B?cUQrYjNKWStzcUEyckFGWjM5K1QwOWlCSXpwQllLNUpHY05INENFejZkT3BE?=
 =?utf-8?B?V3k1VjRsemVCL1hIMlNDSGlzMXM0Y2NZQkZ5bHNEcHBFRTB2NDEvejU3QkNn?=
 =?utf-8?B?ZHdMTmpkelJWdzJiQlVzeGZ3MGxuZGc4ZUhvd25STjVmQzRrTVFQUWdIT2Mv?=
 =?utf-8?B?L3d3RXk2ME0yZDI2SjV2ZWFhaHYzRFljc2ZzZU9IYW8xbWE4aCsrUEpLMnRh?=
 =?utf-8?B?cDRYVCtNOG1jU1hHY2pyWVFrbWs5REFsVkFKTG80OGUycm5xajJJZUNmOWdh?=
 =?utf-8?B?RXBoVnNtNk4zVjVnT3hKcjBsU0FEdHV1cDFNL0tMZkFyMzhIb2xtZzQ2KzdU?=
 =?utf-8?B?aXJKN3hyazFldmU1cEhaNFdZeGk4YmtRTGlTWWF3a2FmbWM2UTZZZjJjYzVn?=
 =?utf-8?B?VlB1REM3QkpjVW1tSUovVkdxcUVpRjcxbUdzakdMSENGWnJ0QkgxTFBZVnRh?=
 =?utf-8?B?OElmV1pBOElxWGtNQkFocys5TWh5ZFJaUmpycE84aFo0ZGhnQnpEV1FNRHli?=
 =?utf-8?Q?81RE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEN2aVhhbWhBZXgrRm83cmJzRkRuWnFaRDN1VDVoY29ZakN2RWRHTTlNb1ZW?=
 =?utf-8?B?VzlOTEhwYkpGNEs3MisxV0pzMTcwRDVUay9weEIwTE9CSkZaSFlCN2w5WWNF?=
 =?utf-8?B?TXg3K1hENjVMNTFaRS9MVlMrcUtWWUxnZHozR3M1MVZyU0NHZU1SL2VjVWZQ?=
 =?utf-8?B?bjdGc3RJNE10a2ZqMzZLdklyUi9HdEVGRWtRZERzZGxSeWJQN0hTa00veEt3?=
 =?utf-8?B?VUw3WlUyU25uWGZUTU10b0o5bko0SmNqVlhiU2ZiNktWVDU2Mm1oMHNJZUJ3?=
 =?utf-8?B?a0xlOUhsRjNETUxCL0M1UHFndTBEU0xhdmJVNXFUREhPdCtUaDcyZFFRcGc3?=
 =?utf-8?B?QjJxUFJYNjZWbFVBRVR5MmFZOTViSXo0czNYY1lHVDgyZ05nZnZ0TWN4N2Jq?=
 =?utf-8?B?Q3N5QXI2UTI0QStEOEhDUkxyNjlnaFF4aklsUTZ3aHJvMERNL01jTWN4QmVu?=
 =?utf-8?B?OGpmS1d0bHI5NWFUbHpLS2pUcTVlMlJ5TkRvR3RtcHJ3ZFdrSE1wdVYzK2sy?=
 =?utf-8?B?SVEvU2dqNVNRQU9TL0M2cUZ3SVUzcDRQQVFNR1dEM2lxSFk1b3lKenNZa0l3?=
 =?utf-8?B?eXVmWTByNHAxa0ExbURiNStNWTJmbHN0QktsamovV0pRY2ExVy9MNkxYMkhm?=
 =?utf-8?B?eitwNkd3SWtITzNWbXVMRmkrWTMwa0tsTE1ObjNFTHNMajhaaC9RK1JiWHhT?=
 =?utf-8?B?UzlRMjFYS3F6MUpLZlNEbk9NMEUweWVXK0RiWUJySVlKcWZ2dkdXMjNlTXRF?=
 =?utf-8?B?R3lTeFM4akl6dkNFQnEzSEVOMEI1bzBweHlxZWJtOG04b3o4ZlZ6UXdvUlhS?=
 =?utf-8?B?Ly9mME9nMm5HZGtnNlFyR3lJbmtnaEpPbmxGb0dGTVh0amZjeS84RHJVRWFr?=
 =?utf-8?B?T2FlVjUxYVdtTTkvTkYvQXFsa1hvVVRMdGY4dTQxd3VnR1hzMlpSVlMxVGQ3?=
 =?utf-8?B?aWpSRHUzbytiYnQ1d3NyRzFGbHdWeEZmSnNGWXJhbnBJaGMrTHlWN3VQQ2RC?=
 =?utf-8?B?U3lHTGt1Qk1GeWdTdVNlbkd5YmJ1b01HQi94OE1aTXBHeTBncGFYdDVGd3dP?=
 =?utf-8?B?cWM5bUs4QTdub0ZaSDcxSlp4YWExQytoSWVZbUxqcTdmS05kdDdKYyt3cE1i?=
 =?utf-8?B?MXZIUkJBbE42OWphaGk5cUh2UmRCbDQ3UlpPS1Q2MjMrVEt0ZU14MlFTTnVH?=
 =?utf-8?B?cWhKUjFFN213cWRuVFJDTUR3U1dkRHNlQ1FyR0MzNDNTS0h5MGVxcCt1Smkv?=
 =?utf-8?B?TzZMdzR3UzhtL1RQVzUyaEpyWW1SMStMNGRRN21xaXNIN21zb1JvNE9UVnNX?=
 =?utf-8?B?MzlSUkNNL0pQd1ljKzA3QklseGRIM0E4Q2tzYVM5SnBIWWJhdWc0Q1RUak9x?=
 =?utf-8?B?dGVlUnBQckJLY2w2ZUQ1UG9lTVd1bTdKS0ZOaStKWXQ1MW16Y0NHKzhLMmdR?=
 =?utf-8?B?V1h5THRxWEYwblA3RlZLd1JtdzVHeFlGbXpobGxaR1ZiLzA4WlkvMXR5QnVM?=
 =?utf-8?B?WmI5VEFwTExFbGlNOEp2OThGc0ZnNGwxbXFhdVNjamxwbGxRN0tvYWJLTEV5?=
 =?utf-8?B?V3lueUIzK09Bc0lZUEExWU9CeXNaazZsT09JMExTQVhrVVVlVHdmeDN5ZnZ6?=
 =?utf-8?B?NFZYWldpVitBYlkrOUxySzVGRjhaSWRpYkRNcDVicjZoNUlXTmcvbEdSWHJU?=
 =?utf-8?B?Nk5XN3o3OXZMRzJ0TG9BRjUwa1JSdGxIMlpLNlJjSnZlRVFOUTBuV2pvNlhr?=
 =?utf-8?B?UWFjVGRUWGY3S2FwbXVySlBucTJYSThiR29rdWVTRXBXeXJMTU9sMGpCM3Fx?=
 =?utf-8?B?ZFh3TFY4N0wrQmxIVW1EVnlFWEwweFlHNjdzQ1BOSW96L3NmVWFIVExjeGsy?=
 =?utf-8?B?bU1nNFhqVWV3VmZHNFR0SUVEbTBkMHZIUWs1T3hIRjIxNWd2VXk5dnk3aWdy?=
 =?utf-8?B?c3hyQmt5eHlZUUlPSGhhdkFNNHFzcmdFWk9ZOHEwdytLSjRrNkNZblFEaUlm?=
 =?utf-8?B?TFkvUVk5bSs0aDhlVHEvWlFocGpONzhLNHFRWW9OSlhxTTRiRXJlRFp3ZGJG?=
 =?utf-8?B?aFhHNG1WSXdPeWRhbjVaeXdCNFpycFYzU21oOUlSNk1qTzdtbFJNMERMSGNH?=
 =?utf-8?B?ZzZCK3hRQ0d5SHdRaXNpSE5wbURGVXUwOTB6QW9qMlRHNjR3TVc0WWlWZjlz?=
 =?utf-8?B?QVFKV3c2eUVYVVdIUHNBd21rSXBPYkZSblBPb29MaUxTTTVkT0pQQ3RBSVpG?=
 =?utf-8?B?TjJKRUdtWkNRRmE5MjQzeDVyWUtGdWFCRnh6QUkrcHM0NEpuUjh4VDdhQ3Fl?=
 =?utf-8?B?aG8vVm9ZbTRISlZjc1M5TnRsL3RXNWlkMVJ1WDBFOGJERlY0emwrdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c262616a-8e55-4f46-47dd-08de68978d39
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 11:28:45.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUQiP3x9d/xLNlzy5rcqj2/aiPI4CdzReMOIlBPQ6Yj9/56BqVumQx3U9YYbJ5mOCj/PqkvwTvFM/4O2nVJbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 11:28:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21853

On 06.02.26 11:15, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  doc/README.factory-reset.md | 40 +++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
> index 729912b..aa8dd1c 100644
> --- a/doc/README.factory-reset.md
> +++ b/doc/README.factory-reset.md
> @@ -1,18 +1,18 @@
>  # Enable Factory-reset
>  
>  To enable the factory-reset functionality the following two elements need to be installed:
> - - initramfs-factory-reset-hook which executes the factory-reset
> -  ```
> -  INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
> -  ```
> +- initramfs-factory-reset-hook which executes the factory-reset
> +```
> +INITRAMFS_INSTALL += "initramfs-factory-reset-hook"
> +```
>  - factory-reset-helper which provides the helper scripts to set the factory-reset marker
> -  ```
> -  IMAGE_INSTALL += "factory-reset-helper"
> -  ```
> +```
> +IMAGE_INSTALL += "factory-reset-helper"
> +```
>  
>  ## Technical details
>  
> -The by executing `set-factory-reset.sh --create` a marker is stored as a EFI variable or on disk (default `/dev/disk/by-partlabel/efi`).
> +By executing `set-factory-reset.sh --create`, a marker is stored as an EFI variable or on disk (default `/dev/disk/by-partlabel/var`).
>  The marker on disk is intended for devices which do not provide the facilities to set EFI variables.
>  The initramfs reads this marker and formats the hard-drives provided by the variable `INITRAMFS_FACTORY_RESET_DEVICES`.
>  The initramfs-hook will try to detect the previous used file system and will format the partition with the detected type.
> @@ -27,3 +27,27 @@ The removal of the TPM keys can be deactivated by setting the variable `INITRAMF
>  As the factory-reset is executed before the disks are unlocked in the initramfs, the file system type must be provided with the
>  variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of encrypted partition is not supported with the file based
>  marker.
> +
> +## Verification
> +
> +- Create a test file in a target partition (ex: `/var`)
> +```
> +root@demo:~# touch /var/to-be-deleted
> +```
> +
> +- Set the factory-reset marker with the below command:
> +```
> +root@demo:~# set-factory-reset.sh --create
> +```
> +
> +- Trigger a reboot as factory-reset happens in the initramfs step:
> +```
> +root@demo:~# reboot
> +```
> +
> +- Factory reset runs during the initramfs. The reset scripts format the target partition with the required filesystem. If disk encryption is enabled, the initramfs scripts also encrypts the target partitions. Both of which can be observed in the boot logs.
> +
> +- After the reboot, confirm that the test file created in step 1 is deleted.
> +```
> +root@demo:~# find /var -name "to-be-deleted"
> +```

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

