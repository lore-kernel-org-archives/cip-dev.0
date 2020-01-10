From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 10 Jan 2020 12:55:52 +0000
Subject: [cip-dev] [ANNOUNCE] Release v4.19.94-cip18 and v4.4.208-cip41
Message-ID: <OSAPR01MB36679D8C9614D4B4505928C692380@OSAPR01MB3667.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

CIP kernel team has released Linux kernel v4.19.94-cip18 and v4.4.208-cip41.
The linux-4.19.y-cip tree has been updated base version from 4.19.91 to 4.19.94.
And the linux-4.4.y-cip tree has been updated base version from 4.4.206 to 4.4.208,
and added support R8A7744 to rcar-du driver.

You can get this release via the git tree at:

  v4.19.94-cip18:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      b17c26ec7d8aef9ec4bc13e564fb4aea05e22486
    added commits:
      CIP: Bump version suffix to -cip18 after merge from stable

  v4.4.208-cip41:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      ba8dc2a25994d1d17872b641d4e6ff50ea9d9217
    added commits:
      CIP: Bump version suffix to -cip41 after merge from stable
      ARM: dts: r8a7744: Add DU support
      drm: rcar-du: Add R8A7744 support
      dt-bindings: display: renesas: du: Document the r8a7744 bindings

Best regards,
   Nobuhiro
