Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABC4D0D14B
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 17:31:17 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11705.1767807071206165834
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 09:31:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=m/K/BQOG;
 spf=pass (domain: siemens.com, ip: 52.101.66.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7TGKzJgROUX+CodunUKhTUGx0qYf6tV61Pd9cXmpm19w9rCm6XvE1hVhR4WAm+y8lIfh3MprocXqPihK0sKZV4uf1va6jNGNaDPcekg7c2lOZig2ytNMQEl8sS8I0+U3+H6C+CdtrjescCjnWM4sUrN3uXZGVUYPckggyGgdZPtNvGZF6yHvJxW0j9bFlwAgXHMfRlaSg7jiihid1wMmT0cV7YFdy0s/SkOQ5eW0S+alRPH5gF3MNaZZJyts5mL7wcTMSdfS5rHeovGcCiYyj4Da/pGnD8zvQjgecoVh4LA2SALRfp0Hp5/BVTVFr/VLSDewFesinIf2MYw8xSdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm+XCQlplCN/mwJU+EObLmf0j5DikY2dfTMmoBCvQYw=;
 b=kpdVdsQF4Kh8eZljTMdiT6lhG11dWfW+vXo4wPLBoUnFJ+jiWHjiKZTDEcUYGFro+Rl5AlQe4mlAl3zjOi8Xv2Bl3+jN+VX2mnS3V103iX1SSyVjhhZJd3g4STlCqUVWFkJwTgA8Kx7xlMWlxg0F1fly9MCPMjTGRlSxRdSE1utfsHAynbW9Bh0GEjshNyGc+TWTfuimlAMMH9bY6Ofw3FGCUXHRypM6D/pAgJUyFoSSDTkGOIQREh1WSCtd0IV7h8ZX66sIpWG687BY8mbdnpp0G6t5k52fz8DoGFjRdfFGWtqedphzW9vpKGrhSq3d/Kd6IAglF1Bs6cPZB831Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm+XCQlplCN/mwJU+EObLmf0j5DikY2dfTMmoBCvQYw=;
 b=m/K/BQOGhcRe8MyruciJvX/oQHnwcHQVF3A+GvTfL3XZtkwTJMMaYuifHuhWrLIOIahyBTtniKczqjk9P8FvuBJwgmbv4p7zrqGZLV8MZeUXZlhW0AE7P9i12jSZ9nBGQ7XCONHUOGHCM65X35R6lInkLNFUPWFmCsNOMcHexLGHr7p8vBn1sfOpoiX/kRs6A4GMfdLVdHMAlrlnp9N2XhXKZx+xqkvedcp/yxz+dyJpGLCJdutKMxZ/V5rbqM8oiY/zn9CHrZbTG/6oUrJ35q/xPVqzpMdtxZ1kclLRXqzrliM6xGHC2MVACDjgQdZevck9hS9u1n36Aq7e/aLsEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:31:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 17:31:07 +0000
Message-ID: <fdf179b5-ab4e-4594-88a1-f3871f3e7594@siemens.com>
Date: Wed, 7 Jan 2026 18:31:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 6/7] Add documentation how to
 integrate isar-cip-core
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 clara.kowalsky@siemens.com, cip-dev@lists.cip-project.org,
 benedikt.niedermayr@siemens.com
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
 <20260107132707.733180-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260107132707.733180-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:610:60::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e4cc7b-c9ed-43ba-c67b-08de4e128aa7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OFFsNktLOTJ5MDEzQWNuTktJZmhIUlVXcXdaZHBBRHdCNDViNjBwRnVGMGhp?=
 =?utf-8?B?VzZKVVpyMzF4aDdyN2dTT2FlaG1QMDdFSTM2SGdNdnk5RTJCMDZBMFhYNjRO?=
 =?utf-8?B?VU45Q3o4SmhxKzIzcngySmVSY1FlVVpmUG5NcHlkQkNGMXozdFdyYlNsOGF1?=
 =?utf-8?B?cks4cXhVOFhhbklkQ1FHQTlqSlBKdmdFYno5NW5UYVZBYlZjSXluS1lFZTlR?=
 =?utf-8?B?YTZmY2ZST3VDSWd6NWlPSkxVQ05UWU4ray82aHQweC93elByTnVaL2JzVzZD?=
 =?utf-8?B?cUdZL3Y2eWtId3hxNWdNcnVmZXVkN1A5K1F5WUNZcnpPRlp0SVpGQ2RhZFVR?=
 =?utf-8?B?ZkNJRFJRNHBqREJMUkY1eFNwOStlYzBvNkZKMFZrOHg0ZFFFWDQ4NmtjdlJX?=
 =?utf-8?B?MlN0VTJNQUg2R3dZQ0ZGbElEenI2aFo4M3RMVjd4ajdsZXo5ODBtNTJGWUtj?=
 =?utf-8?B?Wno0cG5FeXhIa2lIK1k3MjhOWEs1WjBXbFBPNjZZU002QjR2eDd2bkNpMm9Z?=
 =?utf-8?B?cy9NYjlpS3NiOUg5SjE0Nlh3OUlZQXVYdHVkTG0wcml4NkUzZ2U1RVpra1ZG?=
 =?utf-8?B?a3JVTVNxdHN3WHZiM1NNcnBMSW1xa2t6anBXK2xuWXNnQ0J3NnR6Mml4aHdK?=
 =?utf-8?B?QjJXSGdtdTVYMzBlRm12LzJkaUx1SHBnQXhnMFZCNnUxR2JpMmxNcWJ3bXM1?=
 =?utf-8?B?SmtzVnlKS0JtbktyNFN1RzlyM1Z3TmgzTFZsTXFxMXViSnhRRzVIdFEvRUVG?=
 =?utf-8?B?bjdlek1QV2NnU2tIdmE0MjRJOHk5dGpSWUtCOVVoM0d4aG0rK2c0MmEyVWFE?=
 =?utf-8?B?VjFMWFRYYjYzUlJYS0JOM242UUVyaFMvZ1EwSkk4aHg4RjNHQUlEeUEzMDky?=
 =?utf-8?B?ako3aXhPNDVwZ2UvQjlwbjJDRkRrQ2dseXNFbEowTi9QakNBUEFubklETk5n?=
 =?utf-8?B?Mkl5b3lEUCs0REhhUGwveUJiUno0NVpZWFhGL050NnorSDVsTlE5V0dCTWEx?=
 =?utf-8?B?c0p3L2oyOHpIWFFsUE5KZk12V1NlWXBDa2VhRkI2VVRsenR5TEdzbm1hNUha?=
 =?utf-8?B?bnN1ZCtycTBSb0NlclQ2NmpHL0FxK0Zid2FjUm5yVkdTZEhZaS8vRTFHWU93?=
 =?utf-8?B?V2hQUElvSi83Z3dMdThTeTNUYTBYeUlzSm93QkRka2VDaHFIOUdQclJzN3BZ?=
 =?utf-8?B?U1JiSUVNN1MrYzA2empRaWE3U2NCWVdMRXAzdTI0cVM3Y3A4K3FQNEhNdDhn?=
 =?utf-8?B?ZzUwTnZMZjZvZ20ybDBHTnpNKzRkYUt4THNTQXZuOGQ3MW9xV25Od2cyV2Vo?=
 =?utf-8?B?RENBMy9pN1N6b0tlTEpoQ3BQYm8vN1FwQmtDNlhWMDU1Sm5XVUxTbi9XSDh0?=
 =?utf-8?B?QWMyK2Nsc1M4cFR2T0FnVEJXUTdNMk9wbHVVZmRzSzBpUGRzZXRITzZhTzF5?=
 =?utf-8?B?eURxZlFrTGF4T3pnbEhmWWQ1VUdycTVVN1RjRTFFN1VRVGVFc1M2aUZaOWtx?=
 =?utf-8?B?SjgrZzNDWlpUQi8rdWtxdTNvTWJ0M0wvTm5ZWXNsb1ZDM1l1Q1pvZGtycVVq?=
 =?utf-8?B?em16dkJWVGM3bGVObkZXY1k5NStWUTJFSzBVNlpDVXQzU1FuckxBdkRKWVdZ?=
 =?utf-8?B?OUdKQmxhVXJFUXBVaEFCZ2plOGVaOEp3dVhpd2tnc1Y4Q2ZHZStKQ3BldEtE?=
 =?utf-8?B?ZEx0a0xHMkZMZmFTb0NMWnZHbFlvaVMxRlNHbkZqQmNYMkV4Q3FKUGFGekdn?=
 =?utf-8?B?K1Y4TU9XTUIrL2dxWktzUkZUQ3h4dFJ2Tjl5K2UxWGJSdHVqZHpuVFVNcFdq?=
 =?utf-8?B?cjJ2TGRCaCs2S0RpWW5zZ3BRSllpczZxRllvVDdxUDVzdThQTjYySWhHS3pH?=
 =?utf-8?B?SVFodG1oTVFFWDlnZ0pRaloxRjB4N2ora3dPSWFPOXRnbGF0TklueGE3VFo0?=
 =?utf-8?B?UzdLcEh3UloreDluYytEVDhGNEVKb2gxU2ZyK05iS01KUzZadjhGdmsyd0lP?=
 =?utf-8?B?bDA1dzgzYTVRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1lGcmlxV0R0YWpsUFFidWQrSFI0YmtSOFYxYkZnY2hyMDQrc0VpNXdObEJF?=
 =?utf-8?B?M3ovc1lGMStYTlFudGttbTJTR1ZMVFNqeTgrVitrT285Y0VmNXNOZ3AvRnVp?=
 =?utf-8?B?RDIvd2N1QU1zazZXQ0xSZk5yTGdTbU5YdVR5cUFyOHZJNHdEZy9yN3lLdDNu?=
 =?utf-8?B?d1MvWHlMcFZqOUdvZzhkSFpZMWJzNHlOM2ZYbUducWMyM0lLb2JnVlAwQmZi?=
 =?utf-8?B?WHp2MmVzQkg1cEljbDdEUFBEcnlmc01KdDNsRXlUai80QkpCOGpvL3hPcUo1?=
 =?utf-8?B?c2lYN25UbFhCamJBU2VuNXZNSW4vbUZLc0ovRDQ4LzdObWtQSTAxSFByTDAw?=
 =?utf-8?B?VjB6dEJFSzRvR2xHLzlkdHczbStzK0J3bGpTQXQ2VjJaaHpJbFlNU0w4Znpy?=
 =?utf-8?B?SS9XMzJpNS9LTk5tcXpodlVIVjJ5dG5qWDV1WE54dkY1Q0hGYURGL0d6eXVM?=
 =?utf-8?B?dm9ob0l1YUNMNnE0cGtYeGtQQzQrc1RUUDRLYzJLZjlWY25ldnNLeHp5dVBx?=
 =?utf-8?B?TmZmRHcrSzF3b0dDOWlXcTVFSzJHUjhCNWd6M0tkdkxvZ0M5UEVlYjJKaW9o?=
 =?utf-8?B?NXpwa2pOVW5yd214cFE2dGtmbWZvcjNTV2RpSlg5NzVsWSs2dkZTSVZVazl0?=
 =?utf-8?B?ZCtKandFZVR1VXFxVEhpNUZUMjFiQ1V1ZWN3TVVLNzl4akFLcUlJS3RkMnBY?=
 =?utf-8?B?MVpabmNlcTFjQkN4VWMvd0Q1Ykt4S2VsNTBNVWZaazJmZ0dQbHh1YW1EbWll?=
 =?utf-8?B?Wkg3bEFaVk5NWVlNYjFvOEZMUUxRU0IwVVd3ZW9kQzdmNUlqdnNnQUtxeTIv?=
 =?utf-8?B?cUNzZmU2Q3AwSzhzbXh2bE8xSGxMcVd3bTk5VndiaG45bEMwZXBIUUtRQjgv?=
 =?utf-8?B?a1pkMS9WbUppZTIrd040Uk83a2RsU3dXUXYxKzU0cUdtVHRickZMSDZXanVN?=
 =?utf-8?B?ZFBZcFZSQ1lmeHRZbTRGWGNQWjFLSXc3dHVmdXlBYXpUOXBVdGNNYlRPVHdm?=
 =?utf-8?B?RllZTWNKd1BtNi8wUUNIS3ExcHppam11Slg2dXlmMnZidXJQTTFRQU9jMEVG?=
 =?utf-8?B?MlpsMWFKekV0SWttTDUvek91eXhiR2NkZGMxQXYvVmdmZVZMN1BlbjJKVHRT?=
 =?utf-8?B?cmlmYVVDWDlKTjNVMUkxMkF2M0g4QWRJZFllRVM1MGdySmY5aVVzd2xKMUFs?=
 =?utf-8?B?RENTcTJJUnlBVFRnZUNmblBLaWV6YkI5UC9CM1A2UkZKa3RzbXYvSVFIRWNO?=
 =?utf-8?B?MFVHYTgyNnZYN1JNZkpEeTZqcHFrR3JWaGgxaVlBZmRHK1pTeVlBTjkwNkdJ?=
 =?utf-8?B?VWIvdUx3R1R2TnpzM0U0SGwrMkl1K1oySGxsNFBzMVBzZTloOG1FSWdJT0RL?=
 =?utf-8?B?RDNKZHlVK013UW9uMjc4bzA1eEZhTnlDVUFINzdUSGRCRkViUms4TmVsc3Nv?=
 =?utf-8?B?bTcyL2xTV2l1RkRLUTZpWldGYWx4NXYvRjAxNG1qZ3ltbDNZQUUwcEdybXlz?=
 =?utf-8?B?VkJQVmI2anhPaFlIeFJYcHQ1RnVlZnY1WHJzWnBqZXQvWDdWWUU1T2xkQ3RZ?=
 =?utf-8?B?cStpT1oxOHZEcGtteTNOdlh4UzMzeFlnY2YvT1JkazlMTEhaZlZ3Y0hodFZ5?=
 =?utf-8?B?a2FaQnRhK29CWWE0Ky9ocktVTmVtTGVTZmFMWjZaaFhvRHZsNHhXWWdwd1ox?=
 =?utf-8?B?YkJVVSt2Q1hCWktpb2loT040bGx1S3o2L1B2c2lIcXorckIxV1RZNEd1RzM3?=
 =?utf-8?B?RnZrbHZVUldKOGEwenUvS0YxT3EvMU55TzVFZng4SHBueXJOQUhGQ3gxcjBQ?=
 =?utf-8?B?dk1NQjVRZHZJSndUM2VhSjh5cUx2NVZleVlkcVlURjBjeEtWM1ZuUnZ4VFNJ?=
 =?utf-8?B?Rmt2R1AvcjJvQ2hiMS9EYW0wSDdvVGJwTjZzWkRFOVp2b2F2TkpsYTZuM2pL?=
 =?utf-8?B?N3ViT0l6bTFKVVJwT0M2dDZwV2M3QnVHWWlHQWJxam1ISEVTcEszeU1jdTc5?=
 =?utf-8?B?QkMwQXRnWmN4cDgwbHRMVytjUkhyRExKeHhmUkxFNHk5dHFoWFRVWHFVQ0wr?=
 =?utf-8?B?dElJQzhWVEpwRVZPTTJoUWRQMW4rOEZFcVhIWW1pYVlrK1RrMlV2M1hDWFQ1?=
 =?utf-8?B?TWVKV2hYUXN3bjVHMHZWcWx4NjBSN1dxd3RhWlVIQkxKYkpSWEFyTjczNEJZ?=
 =?utf-8?B?MU1SQkl6Q3YvM0pSSmN0aFFOQm9oWE5GejBnSk9Hd0JBWS92anBWcmZNbDdh?=
 =?utf-8?B?M1M2M3NwdDZHbjNCTFhwbnA1TlZ5QldIaC8xSjI2Y1BCNUpnaWVOdXJiZm82?=
 =?utf-8?B?RTZvN1lpOWJNaFFTdTl2ZHFyV0VzY09NTFRSRGtLTllzUUI2emtJUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e4cc7b-c9ed-43ba-c67b-08de4e128aa7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:31:07.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3qarME15UKw1xXgCAy36c26Q/ZB5cxNSKc/4HnqLipGzn6dszZZWtfakgEWldymN/pCK1jfaTDeYN6YZBL+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 17:31:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21417

