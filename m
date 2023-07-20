Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B81DEB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 09:56:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.9326.1689846983025587773
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 02:56:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36K9uCaW237711; Thu, 20 Jul 2023 18:56:12 +0900
X-Iguazu-Qid: 2rWhDvohsgCwNHL7Fw
X-Iguazu-QSIG: v=2; s=0; t=1689846972; q=2rWhDvohsgCwNHL7Fw; m=sykpx6wzQ1Eg94j1fK+RmLICrUULGVWaClLYUaLGVcE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 36K9uA7J3557339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jul 2023 18:56:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me8B9dDxYnPv9nQO1eLNUgXHg99MJTGVAQlfav5XxQmODxYJIgIzTRvEDPoQbWLLM7GuZ9O5HF3FrBhqLZtevaW7IsTSYcL74XTVgT4j7I65rF7Zdha8UrtJeUQhYpGLYaRQjTsLoFKTfBUwURrgyjf1wEAB0t681OUiYmzKtETfwZku5VzkCNZI8MZ7uL3xL4ujTAWiQU+iMEYpXPRw8OZ6h+XfJ0lJKM5zQTWjU/YitRQ2jla5aVbim1ta2uDrtTypl/Uiz484dWi8uiB6LieFjkg2akMY8h6ZD1KDOVnc7ZBvVuxDrlHJC65YErSJlLxc7xSkzL7E/SR5QNya6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+04vsGCpxjvA/tHJSGh5+O2E5v638FK+jJLDzufTEvc=;
 b=f8AXNe+5JAvEZvxOimJTYoM0JP3GFb58qIOKaZg9f2M8syNOFQnX7wxQ0ht+w52UQ8TYMw+TDB7oKQydPhzh05NaxbM5jsVW/EbiChOPPW2FGp0vGkvGYAPj23hUzlbiFKfN+gnJnD0XUWsMPDkPNIazOCH3WVIEJ8/Jt02eDvFwnYOp1o2NXCPcpqsddpiaXQLV7youYDGvNvj2YCGMDb62Nzpe/EX9tcQzsKWcPxVmlKvvC0l+OK5s5rdLEByyZW3sc72olfIPpQKhD81MiWfmCKIm717MEqjDf33FfIuXLnIWV33ztHq89fVMvAzwy4NQsNTRNXhRWOB2aC/L4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/4] Add PWC support
