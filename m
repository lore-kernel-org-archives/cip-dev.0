Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB44EB64D9
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 13:08:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web11.7000.1687180113150889791
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 06:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YlminlSK;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPxODPhttdzwGEq04N2LIlfhQjgDnF7eqhWepNMMpxP9FsfEwvLbUH8upLBvZ2Kss1RAP1qg/c1uSttqCQYGBW8TbN5WgEmrlZeZTZhcXhvOnZNmbnaVxi1Ff24XbXfK74kiCiiHV4mw3NwlVfpTYOThvy7XdNJfVws8rfp7WqT1qmXeUFWTgrvUrBbvjRkcXTcO/9WYIvFGxyFxy8sjP0c2R72/6pxih15e/x8tGsis7kBMWWq1sOi7d4Cd5OI+4PzNHpuJplR2C5nrJgWBzGHFT5GMeTtjGPuVtm/FF/OnngabN3noREwSpsosonOYKvsZnA0kiGgWpm8YqutEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzBne9qpzLyFLDN9D0ENVPPSAHfE3pd+SGR/mrSW+Qk=;
 b=DF6nIFbpYTp3H8efbcdJ80h86CYr4ZXUW9W9py0puEvyFAkXQCnMl0Sc7548OCQm7nRsCELv9uaP5AOu1Sl1WP1SHc9auy+EVGecqss7yaubC8lphBViw6oOJDjeYCetC9ww7DnBzGPlhSrHl5ctEwNSCQ8FTqS5uXjsJNm3FLSlkzLQu6W4ipE7tR4B8cxspMmDT6usizKEM1eL3SEKDJyptINZ+tqQJGtzH7R33Q7CyB4nMuGW6VD2f6j+ZKVmpkL+hh0FgrpPSGzZG1cSFiVd/RMGjUrqfczReaO7IjkfjBMxhGB2MsiMbvm5CCN/+uxTePdbu1NB+zvf//O2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzBne9qpzLyFLDN9D0ENVPPSAHfE3pd+SGR/mrSW+Qk=;
 b=YlminlSKKELLmN5BG8sBjwMIffAGA5+Crke8L9LsAHR8AmaJyZCYwC6dbwXOB8RuPU1AFtUBqzRlJtE+PQvaVhvamzSmGxbwpk8kZMVv8dv8b/KJkS6xmDOFL102aYeneAgwT5pXDeP7sttM22Ne655pZ7hZxJpf0qSYlzNO2JK7g/nqbpGY7gxFyLmxF9V4Vlnkwnu1rxKgYJmK2+7hxwkx1gRrPQVZILkX3WJht3TngjIfyqEmq/K8OLVWiI9bhHSnw/qtl0Xwu0kw4GKdKkIhsnqtgsLFbdDf6m2aPcU9a08kBxkySiCHyrw7T9zaeQsUsw4FiSOyZfZJj7nFtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB6140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:79::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 13:08:29 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:08:29 +0000
Message-ID: <40624a74-e2e1-f1bc-5fec-eeab8c0f4b48@siemens.com>
Date: Mon, 19 Jun 2023 15:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Update to 2023.05
 with wfx support
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, christian.storm@siemens.com,
 cip-dev@lists.cip-project.org
