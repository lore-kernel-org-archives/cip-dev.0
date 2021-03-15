Return-Path: <SRS0=wNAu=IN=lists.cip-project.org=bounce+64572+6284+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C6BC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 21:08:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB7864F0F
	for <cip-dev@archiver.kernel.org>; Mon, 15 Mar 2021 21:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB7864F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6284+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jYCaYY4521723xyQj6Z4OYE2; Mon, 15 Mar 2021 14:08:15 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.641.1615842492863631177
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Mar 2021 14:08:14 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 12FL89L3024982; Tue, 16 Mar 2021 06:08:10 +0900
X-Iguazu-Qid: 34trudpgJQ8usFjJKK
X-Iguazu-QSIG: v=2; s=0; t=1615842489; q=34trudpgJQ8usFjJKK; m=gnacerq4HfMKg+FCsdKhBvLPwuGoo7bPWjuPeItfFrQ=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1511) id 12FL88te001504
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Mar 2021 06:08:09 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id E9F3910009E
	for <cip-dev@lists.cip-project.org>; Tue, 16 Mar 2021 06:08:08 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12FL88cP031193
	for <cip-dev@lists.cip-project.org>; Tue, 16 Mar 2021 06:08:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6tKWLU7h1SFuozDxurXfXd4w/BufErQC5UEJNIZraPaotbIIA8XSWtgILtX2GKlIf1I+EVwvUZjjcGP4v8aEPrg6lRnxtsWbY3+kD18hCJ3Gy0NolTvJLU/M0Evi1ubTqpseQM0FszxQjjSvIxYi1e+m5W27GFsn9hM8B0FknmYTPl5GBTmgCeNO4QfFyW/6PXBgvHxXHrn4pWhU8y5JvW8tOQS8vwrZRjTlA8YzMZuwtNe9I6zBYOIowf5WIx9IN6ZgL1Q7/buQ1Xp2K3f2YAKFmdO6PoXNPUm0c9HlijO8DE+7fnOb6A63cw+Q5ky74DaX6UQkkcl95Bd35tN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2FBPLouDLkK4+lptTKPk8ojEe3Zlpb5uakbPSf/rdI=;
 b=ShLAclLgg3R+hbP6A0XcVUVGdMkM4K+56PnxoBG/8f1Sc5qKTdcBhbliKLcwmF1sckHu99J6DpSZ3yFRzIwGHlw0ueo52jia5b8JXFbOwXG9gjCbxe5eSHtABBPBxzOFLkxzKii6Fw6cNEf2vexOZ84e2rwlWeeyuPfJXgpfcpdZnCStghptdSZjlTauSgoJ0MCZjW3d3wBRIkxb433+vS10jy1LSoeI2rZ9z6CHOf1eSY/qJlOhUShurjr9HxQF4mpXPKzQxYkoZkjh1NOYqM5xsmOlx0aYo6d/YS0Iyh9CsDpL7akzcKufdW+FYzDNZLfuMJApALD2/1gytNXWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP kernel release delayed
