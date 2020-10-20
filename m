Return-Path: <SRS0=Oede=D3=lists.cip-project.org=bounce+64572+5628+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EEC5517A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:56:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218F42237B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 21:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="L2rnhxSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218F42237B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5628+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hUBSYY4521723xpQcfxCDTXW; Tue, 20 Oct 2020 14:56:21 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.101])
 by mx.groups.io with SMTP id smtpd.web12.2400.1603230980159439433
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 14:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PREsgdJkKfq8YkBc+4E1IC5EiI6P3ytHxM56Ln/LzzRWKjPUtlzyksONuPRdiiMZKhCaiPMsFm2xB1fOemyRiVOHnAQ42ClEFJ4OWluow29GYTHyKYOFtHgzadlKddFHGTZC/qi7uyphp9iwMj+XZWeqqvWIbAEUp3SUqHUhxvGuyuoREwcfZ1VjNOAwXt7Et1QIW/Q0Bl8YMHU7Yyyy9fBgOyRqE+ojnH2ZgvbrWYZx4ZWHCTAnorXJ2DnsP3fQT1SOCyMj+Zhg0+I5scpvSPQqmSQBas/J0tObtJqj7meVJ3Iho4q9YIJBIgxoSe5KnUYQitWirsggZzTqCR2oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcX1RA3YKWEACMaJrj6D2REiRk/y0B1P5atUeWXKUmM=;
 b=ju3Oo+t+x5UD2PyJVBxmJA4uBW+vf6jUgGORvcnSSGIUxuTsf+UUE6HMG4yyJtqESCy/wg7Dm71ZVgSvNLlcQQhenaQjUSBiugEBnhFY/Inf8Ws9B/wVvxnCYc2BYSn0jO+AR+UHR7qy1g2S8z23vAj27e+5TJDa8pMJOaH8mAZ04CLPAQtoGTXwpdqO40uBaFmIloFNROVJ0ruoY7nvbkv69I0TimU9Sb25GSEoQjCz6xh0sEa/FOCnPVBuUTd8IS3A23qeR+EJJRWbnL9ougfbmf27enM1MS4gnjMpik0Yq5WHsiuqJUM5Ap7amqDPgKFAWoEf8qGhPS7TGU+2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 20 Oct
 2020 21:56:14 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 21:56:14 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 24/50] PCI: endpoint: Replace spinlock with mutex
Thread-Topic: [RFC PATCH 4.19.y-cip 24/50] PCI: endpoint: Replace spinlock
 with mutex
Thread-Index: AQHWoKLMcmEZW4H6iEuZ4dh3fP82qqmhAhSAgAAOJ+A=
Date: Tue, 20 Oct 2020 21:56:14 +0000
Message-ID: 
 <OSBPR01MB5048F76FC81C94ED7FE1C553AA1F0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201020204332.GB29993@duo.ucw.cz>
