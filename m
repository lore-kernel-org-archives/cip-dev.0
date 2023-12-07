Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C9C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:10:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.83166.1701954649331825297
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:10:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3B7DAlup3940253; Thu, 7 Dec 2023 22:10:47 +0900
X-Iguazu-Qid: 2yAbpkkD0beg0hyvmi
X-Iguazu-QSIG: v=2; s=0; t=1701954647; q=2yAbpkkD0beg0hyvmi; m=jxbJr9BFYMTzsbfdpAWw4WAQQ5jY5z9uOnt/jKGjkSQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3B7DAk8w604826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Dec 2023 22:10:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4XX7O8ZVbSpUFqAXX/D1+9RgpNv+v8rXhdZ2d9lleBaXTgtG2l8Pf1taGgd7UzOrmUPBDmIK+sy9vuQcyOHdQhHl1HLNQC+K6dh5myjxzCHHW/o3b6p+kUYRN4/I8PThgO+TwHBU+07CtCu75MTVief6UtEUCpHdZgAU6Zc12FL64XLYgS2TTHsjXiUY6910e9/BEJanfNLXG2MW8gZ0VcT6zydL6U5ZKLn+iG54ia5PkmyazDs4QHauzgDGh/Qrp5QwYneuGTrQunPSPu3PWymbkqel20/Ulnbd1KBoROhZatfXuFvCPhgt/8edchhmtksRLL9gc3REUIsAauC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbrvC0Bx9tlzxsNqwc/cZidEILDZul4OaK6C3EaEXGE=;
 b=Uh3e5DIBRZO7w/tCkMuifnn30GTA89sXUS7yBCgvm/92vajB/E17Vf89mkK1wQ0sfaTzQSFQvxngVLsapvqyYnU6hX1qvyzyZ2e4kuv4Vh/8WVZl54tZG7BNaa2LL05xmw7rmvNc50ifZYcGvzBANuy6FzI964PdeTCq0RR2hf+1/LRxQe1Z3vGRxh1CMIkohAsHo0OILGiAnJuNnChwdK3EJkJx7nHOMjWRkmLXXQPf7UMJzCMwPMeZdO++e+viZIcTB3JDvfsiZHHSVsnYFOjnHLr2AncGgAOkA03hH1yGgWGWejQZBW0JqQN/lVJ0QYMDpK3uSliyPx5n+PoRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaKMClJOEPpvCtn06N8FwB5TNXubCda4AggAA9iQCAACGzQA==
Date: Thu, 7 Dec 2023 13:10:44 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245642F579F30840E67FD7C928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <2df11e62-6cb3-413e-b72d-3a2f6b3332ec@siemens.com>
 <TYVPR01MB1124553711DEB70B23EDEF814928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <ZXGm8hlfZRmosI1O@duo.ucw.cz>
