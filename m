Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FAFC54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 14:09:35 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web11.45181.1710770969494437637
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 07:09:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RBYVhQ36;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5RQLPD1ux9h+p101TbRyoQD9vu73OSNMKQf5bf6RJtTog+GwZ3Zu7A532C/DWyVBqeAvQrZ22zxxxEVBqy7/tT0r9dg2HOO642foX4Q7e8RfmJ4wGRxtr4aYZQ842N491v9eV32/DPjmSKJRbf3ld7pYPS9JA0fjtdeemybTzLYohsHo/fGb1f1YFe5fdABeJJYd+TdsLih19dD9QrdvMh1DE7dSo1zU1UDHSEF8QLyKbHczyCCorHEuhzqm3QYzAPhx6xgiDK5+NfYfQFx+pO72Ha0GeHfjCx9S6mTO/UN+xM6k84wSqux0RyWTsXUIQyI5/1ekyesio08Rat2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFpTfbyOEKPG9weLdH3m+J4mQBt8nd1/UIYAUKwPQpI=;
 b=hhwW/V7teNKLMbOPLaGhJ5uG7h7Mirz3DmlMGvImKn85TptIJ83Lo91h22t3If71EJXvj4xKLBFTxG1iF5y3joLnE/jvBAsEGanmaiXjxOLQtcuI5aFLuMMPBn5QyDSG2C11Ic/rv79yVhNX228khtnhziO+5WvmyzXPTWmCMveOO7zfaeysaH5iTh9egp/9Nw5el1L8XBwOkdI80pyHeUuW7wldgBhGSv56JHxZBstMWnxfDyeYxACkaWY8afgkHA3cX4rg/xUjaojtunFvgiUyXxLKs/Jtliyxn6/Y1o3tv8vFnqwcBAzWpH62ity58/81xI3PF0zGzGExFZG3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFpTfbyOEKPG9weLdH3m+J4mQBt8nd1/UIYAUKwPQpI=;
 b=RBYVhQ369IGwLu1K7E5W1Nk8Kwnq7BVJIzFlkBY5PjKC3RXMifgvWJMjabyW8teCffpnJ3VROBKHqVA7vC6LDcH0yUdiVRDnG1xTV0C1hmoI1s+gHlVjB27/iDS/ygdtjZmU+AcK7nlN1INENFk9bEVWMzV3uuEL5Txmk+/jCB3etpzffxNQzjaqTs/7nxWMgbgOjzgyACYqGJEW51eKixQUukjg5JcalNUl0pPN9+wjnQ1WXLxxZqG3NO+LslTcne1NeYLPA62riks9PXNUjT5bjWTHiVmH4lyEm4a9CU2+f2rYDEGVEnjS7iXccAUmlvV1JUTEUDRD9DoUHkQfsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:336::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:09:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:09:24 +0000
