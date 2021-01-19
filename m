Return-Path: <SRS0=4UIW=GW=lists.cip-project.org=bounce+64572+6111+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8AC433E0
	for <cip-dev@archiver.kernel.org>; Tue, 19 Jan 2021 23:33:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18ED22DD3
	for <cip-dev@archiver.kernel.org>; Tue, 19 Jan 2021 23:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18ED22DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6111+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VhzTYY4521723xvQzd4wmfB3; Tue, 19 Jan 2021 15:33:02 -0800
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.94])
 by mx.groups.io with SMTP id smtpd.web08.20427.1611099105135674744
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Jan 2021 15:31:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsR1H+fuoBVlsHuBKMQWEwjnBIBoIZMc02NPDQ1MxxWv0mkHDkTZ7tGAP+gaBDD6GiEv7PwFTGWJQ7tCKF6rZCJuL7FWqsJLmnLSI2fIazBwKYnWwDHZckhepOLtrYHU3hdtIdbj3R9sf6HWiSoSUeMBAlwlr1L/IEHvQ4uX5rqu2/mupAf4PzOfFCr+bSHkH0SLf73TTz5GBkiMAj0RrSUqWhI9wnXdkFyNJpQwyY5pORHs8WyD66o7H4yZs71i8wKkF+Y8Qh8sasaLcqxvgcdwoEdOZaMCdACghnDOM/BjnZHOTxkU7/6Tlt4vjXjoGTzhjYyBfuvjUeACn07Kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPPLn86DzS9milihXvHua+z9yaoAg7i4Fj4otNHg1Lg=;
 b=dLLBxmspVpc+xqoxi2hdWaaCuiMjSEE7v+BRPB3KbIhv/NmHtTo5NFW3bRswFExBgH2ZaQIPUWl9AUPfuFEUCwdt1Us/2wsZ+7x1MKJxT97l5/lgQlhKvSv8i4/KwpJ6ebQvVkxG75B0ILIxjkLIUeVDBXtD5ZZOFQbL8kZV28Q5HROprE+bsWGYPmt/hwo6bMXM5Yhju82Mm2CBJUozxJCZinIYzpTEjo8LPoCcFFwZBtuwwzDVTu6O+k0IaXl4IF3jA/GwE4ZXI4G/qeSCsAO8oaj+r9JdK8X3YWnUzqcg/NIqIO03yy3szn1GgyfMLqFyrB/DdoAofiw/m6nigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB3147.jpnprd01.prod.outlook.com (2603:1096:404:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 23:31:41 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::a980:35c2:4282:b23f%4]) with mapi id 15.20.3763.015; Tue, 19 Jan 2021
 23:31:41 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <pavel@denx.de>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Starting 5.10.y branch?
Thread-Topic: Starting 5.10.y branch?
Thread-Index: AQHW7o/u7/d0yzFITEiYw5kpOj2LwKovmSzQ
Date: Tue, 19 Jan 2021 23:31:41 +0000
Message-ID: 
 <TY2PR01MB497256384FF6FC1115BC3F34A0A30@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <20210119182125.GA17515@duo.ucw.cz>