References: <20230619105015.195380-1-Quirin.Gylstorff@siemens.com>
 <94ab0687-0b45-b10f-3115-5d336aaae83b@siemens.com>
 <946aa906-b596-b1fa-a66b-4b61106e2cc6@siemens.com>
 <9c903f05-5ea0-9f99-dfee-10a0c6ac39b3@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <9c903f05-5ea0-9f99-dfee-10a0c6ac39b3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e58eb3-0c7b-4c03-ea0c-08db70c646ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FdU8iIZ1lQXGE3Yte8Hr4YxJSqD5iraFUisMhKc/EAQ1WPmHbMtdMYBiWcuYRS/Lsv/NWxW1Vvwr850koOiPsgNmARcEzkLcmVvJdOiI1IBb6kTBOP3gseZVMLf6+KNjYYEtOkoaOgWfRMSNC+3NY0YwGfEy7EKl90rnifVLe89LV84T6nc7uw7gykqpH/CAeBpEfYAFrOYZJWRks5Ebj7efFCwPvqjVwjTXkBA1x2XKhv2b0cFUrSL6zISMllBFq76X++MUfS0gNA7xFUa0DR6H96veaszQAYvt9hpANXUh0xiJgrqJ91uCRO9Bxpi5BQE6HKEfCPxkq41rjW7882hZdjutctYLGXKoW+xQgREK7LMG9F/5ETzoq4AhKIT8gFeeIt2tVzBadGYMHUYkQdWwnFlkrkbbhzr031L8aQzCcZX9q93ViYm5tPggTXmA0Rj4ryS1ct3JucvAoX/+Y1fTTNMqKAfvhohgbrEmf7g6D2MZ9DHwI3T5mUo2COSa+49Wdgwk7ZwwHZmbqP1yjrrynIrkCH9adbWdOz2Ka/82Y/L09tl8tNARGY5fTbQ20TYv744u9//sdghA8cOk9xuxlcbyKN4SRE4rpIGFeFJ7i4A+r2eMy1AARf6LMUaL+aJLjg4V7vNXJUdN3tGPAQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(26005)(6506007)(6512007)(53546011)(31686004)(2616005)(6486002)(36756003)(186003)(6666004)(478600001)(83380400001)(19627235002)(82960400001)(66946007)(66556008)(66476007)(8676002)(8936002)(31696002)(66899021)(5660300002)(15650500001)(30864003)(2906002)(38100700002)(316002)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/JcKDZ7/s5WexwjppTb2BSdwjBAUdcFwu5g2xOFqt6ak0VjRG5OO7rQ87xUn?=
 =?us-ascii?Q?kZRYWmY5thhVphTUlFCmuVDihhFgxMHHUPw5sbCeVb+CYJNuWBs99dggdfLf?=
 =?us-ascii?Q?CMDG8POSSsADV5gw67Ntl9YegVknfAW3+BCSVbNrlg733QIWBfUUxLNmIMfr?=
 =?us-ascii?Q?36uIdILw275sT0OxBbKz+2UGXQzTS4ovnS8UFtndPF/3GvPt1zIAtXUCUyWj?=
 =?us-ascii?Q?w2G+QXA3opFstfqzofC+HfZaFMEarl7/zBMiaz2mxMmGlMrG6HdlBEX9anx2?=
 =?us-ascii?Q?rXtROn1DVlZj9XB48behKETF3myJhKia803x8Sc9JEtIPGCnyuJcr2mHbTYV?=
 =?us-ascii?Q?mXDjvCeRRF+ifDmqHps/88PzDqd2idGr8ywk61ayfXGzsd+1ADd1Xrz4vBL/?=
 =?us-ascii?Q?oyVDGXcgOA4H+XnmzD0JJGaE8o36L1Qndn2lo4raEusMDRhXaVrseBZ/hSJp?=
 =?us-ascii?Q?ySpy0DWmqYTL+obqji/fZneCCg9Zp1kctDsbtlpV1UsvRVtjFsbfPu0UzkZI?=
 =?us-ascii?Q?XJShoLGr5HNhMiwXY17b3F5tLTfr9adw6pu5slMmNaojDJAEMA7kJyG8eusj?=
 =?us-ascii?Q?x/IGgalG0omaVQlW801SwR/CXmsYUOmWAnFDEPSh8V0F3vVJL50+I0jTWUwn?=
 =?us-ascii?Q?6NcpXCxhVBDg+OEjj4F9HYu+OQ6zPs7CMpwmk4WdnClEIBI2QrqjlUJs7rfN?=
 =?us-ascii?Q?azGOHatvzbmppKBAJprYrNujI3a+A92tWWcL5Rxvpn4+FeogdrUpbR0LRD/4?=
 =?us-ascii?Q?JAAJiSDBWPT/slcXvTB5ALm5KVm36FlEip9qfmcfqLqgeKyP3s9Nb2AQOsAW?=
 =?us-ascii?Q?mfPpl3EPJeXHIat9W/8uUyUw2dbtM4U4nuAm6DhC+d6SEWlzOfKGK9drZLFD?=
 =?us-ascii?Q?l46GVFPYiSpm45dEPIK88/3zPe7pDPpU7sosAsTDA6HcbvflHyKjM+ldQUwK?=
 =?us-ascii?Q?gZT1Rs0jFZKZeU6O2Hi47W3XZZr/vSzksiiGEw7cZm8yIpw/ceZJAk7vfu2y?=
 =?us-ascii?Q?8rNViiNKjOAuG3XdUk/hM+Gj9uTu7cpia8fRgGVPP438YsV6sUl/7eskAxUh?=
 =?us-ascii?Q?6K6bLGFh6K7lSMEcLqpzJEB2tNs+9TUnZNiYaKN2whs5E5nqaMnFNrRIq/CS?=
 =?us-ascii?Q?YrRcRhsCCAcFYNMGeyNCBapisT7Pqu1sSCfKjT4uuUga/CIRpXqjxmBOV6e7?=
 =?us-ascii?Q?tejhLGmcAiRjiuUpbaRl5yspMa5hs5nA5WYBSjqZCeSPulW7uQS3G7FvO00B?=
 =?us-ascii?Q?Q1HvNfVNDt6ya8wcsqIFnSRYMtb9hu+xxzVTjhPrcA1MOdPMq1ME+3ntx71K?=
 =?us-ascii?Q?hfDQdu8sJnZEbA0Dt4p0mPNJ3SjKhrEZBlpN7Q8e8K/+0H0GvYFOnR1Ro63c?=
 =?us-ascii?Q?xhga3uHn/cFYGYHFNs5VFg0p6Q/X4R/G6sPxQJeE83SOTAOuJKmP+65oNT2P?=
 =?us-ascii?Q?91bRpCUPzvnNl1GWxWY1pbrlGr9Dnf3vuYt2QTHNzAZz/dR7w+YH4Xzbvgdg?=
 =?us-ascii?Q?0oe0TkMe4LGZPitgE+8NHSy+B3BnZrDs8bmxh7sCDf1f3HT5W0SmdtbddykR?=
 =?us-ascii?Q?MQ7GBaEY7f/cYcQbpMgz2mGLiofrmna6gUgSEyIaFIHaFGAa8NBf40tbIlJN?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e58eb3-0c7b-4c03-ea0c-08db70c646ad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:08:29.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68Lu08syonQG/qrFkeCPnzjHMxauc45+QV9SZ2QsIb/SHAV85Rqh2jHdTldVCMTe/vWFEAe81POdukCIqPcT1ymoDTM5hfLRP45sFHrKLbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 13:08:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12075



