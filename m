Return-Path: <SRS0=v7BS=JZ=lists.cip-project.org=bounce+64572+6399+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBDC433B4
	for <cip-dev@archiver.kernel.org>; Wed, 28 Apr 2021 23:54:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D146143D
	for <cip-dev@archiver.kernel.org>; Wed, 28 Apr 2021 23:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D146143D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6399+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Wrz2YY4521723xv8EXDgReKc; Wed, 28 Apr 2021 16:54:17 -0700
X-Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.web11.4819.1619654054116714265
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Apr 2021 16:54:16 -0700
X-Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <masashi.kudo@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id dIxF05261A;
	Thu, 29 Apr 2021 08:49:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH53vcLrm8L452ggzWig92GSJAluATjqVeo5c13pWb5phvtgRuvjeMXUVk00uNObuUBrhOgWwaTVWzXYLFGg7zNwMa6KgWObgJY8ForOQ4Js3nXekMTNCmpVwL5/UlzWsoMdae18UCNIeMgcDNXlMAwf04VKlCIAXPQaJUMIu7joYhgzPU9Gx3ZxWiDiTTASPP2Ghj95htd2/ygiVud+jmZPEIOEcfA5fjE9oQ4y/3ZBIFfKFtmTcG2jqpyi3A23miAGcXEhBRmi7u9y4jTAEC6ULA/jzk1QQ4NUjZm9UZHKjrbwl7un8Ejjzg5b42HU8V+8q8lvHEEiEaS95tPhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3iOrClagPWwte06522cTcxzK1NdgOwPDlcGXTKxW+w=;
 b=UYsrlyb0lvRqnAq+IF0l0/is+v9CQ7fy4Zdw7aU6MsyNR75ocV1g0/CLpSACLh/sxF4Be+Ecr8laIx97YmRuqLYmYbbWT/gboQBJ+ZpxKHg8Bmd5bfUJljXtL1h/hxRsuzep8c+TT6TV/pYn+q0yGCJzeKkD472tmFokrqIuTRU5OShpnwvP+yDVHUyHU1lKBwO3sDyCO4ByL4OEn+B3PitXLqXWmN/QnSloSzRhUbyA8pHBWABeEOBKzkFy0W9Y69s9mVAUc6gT7Gu4m+zSD04OeuG3cEqQgxtTqG63Rx83z8nf2wcVIVj64CRbsICpbMgA8GuBMjYIELAUSy2IBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB3823.jpnprd01.prod.outlook.com (2603:1096:404:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 23:49:02 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::4cee:d78:d8e9:8a0%5]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 23:49:02 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] NO IRC meeting today
Thread-Topic: NO IRC meeting today
Thread-Index: Adc8iO8LLm6odETESvmUSLjN0njvVA==
Date: Thu, 29 Apr 2021 08:54:09 +0900
Message-ID: 
 <TY2PR01MB4972CF135C4C1F335B1EBB77A0409@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8e8996-585f-49cd-956d-08d90aa03367
