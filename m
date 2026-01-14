Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE3D31A28
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 08:26:22 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6052.1768379174497008396
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 00:26:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jk3z2aKp;
 spf=pass (domain: siemens.com, ip: 40.107.159.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luw+RIkN9q2dsmWUKVKLeRvQJf5Gt6Hx4JvPRmVCAONnfc03lN8bIJqGA1tUowRDVbP2hEPE+LnmdVD33OT1M2zDx858kuRQYC2GDiRnGsrM/NS3kkzL8/6YUlU9RDoqLsAGs2PBwZVFvFO196CbFtLb2WtovZKu7UnGyXZj6Fp7Miw6291P3NeS7TuIM5VzlglYvoD4sp5cd02hcHZQ/ObPZQ532dfzYAqDvVJUuYzVwTwb774L4keown8uwQEYRwNU2GVcgRRCrkREw8SmcWjLyia3N2od2az+GHWv1ae+AIHjUXufU24uQL2tYkvgjalaiOmNCkG2p/uht1IH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fho/a3UQThtFkeznM8yx7T9hF3GCEh3WH7xrgYctZI=;
 b=JAfCQ9HihUaL+jNx8Jxk2EnuqzhJbURIM4ifMXHdwT/uWPndEiPZLpdMJv6aiYLdbThll2d31FLQJWfwn01jNGAesTLPSEH8dIHEttn6e2WfBUFiYebQ5DQLiEF98qHBtKQR3gAb+hbJjD52rhrg3NYkW9lSVyGvf1LdynhGZ3F+mSdol0UsB/lkb53e3WS5VJY9M3iTzywAWuyMeb2lc/MRrl/fpKS+08wWcA4px6qu0/ef+y0yQvKAZWHc/pj0C0iC2Z1LHdX4W2z0o5oS0sIasAXVduf7Vmt0Q+hVHSGGic4QRU0qpO4KwXKNUc3uViZtrfKQEAXTOLU/0pNXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fho/a3UQThtFkeznM8yx7T9hF3GCEh3WH7xrgYctZI=;
 b=Jk3z2aKpjbsbgnHTqQjkyPE6/aJp64sBdaMjHD1Q4nGX5POOT32WBz2zj7TpIuoh22b1MiApBbK9LONKCIo0uCzWR60RQTgi3HYYCunXUFABAl2Y8FbclkjKbOSJgWoZsa6SINspyvso1e3E9pw4TNY1LtZOd+uTd6hJDbNdJLPnh6AT2Mi/oWAY73dgUeE3QrXBEpSXh339RndjNRctCN6wxqpfAqCLF8Beu7x47DrYU3J+fgdF+Xdoy44bHWMNctWDMGikHG4dzqm1PmaqHWQo0IWpel/uUe9DJcW1hrYXq8yu4BwMst+Ol96SgErDfXryWpLS9JcTkxRsdYSPlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 08:26:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 08:26:10 +0000
Message-ID: <357734d6-cf45-4855-a0a1-70ccf3f8e388@siemens.com>
Date: Wed, 14 Jan 2026 09:26:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] wic: Unify /var partition handling
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
References: <20260109095039.29617-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260109095039.29617-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ca8c18-b340-400b-f01a-08de53469200
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZlRhVVZnbXpnQmhlbThGY3JhK3FUbEhzd1pqWWV3cnNsYmlRdkhYbWdqUDVC?=
 =?utf-8?B?V1UwdlFhcWdvWHZZNVFjb1pJZVpUcHl4RlVYTUFFUHg3YzZDSkJoVkVKWUVK?=
 =?utf-8?B?VW5GRlNtLzVkb2IyN1BDS29QZFY3elVEcHAwZXd6WXZvUXkxQUpGZmlSUkNC?=
 =?utf-8?B?cGdiSU44TlVobk1wdmtOQmdCMGZlK2JmSXJMdEN6MjRTQStqaklKODU3Yk9P?=
 =?utf-8?B?Y1ZqRzNIelpJZWhyM2EvYmU3WXhMRXFVZWFGa3QxZGQvSHgyR01mcHA1OFRz?=
 =?utf-8?B?R3pKMytHQklFcnNYZjdzS1ovV1lvSHNXeTE3dmRkMlBwS3lVSjJKV1doR244?=
 =?utf-8?B?eDJ3K2xQOVV1UmpsdURjdkhTZG0rTVlvUThmYzQ0VjZzd3ovWW9xVlNXbUIv?=
 =?utf-8?B?L0pVVTlyMWxxS1V4a1FUKzNJNlc1UGM3eUlaeEt2R05HRmdxOVl2L2RTMTZH?=
 =?utf-8?B?V0F6MGp5VFZCZkRrYWxEWDRkdGpDYjFuK05SS1lkRHhyei9uV2lnZlE0a2U0?=
 =?utf-8?B?TGZlMG85SWlHNHZuZGpUamNpWlBxN0drcFFPalQrd3JMbUtEYU1GWkdBMlh1?=
 =?utf-8?B?Rkg2SnZLTlRraCtqMlRNWGsrUjc2YXRKdVpBSWtwOVFTZzZLZE1NOVFuV2lR?=
 =?utf-8?B?QVpYVXZENXI3S1lvdkdDT0ZYQXl3eVZCYlpGczhqby9sZnY5TmptMmdqVjJG?=
 =?utf-8?B?bjJMeHpHVEhMNU1COWZXb0hPQmpNUHIyMjFOV0ovVHcyNzRZWmNsZG5TZDRI?=
 =?utf-8?B?WUdsU1EzLzdrS1FoaHUydlRWRVA5S05JbVVhdFZFY0xSV1J4WlU4VEJMczZ5?=
 =?utf-8?B?YU81Z0NuVEovV2dKejZHc0MyTEhzK0J6RTRSUnhpWjlSTWVFSktIc1R6U0Y4?=
 =?utf-8?B?cm85MDNUQzJHMWh4MnNTMGVvclcydzlnUkdMTllLMXcxdnhBUUVCdSthOGYy?=
 =?utf-8?B?RWVnNlQ5aTlvQlkxVXVoRWFPSUxzYnh5S0svSUlSVFA1ZDBpN1NqOTZCa1ln?=
 =?utf-8?B?UGl4WG1jREthcTlsblJGSnlmb1UvcEFEMjU0U0ZMaVlUTWFDNWRtNEpVTDNy?=
 =?utf-8?B?ZW8xcUJtbS9WRVg2b1lNSHRxZjJ5S3pKbmJlVjBDS3pPQld3aTNEd0NQVHZn?=
 =?utf-8?B?RWRlbVpEdGo5aDNONjhyTmVNRU9JN1JGc1p4WktrUW1NT0IyT0d4eEtMY0tQ?=
 =?utf-8?B?aXBvMVVWTDYzWWRUZzgvc1gvbDZmeWJHbnFabmliTGtKK2dTSkd3aElsK1hU?=
 =?utf-8?B?V0htQUVzYitGQ2RRTzY5b3J3U1dRR0RCK2ttdVV5N0RTa1dURzFDbElrWnVx?=
 =?utf-8?B?Vng3OFYvYmdGZ0VsLzY2bThEN1ZHd0xaTVhyR2hkQ2QrNXh6ZG1PV3RhQmpH?=
 =?utf-8?B?Q0w5Tmc3QkJmL0paNnk4MzNzMVdOTHZPbUU0a2JHbE5JZk5Rb29GdUVJdTRp?=
 =?utf-8?B?Z0MvQXpmc1V0QVl5TUgyRklBNnNydkpoSEJCR3BCNk9oNHovVWt6UldSMFpa?=
 =?utf-8?B?N0d4Tk1EQVdGY0Fva1VSSmFqdEQwK3MzQjZxT1F3d0FkYytQUi9VeVVqMXh6?=
 =?utf-8?B?Sm0yNmpZUDJmcVJ6V3djcEFQbjhCZUpWS29DQkxCbDFnejlYVE5wQ3NQT3NG?=
 =?utf-8?B?QTB4WTQzQVVySXBKb1pVR1BUMzRRb3dMSTdPVVZKeGFKOXFtOENXenRZMXhX?=
 =?utf-8?B?ejJuaVF6Q2FnYjAwSzF0YjRrZk1ZM2oyWDkwZ1pzWUtqclQ2cEtVWmJJVDZa?=
 =?utf-8?B?c0Z4MlptVEp0VWprMHhpYjdxckpQMXk1aElKMk1xc1NVMklDWjNmSmh3TWZN?=
 =?utf-8?B?dTdsUXhxRGtRdW92cEE5T3ZSK25jQU9JRFgwYlNRL2VocVI2ZGdIbHJ6TkZq?=
 =?utf-8?B?SnRSVkdlbm1RY1JhK2RDdmFIdWc3ZFJpclZzbndLUlh2Z0JPMlJXVkJBbUF1?=
 =?utf-8?Q?ngc8zgZmvjmlup01KpWc61Jo47P3u/1r?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDNtVFhlajlJellJakNLaFFzdFk2ZzNEWEhUR0QxaUlDVExvZkR2MkhzTFdS?=
 =?utf-8?B?UFRwTmJUS2I1VXFOSHN6S1BYNWVwMGdDZC9XNzBIUmVPcXRMcGc4QjdJdkpl?=
 =?utf-8?B?MmQ0dFcvYURWN01aczlzelNMdHB5cSsvbDcxS0RHSnRzNVV2aW5SZlNIS01E?=
 =?utf-8?B?Z3NsS3hYTm1XZ2ZoU2tMU0h0SWdzYUhpVkxEZjJqMkd5ZDFCTWVpdE5SeW12?=
 =?utf-8?B?eVJ2eVc2TjFma3lheUd0dVhSc1ZKbnRzWjlzSmNFN1hoc0xTYU4yRXZORnNE?=
 =?utf-8?B?YXBkN3VRSW9SZE84c3hBOWQxdDdQMzRUS1NtVk9SVU52eTc2UjN4UWRkWENR?=
 =?utf-8?B?UHhWajYzdUo1U1hhMjZWeE1IMUdtQUR5aU5MMHBQYzkyUEJUUUZ0ajQySVFm?=
 =?utf-8?B?bTl2ZXF2NjlCVHQ2eXJSTld2S1cvMVFMZFE4TmdCSVRhMXpsbnJKM1N2TzV2?=
 =?utf-8?B?Q3E1aVZtVHZGYUdkU3ZXUkNZN0UzMVphY29VclE5YkI0aUtCUjczcTNZbWFU?=
 =?utf-8?B?VThVYStQVVBpamdKZytjaWhwaUZoZnZoYmdSTWd6SnhkeWZkNHE5ZzRQS1hI?=
 =?utf-8?B?cGJIWEp2M1loTTRsMzhHV3NVK2cvNTNQTDdQVUhzNnorTjdmZ3RYTFBqU3Uv?=
 =?utf-8?B?VFAxazR4WW9aYjdjZUV2M0dyRC9LR0YvUWszUGZnWGJRekt3WHlsb1lSUFgr?=
 =?utf-8?B?ZXk4eFhJU3NNTEF5MVE5clQ3bUhkSjdHeGxxZUNwWHNoR09RMk5DaUpYM1oy?=
 =?utf-8?B?Qi96cDlvSHM0eDJjdFYwRzJtV1hyQUU0bDRPTWY3UWJGdzNud0kwYU5GbU8y?=
 =?utf-8?B?MFZ2YkpIZDduVGM1VG8xYThlOG9saEdDeXhCYTNFTGk3Ti9mbDdJQ1o0TWkx?=
 =?utf-8?B?WC93VU9qT0Y4S3YwcVdUbmQ0ekl6MmJVUzVxMXhHRVRDOFdHODFRd0Zld2Ra?=
 =?utf-8?B?QjNtLzkyL0JXNUMraVFhZXlOb09DUEhtRk5QV2JRemFhWGdSd3BkYk5jOXJ6?=
 =?utf-8?B?WHJDV1dyQXZNeHlIclFOV0tDQkIrd09sQzZJNTBJRjRCdEJNWE9oSU54S3hT?=
 =?utf-8?B?SXpMWUE4TDFZQUxCZzBWYWVBYmdMWlJ3WUxPaVMxZ1hQRVdpVnN5bWQydUxC?=
 =?utf-8?B?cFhqYjdacnQxVXBuK0M2d1ZQUFlzek92YXNqdTNRTlljb2N2akgvbjFJNUR1?=
 =?utf-8?B?V2RhaHlrcm9NM1NaVEdmQW1KemlzMWU4aTdwN3QrVFZiU2dEWkxKN21HVUlr?=
 =?utf-8?B?dTlIR2lncFZVaVg2SmlBWHFlcHJrWkVYaWk5Q2Ivb3MydTJtZ0JQQ29naHdB?=
 =?utf-8?B?bFp0ZlYyNFc5R3F5TXpOSXg2TzVjSUdiNnNJa2RZTUtRcWh6NTBEcTFWaXUv?=
 =?utf-8?B?eGtCdG1uVEdXeW45NmgyQ216Zmh5TVFkK1l3QnNqR2drWjk4eUc3THJjc2lx?=
 =?utf-8?B?ZlR4ZXpuQ1BjeDZtRGxac2V1QW9JZHAvMnMyWE5lRHdmcTgxRllia2hXaXRi?=
 =?utf-8?B?WFkzeWpuWWlZbHU0RXhPajl5ZS9FWk9sVmtWM1FIQ21GQUdIWENpN2VLMHQ5?=
 =?utf-8?B?VGhDZzRiNE5pWG84ZUxndzZEYStTOElQc21tamhNQkM3SnpyajVGRHRtVURI?=
 =?utf-8?B?RmRJd1lJRWZadUhGZ3dvdUk3MEdUOTkvY3pXNk53U0NUcDV4eFg3V2FVbVJ0?=
 =?utf-8?B?Ujl4dWMyTEdXSXVjUzFYZk9GMUxvZ3FTTGJ2bEtBVVVQZ2phRW00V05oaTVK?=
 =?utf-8?B?dktNdCtKQjgrU1FoTG1OdWg0S0lyS0hmQnRnc0d6aGdDTmxTbUtkWjhpTUMw?=
 =?utf-8?B?QWExMldRUktiVS9HL2lJc0VjZnlCSEZzN2UrNUROYlRYVkR4dHgwZ05XQ0Zo?=
 =?utf-8?B?K2pTSWxsZExZL1g4enZHVWR4dytzUVhNbFNaank3bnFsMnBVZmlGT0R6SmlV?=
 =?utf-8?B?ZmVSdVJLVUVDbm82SmVKbGxtSVBSREJOQVpob1pvVHV6dVpUcjdsYVgrZC8v?=
 =?utf-8?B?NHkvMWpvNFVjaEdMQ2xTVG81Z3JBOWJSN3gzWUhzNjRDb3JqR3IzN1Q4c0lr?=
 =?utf-8?B?d2dCcEVjNmk2RTFEYTZLczZTa2syc3BCN2k0dFZVWmtGNjdBdC92N0wvbWFU?=
 =?utf-8?B?dzBIVUx6UVZjSFAzQkJaRzJ1dlYxemdFcDdPdVJQRXRNeVBjVFBDUk1zVmpp?=
 =?utf-8?B?QllDSmFKUFNlamVjQ3YyYzZmTllHS1JoRFVWK1J4Zm9ZRjhHNnBHN0J5Y3dN?=
 =?utf-8?B?TFdHRVp6Z0RZd2NnS01xK2NnMFJEbUxPNTQySkIzYTh3V2tTWjY3bWhtL3FD?=
 =?utf-8?B?MFFqVlpucU9TWUJIN1RCUzNDaS9yZnhKY2ZnK05YVWpUWjV5OVpXQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca8c18-b340-400b-f01a-08de53469200
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:26:10.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z6w+dV6iYPUosKBR6FaaoSq6D21Bc5HoUNVT4fFpE3f2u03n3DkMcSLR8v/QawBNNDDKdhjhyAnTOQsa5+8wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 08:26:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21538

