X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.1422.1646793366480743576
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 18:36:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Zusrf4yq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id mv5-20020a17090b198500b001bf2a039831so3892958pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 18:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PdQ80+Gf7BftvSo4CB2iUHDb3wBwqrT7afzvVPtga/8=;
        b=Zusrf4yqqSpN5Fii1JYkjtzXqYcmof2UqeUN5hjPjDI6fsOgQB5Kg1cwW3UWpdw4Zm
         JBS/SIVVxJXYPwgEumAQbExyZBjp9KR5u1JP/Fiz76SpTBV0+Vz2NrqzkjRYgq2VyGF+
         OWVgVhhKwSbSVViO6el1lungR5pFsq5uMzZlDYkl57gDSlTuMo8HFqq+WJr7PeLIaMGt
         1cgvL8RdQkW2hxuAdTCg6KsKY9kLI+xnMnSLRokNO+hvhMr3zoRlbzl9YEdTjj9FteEO
         Ep4QKqcZ+wGlIiM+zGMjRaBqJ/qcEFZC0Q7w6XWp49ANH33yQAhp8g8xSNvSszV+Cu+r
         C7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PdQ80+Gf7BftvSo4CB2iUHDb3wBwqrT7afzvVPtga/8=;
        b=LLRFG7wCqq6XLxjxiOlTm0wmz8LdeZ1FNy92WTXP7ycJ2TS5bBWgjOhQBO1zXPDo0B
         nL8eELE1EuUAi2quhG80O8QY4PXAtBRCuoORLXnhGgB8EtX/vQYUmkErGCk3a47eRCQD
         RE13ealBkLATwBt3fRd9XZM4g0RyYZa6UB/DBfKjiLyUgB4gcxtnnv4iH61op9iL9gwt
         IQp+LxbP7QBMsyysvyzHt144kYhY69NB6uh8xphyHFmn/A/67c1KH65EyZCU0webwASY
         gc/mgtYfWh/0aNA1PAs2DDxE0JV+xK6VRFSqiyntM44GE4hN1N9jzZvuc6GSOCUYi7VW
         fxPw==
X-Gm-Message-State: AOAM531qwt3shFcSGLOPW5L9bL5dY4jXTn5TlxgzxuKVPJg+6nD+H878
	K/P5rgGMnCZtvn9J56XH9RqfXk/UqIu6WdxmGlQ=
X-Google-Smtp-Source: ABdhPJyw4lb2nf2WdDXpTfnIeCIK3EXpnEbH/zT7ahE7L8Ib/pc2JW2tsrCkPgzyhQTNpiPfslvj4g==
X-Received: by 2002:a17:902:e84c:b0:151:e3a4:5ffe with SMTP id t12-20020a170902e84c00b00151e3a45ffemr15089783plg.18.1646793365840;
        Tue, 08 Mar 2022 18:36:05 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h10-20020a62830a000000b004f73c34f2e8sm430149pfe.165.2022.03.08.18.36.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:36:05 -0800 (PST)
Message-ID: <62281295.1c69fb81.fa1af.1de4@mx.google.com>
Date: Tue, 08 Mar 2022 18:36:05 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 9 runs, 1 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-cip-nfs: 9 runs, 1 regr=
essions (v5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/baseline-=
cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62280f1bb7fec49983c629d4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig/gcc-10/lab-ci=
p/baseline-cip-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62280f1bb7fec=
49983c629d5
        failing since 5 days (last pass: v5.10.100-cip2-239-g01aa183a119a, =
first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

