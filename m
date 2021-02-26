Return-Path: <SRS0=nCU3=H4=lists.cip-project.org=bounce+64572+6200+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C5C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 26 Feb 2021 12:42:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87EE64DFF
	for <cip-dev@archiver.kernel.org>; Fri, 26 Feb 2021 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87EE64DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hitachi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6200+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dxPRYY4521723xKx5akxdufB; Fri, 26 Feb 2021 04:42:47 -0800
X-Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com [67.219.246.115])
 by mx.groups.io with SMTP id smtpd.web11.8681.1614343365471039764
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Feb 2021 04:42:46 -0800
X-Received: from [100.112.6.224] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
	by server-4.bemta.az-c.us-east-1.aws.symcld.net id 77/4F-56876-4CCE8306; Fri, 26 Feb 2021 12:42:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRWlGSWpSXmKPExsXSOvGJpe7hNxY
  JBq8uy1m0XDvMZtEw8w+bxa2X7cwWPw+dZ3Jg8djwaDWrR/PKNeweF17eZQ9gjmLNzEvKr0hg
  zfh8NKXgu0rF4vc9rA2MW+S6GLk4hAQWMUq8f/KMpYuRE8iplWja8JwdIrGEUeL3vO9MEM4jR
  olfK3axwTk/Xj2CyrxllOjYt5YZxGEUWMos8WbiC3YI5xiLxMP2FjYIZzOjxKGtL1kh1ixgkp
  g+qRCi/z6jxN2ep+wgCTaBXIkr5z6C2SICeRJH57aB3cUsMIVRYuquBBBbWEBFYu6sRsYuRna
  gGlWJfkmIaj+JnpYrQFdwcLAARVdfUAYJswgYSTS1n2YCsXkFYiQOtJ2BeqGJWeLr7Btg53AK
  xEqcWXoerIhRQFZi8q5GJoit4hKXJi9iA7ElBAQkluw5zwxhi0q8fPyPFeKvWYwS9y9cZ4FIK
  EvsOnSNHcKWlbg0v5sRwvaVeDPzMlSNlsTxv2eg7GyJxgXnWCcwmsxCsg/C1pfYM/EUC4StLb
  Fs4WvmWWBPCEqcnPmEZQEjyypGs6SizPSMktzEzBxdQwMDXUNDI11TXUMzE73EKt1kvdJi3dT
  E4hJdQ73E8mK94src5JwUvbzUkk2MwISUUsC6ZAfj91cf9A4xSnIwKYny3uizSBDiS8pPqcxI
  LM6ILyrNSS0+xCjDwaEkwbvlJVBOsCg1PbUiLTMHmBxh0hIcPEoivFzABCnEW1yQmFucmQ6RO
  sUYyzHh5dxFzBxrGpcAyWdrQeSGeUuB5P+7d4Fk/4KDq5k5brYfApKt339tZOboBZFCLHn5ea
  lS4ryeIEMFQIZmlObBrYRlgkuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHl9XgNN4cnMK4G
  77BXQ0UxAR1+JMQM5uiQRISXVwNQzbY5Jk0gp6ymvzxN3HY79ZPJr8sXW5sClf6ecuBntyiYt
  +egw6++VC3WWl+zfqvh4YsD/Sy5ldjNa/3h9turXMi08bH+NgYd/eanH1fDK+UUaNfuUl5XeZ
  onS8p16oTXMUt1vQ4tX+LZpOalfr+iYbhd0+7py5vGTLt/fz5p6zzWuIuT5xPZ47XctRwz+2q
  vJWl86GSXos0FqWss6sVs7Jtzu0px2+OjHqpQPfow9JUZ3q57sYpQuDOYyk3HY/O3Q6h6324a
  Tp85VEpFdnhvhquoqc/Do7Re8Tw/XZBVN3iXZ2bnrgZT9svoPF28yzkpZ5KVU+r2480Np7928
  56HfHsW9ivooUF6jk6Dq1afEUpyRaKjFXFScCAAivKwWfwQAAA==
X-Env-Sender: hidehiro.kawai.ez@hitachi.com
X-Msg-Ref: server-20.tower-414.messagelabs.com!1614343361!426807!1
X-Originating-IP: [133.145.228.57]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
X-Received: (qmail 24332 invoked from network); 26 Feb 2021 12:42:43 -0000
X-Received: from mail10.maildeliv.hitachi.co.jp (HELO mail10.hitachi.co.jp) (133.145.228.57)
  by server-20.tower-414.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 26 Feb 2021 12:42:43 -0000
