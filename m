Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F555C54E55
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.9706.1709765211786110187
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=quyZciaw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd1d9daf02so1696535ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765210; x=1710370010; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xThq1Gxiio9juxyTjN/2VXHEmARPg29a4HsR5zsM9pc=;
        b=quyZciawwXg9aMycYwqID7vJcciq7iZNu92N7NyuC30PM3Z4aIFYpq5yi/sW0ugcDs
         OgUsLCyPSw91wvmU1AXp+PNKpUWGDgFB62JwuQ0Sv5dWQt6ZX6wChk9kgDK2DyNMv+nO
         RdfNYAvxDH87cxpOgcv4Hhk3YfSuDwBHjwODSTmd6KbH1qwDRhcjRHxkhGDFRMcqYwLj
         BouCNQmf9g+rL2yU1MpkiMNFCAhphsUgQ7ZOa1FTFP7jnCuEnFCEl5Y09x4PV91jOsB0
         PzzlwDS5+sIX5BoRvS5+VBjn2/N3NkQjKnmxWUF1GKuFMlCikwd73Ogyazus7bQGSBJt
         9xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765210; x=1710370010;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xThq1Gxiio9juxyTjN/2VXHEmARPg29a4HsR5zsM9pc=;
        b=v70inBPNGLSuCngjTNtu66LiD9iTOJJRxyF0Y9t41OAyIjCA8qpQ1qxZ02yszERe0Z
         htuIRbaVZglaOro10vaqHZnD7sNCUhnqT/d0Q4TC3RFYKVnZB25sHbItnjaYosG3+6pI
         aV0ZmcGr9rIwxV+fxbiGqHF4xVatE+Mj1Di/f5N3EZrOI8fGOoppWj4Q5aJZN/2eWl9G
         yEiqAroq+JfaPAgtsEycRAXdskRhF8Ia9Na/gvrJCcdBTnSS49yBdF4ROLpjeqD98o5q
         vDSLGSWfvvspP9qZ3aonX6iYrwKruMlmznLGpZxPq/3VH0h3NZzwcxAu2gt03e8Kgxrk
         4Slw==
X-Gm-Message-State: AOJu0Yw1AE2bOOJyqLz6bHIvZMxUMcKp//tcH2qxSlnafG58yFHLLroL
	SIEO0bU7RrpK0daOM/aBf6CzklOzmbAMnIKhScm/cimpSIjBuYjMJsdgxflnFknbzFR1ezlIcp5
	hG28=
X-Google-Smtp-Source: AGHT+IEXI+L0L4OHnZFzXra+u8OLB7TGXCT0rMwm83b4HVNl6uOcL17+WAv/Z2u8tog7t8Pp96RDEw==
X-Received: by 2002:a17:902:e88b:b0:1db:d811:732a with SMTP id w11-20020a170902e88b00b001dbd811732amr6550336plg.37.1709765210411;
        Wed, 06 Mar 2024 14:46:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001dc71ead7e5sm13153369pld.165.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Message-ID: <65e8f259.170a0220.40f8d.39c3@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 18 runs,
 6 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15248

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 18 runs, 6 regressio=
ns (v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e8e29d6f1dc5104c431d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/x86_64/x86_64_defconfig+x86=
-board/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e8e8e29d6f1dc5104=
c431e
        new failure (last pass: v5.10.209-cip44-552-gc0460fb20fc00) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
qemu_riscv64              | riscv  | lab-broonie   | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65e8e070f3a95a70734c436b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e8e070f3a=
95a70734c4370
        failing since 12 days (last pass: v5.10.205-905-gb40421b142370, fir=
st fail: v5.10.209-cip44-424-g38943e302f8c8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65e8e070f3a=
95a70734c4370
        failing since 12 days (last pass: v5.10.205-905-gb40421b142370, fir=
st fail: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e1b8729e66314a4c42f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e8e1b8729e66314a4=
c42f5
        failing since 61 days (last pass: v5.10.201-cip41-540-g3640150b3b16=
9, first fail: v5.10.205-897-gcc9858ae2881) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e54875ce829a2d4c4321

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e8e54875ce829a2d4=
c4322
        failing since 6 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e7d7b5ca481a134c42e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65e8e7d7b5ca481a134=
c42e1
        new failure (last pass: v5.10.209-cip44-552-gc0460fb20fc00) =

 =20

