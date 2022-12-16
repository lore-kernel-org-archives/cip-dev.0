Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85DC4167B
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 21:10:41 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.6523.1671225035962550697
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 13:10:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3iXgWtbv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id 4so3528213plj.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 13:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3koeGbrIM09T9Y4CbLp7z59ZklN7pNIZiHhMZS9R0=;
        b=3iXgWtbvyR8R2dOkMuEBv8E8cptvlyXUIa7J2b3TRNpFjlwExOJcSzGY+sUBdb/YDe
         8l1QOlWu07trsJWruHcBuLhirDDjOSOd1gjvMLpPANkt3UhUREXwYjHW/TiZ7hDcWVza
         Dto4R/u6NvOV/c6TSDfPAbJKmt7s6W/H46baSaiSQEPzh0T4otcHJtbLdIGIkg40NApq
         l97KIHusHbHZYfe8itoCtcL7Xuf3bTut337CF4dstdp88Q/7tLWfvlMOi/013zk3LkTj
         OrEiB820yF+4rzo85i1mxCdxUqaFlPrdS62FySINUmMyRIZG6CwOzdLUCi4PlC6QV/TA
         3bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/j3koeGbrIM09T9Y4CbLp7z59ZklN7pNIZiHhMZS9R0=;
        b=yvKtEWCp8aoKElkb4l0UsKzNTpDNpivxfrG13IsDPK3Cmd8pkVla7SrKVgRl1cBYhA
         hh0MdyALiRnOmFCkBIj5BISrY2+Gx89O48+CIZOtPzbiE9ZXaz1cKIlVGPMGHC2/5Qy/
         9uAtJJbZVALC9T2K/QQXosO7PWvwJTQC+SN0BtYsGNZAihte4mRDAwvoxnQ8pikmA4Xr
         GTR6AdQxL11KwbdNMeoTePtC52pE8LYSDEaXaNCUXeNcLNzobJOadI7lqqeli3Vr7CK/
         Z2BGaJNEyVdUetDSdr+YGdPRQlzYCwIk/yAwXnlzrdYgZZZjoxPghVpHLeBcj+tuhlSm
         mliw==
X-Gm-Message-State: ANoB5pnFhN/xsiIFOVcC2uX7cmfDPjghhY/Y+hlFBSMAzRhDGoyzhNdZ
	zlqi72gD1QGfBPRfAv+NIkz1TefE+d+KHw947LA=
X-Google-Smtp-Source: AA0mqf76ioPlvlH9leXSRZcYcffXeKLHZvTOcRqN3CCbXxbd1VyQ9Hvu7PuQPOuYNblY5pMVnfwzwA==
X-Received: by 2002:a17:902:6bcc:b0:188:5256:bf60 with SMTP id m12-20020a1709026bcc00b001885256bf60mr32657900plt.25.1671225037394;
        Fri, 16 Dec 2022 13:10:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001890cbd1ff1sm2060585plg.149.2022.12.16.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:10:36 -0800 (PST)
Message-ID: <639cdecc.170a0220.ee94a.4669@mx.google.com>
Date: Fri, 16 Dec 2022 13:10:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-ipc: 8 runs,
 1 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 21:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10247

cip/linux-5.10.y-cip ltp-ipc: 8 runs, 1 regressions (v5.10.158-cip22-7-g924=
62fd9830b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b7218b76b89d4cb8174b136fc03b46ad4b749578 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/639cde2ba8223b6d872abd07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gxl=
-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-broonie/ltp-ipc-meson-gxl=
-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221209.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/639cde2ba8223b6d872abd=
08
        new failure (last pass: v5.10.158-cip22) =

 =20

