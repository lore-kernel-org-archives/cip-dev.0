Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5AEC83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 11:17:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.web11.18702.1752837448960723841
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 04:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mVZrrZ4Q;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ry/NS6MwgUkgBsXffi9pOl7ysDxZgoUGXb1jnHhZXl2GZBje4+5mvJt0VD1hGP1o1KUFUxUvIR9lJ6p/Gb1sWELrD6ZaNsHA1wvc8wG97Gx0T1niTTOGt3PqnX+VccfLBLI1iXcr2DjQPSVdJ3PnciIWg0/XMz6JLw9PuS/AsqlohViZrtL/dQ0Q+1qENjymBmf8+AqTV+jiz6zQS4WrU0JB+iV7RLFGszPIgTmg9wP8x5Yoj0EqR3FLKTPF6e3j+ai0Dz/jHjHaA/k2rS9cyj4AjhjYF8bB+2CwGytgimVcTnp5T8+8NWTOY9N8JoghGqzqxr9lewhH/BRhTiIH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cru4p5kqZcabltbU1vZqAFk2Heh+KKeZ7nIsUH0/PtY=;
 b=Oh7szJT+jF0zZ31x0CgCAXTVuheWpnNM4vHRJ+xHm2CQmZ6nQIAJuumGIHq5dd4G9Z/0cWhantyJEhJ/NoKiPFMPQTWYlHjjWG7ka3kNHeFHuFCrOIhmVZZa9jOJeTfq9LDmOa42Q72i22Ue087ZpRqhO2O8z8kW8KENe6a5juKbNctwAI9XvsjeYYi2P0ZGYbQPBxEMSloPE8qMhwqrNc590Dmry7IIEUwUgUlwQTsjVxsGnFOHPZoVFYGXqJ9sl7MOqLS715uUGY3L/YAbwPihof/W6uRCkurbWfPwtzgRkXZNAZHv2eB6vomzwP3MsNWg5XLYnk+VXHwQh9sriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cru4p5kqZcabltbU1vZqAFk2Heh+KKeZ7nIsUH0/PtY=;
 b=mVZrrZ4QyfPy9W0uoub+k7gUp8w5unGw8OspUHzKfDY6qU7q7dI3qsrSJuuyhl4MTzmeV3pORAKcHk5cgdCpdFWdL4RQ+TgonA68CmFhW9tpGaDrEoUVDoNVWmjbJqKTzuzEHSnS6NWPYgVDdXrXgnIbQeadLcEA87m/rN8O3xHgOBqFz1U+ULae/kMEm3DCqWich4UKEyU+F/pywYtahJdCIrqWVav0+SN8pt0CA6H+E/CDhx6t/Ej1AN368irKt6UqfW1uS+50Z2APwnJCOpnFCivRtDb0thB0gJNoRzzYIVn4CAfoRnVcjC5Sx48OIoFuS1lSLQfHVtzEhl/M0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:17:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 11:17:24 +0000
