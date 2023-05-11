Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1688C77B7F
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 08:52:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.74])
 by mx.groups.io with SMTP id smtpd.web10.54535.1683795172545510044
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 May 2023 01:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bkuPpV62;
 spf=pass (domain: siemens.com, ip: 40.107.20.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3A1D1xctVRvWyX65h1BgwzpPkCAyLj7kYxKi01n7X3w5AVPtamwx408Fvm5dANyqT8ysYkEu1VPfIM+GaQD9EoRx+Lrm28UHxm5cPdjHKWmWZGmk3cOXdzzXx89ligqIbxbO8ijyDErstzvzYEEvlhXdV+S29oKeO/i12R0Fgiy2MAZel6qvFX3K4/y4Y8sP935rrREFlOwDvTZ/DjU1EsYaixg0uoQUShCxeH/3rPVuTo0jGBTzgEqERa6Qo+di+VrwC5hkLJe+/rIGFx0Bjb6hJO/dCAd17rUuDgBwaiqk6fQKLXcSondFt+02sW5Vu9XJm5oCEWvDei1r3UlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYtJ1xC/hQMw32wWISmGEAc5O9m12h1i1OnjlfJiq3I=;
 b=Qoud3BSTVVmKcI6BUFmcCqpSAIPAL2iCptpiYHDKTe1ZpPMM7wL9LHeH6+9s3OYrTRqilYSxFstVroERzDJO1c+sqpal7dWRFeSITdcy4HXaZOPhU5nDeeijGHY2jkazhvyW8n7UAEBUeDokmKV1nUopGLL0NstHZGb1GF/OTd1ZOUxdVTgujQc6tSA+lxQZZyHFMkksm9n2IM7Uow9PZ9ISY4VPZP3X1lwvyQMxEWnCUYpOhDs2k8rWqGSXQWXHRcgNw1KCnzuIwEAm2F6RByLSMu+ZYO38TCYyVpLpxbznzpS7La/h+tbBauHuqXQqOWtcDZ+vsWmDDojIJoFUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYtJ1xC/hQMw32wWISmGEAc5O9m12h1i1OnjlfJiq3I=;
 b=bkuPpV620QaAbYaWBGwAEJPU7b1GZ/022Z1vc9IZ7UKAKCYDM+1YoEu9F9ecw0KNXB3GYKiC0j2uDSxR0KYFfjAY0CpxKoRC3PYVo6Bc0PKjLhIHYajpcvWFSnYUzuA+6od47P6/qXsqQIO6skUnkrBV3BKW4TdDe2kzDG6sjbUc9s+cFY3DVhm6XKier3Gq0lUCFlVO9AWq9N3LCThRJkyjwUwPewrupIMAogg0ptHNMRVuTHReTeJVrwzTvAPKv1qz9w/Lq0bigI/HPT4jYzEQkm/EKY1JEDJtGs0ZAQyadepQ4BSjQ6akSJbndMTfMYliWJgVg7ast6kaSMYbJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB8026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Thu, 11 May
 2023 08:52:50 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec6b:bdc6:10c5:ae86%5]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 08:52:49 +0000
