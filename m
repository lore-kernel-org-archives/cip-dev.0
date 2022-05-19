Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E0C433EF
	for <webhook@archiver.kernel.org>; Thu, 19 May 2022 02:07:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.2781.1652926052095923026
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 May 2022 19:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 24J27TIm016244;
 Thu, 19 May 2022 11:07:29 +0900
X-Iguazu-Qid: 2wHHdmOs2qFYUQ57bv
X-Iguazu-QSIG: v=2; s=0; t=1652926048; q=2wHHdmOs2qFYUQ57bv;
 m=0QTLSozcOqaEMZvHhk6ZvPGakRmT5EY6i8WvIDiU4nM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 24J27RKm002900
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 May 2022 11:07:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5/d5kSzqnthLexGlYaICB2mhqgPGtlk7IdKAYQiqN8VdnhEqa5oXDNx5yXYmqsKb/h/E88BSzuvJvATYNz7Ss6sBABr7W3GmqvVMsjcj6hydf3k/KPRm+Pd6V5zyxjnxVjNaoFHZn/Aum+XCAn3z4Fvp49kyUU4upZJjioX89Je1ibzM+J2dCJebYEpSohgP9Ij/lGQmpyB5Km1nznRuAGnbe6Uvs8fMj8vRAnKlOnIIiz6U9QqvbW56VSs6/IzBXPYZBjNkm+y2wVi4UZzAqut/86+MBH50rEHcqFPiQ6/kKmvJ0EIfr7C/jFZhnk87j3XorvpHqlkcMEXet+IOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKuM+gCbwyUdVAlaByu2TQb/D9s5qDixx+r0XRMGjxo=;
 b=QN8YDKi7yBrR//4TRmkX93+4FDm05dos8WtbeZzyEqk5CzEPOMW+0bm1/BBKt5PkEgNkgmpPRGBZ49b9hqtKjRCFm2dD3XdLSmAFrL6q4V4L/ijoE7361dwI1ZOLZS7iwbQUE9EBHAdl33XbdZ/o0BTqTV9MCXq0WFZ+6Eu9yAqLUQ+wnufHW1k9yKjFXzI45T86qDapahb2Qp3NDpZA7aJWXfeN//42EuY4miQDf6XcNsjIdAnEE0fkixzPeJmqyK7zqJX7H9H4PBzas5MNH4JXGKFAEcQh5nE2JsA9Y4dqay9L/7kGLcfF/CMUFgE8/MdFhYihyOso6fYRi67F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <iwamatsu@nigauri.org>
Subject: RE: [cip-dev] linux-4.4.y-cip-rebase: patches in wrong order?
Thread-Topic: [cip-dev] linux-4.4.y-cip-rebase: patches in wrong order?
Thread-Index: AQHYYHf+3l9MiSHYWUeqHuDTVhgMKq0lX5HAgAApcnA=
Date: Thu, 19 May 2022 02:07:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94205E69C898552305BA8C7E92D09@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220505120120.GA4543@duo.ucw.cz>
 <TYWPR01MB94206F854C936F554C2F490592D19@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB94206F854C936F554C2F490592D19@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cee0a54-ee41-48cf-0206-08da393c5147
