Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D60AC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 16:55:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.998.1785257754693870850
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 09:55:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L6TTnw0B;
 spf=pass (domain: siemens.com, ip: 52.101.70.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rf0uUIYYtii5MOPm80h7/5pyCPooZIkqHyBQzimVs9mU3GROBfE7adZjQ37BqLtekfpnvJpuSgZxkpWttfEd8sLSH1tdR5v2MtVr/X1YZi09gQ3kzO9ssNBeLZ1HdsJkXHPGtW+Znf41my8PG+Vqn1lk7IMWkO3oU4hsSpBZsok/V0+HHGi2zrZnuUXRwUOzz9+zZFG+w1TV3kckhWpDvmczyeosjkdn7dEQd8QZq1bL3aRjG2AmLI1iVbsCgbSJEwR4ME732zFVdANE+wSxQXi5yU8aZfUM7w/JQmzh6CfzlCIZHh47gcJLmqXrLeG73W+ZXRC4/r6RtyCtRh1OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpNXwmLE93HPn+voUgKnjSalOH1a/9FGEsD8sT4btEg=;
 b=fQajYlhpYpxeXkr1oKSPO3quhDXMr7Ei99kp0/pDlcsars2g1Pi2hiaVn2sUp2wXvXn4q6sVgK+766u7dRKqMo+Yb3oNotf1RYgAdswse3Dy2Wlvv98QVILgg/jsM7FiNJuirABMWC91Mh4ufU90yW3KCD1D/axe+29xErg3sBFnH7LsT5Nufc34vBy1i0NHk18oftSov577rF7wPHt+baE8CZrDMLxqW917fwY2AT1RIeYfXmij1VBPON/McWgj4bwlpJ6piHfeGqm2o5SfjpYSmNBYHB/IKfiS4G3p8xGP/UXq6xpx3Q8yel9jy8DXh6zf8m/ThKHLvILK0/1xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpNXwmLE93HPn+voUgKnjSalOH1a/9FGEsD8sT4btEg=;
 b=L6TTnw0Bol6YvdEc1TbcuiNFG+v1HxODCN5z5ObtQQNr7cIYvhY2PiS34UQlRfJJ9Pa2jPeJW2lU7aKSdTky8k60SUhbLOz7BhqdPmZwlz/Q5wVZwRN9i5OHFgq2QTOSOfQAucOjt0zmyOiw/P0Ogu7KWOS3Fi4UrlYmjKTrSxW3xIjbS7zEYBnnJRLbP7uC8s/Ot5lAOmkdSX61yPoXK2HhgubBKRLbNmRc9YQLJrY3STPGcx0s0Zh7n2txxUzxwjiTB812f1/F4/1pPJxZOZOTCFNybNolSSkGlrB/WguRa2HHyOB1afOu3f+Xk4wZGV5/NOF0EOp46cU5w9c8ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:55:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 16:55:48 +0000
Message-ID: <592f75fa-e569-4d21-abd6-0bdca1cfb5fc@siemens.com>
Date: Tue, 28 Jul 2026 18:55:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/5] switch to rootless build
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0329.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: f00007d2-ff22-4ee8-8efa-08deecc912d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|56012099006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ae0/C9wZrBFqUgqUQYoIAgsNVTE/2a2xeXx5dIzFnJwxuVS+PPWu7MeVWwFdfEPl0WMfqndLjUYWJ2DYxPWzgHQDI7bzetf4DshGzdElmWQ1oui+XKUpNbhAIiGJmZ+D82ZnelnsXKjxy6bhHtZPZjgYbirLGVWJyFZkWGDRQkOZ0khrnOjrnclBGNYIEZgwFHoEgT5GqHbAUABYLEEkNSGUSBMwicLQirWazUcgVDZw7ayJOchbg2NICF1TrfmDNM7tiiPT1uNXzzsJcENaa4yvvCdQ+b/yZgyGfHgk5W4QC58yacHImoLz2j6eAHKLK8IHXLxt657Y0jmXyAO9RxNcMpe0j2+Oe1PfvIllqWOaKyP/jZR9ddX+hHmS3YbJj9Z2q9onaN3MNxveoXt1Z/FtyAfcfAYXQDRgYUjF8ZRWvuM5gnqJ0gX2WuBAWVsXWOiPhrAtzf5L/rUHB7QW7heT8gWAxaBbvz5KTTglmpeS/WaM75u3gB8lf8qGixMD0BD4jWM6mhtOv/BSWR8Ld2i1JVNbJleY6EdsPuP9IilUCgzqXsLyj8NkazUaZUh1dsNEQS4lAkCZ9UYkMe9ZJz1iX84cyLrxUGHWSqSwpJ4gtYo4fb6uMjye0e1cEPG5uLftKMhd4NoNtO91fplPnsSoT+jHEG1jGk2XzhvZSOo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U096NURJNjA3WTIyTU5mQXJBT1VVRUljWG9lSEJqVU5ocUVPRktsUzZveVls?=
 =?utf-8?B?bUtaeHc3UzlzdmlUZC9CN3dvZlo2Q09xMnpRbXdBWXNwRFE3YnF1L0xYZW1E?=
 =?utf-8?B?VUJQRlRHUWNtODNQbGd5NG5yb0VYK2VCTkd1eUtSZlU5Wkx4WEdEYkIzcjhH?=
 =?utf-8?B?ZlRnMVlxZzNZSVdQQ0lZMzZHUDI2dlZkUlV1b2doNEF0SFNwY2Z3T0xVaDds?=
 =?utf-8?B?SjBhWEx3V25UaVRNU1ROQ3VuSG5EbEpxRmNLRlhpOHRNQk5qZnc4a0JYczkx?=
 =?utf-8?B?R2xUTHpmYll3aHZIcndKUjdNSUJiRUJyRkpGOVNCVnlNaGtQanRwY3AzY0tJ?=
 =?utf-8?B?K3ZOK0pqNHYzbDljRU05c29TR2Mzcy8wL3FuSHVGb05EN0QvV1Y4aDV4WWRm?=
 =?utf-8?B?Sy95SlY5dE5qckhNekM0YU9OWTVTUVBkaGVxMERoZUJCYWZQVDIySEpyZUI4?=
 =?utf-8?B?Z2pTL1RqQUVndWlKMHFxa1pqaU11eThlTkhCU3AxM3FaNWpRdTVxVzhmQzJ2?=
 =?utf-8?B?VVEyRXhqQmZoTFZ5WnVkd3NGUVFBY2JsZUN6amtodmhWQ3hQQncyTXRpVFhD?=
 =?utf-8?B?Q3B0dlV6emVZMzlOUTdxU2hKVTh3SmcyUzE0RDZsVjNDc1pJMnZuYmZoajJq?=
 =?utf-8?B?SW5qS2J5U3lBcDNCbDBISDR0UVRoWkZUaGVuTllvcVpoMU1DanQvR3dUUVNE?=
 =?utf-8?B?cVJZdzNBNEw1WDdScUEvLzdHUFZ5N1ZjeXZLbHdwaW5Pd3NLTVU1ZjRGNGVr?=
 =?utf-8?B?N0J3M0lTQUhDTXp5a1ZxY0E0RE85R2ZMRkFQYTQxMmp0S1c2Vnh6YmlPSkZV?=
 =?utf-8?B?Z2xhWnIwb1RxbGJaUU5DRUpRbSthR0crSUJabmVEbHZ5QlFSR1VwU2FXbmI3?=
 =?utf-8?B?NzVCdExSZUpHRStBemZQT3FxSmM4OHpzQ21xVmhDYnFnQ284YUR5RXBibC93?=
 =?utf-8?B?YlRrV1JNRGRhdWM0d2VUTTZWQkwrYzJBNG0va1dnanNJZlovTlhpK2hpb2dN?=
 =?utf-8?B?NUtiK2k0RVZ2eS95YTNneDFMam9xeGNuaitmdElaSGVMcWJQY0hUN3ZnQVBY?=
 =?utf-8?B?MXU4TmkxR1A2L1ZjeTJ1L0lwL1Q0ekZsejJzQU9zSThqSzhIdWY4OFVyREFk?=
 =?utf-8?B?NS9LUzFYbUdjdCtkM2xCUWRIcTBLMFQxUlhoOVlyc1drN0ZFbmdnakM2K3BM?=
 =?utf-8?B?UFhqeTdWbGp4TlZWbjhKZkovaVNVWThoaVdLWVhPeEdOWU1sby9tY01OOU9T?=
 =?utf-8?B?TXFnb3luT1hJUDdURlhZOGpuTEtLOHJEVTlLQ0hyQVJFbTNoeXlMcUgrZzZG?=
 =?utf-8?B?bkNhTW9IQkxVUjN5QWtCU2ZCVkdKZWtLaWdwVUg4T3lxQXF2TFpkVXpleDlF?=
 =?utf-8?B?RGx1cUtIWmFqS0FZUnNTRnF0RXkyZFJGT1ZNZXVSNnZpL3I0OXpNdHg3WHVx?=
 =?utf-8?B?QUtkY0RoYkgrRWlUNk13OFVlRkhVdmZGYlM3eXR2elRQVWZ0YnBBeWt0emt1?=
 =?utf-8?B?eVUyZU9lWlJGaXNYTFhPTHhMWllRb1REWTFhaEh4V1dHR202cDZoeWxKVllM?=
 =?utf-8?B?VGFZYkRRbkZWVDhqVTJNb3BjUzAyMlF2dC93WmdBSzhxWkczbEdBeEwxZGtX?=
 =?utf-8?B?UXlrcnpYa0w0UjZMY2JvTlVSWno0dU5VaXFSclVjZUFSaEFUS28rNkplWXA5?=
 =?utf-8?B?TzZJZFhwaTB2RFFUOG1KSXJQOEVCK2I0dTBndExndjR4bklvL0dOdlVjQkRL?=
 =?utf-8?B?YkwrdFY5dTRpWW93VmN0TGJlRW1jWm1QTGRDRGZyQ3hidWxsTVA2NFNoQVJh?=
 =?utf-8?B?dFhvUkxlelVENUhyU2pyL2txTmhRWjF6ZjhPeGhQQkFNQUVzVXFveWk5Y3hH?=
 =?utf-8?B?VDc1bm96VHZXd1k4d01UalRoREczdG5SQTE4VUs1WXR2bm53RktWMlRkMlZY?=
 =?utf-8?B?NkRRWEZENXZwMDB2YzJpMlBYTWxZYXZwR1BrZ1pHMkx4WVZPV2dJdk1CNlho?=
 =?utf-8?B?VFRPcnlQWERObjc0eUp1dldlSGFNVnZmZEJkVms1cU5nQkJjeDl2dXZIcHd5?=
 =?utf-8?B?U1NJQldCYmZUL1doVXRuWG84VFFLRlJDWEZYcU9UOGFEMmhpVUZHbERXeHRj?=
 =?utf-8?B?Q0RFTjY4ZWFvc1dhOXpqaUNyZlVBOUNIeEdIVUFKV0FkT0FDVUI4M0xmc2Fz?=
 =?utf-8?B?dXhQRXFiT1FCdUg4bEk4UE9MdWhQTGNQU3hXelZOWEo2TFZ4Qmt6Vmw0YUhF?=
 =?utf-8?B?RFZhU3U4bnRMZFJvcVFKcW50b3N5T3FrWDVUdEk5UHZCK2dibjNzcUpOa0tu?=
 =?utf-8?B?T3BTREsyZlhnY2pLdGJkOU1zeTFESkZLWG5GSHJGV29jQU5zQ3QyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00007d2-ff22-4ee8-8efa-08deecc912d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:55:48.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bass5ziJ4zNZf5aDAt27pZLOZDbUwyLS09RKnV4Emwfkyy+W+VQWZ9vZUx/MDX7TRhrnoNjIROsXBUJLP+fdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 16:55:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23808

On 28.07.26 15:12, Quirin Gylstorff wrote:
> This patchset contains the necessary changes to switch
> isar-cip-core to the new rootless build.
> 
> Changes v2:
>  - add Debian release requirement for rootless builds
>  - use kas purge in .reproducible-check-ci.yml
>  - use correct kas-container
> 
> Quirin Gylstorff (5):
>   update to kas 5.4
>   update Isar to contain rootless changes
>   use run_priviledged instead of sudo
>   switch to isar-rootless
>   update README.md for rootless build
> 
>  .gitlab-ci.yml                          |   2 +-
>  .reproducible-check-ci.yml              |   3 +-
>  Kconfig                                 |   2 +-
>  README.md                               |   8 +-
>  classes-recipe/image_uuid.bbclass       |   4 +-
>  classes-recipe/read-only-rootfs.bbclass |   8 +-
>  kas-cip.yml                             |   4 +-
>  kas-container                           | 300 +++++++++++++-----------
>  8 files changed, 176 insertions(+), 155 deletions(-)
> 

Thanks, merged with the mentioned changes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

