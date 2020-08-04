Return-Path: <SRS0=MaOx=BO=lists.cip-project.org=bounce+64572+5085+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F36C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:12:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A304207DF
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RO6RehZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A304207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5085+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RhF6YY4521723xQcprNczls9; Mon, 03 Aug 2020 21:12:39 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.12483.1596514356971365767
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 21:12:38 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0744CWsB001642; Tue, 4 Aug 2020 13:12:32 +0900
X-Iguazu-Qid: 34tKSwRU8G8Sy2Fuzt
X-Iguazu-QSIG: v=2; s=0; t=1596514352; q=34tKSwRU8G8Sy2Fuzt; m=V+baW9uC0i7bp/vFmAlf9kAB1eWIL5vVqHEwFjMUnGA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 0744CUcs006148;
	Tue, 4 Aug 2020 13:12:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0744CUMf013559;
	Tue, 4 Aug 2020 13:12:30 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0744CUZK027662;
	Tue, 4 Aug 2020 13:12:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOvH7yU2lwiEeKoIxHzz1DxImlzJ0LTGRYeXn+u21hc2ub89axrg+sHOJiv5n2a7+HGC+SHUTLiYM1bqeiJAJgaYx9r9Vg80uJ8eKNn7JvsBqW4tkayxhudk3tU08EORPx8AzoHgrNokkovi3G7tfda8VEGvRTFdYCQN5nFU//sS/I2Th91V5kBDLPA+INFV9lMASSaMOwDo0473axX+9xQa65yVE6Ftbn5X1+bE3PphM9ktzwQIXXFIwrP3P3iWW4IOavQ/8WC1HXUwXXwdzjqKO528PKctdxOvNDXeFwB3HlVMK0+2RKKyaWzHjmpAIo6pjjLKzg/bnwiSd23xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qv3aqqfvjn6ZDeHGsZXYu7/KTovsVfrWxv1oW0PvzY=;
 b=geDRQiH53Fz5IOhgueOQpo72dFsoWRZ5kIQ3RwI+GCm2IWhTWCl6rr4B6MyftTt0Fp1xjjHVIRRKTGF24M7MJbLXmrJqVqXBJG288xUg7nzhzH26vBp0XTCMpjepBvBCYClHqg1clsxKYYhNybs6f4ILjcv4n0XARslCVALo2AM9HEPnaDVHDSoOIdrNc3ImV0PeFBQDgfEE5SKTV6Eazse4AWwVoCPQBApfjA2nPUsRto3m3ToCv6et3luuMRTpZWiAIOZor0+ey35dFlE4wsyamQ29nEPnEy1tghdn3t6X+3JazDO+Xetf2mUxWmyEC31w5Bd07DfFz/LUb4Eaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <kento.yoshida.wz@renesas.com>
Subject: Re: [cip-dev] Kindly review for kernel config changes
Thread-Topic: [cip-dev] Kindly review for kernel config changes
Thread-Index: AdZfLRya8AsrLlY1RdmzI8gvGsZiWQABt3D7AACO7eACt716gA==
Date: Tue, 4 Aug 2020 04:12:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20531E87B279326754C284EDD04A0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
 <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a15eade1-a840-43f7-ec31-08d8382c9a29
