Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C36CD128A
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 01:18:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.28381.1712193483615510603
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Apr 2024 18:18:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4341Htag1542770; Thu, 4 Apr 2024 10:17:55 +0900
X-Iguazu-Qid: 2yAaYKYb4W1G2sep3V
X-Iguazu-QSIG: v=2; s=0; t=1712193475; q=2yAaYKYb4W1G2sep3V; m=CoMoctBhjEda4k/GH27dXo89PRieG6ZHGzY8Ped8iAA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4341HssV2720505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 4 Apr 2024 10:17:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZdrDMmucgf5ApoF3N2glvTwDZRKEpcLBjG6NZ1BXen3UQhTGu3NO6yO5l6NbPr8W8uLNgW4QmaFTpWFRej0ZtU/n1Udi73JiAzkKhrFMogMnF7lSYbaT71q38YvYN+1aDsaDZuVfUM7iSCQzPMoSn2mhQAOYPTy9gyvc9AuydmwAkIpaHOkXUu8nelgkkgiHB5Kys3nLJGidKReO4eexAsZHw7I78BRgI/EXD6uJ5r7xzZ5YFKyKTCSprWzGLm8HExfHJijZfRsC/8ULoGaGOsxMRKfeI+9vciP+dPBYJi852uJjp5KLV95gRaVx9+ffEpjroBeMMo15M4RUgeTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUQhtRBwS5i/kYvEb9+VlRi1xn9mS4vuR96x1ueMZMo=;
 b=eBJSgvvjjnE+SaYDJjaFLKbGk1uWhrl80kvQStJkvZKFzKh0jSdud9gf6F/FhQXaywryYEIb4UEUSi+B6FbyRGLLo2Gmeps1IPyD7WyUjOzl2x3Ihw8uu+b8BzsTNnPFIaWGq1NsZlL3TQbLw9q6T5YymBI33UUL4Q212oN9si92K7yvqik72BwLYqWSUMkpILpCNsx8/bAuKwR2yA+ohpmywjQ+99wSoH9UvO8A+kKkazFaW80Q9bty8w0pbKyvDpT3sq7v+9nKDw3y2RlHqVOeno/FukpBOYQrmAQjizwokPGaQuQIFn8Wgt8hxFtim9DIByd65+PEP6kChzV8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>
Subject: RE: [cip-dev] 6.1.83, 5.10.214 would be useful -cip releases
Thread-Topic: [cip-dev] 6.1.83, 5.10.214 would be useful -cip releases
Thread-Index: AQHagssn1FGQ683O2UyW3WrhvbmV5rFT+O1QgAIdKQCAABlBgIABJjdA
Date: Thu, 4 Apr 2024 01:17:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388BFBF7A75C74865BD181F923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
 <OS0PR01MB6388AD7CE5977F6F9494AD05923F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <OS0PR01MB638805BF298A7488E54CFB32923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <Zg0IX1mq8NAwgsdF@duo.ucw.cz>
