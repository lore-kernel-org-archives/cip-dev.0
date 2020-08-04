Return-Path: <SRS0=6mZa=BO=lists.cip-project.org=bounce+64572+5086+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98390C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:13:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAC32177B
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dLW5IfFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAC32177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5086+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dDuhYY4521723x9TrmVnCmfm; Mon, 03 Aug 2020 21:13:11 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.12489.1596514388412823924
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 21:13:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0744D3F9029963; Tue, 4 Aug 2020 13:13:03 +0900
X-Iguazu-Qid: 2wGqu78fihW3GkWDLN
X-Iguazu-QSIG: v=2; s=0; t=1596514383; q=2wGqu78fihW3GkWDLN; m=jHN3JI/Gw1XB3J1IgInJs5UZII21ZtnHDPJqMnnoYeo=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 0744D0hM020934;
	Tue, 4 Aug 2020 13:13:02 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0744D0ZS003572;
	Tue, 4 Aug 2020 13:13:00 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0744D0jD006705;
	Tue, 4 Aug 2020 13:13:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0g9E1+N8ddd0sqNZP6D2UPWA7ot71Szvyr63gOZH1HTLsX6xg5IXvymgTiM+mFuwlrOCaiExAavBAkkvb+ZwX6wQdPy/S7UiDCJeNZTeJYuTGxcPkVwj32NhXwzrmfq5NJmJDSaJBbEulxYlGuUPGhyU7IVZPUzGEOhB1z9Qc1G+smtPfIltbxi0NzEbzDS/UY9ukWAQplMDqm+fDa0DKACvTUlYTTlDmtpN8O/s25Z+4dinaOmwg6gkgx4MSYbRlNhKxJOQY7/KwwURBKRp5as1K0EypTumx+tWY7qVHyn2M8ME+TjjPhEGRy48qNMVvd4a63P+YHm86D3nosuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eyQSvvYMHuLaqqq95IrRiAzHGETrFtVvnyTqbvrWS4=;
 b=NZnm/tZxPIiEq2RtpnHGm/vya/+EBdpxYIDanrdWHR7x4atyRAyroqEFwG4E52AdvKNvGTpLZNRmIqq2j5qrwrZAMZ2jGZb+veJ1VzL8AoQN12Cbh3rZk0z/LWV2Xy9HR9W2l7Uir97ITjLCzvFTMqXmZqjPdNO3BctUC0d+bFcmdWJVtBQowOzp7Jt6/CXJ4brBGHi9GX66lucQrSXmndyemfYGCZI1DCXSeMBGskAgTdhoPEYI+Pk6aKdAKR6VvozxGDogJ6k0H8UxPBmegx/7EYDQ0EDZwRyaKBEWld1zMoqpy/7jSXC8/n6j12Kvp4cJ1yyOYBxx2tC1rn8llQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <kento.yoshida.wz@renesas.com>
Subject: Re: [cip-dev] Kindly review for kernel config changes
Thread-Topic: [cip-dev] Kindly review for kernel config changes
Thread-Index: AdZfLRya8AsrLlY1RdmzI8gvGsZiWQABt3D7AACO7eACt716gAAAJH4g
Date: Tue, 4 Aug 2020 04:12:58 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205321180007A01BB0C28695D04A0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
 <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com> 