In-Reply-To: <20210119182125.GA17515@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 904094fd-3340-4770-813e-08d8bcd25fee
x-ms-traffictypediagnostic: TY2PR01MB3147:
x-microsoft-antispam-prvs: 
 <TY2PR01MB3147F1DCC1AE15CF5DE762D0A0A30@TY2PR01MB3147.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Yo1xT22w5q0+aTwrL5YshR3o8k9lTnh388tTQxK9yOac2amuN6NByfQecY+Y4hFAs/cxoNNegikcNG+yhCNnisUv1x3YcgEQaKd1Ae21mVwLhoQl81yaG1J+kUEeleUK4K1edxR856cOSp8CbETumFB7xO3UDzvh6/wbNr/b8CT4Dyis2dHH10bkQNhnqLLSbd1JQfOZrJhVvL6npuycWem7qaL+Z5gWUos7oHkFlZXjnNZqDHNfZM8/lfBTnpmIaDc4mfACD2rFheoPQPc9Vd55PAV+XO5Pb+FfJowEkMeFM8T9wh2MiWY/PA97fk6MpBQ8O+/CA23+kTx5g+bSb9ZQXuLGIpsW6vHuDSeiQFT6zlWx1IswrrjRz9NIF0eIrqR7NsM2mJpQPqDeGXk7VQ==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?bXdYVWt4cmZwTXRoSVZtYmtVZHBlNklmM3JXcUxwOWZmK204YzdJVGVW?=
 =?iso-2022-jp?B?cE5VcS9aZWlLSStmbFlWZDVZci9ZU1F3YkVVOWV1eHA4WS9hM1VJeXkr?=
 =?iso-2022-jp?B?V3ZLUGZSVmh6eGlHdnBYREN4Tm94TGJQQnZKbCtkSjNOYmI4MHRqRkNt?=
 =?iso-2022-jp?B?L0dSRkZNU3BZRlhnVGhtbjFkVU1rbWdnaDVwRWg3d2FJeU1zemVJMVpO?=
 =?iso-2022-jp?B?NnMySFl2UFVxK1FDVG0vNnVldUVSTVF4UzJheWYvdXVCY1pJUzdOL3Ny?=
 =?iso-2022-jp?B?bWp0TlZJVTI2QS9UNGJxblVuSUtzbDJPalphV2FGWWM1RlF3ZjVqejZk?=
 =?iso-2022-jp?B?Q3NEcWF0YjVaeEd3b25aZlhiK0pxTVdaYytTd0dtWkYzZzViSVBsS0NT?=
 =?iso-2022-jp?B?NU5mNWFld2d1Q09qeWE2UElQSUxwQUs5emV3bHZjdCszWVVnbEk0U3ZV?=
 =?iso-2022-jp?B?QzRrM0ZzeGRUODNWSVpUUEVYTE92bDUvcHdraTMzUVoxbUUvN1cxNWw0?=
 =?iso-2022-jp?B?eUlkN0JaVVdnL0w0NVNKYmNzSGlwYlZCaDIraXg3SngzUFNPbVc0K0Vo?=
 =?iso-2022-jp?B?Qy9wSHhRZnorcXU5RjJZUUV2WnBXU0ZsTmRuQ0N1WlI4Z3JlZkp2ejRE?=
 =?iso-2022-jp?B?VXZDQWJheFVJdDFVaGVscE1nekRnbEhHTisyV0wxeU4rNkxMQnluREhY?=
 =?iso-2022-jp?B?UzMrNXJ5Z2FtODR2L1RSWUcwVXdGUnR3cUovYlJtMFhZNWdkTHo4SHJG?=
 =?iso-2022-jp?B?VDJCaTRlVlIrV1U0TXAzK0hzcWI0VnZiVTdNS0xmQWI3anp4WkxMVUFj?=
 =?iso-2022-jp?B?VzdlcTduZG1UM2U3bW93UTlYclNNNUpEQ0NKeUVHRTllRkpSV05Idkxa?=
 =?iso-2022-jp?B?cDNnU24reHJkQWI2emNoeXpnK01VbUphODJTM1BKaDVaSnZHUG9IV3k2?=
 =?iso-2022-jp?B?VmlrWDB0d3IzSkhnQVArTk4zZzdnTXFNR3krcGV5dmhuRjVwbFZ0aHR2?=
 =?iso-2022-jp?B?WmljZC9MT1QrZ09CaFB0OFducEhmeGFwTWlCVXpqTzh5Z2RLL1dVQlNo?=
 =?iso-2022-jp?B?eHI4QzNvU2YzNjM1VnQ1NThhd2ZvL1ZkWCt2Q2l0TnkwNXV2Vm1xWmh0?=
 =?iso-2022-jp?B?Q0twUTVCQ2E1ZFBXSU03cmhwMUo2b3pnKzlhQWE5b1lIZXkwQ05XbUl2?=
 =?iso-2022-jp?B?L0g5ZWR0VHZxR2hmUGZWQStBRVZBY3JvZDhPOENtSHRaQ1E5aEpWZUZC?=
 =?iso-2022-jp?B?RmlIU2lLYjEyQjhiaUZRS2s0a09mV3luRGY4bmZXcVkzSytCZWd3TTRy?=
 =?iso-2022-jp?B?Vjc5RkxVUC9PbWdzTzFsaXlIVjZvMEg3MWMxaS96NmtKcGRFK0RwTGx6?=
 =?iso-2022-jp?B?UVZpV3R2VW5HTGlPTVpWL2NKanAwZ1hsRVVmaTk0emd3VUExYz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904094fd-3340-4770-813e-08d8bcd25fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 23:31:41.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcHh3fnsrI/aAe0ijtIkAnCbEk8AzzrG/nDt+Dph+WfoI1Ta0d2qDAxxe8NhsgPdjexvWpJSAmTc6RrVVMwF8T7SoJDddwwodXziuhCi1mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3147
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t6uL971VODeNDin9avBFjWDOx4520388AA=
Content-Type: multipart/mixed; boundary="ArkNoOnp86f19TO4rKP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611099182;
 bh=gVzKuldH8hEp12zFbUlK/n/wOGpmm9ytKhrORaAtUeI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ZATThDh8OrcPvpqpwpamNDuCnSGSTDOhJIcWk+C5nvG7wpEm0tGZNBVKmTmAGCWC1PX
 +dbXvUR//X3A5e/9j+Oe3DtoMAbcZA3urdXCd8+7YM3TCNnPu9+joWTaab9tb8QVpquez
 fizH0QkgYA9l+p4H/OQXzGD2tNyz6/aEQRE=

--ArkNoOnp86f19TO4rKP9
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

Thanks for your offer. Yes, please do so!

Best regards,
--
M. Kudo

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, January 20, 2021 3:21 AM
> To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masas=
hi.kudo@cybertrust.co.jp>;
> nobuhiro1.iwamatsu@toshiba.co.jp; cip-dev@lists.cip-project.org
> Subject: Starting 5.10.y branch?
>=20
> Hi!
>=20
> I believe the next step with 5.10.y is to create linux-5.10.y-cip branch =
at kernel.org.
> I'd propose to start with whatever is newest stable at the moment, so pro=
bably
> 5.10.8 or 5.10.9. Is it okay for me to do that?
>=20
> Next steps probably are:
>=20
> * Verify mirroring to gitlab
> * Put required .gitlab-ci.yml
> * Gather test results
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ArkNoOnp86f19TO4rKP9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6111): https://lists.cip-project.org/g/cip-dev/message=
/6111
Mute This Topic: https://lists.cip-project.org/mt/79958721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ArkNoOnp86f19TO4rKP9--