Thread-Topic: CIP kernel release delayed
Thread-Index: AdcZ30rmCF8G3MqFRVu5PsqAniOjgA==
Date: Mon, 15 Mar 2021 21:08:06 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298370833E6B71F34B37CEDC926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b15f7eb1-76e7-4ed0-e2f9-08d8e7f66e2e
x-ms-traffictypediagnostic: OSAPR01MB1553:
x-microsoft-antispam-prvs: <OSAPR01MB1553043F3F11778A3E1DBFE2926C9@OSAPR01MB1553.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RXcg7GMnHuJ7ZZ/tzN9n8Ii69niLYpvYFmp4I13xJ47fZdeOQjL5KGUkiFx0KzwTXcYx6WymrN7mYFmaMPMahTJqAaxLki5QugdGGYPJbx2WlR/rr4dpdgq4NKBoeJUcR7kXpTPKVZrJCSwnTGbFLY28R+9b16x0r2jU56sM6BXAAVTH0q4t09bI4oD4DOyOcFu6iYMQGZk3KOKGU5Pl/+JfYjfnsBRXb32OioyzNFMVlx4S5ZmoPRXWj3B+roiN7e1pdWrIGiHSZbcxYv3IGTOJKB4MNdSVnbGdJ1V3ruauzS5Lsl6H4oZmQTQAlR6a7lEtJ6zigF7EEnMcxwXqGoqCD9sj4BfUvGwAXMu5JqHOptuz906uqRd9qWxTs9nTwGJrOw6xErptzN3s0SwqSj/f3PjcR6q6W/Al8i7pfI9pmttX/BLc4ALNVWh+RZC906UXXjy4MbTr+FGLHcnaBux7E3WKiJmfY0LhZ+nrR/QlAQ80ksCSfjeTA5TwN1brY6+1KT4SWWEXeeLQnbzPZ6sfTCDwhm92xj8qr0YXsfVx+0gScd+vC4kjPYR56tWU8+I37mHlqyNOIQ7uV9zdpmyRiRj5s4lbcVj7Za90cEQYfdQZiseCh2X7nT9etGsZztzd02LfrCOXbOebeQ264w==
x-ms-exchange-antispam-messagedata: =?utf-8?B?RG0wb3VjcWdWcUxIU3Uxb0JubDhzdng4aVI2S0NBKy9kWkNsL3RCVTd6ZjRw?=
 =?utf-8?B?NmYrdklOOWZsUnp2d082OWNCZW0vSFVkUTRGaUl6dzdtb2FFZXhTdDZqL2Za?=
 =?utf-8?B?Q3JkMjZkQTAvOEdQRzMrbEdKWXp1QWQrSkNOWVM0OFcvS2lqcTM0NnJVZlhN?=
 =?utf-8?B?NzlEcXMvQzRLUGNKWEtuckJRekpkditUU0hlUlBGSXlqdGVsT3hjazN4Sk5G?=
 =?utf-8?B?bGR4M2c3SkZubVlkSWZtK01NNGx2QVJYWmYzMG83UWNRbjFyMVR2eWkrcmll?=
 =?utf-8?B?WnRwb3FjaVF0a1cwM3ZUT0w2TXVEbFBXVGNvY3JVZmJybzBWWFhnUmVzV1cy?=
 =?utf-8?B?NW5GTDl4b0dBREFsMUZ2KzBzVlNzbXJ5SWRtQWE2a0V3cXJ0UmVZUzA0blVB?=
 =?utf-8?B?cHlrZ1RNSHhOaHFQYVVSRGRER1M0b1BSdFRiMXQxdVRpQnZnVnYvZmlRM1VI?=
 =?utf-8?B?SlQwNCtncS9NQ1J5U1oxck93QnkyS09zZ3JURGt4K1pUZFVpa3Z0OCtZdVlC?=
 =?utf-8?B?SmhzS3NpcHpKbWJyUUJrazRqVXdYamVoSkF3MVNaL09GeVZ1ZXA2cE5ZRUJ1?=
 =?utf-8?B?bEdNQjVDVXM3ZkZzNDBSUzdteGxubmxJUSsrVGF5QlJpYXhtRjhEdDhUNVNu?=
 =?utf-8?B?N2VIejJoNTRjZG5tQU9GUWJ6eDZZMEFJam1VcGQzTlhwdHBUK0hkRzhIblRM?=
 =?utf-8?B?b2pTcXRzTUpUN1NHZ0t1WTRvQVFrY0NtZnhVU1oyV1ZueE9sd1hsVDN3eDJx?=
 =?utf-8?B?UFJsT24rcHgvdlJqaThsd0VUdjNjV1pxa1owUjl5Mm1BNXJjbXZsNmhkN2lY?=
 =?utf-8?B?YlJWZS9VRktlSUlvV3NsSDdUdFVROTRzUk84QXpRYkJ5cWxadVVpS3Z4cmFk?=
 =?utf-8?B?WXE1WE1wbzVxdUlaYTRDd3RWQnZVd0xBcUV3dlMxcDJRV1Bodm1XYzlsbWJK?=
 =?utf-8?B?VndEMDgxRWxWd09ELzVxNmN4dm5MS3c5RHREL0gyQ082eDczUkNjaWQyNm83?=
 =?utf-8?B?bXJBOTE2SWp1aGNCZlY1eFMzR21tandRa2FNS2tGNmZPd2hrZmIycUpuUVR1?=
 =?utf-8?B?QXF3LzVhMjhBY3VXM3d2VFhPZzNKdUpXZUo1Y0kyTmUzdXZnYzJUSHNSQ3A2?=
 =?utf-8?B?b2dBYnF0S3Fnd0FHOUZTZFlVNVVlaHRYd0YwYkhEMVIvWG00QWZyTnVPRHJO?=
 =?utf-8?B?bVVaMUVFeWZsUVZNb1JwMFBvamJhdzhNbDJnNlpQQWhuVzIvenZ0N3VuU3px?=
 =?utf-8?B?VEY2Z0NIcUxnNEhZTWhTQStSVDRHdENRSVh6TUphM1V2cTZhZHl6Q1ZRRlk3?=
 =?utf-8?B?d1VqaUNoYXFIRjFIR0svRXYyWkRMZHljNWJuekZMaksvdHk0WnVnazNZbzJL?=
 =?utf-8?B?VHRGZDFITUsvdEZZT2x0NGpwcXdQRGlXcXRzbFRwT09jT2VySCsxZW0wMTBC?=
 =?utf-8?B?UnBiVHdVYmVqdm1sTkZTb1R4Q0ZLa0YveGNNR0VGMzdoZmNoYmN3eTVrbzVG?=
 =?utf-8?B?TTZ0amVDSDJSeXI3RkdvUHR0NUdsZkp3SUNKUU10MWxDT2diWm95YVJaOE55?=
 =?utf-8?B?Rzk3OEpJS25PcXB2VG81N2xsTDlyRHZhRU1YRVo2cVlWMHQwZVMvOEdjcjdX?=
 =?utf-8?B?K3NVNHRjMmhkbWgrK2RmbnB6dWNQSTFMbHdnWldzdlhMemRFYnlYOHF3QzVm?=
 =?utf-8?B?SUpoTFFoZEpyU3EzY0YxalRTM3JFYUJXbzI5YzZNOVBiejlNRkZCdUpqTjVL?=
 =?utf-8?Q?+riy9pN5Pl2ZPu8zDTKGxgsGcEUV0Oh/0abvRcm?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15f7eb1-76e7-4ed0-e2f9-08d8e7f66e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:08:06.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z+gSDssHgt2FzUGDYgIhoHrXNukmHPLGGPxxdy0AnS7c26+QUyAfGH8SLXHdlZVimLJT1XzUm9zmyak1IeYFFiVvrdRurpzTFbo5yJqt8AkWGCjZ7gpaieYSmayd0wt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1553
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pc5V9p0hgQqCxzEED5qYkujHx4520388AA=
Content-Type: multipart/mixed; boundary="wBneW2J0iWv0nCyKZtg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615842495;
 bh=Isqi42szXqYBZTb5Q15hUwaOamN1i9NDMagn8hmh7Lg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EeNqP7J4cGThkLfLlQvWEsNsVPINAlKcjQRCbmhCPeM6gZ80JLWLRgGX3EbgSKxcLib
 JIm6ZL8tp43hc/+JyXSJaq6AqRi3M+JDpms7S5iKTW4ewwkpHP9O72giim2c/JxAlTALi
 Q/jl0tck1/Ny9HLNM+ADWwvhdydKHL0bQIM=

