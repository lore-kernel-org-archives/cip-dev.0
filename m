Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76447C3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.7542.1704723057399172669
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 06:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=zd0GX06g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so322782a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704723056; x=1705327856; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t5CUf/PiC3UPIeTuAgR+TahHxOjomEU5VpLtreDmk5g=;
        b=zd0GX06gboVotsZrg6MrDnbjRBIFXL/Th+Fc2peLvTxajIcv5qKCQiIkUbDHzI2ANc
         MTLBDO4X+1jcIhPnKhwsQykEh9d0dXM5IQT2k1Egh7bizPbSq9nSQFjCS3NkjlGZATKN
         ZzazWrUak69SiJDFSge16D5YCKIhtMRbitNn+VDCEZ3CyU9ZppPYSey6iCqcvxiF4fgc
         7vojImB4Z8g4LRXNgxdmJY37AVNJ6bfxt+at1kKCsrcmC34PuPM2mehUAKQZfljwXxva
         sE6/Q8dHaOUr1+BAvy+khB9vNfRvBJk9t48u/Xvdo7258jZ3dpnVErgCv9a3gjJtsMkF
         zs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723056; x=1705327856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5CUf/PiC3UPIeTuAgR+TahHxOjomEU5VpLtreDmk5g=;
        b=eFeFLf7qoy38q7kFxOAZJw39Aj5asJF6bt3eT6b0hxardwRwC/KLwPk3k/Lbjfrnai
         sV+hMdG6fz2o2UTBguQqRW2fIho2uvRSrBUrHWZ4A/r3YkVgQXj1ewbJQToVvU9D3emt
         +4ew8Vn0BymZhMkxl5JmGohHCFUEMIsJxRt4doSvcfNCCJ+2wkv6qxXiMuEq63K8CIxr
         c6XJw2BeHMxvnE7tNZXBnItgKa/mMcy5uPp2klC+25F3g7oCXZkU9Mf5P73cZ5osxjmA
         a6LPecJGEsmTGo8+JtpUwIv/pyW8sCWXgfACk+zxEogtQ4JGrBYVDxMrzBGkk5OKwzKC
         1/mg==
X-Gm-Message-State: AOJu0Yyx44MTJ+XJeG299v6SSxfZVTNAs3Ar1678I0u3oYVZ8V437nuy
	mXATGJvR653VM2TAO/8rrXHvhgHbO+829bCQ+nLszvAh3zU=
X-Google-Smtp-Source: AGHT+IELCRpHoLxgvCV4abTlXPGTJN06XpInwoxxajQPkgsla0Cyf4tGJjYsI3zfUxJEEUyYLuSjMA==
X-Received: by 2002:a05:6a20:1044:b0:195:192c:e5a5 with SMTP id gt4-20020a056a20104400b00195192ce5a5mr1028976pzc.56.1704723056068;
        Mon, 08 Jan 2024 06:10:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lo21-20020a056a003d1500b006d9a13b491csm5983923pfb.212.2024.01.08.06.10.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Message-ID: <659c026f.050a0220.4dab5.d534@mx.google.com>
Date: Mon, 08 Jan 2024 06:10:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-fcntl-locktests: 6
 runs, 2 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 14:11:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14281

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-fcntl-locktests: 6 runs, 2 r=
egressions (v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/659bf63e629596534852a3f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/659bf63e62=
9596534852a3f8
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/659bfba0a8f5d816bc52a3f2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm64/defconfig/gcc-10/lab-=
cip/ltp-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/659bfba0a8=
f5d816bc52a3f3
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342) =

 =20