On 6/19/23 14:49, Jan Kiszka wrote:
> On 19.06.23 13:57, Gylstorff Quirin wrote:
>>
>>
>> On 6/19/23 12:55, Jan Kiszka wrote:
>>> On 19.06.23 12:50, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
>>>> (tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.
>>>>
>>>> You can enable wfx by enabling during in the systemd service by writin=
g
>>>> to `/etc/swupdate/conf.d/suricatta.conf`:
>>>> ```
>>>> SWUPDATE_SURICATTA_ARGS=3D"-S lua <wfx arguments>"
>>>> ```
>>>> For the <wfx arguments> see 'swupdate -h'.
>>>>
>>>> To switch between wfx and hawkbit exchange `lua` with `hawkbit`.
>>>>
>>>
>>> There is still no note that we disable delta update support with this
>>> version, right?
>>
>> I will send a v3.
>>
>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> Changes v2:
>>>>  =C2=A0 - add patch to display swupdate version
>>>>  =C2=A0=C2=A0=C2=A0 - this Patch also sets the EXTRAVERSION with packa=
geversion+git
>>>> commit sha
>>>>  =C2=A0 - set CONFIG_SURICATTA_WFX to always enable wfx
>>>>  =C2=A0 - use version 2023.05 as it is the version stored in the swupd=
ate
>>>>  =C2=A0=C2=A0=C2=A0 sources
>>>>  =C2=A0 - move patches to version specific folders for readability
>>>>  =C2=A0 - Add instructions to start swupdate service with wfx
>>>>
>>>>  =C2=A0 conf/distro/cip-core-bookworm.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>  =C2=A0 conf/distro/cip-core-bullseye.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>  =C2=A0 conf/distro/cip-core-sid-ports.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>>  =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
>>>>  =C2=A0 recipes-core/persistent-fs/files/data.mount=C2=A0=C2=A0 | 13 +=
++
>>>>  =C2=A0 recipes-core/persistent-fs/files/postinst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +
>>>>  =C2=A0 .../persistent-fs/persistent-fs_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 20 ++++
>>>>  =C2=A0 .../0002-debian-rules-Add-CONFIG_MTD.patch=C2=A0=C2=A0=C2=A0 |=
 27 ------
>>>>  =C2=A0 ...-SWUpdate-USB-service-and-Udev-rules.patch |=C2=A0 0
>>>>  =C2=A0 ...ules-Add-Embedded-Lua-handler-option.patch |=C2=A0 0
>>>>  =C2=A0 ...es-Add-option-to-disable-fs-creation.patch |=C2=A0 0
>>>>  =C2=A0 ...ules-Add-option-to-disable-webserver.patch |=C2=A0 0
>>>>  =C2=A0 ...ch-to-fix-bootloader_env_get-for-EBG.patch |=C2=A0 0
>>>>  =C2=A0 ...prepare-build-for-isar-debian-buster.patch |=C2=A0 0
>>>>  =C2=A0 ...d-rules-Add-option-for-suricatta_lua.patch |=C2=A0 4 +-
>>>>  =C2=A0 ...rate-build_profile-option-for-delta-.patch | 45 +++++++++
>>>>  =C2=A0 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++=
++++++++
>>>>  =C2=A0 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ++++++
>>>>  =C2=A0 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |=C2=A0 2 +
>>>>  =C2=A0 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb=C2=A0=C2=A0 | 39 -=
-------
>>>>  =C2=A0 recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 | 60 ++++++++++++
>>>>  =C2=A0 21 files changed, 273 insertions(+), 74 deletions(-)
>>>>  =C2=A0 create mode 100644 recipes-core/persistent-fs/files/data.mount
>>>>  =C2=A0 create mode 100755 recipes-core/persistent-fs/files/postinst
>>>>  =C2=A0 create mode 100644 recipes-core/persistent-fs/persistent-fs_0.=
1.bb
>>>>  =C2=A0 delete mode 100644
>>>> recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>>> (100%)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0002-debian-rules-Add-Embedded-Lua-handler-option.patch (100%=
)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>>>> (100%)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0004-debian-rules-Add-option-to-disable-webserver.patch (100%=
)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch=
 (100%)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2021.11}/0006-debian-prepare-build-for-isar-debian-buster.patch (100%)