In-Reply-To: <Zg0IX1mq8NAwgsdF@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB8267:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SVG+qWVhjeTh0cN0rMY+AzRdLpGW1KLyTz2DIrOgAUGhMs2Q/x5CiLs1mLv3v/o582meMp/lTW05NFdYzSqGixeaCjNgI1kOPTVQ2q7d/YEpnAcrAv48lpUq2w8Ov0NVxIrSysu5Qc7zLZqkJYonjatnUnojjFqMN/C6J5Q6LPtqX+65SBzed6dYcyGh7zyuxlt8qEh/kNYHwbchTN2JC0rk9FdKtTGzze+RXYtbSFq2qY6hrOtnHKl1I5t5WvTaHIX+v8F7Kv9lHD+ZXcDg9Iighqr+J/fv1MFvT20dvDd9yjbxePs86KjkSsBkcOgAXW6diprhXQwDIMVPqitTXdwd9yuHoVWCzoze6RHVIjr25Fa7xzuAGGSwETYJXYSFRHYcLITHDN8fn+s3SJ4kRjPqMLf90YkuwrYvc7MlfXIfJ/oJqYMdCtqhpTq4lf9KJDjsOAXrfYQvTKTUH8R1fNYDicgD5TJFoX+eQ8duqGgesOjom5cLtFlnbwmwLTf6Hs5Ykda1N0MWMrIvt6NmYydgc5WLJuTyaMuwjzCCllYllswpGEzhVif6IjHNhmTIDXE8S0dO2oGOKT054eaHw38rCASb14zLoog49CwP3aYTxslDWHKkddeDfPMpq2UDuKFKIfBIaSS0mzd+BbBh5pU4QjBl/etAHeNcgan8zhCNxvuH7K2hfpFOn6ZteqLp4OI6bQaF2VwwepLZM0+Lrw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N2FhTWJtWVFwTWJDS2FndVowQXhzU1dmOFVWVFZFRmZES2NOclpuUVBn?=
 =?iso-2022-jp?B?WFVuMjdJVlhqYzNLY2RoV2NCRjFJNk80U1k1MWlZaHhiUEtsM1F5d1Zz?=
 =?iso-2022-jp?B?c1Rubm9mcThhTVlkc3hSM2UyajRLS25sY0s5NHczZlVOZ2pqd3VDQVZl?=
 =?iso-2022-jp?B?bFluV294b0FDQkdLK3dTYzV3ME9GcmhER2pscytUeVI0NDgvcmlQcmMy?=
 =?iso-2022-jp?B?Q2ludElhVXA1ejU0L0oxZnl5cWllWWlOYnduaHlKSDVpRGNaWHdIYTJr?=
 =?iso-2022-jp?B?YjlPZkExVDQrMHFLY1UzVDU3UHUzMWM0MjNLWVM5dlpkSFllcXZqR0Ir?=
 =?iso-2022-jp?B?bU0yVW9INDBGR0RiQWlSQzdwYytUckZQTUNMLzdOQ3JHTXpKRVZWTC9p?=
 =?iso-2022-jp?B?ZU8wMzRvYlY2TG94Z214YWZ3d0xlZys5aG56by9tODN1OFJXRnpWc25Z?=
 =?iso-2022-jp?B?MnJqTmVyQVZvRUc3cHZCdEgvU0IrRUIySmdqc0pMdUQ5RkxPcUVMRDFN?=
 =?iso-2022-jp?B?TUJVTEVIL0ZvQ0Z2YTUxN1Q5RVdmbU5WcEtieGNScjhFS05OUXNKbks3?=
 =?iso-2022-jp?B?Y2krMDhmZkJTSTh2L0tOaGlMbWNHZGZaYXB2dWtGWk5nSnp1azU4aUg0?=
 =?iso-2022-jp?B?Y3BkdEJQaUVvUTAvS1oyMG1oVWVBQmlxUXlNL0xodmpmZEM4YlFtQTZ4?=
 =?iso-2022-jp?B?azRERVlxOW5tSFNvdmlCVHZBQ3NXcHIzbGIvekU1NHF4MGFuUVRsYnJQ?=
 =?iso-2022-jp?B?L0FLbnZsdG5CU3A1Mmk2UVRVbWNMVlJJVVYxcGxlRUdqdlhMMDk5dWRu?=
 =?iso-2022-jp?B?STJONFhoNTdQdDRIY1N5QWxSY2ZJT21ocEdsM056WXc3Z0tMOW5pMG41?=
 =?iso-2022-jp?B?a2lTSnVNdkZncWhxZWpCbUdQUGpnb1NnMWVhcDQvS0w0dlNsWGdJc01L?=
 =?iso-2022-jp?B?ZEZMTnlCLzZRRnhXcEpkT213OWw1Z01zMnZkdnJJK25weGNaaklvbm9l?=
 =?iso-2022-jp?B?dTlhaEpsekJ2UFY4YkU0ZjlRMTFpczVIZ2ZUSXh6VTdZUmkxVmJCS1Zj?=
 =?iso-2022-jp?B?TFhGUUVEOUNBWXpaYktFMllLM1hlcTdNeHRUWXlXbWdha0Ywb1lNS0h2?=
 =?iso-2022-jp?B?L0hjTS9CbGIvdDRpUjF2TmRCemlucDl2MjZQdzVLZFRWckZYY2xaU0RT?=
 =?iso-2022-jp?B?cVo2Zm56R1M3WHQ3S08yYUZnQkdUZEVWeXlZTm9lTVAwVTNJVHIwUTVh?=
 =?iso-2022-jp?B?U1IrR2Q1b0hubHhuVE5WVjZQOUM0cVJwaThXYmFhb2l5R0RMK3QwaXpT?=
 =?iso-2022-jp?B?RWJJWkdKOFdLbG9ueFExN3hZSmxVbG8yQ2xsTERQOTdrdFVUSnNMNmxl?=
 =?iso-2022-jp?B?MGlsUXpibnBtSmw0RVh0M0l2cXo5d2wvVWFjcWh3TFJZTWdCKzVDcU5v?=
 =?iso-2022-jp?B?dHpEdWFJamVEZWc1QkU0ZStCN3JXZnBwcHkvZnVTUm5hTmtiZ1VJdWxT?=
 =?iso-2022-jp?B?d1I5SVpla2JjeGtkOGlxVXFwbHV1dVNVMVo1TGZPc3hhcFZlandYek1H?=
 =?iso-2022-jp?B?am5YeURjbi9zMVpmR2NzcWdtYnh1MXppV0hvamVUSG8wL1hjTjZjQ3cz?=
 =?iso-2022-jp?B?Q1pDZzdFQ2FQQTFxNzdUQVhrOEZsc2pEKzlpdjBWYlp1ZStiaDA3Zlho?=
 =?iso-2022-jp?B?QnR4OHRYVFdaRHBjODJ6L0NuT09RQ0crWjFtNVcvdFRrSlZaZEdwYkwv?=
 =?iso-2022-jp?B?UURlV3NGd0hMa0liZG55Z2c4alJZR0pFMmZ6TkFEb1BWblZNYktqbEFD?=
 =?iso-2022-jp?B?dXZzK3pXai9uUnhCNjFURVpwUEpNQmlCTUIyVDVRL1c0R1prd0pQeXcv?=
 =?iso-2022-jp?B?RWU5WjZneCtqTmsya2tXUyt2OWVUUFRMZ0FqUDdYdmlLTVBqMzErZFI1?=
 =?iso-2022-jp?B?M0p4dzFqTkFKc0JremNFUFhoWFltQjhWQy83alJHNUlUQitwVDRkQi9Y?=
 =?iso-2022-jp?B?Q3dBL2lnMk43RFFaWStwdGNSRHd1eEhMOStaQzJ6M2FDYkJUbmtxTENt?=
 =?iso-2022-jp?B?LzQ2N2plYzBtQ3RiTFVtbUNhZi9YVmsrRk9JeHRPM1Q5WmcvRXRzWERP?=
 =?iso-2022-jp?B?NFhweFFLcm5LN0E3V0tMb3hGUGxNRnhsdDJzeDJ3Vk1jUjVjak94Q3BK?=
 =?iso-2022-jp?B?U1RESVM5Q2x6QkhHUjhjeGdRUUlzMVZzTENrRG11OElnYU1yZXoxQ0N3?=
 =?iso-2022-jp?B?VkJreU9sNWNneGxjQ0dPN3BQQnU1Mm9PZHE4d1BORDZJc2hkTVNGbVRL?=
 =?iso-2022-jp?B?QTNYMWQzbXlpcWt4R2FLVHBsK28xc2QxWWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69596c80-bfa9-42b8-4dc6-08dc54450c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 01:17:51.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os4VQIFaydJu/LHHv3Uqs/5k49OkD3doiEd1ZHyWAC+C5zGFUi6GULAmoJyHNFMhS4DXI7nRbvsFbstu3kO/F/0FoEIx71W7Obrbx/akWJBc9F/fJR7c+QRA0IpTqZuG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8267
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 01:18:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15487

