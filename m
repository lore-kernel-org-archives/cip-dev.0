Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43378C61DA4
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:48:14 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.52365.1675687690635708182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:48:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=q50lDgO/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id t17so8296263pfj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tkxe00uB+Krdv1kJVvlwfSgxjdXr6x37T9F2zMiuioQ=;
        b=q50lDgO/nDOyAayHDOxFnSkwHnQqHlrJXBnraGm0V5Z/ElaTHscD92PhNUsxBR1+Z0
         tCgWyDY22OU9y2tsZnyBbAm10FxXmfnx4qvQjrAlm+PVa0nbSXLqsUaQd+0HvmzrMzgx
         yf9RfNpOmJnEhlIpQOg/A1MQH2/DvtSp+HGVpmymaV2aBmMepbsbdPk0SxsMlmo5WD/n
         6AuOhU5dTM3C0pUVgnSErjXzWZu8kz0ZfhSnq+6IKIn873lw7/3aFauXyACsXdkxXvp+
         6rNmO24xlFZ1baNEiLAMroAbpAPYh64tmGDR8Igu2B+Q/hG8OVST2YzL9wzTlovu9Hbq
         UyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkxe00uB+Krdv1kJVvlwfSgxjdXr6x37T9F2zMiuioQ=;
        b=J7ncbaxalTcZcevgoUYsq6kbLhNAZBstjcDQwByzjufGkt/AB60uvulcta+nQNtQ8S
         Tgy/kgQTL/r7uRPuu0GPmho78Al8cR4S79MJxtCfxcCrM0fFqVN50LXBrDAYtZWnwJhy
         pu6yEPDYftkF9kU5VyubO1cWlkoxxI8iYiiUfTSWdXr9u4PRZonqK7robsCUruJY3wg8
         u3q6gbVxHSAM2O8AqmJvosWBhIIN7yttHq1Mq2hgvxfNBehir4OvU1M1M5BfvkZj3Q2G
         oZV9n0HVppq6JkOvXL9z/eL8pgxTuil3BVa3rE2krgXzT3tGaCwthbSSwJGLII0uKVnx
         MiZA==
X-Gm-Message-State: AO0yUKXHjFf/KDc7RH2SK9YDUQbG2+BwrNOVVnc4et8ZZPYX6HYo7UlI
	raSvG1YIjKYbI3E+VfZC92WPhohpJwKywHaT
X-Google-Smtp-Source: AK7set/RNdxqvaOcrLiFFL8L4VtwdRlRW/LyyX1EY5dGbu0ZjrvQpFS7btjlPyytesa0S3rWRyEMgw==
X-Received: by 2002:a05:6a00:4146:b0:591:3d20:3816 with SMTP id bv6-20020a056a00414600b005913d203816mr20518185pfb.4.1675687689702;
        Mon, 06 Feb 2023 04:48:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j22-20020a62b616000000b00594235980e4sm6962556pff.181.2023.02.06.04.48.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:48:09 -0800 (PST)
Message-ID: <63e0f709.620a0220.3f81c.ae84@mx.google.com>
Date: Mon, 06 Feb 2023 04:48:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.165-cip25-154-gb7e05ba4f61a2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8
 runs, 1 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:48:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10603

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 8 runs, 1=
 regressions (v5.10.165-cip25-154-gb7e05ba4f61a2)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.165-cip25-154-gb7e05ba4f61a2/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.165-cip25-154-gb7e05ba4f61a2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7e05ba4f61a238b39854406f0889bab2b4fb757 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/63e0e93b69ca004627915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.165-cip25-154-gb7e05ba4f61a2/arm64/defconfig/gcc-10/lab-=
baylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e0e93b=
69ca004627915eba
        failing since 158 days (last pass: v5.10.136-cip14-542-g97767707d3d=
0, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

