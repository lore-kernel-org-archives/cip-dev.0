Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D883C64ED8
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 21:11:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.1614.1677186675300509177
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Feb 2023 13:11:16 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 31NLB3Yi026548; Fri, 24 Feb 2023 06:11:04 +0900
X-Iguazu-Qid: 2wHH8MjPYSRRly9MFk
X-Iguazu-QSIG: v=2; s=0; t=1677186663; q=2wHH8MjPYSRRly9MFk; m=zM1CTAzwXfL33b+iMak3TT9w6YJZa9uieJ2618+wXpI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 31NLB0E7028945
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Feb 2023 06:11:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c115RNHOdF+5vTI0ysOcWPKtZwlav/tE06udboQF95lbugVO8ykZqvR9iKNMwQxUIOYEjwvEOS/lUDFjPjPFvmKXopsmXfxlW8Pu7i8rRh1ULuPdpzVtTzKIZoQs8BfwJoNGzqPPtljZG9Jq7oXxePnP2HEKTJYRFZN1A9PXWR24SDTVxCY07oCKSG5aW1qIIxN8oqTGn1MALOOYnR9D8gRUWaCcvNRIbAdQvfaKtpXxGBYf5LPDJVp+4sGzyElUERjFh/akJ4j1t1kS9pRGajBwp5CLEjSKF/ZEekIr/GchSmOudGUPEWOoRZC0Iv2GOs8BMSRW7Uenh/NouvEVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz428VwH1/Fv+e+tAMgGsrYcvJ52pYBfarRGCgLjsi4=;
 b=Dgz5LGo6bdZLCNaSa4KrbxFQBOX6tp2jWOl56TwjoXTnAnGUeQYu8S9TPpxQTBJasE//FxDfiHumAepNdEGbdVcRVtgFSZEnYq3qapPX0nmPM3679FBTGdSKqbLTUHmAehEH5PAXMLZYn/DIakGd6iXemRaHoZ5TSAGB9VJ4SnOuuogMaM4TkDYPcUuQ31mD2MFw0xhZXrBrw5gJSFgkkqt4SvQolDv2YTvh1VuddM7NZKfJ4qYW6k0ejf7xsjd1P304bWjLVXiLV+WvmlCwc7VTwx1Zros2Vx93Moy29gvQn4LkK4gQoo/Z+n6CIhd33SLVx7riSQdgTXWD5pHAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Thread-Topic: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
 improvement
