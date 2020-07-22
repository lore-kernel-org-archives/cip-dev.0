Return-Path: <SRS0=afrj=BB=lists.cip-project.org=bounce+64572+4958+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE697C433E3
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 10:47:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E03C20771
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MhesX7cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E03C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4958+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uad2YY4521723xx7VRxiAKmn; Wed, 22 Jul 2020 03:47:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.16196.1595414819255640089
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 03:47:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 06MAkvPa001691; Wed, 22 Jul 2020 19:46:57 +0900
X-Iguazu-Qid: 2wHHmtTgnxWBXRjsgL
X-Iguazu-QSIG: v=2; s=0; t=1595414816; q=2wHHmtTgnxWBXRjsgL; m=Ljg82aCIO1TMnMI2j0kkQcAKSAxoKVmCknk/ePZbxqc=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 06MAkuMW023408;
	Wed, 22 Jul 2020 19:46:56 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06MAkujU013584
	for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2020 19:46:56 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06MAkuKg002793
	for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2020 19:46:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c881eK4DC44MhbxOfGMLAiY0sUBg9txKcmIu8RweIfQyzLTqKduBGYXeEGh8TKCA43GqnuW1iIn96CcQxVh9Yo7W5Z5iYVYkLabwAwzTeo5/iuJubBSXfuMX9cbJricvAXhDCwddkwgZdNuIWSI6shnCPI2pbXfiuY8pmoiupp297YTxrPrFSixdS3U6ylcVAPLn1v9gvAhhiK8tIypiFTOGo/IQBBiTAKhZa/gk7VKAjl+TOGiAjIk4Oo7Egg0pC2W4Mdsln0oMJWGr++JO5NYsFAc927MSMW3cZdeT2HmjgelAGyXwgepF/2ymBzRTJWqGTUnPMtlHZiOLeHduaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOIho9W2gTuYjBNhTfcp9Nd6gdU6RYvIzo3qZLgSr2M=;
 b=OsSnE7hsReCEUB+FG143BFQbZ5ZiM5XoWejPlSTroPA4m1nW0m12KYrwkhV1LxvT4UqUQUdnuplT+rVw2w4IL2GzsXwSHpQElBIqcytZ+M50nmUOxY3qwzCK9gvGqWRYAT1yWdUcYi/YHM8oPs/s95UkMRQfNPPag7b5d9JWvUEaLxRV96qxTjmv7uEL1blseBveaF+uz0fsxw8JmuUugWVqRcq1y9dmJRIDMAabPRF9u44pPzefgQqlRvDfpYGbrdLY62YLrsAosKNCs/S6r54LoK/UdLm54mjzzNVBATBJ7eKtKz2CacN5LDxRkdjEX6IaxPSVcItZUfcE9r+93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Topic: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Thread-Index: AQHWX/OmhX5UQNU+wkWK0hIB6uUEs6kTMaVigAAMAICAACgeIA==
Date: Wed, 22 Jul 2020 10:46:54 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205393EC7EF5806AF88C6D39D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
 <5cf9c07a-76a3-ab41-8d39-786876aa0c0d@siemens.com>
 <OSBPR01MB20537A054E7222BF5E1BC7E6D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <b22e4826-c624-fe98-07ee-2d6d99bf55a1@siemens.com>
