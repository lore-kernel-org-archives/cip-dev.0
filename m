Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8AAC433EF
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 06:30:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.7164.1636612210915832768
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Nov 2021 22:30:12 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1AB6TopP018128;
 Thu, 11 Nov 2021 15:29:50 +0900
X-Iguazu-Qid: 2wGrZzhrwsvgOlYYZU
X-Iguazu-QSIG: v=2; s=0; t=1636612190; q=2wGrZzhrwsvgOlYYZU;
 m=b0e+qilOc7Uc6WXT00pfiubk5tR7pjDCcld6YjX5UrY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 1AB6TkMF018210
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Nov 2021 15:29:46 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 3AF56100126;
	Thu, 11 Nov 2021 15:29:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1AB6Tjgg026481;
	Thu, 11 Nov 2021 15:29:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRD4aDO6qMXws8WsQfu35jbmZmIyZY4IR92pMJDrs5Pu8WHEtvo/WHrJZLOX8zxygjzjNzOFBcfn3YIf+bezybdmQgKxSBZTVvH2M4Iw1Sppj/IFVm80lyv6mapPVD26H1iI+rfNUf82lTANUCY86L42yZfb5ZUtgtZUXnKcYh3chuyiUB/no//PgipFsSFp+oLuxPTeM/kRJe5BUElBTskdPtkrBRJpMNaQJC1JAy09fKEuQ1nTQMDpiWUZUhPCL0dFmCmsVPbyCQaHBH6mSfxqu2/TB46nTe2zEiKdgA8poOSM/nyX4/Slpfhrut91umCjDBWeuel4j7n+JdkaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a+gO258YEZTDV9maOAAOi5Jxg3OHaeh44N2TqcCR30=;
 b=mB/2HYcXwp7jvmPwZ2MDC18m+e0Gt6bCY0p1eRtLhMN2vLc3wHAKxbUnjtKdWKQm0YDTpmZfMn/3ni+p9vsQEsF+e7EhJsS/6FW38MLvcoMWmEwHTSIDA3daeJ8axD54gHJyuXOl7ighvfuix1991tD+j+mN2HC3QqDjmkJrsv0jICcR2BLi3CGl9zAKsQNf6n+DLeFtbZxSTAa704iimTxDKptHqgc1et97zG6XgNbGT2eq57LgAOTJcd140mF/032BXaY6u9k1DiMa0sIh2GrLYvTf8f5zvx0yX83f7+AYKzjFB3BIDCx2WY1H4wh+DwrvRtocgbhwHOxqQ6/3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
