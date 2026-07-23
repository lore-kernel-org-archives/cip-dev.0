Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98288C531C7
	for <webhook@archiver.kernel.org>; Thu, 23 Jul 2026 10:47:28 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20763.1784803638195073937
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jul 2026 03:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qaAHf/vm;
 spf=pass (domain: siemens.com, ip: 52.101.69.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNmwjcoc6ngArmOAWgDTWpAlIJgqE4nrQp0TFW+WChlMeNIRim81UNLH0TJ+aC3LJGhdAUoXtjILOuCwbVQidjVizBVJ1VESDWZVXnHjP7Muh+XwvcAIg6pp/S7NjbAWbc07r4Rs57cxCIvtzMmu3fHsNZOz1ZGot+HqxiBf7EuEE37i6tp04G0EnWE7/vnG1PLs6cWjGDiqwA65LpElHOxgQSzSdkn2jRBnwFoOVWMtXyCHDp+Y3mxRflWU54hjr1+Hz/1H2uRrT8qbsazVLjlMFDt/BhWL5Gk9Vet3qnGfoA21YWZ/rcTbNmoxUgISW3exNQ/Ad9nD2xaRBVhzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te7byivB71fcIA8baodQK9LHKg5Nby2MRMyj4BtAng0=;
 b=YQb2AJjOqcgM1UT8gv0SwVnby5Nee0CXu5m1N7x1LzYlUZiBLnRq+o73SwWaaNkM2YnngveD6K/ufKgeiPwZBL01U8TCDORBCylkdHOqVMMPE+r69x7CrzGx/353rCx8o+i+wdMka/Gf7lNlmFRa2RDRv0lqte7pzeHEhhtwPbYwJgESdJ+7Alo8FbTVuhX9g2kfbU1H8g7t+SwRe64vVWrACKB1nVrXjyJGSr6QSwYdD07e8HWt/lic4SwHAK2DYfnquaXIptEh6kT62SzhBPBsCSP5IYJ9IHx73/hyokYAQhoop4OGVgZhC3rqPG1niwfa68B27WkmkBGJLI2aVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te7byivB71fcIA8baodQK9LHKg5Nby2MRMyj4BtAng0=;
 b=qaAHf/vmfAYIh9TsetzDIHF9H2T/FPpJfpNVrpKYYTwttmzN+9QaVQz6Khd2gcjGhBANQK5Ky1ZTGcheyZbryAyilQLb3iaoKwphdVJ0dE3MGWiUKZouVSxQW9PHw6jzLE29jDl/Q4iZG9aI7fqSfthksm8MByzHiFXp3w7xksDcOLwBxQRjrllLfSfKBkndVzsJYtxJZuuK1BLV6M7riFN1Un8aqUpgES2ysIUKSAyzlJd2dFCly6kT/KdKw2/3aPrNTaI6QjwLSipjFeiigHVfWnBmmxuKW/Yv/GHlrM5fSp56eGtRraeOKCM1G1SkvTd/dfpCoK5Sd7zT3diLtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:47:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:47:12 +0000
Message-ID: <204ef998-8773-4e6b-b843-43ca4269ca3d@siemens.com>
Date: Thu, 23 Jul 2026 12:47:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/3] Enable swupdate support for debian
 sid
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: kazuhiro.hayashi.f74@mail.toshiba, kumar.dinesh.h95@mail.toshiba
References: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260722145755.641375-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6936f986-e7c2-4264-e5b2-08dee8a7c07a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	y+NFlUQZWHk7trH5w8ILLQg5zXXiAHvpmIBZ9sg9sCNzehvmf6ybomWI5CCGqDabcQvVNMr+pOH03+iWA7AH0C4IHwz7NacRvarVgH9fP56FENpeLKTgBxlo2oHkRnxSQup/SPjkeFAcP7eW/eUYA/P1U0xbGGEM+qe1ggIWk6zWOr1aIi17LbrWWySDUKhbys6WMGF0t172Xxkdh66U7vSosYNYCG1Dbyp/jiE8YUfyBqAtDsknk3X5cT3AwmHL2hureRJNu1p204GHPivpecVRToXe1OQZGueusTbGP8LgVtqBjJfhQPD8nyvuwP9IlB+y0s4oMCUqwqUmFH/pkOs5M7PsFB4cCqzj1OrhScXpiG9zzzNsUQ2cUqObxvq0ivlE2dm7iJgRwDYH/zLbxj0AXQsBXXeMw/RAmMg62DuCedz5AgQhbMQMZ9Ce6BP+JbfQ4v3rY9WlYv4Bsq57UU1YphQdSJaRxB1Z9gRKyXa4mQXeMWg3dwoX51r80w/dQRIpCK5G6NRqG6gK9W8OeAYMAP0GcALQTo+beYfr+HmI/NrEWlrcSILnZnDS2nY2WMZ/a2g+wLApvJFxZXB2XzGT5DJX1lwXvJozMXOHnrb40WIXoZCatITSbt4WeE9Melj4CiUshC4bzZtuELCJcoeZQHwnZ+35V+RtfqJ0lZU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WSs2L2JhWUpwcHBJM2pNNFl5MjhnMXNKai9ndUFRZTdGeDAzZWFSTk5vbEkx?=
 =?utf-8?B?RTFBR0VqbDZYMGNIT25xWVgxY2NUaTJDOUdMcnhoM2tpK0NWdWFqcStZYnA0?=
 =?utf-8?B?U24rTUZRUGZWLzV0YVc1MDFHNmE0dlp1K1JKNStITWxTZjFyc1VyanVkSjY1?=
 =?utf-8?B?SVNDdWs5TkZCN3Z4RXlQOWExM3JrbkEwZEVzSWZTNHJvYjEraGtjYW1yaXV2?=
 =?utf-8?B?S1VpZDNFS1V3d3NHMmVtYU5XT0trTFB4SnBkZWtMV2hJV0VOQUZmYUZBK052?=
 =?utf-8?B?bXY5S21TbmRVWGZaS2R6MW8rMTZrNXN6STNEZGl2c0dMbHJ4bDdyalZJSXlS?=
 =?utf-8?B?YjhsaWpKdk9yUkpla3FCUGFvbkJyay80TWtNRFdKSFpzUXdIM2pJU3BNVTdm?=
 =?utf-8?B?RUsvQjlYSXZCRUpTQko5U2VTZmZhcWZvK3FrRGdGTHB4UGRnUDBvNmhhV0Nj?=
 =?utf-8?B?WHFwaXZIaHBjSlpGYjIzbEQvVmdiNGZJQ1VONHRXOVEzTlRWdk5kaktuYzgr?=
 =?utf-8?B?bGw5VW5PTkVvMTFmcngvSktRZ3IvOEd0YWFmMm1ON2E3VTFrKzIySUVUaUZh?=
 =?utf-8?B?UVJhSEdHZFgrRVdQeE1WNTdma0w2Y210SE1LS2FTN1hIam1BTndCcWZ6dnNr?=
 =?utf-8?B?dXNhRThFcDB5a2lFcVAzM2xUTVE0dURUejdtR3dVbnZtQW4rWWVmWDF3eU5W?=
 =?utf-8?B?M05mODZSZloreHZONTJTZE4vQmxjVzBKTFpMaUFSWGwxdWF1UTZqMUthVEJJ?=
 =?utf-8?B?NUtuRWJvWlJ6R3AraE1iQkw2SjdBUU5yc2F4UDUzMFgxbzBqaFcwb3p3Zm84?=
 =?utf-8?B?N0VtOWJCRy84clpGU3lpV0JSVWZiaVdsRGsyRm9EU0VzWGl0NVhvelpKVXl0?=
 =?utf-8?B?UEZJUk9zYll1YTI2TFBHY0JhTUh3bVEzUFhsajBqTW9TUEhiL3JJcDVZUVpG?=
 =?utf-8?B?eTU2UjE0QVJaVTY2aFk0dDV0ZmdtMkJDbjd3ejBVQ3dXNnkyQXVhQjRENGRK?=
 =?utf-8?B?WUl4eXByeERHZG9jekFzTkFkMzVpWGVPUGtwVHM5RUdkYlFkUytycVFTQno2?=
 =?utf-8?B?dEdpdUtDeC9yTXRKZWdiZEdBME4wb1J4TVN4QXQxVXBUR3BlQ3FPSnBUSTFN?=
 =?utf-8?B?S1lqSFpYV2c4SnNZdk1aV0ZMeHRhVVllZUhFR29wWk9CMkR4b2FWWndJU0FF?=
 =?utf-8?B?VVZiUTlqUWNyMHQ4T0NMWUwyTytQNUp2SkR5N3UwaisycmEvNWZzUk9pM3lm?=
 =?utf-8?B?SGtTVGlmQzZaVVpCWlBweVJZTHFhbmlrZkc4T0tEZlNGTnE2RGFMZjZpK0ky?=
 =?utf-8?B?dW1SMy9JV2VGcGVwRi9pQndlV0NEbElaNzJtOEcyQ0RXbDA0cmhsQUNYN2NH?=
 =?utf-8?B?V1MwYzRQMWo4Ti9id0gzS3lPeXhPajFJUHdNVjRIdUxuaHhNMmlVdzdOSHBK?=
 =?utf-8?B?WWJVQWlCM2ZXbE96bnI1ZUtzUVlNcmVzYmlEWjliOEQydVVpRFpnZ1pGdUc5?=
 =?utf-8?B?YUYvSHk3UUpJVGVxSzNpTHFaam9JMHp2bmVubEF0c2tqN2NkaDBFYlRDTGRu?=
 =?utf-8?B?LzV1N0ltRUFWZTgxM1JKc2ZFYWM5YWU4eVhKRGRoMCtzbTlTNVRZUUV5RXZa?=
 =?utf-8?B?Q1daaEt6NlpncXZpZ1RqVXM5VG9xblVCdmJFVGppa2UyQmZkbWpoZjFxeDBa?=
 =?utf-8?B?cFZCa0h3SmpTTllvOXFWOExZNzVVSDY2Z0JxZEU1TlExTHhLUnNKUzdYRnVu?=
 =?utf-8?B?SlZKalVacFBJekdkb1dKNFJDWG9jbURtZDhKaDNDVURXZ2JuNWNiK2VIOEUr?=
 =?utf-8?B?OVAvMlR1Um9ITkg5Nmh4SEx0Ymo1dVNmNkhaRWJ3aDlrMWh2SUl0L3VMS0hM?=
 =?utf-8?B?Q01GRk9DUExsQXZqVU9GcXVMUHR6RG9wU3l0Z1ROMUtUNXc5dXFOMHBHNTlo?=
 =?utf-8?B?YVRjNmZiNTFRczM3K0lsUkNrNy8xdkRyQjFBSHhxdzgyTEFIN0dNNGZBUmRY?=
 =?utf-8?B?YnVsdDdKUk5uZE01R09meHNMRVBHVmY0NnhQb29hNGY1Njc3Q2ttZ0xTbGl4?=
 =?utf-8?B?cjIzM3k3eTBPZkFjQzEzUTZ0TTlmS2d6YVV0WThQNWdtZFFreHo1ZmQ0UDZO?=
 =?utf-8?B?SGg2Yk9acDlOVkRtL0hhNnR6Sko0UnNCR1lWWE5uNm9KRVVFV3N4VldLM05q?=
 =?utf-8?B?ak5SWEF4L1VYRERpeW5Hd3d3QktDSEhNUjlZQW9KaSt4UUhyMkl6RHQ3dDN5?=
 =?utf-8?B?dVhXZCtoNUljKzdZbmxNZnQ4S3lzdUF0TGR3OU10ZTVmdkJnc2ZDSjFmT0JU?=
 =?utf-8?B?U2thVGJVT2x1MWhIcXYreWttMDZaTlBlL2ZqZ0FpbVo1U0I0QkxSdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6936f986-e7c2-4264-e5b2-08dee8a7c07a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:47:12.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nG4V59GQLXvofRLX27ZCKlQeZUkh4xDQ4M3pUIerpOLOn4os4FpPy5y6fUJjBGCUXJgMBlH6dP8yC5RiSoTH/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jul 2026 10:47:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23726

On 22.07.26 16:57, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> This patch series enables the swupdate support for debian sid. 
> 
> Shivanand Kunijadar (3):
>   swupdate-handler-roundrobin: Keep default lua version as 5.5
>   swupdate-handler-roundrobin: Remove adding additional lua version
>     paths
>   swupdate.cfg.tmpl: Add digest-provider option for signature
>     verification
> 
>  .../files/{swupdate.cfg => swupdate.cfg.tmpl}        |  3 ++-
>  recipes-core/swupdate-config/swupdate-config_0.2.bb  | 12 +++++++++---
>  .../swupdate-handler-roundrobin_0.1.bb               | 12 +++++-------
>  3 files changed, 16 insertions(+), 11 deletions(-)
>  rename recipes-core/swupdate-config/files/{swupdate.cfg => swupdate.cfg.tmpl} (72%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

