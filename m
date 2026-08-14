Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B84C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 10:59:36 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10401.1786705166133995583
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 03:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UejydyBz;
 spf=pass (domain: siemens.com, ip: 52.101.83.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt1yXshTmCmE2IPh9kWUFzDqiuju0o0Cj541YAVIa/7GTq/gJTQP2CFuiDOUpwnSCcjxzVxRFZaAstxy3QVISRbP4LIYFgLvbHujieLqEnL9JhdgEOUCJjJ9lLPBa0vVFUnlPbV/LcZZrbQApnc1u96VZpt6RKo/PE4TfihmAwiVB/u3eOUBHdLz8ZMRcCC/fUXMT5xtfa65ZHiHp79wKFgWxek629iNm7fmukIeBEyrkDNithznjW/8o0ikSGjl5VItiC1MRCQ9fxmyUM2kjnk/0/y0x7+0YxpCSJ3O09/q9rGdO8g+rXxHTUPVSh5JVYbdlKrSqIul4y4wk/1FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f10NiZgN2mvevrVYkCO0cGq1Ra7abz8KdcDYXBn0Y48=;
 b=TuC+Ho0DaornUd2G/UCQmPlc7Q+1pyxvUFE93ALRCpuP4+e7EFxp+KjttdRubhJsfOdqkiyf3+06g2jrbXCnolTNsU1lsTNKhjG4hes7pG4dknHSi83XTWuk5reLahu5hTBbJitwnWPti7HdkKn4Ya/eH/mYYmRS4O2cqezWu8UVtpTyT94qrzOcXCsXphFA2AVJO9nIR79Fty8K+TSyiRf4cIzgw/7szEKlZsjd1BVnTVo8g7+0R7nOe8htATIIXphwjpxdJwNkjGXK65cKYg/fUjreS1o8SqRJTB2ErF4sogg9YYCUZwUTrYvlaIYyGNvMomDXltei+qiMJOiwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f10NiZgN2mvevrVYkCO0cGq1Ra7abz8KdcDYXBn0Y48=;
 b=UejydyBzCW44VPjBa0u3VstmvyxtDsI84hVlG7unqIczHJ3U5Opn7XZsynk6GW0FHOyGSmLO2dUCkYZPRNC/5Lr96mKLE6Ap67VeKlh+yeQItR3cp+L/2phOMXf7D8TmnjM4BfV1gO6L8jMUJL20AwaO86qwWlg3RWnA79sHJioiz6hnIa42yfVm+um26rRIIaZ8CqlvBxEJezH37mg5ASUHcA3AG1u/UW0b8ioRiYyQWmyOUeS0WBXOw/6tGhJtvdzMZNAP6568mwZvLmcz6lgn4k23Vv+Gp4jD9ON286jAGISKdfSKE0k/eVoeboFiS3qZQgtZBfI+AocRvCHYXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 10:59:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0315.012; Fri, 14 Aug 2026
 10:59:20 +0000
Message-ID: <a759f568-e9d6-451d-968e-c31ded1c7f64@siemens.com>
Date: Fri, 14 Aug 2026 12:59:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] recipes-core: ltp: add python3 and jq
 runtime dependencies
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260814070413.899289-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260814070413.899289-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:208:32f::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: ad274af6-c01e-4a62-8922-08def9f317dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Y7bX2R2iDFSaFEYGK7xJw27h+LwgLaEokAuyw3tRDwuQPkJI9bBDvIyRFWrDs9iZ8wtWcaGGXjIzQLmFmeMGJaV3fe//PRmQYir6Hsr/3192V2JiIcKeVyb3PxKH6aDVw6dMvwcmZ7oqnsC63XCgHKOsBYOH6FKzzbByxoOG6b49zsbqMdMSEUXMfLy+G/fzg9rF5D+RF3cyTlPb0M30xSnG2+Nbv7+mSLfeMTZloeJkNu43lwNLEdn58VgqcoVqebYy5kYTKOHuZyedL3tv2QhqRzpK4/LC2t3Sc6Q1RtjW4aV0IUJqauTv7tVcGZ6KNJtHzyTbOSbJN5hgNP5MvWAWdl0Gzemxk7/vHTL3sx+DVcgkEPSpgkFhbXVrL9fG5/pWfSd8BLbc0dLRv1luMDHcMglg1CyPJ3tLKUbTF6c8SxrsUPavRPpGiHZgpaM78E0eyZ8nW8ivMplz3V6lyJsocfwchZh3dQCwYb1qQ61bYMq753+FqwVmRWsGJbsIlc+o3Ua6ls/RQtcEcGi14Sake0XqiNoAZwajuTQw2huqdpGJ5EM21eNO7NRJhB5j79DHMtDQP8kkTEbe6WILgj0Q6zpyjrphpME7sTZLRueYI0B4Jqf45/8RT6iGKOrhfk2D7HaTPiHOBzrvh+282ea3ju7GYMsruAnnI6VG7e8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2NsOGZyKzZzeU12RmNBZ0VlU0o5RnNPc0ttVW5BVDcwMURFSUFnUmJZR1lF?=
 =?utf-8?B?NUNoSXhUVjB4eTExL2d6TTBiQXpTbzh2QmJ6eHBWSVVWeWpVcDhmSFJ1OVJw?=
 =?utf-8?B?Rm1VNkc3NmY2Njl4SllEdUhTdVZ5ZlJTeEY0Z1I0TTA3SG5Ea2ZIRThIclVl?=
 =?utf-8?B?OG9RYnlyRU9Kb3FBcUU1U2Q2bHpGcXExSXlObnFJVUw1MUhJRjR6WU04SmJw?=
 =?utf-8?B?bk5wdWVxa0ZNdzVmTC9RdHVHUEp1RXFsL2JDbkdDMTVtc2FNNGsxWjlSdUlI?=
 =?utf-8?B?dENyOXA3QVdBUmNUc0t2cFdNWXZRRnFNYno1VU05UGc3NTVEeS9DLzkwYm0r?=
 =?utf-8?B?VFo0WmRDcXJvM2VBVTJwV09jQXozQ2ZVVk1IZXV1Vmc0MFJEaW9GcXgyU3g3?=
 =?utf-8?B?NnFjNHIwRFQyekdXcXhYRTNlYXJaaFA4R3hvcDZHVzlyOFpRb2VhS3dNK0lk?=
 =?utf-8?B?M0xLMDZzV2orRkxLNUw2alozTGhYOWwwUkZoRkpyUUFuVTlyRkNod0NNZVJS?=
 =?utf-8?B?aEdhRnY1YVRDelJlUVdaMzZOVDE3U2Qwc2N3YkcrdHdOWWZGU0pGcE8xdmVL?=
 =?utf-8?B?UGRuMGlScVJlbkFOY3J0N2x2WjF5VGlGV1pnV2RkVmdLcjI3ZU1ycTNVaXM4?=
 =?utf-8?B?cHpQNXFGcU1ha2dLTTNONjZvcHQxV1JPc0U5QUNPelhEeEZPeTNqa3V2Wng5?=
 =?utf-8?B?emt0ZGk3N2pYdTJyNnc0bEtYSnoyWTBvOXg0TGdVbjcvR1lESi82OE1tSTlO?=
 =?utf-8?B?NjUyZml6eG9YdHdMZi9DcDd1UFdzOXJkc0h5OXQ4cENKWHA1dTJJUy83RVJI?=
 =?utf-8?B?UVUrZ0JHazk3bnRhWG5yR01MWVpVRlplUllRMi9PRUhxaytWSkQrNHN2UGpV?=
 =?utf-8?B?bDN2Rlh5K091STBVU0ZpNWtQS3YwT3paM2VhWnB3UFlpZjlCM3QwZjNKZmVo?=
 =?utf-8?B?d1lDcXg1SGV5bnltQ0tkb0hmMGhuVFBpL1BkMDBTOCtVVlJIWWpjTEIwbCtQ?=
 =?utf-8?B?bEZuZ05iaUlaNXpmdGtUT1lRQVM3TGUzYkdjMVQvckhYZHhaNXhNbzY2ckVL?=
 =?utf-8?B?MVhab2hDK0o0MmRwK0l3N0E3eU9talF4UktNK0lCdzYxZFVxK1poY095NEt3?=
 =?utf-8?B?c2NmVmxjU3dhUjNhMmNLZ2F1UEJOZkR5RXArN2xkaFlOeVdKaUNUa2pNZE5L?=
 =?utf-8?B?Tk1xd0lTQVk3NjV3OUVuRDNLRkRMSGZ0ZmpNS3JROUVydzRka1J2d3ptU2ls?=
 =?utf-8?B?M1E0cUtobEh3aGhLL29CLzJlQkpNQzRsWGk0eEZpeXRjT2lHNEFoYkZXS29n?=
 =?utf-8?B?NWw1SDI5d2tvY0cyb1ZISzNUdmJlVk9qVXdnRHFBanBBc2JjcTFCbW1GakNS?=
 =?utf-8?B?elp0NHgzTE93alZMb2N1cGVkS2k0MEVjN1NYZm5RSE1nelVtbHJDZXcyZ0pT?=
 =?utf-8?B?ZDl0TkhVK1JaTHFuN3VCUW8wcE9PY1BaSlptK3prN2pDMmJ1Q3FhcENsbVRJ?=
 =?utf-8?B?OURRYXpOSk43UVZ2cTZxRWtubUJWUEYvUVZITkptdVpnMDVHbGV5ckExd1RN?=
 =?utf-8?B?ZDBoT2xtYWNxZTQvQVRWcnZPY1lKM2VRWmNDVXd5UW1DbG02Kzhnd1RDNjMy?=
 =?utf-8?B?YWovMVdENWdaSWptNkJmTnp5bmltZDBEbndqRkJSeGlCZFpndXJJcWlwZGdh?=
 =?utf-8?B?eTBmdzdHbXM2eXZBa0hCTGZUNFdZdHhFMzEyWkxJS0tIaDJNcTFzcXRQS2VN?=
 =?utf-8?B?MjdSM240NzVpUklqMzJFUnJFMXkzejJZZ21XbG5sVDJORHRTY0s4WElPaWVB?=
 =?utf-8?B?RzhTeENIaVo3Tk1OSkdHalNoZ2dxUko4UnA1OGJxdzRSaWlpQzlZYnVjVW54?=
 =?utf-8?B?OTNaWkQyd3d3K1paTE5Md0N5SGoxZEh5TExxbDZnTFJkMFc1WGR1V1AvZ2ZP?=
 =?utf-8?B?R2d4eWoyRnViQ0FkK3B3bjNKYmJYMGRhS2pSUW82RDhud2tRSmk2R0VoQk1O?=
 =?utf-8?B?Sk9zY2xkdXh4aVpYWGtLSUkzQWVQbmU1N1ZMb1lob3haRnJqRkIxUXBSeFE0?=
 =?utf-8?B?aTlKK1V1T1VJUGdFWlZlODkzV3ZSQkVYVmlqOFV3ajJZSDBzSGh1NXp0WHdj?=
 =?utf-8?B?ZGkwOUlUK3kxdlQ1NUwrOTlhSTRPRzdKQXBYdWJXSHlIVFptSmNWYkNXQ2U3?=
 =?utf-8?B?S2hUQWVVUFJQRlNKbkwxS2xsdEYyalU0a01UWGUwM1pBYTluVjhjY2hQTkd4?=
 =?utf-8?B?YWtoVnpmby9JM2RQcWVIQXhVSk9jRkJxUkhyT3NESzU3a0pMZkpUN2ZFeEsv?=
 =?utf-8?B?S2hNUkNRcUdNWXBaQlRUUis3L21NcFp6Y3l0ZThwT1BFdVRaOU1RUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad274af6-c01e-4a62-8922-08def9f317dd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 10:59:20.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT+rMcCdMkclcDcm7uErVRiBj8Ra9JL7aBzgJvj7YqMOKlEyj2N8JXuAMb6thLR6r0a4Ur8rYeNJ+d1m9H3VUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 10:59:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23934

On 14.08.26 09:04, Gourav Singh wrote:
> With LTP 20260529, runltp is deprecated and kirk is the recommended runner.
> Ensure ltp-full runtime includes tools needed by the bundled kirk runner
> and report parsing/inspection workflow.

Please send a v2 of "recipes-core: ltp: Update to 20260529" instead.
It's still in next, so we can replace it with a version that does both
required steps at once.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

