Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01819E9A048
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 13:20:54 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13738.1771507248012596560
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 05:20:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EtCSPfew;
 spf=pass (domain: siemens.com, ip: 40.107.159.45, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfUgyVwk4pip+uUzawbzXMjObV2Y3payiALBhAJI1Mx1JtkO3K6AAU+cb0Na4O55Nv/oEPVt0RIb7RLfaxhEuwDMqZlnEbsgtHKaBizKviRC2YB14Fc6m1EJzlViKTEyy97AvHyTpRlDyDjLmA/2ter/c/D+TburzrtqYFonlu4THDKwvJYo+ahY1GJlATJYvuSxftzNaMQradLF5WO4Z6lNKmwxyyhuH+Xl6JAGU8h+Utmt83idSTLWofhH/FcrosolD8+rU3kaTeurUMwsF0jFu622f7hyB8bVNP4M+3o0fEy3x6xuchwULXOBXmKFDmmflk8Q+pUvvFm82+DsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69n24FHnr42fzT0ICvkWy4sdE2e57yFa/wdgdCquyEY=;
 b=Kk9SzB3MrvaKnfD/bkPbngeaGPjSC3DgH1HxgTf49fIYHfqxe0xKINe2i/jDCOgf64IY2Ak8yoUtagCgoFWV1Vm6v5t7xfeCwy+18vpNMlxoIhyX+sJlfqqplODSAQ7Ekci5FjCy9a5MXOyOxSMi1GrsmAd7F/Rhw1J6VDKskmoTJCpglUahJRFfUuLxyVRs45khxZXdlJ+c30p3YU6JXPXI2mr+H926TagcefLB7JwPFnP6GL2zxQ3FZr/7YJ1sKKenQWjWUdScYh+9lculm++9hKnCwPrf4uzwAGIBGKyJ0ZXtrJ4pTCz94Pguae09Es6sz92iCiVmbrcq2UdHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69n24FHnr42fzT0ICvkWy4sdE2e57yFa/wdgdCquyEY=;
 b=EtCSPfewbEtue3HHYcLMLhanxlQMbTKRcM3B3f5+g8UadJ/lLeQQjX52w/ppmwcBpbKKAJSj4WDVGC/oO+rgDW7kgMJo6C87Jq2pxqZUiaBFmOCZhn4pmvJKamrPO41A9dayvU0L76EAfw+x6S1m/9ftWjTQkN+POLQToSEF/3HBcWBUN3W+JrJVC+4tcJY3+j1gFEhc/OZ4/7MVYNJsZSieIQuQei0qercLy7zlHcsHcv64oNTu7BFoI6AYij6xPErRWzSPw3rn+tqvS168eYy4zP4INdK+rFKcE07nHeyFpe8JoU3e4FFz1YCZLgAMlmQMRWXb2cgOnxmdE3gVZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e2::19)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 13:20:43 +0000
