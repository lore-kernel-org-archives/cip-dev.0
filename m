Return-Path: <SRS0=Ls1Y=MD=lists.cip-project.org=bounce+64572+6619+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D327C07E96
	for <cip-dev@archiver.kernel.org>; Sun, 11 Jul 2021 11:13:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B72611CB
	for <cip-dev@archiver.kernel.org>; Sun, 11 Jul 2021 11:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B72611CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6619+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QLKdYY4521723xXOcdfQakqG; Sun, 11 Jul 2021 04:13:36 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.53])
 by mx.groups.io with SMTP id smtpd.web08.5870.1626002014562769367
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 Jul 2021 04:13:36 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out11.sbt-mailgate.jp [10.16.47.41]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id LUHY04766A;
	Sun, 11 Jul 2021 20:07:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEZC41diBZxBlO6chb38SOlUdvs7uO9YHnFnyZuWuCzV4jiUVXZ9kWDU0XD45FjEpsX4A1UaAt5Fk51OMMoMb3hJXWxaRECvVjbs8lwhsSGkAPgq//2MlYYBlrm6yfvjSzv+OXYfDua386agxm99OBeNS4mwU6E9YI8fFkU4M+ldeaJaBnsepk8gIocUkoFqx55xMWFfRxUd9Dt77s/98jr5foBpLqbf0w+C8HDqKdOlEQx9TW2u4hVr/lJTezQ4WApYGwTRk5iKeLw3eOeFO5wcIPWFoUiKnRRTZTHabvw9oqU0343NAYI9ltGHoNvx2PbiOKcgM875cRKhW728Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbPQU8bj9MKuVaBpxk5ueS2Slv/a/4MzKPnklNhfaYA=;
 b=kn/AlMLCn7aX9PcciXWvylgakfFwXbpvwnzvUnVMl6EyHLu8PXzd5kjA0gcgsdHodyr8nwPNmjzzpEoku7d/3G+4CXDZmMTwBRuRJZ9Bs1vWGuxcRa3qkBQiujFzsRnMOKtEAGuSwwvoV/mbRCd7nRoP1BdvJSm2WOpZ+ytliaVJW3pauw5vCf7RUD0gz+0pLCJ0dR/niH6TSp2LUQofPwdkLieKsZkXpcLa5NEMLM4YN3RD3QZbm1CtKmrYS38CwzyBqYLwox1+mEZmfYwVZgnpuf8MSfyNOMLnUSWFeakz+zrUoCjRsRahlW0zz62FGuOZLFo3LpfNIuJvTZAeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB2558.jpnprd01.prod.outlook.com (2603:1096:404:88::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sun, 11 Jul
 2021 11:07:10 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::f937:86f8:a385:7913%4]) with mapi id 15.20.4308.026; Sun, 11 Jul 2021
 11:07:09 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entries this week
Thread-Topic: [cip-dev] New CVE entries this week
Thread-Index: AQHXc49dGZtehwmSo0KKbSoYmJRFIas9d3QAgAAq/kA=
Date: Sun, 11 Jul 2021 20:13:28 +0900
Message-ID: 
 <TY2PR01MB497227B8AABD7A560E1062AAA0169@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9o6L1L7z=HBNDQUc8yxHy9ZehgCjWhUmke3uuMJ6qpp9A@mail.gmail.com>
 <20210711083230.GC14434@duo.ucw.cz>