--wBneW2J0iWv0nCyKZtg1
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNClRoZSBrZXJuZWwgdGVhbSBhcmUgcGxhbm5pbmcgdG8gcmVsZWFzZSBuZXcgQ0lQ
IGtlcm5lbCBsYXN0IHdlZWtlbmQsIGJ1dCB3ZSBhcmUgY3VycmVudGx5IGhhdmluZyBwcm9ibGVt
c1swXQ0Kd2l0aCB0aGUgTEFWQSBsYWIgYW5kIGNhbid0IHJ1biB0ZXN0IGl0IG9uIHNvbWUgcmVm
ZXJlbmNlIGJvYXJkcy4gVGhlcmVmb3JlLCB0aGUgcmVsZWFzZSB3aWxsIGJlIGRlbGF5ZWQuDQpB
cyBzb29uIGFzIExBVkEgbGFiIGlzIHJlc3RvcmVkLCB3ZSB3aWxsIHRlc3QgYW5kIHJlbGVhc2Ug
aXQuDQoNClNvcnJ5IGZvciBjb250YWN0aW5nIHlvdSBsYXRlLg0KDQpCZXN0IHJlZ2FyZHMsDQog
IE5vYnVoaXJvDQoNClswXTogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9h
bGxkZXZpY2VzL2FjdGl2ZQ0K

--wBneW2J0iWv0nCyKZtg1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6284): https://lists.cip-project.org/g/cip-dev/message=
/6284
Mute This Topic: https://lists.cip-project.org/mt/81361444/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wBneW2J0iWv0nCyKZtg1--
