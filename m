Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD31C25B76
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 09:09:06 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.64])
 by mx.groups.io with SMTP id smtpd.web11.78801.1717405739954836586
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 02:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=E7oSiPHt;
 spf=pass (domain: siemens.com, ip: 40.107.8.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvZj6duYw6wt1lCqlOrp+p6A/jvHsEPDyvXk4vz2u7hnhmSM5nSCPCC8HuLy7iFaqw58IRKxpT4laAuIaaVR2lHSiea4szNWWZYf73foAGyHlwCqXdeUI/Eclum2I9+n7u3gjnohO/d/CvySEkzhQY+LhaOJhB/XQm7rZozYYPcNTrAy9PzBZwbhnfrs4q7QtG4pyV5w00N6tX4vN2/j8aqLzrR9II7ox1z7Op1qqnbH+Yx8grnRyTFqN//4zyf+KEu/GNKEIpVZdMDEEAQjCJHpOK37gt8rh8A67YmWWsKYpPL7j0MTDRBZwOliF/vYHbClHX44zYsnx1mvN+pchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfIT3DErI8UoQRK5/F6cBvdGOVZPsvW7nB+fjzbKlRc=;
 b=CDJ0s52ztEHtnnHIxyPxnUHOS20nRcf2pE12qG1WtFzjsutiBaAxGbtIat96o+YBBwEzkTdriLaQsa1Aptjm4jU9OE/maCk2+A7cgEeFxiyO9cj2Q6vDTKUvhOC/KIeaeoT8g0qQQWzxN2BClAzOxLK9vdn9yFWbzk4IQf6JNCmHfQbmzx+kVbYYlEZAseGyH7omYh64yI+1J83LC7anrALAszN2OlTmgzkArVljX9pqPqnWL1kruAOPxKwiiBAZZsVUOnapJ831crsNSc5Ifvh748IGrx1kC85LjT/hruZJ08ilNdmEeq9dbI+GgBB/v3w1qsCRj3O4W9v0iF50lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfIT3DErI8UoQRK5/F6cBvdGOVZPsvW7nB+fjzbKlRc=;
 b=E7oSiPHtOIj2v03sX6Td95oBGyTJFhFuZ8Df9cqrvkVTHeqb8VSPZrr12DOpA+b7b4LCee3vt/klLkt/+pXa/5dsOvk0IFCiBFOyEuoXS3zOjfubx3s42BsqgM8d2r6sD6/LXC4bk3m9SoWt5aIUI7BQWpN0NE+KOKQR64M68r8gyczY37O7+focZp6d0lhR09gPr/5dkrmad6WhdouiUBccGNmgEhzIz4ddDuIT+EgML5qWeOk3+rpvKe6htpnCIFGqAXSyS/AS6sXZNkz+iCHdgRmbW4yfHgw927B0SKPj7B2KJ6fzYhKOR4IFzpJvCyu2xrpb1wLlASyZsaJmbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 09:08:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 09:08:56 +0000
Message-ID: <9f1638f8-2f94-4b3e-bc3e-4871f83c6146@siemens.com>
Date: Mon, 3 Jun 2024 11:08:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 0/3] Trigger CIP Core testing LAVA jobs
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:610:50::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: b8640e44-295b-42ae-868e-08dc83accc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjMrVjltUGxFUmdqak5RZ0xzSVRuTkFndnBYR3VUc3laNnhYSTgwWjhpRWlw?=
 =?utf-8?B?dzU2THA5UmVLT2ZzRE1paFJ4ZTI5TS82MXc4TVJFRFM4ZzJrTTM5VlpaMGtu?=
 =?utf-8?B?TlhiN0g5NTNwaG5ibExzQ3FqWGZ0UmladFZCSzR4Skc2QnF3SmVCR0Z6TXgy?=
 =?utf-8?B?a0hveWF2RGJDQ1FtdHVrRWZrWmtVUEhBVmJXT2VnY3kzTy9hQ0xJbGkzL3Fu?=
 =?utf-8?B?dUROYjA0eUFxSk5YQzNlOUFEQ2NNM1FhdGh4TFIvWFZyMjFjcXVKdEZWNHN0?=
 =?utf-8?B?aFdoSWF6dyswZEdERGliSGVBR0U2UHFnQkMrclpTS3hlWWlKOVBWMmpwSTA2?=
 =?utf-8?B?TXZtNUpBQTYrTEl5Wjg5aFBTa2hoNEk3V3JFZUYxOWR2ZGJYendwZGJiUnFl?=
 =?utf-8?B?TlMyVzVGdkIwcjR1OGRJZUNUNmN0VDhFTGdYRWkwWVhoNmNHR3hjY0hZeWpK?=
 =?utf-8?B?UjZ6RXgyZElXblBsTStGZ3d1SnJ1MWdoclhOTzdZZEl2enRyZWRUMUVvcWxr?=
 =?utf-8?B?YzJUN2JwL0s3SjA0NmxTQ1hhMHBLQkRBckhlcEplZEVVT244dnNBTEoybnhZ?=
 =?utf-8?B?UVVFaVZUZVJUUGd3aVQyOW1qTmVIdkNMNFNIM1AvM0FvOStnTW1aMmdZem5L?=
 =?utf-8?B?eGFMU0JRWEJibXlTNUZDTW1tdEErTTh3OC81UWJyMU9LV1FrSEJBNWM5ZWFK?=
 =?utf-8?B?Y3ZUTFJsZ1M0SXlZTm1iaTF4RFlOd1ZLaWRkWmcyaGdPTkF3amI5aVpUazVm?=
 =?utf-8?B?cDZyS0tNM09MeFhFYWl6aUxhMmI2VDl3aWc2eWEzMFZHNjhvcmdkcVRLL2xN?=
 =?utf-8?B?NnY0UUI1MXUvMm13RXU4MWN2MGpUODZQdmlWTUlvaUNpV1oxTEtraElCcXk1?=
 =?utf-8?B?QnJrTDR5bFp3WnkvTEt3VEo0Z3VTMnhLdHVHTWdsZ3VUZzNJOVlqdnNoS1Z4?=
 =?utf-8?B?NmJ6T0RmUGdPclBYTFZsem9Ra3ZVazhiSmlTSnpBaEZ6aEhzQURGZHNwS0t0?=
 =?utf-8?B?V3FjUVc0cWt2OEZlanpIeFdGWUk0NzNNWFVUd1NOSEJKVDJ1cUhCbElmVFhJ?=
 =?utf-8?B?K1RmQmpKTHl6d0RidEFRVkRwR0FpRzBidlBaNjNNWVYyQ1gwNEh2M2g1cFl6?=
 =?utf-8?B?bkE2ejlUY0Z2MVZUa2M1WnpHT3Y3TlNHaFo2cVZjUnU2QVdZZWFzMHYwaS9D?=
 =?utf-8?B?dE1KSkgwbzNNTlN2VUFvMVo5Uk1Zc3V3NllndlBSRk9uUEkvcEErbjFNeXJ3?=
 =?utf-8?B?M1RjaWNjYWhTR1hoOVZ3dUNoRDRJVWpSc2NCT1BFSEcyRUcrcy9rajBHY3p0?=
 =?utf-8?B?MDNlSlN5WVVpcVRPQ2FXNXRoRW9kOFM1ODJsSXBPUXJBWTRpUFVnY056djNT?=
 =?utf-8?B?bjlTcU02TG1ISitqU2Y4SHhmMHlSUllKendHOVlyeTQ4Sm91alFDTFNsb05y?=
 =?utf-8?B?L3hXWWpPRkt3aEd4Ty9HM3FuUVZnT1h6cXNIRHo1RS91RkFsUWVUU0syU0Fv?=
 =?utf-8?B?emk4N082bGVsVkltd0NJRDJyTGRpSGNiQmFQQTFMSGNVeXhrVUlFZjJ2Z0Vu?=
 =?utf-8?B?R3BMb2JXQnlyREp2eDArd3RIeTZvcVdsaWNmVDdlMmwzR3o5Zmc0Z1JZZ01V?=
 =?utf-8?B?dVJwSy9KL3hoLy84aHNUMTNkMnNmT3FLSnU4VzJmd0VKOEdwby93eDQwMGZP?=
 =?utf-8?B?eU91UXFDNzJxSGpLU3R2Y29mYTZCL1I0NHc4Q21lUllqWGl5V1oxY2h3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2ZDRVZLTGJvanBwdGdSQnVwYVhDQWRibFQ0Nll0NXlyYUZsbEtjV0xLREYx?=
 =?utf-8?B?TVRveEl3R2NzS0hQbFR1VVMzY2FyODRZcDJGZnhuS0ltTnkwandSNE9nZHgr?=
 =?utf-8?B?dlk4VHArdXozS3B4eFc3dFErUU9FM1RHeEhQUEpWSUVCY2ozeEk4YmFrVXFQ?=
 =?utf-8?B?UWEwbnRpRVZSdEhxZXo4aUpkaVlZQkM5b3JFMHh3a1dwcjlwYzNPaC9jNmhn?=
 =?utf-8?B?Vjc5eTRjNThBd0xzQXE3cm9yN0Q2aFpHYW42dEMvSEFIN3EzL3hVY1FWaDBT?=
 =?utf-8?B?SUY5RzF6VGQ0ZWs0RHk0VnZVS2htQnYwa1dEZUNQWjJFMlAzK1hiR3pyN1V2?=
 =?utf-8?B?OE1sWjBnVGNlMXI4Z28zS0lsM0dOQWtNNHFGMC8zVlAzenpudHV3TzJXdXhx?=
 =?utf-8?B?N3hjNWZDV24vVzdqUWZnS2g5VXIxMXA5bTdsSmt0ajROVFRaL2xiTUhDeFdy?=
 =?utf-8?B?OUFHWlY4MnhFVGh6NVJXUTFnc2NWcHR1VHRHazByLzZOUEN5VlJMbTlBSllV?=
 =?utf-8?B?WExYMi94bEhWZVFEYzVwNllaMXBnY3lkOUdaQVJoWkZJUFZDL3U3QjZteEdL?=
 =?utf-8?B?cHBvMEdkUnY0YVJVWVVybmh4SlNaeFFzekhnV2ZYODVtMmVadWtTVE5TeGRL?=
 =?utf-8?B?MlZjTU1iaC8zekFJWi9JYXJqNmpDbHlqYUFNMDJjOElEbFB1Y09id3hOMFcz?=
 =?utf-8?B?QUkrR0h5VHljdFFCTzBkbHJFWWhHTllUOGVKVVJXWjd5aG51WS9CVlVOdFdN?=
 =?utf-8?B?NitNd3N3SExkd05GNk12c0IxMTdaZ3JPRmd1aGQ4dURmVmhtSGY1ZXh4WVQw?=
 =?utf-8?B?Um5zbmlTMFp6SFlRdkhSTGJ5STdqamVXMXQxWlczY1MvLzhGZHp6VXowdW82?=
 =?utf-8?B?TmtSU3pOR3NxZU9zNWd1aFlyTnA4L3hWWkZiMk16Q2ZNVEYrR1RqdXRydjRV?=
 =?utf-8?B?NzB0OXc4amdjaWZhZXRka1FBL1B0UlZ1djBBSjhaeUF5VGJodnFwOEgwdDFy?=
 =?utf-8?B?YmdmSmw1bXRrU0J2K1l2NGdCczRwd2YwZk1sZkxGc1ZnYWFCdENuSmY2ckc4?=
 =?utf-8?B?bHRwTjZrbmpyOCtyWTZrVmQ2L202N21WTkM2SEhhdytNc0VoTzkwb2RJVVg3?=
 =?utf-8?B?bjRZMjBXdFhneHh0Tnk5RzZFaC9sV0tzZzBnS2NZQkJtMUVzQ1VOMGFRVEFn?=
 =?utf-8?B?c1NYN250WUJvL3o2MTVTUjErQk1XcnRNK3JaWHBuRHgzSENTYWFQYnNrUS8v?=
 =?utf-8?B?WmRuNDEvRmhqRHFYem5OUlZ2Zk9NVmhNbHRDVXJvZEZQZ3ZteUpUMjFtb1Ri?=
 =?utf-8?B?RXhWWXcyQlAzNDVwcjNhM0FvdFplVXZGcTNGaUxXYVM5dTFsajNxczQrQUln?=
 =?utf-8?B?T2FTU2NWbWUydUlXallNQVZKQm53VzNiRDdzbWNUMVhwdlV3YXRlMC9FMEFZ?=
 =?utf-8?B?Mi80Tk9WQTlQdldHSm1BTFk3cHl5RVhZQWZPZ2t5a2hpV1FLRGROSlNWVEM2?=
 =?utf-8?B?ajJqRjdnYlVCcFJLVllGUkc5TnRRQkVFZkdtZzVUclF2eFBZaEVTT0dVbktI?=
 =?utf-8?B?bm40bmFQR3RDRmoyMjU0Q1lCMjFDWjAzR2s1aVdmZzRIbTBCQVFkbGxKZFd6?=
 =?utf-8?B?MzhpNDRMdzlkYm80eFpNMWluaExsNkM1Q2JXSXVoNEhsbElxdUo0ODhLWk56?=
 =?utf-8?B?aXlhRlhrWGFhOTNKZTdVYkcvQ3FGOU53UEM1NE9oK2lJTVY0cHZ6MGN0OXho?=
 =?utf-8?B?MzNMdUp1VGNVZ0J2NEJSQ2Z1MjFoYVVkUmRDMFdWM3dnNFVTb1lmMk90bW4v?=
 =?utf-8?B?RGxsM3k1VXJtN1A3d2ZUS1hFSVFSYTgwYmVORk9UL1lveXp0SzF0OVZ2ZVBU?=
 =?utf-8?B?Zjg5NlhYU0NFWGNuVk96eVAwTFZoam9SK3hvUi9BaTdlNEptdVd5em1XaWZS?=
 =?utf-8?B?dGdnNFZ1b2o5VWlZTUczV1pCeGsrZ0hPem1uc3VDNTFLZi9RdzFTTGorK1pF?=
 =?utf-8?B?Sk1KNlZQaitPMXBYT1BZeVRVdzIvd044VWIzait4aUFBUjFRdG1SZ094eUZ2?=
 =?utf-8?B?K2JxVE5EWjRBcS9ic1l1aXJYTHB5U3YwblFpTEFCOVBFWC9ySmhkRmY3aVdN?=
 =?utf-8?B?ZC93VklScG80OE1WeXI5UTBwTjhtVGJWVjZNemxDdmFuU2ZXYUFZSm9JcEhk?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8640e44-295b-42ae-868e-08dc83accc51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:08:56.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViD+0C+COlAYXAqT/bdKKurfvEyehgGB5y4yqlgeOAGV9D6F7EnbxnfvFFCAheSmFDJWH18ErNtCIZlBTXxiNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 09:09:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16087

On 03.06.24 09:09, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series of patches will trigger LAVA jobs which test swupdate, secure boot
> and IEC layer.

So, if I apply all these to 'next', what will happen, what can I expect?
I'm keen on getting these in before the release to have that validated,
but I'd like to understand where we are in this regard and only rush if
that adds value.

Jan

> 
> sai ashrith sathujoda (3):
>   test/templates: Include functionality based templates
>   submit_lava.sh: Add script to submit the jobs prepared from templates
>   .gitlab-ci.yml: Add test targets specific for CIP core functionalities
> 
>  .gitlab-ci.yml                         |  33 ++
>  scripts/submit_lava.sh                 | 458 +++++++++++++++++++++++++
>  test/templates/IEC_template.yml        |  72 ++++
>  test/templates/secureboot_template.yml |  63 ++++
>  test/templates/swupdate_template.yml   | 123 +++++++
>  5 files changed, 749 insertions(+)
>  create mode 100755 scripts/submit_lava.sh
>  create mode 100644 test/templates/IEC_template.yml
>  create mode 100644 test/templates/secureboot_template.yml
>  create mode 100644 test/templates/swupdate_template.yml
> 

-- 
Siemens AG, Technology
Linux Expert Center


