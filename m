Return-Path: <SRS0=q23Q=LT=lists.cip-project.org=bounce+64572+6578+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC15C49EA6
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 01:43:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEFE60232
	for <cip-dev@archiver.kernel.org>; Fri, 25 Jun 2021 01:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEFE60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6578+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mjoxYY4521723x4Kj6THoC9G; Thu, 24 Jun 2021 18:43:48 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.1687.1624585425046908130
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jun 2021 18:43:47 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 15P1hV2T015432; Fri, 25 Jun 2021 10:43:31 +0900
X-Iguazu-Qid: 2wGrD5gLVLOTftpGW9
X-Iguazu-QSIG: v=2; s=0; t=1624585411; q=2wGrD5gLVLOTftpGW9; m=4bnRrGK0ICjJszKvhTptl2IkHxmVOODFshjR4vtdxCo=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 15P1hUd9005250
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Jun 2021 10:43:30 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 206ED1000AD;
	Fri, 25 Jun 2021 10:43:30 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 15P1hT0u020863;
	Fri, 25 Jun 2021 10:43:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfvzTsLCO//uiRzQpdU+caX3fncigV7Mo4O1QuZdfH658nhcjNmo/FrL4jIUIdaVevN7nCTzpOFsVZ6qOfJRydmnZipvHr5uBLr6IrxI5R2Au5sPWOCUcyrr06x9PrivKkrJVT46FbS5s8lDbdYsUfnVMRLAFNehUELY2kvz6xUfWD4yA6uN4LJe8h4X4QEiqz2qKWLXMvKG8WGLAnL6pzQZdBV2uf3/TwLabVd9WHZFF6QoDo8Krw/N1JRADDDpd5P/sJQqiIrL42SGvbEz5OVsyZiQiU7cpDMIswnhsYBTPsyqnDVam4jdB4chT69Iyggkv9rD3T8URCxL6XVzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJrlkZi/IsDA0izaRDElwRoI3iKCqX4eP9QfrOD1d14=;
 b=AXMy4cZXSeqFFWuNPYvnXripEa0A7GwWC5eLoGTL06A3HoF4JlxYxtlfKfv+kD6v7pctDMaQEPf4ARoBHxORjzStghomDYJhN5j3CGQFsSHqIGccHk/Jzsi7lxeay6vw0CJRm0lMIk9bGIvH6x4b4wy5sOVCe3uWhBEAZBxtaOsjITR3Z+yzq+uLUKOA/7YV1hiWIlvHPClWpMQFCFBgheLyhZ6K6y0HeU5EF7IzTFxvmGE1GDDDhkH5EZDrT+kesHSO1plOjFJ9OpEL7pLRjgRvnRPbwd6e2O79bF87NDH7kavT6Cj/X/99HC4QbxR6NLWn19K7Qzdeac0X8ZD0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <pavel@denx.de>,
        <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.195-cip52
