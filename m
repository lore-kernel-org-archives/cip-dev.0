Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B9EB64DD
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.53472.1688455560308958959
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=u76NH00t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-666ed230c81so4346506b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455559; x=1691047559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D3+B5KiI+olYxZJwVEI8+E2hhGzi48kKUJL9KnLczOg=;
        b=u76NH00tWdt88RNN98zleEadr1YQ9PPP2QJfjFlbZI3oFx4XUfb1YJWxMQ82JJaCnH
         G5cMaTnTgl1rGrpzFH26YtbnL38LMh0SCx+OSisM1dImUhAiWrYaHvpzSxEUtCKGJPjM
         +BM3hDtV5Wq4XjQlIDLIJlyVvGUyERHMWjtfRsDiasmlg7KpO1xegtpZWCyXIR5mr4Ur
         j7aXByzm4EHXtMnv8xeHfGcc+wxSXfilUocEHaCByaLuybuqqn8eye1jRLxBoJUdBypb
         FZ3Jja3u8SZOlbVvQ1Ax11yIxCRp/Z43tvoIO0BQod/VZf3loUDvoo7LPC/IOMocp5UN
         UPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455559; x=1691047559;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3+B5KiI+olYxZJwVEI8+E2hhGzi48kKUJL9KnLczOg=;
        b=acmnYJus7xpWzUzemXdybzrcRXiDthiB3VbSMomtBs4/6qOstW3fCsXoB1UGafdDMN
         yDoLTztTbQrxsjCnBD8fNGEdKXgY6CUhS4AQ/m0heh5cB+vSj95bGhs4Ss4OAKFm0T4+
         q7WnLGLvqNOIj/QRqvkqU23ZtSDy5uNOdhIXa2/7c87LKUCDloauoyPT8/sK5ug1Rv9V
         KnlH7Uk4xKoJa1OTxZwjw04MiE0F0uXjPLZuO5VqzpDjP60DuLxLJQGZHgsS2kJTuEzW
         2sIwR2ORE8G3MIu9PoBPxIQDIoezQiY1tAz6i3Ke+DYFa/+K+cnJE7odmDwpgQ+aeK/4
         LNig==
X-Gm-Message-State: ABy/qLbLeCcHBjKhMuImbVY4hyfDuPtPW/cER0FIku1vNoJ5l/5dRgD3
	6EE9Le3qKup5eRDBZRMMdmyY0JBIJJ8EYVm2n+yfEA==
X-Google-Smtp-Source: APBJJlFxd/TuwciBjqAI66qWe43acNXyo3u6g/Lg3mbkNEGmxE1tyIuQobUtKWQUO2wpcttpmNOUzQ==
X-Received: by 2002:a05:6a00:1a54:b0:680:d00c:b164 with SMTP id h20-20020a056a001a5400b00680d00cb164mr15994275pfv.34.1688455559260;
        Tue, 04 Jul 2023 00:25:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b006727c1c986bsm13748104pfi.212.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Message-ID: <64a3c985.620a0220.86ad5.c1d9@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs,
 1 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12208

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 16 runs, 1 regressions =
(v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b

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


  Details:     https://kernelci.org/test/plan/id/64a3c3b83e31908c6fbb2a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64a3c3b83e31908c6fbb2a=
77
        failing since 19 days (last pass: v5.10.182-cip35-8-gc3d08808cfa7, =
first fail: v5.10.182-cip35-191-gf4efde512959) =

 =20

