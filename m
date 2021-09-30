Return-Path: <SRS0=BWAQ=OU=lists.cip-project.org=bounce+64572+6762+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF32FC433F5
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 00:12:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237C16154B
	for <cip-dev@archiver.kernel.org>; Thu, 30 Sep 2021 00:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 237C16154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NjdsYY4521723xZgjZV5rPRc; Wed, 29 Sep 2021 17:12:43 -0700
X-Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web09.5740.1632960762008534072
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 17:12:43 -0700
X-Received: by mail-ot1-f52.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso5086988otu.9
        for <cip-dev@lists.cip-project.org>; Wed, 29 Sep 2021 17:12:41 -0700 (PDT)
X-Gm-Message-State: 2GVIkxfciPsyRlhGATrSa9VLx4520388AA=
X-Google-Smtp-Source: ABdhPJwC3DGbENmry7SRlLzKbqJuMYeKNUY5RI1wXWWIuAjxRmZ5+s+1Lt1abyXHzyy9dZzsgSvGrW/5sGrR2iWhSso=
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr2483004otf.180.1632960760925;
 Wed, 29 Sep 2021 17:12:40 -0700 (PDT)
MIME-Version: 1.0
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Sep 2021 09:12:05 +0900
Message-ID: <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
Subject: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="fgBmfGXJYaY9yzkpgXgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632960763;
 bh=exXQ7Qr+blvRdlj+Jn1B2J0L1MD181Ti1cdW/3DhZwc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=u7LZfYTk1YbdoJDRsR1Q3SGn8+5qorNY8njjKtTf/8wuzG8Cy+1FlX3hnHjtY8YnRf5
 0MLyfRIDPMteRQM9YYJqXF8GF+M8i66XbrVPL3goK6k/7Q5HMzYdZCwVWyikWTpDU9YTw
 IqccmUtsfVIPFz0auDp2Nd3/YHIa9SUHXfU=
Message-ID: <20210930001205._AGvrYg0tmVq0BPnIGEq8p7WKljlYRX_CAonPDXNwwM@z>

--fgBmfGXJYaY9yzkpgXgx
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

This week reported one new CVE.

* New CVEs

CVE-2021-20317: lib/timerqueue: Rely on rbtree semantics for next timer

This bug has been fixed in 5.4-rc1 so that before 5.4 kernels are
affected. For 4.19, patch can be applied without any modification. For
4.4, it needs to modify patch to apply it.
According to the description in
cve.mitre.org(https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20317),
it describes "This flaw allows a local attacker with special user
privileges to cause a denial of service" so I think this vulnerability
severity may be low.

CVSS v3 score is not provided.

Fixed status

mainline: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/5.10: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/5.14: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/5.4: [511885d7061eda3eb1faf3f57dcc936ff75863f1]

* Updated CVEs

No updated CVEs  this week.

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--fgBmfGXJYaY9yzkpgXgx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6762): https://lists.cip-project.org/g/cip-dev/message/=
6762
Mute This Topic: https://lists.cip-project.org/mt/85963258/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fgBmfGXJYaY9yzkpgXgx--