On 09.01.26 10:50, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> This allows changing the fstype as well as additional parameters
> used to create the partition depending on configuration more easily.
> 
> This simplifies the implementation of possible update strategies
> for the A/B support for persistent /var
> 
> This patch unifies the slightly varying partition specs for /var in
> *-efibootguard.wkis.in files
> 
> Main difference was:
> 1.) --size vs --fixed-size
>     Probably the most critical change.
>     I assume as we ship empty /var --fixed-size is the desired option to put.
> 2.) --fixed-size 2G vs --fixed-size 512M
>     as we ship empty /var there is no need to create a 2GB partition image
> 3.) removal of --exclude-path boot/
>     this seems to be a copy/paste error from 928209ae423fcf7a658e91be2b1e39ee32b5227c
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  classes-recipe/read-only-rootfs.bbclass         | 3 +++
>  wic/bbb-efibootguard.wks.in                     | 2 +-
>  wic/de0-nano-soc-efibootguard.wks.in            | 2 +-
>  wic/hihope-rzg2m-efibootguard.wks.in            | 2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in   | 2 +-
>  wic/qemu-arm64-efibootguard.wks.in              | 2 +-
>  wic/qemu-riscv64-efibootguard.wks.in            | 2 +-
>  wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 3 +--
>  wic/ti-am62px-sk-efibootguard.wks.in            | 3 +--
>  wic/x86-uefi-efibootguard-secureboot.wks.in     | 2 +-
>  wic/x86-uefi-efibootguard.wks.in                | 2 +-
>  11 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-only-rootfs.bbclass
> index 81e747c..a67bb5f 100644
> --- a/classes-recipe/read-only-rootfs.bbclass
> +++ b/classes-recipe/read-only-rootfs.bbclass
> @@ -17,6 +17,9 @@ do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>  WIC_HOME_PARTITION = ""
>  WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
>  
> +WIC_VAR_PARTITION_FSTYPE ??= "ext4"
> +WIC_VAR_PARTITION ??= "part /var --fstype=${WIC_VAR_PARTITION_FSTYPE} --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153"
> +
>  IMAGE_INSTALL += " move-homedir-var"
>  IMAGE_INSTALL:append:separate-home-part = " home-fs"
>  IMAGE_INSTALL:remove:separate-home-part = " move-homedir-var"
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index 474105a..6883579 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -16,6 +16,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efibootguard.wks.in
> index 906aa72..f010853 100644
> --- a/wic/de0-nano-soc-efibootguard.wks.in
> +++ b/wic/de0-nano-soc-efibootguard.wks.in
> @@ -15,6 +15,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024  --size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index 9df0de5..fdbad14 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 261a25f..941a552 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 4b270a6..21c0b24 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index ca12b5c..948c67d 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -8,6 +8,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024  --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> index fb21cd0..c777a6b 100644
> --- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -16,8 +16,7 @@ include ebg-signed-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# var and optional home are extra partitions
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
>  ${WIC_HOME_PARTITION}
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
> diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efibootguard.wks.in
> index b6976ee..5137c66 100644
> --- a/wic/ti-am62px-sk-efibootguard.wks.in
> +++ b/wic/ti-am62px-sk-efibootguard.wks.in
> @@ -16,8 +16,7 @@ include ebg-sysparts.inc
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
> -# var and optional home are extra partitions
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9 --exclude-path boot/
>  ${WIC_HOME_PARTITION}
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt-hybrid --timeout=0 --append "rootwait rw console=ttyS2,115200n8"
> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
> index 3e141e7..2af3e58 100644
> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
> @@ -5,6 +5,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
> index cc317f0..3640ecf 100644
> --- a/wic/x86-uefi-efibootguard.wks.in
> +++ b/wic/x86-uefi-efibootguard.wks.in
> @@ -9,6 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # var and optional home are extra partitions
>  ${WIC_HOME_PARTITION}
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
> +${WIC_VAR_PARTITION}
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

