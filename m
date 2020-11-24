Return-Path: <SRS0=tjM2=E7=lists.cip-project.org=bounce+64572+5878+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07186C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:48:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAA8206D8
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 13:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kS0QDKNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAA8206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5878+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UKAgYY4521723x6zfdPvXarL; Wed, 25 Nov 2020 05:48:20 -0800
X-Received: from APC01-SG2-obe.outbound.protection.outlook.com (APC01-SG2-obe.outbound.protection.outlook.com [40.107.131.120])
 by mx.groups.io with SMTP id smtpd.web12.576.1606239824320993245
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2020 09:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fwoig5lPgQtU/ZrvjhC9kqrjnWhvay+hHxFvmJlfKwf1FNRv2VuLwcntAKLxv4pcnA8FddQP6hZBPbPKEqIesTqwOa+u4AdJ3re4RmHugXuq2ISkbSaLWM6Ez340hBr0Ww+Smq/L8GIIBGS2w27QqO2A7AASOOKLsxGW0sbjZb3PpLzHJlJC/iZrbR5dVCOHr6rZAMvmjAJ8b85Kae19gvaBy2LpWKOXoLj6UpMohSjzQ+axmlU9G8H/EKpK6DT+TNqT/K4eAiJQcxJjwO//8qHDSJ36CZSxuVAgmPME9yHp4s95KFFbfoxlI7TOI/6EJvf3fE8B6wPU1JNFPjKlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKZVo/4R8V6il+TN/HB7b7DryyvHNeToc+5alkC/DAI=;
 b=RB9dL7MMBupjjXlEjgBzmyvr0PxlfumVIJ/iuoPGMyW7u8rKNPS2SsnLNOdOu7WGaRJvCeAGV5sbTRcWI3robmq9l/dusLSIHur6jATxAqhpDyziyTYQRaDHSY2spWpdtC1mHDeEfcsE9FgIqiDHwoLeXB/VtjppopO8SS7YXBPpUWq7ZaTvJXruiqwmIO49GiaoSo9phSu30e9Ec0YNEYOdpy7PlCeTpi0GYj/4a/7vLoY6QLfH0aZIw0DsPLDFt0AHzoIDxWyj4rqRtp9ztw4iOa1vxBX8R/E9qh4i5izFhNaZc1RRMpca2xLYyM5jSYtlTTuca2Kj3IXzXwd3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 (2603:1096:404:8025::15) by TY2PR01MB2443.jpnprd01.prod.outlook.com
 (2603:1096:404:76::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 17:43:40 +0000
X-Received: from TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::5d23:de2f:4a70:97db]) by TYBPR01MB5309.jpnprd01.prod.outlook.com
 ([fe80::5d23:de2f:4a70:97db%3]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 17:43:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] dt-bindings: PCI: rcar: Add device tree support for r8a7742
Thread-Topic: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
 r8a7742
Thread-Index: AQHWwogOxRebEFLFfE+UcnM4O9+OAKnXjOfw
Date: Tue, 24 Nov 2020 17:43:40 +0000
Message-ID: 
 <TYBPR01MB5309A2A474997739FAB5E34186FB0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
