Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D9C77B6F
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 13:33:12 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.64])
 by mx.groups.io with SMTP id smtpd.web10.13622.1681219987661270894
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Apr 2023 06:33:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uA/bl3sz;
 spf=pass (domain: siemens.com, ip: 40.107.21.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj6hRjx2iF3gn2c04M7/aS5E9jWy1uy6XKZxcX+IdAZyrH6UyUOPN4pz47B1Iey2W1UXiHtDbiMcaPGhkaGoCJcDITI16+8GUMTLc7G/0TFJdIpWzG7RqwEnGv0Z09luGpugzpVEJYhmxCCsAm6Mbtt0edXHaJqdXKltKjVbjB6/vHOP/08lulZQjuIyHPyVklhK52RWGQSv8Nhy5c2pI1MPEmgdH4x3CosiZtiQJtNiJCf/Sq3eaCjdhcIEAaSJQ0lybd6CjqNOHU8d1n930buSLDG7kckLgqrxupg4XKDbENeAhIAYHNjv74wL8GFQrZ+Yo2mmOcpChP5pogR4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvxlFx9LLSNB2crGFS94cYBdj3itUj9lJoxz14R4VIA=;
 b=Bt6Ed/Qjgy7jpbj9LDax+1A8C7+8OPtJf5BgeTtM34T7Ysc3KY1tqqNhVjieh5n68U9r3jUDCqs3KK0OE2AYiwUFHvlm2ODcvRiB7I79Uy56gnz0vFZO04AJ/5z9cKBlgOiRJmUc49c1XTrrXvCP3SnBHV4CW5jb5Gq89yX4eczO7mfwo7xuc8lUCkuPHWLbpSaVffZKiJWhYOBcaBnuNWlRZ5Jh/t+2+cDhPne/3o3sxXyxNuzu7Y0cYYhQs2QpvIQTTn4kPhCi6yFIaCHG66yTL/lysZugNEeRE9lXLnR+MTGX5DzOk40/FBCXssXXtgQZRjZhgkzDZxJiOCoWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvxlFx9LLSNB2crGFS94cYBdj3itUj9lJoxz14R4VIA=;
 b=uA/bl3szwZPT5aEItGkL6DwShoOkddMb8oMPxbzoKlT41z04h+vp0dva6ThAyDBCitdRJYOVu0975PmLP7IGKJXgU1Tt6zaKT0Kbt3L35AK3pa3SLk4RAk4s0zVtZQWmuwq97I3V7lT/6RfjjeWwz1yrHZO4or5rZOB8eQtYkAu+lD3QM2kZFGZm3+6oCnRIhO7M1ElI32ysvrrv5mox+nOfppPu1lX9O9q0A5PUFwBcoAZyKtLeb8NdMEXLjHFjJWcN3Wa9HIapweu441ZFJ9KlMPuhfT+R8iZgotfJ3+4HZYHF/iFS69ri3ruUQEZBid5llNPCgQq3bVlqHCIwUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.27; Tue, 11 Apr
 2023 13:33:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6298.014; Tue, 11 Apr 2023
 13:33:04 +0000
Message-ID: <b1506561-369f-d0e5-e5c3-a5d0ab638434@siemens.com>
Date: Tue, 11 Apr 2023 15:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [ANNOUNCE] isar-cip-core v1.0
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <11c7a50f-4582-9645-ebc2-2ff2c8422454@siemens.com>
In-Reply-To: <11c7a50f-4582-9645-ebc2-2ff2c8422454@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d350161-6fa2-49ca-a231-08db3a914702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MIzcAvfQrj9v2/RCnkBUzsx6iGeD1xS5aWvaxuihu6Jf9v95rTnR0QDvcdh0kI63FNSfro2hdFYODAMGfmJkK3MGzi7cQJ76bQGa2XW/ty8rguqin0eFuJgoVQBf7MXOJwYurlTHf1zcZU/Ia8P5827X6BGk9a/oXF8enQIbG9q/95UDSMFkB/V/0oPJa4j0wwZMYt/FzXEN+Jr7SX0VO5s2/tjbH8OmkRaQ0QbhNYksCaQ7Z9F3oWNV3vW0qg4kDQ7jEqNGdKW4fqkeBZi0PLzbWHbN0Xmqq6bM5ei06U09n8gT1U8tfskpSBp34ef6BxvC67qaL1kNp5oUTr2W+vtUiMeiHnDdCPfuB234DBTbDcata5GoNbTqzVyFieo/H4WhHFrPTdnFF+Qg117hK9vHG3CWeMA7+ZaG09RVAgVMTB5g4Oxn4DM8dIPnO5wWnRxpVQibBcI5TY6xeCRm8I5E1nv/Nk8b/3xkXmyIYG172GnS5iC7cfYuFtzZpCH4iRsY15AHvxOXU/tcyg4YsLlesrfoRvKZaeftVMB9EnaeKAU4LBT23Dv4Y7t5MMrtWw41j8P24NQwgEkNhDH+zEXPWJDwxSfUpN9EPHJ9i+A8gg8nfDT+MLhb9uN6eq1brOE/BAY9MKL91RtzrTY3WzxeMaqoTEbNSwDUg4Sx9TxVJ/7OrTKV+BIakXf7ZUgk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(5660300002)(66946007)(6916009)(66476007)(66556008)(478600001)(316002)(44832011)(38100700002)(41300700001)(82960400001)(8936002)(8676002)(966005)(83380400001)(53546011)(186003)(2616005)(6666004)(6486002)(26005)(6506007)(6512007)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWJGK25XWjdyNUwwak55RXNJZnBteG10dEtic1crdW1HUnF0OTJuTmlyai9W?=
 =?utf-8?B?WTJ2TlRvVjAzd0Q5ZHZrNEF2TWlHV0g2SiswbEZQdFZwdlNVQzVCMlJsYWpT?=
 =?utf-8?B?cXA0VTlYNmhFaDdibHlIK3ZxMTZuRHFXc29jSkl1Z3Ntdm9JS28rdUs0S1c2?=
 =?utf-8?B?QWpNREZERyt3ZkRnQVFEdGxTOWRzbW15VGVJajNNOUU2TXJJa3h5QXRvbEoz?=
 =?utf-8?B?Rm5PUWNmZHhJMWJjamlIOXdGOTNiS2JrWTFLUkd2MkVXMTZRNHNHYkNGczBW?=
 =?utf-8?B?Y3ZiaVZwL1pJQmxyUDFyOEt6UXRNNllEb2k1Wm9VUm1aSU9uVStieVZRWjlN?=
 =?utf-8?B?RkZjUExOSlFQUTZYS1QrdlBNQVd0alJoS2xsdUtQLzdnTXJPaUJFK0szc1dz?=
 =?utf-8?B?OGRTNWMvYkY2dmxaK0VUenRtdDZacUplK3B5L3RsQ1JlakRoZmFvcTNEM3JJ?=
 =?utf-8?B?a3ZSZ3I1TVgxSHVLd2UzQ2tZbGNOd2V0b1c4RVVWbUU4dDlUSVdsQVNUWVRi?=
 =?utf-8?B?SWlQcXpZR3ZSSzlOeXpWeFQ1a2lSWkwvbEFGR21KclRkUmQzQnplYTlUcVc0?=
 =?utf-8?B?ZHluYkttUXdHUThFeTgrM3I4L3NXcWdQY2czMlBISXh5RHQ5aFlEMDRtTUdu?=
 =?utf-8?B?L21zUEZGKzBnS3Jtdk9idGprRWw0ZFBxeFhPR1RNVHlUeVVDNVdCSmtKcGtS?=
 =?utf-8?B?eTZqL3hENFNIUHBDS0hCbUxRV2cyT00yRDNFKytCbHZKNnNkSVo3WGRxRDVX?=
 =?utf-8?B?TW1mTmxNY3poL1VXUVJlcVRBVjR2Z1RrcXV5N0NqNVFSNFhWVlVsSytOSFkz?=
 =?utf-8?B?d3IvYlAzaWRGNmtUTFo3ZlpRenJjTnE2VzQrOVUrYzN1MEhyZUVwdnVMK3dW?=
 =?utf-8?B?WEtmektKdjdwcDh1cWNPZ0FnMlFxZGNmdmlGY0tyeUJJVG1FR2g0djhiUklu?=
 =?utf-8?B?Z3h0MGJkS0lSZU1vcDdqc0ZxMDZiaFUxM0NDN1VLZHFUdUpBRERpbVREYk90?=
 =?utf-8?B?VlB0Y0k0L0d2UGpEOXpVTnJDYUNidlJxUnNvNDh2MUtZV2pxUkdpVkVpVEFP?=
 =?utf-8?B?dzEwS09VMk01N2NEREFoZG9TWmNwN2JoRm9rWmp6QndxSGorNUtralA3akNN?=
 =?utf-8?B?MmVlRlpwMGxFdlBzVEhKa3NQeTZGTS9INVdJMU9WZWc5WC9rTDMrUzVYWnhK?=
 =?utf-8?B?ay9NRUUwSWlYSEc3S3RMNGlPaHB3bW5YditpaTZkd09CTTAxNXFnZ3RzOTNv?=
 =?utf-8?B?aUgrbDhmR2pQcTJoMnpMZzh4SXFNNkI2TEpBajZlSGNEVUZob2hQZWdQZWUr?=
 =?utf-8?B?NnNEQ2hYWTRuUEdvSUpkQmYva3hXelRwWE9PeDdEOEt6MXpoRSsyOXhON0Qw?=
 =?utf-8?B?OUtlblZqcURmUzRPS1A0KzN4ckZvQU5oYVN4U3ZoVUpLMlM4ZTZ3emtEa1Vl?=
 =?utf-8?B?bVRHQllKNUVYVGM3VFJxcTZsck5HSXFTUCsrOG1neWlrRElzYzF1QmpFRlAz?=
 =?utf-8?B?WnJhQlYrWm1xTURTdys0VTRqVTBuUXJMVnZ1ZVBvc1RZVTNXOUxHSUVIUDI5?=
 =?utf-8?B?cE5PNXdlaG45K2d3Vi9HNzU3NFRqN1hmc3BhdzVEVFVmOEsxdnh1RGpGUW1p?=
 =?utf-8?B?ejNWZlE2dXlrR1RWM1dGOS93MDlUTTJydWVsTXdkVUVWWDlCRlVaK29sdUdi?=
 =?utf-8?B?a0tFdU5lQzhBbCtxRFFDZDlVYjBvUGp5eEFpeXNPN2dRNkcvQjc2MUw2d0h2?=
 =?utf-8?B?d3dUS09jZzdScmgzckRYTmYzYVJrOURrZ0ZweGwyQ3I3a296YzJHa0RUUkEx?=
 =?utf-8?B?c0laeVBLNXhxN0RvU1ducktxL0tRY0llUVNmQTBlZW5YUFI5SUs4dVVqbHhs?=
 =?utf-8?B?cmZUakE3cTNqZWs2UVI5dndOR2pGK3lERWdYWjBxTy9Ubld0VHNGeFFsUDhM?=
 =?utf-8?B?UHZ2TXRxQkR1S0xhVkQ1eTJGUk91SFJMNHdXRVRwUldmdXNpc05LNnFibWYw?=
 =?utf-8?B?VVY1TTV3ZWV2V0FWcVFjZXZ3TkJSQmtOY0svajd5OGtEN0N4WXM5WGE4eTZK?=
 =?utf-8?B?QjZ6YXVWRVh1RzkwS3BFdVc2eURjc05FNGZWbjlzYy9DVjV4dXJhS0tXU1Z2?=
 =?utf-8?B?WHRuMXRIaVZVcFROODZZM1pxa2FPSS9MSVpmSmhsZUVFNFY3SFprdEVvUTZW?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d350161-6fa2-49ca-a231-08db3a914702
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 13:33:04.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi3PWRWsTr7aMQg0T7pOBAh0dzB8cbehhUCMhPihDroGqTia6unvYKTsFMncgsgu1Jac9iUT6n2XeXBDYeZ1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6314
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Apr 2023 13:33:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11192

On 11.04.23 10:25, Jan Kiszka wrote:
> This is the first official release of isar-cip-core!
> 
> More than 4 years ago, this layer started with the goal to model the
> Debian-based CIP images according to the generic profile with the help
> of the Isar [1] build image generator. While the first commit only
> supported the BeagleBone Black, we now have 8 targets for 4 different
> architectures. The user can select from 3 different CIP kernel versions
> (plus an upcoming one), with or without realtime, and from 2 Debian
> releases (plus sid-ports for RISC-V). We have support for SWUpdate
> images, some also with UEFI-based secure boot and encrypted data
> partitions. Moreover, we and can add security and CI testing extensions
> to the images.
> 
> Looking ahead, the next major step is adding support for bookworm which
> will also allow us to reduce some custom packaging again as Debian
> picked up where far isar-cip-core had to fill some gaps.
> 
> Last but not least, thanks to all the contributors so far!
> 
> Alice Ferrazzi, Chris Paterson, Claudius Heine, Daniel Sangorrin, Felix
> Moessbauer, Florian Bezdeka, Henning Schild, Hung Tran, Jan Kiszka,
> Kazuhiro Hayashi, Lad Prabhakar, Michael Adler, Nobuhiro Iwamatsu, Peng
> Qiu Ming, Quirin Gylstorff, Sai, Shivanand Kunijadar, Shreyas Karmahe,
> Srinuvasan A, Sven Schultschik, Uladzimir Bely, Venkata Pyla, Vijai
> Kumar K, Sarath P T
> 
> Jan
> 

Some additional notes:

 - Please find the isar-cip-core release here:

   https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.0/isar-cip-core-v1.0.tar.bz2
   https://gitlab.com/cip-project/cip-core/isar-cip-core

 - Missing reference [1]: https://github.com/ilbers/isar/

 - CI is failing for the release, unfortunately, but that is related to
   RISC-V being built against unreliable snapshot.debian.org

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


