Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D94C7EE2F
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 12:00:12 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web10.5629.1685966407609480197
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 05:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vMLvL0XG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.174, mailfrom: bot@kernelci.org)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33b204f0ca0so24597185ab.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685966406; x=1688558406;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti8G18/gbY1xZCxImfNQATH0mZsegHTUBrFRq2JUH+Y=;
        b=vMLvL0XGNsxsovdVLd8WWNV6TwZNEoE1Z4HoVltuDsX+FZXxyYrOorbYF09LlQ1u97
         ElxU045GSm3ydu6+wXbseqGNeZZkZ3HTKB+oh4Ip1y2YS1tjY/rQmRTxOThW28Xvo2FG
         oAO9YbuDkvZtgreZwDArG8RmUjhiYMjDfn+zM+MWjgBZi8la4XssET5v0R3C4qCZhUBA
         4u7yKiQzTA34TJnGbQvbgJQ94zMCqYj/zi7e33o9INC3tyb4W+euvFcX0ex+LS8J1LYc
         S0cGsyYkoOHYjgliwIXhcSLlVp9LuQziac+qQQqxwkK7r6wFxG0JlnUaOyOewhkbuLMy
         B1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966406; x=1688558406;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti8G18/gbY1xZCxImfNQATH0mZsegHTUBrFRq2JUH+Y=;
        b=aJon4Hy5Q6BBLjHiPTV52HMDmMD8u5UustgqmaVnxzaIRdpIwAsQuk5CXyGNeJ8e8C
         mt8a0x65BoGEsQd8rQQBh2jax1Pa2QosFAnb7lPpoSV8LytsT8oGeH14Ex7ArQUcAY9o
         i8AKXEOVtDmLGpl3nAA03sNjnWHa2oy7Bd+7Gb2NxeQrKc4h3Piklsm1z4nRqx/JZceg
         WgZ2oIRFG7VkbeXPN/LOa4t0PK6TpUMMl8S+LTa06GBOQHWcSNll6tywutsEWM+/Y4Vf
         CDHW7mG/B9tUGm1jmFKWcrdNHxiE7+wvT/fy/1cU30oA3y2l5E6SyZkJebYPrdVo7Hs2
         HTGg==
X-Gm-Message-State: AC+VfDw1ii19KM6U3vjkTcM4nUNydVTlII4VdUcT8UuWzYCXAfDifJE4
	8NHkAx7ZsMZY7R3ZP8nSPJWDfsD3yuP8X/OuMlznww==
X-Google-Smtp-Source: ACHHUZ5ufAzJef0K54Qo8uCYtSe7NLgg+Zw44g6RPHIq6Cwzo5T4i9idrw9UqdLPIkgSlw6zcDUYKg==
X-Received: by 2002:a92:c708:0:b0:33b:795d:717b with SMTP id a8-20020a92c708000000b0033b795d717bmr20732106ilp.16.1685966406000;
        Mon, 05 Jun 2023 05:00:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a63f349000000b00502e7115cbdsm5533133pgj.51.2023.06.05.05.00.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:00:05 -0700 (PDT)
Message-ID: <647dce45.630a0220.db96c.919a@mx.google.com>
Date: Mon, 05 Jun 2023 05:00:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 1 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 12:00:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11809

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 1 regressions (v6.1.26-1298-=
g61395b9756bd5)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1298-g61395b9756bd5/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647dc47eeb6b9acebff5de27

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/647dc47eeb6b9acebff5de28
        new failure (last pass: v6.1.26-1302-g2631206dd75c2) =

 =20

