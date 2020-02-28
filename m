Return-Path: <SRS0=0JtD=4Q=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48369C3F2D2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034FB246AE
	for <cip-dev@archiver.kernel.org>; Fri, 28 Feb 2020 13:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034FB246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF85287B62;
	Fri, 28 Feb 2020 13:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHi6rtpcNmh6; Fri, 28 Feb 2020 13:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49CBB87B4D;
	Fri, 28 Feb 2020 13:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BBEC0177;
	Fri, 28 Feb 2020 13:44:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01769C0177
 for <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2020 13:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E47DE87B62
 for <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2020 13:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfhzkS6tZo5N for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2020 13:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1AAA687B4D
 for <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2020 13:44:11 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 01SDhmHT003438;
 Fri, 28 Feb 2020 22:43:48 +0900
X-Iguazu-Qid: 2wGrHliUwtO3XIngTQ
X-Iguazu-QSIG: v=2; s=0; t=1582897428; q=2wGrHliUwtO3XIngTQ;
 m=IHDtdTf7I2jujwJ/rr9kBmb/2qpQr/qNjMKU6FaIqS4=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1112) id 01SDhkNH035146;
 Fri, 28 Feb 2020 22:43:47 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 01SDhkqx008840;
 Fri, 28 Feb 2020 22:43:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 01SDhjue015248;
 Fri, 28 Feb 2020 22:43:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghbqqMI55qBGNeytcA3v9S427FTTU9OGaJtGpM7S1zYwOC3d/14jrh/dXm7cCBb3eEIAWK98evDa0TguEdCi7t7yihsWbU6JrHXNUVnF517G9YGBylpDC2WwY4PLO/8R23QHty7NxxHAtYkhi7/q5o3tGw1FLnQc1soI4hjET8ejY/Hv/DnCmllZUlmjx0o2Wd18rVMCo7HuMVZ4VAvgfCS2Q4U919Gtr7EpCYu1eCbnC7ecxhZKgwx/wyK6LoyGAcqR3cgCRRy4VdFVZdjjLeCm7JnnZk8TOE4HfPdo1RRX/8X5poKvKgkjX5YcQcxHtHLL5iCz1BfppZZ1TU9JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovacKkca+GAsG6Rx0dn2BCBDvCXE0Ei6Oor/gQJjD3s=;
 b=FrjYpNzsk0qaFlpomdfKLc8uYB/ULXdFr2uzBCv2ORgaljiim0vKqwsv/mhcyi3Ru7LLDzpOOES/eaiDHYLINSsda2NTOtOK/JsBI15hj7uIBtU86AJnZz1TsGBjaRCLXdF2eRHmfKDJV+l9udIxPBRQapWlpjBeTD0gmnXREbtjtx0LTsFIslYPINnllrp7witMQ8PgWhj1QY77tigoQ8SB2eMvPGG7vTx9jWqUeZixlyUJYVy4/JlLFjn9LhrZ2G4HRuWazgqTeRCOK5nL8uheNUkbj3edcH/Q8OWwAa9p0JqVw1oTAqPZwrPjMDilxh2FnOt5ZqdxqflAv36/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: [ANNOUNCE] Release v4.19.106-cip21