Accept-Language: en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1043a14-30c5-400b-ee1a-08d8382cab8e
x-ms-traffictypediagnostic: OSBPR01MB4629:
x-microsoft-antispam-prvs: <OSBPR01MB4629AF5A0141A302156BF534D04A0@OSBPR01MB4629.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vQMMqqMusCTYB66uGr3AMFaxEicN0wZILzTBitw1nWFJLPLyrvJhU/C/S3trEC1xYqss8HJISMzkyZfE42mhoDFQuJGgcuwaVRzvgfrDloGSzIxnrJ2rZNjtcPlKDiUf2TYsAJsiBNTHJ1kVYAcATwL+D0nKXKgVRp2PzpaVDUdTVdka6LdOgHsBgAqqTtqTOwfLDycTv/2NVNQ58uJCVeESkUYh1bqzSwyZPEpCzAE2cNXMNHXLUGsOXg/8PjDCtuj1+K13JPJ/nHoeVgSZf2PBtZr74I4Y7bwSwC9aqOd6M9FN5bwdyhdey1xMCRct3TAlk5i5350jJVXSuEtw9cu164WalgL4OcRQI3EWLIXj7Y60p8EA1eOwDsOWCH2h7Gkwi4tQ5gAQcQuWFfZkkOQb3IWEh1MTzHerJBDzjEqGJG6TcGnYKu13gAEj8/kNtg4YUQAyD6LG8dShkHt/LQ==
x-ms-exchange-antispam-messagedata: RULH5hvC8irqAAgYu+Dd11c49HuNJqA4JE1FWlGQ30jDT7eAtt3rWV0fk3Dsp3XLFWMirOihvPW6mxC+icNR/X/jSPctQn58CPQvgJeJcVINVl5ush+eL/2nQvfc/kkVPrvnkjYcg59fRnFJNHMSB/4xba3Jm28ZeP3f3Kg6FrAVTQLdE2D+aBPLSOI7Dk4ZNQzmsaXzry40pESLXbRcd+T+3j/fY6PTd6r8q928zY4xcYJ6maBCv3vw5GuRJ/+2kDCue7NYDxg9omzeluIy9+efO+oA1HHPKC/eLmYasXdmb5y+HYf86PciTY1vJJM8OqyFm+o6CktKmqsznFAfz7wAPbkcX3T4fSBVpcuaAaZ1Box83Vh+35Zthy5tVzsYH8k+9kwKiUpd/D1T4Ng11gDdgD55qKvtFEhKUGCjOha5deyhQ1amC9t3hJJhOK0tRYUxtWoTpkes1QT0C2ZrFPc69HHq+cIUypDtUkcRyRg8qSCaNlay9LngrHHVbvOp6+YrR3jlk/ztQc9C2rvPkA+entVXLqd78lHCq97OjK7cizh6lr2L6AxBjWlCaWFMfT6a6HH4aNx5xA3ZKv0tjcQhSkEIULPzIHwC/nTb/Es5nxRk8xJPPtbQPEGvPZp9M2o5wGABjCUsRGSNggm6+w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1043a14-30c5-400b-ee1a-08d8382cab8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 04:12:58.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no0ywqq/vTcjY3x5t6YRTXUuHej4lFlzY6AwNLFc9M0O1MzW+z8lW57/5AL1YxXpMEAGRVUlSEQ00g5NNOu01RA9dRAnjA2vsGAw8jXODCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4629
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v9YagVjLzCDtG0jYVem3Rv1xx4520388AA=
Content-Type: multipart/mixed; boundary="nCIhR6FmGBMFI7I3VYAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596514391;
 bh=sHj89jvFX1W5HiH1zVBvRxXUcA48qHgUsLMljHAN4FI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=dLW5IfFwXIRNcvQe8DOvkp/6TjkrvLLp4BZssFx/WvdmRVRZmev8St5bekqFPV9AuDs
 fbqhGZv1guRul1r88O4H6lKbYQ4SPwubDx+YlTkhFJdyj+3ZPALFrAP2XHouvE1KBhQmj
 BKnS/Dru5PZ4sbgm0AVkDBQe2EDGWine3e8=

--nCIhR6FmGBMFI7I3VYAA
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

> > I see. Thank you, Daniel.
> > But, I'm wondering why conf/machine/qemu-amd64.conf doesn't define USE_=
CIP_KERNEL_CONFIG =3D "1".
>=20
> It does now.

more accurately, it is in the next branch of isar-cip-core

>=20
> > Do you have any information for this, Dinesh or Venkata?
> > I think we should reconfirm to add these configs to
> > https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mas
> > ter/4.19.y-
> > cip/x86/cip_qemu_defconfig.
> > Or, have you already confirmed to build the image using this?
>=20
> I would prefer if cip-kernel-config had base configurations that are late=
r extended with fragments (board-dependendencies, security layer
> dependencies, etc.). However, that would be a whole new task that might t=
ake long.
>=20
> For now the more realistic approach is to add the security-related kernel=
 configs to either cip_qemu_defconfig or to a fragment in isar-cip-
