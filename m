Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAACC47258
	for <webhook@archiver.kernel.org>; Thu, 25 Jan 2024 13:09:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.17098.1706188144333029258
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jan 2024 05:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 40PD92XA749949; Thu, 25 Jan 2024 22:09:02 +0900
X-Iguazu-Qid: 2yAbxkHIeEWPuNjT16
X-Iguazu-QSIG: v=2; s=0; t=1706188142; q=2yAbxkHIeEWPuNjT16; m=MFXZzB/EngrM/mV8pb9nIbnYMHTAAVhxz6eUkGkUbRo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 40PD91KY2474481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 25 Jan 2024 22:09:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyL0JsgWsamJO1Ku+/Ma+UKqXYfzhOzli/K4r5+ePDMjGc6EEP77EdU22x4Et2XlO0Z9daVspr1QyLbH5Cvguw6A8u3JvlNLbIqGDAERq1Cw6BAsR95cOidShjve5HZuIKx4E+Al7Wx/auhxbeeNlq8P0M5atApMp6QZKclATcZbWTL3GSkSGJEh/S9aVxzJuNVn7dyn/dYuLzoajIyVXOXLxammwzRMbwf8tW3BJamcykkUA0wgtjb4nJDnUwX7LQEwm3V1po53hR36zQsK9zX+7KPqdcgsso6v5AtVVjZHKrNiEvAh18CssJ+q+2szqvrYX6gAuVE2cMAYHUYeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qHdY7oCk4D5RopcWxPeWchG4LjzG0m3lgud2k0AnbM=;
 b=S7TegBnfKJOb49Y+OgsLDk7anx6cvt9B4oHaHLJuRvhF30aNZNuL5sjmzPT18MXrV9E2Z0a7N2TqTiQN6nQumcFUJ48i62VS8ejpvisIxJwL29EtFJhrdE7kkjmUN3EninyRvpFELTAhWjixLYX3LCIQ0iwczxVSZYwIMNUKSXWZL9zBFAk34LSYh3OxSNj8YXAONFCK3oy5N6yGrNrNmRUQpgqnB+/2XXBvpvA8g88qCCDxtU3fu+9+gXoYi9BWEyYxeZaWvVKXqJ2FxC0XEpYRU2V+Ue2FRmVN/AUvdHBvouJcTelnPffyaUYXICNgZSEQ9VQ08reP7KoNxVCoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: CIP IRC weekly meeting today on libera.chat / 20240125