Thread-Index: AQHZRcrnnXCEw7h4o0COsL+BsWK0dq7aC9OggADTqACAAitHUA==
Date: Thu, 23 Feb 2023 21:10:58 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB942053EC3CBBCEA437F6D6E792AB9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB942011DEBBC3C691EA12CEB092A59@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <Y/YEVIJ3F5ci70Ak@duo.ucw.cz>
In-Reply-To: <Y/YEVIJ3F5ci70Ak@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYAPR01MB5516:EE_
x-ms-office365-filtering-correlation-id: c75949d2-b9ff-4b1a-8164-08db15e27602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OrLjuKvy8jTH0wFQ4vmUy5WB83hnP51X0Xt6Q2tYazWXb2Us0w/iyBCKLM/lJ8AUSAyxdJwqSY63MK1VB3eHjxzhFiQhpKAghEseARe9DERAdtOg/TH1z6lT9zarm+sPvx/V8FsHqFmNCQvNmr1kf3mg+fcUMNPhtODnESCRw22tPQ0rBp+iFixat1YncMlG+tUgYdKQI7cyL3cqkBV4qoYDA0Iqyk9F0L2EHF700aW96wkOGr3Q0mrm/ml73LC0088LQH5vbau9d1nMUpEuKj0YMh+37kUF8deJMp2Q+Yc7SM5MyiJz0YG8GpyY5m7gsb51RKh09Wejr66SXdBfqR3JU5wONS/ES7gUzHEI/wdl33Ls25LhgAm83SCsgvqpqrB+2zGfy3aKtQJ5NDaSY5v6SM6gUabctiZmojvrKtN94hTAzUuS3s/Swijc64KWFtB3bJdGG3Abs0atT8TeP5ms9oFgilKIk35ruZkFOazfuOOv6Kt9oXdbp8fV6P8JaoqTCPQahdMwbOD7lOlakMaAw1WgAoU/Ua9XNLQcHv7CSOoBGPgTOJATA6Ks4Y9VADKshUzO9nxXd7iNkH9MhyILb6xZtYwO5/Kjgg41efRXfhY2s9JXLdM7fLKEVeuJ5MokSQEYBREdENFN+19fk7WN6TLVebiUfJ9vWEzpqKaI0HvSKwLiAc9tQ33OxzABdkKJ3Eu6cl0RC24OUDbztQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(7696005)(2906002)(66946007)(38070700005)(55016003)(41300700001)(53546011)(186003)(26005)(6506007)(9686003)(76116006)(66476007)(86362001)(71200400001)(83380400001)(54906003)(316002)(5660300002)(122000001)(52536014)(8676002)(6916009)(4326008)(64756008)(66556008)(66446008)(38100700002)(33656002)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TWNIT09NeStQeHRLSHdQVnVVSVFjVmE4TGdjVnFPa0o5QWJEY2dVeDlL?=
 =?iso-2022-jp?B?V1d3cEV0THVpWWdRV2hmZmtxNzhiazlaeUZwVkk4dmlnZWpweWdFaXBi?=
 =?iso-2022-jp?B?OVpSQllnejlYZ01zRVNIc2ZLd1hxZE56a3BxbG1VcjE2eTVXckRhdlY1?=
 =?iso-2022-jp?B?djNyM296ek4vbGo2dUl6U2h1MFhYcjNvQmVOME5MZm4wRjRzc1NmNlRx?=
 =?iso-2022-jp?B?UjhJS01OcGJERUphTzNIZVpkRzhRcXlYNFR2cnJPUE9zYVhSMGtnRVZW?=
 =?iso-2022-jp?B?Vm1KN0lKN0VRSjNSTTdYYW9FUnZ6TWU3ZEEwQkJidHY3VUFKL1JDOUtO?=
 =?iso-2022-jp?B?MHUyZDdTNUZjbzdmSVp1Z2tFaHZiRDloTDM5cXdOKzRhcWYzckFDT2ZQ?=
 =?iso-2022-jp?B?T2ZQdDNnNmFyL0JIck11Y0VuLzlkS0pud2lBQ2JwQmJkWXd6U2w1OWNy?=
 =?iso-2022-jp?B?d3NIS2I4cUlhUVBWTFBSSVBRSHdVYnRXU2diemNhWHR3TWxCR29yU1Rj?=
 =?iso-2022-jp?B?MTdYUXZqQkZtRk0xbU5Ca2E4bEY2WDB2cmlvTkZUczlzbXp6TjFGRTh5?=
 =?iso-2022-jp?B?QXEwZ2x5SWdFWXV2enNCc1pzY2FhSWR1NTIrQS9hV0dwaHZSUC9aV3dW?=
 =?iso-2022-jp?B?QS9ybFJyZkNKUWVXSFhxU0NQaHhoaE5qVTJBRUFpUng0dUFBL2VNVWdL?=
 =?iso-2022-jp?B?VGk5YUppKy8ybHJtd1RobGRnblJpSGE1Rm9jbTdMcGxQbHNmc09FMUJ3?=
 =?iso-2022-jp?B?TkQwVTdlVFV6MFFUckROTU9lajBVd3FVakw4ZTFKUy84WEJNMHpUVWxT?=
 =?iso-2022-jp?B?L25TeDdCM1JFeU9HOWN0amR6bWUxd1I0bXliRUdJNGFlU2Y0Ynpjb2tB?=
 =?iso-2022-jp?B?di9ocHBkQzgxZDM3dkVxZkN1dWFscWdQVHdOTFAzRzVZYkdRRnhVS1ZK?=
 =?iso-2022-jp?B?U1dXdlNYVTJrUDdZbmVtVFFiOXlPd3VXWW1oS0pSdnRSNWtwZTB4dXRY?=
 =?iso-2022-jp?B?V0toRWR4Q0NSbnZRZ0ZSVXNSamV6QldMYW0yM2tTQ1VkR1hQUUdsTTFt?=
 =?iso-2022-jp?B?R1BtZXdMMzdOL0cvRHpMOUx2SGhwbWZTWWtPOW1TeVVSQXo4ckRXUEpj?=
 =?iso-2022-jp?B?U2k2a2V4RDBQaTVlaTYyL3hLODJReS9IYkh1ZG9YWGdYSUFxZUJOYUhF?=
 =?iso-2022-jp?B?MmRDUmJtYXhjSWNSeVZOL1Y4akp4TTkxSFhENGdrNWhtbnNLM01sTXNx?=
 =?iso-2022-jp?B?RGp3U0htL25vSjU4U2NRdGJGaXE3U3NhQlNQTFBBc1ZGdkEyM3Uyakt6?=
 =?iso-2022-jp?B?OTBQNlVSZWFINTIweVRuMWhnQkx4TnVHRGJCc0RtamhvYmE1S2NUSjNZ?=
 =?iso-2022-jp?B?cE9QbXA0cTRrNEQvclZscEpvVnhwQ3NOQngwVjRNOTNuVTdYSk0rQlhv?=
 =?iso-2022-jp?B?b0pjQlZPakFKbjFGejdxZHZFNnl1dUt4WGFMdmNzWHJ0Vk1uMm9SSlo3?=
 =?iso-2022-jp?B?S0ZBOW56VjlvR05HTzZ4SCtHQ2J2UEhPQ1lHZ3M5VGxFZnpvUldmWnV4?=
 =?iso-2022-jp?B?Y0ZRUDVYdU5ZRDJOMkJZNXlzQ3F5Q0JkekRmc2dPSmxjbXNxRmtJR3Qx?=
 =?iso-2022-jp?B?LzdsRG01aUcxQXAyVXJWdFIzcllGeHhCSzdOWVVlZGhCSiszUjNwemdp?=
 =?iso-2022-jp?B?VHFYelpLSmpxczNHSHdlVVBvOENhWWFHNHBqM3V6ajMxN0lFSE55WGRt?=
 =?iso-2022-jp?B?RC9rcFpnR3N0WVY1Tnp0TXFhQWRBN2NzclR3dCtuYXE3b1BBM1U2aDlU?=
 =?iso-2022-jp?B?STNkRDhDWEIvMlBHN1ZiVGkvNEtMd0M3alR3MStiVWJ2Z200RW13Rm8w?=
 =?iso-2022-jp?B?eGdPa05TS0Y5QUFGUTQweVdoVFh3NVhISjhMVkNMcVRkSDdMQkt1WEVv?=
 =?iso-2022-jp?B?MDlJNlh1NnB4WXNvQVgzekZBNHVPdmN1WnZnUGZLSlF0bUFKaGtHWWxu?=
 =?iso-2022-jp?B?L1ppYWEzRUJ5TDBhdk51dXJUNmJpZTB0YkFHa1dFVldnaWFEQTRiOUo5?=
 =?iso-2022-jp?B?bEsyOXcydnRQYlpjdFJlQXYvSjRmYXNKZzhBelBTTGNpS21tMkV4MmdQ?=
 =?iso-2022-jp?B?dDUrSy9zazVNbWlveEZNNEF0djBFQWM1bVJsUnlNZHVQQm80MTdpSVlZ?=
 =?iso-2022-jp?B?cG9VRmZ2c0UxOERmM0ZvTHdXZU9BVG5OVGVKZm9VMXpLbjlQdTJmNDlj?=
 =?iso-2022-jp?B?MFFTdlhUWmpxbU9POVpHVjdZRlV3ZllTUXdldHVLeEoxZkVkYzl5VUlu?=
 =?iso-2022-jp?B?OHdqbmZWcVFMRlFtMjNTSEI2emNBVE45bVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75949d2-b9ff-4b1a-8164-08db15e27602
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 21:10:58.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAdiU4giG1nMAmMmRpj8C9Tcr/h0pDALYRU5TkHoMA2nocFBM9dqJVnBoiO/w00zVN70nKb9WU0Sk26/gRN4dv5rmWanGw44vjV4e/uN8u29GakdgkdmzcNv6Eo5g/Xh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5516
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 21:11:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10798

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, February 22, 2023 9:02 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; chris.paterson2@renesas.com;
> prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: Re: [PATCH 5.10.y-cip 0/2] Watchdog driver fix and pinctrl
> improvement
>=20
> Hi!
>=20
> > > This patch series aims to fix reset issue with watchdog driver and
> > > remove unnecessary check from pinctrl driver for RZ/G2L alike SoCs.
> > >
> > > Biju Das (1):
> > >   pinctrl: renesas: rzg2l: remove unnecessary check from
> > >     rzg2l_dt_node_to_map()
> > >
> > > Lad Prabhakar (1):
> > >   watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
> > >
> > >  drivers/pinctrl/renesas/pinctrl-rzg2l.c |  3 +--
> > >  drivers/watchdog/rzg2l_wdt.c            | 10 ++++------
> > >  2 files changed, 5 insertions(+), 8 deletions(-)
> > >
> > I reviewed this series, LGTM.
> > If no opinion, I will apply this series.
>=20
> Go ahead, it looks good to me and it passed basic testing.
>=20

OK, I applied and pushed.

> Best regards,
> 								Pavel

Best regards,
  Nobuhiro