Message-ID: <816a6e9c-9d3b-4cfa-a2f4-6cd685cde9df@siemens.com>
Date: Fri, 18 Jul 2025 13:17:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 2/2] immutable-rootfs: disable daily
 package update checks
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com, quirin.gylstorff@siemens.com
References: <20250718101525.1270424-1-felix.moessbauer@siemens.com>
 <20250718101525.1270424-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250718101525.1270424-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac0cb1a-0eea-41ac-2a90-08ddc5ecabd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?anByb0xhTWU5aUF2aHZuTTljcE9STXV3Z2NvSzk4QURGQWNNN1grNGJ2WmtP?=
 =?utf-8?B?elFibVh1M0hMREZiQ1NXUjVYbjI3cnlOWTZOMHRUVG9lWnQ2Y012K3ZoTlk1?=
 =?utf-8?B?bm9rVGNFeTMzNHZ0QWF1WXcvSVhzc1JzUy8xQm5zNm1LK043MGlEWVpxRW1u?=
 =?utf-8?B?ZFNjZWt3anhUOVRlTE53RXJBVldQck02UTEyemVhZENhMVZ3T1lsblhPYmox?=
 =?utf-8?B?ZGRCY3VEaTVacC9oMFlaWUhvWE00bnIzdmtUYStkLzhjRjdIR3V4Zk1PNzZF?=
 =?utf-8?B?ZFdHK2Y0TmxLK3V0SHpWbE1wUXVJT1pDNTAzZ2lWUWw5ajd6RkRkbEY4VGxu?=
 =?utf-8?B?UG9uUWl4R0xkUTR0QXNsODFLZXNEcENnZHk3NHJhUzhOdlVHb29xV2FHMDJj?=
 =?utf-8?B?VVo2M0tITHJkSHlZcHlFdVBjbVY0SGFONmd5byt0SXBYRTlMMW9ZQllTRzQ2?=
 =?utf-8?B?blBJUmpMMEk5Z1RsOFhMS0llaURHVFlDTUhuOWhvRjRaNGxWdjF5S2lHcWFy?=
 =?utf-8?B?QURqMXU1cWNwcWZZR1loZ2JZSE13MGxNS1dtQVRvV1BVbnJFQVlpM01kcVJL?=
 =?utf-8?B?N0x3SVU3NU50R1VBZW1pdXVJOTFXc0ovQ2pLaDE1WGE2UzR4c0draTBUWFRB?=
 =?utf-8?B?ZkNwUEhqUzB1bVMxUU15ZmdHN09iTFRMTjF2MUxrTDR4dlNRZlQxSVJ4Sk5V?=
 =?utf-8?B?QU5hRnJHanNDWUd3WU15UmlqTTlqYnNWZjRkbFdTbzM3VmRvNVBHYlV3VStq?=
 =?utf-8?B?c0VXajFsKzZNc3NRT1lmcTRjTFdyeDdQUGtLVFgxUkl4Z1I0U05aa1lLbENB?=
 =?utf-8?B?YWNXcTVhbFMyM0pzMnBCNUVpajNsdlY1SDJDMjN2cnM0UWllMEVPRHlveHps?=
 =?utf-8?B?QlNTVDdNc3Z0Unkvc3pBMERDS0hjL2lObkU0bHdjVVIzSWltTG9FV2d5STgr?=
 =?utf-8?B?ZjdoSkN1aS9jRFA1RUxiSm84Y0dJU1NWbFlnMUFqRzR3NEJMWGsyZHhVenE1?=
 =?utf-8?B?NmFOQUU5T2NVanpvSEd1VUd2SFpOQTZCV1BBQmVpOVNLb0gzc0FRUUdQY1BQ?=
 =?utf-8?B?UldaVFlaaGpKeGNhRlpGOE52V0dqQTRPVUtPNlhWSnAzTTByemxJMTg3Y0t2?=
 =?utf-8?B?WEw3RFZuZVR5WGRVQWlNSjMvaGFkNlYzbHh6QzBxK3dueldkR2RlVXN2T3FZ?=
 =?utf-8?B?YjdDRU5hcEtPRHoxTVdIMjVwNyt4ZWZobmZ1UjRkcFk2ZWJMbDNQaldDQldn?=
 =?utf-8?B?dGtjQnl2TmhWNit6WUdQQ2lBNkk4ci9MYjdDUWVvaDJ1U0xHNVdxQVpzZStM?=
 =?utf-8?B?Vm1nejk2RDFnRk5KUExmSHpjWXo1YytPUFVybXRQaGo3WldkUVVuOTV4a1dZ?=
 =?utf-8?B?Uk93RHpicFV0RWJlVVI4OUszelBMcnNUdWJiM1BuZjdPS2hmNjNvdVFxcjRH?=
 =?utf-8?B?ZC9IWG5sOHorOHBNU2trZzBGYVV4YU92WVNETy9mNEkvQnFxSjdET0VFcCs5?=
 =?utf-8?B?NmN3Q29teHFQeXNjVjFMRjZCZDBDd0ZIVEowMXZGbVVlendPOUZ1a3dCaldw?=
 =?utf-8?B?MU5ZKzhUYmpsTXJ4SnJZc05lQXg3UWNCaFp2cnpnRFg1Ui82WlB4ZU5GeEM2?=
 =?utf-8?B?K29UNm1URlBCR2xYdGEvYmFma2lUa2dnTlVteHNTOXREMXZYbXFYQUZRMXNi?=
 =?utf-8?B?UGI4d0pQUGFLV0grSUlLcDBVMUt4QlAvWDdqc2lCbmJlZWVWWDkyajdPb2tB?=
 =?utf-8?B?L3I4QjVIMGwvdjd1WldjODc4bitpdEhLeDduellTanJtaStBeldQenltZmxR?=
 =?utf-8?B?aXhDaUNaYWJzaDR1dUhIQkNBTzVlUHp6cllFeTAwYmF5SVRpSkV5Rms2clE1?=
 =?utf-8?B?eE5uWUx3b29vZ1JkaUFOVk9wSlVUSnlXZER2OGt6K3J0anRqMGorbG4xYkZK?=
 =?utf-8?Q?ryKDNG2pFzQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjQ5Rk9icDN2WjB6SDIrSGF6ZW1Bbms2dUNCQnJyWXpBTlU1UFBENDJCZjl4?=
 =?utf-8?B?TWdFdXNBazROMTUxSzNENUZScXRwTS9QWFhCMFYyM2wwTFd1MDN1Vm1wWEhG?=
 =?utf-8?B?RkpPVnZTQlluMjUzbittRm9MUzZadG9mWVVuQ0J4NFdlOUpkUS9tN3pZby9H?=
 =?utf-8?B?UnRsT2pKMjlKdzQyTHpVSHdzbUlqTDMxNEVTRm5vbEZaSWpUY3hjd3BXeHdM?=
 =?utf-8?B?YUVvb1NwM0xnQkc3QzZlY3k4RmpPWHZqS3FlWTNnVFZHSHJXT2pDL1k4bUly?=
 =?utf-8?B?eFQ0SG9CY2tSOCtPV2E5WkYzWUtxc1ppYUI1M2I4QkRqUllJb25yemtyM01z?=
 =?utf-8?B?V0wzVnJrWUc1WFduWWU1S3VDK3NZN0EzbWRuaTBnbmRyN0E3TXdTcUtjaGsy?=
 =?utf-8?B?YXVOTTAvQnpRNjhVNCt2K0JIcFNDZ1BEdFlrNTdIUmlsVmlFWHVHQWFTVUdx?=
 =?utf-8?B?a2xTeEVhYVdReVR3cXV5R2VLNGFlejYwRkxMRERSNWE0anRUbEJCU3orNmdN?=
 =?utf-8?B?RkpNbHgzaUc4NkhKcGRqWldlVzFRR1BJNEZNODFTalZyalByOWU5ZDYwMFNH?=
 =?utf-8?B?Wkp3T2hhSGpMTTlXSDU5UHFBVDZHcXdZWENwZ2FlWDgrTDFZdnh2US9aVWNS?=
 =?utf-8?B?ZStQV0E5ckdiYVVhN1BSSHN4Mzl0UDJCT1A1alkzQnNSRUNiVUJjS2hWeHdh?=
 =?utf-8?B?TUtVRjFFbU83dk1JWkRXZkRURWRBd0xrUk1HNTZQaG5aNzEveDgwZjNhUEtp?=
 =?utf-8?B?N21GMWxwOEtERWM5U25BZ1JFZk5MYkNHelJUemJ6SnRQeFhla0gvajNjaVM3?=
 =?utf-8?B?eTgwVmoxTnZDMm5Ga2tkYW1nQm84YWxxTVNhM1VUQ2xQYkpBRFp3aUVyUjJD?=
 =?utf-8?B?cmtobW9FeldtM29tVytBamFWQ2tUQ2Z6U3lRc0NVc3RZR1JTa0U3QXhyLzFV?=
 =?utf-8?B?NCtMMTJoaEQrZmxReEtOQUcwdkpTczVuQWhkTmV0MnVPVmFkZUEvWFVjSnVO?=
 =?utf-8?B?OVYycU9jY1RtOEI4SGFHZ0F1emJobmllQjFqQnY5RzBrcDl0SENQRmdzUmY4?=
 =?utf-8?B?WG00UllPRDdwOFJ5OEU5bEtoL2pPRlVQUVBxZC9iYm1VMGlQYkkzb2t6SmR0?=
 =?utf-8?B?RnFsVDlwcld3QTVXNHdnUDFVbXpFS0lXWTJyeWFoMmFWejZKOG1lQnpsK3hZ?=
 =?utf-8?B?VytYdVFzQ2pFWTI4M2E3ZjIrdldERmMrc0xCSHNlb1FKd1dnOTdlS2RnRlE4?=
 =?utf-8?B?cTgwVDF0aGNvNkRSczdNSmdibnpmbjVBTmZ5Uy9PdUJFVVVDWnRPUFlNTk9y?=
 =?utf-8?B?Z2ZnSmdtQklnMmdmNFEzcVd5SUJmQ1dtRGl5MVd0NXE2RDRBTkNIWFg2Y3Zr?=
 =?utf-8?B?RnRmY25xTjhqSDVZaUhpWTB4T3FyTDMwZTNIVFpkOFRwZ2F6Ri9rOGg2em92?=
 =?utf-8?B?QzFxaWhlNzhoNXBaQXc0MFVtT29ZSnczR2U4dUo5dUFUYzRpcG1NdEtBSXFa?=
 =?utf-8?B?ZGFEWTFYbnc1NHF4MmE0R2k2WXliREQzTkR6dkgzQlJyVGFyeVNobnpLVzlr?=
 =?utf-8?B?YjNHTlp4RDFMMkZscGxLMExjWG5rbHdIRDRlUHZ1Ky9yQWNlZWFHMU9EeFlw?=
 =?utf-8?B?QWR4cFNnRSt4TEM2bldCVm9sUnFaaXhnbHZUNGptRVh2dG9LK3BKU2QyazJn?=
 =?utf-8?B?QUpQT0N1ZEpjL2VmTU41VnloK0J1VFdsUFRUUjJFWFVCUmhkZkhnaFoyenl0?=
 =?utf-8?B?VEpROW1MZkF0SjlDT0xnTy9xbUx2eVVLMGF5UHMzTXpJYXVBR3Q1U3NjMlkz?=
 =?utf-8?B?NU81S0EwekVhNmhtNmhLM2ZnL1VmS1ZndkQzY2huTGhxaS8xMWJuSUVNVjl1?=
 =?utf-8?B?WjRLUUJhUzdJWGVYMXpFRWhyWDhFeWhTMVlqeFhuUGw3VDFMSnJ6UjlJeXZS?=
 =?utf-8?B?K3NKbjlENVlaYlVKdjIwQmVFTWx6Um90TUY4QTZxOUZjSjhLYWRWbU9BMjYw?=
 =?utf-8?B?eXBpendGSFVhOVdnVHVQQmFOWXc1d0pOSDllWmRxenhubHU2RkQ2ZVRheEov?=
 =?utf-8?B?d0p1UUJVamYweHBYSU9lVGdWZ1RpbGNPajBSaXhqNTRudUduSU1kZEhacFd2?=
 =?utf-8?B?N01LdHgyTldCYUF3YWRoQTdoNm1UdjFSUWtOQTJMT3lCQlorOXRGSlQyOTEy?=
 =?utf-8?B?Ny9OQm14SDMzc3Fpd1NvY3RHZ3pjOC9SVHoyRW5GWFdmeGIwS1ZVMzgreUVS?=
 =?utf-8?B?V055TkdyMkI5VkZkSEE4UmYvaGhRPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac0cb1a-0eea-41ac-2a90-08ddc5ecabd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:17:24.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LtkqYU9MuuqRAg/3IjyMTpB5FMiEccaaRBT4w7DIyTxetj44hJ2Dz6XiieWSkn2+5rUz0Ja11hej5QDyQenhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5979
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 11:17:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19566

