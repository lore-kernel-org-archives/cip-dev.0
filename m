Return-Path: <SRS0=k87l=BG=lists.cip-project.org=bounce+64572+5015+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65CC433E1
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 02:00:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6412206F6
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 02:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ZFc3OaKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6412206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5015+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 32JMYY4521723xv10JJZ5zy7; Sun, 26 Jul 2020 19:00:03 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.46951.1595815198777139256
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2020 19:00:00 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 06R1xpMu016822; Mon, 27 Jul 2020 10:59:51 +0900
X-Iguazu-Qid: 34ts1iCWMmi09BOOS8
X-Iguazu-QSIG: v=2; s=0; t=1595815191; q=34ts1iCWMmi09BOOS8; m=1sxPSD3h/+lhmQSFqFNXJsLYwn/RqFgDPA7gw0kfJZs=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 06R1xogv006952;
	Mon, 27 Jul 2020 10:59:50 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06R1xnsF001418;
	Mon, 27 Jul 2020 10:59:49 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06R1xn1P000942;
	Mon, 27 Jul 2020 10:59:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqueC5fsluWpb4ZSo/GJh80im7CSUbYWj/jPaur/dclHzOpEEvgTQIDJdV41WSsbnJjrWlj4EC5HbIBt+lCjKFlhiqPBJuTVL99x306aUBGLlwLLYUcdK7hV/cd/EOSTiiCepT2IByww7ilx3GCfyFMOFioozdDiSghUG5S7MRO9qAs/hEpVq/ej/2XQwFIOhtl+UmeGx+VPvgxpyNr+0btIWQsLzxKKVn8akdRGtl1lVwC2WbSk7q0tBnPuwWHDlSe51wJZ+2Yo8kOzNso1+itWVLAfFsaAreVmeJKk0e3sPxzggfwnYPHW6OqBTxZ/RTWvu922CkTA2Y7rDBoVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBTSu6vIe5fV3VQZugQkQX3weFo59D6ywpO3w8Mdh5s=;
 b=kIZUuxhlCMTgXZQ5wbk/DhiDbM30ZJIhEsdd089nB+gouefmo/A0dae1eUBZ+R7ur7IspiI/Hy7vZne7EpP41VnhhMDudwwDcAnMwViu/dr6HmRVnLs6urWWL2tET6M4Laev3aoMO2S+Ao7/g04vrMUCVn6MkKcBCJ7d4Q2h31Csxamhbatl4yp+X9rS4LQkP6fF2r6XAfX9PZ4sg/ZtC2XCX+0DCM08L4ZCaNrkuWxwYCHyDsdTIzB01z0LxkKyG9Yt4IsDKWGyx+J8p8DBggr0BsHU1/9v4qtXnuYrIBmoPyWfRKWkxpVIZf5wF3vB3sPbCHuMh4Tf72QTMydRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <cip-security@lists.cip-project.org>