In-Reply-To: <20201020204332.GB29993@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cdfb768b-ad70-47dd-9594-08d87542f710
x-ms-traffictypediagnostic: OSYPR01MB5445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSYPR01MB544537D312D77B918E62832EAA1F0@OSYPR01MB5445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 tIOoJKFV6pGwSXxdQ9le2yxJ73Z9dSQv21bZ6E3v3wLXX7E2EA/gQmSYyowgtDxZbe7Z9az+JlfS7+oBZhOVp6DKijK6jmq5fYA2brYzxtYGTW9jBOQ9Uwd6MK/1C1kZvCe074BwEzORO1Dheinu6rQl0lW0vmEaaUeJ4D3OEAm0+BIm4dJXMaiV1tJEkuQpmH7gBQh1F88ZZpklZkm0Hg6suyoeulbb/6Tr94Nr1btiWdVr1g8HUbRGSU/8mSYRUjNpcutoLQaSRNh314BnYk60ENGNgw+0FaQl9QUqpyDaPtQCM8E8vXwxu9jM33DP0Dk/VQGGShHdXUs8n14JAPX8L8lBslizVIKBNqCzBhbPHIrDwlf5QAngj6F9EgMD55CLco02jb8N802Cdx3t4w==
x-ms-exchange-antispam-messagedata: 
 uKhQ8+5pqqoG0WMxfbM81O9qoXq4BHnFe5pzci7NmPe1Hvfs4gxdmaRzW0ihhtvbJDsigDiTCt4HHB5LS+wObQ0+iblmAE/E5C1Ba3KMC9puvEjB6lbQrTcMohon9fkFCfAcVIf/Ir++ageE7dXIkj6c/v+Ygmxb1ctWrg1PIwo25Z/aUvAXGceqF7h6uFVTBsT7JfcAsOzErFdyYCWSO7GNgx0auidrp5Slf1/vHORNgaVpjfv4pb/YRatp0H8yB8+r9zItLCzSiF4NlDg5gvHcUY1utPBFx3Y/gpTgg3eAtMldekDHB/46j72Uvbz/QRVAcFy5IdjUCOCQvkQk9wvTcqAHIq1E9i8Za9QVD1UMQDGHYbqc6lA5C4wPwsiE+wMIg+20SOxx/9U0HHY4nCLXNet8prygVbLv+MLqyVi/74q0ONbUlqO2m3AJSOFA15APNgcZKbh65js20DV+lpjDRjA1vL6kCfP9Gj7zBFwZhJQ+1At5NsJJknwZ0TeRTY52iHHTJxr3U0JUsxtmgrS92fOmtboTt8VvaXWYwVHCPVg8YIuzMvz7Pu8BAKJi/IZtUG00Fwa1jL7M3U92IXyyEQdQvKPhRLexF6aZt/SF58ewQKbIj+DIHTmtT9j8Q5iaC4aX4AmGWaDm0y5+6Q==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfb768b-ad70-47dd-9594-08d87542f710
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 21:56:14.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TyNJvM9vJ5C6hiWiAUtJZJ6nvLJ5+HlQ//gx0UnjUL3dZUn7opw2mle14fhP+uZN56xQn+dq/3lSv9CZZNNyMu13aOW5Sg9s44CzHrsOqeXFQYRrsjJJz7d2I8OLTX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Mwpdzn9qw4QDKRgEuR9Q47Zcx4520388AA=
Content-Type: multipart/mixed; boundary="1rkq5HyFzVS73KrWHncb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603230981;
 bh=z9+QZnogo5LN6nnFMhjiGwNV55NVFP0QFlUquphxtOE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=L2rnhxSoSHt+YGguuJEoSD/CZEIwfv2ypruD1ZlrDqGyYGdDNhFM6aAFOfK0YcwDbrT
 ZsqdFRdNMvXtxkAr6rdi7BHqPrXRrX/NrVhy1TfgftaQgrGRBQfDjj4dcbUsv7eaj0aF0
 Q9bkGcQ35RDuA62mw+T/gY2buFlB835n/Mo=

--1rkq5HyFzVS73KrWHncb
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 20 October 2020 21:44
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 4.19.y-cip 24/50] PCI: endpoint: Replace spinlock=
 with mutex
>=20
> Hi!
>=20
> > commit 3d3248dbd018502f654064c78efcd2e165ab3486 upstream.
> >
> > The pci_epc_ops is not intended to be invoked from interrupt context.
> > Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
> > mutex_lock and mutex_unlock respectively.
>=20
> Could I get some kind of explanation why this is good idea?
>=20
Apart of one mentioned above other point I would add is on a single core ma=
chine mutex_lock/unlock would be good choice.

Also to add the callbacks in controller driver might sleep. For example in =
raise_irq callback  [1], [2].

> As long as code protected by the locks does not sleep, spinlocks are
> okay... (but they should not need "_irqsave" variants).
>=20
> They are likely to have better performance, too, when protected code
> is small and fast.
>=20
I do agree with the above two points *if the code isn't sleeping*.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/=
drivers/pci/controller/pcie-rockchip-ep.c?h=3Dlinux-4.19.y-cip#n410
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tree/=
drivers/pci/controller/pcie-cadence-ep.c?h=3Dlinux-4.19.y-cip#n310

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1rkq5HyFzVS73KrWHncb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5628): https://lists.cip-project.org/g/cip-dev/message=
/5628
Mute This Topic: https://lists.cip-project.org/mt/77461695/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1rkq5HyFzVS73KrWHncb--
