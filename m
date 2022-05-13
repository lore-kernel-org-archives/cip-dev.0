Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E521FC433F5
	for <webhook@archiver.kernel.org>; Fri, 13 May 2022 07:42:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.5557.1652427727974527493
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 May 2022 00:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 24D7fwpD022139;
 Fri, 13 May 2022 16:41:58 +0900
X-Iguazu-Qid: 2wGrMWgEdbaOcyhutc
X-Iguazu-QSIG: v=2; s=0; t=1652427718; q=2wGrMWgEdbaOcyhutc;
 m=2NmiWBBfc0IEq8Vj4syyd7Oekw1984Xx+SVMdBVdSoc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 24D7fuMA001787
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 May 2022 16:41:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln1spQYEZFff0Qezr8TDukIWprc18kfImxxC1rkr8gfCsPahrCRDhSYsoDLN4VucUjKSG6mqDoLanV0E7B9dDWm4CSzDcUbXPyHYuE1p/nv1Z+fh/14QQlttNLiLqDcARmLqEb1OgiqjulCJSZN5QX9YFKG03cPq8r7JkmGzwbls6e31B0T8RGxRdi4PrK7AiXxI5DbfT1K3nV/Y0fKnHKBG5C5ZZH4mEZWVVUd0vHKba551XjcdAj0pjExIbBm6G3jrNzBZ3Fg07hndNs3VlP0eWwWfLX9vZnZm13+J+HutqGcA3movKaNKpcq+hd6G/fb7doD/IW9gc7wUAnZ2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COw1JWsLAZNBap2QEONvTh1JKQplpYLeAY3qTZOyNHY=;
 b=BtLFDMEJfUEICxWN1wHdV2qSOq5EkqUFwYa6pP2wyYCMHN6WRpUF02f7Y5ma9ePf2LhRDFV53gef89B24OdCKa4higqmxpmfEjFG+sdDBXgWRZ1dCdDxb1VAy+/JOtFsdoZwXvbeS+4BPrpt+u/svatU+N3KHpX6uV6vMKLGTJBpzkUMoSo+7iAx6aifQfrZTUCSWXbm28YFeRiLVbdke6vd6KjU1g24IcE4/9aZWmkFij4is2Pkpf7bcr9yHohAZK/KM2F3ntNYjHk3Uu38swRRxHvGCpkjBJEpze3Wh5K7uOomJM1lYV12/mNjNQGts1AvNfkYuAI1AJQIaMI8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: Coordintaing -rt releases in May
Thread-Topic: Coordintaing -rt releases in May
Thread-Index: AQHYY5x0uW+FwqX7O0el1DbHnJT3j60XOTtQgADbyYCABFz4AA==
Date: Fri, 13 May 2022 07:41:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94201F4B49EB201D02F94C7292CA9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220509120033.GA25149@duo.ucw.cz>
 <TYWPR01MB94203CED9AB8DD767CF5614D92C69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220510130153.GA20410@amd>
