Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC97D78785
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 14:27:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17808.1766154423990460812
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 06:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DxHivNhL;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZ+kksv3OM9RCtNz81oqd1Cs3Mex3wz69nLHybQzslq2lkpGUvMj2ayKkAoMrVWkmj/PZQ+NDS5zooGIxCCYpUzj4id/KctQj7JHzUp1qGQxCMH63e/hFxoLkLIq97vWGbEZFumkZDoLhiGae6N5Es4UDfjtLXhZziVNcbXKzps124186dDKq1cOlO6rhPChbumRETghRIE0Qjkyy5K2ukOKo4C/OnzaAuV8SqcxmlsOt7YSiJqhVC1UIDOQx3lbJ6956ysqfKv9c9nqIAzn7KpmBLvsI/QktNJUb+P++warQyVD8fyJnzgiGq2N0zzM7+1uOrxfkzKOdflv1B5Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4bxwIwtlEinUiAh4aA6smiJY5+rz2gRpv0rOrn4+C0=;
 b=H7r63m51dHNr8UQLoSHQyX5R7TrVbJym2rKx2AN31+4SVYm2ahHMM/cHgUSnORS5hU6qaC7Yv2D2clxrvahXhHJec658RHPRDip4lNH3w8uniZBNQDfuMjZvhLDtRqfzG9piYpj25asoED3pi+S7Ofu8nEgjUg8Tex6tCm4wJ0a5lZnoxeJxkJ3pt734HRy6WVTy/+QwTqd0fm+L+edDLmo8HlwL6F6okue39IB4GD6uOgzEaIdfe8JYXwXwdQQ03RlHZABBMhN96wAWTjL1/k7xPB2SS/DfTDfTgphBuFbPdVIuYx7GQdm5dRznqkhzKDOSR5EpATgwMUmfvuYugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4bxwIwtlEinUiAh4aA6smiJY5+rz2gRpv0rOrn4+C0=;
 b=DxHivNhLpMVMelgOWtJ+5UyoGHYvCikJUiq3fYgdsFeneMzCtDDGi3j4jHLU2cQPu8I8JYBW9s53OFNj15SSUm2T9bQXACf1A6Skx2/KeoYoIgHtDPvR+KfMlKCFLPVYJdpV1bd7OC6yYkCDtuOxxl9/oBIVrNlAopjOxi7m4eD4Y+9FWCjMK+j45tnuUNhx6hbVuOYKtS8y1PdM9ZT42/OVbA212BmyFDGkhOvUedbJC25poN4tiDF3ba2aUR7tkJ34x9R9NUWfhEdGLOFD38F3vGN3xFrRmVS6dACrqxpX0/NbOHOHWYegJjUoVvmIjTwLUNZGMAUuT7+EbTjtfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:643::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 14:27:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:27:01 +0000
