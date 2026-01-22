Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CCC44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:23:58 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34336.1769077433045334123
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:23:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=n1bFdAiK;
 spf=pass (domain: siemens.com, ip: 40.107.162.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/4+0EcowAWP1080DcNIGcdPlmary/0dqHCzAY8EFLEWArTmFzZHQlpyyH2vvo5zxwnBn/3DR4V4x+VAb7WTf1zNyMIx2QVuuS4nnd8A1E2Q3wi32Gyme6m6E58gSaQp/263e5ygTzRKhKvqHjE4MxoCdSbBh1mZBRIkuXjkF92YHy2qFnZP60eNmVrqutuibVRDSi73zOyzi3divOudDEBjX/xXw+Szdlprw+Kg8A9Fqf2QzwgaCG18K8yF6bNpc9KKR2NWizuRD3B/Eno5OYSwZKNygEYswYTZoyL+SLGG7tQEjt8swOTi0rpk+h2RH4eeOx7vJ5AnO4lTx0ag5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx8e+GBm+Fnn3bVqpjs/HpNrdVwbJT7eXOnwZ9uIB3I=;
 b=x9SVq8HJC7Pq+xh3+ahS5L4Nd3O3IT1QtiA6ZCfOoOn07rAGvil+SjANaizHwSvQ2VNdIY4LW9mFXrQIA+EGN0uOwUK1rDxSQwT43QzjzNhj3RbChZw+2i0MNW499/S7h6A4laUey3ofoahQu4jN80yeXjzmZB8agCISDor3mKr8VzLKfygEG48VAD90R6bv/1oUrDcKX/XRfs6bYdovwKr7jNrJ81MJ6KgSWVUwoT2qbO0cVH5wMZvOhO7Bq7IGcQ71HTeDHI+fb7igFCZneKjl1HhabOvS9VNVi0Zf8ORjvuvs4NU9o7GNZmGbiDVXb/W0kGqCC3o4n3ZuvEjlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx8e+GBm+Fnn3bVqpjs/HpNrdVwbJT7eXOnwZ9uIB3I=;
 b=n1bFdAiKcdak1V25pFqKmCbRuMLUswYY38wRrD0Bue+ZjgTjflKYjegPwnHfJbVHhkK40PbmZo2Vwyh5SLJGImyNiKwwe4pPQxa8O0zM5VwMlGxfjz00KhEkUbQA5jBnEeq9UlN8FBNe8zHUtAKwtAklrDYI8rW9e8w9IzKUURJ4JxO0bEfb4DdBKM1xEsL5aL+A6MsJzkBv7BiCrJxnpmDGDLV557/QQkS7dF4Uvn6iRHCPdD75/0oktzK60+pTXahdX4vHb3JmyeNdAoaEb5EGyBG9srf830Pp1cm1CA+q/1dCweYI2cqQjp1y9ehmVFjeC1pEKcH6tzWrpf54QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:48 +0000
Message-ID: <dfaed43d-2bb3-43df-b3ba-630215c77386@siemens.com>
Date: Thu, 22 Jan 2026 11:23:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v5 2/4] Kconfig: Add option to set WFX_URL
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 michael.adler@siemens.com
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-3-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260116120347.1733494-3-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0488.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 063d6dd8-b508-4308-38c8-08de59a054a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TUQrN3R1RUhtODhFR0JoTFdLSlpBV2xvL2t1NVAxY1l0eENuZmVpVUxOR2FK?=
 =?utf-8?B?RzVpRXdGWU1LeHhQa21xazdCMEI0VTN0cEw3cWJ0ZVdwZWhFVWlGSUFyRFNt?=
 =?utf-8?B?T3JzSVpmYkFNc0czc2RQa2tMWFhQVEFTQWtLK2llQ1FxWHJ0L3NzY0JwVjFX?=
 =?utf-8?B?dXhDZStUbnU2a3VMVk53WTJmbzkrWWdkaXo3Sm8xRGZrd0d4aDBhb052d0F4?=
 =?utf-8?B?YnVCWkNxYWw5VEhrMzBKUjVuN3BpNjRGQm5aRTB1QktPaHFMNXFoVVNuVEla?=
 =?utf-8?B?Q1h3ZDV3aWVDMmRWdEs1Y3d4Tms5emQ4LzlBR2NGVlArZWVpWGxFeXhHMjV3?=
 =?utf-8?B?QkxCdC90K3FWVFJVcmNoU2UzNURwTkQyK1ZkZlQ3RVhYVG11bXRJSFo1N1NS?=
 =?utf-8?B?d3VLM25qTTdXNTRNN2paWGxudTRuZ3RtUVJkb3o0bUpSeXZETTdVcTcxTkZ3?=
 =?utf-8?B?U0hEeU1zOHRSc0d5WUp2d0V3bHZWTUJCRW1qVksyMDZ3bzlnaEM3NUZ6T0dC?=
 =?utf-8?B?OWxHVDJndmU0L2ZOeDdyVUhUODhuTk1SUjF5VDNDcEZGeUE2Nm5vK2VHTkhC?=
 =?utf-8?B?L3h3cy9oMXFKTzRaZ0Q0eHk0QmJRcWt6T3hmWWlhNGZYQjBNTTVvYXJRWGZN?=
 =?utf-8?B?SDZFaDYzYWx2WldVdnYyMjgrSnN6bHBSNnRhT0laSWtVZmtuWEN4N0xmZkt3?=
 =?utf-8?B?SFlUTGZMb2t2QjRIK1hiOXVWZjZ3NzNldEowZjJDTEdwWmJOby93TzNJbEpQ?=
 =?utf-8?B?VmpGQlE2Y3NGR2ZVRmZidE5iY1Jremx6K1Z5dnJQckkwQ2ZuK3pnNjR4d1kz?=
 =?utf-8?B?V1IrZHhUKythZVBYekRFYWJ1MTdHUTVXdE5JQmtyZU4rTVpiRWQ5MFJwdSt4?=
 =?utf-8?B?YkR1eFpzQzJhM0FkK3NtOGxtRGdRWjJ2TTZuMkQ4SHpTMU1RU2E0aFcyZFhH?=
 =?utf-8?B?cDRVQno2V2N4YkZxSExPZGFDa0xsSStsRFF1ZkFiOVFaRG01ek02Ny9JNzBi?=
 =?utf-8?B?T0llc2l1V0VnbFQ2NS9LbHdEbG90eEp2NkhTY3RGUzlXQ1I3NHNoQnRqdkdO?=
 =?utf-8?B?Q2dtRE5QM3NOWTI4TkREM3FURmFUZFFrK0tkbDBvU3hyanVkRzNhYWZxZVlr?=
 =?utf-8?B?QUZuSTZvM1hneHdGRkx0TDBRcmlLakczR0crSUROMUdRcnREWjFodlcyY1Av?=
 =?utf-8?B?NGVmNm8xTml1U0thSDZIS0t5NFkxT2hyVDBBbnNRM2REbnBCTmxkdDNRQi8r?=
 =?utf-8?B?S2FDOHRLaHk1bmU0a3MzY1RVQ2pyRlNiczkwY2g2K01sT1krOHFueGxoZUVo?=
 =?utf-8?B?eTl4QXVHc3doTlVwMWxwZXJhWGxvRzJjanBUOEVXUE9OaFdreGROY0ZhcWsr?=
 =?utf-8?B?bDBnZm5LeVpCMFBwdkdNV2NDUEZkUHd5Y21qU1JSdXY1clg2RjJoRkhxUHJO?=
 =?utf-8?B?b1NycnlWMjRhYU9oU3Y2V3lnQ3lRUHk3UENYUlhZMGxTVzRHaVUyS09PN2JN?=
 =?utf-8?B?blhrS0NqaDFPWUp2ZVRCdkxrbFIvejFNUktJQ1RRSXRrUmM3K01kRjJnL3VG?=
 =?utf-8?B?RzRDN2dOZ0d4N0Y5NFZuUFVDL3d3WUh0YUl0blR4TnJVUWdkVS81YitKaWx6?=
 =?utf-8?B?ODJUQ0NLUkpuV0lvdktYMkFYeFNxa2YyaXBXaWxnRGFzdHFFQ0o2cm9VNnFO?=
 =?utf-8?B?MThUaDRaZ2gzN21jdUl4SDNEUUFzOGpub04wdEhncytqT1VtbW5xeWNFYXFv?=
 =?utf-8?B?N3ljNmNISHZ5UDY3d2hMVDZmV0dCRGZHOXJhWGlIVko2eUNzRXpOcHFuSGZp?=
 =?utf-8?B?QWZ3ZTQreVpuMEJhQTlLSW9VMThVWmpyNllyY29WOFUwZ3Rwd1NtelprQTNq?=
 =?utf-8?B?NXp2eDdjaHhSQm93ZlBKNWZubEk2RmlxQXh3dTRpakhIRG94ZGduU3BpZnNt?=
 =?utf-8?B?T0xqOXFvTnBnOUJNRkp5VktJM0pTRnQ4TWVzSXVjZkpIWUxmS2lQb2YxdkQy?=
 =?utf-8?B?SHdObTh6NUtxZDNrRWhYcUY0VXJyK2tmRkNoRVdzTS80ZkZFZGF0cWtZR2Zp?=
 =?utf-8?B?d0FmdDJ1OExJcVM1VjRGeUFPR1ZFQkF1N3phbWJjOWRHVitXdkhQbWdBTDNJ?=
 =?utf-8?Q?BDQE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFM0YjVMeWlSU0lja1RicW9JTkhQUHlGT2lQM0Jua0FuMmNBN1RTbHpEL1RN?=
 =?utf-8?B?M0FUejJyRHU4dFZEdXV5ZSsvZVRwN2ZGVkVDOUM4ZG1nYXhYNFc1YXBzOWlR?=
 =?utf-8?B?ZGlra2lGOFJUOUhLaEdUNGpkNFk3SzE0QUlpdXRPZm9WTjlmVzJUK0kvRjR1?=
 =?utf-8?B?L2ZDNERaNFBwWjZ6SVRNeTYxTVV6U0MxV0VmK004S3QrS0lpMTJzaWttb21r?=
 =?utf-8?B?VzlVaFhncHp6ZEtpcFNYaEVDYUVHbm10WUVHSFpKUVh0L08vRUowQU9pdFZF?=
 =?utf-8?B?TnJWYzlyelllMHNDVE5KTVc4d3B1TUgvUk1VOUdaMjFkeTluMGNOK01LcXVE?=
 =?utf-8?B?Vmx2N1AyZkMzUjNHcVQ1djdIUTRBTnEyMk50dExvaGlkV2pnYnlva0J4ZGly?=
 =?utf-8?B?WWE4YitvbGxORm5BZXptdXZtZ0ptQ1IyVU5lOTZIUUlpZnN6MWZTSnRNUEdy?=
 =?utf-8?B?SGZSdW8zSkFnbU1GZE0wcUhBYmVTWmo5WnVleUcvL24wUlkvTWlNeTV3Qm5N?=
 =?utf-8?B?ZEQyc3FVbWdXbkhlSVVrcTVGdk53NW40WkdpTnFmNDdzalM2a0JCNlgvQWZh?=
 =?utf-8?B?SWZ1UlFGK1dMQlJpZkNsaDcwcHE1UnpiaHNmUlk3OVAySVcvenlwUGtiVFdo?=
 =?utf-8?B?bEYwL0wwM2RCNlNEMG8vUXluVmhhZi9FS056NGdTNktqVkgxUENhWjJTMjVl?=
 =?utf-8?B?d09VNjJFNkFleVFWZmRKRTF2bEFCM3JvMTUzaURWam8wQzdSMU9TUVd1aVBr?=
 =?utf-8?B?cGEzb1RqWHZQN1pEeUZ3ZXRncjV6SitBRmNnZUNYRVpHdlZYQktxQ3NjN2Nt?=
 =?utf-8?B?VVhITGRwZzVxaUF5MHl3WThMd081KzN6SG9LZ2VzQXAzRTlwMENYeWZwQ3hm?=
 =?utf-8?B?SVJnYzRnbWNEcytuR0xRcC9sUXpia2RZMGw4K0RZYWh5N3UyRGVFTytYWGNH?=
 =?utf-8?B?Q2k3OFNkRGhZaE1EZnpySXpCNko2Nkd6TWR5Y1dLbFc1c2FLWkxUS2tuS1px?=
 =?utf-8?B?OExKSS9NbWM2cEhTdHZTdWpXK0tnb3MzWDg1aWwyd0taZGhvd0ozQk05M1ZX?=
 =?utf-8?B?ZWF0aGRnYmk5SU0xUGhLanhYcGZLNnpKZEpaNFJIbkw0Tit6ckZMMUNzc1RG?=
 =?utf-8?B?bUdKSFhTVXRMRnNWQ3BCamdjVWcyT2ltR3MvS3FLcXFjeE1PZFlWSHFudGF0?=
 =?utf-8?B?OHhMdnN1dWRHYzI4a1NXeUlaK2d2UWthTlo4NExpaHBoK1NDRlVQY25xSlFW?=
 =?utf-8?B?emxjempEQzR4ZW9yekQ1SjFFUXpjUmVpVmU1TStUdi9JSXFSajBmY1h3WlZ6?=
 =?utf-8?B?d3JjVzFaVHZyVUlRZzA0U3BlMzA0Z1RleklLcUhyc1ptUVM4TXZvSmpod0Fn?=
 =?utf-8?B?SkZDK1dVSmpvZUJWVzFvaituT0JienZxRnJmVDlLNElhU01MVHp2Smg5Nmk3?=
 =?utf-8?B?elpPbGNLa21BTHJHeSsySCtNTm8wSTV2cUo2dkZ2cyt6aDFVdGJVR0I0ZFdx?=
 =?utf-8?B?VlloU0FCNG5nV0swTDdMOS9ES2pjTmpJdXkxTVNvdk8xTjFWUkhyWk9WQVJ5?=
 =?utf-8?B?Y0V6c1pqMXJLWWswN0dFMUhtMThMN2YwY2d1WWtaYy96RXJUMXVtREh2cjVB?=
 =?utf-8?B?aW1XeG1XNWlnVDVYZUltblVmQkYraHFSNVUxcGZ1WktiWXNOQ0pNQUdiVHh0?=
 =?utf-8?B?K1VsbWlxaVFyYU5sV0FQVTMvdURPSlhOUUpURE5HM21HZWRveTdOOEhGVE5y?=
 =?utf-8?B?WVlCQzRiOVhwb09CRjFhd0xIZ2EzMWVUN1N5MkpZVGh4OGRRRVFlSGVYcDcy?=
 =?utf-8?B?eVRoT28wRHJWMmVqL05Cd2ZtdmU4U09nMWV2MnkzRFpWWGl4dDN2Q0ZLN3Vt?=
 =?utf-8?B?SDJ4MWdUcTV6RWZiSVBpbUdrUWlpa1hETWR6d2JlQkpSQnJRckxBZVRvczNq?=
 =?utf-8?B?M2FXTEp3ZTlWOVd5SVNGaFFNa0lVMU5yY0hSUzQ5Vi95L3lYN3VXRVVYSU5B?=
 =?utf-8?B?S0lIRWpHQm9td3BEWEwySU44QmREVFNzR2ZVOEFLcGd6MTl5U3VWbEI3TVk0?=
 =?utf-8?B?bnRqY1NYb2pFdlV5SmIzQ2hKYmdkQk9uZXE3ajNlTStGODNzQVVUYThkMHhh?=
 =?utf-8?B?TWE1SjQ4TFlxeU5mY1pRcEM0QklLNGxYaEdSNVNSbnhxTHNuZUVrOEs4NHlR?=
 =?utf-8?B?UXFPWmdMTFlZbms3MVdYa1VNUDU1QTBYTC9XTzd1eWJvY0xCa25idyt0S3ox?=
 =?utf-8?B?VlZSWEdMS283Z2Z4S0N1c1lwV213UDZmQ1dnbGE2Nm1VQ0U0NGZMeWlFUHJa?=
 =?utf-8?B?N3JRZ1JmekFIQVUvcUdQcmlTSlhsRk5IMlUwUlNPTDA0TmhEMTBSZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063d6dd8-b508-4308-38c8-08de59a054a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:48.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUm8ewHPoPznIVMKhoktt33W/xI5D/XVVuiYBf+eW0ERLyUV7jD42+SoNwlIlsmrpuJ2NjI7iFwwriwulZhM5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7555
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:23:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21697

On 16.01.26 13:03, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 30abb84..3665269 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -279,6 +279,13 @@ config IMAGE_SWUPDATE
>  
>  if IMAGE_SWUPDATE
>  
> +config WFX_URL
> +	string "WFX backend URL"
> +	default ""
> +	help
> +	  URL of the wfx backend for software updates. See ./doc/README.swupdate.md for
> +	  more about wfx support for updates.

Maybe clarify here that an empty string implies that wfx support is
disabled.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

