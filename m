Return-Path: <SRS0=npXX=AV=lists.cip-project.org=bounce+64572+4919+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25DC433E4
	for <cip-dev@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854C5207D0
	for <cip-dev@archiver.kernel.org>; Fri, 10 Jul 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WydqmHDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854C5207D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4919+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id X5rCYY4521723xfLJjGS0WJE; Fri, 10 Jul 2020 08:15:20 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.102])
 by mx.groups.io with SMTP id smtpd.web12.13198.1594394118249089553
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jul 2020 08:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUtTHAuoh5NAV9Vrdlv/t7t0UViu9nA1QahsGpEDJlT16M/9kbdU6zVXnDth8gsxNUVD6A9EfGHoV3s8hRRAb7fd9h6zKXHvzEduPnHfs1kOwtwoQEJ56Eftr4gbcN3avJJhknwYav/a71Gx1es8LaD55oVYDpGHYCz9JwzCFVN3tp4Gf7/UbN35W8484cZwLo70yN1sSVyHvGSj8HlPnCofStgnj68aRwTnolr5ydqoC+V53wGGogjMSRn8XbZr3xj6kyxxA5rRBUC+GMfCU6ZsiMZsnsY6zuesOiAc+ZjsX6jKUmpLABd91PWUcLXtpCLncMh71P/XDP5M7Aou6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxdii1fXDc5zWSI+KGeW5aqRM6N19oq5ExpnpDrc/IY=;
 b=m/CMaHQVT7XYX+VxLCXCZXRG6vVWI4hGoR2pysaoqom3K2ZFxcfP484D1+N+RaqRF7oU9OX2I5LWMtmOwjEJnXB7ciR47Rn8UP/XnTXn0tJHtoV2dR9T+72rcor3eYl+ZC5eVE6XizIDIUbvT//X5IfjMats4tEv3xsx29fHHscsuShwJWSnVxn9JCq1wQD1xZiwaZiQav09lFEGbErFVWLLSRwHfF6ara/H3lvr0yrPPLiN8RP6ZDzyLgeIVIWd+DzIj7T/uETlFz86nH1azUWM6mGrmFW40Snka3TXab1TBxeRcRKhsAh3ow1giR4i66CrUYpBhtx38j/gHiDqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB2488.jpnprd01.prod.outlook.com (2603:1096:604:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 10 Jul
 2020 15:15:14 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::c44c:5473:6b95:d9fd%6]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 15:15:14 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] KernelCI Community Survey Report
Thread-Topic: KernelCI Community Survey Report
Thread-Index: AdZWzMMv+iYmELf6QdaijX2rSuz94g==
Date: Fri, 10 Jul 2020 15:15:14 +0000
Message-ID: 
 <OSAPR01MB2385CAEC00E47C13EC676004B7650@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3f63d53-4303-42c0-9ee9-08d824e40c1a
x-ms-traffictypediagnostic: OSBPR01MB2488:
x-microsoft-antispam-prvs: 
 <OSBPR01MB2488AC55A1A3A3A82A0796C5B7650@OSBPR01MB2488.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 esr4j9xzvhko8j91ME1IM7w2GJof19cBW+GXlj6SmIhwv4BdYLfHwl0KmdkDyB7GSiFn8BvuSEsFN6heGIq2MAbKk0f2yAiVChrcv4FfFsI8Kq4iQR7ZwGhEATwlwt7yDU3ovPjgqhsUguSbKfkJ820G50BTSvn5ikoe5rolhF2zbZiACAn/Eg8NTvIOmPrHA0gA+xaah49/ydTZ8FvSDSahQigB51vLWSL/G2j85PTNLs4zKktn9rXC5suvEQD/+Me0xo7CsiVaqUYmC0KFVTVRW4jzyJCHXyEgiGvK+TXPjSTx1iKtSTHIHWzekKOTX67bKgyCtRIm46R+8Ip32wLyrRzHczfA2BfplKXilG6oUvk97pEPgxKu6UK0BjqSO+hYOCKiUuS5hjI+b2rq2A==
x-ms-exchange-antispam-messagedata: 
 LnQugl2jjPiA0C7gVdEJC6+uZlG0yVD2GL32rcnOZg0+mSin6lRLU2uHIQTcJb0jq9BM/mYG8A2YIl6QqQMRud3wDrZOJcjs1aqeA640sbHZR5b/TouW6ndv7T+YJ2w8W04uHhKuKGWHRgIOfTMFXK6pFwxbYQ04aMU4AXV25zbTwXaJd75fpd6BhsIpBKT+Pv8d7yguUf87XA08oCCDp9DZZkMIo/8XyQvCpBFClVloMqw8LDjANccLuSzSgHIPxi0RPGFZoAN6P3CgLYwnBvuOUzsO7cyPLa9LwD1pE64znKMy13ketUfLsApfsFYtEAJfVmfttncujRcA+axqx492uHIkKQKi3Rk34Hj8vBh4csC53m0i7ifhI/2puIHncaXOv6rrhW73YWVOF6QMvg3NLcrArLQ10IwsaTdnfTtzGoC6+gJe8vElDGbi0lqZIQzPYOmD1WopE6AhOD6uM650Ws3NwsepcBx0TQb3t4NCQfPqF+w/PFELUF/o9P2D
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f63d53-4303-42c0-9ee9-08d824e40c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 15:15:14.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1vuL193/gZzpsjJLuPVIBwg17m8DK+cYA+K11/AeW+vei3lm/S/c77SrXRVton578OcFeUvxbUN+Zc0sKFYPnFJ4UUF2Ay712H3k7yki5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2488
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZrWk50AUDrXNrAFkdt26IZ6Tx4520388AA=
Content-Type: multipart/mixed; boundary="bphTs9vZZGSDxsKzezWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594394120;
 bh=SXuRk/+WyUP5iGgwH0F/9GtSstV5++AoSN3D6rxtMo0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=WydqmHDko3h8WbM4pyQB69GxKEiI3AawHPDuBpk65schuATeKcq1yx1wa/LcPOXAUed
 UOAh1r/wk3Ob0V8DripGdhDtxSdZlCl47wc+4cpK8tQKguyU5yuSToYrJhDGLvHzsQmeW
 4Xb5pqRbrQsTKeyMdvc2DlO8xFQnQMR5U4Y=

--bphTs9vZZGSDxsKzezWL
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

If you're interested, the KernelCI project have published the results of th=
eir first user survey:
https://foundation.kernelci.org/blog/2020/07/09/kernelci-community-survey-r=
eport/

Kind regards, Chris


--bphTs9vZZGSDxsKzezWL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4919): https://lists.cip-project.org/g/cip-dev/message=
/4919
Mute This Topic: https://lists.cip-project.org/mt/75420219/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bphTs9vZZGSDxsKzezWL--
