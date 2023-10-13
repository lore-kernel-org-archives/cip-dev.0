Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F2CDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 16:01:01 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.79])
 by mx.groups.io with SMTP id smtpd.web11.42594.1697212854565010602
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Oct 2023 09:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M+4nCuzM;
 spf=pass (domain: siemens.com, ip: 40.107.241.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABKsBYw30gcAaPcoGIHAFXwP+BHd3m5XIeUE+c9ca/LsMfy3vfOxpu1oZaQkB+kIDRWNc6h1hk0wWHT0u8j9rj/6427RpsM/8IpXsuQh9x8fmcrMDn0niGB8OgPSHlFY2dbdDzrvainFniOkv223feDKhxX4z2dmxNhsMvEYPrkU+CSDTJBQQY4Yzs6bwwohvYwaQeF+LgEJTfJ1/DwVSDnChUjyF3KcmuPBWzSOB+77izqCbyXpqjhTz7j4W0Luqx6d5lOz9F5alLb/SmepLQZwJrfz9cfme6oOxNV3f6XVSXg+EHUtXzbLoGPKVgGU+MEaRkbLkOMZQbTccPYyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4UfXOEsSvdZkM1JfVyUC8NcyrJG8sWJX4r6PpztZNw=;
 b=KkbeX4VgLpfCxZclUI+Zar/onCwphn4TzRnJGZ5MTwLU0gsLl3bLkj9LJDa6FfVXwOau/plA0dIs+w46f4+TyBafdWpuQ+LSFJztYSSkbiLKOdksphBW++9qQ/fZfGvXmpGGkWXg436YxpUnrfqPZ7XGhTjqGKO0KLb6/jRVXAOigq12V7meM0zgbRIFyNvRyqcgD4nBdfTkYdx8idACtZKeRkiSgjyw3nRxupjDy8ZVQJ32DXEWVvAgMP6EwTfxaU6S+PcTdwAGT7cuA3IflaZWFtRS/YTMz97W9adJdBjuu6R1k6ql7k0jh4UQHiq8G82djQ1sxz8klCVOz/sXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4UfXOEsSvdZkM1JfVyUC8NcyrJG8sWJX4r6PpztZNw=;
 b=M+4nCuzMD5x3PL8agl2gWTfDsUpslrN1WtgYfB/eNLrKIQy2rPDiiMxglInzOz26gSc7oBkR1EIIwGTIdKACHRc6OM7rxUPE+QJijuyZ6W3EwuRoDhC05s32t4jdWV6UZA4X5tbJnwitMuVgV47nMGmiFVtGFilt3A4Uw7OqxxbPCUsKoamB5tIjIe7fIHU/0ayuDT6BDg97x9N/9WBAnTMzu5zHWAcA/DkokDL7AReCg/X5FmIGyWbrX249sHRgW72luSKR4FqVfpoAs9XM3dWsL07kShhsFOfap9XpocsnJaD2/Vi13tZPOIhz+N5O6XdkQDwFBrVkyWSbZPoARw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:00:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:00:50 +0000
Message-ID: <a49046e3-25f6-4a3b-a3cf-3d015e6aabe0@siemens.com>
Date: Fri, 13 Oct 2023 18:00:48 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.2-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3145:EE_
X-MS-Office365-Filtering-Correlation-Id: e86c88ff-2228-48f8-0d80-08dbcc05926c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	crpeBVqgCD0V3ranqZ7kRWFcsTeFgrtzqRZmtDEB9IvCEHHIDT7UduQmECdIFUTQTakx8Yr4coemNSkBFRCx2VEYMeaZ+W7k+0dW6yXBGLKgGSH5Lu3gpvY+bkbehCUNRrC8kuACc7rX+TbMSUPNN1Glc4POAbUXXxAfTHlpDohsf2+Clc40N5+EEYx+XUiulr88W0HjOnn562WJ+mDF5PIR0Hyg+JT29iVrUNnXTzSLtsnFFEu49PW/UjVIPzyx1WyA/OvN4Lu7XBfxXXyJs+yhEOcqLGxGFEdMyoxObZ/7y1yRjR3m3YWpPdFqzfHiClxXGSct7eftqmSMW1w2ZTiwkhIJt1PUDtryPCqboPskM3zkAk9y7m3iF0BA/v4aHEZ8sB+6RqU0/ggZeEqz2QcmEiw2ILJd60OCJi3394xakwwM2Wp9J7VAIWAB3DbbyRuNWk+70ZVdnDt+Oo/nR9ktBcaTz5nmYQXIVrSu2Q1GOyD83M2ubWNU+AnVs4YIJVOwLO3wr4Ta5jg/F+/V4Q5+xdteeVaCs2+ibzpiMkXKg0ZTmnA2tzXVush3AbTyoG3Va3GPSxxo1IEDdgAHUOsrDTFnEXbFL7azHP6DEcIXhDA92i4fbSIS6YPax7HN42sDQyxurjy5LvHHPyMLLw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(31686004)(2616005)(8676002)(6506007)(6512007)(6486002)(478600001)(8936002)(966005)(26005)(41300700001)(6916009)(2906002)(316002)(4744005)(5660300002)(82960400001)(31696002)(86362001)(44832011)(66556008)(66946007)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yll1YmMzNStqcVpyOXRqTVNGVFJlcnB0UDVqR2NYODN1NXVMM2wxRGpqb1lW?=
 =?utf-8?B?WVhGbzV3WVpQM2w0alJ4Q0lEMGI2cVQrR3dUN0ptYUw4Rk1nSTZwOHFJTGRh?=
 =?utf-8?B?bDZNTzNzVEk0Y1hHUlNzZmhBblA0Q3kyNDFobHhzUHBaSTU4VUFIMHE4NWk5?=
 =?utf-8?B?K1hGQmpmbkhZb3RIZmtINXJaTUNwaTk0eEhYQTNMNDhkRXJzQlIzVS8wVGVB?=
 =?utf-8?B?dTN0RlBXSUxLblM5YW9hY3RqUDliZG9pOGNmc3NFYlpoc2xpalY0LytEdFZX?=
 =?utf-8?B?QnM3OE04NmhkeFplczJ0SDAyZk16Mk5YUVFQTVRNMTg3TVZWQ2puQTF6NmVD?=
 =?utf-8?B?cjFHRVRMclA3aWlrNWp2Y2RlNHN0Yk9aNnNmSnFtL1JLenZpaVl1OTlEdURv?=
 =?utf-8?B?V2xKaTVDSksrK1BpT2orbDdIem00RitnVzZBc0s0MndjcjMxWmljVURYZ0pV?=
 =?utf-8?B?eUdxeXhvSERxOHhKcEZFaEYvVDJETVhVU0dTc3E3VjlyZ1hwNDZaV0ZqdFJQ?=
 =?utf-8?B?Mkd4VFByM05KdDkxWGI1SnNEQlQ1VHhhUitjZjRldk9yTjF2Y2JnemREZmJx?=
 =?utf-8?B?aE93UGJzUC81bUladlQ2UFhFUlZGZUwxN3RFaEpjS2tyMmhYT21QN0x1bnJL?=
 =?utf-8?B?SVdLUDRtQXM2RHBCczhsbU9DM3ZaV1A3UW8zZmk5czNFRm5WTTBrakE0aUNB?=
 =?utf-8?B?djNtRGZjdE1PaWhqODNYOE1DUDBRWWpFL1hSanBHdEUxMTZ0dG5SWks3dllQ?=
 =?utf-8?B?MS9RU0lyWDFEODdDMldmb3IxWTRza3VLN3ovTWJsWG41K3JWaEd6Umt2UnFm?=
 =?utf-8?B?cGdmSGtVTXUxZm9nNUJSdFQxQU5pWXpzeUovRktFTkw1dUhOWjkwS05VUTJ3?=
 =?utf-8?B?dlNlendHUkRRejB6SmZpSFgzRWdYUlh2enArL2p0NU9xb1M3QnlQM1NHSmdS?=
 =?utf-8?B?T0FSTFM1VGtFR1ZDYmxIdktkZWl2NlRoUFBaVVJUZEtGTUZ4SU5RalpFRGUz?=
 =?utf-8?B?NHpxc0pQK1h1ejBTRjZCWUJnU0h1emI1UHBORHBuNGdWOUovR1ZBSGliTmtO?=
 =?utf-8?B?Uk1IanF4TnZZcWpFRHNLOVhMSWtuTzV5UW5LdHRWdkJta1l3L2xZekY0SG9R?=
 =?utf-8?B?YWMvYlF6M25CY0hYOEY4TXRIa2l6NERPblUra29WR0k5TkdGbE9VRGtSMEdG?=
 =?utf-8?B?eUF4ZmtMdmZXSFAwRnRXVC96SmRtd0lYR2toRENVMW5VU2dsTVdkU2lVNmVR?=
 =?utf-8?B?UEtOKzUwQVlxKzNmMGlHdUhvdi9GTEIvZXB4Wkk2bWpwM05CUXRieGxwWmhp?=
 =?utf-8?B?UXh6MlFtUHdOQTJpTkJBT2w1YytXOTM5d2JLSWJ4L2IxMy9USlV4Vy81dWNW?=
 =?utf-8?B?eDM1VGpBQS93b2dhVGYvY3hDa1JzTkFUcUtmZHBjL2ZMUmhXS3REc0t0ME02?=
 =?utf-8?B?a0FoUXRjR25qM091N0RNU2xhQlcrNmFCQy9nSlVueVpxM0J1MEJWYUw0aXpE?=
 =?utf-8?B?N1RYR25qclYvUWk2RS9FN0ltV0d0VDY4dWUzbmt5STVJVGNRSGRpd2M2dmd0?=
 =?utf-8?B?T2lUa3JXRmpHZ2xqYTU3Z1NRSExhVUZjbmZwaWxCQit2b3BmYTZ3NVpDaFlj?=
 =?utf-8?B?S1A4QXFTTDB3SXAyZ0R6WGZZd3prZkpWdWVpVElKcUpsZDNROTMrcDJrdTRk?=
 =?utf-8?B?bGNPbUlhVm9ZLytoYjlyMEhnYmtENi9RaXRobkpJY1NGYmYybjBOSHNpTUZ5?=
 =?utf-8?B?YWdYTU9pUThYbHZ2SnJzYXRlMy9qRmphalFBeUg2OWFKeUpueldYT243azZn?=
 =?utf-8?B?RXBaSlZuc0RsbVBDaGk0ZjU2N3hsb3VPLzVLN2ZUR1BadWJnNGREd3A2Z2w1?=
 =?utf-8?B?cE00Q29DMTQzNlFlKzFIR21OM3Rvd1psTHZZNmFKVWFjempKL3ViaVgxZ091?=
 =?utf-8?B?Q0p3ZHgyNDVCaEY0bEdwUWJKQWovREkyOVJ6R0M5aHlMdlplTHNNUy9tWVlI?=
 =?utf-8?B?ZkUzamlqaGQxZFpkejYwYkxyaWtkcE5WQjVLUTRuSHB6N2MzODdZaEI1TUht?=
 =?utf-8?B?OXMyTjRYQ2ZTS1cxcUxqMkF2b1F2L09TSUFnTkVEbm1VVXZXOStQS0s0U2ZW?=
 =?utf-8?B?WG1wdVo0L2JwOU1DK0tZZkw0NXFEeWpLcjhKSjh4eE9KMmx0czc0NlZUdkRE?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86c88ff-2228-48f8-0d80-08dbcc05926c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:00:50.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZ6q8NCWh/zejDbUZ1BZA0PGC6A3qU1k3AYOkhETinF69oGbfsCjp25Xw+AEJkmNCqfyP+m6YBvObk3NJ/dUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3145
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Oct 2023 16:01:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13396

Hi all,

this is the first release candidate for the v1.2 release of
isar-cip-core, the Isar layer which allows to build CIP Debian images 
according to the generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.2-rc1/isar-cip-core-v1.2-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.2-rc1?ref_type=tags

Please test and make sure we identify and resolve any remaining bugs
before the release! If all goes well, I plan to release by the end of 
next week (CW42, the obvious answer).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

