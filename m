Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76915C433EF
	for <webhook@archiver.kernel.org>; Tue, 30 Nov 2021 10:22:21 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.136])
 by mx.groups.io with SMTP id smtpd.web11.74011.1638267739234036273
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Nov 2021 02:22:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=CqJYiKRj;
 spf=pass (domain: renesas.com, ip: 40.107.114.136,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRfI1QUDmGLNxHfz8c43z2gv0sTCBD7M27BctsjKteDbgpEtvjXWT4cZFS7rddFxkPki4Lunf09mDiiGbZ3I2/L5TlJf1m8/EDiv0dUug5BYzjOQrZE+DRtEijuk8RekaXy92j09CGPO7eDFpnUAM58Y3vKJUiOnpcovZJxH0Tobd+oLn5rfcWg7jwPJ8EMDhWZGXpqaZwsxKH6fejT845l6Arb2NXqsz22xQilK8RV/2LBNArvh6z2AE//ifI35QObwo0oDLtQcYWsvc/atQifcbXyvWqFGmo1IXOzvBjgyATlf2ozmHfWMrKw5B5oJQgkkdEPx+/gCb5K1bJRLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auGzdp6XUyQdF7/34y0zeBBO/przVVv7F6LVkCURcoA=;
 b=IcrnQkVAxmtrCwQ0f/NSE2SmZ/RKdKNVh77+j9WgzQ/qX4MUYfToSiw+qnZcjm6LvCMjoz2dao+iIWlyY8LydMMcRg8oe3uBvIy2qbvPsxhmV4FT2MO/j7fz6H6R+9/ayVjyib8Zmxuj9Ig64cCsDOpJnbzEe2RogzKlpJl5CSYUbRmXS2W1Y0gsMyG+AERIKYy9HiAQoZ9eMxihOi623H6/MIyQXPhIyj531UZbo4eRW9izXT17HcOPLlLpN/temA1NxF5jJFaNMtlmJp+ZH1uxvXsldUJnhmSQH3a4ZOYPCiuaEdB86/zDGTfCN+henWqCFYhxQNANmmlKFzgnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auGzdp6XUyQdF7/34y0zeBBO/przVVv7F6LVkCURcoA=;
 b=CqJYiKRjIgUEIV07NqAAP9lCCCUVGCZGN4Ysl6MjzoO2Ypo7P9hToszYb0W18nNHUKIwDOVvDIpvQINaYV93cF7iuU9h/CyAoPxKjCNzSg9df983sKrbuKuh6JRYnuR36dXLVU6eQd012UAwCZtAy/eEYK+vklZu9zwmxHExlnk=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB1939.jpnprd01.prod.outlook.com (2603:1096:603:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:22:14 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::393c:4f5a:131d:440b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::393c:4f5a:131d:440b%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:22:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "bot@kernelci.org" <bot@kernelci.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>,
	"kernelci@groups.io" <kernelci@groups.io>
Subject: RE: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1
 regressions (v4.19.217-cip62) #kernelci
Thread-Topic: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1
 regressions (v4.19.217-cip62) #kernelci
Thread-Index: AQHX5cTqi3vVsdFhjkmmloN3zvQooawb1qiw
Date: Tue, 30 Nov 2021 10:22:14 +0000
Message-ID: 
 <OSZPR01MB687760A42FAC36D478192D11B7679@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
 <20211130083305.GA2355@amd>
In-Reply-To: <20211130083305.GA2355@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e817c09-d6b4-457c-186f-08d9b3eb4747
x-ms-traffictypediagnostic: OSAPR01MB1939:
x-microsoft-antispam-prvs: 
 <OSAPR01MB1939B73BE78ACA07D3CFF6CBB7679@OSAPR01MB1939.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Co/mOcPKugpoJMUogcYA15RdGFZ1TMlDMB1dW6KaBTCyxt2r0uKxYx2xC2DTdmpxHY6l++PMTPXKa5zVuOCQpW3QLlcFF1uCuATPiEsWk/dA8K5J3qcIxX2xLW1sizi1tEERoGfQ/dPIiz5ptqkaxJMRLKuxOVgG3z6P2vitFZZ1Gl6JU9AGk5z1jpomRbslmM6wGXANNAd/wDxSoeBOVpeIuLEaAI3nzXr2PomUwvhCXmLedvbUfGMDvwV/ZylSZdViw33AJD1KY9HPil27c8xkmAC+gOpsOI18fUhNJZMQxnM/9HPivuibtb7NHY12cONoSiFUfxL9g5CoeIFQEHhyw7zgQv3vWIC1ZDUteCpxHOO8PCTEBe7vUyz/v33p8TWYiDKCj2spS0w748idqPplH5GT+7gctbhqZ/+PbHz3nS1cs98XG8XX3DJ5he3F4es8CqxiJGfHsavubWBZYEI9Y9/YgXv8ug41MMsuNdD5gSLyJDYXGYjh3i24skM+Bi9en/epLYwHDCYjL9UO4uPKIHG1dVPyULf6tNeEuk578AMBhGZ2nowXNwBnCoWNxzFaLcqgctc843citemiGH5qwah/oN3I7/dEdtE96s+cWQHoi5s/JKSpmhT70c/Iu0heLTehu3Qvxsd1L+hb2MLttgupa/AA029QXtlZNB1sbZsB5PJO8Jll6HD8PBRH3v2d1DrHL3k4ft0uy8TrXBF7xNyIFBol/+YQWXLETbuNY2Tac1gvnSUQzkKZjpyd2+2FiOf0hlwi6WbtGpRbxVCzKbDXJmG2cXmIQMb4Y/oHZKi8+VQ9t6qgUNJkT+nX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(7696005)(83380400001)(8936002)(5660300002)(76116006)(71200400001)(66476007)(64756008)(66556008)(9686003)(33656002)(52536014)(66946007)(316002)(122000001)(99936003)(66446008)(38070700005)(26005)(110136005)(508600001)(6506007)(38100700002)(55016003)(966005)(86362001)(186003)(8676002)(45673001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?SxBvlGXBCYBqhaeYbBiydxqE/NPdXbzdKgLWNVTyTBcYa56IiIfOsHzZ?=
 =?Windows-1252?Q?DbX6n7zZISyv4ljeb87TaR7hzH2m6UvBySlvWrBWwP6g6mQoRIL3xtP5?=
 =?Windows-1252?Q?FtxPow++h6OlGO9EcvKN6PEZsMaMIEkUJddxSsmt3dUKh3K43eA5jVRt?=
 =?Windows-1252?Q?wg3/Z4hXc6UH9KnB/jS3eYy6nOLaw75UcqWmxGBZvCj6lWM5PUmCrJoI?=
 =?Windows-1252?Q?uPEjbtlnfhifKRfKpU60gdJ97f5IyM2tAqlUugPObnIm7Hi07QVDcPo9?=
 =?Windows-1252?Q?Eg3V2bc+JJZRgHlM0Q0YvgKbYH251q7x/X/n+Q5Yn8hAxwpliTKySnwi?=
 =?Windows-1252?Q?LBzi+Ow1h2hs53O8fOJz30aBL4gZy60KbB89KnV2zWD7Rdbj5jx/a+mK?=
 =?Windows-1252?Q?I/IR+trV3wuZyw3s1XzKY95DaGHKuT7D11JiLczjs9q9vQrCSoYRxlCJ?=
 =?Windows-1252?Q?m/f4T1s21Z+zS7gNbMqcGXgtFGfYuIPbL2J8LLgSDoXDgbhT46PXy9Vh?=
 =?Windows-1252?Q?vDerz/tBhBQo7XxPjHPOn6fo55Ycdaz9HsuoR6vtPw0QHZ3c0hEoSig2?=
 =?Windows-1252?Q?aY5ghvV/8GnAaMksm4QmAcSTq9pNKPZl8wkAsvU72HCRIlza2ZMzNBC9?=
 =?Windows-1252?Q?CBalRcleqAipIqSXnJu6URJtH7X7h0BxZZcK4l1LHs7d3xX+zy1DkRjp?=
 =?Windows-1252?Q?Lhj3npcL1RuegigdxuFblKkq+Q9KDf5h8nLHQL7/2BT2eX8G7n95vHNA?=
 =?Windows-1252?Q?tgOxUKkzhrHPB3u2/inxBK56kMsoxJG0FRZxnYcJbvhedtJgFSPZ2x22?=
 =?Windows-1252?Q?QRsZmZiypMGBiNvkN5xaLBT5ncRQhq5kZGp5r01pzs3a7q8Ki68N8aiM?=
 =?Windows-1252?Q?zlCKX94JERIy/kYpUeis0aTe+GYfKuRauf105T22qv3srJC9aD2n9Ges?=
 =?Windows-1252?Q?JKGDgvG55FHY4U7C6rWRb5GPo5PfBCAh1lNWeDdmZPRQvk99wNYDjOA4?=
 =?Windows-1252?Q?7InIU1o3mZoS3xc3mAXiQlkxrAyZz2kY4QVaGPBQGdeRoQRxxVKYaC8f?=
 =?Windows-1252?Q?jz5+yL3CIA7kSQrB2M6e/MTcVkNjzH8jpBAkqboASZbZ72NeI46Ruac7?=
 =?Windows-1252?Q?ruEYuFEwVXyelGozsn4bLYzPBR3wCasPDXh+Z6XKu5gRi4KCCkymJvvQ?=
 =?Windows-1252?Q?3FXqwuKFm6W82AAlpUgY/KEfiluGTpojsMMbn9IT6EDffQq/T/rUoN5T?=
 =?Windows-1252?Q?3r8K8YHZlKzbfM6gL9pbigiZrNWWOHEmttwFXWGwoitSsyk+hEIc7RS+?=
 =?Windows-1252?Q?2BQM1F/MDy2Q6w+GVWcCCZBkk+0r6keHqA5Cudp5GTCxpuB0tEe8WgdI?=
 =?Windows-1252?Q?QcIOYA/UKcMh0zSHLARFzmIcysxoYT1zE3VYi0QnM2qn++xG8ZtgMF0z?=
 =?Windows-1252?Q?tx/3pYPdoGOrGaZShK8e3fdjvJCAe5oxYEOpO6HUaklvmplDIECZ6K77?=
 =?Windows-1252?Q?QyQTYtTYA0fu6cNR73w6rsktJ9boh23QdM1oKuEGHaNo1qxITAxO4yzN?=
 =?Windows-1252?Q?pin+bhGjY+7gWzkMGqEWsfwnleo7OIIK+Bd+IToyo7lHj/AkgY3UO6Es?=
 =?Windows-1252?Q?RJxZ7A0cEgncG7mAjMgbqIUKReb9LbGa5F7GBuE22WJxRm3dEJTLbCLZ?=
 =?Windows-1252?Q?TDKiYxA6lOFRSj3ZNN5m6YPzJy3mFK0sw8fBQA3W7cyFl79k/qgLWZtr?=
 =?Windows-1252?Q?X+1Xemn0VkKRrxSNIHRrAoTcr8DDPSfqR/4YiLj0e2F7ZmQpm76fKyul?=
 =?Windows-1252?Q?0GSXyA=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_OSZPR01MB687760A42FAC36D478192D11B7679OSZPR01MB6877jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7e817c09-d6b4-457c-186f-08d9b3eb4747
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 10:22:14.2341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 RdxnLz/Mn/vGv3FaXgHBhi4iDoIrsr67d/yymJGg5ndbfehinLJGvKOfz5weLAD4pkFHW7sWd9c2+JtyVmFiXfXuSGEeSgwK01bLhH1AyA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Nov 2021 10:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7038

--_002_OSZPR01MB687760A42FAC36D478192D11B7679OSZPR01MB6877jpnp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

+kernelci ML as they will appreciate the feedback.

> From: Pavel Machek <pavel@denx.de>
> Sent: 30 November 2021 08:33
>=20
> Hi!
>=20
> So... I tried to understand this report, and still could not.
>=20
> First problem is actually in the From: line. By placing bot there, it
> is not clear who is responsible for this, and if someone reads replies
> to the bot address.
>=20
> I feel posts to mailing lists should be signed by human responsible
> for them.
>=20
> Then we have:
>=20
> > cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-ci=
p62)
>=20
> Ok, so we may have an regression. That means it worked before and it
> does not work now. I'd expect two versions "worked in v4.19.123-cip12,
> now broken in v4.19.217-cip62", but we only have one.
>=20
> > Regressions Summary
> > -------------------
> >
> > platform         | arch  | lab           | compiler | defconfig | regre=
ssions
> > -----------------+-------+---------------+----------+-----------+------=
------
> > rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1

Did you not have a "details" link here? In my copy of the email (attached) =
it links to=20
https://linux.kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kernel/v4.1=
9.217-cip62/plan/baseline-nfs/

If you click on the platform in question it says: "New regression, last pas=
s: v4.19.216-cip61", which also links to the relevant build job.
I think it also says this in the email below the failed test case? (baselin=
e-nfs.login)

>=20
> >   URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-c=
ip.git
> >   SHA:      dc62e26e3be875a7324b85b8274c13a335e610dd
>=20
> Still no note when it worked last.
>=20
> >   HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19=
.217-
> cip62/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-
> kevin.html
>=20

Again, there should also be a link to the specific failed test case, in thi=
s case:
https://linux.kernelci.org/test/plan/id/61a58c2989f6953bd118f6e4/

This includes a link to the defconfig used, although perhaps you'd like to =
know more about the platform.

Kind regards, Chris

> Ok, so we have bootlog from a machine, that's quite unhappy. Part of
> it are kernel problems, but we see missing firmware, too. In the end,
> it looks like it has no usable network card, so it can not do NFS
> boot... and panics.
>=20
> It is hard to tell config problem vs. kernel bug without knowing more
> about machine configuration. Best seeing previous successful runs...
>=20
> Is there human here who believes this is a problem in -cip kernel that
> is worth solving, and is willing to answer questions and test patches?
>=20
> Best regards,
>=20
> 								Pavel
>=20
> 02:27:34.443815  <4>[    1.401574] cacheinfo: Unable to detect cache
> hierarchy for CPU 0
> 02:27:34.452441  <6>[    1.413496] loop: module loaded
> 02:27:34.464113  <4>[    1.421343] rockchip-spi ff1d0000.spi: Failed
> to request TX DMA channel
> 02:27:34.471531  <4>[    1.429063] rockchip-spi ff1d0000.spi: Failed
> to request RX DMA channel
> 02:27:34.487460  <6>[    1.446867] m25p80 spi0.0: gd25lq64c (8192
> Kbytes)
> 02:27:34.501792  <4>[    1.459399] rockchip-spi ff1e0000.spi: Failed
> to request TX DMA channel
> ...
> 02:27:48.313465  <6>[   15.264576] atmel_mxt_ts 3-004b: Family: 164
> Variant: 14 Firmware V2.3.AA Objects: 40
> 02:27:48.362782  <4>[   15.318381] atmel_mxt_ts 3-004b: Direct
> firmware load for maxtouch.cfg failed with error -2
> 02:27:48.535527  <4>[   15.377455] atmel_mxt_ts 5-004a: Direct
> firmware load for maxtouch.cfg failed with error -2
> 02:27:48.827088  ipconfig: no devices to configure
> 02:27:48.831012  ipconfig: no devices to configure
> 02:27:48.926132  <4>[   15.866511] platform regulatory.0: Direct
> firmware load for regulatory.db failed with error -2
> 02:27:48.931359  <6>[   15.879008] pci 0000:00:00.0: PCI bridge to
> [bus 01]
> 02:27:48.938653  <6>[   15.879016] pci 0000:00:00.0:   bridge window
> [mem 0xfa000000-0xfa1fffff]
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--_002_OSZPR01MB687760A42FAC36D478192D11B7679OSZPR01MB6877jpnp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 30 Nov 2021 10:22:10 GMT";
	modification-date="Tue, 30 Nov 2021 10:22:10 GMT"

Received: from OSBPR01MB2263.jpnprd01.prod.outlook.com (2603:1096:603:23::13)
 by OSZPR01MB6877.jpnprd01.prod.outlook.com with HTTPS; Tue, 30 Nov 2021
 02:40:18 +0000
Received: from TY2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:404:56::25)
 by OSBPR01MB2263.jpnprd01.prod.outlook.com (2603:1096:603:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 02:40:16 +0000
Received: from TYCJPN01FT005.eop-JPN01.prod.protection.outlook.com
 (2603:1096:404:56:cafe::41) by TY2PR02CA0013.outlook.office365.com
 (2603:1096:404:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 02:40:16 +0000
Received: from mail02.groups.io (66.175.222.108) by
 TYCJPN01FT005.mail.protection.outlook.com (10.118.160.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 02:40:15 +0000
From: KernelCI bot via groups.io <bot=kernelci.org@groups.io>
To: "cip-dev+int+1680+2922216858170285886@lists.cip-project.org"
	<cip-dev+int+1680+2922216858170285886@lists.cip-project.org>,
	"kernel-build-reports@lists.linaro.org"
	<kernel-build-reports@lists.linaro.org>, "kernelci-results@groups.io"
	<kernelci-results@groups.io>
Subject: cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions
 (v4.19.217-cip62)
Thread-Topic: cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions
 (v4.19.217-cip62)
Thread-Index: AQHX5ZOdikPE8FFNlkuUWLC1SMlWlg==
Sender: "kernelci-results@groups.io" <kernelci-results@groups.io>
Date: Tue, 30 Nov 2021 02:40:13 +0000
Message-ID: <61a58f0d.1c69fb81.10029.4ed2@mx.google.com>
List-Help: <mailto:kernelci-results+help@groups.io>
List-Subscribe: <mailto:kernelci-results+subscribe@groups.io>
List-Unsubscribe: <mailto:kernelci-results+unsubscribe@groups.io>
Reply-To: "kernelci-results@groups.io" <kernelci-results@groups.io>,
	"bot@kernelci.org" <bot@kernelci.org>
Content-Language: en-GB
X-MS-Exchange-Organization-AuthSource: 
 TYCJPN01FT005.eop-JPN01.prod.protection.outlook.com
X-MS-Has-Attach: 
X-Auto-Response-Suppress: All
X-MS-Exchange-Organization-Network-Message-Id: 
 d0629d71-8aa5-409b-e74c-08d9b3aabdde
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
received-spf: Pass (protection.outlook.com: domain of groups.io designates
 66.175.222.108 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.175.222.108; helo=mail02.groups.io;
x-ms-exchange-organization-originalclientipaddress: 66.175.222.108
x-ms-exchange-organization-originalserveripaddress: 10.118.160.88
authentication-results: spf=pass (sender IP is 66.175.222.108)
 smtp.mailfrom=groups.io; dkim=pass (signature was verified)
 header.d=groups.io;dmarc=bestguesspass action=none
 header.from=groups.io;compauth=pass reason=109
x-forefront-antispam-report: 
 CIP:66.175.222.108;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail02.groups.io;PTR:mail02.groups.io;CAT:NONE;SFS:(4636009)(55446002)(6486002)(1096003)(121216002)(6636002)(76796012)(6512007)(26005)(9686003)(7596003)(7636003)(19810500001)(336012)(8676002)(7846003)(956004)(83380400001)(36736006)(118246002)(5660300002)(36906005)(966005)(356005)(45673001);DIR:INB;
x-ms-office365-filtering-correlation-id: d0629d71-8aa5-409b-e74c-08d9b3aabdde
x-microsoft-antispam: BCL:0;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2263:
x-ms-exchange-crosstenant-originalarrivaltime: 30 Nov 2021 02:40:15.7762 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Internet
x-ms-exchange-crosstenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
x-ms-exchange-crosstenant-network-message-id: 
 d0629d71-8aa5-409b-e74c-08d9b3aabdde
x-ms-exchange-transport-crosstenantheadersstamped: OSBPR01MB2263
x-ms-exchange-transport-endtoendlatency: 00:00:02.9301672
dkim-signature: v=1; a=rsa-sha256; c=relaxed/simple; d=groups.io; q=dns/txt;
 s=20140610; t=1638240014; bh=Fy/h89yuiTI75QSgkbzBjzETVBGDchPJjPuWkqQlyOE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=eAiVe0Z8yFNMo3DID1yO6OBVTp+2KOe/aNkVSdrJYjFsV2CZDiaN1/KZm3FPYoxtZHX
 qXmtDKYcwgpMk9h6fAFvLy+83OaVa6M+/xGcVRpqUlCjWjvAXDf3bCRRsUebYq50toGxl
 UwzGUVRjsiCsNd5AygU5YdZrYju8BSkBMSs=
x-gm-message-state: PIZXVlrJfQGnUyuxQX1kHLrXx881120AA=
x-google-smtp-source: 
 ABdhPJxghDhYkVE27PIX15gSkve0VCVMc1WlboO4kGeSY/rSXRHVML9dBgqzjuJP2WU+m4YCkmTfuw==
x-received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b10sm18876554pft.179.2021.11.29.18.40.13        (version=TLS1_3
 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Mon, 29 Nov 2021 18:40:13
 -0800 (PST)
delivered-to: mailing list kernelci-results@groups.io
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-eopattributedmessage: 0
x-eoptenantattributedmessage: 53d82571-da19-47e4-9cb4-625a166a4a2a:0
x-ms-exchange-atpmessageproperties: SA|SL
x-ms-exchange-processed-by-bccfoldering: 15.20.4734.024
list-id: <kernelci-results.groups.io>
x-ms-exchange-crosstenant-authsource: 
 TYCJPN01FT005.eop-JPN01.prod.protection.outlook.com
x-ms-exchange-crosstenant-authas: Anonymous
mailing-list: list kernelci-results@groups.io; contact
 kernelci-results+owner@groups.io
X-Microsoft-Antispam-Mailbox-Delivery: 
 ucf:1;jmr:0;auth:0;dest:C;OFR:CustomRules;ENG:(910001)(944506458)(944626604)(920097)(930097);
X-Microsoft-Antispam-Message-Info: 
 =?us-ascii?Q?bGn2TOd00T8X6MOgd+L9UQJ/QgZ9w5jI1zp+oN3FdI9ppAnZANUdUIU5M6k0?=
 =?us-ascii?Q?4cPUWbFFwVRr56D61sGlzrpq/U7clFAf63TwtRNfEqM2iWgm7XZYkwxDbeaM?=
 =?us-ascii?Q?3B1kvGiQFoigKmOvmeMFDmfTKouVieiPgKgutyZGKmEnpXgSxKDm+tQDUmL3?=
 =?us-ascii?Q?pB+K2+f9jvIjsa7PRnQhttbaPkP+Ovk+ibmh3g0bXWk0ut4e72JegUXE9w+G?=
 =?us-ascii?Q?VHKqlMvYX74p5qALo20X+XTmnioOQkIUt4rYfC7J827RS96ATisXiKtuxp7L?=
 =?us-ascii?Q?xHlEQpD9A4qIxilRKckje6HrL8G2wXXVA1BpcHaC1LCirZXCc8oXzmpRElmB?=
 =?us-ascii?Q?8UtUEBNDK8Ge43MsGddZl0M82pYclSbGhRM39YFIYhfjP6r9IUp7P0Gw2riM?=
 =?us-ascii?Q?FgB19P4cJ9EHvXC2WdLT1WUc0NJI/cZY1zrZip8QZ6m/bmTyBnQGI7ZP4dlW?=
 =?us-ascii?Q?dkzgskG5Lf/RDQ/YkuQ/jeWdLImN3u3TABeZggngN5Piw3F3D5LOeKE/s3Kt?=
 =?us-ascii?Q?bVwoO3NiVOsrDzSus949lc/XvUF6Bi8fhh8ZyCWHhm3nfOEf7vu4jU47OWmv?=
 =?us-ascii?Q?w3E3+c7AIrmEY4gGPICC+3TjH7ZBfm7fA2gw/BjPlPA4dS64hcoky2IXbjzx?=
 =?us-ascii?Q?+NrZtnmkoSs77L8BWc8ylBEPfRyGSWfBXtkLlTJdfRAfAqFWveLWoF33w5Eu?=
 =?us-ascii?Q?wOaYgeIvFuh5rO/mN26duyP6dZA1EEws6w6XOpVhvLLy1GmBoaP5SNQD0pW7?=
 =?us-ascii?Q?vCQ4KH/0mewCxE6sjwGkw6e9xVCK5JlyjkB6zGcySy5kXCcgSQeJluZL+h8+?=
 =?us-ascii?Q?g98S0NJFkakbJZZTKTfvtpmI0v9VWpw+Wo2FyNaMfTg8ipUFq/0tTh892SOL?=
 =?us-ascii?Q?X/dofTKp9+xOyFcIC+cFL2ompbxnLYtk5KHwwLDNdrausp7pL2CCN/RKVoVP?=
 =?us-ascii?Q?7Bnx0eqV6hJm9IIiVoPwZskTz2Ru/GFKHMjHgWNCwSGTl4mTeIMlyyPvT0Xs?=
 =?us-ascii?Q?kjlVTKgIakOoZfPJjVxtcJShWjlWWCJEZM7w5nyfuHwKmwGX5aaB1yTF8DLK?=
 =?us-ascii?Q?JzrREJ+HkIj8k83DNbQt3CxAOt7U9zhWZy2oRk4W6Zz1nmFT0i/B0LFBbDqi?=
 =?us-ascii?Q?7tXhCi4fuelDMzXmeKKdzopvOY+JGdWPVvLEwkTgbprTGpJ9Bka/MjeF+Ene?=
 =?us-ascii?Q?KDp2gEGm8Y/M9uLMJshrSWP0OTlw6DsRt/1+zG7k0h80I30K2jtzr/3zFQSR?=
 =?us-ascii?Q?TTV79DKcCafAuIaxlklI6BFL5d/ORBVOXX9FGyr62PEVeEdaJhU3NHQ6yiN0?=
 =?us-ascii?Q?y0qbZBb6e5ZjbuixdGP5CEQnQeOVNygBUUo1BmmwpC0/zcVY5xgih1J9SnLi?=
 =?us-ascii?Q?+Kzr75KMnxv7hKU2HN/0SfoURnGNlxirQIbsa87x9rHXkDCTagrFqZtPolW2?=
 =?us-ascii?Q?KJzw6tcXiLUFivYizVNP6XDiFQ4XdRBw1ey599ClNrOVO7dE8+tMpWfCUjmN?=
 =?us-ascii?Q?Gz8wT7VmmYUXyKWmt2JugwsvG2tB/EtK9QI5ivnCJfdVV1ZMwWsENCj0nnxm?=
 =?us-ascii?Q?ks2sdGjVI7M2Ch9xHMhrB8suX+GbFSD3Ays//wkU8Pg9choToKr75+ySBP7a?=
 =?us-ascii?Q?4ysseP9seuGjXHwYqeulW4zQKc7i8Pcq8Isdy5y6nEbMFrP3kmF61OSqlXsO?=
 =?us-ascii?Q?wbVTFVV53T+TMp7QbW5suNEj07H1is0P1r0gnStIP9ff996xL86tDn0rhlls?=
 =?us-ascii?Q?yy5U/SdvR4qEvrFN1CLS0uJ+aPkmG5o7UNXQDQSvD9T7ew9Dy4hAcpZ9JRwI?=
 =?us-ascii?Q?wcPONBdl3NYSW9AmzJUEbktllcx4rXsUsR1XqjVeulIeFxRxbOC85NnhQ5O4?=
 =?us-ascii?Q?mSQqEDvNmRGDoqZ07WAOJ0aj4yBagushJmtmRhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2D0F9A09203DC4EB1DADD3E40506D14@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.217-cip62)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1

  Details:  https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fkernelci.org%2Ftest%2Fjob%2Fcip%2Fbranch%2Flinux-4.19.y-cip%2Fkernel%2=
Fv4.19.217-cip62%2Fplan%2Fbaseline-nfs%2F&amp;data=3D04%7C01%7Cchris.paters=
on2%40renesas.com%7Cd0629d718aa5409be74c08d9b3aabdde%7C53d82571da1947e49cb4=
625a166a4a2a%7C0%7C1%7C637738368188646705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=
=3D7LnO%2FA7MHJS0xUPAeS9nCf7zN%2F%2FrvLPFV6145yUsHMA%3D&amp;reserved=3D0

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.217-cip62
  URL:      https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fcip%2Flinux-cip.gi=
t&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409be74c=
08d9b3aabdde%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C63773836818864670=
5%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DhOL0KaegmeL8SQ%2FEzNswHHWMoQJEk1rqfjEa=
%2FJyLqyE%3D&amp;reserved=3D0
  SHA:      dc62e26e3be875a7324b85b8274c13a335e610dd


Test Regressions
----------------


platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig | 1

  Details:     https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fkernelci.org%2Ftest%2Fplan%2Fid%2F61a58c2989f6953bd118f6e4&amp;data=
=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409be74c08d9b3aabd=
de%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C637738368188646705%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C3000&amp;sdata=3DL9ByWHKrbx12yj7jyYfF6Suelbe62jB2Kc3fU68Vsb8%3D&a=
mp;reserved=3D0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fstorage.kernelci.org%2F%2Fcip%2Flinux-4.19.y-cip%2Fv4.19.217-cip62%=
2Farm64%2Fdefconfig%2Fgcc-10%2Flab-collabora%2Fbaseline-nfs-rk3399-gru-kevi=
n.txt&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409b=
e74c08d9b3aabdde%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C6377383681886=
46705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I=
k1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DKKHs4n6I51CvSQqx81BJfcsQCUVWqXQx6i=
z9uFqMpsA%3D&amp;reserved=3D0
  HTML log:    https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fstorage.kernelci.org%2F%2Fcip%2Flinux-4.19.y-cip%2Fv4.19.217-cip62%=
2Farm64%2Fdefconfig%2Fgcc-10%2Flab-collabora%2Fbaseline-nfs-rk3399-gru-kevi=
n.html&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409=
be74c08d9b3aabdde%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C637738368188=
646705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6=
Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DBqI2BE36xHpblfy6R5ccnjmCZUJxLaLzv=
dIdXv2S9Zs%3D&amp;reserved=3D0
  Rootfs:      https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3=
A%2F%2Fstorage.kernelci.org%2Fimages%2Frootfs%2Fdebian%2Fbullseye%2F2021112=
6.0%2Farm64%2Finitrd.cpio.gz&amp;data=3D04%7C01%7Cchris.paterson2%40renesas=
.com%7Cd0629d718aa5409be74c08d9b3aabdde%7C53d82571da1947e49cb4625a166a4a2a%=
7C0%7C1%7C637738368188646705%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC=
JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DK3HF2BVHIx5=
d7tZkGbPRdXOzxVR9os2cIgZyDvIyNgk%3D&amp;reserved=3D0


  * baseline-nfs.login: https://jpn01.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fkernelci.org%2Ftest%2Fcase%2Fid%2F61a58c2989f6953bd118f6e5=
&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409be74c0=
8d9b3aabdde%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C637738368188646705=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DRpV0o6jsq85yfaSSBit%2FBm76%2B8%2B4euh89=
yy1YcF69ec%3D&amp;reserved=3D0
        new failure (last pass: v4.19.216-cip61)



-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Groups.io Links: You receive all messages sent to this group.
View/Reply Online (#19927): https://jpn01.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fgroups.io%2Fg%2Fkernelci-results%2Fmessage%2F19927&amp=
;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7Cd0629d718aa5409be74c08d9b=
3aabdde%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C1%7C637738368188646705%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C3000&amp;sdata=3DGv9OPjqRdI15RyFITwPcvyisCeoIEJfUNmODV4FW0Ys=
%3D&amp;reserved=3D0
Mute This Topic: https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Fgroups.io%2Fmt%2F87394828%2F881120&amp;data=3D04%7C01%7Cchris.pat=
erson2%40renesas.com%7Cd0629d718aa5409be74c08d9b3aabdde%7C53d82571da1947e49=
cb4625a166a4a2a%7C0%7C1%7C637738368188646705%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda=
ta=3D8DAUtVMZpoVZqR%2FPhSBNIGJeM7ZXb%2FpUSo9Zba92YWg%3D&amp;reserved=3D0
Group Owner: kernelci-results+owner@groups.io
Unsubscribe: https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fgroups.io%2Fg%2Fkernelci-results%2Funsub&amp;data=3D04%7C01%7Cchris.p=
aterson2%40renesas.com%7Cd0629d718aa5409be74c08d9b3aabdde%7C53d82571da1947e=
49cb4625a166a4a2a%7C0%7C1%7C637738368188646705%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s=
data=3DqlHefhsP6qTbzXQnwcL8u%2FJTsoSXhRxDe%2BK36%2FOCCbk%3D&amp;reserved=3D=
0 [chris.paterson2@renesas.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



--_002_OSZPR01MB687760A42FAC36D478192D11B7679OSZPR01MB6877jpnp_--

