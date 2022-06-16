Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E727CC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 17:03:44 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.20552.1655399021634860874
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 10:03:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ylNlRx6S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d5so1733318plo.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 16 Jun 2022 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YLLvWf7ZIrIG2bomacTBmag+aJHfCcPn3c/wy4qs1eE=;
        b=ylNlRx6S+Och0A4mu4TVc+MMWFGbijtPTMj3Z2XGv5gCB42ULXIASmg2X241nKzF9A
         O52AoSOxmKQvfzf5XWXCMcHmN41qyx6w6f1SdngevGkVHgbeMhTEGL18Jtr8FHt2Hsv6
         h0Hn1Kfp/sRSgTO0CxEnEdByrovI/k3f/NTRNTeBTSw/eOyUD8908pQVYTj09j48dQYk
         /AZpfztvqmutttbKb/hNKiab+cC3G7Mixffhc6qNhTFyHhMIE6/ld04R2UwVi3gh8KoG
         XfHWDDhThPUr6IiHp49gfSgAtEk7FuT1N4gYFWx5sU4iko8sNJs5gIaU3GIiDlS2qW7J
         o7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YLLvWf7ZIrIG2bomacTBmag+aJHfCcPn3c/wy4qs1eE=;
        b=zKlKksAlf0R+WVwu41BtV1FiwheVyZJM9x9MY1goulC6nN0PYalMk37i8x9H0buZ+a
         Qmt5gc2oe/bk+QNYttWyzlyd70AI7rRDvnFif++HRKCenSBljNohHb/PFS20Vofza5sW
         kzEyrG/SRRA0n2DLz0q3DKujSFxUBLs+xgidQy5zYvjCtoFWKePAXCf1/9KD+70AqYSE
         ZZcjp/fFZfhRHXDPFlkO479XxCBx7q9IIiD1iXpMzOccaL+ErC7qBDKuotFK2m2pxKA9
         yzjdREBBxACjY/t6Ws09nB+draf8PqSXza+Obavu6lKDp8JmYl6FpIxM7Tph+mh2qAdZ
         GFiA==
X-Gm-Message-State: AJIora/PNvkFmHlMBSa9fG903RK9hjqtAluHwhvz3ZyxpJHyhofFqMaK
	22zXa6sjRNBWUzB6WOZEHxQ/n5YsqmYmuyhl/Oo=
X-Google-Smtp-Source: 
 AGRyM1uM3B7iJIxpqXx7I6weG9K5DqvFJzYp16/J5/50M/ZaKWY6bmDYBo6n8ev37Twf/YNtQHVn6g==
X-Received: by 2002:a17:902:6b89:b0:168:cf03:9e63 with SMTP id
 p9-20020a1709026b8900b00168cf039e63mr5589485plk.46.1655399020765;
        Thu, 16 Jun 2022 10:03:40 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w15-20020a17090a1b8f00b001ec71f4a3ecsm25715pjc.30.2022.06.16.10.03.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:03:40 -0700 (PDT)
Message-ID: <62ab626c.1c69fb81.ee2ac.010c@mx.google.com>
Date: Thu, 16 Jun 2022 10:03:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75-307-g39a7d45c38bb7
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 1 regressions (v4.19.246-cip75-307-g39a7d45c38bb7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jun 2022 17:03:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8575

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 1 regression=
s (v4.19.246-cip75-307-g39a7d45c38bb7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.246-cip75-307-g39a7d45c38bb7/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.246-cip75-307-g39a7d45c38bb7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      39a7d45c38bb7a761b622e3f5d1c8f804a801c29

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ab51fe7b988ca17ea39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.246-cip75-307-g39a7d45c38bb7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62ab51fe7b988ca17ea=
39bcf
        new failure (last pass: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

