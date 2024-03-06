Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD3FC54E41
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.9708.1709765213158304725
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VpXXu27N;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd1d9daf02so1696665ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765212; x=1710370012; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1U0KbbP7dUeWyRlCyup6x7plTTf+3CCCTHHPbjJGP5I=;
        b=VpXXu27NYuXIFGn2d4ipGkzpEZeAItRyYf1xhq/xRHNKOWax/UYWkWrVBfpPrhp4bQ
         vyOM9o6ww3T6Q3uu54lOVjrJETNBxX7eedPEgCjU7/djR7mZMnFPefzaxJ0DlQGyb/UM
         tKUiBz0W3y547RJDhM0IK21KoA/DNmmapGIei64WC6YeQYqxX4eo6oHTw7688tjrZJl/
         3gMwQ21ITxN+XlHq+bLnmJ9ldSURZj/sWFk1ZIO3fBZIvuxc/CzmXTTMMeChWVlkmy0f
         RCSQ2XFQRrQOBZt3JaOKNUSuDt91qIO2qZLZjeJnyLA//LfJ2T8ZIzWzQfsYeQ6IFwnW
         VdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765212; x=1710370012;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1U0KbbP7dUeWyRlCyup6x7plTTf+3CCCTHHPbjJGP5I=;
        b=mmii0AHj43Jap+WtZIhemlFFFjJSVay6eAzt55TaOb85x9j+S3dEQyyMAdg+c9S1r1
         wWNJjb8UD4AFMZr7xkYcqZOgadNilfb0u8mmu3UxFobKmCZdrWNRxsGuk+bUT7BOT+FH
         NNOgT17zpBfWO/eqZrz/SgGCXzaO+zm5xOg8qUJvrmZ2Wn1OnGlrghrv1/UD24BlVlGL
         bRIQKVQpDuq4Brmemp/a44bQ2WJ8XPSCik+JbyOhHLc9+pMphNFXWA9xDzLd19Pq+XR1
         A3b5FSn7uPIQOaICVzXb67UeZxhJcAXjPtCCEkw/qrd4kvjGZuattegaYiqla0kcV1GS
         Oxng==
X-Gm-Message-State: AOJu0YybuWyFWF65aCzN6p84zcIYatHdVA3TFTjWATHhOHhC0BQUK8No
	/KlXqQUCq+9Ghlc7MOFMjSAcGs8m+4rno1xOIslHjEK9ZBc1Ovl6t7b6ltgi83SF6+xjdYrkVEN
	iODg=
X-Google-Smtp-Source: AGHT+IHqcZHnSHY+fY8nXAM44mJ4myXBQ82y5lxHQswLSE7rcZqH4I9TBORvOHmBCDj/UYdgTHbHZw==
X-Received: by 2002:a17:902:c20c:b0:1dc:fc69:7a40 with SMTP id 12-20020a170902c20c00b001dcfc697a40mr5758992pll.11.1709765212101;
        Wed, 06 Mar 2024 14:46:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001db608107ecsm13065679plh.167.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Message-ID: <65e8f259.170a0220.20cfd.2fcd@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs,
 3 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15249

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs, 3 regressions =
(v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e1f16b3cd440734c42eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/riscv/defconfig/gcc-10/lab-=
collabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e8e1f16b3cd440734c42=
ec
        new failure (last pass: v5.10.209-cip44-552-gc0460fb20fc00) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e028147197167c4c434e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e8e028147197167c4c43=
4f
        failing since 125 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e758f617ab7ec34c4306

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e8e758f617ab7ec34c43=
07
        failing since 76 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20

