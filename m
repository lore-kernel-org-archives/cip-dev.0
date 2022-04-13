X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.443.1649866940634864373
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 09:22:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CjFTdYk+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id cj5so2405879pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4GlFEmvLus8wNNh/f3GBaiCu44Ey3twQK0ooQVZOVno=;
        b=CjFTdYk+ePqouJvC3fMI9GXTklk37vVQ+cDsVLSTkcbXgL+V9iNKWJjEhJIQqyVr5M
         OtJUFUBmdxKQ02t5nY9gl4yodDkEsgdCE5qw6qgswg4pbv2Ugp/3WCf2O44fa7DXF8CC
         G+iN4dxPSyeOPNdP9etK0d5AMtAp8ujpJDOrBv/iQBYf5dQpWFM6smrqdP6XibsE4nDl
         YwYvbVzUE9PikG7AW94INWf15zGOsW8Qun86GgrVgeYc8hgi1tv2gukvvqqOAHiRIb/j
         B5d5zP5s4wdt9ds5Uv8kryiotx99UXccdCXqvvPuKvyr3PMJZ21risZ1eQ6LoQv1c9VD
         RSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4GlFEmvLus8wNNh/f3GBaiCu44Ey3twQK0ooQVZOVno=;
        b=I6zyxjh8IZuHXZatxOwUjRtG6+VfvjgEYMElAtYv9WyklCb9GA6VCNCJK9r6JlVNyY
         ffZHprEvU4oRuG12wOJP326+fWSlfWZKFSnyOGVtWB57MWF4ZiMm5TfNqg8erqwO6t/M
         8KihH6PaUVzE8rz/GGjiErXzcKQJXVYYUQuYNrL6vHimb83zk/ZGhLQiOaNQntS6e7us
         iOWUQweXPtNeibfIlLKwG5PaOjARjnALtXmcdALiV4rR3RW2RFt+JzvnBZqI/F1t2PZe
         J7vPMEXjgWYhjxqQjBHSwU39PzYO61s73NyujLws9osMMuyQfNP3am98G+YJX8yZPJ1+
         YpcA==
X-Gm-Message-State: AOAM531C2Y/WjrjQqxLxBO9Jqh6xc7wrAVovnD1rR0MazXuK3PjlNoWe
	J+D0ZHJjkYGy7CyM9z10cgldMFySWkvef/FU
X-Google-Smtp-Source: ABdhPJyWiAuy/wFYJK7QoMjk1l+tkPH+c4MIHGxq07kmERpSoydj/qh11Mn0S+RDFVMBAb/tv0/Vyw==
X-Received: by 2002:a63:7e48:0:b0:398:5eed:a768 with SMTP id o8-20020a637e48000000b003985eeda768mr35273943pgn.519.1649866939929;
        Wed, 13 Apr 2022 09:22:19 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a625211000000b005056a6313a7sm21334917pfb.87.2022.04.13.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:22:19 -0700 (PDT)
Message-ID: <6256f8bb.1c69fb81.d2cff.6954@mx.google.com>
Date: Wed, 13 Apr 2022 09:22:19 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.109-cip5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 2 runs, 2 regressions (v5.10.109-cip5) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-pty: 2 runs, 2 regressions (v5.10.109-cip5)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.109-cip5/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.109-cip5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c39c65c57028fa2c58fb7579c15f9cb67571acc

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ea1fa3222b58b2ae071d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6256ea1fa3222b58b2ae07=
1e
        failing since 15 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256f0858c023b05deae0687

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-h=
p-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.109=
-cip5/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-h=
p-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6256f0858c023b05deae06=
88
        failing since 15 days (last pass: v5.10.83-cip1-151-ga4163710a1dc, =
first fail: v5.10.106-cip4) =

 =20