On 07.01.26 14:26, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.usage.md | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 doc/README.usage.md
> 
> diff --git a/doc/README.usage.md b/doc/README.usage.md
> new file mode 100644
> index 0000000..1e1973c
> --- /dev/null
> +++ b/doc/README.usage.md
> @@ -0,0 +1,51 @@
> +# Integrate isar-cip-core in an Isar layer
> +
> +This document describes how to integrate isar-cip-core into a existing isar layer and build a
> +A/B root file system which can be updated with SWUpdate.

"Usage" is broad, but this document is only about A/B updatable rootfs
at this stage. Is the vision to describe all the other customization
points in this file (e.g. overlays, secure boot enabling)? And what if
someone only wants certain recipes from isar-cip-core, e.g. the kernel?

I think the filename should be clearer, more narrow, or the document
should at least mention what may still need in-depth description.

Jan

> +
> +## Add cip-core to a kas.yaml
> +
> +Add the isar-cip-core layer to a kas-file:
> +```yaml
> +  cip-core:
> +    url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> +    branch: master
> +```
> +
> +## Configure the root filesystem for A/B Updates
> +
> +Add this line switches the root file system to a read-only file system
> +with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
> +An additional image type is generated with contains the update artifacts.
> +
> +```bitbake
> +require recipes-core/images/swupdate.inc
> +```
> +
> +## Create a image description
> +
> +Create a new wks file to describe the image. It is recommended to use
> + [wic/qemu-amd64-efibootguard.wks.in](../wic/qemu-amd64-efibootguard.wks.in) as
> + the base for this image. As all necessary variables are set.
> +
> +## Set variables
> +
> +Generate the uuid for the root file system partitions. These variables are used
> +by SWUpdate to select the update partition.
> +```
> +ABROOTFS_PART_UUID_A = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
> +ABROOTFS_PART_UUID_B = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
> +```
> +
> +Set the certificate source and mechanism to sign the update artifact.
> +
> +```
> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
> +PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
> +```
> +
> +Set  the variable `OVERRIDES` to `:swupdate` to customize the initramfs:
> +```
> +OVERRIDES .= ":swupdate"
> +```

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