Thread-Topic: [PATCH 6.1.y-cip 0/4] Add PWC support
Thread-Index: AQHZuYw82U0W9N9ujk2SRlH5ZRwr6q/CbRwg
Date: Thu, 20 Jul 2023 09:56:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94202AFAD6CE40BB9C74EF96923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYVPR01MB10815:EE_
x-ms-office365-filtering-correlation-id: ef8fe924-a640-4d25-dfb9-08db89078aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h6toFxWg0wBZLvAWmiIUZP+c+ytkU1dpPZbCo0+OQOtBpqOzlR0pftyfeDfgu+tEuPbuA9RKV6owuMsODIQly27LwkkdBkvReJX4AOnGe06Hez8g1ZU9+8aNtQiUXzwWq6EuyzeDEgiqD2QVxx19Fga0dufrpVBSYaAZO+xKmMeWZqnhuoMQNrcCaYYq7NQ4dPgmc1lA1TvgBawpxf1UuLGmTl1+rSyKP/6D72/uJkpQbPBS/bnHZpTnXyOhkmZqHaIEoCN+DGHAcTgOanL4QDeYLEiFeiIP2x5R7Z82Py3jQi6Rfl3BcOz4QWxDgzIMdXfNeORjCCm5mxxH8TV4OBQhgQ4ahi2LymJ1OPX1ACapYvZnHzBveI0eAUZUpEbSbsjFTya/IS9gKApVnWF4ktM9fuiBkvI947Cd+E7nPbGrRaY/zpH9kU+xiz+kmJFmDDOKFvvTN9uUahHiZ1SmnMaop/t7pKEyIX3DzQOirKkO7mO7gjypO+uboB8Cja45ol19lwseiojaKPZXQxWyYtMOQQ+vtJ5SjSHVuinUidP35uMeXAyBEadPNVXHrcbrkoUWH6e8qZUlPHq9a/u8R9ZV8U/Mnb8IFKXQiswwQZm4RdIqKsPZSCWv0tLZULb4JpaLYL2CwW4jfqU8Sr2mYQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(86362001)(33656002)(54906003)(478600001)(110136005)(76116006)(66946007)(66556008)(4326008)(53546011)(66476007)(64756008)(6506007)(26005)(66446008)(7696005)(9686003)(4744005)(52536014)(2906002)(55016003)(8676002)(316002)(8936002)(41300700001)(5660300002)(71200400001)(122000001)(38070700005)(38100700002)(83380400001)(186003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TVFwZGVuQml3OFdqZVlXU3lxbndPdFJDckRVdGU4S2JSeHBQY0hTNEVz?=
 =?iso-2022-jp?B?SmN0c2dISGdlampURS83Z1k0UGwvVU11Z3R2Tm0rYVhPZjMrN0IvVi9C?=
 =?iso-2022-jp?B?SUZlam93OXA3a3dnQ3dzcTljcW14dm11dEdLUEJsaERTWEhXR2Npckhk?=
 =?iso-2022-jp?B?WjBUMXo5b0l0WEloR1BKSXU5b3FEcGZvSmxhUm1ueWdoVjVtSzhVT1A5?=
 =?iso-2022-jp?B?Z3k0S1IxVXh0cWJySVlTcnZJQlhrK002elVacFZleWFVUnZHREtEY1Fj?=
 =?iso-2022-jp?B?SllXcXpXT1gzTUVIeEw5MWMwU0doRXpyOXdUdW5uV1RMMEU5N1lPUUxU?=
 =?iso-2022-jp?B?NnlZNGcwRjdybVF3bitYOEEzbGFHM3E1OERzUHNreXo4dkl6TkZOb0tk?=
 =?iso-2022-jp?B?THo3aWRpTUNhTnJlL3RVVk02d2NIY0NiS1FJNXhzRXg2WUJ0NHFSR210?=
 =?iso-2022-jp?B?ZXg0YWgrak53aXlIZnRsMGZpNmVQektLZXZoNnhiVUZBK2dUUk5jRytz?=
 =?iso-2022-jp?B?REV2bDQvOHRFVmlKWmlKbXlLbWxKckI4RzFIbVVtWThPS3oyb0RtNXBZ?=
 =?iso-2022-jp?B?aG0zT3Q0em53SlhCWEI3WGM4dDFZekpnZVcvNXQvN0xZWXZuRUZmZUpG?=
 =?iso-2022-jp?B?OFI0Zk9UcjVnbXhwK1JITXd5SzY0enZBNmlEMGVVejFqVGU2T29zUzh3?=
 =?iso-2022-jp?B?aG5ud1RxWm52MGUydFFqTW94WUVqMW9KdkRUZ3RFSGFWZHl4TnNFclBa?=
 =?iso-2022-jp?B?VzNhc3cxNzlqVldKNlFpRWpJZ0FSdCtTcmhFUW1MK0pwSDlvV1BvS0xi?=
 =?iso-2022-jp?B?MkRHblY5L1JtMU41NHY0RDlFajMyM0dsS2xjK2Fqck9mQWxzVGtpanUr?=
 =?iso-2022-jp?B?VUxTdyt5QnJsU2o1SGpvREpJbHRkc1JTTW9yczl0OHBlRlB0Zlg2V09s?=
 =?iso-2022-jp?B?ZUZXbzJ2MGtmT2ZobldrSVN2OTVPclk3cmpqWWlQSUNTV0xNVmZVTWM0?=
 =?iso-2022-jp?B?S1VoUnVlWjJxMHBjWXRVdTFXa0p0cWthdnZDYkxpWlZaV3FGTXM0YWFh?=
 =?iso-2022-jp?B?TmgwS3A2T004OUxZNS9tckc1dmRIWG9BcE00THNHVEt0VUxrTGpHN1M1?=
 =?iso-2022-jp?B?NmQrYTZmb2ZGeGgxMWNva1ZkMi9QUDhPWENHNHFwcjRhZ2diWDVSV2xK?=
 =?iso-2022-jp?B?aDh2K0RtQy9EWkF3SjFPWlFsR2tDMWUxRVJyWU1HditoN3BuamhSWkxm?=
 =?iso-2022-jp?B?WExxZ3YxYm1iZmt0NTZKWGZrVFNiQkkwV0NkblVTbjhLYnpaRFRaQmZ0?=
 =?iso-2022-jp?B?MlZLaDdFQ3l2WFVzZUFmQzB0VUExL3RYVE5hNXkwaFE5RnJoYTF1ZHg0?=
 =?iso-2022-jp?B?V2Y1d2F0STNsZ3FSU3hQbHNXLzBSWmEvc2JQUTlkWmw4bHhjeEtacmRE?=
 =?iso-2022-jp?B?RGFqYVNEWEJhVHAvV29FUG1Wc0d0bFpyTGpaUmFCei9vWVVhWmN2aVNh?=
 =?iso-2022-jp?B?bmNDd1J4SFl2OFBwUmNla2EvenBKbWM4UzRGWGUwTi96dkE4b1Jpdksz?=
 =?iso-2022-jp?B?MmFkS05USkc3SmxZNWtOL2h5NnhvR3h0b0RPNFpza0pRK0NFNzUzOWhJ?=
 =?iso-2022-jp?B?NzZjRnFSNjZ1T0FvTWVUNTU4RkdFdi9XT2FsWHNUWWhPV0V3c1Q2Rzdy?=
 =?iso-2022-jp?B?KzNITGtydk1Oa0xxU2Y2QUtCRndReUhGWmNBdmhjNFo4WEdsQVNFVG1U?=
 =?iso-2022-jp?B?V0lMSWpyb2xIZUM2eDZES1h2OHNQNks3cEFlZHJadjk2a0NLZkpJRnFr?=
 =?iso-2022-jp?B?OFlZWHBpUjg4VzBBeTNiY3pWRytwNjhNVk1yQnNlbmlCVEphU0VXN05M?=
 =?iso-2022-jp?B?eUVkZmt6M2d1OUY2U3ZVdFFDZWd2Ukc1NjZOUjFYUUVOeW5lN3cxeGdz?=
 =?iso-2022-jp?B?U2IvZGdjaC9mWG02UEU2czFzWmI2N3JJdGUwL0pTTGhwd3ZSVTNjeDQ5?=
 =?iso-2022-jp?B?b2pjRlBPU2lLeFdXSEdpWEJKanNMREdIQXYwek9BSzdKcW9JdTRNZmFO?=
 =?iso-2022-jp?B?RU54TVZXT1hCWWQxMUdMYVZRc0RwYmRMZTJJMUVmbkVUc0ViVzNrc2tN?=
 =?iso-2022-jp?B?VFJyWDVzU1Y0c0lIdG05SEFNMHhGYmJHWjVSNUJqeXdIZk1sdnFMdDZp?=
 =?iso-2022-jp?B?UjdUai9Yck8raTEwZ2gwMTFIT3lsRG02WG4vWE0zamhUSHBwci9nZWxu?=
 =?iso-2022-jp?B?SW5Ncjh2WndxeHpwL1hmdHB3cjN1ZDlOOFY0c1JhQ2dIWUtsUGNHaVFq?=
 =?iso-2022-jp?B?aDNnMWNwOHhpL1laMWlLendRaTlPbHgya1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vn6kFCxjKkQamQr4NltJf9fj4Mwh84LQXWfO3n8TQQ0Iypey5T/vCSaxemDQVOb+X2f2dgVsoRpabSYGp0lAsMTMHJ5H3fYy+x/Ts3hVhIskd3vr+uI73MgDIGoBVHN6HX97MUH5778F3TwsVENKY6SoYvD781YGcmpX77sIGkZin0PSkTbWCDo4jBxVxaySbaoRsOU+/9qk3YVGeJG/7Q712SjHwaSLO+Bp8bKVfNNF6vsawsTrF7rwek4smmxa23DreCqqW+dsl0Q7VIJHp6Bnrz9q3ZaT5S3ZY8E9eOTtjdy7mMBc3eoM8e5RWIaiRIMM3cj7oU9q+mHz+ttUizugFj9aT9+OCvn8w/EpSh9QbyGExXPWE67CZSmB8Bw7LsCA2+AT9Tpv7zjrDuIpcybgI5HKUlALQMxP0zCGTVy9CbtN1ZKAjfkPjfH0T7o+jkPXL+M3UEaAdQ6Ag6xZNThdAx8MWvFb+HsGjdFRyOy1z4mwJ6G+iDmEN9cHOLZ9iu8azhG2sbo+jYRkO4jAGNHzNM9PVXPuM8PP/Sozvwql4Rb0w74r67MCJJDizHPAgOj6dGpqr6YDSq7ezwoVyUhwZNYmKkdFti2tbalf/78sSHLtCxzdF7sE0jts6S7uw7BNq/Is17wpHWvfQeQ5t0uM2f2aqX5ox7RG2WlNxeacMx27u+PlxhKpU3Hwj2ye8Tl6MS9XJuelpMQqYXdRbDXZ/D9bjrMMZKo9fXgDWrpDk8CWuSbNjlyt9jOh7Y+1E/JEmUVfVBsxOhCX682la7W2orhZrwINPREZxnI71o85IZeJWMycF6VFbIqT+NrBc8NXnZGrd1Z/i/wNfHcEyW1wzEgUBs47nHaAjMg2QmKdjbO6eyBCve2LIuz+m0ufnBKTYbxIW25iec/3fHjcGg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8fe924-a640-4d25-dfb9-08db89078aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:56:08.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHDHY/HQFGnK81GYZx30gDpMY5LS88lNajFy4AhxDQ7xRjBgoXuKlP07iwDzQ8EougLOmS6c8CCi1+6ik8GJhAiDEXCGwzqGrZJ71NI8JFUXTS05nKPfmvzBF7D7EqZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10815
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 09:56:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12441

Hi all,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Wednesday, July 19, 2023 12:26 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 6.1.y-cip 0/4] Add PWC support
>=20
> Dear All,
>=20
> this series add PWC support to 6.1.y-cip.
> All the patches are cherry-picked from mainline.
>=20
> Cheers,
> Fab
>=20
> Fabrizio Castro (4):
>   dt-bindings: soc: renesas: Add RZ/V2M PWC
>   soc: renesas: Add PWC support for RZ/V2M
>   arm64: dts: renesas: r9a09g011: Add PWC support
>   arm64: dts: renesas: v2mevk2: Add PWC support
>=20

I reviewed this series, LGTM. I can apply if there are no comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


