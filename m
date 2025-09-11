Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23454CAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 16:17:53 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.56])
 by mx.groups.io with SMTP id smtpd.web11.1679.1757607466149567401
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 09:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o9ErWTh3;
 spf=pass (domain: siemens.com, ip: 40.107.162.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZnnAv+vKJ3gD9enQpEx85FhmFv6hAni2pHKwjF4vR/sgmu5rHo6ce2Ti3a17AV4kj9856/YYLymZ/olVxSnoXEGtbd1szcW0unaPQSVeSc0c41gA0zLatfe4roPerr9p5BiP7efGCZFz/IeDpQEguY1GWwAVwXHbfeZrDlMXUg+Pwx52ZMkhP4hgL/7JGRfU4vV4/gn4HRXDWv3Fe8ITb/nIHm7VnNb3X9bFoq1l5pgwmwqbHyQaBv3hOBaP99eXFOHJUh75SnOuXAArQK3xuc//gaWJKq21GMEyxRkI3UDbs2Y0br/4KJsQCs2ReGyjI+0msP5CSJMzh9wlmHSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTXJ5SqqGeb/g7a1Y7ZtkRVRWd1sv/Un8/i1blCgQng=;
 b=AHyfPwWQ8nF7sPMAgPQCKUPhF3kGwGl2sSiNGFwvCir62DOodDQdlPaKLDcPDCgFyN4lvH3I2fulzp/ihAtsMhIs81/Dh0UIF+b0a3R/zK96MOCIVRdblu38mbYcIDX6NwN75ZXV2gsgeER4Q7eRM8WCfR5mFJXEAmDzPhsjfMy1EC2EG9OfnaOWW1dGZwIJC3EINDY56L2V977c+fTIXnrPHqm4VOovSaVq+rGEy1wdGkNgOVmY4S83hHxbwU9/1Z8lnIjodFIRSI1R5QbpX82crZa83w7HBtHG5JB34yrIaysN9AQVrwgj50pH4mYTfnuCKNzmszVZq3oX4c3G9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTXJ5SqqGeb/g7a1Y7ZtkRVRWd1sv/Un8/i1blCgQng=;
 b=o9ErWTh3LvW61Vn0UN86JUBXR9eYOyXc5Ud/1rM4KmueJVdlb3YCW+GmtSO4jNXLp3GXHEg8Xl5QI0UbHLTAQiFEXMZOZOAahrl3wmlvf/QrrFwIQjVhdGKSi4lJ8jAzLWQdEr3uuwigvDeujs5MTTGK7GrY9oZwAlaiFQXaT9UrsQvgLKYUs3qdAc19sGtmbkcBvabsrMmGBjqcbnCLZ0VDKxnAtjTbO8MYTWPy1/Dx8s2SOVZwJqXa5FOgA7OfVva2+eUdlt7IWtEYHkidhiM7QAKrS0zUehush8Jdpk34hxC+UlhMz3T81OcHZWATtKQK007SoHMwI7yslfZVSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:17:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:17:39 +0000
Message-ID: <b6badeb5-b1c5-490e-9db5-8c26991221e6@siemens.com>
Date: Thu, 11 Sep 2025 18:17:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 2/7] Add factory-reset
 initramfs hook
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
 <20250904095231.2039819-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904095231.2039819-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 81415bb8-8770-4fcb-79c7-08ddf14eba38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MmU1ckdzMFdJenZ3ZzhQcVNMWXR0aVp3bUpib0dNQmFKQy8vTS9SR2k4UGxX?=
 =?utf-8?B?Y2xhMCtJNHpzTkFoYVdxT1dmaGFuVGVHNTQzbW8xdVlMUG5HaElNQlh3dzJ5?=
 =?utf-8?B?KzhDWmdLMmM1K2ZGY2lLb2o2Tk1wQXZNb28wSUpDcmtJYkQ3TGZRdTZIZC8r?=
 =?utf-8?B?ZXMzYXBzMWVyR2tqQ2h4K3pZNkNCVWN1WFdsMjByVXc1RWxQeUVFZ2tKbFR1?=
 =?utf-8?B?YkRtRDErYmlzQklDWHI2QlpxclRWbEY1UVR3Y0tzM1V0MkRaTmxWWCtCV1ZX?=
 =?utf-8?B?OXN1dzJXRVlnZ2h3bUpCbGpWTHNhMWRGa0JmOFVCRm9BeGR1YWlIT29WM0FD?=
 =?utf-8?B?M2k4V0tybU9JZVlpa1RydDNXc3JhRW1YN1VZalpxbnFmSGZIbXNwWFdYdXdt?=
 =?utf-8?B?TjdHUjZJZkZMaDdhZUplS2VMRlQrZVdITFNnU0t6ZVNKdlF1Q1N6aWV6aFdo?=
 =?utf-8?B?UEJQWmlHaHVpSE5QdHY2eGJ6TTg3STZXa1lPS2dqRkQzZy82enhJZy9hbTBs?=
 =?utf-8?B?Y1RjU3lJRFhFd2tFMDg4U0pENDRCRjRqZ0R6UTNVaTNwVWZCZWwxVkpXN0Rs?=
 =?utf-8?B?Z1dqL1BMSUl6VE5aL0czY1M3UGdwOVNraEdWNE56ekxHbG1qb3hrNWlwSFJQ?=
 =?utf-8?B?cEZiTDNPRFp5cVpJcmIwRHhxdFZ2WTRFRlp6ZkEraldwQzB5emRKTVhDSVF0?=
 =?utf-8?B?M3g5OGFNaGxrenhqR0E2dDlnQVpwaEtFelRiNEVmejlDbDNKOFZ0UTVGdExQ?=
 =?utf-8?B?anowYzl1WWJSSWxWalhZV29Cbk5KdGdudDdSZGtud1ovVmNwTkdla1VwUWpm?=
 =?utf-8?B?WFM5cXFiMldadkFYdDF1akNWeDRzSnN3OWgrU28wdEwyZWhZc1d3U0ZFdllF?=
 =?utf-8?B?MUlFZXd2Tk1TUTh4VE53dFR0aThEUk9CUmptMmc5djhGdWlOZHNhdWk0b3hO?=
 =?utf-8?B?bG52VmpkS0pKSWFZTExFQ2dYWXRJTmxFYmNzRkk4WjdEWktYcWNJUXBNOUVr?=
 =?utf-8?B?cU40S0VLVFlmZ1BReDNxQm94OG04cUg4L0MweTlvSXZlNTd0UDNZLzI4cnRH?=
 =?utf-8?B?OUMvK2p6UmpuY3RkcUQyVWhEL2l6M0ZSS3FTVkdYOWxNVllUTzNWZ1hmZDFM?=
 =?utf-8?B?NUJLTmprWGtvejBwTkE5cm9JMml1N29OZFNKL052dzlFRnE1S1RDamdpT29z?=
 =?utf-8?B?blQ0aXJMNnlIRUtOQzRLWmdQM1I0UjdtdlV6TE5saE5jT1RwRjFVZFhLMGtL?=
 =?utf-8?B?RVB3YmZmVW9lLyszamFWQUhKOUxDYVgwY2lscGNrNU04bWJYeWpqc3NNbDAr?=
 =?utf-8?B?OXQ1VkhxRjNpRi9ScmN0WVU0QUZZUUYrV0xISWUzcXp0dVk0SnRQMWJwOEVn?=
 =?utf-8?B?MkE0S3FBNXViTDFGOWNaSTV0eU1QOUd6SWJjVXZQS1hUcmQyOGc3M2JKMUNy?=
 =?utf-8?B?REZmNjRVSDVVL2twd2RKbElzaVc4TC9BY1ZuYmQ1bGxiblRJTUZCLzZhaklp?=
 =?utf-8?B?dFpMalorRlN4OW5ib0kveTNNR1VzRzRpNk1TRlNMNWlsWVA0VVB4bDRyblFv?=
 =?utf-8?B?N09pQnBUWkxEc21hdlF3RENJR1V5SEV6M2s5dXRvcHcyZGM1QXphd0JSN2lN?=
 =?utf-8?B?ZTRYOWh4cHc2TVNhc1duR0w4aXFUV3JqYko5NkxPY0o3V0IxRGIwakFxeTRj?=
 =?utf-8?B?b2xsTXMxK0c5a2RPTlRmTHZrSjBGZU5PRnp5dHc1NVI1bHNHNDZ3YjRUSllJ?=
 =?utf-8?B?c0JqYVh1QkUxc0hwMHZ4RDJzY2FUbkEydTVYKytySUVzWGNVLzBZSGZCMUQ3?=
 =?utf-8?B?SEtxSDE2bXJFMTVHZ0ZDOTM0RWNGc3JyNHZ4djk0aW5zYjNHQW9BSzZnT3d0?=
 =?utf-8?B?clcxTkx6K29yeVJoaWlmbEg0azRMSG5BQTYrbnhVN1hHS0trdEdmODB0UjBD?=
 =?utf-8?Q?+vQpOUumHCg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWV6dWpZOWxaeVZ3Z0FsWDl1VHlhWHcvT3pjRnpVT3NKVWpibTUyM2FVZlFi?=
 =?utf-8?B?MjhhTTRVeFRxVGNpaEdQS3cxVFVVSXpYZXZLSDNObnhTeWxDRGhGVnc4K1p5?=
 =?utf-8?B?NDNrajFkSGxBQnpZVEhza0s5M0V1eXJZUUFIVEV4L0gxMkllNUNxdGNwWlA3?=
 =?utf-8?B?MXlPWitJT0ZUNHRjSEJSVUJqay9VcFErRmRPQWFYL1puSUxhaUkweS9LWlhH?=
 =?utf-8?B?UTNXSU9IYytPT2lCMThJZkNVZVlpRlFZSk1ORTEwSTZXZk9KbW1LanRJNFgr?=
 =?utf-8?B?SXp1REJlb0NxempUMWZiWFkzbk9RcndsR3lVQzFmRE8zd2t6czkzUlN5OUg0?=
 =?utf-8?B?UlJVbXpUT3Ixb3g4WS96VnJZa0Y3ZEpQQ3k5bytUdWlpbmh2dGU5cDhGV2pz?=
 =?utf-8?B?anZaSC9rV0dZdHQrYndNWFBIa0dzY0NEOVNyT2o4Q3llZ0dtMVhhaWRDL2lY?=
 =?utf-8?B?OEt3Y2FyWkRleHExcVFCVXNVNklhdVFmbFRxeUw2NFJyakNJc3VXUXRXbzNQ?=
 =?utf-8?B?cTM1YjFUQ1JTTnVSWDRoc1VnMUJXYjZRTzBvZlpiaURjcnFRb055K043VEdF?=
 =?utf-8?B?cGZaVE9yY1V4MDliM0hkQmZ0U2wwWmVBVHlNRVVxVCs3Z280T29wY3BFV0p3?=
 =?utf-8?B?Rmc4MUR6OUVreHJFdVRvYUZKdnd3d2MwRFhWTGsya1Q3Rzl4TWhsQ1BoLzJz?=
 =?utf-8?B?UCs4WEZ4eWtBWVRFNWsxVkVMcCsrUnI5WlB5NmY2K3dZOER3VjVNR3hraVVC?=
 =?utf-8?B?ZVVpekNiR00yUzVZa2ZjZ1J6Q3RlLzQvSW1uTjl2Z2N4WWVaZGhQMjFraHQy?=
 =?utf-8?B?SlJhbjdMeloxbUNzSENzZ1k5bEhMeGF6VTBNd2ZEdFllZFQydmRaMXkxU21P?=
 =?utf-8?B?bmxEVnNIQzdkT2hTNlBRUXdTWHBmZTFjSU00UEozTzNXSXNVRXBzaTRzSStL?=
 =?utf-8?B?eWtjRk5pUmRoUW1jTjBheUt2WmlNWkZqeXFDY3I2SlhkLzh6bW5ZN0F2ZnNn?=
 =?utf-8?B?WWJPa2J6WUVhYzBhKzZLZFlCK3g1R3MzMVd4NEpnMk5MU2s0UkQyMXB1UEZy?=
 =?utf-8?B?cExzbEJERnQzL1VWdm9JeHhJbmZYYzlwdk5USVNVNWRGcUh6WS9XTklqSEV2?=
 =?utf-8?B?TTVPZC9YVlJEMDZRVVhzVmMvVWEvUDlvalhENHJoOC9leHNBT2h1RmV6L2Jm?=
 =?utf-8?B?V0x6TmNrMDQ3RFFjaUZCOWJYU1BpUXAwZ2drWEhzN0hFRUVBanEweitybkxD?=
 =?utf-8?B?dVlRWVk5dmU5TThoVWdPVG5JdzlqZ056K2UxMTZyMVY2RGRpUE4zMytsenZm?=
 =?utf-8?B?NzMxQ1kxS3ZxRDN3NHU1dnVYUVlOc210TzdtT21VOFpKNHVDcmp0K295Qk1Z?=
 =?utf-8?B?cFk3MjZGbmNtREdjVTJkZXl2WXZKcmZHYjF0SVFlc0p3U214b3VrU1I5Mkdz?=
 =?utf-8?B?SG9FZVRXR1ZDQlNZa1RSM2tLSm0rb0dJNzlaNmhDWGRWVDdEK3djR2NmK2Nu?=
 =?utf-8?B?L2cvYU9KSTVuNUt5ZGI0SGdvdGZ5TCsyMTgralhiRHpFZmNyb01tbzZkVXgz?=
 =?utf-8?B?ZWZxK1g5cERPYkl3aHRlOW9VbDlOMm1PczQ2LzNyY0NnT0tJNE82azgxVURt?=
 =?utf-8?B?aEtaNENtbXhORDc1OXZ3WXRodVJ2WlJYMS9vVE03N3orOXdHMnppemlnSTVV?=
 =?utf-8?B?WnZndXpja3gvTHhGVklwclRVbTBTdXhoVE1MTnBqYVhLR2JZTkFjUzljSS80?=
 =?utf-8?B?MjEyL1ZwajBYZmR6OTJNOUhlcDVNcEFHZGV4WXhYa1VmZWNmaGR2SExkamlx?=
 =?utf-8?B?cFRobVhsSlgwZENHcmFVdm9jY0FaajdKYUF5ZzlUS212VDJWb25SUmw5OXh3?=
 =?utf-8?B?cnp1SkNHQ2FoMnllZDVZcDJidE02UFp1QTA2K25wbUw0b2tDdzF3ZEQ4UFpN?=
 =?utf-8?B?VWFnRlowSTY4bk1BdHpZVXVIYWJvZGN4cllqT1R6aFo2dWg1T2REdEtUa2ho?=
 =?utf-8?B?UHhXV2NIbnE0QU52UTNZMnJlWUVFTTBOaFkxL09FZFYvSy9WN3I1ekQ4YW1Y?=
 =?utf-8?B?bGx1WE52bWYwMzVsNi9abk9nQzlNbWlvbmxsTUtubXpyTWxTbE9WanZERjd1?=
 =?utf-8?B?cXZCYWJCdFZtbTIxV09JdGkyVk5yem90amZMRTdPOUZoWE5XTHl0cGw3OTdY?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81415bb8-8770-4fcb-79c7-08ddf14eba38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:17:39.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbxgDdKwxpgUS9ixPQdEClLOwUk6YJIAphZKgnfO2zJcikrGfujnzVHv6ii8YDoaloedY218xJK98zLhwN8Klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8643
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 16:17:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20041

