Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32138C6FA92
	for <webhook@archiver.kernel.org>; Sun, 18 Sep 2022 15:47:02 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.9869.1663516013083083449
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=WZkrGrbw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id
 d64-20020a17090a6f4600b00202ce056566so4546980pjk.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 18 Sep 2022 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=35vq5OIY5gAGPc18USxIv/MoC/700IjyaO/1rJHAbh4=;
        b=WZkrGrbwgyssE01oqKi46OpJ5K5YoaZpJb0qhAcT9Ehs1UdotsOCK15L6YNMWKHr7f
         m0NyvniLmWgQm1m/RXgibCUNa0SD03bZFsu8+mFqB1e1v4iI3pJw7WCA3WkHETQhbxd1
         RbvdGS7W1SYUI9Q/aQBGYXtCN2R9AcNeYUjHuL3ABeH5aESBvGPrs76iyhVi/AUcepBa
         QFvNyt3kivUX5QesGP82zjZpZn1vWlt3vGTXfMyL8QKvHTVG0IkAh6LydByT8Rb7BeXo
         6yD+PxTeMkPMGAs+0NaIFLvkzE4iH72DAQUkNNZz+bhvyxbOtoJPVANAjQxRkuTzxGU+
         Zo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=35vq5OIY5gAGPc18USxIv/MoC/700IjyaO/1rJHAbh4=;
        b=e/yiPEquTLCWyL6B3LuExTw0CvoPDKOQyZud3yJ8+M2dztJU7EqOxKbtFZc8OWZvp6
         nw1/wSRUI5FQKnrDffez1SBw7ow+h94pRlO0zFKT0bFISVMcpfS4ilqkRUH4TRROoaUo
         ls0lf700yb9cLujcEKp27gqHGbvyG7eCj86029IgaoFqxvPcLjzNJOUUZ59WYx2pAQP7
         zfcHOQFH+RMtN8vAAC/jUhU6t0TUYfEsVFpFclkvhBVZFxJjaSZ1W4gIt7Pco2ilvL7w
         icT+xZ42DK/L9/nCPoJK8PpP/39u1YuTOVI7nf56vHGRK3ulEvLcn1JraUScILT42rsR
         w5hA==
X-Gm-Message-State: ACrzQf39C51rVuZsPwKya4d7kH7EeXvVPMITLZ1fiCBLgQp7RgutgrdC
	4Hmg0jn7Da3jcPmRcndZ+3qD+V3Upr66pb1KPgg=
X-Google-Smtp-Source: 
 AMsMyM4WoLkyWxRtmSpPJdISLLeeFqWupHvGTOIeaTt7WXGbLeIKH6PNcTCSuvtUnoxBsd1IARfdzg==
X-Received: by 2002:a17:90a:a09:b0:202:ab93:2afb with SMTP id
 o9-20020a17090a0a0900b00202ab932afbmr25950076pjo.60.1663516012433;
        Sun, 18 Sep 2022 08:46:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p129-20020a622987000000b0053e84617fe7sm18296966pfp.106.2022.09.18.08.46.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 08:46:52 -0700 (PDT)
Message-ID: <63273d6c.620a0220.460d1.f51c@mx.google.com>
Date: Sun, 18 Sep 2022 08:46:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-231-g7349cef09ddd2
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 2 regressions (v4.4-st20-231-g7349cef09ddd2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 18 Sep 2022 15:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9516

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 2 regressions (=
v4.4-st20-231-g7349cef09ddd2)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-231-g7349cef09ddd2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-231-g7349cef09ddd2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7349cef09ddd27c4d55cc11d23fdf232c9184ccc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f09d27ffc3de635564b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63272f09d2=
7ffc3de635564c
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63272f08d27ffc3de6355648

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-231-g7349cef09ddd2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63272f08d2=
7ffc3de6355649
        failing since 0 day (last pass: v5.10.138-cip15-10-g52cbd8ad1543e, =
first fail: v4.4-st20-229-gb433f12afe250) =

 =20