Thread-Topic: CIP IRC weekly meeting today on libera.chat / 20240125
Thread-Index: AdpPjgnURUvbsK0BSvqAsHDJdDgtLAAAIHEQ
Date: Thu, 25 Jan 2024 13:08:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887A83D28A61ED00D653F4927A2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6388719318CDE0F32350DC50927A2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388719318CDE0F32350DC50927A2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB8375:EE_
x-ms-office365-filtering-correlation-id: df4bb0cc-b056-4ee2-70b3-08dc1da6cb61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rlAi3brQumKa6iXVq0gA2488eNEDdKj4dHCX36qZFrkRUTqW/9yzwK2fOImuo1nZslG4JgEUS1wBp+h+fOcVVxyySSqhR/U6ja0k/AIjKgLBoOIO79mD6NNaRh4oWqJJNmRJO54YftyymByLmoJUOZOg6k/SaFKEIl1uJdvtQKCI9Kkx79o5cI79xLdTQuIURveJiDItn0bUrgDtUN9iiatn97kCUMPthbJ1cyincuv7vEnmzhNrNP7YbTo9d7Pqr7322GDoUgcquKTNGSOGwCyfmHE8ownqBWlDsdQfkefjKaDlCruwkC+MRDTd5FoHIUmAvK33WrawZqwr5jZCdOhQB2+B378JKvQBqPr3EahMJXLyXssog12BRlc2KB4Cr17cTHvhVu6Gz0WkeyySGYFrkVPmrrwBbAOr6l8zSdDvGQ810mQLbUk+oXURl1I/nnvo0ixYKOwpek8KVp1jSTVQzQD2SuywHm6lk3tneZfoluyfogXb2hpu/qRF9yUNhapbCxkI7tFoMSEoib68kjw250d9aw09R4SLU5ongzSmgGyMXkOWWE7GtALAtn6v+qpOqM9UjuBXv9jC/3HsiPiF113Kd8yvR/t+WI4RbhhhvPZNwTZijTPYNypJckAQ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(6506007)(7696005)(2940100002)(26005)(53546011)(71200400001)(9686003)(38100700002)(86362001)(38070700009)(33656002)(8936002)(966005)(41300700001)(2906002)(8676002)(52536014)(83380400001)(122000001)(5660300002)(316002)(64756008)(66946007)(478600001)(6916009)(66446008)(66476007)(66556008)(76116006)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TVJ5YnNIb3dxZUtkcTNZemdpT1dXSWxSZyt1SDZRa3hNVjQ5bExUQ2sz?=
 =?iso-2022-jp?B?RzdSYUFlR3ZWcmVvS09PdmdzK3VkNEduOU1raHd6KzJRMG1pejRxbGpJ?=
 =?iso-2022-jp?B?WnI1OWFOTDFzYWVTeHo5VDZwRWhDS01aMDgvbE1XWThuZXVzRFBhakg4?=
 =?iso-2022-jp?B?NXBuaUxPL0lnc0ttTFBqS3BUMlFiOU9XRU95eGNMRjBwTHZVUk5EM0xj?=
 =?iso-2022-jp?B?MTBQT0owVUwxM2I0c2xMY00rdGJQbThVdUFNdUJEdE1wQ2lRSkhNeFd0?=
 =?iso-2022-jp?B?cmF5R2ErTUc3TnZvSU1FZ0tsOUNwOUFwYVJ5L2NTeHNhWE1UV2IvZEl2?=
 =?iso-2022-jp?B?bEhybDZIZlh1bGJZdUFhK2VVUFpMMWR0bGFIbDJXUnYvVk9Vd3BLd0Jl?=
 =?iso-2022-jp?B?UFlNQVdOUWRRVTV0ZDRmMnVYUmNsS2gxRGk0MkJ5TmNjL2l6QlJUU2Ez?=
 =?iso-2022-jp?B?UHJHck1ybDFyTXZkcll0UTl5Wk15azdzWmxidGxvVEtXZEdIMXMrZTVH?=
 =?iso-2022-jp?B?bEVoNzJyUFNQbXZZZTVENEhsZWk0V2VleGFpbnA3TUhGeHRIZmpCUDF1?=
 =?iso-2022-jp?B?TTVCaGxRTjFGRm5wUmxtODFLUnptYkNTYnVZajRsdUxkWTFOMGdLWFN6?=
 =?iso-2022-jp?B?ZThDbWtYTi9BYmpvRnlaTm9SNmtXbDlUYXlaNU5IWmF3VUlJRnljeEVu?=
 =?iso-2022-jp?B?VkRzRmJoNndpTkFoVVhmY3VXYUtiTUQzVEJXUlBrdVl1NS9IenVVbGJ3?=
 =?iso-2022-jp?B?L1pic2tRTDFlRWswZVFpTDFOd1FKMXk4c2ZBd3kwS0ZKSnBPYTcyRncr?=
 =?iso-2022-jp?B?Vlk0ajhSeEk4bm5uR25SakVic1gwOHpzdUVqVjJtblN4eUhCcUtWdGxB?=
 =?iso-2022-jp?B?Sk43MHpseE1wbFZHdFBGLzJacXl0SStrcjJSdzFJd3ZlNGF0Sk01cGhp?=
 =?iso-2022-jp?B?RkFGVWhVelJpdk5tQS82K256bnYrcnhUZ0FxenRPd3lFS3hxLzZ2RGJB?=
 =?iso-2022-jp?B?cFlhakJmUEh6cW1RMitmZTBmNmgvVG04ajZvbXpSM1NXR3F3USt2dVNH?=
 =?iso-2022-jp?B?ek12c0RhakJoVkhhUkV6VWU3djJrSmxxTW9hUUM2TXRNSzI3bjNZRzFL?=
 =?iso-2022-jp?B?OFV5N0RFUlkvYVg5ZzNqUHl3NGtXeHZZbHlMc1luTE1qRWdndjNrSi9X?=
 =?iso-2022-jp?B?ZTF5TS85dFh2alhIVTNrVjFBSkxBNWZlK3l0WHlydXo5S1RtU2ozUUwz?=
 =?iso-2022-jp?B?a0tWT3ljd2JmcmxZNEEwemVNWlY1QTNqaFNNd2h2SksvSjZodzBJaTVs?=
 =?iso-2022-jp?B?OXNnOWtYNU1MbzB6WEdaaE54Y2MxYktFdGpKOVZTdTBRODZqbjBoZU9h?=
 =?iso-2022-jp?B?MEZ2bFVqTGlzRjJZUUR1TUlNS09PM2YxTVg2TmVXMVMvM2ExZmJEbGVF?=
 =?iso-2022-jp?B?cDBOc0pUSXFDYU55NmpHWHl4blZIbjJpWEFnZ3lzVWhBUWMwM01ZQ1ha?=
 =?iso-2022-jp?B?ZUJ4TXJySjlhMHNqMythSi9HM2xiM3lUQXJ1QmFoOVA3NUdFZHI4UFA2?=
 =?iso-2022-jp?B?QnBrUU1kQWVZay9QWWRYZmxyZVNSNTJYdHB2MVpuU2doR2g5VnZ2Y1Ns?=
 =?iso-2022-jp?B?T0N0MXBCdmtSa0lPY2JsZ09SZ1cxN2NZMkc2TkluM1l4THRQWXRscHJR?=
 =?iso-2022-jp?B?VnNzbDV1SEFrb2tUWWcrcEwyVm1qNEtwVFgrTU1ZdXJyOWhxVkZiRU1r?=
 =?iso-2022-jp?B?cXJjMVhDYmd4aGV4aVR3WUJvWUh3NmZhZkI4MUp4TjMzdjViZUhLNWRm?=
 =?iso-2022-jp?B?dnZFeFRwaHFQMUxVT0djWHFGaHg0aXRscWh1R0dKZUExb21jd1ZyUXVJ?=
 =?iso-2022-jp?B?WjhXZzg1R016UFk2c1JIOU9oRDlDY3hhNDFlR0ZPRUoxREdXZmVmRlFp?=
 =?iso-2022-jp?B?U1lVUEpVOVNEcDVscUwzVjR0d1BlQVp0Mlh6NU9hR25BMUdNWm9XdXZn?=
 =?iso-2022-jp?B?QUlQMFo2NHdzSjR1QWtBdWJZT3QwbjlicGwvT2VYVUZxZElZOWpFUHov?=
 =?iso-2022-jp?B?eG5IdVhaMmNpY3ROY1hXWm1uWFR1U0kvTE9NZXIraWtjemU0Q3J0bmxQ?=
 =?iso-2022-jp?B?c09ZN1BsRXQxbWlSaExqWTRQbUZYVmlIMkFKZ3paZGhYVkdaeWNmOE9P?=
 =?iso-2022-jp?B?ejk4Ny9DSWU5d05nbCt1cVFKNDNRRWZYTjBXL2Y5MU1KcGtabjhoelNw?=
 =?iso-2022-jp?B?cmtsWEsrckFvWkRjdWE5RTR5L3A1eUU0QmVTZGJ6d3d0aWd5S05LSmRY?=
 =?iso-2022-jp?B?QVJaYWJMcnVTS3RvQk9KZENCTnJ5SWgrVEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4bb0cc-b056-4ee2-70b3-08dc1da6cb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 13:08:59.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVMhrLJ7+MEUZ8w2ZYz5kn4tjY1rPV5FcHyKsR+VfqCGyhInOsGA4djoZnEFqbMGHrUxWzJLVRZf0Xu4sNi8hjUQZQOrFp7skDcgiPQ3o0a6UEk5yEDBgTg8TQqeBidD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8375
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jan 2024 13:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14459