Message-ID: <d38b7078-a920-43a0-b4dc-5cf6a5410d22@siemens.com>
Date: Fri, 19 Dec 2025 15:26:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/6] Move RO_ROOTFS Options to
 swupdate.inc
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
 <20251219103349.1227710-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251219103349.1227710-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:610:b3::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e8f5de-f7a8-44a7-ca0a-08de3f0aac83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZXBFazE1alFST0RnVFZJZDJ6K0NMUVFDaGtibU1ZRUhjVkRxVEFaVXd3YnRw?=
 =?utf-8?B?dlhOMmR3QTNiL1ZqN003cmxIdU4xRmZ6SitRYVljSmRWeFp3b095V2VFMW9j?=
 =?utf-8?B?K3UyaHgzanlkRmdvT0ZsUyt3dXpYSzFtVTlsZHdsam95cVRodm9YZzgzWWhi?=
 =?utf-8?B?bXpxRS9oQUlTTkxnZ2V1TytCVGJzTGNQdnA2U3RpOU9teC83ei9vVThCeE51?=
 =?utf-8?B?dE5MYjNkbXJhRTNNNkNwQkkrWmJaN3M2TnlZUmJnTmF4Q0pZdGhia2RFTFpu?=
 =?utf-8?B?RStXSDI3VHRDYm1kbWFTYnIyYlA5Vjh0R2xWK3NtWUtzY05KVk5mR0psUUt3?=
 =?utf-8?B?ZHE1UlA1M3RreHNBZC93WUtlUEpiK2pGNFlzRmZFbXBTcHdhQXhoYjZtNFhi?=
 =?utf-8?B?NG0ydE03UjNIdVF1SldmcDBjNXNSYXl2cE44RG5HVlpvWk9HSzJESlBXNkh3?=
 =?utf-8?B?cWQ4OXVsMW5CKzl1aG9uVmtFUmZ4U3ZZbnNCUytYdmZsWkpDQlFJeGtITFZq?=
 =?utf-8?B?RHRFVHBNQjRkS1VFMC9lWExRbWRXK0dNQXJSTFJnOUZQMVBGREl1Qm9SYTBR?=
 =?utf-8?B?TDZmekdJbisvNmNhVnVHUFVnS0I4RTJvcHc5N2xha05xQm03R0lqSGZucFRE?=
 =?utf-8?B?TUdNaG5wT3pwbm1nYlNOUHI4VSsyNUg5VEhQZlJoYlEzMnJVUzVGaGVFSlZm?=
 =?utf-8?B?akdlNm9UU3Y1djIzU2hMajU1cDZzMnpSUHN2Kzd0UW9mNlc3S1o3QVhxeW9I?=
 =?utf-8?B?UW9qVGl1SWNrK3dlVXV1UUxNWTMxN2RPaHQzVitiT3dTSXJGQStTM1BybGs5?=
 =?utf-8?B?U3dYYk9nem5pc3VjVm1kRG1BN2d0Q1hBeUFGV0hHbXcwelBHSUNxdDE1TDI4?=
 =?utf-8?B?NnkzZ0o2amlGTk44cDZzS1p6Y1VZR1dLNmJYRUVZZTFkNU96YzE5R0NZVkNk?=
 =?utf-8?B?WXRhQ3YvMFl5Y2dvZDJydVVRbDhpUnQ4WGhkS2pCRjdScHdKeURoUmZLNG5Q?=
 =?utf-8?B?TWRtTGhOcXVCV1JzaGl4RUI2UldzL1lXOVJwV1JucUo2enFuckcyQjZqcUpG?=
 =?utf-8?B?d2ZEVDlSdTFIWjVSak15QUt5akp6eklVMHp3cStKR1BkYVUxTXlRMGRINS9W?=
 =?utf-8?B?VmtrMG0zL2lWd3FTVVRTMEI5d2VoTHdpemRWOWtPTjNIbThadXY3RzFMNUdh?=
 =?utf-8?B?bS9YTWt2ZUorSmo1ZFYwQ1l5c3htdjJaSTIxaXFLNi91S2VOY2FMOGFka0VY?=
 =?utf-8?B?OG5CUDRSNCtyMFFuNnNCWTNWQVZZb3oxTmR1U2tlbDRSZkxGNE9vb1hySzZi?=
 =?utf-8?B?RS9zVFRGdDJidHZMSFZuUFVqQjBvc0tjZVZ0MWdJZGRCdFFzVDYvMUtmaTNm?=
 =?utf-8?B?NDlpM05zd2MvY2tIT3YwelM0Q3c5cDdINUErOE5PZ3hlRmp3ek51T0hWYmpq?=
 =?utf-8?B?RWdVc0czUXNoSUFTKzIxVE1GdUt2VG53QXlwZUcrcFpTK1BRNC9KeDE3dWVo?=
 =?utf-8?B?MlZCcStRdW5WUXVIMGNEeHdJTkJWRU9KckowWi9oRVp2UHNtWjBIMlllejBJ?=
 =?utf-8?B?VW1aVEkza0gyYitCSmZRTXdwTUV5TmJnVk81a1JVQXpaVjA5eEdSbk9LaVN2?=
 =?utf-8?B?M0tQLzhXVXFNRk5kZlp3TGszQ29uWm1tTHgxejVzM1gvMTVTblpNelVXNHFl?=
 =?utf-8?B?TVVjUi83ZUZ5U1ZXZUJSSTJ0SGF1Nm1QRWFVS0xZTm9KZXhMTHN4UU5SOTBv?=
 =?utf-8?B?TzU5b0NIeExWaTdNRW9XRzJnVzNKaHdrR0dTU2VyNm5lZjJjLy9BWHZJSTFa?=
 =?utf-8?B?UmFkNmFBZHpUMTBvampZc25nSy9jV3diQ1picEIzUElTL1FacWQ3dTE1ZERB?=
 =?utf-8?B?aFZZTStGREVMUVdqUWQxSzhNRlBWTjdWY2VNN1BuV3lKYVJjVmR2MFQyZXlh?=
 =?utf-8?Q?WayJ/metDicO/SXb8mjEk0SG5PvgHtGY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3hpTmg0MUpvZVE0NFFGUVlmMFAvRm9EQWpkVmxHL3lCU3pxUG9hRk1yeWVp?=
 =?utf-8?B?ZGxEcnZwOVZXajVqRDU2NnU1UFZNbTAwZmVhQXNpWmk3dnBFN09TTE5tcVkv?=
 =?utf-8?B?anVzSzN6ZW1xQnJma2lSa1ZpYzJQbHB2c3ExdVhRMmYya01wUU9PTHFoWXZ6?=
 =?utf-8?B?alNNSUI0QU54SFkxRVpuNXY0ZUQxVXllaHZHUCt1STFwZk13VXBmZWUrenZX?=
 =?utf-8?B?cW9BdGltaWFPSFlraWhOSEc4MlNaWFJKYzRxQlJxUmVxYlo0NzdJSThhM0RM?=
 =?utf-8?B?eC9pZlovS1AxT3IzQ0NKNUlhYzF2ZEY3ZDgwaUtKbFEweUkxdGNuemNMdEdN?=
 =?utf-8?B?eDN5K2VRS0s5MHR0dFBOZm9UeWc3cUlwUmJWN0ZVaUlDUmpsZzQ0eEpkak83?=
 =?utf-8?B?WW5VYzdmQW9LeWc3ODhUM1kyMGFLVEc1OWRRN2Fwa09QQWIxSWNtd25vVmtL?=
 =?utf-8?B?bkQ2QmdZVHRTWlkvOHlQOUJRamk1VWNCd3I0dG5wQVc3K29vaTB6Y0k3d2Ry?=
 =?utf-8?B?M1ZXVk53SEJIWGM2aTdLL1k0dXpQSVFlQ3hKYy81SU5LYmI3SGJTRGNzRTRR?=
 =?utf-8?B?WFhyWUh3THFuYmhsTzF4Mm01YW9EQi9zNDNZRjViVSs1TDdUbUNOMHprbEhB?=
 =?utf-8?B?NDBLQ21rOWtwSHJqZ213MFpUSis5RVJaVGIxSWhmZHBJUmRXZWppYTU3ZjVo?=
 =?utf-8?B?SnJDZzBmbkRWVExuSG4zSW1MY0piRHBtTTIyMnpnNnRaajBCdzlYWk1XUnN3?=
 =?utf-8?B?dFh6b1F1ZEZmMjc4aCtrMzRzcjhDaHhIa0xFUGJGMVZiWFJDczRnVmRTRWY2?=
 =?utf-8?B?NUlWRlp1U2pRYVhUZDU0MVYxdHdzRUlFMzZnczV5TWl6dXArSlNHSXBXTGow?=
 =?utf-8?B?SVIrcUZhMW1DRGRzeVR0Yk9tNFRuVmFUY09ITG9GQjlubVA4bWIvWTlBZEVQ?=
 =?utf-8?B?ZzZEZzNnL2kwNjRmdHBUaC9OR0VnTCszSkZVbWpncHhFbkV2MTA1MDdWMkk0?=
 =?utf-8?B?eFI0ZVBmN200Mm4wWXNtSnpVUVdzNzVnTHgzQUZlQm9xaHVhMFpJY1l5ZnJJ?=
 =?utf-8?B?b2JCdHFvSFJHdHFhQmlaNWhVVlJrc0h2aUp5emVrY2xnRzNvc0UyTnNSdnJP?=
 =?utf-8?B?V2NaTmZVVTdHL2Ftdm1DMlVVNjNMd3E0b1ZVL1ZFakl6OEFISUl6b1J5bUlC?=
 =?utf-8?B?SDlpOWxGUk1ITllVMDZxM1FBS0ova0lHZmJ1aGRGV3hpeG5HRUZtYlJLM3F5?=
 =?utf-8?B?SVZhVU9uSHR0a1UzNi9aa3lYTDBtZVBDU0R3M2w5NUhNb0pxbTJZREhoMzBB?=
 =?utf-8?B?QnJxRm51OElUb1Q4aTQyN0pqMlc2YzlLb04rZ1JCaXhkbUFMbkNWSERWelRH?=
 =?utf-8?B?ZnZYQUFhQ01ybmtNVVNtSWYzM3lNc3o4ZXBhT3hrTVFBaWViZHNrWXlRaEY2?=
 =?utf-8?B?bEU1TkYyMmRWUzU1RFEvN0xma05Mekp1ZXczVHJReGhoVU9FeDZGU3k4Mkxm?=
 =?utf-8?B?R250WmNia1UrOGdyUHpoK1U5TEt2dm52WkNmV05oR3BlNVMyN1RhOUNYNW5p?=
 =?utf-8?B?UnhZM0w1MHFXbkNYM0JINzc5WjNWbW55VVFRZUJzSmRUS2hDUFl1NmFXNGZm?=
 =?utf-8?B?QWg0MWxkWEFzSmZTNkszOERtbG1saCtVczlEM1ZESW5GbWs1UkN4bE44YWNm?=
 =?utf-8?B?dmhyMWUwYWxyOTJISEV5Y3JSVUFsVWhTOUV3Q2FsdU12WThGZS9VWis0K1I4?=
 =?utf-8?B?dnR3MzFJQS9xdEU1UlR1MXgxelJHMmoyWDdBcGZNd1c4WUZPWXVNaXIrR1gv?=
 =?utf-8?B?Vm5KNzdtU2lhSWwwcWJ1OWpHVFM3YncyR2pXMVpsK1BDejdUckxDQUdPeFFL?=
 =?utf-8?B?RFh3VEk2ZDFxMXE4VmJhYml3bDRyU3FCZnBDMllOTktyWmw3cVZKS3lmcVdT?=
 =?utf-8?B?enBpWUY3Q2tkbTdmWjc4cTQ4YXJQWTNPNlBNMFJxSnF5N0JPRmFoTVBsSXhi?=
 =?utf-8?B?U1llV3IybDAyVW9lb3hNNTJLSHp6R1lOWTdwSTZVS25ndnhBeWtCY3pYQ1ZJ?=
 =?utf-8?B?b1VYU0pubXVKUVBvSnd0aWhjN2o5MHVnWkx3UTFWblV1WmFibUhxNUZTZjcv?=
 =?utf-8?B?QkVwOXcvSGpONkFBVXZQZndpQlZqN2szbElMc253R0pKZDFrRHpVdVV3Sy9B?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8f5de-f7a8-44a7-ca0a-08de3f0aac83
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:27:01.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EakGYnjX+M479umXcmmZWwpUHfVeHfANapXb7eCOqjDELFJiVtBW+uHA3Q7jFKyhCDzzd5hsZ9hz+PnY/iWG4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 14:27:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21180

