Return-Path: <SRS0=IVJA=BA=lists.cip-project.org=bounce+64572+4949+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D052CC433E1
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 08:40:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3619620709
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 08:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Szy9a6Z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3619620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4949+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HXthYY4521723xe8oEyTGZ3j; Tue, 21 Jul 2020 01:40:15 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.122])
 by mx.groups.io with SMTP id smtpd.web11.14779.1595320813840544140
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 01:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzjFB1JQ0Hf0Ugzui94fKGDsa+Sj/1/wohllnFjJvb1HlUriVVbnqhShIvBreC+dCO/iohISVac2kk/OtS0rIb/daRvtTu+StWAZSl/WdEkpWftrAKR8C18rShfqYmUE0kGiuLcznnPibkkaY2F4mj0e5fYFl3G00VsDpwcNZC3joOqlXK9PaAzARN5dnHU/1xC+my2Olxa3fp21kRV8cQHOErxj0H3RXoIhIpUoKoBrhe3eWpoVnXg/6FuBRtrghappfrVEaWUqUeBqrjRGJizPhqGRI2AXJdzshPRfF97CZv1bI902BTQ7dp6rtnieRKRd2IZxG2MmmOg4TCCMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/0g9WDQX+uQLSHyI1ft+QbzTbphrWjfy/Eam5znOFs=;
 b=CX/ddLI0sI1wYIKThQ6zPvuE8rS8k8Sr0lzQFLBjxhc7qUeGSTKkuaTpCSTTPz7Z7LEWRE2l+Dz8o4ejNW8v57o3tNkkrQARY5mBCfWAaF80W4waUidAtyJZIKiTRJRL1JhG1wSlFV8Ea91nLsdwwZzeSKLi6mh8KR+kzY/GNPcU+6EoSZTlsFYDFbjAI1T2bLtZh7mdI9W2mJWXpD3ARchv8iHuaZYnEgN9Z+VvA0kZM+9lvjB7/G3+VJ8Pp/wL4XKeTNPBm6Lw7wfQUw4oSbJjc/h2SydJeGlyE6Yrr2HD54p1B9c3gLoicRvWTjLU7tcU2Q4HZ6ZtwXrKSXoIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com (2603:1096:604:84::10)
 by OSAPR01MB4674.jpnprd01.prod.outlook.com (2603:1096:604:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 08:40:11 +0000
X-Received: from OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::8449:1c80:1d61:299f]) by OSYPR01MB5366.jpnprd01.prod.outlook.com
 ([fe80::8449:1c80:1d61:299f%6]) with mapi id 15.20.3195.026; Tue, 21 Jul 2020
 08:40:10 +0000
From: "Kento Yoshida" <kento.yoshida.wz@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Kindly review for kernel config changes
Thread-Topic: [cip-dev] Kindly review for kernel config changes
Thread-Index: AdZfLRya8AsrLlY1RdmzI8gvGsZiWQABt3D7AACO7eA=
Date: Tue, 21 Jul 2020 08:40:10 +0000
Message-ID: 
 <OSYPR01MB5366AE110AC4DD024AEAA976DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
References: 
 <OSYPR01MB53662AC2C72A42E9C766B989DF780@OSYPR01MB5366.jpnprd01.prod.outlook.com>
 <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2053969F533158C576644152D0780@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.50.33.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bedb874f-0649-490b-6017-08d82d51ae1b
x-ms-traffictypediagnostic: OSAPR01MB4674:
x-microsoft-antispam-prvs: 
 <OSAPR01MB46741F55CE089AD03B50A18CDF780@OSAPR01MB4674.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 2RF2O1e7W7gmIUvNvBhGh6qOVM6yrhtg8RCf1WPMXCnXt6BsDTfGdyu8ygTh0Q5IKTnBpYGKfMh83lFD92/Dd6OECPIa74mL4dHuCB1mDlkehvh4UmN1BLdqQmqtpvu++31Dp0GP/UBr2uTLyh4VW4VStqoRCDAYHGdvQAR6+2KI1gie0DP/zPXIWRrLmkrC9BzL8S2WRR05bXWYTqoauDVQ1W1H2smuhJgADhc41pBJXHR+SmgYKZg5GIU/Ny1Ai0Og3dekHFEKz3x62Hl09k7yKREUQj2AltpXUU/mJ2J11us/kQi9CP2zVTLiBFGhKV73yjn8yQndgoqTULCnb+rYGU7V3n7x0oJdks20SE3wXn9HEpZSJLCVA/U+6wpAri4uwBonWz7QQUmBGaB51w==
x-ms-exchange-antispam-messagedata: 
 ndbfBDI3qT+KzGcca1EEIBLNWS8CmYBdKYBdCbslCozA+c4awP1T1WxT4AMEIyWszZZ9JtBMU4qI9nusp60LCndtNWvZ5iqKbC1XbC+oijlX8BFclE3RkA8ktQkNSl5dmSqlhCPFqkG3cxARi61YeL+BmO0Iy9lf/K2cirns3AOvU5ZxW+7Amx+wyLT5jYPe8c6ivts+wiDMtVZrsWeu7QuGjtan2ch/2k8JpC0lBFwaV36lTaFlT7ZkJK+nLik5gkzn8cSJJkEsSyyMZ/bQL7eUw/9f7UK4cowwjTalOz6l7vIW+tAVJ8JZYmwIqeudtzL6w+CIpcOzPxzfIHMgQp80OoktfUwcLMiy9DMfob6PNvSwSFTTi+G+9MkPZS0I+cjITHDyXKCsjSIl5Jk12P6NjaeZNw5tsUkRreFcqABJ99RN/yOUeoFFjXvAyX6RpiFJXKx/HeF4Qzscmi9Fj3ToL1ehiIVKPSTgcQLr1xmOPHzs0gc1i8aV8AElqOjf
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5366.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedb874f-0649-490b-6017-08d82d51ae1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 08:40:10.8639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlaYoLJi0a4vUCKXH0wYdq5OysijzHy3IbiCnb7dqOlI6NSMmlv4j4mJ8vo/OMPQ0QqD2KyslXe5w/Hw8VlmetKmOR2QRpl4+gL/4uW1NVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4674
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CeOHiTptIlM5ARpKg0YvbGMfx4520388AA=
Content-Type: multipart/mixed; boundary="O4X43pMUkcnLKzuZwW3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595320815;
 bh=Gz6EXGI+RnN2zBTN2iyjTVjRmSG1Eayw4PROHATk0Ko=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Szy9a6Z1/ezt4LYCJeQd+BIWn9g9lMTCVqZxL6+7DTHNbKIHAQHHjMvxGvFgyzx7SZY
 DYAEEaMRhM6c16AYMsKX8JnPh6ekS2MN+Z1EThxWWlb/EBrucVt77KY3DNJO7pxl+cRbL
 6zlHc73RqoexnnWyO1B29OYO3O75nkbuhpY=

--O4X43pMUkcnLKzuZwW3o
Content-Language: ja-JP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--O4X43pMUkcnLKzuZwW3o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4949): https://lists.cip-project.org/g/cip-dev/message=
/4949
Mute This Topic: https://lists.cip-project.org/mt/75699231/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--O4X43pMUkcnLKzuZwW3o--
