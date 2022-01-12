X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web09.22936.1641994063584466993
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 12 Jan 2022 05:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=B2voTGUj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso4707439pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 12 Jan 2022 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kiwmw0nW0J52kS604HjvpjxIskGcw7byVhsVj63onaw=;
        b=B2voTGUjvEBnNzcseTC+OO+DgWEi7xUuAi4lv3JBooDqWLhhvLbYF77PwCOMaDJ8sJ
         xUfNNMLnL9mHFBi4SyZXzSfZroPoMerB9v+h4lHImKmDCTbC1pKc6nngJel+mYJwWraf
         y+pl19JGuMrdupfwVWSg/dpJXuLIsO59eN2UCWdqhu5ccAPy/J1Us2ktkAvcKdR9+QZ5
         UdL4NhQ4GH8ogBqdCmG+MnBu5vwkghOnaXvmyjvKXul2eaTVr9eGlRGn7/MXFUIwHmW3
         Ll8fF5BjBEmjxjthzsh6aZH4Cvqy4rn/0d0V3PYemIUnPBNamNRFf+/gVDy+dLLYp0jS
         sIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kiwmw0nW0J52kS604HjvpjxIskGcw7byVhsVj63onaw=;
        b=gpnVOZeXymg5YytHLiaXkAah6CnLUy1NAlUfGCpj3LZwQf0nKLxwiZZDNuIv9lOezz
         +x54rFLpWdOr49vqI9br8ed4q67Dj1z17r96rvRCz0d/TR8gogrYAQnOtllyPu4iMQq5
         VL1Ly6gjpYoTONrPZjWUhO6HfI4vKyYRf748JDx71XgPLj9DpEdq2FKs0IJMds3H73GE
         HvSwU3iEWzWKJebaHVnQ7p+l4mdLPBsKFcSbDvHSbpHQr3qQH6xDC9rdwQ7EZIDHwJQ6
         RHNE6wT/hOHEyP0XNvHT58SxtzVyarEDjMkSdwQ4XNAhmCVarc5e+sybfvsTxvrAOcKE
         m56A==
X-Gm-Message-State: AOAM530RmlgLg3yGoBv/uI7d83+QezxPMEYnbTpLqom1qZZS1zObLv59
	WVap6xGv5qMc1ip/bzTDsk3XAygPaZa+axY4
X-Google-Smtp-Source: ABdhPJykuIAGkDqdb6w8uFH221XjvWmPVBVCn1peytm2G/7VRYoRn12bN8hTnKXF2F59/cMddW/vcA==
X-Received: by 2002:a17:90b:38c4:: with SMTP id nn4mr8798996pjb.227.1641994062946;
        Wed, 12 Jan 2022 05:27:42 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h4sm14557828pfi.79.2022.01.12.05.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 05:27:42 -0800 (PST)
Message-ID: <61ded74e.1c69fb81.5379d.33ec@mx.google.com>
Date: Wed, 12 Jan 2022 05:27:42 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.83-cip1-150-ge27e063993d9
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-ipc: 8 runs, 1 regressions (v5.10.83-cip1-150-ge27e063993d9) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-ipc: 8 runs, 1 regressions (v5.10.83-cip1-150-ge27=
e063993d9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.83-cip1-150-ge27e063993d9/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.83-cip1-150-ge27e063993d9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e27e063993d9bed9942dbaddd575086dccd29623

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e48f57becbcc836f7d9c554b1709a5926e29f703 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/61ded5071af54ef8b4ef6748

  Results:     8 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.83-=
cip1-150-ge27e063993d9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-=
ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20211221.0/arm64/initrd.cpio.gz =



  * ltp-ipc.pipeio_5: https://kernelci.org/test/case/id/61ded5071af54ef8b4e=
f674e
        new failure (last pass: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

