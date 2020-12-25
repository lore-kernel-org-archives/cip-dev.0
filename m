Return-Path: <SRS0=ymmE=F5=lists.cip-project.org=bounce+64572+5976+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6398FC433E0
	for <cip-dev@archiver.kernel.org>; Fri, 25 Dec 2020 06:36:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AECE23129
	for <cip-dev@archiver.kernel.org>; Fri, 25 Dec 2020 06:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AECE23129
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5976+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JOVSYY4521723xM3cqAu3hoJ; Thu, 24 Dec 2020 22:36:17 -0800
X-Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com [67.219.250.113])
 by mx.groups.io with SMTP id smtpd.web12.7737.1608878176794648197
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Dec 2020 22:36:17 -0800
X-Received: from [100.112.132.72] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-2.bemta.az-b.us-west-2.aws.symcld.net id 76/1A-28581-E5885EF5; Fri, 25 Dec 2020 06:36:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRWlGSWpSXmKPExsXSOvGJpW5cx9N
  4gwvTOS1arh1ms2iY+YfN4tbLdmaLn4fOMzmweGx4tJrVo3nlGnaPCy/vsgcwR7Fm5iXlVySw
  Znyb0MFaMEO44vynvUwNjA8Euhi5OIQEFjFK/P+xmaWLkRPIqZX4+WUNC0RiCaPEp7eH2CGcR
  4wSnyd+R3C29RyAKnvLKLF3zQRWEIdRYCmzxLRZP5ghnGMsEldvPoXKbGaUOLT1JStEzwImib
  3/drF1MXIAOfcZJY66g6xnE8iVuHLuIzuILSJQIDHn6zmws5gFpjBKTN2VAGILC6hIzJ3VyNj
  FyA5UoyrRLwlRbSWxf/1rJhCbBSh6b/dhZgjbSOLpyo+sIDavQIzE8afX2SAu6GGUaN/4EmwV
  p4C1xIq5D8GKGAVkJSbvamSCWCsucWnyIjYQW0JAQGLJnvPMELaoxMvH/6D+msUocf/CdRaIh
  LLE53W3oGxZiUvzuxkhbF+Jk/M3MEHYWhLvVm1lBXldQiBb4vSP2AmMJrOQrIOw9SX2TDzFAm
  FrSyxb+Jp5FtgPghInZz5hWcDIsorRPKkoMz2jJDcxM0fX0MBA19DQSNfQ2ETX0lIvsUo3Sa+
  0WLc8tbhE10gvsbxYr7gyNzknRS8vtWQTIzAlpRS0Je9gbHzzQe8QoyQHk5Iob3vI03ghvqT8
  lMqMxOKM+KLSnNTiQ4wyHBxKErx7W4FygkWp6akVaZk5wPQIk5bg4FES4f3cBpTmLS5IzC3OT
  IdInWJ05Zjwcu4iZo41jUuA5JKNILL1+6+NzBy9IFKIJS8/L1VKnFe5HahZAKQ5ozQPbjQstV
  9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx7BeQEnsy8ErgLXgEdxwR03InGxyDHlSQipKQ
  amLS19II8Vzhf52QuFUh045XLDo3c2rLlj/pc/ysGT1WidS7ouRQy/2JtPP/mkVdmPfsmg//r
  XB7/1udmrXk2lX1SLOexlv3qb20OXOmKPsQQ0W26/oHzR+YZbSVfunPTZWeLTZ/96eTiaveem
  5VNfpaL9Lr9ljw7Nbnrwepdik/cH7PKi7Yc0Y6yyy7qKrgbsPaResgtqxj7mhMt2245c7gnVU
  j5G7CWMH4yOOfM++BbKK+E0e3s1861qzgcjSMDDxhfTu491GF+JO7tbKaPqqUzHr593aPX8DR
  8VZvnun/X+l8/9r/53XSOHH/BpkmSAX+lZwdlTulj8KkTyUhb9frpuicPb+rN0ezZmX5eiaU4
  I9FQi7moOBEAHaCBd2gEAAA=
X-Env-Sender: hidehiro.kawai.ez@hitachi.com
X-Msg-Ref: server-13.tower-345.messagelabs.com!1608878171!377999!1
X-Originating-IP: [133.145.228.57]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
X-Received: (qmail 20308 invoked from network); 25 Dec 2020 06:36:13 -0000
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) (133.145.228.57)
  by server-13.tower-345.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 25 Dec 2020 06:36:13 -0000
