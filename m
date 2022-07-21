Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEAC433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.4925.1658400838582046295
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tbKihjqG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id r186so1337511pgr.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KYgAcNui/LLUAX+nAtPFnzAPj0UVFzr2QEFIVBajI8U=;
        b=tbKihjqG3vG8ERFjvzO/19Te46vVRKfwSCKWIuThSVqFCXADosVfy/pVTgiV4zF8LS
         IIAKv8DyrIWsgJBcU5ZYIzhGE/P+PCD7ogvAJNkA/W29ER5fSGS1M8iEYLCiqsA01/NT
         XUzNk5wrPDXD8Vs7FQnjks2rST00DnpA/kca5gp7E4rJgVSI8moFnVQ1YMHxyX7R7Vyr
         cQVMzDX7ADoEgkL8kkH+ptkGL30Bbab6x0idmfsFaqtrYRPAYMkafYQx/qpmVOBWgnr4
         //61W3CnVtJdlnqKJmQp2J7QRgAP2yj7rfvmk52d5OZXYmy+EiwUiA2QGYNrB52zyD6/
         DjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KYgAcNui/LLUAX+nAtPFnzAPj0UVFzr2QEFIVBajI8U=;
        b=pSeBIEDbck8sglUIDj2UJi/yAWv2h/hJV6uImYjgfjSxSpybVKVJzokxcaL+EjZMe/
         /4rcSLvYcDaznoUXgjnyora9mbYEVnYjNAEo0DDJYvQRKMzPXaDmHcGwW7r4FBXE/qlp
         4gpz5p/lmOYeLTpU7AQAVi3bAfrg6dMBvqWybXNsmKv2qFSsBjzMiXFPMGTr+0qRdJ0b
         4+x10qlUM28+r+2bVrMJZaP+g7jp6266iijLL7D2iSxunfHc+rqA515Us58of2C0gFnq
         QMFHL2ku+QuewgWkMCfDQ55arVT3GYuXc2sVnkAAjwB6XFVKd3fdDwvO37Nh0tNP2KAB
         xFAQ==
X-Gm-Message-State: AJIora/vw2YNxl0O3FFRAKDKIAATTslSRSpN93MTJBLy5BPQLu0RYB0r
	ko+36v7nos9ULsiVaOBajGasJbEdXr1liSd35/M=
X-Google-Smtp-Source: 
 AGRyM1v6qSNQZo3w6SejPW3EVA4rZ8DRXJgnlJ5pLgzT4lKJMyo8gpXDq0MhJzCmyWfIDR6JakVO2w==
X-Received: by 2002:a65:6714:0:b0:41a:49fa:2bd7 with SMTP id
 u20-20020a656714000000b0041a49fa2bd7mr11933984pgf.331.1658400837924;
        Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 t12-20020a17090340cc00b0016c5b2a16ffsm1330112pld.142.2022.07.21.03.53.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Message-ID: <62d93045.1c69fb81.9cdff.2118@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 1 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8876

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 1 reg=
ressions (v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
          | regressions
-----------------------------+-------+--------------+----------+-----------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91ff6ed0f0419b3daf0dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+kselftest/gc=
c-10/lab-baylibre/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220716.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/62d91ff6ed0f=
0419b3daf0de
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

