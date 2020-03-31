Return-Path: <SRS0=Mg3o=5Q=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766AC43331
	for <cip-dev@archiver.kernel.org>; Tue, 31 Mar 2020 01:48:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA46206CC
	for <cip-dev@archiver.kernel.org>; Tue, 31 Mar 2020 01:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA46206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EC9BE24AF4;
	Tue, 31 Mar 2020 01:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8DE2cm2FJ2U; Tue, 31 Mar 2020 01:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BE34524A5C;
	Tue, 31 Mar 2020 01:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A159FC07FF;
	Tue, 31 Mar 2020 01:48:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94DC7C07FF
 for <cip-dev@lists.cip-project.org>; Tue, 31 Mar 2020 01:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8C54C24A5C
 for <cip-dev@lists.cip-project.org>; Tue, 31 Mar 2020 01:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UBQ5c6PWrYW2 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2020 01:48:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
 by silver.osuosl.org (Postfix) with ESMTPS id EBAA624AF1
 for <cip-dev@lists.cip-project.org>; Tue, 31 Mar 2020 01:48:00 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 02V1lbmW030970;
 Tue, 31 Mar 2020 10:47:37 +0900
X-Iguazu-Qid: 34ts1iCWJY91Nrgexz
X-Iguazu-QSIG: v=2; s=0; t=1585619256; q=34ts1iCWJY91Nrgexz;
 m=eklW37mxsFsDr+44aJGhHZE8Aqvnb8eKAtZpYz8Hj68=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1510) id 02V1lYFa011197;
 Tue, 31 Mar 2020 10:47:35 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 02V1lYKe005912;
 Tue, 31 Mar 2020 10:47:34 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 02V1lYnU022365;
 Tue, 31 Mar 2020 10:47:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk6tJniF1TdLqRrBnD4SF8aPWKcFgJxiBzP4G2rZNU7kDcAv4u/Ii94DZRdvGQQYGWs9FmM9PYuqNbKDMkLxeK8FCaNNpLTdpDTK5NcbfMUVyG3I9kZiQOpjRxq6fuQpRcmG+XYscujQVs46MZG7vKjfnloIp/OaUaamrjPAi5PJC4drLGZzogeBYN1duQODLT+BVGT8bxo4Xxel9kJ/4RF4kS3qlyuYylSMZ4Uexme9zjUPlh5PtZ5s0p2+uSaiEfaZ5jByfYVRtCYNFmXtpxpdrocHsyDf2uEsPHdC4LEr9qa3JJ4xpdwJR8C0n7x9EBR413x/cds5sprzOU6kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdRzj8HDoRbVZLcFXWes39qaO/ZquLhQ4UMAP+SySL0=;
 b=lsMu/bF+A5PcrRvU7NyDEefUZgxrM/UsXGwO/aYh2b4evS27Ms6I2dNM7PmPwzGMPOlXN8wzoJ/gVDtYiyFEOQ5ECiUiJtW9pfCbKDlBuox5uffn6H4vt+ZxSuPHLTYVnTWd499N1qx85di6by7eydCbFdWkZYb+XNjVYKhYFeThWMhkMOyG4fB+BiWv0yZUhEXkw+agCbqQ/7knG1LcMbe0KheSTNk8ej8I8X0DM0GZC+vDgdGqagU5PS3oNcLC8lHJuMz9HIN5HIdUpeZbNJmWvygdX8nFaLjK3J6N38wlKEzXuk6U2s98FZbw2TlUbnsZheQBhaZ6256eNdTDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: [ANNOUNCE] Release v4.19.113-cip23
Thread-Index: AdYG/IkZq7HozWS/QmqcYlJe0wf/FQ==
Date: Tue, 31 Mar 2020 01:47:15 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB366742FF65F76126C72C4B1D92C80@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a0b05d2-b604-48f8-b452-08d7d515704e
x-ms-traffictypediagnostic: OSAPR01MB3604:
x-microsoft-antispam-prvs: <OSAPR01MB3604F08B65E7081C1C9C1DF392C80@OSAPR01MB3604.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB3667.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(66556008)(478600001)(64756008)(4744005)(26005)(66476007)(76116006)(6506007)(66446008)(186003)(66946007)(8936002)(966005)(71200400001)(2906002)(52536014)(55016002)(33656002)(81166006)(81156014)(6916009)(7696005)(4326008)(9686003)(54906003)(5660300002)(86362001)(316002)(8676002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2l4KoX4jTuiYq3KUOv21IYWBwhAPGQxYL2Pb8rXh1hnoh8rTPlzaHCaga93Uc26+emMb6ZlAvjnhi/xdnnX9daFu8Er09j+gC7+kFRyrrTF2gLlKpp+tgy3Yt04VDUaIH487/xWeq7RBWSut5KEwukWIMe2wKjjbS1rXubdYlh6Np+ZD3LmWE41fXDmlGGco08qWxxWc2YVCMD6ZUWVh8iWmkuhCXedS8dSL7a/HVcfkN2M4imm9ODYJUsBGkWXm6elI5ENiP0ehfHkjPC96JTa+bPAJn04SRIdLBuS5i23TNOczlyozsyAfP4yIcmvE6polpdslhpSsNgtRWKaMGLBCdTN86FylzfqV52J60Wzh9PIjVgqboTeFbBynaxVczBXZfLCha9TCC+OKmylGNNwiVRflrfMyAgi5ZY6pQIxbTYCb92SKRjAogB5BZFwBp59iin7vSs2CIOSejb4GdxqxIR0Svq/9SC11iLYo8RyOBJUgU0hoDXGrvZopmQLiTvzMp5618Gja6uqQ/t82OA==
x-ms-exchange-antispam-messagedata: DD3vTi7R5AhbqPf+XCDju9UZpzL32PEmhtmY6PtVFLjCkbSDE6Lh24TDlKghGxnWoYBtGu2Y1kKanPv40wYl6KtY/zQAoe08pfHHzl+p+sXJSGEzWjcT3mX0o4kIjtH1JfNLFs3Vu2SV/2f6Y5LZGw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b05d2-b604-48f8-b452-08d7d515704e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 01:47:15.0200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2r9CRmId/L4uHpLOEyLbql4+qoLynpYINBSL4KGycqTJTZ0CTSP2LS8DdoZgq32r+UEgTp0BOTXZeeapzwag1XcFBBUul8XqtlMf1Q6Iy4DVo2L2pE834Qmw8VgjmwzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3604
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: wens@csie.org, SZ.Lin@moxa.com
Subject: [cip-dev] [ANNOUNCE] Release v4.19.113-cip23
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

CIP kernel team has released Linux kernel v4.19.113-cip23.

The linux-4.19.y-cip tree has been updated base version from v4.19.109 to v4.19.113.
You can get this release via the git tree at:

  v4.19.113-cip23:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      	52f7171e0b7fcf44b37d9dc270de2576bcefe169
    added commits:
      CIP: Bump version suffix to -cip23 after merge from stable

Best regards,
   Nobuhiro
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
