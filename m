Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC3C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 12:12:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.46])
 by mx.groups.io with SMTP id smtpd.web10.82501.1701951120051012311
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 04:12:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iRtWLF+h;
 spf=pass (domain: siemens.com, ip: 40.107.22.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwSc/Ygus5r+d2wYPPNP4oa8HvdyMjzIY/Cp1y2yz1nDLr4Z01NYrLSUIqf4mz6/HM2fv/8ELs8aXeYaFE9tT21Z6TZ/W62XJf5am6t55VmtxpgVEJISdpBLs44am40/6kvYk0d2nrH/FSTfpbGJDV0x/ap/aywgSq8dKfdsRhSty08p0c106cCOTMdjIS6CqwQWv6+CoWKQyE7zl7VJrLN+4oZWmddZdoyDTTEYv0FLIk9ZbIdB/BlrvhiQWp6VN6hJsHb50xmO/x/D9hSbJrOvqnzOf2/oDc3wuekzy8f8KBvX1VC5MOEGfP3y0NE4zFCQ41/eTRQvwMI7uQTmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEOyUNIAqBXyZ1mhWy+1ZiYtKNoNc7Axc4ueZOiyjOA=;
 b=OLz8dTDWFqcaPGtWktEgQoIXhUHyO6Kz2PAeikAPMGY3ObTU/bxo5Xu1zr3BIF5qvIWbiIO5IoUwmqpO9MxV3RfHhaqzGK/dUxnlHpEL+1neUKnykr7aaKqrum64EZyKz6vDHYgjFbRJnnLXrFxoRO1ovqh/22WIOwuJ716xHvd5n2YCtUq+0kyvaGDy8LK24gXhr7Ggf269F2sepFqh7O3jI6qma/GZ+qXP3CLUzTlLK+s0FQcJGD8+uddojEokp39bLXVdYN4EAhZ9Sewqx2/iTSjpGkYrnZZzXkM0iOVgILEM8U4P5dPq0jBuMT1UbW9wSeNk0/wpNAdx3I9x1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEOyUNIAqBXyZ1mhWy+1ZiYtKNoNc7Axc4ueZOiyjOA=;
 b=iRtWLF+hRFfWCdtF2m+d45j5yFzfyizQx9odPaTmbyDBlrK/69eQT/AAs7tyHpXTtQ94fb3yQSouIyTtq8rKNjMZDxrstc9h08wKmzNngIyHinp+GmVtZs/ouYieE/4BzTQTLYm55WxrPycyy/oO+fqEAXy1AmuTZFIVna0y6xGWhD6qQDC0wZXf/9mdDoFAtSefT7oF8WwEvM2kMp+UUzibuX3QHi8iFbODOupkDMIJSATp53i1HdyLXKHisvkRrKcRENr//fe6CAAtG1teGxCKJo9UTe7qaBSS8mItHFoJxRSGj98cCxhUEDwdhYWzg9mzDBJBwHsRJnu0KEecZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 12:11:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 12:11:56 +0000
Message-ID: <fb5fb6eb-e663-415e-9ff7-5cdf4d53f61d@siemens.com>
Date: Thu, 7 Dec 2023 13:11:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
References: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
 <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbc9f11-0778-4c48-3540-08dbf71db4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X7YCvX54t4ZYt4gy9bjRg16TSJEeFLtl7CadUHdKkG8hnU0X8YARsopqWgGZrkEALm874rzP05WGDRhHNrjjAigxcDJb0tC1eeYatn24788u+qY2Rnh5UftZZ1lIe17vYjVJBquX8ZB0EQj3ZAhbX5DMzqiK5vd0JQc7buMdS2d9DPXYkgEOYT5u4RtCpWQdEe6HqggBBIfC119TgGbWS15RbhVqjJtCeEErIXmS4mo++N4h3uscOcnVFvPIiWYLsOBOiLyK6RHvuaQgfSBdBayXdJVuo+kNLGPkwFnDO+F4cyXTrmrPmXFOvljcyKq9pz5tBpbxuFC22kO0QJdHDkHOftBjrTorLdfcwSur9OFs7ITJJSKuIVaEj1mdoSa2JVDhki9s+CHwvwbdGKLvg+75GSK4m2JRNdQ17fPSqSMMR3pI0H51yz7X34exOrgISfeRU6MHNA+K+naKw7lFea0TN4Rbvj/VN69S4snCVV7XZBf4tDm+Z1Sc///WhoNix3LM005wPAE3LrXjGNWbBEsYh5OI3Se+9ZFc2BzY3LHXkbNipjOxLU9xIwr6530eC9S/fCr2pyMs4X0GzZXC3HWjGCJf0iw5BLyj5YZmLXdj/Nh+jIEOV85zZ9mzKHh7/niRusTyxc5ezo03EbQ+6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(2906002)(4001150100001)(5660300002)(41300700001)(53546011)(6512007)(44832011)(478600001)(966005)(8936002)(6486002)(316002)(36756003)(8676002)(82960400001)(38100700002)(2616005)(6506007)(6666004)(83380400001)(66556008)(86362001)(31696002)(66946007)(66476007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUJVYVI1djRJWVVXQ0Y1TDVVODcvbFZoL2JIcTJsWTNPanB4RTF4S2p6ZzV0?=
 =?utf-8?B?M2N0NjdDOTlySXBQd09NQnFMTVhReTZZQkdpd3E2UDFCMzVhWThpaWhWeEtV?=
 =?utf-8?B?Slowb0V6UENCajNWbjVQS2p4cTM1b25TVUpZRGRvM1VSWGxJeEZ3Q2llREdn?=
 =?utf-8?B?K3BOeHB6alFSNlRqaFovaXBEdmEyTWszcWtkM2EzQ1gzWEpiQVUzSTg2ekE0?=
 =?utf-8?B?REhKYnFwMk80MHZZbVhwZ1p0T205TUhWbXB0NmtKWjBNc3dYSlhITFJMcDFk?=
 =?utf-8?B?K1FlTGVnZHN0Z1I4Yzd5T2IrZy81Z1ZPS0hDY3pIMlhFUDBZeVF4cFpjU2JX?=
 =?utf-8?B?SjRZZlYzUlRnaUEvcjhvM0xpdDZ3Sy85NVh6Ujh5QmZHV2dJVWljUGFnMU1F?=
 =?utf-8?B?RFk3QkpHRUMwdllHaTd5OFhrakZZbTRReko2SkE0K1RNRkVXR291UDNtK2s4?=
 =?utf-8?B?YmtvdFlUakMrcnQ5QkpKdGVPSDNsbmJuOTdRdDVoVk8xamJxK2tLZU5vQlFK?=
 =?utf-8?B?dXNQbWxKaGt6OWlHM05MRHdEY0ZkTEN6TWZtbzJmQlVnU1hjcTNkZ1E1K3Jk?=
 =?utf-8?B?WC9Gd1NwQmRzTS9qL0JsNWdJSGZCNmFBZkhnWFRDbmhOSXpLeG9lRXNrOGln?=
 =?utf-8?B?aEJaR3JJU0l1Q1BhaTJxUVVYUW5kVE9hdm15cGZVeXZMZUxzMWpBcDJvWXE5?=
 =?utf-8?B?eHpQSzB5UDg2L1BsZCtHS1huL1NSU1lUY2Z4SkZnaFFUT2dkRXhrdXBDSnlj?=
 =?utf-8?B?WHYvR2M1QlpvZVE2S1dyRndqRnpHKzVySEd4Q1F5OXVrY2s0T1RYaUhoNmtH?=
 =?utf-8?B?MXhiZnZ3TE5FZnU4Rk4yNHdacXRrVlg0TUtDdWRrb2VLeFhuK2M4c05TcEVR?=
 =?utf-8?B?L2hybUpralNQbnNDcW9TNUlvUUVWR0Vwd2pHSlc0dTdoQmxJeTR0RVR6OW1p?=
 =?utf-8?B?THFjU3A5bWE1RlNQQ1Y3YUtGTnJqRmRiVlRoZWN5bjRDT3duUzl1UmwxdldN?=
 =?utf-8?B?Z3JIYVRadE8yRStlTHZKUzNaSzVnaVlvZFFOa0JHYURhMEV0VGh5WkQxV1BH?=
 =?utf-8?B?c3dlZXRMS2xVUDVYTExqUVdhOVpJQ3JQZm44T1Y3UytRdjl2ZFU5L1djcld3?=
 =?utf-8?B?cUl3Vm5QM0dQUzN6ZzA3ZWVQdHJ0eVQvRXFqN1FacVk0MmNrOEllL09WaThp?=
 =?utf-8?B?RkFmQ0o2SGRVN3dxM2dwclBvN2lxeWMvRWdlUU05R2xZZ3ZWTmRiVlRvd3JD?=
 =?utf-8?B?OEw1TDVWaUp2d2VwRFR0YjhsMlhpVzFFelpBVTJoSU4vR0FHeWYzc1NMVFoy?=
 =?utf-8?B?T3pIeDFHcDZjMGdZYm5HRGdnZHZPNHRsajF4azJSdkZ6d3FjZUNHMGFJcWZF?=
 =?utf-8?B?c29pSU1NbGJLVG1YMTViZUVRVXJCUFo3MnR0UWlTVzRaM0dmYXdMM25Ia0RS?=
 =?utf-8?B?d0VnTDdWZXJOeVNOY25NTFU5eVBXbXJ2V1ZkWHNzM0ZnS1VwaVc4S1pIN3dZ?=
 =?utf-8?B?VXVuS1RZNnNpeHltOC85ZmJ3WWxYKytQc05KbGtjbmkwUkFpNWQ3Tm1CZC9D?=
 =?utf-8?B?TGlwS1NtdUlWL2VJWnU3MVVGR1lpbnpma2IrTzJhdTBPYzQyNW9nQWR3SDVH?=
 =?utf-8?B?L2dBdlo4SHV0bE5zcE9VbHZNejZ6RzA3RTZkai9lZGpTYW5xOVFpb05hNjJF?=
 =?utf-8?B?b2xtbml1d1hNcnBpem5yc25SdlhnS3lCV1UrWTl2Q0dqOFZISjVzS1ZndGM1?=
 =?utf-8?B?WGhIbmlCSnA3eVBuMEZSL0dtQlJiU0dkM0FrL0xxQmx1SEhPMmVoMys4YkRJ?=
 =?utf-8?B?YzdML05scjg0U3d5Nk5rQndHWDdwZzQxSVp3VEE4dGZJNHBKbGxpalNKb05n?=
 =?utf-8?B?ZzRHWGVjQ3NiYUN4S3Q0TklCQ1RBVWNBSDdwK21qQ1dSaHRXWFN0SFpsS1l1?=
 =?utf-8?B?dE0raWppM3lKUTFHK2cwTjRzL25janZWMTFoQ2tvYU1Oa0hFV05YbEhyUUZK?=
 =?utf-8?B?ZHZacDFkZ0hxa2huYkNEdXd0S3BEM0FEYmdrMjFaazdSbWtYU09XSkZpclZw?=
 =?utf-8?B?YTJtOVBzQ0ZpWEhyZXF2L2sraW45TWt4Mi9aRkxES2RwVHEyWUVhTUJoZlVR?=
 =?utf-8?B?UnJzQ29oc2JuZkt4OHhiOFlEbnFwdFNTdklvYVFIL2hRSFlYVUZOcjlsaWdx?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbc9f11-0778-4c48-3540-08dbf71db4c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 12:11:56.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncTILiAQVd+tW3E0kfCjD6fgaYwnr9yV97S7Z2zKjO6mWALddrCZ1OGVCQmF66JvSvaQ0zlhMYbnXcGc785gbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6989
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 12:12:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13828

On 07.12.23 08:26, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Thursday, December 7, 2023 12:51 PM
>> To: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>>
>> Hi all,
>>
>> Kindly be reminded to attend the weekly meeting through IRC to discuss
>> technical topics with CIP kernel today. Our channel is the following:
>>
>>     irc:irc.libera.chat:6667/cip
>>
>> The IRC meeting is scheduled to UTC (GMT) 13:00:
>>
>> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&
>> month=12&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4
>> =37&p5=241&p6=248
>>
>> USWest    USEast    UK        DE        TW        JP
>> 05:00     08:00     13:00     14:00     21:00     22:00
>>
>> Last meeting minutes:
>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-30-
>> 13.04.log.html
>>
>> * Action items
>> * Kernel maintenance updates
>> * Kernel release status
>>   - 4.4
>>   - 4.19
>>   - 5.10
>>   - 6.1
> 
> FYI:
> Date (the data is created): Thu 07 Dec 2023 07:23:38 AM UTC
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Thu 09 Nov 2023 04:52:19 AM UTC
>   limit date: Sat 09 Dec 2023 04:52:19 AM UTC
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Thu 19 Oct 2023 03:30:18 PM UTC
>   limit date: Mon 18 Dec 2023 03:30:18 PM UTC
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon 06 Nov 2023 04:21:02 AM UTC
>   limit date: Wed 06 Dec 2023 04:21:02 AM UTC
>   Status: late
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Wed 18 Oct 2023 10:02:27 AM UTC
>   limit date: Sun 17 Dec 2023 10:02:27 AM UTC
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Thu 23 Nov 2023 11:51:14 AM UTC
>   limit date: Sat 23 Dec 2023 11:51:14 AM UTC
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Thu 23 Nov 2023 06:12:31 PM UTC
>   limit date: Mon 22 Jan 2024 06:12:31 PM UTC
>   Status: On track
> linux-6.1.y-cip: interval 15 day
>   latest version release date: Thu 30 Nov 2023 12:42:42 PM UTC
>   limit date: Fri 15 Dec 2023 12:42:42 PM UTC
>   Status: On track
> linux-6.1.y-cip-rt: interval 30 day
>   latest version release date: Sun 03 Dec 2023 07:25:17 PM UTC
>   limit date: Tue 02 Jan 2024 07:25:17 PM UTC
>   Status: On track
> 

Cool!

Jan

-- 
Siemens AG, Technology
Linux Expert Center


