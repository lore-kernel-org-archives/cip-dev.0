Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9877C3DA7A
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 17:23:35 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.57])
 by mx.groups.io with SMTP id smtpd.web11.40824.1672680206071338581
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jan 2023 09:23:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fG0QXBZX;
 spf=pass (domain: siemens.com, ip: 40.107.13.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bml/VlvBNI6ShJNRgPxCyJadjp74bv0nAGbEyZXko/aYbUL1RehVhQzPnQEeLXnDje6CV125G7Iae+WvTj3jqO0WDLX13fdpMpk3hzesTyG3/OKsgBQM7uSATYUGGzChwl//tSRbtY59sv1EcjEXMIc1jzl8vI+/qE3ngi5eDsbrM9uMPmIn+j6khA4VnsKUKqGDjKXq2OofyywSf7lfHd14skIFEZ5F9oOKtbdGuU5tEykZLjSKP10TG9cq5sxgkVpW1UeWc2HfVo4H3I7expD1ZAiw1d81Zl99gOeePMInHyRP7Sm95BYcUlNtjGp17sLhSZx/3AsIRZtMbClGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHXeS2cUU01eyq/ztRgJPV0r763UstgvKoEQCwXQhwI=;
 b=gVeAonmTHyClH2+mXhU6hRLjRyES+yeIFW5kOnWHaZTGTJax2LdSqfUqOmtJOUVHF9sbCiPYqjFrnwBZp/J90iobNFPqOttr5YQCNpvyNfAnnQmtJA+lRXKu+PDObltQjopFA1XOybzZB3uKlu+Ae3gct0zK7+M7I67B7nDzCbBj9DZfUctt6CuZSkZLaDvFGbbv3mFmujYjArwt+GQ2tf9qsLNxBxv9eSBZldhMDHoS+CXtFVifnSRUCiRtb1gCCfrE9xmiM+SNRukB84WXZvEfa/KSeb+peNyyQcf0Lp2vyAQtzaDMfgidTCSRM520RE/xqGGR87pN8mmEZBvEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHXeS2cUU01eyq/ztRgJPV0r763UstgvKoEQCwXQhwI=;
 b=fG0QXBZX0qh5srV+jSr29pb2SW8jUGE/5YyB4MZCjyBD9uaDn8ei9phZY4G8q/2TMrl1Kzm1eiew5f47nx9AlAIHKAuG0sY87WLzV5/jd/o8csD3uMI2j7O0BuQfOPN4ADcIijXWmRdMpyLn28Ji6lWWBiVjajaOXknqHMU/4CGxCja2s2DNHaD99znYHCSdTm/6TS0IDYtujT1TDTXzfhgFUJncbG9GzP+82QJdfj96ywxIwAKetkqFTzdfhE60pthyEkQxQUcKRl9F0vtaiEXk+fcNuC6f+nNnQfLB8GtfKPtBvrY72bw66o3atiO/8lrZo6KL0g5rARMTRWH1vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3301.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 17:23:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 17:23:22 +0000
Message-ID: <cc067eff-9d1e-0fc7-f0cd-8c936f930ef0@siemens.com>
Date: Mon, 2 Jan 2023 18:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/6] improve root home moving for
 layers
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>
CC: cip-dev@lists.cip-project.org, Wang Jing <wangjing@siemens.com>,
 Gylstorff Quirin <quirin.gylstorff@siemens.com>
References: <20221129122451.32155-1-henning.schild@siemens.com>
 <8a8848a0-a801-78bf-e4db-162c19aa3f31@siemens.com>
 <bee9645b-15e1-0f93-d0b5-df8974711459@siemens.com>
 <20230102180405.6cc06e3d@md1za8fc.ad001.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230102180405.6cc06e3d@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3301:EE_
