Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B40CC43334
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 23:38:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.18590.1656545928731568385
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 16:38:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 25TNcVPl030764;
 Thu, 30 Jun 2022 08:38:31 +0900
X-Iguazu-Qid: 34tKBxeAhwUCW0af6D
X-Iguazu-QSIG: v=2; s=0; t=1656545910; q=34tKBxeAhwUCW0af6D;
 m=/3EPvhLU1dx8ecGnGVHLTtXDMqn5c+Yx1hhC4If2oM8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 25TNcSBc017693
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Jun 2022 08:38:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYjXUGCR9RzQ9Q93LrQ/87bfCWLeomEXLzQ+I2RrRBdqv6d+k+3DIkD6nFjNgL3Kyn4qMHmDK+rHqFRXv0Om7xkY+eBfoZbdjUSxgQg2A0+WXy7mFGHNmaSTTTuCSrHQB4xM6kx9btrmMmx6bjYxYguwwLCKilQyoHSLVGk53h8n84qe8Jym6TISOdW8qGlHUO04wFMLDVRzTb8deRf+nNlJQDNJjm9A1UaZesm609HDYWXlEXoXN3JSx+CQXG3firTT7vLcY8F5Q+ik9xk2RYmNj7VKM0stj6brsv0aJpCygRWHJ7uBk7DSoLyQ/idJ2eXeqrh6TKuKyUsN8GZ9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0XZDCMj00po6y/PYWcDFLxEYGqpr7HrQG08eBVrJYw=;
 b=iVpE2YG+LotfaDUKKJD22SPSbuQN6Kqz4Big0P57YO5kIOf43ty/FZU2lyW+baSJLdFY0SL3ePht7Fn3Rls2UQwhXC4E06V46zmvPkfU5wD5IcRlQQ1U3TXUZhGj/iFt/oBC9HVll4MNe6hPNo1sF8A1s/4afPYNEJeNN0qEbNjvwaVecWV4Gy0r9Gbo3ps7xH2GcbwhU6xxNXcwO7CozrNxWSeH/wmjaVxnJPpdVVHISEEstXBRrnY0tih1IR6zQiECAHAb0FgAHjVFp9EQMqtNNfJgReKKq2LP0BLlquTKer0wVOj95TGZioaoeBLmUxVDcLhLF69IDLjmlqPTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <jan.kiszka@siemens.com>
