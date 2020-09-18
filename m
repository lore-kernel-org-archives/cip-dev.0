Return-Path: <SRS0=f9aa=C3=lists.cip-project.org=bounce+64572+5466+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF0C43463
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 22:43:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7277221EC
	for <cip-dev@archiver.kernel.org>; Fri, 18 Sep 2020 22:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eO1KgscL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7277221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5466+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MwgfYY4521723xfRT2PZwUAc; Fri, 18 Sep 2020 15:43:40 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.104])
 by mx.groups.io with SMTP id smtpd.web11.2165.1600469017913216940
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2020 15:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw8wvR0Vk/y9+D0q+G8YTLHWxQXW2MgHxQhAUd9utfFzqGMQ5wJfldDHKI6ZcELwGS9uMgNlRCx74APgz6Wz2rjg7NDJG+wAg0D19lBTkACbwjPVwTeFkqKx4sFMAembxO5hUnMjbbq/GX71Po/Fl5/Ua6WsjXRPirW+Dqw78p8jWWv19b2sPJXKmzWbPPhr7T+iMv9qo+DRRSCc4fSuz/KLnLMUQ35g1auiI1Ckfbc4gn3XqfWTsKZGV0xCLzRs9lhjRLY/e/sppSPdmaNWuS50NF39XmmDhhxoycEyuXyucGZc6YUNf0PyurUi4VE9BFugul6Ql+KUZH5TFbcM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl3qbyfUqW10HRdPNE1jxTKLxEcoJ/MhXrl4s9g4qv4=;
 b=GpvAAXVOIzcRX648YO7hRpi4zKLtEXtrKVQkdgThcoPGczx3wEtuCiQbF1Lz5bncy1bF/aUDb/VM6vu2nynNe4WLHfG58nN5O9aRIXZR71FTEwg8ZtTIvrWkLPoWjTJ5NafuLTmX3ZqlCpK+eCnSlTzfCFsnXClVpTL5uPPwYRMY0cty+Doa8Q7N7bON8MOWpXO/1G9WLgSURlELXNX3N3HueB/otpE+6DpFcQNBUccwLnDTMXSKrbFwQ+obGJSscTg9AN/3m7fm+FGIMzAFzb6jgqCFVWvENrmEsISm1IfHFZDA5WlKy4k930OYlKtaqV8LZoX3KU8RWRWKfFyLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3785.jpnprd01.prod.outlook.com (2603:1096:404:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Fri, 18 Sep
 2020 22:43:34 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::141:efe3:1485:80fa%7]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 22:43:34 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Topic: Is CVE-2020-25284 backporting needed for 4.4-rt x86?
Thread-Index: AdaNw7es631AlWmyTOq25QxHZpRfCwAHn2aAAAqW75A=
Date: Fri, 18 Sep 2020 22:43:34 +0000
Message-ID: 
 <TY2PR01MB4972E6442E2A10765AF7EBC4A03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB49720A7CA0EC8E349A473CFFA03F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <3d774462-6c19-a68a-7101-0183c1c9467d@siemens.com>
In-Reply-To: <3d774462-6c19-a68a-7101-0183c1c9467d@siemens.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c2f14fe-5c21-41e6-57d1-08d85c2446b0
x-ms-traffictypediagnostic: TY2PR01MB3785:
x-microsoft-antispam-prvs: 
 <TY2PR01MB37851CE36072319900B6F69EA03F0@TY2PR01MB3785.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 T/hCHUwfvnUH8R5dAsflEmQEgq5inE+sH1Vw5wfzXND0Q795ZPq7TVMoW1TwgHe3mVxC4Li6fXMOtXinIGfKeSthKk0q5u2RX43cDPj2yk1skhvDlidlIpHel/ZlRzCVZIvPI7GzRmG9N54SuJySvTAsf2Y4JLv5vDD54fkNx86HSb1cszKtz6AOdRPplxAxUjgLAlUpg62UD4vghy1gFB+U2/goivEF4QEXqktGxlzn11hR2BusWzL1bezHsHJ2ufz6KEOtPsUqqTFsizijxMOfZf/+8WhvIaIkXLt/9HHzzkxwSXMPZfM0UYPPWvXRAIcARUThItfgulTKn3bY6fQkLYClXAaiDpBLgYvXQgDMaHkzsWoh2QDKvcfpNMyXJOZYDgSDbpETPu+55jtGaw==