On 04.09.25 11:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to reset the device back to first boot by
> formatting the persistent partitions.
> 
> The reset occurs if a file defined by the variable
> INITRAMFS_FACTORY_RESET_MARKER
> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
> 
> In case of disk encryption it will invalidate the keys
> stored in the TPM if INITRAMFS_FACTORY_RESET_CLEAR_TPM is set
> to `1`.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-factory-reset-hook/files/hook   |  6 +++
>  .../files/local-bottom                        | 48 +++++++++++++++++
>  .../files/local-top                           | 52 +++++++++++++++++++
>  .../files/reset-env.tmpl                      |  2 +
>  .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++++
>  .../files/get-factory-reset-efivar.sh.tmpl    | 21 +++++++-
>  .../files/get-factory-reset-file.sh.tmpl      | 20 ++++++-
>  7 files changed, 186 insertions(+), 3 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/hook b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
> new file mode 100644
> index 0000000..7c558d3
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
> @@ -0,0 +1,6 @@
> +# Copyright (C) Siemens AG, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +copy_file library /usr/share/factory-reset/reset-env /usr/share/factory-reset/reset-env
> +

Newline at EOF - likely more places in the other patches. Please check all.

> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
> new file mode 100644
> index 0000000..e807511
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +. /usr/share/factory-reset/reset-env
> +target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
> +set -x