> core and deby.
>=20
> Thanks,
> Daniel
>=20
>=20
>=20
>=20
> > >-----Original Message-----
> > >From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > >On Behalf Of Daniel Sangorrin via lists.cip-project.org
> > >Sent: Tuesday, July 21, 2020 4:57 PM
> > >To: cip-dev@lists.cip-project.org
> > >Subject: Re: [cip-dev] Kindly review for kernel config changes
> > >
> > >Hi Kent,
> > >
> > >The configuration should go to
> > >https://gitlab.com/cip-project/cip-kernel/cip-kernel-config not isar-c=
ip-core.
> > >
> > >isar-cip-core and deby share cip-kernel-config configuration files.
> > >*isar-cip-core still has the configuration files there but
> > >conf/machine files with USE_CIP_KERNEL_CONFIG =3D "1" do not use them =
anymore.
> > >
> > >Actually that is a nother AI.
> > >
> > >Thanks,
> > >Daniel
> > >
> > >________________________________________
> > >From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > >on behalf of Kento Yoshida <kento.yoshida.wz@renesas.com>
> > >Sent: Tuesday, July 21, 2020 4:12 PM
> > >To: cip-dev@lists.cip-project.org
> > >Subject: [cip-dev] Kindly review for kernel config changes
> > >
> > >Hi,
> > >
> > >The security working group need to use "nftables", and it requires to
> > >add the below kernel configs to work.
> > >Before merging to the master branch of "isar-cip-core", would you
> > >kindly review to add the below configs by this Friday, everyone?
> > >
> > >--- a/recipes-kernel/linux/files/qemu-amd64_defconfig
> > >+++ b/recipes-kernel/linux/files/qemu-amd64_defconfig
> > >@@ -351,3 +351,34 @@ CONFIG_CRYPTO_DEV_CCP=3Dy # CONFIG_XZ_DEC_ARM is
> > >not set # CONFIG_XZ_DEC_ARMTHUMB is not set # CONFIG_XZ_DEC_SPARC is
> > >not set
> > >+CONFIG_NF_TABLES=3Dy
> > >+CONFIG_NF_TABLES_INET=3Dy
> > >+CONFIG_NF_TABLES_NETDEV=3Dy
> > >+CONFIG_NFT_EXTHDR=3Dy
> > >+CONFIG_NFT_META=3Dy
> > >+CONFIG_NFT_CT=3Dy
> > >+CONFIG_NFT_RBTREE=3Dy
> > >+CONFIG_NFT_HASH=3Dy
> > >+CONFIG_NFT_COUNTER=3Dy
> > >+CONFIG_NFT_LOG=3Dy
> > >+CONFIG_NFT_LIMIT=3Dy
> > >+CONFIG_NFT_MASQ=3Dy
> > >+CONFIG_NFT_REDIR=3Dy
> > >+CONFIG_NFT_NAT=3Dy
> > >+CONFIG_NFT_QUEUE=3Dy
> > >+CONFIG_NFT_REJECT=3Dy
> > >+CONFIG_NFT_REJECT_INET=3Dy
> > >+CONFIG_NFT_COMPAT=3Dy
> > >+CONFIG_NFT_CHAIN_ROUTE_IPV4=3Dy
> > >+CONFIG_NFT_REJECT_IPV4=3Dy
> > >+CONFIG_NFT_CHAIN_NAT_IPV4=3Dy
> > >+CONFIG_NFT_MASQ_IPV4=3Dy
> > >+# CONFIG_NFT_REDIR_IPV4 is not set
> > >+CONFIG_NFT_CHAIN_ROUTE_IPV6=3Dy
> > >+CONFIG_NFT_REJECT_IPV6=3Dy
> > >+CONFIG_NFT_CHAIN_NAT_IPV6=3Dy
> > >+CONFIG_NFT_MASQ_IPV6=3Dy
> > >+# CONFIG_NFT_REDIR_IPV6 is not set
> > >+CONFIG_NFT_BRIDGE_META=3Dy
> > >+CONFIG_NFT_BRIDGE_REJECT=3Dy
> > >+CONFIG_NF_LOG_BRIDGE=3Dy
> > >
> > >BR, Kent

--nCIhR6FmGBMFI7I3VYAA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5086): https://lists.cip-project.org/g/cip-dev/message=
/5086
Mute This Topic: https://lists.cip-project.org/mt/75699231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nCIhR6FmGBMFI7I3VYAA--
