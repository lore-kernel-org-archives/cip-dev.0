Return-Path: <SRS0=1G4M=BA=lists.cip-project.org=bounce+64572+4945+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D213FC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 07:57:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB1F20B1F
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 07:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GkJs3uo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB1F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4945+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KI14YY4521723xHx5rRt068N; Tue, 21 Jul 2020 00:57:03 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.14349.1595318221404762619
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 00:57:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 06L7uwrL030122; Tue, 21 Jul 2020 16:56:59 +0900
X-Iguazu-Qid: 34trcFcTUYTlUuW9it
X-Iguazu-QSIG: v=2; s=0; t=1595318218; q=34trcFcTUYTlUuW9it; m=pITGUmwm6SnJ9G59u1wCl4EwYgRcFUhJ09jWMtiwUrQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 06L7uvtt013903;
	Tue, 21 Jul 2020 16:56:58 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06L7uvD8024439
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2020 16:56:57 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06L7uvnY014558
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2020 16:56:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6xz2TVT6LM9Mc8Efyo5hNXgI7cHheQUq/jXm6Pqx4mOVqkIgEidjKfnvx4tOjLWtERuVPZ7ohqUacqgdOsQzzLDKYwbMAj5sTTS2N0Q554WB2Jefx1GO/6ODvE7JDxQsli08SFsO/xrdntsh13NCZTHOrbaeUcQjNTpXVVRbfxUTm9Q3wj0DRdlOn4PYa83YI1CXemtxb+ai/5PKAOccGOhFM4pIbLPA4pgsxb8mTDczGyjd3QwfBNdTQT+qCQT72obDPk56KRK4EXPtb/81WH8EN9PmQu8ZwGFKDYOqvhmFySZVnQQTUD29lX7oAFIuU17QBdKs2cPudPFB3ob0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsrD6JsBfA+f8wZcTqP7iSDvHxPGHxvBDFjRlubyjUo=;
 b=LVczFUUqiGIxxfSCuBCOZZcS9VLuVkiRxM/I4gDNvNMl2XoxJE6OY8+IYKTiP0cqhY7exZ9AbirAHOQpWQDpfTL46sSxpDhOjzZkbiuRAa0EXpuoUEzHh9Lxizr2i2xrIhvRLdeLu4xv7BlI8jkuibAmg8AFPyPBlc+sb/xG/R+l3khbqNhU/jKGQx+Y9bYeF+4eJKCvjbQj0xhgp2sxwnLghmkwF6aPrWJEuUW4cQ5rq2Wj5wrpDFoXbUujpnr2Lcf2rdGpVXxS8NfFmyWNWPauZXwJXLa+Nz9HtJ5hN0obGxqkJ/J1qq04B+qkQaW6tbx2+I7KgE0CL+YDJAyPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Kindly review for kernel config changes
Thread-Topic: Kindly review for kernel config changes
Thread-Index: AdZfLRya8AsrLlY1RdmzI8gvGsZiWQABt3D7
Date: Tue, 21 Jul 2020 07:56:55 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
In-Reply-To: <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cd2f81-1b57-4cbb-fb0f-08d82d4ba345
x-ms-traffictypediagnostic: OSBPR01MB1845:
x-microsoft-antispam-prvs: <OSBPR01MB18454C4C8F94C28AC2657711D0780@OSBPR01MB1845.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XTPgmTRa8QPG3qlNkdOX+ILFlxt1U3+8pFnxqrDdnN6Nf4J/J5/jqjE+lyrM3iCtyTzFf3dVn97BhP06zfuWfw5FYpe1q2a2gRMdpq78tSmDN7l6U6A4zYisJ7xH9T4pvQ5P5OHNWCCT50wEMSZi2H7dfeSRytnv3JeXLEHT+X4F8AcMKzPjbw6GBWo7zzl46ScJcdsMu+7F5Xbf/fHvcU9QkhUJgw0elOzlrESqy7F5zjikf8wnBZLzEl3B6OmjjpkMbHtU0sM8ZxumZ3cIbwVr6SdbCV9YsukIiegpU/pt668Sn+8zaauPuOz17nKUzAHQN4x5Qq27X/ZvAAZmZ12F9fDGjcx6GSayy85K7gif7wnRC/daiEt4zDYBv95p6Knlit+lQuu7q9Q/iH/ZtAINqSNK2SNkOy1VTd0Qz6VvdnFHkZXuH8FlJ/ckTFj9JPwdiHgskTld0pG9QeO//A==
x-ms-exchange-antispam-messagedata: xv+MfaXTCnQdcr6woO4CDlTuEkV01eF/D24ZCL/Z0LQApw/OeczzCOl3A8oNKUQzWWhIBPX2Frm85tjKoR0Wr4866Di7b8u4lue7pH9uH8KA9kNYogQdtroTRrfOhDVHiDkVyB6IwRdhk1/+Dn6ZhLgxwTW4Coku2xjnGjKh8b32oXCxZu+ZvX1/UtCuDa0BcegMRWbFXyYdNXhyyqvWGpRS8yhUksQxDHNi5dsylcTh1fYb4ZXmwPL7v3UpNjnZkeo/vVmfXHSQkuphCosnW3LPz5Wb3fCxv1yTIObzcwC1QNNwXcDsX9UUPX4Er8nq8iRrE98fLWkODTDXHCGd6I8SLGCCa1NuLkdGu+b/UGICgR74RPuQLos2NX9JHUXB0OxKAT7u6hLm+0s2lxM6Oj/UcjborMA5VEYusnO0+ir+d25mzrsHJrTlYx3a37WFRuh2s5n78d8mA0XBVF3VK7vqvYNcYm8tPLGNmduzaCQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cd2f81-1b57-4cbb-fb0f-08d82d4ba345
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 07:56:55.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtPP6sbuWS0mG7ggMZXpYp7GSUfh2nyEoxYU27lVxnfXXe+4Rt33WMJCPL2l5OBGbEnZcnVDBeIGN5GU0RiSHNof3P8JmNGWHgAu7mGMeGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1845
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H4SOAmFxfSenZGeK0YcwMrWgx4520388AA=
Content-Type: multipart/mixed; boundary="aZJhrr3u9bF6zBPi4If4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595318223;
 bh=snAOWSRPUxBA+e3pj+o7FJCjdVhFt+QCmYg5z7ht5BM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GkJs3uo5aMfb5sVJdm+oNdgu6BRd7MafVdumf8uVo14o63EA6eUPJcmmzSpq4I4Azkp
 uQvkB0g2AEq2OfQqb2lobOHDJJdIj/c0hoUJc027ZSFfY3RX7oQw080zq3IdjEsaUtBAg
 SpwY2BRueK2NmqN5pTG1sIyfgcq53x3RnuE=

