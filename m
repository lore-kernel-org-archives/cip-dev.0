Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94285C47071
	for <webhook@archiver.kernel.org>; Thu, 16 Nov 2023 07:53:46 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.73])
 by mx.groups.io with SMTP id smtpd.web11.2397.1700121223826192381
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 23:53:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F2JaKsAC;
 spf=pass (domain: siemens.com, ip: 40.107.20.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJui5QNggcON9jIN2wSZs5y/fmSvYJsoyRCsNLf9HTbyuqTk030qqCxUWMP9FYGXy6GXj7UPzUB1XHh5aoLm56PJyFcIuBNZWIw7sUCASLOB5QRMhERvfqozYgiQfnGyUGc715YwPy3qOxK4geH/FEl/XRWfRbf6saFXEq6GodRPfqI/y1cZbWKdVWREgGbxVIDrc4a1D1mLjWaZD4vJMPR3x8JfnNxTczQfQKJgLYz35/KgCNZtAFcVYHlIZzRZxfHdZgCFGunhaUY2Wd7WimrC6bH7vQDDmGnO0xiqH/N1/qTBCmDfLdgMBEhXmwlv3O4gQntkwX1CnDjbObqmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isK7hViYvxC9mxGBZijZbMQ97D7QMcaNspZsYmWz0wU=;
 b=ixIXeyKAvHQisHeKMfjZ8TIuU3k+Uf+yX7ldrbbFLfbQBg0Whim2yN7zusac3CpgAVx1k2WuTceVs48/lisJHPNu9l30BY53QSgx/ILyQybiOKpyZzkKYE+UPJ7yDlZEZDO5la0XoPSjeYiSBC4/JRE4euNBxtyXeZ1Q2PBUehjm/OMgbhtjekth6AVF6uKtJP9Cr1CnLw408QcooUXFAMIqatXSLLaKwqHHSge5C9kSPosyayXesOBFaW6854xgNy7yd0RvEtMkoWyPH0Fy6tx5USxAxleP9vTRtlaqDIYEjvMo/6KDengbUTGf/QvF3gFJeGACAC+m/X+pM/gDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isK7hViYvxC9mxGBZijZbMQ97D7QMcaNspZsYmWz0wU=;
 b=F2JaKsACxlK+2UUPzVUQLGkB0pRuJwI61M1sditolZtBtWFGsxBjq9oqYJEawb/zcZgSfXUehylfp1LlVjpTZVYb22fupbJXxNgNnN7gWFu/EWwUOg0onIO+PGZ+ol9Lsd34s/1kqlUOIhhO4waN4O/9eMkYmOn9dvH1qRAozV5Qu7f0+yhfupruqkSPjjUVMGTJKEPEv66tFLsDega/GefiqZc2w/EkZGsYdKd3/lYsy4ivM9qPEIB5LCD4hnpKvWuDnosU5NamhMh/9Nf+q4Yi0XghzkttCv+xmxsIBMZ7m3zsC18khBRT3bHCt3tpwF0LL9GSTjb8KbXwFpPANg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 07:53:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 07:53:40 +0000
Message-ID: <81d07fdb-2771-48a6-9543-c724f3a62fa9@siemens.com>
Date: Thu, 16 Nov 2023 08:53:36 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c1b756-2c38-4257-2ffb-08dbe67925f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b/kdYrdFrtfG1+MRGopKMOHTDrLRT7f8Rsdi3H5mG7gAkHwEUtAt0RWdF/9mk+bCO0+ESGoJv3QWUVIq+N5qrDVd9MHmVYrg7Rc8/FaINrBV2LwLwTse9p3/Q/iM+g+5rkiUzify+E7WChCYBAlNepY6+/4aQvweWog/oTMA6H+XxORQe3wMyP8sdsHox9RGnUC+ZgMUXEJ4sj0SK5EZ26uYxD2IWLBs6jrHp1KDOpUCSYJw+jdAZvz2XgMPBmh7e7ejBVBDP5Qwi6NkUFXe8L9+3Ly4LR4LKp3RQy1fivLFxOgFQ29A7kX61R2GHwtTpzCVTHtEb1ZliLVAysFBsdhlTtWaHkyFjSOxYOGDt8vzUhz89jJ21YJIPiUbJ1ViljC27utSVKYjtx69mhD2aSKWgz2ZQ48aL5rPg5UzHb7a3OTaiAFWRepSZz3IMwk416cHh02Liu1FsuLhhHnGJHFXKv00cICgEzeW6P3S+J3NJ+n8hYTOgSQUtvLBzKLOwV5jApCMSTrTw/1lNKPt/17xuqaD7HpUuZFaiAdnOEQC9XOk/tGoGKwFPG1jtOiaJK89T9rmPhzZHvtmXt6GWohyEWejT8wVPcBmO+2a6jhm7WXb8ilYApVLDLmDeUld+YWegVypNFWAzrkZ0wRv6g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(66476007)(83380400001)(66556008)(6916009)(66946007)(316002)(36756003)(4744005)(44832011)(8936002)(8676002)(5660300002)(2906002)(6486002)(966005)(26005)(478600001)(82960400001)(6666004)(6512007)(2616005)(6506007)(31686004)(31696002)(86362001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzhUSVZKOVBYQS9BZEhRZ2N3OWtGTCtFeXRNaGw4dGEwMFhENFFuNXVpTEI3?=
 =?utf-8?B?SDJTMFhzc1UvRmFtMUNhMDJyN0s4ZW5Qei92eXpDcHlkMkk0SU8rRXR0RWRj?=
 =?utf-8?B?TXM4NDJ4NUVDbEhKOHBXYjNBaFdNakJjK1FYbzlzSTc3OGRwbzVJWE5IQkhE?=
 =?utf-8?B?clZJRkZSTUo0YlpaV2pQVm9HRk5tdlJFeG4rei9TdUFhbTFIRkVqTkIrZmc0?=
 =?utf-8?B?UnRTK2xYN1pSdE10d3laeC90bCtEN0J2U2UrYkJVSU9TUUI4TnNEaDRENkx0?=
 =?utf-8?B?UThvVjA4WXVsYm91NWMzbCtwekZhK29ZQVZOeHNtRlFQcXFXdldNTEdXbXA3?=
 =?utf-8?B?VzR4cjcwbys1U2poM1h3QmlFTUc1Wm1KbzdpbXZJa3FCbmhBdlQrb2R2c3ZX?=
 =?utf-8?B?WldGSmtudVlIQ0RxcGpYVFQ5RjI1TkNNV0tnZVhjbUQ0eHVKVGZ6bzAxV0dR?=
 =?utf-8?B?UmJHU2RFNVh0MzVqM1hRVmdTV0RCK1ZPZTIzck1GUlpWWE5NY0FLZDZTd2dt?=
 =?utf-8?B?MFVsTHJKbm5xbkhmOGJ4OGxDMjhqbzFNUDgwZHZYeXNqVXNWb2ZuRWtNS09v?=
 =?utf-8?B?UFUyckUyRWpQZitiWGJ4NTgwTGtWNXBoNzJ3ZHRQSzU4dVpnU2UyNWRUM28v?=
 =?utf-8?B?Q2Y1Qyt6dkJMSUFLNVkzQzEwMUlCVDIyamtwSmF1WjkyRitsNWwyRzhaRi9V?=
 =?utf-8?B?QzlMVDJ0T1ptQ1RpMnVDMjk4c1YxQmZWVW5QeHhuWk5GSnBla1J3WkFXajhx?=
 =?utf-8?B?dERJYjJSQjREU2wwZ0pGczYvUVI2blBUcTZKNmkrUGsxZjdSYjF1VGZnWmM3?=
 =?utf-8?B?dDI1NDRweVNqRU5CMVZiTFBZQVhyZU1DNGVtbis3eVArUkFoMi9xT0MwVGwy?=
 =?utf-8?B?ZEx1QTNDcVo3YU1iUGtmblc5T1JvOFVxUDRxa2hnd0xqVGx4V2lYdE1TRkta?=
 =?utf-8?B?dDBuaDNHSmJGNGl2SXlYN3pXNkcrVW5KRWwramJqd3ZhVC9IbnlJVGFuT2ht?=
 =?utf-8?B?K3Jxb3BHcmVPS2ZJL0FRdHJUc2duZEdFY2RTWnpBV0tuSEdmRGhmVUdvYnhR?=
 =?utf-8?B?STJRbFVjOEZXNytsME0xTDAwWVN1dkVBTFVwTGV0TW5NT3R2a2FiVDhjbUpi?=
 =?utf-8?B?VkVwc3FKajBWZEJVNy9uZUViZ0JQQ21LZzFzZDVncTBVMFYwWVRhQVovWENJ?=
 =?utf-8?B?cWJFYzlsVmhaSFJHRFNrbCtiakRjMFNHblJ3T3dFZ3RYTnBoZlFvaGlOdENE?=
 =?utf-8?B?a05mazlEbTJoMFZtdUovdHkwNHBNcVhOd2ZkRHVtOW83U29WMTI2Y1RsSkNJ?=
 =?utf-8?B?VlRaUkNIbXc0cndFSkE5REtkZjA2MWV4a0tGeUY0eW5LS1oxVEYxRTQ5TWx5?=
 =?utf-8?B?Wno4ZEtscWFZVk1LRXIxZzd6UzNnajNIMXBVSzBtbXRRa3JhYytGUDVGaW5m?=
 =?utf-8?B?aWdHZnJWbjllTzNUTVJXVEx2RW5zaG14YjhhdGRITy8zejN4b0xZQXdXN1dI?=
 =?utf-8?B?WHR5WUNXc1NDK21mVVhET3JsYmx5N0JKc3FJVFl5TmxHMTJVMDNNVllJN3Fz?=
 =?utf-8?B?N1RPYmxEQnpBOXpRRmJqeHlJb1U5QnhrdWptbjJkMjQ4QXJwU3VVVi90ZzR6?=
 =?utf-8?B?bDRJNmxjRkZyWFFVcVBuNFphNEhVYU9VVlBRWm5za3ZuWGJHTDRvaXU2Rk95?=
 =?utf-8?B?eEhqalJnbHljSG5xdkY5NlBaT3ZSamNtaFp3TUVZc3VtWk5iVWU2Yk9wZGhI?=
 =?utf-8?B?QktKWFZPSFgwQUNsaHRwdGFEK05WTlQwQzEwZFhrUTBRNUc5UklYOFVqL1ZW?=
 =?utf-8?B?aEZaRnVuZGpQVlJYQlVsQUtjeU41eXRzMlRwdmwrbFJ4a2xIUDM2REdHM2FI?=
 =?utf-8?B?U2k2L04vUVB4bStXOGJQYURRZU1tT210VUZ6MmFRZXhIQWI4di9NSXhuRTJT?=
 =?utf-8?B?N1BUTEQ0M1U2UlRJTlVSeTdlUFNtZ3BBNmxyNnlnK1pyTzhydGlnOHRPY09n?=
 =?utf-8?B?dFRaR2w0Z3ZnOHoxeTFkYTl6YTZzK0RSUzFWZ3pyTWZseFR0RkVrc2paWkZS?=
 =?utf-8?B?SWhVQlFQU1lKQmV1Um5tL0t2NHpobXVsS1loN2R6dVJkajQ4UTZFSVpqWGs3?=
 =?utf-8?B?VUY2K0E1b2dwa1pDZmlKL211dUJnQ0p3MjU3USs2NGt5VEh1eTN5UW1KT2RB?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c1b756-2c38-4257-2ffb-08dbe67925f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:53:40.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX0DN1tWgu+/J+aykgpJTeASJ+y04GM+Ee1IB8Y5j6NbEar95//yjSMYjL2Z+1Lm6+zeUbk3imJqS8sZAvPEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6291
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Nov 2023 07:53:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13591

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=11&day=16&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-11-09-13.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - substitutions for the next weeks

Jan

