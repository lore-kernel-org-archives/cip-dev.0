Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2481CE7849A
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 10:24:00 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.51])
 by mx.groups.io with SMTP id smtpd.web10.78422.1696242237496837166
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Oct 2023 03:23:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MNYijcmT;
 spf=pass (domain: siemens.com, ip: 40.107.13.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNy33g23a3ZpWSXVpRoo4y9MoQuHRNbWqh/c2f5cicRhnM3LAE9V3mHeX2m43tfWF1QEM2a5MuWWEz96iKOlp69TvLBRPjG8wRDWA+grWfmKykz33RNtdsfimHpNdPuVQqImSI6hUG8lUBV+ydkTabQY82IBXgKXuNqKkkzLVGjp5obRfkVoTqXr8KqX+MfHC/bSWAvA8wUKhu8Ty6vJJ+jBE+/1yr4H50m6lBxfCWLRkI3gLlWyL+P3NO3J2dNS0tEDDCRjjdTyBvYYCpkWM/ogRCjXFC28FqDdX2MEYLHSxrnnZEaCPXAyr0wVry6+9UnDgBDR4E2twmUDMN1zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z0Onkh4EWrfcYqe6GJO9xHN224Bkt6GQGeIOwYsYwk=;
 b=Tiibg9Y+ie8ldI5ygDJeuam39vu14yeHCv4AILyt6/zwb8cBquWLDLES4xVsPmXJiHdPEBLl3ItalbSTPGpllUGqnJKXjthDpUOmK1oU0WROfw7hWzORHnmXmiMpcNA+FC+cNYwWJKQ3FRHPRWXCD9ldS20YFgzHK9mD2fcIsYdZ8hVdBa5JynuE6dsxUGDGTdjS7FNOHkWMxOp0a8V796o2g8WXMmsd+nCZu1/gTFM/aMKTfyet5T22jbgcq0zuP1pcxqdpWotrTiZnVv+dTEd/m8NKWPhJfvZXn1ktzbHHVdSms6+UmyAhkMIz04IJE/Cr4T58z9OFSnWfrh1WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z0Onkh4EWrfcYqe6GJO9xHN224Bkt6GQGeIOwYsYwk=;
 b=MNYijcmT60LHhGIS9ySVODa390DYFSWIH/1vjDjRjfA8e1nXDPy/6t2PhX5tz+mv8+HaBOToG1iLpHGQgPi2SEYrgbdKjrKL//pa9hyTHUaHnvqqRPeLVg6ZZhbMpOSn656/g+uMgcOgyQckM+LpNpkJNJ5f3b+kVSVw+9w7MYyWbw+PS2ZbFXuKJNelLcaXpNwR4HdjC7IgRyTAIepwOY0KCBnwQ7T8UwUrD4dvSFuUVSnVaKzaL/0KOvS44yb+inGDO0st+s6R6hj1V10CstxmfyrrhHaNPCmYwTK0En1+73YT75OdNsHl0nOB/LHqKP4b3H4MRUfNcsSx9e3ZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6659.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Mon, 2 Oct
 2023 10:23:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 10:23:54 +0000
Message-ID: <1f5ee65f-5845-4603-9894-6e22ef29cfd6@siemens.com>
Date: Mon, 2 Oct 2023 12:23:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [cip-dev] [isar-cip-core][PATCH] Add support Plat'Home
 OpenBlocks IoT VX2
Content-Language: en-US
To: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
CC: iwamatsu@nigauri.org, minmin@plathome.co.jp
References: <20230823021713.87089-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <e42fde0d-023d-4e03-a081-0d471172c6f2@siemens.com>
 <TYWPR01MB9420D3C6042C375FB255DE1292E0A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <TYWPR01MB94205EE74FE50218B3F3001B92F1A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <bd108908-8c22-4eeb-9a60-f386e300a2a9@siemens.com>
 <TYVPR01MB11245B2B585370AFFC3C2E88F92C6A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYVPR01MB11245B2B585370AFFC3C2E88F92C6A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 3517bb35-12aa-4a11-0e28-08dbc331adab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qkj03YSFqrCz016Odx8QfZC+wcnoHeWNYHy1Fwa16qfnqQnqFjElXp423s5UmoEQUGX4wn6mYhICFWpwGN/sGOavJxa7d6OH1eNHBuYEk5dAWs17kfBTnhcmECt1eazBzOzBPZfBb7uvl4uX5VHE5tggH7EiV8ZUEG0qZC1PXn9fl3PckxDgP+mFVS3Wq8SI4UqrCCBQnBME+hRnICbGS0l5xJoQyLj63h+FJm3wz5jj/j0E8EO6ZO1uER/hH7f1s6XlhvAufZfdIqqC3DO4aCd5J/MioqWO2iGz/Hs5mzdqXUM5LCy9gNaud7gURHusbvbhAPcMBNipAwx8LP3/J2lOQsW4QAbayY5zk5e4ji4JZgHbNEcSvg+jAC9tru3x5OAFxTKQnJjr6NbfeSkJS8Ia/J11KQ7P44EfrHR/Fpdq3Opcivups/ckcFU9Q5DLGLXUcY0yt2Y7wc1zE9KeX8jjxi9j+GuRs5o+6M0N1BQah5QsxqwuotyETNfQdgWm0gdpmVbXdAZH6yK2MLmXxCKkJiE94avqusqqaJTeFCnV2OMyP1iQo0VFsqItOo7Vg5sU8nuRQsbv+eC9N5slA7qPvKEL9JxfD1SVSd0JX/oceTGS2v0SFwczRYY+W0V3NMXkBbKZe/9SaXOLNyKgsjnPAB/S4iBt6jgMN6wCMO67/YLjtwru4qBCW6IW40A/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(53546011)(2616005)(6506007)(6666004)(478600001)(6486002)(26005)(83380400001)(6512007)(66476007)(8676002)(4326008)(66556008)(66946007)(8936002)(41300700001)(316002)(44832011)(5660300002)(31686004)(31696002)(38100700002)(36756003)(86362001)(82960400001)(151773002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?deTVSvN2ia7w8S/0AtPgWkuSh15G8Li8VxhMEDNSBxD5ehy3zuPP/M3jzplk?=
 =?us-ascii?Q?I5caQmdxeN1ieK9NdAR+VRDoeSsmuq7+32REbTTMW7j60hpyQkLxra0u/AAR?=
 =?us-ascii?Q?pJf6DhIrcImfaWReQnme37++PJSYVhSLffpa7h/JAazHIMzCcUadVBUAX4Mq?=
 =?us-ascii?Q?q4f0yQV4HUzMpqvPI174WBQFheyLd3cKWhIYqcz55RheC8XYscskIVbMORkG?=
 =?us-ascii?Q?Le4D88uc9IRQqBSydOWXrCiWK+/w3qpNrsXWBkyJR9iIEd0dT6IFfTxrcv7B?=
 =?us-ascii?Q?SfdgpZLgshF0qV99+P3AJMx6BoLSFXUyG9TgRSlWs8ESOaobHDS22p3mnlcS?=
 =?us-ascii?Q?yqPBmBKfEJZnDhJEV2I0EqfxUkILEhR5tm41ve9ajpFob0LfVNsGT0HHxqsz?=
 =?us-ascii?Q?PmprIZ7jBhUmO1EBE6VQcgRYrSiaiJKwaglRQJhMBK9xvgmBLoCgt0fTuD9C?=
 =?us-ascii?Q?5GfcambIqZk2JshnljDGWE4j/mPDjViStxn1BHKgUFyjW2X8ulqKKERKaYFl?=
 =?us-ascii?Q?6SBPeOM4pvveAsDqhWl8GidHEmNtOHe6XQbPYGOD/EVu7ZrLRiylU2503exM?=
 =?us-ascii?Q?Z6gaYaC0I1A1d9z0OxRuQQhKb/aYGz7/x/OXgfJ+0psmpOoQ5/SxPX0NLYLu?=
 =?us-ascii?Q?xEGjBk8sllndn14d+z0x1yMeHcvkJRGUJuR1WlcHHxFIpjo2CFDHdVscDUXT?=
 =?us-ascii?Q?HZrhxVOnQ6gqP0JzIlWFXCzoo8RJExBvtDrA1C3ShNA5lgS9nsAKNI6v25ZN?=
 =?us-ascii?Q?scR8ONrde9QZns9kxOMAPoFLIe7NkYexnFGyklA6J9PE3nYqoJA0amRb7Rwr?=
 =?us-ascii?Q?rXdBLt5/rw6NVCR4bkcTdXTSnc0fyhZwWUXfoWpSFV6b65p0nR8D3psQocNo?=
 =?us-ascii?Q?eyXByqx1bkZfa2JDoBsDzGKAsgA8UvwqwUwxVH7wmA2S9EMozbo4pGCOgdhc?=
 =?us-ascii?Q?JrR+c9VfTLtfsPH/iwrSNTszAtgZHiEUzVG17VJe8kZaSNVqIz1cmAHViF5Y?=
 =?us-ascii?Q?qW4/w5yf+4LteyHfGz5NRqGO12e/IIv8/XvIEBJNstCsYjNCa5x2NfnZUBhF?=
 =?us-ascii?Q?yBQxNtZrCqsJ8LwdPQX7vs7FFmmzLBS4pgUfdE5eGKlIAA9EZb9NkbKBk/m3?=
 =?us-ascii?Q?zotWjzsMmf6aazWkZ7heuxzLkl986W2X/uWdf+fCDJ71A3iNHtLnh15qERYa?=
 =?us-ascii?Q?r1F65fkltnacrS71p30gPJx20Dx5J1Vs4nzNjGzR1v2tas+sS7qrJoqpywPw?=
 =?us-ascii?Q?I9fvVWTjC0MNUPnOyz2Q9nMuhPMlJ4+VwflkmG1IlJ5jhzAlxyQKXCykHBIS?=
 =?us-ascii?Q?kgWa19SBcPk8wbqmyTU4wnXPTnzJ02g0EPgPpM4AImQXgu6c2Uy+0ptlsP8k?=
 =?us-ascii?Q?AhweIWiejtNblaoJXJGWzVhVdRtuKC8ILYxWXwVKm8yQ4//0590z1TZv1qIl?=
 =?us-ascii?Q?9U3x2KBFaCrWLAO+hCKzZfBKETWt80WwT3TifwgiGmg6AB5vU7RQY/GuwKPY?=
 =?us-ascii?Q?j6nrCQq/2FnodiFWhLxGr+V9DEE5U+xgZ6e7FyCEQRnpmJ3uBbMqwIuvYYat?=
 =?us-ascii?Q?77i7IjR6/DPoisqMgtXuUGwDMLEwVLUv/LgMsssQ8Kalmiywq4KRsHVwflSY?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517bb35-12aa-4a11-0e28-08dbc331adab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:23:53.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a09kXI+8yeS4ovF3Xl493JYCgjZb1IXb+3MdXCzDUyXbJK6L60WbEXbsp4005gglNf0d4pqJ2hlvA/Iw8EEh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6659
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 10:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13255

On 02.10.23 01:47, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Jan,
>=20
>>>>> I wonder if we should (and could) consolidate the x86 configs. Or=20
>>>>> does this target come with any specialties?
>>>>
>>>> I think it can be integrated if the serial port and baud rate are the =
same.
>>>> (There may be other settings as well.) And the partition scheme is=20
>>>> a reference, so I think the same settings are fine.
>>>> This time ipc227e and vx2 happened to have the same settings, so=20
>>>> they ended up in the same config file.
>>>>
>>>
>>> Ping=EF=BC=9F
>>>
>>
>> Sounded to me like you wanted to send v2, given that you confirmed we=20
>> can consolidate things. Or did I misunderstand this?
>=20
> ipc227e =E3=81=A8 vx2 =E3=81=AF=E7=B5=B1=E5=90=88=E5=8F=AF=E8=83=BD=E3=81=
=A7=E3=81=99=E3=80=82=E3=81=97=E3=81=8B=E3=81=97=E3=81=93=E3=82=8C=E3=82=89=
=E3=81=AF=E5=81=B6=E7=84=B6=E4=B8=80=E8=87=B4=E3=81=97=E3=81=9F=E3=81=A0=E3=
=81=91=E3=81=AA=E3=81=AE=E3=81=A7=E3=80=81=E8=A8=AD=E5=AE=9A=E3=81=AF=E5=88=
=A5=E3=81=AB=E3=81=99=E3=82=8B=E3=81=93=E3=81=A8=E3=82=92=E6=8F=90=E6=A1=88=
=E3=81=97=E3=81=BE=E3=81=99=E3=80=82=20
>=20
> ipc227e and vx2 can be integrated.
> However, since these are just a coincidence, I suggest that we set them s=
eparately.
>=20

I really prefer creating a generic x86-64 target, now that also the
M-COM device is being added. Will reduce our (build-)test matrix.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


