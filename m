Return-Path: <SRS0=NihA=6Z=lists.cip-project.org=bounce+64572+4618+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB416C47255
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 07:36:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F3D2082E
	for <cip-dev@archiver.kernel.org>; Mon, 11 May 2020 07:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nLxb9N8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F3D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4618+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bg0QYY4521723xfVugA78wCL; Mon, 11 May 2020 00:36:08 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.133])
 by mx.groups.io with SMTP id smtpd.web12.7914.1589182567083185918
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 May 2020 00:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSqQbGWgeu/spk7xBTNjjKWcWl+N3+PQ4BUpl93DyQZvbGv6v6KgsOd+MUg8cC+lJp6YRDo4O7GWpLKAMoI7L9uZi9cFpqQQVFn8InFweGlYK4uIC3GuwSF+u1/mov4O6q8fjIYOMt95nZJVvbO7EFf2mZ8hgnmfAQps2H90o8jaS5PjcbD+cZbRCjO5MQPOe/L80WArShuIBnP6PcbiaGSvXeTHd648eXT6gfFhIkuA2KvfiCU8qnjhl5My8bgIGJ28KKAGOhnMVdAO1yEq6cyZszKopBD+IOfyDACgbYSQ7tNd+gxYr2btz2YUpxKkDKs5/wUyd2q7011KYG7wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLmm1QwWhJyu/gXrRnSj/smA/KNHvi869O5Ps1CdTNY=;
 b=iMTc66txVru4REfZNF4itCJ1LgwzQmzVN4reTNpPnSr+velrErY/GYIOuY8K/3ZPIDbzmil/416iy1RYx7ywnHGzi4QBSVcoMu7iLRXoHqqTxq+jcffw/9iY91Xl2+RwvgTeGJXpj7tAQWlQ1E8X1nGCqP+MTJtZMFRplbsyddVQjGAgqPsmBQsLgTe+1c/WNzVLcHHe3KqF1tLGygVu3QJA5P1EFNLNDD6Dw2LdRdXpMSiygVSDzJndfQ52TWmGnE74kPy8iin2/GRo+R7Ki3T/WMvAzKq619nyBmwZ2rjpG5hvXQH5PrG4n8Oj7o/ndWqxjeH20rqEYjoyne1pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (52.134.245.84) by
 OSAPR01MB2209.jpnprd01.prod.outlook.com (52.134.237.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29; Mon, 11 May 2020 07:36:04 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::2f:ca16:fa59:a37f]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::2f:ca16:fa59:a37f%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 07:36:03 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP LAVA infrastructure maintenance
Thread-Topic: CIP LAVA infrastructure maintenance
Thread-Index: AdYnZcRegDp68xZvSZq2QGcvjQZN7Q==
Date: Mon, 11 May 2020 07:36:03 +0000
Message-ID: 
 <OSAPR01MB2385729200A0673185C54C5CB7A10@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [151.224.220.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 832e96d9-0cbf-4701-342d-08d7f57df5ca
x-ms-traffictypediagnostic: OSAPR01MB2209:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2209C9E0D7240E5257A855E6B7A10@OSAPR01MB2209.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 8b3ywGYt+hKtkAd7j8pzlGc2mzaZgIp4wHTax8mYlyV0+mZfv/HhZgWLSeWZGNaB+LEEqg8n2B5Dj3F95OHd514fSCHORdVUEze2Kt7MeHJoBVloYngefOE5UhltCJaeZkO2PAH8eYo2K4A2qACqVFg0NEpHeVX/l3YYRgTSPPzbJuhdhykB2jCJWYOQK7HGizS8dAyA9MRUyqB9iiAsG9katdDo5alP/ucVs10EPer38PNRl1GZnsSdPONOobnn7dfRy5nPTy0N8P9QX/IUFnhZ3FHe8o9qrq/29yLZuA+/pOHikoMijjb1zgO9GL3Hgc4dGMDHLTcdQ0Q/oWqUfjPTyrwFtrTG225plWFbNZddvz+ebrdjPheUlWdPLE8WPzV/xdMBPfZTYGfeM8LJJOSlj38QHHnI9b0dmHA4cafT3Cb1uX8tVZTeKG97g6BdO0Amqm2RvWkdH0h3DWU5YhqrAJ8TpKEoPSy6S3fw4DwZrr6K/bhOQRMXhl272EathKtiAV3GnwLfBEySGdu62g==
x-ms-exchange-antispam-messagedata: 
 6YddRlDsIyGUEaiMFx+j4blBN4+F1fQMrIaMWRBd8vEk3CM5KYWj02nKr34ufsVoa/RjtifSU84NXJywE9k3679hRiHAI+MgIeg6FUorUqiYmClJqdQ+al5cX/qsqaqrUXvUf858ajzPvAGy/NivR2pc+c04CUqsy02/4c4DSPeUoOW0HXw2xGYeXS1BIH1azm/w1xvnKRGl0QlGy3st/eLrh+LOxJ5Fb6/XqU4qng4O9gOAaP9LsmXOux2R9N/op1Ll/c16Fv9f9tl0cUjZImgc6nRECe4LokDeC30jRDSin5+OrPL3xf4Wrookr8q0cJr31hYwN2m/y1B4om9qUgE18QrgP2AL1FUeylpxWJh0PNPJuuoIRVQIA+9FS+F3PpSxHJ+rdI0jKapOvg63571EQU9Om/uVwjf71a5zEDy6kvrQA6phGGYPsJdb5qopcoNFMgLW7MJ1qoxqUmhLxMu2wXgF4NKmdo5LQvSMNYpesNwrHQXs3+pqsjYeWhU4
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832e96d9-0cbf-4701-342d-08d7f57df5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 07:36:03.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEjnJ4Als7VVVOOrRo6QcZi0xz7raeR8SYahtP0Zy3RlJ4+7LvNBhk3ECw3F/jlxjP8BbqssDovRWJHba6aJPQXPK7Tos/VrbfqiBsoKz3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2209
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: w48nWdgQTZpuwN9TsyL0d20Rx4520388AA=
Content-Type: multipart/mixed; boundary="4eaqNpnhXVgz2YLcfjDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589182568;
 bh=EWPLSd+21kqMutHK9r/4NobnZnPejQgoSPx5rpaHqno=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=nLxb9N8EKppbAzXdvrnhsBv9sicNdIOQ62L4XeqOBNqnFsNN299Ch4COhj27yScUltT
 XIuU6NkTdqM1j7hPfqCuPOzf6Vxjh1IcSZHe4QYoQ1GIxXe3zPfdpOhQxg1KsJEWtoEuF
 foGH1O4A6baBrjNPAosYajKjYw7SAXrsZC0=

--4eaqNpnhXVgz2YLcfjDy
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

We're going to be upgrading the version of LAVA we're using in our CI setup=
 on Wednesday this week (13th).

The LAVA master and workers will therefore be offline for an hour or two, s=
tarting from 0800 BST.

I'll let everyone know when everything is back up and running again.

Kind regards, Chris


--4eaqNpnhXVgz2YLcfjDy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4618): https://lists.cip-project.org/g/cip-dev/message=
/4618
Mute This Topic: https://lists.cip-project.org/mt/74131196/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4eaqNpnhXVgz2YLcfjDy--