Received: from AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad36:4857:1094:f10]) by AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad36:4857:1094:f10%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:20:43 +0000
Message-ID: <4b5233f9-bc65-4cff-840b-226e45a98dcc@siemens.com>
Date: Thu, 19 Feb 2026 14:20:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Disable bootloader
 interaction in case of ebg only updates
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>
References: <20260219123726.922484-1-Quirin.Gylstorff@siemens.com>
 <3bd31e51-cdb7-41b7-9c7a-c65146d28cb2@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <3bd31e51-cdb7-41b7-9c7a-c65146d28cb2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2306:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a395935-d7fc-4cbf-be0f-08de6fb9af26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eldNTEpJcVQvSXpTeW9RVVBoSXorQ05nR3NsckpxcVU5Y3Jrc0NWMTJXRGtF?=
 =?utf-8?B?NHBCSytlSnFFeGN4VU0rak5iY2Z0Y0wvckhkUVlobnhHbFZxZmxha1dwcUp4?=
 =?utf-8?B?UXZwQ2hXOVdHdGFGMkh5TlZpR2xjcjVvNklRUzRJWG8veEdqSjFJN3RtUng1?=
 =?utf-8?B?WFNlWUk5cXlxbG1sSzQ1SjhNMlVNUDB5RXZNZW9qd2pYNzMybjJkd2VSdnpl?=
 =?utf-8?B?VUM3L3N6SFNXWmcxcVBPTGRmbHhiMzZYSWJWd0V2RlRnMGFLenVaQVBPMzF0?=
 =?utf-8?B?akZJUXJqeWhDRWZiS1pjRmdCcGU5a1BpUGhhblQvM1R6YlNwOXRoNFQ3Z0Ev?=
 =?utf-8?B?M3lrTGY5VE5DcFJLS3JRcjlNNHdHNWdHNmpqSVZSaFBaaTc2ZnlQUHoyNG5U?=
 =?utf-8?B?bHJhWERubGJ6RGRxSGw2b1JIanV2emJERFlCSFc0dGxIa3NDdnJXK1R5LzZR?=
 =?utf-8?B?MGV0SlNLSG51TFhOS2FPZGV4ejhtaDljbEhtVkdvSHY3aWJQd2VsS3hXWnBN?=
 =?utf-8?B?V2RZeFRCaWFKRDYwSVI3aVR4NzJwNCtkQjJZQXZpM3pzSVJ2TGJsa1BzNS9k?=
 =?utf-8?B?WkpwNG92L3o0ZDROQThUM3dqRmFGVTBpSmZaNTRjNUtiK2hBbVpHR1Q3MmdL?=
 =?utf-8?B?cCtzeU1WNGdkU3JyUTU3cmMvTTl4T3NqTmlIKysyeTVEWDVVdUk5YjBMc0JC?=
 =?utf-8?B?QVk1anRUZFJrc2lmMGdDaVBId3lZaUF0VUZ5UXM5bVRuZWYzcGdhaElXYkNP?=
 =?utf-8?B?ZGtFdGNBOU5Fd05SMFQ2QmRldVhNSmdUbGRwRnE4cDNpelZlMm4yeVBWYWNU?=
 =?utf-8?B?U0NlaTVIQjFIcWVtY0t0LzRsM3JQSHlaVnJhdU9OdkxGVGhlSTZwdmRXcURn?=
 =?utf-8?B?WmZCcDRyMzQ4L1lvbkpsdUtvUjduL1JWMlhFVGV2VmNic1RPdi91NW16aGhW?=
 =?utf-8?B?Y0d6WWFhSDNwZmZoL3hyYXJIMThRdmllT28wbk9tZ2ZzWUxDMDZiaEQza0VT?=
 =?utf-8?B?U1pSQzRZRHFOQkFrYzNxaWZxSXdXZkEvS2xGS24xb3ZQdkhJUlZCL1NTK3JZ?=
 =?utf-8?B?VUh6RmdnUnhFeGswSHJqMDF5QVJJWkJDNVhwLzJINHpmME9YN1VQRDJVMENt?=
 =?utf-8?B?SEpyVTR2R0RLdEhGSThBVXJ1T09MUis1UnF0RzM5Rk1JN1dXelNZc2lKYm0r?=
 =?utf-8?B?d05hOFNHWjNiYUVzdXVqODg0MEVKQ2xuVVJkN2xCNzVLaTZyWTNvK1ljMzFv?=
 =?utf-8?B?TFJkSmJIQ1Y5Y2h6UTd4MDVUaE9ESlpSMkVHNXg1M3VKMzlVeDdkNHFTY3Ft?=
 =?utf-8?B?SThIamRpaWhTN0QxdFBqdWJ4OWRCVS9odklaYURHaVFiU2cyZWZqdXNQZUpT?=
 =?utf-8?B?OEJpVm1KeEZ3R1d5YWJrdXQ2QmgyaHdsL3hVdFhTV3h0ZzdWbHJLY1V4dFc5?=
 =?utf-8?B?c082R2pGTmdkcndyZ1pLYWxzb2t2OFk4WjZEZ240KzhqaEpFUlpzZHZZaW11?=
 =?utf-8?B?c2NLbXNPTnNBNU1YZHIzWDNJZXhyTGduaWphRWJXTkhnTDdBZENLcWFjbVp5?=
 =?utf-8?B?dXErZjZwd2Z6b3JQbEsyVjJQUkxvaW5xQUZ2TGpzbUpQelVBYXFSYm5NUERl?=
 =?utf-8?B?dnNCNmF5Znl1c3pxVkpPek9NVVNIZUF2YTV3U0RESW5hdnhxT2lSYnlIY2NT?=
 =?utf-8?B?MkFKZDMxL1ZGcmFmMU1wcHpSYWV4SnlrUGdKQWxoanNBT0M5TUswTTdHTFVL?=
 =?utf-8?B?aUF0c1BDQzh6cWRna1VSR2hJRGsya09RaWZTcVFMM3VscHcvbjVBR3NTWkJH?=
 =?utf-8?B?N2xNWWRCaG9JTjk2cVVGNm04Zk5zbXQ1dkgra2M2ZStuR0s2MktSN2dwVmw3?=
 =?utf-8?B?NU9ZMmlDbFpPb1NvQjkvNUJkS0lSUWpYQ0gydU81d3dRdnZFTzl5NEMxY3Rj?=
 =?utf-8?B?UW9hQUp4ZFBaVWNYMFovSzJ5bzcwTUpsTmdGYkdIM1huTGNYWkRSblRnQkdR?=
 =?utf-8?B?Zm9keFh1bWtEbFdkN1pjTVllT0V6eUk4QW5tWHhvaEloRFovNlgzd0JmWEdR?=
 =?utf-8?Q?AtWzgn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmxwYzgyZllZbUpmcTd6MzBJbFYyVlZleFBVdWM0OEE0T3lrZzI2Q1JBR2Ri?=
 =?utf-8?B?bkVhTUczNDlOY2t6LzIzU0t0VEdLT2hFdGNoZkFpc1VoS2grY2d3UldUMEg5?=
 =?utf-8?B?NnZMNHdBWkkwQ3pPRldSRlJIWERUQmsrOWpDbGc3c1dwRnhxd05lRUNmOFdK?=
 =?utf-8?B?WG1qZUkwUVVrWTR0cUhvNWt3T3RscE0zcDE5cDQzRU5uV1I3aEhjemkrOXBl?=
 =?utf-8?B?NEh5MFE4akNSUEZobFlQM2loWmFTcnN0M1VaVFhJNFduQUV2aXRnZjBmbmp3?=
 =?utf-8?B?d1N1ZGE3eVpZT0JhYXM4Z2daNUVmdVV5RzZnSXoxSFoyQ0pZd2I2b29WRVNY?=
 =?utf-8?B?OE9uQldoZjB3VGdvMUMwak5wYWx5RHFxVS9BcFZtUE1hODg2djQ1TVJqaTNS?=
 =?utf-8?B?TzF0NE9PaWxHZXBycXlmeDdwZ3ZkU1FFb2ovai9JTGdFY0V4ekROcEVaejdC?=
 =?utf-8?B?dkM3RXZGcnd4N1dIdEdFMC80K0Yzc0RYbXU3ZTRNczlheWMzNHhpNmlRUjNr?=
 =?utf-8?B?aExGQndEVzBiUVBDak5iSDJHUWxIM2NNUUpkbTZWZGZIL0xnWDZ1SGY2Mmlh?=
 =?utf-8?B?OTRZNzhJaW1SdXppRkNwVGhLRmFzSFBOa0J0T0haSi90U2xjSk9VckRYOTFm?=
 =?utf-8?B?MmJZeTlWeE1Id0Z2Z0U5OHY4U3hJT0lIV010VkFWT1VKcW5Ic2VPUFd6OTQ3?=
 =?utf-8?B?VVpTc2pMcjB2bjc2RFE5WUhZMUJxZ1FKeTJuSnkzUW1ib1pNTkMxQllEZ0pZ?=
 =?utf-8?B?cWFhUXF6SE0ySGdoRHhhNFdweDlaanNNUy94RlhyTUdyRnlFTGQ5SFRBOWdR?=
 =?utf-8?B?L1dYT3ZzRUpvK2hDS3JqQ0wvcDF4bWhNRmlWQ05HMVp3WitNMXhxdW1ZY2Qx?=
 =?utf-8?B?QmVMZTVneGd6TjNFVUkxU2hrVDRKeU13NnVWNUQ5UVBsUjM5OG1NdlRQUnB3?=
 =?utf-8?B?T0NMNDhock9aT0Iwc2Y0UEFZVklOVElhVktad1lITWhoYlBWZGhOcngvV0Fx?=
 =?utf-8?B?K2kyalhIWkdQdGU1RWQ2OW9PQkVuZmpHVWNzNmtVRGVHZzVCYjRSdmhpeHZz?=
 =?utf-8?B?c2NFOWJ1b0N3ZVA2YldtcGdkOU5ycThBZUIyNmJDS3Fhc0dYVVRSZGNuam1j?=
 =?utf-8?B?RGt1cENmVStFUkZqWkdBa0g3WEx3eWpjTWxJdkRramJMbG8rRGx1V3RkMnhD?=
 =?utf-8?B?YW9KanJsWmdDWFZPVDNaZVhHZlpHcW5uQUQ0TFNDUEx3dndoTGw4bmhMWGJ2?=
 =?utf-8?B?bU5QUkFEQUxTY2FML3lrQ2dBMkJLemJSaXhOeldIRnVQanR0TUpKRDFCVXdJ?=
 =?utf-8?B?SjdpRGpmTE45a0NEZ2FVcVZYSnorMnFpRjBkVGgwQXRBZzdTM3VhQ1U0SjVJ?=
 =?utf-8?B?WGJSdzIzWUhRRWtGMXM4Rys3OEk2U2pRYWM4cGVSNGFpZEI2OUVHTjFzdWdC?=
 =?utf-8?B?dDVKM09DSlhNTVhpQnRjNzJDbHpKc3g3YVI3WnhpVVE3dnNkejI2M3ZnM1VZ?=
 =?utf-8?B?aEdkRGlvUnpaSjdraEwwMGNjU01WRTdaMFhTZmZBWjZwNkM3aTVSNS93Y1c3?=
 =?utf-8?B?UUkvRW9rWSs5dHVXWEZkZXd6NDdHaENUc3J4aVNiNXpVVHdxSndOS0xzZ3hk?=
 =?utf-8?B?cG9Kc0pLMyt4cExrU3UzcDdHVGxqU093dmIxZitxMW9ydlkySFdPbHhnNnU0?=
 =?utf-8?B?MkRaN1U2MHZYTlBqcG52T0V1M2tXNjJXMk1BMHVRQjBSZnVMVzJnT0JzYXJk?=
 =?utf-8?B?YUM5N0RDRFBVd29qT2EwdDdmSWM1THZVdVdkaTRrZ3liK0IvWDYvSUhvU2ZI?=
 =?utf-8?B?bloxbFFJM0NtMzVNNVJrZHBYWTJPMWtrTHE2dURFU3pLK3ZKTWYrYlJ1MHVG?=
 =?utf-8?B?YWxsVkdyYUkwUGJiNkpaVTRteTVrNHNSTE1TZEg4SmtlS1RXMThKUnAyNmJn?=
 =?utf-8?B?M2FieksxemJoY2k1MEhzMEc3WC9BenJSSm9oL0xIT1dyM2cxc2d3Z21Dazlo?=
 =?utf-8?B?VDkyUUFZWTE4Tjc5NklxNjdiZkM1dFlpVzNtZHRHYm0zbTBwNE9zRC81OW1L?=
 =?utf-8?B?ckx2RGp5aDIzUldUang0TURPVmw5bGRIVnlEUEZVSnU1L3dRQVhLRUhVNjlu?=
 =?utf-8?B?Uk0xRlI4Zy9sVDRoYy9TbzlBMzhmaENDdXM1Y0kzMUk1OHRxVWRTVnU1UGtN?=
 =?utf-8?B?T3pMV0k2NnIxSEVIU2RyQmt2YVprUmthQ2JpTDNmSmlDWTljNm5HMVEveEF2?=
 =?utf-8?B?MmlrVzZYQmZ1VFlYRWsyV1pKZEszTDBnWFFjZStxcEtLenFGQlExM3E5TldC?=
 =?utf-8?B?SnQwNktPa1NCc3NlaFhFSkJJQzhEdzZuc3NLU3RhUkxlY0tDcTFyZUxtWERN?=
 =?utf-8?Q?Xp79LtoJyUD8vnKQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a395935-d7fc-4cbf-be0f-08de6fb9af26
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2306.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:20:43.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFHQe+7SwvdqQfQrn1dKVtWgPLufi+ACyfZjEv5/6VaXCMDtgb+eZ1SCabR0b1vyFYbCE/9g1oSUqKZPVXrgF6qUOT9wpQlQ1DwgYuoi0K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 13:20:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21899



