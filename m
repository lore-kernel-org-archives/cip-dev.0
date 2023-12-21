Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AD4C35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 12:26:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.49773.1703161577324938010
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 04:26:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3BLCQFO11438333; Thu, 21 Dec 2023 21:26:15 +0900
X-Iguazu-Qid: 2yAaL3KHmItSrmY1g2
X-Iguazu-QSIG: v=2; s=0; t=1703161574; q=2yAaL3KHmItSrmY1g2; m=ifnXofkJUTxeTMXt3xJl393iBWHNonwN82u+W35Xdbs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 3BLCQDb02235464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Dec 2023 21:26:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ26367p+IPT9Q1f8bgMQ2BnU+xrukpOkFBYIw+UR01vf8d8YMvKc87bjyJzBIzPkz4YuxXdXIALRAbQcemCV3B/tt+0N/mbwZgR+CobjMWqbIXRvOYkqyZA9wLp+RWLpTcMz4+HtLdcfhO7pO1SEHN8Xg+fa2RcE4nDFOqKmSqHo0iBclEFsGjxRCmeU5C2YknRja7aTvSYQY6skC3B4Av1dViQWf/3HcjpUPnI/hUAUtv+RHmS3w38d1rNnhJsmVwPfIfPO3fhc3pUJSB5PV1tebBYO73cERalhvz3haTUz3uacsI8UQkQxMS03qpvahQRdAV5XrDX0LVq6DBgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBrj+wbCHpjoXcB7boP8AWJrPfLph2rOmBvaeRN+ANM=;
 b=nYBAaxgCIgcm2i9OUJU2bBphdmpoRWtq6vxCxUqnONPTD9QXzuO/lF4pYZrAU/EyaKsK7368FdUxctp6QNZpubVh0edQgNnCk+5YGZOlbQoIjLhLQTq1+XKyrnngAl+aVgx9tnJAnYyK0Dpk8nkzf7hf3u28u6qRIRVeMj+GzhKdS3CdOYKziGylRvf1hWUT45fwQXhZrEyBBJW14KnVR/SGgcPI7bCZ7snXaG8MrZzVKldK3pi4/gZwy7ifx5Wlhko/o28h9sDgTMu47gCktwg9h3tZ75Qsc5GYed3sMJPb2UVfVlIzkwO/sEeer+EUpQxrX5z95A3XnJhuYmAYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat (daylight
 saving changes!)
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat (daylight
 saving changes!)
