Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89678C433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Mar 2022 00:04:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.2049.1646179494158977018
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Mar 2022 16:04:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 22204V2r020269;
 Wed, 2 Mar 2022 09:04:31 +0900
X-Iguazu-Qid: 2wGrPaGxhpM7WAxQw6
X-Iguazu-QSIG: v=2; s=0; t=1646179471; q=2wGrPaGxhpM7WAxQw6;
 m=77V0WTluqTtB8MZq+/MDMiAK6+u6X8C2GgWl2MlKcro=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 22204SAU010038
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 2 Mar 2022 09:04:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbnW+ve/J15Vy/1DsiRMgvNllm9JhHXRH3RpbUxzwYlht0N9eLnZOuK5VhPlcKUqQyUDDdPa8t6cVZ6mJ6vm1wEz0YWgMdd0Q2oo5JrN/TBOwFyEbCUJak5o7yFrjPPfokYIhHJtk9By9daf7dHl8d+Fg1pCKqrEwAuXi73A4sbR9QkZ1ItNrwcPtg+RciWe9ha+rHKkuShdf4YkK/s/ZubLvkS7SuiJFraiPPWbZEb+EmO8DK5T/LL+VmuEiM70/Uxg+ZzEOi/+Q55e32YsNykdl04ZAxWlKxyxtkNEuzR3mS51xaMVZuUmdpo3FW93WFyW4yHO4TWjOKsWdFmM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnLr/0tXWAb04c4VUlqUSZOTLonAqMoCJnRAEdgncoU=;
 b=c1H5JAyaPfDdpRBMwKbB9bLinZW/qhbr4ZaLtOd4fvnKsw9i7vnMN64rjEvUCzhEW2Q3eGG88xtb2E5MrH5HPuOJmRjAQ8DA25GjWD8vb043n9GTMXJeD/INnQTDhDZB1z5FUFXd/5L/BIiiYSz/+3N9rFOnoxEsigHPvt3oyMxr4DdVWcvMw0H+0aTF0Z//DC5Weapzoz1rLEm2JYmYM7HRaoTBRxsHLalHvKuA2xkjY43IvMQ6ACHG2HzcmTyjWaNSqNG5IZbwcp0nGwbUoKUUOBdsVwQaRZu+Z5nEvJ8yaMzi/i5GY5jIeLfaeFmRFHE3NV6EDBe108iAXp/ynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>,
        <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v4.19.231-cip68
