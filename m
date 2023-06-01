Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE6C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 05:34:57 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web11.24565.1685597691875566526
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 May 2023 22:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W/kAkGh3;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PszJ1jlMgT4yJD5i/LxW5vO6xZVfe8ITEu07tuOoHi2KT/mBO+5Jk1R/0QwUwFZkj60o6lF5M9DfNSfzgTe9vn55+03UVKXpLFBcQ2mKCwXwRTnromigazQuPb7oYV3H9p5WenIzrvpazNL7HuzgUl7fSgamWI07sOlc0ZaQa1UIeZJfKEYrzhHjq3fQkDHQOiYalpmfZ1Wx2O3uCpxSNDzxBv9Age/i/FM9biYKt3DDcBQeRcA0YgzlvU2kV9vKyfpP+CYl8s95Fka0DGX0+dM4f57OxmOez0sVsXhymGNX0D8zYXao4pXQybcQpyBf5/i77RnUe0GAtxUismRf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5XJlyr1xaqRVNOTWaTErHixDYR1HivCVVpqm7muTaI=;
 b=WimNvegQZZ5v7wyxbijVViwFk6fk15Q/Jmgt9Bj9kwVRq6rBqXbC683jbyFxomjg2WgLlvpFZ5PA8+Gr+YtFirHaWoOjgcih8i4K53wCJ/iIzeOCcBiEI5TmxLQ9SZz2SlUSc2bIFKHAckhZxqr9tTGHY3InEHLR8FiwEEnadm0e97A1BwcKEQlKdT4+lpJcX/0fRbMpl0GZad74OS/gV/RYh2HBeIiydwCtu4MpuFZ8UsI+U0Dl7DhTFFdz3r6R/XWLFPitw/HeI8g6W1LpLg9lIhw/C0iZlHGMi78df/XFuWwt0WzQO0CLaFc6toT3ralISVAb03bFbb0j5C6t+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5XJlyr1xaqRVNOTWaTErHixDYR1HivCVVpqm7muTaI=;
 b=W/kAkGh3p5jhJF+H3PAEdm1tE0jjGenIqVy/c1iKmXGB480DnRVfyXp3DbqMRdu604H7Iq+m/51vW4DrnWsIKbApfrKSKnb70chy0H1zB9nJb2eTENUev8qymvmRhqpFXdGVu2I8LsHeY3eW/8FERNozPcO6xOvmOhOneRt/EYll3+jO/IKoespmv/mRcO8YfzgXGu/K5Sf/XfnNI73vYnRz765C50ssUunD0+s2Q3k3VpkcP9hh1b/zG4GFcELfq62MMUnRYOUlL2Qr5ionyEu2yIfKkFJfBc/zKvr8t19khj46pn2prKuXrD6S2NYR1rmkgtwh46k+jiioZAI/qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 05:34:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:34:48 +0000
