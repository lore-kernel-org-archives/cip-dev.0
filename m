Return-Path: <SRS0=nXnx=NR=lists.cip-project.org=bounce+64572+6705+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B3C432BE
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894FF60E78
	for <cip-dev@archiver.kernel.org>; Thu, 26 Aug 2021 01:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 894FF60E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Bz9HYY4521723xizFsRWMoON; Wed, 25 Aug 2021 18:10:14 -0700
X-Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.24594.1629940211501567397
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Aug 2021 18:10:13 -0700
X-Received: by mail-ot1-f51.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso1381127otp.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Aug 2021 18:10:11 -0700 (PDT)
X-Gm-Message-State: OC9QpcwhUXMuHBIMGQ6gkGVFx4520388AA=
X-Google-Smtp-Source: ABdhPJyig0tITdTYHEA+JoGYcNf7PWssfpgGaL/a92Pueb89RIYURd7T+U+mGoyO8bQizDiyGRcrEns5m6jIbcy7J8o=
X-Received: by 2002:a9d:2903:: with SMTP id d3mr982777otb.117.1629940210468;
 Wed, 25 Aug 2021 18:10:10 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Aug 2021 10:09:34 +0900
Message-ID: <CAODzB9qV4uxi2EHoPbK8D_mW6cO-Ni2x+tVUMAUYzKGK7y+COw@mail.gmail.com>
Subject: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="xtCibG3gaOh3V5Cy3vXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629940214;
 bh=lE/qteVa9MT9llAoxJwnGT9a7cJRSTsjiu8QTjOi9Cw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=K0guNxzE9VoHc/+WAYF6d3XUCqEr582PDDC8W3L1Ec/XV6+G82p0nNvgDiYQ9zwfabT
 HYd9xA0V1AsjQSgImWiHfGV5EKnxXhLpH1haQNiOp3zjEA3trSNU3twVuAPZSSGrFtuhe
 Y0ve3+IdgvtU3Ekt8ljSVN7Ys09sJDcGVHk=

--xtCibG3gaOh3V5Cy3vXH
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

* CVE short summary

** New CVEs

CVE-2020-3702: mainline is fixed

CVE-2021-3732: mainline and stable kernels are fixed

** Updated CVEs

There is no update.

** Tracking CVEs

CVE-2021-31615: No fix information as of 2021/08/26.

CVE-2021-3640: No fix information as of 2021/08/26.

CVE-2020-26555: No fix information as of 2021/08/26.

CVE-2020-26556: No fix information as of 2021/08/26.

CVE-2020-26557: No fix information as of 2021/08/26.

CVE-2020-26559: No fix information as of 2021/08/26.

CVE-2020-26560: No fix information as of 2021/08/26.

CVE-2021-3600: mainline, 5.10, 5.4 are fixed. 4.4 isn't affected. 4.19
isn't fixed.

* CVE detail

New CVEs

CVE-2020-3702: Specifically timed and handcrafted traffic can cause
internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
encryption with a consequent possibility of information disclosure
over the air for a discrete set of traffic

This CVE affects ath9k driver.

Fixed status

mainline: [56c5485c9e444c2e85e11694b6c44f1338fc20fd,
73488cb2fa3bb1ef9f6cf0d757f76958bd4deaca,
  d2d3e36498dd8e0c83ea99861fac5cf9e8671226,
144cd24dbc36650a51f7fe3bf1424a1432f1f480,
  ca2848022c12789685d3fab3227df02b863f9696]

CVE-2021-3732: kernel: overlayfs: Mounting overlayfs inside an
unprivileged user namespace can reveal files

cip/4.19: [963d85d630dabe75a3cfde44a006fec3304d07b8]
cip/4.4: [c6e8810d25295acb40a7b69ed3962ff181919571]
mainline: [427215d85e8d1476da1a86b8d67aceb485eb3631]
stable/4.14: [517b875dfbf58f0c6c9e32dc90f5cf42d71a42ce]
stable/4.19: [963d85d630dabe75a3cfde44a006fec3304d07b8]
stable/4.4: [c6e8810d25295acb40a7b69ed3962ff181919571]
stable/4.9: [e3eee87c846dc47f6d8eb6d85e7271f24122a279]
stable/5.10: [6a002d48a66076524f67098132538bef17e8445e]
stable/5.13: [41812f4b84484530057513478c6770590347dc30]
stable/5.4: [812f39ed5b0b7f34868736de3055c92c7c4cf459]

Updated CVEs

There is no update.

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information as of 2021/08/26.

CVE-2021-3640: UAF in sco_send_frame function

There is no fix information as of 2021/08/26.

CVE-2020-26555: BR/EDR pin code pairing broken

There is no fix information as of 2021/08/26.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information as of 2021/08/26.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information as of 2021/08/26.

CVE-2021-3600: eBPF 32-bit source register truncation on div/mod

The vulnerability has been introduced since 4.15-rc9. 4.4 is not
affected. 4.19 is not fixed yet as of 2021/08/26.

mainline: [e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90]
stable/5.10: [1d16cc210fabd0a7ebf52d3025f81c2bde054a90]
stable/5.4: [78e2f71b89b22222583f74803d14f3d90cdf9d12]

Regards,


-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--xtCibG3gaOh3V5Cy3vXH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6705): https://lists.cip-project.org/g/cip-dev/message/=
6705
Mute This Topic: https://lists.cip-project.org/mt/85151460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xtCibG3gaOh3V5Cy3vXH--
