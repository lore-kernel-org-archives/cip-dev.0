Return-Path: <SRS0=n9fc=BB=lists.cip-project.org=bounce+64572+4954+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39019C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 02:02:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DC120787
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 02:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KzikN7/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DC120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4954+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id quRmYY4521723xFgIopYNkxw; Tue, 21 Jul 2020 19:02:12 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.10396.1595383329014562524
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 19:02:11 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 06M226VL015687; Wed, 22 Jul 2020 11:02:06 +0900
X-Iguazu-Qid: 2wHHWzHtR7bBipSubd
X-Iguazu-QSIG: v=2; s=0; t=1595383326; q=2wHHWzHtR7bBipSubd; m=FdwyS7kTat567Z/+q5xRdEjDkbciGwGndM+3OZo5N9M=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 06M224HH030478;
	Wed, 22 Jul 2020 11:02:05 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06M224DO018877
	for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2020 11:02:04 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06M2247F019925
	for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2020 11:02:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0s1Pul5VFFEJhAniRsFGfcOYfL0E4Fa5wWyYeRXutZ+j0qZjZx/4AoQ/mB/lU8kdCNhAfj+4q1j98AQvU41Aoyxn0Qsl0BYZoYpLRrCrDtHT+9yZjsfw79wEWupx10R2/Vh2M4uVWqbJwnTqbpwpPBiGrMNKVcVqlMs/cVtaWhNcatgFWUOteFoRn7bXskovEsqNsNaZn3kc1ss6HDjx/0/F2E0YkeecUeb1E9FOK9JxM/JJpi4VO2kfYQemET7mnF9SGTSUN0dUAXv6oouz2RsmLbudUStV/aohIHgkceE1RcUGFip4eaOMCST3fJ5Z2CNLi1xPUS1rtK2dO3gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/S2AOU7GcWrvwS02/uZ/CIx981ZwiwRrkai8WLD9bI=;
 b=hHBkzst94rEegz5pnMq5A8XY7kdxdK0n+7VYhLSf0IY/3y3UW1IwrcwJFTFsWrt/VvulmWC06h0mr4xBzQ9vt5zHkNVxsRjxJNT8CgSoZd/TYfWLVzmKEn4JPjZy2uouA9d48VTapJlnWaPBZa5uVK6KdIvWiCb6QbXXl/B13jRjikKFvd3WDxqPlrqrpvTJYHbESIGMlSHqX+nob7XSWDScyzyLPLf1HIEsX9Qi2217DefX3yT/bmBUM+sYfRVc0YtQDCAf2G4n3jHsXDWjz5P5iAuKQH2cEKJI3lBgwXWUnreYmOfU274CAzLj5Wn8rT+zmwtO/1dobLQW8OSuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Kindly review for kernel config changes
Thread-Topic: [cip-dev] Kindly review for kernel config changes
Thread-Index: AdZfLRya8AsrLlY1RdmzI8gvGsZiWQABt3D7AACO7eAAJWBSGA==
Date: Wed, 22 Jul 2020 02:02:01 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20536E3ED58AC92C3901B931D0790@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
 <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>,<OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23bcd1da-8aaa-4372-dca2-08d82de33963