CC: <uli@fpond.eu>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>
Subject: New kernel patches review management
Thread-Topic: New kernel patches review management
Thread-Index: AQHX1sVKDSpG8mo8q0i20IN6K0w3Lw==
Date: Thu, 11 Nov 2021 06:29:42 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 8849e6d4-559c-c934-f2c8-dabb9f9b0bca
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e2deb7a-cf0b-452a-0df0-08d9a4dca5c2
x-ms-traffictypediagnostic: TYCPR01MB7057:
x-microsoft-antispam-prvs: 
 <TYCPR01MB705779562F0E31F887CA599492949@TYCPR01MB7057.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DylSFjQgu2FHZJ+2HUhFHhejvH/gNAobrS0PgmCZI/geeCqHAS95R+UFajXt5uc+6HK1Ny9ZGR+PgHtEc/XtvqWPaXLEux/X+xSNl/42S77Jm0wnOLHu6veUluO+lDKKAxDVkeoTe/D6yJjqNubmu1udQB2aFn1VPQpNzQkcjIHYQLTZGPkC6IOGualAfJz01VLCBgwx6PzJKqfMI3pPAFEf/fyYPA3Giv+MEmzc8jV2ZtJJ65EeqwNDql8tFQwKBRIRny7UmNtiP/0aaFZrB2iyTTkGJET1MmwbH8BkEurML1UljcSLYWuioJXVEfo19pnv7cuo/cagzm+5SLKcxNDWMqoQSyiyYxnp9c1Im4Q0HL3yKjEFcgXVjgrpUfrcZwGR07TeIXc5DmAFOcZ1IzCJbZXf3c8L5sV/+QWrRvOA35Jd+qmm/Bzxmjt/s1E8luJ2URUoVsu+v1OiAHhQvB+h9U3VYkGE2UoxIu9P6l+fivVx2gHpe9gKWlr0mWV737PQJyF4n0kHVPK1j99yrpyXvW5YM2ar12mux6ZrfgcBUCmfExXVA7dA7rRBlyi8hLR9fLfp8DPYTdEDp1eCznb5fjaOCFuOuYdZcOyi+LuigbztNlyK+HW1r1k7kPsyIg+S0fUcrW2Gxsg4ZPqS/dAb2kKbJzx4R3YcZ+zoXzcTba9QnxqvRB95X8lGLLyy3gT4egNWx5WVefU8OJJPGznzevCZHrcKcX2l7OOrzwAJiLRaTAt67lTcoKk0cviRSAUncnllUFAJNiKwWkU5jSuoJtNkDnSMW/JMcg7/v1MeZZIT1vY9Jb7+sobX6LThGke9xLMY2l1z3m88kyK+4g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(186003)(4744005)(966005)(66946007)(52536014)(71200400001)(86362001)(26005)(508600001)(76116006)(9686003)(2906002)(33656002)(7696005)(66446008)(64756008)(66476007)(4326008)(8936002)(6506007)(316002)(66556008)(110136005)(38100700002)(8676002)(83380400001)(5660300002)(55016002)(54906003)(122000001)(66574015)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dS9aWDExc0VDNVNaLzFRUDl6WHZiczlRdlFZdWFCWmp5aEFkQW9jU1Bi?=
 =?iso-2022-jp?B?QXRkZUpYTjFpV0IxL1U3NFpldHNUb0pFTWJocDdhRzFiZy9qdTZRY0Jh?=
 =?iso-2022-jp?B?cnNuUGRTdUZ0d2ZXR1hFdlA3UTluVVhkNUFGdWFXRUVEYU5pMnhDL0Ru?=
 =?iso-2022-jp?B?d2JMNUEwTGdCUEVoVHBxZUFiaHlzUHNNaHdDNC94MG5OOHBhTTFTWFd1?=
 =?iso-2022-jp?B?M0dRa2dHekdORDdsNmd6b3A1YVJPbThjVGFzY0NKM3ZPLzY2dmdoVGt4?=
 =?iso-2022-jp?B?NlJGTDVLMzVZOW5NNmwyK3htY09uK2lDTGdaZ25NZlBYNENMemFYazBy?=
 =?iso-2022-jp?B?Rm1uU2JWbjdxYVpLNXVHdllkS25YblNkNGZCQlBheHBNb2NoZW12MjV5?=
 =?iso-2022-jp?B?LzNWZXNCdSs5eG02YkQ0K2xxbGFLRDlHcWg4bi9MakxSMzE1S2p1SE83?=
 =?iso-2022-jp?B?cGM5K3ZsN1Axem1md0c2NS81bTNPZm42UTB0ZTBIN1BTcy9TYlA0UFlL?=
 =?iso-2022-jp?B?Tk5CV2o0MWhuY012VHZGcDZ4MENTVEJWTXRCbjFYN2ppcnFSaHZ5Z0ZE?=
 =?iso-2022-jp?B?L2wvQzRqdFdyNDIyMmJORGYxcXhEZ1grYnJnVTQ5S1dWOXppdlhjS21P?=
 =?iso-2022-jp?B?UU1oc2pVOUhmYk5BSXBVVU42SHN0NkQwVkUvN3U3MmJQdXJXT3Y4V0p3?=
 =?iso-2022-jp?B?ZmlRUTY1TnovVzdpUVM5UnNQeHdtcFpCZS9jczZrbnpnWDVmeDRoRGpl?=
 =?iso-2022-jp?B?Qkl5bU1mMmRwTmNOVVNZanEya3JyUFhyUU9ZczV0VUY2REtsREsrVXpU?=
 =?iso-2022-jp?B?ZjRDMHNsZU9lQllXQUJWY3puSVJwODNDOTRGdWJaekNMRkdZdy9LdWZp?=
 =?iso-2022-jp?B?SzVPLzdpTUlLMkhNcitMWWVGdXlVTU1GV0w3MW1XUi85TUsycHorSWZD?=
 =?iso-2022-jp?B?cVRvN053dm5CWjgxUTZFVDF1bGxjd1VCR2hkcjNLaDN2Ly9zS3FrMHFt?=
 =?iso-2022-jp?B?dklpMC9WZS8wdjh6QkkvbkNkS0RrSUw5UCs0WW13NFRIMEtpV2pETWVs?=
 =?iso-2022-jp?B?TG5ZWUJGNDFNNGREaUlpdVdoQ0d0bEwzWWxnNm51aGVKTXFHOGdUM0xU?=
 =?iso-2022-jp?B?b1BkU2lBaDZ6VzcyQ3BTS2NxSUE1cVQycFo3T2RBdWVXdUZHWmpJMWV5?=
 =?iso-2022-jp?B?Q2d2aDRycUlJK0ZFTXk3MFJSaHNZczBZUW9XcVFFbHE0UlNoc0FqWEVT?=
 =?iso-2022-jp?B?RFYzTWZ5eHpBTXk1L2lFQ1FML1NXMzZmMWMzeXdpZzFiRzU0a01vdVlK?=
 =?iso-2022-jp?B?L1hORTZKWXRpU0QrNmVNcGZUc2hOV1ZmZGxUOWtGMEpjVXJzYjlvRWd5?=
 =?iso-2022-jp?B?bjZBRmg3aTc5TFd4Yk1CMTV1UzNNQVZybGVMWEF4UXowOG14OHNYbVM3?=
 =?iso-2022-jp?B?REpCTVkyU3JobmRPclRZL1BhM28zWCtQZkhpVDhkRXdNc1Nrbi8rLzlr?=
 =?iso-2022-jp?B?Sk1sUFpQRU91clREbDRBNDFKNmcrN3JXQzhEZUFqVHdTS09IOVVwQi9M?=
 =?iso-2022-jp?B?TmJGMHMraWVoZ2hvQnhaUmZXK0Fqa3ptc1EyVHpnKzU0SStERWRKb3Rs?=
 =?iso-2022-jp?B?OTFIMHgzRnRBZExhYXJBVWliNVVWSDBQaTJvMmFFQXVLMGoxZlc2Zkww?=
 =?iso-2022-jp?B?ZmVQaXNsemFZVzlRbkwrSitSak9yaGx2akVXV0lGRmppZWxyRXd2MUhi?=
 =?iso-2022-jp?B?amFIY2lTL0g1LzlhbDJPQlFZUFRmWWxYUkVZdm9GM094c0tCUy9IaW1J?=
 =?iso-2022-jp?B?dThWRWtoRll3QVRpRUphN3V2bE0wRHpqUmJlNEZaRVZRT0dkNng0QmQv?=
 =?iso-2022-jp?B?NW1kM2RSOVlTWnNlcTBCc3YzTTZuV0hIVkZFc3lQUmdCWHd0N2ozUWxC?=
 =?iso-2022-jp?B?NHVHVEpJY0FGanFhWnovV0djS3d1M1lrUnVjRGVvNktrV3JMYzhYcEJq?=
 =?iso-2022-jp?B?NWN3T2ovSTVBVHdtQVBvQlpwK1k3bXlFbDNlRnViSHVHRzNVWnFZeXB2?=
 =?iso-2022-jp?B?NTJaRlV4bFEwby92eHVPZUtpTHo4d3pCR3I3NWw1aVVqQ0kwdkZUc05L?=
 =?iso-2022-jp?B?T3JtWkdnQndNRXM1L2JLc1JUUWI2Z0N0V3pxSDNtNzM2Z1FYcXJnR0Ez?=
 =?iso-2022-jp?B?aTBOR1RDckJ4SGtWNC92TEJ4WDJiSkFkb3p5Uk9FSUowUUt2WGRjMzY0?=
 =?iso-2022-jp?B?SWJmOWxGZkg3UG9tOG5Eb0p3T29SVENCdll4bWh1VzJqOVZuRlFLQkh4?=
 =?iso-2022-jp?B?S0hpWEZJdDFNRHJTZlNETWVCOFg5SGdacGtCM2tTeHBLOENGNGFaRFhF?=
 =?iso-2022-jp?B?MnlnN0dhOHFvQUhhcEIrNDFKV0JDcmIwM1ZybVNtSndzOWk2c2ZnNmlj?=
 =?iso-2022-jp?B?c2FueWl4amR0Z3NYS253b3pNeEJPUE8rVW5uRC9QMWtTUFVwanlFRmxH?=
 =?iso-2022-jp?B?NlByNHg1?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e2deb7a-cf0b-452a-0df0-08d9a4dca5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 06:29:42.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 5N3Ri+F0o/qYK/0w4nsylE85OaXu+xtywAqUKNCNiosNBrJV54VtPBj6jen9BBHGN4ih1ppiIG0JSU5YaSsXNa623tOTFj5gVfjJzR5SLuJ60lcrQzDBbxHvat4DT8nf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7057
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Nov 2021 06:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6873

Hi,=0A=
=0A=
I considered using the gitlab wiki to switch the current patch review=0A=
management to another.=0A=
=0A=
The gitlab wiki can be used as a regular git repository and can be=0A=
viewed from his browser by writing its contents in markdown.=0A=
=0A=
  e.g. git clone git@gitlab.com:cip-project/cip-kernel/linux-cip.wiki.git=
=0A=
=0A=
It can be created using the API on the project wiki[0]. Since=0A=
namespaces are available, we can also create hierarchies such as=0A=
5.10.y/v5.10.77 [1].=0A=
The wiki page is first filled with the commit ID, then the CIP kernel=0A=
developer writes the name after the commit they plan to review.=0A=
=0A=
The commit content of [1] is an example, so please let me know if you=0A=
have any opinions about the format and others.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
=0A=
[0]: https://gitlab.com/-/snippets/2200569=0A=
[1]: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/wikis/5.10.y/v5.=
10.77=