--aZJhrr3u9bF6zBPi4If4
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

The configuration should go to https://gitlab.com/cip-project/cip-kernel/ci=
p-kernel-config not isar-cip-core.

isar-cip-core and deby share cip-kernel-config configuration files.
*isar-cip-core still has the configuration files there but conf/machine fil=
es with USE_CIP_KERNEL_CONFIG =3D "1" do not use them anymore.

Actually that is a nother AI.

Thanks,
Daniel

________________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Kento Yoshida <kento.yoshida.wz@renesas.com>
Sent: Tuesday, July 21, 2020 4:12 PM
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Kindly review for kernel config changes

Hi,

The security working group need to use "nftables", and it requires to add t=
he below kernel configs to work.
Before merging to the master branch of "isar-cip-core", would you kindly re=
view to add the below configs by this Friday, everyone?

--- a/recipes-kernel/linux/files/qemu-amd64_defconfig
+++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
@@ -351,3 +351,34 @@ CONFIG_CRYPTO_DEV_CCP=3Dy
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
+CONFIG_NF_TABLES=3Dy
+CONFIG_NF_TABLES_INET=3Dy
+CONFIG_NF_TABLES_NETDEV=3Dy
+CONFIG_NFT_EXTHDR=3Dy
+CONFIG_NFT_META=3Dy
+CONFIG_NFT_CT=3Dy
+CONFIG_NFT_RBTREE=3Dy
+CONFIG_NFT_HASH=3Dy
+CONFIG_NFT_COUNTER=3Dy
+CONFIG_NFT_LOG=3Dy
+CONFIG_NFT_LIMIT=3Dy
+CONFIG_NFT_MASQ=3Dy
+CONFIG_NFT_REDIR=3Dy
+CONFIG_NFT_NAT=3Dy
+CONFIG_NFT_QUEUE=3Dy
+CONFIG_NFT_REJECT=3Dy
+CONFIG_NFT_REJECT_INET=3Dy
+CONFIG_NFT_COMPAT=3Dy
+CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dy
+CONFIG_NFT_REJECT_IPV4=3Dy
+CONFIG_NFT_CHAIN_NAT_IPV4=3Dy
+CONFIG_NFT_MASQ_IPV4=3Dy
+# CONFIG_NFT_REDIR_IPV4 is not set
+CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dy
+CONFIG_NFT_REJECT_IPV6=3Dy
+CONFIG_NFT_CHAIN_NAT_IPV6=3Dy
+CONFIG_NFT_MASQ_IPV6=3Dy
+# CONFIG_NFT_REDIR_IPV6 is not set
+CONFIG_NFT_BRIDGE_META=3Dy
+CONFIG_NFT_BRIDGE_REJECT=3Dy
+CONFIG_NF_LOG_BRIDGE=3Dy

BR, Kent

--aZJhrr3u9bF6zBPi4If4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4945): https://lists.cip-project.org/g/cip-dev/message=
/4945
Mute This Topic: https://lists.cip-project.org/mt/75699231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aZJhrr3u9bF6zBPi4If4--