Debug left-over?

> +if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
> +	log_begin_msg "Factory Reset"
> +	for target in ${target_devices}; do
> +		log_begin_msg "Reset device: $target"
> +		fs_type=$(get_fstype ${target})
> +		case "$target" in
> +			*by-partlabel*)
> +				label="$(basename "${target}" )"
> +			;;
> +			*)
> +				label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
> +				if [ -z "${label}" ]; then
> +					log_warning_msg "Could not find any label  for target '$target'"
> +				fi
> +			;;
> +		esac
> +		if [ "$fs_type" = "luks" ]; then
> +			target=$(find /dev/mapper -iname "*$label")
> +			fs_type=$(get_fstype ${target})
> +			echo "luks device detected use $target"
> +		fi
> +		case ${fs_type} in
> +		ext*)
> +			/sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
> +			;;
> +		btrfs)
> +			/sbin/mkfs.btrfs -L "${label}" --force "${target}"
> +			;;
> +		*)
> +			log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
> +			;;
> +		esac
> +		log_end_msg "Reset device: $target"
> +	done
> +	log_end_msg "Factory Reset"
> +fi
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
> new file mode 100644
> index 0000000..d61ffe8
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +. /usr/share/factory-reset/reset-env
> +
> +target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
> +
> +if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
> +	log_begin_msg "Factory Reset"
> +	for target in ${target_devices}; do
> +		log_begin_msg "Reset device: $target"
> +		fs_type=$(get_fstype ${target})
> +		case "$target" in
> +			*by-partlabel*)
> +				label="$(basename "${target}" )"
> +			;;
> +			*)
> +				label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
> +				if [ -z "${label}" ]; then
> +					log_warning_msg "Could not find any label  for target '$target'"
> +				fi
> +			;;
> +		esac
> +		if [ "$fs_type" = "luks" ]; then
> +			# after this the data on the encrypted partition
> +			# is inaccessible
> +			tpm2_clear
> +			# with encryption the original fs_type is hidden
> +			# use a variable from the reset-env to set it
> +			fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +		fi
> +		case ${fs_type} in
> +		ext*)
> +			/sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
> +			;;
> +		btrfs)
> +			/sbin/mkfs.btrfs -L "${label}" --force "${target}"
> +			;;
> +		*)
> +			log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
> +			;;
> +		esac
> +		log_end_msg "Reset device: $target"
> +	done
> +	log_end_msg "Factory Reset"
> +fi
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> new file mode 100644
> index 0000000..127aaad
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> @@ -0,0 +1,2 @@
> +INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
> +INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> new file mode 100644
> index 0000000..68dda34
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
> @@ -0,0 +1,40 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-initramfs/initramfs-hook/hook.inc
> +DESCRIPTION = "Delete the content of the given Devices"
> +
> +# list of partitions by label
> +INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
> +INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '1'
> +SRC_URI += " \
> +    file://reset-env.tmpl \
> +    file://hook"
> +
> +SRC_URI += "${@ 'file://local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'file://local-bottom'}"
> +
> +TEMPLATE_FILES += "reset-env.tmpl"
> +TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
> +                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
> +
> +RDEPENDS = "factory-reset-helper"
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
> +DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
> +                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
> +                   chattr grep find"
> +HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
> +
> +do_install[cleandirs] += "${D}/usr/share/factory-reset/"
> +do_install:prepend() {
> +    install -m 0755 "${WORKDIR}/reset-env" \
> +        "${D}/usr/share/factory-reset/reset-env"
> +}
> diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
> index 4af5500..8d1b126 100644
> --- a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
> @@ -9,6 +9,21 @@
>  #
>  # SPDX-License-Identifier: MIT
>  
> +# shellcheck disable=SC2221,SC2222