X-Received: from mlsv8.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 99BF13C0035;
	Fri, 25 Dec 2020 15:36:11 +0900 (JST)
X-Received: from mfgw04.hitachi.co.jp by mlsv8.hitachi.co.jp (8.14.4/8.14.4) id 0BP6a8fo028414; Fri, 25 Dec 2020 15:36:11 +0900
X-Received: from GUjpTK3DCemcs33.global.hitachi.net ([158.213.250.34])
	by mfgw04.hitachi.co.jp with ESMTP
	id sghvk5vdb1SdVsghvkruSw; Fri, 25 Dec 2020 15:36:11 +0900
X-Received: from GUjpTKHDCemcs06.global.hitachi.net (2002:9ed5:d273::9ed5:d273)
 by GUjpTK3DCemcs33.global.hitachi.net (2002:9ed5:fa22::9ed5:fa22) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Dec 2020 15:36:11 +0900
X-Received: from GUjpTKHDCemcs04.global.hitachi.net (2002:9ed5:d24d::9ed5:d24d)
 by GUjpTKHDCemcs06.global.hitachi.net (2002:9ed5:d273::9ed5:d273) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Dec 2020 15:36:10 +0900
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs04.global.hitachi.net (158.213.210.77) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Fri, 25 Dec 2020 15:36:10
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUc0xI9ofsRYDeRwcdJX8FJSKYvN8+5OFLwc4SRl0IZPCeiB/2qL4QTRjvxT7kW9p/vinjagp/YxheBodrQsvml0KXdpDI5r01zxMEg7qvkPd6dNNS068lgK2a0G1TMi5UC+lQbxfIcUn9mKAGug0VE86KVUlzUaZqPUv1P3oZDV2W2stvCs3xHv5DoipByPkZOBgadpZfIEjWxErnbu1KFVCY6TDJxUQsx208xwqUek1+6d6n29EnqlJvcOinYY5+NlNPXq9OK7wFmVbBlQqDRUg4rMBdgoUShZFXq1vEzVCXDp99a3PmOz6/76Uo31fCGQD03WATONa5iQGcQzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnpBShGmxikVHWRW0Whj6dMFlkhb0SlL9VE8ef0sbgk=;
 b=hoKHJtAh797t8xtE2msqPzVuyxDHk2RFEaegktpMThLsOOBb7h+pCTfgRcWk/2QlDlgoefLDt3IdD0jZiJUQcXx6Xsa55cOBVZkvWLH8UjDRmFTgoM5cHpeaNsc84jJhwyIXekjpwz8PSEY9WeWt+IGs/Uu8zSFnzw+CR+erVWpjU1nDfLBCwQVdl3VHUPPYUBkNfyXeFaY+ymWqD7hovbXE740Rds9YfFVuCKKeP428/doe1dYVcY0vqV6qsZK9nVAlGY7/ytT7LlD1qHXZqkI5dtSCrbaFWJbVWCIf7o1qKoIBN2CBl6KF3RsWdTlVsTQDuFHWrZ2dW9IvqgOvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com (2603:1096:404:88::15)
 by TYAPR01MB4861.jpnprd01.prod.outlook.com (2603:1096:404:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 25 Dec
 2020 06:36:10 +0000
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4171:f1d1:9c3b:47dc]) by TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4171:f1d1:9c3b:47dc%7]) with mapi id 15.20.3700.026; Fri, 25 Dec 2020
 06:36:10 +0000
From: "Hidehiro Kawai" <hidehiro.kawai.ez@hitachi.com>
To: "'masashi.kudo@cybertrust.co.jp'" <masashi.kudo@cybertrust.co.jp>,
        "'wens@csie.org'" <wens@csie.org>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtgANHIwrA=