References: <20201124173421.14576-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20201124173421.14576-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57396b6c-96a4-4944-d253-08d890a07ada
x-ms-traffictypediagnostic: TY2PR01MB2443:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <TY2PR01MB244308F46EF313A437944FAA86FB0@TY2PR01MB2443.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Ux9yNs5mC4YZLQG8rZuwo6mgOLqh5KSClcFAPw89HB+lI1dcRmreSnBcyYXxv6p0iIiIZiSRR6JUrIpPL0IN3gOK/4Ph9VFSJoKcn5P7lKqOwkABPS1XBCHQGfHegzKENgZ41fUJOYSos+QJHSQu0XCmnMqickSzRlpGaXDSOQPAdGm/FK/f0Gq3/UygUuRvX98V3qpCy+QqUpH9XJLiRUA/832/CbhZcXh8rXUR1aJwi9MbRNYxDAbgIlBwHmjKZrdTY61500MtAGUdA86qz6lko+Oak3tdLNuZwaoNWjAPVZEyV/Evk6nHu3KlbYNNKH4/vnl/q1iDZXtJ+RPNg3CEt8DhcvnPbUifOeovoLXgNyU7kMxO+aPgYiWDW4Nk6dnXoq2X2lVeZGGIrwlX48/SbjkCXXIqq3KO2viGabb4ooJFxECg8BnPOumfrFgXH2IEvTDL21lci/2ct0x2Ag==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?1zTbxF2pMODZabiV5cpTP4y4BJp346lWkWj1FXle0XLQODGY2cwOjaIXcuS8?=
 =?us-ascii?Q?ADbkyXObGxmlqeMLLjn9gYBx4t4952shJs6QslsvxlYJVd+vVwpYFslLYUhh?=
 =?us-ascii?Q?TaEUJLurkrfKXPdK0KZuMEB/aH6P2XHPuh0mVVVpOhxx4YCiRgoKwc7bD7j/?=
 =?us-ascii?Q?DMYFiRJcGF7DiXd+Jh7F+tB0/o7IWrnTlpUsUcmtfnXqjewmG9nNUzjpxJ6k?=
 =?us-ascii?Q?l4NY2h9EUkZ5+XCiWKcE6JlrxzAPt2AFItwVjA8cyM1bSPbt6wc41282f/Oh?=
 =?us-ascii?Q?rvtpe54JPmZfOwpxcgfkakHNCUiaEuA/TvxKshUcdq9Cqe66Q+qfIJfI0Kxo?=
 =?us-ascii?Q?vYUYZEqo9qJUzJVWCdIlM/IpO+yg3sEuMTUqULqn3emkXZC5bNpNCjnxn4AC?=
 =?us-ascii?Q?3LXXayGFjUGhxCyaV2frTUV9KeG3EBkmDO2GtZXKRRthGV9jtyj5KU3JHci8?=
 =?us-ascii?Q?yOX/SnWGQWhGam97kJMVVhxBnXDUM/g+r35N5DeXuKDUa8n1IOUQiYahsauT?=
 =?us-ascii?Q?m8XM36/SNpyc99WjGqzjlAHhxJDoF4neepzMMVhrnsLa+JW0PGEF35TjBUWL?=
 =?us-ascii?Q?SBpzcvdOc2REX48lCB2mdPmZK1fhFRNrEFANaR361UFNR+F7bTvgmh6R7hrK?=
 =?us-ascii?Q?p853Vhn8ya79nWt8wKRi4g16F4qGzKGkOCLIQIt2e/nlsFdtyaQMnoYal8yz?=
 =?us-ascii?Q?VTo+SIpJww0q4FTecFjMMMK6IQTivmXjKTPLOJWtDb9fvH4lMshtqYa82kav?=
 =?us-ascii?Q?8sonNBA6nShOm1DanL3UzsQdG4HhI6WXjkn82IkRbfucSQoyZNcRj7Q8KNTZ?=
 =?us-ascii?Q?z5GGE74SvC2qJym38qOAleimpTm1pQI6XFhnUFZQg17Ze+cDn8XH1c39Nkf3?=
 =?us-ascii?Q?FWvFdCL+qIHuVDjw1Iu3mYyMeG++9Zmeiqz7mLK0LdQdzomQ49LMlNU/AsOO?=
 =?us-ascii?Q?+PocE2pm7Zjg60aD4GG0lTKzi1MZiibvF0nMaE8T2R0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5309.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57396b6c-96a4-4944-d253-08d890a07ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 17:43:40.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQajadBShsanzNxH9bik0pUhcz3OysLq1YRLfQh4cF8g9P/xxtlHwnf6HBlguVQHj/m1DImXAUvg51PtqGf5M2QmJB9bTwSHnkHgu9BQPlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2443
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Fy1kn2NS4yfLqppAV0iMUQsIx4520388AA=
Content-Type: multipart/mixed; boundary="rnc2YMzGj4MWVXClc7de"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606312100;
 bh=58eBeLDzj2hvVvFhGSequlLIMoD/3NtDoTxu+lcf5JM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=kS0QDKNkARqSb4tcudMwT1xoDoOtb/24WIUh+o8KrXzH0JmgpuaeZjuPeGDD/UJJqVl
 B7mFpklrPDF/S+z7wBu76TSil0aE9bT+gO7Fff2KMIAWnSgPi6Sg6JA/P4snyZT/uNW6k
 YG9ZpRUHgbKRE6MniONIX16J+cIp5S1quO4=

--rnc2YMzGj4MWVXClc7de
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel, Nobuhiro,

Please ignore this patch for Linux-4.4.y-cip. I have send another patch fix=
ing tab between commit and commit id
in the patch description.

Regards,
Biju

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: 24 November 2020 17:34
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> lad.rj@bp.renesas.com>
> Subject: [PATCH] dt-bindings: PCI: rcar: Add device tree support for
> r8a7742
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> commit	d16d538ff49145b153976bd8e124116d369db266 upstream.
>=20
> Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller is
> identical to the R-Car Gen2 family.
>=20
> Link:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ker
> nel.org%2Fr%2F20200810174156.30880-2-prabhakar.mahadev-
> lad.rj%40bp.renesas.com&amp;data=3D04%7C01%7Cbiju.das.jz%40bp.renesas.com=
%7C
> 3d34a2122cbd4154baf708d8909f2fab%7C53d82571da1947e49cb4625a166a4a2a%7C0%7=
C
> 0%7C637418360659367751%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
o
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D9BWyqx81fEYB0I=
McK
> 8nJz2xG1WLwRJG5lAE4FXVMBFo%3D&amp;reserved=3D0
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> index bedfdc122543..8a3d8b5be515 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> @@ -1,7 +1,8 @@
>  * Renesas R-Car PCIe interface
>=20
>  Required properties:
> -compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
> +compatible: "renesas,pcie-r8a7742" for the R8A7742 SoC;
> +	    "renesas,pcie-r8a7743" for the R8A7743 SoC;
>  	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
>  	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
>  	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
> --
> 2.17.1


--rnc2YMzGj4MWVXClc7de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5878): https://lists.cip-project.org/g/cip-dev/message=
/5878
Mute This Topic: https://lists.cip-project.org/mt/78482468/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rnc2YMzGj4MWVXClc7de--
