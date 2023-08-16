Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FEC001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 07:54:37 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.62])
 by mx.groups.io with SMTP id smtpd.web10.156224.1692172469965650018
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 00:54:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=br7xGCoW;
 spf=pass (domain: siemens.com, ip: 40.107.105.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3hSqNqQyxrKmxe64lpNeWUp7ftv++GC2M7gvC4DpX7vgMVxyew9qRA5ILKlkKDkRLckg/VneuEKctFbpnCjRBjgvXe8zm6pmHQnw3w1UzchL0fvH1zwtjSbHKtKfQENc/IPWGMQGPRBkG8jy5e66gJhrKYOaiDsAYkN7F7A6FXasbIBxjhmwqD2kBGtTs/UmWmokRp2kaMlFarVJz3ngqIG6A219xKqSO2iII/wKiZeyTxSHuwtJCizJOFH6oeCjRSbn1J21VGLfz4mOc57zNDVWIaIF5agWRWDvpHok2g2f4/PUfesOaucDYhhfuqq3Lt2nptOIkWuF5khyHsnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztxOYND9ZjmH0XIsRlIsoDjHZetgdF3ZlW8wYkYne6Q=;
 b=McFQmUVr+b/a/JH8/cfBPSv9ftVpIuAUGW52PZHz9x6EG+AEWjd++GSXJv+5/jAkzyYASu/ShoyOvfvaUuqR3K9oYZ/ihNpwD983YGIEiHQ6ofU7wvuq3DixeGrXsRM0Vx15Z1/oBotRSJ6zKgEHfSPQdtu0gUiYlC9/PnI3YnUdAf662guX93Qt/2ULP1dbvKyio6A0o5LuV8WMlpVJTj0B1Opp6EMPTymfBTLfr7GMn3awxLHM9adqVbROvCB+KHy/cx6I2FNHiAyKtsn20E3VJa+WoYoH9MeNncnj2GwY7AX/DE2A0Is+Hk6DJDSL0nVrnPwsBt6o+s4cI01Fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztxOYND9ZjmH0XIsRlIsoDjHZetgdF3ZlW8wYkYne6Q=;
 b=br7xGCoWDfg7qXK6cOj/dK82ILJCjCJ/8veLbB09/oYbH0TW207depJuE8SizFIqdsqAAe9ruMqtKmf8mCsSonbhUmIYRHentUYn0C2SgUHZO0LEOZ/36h6f2GpoXzetWoA7zXKeJmCsokF/rgxpagPsxLj3igW3bp3/0HRukukYlF/YctCx3FMF1k5nkOphdwcUVie7cCDGGeXay+I0izGBIy79KI7kvbQM+y3E035p5UdfL36LhIhc03+ptyQpMKyk2epQDdwVEHFSsI1e8Fea7Exq+Lyq7zeNPR/i9OQ1ePTJ3/XkLyv/XxOunHPgZzB/lrqhQmRXeV6l+Zw3gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:54:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 07:54:26 +0000
Message-ID: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
Date: Wed, 16 Aug 2023 09:54:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Problems with git.kernel.org snapshots in CI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: a179c740-bcc8-43e0-0a6b-08db9e2e036b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CcmHMxLhKrOFJAU99MF6Lf3DlDauKetFlrOnvWPoSH8y8XF/xF0Uj21Lu7kKxeAJ+X/u10rXbJkuNTDnLXZDxayCjl7fAV8RAmXxFGu4O498jl/1WAMvjCsejcGPrCzcYLbq+tHfO1HKkPP3t9fd9EJODmGe3SeOo8TtXtaZuPEi66GjOwSEqz9Pm7Zg1yN2ykEI8kif4fRIez8Q7NYKjOJnTA+ge6+XvFwjQF9QMWeyKIkgteonjwpOCOrje+svD2TlbIFoYLavG7fOSz/H15FjTiJMTru6LasWXf3d6ucR9YbvtvHjBUNGFXD0KUXQwrgF+SyWq3yWAFtcyDToYy5pW30SzwoPXjmnEZ5/ewLED7PNAODBSmvpgeVoBJ+5VshA4dhRe/jAyuBKsa6rpGSZgJo9ObWgcOjKn7l1GIaMONeyRVsvOsB584INVXbPY4KqaHMEC08o+13hiybFtzsVs6ZOsNWhbbV/7gOY82hTlT8KmOb2TJspK+tqWxPwsfVSk53JJxuvTgRNzRo1s3jC9bsJuNXDkLfLwy2JraDmrnYrcOPpbKpXzfV+vrSResKFh0TAdMFPskX7wDwVwTK6gPL4xP7AIZhp3keUKvqRODgpDmsaA9RIeoDHNufx+8NIZ0qG488AA8iZl/Xinw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(966005)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(44832011)(8936002)(8676002)(38100700002)(82960400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHladFJPTW5jRWl3WkZpa08vdHN5MTJNaitIVWljSm9TckRlMlVjWE15VkpL?=
 =?utf-8?B?dGoyY0VIakViS0lvaW1nZnlPaWcxVS8xTXNmRlBpTDNaVmZQd2pxa05LK2dP?=
 =?utf-8?B?VHVtZnUzY0MySTJuN2J2QTk5Vkl6UHlWbEk5SFl4U0ppVFdsUmRlU2hZQXlj?=
 =?utf-8?B?MHRxZDI2MDdQWlBpUnJOSDhFckRUVTVZSFRMYWNIWjk3MEFFVk4wa3NsTXJk?=
 =?utf-8?B?YXRMYU5oVkRlSEI0aksrQzU0M3g0cVduVldBZE9sRlU5UWlxOTZYb0RneFA3?=
 =?utf-8?B?eUhDdkZ6ZWZyK2cwanZuR0UvRFlibWMrZXhham5jVUdvMDdIRkhYYXpOUmFX?=
 =?utf-8?B?QVF3R1ZZOXR6QmtSWHNwdE9GSklyeDNoejIxWFNqdVBqVmwxdWdlbUtXZUx0?=
 =?utf-8?B?N2hhR2h4dHFTVXhCM3ZUd0FQaytSMDFCVjZhUGNxVkxPaldVSXhvVGRQbEln?=
 =?utf-8?B?N3NLVmxpNzVmMmhUQ0ZaZjFQelR5NlBIQlVrR2p3Q1dOVUI1VGRIRFV4VTRO?=
 =?utf-8?B?b0dYK0oyaDJLK0pSTVdYNnlPQWNjdlBoMlBudmo2SXZmbDdsa3d0Zlh3cDVu?=
 =?utf-8?B?NUZyelEwc2hVOXc2cUZDUnovUGNsS0tFQ3ZQakFSOUhpcVgwZkFxL01VMXZu?=
 =?utf-8?B?QnhHMlRxTUk4QWxTbGNScmpneEJyL1BDWG9CUVU3OTBxY01VWm5QeGQwSTdm?=
 =?utf-8?B?cHlhYTF4NzBpNHpHVE1ubDJ6ZGlQeVVhODg1N2ZTOUxkeDAyMXhzNVp1TkVP?=
 =?utf-8?B?Y1Z3YURpbVMrdlRxeFVDenY2d3BJa0U4QUVCOVZ3dUpqZVdnSDFmZGhoT090?=
 =?utf-8?B?a09tMFh1RmFPN1U5ZnpUL1UrbzU5SGpUZklabXZCTW13bFltSS9FWnY3Mmli?=
 =?utf-8?B?cENLek5qSUtTU28za3JZZVNGVGdSdk9yTldoMU1WNEl1WnJDQ25GNXVIbzRO?=
 =?utf-8?B?aHRnS0k2ZjN1dEZFVHZNSzB6dHltSWpweG1BbE04NTJGYVdpQkV1eEhUZUdr?=
 =?utf-8?B?ZWtVUTlDV1A2Y2xHU0ZURzNoeTdRTDRqTnU3UEh5dm1ROTFSVHFBUURwa3lk?=
 =?utf-8?B?dUpOaUtlcHROWVg3VUVjNjd3a3RpbkkzV2JxVURvMFVFTWxrTjU1a1Zva1Qx?=
 =?utf-8?B?ODg0WjRDWkFBOGgyL1k0MHZhNi9keDFLdWZXT2RiZG1FOFp1d29mVTkwNWZu?=
 =?utf-8?B?Y0JLL3JLWjhwdVEyZkZTd2ppT09KV1lPZ0piVkJqNVFMUU1Hb1VGOC9EMTdO?=
 =?utf-8?B?YUtvVS9oMjcwaWtwY0Ywa1ZpL3NoVVdHY1RwNVFLKzd3UXlZZFZQblErQzFX?=
 =?utf-8?B?c3NOM1Zpc2Z0VXRmWGF2UjZmdkpYMXdLQjhJL0lIc1Bxa0pkZVpraWxJQTBK?=
 =?utf-8?B?VGQzL2pReVVmbXRCWVlrZlRQbG4vSTJldGpXVWMwenZDRm5VRytoZXVIQ2lY?=
 =?utf-8?B?aFhQNXljbGxLdk53Vk9hTkl1UHNmVW5Rb05ldWZRT1FlQzJpcEhJM3hDYnVL?=
 =?utf-8?B?UnRmTjdwK2IzOEJHNG4ybXNISDhFZzlkUmF4ajdMUTF5WnJnU0c4TWltU3Fp?=
 =?utf-8?B?YVhCK01CcURZeGtrQlhKZUlnMXVvemtlUHVXSmxnS3pwWmVIRXdHeFB0bEhH?=
 =?utf-8?B?aWk4YjAxbGp3UW5iNkRxdmpZbFlUVU52SVRWcUc4K2x1akdFaXdVRVJHUTEw?=
 =?utf-8?B?VXZnOWxINE81VHBJWHZuNGd5eGU5bG5aQ2hpYlp3bEtkMitVVFBmOENLeFMy?=
 =?utf-8?B?Vk55dTNjUDRCWVd4RDh5Y0VpdEZLU0gwUENmNVJMb0gvNytBZmRlcXcvTTdI?=
 =?utf-8?B?LzZkVnNCZXBnQml2YVhGN1JuOTVTaHJZbEdyR1VwK0xyVFpZZ0FMbG1TRXEy?=
 =?utf-8?B?N1gxLy9nRTVjbnhFejhIY2wxSWVhRjZZM2FnbGo1RXFRVmt2MXZrSUxDNE1w?=
 =?utf-8?B?anpXYU1MdlQvNDBQL21VaWhGUmlRdjBzMEdJRHowaGk4TUVpdzY2N0hYWTJF?=
 =?utf-8?B?ZFNQQWRGTUp5UFdpTWVwUE5oaDJrOFNiQ1JtSGxVTEtTbjVUS0c1aVFIRVpx?=
 =?utf-8?B?V1M0Z1V0Tk1Ic0Jjanh1WjkxejczalVBQy9CZG1Vc3dYWHl1Nkhod3k1K0ts?=
 =?utf-8?B?aG9oTEdEZnZZSzNxUkt6azljWHFSMGZ5SzhDeTh4dk5JR2d2bXlFQk5pTEZ1?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a179c740-bcc8-43e0-0a6b-08db9e2e036b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 07:54:26.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l78Qk30P4d0sc24XaP9YosLlZJdQNTHTZLDQ8xnCH8LyyfJipJTb+z+L0Og7jPKeJCckYnfuVkZDcOq48ixKoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 07:54:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12660

Hi all,

isar-cip-core jobs are frequently failing due to fetching issues of
archive snapshots from git.kernel.org, see e.g.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4881160724

Retrying those generally resolves this again.

I think we tried gitlab as mirror in the past, but that also failed
under CI load. Do we have any other alternatives? Would it make sense to
make the tarballs as regular downloads somewhere available?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