X-Received: from mlsv8.hitachi.co.jp (unknown [133.145.228.43])
	by mail10.hitachi.co.jp (Postfix) with ESMTP id 20D903C0035;
	Fri, 26 Feb 2021 21:42:41 +0900 (JST)
X-Received: from mfgw03.hitachi.co.jp by mlsv8.hitachi.co.jp (8.14.4/8.14.4) id 11QCgT6D016102; Fri, 26 Feb 2021 21:42:41 +0900
X-Received: from GUjpTK3DCemcs14.global.hitachi.net ([158.213.250.15])
	by mfgw03.hitachi.co.jp with ESMTP
	id FcS8lPMZB5W4dFcS8lDuXw; Fri, 26 Feb 2021 21:42:40 +0900
X-Received: from GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274)
 by GUjpTK3DCemcs14.global.hitachi.net (2002:9ed5:fa0f::9ed5:fa0f) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 21:42:40 +0900
X-Received: from GUjpTKHDCemcs02.global.hitachi.net (2002:9ed5:d24b::9ed5:d24b)
 by GUjpTKHDCemcs07.global.hitachi.net (2002:9ed5:d274::9ed5:d274) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 21:42:40 +0900
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (74.107.156.4) by
 GUjpTKHDCemcs02.global.hitachi.net (158.213.210.75) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 21:42:40
 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H42yr8u9HDQiBZ6RBL8ramMJm2K4gJbIwn6iHnkkT6MozspJLM3mmix3LCF7yQLqO9lRtKPpB0ptyJpTj9M5h3IKCUq4pnG4znbvIT7/pnE9FCLFR+2LtOn4D1oNk295TzBBjgB6ko3oFTMpMkN6DfANn6g+RqjnFNRQWzYa1/X1dda5qGlmk+R8dUx//+QPkKd0rnNAkrO9fMPgx2IWi2ay7oCUfhCO367JnXbXDP3iINkxhk3ksFXCZrQhBf5hQWNOeT1CjJWQaWm4njliDSZbQyiFzOrxyJGQEHnCZVu69hrprlogY/93J+vSAt9uH/ElBbmCzFa+zVPYjlNMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awr8P0fPSGMuCoyEf3td3gRJX4+47Wwt4hJ1O00jUv0=;
 b=Fd37ya3PJaGH0Cy/pm8A1FG6oevlNfejwcaKyqCT4OtVONOJ5iDuCkld2y/hTOJ9QfYeaZ1w+WeSMGNV3buI1oYeaHPrZabiJzHp6axc0g85YlVk/f/iSpsjIwPPiG2w80osGuecS2V3c/BhClU97U1bU7cvy599cqDbzmkIUEnCOkY3i+X0kB3SAs3k/Kq4PdhI6lF3y3h2t8EddXDM+3Q3HYLCiDrjjr6BdfMpB+CEr/EhG+3cwsKTinOastl+dUMWA9gMuQ6Gtmnylfi2nmOlwC7BFNvEVhcn0upeIhQR+ORtLXup8D6N7JzZkgXILI/S0xYUhe6bgJj4HwW66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi.com; dmarc=pass action=none header.from=hitachi.com;
 dkim=pass header.d=hitachi.com; arc=none
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com (2603:1096:404:88::15)
 by TYAPR01MB4719.jpnprd01.prod.outlook.com (2603:1096:404:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 12:42:39 +0000
X-Received: from TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4d63:81a4:2430:59e2]) by TYAPR01MB2429.jpnprd01.prod.outlook.com
 ([fe80::4d63:81a4:2430:59e2%7]) with mapi id 15.20.3890.022; Fri, 26 Feb 2021
 12:42:39 +0000
From: "Hidehiro Kawai" <hidehiro.kawai.ez@hitachi.com>
To: "'masashi.kudo@cybertrust.co.jp'" <masashi.kudo@cybertrust.co.jp>,
        "wens@csie.org" <wens@csie.org>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] hitachi_omap defconfigs
