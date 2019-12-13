From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 13 Dec 2019 22:21:45 +0000
Subject: [cip-dev] [ANNOUNCE] Release v4.19.88-cip16 and v4.4.206-cip40
Message-ID: <OSAPR01MB323483390F138C52C363126492540@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

CIP kernel team has released Linux kernel v4.19.88-cip16 and v4.4.206-cip40.
The linux-4.19.y-cip tree has been updated base version from 4.19.85 to 4.19.88,
and The linux-4.4.y-cip tree has been updated base version from 4.4.199 to 4.4.206.
In addition, the following features have been backported and updated in the
linux-4.4.y-cip:
  - Support Renesas RZ/G1N SoC (r8a7744)
  - Support iWave G20D-Q7 board based on RZ/G1N
  - Update mmc driver for RZ/G1C's eMMC

You can get this release via the git tree at:

  v4.19.88-cip16:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit:
      baf9a222d9a3efbdac911457b01b6ffeb496aeb1

  v4.4.206-cip40:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit:
      0cddb349320426954582511b95e7d31873941aad

Best regards,
   Nobuhiro