Date: Fri, 25 Dec 2020 06:33:55 +0000
Deferred-Delivery: Fri, 25 Dec 2020 06:36:00 +0000
Message-ID: <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <16529B035A24E529.13568@lists.cip-project.org>
In-Reply-To: <16529B035A24E529.13568@lists.cip-project.org>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8475776-ab6e-4167-8317-08d8a89f5de7
x-ms-traffictypediagnostic: TYAPR01MB4861:
x-microsoft-antispam-prvs: <TYAPR01MB4861F2D3D5A9D6167C8195E0B5DC0@TYAPR01MB4861.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lLCvUDV1GzrwQUsVvyn2Oe4gQ7yjhiKlizxGWdMmUIAvhn3FUPLVUzkUTckvf+DVaoCQcFdFGgWD9853PUIezuNdCDGdCYCSMnVWCLJ08OLrliOfV9w/ccbGxJ8tDiBikKsJnx0Kk7Mb3VNGLcxrcs8Vfbi5sMENgjA76nMYMZ0dVPAwSB2PFIY45dMjZO1YnAY5sk6E8K7gRI0JJZYWX7M8hHiRFKDAS9tbfz/0k3xXhAEEmIkh56P8Witp8ialdp+4w5tXpz0y7oRGj1fusAXwyF20PSe9l9vgtxmqsfVMOv7jrl1wJqOrc7BUp7K+VCEW0QWv/0CD0ydzApJKTEqzKsYnp8HRB9+k/1RBDvB/HUigGWD3z7gZKz3jZnKncIEh2Sf4OTFEveD1H15lgo+4RLDV/9OAM/1iw9n+1DwCeLgy3tYNiKb3+PNsY0N0ZQCOFs97gnSIRn7vvQaDhNgKOvpa74AAOJkCs4T45Xuesztbscuqob3mxKCA+Cc2
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?VE90cEx6a1ZvSFNsWldXbzdIcjVvS3dFREkzQW1iZ05qUTFBN3V3cGdq?=
 =?iso-2022-jp?B?Y2RwU3FIcEk3ckNWMlBuL3F5V2EyWDBnT2p4dFZnbktsRXBMOVBMVFNs?=
 =?iso-2022-jp?B?RVpKR3ZxU2RzNVgwTG5TU2x4bXlvMWVaU29PRHVhSFBibjdOeHQ0MzdY?=
 =?iso-2022-jp?B?VTMxYjJSQ3dYZEJDcDhVbUw3citLYXRXT20xN3VTUGtQZTQrcG0rRkR2?=
 =?iso-2022-jp?B?Z3hZQVM4T2NsRkdzd1JvdFJCVHd3QzhZMFlKR0lmbGFuVHRadzhjcm1H?=
 =?iso-2022-jp?B?ZGxBRU53TUZYaDA4c1BoZjJxRTB6MzV5RFh3a1hpU2xNeXk0cjVuNmFz?=
 =?iso-2022-jp?B?K1E0QkNENVh4R3Z5MFI0WCtOMlFZTHFGRFpVNGtJZmRoTGVoNXFlY2lV?=
 =?iso-2022-jp?B?TG5nRVpkeFVVd1BsZmlXMFBYSjhzS0lKcXlqY3RRWVExUFo3bWNiZFNU?=
 =?iso-2022-jp?B?RUVpWklKK1ZaRmE2OXRXbmViOXhsVTAzRms4TzU2VHRLMTdBNE5HMElH?=
 =?iso-2022-jp?B?c2xzM3lpaFVZK0tURms0eGZHNHV6RE9qbzdiQm5SU2ZxY1VLN1EvTFNk?=
 =?iso-2022-jp?B?WktONExDRm1uQXJDKzIvZ0RDWjZKN1BqcEFhNTEzRGdhZzQ4TFpkek9K?=
 =?iso-2022-jp?B?TlpkYk1PcWlaY3pQL2lhc2xWZk14N2dBTmZQVHhjQnEzQ3oxcWVlMlo3?=
 =?iso-2022-jp?B?OU5HRktxSDR4Yk5lOHlrY2JjVUVBWWdLUktkTCs2Zmd0eWZOeStHV3VC?=
 =?iso-2022-jp?B?OG5pWm9NVENzenh0bk8vWmg2YW5Ddkc4dHRwaGh6NkZuMTZnMEt1NVJK?=
 =?iso-2022-jp?B?ZGFYblk0MWV6SnBLUlgySG9XdFBrVWZsVm1xWFRRY081MVdLZEZidjdl?=
 =?iso-2022-jp?B?T1lOTDh5Zmd4d2Z3elNLYm43N0pDOCtvY3FzZGxJWEdxY2h3Z1FLNVhK?=
 =?iso-2022-jp?B?dHZhVjR1UGx5dTA4WWNRdEUrUWFxWmszOGNZM2lVNDRzRDc0M21WY0N6?=
 =?iso-2022-jp?B?aHV0a1ZMbnVTeTZ4YTVIYndZSTBzN3Bzd04rUkxQOFRmekUrMzdKaXNZ?=
 =?iso-2022-jp?B?TDJ5em4xWmhBL1Vjb1pWWWdKVitmdW5YcE5WVWhmY0VmUXcyUGhpaDZs?=
 =?iso-2022-jp?B?d3ZrTFNiaHNPbUJvMXFuZG1xK0l2ZHIxM0pSWDkraEpHNDArb0RGcnhq?=
 =?iso-2022-jp?B?QnZFNlBMb05pa2NpTGFCVlRteTF5Z0lKMXVxc0lUeDZkNHdhdjA5NDk5?=
 =?iso-2022-jp?B?akRkZ2F6Wm0xdjkvTi9XVFZLU2pTSjFMNnVEM1N0RmFvY2RiZmc3NVc2?=
 =?iso-2022-jp?B?NEZRMTYzSDVEY0E0bkd5RXZsdUovWkRKcjFCaEErMjhCTmdudGRGVXRV?=
 =?iso-2022-jp?B?ZGFtVHlQSWR5bTFNZkNkUVVvVVVmOTBWdVJNenNSQ3RkREF4UyswSnZt?=
 =?iso-2022-jp?B?cjhnS0d4M0REb2cxUVRCSQ==?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2429.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8475776-ab6e-4167-8317-08d8a89f5de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 06:36:10.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7pSmieYnHmZqkU/lUSVzeuzliOFGVoZQ/cxaQIJljQrYZdtcf92SDag78A3XDDBQ2yaF/OBWhK314edJyJiHlXvE+PCtlMbQWERkM8zHgOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4861
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FFuK7OG0vaqHC6lzpiZubxr9x4520388AA=
Content-Type: multipart/mixed; boundary="82pLW7TeJKxpQDC9ganv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608878177;
 bh=ON5tV29HmuRElRcaFgwoQkuY4NPM6mHEJHYiCaHqBgM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZHR3p0HMZDDwuql5AJHxXq9jD0DdvCPRxB45Oz+c7ocyLa+ig/B32IUr4CcEBBDf09A
 W1YtJ/6yp5v4p9yVg4WTYWn4S7oJzXUoQSP51I0Y9y5FFkI4GngRqKOsBkbBjAbrjprJW
 rhUm8hJSekdLSOBzYThYaFwROZUa6mIDYrs=