Why?

> +while [ $# -gt 0 ]; do
> +  case $1 in
> +  -d|--delete)
> +  DELETE_MARKER=true
> +  shift
> +  ;;
> +  -*|--*)
> +  echo "Unkown option '$1'"

Unknown

> +  usage
> +  exit 1
> +  ;;
> +  esac

Indention is off

> +done
> +
>  marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
>  
>  if ! mountpoint -q /sys/firmware/efi/efivars; then
> @@ -19,7 +34,9 @@ if ! mountpoint -q /sys/firmware/efi/efivars; then
>  fi
>  if [ -e "$marker_file" ]; then
>  	echo "factory-reset was triggered"
> -	chattr -i "$marker_file"
> -	rm "$marker_file"
> +	if [ "$DELETE_MARKER" = "true" ]; then
> +		chattr -i "$marker_file"
> +		rm "$marker_file"
> +	fi
>  fi
>  
> diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
> index 281ea3d..fbe5f96 100644
> --- a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
> @@ -9,6 +9,22 @@
>  #
>  # SPDX-License-Identifier: MIT
>  
> +# shellcheck disable=SC2221,SC2222
> +while [ $# -gt 0 ]; do
> +  case $1 in
> +  -d|--delete)
> +  DELETE_MARKER=true
> +  shift
> +  ;;
> +  -*|--*)
> +  echo "Unkown option '$1'"
> +  usage
> +  exit 1
> +  ;;
> +  esac
> +done
> +
> +

Extra newline.

>  marker="$(basename ${FACTORY_RESET_MARKER})"
>  marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
>  storage_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
> @@ -40,7 +56,9 @@ fi
>  if [ -e "${storage_mnt}/${marker}" ]; then
>  	echo "factory-reset was triggered"
>  	# delete marker
> -	rm "${storage_mnt}/${marker}"
> +	if [ "$DELETE_MARKER" = "true" ]; then
> +		rm "${storage_mnt}/${marker}"
> +	fi
>  fi
>  if mountpoint -q "$tmp_mount"; then
>  	umount "$tmp_mount"

I didn't run shellcheck again - please check if it finds more.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