X-MS-Office365-Filtering-Correlation-Id: 087fd39e-de72-4d41-5a16-08daece60c90
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	79Rc1tBXqRNsd3GbWCxFBT+PLLyfqoJY+S60CiDPp7BOZRiATdt91X1Gkd9ZNHlh1/H9AuXu3LbUeIOsoQQOp5GPP2jNe/846AkymOXNYlE4wUdoqr7hBUlU1q69f9x3wxDuiTinCEybIclgXufZuJMfVeBRJJ4xl7k4055I8oIOlKalct+SGZIiqQC+NQGMIpRXGRvkP8dopXhDRDg2xXouN3Z4QHnYL2JkPUrd066NGqNv0ORRuCrFWBMxTw2Y8azLP9Em6zI9lc24sT7Y4WTEOveZ7suKEHIfTwvvrURn0tBf0VH/d9noY7eDy8CCwuKwunOIIP9iEWofzOu45iekKGVx6WpCX+1F1D6QtsI0hwN9Rs7z4VOTpugRMOssO43DacSNJctrZBNZ/ZQkZ441eJYP1YMSz/IxSQpYdK7MV0H8mHPbpNCxiJmjSbYy/046Pwbz/Y1N/GbaCrSO740OmWvg4YdoKm3WOCPEfEg0SkyaRW49GXbzhfyhsvGUiYqLcbKOG7kZRfeG+8+B6a54+ToxOZiL+UP64Xldj/woEkJiR+qnAjpSCxkPj9N7pPqfkncP0YY06o0C/vIt+NNZ+fp5DRTF2CKhv6DNN2DoZ5NTSqeZ4g5oql8UjhMAaM36K9zrwxk6qAlkDL0oC4Dj6JePjb3XOY6BQQQETLPNzMscgY6dKw+thl4HqNnTn3oMEg6sAwoxHv+rw4SielZ3I5vhz/aD1GdAfjR8O54Ip/7yO6E639vhntMeWx3so3Wj+rdNykmXQaJX2a/efxXtt32T43XAkF0hqBVctoGjIlg4deHrJzhRSI7Zlm4L
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(36756003)(66556008)(66946007)(66476007)(2616005)(8676002)(4326008)(41300700001)(6636002)(316002)(37006003)(54906003)(2906002)(31696002)(86362001)(83380400001)(5660300002)(82960400001)(38100700002)(6862004)(8936002)(6486002)(6506007)(44832011)(478600001)(53546011)(6666004)(107886003)(6512007)(186003)(26005)(31686004)(966005)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K4Yi5RreyVGK00w1iM1w/cpJ3x1W8J2I6ee8DyUpsxXvDMlmZPbW1c/RzTM2?=
 =?us-ascii?Q?VmSgKL1/4SJDqGDvaemMpPBbcSa03eFy3UR2S220i7lAn6DzzslKmW/1q5B7?=
 =?us-ascii?Q?cFCTG4uxFkv1NropkAd/EoTIIlgMYA/QF5aVp2rPYgzUvB27D9Wqp8Cn4rzM?=
 =?us-ascii?Q?mayA0Woopl61Cg77AYnoxH1JRjeaZN6D5YqSydgyovGzC+kdgItdeSq6dQbD?=
 =?us-ascii?Q?7jErSAPiUwbrQsQhLcJYhlVUgOZMgUMCx8XnTtAMWhXg2/6+FkChE/wF3OKv?=
 =?us-ascii?Q?gwqIhQ0o9dW9VVpHdI1N67EYG5kh9QnC3d1JI7ocaBKsL7K1WUQIOYibHXEJ?=
 =?us-ascii?Q?u7p5BdzVQDMBkj1jYp96H8uh1OSu4lTQcblkpBkuvolaUY5GQoBtAcs1yvRY?=
 =?us-ascii?Q?nN0PFE+c4jONc+nvJjGAwIlolBiDTuMJa+8+QCtS+5iUz7Q/XnAc3k6R3uhQ?=
 =?us-ascii?Q?+vpO/IF8+OQ5jBvf2U8pysDeLh1hxKxMypTdDFhTPIhvK1AJqFRmG6+rTHTs?=
 =?us-ascii?Q?RVck1sQUJTawS9Kyp2CSz2g2Cetq6/i+n2SM1ODyxkNT+XC5riOes3/3+u3D?=
 =?us-ascii?Q?XzkFQJ0v3IxlprXm41sVBj6PDCeN2/uYL/KSvwk8HFEAUCWIC20AV9+xCjey?=
 =?us-ascii?Q?zRESghPtmqT5CK/FvjEzMaaz/Hx1DQGg6MgCZyjmiY+/zUewc6oL5dgc6R4w?=
 =?us-ascii?Q?SgSDpN8sRZPP4/dglXDXumFpHUN2wWQI0U8/4zD4tc3CEcVRAa3qYBannrxf?=
 =?us-ascii?Q?fOYld2cmRipI1D9ZOQvRTReEWNQsg2VLTXLGEuXBSVEmVV36xcdqqCd8WXPa?=
 =?us-ascii?Q?G9j7kfVOPqGGUZ+zTcyMSqBCQYhN7lb5T3JAokvkYZ64WKZb2VYWil5jFnMv?=
 =?us-ascii?Q?Vg82INAmld00j5PvaWqiJXOq4YEQSA13IdsNwkS0fT/kQO7WgwRZSdBYSC3d?=
 =?us-ascii?Q?kWgxNpRzEJ36jO+Otvn8vNnNfyo0LgBhcVbihrhjDGpa+fjYLY2X5KrPD5qo?=
 =?us-ascii?Q?FrHjNxcYmFvp5ta6/aoKeBfTpYFl5vLUdAm/Gl3w7z2IquqCh5WkNCU6smg2?=
 =?us-ascii?Q?upa0dXLkfzA8zdUHfypnjQbXAx8QdxmFOFAzVVTeNteoguLd2z8DiDqcOUkf?=
 =?us-ascii?Q?SuVIOUceA/rMAtO3/i6ZdWZrH6uKKN+8KWODrz1fu5L1jvhkL/IQc48WNWTP?=
 =?us-ascii?Q?gL525oQ4XJ/MNBAFufZ8hcz4hPuJqhLTewYpT37sUKUe3TaVGmzKF8epYZ3/?=
 =?us-ascii?Q?dPdUg8iaVp2F6nTPuAu4bVkoyY/PPx6RhWVmc1WM7VrYVOmc2Rtu+dQcLkyJ?=
 =?us-ascii?Q?8QxjOa03aZ9ay1OREXAOhMO3lzaX8akKyqlXOJL10bQM+Fgtl26C+BOET9SV?=
 =?us-ascii?Q?rnRQJ8guhfp23dNtPwcq0Dl1/a6m/034JG0kLFdU53kW5XOWzyb+CjEnJucZ?=
 =?us-ascii?Q?c50uXxnCvRRMD29HxaUMR0VqGodtnZLeZKVBLKt/Tvky4GaWf7Y9W/xGM0O0?=
 =?us-ascii?Q?28c8s9hD2mTcfP/Dfrrgb7fBh3ruatITHOXzTtMonQ0fWehVO1rRXsh/zfK/?=
 =?us-ascii?Q?kp1wLUouDxJVZnMZOji59Obv6doO9rRAPDDJexd6gCcucTljQjrF+NPzokKM?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087fd39e-de72-4d41-5a16-08daece60c90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 17:23:22.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyszlT9w3hBtgBL5fQtrVvxYqBIcMbIBrs3QfJNSI+cIMyvEWqTi0UoYCGL4UsJndvkzmdBFhcU2UWGeg/aTqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3301
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jan 2023 17:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10276