x-ms-traffictypediagnostic: OSBPR01MB1654:
x-microsoft-antispam-prvs: <OSBPR01MB1654D28E4A4E233BDFB0837DD04A0@OSBPR01MB1654.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l4Zup7VpLk+nRO4gWt5GPki5vhQ6f+JpXEkOT73a9MfbmYEfOuD9MfbMrnNoCOIDEtEFXeJ3KCznWPWntxioZxsrTFQvYNdikWQf0OAo69AvJEmKVJsVxUeF46xscCZNYj17XiF3lZwdVSNTBLYTDAH0E/CC/6Qc2bI25Hwn1Un1q5m+Ql+1xx1u4S2QR+olip7S/Jkg2gP1MSg3Zm0FXH5HbvCqGCOFW4dm32zuYpQ4tT76jX7TlklhYaY1vq2oJL2+IJNFWGPj/5M4hEWwpWFnzveqrhU8pfqjesc5ZfZNwp7Ucbk6dCLqtMFDn9R+OBDupbRAQdP9/PwR9Bm49e0FyL04Qc+C/8r1U7hepzrx53QU5IrZY68CL/9rldRpTWek9+RSy2JFJ6mgCFytndOT9p507JYURtNmvhByJBUScANInIXbS38kckzGULbdy59DnocbjOWXDSSL5vhFeg==
x-ms-exchange-antispam-messagedata: DncqSMTieRf0y00FGl65rJ4JMKJzct6v+UjRA1SZw/g/BWL5S2TsLO9mUzKud46U0LbEN3n9HJ9Al9T3aZoO/cSHrDOyJ8fe0A5eE+W5p//jvBspQGJ7Vd9l7zNskYdu0hiUWv3rnKT3cVDwTtDsU3Um+7cOczpT2PXBvH8vudttUP0nxLUA28Oy+iPa951V+ZV/RLNG8tcwMwiSWsQGRi4Y6enUkUXQUo2caOo84ubP9OLNT2tbpZqCeVS/TMOulfP2PnoaywKuHclwHRxczf7TX+UOg7jAbd4R7cNfiiTSwvwKJwoFK2EUmL87AHDJlfH5CsAbS4PkibbYq8ZF7nQg2aPT02C5FIfIEnspIc5YOIHg4hIey4GhlvrJiYQLyRHORc0MlbD/DSKNkPz7mu/SUIRQ94MKS5/LV0ZsGgm2B5i19n8ApAKCdG9fncf3aYf26HVHNDnWFWytVIlFpQVS0Os23EtY52ZJq1vr7PsDAwRNrFF6fvOImNyKLcgIBYDbYEyiSlwzrjnNrXeIV44YtGMf+N1ScwRn2yn9oMp3pJssrujC6OTg8TjATQ5Q3pNfjYscESNErLvT84PpR4gXcA2+9I/8fsULH1pMVUv39nYHlskzUfNSOrwhBjhcQzIow0F7EamWYbm8M8JlRQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15eade1-a840-43f7-ec31-08d8382c9a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 04:12:28.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KNm3PMbQ2GVLvZMGzPvT+hnbLFCwy0UvokYKpp4b9UCvwIFe5mEKaE1t/FroWcOGmbxI/zBU2GOh/2I1uuX/jAwNfL7eyYdltPLdDe+Dy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1654
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f45GI41ADLAhOX5JN0rD6XL3x4520388AA=
Content-Type: multipart/mixed; boundary="l8PK4z7g76Gmyud0lLQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596514359;
 bh=Kwhy9IEtw9359mPYoklbCsiXuVt3TK9Q3oDtkl1EDxM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=RO6RehZrS1pagBZGHQRrWKRKUJYb4XK120iQHVQas8ewwjzWF4vYf9MviQaXaxuRz2k
 Q9d0IctqWC7o7a1DyjaR3Gd6eOTNMMAXXVubINhSeSVLw1IqBkF6j7CoQQW6EtZ/Y2Lht
 yLPJIgxqHasM9n7XQeIyqRo15AYLTOeBB1Q=

--l8PK4z7g76Gmyud0lLQa
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi kent

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Kento Yoshida
> Sent: Tuesday, July 21, 2020 5:40 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] Kindly review for kernel config changes
>=20
> >isar-cip-core and deby share cip-kernel-config configuration files.
> >*isar-cip-core still has the configuration files there but conf/machine
> >files with USE_CIP_KERNEL_CONFIG =3D "1" do not use them anymore.
>=20
> I see. Thank you, Daniel.
> But, I'm wondering why conf/machine/qemu-amd64.conf doesn't define USE_CI=
P_KERNEL_CONFIG =3D "1".

It does now.

> Do you have any information for this, Dinesh or Venkata?
> I think we should reconfirm to add these configs to https://gitlab.com/ci=
p-project/cip-kernel/cip-kernel-config/-/blob/master/4.19.y-
> cip/x86/cip_qemu_defconfig.
> Or, have you already confirmed to build the image using this?

I would prefer if cip-kernel-config had base configurations that are later =
extended with fragments (board-dependendencies, security layer dependencies=
, etc.). However, that would be a whole new task that might take long.

