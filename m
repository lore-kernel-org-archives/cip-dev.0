Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5650CC433EF
	for <webhook@archiver.kernel.org>; Thu, 30 Sep 2021 00:12:44 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web09.5740.1632960762008534072
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 17:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=FhBAmStS;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.52,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f52.google.com with SMTP id
 c26-20020a056830349a00b0054d96d25c1eso5086988otu.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=kav5rLZsBOw7aJ5CJEL/j7vFLMg1deoNd+vHq2hc/No=;
        b=FhBAmStSDDcKhe7h6ew+HoR//tQQ2nPPD4jUCQraBgFY06kjoMJiXDiexFX9RwIbiu
         fbiU3b3wHu4sGoUmZEmMHUnL+Wy3BRnSRWCjqTkuwEM94tqsPJYyOtXr8jcEoCpTQexA
         3dsCMn/bd6WJVybpIKDDyRtlLZyb0LNO68cu2UkWZLDHPOJE9XUmk/4Q91LCOM8E5r7e
         Vwp4BcHJQ1w5WH9yiXZB04SWrCy1BLOU5LMmgmhbdXsTEcMSfBsQcGV+muTpMRJIvQx3
         oV8olZE4wWFYWLhqOkAcqTdy46LZO6Yu2JDfFSICB9Zl9PpZuQz2J3d1Wr465OSyHQna
         xIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kav5rLZsBOw7aJ5CJEL/j7vFLMg1deoNd+vHq2hc/No=;
        b=z3IxisOF5DO+s+FOc7uo4SmTW/A9+g0MNcuuSmnqVMYl+MP6Tc2Zf8cKqQ77mCDxKA
         sUAn3jTHX4Ffx0Ifhlkh2ir6+Xxl86UX3WA+zSVTrg7fts2K1LjnWpdAchM3DlQwdrv7
         nFHdPpxyU1CrpPkel9Ey6zPPWNU3P5wLtuM3IxjVUjf0RYf2Je6PgYTcMqEqkt7t2IpW
         C9LhehyYuTfjZ4bouP6k4pEVPe0KFyEswNyhTGuNVcYFXK+U86iXlB7DIoCS7KBLp78h
         yskjmZr9hYmzEy5sk9DFDcsRVzkswI1XdOXI3UiLvBe7wpPFIq+aIkAMzpGkyu+Po1Nb
         6K+Q==
X-Gm-Message-State: AOAM532WKJ+vK3hq8mMF7ZaML+deCHbPoGYa3vwn0SYlC33B8ynVbmI9
	gqhZSvtCdGMpaCprfxxI3gjwu1Y8zPx2GubcCX4ssOvswFR2og==
X-Google-Smtp-Source: 
 ABdhPJwC3DGbENmry7SRlLzKbqJuMYeKNUY5RI1wXWWIuAjxRmZ5+s+1Lt1abyXHzyy9dZzsgSvGrW/5sGrR2iWhSso=
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr2483004otf.180.1632960760925;
 Wed, 29 Sep 2021 17:12:40 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Sep 2021 09:12:05 +0900
Message-ID: 
 <CAODzB9qObzKXuh+WaSqh_KD=T2NfZw79d-NnXFX1vmNGj5wsqQ@mail.gmail.com>
Subject: New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Sep 2021 00:12:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6762

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

