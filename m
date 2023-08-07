Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E17C001B0
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 16:16:53 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.38979.1691425011048619919
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 07 Aug 2023 09:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ABvPEh2B;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-686f1240a22so4548040b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 07 Aug 2023 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691425010; x=1692029810;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L9ZG4MZc32n61+9CGa4+jia5Nm9xbgFslJev7wbyXEY=;
        b=ABvPEh2B7TvCVtgtd+NXYqWUxyylQ7RQBk7kkx5txopPH6Iv/DDNnm8SuodPAt03hz
         YdtXZeK0A95d3HQccaLsT7kJh3PtWk0cvJW8I802LTpKhIm0ZQ5WwD7RBJry6uopTJs1
         5g3100QHO6E1PDJen9GnKWWACIFEvFRsYvlFr7x1cjzTkfDLYMtswI4IXhYxcOn5O8G/
         ycxa6DOq/1raBG0HRcKa2e7zhJN2JN0ZSeaM5wS/FCeBHC7ulkjyLLsfjnGXHNyk1tkd
         QHyQYSKSuvVbfXZeDTjpbyHQV0I7RBIC4IuuUHWRChv39hhkUWt8ERg8ZJp2S2iai+A/
         8iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425010; x=1692029810;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9ZG4MZc32n61+9CGa4+jia5Nm9xbgFslJev7wbyXEY=;
        b=eZO+LyHaT3ksIq8kmGziiohz4RMPzpdXx1Okg3TIAQiHhys2zzsIV6QaLT20rOiaKw
         g1svf1hotSXY2okOkJLlTGRmIm6q+nSoxChU9N1utOlt7X06FTpxqq3j2s2uEc81KU/Q
         t+MC7XwPVH3he7vMxtLBnjIEuVkHB46vLzgvhl6qmEfeIqPLBg25yTAAHOkXdgx+qSB9
         mT1j5oIxTdynwR7NLZD/yB20n5qyxbxXumMMSyc0w/WEjsiyyy4GDR/N8t0L43mVjE+f
         WffkV4bAc17Mx1UbfcHMXR0UJBBwPyYgO0+Rt+js8Jmdm8OpClDVIAZtrv+SkleemlFW
         kJmA==
X-Gm-Message-State: AOJu0Yxxk76DmKi34Xggx+4GHHFq+kWjQ2q8/YiMDwc7M2sduXBJ711x
	YM40MLGmHareOpRGxZj8k639LfuWN9bJ5W0DGNwK9g==
X-Google-Smtp-Source: AGHT+IE8+UnYkfAbeqXVnPJ4D65fOI/bO/REVdAf5GNozpAXActzpltYRHuilPH5Y/cObFXpYGzBog==
X-Received: by 2002:a05:6a00:1ac7:b0:687:4323:ec31 with SMTP id f7-20020a056a001ac700b006874323ec31mr12393895pfv.13.1691425010121;
        Mon, 07 Aug 2023 09:16:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0064aea45b040sm6324872pff.168.2023.08.07.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:16:49 -0700 (PDT)
Message-ID: <64d118f1.620a0220.bb1ae.b089@mx.google.com>
Date: Mon, 07 Aug 2023 09:16:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1447-g64a295c810065
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
Subject: cip/linux-4.4.y-st baseline-nfs: 11 runs,
 1 regressions (v4.4-st20-1447-g64a295c810065)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Aug 2023 16:16:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12558

cip/linux-4.4.y-st baseline-nfs: 11 runs, 1 regressions (v4.4-st20-1447-g64=
a295c810065)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1447-g64a295c810065/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1447-g64a295c810065
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      64a295c810065a25a02cc0e6ae5fcda96967143d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d111a39729cf006a35b1f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
447-g64a295c810065/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d111a39729cf006=
a35b1f4
        failing since 126 days (last pass: v4.4-st20-939-g5ff13a6decb9, fir=
st fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =20