For now the more realistic approach is to add the security-related kernel c=
onfigs to either cip_qemu_defconfig or to a fragment in isar-cip-core and d=
eby.

Thanks,
Daniel




> >-----Original Message-----
> >From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> >Behalf Of Daniel Sangorrin via lists.cip-project.org
> >Sent: Tuesday, July 21, 2020 4:57 PM
> >To: cip-dev@lists.cip-project.org
> >Subject: Re: [cip-dev] Kindly review for kernel config changes
> >
> >Hi Kent,
> >
> >The configuration should go to
> >https://gitlab.com/cip-project/cip-kernel/cip-kernel-config not isar-cip=
-core.
> >
> >isar-cip-core and deby share cip-kernel-config configuration files.
> >*isar-cip-core still has the configuration files there but conf/machine
> >files with USE_CIP_KERNEL_CONFIG =3D "1" do not use them anymore.
> >
> >Actually that is a nother AI.
> >
> >Thanks,
> >Daniel
> >
> >________________________________________
> >From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
> >behalf of Kento Yoshida <kento.yoshida.wz@renesas.com>
> >Sent: Tuesday, July 21, 2020 4:12 PM
> >To: cip-dev@lists.cip-project.org
> >Subject: [cip-dev] Kindly review for kernel config changes
> >
> >Hi,
> >
> >The security working group need to use "nftables", and it requires to
> >add the below kernel configs to work.
> >Before merging to the master branch of "isar-cip-core", would you
> >kindly review to add the below configs by this Friday, everyone?
> >
> >--- a/recipes-kernel/linux/files/qemu-amd64_defconfig
> >+++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
> >@@ -351,3 +351,34 @@ CONFIG_CRYPTO_DEV_CCP=3Dy # CONFIG_XZ_DEC_ARM is no=
t
> >set # CONFIG_XZ_DEC_ARMTHUMB is not set # CONFIG_XZ_DEC_SPARC is not
> >set
> >+CONFIG_NF_TABLES=3Dy
> >+CONFIG_NF_TABLES_INET=3Dy
> >+CONFIG_NF_TABLES_NETDEV=3Dy
> >+CONFIG_NFT_EXTHDR=3Dy
> >+CONFIG_NFT_META=3Dy
> >+CONFIG_NFT_CT=3Dy
> >+CONFIG_NFT_RBTREE=3Dy
> >+CONFIG_NFT_HASH=3Dy
> >+CONFIG_NFT_COUNTER=3Dy
> >+CONFIG_NFT_LOG=3Dy
> >+CONFIG_NFT_LIMIT=3Dy
> >+CONFIG_NFT_MASQ=3Dy
> >+CONFIG_NFT_REDIR=3Dy
> >+CONFIG_NFT_NAT=3Dy
> >+CONFIG_NFT_QUEUE=3Dy
> >+CONFIG_NFT_REJECT=3Dy
> >+CONFIG_NFT_REJECT_INET=3Dy
> >+CONFIG_NFT_COMPAT=3Dy
> >+CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dy
> >+CONFIG_NFT_REJECT_IPV4=3Dy
> >+CONFIG_NFT_CHAIN_NAT_IPV4=3Dy
> >+CONFIG_NFT_MASQ_IPV4=3Dy
> >+# CONFIG_NFT_REDIR_IPV4 is not set
> >+CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dy
> >+CONFIG_NFT_REJECT_IPV6=3Dy
> >+CONFIG_NFT_CHAIN_NAT_IPV6=3Dy
> >+CONFIG_NFT_MASQ_IPV6=3Dy
> >+# CONFIG_NFT_REDIR_IPV6 is not set
> >+CONFIG_NFT_BRIDGE_META=3Dy
> >+CONFIG_NFT_BRIDGE_REJECT=3Dy
> >+CONFIG_NF_LOG_BRIDGE=3Dy
> >
> >BR, Kent

--l8PK4z7g76Gmyud0lLQa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5085): https://lists.cip-project.org/g/cip-dev/message=
/5085
Mute This Topic: https://lists.cip-project.org/mt/75699231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--l8PK4z7g76Gmyud0lLQa--