Message-ID: <10b0be8d-390a-4475-99b7-7bb06686b012@siemens.com>
Date: Mon, 18 Mar 2024 15:09:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/3] Update to SWUpdate
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240318125144.634700-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b139fc1-087e-4f95-531c-08dc47550437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PgU6H9Xi9c6jDUMbq3Gg/WT+JPRPoiMZizZyrm+HY0/mJiEIsgRZoUyRoNIlJizAwaDwt7oVkvU5+G/Z9WVOVCCtS+HAngphlqJgzjibtnSOlII4HSUSNNwtB5nRJZhkx9htdJJJ4iY+HN9OI3yTFlRQbGQ4r2JD5pDU8GezqP7nLryzNx+OFo27wtnQhFeD9Z7G/LRaVGT7PW68iesN8KKeHuQgJ+xpvZPfHBq7wpqcZA6Lj80QZYXdUo3XgKtMCPCTc8zsW/HFGn35FXKqx0MlC3yud6L2ctmyz/5Ts74Ehl9lczuPYvZHWnLTgcP9NQSXOTmGHhdxBX3YHyFevll6/kyj/A3uclpU7I8D4eHjjXp0nAVAoBNo0HzaeOh7ObRbiVCgSOzkSB/EF46OSFLrNsbyA2E9vtd2Gb5X1ckHbVzWGzgNo+6BkbDzT5dwvGv1yWl09VefdeYFBmpMfpsN4GuZWcQ9FY6X+rs+SvMe/QNHnJ3hUKK77q/H2YYZalG8amrZa2nphea6Y7GBPj5ZQ4d2zMNVzz+J0/GavzJJEEPB79Otjfx367m8Rfn0G+v/Fu083bIxnqkAhA8R0knRAQbb/peYOX3qdwYQVwo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzFscEd3azFyOHNEMXMwRVpQRHduNWwwN0VVL1poVUFHMzRPNy9tWlpYNERU?=
 =?utf-8?B?SXdhZ0ZXTmdsa3FOWlJWcitNdmoyQ2ZsVThXdHNrTjVvcE9VcXVtWXpHMCth?=
 =?utf-8?B?WE1lU2VuSkhIVCtnbFQxYUpuZXZtQVJJSUkzTHdpdnpMNnRzeGZkVklaTDlS?=
 =?utf-8?B?RnNrOFJQMHJnaG1USUZsbjlBeTdPRGJSU0E3UWRHU2dhRlpVc1VCVFZyQXBj?=
 =?utf-8?B?VkE2REdXQU1BUjJnamRjVlVZQUNiTWR1Q0RRSmFFdU1TTkNyaGx5L1pmVzJ2?=
 =?utf-8?B?dGhqS0ljcXo2d2ZzVDhuUXhvSHNrWURGaUtUNkNUeThDbTcrWnFuTm5EcGo2?=
 =?utf-8?B?OEVSUHV2TWI0NnNaN0ZoK0NCbHNadzVLNFBUdWVBdjhpOTJ6MUVWQVBQWUh0?=
 =?utf-8?B?dktMVmJ2SGJxVE5yNEtYRjd6K1dLSnpwUWVYeG1yemRnNHF5YlJYRjAybWVp?=
 =?utf-8?B?T2lMY3g4OFpkZEpwbHFMd05SeHh0UnRsU2FxVURPNU1OWjFFQ1VuTjV3clI2?=
 =?utf-8?B?QlF2L2dYVGQvcHB1L3dFY05CWkwvdWh1MGdwZHJhcm1QNkh4U2xLWHdhMW9t?=
 =?utf-8?B?Zko4Wm9WSmFvczhOb1ZwTy85VXV0OWlnZ3RjUUpidzM1OUJ6aTk4WlFsNlk0?=
 =?utf-8?B?djNmbnhMaXJOeTRXeW1qN1YzNit6aUVuaFE1d2pWQ2c2M0JkZU9FY2kxU1FW?=
 =?utf-8?B?SVpZMUJSdkx0WHVhbWcyb05OZEpMUW50aXJ0TnNBNkdsd3ZYYzRPczNCQ0VP?=
 =?utf-8?B?VFAwakF1ZFlrM0VGS1RCUzNETjQ5NDk5Qy92Q2d0SHBPRkFRTTBIbmhBVy9k?=
 =?utf-8?B?aW5Ockt5cndGZTdQMnFOcnBUT0xmZ2xRZyt0R0dUQzVkS0p2SkpSNmtObkF0?=
 =?utf-8?B?YW5uWTRwV1daOGkvcXBrV296T0t4SHlzSysvZGE1aWtRbFVVLzZhY09oZGth?=
 =?utf-8?B?SlV4Z3pmT0ZhM3ROSzRUemp1bW5UZUZZaTRNQkZ6YnFENXVxTnlNempkMU9m?=
 =?utf-8?B?ZTJIdDFJSjhFV0x4QmJsQ0djU3VrOUt4QUh5aU03ZDNlalBzaDFZVnZ6UUdv?=
 =?utf-8?B?ZEtzeW9KMkVKdWhNS1EzZWlDNC9kUlhWSkEzeGsvR00zcHBBMk1rbzYxempJ?=
 =?utf-8?B?cStJQ2QrdHU2M1d3UGNKMU5Bem93Y0lyaHNJdkVrVlZuTUlxMHdwNnNHSUta?=
 =?utf-8?B?SnAvT1ppSzdWNHVHS2FKWXUwQ3dFamFMcGFJUGVPVGtFNjB6dkUvRXFDWFB2?=
 =?utf-8?B?NFk2QzdzN3NlZWxUOGxSVG5aZC95NTF5MWlydzFrM1ZySWppSWM2dElGejhX?=
 =?utf-8?B?NmdaK2s5Y2tGNUdhMWlpVFZPWUlrL2xGQ0YxYUdpMGRFOURMb0JhNnQ5WHpm?=
 =?utf-8?B?VXFpYWhKVjNRcWgvQVdRd1JsazFGQ1MxMVlUNTNnQXprbHdIUHEvQUFwdm9k?=
 =?utf-8?B?ZXdEbVJKMWFnN3NldGVHd3pMMVV6R3pxeDJLa0tvWEhzdDljbVA0elluWnhm?=
 =?utf-8?B?aUd0Z2xXQTJmWWdIRjZvdlRINDdDZFJvSG9QTzI3QktLZGcxODZESnF6VUFl?=
 =?utf-8?B?dDhpbkZVRnRVT20zcjdyNVJYNHAvY2grZy9jUlJYYlA5M3U1ZEJ3UzU3ZnNF?=
 =?utf-8?B?MU5pTVF2WnF2aW90K0g0VDEvT1JnTFdRSVZ0UzgrVVFzL3BhRVk1bUVTNW1Z?=
 =?utf-8?B?elNTUUJLMDFrUFNWSHBGK2xUbDRpVXE5RVZ5d1lHUTE5bjdEdHVucGdHWmNK?=
 =?utf-8?B?NkZGNFExZnYxL2MyMkpJZWI5REl5U2tWRlhsbXp1Wm5vYnpBS09Zaktqc2ZB?=
 =?utf-8?B?YlFHdFVKSHNtbTdjNXZWVDVYcFRFaE5EcmxWalA3Q0NQWlZ3NURybVZjb01P?=
 =?utf-8?B?QTQ0UGVHU2RsYlBnUGJGcWxETDNjZ1YrK1J5RDFuUW9XZTJFWHlUVWIyUFdu?=
 =?utf-8?B?R0xQYjNQcUx2aEdSMlRSVWk0bzlIV1YyNTBOdmI0K3o1cUE5MlNjK2hqNDFi?=
 =?utf-8?B?NkZLQVAvNFdTSXV6ek44OTJDcjkrWFBkV1VJQWExWWdrK0RKNDJvcVVYWWdU?=
 =?utf-8?B?dGJ6eHRLWm1INnZia1dlNlFVNFZuWlFhWTVPaHRXcUw5MndZTUdlVU1Xalli?=
 =?utf-8?B?RFpTU0lhZVJqTFZEWlFSczR1T2VNZlJYYWNnWlNVVVNkRUUya3lQSVlMYXNT?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b139fc1-087e-4f95-531c-08dc47550437
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:09:24.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn8zLgxZD/Ks2yeoPomhuztQOWfQFVJT1WfH2/irAfWAEGd+qG8+RYDgGMXvVWIRPQcuOo9q29UmZBLq4Ya5Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 14:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15360

