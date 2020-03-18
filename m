Return-Path: <SRS0=NiLz=5D=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D9AC10DCE
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 05:42:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB9120768
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 05:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A608860FF;
	Wed, 18 Mar 2020 05:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NU8nw_Mo_Dic; Wed, 18 Mar 2020 05:42:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B0C99860FC;
	Wed, 18 Mar 2020 05:42:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96D40C013E;
	Wed, 18 Mar 2020 05:42:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4845BC013E
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 05:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E2F12041B
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 05:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAgkMWO2kWvu for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2020 05:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
 by silver.osuosl.org (Postfix) with ESMTPS id 5E333203BA
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 05:42:25 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02I5gNgf027346;
 Wed, 18 Mar 2020 14:42:23 +0900
X-Iguazu-Qid: 34tr8v5egXOjVlXvzF
X-Iguazu-QSIG: v=2; s=0; t=1584510143; q=34tr8v5egXOjVlXvzF;
 m=ukMJ/87pn8bKnyxa3TlMrL0F6XrYJQZHsEcSn0ivp84=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1512) id 02I5gNUB019734;
 Wed, 18 Mar 2020 14:42:23 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02I5gMB8014808;
 Wed, 18 Mar 2020 14:42:22 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02I5gMfL014280;
 Wed, 18 Mar 2020 14:42:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD1VBi9LS+AYH8xq5NXpBDIMz1Y3qEHZfNdpVaWpm+SOK//8vdnkyF+bgGyX69kjrud/+7frZyNH5F2E9MJIs5E2yxyriaqI/ttBRmN8b8DZ+Ob0eAsBmjmSAKJ4wNoJfxEXNV3LjtOdKtJmUuJI5BqoC0KrokvpGwoQDy830+Jcyt3RSk/oRXl4QAFd9XgIHGPUNrrVagFERKrC3wz/ik3TeC64nsiOkMWYXTNVdYN0KMvNgHcXaaNcT+lF22e+B1MQ/5S5TBAz+8+uFMQ+6k4Dv32NfHesGUO7e8jA/4ZDR5r4lZbZoAO5h1/KD1GTYYQFS7ACSFi0gEkMMQljOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Tp1Z0fAV0i2/blhQDx7pbGufytAAHwgknATMLCHgA=;
 b=gOSGmIK+9xXylETWxOVgNAI1YeBeaEkwv0wx1w2V1oG+xTz8zJwfFjB4k40HoT+HhwdrOc6FlELIbzkVLHN+Hc4+9ldGZIy/FD+zYUGOeUhM1wxHGV4JuNvvIl+WdIJrPgUpmIMG4+RfPsDt9Q9DXOkU4Ej7SANyOxaYePAn8bZYCJF/eYDc66+1O7euWcyv1ePyIr56D9SjrWjG78Ggfg382LGyCxLT0ngsiZ6QxG4emu7Muljfq69o9wVp88iF06pinj/TuvfchEjFyCLIcKTDPn79r39yli779UVabCPl1qhUKTfLZ5/uH2iSkNRGx7I3r65L1LweLnQX2bFGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>
Thread-Topic: Please check health for renesas board on LAVA
Thread-Index: AdX8pB3xKWT6vpR3T+GXr+q5DF2xkw==
Date: Wed, 18 Mar 2020 05:42:20 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb4354be-7f23-4f41-3502-08d7caff20aa
x-ms-traffictypediagnostic: OSAPR01MB3458:
x-microsoft-antispam-prvs: <OSAPR01MB34586C6ADB7ABA948F9AB95392F70@OSAPR01MB3458.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(33656002)(478600001)(966005)(2906002)(86362001)(6916009)(52536014)(81156014)(81166006)(8676002)(5660300002)(8936002)(186003)(26005)(316002)(7696005)(71200400001)(4326008)(6506007)(66556008)(66446008)(55016002)(9686003)(76116006)(66946007)(558084003)(66476007)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB3458;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXchuR+Q0/+TB7TjmrW0ZUr21XVH9a8zTeKrwlikC7uP2znzuHzug9ZxxgNdO/BmIyFEPORLAlCT3rM/v/06UQt8BoJA4d7biowq1cUMtJzBmSyya8r98KHjGiPvZ3J2EatUiUtlxDYGKv0JavbNnuv6o0E+XNPsCXA2IDoKm8HqoovFlwoARupr3N2jC8vntFT/pgJrWKGV8lFJQ2aRG696aMBHnu0Cvq6wlmIJYvCoLqhkP87McrSjU15GIDGNtBjHlLKu0MOl1IrJyZLlWRYXymdnT5kU4zM3UA/KBDccZl9iAuXS2jX653QLp8vrLItaCBoI+i7fJ+/Ifl58SnOUJF3EibuLd2y8JANCucT98h9oEMbOhs2vjOfInVvPHhlIGqiQsiJlsGJExPDBX0Kk2Qg9OzNB7zFt53uKbjAtXd1OXsUvgQCUW9yNhEadLeVUnfjmEIROq6l/vfk+w/hfKltKL0ITNzTpEWDdQO+mf1efW/wHyVmWppCqz00rp88qxxP5D4WGTYmKVOiRXA==
x-ms-exchange-antispam-messagedata: 6mwCULGmASSet7dqSHQnGCMVOCDQOfWbYaN+zvxCEgNhYUzsf0J6jdeJPTUEv6IlWb4TJtaPORHGKmt4mdxr0M1M4U+C8pm83VoL7hp6UxqF01EnHw7aneqhEQZMTXbwoyXmTY4OHlDOcL90EM7dCg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4354be-7f23-4f41-3502-08d7caff20aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 05:42:20.9451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19yrO++3TUTqNfKNjbvbaiKovKHNY4tt9sst2Biwc2OOjQR1HFVs3Z0Aiq6EjtdQW50pu/WUR+DcE79UeYjAs/bq/odHlK94iWHa/jP22GdMV09Cmy0gon/XjUbqT8lf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3458
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] Please check health for renesas board on LAVA
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

Hi Chris,

Some Renesas boards look like down[0].
Therefore, testing with gitlab has not been completed.

Could you check it?

Best regards,
  Nobuhiro

[0]: https://lava.ciplatform.org/scheduler/alldevices

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