x-ms-traffictypediagnostic: TYCPR01MB9751:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB9751643EB39BE5460B38BCF292D09@TYCPR01MB9751.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 86mbI1Z4g7xmPq6gLLz5x5qJ8Dx8WJWLPrvbC60HqYqsqyL606b9W/kXg6bMmbZbHGyd+2omh/GXU+eDTGdijgppSRYYohHLsAwa3JnEP9EYYQ9oWOPZtI2BjZq59PFXEKcKRTTjv86GI1WCijO0jyXArw+pGgQbvbTEaxbwezaY9nadd6sVJ152NOyGW2o5D2JPe75n+p+RIpdSSFDDtiG5hShqr+REa0CzDkoZKAApJH7GySJbKXTTOzGa6v6UphvK/qqGJVIYtX8bV808704QpBwAOnDBf4QAf53RtBNG09AXBXmFyS232GBffmTzvQ3yd9O1+Q883eJiz8JwZ2O7ZiwWRzneG+CBys8JBArOoyZlQxaNy1Dxh07atV5IB9DUfvGlhSWpzLiiDMJ0Udvm7JeisgePWmOyFcbGMSHOzP7j+DZlH34xMGB/OCosCvXuRQtohSNp0EbY7wwRmrcS+OSSuLae+TFWCYcH7mqf+kKzp+6Xe+kofff6Cmov11VEsSD8GQg3HJwwq4gm5f/H6a65qrZD3ODQ9oaLZOwqvJ7KKvuBXjcOk23iY2zBN2gWmQ0S0K7Gy14y3qXmA7mDh8U9UwIwmj9X6r9zF0Q0AHsI30Ix3QOyV7OdLmjHArH/iNKYEqVND3VpbcDXBOijjXniE3IAXe8aZ9dtV72usE2Dynd2MV5Gr845Iziqo+lzxiBykGbOQWkC7zu/gw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(7696005)(53546011)(6506007)(26005)(66446008)(66946007)(66556008)(66476007)(64756008)(76116006)(316002)(110136005)(186003)(122000001)(508600001)(8936002)(52536014)(38100700002)(33656002)(71200400001)(83380400001)(86362001)(38070700005)(5660300002)(8676002)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NXRROHBhcVluOWlHZzhWQkhTNFRLWndEd2ZUbFBqdkE5dzBBUktkQ01i?=
 =?iso-2022-jp?B?MktHdFJPODE3UzlOQzY2aW1rV29UQ2p0NndjR0ZKNXN2bFRWa0ZOZGNV?=
 =?iso-2022-jp?B?VG1aMGl0SnlybTJnM0RXZ2NRZ0swVDd3VnorZXhWbFMzRGFidTFZMlI1?=
 =?iso-2022-jp?B?SGZjS0p4NDFVY0lNQm1jbjhxTVhaSjVkbGdScDFnTEgxSjBGNk4xcURX?=
 =?iso-2022-jp?B?UUZjNGZuUEhKeEhXeHlMWTlEQXl4ZXYrWVBKQlJBK3BBSUt2ZlMwTmZn?=
 =?iso-2022-jp?B?Z2NVcnAzeWgxa3doYjFxc05ZaS9QN2lLYVI5SVVjMWJpTnJjL2wwcSs2?=
 =?iso-2022-jp?B?eDNaTW5STXYrbFdQWDdFcUVZYjZpcWk3aE5zRzkzU0FpRDBqSnlFZnh5?=
 =?iso-2022-jp?B?SGlXL1RhNVloQlNPOWx5TVVlNG1FSkdOSGNRV2pNYmlIVVNOWVFMM0ZR?=
 =?iso-2022-jp?B?Ly9aSDhEU0ZMSmxqNGVIS1ByMHFHY0dSU1lYR3AybzVESnNGSVMzbTU5?=
 =?iso-2022-jp?B?V2JNbVFHenFmcWUxWllDSVRpcHpUVjdyYWwyNUZ0S09UMFZ6eDNBdXdV?=
 =?iso-2022-jp?B?bXo3MW9ZU2k3SEFuYWE2NWxzdGhxVUtLQ2E1TnR1aDVha0Z1bUhCQTgv?=
 =?iso-2022-jp?B?MzVqeWVzclgwZlVPZW9xQXRzNC9hUDIvZjBrVkdpWGIwOTFLaUVEai9j?=
 =?iso-2022-jp?B?c1FxaUZBNC9lRlZTR2NYalRLR29lL3k0QU1LMXZtd3lHQ3ZaVWovZjVv?=
 =?iso-2022-jp?B?eVlDakFrNFR0TERCeWZZUWdTSVJqV3ErbE4weG9LUUdSTUhaNnpYRExP?=
 =?iso-2022-jp?B?RDJTekNId29lamdGM0p4RkwxSkpnbERaRzU5c2xyYmEvN1BuT1NLMTVX?=
 =?iso-2022-jp?B?VG5hUUhwNVc0UjJhTHhXdXVkTDdoQ1U1NjhzK0lHZXQ2YkJYMGFtbWx2?=
 =?iso-2022-jp?B?WHlJWXowN1M3ZzErM0NzaVAxejZ2R0UvTVJ0MHZGcHV5aGZXbk40bVNS?=
 =?iso-2022-jp?B?T0hDYnN4TUdhOVJkMDRzQmtlTFg4OEJadS94eUtTaFRaSTU3bGFEem1N?=
 =?iso-2022-jp?B?b2NjcHg5b1VYUHdCWExyN3kxV3FzSFNGcGoySW5IYTdzRmR3aVBFdWRN?=
 =?iso-2022-jp?B?VjJVZW9YcWJMaDJlTlFFejBVSjZsaytzcVFoT2JlTVQ2M1dPRm5VUzlM?=
 =?iso-2022-jp?B?L2dpYWxudGJlV3RtbGVCenNBU3N6TW9KMmJFeEtRMTdPY1MvS0dpR3R3?=
 =?iso-2022-jp?B?WVZDL3d1S3lWaWI1Q051RHlCYVUyQ2JWNE15SDlkUDRsdnhzUDNCa2hy?=
 =?iso-2022-jp?B?N2dUb3p6ektOWDVRV2JHNm95OW5pT0RFeTNQekd4OW5VbVdRNkRyNjBN?=
 =?iso-2022-jp?B?KzJqTm5CdU9LNkREOWtmRjJRSlVJdkFjTGtyaTg2NW5tZVRFT3RPcnBl?=
 =?iso-2022-jp?B?WVhKeUZkRHBXRkF5YmRUZFp4cjVHVFgrRkwrNGFCR1ZWbnZsS1hhTnNS?=
 =?iso-2022-jp?B?NERoSEcyM3VHZnErS1NVVDdNMDVKaWx4aDVRVkhJRHgvcjFwZnNHK2cy?=
 =?iso-2022-jp?B?c09hUEoyMlNTNkdoR2tXUjBwR0RxVm9oSXR6WCtWTTgzZVZFeHhDenFO?=
 =?iso-2022-jp?B?MWc1OUcrdXRxQTRHL00zMUhtREl6U0RXNEhKblVJU25taHdDcFlzU0dE?=
 =?iso-2022-jp?B?RTcwR09ndDl5T1ZEYmU2aTJ2MHUwYmdnSHEzQWlXbjlnTjVrSVBuYlpT?=
 =?iso-2022-jp?B?a0M4TjEyVG9JM0VNM0hUVG9NNjQ5ZWtuaFBaR2loRUYrUW9ES21DdE1i?=
 =?iso-2022-jp?B?d1Fyc2VLb0tHM0JNUnlnazlZVmhFQmpCMTBLbG9CcDNaMUFYeXB3YUM4?=
 =?iso-2022-jp?B?MTJBZG4rbjVKQTJPbEtWeFRMcmFlYmExVDhOc0FDTC9iVFRUVmFVTVZC?=
 =?iso-2022-jp?B?d2FJK3BRcXFJc3lSUFZoUUVZYms2eWtZWjd3ZllWUFFYZlhib0dZSm9U?=
 =?iso-2022-jp?B?VUZLTHJac09TUFFHVWs5RDlFbXNCdytpb0FRMzl1UHc2dzhsU1p0WGpX?=
 =?iso-2022-jp?B?WXhtY2N2bnkxWHFqY0tpeTd0d3V0bGw3YVVaV1ZlZGgxS3gvUG9tdHlY?=
 =?iso-2022-jp?B?WVlLK0d1bkUxeUFua3dyOUVpV1lnN3hoK3pkL1lsYnAvdUJMbGxBd1Vi?=
 =?iso-2022-jp?B?MEhOdGoycGtkdjlGcHpjSmpCMzR2N3ZDREtscjd3ZlhqQkNvNjdZR2dt?=
 =?iso-2022-jp?B?bmsrK2Q1RExoUTV5RndpeEJkdFNGaHdPdWtpUEVBcVFrNmxmSUNPdHNl?=
 =?iso-2022-jp?B?bWFYaVRpSVJkODQxYW9rbzNFeTBZMzFLcnRkOFB3dTdtUVYwUUxtbGRD?=
 =?iso-2022-jp?B?WllOUjM3MFlrTk04TXNJSTRidDNEMlZzSlpHRnFZVnlRQ2g4L2w1UHll?=
 =?iso-2022-jp?B?bHVLYXZkZVRhYTY2cFpWaTZaZUU1ZnV5bldxV1JNWTlFVkFwZnU0NkZG?=
 =?iso-2022-jp?B?QTNXQ1JEMks3NUxmdmo4NUdhVktKUTZ2OHQwRzZvVDFib0JIYysycDNW?=
 =?iso-2022-jp?B?a2tveStFR3N2V0JLbld4a0pmdCtNQ3NFSGJFZA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9cee0a54-ee41-48cf-0206-08da393c5147
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 02:07:25.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 hG211DjW/vFMOEkiLKKZcWvlb+p6MVPRhbmgaBosBbU0gJ8RejvuZfVgtLX6ruz9vSHIZ8NLbw1YXFgqj+yhwlGvkD3N0aAGpL6eeb+m506XssRlrDKVhafWbuRn4cAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9751
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 May 2022 02:07:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8412