CC: <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Thread-Topic: [cip-dev] [ANNOUNCE] Release v4.19.249-cip76 and v5.10.125-cip10
Thread-Index: AdiKiPp60ZAqLGCESNeH2YSchf1cRQBRkEAAABBchIA=
Date: Wed, 29 Jun 2022 23:38:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200D2B63DF4639DB76274F92BB9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420A4CEE36E4B536184CBA992B89@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <20220629154518.GA32481@duo.ucw.cz>
In-Reply-To: <20220629154518.GA32481@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f59ccf6d-a675-4e1a-ea2a-08da5a28770a
x-ms-traffictypediagnostic: OSZPR01MB9360:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I2LM1yF0GjI6LxT0XHIoqKzki+GstkERGgVY65smkz8BHHcxgnwrkV6vsNUWajg0SvoZvSgDvtGJrCdYdomIrhbvTvuUmSYZlZuvuZNA5w95pUQDnP41htaL/ZdSYWgVqK42msjVVMlMbHTY0aOHE56IcSQAYxe8+UOcsz9zompOq24999xytquUg1ASnFw8dK3wYP00Kl/6uhNdf/2WXWKxqV1r9hCp/Qw7P+8+qDf0iu5TVqOzCO2y519Cx5SKdCUejwmES16CWwEwqbZ+uJv0UGMPNYam4NMqGlb+MCJjY/QD+i30AutQ0ARhJyA6DF0zDsAH2mktvhvtrNmhnTCMFwrGKZEPpckZoQeYl563jnOUGz0UTxNmx5y43L/gDf4czUl2pEHpQzFxk4mrDiYuTWO32rz6Hf8fk4Dr3zOqwWDVuHzNVfKIvV3q+NRyQ9rWbNSGndvpmvjZXu+gk/HQcX975Y1kLWwRGqQbAmmmmAg4YNia3RTRvm+N7JL6tvGWwOdMyPtS6+og0AGluSGCLwKvTy6hsCzHkJjN3lG28B2qAUS39rHZN+6iwStYXHl1f1Pdbge6usgDpvpRAhV0MpMQXLuZvfuIvAStWviG7aUzyBVyJa4pHmHwW/rQH/iZABH34B6ySejkL5g4P272DseaNKzqNAY8BmzLdu12dg0mTluBx/adsuORvMTeKaZvIKO4pigHQHpdX56rZ6fHpf34DlYr8TUo+8RWScUaq+OlVlxVUFEQUP+CiHwUpGnTkjZ+gvnfFqvfv8qqIj0MXe1IGVzcSJTzWSbMTAt7+e75kO68/MCWkEt0uHuzw2AicfrwRPNG2i0CJ+tf3w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(478600001)(966005)(71200400001)(186003)(33656002)(41300700001)(55016003)(86362001)(316002)(8936002)(2906002)(54906003)(5660300002)(110136005)(38100700002)(7696005)(66476007)(9686003)(83380400001)(6506007)(26005)(53546011)(66446008)(64756008)(76116006)(66556008)(66946007)(4326008)(122000001)(38070700005)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aW9mQTZiVUIwZUNZbTNkNkJkUjVSdmYvUS9yTTVpSmc4ckxxU0w3bTdq?=
 =?iso-2022-jp?B?VDN0cjliN1R3Z2FLLzlvMUlibVBJYlNDL3FDTElaVVJiM2FSUFBzM1Fo?=
 =?iso-2022-jp?B?SUcwaWFobWtXckZLOXBKVllyb2lkR1AxOWlONHNST0d2QncrVXRtOGsw?=
 =?iso-2022-jp?B?dGlVSHE3aksvbElKTUJwSncyNUpwNDYya3pCbzAxeEFIcTlwSUJVWk5r?=
 =?iso-2022-jp?B?N2dOa2pJZVl6cmpIZHg5NVgyUXFjdXdBeHpKd011YzVJVkJpVzZKc1Jp?=
 =?iso-2022-jp?B?TkdDVFBCalJrSStIcGpiVHZxOVBVdy8rZUM3MzR1VU0xcFRUaGNMYUtV?=
 =?iso-2022-jp?B?VkpiTGtmZzl2TXdyTmk4UE9MOUNvelFSU3dHNXQyU1lwK2ZpdG45UEY2?=
 =?iso-2022-jp?B?aGErZmhkMnV3M21zSjl0SkFDWTl3cGtrcUNqMUdzWS84TlFGNXI2T2pj?=
 =?iso-2022-jp?B?SE90TmNIa3RiUWlZYzhBdjVLQlgyRWdpVkhWRnAzMWRZVWJ2SDdJeHla?=
 =?iso-2022-jp?B?R0t2VnpSanZLM0g1cy9BbFFCeTVtaVV4T2hJeTlqT3Yza1pqd1NtNkhj?=
 =?iso-2022-jp?B?alY5Z2tqVUc5blRtSUlnNEpDZVUwTVhSVVAyZ0J6d0Z0OWIzRndLSk4v?=
 =?iso-2022-jp?B?NFErdWpFWWN5VGE2OS9BTGpYU1RwdnB4RjNSZG9aM2N2dHZLZUdaOCsz?=
 =?iso-2022-jp?B?RTg2Nm1STm16UXVkK3hLdmVzbmQ0SWthZzFvNUVSYm1xOW5laVVvRzFC?=
 =?iso-2022-jp?B?YjR4TE5neDhSRlVsdDgzVU9qNWVTemUrUEZJbTNMQWVBdHBxcjBiOU5N?=
 =?iso-2022-jp?B?R25GK293WTdFSGJpZWZTcnVTcTA0ejdXNVRQcDJvTXJ0T1VyZXp6RjhL?=
 =?iso-2022-jp?B?Q2VCcTlndjRDVnJ3d28wVGsxOEhlcGFCTFZaT09BTFNhMHZIeGg5Tndo?=
 =?iso-2022-jp?B?TTBGcU1vS3Z5TmxITDlJVnptcjFDaHloYUFzUU1RM3BOWTNEekRueVN2?=
 =?iso-2022-jp?B?VHJuc2FHKzlxeThOcS9lbDhpK0pnUTV1Q0pKZVpwRHl2NVZkQi9HdEhE?=
 =?iso-2022-jp?B?TzNjRGh6SklPYWMxelVXMGhvN0JRT3hNbkdML0FRd2lmL0NESGRxS0ox?=
 =?iso-2022-jp?B?TkswWHFOaWRxOHRybWMvTjQrRUJXTDFhNkI4Zys4YjVRNnQzWnRhZDh5?=
 =?iso-2022-jp?B?OFFENFUzQ3UvcDF4Mk5tenZRRkZQNDNPM0ZTLzkvOUc0WldPd2k1SG1a?=
 =?iso-2022-jp?B?eTJjaVp0LzBRc0FuUEc5WUJ2UnRPR3FvY1BORDRSU0xiOWtDQ2g3QWlD?=
 =?iso-2022-jp?B?RTkrVHRQSW9VdmpMTFVxYndEa2xsb2U5RzlvZUtzeDBxb2Eya05DdTFk?=
 =?iso-2022-jp?B?NVlVOU1PbHdtYkhSWTJ5UGttenBqaDd2ZzkwUGgxbmZmdzJmd084aDBz?=
 =?iso-2022-jp?B?bnN0RjBGVEVQU2xVQVpiYTF3ZHhNRE9zS2JDRk1WT2h0S0M2VkF3MmMr?=
 =?iso-2022-jp?B?bGV4cUpoS3ZRWU9tSk8vL0paYWY5OVh1TW14NnUya2JYeUFWc0NGRlh6?=
 =?iso-2022-jp?B?R0tYaUxVZHdBLzRmdGxiRWwwTDJJUVVXZjIwRmlFZDgyaVpXYjB3N3ZK?=
 =?iso-2022-jp?B?WW95S2NOSGh1OTVXUkxvVXJHbnhqbzgwRzd6TU93cDNqaHh6dDYwRzhx?=
 =?iso-2022-jp?B?emlEaEIxek8xOEx3TnhuVzNMajFSZXk3ZDgzWGJFSFJ3LytDbno4a1hk?=
 =?iso-2022-jp?B?SGR5WTZNdU1MWFE5eW1DZlhLNnBlZGpLbkIxZy93VFk0MHZsZ1o3clEr?=
 =?iso-2022-jp?B?UXJaVkx4a0tCZ0U1ekVKK2d1dlNZbUlPcmpmdmpvNTN1VmU2dDZ5ZS8v?=
 =?iso-2022-jp?B?QUZNVUltbUZ6SWZSSU12ejhMc28yYWFFRGdWRDNkM0c5clZSd21vWEl6?=
 =?iso-2022-jp?B?ejBzZmJjbnJEaXc4Tkg4MnBad0JkZWZxWmFack1XWTI1OWZPRzVrVHo2?=
 =?iso-2022-jp?B?WklDYWhzcVg4Ty84MElBTC9DdjdEMDFRVm5GelBiTVZ2VGRyME9nRlQv?=
 =?iso-2022-jp?B?eThCcUJtd0VqbE9mZW5VcmozMUhMMTRFNDNIK2krM0tIOE16bFhNbWI4?=
 =?iso-2022-jp?B?bTQ1NGY1ZnQzdkdBMklrUUc0UGhma1UzeWY3dmplT3BES1BJQUsrK2lk?=
 =?iso-2022-jp?B?aENzQ09jKzNoZnRnZ3IzOEE5MVg5eC9QV2RkOW1rejNGSUllSktIVDA2?=
 =?iso-2022-jp?B?Nml3d3ZGRVRRL09xSG9jOWhnbEROVG9HK1JXYXVVY1A2dXN0UkpUdlhM?=
 =?iso-2022-jp?B?c2ZncUR4U3JGbVdvYUZYK01TZ252WEpqUkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f59ccf6d-a675-4e1a-ea2a-08da5a28770a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 23:38:26.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 LwvU/lcOEq++EcfXdZy2JxIg5sk6aZEuDH/c97tZg/IFwF04roXV9d9EwETlgQjyDR7flskqoVc6vhk73fbAxkAvzZ0PTRk5I0ykhXg50EqsI0c+eT2B2ssCnKynHTRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9360
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 23:38:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8629

Hi Pavel and Jan,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Thursday, June 30, 2022 12:45 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; pavel@denx.de; uli@fpond.eu;
> masami.ichikawa@cybertrust.co.jp; jan.kiszka@siemens.com;
> Chris.Paterson2@renesas.com
> Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.249-cip76 and
> v5.10.125-cip10
>=20
> Hi!
>=20
> >   v5.10.125-cip10:
> >     repository:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>=20
> 5.10.125 was immediately followed up by 5.10.126 due to bug in io_uring. =
If you
> use that functionality, you may want to speak up.
>=20

> From: Jan Kiszka <jan.kiszka@siemens.com>
> > 5.10.125 was immediately followed up by 5.10.126 due to bug in
> > io_uring. If you use that functionality, you may want to speak up.
> >
>=20
> Given that this feature is default-on in kernels, is rather easily access=
ible and
> may create "funny" results in the presence of this regression (of 5.10.12=
5), it
> feels like we should follow that update.
>

Thanks for your notification.
I will prepare to update to the latest release, 5.10.127.

Best regards,
  Nobuhiro