x-ms-traffictypediagnostic: OSAPR01MB4739:
x-microsoft-antispam-prvs: <OSAPR01MB473972303E64082CC56B573CD0790@OSAPR01MB4739.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GBh81eMPZUdDGQw1rlNBo62nQVqeXn/aHiysjunJPU1DNbmjHQjhqBHEK2NXD+NOTIuU2e9sI81azm/XRzxzaz9+YNrbHi76vVbZ79GP11dVvxcOAb4bZym5fjOZrI7QK2SysM3VyAJESweCpwEj/9q4hBkaZyEiDUhAh0ZWCEd1IOKyDuduyrFTnv9aetFhWQovY37yPcLrFvcoDJAY1Nzi0/35N5J7sBm1j7gOyUnJprnMdmxtUUXEo+/Pa6Jib8oH+UUEtEXg7SEkQecpSZFhePSUapP+MZMD+A3bGMauKmaZxupspndaRC0Xu07kk7upng0Ye3RohTO83jA8+X9z9AAff4UX8jaqO+AOr2uwpY8eS+8dm6ZsLYqQvSDH1q9Zu8eFdO3N8eHVgyNvgyKHzsCGdc+UYx7qAVEZYg6U0Z5xBCItqGBtALeOkjq2sZ+rv9186wWb11sXQbOwxA==
x-ms-exchange-antispam-messagedata: LK3H9HPYUq/B/0N5tlKMF64r/E4S2bXLT3eRQzx9saeOyq+AeXQ4O/VRBtmp9QwJbwTR7KI/DWxnb+r07JGGSHmvFv6CiTZduJns5fWuCOYAFF5iBoZKaG9Bzs6Il/9P+B2qtVSinVviuvcj+egrQKF42WbEazJj99wCkadIOaAvkFCXmNbqH20XFpg4IWCfGUUBkgfjbpfoLqthg3nc9hObDSJTs+LYzDjEGLMGfal1MaoWShzF92KwDrtRI7JpY3yo9h+pW0fHMi8XBabJ18hRX837W2wWMw+7G4v3TPBMXRWA9VsyIRogonpGHm5LUytwKDqO1Y2FczKJVPIO7V0PgORhVI8gCb1Aq0fb7R7VZDYHW2HmCtZVtFEH/4pT1K553qokj+aGvWo6VXvN2VoilHzP/ss7pVzNFQJBehubJX9ywM5YjqrH+022R0OlL164B/2HAuOu94q4MFDDCQGSKXINdkX+kkjcWNlu/MM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bcd1da-8aaa-4372-dca2-08d82de33963
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 02:02:01.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f54opXTVXiKURFIlIU8JBo7Liy4oCgiN6G+lPGDP6SXLJTYRcbdQEGW/+X5/xCylplQI/FVW/RysKWfv8/b7LR1NjyC7GwMKZ/T003vSub0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4739
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WyBMOxY7sRol0QOSXJJkXA4fx4520388AA=
Content-Type: multipart/mixed; boundary="CoBHrUXmow37F05wiSY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595383332;
 bh=RpP7xn0+uQi4g6t/Jsqnl4URr5WHIMNk2z+k+pCN1MM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KzikN7/txrIjGQbw6kIthGvxiGQKpNGFagWeoRyqtJ/M5BZnoVUC5nmJSaDGlzCW+K1
 93zGrwGQ0jRHhmCLddv94/ykSzjErVUPtGwO0cveyZRXWgIYdm9bpxVEY8ZnETpkm4iW2
 0YbWAwU5MOylvXHXFuvPKUsuCb1x5BwKx5U=

--CoBHrUXmow37F05wiSY1
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

Let me check if we can use the cip-kernel-config version on ISAR and remove=
 the one in isar-cip-core.

I will also add nftables as a fragment to isar-cip-core until you tell me t=
hat it needs long-term support. If it needs long-term support we will have =
to move it to cip-kernel-config.

Thanks,
Daniel

________________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Kento Yoshida <kento.yoshida.wz@renesas.com>
Sent: Tuesday, July 21, 2020 5:40 PM
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Kindly review for kernel config changes

>isar-cip-core and deby share cip-kernel-config configuration files.
>*isar-cip-core still has the configuration files there but conf/machine fi=
les with
>USE_CIP_KERNEL_CONFIG =3D "1" do not use them anymore.

I see. Thank you, Daniel.
But, I'm wondering why conf/machine/qemu-amd64.conf doesn't define USE_CIP_=
KERNEL_CONFIG =3D "1".

Do you have any information for this, Dinesh or Venkata?
I think we should reconfirm to add these configs to https://gitlab.com/cip-=
project/cip-kernel/cip-kernel-config/-/blob/master/4.19.y-cip/x86/cip_qemu_=
defconfig.
Or, have you already confirmed to build the image using this?