>>>>  =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>>> 2023.05}/0001-d-rules-Add-option-for-suricatta_lua.patch (87%)
>>>>  =C2=A0 create mode 100644
>>>> recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_pr=
ofile-option-for-delta-.patch
>>>>  =C2=A0 create mode 100644
>>>> recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-th=
e-build-version-to-swup.patch
>>>>  =C2=A0 create mode 100644
>>>> recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-=
suricatta_wfx.patch
>>>>  =C2=A0 delete mode 100644
>>>> recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>>>  =C2=A0 create mode 100644 recipes-core/swupdate/swupdate_2023.05.bb
>>>>
>>>> diff --git a/conf/distro/cip-core-bookworm.conf
>>>> b/conf/distro/cip-core-bookworm.conf
>>>> index f05d3d3..adafc92 100644
>>>> --- a/conf/distro/cip-core-bookworm.conf
>>>> +++ b/conf/distro/cip-core-bookworm.conf
>>>> @@ -12,6 +12,6 @@
>>>>  =C2=A0 require conf/distro/debian-bookworm.conf
>>>>  =C2=A0 require cip-core-common.inc
>>>>  =C2=A0 -PREFERRED_VERSION_swupdate ?=3D "2022.12%"
>>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>>>  =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>>>  =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>>> diff --git a/conf/distro/cip-core-bullseye.conf
>>>> b/conf/distro/cip-core-bullseye.conf
>>>> index 9c83054..4f26299 100644
>>>> --- a/conf/distro/cip-core-bullseye.conf
>>>> +++ b/conf/distro/cip-core-bullseye.conf
>>>> @@ -15,6 +15,6 @@ require cip-core-common.inc
>>>>  =C2=A0 DISTRO_APT_SOURCES:append:swupdate =3D "
>>>> conf/distro/debian-bullseye-backports.list"
>>>>  =C2=A0 DISTRO_APT_PREFERENCES:append:swupdate =3D "
>>>> conf/distro/preferences.swupdate-bullseye-backports.conf"
>>>>  =C2=A0 -PREFERRED_VERSION_swupdate ?=3D "2022.12%"
>>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>>>  =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>>>  =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>>> diff --git a/conf/distro/cip-core-sid-ports.conf
>>>> b/conf/distro/cip-core-sid-ports.conf
>>>> index edd3c28..2e74af7 100644
>>>> --- a/conf/distro/cip-core-sid-ports.conf
>>>> +++ b/conf/distro/cip-core-sid-ports.conf
>>>> @@ -14,6 +14,7 @@ require cip-core-common.inc
>>>>  =C2=A0 =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>>>  =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>>>  =C2=A0 =C2=A0 DISTRO_APT_SOURCES =3D
>>>> "conf/distro/cip-debian-sid-ports-snapshot.list"
>>>>  =C2=A0 HOST_DISTRO_APT_SOURCES =3D "conf/distro/cip-debian-sid-snapsh=
ot.list
>>>> ${DISTRO_APT_SOURCES}"
>>>> diff --git a/recipes-core/images/swupdate.inc
>>>> b/recipes-core/images/swupdate.inc
>>>> index ebc844a..6a01abb 100644
>>>> --- a/recipes-core/images/swupdate.inc
>>>> +++ b/recipes-core/images/swupdate.inc
>>>> @@ -12,9 +12,6 @@
>>>>  =C2=A0 inherit image_uuid
>>>>  =C2=A0 inherit read-only-rootfs
>>>>  =C2=A0 -IMAGE_INSTALL:append:buster =3D " swupdate"
>>>> -IMAGE_INSTALL:append:bullseye =3D " swupdate"
>>>> -IMAGE_PREINSTALL:append:bookworm =3D " swupdate"
>>>> -IMAGE_PREINSTALL:append:sid =3D " swupdate"
>>>> +IMAGE_INSTALL +=3D " swupdate"
>>>>  =C2=A0 =C2=A0 IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>>>> diff --git a/recipes-core/persistent-fs/files/data.mount
>>>> b/recipes-core/persistent-fs/files/data.mount
>>>> new file mode 100644
>>>> index 0000000..dc64a91
>>>> --- /dev/null
>>>> +++ b/recipes-core/persistent-fs/files/data.mount
>>>> @@ -0,0 +1,13 @@
>>>> +[Unit]
>>>> +Description=3DMount /data partition
>>>> +Before=3Dlocal-fs.target
>>>> +
>>>> +[Mount]
>>>> +What=3D${PERSISTENT_PARTITION}
>>>> +Where=3D/data
>>>> +Type=3Dauto
>>>> +Options=3Ddefaults
>>>> +
>>>> +
>>>> +[Install]
>>>> +WantedBy=3Dlocal-fs.target
>>>> diff --git a/recipes-core/persistent-fs/files/postinst
>>>> b/recipes-core/persistent-fs/files/postinst
>>>> new file mode 100755
>>>> index 0000000..8a13328
>>>> --- /dev/null
>>>> +++ b/recipes-core/persistent-fs/files/postinst
>>>> @@ -0,0 +1,3 @@
>>>> +#!/bin/sh
>>>> +
>>>> +#deb-systemd-helper enable data.mount=C2=A0 || true
>>>> diff --git a/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>>> b/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>>> new file mode 100644
>>>> index 0000000..c665b6c
>>>> --- /dev/null
>>>> +++ b/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>>> @@ -0,0 +1,20 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2022
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +
>>>> +inherit dpkg-raw
>>>> +
>>>> +SRC_URI =3D "file://postinst \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://d=
ata.mount"
>>>> +
>>>> +do_install[cleandirs]+=3D"${D}/lib/systemd/system"
>>>> +do_install[cleandirs]+=3D"${D}/data"
>>>> +do_install() {
>>>> +=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/data.mount
>>>> ${D}/lib/systemd/system/data.mount
>>>> +}
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>>> b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>>> deleted file mode 100644
>>>> index e62a4fc..0000000
>>>> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.pat=
ch
>>>> +++ /dev/null
>>>> @@ -1,27 +0,0 @@
>>>> -From c3adc5d2be41e151c811c96f2bed245778fec82c Mon Sep 17 00:00:00 200=
1
>>>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> -Date: Wed, 29 Sep 2021 11:29:57 +0200
>>>> -Subject: [PATCH 02/10] debian/rules: Add CONFIG_MTD
>>>> -
>>>> -if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>>>> -
>>>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ----
>>>> - debian/rules | 1 +
>>>> - 1 file changed, 1 insertion(+)
>>>> -
>>>> -diff --git a/debian/rules b/debian/rules
>>>> -index 08b74a1..6705140 100755
>>>> ---- a/debian/rules
>>>> -+++ b/debian/rules
>>>> -@@ -20,6 +20,7 @@ endif
>>>> - override_dh_auto_configure:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 cp debian/configs/defconfig=C2=A0 configs/de=
bian_defconfig
>>>> - ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>>>> -+=C2=A0=C2=A0=C2=A0 echo CONFIG_MTD=3Dy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>=
 configs/debian_defconfig
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_SWUFORWARDER_HANDLER=3Dy >> conf=
igs/debian_defconfig
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_CFI=3Dy=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 >> configs/debian_defconfig
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_CFIHAMMING1=3Dy=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> configs/debian_defconfig
>>>> ---
>>>> -2.34.1
>>>> -
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-=
and-Udev-rules.patch b/recipes-core/swupdate/files/2021.11/0001-debian-Remo=
ve-SWUpdate-USB-service-and-Udev-rules.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-an=
d-Udev-rules.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0001-debian-Remove-SWUpdate-USB-se=
rvice-and-Udev-rules.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handl=
er-option.patch b/recipes-core/swupdate/files/2021.11/0002-debian-rules-Add=
-Embedded-Lua-handler-option.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler=
-option.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0002-debian-rules-Add-Embedded-Lua=
-handler-option.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-=
fs-creation.patch b/recipes-core/swupdate/files/2021.11/0003-debian-rules-A=
dd-option-to-disable-fs-creation.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs=
-creation.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0003-debian-rules-Add-option-to-di=
sable-fs-creation.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-=
webserver.patch b/recipes-core/swupdate/files/2021.11/0004-debian-rules-Add=
-option-to-disable-webserver.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-we=
bserver.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0004-debian-rules-Add-option-to-di=
sable-webserver.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_=
env_get-for-EBG.patch b/recipes-core/swupdate/files/2021.11/0005-debian-Add=
-patch-to-fix-bootloader_env_get-for-EBG.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_en=
v_get-for-EBG.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0005-debian-Add-patch-to-fix-bootl=
oader_env_get-for-EBG.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debia=
n-buster.patch b/recipes-core/swupdate/files/2021.11/0006-debian-prepare-bu=
ild-for-isar-debian-buster.patch
>>>> similarity index 100%
>>>> rename from
>>>> recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-=
buster.patch
>>>> rename to
>>>> recipes-core/swupdate/files/2021.11/0006-debian-prepare-build-for-isar=
-debian-buster.patch
>>>> diff --git
>>>> a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lu=
a.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-s=
uricatta_lua.patch
>>>> similarity index 87%
>>>> rename from
>>>> recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.=
patch
>>>> rename to
>>>> recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-surica=
tta_lua.patch
>>>> index 0be5a71..5aeb605 100644
>>>> ---
>>>> a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lu=
a.patch
>>>> +++
>>>> b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suri=
catta_lua.patch
>>>> @@ -1,7 +1,7 @@
>>>> -From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 200=
1
>>>> +From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 200=
1
>>>>  =C2=A0 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>  =C2=A0 Date: Wed, 3 May 2023 16:02:37 +0200
>>>> -Subject: [PATCH] d/rules: Add option for suricatta_lua
>>>> +Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
>>>>  =C2=A0 =C2=A0 This allows to use lua plugins as suricatta backends. I=
t is optional
>>>>  =C2=A0 as it overrides the default HAWKBIT backend.
>>>> diff --git
>>>> a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_=
profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0002-=
d-rules-Add-seperate-build_profile-option-for-delta-.patch
>>>> new file mode 100644
>>>> index 0000000..4203061
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_=
profile-option-for-delta-.patch
>>>> @@ -0,0 +1,45 @@
>>>> +From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 200=
1
>>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +Date: Thu, 15 Jun 2023 18:48:25 +0200
>>>> +Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for
>>>> delta
>>>> + update
>>>> +
>>>> +Delta update need zchunk 1.3 to work on memory restricted
>>>> +devices. zchunk 1.3 is is not available in bullseye-backports
>>>> +and Debian bookworm(12).
>>>> +
>>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +---
>>>> + debian/control | 2 +-
>>>> + debian/rules=C2=A0=C2=A0 | 2 +-
>>>> + 2 files changed, 2 insertions(+), 2 deletions(-)
>>>> +
>>>> +diff --git a/debian/control b/debian/control
>>>> +index e47c320c..d4b17972 100644
>>>> +--- a/debian/control
>>>> ++++ b/debian/control
>>>> +@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (=3D 13),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uuid-dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 zlib1g-dev,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libzstd-dev,
>>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 libzck-dev (>=3D 1.2) <!pkg.swupdate.bpo>,
>>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 libzck-dev (>=3D 1.3) <pkg.swupdate.delta>,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libp11-kit-dev <pkg.swupdate.p11>,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libwolfssl-dev <pkg.swupdate.p11>,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libmtd-dev [linux-any],
>>>> +diff --git a/debian/rules b/debian/rules
>>>> +index 91106fbd..8cac6359 100755
>>>> +--- a/debian/rules
>>>> ++++ b/debian/rules
>>>> +@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
>>>> + else
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo "# CONFIG_MTD is not set"=C2=A0=C2=A0=
=C2=A0=C2=A0 >> configs/debian_defconfig
>>>> + endif
>>>> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>>>> ++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_DELTA=3Dy >> configs/debian_defc=
onfig
>>>> + endif
>>>> + ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf
>>>> riscv64 ia64))
>>>> +--
>>>> +2.39.2
>>>> +
>>>> diff --git
>>>> a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-=
the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0003-=
d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>>> new file mode 100644
>>>> index 0000000..857b4ab
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-=
the-build-version-to-swup.patch
>>>> @@ -0,0 +1,94 @@
>>>> +From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 200=
1
>>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +Date: Fri, 16 Jun 2023 19:43:38 +0200
>>>> +Subject: [PATCH 3/4] d/patches: Add patch to add the build version
>>>> to swupdate
>>>> +
>>>> +The build version is only set if build in a git repository
>>>> +this patch allows to use the version information stored in
>>>> +the Makefile.
>>>> +
>>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +---
>>>> + ...Set-version-if-git-returns-no-informa.diff | 46 +++++++++++++++++=
++
>>>> + debian/patches/series=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> + debian/rules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +
>>>> + 3 files changed, 49 insertions(+)
>>>> + create mode 100644
>>>> debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.di=
ff
>>>> +
>>>> +diff --git
>>>> a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.=
diff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.=
diff
>>>> +new file mode 100644
>>>> +index 00000000..7f964fb7
>>>> +--- /dev/null
>>>> ++++
>>>> b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.=
diff
>>>> +@@ -0,0 +1,46 @@
>>>> ++From bc50744125e8686ec2eb7e5676522da98e51601f Mon Sep 17 00:00:00 20=
01
>>>> ++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ++Date: Sat, 17 Jun 2023 17:56:18 +0200
>>>> ++Subject: [PATCH] Makefile.flags: Set version if git returns no
>>>> information
>>>> ++
>>>> ++This set the swupdate version if build in a non git environment.
>>>> ++E.g. pristine-tar build or from a release tarball.
>>>> ++
>>>> ++Also allows to set the EXTRAVERSION from the command line.
>>>> ++
>>>> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ++---
>>>> ++ Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>> ++ Makefile.flags | 3 +++
>>>> ++ 2 files changed, 4 insertions(+), 1 deletion(-)
>>>> ++
>>>> ++diff --git a/Makefile b/Makefile
>>>> ++index 09d03a34..1004945c 100644
>>>> ++--- a/Makefile
>>>> +++++ b/Makefile
>>>> ++@@ -5,7 +5,7 @@
>>>> ++ VERSION =3D 2023
>>>> ++ PATCHLEVEL =3D 05
>>>> ++ SUBLEVEL =3D 0
>>>> ++-EXTRAVERSION =3D
>>>> +++EXTRAVERSION ?=3D
>>>> ++ NAME =3D
>>>> ++
>>>> ++ IPCLIB_VERSION =3D 0.1
>>>> ++diff --git a/Makefile.flags b/Makefile.flags
>>>> ++index 2a021c89..8eada8fc 100644
>>>> ++--- a/Makefile.flags
>>>> +++++ b/Makefile.flags
>>>> ++@@ -7,6 +7,9 @@
>>>> ++ #
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>>> ++ SWU_DIR =3D $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))=
))
>>>> ++ SWU_VER =3D $(shell git -C $(SWU_DIR) describe --tags --always --di=
rty)
>>>> +++ifeq (,$(SWU_VER))
>>>> +++=C2=A0=C2=A0=C2=A0 SWU_VER =3D $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)=
$(EXTRAVERSION)
>>>> +++endif
>>>> ++ export SWU_VER
>>>> ++ SKIP_STRIP ?=3D n
>>>> ++
>>>> ++--
>>>> ++2.39.2
>>>> ++
>>>> +diff --git a/debian/patches/series b/debian/patches/series
>>>> +index 5638bbf5..12324569 100644
>>>> +--- a/debian/patches/series
>>>> ++++ b/debian/patches/series
>>>> +@@ -1,3 +1,4 @@
>>>> + Link-config-to-swupdate-www-path.diff
>>>> + Replace-Font-Awesome-5-with-Fork-Awesome.diff
>>>> + use-gcc-compiler.diff
>>>> ++Makefile.flags-Set-version-if-git-returns-no-informa.diff
>>>> +diff --git a/debian/rules b/debian/rules
>>>> +index 8cac6359..566a21bd 100755
>>>> +--- a/debian/rules
>>>> ++++ b/debian/rules
>>>> +@@ -17,6 +17,8 @@ export DH_WITH=3D--with lua
>>>> + export HAVE_LUA=3Dy
>>>> + endif
>>>> +
>>>> ++DEB_CHANGELOG_VERSION :=3D $(shell dpkg-parsechangelog | sed -n -e
>>>> 's/^Version: //p' | cut -d + -f 2)
>>>> ++export EXTRAVERSION=3D($(DEB_CHANGELOG_VERSION))
>>>> + BU_SWU=3D
>>>> + ifeq (linux,$(DEB_HOST_ARCH_OS))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 BU_SWU +=3D -VBuilt-Using=3D"$(shell dpkg-qu=
ery -f
>>>> '$${source:Package} (=3D $${source:Version}), ' -W libmtd-dev libubi-d=
ev)"
>>>> +--
>>>> +2.39.2
>>>> +
>>>> diff --git
>>>> a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enabl=
e-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0004-d-rules-Ad=
d-option-to-enable-suricatta_wfx.patch
>>>> new file mode 100644
>>>> index 0000000..9c5ebd3
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enabl=
e-suricatta_wfx.patch
>>>> @@ -0,0 +1,30 @@
>>>> +From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 200=
1
>>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +Date: Fri, 16 Jun 2023 20:32:38 +0200
>>>> +Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
>>>> +
>>>> +Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
>>>> +suricattawfx lua module.
>>>> +
>>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +---
>>>> + debian/rules | 3 +++
>>>> + 1 file changed, 3 insertions(+)
>>>> +
>>>> +diff --git a/debian/rules b/debian/rules
>>>> +index 566a21bd..fc122d0d 100755
>>>> +--- a/debian/rules
>>>> ++++ b/debian/rules
>>>> +@@ -61,6 +61,9 @@ endif
>>>> + ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_SURICATTA_LUA=3Dy >> configs/deb=
ian_defconfig
>>>> + endif
>>>> ++ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
>>>> ++=C2=A0=C2=A0=C2=A0 echo CONFIG_SURICATTA_WFX=3Dy >> configs/debian_d=
efconfig
>>>> ++endif
>>>> + ifneq (,$(LUA_VERSION))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_LUAPKG=3D\"lua$(LUA_VERSION)\" >=
>
>>>> configs/debian_defconfig
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_LUASCRIPTHANDLER=3Dy=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>
>>>> configs/debian_defconfig
>>>> +--
>>>> +2.39.2
>>>> +
>>>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>>> b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>>> index da1434e..2384f41 100644
>>>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>>> @@ -15,6 +15,8 @@ require swupdate.inc
>>>>  =C2=A0 DEB_BUILD_PROFILES +=3D "nodoc"
>>>>  =C2=A0 DEB_BUILD_OPTIONS +=3D "nodoc"
>>>>  =C2=A0 +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/2021.11:"
>>>> +
>>>>  =C2=A0 SRC_URI =3D
>>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3D=
debian/master"
>>>>  =C2=A0 SRCREV =3D"344548c816b555c58ec199f31e45703897d23fb5"
>>>>  =C2=A0 diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp=
.bb
>>>> b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>>> deleted file mode 100644
>>>> index da44ae5..0000000
>>>> --- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>>> +++ /dev/null
>>>> @@ -1,39 +0,0 @@
>>>> -#
>>>> -# CIP Core, generic profile
>>>> -#
>>>> -# Copyright (c) Siemens AG, 2023
>>>> -#
>>>> -# Authors:
>>>> -#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> -#
>>>> -# SPDX-License-Identifier: MIT
>>>> -
>>>> -inherit dpkg-gbp
>>>> -
>>>> -require swupdate.inc
>>>> -
>>>> -DEPENDS +=3D "libebgenv-dev"
>>>> -
>>>> -DEB_BUILD_PROFILES +=3D "nodoc"
>>>> -DEB_BUILD_OPTIONS +=3D "nodoc"
>>>> -
>>>> -SRC_URI =3D
>>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3D=
debian/master"
>>>> -SRCREV =3D"aa9edf070567fa5b3e942c270633a8feef49dad8"
>>>> -SRC_URI +=3D "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
>>>> -
>>>> -# deactivate signing and hardware compability for simple a/b rootfs
>>>> update
>>>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>>>> -
>>>> -# use suricatta-lua instead of suricatta-hawkbit
>>>> -# DEB_BUILD_PROFILES =3D "pkg.swupdate.suricattalua"
>>>> -
>>>> -# Disable cross for arm and arm64 on bullseye
>>>> -# with cross compile we have a unsat-dependency to dh-nodejs on
>>>> arm/arm64
>>>> -ISAR_CROSS_COMPILE:bullseye =3D "0"
>>>> -
>>>> -# add cross build and deactivate testing for arm based builds
>>>> -DEB_BUILD_PROFILES +=3D "cross nocheck"
>>>> -
>>>> -# use backport build profile for bullseye
>>>> -DEB_BUILD_PROFILES:append:bullseye =3D " pkg.swupdate.bpo"
>>>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb
>>>> b/recipes-core/swupdate/swupdate_2023.05.bb
>>>> new file mode 100644
>>>> index 0000000..26c0e67
>>>> --- /dev/null
>>>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>>>> @@ -0,0 +1,60 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +
>>>> +inherit dpkg
>>>> +
>>>> +require swupdate.inc
>>>> +
>>>> +DEPENDS +=3D "libebgenv-dev"
>>>> +
>>>> +DEB_BUILD_PROFILES +=3D "nodoc"
>>>> +DEB_BUILD_OPTIONS +=3D "nodoc"
>>>> +
>>>> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/${PV}:"
>>>> +
>>>> +SRC_URI +=3D
>>>> "git://github.com/sbabic/swupdate.git;protocol=3Dhttps;branch=3Dmaster=
;name=3Dupstream;destsuffix=3D${P}"
>>>> +SRC_URI +=3D
>>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3D=
debian/master;name=3Ddebian;subpath=3Ddebian;destsuffix=3D${P}/debian"
>>>> +
>>>> +SRCREV_debian =3D "aa9edf070567fa5b3e942c270633a8feef49dad8"
>>>> +SRCREV_upstream =3D "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>>> +
>>>> +# patches
>>>> +SRC_URI +=3D "file://0001-d-rules-Add-option-for-suricatta_lua.patch =
\
>>>> +
>>>> file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch=
 \
