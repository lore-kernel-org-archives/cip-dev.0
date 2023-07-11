Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332BEB64DC
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 15:02:58 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.1947.1689087777891634450
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 08:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=zkPRWAzB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-666edfc50deso3727232b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689087777; x=1691679777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=45Z06ipPdBg/pRSZsulxkNtwAqTTHPXDpISAvyg0JMM=;
        b=zkPRWAzB1kHZqzkHYup+rmPuSbcpYCklRd2H454OGaYgDG7P1WZVp0a4Ogw8q0Xqyh
         2wn+676PLXhuj23Sz+Bs/sJYWS4CtVIbs7a0Jmspod8eraMYkoa6L/ILRRx5JL0Ig0PY
         kud8fMDU0LhqwfvqVWLmcVD6pEZbHZxk/EEcSqt3KgBnKGT8aWVgBIzNNdCP9eqGf2XA
         eItKUoyL4d7v9CLTsvnAdwxGGzcpiJxlg56Z4BHfMI2W+IXT9JzAx4IAtCp2nBzuMB7V
         PS/aIP+ROPtfPmGV0h8Ke4ErDUhMiw3DE3Pll0BfbwjLRE6TF7uaa7zqkgh/z7dsyLUG
         XIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087777; x=1691679777;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45Z06ipPdBg/pRSZsulxkNtwAqTTHPXDpISAvyg0JMM=;
        b=A7xqQyi2n4VC/xdrgAiZwIMncnSsMRPFZANQtcbWRH+lQZ5d/ym4A28facVQ1Dc0Hn
         Hghp4TKiTl3UV586bJ/t9VbANc54pA91+0+NVkGKcXengVx7PWBnRWmUxOhOBX+prmpW
         SJcUFXK7BfkeYIMsZE7iAn0apmz5X0wSxXfvVWebVV5ljcl2wNmP+H8mpaQKPY0fOn0i
         Gipz6yzUGwyeWqEslvxFEA9TNKWoR+VhUvWVnZNEzUHbvP60uhEV1xK1ICPmJsL77To+
         AactgkwbN1KvjW+u/b+phdNqlljZNCfluFTTV2xqR8CJQ42AT7BwX50qAoVzJhqVaRYF
         AxXg==
X-Gm-Message-State: ABy/qLZX48CTcK2N0fvX1B0Pm/6Qq3dkSY7+pST5qFcyqbIWBXBXSFe9
	AU4L7yTwRA5PnYP5o2aHSNlcQhRdSzKEwcVyAZXZDg==
X-Google-Smtp-Source: APBJJlFTakUpMd5lVWj69ywm8Xsc+aJLMY2/IeGKN+S/LSlxBa6hhJItCa0k541EfVYd9MJsDprcUA==
X-Received: by 2002:a62:e10e:0:b0:67a:8ed:cec with SMTP id q14-20020a62e10e000000b0067a08ed0cecmr24706679pfh.2.1689087776722;
        Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78714000000b00682bbb65852sm1871108pfo.176.2023.07.11.08.02.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Message-ID: <64ad6f20.a70a0220.56525.3bac@mx.google.com>
Date: Tue, 11 Jul 2023 08:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8201543bbc8b6
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 5 runs,
 1 regressions (v5.10.184-cip36-13-g8201543bbc8b6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 15:02:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12312

cip-gitlab/ci/pavel/linux-test ltp-pty: 5 runs, 1 regressions (v5.10.184-ci=
p36-13-g8201543bbc8b6)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.184-cip36-13-g8201543bbc8b6/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.184-cip36-13-g8201543bbc8b6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8201543bbc8b67c2cfc76e71fda24c2e1f8a7920

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ad629555406c5bd6bb2a9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.184-cip36-13-g8201543bbc8b6/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64ad629555406c5bd6bb2a=
9c
        failing since 26 days (last pass: v5.10.180-cip34-26-gc198172c84b6a=
, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =20