Thread-Index: AQHaM/rKnk+jAIqcS0iNdQR8LJPUBLCzqVyg
Date: Thu, 21 Dec 2023 12:26:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245D034C1C00A18600F1ED79295A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <ZYQXKKFbxBdJIBGl@duo.ucw.cz>
In-Reply-To: <ZYQXKKFbxBdJIBGl@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OSYPR01MB5350:EE_
x-ms-office365-filtering-correlation-id: 134e98e4-5efd-48e9-2d8b-08dc02200371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8x1gF5WiF4rVfruh2YaKhIRrxOSchBGKUSsmGmWOUirknPMezNeWUzgEKNNv0KRKMC7g+iz2p5cuhRJKz7/iBajhwrfXzSg9SHDL3yQdMOL2y5vQKcN31S+bpg9lJupsPxhXLsdwxLlZoSvsEYTKLz993mhI9rolWPuUG2HGf6m2K9UUsLMbsVpjEWebmim/FZnkaZIT4bswx8TqFynFHoCDa6GNL2VyWdY6AGfXYicbMxMtXfdLQS95l41DyDGQYyM4RRESJBYv89HM+an5NNfrndrEfjB3m5Q+7xjph7UzEvDoXHdqsLjQJ3mXntu3v5BibJCSSyfuK0l9p5b25XcZ5qi6o+36gb8AAlefkv4R0+vGvgay7cEIulokMJ5a3ZmUsa/9el5rPwfDwugHlc8MqR4ZdyTWTPomI4ZU15ZDTqRRpFFP6TORx1a1XAq3EEyR2GJzFvz5w5MEAkvE6ZnG/HfJBN+svgP3LCaniA8L2eO/EB07pcK9QpOXPUU+1HNjV88wD0MSdwrTVIMPGCOaiKVGH3PXq0Kesvt3kvhne5D9Du20bORgKNbMgY2c2CV4T19TaPNQhioX+NwQxi5AmWE/q88bYB+YJI/hvTb3FYp1oL+tv1gEisIw0StE3gJsIALYrSEZs7qb/FmASg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(55016003)(26005)(478600001)(71200400001)(7696005)(86362001)(33656002)(122000001)(9686003)(38070700009)(38100700002)(41300700001)(2906002)(5660300002)(53546011)(83380400001)(6506007)(6916009)(316002)(66556008)(64756008)(76116006)(66946007)(66446008)(66476007)(8936002)(8676002)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZjFpOXEwOHRzZ0F1UWFhdkJ5eHVYN3hDNERvY2NTYlRVb21xQ1B4a2Np?=
 =?iso-2022-jp?B?QUNSNGVZekJCcTZJLys3YTRkV2lKci9KVEJBSHZxVjlsb3F5R1kzK3M3?=
 =?iso-2022-jp?B?bDFMQnRwN3VINUZRNEEzdHVCd3grYnlIbjlvRFIwUlBVRndPTjFxUnoy?=
 =?iso-2022-jp?B?eUQ2d0tBY3k2anZoRXF0aW5FaE9ha2lma1VqR3M1WklzcVNvd1JzT2N6?=
 =?iso-2022-jp?B?WEpNSnpQdzFTRW51MkM5VzRhMmp5ODRiRnVHclkwbVhrQjVycGZZT2lR?=
 =?iso-2022-jp?B?SzQ5YnZMdkJzajlXT1M0aU1kdGR3SDFnUmlhbngrSi9paEVXVXREb3Jh?=
 =?iso-2022-jp?B?MGpkbStEYUpmaUJiTC9TdXFYbEN4WmhvcWdHd1Vzcm1FdEc1SmlTNEZn?=
 =?iso-2022-jp?B?MEI3ZmhueGtxVGk4SlNKR2hEVGdwa1FQMytrMDkrMmVPaHE2bGxpc3oy?=
 =?iso-2022-jp?B?SVpzV2g2Q1EwNkZic3Q2a1cxNDlkek5aODJGV2swK3E5NjUrbmJKS1Fr?=
 =?iso-2022-jp?B?cHpybXVBNHdVaUo2ZWpqZzVRRm51Ym5PaHBpY0pzMzh3QkcwSGZjV3I5?=
 =?iso-2022-jp?B?dUVMdWtWamJPaS9kTlprZ0ttNEw0VDVKaW56MzBLMTdiKys4d21QclNB?=
 =?iso-2022-jp?B?MzQxTG5IN2xiS21ZcjViM0JZRWI1NTlidjR2bHRUUEczUlhwb3R6OEEy?=
 =?iso-2022-jp?B?QllGM1J0UkJXQWNuSVVyNjlESUVWSEpaYndEaHZrSGI3WDNjSTdxU0FG?=
 =?iso-2022-jp?B?MmprOGdhbThJM09BT3pWQWJxM3dyNFhBeWt4L0EzdkorNElJR2E2N3Ax?=
 =?iso-2022-jp?B?djh1S2hRK3RnTmVmQjBXOHZ5MUIrbDhQUzh3aDQ4RnYzcjZBT1hqazhL?=
 =?iso-2022-jp?B?VnJkN3cxM0drZWR0Unh4RDZyWW1ScFBNQzBaTWdRUGlMTFA2bEMvcEJv?=
 =?iso-2022-jp?B?OUkvQkIvWkNucW03REJKcUlHNGMwSks4ZkNWY1Nra3dCcysvQ2RJV1Rw?=
 =?iso-2022-jp?B?Q3Q3NjlaWWVISXVwK3FGZ1dJU1JyK0NVNlRWNS8rQVpaQmdrTjNHRlM5?=
 =?iso-2022-jp?B?bmRsNG9RZlZpUkR0MTluRnBkcU9yRm9FTlRFWWhpY1J3WWxaNkxtYjR0?=
 =?iso-2022-jp?B?RUVlUlJDbVVxclFncGMxeGE1a1NrRGx2Mi9qWkJHWFVEOXpIQm5uTVhQ?=
 =?iso-2022-jp?B?bnNkS0RXK0N2SFU5cENJWGhLeUYwUjFUejJEODhQeUVPckg5YnJPVHlV?=
 =?iso-2022-jp?B?UE1rTGRCQkljS0YyVXQ0b3NuSVpMN2lJU1JzRU1QNzQrT0tXYVBJaUMz?=
 =?iso-2022-jp?B?MEJ1QzJpOWVEcis2Z0VMNXRvQ1FUTit6OUdDWkNvcXJyL1dJbGI0NllP?=
 =?iso-2022-jp?B?OGtEZ3R1Mk9vUFNDOHliekZLM3NEc0Fxc2xNc0dreHF2UjZFNzd3eG8z?=
 =?iso-2022-jp?B?QkFUMXI2aE05aURTTGk3SVlyWTJPYmxIWU12TjJwWmpyWjhoYjFkbGVM?=
 =?iso-2022-jp?B?MmVrdVR5V0xsc1FmemorUDNvYWxXbDlMMHVjeDRWWjhheS93M0ZjQ1VG?=
 =?iso-2022-jp?B?U041QVlqRDVCc1p5bTdvYTJWaUJ4MGEwY29vWWpIUjQ4MGdWUWZJaGpo?=
 =?iso-2022-jp?B?UVlRTDVESUZScUFwWEFLYnVETkQ2bHA4T3VBQkN5TmROK0taOTJZbHhV?=
 =?iso-2022-jp?B?ZUFVTGdSbk9OU3B2YjZHakY4MFY2Q205MjRzOTJremRId3hjV2VpUlpR?=
 =?iso-2022-jp?B?UFJZdVQ1MlZhMlJEa0xQT0dXbmRQZEtMcWhOVWNpSDFZRGg2WE9Ta2E1?=
 =?iso-2022-jp?B?WDdOVzNZRHBlY2k3ZlpFRUh3N0d4TG02MnBnMnBjZGRoNHhObmZJMVNM?=
 =?iso-2022-jp?B?RkpHb3JCQVRYOWdlWlYwN3g3VThzQXd6S3dlU2tmYjZCSGluZzhocitE?=
 =?iso-2022-jp?B?ZmZJaElCSy8wcWlPL0NhS0RQMkJ2czNka3lzZVRtd1EreVR0NWFNd3Z2?=
 =?iso-2022-jp?B?SUkzbVFxM0lORG83TE44b3dVTS83a21PcFVWUEgxZU1OMmpCclpSY20x?=
 =?iso-2022-jp?B?TTF5US9ONzlsR2xNN2pEQThmV2lFaFdJTmtZS0VzcXNZZmEvVUlWYmpW?=
 =?iso-2022-jp?B?c1NRdTYzTGhOKzlXUjhLWkJNRlV4aS9vdUJ2QmpycG9YVld3V3ZJQktV?=
 =?iso-2022-jp?B?YmdtbFN3emtQczJPVEVETGRhZUo3S3QwOGtVMStDbXl4VmFlaEpDdlRv?=
 =?iso-2022-jp?B?WXZ1aHMrcXEyU0IxdWtNZ1ZTTWg4SldZUCtLTlBLeW9Bdzk1VjdJUmhv?=
 =?iso-2022-jp?B?T1dpZWJBazJ4SGhkRkR2N0tPL052clpFTUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134e98e4-5efd-48e9-2d8b-08dc02200371
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 12:26:09.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hx/FERljNp9kAgW/HGUvNJm5PLHM2N5DimyJGML+5Wnq1m63IOhRH9W1XzFuZqt3Ppl8X4o6PoPoDFfzhlktyq127+JLapb0/86eafKUpW9ui9WJpiwjEbzoEm6gago7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5350
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 12:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14188

