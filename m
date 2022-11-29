Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD8C46467
	for <webhook@archiver.kernel.org>; Tue, 29 Nov 2022 11:23:27 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.147066.1669720998891532614
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Nov 2022 03:23:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=huTnYFQ4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id y17so5193650plp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Nov 2022 03:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J0CkGcsjEHvPu5kE3GegyPg2epcAigrL3Iok/ko454A=;
        b=huTnYFQ4DCR8LIa5TbqktX0JZuh/vB/TWRaQf6x/1x8nj4hFalVCn5wXLTCwMZfLo3
         wQLxrv+V/ou6ggvUePsLzJBqaZJ3WNmaiOzN2Q8O8M+f14GDHPQTysV6Ke8vwllxH9HH
         387y090NamkyHGgDV1Bp/ex0JPS6tkaehXGnZCHQUBHgRNhQzf/QB7So9YvMh8t55My6
         P/Z5S52wE98g/TDa2S2xB0Jw4vGHLq/o9LVFugeOCevZ0lX0/09whTYfPY1hRZ7N8aXj
         6p4HfSARtsFvQN5RNGQ0kiaqCkIwAA8F7LgiYf6hxa6gJba0VPMtwbo0Rjb5jPkB4Hxz
         7THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0CkGcsjEHvPu5kE3GegyPg2epcAigrL3Iok/ko454A=;
        b=pK0tmcB/GE0F9CNocvng7aUUIrOeTX5IpKHhK8EIGRcLbt+c4g6an8MQqLertiHr/p
         8ucBIOTA258Y02hL1U0kv+vw1oDkMAVcNoi78bNLWKREHpSa3xRXfNEA/2vDxRjY4yxv
         TYOJXbRstJ9EyfqPaB2lQ4wHn2z1NcLc1NNNlhmpPLIVAgtFWSfOOhKpMgaP+/hwaEYA
         TqMfx8JBiH4yy8LcHmv01aRfgvRl2FH8PIWjIcrFSwftOWNhXwCq1YZSCbSFwAyeiP2F
         J4Lp+hoX+ByiPRrlPK4jEPUA/+Rs9LRP/6h7Qh6hyIN2lH5LxUt/hQ5vofrYgW1G/5UB
         UXHQ==
X-Gm-Message-State: ANoB5pnKleZ05wh8bJvrFEbW7l0H9ZkAWpKYPg1yNVlKypYYGe+5JgWC
	VXWvIilzQ2l70MbgaOusJs3pQrbrlgW2H6Qmfok=
X-Google-Smtp-Source: AA0mqf5QQBaeR8ulQXuU7pXKI5gjIn7VKXevc2DkT2feD0IpXdrE4KnYNE1/HoKFp/nW/bgv6TuR5w==
X-Received: by 2002:a17:902:ebc1:b0:186:b6aa:5646 with SMTP id p1-20020a170902ebc100b00186b6aa5646mr36724314plg.73.1669720997851;
        Tue, 29 Nov 2022 03:23:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a674100b002191a64b5d5sm1136842pjm.18.2022.11.29.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:23:17 -0800 (PST)
Message-ID: <6385eba5.170a0220.5a79b.1e6a@mx.google.com>
Date: Tue, 29 Nov 2022 03:23:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Nov 2022 11:23:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10132

cip/linux-4.4.y-cip ltp-ipc: 7 runs, 1 regressions (v4.4.302-cip71)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c727b8f0ca6857a9782a1ee857a57e4f563b34fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  498247917f40b0a82cb149e2ec1cb518acd7b632 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6385e2220df38b244d2abd36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-as=
us-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc-as=
us-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221125.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6385e2220df38b244d2abd=
37
        failing since 3 days (last pass: v4.4.302-cip70-98-g7f7838c92740, f=
irst fail: v4.4.302-cip70-236-g69445bc0d420) =

 =20