x-ms-traffictypediagnostic: TYAPR01MB3823:
x-microsoft-antispam-prvs: 
 <TYAPR01MB3823CDB620A9C9A842825A2BA0409@TYAPR01MB3823.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 dJNbJV3ctFcCw9M4KdqYQ2/qtJQHDf8X42QZsWDwh5vdOpsiZAvCUVKU7YLe282oIgZgx8LBfHO1WJkdXF6ePRGnJlCt6DmSyENiCaJbx1sq2R4O6gBoVZUk2esZw8Zr8d/yipLEUxdWvyT0OpB9vYF8ry5dI6ecOdgarQ6mEzJZMKu+1jjoFJmQ2BxWI3BOBtFakwbBqenhavgDU2uIM7KpAhtCyK2nmJZ1JFI5zhx1Hd1e3D0aolnHiwAbIXHWBfY9YJODLGBIFAjysHUcjZmtFgtbypBieXqJQvTZfk2I7mAiKC3Fr0ikJc1UjUOSnEYdReTYZsqOtUow//4tA2yqwkkzuoKExTHdKdug7YXh7S0qYYZ2uwZmsuZefnN4nYYr0kHEPPmooZoT5TkigmOY/RzNN5eSHdeXgrkKIcbFwtlPtA1WN8XQClNV3B815HozNHDlkFf14pZH9Q4c8VuIVE0EcSl73vymniuayqNx9eu1ladQTg8ZPfhIQnvSC8RjCFtya/6KUKluXUszi88pMKGlTS4c3XXpLrmrWOh1p9YU97TsbSDrBwUUSx+3CBpn+I4FqVWqhi6z5ZZZLwOCsDmQb5DBx/cugJXhbj3CHatsOVF2cS/mHqNbECaF2q9RUJPJg64yDm2DtYzeWKmf0PvjEPbcE0O3ITrvLcQ=
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?UjJ0eXZ5TXp0cGo1TE5oRzQrODFFTVgxMGhVdXFZOHRCbm1vNHovNmIv?=
 =?iso-2022-jp?B?VVpCdE13YTZmK0JpR3lhSEJQbXdmODhJb20ySkIvd3YydFhreEM3amd0?=
 =?iso-2022-jp?B?Ynh3d01lT1A2d01wek02OTNoczMwbzRHK2NZa0tKdzUyRUwzbnpXd3Bk?=
 =?iso-2022-jp?B?dWJwTTVCTmxzbFpnL1pjaitMK0hxZy9SSFdhcUp1aUwvVW5Hb3NlWTNw?=
 =?iso-2022-jp?B?bEdlMVRNaFVnR29ldVV1emFDVGl3UEpHRVFpd1FBNDNUNGRwYXB0cFU3?=
 =?iso-2022-jp?B?SUdNRGI0SVQwWkZyQlFhRUhlaFRLd0ZDOWw4L1htbmNYUjVrdmY1bzFD?=
 =?iso-2022-jp?B?SjZseW5KZGdQM3RyWDZleGY1UU1pQWpPQXBTS2Q4YXR3VEdsNmZJcmFz?=
 =?iso-2022-jp?B?Ly9iNmJldGx2RVdWcS9vK0IwaHZtN0JhUWUzZm5nUmlGSUtBYnhBdVJ1?=
 =?iso-2022-jp?B?ZW9mRzN6ZWFFSnRWcHUyQnM4M2JocnZwdm9ZRXZoNGVyOWJueW8rVFhp?=
 =?iso-2022-jp?B?amN5T0FoVk91eGtYaWZVT0M1a2UxVWZsRHE2Nkc4bWl6SnltTTBMOW9U?=
 =?iso-2022-jp?B?aEhGWlJxN1NjZXMvcUNqU0VONlAxSlF1VnBnQWlubjE0RkhsUkFyTisw?=
 =?iso-2022-jp?B?SHZPUHY0b24yTDRvd3QxTlJtTFZ0cXB4WE51c1loTU43U1pmV2pxWW12?=
 =?iso-2022-jp?B?d1VlYloyNWpEeGowR3ViZDdCYU9Nc1FGS1Y5N0FJc1VDVmJUNm82VllU?=
 =?iso-2022-jp?B?b0IwSUlLdVZZeE9qQU4xbUhKdEx4dzNPQlJ3N3UyQk52YmhHVElnYkpF?=
 =?iso-2022-jp?B?K1gyTnpxUkdWbGFsNExqdndGYUV6dTgxYzV4N0pod1dVelI3WWwzK1ZS?=
 =?iso-2022-jp?B?OWY0aHdIUHFBcUVaNTlZdmxQdmNSQjl4ejVhV3VweG53Z3JwOHVZeS8v?=
 =?iso-2022-jp?B?azJpR3I2d0JzaU1SRlo2NG54UGo3dmUrT2xOUnNnc2NMTlloVUV3QlZs?=
 =?iso-2022-jp?B?WnBSUjRmT3FWYzlGaTRRVW5jbWtkVDJBWklZbTN5bE5tWGxQeTJwZ0Zx?=
 =?iso-2022-jp?B?Q2RwMkZEd2dUQkFtOGRYc002dE9KaWhUa2V3TjVRMEtZMG9oUzUvdnBC?=
 =?iso-2022-jp?B?eTNZWWZ6MExqNVFSakxheFQzQnFxWVlCVDBaNXpnUEpVOVdGSlpZK2Vw?=
 =?iso-2022-jp?B?TXQ5UFFGVkhaRW0zTGd2VTZMTzBCQlp2TDR1cHJRVnBoOG04VC9icTRr?=
 =?iso-2022-jp?B?aUJjVllSanp6V2pXVlQ5SFpCR0hHOWo0MzJlRkxmc2x1dXJqQ0RVWFg4?=
 =?iso-2022-jp?B?dzlVVHdETEdQYVJuWkNGRUZrQ3VRcTJZZmlYTWxRZjNHRlRsZUYxVlRM?=
 =?iso-2022-jp?B?QytNc1UzWkd0NjdUNnZmcHIreE8veHJjY1l2SStkT3VhUjhXa2ZPRXlv?=
 =?iso-2022-jp?B?SG93M0pWelVNdTJBMytOMHhkRDZpdzZzTnV6UGY2U0Z2cjR3WGgrUGgx?=
 =?iso-2022-jp?B?ZGZOSE9hZEUwOUl4T041THk2OGpxblZrVWNOT3NYQTVrYngyWW5zd2lL?=
 =?iso-2022-jp?B?cFk2MVphaXJ6ZDBwNUZ2dGRLamJFNkNTN2RlOWJCQmZOVFpyWTVkR0Zy?=
 =?iso-2022-jp?B?WlVhNFhnMW5HcC9HNjFTalI4T2RQLzQ2b0Z3Q1FYS3VjOEVFdDFLUkVt?=
 =?iso-2022-jp?B?YjZ4bXhFcFNWeGdpSW9WN0N6UG1kWFdQMnp4ZUgramJJMHU4NkxiNzBK?=
 =?iso-2022-jp?B?dE9ORExUOTJnaVROUWJldUMwcDVaejloUjQ5RDJHaWFteEY3UUppMUZ2?=
 =?iso-2022-jp?B?WkxLTW9nN0ZaOEZ1V3VvY0FCYmpwV3ZkY2U0ZUpjNVdMbDJwUitiajFv?=
 =?iso-2022-jp?B?Nlp1TVRXVFhoNzNnTk9zQWp6TldjTTcxUXlIWkIxSkJ1WUFwazA3K3BM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8e8996-585f-49cd-956d-08d90aa03367
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 23:49:02.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkTaDDab95H14w1mI4ayCoQvGsUOrqFtITtUBtrbpWauiAd2lWKvbHlwqFk8Q7gNISjmy6vlXmXSi82UmSBHk1cVhiQlFO7lsBnC/OdenXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3823
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: U54xsWupeMAs4oQ3jzPJKwwzx4520388AA=
Content-Type: multipart/mixed; boundary="xYxnMZelF9TCVaENI89Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619654057;
 bh=pdYefHPYS0yvSgiXR92uhnkuHMsPv8zxBsmD3UTz3vM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=X3so/ZPSR9BkYvklp67l45ybSc0xDFbB4L9s6p5PVQjNsw+xzRkYYbiaBGX/FtAvByl
 Jl/vXoa+QeIQRk4hNzzEmtaAnAGUQs+RoZYmXcCVzRpJL7bxSIsiEV/rXHotfH655EQVg
 HheFq1zUMhwbFi7kAV2zfM23IVzlU0GjPmM=

--xYxnMZelF9TCVaENI89Z
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, All,

As was discussed last week, there is no IRC meeting today.
See you next week.

Best regards,
--
M. Kudo


--xYxnMZelF9TCVaENI89Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6399): https://lists.cip-project.org/g/cip-dev/message=
/6399
Mute This Topic: https://lists.cip-project.org/mt/82444288/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xYxnMZelF9TCVaENI89Z--
