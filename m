Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00C4C433EF
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 13:02:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.5827.1637758929368227120
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Nov 2021 05:02:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1AOD25Hp004087;
 Wed, 24 Nov 2021 22:02:05 +0900
X-Iguazu-Qid: 2wGr4QtDLykM9sOR2O
X-Iguazu-QSIG: v=2; s=0; t=1637758925; q=2wGr4QtDLykM9sOR2O;
 m=fcpDehLbaZ+NCjUDYqHUGhJPW0BoEUPoKIMdD9F6hjk=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 1AOD23ra011282
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Nov 2021 22:02:04 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id AEB471000D2;
	Wed, 24 Nov 2021 22:02:03 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1AOD23ol022209;
	Wed, 24 Nov 2021 22:02:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoZWgdQ6ogAM8Z++h12UasjcmgC9+d4JwiFIQCBkCqF7olmi+ayB4EuQRsoWIfZue47kGStIqmtOnzU40093fyL3pGNu+r+XIKcpRiM7fEh9Vji+sOgxofkR6OLD4muwvhTURRukrbqhRmLS4ed48ycxA3SORwPfD6Z7dd/tXEwg2h0qrl04HKv6orltBxgCM225v2Cv8b82avD6jNIODI3uIcS1xvzhBnNwTvAE55WAsMI9SOkFIeJw+J7U6WSWzOHtHORN39p+PcdP3aXj6bCdBHwrFMEp1I+Qou9xUZUxsPtp3n2N8VLNXvTlRIlFdAl6RKICBc1ooXTpp5NQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UzpkA1zJWN1hcbyrIL50oZw1AsNhF8rL0HxjdidpT0=;
 b=R9+EFaFgO/iX0nJkz7qIKWfhlLl52jFClWZl9ULnK9Jta8SjkMIG/cB1X4j6uaYbbB4v1oPfMI0Pb2lqkSupjBY4R+hHOW57865Xwx7vinaPNKMqLfD9jLinrfYNOajW0xkSgv2SjAoHQvdEHgoYzxVB+fZqSxbahZMrwAv1Y3sKwMW824qXn77KYtLPtYUKtNY3K04OiXW6lcYStKde5OPQqRzvNVLRKoIVuOqLUIjYSdhHCC81R+rewqN6sd3oCMyPrMdl+FJToGnLe0XFVO/S0REtEL5tpCkFFL1DC+Z0anS0HP0oh3xqCuT6FTDUotriXRZ5b/nXyivyAsqyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <quirin.gylstorff@siemens.com>, <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Replacing BBB kernel config: Status and AIs
Thread-Topic: [cip-dev] Replacing BBB kernel config: Status and AIs
Thread-Index: AdfhKw+c+9rAP2YhT6mWMn+3wpW1ewABEr2AAADaN1A=
Date: Wed, 24 Nov 2021 13:02:01 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYCPR01MB84234222EC358E4F72483333E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB84234CF202EC19BCBE72D233E1619@TYCPR01MB8423.jpnprd01.prod.outlook.com>
 <63eb7f13-cf72-bd5c-e62e-f0fe2d773c67@siemens.com>
