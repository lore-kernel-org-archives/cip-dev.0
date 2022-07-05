Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA2C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 04:24:45 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web09.80933.1656995080517892519
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=x03vDWyi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id l6so9977399plg.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 21:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4LMiEYIUpFwdPYtNVgTZk0W3x/WXgO6MQuzvPvpCuGM=;
        b=x03vDWyiA4SUrAXE+kY6imQyWNoAyRpK9inw+BpD0oKBquzN09RdPfc8nb47gCUyCh
         fK66jeJ7OH9nk3AsM/UrGOJKh+l071HDjVW//ymqvXig4+aZ+d0W2G/hHTp/SheiV1t/
         bLmovvMwMeKaGRpu7+/KNPIrUJevLV1egS8606eAmTjVJ1LkmhB80H7pcKok/qZwU5rk
         ZONzvA9eXOyHbxpjOqHWYd8kVAqt9NT7XqLGGZ28vn7SAa75BMW4poPZmS1JWnGZ+CqY
         Lt51MatfMSrAlMaCEmNbCq8PL+JOYCkW4786oeUh0lS8d+U7KftQVZqDll6U2L31uLxk
         ZFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4LMiEYIUpFwdPYtNVgTZk0W3x/WXgO6MQuzvPvpCuGM=;
        b=Q+eZE7+raWNa3JbwPXG/ZvWQ2/9KFYT5IoPKwlsydjvvkVGA4kz4Bsuli590xPKG5G
         wszznB33LLuf6NE8YI7U0HSEarFIlZQBxLZrD/7AHmLYIleJvejENzEAimRfKe8+PTJP
         m3UZ6/1rLonysnwrP6xigBkdrrqwUiXgcIn1YlYJHKCt486xagmXmAdpWF2p0r9D+k16
         YDsK4nb5+y/g0zVDE1GgZeOmK37kggNTtIHvWyaNExKcqtg7qV8ZAPvZLsfHbwE0QPVj
         7eubWZik4WTxzPzc7tdxmww/KPoHQrafhZQ7zTemdVWxa7b2C1lajByUTkMmpV1AKHK3
         5cfw==
X-Gm-Message-State: AJIora+ahzaYRwzgN86beggN8j02wlMbYevQR9QVUfXgdT4II0AfgWN2
	QYvdhsEv1KodfuR0xVCm8KLXqk4U2wb8cZYA
X-Google-Smtp-Source: 
 AGRyM1s9Pv3UvQzjoECVOsIDtooecvUNyuiRlwaFvOUuc3CSLYpOL6xhbhQdXwufjC29lfntmobuLg==
X-Received: by 2002:a17:902:c94b:b0:16a:6427:ae5d with SMTP id
 i11-20020a170902c94b00b0016a6427ae5dmr39261433pla.127.1656995079882;
        Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i17-20020a170902cf1100b0016be24e3668sm3370514plg.291.2022.07.04.21.24.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
Message-ID: <62c3bd07.1c69fb81.f80f5.4add@mx.google.com>
Date: Mon, 04 Jul 2022 21:24:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-120-gf70f522cb972
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs,
 1 regressions (v5.10.125-cip10-120-gf70f522cb972)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 04:24:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8671

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 5 runs, 1 reg=
ressions (v5.10.125-cip10-120-gf70f522cb972)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-120-gf70f522cb972/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-120-gf70f522cb972
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f70f522cb9729264739dd5a10a8e68d86241981f =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3aaef641d6b956ba39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-120-gf70f522cb972/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62c3aaef641d=
6b956ba39bd7
        failing since 7 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