On 2/19/26 1:50 PM, Jan Kiszka wrote:
> On 19.02.26 13:36, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> During an update of the efibootguard binary the boot entries should
>> not be changed. Therefore disable the boot-loader state and transition
>> update.
>>
>> This was found during testing for issue #149.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/images/swu/sw-description-ebg.tmpl | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/recipes-core/images/swu/sw-description-ebg.tmpl b/recipes-core/images/swu/sw-description-ebg.tmpl
>> index c19157c..a63e38a 100644
>> --- a/recipes-core/images/swu/sw-description-ebg.tmpl
>> +++ b/recipes-core/images/swu/sw-description-ebg.tmpl
>> @@ -12,6 +12,8 @@ software =
>>   {
>>       version = "${SWU_VERSION}";
>>       name = "${SWU_NAME}";
>> +    bootloader_transaction_marker = false;
>> +    bootloader_state_marker = false;
> 
> So we need to set both to false to avoid the SWUpdate talks to EBG, and
> one does not influence the other (although there is only one state in EBG)?

According to 
https://sbabic.github.io/swupdate/suricatta.html#update-activation yes.

Quirin
> 
> Jan
> 
>>       ${SWU_HW_COMPAT_NODE}
>>       files: (${SWU_BOOTLOADER_FILE_NODE});
>>   }
> 