Thread-Topic: [ANNOUNCE] Release v4.19.231-cip68
Thread-Index: AdgtP8yKZ1II/26MQ9S9N/r/t4yleAAVx1cAAAx6wOA=
Date: Wed, 2 Mar 2022 00:04:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62520D894471D3C3993D3B3192039@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB6252EBFBECFC83DCA2B8A46892029@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20220301180520.GA13424@duo.ucw.cz>
In-Reply-To: <20220301180520.GA13424@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b371cfc5-a735-473c-19fc-08d9fbe0371c
x-ms-traffictypediagnostic: TYAPR01MB3646:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB36467E7341170AA92FCC5E5292039@TYAPR01MB3646.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 d1q2jwXobT/x0Xk3W9oAqgjhYuvh87NsUmPdgCeUZxs5R/hafELPwjTZXzhJeqRrwlsseZ91CsmjDRj2iK9swkovv/G6VAIDOWw4jxq6DfHayZhKy/5srrbMfbidrJ4BiSCHw1+E/XBoogt7Hu/8tB/X580X3gCJfy5AD8FFruFJ7gB881TtrP64CgVQYPLWk5DVgaBgd3lJ76b72IN0aESaHVmFYmvUODE0xGPnKhzhbjOLehoXA9JUhBh9RR99h1+PMAPVn9P+d4vjoW4xERBEFkMlIfcA6For/PPj2GksTbodJp1zkP1PPYRn0F5O3w+wOdMPTr7EYozJo/ZMTOYRBeYgLJSqbKzORFtWSosPVeLFJa+ktjSlfnJdQZIraE9KwWut7zaC3a49vv8Q7VmMknmfVTwq06kPB2gJWfzMfq7m7GQnTeEKFaKLHRB36CTZcRh/l2eL4j2lKv5NIEN6LZW/m1ESONpzFGmoTxVEZowZ/FfxYPV04t7UE9IrPX1Q1/6IcEukDUSac7VrOP9rABH+V07Wsv9cZa5QIwzyWMQpJrkFMENXHtGC3bfTi/x1sGEbTeM9RQRow1cuOiyE0MZDoA2ZM2X5/SiFAq3UfKsYqiSagTMReG0tRu2kfe44wY7LSR6PNSfUBayTbwIIrPNxlqaZnKl1V40Ki8R2+qeUMivoZmawXd3H3RQjR8zjbohZNPSV6Vyb0TdUXQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(6916009)(122000001)(38070700005)(2906002)(9686003)(316002)(26005)(186003)(54906003)(53546011)(55236004)(5660300002)(86362001)(33656002)(66556008)(4326008)(64756008)(66446008)(8676002)(55016003)(66476007)(8936002)(7696005)(6506007)(71200400001)(52536014)(83380400001)(66946007)(4744005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OXNRZFd1Q00wdEFqMWpCNGRpUDRQakdTdzM3MUcvKzNteHprYlZwZnlw?=
 =?iso-2022-jp?B?QUowMVpCU2grbnhJWWxyZ0RYelRoMytFam5yeTV1N1Z1TFdTK05Wejcx?=
 =?iso-2022-jp?B?RDV6enJiVVZTU2w1TFFTMHg2bk5yMDVWOEZDalR3dkFEd05EZ3l6aktN?=
 =?iso-2022-jp?B?cWVhY3VpdXlkRHdSM0N3eG44VFU2QXd1STFibWx0Yzk5MVNzT1d1R1lX?=
 =?iso-2022-jp?B?bGRYbXlIdGphRk92TWJxNkxwMFkzY1Jia0JiK0ZWaVJsK2NxUXIvZE1j?=
 =?iso-2022-jp?B?eTYvc3N4RVkrbjZYSzY3Qm5HcU5YM1NKcDY0RGorazIrZ0xwUjhjT0dS?=
 =?iso-2022-jp?B?VXg1aXBTaC9SZkc2ZmpaTnhzcWhIVXlQNThORzhOMFpVbjU4dU4yQWhp?=
 =?iso-2022-jp?B?Y0hORlgxT1lmTjNnVFhZekoyMmFKUmxleDVKR1JHdXJhcDVnUlhueWw5?=
 =?iso-2022-jp?B?NndXbWRXMmFLWHRUVTdKWmtoNGxNQjJiRnhkcmJtTm4wNTBiZUkvdzFT?=
 =?iso-2022-jp?B?eWlPaVJSWFUxcEZPd0U4bXhuRGZGM1VXWEY4NC9UdEdHemNqQ0tDdTJS?=
 =?iso-2022-jp?B?ZmY1TFo3L2dtYjlvWXQ0b0syNmI1ZFJRS0JLZnFKcjZaVGZjbWoxR2FJ?=
 =?iso-2022-jp?B?eWJqNHNoN2IvYWRPbzg1MXNGdWJLOWVhTytjWHJudStxQi9zNnJ2aUFu?=
 =?iso-2022-jp?B?UHZPVTkwSCtUVkY2V2I3cjNONjBrMk05U0dvME5RSGZyaGVjM0FqSEVP?=
 =?iso-2022-jp?B?endpKzVIeWpQWkFIRE00QlVqaEtSZWt0eXg2bVJFL1JBWlBVWm5KTkk2?=
 =?iso-2022-jp?B?T2VlZjkwZWlqMHNqejYzbVVBdUZZbzZrb21IejN2S1hxcWd4eVp5RFVR?=
 =?iso-2022-jp?B?cmROR3RHQ1dDeGtpU2t3M3lZcUR5ZEZsUWxGZHhNeUVZeVhQMEozY3hB?=
 =?iso-2022-jp?B?REx5cUtMK3lMK0FiTWlrbWtpYUVLYnJEQXYzMHZ6RnRpRmdtTUZ1Q0s0?=
 =?iso-2022-jp?B?UFFQMy9MNmxkaC9XNVhybndNQWkrOTg0NGhTVWhMUytDMGs1SXQ3VUJO?=
 =?iso-2022-jp?B?KzNya3ZkTHA0a241Wm9IVFJNcDlnbkdrdmc3enB1dndLZms4YnVBR2hD?=
 =?iso-2022-jp?B?RXIzTHFYUWc0YTJsWTc5WFNSU3VHZlNKb2djb1BJQzVnaHlEQlQ2NzA3?=
 =?iso-2022-jp?B?YjA0ejQ1TnJXWkxBWjVoRDZmZkw5Zit2TjZmVVZpQXlQa05qaDArcHRX?=
 =?iso-2022-jp?B?azhBV1RIclpHV0ltSkRGME5ybVVNcFB3anF6Uk1hRUY0aWs3eVpqMlh3?=
 =?iso-2022-jp?B?WmVBN3dpeE5pVTA0dWErQlFaVEx5c0hTNFdUM2hkRUQ5YUZ0QzYyRnZM?=
 =?iso-2022-jp?B?RTJrMUxXOU51cWRyRUlQTkFROXd5bXBPa2hKRjBvZGd0NDRZZlBpRmx4?=
 =?iso-2022-jp?B?SHRPNndpME84b05OZERHeE0xb253MS9LMEVodEo4NVc0Z3JqUUZib3lr?=
 =?iso-2022-jp?B?eVFWZjYrQXkrWWUxajA1OEt0c0U4dEZnNStWcXh1YTFnWTljaUx4Q2tZ?=
 =?iso-2022-jp?B?cVRBRkV1UEZIa1dDb1o1cTh5YlV5eThrSzhDODYreVEvaDZTRkJRU3V5?=
 =?iso-2022-jp?B?OEpUc2RVK2UwT2dtV3hpK3JzT0J6cStxeC9DVXhVNFZLZ1VKWjNVcG5W?=
 =?iso-2022-jp?B?ZU1PYWpXM2wrYmpFQTBwS21lVFQxWEFpeHZYQ1dnOW9sOE0vRW5ySDB0?=
 =?iso-2022-jp?B?WmJESlZrTHlPMnN2UEFIUmMvYng0eEZVc1FQVUQvV2JaTkNIM0FwVXRG?=
 =?iso-2022-jp?B?UWJZbHFzcktTdVNQdEpqRW1PTFJXTFJVaTdYSUZGOGJMTG9xdDJDNHhv?=
 =?iso-2022-jp?B?MkRNQzZEUFdSQy95M2FpU1JCZ0VBNHVSY01mNHpBY09ZR3F2UDhnYytF?=
 =?iso-2022-jp?B?Z3Y0Q0xJR0FTS1lLVVlxV2Q1RkdjSlBOWjZBMXd1OThlUTFkRXlKRWVm?=
 =?iso-2022-jp?B?N1hpZ1dqdmF6ZlR6QU94cmJOS1Vpd1NpOUV4ZUxGYUt0Zk5mWkpWalUy?=
 =?iso-2022-jp?B?VEhyWE5WejNjSmlUOVFEcnptenZoZEZtQ3IwdHJTMzNNNUVJZDhQOE5V?=
 =?iso-2022-jp?B?WnA2NEMwVExra0lZVnB5WTBmdXRhVFcraE9YUU9XL3RiZ3VibFY3TUFN?=
 =?iso-2022-jp?B?RCtTZkVtc2xBNXZzSWo0R1NtOFhXUVFqaFo3RWxKd1E2NVFsRmN2T0Rv?=
 =?iso-2022-jp?B?QnZtMEUydHlHMzFKb1pkeVl6c0dQRk9BZ2tHa05Kby9sMWtIeUdLZW5C?=
 =?iso-2022-jp?B?cjFZQ01Wb1JGcnhqcDhwOFR6UmJiaXJzRTZITXFxTzFqNmFpOGhHdjZU?=
 =?iso-2022-jp?B?Y29Dc3NJZ0xtM05PcFNTWG1aQWNYMXlJbkVyc2laTjFOTDExVzNjd1I1?=
 =?iso-2022-jp?B?ZVAxamIzNW53K1R6RmNlUWp4dm5oZ0JpZWkwTm5neW9yY1VKTFhaWi9Z?=
 =?iso-2022-jp?B?Q3ppYkxN?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b371cfc5-a735-473c-19fc-08d9fbe0371c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 00:04:26.5158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Pupfy53G9Ap58ve1UHpuguD/gYUvnrwu+mg63EOgxBrWM0StV0tOqLDw9sfnSeq9x3HHBpqUPdjYx20CHVvBaYfGe+g0iWpX1qMgmIywbdZl1SzIcAJYu8meZtpSKXLY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3646
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Mar 2022 00:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7648

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, March 2, 2022 3:05 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; pavel@denx.de;
> Chris.Paterson2@renesas.com; uli@fpond.eu; jan.kiszka@siemens.com;
> masami.ichikawa@cybertrust.co.jp
> Subject: Re: [ANNOUNCE] Release v4.19.231-cip68
>=20
> Hi!
>=20
> > CIP kernel team has released Linux kernel v4.19.231-cip68.
> > The linux-4.19.y-cip tree has been updated base version from v4.19.229 =
to
> v4.19.231.
> >
> > You can get this release via the git tree at:
>=20
> Thanks for release. There is 4.19.230-rt103, so this time timing did not =
work out.
> Would it be possible to coordinate the next one with -rt?

Ah, sorry.
I forgot to look at the status of the -rt tree. I will be careful from the =
next time.

Best regards,
  Nobuhiro


