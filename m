Return-Path: <SRS0=HjOK=DC=lists.cip-project.org=bounce+64572+5472+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E097C4363D
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 03:59:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C787A20EDD
	for <cip-dev@archiver.kernel.org>; Fri, 25 Sep 2020 03:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wRHujU4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787A20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5472+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wDjRYY4521723xsc1Tjx4Uwx; Thu, 24 Sep 2020 20:59:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.65.1601006390991690110
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2020 20:59:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08P3xXO0022883; Fri, 25 Sep 2020 12:59:33 +0900
X-Iguazu-Qid: 34ts2Mco67cMLQ9lje
X-Iguazu-QSIG: v=2; s=0; t=1601006373; q=34ts2Mco67cMLQ9lje; m=EAuq3D9MZhvV1yJ2W/mf+5Xn0+8EmT009AGsuEoKy2k=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 08P3xWYM040186;
	Fri, 25 Sep 2020 12:59:32 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 08P3xW9d013342;
	Fri, 25 Sep 2020 12:59:32 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 08P3xVAO029833;
	Fri, 25 Sep 2020 12:59:32 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: sz.lin@moxa.com, ben.hutchings@codethink.co.u, wens@csie.org
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] improve show-description results
Date: Fri, 25 Sep 2020 12:59:24 +0900
X-TSB-HOP: ON
Message-Id: <20200925035927.1958987-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UVJiIg0n4PRV6IyTk9Kp7hSCx4520388AA=
Content-Type: multipart/mixed; boundary="VxQmd7Zvb3pfL2G0L030"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601006393;
 bh=Z+DaYbwgupO8lpgSa+JlVrk/hn/U1wa2ihti39uIUqY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wRHujU4j2PNRuifr3Kmczc7sdbl3Ti8vXTYWVj1Kdgyu65D33R6me1YG/AuIIFm0SsT
 SojvxDxA6/C5Vka1xAz//3ilLBe/WkCp/rr5kw/DrJYddUTTmlM2M1gQc75bhUaXFDIHX
 moi5uH1h1IsGdbxbxw2g9+/Zt8BVanmtF+Y=

--VxQmd7Zvb3pfL2G0L030
Content-Transfer-Encoding: 8bit

I had this in the backlog for a long time. These
patches, improve the way CVEs' descriptions are displayed
when calling scripts/report_affected.py with the option
--show-description` enabled.

[1/3] report_affected: word-wrap for the 'description'
[2/3] report_affected: Delete extra blank lines
[3/3] issues: fill in the description field of

Thanks,
Daniel


--VxQmd7Zvb3pfL2G0L030
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5472): https://lists.cip-project.org/g/cip-dev/message=
/5472
Mute This Topic: https://lists.cip-project.org/mt/77073039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VxQmd7Zvb3pfL2G0L030--
