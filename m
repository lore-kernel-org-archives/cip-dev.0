Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B11C38159
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:38:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.9686.1674023918170455581
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:38:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=km51rKz7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id 127so8133688pfe.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 Jan 2023 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L1K4gBOexJwDvp7su1Ly7PW+XxhEIrArMGu//TeeSf0=;
        b=km51rKz7O/0X2GmP8Z8ct39MJ2tPxa4U/CX2n3wDJmg/E8XP/+UU5twrUuA3nyXhWk
         eULaWYH4AQnZDpV8kAdhxgg2McNUY62JUkXnYPOzJzJIvMz8Pk6OcSN7A7YFMIszXMdd
         scN7YV/40YIhmYMI1PlS7hEiiK4UklcNpOcDrK7TwOnF3oDqQn/o28/O23LFTqDdE4Pz
         wc0v5bnUtKDcO+Mj+OdAcuICpvfQzThdXutpjdtjy+H5+ClLYDJGzvhVNB7Xui8JRh1d
         zY1e2QOx7lYydjGOnW69pgBu6mcsxyoHBM0/8JlQGGWRZ+xPVJU5+Mb2cb8+z1oKWnAY
         RvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1K4gBOexJwDvp7su1Ly7PW+XxhEIrArMGu//TeeSf0=;
        b=ypcEvZik3Ls3Q0fCMPkSGrzOLRj99WXhmy6DLxv6HTgI50PLMko+dY6GzxjFD9lHTe
         iZ5P/6Kxs6YfMwxIjfhKOgYrsq8wheIZZU+uN0mtg2sUnozCE4tCF0IHsQTAC5Us+Uds
         obHeUjZ8zQGBgLNIGBQMUYxDtj7hnMP4KVV/ptW9gDQteo+jTTnggGsgOYSgsX/5Zsx+
         BhWpqOpGKDX1TEwjul4DqoSMz108pxmONcBc3Wdxb7p0wm7Cv0LyDP4Yj1ZhF2a5Xrow
         ZsFHDMIkNxlaJCYYCG7dBzLmmQe5AgnzEi9Kw/VWG79dI9UJQNe4N745xXHFNnb2DkoV
         LiiA==
X-Gm-Message-State: AFqh2konBKNJyfI/xELN5h4QMJe2JlMqCovcOE7g9IM62ywiW9feJOJJ
	hMEyVQhY0U9dmSPvooPPf7UDTzTiDZRov3Mk+sMGqQ==
X-Google-Smtp-Source: AMrXdXuY7/kyrOfdawN2nKUDJtMAfXa0zE35HrENqkRCYMJSCkqxJtoziNQuY3pbPNP/u0t+Hxos8g==
X-Received: by 2002:aa7:92d4:0:b0:58d:bb59:7112 with SMTP id k20-20020aa792d4000000b0058dbb597112mr4597500pfa.22.1674023917508;
        Tue, 17 Jan 2023 22:38:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c24-20020aa79538000000b0057447bb0ddcsm5740602pfp.49.2023.01.17.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:38:37 -0800 (PST)
Message-ID: <63c793ed.a70a0220.6ce12.913f@mx.google.com>
Date: Tue, 17 Jan 2023 22:38:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 4 runs,
 1 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10384

cip/linux-4.4.y-st-rc ltp-ipc: 4 runs, 1 regressions (v4.4-st20-821-g39bdf0=
444b23)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-821-g39bdf0444b23/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c789385107169058915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c789385107169058915e=
bf
        new failure (last pass: v4.4-st20-799-g1229c813bcd9) =

 =20