In-Reply-To: <20210711083230.GC14434@duo.ucw.cz>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b02d7a4e-464b-404c-dde7-08d9445c074e
x-ms-traffictypediagnostic: TYAPR01MB2558:
x-microsoft-antispam-prvs: 
 <TYAPR01MB25582EA8D38BEA6C18B9529CA0169@TYAPR01MB2558.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 qyR8jk5H+Ds4Ty91PExeHcqAWvCO607CnmBSUL9iV9shwlL/JlcLNtahhrcdhoNg2WZtuGZ+zQ/GR5EFy+j0PWZ6StP54ERAHlybzeM1jVxgsLNX+vVvSZZIYH/GYW0nG9DBdSSleKOoVVLSCKfjCviK9/YhrGcLSgfdJdwGMt49NS3ZbozkgqmtE/ltzyMyyv/Dowx9221I9K9wODzsHNOrwbXQ8aDIXeg94RQaOz58Gv1cDo8Ds31zmn62NxFcPljMweOr61gCYhmWkyyKxndK9Sk84VxFwSbz9KPH0XUH+F6pGq76CjUReblJ7zWXaWy/DiHNfa7r1B9ssG8ozYdShvZmhWfdaggmA6kdnYGIaVYlyzAZdv3oBlsj8I/gm2nC2ABPUmvvP9m/1thB2HsSr7vFgq046gYgTv+EUkp4dbSZl4tOnjNcIMWxnn/KISBx2TFpHAp1YxsPvmnE/kdH+hfulZOJZ3hpEgBzvgyvk92KEUqpYGphX+PLqtiEshmndTkBtYEWlLhpijSvJ3qpood9qC9EJ6HWBYVQYoDn/QgSYQUsEONMvE5smDdZQcZucwG8CtRmktRaMxzqMtnyyHFLH05I0pWkGciKYSUce+eyjZS/eULNFmd0K6zn2+rSoWGE5KrJczulLSV33fdho3mU5nr/zxZssdNBr7lcoaWJ/dNgi9Ocg8hb3jfYCrLlWX+dFWHR9QdwtyaMGw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UDYzZGVKWVM2VW5LS1U1WkNKbjVyTGJrY3YzeTNKQUkrSmx5NTJQRHdz?=
 =?iso-2022-jp?B?KzVhK0tLd3RSM2cvSFdEaFBpcXlhMnlZcVZyZVpaNFJLN0ZscEowOGhO?=
 =?iso-2022-jp?B?WThXL0U1c2VVenk4Y2VjcjhRSGFyYmxtY3FnRitYak9iR0pTZ0Y1dHVV?=
 =?iso-2022-jp?B?VkFjUS9tcUhqTEFJbXErWkh0SE5TL3ZTWGNiT3VwK3paV3RGNEpaTVE1?=
 =?iso-2022-jp?B?N2wwR0M0UENyRVlHUnJibEtSK1lWMVc2NHJOczRkNWdTdkgzdjRXTXRl?=
 =?iso-2022-jp?B?NTlZcU51Nml6ekRXR0Q3QXMrS2JsYm1xY2pINjhtWU5DckRhOFlxT3Ix?=
 =?iso-2022-jp?B?Wk5ubithZzBKVDRLWmh1cndNSkIxV1AwTzU3Zk9vdXhPR1o5UWtQZ3F1?=
 =?iso-2022-jp?B?Y3JNbitxckk3K0lWdXRZZ21IQ1VKanF4RlIwK1RWdWJrNDFUV29LT3NN?=
 =?iso-2022-jp?B?R3A2TGdQZE5VZmFub3ZvQUl4TkxyV2ZmUVYxRjB5NzVaUlFNcVJzNllY?=
 =?iso-2022-jp?B?akl0NmJxVW9JNjR3azFiZWp2T1FWSzBtODkxYlhaUkkxZjNyVnpFbmZH?=
 =?iso-2022-jp?B?UFdTaVhiSWkzQUNmMElvTDEyVWJOUnhqYVE3clZuNER4YzVjUzE1djJP?=
 =?iso-2022-jp?B?eHdMeW9FY04yNVE0Mk9vR3RBdzU5U0d5eUd6UmhDalljaUxVa0RabzZx?=
 =?iso-2022-jp?B?UmtIWnlCcTQyMDlsMmJFV3daclU4LzBYL3hwQ1c3NjVCZFkxZTVRQ1NN?=
 =?iso-2022-jp?B?bDk3YmE2aDB3RDdNWDI4bkxPcCtoTUxMSHJUMThnVDJHdkl0amxlWUsz?=
 =?iso-2022-jp?B?anNKR1dvTnNJWmtYRWlmL2JSODgzRUQ1enIzb3pESnRTYnAvN0FXdUJ5?=
 =?iso-2022-jp?B?YlBFa09lR2kvL3h0RGxQK0Q0T2I3c1ljYjRUeW5MeGNaaVhpWHN5MjVV?=
 =?iso-2022-jp?B?Vkhub2kzNWNWeVdiU2Zrd3RCaFVCWTNlR1pIc2FkbElYUCtPTnJhbUJ4?=
 =?iso-2022-jp?B?WisxS3VCSUVBQk0ydFlKWlBmYWpKTGcvWlMyOCtNZ3hES3hQWHhUK1pT?=
 =?iso-2022-jp?B?NkRlOWgzR3gyK29ydS9EY0R6VVZmcDNBc2k1blVha1dyY0pEMmVtTy9O?=
 =?iso-2022-jp?B?bXBuYmQwQ0xFRm50S1VWODkzdnRnbE0xeWh5aWRZak9UdDIzVGh2U3V6?=
 =?iso-2022-jp?B?V0NFdkVoVXRZaVpvczVKbzZiZUErVlMvSCs5N0tVTXpOTExnVjVyV2tY?=
 =?iso-2022-jp?B?NEcvYnhEaktrWEx6c1lVQjVUNmhUMEZRN2dxRnl3UTlYZ0JNNHVwV2FZ?=
 =?iso-2022-jp?B?eXBqN1BzeVZhcEFJSG83bURIaWVlNENqRkhIdHV2UDhtZWQ5SjFyempF?=
 =?iso-2022-jp?B?eFBUeFpDVkI1aTlwd1RMdmZBUGZHbjZRcFY4dEdLbHA3S1BCRnRKbE1N?=
 =?iso-2022-jp?B?MTRMZmhOZHFnOERMM3ordHU4K2Y3OTFreng4RUVNQm1hMVhBNFI1OS9H?=
 =?iso-2022-jp?B?SVczaVdqbVp1OGdtNktqeUpNSE9FdFB3bllrTm1qK0NKUGwyUEN2dXRj?=
 =?iso-2022-jp?B?bkpqRVlETzJ5N1JUdDdyaE1QR0JSNUcwN2FYRTRzbVljYXRqUUZXR0Vk?=
 =?iso-2022-jp?B?Y05vN0hEZUdLRjkyV1l1Z0MzTmUvVEYvb1lFZ29wZmJzNFlOUnpxblZE?=
 =?iso-2022-jp?B?QUtZaldScFpoTmlHR045SGRWYnlVckg2eTJmcmlNWVZBOGl5cjdVNE5H?=
 =?iso-2022-jp?B?eThXVW5jUUZVTGkwYnlpNnJrdlJ4cUd1T3ZSdzcyWU5yaDRxKytGQndm?=
 =?iso-2022-jp?B?ZUhjL1QrUmVtOE9jOWU5aU5SL3pYdWNMMzE2WlA3eXlRTTFKM0JxNUhP?=
 =?iso-2022-jp?B?bWVvZDV5MXFxR2hPbEU2Y1VmOG5LcjFXMXhtdDljZnlZWFBMYVhzbDBs?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02d7a4e-464b-404c-dde7-08d9445c074e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2021 11:07:09.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xrGkuR1nCikRUNTmNLGxx08rZ5X8sYL28z2al2/DRvVPOP6IJM+TySKcCkUSjpWgYU7gLH58EodKe+XlU1Scdje1nlu3txLY/f1D0EpUtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2558
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3U3PwlWUYSbA2FXXd2r36prUx4520388AA=
Content-Type: multipart/mixed; boundary="A9D2TajgrM6DHxBpO9kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626002016;
 bh=jd104Po7yhVa58dtWrmNVnfyZOV1l0J+1UdxtrN+zQI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WKw7bWO5p/bsTpmN8ZCUorA24VqMuJ1PsrL5Tp56Rj6SoY8grXXsXIUIgbAdQn78TDm
 fkISHH5DkvZMFQoanjPSH5tv9nYznPr7tn/CQomilOLAzDe0gi57gfsmm57RmIX1A18bT
 sSAVQAvyaQLin7S4QfQGhkYrjCi/8COxnAI=

