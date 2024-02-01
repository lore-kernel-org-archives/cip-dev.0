Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869CC4828F
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 15:05:22 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.17689.1706799921936602048
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 07:05:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=y6MM4JfC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d944e8f367so8816435ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 07:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706799920; x=1707404720; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EwTezBD3nSLBl2hk7H7UNlB2Y2GW03qN0f7x0XGpy0w=;
        b=y6MM4JfC0OQAZh3ayrxSYgOcT9kthxWHJMl3/a7kNkTh2HIMHk2Y+t8vs+pf2xp2s5
         t7Vj1ewQCAlBX77GDK/e0RUR2U9YY/zzdCuyQkAtAvZBNoNEjC1XqURlN54cWdQ3cLWi
         fXzULxhGNFRJf2cLKmLnikeBrJDZbngEo09h9qAPd5XlPhXXGr6cKSjcvzxtsg8ZQrIl
         w2vbJ7jusHnefTVr6mziRAtlgQLbgFX0OuQknZe+RDdQnMaJXAjdGG43Qupo4hVMaTOO
         QeWT5Y5OFEHEApf30W8zthOt4ypS5DqUUCRMbr11GVs7+QGUApEgRRqM+C9y6DBomPAF
         AKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799920; x=1707404720;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwTezBD3nSLBl2hk7H7UNlB2Y2GW03qN0f7x0XGpy0w=;
        b=XseMVKaHnRyfACDhjY72sszVQzOWbDTVfwiaGDsDRgANKvwZRQxKLtvFv3MKblhwbk
         o5eu6xo0Tah/q9/SGr2hhpwpBPDufL60S7DfAd7UhA0h8kpbS3fWmrUn6r11DirHJdCL
         TxbobD0WwnPSPs3Q+yfZ2uRUecwwaeHYgFSrRrwf4CIkhUWbndlHgNK581JB1oUmFpoQ
         fd/bPlOkgRy1BAIxJciR16nHElORAZyo2+vf0fp4+jTMkBnoMvJbwysr2QhPbbGb3HZ9
         7DjWIM2DXLgNoYCAdoZAaVtPoLYIHNbGk9a1sZqqTIaD12WbkWdCSWea3Eh8QGRglHs9
         xwHg==
X-Gm-Message-State: AOJu0Yzmxyj/mpd0uNWKI8mGDiE0H2qoygAf+rMWbjQ1NqIgYTlXJ1eo
	PoLX/9+SCxdSNfQ3RXlIYLSzlVfEwrhwQpw2hIJv3qpL/ZauLC+C8yDJqi6W5HZKUTfWR6np9Fm
	z
X-Google-Smtp-Source: AGHT+IHe/4C+16zWzgZ/tdEEKYgv0TLbpUSUBJcmCi1zU7W5rze6y5B8LwolyBmBaiGZrAwBs4TNnQ==
X-Received: by 2002:a17:902:e892:b0:1d9:143b:eaf with SMTP id w18-20020a170902e89200b001d9143b0eafmr2460607plg.61.1706799920298;
        Thu, 01 Feb 2024 07:05:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVcF0zWB4WxJNXdwzvtjEzwL6Z1V6miNHnRuQLuEBafTYe66daPmjxEu1KsvxRbpzBsOUqNv6GwYT4GpEDWvj5YXiejlqRkTQwbfl84vPPbNcaHQJx/kQH57yFzo9nSgbjEYPO9gyCdUiWp8Ixj+RFVVA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170903290b00b001d936a7bd46sm2837930plb.271.2024.02.01.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:05:19 -0800 (PST)
Message-ID: <65bbb32f.170a0220.36449.9f00@mx.google.com>
Date: Thu, 01 Feb 2024 07:05:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.72-cip13-31-g9539320ac89dc
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-pty: 9 runs,
 2 regressions (v6.1.72-cip13-31-g9539320ac89dc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 15:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14584

cip/linux-6.1.y-cip ltp-pty: 9 runs, 2 regressions (v6.1.72-cip13-31-g95393=
20ac89dc)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-31-g9539320ac89dc/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-31-g9539320ac89dc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9539320ac89dc2caf6bf646eca56ac33ae7c615b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bba93227523d272900a041

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bba93227523d272900a0=
42
        new failure (last pass: v6.1.66-cip11-1-g2d3d776d703d7) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bbaaaec3144e38d300a042

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bbaaaec3144e38d300a0=
43
        failing since 13 days (last pass: v6.1.67-cip12, first fail: v6.1.7=
2-cip13-30-g79e2886a5da69) =

 =20

