Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED3EB26F3
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 17:36:15 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25465.1770744972523386042
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Feb 2026 09:36:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eqZu90lU;
 spf=pass (domain: siemens.com, ip: 52.101.65.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOceHt5zFYlJK+L7OWR/96B8bK1ad/2YtJoeW44USQad//RquKYfjtEBRP7EJOGCPnsopr/qpBrfYHN86I6RG+YSjX4H+ytLGAL/tBU/M4+oq14o2Ua8LKSQzYtbHT6PrwVYnBoaoAgCC9Cjp2XzG4xJQ29YrLPhWZgaF6WgeNcK2ZG4HRZFiJnd4bHhh971+X1NDL+CObnUQyhyAx56QW/NybszoR55dE6WWAWyC+7wvOhAWeYAHLgIVy34MWKqupEjdGWU7rzKvJI8mXlShE/BdErvJbhAf8wb3K1G7cp/g6c2JV/oxGszsvEZpiL9n/ZyxJ26/B3t5CBgjg2K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77xEgXn8JDVrjrcLq8IjnaUFTOir4S0gk5aR0RBgl84=;
 b=cnWxgbt2VeqOAmKbswFhewJcH9gL1yFv4lFeS+ZfLc+ips7Fu0q7S7KunLwUxT25ZKNC3JMuwrs7PMiMwGrc24eN5OiOJ/S+tA2dc5lEu8g4+wEvfQygXGumW96ljpGGeOsm73Ljcn2MS4a6nRBIyflVWqh5qlKtTmgFqI9eizxLSO8HGun8Al0dTnhH+mQSg7PUExuTRrv0iOXrCfjeunECELiz1B2Yqd1OgZtJbIfvGC5NqRMYMG8nxpOwEVi9v0FAG9h1x1/BuGD7zbjBGw9F3G7EDE3c5263mEguO9wJwNQtrI17mM7lJepwy36g0Z8rxMUoF8P+9sTYgx1LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77xEgXn8JDVrjrcLq8IjnaUFTOir4S0gk5aR0RBgl84=;
 b=eqZu90lUfSwyDc4xXU7oas+V8BXjm90DmnZj3GNlzmyYLChbPSk0PR9DTA8xhBi7te7DUNq616ytFZ7lmANn8JJgUO4j+Si09/emRX4fGbMytU/jjHQrADUbSNzapVEf4fcBMfiJSFtM5dz8YcMxJYS+RkoVzOKMpjHKD8hiwsuprUBMOIvs35GRggkLgPRN8oj8JED0nC5Yz8DHlzg8hrQ4/4h1fTj8HgiWlAIEwcTzwcPcVE/kAWRvFdYwoBChqwuDrbAUk2TZJK/bK4Txnp3Erga7RD78pQibmrnbNZGgccNVJormOp+/Sm/kzNEx0GkHEDSeFO1/5/MjoviUhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS1PR10MB7617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 17:28:30 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Tue, 10 Feb 2026
 17:28:30 +0000
Message-ID: <1e646870-4580-4fae-bced-9d7629373384@siemens.com>
Date: Tue, 10 Feb 2026 18:28:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
From: Jan Kiszka <jan.kiszka@siemens.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
Cc: s-adivi@ti.com
References: <cover.1770037068.git.jan.kiszka@siemens.com>
 <TY7PR01MB14818C90B18581467313DC36DCD62A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <4db81fef-2a03-4880-8c04-1de20c00da7b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4db81fef-2a03-4880-8c04-1de20c00da7b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0046.namprd18.prod.outlook.com
 (2603:10b6:610:55::26) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS1PR10MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: a0355749-1c76-48a6-92bf-08de68c9ce8b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TmpaR2x0WGh1aVN1dWNuRVh3R3ZyeG1WVTVzVWpDS2t3QWh6WXl2YUQ5dTEy?=
 =?utf-8?B?WFROeldtQ2xDK2VEWmoxUGE4K2hsZ0dOV0hITm0vR1hsSERKcTV5bnY4NzVC?=
 =?utf-8?B?cU5aWk1BYTNpbytiVWxFMzdEaDZaNm1EeXNOUXB3Q2cvb1lMQk9OV0lYTEdx?=
 =?utf-8?B?Z0cydE41bFMyYzcvdHRsTUhDaks2Q3IxU3BXRW16dVFpcEVvSHloS2QxaW00?=
 =?utf-8?B?a01wZWVaL1NtZXYwekxiSFJLRi95bmQrYXRiaUt5V3IvZUtzUjl0T01iNXFU?=
 =?utf-8?B?M25OMTl5WWdaL2pyak5vOFFidEJYd01FL0lDZFJFbWtLYmErNkplTVNWRzVY?=
 =?utf-8?B?dWI4V0IwM1MrMysxRFpqWm1EVlNpMEluUFU0eFk5cGs4RHpNbHI1TnBodVFZ?=
 =?utf-8?B?Y2V6dnZpeWROcHFkaUxYU3RIRTFaK3FDeDRkOE1vczdoR0hIRnRMdzV1YmNw?=
 =?utf-8?B?MjJuZDNxcHVGamJZYzZTM0dCY2NYTjBoZDg1eVBGYXZ1cmJYZHRnUlNxd2dY?=
 =?utf-8?B?QXJlUWVZTy9HRTJvVUtVUTBnMCtURUZnQW9yZkxnWVRsZkZpVElxSWVkT0dD?=
 =?utf-8?B?czQrSk5jQjY4Q3VlNXljQzJuRHdBMjlGbkx0ZWlWeW1vaTNPaitLTU8rWkhQ?=
 =?utf-8?B?dm5Zb0V4Q2hRc3RJU3lLcC80QmZJKzk4SHQ3UENLTjhyVlovNExFS3FCd2RK?=
 =?utf-8?B?L1JTWDk5bXhMc284NFZPN0VmV285UmFmemR2NlozZkZRZ3k2dC9JMEZReUhZ?=
 =?utf-8?B?dEg5b2hlM3ovbkhqdVVpZ1dUbHdibS84OHNraXQySHRLR3lTM21BQ09QVXZS?=
 =?utf-8?B?dWlMVUhDQnE0NitJNkE1SzRxbkpZRUxKV1YxcW1PZTlCSTAxQjJESlhaR2xY?=
 =?utf-8?B?STZ2ZzRxZ0FVVkM1NnJ5eWNxN2ROVko3K08xbmRyRXQ5dEtjR2dJZzQ4Rldj?=
 =?utf-8?B?OVNqd2dxOWVYcks3blk1Nndxejlkd0dtN2xZaEF3Mm9ObEJQbDNBeXcxQ01l?=
 =?utf-8?B?SGRkSE1PaGRRVkFBa0UrQzF6UzZhUytVUWlGTVFHZDVWdTJJem91UnJ1clJO?=
 =?utf-8?B?MXZJcnl1aEtEOFE3VjN0enR3a1A0NmFVUHVFSkJ3OThneDF2QkVlczVOME5W?=
 =?utf-8?B?d3llaGNZWWVsMUZVcEQwZ2s5S0c4a2UwdWc2NzZzbVRLYXVIRnF3Q0FNYVU2?=
 =?utf-8?B?a3lVQlNrU3lUWnM2OGFOdnNXazl6OGVIVnFKNzNXdDVDUkZpVkl0ODl2eFJQ?=
 =?utf-8?B?QlBtVzVsNmJMMVFUT2Z2UW4ycWdMNE1XL0t3eDNqZ1JlbFFobGJKNHJvbWNu?=
 =?utf-8?B?YXA0S21GT1BwQnc5WFI5VUpseVdYbFpSZlllSmtVKzNERlRwMmxRK1dmTCt5?=
 =?utf-8?B?VWRJT2NKdU1hd01kSnFSYXFCTkxUa2RWdE5SZDFXOUlIeHV4QjkxRkVrWDVo?=
 =?utf-8?B?VDhEZy9oR1NEKytYMkRXYUNwcUlqS2lPQjBqbzFnMUFNelY3Q2hub2hydFVu?=
 =?utf-8?B?UkY0R01oOE1id0hFSm9PUmF6Si8yZDNRZ2ZQVG1FQ3lRaE9PWlk1Yll5UkhE?=
 =?utf-8?B?bWJtQ3RUVEszU3M0eFV2cGJjRFV6MnRBRVNRdGc4b1RqR3VoNld6a3RyTk5V?=
 =?utf-8?B?Zkp6R2thTTVWUXhGYnBGWkZjemt4UjRpRWNRalBTOERXa0FrWWJrOU9mVTdM?=
 =?utf-8?B?YVVhY3k0ejE2NU9NdEp0bVZSK1JoZ2NIeSt1Z0V6N29ib3RsaTJ6WGtVODZZ?=
 =?utf-8?B?K3VFM0g5RGsxNmF2L1NydEpFWlBPSzYyL050RFBUOXlOeSsrKzV0ZDdzSXhR?=
 =?utf-8?B?MTZoZUhrWnNxTHovVGlseXNPQ3Y3Uy8xQzZXL0lXUkJnR2dvS1VNNEVaeGdy?=
 =?utf-8?B?T3R0d1Q1RzJTL2xCRkxDMUMrL1psRUR2SVNRV1o4VlVYMnQ0ZE5RaktmNkRD?=
 =?utf-8?B?ODZWTW9YUE5qSUYyR013Yi9Pb3NzNldpQlNGbWJPa3VtbWlLMUZqVGh2RmVl?=
 =?utf-8?B?TklDZFNkSWZXeTZtVjNDVTZKN3RMZzJRL2dvalJZOXVFZjY1REJDUG9TaUFM?=
 =?utf-8?B?T3F2Ujg1U1ZyZFk5RThGNVV5SjZUbWp3MXFwb3dtZ0U2SkJIakljL1dpZWF5?=
 =?utf-8?Q?jQHU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZG5RM1JkQXdiRGZGL21Od2p2RHMxMXdMSHRsNWNBNnQ5YXBZcEx4TE1qdlB2?=
 =?utf-8?B?VmMzQjI5VkNCZ1RYV1F2d0ZzVlhqNkRCcjJpSm13elZqOE5ZZjkzZGJPQlZy?=
 =?utf-8?B?d2RhNmVpWjZEd3hremVRTVI0M2hpTmlUa24ybVZrVFlzL0tFemFTelo2U24x?=
 =?utf-8?B?eXVPTnpDSmhiZ0NNeVZxSlNsN3hUc1loZUg1RkM0aGJmMTQvTU1aVzV2MCt0?=
 =?utf-8?B?VXpReGMxQjZ6KzdhUlAwRVMvb2RUQmVCRWg5L1VYMkdUKzRXVysxRWNKM0RG?=
 =?utf-8?B?aWRKVnZVVndBT2ZXdUxrcFVDdlJzZGV0a0sybGJOLzVpSTQ0N3RiUGZBdkl1?=
 =?utf-8?B?YTVQVFUwR2Z0Mk1CbjhobWxyRGNNM3U3azdZRkY1MktPSWF2TFlNRjQyQ2pi?=
 =?utf-8?B?MWJKd21JWk5vckdyOG9naW96MTBpb3BCT1AwYXRJSkNoU2Z5WldqSWxJbEda?=
 =?utf-8?B?S29OQ2l4R2sxbmNnRkFjV0wyV0srUFVCenNndDRWdlNoT2JRZlNsM21YMlVZ?=
 =?utf-8?B?dStBOGZrN2JQdUp1VWpoTTJrazgrY3Aycm9uUnpDTzhIMHZBV1J3YU1YZHEx?=
 =?utf-8?B?ZFoyUk1mZVVqYlM2MjZJbjB3dEVBYnlHd2hYTDY2djVKOUNpV3Rub1pETnll?=
 =?utf-8?B?dmRaSzhPbmtkTktjYWNkdlh1TStUQ09BenRFZ25yUXB1MlNZRCs5emdDUmg1?=
 =?utf-8?B?a0k0dzJzUlllQWorcldjVGRhMFJPMlNqSTRBREVqd2QwSlJHNWhYSk1jS1FW?=
 =?utf-8?B?UW9VYjF2MzkvbVUzbUd3Vk85Y1dTR1lZbVhNVXJ2Ky95Zk9SS3BiV1ZzWmI4?=
 =?utf-8?B?ODdqaEhzM3ZjWFNCRFpSa0tJNjlxUStkbEwwOStuVkZyRGQ1N2drTVdUcVN0?=
 =?utf-8?B?T2svUDFWWGl1VHNidXdISzFUNjhFczZ5R3JuSHBPOVYyeWNwVHVlSi9IakNj?=
 =?utf-8?B?TTRBbTFQdTFqbjQwTFordkZyVmRQRlV6WmlQbVNKRUNkK21Cdm0vZ0J5UC9i?=
 =?utf-8?B?VGxUN0hkR0ZXclB0OFhNankwNEdIMWJaN0xwM3hLdzgxWE84WVRKanc4OXJV?=
 =?utf-8?B?RkwvaTJ3aGJsVU1zZkMyaVYxSU1namFVYjFJRnBSMmMxcVBSTmhwTDE2RVIz?=
 =?utf-8?B?ZEdCNDFnTE1xd09pV0hsSmFUU05IZFVWQXYxWVZBTWV4WVo3dC9xcWQxQk1G?=
 =?utf-8?B?ZzFEUVN5WXp4WmxzZGdSN1JrVTZrNDFZMjZNeXlOWmEzd0N2TjVoWGNNRHRx?=
 =?utf-8?B?eXoyenhmaHJtb0FCYW9kSEV3T3FKQldDNzBMNUJXNXVoeXNRM0JzdkZsYkdX?=
 =?utf-8?B?MjJ1OTU2ekJCWmNVUFFLNFFOL0ZlaU9JNmtXYlE2cGs1bWhCSUVPVDhmVkU0?=
 =?utf-8?B?L3BpRkpVUkRrZ3BkNkVFNkhOQytIMjNFQU1MUkJ0YzltR1FGTEJKdXZoOTRh?=
 =?utf-8?B?dTRvcmFUVkpKN0NEeGtzTXRHUi9yYjJpeVVYam5YS1ZJVHAxNnYxYThlNWRK?=
 =?utf-8?B?a203Mm55bjZINkZ0WEw3UHBXNSsxMlBDYzhKSHZvU2JuclhIZ0lES3FDVmdH?=
 =?utf-8?B?MTYyM0FvdURtTndPazE1YWE4Q2VqYXRQU0hlcVhrbzN6eDk5UytjbkhITEZF?=
 =?utf-8?B?TGhuS2ZyV0pBTThmc2RxK0xmRDhVZ0QxNmhPQ0JxR2YzYitmTlJJQ2VXZkJn?=
 =?utf-8?B?OXROVlhMQlZYcHhwN2tLRkxtaDNieVNkRkJja3BsSi9MS1lEckZrL1JVeklP?=
 =?utf-8?B?Z1BXUFRzSmt5VlJ0d3hmenh3NWJzTlJUS2lpbnJ1QjcvVm04TVk1MXJZQS85?=
 =?utf-8?B?ZVFNUFgwUFVVak1HWnQxWFFGTW1SNkowQlRpME9hVkIzdXVSVmhrL0NKVEVz?=
 =?utf-8?B?Ujk4Y3o2Sk1hMXZIRmtZbmlYM0xwSjVMSjJPOHVGRFJuc0dRb1pCV2NkVG5k?=
 =?utf-8?B?LzVxbnBqVHIxTlh3bFVWSTFCdHFVbytjVmd6c25DUFBxZVR1VUdrZWR1Qkox?=
 =?utf-8?B?U2pBOFl2MWcvTXlaWGZTSXVPcWhZMnpEa05ub1lISjByLy8yakZRb2lxODJx?=
 =?utf-8?B?cnlsLzJQRmpnY3hnaHdNcktrNzJDUk1Wb3RYaHdwak1VQk1aamlBb0xTYVFa?=
 =?utf-8?B?SDBWUW9LVkMzLzJxaGQ5ZCs2eG9sNkVXTlVQVTRFK0RRZWVSSVg1ODg3U3p1?=
 =?utf-8?B?bnF6OG1pT0pQVHdvUGluQ09oa1kyU2FRYnlPKzcxaWUyVmNiSTQ5d1lLc1Mw?=
 =?utf-8?B?RVQ1RUFVaUNUVk9BTVNob25jUVlFaWJhSWVaUlk2RFE5SXNpL2wvVUZ0S2U3?=
 =?utf-8?B?am1vbVB0WWtPWlFnWnRUZGtROGh1RGlSaG15UzFJalczNkpKL1ZmQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0355749-1c76-48a6-92bf-08de68c9ce8b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:28:29.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwvpSSorTY7EJJRkZv7J0s2NMflKG6uBVdf9odbdDqhX/WsKdFgAQJ4AOGrf+2jgS5ERpctHSq4wOu9AahY5Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Feb 2026 17:36:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21854

On 10.02.26 09:18, Jan Kiszka wrote:
> On 10.02.26 06:04, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
>> Hi,
>>
>> Thanks for your patch.
>> I tested this patch series on 049ea8ff8370a10d88214b2d488ef6f7c1d28a4e (master)
>> My board fails to boot. I pasted the boot log below.
>>
>> Best regards,
>>   Nobuhiro
>>
>> ```
>> HSS: decompressing from eNVM to L2 Scratch ... Passed
>> DDR training ... Passed ( 5401 ms)
>>
>> ---------------------------------
>> --        BeagleV-Fire         --
>> ---------------------------------
>>
>> [5.464693] PolarFire(R) SoC Hart Software Services (HSS) - version 0.99.36-BVF-0.3.0
>> MPFS HAL version 2.2.104 / DDR Driver version 0.4.023 / Mi-V IHC version 0.1.1 / BOARD=bvf
>> (c) Copyright 2017-2022 Microchip FPGA Embedded Systems Solutions.
>>
>> incorporating OpenSBI - version 1.2
>> (c) Copyright 2019-2022 Western Digital Corporation.
>>
>> [5.495680] Build ID: 3f0ed536ff6a0aaef3c9b81896adaee39ec4d8c1
>> [5.502538] Built with the following tools:
>>  - riscv64-unknown-elf-gcc (xPack GNU RISC-V Embedded GCC (Microsemi SoftConsole build), 64-bit) 8.3.0
>>  - GNU ld (xPack GNU RISC-V Embedded GCC (Microsemi SoftConsole build), 64-bit) 2.32
>>
>> [5.524411] NOTICE: Running from L2 Scratchpad
>>
>> [5.530053] Serial Number:
>> 9d5ab5e2c5711676ace9e5cd4b2b1dd000000000000000000000000000000000000000000000000000000000000000000000
>> [5.542726] Segment Configuration:
>>         Cached: SEG0_0: offset 0x0080000000, physical DDR 0x00000000
>>         Cached: SEG0_1: offset 0x1000000000, physical DDR 0x00000000
>>     Non-cached: SEG1_2: offset 0x00c0000000, physical DDR 0x00000000
>>     Non-cached: SEG1_3: offset 0x1400000000, physical DDR 0x00000000
>> Non-cached WCB: SEG1_4: offset 0x00d0000000, physical DDR 0x00000000
>> Non-cached WCB: SEG1_5: offset 0x1800000000, physical DDR 0x00000000
>> [5.583609] L2 Cache Configuration:
>>     L2-Scratchpad:  4 ways (512 KiB)
>>          L2-Cache:  8 ways (1024 KiB)
>>            L2-LIM:  4 ways (512 KiB)
>> [5.598104] DDR-Lo size is   32 MiB
>> [5.602358] DDR-Hi size is 1888 MiB
>> [5.626176] Design Info:
>>     Design Name: CI_DEFAULT_FD28A2CA1789CDC1137
>>     Design Version: 02.00.2
>> [5.636592] Attempting to select eMMC ... Passed
>> [5.891124] User button NOT pressed
>> Press a key to enter CLI, ESC to skip
>> Timeout in 1 second
>> ..
>> [6.900764] CLI boot interrupt timeout
>> [6.905278] Initializing Mi-V IHC
>> [6.909357] Initializing IPI Queues (3304 bytes @ a02e660)...
>> [6.915867] Initializing PMPs
>> [6.919600] Initializing Boot Image ...
>> [6.924200] Trying to boot via MMC ...
>> [6.928714] Attempting to select eMMC ... Passed
>> [7.183124] Preparing to copy from MMC to DDR ...
>> [7.188654] Validated GPT Header ...
>> [7.204547] Validated GPT Partition Entries ...
>> [7.209842] Boot Partition found at index 0
>> [7.214789] Attempting to read image header (1632 bytes) ...
>> [7.221221] Copying 601712 bytes to 0x103fc00000
>> [7.230057] MMC: Boot Image registered ...
>> [7.234918] Boot image passed CRC
>> [7.239258] Boot image set name: "PolarFire-SoC-HSS::U-Boot"
>>
>>
>> U-Boot 2026.01 (Jan 01 1970 - 01:00:00 +0000)
>>
>> alloc space exhausted ptr 2010 limit 2000
>> CPU:   sifive,u54-mc
>> Model: BeagleBoard BeagleV-Fire
>> DRAM:  1 GiB
>> Core:  68 devices, 14 uclasses, devicetree: separate
>> MMC:   mmc@20008000: 0
>> Loading Environment from nowhere... OK
>> In:    serial@20000000
>> Out:   serial@20000000
>> Err:   serial@20000000
>> Net:
>> Error: ethernet@20110000 No valid MAC address found.
>> No ethernet found.
>>
>> Hit any key to stop autoboot: 0
>> switch to partitions #0, OK
>> mmc0(part 0) is current device
>> Scanning mmc 0:2...
>> Failed to load '/'
>> Failed to load EFI variables
>>
>> Error: ethernet@20110000 No valid MAC address found.
>>
>> Error: ethernet@20110000 No valid MAC address found.
>>
>> Error: ethernet@20110000 No valid MAC address found.
>>
>> Error: ethernet@20110000 No valid MAC address found.
>> Booting: Label: mmc 0 Device path: /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-)
>> EFI stub: Booting Linux Kernel...
>> EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
>> EFI stub: Using DTB from configuration table
>> EFI stub: Exiting boot services...
>>
>> Error: ethernet@20110000 No valid MAC address found.
>>
>> Error: ethernet@20110000 No valid MAC address found.
>> [    0.000000] Linux version 6.12.63-cip15 (isar-users@googlegroups.com) (riscv64-linux-gnu-gcc (Debian 14.2.0-19) 140
>> [    0.000000] Machine model: BeagleBoard BeagleV-Fire
>> [    0.000000] SBI specification v1.0 detected
>> [    0.000000] SBI implementation ID=0x1 Version=0x10002
>> [    0.000000] SBI TIME extension detected
>> [    0.000000] SBI IPI extension detected
>> [    0.000000] SBI RFENCE extension detected
>> [    0.000000] SBI SRST extension detected
>> [    0.000000] efi: EFI v2.11 by Das U-Boot
>> [    0.000000] efi: RTPROP=0xbe335040 SMBIOS 3.0=0xbf387000 INITRD=0xbe2ed040 MEMRESERVE=0xbe2ec040
>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'non-cached-low-buffer': size 64 MiB
>> [    0.000000] OF: reserved mem: failed to allocate memory for node 'non-cached-high-buffer': size 256 MiB
>> [    0.000000] OF: reserved mem: 0x00000000d8000000..0x00000000d9ffffff (32768 KiB) nomap non-reusable buffer@d8000000
>> [    0.000000] OF: reserved mem: 0x00000000c8000000..0x00000000c9ffffff (32768 KiB) nomap non-reusable buffer@c8000000
>> [    0.000000] OF: reserved mem: 0x0000000088000000..0x0000000089ffffff (32768 KiB) nomap non-reusable buffer@88000000
>> [    0.000000] Reserved memory: created DMA memory pool at 0x000000103fc00000, size 4 MiB
>> [    0.000000] OF: reserved mem: initialized node hss-buffer@103fc00000, compatible id shared-dma-pool
>> [    0.000000] OF: reserved mem: 0x000000103fc00000..0x000000103fffffff (4096 KiB) nomap non-reusable hss-buffer@103f0
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000103fffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000080000000-0x0000000087ffffff]
>> [    0.000000]   node   0: [mem 0x0000000088000000-0x0000000089ffffff]
>> [    0.000000]   node   0: [mem 0x000000008a000000-0x00000000bdffffff]
>> [    0.000000]   node   0: [mem 0x00000000be000000-0x00000000be000fff]
>> [    0.000000]   node   0: [mem 0x00000000be001000-0x00000000be334fff]
>> [    0.000000]   node   0: [mem 0x00000000be335000-0x00000000be335fff]
>> [    0.000000]   node   0: [mem 0x00000000be336000-0x00000000be336fff]
>> [    0.000000]   node   0: [mem 0x00000000be337000-0x00000000be358fff]
>> [    0.000000]   node   0: [mem 0x00000000be359000-0x00000000bf386fff]
>> [    0.000000]   node   0: [mem 0x00000000bf387000-0x00000000bf387fff]
>> [    0.000000]   node   0: [mem 0x00000000bf388000-0x00000000bfb6bfff]
>> [    0.000000]   node   0: [mem 0x00000000bfb6c000-0x00000000bfb6dfff]
>> [    0.000000]   node   0: [mem 0x00000000bfb6e000-0x00000000bfffffff]
>> [    0.000000]   node   0: [mem 0x00000000c8000000-0x00000000c9ffffff]
>> [    0.000000]   node   0: [mem 0x00000000d8000000-0x00000000d9ffffff]
>> [    0.000000]   node   0: [mem 0x000000103fc00000-0x000000103fffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000103fffffff]
>> [    0.000000] On node 0, zone DMA32: 24576 pages in unavailable ranges
>> [    0.000000] On node 0, zone Normal: 56320 pages in unavailable ranges
>> [    0.000000] SBI HSM extension detected
>> [    0.000000] Falling back to deprecated "riscv,isa"
>> [    0.000000] riscv: base ISA extensions acdfim
>> [    0.000000] riscv: ELF capabilities acdfim
>> [    0.000000] percpu: Embedded 22 pages/cpu s50024 r8192 d31896 u90112
>> [    0.000000] Kernel command line: initrd=\initrd.img-6.12.63-cip15 LABEL=Boot root=PARTUUID=bac9149c-8332-4f2b-a225w
>> [    0.000000] Unknown kernel command line parameters "LABEL=Boot", will be passed to user space.
>> [    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
>> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 279552
>> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
>> [    0.000000] software IO TLB: area num 4.
>> [    0.000000] software IO TLB: mapped [mem 0x00000000b4e00000-0x00000000b8e00000] (64MB)
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]       fixmap : 0xffffffc4fea00000 - 0xffffffc4ff000000   (6144 kB)
>> [    0.000000]       pci io : 0xffffffc4ff000000 - 0xffffffc500000000   (  16 MB)
>> [    0.000000]      vmemmap : 0xffffffc500000000 - 0xffffffc600000000   (4096 MB)
>> [    0.000000]      vmalloc : 0xffffffc600000000 - 0xffffffd600000000   (  64 GB)
>> [    0.000000]      modules : 0xffffffff01794000 - 0xffffffff80000000   (2024 MB)
>> [    0.000000]       lowmem : 0xffffffd600000000 - 0xffffffe5c0000000   (  63 GB)
>> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> [    0.000000] rcu: Hierarchical RCU implementation.
>> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
>> [    0.000000] rcu:     RCU debug extended QS entry/exit.
>> [    0.000000]  Tracing variant of Tasks RCU enabled.
>> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
>> [    0.000000] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=4.
>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> [    0.000000] riscv-intc: 64 local interrupts mapped
>> [    0.000000] riscv: providing IPIs using SBI IPI extension
>> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361s
>> [    0.000003] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns
>> [    0.000628] Console: colour dummy device 80x25
>> [    0.000658] printk: legacy console [tty0] enabled
>> [    0.002546] Calibrating delay loop (skipped), value calculated using timer frequency.. 2.00 BogoMIPS (lpj=4000)
>> [    0.002624] pid_max: default: 32768 minimum: 301
>> [    0.002845] LSM: initializing lsm=capability
>> [    0.003339] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
>> [    0.003484] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
>> [    0.007294] CPU node for /cpus/cpu@0 exist but the possible cpu range is :0-3
>> [    0.012353] riscv: ELF compat mode unsupported
>> [    0.012383] ASID allocator disabled (0 bits)
>> [    0.012907] rcu: Hierarchical SRCU implementation.
>> [    0.012954] rcu:     Max phase no-delay instances is 1000.
>> [    0.013953] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
>> [    0.014734] Remapping and enabling EFI services.
>> [    0.016088] smp: Bringing up secondary CPUs ...
>> [    0.022908] smp: Brought up 1 node, 4 CPUs
>> [    0.025064] Memory: 869308K/1118208K available (11596K kernel code, 4965K rwdata, 4096K rodata, 2273K init, 517K b)
>> [    0.027073] devtmpfs: initialized
>> [    0.038369] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [    0.038491] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
>> [    0.039485] pinctrl core: initialized pinctrl subsystem
>> [    0.041172] SMBIOS 3.7.0 present.
>> [    0.041262] DMI: beagle BeagleBoard BeagleV-Fire/BeagleBoard BeagleV-Fire, BIOS 2026.01 01/01/2026
>> [    0.041357] DMI: Memory slots populated: 0/0
>> [    0.043197] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    0.044109] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>> [    0.044230] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>> [    0.044519] audit: initializing netlink subsys (disabled)
>> [    0.045141] audit: type=2000 audit(0.044:1): state=initialized audit_enabled=0 res=1
>> [    0.046076] thermal_sys: Registered thermal governor 'step_wise'
>> [    0.046213] cpuidle: using governor menu
>> [    0.072606] cpu1: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
>> [    0.072606] cpu3: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
>> [    0.072633] cpu2: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
>> [    0.096718] cpu0: Ratio of byte access time to unaligned word access is 0.01, unaligned accesses are slow
>> [    0.097122] CCACHE: 4 banks, 16 ways, sets/bank=512, bytes/block=64
>> [    0.097181] CCACHE: Index of the largest way enabled: 11
>> [    0.120441] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@3000000000
>> [    0.121236] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@3000000000
>> [    0.121476] /fabric-pcie-bus@3000000000/pcie@3000000000: Fixed dependency cycle(s) with /fabric-pcie-bus@300000000r
>> [    0.125897] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>> [    0.125966] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>> [    0.128097] ACPI: Interpreter disabled.
>> [    0.128795] iommu: Default domain type: Translated
>> [    0.128843] iommu: DMA domain TLB invalidation policy: strict mode
>> [    0.131990] SCSI subsystem initialized
>> [    0.133154] usbcore: registered new interface driver usbfs
>> [    0.133294] usbcore: registered new interface driver hub
>> [    0.133432] usbcore: registered new device driver usb
>> [    0.134931] efivars: Registered efivars operations
>> [    0.136181] Advanced Linux Sound Architecture Driver Initialized.
>> [    0.138550] vgaarb: loaded
>> [    0.139556] clocksource: Switched to clocksource riscv_clocksource
>> [    0.141508] pnp: PnP ACPI: disabled
>> [    0.167966] NET: Registered PF_INET protocol family
>> [    0.169012] IP idents hash table entries: 16384 (order: 5, 131072 bytes, linear)
>> [    0.174128] tcp_listen_portaddr_hash hash table entries: 512 (order: 2, 16384 bytes, linear)
>> [    0.174331] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> [    0.174427] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> [    0.175045] TCP bind hash table entries: 8192 (order: 7, 524288 bytes, linear)
>> [    0.178666] TCP: Hash tables configured (established 8192 bind 8192)
>> [    0.179690] UDP hash table entries: 512 (order: 4, 49152 bytes, linear)
>> [    0.180092] UDP-Lite hash table entries: 512 (order: 4, 49152 bytes, linear)
>> [    0.180915] NET: Registered PF_UNIX/PF_LOCAL protocol family
>> [    0.182745] RPC: Registered named UNIX socket transport module.
>> [    0.182811] RPC: Registered udp transport module.
>> [    0.182846] RPC: Registered tcp transport module.
>> [    0.182879] RPC: Registered tcp-with-tls transport module.
>> [    0.182913] RPC: Registered tcp NFSv4.1 backchannel transport module.
>> [    0.182970] PCI: CLS 0 bytes, default 64
>> [    0.184816] Unpacking initramfs...
>> [    0.186040] workingset: timestamp_bits=46 max_order=18 bucket_order=0
>> [    0.187088] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> [    0.188252] NFS: Registering the id_resolver key type
>> [    0.188379] Key type id_resolver registered
>> [    0.188418] Key type id_legacy registered
>> [    0.188526] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
>> [    0.188575] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
>> [    0.189155] 9p: Installing v9fs 9p2000 file system support
>> [    0.192783] NET: Registered PF_ALG protocol family
>> [    0.193047] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
>> [    0.193680] io scheduler mq-deadline registered
>> [    0.193733] io scheduler kyber registered
>> [    0.193884] io scheduler bfq registered
>> [    0.196727] riscv-plic: interrupt-controller@c000000: mapped 186 interrupts with 4 handlers for 9 contexts.
>> [    0.200586] SBI CPPC extension NOT detected!!
>> [    0.369675] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> [    0.376972] 20000000.serial: ttyS0 at MMIO 0x20000000 (irq = 12, base_baud = 9375000) is a 16550A
>> [    0.377122] printk: legacy console [ttyS0] enabled
>> [    1.457413] 20100000.serial: ttyS1 at MMIO 0x20100000 (irq = 13, base_baud = 9375000) is a 16550A
>> [    1.469786] 20102000.serial: ttyS2 at MMIO 0x20102000 (irq = 14, base_baud = 9375000) is a 16550A
>> [    1.482290] 20106000.serial: ttyS3 at MMIO 0x20106000 (irq = 15, base_baud = 9375000) is a 16550A
>> [    1.493011] SuperH (H)SCI(F) driver initialized
>> [    1.498885] [drm] radeon kernel modesetting enabled.
>> [    1.525663] loop: module loaded
>> [    1.536543] ------------[ cut here ]------------
>> [    1.541291] macb 20110000.ethernet: device non-coherent but no non-coherent operations supported
>> [    1.541323] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/dma-noncoherent.c:139 arch_setup_dma_ops+0x6e/0xac
>> [    1.541380] Modules linked in:
>> [    1.541402] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.63-cip15 #1
> 
> Ouch. I just checked my image again, and it used -cip14. Hope we do not
> have a regression. I will try to rebuild and retry later.
> 

It's not a kernel regression, your firmware is likely too old. Just 
rebuilt "next", and that image also boots fine.

I was told to use the latest official Fire image and flash a newer 
version from there. Here is what I saved from the discord thread:

  cd /usr/share/beagleboard/gateware/
  sudo ./change-gateware.sh default

With that, I get a nice beagle and

---------------------------------
--        BeagleV-Fire         --
---------------------------------

[1.44532] Initializing PMPs
[1.48924] PolarFire(R) SoC Hart Software Services (HSS) - version 0.99.48-v2025.03-19-g5e2caf41
MPFS HAL version 2.3.108 / DDR Driver version 0.4.031 / Mi-V IHC version 0.1.1 / BOARD=mpfs-beaglev-fire
(c) Copyright 2017-2025 Microchip FPGA Embedded Systems Solutions.

incorporating OpenSBI - version 1.2
(c) Copyright 2019-2022 Western Digital Corporation.

[1.85397] Build ID: 17f544e56d3ceb481fdfefde667001e70cf1ce24
...

We may have to add some documentation. Maybe you can note down the steps 
you take, and then we add that to a board README.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