In-Reply-To: <20220510130153.GA20410@amd>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f81ae8-af28-4339-854a-08da34b40c6d
x-ms-traffictypediagnostic: OS3PR01MB6151:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB6151DC84B1491A00D260807A92CA9@OS3PR01MB6151.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7AKtp1iLvYroOPSQkX5IZYoPmEUYxcSuIcebofjznM6BV3BRH1f6VAwLR93n/EseF7FTVOBXxFAXtukyqy36hB0N1TfuCCTdPqayr9wAyomynfxhjWz9LKUv5Rg9syJXoC6B243ANxLZy+o1KVWzDbrPgfaf6dvvdo/9BFYnxHdd1NR+da8p5Xb808Jg9Fs7snO51PGXcfaFoo/XlFcEGl7K7rL+tGNTrTFGiFhEQanIzaiZ2HLi3LfRrb/Yk7A1K6ELxHI1OGKfTiHjL3yG4cw0xJb0r27ZtME/OFNoF9+s8h6EVVDsIkWb350oonThKPSKHOx8dfyhU7jBvWNWvOtHHyNZ7i0eH7B7SCZ30d8cnUOwjSD4ezwvv8LCFBpmdfT0S9Jp+gaE9ADuF6w4zi5Ywldtg5zZCa3fj9r1JmZsyxWD5ONRSOnfgHdd5VxxQyqHEpZ3PWh2DpWtPVd2tgnDsEpNC8I+8qdJDt7NndeK/fzAliDaW0AtAhGc1Pl0aHva/a3gdzxZxnm4OkAyvVp6DVeCF29CDtk5gXGlWWDGuv0NWCkouJ+K14XrO/Ysm1srVc6dJYETQxPehDfYaBFPgNAxUcG69mZ7bmuA5vqYTf2t+yLy5Cvghn/qmCm1EXqgFcK6R49JCaxsXX2ZiNYowDaErTLGkm691OFLDfMFugLlW60o5asIX/iLs8QVkD1WYCOEsmPNQUlIgoY11g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(71200400001)(316002)(33656002)(83380400001)(508600001)(6916009)(66446008)(4326008)(26005)(66556008)(66946007)(8676002)(5660300002)(64756008)(7696005)(2906002)(66476007)(9686003)(122000001)(8936002)(38100700002)(6506007)(53546011)(86362001)(52536014)(55016003)(55236004)(4744005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eGF5RkN3bGszeDM2WlNLTHNTRTEzZ3p2WWkwczhnVFh3YU9YNHlUOE9i?=
 =?iso-2022-jp?B?bzIzN0Mxa2FGeGNQRXM2QjhNeWREcHJ5NXVUcmZYK1Q2TmpIVG1pemFM?=
 =?iso-2022-jp?B?VzErWng3MDJON0U3UVJRdVF5WUo3TEkwc3A3MGRSS1VrSUJuVm4wY0FJ?=
 =?iso-2022-jp?B?TUMrQ01QY3Q5UUxERmZITFg1dzlNdEtYc2RtbEFQMXhFZDVBb2ZZdGVa?=
 =?iso-2022-jp?B?MzFLVUFGNTlGK1FERFdFbjNsRTZVbndTL05nUHNEaHlTOXdSZTgrOU5s?=
 =?iso-2022-jp?B?MzhaSlJLK2c2cU9YbFNCYXV4VzZLeUlNTUlSdlBjYzd6ZTlDWmQyNzMz?=
 =?iso-2022-jp?B?RFE1THVVY0Izd1p0TG1RSG10QTFQemRrZzR3YUZpekkrYjlaRzVReDdB?=
 =?iso-2022-jp?B?OCtxKzRlUVo3cHJZV2JKUUFjRWZwMnFKM2hSSzdkNHZEa0pTMG92elVC?=
 =?iso-2022-jp?B?RVNpQ0MzUUJWWTU0VjBOblA3emY0eHQvMis4MW5rNVgyRzRseXNhZCtC?=
 =?iso-2022-jp?B?cWY1TEI1YjFOSFMwM2hQNW8rUnVsUmE2NHZZVG1qNEhJNjFZS25qN2dD?=
 =?iso-2022-jp?B?NzRCVG1FN2FBNllXTDYyMFZoaHlEZU93eVBRVGlHL2g3ejcyRHg1YUNT?=
 =?iso-2022-jp?B?NW5qWW5rL0luTzZSTmNnYnBQdzRMOVVxUE5iZDZDdGRVbk1LYWJwdTJv?=
 =?iso-2022-jp?B?M0crVktaeTAwd3VVelZ3dzRxZHNUc3JmdXRheEtWVUgwRXhMdWJvZlAv?=
 =?iso-2022-jp?B?bE5DQm1MVlBWK2ZPQVpFbXVsN2NEWHloYko1SUV2OXRYTXhpVEQraGpv?=
 =?iso-2022-jp?B?eUdWZWZLOVNid2dZaDBJSzRvMWpOY2grOHRYV1dGTExTQ1g1SEhaVmRG?=
 =?iso-2022-jp?B?UUYyakFoZkRJaFZIbHdaMm5iT3c3djVFUnZiOFdrcTk2dlBPQUd2M0x5?=
 =?iso-2022-jp?B?THF0cVpIYmhVSUVMeThweWh4MWJweFk4Ykdoay9lbUZBcHkwWVcwcWNH?=
 =?iso-2022-jp?B?WkNNekZDTzJJWGRTOUZZbjNYNEF5cGlpMUQ2UUR4UjdBYStXQ25Ob1NT?=
 =?iso-2022-jp?B?ZVRGVHpYV2FYYng3VW14Ry9DNGIxMkNndkZvb01iNUxMY0E4ellSaWpk?=
 =?iso-2022-jp?B?UFBMNkJRLzBNM0Y1QWhMV0ExQm1jY016amVwd2RxK3R3a1l2ejluTE4x?=
 =?iso-2022-jp?B?STVGbzIwQy9ORk5aRVFYaGdHNWIxZXZHdG81NE5Pc0hCOVcrS3FoK3gx?=
 =?iso-2022-jp?B?NFJTY2IzNlVJVkc2S2VXY3BWTHpjVWpJRVU4eC9HTXJ5L2VETXVyK2ZZ?=
 =?iso-2022-jp?B?QWJxQllEN0ZsT2FzMWNYZTcrNDNiQk5RUVdpT3E0Zi8rZUh6R1JaSFlW?=
 =?iso-2022-jp?B?QzNHZVlrazlVVkNELzM3UGVXQzhrem1uSUxIR0NWRzFPZ2pBaEpOdUJi?=
 =?iso-2022-jp?B?Qkt4WjEvY2c1SFpDbCtHcUY4aXNoQk9iT2c3NUZzNDZFSHZEZUdNT29l?=
 =?iso-2022-jp?B?TWZmUCtJK3JkeXFPOFEyMGNOV1MxeUs4MHh2c0tqcnNxUGVOODhwVHQw?=
 =?iso-2022-jp?B?ay9tVC9TdDJKSEtaaW1oMmVNT3pma0VLYlBuU25iMi9RNnAxZ3QxT1or?=
 =?iso-2022-jp?B?eDVSRit1NzBqZGJXaDljSXFHeVI2VUN0aEpraGZJMlZ0OHM5KytJQWcz?=
 =?iso-2022-jp?B?cHQvVWt2NTU3OEh0eC9BNkRJalV2VllXS255UFJIV29DSHNlcU1FN1RV?=
 =?iso-2022-jp?B?aGRBdDFGM0RQSXFUQU0wQ0pTMkVHT1ZOY3lESjVQZmRjTzN2bkREZ2tZ?=
 =?iso-2022-jp?B?RlBFbUtnVGpPTFEvK0lTL1JybjMrekk3V0YrOFh2TVVlVlIyckdKQW94?=
 =?iso-2022-jp?B?ZjMzaVNTYlpqMXlEUTI4Y1k4cEJwWlY0aFJPTHc2ZGZzSjR0dU9MVC9y?=
 =?iso-2022-jp?B?WkRsSGNJbGxqSkFMemsrekVXNnluOHpoTnVRa3E5QjFOZ1VtenBFUGFX?=
 =?iso-2022-jp?B?bkRBQW9UZ3ErK3pLTnNZcy9ETml0RkRPSWovUTUrazA5NEJ3bXU3aS90?=
 =?iso-2022-jp?B?M0dCS1RiZXhTNHFQMkZLTnRLd0N6Skg5NHZvYmt0Tll5czJHTVpNb0NQ?=
 =?iso-2022-jp?B?YkxXVDF2RHgzVXhzOWJlb2IxbExVNUFVUmVIR2dEditTeDNXMVRYN2dk?=
 =?iso-2022-jp?B?ZkRWVG1YaGFjYVBVaHFxRjhNV0ttUXNINGN1dE81SXBmdXZEREpOUzVX?=
 =?iso-2022-jp?B?OEpEV0NEU1hPa0V6Z2lMdlZKK2xzUWdBVGJDS3oxMi9YNjlFSzkvbHVj?=
 =?iso-2022-jp?B?ay9kTE1BZkNXLzZnR21OSWpsQmhNZnBoTHpEdkN5cXBzVENrREFxd2hK?=
 =?iso-2022-jp?B?dkpUdGFBRUdWdW1RcThVamlvRWpwQ0ViZkRJOUFPQmxHOEVISGhobkpo?=
 =?iso-2022-jp?B?MUNXczM5S2c1b0ZjMUorNUVZWjJnV2tkU3dxVUhmUlM2ZjVvMlU2b0hl?=
 =?iso-2022-jp?B?SkNvWUkzZ0tRekxrbkEwb2Y3Y2pIdENscFdFcXVjVWF3NEVXUEZOY2Fw?=
 =?iso-2022-jp?B?UDN5ZHk0cz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 63f81ae8-af28-4339-854a-08da34b40c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:41:53.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 6l412PWvzF+Ht13Zk26ytaa+MlFXHB9ooRN+CAwdZytA1i4OQpQ21jiHSG2kthZKPyluBZTKBHs+W5jZVfrMMh/ZMKcrrxCW8fqU0abo2yL+SbwhJjnBjjWVdZ+LXwsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6151
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 May 2022 07:42:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8344

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, May 10, 2022 10:02 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: pavel@denx.de; cip-dev@lists.cip-project.org
> Subject: Re: Coordintaing -rt releases in May
>=20
> Hi!
>=20
> > > It is time to do -rt update but I don't see good match in releases:
> > >
> > > 5.10.109-rt65
> > > 5.10.112-cip6
> >
> > We have released v5.10.109-cip5.
>=20
> Ok, I created 5.10.109-based -rt release.

OK, thanks.

>=20
> > >
> > > 4.19.240-rt108
> > > 4.19.239-cip72
> > >
> > > It may make sense to delay or do extra releases to get matches.
> >
> > The latest release of 4.19.y is 4.19.241, but we could release CIP
> > kernel based on 4.19.240.
>=20
> I believe that would be rather "strange". I could do
> 4.19.240-rt108-cip72 based release, but I guess it will be better to wait=
 for next
> 4.19-rt and do a matching -cip release.

I see. I will wait next matching.

Best regards,
  Nobuhiro