x-ms-exchange-antispam-messagedata: 
 5TYj54GdbmYKHIAUwo0AUEoU/FIZ65wl1tv1S5XdWFZRTJa88x15ZpwS05kre+cUduIGvBoA0vjYIB4uker+EwWToW+zMNdozk3QiRbNsr5QxMreJXFSCzqhuFGU4uJeVX4pgcbwWyb0+YcGymZQOLIEjVCbADE6w2xku81kzuSkIBWe3/fovyJXS1Edn0BqjfWaWSrafLNx2P4zKdgWzX59pJzKKmtAr7ArtdKLZCGo5vLNkd6PTjPqgCco0MuvaoVH2KYOFnvs8lTNr5j/QCZZ0KqAgr9IgjtohaCfQPv8CnwKROpBNcY7RNzR45YYXHn8FC/HmTwjyD2s7L/yUTnpaKkoZAnD03ZJAvrctBxsoR5LdnIhC1Rr+/AsE92AEvO2FITWRUV9XIPxG+pUN+rGdJesEopVbINfHQchDb2DF02uhmDfjwMe/BYKdPBXV4HghhMXdSaFz5j+OwvpawNFpzpfuyVlLiPVPcx9S9ZzLkJ27vJsqRtb+7UcPoJ65T2e6iEezt4Zw3PCsNG12nH1ZuqucRdaQGj1PBJ4Ci8KXe4Dm8WeqTMNmDwpUGWR4kDGUmznbrdVItAPGAMRmg7ca0PPwCSWm4xYGCx/D4DNOKeqm+qaYfm3dioDNIIR5QafjyLkl1mJHmZVsgxOvg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2f14fe-5c21-41e6-57d1-08d85c2446b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 22:43:34.6925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFbCMehbTSLz/iin5zRbsOed9zWCZbRgS9XU0qMCu5S0E0hxp48Ncqr0MVMp5jpKvpuKk0C0NiJkpizTJc2Qi2wtye8hoCQE+i2HMs714qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3785
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Kdr8v6mODru56nf7LRorjtJ9x4520388AA=
Content-Type: multipart/mixed; boundary="E1roJKSRTComPaYM8zNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600469020;
 bh=DNVvI62K4mh+o81flaiAgkhQBwVZ0zoWjaJOXmmg+30=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=eO1KgscL1OrEpwBtVUlkLDbBxpHLaQCw3fqUYl5CC8Jsks+PAikidUZE9aj9dtWd+Bq
 ZVWvAP/aFKXyLGaKYYslIdojHfvlNrL2Auh0ZCRHszBC133jIoTgBK8X49Uc3qHkwtYWA
 m5RBzk/5JyaJG39s203AVNurWJaecCQIpnE=

--E1roJKSRTComPaYM8zNa
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Jan-san,

Thanks for your quick response!

> Is that the only config in our repo carrying rbd/ceph? The we should like=
ly drop
> that, to be clear also in the future.

When we discussed at the IRC, the config carrying rbd/ceph is only 4.4-rt x=
86.

So, I understood that the backporting is not required.=20

Best regards,
--
M. Kudo

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Saturday, September 19, 2020 2:36 AM
> To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masas=
hi.kudo@cybertrust.co.jp>;
> cip-dev@lists.cip-project.org
> Subject: Re: Is CVE-2020-25284 backporting needed for 4.4-rt x86?
>=20
> On 18.09.20 15:58, masashi.kudo@cybertrust.co.jp wrote:
> > Hi, Jan-san, Siemens team,
> >
> > There was some query to Siemens about the need of CVE-2020-25284
> backporting.
> >
> > - CVE-2020-25284 is in rbd ( Ceph block device ).
> > - it is only fixed for v4.19 and later stable kernels
> > - Siemens has this built as a module in their 4.4-rt x86 config, but
> > not their 4.19 one
> >
> > So the question from the Kernel Team is whether Siemens needs its backp=
orting
> to 4.4-rt or not.
> >
>=20
> Not to my best knowledge. This is very likely an accidental choice.
>=20
> Is that the only config in our repo carrying rbd/ceph? The we should like=
ly drop
> that, to be clear also in the future.
>=20
> Jan
>=20
> > Please take a look about the discussion at the IRC meeting yesterday.
> >
> > https://irclogs.baserock.org/meetings/cip/2020/09/cip.2020-09-17-09.00
> > .log.html
> >
> > Best regards,
> > --
> > M. Kudo
> >
>=20
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence
> Center Embedded Linux

--E1roJKSRTComPaYM8zNa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5466): https://lists.cip-project.org/g/cip-dev/message=
/5466
Mute This Topic: https://lists.cip-project.org/mt/76930681/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--E1roJKSRTComPaYM8zNa--
