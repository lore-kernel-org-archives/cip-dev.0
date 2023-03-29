Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31562C77B61
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 16:30:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.1105.1680107426173799334
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 29 Mar 2023 09:30:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cXaPL08t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id kq3so15433909plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 29 Mar 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680107425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUfL3TUTfESCwOtM/OIkDgvFzIxbbdA6MbRsOUmcXAk=;
        b=cXaPL08tFK2ko5YKHPpDrozhUdBwyEADJ3fIvZHMNRrrZuATAsQ8sx9YKtoMuDxWWZ
         LTzQpUyZCU+0hFGiU6II95vqbVokTYrJhSAofKs8AXNZwBCX4r+5vBYtBfSTDq69JuSi
         pXQhk5L/r5IC/CPSEz+dWFV8T89285F3/YYp+2ptrCuegQ5e4OAROp5isYvJP21Pc9We
         4kfPmF/uy9wlR+E9oxTsK9IGOh758XO25xxf3XzWbmApOaexvkPDZg7mgIjmNzOnOady
         8oyNKztd9+tYP1xgxzVSwqd4UirHYQsz5HOUQSf/TZ89G7MKdi8PFEbNd9K4meOras6i
         aMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUfL3TUTfESCwOtM/OIkDgvFzIxbbdA6MbRsOUmcXAk=;
        b=Of3Pr4dMLpaf6XyS2tXC/bZe7Fn3LhygNjruycVycwQzkOmfrA2ppar7iym+b+w3fL
         Rr5ToNp/k3MngcdTN7uDT7nS6rWb3pxNN8+zQt0/T9ZEHbMV/BrHntQihrKOBHSf07lI
         d+75xpv8M3GoxrMGE44l78wiYvsNM/DYdounU6UhHj4bdZdUP5mrxSvgGgh5r3AhEIWd
         yidWMSnEptC7p68Hsov39Md2c85cXZK6ljerkXBFKVeB/G5p8FpmFn8tg5q67Liung9y
         EQEipic7M+LpujRCiD7GhrjISZMjQI9PwvN9UCpfcqRgVkbXm0ErKZP5XlWYZDyStNF1
         a3bA==
X-Gm-Message-State: AO0yUKU0xfAyhpWVYWFWq4ZiGF0I4cR8UhGpHTN2VKthfi2Vd2qSP0xG
	t4uQBTtb2vpHydcpxUBvqlqGaRxTvafEPWiJYNlP3g==
X-Google-Smtp-Source: AK7set+viKyxhz0f7EzSl0W326Qcc52xu+uM9dSh+fW2sIf1y0dBG8fuin2YO5LEa9vFIQy17bQpKg==
X-Received: by 2002:a05:6a20:8b82:b0:d9:7fcf:1076 with SMTP id m2-20020a056a208b8200b000d97fcf1076mr19253528pzh.25.1680107425247;
        Wed, 29 Mar 2023 09:30:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a62e906000000b0062a56e51fd7sm11886165pfh.188.2023.03.29.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:30:24 -0700 (PDT)
Message-ID: <642467a0.620a0220.abec1.503e@mx.google.com>
Date: Wed, 29 Mar 2023 09:30:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1097-gd51b0e04681f
Subject: cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1097-gd51b0e04681f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 16:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11128

cip/linux-4.4.y-st-rc ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20=
-1097-gd51b0e04681f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1097-gd51b0e04681f/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1097-gd51b0e04681f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d51b0e04681f73604e7ebc991f6a63833a70d3c5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f41e8a2fa6f048d456ec2b136db9af50c7e42de8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642453381580b2232262f772

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1097-gd51b0e04681f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6424533815=
80b2232262f773
        new failure (last pass: v4.4-st20-938-gc773c630d0e4f) =

 =20