Message-ID: <5a9fec0a-efb5-1657-ebab-7d78ce535195@siemens.com>
Date: Thu, 11 May 2023 10:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be82dd7-92f5-4431-38b4-08db51fd1951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q8+3Q+Q2X+Et/yOcvqetcq8WYwPeHf/k65UtMkKPs6nFYZScRWVSOYP+PYorLCua6P1oUAHbAEepsLZXFGfjBK7R8XMQWIxvua4TAa8x6SbQ4DxZ8AiLdHwdkw+sHRrZt6Oemg892U1ir5iFSbnYPWuW48SxSLWELNIOWGNCryloExmsHffxR0yccmY4eI1Qk46k20GKoluaTSMt9KeTA55vj2orsTUKJjge6ZdYfySWfkmkUJmrXnhWx1t2ApZvLxB3WLpxP17P421zIDaKGXeWoerKLSEx2stAOb2gOqukAfl/n3XEyMG1Mt/nkABdBSD4k+DLxlACT0Xs3QQqS2zWAaU6BnlDlyQvoJxrW5zn4jKNxKpOBRt9vmBmKvZME4QleLjagmNp2BCwLytgIBfmKJJqniOFUoieNX2wKIexja2df7V/yIK9SqZN9si7H7yFFtSH9pSnUeJgVE/BqyNwPXbomigAgwhox6ig7w2Tlsjv7/GS8RnKxjujQOFh/jNStprEVGPueG9usNnWPlEz2NS+4maOck/3t3FEjeWEaYwCis1Wr25Q73bkcwEiUeEH/+EbzAlAGZR4CAKxPK8R0bP+7zi7r9zUaXqTxJydg15Q1VT0kn3kjQQJQY4wPuj4r8Chi+ou2YgUEgs4RQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(8676002)(2906002)(83380400001)(6486002)(186003)(2616005)(6916009)(66556008)(66946007)(4744005)(6512007)(41300700001)(6666004)(66476007)(316002)(6506007)(44832011)(26005)(5660300002)(478600001)(8936002)(966005)(38100700002)(82960400001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cTlwRU90ZlhhV0MzNjZRZW1sQmF5RDhsUy9BeXpyYjlXMlNReFhEWDNESXVm?=
 =?utf-8?B?T3B1YVF2VlIreU5UeVpySzNBaGpZTW5wK3pzMW1HYmFUQlZkeTgwNUpWeGJD?=
 =?utf-8?B?WGZiajE3RFJwbjB3eG0vMVZiUFlVYjczKzM1SXNQNzl1MXBEK29veFhJcTdS?=
 =?utf-8?B?dXF5T1dTdm5FcG5ON05rdDJ4dU1GSy9kWkxSQWpYTktjdWFpYnluekVndnpB?=
 =?utf-8?B?MWZ4OFoyWFdTeHgzR0pLQllMTFBYZVIxaCtmWHdtRFlUNm55RGpxQXBpYThN?=
 =?utf-8?B?aW1PMVNrcjZLeEs4NVpmeEhtT0sveGUvbnoyQ2w1QXBWb2xwKzdpUGVEckR4?=
 =?utf-8?B?UWQ2ZHcxZUZ1YXNTcG80eVk0djcwQlZRSlJkSXpROWREODZ4empCNTd2QnRO?=
 =?utf-8?B?aGxaUEl3MEJRYXBRcFo0QW40dkx5cVdqNFJiZVRleTNDaFFnTTN1T1cycVFF?=
 =?utf-8?B?Q2NZRWJpT0NKU2QwdHdJdFdBRjdoT0VWNUV3aERSYWE3VGVYRmx5S0FJMXVL?=
 =?utf-8?B?cW5icG5hUFA5OE9qUnBZcWt5UEpiWDlaTDZ3ejVQcHNEdVhLOGtPUWVVeHJo?=
 =?utf-8?B?RTJkb3hDWmdEL2JhKzE2WEYrUUgwVkEwRzZFY0FQWEswSCt5UDhxN04vWkM0?=
 =?utf-8?B?VU91VXFjOFRqdFQzR1VUU0pSeElBdmV5ZmRKOUZTcnVvWlgvUzQ3a3dadWVq?=
 =?utf-8?B?WGZaL05NZ0tlb0JHdGFGaWNwOEo1a1JDdUY2Qm9PMGZUMUIrR3QxczlqKzZa?=
 =?utf-8?B?T3IyQWhXdXk2WWpDQ1hhdERGaFgybTNndGhRNXhmMEtTOW1CRkU2Nm1La1pm?=
 =?utf-8?B?R0NZQXJZM3lDbnBLdlRXeDdkUTdrdWpPQkd4dExOZjN1VG9MNXpkTnpSdnk5?=
 =?utf-8?B?RzNHK2Z3WEtMb2FMRHl2enZ6MHJEcC9mU1hFdDN6NmMrRnBPWTBubXp5dmJi?=
 =?utf-8?B?bGdnNXQ5OTQwZUNEeHhaZUQ0NC8rMy91eFdVNERtUDFlRzUvL2pBY215cHV2?=
 =?utf-8?B?Mis1RXlkWTZMM1ZwQ1IzcWJsWXN3bXNBR2lWVGl4VkZMengzNWhOUkpoQW1J?=
 =?utf-8?B?Kzc5Nzd4eDFCM1QyTURFd2hNejJpNm5uVkt6T2ZIWUI3OXR4UEdKdjZJekxp?=
 =?utf-8?B?S0thTzh2V1hHVmMwcU5ETWw1d0M2V3gzUXdXbDFFUThwNVJzRWhNaG5MTWVm?=
 =?utf-8?B?TnJMR2ZGVVNnakJFK2lMWWJUTXRMREx4Ymw4U1FmZ2FvV0cxMFlLdGNuVW84?=
 =?utf-8?B?OGczMG1TRzlkVlRtV3ZXUk5pcDFTbkxOdW9saGhrUEtnbkVlRml0TEZ2MUFF?=
 =?utf-8?B?aEphU2Exck1BZDllQjdmOEh5bVQzU1UvaDJPNnREenplaEtTQ2xqT0JZcnJV?=
 =?utf-8?B?VUFQekV4ZFZnK2hxMDhwakxGWndER2RoNWM1QVZRZFVNYWZGVExYWkltZG8v?=
 =?utf-8?B?K0dzQzVPYk1yR2VKc201ZmlDcWtKYTdsN3R3ZUFvZVduQ2JHL25tbXk5NWQx?=
 =?utf-8?B?TGJ2RzlzUTA2TFZyKzZiYkw5eG9wZWJtaVkxakdZbGlYRzhYZTk0OURxalhj?=
 =?utf-8?B?ditsU3k0TFYxUTVyanlIVFE4c0NoWVNHVkhCSDQ1aEFQaWJVdzRQM0Irb1Rw?=
 =?utf-8?B?Tmpia25MSUYvOUI4ZUpYQXFuWGN2Y3Boc1JCZ1VtTnVSSWVkYjVCZ3B1SktS?=
 =?utf-8?B?SjdCSUw1enNTSVQ1QUVuUlFSZWFKUm94c0R4WVVXMzFhMkpHRGZLQ1RXYWpE?=
 =?utf-8?B?Y3BUV0drMVZRQ0YrTnNDZnJPVjZmRUJ4WGFLeDNLMzhCa2ZTNlVFRmhOTUNR?=
 =?utf-8?B?YzR1S21zY0lkaUVkZ2I4OFZlSHpyaUp2allVcjd1QVJHV3BHRFk2Z0ZwUlhB?=
 =?utf-8?B?c09kTTBTUy9heDF3elVGNDFNMWlzblJOeFE2bExYT2JhbHJlUGVWS1RTd1Zr?=
 =?utf-8?B?S3Iza3pBUk5jcmxESmFWWVU1YTNRMjNPMDQxOGpzcWZESnhSWGpBVWFyaUpn?=
 =?utf-8?B?ZDljSEJ3V1UyQ3VCRzJLMGdmSjMvUUlmK2Q1cDJFbmhaTG1BL0VaL3FKWW1I?=
 =?utf-8?B?VmVLT3ZsRzkwempmVWYwV3Y4VUlwS2Erc2d1WWgxQittK2Z3aC9Xa05mZnJC?=
 =?utf-8?B?TDVXdm5YdVZsL1RHb3hUWGxHT3BlSFZpam8rVDZyZ0FDQVBxaTYzclhFVnlm?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be82dd7-92f5-4431-38b4-08db51fd1951
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 08:52:49.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMqKyva1vbZzwuOI0lSIt8OuF+ajfnvHReEWpezCSj2whjkZJAIQCcndQ61Rn491BaGKEJUKu48Gx5I0PqOWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 May 2023 08:52:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11437

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=5&day=11&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/05/cip.2023-05-04-12.01.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