In-Reply-To: <63eb7f13-cf72-bd5c-e62e-f0fe2d773c67@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6966e3d9-75df-485c-9d7a-08d9af4a9b79
x-ms-traffictypediagnostic: TYWPR01MB8283:
x-microsoft-antispam-prvs: 
 <TYWPR01MB8283939BE24A396396599CDEE1619@TYWPR01MB8283.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 N19iG5yphQcM5JXf7Jcuxaj5tbnCwXbxzg8vR177wIIUhknBB7NFMfc+5X2u7mlOkoNArJ5PNa2HG0xNO+8Ab05Zsyby6kWgzqInOzX3P5d4Ae9GPDHUzBF2t4PENvuY9XF9SmOi/xJ/svit8Z3EGk6VpuF0H3smsouwOJQcmReNbG2iBijYgiQ2tpdTWSHs5GxY7RZt+Y7A58U+fNNQemUbPSi6PKY5fdFwmE7LbI+1aXW0ieBcZ+8clmcdXASirkyeo5AZhzrrnE7jK9QJH+W/lD0TzDqR6z/8RKvoPPDL+iuFyIf2B37+ucta4OJex1vS63KA9asRMQNHwEBbIfQBP2X97rT+l07ICYnIQuDCpH7O554okhqtp0kmHsyPeE+BmofYodzqlnbd/7bdKroBLIcSHWrYL0frk1TYdAf5cNraO//izGs9SgS0cFFAKlveiDu9I4SJFWC5Z1YPqIvN0Bfv5/+RiR8+o88KqRo5p6BltHUvsvT6QmkMKlGDUzkweD60MAAvDEYpBUJpOUKKCdYb9i3iXQOVfpTgu668O3GGybgGH1NmM3TnbnSukN2Upll6dS+fy5JfvoZwvVJhMd6v2KZt2OmLCaPbgUkSmZhyTznogmfBZ5fHPiqVLa416xSEcKqG/+dwjBT3rW80K1GfyuZXgo6/FO6z3Hy4Qg6qFbAbP3VwCqvFew+icoYNXKz9914cKxhNe18rGlNcwmO3vJzS2YyyvXp7RQ5rVXuCQ6T5fI/jKEGpQXVyHrALBpj4Ct3xDwoEDX2FxsEdD3aUGxJYdTwrsA/2Zjg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8423.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(26005)(38070700005)(966005)(8936002)(9686003)(8676002)(33656002)(55016003)(6506007)(316002)(76116006)(71200400001)(508600001)(110136005)(2906002)(122000001)(38100700002)(5660300002)(66946007)(66476007)(66556008)(4744005)(52536014)(7696005)(66446008)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NXhkNFkwaVdWNDQrdDBUUDd1dW5qOEhsb0Fqc3lISXEwY3hpZzhJaWZz?=
 =?iso-2022-jp?B?QnN4QXJ5aXlCT1pCWk9KZFVIV2lGVE52b2V6UnlRUWRaR1FCdFJLU3J2?=
 =?iso-2022-jp?B?MGtTY3M5VFRkcUhTVWJoZEhmSmU1ZXMzQ25CWDRaYzZKei9pRU1XK2JF?=
 =?iso-2022-jp?B?azdvOGdiMWMyUzBJZU1zQXRaa0l5WGpiSDJoRldHWWdTcityNDJHdEdy?=
 =?iso-2022-jp?B?NFA0UUM4S2xuTFlZQUIrc0JKNjE2VEg1Wk80STZETWppNHdPaVBLcWJY?=
 =?iso-2022-jp?B?aStsa1BaS0ZBRHN0Y2pjeG5Ydi9vSWxVODRheTdYZDkwUUR6ZjFTOTZX?=
 =?iso-2022-jp?B?ZlFxKzhscGxlY0FyMXJhdStCQlptZExja09ISS94bE5yVk54TjBFN3A5?=
 =?iso-2022-jp?B?bjQ5cmxtN0M4Ym9zUDVheE9GNUZWcmpJTTVHei9LclpObWRGelBwL3Fm?=
 =?iso-2022-jp?B?M3lpNFJCWFVub2dBZDloYldXMHNGeWVGK2NDcTFyZi9YZEY1NDNJaTVN?=
 =?iso-2022-jp?B?Z1JHbkc2UTNKWnMzYitxek0yRDIrY2VCb0VMUmEvbVVRSjUvb0YzaW1B?=
 =?iso-2022-jp?B?cXVCa21NUkVtSGZhYUZwWitXSERraXhoYk5jSlR6K1ZueURGMEkrRnhC?=
 =?iso-2022-jp?B?T1Q3bGVYR3IxdVBGOW9JTU1hMFlUcXJUZE5Db0ZuNnk0WlZDVkZkbnNu?=
 =?iso-2022-jp?B?UmhFZGdTL1B6V2k4V2FqODl3dDJYWHhFWG52R1gxSmRERXhTT3Jpd3Bz?=
 =?iso-2022-jp?B?ZENtUXJ2V29UdTB2Q054OGl1aUVkbDBZek9OdWJKQVFweTBPaklCN1Mv?=
 =?iso-2022-jp?B?REwwRGtnUXh0aXNROWlxTUdCc1grRGRSZzVqNXI0UDZrRXhhTExrN2w1?=
 =?iso-2022-jp?B?NmE1QStUeTUxWWZNaUNZaWNDamlMSXdOYm5LUlVQWHRWM3M5a2tDVUNi?=
 =?iso-2022-jp?B?WS8wTHRBeVJ3ZkozZ2U0VEljSUVkSngzWXhUclBOeHhkOWdyTTJpSHIz?=
 =?iso-2022-jp?B?dTZxUHBUYVVQbEYxaEwwMlJsV3pqOHlyeXlpSjNqRE92MVlpRTlyVkl1?=
 =?iso-2022-jp?B?OTZYWWRvS0VhMWxGS2RHVTNvaXVoLzdFT3dlVllDM0Q1TUpMWE1LVm56?=
 =?iso-2022-jp?B?VHB3bWlmb1FFaWpOd3B6cTFLeUhySXZ0ZHZ0MjVhTWZUaFhkajZCbWJv?=
 =?iso-2022-jp?B?S2RXK1gvREZOTUlWRGJHdkNxb0Y3YW1Hd2JYR1dDYll0bEc4NDN0OVhv?=
 =?iso-2022-jp?B?cFluRGlBZUhIVnlvV2ZITE01WnFpT0VhdkR4OE5HWkczcVJXN3Z6N2I0?=
 =?iso-2022-jp?B?T2MzWExqQnc2TDF4bk4rRStISVJPRFl2UHJIR3B2S1BJU1Y2WWdzbDFP?=
 =?iso-2022-jp?B?RWRSZnVFWkM5Z3Rob01OUC9EbjY1VS9tYXpWUW8zOHZCOHhiRkpPYjly?=
 =?iso-2022-jp?B?MnNSaDMyVEFpQ2tkUnRiTnkwL3dvdmZwK2hIbWQzTkVmcXA3aGZma1dp?=
 =?iso-2022-jp?B?UFFDQURkMVdGbEMxSTlyWDlNUHoxemtEb2hTZTloQ2t2ZXVSOHZGdjhW?=
 =?iso-2022-jp?B?dFdIaGZicWFLYkFiTC8wajVnT2FhU3FTdUQ0SGxXUkhDVmVtMnl5bldS?=
 =?iso-2022-jp?B?dTZzRGs5VlNXNDZKVXY3anNNaitHMWZmckk0NkR4TWpvQUo3ZlFWVE1N?=
 =?iso-2022-jp?B?Qjc5Q0FEdmpHUlNOeFY0UUs4aUdPS1lsam5sNWdzWmF2WW1wMHpLZmZi?=
 =?iso-2022-jp?B?MVJIYkJvVEFjdmZyUnZQNnAwWkd3WXVNbHFjRTZLZE11alhodFJUQS9m?=
 =?iso-2022-jp?B?NU9rVFVqRFQ0QmUvMkdSVkxBVDZNR2t5Q2dNQktydVFEOGJwSTVDSXNC?=
 =?iso-2022-jp?B?NUNJa0dva3RCMGt4bnRGOTBkOUd1NmxndE84UHQxVjRidzZscnQ3VFln?=
 =?iso-2022-jp?B?V3RDdXZhMmRaNzNQRUx2OHBvSEtrMjdjemhzVk1UZ3VwUFRDYzFMaDFX?=
 =?iso-2022-jp?B?N3JLSFQyRmdXT1ZRMThoYVlKTU1HUjhxQTdQUS9FRVoyWG9RQllud1Bx?=
 =?iso-2022-jp?B?dWNGYmdIYlM0M0JqL2JWZWg0bFdkZEdUMEtHSGJLUkllRHRmajREbysv?=
 =?iso-2022-jp?B?VC9td2Fkdlo0L0V4a2VOQ3N4STlpWkRCZVBYWGxLVW1MckRKOVd0LzhW?=
 =?iso-2022-jp?B?YlJkOEZqdUh5WW5qNzNIdGVEOTV6alJwT0Q2QUFVaDB0MHRKVmNJemt5?=
 =?iso-2022-jp?B?YW84OUU0a3M5Z3BvMlFMdllHam9tTHBnRDhuL3JhZ2FaclhNY1RnRVlT?=
 =?iso-2022-jp?B?d1ZGQ0pJYUZVcTllWjlQVldlT3VvRGdZR1NDNUE2a2dJQjNhTkhCc2E1?=
 =?iso-2022-jp?B?TVY3OC9CeCtvRWdNbm1qV2cyM21ySmVNbU9jTDBvZUtudG9DUXRKUUVw?=
 =?iso-2022-jp?B?UnJhS1JRPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8423.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6966e3d9-75df-485c-9d7a-08d9af4a9b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 13:02:01.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 1T9aizYrzYl6nbmSTmMYWKDGPn/nlUXhU/pJyuCRiOhPzi2AhwrSF/P6U6qp8JnpLNxUNUe59kTGJewfqatjuwBajp/EOSGTMhFbDzYkr48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8283
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Nov 2021 13:02:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6998

Hi Quirin,

[...]
>=20
> Sorry, v2 was lying around at [1].
>=20
>=20
> [1]:
> https://gitlab.com/Quirin.Gy/cip-kernel-config/-/tree/feature/bbb-isar-co=
nfig

OK, thanks for creating these patches!

>=20
> Testing is missing.

Toshiba members can test them using our BBB.
Please let me know if you already have the steps to testing.

Best regards,
Kazu

>=20
> >
> > Best regards,
> > Kazu
>=20
> Quirin