On 18.07.25 12:15, Felix Moessbauer wrote:
> When running on an immutable rootfs, we don't allow package updates.
> Nonetheless, apt tries to update the daily package list and upgrade some
> packages. This is triggered by systemd timers, which are both manually
> registered in /etc, as well as deployed via systemd vendor presets.
> While it anyways makes no sense to run the update, it also might fail
> for various reasons, rendering the system "degraded" after some time.
> 
> We disable the timers and also disable the dpkg database backup, as the
> database itself is also immutable.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> PS: It is very unlikely, that we catch this kind of errors in our tests,
> as they only show up after running the system for some time. We further
> don't reliably know severe the impact on production systems is, as still
> many don't rely on the overall systemd state (e.g. to bless an update).
> 
> Firmware updates: This patch will also cleanup the timers on deployments
> with an /etc overlay because:
> 
> - the timers previously got installed by debian - hence are part of the
>   immutable rootfs (the lowerdir of /etc)
> - the systemd presets did not install the timers because they were
>   already installed - hence the files are not created in the upperdir.
> 
> Best regards,
> Felix
> 
>  .../files/95-disable-package-updates.preset          |  3 +++
>  recipes-core/immutable-rootfs/files/postinst         | 12 ++++++++++++
>  .../immutable-rootfs/immutable-rootfs_0.2.bb         | 11 ++++++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>  create mode 100644 recipes-core/immutable-rootfs/files/postinst
> 
> diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
> new file mode 100644
> index 0000000..7e6e9ef
> --- /dev/null
> +++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
> @@ -0,0 +1,3 @@
> +disable apt-daily.timer
> +disable apt-daily-upgrade.timer
> +disable dpkg-db-backup.timer
> diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
> new file mode 100644
> index 0000000..a6e1962
> --- /dev/null
> +++ b/recipes-core/immutable-rootfs/files/postinst
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +set -e
> +
> +# These services are installed by "apt" to ensure the system receives
> +# updates. As we don't allow updates on an immutable system, we need
> +# to disable them.
> +deb-systemd-helper disable apt-daily.timer
> +deb-systemd-helper disable apt-daily-upgrade.timer
> +deb-systemd-helper disable dpkg-db-backup.timer

What if someone downstream (and I hope eventually also in isar upstream)
has dropped dpkg and apt from the system? Then this will fail although
it should rather just be happily doing nothing.

> +
> +#DEBHELPER#
> diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
> index c847f44..85f6184 100644
> --- a/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb
> +++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.2.bb

Let's bump the recipe revision at this chance.

> @@ -15,7 +15,11 @@ inherit dpkg-raw
>  MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
>  DESCRIPTION = "Config to link volatile data to immutable copies"
>  
> -SRC_URI = "file://${BPN}.tmpfiles.tmpl"
> +SRC_URI = " \
> +    file://postinst \
> +    file://${BPN}.tmpfiles.tmpl \
> +    file://95-disable-package-updates.preset \
> +"
>  DPKG_ARCH = "all"
>  
>  IMMUTABLE_DATA_DIR ??= "/usr/share/immutable-data"
> @@ -25,3 +29,8 @@ TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
>  do_prepare_build:append() {
>      cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
>  }
> +
> +do_install() {
> +    install -v -d ${D}/usr/lib/systemd/system-preset
> +    install -v -m 755 ${WORKDIR}/95-disable-package-updates.preset ${D}/usr/lib/systemd/system-preset
> +}

Fine with this otherwise.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

