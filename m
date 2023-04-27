Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30292C77B73
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 10:18:32 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.16719.1682590701995391573
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 03:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vkVvwhLW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-51f3289d306so6327566a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9j4d+FCjJem6CyaampBYsrUbEMI8cbtW8Kk3A00xkyw=;
        b=vkVvwhLWiYi85mkMhUs6s9albfWRppdP4XivCVRCqg0s7/9mCTmcgdlDKkOTPGp4sc
         bhsSR37l7fU+IQL8n12XSqcU3iy3g5DZspiq2sBtY9nmOyyK1HOJVzW961j7yf72qVBd
         a3eGvZ3dn241Dru8qJy6K1AEKWZH/hn4+0elu7E19osDdFzR69dFO7CtgH9KOuxtPg9U
         Hs0iucmghKViKJkKwxcisN59OUf8J4i6AAyX4DeGIxhxD0kX206HaOsslD8h6DwQDCja
         z2FVbi2V7IGqYDbAGc3J7DbvAh66xtqm/O4/B8jVFDreCIQKN3kdmi8mL9e1yiMKhyqt
         hp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590701; x=1685182701;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j4d+FCjJem6CyaampBYsrUbEMI8cbtW8Kk3A00xkyw=;
        b=ZLHMqTW6s5LVdsGLDEWHMKR9B5f2sMIryNTDZuWu5nqszvt54kL/GrZJBmdYCpkISP
         GWObseGRKK5vgWVu7AoiYu0pS7I1Yp/BS+GeuKzPZwG3DqKXRQu9x0GetFVO9fXINf7b
         nz8wO3GnLponB0YRcisg5vnfkMdWCnFihvSPZ5q899KJoW3XZRgOXgPSR+EH/RgscPQp
         GqaL5NC1X6iAltkWbmvJkTrp1TpR5h5N1h6utx8DbSZpgushNIOavfmv9bm6ANvjfynP
         paEgO2AUl9zg5hE43sezaDOubs+UVWpTT/IKwvDXu1cGlclqZUxr9v/ThSJBuq5l3kb1
         ZWWA==
X-Gm-Message-State: AC+VfDwuO+pzm7MR6e1SGlmIWUokqseujDOO0HHqaq/nbNTs0BkIMGTc
	NgSxmZY6KG+w5Xy1uBi4v4fZoA+yx30oHOqWQk64fg==
X-Google-Smtp-Source: ACHHUZ5RZ7oCsayD43ftWhbS+/KwkUTq/V50t6ZPp9ul5/qpBUvuXjkrAo5Xyrw1xBii/iVTl6FedA==
X-Received: by 2002:a17:90b:1647:b0:24b:2b9a:7fd2 with SMTP id il7-20020a17090b164700b0024b2b9a7fd2mr1329554pjb.9.1682590701034;
        Thu, 27 Apr 2023 03:18:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a4e0200b00246774a9addsm12482987pjh.48.2023.04.27.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:18:20 -0700 (PDT)
Message-ID: <644a4bec.170a0220.86a64.9a96@mx.google.com>
Date: Thu, 27 Apr 2023 03:18:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 10:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11363

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1186-g2516b357b2e3a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3bfa4c855b80812e8603

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/644a3bfa4c=
855b80812e8604
        failing since 28 days (last pass: v4.4-st20-938-gc773c630d0e4f, fir=
st fail: v4.4-st20-1097-gd51b0e04681f) =

 =20