On 19.12.25 11:31, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> These defaults should always be set and there should not be
> part of the kas option file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate.yml                                       | 5 -----
>  recipes-core/images/swupdate.inc                           | 6 ++++++
>  recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index f1f3f77..4a128f1 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -20,11 +20,6 @@ local_conf_header:
>      OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
> -    RO_ROOTFS_TYPE ??= "squashfs"
> -    IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> -    IMAGE_FSTYPES:append = " swu"
> -    # input is already compressed
> -    SWU_COMPRESSION_TYPE = ""

So, the scope reduction to image recipes is not problematic for any of
these variables? Just double-checking...

>      WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 75be566..696ee7d 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,6 +12,12 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +RO_ROOTFS_TYPE ??= "squashfs"

There is also a default set in swupdate.bbclass.

> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
> +IMAGE_FSTYPES:append = " swu"
> +# input is already compressed
> +SWU_COMPRESSION_TYPE = ""
> +
>  # read-only rootfs with /home and /var
>  # as separate partitions is used
>  # /boot is excluded as an unified kernel image
> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> index 9d53394..076f14a 100644
> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
> @@ -11,6 +11,8 @@
>  
>  inherit initramfs
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
> +
>  INITRAMFS_INSTALL += " \
>      initramfs-overlay-hook \
>      "

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