In-Reply-To: <ZXGm8hlfZRmosI1O@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYVPR01MB10767:EE_
x-ms-office365-filtering-correlation-id: e83c0ed1-dbc7-4b83-3fc0-08dbf725eb9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rp6Prh2fhniDquS2U3z4mpq8EXRACOR3ta2rjw9tpYIztQe3lglVfjfJaX3bpoUZHXDfp+0Zk/vxvSFNhQGmK+TTYNyNTjFY9p66wzezHym/fMlB/LsarhFQw/5hv4ohUVXwjvkcdTQ+Rbz332pEnQ10aMIo406vCKnoIWRC4gDk1sfxfoYOCXOOsB/giZ43p07h2UcD5+bL5i2cjqXp3osW5y7eLwV/xtR6oJb2Cy7FlRznnaoEP4Z2KkbqDncBZUewoH7YFemd3STVGn3kfiaT/sieTmJYJfcEWp9AY1ZcWt+JFx/iCAEz2UKKzK1MZ4swVHwLC7pZwTyffWbys0+UVXWIVD8xH48bUq124PP3nbHnbIyyhRrNWDOKR3ZzhAEREAVW1XYgORHv7iAOUjSV0Zv6sZl5gSRVW8arHET+jPajr1kn2aIiLon0tHeu9mpF2YB342cK+On/4lHZLwHgyOfwI/RmklexN2LIBx0UUAoouCf1HiaITUGF/CYwrNCITn6ZT6hox2GOSAT3sVF4Hzl1XCDqAQZKBxEjfyOI6NV8ddSQbTKrCHIYzi/Ovs5uRHvds/UcuKiOPPCof44PPFLF5zM6LbNzvCOODYCjK06Co4KMwcCFtGlTUC1USM3VVMoun4jioNl//jJCQg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(33656002)(2906002)(38070700009)(83380400001)(55016003)(38100700002)(122000001)(86362001)(6506007)(53546011)(52536014)(5660300002)(478600001)(316002)(7696005)(966005)(71200400001)(8936002)(8676002)(66946007)(41300700001)(76116006)(64756008)(66556008)(66476007)(6916009)(66446008)(9686003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a29DQ0owMDBuM1ZtV3FXak9LWHEweW05RXVMZ21BV3J5WkdyR1cyV0pH?=
 =?iso-2022-jp?B?dE5jYWV6WEI5MVcrYmNjSXJqZEU5OUFnaDB6bEJ0VUlzNzhueENGTnYy?=
 =?iso-2022-jp?B?TjIwQ0drUHd2U3E1bk5iMkZVT3pNY3J1WDBDV2JOdDd6N3lySjFLdXVE?=
 =?iso-2022-jp?B?aTFHL01kNjdMSEpvNjJqNnAza2JsWUdjYU9HLzJPeUo0S2RkQXZVZnZD?=
 =?iso-2022-jp?B?Snd5MHUwODhJaUdNN2pueThqK3N5a1Zaa01ueFcxSE1TaDZzSlpNVGI4?=
 =?iso-2022-jp?B?Mzk4SUxtclNEbGpUSnN0RHUzSEozZ08zRXlHYmJvT1hBbjJTQW9lc0l5?=
 =?iso-2022-jp?B?VDUxWW9mMjR2ZUkrT1FtS2p6OXJ3eHZkbHJDQVhYOTBiS3JMR3ZucU4w?=
 =?iso-2022-jp?B?Q2haell0QWdqWGZKdTVoN3p2RUk2Z0puaWIrZW9ROWlnWDFXS1Bqajgx?=
 =?iso-2022-jp?B?bGw1Qk5yS2twUGNtR2xIdHBmRkl2RW5pa3ZPV2lBdjFUOXNLWkc4K1R3?=
 =?iso-2022-jp?B?aWM2Uk5QZnp4SHQyYnlrQmltMUVqc1drSURQanNHeDc5R3E0UmVZVFFP?=
 =?iso-2022-jp?B?b0tiNk5xcnJiNVZlSlNqZTQzcndWbm4vMjJyQk14VVpPY2JPazZhSFJs?=
 =?iso-2022-jp?B?cUQ5WjhYazdOUURmRVdiL3BHeW1sSUFKTHJRTmxqcExkTVBhQUhOWktV?=
 =?iso-2022-jp?B?OXI3T1pYQmRVWEs5c2RTK1p4S0pkbjdZb3JmQ3VKZXFZNjA3SEE2NEl6?=
 =?iso-2022-jp?B?ZUVDV2xzUmdITUgyRklGMVlnc0xRZHhzSkRaTDR2RldGc0dBbzZiODlt?=
 =?iso-2022-jp?B?dXV1NjA1cWpvREI5NlNadlVhN3FkV0xZVll5YnlQVndETHZnWGtPK2Vw?=
 =?iso-2022-jp?B?dUJPSWNJUDdRRWFMRGYxa1ZkcGlrMlZSQlJtMk5LZ3RuOS9jNzRodG43?=
 =?iso-2022-jp?B?LzJSQjhVcFg2YjVNWE4wU0swL25BNmVxVmRxVUNBV0s1V2dwNHpjN0lG?=
 =?iso-2022-jp?B?SzRNc3B5OHNiOUhnSGx0bjZ5dlYyU0lzdUFYeHF2NUU3Wk8zRndJTkhx?=
 =?iso-2022-jp?B?L0hyUlFLRHZWVExUVUx3YWYrTUZnQnpOT0NBblNsOTZIbkVMRUlHTld4?=
 =?iso-2022-jp?B?VjV5ZEQyazVWTUZhVStyc1ZLQ0pCcm5IQ2JlNEN4TXJNaVpycmEwVlI4?=
 =?iso-2022-jp?B?MFMxazFmb1JoaGc5d3dvbkxDSzFFeit4T0RxSkZ3aTFmSFIzaFpSWEhp?=
 =?iso-2022-jp?B?bkZ2UUZ3bUhVY2M3d3h6TTd2OXZaMWdWdWJKRW1mYytJYTJ6YXVnZGsv?=
 =?iso-2022-jp?B?NERJVkUvMVhzNVNZb0IzWmVTSVJMUjh1RlZPeGFWNmhVM0svRDdkY2Q2?=
 =?iso-2022-jp?B?aWZZN0VrcWdpV3U0TDZSaWhLcTJMS05sT2hkRWlZWHVXNmdlem1NRyth?=
 =?iso-2022-jp?B?MC95ZXZFcm5YV01ZTitEN1ZtOGxUOG14WWk2c1VMd1lhRmt6bEtOTWh1?=
 =?iso-2022-jp?B?NXU3Zkt1TGdFNmZPZHFKTTNXeU1CbHlKVW10K05NUnF4aHV2WDhTNkFz?=
 =?iso-2022-jp?B?aytkdTlrdE41eEduMnlFRkNDY2FDalpzYmFtdFYrbVA5VUVoS1MvQTFz?=
 =?iso-2022-jp?B?RFd3eWNHNlVVUU8rOXhodG4wZi9Wd1cwM1ZEKzQrZ2RmbDJ2a3BHZE04?=
 =?iso-2022-jp?B?RFprZitqY0FMamZqUHI4eUh4NnVYQWduUU5uVlNpdytEK1NqTGlyeE00?=
 =?iso-2022-jp?B?RkxzbVJpVGJnUDR6S05iWlpIWlVpekUvQkI2UWVMcGJsOFB1ODlFaVRa?=
 =?iso-2022-jp?B?QlpkUCtuR1p5N0JMNFo1NmpUZ1NZZE92dzJ6RHZMNGpFOUNCaXhSSWEv?=
 =?iso-2022-jp?B?a09oQ1BUcDV1MzArbUdRL0VmRm5hbHRiMUFsSk9UaURkN2c0blRVUUFQ?=
 =?iso-2022-jp?B?dXNRZjhCQTRaWTFKS1lzWFdqN0YzNmN6NW85RjdoWFh2MkVTZy9xei9i?=
 =?iso-2022-jp?B?V0FxeURmcVB3dE1mY3NzYm9SaVFGK0k0MVdJbExZdGRXSVd1Um5BV3E1?=
 =?iso-2022-jp?B?NEM0QThzcjdXQ1c4MCs5MlB2eU9Vbk45eUM0QjMzUFUvdVhUUzdNN3Vs?=
 =?iso-2022-jp?B?dXZ0bjZwOHhuYitnVFVTeHhPU2Izb0xJa1c4SkNEOWJBaVliN0NVVlEw?=
 =?iso-2022-jp?B?UnNrTXpXZDVwaU9STE9wVHhuTEZNMjVJTGNpMUlXcFo0SHNzVmtIc0hy?=
 =?iso-2022-jp?B?dHpNRWlBUklxY2NvR3RlYUJ1MlI4T203WnF0MTFSbHRCeCtCcHUzNk5T?=
 =?iso-2022-jp?B?bVE5SmduelZUTStOU2hZRitnWjNEeWtTZkFrMFhMZmlPYmE4UGhwRDV6?=
 =?iso-2022-jp?B?QUlkUlRiNXZOc1luK3BhZzAxUUw4dUtqdGJlbi9oVFZWZmFWYUozMXZG?=
 =?iso-2022-jp?B?T2tUNzE5Ukt5K216MmVnYlpUcnJqdlNUbCtBPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83c0ed1-dbc7-4b83-3fc0-08dbf725eb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 13:10:44.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iB0YcV9PPfutKO7hS9XIdAjVfaCxcNkCu1UWaWhKlSSbx1x+AipLYlGclxEsXWepIopnNYSQkaAawB5vEr7mMsowdVaHCyO0Zp6l8vLSKMchi+Br7ylJ5GU/zYnmKRYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10767
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:10:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13834

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Thursday, December 7, 2023 8:05 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
>=20
> Hi!
>=20
> > >
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023
> > > &
> > >
> month=3D12&day=3D7&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p=
4
> > > =3D37&p5=3D241&p6=3D248
> > >
> > > USWest    USEast    UK        DE        TW        JP
> > > 05:00     08:00     13:00     14:00     21:00     22:00
> > >
> > > Last meeting minutes:
> > > https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/11/cip.2023-
> > > 11-30-
> > > 13.04.log.html
> > >
> > > * Action items
> > > * Kernel maintenance updates
> > > * Kernel release status
> > >   - 4.4
> > >   - 4.19
> > >   - 5.10
> > >   - 6.1
>=20
> > FYI:
> > Date (the data is created): Thu 07 Dec 2023 07:23:38 AM UTC
>=20
> Hehe, nice script. Should we put it into version control somewhere?
> I'm using gitlab.com:cip-project/cip-kernel/lts-commit-list bin directory=
 for
> various tools, so perhaps there?

No, this is still in my hands. I'll commit to that.

>=20
> > linux-4.19.y-cip: interval 30 day
> >   latest version release date: Mon 06 Nov 2023 04:21:02 AM UTC
> >   limit date: Wed 06 Dec 2023 04:21:02 AM UTC
> >   Status: late
>=20
> I can do the 4.19-cip release if that would help...

Thank you.
I plan to do this this weekend. But it would be very helpful if you would.
Please go ahead.

Best regards,
  Nobuhiro


