Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F38C48286
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 20:22:20 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.81])
 by mx.groups.io with SMTP id smtpd.web10.47004.1707078131502689972
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Feb 2024 12:22:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jg3H3MoH;
 spf=pass (domain: siemens.com, ip: 40.107.15.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b08RenKiebs+HTpqh2Q3WzwzX5tRuKyZxJDoanW2FQYQtUR29XILIK8SEfQ8/wfVYwkWDnOCN9U597qb8fnChVwNqxA0hJv6AuIdyZ/I7cT9QKCNyJkD/hp/ENasOpVggMqtes+Gp1Nepr8F2yx4HHdm00kkhaC6LyD6MmP9XX4b/BC5TXNVt921Du7gUvEsdRKRNcLUegN0WKpETX80d67Wt5C4iZJma7VLqIcYkoq4QLmXkXC9rLt0fKhh+doYV5+W1ZVEO1OTJnOKzZYLEOEuWp+nG5bDnnqDxUYL4YFOB2uf0maerZfcQPlmX/MnG6ACoK0X7ANJQ+S0lGcarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPFK6ugP6+bfHRSsF8ANzLTCLZm6flJpWhZOV4/r+N4=;
 b=BV2TBNnksJ/eFBqRXTmbDfpxFY4rorpJ3Ea5v905kxZwMETo+Lw/wuiM70SUmRlhlKpIg+nEs6y9DX/DEEKDKximN4+gnWbICCDtjNVmHLH7g4gUhVCyARg2t+RZPOnezfEEK5JeoHNH+QizeG8euerCScjxJRLYN1zgCyPXdr0f6FmDIgO6LI9TW2hjGgqUFZC70/88PwPbsQZzl20UZl+kxE6ervT3s9tzIq+89Z8rDpLBX+We1iSl8rIYw5NyWukhED15kyFq6Kh2VN/1eSZA8FDCe0HITe2Zw73ylR/iNQ2I5OCH8CWgXFhzA5HYfjOWtSitQvHWDEY2Ba3L4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPFK6ugP6+bfHRSsF8ANzLTCLZm6flJpWhZOV4/r+N4=;
 b=Jg3H3MoHiM6igS9xONBvQHoLQyeBiiDl5EZgJwWDwmJ12EGLAKnkWIWNw25hC68RrEOBesS88M5Vt2HpE15txJooMxsYeqE+aL1u4TnrBbBUD8qVfLRfS7J1jxffDgTjF9W6ecn+Vx39WVdB91cWtPcg88234O5p2HDYTjy1pRuy5k9eIBVQ2xF/acwMLOas3SNZ3k8kFhjf7dmmxJmgN0B7Eo7/w4pDckRzKLEaq7dVS9ZEnU7Pdrf67YMFwHDzfKoPHahoKQxQ3QoUdzhqTKsekDdvCDPtWzYuRRbHKRTeK4PPZkf0R+aTnJvjIwCcHa7OTMr9A7aV//9MA1yy5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 20:22:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 20:22:08 +0000
Message-ID: <f33114db-6de7-4db0-a755-cc4865c851a6@siemens.com>
Date: Sun, 4 Feb 2024 21:22:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] 6.1.75-cip14-rt8 (rt23)
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <17B0A71DF7AB7000.8798@lists.cip-project.org>
 <Zb+BHomVksw/FJtW@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <Zb+BHomVksw/FJtW@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3649:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ce8f8c-b1d4-4833-c835-08dc25bef5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ykFuvf3oYEY4CUdsVPyR+pUzfLYxXMmjlJEOGx8GS5uMIoeNscYVC1CpZk9a+Ws2SnDx5h4O7RnUnp6lYD+UWtZK7hSTcCwI+I4ug0jXUzqqbfZkbxGTxtxweuNWQrXCgxCQsXAcKFYCrL2qyi3mUCt3KBOOXCgxlDwlKmSZY9uSFmx5/Sc44uQg7ueKTRqlu0x90z01+5v3YUaG4sP48qySGV0BGa5kbXifhv8GyXe33A0tZmnMeT0XHUHXg8gPugJr4Rf2Iuahzo3iZc77uSd+J0S5nFuALYqd7suR5touZ0HgmFGnU4jJ3jUnKacpTvIK1033OgzpSInOJaRGY7SI+ET4mYYNNCDX1qzVHwkuhyPe+sdAdroDhf+xrGaeuvW/9cXDfF74GrIA4rFfpGCeM7t70fLO91qJMS72OmAX8ug3bqDy4vCXHeN2zRARqgIud4hYdNT3S2Tu29gHLn+tUf9OUkNWmPI2jQ/gC9Out/EnpVvZBtS3mCtj0rXcxvw/ADHcbKguLVmQDpB/do6NhUuS4EJ8PC6fGW3Yo7c8egrFz4YWr/mMN17GayGTlk7SBTI23ldujvO0Tn0ez0nD63ZjvWjkiTJkrwdqBu+pedqbmQWQcrGOyB6bVExz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(26005)(31696002)(41300700001)(82960400001)(38100700002)(4744005)(316002)(8936002)(8676002)(6506007)(6666004)(66946007)(66556008)(5660300002)(2906002)(66476007)(4326008)(44832011)(53546011)(6512007)(478600001)(6486002)(966005)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHVmdGRkc1lydEVrVjJsS1VhMXp2dWI4d3VGWnpRajZnZFdqd09VT2lia25i?=
 =?utf-8?B?dC9DM2puTDJuaGNYRElpTEtUKzVzdDBYUDdyQkdUbXBINHpveThHZkY2YVRH?=
 =?utf-8?B?cUlKcGtrODhTWHV1Z1dJbFJDNUdkeGJhUFNVSE56Vmt0S2FYWjd3aHRMalE3?=
 =?utf-8?B?a2hqYUttbHBlcUplVUVIV2kwV2FOVDY5T1hkbUxKbk9nczI4YjdvU3RTZERO?=
 =?utf-8?B?UlNYZUpPQ2VBQXJySTZwRVg2MjNneUxycGxaZ01BaVR3QlIxQllxTGQzVXRV?=
 =?utf-8?B?SzNieG9SK1ZDRnhDZldRb01aT21YTTVuM1Nrb1lkUUxrdUlydVRkUnY4enMw?=
 =?utf-8?B?cUhmTUhBazNPWDJ2czZlS0NOUU5vL1RpbCtOVUx3SG1xSlJWTE42VnoxMUtz?=
 =?utf-8?B?clVKUXFlMTFlazFIOTVnNmVUdGErdElmN3dlSG0wVC9waGJZQjY3eUVuRUxY?=
 =?utf-8?B?VG9pWDdOMERnWWFnbkY5MXdiUlY1WXNLaWF0TzJ4WGh4eUt5N3JLWENnUG93?=
 =?utf-8?B?eXRrbU1SVnhqZnUvOE9Dam5IQkk3NkN5K3lnVm1BdG9mcElzaUtWVGZhbXNr?=
 =?utf-8?B?SXhWV1JDUWI4MVNidWdpNW0zSjJ1Z0dqd08xMVVIRE41THVlNGhJM1M2YjZy?=
 =?utf-8?B?am5QYUlBL1JSWERjSWliWUFxd0RreWpmNkR6bGdUT3B1TTRMRE1wK2NDMDEr?=
 =?utf-8?B?RURIYVdkeUwrTHl5VnZISGk3VzdMc0hWcnJwU2VXL2JCMTVvYkFWbXo2SkRv?=
 =?utf-8?B?dWNaUTN5WUtvSjJvZmUyVk9pNnF6MVBLWmFSdEdiM0dXT0ZweHVZaTlaUTY2?=
 =?utf-8?B?WERRRDRRSVpSbkNqR1lmQXpzQzRlT3M0VStKYzZGYWp6WUFaZmxiQ096L2p6?=
 =?utf-8?B?WXE1bTRGZCtvSElkMmdpck1CUkYvbEpBV2Vyb1hNN3hmNWxmUGswTlJMYVVJ?=
 =?utf-8?B?a05jK3EvQ3Qrb1FqWjhkVGkrOVBHY1I0VFdXS0I4d05nMmphMGt1VzRxVCty?=
 =?utf-8?B?Z3R5VkRKRFhaVlloRnQ4TzFydzM0SVZzUTNlUUJmaUYzNEUwOXFIcytrU2pL?=
 =?utf-8?B?L3E2K1lTc0cwUy9JT3AvWll6eGlSY3UxMGpZZVZHOTJGQUtENFdOM0tnWUM0?=
 =?utf-8?B?blcvV0pzcFJIOFBPRkhNd3BSb1l1WFNRdjQyV1VLdlVDenc1T2lxcHliTmgy?=
 =?utf-8?B?R3YrUm02L0NlVUhvM3BzZFh3cm51NFprMmo1VXRtNjJtVmx0UTcvYmJGUVdV?=
 =?utf-8?B?SFVYTElqcFBocjQ0QWlyWmRtNTZqY3hOV1VDRkJ3NlpBMXBQVklscFBEc05h?=
 =?utf-8?B?UHczQkFNZVhTNUhwcnpWejNHTVRFbW5rTXlubFEvNy80c1AxR1hpZUJRYy82?=
 =?utf-8?B?eXo2UzIrSVROYTh4QXVvb2hlelV0ZUMyMURZemlUSGd4Z2RPVEZTNlE0Tk1s?=
 =?utf-8?B?NS9HQVQvRkZrWUJtUWZRN09ydU92RXE2K0luT0thWUZnTGxpeFptay9sczdp?=
 =?utf-8?B?UGpiQ1BVeFpkdFd1RFc0OWs5RUNuTlNNREkrRVRjMXN5dlI5bm9QcTVrNXlK?=
 =?utf-8?B?YjFTNko0NDIyVDJjUDFzN2pyd1BuY2VuQjJESUFkQUZZRHRnUWxxMC9QNTl1?=
 =?utf-8?B?T0dpOS9wUjhleTVxU241K0VmdlJ1cklkQmZRSVFJaUIrdUtMcHp5b1VBRG13?=
 =?utf-8?B?cWIrYmo0L1VOQXFOSk5yWWI0dXpteHlhSHFtTVVJM20wMmltc0Q4WXlFRkg1?=
 =?utf-8?B?a1lKUmZFQ1ZBQ0VwSlNSem1jN2cybXdaTTliaTZQanY1VStGT21QSlhubWZF?=
 =?utf-8?B?SVRoTGlYRFRMWkI5d1d4dVVJOHNrMVhTcUpNREpTYzZ4Y2N6SkZmUnFmYTdS?=
 =?utf-8?B?SW5tOHNGZkx1NXpNcTQrWFRiU2toNVpvbGtvc0NheGRMdm1TRFlLdWZTQ0M2?=
 =?utf-8?B?MkQxemFOdW1ndm5aS1p6a2Z4N0dNRStUYWFiZzZKVHNWeVMvbHlVRVZlWXIv?=
 =?utf-8?B?YUpqZjlOR3ZYY2Nrci9NS2Rnb1h1ODlvNHFKTmNXV3R6QkdFeEpRTjkvNWFv?=
 =?utf-8?B?cmM5aWhjNlU1SjBwSW5SY2F3NFV5RXlIa1hkNGM5Z0JtN1hqZ3NtQzMycElQ?=
 =?utf-8?B?WXVTQ2dFcXEvZXVJTnczcTQ2Q3o1QkdEWm0rLzVlN3Y4MXFDWXpqQkhDallZ?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ce8f8c-b1d4-4833-c835-08dc25bef5ee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 20:22:08.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sck4oUc2ztE7mZQV4vP4yPcSDqip3K4gf0Cy6EbqufqYzGN7YLRbniGGQkt0+vCqOymGjhSxBl9mYjRPQP0YWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 20:22:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14656

On 04.02.24 13:20, Pavel Machek wrote:
> Hi!
> 
>> New realtime trees should be available at kernel.org.
>>
>> Trees are available at
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
>> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase
>>
>> And their content should be identical.
>>
>> There are also tar archives, at:
>>
>> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 
> I managed to push wrong tags at the server. I believe I've undone the
> mistake by now, and everything should be okay, but be extra careful
> this time.

Something looks strange with -rt tarball as well - no RT inside?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