Thread-Index: AdXuM6SPZAC85KKiSoSFBBBj9LWlOQ==
Date: Fri, 28 Feb 2020 13:43:43 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667E6430A1E38A9DBEA8E5092E80@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1be7fabe-fea5-41c1-c882-08d7bc543a55
x-ms-traffictypediagnostic: OSAPR01MB4883:
x-microsoft-antispam-prvs: <OSAPR01MB488372866F66FB6E36CC835492E80@OSAPR01MB4883.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(5660300002)(2906002)(4326008)(26005)(966005)(186003)(86362001)(54906003)(7696005)(6506007)(478600001)(316002)(64756008)(66556008)(81156014)(76116006)(66446008)(8676002)(52536014)(71200400001)(55016002)(9686003)(6916009)(33656002)(66946007)(8936002)(66476007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB4883;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqAdAgjpT0xwLyDvaZZCjmUp5922/U4pUAplD2j+qAPxJittIV4Bw7MnzAeP5h9K0sN7/jwAAOSmmWTolbw4cccaVztWbd8y9renMWt9adKhDZU4ngPi5dU2QmSS/4fe0QZv2DpHN2c/VTdW+qnRpUGs0sH2rBpCRsHB82oy/gAZNG58FTVIC3Wa1T8YixhqndMcIbdirPgkmQS1e+wzdoWvv5mi6sJbQj703HBcqTXBAbCs1yLmgsIjwCKslaDt5IctNxYMwMco8+slacFKSzwvh60eLRetQT7d+ExsnRHJT66vpSXly3DxlL7Kj3hgXUmGQr0kW16ATEte+OgXPlRL6q+8vTuLcIxdLarhe+Kuk8GMo+bNnTM757NsUyywNGNL45dZE0PhujrMLgL5wKiqfBFeF7ruMBN51tRF3bqugnYnz2aF0hBzK9ggoqFtFMdbSn17LWXp0ChXWxx0LPsAsEUfacOsn3Rgb36sXH+wp3JnSq+1fsrW2ra+zNmaTj64DFAFy6/HVV5z0hkL8g==
x-ms-exchange-antispam-messagedata: PsP43GRpNrmKQo0zrh0qk07KneECuZ2Sh6juSYJ2hTBVzXIR8eooKQbv5NmT6et8bcKqFPpx7mJRUsTtPMczF64stXr3kLdKUS7T8WKt0FqvSYhSHQaKni51Ox+IsIOMXxno72eUxY8NykiKxnVSRg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be7fabe-fea5-41c1-c882-08d7bc543a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 13:43:43.6730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXiyQug3h1dv3pr1rGStQYKuKG1/75Ns7lf/2LH/65/ysAQwic1Sc61yXmkAgnx4lJwVFOIJb22DZJT4Fw5R9svLAQl7HwWyzFNsPUo+V6z1QRjxlewFDb6bboTG2sC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4883
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: SZ.Lin@moxa.com
Subject: [cip-dev] [ANNOUNCE] Release v4.19.106-cip21
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi all,

CIP kernel team has released Linux kernel v4.19.106-cip21.
The linux-4.19.y-cip tree has been updated base version from v4.19.103 to v4.19.106,
and USB updates and cat874's USB were added.

You can get this release via the git tree at:

  v4.19.106-cip21:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      0bf4ec5b1b8419e1c67a72182ee8d9b8d4a9337b
    added commits:
      CIP: Bump version suffix to -cip21 after merge from stable
      arm64: dts: renesas: cat874: Enable usb role switch support
      arm64: dts: renesas: cat874: Enable USB3.0 host/peripheral device node
      usb: gadget: udc: renesas_usb3: Enhance role switch support
      usb: typec: fix an IS_ERR() vs NULL bug in hd3ss3220_probe()
      usb: typec: hd3ss3220: hd3ss3220_probe() warn: passing zero to 'PTR_ERR'
      usb: typec: add dependency for TYPEC_HD3SS3220
      usb: typec: hd3ss3220_irq() can be static
      usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller
      dt-bindings: usb: renesas_usb3: Document usb role switch support
      dt-bindings: usb: hd3ss3220 device tree binding document
      usb: roles: Add fwnode_usb_role_switch_get() function
      device connection: Add fwnode_connection_find_match()
      usb: roles: Introduce stubs for the exiting functions in role.h
      device connection: Find connections also by checking the references
      device property: Introduce fwnode_find_reference()
      device connection: Find device connections also from device graphs
      device connection: Prepare support for firmware described connections
      usb: typec: Find the ports by also matching against the device node
      usb: roles: Find the muxes by also matching against the device node
      usb: typec: mux: Fix unsigned comparison with less than zero
      usb: typec: mux: Find the muxes by also matching against the device node
      device connection: Add fwnode member to struct device_connection

Best regards,
   Nobuhiro
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
