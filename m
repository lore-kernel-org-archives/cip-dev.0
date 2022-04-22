X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web12.9447.1650637892844049059
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 22 Apr 2022 07:31:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=k9jWIMCw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id b15so8184087pfm.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 22 Apr 2022 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vI3diRAfMKvBj7bvTvpLfD8KaCPSUXQ2lNXpQ9NISpY=;
        b=k9jWIMCwgkSvMR1zAWdVk0WKv7tjkmfCWGGj8RKFy1HT54QVGQ1IWGzeDi3LaG+HtQ
         YQWlfNTgx19WG/5zW6Ao1+zfHkRo1knUaTTigfDKyPU6twB3UilEGhkcEfX9C1SXTOSu
         xwcL3PFcwVpOqj9+yVJWpSfSHf8xcuU1DA/gegJ2dyJWePQWfrhaiIUt9qymcP7A9zFX
         3pm1dFaKNOXblH4Ckff5+t6P0MHL6yfSWZHQWTDDONoPkzbwRgYJy5TvIWMOvYXPjdFQ
         Hh+ly9+RNzAXZajBI7UODdX/sWvWeBtmCcfWVtEMXejPjuCZfs1csdLfEcW+eMBM+VAe
         Q+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vI3diRAfMKvBj7bvTvpLfD8KaCPSUXQ2lNXpQ9NISpY=;
        b=b7rUkekITZkXSadgwyaCLQy92aa2x6s0As4GOc/YDZGU932Picq97Y2vHDUigAzvf0
         GqFRG0aVXu5kmI/QbZlc9IplApAkxfSoG5ryS4weDh1prSnAPbWYxHttB68tFovJOCwk
         fTyb6EToi+kqIcxBJ3wcZXYJdtKJqqUIa14GgsvXbvpHMdy8MLT9Rm9Q1H9koR912CEv
         XDJC4SP5uWwbOBlGiYBDGUj9uVSjaVIX5WErx7mYjUnfCvjjmSAn9wspLb3opCHn9xG8
         DwVAVBWUWvp1hPJsFvEHt7L8p9IK8exifyoVwxWlvmWzuCudDixVTN87wxtwM9gsVwja
         btPg==
X-Gm-Message-State: AOAM5326nVb9KuRgCVjOtvH6TOIMW7AdPpV8+0Xbw1VHicU8sL9MTE+F
	uLafuoCVVQK2v0d+e9nrQu7zdhHAFW18VYoxUW4=
X-Google-Smtp-Source: ABdhPJxEoCzEzerPy7+mcHqRkQmJ4K3th6av6ommuXDPy8tlPdgrTtPd9T21kS/qawOSJT7UURgAmA==
X-Received: by 2002:a05:6a00:a26:b0:4fd:f9dd:549c with SMTP id p38-20020a056a000a2600b004fdf9dd549cmr5312972pfh.42.1650637892009;
        Fri, 22 Apr 2022 07:31:32 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090ab29600b001d287fd3f79sm6072343pjr.46.2022.04.22.07.31.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:31:31 -0700 (PDT)
Message-ID: <6262bc43.1c69fb81.1b45.f819@mx.google.com>
Date: Fri, 22 Apr 2022 07:31:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-516-ge5e741fbfc87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v4.19.233-516-ge5e741fbfc87) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-pty: 1 runs, 1 regressions (v4.19.233-51=
6-ge5e741fbfc87)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-516-ge5e741fbfc87/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-516-ge5e741fbfc87
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5e741fbfc87d414037c91102d2523f655726811

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  91fd818dbff1aa3bcefae3747f83e1dd5c1586dd =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6262a9e27ff221b1afff947b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-516-ge5e741fbfc87/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220411.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6262a9e27ff221b1afff94=
7c
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