In-Reply-To: <b22e4826-c624-fe98-07ee-2d6d99bf55a1@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d736f64e-ee1b-41fe-8bfc-08d82e2c8c89
x-ms-traffictypediagnostic: OSBPR01MB3911:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB39110E8F05709C7EEB03E8BED0790@OSBPR01MB3911.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 330aBboMqWH5d97V3LGl7oxOnck9nXhV8yGm7hg3JW147btXTQpszqz1CeRKxFy/dQiejy7hLi06uOMj8YFV3QXKNflbfJ7Iba69ebv11zAf+zAIihWcTrhc9U3ZOhIDrUrWwSb7p194S+vFDWNC9v+GgzAWvXVg4TO5z5IwfPNWJnnHo2mICSI2EIZry0n+fh0g4Grr3K7u7Y9quxZ/IheKwNa22mP306OkCyuWR9CY4xQ+lr1byp2e3d9JVayoFk3EHcwY2bS/Fol39KKzRwUneOfIf5ymycgAGfn9RRR3Dr6j6jxdeyox3XfJpFodmuz9zNooIIPUuhnfB8rHfd6vHinE4BqDAxeqTCe84sKGEVgIYKzhsqaG3NlSl2qFLiU2wtQOUU3yY0qlw250S0829EriWB091egRKtLaWfsMvSai+0bz2sk+/tJ88zUdzCG2Jsv37UDfiSbiHwjh2Q==
x-ms-exchange-antispam-messagedata: U2yJbJDsfBlB11y4hdEgcWVxm9j58sPhuU5UyD1m07PN4liEG8L3Ln0UrAE/AzCUmKgWdaVUjEcXTXIy8mosvgAD9JVlm5c+AF+/d3ivIs+H2Kjrfqc32EzTOj4gB87xWpJcFcizTABPa+oZcrk9IjxJLxzkxybtpDZLVUPdQF5TAh96Or2jzO8xvXBuXDKPMf8qevwL9hsuIlIO0lbfTY4OxIlrbtJrdt/hlqeZcCfZSLAh3Ja1upsl+e5Oy6nl53pzIMuPH7C54NBy0leQrL4hSb7+tlWofeSZoeo+8Lj6C0mbl46UMdt3w2o8Ch7LIf1z0TvOekv1hagtKzqhk+rwqvL8z1cFKH9rqHrNLv5MpOZdQKcEMBUP4scKE6Be5twAznwQUsZqvwxQaNek0p3ZJXhwttUX+Tf/4appkO6FCJL6paxVe1ZdnGicRBx2Jmy5kWVv4Vh6e+rLLH9gC4QfDU+3yqZhtfkwGNB+aT8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d736f64e-ee1b-41fe-8bfc-08d82e2c8c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 10:46:54.3288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQzObK4XeT2JEkL0StuPNYwaT2LWYNR6FRsKGa3+T/TOt1rb7IobAQ7TPv+C7fynpb+KzCZevBUhNPEv9HV6M1w6A+8xuBWOE6oIWOJ/RIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3911
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3s48E7QLdJNIj3unJ1ASPpatx4520388AA=
Content-Type: multipart/mixed; boundary="yIonu3LQ0zyl9RQvR1Cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595414822;
 bh=IkrluezBxlhwM8H0mPZt8MvCIWBtzlcZEQQ7E2jd51Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MhesX7cO22RDtPNruQ/QxR20EOawx35mXz88DSPFGIgCFYPhET0mM37utfVa/pwS+zy
 Gt7UJTxFaMPrJy0LK0RFPcHMG4TjnAykgaqxWE/IFobfvM+iq3Dr563UD6bI8MuLCSZVt
 RJRV1dxWT0kJeeSkn6lz/hPKzsmWnma56Pk=

--yIonu3LQ0zyl9RQvR1Cy
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka
> Sent: Wednesday, July 22, 2020 5:05 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) <daniel.sangorrin@toshiba.co.jp>; cip-dev@lists.cip-project=
.org; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B) <nobuh=
iro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt la=
yer
>=20
> On 22.07.20 09:25, daniel.sangorrin@toshiba.co.jp wrote:
> > ________________________________________
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: Wednesday, July 22, 2020 3:44 PM
> > To: cip-dev@lists.cip-project.org; sangorrin daniel(=1B$B%5%s%4%j%s=1B(=
B =1B$B%@%K%(%k=1B(B
> > =1B$B""#S#W#C"~#A#C#T=1B(B); iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=
=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B)
> > Subject: Re: [cip-dev] [isar-cip-core] tests: put all tests into a opt
> > layer
> >
> > On 21.07.20 14:42, Daniel Sangorrin wrote:
> >> having an opt-tests layer makes it easier to see what tests are
> >> installed, and allows creating images without them as well
> >
> > JAN:
> > "Having ... as well."
> >
> > Does this obsolete
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/merge_requests
> > /7,
> > where I just commented on?
> >
> > DANIEL: Maybe you can apply Iwamatsu-san merge request first, and I wil=
l prepare a new patch on top of that to avoid confusion.
>=20
> That would confuse me now: What creating a separate test image first, jus=
t to remove it again?

Sorry for the confusion.

If you apply MR7, I will move the rt-tests and stress-ng packages from the =
customization "package" to the test image.
If you instead apply MR5, I will move them to opt-testtools.yml

Or is there any special reason for rt-tests and stress-ng to be in the cust=
omization package?

Thanks,
Daniel

>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence =
Center Embedded Linux

--yIonu3LQ0zyl9RQvR1Cy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4958): https://lists.cip-project.org/g/cip-dev/message=
/4958
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--yIonu3LQ0zyl9RQvR1Cy--
