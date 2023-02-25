Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EF5C7EE23
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:25:59 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.51282.1677353157541563241
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:25:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vmQYQI6a;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id x34so2381552pjj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gaRI5dToSV8jfo8LvXPQ13rfkhxppoxJ9LcIrHeRwFk=;
        b=vmQYQI6aMcYDEL7taDSfIR3NaCace2cmOjiIYHMVNuoDgYfhFtI8iEMgHgV5AL8iqe
         8ozgce9DjZuFQCi/5afaShMXzHE2wla7+kJ/4EYuvkeaGbRLyUau32nGC+9dY6h3ocfl
         GmkV11DMxwCb1nwhruQZZDlv+oTUdXNImHVIETKuPRtkNRZEhFnjUmgE2ghakSa0xsB3
         dB3imFwuHaf+UakBWufgw6j21lQVo/0rD7dKZQrp9jSZX4PGyA8yh0QiMRM2bhwG3hsO
         Y9IU0y0JdCVv7K3a93Sve/6/HP92iGJVrSgYaH1GZ53QQxdFNvSm49DyWfJPD0CijJuf
         JMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaRI5dToSV8jfo8LvXPQ13rfkhxppoxJ9LcIrHeRwFk=;
        b=5Ek9UbEXGVe+t/5EimmXSmOLrc87imtzihLP9aQbzeAI9PuPDYDbscgtI5LXSh729e
         TbyG9UiESiP4hNsJi0J2+RuVzY/R5FdE8ai3Bt4qCQKIeMKIel1NB8Yuq2CQgUnDYCyc
         oDUMnXX148wqImGeghSN7UVk+UdGK1t4TWaBNAoLcQXA5cf9etNnMsMytCFtf2rMjUwt
         DTh8rHhFDOG69nAA0yymX53xVETcaUkXOm9n0A4sbnyoM0tbk19prrjTWYnwvQ+Ct8qY
         u8Vr6Md6d4bQRO9sThypSPCFVnhgEtdLkrWzRJ5jJyzYZNmwFYt/61r2bwoH91xOZTOL
         JktA==
X-Gm-Message-State: AO0yUKUCbsWyjIKfea8tP9FXpy3Mk8HpFnWbH6l5KhSGUQxlWQMATL4A
	9crayti1piEn/ouAlpbP9bwIh3AARyQr85k7puo=
X-Google-Smtp-Source: AK7set+cHV7BxUBeCZgnEcXMjO9aUz+H3z+Ua2rO5x7obKI3c6Zp5sHy7EB/zfHGsEeB2CbjWHjs6A==
X-Received: by 2002:a17:903:803:b0:19b:d811:9f50 with SMTP id kr3-20020a170903080300b0019bd8119f50mr18039426plb.50.1677353156798;
        Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b0019a83f2c99bsm1620906plb.28.2023.02.25.11.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Message-ID: <63fa60c4.170a0220.da1de.275d@mx.google.com>
Date: Sat, 25 Feb 2023 11:25:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 53 runs,
 1 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:25:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10846

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 53 runs, 1 regress=
ions (v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa550c37bcc47c468c862f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63fa550c37bcc47c4=
68c8630
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