BR, Kent

>-----Original Message-----
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beh=
alf Of
>Daniel Sangorrin via lists.cip-project.org
>Sent: Tuesday, July 21, 2020 4:57 PM
>To: cip-dev@lists.cip-project.org
>Subject: Re: [cip-dev] Kindly review for kernel config changes
>
>Hi Kent,
>
>The configuration should go to
>https://gitlab.com/cip-project/cip-kernel/cip-kernel-config not isar-cip-c=
ore.
>
>isar-cip-core and deby share cip-kernel-config configuration files.
>*isar-cip-core still has the configuration files there but conf/machine fi=
les with
>USE_CIP_KERNEL_CONFIG =3D "1" do not use them anymore.
>
>Actually that is a nother AI.
>
>Thanks,
>Daniel
>
>________________________________________
>From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beh=
alf of
>Kento Yoshida <kento.yoshida.wz@renesas.com>
>Sent: Tuesday, July 21, 2020 4:12 PM
>To: cip-dev@lists.cip-project.org
>Subject: [cip-dev] Kindly review for kernel config changes
>
>Hi,
>
>The security working group need to use "nftables", and it requires to add =
the
>below kernel configs to work.
>Before merging to the master branch of "isar-cip-core", would you kindly r=
eview to
>add the below configs by this Friday, everyone?
>
>--- a/recipes-kernel/linux/files/qemu-amd64_defconfig
>+++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
>@@ -351,3 +351,34 @@ CONFIG_CRYPTO_DEV_CCP=3Dy # CONFIG_XZ_DEC_ARM
>is not set # CONFIG_XZ_DEC_ARMTHUMB is not set # CONFIG_XZ_DEC_SPARC is
>not set
>+CONFIG_NF_TABLES=3Dy
>+CONFIG_NF_TABLES_INET=3Dy
>+CONFIG_NF_TABLES_NETDEV=3Dy
>+CONFIG_NFT_EXTHDR=3Dy
>+CONFIG_NFT_META=3Dy
>+CONFIG_NFT_CT=3Dy
>+CONFIG_NFT_RBTREE=3Dy
>+CONFIG_NFT_HASH=3Dy
>+CONFIG_NFT_COUNTER=3Dy
>+CONFIG_NFT_LOG=3Dy
>+CONFIG_NFT_LIMIT=3Dy
>+CONFIG_NFT_MASQ=3Dy
>+CONFIG_NFT_REDIR=3Dy
>+CONFIG_NFT_NAT=3Dy
>+CONFIG_NFT_QUEUE=3Dy
>+CONFIG_NFT_REJECT=3Dy
>+CONFIG_NFT_REJECT_INET=3Dy
>+CONFIG_NFT_COMPAT=3Dy
>+CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dy
>+CONFIG_NFT_REJECT_IPV4=3Dy
>+CONFIG_NFT_CHAIN_NAT_IPV4=3Dy
>+CONFIG_NFT_MASQ_IPV4=3Dy
>+# CONFIG_NFT_REDIR_IPV4 is not set
>+CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dy
>+CONFIG_NFT_REJECT_IPV6=3Dy
>+CONFIG_NFT_CHAIN_NAT_IPV6=3Dy
>+CONFIG_NFT_MASQ_IPV6=3Dy
>+# CONFIG_NFT_REDIR_IPV6 is not set
>+CONFIG_NFT_BRIDGE_META=3Dy
>+CONFIG_NFT_BRIDGE_REJECT=3Dy
>+CONFIG_NF_LOG_BRIDGE=3Dy
>
>BR, Kent

--CoBHrUXmow37F05wiSY1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4954): https://lists.cip-project.org/g/cip-dev/message=
/4954
Mute This Topic: https://lists.cip-project.org/mt/75699231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--CoBHrUXmow37F05wiSY1--
