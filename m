Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8CFC43217
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:27:11 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.1934.1668140830068033279
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:27:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=l6gvkm6g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id v17so3342502plo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8CqlOoe3KfP2YYrGZjXaUO1YScnCSA4VlXkIZ7PH3A=;
        b=l6gvkm6gt5v2LRKwagchFVc4tucmjEAHPSbDjWaG9o8yK2IuJvP+w0cuhMGu6uNoep
         wkL2PJcYqLCYqOtmzcTxzMJfKUa/Zq2NmymYHyahHWjS/eARlKDfsKxtBtCOYC+y8Vcc
         rf964JFhQIceW1qU/U0VokaCkTpApjHgIdGfSuBPtf99Yn4ihNVhwaxaiD6S7AS5qnqE
         yZfo6NumuoolXdesWv/CoJKLrXJ+1ka9HZeS85EUTInyviRZ/SIDGh1pasHd2ePJUwu+
         3n1wRXPdeoLk64oR3h9G2Z0QGYHkiYxqnAfTmLyExdAZK0Na2LmzkM/PTf+2bHjo8a/U
         rMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8CqlOoe3KfP2YYrGZjXaUO1YScnCSA4VlXkIZ7PH3A=;
        b=nNPSouvLAgPi6ZKC/d7rfC1wU56D44zw7dYTnsFRyyJVEzBRPNRnBKEyn2LYTP0+KG
         aa2gaRvnrK011Ayaf5TvdLRjeKAqjtsPayyf2WakKYeFR2zXWKDsBp3IJ74k/BR5obp+
         /5Kn3AiVqq4eJ2s+J19kh81u3nfyfX7Hxo3OBFN4A9s80zEV9buXb9oyflPO2ET+aOhf
         DDXAu+ot7PubF+dGfXw2Z87I7Api06YxNgQlBtmvNI11cWeGzL+vJ/HKMGDk+gJ5O5W0
         WZoQF86zhBGTzENHmAVvD8xKORwdg9quAb9Rs7XV0/s0H0reA2uprBd2hiNgqeHRfotX
         EW+w==
X-Gm-Message-State: ACrzQf03Hr+bwLiuNSEKZJPzSzjufyZ0+aY6uSZpE+jEafkLURnrO231
	BLAkbfocP7O2V56eeEWNf5watEsjn68kMwcHrVQ=
X-Google-Smtp-Source: AMsMyM4t3sEhjm8KhtegW3PohEklC6H7EhnCsyAKHKVmQJKp0STrK9V64pyNbPKm9NQriPDp+eOr5g==
X-Received: by 2002:a17:90a:d78b:b0:213:18ad:f71f with SMTP id z11-20020a17090ad78b00b0021318adf71fmr3408281pju.178.1668140828866;
        Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t21-20020a1709028c9500b00176d218889esm513931plo.228.2022.11.10.20.27.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Message-ID: <636dcf1c.170a0220.4d684.111f@mx.google.com>
Date: Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 33 runs,
 3 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:27:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10014

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 33 runs, 3 regress=
ions (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636dc81528e41f2a25e7db6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636dc81528e41f2a2=
5e7db6e
        failing since 13 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-468-g86403a07ae1c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636dcc117350e7e87ae7db5a

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/636dcc117350e7e87ae7db7c
        failing since 247 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-11-11T04:14:01.621122  =

    2022-11-11T04:14:02.659045  /lava-7943350/1/../bin/lava-test-case
    2022-11-11T04:14:02.696745  <8>[   38.582535] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/636dc557449cb3f1c1e7db72

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/636dc557449cb3f1c=
1e7db73
        new failure (last pass: v5.10.147-cip18-468-g86403a07ae1c) =

 =20

