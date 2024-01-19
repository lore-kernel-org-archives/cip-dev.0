Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC4C4725D
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 16:19:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.88])
 by mx.groups.io with SMTP id smtpd.web11.26649.1705681182022264139
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 08:19:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b155HT2i;
 spf=pass (domain: siemens.com, ip: 40.107.21.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQfwnwSO52qn8U/VkFRpaMoFa6SY5ANPy/bfWeegcf/8AeP0RlK1cbF1cenl/F5mW/ajM/e2ip/xL+wZAGAMtDi30ZsvTHr0A54AZVuGLydIeb65O8LRHXk2I5lYwBMJMKipbd9c0suqBvK/8wESA2rq9XJCwOYymVtQHX9lILIPxd8ygkgkObx9O/R3eXtGh5KcyWyFIZsKQeUMpk77JhjKpw0nLb42JJ3wS9wce9SCm9oI8Ghz0r1DcPJswCSeHL6L4XWclqQ+Vpv/QJXsl5eXW6TXDxX2U0GMyk3Zmr4kh3XUGcj1CvODdZVe4mjQWXt+5P8qmu2K3MHf4/s41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEH80CCE8gRiKhOg+7glVQgkt893z1ax/B9xNp+YJCY=;
 b=dTwF5ernUJ0+PYrCriovqqjNevBvBnWfE51bcneKmkafe59uCEJjR7P+kgNwFSU1fUcecvj37lWE/cylLYzOiIj7YquLzFCyP7XGGmxrEMYt2bq7PCFbf9EOA5aEiw6aQHOlN2mDR6jg5625CHm1/VWHpAta/LkBebhXuzIu2QD1fb/09OPk2qkRO1YgPCUVocGv8+DtQ2ranJyB/LUmfXIktnMSbjob58aLnQ9zyD3Kw3o7ylBtFdlIhpwbnk0EstfGS3CbPLm5TQRAA+AxvCau6KRyovUWYCZP5QQjeJZcS3grEmxcVVDF4oAIBo/IW+HqxeMfi+3G3FzJRqk2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEH80CCE8gRiKhOg+7glVQgkt893z1ax/B9xNp+YJCY=;
 b=b155HT2iXj6orEIZ1GRN6pCjUeBgxXOD2Phf3ancbY/s8LMJ4kFpR/ZT1YJjtODmx679s/j7M0JpBoDwn07wVEBfxodKucElLxgyV1cnol0RXoNbL41Zu1Li7nOai5hlcsVIqhhjiH1SvJ+GX6Pcc50MwLFZ9DoojOncTYukYt5lNz4w4jhTwc+bBA9dmAtj61/4PTzsmoONo4rBDCiuV0ZIKQkNQjcmsBPnF1s8i/AdKhXi0KQE8AWmowzxi5aOPknA45UtO2ngMvHQViVfeaXxJWxJmyObI2SnQXcGiEuwUm58hp48XjlSG1yHVn/bmc1amrxy44stGgNGKVNmGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 16:19:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:19:33 +0000
Message-ID: <d63c09eb-ecdd-47de-9afe-c01e8f2c6baa@siemens.com>
Date: Fri, 19 Jan 2024 17:19:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.3-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 56078e4b-f11a-4202-ffd9-08dc190a6c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ogBo+G36RqPmkDkpgLpZOERAb6dMLeVUUgdlvvW+YUyihieoHbx0tCdQpB3UYOITwKcTCs9IExGbtH4Y6AjgIcLZvj9lYW3nGv0OYbGWXgSbMSmJGW4KmTeQZ66YMKgJKT6vSO26jpRPAbTeBvTU4lnezZ0oNLXdMiABEQy+5SGAwGITojOBtfTrCDYv6uDwkzvnr2ynq4kezJRWPuEfBFBDe4nJrb5ZjxKnYWIyqa8RYiojQ2ST8crZcmGBvHVV1/TsMai6SL0LzPgF3YydGF9qyAiLrQ20GVrfqHgi4pOmdzBldn/A0KLmrdnPVjaaO24eCNNpoqVER/5U/J9MXeuHdAS6tQnVuVPrcQYsw4au940VeqXJYwNqDeLofOwCAKs+7E5bws+j0lSuHUg4n4KLXJsg+GAUTd3Ibl3H3UE0SVbIgVZV82DNlBfHbQl7G6iwBFWTNYl1ia7M9eEwKZmZpvu2PeUPqqQxSDqzq8Z0OdwEWVqWJ1U8sddfGIiIpL/36GIesveA5x0+IxSV/+h9xz3Q5BpceY3GFfYm/aAwWahVwIkXdnO+UJIWd4dJiEtnIOcGoHVSCoab/7BGmEcvEudZJnZzH7b2xBVaj4jNp+gziDGjez8B/oouT6/Ttm/H1ns09TM5HOxx+zSIQQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(44832011)(8676002)(66899024)(8936002)(86362001)(31696002)(38100700002)(41300700001)(82960400001)(2906002)(36756003)(4744005)(5660300002)(6512007)(66476007)(6916009)(316002)(66556008)(6506007)(66946007)(2616005)(31686004)(478600001)(966005)(6486002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ni9VN3R6UzF0UElCOTFRNGtRd0NaeWdhWHdtZ0hNSEFiY0VYUXp4UzdnKy9m?=
 =?utf-8?B?UW1Wd1VlWkt3V1BtTnRzbVhkcGtRSUZSdy9Bd0xEcjk1ZEZ3MDhJK2pTZFVU?=
 =?utf-8?B?ZGlnM00xSGwvUHZXUnVJSTVZLzVjTDVuRHdVd0p2MUUwSllrUzFrVTd6K1Nh?=
 =?utf-8?B?YzBwQmsxeWpxeWV5UUU2anBtNUNMSnY5MFVCMW9CRHF3VFZTZGpTMk8zaEZ0?=
 =?utf-8?B?YVA3WEptSUt4bVNHemRaRWFsMk5yZVRmSUJuOXJNN3B2UDZHbHpuMndBTFV1?=
 =?utf-8?B?V2VjcXRrYmN1aWVyUU5rL3ZCUFgyYWJUbWxqbEFvOEVyU1NJMmp3a1VHWFNU?=
 =?utf-8?B?dHVRMWpPYXhOblNMK0Y0TmZiTGhkQUwrRDBTYVcrblh1NmdROVhoUXVtUmZs?=
 =?utf-8?B?LzZjS0ExYXVBZW5SejAwQ1huTUtFRnpQaHNFc1VvY3g1Y2VMZStQVHFhMGVK?=
 =?utf-8?B?VnBBRGZILy9HaHJlblB0OXpsZ3A2SjE2dGN0TnlHRnRoQUJ2Z1ZyNnMvSlhp?=
 =?utf-8?B?YTAvUFlJeXVKZWtRU241blZLR3pxclJ1MW52Umlxc3J2OFFPLzBkaklLdVVM?=
 =?utf-8?B?aWJOa2RwSGtkdGNIQ1lWcVdZb093L2JxR3pZa2N0NnBNS21nT3F6cFJUNVN2?=
 =?utf-8?B?cFFBU1NaV3FDcVhlWVBramFXMm4rRFpEYWNPSnR6QjBrT3hjZkwrVHBMbm95?=
 =?utf-8?B?Wlg1M2NzNk1wcW8rTlBpMzBPOU83dnN0T2psLzlhN0toWGtUckFubjVLY1dJ?=
 =?utf-8?B?MFFoV2FEN2RNdnRlOEhxcHpiYUoyS0p6K29ZVWZKNnB0aEdJQlBFZzRLTmpB?=
 =?utf-8?B?KzJhcHNma2pkVkxTWDE5QTgvM3pHWGFNcjBOL0F6MnZpcU1ZQVhnUVVYU3pY?=
 =?utf-8?B?ZllyQWhSL2RkQ2R3elVrM2JTS3VzVkp6UE1sRG9PZkM2dndXaVBEVS9xeWhQ?=
 =?utf-8?B?RGpvQ1ZxQmRtbjdHQWh4bEt3dHRhNzdHVnlRZnMrSTFDcXpmR3ZTVjJvQWRE?=
 =?utf-8?B?RERwdGttWGVsTThmQ25RM3kvSURHTnNRdVVmWUEvcWN2bjlWYU9MOVVMOTd0?=
 =?utf-8?B?QkI3cTBDZjNqSnRYU0c3OWxmTks5bGZoRUYvZVAwcjUrLzNWanpEM3UxK2kr?=
 =?utf-8?B?UGlhK0NySTJNckFVK1NSWmVUNVBkSUJUSWlSWHN2VlJuVGxtMTFiS0hmUmpT?=
 =?utf-8?B?cWtwUnFGRFBkTExIMDRvKytBZjU5dUF2L2tJWjBOc3RPRDIya1JWMDJhRGtK?=
 =?utf-8?B?N05YaWVZbmZiZytTQStIbHRmczBhQTVMUDhIaWZ2LzlOcmZRaEZ1SVY3aDFm?=
 =?utf-8?B?TlErTDBMc0Fia2E3N3lVczQ1c0ZoQWZ3aGRsUnQxRC9MWXlnaTJwRHRpS0tr?=
 =?utf-8?B?ZlZKVFgvOHhFc0w0ek5LZTZub3B4TFk4QjduTDArRFMvTkR0OHJZTkhVc3dw?=
 =?utf-8?B?N1UyTzV0bkorZ0Jkb1dtWk5yZk5xZ0tyYWJoaGVJcXJBMnZlRWVUdUhSRWh4?=
 =?utf-8?B?VDNVYjhXRVlMeGJmUEVaTEM0cXhDZVhiVC9mVXBFZE9Lanp4RGQyeWYzZWRy?=
 =?utf-8?B?cUtJT29zVWFmcXl1Mm0xTmQvQ0h1eUt3S0pDYzJyd2hka1ZzZWJ2SkZYdytB?=
 =?utf-8?B?RGxBd2lRU1pwMEc0cmx1R0MrRFpWK3JPU2VtNGRwMitGQW4yNnlRYzdNOUNZ?=
 =?utf-8?B?LzNhWVNraVdJbkVidWZZMXRVVjVzblhNRGFpL3BuR1Q5VDBiUWtmUnVIRVZL?=
 =?utf-8?B?dEdRZUN1bWlGazAxZFRnWHZJbGEzcHRuREVpUXoyNGJJeTIyTGtoVnhFUk9l?=
 =?utf-8?B?Qk5ORzJLbEpuQnNld0lSZ2xxK3VrNGk5dG9aTWlXWmt0OEYyd3Nyb0NiTElG?=
 =?utf-8?B?YVhNaWlOcjZHbDBvazkvTzFwUGJSdE1VUnBtWkpsL0JoZ1plb1U4K2VLRDUv?=
 =?utf-8?B?SFhWbWdKMzk0dERlTGxpMzJ5bmx0QlhJTHVWUUtSSzFKVzAyVjZTN3BRbHo3?=
 =?utf-8?B?Yk0rbVFwTUpJOVUwMmoxV2hwTG1Yd2NVb3pxa0dMdCtHa3kyTTdjS1lNVk5P?=
 =?utf-8?B?LytuK2VrSjRNSk1uYXBRWnJkNFpXemcvdjEyZklpM20wSXFVK0VFYjlOMGk3?=
 =?utf-8?B?azJsc1ZuMVZJUG9lMXJqUDJBbWNKb05odHdadEhBb1UzNm9ETGZTdk5LaXFn?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56078e4b-f11a-4202-ffd9-08dc190a6c3f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:19:33.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+hsFdWW5XTeQHu8F/HqEo+1gc66BQjVj5UzqLHUulaOjJqC4LhXfdIyhXebc0FhZT8qfzi+kBwjZMUGUzU0jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6986
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 16:19:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14428

Hi all,

this is the first release candidate for the v1.3 release of
isar-cip-core, the Isar layer which allows to build CIP Debian images 
according to the generic profile.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.3-rc1/isar-cip-core-v1.3-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.3-rc1?ref_type=tags

Pipelines are green again - except for the usual suspect riscv64, but 
even that is much better now. Please test everything and make sure we 
identify and resolve any remaining bugs before the release. I'll be off 
next week but would pick up the pieces you find and submit the week 
after, ideally doing the final release by the end of January then.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

