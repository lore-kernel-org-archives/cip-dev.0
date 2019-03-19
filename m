From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 19 Mar 2019 03:38:00 +0000
Subject: [cip-dev] CIP kernel Debian package
Message-ID: <OSAPR01MB37630D32D160DC2C7295C059D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Jan,

When you build the kernel with ISAR, do you create a kernel Debian package?

In that case, it would be interesting to distribute such kernel package separated from the rootfs. For example:
- the package could be used with other build tools (e.g.: debos)
- we could create a simple update mechanism for the kernel with apt-get
- the kernel can be downloaded by LAVA for testing

Alternatively, we could setup a Gitlab CI environment to build the kernel and package it. Then, you would be able to install the kernel as a package in ISAR, instead of building it from scratch.

What do you think?

Thanks,
Daniel
