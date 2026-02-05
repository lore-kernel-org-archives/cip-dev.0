Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E3ECD98B
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 16:57:42 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25607.1770310656414119946
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 08:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FLacPmHp;
 spf=pass (domain: siemens.com, ip: 52.101.70.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb39PrQ26nCX+3RpntHQzySsquK+xLacr2U8YYUM2LJ8PeLhklzkI2LlO827qgbybRgmxjlGLA8B5TA5sX48j558RjV9VCq5cjnEQaOpseP3u29/WpVcUu37lCp3WTkvXbjb+BWUg9bblYbURHT6mN/Qm4loLPLB4E4x4OOgNK/ptpbV3Ww8397x6KQjeWj+dUnkxjvTccxnYg/i99kU4A5BT1w43E1Kvht5RbAYjy/U5TB1sOPc5Jy4FyYzqAzqAKTQiVdewqIUto+pRfbXVc6XHrEDk74AYrEZJKAVeWzwWrlc8J4iNCXHD/hsKkX3MnucMQKGjbm/VV6HgTd7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPu6H4XFphH3WqOuXdKr6MA6/zFcwY63dvFG4F4FOlI=;
 b=lV2Lp1WOghLci6PbrLzctXkkllg5s5p+PvsuhEEl3/HNbjD3gQJO1risVmczdljfPs6uqDwA4QhPgUtQNOU77gqNUB3Uvq6vALj7im/D6IVtvy7j0TEMDPlNTHr+KWBXaUwg568wNAp2PGSD5NvXDKvwWjwO6A8W9t3DBebJyUsaR11JKGlKlLCEZa6vHJONQODopR6eYSrbZO6IXQeLCa84UPHtfH2HaIMhqH7h1aZLtFDXp/SR5FLywfFng7tlraG+FYK0UF59232wbofR3X0uuIynYuWDdMG2y8uG05I/fuxj88yrcZ3KfoWwF+HXPUX9wRMOcjUWDkS2men0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPu6H4XFphH3WqOuXdKr6MA6/zFcwY63dvFG4F4FOlI=;
 b=FLacPmHpNXbAaNEVBKGPatCHHidrtMP6cluJdLotAZMYbkf3yz3VfWObJlFuhkMZZsLla0B3CdMxIKf2D/8GZea7eH9cnPARg3O0vzjOlcOEn7aQsqFbo1Dze3nWgHg+ijS88FH4qtP6L6SXkELWXeXqCj3iXwIz6cH4lYVTlA+F5SKD/fZ8NJa+qsj00mIssLxxpAiHz5V8DXz8dORG9NeLDJIR3CzaECGVwTSu4tY5RteMxF4a7NrtGYtkxdDvN2qiBXgrwmv+DQYP+z0rWkBH+8VFFsXkkRuCklxshvhfM/daVYsgMiB26qvbu8xvXl0vtSjS1LFaIqIF9nBoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by FRWPR10MB9419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 16:57:33 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 16:57:32 +0000
Message-ID: <944f83ee-b233-46d0-9e2d-f96af55cbecd@siemens.com>
Date: Thu, 5 Feb 2026 17:57:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for
 Debian Trixie
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|FRWPR10MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 667cacb6-5ee4-4564-04ea-08de64d7a77d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MXEwT0diaGZ4L3g4RHgrVUc4ZzV2ZHIvVyswRGsrM09YM05UV2d5ZWF6Y0ZE?=
 =?utf-8?B?UGwxekhuL0RqWEszbHBDMXlOeWhNUjBxdzRTMzg0dzUxSFIwM2RrVDg4MVNV?=
 =?utf-8?B?NDExLzhJeFVOU2pLZlF4MktIUUlNUWJ6emNESnZBYkQvWUZuWUdpY1NsbWtN?=
 =?utf-8?B?YmFDd3RWaVRtb1JoZ1gxZHBMY2tXQ1dVbzNjQ20zYnFkNFFtR3BuS0h5VUFQ?=
 =?utf-8?B?STlTZllQRkwyaWJPaWExd210clBneVR3aTNnLzlad3Y3LzlWYldUWm1RZytX?=
 =?utf-8?B?Yy9rMzU4ZGdvcGQ4ZXRINjhvZWR6Ty9YMEtJOTNSSTVqb2NhYW84aUMxQXdR?=
 =?utf-8?B?MURPa28yM0VMNzlVUWplUXg1S3RNc3JRVERaOEdjWXN0aWNOWkJpRnFKTVRM?=
 =?utf-8?B?bVQ3Sk5XRnR6ZDhFZGc0UEFER3NOQzZVbE9TUDdkRkYvZXlGaTVxbFlzWnJQ?=
 =?utf-8?B?SEN2eVVyT0Fnb2w1clJvVC92Wk5NZWdFSGtmNU9YdVZFTlBkUElSVnd6Z25E?=
 =?utf-8?B?ZjQ2a3cvZ0JxWmRwRWFVM1NMU0hWaU9xNXI0NWFOaStkOUZyRVlXSkNNV1pD?=
 =?utf-8?B?cjJGYTlBaVhOQ1ZhMVl1VXNiMjdITVRXTkYrOHRISDc3WlN3cXJaUjJJOGVr?=
 =?utf-8?B?RDZ2bzFqOWFYUTAwSDFFekhCclNsRXkvemJvOXBRR1REYk9xRVZVNS9kSEVZ?=
 =?utf-8?B?OGRscmN3bnVRTTNRRXYxVmRYSjQwR3VLd0FxV2ZibFZ6SjhzbldZNTF3Z1Uw?=
 =?utf-8?B?QWJVWFpHU2hFZ0UyY2dJTCtmdVhFNzB0QUJTeGxkZ1UrQTBGS1cvRWlCWWxh?=
 =?utf-8?B?MnZGcVlsYUh0aXA5c3JlQ0NVaU5UTVB1UWtwVjA4aFpTZkIzWklMRWZod1VI?=
 =?utf-8?B?WUY3aUZQc2VvcncrUVVUcGVrd00wcVdNbVpqVy9jOGw4OXMwYThsOE9DcmQ5?=
 =?utf-8?B?Vk92aWh1RkptVFFaU3A5QjhvQ21VL3hLeVNHWjkyeGdWUXcwcW0zZ3B2VG1G?=
 =?utf-8?B?S1VyWElVNCtrL1cxY0N4Z01XdTRTRU1yaDhIT3NRdFNyMUtDczlqSU9nU1J6?=
 =?utf-8?B?RUF0VFgyU0JObUhQb3lySVQ4UjBzUm5HUkdaSGdVM2pZMGhTbTRWQWpzNzlH?=
 =?utf-8?B?ckMvWGY1Vm05UTMzaGRPakNuanlUNFpLN1hDaGxBblpidXVaSEt5UU1vL3Ir?=
 =?utf-8?B?NnJvcENoSW9Md08xcXhuSTBJYkdROG5IWXVrTURENEk4OUZCZmxaT2tmU2w0?=
 =?utf-8?B?T2c2alFseGMxRVpDYzBzbGk0QXZNY1UrS2lDS001ZjhUZ2Z6cFhoWGhZdkpE?=
 =?utf-8?B?UFcrd3M4Q1VjQ1RVQ2preTNQVDBZTkRXN1h6dVViTmxtVGhSOEZJcTFSRklD?=
 =?utf-8?B?cHpQQzNDdGQ4OXlsVmRpWlpjZ3JaSGFqUVJ5dlhLaW92M1gxMndsODBnbjN1?=
 =?utf-8?B?a09lSkdrT2d4emxGWlBuTDdqRWxOUE5sdWtDZmcvREh2Q1hJWHIzRTIxU0xm?=
 =?utf-8?B?T1hvWEU1aW5PbGRqUnI3Z3NRdC9ua0VSMTBPcm5tWTBqZ1BJMWhwRDQ1UUUw?=
 =?utf-8?B?Ukc1Z1ROZ3NEZW1CV2dyRUNWV0tLelNJdEp0NTlCM2NtREVPLzlGcHBpTzYz?=
 =?utf-8?B?ejdTUy9mNVp6ODY3Z2RUY3Q1TlEyWDd6N3Vya0tUUEFwQ08xYmVCUzBMdnBM?=
 =?utf-8?B?M0dPbGFBK3NjdGNoTlo3VUtVdU9vb1JFR3hVZERUUmJVd2hwTEJpQktsQTBB?=
 =?utf-8?B?VjladXAvWi9OckRucjJPUVNnV0NDWGZRK1AxcjE1MGt4bUxtalNBSVZ5Z2tM?=
 =?utf-8?B?a1dwV3lXTDlFYUlyTHJjWUwrZnFSL0VZOWduYlpPbUxaYXRHbVE1RFdHM1F1?=
 =?utf-8?B?REFlc0VaZkZBZzZjcXVYV25ENkZwZ2JKeVkvV3pJV3hBdXdhNDRkcG02Vm96?=
 =?utf-8?B?VjFXVUVOalFpaTdpNTV3Qk1FMFRXMzQ3L1VpU2ZjRGRtblBHZlB6RmlSamsr?=
 =?utf-8?B?bXJxd0tpdkdBYWpkWktOdUptZk9XUlcrWGVkWVBxbUdGMnpjU2JWcHVhaEFq?=
 =?utf-8?B?VnZRbVB3c3Fiemh5SkV1OVQ0L2ZnaDNNMWpJa1dFeDVBSUFKS0lERmRLZDdu?=
 =?utf-8?Q?5r5k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?alFuRC9JUFJDWkM2Z04vT052L1MxWG9SK3ZpWUJ1SXU3VGVIWEp4NWhtTmFa?=
 =?utf-8?B?KytjYkRXamZNMFRPZWtNZ0JvK3hDZHk5WFBGVHpKRlRINDhyd0FCY0d5Y0tD?=
 =?utf-8?B?Mlh5Y2VhbVhkM29URE9KU1ozVGVDbWlIb2RhUlNNaCsweDZxdlpUdWYxaHBR?=
 =?utf-8?B?V3RiTm11ZER1dk1kcVNrZzRPMHZOczJ1Z3Y4YVRMWjZWY1o2b05WVnY1V05o?=
 =?utf-8?B?bGFyc2ZKNjZoMlhtMVZnd0hFSmQ4RnZUQU1RN0V2aFpQK09HZEQ1ZlNwMWJR?=
 =?utf-8?B?b1Ywbm16bWFFM2gzVDZuMUJGQkMvS0dnZko2ak56MS9nTFFWMVRyK25NYnJL?=
 =?utf-8?B?eGdJcDRIa1lhQk80MU9pWXowVU03QU51UGxGOW9OYWc3dnVFUUtPZFRZdUxq?=
 =?utf-8?B?VHdIVWc0RWtqN3Vob2pDeThMQzRYQ3BJU2l5eUsreEpUb3hSS3I3MU5iODZZ?=
 =?utf-8?B?alVaUzZxL3pnUEdVU01TcHhlYy9uN1l5S3VSUTdDTVZUWHVkRkdkdkNUcmcy?=
 =?utf-8?B?UTdYejBtSTJqOG9FMGJnaHAybUtTb3ZMOWpJcFBxWlU3NC9hMnZjekxWVXdr?=
 =?utf-8?B?Nmw2REE2VHNGV0Z5azBNVXZxRVVYK2p0d3NnZnFpWGd2YTJ0RmlVenZEYjdp?=
 =?utf-8?B?TE9hcWdNRytaRVk1L0hWYmF6SHo3VGkvMzZFRU81VG1QQ3k0N1g0WE43cGdU?=
 =?utf-8?B?NXhpVlpKelFtUmg0MVRRa09KdXNKR055YmtZY2xZYWw0V291MG83ZDIxQkVF?=
 =?utf-8?B?TXB0c05SaHhQeEMwRGxUUjM3Rmo1MUFXTjY3THVONXpRQUpxSXd4b1hVUXYr?=
 =?utf-8?B?MWlDN0h6dVcwTzQ4V3ppWjAzcFdDdEJEckw4QStkSmxHMnBMWENKWEJHYmIv?=
 =?utf-8?B?ZzZGc0FSaUp5Yzd4d0hNOTQwSU00MWFPYi82Umc2NWFHSjFwRnZNTkF2RXNw?=
 =?utf-8?B?d3dyN0I2eWYzczNxejhuUTJEN1Z6a25kcFpHV3FRa1FFN2NxT0dPTG1MWG9j?=
 =?utf-8?B?THR4QkVxemxEWHl0YUtlK2c4MURhYmVHZGh3NEltelc5ZCtKMWdXS0tjNGp0?=
 =?utf-8?B?Nm5zRzhsOTFsNW9VTzJsQmZDL2Y2SEplU1I5NUxuZWpPbW9PMjNXSlozcUQ2?=
 =?utf-8?B?SHhZVTRtZ2NKdFhoSmFJY3N1ZFE4aHFlUXB0bWN2UU10Q0UvZmMxNEVPdzha?=
 =?utf-8?B?QTF0NTRXYXpnc2t2R0Q0TTh4K1I2bTU0ZU9XelFIUzJLcGJmdGVyLzlVSnAy?=
 =?utf-8?B?Y01Xd3BocnZhSGZZZzVBbFRhek9ycGF4a2ZWc3NzLzZoSmx6V2c2R2p5dUtJ?=
 =?utf-8?B?U0RxUVRTNVNIbnQvb1ROZ1RteitUZHd2Tk9FOG5oNlJzeDdxNlVmZ21pU2w5?=
 =?utf-8?B?ajY4SC9uZDN4OEEzNEh3bzE2QjZaOUNZN1hGZ1BGYzdqMVVPaXdUTkpvcmFm?=
 =?utf-8?B?RVh5a2pvckhYRkU4bGRSTFQwZkFieUY2SExUSHQ4TDVxUFY4VEJiTEc4Wi9T?=
 =?utf-8?B?eTZiUWtBckVoOVpucS9ySW95U1FhMTM4ZWxtWVh4RHZZZXRNTXFMTW5QRHBR?=
 =?utf-8?B?anI5bDJmVFFkMVk4SFpCOHFUSm4wNjNJYnBnc1VhRnN2VFl3ZFVZd095K2s2?=
 =?utf-8?B?ajNzR1pLUmxYNHJxamNKK3pxSENVN0t1SWRnTEt4R2ZHYm5jVGs3MmtjZDR4?=
 =?utf-8?B?TFZGZmRJSkRMZ2pqWkQwZC9MQmJ1dFhudkV2NlJKMldqa21PQkF2RmdvZzRO?=
 =?utf-8?B?dlpFaWVwbVBQZWZCSGZMQVpXRHdjNmtRcURyQ0h6OGFKUEh0NUdXY0F3MFFu?=
 =?utf-8?B?MXJ4MmJ3TXdNLzZZLy81VEVJNWFIYkxRd0tTNG55Y1ZlcXNsamVKUGRicDQy?=
 =?utf-8?B?Y2VBTmNad0dzeGhkd0dQemZYQ0wzL2NNUWpRUlI4OVIyTSs5UTlTLzdjZ2dX?=
 =?utf-8?B?anpXcmZQNDRORnFGbHdWTzdHRTA5WDMxQ2c1LzJEZWZOT1cwMFNWNDQyYnZH?=
 =?utf-8?B?WnZvTUJjK1Q1TUY2bFRzSVFKUEhUbXNNY3NHUjFudFYrak85c01NdVB6RHN3?=
 =?utf-8?B?NEhqQWp3VDNUNEZFZzNxTkpWbHRVK0d4eFY4R29GY2xUbXNHcnBEaS9GM0Zn?=
 =?utf-8?B?eWJEZFdIUS9JaExhdmRUaE5KV2lDanlSMTBBU09YbDBpbjNXc3Y3YzhEOEtB?=
 =?utf-8?B?OWtaL3VwbU16YkFtd2dUYUlHVVYrY2ZNTWdHdmJuajZYc1JYR0V1cFRaSnZ2?=
 =?utf-8?B?cW1tRnZXeS96azJnbENGRHR2ZFpMUk9UOTEzSnA0OGU1SG5jZXplSi9sektw?=
 =?utf-8?B?NkNqOGgrZkpmOXhkTUhmWS9VbFNQWUR1dVNHU2paazJyVEt2OGdHb3NmeUl2?=
 =?utf-8?Q?luXOnOb01kGI5/OI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667cacb6-5ee4-4564-04ea-08de64d7a77d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:57:32.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne4LkZdDjJUIoBIhObc2WQ6D8253KVkAEi5Qqyp7NznjUMefLAlnmc/ZLQYLCTWEpGXryyqLRadTTbwVdlwphA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9419
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 16:57:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21840

On 05.02.26 17:37, Badrikesh Prusty wrote:
> Debian Trixie ships SWUpdate 2024.12 which has an issue: swupdate-client
> ignores the daemon's RuntimeDirectory setting and always uses /tmp
> sockets, causing IPC failures.
> 
> This sets PREFERRED_VERSION_swupdate to 2025.12 and enables
> SWUPDATE_SELFBUILT for Trixie. It also adds patches so control and
> progress sockets are created under /run/swupdate by default,
> matching documentation. swupdate-client now uses these sockets by
> default when applying updates.
> 
> Closes: #135

What's the state in Debian? Did they refuse to fix it in stable?

Jan

> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  conf/distro/cip-core-trixie.conf              |  1 +
>  recipes-core/images/swupdate.inc              |  3 +-
>  ...date-as-default-socket-directory-ins.patch | 49 +++++++++++++++++++
>  recipes-core/swupdate/swupdate_2025.12.bb     | 43 ++++++++++++++++
>  4 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2025.12.bb
> 
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
> index b133bbb..4ed2461 100644
> --- a/conf/distro/cip-core-trixie.conf
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -12,5 +12,6 @@
>  require conf/distro/debian-trixie.conf
>  require cip-core-common.inc
>  
> +PREFERRED_VERSION_swupdate ?= "2025.12%"
>  PREFERRED_VERSION_linux-cip ?= "6.12.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 00e972e..c9dbcde 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -42,10 +42,11 @@ SWUPDATE_SELFBUILT ?= "0"
>  SWUPDATE_SELFBUILT:buster = "1"
>  SWUPDATE_SELFBUILT:bullseye = "1"
>  SWUPDATE_SELFBUILT:bookworm = "1"
> +SWUPDATE_SELFBUILT:trixie = "1"
>  
>  python() {
>      base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>         bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>          bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>  
> diff --git a/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
> new file mode 100644
> index 0000000..e87c8bc
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
> @@ -0,0 +1,49 @@
> +From c89f62d0a68e5c45e3f052edf6c3d77bba8c67e5 Mon Sep 17 00:00:00 2001
> +From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +Date: Tue, 3 Feb 2026 11:25:18 +0530
> +Subject: [PATCH] ipc: use /run/swupdate as default socket directory instead of
> + /tmp
> +
> +Change the default socket directory for control and progress IPC from
> +/tmp to /run/swupdate.
> +
> +This aligns with systemd conventions (RuntimeDirectory=swupdate) and
> +the documentation in `doc/source/swupdate.rst`. It also improves
> +security by avoiding world-writable /tmp and provides deterministic,
> +predictable paths for both daemon and clients.
> +
> +Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +---
> + ipc/network_ipc.c  | 2 +-
> + ipc/progress_ipc.c | 2 +-
> + 2 files changed, 2 insertions(+), 2 deletions(-)
> +
> +diff --git a/ipc/network_ipc.c b/ipc/network_ipc.c
> +index 099587d4..e167d0b1 100644
> +--- a/ipc/network_ipc.c
> ++++ b/ipc/network_ipc.c
> +@@ -32,7 +32,7 @@ char *get_ctrl_socket(void) {
> + 			socketdir = getenv("TMPDIR");
> + 		}
> + 		if (!socketdir)
> +-			socketdir = "/tmp";
> ++			socketdir = "/run/swupdate";
> + 		if (asprintf(&SOCKET_CTRL_PATH, "%s/%s", socketdir, SOCKET_CTRL_DEFAULT) == -1)
> + 			return (char *)"/tmp/"SOCKET_CTRL_DEFAULT;
> + 	}
> +diff --git a/ipc/progress_ipc.c b/ipc/progress_ipc.c
> +index d3689271..382a83c9 100644
> +--- a/ipc/progress_ipc.c
> ++++ b/ipc/progress_ipc.c
> +@@ -41,7 +41,7 @@ char *get_prog_socket(void) {
> + 			socketdir = getenv("TMPDIR");
> + 		}
> + 		if(!socketdir){
> +-			socketdir = "/tmp";
> ++			socketdir = "/run/swupdate";
> + 		}
> + 		if (asprintf(&SOCKET_PROGRESS_PATH, "%s/%s", socketdir, SOCKET_PROGRESS_DEFAULT) == -1)
> + 			return (char *)"/tmp/"SOCKET_PROGRESS_DEFAULT;
> +-- 
> +2.39.5
> +
> diff --git a/recipes-core/swupdate/swupdate_2025.12.bb b/recipes-core/swupdate/swupdate_2025.12.bb
> new file mode 100644
> index 0000000..d53545e
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2025.12.bb
> @@ -0,0 +1,43 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Badrikesh Prusty <badrikesh.prusty@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +DEPENDS += "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "1fa1ce0c85423f228529d2fccbe8813f07040536"
> +
> +# patches
> +SRC_URI += "file://0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch"
> +
> +# Disable cross for arm and arm64 on bullseye
> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
> +ISAR_CROSS_COMPILE:bullseye = "0"
> +
> +# add cross build and deactivate testing for arm based builds
> +DEB_BUILD_PROFILES += "cross nocheck"
> +
> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
> +}

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