Message-ID: <01b02d0a-85e0-a18d-fab1-2a5fd7b80638@siemens.com>
Date: Thu, 1 Jun 2023 07:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a8c4e1-14b9-41b8-5f9f-08db6261e9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kfM9sJYcXDS31NrAsklz/sxLaU4+qM1FktYQpTMCHEE9xbKabV0hS16HU4c3cqBdOojuprC2YfRYjj+8cAmA55uddz72EfK8EG18BnYHwn+3V3LMp/IqCFmu0TZaqTL40ylj6EmC3xIdTLzNymIWpdEQTCQAqIvqySCuwazyPR8OWQVN7cHfLrEn/sK3MY+5bZibR46SKPd1cwCa86Q4Bfx8n3Sih7on8pnU3GgO/nA3DvpXLf0tCXQp2dQyWcZVHl6jLJn2jE0v/Yu9KakFJYAJAP2VEchxqgV3IQfCju1QAGySI4Q4hVXEdhC1LYuv0sXM9tlrtfL9i2RaJsFUZGzeXw53kNyIUnz8kiXaa/uDZF1CfdjFDFlV71XeS/eiYYUZfwG9DxRy5a3lIuoFds8/a+Nmkqty6ycFpOr2V0ix/67P3/30rKVJBEh+Uv1tG7VmlDnI5NU4yki4jperCIcSg8AV44MnrHlr6SbNxTgjzcIm4UADCk/Kd/SWEvfHQY38+JzSujCqkNbKfghpYtrrBnT54zVsYcfkuQiIyuqutZn7EJLFjM2kBFveHSkzJUMdG4qsFgynBclRJwaG2PcioKh6LaqILaDtQ2H3mSsHlFVStoWqD+T4baO3czcnfBaNw96LgUUhqT7lgtLrjg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(82960400001)(478600001)(6666004)(38100700002)(26005)(83380400001)(2616005)(6506007)(6512007)(186003)(966005)(6486002)(36756003)(41300700001)(66476007)(66946007)(31696002)(44832011)(6916009)(66556008)(86362001)(8936002)(316002)(31686004)(2906002)(4744005)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDJpZGRJUmFOSENIeVpTREh5c1Y2dHZ6SXBvS3ZsdFU0alFqNUcvYmVocG9h?=
 =?utf-8?B?Ty9FcUhDN2Y2dVNqY2lFUENacTNXVTl2WlVZVWNZT0ZQR1hLMHE3WEpHYU5k?=
 =?utf-8?B?V0Flc2pONVl3YlA5aEdGR3JaSHlwd1c5RkZhWWx6Y0Y1R3BJZE1zNDc2M0xH?=
 =?utf-8?B?T1pQOElMeGNvMkJYdFZveVd1L0V6b3hYa2h0dUNiN2tFYlQvZ2R1cG9KNmtH?=
 =?utf-8?B?eEZ2SENVMEVJa3JoS2VaZzNBb0lsTk1aMFBJaFRRZ05yYzZYcUVXbUhuZC9X?=
 =?utf-8?B?anJ0ZDhaQ1VHYnZSRDYzcVJSWHF6Z0MyRkZocmRFVG5ENHZlZ285Mkl2bVcy?=
 =?utf-8?B?SjRZRUhwQ245NXVxQUxuTVZOVENMNXV4MzZ1YW9YNys4enh1WVFmeXdXc3lq?=
 =?utf-8?B?L29jU0Fsa1FvTG56VEFSUGp3eE0rZGU4SExwdUczVzh0eXptdHZrWjYwN1o5?=
 =?utf-8?B?N2ZRSlNFMXgvM0Z5NTF4anpHUEtYejByeUUvSU14VW5MQVdHa21MN0VBamtn?=
 =?utf-8?B?Q0tETjdzWnc4OXFoVldSbUJXdlJsMnNRNjFiZUN3eHRVQ29CNUpFamY0aXJ4?=
 =?utf-8?B?R0lKOGQxUmtDOEY0NmZKVzFqL215dEJNM05oNWxFZXJ1ZkNUSmNoaTlPNzFt?=
 =?utf-8?B?Mm9ENjhWa2ZTM2g3dWJodmg3MHg5VzI5UHRxMU1lbGhENGdQc3AvVFBCWkt0?=
 =?utf-8?B?aTVCQzZteTYyOUo3TlJBRnJvK3Bad09mMFpZTU9DV2hmTDB4WXZ4R1o1bm5N?=
 =?utf-8?B?SEdlL1JkZWx0anVNanhrcFYrM25pc0RHMStjQ2xPZ0R4M0dSNFRDZi9mVjYr?=
 =?utf-8?B?Uk43eGdUTEhMNC84eWc5MXIzeXVhcEFkNDBFSlZJcUh5NmRkVWpjMDNyOW1C?=
 =?utf-8?B?R0Q4a1d2MmlsT3JqMFBSVDhEa2YxM1Zxa0U4TmY3c29kd0FsZmxOTmxaT0Fy?=
 =?utf-8?B?aXlleUhSdHk5elhEVkZlWllBWURPRnN4L2lwK0R5cmw1N20vMjY2cGNvNGZ2?=
 =?utf-8?B?VUdON3NLYWsyclZlVHV6SkZiWjFtZnIreDNNa0dydHhtczJjbEFQYUpTcTRQ?=
 =?utf-8?B?RnZjc0VlTmE5aXNIVjl6ZkViR1p0TUdSeW1yS3BsUUR5UGs0ZHZybTY5QTdP?=
 =?utf-8?B?OEozdnFaVG11NWp0TlFxQ25BK2ZaNlVxWUtKMXEwYTRqNnpiUWMzbm1IdHdv?=
 =?utf-8?B?Tk52OHhvVnlHbG9ZeGN1OGE3TzZBQWpUMzhDNkF5eC9MV0RBenVFZ28rVDl6?=
 =?utf-8?B?NENNV3kySmk0bTNyRFNISU9kU2tXRzcyVUtMWnpFWkdqMUNQbW9pTTBvZG1C?=
 =?utf-8?B?WVkvQjdzS1lnUDhqWTN1WmJxTHR3dHBaWS9JTmlVQWNCaUhGVStYWDBRSEh6?=
 =?utf-8?B?NUo5VnNIQ2xDNlFuVGlNdjhMV21vL3JlYXVza1A2dmFiWEF6L3BTdXhRT0RV?=
 =?utf-8?B?MHV6NlFXa1h4QVJ4RTFQNzNyQjZGU1RnNHBMTGVVZVZwaEdpQ3ZxeFZ4bERr?=
 =?utf-8?B?ZS95aHdCSE93Mi9GT0JsNnNCeE5XbmIxVFBFMDhSSWZheWM2QnM1REVOeTA4?=
 =?utf-8?B?dmEyY1FDdmRBZ2hNSmZwcFozTFhlTUNOQmNXaWl3ci9pME1NZzgxa2VieXVW?=
 =?utf-8?B?QjlHbm1mL0ZONXd0eXRpVlZIaXF0WlhWbldxOC9hcG5VSUpnWjd2RUVaUVlS?=
 =?utf-8?B?SksrRHFsTlFYTlgzZW5PYzNSNnRmeFJIUStObDduQTg1cWQvbE9zQnNiY2I1?=
 =?utf-8?B?dFphZU03ZTUzUlc1ZmJVRkxPQU5adlVnblVWNWpqUE9aOCtudU5mSTl2OTFM?=
 =?utf-8?B?Q2c2Y2dDakgzdk1MdVJLaGhnMS9WeHdZVE5Ea0xkQXZqUG9RRmNMNFBERE12?=
 =?utf-8?B?T1pzWml1VURiU0NsSS9YL291UWtqUklLZkM0Y1B0c0JsaDdNOURjTlRhdjJ5?=
 =?utf-8?B?Zlc3L1FqOHh3S09YTUFqaitRZ3FubG9aMFoxL2U1ancwYlo4WHJ1cGdmdE9I?=
 =?utf-8?B?eDZQR2RzcjczR2d5QzlTeFdYdzF2aWo1eGRRS09GTFcvcnZvcHBkUDB1bmhK?=
 =?utf-8?B?WFdqa0NKRkZCbWhGUnp2VTNHeXUrNU9xYkZNaXFTTkdWbklCMGRQb1l4dXlD?=
 =?utf-8?B?aEhFSHdodGJ5VGw4TmM1b2VuUTJmcnBBYmpSNUdhRktoV3phWW83MHJONWY4?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a8c4e1-14b9-41b8-5f9f-08db6261e9b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 05:34:48.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcvZVUpQubh92cm1LEbbzbn/wBVyu0zbrDf1+4gQ46HpYYJoTO24wz9sl8H0/9O/C62h3LAU9GkAp39vlc5wZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 05:34:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11715

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=6&day=1&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/05/cip.2023-05-25-12.02.log.html

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

