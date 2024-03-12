Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDCC54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 08:40:47 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.84])
 by mx.groups.io with SMTP id smtpd.web11.3950.1710232846482682202
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 01:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CSi4LV0D;
 spf=pass (domain: siemens.com, ip: 40.107.6.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC2KCbOQARJv7pHHoT62rOyuyah9VXF8IouzbNZxJ8y8MZ1xtpXNqVQ4wT6UoQq5LmzpJ1TpUPxk57BiXgtUqbl8t4rLT7XluRAKZkPi+zsDhgiVCZj29w0/ojcrLEzEodOsVscfyNCZKLZgH5GeZP8SecXPfwsaVbhjKblCiWZdNppY25c2Ox+kSTm7TddonGS2GD7TV4iJGp6+qirfW9EXzysasdBreQS8e5QyoBewZHMwvgkPJbmhbtvLjMh9o6A4W9b0ggsHbJEB1eMAnZ6/85xdcDWUWIxYFHkBH0BLQIGs1xA6JzcrjtfBm8YGZaTNlUC+M03xVMpTCH0oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2S9FVl6ft+NzFVRZVwQ8cqD9CRf0l2zsNemdiQvb/0=;
 b=UYIZ5jONf0NhAPZf7O+eZwgKjeMhH7z6Lz0TqOoRnAkiSewbeT67W75jLtwV6nwBkrvwVfU1TZ36bFT3tWbKM7ivX/w6tiT2i28I5jNNiosMhWNKHEfMYaCodAgWZuKTwBkhs5jxbhdnH54fYQdWJ9dm4o4tAM8yRlGlwATRRw9CVDWjNT0rFEcU8jcr5z+5c7ysgEF4MSUOgZFXOTTNpa6CCIyF/dEwDzKRL9K2lTsAm+ZZGDY/kH0AnkjLvakvSN1w/9Js9D9ghrRTID01jZ5xtzYH5Dl7B7wkCM0VQqI1eiFI5aUsHbwHujemHnrFNEPPAwjAOK2PR17cBmIAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2S9FVl6ft+NzFVRZVwQ8cqD9CRf0l2zsNemdiQvb/0=;
 b=CSi4LV0Dy4IrM8U9PCicjG9KTuSje+8h5vcFGVz42/fwflUATp3XqTmRqBQ+95+bPcNsvkTxOHa5g1XI7de8OK20cdAion+xbFICgbTmBkP9u6q29nFpJbhgpZtVU4l3Fl8PMs+isHL22tuYsYPmgkl9XO8iF/DhlzBptOIbX9bqxekCCh8hGeBB6KQZcBtJRKibyaegQ2iVhHMoRQYSW3ouocyNHu/cE4BR5hDdlvV+8AxNp0PYRpm5Iu0xzpOCRlVKQOfZQnp8mAbhLFlIE+7jfHwTzlZTP2Vjmz0Kulo5icWtgx7+FAe4qasuDNfqbZffPnfVvnBg8Hz36AiRwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 08:40:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 08:40:43 +0000
Message-ID: <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
Date: Tue, 12 Mar 2024 09:40:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more
 robust
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: b9df7982-41e7-48d5-888e-08dc42701ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M3S84BCVW2a4ZDOOv5r1Koqygc8G4L6Bx+SWXIGfmn8X0W+Rp7+yPuYiYeUYvdivdMsvbV3CGk/6yiDehiA7sbF0pGb27UyESmTt3bTww2opcEPudyrG4dop6RvEFwfL7iS4YGxYluxgzftbAnmjfWxv+k5bAXryWcDW4xZav4aUGLLLzHsY1DWqrwItRa3qZtWpEUimWgnaaXiwYAb0Sz6UsJ15/gri8jGnL9G2KJWKxuwZUvB0cVaUECE8dPa/u3TT3UyQHAxdvTCOBpQoX1JHxAjdw9jDrenEcdRYaiznVr6cBtm0MJQguuNyRLAxx1YgZ4Du/xzQe7NGp0BFKBdQlp/ve9JLcMlgBE6Z3SKKPP5L+5S5wV5XSteZzXfZ7cHbqihRdPn1adgngxkJQvDxf0odvwDFusids6deX60DxE8bIjNpvZgvMlLTLyJwD/ehV2HACUnsF27xXT5pg5cfZswsUYHny2gRXRoBPPVIRQO5XWpYtZsSZeCNAhZ36+yMCgFBuydP8HHJjDE53Wf1LG/k4mMLcgWKjl3fhcYFqseTxIw6yhmvNv4f3oa6wrzcKfg4pAwy/U068lad2iU8skWf57IuP2gvEtyqL81Oz47Ai0Cczg90ExYX5TFjsN1EzDhBx5jsaNm0pjJwFg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWhvdXJCNHVoaVhYbkVwZlljSStqMEg1TWw0YWhkandQb2s4UGMyUnA0QXpt?=
 =?utf-8?B?aW43MVdFOWx4U2JyUExmZHBNanlsdW5IOC9GeThmbzJmMkNLMmVnYyt0dGlB?=
 =?utf-8?B?NGxleWZiR3p1ckNSVkJINWFraEJUbHBhYnk1WXVEam9SZVBidlhIemltU2li?=
 =?utf-8?B?bHJ0QmUvK3Fuajl0TmJTUUh6SUFUQlR2aGNrS3VqbHVUR0pxTWp0VkhLRk11?=
 =?utf-8?B?SkVCc2M2RzdtdzVpUnZqbUk4aG1Iem1UUnp1bUJ0WG5UamVyVVIwdlZ1MEZF?=
 =?utf-8?B?bU9KUVprV3p0RXliL1ZObzdwcHZ1VHhaUkVsWDNvb2lsbjdteHlCZzlQc2RV?=
 =?utf-8?B?WGxuZUVUMUptUyt4azhSS2xFSUlhZ0hMMEJUcUNZNE5YT1QrcGxadmdJdU4y?=
 =?utf-8?B?dHZZWmZuSHlNZVhtY3lybWJpNStBZ1JlRDlXMkVGamcrOXV4L3FoUUpCVFhS?=
 =?utf-8?B?Wi9Oa1REdlFITDVpWDBoZm1meUNQeUd5TzVGUEU5ck9GaWtnLytabzRXdHly?=
 =?utf-8?B?djNMUTNPZHpHSjR1VGt1VEJ1RDZEZkRwRGZFdEQ2MktuQ0pIdmp4UGpXOER6?=
 =?utf-8?B?ODNnQXFSa3lmMmFMS2E4OWhUWEp3dkdrMHBEbnNCZkRSUUdTS01aQ2lNWCs4?=
 =?utf-8?B?b2FEL1RUYVZPWjcrdXB5ZU5GMXVxZG13dkt2Yks1bCs0MS9uK3RxNmk5aEI2?=
 =?utf-8?B?ZSt4TFJ2amVURTRYamJ5SHdxalJpeGRtZ1ZCMG90S0lEb25adDJxWVNHUGhQ?=
 =?utf-8?B?K1RHV3QxekJXc1VzUnp1VndiL05OVUpvd3hnRFg5TXBGb3FBRFpncThuaDNz?=
 =?utf-8?B?RnRiNUt5d2V4ZEN2Ymg2d1RXTURpdStRc2FwbzFDcUMrYitydDI5NXpLSkp1?=
 =?utf-8?B?QXZERjkvMnZicEZrTDhCd2FuNE4rc3NBRzNmWDM4Q1pSMlhnNG9tbzN4SmhB?=
 =?utf-8?B?K0xUTVlPUUV3SkN1OEVpTEtvYytBUGRnSzlONkUrUURqUzJVbjRGWUFnMXpG?=
 =?utf-8?B?THhVWkVaeVA5ZXZ4NnUvY3BsVnMzVmVHc3dOdk5VSCtwY0k3eHBjNnRUWE5i?=
 =?utf-8?B?QTVaTkxBRFFIWTRSUmZKWmVFSUY0cXlNbWVCSFlBYkg3dlVPWnk3TXk2V3RP?=
 =?utf-8?B?VGhUQ2owN205NmJkWE13N3h3VWJmWXlNdmRWVFFNUTNkKytVL0E3THVtVUNo?=
 =?utf-8?B?NFQyQjdxR3p1bUtzR2VvbnBxamVCaWlIZzR1ajhFUVR5T201QVNXY2ZRL0lp?=
 =?utf-8?B?MVNBbTN2MFBMV2F6dUFYRlhOdjRJcGxYRDMzQnU5THAxVlVEakwyek5pcEFp?=
 =?utf-8?B?bWpPZ0ZnRDRCQ1VXVy8zU3BUQy9WRndBZFdxMVN4VHJldHNBMlRXeE1vSjNV?=
 =?utf-8?B?MFl1eDV0RjdHSDJVT29iODZWTHJ1b0JqR1NudXhCV0FIZXZIN20zbGx6K2dZ?=
 =?utf-8?B?TWd3VGlkWDRadGpGNkpEMzZzNEZWT2RiLzV6UzlyUU9Objl1REt0Q29md2NM?=
 =?utf-8?B?cHM0Y2tSeGxnWHhEQVJiWFJmNmR6d3l0REpKNnBkQTlxOGE2V2ZkZkVTSWRH?=
 =?utf-8?B?MDU1dE9VcmN3bFo4TTlxS01FN2RRV0VLbnRlZEoycWpTUWRWWnRabEZYU3B4?=
 =?utf-8?B?VC9EdjhTdkRuME52dXZLNmNKY3NRN1IwZTVMM2o3VGx1cVF3SXdWZnh3YUNp?=
 =?utf-8?B?enFqVlFZOGpIbC94WGR4ak9HeS91ZzV0K1pWSlhCS0JMSXZHUzVCQ3MzdlJq?=
 =?utf-8?B?ME02cUluZmYxbXFqcm56V2l1a2xYeHJaTnJtbStuTWpGUG15OHFUNnk3T1ZV?=
 =?utf-8?B?NU40QnV4dDZQM1ZMRnVJR004SkJoa0hDNEN6b0xocUJSUUV0RjNNZzdDbnIw?=
 =?utf-8?B?MVZFSnlLZnhQeUFKejdxZlY2ZVZ3THIyTjZiS0VRZEJRSXVPalJUVW5Hc0h3?=
 =?utf-8?B?T0l1VVdJWG1CZXFtc2xGTVp0ODdUS21GTDdUN280Yk55UHpHWXRheVNsNjZJ?=
 =?utf-8?B?LzR1cWNkdE5QYXczMHZ4bGFhMkp3eU8rczdVYzNPK3hseWlhZjlLOW9mZlJu?=
 =?utf-8?B?b1ZqUjVTUFlYOThvRkR6a2Nsa0dicFJXdkFuV2NrK1hxQ2FYVXhJQVArZytE?=
 =?utf-8?B?SUlReWdwNEhSQXBUUE5GWWh1eFFjbWJINnFZL1ZocXphOFU0Qzc4Yk1PNDZq?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df7982-41e7-48d5-888e-08dc42701ab2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 08:40:43.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 493EAn8d4bDlBP6owM3xJpmmmo51XubuE6sUukKFWU8mZtstYSqylcQpPBVHUta0MNVDoXphQij3Cfr1kutddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 08:40:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15274

On 05.03.24 17:10, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset adds checks to validate the certificate and key before
> used in the signing process.
> 
> Add also adds the missing Documentation about swu signing in cip-core
> and fixes two issues:
>  - an error in the build logs of do_image_swu
>  - Creating all existing image recipes by touching SRC_URI in a anonym
>    python function.
> 
> Changes v3:
>  - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
>  - use local variable to increase readability
>  - add formatting patches
>  - fix typo in commit message
> 
> Changes v2:
>   - Add information about cpio option in long form
>   - replace cpio option `-H` with long form '--format='
> 
> 
> Quirin Gylstorff (6):
>   swupdate: check output of sign-swu
>   sign-swu-cms: check if key and cert are valid
>   doc: Add section about SWUpdate signing to README.swupdate.md
>   fix do not add files to each image recipe
>   format: classes/efibootguard fix spacing
>   format: classes/swupdate fix parenthesis
> 
>  classes/efibootguard.bbclass                  | 39 ++++----
>  classes/swupdate.bbclass                      | 88 +++++++++++++------
>  doc/README.swupdate.md                        | 21 +++++
>  .../swupdate-certificates/files/sign-swu-cms  | 29 +++++-
>  4 files changed, 127 insertions(+), 50 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