Subject: [cip-dev] The security of NTP
Thread-Topic: The security of NTP
Thread-Index: AdZjtVn+GEKdZ28XRvayTupQL0QETA==
Date: Mon, 27 Jul 2020 01:59:46 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053682B08257AC2230531FDD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37347de2-b9b6-4a02-8638-08d831d0bd04
x-ms-traffictypediagnostic: OSAPR01MB3058:
x-microsoft-antispam-prvs: <OSAPR01MB30582C261A47C15F7FBAC934D0720@OSAPR01MB3058.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1kS+m0dh5gnnW4MdEkdblX5SOa0xROTikExddmRSPfg7mMairr7h17rqQ5YRCJRHXMLMggJ66P9Wrr9M6rFi5jQDZPp2Jo2vZOuD+3J6uuDTenpfAGW6Ump22DaDYKmA8jJODRV1tf0TJbe7EuS+t6OigL6FHUBxLBDlpCsmy8vCnQPZthBBpG4XkpFy10QqtiIVAXoa/2nGRvx2+1N7LA7xDGWbvzrPZlb63GZEJFXd5/2CKJwOdWJmTXTYO2/4ZXNkgn0yakeq7duP73WkEzTKzU6hCKvwKUUoCWf5kvKF9jtt3ICp56R4153Qkt7SFL/3Ts2mPr2ME0ikRONfNwfheuuKYfLyvASmrg5HBfesreFoIK/hrHVB3gXL8RcxZgYRSAdKaF5Ky82DJoMUIsKtspe2TTpxrMKDwV3/8YOVJeVgbhECh2lTzqIuoIG3Vpiqjk4JZgeonA/Hg6iaAog9H2wnjthy8c1j9ytb6TE=
x-ms-exchange-antispam-messagedata: W9iGGT0GmgvYR+SCfpd9GM3twYlwKO7h2NTYhsy6bkS2m7KS/x3C/FyEpEPrC3uHGkDwB+eo99D7MJfZWgnLvX8hGmA/7CAfRtO4AzwyFC7Nm2F72Ejk/93hRnK3KWVTXDjyswqCX50z7RQo/67Rm2yWr8BCNZuoBsTmoZvXI3WOGRI+QZu0TeXaUoibjA0dq8WWv/KYXILM9wHzRidYGspV+W+2NnUkD0lcRTVQURXffN3qypqqFThDiBw9FcwXpJUWJLjy56mu354kQzjCofhoDxY6+45V+Ju0zPytdbDZe8W9XFbGdQc3s6tRPv6FQGeSIZMFiAzWCWxRBDKj2Y1fgNF3kL0nDC+gJwECnI7XCIYRwTrrMXAFuIIH567uWg6imgMwZ9wH1A4nKGqtOTyUbT+D6od5hfWI6z3b9uZBDOzUI7hTk1BkzbtoBbJv7mlSc7RVLhNQKUhCChD50/vGq4hSZiYeTUoSB7aA8pI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37347de2-b9b6-4a02-8638-08d831d0bd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 01:59:46.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjcTTKRcgsqJk9Jnezamftei1zcAncjv3/YTu6onqbailDv+ZS+PiGSPtalAjBwPHxMNvJd8j2bQ4MCdVNd6oVgo/rKvmNYcleqFRJ+LQyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3058
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AuzvWe1vffqwJwPduFytO9fxx4520388AA=
Content-Type: multipart/mixed; boundary="zVOL9rUWpvp9POBqleYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595815203;
 bh=MOmaSqmk/p2jjXojVnhsQgTR9Ey+baymIU58Pw8xfSg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZFc3OaKGSQ0b66QHCPeMz2prlTpGc2s5hW0IJ7O1XunuFhTwOcq0+JoQaBmyorVLmi5
 xgzGEhXb2ov9ZEPNqJ+Hm9BkikfaOaBBBnS7nmqtV3rlnmX9KSj7sGcPW4cgEgPFWczTK
 R55gx8oVmzqXiPgZXiDh+VwqF/r+RTpBaC4=

--zVOL9rUWpvp9POBqleYp
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,
*I renamed the subject and added cip-security to Cc

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek
> Sent: Friday, July 24, 2020 5:58 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] Resource describing the Deby workflow?
>=20
> Hi!
>=20
> > I'm almost done getting SSL working between the BBB and hawkbit. The
> > last piece of the puzzle is to get NTP working on the BBB (since I
> > need valid time to ensure that the server certificate is valid).
> > Unfortunately, I'm
>=20
> Notice that in this case SSL is not adding as much security as you think =
it does.
>=20
> SSL attempts to protect against active attackers, and those can manipulat=
e NTP easily.

In the past, I read a bit about this topic because NTP seemed to be weak ag=
ainst man-in-the-middle attacks and that could cause problems when updating=
 software:
- the device may not be able to judge correctly whether a certificate is ex=
pired or not
- the device may reject updates because it thinks they are older than the c=
urrent update (when using timestamps)

Both cases would cause the device not being updated (a freeze attack).

[Note] civil infrastructure devices may also use GPS Satellites for time sy=
nchronization, or contract private leased lines and set up their own NTP se=
rver there. Not perfect but probably there are easier ways to compromise yo=
ur device.

After some reading, I found out that NTP includes authentication support no=
wadays (symmetric keys, autokey..) but apparently nobody uses them.
https://tools.ietf.org/html/rfc5906
https://chrony.tuxfamily.org/comparison.html (check NTP authentication)

It seems there is a new standard called Network Time Security (NTS) now.
https://www.rfc-editor.org/rfc/rfc8633.html
https://weberblog.net/network-time-security-strengths-weaknesses/
https://www.infoq.com/news/2019/11/cloudflare-open-source-nts/

Also, during my investigation on software update technology I also found ou=
t that TUF (the update framework) and its child UPTANE had a separate Time =
server to limit the freeze attacks.

There was a nice presentation by Justin Cappos in Japan last year:
https://events19.linuxfoundation.org/wp-content/uploads/2018/07/Uptane-2019=
-Summer-AGL-event.pdf

Thanks,
Daniel



>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zVOL9rUWpvp9POBqleYp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5015): https://lists.cip-project.org/g/cip-dev/message=
/5015
Mute This Topic: https://lists.cip-project.org/mt/75814887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zVOL9rUWpvp9POBqleYp--
