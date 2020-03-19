Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F800C4332B
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 00:34:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E2B20752
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 00:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E2B20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 833FD87998;
	Thu, 19 Mar 2020 00:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oajv5qHAAHQi; Thu, 19 Mar 2020 00:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB11F87775;
	Thu, 19 Mar 2020 00:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1650C087F;
	Thu, 19 Mar 2020 00:34:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F0EC087F
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 74A3B85F33
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zmm-O21PA_At for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 00:34:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A8C1B85D56
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:34:27 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 02J0Y3J9021505;
 Thu, 19 Mar 2020 09:34:03 +0900
X-Iguazu-Qid: 2wHH6kkKp444IIz3fI
X-Iguazu-QSIG: v=2; s=0; t=1584578042; q=2wHH6kkKp444IIz3fI;
 m=cvvfH8ztIP0Hqz+kAjlS8jo0pr3xEnm3BVE4W6kw0RY=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1112) id 02J0Y0ml007032;
 Thu, 19 Mar 2020 09:34:01 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02J0Y0us000159;
 Thu, 19 Mar 2020 09:34:00 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02J0Y00e020758;
 Thu, 19 Mar 2020 09:34:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UINaYgh7nUmuYJrbpRVEZKj62gRC3Y+Se2wAExzeQi8MeF2uxf71Q3up3m0vLl40GHgtdU5bEJYIL7v+YzABw+CpqpMmITqKXJ5MY1A9p6YtFVOpsnBf7cnj0gh4Z3Siv/ahTaYLSVmMgPhv+4wuxSSkSz1PViaI+vtNZoWDLCacERwAWUmqZBkwqDhE4VaKVKlFw+o6Yfx9j/t9WiyHkVKLuHvHdSWTqr2KyltBr/hjpO96bdCB6MGhxlb/+/BtvvPH+3sNzjSNW13hpajdZ4ScVDALYv+YR4+C5ikGJkv0Gkuq0aBo96jtugXFxtWKjw8BZdrZZSpDrO6tG9k92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHoRiCz40AFULf7Yl+9GF+SxttA/vOPPn2A4h/dpELM=;
 b=eiOqgNGb6AfCPbwIHWMN9nlfCG7Tq+iXmBCf3akDVtP/k3V/SYcnGotGLgSnW4aoCY7BxiNqF+5OoZv0X0P7c4ytiqHfLCazLCPthw6ed74/MpsfJpTV1au3lSHniWpypn5Qbr9xSjmaf1APfAd8miDrNkPsVykVYK/yLsUUJyn21HiRQyy2tnhi5Pi6hrLxNidDyeoAfE5jEuaBl/XnFJJOTLYAhIxIjI8YFiFXWJAxA9Ac54Hpql7LeRvnODNUQdX6AyJZsJNi/Mh/0rXjpgg5V6a4zO2pIcHkoU7VypDAxXUex3I6UKieQr9H/gBgDSeBMmnXLhcC3RCyk5vjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Thread-Topic: [ANNOUNCE] Release v4.19.109-cip22 and v4.4.216-cip43
Thread-Index: AdX9hY9kXII0NaBARSi5V62SgZRs/w==
Date: Thu, 19 Mar 2020 00:33:57 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667E6C30F41B7AB295853B292F40@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a0e36f-cca3-4250-10ef-08d7cb9d3675
x-ms-traffictypediagnostic: OSAPR01MB4324:
x-microsoft-antispam-prvs: <OSAPR01MB4324A8314C191E4B3545DE7F92F40@OSAPR01MB4324.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(71200400001)(81166006)(8936002)(2906002)(8676002)(81156014)(66556008)(64756008)(66446008)(66476007)(66946007)(52536014)(26005)(186003)(4744005)(76116006)(5660300002)(966005)(316002)(7696005)(6506007)(478600001)(54906003)(33656002)(86362001)(55016002)(6916009)(4326008)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB4324;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Z8OOfRJL0w82OsQ+URJQEteX8UiTNtLIsSwzj647+77PtmV3y5D/sVwxBq5doe5avpJAP9BYWXYN8DMDep9nQX54PqY70CS6IHj2HbCX4Y8H2ul4I0rsi5MYdomGCIMgHLNM0unNVrrWUXQpMUE+N7wGiVUmEfIydaQALS8QHF3sNL7FqVPNck89EbkOC12IY6zDIVXcaGlOzw/Pt2I61iDJ76IdsKm0Xs03q3E7m39aNfwde4so7TP6kmfal5eB6RI+L8jYGvxIoMcDZCvJffbIdCGUuugK8pPIemQv6p7MVb8ygQVaYtiq12jH7tySwDk71uU9qMQFCFhUFowkxzxdqorLVLnn5le4qKD1tJLaNH6HLNGIakUSK7i/paEzBHMGd1MBolDvFWOLdJYBb4nbtULSoNn9psq1YxThmXuGsTcUJIlAXfZnVMq2ybYthk2n7eHcnmNdbtWcHV4Xa//uJl7eqFPuGkzhtwmcEA6zF/d5QVJ3w9lp0SWx0EabZGGUWyCgdMUKNE4UxNZCw==
x-ms-exchange-antispam-messagedata: 1l3p9kn6Fmo4Rm/qF5chvO9XIvq2CapvKgncusMQlPsbFgZfi04/mpF/vrqSVcHdG31hMMH9m44QHbDJ5YfhGXVX4eceBPU3QvRuL3h0ABNP8NHLjKrWsf8fGVERgmKV/72s5xeagWr29r+i5vXpgA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a0e36f-cca3-4250-10ef-08d7cb9d3675
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:33:57.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1oaStfXnrmVQ8nc0geyfL9hgd31et45t2WVVFbmDfBzVPnsZsQipnAAqwkx7EjMG/MEw/DzOVg4oVX0d64axc6eTrqok05Fbym9gCrnjUs8rxsNhx5/7797HeziYcGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4324
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: wens@csie.org, SZ.Lin@moxa.com
Subject: [cip-dev] [ANNOUNCE] Release v4.19.109-cip22 and v4.4.216-cip43
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

CIP kernel team has released Linux kernel v4.19.109-cip22 and v4.4.216-cip43.
Release was delayed due to test confirmation delay, sorry.

The linux-4.19.y-cip tree has been updated base version from v4.19.106 to v4.19.109,
and linux-4.4.y-cip tree has been updated base version from v4.4.213 to v4.4.216.

You can get this release via the git tree at:

  v4.19.109-cip22:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      94c283d68eaf9e242105a4516a00a516068c61da
    added commits:
      CIP: Bump version suffix to -cip22 after merge from stable

  v4.4.216-cip43:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      0e44e8ae8f3be94257c32a69400a69eea9ff5cb1
    added commits:
      CIP: Bump version suffix to -cip43 after merge from stable

Best regards,
   Nobuhiro
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