Hi  Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Wednesday, April 3, 2024 4:42 PM
> To: cip-dev@lists.cip-project.org
> Cc: pavel@denx.de
> Subject: Re: [cip-dev] 6.1.83, 5.10.214 would be useful -cip releases
>=20
> Hi!
>=20
> > > > 6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt
> > > > and 5.10.214-rt is in the pipeline, if we could get matching -cip
> > > > releases, that would be useful for me.
> >
> > 5.10.213-rt is correct?
> > https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > /commit/?h=3Dv5.10-rt
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
> v5.10.214-rt106-rc1	linux-stable-rt-5.10.214-rt106-rc1.tar.gz
> 	Luis Claudio R. Goncalves	7 days
> v5.10.213-rt105-rebase	linux-stable-rt-5.10.213-rt105-rebase.tar.gz
> 	Luis Claudio R. Goncalves	9 days
> v5.10.213-rt105	linux-stable-rt-5.10.213-rt105.tar.gz  	Luis Claudio R.
> Goncalves	9 days
>=20
> 5.10.213 will do the trick, yes. I expected v5.10.214-rt106-rc1 to be rel=
eased by
> now, I still expect it to be released "soon" so that would work, too.
>=20

Ah, I do not check v5.10-rt-next, thanks.
I will release using with .214.

Best regards,
  Nobuhiro