--82pLW7TeJKxpQDC9ganv
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Kudo-san and ChenYu-san,

We are sorry for the inconvenience.  The confirmation will take some time.
If you'd like to solve this issue quickly, please disable nouveau driver n=
ow.
After the confirmation, we'll send an updated defconfig.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

> From: cip-members@lists.cip-project.org <cip-members@lists.cip-project.o=
rg> On Behalf Of Hidehiro Kawai
>=20
> Hello Kudo-san and ChenYu-san,
>=20
> Thanks for reporting the issue.
> Including nouveau driver, it seems that our defconfigs have some unneede=
d drivers.  I'm confirming this with our development
> team, please wait a moment.
>=20
> Best regards,
>=20
> Hidehiro Kawai
> Hitachi, Ltd. Research & Development Group
>=20
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of masashi.kudo@cybertrust.co.jp Hi, Hitachi-team,
> >
> > Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the follow=
ing email.
> > https://clicktime.symantec.com/3Hrgtrrm6ninbLpVgrZpbS37Vc?u=3Dhttps%3A=
%2
> > F%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> > fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2F%23u
> >
> > According to the kernel team analysis, it seems that the nouveau
> > driver is enabled in hitachi_omap defconfigs for both
> > 4.4 and 4.19.
> > However, the configs are for OMAP platforms which, according to our un=
derstanding, don't have PCI for a graphics card.
> > So we think that the hitachi_omap defconfigs should be corrected to di=
sable the nouveau driver.
> >
> > We could be wrong, so please advise us. Once you confirm it to be corr=
ected, we will go ahead to change it.
> > Best regards,
> > --
> > M. Kudo
>=20
>=20
>=20


--82pLW7TeJKxpQDC9ganv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5976): https://lists.cip-project.org/g/cip-dev/message=
/5976
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--82pLW7TeJKxpQDC9ganv--