Hi all,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Thursday, January 25, 2024 9:58 PM
> To: cip-dev@lists.cip-project.org
> Subject: CIP IRC weekly meeting today on libera.chat / 20240125
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>=20
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2024&
> month=3D1&day=3D18&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p=
4
> =3D37&p5=3D241&p6=3D248
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     21:00     22:00
>=20
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/01/cip.2024-01-18=
-
> 13.01.log.html
>=20
> * Action items
>   - prepare blog entry on SLTS kernel state and challenges [Jan]
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1

Date the data is created: Thu 25 Jan 2024 12:30:17 AM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed 03 Jan 2024 05:59:46 AM UTC
  limit date: Fri 02 Feb 2024 05:59:46 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed 03 Jan 2024 10:54:06 AM UTC
  limit date: Sun 03 Mar 2024 10:54:06 AM UTC
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 11 Jan 2024 03:28:42 PM UTC
  limit date: Sat 10 Feb 2024 03:28:42 PM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu 28 Dec 2023 05:34:49 PM UTC
  limit date: Mon 26 Feb 2024 05:34:49 PM UTC
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri 19 Jan 2024 08:26:21 AM UTC
  limit date: Sun 18 Feb 2024 08:26:21 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu 23 Nov 2023 06:12:31 PM UTC
  limit date: Mon 22 Jan 2024 06:12:31 PM UTC
  Status: late
linux-6.1.y-cip: interval 15 day
  latest version release date: Thu 11 Jan 2024 03:35:34 PM UTC
  limit date: Fri 26 Jan 2024 03:35:34 PM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed 27 Dec 2023 10:04:59 PM UTC
  limit date: Fri 26 Jan 2024 10:04:59 PM UTC
  Status: On track

Best regards,
  Nobuhiro