Thread-Topic: [ANNOUNCE] Release v4.19.195-cip52
Thread-Index: AddpY2TQM8U2Nz/VQkuQhLTyAGskNA==
Date: Fri, 25 Jun 2021 01:43:25 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252A517FA095932BAC6856992069@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29656c18-42d6-4e7a-e705-08d9377a9f9e
x-ms-traffictypediagnostic: TY2PR01MB3707:
x-microsoft-antispam-prvs: <TY2PR01MB37076E259E8EEABA08DDCEB692069@TY2PR01MB3707.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WgGwCvrNRJkjN1Si9LfdkpFK/ZYBRLmbDsR1sgMkcKHkfD3BMj93vMR133IeeawOupxFJABhfEsoVbUTVwSe3Lx/P2fwYM+dk2vzuCseUc6VA+ArGuXPrMikS4VZuuf3HvLjwFjtb6L1qf3FtG81Mq55se6PRVnvxhHClD/R6f7DvUSNKu0FApoIwWQUEpNgkkmlrY4DjGqGCULklEXqT3WyfRwkAbEq6N7pk/IqHXliFlsPRQI2HKSUnKiJxBAFqhAgOOf9idr+G6Oe/xzFwERzin8zZYYCBlA5R34JIH6n472nq7HhkwGZhpWNWk19R3dyflxx0GzlKa12vElvgSmsqETKH+tP+wAEMAXmV8icGk1Kknjm/1gD9xdlSo6XPJmIE9+8ZdpaqmDOXAJ3lYHqYNwRafDSQIfzHxDwuB4O4KkkkJMuD8Cj1opk8Y6QvoUmvoTfCQZ8Qi9BqjQR8uXcQGZNyO3pt0ozV60fAZKC/h38Vz2jSaK/yUUtDrrlXwoLQ4RFuVw24FUoyEen08abTiZLHZ9+zqJnWWkqoe/OvS+AXL+mbZqw8dEcoXlV3/6G3Dt5LrkRWn0HqyPytSpzC1UOpMJdHxO4xquPSHpd7xSiOh/Up39Iz+v2YO2uyf1JanqdZIcTwVDtYucfglBLEJy0qGYJ+D52mw6poDUd+THRMHYGwk8hLHqzPiLdDjPGBHFo3mH2yjIMT/YgMaX2x7YdyyS2iBirs0iGAQI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1hzMmhCZG1yZ1hIWVRpbTR1TTlrUnJRM1JselF6MU9tRGR4QklCU0MrSlVD?=
 =?utf-8?B?Qk1QWEZNQm1Mb1FSK1VvVVRBZFNvZXBnakRNUjJxeCtQQWNwOWlTeExHdmhW?=
 =?utf-8?B?a2NteDNuY2VXZmM2aXpEa004NFR4N0szOEt6NWdnSm12eEtXeWtwdDhpbkZz?=
 =?utf-8?B?T0pCOEJkdVNvcTkvbzhkMGZDNjFYR053Rkw0M3BFUE5Va1pod01zWitVUzhu?=
 =?utf-8?B?cHNCRkMxdDJsU3VxMytjZHVTSjh0R2JBaTBCVUhZWnJLNnF3QzhUTlNmMWJ6?=
 =?utf-8?B?eUJkSEt3ZjhjdGE3OER4TkYzcUV0OThsRUR0VjlOT1EvZEU0TnhWdTgza3dt?=
 =?utf-8?B?OEdodURUOUw3bmFjeWQ4cHc2OTNoUVg2Mkh6ZGh5S3lVQk50OUEzbnVlMjFo?=
 =?utf-8?B?UHpIUmdQc2ZPOTA0RHJMYmZmcjdSOGJNaGQ1Wk1pZEVIQ1k2aG5qZ2hJL0lW?=
 =?utf-8?B?RGE5VG9CYjZOcWtLZmsveEhwQ2oya1FPakI5N3ArdzVtTFlZa1V0SnEyeUVq?=
 =?utf-8?B?SWxiTjRSSEpsY05kbk5qRzlOUFFXYzZRR3NjTGlDV2dGRGhUMlc0YmE2akgr?=
 =?utf-8?B?Y2pSVlA1ajlvZzNiOFdIVGE4SkFSdE5iaGpQeHRmakFUa2NMSTV6L3p1WjZF?=
 =?utf-8?B?bXo4TnpNcWxuUDNzQVRpSDVtbmdra1o2Q3k0UGkxU0VQT1VHZTRONmxrNXlI?=
 =?utf-8?B?TUZiUnh1bEIrR1Z0WStEUXpXY2xVTkRhWU1ZekE4L29wR0JhN0pBSVB2emd6?=
 =?utf-8?B?dnF5UXVYYmZJbUhwaktWbXNFU0V4WUhlZjM2aUF3eHowNG9GRm1lSUcrOFhL?=
 =?utf-8?B?YmZWbnA4U0g1YUoxMGgzUFpubEFHNUNVaFBxRE1kZ3hQZW5nVlBQWXBCRUFY?=
 =?utf-8?B?NnNXd2ZuVi90SFR0LzJVeVB0Q1FucGpmSk9lNlUrbjNKZlJCdG02aXlGdDVX?=
 =?utf-8?B?cmkwQng1TEZTc0FYY1NNdEdMQVNRVkpUaTBnOGpiSm8vYnBZZERjTmJqNEov?=
 =?utf-8?B?WHRzSlJFbUtVRXJUeXFPUi9QMVVGNHBpVFBYQTdFTldtSUZJMm1lMjFLZmpo?=
 =?utf-8?B?aHNPQ2gwdUVhU1hpMGd4ZE5Wbzk0RVcyZkdpSXVGRWpON3ppUmRWd2M3Z2w1?=
 =?utf-8?B?NWpXSVlMSmM0WEdaUGlIbklTMElpSHkzS2s4NHIrblVQdXUxUXpSSkNma2dl?=
 =?utf-8?B?Qk9GbnVvRnRvVGRtbXhhUjFLRWJ1RzRKU1ZGanhoaVVSdFJqcUFUQ3dkbkpM?=
 =?utf-8?B?VUNTQkVkSTdQVzFNdUkvaklSRjViMGJGaTFvTy9ncWp5Zzk1cjlsRVI5ZG1V?=
 =?utf-8?B?T0p3UHlqeHU0TGx4TFJBWGJwZ1dHWGNkOGNvYUR2WFRXK1dXam9rRENBL1pw?=
 =?utf-8?B?Y2RCQUlxdTRTSkgybmh4QlpLTmdpZzVVNmZGNGRPMHpjZ1R3UXJJR1BLWGV4?=
 =?utf-8?B?NmFLd1d6OHVGczk0bFdpamtUWk5NdGtia25XMkUrWFk0ZkI3RmdiTHRGNjdZ?=
 =?utf-8?B?UDBuajU4K2NldkQ4OTJwM2ZRWGxBcVhaa2twdUp4d2gzMnFSY2hQQjJ5WC96?=
 =?utf-8?B?WHNoOENiK2JoaFVaKzllTWp2NEpVdmJLSXdFU3F5WUZVVTlOTXlHeUdmQndr?=
 =?utf-8?B?dVk3MzZCQjd5WE03MGl2ZGV4Ym9MZlNNVkE3Q0dOS05hTUlldzQvcjRnSmt5?=
 =?utf-8?B?WkdjWUJFZ2RzYmx4clV4MWd6cTBQRmgrYkVjdHZmdWJkZzQ3M3labnNhYlZO?=
 =?utf-8?Q?KTNjHoe9eW6Kfu9g9E=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29656c18-42d6-4e7a-e705-08d9377a9f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 01:43:25.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XP0jrCG2F1gmRjFTxoPSRlif/nf25JwZhzLuZXr7us+LjJY9LskEXEreh1G/RoExtka85NwnYa276BIKE9rFuJhCM0ctEdadnaHDJ5Yj9tu+w72Yy5xz/9QWASipe/FZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3707
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8BhfwKZJBO6KmVxwK2J1EhKqx4520388AA=
Content-Type: multipart/mixed; boundary="iozSabsI6N4UiqHQGsE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624585428;
 bh=8pFK0L6SrG68oOw1iTg23JKXPGyj3rOUafiqmS6cfuE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=H25p2XDI3QhqOKigyUJ2Yk4O/3Vfaz6TuVhK+FOEid0dhXyrzfbJWVYqzu/+qH2W50K
 vcodyzSTRxUrSaiVn10p6pVbM87ko8lHk5nDhV8Eslq3LHGhKsCpImx+pjoosc0BeKriT
 xDQ1NMpGVhcya0moNkZYfLXObJqy34Ts2aM=

--iozSabsI6N4UiqHQGsE9
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xOTUtY2lwNTIuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQg
YmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTk0DQp0byB2NC4xOS4xOTUuDQoNCllvdSBjYW4gZ2V0
IHRoaXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE5NS1jaXA1MjoN
CiAgICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51
eC00LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA3YmM3ZTNhYWU0NDBjZWVjN2Y1
ZmVlZTNmZDUzNTc5YjQ3MjJiYjc0DQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVt
cCB2ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNTIgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVz
dCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg0KLS0gDQpOb2J1aGlybyBJd2FtYXRzdQ0K

--iozSabsI6N4UiqHQGsE9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6578): https://lists.cip-project.org/g/cip-dev/message=
/6578
Mute This Topic: https://lists.cip-project.org/mt/83775394/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iozSabsI6N4UiqHQGsE9--