HI all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Thursday, December 21, 2023 7:45 PM
> To: cip-dev@lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat (daylight =
saving
> changes!)
>=20
> Hi!
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>=20
> > USWest    USEast    UK        DE        TW        JP
> > 06:00     09:00     13:00     14:00     21:00     22:00
>=20
> That is in about 2 hours.

* Kernel release status

Date the data is created: Thu 21 Dec 2023 12:15:48 PM UTC
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon 11 Dec 2023 02:40:37 AM UTC
  limit date: Wed 10 Jan 2024 02:40:37 AM UTC
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu 19 Oct 2023 03:30:18 PM UTC
  limit date: Mon 18 Dec 2023 03:30:18 PM UTC
  Status: late
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu 07 Dec 2023 05:37:21 PM UTC
  limit date: Sat 06 Jan 2024 05:37:21 PM UTC
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed 18 Oct 2023 10:02:27 AM UTC
  limit date: Sun 17 Dec 2023 10:02:27 AM UTC
  Status: late
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu 23 Nov 2023 11:51:14 AM UTC
  limit date: Sat 23 Dec 2023 11:51:14 AM UTC
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu 23 Nov 2023 06:12:31 PM UTC
  limit date: Mon 22 Jan 2024 06:12:31 PM UTC
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Mon 11 Dec 2023 11:00:07 AM UTC
  limit date: Tue 26 Dec 2023 11:00:07 AM UTC
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Mon 11 Dec 2023 07:08:30 PM UTC
  limit date: Wed 10 Jan 2024 07:08:30 PM UTC
  Status: On track

Best regards,
  Nobuhiro