Thread-Topic: hitachi_omap defconfigs
Thread-Index: AdbTcPgiOigQlKwYRJOXEiB+bUAieQDzuqtgANHIwrAABi+8sAwq1QNgADwkvVA=
Date: Fri, 26 Feb 2021 12:40:18 +0000
Deferred-Delivery: Fri, 26 Feb 2021 12:42:00 +0000
Message-ID: <TYAPR01MB24298D6F0B079B2FD04EDFB5B59D9@TYAPR01MB2429.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497230D728C09766E2AEDF8AA0C50@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <16529B035A24E529.13568@lists.cip-project.org>
 <TYAPR01MB242955EF692D73FD473196EDB5DC0@TYAPR01MB2429.jpnprd01.prod.outlook.com>
 <TY2PR01MB497225A38DD561DEFF392ACAA0DC0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB4972C67E512FDF94724B1B8DA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972C67E512FDF94724B1B8DA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [202.246.252.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37a2ee7f-4c61-4b54-cdbb-08d8da5400af
x-ms-traffictypediagnostic: TYAPR01MB4719:
x-microsoft-antispam-prvs: <TYAPR01MB4719CA2601EBE63FCDF5F0A6B59D9@TYAPR01MB4719.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aRdu8MyKTfir3256NlbOT9NH8N10ojs0oxZbom783w/bHU43W7We/hLu3GzTaDHJoXGKo5cIphBCAbNgQAiUH+PZSqGM/A2FHE+9vbseMhc7oNWo7SWYiTI8NJkPwNRrHzS68L3Gftfvz7ewA+VDcZmM2bCuBNNWZxexrIFZVVzX05tIpJ/r76feutoni448/VknaJwZk3Lu3KNLqjzl3WObHlQt38pF0VxN/NFmqd2AEenhLybPz0N1QLKAc1vRE+q6wFFDCzSClYAr4ctTjvBN82sJTpe39sy5e3VQGjNs/GU+nbWIXh4WGf1RefMciGQruhtLyTHsPK6lmRtYTDWkO3LDLui7vOsTAF2hemWuRC3Tc5cwb+PmlpElFrg6e0uNNcRKS5CLcL3isFwj36D4xWaSPEHWNeSrhkGcC06SFHZft070+jrtgtebQVFeMla44I38E1OwpeyL2DMEgPMISYNcb/MIuEeV2tS2TJganyVY48xhUPd41bdydt12n+pOVjPXK8LfI4enIcwPWId3JHHhbrFk1QfAgIQponG5ORgM2xpEa7jsXkxFlM372ZO8QD7gQzeqINXNKqkRNObZlpqO+Ku5fgNya/e0JVRfsnUw70EtkG7d9hAdKVoO11a/XOCSkkDCPnZFqhu78A==
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?L3lNdXB2YnZ5cThTNWZBK3ZRNy9tUExlaXI4bmdUWUtZcENpdVRRVWhY?=
 =?iso-2022-jp?B?MkEzaE5mT0U5WjVtY1AvdXhzSkRjeGZONVI4bmozeDdhQnozcmpXOE11?=
 =?iso-2022-jp?B?ZUdTVEk1ZHBDUGZac1BsUUtIOUZPcEI1d2pmR01ldUdMZzBONVhFd0J4?=
 =?iso-2022-jp?B?ZmpzWG9EUjZWampYRUszS2x2MFZGa3JmRzBDNHNDeVE1NnNkN3YzbU9Y?=
 =?iso-2022-jp?B?WmRsbEtHZDl5ZFY2R3p5NlcyT2s4OW0vVGhCVWxHeG51Qm5LU3hYV3pl?=
 =?iso-2022-jp?B?SktPQzNNay9Xcm92djM1Z1M0UDd2WitZM2tnM2tKUXlCbTFuYUNkeElG?=
 =?iso-2022-jp?B?ek1XUlZ2a3VoTXFscyt2T1hGeGFSSkJHWlllbU8xdmplb00vWHJsSDNY?=
 =?iso-2022-jp?B?UWtDcmg1aFQ0ZUplaXdUMmUyd0RRcUFjT2FzZVE0d2RGUlpGbGp4OVdx?=
 =?iso-2022-jp?B?RzF4ZHZqY0ZFNmd2SDF4YU9JblhLUGk1Y2dHNkxlWUh6MzN0azdvS2RN?=
 =?iso-2022-jp?B?SzhURysvS1FFeklRWENYS0VaSklHby91d1BJdDQ5VElNamx4RjBOOWc0?=
 =?iso-2022-jp?B?bHVUcmFhME01SHdIZFNkc1h4K3JLNTNxYkFPc2hkNVBEa3ltTW1yQnFZ?=
 =?iso-2022-jp?B?ZzhvZ3hLTFVIT1ZYaUxFTkNwMWY5bnVaWHZETHhIRXJDa3BLRlp6aUxH?=
 =?iso-2022-jp?B?dExDbUhUbzdWb3ZKUVljWFZzT0JhSUViejdjVG1ZbEtDR1IzakNZNEIy?=
 =?iso-2022-jp?B?K2VwUHZxaml3UEdPdnMySnd6eFExY3M1TjVzSkljYUpNd2ljaktzeWJo?=
 =?iso-2022-jp?B?dDE0Y093NTZkdzB2MC9oWjZsRWQ3NEErK1MyZmZoOU4yU0NlZWVteGN1?=
 =?iso-2022-jp?B?bXVYTUJUWExVT2wzMkFmU2xxRWhXREE5TzhkMWVubC9QWm9PUlpYcjUv?=
 =?iso-2022-jp?B?c0FGNGx4NzU2dW9SQkpQdGUyT0EzNURaWWFhYVM2dmJiUERFdnpxN1BN?=
 =?iso-2022-jp?B?NHdBd2xDOThweXlsK0doWmtPL1MzVDFJYVQxMWxLWDM0bWtPYjcvVHVx?=
 =?iso-2022-jp?B?czcwTmtic1JuaGdEd3VGQUM1VjFrWW1XQzhPbzJYcWhzNTFFNFZzWjhp?=
 =?iso-2022-jp?B?NDBwSEEwUFQrQ3ZQYkdrOEtvNDI3M0dJbWFmcXBFWkZmZC83Yis5Q09B?=
 =?iso-2022-jp?B?czlzNmgrRXpOU2wvM0V2MHBJcFFNQ0N2eDhCOXR6K0h0WTcvdkQzS3Zj?=
 =?iso-2022-jp?B?cWxJaHl0RjBTTCtkUGJVNUVzNEZReEZtTHdZVHFCcWxJTEdyRCtBSWpF?=
 =?iso-2022-jp?B?OVVCQ0ZPNndaUmVhUEJNSjJSVGxmTHNaeFRTTUFDeVBTazY0RG0vMXNw?=
 =?iso-2022-jp?B?UjNkVkdsMmZCUFc2dnRmeDU5bTk3OWtFZGVSRTA1MjRybjdEVG83NUlM?=
 =?iso-2022-jp?B?K0hiTWtic3lJWUJEY2pMQzFYcmtCMG1rZTFOVURoNlpMVjUwcW9TV1VK?=
 =?iso-2022-jp?B?Y1M5MFlvVjBrOXExR3QxNEtUR0Mwc1pWNkFmZDVEd1JiT0g0TTNES3VK?=
 =?iso-2022-jp?B?T0JWcjY0QkFHdjdBUUcwbm5LRlE2MWZIV2pnNE5iMWNJeVJlZHlYRHQ4?=
 =?iso-2022-jp?B?bkROcVVlV1drT2gvYlZiaWlpaTZobUFWT0VQNXJOQllTcUl5djMwK0RT?=
 =?iso-2022-jp?B?RVdTWUoxdS9KSjYwajBITDFvZnQ5WGlwbDdEa3NsNDM1eUtPUkgwdkNt?=
 =?iso-2022-jp?B?Qll0VkZ2a2MxQUE4di9zSGN0WjBQaTUwR200UTN1TGZ5VUl2YmU1eC80?=
 =?iso-2022-jp?B?SEhZZ2k4QmRIckxxZEhYQzR3aEpSbUhiUEVVdGdGSTROSjBKaFNCZ1Fi?=
 =?iso-2022-jp?B?VEhPZGFwNGtSVGxRaXNtaFlKc1JCeURpcG9rVWxaMnVKRVRGQ002S2Mw?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2429.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a2ee7f-4c61-4b54-cdbb-08d8da5400af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 12:42:39.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f54277c9-dafe-44aa-85a4-73d5c7c52450
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRbIsdw63tGIZcbGi7cvCE/hTQ10XvrqmX5OiPhPREzH+a495aKmFKqF3LUBVIm4PoevyIeQ5Y1O7Jdfjm0Yn0YG/oJ6ozU4jD0P2wvUWWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4719
X-OriginatorOrg: hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RQpD7KLk05wUF9kI8Rvzu8Tmx4520388AA=
Content-Type: multipart/mixed; boundary="2qAMkRijLEsJJuIbD8AK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614343367;
 bh=EFmJGYFhrJfc+gRulbp26Pe8YJQ0K30nOhcCiRvBr8s=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=W6gqd7fOdIvWVp5JhPDGNNimZDKGFoLRyxlllEWJE5f/vQk+9xF/3Jc/ZwKBxk1miJV
 QCg2XN4Wy06jW8AArX1eIaDWiwDYulAUEVxQWjTs2rwIPPVRxpZtQgU8o1RsuPBTs6RIu
 s9IKdsCVSw/04LiHeM64D08UUuYfF1LEAjM=

--2qAMkRijLEsJJuIbD8AK
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Kudo-san,

I'm sorry about this.

I think we can disable some DRM drivers, but I haven't received
response from related persons yet.
So, please simply disable nouveau driver.

Best regards,

Hidehiro Kawai
Hitachi, Ltd. Research & Development Group

> From: masashi.kudo@cybertrust.co.jp <masashi.kudo@cybertrust.co.jp>
>=20
> Hi, Kawai-san,
>=20
> It's been a while since we last chatted about this issue.
> If it takes more time, shall we disable nouveau driver as you suggested?
>=20
> Best regards,
> --
> M. Kudo
>=20
> > -----Original Message-----
> > From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B
> > Sent: Friday, December 25, 2020 6:28 PM
> > To: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai.ez@=
hitachi.com>;
> > 'wens@csie.org' <wens@csie.org>
> > Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> > Subject: RE: hitachi_omap defconfigs
> >
> > Hi, Kawai-san,
> >
> > Thanks very much for letting us know the current status.
> > We will wait for your response, so I would appreciate it if you can ke=
ep us updated.
> >
> > Best regards,
> > --
> > M. Kudo
> >
> > > -----Original Message-----
> > > From: =1B$B2O9g1Q9(=1B(B / KAWAI=1B$B!$=1B(BHIDEHIRO <hidehiro.kawai=
.ez@hitachi.com>
> > > Sent: Friday, December 25, 2020 3:34 PM
> > > To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <=
masashi.kudo@cybertrust.co.jp>;
> > > 'wens@csie.org' <wens@csie.org>
> > > Cc: cip-dev@lists.cip-project.org; cip-members@lists.cip-project.org
> > > Subject: RE: hitachi_omap defconfigs
> > >
> > > Kudo-san and ChenYu-san,
> > >
> > > We are sorry for the inconvenience.  The confirmation will take some=
 time.
> > > If you'd like to solve this issue quickly, please disable nouveau dr=
iver now.
> > > After the confirmation, we'll send an updated defconfig.
> > >
> > > Best regards,
> > >
> > > Hidehiro Kawai
> > > Hitachi, Ltd. Research & Development Group
> > >
> > > > From: cip-members@lists.cip-project.org
> > > > <cip-members@lists.cip-project.org> On Behalf Of Hidehiro Kawai
> > > >
> > > > Hello Kudo-san and ChenYu-san,
> > > >
> > > > Thanks for reporting the issue.
> > > > Including nouveau driver, it seems that our defconfigs have some
> > > > unneeded drivers.  I'm confirming this with our development team,
> > > > please wait
> > > a moment.
> > > >
> > > > Best regards,
> > > >
> > > > Hidehiro Kawai
> > > > Hitachi, Ltd. Research & Development Group
> > > >
> > > > > From: cip-dev@lists.cip-project.org
> > > > > <cip-dev@lists.cip-project.org> On Behalf Of
> > > > > masashi.kudo@cybertrust.co.jp Hi, Hitachi-team,
> > > > >
> > > > > Last week, CVE-2020-27820 [drm/nouveau UAF] was reported by the
> > > following email.
> > > > > https://clicktime.symantec.com/3HW3CdVzyukGSgx2iFmjhKS7Vc?u=3Dht=
tp
> > > > > s%3A%2F%2Fclicktime.symantec.com%2F3Hrgtrrm6ninbLpVgrZpbS37Vc%3F
> > > > > u%3Dhttps%25
> > > > > 3A
> > > > > %2 F%2Flore.kernel.org%2Fcip-dev%2FCAGb2v641%3DSr
> > > > >
> > >
> > fdDh9CS4fwWVrfuCG2O2oni9V_QsVJEza%2Bg5mRg%40mail.gmail.com%2FT%2
> > > F%23
> > > > > u
> > > > >
> > > > > According to the kernel team analysis, it seems that the nouveau
> > > > > driver is enabled in hitachi_omap defconfigs for both
> > > > > 4.4 and 4.19.
> > > > > However, the configs are for OMAP platforms which, according to
> > > > > our
> > > understanding, don't have PCI for a graphics card.
> > > > > So we think that the hitachi_omap defconfigs should be corrected
> > > > > to disable
> > > the nouveau driver.
> > > > >
> > > > > We could be wrong, so please advise us. Once you confirm it to
> > > > > be corrected,
> > > we will go ahead to change it.
> > > > > Best regards,
> > > > > --
> > > > > M. Kudo
> > > >
> > > >
> > > >=20

--2qAMkRijLEsJJuIbD8AK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6200): https://lists.cip-project.org/g/cip-dev/message=
/6200
Mute This Topic: https://lists.cip-project.org/mt/78995356/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2qAMkRijLEsJJuIbD8AK--
