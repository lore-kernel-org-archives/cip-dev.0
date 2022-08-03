Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83254C19F29
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.211.1659543895631456205
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rvrWSvAc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id x23so8208719pll.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PRd63HCIunsMu7cpOseB/9Sr54G51lRhEgq2J5HQOb0=;
        b=rvrWSvAc8SR6TNGtHUORUlD52DeW0Geuv77LZDE1T6xjU8o3oInfAbF15WCEwr1UaX
         ViahkR91iQQjIkmOmBJM5b7uQ9VQ2cedFu199Mri+rqcD2qnnYi+B3AUptiRxHnjDpXi
         SifsVKl8XQIIyec3aZAaNQiptA4Si4DQFtw3NElxdZsMhQxvOsVdaK0p82oRgKu4FLj6
         pbMIZMdd+kq/mdnLWeDGlfu3jXrXKMR55O2Tqnl4RwyoirrAWYKgh3SoXgGNLzYeCfWy
         fqkK1FECnF0k2l+8ANvoMMT3HEkkQXHqjKV5fITMx+1QRohmahcojAZlw5BEI2eApN25
         i/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PRd63HCIunsMu7cpOseB/9Sr54G51lRhEgq2J5HQOb0=;
        b=N5whk6yNM2Tgta10D18e6ZQR8vMJVBoE+sjfI46IAJEVuBlRRWR6bPZoj2i9yW/pnL
         cLYlijbpMM9Ao9QpFTUfILnu4IGYP0zhiTsFRxAmQZ6CDFpk0kCYx/1byaxNyMPcuW52
         qJHI+KqjcB2723zLjFp8YyDH83aa9QPCVO/GTvh1RNUbbHBrNHLQAYjP+BbnDUIgzhIh
         5YFS7viGhtNjKRlbZOJwLUv7fFjLrK5vx0h8sVVampixXiTNYunsz6UOY3zdu4Ere4mJ
         qZNnPE5naetZus1/Gytz+Z0+n7/vUGfS/TrPjxq0w59xk0TJZ/nzYEGPVV2Dk3lK+IEi
         SdiQ==
X-Gm-Message-State: ACgBeo2j4CskRaKbh5Fv8GDGMiAHYyGHo+XylIT5KrCJC2LgAt96zpKu
	xN3UmJbLf+9sqMiIjNgA80IO7OzBkGGqQOiVDLk=
X-Google-Smtp-Source: 
 AA6agR5XDiwt8Z79nzkX0cGcKnudVS8cIw+Xfkz5htMazaeSJjaSecpD4goRYyHIcaAQ1nzKw/IEhg==
X-Received: by 2002:a17:902:e886:b0:16e:d785:5a0 with SMTP id
 w6-20020a170902e88600b0016ed78505a0mr18972971plg.36.1659543894960;
        Wed, 03 Aug 2022 09:24:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e16-20020a170902ef5000b0016ccbc9db0fsm2129787plx.5.2022.08.03.09.24.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:24:54 -0700 (PDT)
Message-ID: <62eaa156.170a0220.5962f.3c6a@mx.google.com>
Date: Wed, 03 Aug 2022 09:24:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 8
 runs, 1 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9067

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 8 runs, 1 r=
egressions (v5.10.131-cip13-431-g420b8f43ddc46)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62ea9e4ef87cf16f6fdaf07c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62ea9e4ef8=
7cf16f6fdaf07d
        new failure (last pass: v5.10.129-cip12-59-ge5b19636ca9c4) =

 =20

