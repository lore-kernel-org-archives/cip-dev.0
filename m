X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web09.5545.1647307798643271528
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 18:29:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hO1leUTz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id e13so15033412plh.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MfOrXaWj1HELuQzI6AaCo2necTTLCJNcKSl78S+tIeI=;
        b=hO1leUTzKaFCvnSXIrpslVQkkLmdklNZmQjGmJS6lYNY1+FEMxDKEmr0j/v8HtalJm
         78u6+R5b7MonuEWal7dq+u3Q1F4+JxwwG2OmTSFDB0mVC8NpjfaXGZwQVbK5nNTDUC6n
         756HT3KCaachJEGVBAd9iygfKtbncOFwmWcXGjX4hk1wpDjnAN6wPy/0Tia9eBjJ++YI
         ejca7P2TkOhfxoj1hTsvYyY1JksVhxAgIpnJhdEeatlvshTmzKr78m2e03Ey6CgoRP9e
         H3/j0T8MHMx/zv52Lgwz0dczJm7AoR8DjchtqIFww3+QS8KXlcotMAdv559RA8htIhFj
         uUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MfOrXaWj1HELuQzI6AaCo2necTTLCJNcKSl78S+tIeI=;
        b=3qjIIiwdorzO3z+9tZCFOAXkiSektC3Ui0VpjN/z1F1b7leF2qiau8MJdAz+xHuncX
         HpoS2HlSgWjr2RPjOJCLrw2bgSwzk1SX6LEMG2f//lm+xltKK7RIqeDNVjoxDUjgqjnU
         b5hFaD9h6MJYw+/OuFjdFkWzIqkZINJNZfafKk8cRKOHRqoAhoAsOxO+f8d3q7fBKlwZ
         dkBK4aNpT1OxZjDpotlZjVMKHx/VBq7Ry8dd7bCpVYxgIOjQXOKsrxffdVlFrbCiztcL
         WqY3MDSogKOU0efph2z6mwNcJxmwDhdhUoTBir+zSmG1Mp8XsNQcxjRjoveTPHWbvEK2
         /YbQ==
X-Gm-Message-State: AOAM532Q8uccZJftZBJsl05jalFWCGRxB+HP8fuIrDUn6rW+ed3g3zKw
	2rqVu+CI8Yz+I2Pe36KBhfjSHVq0D374xEXYivI=
X-Google-Smtp-Source: ABdhPJzlL61Xy26Ftm4+pjDA7DYhSSQOtdncY9L/DbDwhFZ+odhYJyV+iaV0JcqthVGgIKwQelOFKg==
X-Received: by 2002:a17:902:ba84:b0:153:9866:ff54 with SMTP id k4-20020a170902ba8400b001539866ff54mr821298pls.126.1647307797863;
        Mon, 14 Mar 2022 18:29:57 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a056a00248300b004f6f729e485sm22733026pfv.127.2022.03.14.18.29.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:29:57 -0700 (PDT)
Message-ID: <622fec15.1c69fb81.f34e7.98cf@mx.google.com>
Date: Mon, 14 Mar 2022 18:29:57 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.233-cip69-1019-g2e5815777e975
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 6 runs, 1 regressions (v4.19.233-cip69-1019-g2e5815777e975) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 6 runs, 1 regressions (=
v4.19.233-cip69-1019-g2e5815777e975)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.233-cip69-1019-g2e5815777e975/plan/ltp-fcntl-locktest=
s/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.233-cip69-1019-g2e5815777e975
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2e5815777e975e9b2702739a96b2af41357c95fe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fd751b247af2c3bc62985

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.233-cip69-1019-g2e5815777e975/x86_64/x86_64_defconfig+x86-chromebook=
/gcc-10/lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/622fd751b2=
47af2c3bc62986
        new failure (last pass: v5.10.100-cip2-319-g7182f5032311) =

 =20

