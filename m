Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5CCDC167
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:52:29 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88261.1767700341173570601
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:52:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rH1CHAal;
 spf=pass (domain: siemens.com, ip: 52.101.66.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldtlAHql5PNk5YTmNOVu/6vv7Aqwm4iqXUQeaDCb2xgD3ciX2RLdnctTCvg2SPNl93Re3g1u8ZlJ7v2LrPZaArxORaQntu57d3yi3T1470VFgUsNAYsAVRxE9daID1pyQ0BpQFqfT6V5EWcM0h2hLQG2IPLIml0T3HtNYXSuPcp9QQ4E2TeJwPqlddd6o5ijMJW/BuWSt8FKKpSiDoSj/q1G1e+IDPE7zzS27Dzmgi37GHz3eA6ewLiiKf53DCKZlpIsWccpBDV6Nz4vdhyN9VyXjFkvt1900nC76YhtZL5dqSQZTHTivtaV6FPdkP6lJHb/+VSl7VfN+W8abqIx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4ITSKW+APnViSZwyciE4v9sKCZLSxmndYSxhkmQ8lQ=;
 b=Iflw31grwaNq5moBAKz6hcqNf4a3IzQyz4GBbenrjCyiE2yINEt/H/0zLy8dk0hGuBCmN67hpBtNTiNR05KvT3J/A5tiW6DyVICkevJlc6UjQW3D5Gpx9T+DsfrjoQsuNhhXn4SE0lAxpSwju/GQTBJXVLjXfNwRCzidwKoxHEFRmfCjjVW1zAMxtng6G6UHNCqULCeIiECtC/eNukaIWZkiuVIJ5a6gExBxXih0s/BCXFsTCEhj3yIP7wClmLfkIbcaEynpPPsGuiaBWYx/qvnHq7vwdub9RVEfc36umm+KXs0EHUInGFyP0Xji2/hE0H4zzSPzWNjqhb0wqV2cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4ITSKW+APnViSZwyciE4v9sKCZLSxmndYSxhkmQ8lQ=;
 b=rH1CHAals/J+mPL+5RGjW/TjsWMNVmL2xPQxgj+yZX9LmCgzpVW2OD3xP/eqRZT4aVuXEAnKfTe0DurwZDBND19+PZXhp8z17IDBzcomC2VF/nLy92zbNuoZRufPB/M8kbpUEL8QUV3Br4+BtOw05OUf+690blG1/XARn7V4cnMWFplrj6AUTWQkPq9L6q19Bww/TWFhOmkFe41XZlIuoKAP05HHOhuOGsSV4dPUnFHntNHfcC3cUQykWgoIB0L3COekOprHV+i3N1hi93TvdD61tuaFnFLeacSHQZpuxWybSwfkGRL33IXLP96LjQimaSDJozYPHmR+c2+MsxEa9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 11:52:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:52:16 +0000
Message-ID: <3c563f73-7800-4b95-8dc3-b7e4025773c1@siemens.com>
Date: Tue, 6 Jan 2026 12:52:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): install systemd-cryptsetup
 for LUKS userspace support on Trixie
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com
References: <20260106114331.924611-1-gourav.singh.ext@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260106114331.924611-1-gourav.singh.ext@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8147614f-7148-403d-1ba8-08de4d1a09db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WEZ4OG81cXZMbXlKeFpQRFliVzZYeGRENEtKN3Zrb0MzQnNzSFlVU1BRKzRk?=
 =?utf-8?B?UlBqcTR5U0VIN0h6Q1VLNk9UcUNvMk1OaUdldWlWd0JHTlU2WFhaeFhjSkRI?=
 =?utf-8?B?QjZyYzN3UkZCNVFYZEs5c0Y3WXMxK2JETklMWlBjU3IvRUtoRmJWV0g4TUtp?=
 =?utf-8?B?NEZhNjhZa2UyM3BCaWZSb2M2Ylp1V1E0bU1VaDdjWS9udXRXTDgySmRpalFs?=
 =?utf-8?B?MHkyNzlaVmprZVZGU2k5TkNWVitieFR2UFVlZ3FUa3J1Sk1FWlpzNWpBaW9l?=
 =?utf-8?B?ck15Z3BSVW5tRFhGOFI0OHM0SVFHUGlWTitYYm5pekNGUklRZHMvN0VNd2pi?=
 =?utf-8?B?eTRoVEVoTFJtNmJCU1BzTjVtdzZkOTJ2TkprdUg5NUcxbU1QTUQ3Vm5lc3NZ?=
 =?utf-8?B?dlhIV290dEMreWI0bTYxV3ZveXRlT3R1YUR4RGpQbDR1UnROcDNJTlFTVHVi?=
 =?utf-8?B?OEVVWC9DZzlLT0FUUVpVSDdrOTJtTGlNd2xudmpqRVJoeWdmSFZ3eGpQTmdr?=
 =?utf-8?B?aERUTmsyc2pEeTI5UktNdDh5NkVVYnkxTnRocmhJODh0UVc5SGFwTDR1RWVD?=
 =?utf-8?B?dWtsK295WUdScXhpUDN2ZHdTR1NkMEwwcmhLZ2NlazY4T2tmQ0xPTU9SWVZ2?=
 =?utf-8?B?alJxbk5UUHRrUkhiYk1xRThWUFZYeUtVWGJJQU15cFN6WnhKVjdla3IyVUNM?=
 =?utf-8?B?ZEM4dVV5anlEMU1GRVRqd2QrR0pqK1RJUG12dVJiNGk1VExEdTVQVHdBMVVi?=
 =?utf-8?B?Nk5SK3pVL0ZBK1BaZmtCUW1MdDdzdHdNZWczd0I3elQ0WkRCNG1DT0xzYmVr?=
 =?utf-8?B?SC9oVFQzRENKb0lPWHNBQlFvMy9CejAvanh3RVV2OVprOHkzMmlWZkt4VWFF?=
 =?utf-8?B?S2Z6OWlMUFFiQm1qeG1wSUhvQldsRUlmbVlQNE8zMHg0bllCYXFaU2tRYmdp?=
 =?utf-8?B?bGtDcVllbWh3K29BTThhSktHNDhiTjJoR2dsSnlrVWZ3clEwdEE3YjZyNC83?=
 =?utf-8?B?RS9CZTl6VDNueVV1dlRZT2JmYzlJNHF1aEtsRThMN28xL1k3QVZibVFtb014?=
 =?utf-8?B?L1djNVpaSDBLbWFGL2lwU3cwTVNxWWpKK2ZWWENsQWZnM1h5cEllVW5rTGJW?=
 =?utf-8?B?VFo3bVRBTkg4ZHNzMDN1ZmZpQ1E2UG84UGVDbmdVTjRiZlRZa1R1SkV5MWhs?=
 =?utf-8?B?VFpqVDlNRDNhT3hFV2M5SWhMUSt1KzZKS3hxV0w0L0VDYWNJZWFNRk9nZTNQ?=
 =?utf-8?B?bU1zVXdnSXlOSEh0b1ZGSENHeXdWL1gyQXAzT2J0ZHNUT3QyRXBMakpKQVFV?=
 =?utf-8?B?aUNRYUNsWS9jdENkM0VJcUU0ZEZtUmErMzRyWWdDendnRXpkeVpCc21CcGNU?=
 =?utf-8?B?TnErekpwNkY2L0p2MUZKU3doYU81K0tXL3pXOEFaNG1BWDA3aDhWWW5mNGVp?=
 =?utf-8?B?QXJWVHg3ck9WZ1AwZHEyNktyaFcvVEhpblQ2QzFCV3VOYkR0VFF0MDdCUFpQ?=
 =?utf-8?B?eXI2WkxteG8wTE9MWi9NYldZZ2xLdUNoWU9ObkVTMFFKcGJPa2c2VEVzaGls?=
 =?utf-8?B?Q3piL1ZabzByN1ZlVSs3MEF3QTBIa0V1Q0xsbEUrZ3NKT3k2cFBoV2dpbVhr?=
 =?utf-8?B?bStsTWV5WHdUT0UwcG1VQXBhSTYwRGpOM0FvcDdJbXowaW84bkVjT2o5NDB0?=
 =?utf-8?B?TktqTERQUFNZOVY0NXNBMC9JTnVvOFo0VmZ2QytXWFo1VFR3T09qbzlqRjJL?=
 =?utf-8?B?dVRwOGdyWnpYdFFJZU1ydnc0dWRhMDVuakQ2MHN2dnZKd0c5Z0ZZb3hCSG4v?=
 =?utf-8?B?Q1VBNVI1eWRjUkp3bFN0SUZta1B4YVE1SXFlQWpnbVFPcmNSMmZIMUp2RUEw?=
 =?utf-8?B?R2JIVUFXYWRvekx2c2FvTDBpMm9PQjgvRkF3bmpjWjdRN1FQSCtrMUxnZERF?=
 =?utf-8?Q?3X2wr5i3x7myOK1elATeTc1zuwnbMYe/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUZBOVV5WWd6WmhZaEN3eGFXVFFrSDVLbXlDVUJ3VEVhN1FMRUJ0YUxzRkxE?=
 =?utf-8?B?aEcrZ05XLzZoVEhXR3FUTW1KaWRPczRPa1pWTE4wSC9RWFFHVnNjSmZiU0xy?=
 =?utf-8?B?RUhFb0E5VzIzcFB2c2hQK1pubTRRUmhod0JyV0R3ZHB2ZmtIRVZTc1BVNERU?=
 =?utf-8?B?by9tdlZBZmowNXVUR2R3azJNbk1jVHpvcEp1cWxMZWdaaG9KbHU4L3NhZnJZ?=
 =?utf-8?B?ZjRlc1Vuc0ZXWXVEZzNaNkF5MFR2ckpYanY2TGZqQnl6V09ZaDdzdUp2czlk?=
 =?utf-8?B?MjlIOHhXT3ZZbk1mWDZUK09VMVVLd0hYaHRPNkppamUxZFlLRTB1MkxySjlZ?=
 =?utf-8?B?SjQ3RDJocHVaYlFWeG1OQzk3cDZsbXcrMWJGRVRPZ3ZNNHlxdXRobVRFLzZx?=
 =?utf-8?B?bytLdmpSUlk4R1QxUGxGS1BlT0NJWFdRbGlNazBUVXdBK0F3VjR2Q3dQeS9u?=
 =?utf-8?B?ODhOaDY0RkIwYzBOUjk4M3lXbmdzWWZJT0RCWGZycC9MSjBJazlkU0VFSFhv?=
 =?utf-8?B?QndHWUwrMzRVUytZVmVXUzlLVVR0VjBCNE5oMkI4NktpT0h1elFrU3JIRSts?=
 =?utf-8?B?T2ljTEJoejVLVGlGQWQwYVMvNlZUNWJicjhacXBXa091dmh0bDZUMkhpOEN3?=
 =?utf-8?B?c00zQWcyaUUzcDRQbTBQcXkvZ1FPVGNKdWxYZTkzcDNPbk5ya0Nhcm5waXFt?=
 =?utf-8?B?a2o1QUJ5NCtRMk51NEx6MFNNS2RiZS9QemJFOExzYmJ5YXBPN1JZQmNRcEY2?=
 =?utf-8?B?T0tpRkhJWktSVXpSRFNtY2ZwcEJ4UEtKQkgrTll4bXlLRjNIeXV5QW5LeVNL?=
 =?utf-8?B?TTVhY2c0MGgyVkkrZXRucUN1MHpvdnZrZUtyVkRNSmRoQXNvcTJTbE5NTHpy?=
 =?utf-8?B?SEpDMHM3SUdsaEJ2Uk9qNlFlZnhsWEVWSUJGMHEraEoxSnQxUTlycnFpdFA5?=
 =?utf-8?B?VHlUYlhtdnJPeWpKQTdBVUdZdytiZGcrNzBrUE5rKzFXVmdVb3RDck56eFRU?=
 =?utf-8?B?VzcyWjJuYXgwNXduYWFYN2JIMEZWQ0FRQVVPek1wVitVcHZyZU1makp1R1Zv?=
 =?utf-8?B?RGh4NjBiRzM3blpxUXBvZVNJTW9ISHVyNkJhUEdFVUdWSnVoYXora3RkelVU?=
 =?utf-8?B?YkhiVUIxL2h3ZkNTWUR3c1A0Z1RZTkhHQ25DTTYwTWVJd3kyTXpaQjdoT3RU?=
 =?utf-8?B?V21BREplRUNvSG5kTmg1aXR3MFl1WFU3VzVFckcvcDdqVFFMWnRzeWtBRENs?=
 =?utf-8?B?THdkd1hYdmVKNStVd0t6dDNkcTdKTUFrOEpXS29CRG5ESVZ4N3V2aHhUSGdh?=
 =?utf-8?B?dkhVUDR2dFN5ZHBaU0k4NzhPZktQUzdMVkM5T0N3ZG42QWtQN2pXUExLWlJo?=
 =?utf-8?B?NnJGTDZ0ZTdvbGI5dTM3SXE1eEhES21MMEMySjlCZGxvRC9jZ2N4T1Rwb0NQ?=
 =?utf-8?B?ZVpPVDlqSDlJV1NGWUtyVUVpOUpxQ1drL1BxNzlBVFNOSXJhQ2dFWjZlcnh6?=
 =?utf-8?B?TzhBbE1ldFl4aS9WS251RFNZNUxJM0FHK3o3UEVOUDk2TU9SRFF1d2Q1Yjd1?=
 =?utf-8?B?WjFaNUhkWGJLdmVqYnZzUTFkWlJkSkR0eXQzWVExRXBGekNycXpLZVRNTTUy?=
 =?utf-8?B?T2Y3SFlxNzVHV1k0NzBOU2EvSmdpM3ZNWVZDQmlqVlUrVi80NVpnVW9ZQi93?=
 =?utf-8?B?d1V0NUFOczNVRTdobDFQN0ZIN2JvSGIrQnpJck13cEcvWkVlSHB4ZVRlNnlh?=
 =?utf-8?B?WTJ0bVFLenFKeXhzZnM5M1R6QUVvOGdOV2FqeHZCYlJFbVE4TlNyNDJtclUy?=
 =?utf-8?B?UUtGT08zcVcrN2w4RktESFlySERCOGJDaVI1K2FlbDE3Y1F4Ri9JMCs3eGVu?=
 =?utf-8?B?Sm9vMmxRR2NCZCtnSWQ0Rmg2dFpWcDVzVG9abUJ0bWEvNjlhQ2xKcm9CT1ZJ?=
 =?utf-8?B?T1NJdEpBcXRvSWVBV0tjRzROWHFVSDBsbnRrVk9vSTVnVW5UakpFb0RPZjJM?=
 =?utf-8?B?S0RDaU92TmJBMWNjak0rdHJOSU1xUS9XOTg4M1NMVG1aRW0xczZaaVZwWFJS?=
 =?utf-8?B?Nys0WWE2VVZQL2Iwc1lTQmptNkxEaks4ZVR3YVhHK043QjFpdkpQelBYbUhz?=
 =?utf-8?B?V2ZmblYya0lqcHhwc2QwY3FDTW1ObllnTlVjMTBQckRSQVZPeXlwVHZHM0Z5?=
 =?utf-8?B?QjRiR0o1Q1BkZzN4NlNway9keHZRQktVRExRVGNnWTFNQVd3SW1RSWRvM0pS?=
 =?utf-8?B?NHRma0gxRWVBRDUwbDR2dDNCMXB4STVGYTBadlRsdTBMRTl2N3RTZUhvc1hG?=
 =?utf-8?B?ZDN2NS9LTVU5ZVE5QnEzckg5OURPOGIxTW01VmZuR0ZQYnJNcHJBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8147614f-7148-403d-1ba8-08de4d1a09db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:52:16.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YceiYj3TIyRhxyHjo7xOzSxhk+Zle+TTIqliMrdO+gXkhIGjkgID1XG2B+vsLCpbdn0nunTb0M46IjmSizQm6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:52:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21357

On 06.01.26 12:43, Gourav Singh wrote:
> systemd (>= 256-2) split cryptsetup tools into a separate systemd-cryptsetup
> package which is only Recommends. On minimal Debian Trixie images this
> causes LUKS devices to be unlocked in kernel space but not exposed in
> userspace (/dev/mapper).
> Ref: https://salsa.debian.org/systemd-team/systemd/-/commit/65e0731d3a0360fe9816a24be459fc2d2b8becb3
> 
> Installing systemd-cryptsetup will restore expected LUKS behavior.
> 
> Related to issue: https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/8
> 
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 8a8c695..1d62273 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -34,6 +34,8 @@ IMAGE_PREINSTALL += " \
>  	login \
>  	util-linux \
>  "
> +# Ensure LUKS devices are exposed in userspace on Debian Trixie (systemd 256 split)
> +IMAGE_PREINSTALL:append:trixie = " systemd-cryptsetup"
> 

Better invert this (remove from older releases - when needed), or we
will pile up additions when looking ahead (forky+).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