On 02.01.23 18:04, Henning Schild wrote:
> Am Mon, 2 Jan 2023 11:42:29 +0100
> schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>=20
>> On 21.12.22 14:01, Gylstorff Quirin wrote:
>>>
>>>
>>> On 11/29/22 13:24, Henning Schild via lists.cip-project.org wrote: =20
>>>> The original idea was to make the rootfs home dir move and symlink
>>>> reusable in another layer, while also playing back some findings
>>>> from that other layer.
>>>>
>>>> That is p1...p4
>>>>
>>>> p5 and p6 are drive by findings, feel free to pick in any order i
>>>> do not care about them too much
>>>>
>>>> Henning Schild (6):
>>>> =C2=A0=C2=A0 customizations: make postinst idempotent
>>>> =C2=A0=C2=A0 customizations: make postinst script report all potential=
 errors
>>>> =C2=A0=C2=A0 customizations: comment why we can not actually change ho=
me
>>>> easily change-root-homedir: split root home move into own package
>>>> =C2=A0=C2=A0 kas: set clear text root password
>>>> =C2=A0=C2=A0 CONTRIBUTING: fix note on patch prefixes
>>>>
>>>> =C2=A0 CONTRIBUTING.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>> =C2=A0 kas-cip.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++--
>>>> =C2=A0 .../change-root-homedir.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++++
>>>> =C2=A0 .../change-root-homedir/files/postinst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 21
>>>> +++++++++++++++++++ recipes-core/customizations/common.inc
>>>> |=C2=A0 5 +++-- recipes-core/customizations/files/postinst=C2=A0=C2=A0=
=C2=A0 | 10
>>>> ++++----- 6 files changed, 37 insertions(+), 10 deletions(-)
>>>> =C2=A0 create mode 100644
>>>> recipes-core/change-root-homedir/change-root-homedir.bb
>>>> =C2=A0 create mode 100644
>>>> recipes-core/change-root-homedir/files/postinst
>>>>
>>>>
>>>> =20
>>>
>>> Looks good to me. Tested with qemu-amd64.
>>>
>>> Acked-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>  =20
>>
>> Didn't hit the list and also patchwork. Please check for the reason
>> and resubmit.
>=20
> Ok i will try again but i wonder how Quirin could have it when he was
> never on To or Cc. I would not really know what to check on my side,
> will add Jan to Cc but not Quirin and we see who gets it which way.
>=20

Seems it did actually hit the list (that's where Quirin found it) but
not kernel.org (where I'm reading things):

https://lists.cip-project.org/g/cip-dev/topic/isar_cip_core_patch_0_6/95332=
873?p=3D,,,20,0,0,0::recentpostdate/sticky,,,20,2,0,95332873,previd%3D16726=
59862011165206,nextid%3D1671491382031296064&previd=3D1672659862011165206&ne=
xtid=3D1671491382031296064

vs.

https://lore.kernel.org/cip-dev/bee9645b-15e1-0f93-d0b5-df8974711459@siemen=
s.com/T/#t

Sigh, this is annoying. Will open an issue with LF support again.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


