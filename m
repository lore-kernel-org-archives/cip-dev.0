Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30029C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:29:22 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.6])
 by mx.groups.io with SMTP id smtpd.web10.94042.1738603757480032465
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:29:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pXEe6JzM;
 spf=pass (domain: siemens.com, ip: 52.101.69.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlYI8GRu/vvpmt2VdlnPrJkD/tWNuJ/FPlUMiIG78ZLR0fI6bn1BVjcr/AWZMrouAYysbfZ1VPOrvhfR+IKXUNJr37mLa6dc+loYo3R86CUI18DStFG+MSZfYO718qHSYmLp68Oeq7K8aZ2OW34qX7+Z27R29TBg+yEXj8JbRBOrzwJN6oSU4jcOBN083aaIDoOYErvFILOHpn80/Q5Pyprtt6DBe/r5+KlrVIFl3/IjaynPfIHCvl7IB4AXuDHYCk6eUVxql9o4TnZCGqwZU1njgjv7XH37/6ieHE1E1jCH3t/Y2VG9Pkmv4utKHhkVHtq0m7fRBBdIPt2IkeSjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H2pClNE4d+hjRki07OOzT4K+yCbFam5CiU4NZ/KeHc=;
 b=cAG/zxJlBI3L0+Njcj9/vFCAGSZ1iW9eBcj5VWQoLF8OjCer0pDzakRDnTWwIKr3wVLKfxv+P2ZPQEV1Qf6VnaAgBX2JumSGuBF861iw+Yuj6KEou6LKz5bIEo0x9Fk8OiS24iNrj7NadrVZGHyuPsiQpiMzYju+WfG0jVPX61LtCcZpShGNlC+ts2ggDjN0pmupJY7L0HqwAWxlqyPFqIo2/PkrzKSsBuli19hW+TMibZemgkX/f6vHL27ssZvuWFgUz64+sVar8a47rodDCkH/TwN3fsZVsAuJzM3Zjb/Eq+OWBcxohf0hvs0nZtMA3jwxwmIaeBYyynO7JN+Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H2pClNE4d+hjRki07OOzT4K+yCbFam5CiU4NZ/KeHc=;
 b=pXEe6JzMRUPTrBaP0RruHAw8t8157nvKMH9WZL1iNRABS09WLOIJXwkEJwZ8HiQdaiConW2xBkl7X71/WbW2FBIvjhompf/chgRz6wINB80ZTUoI3Jg37d1QLcqH3cDQvFbdZmTTd8Nv8G9CMsWy7pNzcdHxGICWO52tdpslnhT5L237L1lmHgr86Rjrw6DAUKBiJ7qycBV/9rb0nDOULiySxu+gtGJivktgvX7Y4aSISzuMuSgUCSGgKQKpVSPjpCPkpfHNLIOQj6eRwgFUNZhX5Vh35xIZeeoU9H07ZR6WKfEJBv97u0BirEwxkWYc53NUJsZyXe8EwFejW77pFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.9; Mon, 3 Feb
 2025 17:29:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:29:14 +0000
Message-ID: <5ea46f54-9a0a-4045-abdf-001d0005fcea@siemens.com>
Date: Mon, 3 Feb 2025 18:29:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH 00/10] Provide A/B snapshot support
 for persistent /var
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
 <13624aed-827f-4b4c-930c-b75a38eb2e9c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <13624aed-827f-4b4c-930c-b75a38eb2e9c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbd656d-a222-4ba9-d692-08dd44784758
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MjhDL29taWtqdEtaZHBacEg3ZU5zOHJIREx6L0JGMTBKY1JFNkJENXBXazN1?=
 =?utf-8?B?RlYwOGFnTXd0MXBpOU1qY1V2WXNYakl0ekUveDB0eUFGRkxKc2kzRzUrQVdj?=
 =?utf-8?B?UzlrRlE5cU1ldTdONVpkTkl5cnZibE56Qms0YWdvaE4xOUh3cUlWbUVzMU4v?=
 =?utf-8?B?UW9uOHg5dGlGdEpSdkFLVlVHdkRrZmpad043WHIzRWlHaDUxaFhsM0h3Z2xG?=
 =?utf-8?B?MzhDVkZPMGh1alhIaG50VmphcnVSOXpMU3hJU2l2aDFzZjg0L2EyM3ZPdDBs?=
 =?utf-8?B?bVYzOWkrR1JFQ1dva1pyN3R5S0RURXdWZ1M3NlE1elBjQzdjQS82OC9YUVRF?=
 =?utf-8?B?VHRzZnRIeVg2OUdmNmdMNkJoMGlSMnVXMVRlOE9HcVBvaG5hc01RWE43ZUg0?=
 =?utf-8?B?d0cxQnZyUndHUU45RCtKZjZkeG5EdG00OXJpdGJmTHc2K1hHY0N4ZGJyOTZ6?=
 =?utf-8?B?NjliVThQVDRYK0lkbFN4TlcvL21Yc1dWRHBTdGxpSlMvNy9lWll3Vkh3RTZm?=
 =?utf-8?B?WVk2ZnlHSWpKZXBBOER6dFRHSFVQVnZDSXB1RlJNZzJMb0g3ZFkxVnhaYjEv?=
 =?utf-8?B?Y2laVUc2UjBFcjNwNm15SEJqY0toZitMbmRvVXNtRm9LVnB6clNoQ1BRVEQ1?=
 =?utf-8?B?V0c3WkpyL1RmRUhxYmJVRVduaGhaWnFmcWpLcGpCbGFJVHRqeGEvUTJRcVJ1?=
 =?utf-8?B?bUMvdzZWcHB4N2YzbkxvcGdDeldRVGlmSlNTbFovNDRYQzQ4eGZqRTdGbGZO?=
 =?utf-8?B?SDF3bHNNSGduVThoSmVXS2RqUWNkY2hjTFBBeFJVazJNYVpJTmFIYU5QcEdD?=
 =?utf-8?B?bjVVVExtM2UyTjkyZWxlbTZKSlZxdzQybzQ4aU1IZG1vY21LUjhZbDF5YmFW?=
 =?utf-8?B?ZWdheDRhOXF1WDN1ZVB2N1crZkFiZEdRazZWTGRlVGYxQitVUlVpL2d0dVA5?=
 =?utf-8?B?TGRBazdUdVRWRmQ2ODEwclQyTzAyVEhOYU9wajYxNmxmYkdJWkRMVDFyVXNt?=
 =?utf-8?B?VEptNCtud0o2RHRFVWN1UjVHa0UvWGJUbjY0NXpzRko0b1IxOGRxRnhBNlZO?=
 =?utf-8?B?MUorMUhxM2lNOXVZL09sZDdmcHFpWG5xTUppbnRHNVNmVmNyQnVkb0FFeDV4?=
 =?utf-8?B?ZEZBSEFETkkrS1VaR3F2OWdpN0M5Q0gxaHR6NFByMkNUMnhmSm90WFY1dzBq?=
 =?utf-8?B?NmxwaTd3VjEwamlmUTV2bndadzJCdWRLZk9jY0VQMVdQY3crRkJRbEw1cGw5?=
 =?utf-8?B?TmpOOUNmQk5nb1paM2dPT1R0SHdzSERyUlBvSmNqWlVIODRZN1llbHB6dzRt?=
 =?utf-8?B?RUdGNEY3ZVYyY1FOUlBCL1lUZ05JMU1aODNyay9TN0lKbzhoR2lDYVNqUmkr?=
 =?utf-8?B?ZVZsWWRBOUdqcmdvL05QL1R1dSs4NGhRVTNRdHk1WXE5WVNwdlFWcmFvcVlR?=
 =?utf-8?B?ZDBZV1JuVURpbVEvQkY2cGVjRjdHSXl4emVPdzc4dkNsZEpsQUdWUHFyS2Nz?=
 =?utf-8?B?YkNRM1IxT0pveU04WXZWVGFXWkI2akZOelNSLzNxTjFPbWtuSkNaMWR3Rlho?=
 =?utf-8?B?U3p4emJINzFaUUJ5TFNQZWZHaU9XVXAzeFRlRFE0UDg0QVA3b01GbkJHQ0dt?=
 =?utf-8?B?VlYrdXpCOGY0L0JmV096dWRDZmNUTHF6U01EbExOT1lSdVh1dEloYkRFMVAz?=
 =?utf-8?B?VzdMcDcyZjJabHNqdjZkbXM3c3gwcEFUWUVTSmJ1bGNUZUlES08xOVBldmFo?=
 =?utf-8?B?WktvYSs2ajJzZ1ZDNW92NmJuZHdyUHhiWXQwT0ZqZ2lCM2pQako0akVxRkN1?=
 =?utf-8?B?U1J1ODhxRjdnYktyZ1RvMytkUmllcnNXUzRnVUptMHRrdU5DWDVsSzF3dDhO?=
 =?utf-8?Q?LTUQqLkgm/d6y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUhLWmxFbmFuSFg0SGJNTzNCbjY3K3VjbUlLUU52RmI3eG9nSExsanI1S01Y?=
 =?utf-8?B?ZitIZENjaTJLZVVBd1N0UTZaMXhGeVJha0N1K0ZNcDA5N0V4Vzhub05KUXFm?=
 =?utf-8?B?ak1YYmZYWlFmVlRkRHBIY09aeDVzQlJzRzBxRWZwS1pyUDBCOHY2VEdFaTRz?=
 =?utf-8?B?VWNlMVR0MWNST25KWUVwQ1VVU3FwQ2k4Y1p4K2xTdU5maXlQYXZpWmpSOGN5?=
 =?utf-8?B?STlKRWpwVk5GUmd0SGFrM0xWYVlWT1Zhd1UxZS95aW1CQlEzRjlMQmZteTBO?=
 =?utf-8?B?QXNDRStDYnNYNFN5TjdyZFdWNGNXbUo1ZWVIYk90aHFtZ0EyM3pxQng3c0pr?=
 =?utf-8?B?dFpjazBqcTJmSGZkemtMY0lyUnJ0bDBkYTJhUVNmYnluekI1K3ZPQXdYSkRu?=
 =?utf-8?B?d0JHaGNxLzZqN1grd09wYVE4NVZ2WnJPYjNUUUdEeWN5Y3BoQUt3RWNna01z?=
 =?utf-8?B?N25nZGJSODdoaExIVEh2WDY3ZDdFVi9QeWFzcEw3NFoySTBnbmpQbmZmVktP?=
 =?utf-8?B?SVhmL0REUWZPN1d1MjhoTy9pcUwyMDZZZlR6aWdjTlpwMEZYNnFRTWhhTmhO?=
 =?utf-8?B?THdtNngyVlVleFJYbFJNZ05pRnRoWFlTempTdDFmZ0tBVTFYZXZ6MlpDWmVj?=
 =?utf-8?B?d29hbkVMbysvZFBiVk9KNDl1cGtjOWZLRnFIQ0JEbVowMW0zQ2ZnMWdjRFR1?=
 =?utf-8?B?WGdtY3BqZXFud0d3bDZwVVN0WkdiZ2hVWWtPUWZjaWhjbk5mRjZzeDBDbEQ1?=
 =?utf-8?B?M1dkMTlna21xS3NYUE1OMXBaZjdROUhZblZkNzYrRklTRURMbmVrdUpPTzl0?=
 =?utf-8?B?U0NyVmkzNjkzYlY5R3dtNm90Ulc0QTFrak9JQmhFSGxOUGpYem01M3ROWHNM?=
 =?utf-8?B?eFpiWU80SEVNdEhDUWJGT0F3em9XbytuSjlVT0ZwUXRXUmtjZDE1WW4xSzVi?=
 =?utf-8?B?ZjlsOG5IbG91Q25rOG8vaXdSM1U5amxOSm9TWEpUWG1OWGRuL1ExTjdaZDhp?=
 =?utf-8?B?M3lUMmJjc1pCQmRHMHdLZkNRSFVSRUZwTjRCa3RkcW5yQ3d5SWpqWkdWbHRw?=
 =?utf-8?B?eDN6bVljQ3huYUt0OElQdllVSFNtdzN0ci96bGhRQUFRWTBMWEVQWHowWFVX?=
 =?utf-8?B?aEZoV0U5UnNGTEwrTFNMbmdLUVVFRHRCaXZ0VVZZNC91d1hwT3NTQU1TQTFR?=
 =?utf-8?B?aU54OUpBQzFVYThZUkFQQ0Faa3dBZTdZemJwamNUQk5VLy9ZdkordnNOdnJn?=
 =?utf-8?B?dk9IV2ZnWlEwTWpWSTdIQkx4d2FuTGdWc2lENld2QXdjeWxla2NpTWV1Vlc2?=
 =?utf-8?B?WisrNFVacVQ5Rzd0Q3VRcG0rbVg4MHRRSWpQVk1Pazk4OHRMYVlwMjZ3YU56?=
 =?utf-8?B?ZXowa2VXUk9ML1NGeHlwRXFjS3k2NExMTmk2cVd5V2pMRlV6N0lueUhtYjlN?=
 =?utf-8?B?R3RmalN3WDlXVG5XSGhhN3pGQmFjcGFLUVBWTHYwems2VTRuaXhuREJqOG01?=
 =?utf-8?B?eDQyV0RybFpTdWdsQlR6WjhHa0ljTU82aWxmRHRybWplQXBYWUxxNlA1OXBy?=
 =?utf-8?B?WkV0VmgrNkJSMlc1L0x2Ym56b3U1OWZ4UFR3d0JXcTV6TmZRNWl3dFA2ckt5?=
 =?utf-8?B?Zy9iZlg4Rlo2ZXJwejBPWHdnSk5HTGx3cUdTVnRyRjZmbnBuOGZMMmY4blFB?=
 =?utf-8?B?bXhwK2huWTNWY0NGcjFneDhQVVNGRFV2Qnp0Ym84ZHRNckJkdEJiZEZRNSt1?=
 =?utf-8?B?cG9XK1VxdzBBNFc3VFZPU2VyV2RMalRMdFRWS3ltOHZHUFRQSFhCcHl3R3pz?=
 =?utf-8?B?S3QwajlzSGI0Q2t6VWlmV1EyVHlja01Ea2o3bWtYcGhzTG5jNDl1cjRGSjcr?=
 =?utf-8?B?bCtSZjA4dVBUWlJBcWFvaVhhRW1lS1VWMXVEZGJ0OVV4SjBLa2xJcy9UMnZ5?=
 =?utf-8?B?d1J0VndUNXhYQ2dET0lEd0RWVW1UOUUxcHNTRUl0OVJkS0k0aSs3WTFHK3VN?=
 =?utf-8?B?K3BGYXRtSGFFYkZmNUVpb2J3WDhDcE5mdGxkcGEyckFxbmZ0WFpKWkQxVmtu?=
 =?utf-8?B?TnZNakNPOENRRU1iQU84QkxCSm1PY25YN3FONG8vSjN0bDF0aHJLL3ZPNk5q?=
 =?utf-8?B?anVpNFRreitjR1R4ZFpBQlJlUlhXZk5wYUZyandPcFdJekFZdllrRVRpZE9Z?=
 =?utf-8?B?aVVVZ3pZdDRIVkhUODZ1UC9hNmFFYnNQWCtpelJZc3pjM3dzRlByVllQb0xW?=
 =?utf-8?B?cDUzWjhYWjhHZUZMdzB0MGdLNjlBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbd656d-a222-4ba9-d692-08dd44784758
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:29:14.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NrLffFma4xEFeRidxJTs6nZFAdK4YBW0FUu2jiuAIvsjDlcb1z9oFomH+H9fo+nMiRHXHclpqqXxV0VSghC1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:29:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17734