On 18.03.24 13:51, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This will use the latest release on salsa for swupdate. It activates
> WFX by default and fixes a regression with postinstall scripts.
> 
> SWUpdate 2023.12.1 will replace 2023.05.
> 
> Changes v2:
>  - fix whitespaces and Copyright
>  - Remove Preferred_version for Sid as we use the upstream binary
>  - remove preferred_version for libubootenv -> unnecessary
> 
> Quirin Gylstorff (3):
>   swupdate: Add recipe for 2023.12.1
>   conf/distro/cip-core-*: prefer swupdate 2023.12 for all distro except
>     buster
>   remove SWUpdate recipe 2023.05
> 
>  conf/distro/cip-core-bookworm.conf            |  2 +-
>  conf/distro/cip-core-bullseye.conf            |  2 +-
>  conf/distro/cip-core-sid.conf                 |  1 -
>  ...tch-to-add-the-build-version-to-swup.patch | 94 -------------------
>  ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ------
>  ...rate-build_profile-option-for-delta-.patch | 10 +-
>  ...nstall-Fix-path-for-debian-bullseye.patch} |  6 +-
>  ...wupdate_2023.05.bb => swupdate_2023.12.bb} | 22 ++---
>  8 files changed, 21 insertions(+), 146 deletions(-)
>  delete mode 100644 recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>  delete mode 100644 recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
>  rename recipes-core/swupdate/files/{2023.05 => 2023.12}/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch (87%)
>  rename recipes-core/swupdate/files/{2023.05/0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch => 2023.12/0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch} (84%)
>  rename recipes-core/swupdate/{swupdate_2023.05.bb => swupdate_2023.12.bb} (54%)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


