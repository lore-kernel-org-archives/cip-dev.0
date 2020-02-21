Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A8C35640
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9427B222C4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9427B222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5D77486E33;
	Fri, 21 Feb 2020 05:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqPA++Wqhmui; Fri, 21 Feb 2020 05:28:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1399086E32;
	Fri, 21 Feb 2020 05:28:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA659C013E;
	Fri, 21 Feb 2020 05:28:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF55C013E;
 Fri, 21 Feb 2020 05:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 29AC386135;
 Fri, 21 Feb 2020 05:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id regZO8AIyVs2; Fri, 21 Feb 2020 05:28:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1515.securemx.jp [210.130.202.154])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EC32A861BC;
 Fri, 21 Feb 2020 05:28:03 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 01L5S2ee018799;
 Fri, 21 Feb 2020 14:28:02 +0900
X-Iguazu-Qid: 34tKO6kaJ4oq7hii3j
X-Iguazu-QSIG: v=2; s=0; t=1582262882; q=34tKO6kaJ4oq7hii3j;
 m=wJCKEVNlUJvtA1q9OHUfkxCMZ4qm9LMW1StBczb09Ts=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1510) id 01L5S1w2031875;
 Fri, 21 Feb 2020 14:28:01 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 01L5S1Sf011094;
 Fri, 21 Feb 2020 14:28:01 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 01L5S0aj001547;
 Fri, 21 Feb 2020 14:28:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3xZ9yJrfMnLiUyc6DRl48XCpZf+Juzy4t8D3BPtMAHfPzYs7JgU4EfiZufOQPTB/jsB4CjpgGkqSyPR+sRLBD2YpfK7gIutoZHRuWtikRsOq9ydjnIe7GB25Vqwa6kSbhxzA3uWISIsut8gFG27jn6qvzHuoqWel2ye9DtscWgqeVmpzEB/wJdaAE+577tyNHP6wi7haz1cKG7g0UrJESEm+mk5AT8GzZRiePQNnp96eSPwfPAuP27E+MXTUX1zIw4OPNxWtA91utzoHEkTcxMXUI0fzq+Z2MtypH1JogJqaQwO3MmWGmW2hNjIOHAZF3ysB6xKHUVkW1CQ6WyCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lssjCl+Wap691t9lkJ1tyQbrqmFegO/tiGyXkmME7jc=;
 b=lFxHj9r+z/6wZLWoSA5bpkjQNS60NTohKEK1WGcGHrGzaSvF4gss/hEoYAj91VwArYIj/lPM+bmir8rco9W+9zAfEQXtchVcVaFgs7oezMW1ZXHv9Ae8iLwNK+RD8rw30ILnmtgDap7CncIsHleKme8Jxap1g194LzWr4bFvpiBbACQgSwVubNSFOBCbpw5ITiHPIRwp5IFzoEFvXb4kBr7Qp54vvyTL4MOwlXINEbDtnIpjTDY8cF75B5wIMdzYZSPDtVx8fZPabu1bkD8mGqRskaSKL21WbkmtId3+6zEh25Qc8yZgp0d24RgpkL+dRv4P+4MifDL4FmMhJ/hTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-security@lists.cip-project.org>
Thread-Topic: Sample image including security packages
Thread-Index: AdXod0daEQ5yvAxmSqGjegxSRddNWw==
Date: Fri, 21 Feb 2020 05:27:58 +0000
X-TSB-HOP: ON
Message-ID: <TYXPR01MB1808AD5423CA82AE50EC4D90E1120@TYXPR01MB1808.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kazuhiro3.hayashi@toshiba.co.jp; 
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea973e2-19b0-4016-9e6b-08d7b68ed030
x-ms-traffictypediagnostic: TYXPR01MB1776:
x-microsoft-antispam-prvs: <TYXPR01MB17762D39AFA5FBDE14036374E1120@TYXPR01MB1776.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(478600001)(966005)(6916009)(2906002)(8936002)(33656002)(316002)(71200400001)(8676002)(81156014)(5660300002)(55016002)(86362001)(81166006)(7696005)(52536014)(9686003)(66446008)(4326008)(26005)(64756008)(6506007)(186003)(66946007)(66556008)(66476007)(76116006)(450100002)(15650500001)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:TYXPR01MB1776;
 H:TYXPR01MB1808.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3d/ODjo1ElIASKKujV2S0VLoeNtLlvI8reU2fpasIV9i3Ql0MnkBMskX4Fpzfv9jyGqNf+GatXZBcLi2BHEJ0tyvkmdkIj8V4GuClQuB60mRjdpgaIhrCYAbphcNr5e/OLTd4Rlaq2c0xdAQzYJdy+nWrhrANfT3JS6e4IXGxiVfQCO2f2fxwznQP3aMKEaOjX+gbi7vRq3OklIAG+XSJJ0F3mfJl+2Pz53smbGhZP0N9Fhc7Zzpwmd4Df3hB0+nfJxqpvg9mecWciMp2iW1mzkNyFrYlwqIN2uExV17ZsmR0hPniaNkHAzeS/kipYJs4tTH2Hte+vkVoo7uk5yxRxxym/4nyWuHqBCH9MEqezSHR5wmu8ODvlYVg6qRXfUK17KsFbL/Vqvgs4K0FCstOy6/4y80Nq3ArcDHfD796DJ0jJYNOT0Qp7uRNNTJkk39m4pAWPvMZCHpo4mHFaKO34+pGMS3bbm0VSKZmNncEwZSBTXdD1jAQUQ/DLzmq8j8sC9ifwFH0c911lpMHWfAQ==
x-ms-exchange-antispam-messagedata: oMMHPeYXV9NpUhYUJJEeVYqVxvSjhZcP7FRq1Hchu9LJ57qvwU7iQMvpIex9tKWJ9MH6GJb4mVkmqUtAx+kNtQrZXe93nsqSTQFOVEnZfmfkeS9P2RsZBNYgATPsE8SnDrHcLjD5zsspVujNvOVtlw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea973e2-19b0-4016-9e6b-08d7b68ed030
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 05:27:58.9383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkxQRfornhi/8V1AaGEEI4diZPN5uvvosQqrUlc/WDXG+uefqtCNOmjxen1DAbUPXNoXp8t9KBq7wDDGPBgjXzCHCRe8L9LalvJb82re6pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1776
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] Sample image including security packages
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

Hello CIP Security WG,

I've created a sample setting to customize CIP Core generic profile.
https://gitlab.com/zuka0828/isar-cip-core/-/tree/master
(Now in my personal account)

Introduction: https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/SECURITY.md

Please ask in cip-dev if you need more development information :)

Note: `sudo` and `sudo-ldap` conflict each other, but both were proposed.
We need to select one from them.
I temporally removed the both from `IMAGE_PREINSTALL`.

Best regards,
Kazu

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
