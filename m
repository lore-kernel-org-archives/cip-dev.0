Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55BEE0202
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 18:12:32 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.4323.1694628745393628208
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 11:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pk7AFXb0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c1ff5b741cso494615ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694628744; x=1695233544; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vq8icEb5HDtEeVPNEoN8QKwoEeFV9EnQmNfcEEg0aZI=;
        b=pk7AFXb0I+SJBd9a8sCrwgFltC1OFFe/43c+cUExAZj96/UiazxrF0897jNFhfckyA
         hsib1swZLp24VcVEvcY2VPjdzkG/1d8kpvD8hvqigtFCaMH0Y4o49RknXvD34+MsOPGC
         ZzlqBOYP7kl3VN8KQCR6VtOJmm5VIsObU7ZYBZ4W+dWYNXhXKqsGFhWIYpKwsjJbOI9w
         ypNO0cppLsZupubVDjEG7Lf3fBleW0ZDLE6ab0jHVSnwTb4q2S0pXSCyPOexHjQPZhP5
         kkILX9E/z2S5lkHNLzRP82S37fnrXgpmulBG4fhdfYePcA0iN2UYyd6JH3yBqbn0mRy8
         TzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628744; x=1695233544;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq8icEb5HDtEeVPNEoN8QKwoEeFV9EnQmNfcEEg0aZI=;
        b=PPGNmQV0kB4idT3pQQ0L9Y0w/wTTLZJVLldJ2v1VgHiRWOC258DfPUVQWU6EE33AFl
         p5YsY9oGPQUxrsm78jXWox0pZwbWQTLhDzRqlP8/UdEzQLwruH791ikGWYcWImrAiVEy
         BiJZiFIScO1nPJ19skNgL3CrOOwpQ4PKJK1aYLP9RNqzdYTt2lLRWDbMUHd0ndWiWbEq
         g0r7Z/aCDs9n3lPreodYtTKvxz95ye+e8TuK6HtyFVrVEyOspBEKWdGRBMTO2Dtpd0dW
         Llmjmk122Lbli2SiNcEjQAzbYqqTkka2hQs8THCOD7s5U8vagkIZb43GvvmHALpLWxEE
         sZyA==
X-Gm-Message-State: AOJu0YyPX1HjKqgMYRQcI494LzKpIdO/9np576HCAQRwxNU3AY46BIsG
	h8oLi5PZ+ZcNyxiOBZ4kCA9V0DdnJaXuoKdmpXc=
X-Google-Smtp-Source: AGHT+IGtKGcPRq+LmW7EizkMHSTbMcdZ2ijp/EwKxBqZBkjHIr/4UenGCBQesGjuGCBQwoGoWQnS+Q==
X-Received: by 2002:a17:902:c950:b0:1c3:3dae:5869 with SMTP id i16-20020a170902c95000b001c33dae5869mr4348196pla.63.1694628744306;
        Wed, 13 Sep 2023 11:12:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bdc66478c1sm10766610plg.309.2023.09.13.11.12.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:12:23 -0700 (PDT)
Message-ID: <6501fb87.170a0220.ad238.f394@mx.google.com>
Date: Wed, 13 Sep 2023 11:12:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d496
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs,
 1 regressions (v6.1.52-cip5-29-g9fee06894d496)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 18:12:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13123

cip-gitlab/ci/pavel/linux-test ltp-mm: 1 runs, 1 regressions (v6.1.52-cip5-=
29-g9fee06894d496)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.52-cip5-29-g9fee06894d496/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.52-cip5-29-g9fee06894d496
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f347fd4bbd65568a0a8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6501f347fd4bbd65568a0a8d
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86) =

 =20