>>>> +
>>>> file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch=
 \
>>>> +
>>>> file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>>>> +
>>>> +# deactivate signing and hardware compability for simple a/b rootfs
>>>> update
>>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>>>> +
>>>> +# suricatta wfx requires suricatta lua and the dependency
>>>> +# is not set automatically
>>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattalua"
>>>> +# add suricatta wfx
>>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattawfx"
>>>> +
>>>> +# Disable cross for arm and arm64 on bullseye
>>>> +# with cross compile we have a unsat-dependency to dh-nodejs on
>>>> arm/arm64
>>>> +ISAR_CROSS_COMPILE:bullseye =3D "0"
>>>
>>> So, this means we can drop all the backport lists again? But that worke=
d
>>> without native compilation with 2022.12.
>>
>> I tested it on my system and it still necessary for arm64/armhf to
>> build. This is the same as for the=C2=A0 2022.12 recipe.
>>
>=20
> Oh, wow, it's even getting worse then. Can't we build swupdate withough
> nodejs? Yet another build profile? This is a new depencency with
> 2022.12, isn't it?
>=20
> Jan
>=20

Currently we use the debianization as provided by the Debian Maintainer.=20
The node depenency is as far as I know for  webserver/website.

What I can do is to patch the debianization to remove the packages and=20
build steps which require node-js.

Quirin


