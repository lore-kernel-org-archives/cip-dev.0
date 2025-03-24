Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB2EC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:54:32 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.40])
 by mx.groups.io with SMTP id smtpd.web11.37172.1742817265579819885
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:54:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s4rl3WZQ;
 spf=pass (domain: siemens.com, ip: 40.107.159.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X75dKnVor4KMXcr1liLkeoaFfmQqFtTDMVWVKYIMCqjafsJZtkLudPoxPbNAdBcnOegGwufqXwvR6LAkC4gp+vtmyQqOxB4f+5b7FtFnMzZRPdOkpDtxfq6t1MKC5YZkuEb/xovJItFqg1UxPpcAKmxT4X6ADk20oQpS9EsD5DNnVP9urEABQQhh+qd/RRySdBHiaj1vnWMjj6x8nkSS8l4MNSOt7Mb5+XlmzzgrpGeJS04GCb5YQEPblawvzrY4cL35OkRsJi9CG4cbZuv2foNZLy7jJHwYSnLxaMvZ33+cZvNMNPdmz5hwxCdJQzVBwV+yVoFpg7FV2i3zrHZF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnVD5xSWqbQ3SkeZUzulo30bb9GSoDNBcie2WqfUAo4=;
 b=aomPMoKJvD+nxQaxq3bI58tjrxLfYkAlONo3A1e8ViWJnEOF5d7i5NnWauCh5ztvMKW5N9PPgxM8vPXLQndtXeYV1syytAi9WStYA3iFEUaU7gl9enmX5Tk16WyZuISqEIGcD/6ssPfLbgu/6JCRa7wGJzrkujqYsqGfTi3KASAX4B2qrkv4fcm55Jbf1GwTYwRlkAfLNikFy1UZFlRXy6Vqe+itTwYTMnAYNnZ9pWVABEk9CeML+u++QxgAUXf7TgGa+mOKObOIXetpOO2ZZzOe9D5eve4feT5bxbOaFHha4HqML7rxXDovassAnM1a0YK5QhbQ4n+LSNLa3f6a3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnVD5xSWqbQ3SkeZUzulo30bb9GSoDNBcie2WqfUAo4=;
 b=s4rl3WZQqeDyAOQULLoN2AFt8SjSpzwP0s4gCdGf9S8c56aMHWJydrE3NupS4CewHLBhL8DMLlB1qnPkZp6tochshlgODabZ4XPFxdi7D9rZZ9Cpe+dj3TpdZI0rq6Lc5thzvLzLq5/MPkR4IubwdXZD/vNTatxA+OCtba9lp9QrTNwKAcPssbN06JXkT1Qh8VQqHxaW/9lrQlaiqO1lT4/HtZKS2ljNf2ETDnlDUC8Po+4Xpl/aTXuheCXB4XowHYNyrJRAo9GYnBEZEps4v5ccY7Aecrx72l15jljHHXE0w2rTVeXuhAHB2Q5GDAKBuTPnIILZxF4DusZxyyZtuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7853.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:54:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:54:20 +0000
Message-ID: <a1270914-e11d-471d-a63c-77dddcb958cf@siemens.com>
Date: Mon, 24 Mar 2025 12:54:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition
 for qemu security targets
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
 <37053ef1-be2b-442d-b4a9-9da99e75671f@siemens.com>
 <OSCPR01MB14838A47CBFE9609D5FF0D806C2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSCPR01MB14838A47CBFE9609D5FF0D806C2A42@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0348.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: e58bdb2f-199c-4d8f-fde9-08dd6aca9cd1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eUZsMVRTZlpsN2tCUzYrb2V5bC9JemZlTFBJTGY5OTlnaVRBL01BQlJqejF5?=
 =?utf-8?B?dUxWb0pSSDkrREplcnZ5dmloZHluNVdvM1ExOGhTakJoVXZuQWJsWmluYlVY?=
 =?utf-8?B?Y1RZb0t6enZJMU9ZaG9EclRzS2QwNEo2RkFxSzloVm45U0ZySlpoZVRXc2Fj?=
 =?utf-8?B?ZERVcFFFVjlYdkF2M0VMaDhDUmp4QUppTDZ2eTNpZVJkemJ6M29kQ3dWSzdC?=
 =?utf-8?B?UGdPTUlqY3FiL0YvQVZHSHJiVGdZTVc5Qm9LQjM2ZXRYYllqbG9WOVBzTWlw?=
 =?utf-8?B?cFN0K2lhdk94WkxINDdpTDk5RVVZNXRnbFhtdGg3NU1nZ3NVUU5aVGxNUGRw?=
 =?utf-8?B?dXcxejdSQmxzd016OEp4RGVNMW9RRHhCUzRtVDlaQ0l4cXltbFMwV25GSXMz?=
 =?utf-8?B?SHNGT2hmU01TeVZhRFBBZDBJcGpNc3QyOXdLN1RjWkp6QU4vYSsrZGNvL0JJ?=
 =?utf-8?B?c2FKaDFRUnExMEs5WE92SlFhRUxvVXdUOWhrMlJFVlRieVR6VFcwTEJIc1lt?=
 =?utf-8?B?N1VNY0VXUzFVVFlDT3FJdWdwL2NRclpqK1NtSGt1Q0tCWVB5S0JOTEprYkFq?=
 =?utf-8?B?SHJjNTZYNUw4SzBwbVBNSXdHMUREZlQ1M0N1RUhOTkJnK3ZCaXlUZkRwT2p0?=
 =?utf-8?B?OG41S3BtYzFuc3pTL29oQnd5UjhPanRpNGxkYUtKVkZMTTBsUEpleVJ1TDRa?=
 =?utf-8?B?WXlJVFhhVFZ1cEhMOUtMZ1BFVDBBL25Pc3hZZnJDUmlYcElDc1JiVHlpZkhS?=
 =?utf-8?B?OFlrbWY2WENBM1FJVk4zTng3ZkJ6SEk1VHZyM0hNOWZBQ080SjZaODUxVHpq?=
 =?utf-8?B?NXE4ZVo4dFluOXRqS3FDUVp1UjE1SHBrcS9tNmJLdDJtZ0NMbEdhUmdUMW43?=
 =?utf-8?B?bDRNQnBScFpRd0l3Tjl6aGxIK2JTK1dTenJzNXNyQnFJM3NyZEJsMFdqYy9O?=
 =?utf-8?B?WTdEdFgrcGFzSzdjQStoVXdRcjR5TkxYU1pmVHJpNmlWY09vV0d4NGJYNk5W?=
 =?utf-8?B?RGV3M3duT2pucjlmY2pPcmZMbDFVbnR6d2g5Y3ltRzkxZGcwK3RJMnVUck5M?=
 =?utf-8?B?L0t6Z3BweGVBQzY0K0VrWllaTjlOaXlQNHBGUms0QjhrOUVIcDhsRGtUdzNZ?=
 =?utf-8?B?Zk1SMHFKWHB0anNDUVUyN3YwMVl0cFVSbXdUOFNqT0pvcGNPcWVOODd5STUx?=
 =?utf-8?B?bCtuOVBhRGNWbjJZamp3dmJEM3YrRC8relVIYmdESEdlQUVZTFRYWkY1M1NZ?=
 =?utf-8?B?b1ZQYmdMY1k5Z0lBK2I4dm4rUDV5Q0xpOXU0UUY3RDdWSWFERjhRNXg4Z0RJ?=
 =?utf-8?B?MWsyZnZGU1VoanFIbEtncDZOMnlEaXdFSTV6NVNQeWRtMkpRZDcwUUw1dFlW?=
 =?utf-8?B?UjFYTDF6QzFZYW5TYzhoaW9ibUxqRHN6SjdYd2IvYTA4T3ZDZmxjZS8xc08w?=
 =?utf-8?B?eU1leUdMNFk0MlVoWDBYclJGVllIN3FkVlVQVEJyZ29xNmVWZFZQanhta1dK?=
 =?utf-8?B?dUZHVlJUTC8vVHUyd3d3Z3NCNmNOdHhmSUtzVWdkekNKTEJ2ZDJmd0hTdUJH?=
 =?utf-8?B?NFBtam03S3dmOUtMOU1PL3dTSGt1MjRGSExFdmNsekkzbFl5d0R3dUFLRGVT?=
 =?utf-8?B?c1MyVHdtM1I3aEMrTGxDUGEwOEg2QXM3U3FVMHhPZkZzaHRaVllabEl1RFF3?=
 =?utf-8?B?bmt6VUNFYndwUHR6ODJRM3lhc1NEbTFlbUtBQXNHaGhDU3VzNk5jRi9LbXlH?=
 =?utf-8?B?L2VzekQ3cGpLWDdCNEdQUUluMjY2SXc2eW1GN2hxMEhEa29tNFd0c3N0aHVi?=
 =?utf-8?B?UTVSVWxzQXVlNWlhdjRmMTRuYTdLeFpLdWxPN0REWHIzcHU3eHlKL0RLbE13?=
 =?utf-8?Q?LGlGpb+DQzXh2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVVwbzMwemtvYlZLVVovNThFemkzd1lFOFBvTys5QUpieW94TVprd1BQK01D?=
 =?utf-8?B?YjNzdTQ1cHUyVkNYeEh1dXFNbi9XTFV0TFRsVVJTQ2tPNVhjeTlmRnVCV2hB?=
 =?utf-8?B?NUN1QW9WNzMwTHRCNFNnSFYrVVZkN0JGa3M5UFoyd1dGUmtCTms1Z3crNGV6?=
 =?utf-8?B?R2o2R1hNOWY4aWU5LzVZd3RvcFhXdE9aODMreHFGemFhazczZ1dMTTNwdVRN?=
 =?utf-8?B?S0hHbDd0S3Nxb2F5UWZiWFBZbXhVMTNqR1hXVURXb3hhQllvLzB4Tkh3eTl5?=
 =?utf-8?B?YUtFSmJ4N1FuZCs5QitYTnVJNmpXdE9Wclh4T0x5dlpXMldwdEZ4UkJnSUdl?=
 =?utf-8?B?NlJtMlB0ZUl2aFluZXVybzEyVEVMTENPejhJMzZiR1FKQXlaa0ZuQlJIeE5Z?=
 =?utf-8?B?aHBmVlJMenU2YmVJMklLNVNUNGpnNkpMeEMyOFM2SUN5bnRJVG9wZjd6VmNR?=
 =?utf-8?B?THM0eGw1eGRDeHVGMW1XSFcyK0grSmNDTjN5cEQwbjdLaHdIVU5BS3N4dWgr?=
 =?utf-8?B?VzRHVThwVHA1ZEFud0VmREV0ZDRPZDVHdHh4bHoxZzlhNkp4eGljc0dUS25P?=
 =?utf-8?B?TWh5Z3E2UHFtRnNtUU92ckRhMTltbFRsNkF5bmh0bzJFOG1WNTdUNUt2dnBC?=
 =?utf-8?B?bnRHTENFWm52TU9qdVNuTmhWcUV2MndSajlxT2tZTFh6a0plcCtYNzdQMnpF?=
 =?utf-8?B?VE1qUG1WWmdKNFFtenZma0VNWTFMUmR6WnkzL0RaQmdJc1QzSHFITGZPcTJl?=
 =?utf-8?B?SXRvcXhCaGRpelVNQmt5S3VwcXBFQlNLOHdWMU5yYTh0dC8yeG81a0YxeXhP?=
 =?utf-8?B?SWtENGsvSVQ3Rk1YR0RTbW44TldIRDhzUGY3WHdlUHloc1Y3WXJEai9WeUJZ?=
 =?utf-8?B?UUh4SEVOZXZvZ2VhRGFZczVrTUFudTZ5VC9lWnVJTVFUWTR0d3RJNkc4U3dz?=
 =?utf-8?B?VGQ5T3lWRStnSm5jQS92aVFrZjRNRGdJZXZkam5nSVRZeTJEelFVRXcrNThx?=
 =?utf-8?B?SmxOMkZocitpTEVOdkVzL1QrSHUxNldEOXJaSVVmbnBGRUtXWTRFQWFveDdw?=
 =?utf-8?B?UnYzaGNEdGNpaGYrQ2RSVFkrM2did0xLaG41Q3pKYnJsWU02SXBUUlRCbzZ2?=
 =?utf-8?B?bWo5TkhONi9KSFhUY1ZqWlJlbFhGajFxNFF6dmYydUhBeWc5S3lSMlZySStp?=
 =?utf-8?B?eGZTZzFKdjRDUG5pditZS0g3ZlhZOGw5ZXBsKzdybW0yc0xnOUxydkNJQmZt?=
 =?utf-8?B?b1dreHVid1g0aGZMend0b2RyeVpoS1FUck5RR2lTRXdaODk2ai9ydDZIWHZj?=
 =?utf-8?B?bWk4UHU4dVhRdldVNzk3d3A1dDV2ZTc0eEtGWEtXSFNMeCttRjk0UGZPUWJY?=
 =?utf-8?B?K2h3QmVPMG9PaHpUc0hZblAxOXJhdVBiZU1Sb3hiRU5ORTlKZ20xRjkrOGdY?=
 =?utf-8?B?UDBrU3dFMTJ6b2FxMFVPcEVLUkErcGk3VTV3WmNTUzVuV0RZWFEveFJPNmpR?=
 =?utf-8?B?eTRzcHlCR0gvVkszb2JYRzFqbC9STjRJS3JDRjF2WmtnRVZ5Y2NxR2lraDB4?=
 =?utf-8?B?U2RtM3hqek9ZaG1kOGE5UTh2Y3lEQWlrcGpNOUM2cXFnb3BIci9MTE5IUmhx?=
 =?utf-8?B?dW84dWNJTTFUTGFJMXVQajg3akpBVzdrZG1xYlNMRjAwNkkrV0pRaVZVWC9l?=
 =?utf-8?B?YmF3aW9VY0RTT0kvaFQ1ekFabkRWQWk5YjJRcG83TVgzaVNJMnRKSTYrUERM?=
 =?utf-8?B?V0NRVWd5Z1YxNnEzRE0vTDBCYU5QV2RiYzZTcTJzTEpaL2VZL21OMld3Mmdv?=
 =?utf-8?B?R1NSeDVPdTRaSmFUSno3bGZGYkZjbkVrdHJqYkdNb1FFRmhUZ2NLQWNNR3BN?=
 =?utf-8?B?cHNTWktWVzlqbEIvVjFydVNnVG1UQlo2aEgraUtjM1BrRlBMQnE2MmhzaDhB?=
 =?utf-8?B?MGp3dlhyZ0ZFaERQZjJhRmk4cjBPMU1XV2dRYk9hVElub2hHNEYxTWVvelVY?=
 =?utf-8?B?dFZabXpXb2h6QUdBa1IxQTF1T3ozVDRPVTludFpBY1FTd0IySWRmNmZqeENx?=
 =?utf-8?B?dmRLL3daMkhKaGJVMFMxNE9jb2NPTEVLUld1QjZ2VklJREFZQ3VaR0VybHRN?=
 =?utf-8?Q?BoAHo4Houm0GOjFA/LkWfI21M?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58bdb2f-199c-4d8f-fde9-08dd6aca9cd1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:54:20.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5MVQXIXPqF9vB+pvuTTc/lFyvWg+6uSzVy0cd9m8HcYEe5sqWl9naS5+MVlE2CCHKBh9vviOzQ+pvZMeqJgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7853
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:54:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18344

On 24.03.25 12:35, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
> 
> Across all QEMU targets, the mentioned test cases are failing ->
> TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1
> 
> All three of them are related to aide where we explicitly modify a file
> and check if aide is able to detect that. If I run these test cases in /
> var/home/.. Aide is able to detect that the file has been modified
> reporting an integrity failure to journal logs. But if I do this in /
> home as working directory to run these tests, the changes are not detected.
> 
> We can also change the working directory to /var/home here, instead of
> deploying separate home partition here -> https://gitlab.com/cip-
> project/cip-core/isar-cip-core/-/blob/master/tests/templates/
> IEC_template.yml?ref_type=heads#L74 <https://gitlab.com/cip-project/cip-
> core/isar-cip-core/-/blob/master/tests/templates/IEC_template.yml?
> ref_type=heads#L74>
> 

The idea of linking /home to /var/home is that it is (widely)
transparent to its users. What is aide exactly doing to let that fail?
Does it reject to follow symbolic links? Why?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

