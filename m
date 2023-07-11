Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45150C0015E
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 09:15:18 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.108])
 by mx.groups.io with SMTP id smtpd.web11.3494.1689066914029255268
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 02:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=pg6cvMLv;
 spf=pass (domain: renesas.com, ip: 40.107.113.108, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+egcrhOv2XP4+Xmqepz8IlhQVuUu8ZACRUcf8dwY2cbPs19gsww3goZgClCfT9RufD2jcbjNtyM/B7oXW6bwRVF+9y+K914c6ZbwulwiaNWGTKJODGHFQG5xU+Lf+vZUbgvdv/NwZzxwXT3Y7mEXpudNWY5eUrwr9y6/Hb4iYF9zVx7T+bKyAznasuZ6T5b78JG4ZJ/6/HsrCu4cq5j3ZrnAg0x2P+HhSh3NPfjDDnbq+urZy4fF982VcK6A0c8Jmg31INVgPak8t0zJVJt9SE6GRcKURrW7mA7yT5pa5M2ENvt34OwE2QDKFzRf8CqpIZmFQQqJLdqWRhGTyGung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liz+EZW6GaG/3XKgSQOBRR8TFWetr57fix8J4BD2y84=;
 b=XVHN7UL3Hn2kIJRX8ribf8+/C8NMpG13vDfwdm9gUxox1yOu/iwhUpP7kuXmY4RcbTwjd8W34Rq92YOOP3nX5fWVwlRkQ28zjUeQTqLEYHSNUhmm4AmSi6zP1bhGxY3bD0m1pFXSczA5JoDMkFYRQViIvKXv1GAoL4hUiHoaVHRI7+MP6i89fwj+Do9vGpBA5v7HQ340jG5JAsLArPIjl4+PZ5GlGHLkZTgAyfmeXgHIi0Y9SETpm5yoQcSUYKIhqQ3hE0Zzk1yiIc47qfnWf4Jvs9XA0i9CchykMppY9eFmArehs3uDKFkgW/fThFIeDP/ZuRs55afum2bn2uH/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liz+EZW6GaG/3XKgSQOBRR8TFWetr57fix8J4BD2y84=;
 b=pg6cvMLvkY7jvaaOl+bqGxksOOP61tGHlTcyxEelD2xSzU7Wideo9zN8sST5wqpSgtFXwOkPBHS3wzUjw0ZWYnlwwXh6n5TmXpcDvo9yX6IEVZNNYaWdMirLiOP7fIoT2Guv9UjFaCmXy3su8dVz2VxnvP06kAxH+ZOTZ6fOCzE=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TY3PR01MB11592.jpnprd01.prod.outlook.com (2603:1096:400:371::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 09:15:08 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::c3b4:9b5b:7ec3:7ab7%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 09:15:08 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
CC: "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Thread-Index: AQHZrdIq3XDB89H7b06mLbgyT4rIha+r8+GAgAhUWGA=
Date: Tue, 11 Jul 2023 09:15:08 +0000
Message-ID: 
 <TYWPR01MB87756342112FB5A35D4D93C6C231A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420D58265BF325B0FB9F9A8922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TY3PR01MB11592:EE_
x-ms-office365-filtering-correlation-id: 83310812-ff99-4709-9431-08db81ef5245
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WvSdEmumSmUJfKkkNnu8zE3J7CybZ54DuRovPkDksgoBjBI6HbjTIyAgHVllOz6WrDXg73YNssBb0MSKPrHYsUeG8CoEsff8LsgaYDGVCwa/wQSYpHQhUwUPExW2hD9eHeUmaH93pguk0EWudpQx8sYmY9ld8BnVGUA0WyFoKVVFTF5n6hZPwDaOOILT+rVHNaVmID+fw79XOHbPbUfToM3NlUdTA3dRlHwaJnaCnIOJPxTcffW1ugC/m8qTqvfYxGHQSHjErVTJSDUIT/wtUKpaGoYShEaqRq++JzZY9tTBJE8l5SrB/NGa8BDaSReX2w2W+5TYHr+2k6Pjmbi6/gimgi4hYPHdyQcn5KWXiK/LS2DsdQkpypS1lP+jITs9yVxuPK/isUSyvzRKpMPIYbShAT0STzNyYVhKjZTR7o9u/PcoZ8Q9cRyErNESMsYaznZ7IdnGKrSmK5P/yPd0SQ6qrApdxNnMFnm3g/BjLM5e5mKZJer3tkJN67P14Lzg90/UZHtXpiWYwAzIE6/ZQium7B18B5UnVNJlmVnGx9JKtpJhbCHmK/CIEb8y7f5VAbQ+KE3Ii9x+m6OQUtFvTfCn/NHzcJnllT4TDh+oHD4xTM3/ps1UoDdRzMudo3b1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199021)(86362001)(38100700002)(38070700005)(33656002)(55016003)(76116006)(7696005)(110136005)(54906003)(71200400001)(122000001)(107886003)(26005)(186003)(6506007)(9686003)(53546011)(478600001)(316002)(66556008)(5660300002)(66946007)(66476007)(8936002)(8676002)(52536014)(2906002)(64756008)(66446008)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WCtOQlV4K0JsZ1VkNGRlYStwM296bENHRFRCN0R1SWNJdHZZVmIxOHJP?=
 =?iso-2022-jp?B?b3dkbVNyOVdhL0RGSXhON1ZtQ05EaUxKWEJLdHE1dlRabE5aRlVUS09q?=
 =?iso-2022-jp?B?cWhUWm1USVRqNEMyVjgyaDNKNjUycDJLNUFGaExJWFNtTHVMRXBOeHNY?=
 =?iso-2022-jp?B?OEcybGZnZ2RqNmZ0SFdRbHRKQVBNbUROWmZuOWZXeWwyc05hZzg0bzIy?=
 =?iso-2022-jp?B?eThBdWRSNWpKNjkyT05hNTBXamRON1E5R1M0aGtrOUlXY3JvdE1DZ1ow?=
 =?iso-2022-jp?B?L2pyNlkvNmpJV3I2cmFvaktmTmorLy9RbkNmMEx2YjNVRjhCalBhc0M3?=
 =?iso-2022-jp?B?T29SOFBzSHFYQ2RQdVdic0dFU1B3RytFelNCMUpUMlBPSHR1Tm1lT0ZL?=
 =?iso-2022-jp?B?aXpFOFJMeXljSmpEMHhWQ21TQVFFbWhQM1NoTUZQaUlhYmVmYkFUVXVt?=
 =?iso-2022-jp?B?bU1tVS8zNFhkL0RxdVY2Q1hlNVl3T05RR2h0RVY1ekNlMEtFeW5EZ2Rj?=
 =?iso-2022-jp?B?c1NSdzJLV2RLWUJaTGVKU1F4K2JBazRWN00wWk0xUTBObHNPV3N5aVpj?=
 =?iso-2022-jp?B?Y08rYXJjS3VGaDZrODRvalNzR2c2NUZzaFdrd092YWx3Z1hKeEVySTV3?=
 =?iso-2022-jp?B?cGN2V0s5WDhSNSs3WkE5MXVmazRPcTVzaTF6Tm8wekgyRVBpUWF4cFFy?=
 =?iso-2022-jp?B?YmZwMDN0QnpMc3NRVWgvWC9ja3hwMFlHSytrbWsxcU5Db2xQaFovcDFh?=
 =?iso-2022-jp?B?aDhyZVFDL01ndTYzUkVZWFF4aktTemVZRXUxdUpqRWhOWmIwTERoTTFn?=
 =?iso-2022-jp?B?STNUZ1dVdFVYa21CMUZvN1dYWER1QThGdkg4RmtBRWU4VFY2VE1uSFFQ?=
 =?iso-2022-jp?B?eDFQb3JVQWR4UU42bEI3UnZVN0hnZml1WG5qdStrMVdISXYycXVwVytk?=
 =?iso-2022-jp?B?MjRhbGxJQytvZEtma0pEaXZseUhucFpJaUtQQndVYzRiM3JheFEvcTBM?=
 =?iso-2022-jp?B?T01Wdytaa0tHVjRXQ3dyRUkwNUN5VGtXd25wM2hmSjg0QzNtaGp1R1Ja?=
 =?iso-2022-jp?B?bVo5TURWWDY5N2dnYmFEaTE5UHZmTzh5Qi83OVNJSnFWb2kvYjdHN3I0?=
 =?iso-2022-jp?B?QTNDQS82UGxRenpBNFV6Y2xUeDlxTnB6UThpMSs0MmhiK0M4ZkYxd0J3?=
 =?iso-2022-jp?B?MUdrNTlLWG9lTEZSVzRxUG8vUHJsd2lmck5tQmcrRE9GVm5SUWphQ1NQ?=
 =?iso-2022-jp?B?WU1rNm1hZU5OemsyWWtCUndsODRZNzdsMVFlanVzVWY5azF1UzFsSVcy?=
 =?iso-2022-jp?B?K2h6dXNUVXExQW55VXVmNDdTVWtjaHVHNTM0M21kaklDUWtqV0tFdERy?=
 =?iso-2022-jp?B?SG5ocGRURkcvdTBMdVA4NHVTZmpDUGxwOWUwVW1TTTJ2eXZENXIwTTBh?=
 =?iso-2022-jp?B?a2l0TkZaVmtyS2U4QzV1aHV6MzRSZzEyb3N4UDhNdjlMRE5ubHg5UnpW?=
 =?iso-2022-jp?B?QS9lc2dURlkvNmVDd0Jvd0wyRUtOMjM1RmpkNk1URndGS1lRSFVNdFVk?=
 =?iso-2022-jp?B?SmUyemFWQWVNK1A1RFZyaEpZckd4c2cvUi92cC8yaFZFN0x0YkVsWW4w?=
 =?iso-2022-jp?B?MGQ1V0JDT25uaWFaTEdkVllEOWFBa1pkNWhNVnRieDVUelBKUTRGeEVq?=
 =?iso-2022-jp?B?Zm1IRE9nYnhwRHlkVW5TajRqNFErN0N4MkxUWVF6UDd2RGk3bE41d3lo?=
 =?iso-2022-jp?B?dDJQUjZvenFwRzg3dUUxWmwraVNTdjdUTHVrMXhjZ0p5REI3Q2JqQitv?=
 =?iso-2022-jp?B?ZC80Y2p2akV0bGw4YlpsSTFhQVhKY3ZvY1JoOE9pN3hiamlGUDdmdTV1?=
 =?iso-2022-jp?B?SGM4bmpEaWZ6VUdaVFZaSHdTU2JrdEhYWWk1TEpHcWtqejVpS2MwWUpC?=
 =?iso-2022-jp?B?S1ByaUpXYVA4ejdjQjhobHROcUtFK21QbFdjZE51SlBEUTQrTS9Jdng1?=
 =?iso-2022-jp?B?aUFGTXJ4N09rRkRrc2pYaVExc3orSURMTUhZTHdKV2hBSlVFQzNOZk00?=
 =?iso-2022-jp?B?MTNlVnlmbXRPUG44dXJobFNIUm5QZGxJdzhmdHVCWGY5L1hrNVBRYW4r?=
 =?iso-2022-jp?B?aUoyNmI5aVFkSlo0WEhlbzhBR3htaE9sUlR0L1k5eVF1YVdZYnJLSU5n?=
 =?iso-2022-jp?B?WEMzR2NDdjFJMFkvZGhlR3hIU0pHMFFhbC92TVhhWFhxYUlkOUR2UUo4?=
 =?iso-2022-jp?B?STYyMGlVazVVb1RWWUs1U2RoMm80RW9ONlJSTGtsUyt3c25qMmVlRk0w?=
 =?iso-2022-jp?B?R0RVd2lrNXJoR3NyOXlFdURNSTg4aEowaVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83310812-ff99-4709-9431-08db81ef5245
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 09:15:08.0249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMhQNHhvnC4Kd4a+m18X/5lz5eTpZak9o/9zRwjM14kFlufOyLU3aj5Q2EKvH9lSQf07ODjgpR0Fs0veBuQb+fnYlFAJnZw64XQJBf8rUBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 09:15:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12302

Hi Iwamatsu-san,

Thanks your reply!

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> Subject: RE: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas
> RZ/V2M
>=20
> Hi Fabrizio,
>=20
> > -----Original Message-----
> > From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Sent: Tuesday, July 4, 2023 2:17 AM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C=1B(B
> =1B$B""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>
> > Subject: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas
> RZ/V2M
> >
> > Dear All,
> >
> > this series adds eMMC/SDHI support to the Renesas RZ/V2M SoC.
> >
> > I would like to highlight that the driver patch looks fairly
> different from upstream,
> > and the reason for it is that the SDHI IP found inside the RZ/V2M
> requires a
> > couple of quirks.
> > The SDHI quirks have been reworked quite a bit over time, and the
> > implementation the upstream driver patch relies on depends on
> changes
> > spanning the renesas sdhi core, the renesas internal DMAC
> implementation,
> > and the CPG implemenation.
> > Considering the amount of patches that would need backporting in
> order to get
> > a similar solution to the one found upstream, and considering that
> the changes
> > would affect several platforms, I thought that adapting the solution
> for the
> > quirks found upstream to the solution currently available in
> v5.10.y-cip is the
> > best way to go, as it adds the required support without introducing
> > unnecessary risks.
> >
> > Cheers,
> > Fab
> >
> > Fabrizio Castro (4):
> >   dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
> >   mmc: renesas_sdhi: Add RZ/V2M compatible string
> >   arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
> >   arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
> >
> > Phil Edworthy (1):
> >   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
> >
>=20
> I reviewed the patch and found no issues.
> I can apply, if there are no comments and issues.

I think this series is safe to apply, as no issues have been highlighted
from the reviews.

Thanks,
Fab

>=20
>=20
> Best regards,
>   Nobuhiro


