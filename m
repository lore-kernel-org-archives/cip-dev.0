Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E043D3ABFA
	for <webhook@archiver.kernel.org>; Sat,  6 Dec 2025 08:24:30 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2406.1765009465499835003
 for <cip-dev@lists.cip-project.org>;
 Sat, 06 Dec 2025 00:24:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fzbBMF9e;
 spf=pass (domain: siemens.com, ip: 52.101.83.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoseiWy9eN+16d4QTqjro1z6aVFMCcbQu1GZZuJ4XqexwhYydUCDJHNAcg/VWC/PmxG6bGQHMGYvCl5KVgSYaycs0liY5yyxBALa7Y+eI/KelzShWntyJNrNHDTx9WPM/LADQk/8yOOkvfEkZPxW9UYAUNReZ+0OZL3r1Jto0t+kxyMI1qm8j3+sxXbQ/FaAjAVSA9pZEAwc/9esFqzU5C+BQ3shyN3qXocc3OWGsgbBj4LFaPCF4qjzLzzDOIIqJ9kBHv0TAs3UHPulkLTAMYWoiLlUcHNRykLIMrz8Kop7tUJMUIFRMIVHBRPygc56rW/rBJYJ4QvxtPqQkVDDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LhBtVBf2xiIrZqkhcHZcYRZsO3/+QvBMEW/59tJ78Y=;
 b=sr76rccuhaxaFGaOoYmnP2RaqF9SnhK151JIiNmNt9KFYP9Z4F5y1YeilbWP7zgBtARcogs0PiIZI8PAxL+R4Kx5Nvn9wNFK0TND4z66rZOVWiWNJxOe4r3RdIMNfESobhGq/UFHIa1FuaCUOGe+lfewRM8xXuaXdLan6vsXEuErBxwhRG3y0K32i+KMiemimybnPCOD5V74qVfNI6iMKqaP1is9KBo7Kl426ESuO3ncuA/iELH8rOd573fwmDZBTJ4VHQpgJQ5V2D3uoXcBVLURH2Ik9QIR0kLvSW21XvVYCKqsqAVjzrFyLOvmtmVPYlyD2ly15a2sSZklPRK3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LhBtVBf2xiIrZqkhcHZcYRZsO3/+QvBMEW/59tJ78Y=;
 b=fzbBMF9ertvTTj3NRHiajhRX9F/Pu1OcxgeX8NOqTCyXrwliMYcf/IvVP6N2kfbHorGuqdeq9BLk3hIte2/meKQwaXheifEJ4wETnkZRcaRxxe8mRdP9lEUXZMYYBrETGvP+IJozYZnpqPz+pqL9tt824knxVCgjs4ZPlP7D3VHGCIlqEJenG2kxAAZFprqZVBoYrT2U3uxtiaNOlvebDHuVh/6O6nhJjhnDzUaW2liVEGo3zX//ya2oIcQ+njtRRghK7Bz+995WdTAtsVAURrNQcKlsSsKkkHRNpqe91m/bxT2cV1v0JhIY2SPMLG8Re4KM9aVFFUDhBVqWqlVjgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Sat, 6 Dec
 2025 08:24:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9388.003; Sat, 6 Dec 2025
 08:24:21 +0000
Message-ID: <57ccfb35-ed55-4905-9ca8-9d113828c7d4@siemens.com>
Date: Sat, 6 Dec 2025 09:24:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 0/3] Fix Reproducible build tests in the
 CI
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251205142927.4087770-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 134b35f7-3178-463b-97b9-08de34a0dae4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cXNOVXRqYW9XQlBNRFNPWUJmbWJxOE9IRnVuMm9TektuTGxpeWIyTU16VEQ1?=
 =?utf-8?B?RjRSdmNiVE1TVVE3UmNMaW1xRlJnQjBqWmdsRU9IdE0xN21FSUVzTUo4dVpl?=
 =?utf-8?B?Q3g1QmM5dGZjdFlNTzIvNWFBUU1HVVBtMjJzNWRETGY3MWRxaUVwRHZtbzFB?=
 =?utf-8?B?UUNFalBheVVBTTQ5dk00akpOeHI0eVVZTjZHOHB1RzZ3UmI4MnlVaUZkLzEv?=
 =?utf-8?B?OTlSYVU5Z25sL1JYZGU1aG9KQ2dnQ2xGN0lEWk5QcUVwOXJsZ2RFdHZld2pI?=
 =?utf-8?B?YnFTSlg2NHMreElIUWtCbDdwczF0SzRXK1R2KzZKbG9mcUFXTFVhUlBvRkFz?=
 =?utf-8?B?NW5qYmNMYm81WmVDbUxGbkt1a1RBejN0bFlpWTNoWWh4RDMzdERoQk1VWHUx?=
 =?utf-8?B?WXVuMWk4TjJsTDRUR1ZTQ1hEZlJVam1CcTIxZ1ZvNjAwSFFVRVVhN1RLdkNT?=
 =?utf-8?B?bHZQRFdWeGEvVkVRUURZVkFUNzNacmxFbGF3eVNldmxWckJsc1VhRHpEM1Uy?=
 =?utf-8?B?N0RVb3dCeHpyVm90RysrYmQ1eGRDaFp3WHgyUnFsWmE2Z0w4NGlCa0NkeElu?=
 =?utf-8?B?Q1RaQUtzWmQzMHVPR0lVZzZvK1FvS3VBY1RyZFpJRWpML1ZMUEtYSnF1YmxK?=
 =?utf-8?B?VlA1QTYveXRkY2pFUkh6NUhoRml5OGxCTzhJTExQb2F4NW4wWXpSYkkwYndh?=
 =?utf-8?B?bitDOVZ0MkZCQ1RkSXcybmpCbkJkeUlBOEtFNXk2TjlnbEFGbUMwTjBvMXpD?=
 =?utf-8?B?N2h4dUhBZmxPZzkyN1IzWXp4VEdrRjZzeWl5N3FuZ29VMXllMjVQcE1XQ2tU?=
 =?utf-8?B?UkJ5aUxsMzZDSDZzd0k5TDY3SXE2UkZ6MFpBaDEzZG1EbW1CVTRjUmFzcmx2?=
 =?utf-8?B?TUhIUTYxWDB0WW0wd2xhbkFBNEhJakwvUXJZK1FsVzFrNUIwTVhwNUhoK0gw?=
 =?utf-8?B?T1pEWTNPaXlIRWRBdkpVeFI3aDNkZG8zRmpEVVBDYjJaUVIxeVc4eW80M1Fw?=
 =?utf-8?B?cVB4dnkzNWJVQmpzc1NmQ3M4TmhKckVJRmI2ck54UW9Ra283MDRoMksxUHNx?=
 =?utf-8?B?VkRIK3diTllkKyt1cnorRTBVNW9lN0ZmRmhCYlFQNExNUVJQSlU1L2hJYitU?=
 =?utf-8?B?ZFhtVXNDU0p3Nm9IeklRRGlpYWR5bzNUeE1xQUZTRUViSko3OG96QVhiMHlr?=
 =?utf-8?B?ZmMrRFNsZ0o2UVdzbU1yd05odHJDYkxUeG9wT2JVcGRESVVWWnRWMDJ6YjJm?=
 =?utf-8?B?OHpqNGp0NzJuRVdXZXJyVUVqTEVidCtNT0c0bGlrNDdPVHFjdE4zU2h6WElj?=
 =?utf-8?B?MktFNHczL3MyTGs4Y3kxUEFnWFA3c05tM09CYVphNWVFUmkrQkxyZ1VNZXNS?=
 =?utf-8?B?eTZ5L09aY2llbXhGUjVuL3FSZlk2OTh0aEg3R1R5dERLL09sd3FRbVF2Mzg5?=
 =?utf-8?B?WjRXU1lBYXVmVlhmYWMrdCtEc0lTaWtZczlXa1Npbzk4MjZ1czc3cmU2WXBF?=
 =?utf-8?B?M0tnR2ZOZ01zUU15Uzl0TnBWQUpZaS9JQmx4L1BoZ1FWV2oyM3NpS0dFVlFD?=
 =?utf-8?B?RmVCbE90bjZBc2QwWjc4YmZGWDFoTHNDUWVjdmloQittbk1NTTRhSEJxa2R3?=
 =?utf-8?B?SVVuY2h1OGlDcDhNS0lzSFFmRkZMbnlTV3ZqSUMvbFh0U3VqRktXcUZndWpX?=
 =?utf-8?B?QmZOZ3hnbm5ORFlpbEtNRW9NbFlaU3NUckQraFBEZEZpb2lUNEtONjhDU2ZH?=
 =?utf-8?B?TFBtV3BxUmR3SlVvTFh2emVRM3hxQzhVVGFwbFp5OGp1Q0h5SGJxTmdSOGJR?=
 =?utf-8?B?ZE9YV2JVazRQTklRV2xmTDRickZlR09ZVHlZMEFNS08zcjBOajRHMmdFN091?=
 =?utf-8?B?L1VYVzQ2UlVGOEhJZXhJaUVzczl2Z1JZdzRvUUlGQ1BiMnR4a09GVU9rRkJp?=
 =?utf-8?B?MC9TengweGU4d3BKU2F3V0dPRE9IOU4rQ01XK1U1VjZhT3Q2TUpkWFZtbU5V?=
 =?utf-8?B?VTliOFBkRFh3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGJKQkN3Nlgrc3dCTVZ1cEVOZmRFdDA3ZFVCWFVJSEh0ZzR5TXZDSHYzR3dX?=
 =?utf-8?B?a1lyTzZLRDY1dW1Rd0lKZHRQcEx2WHNGMjN6VWxTT3RsR3dlMlF0L1lCQ2px?=
 =?utf-8?B?SUNPeEhYdWQ1QmlJMjFmSjZCb3VHek54YnE0K253akZBZzcvV1VUQTBBQm01?=
 =?utf-8?B?aFRvUTFxT2hGK2RKZjFqeXl6TXlVenByakQ4OGpvRWVBYWpiT0hkUk1kVWJ6?=
 =?utf-8?B?TEc3R0NDTEt1aDNMTjZxd2F5bDZ1eWpSaGVHY0FBN3k1TnZpbm5KUGdsWDJ6?=
 =?utf-8?B?V3FPM0JjL1ZPRkJHRmRXb1Q1YUkzcDE0bWxGck8rdlJGcVpiTVRLODk1VVhu?=
 =?utf-8?B?UFduYklhYUs0VXQ1TGU4ekdzTlp6djFBMTFVWHhEUDBoSU02eTRaWTkvU1oy?=
 =?utf-8?B?ejhXY3FBelN1dVJFZmVQTDFKdGNKalUrQmdrajhRR1FhYmtCSTBoOVBEVzZE?=
 =?utf-8?B?b0VCNHRjUnV2bmRJM3hiSzVTQVd2cjFDb2w3V2hWaWx6NHF4TmM2RFZlRW04?=
 =?utf-8?B?K1JKbkllRk9jUXd1dkdPT3dRdUxVN2hCR2JDSXBhbXM1TjBxNXgveDVKOGF2?=
 =?utf-8?B?QXE5YVQydGpJWnl0M2dxS2xtWE9tVkFQTFVWZ0lDdmdWL1RNbVRYSVVHT3dG?=
 =?utf-8?B?SjRXNmE4ZTZYUnZHdERudm1kVStsM1ZQUFZSdlFvVFV5anZPeGNXRmFnVVU3?=
 =?utf-8?B?NHdFZ3BNZ1VqMjQybTNIeWxQb3RONVBVZjJiNVc0V21KMHNzV2lYWDVzaWFD?=
 =?utf-8?B?ampIY1FkeWtGR3ZGak96VzZFNFl3YnNmUnFCU2tWQ1oxY1MxMHVDL2tnV3hi?=
 =?utf-8?B?RFVzWE8vQjdtTmFKNnkvSG50SGN1SWYrSHVCejJoS2hqSkg0MDZTTnpXOXZz?=
 =?utf-8?B?d0RrcmlSUjBHclVreFpDQUVFeTBtUEJLZHdKT21QQUhjVHVzbEVVZFF0RnRq?=
 =?utf-8?B?ZnphMHNNc1UraitRejhCckZhYk1mOXNiSGw5ekZEemxHM1VVL3VSeG9vanNy?=
 =?utf-8?B?djdhaW5MaHdOQUNqWFNpTjgzeUU1TTNPZXpQbUV4MmsxSTJFdEhOclNTU1l1?=
 =?utf-8?B?OGNZQWxINXBGWTRySmVUUDczdjA3TXM0SmFJWHpaRHFGaDlOK2U3THFZYzhC?=
 =?utf-8?B?blN3ZC9ieG4zeUNYOHNSbjRvUERHakV0UTdRMzRibVFHS1RDRWgrMUJEREhv?=
 =?utf-8?B?Tm1CcmkzVHg5NHkrWGNCckhEV0k1WWgrNUpoT3ZXb3hONysyVis1VjVYMjAw?=
 =?utf-8?B?K21EQ2VJWFY1cWVQK01DcmY1b0xpUkk5VUJKSXhCYVVJVm82SGhGeHFjOFlU?=
 =?utf-8?B?Y0owZHovWHZXazFmdjRpVExCeXhsY0wyWDRhdloxMmtoOFQyRFZyMjIrWllV?=
 =?utf-8?B?bVc1empCSlFUYTQyWE9yeGdyQ21zTXVUWUlNYlQzL0g4SkRvMU5weUhZeGk5?=
 =?utf-8?B?MTA5YWJBZDg5cm9zRytjeHJsc1duUG5OVDJDbzdDSWJBcWQzOHJNQlhpaEty?=
 =?utf-8?B?eW02Q3ozamlPL1lhYVhLOUs5WklWS2FSM2NtVHh3eENOa3V2azg5L1kxeFVy?=
 =?utf-8?B?SEVLN3RDQnlGdEVHU3RRMlU0eWl6UEprLys2eDlwNnZ2WElhNi9GNkg0eXQ0?=
 =?utf-8?B?N2pMY1hBbDQyZEV5L2lzRnM4bkRTZmkvMjlJRWQ5cHZDeDN5Y1ptdFNmdjVP?=
 =?utf-8?B?VHVRTmlWR2RLZDR5dUpiemdwZmttNjVhVXVlOGY0aW9BZlduenJPZUdIT3Mz?=
 =?utf-8?B?RFVDK3prS1VSVEpUd2Z1S2h2czdTdEhYM0RpYnluZFdPMXZGN0R1WmJETWpz?=
 =?utf-8?B?YnFpK2YwSElBNFAwVnZ4OUhCSGNRSkczandqdTdxMmtpVWh0cGlWbTdoN3F1?=
 =?utf-8?B?aHB3eWowWWErbEk5NUxaT3FwUFNlUTNnL0xxM2hDNDdUclVhWTNiVVBpam0w?=
 =?utf-8?B?M3N4aDdNYkdVdktZMnhsSEJrZUFtVmEwNEpQOVl4a29FcHl2ZElnbitkYzlr?=
 =?utf-8?B?a3B6KzE4anFpWEprM0wxMmZjWmhnTGVtVm5vRERUcFc5WTJFZHVuekdaOFBM?=
 =?utf-8?B?QUVLYWRTcU5YbzFHQ2NYQXZNdnJYMlBKR2kxK1lyMjZBSVZ0cjFxYkc0eHlh?=
 =?utf-8?Q?yyRcr1anFQ9z9lpUWz8w08yms?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b35f7-3178-463b-97b9-08de34a0dae4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 08:24:20.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhjvclK3H+JZigoGYgTw+52HArE1hRwRUHRVr/4JU3FYeuLMGGAHEX/CX0llS/nkJecNbDNem53ZcbIan22hXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7264
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 06 Dec 2025 08:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20953

On 05.12.25 15:29, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Recent updates to the CI for moving to trixie based build and tests led 
> to the reproducible build test in the CI to break. This patchset fixes 
> the issues in the reproducible build tests in the CI and while at it 
> also fixes a bug in the reproducible build test script that came to 
> light because of the issues.
> 
> Now, I did do a test run[1] with these patches and found the reproducible build 
> test still fails but the failure is due to a reproducibility issue 
> (best discussed in a separate thread) and not a CI issue.
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2195307991  
> 
> Adithya Balakumar (3):
>   .reproducible-check-ci.yml: Align with recent changes in
>     deploy-cip-core.sh
>   scripts/deploy-cip-core.sh: Check for the existence of the broken swu
>     file before uploading
>   scripts/repro-tests.sh: Remove return value from run_diffoscope
>     function
> 
>  .reproducible-check-ci.yml | 2 +-
>  scripts/deploy-cip-core.sh | 4 +++-
>  scripts/repro-tests.sh     | 9 ++-------
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

