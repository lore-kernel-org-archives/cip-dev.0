Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77029C5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:52:27 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.9758.1708692745111995513
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Naw3Y3E3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc418fa351so1736085ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708692744; x=1709297544; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X2O+vQhwLQ/Parp1uPHC52Q56p7LTAcNir7u3/O2g7Q=;
        b=Naw3Y3E30MQ0QJDvJoAC6PQqZL4utJoZZKdU6zVRLdmP0Zx/V+vbdB755P1XLnECcc
         OgogVU5eMqGiuOJgF+nL8HhOkjGewpFmluQz9/j9oZHtgpmSl1rjuBHfsRWf/J9P2OyN
         7Khhd+/dHjYpEMla+TlN6rHMXLfrBZNQP0vxQ4X2x5k1+4xT2c2fDl5OxiBJolsJJ2L4
         abQdvj8g0dsEl8xoWZX7c4inNg5cvRki6e5cSLitZfmMwh2oGPjuCITLo7GgnlurW3dS
         x0rF15dCrOeKIleteqkOuBUuShDLian7tt8zZlso6yHJKZ/9jYqQB/MTafvu/Hg/YB5H
         z2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708692744; x=1709297544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2O+vQhwLQ/Parp1uPHC52Q56p7LTAcNir7u3/O2g7Q=;
        b=lb4L2PvKwjmiImoTkW57e/HYQqkpjWuY7ieq0wlzSFWtF8iycUaecg5WE6rHdj7Xba
         VEXhJqdec4RI/5GRhQYE0m85qo4tVZZwEea2NTOoo27x095adu8l9LbATrSpLKznFDT3
         HfZNmnWqUzsS5TBG4NF4MKXHkvgfFB7YNY+pxKMD0OpGfAWCbUa99uEQ9NtxaVaIAjb3
         /5DTMT7iTxIHk2yDx34uVJm6eUacE0y9KScyIgvNXN8VquSvo+2NNe+07Wp/+cvL0hSl
         z++Al8Xyhl9sr0uuSxhN3+T6Sr1pWsUaqT/jVFsguKkWiPR9lr5XJ4Lcv8WTiSow3quu
         RmWw==
X-Gm-Message-State: AOJu0YxhY1wSoL5+NpCwzb5ZpYVDsznryViqnqmP8a7JJ7EzafNp4HHi
	t5FU8TIHE1QJOdQijYtqEFgzCPRNGbpe5yOt+KM3u5eubUKWF4PEaqEFZgeZEeFn/n6VF8NVVq7
	sdOg=
X-Google-Smtp-Source: AGHT+IEl56LQYtij7lMPu36/JKdJlDd/BQn5TTuk2DsRUNs1UhqvNUimuV7/t4Nms1xe0FoKl3dQtA==
X-Received: by 2002:a17:90a:8b02:b0:296:e8e3:13c7 with SMTP id y2-20020a17090a8b0200b00296e8e313c7mr2839052pjn.10.1708692743942;
        Fri, 23 Feb 2024 04:52:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090adc0500b002993f72ed02sm1367944pjv.34.2024.02.23.04.52.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:52:23 -0800 (PST)
Message-ID: <65d89507.170a0220.2a5d6.379d@mx.google.com>
Date: Fri, 23 Feb 2024 04:52:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.306-cip107-201-gc2afc54e2d6bb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs,
 3 regressions (v4.19.306-cip107-201-gc2afc54e2d6bb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:52:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15081

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs, 3 regression=
s (v4.19.306-cip107-201-gc2afc54e2d6bb)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.306-cip107-201-gc2afc54e2d6bb/plan/ltp-ti=
mers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.306-cip107-201-gc2afc54e2d6bb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c2afc54e2d6bb0bb2a9214444545a17298928975

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65d886cc6ecf07488e637018

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65d886cc6ec=
f07488e63701d
        new failure (last pass: v4.19.304-cip106-176-g770d0422c72e9) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65d886cc6ec=
f07488e63701d
        new failure (last pass: v4.19.304-cip106-176-g770d0422c72e9) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65d88bb3be1605d33a63702b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.306-cip107-201-gc2afc54e2d6bb/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65d88bb3be1605d33a6=
3702c
        new failure (last pass: v4.19.304-cip106-176-g770d0422c72e9) =

 =20