Hi,

> > This was unexpected for me, may be unexpected for our users, and would
> > make -cip-rt release different to previous ones. COuld we get order of
> > patches be
> >
> > git log:
> > [CIP patches]
> > [-st patches]
> > [Greg's stable tree]
> > [Linus tree]
>=20
> Indeed.
> I will revert to the commit order above, and force-push.

I updated linux-4.4.y-cip-rebases branch and v4.4.302-cip69-rebase.

Best regards,
  Nobuhiro



> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> Sent: Thursday, May 19, 2022 8:40 AM
> To: cip-dev@lists.cip-project.org; iwamatsu@nigauri.org
> Subject: RE: [cip-dev] linux-4.4.y-cip-rebase: patches in wrong order?
>=20
> Hi Pavel,
>=20
> Sorry, reply was late.
>=20
> >
> > In previous linux-4.4.y-cip-rebases, order of patches was:
> >
> > git log:
> > [CIP patches]
> > [Greg's stable tree]
> > [Linus tree]
> >
> > With start of self-maintainance, we now have:
> >
> > git log:
> > [-st patches]
> > [CIP patches]
> > [Greg's stable tree]
> > [Linus tree]
> >
> > This was unexpected for me, may be unexpected for our users, and would
> > make -cip-rt release different to previous ones. COuld we get order of
> > patches be
> >
> > git log:
> > [CIP patches]
> > [-st patches]
> > [Greg's stable tree]
> > [Linus tree]
>=20
> Indeed.
> I will revert to the commit order above, and force-push.
>=20
> Best regards,
>   Nobuhiro


