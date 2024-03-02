Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEAFC54E49
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 03:49:43 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.43053.1709351377529007012
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 19:49:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=aBQZWlK3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so1957502b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709351376; x=1709956176; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0UH33gIdj42gTy+Nas8cC0zn9KWqYD6KGoMMHu8fVNk=;
        b=aBQZWlK3GQn6iJMrVRNX4gQxNolcACPAkMaD7cYgItMXLxq8tkNnosUtv4yfrKRRQG
         sLapzOBsbDfErkphdZy7XyzxmWNqjvjtzvR5RX1l6BtjwnncRTvEbjgKnBAnhEsAzrFz
         kStFfU2sJU4jjnRpjI5PHx6mg7RZ55FIsILZTpkQLWcLXMZSP3Eh3SZ6T4D0ikbLhaAp
         IyMQ32swE+OuFGQz1P3QFIJQPPvbxvahJ40UN1rB7enccRb9NXy/VRgSv408Koa1SAq0
         wb7ueTUMWchLQy/KclD3cSK+HTKzH3uWHo7fgxBYSQtICvljYBEBEhj8HMUyqmNAVOb+
         fTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709351376; x=1709956176;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UH33gIdj42gTy+Nas8cC0zn9KWqYD6KGoMMHu8fVNk=;
        b=URr9mWsuzVhLtenJYCyiEIJTXALYf87lKAdMkhmwnXv3ZBvSMJXIxHXH2gkZtb+tJx
         7fYyCt/Ig5xDGtfEzZJJw8qjEjCWCulVmyxTEBLielg0ZxmT182u7AOn+Rul0DYFKUa/
         81Fl7TGy+pX7kBM1NY7+tunLVSlT3LKiWaBYdmyaimg2uQdUGNulwxKip9DtLyO4hPxA
         3fqu7dSS3ucNsa9iUlVXsAtyvYvWiz/Zcjj+kXaOcf7ulgr36n6tUq3jqex9kne55jZK
         I6hochyi9zn/txZQd54r00dlW0zyJDbk+jTdfv/l1ZNmGH1knIRnAjjwRZpOCC63jVAq
         uTLw==
X-Gm-Message-State: AOJu0Yy5l7QNPZzuB79nAGRjKWJlMCGiyn51sHgikUushZJCAkP3MTxO
	O2p9SsUxGh+O+w4eN7fBScwVjTKF1c2167snw9C4JrbNzuONnkSddKaheVqSQZ0OxzmXjdHngBQ
	8KDc=
X-Google-Smtp-Source: AGHT+IHmjK4CmDRxpH+7RfcmMjb4BItbIz6fcBztLjY5cJlBbBfFQ/7pJftXkV9OyFl71s+/CHblfQ==
X-Received: by 2002:a05:6a20:5484:b0:1a0:efae:53c7 with SMTP id i4-20020a056a20548400b001a0efae53c7mr4197678pzk.14.1709351375987;
        Fri, 01 Mar 2024 19:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gb2-20020a17090b060200b0029acce2420asm3913552pjb.10.2024.03.01.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Message-ID: <65e2a1ce.170a0220.d0798.3085@mx.google.com>
Date: Fri, 01 Mar 2024 19:49:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.306-cip107-rt35
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-mm: 9 runs,
 1 regressions (v4.19.306-cip107-rt35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 03:49:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15163

cip/linux-4.19.y-cip-rt ltp-mm: 9 runs, 1 regressions (v4.19.306-cip107-rt3=
5)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
  | regressions
-------------------+--------+---------------+----------+-------------------=
--+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | defconfig+x86-boar=
d | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.306-cip107-rt35/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.306-cip107-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
  | regressions
-------------------+--------+---------------+----------+-------------------=
--+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | defconfig+x86-boar=
d | 1          =


  Details:     https://kernelci.org/test/plan/id/65e2938c1888e037e1637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-1=
1A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
306-cip107-rt35/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-1=
1A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65e2938c1888e037e1637013
        new failure (last pass: v4.19.299-cip105-rt34) =

 =20

