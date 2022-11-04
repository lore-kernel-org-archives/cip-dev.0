Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7CDC43217
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.9135.1667553824575746477
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=VeTN1Uv1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so4117086pjd.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFqCWlu0PZV+e0jQc0BpG0eAN5JYwNYcIV/KwaVpsdo=;
        b=VeTN1Uv1Dy4eY04QTLT74UmvkE8hVT62Uv+TYuzA4QmdxIRTtlfzKzDLij5EHDVJ7y
         AuLNRkMrpSnGZbwlraWAbaG829ovEg7uO21zUtxcNLwbHWfoEnFVcgfPEnHnmnh3ebH6
         PY9Z1T6qXTsfklR/7xmbu7V3JIxEO9j6ZgvgviN7EBi1vqCqzSZBqq60dIMxFuHZled3
         PoCEINAk0Z+DK0zuXMN7YlgDGLW+CIX7QxFHyLU44YR/8R+XSraITFuG6SARdgF8QwTl
         um7GNNhN1f5dC2kT5kapcdN3TvYbrtWkcGudIxVFyMBySCUryPuvtIvUI1JHYT8d+/EC
         qAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFqCWlu0PZV+e0jQc0BpG0eAN5JYwNYcIV/KwaVpsdo=;
        b=MPe2xVFwZM09FkAUOPE4VWF5D2vQbmmW3Jzkt3p8GrwiJVLwg4fqt38ZmqeWT6viEA
         PV4v6fH1+rpGQMGNpHAHB/QHgvefKjTerVRpAu22szs+9Ivu9uucU9g5o0It7+EALQxq
         /n7iImazB63AYVLTfJu0Hy+PDVsdLs7eI7brsEq2h2Z6msNkmi7XrfqoAeN25WeZXLDS
         sRGeaRgucp39ka0JldSVzOSNtk5Ps8SJ5UHuAlFWZ52dAlE9i/aanFOiFfE8cw0MiYgD
         azYRkuWX7UwgUk5nh1pFoj2RIYO84JkJWzqSBlVBggb2Gt7N1BOT3t3OLwWR8Ke+5Ulr
         1CGw==
X-Gm-Message-State: ACrzQf184bHVtQGGHT6v3ekpPDFPHPRMgf7Dhny0PDsp6gmx3x43L+li
	pLAc0LTxbrkuok00rYXiCilvbltJ3E0ezA==
X-Google-Smtp-Source: AMsMyM60lMeHaHp4HiPOZ1Xb9bN1SXtdd5ynuP8dfM+RtbRq5CjbRQrUMIs99QszY2fqE41A3BSB0g==
X-Received: by 2002:a17:903:1105:b0:178:ae31:aad with SMTP id n5-20020a170903110500b00178ae310aadmr34925831plh.3.1667553823615;
        Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b0056baebf23e7sm2268699pfr.141.2022.11.04.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Message-ID: <6364da1f.a70a0220.d62d0.43c0@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9928

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.14=
7-cip18-12-gcb2b164780be)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6364d379c5eb50821de7db4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kselftest-files=
ystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/arm64/defconfig/gcc-10/lab-baylibre/kselftest-files=
ystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6364d379=
c5eb50821de7db4f
        new failure (last pass: v5.10.147-cip18) =

 =20