--A9D2TajgrM6DHxBpO9kk
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Pavel-san,

Thanks for your diagnosis!

Best regards,
--
M. Kudo

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Pavel Machek
Sent: Sunday, July 11, 2021 5:33 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week

Hi!

> These are the new issues this week:
>=20
> * 2021/06/30
>=20
> CVE-2020-28097 -- vgacon_scrolldelta out-of-bounds read

This is sad situation but we don't need to do anything here.

> CVE-2021-29256.yml -- Mali GPU Kernel Driver elevates CPU RO pages  to=20
> writable

Too early to do anything here, we don't have enough information.

> CVE-2021-31615 -- InjectaBLE: Injecting malicious traffic into=20
> established Bluetooth Low Energy connections

Too early to do anything here, we don't have enough information.

> * 2021/07/08
>=20
> CVE-2021-35039 -- Without CONFIG_MODULE_SIG, verification that a=20
> kernel module is signed, for loading via init_module, does not occur=20
> for a module.sig_enforce=3D1 command-line argument.
>=20
> This CVE affects v4.15 to v5.12, so v4.4 kernel doesn't affect.

Stable did the work, we don't need to do anything. Good :-).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--A9D2TajgrM6DHxBpO9kk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6619): https://lists.cip-project.org/g/cip-dev/message=
/6619
Mute This Topic: https://lists.cip-project.org/mt/84058381/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--A9D2TajgrM6DHxBpO9kk--