On 03.02.25 18:17, Jan Kiszka wrote:
> On 30.01.25 10:39, Jan Kiszka wrote:
>> This is a first attempt to provide a pattern and reusable recipes for
>> saving and rolling back the persistent data during A/B updates. The
>> obvious approach is using a filesystem that supports snapshots and
>> linking those to the rootfs revision that is being booted. As first
>> implementation, we are using btrfs. While the current implementation is
>> built around btrfs, the concept should not. It may even work with
>> device mapper snapshots.
>>
>> That said, the devil is always in the details. And even this "simple",
>> btrfs-only implementation took some rounds to find a logic that neither
>> piles up obsolete snapshots or deletes them prematurely. Still, careful
>> review is highly welcome, specifically of patch 3.
>>
>> As we are currently having split /var and /home partitions, this does
>> not cover anything in home directories. However, this will automatically
>> change when [1] is addressed.
>>
>> Jan
>>
>> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
>>
>> Jan Kiszka (10):
>>   initramfs-crypt-hook: Add support for btrfs
>>   initramfs-crypt-hook: Bump revision
>>   initramfs: Add hook for managing /var in A/B fashion
>>   initramfs-overlay-hook: Optimize variable initialization
>>   initramfs-overlay-hook: Tune the parameter documentation
>>   initramfs-overlay-hook: Add awareness for abvar hook
>>   initramfs-overlay-hook: Bump revision
>>   swupdate: Make var filesystem type configurable for update images
>>   swupdate: Activate abvar initramfs hook when VAR_FS_TYPE is set to
>>     btrfs
>>   Enable A/B snapshot for /var on x86 and qemu-arm64
>>
>>  classes/swupdate.bbclass                      |  1 +
>>  conf/machine/qemu-amd64.conf                  |  5 +-
>>  conf/machine/qemu-arm64.conf                  |  5 +-
>>  conf/machine/x86-uefi.conf                    |  5 +-
>>  kas/opt/ebg-swu.yml                           |  6 +-
>>  kas/opt/swupdate.yml                          |  1 +
>>  .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
>>  .../files/local-bottom.tmpl                   | 86 +++++++++++++++++++
>>  .../initramfs-abvar-hook_0.1.bb               | 31 +++++++
>>  .../files/local-top-complete                  |  7 ++
>>  ...ook_0.5.bb => initramfs-crypt-hook_0.6.bb} |  6 ++
>>  .../files/local-bottom.tmpl                   | 10 ++-
>>  ...k_0.2.bb => initramfs-overlay-hook_0.3.bb} |  8 +-
>>  wic/bbb-efibootguard.wks.in                   |  2 +-
>>  wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
>>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  2 +-
>>  wic/qemu-arm64-efibootguard.wks.in            |  2 +-
>>  wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
>>  wic/x86-uefi-efibootguard-secureboot.wks.in   |  2 +-
>>  wic/x86-uefi-efibootguard.wks.in              |  2 +-
>>  20 files changed, 168 insertions(+), 20 deletions(-)
>>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
>>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
>>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.5.bb => initramfs-crypt-hook_0.6.bb} (93%)
>>  rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.2.bb => initramfs-overlay-hook_0.3.bb} (87%)
>>
> 
> Patch 1 and 2 look ready enough to me now while the rest needs a bit
> more time. Therefore, I will keep the first two in next and push the
> others into a wip/abvar staging branch so that we can move forward with
> other pending patches.
> 

Actually, patches 4, 5 and 7 fall into the same category and are kept in
next, too. Makes:

- initramfs-crypt-hook: Add support for btrfs
- initramfs-crypt-hook: Bump revision
- initramfs-overlay-hook: Optimize variable initialization
- initramfs-overlay-hook: Tune the parameter documentation
- initramfs-overlay-hook: Add awareness for abvar hook
- initramfs-overlay-hook: Bump revision

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

